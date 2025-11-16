HA$PBExportHeader$uo_generate.sru
$PBExportComments$Userobject f$$HEX1$$fc00$$ENDHEX$$r die Generierung von Fl$$HEX1$$fc00$$ENDHEX$$gen und der kompletten Beladung
forward
global type uo_generate from nonvisualobject
end type
end forward

global type uo_generate from nonvisualobject
end type
global uo_generate uo_generate

type variables
Public:
integer 						iImportBobValues		= 0			//09.06.2010 HR: BOB-Werte einspielen
integer 						ii_Debug_Save 			= 1			//HR: 03.06.2009: Bei 1 werden alle SaveAs der Generierug nach c:\ geschrieben
string   						is_Debug_save_path 	= "C:\" 	// 03.11.2011 HR:
integer 						ii_delete_flights 		= 1			//HR: 28.05.2010: Bei 1 werden die Fl$$HEX1$$fc00$$ENDHEX$$ge vor dem Generieren gel$$HEX1$$f600$$ENDHEX$$scht
long 							ljobgroup 				= 0			// HR: 28.05.2010: Klammer f$$HEX1$$fc00$$ENDHEX$$r den Flugvergleich

string							sPostMessage
Boolean						bSendMessage
Boolean						bNonFlightBusiness
String							sNFBUnit
DataStore					dsjobs2generate
Boolean 						bDelete 					= True 	// Sollen die Daten gel$$HEX1$$f600$$ENDHEX$$scht werden ? Mit Generierung ja, mit Ver$$HEX1$$e400$$ENDHEX$$nderungsbrowser Nein

// ------------------------------------------------
// Instanzvariablen des Fluges
// ------------------------------------------------
Integer						iPaxType
Integer						iQPType 					//HR 06.07.2009: Welche QP soll genommen werden 
Integer						iDays_Offset
Integer						iJob_Type
Integer						iGenerierungsstatus	// bei Change-Verarbeitung ist dies der Flugstatus
Integer						iActiv
Integer						iPrio
integer						iBooking
integer						iAction					// holen/bringen
integer						iInboundOffset
integer						iMove
integer						iJobParameter
integer						iStatusUpdate7				= 0
integer						iRefund								// EG-Erstattung
integer						iAirlineType							// FSK = 0, FSI = 1
integer						iTimeAdjustment			= 0		// Anpassung Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeit erw$$HEX1$$fc00$$ENDHEX$$nscht
integer						iDontGeneratePaxCounts = 0
integer						iMLFlight						= 0
integer						ii_orders_transfer
integer 						ii_trainbusiness							// 29.07.2015 HR:

// 24.03.2009 HR: Auch in der Standardgenerierung sollen die UTC-Zeiten gespeichert wernden
Decimal						nDepartureFaktor
Decimal						nArrivalFaktor

String							sClient
String							sRampTime
String							sKitchenTime
String							sFirstLegTime
String							sFirstLegRampTime
String							sFirstLegKitchenTime 
String							sAirline				
String							sSuffix				
String							sDepartureTime		
String							sACType				
String							sGalleyVersion
String							sTLCFrom
String							sTLCTo
String							sCountryFrom
String							sCountryTo
String							sTrafficArea
String							sTrafficAreaShort
String							sUnit
String							sArrivalTime
String							sBlockTime
String							sHandlingShortText
String							sDefaultHandlingShortText
String							sHandlingLongText
String							sDefaultHandlingLongText
String							sRoutingShortText
String							sRoutingLongText
String							sOwner
String							sGenerierungsstatus
String							sLoadinglist
String							sHandlingObjectText
String							sLoadingUnit
String							sPackinglist
String							sNewspaper
String							sInboundAirline
String							sInboundSuffix
String							sInboundTime
String							sPackinglistText
String							sClass
String							sVersionString
String							sBoxFrom					= ""
String							sBoxTo						= ""
String							sRemarkText				= ""
String							sCustomer
String							sACConfiguration
String							sOriginalDeparture							// Abflugzeit aus Flugplan
String							sRegistration								// Nur bekannt, wenn betr. Prognose eingespielt wird
String							sInstanceName 			= "None"
String							sProfile 						= "CBASE_SERVICES.INI"
String							sFirstLegGalleyVersion			
String							sFirstLegOwner						
String							sFirstLegACType			
String							sOut

Long							lFirstLegAircraftKey	
Long							lFirstLegOwnerKey	

Datetime						dtStart
Datetime						dtEnd
Datetime						dtToday

Date							dGenerationDate				// Das Bezugsdatum der Generierung
Date							dGenerationDateUTC			// 01.10.2010 HR: Japantool Das Bezugsdatum der Generierung in UTC 
Date							dNewGenerationDate
Date							dReturnFlightDate				// Neu: Das R$$HEX1$$fc00$$ENDHEX$$ckflug-Datum

Boolean						bSchedule

Boolean						bSearchBackWards
Boolean						bCallByWebService 		= False  	// Aufruf $$HEX1$$fc00$$ENDHEX$$ber Web (True = kein Ausz$$HEX1$$e400$$ENDHEX$$hldidalog nutzen)
Boolean						bNoHandlingNecessary	= False	// f$$HEX1$$fc00$$ENDHEX$$r Monalisa-Auslandscaterer (True = keine Standardbeladung n$$HEX1$$f600$$ENDHEX$$tig)

Long							lJob_Key
long							lScheduleKey
long							lRoutingPlanKey
long							lRoutingPlanDetailKey
long							lRoutingPlanGroupKey
Long							lAirlineKey
Long							lAircraftKey
Long							lLegNumber
Long							lTlcFrom
Long							lTlcTo
Long							lCustomerKey
Long							lHandlingTypeKey
Long							lDefaultHandlingTypeKey
Long							lFlightNumber
Long							lResultKey
Long							lRoutingID
Long							lOwnerKey
long							lTimeStart
long							lTimeEnd
long							lRoutingPlanDetailKey_CP
long							lRoutingPlanGroupKey_CP
long							lJobActions
long							lJobNFBActions
long							lLoadinglistIndexKey
long							lHandlingId
long							lHandlingJoker
long							lTransActionKey
long							lFlightLegs
long							lQaqKey
long							lPackinglistIndexKey
long							lPackinglistDetailKey
long							lClassNumber
long							lCalcID					// Art der Berechnung (sys_calculate)
long							lCalcDetailKey			// z.B. welche Ratiostaffel
long							lQuantity
long							lHandlingKey			// Von welchem Handlingobjekt stammt die St$$HEX1$$fc00$$ENDHEX$$ckliste
long							lHandlingKeyNews		// Von welchem Handlingobjekt stammt die St$$HEX1$$fc00$$ENDHEX$$ckliste
long							lFirstLegTLC_From
long							lInboundFlightNumber
long							lFlightScheduleTime
datetime						dtFirstLegDeparture

long							lParent
long							lVersionGroupKey
long							lFlightDataQuery
long							lAccountKey				// Key f$$HEX1$$fc00$$ENDHEX$$r KVA
long							lDefaultAccountKey		// Key f$$HEX1$$fc00$$ENDHEX$$r KVA aus Tabelle cen_handling
long							lResultKeyGroup		// Result-Key vom ersten Leg
long							lLastResultKeyGroup	// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob lResultKeyGroup gewechselt hat
long							lBillingKey				// Belegnummer (21.01.05)
long							lFlightStatus				// Flugstatus: Scheduled,CNX,REQ
Long							lDefaultOwner		
integer						iLegIdentifier
integer						iBulkIdentifier
long							lJobNumber				// njob_key
long							lCurrentLegNumber	// 14.11.05: f$$HEX1$$fc00$$ENDHEX$$r of_create_sort
Integer						ii_nlcl_mirror_flag		// TBR 29.06.2009 Kennzeichen LCL-Flug
	
DataStore					dsGenerateSchedule
DataStore					dsReturnFlightSchedule
DataStore					dsGenerateRoutingPlan
DataStore					dsLocal_adjustments

//FRE 15.05.2008
DataStore					dsGenerateRoutingPlanHandling

DataStore					dsHandlingObjects
DataStore					dsHandlingObjects_CP
DataStore					dsHandlingObjects_LCL // TBR 29.06.2009
DataStore					dsHandlingDetail
DataStore					dsTrafficAreas		  
Datastore					dsHandlingNewspaper
Datastore					dsAirlineClasses
Datastore					dsAircaftVersion
Datastore					dsCentralForecast
Datastore					dsLocalForecast
Datastore					dsCrewQuantities
Datastore					dsHandlingQaq
Datastore					dsHandlingNewsAddon
Datastore					dsLocalTimes
Datastore					dsLocalTimesFlights
Datastore					dsGenerateFlight			// Flugplaninfo f$$HEX1$$fc00$$ENDHEX$$r konkret einen Flug
Datastore					dsFlightData
Datastore 					dsCITPFlightData  			//HR 06.07.2009: Welche QP soll genommen werden
Datastore 					dsResultkeys  				//HR 07.07.2009: Hier werden die alten Resaultkeys eines Tages zwischengespeichert
Datastore					dsGenerateNFB
Datastore					dsHandlingMealCover
Datastore					dsGenerateCenExternalSchedule
Datastore 					dsGenerateCenExternalSpml		// 05.02.2016 HR: CBASE-DE-CR-2015-052 Auch SPMLs sollen eingespielt werden
Datastore					dsCustomerCodes						// 19.01.05: Kundennummern
Datastore					dsHandlingInfo
Datastore					dsExplosion					// 06.06.05: Volle St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung
Datastore					dsFlightsForUnit			
DataStore					dsGenerateNonACType
Datastore					dsHandlingTypeCache
Datastore					dsCenOutCache
Datastore 					dsCITPFlightDataSPML 	// 02.09.2009 HR: F$$HEX1$$fc00$$ENDHEX$$r CITP-SPMLs zu $$HEX1$$fc00$$ENDHEX$$bertragen

long							lResultKeys1[]
long							lResultKeys2[]
long							lResultKeys3[]
long							lResultKeys4[]
long							lResultKeys5[]

uo_generate_datastore	dsDeleteMessages

uo_generate_datastore	dsCenOut
uo_generate_datastore	dsCenOutNotRegenerate 		// 23.06.2010 HR: DS mit Fl$$HEX1$$fc00$$ENDHEX$$gen, die nicht neu generiert werden sollen
uo_generate_datastore	dsCenOutHandling
uo_generate_datastore	dsCenOutHandlingNews
uo_generate_datastore	dsCenOutPax
uo_generate_datastore	dsCenOutQAQ
uo_generate_datastore	dsCenOutNewsExtra
uo_generate_datastore	dsGenerateProtocol
uo_generate_datastore	dsCenOutNFB
uo_generate_datastore	dsCenOutMeals
uo_generate_datastore	dsCenOutExtra					// f$$HEX1$$fc00$$ENDHEX$$r Extrabeladung
uo_generate_datastore	dsCenOutNewSPML			// f$$HEX1$$fc00$$ENDHEX$$r SPML
uo_generate_datastore	dsCenOutAllSPML				// 25.11.2009 HR: Alle SPMLs der Fl$$HEX1$$fc00$$ENDHEX$$ge
uo_generate_datastore	dsCenOutPriorSPML			// f$$HEX1$$fc00$$ENDHEX$$r SPML
uo_generate_datastore	dsCenOutPriorPax				// Mengenermittlung alt
uo_generate_datastore	dsCenOutNewSPMLDetail		 // Aufgel$$HEX1$$f600$$ENDHEX$$ste SPML
uo_generate_datastore	dsCenOutAllSPMLDetail		//25.11.2009 HR: Alle aufgel$$HEX1$$f600$$ENDHEX$$ste SPML aller Fl$$HEX1$$fc00$$ENDHEX$$ge
uo_generate_datastore	dsCurrentMeals					// Aktuelle Mahlzeiteneingaben
uo_generate_datastore	dsCurrentExtra					// Aktuelle Extrabeladung
uo_generate_datastore	dsOldMeals						// urspr. Mahlzeiteneingaben
uo_generate_datastore	dsOldExtra						// urspr. Extrabeladung
uo_generate_datastore	dsCenOutLCL					// f$$HEX1$$fc00$$ENDHEX$$r LCL-Handling

uo_generate_datastore   dsCenOutQP						//23.06.2009 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die QueryPerioden eines Fluges

uo_generate_datastore	dsBillingStatus					// $$HEX1$$dc00$$ENDHEX$$bertragung ins Abrechnungssystem

uo_generate_datastore	dsCenOutDispo					// Matdispo
uo_generate_datastore	dsCenOutDispoDetail			// Matdispo-Details
	
// ------------------------------------------------
// Berechnungsobjekt
// zun$$HEX1$$e400$$ENDHEX$$chst nur ein Berechnungsobjekt, sp$$HEX1$$e400$$ENDHEX$$ter evtl. f$$HEX1$$fc00$$ENDHEX$$r jede Formel instanziieren
// ------------------------------------------------
uo_calculation				uo_calc

// ------------------------------------------------
// Debug
// ------------------------------------------------
uo_generate_datastore	dsCenOutDebug
boolean						bDebugCenOut = false
integer						iOffset_RF
integer						idebug_level = 0
string							sTraceFile
string							sServiceLogFile
string							sServiceLogFileName

// ------------------------------------------------
// Datastores f$$HEX1$$fc00$$ENDHEX$$r Change der Beladung
// ------------------------------------------------
uo_generate_datastore	dsCenOutChange

// ------------------------------------------------
// Userobjekt f$$HEX1$$fc00$$ENDHEX$$r Mahlzeitenbeladung
// ------------------------------------------------
uo_meal_calculation		uo_generate_meals

Boolean						bCalculateConcDiff	= True			// muss abweichende Beladung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden

boolean						bCalculateNoMeals	= false	// reagiert darauf, ob User Mahlzeiten
																		// neu kalkulieren m$$HEX1$$f600$$ENDHEX$$chte
boolean						bCalculateNoExtra	= false		// reagiert darauf, ob User Extrabeladung
																		// neu kalkulieren m$$HEX1$$f600$$ENDHEX$$chte
boolean						bCalculateNoNews	= false		// reagiert darauf, ob User Lesematerial
																		// neu kalkulieren m$$HEX1$$f600$$ENDHEX$$chte
s_change_flight				strChange

// ------------------------------------------------
// Aus CBASE-Applikation heraus darf nur
// f$$HEX1$$fc00$$ENDHEX$$r eine Airline ein Job ausgef$$HEX1$$fc00$$ENDHEX$$hrt 
// werden.
// ------------------------------------------------
long							lAirlineParameter = 0

// ------------------------------------------------
// Userobjekt f$$HEX1$$fc00$$ENDHEX$$r Mahlzeitenbeladung
// ------------------------------------------------
boolean						bCalcMealsWithoutHandling	= false	// falls Mahlzeiten ohne 
																				// vorhandene Container-Handling-Objects
																				// kalkuliert werden
																				
// ------------------------------------------------
// Charter-Systematik
// ------------------------------------------------
boolean						bCharter	= false			// Abweichende Generierungslogik
																// f$$HEX1$$fc00$$ENDHEX$$r Charter-Airlines
datastore					dsCharterMemory			// Ist-Zustand des Fluges

// ------------------------------------------------
// DLV-Systematik Delivery
// Delivery soll Auftragsmenge auf null setzen
// ------------------------------------------------
integer						iDelivery = 0

// ------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Protokollierung
// ------------------------------------------------
integer						iInfo			= 1 
integer						iFehler		= 2
integer						iSystem		= 3
integer						iWarnung	= 4

Datastore					dsRatioCache	// Ratiolist-Caching

integer						iUseSequenceForCenOutMeals = 1	// Sequence verwenden

long							lVersionGroupKeyLeg1

boolean						bDifferentReturnDate = false		// 21.11.05 Wenn Leg ein abw. R$$HEX1$$fc00$$ENDHEX$$ckflugdatum hat

string 						sSupp_Units[]  // HR 02.09.2008 SupplierUnits f$$HEX1$$fc00$$ENDHEX$$r manuelle Generierung

// 28.04.2009
Long							lOPCode_Key
String							sOpcode

// 21.08.2009 HR: Amos-Abl$$HEX1$$f600$$ENDHEX$$sung
string 						sAdjustmentSet 		= 'none' // 16.06.2010 HR: CR IMView302
integer 						iImportSpmls 			= 0
datastore 					dsValidSPML

string 						cdeparture_vorleg //28.09.2009 HR: Falsche Zeiten

integer 						iChildrenFC      		//30.10.2009 HR: Anzahl CHD in den CITP-Zahlen
string  						sErrorPaxCounts  	// 17.11.2009 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Fehlermeldung keienCITP/AMOS-Zahlen
datetime 					dt_dep_vorleg 		//14.12.2009 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r den Abflug (Datum+Zeit) des Vorlegs
datetime 					dt_arr_vorleg 		//21.11.2011 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r den Ankunft (Datum+Zeit) des Vorlegs

// 05.05.2010 HR: Citypairwerte
long 							il_tlc_to 					= -1
long 							il_tlc_from 				= -1

// 28.10.2010 HR: Generierung von Einmalereignissen
integer 						ii_generate_type  		= 1 		//Generierungstype: 1: Standard, 2: Einmalereignisse, 3: Beide
integer 						ii_generate_jobtype 	= 1 		//Generierungstype aktueller Job (1 oder 2)
datetime 					idt_start, idt_ende

// 01.11.2010 HR:
boolean 						bCFSAirline								//Schalter: Generierung nach CFS-Logik
uo_generate_datastore	dsExtCatSched							//Datastore mit CFS-Flugplan
boolean						bCFSCheckOnly				= FALSE  //Es soll nur die CFS-Pr$$HEX1$$fc00$$ENDHEX$$fung durchgef$$HEX1$$fc00$$ENDHEX$$hrt werden (keine Generierung)
integer						ii_leg_number							//Leg-Nummer f$$HEX1$$fc00$$ENDHEX$$r SKY-Package-Ermittlung

// 18.11.2010 OH:
Boolean   					bUseOwner4TrafficArea 	= FALSE

string 						is_flugnummer

uo_generate_datastore 	dsCenOutPackets						// 04.04.2011 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die CFS-Packete eines Fluges
uo_generate_datastore 	dsCenOutLOS							// 04.04.2011 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die CFS-LOS-Infose eines Fluges
long							il_result_key_group					// 05.04.2011 HR: RESULT_KEY_GROUP Schl$$HEX1$$fc00$$ENDHEX$$ssel
boolean						ib_check_cfs_packetclass = True	// 17.05.2011 HR: Schalter, ob Klassen bei den Packets gepr$$HEX1$$fc00$$ENDHEX$$ft werden soll

string							is_AdditionalAccountCode			//08.09.2011 HR: Abrechnungscode2 soll mit eingespielt werden

uo_generate_datastore	dsCenOutPPM							// 19.09.2011 HR: Produktionsplanung
uo_generate_datastore	dsCenOutPPMStowages				// 19.09.2011 HR: Produktionsplanung
uo_generate_datastore	dsCenOutPPMMD						// 19.09.2011 HR: Produktionsplanung

boolean						ib_CFSWithoutFlightplan				// 30.09.2011 HR: Schalter f$$HEX1$$fc00$$ENDHEX$$r CFS-Generierung ohne Flugplan$$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung

string 						is_schedule_parameter				// 12.10.2011 HR: Parameter des Flugplans

long							il_maxlogsize = 5000000				// 13.10.2011 HR: Maximale Gr$$HEX2$$f600df00$$ENDHEX$$e der LOG-Datei

string							ls_old_ramp_time						// 15.02.2012 HR: Alte Rampenzeit merken
string							ls_old_kitchen_time					// 15.02.2012 HR: Alte K$$HEX1$$fc00$$ENDHEX$$chenzeit merken
Boolean						ib_generate_ppmdata					// 20.06.2012 HR: Schalter PPM-Date-Generierung

integer						ii_logFlightNumber = 0				// 21.06.2012 HR: Schalter ob Flugnummer bei der Generierung ausgegeben werden sollen
integer						ii_aut_mahlzeitenverteilung = 0	// 20.11.2012 HR: Schalter, ob am Ende einer Generierung die Mahlzeitenverteilung mit FlightCalc angesto$$HEX1$$df00$$ENDHEX$$en werden soll

datetime						idt_generate_date						// 24.10.2014 HR: Datum der Generierung
integer						ii_resuse_resultkeys					// 26.11.2014 HR: Schalter, ob die Reselutkeys bei der Generierung reseycelt werden sollen
integer						ii_new_cfs_handlinggen				// 27.11.2014 HR: Schalter, ob neue CFS-Package-Handling-DWS genutzt werden sollen

uo_generate_datastore	dsCenOutCheckPt						// 14.01.2015 HR: Flightchecker
integer						ii_create_checkpts  = 1				// 14.01.2015 HR: Flightchecker

string							is_CADDITIONAL						// 03.02.2016 HR: CBASE-BRU-CR-2015-007

boolean						ib_check_packets_handling	= false 
string							is_check_packets_handling

uo_conv_utc_loc			uoConvUtcLoc
end variables

forward prototypes
public function boolean of_get_handling_text (integer lkey)
public subroutine of_get_handling_joker ()
public function long of_get_routingplan_key ()
public function long of_get_history_key ()
public function boolean of_get_actype (integer lackey)
public function long of_check_flightnumber (long lroutingplanrow)
public function boolean of_citypair_flight (long lroutingplanrow, integer lschedulerow)
public function string of_get_account_code (long arg_key)
public function boolean of_write_cen_out_news_extra ()
public function boolean of_generate_non_flight_business (boolean bcheck)
public function boolean of_get_packinglist ()
public function boolean of_write_cen_out_qaq ()
public function integer of_resolve_spml ()
public function boolean of_generate_version (long lcenoutrow)
public function boolean of_update_history_change ()
public function boolean of_update_change ()
public function boolean of_write_job_history ()
public function boolean of_generate_schedule_delete_history ()
public function boolean of_delete_non_flight_business ()
public function long of_search_city_pair (long lroutingplanrow)
public function boolean of_write_protocol (integer i_importtype, integer i_import_modus, integer i_user_group, integer i_message_type, string s_message_key, string s_message_validation, string s_message)
public function boolean of_generate_explosion ()
public function long of_search_returnflight (integer iday_offset)
public function boolean of_find_handling (long lcenoutrow)
public function boolean of_generate_find_handling (long lcenoutrow)
public function boolean of_set_traffic_area ()
public function boolean of_generate_pax (long lcenoutrow, long lrow, long lclass_number)
public function boolean of_change_version (long lcenoutrow, long largversiongroupkey)
public function boolean of_job_executed ()
public function boolean of_generate_handling_si_qaq ()
public function boolean of_generate_handling_two (long lcenoutrow)
public function boolean of_write_cen_out_handling ()
public function boolean of_write_cen_out_handling_news ()
public function boolean of_generate_handling_newspaper ()
public function boolean of_generate_schedule_delete ()
public function s_change_flight of_single_flight (s_change_flight s_change)
public function boolean of_update ()
public function boolean of_update_history ()
public function boolean of_write_cen_out_single_flight (boolean bcitypair)
public function boolean of_delete_messages ()
public function boolean of_generate_handling_one (long lcenoutrow)
public function long of_search_flightnumber (long lroutingplanrow)
public function long of_create_sort (long lseekrow)
public function boolean of_set_cen_out_return_flight (long lschedulerow, long lroutingplanrow)
public function boolean of_write_cen_out (boolean bcitypair)
public function boolean of_set_cen_out (long lschedulerow, long lroutingplanrow)
public function boolean of_generate_handling_objects ()
public function long of_get_schedule_key ()
public function boolean of_generate_schedule (boolean bcheck)
public function boolean of_set_internal_times ()
public function integer of_change_internal_times ()
public function boolean of_change_pax ()
public function boolean of_change_spml ()
public function s_change_flight of_change_handling_objects (s_change_flight s_change)
public function boolean of_generate_flights ()
public function boolean of_generate_jobs (date dgenerate_date, string sclientparm, string sunitparm, long ljob_keyparm)
public function long of_get_account_key (long arg_customer_key, string arg_code)
public function string of_get_customer_code (long arg_customer_key, string arg_unit)
public function integer of_update_day7 ()
public function integer of_validation ()
public function integer of_generate_dispo_compare ()
public function integer of_build_arrays (datastore odw, string scolumn)
public function boolean of_check_actyp ()
public subroutine of_save_protocol ()
public function integer of_log_joblist (long lrow, datetime dtrun)
public function string of_checknull (string stext)
public function integer of_write_service_log (string text)
public function integer of_update_from_cache ()
public function string of_get_job_name (long lrow)
public function integer of_log (string smessage)
public function boolean of_delete_pps_data ()
public function boolean of_delete_pps_alarms ()
public function boolean of_delete_pps_changes ()
public function boolean of_generate_flights_by_fre ()
public function integer of_get_costtype ()
public subroutine of_reorg_legs ()
public function integer of_write_flights ()
public function string of_get_configuration (long arg_aircraftkey)
public function boolean of_get_opcode (long al_airline)
public function integer of_generate_qp ()
protected function boolean of_get_handling_lcl (long pl_nresult_key, long pl_umm_key, ref string ps_message)
public subroutine of_regen_keys ()
public function boolean of_recalc_pax (long arg_lrow)
public function boolean of_generate_spml_from_citp (long lcenoutrow)
public function long of_insert_new_spml ()
public function boolean of_compare_flights (long arg_nairlinekey, string arg_cunit, string arg_cclient, date arg_ddeparture, string arg_sdescription)
public function boolean of_generate_explosionjobs ()
public function boolean of_generate_flights_cfs ()
public function long of_search_cfs_flight (datastore arg_ds, long arg_row)
public function boolean of_use_owner_for_trafficarea (string as_client, long al_airline_key)
public function integer of_check_cfs_flights (long arg_lairline_key, date arg_ddeparture)
public function string of_get_airline_from_key (long arg_airline_key)
public function integer of_get_packet_handling (long arg_row, long arg_result_key, long arg_result_key_group)
public function integer of_write_cen_out_packets_los (long arg_row, long arg_result_key, long arg_result_key_group)
public function boolean of_get_cfspacket_check ()
public function integer of_generate_ppm (long arg_row)
public function boolean of_write_job_history_once (integer arg_status)
public function boolean of_generate_flightcalcjobs ()
public function integer of_generate_handling_paclos (datastore arg_dshandling, long arg_row, long arg_lcenoutrow, integer arg_sslzbl)
public function boolean of_generate_idocjobs ()
public function boolean of_generate_skytelexsendjobs ()
public function integer of_change_handling (long arg_result_key_group, long arg_handlingtypekey, string arg_shandlingshorttext, string arg_shandlinglongtext)
public function integer of_trace (string arg_function, integer level, string trace_text)
public function integer of_trace_flight (string arg_function, string trace_text)
public function integer of_get_co_packetkeys (long arg_result_key, string arg_cclass, ref long arg_packetkey[])
public function integer of_create_checkpts ()
public function boolean of_generate_handling_meals (integer arg_module_type, s_change_flight s_change, string arg_rowcount)
public function boolean of_generate_handling_meals_new (integer arg_module_type, s_change_flight s_change, string arg_rowcount)
public function integer of_checkpoint_push (long arg_nresult_key, integer arg_status)
public function boolean of_reduce_overload (s_change_flight s_change)
public function boolean of_get_handling_from_text (string arg_handling)
public function string of_get_job_paxtype (integer arg_type)
public function integer of_set_jobs_to_ignore (integer arg_kind)
public function boolean of_get_opcode_per_handling (long al_handling_type_key)
public function boolean of_generate_spml_from_extern (long lcenoutrow)
public subroutine of_check_packet_handling (long arg_result_key)
public function string of_create_cflightkey (date arg_date, string arg_airline, integer arg_flightnumber, string arg_suffix, string arg_tlc_from, string arg_tlc_to)
public function boolean of_checkpt_exists (long arg_airline_key, string arg_unit)
end prototypes

public function boolean of_get_handling_text (integer lkey);// --------------------------------------
// Informationen zum Handling
// --------------------------------------
   SELECT ctext,
			 cdescription
     INTO :sHandlingShortText,
			 :sHandlingLongText
     FROM cen_handling_types  
    WHERE nhandling_type_key = :lKey ;

	If sqlca.sqlcode <> 0 Then
		return False
	End if
	
	return True	

end function

public subroutine of_get_handling_joker ();// -----------------------------
// Joker f$$HEX1$$fc00$$ENDHEX$$r Handling ermitteln
// -----------------------------
	SELECT nhandling_type_key  
     INTO :lHandlingJoker  
     FROM cen_handling_types  
    WHERE ctext = '*' AND  
          nairline_key = :lAirlinekey ;
					
	If SQLCA.SQLCODE <> 0 Then
		lHandlingJoker = -1
	End if	

end subroutine

public function long of_get_routingplan_key ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_routingplan_key (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: long
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Streckenplan ermitteln
// und Charter-Eigenschaft setzen
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       	Version  	Autor          			Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  ??	   			1.0      	??   					Erstellung
//	01.10.2010 	1.1			Heiko Rothenbach 	Erweiterung um Schalter bCFSAirline
//
// --------------------------------------------------------------------------------------------------------------------

	Long lKey, lCharter, lCFS,lCFSPacket, lCFSWithoutFlightplan

	is_schedule_parameter = ""

	SELECT 	cen_routingplan_definition.nroutingplan_index, 
				cen_routingplan_definition.ncharter, 
				cen_routingplan_definition.ncfs,
				cen_routingplan_definition.NCFS_PACKETCLASS,
				cen_routingplan_definition.NCFS_WITHOUT_FLIGHTPLAN
	  INTO 	:lKey, 
	  			:lCharter, 
				:lCFS,
				:lCFSPacket,
				:lCFSWithoutFlightplan
	  FROM cen_routingplan_definition  
	 WHERE ( cen_routingplan_definition.dvalid_from <= :dGenerationDate ) AND  
			 ( cen_routingplan_definition.dvalid_to   >= :dGenerationDate ) AND  
			 ( cen_routingplan_definition.nairline_key = :lAirlineKey ) ;

	If sqlca.sqlcode = 0 then
		if lCharter = 1 then
			bCharter = true
			is_schedule_parameter = "Charter-Airline"
		else
			bCharter = false
		end if
		
		if lCFS = 1 then
			bCFSAirline = true
			is_schedule_parameter = "CFS-Airline"
		else
			bCFSAirline = false
		end if
				
		// --------------------------------------------------------------------------------------------------------------------
		// 18.05.2011 HR: Soll bei CFS-Fl$$HEX1$$fc00$$ENDHEX$$gen die Klasse bei der MLZ-Def-Suche 
		//                           ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
		// --------------------------------------------------------------------------------------------------------------------
		if lCFSPacket=1 then
			ib_check_cfs_packetclass = true
			is_schedule_parameter += " + CFS-Packets"

		else
			ib_check_cfs_packetclass = false
		end if 
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.09.2011 HR: CFS-Generierung ohne Flugplan
		// --------------------------------------------------------------------------------------------------------------------
		if lCFSWithoutFlightplan=1 then
			ib_CFSWithoutFlightplan = true
			is_schedule_parameter += " + without Flightplan"
		else
			ib_CFSWithoutFlightplan = false
		end if 
		
		return lKey
	Else
		return -1
	end if


end function

public function long of_get_history_key ();// ----------------------------------
// Key f$$HEX1$$fc00$$ENDHEX$$r History ermitteln
// ----------------------------------
	long lSequence
	lSequence = f_Sequence ("seq_cen_out_history",sqlca)
	If  lSequence = -1 Then
		 return -1
	End if	
	
	return lSequence
end function

public function boolean of_get_actype (integer lackey);// --------------------------------------
// Informationen zu einem Aircraft Type
// --------------------------------------
  SELECT cactype,   
         cgalleyversion,
			nairline_owner_key
    INTO :sACType,   
         :sGalleyVersion,
			:lOwnerKey
    FROM cen_aircraft  
   WHERE cen_aircraft.naircraft_key = :lACKey;


	If sqlca.sqlcode <> 0 Then
		return False
	End if
	
	sOwner = f_get_airline_name(lOwnerKey)
	return True	
end function

public function long of_check_flightnumber (long lroutingplanrow);// ------------------------------------------
// sucht eine Flugnummernbeladung im Flugplan
// ------------------------------------------
long 		lScheduleRow
string 	sSearch

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

If Len(Trim(sSuffix)) = 0 Then
	sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
				 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto)
Else
	sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
				 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto) + &
				 " and csuffix = '" + sSuffix + "'"
End if	

lScheduleRow = dsGenerateSchedule.find(sSearch,1,dsGenerateSchedule.Rowcount())

return lScheduleRow
end function

public function boolean of_citypair_flight (long lroutingplanrow, integer lschedulerow);// ------------------------------------------
// sucht eine Flugnummernbeladung im dsCenOut
// ------------------------------------------
long		lCenOutRow, lFound, ll_LegNr
string		sSearch, sFind
long		llFlightNumber
string		slSuffix
long		lFind
long		nTLCFrom
long		nTLCTo

llFlightNumber	= dsGenerateSchedule.Getitemnumber(lschedulerow,"nflight_number")
slSuffix         	= dsGenerateSchedule.Getitemstring(lschedulerow,"csuffix")   
//MB: Erweiterung 30.06.2011: Auch routing $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen, da es (in NAM) an einem Tag durchaus 2 Fl$$HEX1$$fc00$$ENDHEX$$ge mit selber Flugnummer 
//und selber catering unit, aber unterschiedlichem routing geben kann
nTLCFrom		= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_from")
nTLCTo			= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_to")
ll_LegNr			= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nleg_number") // 20.03.2015 HR:

If IsNull(slSuffix) Or Len(Trim(slSuffix)) = 0 Then slSuffix = ' '

// 20.03.2015 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer mit Suffix suchen, da sonst $$HEX1$$c400$$ENDHEX$$pfel mit Birnen verglichen wird
//If Len(Trim(slSuffix)) = 0 then
//   sSearch = "nflight_number = " + string(llFlightNumber) +" and ntlc_from = " +string(nTLCFrom)+" and ntlc_to = "+string(nTLCTo)
//Else
   sSearch = "nflight_number = " + string(llFlightNumber) + " and csuffix = '" + slSuffix + "'"+" and ntlc_from=" +string(nTLCFrom)+" and ntlc_to="+string(nTLCTo)
//End if

lCenOutRow = dsCenOut.find(sSearch,1,dsCenOut.Rowcount())

// ------------------------------------------
// Ok, der Flug war schon da.
// ------------------------------------------
If lCenOutRow > 0 Then
   lRoutingPlanDetailKey_CP      = dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nroutingdetail_key")
   lRoutingPlanGroupKey_CP      = dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nrouting_group_key")
   dsCenOut.SetItem(lCenOutRow,"NROUTINGDETAIL_KEY_CP",   lRoutingPlanDetailKey_CP)
   dsCenOut.SetItem(lCenOutRow,"NROUTING_GROUP_KEY_CP",   lRoutingPlanGroupKey_CP)
   return True
Else
   
   // --------------------------------------------------------------------------------------------------------------------
   // 20.03.2015 HR: Auch bei Citypair: Falls Flugnummer im dsCenOutNotRegenerate zu finden ist, dann 
   //                        auch auf Generierung verzichten
   // --------------------------------------------------------------------------------------------------------------------
   sFind = "nflight_number = " + string(llFlightNumber) 
   sFind += " and nleg_number = "+string(ll_LegNr)
   sFind += " and csuffix = '" + slSuffix + "'"
   sFind += " and ntlc_from = "+string(nTLCFrom)
   sFind += " and ntlc_to = "+string(nTLCTo)
   lFound = dsCenOutNotRegenerate.find(sFind, 1, dsCenOutNotRegenerate.RowCount())

   if lFound > 0 then   
      of_trace("of_citypair_flight", 1,"Flight found in NotToRegenerate Cache: " + string(lFlightNumber)+sSuffix+" Leg "+string(lLegNumber)+" " +dsCenOutNotRegenerate.getitemstring(lFound, "ctlc_from")+"-"+dsCenOutNotRegenerate.getitemstring(lFound, "ctlc_to"))
      return true
   end if
   
//
//   25.08.05 Suche, ob es den Flug f$$HEX1$$fc00$$ENDHEX$$r einen anderen Betrieb gibt
//            Dies w$$HEX1$$e400$$ENDHEX$$re ein Gegencheck, ob der Flug mit seiner konkreten Flugnummer
//            einem anderen Betrieb $$HEX1$$fc00$$ENDHEX$$ber die Beladedefinition zugewiesen w$$HEX1$$e400$$ENDHEX$$re.
//            Das Resultat aber ist, dass die komplette City-Pair-Request Logik,
//            n$$HEX1$$e400$$ENDHEX$$mlich den Flug auch dann f$$HEX1$$fc00$$ENDHEX$$r einen Betrieb anzulegen, obwohl ein
//            anderer Betrieb zust$$HEX1$$e400$$ENDHEX$$ndig ist, nicht mehr funktioniert.
//            Bsp.    CP       STR-HAM f$$HEX1$$fc00$$ENDHEX$$r STR als REQ
//                  LH 149    STR-HAM f$$HEX1$$fc00$$ENDHEX$$r HAM als N2
//                  Der Flug soll f$$HEX1$$fc00$$ENDHEX$$r beide Betriebe generiert werden, w$$HEX1$$fc00$$ENDHEX$$rde aber
//                  im Falle der folgenden Pr$$HEX1$$fc00$$ENDHEX$$fung nicht f$$HEX1$$fc00$$ENDHEX$$r STR generiert.
//
//   nTLCFrom       = dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_from")
//   nTLCTo         = dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_to")
//
//   sSearch =    "nflight_number = " + string(llFlightNumber) + " and csuffix = '" + slSuffix + &
//               "' and ntlc_from = " + string(nTLCFrom) + " and ntlc_to = " + string(nTLCto) + &
//               " and cunit <> '" + sUnit + "'"
//   lFind = dsGenerateRoutingPlan.Find(sSearch,1,dsGenerateRoutingPlan.RowCount())
//   if lFind > 0 then
//      return true
//   else
      return False
//   end if
End if   

end function

public function string of_get_account_code (long arg_key);//=================================================================================================
//
// of_get_account_code
//
// Holt den passenden AccountCode zum Text
//
//=================================================================================================
string	sText


select caccount
  into :sText
  from cen_airline_accounts
 where naccount_key = :arg_key;
 
if sqlca.sqlcode <> 0 then
	return ""
else
	return sText
end if

end function

public function boolean of_write_cen_out_news_extra ();// ------------------------------------------
// Daten nach cen_out_news_extra schreiben
// ------------------------------------------
	long 		lRow
	string 	sSearch
	Long  	lSequence
	string	sClassName

// ------------------------------------------
// Key ermitteln
// ------------------------------------------	
	lSequence = f_Sequence("seq_cen_out_news_extra", sqlca)
	If lSequence = -1 Then
		return False
	end if

// ------------------------------------------
// Klasse ermitteln
// ------------------------------------------	
	if lclassnumber > 0 then
	
		select cclass
		  into :sClassName
		  from cen_class_name
		 where nairline_key 	= :lairlinekey
			and nclass_number = :lclassnumber;
	
		If SQLCA.SQLCODE <> 0 Then
			return False
		End if
	else
		sClassName = ""
	end if

	
// ------------------------------------------
// Eintrag in Datastore einf$$HEX1$$fc00$$ENDHEX$$gen
// ------------------------------------------
	lRow = dsCenOutNewsExtra.insertrow(0)
	dsCenOutNewsExtra.SetItem(lRow,"ndetail_key",lSequence)
	dsCenOutNewsExtra.SetItem(lRow,"nresult_key",lResultKey)
	dsCenOutNewsExtra.SetItem(lRow,"nhandling_id",lHandlingId)
	dsCenOutNewsExtra.SetItem(lRow,"nclass_number",lClassNumber)
	dsCenOutNewsExtra.SetItem(lRow,"nnews_pl_index_key",lPackinglistIndexKey)
	dsCenOutNewsExtra.SetItem(lRow,"nnews_pl_detail_key",lPackinglistDetailKey)
	dsCenOutNewsExtra.SetItem(lRow,"ntransaction",lTransActionKey)
	dsCenOutNewsExtra.SetItem(lRow,"cnews_pl",sPackinglist)
	dsCenOutNewsExtra.SetItem(lRow,"cnewspaper",sNewspaper)
	dsCenOutNewsExtra.SetItem(lRow,"cclass",sClassName)
	dsCenOutNewsExtra.SetItem(lRow,"nquantity",lQuantity)
	dsCenOutNewsExtra.SetItem(lRow,"ncalc_id",lCalcID)
	dsCenOutNewsExtra.SetItem(lRow,"ncalc_detail_key",lCalcDetailKey)
	dsCenOutNewsExtra.SetItem(lRow,"nprio",iPrio)
	dsCenOutNewsExtra.SetItem(lRow,"naction",iaction)
	dsCenOutNewsExtra.SetItem(lRow,"dtimestamp",Datetime(today(),now()))
	dsCenOutNewsExtra.SetItem(lRow,"nstatus",0)
	dsCenOutNewsExtra.SetItem(lRow,"cdescription","")
	//
	// Inbound f$$HEX1$$fc00$$ENDHEX$$r die Zeitungsumladungen
	//
	dsCenOutNewsExtra.SetItem(lRow,"cairline_ib",sInboundAirline)
	dsCenOutNewsExtra.SetItem(lRow,"nflight_number_ib",lInboundFlightNumber)
	dsCenOutNewsExtra.SetItem(lRow,"csuffix_ib",sInboundSuffix)
	dsCenOutNewsExtra.SetItem(lRow,"noffset_ib",iInboundOffset)
	dsCenOutNewsExtra.SetItem(lRow,"carrival_ib",sInboundTime)

	if isnull(lAccountKey) or lAccountKey = 0 then
		lAccountKey = lDefaultAccountKey
	end if
	dsCenOutNewsExtra.SetItem(lRow,"naccount_key",lAccountKey)
	dsCenOutNewsExtra.SetItem(lRow,"caccount",of_get_account_code(lAccountKey))

	return True

end function

public function boolean of_generate_non_flight_business (boolean bcheck);// ---------------------------------------
// Generierung der Non Flight Beladung
// ---------------------------------------
	integer 		i
	integer		iVerkehrsTag
	string  		sFrequenz
	long 			lRow,lFound
	long  		lSequence
	long			lSQLCode
	long			lSQLRow 
	String		sSQLErrorText
	String		sTableName
	
	iVerkehrsTag 	= f_getfrequence(dGenerationDate)
	sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"
	
	lJobActions		= 0 
// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
	If bCheck Then
		If of_job_executed() Then
			return False
		End if	
	End if
// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r die History ermitteln
// ---------------------------------------------------------
	lTransActionKey = of_get_history_key()
	If lTransActionKey = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",&
								string(dGenerationDate,s_app.sDateformat),&
								"No valid loading history key available.")
		return False
	End if	
// -----------------------------------------------------------------
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber Trigger gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		
	DELETE FROM cen_out_nfb 
	      WHERE ddelivery = :dGenerationDate and 
					cclient	  		= :sclient and
					cunit		  		= :sunit;
	If sqlca.sqlcode <> 0 then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't delete non flight business, sqlcode " + string(sqlca.sqlcode) + ".")
		rollback using sqlca;
		return False
	end if
// -----------------------------------------
// Reset NFB
// -----------------------------------------
	dsCenOutNFB.Reset()
// -----------------------------------------
// Retrieve CEN_NFB join CEN_NFB_CUSTOMERS
// -----------------------------------------
	dsGenerateNFB.Retrieve(DateTime(dGenerationDate),sClient,sUnit)
	dsGenerateNFB.SetFilter(sFrequenz)
	dsGenerateNFB.Filter()
// -----------------------------------------
// Auftrag in dsCenOutNFB (CEN_OUT_NFB)
// Achtung: Sequence von CEN_OUT
// -----------------------------------------
	For i = 1 to dsGenerateNFB.Rowcount()
		 lRow = dsCenOutNFB.insertrow(0)
		 lSequence = f_Sequence ("seq_cen_out",sqlca)
		 If lSequence = -1 Then
			 of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",string(dGenerationDate,s_app.sDateformat),"Can't get a new sequence : seq_cen_out.")
			 return False
		 End if	
		 dsCenOutNFB.SetItem(lRow,"nresult_key",lSequence)
		 dsCenOutNFB.SetItem(lRow,"ntransaction",lTransActionKey)
		 dsCenOutNFB.SetItem(lRow,"nnon_flight_key",dsGenerateNFB.GetItemNumber(i,"nnon_flight_key"))
		 dsCenOutNFB.SetItem(lRow,"cname",dsGenerateNFB.GetItemString(i,"cname"))		  
		 dsCenOutNFB.SetItem(lRow,"ccompany",dsGenerateNFB.GetItemString(i,"ccompany"))		  		
		 dsCenOutNFB.SetItem(lRow,"cdivision",dsGenerateNFB.GetItemString(i,"cdivision"))		  		
		 dsCenOutNFB.SetItem(lRow,"clast_name",dsGenerateNFB.GetItemString(i,"clast_name"))		  		
		 dsCenOutNFB.SetItem(lRow,"cfirst_name",dsGenerateNFB.GetItemString(i,"cfirst_name"))		  				 
		 dsCenOutNFB.SetItem(lRow,"cstreet",dsGenerateNFB.GetItemString(i,"cstreet"))		  				 		 
 		 dsCenOutNFB.SetItem(lRow,"czip_code",dsGenerateNFB.GetItemString(i,"czip_code"))		  				 		 
 		 dsCenOutNFB.SetItem(lRow,"ccity",dsGenerateNFB.GetItemString(i,"ccity"))		  				 		 
 		 dsCenOutNFB.SetItem(lRow,"cphone",dsGenerateNFB.GetItemString(i,"cphone"))		  				 		 
		 dsCenOutNFB.SetItem(lRow,"cfax",dsGenerateNFB.GetItemString(i,"cfax"))
		 dsCenOutNFB.SetItem(lRow,"cemail",dsGenerateNFB.GetItemString(i,"cemail"))
	    dsCenOutNFB.SetItem(lRow,"ccostcenter",dsGenerateNFB.GetItemString(i,"ccostcenter"))
		 dsCenOutNFB.SetItem(lRow,"cclient",sClient)
		 dsCenOutNFB.SetItem(lRow,"cunit",sUnit)
		 dsCenOutNFB.SetItem(lRow,"corder_text",dsGenerateNFB.GetItemString(i,"corder_text"))
		 dsCenOutNFB.SetItem(lRow,"ddelivery",DateTime(dGenerationDate))
		 dsCenOutNFB.SetItem(lRow,"cdelivery_time",dsGenerateNFB.GetItemString(i,"cdelivery_time"))		 
		 dsCenOutNFB.SetItem(lRow,"cramp_time",dsGenerateNFB.GetItemString(i,"cdelivery_time"))		 
		 dsCenOutNFB.SetItem(lRow,"ckitchen_time",dsGenerateNFB.GetItemString(i,"cdelivery_time"))		 
		 dsCenOutNFB.SetItem(lRow,"cremark",dsGenerateNFB.GetItemString(i,"cremark"))		 
		 dsCenOutNFB.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
		 dsCenOutNFB.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
 		 dsCenOutNFB.SetItem(lRow,"NUSER_MODIFIED",0)
		 dsCenOutNFB.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
		 dsCenOutNFB.SetItem(lRow,"DGENERATION_DATE",datetime(dGenerationDate))
	Next
	
	lJobActions	= dsCenOutNFB.Rowcount()
// -----------------------------------------
// Default dsCenOutNFB speichern.
// -----------------------------------------
	If dsCenOutNFB.update() = -1 Then
		lSQLCode 		= dsCenOutNFB.lSQLErrorDBCode
		lSQLRow  		= dsCenOutNFB.lSQLErrorRow
		sSQLErrorText	= dsCenOutNFB.sSQLErrorText
		dsCenOutNFB.SaveAs("C:\dsCenOutNFB.xls",Excel5!,True)
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB", &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated non flight business data to database, sqlcode " + &
								string(lSQLCode))
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					  sunit + "~tCan't write generated non flight business data to database, " + &
					  "sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
// -----------------------------------------------
// Datastore dsCenOutNFB (History) speichern.
// -----------------------------------------------
	dsCenOutNFB.ResetUpdate()
	sTableName	= dsCenOutNFB.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutNFB.Rowcount()
		dsCenOutNFB.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutNFB.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutNFB.update() = -1 Then
		lSQLCode 		= dsCenOutNFB.lSQLErrorDBCode
		lSQLRow  		= dsCenOutNFB.lSQLErrorRow
		sSQLErrorText	= dsCenOutNFB.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB", &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated non flight business data history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutNFB.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated non flight business data history to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutNFB.Object.DataWindow.Table.UpdateTable = sTableName
	
// -------------------------------------
// Commit des Jobs
// -------------------------------------
	lTimeEnd = cpu()
	If not of_write_Job_history() Then
  		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
		rollback using sqlca;
		return False
	Else
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,"NFB",string(dGenerationDate,s_app.sDateformat),"Successfully generated in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		commit using sqlca;
		return True
	End if
	
	return True

end function

public function boolean of_get_packinglist ();// ---------------------------------
// Select con Packinglistinfos
// ---------------------------------
	SELECT cpackinglist
     INTO :sPackinglist 
 	  FROM cen_packinglist_index
	 WHERE npackinglist_index_key = :lPackinglistIndexKey;
  
   If sqlca.sqlcode <> 0 then
		sPackinglist 		 = "Not found"
	End if
	
	SELECT ctext,npackinglist_detail_key
	 INTO :sPackinglistText,:lPackinglistDetailKey  
	 FROM cen_packinglists
	WHERE npackinglist_index_key = :lPackinglistIndexKey AND
		 	dvalid_from <= :dGenerationDate AND
		 	dvalid_to   >= :dGenerationDate  ;
	
	If sqlca.sqlcode <> 0 then
		sPackinglistText 		 = "Not found"
		lPackinglistDetailKey = 0
		return False
	End if

	return True
end function

public function boolean of_write_cen_out_qaq ();// ------------------------------------------
// Daten in den Datastore dsCenOut schreiben
// ------------------------------------------
	long 		lRow
	string 	sSearch
	Long  	lSequence

	
	lRow = dsCenOutQaq.insertrow(0)
	dsCenOutQaq.SetItem(lRow,"NRESULT_KEY",lResultKey)
	dsCenOutQaq.SetItem(lRow,"NHANDLING_ID",lHandlingId)
	dsCenOutQaq.SetItem(lRow,"NHANDLING_QAQ_KEY",lQaqKey)
	dsCenOutQaq.SetItem(lRow,"NPRIO",iPrio)
	dsCenOutQaq.SetItem(lRow,"CTEXT",sHandlingObjectText)
	dsCenOutQaq.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
	dsCenOutQaq.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
	dsCenOutQaq.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
	dsCenOutQaq.SetItem(lRow,"NTRANSACTION",lTransActionKey)

	return True


end function

public function integer of_resolve_spml ();//========================================================================
//
// of_resolve_spml
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung der SPML
//
/*========================================================================

F$$HEX1$$fc00$$ENDHEX$$r die "$$HEX1$$dc00$$ENDHEX$$bergangsphase":
Lediglich alt-neu ermitteln

1. Ermitteln der SPML-Objekte => Mahlzeitenbeladung herausfinden
2. Eigenschaften (OnTop) der SPML heraussuchen
3. SPML-Details berechnen
4. Mahlzeitenberechnung durchf$$HEX1$$fc00$$ENDHEX$$hren

*///======================================================================
long		i
long		lClass_Number
long		lPriority
long		lSPML_Key
long		lquantity_old
long		lFind
long		lMasterkey
string	sFind

//
// Ermittlung Menge alt
//
//	dsCenOutNewSPML	= s_change.dsnewspml
//	dsCenOutPriorSPML	= s_change.dspriorspml
//

for i = 1 to dsCenOutNewSPML.RowCount()
	lClass_Number 	= dsCenOutNewSPML.GetItemNumber(i,"nclass_number")
	//lPriority		= dsCenOutNewSPML.GetItemNumber(i,"nprio") => and nprio = " + string(lPriority)
	lSPML_Key		= dsCenOutNewSPML.GetItemNumber(i,"nspml_key")
	lMasterkey		= dsCenOutNewSPML.GetItemNumber(i,"nmaster_key")
	
	sFind = 	"nclass_number = " + string(lClass_Number) + " and nmaster_key = " + string(lMasterkey) + &
				" and nspml_key = " + string(lSPML_Key)
	
	lFind = dsCenOutPriorSPML.Find(sFind,1,dsCenOutPriorSPML.RowCount())
	if lFind > 0 then
		lquantity_old = dsCenOutPriorSPML.GetItemNumber(lFind,"nquantity")
		dsCenOutNewSPML.SetItem(i,"nquantity_old",lquantity_old)
	end if
next

return 0

end function

public function boolean of_generate_version (long lcenoutrow);// -------------------------------------------------
// Version ermitteln
// -------------------------------------------------
long 					ll_nflight_number, i, a, lQueryID, lRow, lFind, lRows, lFindRow
string 				ls_cunit, ls_cairline, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_cdeparture_time, sOwnerForeign, sACTypeForeign, sDepartureTimeForeign
string	 				sClassNameArray[], sAircraftConfiguration, ls_CFLIGHT_KEY, sClassName, sClassText, sVersion, sVersionFormat
integer				li_PaxTypeLocal, iClassNumberArray[], iSeatVersion[], iForecast[], iClassNumber, iVersion
uo_get_aircraft 	uo_get_ac

If IsNull(sSuffix) Or Len(sSuffix) = 0 Then sSuffix = ' '

// -------------------------------------------------
// Es wird erstmal gel$$HEX1$$f600$$ENDHEX$$scht
// -------------------------------------------------
If bDelete = True Then
	delete from cen_out_pax where nresult_key = :lResultKey;
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	
End if

// --------------------------------------------------------------------------------------------------------------------
// 07.07.2015 HR: CBASE-DE-CR_2015-028 Neue  Funktion 'Lokale Anpassungen' (9)
// --------------------------------------------------------------------------------------------------------------------
li_PaxTypeLocal = iPaxType

if li_PaxTypeLocal = 9 then
	dsLocal_adjustments.setfilter("nfreq"+string(f_getfrequence(dGenerationDate))+"=1")

	ll_nflight_number		= dsCenOut.getitemnumber(lcenoutrow, "nflight_number")
	ls_cunit					= dsCenOut.getitemstring(lcenoutrow, "cunit")
	ls_cairline				= dsCenOut.getitemstring(lcenoutrow, "cairline")
	ls_ctl_from				= dsCenOut.getitemstring(lcenoutrow, "ctlc_from")
	ls_ctl_to					= dsCenOut.getitemstring(lcenoutrow, "ctlc_to")
	ls_crouteing				= dsCenOut.getitemstring(lcenoutrow, "crouting")
	ls_cdeparture_time	= dsCenOut.getitemstring(lcenoutrow, "cdeparture_time")

	dsLocal_adjustments.retrieve(lAirlineKey, ls_cunit, dGenerationDate, ls_cairline, ll_nflight_number, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_cdeparture_time,sAdjustmentSet)
	
	if dsLocal_adjustments.rowcount()=0 then
		//Kein Eintrag in Anpassungen, dann Zentrale Auslastung nehmen
		li_PaxTypeLocal = 1
	else
		li_PaxTypeLocal = dsLocal_adjustments.getitemnumber(1, "com_npax_type")
	end if
	of_trace("of_generate_version", 50,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) +" Paxtype set to "+of_get_job_paxtype(li_PaxTypeLocal))
end if

// ------------------------------------------------------------
// Retrieve auf die Defaultversion oder die aktuelle Version
// ------------------------------------------------------------
lVersionGroupKey = dsCenOut.GetItemNumber(lcenoutrow,"nversiongroupkey")
if isnull(lVersionGroupKey) then lVersionGroupKey = 0

If li_PaxTypeLocal = 3 then //aktuelle Passagiere
	// 02.12.2009 HR: Nach au$$HEX1$$df00$$ENDHEX$$en gezogen, so dass immer gelesen wird
	dsFlightData.Retrieve(lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom)
	
	if bDifferentReturnDate = false and lVersionGroupKey > 0 Then
		of_trace("of_generate_version", 50,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
						", bDifferentReturnDate = false and lVersionGroupKey > 0")
	//	dsFlightData.Retrieve(lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom)
	else
		//
		// 18.11.2005: Ab Leg 1 (und ggf. Folgetag) gehts auch ohne lVersionGroupKey!
		//
		of_trace("of_generate_version", 50,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
						", bDifferentReturnDate = " + string(bDifferentReturnDate) + " and lVersionGroupKey = " + string(lVersionGroupKey) )
						
		if lLegNumber > 1 then
			//dsFlightData.Retrieve(lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom)
			if dsFlightData.RowCount() > 0 then

				// Doch noch VersionGroupKey ermitteln!!!
				
				sOwnerForeign				= dsFlightData.GetItemString(1,"cequipment_owner")
				sACTypeForeign			= dsFlightData.GetItemString(1,"cequipment")
				sDepartureTimeForeign	= dsFlightData.GetItemString(1,"cdeparture_time")
				// -------------------------------------------------------
				// Nun die Sitzplatzversion
				// -------------------------------------------------------
				lQueryID 		= dsFlightData.GetItemNumber(1,"nquery")
				For i = 1 to dsFlightData.Rowcount()
					If dsFlightData.GetItemNumber(i,"nquery") <> lQueryID Then
						Exit
					End if	
					sClassNameArray[i] 	= dsFlightData.GetItemString(i,"cclass")
					iClassNumberArray[i] = dsFlightData.GetItemNumber(i,"nclass_number")
					iSeatVersion[i] 			= dsFlightData.GetItemNumber(i,"nversion")
					iForecast[i] 	 			= dsFlightData.GetItemNumber(i,"nforecast")
				Next
				// -------------------------------------------------------
				// Und nun die eigentliche Pr$$HEX1$$fc00$$ENDHEX$$fung Flugger$$HEX1$$e400$$ENDHEX$$t
				// -------------------------------------------------------
				uo_get_ac = create uo_get_aircraft
				uo_get_ac.sOwner 			= sOwnerForeign
				uo_get_ac.sActype 			= sACTypeForeign
				uo_get_ac.sClass[]			= sClassNameArray[]
				uo_get_ac.iVersion[]			= iSeatVersion[]
				uo_get_ac.iClassNumber[]	= iClassNumberArray[]
				uo_get_ac.lAirline_Key		= lAirlineKey

				If uo_get_ac.of_get_aircraft() <> 0 then
					// 01.10.2009 HR: FASTLANE ZD
					//   Wenn der AC-Type mit der Version nicht vorhanden ist aber die Version des aktuellen Fluges mit der Version 
					//   von AMOS $$HEX1$$fc00$$ENDHEX$$bereinstimmt, dann den AC-Type vom Flug $$HEX1$$fc00$$ENDHEX$$bernehmen und weiterarbeiten (ZD-Anforderung LSY-1483)
					//string sAircraftConfiguration 
			
					sAircraftConfiguration = of_get_configuration(lAircraftKey)
					if sAircraftConfiguration <> uo_get_ac.sVersionString then
							of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
												string(dGenerationDate,s_app.sDateformat),&
												"(Act. Pax) No valid aircraft type found.")							
					END IF
					// 01.07.2009 HR: Falls der AC-Type nicht ermittelt werden kann, dann m$$HEX1$$fc00$$ENDHEX$$ssen die Variablen trotzdem gesetzt werden, 
					//                        damit weiter unten nicht alte/falsche Werte zugespielt werden.
					if lVersionGroupKey > 0 then
						lAircraftKey					=  dsCenOut.GetItemNumber(lcenoutrow,"naircraft_key")
						sGalleyVersion				=  dsCenOut.GetItemstring(lcenoutrow,"cgalleyversion")
						lOwnerKey					=  dsCenOut.GetItemNumber(lcenoutrow,"nairline_owner_key	")
						sOwner						= dsCenOut.GetItemstring(lcenoutrow,"cairline_owner")
						sACType						= dsCenOut.GetItemstring(lcenoutrow,"cactype")
						sVersionString				= dsCenOut.GetItemstring(lcenoutrow,"cconfiguration")
					end if					
				else
					lAircraftKey					= uo_get_ac.lAircraft_key
					sGalleyVersion				= uo_get_ac.sGalleyVersion
					lOwnerKey					= uo_get_ac.lOwner_key
					sOwner						= uo_get_ac.sOwner
					sACType						= uo_get_ac.sActype
					// 16.11.2009 HR: Abflugszeit vom Flugplan nehmen, da es sonst zu Problemen mit UTC/LOCAL Umrechnung geben kann
					//sDepartureTime			= sDepartureTimeForeign
					sVersionString				= uo_get_ac.sVersionString
					lVersionGroupKey			= uo_get_ac.lGroup_key
					lFlightDataQuery			= dsFlightData.GetItemNumber(1,"nquery")
				End if
				destroy uo_get_ac
				if lVersionGroupKey > 0 then
 
					// cen-out muss angepasst werden!!!
					lFind = dsCenOut.Find("NRESULT_KEY = " + string(lResultKey),1,dsCenOut.RowCount())
					if lFind > 0 then
						dsCenOut.SetItem(lFind,"nversiongroupkey",lVersionGroupKey)
						dsCenOut.SetItem(lFind,"nquery",lFlightDataQuery)
						dsCenOut.SetItem(lFind,"NAIRCRAFT_KEY",lAircraftKey)
						dsCenOut.SetItem(lFind,"CGALLEYVERSION",sGalleyVersion)
						dsCenOut.SetItem(lFind,"NAIRLINE_OWNER_KEY",lOwnerKey)
						dsCenOut.SetItem(lFind,"CAIRLINE_OWNER",sOwner)
						dsCenOut.SetItem(lFind,"CACTYPE",sACType)
						dsCenOut.SetItem(lFind,"CCONFIGURATION",sVersionString)
					end if
				end if
			end if			
		end if
	end if
	lRows = dsFlightData.RowCount()
ElseIf li_PaxTypeLocal = 4 then //HR 18.11.2015 and lVersionGroupKey > 0 Then //betriebliche Prognose
	dsGenerateCenExternalSchedule.Retrieve(1,lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom,sUnit)
	
	// 05.02.2016 HR: Wenn SPMLs eingespielt werden sollen, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir diese auch lesen
	if iImportSpmls=1 then 
		dsGenerateCenExternalSpml.Retrieve(1,lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom,sUnit)
	else
		dsGenerateCenExternalSpml.reset()
	end if
	lRows = dsGenerateCenExternalSchedule.RowCount()

// 03.07.2009 HR: AMOS abl$$HEX1$$f600$$ENDHEX$$sung
// 13.10.2015 HR: Um Lokale Anpassung erweitert
//elseif li_PaxTypeLocal >=5 and li_PaxTypeLocal <=8 then //gebuchte und erwarte Passagiere mit und ohne PAD's
elseif li_PaxTypeLocal >=5 and li_PaxTypeLocal <=10 then //gebuchte und erwarte Passagiere mit und ohne PAD's
		if iQPType <> -1 then
			dsCITPFlightData.setfilter("cen_request_nairline_qp_key = "+string(iQPType))
		else
			dsCITPFlightData.setfilter("")
		end if
		
		// Flugschl$$HEX1$$fc00$$ENDHEX$$ssel - Aufbau  TagAlcFlgnrSufVonNach
		// 28.10.2013 HR: ddeparture durch dreturn_date ersetzt, da Fl$$HEX1$$fc00$$ENDHEX$$ge ex Deutschland anderes Ddeparture haben
		ls_CFLIGHT_KEY = String(dsCenOut.GetItemdatetime(lcenoutrow,"dreturn_date"), "YYMMDD") + dsCenOut.GetItemString(lcenoutrow,"cairline") + String(dsCenOut.GetItemNumber(lcenoutrow,"nflight_number"), "0000")
		
		If IsNULL(dsCenOut.GetItemString(lcenoutrow,"csuffix")) Then
			 ls_CFLIGHT_KEY += " "
		Else
			ls_CFLIGHT_KEY += dsCenOut.GetItemString(lcenoutrow,"csuffix")
		End If
		
		ls_CFLIGHT_KEY += dsCenOut.GetItemString(lcenoutrow,"ctlc_from") + dsCenOut.GetItemString(lcenoutrow,"ctlc_to")
			
		dsCITPFlightData.Retrieve(ls_CFLIGHT_KEY)
		
		// 02.09.2009 HR: Falls SPMLs eingelesen werden sollen, dann jetzt lesen 
		if iImportSpmls=1 then dsCITPFlightDataSPML.Retrieve(ls_CFLIGHT_KEY)
	
		if dsCITPFlightData.RowCount() > 0 then
            
			sOwnerForeign				= dsCITPFlightData.GetItemString(1,"cen_request_flight_cairline_owner")
			sACTypeForeign			= dsCITPFlightData.GetItemString(1,"cen_request_flight_cactype")
			sDepartureTimeForeign	= dsCITPFlightData.GetItemString(1,"cen_request_flight_cdeparture_time_local")
			// -------------------------------------------------------
			// Nun die Sitzplatzversion
			// -------------------------------------------------------
			lQueryID 		= dsCITPFlightData.GetItemNumber(1,"cen_request_nairline_qp_key")
			For i = 1 to dsCITPFlightData.Rowcount()
				If dsCITPFlightData.GetItemNumber(i,"cen_request_nairline_qp_key") <> lQueryID Then
					Exit
				End if	
				sClassNameArray[i] 	= dsCITPFlightData.GetItemString(i,"cen_request_pax_cclass")
				iClassNumberArray[i] = dsCITPFlightData.GetItemNumber(i,"cen_request_pax_nclass_number")
				iSeatVersion[i] 			= dsCITPFlightData.GetItemNumber(i,"cen_request_pax_nversion")
				iForecast[i] 	 			= dsCITPFlightData.GetItemNumber(i,"cen_request_pax_npax")    //Hier muss noch gepr$$HEX1$$fc00$$ENDHEX$$ft werden, was da $$HEX1$$fc00$$ENDHEX$$bergeben werden soll
			Next
			// -------------------------------------------------------
			// Und nun die eigentliche Pr$$HEX1$$fc00$$ENDHEX$$fung Flugger$$HEX1$$e400$$ENDHEX$$t
			// -------------------------------------------------------
			uo_get_ac = create uo_get_aircraft
			uo_get_ac.sOwner 			= sOwnerForeign
			uo_get_ac.sActype 			= sACTypeForeign
			uo_get_ac.sClass[]			= sClassNameArray[]
			uo_get_ac.iVersion[]			= iSeatVersion[]
			uo_get_ac.iClassNumber[]	= iClassNumberArray[]
			uo_get_ac.lAirline_Key		= lAirlineKey

			If uo_get_ac.of_get_aircraft() <> 0 then
				// 01.10.2009 HR: FASTLANE ZD
				//   Wenn der AC-Type mit der Version nicht vorhanden ist aber die Version des aktuellen Fluges mit der Version 
				//   von AMOS $$HEX1$$fc00$$ENDHEX$$bereinstimmt, dann den AC-Type vom Flug $$HEX1$$fc00$$ENDHEX$$bernehmen und weiterarbeiten (ZD-Anforderung LSY-1483)
				//string sAircraftConfiguration 
				sAircraftConfiguration = of_get_configuration(lAircraftKey)
					if sAircraftConfiguration <> uo_get_ac.sVersionString then
						of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
											string(dGenerationDate,s_app.sDateformat),&
											"(CITP) No valid aircraft type found.")		
						of_trace("of_generate_version", 10,"(CITP) No valid aircraft type found: Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
					                      " AC-Version: "+sAircraftConfiguration +" CITP-Version: "+uo_get_ac.sVersionString +" CITP-Actype: "+sOwnerForeign+"-"+sACTypeForeign+" iVersion: "+string(upperbound(iSeatVersion))+": "+uo_get_ac.sStatustext)
				else
					
					lFlightDataQuery			=  dsCITPFlightData.GetItemNumber(1,"cen_request_nairline_qp_key")
				end if
				// 21.10.2009 HR: 
				dsCenOut.SetItem(lcenoutrow,"nquery",lFlightDataQuery)

				// 01.07.2009 HR: Falls der AC-Type nicht ermittelt werden kann, dann m$$HEX1$$fc00$$ENDHEX$$ssen die Variablen trotzdem gesetzt werden, 
				//                        damit weiter unten nicht alte/falsche Werte zugespielt werden.
				if lVersionGroupKey > 0 then
					lAircraftKey					= dsCenOut.GetItemNumber(lcenoutrow,"naircraft_key")
					sGalleyVersion				= dsCenOut.GetItemstring(lcenoutrow,"cgalleyversion")
					lOwnerKey					= dsCenOut.GetItemNumber(lcenoutrow,"nairline_owner_key	")
					sOwner						= dsCenOut.GetItemstring(lcenoutrow,"cairline_owner")
					sACType						= dsCenOut.GetItemstring(lcenoutrow,"cactype")
					sVersionString				= dsCenOut.GetItemstring(lcenoutrow,"cconfiguration")
				end if					
			else
				lAircraftKey						= uo_get_ac.lAircraft_key
				sGalleyVersion					= uo_get_ac.sGalleyVersion
				lOwnerKey						= uo_get_ac.lOwner_key
				sOwner							= uo_get_ac.sOwner
				sACType							= uo_get_ac.sActype
				// 16.11.2009 HR: Abflugszeit vom Flugplan nehmen, da es sonst zu Problemen mit UTC/LOCAL Umrechnung geben kann
				//sDepartureTime				= sDepartureTimeForeign
				sVersionString					= uo_get_ac.sVersionString
				lVersionGroupKey				= uo_get_ac.lGroup_key
				lFlightDataQuery				=  dsCITPFlightData.GetItemNumber(1,"cen_request_nairline_qp_key")
			End if
			destroy uo_get_ac
			if lVersionGroupKey > 0 then
	
				// cen-out muss angepasst werden!!!
				lFind = dsCenOut.Find("NRESULT_KEY = " + string(lResultKey),1,dsCenOut.RowCount())
				if lFind > 0 then
					dsCenOut.SetItem(lFind,"nversiongroupkey",lVersionGroupKey)
					dsCenOut.SetItem(lFind,"nquery",lFlightDataQuery)
					dsCenOut.SetItem(lFind,"NAIRCRAFT_KEY",lAircraftKey)
					dsCenOut.SetItem(lFind,"CGALLEYVERSION",sGalleyVersion)
					dsCenOut.SetItem(lFind,"NAIRLINE_OWNER_KEY",lOwnerKey)
					dsCenOut.SetItem(lFind,"CAIRLINE_OWNER",sOwner)
					dsCenOut.SetItem(lFind,"CACTYPE",sACType)
					dsCenOut.SetItem(lFind,"CCONFIGURATION",sVersionString)
				end if
			end if
		end if			
Else	//zentrale & lokale Auslastung
	select distinct ngroup_key
	  into :lVersionGroupKey
	  from cen_aircraft_configurations
	 where naircraft_key = :lAircraftKey
		and ndefault 		= 1;
End if

// 21.11.05 Immer noch kein lVersionGroupKey
if lVersionGroupKey = 0 then
	select distinct ngroup_key
	  into :lVersionGroupKey
	  from cen_aircraft_configurations
	 where naircraft_key = :lAircraftKey
		and ndefault 		= 1;
	of_trace("of_generate_version", 50,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
					", last chance for lVersionGroupKey = " + string(lVersionGroupKey) )
	
	// 04.11.2009 HR: Wenn ich den Versiongruppenschl$$HEX1$$fc00$$ENDHEX$$ssel habe, muss ich ihn auch abspeichern, damit weiter hinten die Zahlen zugespielt werden
	if sqlca.sqlcode=0 then	dsCenOut.SetItem(lcenoutrow,"nversiongroupkey",lVersionGroupKey)
end if

lRow = dsAircaftVersion.Retrieve(lAircraftKey,lVersionGroupKey) 

// --------------------------------------------------
// Crew Mengen retrieven
// --------------------------------------------------
dsCrewQuantities.Retrieve(lAircraftKey) 

If lRow <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber), &
								string(dGenerationDate,s_app.sDateformat),&
								"This flight has no valid aircraft configuration." )
	of_trace("of_generate_version", 10,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
					", dsAircaftVersion.Retrieve(lAircraftKey,lVersionGroupKey) = 0 rows!!!" )
End if

// -------------------------------------------------
// Alle Klassen der Airline in dsCenOutPax eintragen
// ------------------------------------------------
sVersion = ""
sErrorPaxCounts=""
For i = 1 to dsAirlineClasses.Rowcount()
	 iClassNumber 	= dsAirlineClasses.Getitemnumber(i,"nclass_number")
	 sClassText		= dsAirlineClasses.Getitemstring(i,"cclass")
	 sClassName	= dsAirlineClasses.Getitemstring(i,"cclass_name")
	 iBooking			= dsAirlineClasses.Getitemnumber(i,"nbooking_class")
	 
	 lRow 			= dsCenOutPax.insertrow(0)
	 dsCenOutPax.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
	 dsCenOutPax.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
	 dsCenOutPax.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
	 dsCenOutPax.SetItem(lRow,"NTRANSACTION",lTransActionKey)
	 dsCenOutPax.SetItem(lRow,"nresult_key",lResultKey)
	 dsCenOutPax.SetItem(lRow,"nclass_number",iClassNumber)
	 dsCenOutPax.SetItem(lRow,"cclass",sClassText)
	 dsCenOutPax.SetItem(lRow,"cclass_name",sClassName)
	 dsCenOutPax.SetItem(lRow,"nbooking_class",iBooking)

	 // --------------------------------------------------------------------------------------------------------------------
	 // 10.02.2014 HR: CBASE-NAM-CR-13049 - Non Booking Classes Configuration for CFS-Airlines
	 // --------------------------------------------------------------------------------------------------------------------
	 dsCenOutPax.SetItem(lRow,"noverride_config", dsAirlineClasses.Getitemnumber(i,"noverride_config"))
	 
	 If iBooking = 1 Then
		 lFindRow = dsAircaftVersion.find("nclass_number = " + string(iClassNumber),&
													 1,dsAircaftVersion.Rowcount())
		 If lFindRow > 0 Then
			 iVersion = dsAircaftVersion.Getitemnumber(lFindRow,"nversion")
			 dsCenOutPax.SetItem(lRow,"nversion",iVersion)
		 Else
			iVersion = 999
			dsCenOutPax.SetItem(lRow,"nversion",999)
			of_trace("of_generate_version", 10,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) + &
							", nversion = 999 for iClassNumber=" + string(iClassNumber))
		 End if
		 // ----------------------------------
		 // Sitzplatz Version formatieren
		 // ----------------------------------
		 If len(string(iVersion)) = 1 Then
			sVersionFormat = "000"
		 ElseIf len(string(iVersion)) = 2 Then
			sVersionFormat = "000"
		 Else
			sVersionFormat = "000"
		 End if	
		 If sVersion = "" Then
			 sVersion = string(iVersion,sVersionFormat)
		 Else
			sVersion = sVersion + "-" + string(iVersion,sVersionFormat)
		End if	
	Else
		 dsCenOutPax.SetItem(lRow,"nversion",0)
		 
	End if
	dsCenOutPax.SetItem(lRow,"npax",0)
	dsCenOutPax.SetItem(lRow,"npax_spml",0)
	dsCenOutPax.SetItem(lRow,"npax_old",0)
	dsCenOutPax.SetItem(lRow,"npax_spml_old",0)
	
	of_generate_pax(lcenoutrow,lRow,iClassNumber)
Next

if sErrorPaxCounts >" " then
	// --------------------------------------------------------------------------------
	// 17.11.2009 HR: Fehlermeldung nur einmal Pro Flug und nicht pro Klasse
	// --------------------------------------------------------------------------------
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								sErrorPaxCounts )	
end if

dsCenOut.SetItem(lcenoutrow,"cconfiguration",sVersion)

// 21.08.2009 HR: Hier ist der Aufruf f$$HEX1$$fc00$$ENDHEX$$r die Funktion AMOS-Abl$$HEX1$$f600$$ENDHEX$$sung - Paxanpassungen
of_recalc_pax(lcenoutrow)	

Return True

end function

public function boolean of_update_history_change ();	long		lSQLCode
	long		lSQLRow 
	long 		i
	string	sTableName,sSQLErrorText
	
// --------------------------------------------
// Datastore dsCenOut (History) speichern.
// --------------------------------------------
	dsCenOut.ResetUpdate()
	sTableName	= dsCenOut.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOut.Rowcount()
		dsCenOut.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOut.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOut.update() = -1 Then
		return False
	End if
	dsCenOut.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutHandling (History)speichern.
// -----------------------------------------------
	dsCenOutHandling.ResetUpdate()
	sTableName	= dsCenOutHandling.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandling.Rowcount()
		dsCenOutHandling.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutHandling.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutHandling.update() = -1 Then
		return False
	End if
	dsCenOutHandling.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutQAQ (History)speichern.
// -----------------------------------------------
	dsCenOutQAQ.ResetUpdate()
	sTableName	= dsCenOutQAQ.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutQAQ.Rowcount()
		dsCenOutQAQ.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutQAQ.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutQAQ.update() = -1 Then
		return False
	End if
	dsCenOutQAQ.Object.DataWindow.Table.UpdateTable = sTableName
	
// -----------------------------------------------
// Datastore dsCenOutNews (History) speichern.
// -----------------------------------------------
	dsCenOutHandlingNews.ResetUpdate()
	sTableName	= dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandlingNews.Rowcount()
		dsCenOutHandlingNews.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutHandlingNews.update() = -1 Then
		return False
	End if
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName


// -----------------------------------------------
// Datastore dsCenOutNewsExtra (History) speichern.
// -----------------------------------------------
	dsCenOutNewsExtra.ResetUpdate()
	sTableName	= dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutNewsExtra.Rowcount()
		dsCenOutNewsExtra.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutNewsExtra.update() = -1 Then
		return False
	End if
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutPax (History) speichern.
// -----------------------------------------------
	dsCenOutPax.ResetUpdate()
	sTableName	= dsCenOutPax.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutPax.Rowcount()
		dsCenOutPax.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutPax.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutPax.update() = -1 Then
		return False
	End if
	dsCenOutPax.Object.DataWindow.Table.UpdateTable = sTableName	
	
	return True
end function

public function boolean of_update_change ();	long		lSQLCode
	long		lSQLRow 
	Long		i
	String	sSQLErrorText
// --------------------------------------
// Datastore dsCenOut speichern.
// --------------------------------------
	If dsCenOut.update() = -1 Then
		dsCenOut.SaveAs("C:\dsCenOut.xls",Excel5!,True)
		return False
	End if
// --------------------------------------
// Datastore dsCenOutHandling speichern.
// --------------------------------------
	If dsCenOutHandling.update() = -1 Then
		dsCenOutHandling.SaveAs("C:\dsCenOutHandling.xls",Excel5!,True)
		return False
	End if
// --------------------------------------
// Datastore dsCenOutQaq speichern.
// --------------------------------------
	If dsCenOutQaq.update() = -1 Then
		dsCenOutQaq.SaveAs("C:\dsCenOutQaq.xls",Excel5!,True)
		return False
	End if
// -----------------------------------------
// Datastore dsCenOutHandlingNews speichern.
// -----------------------------------------
	If dsCenOutHandlingNews.update() = -1 Then
		dsCenOutHandlingNews.SaveAs("C:\dsCenOutHandlingNews.xls",Excel5!,True)
		return False
	End if
// -----------------------------------------
// Datastore dsCenOutNewsExtra speichern.
// -----------------------------------------
	If dsCenOutNewsExtra.update() = -1 Then
		dsCenOutNewsExtra.SaveAs("C:\dsCenOutNewsExtra.xls",Excel5!,True)
		return False
	End if
// -----------------------------------------
// Default dsCenOutPax speichern.
// -----------------------------------------
	If dsCenOutPax.update() = -1 Then
		dsCenOutPax.SaveAs("C:\dsCenOutPax.xls",Excel5!,True)
		return False
	End if

	
	return True



end function

public function boolean of_write_job_history ();// ------------------------------------------------
// commit des Jobs mit Eintrag in loc_gen_history
// ------------------------------------------------
long   lCPU, lSequence
datastore lds

lCPU = ((lTimeEnd - lTimeStart) / 1000)

if  ii_generate_jobtype=3 then
	// --------------------------------------------------------------------------------------------------------------------
	// 01.06.2016 HR: Neuen Jobtype f$$HEX1$$fc00$$ENDHEX$$r die Flightcalcberechnung, die kein Historyeintrag ben$$HEX1$$f600$$ENDHEX$$tigt
	// --------------------------------------------------------------------------------------------------------------------
	
	return true
elseif ii_generate_jobtype=2 then
   	// 09.12.2011 HR: Protokoll in eigene Funktion ausgelagert
	return of_write_job_history_once(1)	

else
   lCPU = ((lTimeEnd - lTimeStart) / 1000)
   
   if lJobActions > 99999 then
      lJobActions = 99999
   end if

  // 24.10.2014 HR: DGEN_DATE eingef$$HEX1$$fc00$$ENDHEX$$gt
  INSERT INTO loc_job_history (njob_key,djob_date,djob_run_date,ncpu,nflights, DGEN_DATE) VALUES (:lJob_Key,:dGenerationDate,:dtstart,:lCPU,:lJobActions, :idt_generate_date);
   
   If sqlca.sqlcode <> 0 then
      
      f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
                  sunit + "~tCan't insert job history to database (" + &
                  string(lJob_Key) + "," + string(dGenerationDate) + "," + string(dtstart) + &
                  "," + string(lCPU) + "," + string(lJobActions) + ")~n" ,sTraceFile + "-" + this.sInstanceName + ".log")
                  
      f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
                  sunit + "~tCan't insert job history to database, " + &
                  "sqlcode : " + string(sqlca.sqldbcode) + "~n" + sqlca.sqlerrtext,sTraceFile + "-" + this.sInstanceName + ".log")
                  
      rollback using sqlca;
      return False
   else
      commit using sqlca;   
      return True
   end if
end if

end function

public function boolean of_generate_schedule_delete_history ();// -----------------------------------------------------
// l$$HEX1$$f600$$ENDHEX$$schen von Tagesflugplan History
// -----------------------------------------------------
long	lSQLCode
long	lSQLRow 
	
lJobActions		= 0

// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if	

SELECT count(*) into :lJobActions FROM cen_out_history
		WHERE ddeparture 	= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit	 and
				nairline_key 	= :lAirlineKey;
// -----------------------------------------------------------------
// Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r History z$$HEX1$$e400$$ENDHEX$$hlen.
// -----------------------------------------------------------------	
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule history count(*), sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if
// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
DELETE FROM cen_out_history 
		WHERE ddeparture 	= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit and
				nairline_key 	= :lAirlineKey;
				
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete_history", 1, "ERROR - Delete on cen_out_history failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule history, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if
// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
	commit using sqlca;
	return True
End if



end function

public function boolean of_delete_non_flight_business ();// -----------------------------------------------------
// l$$HEX1$$f600$$ENDHEX$$schen Non Flight Business
// -----------------------------------------------------
long	lSQLCode
long	lSQLRow 
lJobActions		= 0
// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if	
// -----------------------------------------------------------------
// Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r History z$$HEX1$$e400$$ENDHEX$$hlen.
// -----------------------------------------------------------------	
SELECT count(*) into :lJobActions FROM cen_out_nfb
		WHERE ddelivery 		<= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit;
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",string(dGenerationDate,s_app.sDateformat),"Can't delete non flight business count(*), sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if
// -----------------------------------------------------------------
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber Trigger gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		
DELETE FROM cen_out_nfb 
		WHERE ddelivery <= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit;
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",string(dGenerationDate,s_app.sDateformat),"Can't delete non flight business, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if
// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,"NFB",string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,"NFB",string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
	commit using sqlca;
	return True
End if



end function

public function long of_search_city_pair (long lroutingplanrow);// ------------------------------------------
// sucht eine City Pair im Flugplan
// ------------------------------------------
	long 		lScheduleRow 	= 1
	long		lSeekRow 		= 1
	long		nTLCFrom
	long		nTLCTo
	string 	sSearch
	
	nTLCFrom 		= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_from")
	nTLCTo			= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ntlc_to")
	sSearch 			= "ntlc_from = " + string(nTLCFrom) + " and ntlc_to = " + string(nTLCto)

	Do while lScheduleRow > 0
		lScheduleRow = dsGenerateSchedule.find(sSearch,lSeekRow,dsGenerateSchedule.Rowcount())
				
		If lScheduleRow > 0	Then
			// ----------------------------------------------------------
			// Es ist m$$HEX1$$f600$$ENDHEX$$glich das dieser Flug bereits mit der Flug-
			// nummer im Routingplan stand, deshalb suchen wir nochmal
			// im Datastore dsCenOut, sofern dieser vorhanden ist tragen
			// wir die entsprechenden City Pair Keys in dsCenOut ein.
			// Wir pf$$HEX1$$fc00$$ENDHEX$$fen ebenfalls ob das Flugger$$HEX1$$e400$$ENDHEX$$t generiert werden soll
			// ----------------------------------------------------------
			lFlightNumber 	= dsGenerateSchedule.Getitemnumber(lschedulerow,"nflight_number")
			sSuffix			= dsGenerateSchedule.Getitemstring(lschedulerow,"csuffix")	
			If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

			// 17.11.2011 HR: Abflugszeit vorleg reset
			dt_dep_vorleg 	= datetime(date("01.01.2000"),time("00:01"))
			dt_arr_vorleg 	= datetime(date("01.01.2000"),time("00:01")) //21.11.2011 HR

			If of_check_actyp() = True  Then
				If of_citypair_flight(lRoutingPlanRow,lScheduleRow) = False Then
					of_set_cen_out(lScheduleRow,lRoutingPlanRow)
					of_write_cen_out(True)	
				End if	
			End if	
		End if
		lSeekRow = lScheduleRow + 1
		If lSeekRow > dsGenerateSchedule.RowCount()	Then
			exit
		End If
	Loop	
	return 0
	
end function

public function boolean of_write_protocol (integer i_importtype, integer i_import_modus, integer i_user_group, integer i_message_type, string s_message_key, string s_message_validation, string s_message);// ---------------------------------------------------------------
// Protokollierung der Generierung-Aktivit$$HEX1$$e400$$ENDHEX$$t in die Datenbank
// ----------------------------------------------
// iImportType		10 = Tages Flugplan
// 					20 = 
// iImport_Modus	1-3	neu-update-delete
// iUser_Group		1-2	admin-anwender
// iMessage_Type	1-4	info, fehler,system,warnung
// ----------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// 10.01.2011 HR: Bei Job_Type -2 (Compare Flights) wird kein Datenbankeintrag
//                           vorgenommen
// --------------------------------------------------------------------------------------------------------------------
if iJob_Type <> -2  then
	Long  	lSequence
	Long		lRow
	lSequence = f_Sequence ("seq_loc_gen_protocol",sqlca)
	
	If  lSequence = -1 Then return False
	lRow = dsGenerateProtocol.insertrow(0)
	If lRow <= 0 Then return False
	
	dsGenerateProtocol.Setitem(lRow,"nprotokol_key",lSequence)
	dsGenerateProtocol.Setitem(lRow,"cclient",sClient)
	dsGenerateProtocol.Setitem(lRow,"cunit",sUnit)
	dsGenerateProtocol.Setitem(lRow,"dimport_date",datetime(dGenerationDate))
	dsGenerateProtocol.Setitem(lRow,"dimport_time",dtToday)
	dsGenerateProtocol.Setitem(lRow,"nairline_key",lAirlineKey)
	dsGenerateProtocol.Setitem(lRow,"cairline",sAirline)
	dsGenerateProtocol.Setitem(lRow,"nimport_type",i_ImportType)
	dsGenerateProtocol.Setitem(lRow,"nimport_modus",i_Import_Modus)
	dsGenerateProtocol.Setitem(lRow,"nuser_group",2)
	dsGenerateProtocol.Setitem(lRow,"nmessage_type",i_Message_Type)
	
	if isnull(s_Message_Key) or s_Message_Key="" then s_Message_Key = "NULL"
	dsGenerateProtocol.Setitem(lRow,"cmessage_key",s_Message_Key)
	
	if isnull(s_Message_Validation) or s_Message_Validation="" then s_Message_Validation = "NULL"
	dsGenerateProtocol.Setitem(lRow,"cmessage_validation",s_Message_Validation)
	
	if isnull(s_Message) or s_Message="" then s_Message = "NULL"
	dsGenerateProtocol.Setitem(lRow,"cmessage",s_Message)
	
	dsGenerateProtocol.Setitem(lRow,"nuser_id",0)
	dsGenerateProtocol.Setitem(lRow,"njob_key",lJob_Key)
end if

// 19.06.2012 HR: Auch die Flugnummer mit ausgeben
if isnull(s_message_key) then s_message_key = "NULL"
if isnull(s_Message) or s_Message="" then s_Message = "NULL"
of_trace("of_write_protocol", 1,"("+s_message_key+") "+s_Message)

return True
end function

public function boolean of_generate_explosion ();// ----------------------------------------------
// Erstellen der Packinglist Explosion
//
// Generierungsstatus steuert Insert oder Update
// ----------------------------------------------
	//uo_packinglist_explosion 	uo_matdispo
	
	uo_pl_explosion					uo_matdispo
	
	integer 		i
	long			lcnt

// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist?
// -----------------------------------------------------------------
	If of_job_executed() Then
		return False
	End if		

// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob denn $$HEX1$$fc00$$ENDHEX$$berhaupt was im Flugplan ist.
// -----------------------------------------------------------------
	if iJob_Type = 100 then
		select count(*)
		  into :lcnt
		  from cen_out_nfb
		 where cclient 	= :sClient
			and cunit		= :sUnit
			and ddelivery	= :dGenerationDate;
	elseif iJob_Type = 110 then
		// Globale Matdispo: cen_out_master -> cen_out_detail
		select count(*)
		  into :lcnt
		  from cen_out, cen_out_master
		 where cen_out.nresult_key = cen_out_master.nresult_key 
		 	and cclient 	= :sClient
			and ddeparture	= :dGenerationDate;
	else
		select count(*)
		  into :lcnt
		  from cen_out
		 where cclient 	= :sClient
			and cunit		= :sUnit
			and ddeparture	= :dGenerationDate;
	end if
		
	if lcnt = 0 then
		return false
	end if

// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r die History ermitteln
// ---------------------------------------------------------
	lTransActionKey = of_get_history_key()
	If lTransActionKey = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
								string(dGenerationDate,s_app.sDateformat),&
								"No valid loading history key available.")
		return False
	End if

// --------------------------------------------------------------------------------------------------------------------
// 14.10.2015 HR: Vor der Aufl$$HEX1$$f600$$ENDHEX$$sung setzen wir alle offene OE-Jobs auf IGNORE
// --------------------------------------------------------------------------------------------------------------------
of_set_jobs_to_ignore(1)

// ------------------------------------------------------------------
// Matdispo durchf$$HEX1$$fc00$$ENDHEX$$hren
// -------------------------------------------------------------------
	uo_matdispo = create uo_pl_explosion
	
//	uo_matdispo.sMatDispoTraceFile = sTraceFile + "-" + this.sInstanceName + "_Explosion.log"  // 23.09.2010 HR: LOG-Files Explosion pro Instanze erzeugen
	uo_matdispo.sMatDispoTraceFile 	= sTraceFile + "-" + this.sInstanceName + ".log" // 17.03.2015 HR: Gleiches Log wie die Generierung

	// Job-Key und Job-Type ist von hier aus zu setzen
	uo_matdispo.lJobKey 					= lJob_Key
	uo_matdispo.iJobType 				= iJob_Type

	Choose Case iGenerierungsstatus
		Case 4
			// 15.05.2013 HR: Wenn Fehler in der Explosion, dann raus hier
			if not uo_matdispo.of_start_for_airline(sClient,sUnit,dGenerationDate,lAirlineKey) then return false
			lJobActions = uo_matdispo.lNumberFlights
		Case 5
			// Update macht keinen Unterschied
			// 15.05.2013 HR: Wenn Fehler in der Explosion, dann raus hier
			if not uo_matdispo.of_start_for_airline(sClient,sUnit,dGenerationDate,lAirlineKey) then return false
			lJobActions = uo_matdispo.lNumberFlights
		Case 6
			// 15.05.2013 HR: Wenn Fehler in der Explosion, dann raus hier
			if not uo_matdispo.of_start_for_nfb(sClient,sUnit,dGenerationDate) then return false
			lJobActions = uo_matdispo.lNumberFlights
		Case 7
			// Zentrale Matdispo f$$HEX1$$fc00$$ENDHEX$$r einen Mandanten
			// 15.05.2013 HR: Wenn Fehler in der Explosion, dann raus hier
			if not uo_matdispo.of_start_packinglist_explosion(sClient,dGenerationDate) then return false
			lJobActions = uo_matdispo.lNumberFlights
	End Choose
	
	destroy uo_matdispo

	// 17.12.2014 HR: Sollen IDOC-Auftr$$HEX1$$e400$$ENDHEX$$ge erstellt werden?
	if ii_orders_transfer = 1  then
		// 12.01.2015 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen hier die Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r heute retrieven, damit wir die Auftr$$HEX1$$e400$$ENDHEX$$ge erstellen k$$HEX1$$f600$$ENDHEX$$nnen
      	dsCenOut.retrieve(this.lairlinekey, this.dGenerationDate, this.sClient, this.sUnit)
		if not  of_generate_idocjobs() then
			return false
		end if
	end if
	
// -------------------------------------
// Commit des Jobs
// -------------------------------------
	lTimeEnd = cpu()
	If not of_write_Job_history() Then
  		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
		rollback using sqlca;
		return False
	Else
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully generated in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		commit using sqlca;
		return True
	End if
	
	return True
	
end function

public function long of_search_returnflight (integer iday_offset);// ---------------------------------------------------
// sucht eine Weiter oder R$$HEX1$$fc00$$ENDHEX$$ckflug der nicht
// am selben Tag geht wie der Hinflug im Flugplan
// ---------------------------------------------------
	integer		iVerkehrsTag
	string  		sFrequenz
	long 			lFound
	string 		sSearch

	If IsNull(sSuffix) Or Len(sSuffix) = 0 Then sSuffix = ' '
	
	dReturnFlightDate = RelativeDate(dGenerationDate,iDay_Offset)
	iVerkehrsTag 		= f_getfrequence(dReturnFlightDate)
	sFrequenz 			= "nfreq" + string(iVerkehrsTag) + "=1"

if lFlightNumber= 2741 then
	lFlightNumber= 2741
end if

// -----------------------------------------
// Retrieve und Filter Flugplan
// -----------------------------------------
	dsReturnFlightSchedule.Retrieve(lScheduleKey,DateTime(dReturnFlightDate),&
											  lFlightnumber,&
											  sSuffix)
	dsReturnFlightSchedule.SetFilter(sFrequenz)
	dsReturnFlightSchedule.Filter()
// -----------------------------------------
// Und nun die Suche
// -----------------------------------------
	If Len(Trim(sSuffix)) = 0 Then
		sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
					 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto)+&
				 	" and (isnull(csuffix) or trim(csuffix)='')"		// 06.05.2011 HR: Suffix muss auf LEER gepr$$HEX1$$fc00$$ENDHEX$$ft werden
	Else
		sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
					 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto) + &
					 " and csuffix = '" + sSuffix + "'"
	End if	
	
	lFound = dsReturnFlightSchedule.find(sSearch,1,dsReturnFlightSchedule.Rowcount())

	Return lFound
	
end function

public function boolean of_find_handling (long lcenoutrow);// ---------------------------------------------------------------
// Handlings aus Legs die r$$HEX1$$fc00$$ENDHEX$$ckw$$HEX1$$e400$$ENDHEX$$rts abgesucht werden.
// Es werden alle Datens$$HEX1$$e400$$ENDHEX$$tze ber$$HEX1$$fc00$$ENDHEX$$cksichtigt die den selben 
// NROUTING_GROUP_KEY haben.
// ---------------------------------------------------------------
	Long			i
	integer		iVerkehrsTag
	string  		sFrequenz
	boolean		bFound = False
	
	iVerkehrsTag 	= f_getfrequence(dNewGenerationDate)
	sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"
	
	
	For i = lCenOutRow to 1 Step -1
		 If dsCenOut.GetItemNumber(i,"NROUTING_GROUP_KEY") <> lRoutingPlanGroupKey Then
			 Exit
		 End if	 
		 lRoutingPlanDetailKey		= dsCenOut.GetItemNumber(i,"NROUTINGDETAIL_KEY")
		// ---------------------------------------------------------------
		// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r Flugnummern bezogene Beladung
		// ---------------------------------------------------------------
		 dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate, sUnit)
		 dsHandlingObjects.SetFilter(sFrequenz)
		 dsHandlingObjects.Filter()
		 If of_generate_find_handling(i) Then
			 bFound = True
		 End if
	Next
	
	
	
	return bFound
	
	

end function

public function boolean of_generate_find_handling (long lcenoutrow);// ---------------------------------------------------------------
// Loadinglist aus vornagehenden Legs ermitteln
// ---------------------------------------------------------------
	long 			lRow,i,j
	long			lHandling_Key
	datastore 	dsHandling
	string		sFilter
	
// ---------------------------------------------------------------
// Nur Flugnummer, City Pair ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
	dsHandling = dsHandlingObjects

	lRow = dsHandling.find("nhandling_id = 1",1,dsHandling.Rowcount())

	If lRow <= 0 Then
		return False
	End if	
		 
// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den 
// nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
	For i = 1 to dsHandling.Rowcount()
		lHandlingId				= dsHandling.Getitemnumber(i,"nhandling_id")
		sHandlingObjectText 	= dsHandling.Getitemstring(i,"ctext")
		// --------------------------------------------
		// Loadinglist 
		// --------------------------------------------
		If lHandlingId = 1  Then
			lHandling_Key = dsHandling.Getitemnumber(i,"nhandling_key")
			// ----------------------------------------------------
			// Nun der retrieve auf das Handling Objekt
			// ----------------------------------------------------
			dsHandlingDetail.Retrieve(lHandling_Key,dGenerationDate,lAircraftKey,sDepartureTime)
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			// -------------------------------------------
			sFilter = "nhandling_type_key = " + string(lHandlingTypeKey)
			dsHandlingDetail.SetFilter(sFilter)
		 	dsHandlingDetail.Filter()
			If dsHandlingDetail.Rowcount() <= 0 Then 
				return False
			End if
		End if
		
		If lHandlingId = 1 Then
			For j = 1 to dsHandlingDetail.Rowcount()
				sLoadinglist 			= dsHandlingDetail.Getitemstring(j,"cloadinglist")
				iPrio						= dsHandlingDetail.Getitemnumber(j,"nprio")
				is_AdditionalAccountCode 	= dsHandlingDetail.Getitemstring(j,"cadditional_account") // 08.09.2011 HR:

				If not of_write_cen_out_handling() Then
					return False
				End if	
			Next	
		End if	
	Next	

	Return True
end function

public function boolean of_set_traffic_area ();/*
* Objekt : uo_generate
* Methode: of_set_traffic_area (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.11.2010
*
* Argument(e):
* none
*
* Beschreibung:      Ermittlung Verehrsgebiet zu City Pair
*
* Aenderungshistorie:
* Version       Wer         Wann         Was und warum
* 1.0          <unknown>
* 1.1          O.Hoefer   18.11.2010      Erweiterung: bei "Use owner traffic area" wird zum AC Owner statt Customer gesucht
*
*
* Return: boolean
*
*/

// ----------------------------------------
// Trafic Area ermitteln
// ----------------------------------------
   long          lRow
   string      sFind

   Long         ll_Rows
   Long         ll_Owner_Key
   DataStore   lds_TrafficAreas

   If bUseowner4trafficarea = FALSE Then

      sFind  = "ntlc_from = " + string(lTlcfrom) + " and ntlc_to = " + string(lTlcto)
   
      lRow = dsTrafficAreas.Find(sFind,1,dsTrafficAreas.RowCount())
         
      if lRow > 0 then
         sTrafficArea            = dsTrafficAreas.Getitemstring(lRow,"ctext")
         sTrafficAreaShort         = dsTrafficAreas.Getitemstring(lRow,"cshort")
         iRefund                  = dsTrafficAreas.GetitemNumber(lRow,"nrefund")
      Else
		// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
		//sTrafficArea            = "Nil"
         //sTrafficAreaShort         = "Nil"
         sTrafficArea            		= " "
         sTrafficAreaShort       	= " "
         iRefund                  = 0
         //
         // Meldung: Falls kein Verkehrsgebiet gepflegt, dann auch kein Refund
         //
         return false
      end if
      
      return True
      
   Else
      // ----------------------------------------------------------      
      // Ermittle Traffic Area mit Owner Key
      // ----------------------------------------------------------   
      ll_Owner_Key = lOwnerkey
      If IsNULL(ll_Owner_Key) OR ll_Owner_Key < 1 Then
         ll_Owner_Key = ldefaultowner
      End if
      If IsNULL(ll_Owner_Key) OR ll_Owner_Key < 1 Then
         // Autsch!
		// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
		//sTrafficArea            = "Nil"
         //sTrafficAreaShort         = "Nil"
         sTrafficArea            		= " "
         sTrafficAreaShort       	= " "
         iRefund                  = 0
         return FALSE
      End If
      
      lds_TrafficAreas                        = Create DataStore
      lds_TrafficAreas.DataObject             = "dw_generate_traffic_areas"
      lds_TrafficAreas.SetTransObject(SQLCA)
      ll_Rows  = lds_TrafficAreas.Retrieve(ll_Owner_Key, dGenerationdate)
      If ll_Rows > 0 Then
         
         sFind  = "ntlc_from = " + string(lTlcfrom) + " and ntlc_to = " + string(lTlcto)
         lRow = lds_TrafficAreas.Find(sFind,1,lds_TrafficAreas.RowCount())
         
         if lRow > 0 then
            sTrafficArea            = lds_TrafficAreas.Getitemstring(lRow,"ctext")
            sTrafficAreaShort         = lds_TrafficAreas.Getitemstring(lRow,"cshort")
            iRefund                  = lds_TrafficAreas.GetitemNumber(lRow,"nrefund")
            DESTROY lds_TrafficAreas
            Return TRUE
         ELSE
			// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
			//sTrafficArea            = "Nil"
			//sTrafficAreaShort         = "Nil"
			sTrafficArea            		= " "
			sTrafficAreaShort       	= " "
            	iRefund                  = 0
            	DESTROY lds_TrafficAreas
            	return FALSE
         End If
      ELSE
		// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
		//sTrafficArea            = "Nil"
         //sTrafficAreaShort         = "Nil"
         sTrafficArea            		= " "
         sTrafficAreaShort       	= " "
         iRefund                  = 0
         DESTROY lds_TrafficAreas
         return FALSE
      End If
      
      
   End If

end function

public function boolean of_generate_pax (long lcenoutrow, long lrow, long lclass_number);datastore 	dsForecast
string			sFind
long			lFoundRow
integer		iVerkehrsTag
string  		sField
string			ls_Class
decimal		dFactor
integer		iVersion
integer		iPax
string			sLocalorCentral
long			lQueryID,i
integer		iSearchClass
integer		iTest
integer		iLocalPaxType
long			lcnt
Long 			lFoundCrew

iVerkehrsTag 	= f_getfrequence(dNewGenerationDate)
sField 			= "nload_factor_freq" + string(iVerkehrsTag)

// 20.05.05 REQ-Fl$$HEX1$$fc00$$ENDHEX$$ge
// 28.03.07 erweitert um andere Abfertigungsarten,  Schalter iDontGeneratePaxCounts wird in  of_generate_handling_objects() gesetzt
// 03.07.09 HR: An den Anfang der Funktion gesetzt, da bei REQ-Fl$$HEX1$$fc00$$ENDHEX$$gen immer auf 0 gesetzt wird
if iDontGeneratePaxCounts = 1 then
	dsCenOutPax.Setitem(lRow,"npax",0)
	return True
end if

// Umstellung auf iLocalPaxType, da Kombination aus Betr.Prognose und Forecast m$$HEX1$$f600$$ENDHEX$$glich sein soll
iLocalPaxType = iPaxType

if iLocalPaxType = 9 then
	dsLocal_adjustments.setfilter("nfreq"+string(f_getfrequence(dGenerationDate))+"=1 and nclass_number = "+string(lclass_number))
	dsLocal_adjustments.filter()
	
	if dsLocal_adjustments.rowcount()=0 then
		//Kein Eintrag in Anpassungen, dann Zentrale Auslastung nehmen
		iLocalPaxType = 1
	else
		iLocalPaxType = dsLocal_adjustments.getitemnumber(1, "com_npax_type")
	end if
	of_trace("of_generate_pax", 50,"Airline-Key=" + string(lAirlineKey) + " Flightnumber=" + string(lFlightnumber) +" Paxtype for Class "+string(lclass_number)+" set to "+of_get_job_paxtype(iLocalPaxType))
end if

// -------------------------------------------------
// Pax Airline auf 0 setzen
// -------------------------------------------------
dsCenOutPax.Setitem(lrow,"npax_airline",0)

// -------------------------------------------------
// Welche Art von Passagierzahlen ?
// -------------------------------------------------
If iLocalPaxType = 1 Then
	dsForecast 			= dsCentralForecast
	sLocalorCentral 	= "central"
	
Elseif iLocalPaxType = 2 Then
	dsForecast 			= dsLocalForecast
	sLocalorCentral 	= "local"
	
Elseif iLocalPaxType = 3 and dsCenOut.GetItemNumber(lcenoutrow,"nversiongroupkey") > 0 Then
	
	if dsFlightData.RowCount() > 0 then
		// -------------------------------------------------
		// Aktuelle Passagierzahlen eintragen
		// -------------------------------------------------
		lQueryID 			= dsFlightData.GetItemNumber(1,"nquery")
		iSearchClass 	= dsCenOutPax.GetItemNumber(lRow,"nclass_number")
		lFoundRow	 	= dsFlightData.Find("nclass_number = " + string(iSearchClass) + &
							  			" and nquery = " + string(lQueryID),1,dsFlightData.Rowcount())
		
		If lFoundRow > 0 Then	
			iPax = dsFlightData.GetItemNumber(lFoundRow,"nforecast")
			dsCenOutPax.Setitem(lrow,"npax",iPax)

			// 13.06.08, KF Feld npax_forecast existiert nur in den angegebenen datawindows....
			if dsCenOutPax.dataobject = "dw_cen_out_pax_change" or  dsCenOutPax.dataobject = "dw_cen_out_pax" then
				dsCenOutPax.Setitem(lrow,"npax_forecast",iPax)
			end if 
		End if
		// 06.07.2009 HR: Nur wenn aktuelle Passagierzahlen vorhanden, dann zur$$HEX1$$fc00$$ENDHEX$$ck, ansonsten lokale Prognose verwenden
		return True 
	end if
	
	iLocalPaxType = 2
	sErrorPaxCounts = "Can't find a actual Pax-Counts, use Local Forcast"
	
Elseif iLocalPaxType = 4 and dsCenOut.GetItemNumber(lcenoutrow,"nversiongroupkey") > 0 Then
	// -------------------------------------------------
	// Prognose eintragen
	// -------------------------------------------------
	lQueryID 			= 1
	iSearchClass 	= dsCenOutPax.GetItemNumber(lRow,"nclass_number")
	lFoundRow	 	= dsGenerateCenExternalSchedule.Find("nclass_number = " + string(iSearchClass) &
						  							,1,dsGenerateCenExternalSchedule.Rowcount())
	If lFoundRow > 0 Then	
		iPax = dsGenerateCenExternalSchedule.GetItemNumber(lFoundRow,"nforecast")
		dsCenOutPax.Setitem(lrow,"npax",iPax)

		// 05.02.2016 HR: Wenn SPML $$HEX1$$fc00$$ENDHEX$$bertragen werden soll, dann Menge schon mal eintragen
		if iImportSpmls = 1 then
			ls_Class		= dsCenOutPax.GetItemString(lRow,"cclass")
			
			lFoundRow = dsGenerateCenExternalSpml.find("cclass  = '" +ls_Class +"'", 1, dsGenerateCenExternalSpml.Rowcount())
			
			if lFoundRow > 0 then
				iPax = dsGenerateCenExternalSpml.GetItemNumber(lFoundRow,"comp_sumquantity")
			else
				iPax = 0	
			end if
			dsCenOutPax.Setitem(lrow,"npax_spml",iPax)
	
		end if

		// 03.03.06 Prognose gefunden, zur$$HEX1$$fc00$$ENDHEX$$ck
		return true
	End if

	iLocalPaxType = 2 // 03.03.06 Keine Prognose gefunden, dann lokale Auslastung verwenden

Elseif iLocalPaxType = 4 and dsCenOut.GetItemNumber(lcenoutrow,"nversiongroupkey") = 0 Then
	iLocalPaxType = 2  // 03.03.06 Keine Prognose gefunden, dann lokale Auslastung verwenden

// 03.07.2009 HR: Amos Abl$$HEX1$$f600$$ENDHEX$$sung
Elseif (iLocalPaxType >= 5 and iLocalPaxType <=8) or iLocalPaxType = 10 then
	if dsCITPFlightData.RowCount() > 0 then
		// -------------------------------------------------
		// CITP-Zahlen eintragen
		// -------------------------------------------------
		lQueryID 		= dsCITPFlightData.GetItemNumber(1,"cen_request_nairline_qp_key")
		
		// --------------------------------------------------------------------------------------------------------------------
		// 26.02.2014 HR: Wir gehen hier auf Klasse, da die Nummer ggf. falsch sein kann
		// --------------------------------------------------------------------------------------------------------------------
		ls_Class		= dsCenOutPax.GetItemString(lRow,"cclass")
		
		lFoundRow	= dsCITPFlightData.Find("cen_request_pax_cclass = '" + ls_Class + "'"+ &
		                             " and cen_request_nairline_qp_key = "+string(lQueryID),1,dsCITPFlightData.Rowcount())

		If lFoundRow > 0 Then	
			choose case iLocalPaxType
				case 5  //Booked Pax
						iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npax")
				
				case 6  //Booked Pax + PAD
						iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npax")
						iPax += dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npad")
				
				case 7  //Expected Pax 
						iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_nexpected")
				
				case 8  //Expected Pax + PAD
						iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_nexpected")
						iPax += dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npad")
				
				case 10 // (Booked + Expected Pax) /2
						iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npax")
						iPax += dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_nexpected")
						iPax = int(iPax / 2)
			end choose
			
			dsCenOutPax.Setitem(lrow,"npax",iPax)

			// 13.06.08, KF Feld npax_forecast existiert nur in den angegebenen datawindows....
			if dsCenOutPax.dataobject = "dw_cen_out_pax_change" or  dsCenOutPax.dataobject = "dw_cen_out_pax" then
				dsCenOutPax.Setitem(lrow,"npax_forecast",iPax)
			end if 
			
			// 02.09.2009 HR: Wenn SPML $$HEX1$$fc00$$ENDHEX$$bertragen werden soll, dann Menge schon mal eintragen
			if iImportSpmls = 1 then
				iPax = dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_npax_spml")
				dsCenOutPax.Setitem(lrow,"npax_spml",iPax)
				
				// --------------------------------------------------------------------------------
				// 30.10.2009 HR: Falls SPML eingelesen werden, dann sollen die CHDs 
				//                        der F- und C-Klasse aufsummiert werden, um am Ende
				//                        in der Extrabeladung eingetragen zu werden
				// --------------------------------------------------------------------------------
				if iSearchClass =1 or iSearchClass=2 then
					iChildrenFC += dsCITPFlightData.GetItemNumber(lFoundRow,"cen_request_pax_nchd")
				end if
				
			end if
			
			// 04.11.2015 HR: Wenn wir Zahlen f$$HEX1$$fc00$$ENDHEX$$r die Klasse haben dann zur$$HEX1$$fc00$$ENDHEX$$ck
			return True 
			
		elseif  iBooking = 1 Then
			// 04.11.2015 HR: Wenn wir keine Zahlen f$$HEX1$$fc00$$ENDHEX$$r die Klasse haben, aber es sich um eine Buchungsklasse handelt, dann auch zur$$HEX1$$fc00$$ENDHEX$$ck
			return True 	
		End if
		
	end if
	
	iLocalPaxType = 2
	if  iBooking = 1 Then
		// 04.11.2015 HR: Fehlermeldung nur f$$HEX1$$fc00$$ENDHEX$$r Buchungsklassen
		sErrorPaxCounts = "Can't find a CITP-Counts, use Local Forcast" // 17.11.2009 HR: Fehlermeldung Pro Flug und nicht pro Klasse
	end if
Else
	return True		// keine Passagierzahlen
End if

// 03.03.06 Keine Prognose gefunden, dann lokale Auslastung verwenden
if iLocalPaxType = 2 Then
	dsForecast 			= dsLocalForecast
	sLocalorCentral 	= "local"
end if

// -------------------------------------------------
// Lokaler oder Zentraler Forecast 
// -------------------------------------------------
if iLocalPaxType = 1 then
	sFind 	= "nclass_number = " + string(lclass_number) + " and nrouting_id = " +  string(lRoutingId)
	
elseif iLocalPaxType = 2 then
	sFind 	= "nclass_number = " + string(lclass_number) + " and nrouting_id = " + &
					string(lRoutingId) + " and loc_class_forecast_cunit = '" + sUnit + "' and " + &
					"ctime_from <= '" + this.sDepartureTime + "' and ctime_to >= '" + this.sDepartureTime + "'"
end if						

lcnt		 	= dsForecast.RowCount()
lFoundRow 	= dsForecast.Find(sFind,1,dsForecast.Rowcount())
// -------------------------------------------------
// Kein Eintrag bei nicht Buchungsklassen ist OK.
// 25.04.07, KF Crewmengen zuspielen
// -------------------------------------------------
If lFoundRow <= 0 and iBooking = 0 Then

	// --------------------------------------------------------------------------------------------------------------------
	// 10.02.2014 HR: CBASE-NAM-CR-13049 wenn noverride_config=0 dann wie bisher
	// --------------------------------------------------------------------------------------------------------------------
	if  dsCenOutPax.GetItemNumber(lRow,"noverride_config") = 0 then
		lFoundCrew = dsCrewQuantities.Find("nclass_number  = " + String(lclass_number), 1, dsCrewQuantities.RowCount())
		 
		if lFoundCrew > 0 then
			
			iPax = dsCrewQuantities.GetItemNumber(lFoundCrew, "nversion")
			dsCenOutPax.Setitem(lRow,"npax",iPax)
		end if
	else
		// --------------------------------------------------------------------------------------------------------------------
		// 10.02.2014 HR: CBASE-NAM-CR-13049 wenn noverride_config=1 dann schauen wir in die Packages, 
		//                        ob wir was f$$HEX1$$fc00$$ENDHEX$$r die Klasse haben, wenn ja, dann nehmen wir die Paxe aus den Packages
		//                        ansonsten setzen wir diese auf 0
		// --------------------------------------------------------------------------------------------------------------------
		lFoundCrew = dsCenOutPackets.find("nresult_key = "+string(lResultKey)+" and  cpacket_class= '"+dsCenOutPax.getitemstring(lrow, "cclass")+"'",1, dsCenOutPackets.rowcount())
		
		if lFoundCrew > 0 then
			iPax = dsCenOutPackets.GetItemNumber(lFoundCrew, "npax")
			
			// 23.04.2014 HR: 4.99-120 Wenn Feld nicht gef$$HEX1$$fc00$$ENDHEX$$llt ist, dann soll eine 0 geschrieben werden, da sonst das Speichern scheitert
			if isnull(iPax) then
				dsCenOutPax.Setitem(lRow,"npax",0)
			else
				dsCenOutPax.Setitem(lRow,"npax",iPax)
			end if
		else
			dsCenOutPax.Setitem(lRow,"npax",0)
		end if
	end if
	
	return True
End if	
	
// 04.11.2015 HR: Fehlermeldung nur f$$HEX1$$fc00$$ENDHEX$$r Buchungsklassen
If lFoundRow <= 0  and iBooking = 1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't find a " + sLocalorCentral + " forecast entry for class : " + &
								dsCenOutPax.Getitemstring(lRow,"cclass_name") )
	return True
End if

// -------------------------------------------------
// Faktor f$$HEX1$$fc00$$ENDHEX$$r den Abflugtag
// -------------------------------------------------	
dFactor 		= dsForecast.Getitemdecimal(lFoundRow,sField)
iVersion 		= dsCenOutPax.Getitemnumber(lRow,"nversion")
// -------------------------------------------------
// Passagierzahl eintragen aber nicht f$$HEX1$$fc00$$ENDHEX$$r 999
// -------------------------------------------------	
If dFactor > 0 and iVersion > 0 and iVersion < 999 Then
	// Fallunterscheidung: handelt es sich um eine 100%-Auslastung?
	// Dann auf jeden Fall Rundungsprobleme vermeiden!

	if int(dFactor) = 100 then
		iPax = iVersion
		dsCenOutPax.Setitem(lRow,"npax",iPax)
	else
		iPax = Round ((iVersion / 100 * dFactor), 0)
		dsCenOutPax.Setitem(lRow,"npax",iPax)
	end if
End if

return True

end function

public function boolean of_change_version (long lcenoutrow, long largversiongroupkey);// -------------------------------------------------
// Version ermitteln
// -------------------------------------------------
	long 			lRow
	long			lFindRow
	string		sLocalClass
	string		sClassName
	integer		i
	string		sVersion
	integer		iClassNumber
	integer		iVersion
	string		sVersionFormat
	
//	dsCenOutPax = 
// -------------------------------------------------
// Datastore zum Update von Pax Zahlen
// -------------------------------------------------
	dsCenOutPax										= Create uo_generate_datastore
	dsCenOutPax.DataObject 						= "dw_cen_out_pax_change"
	dsCenOutPax.SetTransObject(SQLCA)
 	dsCenOutPax.Retrieve(lResultKey)
// -------------------------------------------------
// Retrieve auf die aktuelle Version
// -------------------------------------------------
	dsAircaftVersion								= Create DataStore
	dsAircaftVersion.DataObject 				= "dw_change_aircraft_classes"
	dsAircaftVersion.SetTransObject(SQLCA)
	lRow = dsAircaftVersion.Retrieve(lAircraftKey,lArgVersionGroupkey) 
	If lRow <= 0 Then
		destroy dsCenOutPax
		destroy dsAircaftVersion
		return False
	End if
// ---------------------------------------------------------
// Retieve Airline Classes
// ---------------------------------------------------------
	dsAirlineClasses.Retrieve(dsCenOut.Getitemnumber(lcenoutrow,"nairline_key"))	
	If dsAirlineClasses.Rowcount() <= 0 Then
		destroy dsCenOutPax
		destroy dsAircaftVersion
		return False
	End if
		
// -------------------------------------------------
// Alle Klassen der Airline in dsCenOutPax eintragen
// ------------------------------------------------
	sVersion = ""
	For i = 1 to dsAirlineClasses.Rowcount()
		 iClassNumber 	= dsAirlineClasses.Getitemnumber(i,"nclass_number")
		 sLocalClass	= dsAirlineClasses.Getitemstring(i,"cclass")
		 sClassName		= dsAirlineClasses.Getitemstring(i,"cclass_name")
		 iBooking		= dsAirlineClasses.Getitemnumber(i,"nbooking_class")
		 lRow 			= dsCenOutPax.Find("nclass_number = " + string(iClassNumber),1,dsCenOutPax.Rowcount())
		 If lRow <= 0 Then
		 	 lRow = dsCenOutPax.insertrow(0)
		 End if	 
		 dsCenOutPax.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
		 dsCenOutPax.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
		 dsCenOutPax.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
		 dsCenOutPax.SetItem(lRow,"NTRANSACTION",lTransActionKey)
		 dsCenOutPax.SetItem(lRow,"nresult_key",lResultKey)
		 dsCenOutPax.SetItem(lRow,"nclass_number",iClassNumber)
		 dsCenOutPax.SetItem(lRow,"cclass",sLocalClass)
		 dsCenOutPax.SetItem(lRow,"cclass_name",sClassName)
		 dsCenOutPax.SetItem(lRow,"nbooking_class",iBooking)
 		 If iBooking = 1 Then
			 lFindRow = dsAircaftVersion.find("nclass_number = " + string(iClassNumber),&
														 1,dsAircaftVersion.Rowcount())
			 If lFindRow > 0 Then
				 iVersion = dsAircaftVersion.Getitemnumber(lFindRow,"nversion")
				 dsCenOutPax.SetItem(lRow,"nversion",iVersion)
			 Else
				destroy dsCenOutPax
				destroy dsAircaftVersion
				return False
			 End if
			 // ----------------------------------
			 // Sitzplatz Version formatieren
			 // ----------------------------------
			 If len(string(iVersion)) = 1 Then
			 	sVersionFormat = "00"
			 ElseIf len(string(iVersion)) = 2 Then
				sVersionFormat = "000"
			 Else
				sVersionFormat = "000"
			 End if	
			 If sVersion = "" Then
			 	 sVersion = string(iVersion,sVersionFormat)
			 Else
				sVersion = sVersion + "-" + string(iVersion,sVersionFormat)
			End if	
		Else
			 dsCenOutPax.SetItem(lRow,"nversion",0)
		End if
		dsCenOutPax.SetItem(lRow,"npax",0)
		dsCenOutPax.SetItem(lRow,"npax_spml",0)
		// of_generate_pax(lRow,iClassNumber)
		
	Next
	dsCenOut.SetItem(lcenoutrow,"cconfiguration",sVersion)

	destroy dsCenOutPax
	destroy dsAircaftVersion
	
	Return True
	
end function

public function boolean of_job_executed ();// ------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob ein Job schon gelaufen ist ?
// 10 Tagesflugplan Neuanlage 			pro Betrieb
// 20 Tagesflugplan Update 				pro Betrieb
// 30 Tagesflugplan Delete 				pro Betrieb
// 40 Matdispo Neuanlage	 				pro Betrieb
// 50 Matdispo Update		 				pro Betrieb
// 70 Non Flight Business Neuanlage 	pro Betrieb
// 80 Non Flight Business Update	 		pro Betrieb
// 90 Non Flight Business Delete	 		pro Betrieb
// 100 Non Flight Business Matdispo		pro Betrieb
// 110 Zentrale Matdispo					pro Mandant
//	120 L$$HEX1$$f600$$ENDHEX$$sche $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen		pro Betrieb
// 130 Delete History						pro Betrieb
//	140 PPS Daten l$$HEX1$$f600$$ENDHEX$$schen
// 150 PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen
// 160 PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen
// 170 Asynchrone Generierung (Tagesflugplan + Matdispo $$HEX1$$fc00$$ENDHEX$$ber OnlineExplosion)
// ------------------------------------------------
	long 		lCount
	date		dJobDate
	datetime dtJobDateFrom
	datetime dtJobDateTo
	string	sYear, sMonth, sDay

	if ii_generate_jobtype=2 then
		// 28.10.2010 HR: Bei Generierungstype 2: Einmalereignisse wird immer false zur$$HEX1$$fc00$$ENDHEX$$ckgegeben
		idt_start = datetime(today(),now())
		return False
	end if

	//
	// Vorher: Konvertierung; nur so ist es als Dienst gelaufen
	//
	dJobDate 		= date(dtstart)
	dtJobDateFrom	= datetime(date(dtstart),time("00:00:00"))
	dtJobDateTo		= datetime(date(dtstart),time("23:59:59"))
		
	If iJob_Type = 10  Then				
		
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key 
		   and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 20  Then		
		
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key 
		   and djob_run_date >= :dtJobDateFrom 
			and djob_run_date <= :dtJobDateTo		
		   and djob_date 		= 	:dGenerationDate;
				  
	Elseif 	iJob_Type = 30  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 40  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 50  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key 
		   and djob_run_date >= :dtJobDateFrom 
			and djob_run_date <= :dtJobDateTo	
		   and djob_date 		= 	:dGenerationDate;

	Elseif 	iJob_Type = 70  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 80  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 90  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;
		
	Elseif 	iJob_Type = 100  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;
		 
	Elseif 	iJob_Type = 110  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 120  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;
		 
	Elseif 	iJob_Type = 130  Then		
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;
	
	Elseif 	iJob_Type = 140  Then	  // PPS Daten l$$HEX1$$f600$$ENDHEX$$schen	
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 150  Then	  // PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen	
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;


	Elseif 	iJob_Type = 160  Then	  // PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen	
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;

	Elseif 	iJob_Type = 170  Then	  // Asynchrone Generierung	
	
		SELECT count(*) INTO :lCount FROM loc_job_history  
		 WHERE njob_key = :lJob_Key and djob_date = :dGenerationDate;
	
	else
		this.of_trace("of_job_executed", 1, "Job_type " + String(iJob_Type)+" not defined.")

	End if	
	
	If lCount > 0 then
		return True
	Else
		return False
	End if
	
end function

public function boolean of_generate_handling_si_qaq ();// ---------------------------------------------------------------
// Station Instruction ermitteln
// Handling-ID = 3
// ---------------------------------------------------------------
	long 			lRow,i,j
	long			lHandling_Key
	datastore 	dsHandling
	string		sFilter
	long			lRet
// -------------------------------------------------
// Es wird erstmal gel$$HEX1$$f600$$ENDHEX$$scht, 
// -------------------------------------------------
	If bDelete = True Then
		delete from cen_out_qaq where nresult_key = :lResultKey;
		If SQLCA.SQLCODE <> 0 Then
			return False
		End if	
	End if	
// ---------------------------------------------------------------
// Flugnummer oder City Pair, mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
	dsHandling = dsHandlingObjects
	lRow = dsHandling.find("nhandling_id = 3",1,dsHandling.Rowcount())
	If lRow <= 0 Then
		dsHandling = dsHandlingObjects_cp
		lRow = dsHandling.find("nhandling_id = 3",1,dsHandling.Rowcount())
	End if	
	
	
// ---------------------------------------------------------------
// Kein Station Instruction
// ---------------------------------------------------------------
	If lRow <= 0 Then 
		return True
	End if	
// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den 
// nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
	For i = 1 to dsHandling.Rowcount()
		lHandlingId				= dsHandling.Getitemnumber(i,"nhandling_id")
		sHandlingObjectText 	= dsHandling.Getitemstring(i,"ctext")
		// --------------------------------------------
		// Station Instruction
		// --------------------------------------------
		If lHandlingId = 3  Then
			lHandling_Key = dsHandling.Getitemnumber(i,"nhandling_key")
			// ----------------------------------------------------
			// Nun der retrieve auf das Handling Objekt
			// ----------------------------------------------------
			dsHandlingQaq.Retrieve(lHandling_Key,dNewGenerationDate)
			
			If dsHandlingQaq.Rowcount() <= 0 Then return False
		End if		
		If lHandlingId = 3 Then
			
			For j = 1 to dsHandlingQaq.Rowcount()
				lQaqKey 			= dsHandlingQaq.Getitemnumber(j,"nhandling_qaq_key")
				iPrio				= dsHandlingQaq.Getitemnumber(j,"nprio")
				If not of_write_cen_out_qaq() Then
					return False
				End if	
			Next	
		End if	
	Next	

	Return True

	
end function

public function boolean of_generate_handling_two (long lcenoutrow);// ---------------------------------------------------------------
// Supplementloading List ermitteln
// ---------------------------------------------------------------
 			
long 			lRow, i, j, k, lHandling_Key
datastore 	lds_Handling, lds_PackageLos
string			sFilter, sFilterReg
boolean		bCFSPackages, bCFSExact


// ---------------------------------------------------------------
// Keine Supplementloading f$$HEX1$$fc00$$ENDHEX$$r Abfertigung Anlieferung
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "DLV" then
	return true
end if

// ---------------------------------------------------------------
// 26.06.2006 Keine Supplementloading f$$HEX1$$fc00$$ENDHEX$$r Abfertigung Request
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "REQ" then
	return true
end if

// ---------------------------------------------------------------
// Keine Supplementloading f$$HEX1$$fc00$$ENDHEX$$r Abfertigung SPC
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "SPC" then
	return true
end if

// ---------------------------------------------------------------
// Keine Supplementloading f$$HEX1$$fc00$$ENDHEX$$r Abfertigung INT CBASE-BRU-CR-2015-014
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "INT" then
	return true
end if

// ---------------------------------------------------------------
// Flugnummer oder City Pair, mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
lds_Handling = dsHandlingObjects

lRow = lds_Handling.find("nhandling_id = 2",1,lds_Handling.Rowcount())

If lRow <= 0 Then
	lds_Handling = dsHandlingObjects_cp
End if

// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den 
// nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
For i = 1 to lds_Handling.Rowcount()
	setnull(lAccountKey)
	setnull(lDefaultAccountKey)
	lDefaultAccountKey	= lds_Handling.Getitemnumber(i,"naccount_key")
	lHandlingId				= lds_Handling.Getitemnumber(i,"nhandling_id")
	sHandlingObjectText 	= lds_Handling.Getitemstring(i,"ctext")
	// --------------------------------------------
	// Supplement Loadinglist 
	// --------------------------------------------			
	If lHandlingId = 2  Then
		lHandling_Key 	= lds_Handling.Getitemnumber(i,"nhandling_key")
		lHandlingKey	= lHandling_Key
		// ----------------------------------------------------
		// Nun der retrieve auf das Handling Objekt
		// ----------------------------------------------------
		dsHandlingDetail.Retrieve(lHandling_Key,dNewGenerationDate,lAircraftKey,sDepartureTime)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 05.03.2013 HR: Filter wurde um die Registration erweitert (CBASE-DE-CR-2011-107)
		// --------------------------------------------------------------------------------------------------------------------
		for k = 1 to 2
			if k = 1 then 
				//Step 1 mit Registration
				sFilterReg = "cregistration = '" + sRegistration + "' and "		
			else 
				//Step 2 mit Dummy-Registration *
				sFilterReg = "cregistration = '*' and "		
			end if
			
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			// -------------------------------------------
			sFilter = sFilterReg + "nhandling_type_key = " + string(lHandlingTypeKey)
			dsHandlingDetail.SetFilter(sFilter)
			dsHandlingDetail.Filter()
			If dsHandlingDetail.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				// -------------------------------------------------
				sFilter = sFilterReg + "nhandling_type_key = " + string(lHandlingJoker)
				dsHandlingDetail.SetFilter("")
				dsHandlingDetail.Filter()
				dsHandlingDetail.SetFilter(sFilter)
				dsHandlingDetail.Filter()

				// 05.03.2013 HR: Daten gefunden, dann raus hier
				If dsHandlingDetail.Rowcount() > 0 Then exit

			else
				// 05.03.2013 HR: Daten gefunden, dann raus hier
				exit
			End if
		next

		// ---------------------------------------------------------------
		// Achtung: Legs > 1 d$$HEX1$$fc00$$ENDHEX$$rfen keine ZBL bekommen
		// ---------------------------------------------------------------
		if dsHandlingDetail.Rowcount() > 0 and lLegNumber > 1 then
//				of_write_protocol(iJob_Type,iGenerierungsstatus,2,iInfo,sAirline + " " + &
//									string(lFlightNumber),&
//									string(dGenerationDate,s_app.sDateformat),&
//									"Supressing Supplement Loading List because Legnumber is larger than 1." )
			return true
		end if
		
		For j = 1 to dsHandlingDetail.Rowcount()
			sLoadinglist 						= dsHandlingDetail.Getitemstring(j,"cloadinglist")
			iPrio								= dsHandlingDetail.Getitemnumber(j,"nprio")
			lAccountKey						= dsHandlingDetail.Getitemnumber(j,"naccount_key")
			is_AdditionalAccountCode	= dsHandlingDetail.Getitemstring(j,"cadditional_account") // 08.09.2011 HR:

			// --------------------------------------------------------------------------------------------------------------------
			// 17.06.2013 HR: CBASE-CR-NAM-12070B
			//                        SSL und ZBL nach Packages oder LOS zuordnen
			// --------------------------------------------------------------------------------------------------------------------
			if  lds_Handling.Getitemnumber(i,"nuse_customer_packets") = 1 then
				if of_generate_handling_paclos(lds_Handling, i, lcenoutrow, 2) = 0 then continue
			end if
			
			// Merker: Auch Customer-Key hier holen und in cen_out setzen
			
			If not of_write_cen_out_handling() Then
				return False
			End if	
		Next	
	End if	
Next	

Return True

end function

public function boolean of_write_cen_out_handling ();// ------------------------------------------
// Daten in den Datastore dsCenOut schreiben
// ------------------------------------------
	long 		lRow,lFound
	string 	sSearch
	Long  	lSequence

// ------------------------------------------
// Loadinglist Index Key
// ------------------------------------------	
	select NLOADINGLIST_INDEX_KEY
	  into :lloadinglistindexkey
	  from cen_loadinglist_index
	 where cloadinglist 	= 	:sLoadinglist
	   and dvalid_from 	<=	:dNewGenerationDate
		and dvalid_to		>=	:dNewGenerationDate	;
		
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	
// -------------------------------------------------------
// Ok, Loadinglist's k$$HEX1$$f600$$ENDHEX$$nnen nur einmal angewiesen werden !
// Check ob die gleiche Anweisung mehrmals vorliegt.
// -------------------------------------------------------
	lFound = dsCenOutHandling.find("nresult_key = " + string(lResultKey) + &
				" and nloadinglist_index_key = " + string(lloadinglistindexkey),1,dsCenOutHandling.Rowcount())
	If lFound > 0 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat), + "Loadinglist " + &
								sLoadinglist + " is not uniquely defined, this instruction will be ignored." )
		return True
	End if

	lRow = dsCenOutHandling.insertrow(0)

	dsCenOutHandling.SetItem(lRow,"NRESULT_KEY",lResultKey)
	dsCenOutHandling.SetItem(lRow,"NHANDLING_ID",lHandlingId)
	dsCenOutHandling.SetItem(lRow,"NLOADINGLIST_INDEX_KEY",lloadinglistindexkey)
	dsCenOutHandling.SetItem(lRow,"CLOADINGLIST",sLoadinglist)
	dsCenOutHandling.SetItem(lRow,"NPRIO",iPrio)
	dsCenOutHandling.SetItem(lRow,"CTEXT",sHandlingObjectText)
	dsCenOutHandling.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
	dsCenOutHandling.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
	dsCenOutHandling.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
	dsCenOutHandling.SetItem(lRow,"NTRANSACTION",lTransActionKey)
	dsCenOutHandling.SetItem(lRow,"nposting_type",1)	// Kartenart "Belastung"
	dsCenOutHandling.SetItem(lRow,"nquantity",1)			// Menge ist immer 1
	if isnull(lAccountKey) or lAccountKey = 0 then
		lAccountKey = lDefaultAccountKey
	end if
	dsCenOutHandling.SetItem(lRow,"naccount_key",lAccountKey)
	dsCenOutHandling.SetItem(lRow,"caccount",of_get_account_code(lAccountKey))

	// 08.09.2011 HR: Abrechnungscode2 f$$HEX1$$fc00$$ENDHEX$$llen
	if isnull(is_AdditionalAccountCode) then
		dsCenOutHandling.SetItem(lRow,"cadditional_account"," ")
	else
		dsCenOutHandling.SetItem(lRow,"cadditional_account",is_AdditionalAccountCode)
	end if
	
	//
	// neu: f$$HEX1$$fc00$$ENDHEX$$r den besseren Nachvollzug wird auch nhandling_key gespeichert
	//
	dsCenOutHandling.SetItem(lRow,"nhandling_key",lHandlingKey)
	

	//trace(50,"of_write_cen_out_handling" + " - " + "lResultKey: " + string(lResultKey) + " Flight: " + string(lFlightNumber) + " Loadinglist: " + sLoadinglist)
	
	return True


end function

public function boolean of_write_cen_out_handling_news ();// ------------------------------------------
// Daten nach cen_out_news schreiben
// ------------------------------------------
	long 		lRow
	string 	sSearch
	Long  	lSequence
	string	sInfo

// ------------------------------------------
// Loadinglist Index Key
// ------------------------------------------	
	select nnews_ll_index_key, cinfo
	  into :lloadinglistindexkey, :sInfo
	  from cen_news_ll_index
	 where cnews_ll 		= 	:sLoadinglist
	   and dvalid_from 	<=	:dNewGenerationDate
		and dvalid_to		>=	:dNewGenerationDate	;
		
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	

	lRow = dsCenOutHandlingNews.insertrow(0)
	dsCenOutHandlingNews.SetItem(lRow,"nhandling_key",lHandlingKeyNews)
	dsCenOutHandlingNews.SetItem(lRow,"nresult_key",lResultKey)
	dsCenOutHandlingNews.SetItem(lRow,"nhandling_id",lHandlingId)
	dsCenOutHandlingNews.SetItem(lRow,"nnews_ll_index_key",lloadinglistindexkey)
	dsCenOutHandlingNews.SetItem(lRow,"ntransaction",lTransActionKey)
	dsCenOutHandlingNews.SetItem(lRow,"cnews_ll",sLoadinglist)
	dsCenOutHandlingNews.SetItem(lRow,"cinfo",sInfo)
	dsCenOutHandlingNews.SetItem(lRow,"nprio",iPrio)
	dsCenOutHandlingNews.SetItem(lRow,"ctext",sHandlingObjectText)
	dsCenOutHandlingNews.SetItem(lRow,"dtimestamp",Datetime(today(),now()))
	dsCenOutHandlingNews.SetItem(lRow,"nstatus",iGenerierungsstatus)
	dsCenOutHandlingNews.SetItem(lRow,"cdescription",sGenerierungsstatus)

	if isnull(lAccountKey) or lAccountKey = 0 then
		lAccountKey = lDefaultAccountKey
	end if
	dsCenOutHandlingNews.SetItem(lRow,"naccount_key",lAccountKey)
	dsCenOutHandlingNews.SetItem(lRow,"caccount",of_get_account_code(lAccountKey))

	return True


end function

public function boolean of_generate_handling_newspaper ();// ---------------------------------------------------------------
// Newspaper-Loadinglists ermitteln
//
// Handling-Objekt			Handling-ID
// ------------------------------------
// Zeitungs-Loadinglists		6
// Zeitungs-Extrabeladung		7
// Zeitungs-Umladung				8
//	Zeitungs-Gatelieferung		9
// Drittmarkt						10
// 
// ---------------------------------------------------------------
//
// 22.05.2003	sClass f$$HEX1$$fc00$$ENDHEX$$r den Zugriff auf ein Varchar-Feld
//
// ---------------------------------------------------------------
	long 			lRow,i,j,l, lFind
	long			lHandling_Key
	datastore 	dsHandling
	string		sFilter, sFind, sSQL, sSub
	long			lRet, lKey, lInboundAirline
	integer		iTrafficDay	// Verkehrstag
	integer		iarrival_faktor, iClass
	long			lPaxToCalc
	time			tInbound
	long			lFaktor,	lHour, lSeconds, lDepartureSeconds
	long			lHourSeconds, lMinuteSeconds, lMinute
	long			lCustomer_Key
	
// ---------------------------------------------------------------
// Flugnummer oder City Pair, mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
	dsHandling = dsHandlingObjects

	lRow = dsHandling.find("nhandling_id = 6",1,dsHandling.Rowcount())

	If lRow <= 0 Then
		dsHandling = dsHandlingObjects_cp
		lRow = dsHandling.find("nhandling_id = 6",1,dsHandling.Rowcount())
	End if	
// ---------------------------------------------------------------
// Keine Zeitungsbeladung, oder wenigstens Extrabeladung 
// oder Umladung ???
// ---------------------------------------------------------------
	If lRow <= 0 Then 
		dsHandling = dsHandlingObjects
		lRow = dsHandling.find("nhandling_id = 7",1,dsHandling.Rowcount())
		If lRow <= 0 Then
			dsHandling = dsHandlingObjects_cp
			lRow = dsHandling.find("nhandling_id = 7",1,dsHandling.Rowcount())
		End if	
		If lRow <= 0 Then 
			dsHandling = dsHandlingObjects
			lRow = dsHandling.find("nhandling_id = 8",1,dsHandling.Rowcount())
			If lRow <= 0 Then
				dsHandling = dsHandlingObjects_cp
				lRow = dsHandling.find("nhandling_id = 8",1,dsHandling.Rowcount())
			End if	
			If lRow <= 0 then
				return True
			End if
		End if
	End if
	
// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
	iTrafficDay = DayNumber(dNewGenerationDate)
	iTrafficDay --
	if iTrafficDay = 0 then iTrafficDay = 7
	
// ---------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bertrag in History-Tabellen
// (fehlt noch)
// ---------------------------------------------------------------

// ---------------------------------------------------------------
// Tabula Rasa
// ---------------------------------------------------------------
	If bDelete = True Then
		delete from cen_out_news where nresult_key = :lResultKey;
		If SQLCA.SQLCODE <> 0 Then
			return False
		End if
	
		delete from cen_out_news_extra where nresult_key = :lResultKey;
		If SQLCA.SQLCODE <> 0 Then
			return False
		End if
	End if
// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den 
// nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
	For i = 1 to dsHandling.Rowcount()
		setnull(lAccountKey)
		setnull(lDefaultAccountKey)
		lHandlingId				= dsHandling.Getitemnumber(i,"nhandling_id")
		sHandlingObjectText 	= dsHandling.Getitemstring(i,"ctext")
		lDefaultAccountKey	= dsHandling.Getitemnumber(i,"naccount_key")
		// --------------------------------------------
		// Lesematerial Loadinglist 
		// --------------------------------------------
		If lHandlingId = 6  Then
			lHandling_Key 			= dsHandling.Getitemnumber(i,"nhandling_key")
			// ----------------------------------------------------
			// Nun der retrieve auf das Newspaper Handling Objekt
			// ----------------------------------------------------
			lRet = dsHandlingNewspaper.Retrieve(lHandling_Key,dNewGenerationDate,lAircraftKey,sDepartureTime)
			of_trace("of_generate_handling_newspaper", 20,"processing result_key=" + &
						string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
						", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
						" " + sHandlingObjectText + ", Rows in dsHandlingNewspaper = " + string(lRet))
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			// -------------------------------------------
			sFilter = "nhandling_type_key = " + string(lHandlingTypeKey)
			dsHandlingNewspaper.SetFilter(sFilter)
		 	dsHandlingNewspaper.Filter()
			If dsHandlingNewspaper.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				// -------------------------------------------------
				sFilter = "nhandling_type_key = " + string(lHandlingJoker)
				dsHandlingNewspaper.SetFilter("")
				dsHandlingNewspaper.Filter()
				dsHandlingNewspaper.SetFilter(sFilter)
		 		dsHandlingNewspaper.Filter()
			End if
		End if
		
		// --------------------------------------------
		// Lesematerial Extrabeladung / Umladung / Gate
		// --------------------------------------------
		If lHandlingId = 7  or lHandlingId = 8 or lHandlingId = 9 Then
			lHandling_Key = dsHandling.Getitemnumber(i,"nhandling_key")
			// ----------------------------------------------------
			// Nun der retrieve auf das Newspaper Handling Objekt
			// ----------------------------------------------------
			//MessageBox("dsHandlingNewsAddOn.Retrieve",string(lHandling_Key) + "," + string(dNewGenerationDate) + "," + sDepartureTime)
			dsHandlingNewsAddOn.SetFilter("")
			dsHandlingNewsAddOn.Filter()
			lRet = dsHandlingNewsAddOn.Retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime)
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			// -------------------------------------------
			sFilter = "nhandling_type_key = " + string(lHandlingTypeKey)
			dsHandlingNewsAddOn.SetFilter(sFilter)
		 	dsHandlingNewsAddOn.Filter()
			If dsHandlingNewsAddOn.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				// -------------------------------------------------
				sFilter = "nhandling_type_key = " + string(lHandlingJoker)
				dsHandlingNewsAddOn.SetFilter("")
				dsHandlingNewsAddOn.Filter()
				dsHandlingNewsAddOn.SetFilter(sFilter)
		 		dsHandlingNewsAddOn.Filter()
			End if
		End if
		
		//
		// Daten nach cen_out_news schreiben
		//
		If lHandlingId = 6 Then
			For j = 1 to dsHandlingNewspaper.Rowcount()
				sLoadinglist		= dsHandlingNewspaper.Getitemstring(j,"cnews_ll")
				iPrio					= dsHandlingNewspaper.Getitemnumber(j,"nprio")
				lHandlingKeyNews	= dsHandlingNewspaper.Getitemnumber(j,"nhandling_key")
				of_trace("of_generate_handling_newspaper", 50,"processing result_key=" + &
						string(lResultKey) + ", sLoadinglist = " + sLoadinglist + ", nhandling_key = " + &
						string(lHandlingKeyNews) )
				If not of_write_cen_out_handling_news() Then
					return False
				End if
			Next
		End if
		
		//
		// Daten nach cen_out_news_extra schreiben
		//
		If lHandlingId = 7 or lHandlingId = 8 or lHandlingId = 9 Then
			For j = 1 to dsHandlingNewsAddOn.Rowcount()
				//
				// Neu:	Pr$$HEX1$$fc00$$ENDHEX$$fung, ob der Kunde (cen_handling_ncustomer_key) mit dem AALC aus cen_out
				//			$$HEX1$$fc00$$ENDHEX$$bereinstimmt. Falls nicht, dann ist dieser Lesematerial-Auftrag auch nicht
				//			f$$HEX1$$fc00$$ENDHEX$$r diesen Flug.
				//
				lCustomer_Key				= dsHandlingNewsAddOn.Getitemnumber(j,"cen_handling_ncustomer_key")
				if lCustomer_Key <> lcustomerkey then
					//
					// HandlingObjekt-Kunde stimmt nicht mit Flug-Kunde $$HEX1$$fc00$$ENDHEX$$berein
					//
					continue
				end if
				
				sPackinglist				= dsHandlingNewsAddOn.Getitemstring(j,"cen_news_pl_index_cnews_pl")
				sNewspaper					= dsHandlingNewsAddOn.Getitemstring(j,"cen_news_pl_index_cnewspaper")
				iPrio							= dsHandlingNewsAddOn.Getitemnumber(j,"nprio")
				lPackinglistIndexKey		= dsHandlingNewsAddOn.Getitemnumber(j,"nnews_pl_index_key")
				lPackinglistDetailKey	= dsHandlingNewsAddOn.Getitemnumber(j,"cen_news_pl_nnews_pl_detail_key")
				lClassNumber				= dsHandlingNewsAddOn.Getitemnumber(j,"nclass_number")
				sClass						= dsHandlingNewsAddOn.Getitemstring(j,"cclass")	
				lCalcID						= dsHandlingNewsAddOn.Getitemnumber(j,"ncalc_id")
				lCalcDetailKey				= dsHandlingNewsAddOn.Getitemnumber(j,"ncalc_detail_key")
				iAction						= dsHandlingNewsAddOn.Getitemnumber(j,"naction")
				lInboundAirline			= dsHandlingNewsAddOn.Getitemnumber(j,"nairline_key_inbound")
				sInboundAirline			= f_airline_to_string(lInboundAirline)
				lInboundFlightNumber		= dsHandlingNewsAddOn.Getitemnumber(j,"nflight_number_inbound")
				sInboundSuffix				= dsHandlingNewsAddOn.Getitemstring(j,"csuffix_inbound")
				iInboundOffset				= dsHandlingNewsAddOn.Getitemnumber(j,"noffset_inbound")
				setnull(sInboundTime)
				//
				// Falls Inbound Daten vorhanden (Umladungen),
				// dann den Flugplan anzapfen
				//
				if dsHandlingNewsAddOn.Getitemnumber(j,"nairline_key_inbound") = lAirlineKey then
					lKey = of_get_schedule_key()
					//
					// Retrieve auf Inbound-Flug
					//
					dsGenerateFlight.Retrieve(lKey, lInboundAirline, lInboundFlightNumber, sInboundSuffix, dNewGenerationDate)
					//
					// Suche passenden Verkehrstag
					//
					iTrafficDay = daynumber(dNewGenerationDate)
					iTrafficDay --
					if iTrafficDay = 0 then iTrafficDay = 1
					
					lFind = dsGenerateFlight.Find("nfreq" + string(iTrafficDay) + " = 1",1,dsGenerateFlight.RowCount())
					if lFind > 0 then
						sInboundTime 		= dsGenerateFlight.GetItemString(lFind,"carrival_time")
						iarrival_faktor 	= dsGenerateFlight.GetItemNumber(lFind,"narrival_faktor")
						
						lHour					= Hour(Time(sInboundTime)) 			// Stunden
						lMinute				= Minute(Time(sInboundTime))			// Minuten
						lFaktor				= iarrival_faktor * 60 * 60 			// GMT Offset in Sekunden
						lHourSeconds		= Hour(Time(sInboundTime)) * 3600	// Stunden in Sekunden
						lMinuteSeconds		= Minute(Time(sInboundTime)) * 60	// Minuten in Sekunden
						lDepartureSeconds	= lHourSeconds + lMinuteSeconds + lFaktor	// Inboundzeit in Sekunden
						
						tInbound 			= time(sInboundTime)
						
						//
						// Die neue Zeit
						//
						if lDepartureSeconds < 86400 then
							sInboundTime		= string(RelativeTime(Time(sInboundTime),lFaktor),"hh:mm")
						else
							//
							// 00:00 Uhr Grenze wird $$HEX1$$fc00$$ENDHEX$$berschritten
							//
							lHour = (lHour + iarrival_faktor) - 24
							sInboundTime	= string(Time(lHour, lMinute, 0),"hh:mm")
						end if
					end if
				else
					//
					// Es handelt sich um eine Fremde Airline
					// => es gibt vielleicht gar keinen Flugplan
					//
				end if
				
				
				//
				// Menge lQuantity ermitteln
				//
				if lCalcID > 0 then
					//
					// Passagierzahl f$$HEX1$$fc00$$ENDHEX$$r Klasse ermitteln
					//
					// alt: 
					//
//					sFind = "nresult_key = " + string(lResultKey) + " and nclass_number = " + string(lClassNumber)
//					lRow = dsCenOutPax.Find(sFind,1,dsCenOutPax.RowCount())
//					if lRow > 0 then
//						lPaxToCalc = dsCenOutPax.GetItemNumber(lRow,"npax")
//					else
//						lPaxToCalc = 0
//					end if
					//
					// neu: Klasse ist ein String-Feld, kann mehrere Klassen haben und muss berechnet werden
					//		  dazu wird jetzt sClass statt lClassNumber verwendet
					// gut: dsCenOutPax h$$HEX1$$e400$$ENDHEX$$lt auch die Klasse als String
					// lResultKey ist instanz
					// lPaxToCalc ist lokal, wird nach jedem Flug null, 
					// => Check Sortierung dsHandlingNewsAddOn
					//		kann ohne weiteres lPaxToCalc hochgez$$HEX1$$e400$$ENDHEX$$hlt werden???
					//
					// 
					// neuer Ansatz:
					//
					iClass 		= len(sClass)
					lPaxToCalc	= 0
					
					for l = 1 to iClass
						sSub = mid(sClass,l,1)
						sFind = "nresult_key = " + string(lResultKey) + " and cclass = '" + sSub + "'"
						
						lRow = dsCenOutPax.Find(sFind,1,dsCenOutPax.RowCount())
						if lRow > 0 then
							lPaxToCalc += dsCenOutPax.GetItemNumber(lRow,"npax")
						end if
					next
					
					
					//f_print_datastore(dsCenOutPax)

					
					if isvalid(uo_calc) then
						//
						// Berechnungsart wurde gew$$HEX1$$e400$$ENDHEX$$hlt
						//
						uo_calc.lcalcid 			= lcalcid
						uo_calc.lCalcDetailKey 	= lCalcDetailKey
						uo_calc.dDate				= dNewGenerationDate
						uo_calc.lPax				= lPaxToCalc	
						
						if lcalcid = 1 then
							lQuantity = dsHandlingNewsAddOn.GetItemNumber(j,"nquantity" + string(iTrafficDay))
						end if
						
						if lcalcid = 2 then
							lQuantity = lPaxToCalc	// hier pax aus cen_out_pax
						end if
						
						if lcalcid = 3 then
							//
							// Ratiolists gem. sys_calculator
							//
							lQuantity = uo_calc.of_calc_ratiolist()
						end if
					else
						lQuantity = 0
					end if
				else
					//
					// keine Berechnungsart => Menge f$$HEX1$$fc00$$ENDHEX$$r Frequenztag wird $$HEX1$$fc00$$ENDHEX$$bertragen
					//
					lquantity = dsHandlingNewsAddOn.GetItemNumber(j,"nquantity" + string(iTrafficDay))
				end if
				
				If not of_write_cen_out_news_extra() Then
					return False
				End if
			Next
		End if
		
	Next

	Return True
	
end function

public function boolean of_generate_schedule_delete ();// -----------------------------------------------------
// l$$HEX1$$f600$$ENDHEX$$schen Tagesflugplan 
// -----------------------------------------------------
long	lSQLCode
long	lSQLRow 
	
lJobActions		= 0
// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if	

SELECT count(*) into :lJobActions FROM cen_out
		WHERE ddeparture 	= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit	 and
				nairline_key 	= :lAirlineKey;
// -----------------------------------------------------------------
// Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r History z$$HEX1$$e400$$ENDHEX$$hlen.
// -----------------------------------------------------------------	
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule count(*), sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// 07.07.2009 HR:
// L$$HEX1$$f600$$ENDHEX$$sche CEN_REQUEST, da diese nicht mehr $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht wird
// -----------------------------------------------------------------	
delete from cen_request 
       where nresult_key in (select nresult_key from cen_out 
		                                                     where  ddeparture 			= :dGenerationDate and 
																	cclient	  		= :sclient and
																	cunit		  		= :sunit and
																	nairline_key 	= :lAirlineKey);
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_request failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight requests, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if


// -----------------------------------------------------------------
// 07.07.2009 HR:
// L$$HEX1$$f600$$ENDHEX$$sche CEN_OUT_QP, da diese nicht mehr $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht wird
// -----------------------------------------------------------------	
delete from CEN_OUT_QP 
       where nresult_key in (select nresult_key from cen_out 
		                                                     where  ddeparture 			= :dGenerationDate and 
																	cclient	  		= :sclient and
																	cunit		  		= :sunit and
																	nairline_key 	= :lAirlineKey);
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on CEN_OUT_QP failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight querys, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber Trigger gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		
DELETE FROM cen_out 
		WHERE ddeparture 	= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit and
				nairline_key 	= :lAirlineKey;
				
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_out failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Prognose l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		
DELETE FROM cen_external_schedule 
		WHERE ddeparture 	= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit and
				nairline_key 	= :lAirlineKey;
				
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_external_schedule failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete forecast schedule, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if	

// -----------------------------------------------------------------
// 18.04.2007, KF
// Datum von = auf <= ge$$HEX1$$e400$$ENDHEX$$ndert
//
// Inbound-Daten l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
DELETE FROM cen_in 
		WHERE darrival 		= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit;
				
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_in failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete inbound, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if		

DELETE FROM cen_in_out 
		WHERE darrival 		= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit;
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_in_out failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete inbound, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if		

DELETE FROM cen_transport 
		WHERE darrival 		= :dGenerationDate and 
				cclient	  		= :sclient and
				cunit		  		= :sunit;
				
If sqlca.sqlcode <> 0 then
	this.of_trace("of_generate_schedule_delete", 1, "ERROR - Delete on cen_transport failed: ["  + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete inbound, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if	

// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
	commit using sqlca;
	return True
End if


end function

public function s_change_flight of_single_flight (s_change_flight s_change);// ---------------------------------------------
// Handlings f$$HEX1$$fc00$$ENDHEX$$r den entsprechenden Flug $$HEX1$$e400$$ENDHEX$$ndern
// ---------------------------------------------
integer		iVerkehrsTag
string  		sFrequenz
long			lRow
// ---------------------------------------------
// Inhalt der Tabellen nicht l$$HEX1$$f600$$ENDHEX$$schen !
// ---------------------------------------------
bDelete 					= False

s_change.bsuccess 	= True
s_change.sMessage 	= ""
bCalculateNoMeals	= s_change.bmeals
bCalculateNoExtra		= s_change.bextra
bCalculateNoNews		= s_change.bnewspaper
dNewGenerationDate	= s_change.dDeparture
dGenerationDate		= s_change.dDeparture
iVerkehrsTag 			= f_getfrequence(dNewGenerationDate)
sFrequenz 				= "nfreq" + string(iVerkehrsTag) + "=1"
sGenerierungsstatus	= "changed"

dsCenOut									= Create uo_generate_datastore
dsCenOut.DataObject 						= "dw_change_cen_out"
dsCenOut.SetTransObject(SQLCA)

dsCenOutPax								= Create uo_generate_datastore
dsCenOutPax.DataObject 					= "dw_change_cen_out_passenger"
dsCenOutPax.SetTransObject(SQLCA)

dsCenOutHandling							= Create uo_generate_datastore
dsCenOutHandling.DataObject 			= "dw_change_cen_out_handling"
dsCenOutHandling.SetTransObject(SQLCA)	 

// --------------------------------------------------------------
// Datastore wird mit der Struktur s_change $$HEX1$$fc00$$ENDHEX$$bergeben.
// --------------------------------------------------------------	
dsCenOut	= s_change.dssingle

// --------------------------------------------------------------
// Nun Instance Variablen f$$HEX1$$fc00$$ENDHEX$$llen.
// --------------------------------------------------------------	
lRoutingPlanDetailKey_CP	= dsCenOut.GetItemNumber(1,"NROUTINGDETAIL_KEY_CP")
lRoutingPlanGroupKey_CP	= dsCenOut.GetItemNumber(1,"NROUTING_GROUP_KEY_CP")
lRoutingPlanDetailKey			= dsCenOut.GetItemNumber(1,"NROUTINGDETAIL_KEY")
lRoutingPlanGroupKey		= dsCenOut.GetItemNumber(1,"NROUTING_GROUP_KEY")
lLegNumber						= dsCenOut.GetItemNumber(1,"NLEG_NUMBER")
lFlightNumber 					= dsCenOut.Getitemnumber(1,"NFLIGHT_NUMBER")
lAircraftKey						= dsCenOut.Getitemnumber(1,"NAIRCRAFT_KEY")
lHandlingTypeKey				= dsCenOut.Getitemnumber(1,"NHANDLING_TYPE_KEY")
sDepartureTime					= dsCenOut.Getitemstring(1,"CDEPARTURE_TIME")
lRoutingID					 	= dsCenOut.Getitemnumber(1,"NROUTING_ID")	
lResultKey						= dsCenOut.Getitemnumber(1,"NRESULT_KEY")
lAirlinekey						= dsCenOut.Getitemnumber(1,"NAIRLINE_KEY")
sTLCFrom						= dsCenOut.Getitemstring(1,"ctlc_from")
sTLCTo							= dsCenOut.Getitemstring(1,"ctlc_to")
sAirline							= dsCenOut.Getitemstring(1,"cairline")
sSuffix							= dsCenOut.Getitemstring(1,"csuffix")
iGenerierungsstatus			= dsCenOut.Getitemnumber(1,"nstatus") 
ii_leg_number					= dsCenOut.Getitemnumber(1,"nleg_number")

// 25.09.2012 HR: noch ben$$HEX1$$f600$$ENDHEX$$tigte Felder f$$HEX1$$fc00$$ENDHEX$$llen
lTlcfrom	= dsCenOut.Getitemnumber(1,"ntlc_from")
lTlcTo	= dsCenOut.Getitemnumber(1,"ntlc_to")

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

  // 01.10.2010 HR: Japantool UTC-Zeit ermitteln
  SELECT trunc(cen_out.ddeparture_time_utc ) 
    INTO :dGenerationDateUTC  
    FROM cen_out  
   WHERE cen_out.nresult_key = :lResultKey;

//19.01.2011 HR
is_flugnummer=string(dGenerationDate, "yyyymmdd")+sAirline + string(lFlightNumber, "0000")+sSuffix+sTLCFrom+sTLCTo

if iGenerierungsstatus < 3 then iGenerierungsstatus = 3
// ---------------------------------------------------------------
// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r Flugnummern bezogene Beladung
// ---------------------------------------------------------------
dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate, sUnit)
dsHandlingObjects.SetFilter(sFrequenz)
dsHandlingObjects.Filter()
// ---------------------------------------------------------------
// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r City Pair bezogene Beladung
// ---------------------------------------------------------------		 
dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, sUnit)
dsHandlingObjects_cp.SetFilter(sFrequenz)
dsHandlingObjects_cp.Filter()
// ------------------------
// Handling Joker ermitteln
// ------------------------
of_get_handling_joker()	
// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Loadinglist 
// ---------------------------------------------------------------		 
If not of_generate_handling_one(1) Then
	if not bNoHandlingNecessary then  // keine Abbruch bei Monalisa-Auslandcaterer

		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Standardbeladung kann nicht ermittelt werden.")
		return s_change		
	end if
End if
// ---------------------------------------------------------------		 
// Handlingobjekte Supplement Loadinglist
// ---------------------------------------------------------------	
If not of_generate_handling_two(1) Then
	if not bNoHandlingNecessary then  // keine Abbruch bei Monalisa-Auslandcaterer
		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Zusatzbeladung kann nicht ermittelt werden.")
		return s_change		
	end if
End if
// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Station Instruction
// ---------------------------------------------------------------		 
If not of_generate_handling_si_qaq() Then
	if not bNoHandlingNecessary then  // keine Abbruch bei Monalisa-Auslandcaterer

		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Stations Auftrag kann nicht ermittelt werden.")
		return s_change		
	end if
End if
// ---------------------------------------------------------------		 
// Pax Zahlen $$HEX1$$fc00$$ENDHEX$$bergeben
// ---------------------------------------------------------------		 
dsCenOutPax 		= s_change.dsPax
dsCenOutPriorPax	= s_change.dsPriorPax
//// ---------------------------------------------------------------		 
//// SPML vorbereiten, werden im Pax-DW ben$$HEX1$$f600$$ENDHEX$$tigt
//// ---------------------------------------------------------------		 
//dsCenOutNewSPML			= s_change.dsnewspml
//dsCenOutPriorSPML			= s_change.dspriorspml
//dsCenOutNewSPML.Sort()
//dsCenOutNewSPML.GroupCalc()
//// ---------------------------------------------------------------		 
//// SPML Zahlen Menge alt <-> neu $$HEX1$$fc00$$ENDHEX$$bertragen
//// ---------------------------------------------------------------		 
//If not of_change_spml() Then
//	s_change.bsuccess = False
//	s_change.sMessage = uf.translate("Alte SPML konnten nicht $$HEX1$$fc00$$ENDHEX$$bertragen werden.")
//	return s_change		
//End if
//// ---------------------------------------------------------------		 
//// Pax Zahlen Menge alt <-> neu $$HEX1$$fc00$$ENDHEX$$bertragen
//// ---------------------------------------------------------------		 
//If not of_change_pax() Then
//	s_change.bsuccess = False
//	s_change.sMessage = uf.translate("Alte Passagierzahlen konnten nicht $$HEX1$$fc00$$ENDHEX$$bertragen werden.")
//	return s_change		
//End if
// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Zeitungsbeladung aufl$$HEX1$$f600$$ENDHEX$$sen
// Achtung: Mu$$HEX2$$df002000$$ENDHEX$$nach Default Aircraft Version laufen!
// ---------------------------------------------------------------		 
if bCalculateNoNews = false then
	If not of_generate_handling_newspaper() Then
		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Zeitungsbeladung kann nicht ermittelt werden.")
		return s_change		
	End if
end if
// ---------------------------------------------------------------		 
// Handlingobjekte Mahlzeitenbeladung
// ---------------------------------------------------------------
dsCenOutMeals 				= s_change.dspriormeals
dsCenOutNewSPMLDetail	= uo_generate_meals.dsSPMLDetail
dsCurrentMeals				= s_change.dsCurrentMeals
dsCurrentExtra				= s_change.dsCurrentExtra

// --------------------------------------------------------------------------------------------------------------------
// 12.04.2011 HR: Wir lesen die Packets zum Flug ein, damit diese ggf.
//                           bei der Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden.
// --------------------------------------------------------------------------------------------------------------------
dsCenOutPackets.retrieve(lResultkey)

//
// Neuberechnung Mahlzeiten, Achtung: bCalculateNoMeals spielt eine Rolle
//
//
// R$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngigmachen von annulliertem Flug kann Neuberechnung verhindern...
//
if s_change.bDoMealCalculation = true then
	
	// 25.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen lesen (CBASE-NAM-CR-11009)
	// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling: Result_key wird ben$$HEX1$$f600$$ENDHEX$$tigt
	uo_generate_meals.uf_retrieve_local_subst( sUnit, lAirlineKey, lFlightNumber, sSuffix, dGenerationDate, sDepartureTime, lAircraftKey, &
															 lRoutingID, lTlcfrom, lTlcTo, lHandlingTypeKey, lResultkey)

	//	// 		 
	//	// SPML aufl$$HEX1$$f600$$ENDHEX$$sen
	//	// 
	//	if of_resolve_spml() <> 0 then
	//		s_change.bsuccess = False
	//		s_change.sMessage = uf.translate("Handling SPML kann nicht ermittelt werden.")
	//		return s_change
	//	end if
	
	//
	// Mahlzeiten aufl$$HEX1$$f600$$ENDHEX$$sen
	//
	if not of_generate_handling_meals(0, s_change, "") Then
		s_change.bsuccess = false
		s_change.sMessage = uf.translate("Handling Mahlzeitenbeladung kann nicht ermittelt werden.")
		return s_change
	end if
	//
	// SPML und SPML-Details k$$HEX1$$f600$$ENDHEX$$nnen erst im w_change_center gespeichert
	// werden. (Master-Detail-Beziehung)
	//
	if dsCenOutNewSPMLDetail.RowCount() > 0 then
		//
		// Inhalt der SPML-Details in die Struktur kopieren,
		// damit im Fenster sp$$HEX1$$e400$$ENDHEX$$ter die Inhalte gespeichert werden k$$HEX1$$f600$$ENDHEX$$nnen.
		//
		dsCenOutNewSPMLDetail.RowsCopy(1,dsCenOutNewSPMLDetail.rowcount(),Primary!,s_change.dsnewspmldetail,s_change.dsnewspmldetail.RowCount() + 1,Primary!)
	end if
end if

//
// Neuberechnung Extrabeladung
//
// Falls einfach so drin bleibt, wird die neuberechnete Mahlzeitenbeladung zerst$$HEX1$$f600$$ENDHEX$$rt
//
dsCenOutExtra = s_change.dspriorextra

// if bCalculateNoExtra = false then
if s_change.bDoMealCalculation = true then
	If not of_generate_handling_meals(1, s_change, "") Then
		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Extrabeladung kann nicht ermittelt werden.")
		return s_change
	End if
	
	//dsCenOut.setitem(1,"nlocal_sub",uo_generate_meals.il_nlocal_sub_flight) // 25.09.2012 HR: Kennzeichen ob Lokalen Ersetzungen durchgef$$HEX1$$fc00$$ENDHEX$$hrt wurden an Flug merken(CBASE-NAM-CR-11009)
 	//s_change.dssingle.setitem(1,"nlocal_sub",uo_generate_meals.il_nlocal_sub_flight) // 08.10.2012 HR: Kennzeichen ob Lokalen Ersetzungen durchgef$$HEX1$$fc00$$ENDHEX$$hrt wurden an Flug merken(CBASE-NAM-CR-11009)
end if


//
// Neue Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung ist in dsCenOutMeals
//
//s_change.dspriormeals = dsCenOutMeals // doch nicht zur$$HEX1$$fc00$$ENDHEX$$ck in Struktur

// ---------------------------------------------------------------		 
// Matdispo f$$HEX1$$fc00$$ENDHEX$$r neue Beladung sp$$HEX1$$e400$$ENDHEX$$ter separat
// ---------------------------------------------------------------

return s_change

end function

public function boolean of_update ();//=====================================================================================
//
// of_update
//
//=====================================================================================
long		lSQLCode
long		lSQLRow 
Long		i
String	sSQLErrorText
Long		lRows
long		lActions
long		lCount
datetime	dtGenerationDate
datetime	dtReturnFlightDate
datetime	dtNewReturnFlightDate
string	sLocalDepartureTime
long		lChangedResultKey
long lFound, lmaster_key, j, k

lJobActions	= dsCenOut.Rowcount()

long 			nairlinekey, nflightnumber, nlegnumber, lresult_key
string 		cunit, csuffix, cTLCFrom, cTLCTo, sFind
datetime 	ddeparture

for i= dsCenOut.rowcount() to 1 step -1

   nairlinekey      	= dsCenOut.getitemnumber(i,"nairline_key")
   nflightnumber   	= dsCenOut.getitemnumber(i,"nflight_number")
   nlegnumber      	= dsCenOut.getitemnumber(i,"nleg_number")
   cunit            		= dsCenOut.getitemstring(i,"cunit")
   csuffix         		= dsCenOut.getitemstring(i,"csuffix")
   ddeparture      	= dsCenOut.getitemdatetime(i,"ddeparture")
   cTLCFrom      	= dsCenOut.getitemstring(i,"ctlc_from")
   cTLCTo         	= dsCenOut.getitemstring(i,"ctlc_to")
   
   // --------------------------------------------------------------------------------------------------------------------
   // 23.06.2010 HR: Falls Flugnummer im dsCenOutNotRegenerate zu finden ist, dann auch auf 
   //                        Generierung verzichten
   // 20.03.2015 HR: Es muss die ganze Strecke ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden, nicht nur CTLCFROM 
   // --------------------------------------------------------------------------------------------------------------------
   sFind = "nflight_number = " + string(nflightnumber) 
   sFind += " and nleg_number = "+string(nlegnumber)
   sFind += " and csuffix = '" + csuffix + "'"
   sFind += " and ctlc_from = '"+cTLCFrom+"'"
   sFind += " and ctlc_to = '"+cTLCTo+"'"
   lFound = dsCenOutNotRegenerate.find(sFind, 1, dsCenOutNotRegenerate.RowCount())

   if lFound > 0 then   
      	of_trace("of_update", 1,"Flight found in NotToRegenerate Cache: " + string(lFlightNumber)+sSuffix+" Leg "+string(lLegNumber)+" " +sTLCFrom+"-"+sTLCTo)
		
		lresult_key = dsCenOut.getitemnumber(i,"nresult_key")
		
		dsCenOut.deleterow(i)
		for j= dsCenOutHandling.rowcount() to 1 step -1
			if lresult_key = dsCenOutHandling.getitemnumber(j,"nresult_key") then dsCenOutHandling.deleterow(j)
		next
		
		
		for j= dsCenOutQaq.rowcount() to 1 step -1
			if lresult_key = dsCenOutQaq.getitemnumber(j,"nresult_key") then dsCenOutQaq.deleterow(j)
		next
		
		for j= dsCenOutHandlingNews.rowcount() to 1 step -1
			if lresult_key = dsCenOutHandlingNews.getitemnumber(j,"nresult_key") then dsCenOutHandlingNews.deleterow(j)
		next
		
		for j= dsCenOutNewsExtra.rowcount() to 1 step -1
			if lresult_key = dsCenOutNewsExtra.getitemnumber(j,"nresult_key") then dsCenOutNewsExtra.deleterow(j)
		next
		
		for j= dsCenOutPax.rowcount() to 1 step -1
			if lresult_key = dsCenOutPax.getitemnumber(j,"nresult_key") then dsCenOutPax.deleterow(j)
		next
		
		for j= uo_generate_meals.dsCenOutMeals.rowcount() to 1 step -1
			if lresult_key = uo_generate_meals.dsCenOutMeals.getitemnumber(j,"nresult_key") then uo_generate_meals.dsCenOutMeals.deleterow(j)
		next

		for j= dsCenOutAllSPML.rowcount() to 1 step -1
			if lresult_key = dsCenOutAllSPML.getitemnumber(j,"nresult_key") then 
				lmaster_key =  dsCenOutAllSPML.getitemnumber(j,"nmaster_key")
				dsCenOutAllSPML.deleterow(j)
				
				for k=dsCenOutAllSPMLDetail.rowcount() to 1 step -1
					if lmaster_key =  dsCenOutAllSPMLDetail.getitemnumber(k,"nmaster_key") then dsCenOutAllSPMLDetail.deleterow(k)
				next

			end if
		next

		// --------------------------------------------------------------------------------------------------------------------
		// 13.11.2015 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die CHECKPOINTS bereinigen
		// --------------------------------------------------------------------------------------------------------------------
		for j= dsCenOutCheckPt.rowcount() to 1 step -1
			if lresult_key = dsCenOutCheckPt.getitemnumber(j,"nresult_key") then dsCenOutCheckPt.deleterow(j)
		next
		
	else	
		DELETE FROM cen_out  
			WHERE ( cen_out.nairline_key = :nairlinekey ) AND  
				( cen_out.nflight_number = :nflightnumber ) AND  
				( cen_out.csuffix = :csuffix ) AND  
				( cen_out.ddeparture = :ddeparture ) AND  
				( cen_out.nleg_number = :nlegnumber ) AND  
				( cen_out.cunit = :cunit )  				  ;
		if sqlca.sqlnrows>0 then
			of_trace("of_update", 1, "Delete Flight because new in DSCENOUT: "+string(nairlinekey)+" "+string(nflightnumber, "000")+csuffix+" "+string(ddeparture, "dd.mm.yyyy")+" Leg "+string(nlegnumber)+" "+cunit)
		end if
	end if
next

of_trace_flight("of_update","CEN_OUT") // 21.06.2012 HR:

If dsCenOut.update() = -1 Then
	lSQLCode 		= dsCenOut.lSQLErrorDBCode
	lSQLRow  		= dsCenOut.lSQLErrorRow
	sSQLErrorText	= dsCenOut.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline + " " + &
							string(dsCenOut.Getitemnumber(lSQLRow,"nflight_number")),&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated flight data to database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(dsCenOut.dataobject + " -> " + string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated flight data to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")

	return False
End if

// --------------------------------------
// Datastore dsCenOutHandling speichern.
// --------------------------------------
of_trace_flight("of_update","CEN_OUT_Handling") // 21.06.2012 HR:

If dsCenOutHandling.update() = -1 Then
	lSQLCode 		= dsCenOutHandling.lSQLErrorDBCode
	lSQLRow  		= dsCenOutHandling.lSQLErrorRow
	sSQLErrorText	= dsCenOutHandling.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated handling data to database, sqlcode " + &
							string(lSQLCode)) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated handling data to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if

// --------------------------------------
// Datastore dsCenOutQaq speichern.
// --------------------------------------
If dsCenOutQaq.update() = -1 Then
	lSQLCode 		= dsCenOutQaq.lSQLErrorDBCode
	lSQLRow  		= dsCenOutQaq.lSQLErrorRow
	sSQLErrorText	= dsCenOutQaq.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated station instruction data to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated station instruction data to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if

// -----------------------------------------
// Datastore dsCenOutHandlingNews speichern.
// -----------------------------------------
If dsCenOutHandlingNews.update() = -1 Then
	lSQLCode 		= dsCenOutHandlingNews.lSQLErrorDBCode
	lSQLRow  		= dsCenOutHandlingNews.lSQLErrorRow
	sSQLErrorText	= dsCenOutHandlingNews.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated newspaper handling to database, sqlcode " + &
							string(lSQLCode)) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated newspaper handling to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if


// -----------------------------------------
// Datastore dsCenOutNewsExtra speichern.
// -----------------------------------------
If dsCenOutNewsExtra.update() = -1 Then
	lSQLCode 		= dsCenOutNewsExtra.lSQLErrorDBCode
	lSQLRow  		= dsCenOutNewsExtra.lSQLErrorRow
	sSQLErrorText	= dsCenOutNewsExtra.sSQLErrorText
	
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated newspaper extra loading to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated newspaper extra loading to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if

// -----------------------------------------
// Default dsCenOutPax speichern.
// -----------------------------------------
of_trace_flight("of_update","CEN_OUT_PAX") // 21.06.2012 HR:
If dsCenOutPax.update() = -1 Then
	lSQLCode 		= dsCenOutPax.lSQLErrorDBCode
	lSQLRow  		= dsCenOutPax.lSQLErrorRow
	sSQLErrorText	= dsCenOutPax.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated aircraft versions data to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated aircraft versions data to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if

// -----------------------------------------
// 23.06.2009 HR
// dsCenOutQP speichern.
// -----------------------------------------
If dsCenOutQP.update() = -1 Then
	lSQLCode 		= dsCenOutQP.lSQLErrorDBCode
	lSQLRow  		= dsCenOutQP.lSQLErrorRow
	sSQLErrorText	= dsCenOutQP.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated query periods to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated  query periods to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
End if

// ---------------------------------------------------------
// 13.06.08, KF
// Vor dem Speichern die Kostenart und das Steuerkennzeichen 
// der einzelnen Mahlzeiten ermitteln
// ---------------------------------------------------------
this.of_get_costtype()
// ---------------------------------------------------------
// dsCenOutMeals speichern (liegt im UserObject)
// ---------------------------------------------------------
of_trace_flight("of_update","CEN_OUT_MEALS") // 21.06.2012 HR:
if uo_generate_meals.uf_write_cen_out_meals() = -1 then
	lSQLCode 		= uo_generate_meals.dsCenOutMeals.lSQLErrorDBCode
	lSQLRow  		= uo_generate_meals.dsCenOutMeals.lSQLErrorRow
	sSQLErrorText	= uo_generate_meals.dsCenOutMeals.sSQLErrorText
	
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated meal loading data to database, sqlcode " + &
							string(lSQLCode) + ", result_key=" + &
							string(uo_generate_meals.dsCenOutMeals.Getitemnumber(lSQLRow,"nresult_key")))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated meal loading data to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	uo_generate_meals.dsCenOutMeals.Reset()
	return false
end if

of_trace_flight("of_update","CEN_OUT_SPML") // 21.06.2012 HR:
if dsCenOutAllSPML.update() = -1 Then
		lSQLCode 		= dsCenOutAllSPML.lSQLErrorDBCode
		lSQLRow  		= dsCenOutAllSPML.lSQLErrorRow
		sSQLErrorText	= dsCenOutAllSPML.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated spmls to database, sqlcode " + &
								string(lSQLCode))
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated  spmls to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")

		return False
else
		if dsCenOutAllSPMLDetail.update() = -1 Then
			lSQLCode 		= dsCenOutAllSPMLDetail.lSQLErrorDBCode
			lSQLRow  		= dsCenOutAllSPMLDetail.lSQLErrorRow
			sSQLErrorText	= dsCenOutAllSPMLDetail.sSQLErrorText

			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
									string(dGenerationDate,s_app.sDateformat),&
									"Can't write generated spmldetails to database, sqlcode " + &
									string(lSQLCode))
			f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
							sunit + "~tCan't write generated  spmldetails to database, " + &
							"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	
			return False
		end if	
End if
of_trace_flight("of_update","CEN_OUT-Packets etc") // 21.06.2012 HR:

// --------------------------------------------------------------------------------------------------------------------
// 04.04.2011 HR: CFS-Packets der Fl$$HEX1$$fc00$$ENDHEX$$ge
// --------------------------------------------------------------------------------------------------------------------
dsCenOutPackets.setfilter("")
dsCenOutPackets.filter()
dsCenOut.setfilter("")
dsCenOut.filter()
if dsCenOutPackets.RowCount()>0 then
	this.of_trace("of_update", 3, "Rows in dsCenOutPackets before flightsearch "+string(dsCenOutPackets.rowcount()))
	for i = dsCenOutPackets.RowCount() to 1 step -1
		 if dsCenOut.find("nresult_key = "+string(dsCenOutPackets.getitemnumber(i,"nresult_key")),1,dsCenOut.Rowcount())<=0 then 
			dsCenOutPackets.DeleteRow(i)
		end if
	next

	if dsCenOutPackets.update() = -1 then
		lSQLCode 		= dsCenOutPackets.lSQLErrorDBCode
		lSQLRow  		= dsCenOutPackets.lSQLErrorRow
		sSQLErrorText	= dsCenOutPackets.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated packets to database, sqlcode " + &
								string(lSQLCode))
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated  packets to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	else
		this.of_trace("of_update", 3, "Rows in dsCenOutPackets: "+string(dsCenOutPackets.rowcount()))
	end if
elseif bCFSAirline then
		this.of_trace("of_update", 3, "Rows in dsCenOutPackets: 0")
END IF

// --------------------------------------------------------------------------------------------------------------------
// 04.04.2011 HR: CFS-LOS-Infos der Fl$$HEX1$$fc00$$ENDHEX$$ge
// --------------------------------------------------------------------------------------------------------------------
dsCenOutLos.setfilter("")
dsCenOutLos.filter()
if dsCenOutLos.RowCount()>0 then
	this.of_trace("of_update", 3, "Rows in dsCenOutLos before flightsearch "+string(dsCenOutLos.rowcount()))
	for i = dsCenOutLos.RowCount() to 1 step -1
		 if dsCenOut.find("nresult_key = "+string(dsCenOutLos.getitemnumber(i,"nresult_key")),1,dsCenOut.Rowcount())<=0 then 
			dsCenOutLos.DeleteRow(i)
		end if
	next

	if dsCenOutLos.update() = -1 then
		lSQLCode 		= dsCenOutLos.lSQLErrorDBCode
		lSQLRow  		= dsCenOutLos.lSQLErrorRow
		sSQLErrorText	= dsCenOutLos.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated los to database, sqlcode " + &
								string(lSQLCode))
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated  los to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	else
		this.of_trace("of_update", 3, "Rows in dsCenOutLos: "+string(dsCenOutLos.rowcount()))	
	end if
elseif bCFSAirline then
		this.of_trace("of_update", 3, "Rows in dsCenOutLos: 0")
end if

// --------------------------------------------------------------------------------------------------------------------
// 22.09.2011 HR: die PPM-Daten speichern
// --------------------------------------------------------------------------------------------------------------------
if dsCenOutPPM.update() = -1 then
	lSQLCode 		= dsCenOutPPM.lSQLErrorDBCode
	lSQLRow  		= dsCenOutPPM.lSQLErrorRow
	sSQLErrorText	= dsCenOutPPM.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated ppm to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated ppm to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
else
	this.of_trace("of_update", 3, "Rows in dsCenOutPPM: "+string(dsCenOutPPM.rowcount()))	
end if

if dsCenOutPPMStowages.update() = -1 then
	lSQLCode 		= dsCenOutPPMStowages.lSQLErrorDBCode
	lSQLRow  		= dsCenOutPPMStowages.lSQLErrorRow
	sSQLErrorText	= dsCenOutPPMStowages.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated ppm-stowages to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated ppm-stowages to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
else
	this.of_trace("of_update", 3, "Rows in dsCenOutPPMStowages: "+string(dsCenOutPPMStowages.rowcount()))	
end if

// --------------------------------------------------------------------------------------------------------------------
// 14.01.2015 HR: Flightchecker
// --------------------------------------------------------------------------------------------------------------------
if dsCenOutCheckPt.update() = -1 then
	lSQLCode 		= dsCenOutCheckPt.lSQLErrorDBCode
	lSQLRow  		= dsCenOutCheckPt.lSQLErrorRow
	sSQLErrorText	= dsCenOutCheckPt.sSQLErrorText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
							string(dGenerationDate,s_app.sDateformat),&
							"Can't write generated checkpt to database, sqlcode " + &
							string(lSQLCode))
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't write generated checkpt to database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	return False
else
	this.of_trace("of_update", 3, "Rows in dsCenOutCheckPt: "+string(dsCenOutCheckPt.rowcount()))	
end if

return True


end function

public function boolean of_update_history ();	long		lSQLCode
	long		lSQLRow 
	long 		i
	string	sTableName,sSQLErrorText
	
// --------------------------------------------
// Datastore dsCenOut (History) speichern.
// --------------------------------------------
	dsCenOut.ResetUpdate()
	sTableName	= dsCenOut.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOut.Rowcount()
		dsCenOut.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOut.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOut.update() = -1 Then
		lSQLCode 		= dsCenOut.lSQLErrorDBCode
		lSQLRow  		= dsCenOut.lSQLErrorRow
		sSQLErrorText	= dsCenOut.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated flight history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOut.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated flight history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOut.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutHandling (History)speichern.
// -----------------------------------------------
	dsCenOutHandling.ResetUpdate()
	//dsCenOutHandling.Sort()
	//dsCenOutHandling.print()
	sTableName	= dsCenOutHandling.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandling.Rowcount()
		dsCenOutHandling.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutHandling.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutHandling.update() = -1 Then
		lSQLCode 		= dsCenOutHandling.lSQLErrorDBCode
		lSQLRow  		= dsCenOutHandling.lSQLErrorRow
		sSQLErrorText	= dsCenOutHandling.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated handling history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutHandling.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated handling history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutHandling.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutQAQ (History)speichern.
// -----------------------------------------------
	dsCenOutQAQ.ResetUpdate()
	sTableName	= dsCenOutQAQ.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutQAQ.Rowcount()
		dsCenOutQAQ.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutQAQ.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutQAQ.update() = -1 Then
		lSQLCode 		= dsCenOutQAQ.lSQLErrorDBCode
		lSQLRow  		= dsCenOutQAQ.lSQLErrorRow
		sSQLErrorText	= dsCenOutQAQ.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated station instruction history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutQAQ.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated station instruction history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutQAQ.Object.DataWindow.Table.UpdateTable = sTableName
	
// -----------------------------------------------
// Datastore dsCenOutNews (History) speichern.
// -----------------------------------------------
	dsCenOutHandlingNews.ResetUpdate()
	sTableName	= dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandlingNews.Rowcount()
		dsCenOutHandlingNews.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutHandlingNews.update() = -1 Then
		lSQLCode 		= dsCenOutHandlingNews.lSQLErrorDBCode
		lSQLRow  		= dsCenOutHandlingNews.lSQLErrorRow
		sSQLErrorText	= dsCenOutHandlingNews.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated newspaper history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated newspaper history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutNewsExtra (History) speichern.
// -----------------------------------------------
	dsCenOutNewsExtra.ResetUpdate()
	sTableName	= dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutNewsExtra.Rowcount()
		dsCenOutNewsExtra.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutNewsExtra.update() = -1 Then
		lSQLCode 		= dsCenOutNewsExtra.lSQLErrorDBCode
		lSQLRow  		= dsCenOutNewsExtra.lSQLErrorRow
		sSQLErrorText	= dsCenOutNewsExtra.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated newspaper extra loading history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated newspaper extra loading history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName

// -----------------------------------------------
// Datastore dsCenOutPax (History) speichern.
// -----------------------------------------------
	dsCenOutPax.ResetUpdate()
	sTableName	= dsCenOutPax.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutPax.Rowcount()
		dsCenOutPax.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	dsCenOutPax.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If dsCenOutPax.update() = -1 Then
		lSQLCode 		= dsCenOutPax.lSQLErrorDBCode
		lSQLRow  		= dsCenOutPax.lSQLErrorRow
		sSQLErrorText	= dsCenOutPax.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated aircraft versions history data to database, sqlcode " + &
								string(lSQLCode)) 
		dsCenOutPax.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated aircraft versions history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		return False
	End if
	dsCenOutPax.Object.DataWindow.Table.UpdateTable = sTableName	
	
// -----------------------------------------------
// Datastore dsCenOutMeals (History) speichern.
// -----------------------------------------------
	uo_generate_meals.dsCenOutMeals.ResetUpdate()
	sTableName	= uo_generate_meals.dsCenOutMeals.Object.DataWindow.Table.UpdateTable
	For i = 1 to uo_generate_meals.dsCenOutMeals.Rowcount()
		uo_generate_meals.dsCenOutMeals.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	
	uo_generate_meals.dsCenOutMeals.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

	If uo_generate_meals.dsCenOutMeals.update() = -1 Then
		lSQLCode 		= uo_generate_meals.dsCenOutMeals.lSQLErrorDBCode
		lSQLRow  		= uo_generate_meals.dsCenOutMeals.lSQLErrorRow
		sSQLErrorText	= uo_generate_meals.dsCenOutMeals.sSQLErrorText
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline, &
								string(dGenerationDate,s_app.sDateformat),&
								"Can't write generated meal history data to database, sqlcode " + &
								string(lSQLCode)) 
		uo_generate_meals.dsCenOutMeals.Object.DataWindow.Table.UpdateTable = sTableName
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't write generated meal history data to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
		// 03.02.05: Reset Datastore muss auch im Fehlerfall passieren!
		uo_generate_meals.dsCenOutMeals.Reset()
		return False
	End if
	uo_generate_meals.dsCenOutMeals.Object.DataWindow.Table.UpdateTable = sTableName	
	uo_generate_meals.dsCenOutMeals.Reset()
		
	return True
end function

public function boolean of_write_cen_out_single_flight (boolean bcitypair);// ------------------------------------------
// Daten in den Datastore dsCenOut schreiben
//
// Fast baugleich zu of_write_cen_out,
// nur um ein paar Felder erweitert ..
// ------------------------------------------
long 		lRow = 0
string 	sSearch
Long  	lSequence

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

dsLocalTimes.Retrieve(sClient,sUnit,lAirlineKey)	
dsLocalTimesFlights.Retrieve(sClient,sUnit,lAirlineKey)	
dsAirlineClasses.Retrieve(lAirlineKey)	

lRow = dsCenOut.insertrow(0)
lSequence = f_Sequence ("seq_cen_out",sqlca)
If lSequence = -1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't get a new sequence : seq_cen_out.")
	return False
End if	
lResultKey	= lSequence
dsCenOut.SetItem(lRow,"NRESULT_KEY",lResultKey)
dsCenOut.SetItem(lRow,"NUSER_MODIFIED",0)
dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY",0)
dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY",0)
dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY_CP",0)
dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY_CP",0)
// -------------------------------------------------
// Flugnummer oder City Pair
// -------------------------------------------------
If bCityPair = True Then
	dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY_CP",lRoutingPlanDetailKey)
	dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY_CP",lRoutingPlanGroupKey)
Else
	dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY",lRoutingPlanDetailKey)
	dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY",lRoutingPlanGroupKey)
End if	

dsCenOut.SetItem(lRow,"DGENERATION_DATE",datetime(dGenerationDate))
dsCenOut.SetItem(lRow,"NROUTINGPLAN_INDEX",lRoutingPlanKey)
dsCenOut.SetItem(lRow,"NAIRLINE_KEY",lAirlineKey)
dsCenOut.SetItem(lRow,"CAIRLINE",sAirline)
dsCenOut.SetItem(lRow,"NFLIGHT_NUMBER",lFlightNumber)
dsCenOut.SetItem(lRow,"CSUFFIX",sSuffix)
dsCenOut.SetItem(lRow,"DDEPARTURE",DateTime(dNewGenerationDate,Time("00:00")))
dsCenOut.SetItem(lRow,"CDEPARTURE_TIME",sDepartureTime)

//03.09.07 DB: Erweiterung der CEN_OUT Struktur
dsCenOut.SetItem(lRow,"CAIRLINE_ORIG",sAirline)
dsCenOut.SetItem(lRow,"NFLIGHT_NUMBER_ORIG",lFlightNumber)
dsCenOut.SetItem(lRow,"CSUFFIX_ORIG",sSuffix)
dsCenOut.SetItem(lRow,"DDEPARTURE_ORIG",DateTime(dNewGenerationDate,Time("00:00")))
dsCenOut.SetItem(lRow,"CDEPARTURE_TIME_ORIG",sDepartureTime)

dsCenOut.SetItem(lRow,"CRAMP_TIME",sRampTime)
dsCenOut.SetItem(lRow,"CKITCHEN_TIME",sKitchenTime)
dsCenOut.SetItem(lRow,"NAIRCRAFT_KEY",lAircraftKey)
dsCenOut.SetItem(lRow,"CACTYPE",sACType)
dsCenOut.SetItem(lRow,"NAIRLINE_OWNER_KEY",lOwnerKey)
dsCenOut.SetItem(lRow,"CAIRLINE_OWNER",sOwner)
dsCenOut.SetItem(lRow,"CGALLEYVERSION",sGalleyVersion)
dsCenOut.SetItem(lRow,"CCONFIGURATION",sACConfiguration)
dsCenOut.SetItem(lRow,"NLEG_NUMBER",lLegNumber)
dsCenOut.SetItem(lRow,"CUNIT",sLoadingUnit) 
dsCenOut.SetItem(lRow,"CCLIENT",sClient)
dsCenOut.SetItem(lRow,"NTLC_FROM",lTlcFrom)
dsCenOut.SetItem(lRow,"NTLC_TO",lTlcTo)
dsCenOut.SetItem(lRow,"CTLC_FROM",sTLCFrom)
dsCenOut.SetItem(lRow,"CTLC_TO",sTLCTo)
dsCenOut.SetItem(lRow,"CARRIVAL_TIME",sArrivalTime)
dsCenOut.SetItem(lRow,"CBLOCK_TIME",sBlockTime)
dsCenOut.SetItem(lRow,"NCUSTOMER_KEY",lCustomerKey)
dsCenOut.SetItem(lRow,"CCOUNTRY_FROM",sCountryFrom)
dsCenOut.SetItem(lRow,"CCOUNTRY_TO",sCountryTo)
dsCenOut.SetItem(lRow,"CTRAFFIC_AREA",sTrafficArea)
dsCenOut.SetItem(lRow,"CTRAFFIC_AREA_SHORT",sTrafficAreaShort)



dsCenOut.SetItem(lRow,"NHANDLING_TYPE_KEY",lHandlingTypeKey)
dsCenOut.SetItem(lRow,"CHANDLING_TYPE_TEXT",sHandlingShortText)
dsCenOut.SetItem(lRow,"CHANDLING_TYPE_DESCRIPTION",sHandlingLongText)

dsCenOut.SetItem(lRow,"NROUTING_ID",lRoutingID)
dsCenOut.SetItem(lRow,"CROUTING",sRoutingShortText)
dsCenOut.SetItem(lRow,"CROUTING_TEXT",sRoutingLongText)
dsCenOut.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
dsCenOut.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
dsCenOut.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
dsCenOut.SetItem(lRow,"NTRANSACTION",lTransActionKey)
dsCenOut.SetItem(lRow,"nversiongroupkey",lVersionGroupKey)
dsCenOut.SetItem(lRow,"nquery",lFlightDataQuery)
dsCenOut.SetItem(lRow,"DORIGINAL_DEPARTURE",DateTime(dNewGenerationDate,Time("00:00")))
dsCenOut.SetItem(lRow,"ccustomer",sCustomer)
dsCenOut.SetItem(lRow,"nairline_type",iAirlineType)
dsCenOut.SetItem(lRow,"nmanual_input",1)
// ----------------------------------------------------------
// EG-Erstattung (Refunding)
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"nrefund",iRefund)

// ----------------------------------------------------------
// Update Tag 7
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"cbox_from",sBoxFrom)
dsCenOut.SetItem(lRow,"cbox_to",sBoxTo)
dsCenOut.SetItem(lRow,"nstatus_update7",iStatusUpdate7)

// ----------------------------------------------------------
// Der neue Flug-Status: 
// Zun$$HEX1$$e400$$ENDHEX$$chst 0 = "Scheduled"
// Sp$$HEX1$$e400$$ENDHEX$$ter auch als Flag f$$HEX1$$fc00$$ENDHEX$$r "Cancelled" oder "OnRequest"
// ----------------------------------------------------------
if sHandlingShortText = "REQ" then
	dsCenOut.SetItem(lRow,"nflight_status",2)
else
	dsCenOut.SetItem(lRow,"nflight_status",0)
end if

// ----------------------------------------------------------
// Leg-Identifier und Bulk-Identifier
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"nleg_ident",iLegIdentifier)
dsCenOut.SetItem(lRow,"nbulk_ident",iBulkIdentifier)

// ----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckflugdatum (22.04.05)
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"dreturn_date",DateTime(dNewGenerationDate,Time("00:00")))

// ----------------------------------------------------------
// Belegnummer entspr. SEQ_CEN_OUT_NBILLING_KEY (13.05.05)
// ----------------------------------------------------------
lBillingKey = f_Sequence("SEQ_CEN_OUT_NBILLING_KEY",sqlca)
If lBillingKey = -1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat), &
							"Can't get a new sequence : SEQ_CEN_OUT_NBILLING_KEY.")
	return False
End if
dsCenOut.SetItem(lRow,"nbilling_key",lBillingKey)

// ----------------------------------------------------------
// 28.04.2009 Default OP Code
// ----------------------------------------------------------
If of_Get_OPCode( lairlinekey ) Then
	dsCenOut.SetItem(lRow,"nopcode_key", lopcode_key )
	dsCenOut.SetItem(lRow,"copcode", sopcode )
End If

// ----------------------------------------------------------
// 28.01.2016 Default OP Code per Handling Type
// ----------------------------------------------------------
If of_get_opcode_per_handling( lHandlingTypeKey ) Then
	dsCenOut.SetItem(lRow,"nopcode_key", lopcode_key )
	dsCenOut.SetItem(lRow,"copcode", sopcode )
End If

// --------------------------------------------------------------------------------------------------------------------
// 05.04.2016 HR: CBASE-BRU-CR-2015-007 Wir schreiben den Wert in die CEN_OUT auch bei manuell angelegenten Fl$$HEX1$$fc00$$ENDHEX$$ge
// --------------------------------------------------------------------------------------------------------------------
dsCenOut.SetItem(lRow,"cHeader2", is_CADDITIONAL)

//------------------------------------------------------------------------------------------------------------------------
//11.05.2016: MB: NTB-Schalter auch bei manuell aufgenommen Fl$$HEX1$$fc00$$ENDHEX$$gen eintragen
//-------------------------------------------------------------------------------------------------------------------------
dsCenOut.SetItem(lRow,"ntb", ii_trainbusiness)
return True

end function

public function boolean of_delete_messages ();// -----------------------------------------------------
// 120: L$$HEX1$$f600$$ENDHEX$$schen der $$HEX1$$c400$$ENDHEX$$nderungsmittteilungen 
// -----------------------------------------------------
long		lSQLCode
long		lSQLRow 
long		i
string	sSQLErrorText
long		lCounter

lJobActions		= 0
// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if

// -----------------------------------------------------------------
// Ganz neue Methode: ESQL
// -----------------------------------------------------------------
//select count(*)
//  into :lJobActions
//  from loc_received
// where ntransaction in
//	(select ntransaction
//	  from cen_out_changes
//	 where nresult_key in
//			 (select nresult_key
//				 from cen_out_history
//				where ddeparture 	  <= :dGenerationdate
//				  and cclient			= :sClient
//				  and cunit 			= :sUnit
//				  and nairline_key	= :lAirlineKey
//			  )
//	)
// using sqlca;

// 08.12.2009 HR: SELECT wegen langl$$HEX1$$e400$$ENDHEX$$ufer ge$$HEX1$$e400$$ENDHEX$$ndert

 SELECT count(*)  
 into :lJobActions
    FROM loc_received  
   WHERE ( loc_received.nresult_key in (select nresult_key from cen_out_history 
													where	ddeparture       <= :dGenerationdate
																and cclient            = :sClient
																and cunit             = :sUnit
																and nairline_key    = :lAirlineKey))
	using sqlca;

if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't count messages in database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't count messages in database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if

//delete
//  from loc_received
// where ntransaction in
//	(select ntransaction
//	  from cen_out_changes
//	 where nresult_key in
//		 (select nresult_key
//			 from cen_out_history
//			where ddeparture 	  <= :dGenerationdate
//			  and cclient			= :sClient
//			  and cunit 			= :sUnit
//			  and nairline_key	= :lAirlineKey
//		  )
//	)
// using sqlca;

    delete
	 FROM loc_received  
   WHERE ( loc_received.nresult_key in (select nresult_key from cen_out_history 
													where	ddeparture       <= :dGenerationdate
																and cclient            = :sClient
																and cunit             = :sUnit
																and nairline_key    = :lAirlineKey))
	using sqlca;

if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't delete messages from database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't delete messages from database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if
// -----------------------------------------------------------------
// SYS-Explosion kann auch raus
// 07.09.2012 HR: Nur abgeschlossene Jobs l$$HEX1$$f600$$ENDHEX$$schen
// 14.03.2014 HR: Nur von Fl$$HEX1$$fc00$$ENDHEX$$gen, die mindestens vor x Tage abgeschlossen wurden
// -----------------------------------------------------------------
select count(*)
  into :lCounter
  from sys_explosion
 where nprocess_status >1 and
 		  dstop_computing < :dGenerationdate and
 		  nresult_key in
	 (select nresult_key
		 from cen_out_history
		where ddeparture 	  <= :dGenerationdate
		  and cclient			= :sClient
		  and cunit 			= :sUnit
		  and nairline_key	= :lAirlineKey
	  )
 using sqlca;

if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't count explosion jobs in database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't count explosion jobs in database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if

delete
  from sys_explosion
 where nprocess_status >1 and
 		  dstop_computing < :dGenerationdate and
 		 nresult_key in
	 (select nresult_key
		 from cen_out_history
		where ddeparture 	  <= :dGenerationdate
		  and cclient			= :sClient
		  and cunit 			= :sUnit
		  and nairline_key	= :lAirlineKey
	  )
 using sqlca;

if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't delete explosion jobs from database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't delete explosion jobs from database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if
// -----------------------------------------------------------------
// Flight-Pricer kann auch raus
// -----------------------------------------------------------------
// 04.06.2012 HR: Ausgelagert in CBASE_CENTRAL 
/*
select count(*)
  into :lCounter
  from sys_flight_pricer
 where dcreated < :dGenerationdate;
 
if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't count pricing jobs in database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't count pricing jobs in database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if

delete
  from sys_flight_pricer
 where dcreated < :dGenerationdate;

if sqlca.sqlcode <> 0 then
	lSQLCode 		= sqlca.SQLDBCode
	sSQLErrorText	= sqlca.SQLErrText
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"Can't delete pricing jobs from database, sqlcode " + &
							string(lSQLCode) ) 
	f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
					sunit + "~tCan't delete pricing jobs from database, " + &
					"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")
	rollback using sqlca;
	return False
end if
*/
// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + &
							" seconds. Messages: " + string(lJobActions) + ", Explosions: " + string(lCounter)) 
	commit using sqlca;
	return True
End if


return True

end function

public function boolean of_generate_handling_one (long lcenoutrow);// ---------------------------------------------------------------
// Loadinglist, Supplementloading List ermitteln
// ---------------------------------------------------------------
long 			lRow, i, j, lHandling_Key, lDebug, lNewAccountKey, lFound
datastore 	lds_Handling
string			sFilter, sGetAccount, sKVA

// -------------------------------------------------
// Es wird erstmal gel$$HEX1$$f600$$ENDHEX$$scht
// 25.09.06 aber nur wenn keine manuelle Eingabe erfolgt ist
// -------------------------------------------------
If bDelete = True Then
//	delete from cen_out_handling where nresult_key = :lResultKey
//	and nmanual_input <> 1;
	delete from cen_out_handling where nresult_key = :lResultKey;
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	
End if	

// ---------------------------------------------------------------
// Keine Basic Loadinglist f$$HEX1$$fc00$$ENDHEX$$r Abfertigung Anlieferung
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "DLV" then
	iDelivery = 1
	// dsCenOut.SetItem(lCenOutRow, "nflight_status", 2)
	return true
end if

// ---------------------------------------------------------------
// Keine Basic Loadinglist f$$HEX1$$fc00$$ENDHEX$$r Request
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "REQ" then
	iDelivery = 1
	dsCenOut.SetItem(lCenOutRow, "nflight_status", 2)
	return true
end if

// ---------------------------------------------------------------
// Keine Basic Loadinglist f$$HEX1$$fc00$$ENDHEX$$r Abfertigung SPC
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "SPC" then
	iDelivery = 1
	// dsCenOut.SetItem(lCenOutRow, "nflight_status", 2)
	return true
end if

// ---------------------------------------------------------------
//  Keine Basic Loadinglist f$$HEX1$$fc00$$ENDHEX$$r Abfertigung INT CBASE-BRU-CR-2015-014
// ---------------------------------------------------------------
if dsCenOut.GetItemString(lcenoutrow,"chandling_type_text") = "INT" then
	return true
end if

// ---------------------------------------------------------------
// Flugnummer oder City Pair, Mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
bSearchBackWards = False
lds_Handling = dsHandlingObjects

lRow = lds_Handling.find("nhandling_id = 1",1,lds_Handling.Rowcount())

If lRow <= 0 Then
	lds_Handling = dsHandlingObjects_cp
	lRow = lds_Handling.find("nhandling_id = 1",1,lds_Handling.Rowcount())
End if	

// ---------------------------------------------------------------
// Keine Basic Loadinglist, bei Leg 1 ist das ein Fehler!
// F$$HEX1$$fc00$$ENDHEX$$r Abfertigung Anlieferung ist das OK!
// Ab Leg 2 m$$HEX1$$fc00$$ENDHEX$$ssen wir die vorhergehenden Legs $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen.
// ---------------------------------------------------------------

If lRow <= 0 Then 

	If lLegNumber = 1 Then
		// Pr$$HEX1$$fc00$$ENDHEX$$fung Status REQ (OnRequest) / CNX: Falls ja, dann keine Fehlermeldung
		if dsCenOut.GetItemNumber(lcenoutrow,"nflight_status") = 0 then
			return false
		else
			// Flug ist/war CNX oder REQ
			return true
		end if
	Else
		// ---------------------------------------------------------------
		// Ok, nun kommt der Tanz in dem die Legs r$$HEX1$$fc00$$ENDHEX$$ckw$$HEX1$$e400$$ENDHEX$$rts nach der Grundbeladung abgesucht werden. Erstmal ein merker
		// ---------------------------------------------------------------
		bSearchBackWards = True
		return True
	End if
End if	

// ----------------------------------------------------------------------
// Alle zugeordneten Handlingobjekte auf die momentane Abfertigungsart durchsuchen. Befindet sich kein Eintrag in eine der Objekte wird
// die ABART auf den Default aus der Beladedefinition gesetzt
// ----------------------------------------------------------------------
Integer 	iFoundHandling
Long 		lResultKeyToFind
Long 		lCacheHandlingTypeKey

iFoundHandling = 0

For i = 1 to lds_Handling.Rowcount()
	lHandling_Key 	= lds_Handling.Getitemnumber(i,"nhandling_key")
	lHandlingKey	= lHandling_Key
	// ----------------------------------------------------
	// Retrieve der Details des Handlingobjekts
	// ----------------------------------------------------
	dsHandlingDetail.Retrieve(lHandling_Key,dNewGenerationDate,lAircraftKey,sDepartureTime)
	
	sFilter = "nhandling_type_key = " + string(lHandlingTypeKey)
		
	dsHandlingDetail.SetFilter(sFilter)
	dsHandlingDetail.Filter()
	
	if dsHandlingDetail.RowCount() > 0 then
		iFoundHandling = 1
		exit
	end if
		
Next

// ------------------------------------------------------
// In keinem der Objekte befindet sich eine Zeile mit der aktuellen ABART, dann den Default setzten 
// ------------------------------------------------------
if iFoundHandling = 0 then
	
	// ---------------------------------------------------
	// 06.09.2007, KF
	// Abfrage vor die Verarbeitung der Handlings gezogen
	// ---------------------------------------------------
	// 26.04.2007, KF
	// Sollte f$$HEX1$$fc00$$ENDHEX$$r die Abfertigungsart keine Beladung definiert sein, dann kann das den Grung haben, dass
	// die Funktion of_update7() eine Abfertigungsart zugespielt hat, f$$HEX1$$fc00$$ENDHEX$$r die jetzt keine Standardbeladung 
	// mehr definiert ist.
	// Deshalb den Filter nochmal mit der Abfertigung aus der Beladedefinition setzen.
	// ---------------------------------------------------
	lResultKeyToFind = dsCenOut.GetItemNumber(lcenoutrow,"nresult_key")
	
	lFound = dsHandlingTypeCache.Find("nresult_key=" + string(lResultKeyToFind), 1, dsHandlingTypeCache.RowCount())
	
	if lFound > 0 then
		
		// Nur neu filtern, wenn es eine andere ABART ist
		lCacheHandlingTypeKey = dsHandlingTypeCache.GetItemNumber(lFound, "nhandling_type_key")
		
		if lCacheHandlingTypeKey <> lHandlingTypeKey then
			
			lHandlingTypeKey = dsHandlingTypeCache.GetItemNumber(lFound, "nhandling_type_key")
			dsCenOut.SetItem(lcenoutrow,"nhandling_type_key", lHandlingTypeKey)
			dsCenOut.SetItem(lcenoutrow,"chandling_type_text", dsHandlingTypeCache.GetItemString(lFound, "chandling_type_text"))
			dsCenOut.SetItem(lcenoutrow,"chandling_type_description", dsHandlingTypeCache.GetItemString(lFound, "chandling_type_description"))
			
			// ----------------------------------------------------------
			// 09.07.2007, DB
			// Wenn der neue Flugstatus 2, also "REQ" ist kann er so bleiben, ansonsten muss der Status auf 0 gesetzt werden.
			// ----------------------------------------------------------
			if dsHandlingTypeCache.GetItemString(lFound, "chandling_type_text") = "REQ" then
				dsCenOut.SetItem(lCenOutRow, "nflight_status", 2)
			else
				dsCenOut.SetItem(lCenOutRow, "nflight_status", 0)
			end if
				
			// 23.06.2014 HR: CBASE-NAM-CR-14019: $$HEX1$$dc00$$ENDHEX$$bernahme Abart in einen neue Funktion ausgelagert
			of_change_handling(dsCenOut.GetItemNumber(lcenoutrow, "nresult_key_group"), lHandlingTypeKey, dsHandlingTypeCache.GetItemString(lFound, "chandling_type_text"), dsHandlingTypeCache.GetItemString(lFound, "chandling_type_description"))
		end if 
	end if
end if

// -----------------------------------------------------------------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den  nhandling_key (der Key des Handlig Objektes)
// -----------------------------------------------------------------------------------------------------------------------
For i = 1 to lds_Handling.Rowcount()
	setnull(lAccountKey)
	setnull(lDefaultAccountKey)
	lDefaultAccountKey	= lds_Handling.Getitemnumber(i,"naccount_key")
	lHandlingId				= lds_Handling.Getitemnumber(i,"nhandling_id")
	sHandlingObjectText 	= lds_Handling.Getitemstring(i,"ctext")
	
	// Loadinglist 
	If lHandlingId <> 1  Then continue
	
	lHandling_Key 	= lds_Handling.Getitemnumber(i,"nhandling_key")
	lHandlingKey	= lHandling_Key

	// Nun der retrieve auf das Handling Objekt
	dsHandlingDetail.Retrieve(lHandling_Key,dNewGenerationDate,lAircraftKey,sDepartureTime)
	
	// und nun ein Filter auf die Abfertigungsart
	sFilter = "nhandling_type_key = " + string(lHandlingTypeKey)
	
	dsHandlingDetail.SetFilter(sFilter)
	dsHandlingDetail.Filter()

	lDebug = dsHandlingDetail.RowCount()
	
	// ---------------------------------------------------------------
	// Achtung: Legs > 1 d$$HEX1$$fc00$$ENDHEX$$rfen keine ZBL bekommen
	// ---------------------------------------------------------------
	if dsHandlingDetail.Rowcount() > 0 and lLegNumber > 1 then
		return true
	end if
	
	For j = 1 to dsHandlingDetail.Rowcount()
		sLoadinglist 						= dsHandlingDetail.Getitemstring(j,"cloadinglist")
		iPrio								= dsHandlingDetail.Getitemnumber(j,"nprio")
		lAccountKey						= dsHandlingDetail.Getitemnumber(j,"naccount_key")
		is_AdditionalAccountCode 	= dsHandlingDetail.Getitemstring(j,"cadditional_account") // 08.09.2011 HR:

		// --------------------------------------------------------------------------------------------------------------------
		// 17.06.2013 HR: CBASE-CR-NAM-12070B
		//                        SSL und ZBL nach Packages oder LOS zuordnen
		// --------------------------------------------------------------------------------------------------------------------
		if  lds_Handling.Getitemnumber(i,"nuse_customer_packets") = 1 then
			if of_generate_handling_paclos(lds_Handling, i, lcenoutrow, 1) = 0 then continue
		end if

		// Die 1. Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste und somit der AC-Typ steuert den Kunden also cen_out.ncustomer_key und cen_out.ccustomer
		if j = 1 then
			lCustomerKey		= dsHandlingDetail.Getitemnumber(j,"ncustomer_key")
			sCustomer 			= dsHandlingDetail.Getitemstring(j,"cen_airlines_cairline")
			sGetAccount			= of_get_account_code(lAccountKey)
			
			dsCenOut.SetItem(lcenoutrow,"NCUSTOMER_KEY",lCustomerKey)
			dsCenOut.SetItem(lcenoutrow,"ccustomer",sCustomer)
			dsCenOut.SetItem(lcenoutrow,"naccount_key",lAccountKey)
			dsCenOut.SetItem(lcenoutrow,"caccount",sGetAccount)
		end if
		// -------------------------------------------------------------------------
		// Falls 10-stelliger VonAn f$$HEX1$$fc00$$ENDHEX$$r den Kopf vorgesehen war, dann in cen_out_handling "00" setzen 
		// 19.01.2007 - ZCF4-FM-1047, KF
		// Pr$$HEX1$$fc00$$ENDHEX$$fung erweitert, es werden nur noch die KVA's ersetzt, die keine Platzhalter (YYYY oder XXXX) haben
		// -------------------------------------------------------------------------
		
		if len(trim(sGetAccount)) = 10 and Pos(sGetAccount, "YYYY") = 0 and Pos(sGetAccount, "XXXX") = 0 then
			sKVA = mid(sGetAccount,5,2)
			if sKVA = "00" then
				// Fall A: VonAn stammt von einem 00er KVA
				lNewAccountKey = of_get_account_key(lCustomerKey,"00")
				if lNewAccountKey > 0 then
					// Falls Account "00" f$$HEX1$$fc00$$ENDHEX$$r diese Airline gefunden wurde, dann mit dem neuen Key weiterarbeiten
					lAccountKey = lNewAccountKey
				end if
			else
				// Fall B: VonAn stammt nicht von einem 00er KVA
				lNewAccountKey = of_get_account_key(lCustomerKey,sKVA)
				if lNewAccountKey > 0 then
					// Falls KVA f$$HEX1$$fc00$$ENDHEX$$r diese Airline gefunden wurde, dann mit dem neuen Key weiterarbeiten
					lAccountKey = lNewAccountKey
				else
					// KVA ung$$HEX1$$fc00$$ENDHEX$$ltig, dann nehmen wir "00"
					lNewAccountKey = of_get_account_key(lCustomerKey,"00")
					if lNewAccountKey > 0 then
						// Falls KVA f$$HEX1$$fc00$$ENDHEX$$r diese Airline gefunden wurde, dann mit dem neuen Key weiterarbeiten
						lAccountKey = lNewAccountKey
					end if
				end if
			end if
		end if
			
		If not of_write_cen_out_handling() Then
			return False
		End if	
	Next	
Next	

// 26.01.05: Merker
// W$$HEX1$$e400$$ENDHEX$$re hier nicht die gute Gelegenheit der Pr$$HEX1$$fc00$$ENDHEX$$fung, ob ein Flug SSLs hat oder nicht? REQ-Status nicht vergessen!
if dsCenOutHandling.RowCount() = 0 then
	if lLegNumber = 1 then
		// Pr$$HEX1$$fc00$$ENDHEX$$fung Status REQ (OnRequest)/ CNX: Falls ja, dann keine Fehlermeldung
		if dsCenOut.GetItemNumber(lcenoutrow,"nflight_status") = 0 then
			return false
		else
			return true
		end if
	end if
end if

Return True

end function

public function long of_search_flightnumber (long lroutingplanrow);// ----------------------------------------------------------------------
// sucht eine Flugnummernbeladung im Flugplan
// ----------------------------------------------------------------------
long 		lScheduleRow,lRow
string 	sSearch
Integer	i

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

If Len(Trim(sSuffix)) = 0 Then
	sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
				 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto) +&
				 " and (isnull(csuffix) or trim(csuffix)='')"		// 05.05.2011 HR: Suffix muss auf LEER gepr$$HEX1$$fc00$$ENDHEX$$ft werden
				 
Else
	sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
				 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto) + &
				 " and csuffix = '" + sSuffix + "'"
End if

if lFlightNumber= 2741 then
	lFlightNumber= 2741
end if

// 28.09.2009 HR: Falsche Zeiten
if cdeparture_vorleg >" " then
	sSearch += " and cdeparture_time > '"+cdeparture_vorleg+"'"
end if

lScheduleRow = dsGenerateSchedule.find(sSearch,1,dsGenerateSchedule.Rowcount())
// ----------------------------------------------------------------------
// Flug wurde nicht gefunden, kann demnach nur ein Weiter oder R$$HEX1$$fc00$$ENDHEX$$ckflug
// sein, der nicht am selben Tag geht !
// ----------------------------------------------------------------------
If lScheduleRow <= 0 Then 
	if bCharter then
		For i = 1 to 1 
			// ------------------------------------------
			// Wir schauen maximal 1 Tag in die Zukunft
			// ------------------------------------------
			lScheduleRow = of_search_returnflight(i)
			If lScheduleRow > 0 Then  
				iOffset_RF = i
				of_set_cen_out_return_flight(lScheduleRow,lRoutingPlanRow)
				of_write_cen_out(False)
				return lScheduleRow
			End if	
		Next
	else
		For i = 1 to 3 
			// ------------------------------------------
			// Wir schauen maximal 3 Tage in die Zukunft
			// ------------------------------------------
			lScheduleRow = of_search_returnflight(i)
			If lScheduleRow > 0 Then  
				iOffset_RF = i
				of_set_cen_out_return_flight(lScheduleRow,lRoutingPlanRow)
				of_write_cen_out(False)
				return lScheduleRow
			End if	
		Next
	end if
	If bDebugCenOut = True Then
		lrow = dscenOutDebug.Insertrow(0)
		dscenOutDebug.SetItem(lRow,"CAIRLINE",sAirline)
		dscenOutDebug.SetItem(lRow,"nflightnumber",lFlightNumber)
		dscenOutDebug.SetItem(lRow,"ddeparture",dGenerationDate)
		dscenOutDebug.SetItem(lRow,"cdeparture_time",sDepartureTime)
		dscenOutDebug.SetItem(lRow,"nleg_number",lLegNumber)
		dscenOutDebug.SetItem(lRow,"cfom",sTLCFrom)
		dscenOutDebug.SetItem(lRow,"cto",sTLCTo)
		dscenOutDebug.SetItem(lRow,"noffset",99)
		dscenOutDebug.SetItem(lRow,"sunit",sLoadingUnit)
	End if	

Else
	of_set_cen_out(lScheduleRow,lRoutingPlanRow)
	of_write_cen_out(False)
	return lScheduleRow
End if

return lScheduleRow
end function

public function long of_create_sort (long lseekrow);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_create_sort (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long lseekrow
// --------------------------------------------------------------------------------------------------------------------
// Return: long
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       	Version 	Autor          		Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  ??	   			1.0      	??   				Erstellung
//  21.07.2011	1.0      	H.Rothenbach   	Umstellung auf NRESULT_KEY_GROUP
//
// --------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bertr$$HEX1$$e400$$ENDHEX$$gt die Departure Zeit und Interne Zeiten vom ersten Leg
// ----------------------------------------------------------------
integer 		i

For i = lSeekRow to dsCenOut.Rowcount()

	// --------------------------------------------------------------------------------------------------------------------
	// 21.07.2011 HR: Nur wenn Leg zur aktuellen Fluggruppe geh$$HEX1$$f600$$ENDHEX$$rt, dann $$HEX1$$e400$$ENDHEX$$ndern wir die Zeiten
	// --------------------------------------------------------------------------------------------------------------------
	if   dsCenOut.GetitemNumber(lSeekRow,"nresult_key_group")  = dsCenOut.GetitemNumber(i,"nresult_key_group") then
		dsCenOut.SetItem(i,"CDEPARTURE_TIME",sFirstLegTime)
		dsCenOut.SetItem(i,"DDEPARTURE",dtFirstLegDeparture)
		dsCenOut.SetItem(i,"CSORT_TIME",sFirstLegTime)
		dsCenOut.SetItem(i,"CRAMP_TIME",sFirstLegRampTime)
		dsCenOut.SetItem(i,"CKITCHEN_TIME",sFirstLegKitchenTime)
		dsCenOut.SetItem(i,"NPARENT_TLC_FROM",lFirstLegTLC_From)
	end if
Next	
	
return 0


end function

public function boolean of_set_cen_out_return_flight (long lschedulerow, long lroutingplanrow);// -----------------------------------------------
// Daten f$$HEX1$$fc00$$ENDHEX$$r den Datastore dsCenOut vorbereiten
// -----------------------------------------------
long					lDeparture_Faktor
long					lRow
string					sClassName[]
integer				iSeatVersion[]
integer				iForecast[]
integer				iClassNumber[]
integer				iQueryID, i
uo_get_aircraft 	uo_get_ac
string					sOwnerForeign
string					sACTypeForeign
string					sDepartureTimeForeign
integer				irc

sVersionString 	= ""	
lVersionGroupKey 	= 0
lFlightDataQuery	= 0
// -----------------------------------------------
// Daten aus dem Flugplan
// -----------------------------------------------
lTlcFrom						= dsReturnFlightSchedule.GetitemNumber(lschedulerow,"ntlc_from")
lTlcTo							= dsReturnFlightSchedule.GetitemNumber(lschedulerow,"ntlc_to")
sTLCFrom					= f_check_three_letter_code_id(lTlcFrom)
sTLCTo						= f_check_three_letter_code_id(lTlcTo)
// ------------------------------------------------------------
// GMT oder Local Time spielt bei R$$HEX1$$fc00$$ENDHEX$$ckfl$$HEX1$$fc00$$ENDHEX$$gen keine 
// Rolle da diese an das erst beladene Leg gekoppelt werden
// Anm. 15.02.: Diese Aussage ist falsch!
// -------------------------------------------------------------
// alt:
//	sDepartureTime				= dsGenerateSchedule.GetitemString(lschedulerow,"cdeparture_time")
//	dNewGenerationDate		= dGenerationDate

// 24.03.2009 HR: AUS IFMS-Generierung $$HEX1$$fc00$$ENDHEX$$bernommen
nDepartureFaktor				= dsReturnFlightSchedule.GetitemDecimal(lschedulerow,"ndeparture_faktor") // TBR 04.11.2008
nArrivalFaktor					= dsReturnFlightSchedule.GetitemDecimal(lschedulerow,"narrival_faktor") //HR 29.09.2009
sDepartureTime				= dsReturnFlightSchedule.GetitemString(lschedulerow,"cdeparture_time")
dNewGenerationDate			= relativedate(dGenerationDate, iOffset_RF)
sArrivalTime					= dsReturnFlightSchedule.GetitemString(lschedulerow,"carrival_time")

If lFlightScheduleTime <> 1 Then
	// --------------------------------------------------------------------------------------------------------------------
	// 19.02.2016 HR: CBASE-DE-CR-2015-059 neue Funktion zur Umrechnung
	// --------------------------------------------------------------------------------------------------------------------
	uoConvUtcLoc.uf_utc2loc(sTLCFrom, dNewGenerationDate, sDepartureTime, nDepartureFaktor)
	
	if sDepartureTime < sArrivalTime then
		i = 1
	else
		i = 0
	end if
	
	sDepartureTime			= uoConvUtcLoc.is_new_time
	dNewGenerationDate		= uoConvUtcLoc.id_new_date
	nDepartureFaktor			= uoConvUtcLoc.id_new_offset

	uoConvUtcLoc.uf_utc2loc(sTLCTo,  relativedate(dGenerationDate, iOffset_RF + i), sArrivalTime, nArrivalFaktor)
	sArrivalTime				=  uoConvUtcLoc.is_new_time
End if

//
// Neu: Original-Abflugzeit aufheben
//
sOriginalDeparture			= sDepartureTime

sBlockTime 					= dsReturnFlightSchedule.GetitemString(lschedulerow,"cblock_time")
lAircraftKey					= dsReturnFlightSchedule.GetitemNumber(lschedulerow,"naircraft_key")
sACType						= dsReturnFlightSchedule.GetitemString(lschedulerow,"cactype")
sGalleyVersion				= dsReturnFlightSchedule.GetitemString(lschedulerow,"cgalleyversion")
lOwnerKey					= dsReturnFlightSchedule.GetitemNumber(lschedulerow,"nairline_owner_key")
sOwner						= dsReturnFlightSchedule.GetitemString(lschedulerow,"cen_airlines_cairline")
lFlightNumber 				= dsReturnFlightSchedule.Getitemnumber(lschedulerow,"nflight_number")
sSuffix						= dsReturnFlightSchedule.Getitemstring(lschedulerow,"csuffix")	
If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
sCountryFrom 				= dsReturnFlightSchedule.GetitemString(lschedulerow,"ccountry_from")
sCountryTo					= dsReturnFlightSchedule.GetitemString(lschedulerow,"ccountry_to")

If len(sCountryFrom) <= 0 or isnull(sCountryFrom) Then
	// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
	//sCountryFrom 	= "Nil"
	sCountryFrom 	= " "
End if
If len(sCountryTo) <= 0 or isnull(sCountryTo) Then
	// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
	//sCountryTo 	= "Nil"
	sCountryTo 	= " "
End if
// ------------------------------------------
// Daten aus dem Routingplan
// ------------------------------------------
lRoutingPlanKey			= lRoutingPlanKey
lRoutingPlanDetailKey		= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nroutingdetail_key")
lRoutingPlanGroupKey		= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nrouting_group_key")
lAirlineKey					= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nairline_key")
sAirline						= dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"cairline")
lLegNumber					= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nleg_number")
lCustomerKey				= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ncustomer_key")
lHandlingTypeKey			= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nhandling_type_key")
sHandlingShortText		= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_ctext")
sHandlingLongText			= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_cdescription")
lRoutingID					= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nrouting_id")
sRoutingShortText			= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"crouting")
sRoutingLongText			= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"crouting_text")
iAirlineType					= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"cen_airlines_nairline_type")
ilegidentifier					= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nleg_ident")

// --------------------------------------------------------------------------------------------------------------------
// 15.10.2010 HR: Rampenboxen vorbelegen bzw. zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// --------------------------------------------------------------------------------------------------------------------
sBoxFrom				= ""
sBoxTo					= ""

// Nur die Hinfl$$HEX1$$fc00$$ENDHEX$$ge bekommen Bulk-Identifier = 0
// alt: if ilegidentifier = 1 or ilegidentifier = 2 then
if ilegidentifier = 1 then
	ibulkidentifier = 0
else
	ibulkidentifier = 1
end if
// ------------------------------------------
// Kunde zun$$HEX1$$e400$$ENDHEX$$chst aus Routingplan holen
// ------------------------------------------
lCustomerKey				= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ncustomer_key")
sCustomer 					= dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"ccustomer")
// ---------------------------------------------------------------------------
// Sollen Rampenboxen und/oder Abfertigungen der Vorwoche $$HEX1$$fc00$$ENDHEX$$bernommen werden ?
// ---------------------------------------------------------------------------
If iJobParameter >= 1 and  iJobParameter <= 3 Then
	irc = of_update_day7()
	If irc = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Handling of day - 7 not found.")
	End if
	If irc = -2 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Ramp boxes of day - 7 not found.")
	End if
End if		
// ----------------------------------------------------------------------------------
// Ok, der Job soll aktuelle Flugdaten verwenden, wir ver$$HEX1$$e400$$ENDHEX$$ndern folgende Parameter:
// Abflugzeit, Eigner, Flugger$$HEX1$$e400$$ENDHEX$$t,Galleyversion
// ----------------------------------------------------------------------------------
If iPaxType = 3 and sLoadingUnit = sUnit Then
	dsFlightData.Retrieve(lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom)
	
	If dsFlightData.Rowcount() <= 0 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
			string(dGenerationDate,s_app.sDateformat),&
			"No valid flight data (flight number) available, standard will be used.")

	Else
		sOwnerForeign				= dsFlightData.GetItemString(1,"cequipment_owner")
		sACTypeForeign				= dsFlightData.GetItemString(1,"cequipment")
		sDepartureTimeForeign	= dsFlightData.GetItemString(1,"cdeparture_time")
		// -------------------------------------------------------
		// Nun die Sitzplatzversion
		// -------------------------------------------------------
		iQueryID 		= dsFlightData.GetItemNumber(1,"nquery")
		For i = 1 to dsFlightData.Rowcount()
			If dsFlightData.GetItemNumber(i,"nquery") <> iQueryID Then
				Exit
			End if	
			sClassName[i] 		= dsFlightData.GetItemString(i,"cclass")
			iClassNumber[i] 	= dsFlightData.GetItemNumber(i,"nclass_number")
			iSeatVersion[i] 	= dsFlightData.GetItemNumber(i,"nversion")
			iForecast[i] 	 	= dsFlightData.GetItemNumber(i,"nforecast")
		Next
		// -------------------------------------------------------
		// Und nun die eigentliche Pr$$HEX1$$fc00$$ENDHEX$$fung Flugger$$HEX1$$e400$$ENDHEX$$t
		// -------------------------------------------------------
		uo_get_ac = create uo_get_aircraft
		uo_get_ac.sOwner 				= sOwnerForeign
		uo_get_ac.sActype 			= sACTypeForeign
		uo_get_ac.sClass[]			= sClassName[]
		uo_get_ac.iVersion[]			= iSeatVersion[]
		uo_get_ac.iClassNumber[]	= iClassNumber[]
		uo_get_ac.lAirline_Key		= lAirlineKey
		If uo_get_ac.of_get_aircraft() <> 0 then
			of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
								string(dGenerationDate,s_app.sDateformat),&
								"No valid return flight data (aircraft type) available, no passenger counts available.")							
				
		Else
			lAircraftKey				= uo_get_ac.lAircraft_key
			sGalleyVersion				= uo_get_ac.sGalleyVersion
			lOwnerKey					= uo_get_ac.lOwner_key
			sOwner						= uo_get_ac.sOwner
			sACType						= uo_get_ac.sActype
			//sDepartureTime				= sDepartureTimeForeign
			sVersionString				= uo_get_ac.sVersionString
			lVersionGroupKey			= uo_get_ac.lGroup_key
			lFlightDataQuery			= dsFlightData.GetItemNumber(1,"nquery")
		End if
		destroy uo_get_ac
	End if	
End if
// ----------------------------------------------------------------------------------
// Ok, der Job soll betriebliche Prognose, wir ver$$HEX1$$e400$$ENDHEX$$ndern folgende Parameter:
// Abflugzeit, Eigner, Flugger$$HEX1$$e400$$ENDHEX$$t,Galleyversion
// Nur f$$HEX1$$fc00$$ENDHEX$$r Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r diesen Betrieb !!!
// ----------------------------------------------------------------------------------
If iPaxType = 4 and sLoadingUnit = sUnit Then
	dsGenerateCenExternalSchedule.Retrieve(1,lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom,sUnit)
	If dsGenerateCenExternalSchedule.Rowcount() <= 0 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
							string(dGenerationDate,s_app.sDateformat),&
							"No forecast available, standard will be used.")
	Else
// --------------------------------------------------------------------------------------------------------------------
// 05.11.2015 HR: P Locke in UK m$$HEX1$$f600$$ENDHEX$$chte nicht mehr den AC-Type von der Prognose $$HEX1$$fc00$$ENDHEX$$bernehemen
// --------------------------------------------------------------------------------------------------------------------
/*		
		lAircraftKey				= dsGenerateCenExternalSchedule.GetItemNumber(1,"naircraft_key")
		sGalleyVersion				= dsGenerateCenExternalSchedule.GetItemString(1,"cgalleyversion")
		lOwnerKey					= dsGenerateCenExternalSchedule.GetItemNumber(1,"nairline_owner_key")
		sOwner						= dsGenerateCenExternalSchedule.GetItemString(1,"cac_owner")
		sACType						= dsGenerateCenExternalSchedule.GetItemString(1,"cac_type")
		//
		// 26.09.06 Departure-Time darf nicht durch betriebliche Prognose ge$$HEX1$$e400$$ENDHEX$$ndert werden
		//
		//sDepartureTime				= dsGenerateCenExternalSchedule.GetItemString(1,"cdeparture_time")
		sVersionString				= dsGenerateCenExternalSchedule.GetItemString(1,"cconfiguration")
		lVersionGroupKey			= dsGenerateCenExternalSchedule.GetItemNumber(1,"nversion_group_key")
		sRegistration				= dsGenerateCenExternalSchedule.GetItemString(1,"cregistration")
*/
		lFlightDataQuery			= 1
		
		If iJobParameter = 1 Then
			lHandlingTypeKey 		= dsGenerateCenExternalSchedule.GetItemNumber(1,"nhandling_type_key")
			sHandlingShortText	= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_text")
			sHandlingLongText		= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_description")
			sBoxFrom				= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_from")
			sBoxTo					= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_to")
			iStatusUpdate7			= 1
		ElseIf iJobParameter = 2 Then
			sBoxFrom				= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_from")
			sBoxTo					= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_to")
			iStatusUpdate7			= 0
		ElseIf iJobParameter = 3 Then
			lHandlingTypeKey 		= dsGenerateCenExternalSchedule.GetItemNumber(1,"nhandling_type_key")
			sHandlingShortText	= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_text")
			sHandlingLongText		= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_description")
			iStatusUpdate7			= 1
		End if	
		
	End if	
End if

// --------------------------------------------------------------------------------------------------------------------
// 03.02.2016 HR: CBASE-BRU-CR-2015-007 Wir merken uns das gepflegte Feld
// --------------------------------------------------------------------------------------------------------------------
is_CADDITIONAL = dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"CADDITIONAL")
if isnull(is_CADDITIONAL) then is_CADDITIONAL = " "

// ------------------------------------------
// Traffic Area zuweisen
// ------------------------------------------
of_set_traffic_area()
// ------------------------------------------
// Interne Zeiten
// ------------------------------------------
of_set_internal_times()

If bDebugCenOut = True Then
	lrow = dscenOutDebug.Insertrow(0)
	dscenOutDebug.SetItem(lRow,"CAIRLINE",sAirline)
	dscenOutDebug.SetItem(lRow,"nflightnumber",lFlightNumber)
	dscenOutDebug.SetItem(lRow,"ddeparture",dGenerationDate)
	dscenOutDebug.SetItem(lRow,"cdeparture_time",sDepartureTime)
	dscenOutDebug.SetItem(lRow,"nleg_number",lLegNumber)
	dscenOutDebug.SetItem(lRow,"cfom",sTLCFrom)
	dscenOutDebug.SetItem(lRow,"cto",sTLCTo)
	dscenOutDebug.SetItem(lRow,"noffset",iOffset_RF)
	dscenOutDebug.SetItem(lRow,"sunit",sLoadingUnit)
End if	

return True

end function

public function boolean of_write_cen_out (boolean bcitypair);// ------------------------------------------
// Daten in den Datastore dsCenOut schreiben
// ------------------------------------------
DateTime		dtArrivalDateLoc
DateTime		dtArrivalDateUtc
DateTime		dtDepartureDateLoc
DateTime		dtDepartureDateUtc
Long				a
Long				lBillingSequence
Long				lLocKey
Long 				lRow 					= 0
Long  				lSequence
String				sCustomerCode
String 			sSearch
String 			ls_fk

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

lRow = dsCenOut.insertrow(0)

// 1. Abflugdatum/-zeit UTC
uoConvUtcLoc.uf_loc2utc(sTLCFrom, dNewGenerationDate, sDepartureTime, nDepartureFaktor)
dtDepartureDateUtc		= DateTime(uoConvUtcLoc.id_new_date, Time(uoConvUtcLoc.is_new_time))

// --------------------------------------------------------------------------------------------------------------------
// Wenn UTC VorLeg gr$$HEX2$$f600df00$$ENDHEX$$er UTC Depature, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir einen Tag addieren
// Auch gegen ARR-UTC pruefen
// --------------------------------------------------------------------------------------------------------------------
if f_dt_diff(dt_dep_vorleg, dtDepartureDateUtc)<0 or f_dt_diff(dt_arr_vorleg, dtDepartureDateUtc)<0 then
	dtDepartureDateUtc = f_dt_add(dtDepartureDateUtc, 86400)
end if

dt_dep_vorleg = dtDepartureDateUtc

// 22.02.2010 HR: Zu merkende Zeit anhand des Schalters Local/UTC festlegen.
If lFlightScheduleTime = 1 Then
	cdeparture_vorleg = sOriginalDeparture
else
	cdeparture_vorleg = string(dtDepartureDateUtc, "hh:mm")
end if

dsCenOut.SetItem(lRow,"ddeparture_time_utc",dtDepartureDateUtc)

dtDepartureDateLoc 		= DateTime(dNewGenerationDate,Time(sDepartureTime))

// --------------------------------------------------------------------------------------------------------------------
// 17.06.2015 HR: Falls Ankunftszeit leer, dann rechnen wir jetzt auf die Abflugzeit UTC eine Minute drauf
// --------------------------------------------------------------------------------------------------------------------
if sArrivalTime ='00:00' or trim(sArrivalTime)='' or isnull(sArrivalTime) then // 13.02.2012 HR: Hier auch pr$$HEX1$$fc00$$ENDHEX$$fen , ob Leer oder NULL ist
	dtArrivalDateUtc        		= f_dt_add(dtDepartureDateUtc, 60)

	uoConvUtcLoc.uf_utc2loc(sTLCTo, date(dtArrivalDateUtc), string(dtArrivalDateUtc, "hh:mm"), nArrivalFaktor)
	sArrivalTime				= uoConvUtcLoc.is_new_time
end if

// 2. Ankunftszeit UTC als DateTime
if sDepartureTime > sArrivalTime then
	a = 1
else
	a = 0
end if

uoConvUtcLoc.uf_loc2utc(sTLCTo, relativedate(DATE( dtDepartureDateLoc), a) , sArrivalTime, nArrivalFaktor)
dtArrivalDateUtc			= DateTime(uoConvUtcLoc.id_new_date,Time( uoConvUtcLoc.is_new_time)) // Abflug DateTime UTC

// Problem: Wenn Ankunftszeit am n$$HEX1$$e400$$ENDHEX$$chsten Tag ist, so ist das Ankunfts-DateTime jetzt kleiner
// als das Abflugs-DateTime => Pr$$HEX1$$fc00$$ENDHEX$$fen und ggf. anpassen
IF 	dtArrivalDateUtc < dtDepartureDateUtc THEN
	dtArrivalDateUtc = f_dt_add(dtArrivalDateUtc, 86400)
END IF

dsCenOut.SetItem(lRow,"darrival_time_utc",dtArrivalDateUtc)
dt_arr_vorleg = dtArrivalDateUtc //21.11.2011 HR

// 3. Ankunftdatum/-zeit LOC
uoConvUtcLoc.uf_utc2loc(sTLCTo, date(dtArrivalDateUtc), string(dtArrivalDateUtc, "hh:mm"), nArrivalFaktor)
dtArrivalDateLoc			= datetime(uoConvUtcLoc.id_new_date,Time( uoConvUtcLoc.is_new_time)) 

dsCenOut.SetItem(lRow,"darrival_time_loc",dtArrivalDateLoc)
dsCenOut.SetItem(lRow,"CARRIVAL_TIME",string(dtArrivalDateLoc, "hh:mm"))

// --------------------------------------------------------------------------------------------------------------------
// 18.12.2009 HR: Zeiten und Offset setzen
// --------------------------------------------------------------------------------------------------------------------
dsCenOut.SetItem(lRow,"ddeparture_time_loc",dtDepartureDateLoc)
dsCenOut.SetItem(lRow,"dreturn_date",DateTime(date(dtDepartureDateLoc),Time("00:00"))) // 18.11.2011 HR:
dsCenOut.SetItem(lRow,"noffset_dep", nDepartureFaktor) 
dsCenOut.SetItem(lRow,"noffset_arr",nArrivalFaktor) 

dsCenOut.SetItem(lRow,"DDEPARTURE_ORIG",dsCenOut.getitemdatetime(lRow, "dreturn_date"))
dsCenOut.SetItem(lRow,"CDEPARTURE_TIME_ORIG",sDepartureTime)

// --------------------------------------------------------------------------------------------------------------------
// 16.03.2012 HR: F$$HEX1$$fc00$$ENDHEX$$llen Flightkey
// --------------------------------------------------------------------------------------------------------------------
ls_fk = string(dtDepartureDateLoc,"YYYYMMDD")
ls_fk += sAirline
ls_fk += string(lFlightNumber,"0000")

if isnull(sSuffix) or trim(sSuffix)="" then
	ls_fk += " "	
else
	ls_fk += sSuffix
end if

ls_fk += sTLCFrom
ls_fk += sTLCTo

dsCenOut.SetItem(lRow,"cflight_key",ls_fk)

lSequence = -1

if ii_resuse_resultkeys=1 then
	// Hier muss der KEY-Recycler rein
	// 17.03.2016 HR: CBASE-Z4-EM-16002 Wir d$$HEX1$$fc00$$ENDHEX$$rfen keine Keys von gesprerrten Fl$$HEX1$$fc00$$ENDHEX$$gen verwenden
	a = dsCenOutCache.find("cflight_key = '"+ls_fk+"' and nreused = 0 and nnotregenerate = 0", 1, dsCenOutCache.rowcount())
	if a > 0 then
		dsCenOutCache.setitem(a, "nreused", 1)
		lSequence = dsCenOutCache.getitemnumber(a, "NRESULT_KEY")
		of_trace("of_write_cen_out", 50, "NRESULT_KEY - Recycler for "+ls_fk +" ReUse "+string(lSequence))
	end if
end if

if lSequence = -1 then
	lSequence = f_Sequence ("seq_cen_out",sqlca)
	If lSequence = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't get a new sequence : seq_cen_out.")
		return False
	End if
end if

// Gruppierung der Fl$$HEX1$$fc00$$ENDHEX$$ge $$HEX1$$fc00$$ENDHEX$$ber mehrere Legs
//15.11.2012 HR Neuer Gruppenkey auch f$$HEX1$$fc00$$ENDHEX$$rs 2. Leg, wenn erstes Leg nicht generiert wurde
if lLegNumber > 1 and lResultKeyGroup>0 then
	lLocKey = lResultKeyGroup
else
	lResultKeyGroup = lSequence
	lLocKey = lResultKeyGroup
end if

lResultKey	= lSequence
dsCenOut.SetItem(lRow,"NRESULT_KEY",lResultKey)
dsCenOut.SetItem(lRow,"NUSER_MODIFIED",0)
dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY",0)
dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY",0)
dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY_CP",0)
dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY_CP",0)

// 09.08.2010 HR:
dsCenOut.SetItem(lRow,"nnotregenerate",0)

// -------------------------------------------------
// Flugnummer oder City Pair
// -------------------------------------------------
If bCityPair = True Then
	dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY_CP",lRoutingPlanDetailKey)
	dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY_CP",lRoutingPlanGroupKey)
Else
	dsCenOut.SetItem(lRow,"NROUTINGDETAIL_KEY",lRoutingPlanDetailKey)
	dsCenOut.SetItem(lRow,"NROUTING_GROUP_KEY",lRoutingPlanGroupKey)
End if	

dsCenOut.SetItem(lRow,"DGENERATION_DATE",datetime(dGenerationDate))
dsCenOut.SetItem(lRow,"NROUTINGPLAN_INDEX",lRoutingPlanKey)
dsCenOut.SetItem(lRow,"NAIRLINE_KEY",lAirlineKey)
dsCenOut.SetItem(lRow,"CAIRLINE",sAirline)
dsCenOut.SetItem(lRow,"NFLIGHT_NUMBER",lFlightNumber)
dsCenOut.SetItem(lRow,"CSUFFIX", sSuffix)
dsCenOut.SetItem(lRow,"DDEPARTURE",DateTime(dNewGenerationDate,Time("00:00")))

// -------------------------------------------------------------------------
// 19.06.08, KF
// -------------------------------------------------------------------------
// Der Schalter iMLFlight wird in Funktion of_generate_flights gesetzt.
// Fl$$HEX1$$fc00$$ENDHEX$$ge die nur Aufgrund einer Zuordnung auf Handlingobjektebene
// generiert werden haben hier den Wert 1 in der Variable iMLFlight.
// Bei diesen Fl$$HEX1$$fc00$$ENDHEX$$gen soll dann immer die tats$$HEX1$$e400$$ENDHEX$$chlich Abflugzeit eingetragen
// werden und nicht die von Leg 1
// -------------------------------------------------------------------------
if this.iMLFlight <> 1 then
	dsCenOut.SetItem(lRow,"CDEPARTURE_TIME",sDepartureTime)
	// dsCenOut.SetItem(lRow,"dreturn_date",DateTime(dReturnFlightDate,Time("00:00"))) // 13.04.2015 HR: Wird bereits weiter oben gesetzt
	if dsCenOut.dataobject = "dw_cen_out" then dsCenOut.SetItem(lRow,"nml_flight", 0)
else
	dsCenOut.SetItem(lRow,"CDEPARTURE_TIME",sOriginalDeparture)
	dsCenOut.SetItem(lRow,"dreturn_date",DateTime(dNewGenerationDate,Time("00:00")))
	
	if dsCenOut.dataobject = "dw_cen_out" then dsCenOut.SetItem(lRow,"nml_flight", 1)
end if

//03.09.07 DB: Erweiterung der CEN_OUT Struktur
dsCenOut.SetItem(lRow,"CAIRLINE_ORIG",sAirline)
dsCenOut.SetItem(lRow,"NFLIGHT_NUMBER_ORIG",lFlightNumber)
dsCenOut.SetItem(lRow,"CSUFFIX_ORIG", sSuffix)

dsCenOut.SetItem(lRow,"CRAMP_TIME",sRampTime)
dsCenOut.SetItem(lRow,"CKITCHEN_TIME",sKitchenTime)
dsCenOut.SetItem(lRow,"NAIRCRAFT_KEY",lAircraftKey)
dsCenOut.SetItem(lRow,"CACTYPE",sACType)
dsCenOut.SetItem(lRow,"NAIRLINE_OWNER_KEY",lOwnerKey)
dsCenOut.SetItem(lRow,"CAIRLINE_OWNER",sOwner)
dsCenOut.SetItem(lRow,"CGALLEYVERSION",sGalleyVersion)
dsCenOut.SetItem(lRow,"CCONFIGURATION","")
dsCenOut.SetItem(lRow,"NLEG_NUMBER",lLegNumber)
dsCenOut.SetItem(lRow,"CUNIT",sLoadingUnit)
dsCenOut.SetItem(lRow,"CCLIENT",sClient)
dsCenOut.SetItem(lRow,"NTLC_FROM",lTlcFrom)
dsCenOut.SetItem(lRow,"NTLC_TO",lTlcTo)
dsCenOut.SetItem(lRow,"CTLC_FROM",sTLCFrom)
dsCenOut.SetItem(lRow,"CTLC_TO",sTLCTo)
//dsCenOut.SetItem(lRow,"CARRIVAL_TIME",sArrivalTime) HR 29.09.09
dsCenOut.SetItem(lRow,"CBLOCK_TIME",sBlockTime)
dsCenOut.SetItem(lRow,"NCUSTOMER_KEY",lCustomerKey)
dsCenOut.SetItem(lRow,"CCOUNTRY_FROM",sCountryFrom)
dsCenOut.SetItem(lRow,"CCOUNTRY_TO",sCountryTo)
dsCenOut.SetItem(lRow,"CTRAFFIC_AREA",sTrafficArea)
dsCenOut.SetItem(lRow,"CTRAFFIC_AREA_SHORT",sTrafficAreaShort)
dsCenOut.SetItem(lRow,"NHANDLING_TYPE_KEY",lHandlingTypeKey)
dsCenOut.SetItem(lRow,"CHANDLING_TYPE_TEXT",sHandlingShortText)
dsCenOut.SetItem(lRow,"CHANDLING_TYPE_DESCRIPTION",sHandlingLongText)
dsCenOut.SetItem(lRow,"NROUTING_ID",lRoutingID)
dsCenOut.SetItem(lRow,"CROUTING",sRoutingShortText)
dsCenOut.SetItem(lRow,"CROUTING_TEXT",sRoutingLongText)
dsCenOut.SetItem(lRow,"DTIMESTAMP",Datetime(today(),now()))
dsCenOut.SetItem(lRow,"NSTATUS",iGenerierungsstatus)
dsCenOut.SetItem(lRow,"CDESCRIPTION",sGenerierungsstatus)
dsCenOut.SetItem(lRow,"NTRANSACTION",lTransActionKey)
dsCenOut.SetItem(lRow,"nversiongroupkey",lVersionGroupKey)
dsCenOut.SetItem(lRow,"nquery",lFlightDataQuery)
dsCenOut.SetItem(lRow,"DORIGINAL_DEPARTURE",DateTime(dNewGenerationDate,Time("00:00")))
dsCenOut.SetItem(lRow,"ccustomer",sCustomer)
dsCenOut.SetItem(lRow,"nairline_type",iAirlineType)
dsCenOut.SetItem(lRow,"nposting_type",1)	// Kartenart "Belastung"

// ----------------------------------------------------------
// EG-Erstattung (Refunding)
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"nrefund",iRefund)

// ----------------------------------------------------------
// Update Tag 7
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"cbox_from",sBoxFrom)
dsCenOut.SetItem(lRow,"cbox_to",sBoxTo)
dsCenOut.SetItem(lRow,"nstatus_update7",iStatusUpdate7)

// ------------------------------------------------------
// 26.04.2007, KF
// Die Default Abfertigungsart aus der Beladedefinition
// merken falls of_update7() eine ABART zuspielt f$$HEX1$$fc00$$ENDHEX$$r
// die in of_generate_handling_one() keine Standard-
// beladung gefunden wird.
// ------------------------------------------------------
a = dsHandlingTypeCache.InsertRow(0)
dsHandlingTypeCache.SetItem(a, "nresult_key", lResultKey)
dsHandlingTypeCache.SetItem(a, "nhandling_type_key", lDefaultHandlingTypeKey)
dsHandlingTypeCache.SetItem(a, "chandling_type_text", sDefaultHandlingShortText)
dsHandlingTypeCache.SetItem(a, "chandling_type_description", sDefaultHandlingLongText)


// ----------------------------------------------------------
// Der neue Flug-Status: 
// Zun$$HEX1$$e400$$ENDHEX$$chst 0 = "Scheduled"
// Sp$$HEX1$$e400$$ENDHEX$$ter auch als Flag f$$HEX1$$fc00$$ENDHEX$$r 
//	1 = "Cancelled" 
// 2 = "OnRequest"
// ----------------------------------------------------------
if sHandlingShortText = "REQ" then
	dsCenOut.SetItem(lRow,"nflight_status",2)
else
	dsCenOut.SetItem(lRow,"nflight_status",0)
end if
// ----------------------------------------------------------
// Leg-Identifier und Bulk-Identifier
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"nleg_ident",iLegIdentifier)
dsCenOut.SetItem(lRow,"nbulk_ident",iBulkIdentifier)
// ----------------------------------------------------------
// Alle Legs erhalten Result-Key vom ersten Leg
// nresult_key_group, lLocKey
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"nresult_key_group",lLocKey)
dsCenOut.SetItem(lRow,"nmanual_input",0)
// ----------------------------------------------------------
// Original-Abflugzeit merken
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"coriginal_time",sOriginalDeparture)
// ----------------------------------------------------------
// Belegnummer entspr. SEQ_CEN_OUT_NBILLING_KEY (21.01.05)
// ----------------------------------------------------------
if lLastResultKeyGroup <> lResultKeyGroup then
	lBillingSequence = f_Sequence("SEQ_CEN_OUT_NBILLING_KEY",sqlca)
	If lBillingSequence = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat), &
								"Can't get a new sequence : SEQ_CEN_OUT_NBILLING_KEY.")
		return False
	End if
	lBillingKey = lBillingSequence
	lLastResultKeyGroup = lResultKeyGroup
end if
dsCenOut.SetItem(lRow,"nbilling_key",lBillingKey)
// ----------------------------------------------------------
// Registration nur bei betr. Prognose
// ----------------------------------------------------------
dsCenOut.SetItem(lRow,"cregistration",sRegistration)
// ----------------------------------------------------------
// Kundennummer (19.01.05)
// ----------------------------------------------------------
sCustomerCode = of_get_customer_code(lCustomerKey,sLoadingUnit)
dsCenOut.SetItem(lRow,"ccustomer_code",sCustomerCode)
dsCenOut.SetItem(lRow,"nposting_status",0)	// Storno-KZ

// ----------------------------------------------------------
// 28.04.2009 Default OP Code
// ----------------------------------------------------------
If of_Get_OPCode( lairlinekey ) Then
	dsCenOut.SetItem(lRow,"nopcode_key", lopcode_key )
	dsCenOut.SetItem(lRow,"copcode", sopcode )
End If

// ----------------------------------------------------------
// 28.01.2016 Default OP Code per Handling Type
// ----------------------------------------------------------
If of_get_opcode_per_handling( lHandlingTypeKey ) Then
	dsCenOut.SetItem(lRow,"nopcode_key", lopcode_key )
	dsCenOut.SetItem(lRow,"copcode", sopcode )
End If

// --------------------------------------------------------------------------------------------------------------------
// 04.04.2011 HR:
// --------------------------------------------------------------------------------------------------------------------
dsCenOut.SetItem(lRow,"nmanual_packets",0)
dsCenOut.SetItem(lRow,"nac_group_key",lVersionGroupKey)
dsCenOut.SetItem(lRow,"ncfs_packets",0)

// --------------------------------------------------------------------------------------------------------------------
// 03.02.2016 HR: CBASE-BRU-CR-2015-007 Wir schreiben den Wert in die CEN_OUT
// --------------------------------------------------------------------------------------------------------------------
dsCenOut.SetItem(lRow,"cHeader2", is_CADDITIONAL)

dsCenOut.SetItem(lRow,"ntb", ii_trainbusiness) // 29.07.2015 HR:

if bCFSAirline then
	dsCenOut.SetItem(lRow,"ncfs",1)
	
	of_write_cen_out_packets_los(lrow, lResultKey,lLocKey )
else
	dsCenOut.SetItem(lRow,"ncfs",0)
end if

return True

end function

public function boolean of_set_cen_out (long lschedulerow, long lroutingplanrow);// -----------------------------------------------
// Daten f$$HEX1$$fc00$$ENDHEX$$r den Datastore dsCenOut vorbereiten
// -----------------------------------------------
long					lDeparture_Faktor
string					sClassName[]
integer				iSeatVersion[]
integer				iForecast[]
integer				iClassNumber[]
integer				iQueryID, i
uo_get_aircraft 	uo_get_ac
string					sOwnerForeign
string					sACTypeForeign
string					sDepartureTimeForeign
integer				irc
long					a
integer 				iVerkehrsTag 

sVersionString 			= ""	
lVersionGroupKey 		= 0
lFlightDataQuery		= 0
// -----------------------------------------------
// Daten aus dem Flugplan
// -----------------------------------------------
lTlcFrom							= dsGenerateSchedule.GetitemNumber(lschedulerow,"ntlc_from")
lTlcTo								= dsGenerateSchedule.GetitemNumber(lschedulerow,"ntlc_to")
sTLCFrom						= f_check_three_letter_code_id(lTlcFrom)
sTLCTo							= f_check_three_letter_code_id(lTlcTo)

nDepartureFaktor				= dsGenerateSchedule.GetitemDecimal(lschedulerow,"ndeparture_faktor") // TBR 04.11.2008
nArrivalFaktor					= dsGenerateSchedule.GetitemDecimal(lschedulerow,"narrival_faktor") //HR 29.09.2009
sDepartureTime				= dsGenerateSchedule.GetitemString(lschedulerow,"cdeparture_time")
dNewGenerationDate			= dGenerationDate
sArrivalTime					= dsGenerateSchedule.GetitemString(lschedulerow,"carrival_time")

If lFlightScheduleTime <> 1 Then
	// --------------------------------------------------------------------------------------------------------------------
	// 19.02.2016 HR: CBASE-DE-CR-2015-059 neue Funktion zur Umrechnung
	// --------------------------------------------------------------------------------------------------------------------
	uoConvUtcLoc.uf_utc2loc(sTLCFrom, dNewGenerationDate, sDepartureTime, nDepartureFaktor)
	
	if sDepartureTime < sArrivalTime then
		i = 1
	else
		i = 0
	end if
	
	sDepartureTime			= uoConvUtcLoc.is_new_time
	dNewGenerationDate		= uoConvUtcLoc.id_new_date
	nDepartureFaktor			= uoConvUtcLoc.id_new_offset
	dReturnFlightDate			= dNewGenerationDate
	
	uoConvUtcLoc.uf_utc2loc(sTLCTo,  relativedate(dGenerationDate, i), sArrivalTime, nArrivalFaktor)
	sArrivalTime				= uoConvUtcLoc.is_new_time
	nArrivalFaktor				= uoConvUtcLoc.id_new_offset
End if

// 14.10.2010 HR:
iVerkehrsTag 	= f_getfrequence(dNewGenerationDate)

// Neu: Original-Abflugzeit aufheben
sOriginalDeparture			= sDepartureTime
sBlockTime 					= dsGenerateSchedule.GetitemString(lschedulerow,"cblock_time")
lAircraftKey					= dsGenerateSchedule.GetitemNumber(lschedulerow,"naircraft_key")
sACType						= dsGenerateSchedule.GetitemString(lschedulerow,"cactype")
sGalleyVersion				= dsGenerateSchedule.GetitemString(lschedulerow,"cgalleyversion")
lOwnerKey					= dsGenerateSchedule.GetitemNumber(lschedulerow,"nairline_owner_key")
sOwner						= dsGenerateSchedule.GetitemString(lschedulerow,"cen_airlines_cairline")
lFlightNumber 				= dsGenerateSchedule.Getitemnumber(lschedulerow,"nflight_number")
sSuffix						= dsGenerateSchedule.Getitemstring(lschedulerow,"csuffix")
sCountryFrom 				= dsGenerateSchedule.GetitemString(lschedulerow,"ccountry_from")
sCountryTo					= dsGenerateSchedule.GetitemString(lschedulerow,"ccountry_to")

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

If len(sCountryFrom) <= 0 or isnull(sCountryFrom) Then
	// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
	//sCountryFrom 	= "Nil"
	sCountryFrom 	= " "
End if
If len(sCountryTo) <= 0 or isnull(sCountryTo) Then
	// 19.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r NAM soll hier wie bei der Flug-Neuaufnahme ein Blank anstatt NIL eingetragen werden
	//sCountryTo 	= "Nil"
	sCountryTo 	= " "
End if

// ------------------------------------------
// Daten aus dem Routingplan
// ------------------------------------------
lRoutingPlanKey					= lRoutingPlanKey
lRoutingPlanDetailKey				= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nroutingdetail_key")
lRoutingPlanGroupKey				= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nrouting_group_key")
lAirlineKey							= dsGenerateRoutingPlan.GetitemNumber(lroutingplanrow,"nairline_key")
sAirline								= dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"cairline")
lLegNumber							= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nleg_number")

if dsGenerateRoutingPlan.dataobject = "dw_generate_routingplan_cfs" then
	// 14.10.2010 HR: Im CFS gibt es f$$HEX1$$fc00$$ENDHEX$$r jeden Verkehrstag ein Handling
	lHandlingTypeKey				= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nhandling_type_key"+string(iVerkehrsTag))
	sHandlingShortText			= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_ctext"+string(iVerkehrsTag))
	sHandlingLongText				= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_cdescription"+string(iVerkehrsTag))
else
	// 14.10.2010 HR: Standard
	lHandlingTypeKey				= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nhandling_type_key")
	sHandlingShortText			= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_ctext")
	sHandlingLongText				= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_cdescription")
end if

lDefaultHandlingTypeKey			= lHandlingTypeKey 		//dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nhandling_type_key")
sDefaultHandlingShortText		= sHandlingShortText 		//dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_ctext")
sDefaultHandlingLongText		= sHandlingLongText 		//dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"cen_handling_types_cdescription")

lRoutingID							= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nrouting_id")
sRoutingShortText					= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"crouting")
sRoutingLongText					= dsGenerateRoutingPlan.Getitemstring(lroutingplanrow,"crouting_text")
iAirlineType							= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"cen_airlines_nairline_type")
ilegidentifier							= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"nleg_ident")

// --------------------------------------------------------------------------------------------------------------------
// 15.10.2010 HR: Rampenboxen vorbelegen bzw. zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// --------------------------------------------------------------------------------------------------------------------
sBoxFrom				= ""
sBoxTo					= ""

// Nur die Hinfl$$HEX1$$fc00$$ENDHEX$$ge bekommen Bulk-Identifier = 0
// alt: if ilegidentifier = 1 or ilegidentifier = 2 then
if ilegidentifier = 1 then
	ibulkidentifier = 0
else
	ibulkidentifier = 1
end if
// ------------------------------------------
// Kunde zun$$HEX1$$e400$$ENDHEX$$chst aus Routingplan holen
// ------------------------------------------
lCustomerKey					= dsGenerateRoutingPlan.Getitemnumber(lroutingplanrow,"ncustomer_key")
sCustomer 						= dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"ccustomer")

// --------------------------------------------------------------------------------------------------------------------
// 15.02.2012 HR: Alte Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeit zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// --------------------------------------------------------------------------------------------------------------------
ls_old_ramp_time 		= ""	
ls_old_kitchen_time 	= ""

// ---------------------------------------------------------------------------
// 26.04.2007, KF
// Sollen Rampenboxen und/oder Abfertigungen des aktuellen Tages $$HEX1$$fc00$$ENDHEX$$bernommen
// werden ???? 
// Ist der Cache leer dann die der Vorwoche verwenden (iJobParameter auf 1)
// 20.01.2012 HR: neuer Parameter 5 ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 15.02.2012 HR: neuer Parameter 6 ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// ---------------------------------------------------------------------------

If iJobParameter = 4 or iJobParameter = 5 or  iJobParameter = 6 Then
	
	if dsCenOutCache.RowCount() > 0 then
		irc = of_update_from_cache()
		
		If irc = -1 Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
						string(lFlightNumber),&
						string(dGenerationDate,s_app.sDateformat),&
						"Ramp boxes not found in cache.")
		End if
		
		If irc = -2 Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
						string(lFlightNumber),&
						string(dGenerationDate,s_app.sDateformat),&
						"Handling of day - 7 not found.")
		end if
		
	else
		
		iJobParameter = 1
		
	end if
	
End if

// ---------------------------------------------------------------------------
// Sollen Rampenboxen und/oder Abfertigungen der Vorwoche $$HEX1$$fc00$$ENDHEX$$bernommen werden ?
// ---------------------------------------------------------------------------
If iJobParameter >= 1 and  iJobParameter <= 3 Then
	irc = of_update_day7()
	If irc = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Handling of day - 7 not found.")
	End if
	
	If irc = -2 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Ramp boxes of day - 7 not found.")
	End if
End if

// ----------------------------------------------------------------------------------
// Ok, der Job soll aktuelle Flugdaten verwenden, wir ver$$HEX1$$e400$$ENDHEX$$ndern folgende Parameter:
// Abflugzeit, Eigner, Flugger$$HEX1$$e400$$ENDHEX$$t,Galleyversion
// Nur f$$HEX1$$fc00$$ENDHEX$$r Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r diesen Betrieb !!!
// ----------------------------------------------------------------------------------
If iPaxType = 3 and sLoadingUnit = sUnit Then
	//
	//
	dsFlightData.Retrieve(lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom)
	If dsFlightData.Rowcount() <= 0 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
								string(dGenerationDate,s_app.sDateformat),&
								"Found no valid AMOS information for this flight.")
	Else
		sOwnerForeign				= dsFlightData.GetItemString(1,"cequipment_owner")
		sACTypeForeign			= dsFlightData.GetItemString(1,"cequipment")
		sDepartureTimeForeign	= dsFlightData.GetItemString(1,"cdeparture_time")
		// -------------------------------------------------------
		// Nun die Sitzplatzversion
		// -------------------------------------------------------
		iQueryID 		= dsFlightData.GetItemNumber(1,"nquery")
		For i = 1 to dsFlightData.Rowcount()
			If dsFlightData.GetItemNumber(i,"nquery") <> iQueryID Then
				Exit
			End if	
			sClassName[i] 		= dsFlightData.GetItemString(i,"cclass")
			iClassNumber[i] 	= dsFlightData.GetItemNumber(i,"nclass_number")
			iSeatVersion[i] 		= dsFlightData.GetItemNumber(i,"nversion")
			iForecast[i] 	 		= dsFlightData.GetItemNumber(i,"nforecast")
		Next
		// -------------------------------------------------------
		// Und nun die eigentliche Pr$$HEX1$$fc00$$ENDHEX$$fung Flugger$$HEX1$$e400$$ENDHEX$$t
		// -------------------------------------------------------
		uo_get_ac 						= create uo_get_aircraft
		uo_get_ac.sOwner 			= sOwnerForeign
		uo_get_ac.sActype 			= sACTypeForeign
		uo_get_ac.sClass[]			= sClassName[]
		uo_get_ac.iVersion[]			= iSeatVersion[]
		uo_get_ac.iClassNumber[]	= iClassNumber[]
		uo_get_ac.lAirline_Key		= lOwnerKey
		
		If uo_get_ac.of_get_aircraft() <> 0 then
			// 23.04.2009 HR: FASTLANE ZD
			//   Wenn der AC-Type mit der Version nicht vorhanden ist aber die Version des aktuellen Fluges mit der Version 
			//   von AMOS $$HEX1$$fc00$$ENDHEX$$bereinstimmt, dann den AC-Type vom Flug $$HEX1$$fc00$$ENDHEX$$bernehmen und weiterarbeiten (ZD-Anforderung LSY-1483)
			string sAircraftConfiguration 
			
			sAircraftConfiguration = of_get_configuration(lAircraftKey)
			
			if sAircraftConfiguration = uo_get_ac.sVersionString then
				sDepartureTime			= sDepartureTimeForeign
				sVersionString				= sAircraftConfiguration
				lFlightDataQuery			= dsFlightData.GetItemNumber(1,"nquery")
				
				SELECT distinct cen_aircraft_configurations.ngroup_key into :lVersionGroupKey
				 FROM cen_aircraft,   
						cen_airlines,   
						cen_aircraft_configurations,   
						cen_class_name  
				WHERE ( cen_airlines.nairline_key = cen_aircraft.nairline_owner_key ) and  
						( cen_aircraft.naircraft_key = cen_aircraft_configurations.naircraft_key ) and  
						( cen_aircraft_configurations.nairline_key = cen_class_name.nairline_key ) and  
						( cen_aircraft_configurations.cclass = cen_class_name.cclass ) and  
						(  cen_aircraft.naircraft_key = :lAircraftKey ) ;

				if sqlca.sqlcode<>0 then
					lVersionGroupKey = 0
				end if
				
			else
						of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
							string(dGenerationDate,s_app.sDateformat),&
							"Found no valid AMOS aircraft information for this flight.")
			end if
		Else
			lAircraftKey					= uo_get_ac.lAircraft_key
			sGalleyVersion				= uo_get_ac.sGalleyVersion
			lOwnerKey					= uo_get_ac.lOwner_key
			sOwner						= uo_get_ac.sOwner
			sACType						= uo_get_ac.sActype
			sDepartureTime			= sDepartureTimeForeign
			sVersionString				= uo_get_ac.sVersionString
			lVersionGroupKey			= uo_get_ac.lGroup_key
			lFlightDataQuery			= dsFlightData.GetItemNumber(1,"nquery")
		End if
		destroy uo_get_ac
	End if	
End if

// ----------------------------------------------------------------------------------
// Ok, der Job soll betriebliche Prognose einlesen, wir ver$$HEX1$$e400$$ENDHEX$$ndern folgende Parameter:
// Abflugzeit, Eigner, Flugger$$HEX1$$e400$$ENDHEX$$t,Galleyversion
// Nur f$$HEX1$$fc00$$ENDHEX$$r Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r diesen Betrieb !!!
// ----------------------------------------------------------------------------------
If iPaxType = 4 and sLoadingUnit = sUnit Then
	dsGenerateCenExternalSchedule.Retrieve(1,lAirlineKey,lFlightnumber,sSuffix,dNewGenerationDate,sTLCFrom,sUnit)
	If dsGenerateCenExternalSchedule.Rowcount() <= 0 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
							string(dGenerationDate,s_app.sDateformat),&
							"No forecast available, standard will be used.")
	Else
// --------------------------------------------------------------------------------------------------------------------
// 05.11.2015 HR: P Locke in UK m$$HEX1$$f600$$ENDHEX$$chte nicht mehr den AC-Type von der Prognose $$HEX1$$fc00$$ENDHEX$$bernehemen
// --------------------------------------------------------------------------------------------------------------------
/*		
		lAircraftKey					= dsGenerateCenExternalSchedule.GetItemNumber(1,"naircraft_key")
		sGalleyVersion				= dsGenerateCenExternalSchedule.GetItemString(1,"cgalleyversion")
		lOwnerKey					= dsGenerateCenExternalSchedule.GetItemNumber(1,"nairline_owner_key")
		sOwner						= dsGenerateCenExternalSchedule.GetItemString(1,"cac_owner")
		sACType						= dsGenerateCenExternalSchedule.GetItemString(1,"cac_type")
		//
		// 26.09.06 Departure-Time darf nicht durch betriebliche Prognose ge$$HEX1$$e400$$ENDHEX$$ndert werden
		//
		// sDepartureTime				= dsGenerateCenExternalSchedule.GetItemString(1,"cdeparture_time")
		sVersionString				= dsGenerateCenExternalSchedule.GetItemString(1,"cconfiguration")
		lVersionGroupKey			= dsGenerateCenExternalSchedule.GetItemNumber(1,"nversion_group_key")
		sRegistration				= dsGenerateCenExternalSchedule.GetItemString(1,"cregistration")
*/
		lFlightDataQuery			= 1
		
		If iJobParameter = 1 Then
			lHandlingTypeKey 		= dsGenerateCenExternalSchedule.GetItemNumber(1,"nhandling_type_key")
			sHandlingShortText	= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_text")
			sHandlingLongText		= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_description")
			sBoxFrom				= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_from")
			sBoxTo					= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_to")
			iStatusUpdate7			= 1
		ElseIf iJobParameter = 2 Then
			sBoxFrom				= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_from")
			sBoxTo					= dsGenerateCenExternalSchedule.GetItemString(1,"cbox_to")
			iStatusUpdate7			= 0
		ElseIf iJobParameter = 3 Then
			lHandlingTypeKey 		= dsGenerateCenExternalSchedule.GetItemNumber(1,"nhandling_type_key")
			sHandlingShortText	= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_text")
			sHandlingLongText		= dsGenerateCenExternalSchedule.GetItemString(1,"chandling_type_description")
			iStatusUpdate7			= 1
		End if	
	
	End if	
End if

// --------------------------------------------------------------------------------------------------------------------
// 03.02.2016 HR: CBASE-BRU-CR-2015-007 Wir merken uns das gepflegte Feld
// --------------------------------------------------------------------------------------------------------------------
is_CADDITIONAL = dsGenerateRoutingPlan.GetitemString(lroutingplanrow,"CADDITIONAL")
if isnull(is_CADDITIONAL) then is_CADDITIONAL = " "

// ------------------------------------------
// Traffic Area zuweisen
// ------------------------------------------
if not of_set_traffic_area() then
	of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,sAirline + " " + string(lFlightNumber) + sSuffix,&
					string(dGenerationDate,s_app.sDateformat),&
					"Found no valid Traffic Area => No refunding!")
end if
// ------------------------------------------
// Interne Zeiten
// ------------------------------------------
of_set_internal_times()
return True

end function

public function boolean of_generate_handling_objects ();// ----------------------------------------
// Handlings zu den entsprechenden Fl$$HEX1$$fc00$$ENDHEX$$gen.
// ----------------------------------------
Long			i
long			j
integer		iVerkehrsTag
string  		sFrequenz
string			sAirlineCode
date			ldReturnFlightDate
string			sCurrentHandling
Long			ll_concDiffCount
datastore 	dsValidSPMLDetail
long 			lFindDef
long			lhmealkeyold
long			lhmealkey
long			i2
string 		lsSPML
string			lsclass
long			lRowcount
integer		li_HORFWDD
string			ls_rowcount

// --------------------------------------------------------------
// Datastore nach NROUTING_GROUP_KEY und NLEG_NUMBER sortieren	
// --------------------------------------------------------------
dsCenOut.Sort()

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
strChange.dscenmealsdetdeduction				= Create uo_generate_datastore
strChange.dscenmealsdetdeduction.dataobject	= "dw_exp_cen_meals_det_deduction"

// --------------------------------------------------------------
// 24.02.2005: Reset Rotation-Cache
// --------------------------------------------------------------
if isvalid(uo_generate_meals.dsRotationCache) then
	of_trace("of_generate_handling_objects", 10,"Reset uo_generate_meals.dsRotationCache...")
	uo_generate_meals.dsRotationCache.Reset()
end if

// 10.06.2010 HR: BOB-Schalter an meal_calculation $$HEX1$$fc00$$ENDHEX$$bergeben
uo_generate_meals.iImportBobValues = iImportBobValues

// 21.11.2013 HR: Wir schauen, ob die Umlaufbestimmung bei Returndates mit DRETURNDATE oder DEPDATE erfolgen soll (LSY_5908)
li_HORFWDD = integer(f_mandant_profilestring(sqlca, sClient, "Generierung","HOReturnFlightWithDepDate","1"))

// ----------------------------------------------------
// 14.01.2009
// 06.08.2014 HR: Schalter auch bei der Generierung auslesen
// Leere Customer PLs bef$$HEX1$$fc00$$ENDHEX$$llen? Schalter auslesen
// ----------------------------------------------------
long ll_fillemptycustomerpl
ll_fillemptycustomerpl = long(f_mandant_profilestring(sqlca, sClient, "OnlineExplosion","FillEmptyCustomerPL","0"))
uo_generate_meals.il_fillemptycustomerpl = ll_fillemptycustomerpl

lRowcount = dsCenOut.Rowcount()
For i = 1 to lRowcount
	
	select 1 into :j  from dual;
	
	ls_rowcount = "row " +string(i,"000") +" of "+string(lRowcount,"000")+": "
	
	// 07.12.2009 HR: Zur$$HEX1$$fc00$$ENDHEX$$cksetzten nur, wenn ds auch vorhanden
	if isvalid(dsCenOutNewSPML) then dsCenOutNewSPML.reset()
	
	// 25.11.2009 HR:
	if isvalid(dsCenOutNewSPMLDetail) then dsCenOutNewSPMLDetail.reset()
	if isvalid(uo_generate_meals.dsSPMLDetail) then uo_generate_meals.dsSPMLDetail.reset()

	iChildrenFC 						= 0    // 30.10.2009 HR: Anzahl CHDs zur$$HEX1$$fc00$$ENDHEX$$cksetzen, die ggf bei der CITP-Zuspielung berechnet werden

	lResultKey 						= dsCenOut.GetItemNumber(i,"NRESULT_KEY")
	lRoutingPlanDetailKey_CP	= dsCenOut.GetItemNumber(i,"NROUTINGDETAIL_KEY_CP")
	lRoutingPlanGroupKey_CP	= dsCenOut.GetItemNumber(i,"NROUTING_GROUP_KEY_CP")
	lRoutingPlanDetailKey			= dsCenOut.GetItemNumber(i,"NROUTINGDETAIL_KEY")
	lRoutingPlanGroupKey			= dsCenOut.GetItemNumber(i,"NROUTING_GROUP_KEY")
	lLegNumber						= dsCenOut.GetItemNumber(i,"NLEG_NUMBER")
	sAirlineCode						= dsCenOut.Getitemstring(i,"cairline")
	lFlightNumber 					= dsCenOut.Getitemnumber(i,"NFLIGHT_NUMBER")
	lAircraftKey						= dsCenOut.Getitemnumber(i,"NAIRCRAFT_KEY")
	lHandlingTypeKey				= dsCenOut.Getitemnumber(i,"NHANDLING_TYPE_KEY")
	sDepartureTime				= dsCenOut.Getitemstring(i,"CDEPARTURE_TIME")
	sOriginalDeparture				= dsCenOut.Getitemstring(i,"CORIGINAL_TIME")
	lHandlingTypeKey				= dsCenOut.Getitemnumber(i,"NHANDLING_TYPE_KEY")
	
	lRoutingID					 	= dsCenOut.Getitemnumber(i,"NROUTING_ID")	
	dNewGenerationDate			= date(dsCenOut.GetitemDateTime(i,"ddeparture"))
	sSuffix							= dsCenOut.Getitemstring(i,"csuffix")
	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

	sTLCFrom						= dsCenOut.Getitemstring(i,"ctlc_from")
	lFlightStatus						= dsCenOut.Getitemnumber(i,"nflight_status")
	lDefaultOwner					= dsCenOut.Getitemnumber(i,"nairline_owner_key")
	sCurrentHandling				= dsCenOut.Getitemstring(i,"chandling_type_text")
	
	// 01.10.2010 HR: Japantool 
	dGenerationDateUTC             = date(dsCenOut.GetitemDatetime(i,"ddeparture_time_utc"))
	
	il_tlc_from 						= dsCenOut.Getitemnumber(i,"ntlc_from")
	il_tlc_to 							= dsCenOut.Getitemnumber(i,"ntlc_to")
	
	// 07.12.2010 HR: CFS-Package-Generierung
	lAirlineKey						= dsCenOut.Getitemnumber(i,"nairline_key")
	sTLCTo							= dsCenOut.Getitemstring(i,"ctlc_to")
	sAirline							= dsCenOut.Getitemstring(i,"cairline")
	ii_leg_number					= dsCenOut.Getitemnumber(i,"nleg_number")
	
	iMLFlight							= dsCenOut.Getitemnumber(i,"nml_flight")
	iDontGeneratePaxCounts		= 0
	
	// 05.03.2013 HR: Wir holen die Registration f$$HEX1$$fc00$$ENDHEX$$r die registrationbezogene ZBL-Beladung (CBASE-DE-CR-2011-107)
	sRegistration					= dsCenOut.Getitemstring(i,"cregistration")
	if isnull(sRegistration) then sRegistration = ""
	
	//19.01.2011 HR
	is_flugnummer					= string(dGenerationDate, "yyyymmdd")+sAirline + string(lFlightNumber, "0000")+sSuffix+sTLCFrom+sTLCTo
	
	// --------------------------------------------------------------------------------------------------------------------
	// 21.06.2012 HR: Ausgabe der Flugnummer unabh$$HEX1$$e400$$ENDHEX$$ngig vom Tracelevel einschaltbar
	// --------------------------------------------------------------------------------------------------------------------
	of_trace_flight("of_generate_handling_objects", ls_rowcount + sAirline + " "+string(lFlightNumber, "0000")+sSuffix+" "+sTLCFrom+"-"+sTLCTo)
	
	// -------------------------------------------------------------------------------------
	// 28.03.2007, KF
	// Alle Abfertigungsarten bei denen die Passagierzahlen auf 0 gesetzt werden sollen
	// definieren
	// -------------------------------------------------------------------------------------
	// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014
	if sCurrentHandling = "STD" or sCurrentHandling = "DLV" or sCurrentHandling = "REQ" or sCurrentHandling = "SPC"  or sCurrentHandling = "INT" then
		iDontGeneratePaxCounts	= 1
	end if
	
	// 17.11.05 Abweichendes RF-Datum?
	sOut = "[" + string(lResultKey) + "] - " + sAirlineCode + " " + string(lFlightNumber, "000") + " / " + sTLCFrom + " / " + String(dNewGenerationDate)
	
	ldReturnFlightDate			= date(dsCenOut.GetitemDateTime(i,"dreturn_date"))
	
	if lLegNumber > 1 and ldReturnFlightDate <> dNewGenerationDate then
	    // 21.11.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r DE gibt es eine Absprache, das Uml$$HEX1$$e400$$ENDHEX$$ufe der RF mit DEPDATE ermittelt werden (LSY_5908)
		if li_HORFWDD = 1 then
			of_trace("of_generate_handling_objects", 10,ls_rowcount +"DepartureDate <> ReturnFlightDate (DepDate Used)" + string(dNewGenerationDate) + ", sAirline=" + sAirline + ", sAirlineCode=" + sAirlineCode + &
							", lFlightNumber=" + string(lFlightNumber) + ", lRoutingPlanDetailKey=" + string(lRoutingPlanDetailKey) + &
							", lRoutingPlanDetailKey_CP=" + string(lRoutingPlanDetailKey_CP))
		else	
			bDifferentReturnDate = true
			dNewGenerationDate = ldReturnFlightDate
			of_trace("of_generate_handling_objects", 10,ls_rowcount+"DepartureDate <> ReturnFlightDate " + string(dNewGenerationDate) + ", sAirline=" + sAirline + ", sAirlineCode=" + sAirlineCode + &
							", lFlightNumber=" + string(lFlightNumber) + ", lRoutingPlanDetailKey=" + string(lRoutingPlanDetailKey) + &
							", lRoutingPlanDetailKey_CP=" + string(lRoutingPlanDetailKey_CP))
		end if
	else
		bDifferentReturnDate = false
		of_trace("of_generate_handling_objects", 50,ls_rowcount+"DepartureDate = ReturnFlightDate " + string(dNewGenerationDate) + ", sAirline=" + sAirline + ", sAirlineCode=" + sAirlineCode + &
						", lFlightNumber=" + string(lFlightNumber) + ", bDifferentReturnDate = false")
	end if

	of_trace("of_generate_handling_objects", 50,ls_rowcount +"sAirline=" + sAirline + ", sAirlineCode=" + sAirlineCode + &
					", lFlightNumber=" + string(lFlightNumber) + ", lRoutingPlanDetailKey=" + string(lRoutingPlanDetailKey) + &
					", lRoutingPlanDetailKey_CP=" + string(lRoutingPlanDetailKey_CP))
	
	// ---------------------------------------------------------------
	// Achtung: Original-Abflugzeit vom Leg ber$$HEX1$$fc00$$ENDHEX$$cksichtigen!
	// Falls diese von der Departure Zeit abweicht (das ist i.d.R. so),
	// dann muss diese zur Ermittlung der Beladung herangezogen werden!
	// ---------------------------------------------------------------
	if lLegNumber > 1 then
		if sDepartureTime <> sOriginalDeparture then
			sDepartureTime = sOriginalDeparture
		end if
	end if
		
	iVerkehrsTag 	= f_getfrequence(dNewGenerationDate)
	sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"
	// ---------------------------------------------------------------
	// nur Handlings f$$HEX1$$fc00$$ENDHEX$$r die zu generierende Unit
	// ---------------------------------------------------------------
	If dsCenOut.GetitemString(i,"cunit") = sUnit Then
		
		//Pr$$HEX1$$fc00$$ENDHEX$$fung, ob abweichende Beladung definiert wurde
		Select count(*) 
			Into 	:ll_concDiffCount
			From 	cen_handling_conc_diff,
					cen_routingplan_handling,
				   cen_meals,
				   cen_meal_cover,
				   cen_mop_master
			Where cen_mop_master.nmop_key = cen_meals.nmop_key And
               cen_meals.nhandling_key = cen_meal_cover.nhandling_foreign_key And  
					(	cen_routingplan_handling.nroutingdetail_key = Nvl(:lRoutingPlanDetailKey, 0) 
					   Or
						cen_routingplan_handling.nroutingdetail_key = Nvl(:lRoutingPlanDetailKey_CP, 0) 
					) And
					cen_handling_conc_diff.nroutingplan_handling_key = cen_routingplan_handling.nroutingplan_handling_key And
					cen_routingplan_handling.dValid_from <= :dNewGenerationDate And
					cen_routingplan_handling.dValid_to >= :dNewGenerationDate And
					cen_handling_conc_diff.nhandling_key_conc  = cen_mop_master.nhandling_key_conc;
		
		bCalculateConcDiff = (ll_concDiffCount > 0)

		// ---------------------------------------------------------------
		// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r Flugnummern bezogene Beladung
		// ---------------------------------------------------------------
		
		// DB 11.07.2008: Bei Job_Type = 11 spielt die unit keine Rolle, 
		// daher muss hier ein anderes DW verwendet werden.
		if iJob_Type = 11 or dsCenOut.Getitemnumber(i,"nmanual_input") = 1 then
			//HR 02.09.2008: CBASE-ML-EM-0140
			//Falls keine Supplierunits $$HEX1$$fc00$$ENDHEX$$bergeben wurden der aktuelle Betrieb $$HEX1$$fc00$$ENDHEX$$bernehmen
			if upperbound(sSupp_Units) =0 then sSupp_Units[1]=sUnit
			//Handlingobjecte f$$HEX1$$fc00$$ENDHEX$$r alle SuppliererUnits holen
			dsHandlingObjects.DataObject = "dw_generate_handling_objects_supunits"
			dsHandlingObjects.setTransObject(SQLCA)
			dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate, sSupp_Units)
		else
			dsHandlingObjects.DataObject = "dw_generate_handling_objects"
			dsHandlingObjects.setTransObject(SQLCA)
			dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate,sUnit)
		end if
		
		dsHandlingObjects.SetFilter(sFrequenz)
		dsHandlingObjects.Filter()
		// ---------------------------------------------------------------
		// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r City Pair bezogene Beladung
		// ---------------------------------------------------------------
		// DB 11.07.2008: Bei Job_Type = 11 spielt die unit keine Rolle, 
		// daher muss hier ein anderes DW verwendet werden.
		if iJob_Type = 11  or dsCenOut.Getitemnumber(i,"nmanual_input") = 1 then
			//HR 02.09.2008: CBASE-ML-EM-0140
			//Falls keine Supplierunits $$HEX1$$fc00$$ENDHEX$$bergeben wurden der aktuelle Betrieb $$HEX1$$fc00$$ENDHEX$$bernehmen
			if upperbound(sSupp_Units) =0 then sSupp_Units[1]=sUnit
			dsHandlingObjects_CP.DataObject = "dw_generate_handling_objects_supunits"
			dsHandlingObjects_CP.setTransObject(SQLCA)
			dsHandlingObjects_CP.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, sSupp_Units)
		else
			dsHandlingObjects_CP.DataObject = "dw_generate_handling_objects"
			dsHandlingObjects_CP.setTransObject(SQLCA)
			dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, sUnit)
		end if
		
		dsHandlingObjects_cp.SetFilter(sFrequenz)
		dsHandlingObjects_cp.Filter()
		// ------------------------
		// Message an Window
		// ------------------------
		If bSendMessage Then
			sPostMessage = "Execute job handling objects, for unit: " + sUnit + " Airline: " + sAirline + " Job ID: " + string(iJob_Type)
			w_cbase_generate_dialog.triggerevent("ue_redraw")
			yield()	
		End if	

		// -------------------------------------------------------------------------------------
		// 07.03.2011, HR: Auch das muss noch nach vorne
		// Alle Abfertigungsarten bei denen die Passagierzahlen auf 0 gesetzt werden sollen
		// definieren
		// -------------------------------------------------------------------------------------
		sCurrentHandling				= dsCenOut.Getitemstring(i,"chandling_type_text")
		lFlightStatus					= dsCenOut.Getitemnumber(i,"nflight_status")
		// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014
		if sCurrentHandling = "STD" or sCurrentHandling = "DLV" or sCurrentHandling = "REQ" or sCurrentHandling = "SPC"  or sCurrentHandling = "INT" then
			iDontGeneratePaxCounts	= 1
		else
			iDontGeneratePaxCounts	= 0
		end if

		// ---------------------------------------------------------------		 
		// Default Aircraft Version oder aktuelle Version eintragen
		// HR 09.02.2011 Zuerst die Version setzen, dann LL und SLL ermitteln
		// ---------------------------------------------------------------		 
		If not of_generate_version(i) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't create aircraft version." )
		End if			
		
		// ---------------------------------------------------------------		 
		// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Loadinglist 
		// ---------------------------------------------------------------	
		If not of_generate_handling_one(i) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"This flight has no basic loading list." )
		End if

		// --------------------------------------------------------------------------------------------------------------------
		// 24.01.2014 HR: CBASE-DE-EM-13010: Wir pr$$HEX1$$fc00$$ENDHEX$$fen hier noch mal auf die Abart, da es sein kann, dass
		//                                                         sich die ABART ge$$HEX1$$e400$$ENDHEX$$ndert hat, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir die Paxe 
		//                                                         nachtr$$HEX1$$e400$$ENDHEX$$glich noch auf 0 setzen
		// --------------------------------------------------------------------------------------------------------------------
		sCurrentHandling			= dsCenOut.Getitemstring(i,"chandling_type_text")
		lFlightStatus					= dsCenOut.Getitemnumber(i,"nflight_status")
		// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014
		if sCurrentHandling = "STD" or sCurrentHandling = "DLV" or sCurrentHandling = "REQ" or sCurrentHandling = "SPC"  or sCurrentHandling = "INT" then
			of_trace("of_generate_handling_objects", 1,ls_rowcount+sOut +" PaxReset because REQ-FLight")
			iDontGeneratePaxCounts	= 1
			dsCenOutPax.setfilter("nresult_key = "+string(lResultKey))
			dsCenOutPax.filter()
			for j = 1 to dsCenOutPax.rowcount()
			 	dsCenOutPax.setitem(j,"npax",0)
			next
			dsCenOutPax.setfilter("")
			dsCenOutPax.filter()
		end if


		// ---------------------------------------------------------------		 
		// Handlingobjekte Supplement Loadinglist
		// ---------------------------------------------------------------	
		If not of_generate_handling_two(i) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't access supplement loading list." )
		End if
		
		// ---------------------------------------------------------------		 
		// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Station Instruction
		// ---------------------------------------------------------------		 
		If not of_generate_handling_si_qaq() Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't access station instruction." )
		End if

		// --------------------------------------------------------------------------------
		// 02.09.2009 HR: Wenn SPMLs $$HEX1$$fc00$$ENDHEX$$bertragen werden sollen, dann werden
		//                        hier die Datastores gef$$HEX1$$fc00$$ENDHEX$$llen
		// --------------------------------------------------------------------------------
		dsCenOutNewSPMLDetail	= uo_generate_meals.dsSPMLDetail
		
		if iImportSpmls = 1 then
			
			// --------------------------------------------------------------------------------------------------------------------
			// 08.02.2016 HR: CBASE-DE-CR-2015-052 SPMLs aus der betrieblichen Prognose einspielen
			// --------------------------------------------------------------------------------------------------------------------
			if iPaxType= 4 then
				
				if not of_generate_spml_from_extern(i) then
					of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
									string(lFlightNumber),&
									string(dGenerationDate,s_app.sDateformat),&
									"Can't create spml's." )			
				end if
			else
				if not of_generate_spml_from_citp(i) then
					of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
									string(lFlightNumber),&
									string(dGenerationDate,s_app.sDateformat),&
									"Can't create spml's." )			
				end if
			end if
		end if
		
		// ---------------------------------------------------------------		 
		// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Zeitungsbeladung aufl$$HEX1$$f600$$ENDHEX$$sen
		// Achtung: Mu$$HEX2$$df002000$$ENDHEX$$nach Default Aircraft Version laufen!
		// ---------------------------------------------------------------		 
		If not of_generate_handling_newspaper() Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't access newspaper loading List." )
		End if			
		
		// ---------------------------------------------------------------		 
		// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Mahlzeitenobjekte (Module_type = 0)
		// und Extrabeladung (Module_type = 1) aufl$$HEX1$$f600$$ENDHEX$$sen
		// ---------------------------------------------------------------
		
		// 25.09.2012 HR: noch ben$$HEX1$$f600$$ENDHEX$$tigte Felder f$$HEX1$$fc00$$ENDHEX$$llen
		lTlcfrom	= dsCenOut.Getitemnumber(i,"ntlc_from")
		lTlcTo	= dsCenOut.Getitemnumber(i,"ntlc_to")

		// 25.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen lesen (CBASE-NAM-CR-11009)
		// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling: Result_key wird ben$$HEX1$$f600$$ENDHEX$$tigt
		uo_generate_meals.uf_retrieve_local_subst( sUnit, lAirlineKey, lFlightNumber, sSuffix, dGenerationDate, sDepartureTime, lAircraftKey, &
     	                                                                lRoutingID, lTlcfrom, lTlcTo, lHandlingTypeKey, lResultkey)

		// Reset Meals-Datastore erst nach update der History
		// (in of_update_history)
		//	uo_generate_meals.dsCenOutMeals.Reset()

		If not of_generate_handling_meals(0, strChange, ls_rowcount) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't access meal loading." )
		End if		

		// 15.01.2016 HR: An diese Stelle nach der Mahlzeitengenerierung gezogen
		// Neu: $$HEX1$$dc00$$ENDHEX$$berbeladung mu$$HEX2$$df002000$$ENDHEX$$an dieser Stelle - n$$HEX1$$e400$$ENDHEX$$mlich ganz am Ende - abgezogen werden
		If not of_reduce_overload(strChange) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't reduce overload." )
		End if			

		If not of_generate_handling_meals(1, strChange, ls_rowcount) Then
			of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
								string(lFlightNumber),&
								string(dGenerationDate,s_app.sDateformat),&
								"Can't access extra loading." )
		End if			
		
		
		//dsCenOut.setitem(i,"nlocal_sub",uo_generate_meals.il_nlocal_sub_flight) // 25.09.2012 HR: Kennzeichen ob Lokalen Ersetzungen durchgef$$HEX1$$fc00$$ENDHEX$$hrt wurden an Flug merken(CBASE-NAM-CR-11009)
		
		if iImportSpmls = 1 then

			// --------------------------------------------------------------------------------
			// 30.10.2009 HR: Zuerst die CHDs noch einarbeiten
  			// --------------------------------------------------------------------------------
			if iChildrenFC >0 then
				uo_generate_meals.dsCenOutMeals.setfilter("nresult_key = "+string(lResultKey) +"  and nmodule_type = 1")
				uo_generate_meals.dsCenOutMeals.filter()

				//Zuerst m$$HEX1$$fc00$$ENDHEX$$ssen wir die Extrabeladung f$$HEX1$$fc00$$ENDHEX$$r den Flug filtern
				 
				long lPLIndexKey,lFind, lFunctioncode
				Datastore								dsPackinglistFunctions	// St$$HEX1$$fc00$$ENDHEX$$cklisten der Extrabeladung, die 
																								 // automatisch ver$$HEX1$$e400$$ENDHEX$$ndert werden.
				dsPackinglistFunctions								= Create DataStore
				dsPackinglistFunctions.DataObject 				= "dw_change_packinglist_function"
				dsPackinglistFunctions.SetTransObject(SQLCA)
				
				dsPackinglistFunctions.Retrieve(dReturnFlightDate)
				
				//==============================================================================================
				// Extrabeladung reagiert auf bestimmte Schl$$HEX1$$fc00$$ENDHEX$$sselnummern,
				//==============================================================================================
				if dsPackinglistFunctions.RowCount() > 0 then
					for j = 1 to uo_generate_meals.dsCenOutMeals.RowCount()
						
						lPLIndexKey = uo_generate_meals.dsCenOutMeals.GetItemNumber(j,"npackinglist_index_key")
						lFind = dsPackinglistFunctions.Find("npackinglist_index_key = " + string(lPLIndexKey),1,dsPackinglistFunctions.RowCount())
						if lFind > 0 then
							lFunctioncode = dsPackinglistFunctions.GetItemNumber(lFind,"nfunction")
							choose Case lFunctioncode
								case 1
									uo_generate_meals.dsCenOutMeals.SetItem(j,"nquantity",iChildrenFC)
									uo_generate_meals.dsCenOutMeals.SetItem(j,"nmanual_input",1)
									of_trace("of_generate_handling_objects", 50,ls_rowcount+"CHD-Import: "+string(iChildrenFC)+"x CHD in Extrabeladung")
							end choose
						end if
					next
				end if
				
				destroy dsPackinglistFunctions
				garbagecollect() // 20.06.2012 HR:
			end if
			
			
			// --------------------------------------------------------------------------------
			// 20.11.2009 HR: Jetzt m$$HEX1$$fc00$$ENDHEX$$ssen noch die SPMLs gepr$$HEX1$$fc00$$ENDHEX$$ft werden, ob sie
			//                        $$HEX1$$fc00$$ENDHEX$$berhaupt erlaubt sind.
			// --------------------------------------------------------------------------------
			i2=uo_generate_meals.dsCenOutMeals.setfilter("nresult_key = "+string(lResultKey) +"  and nmodule_type = 0")
			i2=uo_generate_meals.dsCenOutMeals.filter()
			
			i2=dsCenOutNewSPML.setfilter("nresult_key = "+string(lResultKey)  )
			i2=dsCenOutNewSPML.filter()
		
			dsValidSPMLDetail								= Create DataStore
			dsValidSPMLDetail.DataObject 				= "dw_change_valid_spml_details"
			dsValidSPMLDetail.SetTransObject(SQLCA)	
			
			for i2 = 1 to dsCenOutNewSPML.rowcount()
				lsSPML = dsCenOutNewSPML.GetItemString(i2,"cspml")
				lsClass = dsCenOutNewSPML.GetItemString(i2,"cclass")
				lFindDef = 0
				lhmealkeyold = 0	
				for j = 1 to uo_generate_meals.dsCenOutMeals.RowCount()
					if uo_generate_meals.dsCenOutMeals.GetItemString(j,"cclass") = lsClass then
						lhmealkey = uo_generate_meals.dsCenOutMeals.GetItemNumber(j,"nhandling_meal_key")
						if lhmealkey <> lhmealkeyold then
							dsValidSPMLDetail.Retrieve(lhmealkey,dGenerationDate)
							lFindDef = dsValidSPMLDetail.Find("sys_spml_cspml = '" + lsSPML + "'",1,dsValidSPMLDetail.RowCount())
							if lFindDef > 0 then
								exit
							end if
							lhmealkeyold = lhmealkey
						end if
					end if
				next
				if lFindDef = 0 then
					of_trace("of_generate_handling_objects", 6,ls_rowcount+sOut+": "+lsClass+" "+lsSPML+" nicht zul$$HEX1$$e400$$ENDHEX$$ssig in Verbindung mit den angewiesenen Mahlzeiten!")
					dsCenOutNewSPML.SetItem(i2,"cspml","CNX")
				end if
			next
			
			for j = dsCenOutNewSPML.RowCount() to 1 step -1
				if dsCenOutNewSPML.GetItemString(j,"cspml") = "CNX" then
					dsCenOutNewSPML.DeleteRow(j)
				end if
			next
			
			destroy dsValidSPMLDetail
			garbagecollect()
			
			dsCenOutNewSPML.sort()
			dsCenOutNewSPML.groupcalc()
			
			// --------------------------------------------------------------------------------
			// 20.11.2009 HR: Zuletzt noch die SPML-Zahlen in der Pax-Tabelle anpassen
			// --------------------------------------------------------------------------------
	
			i2=dsCenOutPax.setfilter("nresult_key = "+string(lResultKey)  )
			i2=dsCenOutPax.filter()

			for j=1 to dsCenOutPax.rowcount()
				lFindDef = dsCenOutNewSPML.find("nclass_number = " + string(dsCenOutPax.getitemnumber(j,"nclass_number")), 1, dsCenOutNewSPML.rowcount())
				
				if lFindDef>0 then
					dsCenOutPax.Setitem(j,"npax_spml",dsCenOutNewSPML.getitemnumber(lFindDef,"compute_sum"))	
					dsCenOutPax.Setitem(j,"npax_spml_forecast",dsCenOutNewSPML.getitemnumber(lFindDef,"compute_sum"))	
				else
					dsCenOutPax.Setitem(j,"npax_spml",0)	
					dsCenOutPax.Setitem(j,"npax_spml_forecast",0)	
					
				end if
			next
			
			i2=dsCenOutPax.setfilter("" )
			i2=dsCenOutPax.filter()
			uo_generate_meals.dsCenOutMeals.setfilter("")
			uo_generate_meals.dsCenOutMeals.filter()
			
			dsCenOutNewSPML.rowscopy(1, dsCenOutNewSPML.rowcount(),primary!, dsCenOutAllSPML, 1,primary!)
			dsCenOutNewSPMLDetail.rowscopy(1, dsCenOutNewSPMLDetail.rowcount(),primary!, dsCenOutAllSPMLDetail, 1,primary!)
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 22.09.2011 HR: GGF die PPM Daten erzeugen
		// --------------------------------------------------------------------------------------------------------------------
		of_generate_ppm(i)
		
	End if						

Next

// 15.01.2016 HR: Nicht ganz am Ende, sondern nach der Mahlzeitengenerierung
//// Neu: $$HEX1$$dc00$$ENDHEX$$berbeladung mu$$HEX2$$df002000$$ENDHEX$$an dieser Stelle - n$$HEX1$$e400$$ENDHEX$$mlich ganz am Ende - abgezogen werden
//If not of_reduce_overload(strChange) Then
//	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline + " " + &
//						string(lFlightNumber),&
//						string(dGenerationDate,s_app.sDateformat),&
//						"Can't reduce overload." )
//End if			

of_trace_flight("of_generate_handling_objects","Finish")

return True
end function

public function long of_get_schedule_key ();// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Flugplan ermitteln
// lFlightScheduleTime = 0 GMT
//							  = 1 Local
// ---------------------------------------------------------
	Long lKey
	
	

	SELECT nschedule_index,ntime_local_utc
	  INTO :lKey,:lFlightScheduleTime
	  FROM cen_schedule_definition  
	 WHERE ( cen_schedule_definition.dvalid_from <= :dGenerationDate) AND  
			 ( cen_schedule_definition.dvalid_to   >= :dGenerationDate) AND  
			 ( cen_schedule_definition.nairline_key = :lAirlineKey ) ;


	If sqlca.sqlcode = 0 then
		return lKey
	Else
		return -1
	end if

end function

public function boolean of_generate_schedule (boolean bcheck);//=====================================================================================
//
// of_generate_schedule
//
// Neuanlage oder Update eines Tagesflugplans pro Betrieb
//
// Parameter bCheck = True  Pr$$HEX1$$fc00$$ENDHEX$$fung, ob der Job bereits gelaufen ist
//				 bCheck = False keine Pr$$HEX1$$fc00$$ENDHEX$$fung
//
//=====================================================================================
long		lSQLCode
long		lSQLRow 
string		sSQLText

long		i
integer	liLegnumber
string		lsAccountCode
long		llAccountKey
string		ls_GenerateRoutingPlan

// --------------------------------------------------------------------------------------------------------------------
// 01.11.2010 HR: Falls es eine Generierung f$$HEX1$$fc00$$ENDHEX$$r heute oder in der 
//                           Vergangenheit sein soll, dann machen wir das nicht
//					   (Kann bei der Einmalgenerierung vorkommen)
// --------------------------------------------------------------------------------------------------------------------
if iDays_Offset <1 then 
   of_trace("of_generate_schedule", 1, "Offset "+string(iDays_Offset)+" is less than 1, so job is ignored.") 
   return false
end if

// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
//bCheck = False
If bCheck Then
	If of_job_executed() Then
		return False
	End if	
End if	

// --------------------------------------------------------------------------------------------------------------------
// 20.10.2009 HR: Alle Datastores reseten, dass bei einem Fehler nichts stehen bleibt.
// --------------------------------------------------------------------------------------------------------------------
dsCenOut.Reset()
dsCenOutHandling.Reset()
dsCenOutQaq.Reset()
dsCenOutHandlingNews.Reset()
dsCenOutNewsExtra.Reset()
dsCenOutPax.Reset()
dsCenOutCheckPt.Reset() // 13.11.2015 HR: M$$HEX1$$fc00$$ENDHEX$$ssen wir auch reseten

if isvalid(uo_generate_meals) then
	if isvalid(uo_generate_meals.dsCenOutMeals) then
		uo_generate_meals.dsCenOutMeals.Reset()
	end if
end if

// 29.04.2011 HR:
dsCenOutQp.Reset()
dsCenOutAllSPML.Reset()
dsCenOutAllSPMLdetail.Reset()
dsCenOutLos.Reset()
dsCenOutPackets.Reset()

// 23.05.2012 HR:
dsCenOutPPM.Reset()
dsCenOutPPMStowages.Reset()
dsCenOutPPMMD.Reset()

dsCenOut.setfilter("")
dsGenerateRoutingPlan.setfilter("")

// --------------------------------------------------------------------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Streckenplan ermitteln und das Charter- und CFS-Flag setzen
// 02.07.2013 HR: Vor die of_get_schedule_key gesetzt, damit wir wissen, ob wir den Flugplan
//                        $$HEX1$$fc00$$ENDHEX$$berhaupt brauchen
// --------------------------------------------------------------------------------------------------------------------
lRoutingPlanKey = of_get_routingplan_key()
If lRoutingPlanKey = -1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"No valid loading definition key available.")
	return False
End if	

// --------------------------------------------------------------------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Flugplan ermitteln
// --------------------------------------------------------------------------------------------------------------------
lScheduleKey = of_get_schedule_key()

// --------------------------------------------------------------------------------------------------------------------
// 02.07.2013 HR: Falls wir ohne Flugplan generieren, dann ist das kein Abbruchkriterium, wenn wir
//                        keinen g$$HEX1$$fc00$$ENDHEX$$ltigen Flugplan finden
// --------------------------------------------------------------------------------------------------------------------
If lScheduleKey = -1 and ib_CFSWithoutFlightplan = false Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"No valid flight schedule key available.")
	return False
End if	

// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r die History ermitteln
// ---------------------------------------------------------
lTransActionKey = of_get_history_key()
If lTransActionKey = -1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat),&
							"No valid loading history key available.")
	return False
End if

// ---------------------------------------------------------
// Retieve Traffic Areas
// ---------------------------------------------------------
bUseOwner4TrafficArea = of_use_owner_for_trafficarea( s_app.smandant , lairlinekey) // 18.11.2010 OH:
dsTrafficAreas.Retrieve(lAirlineKey,dGenerationdate)

// ---------------------------------------------------------
// Retrieve auf interne Zeiten
// ---------------------------------------------------------
dsLocalTimes.Retrieve(sClient,sUnit,lAirlineKey)	
dsLocalTimesFlights.Retrieve(sClient,sUnit,lAirlineKey)	

// 26.11.2014 HR: Neuer Schalter, ob bei der Generierung die Resultkeys der letzten Generierung wiederverwendet werden sollen
//ii_resuse_resultkeys = integer(f_mandant_profilestring(sqlca, sClient, "Generierung","ReUseResultkeys","0"))
ii_resuse_resultkeys = 1 // 19.03.2015 HR: Mit 5.10 wollen wir immer recyceln.

if ii_resuse_resultkeys = 1 then
	of_trace("of_generate_schedule", 1,"Reuse NRESULT_KEY is on.")
end if

// 26.11.2014 HR: Neuer Schalter, ob bei der Generierung der Mahlzeiten die neuen DWs genutzt werden sollen
ii_new_cfs_handlinggen = integer(f_mandant_profilestring(sqlca, sClient, "Generierung","NewCFSHandlingGen","0"))
if ii_new_cfs_handlinggen = 1 then
	of_trace("of_generate_schedule", 1,"NewCFSHandlingGen is on.")
end if

// 07.07.2009 HR: Alte nresult_keys merken
dsResultkeys.retrieve(sClient,sUnit,lAirlineKey, dGenerationdate )

// --------------------------------------------------------------------------------------------------------------------
// Retrieve auf Flugger$$HEX1$$e400$$ENDHEX$$te die nicht generiert werden sollen
// --------------------------------------------------------------------------------------------------------------------
dsGenerateNonACType.Retrieve(sClient,sUnit,lAirlineKey,dGenerationdate)

// ---------------------------------------------------------
// Retrieve Airline Classes
// ---------------------------------------------------------
dsAirlineClasses.Retrieve(lAirlineKey)	
If dsAirlineClasses.Rowcount() <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,&
							string(dGenerationDate,s_app.sDateformat), &
							"No valid airline classes available.")
	return False
End if

// ---------------------------------------------------------
// Retrieve Central Forecast
// ---------------------------------------------------------
dsCentralForecast.Retrieve(lAirlineKey,dGenerationDate)		

// ---------------------------------------------------------
// Retrieve Local Forecast
// ---------------------------------------------------------
dsLocalForecast.Retrieve(lAirlineKey,dGenerationDate)	

// ---------------------------------------------------------
// Retrieve Customer Codes (19.01.05)
// ---------------------------------------------------------
dsCustomerCodes.Retrieve(dGenerationDate)

// --------------------------------------------------------------------------------------------------------------------
// Zwischenspeicher f$$HEX1$$fc00$$ENDHEX$$r die Defaultabfertigungsarten l$$HEX1$$f600$$ENDHEX$$schen
// --------------------------------------------------------------------------------------------------------------------
dsHandlingTypeCache.Reset()

// 03.09.2009 HR:
dsCenOutNewSPML = create uo_generate_datastore
dsCenOutNewSPML.dataobject = "dw_change_cen_out_spml"
dsCenOutNewSPML.settransobject(SQLCA)

dsValidSPML  = create datastore
dsValidSPML.dataobject = "dw_change_valid_spml"
dsValidSPML.settransobject(SQLCA)
dsValidSPML.Retrieve(sClient)

// --------------------------------------------------------------------------------------------------------------------
// 14.10.2015 HR: Vor der Generierung setzen wir alle offene OE-, FC- und DE-Jobs auf IGNORE
// --------------------------------------------------------------------------------------------------------------------
of_set_jobs_to_ignore(0)

// --------------------------------------------------------------------------------------------------------------------
// Erstellung der Fl$$HEX1$$fc00$$ENDHEX$$ge	CEN_OUT
// 01.10.2010 HR: Bei gesetztem Schalter neue CFS-Generierung 
//                           ansonsten wie gehabt
// --------------------------------------------------------------------------------------------------------------------
if bCFSAirline then
	of_trace("of_generate_schedule", 1,"Generate with CFS-Roles "+is_schedule_parameter)
	ls_GenerateRoutingPlan = dsGenerateRoutingPlan.dataobject 
	
	destroy dsGenerateRoutingPlan
	dsGenerateRoutingPlan					= Create DataStore
	dsGenerateRoutingPlan.dataobject 		= "dw_generate_routingplan_cfs"
	dsGenerateRoutingPlan.settransobject(SQLCA)

	destroy dsGenerateSchedule
	dsGenerateSchedule					= Create DataStore
	
	// --------------------------------------------------------------------------------------------------------------------
	// 12.10.2011 HR: Sollte ohne Flugplan generiert werden, dann nehmen
	//                           wir ein Flugplandatawindow aus den CFS-Daten
	// --------------------------------------------------------------------------------------------------------------------
	if ib_CFSWithoutFlightplan then
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_cfs"
	else
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_all"
	end if

	dsGenerateSchedule.SetTransObject(SQLCA)

	of_generate_flights_cfs()

	destroy dsGenerateRoutingPlan
	dsGenerateRoutingPlan					= Create DataStore
	dsGenerateRoutingPlan.dataobject 		= ls_GenerateRoutingPlan
	dsGenerateRoutingPlan.settransobject(SQLCA)	

	destroy dsGenerateSchedule
	dsGenerateSchedule						= Create DataStore
	dsGenerateSchedule.DataObject 		= "dw_generate_schedule"
	dsGenerateSchedule.SetTransObject(SQLCA)

	destroy dsExtCatSched // 20.06.2012 HR:
	garbagecollect()

	of_trace("of_generate_schedule", 10,"Rows in dsCenOut after creation (cfs): "+string(dsCenOut.rowcount()))
else
	of_trace("of_generate_schedule", 1,"Generate with Standard-Roles "+is_schedule_parameter)
	of_generate_flights()
	of_trace("of_generate_schedule", 10,"Rows in dsCenOut after creation: "+string(dsCenOut.rowcount()))
end if
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_generate_schedule_1_ds_cen_out_after_generate_flights"+string(now(),"hhmmss")+".xls", excel5!, true)

// --------------------------------------------------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung der generierten Daten vor dem Speichern
// --------------------------------------------------------------------------------------------------------------------
of_trace_flight("of_generate_schedule","of_validation start") // 21.06.2012 HR:

of_validation()

of_trace_flight("of_generate_schedule","of_validation finish") // 21.06.2012 HR:

of_trace("of_generate_schedule", 10,"Rows in dsCenOut after validation: "+string(dsCenOut.rowcount()))
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_generate_schedule_2_ds_cen_out_after_validation"+string(now(),"hhmmss")+".xls", excel5!, true)

// --------------------------------------------------------------------------------------------------------------------
// HR 26.08.2008: CBASE-DE-EM-2046: Legnummer neu durchnummerieren und Zeiten anpassen
// --------------------------------------------------------------------------------------------------------------------
of_reorg_legs()
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_generate_schedule_3_ds_cen_out_after_reorg"+string(now(),"hhmmss")+".xls", excel5!, true)
of_trace("of_generate_schedule", 1,"Rows in dsCenOut after reorg_legs: "+string(dsCenOut.rowcount()))

// ---------------------------------------------------------
// alle Handling-Objects ermitteln
// ---------------------------------------------------------
of_generate_handling_objects()
of_trace("of_generate_schedule", 1,"Rows in dsCenOut after create handling: "+string(dsCenOut.rowcount()))
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_generate_schedule_4_ds_cen_out_after_handling"+string(now(),"hhmmss")+".xls", excel5!, true)

//-------------------------------------------------------------------------------------
// Setze VonAnCode von Leg 1 auf alle Folgelegs
//-------------------------------------------------------------------------------------
for i = 1 to dsCenOut.RowCount()
	liLegnumber		= dsCenOut.GetItemNumber(i,"NLEG_NUMBER")
	if liLegnumber = 1 then
		lsAccountCode 	= dsCenOut.GetItemString(i,"caccount")
		llAccountKey 	= dsCenOut.GetItemNumber(i,"naccount_key")
	else
		dsCenOut.SetItem(i,"caccount",lsAccountCode)
		dsCenOut.SetItem(i,"naccount_key",llAccountKey)
	end if
next

// ---------------------------------------------------------
// Update auf alle Datastores dsCen ....
// ---------------------------------------------------------	
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"cen_out_upd.xls", excel5!, true)

// 23.06.2009 HR: Erstellen der QPs f$$HEX1$$fc00$$ENDHEX$$r die angelegten Fl$$HEX1$$fc00$$ENDHEX$$ge
of_generate_qp()

// 07.07.2009 HR: Result_keys in den Tabellen CEN_REQUEST und CEN_OUT_QP anpassen
of_regen_keys()

// --------------------------------------------------------------------------------------------------------------------
// 14.01.2015 HR: ggf. Daten f$$HEX1$$fc00$$ENDHEX$$r Flightchecker erzeugen
// --------------------------------------------------------------------------------------------------------------------
if ii_create_checkpts  = 1 then
	if of_create_checkpts()<> 1 then
		return false	
	end if
end if

of_trace_flight("of_generate_schedule","of_update start") // 21.06.2012 HR:

If not of_update() Then
	rollback using sqlca;	
	return False
End if

of_trace_flight("of_generate_schedule","of_update finish")// 21.06.2012 HR:

// --------------------------------------------------------------------------------
// 08.01.2009 HR: Pr$$HEX1$$fc00$$ENDHEX$$fprotokoll Generierung
// --------------------------------------------------------------------------------
i= of_write_flights()

// --------------------------------------------------------------------------------------------------------------------
// Update auf alle Datastores dsCen .. History
// --------------------------------------------------------------------------------------------------------------------
of_trace_flight("of_generate_schedule","of_update_history start") // 21.06.2012 HR:

If not of_update_history() Then
	rollback using sqlca;	
	return False
End if
of_trace_flight("of_generate_schedule","of_update_history finish") // 21.06.2012 HR:

// 03.09.2009 HR:
destroy dsCenOutNewSPML
destroy dsValidSPML

// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()

// 20.11.2012 HR: wenn eingeschaltet und Generierung erfolgrech, dann Auftrag f$$HEX1$$fc00$$ENDHEX$$r FlightCalc erstelllen
if ii_aut_mahlzeitenverteilung = 1 then
	if not of_generate_flightcalcjobs() then
		return false
	end if
end if

// 17.12.2014 HR: Nicht mehr bei der Fluggenerierung, sondern nach der SL-Aufl$$HEX1$$f600$$ENDHEX$$sung bzw. Asynchgen
//// 17.12.2013 HR: Sollen IDOC-Auftr$$HEX1$$e400$$ENDHEX$$ge erstellt werden?
//if ii_orders_transfer = 1 then
//	if not of_generate_idocjobs() then
//		return false
//	end if
//end if

// 09.01.2014 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen und erstellen ggf. Auftr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r die SKY-Telex-Send_QUEUE
of_generate_skytelexsendjobs()

// --------------------------------------------------------------------------------------------------------------------
// 03.08.2010 HR: Nur bei Jobs au$$HEX1$$df00$$ENDHEX$$er Asynchrone Generierung
// --------------------------------------------------------------------------------------------------------------------
if  iJob_Type <> 170 then
	If not of_write_Job_history() Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
		rollback using sqlca;
		return False
	Else
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully generated in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		of_trace("of_generate_schedule", 1, "Successfully generated "+string(dsCenOut.rowcount())+" Flights in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		commit using sqlca;
		return True
	End if
else
	return true
end if
end function

public function boolean of_set_internal_times ();// ------------------------------------------------------------
// Interne Zeiten ermitteln
// Rampen und K$$HEX1$$fc00$$ENDHEX$$chenzeiten werden zuerst $$HEX1$$fc00$$ENDHEX$$ber
// Flugnummer gesucht anschlie$$HEX1$$df00$$ENDHEX$$end $$HEX1$$fc00$$ENDHEX$$ber Airline und Strecke
// ------------------------------------------------------------
long 		lRow
string	sSearch
long		lRampOffset		= 0
long		lKitchenOffset	= 0
time		iInternal
long		lDepartureSeconds
long		lDiff
long		lHour,lSeconds

	
// --------------------------------------------------------------------------------------------------------------------
// 15.02.2012 HR: Wenn alte Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeit gesetzt sind, dann 
//                           nehmen wir diese, ansonsten wie bisher
// --------------------------------------------------------------------------------------------------------------------
if ls_old_ramp_time <> ""	and ls_old_kitchen_time 	<> "" then

	sRampTime		= ls_old_ramp_time
	sKitchenTime 	= ls_old_kitchen_time
	
else	
	
	// ------------------------------------------------------------
	// suche nach Flugnummer
	// ------------------------------------------------------------
	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

	If Len(Trim(sSuffix)) = 0 Then
		sSearch = "nflight_number = " + string(lFlightnumber)
	Else
		sSearch = "nflight_number = " + string(lFlightnumber) + &
					 " and csuffix = '" + sSuffix + "'"
	End if
	
	lRow = dsLocalTimesFlights.Find(sSearch,1,dsLocalTimesFlights.RowCount())
	
	if lRow > 0 then
		lRampOffset				= dsLocalTimesFlights.GetitemNumber(lRow,"nramp_time") * 60
		lKitchenOffset			= dsLocalTimesFlights.GetitemNumber(lRow,"nkitchen_time") * 60
	Else
		// ------------------------------------------------------------
		// suche nach Strecke
		// ------------------------------------------------------------
		sSearch = "nrouting_id = " + string(LRoutingId)
		lRow = dsLocalTimes.Find(sSearch,1,dsLocalTimes.RowCount())
		if lRow > 0 then
			lRampOffset				= dsLocalTimes.GetitemNumber(lRow,"nramp_time") * 60
			lKitchenOffset			= dsLocalTimes.GetitemNumber(lRow,"nkitchen_time") * 60
		end if
	End if
	
	If lRow <= 0 Then
		// ------------------------------------------------------------
		// Ok, wurde nicht gepflegt dann halt Abflugzeit !
		// ------------------------------------------------------------	
		sRampTime			= sDepartureTime
		sKitchenTime		= sDepartureTime
		return False
	End if	

	lHour						= Hour(Time(sDepartureTime)) * 3600
	lSeconds					= Minute(Time(sDepartureTime)) * 60
	lDepartureSeconds		= lHour + lSeconds + lRampOffset + 60
			
	If lDepartureSeconds < 0 Then
		sRampTime			= string(RelativeTime(Time("23:59:59"),lDepartureSeconds),"hh:mm")
	Else
		sRampTime			= string(RelativeTime(Time(sDepartureTime),lRampOffset),"hh:mm")
	End if	
	
	lHour						= Hour(Time(sDepartureTime)) * 3600
	lSeconds					= Minute(Time(sDepartureTime)) * 60
	lDepartureSeconds		= lHour + lSeconds + lKitchenOffset + 60
			
	If lDepartureSeconds < 0 Then
		sKitchenTime		= string(RelativeTime(Time("23:59:59"),lDepartureSeconds),"hh:mm")
	Else
		sKitchenTime		= string(RelativeTime(Time(sDepartureTime),lKitchenOffset),"hh:mm")
	End if	
end if

return True
		

	
	

end function

public function integer of_change_internal_times ();// ---------------------------------------------------------
//
// of_change_internal_times
//
// ---------------------------------------------------------
	long 		lRow
	string	sSearch
	long		lRampOffset		= 0
	long		lKitchenOffset	= 0
	time		iInternal
	long		lDepartureSeconds
	long		lDiff
	long		lHour,lSeconds

// --------------------------------------------------------------------------------------------------------------------
// 15.02.2012 HR: Falls Schalter =0 (bisher keine $$HEX1$$c400$$ENDHEX$$nderung der Rampenzeit)
//                           dann wie bisher, ansonsten nur K$$HEX1$$fc00$$ENDHEX$$chenzeit nach Rampenzeit
//                           errechnen
// --------------------------------------------------------------------------------------------------------------------
if dsCenOut.getitemnumber(1,"nblock_ramp_time")=0 then

	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

	// ---------------------------------------------------------
	// Retrieve auf interne Zeiten
	// ---------------------------------------------------------
	dsLocalTimes.Retrieve(sClient,sUnit,lAirlineKey)	
	dsLocalTimesFlights.Retrieve(sClient,sUnit,lAirlineKey)	

	// ------------------------------------------------------------
	// suche nach Flugnummer
	// ------------------------------------------------------------
	If Len(Trim(sSuffix)) = 0 Then
		sSearch = "nflight_number = " + string(lFlightnumber)
	Else
		sSearch = "nflight_number = " + string(lFlightnumber) + &
					 " and csuffix = '" + sSuffix + "'"
	End if
	lRow = dsLocalTimesFlights.Find(sSearch,1,dsLocalTimesFlights.RowCount())
	if lRow > 0 then
		lRampOffset				= dsLocalTimesFlights.GetitemNumber(lRow,"nramp_time") * 60
		lKitchenOffset			= dsLocalTimesFlights.GetitemNumber(lRow,"nkitchen_time") * 60
	Else
		// ------------------------------------------------------------
		// suche nach Strecke
		// ------------------------------------------------------------
		sSearch = "nrouting_id = " + string(LRoutingId)
		lRow = dsLocalTimes.Find(sSearch,1,dsLocalTimes.RowCount())
		if lRow > 0 then
			lRampOffset				= dsLocalTimes.GetitemNumber(lRow,"nramp_time") * 60
			lKitchenOffset			= dsLocalTimes.GetitemNumber(lRow,"nkitchen_time") * 60
		end if
	End if

	If lRow <= 0 Then
		// ------------------------------------------------------------
		// Ok, wurde nicht gepflegt dann halt Abflugzeit !
		// ------------------------------------------------------------	
		sRampTime			= sDepartureTime
		sKitchenTime		= sDepartureTime
		return -1
	End if	

	lHour						= Hour(Time(sDepartureTime)) * 3600
	lSeconds					= Minute(Time(sDepartureTime)) * 60
	lDepartureSeconds		= lHour + lSeconds + lRampOffset + 60
			
	If lDepartureSeconds < 0 Then
		sRampTime			= string(RelativeTime(Time("23:59:59"),lDepartureSeconds),"hh:mm")
	Else
		sRampTime			= string(RelativeTime(Time(sDepartureTime),lRampOffset),"hh:mm")
	End if	
	
	lHour						= Hour(Time(sDepartureTime)) * 3600
	lSeconds					= Minute(Time(sDepartureTime)) * 60
	lDepartureSeconds		= lHour + lSeconds + lKitchenOffset + 60
			
	If lDepartureSeconds < 0 Then
		sKitchenTime		= string(RelativeTime(Time("23:59:59"),lDepartureSeconds),"hh:mm")
	Else
		sKitchenTime		= string(RelativeTime(Time(sDepartureTime),lKitchenOffset),"hh:mm")
	End if	

else

	sRampTime		= dsCenOut.getitemstring(1,"cramp_time")
	sKitchenTime 	= f_get_kitchen_time( dsCenOut.getitemstring(1,"cunit"), &
	                                                                  dsCenOut.getitemnumber(1,"nairline_key"), &
	                                                                  dsCenOut.getitemnumber(1,"nflight_number"), &
													   dsCenOut.getitemstring(1,"csuffix"), &
	                                                                  dsCenOut.getitemnumber(1,"nrouting_id"), &
													   dsCenOut.getitemstring(1,"cdeparture_time"), &
													    dsCenOut.getitemstring(1,"cramp_time"))

end if

return 0

end function

public function boolean of_change_pax ();//========================================================================
//
// of_change_pax
// 
// $$HEX1$$dc00$$ENDHEX$$bertrag Passagierzahlen alt <-> neu
//
// 14.02.2005	REQ ber$$HEX1$$fc00$$ENDHEX$$cksichtigen (lFlightStatus = 2)
//
//========================================================================
long		i
long		lClass_Number
long		lpax_old
long		lspml_old
long		lspml_act
long		lFind
string	sFind

//
// Ermittlung Menge alt
//
//	dsCenOutPax			= s_change.dspax
//	dsCenOutPriorPax	= s_change.dspriorpax
// dsCenOutNewSPML	= s_change.dsnewspml
//
for i = 1 to dsCenOutPax.RowCount()
	lClass_Number 	= dsCenOutPax.GetItemNumber(i,"nclass_number")
	
	sFind = 	"nclass_number = " + string(lClass_Number) 
	
	lFind = dsCenOutPriorPax.Find(sFind,1,dsCenOutPriorPax.RowCount())
	if lFind > 0 then
		lpax_old 	= dsCenOutPriorPax.GetItemNumber(lFind,"npax")
		lspml_old 	= dsCenOutPriorPax.GetItemNumber(lFind,"npax_spml")
		dsCenOutPax.SetItem(i,"npax_old",lpax_old)
		dsCenOutPax.SetItem(i,"npax_spml_old",lspml_old)
	end if
	
	//
	// Aktualisiere auch die SPML-Mengen
	// und markiere ggf.
	//
	sFind = 	"nclass_number = " + string(lClass_Number) 
	lFind = dsCenOutNewSPML.Find(sFind,1,dsCenOutNewSPML.RowCount())
	if lFind > 0 then
		lspml_act 	= dsCenOutNewSPML.GetItemNumber(lFind,"compute_sum")
		dsCenOutPax.SetItem(i,"npax_spml",lspml_act)
		if lspml_old <> lspml_act then
			dsCenOutPax.SetItem(i,"status_npax_spml",1)
		end if
	else
		//
		// kein Treffer => Menge = 0
		//
		dsCenOutPax.SetItem(i,"npax_spml",0)
	end if
	
	//
	// REQ
	//
	if lFlightStatus = 2 then
		if dsCenOutPax.GetItemNumber(i,"npax") <> 0 then
			dsCenOutPax.SetItem(i,"npax",0)
			dsCenOutPax.SetItem(i,"status_npax",1)
		end if
		if dsCenOutPax.GetItemNumber(i,"npax_spml") <> 0 then
			dsCenOutPax.SetItem(i,"npax_spml",0)
			dsCenOutPax.SetItem(i,"status_npax_spml",1)
		end if
	end if
next

return true

end function

public function boolean of_change_spml ();//========================================================================
//
// of_change_spml
// 
// $$HEX1$$dc00$$ENDHEX$$bertrag SPML alt <-> neu
//
//========================================================================
long		i
long		lClass_Number
long		lspml_old
long		lFind
string	sFind
long		lprio

//
// Ermittlung Menge alt
//
//	dsCenOutNewSPML			= s_change.dsnewspml
//	dsCenOutPriorSPML			= s_change.dspriorspml
//
for i = 1 to dsCenOutNewSPML.RowCount()

	// 03.06.2014 HR: CBASE-NAM-CR-14020: Auch bei SPMLs soll eine lokale Ersetzung m$$HEX1$$f600$$ENDHEX$$glich sein
	//                                                           Wir setzen das Flag vom letzten Mal zur$$HEX1$$fc00$$ENDHEX$$ck
	if dsCenOutNewSPML.GetItemNumber(i, "nlocal_sub")=1 then
		dsCenOutNewSPML.SetItem(i, "nlocal_sub",0)
	end if
	
	lClass_Number 	= dsCenOutNewSPML.GetItemNumber(i,"nclass_number")
	lprio 			= dsCenOutNewSPML.GetItemNumber(i,"nprio")
	
	sFind = 	"nclass_number = " + string(lClass_Number) + " and nprio = " + string(lprio)
	
	lFind = dsCenOutPriorSPML.Find(sFind,1,dsCenOutPriorSPML.RowCount())
	if lFind > 0 then
		lspml_old 	= dsCenOutPriorSPML.GetItemNumber(lFind,"nquantity")
		dsCenOutNewSPML.SetItem(i,"nquantity_old",lspml_old)
	end if
	
	//
	// REQ
	//
	if lFlightStatus = 2 then
		if dsCenOutNewSPML.GetItemNumber(i,"nquantity") <> 0 then
			dsCenOutNewSPML.SetItem(i,"nquantity",0)
			dsCenOutNewSPML.SetItem(i,"status_nquantity",1)
		end if
	end if
	
next

return true

end function

public function s_change_flight of_change_handling_objects (s_change_flight s_change);//===========================================================================
//
// of_change_handling_objects
//
//===========================================================================
//
// Haupteinstieg f$$HEX1$$fc00$$ENDHEX$$r Masterchange vom Flug-Browser (w_change_center)
//
//===========================================================================
// History
// 28.06.2010 CBASE-NAM-0013 Traffic Areas
//===========================================================================

// ---------------------------------------------
// Handlings f$$HEX1$$fc00$$ENDHEX$$r den entsprechenden Flug $$HEX1$$e400$$ENDHEX$$ndern
// ---------------------------------------------
integer		iVerkehrsTag
string  		sFrequenz
string			sFind
long			lRow
long			i
long			lCurrentHandlingKey
long			lCurrentSort
long			lFind
Long			ll_fillemptycustomerpl
String			ls_temp

Long			ll_umm_nkey
String			ls_message
Long			ll_Rows
Integer		li_Succ

datastore	dsSupplierArlineAssign

dsSupplierArlineAssign = create datastore	
dsSupplierArlineAssign.dataobject = "dw_airline_supplier"
dsSupplierArlineAssign.Settransobject(sqlca)
dsSupplierArlineAssign.Retrieve(this.lAirlineKey, DateTime(dGenerationDate))

// ---------------------------------------------
// Inhalt der Tabellen nicht l$$HEX1$$f600$$ENDHEX$$schen !
// ---------------------------------------------
bDelete 					= False

s_change.bsuccess 	= True
s_change.sMessage 	= ""
bCalculateNoMeals		= s_change.bmeals
bCalculateNoExtra		= s_change.bextra
bCalculateNoNews		= s_change.bnewspaper
dNewGenerationDate	= s_change.dDeparture
dGenerationDate		= s_change.dDeparture
iVerkehrsTag 			= f_getfrequence(dNewGenerationDate)
sFrequenz 				= "nfreq" + string(iVerkehrsTag) + "=1"
sGenerierungsstatus	= "changed"
iTimeAdjustment		= s_change.iTimeAdjustment

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
if isvalid(s_change.dscenmealsdetdeduction) then
	s_change.dscenmealsdetdeduction.reset()
else
	s_change.dscenmealsdetdeduction				= Create uo_generate_datastore
	s_change.dscenmealsdetdeduction.dataobject	= "dw_exp_cen_meals_det_deduction"
end if

dsCenOut										= Create uo_generate_datastore
dsCenOut.DataObject 						= "dw_change_cen_out"
dsCenOut.SetTransObject(SQLCA)

dsCenOutPax									= Create uo_generate_datastore
dsCenOutPax.DataObject 					= "dw_change_cen_out_passenger"
dsCenOutPax.SetTransObject(SQLCA)

dsCenOutHandling							= Create uo_generate_datastore
dsCenOutHandling.DataObject 			= "dw_change_cen_out_handling"
dsCenOutHandling.SetTransObject(SQLCA)	 

// TBR 29.06.2009 --------------------------------------------------------------
dsHandlingObjects_LCL					= Create uo_generate_datastore
dsHandlingObjects_LCL.DataObject 	= "dw_generate_handling_objects"
dsHandlingObjects_LCL.SetTransObject(SQLCA)	 

// --------------------------------------------------------------
// Datastore wird mit der Struktur s_change $$HEX1$$fc00$$ENDHEX$$bergeben.
// --------------------------------------------------------------	
dsCenOut	= s_change.dssingle

// --------------------------------------------------------------
// Nun Instance Variablen f$$HEX1$$fc00$$ENDHEX$$llen.
// --------------------------------------------------------------	
lRoutingPlanDetailKey_CP	= dsCenOut.GetItemNumber(1,"NROUTINGDETAIL_KEY_CP")
lRoutingPlanGroupKey_CP	= dsCenOut.GetItemNumber(1,"NROUTING_GROUP_KEY_CP")
lRoutingPlanDetailKey			= dsCenOut.GetItemNumber(1,"NROUTINGDETAIL_KEY")
lRoutingPlanGroupKey			= dsCenOut.GetItemNumber(1,"NROUTING_GROUP_KEY")
lLegNumber						= dsCenOut.GetItemNumber(1,"NLEG_NUMBER")
lFlightNumber 					= dsCenOut.Getitemnumber(1,"NFLIGHT_NUMBER")
lAircraftKey						= dsCenOut.Getitemnumber(1,"NAIRCRAFT_KEY")
lHandlingTypeKey				= dsCenOut.Getitemnumber(1,"NHANDLING_TYPE_KEY")
sDepartureTime				= dsCenOut.Getitemstring(1,"CDEPARTURE_TIME")
sOriginalDeparture				= dsCenOut.Getitemstring(1,"CORIGINAL_TIME")
lRoutingID					 	= dsCenOut.Getitemnumber(1,"NROUTING_ID")	
lResultKey						= dsCenOut.Getitemnumber(1,"NRESULT_KEY")
lAirlinekey						= dsCenOut.Getitemnumber(1,"NAIRLINE_KEY")
iGenerierungsstatus			= dsCenOut.Getitemnumber(1,"nstatus") 
sClient							= dsCenOut.Getitemstring(1,"cclient")
sUnit								= dsCenOut.Getitemstring(1,"cunit")
lFlightStatus						= dsCenOut.Getitemnumber(1,"nflight_status")
lDefaultOwner					= dsCenOut.Getitemnumber(1,"nairline_owner_key")

// 05.03.2013 HR: Wir holen die Registration f$$HEX1$$fc00$$ENDHEX$$r die registrationbezogene ZBL-Beladung (CBASE-DE-CR-2011-107)
sRegistration					= dsCenOut.Getitemstring(1,"cregistration")
if isnull(sRegistration) then sRegistration = ""

 // 01.10.2010 HR: Japantool: UTC-Zeit ermitteln
  SELECT trunc(cen_out.ddeparture_time_utc ) 
    INTO :dGenerationDateUTC  
    FROM cen_out  
   WHERE cen_out.nresult_key = :lResultKey;

// --------------------------------------------------------------------------------------------------------------------
// 25.08.2010 HR: Variablen werden f$$HEX1$$fc00$$ENDHEX$$r die BOB-Berechnung ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
sAirline = dsCenOut.Getitemstring(1,"CAIRLINE")
sSuffix = dsCenOut.Getitemstring(1,"CSUFFIX")
sTLCFrom = dsCenOut.Getitemstring(1,"CTLC_FROM")

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
	
// 13.01.2011 HR: CFS-Package-Generierung
lAirlineKey						= dsCenOut.Getitemnumber(1,"nairline_key")
sTLCTo							= dsCenOut.Getitemstring(1,"ctlc_to")
ii_leg_number					= dsCenOut.Getitemnumber(1,"nleg_number")

//19.01.2011 HR
is_flugnummer=string(dGenerationDate, "yyyymmdd")+sAirline + string(lFlightNumber, "0000")+sSuffix+sTLCFrom+sTLCTo

// --------------------------------------------------------------------------------------------------------------------
// 29.07.2010 HR: Bei R$$HEX1$$fc00$$ENDHEX$$ck- oder Weiterflug muss das Datum des LEGS 
//                           benutzt werden zur Ermitttlung der Handlingobjekte
// 21.11.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r DE gibt es eine Absprache, das Uml$$HEX1$$e400$$ENDHEX$$ufe der RF mit DEPDATE ermittelt werden (LSY_5908)
// --------------------------------------------------------------------------------------------------------------------
li_Succ = integer(f_mandant_profilestring(sqlca, sClient, "Generierung","HOReturnFlightWithDepDate","0"))

// 26.11.2014 HR: Neuer Schalter, ob bei der Generierung der Mahlzeiten die neuen DWs genutzt werden sollen
ii_new_cfs_handlinggen = integer(f_mandant_profilestring(sqlca, sClient, "Generierung","NewCFSHandlingGen","0"))
if ii_new_cfs_handlinggen = 1 then
	of_trace("of_generate_schedule", 1,"NewCFSHandlingGen is on.")
end if

if lLegNumber > 1 and date(dsCenOut.GetitemDateTime(1,"dreturn_date")) <> dNewGenerationDate and li_Succ=0 then
	dNewGenerationDate		= date(dsCenOut.GetitemDateTime(1,"dreturn_date"))
	iVerkehrsTag 			= f_getfrequence(dNewGenerationDate)
	sFrequenz 				= "nfreq" + string(iVerkehrsTag) + "=1"
end if

// ----------------------------------------------------------------------
// 28.06.2010 CBASE-NAM-0013 Traffic Areas
// Traffic Area neu Lesen
// ----------------------------------------------------------------------
bUseOwner4TrafficArea = of_use_owner_for_trafficarea( s_app.smandant , lairlinekey) // 18.11.2010 OH:

// --------------------------------------------------------------------------------------------------------------------
// 18.05.2011 HR: Soll bei CFS-Fl$$HEX1$$fc00$$ENDHEX$$gen die Klasse bei der MLZ-Def-Suche 
//                           ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
// --------------------------------------------------------------------------------------------------------------------
ib_check_cfs_packetclass = of_get_cfspacket_check()

ll_Rows	= dsTrafficAreas.Retrieve(lAirlineKey,dGenerationdate)
lTlcfrom	= dsCenOut.Getitemnumber(1,"ntlc_from")
lTlcTo	= dsCenOut.Getitemnumber(1,"ntlc_to")
If of_set_traffic_area() then
	li_Succ = dsCenOut.SetItem(1,"CTRAFFIC_AREA",sTrafficArea)
	li_Succ = dsCenOut.SetItem(1,"CTRAFFIC_AREA_SHORT",sTrafficAreaShort)
End If

// ----------------------------------------------------
// 14.01.2009
// Leere Customer PLs bef$$HEX1$$fc00$$ENDHEX$$llen? Schalter auslesen
// ----------------------------------------------------
Select 	cValue 
into 		:ls_temp
from		cen_setup
where		cclient		= :sclient  	
and		cSection		= 'OnlineExplosion'				
and		cKey			= 'FillEmptyCustomerPL';
If SQLCA.SQlCode =0 Then
	ll_fillemptycustomerpl = Long(ls_temp)
Else
	ll_fillemptycustomerpl=0
End if
uo_generate_meals.il_fillemptycustomerpl = ll_fillemptycustomerpl
// ----------------------------------------
// Ende Schalter
// ----------------------------------------

// 09.06.2010 HR: BOB-Schalter an meal_calculation $$HEX1$$fc00$$ENDHEX$$bergeben
uo_generate_meals.iImportBobValues = iImportBobValues

// TBR 29.06.2009: Integragtion LCL-Mirror Fl$$HEX1$$fc00$$ENDHEX$$ge START -------------------------

// Handelt es sich um einen LCL-Flug ?
SELECT	NLCL_MIRROR_FLAG,
			UMM_NKEY 

INTO		:ii_nlcl_mirror_flag,
			:ll_umm_nkey

FROM		CEN_OUT

WHERE	NRESULT_KEY = :lResultKey;

IF 	sqlca.sqlcode <> 0 THEN
	s_change.bsuccess = False
	s_change.sMessage = uf.translate("DB-Error bei SELECT FROM CEN_OUT: " + String(sqlca.sqlcode) + " " + sqlca.sqlerrtext )
	return s_change
END IF

// LCL-Flug ...
IF ii_nlcl_mirror_flag = 1 THEN
	
	// Wenn LCL-Flug, dann Handling hier holen ...
	IF NOT of_get_handling_lcl(lResultKey,ll_umm_nkey, ls_message) THEN
		s_change.bsuccess = False
		s_change.sMessage = ls_message
		return s_change
	END IF
	
END IF

// TBR 29.06.2009: Integragtion LCL-Mirror Fl$$HEX1$$fc00$$ENDHEX$$ge ENDE -------------------------

dsHandlingInfo.reset()

dsSupplierArlineAssign.Retrieve(lAirlineKey, DateTime(dGenerationDate))
sFind = "cunit = '" + sUnit + "'"
lFind = dsSupplierArlineAssign.Find(sFind, 1, dsSupplierArlineAssign.RowCount())
	
if lFind > 0 then 
	iMLFlight = dsSupplierArlineAssign.GetItemNumber(lFind, "nwrite_packinglist_flag")
	uo_generate_meals.ii_mlflight = iMLFlight

	// --------------------------------------------------------------------------------------------------------------------
	// 09.08.2012 HR: Bei ML-Fl$$HEX1$$fc00$$ENDHEX$$gen ist das muss das Abflugdatum des 1. Legs genommen werden, da die
	//                        Frequence der Handlingobjekte am Abflug Beladestation h$$HEX1$$e400$$ENDHEX$$ngen
	// --------------------------------------------------------------------------------------------------------------------
	if iMLFlight = 1 then // 21.11.2013 HR: IF eingebaut (LSY_5908)
		dNewGenerationDate	= dGenerationDate
		iVerkehrsTag 			= f_getfrequence(dNewGenerationDate)
		sFrequenz 				= "nfreq" + string(iVerkehrsTag) + "=1"
	end if
end if

destroy(dsSupplierArlineAssign)

if iGenerierungsstatus < 3 then iGenerierungsstatus = 3

// --------------------------------------------------------------
// Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeiten anpassen
// --------------------------------------------------------------	
if iTimeAdjustment = 1 and of_change_internal_times() = 0 then
	s_change.sRamptime 		= sRampTime
	s_change.sKitchenTime 	= sKitchenTime
else
	s_change.sRamptime		= dsCenOut.Getitemstring(1,"cramp_time")
	s_change.sKitchenTime	= dsCenOut.Getitemstring(1,"ckitchen_time")
end if

//
// 17.10.05	Sollen bei der Neuberechnung der Mahlzeiten Sequences ermittelt werden?
//				(Muss von aussen gesetzt werden!)
//
uo_generate_meals.iUseSequence = iUseSequenceForCenOutMeals 	// Sequence verwenden

// ---------------------------------------------------------------
// Achtung: Original-Abflugzeit vom Leg ber$$HEX1$$fc00$$ENDHEX$$cksichtigen!
// Falls diese von der Departure Zeit abweicht (das ist i.d.R. so),
// dann muss diese zur Ermittlung der Beladung herangezogen werden!
// ---------------------------------------------------------------
if lLegNumber > 0 and not isnull(sOriginalDeparture) then
	sDepartureTime = sOriginalDeparture
end if
// ---------------------------------------------------------------
// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r Flugnummern bezogene Beladung
// ---------------------------------------------------------------
//dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate, sUnit)

// DB 11.07.2008: Bei Job_Type = 11 spielt die unit keine Rolle, 
// daher muss hier ein anderes DW verwendet werden.
if dsCenOut.Getitemnumber(1,"nmanual_input") = 1 then
			// TLE 12.11.2008: Einschr$$HEX1$$e400$$ENDHEX$$nkung der Selektion auf die Betriebe des Suppliers 
	//  (Korrektur HR 02.09.2008 auch f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$c400$$ENDHEX$$nderung aus Flugbrowser nachgezogen)
	//Falls keine Supplierunits $$HEX1$$fc00$$ENDHEX$$bergeben wurden der aktuelle Betrieb $$HEX1$$fc00$$ENDHEX$$bernehmen
	i = f_get_supplier_units_for_unit(this.sUnit, this.sSupp_Units)
	if i=0 then
		uf.mbox("Achtung","Fehler bei der Ermittlung der SupplierUnits")
		this.sSupp_Units[1]=this.sUnit	
	end if

	if upperbound(sSupp_Units) =0 then this.sSupp_Units[1]=this.sUnit
	//Handlingobjecte f$$HEX1$$fc00$$ENDHEX$$r alle SuppliererUnits holen
	dsHandlingObjects.DataObject = "dw_generate_handling_objects_supunits"
	dsHandlingObjects.setTransObject(SQLCA)
	dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate, this.sSupp_Units)
	//dsHandlingObjects.DataObject = "dw_generate_handling_objects_all"
	//dsHandlingObjects.setTransObject(SQLCA)
	//dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate)
else
	dsHandlingObjects.DataObject = "dw_generate_handling_objects"
	dsHandlingObjects.setTransObject(SQLCA)
	dsHandlingObjects.retrieve(lRoutingPlanDetailKey,dNewGenerationDate,sUnit)
end if
//f_print_datastore(dsHandlingObjects)
dsHandlingObjects.SetFilter(sFrequenz)
dsHandlingObjects.Filter()
//f_print_datastore(dsHandlingObjects)
// ---------------------------------------------------------------
// Handling Objekte f$$HEX1$$fc00$$ENDHEX$$r City Pair bezogene Beladung
// ---------------------------------------------------------------		 
//dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, sUnit)
		// DB 11.07.2008: Bei Job_Type = 11 spielt die unit keine Rolle, 
		// daher muss hier ein anderes DW verwendet werden.
if dsCenOut.Getitemnumber(1,"nmanual_input") = 1 then
	// TLE 12.11.2008: Einschr$$HEX1$$e400$$ENDHEX$$nkung der Selektion auf die Betriebe des Suppliers 
	//  (Korrektur HR 02.09.2008 auch f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$c400$$ENDHEX$$nderung aus Flugbrowser nachgezogen)
	//Falls keine Supplierunits $$HEX1$$fc00$$ENDHEX$$bergeben wurden der aktuelle Betrieb $$HEX1$$fc00$$ENDHEX$$bernehmen
	i = f_get_supplier_units_for_unit(this.sUnit, this.sSupp_Units)
	if i=0 then
		uf.mbox("Achtung","Fehler bei der Ermittlung der SupplierUnits")
		this.sSupp_Units[1]=this.sUnit	
	end if

	if upperbound(sSupp_Units) =0 then this.sSupp_Units[1]=this.sUnit
	//Handlingobjecte f$$HEX1$$fc00$$ENDHEX$$r alle SuppliererUnits holen
	dsHandlingObjects_cp.DataObject = "dw_generate_handling_objects_supunits"
	dsHandlingObjects_cp.setTransObject(SQLCA)
	dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, this.sSupp_Units)
	//dsHandlingObjects_cp.DataObject = "dw_generate_handling_objects_all"
	//dsHandlingObjects_cp.setTransObject(SQLCA)
	//dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate)
else
	dsHandlingObjects_cp.DataObject = "dw_generate_handling_objects"
	dsHandlingObjects_cp.setTransObject(SQLCA)
	dsHandlingObjects_cp.retrieve(lRoutingPlanDetailKey_CP,dNewGenerationDate, sUnit)
end if

dsHandlingObjects_cp.SetFilter(sFrequenz)
dsHandlingObjects_cp.Filter()
// ------------------------
// Handling Joker ermitteln
// ------------------------
of_get_handling_joker()	

// --------------------------------------------------------------------------------------------------------------------
// 12.04.2011 HR: Wir $$HEX1$$fc00$$ENDHEX$$bertragen die Packets zum Flug, damit diese ggf.
//                           bei der Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden.
// 21.06.2013 HR: Wir brauchen die Packages auch f$$HEX1$$fc00$$ENDHEX$$r SSL/ZBL-Bestimmung (CBASE-CR-NAM-12070B)
// --------------------------------------------------------------------------------------------------------------------
dsCenOutPackets.reset()
for i=1 to s_change.dsPackets.rowcount()
	 dsCenOutPackets.insertrow(1)
	 
	 dsCenOutPackets.setitem(1,"npackets_key",s_change.dsPackets.getitemnumber(i,"npackets_key"))
	 dsCenOutPackets.setitem(1,"nresult_key",s_change.dsPackets.getitemnumber(i,"nresult_key"))
	 dsCenOutPackets.setitem(1,"nresult_key_group",s_change.dsPackets.getitemnumber(i,"nresult_key_group"))
	 dsCenOutPackets.setitem(1,"nleg_number",s_change.dsPackets.getitemnumber(i,"nleg_number"))
	 dsCenOutPackets.setitem(1,"cpacket_class",s_change.dsPackets.getitemstring(i,"cpacket_class"))
	 dsCenOutPackets.setitem(1,"cpacket",s_change.dsPackets.getitemstring(i,"cpacket"))
	 dsCenOutPackets.setitem(1,"cpacket_var",s_change.dsPackets.getitemstring(i,"cpacket_var"))
	 dsCenOutPackets.setitem(1,"cpacket_group_code",s_change.dsPackets.getitemstring(i,"cpacket_group_code"))
	 dsCenOutPackets.setitem(1,"cpacket_description",s_change.dsPackets.getitemstring(i,"cpacket_description"))
	 dsCenOutPackets.setitem(1,"nairline_packages_key",s_change.dsPackets.getitemnumber(i,"nairline_packages_key"))
next

// 21.06.2013 HR: Wir brauchen auch die LOS f$$HEX1$$fc00$$ENDHEX$$r f$$HEX1$$fc00$$ENDHEX$$r SSL/ZBL-Bestimmung (CBASE-CR-NAM-12070B)
dsCenOutLOS.retrieve( dsCenOut.Getitemnumber(1,"NRESULT_KEY_GROUP"))

// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Loadinglist 
// ---------------------------------------------------------------		 
If not of_generate_handling_one(1) Then
	if not bNoHandlingNecessary then  // keine Abbruch bei Monalisa-Auslandcaterer

		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Standardbeladung kann nicht ermittelt werden.")
		return s_change		
	end if
End if
// ---------------------------------------------------------------		 
// Handlingobjekte Supplement Loadinglist
// ---------------------------------------------------------------	
If not of_generate_handling_two(1) Then
	//
	// 28.03.2006 Eine fehlerhafte ZBL-Zuordnung darf die komplette Bearbeitung nicht stoppen
	//
	//	s_change.bsuccess = False
	//	s_change.sMessage = uf.translate("Handling Zusatzbeladung kann nicht ermittelt werden.")
	//	return s_change
	if not bNoHandlingNecessary then // keine Abbruch bei Monalisa-Auslandcaterer

		uf.mbox("Hinweis","Handling Zusatzbeladung kann nicht ermittelt werden. Bitte informieren Sie die Stammdaten-Pflege!")
	end if
End if
// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Station Instruction
// ---------------------------------------------------------------		 
If not of_generate_handling_si_qaq() Then
	if not bNoHandlingNecessary then // keine Abbruch bei Monalisa-Auslandcaterer

		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Stations Auftrag kann nicht ermittelt werden.")
		return s_change		
	end if
End if
// ---------------------------------------------------------------		 
// Pax Zahlen $$HEX1$$fc00$$ENDHEX$$bergeben
// ---------------------------------------------------------------		 
dsCenOutPax 		= s_change.dsPax
dsCenOutPriorPax	= s_change.dsPriorPax
// ---------------------------------------------------------------		 
// SPML vorbereiten, werden im Pax-DW ben$$HEX1$$f600$$ENDHEX$$tigt
// ---------------------------------------------------------------		 
dsCenOutNewSPML			= s_change.dsnewspml
dsCenOutPriorSPML			= s_change.dspriorspml
dsCenOutNewSPML.Sort()
dsCenOutNewSPML.GroupCalc()
// ---------------------------------------------------------------		 
// SPML Zahlen Menge alt <-> neu $$HEX1$$fc00$$ENDHEX$$bertragen
// ---------------------------------------------------------------		 
If not of_change_spml() Then
	s_change.bsuccess = False
	s_change.sMessage = uf.translate("Alte SPML konnten nicht $$HEX1$$fc00$$ENDHEX$$bertragen werden.")
	return s_change		
End if
// ---------------------------------------------------------------		 
// Pax Zahlen Menge alt <-> neu $$HEX1$$fc00$$ENDHEX$$bertragen
// ---------------------------------------------------------------		 
If not of_change_pax() Then
	s_change.bsuccess = False
	s_change.sMessage = uf.translate("Alte Passagierzahlen konnten nicht $$HEX1$$fc00$$ENDHEX$$bertragen werden.")
	return s_change		
End if
// ---------------------------------------------------------------		 
// Handlingobjekte f$$HEX1$$fc00$$ENDHEX$$r Zeitungsbeladung aufl$$HEX1$$f600$$ENDHEX$$sen
// Achtung: Mu$$HEX2$$df002000$$ENDHEX$$nach Default Aircraft Version laufen!
// ---------------------------------------------------------------		 
if bCalculateNoNews = false then
	If not of_generate_handling_newspaper() Then
		//
		// 12.07.2005: Wenn Lesematerial nicht klappt, dann darf nicht die 
		// Operation stehen!
		//
		//s_change.bsuccess = False
		//s_change.sMessage = uf.translate("Handling Zeitungsbeladung kann nicht ermittelt werden.")
		//return s_change	
		uf.mbox("Lesematerial","Lesematerial f$$HEX1$$fc00$$ENDHEX$$r diesen Flug kann nicht ermittelt werden.~r" + &
										"Bitte wenden Sie sich mit diesem Problem sp$$HEX1$$e400$$ENDHEX$$ter an die Fachabteilung!")
	End if
end if
// ---------------------------------------------------------------		 
// Handlingobjekte Mahlzeitenbeladung
// ---------------------------------------------------------------
dsCenOutMeals 				= s_change.dspriormeals
dsCenOutNewSPMLDetail		= uo_generate_meals.dsSPMLDetail
dsCurrentMeals					= s_change.dsCurrentMeals
dsCurrentExtra					= s_change.dsCurrentExtra
dsOldMeals						= s_change.dsOldMeals
dsOldExtra						= s_change.dsOldExtra
//
// Neuberechnung Mahlzeiten, Achtung: bCalculateNoMeals spielt eine Rolle
//
//
// R$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngigmachen von annulliertem Flug kann Neuberechnung verhindern...
//
if s_change.bDoMealCalculation = true then
	//
	// 21.04.2005	Sortierung nach Inhalt dsCurrentMeals???
	//					Verwendung von nclass_number
	//
	for i = 1 to dsCurrentMeals.RowCount()
		lCurrentHandlingKey = dsCurrentMeals.GetItemNumber(i,"ncover_key")
		lFind = dsHandlingObjects.Find("nhandling_key = " + string(lCurrentHandlingKey),1,dsHandlingObjects.RowCount())
		if lFind > 0 then
			dsHandlingObjects.SetItem(lFind,"nclass_number",i)
		end if
	next
	//
	// 21.04.2005	Sortierung nach Class-Number (wenn vorhanden)
	//
	dsHandlingObjects.GroupCalc()
	dsHandlingObjects.SetSort("class_sort")
	dsHandlingObjects.Sort()
	// 		 
	// SPML aufl$$HEX1$$f600$$ENDHEX$$sen
	// 
	if of_resolve_spml() <> 0 then
		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling SPML kann nicht ermittelt werden.")
		return s_change
	end if

//	// --------------------------------------------------------------------------------------------------------------------
//	// 12.04.2011 HR: Wir $$HEX1$$fc00$$ENDHEX$$bertragen die Packets zum Flug, damit diese ggf.
//	//                           bei der Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden.
// 21.06.2013 HR: Nach oben verschoben (CBASE-CR-NAM-12070B)
//	// --------------------------------------------------------------------------------------------------------------------
//	dsCenOutPackets.reset()
//	for i=1 to s_change.dsPackets.rowcount()
//		 dsCenOutPackets.insertrow(1)
//		 
//		 dsCenOutPackets.setitem(1,"npackets_key",s_change.dsPackets.getitemnumber(i,"npackets_key"))
//		 dsCenOutPackets.setitem(1,"nresult_key",s_change.dsPackets.getitemnumber(i,"nresult_key"))
//		 dsCenOutPackets.setitem(1,"nresult_key_group",s_change.dsPackets.getitemnumber(i,"nresult_key_group"))
//		 dsCenOutPackets.setitem(1,"nleg_number",s_change.dsPackets.getitemnumber(i,"nleg_number"))
//		 dsCenOutPackets.setitem(1,"cpacket_class",s_change.dsPackets.getitemstring(i,"cpacket_class"))
//		 dsCenOutPackets.setitem(1,"cpacket",s_change.dsPackets.getitemstring(i,"cpacket"))
//		 dsCenOutPackets.setitem(1,"cpacket_var",s_change.dsPackets.getitemstring(i,"cpacket_var"))
//		 dsCenOutPackets.setitem(1,"cpacket_group_code",s_change.dsPackets.getitemstring(i,"cpacket_group_code"))
//		 dsCenOutPackets.setitem(1,"cpacket_description",s_change.dsPackets.getitemstring(i,"cpacket_description"))
//		 dsCenOutPackets.setitem(1,"nairline_packages_key",s_change.dsPackets.getitemnumber(i,"nairline_packages_key"))
//	next
//	
	// 25.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen lesen (CBASE-NAM-CR-11009)
	// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling: Result_key wird ben$$HEX1$$f600$$ENDHEX$$tigt
	uo_generate_meals.uf_retrieve_local_subst( sUnit, lAirlineKey, lFlightNumber, sSuffix, dGenerationDate, sDepartureTime, lAircraftKey, &
	                                                                lRoutingID, lTlcfrom, lTlcTo, lHandlingTypeKey, lResultkey)
	
	// Mahlzeiten aufl$$HEX1$$f600$$ENDHEX$$sen
	if not of_generate_handling_meals(0, s_change, "") Then
		s_change.bsuccess = false
		s_change.sMessage = uf.translate("Handling Mahlzeitenbeladung kann nicht ermittelt werden.")
		return s_change
	end if

	// SPML und SPML-Details k$$HEX1$$f600$$ENDHEX$$nnen erst im w_change_center gespeichert
	// werden. (Master-Detail-Beziehung)
	//
	if dsCenOutNewSPMLDetail.RowCount() > 0 then
		//
		// Inhalt der SPML-Details in die Struktur kopieren,
		// damit im Fenster sp$$HEX1$$e400$$ENDHEX$$ter die Inhalte gespeichert werden k$$HEX1$$f600$$ENDHEX$$nnen.
		//
		dsCenOutNewSPMLDetail.RowsCopy(1,dsCenOutNewSPMLDetail.rowcount(),Primary!,s_change.dsnewspmldetail,s_change.dsnewspmldetail.RowCount() + 1,Primary!)
	end if
end if

//
// Neuberechnung Extrabeladung
//
// Falls einfach so drin bleibt, wird die neuberechnete Mahlzeitenbeladung zerst$$HEX1$$f600$$ENDHEX$$rt
//
dsCenOutExtra = s_change.dspriorextra

// if bCalculateNoExtra = false then
if s_change.bDoMealCalculation = true then
	If not of_generate_handling_meals(1, s_change, "") Then
		s_change.bsuccess = False
		s_change.sMessage = uf.translate("Handling Extrabeladung kann nicht ermittelt werden.")
		return s_change
	End if

	//dsCenOut.setitem(1,"nlocal_sub",uo_generate_meals.il_nlocal_sub_flight) // 25.09.2012 HR: Kennzeichen ob Lokalen Ersetzungen durchgef$$HEX1$$fc00$$ENDHEX$$hrt wurden an Flug merken(CBASE-NAM-CR-11009)
	//s_change.dssingle.setitem(1,"nlocal_sub",uo_generate_meals.il_nlocal_sub_flight) // 08.10.2012 HR: Kennzeichen ob Lokalen Ersetzungen durchgef$$HEX1$$fc00$$ENDHEX$$hrt wurden an Flug merken(CBASE-NAM-CR-11009)

end if
//
// Neue Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung ist in dsCenOutMeals
//
//s_change.dspriormeals = dsCenOutMeals // doch nicht zur$$HEX1$$fc00$$ENDHEX$$ck in Struktur


// ---------------------------------------------------------------		 
// Matdispo f$$HEX1$$fc00$$ENDHEX$$r neue Beladung sp$$HEX1$$e400$$ENDHEX$$ter separat
// ---------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// 21.09.2011 HR: GGF die PPM Daten erzeugen
// --------------------------------------------------------------------------------------------------------------------

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob PPM gef$$HEX1$$fc00$$ENDHEX$$llt werden soll
if f_mandant_profilestring(sqlca, sClient, "Generierung","FillPPM","0") = "0" then 
	ib_generate_ppmdata = false
	this.of_trace("of_change_handling_objects", 10, "of_generate_ppm: Generate PPM-Data is switched off")	
else
	ib_generate_ppmdata = true
end if

lrow = dsCenOutPPM.retrieve(lResultKey)

of_generate_ppm(1)

// --------------------------------------------------------------------------------------------------------------------
// 22.09.2011 HR: die PPM-Daten speichern
// --------------------------------------------------------------------------------------------------------------------
long lSQLCode, lSQLRow
string sSQLErrorText

if dsCenOutPPM.update() = -1 then
	lSQLCode 		= dsCenOutPPM.lSQLErrorDBCode
	lSQLRow  		= dsCenOutPPM.lSQLErrorRow
	sSQLErrorText	= dsCenOutPPM.sSQLErrorText
	this.of_trace("of_change_handling_objects", 3,	"Can't write generated dsCenOutPPM to database, sqlcode " + string(lSQLCode))
else
	this.of_trace("of_change_handling_objects", 3, "Rows in dsCenOutPPM: "+string(dsCenOutPPM.rowcount()))	
end if

if dsCenOutPPMStowages.update() = -1 then
	lSQLCode 		= dsCenOutPPMStowages.lSQLErrorDBCode
	lSQLRow  		= dsCenOutPPMStowages.lSQLErrorRow
	sSQLErrorText	= dsCenOutPPMStowages.sSQLErrorText
	this.of_trace("of_change_handling_objects", 3,	"Can't write generated dsCenOutPPMStowages to database, sqlcode " + string(lSQLCode))
else
	this.of_trace("of_change_handling_objects", 3, "Rows in dsCenOutPPMStowages: "+string(dsCenOutPPMStowages.rowcount()))	
end if


If s_app.bDebug Then
//		f_print_datastore(dsHandlingInfo)
End if	

return s_change

end function

public function boolean of_generate_flights ();
//=====================================================================================
//
// of_generate_flights
//
// Erster wichtiger Schritt zur Fluggenerierung: 
// Die Fl$$HEX1$$fc00$$ENDHEX$$ge werden aus der Beladedefinition und dem Flugplan erstellt.
//
//=====================================================================================
integer 		i
integer		iVerkehrsTag
string  		sFrequenz
long 			lRow,lFound, lRowcount
long			lFindDefault
long			lFlightGroup
Boolean		bGenerateFlight
integer		iTest
long			lKey, j, k
boolean		bDeleteLegs
long			lCurrentGroupKey
string			sFilter, sFind

datastore	dsSupplierArlineAssign

iVerkehrsTag 	= f_getfrequence(dGenerationDate)
sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"

// ------------------------------------------------------------------
// Alle Datastores resetten ! (Umzug am 28.02.2005)
// -------------------------------------------------------------------	
dsCenOut.Reset()
dsCenOutHandling.Reset()
dsCenOutHandlingNews.Reset()
dsCenOutPax.Reset()
dsCenOutQAQ.Reset()
dsCenOutNewsExtra.Reset()
dsCharterMemory.Reset()

//HR 31.10.2008 Reset des Filters 
dsCenOut.setfilter("")
dsCenOut.filter()

dsGenerateSchedule.setfilter("")
dsGenerateSchedule.filter()


// --------------------------------------------------------------------------------------------------------------------
// 10.06.2010 HR: Schauen, ob schon BOB-Werte eingespielt wurden
// --------------------------------------------------------------------------------------------------------------------
  SELECT count(*)  INTO :i  
    FROM cen_out,   
         cen_out_meals  
   WHERE ( cen_out_meals.nresult_key = cen_out.nresult_key ) and  
         (( cen_out.nairline_key = :lAirlineKey ) AND  
         ( cen_out.ddeparture = :dGenerationDate ) AND  
         ( cen_out.cunit = :sUnit ) AND 
	    ( cen_out_meals.nimport_from_bob = 1 ) )   ;

if sqlca.sqlcode=0 and i>0 then
	iImportBobValues = 1
end if

// -----------------------------------------
// Retrieve und Filter Flugplan
// -----------------------------------------
dsGenerateSchedule.Retrieve(lScheduleKey,DateTime(dGenerationDate))
if ii_Debug_Save =1 then dsGenerateSchedule.saveas(is_Debug_save_path+"of_generate_flights_1_dsGenerateSchedule_vorher"+string(now(),"hhmmss")+".xls", excel5!, true)


dsGenerateSchedule.SetFilter(sFrequenz)
dsGenerateSchedule.Filter()

if ii_Debug_Save =1 then dsGenerateSchedule.saveas(is_Debug_save_path+"of_generate_flights_3_dsGenerateSchedule_nach_filter"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

// -----------------------------------------
// Retrieve und Filter Routingplan
// -----------------------------------------
dsGenerateRoutingPlan.Retrieve(lRoutingPlanKey, sUnit, dGenerationDate) // 14.05.2010 HR: Generierungsdatum eingebaut
dsGenerateRoutingPlan.SetFilter(sFrequenz)
dsGenerateRoutingPlan.Filter()

dsSupplierArlineAssign = create datastore	
dsSupplierArlineAssign.dataobject = "dw_airline_supplier"
dsSupplierArlineAssign.Settransobject(sqlca)
dsSupplierArlineAssign.Retrieve(this.lAirlineKey, DateTime(dGenerationDate))

if ii_Debug_Save =1 then dsGenerateRoutingPlan.saveas(is_Debug_save_path+"of_generate_flights_4_dsGenerateRoutingPlan_vorher_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

of_trace("of_generate_flights", 50,"Vorbereiten" )
For I = 1 to dsGenerateRoutingPlan.Rowcount()
	
	// ----------------------------------------------------------------------------------
	// 19.06.08, KF
	// Fl$$HEX1$$fc00$$ENDHEX$$ge die einen abweichenden Betrieb zwischen Handlingobject und Flug aufweisen
	// markieren
	// ----------------------------------------------------------------------------------
	
	// ----------------------------------------------------------------------------------	
	// 19.06.08, KF
	// Zwischenlegs, die kein Handlingobjekt der Betrieb am Flug zugewiesen haben...
	// Flug muss trotzdem generiert werden ...
	// ----------------------------------------------------------------------------------
	//14.05.2010, HR Nur Zwischenlegs nicht erstes Leg
	if isnull(dsGenerateRoutingPlan.GetItemString(I, "cunit")) and dsGenerateRoutingPlan.GetItemNumber(I, "nleg_number")>1 then
		dsGenerateRoutingPlan.SetItem(I, "cunit", dsGenerateRoutingPlan.GetItemString(I, "cen_routingplan_cunit"))
	end if
		
	// ----------------------------------------------------------------------------------
	// 02.07.08, KF
	// Monalisa Fl$$HEX1$$fc00$$ENDHEX$$ge, gekennzeichnet durch nwrite_packinglist_flag = 1 in der 
	// Supplierzuordnug, als solche markieren
	// ----------------------------------------------------------------------------------
	sFind = "cunit = '" + dsGenerateRoutingPlan.GetItemString(I, "cunit") + "'"
	lFound = dsSupplierArlineAssign.Find(sFind, 1, dsSupplierArlineAssign.RowCount())
		
	if lFound > 0 then 
		if dsSupplierArlineAssign.GetItemNumber(lFound, "nwrite_packinglist_flag") = 1 then
			dsGenerateRoutingPlan.SetItem(I, "nml_flight", 1)
		else
			dsGenerateRoutingPlan.SetItem(I, "nml_flight", 0)
		end if
	else
		
	end if
	
	
Next

destroy(dsSupplierArlineAssign)

// -----------------------------------------------------------------
// 26.04.2007, KF
// Einige Informationen aus cen_out cachen (sofern der Tag schonmal 
// generiert wurde)
// -----------------------------------------------------------------		
dsCenOutCache.Retrieve(lAirlineKey, dGenerationDate, sclient, sunit)
of_trace("of_generate_flights", 1,"cached " + string( dsCenOutCache.RowCount()) + " flights for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey))

// --------------------------------------------------------------------------------------------------------------------
// 29.01.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r das Receiycling brauchen wir die alten QP
// --------------------------------------------------------------------------------------------------------------------
dsCenOutQP.Retrieve(lAirlineKey, sunit, dGenerationDate)
of_trace("of_generate_flights", 1,"cached " + string( dsCenOutQP.RowCount()) + " QPs for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey))

// -----------------------------------------------------------------
// Neu, erstmal alles l$$HEX1$$f600$$ENDHEX$$schen !
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		

if ii_delete_flights = 1 then
	of_trace("of_generate_flights", 1,"start delete from cen_out")
	// 23.06.2010 HR: NNOTREGENERATE - Schalter eingebaut
	DELETE FROM cen_out 
			WHERE dgeneration_date 	= :dGenerationDate and 
					cclient	  				= :sclient and
					cunit		  				= :sunit and
					nairline_key 			= :lAirlineKey and 
					NNOTREGENERATE 	= 0;
					
	If sqlca.sqlcode <> 0 then
		of_trace("of_generate_flights", 1,"delete from cen_out - error " + string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext)
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule, sqlcode " + string(sqlca.sqlcode) + ".")
		rollback using sqlca;
		return False
	else
		of_trace("of_generate_flights", 1,"finish delete from cen_out")
	end if
	

end if

// 23.06.2010 HR:
dsCenOutNotRegenerate.reset()
// dsCenOutNotRegenerate.setfilter("nnotregenerate = 1") // 13.04.2015 HR: Wird nicht mehr ben$$HEX1$$f600$$ENDHEX$$tigt
dsCenOutNotRegenerate.retrieve(lAirlineKey, dGenerationDate, sclient, sUnit)
of_trace("of_generate_flights", 1,"cached " + string( dsCenOutNotRegenerate.RowCount()) + " flights for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey)+" with markt not to regenerate.")

If dsGenerateSchedule.rowcount() <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Flight Schedule.")
	of_trace("of_generate_flights", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(dsGenerateRoutingPlan.rowcount()))
	return False
End if

If dsGenerateRoutingPlan.rowcount() <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Loading Definition.")
	of_trace("of_generate_flights", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(dsGenerateRoutingPlan.rowcount()))
	return False
End if

// -------------------------------------------------------------------------
// der Routingplan ist der Taktgeber, es werden alle Betriebe retrieved !!!!
// zuerst die Flugnummern und dann die City Pair Beladung.
// -------------------------------------------------------------------------
lFlightGroup = -1
// ------------------------
// Message an Window
// ------------------------
If bSendMessage Then
	sPostMessage = "Execute job flights, for unit: " + sUnit + " Airline: " + sAirline + " Job ID: " + string(iJob_Type)
	w_cbase_generate_dialog.triggerevent("ue_redraw")
	yield()	
End if

of_trace("of_generate_flights", 50,"lRoutingPlanKey=" + string(lRoutingPlanKey) )


dsGenerateRoutingPlan.SetSort("nsort A nrouting_group_key A nleg_number A")
dsGenerateRoutingPlan.Sort()

if ii_Debug_Save =1 then dsGenerateRoutingPlan.saveas(is_Debug_save_path+"of_generate_flights_4_dsGenerateRoutingPlan_after_sort_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

lRowcount = dsGenerateRoutingPlan.Rowcount()

For I = 1 to lRowcount

	dReturnFlightDate = dGenerationDate		// R$$HEX1$$fc00$$ENDHEX$$cksetzen ReturnFlightDate
	
	
	lFlightNumber 	= dsGenerateRoutingPlan.Getitemnumber(i,"nflight_number")
	sTLCFrom		= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc")
	sTLCTo			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc_1")
	lTLCFrom		= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_from")
	lTLCTo			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_to")		
	sSuffix			= dsGenerateRoutingPlan.Getitemstring(i,"csuffix")
	lFlightLegs 		= dsGenerateRoutingPlan.Getitemnumber(i,"compute_legs")
	lLegNumber		= dsGenerateRoutingPlan.Getitemnumber(i,"nleg_number")
	sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	iMLFlight 		= dsGenerateRoutingPlan.Getitemnumber(i, "nml_flight")
	
	// 24.06.2010 HR:
	if lFlightNumber = -1 then continue
	
	// 28.09.2009 HR: Falsche Zeiten
	if lLegNumber=1 then
		cdeparture_vorleg=""
		// 18.12.2009 HR: Abflugszeit vorleg reset
		dt_dep_vorleg = datetime(date("01.01.2000"),time("00:01"))
		dt_arr_vorleg = datetime(date("01.01.2000"),time("00:01")) //21.11.2011 HR
	end if
	
	// --------------------------------------------------------
	// 12.06.2008, KF
	// --------------------------------------------------------
	if isnull(sLoadingUnit) and lFlightNumber >0 then
		of_trace("of_generate_flights", 10, "Row "+string(i)+" of "+string(lRowcount)+" Nullvalue in cunit found for Flighnumber " + string(lFlightNumber) )
		
		//01.11.2012 HR
		if dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup or iMLFlight = 1 then
			of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" Group Change for nrouting_group_key = " + string(lFlightGroup) )
			lFlightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
			lResultKeyGroup=0 //15.11.2012 HR Sicherstellen, dass folgende 2.Legs nicht an ein andern Flug angeh$$HEX1$$e400$$ENDHEX$$ngt werden
		end if

		continue
	end if
	
	// Migration FRA ZD - FRA ZF, Bleyer 18.12.2007
	If dsGenerateRoutingPlan.Getitemstring(i,"cunit") = "0115" and sUnit = "1150" Then
		sLoadingUnit	= "1150"
		dsGenerateRoutingPlan.Setitem(i,"cunit","1150")
	Else
		sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	End if
	
	//
	// 13.10.2006 Falls gleiche Flugnummer als Default auftaucht, dann auf
	// Generierung verzichten
	//
	lFindDefault = dsGenerateRoutingPlan.Find("nflight_number = " + string(lFlightNumber) + " and ndefault = 1 and csuffix = '" + sSuffix + "'" &
						,1,dsGenerateRoutingPlan.RowCount())
						
	if lFindDefault > 0 then
		if lFindDefault <> i then
		
			//01.11.2012 HR
			if dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup or iMLFlight = 1 then
				of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" Group Change for nrouting_group_key = " + string(lFlightGroup) )
				lFlightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
				lResultKeyGroup=0 //15.11.2012 HR Sicherstellen, dass folgende 2.Legs nicht an ein andern Flug angeh$$HEX1$$e400$$ENDHEX$$ngt werden
			end if


			continue
		end if
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 23.06.2010 HR: Falls Flugnummer im dsCenOutNotRegenerate zu finden ist, dann auch auf 
	//                        Generierung verzichten
	// 20.03.2015 HR: Es muss die ganze Strecke ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden, nicht nur CTLCFROM 
	// --------------------------------------------------------------------------------------------------------------------
	sFind = "nflight_number = " + string(lFlightNumber) 
	sFind += " and nleg_number = "+string(lLegNumber)
	sFind += " and csuffix = '" + sSuffix + "'"
	
	sFind += " and ctlc_from = '"+sTLCFrom+"'"
	sFind += " and ctlc_to = '"+sTLCTo+"'"
	lFound = dsCenOutNotRegenerate.find(sFind, 1, dsCenOutNotRegenerate.RowCount())

	if lFound > 0 then	
		of_trace("of_generate_flights", 1,"Flight found in NotToRegenerate Cache: " + string(lFlightNumber)+sSuffix+" Leg "+string(lLegNumber)+" " +sTLCFrom+"-"+sTLCTo)
		
		//01.11.2012 HR
		if dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup or iMLFlight = 1 then
			of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" Group Change for nrouting_group_key = " + string(lFlightGroup) )
			lFlightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
			lResultKeyGroup=0 //15.11.2012 HR Sicherstellen, dass folgende 2.Legs nicht an ein andern Flug angeh$$HEX1$$e400$$ENDHEX$$ngt werden
		end if

		continue
	end if
	
	lCurrentGroupKey = dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
	
	// ---------------------------------------------------------------------
	// Haben wir eine neue Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen. (Hin, Weiter oder R$$HEX1$$fc00$$ENDHEX$$ckflug)
	// ---------------------------------------------------------------------
	// DB 08.08.2008: Wenn ein MonaLisa-Flug zu einer Gruppe geh$$HEX1$$f600$$ENDHEX$$rt, die nicht generiert wird
	// muss nochmal gepr$$HEX1$$fc00$$ENDHEX$$ft werden, ob dieser Flug doch generiert werden muss.
	if dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup or iMLFlight = 1 then
	//*alt*/if dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup then
		of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" Group Change for nrouting_group_key = " + string(lFlightGroup) )
		lFlightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
		// ---------------------------------------------------------------------
		// Ok, nun pr$$HEX1$$fc00$$ENDHEX$$fen wir ob in dieser Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen der Generierungs
		// Betrieb vorkommt.
		// ---------------------------------------------------------------------
		lFound = dsGenerateRoutingPlan.Find("nrouting_group_key = " + &
					string(lFlightGroup) + " and cunit = '" + sUnit + "'",&
					i,dsGenerateRoutingPlan.Rowcount())
		// ---------------------------------------------------------------------
		// 09.09.2005
		// Sch$$HEX1$$e400$$ENDHEX$$rfere $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung, falls es sich um eine Charter-Airline handelt:
		// Nur wenn alle Leg-Angaben 1:1 mit der Beladedefinition $$HEX1$$fc00$$ENDHEX$$bereinstimmt
		// wird der Flug generiert.
		// ---------------------------------------------------------------------
		if bCharter then
			//
			// Gruppe hat gewechselt:
			// Sind die Legs der letzten Gruppe vollst$$HEX1$$e400$$ENDHEX$$ndig?
			//
			if dsCharterMemory.RowCount() > 0 then
				
				dsCenOut.SetFilter("")
				dsCenOut.Filter()
				
				of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
								+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
				bDeleteLegs = false

				//
				// Kontrolle: dsCharterMemory des vorherigen Flugs gegen dsCenOut
				// und l$$HEX1$$f600$$ENDHEX$$sche Fl$$HEX1$$fc00$$ENDHEX$$ge, die nicht 1:1 der Beladedefinition entsprechen
				//
				
				sFilter = "nrouting_group_key = " + string(lKey)
				dsCenOut.SetFilter(sFilter)
				dsCenOut.Filter()
				of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" Filter = " + sFilter + " => dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
								+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
				//
				// Weicht Anzahl Legs ab?
				//
				if dsCenOut.RowCount() <> dsCharterMemory.RowCount() then
					of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" bDeleteLegs = true because of Rowcount" )
					bDeleteLegs = true
				end if
				
				for j = 1 to dsCenOut.RowCount() 
					for k = 1 to dsCharterMemory.RowCount()
						if dsCenOut.GetItemNumber(j,"nleg_number") = dsCharterMemory.GetItemNumber(k,"nleg_number") then
							//
							// K.O.-Check: Routing muss gleich der Vorgabe aus Beladedefinition sein!
							//
							if dsCenOut.GetItemNumber(j,"ntlc_from") <> dsCharterMemory.GetItemNumber(k,"ntlc_from") or &
								dsCenOut.GetItemNumber(j,"ntlc_to") <> dsCharterMemory.GetItemNumber(k,"ntlc_to") then
								of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" bDeleteLegs = true because Leg " + string(dsCenOut.GetItemNumber(j,"nleg_number")) + "  " + string(dsCenOut.GetItemNumber(j,"ntlc_from")) + " <> " + &
										string(dsCharterMemory.GetItemNumber(k,"ntlc_from")) + " or " + string(dsCenOut.GetItemNumber(j,"ntlc_to")) + " <> " + &
										string(dsCharterMemory.GetItemNumber(k,"ntlc_to")) )
								of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" bDeleteLegs = true (1)" )
								bDeleteLegs = true
							end if
						end if
					next
				next
				
				if bDeleteLegs then
					of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" bDeleteLegs set nrouting_group_key=" + string(lKey) )
				
					for j = dsCenOut.RowCount() to 1 step -1
						dsCenOut.DeleteRow(j)
					next
					dsCenOut.SetFilter("")
					dsCenOut.Filter()
				end if
			end if
			//
			// dsCharterMemory speichert Ist-Zustand des Fluges aus der Beladedefinition
			// Nur wenn der sp$$HEX1$$e400$$ENDHEX$$ter generierte Flug exakt dieser Vorgabe entspricht, wird
			// er nach cen_out gespeichert.
			//
			dsCharterMemory.Retrieve(lRoutingPlanKey,lFlightGroup)
			//
			// Flight Group f$$HEX1$$fc00$$ENDHEX$$r die Kontrolle nach dem Gruppenwechsel merken
			//
			lKey = lFlightGroup
		end if

		// ---------------------------------------------------------------------
		// Ok, der Generierungsbetrieb kommt vor, ist der Flug mit dem 
		// dem ersten Eintrag des Generierungsbetriebes mit dem aktuellen
		// Generierungstag im Flugplan? Falls nicht brauchen wir die ganze
		// Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen nicht.
		// ---------------------------------------------------------------------
		If lFound > 0 Then
			If of_check_flightnumber(lFound) > 0 Then
				bGenerateFlight = True
			Else
				bGenerateFlight = False
			End if	
			// -----------------------------------------------------------------
			// Pr$$HEX1$$fc00$$ENDHEX$$fung ob das Flugger$$HEX1$$e400$$ENDHEX$$t generiert werden soll
			// -----------------------------------------------------------------
			If bGenerateFlight = True Then
				If of_check_actyp() = False  Then
					bGenerateFlight = False
				End if
			End if	
		Else
			bGenerateFlight = False
		End if	
	End if	
	
	of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" processing flight " + string(lFlightNumber) + ", nrouting_group_key = " + string(lCurrentGroupKey))
	// -------------------------------------------------------------------------
	// Kein City Pair und innerhalb der Gruppe kommt der Generierungsbetrieb vor.
	// -------------------------------------------------------------------------
	If lFlightnumber <> -1 and bGenerateFlight = True Then
		//HR 16.11.2012 Wenn erstes Leg nicht generiert, dann auch das weiter nicht
		if lLegNumber>1 and lResultKeyGroup=0 then
			of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" flight " + string(lFlightNumber) + " ignored, because 1. Leg not generated")
		else
			of_search_flightnumber(i)
		end if
	else
		of_trace("of_generate_flights", 50,"Row "+string(i)+" of "+string(lRowcount)+" flight " + string(lFlightNumber) + " ignored")
	End if
Next

//
// Nicht vergessen, letzte Gruppe erf$$HEX1$$e400$$ENDHEX$$hrt keinen Wechsel mehr innerhalb der Schleife
//
if bCharter then
	//
	// Gruppe hat gewechselt:
	// Sind die Legs der letzten Gruppe vollst$$HEX1$$e400$$ENDHEX$$ndig?
	//
	if dsCharterMemory.RowCount() > 0 then
		of_trace("of_generate_flights", 50,"final dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
						+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
		bDeleteLegs = false
		//
		// Kontrolle: dsCharterMemory des vorherigen Flugs gegen dsCenOut
		// und l$$HEX1$$f600$$ENDHEX$$sche Fl$$HEX1$$fc00$$ENDHEX$$ge, die nicht 1:1 der Beladedefinition entsprechen
		//
		dsCenOut.SetFilter("nrouting_group_key = " + string(lKey))
		dsCenOut.Filter()
		//
		// Weicht Anzahl Legs ab?
		//
		if dsCenOut.RowCount() <> dsCharterMemory.RowCount() then
			of_trace("of_generate_flights", 50,"bDeleteLegs = true because of Rowcount" )
			bDeleteLegs = true
		end if
		for j = 1 to dsCenOut.RowCount() 
			for k = 1 to dsCharterMemory.RowCount()
				if dsCenOut.GetItemNumber(j,"nleg_number") = dsCharterMemory.GetItemNumber(k,"nleg_number") then
					//
					// K.O.-Check: Routing muss gleich der Vorgabe aus Beladedefinition sein!
					//
					if dsCenOut.GetItemNumber(j,"ntlc_from") <> dsCharterMemory.GetItemNumber(k,"ntlc_from") or &
						dsCenOut.GetItemNumber(j,"ntlc_to") <> dsCharterMemory.GetItemNumber(k,"ntlc_to") then
						of_trace("of_generate_flights", 50,"bDeleteLegs = true because Leg " + string(dsCenOut.GetItemNumber(j,"nleg_number")) + "  " + string(dsCenOut.GetItemNumber(j,"ntlc_from")) + " <> " + &
								string(dsCharterMemory.GetItemNumber(k,"ntlc_from")) + " or " + string(dsCenOut.GetItemNumber(j,"ntlc_to")) + " <> " + &
								string(dsCharterMemory.GetItemNumber(k,"ntlc_to")) )
						of_trace("of_generate_flights", 50,"bDeleteLegs = true (2)" )
						bDeleteLegs = true
					end if
				end if
			next
		next
		if bDeleteLegs then
			of_trace("of_generate_flights", 50,"bDeleteLegs set nrouting_group_key=" + string(lKey) )
		end if
		for j = dsCenOut.RowCount() to 1 step -1
			if bDeleteLegs then
				dsCenOut.DeleteRow(j)
			end if
		next
		dsCenOut.SetFilter("")
		dsCenOut.Filter()
	end if
end if

// -------------------------------------------------------------------------
// und jetzt die City Pair Beladung.
// -------------------------------------------------------------------------	

lRowcount =  dsGenerateRoutingPlan.Rowcount()
For I = 1 to lRowcount
	lFlightNumber 	= dsGenerateRoutingPlan.Getitemnumber(i,"nflight_number")
	sTLCFrom		= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc")
	sTLCTo			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc_1")
	lTLCFrom		= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_from")
	lTLCTo			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_to")		
	sSuffix			= dsGenerateRoutingPlan.Getitemstring(i,"csuffix")
	lFlightLegs 		= dsGenerateRoutingPlan.Getitemnumber(i,"compute_legs")
	lLegNumber		= dsGenerateRoutingPlan.Getitemnumber(i,"nleg_number")
	sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	iMLFlight 		= dsGenerateRoutingPlan.Getitemnumber(i, "nml_flight")
	
	// 24.06.2010 HR:
	if lFlightNumber <> -1 then continue
	
	// --------------------------------------------------------
	// 12.06.2008, KF
	// --------------------------------------------------------
	if isnull(sLoadingUnit) and lFlightNumber= -1 then
		of_trace("of_generate_flights", 10, "Row "+string(i)+" of "+string(lRowcount)+" Nullvalue in cunit found for Citypair  " + sTLCFrom + " - " + sTLCTo )
		continue
	end if
	
	// Migration FRA ZD - FRA ZF
	If dsGenerateRoutingPlan.Getitemstring(i,"cunit") = "0115" and sUnit = "1150" Then
		sLoadingUnit	= "1150"
	Else
		sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	End if

	// ---------------------------------------------------------------------
	// Bei City Pair nur die Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r die aktuelle Unit !
	// ---------------------------------------------------------------------
	If lFlightnumber = -1 Then
		If sLoadingUnit = sUnit Then
			of_search_city_pair(i)
		End if
	End if
Next

If bDebugCenOut = True Then
	// f_print_datastore(dsCenOutDebug)
End if	

if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"cen_out.xls", excel5!, true)

return True

end function

public function boolean of_generate_jobs (date dgenerate_date, string sclientparm, string sunitparm, long ljob_keyparm);long 		i
long		iFileNum
string		sFilter 			= ""
string 	sServiceName 	= ""
string		sLastRead 		= ""
Long		lStart
Long		lEnd
Boolean	bReturn
// -----------------------------------------------------------
// Job Liste erstellen
// 10 Tagesflugplan Neuanlage 			pro Betrieb
// 20 Tagesflugplan Update 					pro Betrieb
// 30 Tagesflugplan Delete 					pro Betrieb
// 40 Matdispo Neuanlage	 				pro Betrieb
// 50 Matdispo Update		 				pro Betrieb
// 60 Tagesflugplan Overwrite 				pro Betrieb
// 70 Non Flight Business Neuanlage 		pro Betrieb
// 80 Non Flight Business Update	 		pro Betrieb
// 90 Non Flight Business Delete	 		pro Betrieb
// 100 Non Flight Business Matdispo		pro Betrieb
// 110 Zentrale Matdispo 					pro Mandant (!)	Auskommentiert am 29.01.2004
// 120 $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen l$$HEX1$$f600$$ENDHEX$$schen	pro Betrieb
// 130 History l$$HEX1$$f600$$ENDHEX$$schen							pro Betrieb
// 140 PPS Daten l$$HEX1$$f600$$ENDHEX$$schen
// 150 PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen
// 160 PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen
// 170 Asynchrone Generierung (Tagesflugplan + Matdispo $$HEX1$$fc00$$ENDHEX$$ber OnlineExplosion)
// -----------------------------------------------------------

// 28.10.2010 HR: Retrievelargument eingebaut
dsJobs2Generate.Retrieve(ii_generate_type)

// 24.10.2014 HR: Datum der Generierung f$$HEX1$$fc00$$ENDHEX$$r die History
idt_generate_date = datetime(dgenerate_date, time("00:00"))

// -----------------------------------------------------------
// Instanziierung/Aufruf f_service_loop
// -----------------------------------------------------------
//uo_job.iDebug_Level = iDebuglevel
//uo_job.sInstanceName = sInstance
//uo_job.of_generate_jobs(dDatum, "", "", 0)

// -----------------------------------------------------------
// Instanziierung/Aufruf CBASE Application
// -----------------------------------------------------------
//	uo_job.iDebug_Level = s_app.iTrace
//	uo_job.sTraceFile 			= ProfileString ("cbase.ini", "TRACE", "DIRECTORY", "c:\") + ProfileString ("cbase.ini", "TRACE", "LOGFILE", "trace_" + string(today(),"yyyy-mm-dd") + ".txt")
//	uo_job.lAirlineParameter 	= dw_1.GetItemNumber(dw_1.GetRow(),"nairline_key")
//	uo_job.lJobNumber				= lJobNumber
//	uo_job.of_generate_jobs(Date(strJob.sReturn),s_app.sMandant, s_app.sWerk,lJobKey)

// -----------------------------------------------------------
// Sofern ein Filter angegeben wurde, wird dieser gesetzt,
// andernfalls werden alle Jobs f$$HEX1$$fc00$$ENDHEX$$r alle Betriebe ausgef$$HEX1$$fc00$$ENDHEX$$hrt.
// -----------------------------------------------------------
If sClientParm <> "" and sUnitParm <> "" Then
	sFilter = "cunit = '" + sUnitParm + "' and cclient = '" + sClientParm + "'" 
else
	// --------------------------------------------------------
	// 22.11.06 Filter auf Instanz wenn als Dienst gestartet
	// 25.04.11 Gro$$HEX1$$df00$$ENDHEX$$/Kleinschreiung ignorieren
	// --------------------------------------------------------
	sFilter = "upper(cinstance) = '" + upper(this.sInstanceName) + "' "
End if	

If lJob_KeyParm > 0 Then
	If len(sFilter) > 0 Then sFilter = sFilter + " and "
	sFilter = sFilter + "njob_type = " + string(lJob_KeyParm)
End if

If lJobNumber > 0 Then
	If len(sFilter) > 0 Then sFilter = sFilter + " and "
	sFilter = sFilter + "njob_key = " + string(lJobNumber)
End if

// -----------------------------------------------------------
// Falls aus der Applikation gestartet wurde
// -----------------------------------------------------------
If lAirlineParameter > 0 then
	If len(sFilter) > 0 Then sFilter = sFilter + " and "
	sFilter = sFilter + "nairline_key = " + string(lAirlineParameter)
End if

If len(sFilter) > 0 Then
	dsJobs2Generate.SetFilter(sFilter)
	dsJobs2Generate.Filter()
End if	

If isvalid(w_cbase_generate_dialog) Then
	bSendMessage = True
Else
	bSendMessage = False
End if	
dtToday = Datetime(Today())

//
// 08.07.04: Aus aktuellem Anlass: nochmals die Reihenfolge sicherstellen	cclient A, cunit A, nprio A
// 24.08.04: Neue Sportierung: cclient A, cunit A, njob_type A
// 23.12.05: Neue Sportierung: njob_prio A, cclient A, cunit A, njob_type A
// 30.10.08: Neue Sportierung: njob_prio A, cclient A, cunit A, njob_type A, ndays_offset A, nairline_key A
// 30.10.10: Neue Sportierung: njob_kind A, njob_prio A, cclient A, cunit A, njob_type A, ndays_offset A, nairline_key A
// 13.02.12: Neue Sportierung: njob_kind A, njob_prio A, cclient A, cunit A, comp_njob_type A, ndays_offset A, nairline_key A
if ii_generate_type <> 2 then
	dsjobs2generate.SetSort("njob_kind A, njob_prio A, cclient A, cunit A, comp_njob_type A, ndays_offset A, nairline_key A")
else
	// --------------------------------------------------------------------------------------------------------------------
	// 12.04.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r reine Einmalereignisinstanzen ist eine andere Prio n$$HEX1$$f600$$ENDHEX$$tig
	// --------------------------------------------------------------------------------------------------------------------
	dsjobs2generate.SetSort("njob_prio A, ndays_offset A, cclient A, cunit A, comp_njob_type A, nairline_key A")
end if

dsjobs2generate.Sort()

// --------------------------------------------------------------------------------------------------------------------
// 09.11.2010 HR: Neuer Kopf im LOG-File der Generierung
// --------------------------------------------------------------------------------------------------------------------
this.of_trace("of_generate_jobs", 1, " ")
this.of_trace("of_generate_jobs", 1, " ")
this.of_trace("of_generate_jobs", 1, "#######################################################################################################")
this.of_trace("of_generate_jobs", 1, "Processing joblist for date " + String(dgenerate_date)+ "   Jobs in Queue: "+string(dsjobs2generate.rowcount()))
this.of_trace("of_generate_jobs", 1, "Debug Level " + String(this.idebug_level))
this.of_trace("of_generate_jobs", 1, "#######################################################################################################")

For i = 1 to dsjobs2generate.rowcount()
	this.of_log_joblist(i, DateTime(dgenerate_date))
Next 

// --------------------------------------------------------------------
// Hier wird in die ServiceLog-Datei protokolliert.
// Wenn heute noch nicht ins Logfile  geschrieben wurde
// --------------------------------------------------------------------
sLastRead = ProfileString(sProfile, this.sInstanceName, "LastRead", "01.01.2000")

// --------------------------------------------------------------------------------------------------------------------
// 09.06.2011 HR: Log-File Variabel f$$HEX1$$fc00$$ENDHEX$$r zuk$$HEX1$$fc00$$ENDHEX$$nftige Instanzen variabel machen
// --------------------------------------------------------------------------------------------------------------------
if pos(upper(this.sInstanceName), "INSTANCE")>0 then
	sServiceName="cbase_service"+mid(this.sInstanceName, 9)
else
	sServiceName="GUI"
end if

this.of_trace("of_generate_jobs", 100, " sServiceName "+sServiceName)

// Den Dateinamen des Logfiles festlegen
sServiceLogFileName =   sServiceName + ".log"
sServiceLogFile 		+= sServiceLogFileName

// Die Jobs wurden noch nicht ausgef$$HEX1$$fc00$$ENDHEX$$hrt und heute wurde noch nicht in die logdatei geschrieben
if sLastRead <> String(Today(), "dd.mm.yyyy") then
	this.of_write_service_log("working")
end if

For i = 1 to dsjobs2generate.rowcount()
	
	lStart = CPU()
	
	ii_generate_jobtype 			= dsJobs2Generate.Getitemnumber(i,"njob_kind")	// 28.10.2010 HR: Jobtype merken (1: Standard, 2: Einmalereignisse)
	sUnit 								= dsJobs2Generate.Getitemstring(i,"cunit")
	sClient 							= dsJobs2Generate.Getitemstring(i,"cclient")
	lAirlineKey 						= dsJobs2Generate.Getitemnumber(i,"nairline_key")
	sAirline							= dsJobs2Generate.Getitemstring(i,"cairline")
	iPaxType 	 					= dsJobs2Generate.Getitemnumber(i,"npax_type")
	iQPType							= dsJobs2Generate.Getitemnumber(i,"loc_jobs_nairline_qp_key")	// 06.07.2009 HR: AMOS-Abl$$HEX1$$f600$$ENDHEX$$sung
	iDays_Offset 					= dsJobs2Generate.Getitemnumber(i,"ndays_offset")
	iJob_Type						= dsJobs2Generate.Getitemnumber(i,"njob_type")
	lJob_Key							= dsJobs2Generate.Getitemnumber(i,"njob_key")
	iActiv								= dsJobs2Generate.Getitemnumber(i,"nactiv")
	iJobParameter					= dsJobs2Generate.Getitemnumber(i,"nparameter")
	dGenerationDate				= RelativeDate(dgenerate_date,iDays_Offset)
	lTimeStart 						= cpu()
	dtStart 							= Datetime(today(),now())

	 // 21.08.2009 HR: Amos-Abl$$HEX1$$f600$$ENDHEX$$sung
	 //iUseLoaclAdjustment = dsJobs2Generate.Getitemnumber(i,"nuse_loc_ajustment")  
	sAdjustmentSet 				=  dsJobs2Generate.GetItemString(i,"cset")   // 16.06.2010 HR: CR IMView302
 	
	ii_orders_transfer				= dsJobs2Generate.Getitemnumber(i,"norders_transfer")	// 17.12.2013 HR: Sollen am Ende Auftr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r OrderChange erstellt werden?
	ii_aut_mahlzeitenverteilung 	= dsJobs2Generate.Getitemnumber(i,"nmealdistribution") 	// 20.11.2012 HR: Mahlzeitenverteilung
	iImportSpmls 					= dsJobs2Generate.Getitemnumber(i,"nuse_spml") 
	ii_create_checkpts  			= dsJobs2Generate.Getitemnumber(i,"ncheckpt") 				// 15.01.2015 HR: Flightchecker
	ii_trainbusiness					= dsJobs2Generate.Getitemnumber(i,"cen_airlines_ntb") 	// 29.07.2015 HR:

	If isnull(iJobParameter) Then iJobParameter = 0
	
	 // ------------------------
	 // Handling Joker ermitteln
	 // ------------------------
	 of_get_handling_joker()
	 yield()	
	 // ------------------------
	 // Message an Window
	 // ------------------------
	 If bSendMessage Then
		 sPostMessage = "Execute job for unit: " + sUnit + " Airline: " + sAirline + " Job ID: " + string(iJob_Type)
		 w_cbase_generate_dialog.triggerevent("ue_redraw")
		 yield()	
	 End if
		
	 this.of_trace("of_generate_jobs", 1, "Starting job   # " + String(i, "000") + " - "  + this.of_get_job_name(i))

	// --------------------------------------------------------------------------------------------------------------------
	// 28.09.2015 HR: Weiche f$$HEX1$$fc00$$ENDHEX$$r Aktiv/Inaktiv eingebaut, LOG-Eintrag bei Inaktiv, Jobsverzweigung mit Case
	// --------------------------------------------------------------------------------------------------------------------
	if iActiv = 0 Then
		 this.of_trace("of_generate_jobs", 1, "Jobs for Airline are deactivated!")
	else
		choose case iJob_Type
			case 10 // 10 Tagesflugplan Neuanlage 			pro Betrieb
				iGenerierungsstatus 	= 1
				sGenerierungsstatus 	= "Insert"
				bReturn = of_generate_schedule(True) 

			case 20 // 20 Tagesflugplan Update 				pro Betrieb
				iGenerierungsstatus 	= 2
				sGenerierungsstatus 	= "Update"
				bReturn = of_generate_schedule(True)

			case 30 // 30 Tagesflugplan Delete 				pro Betrieb
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete"
				 bReturn = of_generate_schedule_delete() 
				 
			case 40 // 40 Matdispo Neuanlage	 				pro Betrieb
				 iGenerierungsstatus 	= 4
				 sGenerierungsstatus 	= "Explosion Insert"
				 bReturn = of_generate_explosion() 			 
				 
			case 50 // 50 Matdispo Update		 				pro Betrieb
				 iGenerierungsstatus 	= 5
				 sGenerierungsstatus 	= "Explosion Update"
				 bReturn = of_generate_explosion() 
				 
			case 60 // 60 Tagesflugplan Overwrite 			pro Betrieb
				 iGenerierungsstatus 	= 2
				 sGenerierungsstatus 	= "Overwrite"
				 bReturn = of_generate_schedule(False)		 
				 
			case 70 // 70 Non Flight Business Neuanlage 	pro Betrieb
				 iGenerierungsstatus 	= 1
				 sGenerierungsstatus 	= "Insert"
				 bReturn = of_generate_non_flight_business(True)	
				 
			case 80 // 80 Non Flight Business Update	 	pro Betrieb
				 iGenerierungsstatus 	= 2
				 sGenerierungsstatus 	= "Update"
				 bReturn = of_generate_non_flight_business(True)	
				 
			case 90 // 90 Non Flight Business Delete	 		pro Betrieb
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete"
				 bReturn = of_delete_non_flight_business()
				 
			case 100 // 100 Non Flight Business Matdispo	pro Betrieb
				 iGenerierungsstatus 	= 6
				 sGenerierungsstatus 	= "Explosion Insert"
				 bReturn = of_generate_explosion()
				 
			case 110 // 110 Zentrale Matdispo 				pro Mandant (!)	Auskommentiert am 29.01.2004
				 iGenerierungsstatus 	= 7
				 sGenerierungsstatus 	= "Central Itemlist Explosion"
		//			 of_generate_explosion()
		
			case 120 // 120 $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen l$$HEX1$$f600$$ENDHEX$$schen	pro Betrieb
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete Messages"
				 bReturn = of_delete_messages()	 
				 
			case 130 // 130 History l$$HEX1$$f600$$ENDHEX$$schen						pro Betrieb
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete History"
				 bReturn = of_generate_schedule_delete_history() 			 
				 
			case 140 // 140 PPS Daten l$$HEX1$$f600$$ENDHEX$$schen
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete PPS data"
				 bReturn = of_delete_pps_data() 
				
			case 150 // 150 PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete PPS alarms"
				 bReturn = of_delete_pps_alarms()
				 
			case 160 // 160 PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen
				 iGenerierungsstatus 	= 3
				 sGenerierungsstatus 	= "Delete PPS changes"
				 bReturn = of_delete_pps_changes()	 
				
			case 170 // 170 Asynchrone Generierung (Tagesflugplan + Matdispo $$HEX1$$fc00$$ENDHEX$$ber OnlineExplosion)
				 // --------------------------------------------------------------------------------------------------------------------
				 // 02.08.2010 HR: Asynchrone Generierung (Zuerst normaler Tagesflugplan,
				 //   dann Matdispo $$HEX1$$fc00$$ENDHEX$$ber OnlineExplosion pro Flug)
				 // --------------------------------------------------------------------------------------------------------------------
				 iGenerierungsstatus 	= 1
				 sGenerierungsstatus 	= "Insert"
				 bReturn = of_generate_schedule(True) 
				 if bReturn then
					bReturn = of_generate_explosionjobs()
				end if
				 sGenerierungsstatus 	= "Asynchron"
				 
			case else
				this.of_trace("of_generate_jobs", 1, "Jobstype "+string(iJob_Type)+" not defined!")
				
 		end choose
	End if	

	yield()
	of_save_protocol()
	
	if bReturn = false then
		if ii_generate_jobtype=2 then
		   	// 09.12.2011 HR: Bei Einmalereignissen muss im Fehlerfall auch der Datensatz markiert werden, damit er nicht immer wieder ausgef$$HEX1$$fc00$$ENDHEX$$hrt wird
			of_write_job_history_once(2)	
		end if

	  	this.of_trace("of_generate_jobs", 1, "        job   # " + String(i, "000") + " - " + sGenerierungsstatus + " - Returned FALSE!!")

		rollback using SQLCA;  
	end if
	
	lEnd = CPU()
		
	this.of_trace("of_generate_jobs", 1, "Processing job # " + String(i, "000") + " of " + String(dsjobs2generate.rowcount(), "000") + " took " + string((lEnd - lStart) / 1000, "0.00") + " seconds")
	
Next

// Die Jobs wurden ausgef$$HEX1$$fc00$$ENDHEX$$hrt und heute wurde noch nicht in die logdatei geschrieben
if sLastRead <> String(Today(), "dd.mm.yyyy") then
	SetProfileString(sProfile, this.sInstanceName, "LastRead", String(Today(), "dd.mm.yyyy"))
	this.of_write_service_log("finished")
end if

return True
end function

public function long of_get_account_key (long arg_customer_key, string arg_code);//=================================================================================================
//
// of_get_account_key
//
// Holt den passenden AccountCode zum Text
//
//=================================================================================================
long	lReturn

select naccount_key
  into :lReturn
  from cen_airline_accounts
 where nairline_key 	= :arg_customer_key
   and caccount		= :arg_code;
 
if sqlca.sqlcode <> 0 then
	return -1
else
	return lReturn
end if

end function

public function string of_get_customer_code (long arg_customer_key, string arg_unit);//==================================================================================
//
// of_get_customer_code
//
// Ermittelt die 4-stellige (bis zu 18-stellige) Kundennummer je Betrieb
//
//==================================================================================
long		lFind

if dsCustomerCodes.RowCount() = 0 then return ""

lFind = dsCustomerCodes.Find("nairline_key = " + string(arg_customer_key) + &
								" and cunit = '" + arg_unit + "'",1,dsCustomerCodes.RowCount())

if lFind = 0 then
	lFind = dsCustomerCodes.Find("nairline_key = " + string(arg_customer_key) + &
									" and cunit = '----'",1,dsCustomerCodes.RowCount())
end if

if lFind > 0 then
	return dsCustomerCodes.GetItemString(lFind,"ccustomer_code")
end if

return ""

end function

public function integer of_update_day7 ();date			dUpdate7Date
string		sBox_From,sBox_To,sShortText,sLongText	
long			lKey, lACOwnerKey
integer		iTest

If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

// ---------------------------------------------------
// 7 Tage zur$$HEX1$$fc00$$ENDHEX$$ck
// ---------------------------------------------------
// dUpdate7Date	= Relativedate(dNewGenerationDate,-7)
dUpdate7Date	= Relativedate(dGenerationDate,-7)	// 15.03.05
sBoxFrom				= ""
sBoxTo				= ""
sRemarkText			= ""
iStatusUpdate7		= 0

SELECT nhandling_type_key,  
		 chandling_type_text,
		 chandling_type_description,
		 cbox_from,   
		 cbox_to  
  INTO :lKey, 
		 :sShortText,
		 :sLongText,
		 :sBox_From,   
		 :sBox_To  
  FROM cen_out  
WHERE  nairline_key 			= :lAirlineKey  AND  
		 nflight_number 		= :lFlightNumber  AND  
		 csuffix 				= :sSuffix  AND 
		 cunit	 				= :sUnit  AND 
		 ctlc_from				= :sTLCFrom AND
		 cen_out.ddeparture	= :dUpdate7Date;

If sqlca.sqlcode = 0 then
	// ----------------------------------------
	// 1 = Handling und Rampenboxen
	// 2 = Rampenboxen
	// 3 = Handling
	// ----------------------------------------
	If iJobParameter = 1 Then
		lHandlingTypeKey 		= lKey
		sHandlingShortText	= sShortText
		sHandlingLongText		= sLongText
		sBoxFrom					= sBox_From
		sBoxTo					= sBox_To
		iStatusUpdate7			= 1
		
		// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014
		if sHandlingShortText = "DLV" or sHandlingShortText = "SPC"  or sHandlingShortText = "INT" then 
			
			sHandlingShortText = "REQ"
			
			select nhandling_type_key, cdescription into :lHandlingTypeKey, :sHandlingLongText from cen_handling_types where nairline_key = :lAirlineKey and ctext = 'REQ';
			
			if sqlca.sqlcode <> 0 then
				lHandlingTypeKey = 0
				sHandlingLongText = ""
			end if
		
		end if
		
	ElseIf iJobParameter = 2 Then
		sBoxFrom					= sBox_From
		sBoxTo					= sBox_To
		iStatusUpdate7			= 0
		
	ElseIf iJobParameter = 3 Then
		lHandlingTypeKey 		= lKey
		sHandlingShortText	= sShortText
		sHandlingLongText		= sLongText
		sBoxFrom					= ""
		sBoxTo					= ""
		iStatusUpdate7			= 1
		
		// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014
		if sHandlingShortText = "DLV" or sHandlingShortText = "SPC" or sHandlingShortText = "INT" then 
			
			sHandlingShortText = "REQ"
			
			select nhandling_type_key, cdescription into :lHandlingTypeKey, :sHandlingLongText from cen_handling_types where nairline_key = :lAirlineKey and ctext = 'REQ';
			
			if sqlca.sqlcode <> 0 then
				lHandlingTypeKey = 0
				sHandlingLongText = ""
			end if
		
		end if		
		
	End if	
	
Elseif sqlca.sqlcode = 100 then
	sBoxFrom						= ""
	sBoxTo						= ""
	If iJobParameter = 2 Then
		iStatusUpdate7				= 0
	Else
		// -----------------------------------------------
		// Anzeige im Flugbrowser : Kein Update Tag 7
		// -----------------------------------------------
		iStatusUpdate7				= 2
	End if
	//
	// 25.08.05 Achtung: Meldung darf nur erfolgen, wenn das Leg auch f$$HEX1$$fc00$$ENDHEX$$r den
	// Betrieb bestimmt ist
	//
	if sUnit = sLoadingUnit then
		return -2	// war 0
	end if
Else
	sBoxFrom						= ""
	sBoxTo						= ""
	If iJobParameter = 2 Then
		iStatusUpdate7				= 0
	Else
		iStatusUpdate7				= 2
	End if	
	//
	// 25.08.05 Achtung: Meldung darf nur erfolgen, wenn das Leg auch f$$HEX1$$fc00$$ENDHEX$$r den
	// Betrieb bestimmt ist
	//
	if sUnit = sLoadingUnit then
		return -1
	end if
End if

return 0

end function

public function integer of_validation ();//=====================================================================================
//
// of_validation
//
// Nach der Fluggenerierung: 
// Pr$$HEX1$$fc00$$ENDHEX$$fung auf g$$HEX1$$fc00$$ENDHEX$$ltige generierte Daten, da sonst kompletter Tag nicht gespeichert
// werden kann.
//
// 17.11.05	Umzug einiger of_update-Funktionen hierher!
//				Diese Aktionen sollten n$$HEX1$$e400$$ENDHEX$$mlich vor der Generierung der Beladung erfolgen!
//
//=====================================================================================
long		i, j, k
long		lFind
long		llFlightnumber
string		lsAirlineCode
string		lsSuffix
long		llCurrentFlightnumber
string		lsCurrentAirlineCode
string		lsCurrentSuffix
integer	liLegnumber
integer	liCurrentLegnumber
date		dDepartureLeg1
string		lsAccountCode
long		llAccountKey
long		llResultKeyError
datetime	dtReturnFlightDate
datetime	dtNewReturnFlightDate
string		sLocalDepartureTime
long		lChangedResultKey
string		lsDepartureTimeLeg1
string		lsCurrentDepartureTime
string		lsCurrentUnit
string		lsUnit
long 		llDelResultGroupKey[]
long 		llEmptyDelResultGroupKey[]
string 	ls_tlc_from, ls_tlc_to	// 07.06.2011 HR:
string 	ls_Current_tlc_from, ls_Current_tlc_to	// 07.06.2011 HR:
datetime	dt_Current_Returndate, dt_Returndate // 14.02.2012 HR:

//-------------------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung doppelte Flugnummer
// und
// Pr$$HEX1$$fc00$$ENDHEX$$fung dReturn_date bei Leg 1
//-------------------------------------------------------------------------------------
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"ds_cen_out_validation_1_"+string(now(),"hhmmss")+".xls", excel5!, true)

for i = 1 to dsCenOut.RowCount()
	lsCurrentAirlineCode 		= dsCenOut.GetItemString(i,"CAIRLINE")
	llCurrentFlightnumber 	= dsCenOut.GetItemNumber(i,"NFLIGHT_NUMBER")
	lsCurrentSuffix 				= dsCenOut.GetItemString(i,"CSUFFIX")
	If IsNull(lsCurrentSuffix) Or Len(Trim(lsCurrentSuffix)) = 0 Then lsCurrentSuffix = ' '

	liCurrentLegnumber		= dsCenOut.GetItemNumber(i,"NLEG_NUMBER")
	lsCurrentDepartureTime	= dsCenOut.GetItemString(i,"cdeparture_time")
	lsCurrentUnit				= dsCenOut.GetItemString(i,"cunit")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 07.06.2011 HR: Es kann sein, dass sich bei einem Betrieb die Flugnummer
	//					   	pro Leg_nr mehrmals mit unterschiedlichem Routing vorhanden 
	//                        ist. Deshalb wurde das Routing in den Index aufgenommen
	// --------------------------------------------------------------------------------------------------------------------
	ls_Current_tlc_from 		= dsCenOut.GetItemString(i,"ctlc_from")
	ls_Current_tlc_to			= dsCenOut.GetItemString(i,"ctlc_to")
	
	// 14.02.2012 HR: Der Index wurde noch mal um das Returndate erweitert, da es in NAM hier unterschiede gibt
	dt_Current_Returndate = dsCenOut.GetItemDatetime(i,"dReturn_date")
	
	// Im ersten Leg muss Return-Date gleich Departure-Date sein
	if liCurrentLegnumber = 1 then
		dDepartureLeg1 = date(dsCenOut.GetItemDateTime(i,"DDEPARTURE"))
		dsCenOut.SetItem(i,"dreturn_date",DateTime(dDepartureLeg1,Time("00:00")))
		lsDepartureTimeLeg1 = dsCenOut.GetItemString(i,"cdeparture_time")
	else
		// 13.10.2006 Alle Legs m$$HEX1$$fc00$$ENDHEX$$ssen die gleiche Abflugzeit haben
		if lsDepartureTimeLeg1 <> lsCurrentDepartureTime then
			if dsCenOut.GetItemNumber(i,"nml_flight") <> 1 then
				// --------------------------------------------------------------------------------------------------------------------
				// 11.01.2011 HR: Nur wenn da ein Wert in der Variable steht, dann zuordnen
				// --------------------------------------------------------------------------------------------------------------------
				if isnull(lsDepartureTimeLeg1) or trim(lsDepartureTimeLeg1)="" then
					lsDepartureTimeLeg1 = lsDepartureTimeLeg1
				else
					dsCenOut.SetItem(i,"cdeparture_time",lsDepartureTimeLeg1)
				end if
			end if
		end if
	end if

	//HR 26.08.08
	llDelResultGroupKey = llEmptyDelResultGroupKey
	
	for j = dsCenOut.RowCount() to 1 step -1
		if i <> j then
			lsAirlineCode 	= dsCenOut.GetItemString(j,"CAIRLINE")
			llFlightnumber 	= dsCenOut.GetItemNumber(j,"NFLIGHT_NUMBER")
			lsSuffix 			= dsCenOut.GetItemString(j,"CSUFFIX")
			If IsNull(lsSuffix) Or Len(Trim(lsSuffix)) = 0 Then lsSuffix = ' '
			liLegnumber		= dsCenOut.GetItemNumber(j,"NLEG_NUMBER")
			lsUnit				= dsCenOut.GetItemString(j,"CUNIT")
			// --------------------------------------------------------------------------------------------------------------------
			// 07.06.2011 HR: Es kann sein, dass sich bei einem Betrieb die Flugnummer
			//					   pro Leg_nr mehrmals mit unterschiedlichem Routing vorhanden 
			//                            ist. Deshalb wurde das Routing in den Index aufgenommen
			// --------------------------------------------------------------------------------------------------------------------
			ls_tlc_from 		= dsCenOut.GetItemString(j,"ctlc_from")
			ls_tlc_to			= dsCenOut.GetItemString(j,"ctlc_to")			
			
			// 14.02.2012 HR: Der Index wurde noch mal um das Returndate erweitert, da es in NAM hier unterschiede gibt
			dt_Returndate	= dsCenOut.GetItemDatetime(j,"dReturn_date")
			
			if lsAirlineCode 					= lsCurrentAirlineCode and &
				llFlightnumber 				= llCurrentFlightnumber and &
				lsSuffix						= lsCurrentSuffix and &
				liLegnumber					= liCurrentLegnumber and &
				ls_Current_tlc_from 		= ls_tlc_from and &            
				ls_Current_tlc_to			= ls_tlc_to and &
				dt_Current_Returndate	= dt_Returndate and &
				lsUnit							= lsCurrentUnit then 	// 07.06.2011 HR: Routing mit in die Pr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
																			// 14.02.2012 HR: Returndate mit in die Pr$$HEX1$$fc00$$ENDHEX$$fung aufgenommen
				// Es gibt die gleiche Flugnummer schon einmal
				llResultKeyError = dsCenOut.GetItemNumber(j,"NRESULT_KEY")
				
				//HR 26.08.08
				llDelResultGroupKey[upperbound(llDelResultGroupKey) +1] = dsCenOut.GetItemNumber(j,"nresult_key_group")
				
				of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,lsAirlineCode + " " + &
										string(llFlightnumber) + lsSuffix,&
										string(dGenerationDate,s_app.sDateformat),&
										"Flight "+string(llFlightnumber)+of_checknull(lsSuffix)+"("+string(liLegnumber)+") already exists and is going to be deleted! (" + string(llResultKeyError) + ")")

				// Betreffende Zeile l$$HEX1$$f600$$ENDHEX$$schen, bevor Handling-Objekte angelegt werden
				dsCenOut.DeleteRow(j)
			end if
		end if
	next
	
	//HR 26.08.08: Falls Fl$$HEX1$$fc00$$ENDHEX$$ge gel$$HEX1$$f600$$ENDHEX$$scht wurden m$$HEX1$$fc00$$ENDHEX$$ssen alle zugeh$$HEX1$$f600$$ENDHEX$$rigen Legs mit gel$$HEX1$$f600$$ENDHEX$$scht werden
	if upperbound(llDelResultGroupKey) > 0 then
		for j = dsCenOut.RowCount() to 1 step -1
			for k=1 to upperbound(llDelResultGroupKey)
				if llDelResultGroupKey[k] = dsCenOut.GetItemNumber(j,"nresult_key_group") then
					dsCenOut.DeleteRow(j)
					exit
				end if
			next
		next
	end if
next
of_trace("of_validation", 10,"Rows in dsCenOut after Step 1: "+string(dsCenOut.rowcount()))

//-------------------------------------------------------------------------------------
// Datastore dsCenOut die nicht Job Units herausl$$HEX1$$f600$$ENDHEX$$schen.
//-------------------------------------------------------------------------------------
For i = dsCenOut.Rowcount() to 1 Step -1
	 If dsCenOut.GetitemString(i,"cunit") <> sUnit Then
		 dsCenOut.deleterow(i)
	 End if	 
Next	

if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"ds_cen_out_validation_2_"+string(now(),"hhmmss")+".xls", excel5!, true)
of_trace("of_validation", 10,"Rows in dsCenOut after Step 2: "+string(dsCenOut.rowcount()))

// --------------------------------------------------------------
// Sortierfeld Departure und Interne Zeiten erstellen/$$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen.
// --------------------------------------------------------------
// Sortierung: nrouting_group_key, nleg_number

// --------------------------------------------------------------------------------
// 25.06.2009 HR: Zuerst machen wir das Ganz nur f$$HEX1$$fc00$$ENDHEX$$r Fluge (bei CFS Alles)
//						und weiter unten dann f$$HEX1$$fc00$$ENDHEX$$r CityPairs (nur Standard)
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// 24.11.2010 HR: Bei CFS wird nach ResultGroup sortiert sonst wie gehabt
// --------------------------------------------------------------------------------------------------------------------
if bCFSAirline then
	dsCenOut.setsort("nresult_key_group,  nleg_number")
else
	dsCenOut.setfilter("nrouting_group_key>0")
	dsCenOut.filter()

	dsCenOut.setsort("nrouting_group_key,  nleg_number")
end if
dsCenOut.Sort()

if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"ds_cen_out_validation_3_"+string(now(),"hhmmss")+".xls", excel5!, true)

For i = 1 to dsCenOut.Rowcount() 
	lRoutingPlanGroupKey 		= dsCenOut.GetitemNumber(i,"nrouting_group_key")
	
	// 03.06.2009 HR: Merken des Citypair-Keys f$$HEX1$$fc00$$ENDHEX$$r die of_create_sort -Funktion
	lRoutingPlanGroupKey_CP 	= dsCenOut.GetitemNumber(i,"nrouting_group_key_cp")
		
	sFirstLegTime					= dsCenOut.GetitemString(i,"cdeparture_time")
	sFirstLegRampTime	 		= dsCenOut.GetitemString(i,"cramp_time")
	sFirstLegKitchenTime 			= dsCenOut.GetitemString(i,"ckitchen_time")
	lFirstLegTLC_From	 			= dsCenOut.GetitemNumber(i,"ntlc_from")
	lFlightNumber					= dsCenOut.GetitemNumber(i,"nflight_number")
	dtFirstLegDeparture			= dsCenOut.GetitemDateTime(i,"dDeparture")
	lCurrentLegNumber			= dsCenOut.GetitemNumber(i,"nleg_number")
	sSuffix 							= dsCenOut.GetitemString(i,"csuffix")
	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
	sTLCFrom 						= dsCenOut.GetitemString(i,"ctlc_from")

	If isnull(dsCenOut.GetitemString(i,"CSORT_TIME")) Then
		// Achtung: Zeiten werden gesetzt, return_date wird gesetzt
		of_create_sort(i)
	End if

	// Zus$$HEX1$$e400$$ENDHEX$$tzliche Pr$$HEX1$$fc00$$ENDHEX$$fung Lokale Abflugzeit gegen Abflugzeit
	//
	// R$$HEX1$$fc00$$ENDHEX$$ck- und Weiterfl$$HEX1$$fc00$$ENDHEX$$ge, deren lokale Abflugszeit kleiner ist als die
	// Abflugzeit liegen vermutlich nicht am selben Tag...
	//
	// Beispiel: Departure 22:30, Local 07:00 => wegen Nightstop bekommt dieses
	//					Leg Fr$$HEX1$$fc00$$ENDHEX$$hst$$HEX1$$fc00$$ENDHEX$$ck und befindet sich am Folgetag!
	//
	// 16.11.05 Check Zeiten auch wenn CSORT_TIME nicht null ist
	// 19.09.06 Wenn Returndate einmal versp$$HEX1$$e400$$ENDHEX$$tet wurde, dann muss das f$$HEX1$$fc00$$ENDHEX$$r alle 
	//				folgenden Legs so ein
	if lCurrentLegNumber = 1 then
		dtNewReturnFlightDate = dsCenOut.GetitemDateTime(i,"dreturn_date")
	end if
	
	if lCurrentLegNumber > 1 then
		dtReturnFlightDate 	= dsCenOut.GetitemDateTime(i,"dreturn_date")	// = R$$HEX1$$fc00$$ENDHEX$$ckflug-Datum
		sLocalDepartureTime	= dsCenOut.GetitemString(i,"coriginal_time")	// = lokale Abflugzeit
		lChangedResultKey	= dsCenOut.GetitemNumber(i,"nresult_key")
	end if
Next

dsCenOut.setfilter("")
dsCenOut.filter()

of_trace("of_validation", 10,"Rows in dsCenOut after Step 3: "+string(dsCenOut.rowcount()))

// --------------------------------------------------------------------------------------------------------------------
// 21.06.2012 HR: Citypair nur noch f$$HEX1$$fc00$$ENDHEX$$r Standardgenerierung (CFS schon oben)
// --------------------------------------------------------------------------------------------------------------------
if not bCFSAirline then
	// --------------------------------------------------------------------------------
	// 25.06.2009 HR: nun das Ganze noch f$$HEX1$$fc00$$ENDHEX$$r CityPair
	// --------------------------------------------------------------------------------
	dsCenOut.setfilter("nrouting_group_key=0")
	dsCenOut.filter()
	
	dsCenOut.setsort("nrouting_group_key_cp,  nleg_number")

	dsCenOut.Sort()
	if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"ds_cen_out_validation_4_"+string(now(),"hhmmss")+".xls", excel5!, true)
	
	lRoutingPlanGroupKey = -1
	lRoutingPlanGroupKey_CP = -1
	
	For i = 1 to dsCenOut.Rowcount() 
		lRoutingPlanGroupKey = dsCenOut.GetitemNumber(i,"nrouting_group_key")
		
		// 03.06.2009 HR: Merken des Citypair-Keys f$$HEX1$$fc00$$ENDHEX$$r die of_create_sort -Funktion
		lRoutingPlanGroupKey_CP 	= dsCenOut.GetitemNumber(i,"nrouting_group_key_cp")
			
		sFirstLegTime					= dsCenOut.GetitemString(i,"cdeparture_time")
		sFirstLegRampTime			= dsCenOut.GetitemString(i,"cramp_time")
		sFirstLegKitchenTime 			= dsCenOut.GetitemString(i,"ckitchen_time")
		lFirstLegTLC_From	 			= dsCenOut.GetitemNumber(i,"ntlc_from")
		lFlightNumber					= dsCenOut.GetitemNumber(i,"nflight_number")
		dtFirstLegDeparture			= dsCenOut.GetitemDateTime(i,"dDeparture")
		lCurrentLegNumber			= dsCenOut.GetitemNumber(i,"nleg_number")
		sSuffix 							= dsCenOut.GetitemString(i,"csuffix")
		If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
		sTLCFrom 						= dsCenOut.GetitemString(i,"ctlc_from")
	
		If isnull(dsCenOut.GetitemString(i,"CSORT_TIME")) Then
			// Achtung: Zeiten werden gesetzt, return_date wird gesetzt
			of_create_sort(i)
		End if
	
		// Zus$$HEX1$$e400$$ENDHEX$$tzliche Pr$$HEX1$$fc00$$ENDHEX$$fung Lokale Abflugzeit gegen Abflugzeit
		//
		// R$$HEX1$$fc00$$ENDHEX$$ck- und Weiterfl$$HEX1$$fc00$$ENDHEX$$ge, deren lokale Abflugszeit kleiner ist als die
		// Abflugzeit liegen vermutlich nicht am selben Tag...
		//
		// Beispiel: Departure 22:30, Local 07:00 => wegen Nightstop bekommt dieses
		//					Leg Fr$$HEX1$$fc00$$ENDHEX$$hst$$HEX1$$fc00$$ENDHEX$$ck und befindet sich am Folgetag!
		//
		// 16.11.05 Check Zeiten auch wenn CSORT_TIME nicht null ist
		// 19.09.06 Wenn Returndate einmal versp$$HEX1$$e400$$ENDHEX$$tet wurde, dann muss das f$$HEX1$$fc00$$ENDHEX$$r alle 
		//				folgenden Legs so ein
		if lCurrentLegNumber = 1 then
			dtNewReturnFlightDate = dsCenOut.GetitemDateTime(i,"dreturn_date")
		end if
	
		if lCurrentLegNumber > 1 then
			dtReturnFlightDate 	= dsCenOut.GetitemDateTime(i,"dreturn_date")	// = R$$HEX1$$fc00$$ENDHEX$$ckflug-Datum
			sLocalDepartureTime	= dsCenOut.GetitemString(i,"coriginal_time")	// = lokale Abflugzeit
			lChangedResultKey	= dsCenOut.GetitemNumber(i,"nresult_key")
		end if
	Next
	
	dsCenOut.setfilter("")
	dsCenOut.filter()
end if
of_trace("of_validation", 10,"Rows in dsCenOut after Step 4: "+string(dsCenOut.rowcount()))

dsCenOut.setsort("nrouting_group_key,  nleg_number")
dsCenOut.Sort()

if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"ds_cen_out_validation_5_"+string(now(),"hhmmss")+".xls", excel5!, true)

//-------------------------------------------------------------------------------------
// 17.11.05 Ende: Diese Aktionen fanden vorher in of_update statt!
//-------------------------------------------------------------------------------------

return 0

end function

public function integer of_generate_dispo_compare ();//==============================================================================================
//
// of_generate_dispo_compare
//
// F$$HEX1$$fc00$$ENDHEX$$r den Vergleich der Materialdisposition zu unterschiedlichen Zeitpunkten
// muss die Tabelle cen_out_dispo bzw. cen_out_dispo_detail gef$$HEX1$$fc00$$ENDHEX$$llt werden.
//
// Einmal je Verkehrstag und Betrieb ausf$$HEX1$$fc00$$ENDHEX$$hren!
//
// Mehrmaliger Aufruf an verschiedenen Tagen m$$HEX1$$f600$$ENDHEX$$glich!
//
//==============================================================================================
integer	iReckoning[]
integer	idispo_id
long		i, lRow
long		lSequence, lMasterSequence
integer	iFreqKey
datetime	dtTimestamp
datetime	dtNow

iReckoning = {0,1,2,3,4}
idispo_id = 0

dtNow = datetime(today(),now())

//
// Pr$$HEX1$$fc00$$ENDHEX$$fe, ob Matdispo f$$HEX1$$fc00$$ENDHEX$$r diesen Tag schon gelaufen ist in cen_out_dispo
//
dsCenOutDispo.Retrieve(sClient,sUnit,datetime(dGenerationDate))
for i = 1 to dsCenOutDispo.RowCount()
	dtTimestamp = dsCenOutDispo.GetItemDateTime(i,"dtimestamp")
	if date(dtTimestamp) = date(dtNow) then
		//
		// Dieser Job war heute schon dran
		//
		return -1
	end if
	idispo_id = dsCenOutDispo.GetItemNumber(i,"ndispo_id")
next

//
// ndispo_id ermitteln; hochz$$HEX1$$e400$$ENDHEX$$hlen bis max. 8
//
idispo_id++ 
if idispo_id > 8 then idispo_id = 8

lRow = dsCenOutDispo.InsertRow(0)
if lRow > 0 then
	lMasterSequence = f_Sequence ("seq_cen_out_dispo",sqlca)
	If lMasterSequence = -1 Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't get a new sequence : seq_cen_out_dispo.")
		return -1
	End if
	dsCenOutDispo.SetItem(lRow,"nmaster_key",	lMasterSequence)
	dsCenOutDispo.SetItem(lRow,"cclient",		sClient)
	dsCenOutDispo.SetItem(lRow,"cunit",			sUnit)
	dsCenOutDispo.SetItem(lRow,"ddeparture",	dGenerationDate)
	dsCenOutDispo.SetItem(lRow,"ndispo_id",	1)
	dsCenOutDispo.SetItem(lRow,"dtimestamp",	dtNow)
	
end if

//
// Kompletter Matdispo-Retrieve
//
dsFlightsForUnit.Retrieve(sClient,sUnit,datetime(dGenerationDate))
if dsFlightsForUnit.RowCount() > 0 then
	if of_build_arrays(dsFlightsForUnit,"nresult_key") >= 0 then
		dsExplosion.Retrieve(lResultKeys1, lResultKeys2, lResultKeys3, lResultKeys4, lResultKeys5, iReckoning[], &
									0, 2147483647, 0, 2147483647)
		iFreqKey = 0
		//
		// Transfer in neue Datenstruktur
		//
		for i = 1 to dsExplosion.RowCount()
			lSequence = f_Sequence ("seq_cen_out_dispo_detail",sqlca)
			If lSequence = -1 Then
				of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't get a new sequence : seq_cen_out_dispo_detail.")
				return -1
			End if
			
			lRow = dsCenOutDispoDetail.InsertRow(0)
			
			dsCenOutDispoDetail.SetItem(lRow,"ndetail_key",		lSequence)
			dsCenOutDispoDetail.SetItem(lRow,"nmaster_key",		lMasterSequence)
			dsCenOutDispoDetail.SetItem(lRow,"npl_type",			dsExplosion.GetItemNumber(i,"npl_type"))
			dsCenOutDispoDetail.SetItem(lRow,"npl_index_key",	dsExplosion.GetItemNumber(i,"npl_index_key"))
			dsCenOutDispoDetail.SetItem(lRow,"npl_detail_key",	dsExplosion.GetItemNumber(i,"npl_detail_key"))
			dsCenOutDispoDetail.SetItem(lRow,"nfreq_key",		iFreqKey)
			dsCenOutDispoDetail.SetItem(lRow,"cpackinglist",	dsExplosion.GetItemString(i,"cpackinglist"))
			dsCenOutDispoDetail.SetItem(lRow,"ctext",				dsExplosion.GetItemString(i,"ctext"))
			dsCenOutDispoDetail.SetItem(lRow,"cunit",				dsExplosion.GetItemString(i,"cunit"))
			dsCenOutDispoDetail.SetItem(lRow,"nquantity1",		dsExplosion.GetItemNumber(i,"compute_quantity"))
			dsCenOutDispoDetail.SetItem(lRow,"nquantity_final",0)
			
		next
		
		//
		// Speichern in cen_out_dispo, cen_out_dispo_detail
		//
		
	end if
end if	


return 0

end function

public function integer of_build_arrays (datastore odw, string scolumn);long lRow

For lRow = 1 to oDW.RowCount()
	
	if Upperbound(lResultKeys1) < 1000 then 
		lResultKeys1[Upperbound(lResultKeys1) + 1] = oDw.GetItemNumber(lRow, sColumn)
		continue
		
	elseif Upperbound(lResultKeys2) < 1000 then
		lResultKeys2[Upperbound(lResultKeys2) + 1] = oDw.GetItemNumber(lRow, sColumn)
		continue
		
	elseif Upperbound(lResultKeys3) < 1000 then
		lResultKeys3[Upperbound(lResultKeys3) + 1] = oDw.GetItemNumber(lRow, sColumn)
		continue
		
	elseif Upperbound(lResultKeys4) < 1000 then
		lResultKeys4[Upperbound(lResultKeys4) + 1] = oDw.GetItemNumber(lRow, sColumn)
		continue
		
	elseif Upperbound(lResultKeys5) < 1000 then
		lResultKeys5[Upperbound(lResultKeys5) + 1] = oDw.GetItemNumber(lRow, sColumn)
		continue
		
	else
		return -1	
		
	end if
		
	
Next
		
if Upperbound(lResultKeys1) = 0 then lResultKeys1[1] = -1
if Upperbound(lResultKeys2) = 0 then lResultKeys2[1] = -1
if Upperbound(lResultKeys3) = 0 then lResultKeys3[1] = -1
if Upperbound(lResultKeys4) = 0 then lResultKeys4[1] = -1
if Upperbound(lResultKeys5) = 0 then lResultKeys5[1] = -1

return 0

end function

public function boolean of_check_actyp ();// ---------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$ft ob das Flugger$$HEX1$$e400$$ENDHEX$$t generiert werden soll
// ---------------------------------------------------
	long 		lScheduleRow
	string 	sSearch

	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
	
	If Len(Trim(sSuffix)) = 0 Then
		sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
					 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto)
	Else
		sSearch = "nflight_number = " + string(lFlightnumber) + " and ntlc_from = " + &
					 string(lTLCFrom) + " and ntlc_to = " + string(lTLCto) + &
					 " and csuffix = '" + sSuffix + "'"
	End if	
	
	lScheduleRow = dsGenerateSchedule.find(sSearch,1,dsGenerateSchedule.Rowcount())

	If lScheduleRow > 0 Then
		lAircraftKey	= dsGenerateSchedule.GetitemNumber(lschedulerow,"naircraft_key")
		sSearch 			= "naircraft_key = " + string(lAircraftKey)
		If dsGenerateNonACType.find(sSearch,1,dsGenerateNonACType.Rowcount()) > 0 Then
			return False
		Else
			return True
		End if	
	Else
		return False
	End if
	
	
end function

public subroutine of_save_protocol ();	long		lSQLCode
	long		lSQLRow 
	String	sSQLErrorText	
// -----------------------------------
// Protokol speichern
// -----------------------------------
	If dsGenerateProtocol.update() = 1 Then
		commit using sqlca;	
	else	
		lSQLCode 		= dsGenerateProtocol.lSQLErrorDBCode
		lSQLRow  		= dsGenerateProtocol.lSQLErrorRow
		sSQLErrorText	= dsGenerateProtocol.sSQLErrorText
		f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
						sunit + "~tCan't save job error protocol to database, " + &
						"sqlcode : " + string(lSQLCode) + "~n" + sSQLErrorText,sTraceFile + "-" + this.sInstanceName + ".log")						
	End if
	GarbageCollect()
	dsGenerateProtocol.Reset()
	Return
end subroutine

public function integer of_log_joblist (long lrow, datetime dtrun);// -------------------------------------------------
// 22.11.2006
// Eine Zeile der Jobliste ins Protokoll schreiben
// -------------------------------------------------
String ls_Out

ls_Out = "[" + string(lRow, "000") + "] - "

if dsJobs2Generate.Getitemnumber(lRow,"njob_kind")=2 then
   ls_Out +=    "Einmalereignis " + " - "
end if

ls_Out += this.of_checknull(dsJobs2Generate.Getitemstring(lRow,"cairline")) + " - " 
ls_Out += this.of_checknull(dsJobs2Generate.Getitemstring(lRow,"ctext")) + char(9)
ls_Out += this.of_checknull(dsJobs2Generate.Getitemstring(lRow,"cclient")) + char(9)
ls_Out += this.of_checknull(dsJobs2Generate.Getitemstring(lRow,"cunit")) + char(9)
ls_Out += this.of_checknull(String(dsJobs2Generate.GetitemNumber(lRow,"ndays_offset"))) + char(9)
ls_Out += String(dtRun) + char(9)
ls_Out += this.of_checknull(dsJobs2Generate.Getitemstring(lRow,"cinstance")) + char(9)

this.of_trace("of_log_joblist", 99, ls_Out)

return 0

end function

public function string of_checknull (string stext);

if isnull(sText) then return ""

return sText
end function

public function integer of_write_service_log (string text);integer	iServiceLogFile

	iServiceLogFile	= FileOpen(sServiceLogFile, LineMode!, Write!, LockWrite!, Replace!)
	
	FileWrite(iServiceLogFile, text)
	
	FileClose(iServiceLogFile)

return 0

end function

public function integer of_update_from_cache ();date			dUpdate7Date
string			sBox_From,sBox_To,sShortText,sLongText	
long			lKey, lACOwnerKey
integer		iTest, iReturn
String 		sFind
Long			lFound

// --------------------------------------------
// Rampenboxen im Cache suchen
// --------------------------------------------
If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '

sFind  = "nairline_key=" + string(lAirlineKey) + " and "
sFind  += "nflight_number=" + string(lFlightNumber) + " and "
sFind  += "csuffix='" + sSuffix + "' and "
sFind  += "ctlc_from='" + sTLCFrom + "'"

lFound = dsCenOutCache.Find(sFind, 1, dsCenOutCache.RowCount())

if lFound > 0 then

	sBoxFrom				= dsCenOutCache.GetItemString(lFound, "cbox_from")
	sBoxTo					= dsCenOutCache.GetItemString(lFound, "cbox_to")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 15.02.2012 HR: Bei JobParameter 6 sollen die Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeit
	//                           auch $$HEX1$$fc00$$ENDHEX$$bernommen werden
	// --------------------------------------------------------------------------------------------------------------------
	if iJobParameter = 6 then    
		ls_old_ramp_time		= dsCenOutCache.GetItemString(lFound, "cramp_time")
		ls_old_kitchen_time	= dsCenOutCache.GetItemString(lFound, "ckitchen_time")
	end if
	
else
	
	sBoxFrom				= ""
	sBoxTo					= ""
	iReturn 					= -1
end if

if isnull(sBoxFrom) then sBoxFrom = ""
if isnull(sBoxTo) 	then sBoxTo = ""

// --------------------------------------------------------------------------------------------------------------------
// 20.01.2012 HR: Wenn nur die aktuellen Rampenboxen oder aktuelle 
//                           Rampenboxen mit Zeiten $$HEX1$$fc00$$ENDHEX$$bernommen werden soll,
//					   dann raus hier
// --------------------------------------------------------------------------------------------------------------------
if iJobParameter = 5 or iJobParameter = 6 then
	return iReturn
end if

// Messagebox("", sBoxFrom + "-" + sBoxFrom  + "~r~r" + sFind + "~r~rstring(lFound) = " + string(lFound) + "~r~rdsCenOutCache.RowCount() = " + String(dsCenOutCache.RowCount()))

// ---------------------------------------------------
// 7 Tage zur$$HEX1$$fc00$$ENDHEX$$ck f$$HEX1$$fc00$$ENDHEX$$r die Abfertigungsarten
// ---------------------------------------------------
dUpdate7Date	= Relativedate(dGenerationDate,-7)	
sRemarkText	= ""
iStatusUpdate7	= 0

SELECT nhandling_type_key,  
		 chandling_type_text,
		 chandling_type_description
  INTO :lKey, 
		 :sShortText,
		 :sLongText
		 
  FROM cen_out  
WHERE  nairline_key 			= :lAirlineKey  AND  
		 nflight_number 		= :lFlightNumber  AND  
		 csuffix 					= :sSuffix  AND 
		 cunit	 					= :sUnit  AND 
		 ctlc_from				= :sTLCFrom AND
		 cen_out.ddeparture	= :dUpdate7Date;

If sqlca.sqlcode = 0 then
	
		lHandlingTypeKey 		= lKey
		sHandlingShortText	= sShortText
		sHandlingLongText	= sLongText
		
	
Elseif sqlca.sqlcode = 100 then
	
	If iJobParameter = 2 Then
		iStatusUpdate7				= 0
	Else
		// -----------------------------------------------
		// Anzeige im Flugbrowser : Kein Update Tag 7
		// -----------------------------------------------
		iStatusUpdate7				= 2
	End if

	if sUnit = sLoadingUnit then
		iReturn = -2	// war 0
	end if
	
Else

	If iJobParameter = 2 Then
		iStatusUpdate7				= 0
	Else
		iStatusUpdate7				= 2
	End if	

	if sUnit = sLoadingUnit then
		iReturn = -2
	end if
End if



return iReturn

end function

public function string of_get_job_name (long lrow);
// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_job_name (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long lrow
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  ??	   		1.0      	??   Erstellung
// 20.01.2012 HR: Neuer Parameter 'aktuelle Rampenboxen'
// --------------------------------------------------------------------------------------------------------------------
String 	sReturn
Long 		lType
// 10 Tagesflugplan Neuanlage 			pro Betrieb
// 20 Tagesflugplan Update 				pro Betrieb
// 30 Tagesflugplan Delete 				pro Betrieb
// 40 Matdispo Neuanlage	 				pro Betrieb
// 50 Matdispo Update		 				pro Betrieb
// 60 Tagesflugplan Overwrite 			pro Betrieb
// 70 Non Flight Business Neuanlage 	pro Betrieb
// 80 Non Flight Business Update	 		pro Betrieb
// 90 Non Flight Business Delete	 		pro Betrieb
// 100 Non Flight Business Matdispo		pro Betrieb
// 110 Zentrale Matdispo 					pro Mandant (!)	Auskommentiert am 29.01.2004
// 120 $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen l$$HEX1$$f600$$ENDHEX$$schen	pro Betrieb
// 130 History l$$HEX1$$f600$$ENDHEX$$schen						pro Betrieb
//	140 PPS Daten l$$HEX1$$f600$$ENDHEX$$schen
// 150 PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen
// 160 PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen
// 170 Asynchrone Generierung (Tagesflugplan + Matdispo $$HEX1$$fc00$$ENDHEX$$ber OnlineExplosion)

sReturn  = "[" + of_checknull(dsJobs2Generate.Getitemstring(lRow,"cunit")) + "] - "
sReturn += "[" + of_checknull(dsJobs2Generate.Getitemstring(lRow,"cairline")) + "] - "

// 29.10.2010 HR:
if ii_generate_jobtype=2 then
   sReturn +=    "Einmalereignis " + " - "
end if

lType 	 		= dsJobs2Generate.Getitemnumber(lRow,"njob_type")
Choose Case lType
	Case 10
		sReturn += 	"Tagesflugplan Neuanlage      " + " - " 	
	Case 20
		sReturn += 	"Tagesflugplan Update         " + " - " 	
	Case 30
		sReturn += 	"Tagesflugplan Delete         " + " - " 	
	Case 40
		sReturn += 	"Matdispo Neuanlage           " + " - " 	
	Case 50
		sReturn += 	"Matdispo Update              " + " - " 	
	Case 60
		sReturn += 	"Tagesflugplan Overwrite      " + " - " 	
	Case 70
		sReturn += 	"Non Flight Business Neuanlage" + " - " 	
	Case 80
		sReturn += 	"Non Flight Business Update   " + " - " 	
	Case 90
		sReturn += 	"Non Flight Business Delete   " + " - " 	
	Case 100
		sReturn += 	"Non Flight Business Matdispo " + " - " 	
	Case 110
		sReturn += 	"Zentrale Matdispo            " + " - " 	
	Case 120
		sReturn += 	"$$HEX1$$c400$$ENDHEX$$nderungsmitteilungen l$$HEX1$$f600$$ENDHEX$$schen" + " - " 	
	Case 130
		sReturn += 	"History l$$HEX1$$f600$$ENDHEX$$schen              " + " - " 	
	Case 140
		sReturn += 	"PPS Daten l$$HEX1$$f600$$ENDHEX$$schen            " + " - " 
	Case 150
		sReturn += 	"PPS Alarme l$$HEX1$$f600$$ENDHEX$$schen           " + " - "
	Case 160
		sReturn += 	"PPS $$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen       " + " - "
	Case 170
		sReturn += 	"Asynchrone Generierung  " + " - "
	Case else
		// 02.08.2010 HR: Auch bei NULL-Value mit ausgeben
		sReturn += 	"Unknown JobType " + of_checknull(string(lType)) + " - " 	
end choose

sReturn += "[" + of_checknull(String(dsJobs2Generate.GetitemNumber(lRow,"ndays_offset"), "00")) + "] - "


lType 	 		= dsJobs2Generate.Getitemnumber(lRow,"npax_type")

// 13.10.2015 HR: ausgelagert
sReturn 		+= of_get_job_paxtype(lType)+ " - " 	

/*
Choose Case lType
	Case 1
		sReturn += 	"zentrale Auslastung  " 
	Case 2
		sReturn += 	"lokale Auslastung    " + " - " 	
	Case 3
		sReturn += 	"aktuelle Passagiere  " + " - " 	
	Case 4
		sReturn += 	"betriebliche Prognose" + " - " 	
	case 5
		sReturn += 	"gebuchte Passagiere (CITP)" + " - " 	
	case 6
		sReturn += 	"gebuchte Passagiere + PAD (CITP)" + " - " 	
	case 7
		sReturn += 	"erwartetet Passagiere (CITP)" + " - " 	
	case 8
		sReturn += 	"erwartetet Passagiere + PAD (CITP)" + " - " 	
	case 9
		sReturn += 	"lokale Anpassungen" + " - " 	
	Case else
		// 02.08.2010 HR: Auch bei NULL-Value mit ausgeben
		sReturn += 	"Unknown PaxType " + of_checknull(string(lType))  + " - " 	
End Choose
*/
lType 	 		= dsJobs2Generate.Getitemnumber(lRow,"nparameter")
Choose Case lType
	Case 0
		sReturn += 	"none " 
	Case 1
		sReturn += 	"Rampenboxen und Abfertigung" 
	Case 2
		sReturn += 	"Rampenboxen  "
	Case 3
		sReturn += 	"Abfertigung" 
	Case 4
		sReturn += 	"aktuelle Rampenboxen und Abfertigung" 
	Case 5 // 20.01.2012 HR: Neuer Parameter 'aktuelle Rampenboxen'
		sReturn += 	"aktuelle Rampenboxen" 
	Case 6 // 19.06.2012 HR: Neuer Parameter 'aktuelle Rampenboxen und Zeiten'
		sReturn += 	"aktuelle Rampenboxen und Zeiten" 
	Case else
		// 02.08.2010 HR: Auch bei NULL-Value mit ausgeben
		sReturn += 	"Unknown Parameter " + of_checknull(string(lType))  
End Choose

return sReturn

end function

public function integer of_log (string smessage);integer	iTraceFile


iTraceFile	= FileOpen(sTraceFile + "-Admin.log", LineMode!, Write!, LockWrite!, Append!)
FileWrite(iTraceFile, String(Today(),"dd.mm.yyyy")+"|"+String(Now(),"hh:mm:ss")+"|" + sMessage)
FileClose(iTraceFile)


return 0

end function

public function boolean of_delete_pps_data ();/* Function: of_delete_pps_data ---------------------------------
*
* Beschreibung : L$$HEX1$$f600$$ENDHEX$$schen der PPS Bewegungsdaten 
*					  Job ID 140  
*
* Besonderheit : 
*
* Aenderungshistorie
* Wer                        Wann        Was und warum
* Klaus F$$HEX1$$f600$$ENDHEX$$rster			31.10.2007			Erstellung
*
*	Return Codes:
*	true	OK
*  false	Fehler
* -------------------------------------------------------------------
*/
long		lSQLCode
long		lSQLRow 
long		i
string	sSQLErrorText
long		lCounter

// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if

lTimeStart = cpu()

// -----------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$rs Protokoll, die Anzahl der zu l$$HEX1$$f600$$ENDHEX$$schenden Fl$$HEX1$$fc00$$ENDHEX$$ge ermitteln
// -----------------------------------------------------------------
select count(*)
  into :lCounter
  from cen_pps_catering_order
  where ddeparture = :dGenerationDate and 
				cunit  = :sunit and
				cairline = (select air.CAIRLINE from cen_airlines air where air.NAIRLINE_KEY = :lAirlineKey);

lJobActions = lCounter

// -----------------------------------------------------------------
// PPS-Prod Lot l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------	
/*
UPDATE cen_pps_prod_order po1
SET po1.NPROD_LOT_KEY = Null
where po1.NPROD_ORDER_KEY in (SELECT DISTINCT(po.NPROD_ORDER_KEY) 
	  	  FROM cen_pps_prod_order po, cen_pps_catering_order co
		  WHERE po.NCO_KEY = co.NCO_KEY and 
		  co.ddeparture 		= :dGenerationDate and 
		  co.cunit		  		= :sunit and
		  co.cairline = (select air.CAIRLINE from cen_airlines air where air.NAIRLINE_KEY = :lAirlineKey));

DELETE FROM cen_pps_prod_lot pl 
		WHERE pl.NPROD_LOT_KEY in (SELECT sub1.NPROD_LOT_KEY from
	  (SELECT pl1.NPROD_LOT_KEY, count(po.NPROD_ORDER_KEY) anzahl from cen_pps_prod_lot pl1, cen_pps_prod_order po, cen_pps_catering_order co
	  WHERE pl1.NPROD_LOT_KEY = po.NPROD_LOT_KEY and
	  po.NCO_KEY = co.NCO_KEY and 
	  co.ddeparture 		= :dGenerationDate and 
	  co.cunit		  		= :sunit and
	  co.cairline = (select air.CAIRLINE from cen_airlines air where air.NAIRLINE_KEY = :lAirlineKey)
	  GROUP BY pl1.NPROD_LOT_KEY) sub1
	  WHERE sub1.anzahl > 0);
*/

//HR 02.07.2008 L$$HEX1$$f600$$ENDHEX$$schen der Loe auf Zeitraum ge$$HEX1$$e400$$ENDHEX$$ndert;

UPDATE cen_pps_prod_order po1
	 SET po1.NPROD_LOT_KEY = Null
  where po1.NPROD_ORDER_KEY in (  SELECT cen_pps_prod_order.nprod_order_key  
				   								 FROM cen_pps_prod_lot,   
										 		           cen_pps_prod_order  
											   	WHERE ( cen_pps_prod_order.nprod_lot_key = cen_pps_prod_lot.nprod_lot_key ) and  
													       ( ( to_date(cen_pps_prod_lot.dprod_lot_plan_end) <= :dGenerationDate ) AND  
         													( cen_pps_prod_lot.nprod_lot_key > 0 ) ));

DELETE FROM cen_pps_prod_lot
		WHERE to_date(DPROD_LOT_PLAN_END) < :dGenerationDate and
					NPROD_LOT_KEY > 0;


If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't delete prod lot, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-Mahlzeitenverteilung l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_meal_layout 
where ncontainer_key in 
  (
  select ncontainer_key from cen_pps_container 
  		where nco_key in
		  (
		  select nco_key from cen_pps_catering_order 
		     where ddeparture 		= :dGenerationDate and 
					  cunit		  		= :sunit and
					  cairline 			= :sAirline	
		  )
  		
  );

If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS meal distribution, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-Container l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_container 
where nco_key in 
				(
				select nco_key from cen_pps_catering_order 
		     	  where ddeparture 		= :dGenerationDate and 
					    cunit		  		= :sunit and
					    cairline 			= :sAirline	
				);
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS - Container, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-Prod.Order l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_prod_order 
where nco_key in 
				(
				select nco_key from cen_pps_catering_order 
		     	  where ddeparture 		= :dGenerationDate and 
					    cunit		  		= :sunit and
					    cairline 			= :sAirline	
				);
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS - Prod.-Orders, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-FlightSlot l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_flight_slot
where nco_key in 
				(
				select nco_key from cen_pps_catering_order 
		     	  where ddeparture 		= :dGenerationDate and 
					    cunit		  		= :sunit and
					    cairline 			= :sAirline	
				);
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS -FlightSlot, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-CO-Handlings l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_co_handlings 
where nco_key in 
				(
				select nco_key from cen_pps_catering_order 
		     	  where ddeparture 		= :dGenerationDate and 
					    cunit		  		= :sunit and
					    cairline 			= :sAirline	
				);
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS - CO-Handlings, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -----------------------------------------------------------------
// PPS-CO-Loading l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_co_loading 
where nco_key in 
				(
				select nco_key from cen_pps_catering_order 
		     	  where ddeparture 		= :dGenerationDate and 
					    cunit		  		= :sunit and
					    cairline 			= :sAirline	
				);
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS - CO-Loading, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if


// -----------------------------------------------------------------
// PPS-Flug l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------		
Delete from cen_pps_catering_order
where ddeparture 		= :dGenerationDate and 
		cunit		  		= :sunit and
		cairline 			= :sAirline;
  		
If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete PPS - Catering Order, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + &
							" seconds. PPS Flights: " + String(lCounter)) 
	commit using sqlca;
	return True
End if

return true

end function

public function boolean of_delete_pps_alarms ();/* Function: of_delete_pps_alarms -----------------------------------
*
* Beschreibung : L$$HEX1$$f600$$ENDHEX$$schen der PPS Alarmmeldungen 
*					  Job ID 150  
*
* Besonderheit : 
*
* Aenderungshistorie
* Wer                      Wann        	Was und warum
* Dirk Bunk						28.11.2007		Erstellung
*
*	Return Codes:
*	true	OK
*  false	Fehler
* -------------------------------------------------------------------
*/

long		lCounter

// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if

lTimeStart = cpu()

// -----------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$rs Protokoll, die Anzahl der zu l$$HEX1$$f600$$ENDHEX$$schenden Alarme ermitteln
// -----------------------------------------------------------------
select count(*)
  into :lCounter
  from cen_pps_object_alarm_map
  where to_date(dalarm_set) <= :dGenerationDate and 
							cunit  = :sunit;

lJobActions = lCounter

// -----------------------------------------------------------------
// PPS-Alarme l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------	
DELETE FROM cen_pps_object_alarm_map 
		WHERE to_date(dalarm_set) <= :dGenerationDate and 
					 		  	 cunit  = :sunit;

If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't delete PPS alarms, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo," ",string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + &
							" seconds. PPS alarms: " + String(lCounter)) 
	commit using sqlca;
	return True
End if

return true

end function

public function boolean of_delete_pps_changes ();/* Function: of_delete_pps_changes -----------------------------------
*
* Beschreibung : L$$HEX1$$f600$$ENDHEX$$schen der PPS $$HEX1$$c400$$ENDHEX$$nderungen 
*					  Job ID 160  
*
* Besonderheit : 
*
* Aenderungshistorie
* Wer                      Wann        	Was und warum
* Dirk Bunk						28.11.2007		Erstellung
*
*	Return Codes:
*	true	OK
*  false	Fehler
* -------------------------------------------------------------------
*/

long		lCounter

//
// -----------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Job schon gelaufen ist ?
// -----------------------------------------------------------------
If of_job_executed() Then
	return False
End if

lTimeStart = cpu()

// -----------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$rs Protokoll, die Anzahl der zu l$$HEX1$$f600$$ENDHEX$$schenden $$HEX1$$c400$$ENDHEX$$nderungen ermitteln
// -----------------------------------------------------------------
select count(*)
  into :lCounter
  from loc_pps_object_changes
  where to_date(dchange_set) <= :dGenerationDate and 
							 cunit  = :sunit;

lJobActions = lCounter

// -----------------------------------------------------------------
// PPS-$$HEX1$$c400$$ENDHEX$$nderungen l$$HEX1$$f600$$ENDHEX$$schen
// -----------------------------------------------------------------	
DELETE FROM loc_pps_object_changes 
		WHERE to_date(dchange_set) <= :dGenerationDate and 
					 		  	  cunit  = :sunit;

If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't delete PPS changes, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
else
	of_trace("of_delete_pps_changes", 1,"Delete " + string( sqlca.sqlnrows) + " rows from loc_pps_object_changes <= " + string(dGenerationDate)+" and Unit "+sunit)
end if

// 12.12.2008 HR: L$$HEX1$$f600$$ENDHEX$$schen der Event-Maps und Object-State-Maps eingebaut (LSY_1245)
delete from cen_pps_object_event_map 
	   where to_date(devent_set) <= :dGenerationDate;

If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't delete PPS Object Event Maps, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
else
	of_trace("of_delete_pps_changes", 1,"Delete " + string( sqlca.sqlnrows) + " rows from cen_pps_object_event_map <= " + string(dGenerationDate))
end if
		
delete from cen_pps_object_state_map 
		where to_date(dstate_set) <= :dGenerationDate;

If sqlca.sqlcode <> 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't delete PPS Object State Maps, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
else
	of_trace("of_delete_pps_changes", 1,"Delete " + string( sqlca.sqlnrows) + " rows from cen_pps_object_state_map <= " + string(dGenerationDate))
end if

// -------------------------------------
// Commit des Jobs
// -------------------------------------
lTimeEnd = cpu()
If not of_write_Job_history() Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler," ",string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
	rollback using sqlca;
	return False
Else
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo," ",string(dGenerationDate,s_app.sDateformat),"Successfully deleted in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + &
							" seconds. PPS changes: " + String(lCounter)) 
	commit using sqlca;
	return True
End if

return true

end function

public function boolean of_generate_flights_by_fre ();//=====================================================================================
// 12.06.08, KF -  Ge$$HEX1$$e400$$ENDHEX$$nderte Version von Frank Renner
//=====================================================================================
//
// of_generate_flights
//
// Erster wichtiger Schritt zur Fluggenerierung: 
// Die Fl$$HEX1$$fc00$$ENDHEX$$ge werden aus der Beladedefinition und dem Flugplan erstellt.
//
//=====================================================================================
long 		i
integer		iVerkehrsTag
string  		sFrequenz
long 			lRow,lFound
long			lFindDefault
Long			ll_flightNrOld = 0
Long			ll_tlcFromOld = 0
Long			ll_tlcToOld = 0
Long			ll_flightGroupOld = 0
Long			ll_flightGroup
Boolean		bGenerateFlight
iVerkehrsTag 	= f_getfrequence(dGenerationDate)
sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"
integer		iTest
long			lKey, j, k
boolean		bDeleteLegs
long			lCurrentGroupKey
string		sFilter
long			nRoutingDetailKey
long			ll_planRows
long			ll_handlingRows

// ------------------------------------------------------------------
// Alle Datastores resetten ! (Umzug am 28.02.2005)
// -------------------------------------------------------------------	
dsCenOut.Reset()
dsCenOutHandling.Reset()
dsCenOutHandlingNews.Reset()
dsCenOutPax.Reset()
dsCenOutQAQ.Reset()
dsCenOutNewsExtra.Reset()
dsCharterMemory.Reset()

// -----------------------------------------
// Retrieve und Filter Flugplan
// -----------------------------------------
Long ll_r
ll_r = dsGenerateSchedule.Retrieve(lScheduleKey,DateTime(dGenerationDate))
dsGenerateSchedule.SetFilter(sFrequenz)
dsGenerateSchedule.Filter()
ll_r = dsGenerateSchedule.RowCount()
// -----------------------------------------
// Retrieve und Filter Routingplan
// -----------------------------------------
ll_planrows = dsGenerateRoutingPlan.Retrieve(lRoutingPlanKey, sUnit, dGenerationDate)// 14.05.2010 HR: UNIT und Generierungsdatum eingebaut
dsGenerateRoutingPlan.SetFilter(sFrequenz)
dsGenerateRoutingPlan.Filter()
ll_planRows = dsGenerateRoutingPlan.RowCount()
// f_print_datastore(dsGenerateRoutingPlan)

If dsGenerateSchedule.rowcount() <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Flight Schedule.")
	of_trace("of_generate_flights_by_fre", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(ll_planRows))
	return False
End if

If ll_planRows <= 0 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Loading Definition.")
	of_trace("of_generate_flights_by_fre", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(ll_planRows))
	return False
End if

// -----------------------------------------------------------------
// 26.04.2007, KF
// Einige Informationen aus cen_out cachen (sofern der Tag schonmal 
// generiert wurde)
// -----------------------------------------------------------------		
dsCenOutCache.Retrieve(lAirlineKey, dGenerationDate, sclient, sunit)
of_trace("of_generate_flights_by_fre", 1,"cached " + string( dsCenOutCache.RowCount()) + " flights for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey))

// -----------------------------------------------------------------
// Neu, erstmal alles l$$HEX1$$f600$$ENDHEX$$schen !
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht.
// -----------------------------------------------------------------		
DELETE FROM cen_out 
		WHERE dgeneration_date 	= :dGenerationDate and 
				cclient	  			= :sclient and
				cunit		  			= :sunit and
				nairline_key 		= :lAirlineKey;
				
If sqlca.sqlcode <> 0 then
	of_trace("of_generate_flights_by_fre", 1,"delete from cen_out - error " + 	string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext)
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule, sqlcode " + string(sqlca.sqlcode) + ".")
	rollback using sqlca;
	return False
end if

// -------------------------------------------------------------------------
// der Routingplan ist der Taktgeber, es werden alle Betriebe retrieved !!!!
// zuerst die Flugnummern und dann die City Pair Beladung.
// -------------------------------------------------------------------------
ll_flightGroup = -1

// ------------------------
// Message an Window
// ------------------------
If bSendMessage Then
	sPostMessage = "Execute job flights, for unit: " + sUnit + " Airline: " + sAirline + " Job ID: " + string(iJob_Type)
	w_cbase_generate_dialog.triggerevent("ue_redraw")
	yield()	
End if

of_trace("of_generate_flights_by_fre", 50,"lRoutingPlanKey=" + string(lRoutingPlanKey) )
dsGenerateRoutingPlan.SetSort("nsort A nrouting_group_key A nleg_number A")
dsGenerateRoutingPlan.Sort()

// -----------------------------------------
// FRE 15.05.2008_ Retrieve Routingplan-Handling
// -----------------------------------------
//ll_r = dsGenerateRoutingPlanHandling.Retrieve(sUnit)

For I = 1 To dsGenerateRoutingPlan.RowCount()
	
	ll_flightNrOld = lFlightNumber
	ll_tlcFromOld = lTLCFrom
	ll_tlcToOld = lTLCTo
	ll_flightGroupOld = ll_flightGroup
	
	dReturnFlightDate = dGenerationDate		// R$$HEX1$$fc00$$ENDHEX$$cksetzen ReturnFlightDate
	lFlightNumber 	= dsGenerateRoutingPlan.Getitemnumber(i,"nflight_number")
	/*Debug
	If lFlightNumber = 401 Or lFlightNumber = 400 Then
		i = i
	End If
	*/
	sTLCFrom			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc")
	sTLCTo			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc_1")
	lTLCFrom			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_from")
	lTLCTo			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_to")		
	sSuffix			= dsGenerateRoutingPlan.Getitemstring(i,"csuffix")
	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
	lFlightLegs 	= dsGenerateRoutingPlan.Getitemnumber(i,"compute_legs")
	lLegNumber		= dsGenerateRoutingPlan.Getitemnumber(i,"nleg_number")
	ll_flightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
	//FRE spielt hier noch keine Rolle
	//sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	//sLoadingUnit	= sUnit
	nRoutingDetailKey = dsGenerateRoutingPlan.GetitemNumber(i,"nroutingdetail_key")
	
	// -----------------------------------------
	// FRE 15.05.2008_ Retrieve Routingplan-Handling
	// -----------------------------------------
	sFilter = ""
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	ll_handlingrows = dsGenerateRoutingPlanHandling.Retrieve(nRoutingDetailKey)

	// -----------------------------------------
	// FRE 15.05.2008 Filter Routingplan-Handling auf Detail-Key
	// -----------------------------------------
	/*sFilter = ""
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	sFilter = 'nroutingdetail_key=' + String(nRoutingDetailKey)
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	ll_handlingRows = dsGenerateRoutingPlanHandling.RowCount()
	*/
	
	// 13.10.2006 Falls gleiche Flugnummer als Default auftaucht, dann auf
	// Generierung verzichten
	If Len(Trim(sSuffix)) > 0 Then
		lFindDefault = dsGenerateRoutingPlan.Find("nflight_number = " + string(lFlightNumber) + " and ndefault = 1 and csuffix = '" + sSuffix + "'" &
							,1, ll_planRows)
	Else
		lFindDefault = dsGenerateRoutingPlan.Find("nflight_number = " + string(lFlightNumber) + " and ndefault = 1" &
							,1, ll_planRows)
	End If
	
	if lFindDefault > 0 then

		if lFindDefault <> i then	continue
		
	end if
	
	lCurrentGroupKey = dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
	of_trace("of_generate_flights_by_fre", 50,"processing flight " + string(lFlightNumber) + ", nrouting_group_key = " + string(lCurrentGroupKey))
	
	// ---------------------------------------------------------------------
	// Haben wir eine neue Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen. (Hin, Weiter oder R$$HEX1$$fc00$$ENDHEX$$ckflug)
	// FRE: 03.06.2008:
	// Die Gruppe ist jetzt nicht mehr das einzige Kriterium f$$HEX1$$fc00$$ENDHEX$$r die Generierung.
	// Ein weiteres Kriterium ist die Kombination Flugnummer-TLCFrom-TLCTo
	// ---------------------------------------------------------------------		
	//If dsGenerateRoutingPlan.GetitemNumber(i,"nrouting_group_key") <> lFlightGroup Then
	If (ll_flightGroup <> ll_flightGroupOld) Or &
		(lFlightNumber <> ll_flightNrOld Or lTLCFrom <> ll_tlcFromOld Or lTLCTo <> ll_tlcToOld) Then
		
		If ll_flightGroup <> ll_flightGroupOld Then
			of_trace("of_generate_flights_by_fre", 50, "Group Change for nrouting_group_key = " + String(ll_flightGroupOld) )
		Else
			of_trace("of_generate_flights_by_fre", 50, 	"Flight Change for nflight_number = " + String(ll_flightNrOld) + &
								", ntlc_from = " + String(lTLCFrom) + ", ntlc_to = " + String(ll_tlcToOld))
		End If
		//lFlightGroup	= dsGenerateRoutingPlan.Getitemnumber(i,"nrouting_group_key")
		
		// ---------------------------------------------------------------------
		// Ok, nun pr$$HEX1$$fc00$$ENDHEX$$fen wir ob in dieser Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen der Generierungs
		// Betrieb vorkommt.
		// ---------------------------------------------------------------------
		/* FRE 15.05.2008: Pr$$HEX1$$fc00$$ENDHEX$$fung $$HEX1$$fc00$$ENDHEX$$ber die Gruppe kann entfallen, da $$HEX1$$fc00$$ENDHEX$$ber die gelesenen Handlings 
		                   gegangen wird (dsGenerateRoutingPlanHandling)

		lFound = dsGenerateRoutingPlan.Find("nrouting_group_key = " + &
					string(lFlightGroup) + " and cunit = '" + sUnit + "'",&
					i,dsGenerateRoutingPlan.Rowcount())

		*/

		// ---------------------------------------------------------------------
		// 09.09.2005
		// Sch$$HEX1$$e400$$ENDHEX$$rfere $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung, falls es sich um eine Charter-Airline handelt:
		// Nur wenn alle Leg-Angaben 1:1 mit der Beladedefinition $$HEX1$$fc00$$ENDHEX$$bereinstimmt
		// wird der Flug generiert.
		// ---------------------------------------------------------------------
		if bCharter then
			//
			// Gruppe hat gewechselt:
			// Sind die Legs der letzten Gruppe vollst$$HEX1$$e400$$ENDHEX$$ndig?
			//
			if dsCharterMemory.RowCount() > 0 then
				dsCenOut.SetFilter("")
				dsCenOut.Filter()
				of_trace("of_generate_flights_by_fre", 50,"dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
								+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
				bDeleteLegs = false

				//
				// Kontrolle: dsCharterMemory des vorherigen Flugs gegen dsCenOut
				// und l$$HEX1$$f600$$ENDHEX$$sche Fl$$HEX1$$fc00$$ENDHEX$$ge, die nicht 1:1 der Beladedefinition entsprechen
				//
				
				sFilter = "nrouting_group_key = " + string(lKey)
				dsCenOut.SetFilter(sFilter)
				dsCenOut.Filter()
				of_trace("of_generate_flights_by_fre", 50,"Filter = " + sFilter + " => dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
								+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
				//
				// Weicht Anzahl Legs ab?
				//
				if dsCenOut.RowCount() <> dsCharterMemory.RowCount() then
					of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true because of Rowcount" )
					bDeleteLegs = true
				end if
				
				for j = 1 to dsCenOut.RowCount() 

					for k = 1 to dsCharterMemory.RowCount()

						if dsCenOut.GetItemNumber(j,"nleg_number") = dsCharterMemory.GetItemNumber(k,"nleg_number") then
							//
							// K.O.-Check: Routing muss gleich der Vorgabe aus Beladedefinition sein!
							//
							if dsCenOut.GetItemNumber(j,"ntlc_from") <> dsCharterMemory.GetItemNumber(k,"ntlc_from") or &
								dsCenOut.GetItemNumber(j,"ntlc_to") <> dsCharterMemory.GetItemNumber(k,"ntlc_to") then
								of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true because Leg " + string(dsCenOut.GetItemNumber(j,"nleg_number")) + "  " + string(dsCenOut.GetItemNumber(j,"ntlc_from")) + " <> " + &
										string(dsCharterMemory.GetItemNumber(k,"ntlc_from")) + " or " + string(dsCenOut.GetItemNumber(j,"ntlc_to")) + " <> " + &
										string(dsCharterMemory.GetItemNumber(k,"ntlc_to")) )
								of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true (1)" )
								bDeleteLegs = true
							end if
							
						end if
						
					next
					
				next
				
				if bDeleteLegs then
					of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs set nrouting_group_key=" + string(lKey) )
				end if

				for j = dsCenOut.RowCount() to 1 step -1
					
					if bDeleteLegs then	dsCenOut.DeleteRow(j)

				next

				dsCenOut.SetFilter("")
				dsCenOut.Filter()
			end if
			
			//
			// dsCharterMemory speichert Ist-Zustand des Fluges aus der Beladedefinition
			// Nur wenn der sp$$HEX1$$e400$$ENDHEX$$ter generierte Flug exakt dieser Vorgabe entspricht, wird
			// er nach cen_out gespeichert.
			//
			dsCharterMemory.Retrieve(lRoutingPlanKey, ll_flightGroup)
			//
			// Flight Group f$$HEX1$$fc00$$ENDHEX$$r die Kontrolle nach dem Gruppenwechsel merken
			//
			lKey = ll_flightGroup
		end if
		
		// ---------------------------------------------------------------------
		// Ok, der Generierungsbetrieb kommt vor, ist der Flug mit dem 
		// dem ersten Eintrag des Generierungsbetriebes mit dem aktuellen
		// Generierungstag im Flugplan? Falls nicht brauchen wir die ganze
		// Gruppe von Fl$$HEX1$$fc00$$ENDHEX$$gen nicht.
		// ---------------------------------------------------------------------

		If ll_handlingRows > 0 Then
			
			// -----------------------------------------
			// FRE 15.05.2008 Zur Pr$$HEX1$$fc00$$ENDHEX$$fung auf zu generierende Unit Filter von Routingplan-Handling auf Unit
			// -----------------------------------------
			sFilter = ""
			dsGenerateRoutingPlanHandling.SetFilter(sFilter)
			dsGenerateRoutingPlanHandling.Filter()
			sFilter = "cunit='" + sUnit + "'"
			dsGenerateRoutingPlanHandling.SetFilter(sFilter)
			dsGenerateRoutingPlanHandling.Filter()
			ll_handlingRows = dsGenerateRoutingPlanHandling.RowCount()
			If ll_handlingRows > 0 Then
				sLoadingUnit = sUnit
			Else
				sLoadingUnit = ''
			End If

			//FRE: Argument der Funktion of_check_flightnumber wird dort nicht verwendet
			If lFlightNumber > 0 Then
				
				If of_check_flightnumber(1) > 0 Then
					bGenerateFlight = True
				Else
					bGenerateFlight = False
				End If
				
			Else
				bGenerateFlight = True
			End if	
			
			// -----------------------------------------------------------------
			// Pr$$HEX1$$fc00$$ENDHEX$$fung ob das Flugger$$HEX1$$e400$$ENDHEX$$t generiert werden soll
			// -----------------------------------------------------------------
			If bGenerateFlight Then
				
				If Not of_check_actyp() Then bGenerateFlight = False

			End if
			
		Else
			bGenerateFlight = False
		End if	
		
	End if
	
	If lFlightnumber <> -1 And bGenerateFlight Then
		// -------------------------------------------------------------------------
		// Kein City Pair und innerhalb der Gruppe kommt der Generierungsbetrieb vor.
		// -------------------------------------------------------------------------
		//sLoadingUnit = sUnit
		of_search_flightnumber(i)
	End if
	
Next

//
// Nicht vergessen, letzte Gruppe erf$$HEX1$$e400$$ENDHEX$$hrt keinen Wechsel mehr innerhalb der Schleife
//
if bCharter then
	//
	// Gruppe hat gewechselt:
	// Sind die Legs der letzten Gruppe vollst$$HEX1$$e400$$ENDHEX$$ndig?
	//
	if dsCharterMemory.RowCount() > 0 then
		of_trace("of_generate_flights_by_fre", 50,"final dsCharterMemory.RowCount()=" + string(dsCharterMemory.rowcount()) &
						+ " dsCenOut.RowCount()=" + string(dsCenOut.rowcount()))
		bDeleteLegs = false
		//
		// Kontrolle: dsCharterMemory des vorherigen Flugs gegen dsCenOut
		// und l$$HEX1$$f600$$ENDHEX$$sche Fl$$HEX1$$fc00$$ENDHEX$$ge, die nicht 1:1 der Beladedefinition entsprechen
		//
		dsCenOut.SetFilter("nrouting_group_key = " + string(lKey))
		dsCenOut.Filter()
		//
		// Weicht Anzahl Legs ab?
		//
		if dsCenOut.RowCount() <> dsCharterMemory.RowCount() then
			of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true because of Rowcount" )
			bDeleteLegs = true
		end if
		
		for j = 1 to dsCenOut.RowCount() 
			
			for k = 1 to dsCharterMemory.RowCount()
				
				if dsCenOut.GetItemNumber(j,"nleg_number") = dsCharterMemory.GetItemNumber(k,"nleg_number") then
					//
					// K.O.-Check: Routing muss gleich der Vorgabe aus Beladedefinition sein!
					//
					if dsCenOut.GetItemNumber(j,"ntlc_from") <> dsCharterMemory.GetItemNumber(k,"ntlc_from") or &
						dsCenOut.GetItemNumber(j,"ntlc_to") <> dsCharterMemory.GetItemNumber(k,"ntlc_to") then
						of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true because Leg " + string(dsCenOut.GetItemNumber(j,"nleg_number")) + "  " + string(dsCenOut.GetItemNumber(j,"ntlc_from")) + " <> " + &
								string(dsCharterMemory.GetItemNumber(k,"ntlc_from")) + " or " + string(dsCenOut.GetItemNumber(j,"ntlc_to")) + " <> " + &
								string(dsCharterMemory.GetItemNumber(k,"ntlc_to")) )
						of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs = true (2)" )
						bDeleteLegs = true
					end if
					
				end if
				
			next
			
		next
		
		if bDeleteLegs then
			of_trace("of_generate_flights_by_fre", 50,"bDeleteLegs set nrouting_group_key=" + string(lKey) )
		end if
		
		for j = dsCenOut.RowCount() to 1 step -1
			
			if bDeleteLegs then
				dsCenOut.DeleteRow(j)
			end if
			
		next
		
		dsCenOut.SetFilter("")
		dsCenOut.Filter()
	end if
	
end if

// -------------------------------------------------------------------------
// und jetzt die City Pair Beladung.
// -------------------------------------------------------------------------	
For I = 1 to ll_planRows
	lFlightNumber 	= dsGenerateRoutingPlan.Getitemnumber(i,"nflight_number")
	sTLCFrom			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc")
	sTLCTo			= dsGenerateRoutingPlan.Getitemstring(i,"sys_three_letter_codes_ctlc_1")
	lTLCFrom			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_from")
	lTLCTo			= dsGenerateRoutingPlan.Getitemnumber(i,"ntlc_to")		
	sSuffix			= dsGenerateRoutingPlan.Getitemstring(i,"csuffix")
	If IsNull(sSuffix) Or Len(Trim(sSuffix)) = 0 Then sSuffix = ' '
	lFlightLegs 	= dsGenerateRoutingPlan.Getitemnumber(i,"compute_legs")
	lLegNumber		= dsGenerateRoutingPlan.Getitemnumber(i,"nleg_number")
	nRoutingDetailKey = dsGenerateRoutingPlan.GetitemNumber(i,"nroutingdetail_key")
	
	// -----------------------------------------
	// FRE 15.05.2008_ Retrieve Routingplan-Handling
	// -----------------------------------------
	sFilter = ""
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	ll_handlingRows = dsGenerateRoutingPlanHandling.Retrieve(nRoutingDetailKey)

	// -----------------------------------------
	// FRE 15.05.2008 Filter Routingplan-Handling auf Detail-Key
	// -----------------------------------------
	/*sFilter = ""
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	sFilter = 'nroutingdetail_key=' + String(nRoutingDetailKey)
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	ll_handlingRows = dsGenerateRoutingPlanHandling.RowCount()
	*/
	
	// -----------------------------------------
	// FRE 15.05.2008 Zur Pr$$HEX1$$fc00$$ENDHEX$$fung auf zu generierende Unit Filter von Routingplan-Handling auf Unit
	// -----------------------------------------
	sFilter = ""
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	sFilter = "cunit='" + sUnit + "'"
	dsGenerateRoutingPlanHandling.SetFilter(sFilter)
	dsGenerateRoutingPlanHandling.Filter()
	ll_handlingRows = dsGenerateRoutingPlanHandling.RowCount()
	If ll_handlingRows > 0 Then
		sLoadingUnit = sUnit
	Else
		sLoadingUnit = ''
	End If

	//FRE: Unit aus Routing-Plan spielt keine Rolle mehr. Diese kommt aus dem Routing-Plan-Handling
	//sLoadingUnit	= dsGenerateRoutingPlan.Getitemstring(i,"cunit")
	
	// ---------------------------------------------------------------------
	// Bei City Pair nur die Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r die aktuelle Unit !
	// ---------------------------------------------------------------------
	If lFlightnumber = -1  Then
		//FRE 04.06.2008: Wir haben jetzt nur noch Rows mit dem richtigen RoutingplanDetail_Key und der richtigen Unit
		//lFound = dsGenerateRoutingPlanHandling.Find("nroutingdetail_key = " + &
		//			String(nRoutingDetailKey), i, ll_planRows)
					
		//If lFound > 0 Then of_search_city_pair(i)
		If ll_handlingrows > 0 Then of_search_city_pair(i)

	End if
	
Next

If bDebugCenOut Then
	// f_print_datastore(dsCenOutDebug)
End if	

//dsCenOut.SaveAs("c:\temp\cbase\cen_out.xls", excel5!, true)

return True

end function

public function integer of_get_costtype ();/* 
* Funktion/Event: of_get_costtype
* Beschreibung: 	Ermitteln der Kostenart und des Steuerkennzeichens f$$HEX1$$fc00$$ENDHEX$$r
						alle ESL's der Mahlzeitenbeladung
* Besonderheit: 	keine
*
* Argumente:
	keine
**
* Aenderungshistorie:
* 	Version 		Wer			Wann			Was und warum
*	1.0 			K.F$$HEX1$$f600$$ENDHEX$$rster	13.06.2008	Erstellung
*
* Return Codes:
*	 1		Alles OK
*/

Long lRow

// Erstmal nur f$$HEX1$$fc00$$ENDHEX$$r den Generierungsdatastore ausf$$HEX1$$fc00$$ENDHEX$$hren
if uo_generate_meals.dsCenOutMeals.dataobject <> "dw_cen_out_meals" then 
	return 1
end if

uo_costtype_tax uoCostTypeTax
uoCostTypeTax = Create uo_costtype_tax

for lRow = 1 to uo_generate_meals.dsCenOutMeals.RowCount()

	uoCostTypeTax.bMopMeal					= True
	uoCostTypeTax.lhandling_detail_key	= uo_generate_meals.dsCenOutMeals.GetItemNumber(lRow, "nhandling_detail_key")
	uoCostTypeTax.sClass						= uo_generate_meals.dsCenOutMeals.GetItemString(lRow, "cclass")
	uoCostTypeTax.sAccount					= uo_generate_meals.dsCenOutMeals.GetItemString(lRow,"cAccount")
	uoCostTypeTax.sUnit 						= this.sUnit	
	uoCostTypeTax.lSupplier 				= f_get_unit_supplier_key(this.sUnit)
	uoCostTypeTax.lPL_Index_Key 			= uo_generate_meals.dsCenOutMeals.GetItemNumber(lRow, "npackinglist_index_key")
	uoCostTypeTax.lPL_Detail_Key  		= f_get_packinglist_detail_key(uoCostTypeTax.lPL_Index_Key, dGenerationDate) 
	
	uoCostTypeTax.sPackinglist 			= uo_generate_meals.dsCenOutMeals.GetItemString(lRow, "cpackinglist")
	uoCostTypeTax.ilanguage 				= s_app.ilanguage		
	uoCostTypeTax.lCustomer 				= this.lAirlineKey 					
	uoCostTypeTax.dtDate						= DateTime(dGenerationDate)
	
	uoCostTypeTax.of_cost_type()
	uoCostTypeTax.of_taxcode()
	
	uo_generate_meals.dsCenOutMeals.SetItem(lRow, "ncosttype", uoCostTypeTax.lCostType_Key)
	uo_generate_meals.dsCenOutMeals.SetItem(lRow, "ctaxcode",uoCostTypeTax.sTaxCode_Short)

next

Destroy(uoCostTypeTax)

return 0
end function

public subroutine of_reorg_legs ();/* 
* Funktion/Event: of_reorg_legs
* Beschreibung: 	Durchnummerierung der Legs mit 1 beginnend und $$HEX1$$dc00$$ENDHEX$$bernahme der Zeiten (Abflug, Rampe, K$$HEX1$$fc00$$ENDHEX$$che) auf die weiterf$$HEX1$$fc00$$ENDHEX$$hrenden Legs
* Besonderheit: 	keine
*
**
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			H.Rothenbach	26.08.2008	Erstellung
*
*/

long ll_grp_key
long ll_grp_row
integer li_grp_leg
integer i
string ls_zeit

ll_grp_key = -1

//Daten nach Fluggruppen und Legnummer sortieren
dsCenOut.setsort("nresult_key_group, nleg_number")
dsCenOut.sort()

for i=1 to dsCenOut.rowcount()
	
	//Gruppenwechsel?
	if ll_grp_key <> dsCenOut.getitemnumber(i,"nresult_key_group") then
		
		//Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel und Zeilennummer merken
		ll_grp_key = dsCenOut.getitemnumber(i,"nresult_key_group")
		ll_grp_row = i

		//Legnummer auf 1 setzen
		/* HR 09.09.2008: Wegen  Problemen mit der SSL im Flugbrowser wurde die Legnummerierung ausgeschaltet
		li_grp_leg = 1
		dsCenOut.setitem(i,"nleg_number",li_grp_leg) */
	else
		//Legnummer erh$$HEX1$$f600$$ENDHEX$$hen und setzen
		/* HR 09.09.2008: Wegen  Problemen mit der SSL im Flugbrowser wurde die Legnummerierung ausgeschaltet
		li_grp_leg ++
		dsCenOut.setitem(i,"nleg_number",li_grp_leg) */
		
		//Abflugzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "cdeparture_time")
		dsCenOut.setitem(i,"cdeparture_time", ls_zeit)
		dsCenOut.SetItem(i,"CSORT_TIME",ls_zeit) // 15.11.2010 HR: Auch hier die Abflugszeit des 1. LEGS eintragen
		
		//Rampenzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "cramp_time")
		dsCenOut.setitem(i,"cramp_time", ls_zeit)
		
		//K$$HEX1$$fc00$$ENDHEX$$chenzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "ckitchen_time")
		dsCenOut.setitem(i,"ckitchen_time", ls_zeit)
	end if
next

//Sortierung wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
dsCenOut.setsort("nrouting_group_key, nleg_number")
dsCenOut.sort()

end subroutine

public function integer of_write_flights ();// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_write_flights (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: none
// --------------------------------------------------------------------------------
//  Beschreibung: Es werden zur Pr$$HEX1$$fc00$$ENDHEX$$fung der neuen Generierung eine 
//                       Datei mit den generierten Fl$$HEX1$$fc00$$ENDHEX$$gen erzeugt.
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version    Autor                     Kommentar
// --------------------------------------------------------------------------------
//  08.01.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

string ls_checkflights, ls_checkflights_path
long ll_sumflightnumbers, i

//Lese, ob Pr$$HEX1$$fc00$$ENDHEX$$fdatei erstellt werden soll
ls_checkflights = ProfileString(s_App.sProfile, "CBASE_Service", "CheckFlights","0")
SetProfileString(s_App.sProfile, "CBASE_Service", "CheckFlights",ls_checkflights)

//Lese, wohin die Datei gespeichert werden soll
ls_checkflights_path = ProfileString(s_App.sProfile, "CBASE_Service", "CheckFlightsPath","C:\TEMP\")
if right(ls_checkflights_path,1)<>"\" then ls_checkflights_path += "\"
SetProfileString(s_App.sProfile, "CBASE_Service", "CheckFlightsPath",ls_checkflights_path)

//Falls nicht, raus hier
if ls_checkflights="0" then return 0

if dsCenOut.rowcount()=0 then
	of_trace("of_write_flights", 1,"No Rows in dsCenOut")
	return 0
end if

//Dateiname zusammenstellen
ls_checkflights = dsCenOut.getitemstring(1,"cunit")+"-"
ls_checkflights += left(trim(dsCenOut.getitemstring(1,"cairline"))+"____",3)+"-"
ls_checkflights += string(dsCenOut.getitemdatetime(1,"ddeparture"),"yyyy-mm-dd")+"-"
ls_checkflights += string(dsCenOut.rowcount(),"000")+"-"

ll_sumflightnumbers = 0

for i=1 to dsCenOut.rowcount()
	ll_sumflightnumbers += dsCenOut.getitemnumber(i,"nflight_number")
next

ls_checkflights += string(ll_sumflightnumbers)+".XLS"

//Datastore speichern
i = dsCenOut.saveas(ls_checkflights_path+ls_checkflights, excel5!, true)
if i=1 then
	of_trace("of_write_flights", 1,"File "+ls_checkflights_path+ls_checkflights+" created")
else
	of_trace("of_write_flights", 1,"Error creating File "+ls_checkflights_path+ls_checkflights)
end if

return 1
end function

public function string of_get_configuration (long arg_aircraftkey);// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_configuration (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// long arg_aircraftkey
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  23.04.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

string	sReturn
integer li_maxclass
datastore lds_ac
long		i,j
long		lStart = 1

select max(nclass_number) 
  into :li_maxclass
  from cen_class_name
 where cen_class_name.nairline_key = :lAirlineKey
	and cen_class_name.nbooking_class = 1;
	
if sqlca.sqlcode <> 0 then
	return " "
end if

lds_ac = create datastore
lds_ac.dataobject="dw_aircraft_configuration"
lds_ac.settransobject(SQLCA)

lds_ac.retrieve(arg_aircraftkey)

for i = 1 to lds_ac.rowcount()
	for j = lStart to li_maxclass
		if lds_ac.getitemnumber(i,"nclass_number") <> j then
			sReturn += "000-"
			continue
		else
			sReturn += string( lds_ac.getitemnumber(i,"nversion"),"000") + "-"
			lStart = lds_ac.getitemnumber(i,"nclass_number") + 1
			exit
		end if
	next
next	

destroy lds_ac

sReturn = mid(sReturn,1,len(sReturn) -1)

return sReturn
end function

public function boolean of_get_opcode (long al_airline);
//=================================================================================================
//
// of_get_opcode
//
// Holt den Default OP Code zur Airline
//
//=================================================================================================
string	sText


select nopcode_key, copcode
  into :lOPCode_Key, :sOpcode
  from cen_airline_opcodes
 where nairline_key = :al_airline
 and		ndefault=1;
 
if sqlca.sqlcode <> 0 then
	SetNULL(lOPCode_Key)
	SetNULL(sOpcode)
	return False
else
	return true
end if

end function

public function integer of_generate_qp ();// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_qp (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Generierte die Zeitstempel zu denen eine QP zu einem 
//					   Flug ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden muss
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  23.06.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

datastore 	lds_aqp
long 			i, j, lrow, lnew
datetime 	ldt_abflug, ldt_runat
long 			ll_resultkey, ll_offset, ll_qpkey
string 		ls_CFLIGHT_KEY
long 			lfound, llresultOld

if dsCenOut.rowcount()=0 then return 1

lds_aqp = create datastore
lds_aqp.dataobject="dw_generate_airline_qp"
lds_aqp.SetTransObject (SQLCA)

lnew = 0

lds_aqp.retrieve(lAirlineKey)

if lds_aqp.rowcount()=0 then 
	destroy lds_aqp
	return 1
end if

for i=1 to dsCenOut.rowcount()
	ll_resultkey = dsCenOut.getitemnumber(i,"nresult_key")
	
	// Flugschl$$HEX1$$fc00$$ENDHEX$$ssel - Aufbau  TagAlcFlgnrSufVonNach
	// 28.10.2013 HR: ddeparture durch dreturn_date ersetzt, da Fl$$HEX1$$fc00$$ENDHEX$$ge ex Deutschland anderes Ddeparture haben
	ls_CFLIGHT_KEY = String(dsCenOut.GetItemdatetime(i,"dreturn_date"), "YYMMDD") + dsCenOut.GetItemString(i,"cairline") + String(dsCenOut.GetItemNumber(i,"nflight_number"), "0000")
	
	If IsNULL(dsCenOut.GetItemString(i,"csuffix")) Then
		ls_CFLIGHT_KEY += " "
	Else
		ls_CFLIGHT_KEY += dsCenOut.GetItemString(i,"csuffix")
	End If
	
	ls_CFLIGHT_KEY += dsCenOut.GetItemString(i,"ctlc_from") + dsCenOut.GetItemString(i,"ctlc_to")

	//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Flug schon generiert war und es einen alten Key f$$HEX1$$fc00$$ENDHEX$$r den Flug gibt.
	// 09.06.2015 HR: Pr$$HEX1$$fc00$$ENDHEX$$fung erweitert auf schon verwendet
	lfound=dsResultkeys.find("nqp = 0 and csearch = '"+ls_CFLIGHT_KEY+"'",1,dsResultkeys.rowcount())
	if lfound>0 then
		 llresultOld=dsResultkeys.getitemnumber(lfound,"nresult_key")	
		 
		 dsResultkeys.setitem(lfound,"nqp", 1) // 09.06.2015 HR: Wir setzen den Key auf schon verwendet
		 
		 // --------------------------------------------------------------------------------------------------------------------
		 // 29.01.2015 HR: Hat sich der RESULT_KEY ge$$HEX1$$e400$$ENDHEX$$ndert, dann $$HEX1$$e400$$ENDHEX$$ndern wir auch die QPs
		 // --------------------------------------------------------------------------------------------------------------------
		 if llresultOld <> ll_resultkey then
			dsCenOutQP.setfilter("nresult_key = "+string(llresultOld))
			dsCenOutQP.filter()
			
			for j = 1 to dsCenOutQP.rowcount()
				dsCenOutQP.setitem(j,"nresult_key",ll_resultkey)
			next
			of_trace("of_generate_qp", 10,"Change  "+string(dsCenOutQP.rowcount())+" Rows from RESULT_KEY  "+string(llresultOld)+" to "+string(ll_resultkey))

			dsCenOutQP.setfilter("")
			dsCenOutQP.filter()
		 end	if
		 
//		 //Pr$$HEX1$$fc00$$ENDHEX$$fen, ob es schon QP-Eintr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r den Flug mit dem alten Key gibt, dann brauchen diese nicht neu angelegt werden
//		 select count(*) into :lrow from cen_out_qp where nresult_key = :llresultOld;
//		 
//		 if sqlca.sqlcode=0 then
//			if lrow>0 then continue
//		end if
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 20.11.2009 HR: Es muss mit der UTC-Zeit gerechnet werden, da Localzeit sonst mit Local-FRA verglichen wird
	// 15.03.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r Manuelle Aufnahme wird UTC nicht geplegt.
	// 03.02.2016 HR: Als Zeitpunkt sollen die Zeiten vom 1. Leg genommen werden
	// --------------------------------------------------------------------------------------------------------------------
	lrow = dsCenOut.find("nresult_key = "+string(dsCenOut.getitemnumber(i, "nresult_key_group"))+" and nleg_number = 1", 1, dsCenOut.rowcount())
	if lrow <1 then lrow= i //Wenn nicht gefunden, dann bleiben wir bei der Zeile
	
	if isnull(dsCenOut.getitemdatetime(lrow,"ddeparture_time_utc")) then
		ldt_abflug = datetime(date(dsCenOut.getitemdatetime(lrow,"doriginal_departure")),time(dsCenOut.getitemstring(lrow,"coriginal_time")))
	else
		ldt_abflug = dsCenOut.getitemdatetime(lrow,"ddeparture_time_utc")
	end if
	
	//QP-Eintr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r jeden Flug vornehmen
	for j = 1 to   lds_aqp.rowcount()
		ll_qpkey 	= lds_aqp.getitemnumber(j,"nairline_qp_key")
		ll_offset	= -60 * lds_aqp.getitemnumber(j,"noffset")
		ldt_runat = f_dt_add(ldt_abflug, ll_offset)
		
		lrow = dsCenOutQP.find("nresult_key = " + string(ll_resultkey) + " and nairline_qp_key = " + string(ll_qpkey), 1, dsCenOutQP.rowcount() )

		if lrow=0 then
			lrow= dsCenOutQP.insertrow(0)
			dsCenOutQP.setitem(lrow,"nresult_key",			ll_resultkey)
			dsCenOutQP.setitem(lrow,"nairline_qp_key",	ll_qpkey)
			lnew ++
		end if
		 
		dsCenOutQP.setitem(lrow,"drun_at", 					ldt_runat)
	next
next

of_trace("of_generate_qp", 0,string(lds_aqp.rowcount()) + " QP-Rows for Airline "+string(lAirlineKey)+" - Rows in Cen_out: "+string(dsCenOut.rowcount())+" - Rows in CenOutQP: "+string(dsCenOutQP.rowcount())+" - New: "+string(lnew))

destroy lds_aqp
garbagecollect() // 20.06.2012 HR:

return 1

end function

protected function boolean of_get_handling_lcl (long pl_nresult_key, long pl_umm_key, ref string ps_message);DateTime	ldt_ddeparture					
Long			ll_nairline_owner_key 		
Long  			ll_nrouting_id
Long			ll_nhandling_key
Long			ll_nhandling_key_del
Long 			ll_ncustomer_key
Long 			ll_nhandling_id
String 		ls_ctext
Long 			ll_naccount_key
Integer 		li_nclass_number
Long			ll_rownum
Long			ll_newrow
Boolean		lbo_exit
Boolean		lbo_found

// Cursor f$$HEX1$$fc00$$ENDHEX$$r LCL-Handling gem$$HEX3$$e400df002000$$ENDHEX$$Mirror Stammdaten
DECLARE	  GetHandling CURSOR FOR  

SELECT  UMH_NHANDLING_KEY 					,
			CEN_HANDLING.NCUSTOMER_KEY		,
			CEN_HANDLING.NHANDLING_ID			,
			CEN_HANDLING.CTEXT					,
			CEN_HANDLING.NACCOUNT_KEY		,
			CEN_HANDLING.NCLASS_NUMBER

FROM		CEN_UNIT_MIRROR_DETAIL

JOIN		CEN_UNIT_MIRROR_HANDLING
ON			CEN_UNIT_MIRROR_HANDLING	.UMH_UMD_NKEY 				=	CEN_UNIT_MIRROR_DETAIL.UMD_NKEY

JOIN		CEN_HANDLING
ON			CEN_HANDLING.NHANDLING_KEY 									=	CEN_UNIT_MIRROR_HANDLING.UMH_NHANDLING_KEY

WHERE	CEN_UNIT_MIRROR_DETAIL.UMD_UMM_NKEY 					=	:pl_umm_key													AND
           	CEN_UNIT_MIRROR_DETAIL.UMD_NAIRLINE_KEY_OWNER  	=	:ll_nairline_owner_key										AND
           	CEN_UNIT_MIRROR_DETAIL.UMD_NROUTING_ID               	=	:ll_nrouting_id													AND

			:ldt_ddeparture                                   				  BETWEEN	CEN_UNIT_MIRROR_DETAIL.UMD_DVALID_FROM 		AND 
																							CEN_UNIT_MIRROR_DETAIL.UMD_DVALID_TO 			AND
			:ldt_ddeparture 											  BETWEEN 	CEN_UNIT_MIRROR_HANDLING.UMH_DVALID_FROM 	AND 
																							CEN_UNIT_MIRROR_HANDLING.UMH_DVALID_TO;

// Erst mal noch ein paar Daten des Fluges holen ...
SELECT	DDEPARTURE                 	,
  			NAIRLINE_OWNER_KEY 		,
  			NROUTING_ID        
			  
INTO		:ldt_ddeparture					,
			:ll_nairline_owner_key 		,
  			:ll_nrouting_id

FROM		CEN_OUT

WHERE	CEN_OUT.NRESULT_KEY = :pl_nresult_key;

IF 	sqlca.sqlcode <> 0 THEN
	ps_message = "DB-Error bei SELECT FROM CEN_OUT (2): " + String(sqlca.sqlcode) + " " + sqlca.sqlerrtext 
	RETURN FALSE
END IF

			  
// OPEN Cursor f$$HEX1$$fc00$$ENDHEX$$r LCL-Handling gem$$HEX3$$e400df002000$$ENDHEX$$Mirror Stammdaten
OPEN GetHandling;

IF sqlca.sqlcode = 0 THEN

	DO
		
		lbo_exit = FALSE
		
		// FETCH Cursor f$$HEX1$$fc00$$ENDHEX$$r LCL-Handling gem$$HEX3$$e400df002000$$ENDHEX$$Mirror Stammdaten
		FETCH 	GetHandling
		INTO		:ll_nhandling_key		,
					:ll_ncustomer_key		,
					:ll_nhandling_id		,
					:ls_ctext					,
					:ll_naccount_key		,
					:li_nclass_number		;

		IF 	sqlca.sqlcode = 0 THEN
			
			ll_newrow = dsHandlingObjects_LCL.InsertRow(0) 
			
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nroutingdetail_key",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nhandling_key",ll_nhandling_key)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq1",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq2",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq3",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq4",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq5",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq6",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nfreq7",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"dvalid_from",2000-01-01)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"dvalid_to",3000-01-01)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nroutingplan_handling_key",0)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"ncustomer_key",ll_ncustomer_key)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nhandling_id",ll_nhandling_id)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"ctext",ls_ctext	)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"naccount_key",ll_naccount_key)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"nclass_number",li_nclass_number)
			dsHandlingObjects_LCL.SetItem(ll_newrow,"cen_routingplan_handling_nsort",ll_newrow)
					
		ELSE  // IF sqlca.sqlcode = 0 (Fetch GetHandling)
			lbo_exit = TRUE				
		END IF // IF 	sqlca.sqlcode = 0 (Fetch GetHandling)
		
	LOOP UNTIL lbo_exit // Loop $$HEX1$$fc00$$ENDHEX$$ber GetHandling
	
END IF // IF sqlca.sqlcode = 0 (Open GetHandling)

CLOSE GetHandling;		

RETURN TRUE
end function

public subroutine of_regen_keys ();// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_regen_keys (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: none
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  07.07.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------
long i, lfound
string ls_CFLIGHT_KEY
long llresultNew, llresultOld

if dsCenOut.rowcount()=0 then return

if dsResultkeys.rowcount()=0 then return

for i=1 to dsCenOut.rowcount()
		// Flugschl$$HEX1$$fc00$$ENDHEX$$ssel - Aufbau  TagAlcFlgnrSufVonNach
		// 28.10.2013 HR: ddeparture durch dreturn_date ersetzt, da Fl$$HEX1$$fc00$$ENDHEX$$ge ex Deutschland anderes Ddeparture haben
		ls_CFLIGHT_KEY = String(dsCenOut.GetItemdatetime(i,"dreturn_date"), "YYMMDD") + dsCenOut.GetItemString(i,"cairline") + String(dsCenOut.GetItemNumber(i,"nflight_number"), "0000")
		
		If IsNULL(dsCenOut.GetItemString(i,"csuffix")) Then
			 ls_CFLIGHT_KEY += " "
		Else
			ls_CFLIGHT_KEY += dsCenOut.GetItemString(i,"csuffix")
		End If
		
		ls_CFLIGHT_KEY += dsCenOut.GetItemString(i,"ctlc_from") + dsCenOut.GetItemString(i,"ctlc_to")
	
		// 09.06.2015 HR: Suche erweitert, damit 2 Fl$$HEX1$$fc00$$ENDHEX$$ge nicht den gleichen Key erhalten
		lfound=dsResultkeys.find("nresuse =0 and csearch='"+ls_CFLIGHT_KEY+"'",1,dsResultkeys.rowcount())
		if lfound>0 then
			 llresultNew=dsCenOut.getitemnumber(i,"nresult_key")
			 llresultOld=dsResultkeys.getitemnumber(lfound,"nresult_key")	
			 
			 dsResultkeys.setitem(lfound,"nresuse", 1) // 09.06.2015 HR: Verhindern, dass 2 Fl$$HEX1$$fc00$$ENDHEX$$ge den gleichen Key erhalten
			 			 
			 update cen_request set nresult_key= :llresultNew where nresult_key = :llresultOld;
			 if sqlca.sqlcode<0 then
				of_trace("of_regen_keys", 1,"Error Updating CEN_REQUEST for Flight "+ls_CFLIGHT_KEY+": "+SQLCA.SQLErrText )
			end if
			
// 29.01.2015 HR: Machen wir jetzt schon bei der Generierung
//			 update cen_out_qp set nresult_key= :llresultNew where nresult_key = :llresultOld;
//			 if sqlca.sqlcode<0 then
//				of_trace("of_regen_keys", 1,"Error Updating CEN_OUT_QP for Flight "+ls_CFLIGHT_KEY+": "+SQLCA.SQLErrText )
//			end if

		end if
next
end subroutine

public function boolean of_recalc_pax (long arg_lrow);// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_recalc_pax (Function)
// Autor  : Heiko Rothenbach
//---------------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen an dieser Funktion m$$HEX1$$fc00$$ENDHEX$$ssen auch in den Userobjekten
// - uo_generate.of_recalc_pax
// - uo_generate_ifms.of_recalc_pax
// - w_change_center.wf_recalc_pax
// nachgezogen werden 
// --------------------------------------------------------------------------------
// Argument(e):
// long arg_lrow
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Hier werden die Regeln der Paxanpassungen 
//                       abgearbeitet
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  21.08.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------
datastore 	lds_acsearch, lds_classes
string 		ls_cunit, ls_cairline, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_flgnr, ls_cdeparture_time, ls_offset, ls_kind, ls_cclass, ls_upclass[], ls_filter, ls_version, ls_pax
long			ll_nflight_number, ll_nresult_key, ll_version, ll_naircraft_key, ll_airline_key, ll_pax_old, ll_pax_new, ll_found
integer 		li_overload[], li_upgrade[], li_findversion, li_red_add_delivery[], li_kind, i

li_findversion 			= 0

// --------------------------------------------------------------------------------
//  Pr$$HEX1$$fc00$$ENDHEX$$fen, ob $$HEX1$$fc00$$ENDHEX$$berhaupt angepa$$HEX1$$df00$$ENDHEX$$t werden soll
// --------------------------------------------------------------------------------
//if iUseLoaclAdjustment=0 then return true
if sAdjustmentSet = 'none' then return true // 16.06.2010 HR: CR IMView302

// --------------------------------------------------------------------------------
//Schauen, ob Paxe angepa$$HEX1$$df00$$ENDHEX$$t werden m$$HEX1$$fc00$$ENDHEX$$ssen
// --------------------------------------------------------------------------------
ll_nresult_key 			= dsCenOut.GetItemNumber(arg_lrow,"nresult_key")
ls_cunit 					= dsCenOut.GetItemString(arg_lrow,"cunit")
ls_cairline				= dsCenOut.GetItemString(arg_lrow,"cairline")
ll_nflight_number 		= dsCenOut.GetItemNumber(arg_lrow,"nflight_number")
ls_ctl_from				= dsCenOut.GetItemString(arg_lrow,"ctlc_from")
ls_ctl_to					= dsCenOut.GetItemString(arg_lrow,"ctlc_to")
ls_crouteing				= dsCenOut.GetItemString(arg_lrow,"crouting")
ls_cdeparture_time	= dsCenOut.GetItemString(arg_lrow,"cdeparture_time")
ll_naircraft_key      	= dsCenOut.GetItemNumber(arg_lrow,"naircraft_key")
ll_airline_key		 	= dsCenOut.GetItemNumber(arg_lrow,"nairline_key") // 18.02.2013 HR:

ls_flgnr = ls_cunit + "-"+string(dGenerationDate, "dd.mm.yyyy")+"-"+ls_cairline+" "+string(ll_nflight_number,"0000")+ "-"
ls_flgnr += ls_ctl_from+"-"+ls_ctl_to	+"-"+ls_crouteing +": "

dsLocal_adjustments.setfilter("nfreq"+string(f_getfrequence(dGenerationDate))+"=1")

// 16.06.2010 HR: CR IMView302
dsLocal_adjustments.retrieve(lAirlineKey, ls_cunit, dGenerationDate, ls_cairline, ll_nflight_number, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_cdeparture_time,sAdjustmentSet)

of_trace("of_recalc_pax", 10,ls_flgnr+"Anzahl m$$HEX1$$f600$$ENDHEX$$glicher Regeln f$$HEX1$$fc00$$ENDHEX$$r Set "+sAdjustmentSet+": "+string(dsLocal_adjustments.rowcount()))

if dsLocal_adjustments.rowcount()=0 then 
	dsLocal_adjustments.setfilter("")
	dsLocal_adjustments.filter()
	return true
end if

// --------------------------------------------------------------------------------------------------------------------
// 18.02.2013 HR: DS f$$HEX1$$fc00$$ENDHEX$$r Buchungsklassenermittlung
// --------------------------------------------------------------------------------------------------------------------
lds_classes = create datastore
lds_classes.dataobject="dw_airline_classes"
lds_classes.settransobject(SQLCA)
lds_classes.retrieve(ll_airline_key)

// --------------------------------------------------------------------------------
//Paxe anpassen
// --------------------------------------------------------------------------------
dsCenOutPax.Setfilter("nresult_key = "+string(ll_nresult_key))
dsCenOutPax.filter()

for i=1 to dsCenOutPax.rowcount()
	li_upgrade[i]			= 0
	li_red_add_delivery[i] = 0
	li_overload[i]			= 0
     ls_upclass[i]			= "none"
	ls_cclass 				= dsCenOutPax.getitemstring(i,"cclass")

	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue // 14.02.2013 HR: nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
	
	//Erste Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r die Flugnummer und Klasse einem Eintrag
	ll_found = dsLocal_adjustments.find("nkind = 1 and cclass='"+ls_cclass+"'",1,dsLocal_adjustments.rowcount())
	
	if ll_found=0 then
		//Zweite Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r das Citypair und Klasse einem Eintrag
		ll_found = dsLocal_adjustments.find("nkind = 2 and cclass='"+ls_cclass+"'",1,dsLocal_adjustments.rowcount())

		if ll_found=0 then
			//Dritte Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r das Strecke und Klasse einem Eintrag
			ll_found = dsLocal_adjustments.find("nkind = 3 and cclass='"+ls_cclass+"'",1,dsLocal_adjustments.rowcount())

			if ll_found=0 then 	continue

			li_kind	= 3
			ls_kind	= "Strecke"
		else
			li_kind	= 2
			ls_kind	= "CityPair"
		end if
	else
		li_kind		= 1
		ls_kind		= "Flugnummer"
	end if
	
	//Allgemeine Parameter f$$HEX1$$fc00$$ENDHEX$$r sp$$HEX1$$e400$$ENDHEX$$ter merken
	li_overload[i] = dsLocal_adjustments.getitemnumber(ll_found,"noverload") 
	if dsLocal_adjustments.getitemnumber(ll_found,"nupgrade") >0 then li_upgrade[i] = dsLocal_adjustments.getitemnumber(ll_found,"nupgrade")
	if dsLocal_adjustments.getitemnumber(ll_found,"nfind_version") =1 then li_findversion=1
	if dsLocal_adjustments.getitemnumber(ll_found,"nred_add_delivery") >0 then li_red_add_delivery[i] = dsLocal_adjustments.getitemnumber(ll_found,"nred_add_delivery")
	
	if isnull( dsLocal_adjustments.getitemstring(ll_found,"cclass_upgrade")) or trim( dsLocal_adjustments.getitemstring(ll_found,"cclass_upgrade"))="" then
		ls_upclass[i]="none"
	else
		ls_upclass[i]= dsLocal_adjustments.getitemstring(ll_found,"cclass_upgrade")
	end if
	
	//Paxe anpassen
	ll_pax_old = dsCenOutPax.getitemnumber(i,"npax")
	
	if dsLocal_adjustments.getitemnumber(ll_found,"npercent_pax") = 0 then
		//Paxoffset ist in Prozent
		ll_pax_new 	= ll_pax_old + (ll_pax_old * dsLocal_adjustments.getitemnumber(ll_found,"noffset") / 100) + .5
		ls_offset 		= string( dsLocal_adjustments.getitemnumber(ll_found,"noffset"))+"%"
	else
		//Paxoffset ist Absolut
		ll_pax_new 	= ll_pax_old + dsLocal_adjustments.getitemnumber(ll_found,"noffset")
		ls_offset 		= string( dsLocal_adjustments.getitemnumber(ll_found,"noffset"))
	end if
	
	dsCenOutPax.setitem(i,"npax", ll_pax_new)
	
	of_trace("of_recalc_pax", 6,ls_flgnr+"Paxanpassung Klasse "+ls_cclass+" wegen "+ls_kind +"-Regel : Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_pax_new)+" Offset "+ls_offset)
next

// --------------------------------------------------------------------------------
//Version bestimmen
// --------------------------------------------------------------------------------
if  li_findversion=1 then
	// --------------------------------------------------------------------------------
	// 20.10.2009 HR: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Paxe in Version passen
	// --------------------------------------------------------------------------------
	ls_version 	= ""
	ls_pax 	  	= ""
	ll_found 		= 0

	for i=1 to dsCenOutPax.rowcount()
		// Es werden momentan nur die ersten 3 Klassen ber$$HEX1$$fc00$$ENDHEX$$cksichtigt
		//if i> 3 then continue
		if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue // 14.02.2013 HR: nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
		
		if dsCenOutPax.getitemnumber(i,"nversion") < dsCenOutPax.getitemnumber(i,"npax") then
			ll_found = 1
		end if
		ls_version 	+= string(dsCenOutPax.getitemnumber(i,"nversion"), "000")+"-"				
		ls_pax 		+= string( dsCenOutPax.getitemnumber(i,"npax"), "000")+"-"				
	next
	
	if ll_found=1 then
		
		// --------------------------------------------------------------------------------
		// 20.10.2009 HR: Wenn Paxe nicht in Version  passen, dann 
		//                        passende Version suchen
		// --------------------------------------------------------------------------------
		lds_acsearch = create datastore
		lds_acsearch.dataobject="dw_aircraftversion_search"
		lds_acsearch.settransobject(SQLCA)
		
		lds_acsearch.retrieve(ll_naircraft_key)
		
		ls_filter		= ""
		ls_version 	= ""
		ls_pax 	  	= ""

		for i=1 to dsCenOutPax.rowcount()
			
			// 31.08.2009 HR: Es werden momentan nur die ersten 3 Klassen ber$$HEX1$$fc00$$ENDHEX$$cksichtigt
			//if i> 3 then continue
			if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue // 14.02.2013 HR: nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
			
			ls_cclass 	= dsCenOutPax.getitemstring(i,"cclass")
			ll_pax_old 	= dsCenOutPax.getitemnumber(i,"npax")
			
			ll_found		= lds_acsearch.find("nclass"+string(i)+" >= "+string(ll_pax_old), 1, lds_acsearch.rowcount())
			
			if ll_found=0 then 
				if lds_acsearch.rowcount()>0 then
					ll_found	= lds_acsearch.rowcount()
				else
					of_trace("of_recalc_pax", 6,ls_flgnr+"Versionsanpassung: kein Zeile mehr in lds_acsearch. Paxzeile "+ string(i)+"; ls_version: "+ls_version +";ls_pax: "+ls_pax)
					ll_found 	= -1
					exit
				end if
				
			end if
			
			ll_pax_new 			= lds_acsearch.getitemnumber(ll_found, "nclass"+string(i))
	
			// 29.10.2009 HR: Bei neuer Version muss der Versionskey gespeichert werden
			lVersionGroupKey 	= lds_acsearch.GetItemNumber(ll_found,"ngroup_key")

			ls_version 			+= string(ll_pax_new, "000")+"-"				
			ls_pax 				+= string(ll_pax_old, "000")+"-"				
			
			dsCenOutPax.setitem(i,"nversion",ll_pax_new )
			
			if ls_filter="" then
				ls_filter = "nclass"+string(i)+" = "+string(ll_pax_new)
			else
				ls_filter += " and nclass"+string(i)+" = "+string(ll_pax_new)
			end if
			
			lds_acsearch.setfilter(ls_filter)
			lds_acsearch.filter()
			
			of_trace("of_recalc_pax", 100,ls_flgnr+"Versionsanpassung: Versionssuche Filter: "+ls_filter +" Count "+String(lds_acsearch.rowcount()))
		next
		
		if ll_found<> -1 then
			ls_version 	= left(ls_version, len(ls_version) -1)
			ls_pax 		= left(ls_pax, len(ls_pax) -1)
			
			if ls_version <>  dsCenOut.GetItemString(arg_lrow,"cconfiguration") then
				of_trace("of_recalc_pax", 6,ls_flgnr+"Versionsanpassung: Alt: "+ dsCenOut.GetItemString(arg_lrow,"cconfiguration")+"; Pax: "+ls_pax +"; Neu: "+ls_version)
				dsCenOut.SetItem(arg_lrow,"cconfiguration", ls_version)
			end if
		else
			destroy lds_acsearch
			
			//Filter auf Paxe wieder l$$HEX1$$f600$$ENDHEX$$schen
			dsCenOutPax.Setfilter("")
			dsCenOutPax.filter()

			dsLocal_adjustments.setfilter("")
			dsLocal_adjustments.filter()

			garbagecollect()
			return false
		end if
		destroy lds_acsearch
	else
		ls_version 	= left(ls_version, len(ls_version) -1)
		ls_pax 		= left(ls_pax, len(ls_pax) -1)

		of_trace("of_recalc_pax", 6,ls_flgnr+"Versionsanpassung: Keine Versionsanpassung n$$HEX1$$f600$$ENDHEX$$tig, da Paxe: "+ ls_pax +" in Version "+ls_version +" passen.")
	end if
	
end if

// --------------------------------------------------------------------------------
//$$HEX1$$dc00$$ENDHEX$$berbeladung abschneiden und ggf Upgraden
// --------------------------------------------------------------------------------
for i =  dsCenOutPax.rowcount() to 1 step -1
	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue // 14.02.2013 HR: nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
		
	ls_cclass 	= dsCenOutPax.getitemstring(i,"cclass")
	ll_pax_old 	= dsCenOutPax.getitemnumber(i,"npax")
	ll_version 	= dsCenOutPax.getitemnumber(i,"nversion") 

	if li_overload[i]=0 then
		if ll_pax_old > ll_version then
			ll_pax_new = ((ll_pax_old - ll_version) * li_upgrade[i] / 100 ) + .5
			dsCenOutPax.setitem(i,"npax", ll_version)
			if ls_upclass[i]="none" then
				of_trace("of_recalc_pax", 6,ls_flgnr+"Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_version)+" keine Upgradeklasse definiert")
			else
				of_trace("of_recalc_pax", 6,ls_flgnr+"Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_version)+" Upgrade "+string(ll_pax_new)+" Paxe ("+string( li_upgrade[i])+"%) nach "+ ls_upclass[i] )
				ll_found=dsCenOutPax.find("cclass = '"+ ls_upclass[i]+"'", 1, dsCenOutPax.rowcount())
				if ll_found>0 then
					ll_pax_old = dsCenOutPax.getitemnumber(ll_found,"npax")
					dsCenOutPax.setitem(ll_found,"npax", ll_pax_old + ll_pax_new )
					of_trace("of_recalc_pax", 6,ls_flgnr+"                     -> Anpassung Klasse "+ ls_upclass[i]+" Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_pax_old + ll_pax_new))
				else
					of_trace("of_recalc_pax", 6,ls_flgnr+"                     -> Upgradeklasse "+ls_upclass[i]+" nicht gefunden")
				end if
			end if
		end if
	elseif  ll_pax_old > ll_version then
			of_trace("of_recalc_pax", 6,ls_flgnr+"keine Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung gew$$HEX1$$fc00$$ENDHEX$$nscht")		
	end if
next

// --------------------------------------------------------------------------------
//Nachfahrten reduzieren
// --------------------------------------------------------------------------------
for i = 1 to  dsCenOutPax.rowcount() 
	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue // 14.02.2013 HR: nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
	
	ll_pax_old 	= dsCenOutPax.getitemnumber(i,"npax") 
	ll_version 	= dsCenOutPax.getitemnumber(i,"nversion") 
	ls_cclass 	= dsCenOutPax.getitemstring(i,"cclass")
	
	if ll_pax_old >= ll_version - li_red_add_delivery[i] and ll_pax_old < ll_version then
		dsCenOutPax.setitem(i,"npax", ll_version)
		of_trace("of_recalc_pax", 6,ls_flgnr+"Paxanpassung Nachfahrtenreduktion Klasse "+ls_cclass+" Pax old: "+string(ll_pax_old)+" Version: "+string(ll_version)+" FH ab "+string(ll_version - li_red_add_delivery[i])+" Paxe")
	end if 
next

//Filter auf Paxe wieder l$$HEX1$$f600$$ENDHEX$$schen
dsCenOutPax.Setfilter("")
dsCenOutPax.filter()

dsLocal_adjustments.setfilter("")
dsLocal_adjustments.filter()

return true
end function

public function boolean of_generate_spml_from_citp (long lcenoutrow);// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_spml_from_citp (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// long lcenoutrow
// --------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  03.09.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

datetime dtQueryID
long 		i, j, lSPML_Class, lSPML_Quantity, lFound, lFind, lreturn, lSPML_Quantity_Old, iSPML_TopOff_old, lnreq_flight_key
string 	ls_CFLIGHT_KEY, sSPML_Class, sSPML, sSPML_Remark, sOriginal_Remark, sFirstname, sFindString
integer 	iSPML_TopOff

if dsCITPFlightDataSPML.rowcount()=0 then return true

If IsNull(sSuffix) Or Len(sSuffix) = 0 Then sSuffix = ' '

// -------------------------------------------------
// Es wird erstmal gel$$HEX1$$f600$$ENDHEX$$scht
// -------------------------------------------------
If bDelete = True Then
	delete from cen_out_spml where nresult_key = :lResultKey;
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	
End if
dsCenOutNewSPML.setfilter("nresult_key = "+string(lresultkey))
dsCenOutNewSPML.filter()

lnreq_flight_key = dsCITPFlightDataSPML.GetItemnumber(1,"cen_request_flight_nreq_flight_key")


For i = 1 to dsCITPFlightDataSPML.Rowcount()

	If lnreq_flight_key <> dsCITPFlightDataSPML.GetItemnumber(i,"cen_request_flight_nreq_flight_key") Then Exit
	
	lSPML_Class			= dsCITPFlightDataSPML.GetItemNumber(i,"nclass_number")
	sSPML_Class			= dsCITPFlightDataSPML.GetItemString(i,"cclass")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 26.02.2014 HR: In CITP kann es sein, dass die falsche Klassennummer eingetragen ist
	// --------------------------------------------------------------------------------------------------------------------
	j = dsAirlineClasses.find("cclass = '"+sSPML_Class+"'", 1, dsAirlineClasses.rowcount())
	if j>0 then lSPML_Class = dsAirlineClasses.Getitemnumber(j,"nclass_number")
	
	sSPML					= dsCITPFlightDataSPML.GetItemString(i,"cspml")
	sSPML_Remark		= dsCITPFlightDataSPML.GetItemString(i,"cadd_text")
	lSPML_Quantity		= dsCITPFlightDataSPML.GetItemNumber(i,"nquantity")
	//iSPML_TopOff		= dsCITPFlightDataSPML.GetItemNumber(i,"ntopoff")
	sOriginal_Remark	= dsCITPFlightDataSPML.GetItemString(i,"cadd_text")
	sFirstname	= dsCITPFlightDataSPML.GetItemString(i,"cname")
	
	// 25.05.2005 Bemerkung "null" auf null setzen
	if sSPML_Remark = "null" then setnull(sSPML_Remark)

	// 27.11.2009 HR:
	if len(sSPML_Remark) > 40 then 
		sSPML_Remark="Please refer to station"
	end if
		
	if isnull(iSPML_TopOff) then iSPML_TopOff = 0

	// Nur g$$HEX1$$fc00$$ENDHEX$$ltige SPML eintragen
	lFound = dsValidSPML.Find("cspml = '" + sSPML + "' and nairline_key = " + string(lAirlineKey) &
										,1,dsValidSPML.RowCount())
	if lFound <= 0 then
		// Eintrag auf Fehlerprotokoll?
		continue
	end if
	// Fallunterscheidung:
	// Beim SPML-Import mit Namen gelten andere Regeln!
	// ggf. Schalter im Setup
	
	// 16.09.2008 MNu:
	// zus$$HEX1$$e400$$ENDHEX$$tzlich cfirstname ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
	// AMOS-sonderbehandlung raus, weil durch $$HEX1$$e400$$ENDHEX$$nderung vom 25.05.2005 $$HEX1$$fc00$$ENDHEX$$berfl$$HEX1$$fc00$$ENDHEX$$ssig
	
	// immer suchen: klasse und spml
	sFindString = "nclass_number = " + string(lSPML_Class) + " and cspml = '" + sSPML + "'"
	// name da: auch danach suchen
	//if not isnull(sFirstname) and len(trim(sFirstname)) > 0 then sFindString += " and cname = '" + sFirstname + "'"
	// zusatztext da: auch danach suchen
	if not isnull(sSPML_Remark) then sFindString += " and cadd_text = '" + sSPML_Remark + "'"
	
	lFind = dsCenOutNewSPML.Find(sFindString,1,dsCenOutNewSPML.RowCount())
	
	if lFind = 0 then
		// SPML ist neu

		lReturn = of_insert_new_spml()
		if lReturn > 0 then
			dsCenOutNewSPML.SetItem(lReturn,"cclass",sSPML_Class)
			dsCenOutNewSPML.SetItem(lReturn,"nclass_number",lSPML_Class)
			dsCenOutNewSPML.SetItem(lReturn,"cspml",sSPML)
			dsCenOutNewSPML.SetItem(lReturn,"cadd_text",sSPML_Remark)
			dsCenOutNewSPML.SetItem(lReturn,"nspml_key",dsValidSPML.GetItemNumber(lFound,"nspml_key"))
			dsCenOutNewSPML.SetItem(lReturn,"nquantity",lSPML_Quantity)
			dsCenOutNewSPML.SetItem(lReturn,"ndummy",1)
			dsCenOutNewSPML.SetItem(lReturn,"ntopoff",iSPML_TopOff)
			dsCenOutNewSPML.SetItem(lReturn,"status_nquantity",1)
			//dsCenOutNewSPML.SetItem(lReturn,"cname"," ")
		end if
	else
		lSPML_Quantity_Old = dsCenOutNewSPML.GetItemNumber(lFind,"nquantity")
		dsCenOutNewSPML.SetItem(lFind,"nquantity",lSPML_Quantity_Old + lSPML_Quantity)
	end if

	dsCenOutNewSPML.SetItem(lFind,"ntopoff",iSPML_TopOff)
next	

return true
end function

public function long of_insert_new_spml ();// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_insert_new_spml (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: long
// --------------------------------------------------------------------------------
//  Beschreibung:
// Achtung: Es sind folgende Datastores bereitzuhalten
// * Liste aller erlaubten SPML f$$HEX1$$fc00$$ENDHEX$$r die entsprechende Airline und OnTop-Info
//	* Liste aller erlaubten Klassen f$$HEX1$$fc00$$ENDHEX$$r die entsprechende Airline
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  03.09.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

long		lRow
long		lSequence
long		lFind
long		i
long		lclass_number
long		lSPML_Quantity


lSequence = f_Sequence("seq_cen_out_spml", sqlca)
// -----------------------------------------
// liefert -1 bei Fehler
// -----------------------------------------
If lSequence = -1 Then
	return -1
end if

lRow = dsCenOutNewSPML.InsertRow(0)

dsCenOutNewSPML.SetItem(lRow,"nmaster_key",		lSequence)
dsCenOutNewSPML.SetItem(lRow,"nresult_key",		lresultkey)
dsCenOutNewSPML.SetItem(lRow,"nquantity_old",	0)
dsCenOutNewSPML.SetItem(lRow,"nquantity",		1)
dsCenOutNewSPML.SetItem(lRow,"ntransaction", lTransActionKey)
dsCenOutNewSPML.SetItem(lRow,"DTIMESTAMP",datetime(today(),now()))
dsCenOutNewSPML.SetItem(lRow,"nstatus",iGenerierungsstatus)

lFind = dsValidSPML.Find("nairline_key = " + string(lAirlinekey) + " and nclass_number = 2 and nbooking_class = 1",1,dsValidSPML.RowCount())
if lFind > 0 then
	dsCenOutNewSPML.SetItem(lRow,"cclass",			dsValidSPML.GetItemString(lFind, "cclass"))		
	dsCenOutNewSPML.SetItem(lRow,"nclass_number",	dsValidSPML.GetItemNumber(lFind, "nclass_number"))
else
	lFind = dsValidSPML.Find("nairline_key = " + string(lAirlinekey) + " and nclass_number = 1 and nbooking_class = 1",1,dsValidSPML.RowCount())
	if lFind > 0 then
		dsCenOutNewSPML.SetItem(lRow,"cclass",			dsValidSPML.GetItemString(lFind, "cclass"))		
		dsCenOutNewSPML.SetItem(lRow,"nclass_number",	dsValidSPML.GetItemNumber(lFind, "nclass_number"))
	end if
end if

//
// (Master-)Prio wird neu vergeben
//
for i = 1 to dsCenOutNewSPML.RowCount()
	dsCenOutNewSPML.SetItem(i,"nprio",i)
next

dsCenOutNewSPML.SetItem(lRow,"nmanual_input",	1)		
dsCenOutNewSPML.SetItem(lRow,"cdescription",	" " ) //dw_single.GetItemString(dw_single.GetRow(),"cdescription"))		
dsCenOutNewSPML.SetItem(lRow,"ndeduction",		1)		// das wird sich erst sp$$HEX1$$e400$$ENDHEX$$ter noch herausstellen,
															// da diese Info erst nach der Mahlzeitenermittlung bekannt ist
dsCenOutNewSPML.SetItem(lRow,"status_nquantity",	1)		
															
//dw_spml.SetItem(lRow,"nspml_key",			1)		// wird bei der Eingabe ermittelt
//dw_spml.SetItem(lRow,"ntransaction",		1)		// in wf_changed_information

//HR 27.08.2008 CBASE-DE-EM-2077: SPML-Text darf nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden, wenn gespeichert wurde.
// Bei Neuaufnahme Schalter auf 0 setzen
dsCenOutNewSPML.setitem(lRow, "old_spml",0)

return lRow

end function

public function boolean of_compare_flights (long arg_nairlinekey, string arg_cunit, string arg_cclient, date arg_ddeparture, string arg_sdescription);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_compare_flights (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_nairlinekey
//  string arg_cunit
//  string arg_cclient
//  date arg_ddeparture
//  string arg_sdescription
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Vergleicht die Fl$$HEX1$$fc00$$ENDHEX$$ge im System mit den Fl$$HEX1$$fc00$$ENDHEX$$gen, die laut 
//				        Beladedefinition/Flugplan fliegen sollen und erzeugt 
//					   hinzugekommene Fl$$HEX1$$fc00$$ENDHEX$$ge, l$$HEX2$$e400df00$$ENDHEX$$t existierende Fl$$HEX1$$fc00$$ENDHEX$$ge neu
//					   durchrechnen und entfallene Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  28.05.2010	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
uo_generate_datastore	dsCenOutTemp, dsCenOutIst
long 		i, lrow,a, ll_resultkey, lSequence
string 		ls_alc, ls_suffix, ls_find, ls_deptime
integer 	li_flgnr, li_legnr, li_status
datastore dsTemp
date 		ld_depature
string 		ls_GenerateRoutingPlan
// ---------------------------------------------------------
//Umgebungsvariablen setzen
// ---------------------------------------------------------
dGenerationDate = arg_ddeparture
lAirlineKey = arg_nairlinekey
sUnit = arg_cunit
sClient = arg_cClient

// 10.01.2011 HR:
sAirline = of_get_airline_from_key(arg_nairlinekey)
iJob_Type = -2 

ii_delete_flights = 0 //Fl$$HEX1$$fc00$$ENDHEX$$ge sollen von der Generierungsfunktion nicht gel$$HEX1$$f600$$ENDHEX$$scht werden

// 20.10.2009 HR: Alle Datastores reseten, dass bei einem Fehler nichts stehen bleibt.
dsCenOut.Reset()
dsCenOutHandling.Reset()
dsCenOutQaq.Reset()
dsCenOutHandlingNews.Reset()
dsCenOutNewsExtra.Reset()
dsCenOutPax.Reset()
if isvalid(uo_generate_meals) then
	if isvalid(uo_generate_meals.dsCenOutMeals) then
		uo_generate_meals.dsCenOutMeals.Reset()
	end if
end if

// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Flugplan ermitteln
// ---------------------------------------------------------
lScheduleKey = of_get_schedule_key()
If lScheduleKey = -1 Then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": No valid flight schedule key available.")
	return False
End if	

// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Streckenplan ermitteln
// und das Charter-Flag setzen
// ---------------------------------------------------------
lRoutingPlanKey = of_get_routingplan_key()
If lRoutingPlanKey = -1 Then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": No valid loading definition key available.")
	return False
End if	

// ---------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r die History ermitteln
// ---------------------------------------------------------
lTransActionKey = of_get_history_key()
If lTransActionKey = -1 Then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": No valid loading history key available.")
	return False
End if
// ---------------------------------------------------------
// Retieve Traffic Areas
// ---------------------------------------------------------
bUseOwner4TrafficArea = of_use_owner_for_trafficarea( arg_cclient , lairlinekey)  // 18.11.2010 OH: /10.01.2011 HR
dsTrafficAreas.Retrieve(lAirlineKey,dGenerationdate)

// ---------------------------------------------------------
// Retrieve auf interne Zeiten
// ---------------------------------------------------------
dsLocalTimes.Retrieve(sClient,sUnit,lAirlineKey)	
dsLocalTimesFlights.Retrieve(sClient,sUnit,lAirlineKey)	

// ---------------------------------------------------------
// Retrieve auf Flugger$$HEX1$$e400$$ENDHEX$$te die nicht generiert werden sollen
// ---------------------------------------------------------
dsGenerateNonACType.Retrieve(sClient,sUnit,lAirlineKey,dGenerationdate)

// ---------------------------------------------------------
// Retrieve Airline Classes
// ---------------------------------------------------------
dsAirlineClasses.Retrieve(lAirlineKey)	
If dsAirlineClasses.Rowcount() <= 0 Then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": No valid airline classes available.")
	return False
End if

// ---------------------------------------------------------
// Retrieve Central Forecast
// ---------------------------------------------------------
dsCentralForecast.Retrieve(lAirlineKey,dGenerationDate)		

// ---------------------------------------------------------
// Retrieve Local Forecast
// ---------------------------------------------------------
dsLocalForecast.Retrieve(lAirlineKey,dGenerationDate)	

// ---------------------------------------------------------
// Retrieve Customer Codes (19.01.05)
// ---------------------------------------------------------
dsCustomerCodes.Retrieve(dGenerationDate)

// ---------------------------------------------------------
// Zwischenspeicher f$$HEX1$$fc00$$ENDHEX$$r die Defaultabfertigungsarten l$$HEX1$$f600$$ENDHEX$$schen
// ---------------------------------------------------------
dsHandlingTypeCache.Reset()

// ---------------------------------------------------------
// Erstellung der Fl$$HEX1$$fc00$$ENDHEX$$ge	CEN_OUT
// ---------------------------------------------------------
of_trace("of_compare_flights", 10,"Start generate Flights")
// --------------------------------------------------------------------------------------------------------------------
// Erstellung der Fl$$HEX1$$fc00$$ENDHEX$$ge	CEN_OUT
// 10.01.2011 HR: Bei gesetztem Schalter neue CFS-Generierung 
//                           ansonsten wie gehabt
// --------------------------------------------------------------------------------------------------------------------
if bCFSAirline then
	ls_GenerateRoutingPlan = dsGenerateRoutingPlan.dataobject 
	
	destroy dsGenerateRoutingPlan
	dsGenerateRoutingPlan					= Create DataStore
	dsGenerateRoutingPlan.dataobject = "dw_generate_routingplan_cfs"
	dsGenerateRoutingPlan.settransobject(SQLCA)

	destroy dsGenerateSchedule
	dsGenerateSchedule					= Create DataStore
	// --------------------------------------------------------------------------------------------------------------------
	// 01.07.2013 HR: Sollte ohne Flugplan generiert werden, dann nehmen
	//                           wir ein Flugplandatawindow aus den CFS-Daten
	// --------------------------------------------------------------------------------------------------------------------
	if ib_CFSWithoutFlightplan then
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_cfs"
	else
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_all"
	end if
//	dsGenerateSchedule.DataObject 		= "dw_generate_schedule_all"

	dsGenerateSchedule.SetTransObject(SQLCA)

	of_generate_flights_cfs()

	destroy dsGenerateRoutingPlan
	dsGenerateRoutingPlan					= Create DataStore
	dsGenerateRoutingPlan.dataobject = ls_GenerateRoutingPlan
	dsGenerateRoutingPlan.settransobject(SQLCA)	

	destroy dsGenerateSchedule
	dsGenerateSchedule					= Create DataStore
	dsGenerateSchedule.DataObject 		= "dw_generate_schedule"
	dsGenerateSchedule.SetTransObject(SQLCA)

	of_trace("of_compare_flights", 10,"of_generate_schedule: Rows in dsCenOut after creation (cfs): "+string(dsCenOut.rowcount()))
else
	of_generate_flights()
end if
of_trace("of_compare_flights", 10,"Rows in dsCenOut after creation: "+string(dsCenOut.rowcount()))
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_compare_flights_1_ds_cen_out_after_generate_flights"+string(now(),"hhmmss")+".xls", excel5!, true)

// ---------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung der generierten Daten vor dem Speichern
// ---------------------------------------------------------
of_validation()
of_trace("of_compare_flights", 10,"Rows in dsCenOut after validation: "+string(dsCenOut.rowcount()))
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_compare_flights_2_ds_cen_out_after_validation"+string(now(),"hhmmss")+".xls", excel5!, true)

// ---------------------------------------------------------
//Legnummer neu durchnummerieren und Zeiten anpassen
// ---------------------------------------------------------
of_reorg_legs()
of_trace("of_compare_flights", 10,"Rows in dsCenOut after reorg_legs: "+string(dsCenOut.rowcount()))
if ii_Debug_Save =1 then dsCenOut.SaveAs(is_Debug_save_path+"of_compare_flights_3_ds_cen_out_after_reorg"+string(now(),"hhmmss")+".xls", excel5!, true)

dsCenOutTemp = create uo_generate_datastore
dsCenOutTemp.dataobject = dsCenOut.dataobject 

dsCenOutIst = create uo_generate_datastore
dsCenOutIst.dataobject = "dw_cen_out_checkflights_ist" // dsCenOut.dataobject // 09.08.2010 HR: Neuse DW mit Retrieve auf Generationdate anstatt Departure-Date

dsCenOutIst.settransobject(SQLCA)

dsTemp = create datastore
dsTemp.dataobject = "dw_load_definition_flight_calc_req"
dsTemp.Settransobject(sqlca)

dsCenOutIst.retrieve(lAirlineKey, dGenerationDate, sClient, sUnit)
if ii_Debug_Save =1 then dsCenOutIst.SaveAs(is_Debug_save_path+"of_compare_flights_3a_dsCenOutIst"+string(now(),"hhmmss")+".xls", excel5!, true)

dsCenOut.rowscopy(1,dsCenOut.rowcount(),primary!, dsCenOutTemp,1,primary!)
dsCenOut.reset()

for i= 1 to dsCenOutIst.rowcount()
	ls_alc = dsCenOutIst.GetItemString(i,"cairline")
	ls_suffix = dsCenOutIst.GetItemString(i,"csuffix")
	li_flgnr = dsCenOutIst.GetItemNumber(i,"nflight_number")
	li_legnr = dsCenOutIst.GetItemNumber(i,"nleg_number")
	ll_resultkey = dsCenOutIst.GetItemNumber(i,"nresult_key")
	li_status = dsCenOutIst.GetItemNumber(i,"nstatus")
	ls_deptime =dsCenOutIst.GetItemString(i,"cdeparture_time") 
	
	
	dsCenOutIst.SetItem(i,"nstatus",0) // 16.08.2010 HR: Status auf neuzuberechnen setzen
	
	
	// --------------------------------------------------------------------------------------------------------------------
	// 09.08.2010 HR: Auch das Datum in die Suche einbeziehen
	// --------------------------------------------------------------------------------------------------------------------
	ld_depature =  date(dsCenOutIst.GetItemdatetime(i,"ddeparture") )
	
	ls_find = "date(ddeparture)=date('"+string(ld_depature,"YYYY-MM-DD")+"') and cairline = '"+ls_alc+"' and nflight_number = "+string(li_flgnr)+" and nleg_number = "+string(li_legnr)

	if isnull(ls_suffix) then
		ls_find += " and isnull(csuffix)"
	else
		ls_find += " and csuffix = '"+ls_suffix+"'"
	end if
	
	lrow = dsCenOutTemp.find(ls_find, 1, dsCenOutTemp.rowcount())
	
	if lrow=0 then
		//Flug nicht gefunden, dann L$$HEX1$$f600$$ENDHEX$$schauftrag erstellen
		of_trace("of_compare_flights", 10,"Flight to delete because not found "+ls_find)

		a = dsTemp.Insertrow(0)
		
		lSequence = f_sequence("seq_sys_queue_flight_calc", sqlca)
		if ljobgroup = 0 then
			ljobgroup = lSequence
		end if
		dsTemp.SetItem(a, "njob_nr", lSequence)
		dsTemp.SetItem(a, "nresult_key", ll_resultkey)
		dsTemp.SetItem(a, "ddeparture", Datetime(dGenerationDate, Time(ls_deptime))) // 09.08.2010 HR: richtiges Abflugsdatum verwenden
		dsTemp.SetItem(a, "dcreated", Datetime(today(), now()))
		dsTemp.SetItem(a, "cmodified", "requested by " + s_app.sUser)
		dsTemp.SetItem(a, "cuser", s_app.sUser)
		dsTemp.SetItem(a, "nstatus", li_status)
		dsTemp.SetItem(a, "nfunction",8)   //Neue Funktion 'Flug l$$HEX1$$f600$$ENDHEX$$schen'
		dsTemp.SetItem(a, "nforecast",2)
		dsTemp.SetItem(a, "nhistory",1)
		dsTemp.SetItem(a, "njob_group",ljobgroup)
		dsTemp.SetItem(a, "cdescription",arg_sdescription)
		dsTemp.SetItem(a, "nsort",1)		
	else
		//Flug gefunden, dann neu berechnen lassen
		dsCenOutTemp.deleterow(lrow)
		
		a = dsTemp.Insertrow(0)
		
		lSequence = f_sequence("seq_sys_queue_flight_calc", sqlca)
		if ljobgroup = 0 then
			ljobgroup = lSequence
		end if
		dsTemp.SetItem(a, "njob_nr", lSequence)
		dsTemp.SetItem(a, "nresult_key", ll_resultkey)
		dsTemp.SetItem(a, "ddeparture", Datetime(ld_depature, Time(ls_deptime)))
		dsTemp.SetItem(a, "dcreated", Datetime(today(), now()))
		dsTemp.SetItem(a, "cmodified", "requested by " + s_app.sUser)
		dsTemp.SetItem(a, "cuser", s_app.sUser)
		dsTemp.SetItem(a, "nstatus", li_status)
		dsTemp.SetItem(a, "nfunction",1)  
		dsTemp.SetItem(a, "nforecast",2)
		dsTemp.SetItem(a, "nhistory",1)
		dsTemp.SetItem(a, "njob_group",ljobgroup)
		dsTemp.SetItem(a, "cdescription",arg_sdescription)
		dsTemp.SetItem(a, "nsort",1)		

	end if
next

//Alle $$HEX1$$fc00$$ENDHEX$$brigen Fl$$HEX1$$fc00$$ENDHEX$$ge in dsCenOutTemp sind neue Fl$$HEX1$$fc00$$ENDHEX$$ge und m$$HEX1$$fc00$$ENDHEX$$ssen angelegt werden
if dsCenOutTemp.rowcount()>0 then
	dsCenOutTemp.rowscopy(1,dsCenOutTemp.rowcount(),primary!,dsCenOut, 1, primary!)
	
	iPaxType = 2 //Erstmal mit lokaler Auslastung generieren, bis was anderes definiert wird
	
	for i = 1 to dsCenOut.rowcount()
		//Status des Fluges auf 0 setzen (neu angelegt, ohne Handlingaufl$$HEX1$$f600$$ENDHEX$$sung)
		dsCenOut.setitem(i,"nstatus",0)
		
		//Auftrag f$$HEX1$$fc00$$ENDHEX$$r Neuberechung anlegen
		ls_alc = dsCenOut.GetItemString(i,"cairline")
		ls_suffix = dsCenOut.GetItemString(i,"csuffix")
		li_flgnr = dsCenOut.GetItemNumber(i,"nflight_number")
		li_legnr = dsCenOut.GetItemNumber(i,"nleg_number")
		lResultKey = dsCenOut.GetItemNumber(i,"nresult_key")
		li_status = dsCenOut.GetItemNumber(i,"nstatus")
		ls_deptime =dsCenOut.GetItemString(i,"cdeparture_time") 
		ld_depature =  date(dsCenOut.GetItemdatetime(i,"ddeparture") )	//09.08.2010 HR: Datum mit ausgeben
		lAircraftKey = dsCenOut.GetItemNumber(i,"NAIRCRAFT_KEY") 	//07.03.2011 HR: Wird f$$HEX1$$fc00$$ENDHEX$$r die Versionsfindung ben$$HEX1$$f600$$ENDHEX$$tigt

		// --------------------------------------------------------------------------------------------------------------------
		// 16.08.2010 HR: Falls der Status nicht gesetzt, dann Status auf 1
		// --------------------------------------------------------------------------------------------------------------------
		if li_status < 1 then li_status=1

		//Pax-Zahlen f$$HEX1$$fc00$$ENDHEX$$r Flug anlegen lassen
		of_generate_version(i)
		
		ls_find = "Departure: "+string(ld_depature, "dd.mm.yyyy")+" "+ls_alc+" "+string(li_flgnr)+" Leg: "+string(li_legnr)

		if isnull(ls_suffix) then
			ls_find += " and isnull(csuffix)"
		else
			ls_find += " and csuffix = '"+ls_suffix+"'"
		end if

		of_trace("of_compare_flights", 10,"New Flight to create "+ls_find)

		a = dsTemp.Insertrow(0)
		
		lSequence = f_sequence("seq_sys_queue_flight_calc", sqlca)
		if ljobgroup = 0 then
			ljobgroup = lSequence
		end if
		dsTemp.SetItem(a, "njob_nr", lSequence)
		dsTemp.SetItem(a, "nresult_key", lResultKey)
		dsTemp.SetItem(a, "ddeparture", Datetime(dGenerationDate, Time(ls_deptime)))
		dsTemp.SetItem(a, "dcreated", Datetime(today(), now()))
		dsTemp.SetItem(a, "cmodified", "requested by " + s_app.sUser)
		dsTemp.SetItem(a, "cuser", s_app.sUser)
		dsTemp.SetItem(a, "nstatus", li_status)
		dsTemp.SetItem(a, "nfunction",1)  
		dsTemp.SetItem(a, "nforecast",2)
		dsTemp.SetItem(a, "nhistory",1)
		dsTemp.SetItem(a, "njob_group",ljobgroup)
		dsTemp.SetItem(a, "cdescription",arg_sdescription)
		dsTemp.SetItem(a, "nsort",1)				
	next
	
	if ii_Debug_Save =1 then dsCenOut.saveas(is_Debug_save_path+"of_compare_flights_4_dsCenOut_new_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)
	if ii_Debug_Save =1 then dsCenOutPax.saveas(is_Debug_save_path+"of_compare_flights_4_dsCenOutPax_new_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

	// 09.08.2010 HR: Neuer Protokolleintrag
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Anzahl S$$HEX1$$e400$$ENDHEX$$tze in dsCenOut "+string(dsCenOut.rowcount()))
	
	//Neue Fl$$HEX1$$fc00$$ENDHEX$$ge speichern
	if dsCenOut.update()=1 then
		if dsCenOutPax.update()<>1 then
			// 09.08.2010 HR: Ausgabe richtiger SQLCODE und TEXT
			of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Fehler Speichern dsCenOutPax "+string(dsCenOutPax.lSQLErrorDBCode)+" "+dsCenOutPax.sSQLErrorText)
			rollback;
			
			destroy dsTemp
			destroy dsCenOutTemp
			destroy dsCenOutIst
			garbagecollect()

			return false
		else
			// 09.08.2010 HR: Erfolgsmeldung ausgeben
			of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Speichern erfolgreich")
		end if
	else
		// 09.08.2010 HR: Ausgabe richtiger SQLCODE und TEXT
		of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Fehler Speichern dsCenOut "+string(dsCenOut.lSQLErrorDBCode)+" "+dsCenOut.sSQLErrorText)
		rollback;

		destroy dsTemp
		destroy dsCenOutTemp
		destroy dsCenOutIst
		garbagecollect()

		return false
	end if
end if

// 16.08.2010 HR: Status neu zu berechnender Fl$$HEX1$$fc00$$ENDHEX$$ge speichern
if dsCenOutIst.update()<>1 then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Fehler Speichern dsCenOutIst "+string(dsCenOutIst.lSQLErrorDBCode)+" "+dsCenOutIst.sSQLErrorText)
	rollback;

	destroy dsTemp
	destroy dsCenOutTemp
	destroy dsCenOutIst
	garbagecollect()

	return false
else
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Speichern dsCenOutIst erfolgreich")
end if

if dsTemp.Update() <> 1 then
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": Fehler Speichern Nachberechnungsauftr$$HEX1$$e400$$ENDHEX$$ge "+string(sqlca.sqlcode)+" "+sqlca.sqlerrtext)
	rollback;

	destroy dsTemp
	destroy dsCenOutTemp
	destroy dsCenOutIst
	garbagecollect()

	return false
else
	// 09.08.2010 HR: Erfolgsmeldung ausgeben
	of_trace("of_compare_flights", 10,""+arg_cunit+"-"+string(lAirlineKey)+"-"+string(dGenerationDate)+": "+string(dsTemp.rowcount())+" Nachberechnungsauftr$$HEX1$$e400$$ENDHEX$$ge erstellt.")
end if

if ii_Debug_Save =1 then dsTemp.saveas(is_Debug_save_path+"of_compare_flights_5_dsTemp_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

destroy dsTemp
destroy dsCenOutTemp
destroy dsCenOutIst
garbagecollect()

return true
end function

public function boolean of_generate_explosionjobs ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_explosionjobs (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: 	Anlegen der Auftr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r OnlineExplosion f$$HEX1$$fc00$$ENDHEX$$r alle
//						Fl$$HEX1$$fc00$$ENDHEX$$ge der Tages
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  03.08.2010	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

uo_generate_datastore lds
long i, lsequence
datetime ldt, ldt_dep

if dsCenOut.rowcount()=0 then 
	// --------------------------------------------------------------------------------------------------------------------
	// 09.11.2010 HR: Auch wenn keine Fl$$HEX1$$fc00$$ENDHEX$$ge da sind, Job als erledigt markieren
	// --------------------------------------------------------------------------------------------------------------------
	If not of_write_Job_history() Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
		rollback using sqlca;
		return False
	Else
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully generated in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		commit using sqlca;
		return True
	End if	
end if

ldt = datetime(today(),now())

lds = create uo_generate_datastore
lds.dataobject="dw_generate_explosionjobs"
lds.settransobject(SQLCA)

for i=1 to dsCenOut.rowcount()
	lds.insertrow(1)
	lsequence = f_sequence("seq_sys_explosion", sqlca)
	
	if lsequence = -1 then
		of_trace("of_generate_explosionjobs", 1,"Error getting Sequence:  " + string( SQLCA.SQLCODE) + " - " + SQLCA.SQLERRTEXT)
		destroy lds
		return false
	end if 
	ldt_dep = datetime(date(dsCenOut.getitemdatetime(i,"ddeparture")), time(dsCenOut.getitemstring(i,"cdeparture_time")))
	
	lds.setitem(1,"njob_nr",lsequence)
	lds.setitem(1,"nresult_key",dsCenOut.getitemnumber(i,"nresult_key"))
	lds.setitem(1,"ddeparture",ldt_dep)
	lds.setitem(1,"dcreated",ldt)
	lds.setitem(1,"nstatus",0)
	lds.setitem(1,"ncnx",0)
	lds.setitem(1,"ndispo",0)
	lds.setitem(1,"cvalue","G-"+string(dGenerationDate,"ddmmyy")+"-"+string(lJob_Key))
	lds.setitem(1,"dlogtime",dtToday)
	lds.setitem(1,"nfinish",0)
next

if lds.update()=1 then
	of_trace("of_generate_explosionjobs", 1,"Generate " + string( lds.rowcount()) + " Explosionjobs.")

	destroy lds
	
	lTimeEnd = cpu()

	// 17.12.2014 HR: Sollen IDOC-Auftr$$HEX1$$e400$$ENDHEX$$ge erstellt werden?
	if ii_orders_transfer = 1 then
		if not  of_generate_idocjobs() then
			return false
		end if
	end if
	
	If not of_write_Job_history() Then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't write into table job_history.")
		rollback using sqlca;
		return False
	Else
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iInfo,sAirline,string(dGenerationDate,s_app.sDateformat),"Successfully generated in " + string ((lTimeEnd - lTimeStart) / 1000 , "0.000") + " seconds.") 
		commit using sqlca;
		return True
	End if
else
	of_trace("of_generate_explosionjobs", 1,"Update Error:  " + string( lds.lSQLErrorDBCode)+" "+lds.sSQLErrorText)

	destroy lds
	return false
end if

	
	
	
end function

public function boolean of_generate_flights_cfs ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_flights_cfs (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: Boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Generierung der Fl$$HEX1$$fc00$$ENDHEX$$ge nach den Regeln
//					   'Catering Flight Schedule'
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       	Version  	Autor          		Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  01.10.2010	1.0      	H.Rothenbach   Erstellungdestroy

//
// --------------------------------------------------------------------------------------------------------------------

integer 						i, j, k, xx
integer						iVerkehrsTag
string  						sFrequenz
long 							lRow,lFound
long							lFlightGroup, lCFSGroupkey
long							lCurrentGroupKey
string							sFind
uo_generate_datastore 	dsExtCatSchedTemp

iVerkehrsTag 	= f_getfrequence(dGenerationDate)
sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"

// ------------------------------------------------------------------
// Alle Datastores und Filter reseten!
// -------------------------------------------------------------------	
dsCenOut.Reset()
dsCenOutHandling.Reset()
dsCenOutHandlingNews.Reset()
dsCenOutPax.Reset()
dsCenOutQAQ.Reset()
dsCenOutNewsExtra.Reset()
dsCharterMemory.Reset()

dsCenOut.setfilter("")
dsCenOut.filter()


// --------------------------------------------------------------------------------------------------------------------
// 10.01.2011 HR:
// --------------------------------------------------------------------------------------------------------------------
if isvalid(dsExtCatSched) then destroy dsExtCatSched

dsExtCatSched = create uo_generate_datastore	
dsExtCatSched.dataobject = "dw_generate_cfs_schedule"
dsExtCatSched.Settransobject(sqlca)
//dsExtCatSched.il_write_sql=Integer(ProfileString(s_App.sProfile,"CBASE_Service","SAVE_SQLPREV","0"))

// --------------------------------------------------------------------------------------------------------------------
// Einige Informationen aus cen_out cachen (sofern der Tag schonmal 
// generiert wurde)
// --------------------------------------------------------------------------------------------------------------------
dsCenOutCache.Retrieve(lAirlineKey, dGenerationDate, sclient, sunit)
of_trace("of_generate_flights_cfs", 1,"cached " + string( dsCenOutCache.RowCount()) + " flights for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey))

// --------------------------------------------------------------------------------------------------------------------
// 23.04.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r das Receiycling brauchen wir auch hier die alten QP (Finnland)
// --------------------------------------------------------------------------------------------------------------------
dsCenOutQP.Retrieve(lAirlineKey, sunit, dGenerationDate)
of_trace("of_generate_flights", 1,"cached " + string( dsCenOutQP.RowCount()) + " QPs for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey))

// --------------------------------------------------------------------------------------------------------------------
// Schauen, ob schon BOB-Werte eingespielt wurden
// --------------------------------------------------------------------------------------------------------------------
  SELECT count(*)  INTO :i  
    FROM cen_out,   
         cen_out_meals  
   WHERE ( cen_out_meals.nresult_key = cen_out.nresult_key ) and  
         (( cen_out.nairline_key = :lAirlineKey ) AND  
         ( cen_out.ddeparture = :dGenerationDate ) AND  
         ( cen_out.cunit = :sUnit ) AND 
	    ( cen_out_meals.nimport_from_bob = 1 ) )   ;

if sqlca.sqlcode=0 and i>0 then
	iImportBobValues = 1
end if

// --------------------------------------------------------------------------------------------------------------------
// Neu, erstmal alles l$$HEX1$$f600$$ENDHEX$$schen !
// Fl$$HEX1$$fc00$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen, alle detail Tabellen werden $$HEX1$$fc00$$ENDHEX$$ber FK gel$$HEX1$$f600$$ENDHEX$$scht.
// --------------------------------------------------------------------------------------------------------------------
if ii_delete_flights = 1 then
	of_trace_flight("of_generate_flights_cfs","Delete Flights") // 21.06.2012 HR: Ausgabe unabh$$HEX1$$e400$$ENDHEX$$ngig vom Tracelevel einschaltbar
	of_trace("of_generate_flights", 1,"start delete from cen_out")
	DELETE FROM cen_out 
			WHERE dgeneration_date 	= :dGenerationDate and 
					cclient	  				= :sclient and
					cunit		  				= :sunit and
					nairline_key 			= :lAirlineKey and 
					NNOTREGENERATE 	= 0;
					
	If sqlca.sqlcode <> 0 then
		of_trace("of_generate_flights_cfs", 1,"delete from cen_out - error " + string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext)
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"Can't delete flight schedule, sqlcode " + string(sqlca.sqlcode) + ".")

		rollback using sqlca;
		
		return False
	else
		of_trace("of_generate_flights", 1,"finish delete from cen_out")
	end if
end if

of_trace("of_generate_flights_cfs", 1,"Reading CFS-Flights")

dsExtCatSched.Retrieve(this.sAirline, dGenerationDate, lRoutingPlanKey, sunit)

if ii_Debug_Save =1 then dsExtCatSched.saveas(is_Debug_save_path+"of_generate_flights_cfs_1_dsExtCatSched_vorher"+string(now(),"hhmmss")+".xls", excel5!, true)

If dsExtCatSched.rowcount() = 0 then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"No valid CFS data available.")
	of_trace("of_generate_flights_cfs", 1,"No valid CFS data available. ("+f_check_null(this.sAirline)+"/"+f_check_null(string(dGenerationDate))+")")
	//rollback using sqlca;
			
	return False
end if

dsExtCatSchedTemp = create uo_generate_datastore
dsExtCatSchedTemp.dataobject = dsExtCatSched.dataobject 
of_trace("of_generate_flights_cfs", 50,"Rows in dsExtCatSched: "+string(dsExtCatSched.rowcount()))

// --------------------------------------------------------------------------------------------------------------------
// Retrieve und Filter Flugplan 
// 12.10.2011 HR: bei ib_CFSWithoutFlightplan retireven wir anders
// --------------------------------------------------------------------------------------------------------------------
if ib_CFSWithoutFlightplan then
	dsGenerateSchedule.Retrieve(this.sAirline,dGenerationDate)
else
	dsGenerateSchedule.Retrieve(lScheduleKey,DateTime(dGenerationDate))
end if	
if ii_Debug_Save =1 then dsGenerateSchedule.saveas(is_Debug_save_path+"of_generate_flights_cfs_2_dsGenerateSchedule_vorher"+string(now(),"hhmmss")+".xls", excel5!, true)
of_trace("of_generate_flights_cfs", 1,"Rows in dsGenerateSchedule: "+string(dsGenerateSchedule.rowcount()))

// --------------------------------------------------------------------------------------------------------------------
// der CateringFlightSchedule ist der Taktgeber
// Zuerst schauen wir nach, ob der Flug auch laut Flugplan geht
// --------------------------------------------------------------------------------------------------------------------
for i=1 to dsExtCatSched.rowcount()
	if dsExtCatSched.getitemnumber(i,"nleg_number")=1 then
		cdeparture_vorleg=" "
	end if
	
	lrow = of_search_cfs_flight(dsExtCatSched, i)
	
	if  lrow > 0 then
		dsExtCatSched.setitem(i,"nvalid_flight",1)
		dsExtCatSched.setitem(i,"nschedrow",lrow)
		dsExtCatSched.setitem(i,"cfs_departure_time",dsGenerateSchedule.getitemstring(lrow,"cdeparture_time"))
		dsExtCatSched.setitem(i,"nfs_aircraft_key",dsGenerateSchedule.getitemNumber(lrow,"naircraft_key"))
		dsExtCatSched.setitem(i,"nfs_offset",dsGenerateSchedule.getitemNumber(lrow,"ndeparture_faktor"))
		dsExtCatSched.setitem(i,"nfs_tlc_from",dsGenerateSchedule.getitemNumber(lrow,"ntlc_from"))
		dsExtCatSched.setitem(i,"nfs_tlc_to",dsGenerateSchedule.getitemNumber(lrow,"ntlc_to"))
		dsExtCatSched.setitem(i,"nfind_schedule",1)
	else
		dsExtCatSched.setitem(i,"nvalid_flight",0)
	end if
next

if ii_Debug_Save =1 then dsExtCatSched.saveas(is_Debug_save_path+"of_generate_flights_cfs_3_dsExtCatSched_vor_filter"+string(now(),"hhmmss")+".xls", excel5!, true)

if not bCFSCheckOnly then
	dsExtCatSched.setfilter("nvalid_flight = 1")
	dsExtCatSched.filter()
end if

if ii_Debug_Save =1 then dsExtCatSched.saveas(is_Debug_save_path+"of_generate_flights_cfs_3_dsExtCatSched_nach_filter"+string(now(),"hhmmss")+".xls", excel5!, true)

of_trace("of_generate_flights_cfs", 50,"Rows in dsExtCatSched after check Flugplan: "+string(dsExtCatSched.rowcount()))

dsExtCatSched.rowscopy(1,dsExtCatSched.rowcount(), primary!,dsExtCatSchedTemp, 1, Primary!)

if ii_Debug_Save =1 then dsGenerateSchedule.saveas(is_Debug_save_path+"of_generate_flights_cfs_4_dsGenerateSchedule_nach_filter"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

// --------------------------------------------------------------------------------------------------------------------
// Retrieve und Filter Routingplan
// --------------------------------------------------------------------------------------------------------------------
dsGenerateRoutingPlan.Retrieve(lRoutingPlanKey, sUnit, dGenerationDate)
dsGenerateRoutingPlan.SetFilter(sFrequenz)
dsGenerateRoutingPlan.Filter()
of_trace("of_generate_flights_cfs", 50,"Rows in dsGenerateRoutingPlan: "+string(dsGenerateRoutingPlan.rowcount()))

if ii_Debug_Save =1 then dsGenerateRoutingPlan.saveas(is_Debug_save_path+"of_generate_flights_cfs_5_dsGenerateRoutingPlan_vorher_"+string(now(),"hhmmss")+".xls",excel5!,TRUE)

dsCenOutNotRegenerate.reset()
// dsCenOutNotRegenerate.setfilter("nnotregenerate = 1")  // 13.04.2015 HR: Wird nicht mehr ben$$HEX1$$f600$$ENDHEX$$tigt
dsCenOutNotRegenerate.retrieve(lAirlineKey, dGenerationDate, sclient, sUnit)
of_trace("of_generate_flights_cfs", 1,"cached " + string( dsCenOutNotRegenerate.RowCount()) + " flights for " + string(dGenerationDate) + " / " + sUnit + " / " + string(lAirlineKey)+" with markt not to regenerate.")

If dsGenerateSchedule.rowcount() <= 0 Then
	if not bCFSCheckOnly then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Flight Schedule.")
	end if
	
	destroy dsExtCatSchedTemp
	garbagecollect()
	
	of_trace("of_generate_flights_cfs", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(dsGenerateRoutingPlan.rowcount()))
	return False
End if

If dsGenerateRoutingPlan.rowcount() <= 0 Then
	if not bCFSCheckOnly then
		of_write_protocol(iJob_Type,iGenerierungsstatus,1,iWarnung,sAirline,string(dGenerationDate,s_app.sDateformat),"Found no flights in Loading Definition.")
	end if
	
	destroy dsExtCatSchedTemp
	garbagecollect()
	
	of_trace("of_generate_flights_cfs", 1,"dsGenerateSchedule.RowCount()=" + string(dsGenerateSchedule.rowcount()) + &
					", dsGenerateRoutingPlan.RowCount()=" + string(dsGenerateRoutingPlan.rowcount()))
	return False
End if

// --------------------------------------------------------------------------------------------------------------------
// Message an Window
// --------------------------------------------------------------------------------------------------------------------
If bSendMessage Then
	sPostMessage = "Execute job flights, for unit: " + sUnit + " Airline: " + sAirline + " Job ID: " + string(iJob_Type)
	w_cbase_generate_dialog.triggerevent("ue_redraw")
	yield()	
End if

of_trace("of_generate_flights_cfs", 50,"lRoutingPlanKey=" + string(lRoutingPlanKey)+" Rows: "+string(dsExtCatSched.rowcount()) )

lFlightGroup = 0

//HR 19.01.2011 Uns interessiert f$$HEX1$$fc00$$ENDHEX$$r den Schleifendurchlauf nur das 1. Leg
if not bCFSCheckOnly then
	dsExtCatSched.setfilter("nvalid_flight = 1 and nleg_number =1")
else
	dsExtCatSched.setfilter("nleg_number =1")
end if
dsExtCatSched.filter()
of_trace_flight("of_generate_flights_cfs","start finding flights") // 21.06.2012 HR: Ausgabe unabh$$HEX1$$e400$$ENDHEX$$ngig vom Tracelevel einschaltbar


// --------------------------------------------------------------------------------------------------------------------
// 16.04.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r CFS ohne Flugplan brauchen wir die UTC-Offsets zur Berechnung der UTC-Zeiten
// --------------------------------------------------------------------------------------------------------------------
// 19.02.2016 HR: CBASE-DE-CR-2015-059 Faktorermittlung wieder raus da neue Funktion zur Berechnung
//lds_utc = create datastore
//lds_utc.dataobject="dw_generate_utc_offset"
//lds_utc.settransobject(SQLCA)
//
if ib_CFSWithoutFlightplan then
	lFlightScheduleTime = 1  //CFS ohne Flugplan ist immer in Lokalzeit
// 19.02.2016 HR: CBASE-DE-CR-2015-059 Faktorermittlung wieder raus da neue Funktion zur Berechnung
//	lds_utc.retrieve()	
end if

for i=1 to dsExtCatSched.rowcount()
	sSuffix			= dsExtCatSched.Getitemstring(i,"csuffix")
	lFlightNumber 	= dsExtCatSched.Getitemnumber(i,"nflight_number")
	sTLCFrom		= dsExtCatSched.Getitemstring(i,"ctlc_from")
	sTLCTo			= dsExtCatSched.Getitemstring(i,"ctlc_to")

	if isnull(sSuffix) then sSuffix= " "

	//of_trace("of_generate_flights_cfs", 100,"Flight "+string(i) +" of "+string(dsExtCatSched.rowcount())+": "+string(lFlightNumber)+sSuffix+" "+sTLCFrom+sTLCTo)
	
	if lFlightGroup = dsExtCatSched.getitemnumber(i,"ncat_group_key") then continue
	
	lFlightGroup = dsExtCatSched.getitemnumber(i,"ncat_group_key")
	
	// --------------------------------------------------------------------------------------------------------------------
	// Falls Flugnummer im dsCenOutNotRegenerate zu finden ist, dann auch auf Generierung verzichten
	// 20.03.2015 HR: Es muss die ganze Strecke ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden, nicht nur CTLCFROM 
	// --------------------------------------------------------------------------------------------------------------------
	sFind = "nflight_number= "+string(lFlightNumber )+" and "
	sFind += "csuffix = '"+sSuffix+"' and "
	sFind += "ctlc_from='"+sTLCFrom+"' and "
	sFind += "ctlc_to='"+sTLCTo+"' and "
	sFind += "nleg_number =1"
	
	lFound = dsCenOutNotRegenerate.find( sFind,1,dsCenOutNotRegenerate.RowCount())

	if lFound > 0 and  not bCFSCheckOnly then	
		of_trace("of_generate_flights_cfs", 1,"Flight found in NotToRegenerate Cache: " + string(lFlightNumber)+sSuffix+" Leg 1 " +sTLCFrom+"-"+sTLCTo)
		continue
	end if
	
	dsExtCatSchedTemp.setfilter("ncat_group_key = "+string(lFlightGroup))	
	dsExtCatSchedTemp.filter()
	dsExtCatSchedTemp.sort()
	
	lfound=0
	
	lCFSGroupkey=0
	k=0
	for xx=1 to 2
		if xx=1 then
			sFind = "nflight_number= "+string(dsExtCatSchedTemp.getitemnumber(1,"nflight_number"))+" and "
			if isnull(dsExtCatSchedTemp.getitemString(1,"csuffix")) then
				sFind += "(trim(csuffix) = '' or isnull(csuffix)) and "
			elseif trim(dsExtCatSchedTemp.getitemString(1,"csuffix"))="" then
				sFind += "(csuffix = '"+dsExtCatSchedTemp.getitemString(1,"csuffix")+"' or isnull(csuffix)) and "
			else
				sFind += "csuffix = '"+dsExtCatSchedTemp.getitemString(1,"csuffix")+"' and "
			end if
			sFind += "ctlc_from='"+dsExtCatSchedTemp.getitemString(1,"ctlc_from")+"' and ctlc_to = '"
			sFind += dsExtCatSchedTemp.getitemString(1,"ctlc_to")+"' and nleg_number =1"
		else
			sFind = "ctlc_from='"+dsExtCatSchedTemp.getitemString(1,"ctlc_from")+"' and ctlc_to = '"
			sFind += dsExtCatSchedTemp.getitemString(1,"ctlc_to")+"' and nflight_number = -1 and nleg_number =1"
		end if			
		
		lRow=1
		
		do
			lfound = dsGenerateRoutingPlan.find(sFind, lRow,  dsGenerateRoutingPlan.rowcount())
			
			if lfound <= 0 then
				if xx=2 then k=2
				exit
			end if
			
			k=1
	
			if dsExtCatSchedTemp.rowcount()=1 then  
				if lfound < dsGenerateRoutingPlan.rowcount() then
					//HR 07.01.2011 Auch der CFS_KEY muss mitgepr$$HEX1$$fc00$$ENDHEX$$ft werden
					if  dsGenerateRoutingPlan.getitemnumber(lfound,"nrouting_group_key") = dsGenerateRoutingPlan.getitemnumber(lfound +1 ,"nrouting_group_key") and &
						 dsGenerateRoutingPlan.getitemnumber(lfound,"ncfs_key") = dsGenerateRoutingPlan.getitemnumber(lfound +1 ,"ncfs_key") then
	
						k=0 //Mehrlegbeladung, dann wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
					else
						exit //LOOP-Schleife verlassen	
					end if
				else
					exit //LOOP-Schleife verlassen	
				end if
			end if
			
			lRow = lFound +1
			
			lCFSGroupkey =  dsGenerateRoutingPlan.getitemnumber(lfound,"nrouting_group_key")
			
			for j=2 to dsExtCatSchedTemp.rowcount()
				if lfound +j -1 >  dsGenerateRoutingPlan.rowcount() then // 24.05.2011 HR: > anstatt >=
					//Keinen weiteren Datensatz in der Beladedefinition, dann raus hier
					k=2
					exit //FOR-Schleife verlassen
				end if
				
				if isnull(dsGenerateRoutingPlan.getitemString(lfound +j -1 ,"csuffix")) then dsGenerateRoutingPlan.setitem(lfound +j -1 ,"csuffix"," ")
				
				if dsGenerateRoutingPlan.getitemnumber(lfound +j -1 ,"nrouting_group_key") <> lCFSGroupkey or &
					dsGenerateRoutingPlan.getitemString(lfound +j -1 ,"ctlc_from")<> dsExtCatSchedTemp.getitemString(j,"ctlc_from") or &
					dsGenerateRoutingPlan.getitemString(lfound +j -1 ,"ctlc_to") <> dsExtCatSchedTemp.getitemString(j,"ctlc_to") then
					//Neue Gruppe von Beladedefinition oder andere Streckenf$$HEX1$$fc00$$ENDHEX$$hrung, dann raus hier
					k=0
					exit //FOR-Schleife verlassen
				end if
	
				if  (dsGenerateRoutingPlan.getitemnumber(lfound +j -1 ,"nflight_number") = dsExtCatSchedTemp.getitemnumber(j,"nflight_number") and &
					dsGenerateRoutingPlan.getitemString(lfound +j -1 ,"csuffix") = dsExtCatSchedTemp.getitemString(j,"csuffix")) or &
					dsGenerateRoutingPlan.getitemnumber(lfound +j -1 ,"nflight_number") = -1 then
					
					k=1
				else
					//Andere Flugnummer und kein Citypair, dann raus hier
					k=0
					exit //FOR-Schleife verlassen
				end if
			next
			if k >= 1 then exit //Loop-Schleife verlassen
		loop until 1=2		
		
		if k = 1 then exit //For-Schleife verlassen
	next		
	
	if k=1 then
		//Stammdaten gefunden, dann Fl$$HEX1$$fc00$$ENDHEX$$ge anlegen	
		for j=1 to dsExtCatSchedTemp.rowcount()
			if bCFSCheckOnly then
				k= dsExtCatSched.find("next_cat_key = "+string(dsExtCatSchedTemp.GetItemNumber(j,"next_cat_key")), 1, dsExtCatSched.rowcount())
				if k>0 then
				 	dsExtCatSched.setitem(k,"nfind_loading",1) 
				end if 
			else
				// 15.06.2012 HR: Wir setzen das R$$HEX1$$fc00$$ENDHEX$$ckflugdatum anhand des Offsets des R$$HEX1$$fc00$$ENDHEX$$ckfluges
				//dReturnFlightDate 		= dGenerationDate		// R$$HEX1$$fc00$$ENDHEX$$cksetzen ReturnFlightDate
				//dReturnFlightDate 		= relativedate(dGenerationDate,  dsExtCatSchedTemp.Getitemnumber(j,"noffset_days"))
				
				of_set_cen_out(dsExtCatSchedTemp.GetItemNumber(j,"nschedrow"), lfound +j -1)
				//27.03.2015 HR Wir setzen das Datum immer auf CFS-Vorgabe
				dReturnFlightDate 		= relativedate(dGenerationDate,  dsExtCatSchedTemp.Getitemnumber(j,"noffset_days"))

				dNewGenerationDate 	= dReturnFlightDate 				// 15.06.2012 HR: Wir setzen das R$$HEX1$$fc00$$ENDHEX$$ckflugdatum anhand des Offsets des R$$HEX1$$fc00$$ENDHEX$$ckfluges
				sSuffix					= dsExtCatSchedTemp.Getitemstring(j,"csuffix")
				lFlightNumber 			= dsExtCatSchedTemp.Getitemnumber(j,"nflight_number")
				sTLCFrom				= dsExtCatSchedTemp.Getitemstring(j,"ctlc_from")
				sTLCTo					= dsExtCatSchedTemp.Getitemstring(j,"ctlc_to")
				lTLCFrom				= dsGenerateRoutingPlan.Getitemnumber(lfound +j -1,"ntlc_from")
				lTLCTo					= dsGenerateRoutingPlan.Getitemnumber(lfound +j -1,"ntlc_to")		
				lFlightLegs 				= dsExtCatSchedTemp.rowcount()
				lLegNumber				= dsExtCatSchedTemp.Getitemnumber(j,"nleg_number")
				sLoadingUnit			= dsGenerateRoutingPlan.Getitemstring(lfound +j -1,"cen_routingplan_cunit")
				iMLFlight 				= 0
				lCurrentGroupKey 		= dsGenerateRoutingPlan.Getitemnumber(lfound +j -1,"nrouting_group_key")
	
				if lLegNumber=1 then
					cdeparture_vorleg	=""
					dt_dep_vorleg 		= datetime(date("01.01.2000"),time("00:01"))
					dt_arr_vorleg 		= datetime(date("01.01.2000"),time("00:01")) //21.11.2011 HR
				end if
		
				of_trace("of_generate_flights_cfs", 50,"processing flight " + string(lFlightNumber) + ", nrouting_group_key = " + string(lCurrentGroupKey))
	
				lLegNumber				= dsExtCatSchedTemp.Getitemnumber(j,"nleg_number")
				
				// --------------------------------------------------------------------------------------------------------------------
				// 01.09.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r Z$$HEX1$$fc00$$ENDHEX$$ge m$$HEX1$$fc00$$ENDHEX$$ssen wir ggf. die Abfertigungsart aus der CFS-Tabelle nehmen
				// --------------------------------------------------------------------------------------------------------------------
				if dsExtCatSchedTemp.Getitemstring(j,"chandling_type_text") > " " then
					of_get_handling_from_text(dsExtCatSchedTemp.Getitemstring(j,"chandling_type_text"))
				end if
				
				if ib_CFSWithoutFlightplan then
					nDepartureFaktor 	= 99
					nArrivalFaktor 		= 99
				end if
				// --------------------------------------------------------------------------------------------------------------------
				// 15.03.2012 HR: Bei Citypair muss der Aufruf mit TRUE erfolgen 
				// --------------------------------------------------------------------------------------------------------------------
				if  dsGenerateRoutingPlan.Getitemnumber(lfound +j -1,"nflight_number")= -1 then
					of_write_cen_out(TRUE)
				else
					of_write_cen_out(False)
				end if
			end if
		next
	else
         sfind = ""
         for j=1 to dsExtCatSchedTemp.rowcount()
            sfind += string(dsExtCatSchedTemp.Getitemnumber(j,"nflight_number"))+ " "+dsExtCatSchedTemp.Getitemstring(j,"ctlc_from")+"-"+dsExtCatSchedTemp.Getitemstring(j,"ctlc_to")+" | "
         next
         of_trace("of_generate_flights_cfs", 50,"Not Found in Loadingdefinition: "+sfind)
	end if
next
of_trace_flight("of_generate_flights_cfs","finish finding Flights") // 21.06.2012 HR: Ausgabe unabh$$HEX1$$e400$$ENDHEX$$ngig vom Tracelevel einschaltbar
if bCFSCheckOnly then
	if ii_Debug_Save =1 then dsExtCatSched.saveas(is_Debug_save_path+"of_generate_flights_cfs_6_dsExtCatSched_nach_verarbeitung"+string(now(),"hhmmss")+".xls", excel5!, true)
end if

destroy dsExtCatSchedTemp
// 19.02.2016 HR: CBASE-DE-CR-2015-059 Faktorermittlung wieder raus da neue Funktion zur Berechnung
//destroy lds_utc // 16.04.2015 HR:

garbagecollect()

return true
end function

public function long of_search_cfs_flight (datastore arg_ds, long arg_row);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_search_cfs_flight (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// datastore arg_ds
//  long arg_row
// --------------------------------------------------------------------------------------------------------------------
// Return: long
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Sucht den $$HEX1$$fc00$$ENDHEX$$bergebenen Flug im Flugplan und liefert die
//					  Zeilennummer zur$$HEX1$$fc00$$ENDHEX$$ck oder 0
// Es wird momentan davon ausgegangen, das CFS und Flugplan die 
// gleiche Zeit haben (beide Lokalzeit oder UTC)
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  07.10.2010	1.0   	H.Rothenbach	Erstellung
//  30.01.2012 	1.1	HR 				Wir m$$HEX1$$fc00$$ENDHEX$$ssen uns auch den ggf. ge$$HEX1$$e400$$ENDHEX$$nderten ACTYPE merken//
//  11.06.2012	1.2	HR					Bei OhneFlugplan suchen wir anders nach dem Flug
//  15.04.2015  1.3	HR					Bei OhneFlugplan und Dummyflug versuchen wir die Flugdaten doch vom Flugplan zu holen
// --------------------------------------------------------------------------------------------------------------------
string 		ls_find, ls_actype_new, ls_configuration_sky, ls_airline_owner_sky, ls_actype, ls_configuration, ls_galleyversion
long 			lrow, i, ll_airlineownerkey, ll_aircraft_key
date 			ld_departure
integer   		li_freq
datastore	lds

lrow=0

for i=0 to 3 
	// 26.05.2011 HR: 1. Leg muss am aktuellen Tag sein
	if arg_ds.GetItemNumber(arg_row, "nleg_number")=1 and i>0 then continue
	
	ld_departure 		=  relativedate(date(arg_ds.GetItemDatetime(arg_row, "ddeparture")),i)
	li_freq 				= f_getfrequence(ld_departure)
	
	// --------------------------------------------------------------------------------------------------------------------
	// 11.06.2012 HR: Wenn wir ohne Flugplan generieren, dann brauchen wir auch nicht nach dem Flug 
	//                        suchen, sondern k$$HEX1$$f600$$ENDHEX$$nnen direkt den CFS-Flug-Schl$$HEX1$$fc00$$ENDHEX$$ssel benutzen.
	// --------------------------------------------------------------------------------------------------------------------
	if ib_CFSWithoutFlightplan then
		ls_find = "nschedule_key = "+String(arg_ds.GetItemnumber(arg_row, "next_cat_key"))
	else
		ls_find = "nflight_number = "+string(arg_ds.GetItemNumber(arg_row, "nflight_number"))
		ls_find +=" and csuffix = '"+f_check_null(arg_ds.GetItemString(arg_row, "csuffix"))+"'"
		ls_find +=" and date(ddvalid_from) <= date('"+string(ld_departure, "yyyy-mm-dd")+"')"        
		ls_find +=" and date(ddvalid_to) >=  date('"+string(ld_departure, "yyyy-mm-dd")+"')"
		ls_find +=" and ntlc_from = "+string(f_get_tlc_number(arg_ds.GetItemString(arg_row, "ctlc_from")))
		ls_find +=" and ntlc_to = "+string(f_get_tlc_number(arg_ds.GetItemString(arg_row, "ctlc_to")))
		ls_find +=" and nfreq" + string(li_freq) + "=1"   
		
		if i=0 then
			ls_find += " and cdeparture_time > '"+cdeparture_vorleg+"'"
		end if
	end if	
	
	lrow = dsGenerateSchedule.find(ls_find , 1, dsGenerateSchedule.rowcount())
	
	if lrow=0 and ib_CFSWithoutFlightplan and arg_ds.GetItemnumber(arg_row, "next_cat_key") < 0 then
		// --------------------------------------------------------------------------------------------------------------------
		// 15.04.2015 HR: Bei der DUMMY-CFS-Generierung ohne Flugplan m$$HEX1$$fc00$$ENDHEX$$ssen wir versuchen die ben$$HEX1$$f600$$ENDHEX$$tigten 
		//                        Daten aus dem Flugplan zu holen
		// --------------------------------------------------------------------------------------------------------------------
		lds = create datastore
		lds.dataobject="dw_generate_schedule_dummyflight"
		lds.settransobject(SQLCA)
		lds.setfilter("cen_schedule_nfreq" + string(li_freq) + "=1")
		lds.retrieve(lAirlineKey, ld_departure, arg_ds.GetItemNumber(arg_row, "nflight_number"))
		
		if lds.rowcount()>0 then
			lrow = dsGenerateSchedule.insertrow(0)

			dsGenerateSchedule.setitem(lrow, "ddvalid_from", 							ld_departure)
			dsGenerateSchedule.setitem(lrow, "ddvalid_to", 								ld_departure)
			dsGenerateSchedule.setitem(lrow, "ndate_offset", 							0)
			dsGenerateSchedule.setitem(lrow, "sky_ext_cat_sched_noffset_days",	0)			
			dsGenerateSchedule.setitem(lrow, "nfreq1", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq2", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq3", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq4", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq5", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq6", 									1)
			dsGenerateSchedule.setitem(lrow, "nfreq7", 									1)
			dsGenerateSchedule.setitem(lrow, "cblock_time", 								" ")

			dsGenerateSchedule.setitem(lrow, "nschedule_index", 		arg_ds.getitemnumber(arg_row, "ncat_key"))
			dsGenerateSchedule.setitem(lrow, "nschedule_key", 			arg_ds.getitemnumber(arg_row, "next_cat_key"))
			dsGenerateSchedule.setitem(lrow, "cen_airlines_cairline",	arg_ds.getitemstring(arg_row, "cairline"))
			dsGenerateSchedule.setitem(lrow, "nflight_number", 			arg_ds.getitemnumber(arg_row, "nflight_number"))
			dsGenerateSchedule.setitem(lrow, "csuffix", 					arg_ds.getitemstring(arg_row, "csuffix"))
			dsGenerateSchedule.setitem(lrow, "nleg_number",			arg_ds.getitemnumber(arg_row, "nleg_number"))
			dsGenerateSchedule.setitem(lrow, "nairline_key", 				f_get_airline_key(arg_ds.getitemstring(arg_row, "cairline")))
			dsGenerateSchedule.setitem(lrow, "nowner_id", 				f_get_airline_key(arg_ds.getitemstring(arg_row, "cairline")))
			//dsGenerateSchedule.setitem(lrow, "sky_ext_cat_sched_ncat_group_key", 		arg_ds.getitemstring(arg_row, ""))

			dsGenerateSchedule.setitem(lrow, "cdeparture_time", 		lds.getitemstring(1, "cen_schedule_cdeparture_time"))
			dsGenerateSchedule.setitem(lrow, "naircraft_key", 			lds.getitemnumber(1, "cen_schedule_naircraft_key"))
			dsGenerateSchedule.setitem(lrow, "ndeparture_faktor", 		lds.getitemnumber(1, "cen_schedule_ndeparture_faktor"))
			dsGenerateSchedule.setitem(lrow, "ntlc_from", 				lds.getitemnumber(1, "cen_schedule_ntlc_from"))
			dsGenerateSchedule.setitem(lrow, "ntlc_to", 					lds.getitemnumber(1, "cen_schedule_ntlc_to"))
			dsGenerateSchedule.setitem(lrow, "cairline_owner", 			lds.getitemstring(1, "cen_airlines_cairline"))
			dsGenerateSchedule.setitem(lrow, "cconfiguration", 			lds.getitemstring(1, "cconfig"))
			dsGenerateSchedule.setitem(lrow, "cactype", 					lds.getitemstring(1, "cen_aircraft_cactype"))
			dsGenerateSchedule.setitem(lrow, "nairline_owner_key",	lds.getitemnumber(1, "cen_aircraft_nairline_owner_key"))
			dsGenerateSchedule.setitem(lrow, "cgalleyversion", 			lds.getitemstring(1, "cen_aircraft_cgalleyversion"))
		end if
		
		destroy lds
	end if
	
	if lrow > 0 then 
		cdeparture_vorleg =  dsGenerateSchedule.getitemstring(lrow,"cdeparture_time")
		
		// --------------------------------------------------------------------------------------------------------------------
		// 12.10.2011 HR: Bei der Generierung ohne Flugplan, muss hier noch der 
		//                           nairline_key ermittelt werden
		// --------------------------------------------------------------------------------------------------------------------
		if  dsGenerateSchedule.getitemnumber(lrow,"naircraft_key")=0 then
			// 28.11.2011 HR: 
			ls_airline_owner_sky  = dsGenerateSchedule.getitemstring(lrow,"cairline_owner")
			ls_configuration_sky  	= dsGenerateSchedule.getitemstring(lrow,"cconfiguration") 
			ls_actype 				= dsGenerateSchedule.getitemstring(lrow,"cactype")
			//ll_airlineownerkey 		= dsGenerateSchedule.getitemnumber(lrow,"nairline_owner_key")
			
			SELECT 	cen_aircraft.naircraft_key,   
						cen_aircraft.cactype, 
						cen_aircraft.cconfiguration,   
						cen_aircraft.cgalleyversion  
				INTO 	:ll_aircraft_key,   
						:ls_actype_new,
						:ls_configuration, 
						:ls_galleyversion
				FROM cen_aircraft  
				where cen_aircraft.naircraft_key in (				
					  	SELECT cen_aircraft_mapping.naircraft_key  
					 	FROM cen_aircraft_mapping  
						WHERE 	( cen_aircraft_mapping.caircraft_owner = :ls_airline_owner_sky ) AND  
									( cen_aircraft_mapping.caircraft_type = :ls_actype ) AND  
									( cen_aircraft_mapping.caircraft_version = :ls_configuration_sky ) ) ;

			if sqlca.sqlcode=0 then
				dsGenerateSchedule.setitem(lrow,"naircraft_key",ll_aircraft_key)
				dsGenerateSchedule.setitem(lrow,"cgalleyversion",  ls_galleyversion)
				dsGenerateSchedule.setitem(lrow,"cactype",  ls_actype_new) //30.01.2012 HR Wir m$$HEX1$$fc00$$ENDHEX$$ssen uns auch den ggf. ge$$HEX1$$e400$$ENDHEX$$nderten ACTYPE merken
			else
				// 04.04.2014 HR: Traceausgabe erweitert
				ls_find = string(arg_ds.GetItemNumber(arg_row, "nflight_number"))
				ls_find += f_check_null(arg_ds.GetItemString(arg_row, "csuffix"))
				ls_find += " "+arg_ds.GetItemString(arg_row, "ctlc_from")
				ls_find += " - "+arg_ds.GetItemString(arg_row, "ctlc_to")

				// --------------------------------------------------------------------------------------------------------------------
				// 28.09.2015 HR: Fehler nicht nur ins LOG-File sondern auch ins DB-Generierungslog eintragen
				// --------------------------------------------------------------------------------------------------------------------
				//of_trace("of_search_cfs_flight", 1,"Flight "+ls_find+" found no CBASE-AC-Type for AC " + ls_airline_owner_sky+" "+ls_actype+" Configuration: "+ ls_configuration_sky )				
				of_write_protocol(iJob_Type,iGenerierungsstatus,2,iWarnung,arg_ds.getitemstring(arg_row, "cairline") + " " + string(arg_ds.getitemnumber(arg_row, "nflight_number")) + arg_ds.getitemstring(arg_row, "csuffix"),&
					string(ld_departure, s_app.sDateformat),&
					"Found no CBASE-AC-Type for AC " + ls_airline_owner_sky+" "+ls_actype+" Configuration: "+ ls_configuration_sky)
				return 0
			end if
		end if
		
		exit
	end if
next

return lrow
end function

public function boolean of_use_owner_for_trafficarea (string as_client, long al_airline_key);/*
* Objekt : uo_generate
* Methode: of_use_owner_for_trafficarea (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 17.11.2010
*
* Argument(e):
*    string as_client
*    long al_airline_key
*
* Beschreibung:      Schalter zur Ermittlung der Traffic Areas (ueber AC Owner statt Airline)
*
* Aenderungshistorie:
* Version       Wer         Wann         Was und warum
* 1.0          O.Hoefer   17.11.2010      Erstellung
*
*
* Return: boolean
*
*/


Boolean      lb_Ret
Long         ll_Rows
Long         ll_Setting
DataStore   lds_Airline


lds_Airline   = CREATE DataStore
lds_Airline.DataObject = "dw_use_owner4trafficarea" //"dw_airlines_detail"
lds_Airline.SetTransObject(SQLCA)


ll_rows = lds_Airline.Retrieve(as_client, al_airline_key )

If ll_Rows > 0 Then
   ll_Setting = lds_Airline.GetItemNumber( 1, "nuse_owner_for_traffic")
   
   If ll_Setting = 1 Then
      lb_Ret = TRUE
   Else
      lb_Ret = FALSE
   End If
Else
   lb_Ret = FALSE
End If

// 20.06.2012 HR:
destroy lds_Airline
garbagecollect()

Return lb_Ret

end function

public function integer of_check_cfs_flights (long arg_lairline_key, date arg_ddeparture);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_check_cfs_flights (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_lairline_key
//  date arg_ddeparture
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
//  01.12.2010	   1.0      H.Rothenbach   Erstellung
//	02.12.2010	   1.1		M.Barfknecht	lAirlinekey erg$$HEX1$$e400$$ENDHEX$$nzt
//	03.11.2015	   1.2		Oliver H$$HEX1$$f600$$ENDHEX$$fer   Flugplan ermitteln CBASE-BRU-EM-15001 Comparison bei Airline ohne Flugplan
// --------------------------------------------------------------------------------------------------------------------

string ls_GenerateRoutingPlan
long i, j

//Erst mal ein paar Parameter f$$HEX1$$fc00$$ENDHEX$$llen
this.bCFSCheckOnly	= true
this.ii_delete_flights 	= 0
this.dGenerationDate	= arg_ddeparture
this.sAirline				= f_get_airline_name(arg_lairline_key)
this.lAirlineKey			= arg_lairline_key
this.bSendMessage	= false

//this.idebug_level =1000

// --------------------------------------------------------------------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Streckenplan ermitteln und das Charter- und CFS-Flag setzen
// --------------------------------------------------------------------------------------------------------------------
lRoutingPlanKey = of_get_routingplan_key()
If lRoutingPlanKey = -1 Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"No valid loading definition key available.")
	return 0
End if	

// --------------------------------------------------------------------------------------------------------------------
// den Key f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Flugplan ermitteln
// --------------------------------------------------------------------------------------------------------------------
// 23.11.2015 HR: Falls wir ohne Flugplan generieren, dann ist das kein Abbruchkriterium, wenn wir
//                        keinen g$$HEX1$$fc00$$ENDHEX$$ltigen Flugplan finden
// --------------------------------------------------------------------------------------------------------------------
lScheduleKey = of_get_schedule_key()
If lScheduleKey = -1 and ib_CFSWithoutFlightplan = false Then
	of_write_protocol(iJob_Type,iGenerierungsstatus,1,iFehler,sAirline,string(dGenerationDate,s_app.sDateformat),"No valid flight schedule key available.")
	return 0
End if	

ls_GenerateRoutingPlan = dsGenerateRoutingPlan.dataobject 

// 13.01.2012 HR: Neues Datawindow ohne Einschr$$HEX1$$e400$$ENDHEX$$nkung des Betriebs
//dsGenerateRoutingPlan.dataobject = "dw_generate_routingplan_cfs"
dsGenerateRoutingPlan.dataobject = "dw_generate_routingplan_cfs_all"
dsGenerateRoutingPlan.settransobject(SQLCA)

	// --------------------------------------------------------------------------------------------------------------------
	// 01.07.2013 HR: Sollte ohne Flugplan generiert werden, dann nehmen
	//                           wir ein Flugplandatawindow aus den CFS-Daten
	// --------------------------------------------------------------------------------------------------------------------
	if ib_CFSWithoutFlightplan then
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_cfs"
	else
		dsGenerateSchedule.DataObject 	= "dw_generate_schedule_all"
	end if
//	dsGenerateSchedule.DataObject 		= "dw_generate_schedule_all"

dsGenerateSchedule.SetTransObject(SQLCA)

of_generate_flights_cfs()

// --------------------------------------------------------------------------------------------------------------------
// 13.01.2012 HR: Hier m$$HEX1$$fc00$$ENDHEX$$ssen wir noch das Beladungkennzeichen vom
//					   1. Leg auf die folgelegs $$HEX1$$fc00$$ENDHEX$$bertragen
// --------------------------------------------------------------------------------------------------------------------
dsExtCatSched.setfilter("")
dsExtCatSched.filter()
dsExtCatSched.sort()

for i = 1 to dsExtCatSched.rowcount()
	for j=i to dsExtCatSched.rowcount()
		if dsExtCatSched.getitemnumber(j,"ncat_group_key") = dsExtCatSched.getitemnumber(i,"ncat_group_key") then
			dsExtCatSched.setitem(j,"nfind_loading", dsExtCatSched.getitemnumber(i,"nfind_loading"))
		end if
	next
next

if ii_Debug_Save =1 then dsExtCatSched.saveas(is_Debug_save_path+"of_check_cfs_flights_dsExtCatSched_nach_verarbeitung"+string(now(),"hhmmss")+".xls", excel5!, true)
	
dsGenerateRoutingPlan.dataobject = ls_GenerateRoutingPlan
dsGenerateRoutingPlan.settransobject(SQLCA)	

dsGenerateSchedule.DataObject 		= "dw_generate_schedule"
dsGenerateSchedule.SetTransObject(SQLCA)

return 1
end function

public function string of_get_airline_from_key (long arg_airline_key);
// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_airline_from_key (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_airline_key
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  10.01.2011	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string a

SELECT cen_airlines.cairline
 INTO :a
 FROM cen_airlines  
WHERE cen_airlines.nairline_key = :arg_airline_key;

if sqlca.sqlcode = 0 then
	
elseif sqlca.sqlcode = 100 then
	a =  "N/A"
else
	a = "N/A"
end if
	
return a
end function

public function integer of_get_packet_handling (long arg_row, long arg_result_key, long arg_result_key_group);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_packet_handling (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_row
//  long arg_result_key
//  long arg_result_key_group
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  06.05.2011	1.0      H.Rothenbach   Erstellung
//  30.01.2012 	1.1	  HR 				  Tracelevel-Nr f$$HEX1$$fc00$$ENDHEX$$r Ausgabe erh$$HEX1$$f600$$ENDHEX$$ht
// --------------------------------------------------------------------------------------------------------------------

datastore 	lds_handling_types
datastore 	lds_handling_all
long			lfind, l1, l2, l3, l4 , lfound
string 		sFind, ls_flight, ls_type, ls_error

ls_flight = sAirline+string(lFlightNumber,"0000")+sSuffix+" "+sTLCFrom+sTLCTo
if ib_check_packets_handling then is_check_packets_handling +="Check for Flight: " + ls_flight

lds_handling_types = create datastore
lds_handling_types.dataobject = "dw_generate_handling_types"
lds_handling_types.settransobject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 24.06.2014 HR: CBASE-NAM-CR-14019: Unterscheidung der Handlingtypen nach Single oder Multileg
// --------------------------------------------------------------------------------------------------------------------
if  dsCenOut.getitemnumber(arg_row,"nleg_number") > 1 then
	l1 = lds_handling_types.setfilter("nmulti = 1")
	ls_type = "Multi-Leg-Flight"
else
	l1 = lds_handling_types.setfilter("nsingle = 1")
	ls_type = "Single-Leg-Flight"
end if

if ib_check_packets_handling then is_check_packets_handling += " ("+ls_type+")"
l1 = lds_handling_types.filter()

l1=lds_handling_types.retrieve(lairlinekey, dNewGenerationDate)

if lds_handling_types.rowcount()=0 then 
	of_trace("of_get_packet_handling", 5,""+ls_flight+": No HandlingTypes found for "+ls_type)

	if ib_check_packets_handling then is_check_packets_handling += "~r~nNo HandlingTypes found for "+ls_type
	
	destroy lds_handling_types
	return 0
end if

dsCenOutPackets.setfilter("NRESULT_KEY_GROUP = "+string(arg_result_key_group))
dsCenOutPackets.filter()

if dsCenOutPackets.rowcount()=0 then 
	of_trace("of_get_packet_handling", 5,""+ls_flight+": No FlightPackets found")
	
	if ib_check_packets_handling then is_check_packets_handling += "~r~nNo Flight-Packets found"
	
	dsCenOutPackets.setfilter("")
	dsCenOutPackets.filter()

	destroy lds_handling_types
	return 0
end if

of_trace("of_get_packet_handling", 10,""+ls_flight+": FlightPackets for all Legs: "+string(dsCenOutPackets.rowcount()))

if ib_check_packets_handling then is_check_packets_handling += "~r~nFlightPackets for all Legs: "+string(dsCenOutPackets.rowcount())

dsCenOutLos.setfilter("NRESULT_KEY_GROUP = "+string(arg_result_key_group))
dsCenOutLos.filter()

if dsCenOutLos.rowcount()=0 then 
	of_trace("of_get_packet_handling", 5,""+ls_flight+": No FlightLOS found")
	if ib_check_packets_handling then is_check_packets_handling += "~r~nNo Flight-LOS found"
	
	dsCenOutPackets.setfilter("")
	dsCenOutPackets.filter()
	dsCenOutLos.setfilter("")
	dsCenOutLos.filter()

	destroy lds_handling_types
	return 0
end if

lds_handling_all = create datastore
lds_handling_all.dataobject="dw_generate_handling_abartzuord"
lds_handling_all.settransobject(SQLCA)

for l1=1 to lds_handling_types.rowcount()
	lfind = -1
	
//	if  lds_handling_types.Getitemstring(l1,"ctext") = 'M' then
//		l2=1
//	end if
	
	for l2 = 1 to dsCenOutLos.rowcount()
		l3=dsCenOutPackets.setfilter("NRESULT_KEY_GROUP = "+string(arg_result_key_group)+" and cpacket_class = '"+dsCenOutLos.getitemstring(l2,"clos_class")+"' and nleg_number = "+string(dsCenOutLos.getitemnumber(l2,"nleg_number")))
		dsCenOutPackets.filter()
		
		for l3=1 to 2
			if l3 =1 then
				// 07.07.2014 HR: CBASE-NAM-CR-14019: Wir lesen zuerst, damit wir hier das EMTY-Package finden k$$HEX1$$f600$$ENDHEX$$nnen
				lds_handling_all.retrieve(lairlinekey,dNewGenerationDate,  dsCenOutLos.getitemnumber(l2,"nleg_number"), lds_handling_types.Getitemnumber(l1,"nhandling_type_key"),dsCenOutLos.getitemstring(l2,"clos_class"),1,0)

				//Wenn beim Include der Flug keine Pakete f$$HEX1$$fc00$$ENDHEX$$r die Klasse hat, dann zum n$$HEX1$$e400$$ENDHEX$$chsten Schleifenwert
				if dsCenOutPackets.rowcount()=0 then 
					if lds_handling_all.rowcount()>0 then
						// 07.07.2014 HR: CBASE-NAM-CR-14019: Wenn Leg/Klasse keine Packages hat, dann kann immer noch das neu EMPTY-Package
						//                                                           greifen und dadurch die Bedingung als erf$$HEX1$$fc00$$ENDHEX$$llt gilt.
						if isnull( lds_handling_all.getitemstring(1,"cpacket_group")) then
							if lds_handling_all.find("npacket_key = -2", 1, lds_handling_all.rowcount())>0 then
								lfind=1
							end if
						else
							if lds_handling_all.find("npacket_group_key = -2", 1, lds_handling_all.rowcount())>0 then
								lfind=1
							end if
						end if
					end if					
					continue
				end if
				
			else
				lds_handling_all.retrieve(lairlinekey,dNewGenerationDate,  dsCenOutLos.getitemnumber(l2,"nleg_number"), lds_handling_types.Getitemnumber(l1,"nhandling_type_key"), dsCenOutLos.getitemstring(l2,"clos_class"),0,1)
			end if
	
			//Wenn wir keine Pakete f$$HEX1$$fc00$$ENDHEX$$r die Abfertigung/Klasse/Verwendungsart haben, dann zum n$$HEX1$$e400$$ENDHEX$$chsten Schleifenwert
			if lds_handling_all.rowcount()=0 then continue
			
			//Pakete des Fluges als nicht gefunden markieren
			for l4 =1 to dsCenOutPackets.rowcount()
				dsCenOutPackets.setitem(l4,"nfound",0)
			next
			
			for l4=1 to lds_handling_all.rowcount()
				if isnull( lds_handling_all.getitemstring(l4,"cpacket_group")) then
					// 01.03.2013 HR: Filter-Felder korrigiert 
					sFind = "cpacket ='"+lds_handling_all.getitemstring(l4,"cpackage")+"' and "
					sFind += "cpacket_var ='"+lds_handling_all.getitemstring(l4,"cvariation")+"'"
				else
					sFind = "cpacket_group_code ='"+lds_handling_all.getitemstring(l4,"cpacket_group")+"'"
				end if
				
				lfound=dsCenOutPackets.find(sFind,1,dsCenOutPackets.rowcount())
				
				if lfound > 0 then
					lds_handling_all.setitem(l4,"nfound",1)
					dsCenOutPackets.setitem(lfound,"nfound",1)
				end if
			next	
	
			if l3 =1 then //Include
				// --------------------------------------------------------------------------------------------------------------------
				// 07.07.2014 HR: CBASE-NAM-CR-14019: Es gibt jetzt 3 Zust$$HEX1$$e400$$ENDHEX$$nde (Exakt/Alle/Jedes)
				// --------------------------------------------------------------------------------------------------------------------
				choose case lds_handling_all.getitemnumber(1,"nall")
					case 0  //Exact ist ausgew$$HEX1$$e400$$ENDHEX$$hlt
						if lds_handling_all.getitemnumber(1,"compute_found")=lds_handling_all.rowcount() and &
							dsCenOutPackets.getitemnumber(1,"compute_nfound") = dsCenOutPackets.rowcount() then

							lfind=1
						else
							lfind=0
							ls_error = dsCenOutLos.getitemstring(l2,"clos_class") + " - Include - Excact" 
							exit
						end if

					case 1  //ALL ist ausgew$$HEX1$$e400$$ENDHEX$$hlt
						if lds_handling_all.getitemnumber(1,"compute_found")=lds_handling_all.rowcount()  then
							lfind=1
						else
							lfind=0
							ls_error = dsCenOutLos.getitemstring(l2,"clos_class") + " - Include - All" 
							exit
						end if

					case 2
					  	//ANY ist ausgew$$HEX1$$e400$$ENDHEX$$hlt
						if lds_handling_all.getitemnumber(1,"compute_found")>0  then
							lfind=1
						else
							lfind=0
							ls_error = dsCenOutLos.getitemstring(l2,"clos_class") + " - Include - Any" 
							exit
						end if
				end choose
				
			else
				//Exclude
				if lds_handling_all.getitemnumber(1,"compute_found")=0 then
					lfind=1
				else
					lfind=0
					ls_error = dsCenOutLos.getitemstring(l2,"clos_class") + " - Exclude" 
					exit
				end if
			end if
		next
		
		//Kritieren nicht voll erf$$HEX1$$fc00$$ENDHEX$$llt, dann zur n$$HEX1$$e400$$ENDHEX$$chsten Abfertigungsart
		if lfind=0 then 
			of_trace("of_get_packet_handling", 10,""+ls_flight+": "+ lds_handling_types.Getitemstring(l1,"ctext")+" not possible.")
			if ib_check_packets_handling then 
				is_check_packets_handling += "~r~n"+ lds_handling_types.Getitemstring(l1,"ctext")+" ("+lds_handling_types.Getitemstring(l1,"cdescription")+") not possible"
				is_check_packets_handling += ": "+ls_error
			end if
			exit
		end if
	next
	
	//Kritieren der Abfertigungsart alle erf$$HEX1$$fc00$$ENDHEX$$llt, dann Parameter der Abfertigungsart $$HEX1$$fc00$$ENDHEX$$bernehemen und raus hier
	if lfind=1 then
		lHandlingTypeKey		= lds_handling_types.Getitemnumber(l1,"nhandling_type_key")
		sHandlingShortText	= lds_handling_types.Getitemstring(l1,"ctext")
		sHandlingLongText		= lds_handling_types.Getitemstring(l1,"cdescription")
		of_trace("of_get_packet_handling", 5,""+ls_flight+": New Handling: "+ lds_handling_types.Getitemstring(l1,"ctext"))
		
		if ib_check_packets_handling then 
			is_check_packets_handling += "~r~n~r~nNew Handling found: "+ lds_handling_types.Getitemstring(l1,"ctext")+" ("+lds_handling_types.Getitemstring(l1,"cdescription")+")"
		else
			// 23.06.2014 HR: CBASE-NAM-CR-14019: $$HEX1$$dc00$$ENDHEX$$bernahme Abart in einen neue Funktion ausgelagert
			of_change_handling(arg_result_key_group, lHandlingTypeKey, sHandlingShortText, sHandlingLongText)
		end if		

		exit
	end if
next

if lfind <>1 then  
	lfind =0
	of_trace("of_get_packet_handling", 5,""+ls_flight+": No Handling found")
	if ib_check_packets_handling then is_check_packets_handling += "~r~nNo Handling found for Packages"
end  if

destroy lds_handling_all
destroy lds_handling_types

garbagecollect() // 20.06.2012 HR:

dsCenOutPackets.setfilter("")
dsCenOutPackets.filter()
dsCenOutLos.setfilter("")
dsCenOutLos.filter()

return lfind
end function

public function integer of_write_cen_out_packets_los (long arg_row, long arg_result_key, long arg_result_key_group);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_write_cen_out_packets_los (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_row
//  long arg_result_key
//  long arg_result_key_group
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  	Autor          		Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  06.05.2011	   1.0      H.Rothenbach   Erstellung
//  31.05.2012     1.1  	H.Rothenbach   richte Ermittlung der Packete/LOS
// --------------------------------------------------------------------------------------------------------------------
datastore lds
date ld_return
long i

// --------------------------------------------------------------------------------------------------------------------
// 31.05.2012 HR: Wir brauchen das genaue Flugdatum um die richtigen Packete/LOS zu finden, da nur
//                        $$HEX1$$fc00$$ENDHEX$$ber leg_nummber, abflug, offset der richtige Flug zu finden ist.
// --------------------------------------------------------------------------------------------------------------------
ld_return = date(dsCenOut.getitemdatetime(arg_row,"dreturn_date"))

lds = create datastore

// --------------------------------------------------------------------------------------------------------------------
// 04.04.2011 HR: Step 1: Packets
// --------------------------------------------------------------------------------------------------------------------
lds.dataobject="dw_cfs_flight_packets"
lds.settransobject(SQLCA)

// 31.05.2012 HR: ld_return eingebaut
// 25.07.2012 HR: dGenerationDate anstatt dNewGenerationDate
lds.retrieve(dGenerationDate, ld_return, sAirline, lFlightNumber, sSuffix, sTLCFrom, sTLCTo, lLegNumber, arg_result_key, arg_result_key_group, lAirlinekey)

if lds.rowcount()> 0 then
	i =  lds.rowscopy(1,lds.rowcount(),primary!,	dsCenOutPackets, 1, primary!)	
	if i<>1 then
		this.of_trace("of_write_cen_out_packets_los", 1, "error copy "+string(lds.rowcount())+" cfs-packets to flight")
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// 04.04.2011 HR: Step 2: LOS
// --------------------------------------------------------------------------------------------------------------------
lds.dataobject="dw_cfs_flight_los"
lds.settransobject(SQLCA)

// 31.05.2012 HR: ld_return eingebaut
// 25.07.2012 HR: dGenerationDate anstatt dNewGenerationDate
lds.retrieve(dGenerationDate, ld_return, sAirline, lFlightNumber, sSuffix, sTLCFrom, sTLCTo, lLegNumber, arg_result_key, arg_result_key_group)

if lds.rowcount()> 0 then
	i =  lds.rowscopy(1,lds.rowcount(),primary!,	dsCenOutLos, 1, primary!)	
	if i<>1 then
		this.of_trace("of_write_cen_out_packets_los", 1, "error copy "+string(lds.rowcount())+" cfs-los to flight")
	end if
end if

destroy lds
garbagecollect() // 20.06.2012 HR:

// --------------------------------------------------------------------------------------------------------------------
// 05.04.2011 HR: 	Jetzt schauen wir nochmal nach, ob wir f$$HEX1$$fc00$$ENDHEX$$r die Packete 
//						ein anderes Handling verwenden sollen
// --------------------------------------------------------------------------------------------------------------------
i = of_get_packet_handling(arg_row, arg_result_key, arg_result_key_group)
if i = 0 then
	// 06.11.2014 HR: CBASE-NAM-CR-14019: Wenn keine ABART gefunden wurde, dann pr$$HEX1$$fc00$$ENDHEX$$fen wir noch mal ob wir die ABART 
	of_change_handling(dsCenOut.GetItemNumber(arg_row, "nresult_key_group"),dsCenOut.GetItemNumber(arg_row, "nhandling_type_key"), dsCenOut.GetItemString(arg_row, "chandling_type_text"), dsCenOut.GetItemString(arg_row, "chandling_type_description"))
end if

return 1
end function

public function boolean of_get_cfspacket_check ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_cfspacket_check (Function)
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
//  18.05.2011	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

Long lCFSPacket

SELECT 	cen_routingplan_definition.NCFS_PACKETCLASS
  INTO 	:lCFSPacket
  FROM cen_routingplan_definition  
 WHERE ( cen_routingplan_definition.dvalid_from <= :dGenerationDate ) AND  
		 ( cen_routingplan_definition.dvalid_to   >= :dGenerationDate ) AND  
		 ( cen_routingplan_definition.nairline_key = :lAirlineKey ) ;

If sqlca.sqlcode = 0 then
	if lCFSPacket=1 then
		return true
	else
		return false
	end if 
Else
	return false
end if


end function

public function integer of_generate_ppm (long arg_row);Long 					lStart, lEnde, i
Long 					lrow, lrow_md, lrow_stow
Long					lPPMDetailKey, lPPMMDKey, LPPMStowageKey, ll_Resultkey
integer				iDay
integer 				iCounter
string					ls_unit, ls_mandant
datastore 			lds_pl_wksarea

lStart = CPU()

// Wenn PPM nicht gef$$HEX1$$fc00$$ENDHEX$$llt werden soll, dann raus hier
if ib_generate_ppmdata = false then 
	return 1
end if

if  dsCenOut.getitemnumber(arg_row,"nppm_lock")=1 then 
	this.of_trace("of_generate_ppm", 10, "NPPM_LOCK for Flight is set to 1")	
	return 1
end if

ll_Resultkey = dsCenOut.getitemnumber(arg_row,"nresult_key")

ls_unit 		= dsCenOut.getitemstring(arg_row,"cunit")
ls_mandant 	= dsCenOut.getitemstring(arg_row,"cclient")

lds_pl_wksarea = create datastore
lds_pl_wksarea.dataobject="dw_search_local_area_pl_assign"
lds_pl_wksarea.settransobject(SQLCA)

uo_flight_explosion		uo_loading4flight

uo_loading4flight = create uo_flight_explosion

// ---------------------------------------------------------------------
// Properties setzen
// dazu geh$$HEX1$$f600$$ENDHEX$$ren auch zwei Arrays mit den Keys der SSLs und ZBLs
// ---------------------------------------------------------------------
uo_loading4flight.dtDepartureDate	= dsCenOut.getitemdatetime(arg_row, "ddeparture")
uo_loading4flight.sDepartureTime	= dsCenOut.getitemstring(arg_row, "cdeparture_time")

iDay = daynumber(date(dsCenOut.getitemdatetime(arg_row, "ddeparture"))) -1
if iDay = 0 then iDay=7
uo_loading4flight.sVerkehrstag		= string(iDay)

// ---------------------------------------------------------------------
// das Array mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------	
iCounter = 0
dsCenOutHandling.setfilter("nresult_key = "+string( ll_Resultkey ))
dsCenOutHandling.filter()

for i=1 to dsCenOutHandling.rowcount()
	If dsCenOutHandling.Getitemnumber(i,"nhandling_id") = 1 Then
		if i>1 then
			if dsCenOutHandling.find("cloadinglist='"+dsCenOutHandling.GetitemString(i,"cloadinglist")+"'",1, i - 1)>0 then continue
		end if

		iCounter ++
		uo_loading4flight.lFirstArgRetrieve[iCounter] = dsCenOutHandling.Getitemnumber(i,"nloadinglist_index_key")		
	End if	
Next	

// ---------------------------------------------------------------------
// das Array mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For i = 1 to dsCenOutHandling.Rowcount()
	If dsCenOutHandling.Getitemnumber(i,"nhandling_id") = 2 Then
		iCounter ++
		uo_loading4flight.lSecondArgRetrieve[iCounter] = dsCenOutHandling.Getitemnumber(i,"nloadinglist_index_key")		
	End if	
Next	

dsCenOutHandling.setfilter("")
dsCenOutHandling.filter()

// Ermitteln der Beladung
if uo_loading4flight.uf_retrieve() <= 0 then
	of_trace("of_generate_ppm", 1,"Error uo_loading4flight.uf_retrieve(): " + dsCenOut.GetItemString(arg_row,"cairline") + " " + string(dsCenOut.GetItemNumber(arg_row,"nflight_number")) + " " + &
					" (key " + string(ll_ResultKey) + ") " )
	of_trace("of_generate_ppm", 1,"Error uo_loading4flight.uf_retrieve(): " + uo_loading4flight.sStatusText )
else
	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in ds_loginglist_result: "+string(uo_loading4flight.ds_loadinglist.rowcount()))	

	
	dsCenOutPPM.setfilter("nresult_key= "+string( ll_Resultkey ))
	dsCenOutPPM.filter()
	
	if dsCenOutPPM.rowcount()>0 then
		this.of_trace("of_generate_ppm", 3, ""+string(lFlightNumber,"0000")+sSuffix+": Delete  "+ string(dsCenOutPPM.rowcount())+" old rows")	

		for i = dsCenOutPPM.rowcount() to 1 step -1
			dsCenOutPPM.deleterow(i)
		next
	end if
	
	for i=1 to uo_loading4flight.ds_loadinglist.rowcount()
		lrow = dsCenOutPPM.insertrow(0)
		lPPMDetailKey = f_sequence("SEQ_CEN_OUT_PPM", SQLCA)
		dsCenOutPPM.setitem(lrow, "nppm_detail_key",				lPPMDetailKey)
		dsCenOutPPM.setitem(lrow, "nresult_key"	,					ll_Resultkey)
		dsCenOutPPM.setitem(lrow, "ntype",							uo_loading4flight.ds_loadinglist.getitemnumber(i,"npltype"))
		dsCenOutPPM.setitem(lrow, "cpackinglist",					uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_packinglist_index_cpackinglist"))
		dsCenOutPPM.setitem(lrow, "ctext",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_packinglists_ctext"))
		dsCenOutPPM.setitem(lrow, "cadd_on_text",					uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_loadinglists_cadd_on_text"))
		dsCenOutPPM.setitem(lrow, "cunit_of_issue",				uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_packinglists_cunit"))
		dsCenOutPPM.setitem(lrow, "npackinglist_index_key",		uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_packinglist_index_npackinglist_index_key"))
		dsCenOutPPM.setitem(lrow, "npackinglist_detail_key",		uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_packinglists_npackinglist_detail_key"))
		dsCenOutPPM.setitem(lrow, "nquantity",						uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_loadinglists_nquantity"))
		dsCenOutPPM.setitem(lrow, "nheight",							uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_object_equipment_nequipment_height"))
		dsCenOutPPM.setitem(lrow, "nwidth",							uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_object_equipment_nequipment_width"))
/*		dsCenOutPPM.setitem(lrow, "npltype_key",					uo_loading4flight.ds_loadinglist.getitem(i,""))
		dsCenOutPPM.setitem(lrow, "cpl_type",						uo_loading4flight.ds_loadinglist.getitem(i,"")) */
		dsCenOutPPM.setitem(lrow, "cclass",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_loadinglists_cclass"))
		dsCenOutPPM.setitem(lrow, "nclass_number",				uo_loading4flight.ds_loadinglist.getitemnumber(i,"nclass_number"))
		dsCenOutPPM.setitem(lrow, "npl_distribution_key",			uo_loading4flight.ds_loadinglist.getitemnumber(i,"ndistribution_key"))
		dsCenOutPPM.setitem(lrow, "cloadinglist",					uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_loadinglist_index_cloadinglist"))
		dsCenOutPPM.setitem(lrow, "nprint",							uo_loading4flight.ds_loadinglist.getitemnumber(i,"nprint"))
		dsCenOutPPM.setitem(lrow, "cmeal_control_code",			uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_loadinglists_cmeal_control_code"))
		dsCenOutPPM.setitem(lrow, "nlabel_type_key",				uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_packinglists_nlabel_type_key"))
		dsCenOutPPM.setitem(lrow, "nlabel_type",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"nlabel_type"))
		//dsCenOutPPM.setitem(lrow, "nlabel_counter",				uo_loading4flight.ds_loadinglist.getitemnumber(i,"pldetail_label_counter"))
		dsCenOutPPM.setitem(lrow, "nduplicated",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"nduplicated"))
		dsCenOutPPM.setitem(lrow, "nunit_priority",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"nunit_priority"))
		dsCenOutPPM.setitem(lrow, "ncompute_leg",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"compute_leg"))
		//dsCenOutPPM.setitem(lrow, "ncompute_next_leg",			uo_loading4flight.ds_loadinglist.getitem(i,""))
		dsCenOutPPM.setitem(lrow, "nseparator",						uo_loading4flight.ds_loadinglist.getitemnumber(i,"nseparator"))
		dsCenOutPPM.setitem(lrow, "nmodified",						uo_loading4flight.ds_loadinglist.getitemnumber(i,"nmodified"))
		dsCenOutPPM.setitem(lrow, "ngalley_group",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"ngalley_group"))

		// --------------------------------------------------------------------------------------------------------------------
		// 14.03.2012 HR: zus$$HEX1$$e400$$ENDHEX$$tzliche Felder f$$HEX1$$fc00$$ENDHEX$$llen
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutPPM.setitem(lrow, "cprod_time",						dsCenOut.getitemstring(arg_row,"ckitchen_time"))
		if dsCenOut.getitemstring(arg_row,"ckitchen_time") <= dsCenOut.getitemstring(arg_row,"cdeparture_time")	then
			dsCenOutPPM.setitem(lrow, "dprod_date",					dsCenOut.getitemdatetime(arg_row,"ddeparture"))
		else
			dsCenOutPPM.setitem(lrow, "dprod_date",					relativedate(date(dsCenOut.getitemdatetime(arg_row,"ddeparture")), -1))
		end if
		dsCenOutPPM.setitem(lrow, "nstatus_key",					10)

		lds_pl_wksarea.retrieve(ls_mandant, ls_unit, uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_packinglist_index_npackinglist_index_key"), date(dsCenOut.getitemdatetime(arg_row,"ddeparture")))
		
		if lds_pl_wksarea.rowcount()>0 then
			dsCenOutPPM.setitem(lrow, "narea_key",						lds_pl_wksarea.getitemnumber(1,"loc_unit_areas_narea_key"))
			dsCenOutPPM.setitem(lrow, "carea_code"	,					lds_pl_wksarea.getitemstring(1,"loc_unit_areas_ctext"))
			dsCenOutPPM.setitem(lrow, "carea",							lds_pl_wksarea.getitemstring(1,"loc_unit_areas_carea"))
			dsCenOutPPM.setitem(lrow, "nworkstation_key",				lds_pl_wksarea.getitemnumber(1,"loc_unit_workstation_nworkstation_key"))
			dsCenOutPPM.setitem(lrow, "cworkstation",					lds_pl_wksarea.getitemstring(1,"loc_unit_workstation_cworkstation"))
			dsCenOutPPM.setitem(lrow, "cworkstation_text",				lds_pl_wksarea.getitemstring(1,"loc_unit_workstation_ctext"))
		else
			dsCenOutPPM.setitem(lrow, "narea_key",						0)
			dsCenOutPPM.setitem(lrow, "carea_code"	,					" ")
			dsCenOutPPM.setitem(lrow, "carea",							" ")
			dsCenOutPPM.setitem(lrow, "nworkstation_key",				0)
			dsCenOutPPM.setitem(lrow, "cworkstation",					" ")
			dsCenOutPPM.setitem(lrow, "cworkstation_text",				" ")
		end if			

		lrow = dsCenOutPPMStowages.insertrow(0)
		LPPMStowageKey = f_sequence("SEQ_CEN_OUT_PPM_STOWAGES", SQLCA)
		                                        
		dsCenOutPPMStowages.setitem(lrow, "nppm_stowage_key",			LPPMStowageKey)
		dsCenOutPPMStowages.setitem(lrow, "nppm_detail_key",				lPPMDetailKey)
		dsCenOutPPMStowages.setitem(lrow, "cgalley",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_galley_cgalley"))
		dsCenOutPPMStowages.setitem(lrow, "cstowage",						uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_stowage_cstowage"))
		dsCenOutPPMStowages.setitem(lrow, "cplace",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_stowage_cplace"))
		dsCenOutPPMStowages.setitem(lrow, "ngalley_sort",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_galley_nsort"))
		dsCenOutPPMStowages.setitem(lrow, "nstowage_sort",				uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_stowage_nsort"))
		dsCenOutPPMStowages.setitem(lrow, "ndistribution_detail_key",		uo_loading4flight.ds_loadinglist.getitemnumber(i,"ndistribution_detail_key"))
		dsCenOutPPMStowages.setitem(lrow, "nbelley_container",			uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_loadinglists_nbelly_container"))
		dsCenOutPPMStowages.setitem(lrow, "nlimit",							uo_loading4flight.ds_loadinglist.getitemnumber(i,"nlimit"))
		dsCenOutPPMStowages.setitem(lrow, "nlimit_spml",					uo_loading4flight.ds_loadinglist.getitemnumber(i,"nlimit_spml"))
		dsCenOutPPMStowages.setitem(lrow, "nranking",						uo_loading4flight.ds_loadinglist.getitemnumber(i,"nranking"))
		dsCenOutPPMStowages.setitem(lrow, "nranking_spml",				uo_loading4flight.ds_loadinglist.getitemnumber(i,"nranking_spml"))
		dsCenOutPPMStowages.setitem(lrow, "cclass",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cen_loadinglists_cclass"))
		dsCenOutPPMStowages.setitem(lrow, "cclass1",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass1"))
		dsCenOutPPMStowages.setitem(lrow, "cclass2",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass2"))
		dsCenOutPPMStowages.setitem(lrow, "cclass3",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass3"))
		dsCenOutPPMStowages.setitem(lrow, "cclass4",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass4"))
		dsCenOutPPMStowages.setitem(lrow, "cclass5",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass5"))
		dsCenOutPPMStowages.setitem(lrow, "cclass6",							uo_loading4flight.ds_loadinglist.getitemstring(i,"cclass6"))
		dsCenOutPPMStowages.setitem(lrow, "nquantity",						uo_loading4flight.ds_loadinglist.getitemnumber(i,"cen_loadinglists_nquantity"))
	next

	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in dsCenOutPPM: "+string(dsCenOutPPM.rowcount()))	
	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in dsCenOutPPMStowages: "+string(dsCenOutPPMStowages.rowcount()))	

	
	// --------------------------------------------------------------------------------------------------------------------
	// Jetzt kopieren wir noch die Meals und Extrabeladung
	// --------------------------------------------------------------------------------------------------------------------
	uo_generate_meals.dsCenOutMeals.setfilter("nresult_key= "+string( ll_Resultkey ))
	uo_generate_meals.dsCenOutMeals.filter()
	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in uo_generate_meals.dsCenOutMeals: "+string(uo_generate_meals.dsCenOutMeals.rowcount()))	
	
	for i=1 to uo_generate_meals.dsCenOutMeals.rowcount()
		lrow = dsCenOutPPM.insertrow(0)
		lPPMDetailKey = f_sequence("SEQ_CEN_OUT_PPM", SQLCA)
	
		dsCenOutPPM.setitem(lrow, "nppm_detail_key",				lPPMDetailKey)
		dsCenOutPPM.setitem(lrow, "nresult_key"	,					ll_Resultkey)
		dsCenOutPPM.setitem(lrow, "ntype",							uo_generate_meals.dsCenOutMeals.getitemnumber(i,"npl_kind_key"))
		dsCenOutPPM.setitem(lrow, "cpackinglist",					uo_generate_meals.dsCenOutMeals.getitemstring(i,"cpackinglist"))
		dsCenOutPPM.setitem(lrow, "ctext",							uo_generate_meals.dsCenOutMeals.getitemstring(i,"ctext"))
		//dsCenOutPPM.setitem(lrow, "cadd_on_text",					uo_generate_meals.dsCenOutMeals.getitemstring(i,"cen_loadinglists_cadd_on_text"))
		//dsCenOutPPM.setitem(lrow, "carea_code"	,					uo_generate_meals.dsCenOutMeals.getitemstring(i,"carea_code"))
		//dsCenOutPPM.setitem(lrow, "carea",							uo_generate_meals.dsCenOutMeals.getitemstring(i,"carea"))
		dsCenOutPPM.setitem(lrow, "cunit_of_issue",				uo_generate_meals.dsCenOutMeals.getitemstring(i,"cunit"))
		//dsCenOutPPM.setitem(lrow, "cworkstation",					uo_generate_meals.dsCenOutMeals.getitemstring(i,"cworkstation"))
		//dsCenOutPPM.setitem(lrow, "cworkstation_text",				uo_generate_meals.dsCenOutMeals.getitemstring(i,"cworkstation_text"))
		dsCenOutPPM.setitem(lrow, "npackinglist_index_key",		uo_generate_meals.dsCenOutMeals.getitemnumber(i,"npackinglist_index_key"))
		dsCenOutPPM.setitem(lrow, "npackinglist_detail_key",		uo_generate_meals.dsCenOutMeals.getitemnumber(i,"npackinglist_detail_key"))
		dsCenOutPPM.setitem(lrow, "nquantity",						uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nquantity"))
		//dsCenOutPPM.setitem(lrow, "nheight",							uo_generate_meals.dsCenOutMeals.getitemnumber(i,"cen_object_equipment_nequipment_height"))
		//dsCenOutPPM.setitem(lrow, "nwidth",							uo_generate_meals.dsCenOutMeals.getitemnumber(i,"cen_object_equipment_nequipment_width"))
		dsCenOutPPM.setitem(lrow, "npltype_key",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"npltype_key"))
/*		dsCenOutPPM.setitem(lrow, "cpl_type",						uo_generate_meals.dsCenOutMeals.getitem(i,"")) */
		dsCenOutPPM.setitem(lrow, "cclass",							uo_generate_meals.dsCenOutMeals.getitemstring(i,"cclass"))
		dsCenOutPPM.setitem(lrow, "nclass_number",				uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nclass_number"))
		//dsCenOutPPM.setitem(lrow, "npl_distribution_key",			uo_generate_meals.dsCenOutMeals.getitemnumber(i,"ndistribution_key"))
		//dsCenOutPPM.setitem(lrow, "cloadinglist",					uo_generate_meals.dsCenOutMeals.getitemstring(i,"cen_loadinglist_index_cloadinglist"))
		dsCenOutPPM.setitem(lrow, "nprint",							1) //uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nprint"))
		dsCenOutPPM.setitem(lrow, "cmeal_control_code",			uo_generate_meals.dsCenOutMeals.getitemstring(i,"cmeal_control_code"))
		//dsCenOutPPM.setitem(lrow, "nlabel_type_key",				uo_generate_meals.dsCenOutMeals.getitemnumber(i,"cen_packinglists_nlabel_type_key"))
		//dsCenOutPPM.setitem(lrow, "nlabel_type",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nlabel_type"))
		//dsCenOutPPM.setitem(lrow, "nlabel_counter",				uo_generate_meals.dsCenOutMeals.getitemnumber(i,"pldetail_label_counter"))
		//dsCenOutPPM.setitem(lrow, "nduplicated",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nduplicated"))
		//dsCenOutPPM.setitem(lrow, "nunit_priority",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nunit_priority"))
		//dsCenOutPPM.setitem(lrow, "ncompute_leg",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"compute_leg"))
		//dsCenOutPPM.setitem(lrow, "ncompute_next_leg",			uo_generate_meals.dsCenOutMeals.getitem(i,""))
		//dsCenOutPPM.setitem(lrow, "nseparator",						uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nseparator"))
		//dsCenOutPPM.setitem(lrow, "nmodified",						uo_generate_meals.dsCenOutMeals.getitemnumber(i,"nmodified"))
		//dsCenOutPPM.setitem(lrow, "ngalley_group",					uo_generate_meals.dsCenOutMeals.getitemnumber(i,"ngalley_group"))
		
		// --------------------------------------------------------------------------------------------------------------------
		// 14.03.2012 HR: zus$$HEX1$$e400$$ENDHEX$$tzliche Felder f$$HEX1$$fc00$$ENDHEX$$llen
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutPPM.setitem(lrow, "cprod_time",						dsCenOut.getitemstring(arg_row,"ckitchen_time"))
		if dsCenOut.getitemstring(arg_row,"ckitchen_time") <= dsCenOut.getitemstring(arg_row,"cdeparture_time")	then
			dsCenOutPPM.setitem(lrow, "dprod_date",					dsCenOut.getitemdatetime(arg_row,"ddeparture"))
		else
			dsCenOutPPM.setitem(lrow, "dprod_date",					relativedate(date(dsCenOut.getitemdatetime(arg_row,"ddeparture")), -1))
		end if
		dsCenOutPPM.setitem(lrow, "nstatus_key",					10)

		lds_pl_wksarea.retrieve(ls_mandant, ls_unit, uo_generate_meals.dsCenOutMeals.getitemnumber(i,"npackinglist_index_key"), date(dsCenOut.getitemdatetime(arg_row,"ddeparture")))
		
		if lds_pl_wksarea.rowcount()>0 then
			dsCenOutPPM.setitem(lrow, "narea_key",						lds_pl_wksarea.getitemnumber(1,"loc_unit_areas_narea_key"))
			dsCenOutPPM.setitem(lrow, "carea_code"	,					lds_pl_wksarea.getitemstring(1,"loc_unit_areas_ctext"))
			dsCenOutPPM.setitem(lrow, "carea",							lds_pl_wksarea.getitemstring(1,"loc_unit_areas_carea"))
			dsCenOutPPM.setitem(lrow, "nworkstation_key",				lds_pl_wksarea.getitemnumber(1,"loc_unit_workstation_nworkstation_key"))
			dsCenOutPPM.setitem(lrow, "cworkstation",					lds_pl_wksarea.getitemstring(1,"loc_unit_workstation_cworkstation"))
			dsCenOutPPM.setitem(lrow, "cworkstation_text",				lds_pl_wksarea.getitemstring(1,"loc_unit_workstation_ctext"))
		else
			dsCenOutPPM.setitem(lrow, "narea_key",						0)
			dsCenOutPPM.setitem(lrow, "carea_code"	,					" ")
			dsCenOutPPM.setitem(lrow, "carea",							" ")
			dsCenOutPPM.setitem(lrow, "nworkstation_key",				0)
			dsCenOutPPM.setitem(lrow, "cworkstation",					" ")
			dsCenOutPPM.setitem(lrow, "cworkstation_text",				" ")
		end if			

	next

	uo_generate_meals.dsCenOutMeals.setfilter("")
	uo_generate_meals.dsCenOutMeals.filter()

	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in dsCenOutPPM: "+string(dsCenOutPPM.rowcount()))	
	this.of_trace("of_generate_ppm", 10, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in dsCenOutPPMStowages: "+string(dsCenOutPPMStowages.rowcount()))	

end if

destroy lds_pl_wksarea
destroy uo_loading4flight// 20.06.2012 HR:

garbagecollect() // 20.06.2012 HR:

lEnde = CPU()
this.of_trace("of_generate_ppm", 3, ""+string(lFlightNumber,"0000")+sSuffix+": Rows in dsCenOutPPM: "+string(dsCenOutPPM.rowcount())+" Duration "+string((lEnde - lstart)/1000)+" sek")	

dsCenOutPPM.setfilter("")
dsCenOutPPM.filter()

return 1
end function

public function boolean of_write_job_history_once (integer arg_status);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_write_job_history_once (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e): 
// integer arg_status    (1= Job OK; 2=Fehler bei der Ausf$$HEX1$$fc00$$ENDHEX$$hrung)
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
//  09.12.2011	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long   lCPU, lSequence
datastore lds
lCPU = ((lTimeEnd - lTimeStart) / 1000)

// 28.10.2010 HR: Bei Generierungstype 2: Einmalereignisse wird dies in einer anderen Tabelle protokolliert
idt_ende = datetime(today(),now())

lds = create datastore
lds.dataobject="dw_jobs2generate_once"
lds.settransobject(SQLCA)
lds.retrieve(lJob_Key)

if lds.rowcount()>0 then
	if lds.getitemnumber(1,"ndaily")=1 then
		lSequence = f_Sequence ("seq_loc_jobs_once", sqlca)
		If lSequence <> -1 Then
			//T$$HEX1$$e400$$ENDHEX$$gliche Generierungsauftr$$HEX1$$e400$$ENDHEX$$ge werden um einen Tag in die Zukunft gesetzt
			lds.rowscopy(1,1,primary!,lds,2,primary!)
			lds.setitem(2,"njobs_once_key",lSequence)
			lds.setitem(2,"dnot_run_before",relativedate(today(),1))
			lds.setitem(2,"dgeneration_date",relativedate(date(lds.getitemdatetime(1,"dgeneration_date")),1))
		else
			f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
							sunit + "~tCan't copy one-time Generation to new Day(" + &
							string(lJob_Key) + "," + string(dGenerationDate) + "," + string(dtstart) + &
							"," + string(lCPU) + "," + string(lJobActions) + ")~n" ,sTraceFile + "-" + this.sInstanceName + ".log")
			
		end if
	end if
	
	lds.setitem(1,"nstatus",arg_status)
	lds.setitem(1,"dstart_computing",idt_start)
	lds.setitem(1,"dstop_computing",idt_ende)
	
	if lds.update()=1 then
		commit using sqlca;   
	else
		rollback using sqlca;
	end if
end if

destroy lds
garbagecollect() // 20.06.2012 HR:

return True

end function

public function boolean of_generate_flightcalcjobs ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode:of_generate_flightcalcjobs(Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):	
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: 	Anlegen der Auftr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r FlightCalc f$$HEX1$$fc00$$ENDHEX$$r alle
//						Fl$$HEX1$$fc00$$ENDHEX$$ge der Tages
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  20.11.2012	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

uo_generate_datastore lds
long i, lsequence
datetime ldt, ldt_dep

if dsCenOut.rowcount()=0 then 
	return True
end if

// --------------------------------------------------------------------------------------------------------------------
// 14.05.2013 HR: Wenn wir keine Verteilung speichern sollen, dann erzeugen wir auch keine Auftr$$HEX1$$e400$$ENDHEX$$ge
// --------------------------------------------------------------------------------------------------------------------
if f_cen_profilestring("MealDistribution","SaveDistribution","0") = "0" then
	of_trace("of_generate_flightcalcjobs", 1,"SaveDistribution is switched off. No Flightcalc-Jobs are created")
	return true
end if

ldt = datetime(today(),now())

lds = create uo_generate_datastore
lds.dataobject="dw_generate_flightcalcjobs"
lds.settransobject(SQLCA)

for i=1 to dsCenOut.rowcount()
	// --------------------------------------------------------------------------------------------------------------------
	// 14.05.2013 HR: Auftr$$HEX1$$e400$$ENDHEX$$ge nur f$$HEX1$$fc00$$ENDHEX$$r das erste Leg erzeugen, da nur hier eine Aufl$$HEX1$$f600$$ENDHEX$$sung m$$HEX1$$f600$$ENDHEX$$glich ist
	// --------------------------------------------------------------------------------------------------------------------
	if dsCenOut.GetItemnumber(i, "nleg_number") > 1 then continue
	
	lsequence = f_sequence("seq_sys_queue_flight_calc", sqlca)

	if lsequence = -1 then
		of_trace("of_generate_flightcalcjobs", 1,"Error getting Sequence:  " + string( SQLCA.SQLCODE) + " - " + SQLCA.SQLERRTEXT)
		destroy lds
		return false
	end if 

	lds.insertrow(1)
	
	lds.SetItem(1, "njob_nr", lSequence)
	lds.SetItem(1, "nresult_key", dsCenOut.GetItemnumber(i, "nresult_key"))
	lds.SetItem(1, "ddeparture", Datetime(Date(dsCenOut.GetItemDatetime(i, "ddeparture")), Time(dsCenOut.GetItemString(i, "cdeparture_time"))))
	lds.SetItem(1, "dcreated", Datetime(today(), now()))
	lds.SetItem(1, "cmodified", "requested by Generierung")
	lds.SetItem(1, "cuser", "cbase_service")
	lds.SetItem(1, "nstatus", dsCenOut.GetItemnumber(i, "nstatus"))
	lds.SetItem(1, "nfunction",10)
	lds.SetItem(1, "nforecast",0)
	lds.SetItem(1, "nhistory",0)
next

if lds.update()=1 then
	of_trace("of_generate_flightcalcjobs", 1,"Generate " + string( lds.rowcount()) + " FlightCalc Jobs.")

	destroy lds
	
	lTimeEnd = cpu()
	
	return True
else
	of_trace("of_generate_flightcalcjobs", 1,"Update Error:  " + string( lds.lSQLErrorDBCode)+" "+lds.sSQLErrorText)

	destroy lds
	return false
end if

	
	
	
end function

public function integer of_generate_handling_paclos (datastore arg_dshandling, long arg_row, long arg_lcenoutrow, integer arg_sslzbl);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_handling_paclos (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// datastore arg_dshandling
//  long arg_row
//  long arg_lcenoutrow
//  integer arg_sslzbl
// --------------------------------------------------------------------------------------------------------------------
// Return: integer     	1: SSL/ZBL darf verwendet werden
//							0: SSL/ZBL darf nicht verwendet werden
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Schaut, ob f$$HEX1$$fc00$$ENDHEX$$r diese SSL/ZBL f$$HEX1$$fc00$$ENDHEX$$r Packages/LOS hinterlegt sind und pr$$HEX1$$fc00$$ENDHEX$$ft diese gegen
//						die Fluginfos
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  19.06.2013	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

datastore 	lds_PackageLos
boolean 		bCFSPackages, bCFSExact
integer 		k, lFound
string 		sFind, sKind

if arg_sslzbl = 1 then
	sKind = "SSL "
else
	sKind = "ZBL "
end if

lds_PackageLos = create datastore

if  arg_dsHandling.Getitemnumber(arg_row, "nlos_comb_flag") = 1 then
	bCFSPackages 	= false
	bCFSExact		= false
	lds_PackageLos.dataobject="dw_generate_handling_ll_los"
end if

if  arg_dsHandling.Getitemnumber(arg_row, "nlos_exact_flag") = 1 then
	bCFSPackages 	= false
	bCFSExact		= true
	lds_PackageLos.dataobject="dw_generate_handling_ll_los"
end if

if  arg_dsHandling.Getitemnumber(arg_row, "npack_comb_flag") = 1 then
	bCFSPackages 	= true
	bCFSExact		= false
	lds_PackageLos.dataobject="dw_generate_handling_ll_pac"
end if

if  arg_dsHandling.Getitemnumber(arg_row, "npack_exact_flag") = 1 then
	bCFSPackages 	= true
	bCFSExact		= true
	lds_PackageLos.dataobject="dw_generate_handling_ll_pac"
end if

lds_PackageLos.settransobject(SQLCA)
lds_PackageLos.retrieve(sLoadinglist, this.dnewgenerationdate)

if lds_PackageLos.rowcount()>0 then
	if bCFSPackages then
		if lds_PackageLos.getitemnumber(1,"comp_maxleg")>1 then
			dsCenOutPackets.setfilter("nresult_key_group = "+string(dsCenOut.getitemnumber(arg_lcenoutrow, "nresult_key_group")))	
		else
			dsCenOutPackets.setfilter("nresult_key = "+string(dsCenOut.getitemnumber(arg_lcenoutrow, "nresult_key")))					
		end if
		dsCenOutPackets.filter()
		
		if dsCenOutPackets.rowcount( )=0 then 
			of_trace("of_generate_handling_paclos", 10, "No Packages for this flight found")
			return 0
		end if
		
		if dsCenOutPackets.getitemnumber(1,"compute_maxleg")<>lds_PackageLos.getitemnumber(1,"comp_maxleg") then 
			of_trace("of_generate_handling_paclos", 10, "Legs in Flight: "+string(dsCenOutPackets.getitemnumber(1,"compute_maxleg"))+" vs. Legs in Package-Masterdata: "+string(lds_PackageLos.getitemnumber(1,"comp_maxleg") ))
			return 0
		end if

		for k=1 to lds_PackageLos.rowcount()
					
			sFind = "nleg_number = "+string(lds_PackageLos.getitemnumber(k,"cen_loadinglist_packages_nleg_number"))+" and cpacket = '"+lds_PackageLos.getitemstring(k,"cen_airline_packages_cpackage")+"' and  cpacket_var ='"+lds_PackageLos.getitemstring(k,"cen_airline_packages_cvariation")+"' "
			lfound = dsCenOutPackets.find(sFind, 1, dsCenOutPackets.rowcount())
			
			if lfound > 0 then lds_PackageLos.setitem(k, "nfound", 1)
				
		next
	else
		if lds_PackageLos.getitemnumber(1,"comp_maxleg")>1 then
			dsCenOutLos.setfilter("nresult_key_group = "+string(dsCenOut.getitemnumber(arg_lcenoutrow, "nresult_key_group")))		
		else
			dsCenOutLos.setfilter("nresult_key = "+string(dsCenOut.getitemnumber(arg_lcenoutrow, "nresult_key")))					
		end if
		dsCenOutLos.filter()
		
		if dsCenOutLos.rowcount( )=0 then 
			of_trace("of_generate_handling_paclos", 10, "No LOS for this flight found")
			return 0
		end if
		
		if dsCenOutLos.getitemnumber(1,"compute_maxleg")<>lds_PackageLos.getitemnumber(1,"comp_maxleg") then 
			of_trace("of_generate_handling_paclos", 10, "Legs in Flight: "+string(dsCenOutLos.getitemnumber(1,"compute_maxleg"))+" vs. Legs in LOS-Masterdata: "+string(lds_PackageLos.getitemnumber(1,"comp_maxleg") ))
			return 0
		end if

		for k=1 to lds_PackageLos.rowcount()
			sFind = "nleg_number = "+string(lds_PackageLos.getitemnumber(k,"cen_loadinglist_los_nleg_number"))+" and clos_grp_code = '"+lds_PackageLos.getitemstring(k,"cen_airline_los_clos_grp_code")+"' and  clos_var ='"+lds_PackageLos.getitemstring(k,"cen_airline_los_clos_var")+"' "

			// 26.07.2013 HR: 4.94-088 Klasse mit einbeziehen 
			sFind += " and trim(upper(clos_class)) = '"+trim(upper(lds_PackageLos.getitemstring(k,"cen_loadinglist_los_cclass")))+"'"
			
			lfound = dsCenOutLos.find(sFind, 1, dsCenOutLos.rowcount())
    			    
			if lfound > 0 then lds_PackageLos.setitem(k, "nfound", 1)
		next
	end if
	
	if bCFSExact then
		//Nur wenn minedestens ein Packages/LOS gefunden wurden, darf die LL benutzt werden
		if lds_PackageLos.getitemnumber(1,"comp_found") =0 then 
			of_trace("of_generate_handling_paclos", 10, sKind+ sLoadinglist +" not used, because no Package/Los found")
			return 0
		end if
	else
		//Nur wenn alle Packages/LOS gefunden wurden, darf die LL benutzt werden
		if lds_PackageLos.getitemnumber(1,"comp_found") <> lds_PackageLos.rowcount() then 
			of_trace("of_generate_handling_paclos", 10, sKind+ sLoadinglist +" not used, because "+string( lds_PackageLos.getitemnumber(1,"comp_found"))+" of "+string( lds_PackageLos.rowcount())+"Package/Los found")
			return 0
		end if
	end if
	of_trace("of_generate_handling_paclos", 10, sKind+ sLoadinglist +" is used.")
end if

destroy lds_PackageLos


return 1

end function

public function boolean of_generate_idocjobs ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_idocjobs (Function)
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
//  17.12.2013	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long 					i
datetime 			ldt
uo_request_idoc 	uo_ridoc
integer 				li_ok, li_error

//Keine Fl$$HEX1$$fc00$$ENDHEX$$ge generiert, dann raus hier
if dsCenOut.rowcount()=0 then 
	return True
end if

 select NORDERS_FLAG, DORDERS_VALID_FROM 
    into :li_ok , :ldt
  from sys_units 
where CUNIT = :sUnit;

if li_ok=0 then
	this.of_trace("of_generate_idocjobs", 1, "IDOC-SEND f$$HEX1$$fc00$$ENDHEX$$r Betrieb ausgeschaltet")
	return true
end if

if date(ldt) > dGenerationDate then
	this.of_trace("of_generate_idocjobs", 1, "IDOC-SEND f$$HEX1$$fc00$$ENDHEX$$r Betrieb erst ab "+string(ldt, "dd.mm.yyyy"))
	return true // 08.05.2015 HR: #5.10-069 Wenn noch keine IDOC verschickt werden sollen, dann auch raus hier
end if

uo_ridoc = create uo_request_idoc
li_ok 		= 0 
li_error 	= 0

for i=1 to dsCenOut.rowcount()
	// --------------------------------------------------------------------------------------------------------------------
	//Wir erstellen Auftr$$HEX1$$e400$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r die Fl$$HEX1$$fc00$$ENDHEX$$ge
	// --------------------------------------------------------------------------------------------------------------------
	if uo_ridoc.of_insert( dsCenOut.GetItemnumber(i, "nresult_key") ,3,  'CPLN', dsCenOut.GetItemnumber(i, "ntransaction")) =0 then
		li_ok ++
	else
		li_error ++
	end if
next

this.of_trace("of_generate_idocjobs", 1, "IDOC Auftr$$HEX1$$e400$$ENDHEX$$ge erstellt: "+string(li_ok)+" / mit Fehler: "+string(li_error))

destroy uo_ridoc

return true
end function

public function boolean of_generate_skytelexsendjobs ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_skytelexsendjobs (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Hier werden, wenn f$$HEX1$$fc00$$ENDHEX$$r die Airline in der cen_airlines die Zeitstempel gesetzt sind
// Auftr$$HEX1$$e400$$ENDHEX$$ge in die SYS_BRU_PAXCHANGES geschrieben
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  09.01.2014	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
uo_generate_datastore lds, lds2
long i, lsequence, ll_send_checkin, ll_sebd_outstation
datetime ldt_dep

//Keine Fl$$HEX1$$fc00$$ENDHEX$$ge generiert, dann raus hier
if dsCenOut.rowcount()=0 then 
	return True
end if

// --------------------------------------------------------------------------------------------------------------------
// 20.11.2015 HR: Fireout-Parameter-Felder wurden in eigene Tabelle ausgelagert, da jetzt streckenbezoge Unterschiede gibt
// --------------------------------------------------------------------------------------------------------------------
/*
  SELECT cen_airlines.nsend_checkin,   
         	cen_airlines.nsebd_outstation  
    INTO  :ll_send_checkin, 
	 		:ll_sebd_outstation
    FROM cen_airlines  
   WHERE cen_airlines.nairline_key = :lAirlineKey   ;
*/

lds2 = create uo_generate_datastore
lds2.dataobject="dw_sky_bru_firout_routing"
lds2.settransobject(SQLCA)
lds2.retrieve(lAirlineKey)

if lds2.rowcount()=0 then
	destroy lds2
	return true
end if

lds = create uo_generate_datastore
lds.dataobject="dw_sky_telex_sendjobs"
lds.settransobject(SQLCA)

for i=1 to dsCenOut.rowcount()
	lds2.setfilter("nrouting_id = " +string(dsCenOut.getitemnumber(i, "nrouting_id")))
	lds2.filter()
	
	if lds2.rowcount()=0 then continue
	
  	ll_send_checkin 	= lds2.getitemnumber(1, "nsend_checkin")
	ll_sebd_outstation	= lds2.getitemnumber(1, "nsebd_outstation")
	
	if ll_send_checkin <> -1 then 
		lsequence = f_sequence("SEQ_SYS_BRU_PAXCHANGES", SQLCA)	
		
		if lsequence > 0 then
			ldt_dep = f_dt_add(dsCenOut.getitemdatetime(i,"ddeparture_time_loc"), -60 * 60 *  ll_send_checkin)
			
			lds.insertrow(1)
			lds.setitem(1, "npkey", lsequence)
			lds.setitem(1, "nresult_key", dsCenOut.getitemnumber(i,"nresult_key"))
			lds.setitem(1, "dvalidfrom", ldt_dep)
			lds.setitem(1, "nprocess_status", 0)
			lds.setitem(1, "ctype", 'I')
			lds.setitem(1, "ctarget", 'CHECKIN')
		end if
	end if

	if ll_sebd_outstation <> -1 then 
		lsequence = f_sequence("SEQ_SYS_BRU_PAXCHANGES", SQLCA)	
		
		if lsequence > 0 then
			ldt_dep = f_dt_add(dsCenOut.getitemdatetime(i,"ddeparture_time_loc"), -60 * 60 *  ll_sebd_outstation)
			
			lds.insertrow(1)
			lds.setitem(1, "npkey", lsequence)
			lds.setitem(1, "nresult_key", dsCenOut.getitemnumber(i,"nresult_key"))
			lds.setitem(1, "dvalidfrom", ldt_dep)
			lds.setitem(1, "nprocess_status", 0)
			lds.setitem(1, "ctype", 'I')
			lds.setitem(1, "ctarget", 'OUTSTATION')
		end if
	end if

next

if lds.update()=1 and lds.rowcount()>0 then
	this.of_trace("of_generate_skytelexsendjobs", 1, "Generate "+string(lds.rowcount())+" Jobs for SKY-Telex_SEND")
end if

destroy lds
destroy lds2

return true


end function

public function integer of_change_handling (long arg_result_key_group, long arg_handlingtypekey, string arg_shandlingshorttext, string arg_shandlinglongtext);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_change_handling (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_result_key_group
//  long arg_handlingtypekey
//  string arg_shandlingshorttext
//  string arg_shandlinglongtext
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Setzt f$$HEX1$$fc00$$ENDHEX$$r alle Legs eines Fluges die Abfertigungsart auf den $$HEX1$$fc00$$ENDHEX$$bergebenen Wert
//                       CBASE-NAM-CR-14019
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  23.06.2014	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long l3

for l3=1 to dsCenOut.rowcount()
	
	if dsCenOut.getitemnumber(l3,"nresult_key_group")<>arg_result_key_group then continue
	
	if dsCenOut.getitemnumber(l3,"NHANDLING_TYPE_KEY") = arg_HandlingTypeKey then continue
	
	dsCenOut.SetItem(l3,"NHANDLING_TYPE_KEY",arg_HandlingTypeKey)
	dsCenOut.SetItem(l3,"CHANDLING_TYPE_TEXT",arg_sHandlingShortText)
	dsCenOut.SetItem(l3,"CHANDLING_TYPE_DESCRIPTION",arg_sHandlingLongText)

	if arg_sHandlingShortText = "REQ" then
		dsCenOut.SetItem(l3, "nflight_status", 2)
	else
		dsCenOut.SetItem(l3, "nflight_status", 0)
	end if
	
	of_trace("of_change_handling", 5,"Changed Flight "+ string(dsCenOut.Getitemnumber(l3,"nflight_number"))+" to " +arg_sHandlingShortText)
next

return 1
end function

public function integer of_trace (string arg_function, integer level, string trace_text);long 		val

string	sFileName, sUser, sHost, a
string	sApplication
integer	iTraceFile

//
// Debug-Level beachten
//
if level <= this.idebug_level then
	
	if FileLength (sTraceFile + "-" + this.sInstanceName + ".log") > il_maxlogsize then
		a = sTraceFile + "-" + this.sInstanceName + "_"+string(now(),"hhmmss")+".log"
		filecopy (sTraceFile + "-" + this.sInstanceName + ".log", a)
		filedelete(sTraceFile + "-" + this.sInstanceName + ".log")
				
		iTraceFile	= FileOpen(sTraceFile + "-" + this.sInstanceName + ".log", LineMode!, Write!, LockWrite!, Append!)
	
		FileWrite(iTraceFile, String(Today(),"dd.mm.yyyy")+"|"+String(Now(),"hh:mm:ss")+"| File larger then "+string(il_maxlogsize / 1000000)+"MB Backup to " +a)
		FileWrite(iTraceFile, "################################################################# ")
		FileClose(iTraceFile)
		
	end if
	iTraceFile	= FileOpen(sTraceFile + "-" + this.sInstanceName + ".log", LineMode!, Write!, LockWrite!, Append!)

	FileWrite(iTraceFile, String(Today(),"dd.mm.yyyy")+"|"+String(Now(),"hh:mm:ss")+"|[" +arg_function+"] "+ trace_text)

	FileClose(iTraceFile)
end if

return 0

end function

public function integer of_trace_flight (string arg_function, string trace_text);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_trace_flight (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string trace_text
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Schreibt ins Log-File unabh$$HEX1$$e400$$ENDHEX$$ngig vom Tracelevel wenn eingeschaltet
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  21.06.2012	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string	a
integer	iTraceFile

if ii_logFlightNumber = 0	 then return 0

of_trace(arg_function, 0, trace_text + "  **************************" )

/*
if FileLength (sTraceFile + "-" + this.sInstanceName + ".log") > il_maxlogsize then
	a = sTraceFile + "-" + this.sInstanceName + "_"+string(now(),"hhmmss")+".log"
	filecopy (sTraceFile + "-" + this.sInstanceName + ".log", a)
	filedelete(sTraceFile + "-" + this.sInstanceName + ".log")
			
	iTraceFile	= FileOpen(sTraceFile + "-" + this.sInstanceName + ".log", LineMode!, Write!, LockWrite!, Append!)

	FileWrite(iTraceFile, String(Today(),"dd.mm.yyyy")+"|"+String(Now(),"hh:mm:ss")+"| File larger then "+string(il_maxlogsize / 1000000)+"MB Backup to " +a)
	FileWrite(iTraceFile, "################################################################# ")
	FileClose(iTraceFile)
	
end if
iTraceFile	= FileOpen(sTraceFile + "-" + this.sInstanceName + ".log", LineMode!, Write!, LockWrite!, Append!)

FileWrite(iTraceFile, String(Today(),"dd.mm.yyyy")+"|"+String(Now(),"hh:mm:ss")+"|"+arg_function + trace_text+"  **************************")

FileClose(iTraceFile)
*/
return 0

end function

public function integer of_get_co_packetkeys (long arg_result_key, string arg_cclass, ref long arg_packetkey[]);long 	ll_null[], xx
// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_co_packetkeys (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_result_key
//  string arg_cclass
//  ref long arg_packetkey[]
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Ermittelt zu einem Flug und ggf Klasse die zugeordneten Packagekeys
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  27.11.2014	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string ls_filter

arg_packetkey = ll_null

ls_filter = "NRESULT_KEY = "+string(arg_result_key)

if arg_cclass <> "ALL" then
	ls_filter += " and cpacket_class='"+arg_cclass+"'"
end if

if dsCenOutPackets.setfilter(ls_filter)<> 1 then
	arg_packetkey[1] = -1
	of_trace("of_get_co_packetkeys", 1,"Error Filter Packages: " +of_checknull(sAirline +string(lFlightNumber)+" "+ sTLCFrom +"-"+sTLCTo))
else
	dsCenOutPackets.filter()
	
	if dsCenOutPackets.rowcount()>0 then
		for xx=1 to dsCenOutPackets.rowcount()
			if xx > 1000 then
				of_trace("of_get_co_packetkeys", 1,"skip Packages more then 1000 " +of_checknull(sAirline +string(lFlightNumber)+" "+ sTLCFrom +"-"+sTLCTo)+": "+string(dsCenOutPackets.rowcount()))
				exit
			else
				arg_packetkey[xx] = dsCenOutPackets.getitemnumber(xx,"nairline_packages_key")
			end if
		next
	else
		arg_packetkey[1] = -1
	end if
end if

return 1
end function

public function integer of_create_checkpts ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_create_checkpts (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
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
//  14.01.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

datastore 	lds_chkpt
datetime 	ldt_kitchen, ldt_ramp, ldt_alert, ldt_dep, ldt_checkpt
long			i, j, lRow, lOffset, lOffsetAlert
date			ld_vortag

lds_chkpt =create datastore
lds_chkpt.dataobject = "dw_loc_unit_checkpt_data"
lds_chkpt.settransobject( SQLCA)
lds_chkpt.retrieve(sUnit)

if lds_chkpt.rowcount()=0 then
	of_trace("of_create_checkpts", 1,"No CheckPoints found.")
	destroy lds_chkpt
	
	return 1
end if

lOffsetAlert = long(f_unitprofilestring("Default","CHECKPT_WARN_OFFSET", "-120", sUnit)) * 60

for i=1 to dsCenOut.rowcount()
	ldt_dep 			= datetime(date(dsCenOut.getitemdatetime(i, "Ddeparture")), time(dsCenOut.getitemstring(i, "cdeparture_time")))
	ld_vortag 		= relativedate(date(ldt_dep), -1)	
	
	if dsCenOut.getitemstring(i, "cdeparture_time") > dsCenOut.getitemstring(i, "cramp_time") then
		ldt_ramp		= datetime(date(ldt_dep), time(dsCenOut.getitemstring(i, "cramp_time")) )
	else
		ldt_ramp		= datetime(ld_vortag, time(dsCenOut.getitemstring(i, "cramp_time")) )
	end if
	
	if dsCenOut.getitemstring(i, "cdeparture_time") > dsCenOut.getitemstring(i, "ckitchen_time") then
		ldt_kitchen	= datetime(date(ldt_dep), time(dsCenOut.getitemstring(i, "ckitchen_time")))
	else
		ldt_kitchen 	= datetime(ld_vortag, time(dsCenOut.getitemstring(i, "ckitchen_time")))
	end if

	lds_chkpt.setfilter("cen_routing_crouting = '"+dsCenOut.getitemstring(i, "crouting")+"' ")
	lds_chkpt.filter()
	
	if lds_chkpt.rowcount()=0 then
		of_trace("of_create_checkpts", 1,"No CheckPoints for Routing "+ dsCenOut.getitemstring(i, "crouting") +" found.")
		continue
	end if
	 
	 for j = 1 to lds_chkpt.rowcount()
		lOffset = lds_chkpt.getitemnumber(j, "loc_unit_checkpt_times_ntimeoffset") 
		
		choose case lds_chkpt.getitemnumber(j, "loc_unit_checkpt_times_ntimetype")
			case 1 //K$$HEX1$$fc00$$ENDHEX$$chenzeit
				ldt_checkpt = f_dt_add(ldt_kitchen, lOffset * 60) 		
				
			case 2 //Rampenzeit
				ldt_checkpt = f_dt_add(ldt_ramp, lOffset * 60) 		
				
			case 3 //Abflugzeit
				ldt_checkpt = f_dt_add(ldt_dep, lOffset * 60) 		

		end choose

		ldt_alert = f_dt_add(ldt_checkpt, lOffsetAlert)
		
	 	lRow = dsCenOutCheckPt.insertrow(0)
		dsCenOutCheckPt.setitem(lrow, "nresult_key", dsCenOut.getitemnumber(i, "nresult_key"))
		dsCenOutCheckPt.setitem(lrow, "ntransaction", dsCenOut.getitemnumber(i, "ntransaction"))
		dsCenOutCheckPt.setitem(lrow, "ncheckpoint_key", lds_chkpt.getitemnumber(j, "loc_unit_checkpt_ncheckpoint_key"))
		dsCenOutCheckPt.setitem(lrow, "cunit", lds_chkpt.getitemstring(j, "loc_unit_checkpt_cunit"))
		dsCenOutCheckPt.setitem(lrow, "ncheckpoint_sort", lds_chkpt.getitemnumber(j, "loc_unit_checkpt_nsort"))
		dsCenOutCheckPt.setitem(lrow, "ccheckpoint", lds_chkpt.getitemstring(j, "loc_unit_checkpt_ccheckpoint"))
		dsCenOutCheckPt.setitem(lrow, "ctext", lds_chkpt.getitemstring(j, "loc_unit_checkpt_ctext"))
		dsCenOutCheckPt.setitem(lrow, "nworkstationsactiveflag", lds_chkpt.getitemnumber(j, "loc_unit_checkpt_nworkstationsactiveflag"))
		dsCenOutCheckPt.setitem(lrow, "ddeparture_time", ldt_dep)
		dsCenOutCheckPt.setitem(lrow, "dkitchen_time", ldt_kitchen)
		dsCenOutCheckPt.setitem(lrow, "dramp_time", ldt_ramp)
		dsCenOutCheckPt.setitem(lrow, "ntimetype", lds_chkpt.getitemnumber(j, "loc_unit_checkpt_times_ntimetype"))
		dsCenOutCheckPt.setitem(lrow, "ntimeoffset", lOffset)
		dsCenOutCheckPt.setitem(lrow, "dcheckpt_target_time", ldt_checkpt)
 		dsCenOutCheckPt.setitem(lrow, "dcheckpt_alert_time", ldt_alert)
		 
		 // 19.01.2015 HR: Status je nach WKS-Flag setzen
		 if lds_chkpt.getitemnumber(j, "loc_unit_checkpt_nworkstationsactiveflag") = 1 then
			dsCenOutCheckPt.setitem(lrow, "ncheckpt_state", 0)
		else
			dsCenOutCheckPt.setitem(lrow, "ncheckpt_state", 20)
		end if
		
		    
	next
next

destroy lds_chkpt

return 1
end function

public function boolean of_generate_handling_meals (integer arg_module_type, s_change_flight s_change, string arg_rowcount);if ii_new_cfs_handlinggen = 1 then
	// 27.11.2014 HR: Neue testweise Einbau der neuen Datawindow (Wenn alles OK, dann ersetzt die die Funktion of_generate_handling_meals)
	return of_generate_handling_meals_new(arg_module_type, s_change, arg_rowcount)
end if

// Achtung $$HEX1$$c400$$ENDHEX$$nderungen an dieser Funktion auch in of_generate_handling_meals_new durchf$$HEX1$$fc00$$ENDHEX$$hren

//=====================================================================================
// of_generate_handling_meals
//
// Mahlzeitenbeladung f$$HEX1$$fc00$$ENDHEX$$r die Fl$$HEX1$$fc00$$ENDHEX$$ge ermitteln
//
// 04.11.2003: Die Extrabeladung kommt dazu Container-Objekt hat Handling-ID 5 Definition hat Handling-ID 13
// 17.11.2003:	Kurz-Von-An verarbeiten
// 21.11.2003:	Extrabeladung f$$HEX1$$fc00$$ENDHEX$$r Change-Gesch$$HEX1$$e400$$ENDHEX$$ft einbauen
//	10.12.2003:	bCalculateNoMeals: Schalter "Tausche keine Mahlzeiten"
//					In diesem Fall erfolgt die Mahlzeitenkalkulation mit den Daten von cen_out_meals und nicht mit den Stammdaten!
//	21.05.2005:	Neues Feld compute_classnumber in dsHandlingObjects bzw. dsHandlingObjects_CP
//					Nur relevant im Change-Modus
//	29.06.2009: dsHandlingObjects aus dsHandlingObjects_LC f$$HEX1$$fc00$$ENDHEX$$llen
//  10.07.2015: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
//=====================================================================================
long 			lRow,i,j,xx
long			lHandling_Key, lHandlingType
datastore 	dsHandling
string			sFilter,sFind
Long			lPaxtoCalc
integer		iTrafficDay, iHandlingID
long			lFind
boolean		bDefaultAircraftFound
long			lCurrentOwner,lOwnerOnly,lCurrentyp
long			lInfoRow,lHandlingSort
long			ll_RoutingPlanDetailKey
datastore  	lds_sky
string 		ls_packets[], ls_null[] //03.05.2011 HR
boolean		lb_NoPackets

// ------------------------------------------
// Je nach Module-Type unterschiedliche Handling-IDs verwenden
// ------------------------------------------	
if arg_module_type = 0 then
	iHandlingID = 11	// Mahlzeitencontainer
else
	iHandlingID = 5		// Extrabeladungscontainer
end if

// 16.04.2013 HR: Wir setzen den Schalter bei jedem Durchlauf zur$$HEX1$$fc00$$ENDHEX$$ck, damit auch f$$HEX1$$fc00$$ENDHEX$$r die Extrabeladung der Schalter neu ist
//                         (CBASE-DE-EM-12031)
bCalcMealsWithoutHandling = false

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(dNewGenerationDate)
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	

If dNewGenerationDate < Date (2005,1,1) Then
	of_trace("of_generate_handling_meals", 1,arg_rowcount+"Bullshit dNewGenerationDate:" + string(dNewGenerationDate))
End if

If dGenerationDate < Date (2005,1,1) Then
	of_trace("of_generate_handling_meals", 1,arg_rowcount+"Bullshit dGenerationDate:" + string(dGenerationDate))
End if

// ---------------------------------------------------------------
// Flugnummer oder City Pair, Mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
	
//	LCL-Fl$$HEX1$$fc00$$ENDHEX$$ge: dsHandlingObjects aus dsHandlingObjects_LC f$$HEX1$$fc00$$ENDHEX$$llen TBR 29.06.2009
IF ii_nlcl_mirror_flag = 1 THEN
	dsHandling = dsHandlingObjects_LCL
ELSE
	dsHandling = dsHandlingObjects
END IF

ll_RoutingPlanDetailKey = lRoutingPlanDetailKey

lRow = dsHandling.find("nhandling_id = " + string(iHandlingID),1,dsHandling.Rowcount())

If lRow <= 0 AND 	ii_nlcl_mirror_flag = 0 THEN // Nur, wenn kein LCL-Flug HR 26.10.2009

	dsHandling = dsHandlingObjects_cp
	ll_RoutingPlanDetailKey = lRoutingPlanDetailKey_CP

	// Suche Citypair: Falls auch nichts, dann ohne Fehler zur$$HEX1$$fc00$$ENDHEX$$ck
	lRow = dsHandling.find("nhandling_id = " + string(iHandlingID),1,dsHandling.Rowcount())
	if lRow <= 0 Then
		// Falls in Change-Mode, dann k$$HEX1$$f600$$ENDHEX$$nnten ausschl. manuell aufgenommene MZ in dsCenOutMeals vorhanden sein
		if bDelete = true then
			return true
		else
			// im change mode, jedoch nur einmal
			if bCalcMealsWithoutHandling = true then
				return true
			end if
		end if
	end if
End if

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
uo_generate_meals.ids_cen_meals_det_deduction.reset()

// 12.08.2010 HR: Dataobject tauschen, damit BOB-Fl$$HEX1$$fc00$$ENDHEX$$ge die BOB-Werte zugespielt werden k$$HEX1$$f600$$ENDHEX$$nnen
uo_generate_meals.uf_change_flightdataobject("dw_change_bob_pax_flight_gen")

// --------------------------------------------------------------------------------------------------------------------
// 03.05.2011 HR: Wir holen die Packets aus der CEN_OUT-Struktur
// --------------------------------------------------------------------------------------------------------------------
if dsCenOutPackets.setfilter("NRESULT_KEY = "+string(lResultKey))<> 1 then
	ls_packets[1] = '-y-y-y-y-y-y-y-y'
	of_trace("of_generate_handling_meals", 1,arg_rowcount+"Error Filter Packages: " +of_checknull(sAirline +string(lFlightNumber)+" "+ sTLCFrom +"-"+sTLCTo))
	lb_NoPackets = true // 12.01.2016 HR:
else
	dsCenOutPackets.filter()
	
	if dsCenOutPackets.rowcount()>0 then
		for xx=1 to dsCenOutPackets.rowcount()
			if xx > 1000 then
				of_trace("of_generate_handling_meals", 1,arg_rowcount+"skip Packages more then 1000 " +of_checknull(sAirline +string(lFlightNumber)+" "+ sTLCFrom +"-"+sTLCTo)+": "+string(dsCenOutPackets.rowcount()))
				lb_NoPackets = false // 12.01.2016 HR:
				exit
			else
				// 17.05.2011 HR: Schalter muss ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
				if ib_check_cfs_packetclass then
					ls_packets[xx] = dsCenOutPackets.getitemstring(xx,"cpacket_class") + ' - ' +string(dsCenOutPackets.getitemnumber(xx,"nairline_packages_key"))
				else
					ls_packets[xx] = 'A-L-L-E' + ' - ' +string(dsCenOutPackets.getitemnumber(xx,"nairline_packages_key"))
				end if
			end if
		next
		lb_NoPackets = false // 12.01.2016 HR:
	else
		ls_packets[1] = '-y-y-y-y-y-y-y-y'
		lb_NoPackets = true // 12.01.2016 HR:
	end if
end if

dsCenOutPackets.setfilter("")
dsCenOutPackets.filter()

lds_sky = create datastore
lds_sky.dataobject="dw_generate_handling_meals_dr_packets"
lds_sky.settransobject(SQLCA)

// ---------------------------------------------------------------
// Mahlzeitenermittlung im UserObjekt constructor:  = create uo_meal_calculation
// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
For i = 1 to dsHandling.Rowcount()
	lHandlingId				= dsHandling.Getitemnumber(i,"nhandling_id")
	sHandlingObjectText 	= dsHandling.Getitemstring(i,"ctext")
	lHandlingSort			= dsHandling.Getitemnumber(i,"cen_routingplan_handling_nsort")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.02.2013 HR: wenn lHandlingId ungleich der zu verarbeitenden ist, dann direkt zum n$$HEX1$$e400$$ENDHEX$$chsten 
	// --------------------------------------------------------------------------------------------------------------------
	If lHandlingId <> iHandlingID  Then continue

	// --------------------------------------------------------------------------------------------------------------------
	// 12.01.2016 HR: Wenn es keine Packages gibt, dann k$$HEX1$$f600$$ENDHEX$$nnen wir bei CFS-Packets diese auslassen
	// --------------------------------------------------------------------------------------------------------------------
	if  dsHandling.Getitemnumber(i,"nuse_customer_packets")=1 and lb_NoPackets then continue
	
	lHandling_Key = dsHandling.Getitemnumber(i,"nhandling_key")
	bDefaultAircraftFound = False

	// ----------------------------------------------------
	// Nun der retrieve auf das Handling Objekt
	// ----------------------------------------------------
	dsHandlingMealCover.SetFilter("")
	dsHandlingMealCover.Filter()

	// --------------------------------------------------------------------------------------------------------------------
	// 06.02.2013 HR: Bei Eingeschaltetem CFS-Packet-Schalter wird die Ermittlung der Mahlzeitendefintion 
	//                        ge$$HEX1$$e400$$ENDHEX$$ndert (NAM-CR-12042)
	// --------------------------------------------------------------------------------------------------------------------
	if  dsHandling.getitemnumber(i, "nuse_short_packets") = 1 then
		// --------------------------------------------------------------------------------------------------------------------
		// 06.02.2013 HR: Bei Schalter an holen wir die Infos aus CEN_MEALS_COVER_DR und kopieren sie um
		// --------------------------------------------------------------------------------------------------------------------
		dsHandlingMealCover.reset()

		lds_sky.retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime, sAirline, lFlightNumber, sTLCFrom, lairlinekey, ls_packets, lHandlingJoker, arg_module_type)

		if lds_sky.rowcount()>0 then
			lFind = lds_sky.rowscopy(1,  lds_sky.rowcount(), primary!, dsHandlingMealCover, 1, primary!)
			if lFind <> 1 then
				of_trace("of_generate_handling_meals", 1,arg_rowcount+"Error Copy Rows from lds_sky ("+lds_sky.dataobject +") to dsHandlingMealCover ("+dsHandlingMealCover.dataobject +"): "+string(lFlightNumber)+" Handlingkey: "+string(lHandling_Key))
			end if

		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 18.03.2013 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch wieder den Schalter beim Flug setzen, dass CFS-Packets verwendet werden
		// --------------------------------------------------------------------------------------------------------------------
		xx = dsCenOut.find("NRESULT_KEY="+string(lResultKey), 1, dsCenOut.rowcount())
		if xx>0 then
			dsCenOut.setitem(xx,"ncfs_packets",1)
		else
			of_trace("of_generate_handling_meals", 20,arg_rowcount+"ResultKey "+	string(lResultKey) + " not found in DsCenOut")
		end if
	else
		// --------------------------------------------------------------------------------------------------------------------
		// 06.02.2013 HR: ansonsten wie gehabt
		// --------------------------------------------------------------------------------------------------------------------
		dsHandlingMealCover.Retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime, sAirline, lFlightNumber, sTLCFrom)

	end if
	
	// Pr$$HEX1$$fc00$$ENDHEX$$fung Aircraft-Key
	//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
	sFind = "nsorter = 1 and naircraft_key = " + string(lAircraftKey)
	lFind = dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
	if lFind = 0 then
		
		//2. Pr$$HEX1$$fc00$$ENDHEX$$fung auf Aircraftgruppe
		//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
		sFind = "nsorter = 2 and naircraft_key = " + string(lAircraftKey)
		lFind = dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
		if lFind = 0 then
		
			// -------------------------------------------
			// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung auf nun ein Filter auf die Abfertigungsart
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------
			sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_default = 1" 
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
		
			If dsHandlingMealCover.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				// -------------------------------------------------
				sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_default = 1" 
				dsHandlingMealCover.SetFilter("")
				dsHandlingMealCover.Filter()
				dsHandlingMealCover.SetFilter(sFilter)
				dsHandlingMealCover.Filter()
				lHandlingType = lHandlingJoker
				bDefaultAircraftFound = True
			Else
				lHandlingType = lHandlingTypeKey
				bDefaultAircraftFound = True
			End if
		else
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------
			sFilter = "nsorter = 2 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_key = " + string(lAircraftKey)
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
			If dsHandlingMealCover.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
				// -------------------------------------------------
				sFilter = "nsorter = 2 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_key = " + string(lAircraftKey)
				dsHandlingMealCover.SetFilter("")
				dsHandlingMealCover.Filter()
				dsHandlingMealCover.SetFilter(sFilter)
				dsHandlingMealCover.Filter()
				lHandlingType = lHandlingJoker
			Else
				lHandlingType = lHandlingTypeKey
			End if				
		end if
	else
		// -------------------------------------------
		// und nun ein Filter auf die Abfertigungsart
		//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
		// -------------------------------------------
		sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_key = " + string(lAircraftKey)
		dsHandlingMealCover.SetFilter(sFilter)
		dsHandlingMealCover.Filter()
		If dsHandlingMealCover.Rowcount() <= 0 Then 
			// -------------------------------------------------
			// und nun ein Filter mit lHandlingJoker
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------------
			sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_key = " + string(lAircraftKey)
			dsHandlingMealCover.SetFilter("")
			dsHandlingMealCover.Filter()
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
			lHandlingType = lHandlingJoker
		Else
			lHandlingType = lHandlingTypeKey
		End if	
	End if

	// -------------------------------------------------------------------------
	// Neu: Beladung nur wenn Default Eigner und aktueller Eigner gleich sind
	// -------------------------------------------------------------------------	
	If bDefaultAircraftFound = True Then
		If dsHandlingMealCover.rowcount() > 0 Then
			For xx = dsHandlingMealCover.rowcount() to 1 Step -1
				lCurrentyp		= dsHandlingMealCover.Getitemnumber(xx,"naircraft_key")
				lCurrentOwner 	= dsHandlingMealCover.Getitemnumber(xx,"nairline_owner_key")
				lOwnerOnly		= dsHandlingMealCover.Getitemnumber(xx,"cen_meal_cover_nowner_only")
				If lOwnerOnly = 1 Then
					If lDefaultOwner <> lCurrentOwner Then
						dsHandlingMealCover.deleterow(xx)
					End if		
				End if
			Next	
		End if	
	End if	
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.12.2010 HR: Hier werden bei eingeschalteten CustomerPackages noch die zugeordneten Packages gepr$$HEX1$$fc00$$ENDHEX$$ft
	// --------------------------------------------------------------------------------------------------------------------
	if  dsHandling.Getitemnumber(i,"nuse_customer_packets")=1 and  dsHandling.getitemnumber(i, "nuse_short_packets") =0 then

		lds_sky.dataobject="dw_generate_handling_meals_co_packets"
		lds_sky.settransobject(SQLCA)

		// 31.05.2013 HR: Datum mit in den Retrieve aufgenommen
		lds_sky.retrieve(lairlinekey, ls_packets, dNewGenerationDate)
		
		//if ii_Debug_Save =1 then lds_sky.SaveAs(is_Debug_save_path+"of_generate_handling_meals_1_"+is_flugnummer+"_lds_sky"+string(now(),"hhmmss")+".xls", excel5!, true)

		if lds_sky.rowcount()>0 then
			if lds_sky.find("nhandling_key = "+string(lHandling_Key), 1,lds_sky.rowcount())=0 then 
				//if ii_Debug_Save =1 then dsHandlingMealCover.SaveAs(is_Debug_save_path+"of_generate_handling_meals_2_"+is_flugnummer+"_dsHandlingMealCover_"+string(now(),"hhmmss")+".xls", excel5!, true)

				For xx = dsHandlingMealCover.rowcount() to 1 step -1
					if lds_sky.find("nhandling_key = "+string(dsHandlingMealCover.Getitemnumber(xx,"nhandling_foreign_key")), 1,lds_sky.rowcount())=0 then
						of_trace("of_generate_handling_meals", 20,arg_rowcount+"Handling not found in SKY_EXT: " + &
							"handling_key=" + string(dsHandlingMealCover.Getitemnumber(xx,"nhandling_foreign_key")))

						dsHandlingMealCover.deleterow(xx)											
					end if
				next

				//if ii_Debug_Save =1 then dsHandlingMealCover.SaveAs(is_Debug_save_path+"of_generate_handling_meals_3_"+is_flugnummer+"_dsHandlingMealCover_"+string(now(),"hhmmss")+".xls", excel5!, true)

			else
					of_trace("of_generate_handling_meals", 20,arg_rowcount+"Handling found in SKY_EXT: result_key=" + &
						string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
						", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
						" " + sHandlingObjectText+" "+sAirline+string(lFlightNumber)+sSuffix+" "+string(dNewGenerationDate)+" "+sTLCFrom+"-"+sTLCTo)
			end if
		else
			of_trace("of_generate_handling_meals", 20,arg_rowcount+"SKY_EXT is Emty: result_key=" + &
				string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
				", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
				" " + sHandlingObjectText+" "+sAirline+string(lFlightNumber)+sSuffix+" "+string(dNewGenerationDate)+" "+sTLCFrom+"-"+sTLCTo)
			continue	
		end if
		
		garbagecollect() // 20.06.2012 HR:

		// 11.04.2011 HR: Wir setzen noch das Kennzeichen, das CFS-Packets ber$$HEX1$$fc00$$ENDHEX$$cksichtigt wurden
		xx = dsCenOut.find("NRESULT_KEY="+string(lResultKey), 1, dsCenOut.rowcount())
		if xx>0 then
			dsCenOut.setitem(xx,"ncfs_packets",1)
		else
			of_trace("of_generate_handling_meals", 20,arg_rowcount+"ResultKey "+	string(lResultKey) + " not found in DsCenOut")
		end if
	end if
	
//	If lHandlingId = iHandlingID and dsHandlingMealCover.rowcount() > 0 Then	// 11 oder 5
	If dsHandlingMealCover.rowcount() > 0 Then	// 11 oder 5
		of_trace("of_generate_handling_meals", 20,arg_rowcount+"processing result_key=" + &
						string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
						", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
						" " + sHandlingObjectText)
		// Der Key f$$HEX1$$fc00$$ENDHEX$$r die eigentliche Mahlzeitendefinition ist nhandling_foreign_key
		// (Mahlzeitendefinitionen haben den Handling-Typ 12)
		//
		// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung des AC-Typs und des Handlings
		// Zus$$HEX1$$e400$$ENDHEX$$tzlicher Filter auf dsHandlingMealCover (in uo_generate_meals)!
		uo_generate_meals.lAircraftKey				= lAircraftKey
		uo_generate_meals.lLegnumber				= lLegnumber
		uo_generate_meals.lHandlingTypeKey		= lHandlingType

		// Es wird das komplette Meal-Cover-DW $$HEX1$$fc00$$ENDHEX$$bergeben
		uo_generate_meals.dsCenOutPax				= dsCenOutPax
		uo_generate_meals.dsSPML						= dsCenOutNewSPML
		uo_generate_meals.dsHandlingMealCover	= dsHandlingMealCover
		uo_generate_meals.bcalculateConcDiff		= bcalculateConcDiff
		uo_generate_meals.dGenerationDate			= dNewGenerationDate
		uo_generate_meals.dGenerationDateUTC	= dGenerationDateUTC 		// 01.10.2010 HR: Japantool 
		uo_generate_meals.lResultKey					= lResultKey
		uo_generate_meals.lTransaction				= lTransActionKey
		uo_generate_meals.sClient						= sclient
		uo_generate_meals.lAirlineKey					= lairlinekey
		uo_generate_meals.iStatus 						= iGenerierungsstatus 		// nur f$$HEX1$$fc00$$ENDHEX$$r Changes wichtig
		uo_generate_meals.sApplicationProfile		= s_app.sProfile				// f$$HEX1$$fc00$$ENDHEX$$rs Debugging
		uo_generate_meals.sPlant						= sunit							// 31.01.05
		uo_generate_meals.iDebugLevel				= this.idebug_level
		uo_generate_meals.lFlightStatus				= lFlightStatus					// 04.02.05 REQ-Problem
		uo_generate_meals.lHandlingSort				= lHandlingSort		
		uo_generate_meals.bCallByWebService		= this.bCallByWebService
		uo_generate_meals.dsRatioCache 			= dsRatioCache
		uo_generate_meals.iDelivery					= iDelivery						// 26.10.05 DLV-Problem
		uo_generate_meals.ii_mlFlight					= iMLFlight
		uo_generate_meals.lRoutingPlanDetailKey 	= ll_RoutingPlanDetailKey
		
		// 05.05.2010 HR: Citypair an die Mahlzeitenberechnung $$HEX1$$fc00$$ENDHEX$$bergeben, damit diese f$$HEX1$$fc00$$ENDHEX$$r die Berechnungsart zur Verf$$HEX1$$fc00$$ENDHEX$$gung stehen
		uo_generate_meals.il_tlc_from 				= il_tlc_from
		uo_generate_meals.il_tlc_to 					= il_tlc_to

		// --------------------------------------------------------------------------------------------------------------------
		// 12.08.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r die BOB-Zuspielung werden die Fluginfos ben$$HEX1$$f600$$ENDHEX$$tigt
		// --------------------------------------------------------------------------------------------------------------------
		uo_generate_meals.is_airline 					= sAirline
		uo_generate_meals.is_suffix 					= sSuffix 
		uo_generate_meals.il_flgnr 						= lFlightNumber
		uo_generate_meals.is_tlc_from 				= sTLCFrom

		// Mahlzeitenberechnung f$$HEX1$$fc00$$ENDHEX$$r einen frisch generierten Flug
		if bDelete = true then
			// Modus Generierung
			if uo_generate_meals.uf_start_from_scratch() <> 0 then
				f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
								sunit + "~tuo_generate_meals.uf_start_from_scratch() returns error: " + &
								uo_generate_meals.sErrortext,sTraceFile + "-" + this.sInstanceName + ".log")
			end if
			// Aufgel$$HEX1$$f600$$ENDHEX$$ste Mahlzeit nach cen_out_meals schreiben (passiert in of_update)
		else
			// Modus Change-Modul
			uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
																	// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
			if arg_module_type = 0 then
//					uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
//																			// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutMeals
				uo_generate_meals.dsCurrentMeals		= dsCurrentMeals	// = dw_meals
				uo_generate_meals.dsOldMeals			= dsOldMeals
			else
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutExtra
				uo_generate_meals.dsCurrentMeals		= dsCurrentExtra	// = dw_extra
				uo_generate_meals.dsOldMeals			= dsOldExtra
			end if
			
			// Wichtig: dsCenOutMeals h$$HEX1$$e400$$ENDHEX$$lt Ergebnis der Aufl$$HEX1$$f600$$ENDHEX$$sung und mu$$HEX2$$df002000$$ENDHEX$$vorher gel$$HEX1$$f600$$ENDHEX$$scht werden
			uo_generate_meals.dsCenOutMeals.Reset()
			
			// arg_module_type = 0 = Mahlzeitenbeladung
			// arg_module_type = 1 = Extrabeladung
			
			if arg_module_type = 0 then
				if bCalculateNoMeals then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if
			end if
			
			if arg_module_type = 1 then
				if bCalculateNoExtra then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					// Achtung: Je Mahlzeiten-Baustein ein Aufruf!
					uo_generate_meals.uf_start_change()
				end if
			end if
			
			// neu berechnete Mahlzeiten
			// alt: dsCenOutMeals = uo_generate_meals.dsCenOutMeals
			if arg_module_type = 0 then
				
				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewmeals,s_change.dsnewmeals.RowCount()+1,Primary!)
				// Diese Zeile hat zum L$$HEX1$$f600$$ENDHEX$$schen des Zwischenergebnisses gef$$HEX1$$fc00$$ENDHEX$$hrt:
				//dsCenOutMeals = s_change.dsnewmeals
				
				//f_print_datastore(s_change.dsnewmeals)
				
			else
				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewextra,s_change.dsnewextra.RowCount()+1,Primary!)
			end if
			bCalcMealsWithoutHandling = true
			//f_print_datastore(s_change.dsnewmeals)
			//f_print_datastore(uo_generate_meals.dsCenOutMeals)
		end if
	End if
Next

destroy lds_sky

// Sonderbehandlung (nur im Change-Mode)
// ================
// Wenn ein Flug keine MZ-Handling-Objekte in der Beladedef. zugeordnet hat,
// und alle vorhandenen Mahlzeiten im Flug-Browser aufgenommen wurden,
// dann haben wir den Fall, dass wir trotzdem neue Mengen berechnen m$$HEX1$$fc00$$ENDHEX$$ssen.
// Das ganze aber nur einmal (gesteuert $$HEX1$$fc00$$ENDHEX$$ber bCalcMealsWithoutHandling)!!!

if bDelete = false then
	if bCalcMealsWithoutHandling = false then
		// --------------------------------------------------------------------------------------------------------------------
		// 16.04.2013 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen das Ganze auch f$$HEX1$$fc00$$ENDHEX$$r die Extrabeladung so machen.
		//						(CBASE-DE-EM-12031)
		// --------------------------------------------------------------------------------------------------------------------
		uo_generate_meals.lAircraftKey				= lAircraftKey
		uo_generate_meals.lLegnumber				= lLegnumber
		uo_generate_meals.lHandlingTypeKey		= lHandlingType
		uo_generate_meals.dsCenOutPax				= dsCenOutPax
		uo_generate_meals.dsSPML						= dsCenOutNewSPML
		uo_generate_meals.dsHandlingMealCover	= dsHandlingMealCover
		uo_generate_meals.bcalculateConcDiff		= bcalculateConcDiff
		uo_generate_meals.dGenerationDate			= dNewGenerationDate
		uo_generate_meals.dGenerationDateUTC	= dGenerationDateUTC
		uo_generate_meals.lResultKey					= lResultKey
		uo_generate_meals.lTransaction				= lTransActionKey
		uo_generate_meals.sClient						= sclient
		uo_generate_meals.lAirlineKey					= lairlinekey
		uo_generate_meals.iStatus 						= iGenerierungsstatus // nur f$$HEX1$$fc00$$ENDHEX$$r Changes wichtig
		uo_generate_meals.bCallByWebService		= this.bCallByWebService
		uo_generate_meals.lHandlingSort				= 1	
		uo_generate_meals.sApplicationProfile		= s_app.sProfile
		uo_generate_meals.sPlant						= sunit
		uo_generate_meals.iDebugLevel				= this.idebug_level
		uo_generate_meals.lFlightStatus				= lFlightStatus
		uo_generate_meals.dsRatioCache 			= dsRatioCache
		uo_generate_meals.iDelivery					= iDelivery
		uo_generate_meals.ii_mlFlight					= iMLFlight
		uo_generate_meals.lRoutingPlanDetailKey 	= ll_RoutingPlanDetailKey
		uo_generate_meals.il_tlc_from 				= il_tlc_from
		uo_generate_meals.il_tlc_to 					= il_tlc_to
		uo_generate_meals.is_airline 					= sAirline
		uo_generate_meals.is_suffix 					= sSuffix 
		uo_generate_meals.il_flgnr 						= lFlightNumber
		uo_generate_meals.is_tlc_from 				= sTLCFrom

		if arg_module_type = 0 then
			if dsCenOutMeals.RowCount() > 0 then
				uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
																		// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutMeals
				uo_generate_meals.dsCurrentMeals		= dsCurrentMeals	// = dw_meals
				
				if bCalculateNoMeals then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if

				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewmeals,s_change.dsnewmeals.RowCount()+1,Primary!)
				
			end if
		else
			if dsCenOutExtra.RowCount() > 0 then
				uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
														// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet

				uo_generate_meals.dsCenOutMealsOld	= dsCenOutExtra
				uo_generate_meals.dsCurrentMeals		= dsCurrentExtra	// = dw_extra
				uo_generate_meals.dsOldMeals			= dsOldExtra
				
				uo_generate_meals.dsCenOutMeals.Reset()
				uo_generate_meals.dsHandlingMealCover.reset()
				
				if bCalculateNoExtra then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if

				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewextra,s_change.dsnewextra.RowCount()+1,Primary!)

			end if	
		end if

		bCalcMealsWithoutHandling = true
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
if uo_generate_meals.ids_cen_meals_det_deduction.rowcount() > 0 then
	uo_generate_meals.ids_cen_meals_det_deduction.rowscopy(1, uo_generate_meals.ids_cen_meals_det_deduction.rowcount(), primary!, s_change.dscenmealsdetdeduction, 1, primary!)
	s_change.dscenmealsdetdeduction.sort()
end if

garbagecollect()	// 20.06.2012 HR:


Return True

end function

public function boolean of_generate_handling_meals_new (integer arg_module_type, s_change_flight s_change, string arg_rowcount);//=====================================================================================
// 27.11.2014 HR: Neue testweise Einbau der neuen Datawindow (Wenn alles OK, dann ersetzt die die Funktion of_generate_handling_meals)
//
// of_generate_handling_meals
//
// Mahlzeitenbeladung f$$HEX1$$fc00$$ENDHEX$$r die Fl$$HEX1$$fc00$$ENDHEX$$ge ermitteln
//
// 04.11.2003: Die Extrabeladung kommt dazu
//					Container-Objekt hat Handling-ID 5
//					Definition hat Handling-ID 13
//
// 17.11.2003:	Kurz-Von-An verarbeiten
//
// 21.11.2003:	Extrabeladung f$$HEX1$$fc00$$ENDHEX$$r Change-Gesch$$HEX1$$e400$$ENDHEX$$ft einbauen
//
//	10.12.2003:	bCalculateNoMeals: Schalter "Tausche keine Mahlzeiten"
//					In diesem Fall erfolgt die Mahlzeitenkalkulation mit den Daten von
//					cen_out_meals und nicht mit den Stammdaten!
//
//	21.05.2005:	Neues Feld compute_classnumber in dsHandlingObjects bzw. dsHandlingObjects_CP
//					Nur relevant im Change-Modus
//
//	29.06.2009: dsHandlingObjects aus dsHandlingObjects_LC f$$HEX1$$fc00$$ENDHEX$$llen
//=====================================================================================
long 			lRow,i,j,xx
long			lHandling_Key, lHandlingType
datastore 	dsHandling
string			sFilter,sFind
Long			lPaxtoCalc
integer		iTrafficDay, iHandlingID
long			lFind
boolean		bDefaultAircraftFound
long			lCurrentOwner,lOwnerOnly,lCurrentyp
long			lInfoRow,lHandlingSort
long			ll_RoutingPlanDetailKey
datastore  	lds_sky_mc, lds_sky_packets
long			ll_packets[] // 27.11.2014 HR:

// ------------------------------------------
// Je nach Module-Type unterschiedliche 
// Handling-IDs verwenden
// ------------------------------------------	
if arg_module_type = 0 then
	iHandlingID = 11	// Mahlzeitencontainer
else
	iHandlingID = 5		// Extrabeladungscontainer
end if

// 16.04.2013 HR: Wir setzen den Schalter bei jedem Durchlauf zur$$HEX1$$fc00$$ENDHEX$$ck, damit auch f$$HEX1$$fc00$$ENDHEX$$r die Extrabeladung der Schalter neu ist
//                         (CBASE-DE-EM-12031)
bCalcMealsWithoutHandling = false

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(dNewGenerationDate)
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	

If dNewGenerationDate < Date (2005,1,1) Then
	of_trace("of_generate_handling_meals_new", 1,arg_rowcount + "Bullshit dNewGenerationDate:" + string(dNewGenerationDate))
End if

If dGenerationDate < Date (2005,1,1) Then
	of_trace("of_generate_handling_meals_new", 1,arg_rowcount + "Bullshit dGenerationDate:" + string(dGenerationDate))
End if

// ---------------------------------------------------------------
// Flugnummer oder City Pair, Mix ist nicht m$$HEX1$$f600$$ENDHEX$$glich.
// ---------------------------------------------------------------
	
//	LCL-Fl$$HEX1$$fc00$$ENDHEX$$ge: dsHandlingObjects aus dsHandlingObjects_LC f$$HEX1$$fc00$$ENDHEX$$llen TBR 29.06.2009
IF ii_nlcl_mirror_flag = 1 THEN
	dsHandling = dsHandlingObjects_LCL
ELSE
	dsHandling = dsHandlingObjects
END IF

ll_RoutingPlanDetailKey = lRoutingPlanDetailKey

lRow = dsHandling.find("nhandling_id = " + string(iHandlingID),1,dsHandling.Rowcount())

If lRow <= 0 AND 	ii_nlcl_mirror_flag = 0 THEN // Nur, wenn kein LCL-Flug HR 26.10.2009

	dsHandling = dsHandlingObjects_cp
	ll_RoutingPlanDetailKey = lRoutingPlanDetailKey_CP

	// Suche Citypair: Falls auch nichts, dann ohne Fehler zur$$HEX1$$fc00$$ENDHEX$$ck
	lRow = dsHandling.find("nhandling_id = " + string(iHandlingID),1,dsHandling.Rowcount())
	if lRow <= 0 Then
		// Falls in Change-Mode, dann k$$HEX1$$f600$$ENDHEX$$nnten ausschl. manuell aufgenommene MZ in dsCenOutMeals vorhanden sein
		if bDelete = true then
			return true
		else
			// im change mode, jedoch nur einmal
			if bCalcMealsWithoutHandling = true then
				return true
			end if
		end if
	end if
End if

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
uo_generate_meals.ids_cen_meals_det_deduction.reset()

// 12.08.2010 HR: Dataobject tauschen, damit BOB-Fl$$HEX1$$fc00$$ENDHEX$$ge die BOB-Werte zugespielt werden k$$HEX1$$f600$$ENDHEX$$nnen
uo_generate_meals.uf_change_flightdataobject("dw_change_bob_pax_flight_gen")

lds_sky_mc 			= create datastore
lds_sky_packets 	= create datastore

if dsHandling.Rowcount() > 0 then
	lds_sky_mc.dataobject		="dw_generate_handling_meals_co_packets_nc"
	lds_sky_mc.settransobject(SQLCA)
	
	lds_sky_packets.dataobject 	= lds_sky_mc.dataobject
	lds_sky_packets.settransobject(SQLCA)

	if ib_check_cfs_packetclass then
		dsCenOutPax.setfilter("NRESULT_KEY = "+string(lResultKey))		
		dsCenOutPax.filter()
		
		for xx = 1 to dsCenOutPax.rowcount()
			of_get_co_packetkeys(lResultKey, dsCenOutPax.getitemstring(xx, "cclass"), ll_packets)
			if ll_packets[1]<> -1 then
				lds_sky_mc.retrieve(dNewGenerationDate, ll_packets, dsCenOutPax.getitemnumber(xx, "nclass_number"))
				
				if lds_sky_mc.rowcount()>0 then
					lFind = lds_sky_mc.rowscopy(1,  lds_sky_mc.rowcount(), primary!, lds_sky_packets, 1, primary!)
					if lFind <> 1 then
						of_trace("of_generate_handling_meals_new", 1,arg_rowcount + "Error Copy Rows from lds_sky_mc to lds_sky_packets: "+string(lFlightNumber))
					end if
				end if
			end if
		next
		
		dsCenOutPax.setfilter("")		
		dsCenOutPax.filter()
	else
		//Wenn wir die Klasse nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen m$$HEX1$$fc00$$ENDHEX$$ssen, dann holen wir uns alle Packagekeys und die dazu passenden Handlingobjekte
		of_get_co_packetkeys(lResultKey, "ALL", ll_packets)
		if ll_packets[1]<> -1 then
			lds_sky_packets.retrieve(dNewGenerationDate, ll_packets, 0)
		end if
	end if
end if

// ---------------------------------------------------------------
// Mahlzeitenermittlung im UserObjekt constructor:  = create uo_meal_calculation
// ---------------------------------------------------------------
// Ok, nun durchlaufen wir alle Objekte und holen uns den nhandling_key (der Key des Handlig Objektes)
// ---------------------------------------------------------------
For i = 1 to dsHandling.Rowcount()
	lHandlingId				= dsHandling.Getitemnumber(i,"nhandling_id")
	sHandlingObjectText 	= dsHandling.Getitemstring(i,"ctext")
	lHandlingSort			= dsHandling.Getitemnumber(i,"cen_routingplan_handling_nsort")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.02.2013 HR: wenn lHandlingId ungleich der zu verarbeitenden ist, dann direkt zum n$$HEX1$$e400$$ENDHEX$$chsten 
	// --------------------------------------------------------------------------------------------------------------------
	If lHandlingId <> iHandlingID  Then continue
	
	lHandling_Key 				= dsHandling.Getitemnumber(i,"nhandling_key")
	bDefaultAircraftFound 	= False

	// ----------------------------------------------------
	// Nun der retrieve auf das Handling Objekt
	// ----------------------------------------------------
	dsHandlingMealCover.SetFilter("")
	dsHandlingMealCover.Filter()

	// --------------------------------------------------------------------------------------------------------------------
	// 06.02.2013 HR: Bei Eingeschaltetem CFS-Packet-Schalter wird die Ermittlung der Mahlzeitendefintion 
	//                        ge$$HEX1$$e400$$ENDHEX$$ndert (NAM-CR-12042)
	// --------------------------------------------------------------------------------------------------------------------
	if  dsHandling.getitemnumber(i, "nuse_short_packets") = 1 then
		// --------------------------------------------------------------------------------------------------------------------
		// 06.02.2013 HR: Bei Schalter an holen wir die Infos aus CEN_MEALS_COVER_DR und kopieren sie um
		// --------------------------------------------------------------------------------------------------------------------
		dsHandlingMealCover.reset()

		lds_sky_mc.dataobject="dw_generate_handling_meals_dr_packets_nc"
		lds_sky_mc.settransobject(SQLCA)

		if ib_check_cfs_packetclass then
			//Wenn wir die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen m$$HEX1$$fc00$$ENDHEX$$ssen, dann durchlaufen wir die Klassen des Fluges und holen uns zu dieser Klasse die Packagekeys
			// und die zur Klasse passenden Handlingobjekte und kopieren diese in dsHandlingMealCover zusammen
			dsCenOutPax.setfilter("NRESULT_KEY = "+string(lResultKey))		
			dsCenOutPax.filter()
			
			for xx = 1 to dsCenOutPax.rowcount()
				of_get_co_packetkeys(lResultKey, dsCenOutPax.getitemstring(xx, "cclass"), ll_packets)
				if ll_packets[1]<> -1 then
					lds_sky_mc.retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime, ll_packets, lHandlingJoker, arg_module_type, dsCenOutPax.getitemnumber(xx, "nclass_number"))	
					
					if lds_sky_mc.rowcount()>0 then
						lFind = lds_sky_mc.rowscopy(1,  lds_sky_mc.rowcount(), primary!, dsHandlingMealCover, 1, primary!)
						if lFind <> 1 then
							of_trace("of_generate_handling_meals_new", 1,arg_rowcount + "Error Copy Rows from lds_sky_mc to dsHandlingMealCover: "+string(lFlightNumber)+" Handlingkey: "+string(lHandling_Key))
						end if
					end if
				end if
			next
			
			dsCenOutPax.setfilter("")		
			dsCenOutPax.filter()
		else
			//Wenn wir die Klasse nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen m$$HEX1$$fc00$$ENDHEX$$ssen, dann holen wir uns alle Packagekeys und die dazu passenden Handlingobjekte
			of_get_co_packetkeys(lResultKey, "ALL", ll_packets)
			if ll_packets[1]<> -1 then
				lds_sky_mc.retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime, ll_packets, lHandlingJoker, arg_module_type, 0)	
				
				if lds_sky_mc.rowcount()>0 then
					lFind = lds_sky_mc.rowscopy(1,  lds_sky_mc.rowcount(), primary!, dsHandlingMealCover, 1, primary!)
					if lFind <> 1 then
						of_trace("of_generate_handling_meals_new", 1,arg_rowcount + "Error Copy Rows from lds_sky_mc to dsHandlingMealCover: "+string(lFlightNumber)+" Handlingkey: "+string(lHandling_Key))
					end if
				end if
			end if
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 18.03.2013 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch wieder den Schalter beim Flug setzen, dass CFS-Packets verwendet werden
		// --------------------------------------------------------------------------------------------------------------------
		xx = dsCenOut.find("NRESULT_KEY="+string(lResultKey), 1, dsCenOut.rowcount())
		if xx>0 then
			dsCenOut.setitem(xx,"ncfs_packets",1)
		else
			of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "ResultKey "+	string(lResultKey) + " not found in DsCenOut")
		end if
	else
		// --------------------------------------------------------------------------------------------------------------------
		// 06.02.2013 HR: ansonsten wie gehabt
		// --------------------------------------------------------------------------------------------------------------------
		dsHandlingMealCover.Retrieve(lHandling_Key,dNewGenerationDate,sDepartureTime, sAirline, lFlightNumber, sTLCFrom)
	end if
	
	// Pr$$HEX1$$fc00$$ENDHEX$$fung Aircraft-Key
	//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
	sFind = "nsorter = 1 and naircraft_key = " + string(lAircraftKey)
	lFind 	= dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
	
	if lFind = 0 then
		//2. Pr$$HEX1$$fc00$$ENDHEX$$fung auf Aircraftgruppe
		//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
		sFind = "nsorter = 2 and naircraft_key = " + string(lAircraftKey)
		lFind = dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
		if lFind = 0 then
		
			// -------------------------------------------
			// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung auf nun ein Filter auf die Abfertigungsart
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------
			sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_default = 1" 
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
		
			If dsHandlingMealCover.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				// -------------------------------------------------
				sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_default = 1" 
				dsHandlingMealCover.SetFilter("")
				dsHandlingMealCover.Filter()
				dsHandlingMealCover.SetFilter(sFilter)
				dsHandlingMealCover.Filter()
				lHandlingType = lHandlingJoker
				bDefaultAircraftFound = True
			Else
				lHandlingType = lHandlingTypeKey
				bDefaultAircraftFound = True
			End if
		else
			// -------------------------------------------
			// und nun ein Filter auf die Abfertigungsart
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------
			sFilter = "nsorter = 2 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_key = " + string(lAircraftKey)
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
			If dsHandlingMealCover.Rowcount() <= 0 Then 
				// -------------------------------------------------
				// und nun ein Filter mit lHandlingJoker
				//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
				// -------------------------------------------------
				sFilter = "nsorter = 2 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_key = " + string(lAircraftKey)
				dsHandlingMealCover.SetFilter("")
				dsHandlingMealCover.Filter()
				dsHandlingMealCover.SetFilter(sFilter)
				dsHandlingMealCover.Filter()
				lHandlingType = lHandlingJoker
			Else
				lHandlingType = lHandlingTypeKey
			End if							
		end if
	else
		// -------------------------------------------
		// und nun ein Filter auf die Abfertigungsart
		//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
		// -------------------------------------------
		sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingTypeKey) + " and naircraft_key = " + string(lAircraftKey)
		dsHandlingMealCover.SetFilter(sFilter)
		dsHandlingMealCover.Filter()
		If dsHandlingMealCover.Rowcount() <= 0 Then 
			// -------------------------------------------------
			// und nun ein Filter mit lHandlingJoker
			//10.07.2015 HR: SKYSCOPE-DE-CR-2015-001 Es sollen ACs auch $$HEX1$$fc00$$ENDHEX$$ber Gruppen zugeordnet werden k$$HEX1$$f600$$ENDHEX$$nnen
			// -------------------------------------------------
			sFilter = "nsorter = 1 and nhandling_type_key = " + string(lHandlingJoker) + " and naircraft_key = " + string(lAircraftKey)
			dsHandlingMealCover.SetFilter("")
			dsHandlingMealCover.Filter()
			dsHandlingMealCover.SetFilter(sFilter)
			dsHandlingMealCover.Filter()
			lHandlingType = lHandlingJoker
		Else
			lHandlingType = lHandlingTypeKey
		End if	
	End if

	// -------------------------------------------------------------------------
	// Neu: Beladung nur wenn Default Eigner und aktueller Eigner gleich sind
	// -------------------------------------------------------------------------	
	If bDefaultAircraftFound = True Then
		If dsHandlingMealCover.rowcount() > 0 Then
			For xx = dsHandlingMealCover.rowcount() to 1 Step -1
				lCurrentyp		= dsHandlingMealCover.Getitemnumber(xx,"naircraft_key")
				lCurrentOwner 	= dsHandlingMealCover.Getitemnumber(xx,"nairline_owner_key")
				lOwnerOnly		= dsHandlingMealCover.Getitemnumber(xx,"cen_meal_cover_nowner_only")
				If lOwnerOnly = 1 Then
					If lDefaultOwner <> lCurrentOwner Then
						dsHandlingMealCover.deleterow(xx)
					End if		
				End if
			Next	
		End if	
	End if	
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.12.2010 HR: Hier werden bei eingeschalteten CustomerPackages noch die zugeordneten Packages gepr$$HEX1$$fc00$$ENDHEX$$ft
	// --------------------------------------------------------------------------------------------------------------------
	if  dsHandling.Getitemnumber(i,"nuse_customer_packets")=1 and  dsHandling.getitemnumber(i, "nuse_short_packets") =0 then
		if lds_sky_packets.rowcount() > 0 then
			if lds_sky_packets.find("nhandling_key = "+string(lHandling_Key), 1,lds_sky_packets.rowcount()) = 0 then 
				For xx = dsHandlingMealCover.rowcount() to 1 step -1
					if lds_sky_packets.find("nhandling_key = "+string(dsHandlingMealCover.Getitemnumber(xx,"nhandling_foreign_key")), 1,lds_sky_packets.rowcount()) = 0 then
						of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "Handling not found in SKY_EXT: " + &
							"handling_key=" + string(dsHandlingMealCover.Getitemnumber(xx,"nhandling_foreign_key")))

						dsHandlingMealCover.deleterow(xx)											
					end if
				next
			else
					of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "Handling found in SKY_EXT: result_key=" + &
						string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
						", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
						" " + sHandlingObjectText+" "+sAirline+string(lFlightNumber)+sSuffix+" "+string(dNewGenerationDate)+" "+sTLCFrom+"-"+sTLCTo)
			end if
		else
			of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "SKY_EXT is Emty: result_key=" + &
				string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
				", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
				" " + sHandlingObjectText+" "+sAirline+string(lFlightNumber)+sSuffix+" "+string(dNewGenerationDate)+" "+sTLCFrom+"-"+sTLCTo)
			continue	
		end if
		
		garbagecollect() // 20.06.2012 HR:

		// 11.04.2011 HR: Wir setzen noch das Kennzeichen, das CFS-Packets ber$$HEX1$$fc00$$ENDHEX$$cksichtigt wurden
		xx = dsCenOut.find("NRESULT_KEY="+string(lResultKey), 1, dsCenOut.rowcount())
		if xx>0 then
			dsCenOut.setitem(xx,"ncfs_packets",1)
		else
			of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "ResultKey "+	string(lResultKey) + " not found in DsCenOut")
		end if
	end if
	
	If dsHandlingMealCover.rowcount() > 0 Then	// 11 oder 5
		of_trace("of_generate_handling_meals_new", 20,arg_rowcount + "processing result_key=" + &
						string(lResultKey) + ", airline_key=" + string(lairlinekey) + &
						", client=" + sunit + ", handling_key=" + string(lHandling_Key)+ &
						" " + sHandlingObjectText)
		// Der Key f$$HEX1$$fc00$$ENDHEX$$r die eigentliche Mahlzeitendefinition ist nhandling_foreign_key (Mahlzeitendefinitionen haben den Handling-Typ 12)
		// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung des AC-Typs und des Handlings
		// Zus$$HEX1$$e400$$ENDHEX$$tzlicher Filter auf dsHandlingMealCover (in uo_generate_meals)!
		uo_generate_meals.lAircraftKey				= lAircraftKey
		uo_generate_meals.lLegnumber				= lLegnumber
		uo_generate_meals.lHandlingTypeKey		= lHandlingType

		// Es wird das komplette Meal-Cover-DW $$HEX1$$fc00$$ENDHEX$$bergeben
		uo_generate_meals.dsCenOutPax				= dsCenOutPax
		uo_generate_meals.dsSPML						= dsCenOutNewSPML
		uo_generate_meals.dsHandlingMealCover	= dsHandlingMealCover
		uo_generate_meals.bcalculateConcDiff		= bcalculateConcDiff
		
		uo_generate_meals.dGenerationDate			= dNewGenerationDate

		// 01.10.2010 HR: Japantool 
		uo_generate_meals.dGenerationDateUTC	= dGenerationDateUTC
		
		uo_generate_meals.lResultKey					= lResultKey
		uo_generate_meals.lTransaction				= lTransActionKey
		uo_generate_meals.sClient						= sclient
		uo_generate_meals.lAirlineKey					= lairlinekey
		uo_generate_meals.iStatus 						= iGenerierungsstatus 		// nur f$$HEX1$$fc00$$ENDHEX$$r Changes wichtig
		uo_generate_meals.sApplicationProfile		= s_app.sProfile				// f$$HEX1$$fc00$$ENDHEX$$rs Debugging
		uo_generate_meals.sPlant						= sunit							// 31.01.05
		uo_generate_meals.iDebugLevel				= this.idebug_level
		uo_generate_meals.lFlightStatus				= lFlightStatus					// 04.02.05 REQ-Problem
		uo_generate_meals.lHandlingSort				= lHandlingSort		
		uo_generate_meals.bCallByWebService		= this.bCallByWebService
		
		uo_generate_meals.dsRatioCache 			= dsRatioCache
		uo_generate_meals.iDelivery					= iDelivery						// 26.10.05 DLV-Problem
		uo_generate_meals.ii_mlFlight					= iMLFlight
		uo_generate_meals.lRoutingPlanDetailKey 	= ll_RoutingPlanDetailKey
		
		// 05.05.2010 HR: Citypair an die Mahlzeitenberechnung $$HEX1$$fc00$$ENDHEX$$bergeben, damit diese f$$HEX1$$fc00$$ENDHEX$$r die Berechnungsart zur Verf$$HEX1$$fc00$$ENDHEX$$gung stehen
		uo_generate_meals.il_tlc_from 				= il_tlc_from
		uo_generate_meals.il_tlc_to 					= il_tlc_to

		// --------------------------------------------------------------------------------------------------------------------
		// 12.08.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r die BOB-Zuspielung werden die Fluginfos ben$$HEX1$$f600$$ENDHEX$$tigt
		// --------------------------------------------------------------------------------------------------------------------
		uo_generate_meals.is_airline 					= sAirline
		uo_generate_meals.is_suffix 					= sSuffix 
		uo_generate_meals.il_flgnr 						= lFlightNumber
		uo_generate_meals.is_tlc_from 				= sTLCFrom

		// Mahlzeitenberechnung f$$HEX1$$fc00$$ENDHEX$$r einen frisch generierten Flug
		if bDelete = true then
			// Modus Generierung
			if uo_generate_meals.uf_start_from_scratch() <> 0 then
				f_job_error(string(dGenerationDate,"dd.mm.yyyy") + "~t" + sclient + "~t" + &
								sunit + "~tuo_generate_meals.uf_start_from_scratch() returns error: " + &
								uo_generate_meals.sErrortext,sTraceFile + "-" + this.sInstanceName + ".log")
			end if
			// Aufgel$$HEX1$$f600$$ENDHEX$$ste Mahlzeit nach cen_out_meals schreiben (passiert in of_update)
		else
			// Modus Change-Modul
			uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
																	// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
			if arg_module_type = 0 then
//					uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
//																			// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutMeals
				uo_generate_meals.dsCurrentMeals		= dsCurrentMeals	// = dw_meals
				uo_generate_meals.dsOldMeals			= dsOldMeals
			else
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutExtra
				uo_generate_meals.dsCurrentMeals		= dsCurrentExtra	// = dw_extra
				uo_generate_meals.dsOldMeals			= dsOldExtra
			end if
			
			// Wichtig: dsCenOutMeals h$$HEX1$$e400$$ENDHEX$$lt Ergebnis der Aufl$$HEX1$$f600$$ENDHEX$$sung und mu$$HEX2$$df002000$$ENDHEX$$vorher gel$$HEX1$$f600$$ENDHEX$$scht werden
			uo_generate_meals.dsCenOutMeals.Reset()
			
			// arg_module_type = 0 = Mahlzeitenbeladung
			// arg_module_type = 1 = Extrabeladung
			
			if arg_module_type = 0 then
				if bCalculateNoMeals then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if
			end if
			
			if arg_module_type = 1 then
				if bCalculateNoExtra then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					// Achtung: Je Mahlzeiten-Baustein ein Aufruf!
					uo_generate_meals.uf_start_change()
				end if
			end if
			
			// neu berechnete Mahlzeiten
			// alt: dsCenOutMeals = uo_generate_meals.dsCenOutMeals
			if arg_module_type = 0 then
				
				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewmeals,s_change.dsnewmeals.RowCount()+1,Primary!)
				// Diese Zeile hat zum L$$HEX1$$f600$$ENDHEX$$schen des Zwischenergebnisses gef$$HEX1$$fc00$$ENDHEX$$hrt:
				//dsCenOutMeals = s_change.dsnewmeals
				
				//f_print_datastore(s_change.dsnewmeals)
				
			else
				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewextra,s_change.dsnewextra.RowCount()+1,Primary!)
			end if
			bCalcMealsWithoutHandling = true
			//f_print_datastore(s_change.dsnewmeals)
			//f_print_datastore(uo_generate_meals.dsCenOutMeals)
		end if
	End if
Next

destroy lds_sky_mc
destroy lds_sky_packets

// Sonderbehandlung (nur im Change-Mode)
// ================
// Wenn ein Flug keine MZ-Handling-Objekte in der Beladedef. zugeordnet hat,
// und alle vorhandenen Mahlzeiten im Flug-Browser aufgenommen wurden,
// dann haben wir den Fall, dass wir trotzdem neue Mengen berechnen m$$HEX1$$fc00$$ENDHEX$$ssen.
// Das ganze aber nur einmal (gesteuert $$HEX1$$fc00$$ENDHEX$$ber bCalcMealsWithoutHandling)!!!

if bDelete = false then
	if bCalcMealsWithoutHandling = false then
		uo_generate_meals.lAircraftKey				= lAircraftKey
		uo_generate_meals.lLegnumber				= lLegnumber
		uo_generate_meals.lHandlingTypeKey		= lHandlingType
		uo_generate_meals.dsCenOutPax				= dsCenOutPax
		uo_generate_meals.dsSPML						= dsCenOutNewSPML
		uo_generate_meals.dsHandlingMealCover	= dsHandlingMealCover
		uo_generate_meals.bcalculateConcDiff		= bcalculateConcDiff
		uo_generate_meals.dGenerationDate			= dNewGenerationDate
		uo_generate_meals.dGenerationDateUTC	= dGenerationDateUTC
		uo_generate_meals.lResultKey					= lResultKey
		uo_generate_meals.lTransaction				= lTransActionKey
		uo_generate_meals.sClient						= sclient
		uo_generate_meals.lAirlineKey					= lairlinekey
		uo_generate_meals.iStatus 						= iGenerierungsstatus // nur f$$HEX1$$fc00$$ENDHEX$$r Changes wichtig
		uo_generate_meals.bCallByWebService		= this.bCallByWebService
		uo_generate_meals.lHandlingSort				= 1	
		uo_generate_meals.sApplicationProfile		= s_app.sProfile
		uo_generate_meals.sPlant						= sunit
		uo_generate_meals.iDebugLevel				= this.idebug_level
		uo_generate_meals.lFlightStatus				= lFlightStatus
		uo_generate_meals.dsRatioCache 			= dsRatioCache
		uo_generate_meals.iDelivery					= iDelivery
		uo_generate_meals.ii_mlFlight					= iMLFlight
		uo_generate_meals.lRoutingPlanDetailKey 	= ll_RoutingPlanDetailKey
		uo_generate_meals.il_tlc_from 				= il_tlc_from
		uo_generate_meals.il_tlc_to 					= il_tlc_to
		uo_generate_meals.is_airline 					= sAirline
		uo_generate_meals.is_suffix 					= sSuffix 
		uo_generate_meals.il_flgnr 						= lFlightNumber
		uo_generate_meals.is_tlc_from 				= sTLCFrom

		if arg_module_type = 0 then
			if dsCenOutMeals.RowCount() > 0 then
				uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf
																		// s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet
				uo_generate_meals.dsCenOutMealsOld	= dsCenOutMeals
				uo_generate_meals.dsCurrentMeals		= dsCurrentMeals	// = dw_meals
				
				if bCalculateNoMeals then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if

				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewmeals,s_change.dsnewmeals.RowCount()+1,Primary!)
				
			end if
		else
			if dsCenOutExtra.RowCount() > 0 then
				uo_generate_meals.uf_switch_datasource()	// Hier wurde beim zweimaligen Aufruf s_change.dspriormeals gepl$$HEX1$$e400$$ENDHEX$$ttet

				uo_generate_meals.dsCenOutMealsOld	= dsCenOutExtra
				uo_generate_meals.dsCurrentMeals		= dsCurrentExtra
				uo_generate_meals.dsOldMeals			= dsOldExtra
				
				uo_generate_meals.dsCenOutMeals.Reset()
				uo_generate_meals.dsHandlingMealCover.reset()
				
				if bCalculateNoExtra then
					// Mahlzeiten aufgrund cen_out_meals berechnen
					uo_generate_meals.uf_start_change_on_cen_out()
				else
					// Mahlzeiten aufgrund von Stammdaten berechnen
					uo_generate_meals.uf_start_change()
				end if

				uo_generate_meals.dsCenOutMeals.RowsCopy(1,uo_generate_meals.dsCenOutMeals.RowCount(),Primary!,&
										s_change.dsnewextra,s_change.dsnewextra.RowCount()+1,Primary!)

			end if	
		end if

		bCalcMealsWithoutHandling = true
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
if uo_generate_meals.ids_cen_meals_det_deduction.rowcount() > 0 then
	uo_generate_meals.ids_cen_meals_det_deduction.rowscopy(1, uo_generate_meals.ids_cen_meals_det_deduction.rowcount(), primary!, s_change.dscenmealsdetdeduction, 1, primary!)
	s_change.dscenmealsdetdeduction.sort()
end if

garbagecollect()	// 20.06.2012 HR:

Return True

end function

public function integer of_checkpoint_push (long arg_nresult_key, integer arg_status);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_checkpoint_push (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_nresult_key		Result_key des Fluges
//  integer arg_status 		
//              1: AC-Change
//			   2: CX
//			   3: CX-Zur$$HEX1$$fc00$$ENDHEX$$ckgenommen 
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
//  09.03.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// 26.03.2015 HR: Funktion in einen eigenen Service ausgelagert, der auf $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen reagiert
// --------------------------------------------------------------------------------------------------------------------
return 1

/*
Long							ll_rc, ll_row
String							ls_push
String							ls_ret
String							ls_kind
String							ls_null
DateTime					ldt_null

uo_json_object				luo_json, luo_pointer
uo_json_array				luo_json_arrays
n_push_service				lnvo_push
uo_generate_datastore	lds

setnull(ls_null)
setnull(ldt_null)

lds = create uo_generate_datastore
lds.dataobject="dw_cen_out_checkpt"
lds.settransobject(SQLCA)
lds.setfilter(" ncheckpt_state > 0 ")

lds.retrieve(arg_nresult_key)

if lds.rowcount() = 0 then 
	destroy lds
	return 1
end if

choose case arg_status
	case 1
		ls_kind = "CheckpointAircraftChange"
	case 2
		ls_kind = "CheckpointFlightCancellation"
	case else
		destroy lds
		return 1
end choose

lnvo_push = Create n_push_service

luo_json = Create uo_json_object
luo_json.of_append_keyvalue("EAServerCheckpointPushNotificationJSON", "v1.0")

luo_pointer = luo_json.of_append_object("PushNotification")
luo_pointer.of_append_keyvalue("nresult_key", string(arg_nresult_key))

luo_json_arrays = luo_pointer.of_append_array( "Checkpoints")

for ll_row = 1 to lds.rowcount()
	lds.setitem(ll_row, "ncheckpt_state", 0)
	
	luo_pointer = luo_json_arrays.of_append_object()
	luo_pointer.of_append_keyvalue("ncheckpoint_key", string(lds.getitemnumber(ll_row, "ncheckpoint_key")))
	luo_pointer.of_append_keyvalue("ncheckpt_state", "0") // 12.03.2015 HR: Wird auch ben$$HEX1$$f600$$ENDHEX$$tigt
	
	if not isnull(lds.getitemstring(ll_row, "cuser")) then
		luo_pointer.of_append_keyvalue("cuser", "")
		lds.setitem(ll_row, "cuser", ls_null)
	end if
	
	if not isnull(lds.getitemstring(ll_row, "cremark")) then
		luo_pointer.of_append_keyvalue("cremark", "")
		lds.setitem(ll_row, "cremark", ls_null)
	end if
	
	if not isnull(lds.getitemdatetime(ll_row, "dcheckpt_real_time")) then
		luo_pointer.of_append_keyvalue("dcheckpt_real_time", "")
		lds.setitem(ll_row, "dcheckpt_real_time", ldt_null)
	end if

next

ls_push = luo_json.of_get_json_string()

ls_ret = lnvo_push.of_send(ls_kind, ls_push)

ll_rc = lds.update()

destroy luo_pointer
destroy luo_json_arrays
destroy luo_json
destroy lnvo_push
destroy lds

return 1
*/
end function

public function boolean of_reduce_overload (s_change_flight s_change);//-------------------------------------------------------------------------------
//
// of_reduce_overload
//
//-------------------------------------------------------------------------------
//
// $$HEX1$$dc00$$ENDHEX$$berbeladung von Mahlzeiten kann erst nach der vollst$$HEX1$$e400$$ENDHEX$$ndigen Erstellung der
// Mahlzeitenbeladung reduziert werden, da die einzelnen Handling Objekte keiner
// Klassensortierung folgen.
//
//-------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
if s_change.dscenmealsdetdeduction.rowcount() > 0 then
	uo_generate_meals.ids_cen_meals_det_deduction.reset()
	
	s_change.dscenmealsdetdeduction.rowscopy(1, s_change.dscenmealsdetdeduction.rowcount(), primary!, uo_generate_meals.ids_cen_meals_det_deduction, 1, primary!)
	uo_generate_meals.ids_cen_meals_det_deduction.sort()
end if

// Meals-Datastore liegt noch im Userobjekt
if uo_generate_meals.uf_reduce_overload() <> 0 then
	return false
end if

return true

end function

public function boolean of_get_handling_from_text (string arg_handling);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_handling_from_text (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_handling
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Sucht f$$HEX1$$fc00$$ENDHEX$$r eine $$HEX1$$fc00$$ENDHEX$$bergebenes Handling die Parameter bei der Airline. Wenn das Handling
//                        bei der Airline nicht vorhanden ist, dann bleiben die Werte aus den Stammdaten
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  01.09.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string ls_desc
long	ll_key

if sHandlingShortText	= arg_handling then 
	return true
end if

// --------------------------------------
// Informationen zum Handling
// --------------------------------------
SELECT nhandling_type_key,
   		   cdescription
  INTO :ll_key,
		 :ls_desc
  FROM cen_handling_types  
WHERE ctext = :arg_handling 
     and nairline_key = :lAirlineKey ;

If sqlca.sqlcode <> 0 Then
	return False
End if

// Wenn wir das Handling f$$HEX1$$fc00$$ENDHEX$$r die Airline gefunden haben, dann $$HEX1$$fc00$$ENDHEX$$bernehmen wir die Werte
of_trace("of_get_handling_from_text", 1,"Change Handling from " + sHandlingShortText + " to " + arg_handling)

lHandlingTypeKey		= ll_key
sHandlingShortText	= arg_handling
sHandlingLongText		= ls_desc

return True	

end function

public function string of_get_job_paxtype (integer arg_type);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_job_paxtype (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer arg_type
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  13.10.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

Choose Case arg_Type
	Case 1
		return "zentrale Auslastung  "
	Case 2
		return "lokale Auslastung    "
	Case 3
		return "aktuelle Passagiere  "
	Case 4
		return "betriebliche Prognose"
	case 5
		return "gebuchte Passagiere (CITP)"
	case 6
		return "gebuchte Passagiere + PAD (CITP)"
	case 7
		return "erwartetet Passagiere (CITP)"
	case 8
		return "erwartetet Passagiere + PAD (CITP)"
	case 9
		return "lokale Anpassungen"
	case 10
		return "(gebuchte + erwartetet Passagiere) / 2"
	Case else
		return "Unknown PaxType " + of_checknull(string(arg_Type)) 
End Choose
end function

public function integer of_set_jobs_to_ignore (integer arg_kind);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_set_jobs_to_ignore (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer arg_kind		0: Alle Jobs auf IGNORE
//							1: Nur OnlineExplosion Jobs auf IGNORE
//							2: Nur FlightCalc Jobs auf IGNORE
//							3: Nur DocEngine Jobs auf IGNORE
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:		Setzt offene Jobs auf Status IGNORE, so dass diese nicht w$$HEX1$$e400$$ENDHEX$$hrend der Generierung
//                             ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden und sie sich gegenseitig blockieren
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  14.10.2015	   1.0      H.Rothenbach   Erstellung
// --------------------------------------------------------------------------------------------------------------------

transaction 	sqlca_temp

sqlca_temp 					= create transaction
sqlca_temp.DBMS 			= sqlca.DBMS 	
sqlca_temp.ServerName = sqlca.ServerName
sqlca_temp.AutoCommit 	= False
sqlca_temp.DBParm 		= sqlca.DBParm
sqlca_temp.LogPass 		= s_app.suserpassword
sqlca_temp.LogId 			= SQLCA.LogId 

connect using sqlca_temp;

if sqlca_temp.sqlcode<>0 then
	of_trace("of_set_jobs_to_ignore", 1,"Error connect "+ string(sqlca_temp.sqlcode) )
	destroy sqlca_temp
	return -3
end if

f_set_logon_role(sqlca_temp)

// --------------------------------------------------------------------------------------------------------------------
// Sollen OnlineExplosion-Jobs auf IGNORE gesetzt werden?
// --------------------------------------------------------------------------------------------------------------------
if arg_kind = 0 or arg_kind = 1 then
	UPDATE sys_explosion 
	      SET nprocess_status 		= 7,
			    DSTART_COMPUTING	= sysdate,
			    DSTOP_COMPUTING 	= sysdate,
				CVALUE 					= 'new Gen.' 
	  WHERE nprocess_status < 3 
	       and nresult_key IN ( SELECT NRESULT_KEY 
	   								   FROM cen_out 
									WHERE dgeneration_date 	= :dGenerationDate 
									     and cclient	  				= :sclient 
										 and cunit		  			= :sunit 
										 and nairline_key 			= :lAirlineKey 
										 and NNOTREGENERATE 	= 0)
	using sqlca_temp;
	
	of_trace("of_set_jobs_to_ignore", 1,"Set "+string(sqlca_temp.sqlnrows)+" Explosion - Jobs to ignore" )
	commit using sqlca_temp;
end if

// --------------------------------------------------------------------------------------------------------------------
// Sollen FlightClac-Jobs auf IGNORE gesetzt werden?
// --------------------------------------------------------------------------------------------------------------------
if arg_kind = 0 or arg_kind = 2 then
	UPDATE sys_queue_flight_calc 
	      SET nprocess_status 		= 7,
			    DSTART_COMPUTING	= sysdate,
			    DSTOP_COMPUTING 	= sysdate,
			    cerror						= 'new Gen.'
	  WHERE nprocess_status < 3 
	       and nresult_key IN ( SELECT NRESULT_KEY 
	   								   FROM cen_out 
									WHERE dgeneration_date 	= :dGenerationDate 
									     and cclient	  				= :sclient 
										 and cunit		  			= :sunit 
										 and nairline_key 			= :lAirlineKey 
										 and NNOTREGENERATE 	= 0)
	using sqlca_temp;
	
	of_trace("of_set_jobs_to_ignore", 1,"Set "+string(sqlca_temp.sqlnrows)+" FlightCalc - Jobs to ignore" )
	commit using sqlca_temp;
end if

// --------------------------------------------------------------------------------------------------------------------
// Sollen DocEngine-Jobs auf IGNORE gesetzt werden?
// --------------------------------------------------------------------------------------------------------------------
if arg_kind = 0 or arg_kind = 3 then
	UPDATE CEN_DOC_GEN_QUEUE 
	      SET 	nprocess_status	= 7,
       			DJOB_START        = sysdate,
       			DJOB_END           	= sysdate
	  WHERE nprocess_status < 3 
	       and nresult_key IN ( SELECT NRESULT_KEY 
	   								   FROM cen_out 
									WHERE dgeneration_date 	= :dGenerationDate 
									     and cclient	  				= :sclient 
										 and cunit		  			= :sunit 
										 and nairline_key 			= :lAirlineKey 
										 and NNOTREGENERATE 	= 0)
	using sqlca_temp;
	
	of_trace("of_set_jobs_to_ignore", 1,"Set "+string(sqlca_temp.sqlnrows)+" DocEngine - Jobs to ignore" )
	commit using sqlca_temp;
end if

disconnect using sqlca_temp;

destroy sqlca_temp

return 1
end function

public function boolean of_get_opcode_per_handling (long al_handling_type_key);
// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_get_opcode_per_handling (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 28.01.2016
//
// Argument(e):
// long al_handling_type_key
//
// Beschreibung:		Holt den Default OP Code zum Handling Typ
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	28.01.2016		Erstellung
//
//
// Return: boolean
//
// --------------------------------------------------------------------------------

String	sText
String	ls_opcode
Long		ll_opcode_key


 SELECT  cen_handling_types.nopcode_key,   
         cen_airline_opcodes.copcode  
    INTO :ll_opcode_key,   
         :ls_opcode  
    FROM cen_airline_opcodes,   
         cen_handling_types  
   WHERE cen_airline_opcodes.nopcode_key (+) = cen_handling_types.nopcode_key
	AND   cen_handling_types.nhandling_type_key = :al_handling_type_key    ;

if sqlca.sqlcode = 0 then
	If not isnull(ll_opcode_key) Then
		lOPCode_Key = ll_opcode_key
		sOpcode = ls_opcode 
	
		return true
	Else
		return false
	End If
else
	return false
end if

end function

public function boolean of_generate_spml_from_extern (long lcenoutrow);// --------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_generate_spml_from_extern (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// long lcenoutrow
// --------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  08.02.2016	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

datetime dtQueryID
long 		i, j, lSPML_Class, lSPML_Quantity, lFound, lFind, lreturn, lSPML_Quantity_Old, iSPML_TopOff_old, lnreq_flight_key
string 	ls_CFLIGHT_KEY, sSPML_Class, sSPML, sSPML_Remark, sOriginal_Remark, sFirstname, sFindString
integer 	iSPML_TopOff

if dsGenerateCenExternalSpml.rowcount()=0 then return true

If IsNull(sSuffix) Or Len(sSuffix) = 0 Then sSuffix = ' '

// -------------------------------------------------
// Es wird erstmal gel$$HEX1$$f600$$ENDHEX$$scht
// -------------------------------------------------
If bDelete = True Then
	delete from cen_out_spml where nresult_key = :lResultKey;
	If SQLCA.SQLCODE <> 0 Then
		return False
	End if	
End if
dsCenOutNewSPML.setfilter("nresult_key = "+string(lresultkey))
dsCenOutNewSPML.filter()

For i = 1 to dsGenerateCenExternalSpml.Rowcount()
 
	lSPML_Class				= dsGenerateCenExternalSpml.GetItemNumber(i,"cen_class_name_nclass_number")
	sSPML_Class			= dsGenerateCenExternalSpml.GetItemString(i,"cclass")
	sSPML					= dsGenerateCenExternalSpml.GetItemString(i,"cspml_code")
	lSPML_Quantity			= dsGenerateCenExternalSpml.GetItemNumber(i,"nquantity")
	sSPML_Remark			= dsGenerateCenExternalSpml.GetItemString(i,"cremark")
	iSPML_TopOff			= dsGenerateCenExternalSpml.GetItemNumber(i,"ntopoff")
	
	if sSPML_Remark = "null" then setnull(sSPML_Remark)

	if len(sSPML_Remark) > 40 then 
		sSPML_Remark="Please refer to station"
	end if
		
	if isnull(iSPML_TopOff) then iSPML_TopOff = 0

	// Nur g$$HEX1$$fc00$$ENDHEX$$ltige SPML eintragen
	lFound = dsValidSPML.Find("cspml = '" + sSPML + "' and nairline_key = " + string(lAirlineKey) &
										,1,dsValidSPML.RowCount())
	if lFound <= 0 then
		// Eintrag auf Fehlerprotokoll?
		continue
	end if
	
	// immer suchen: klasse und spml
	sFindString = "nclass_number = " + string(lSPML_Class) + " and cspml = '" + sSPML + "'"

	if not isnull(sSPML_Remark) then sFindString += " and cadd_text = '" + sSPML_Remark + "'"
	
	lFind = dsCenOutNewSPML.Find(sFindString,1,dsCenOutNewSPML.RowCount())
	
	if lFind = 0 then
		// SPML ist neu

		lReturn = of_insert_new_spml()
		if lReturn > 0 then
			dsCenOutNewSPML.SetItem(lReturn,"cclass",sSPML_Class)
			dsCenOutNewSPML.SetItem(lReturn,"nclass_number",lSPML_Class)
			dsCenOutNewSPML.SetItem(lReturn,"cspml",sSPML)
			dsCenOutNewSPML.SetItem(lReturn,"cadd_text",sSPML_Remark)
			dsCenOutNewSPML.SetItem(lReturn,"nspml_key",dsValidSPML.GetItemNumber(lFound,"nspml_key"))
			dsCenOutNewSPML.SetItem(lReturn,"nquantity",lSPML_Quantity)
			dsCenOutNewSPML.SetItem(lReturn,"ndummy",1)
			dsCenOutNewSPML.SetItem(lReturn,"ntopoff",iSPML_TopOff)
			dsCenOutNewSPML.SetItem(lReturn,"status_nquantity",1)
		end if
	else
		lSPML_Quantity_Old = dsCenOutNewSPML.GetItemNumber(lFind,"nquantity")
		dsCenOutNewSPML.SetItem(lFind,"nquantity",lSPML_Quantity_Old + lSPML_Quantity)
	end if

	dsCenOutNewSPML.SetItem(lFind,"ntopoff",iSPML_TopOff)
next	

return true
end function

public subroutine of_check_packet_handling (long arg_result_key);string ls_ret

dsCenOut.dataobject="dw_cen_out_one_flight"
dsCenOut.settransobject(SQLCA)
dsCenOut.retrieve(arg_result_key)

if dsCenOut.rowcount()<>1 then
	uf.mbox("", "Flug nicht gefunden")
	return
end if

dsCenOutPackets.dataobject="dw_cen_out_packets_all_legs"
dsCenOutPackets.settransobject(SQLCA)
dsCenOutPackets.retrieve(dsCenOut.getitemnumber(1, "nresult_key_group"))

dsCenOutLos.retrieve(dsCenOut.getitemnumber(1, "nresult_key_group"))

sAirline					= dsCenOut.getitemstring(1, "cairline")
lFlightNumber			= dsCenOut.getitemnumber(1, "nflight_number")
sSuffix					= dsCenOut.getitemstring(1, "csuffix")
sTLCFrom				= dsCenOut.getitemstring(1, "ctlc_from")
sTLCTo					= dsCenOut.getitemstring(1, "ctlc_to")
lairlinekey				= dsCenOut.getitemnumber(1, "nairline_key")
dNewGenerationDate 	= date(dsCenOut.getitemdatetime(1, "ddeparture"))

is_check_packets_handling = ""
ib_check_packets_handling = true

of_get_packet_handling(1, arg_result_key, dsCenOut.getitemnumber(1, "nresult_key_group"))

messagebox("Result", is_check_packets_handling)

end subroutine

public function string of_create_cflightkey (date arg_date, string arg_airline, integer arg_flightnumber, string arg_suffix, string arg_tlc_from, string arg_tlc_to);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_generate
// Methode: of_create_cflightkey (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// date arg_date
//  string arg_airline
//  integer arg_flightnumber
//  string arg_suffix
//  string arg_tlc_from
//  string arg_tlc_to
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Funktion um den CFLIGHT_KEY einheitlich zu ermitteln
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  31.05.2016	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string ls_CFLIGHT_KEY

ls_CFLIGHT_KEY = String(arg_date, "YYMMDD") + arg_airline + String(arg_flightnumber, "0000")
		
If IsNULL(arg_suffix) Then
	 ls_CFLIGHT_KEY += " "
Else
	ls_CFLIGHT_KEY += arg_suffix
End If
		
ls_CFLIGHT_KEY += arg_tlc_from + arg_tlc_to
	
return ls_CFLIGHT_KEY
end function

public function boolean of_checkpt_exists (long arg_airline_key, string arg_unit);long lCount

  SELECT count(*)  
     INTO :lCount
    FROM cen_out,   
         	cen_out_checkpt  
   WHERE ( cen_out_checkpt.nresult_key = cen_out.nresult_key ) 
	   and  ( cen_out.nairline_key = :arg_airline_key ) 
	  AND  ( cen_out.cunit = :arg_unit ) ;

if lCount > 0 then
	return true
else
	return false
end if
end function

on uo_generate.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_generate.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// 26.06.2009 HR:
ii_Debug_Save = Integer(ProfileString(s_App.sProfile,"CBASE_Service","DebugSaveXlsFiles","-1"))
if ii_Debug_Save = -1 then
	ii_Debug_Save=0
	SetProfileString(s_App.sProfile,"CBASE_Service","DebugSaveXlsFiles",string(ii_Debug_Save))
end if

// 03.11.2011 HR:
is_Debug_save_path = ProfileString(s_App.sProfile,"CBASE_Service","DebugSaveXlsPath","NONE")
if is_Debug_save_path="NONE" then
	is_Debug_save_path="C:\"
	SetProfileString(s_App.sProfile,"CBASE_Service","DebugSaveXlsPath",is_Debug_save_path)
end if

// Tracing
sTraceFile	= ProfileString(sProfile, "CBASE_Service", "GenerateLog", "d:\temp\")	
sTraceFile	+= "Debug_Generate_" + string(today(),"yyyy-mm-dd")

// ServiceLog
sServiceLogFile = ProfileString(sProfile, "CBASE_Service", "GenerateServiceLog", "d:\temp\")

//08.12.2011 HR: Maximale LogFileGr$$HEX2$$f600df00$$ENDHEX$$e
il_maxlogsize = long (ProfileString(sProfile, "CBASE_Service", "MaxLogSize", "-1"))
if il_maxlogsize= -1 then
	il_maxlogsize=5000000
	SetProfileString(sProfile, "CBASE_Service", "MaxLogSize", string(il_maxlogsize))
end if

dsjobs2generate							= Create DataStore
dsjobs2generate.DataObject			= "dw_jobs2generate_new"

dsjobs2generate.SetTransObject(SQLCA)


dsGenerateSchedule						= Create DataStore
dsGenerateSchedule.DataObject 		= "dw_generate_schedule"
dsGenerateSchedule.SetTransObject(SQLCA)

dsReturnFlightSchedule					= Create DataStore
dsReturnFlightSchedule.DataObject 	= "dw_returnflight_schedule"
dsReturnFlightSchedule.SetTransObject(SQLCA)


dsGenerateRoutingPlan					= Create DataStore
dsGenerateRoutingPlan.DataObject 	= "dw_generate_routingplan"
dsGenerateRoutingPlan.SetTransObject(SQLCA)

//FRE 15.05.2008
dsGenerateRoutingPlanHandling					= Create DataStore
dsGenerateRoutingPlanHandling.DataObject 	= "dw_generate_routingplan_handling"
dsGenerateRoutingPlanHandling.SetTransObject(SQLCA)

dsCenOut										= Create uo_generate_datastore
dsCenOut.DataObject 						= "dw_cen_out"
dsCenOut.SetTransObject(SQLCA)

dsCenOutDebug								= Create uo_generate_datastore
dsCenOutDebug.DataObject 				= "dw_cen_out_debug"
dsCenOutDebug.SetTransObject(SQLCA)


dsGenerateProtocol						= Create uo_generate_datastore
dsGenerateProtocol.DataObject 		= "dw_generate_protocol"
dsGenerateProtocol.SetTransObject(SQLCA)

dsCenOutHandling							= Create uo_generate_datastore
dsCenOutHandling.DataObject 			= "dw_cen_out_handling"
dsCenOutHandling.SetTransObject(SQLCA)

dsHandlingObjects							= Create uo_generate_datastore
dsHandlingObjects.DataObject 			= "dw_generate_handling_objects"
dsHandlingObjects.SetTransObject(SQLCA)

dsHandlingObjects_CP						= Create uo_generate_datastore
dsHandlingObjects_CP.DataObject 		= "dw_generate_handling_objects"
dsHandlingObjects_CP.SetTransObject(SQLCA)

dsHandlingDetail							= Create uo_generate_datastore
dsHandlingDetail.DataObject 			= "dw_generate_handling_detail"
dsHandlingDetail.SetTransObject(SQLCA)

dsTrafficAreas								= Create DataStore
dsTrafficAreas.DataObject 				= "dw_generate_traffic_areas"
dsTrafficAreas.SetTransObject(SQLCA)

dsHandlingNewspaper							= Create uo_generate_datastore
dsHandlingNewspaper.DataObject 			= "dw_generate_handling_newspaper"
dsHandlingNewspaper.SetTransObject(SQLCA)

dsCenOutHandlingNews							= Create uo_generate_datastore
dsCenOutHandlingNews.DataObject 			= "dw_cen_out_handling_news"
dsCenOutHandlingNews.SetTransObject(SQLCA)

dsAirlineClasses								= Create DataStore
dsAirlineClasses.DataObject 				= "dw_generate_classes"
dsAirlineClasses.SetTransObject(SQLCA)

dsAircaftVersion								= Create DataStore
dsAircaftVersion.DataObject 				= "dw_generate_aircraft_classes"
dsAircaftVersion.SetTransObject(SQLCA)

dsCenOutPax										= Create uo_generate_datastore
dsCenOutPax.DataObject 						= "dw_cen_out_pax"
dsCenOutPax.SetTransObject(SQLCA)

dsCentralForecast								= Create uo_generate_datastore
dsCentralForecast.DataObject 				= "dw_generate_central_forecast"
dsCentralForecast.SetTransObject(SQLCA)

dsLocalForecast								= Create uo_generate_datastore
dsLocalForecast.DataObject 				= "dw_generate_local_forecast"
dsLocalForecast.SetTransObject(SQLCA)

dsCrewQuantities								= Create uo_generate_datastore
dsCrewQuantities.DataObject 				= "dw_aircraft_crew_quantity"
dsCrewQuantities.SetTransObject(SQLCA)

dsHandlingQaq									= Create DataStore
dsHandlingQaq.DataObject 					= "dw_generate_handling_qaq"
dsHandlingQaq.SetTransObject(SQLCA)

dsCenOutQAQ										= Create uo_generate_datastore
dsCenOutQAQ.DataObject 						= "dw_cen_out_qaq"
dsCenOutQAQ.SetTransObject(SQLCA)

dsHandlingNewsAddon							= Create DataStore
dsHandlingNewsAddon.DataObject 			= "dw_generate_handling_news_addon"
dsHandlingNewsAddon.SetTransObject(SQLCA)

dsCenOutNewsExtra								= Create uo_generate_datastore
dsCenOutNewsExtra.DataObject 				= "dw_cen_out_handling_news_extra"
dsCenOutNewsExtra.SetTransObject(SQLCA)

dsLocalTimes									= Create DataStore
dsLocalTimes.DataObject 					= "dw_generate_local_times"
dsLocalTimes.SetTransObject(SQLCA)

dsLocalTimesFlights							= Create DataStore
dsLocalTimesFlights.DataObject 			= "dw_generate_local_times_flights"
dsLocalTimesFlights.SetTransObject(SQLCA)

dsGenerateFlight								= Create DataStore
dsGenerateFlight.DataObject 				= "dw_generate_single_flight"
dsGenerateFlight.SetTransObject(SQLCA)

dsFlightData									= Create DataStore
dsFlightData.DataObject 					= "dw_change_flightdata"
dsFlightData.SetTransObject(SQLCA)

dsGenerateNFB									= Create DataStore
dsGenerateNFB.DataObject 					= "dw_generate_nfb"
dsGenerateNFB.SetTransObject(SQLCA)

dsCenOutNFB										= Create uo_generate_datastore
dsCenOutNFB.DataObject 						= "dw_cen_out_nfb"
dsCenOutNFB.SetTransObject(SQLCA)

dsHandlingMealCover								= Create uo_generate_datastore
dsHandlingMealCover.DataObject 				= "dw_generate_handling_meals"
dsHandlingMealCover.SetTransObject(SQLCA)

dsCenOutMeals										= Create uo_generate_datastore
dsCenOutMeals.DataObject 						= "dw_change_cen_out_meals"
dsCenOutMeals.SetTransObject(SQLCA)

dsCenOutExtra										= Create uo_generate_datastore
dsCenOutExtra.DataObject 						= "dw_change_cen_out_meals"
dsCenOutExtra.SetTransObject(SQLCA)

dsGenerateCenExternalSchedule					= Create uo_generate_datastore
dsGenerateCenExternalSchedule.DataObject 	= "dw_generate_cen_external_schedule"
dsGenerateCenExternalSchedule.SetTransObject(SQLCA)

dsGenerateCenExternalSpml						= Create uo_generate_datastore
dsGenerateCenExternalSpml.DataObject 			= "dw_generate_cen_external_spml"
dsGenerateCenExternalSpml.SetTransObject(SQLCA)



dsHandlingTypeCache = create Datastore
dsHandlingTypeCache.dataobject = "dw_handling_type_cache"

uo_calc = create uo_calculation

uo_generate_meals = create  uo_meal_calculation
//uo_generate_meals.uf_change_flightdataobject("dw_change_bob_pax_flight_gen")// 12.08.2010 HR: Dataobject tauschen

dsDeleteMessages									= Create uo_generate_datastore
dsDeleteMessages.DataObject 					= "dw_delete_messages"
dsDeleteMessages.SetTransObject(SQLCA)

dsBillingStatus										= Create uo_generate_datastore
dsBillingStatus.DataObject 						= "dw_settlement_billing_status"
dsBillingStatus.SetTransObject(SQLCA)

dsCustomerCodes										= Create datastore
dsCustomerCodes.DataObject 						= "dw_generate_customer_codes"
dsCustomerCodes.SetTransObject(SQLCA)

dsHandlingInfo										= Create datastore
dsHandlingInfo.DataObject 						= "dw_handling_info"
dsHandlingInfo.SetTransObject(SQLCA)

// Matdispo-Vergleich
dsCenOutDispo										= Create uo_generate_datastore
dsCenOutDispo.DataObject 						= "dw_cen_out_dispo"
dsCenOutDispo.SetTransObject(SQLCA)

dsCenOutDispoDetail								= Create uo_generate_datastore
dsCenOutDispoDetail.DataObject 				= "dw_cen_out_dispo_detail"
dsCenOutDispoDetail.SetTransObject(SQLCA)

// Die Aufl$$HEX1$$f600$$ENDHEX$$sung analog w_info_center
dsExplosion											= Create datastore
dsExplosion.DataObject 							= "dw_explosion_packinglist"
dsExplosion.SetTransObject(SQLCA)

// Alle aufzul$$HEX1$$f600$$ENDHEX$$senden Fl$$HEX1$$fc00$$ENDHEX$$ge
dsFlightsForUnit									= Create datastore
dsFlightsForUnit.DataObject 					= "dw_cen_out_dispo_flights"
dsFlightsForUnit.SetTransObject(SQLCA)

// Charter-Zwischenspeicher
//dsCharterMemory									= Create uo_generate_datastore
//dsCharterMemory.DataObject 					= "dw_cen_out"
dsCharterMemory									= Create DataStore
dsCharterMemory.DataObject 					= "dw_generate_routingplan_group"
dsCharterMemory.SetTransObject(SQLCA)

dsGenerateNonACType									= Create DataStore
dsGenerateNonACType.DataObject 					= "dw_generate_non_actypes"
dsGenerateNonACType.SetTransObject(SQLCA)

dsCenOutCache											= Create DataStore
dsCenOutCache.DataObject 							= "dw_cen_out_cache"
dsCenOutCache.SetTransObject(SQLCA)		

// 23.06.2009 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die QueryPeriodes eines Fluges
dsCenOutQP											= Create uo_generate_datastore
dsCenOutQP.DataObject 							= "dw_cen_out_qp"
dsCenOutQP.SetTransObject(SQLCA)		

// 06.07.2009 HR: AMOS Abl$$HEX1$$f600$$ENDHEX$$sung
dsCITPFlightData									= Create DataStore
dsCITPFlightData.DataObject 					= "dw_change_citp_flightdata"
dsCITPFlightData.SetTransObject(SQLCA)

// 07.07.2009 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Result_keys eines Flugtages
dsResultkeys										= Create DataStore
dsResultkeys.DataObject 							= "dw_cen_out_resultkeys"
dsResultkeys.SetTransObject(SQLCA)		

// 02.09.2009 HR: AMOS Abl$$HEX1$$f600$$ENDHEX$$sung
dsCITPFlightDataSPML									= Create DataStore
dsCITPFlightDataSPML.DataObject 					= "dw_change_citp_flightdata_spml"
dsCITPFlightDataSPML.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------
// 25.11.2009 HR: Datastores f$$HEX1$$fc00$$ENDHEX$$r die SPMLs der Generierung
// --------------------------------------------------------------------------------
dsCenOutAllSPML = create uo_generate_datastore
dsCenOutAllSPML.dataobject = "dw_change_cen_out_spml"
dsCenOutAllSPML.settransobject(SQLCA)

dsCenOutAllSPMLDetail = create uo_generate_datastore
dsCenOutAllSPMLDetail.dataobject = "dw_cen_out_spml_detail"
dsCenOutAllSPMLDetail.settransobject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 23.06.2010 HR: DS mit Fl$$HEX1$$fc00$$ENDHEX$$gen, die nicht neu generiert werden sollen
// --------------------------------------------------------------------------------------------------------------------
dsCenOutNotRegenerate = create uo_generate_datastore
//dsCenOutNotRegenerate.DataObject = "dw_cen_out"
dsCenOutNotRegenerate.DataObject = "dw_cen_out_notregenerate" // 13.04.2015 HR: Neues DW, das direkt nur die Fl$$HEX1$$fc00$$ENDHEX$$ge lie$$HEX1$$df00$$ENDHEX$$t, die das Flag in der Gruppe gesetzt haben
dsCenOutNotRegenerate.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 01.12.2010 HR: DS f$$HEX1$$fc00$$ENDHEX$$r den CFS-Flugplan aus SKY_EXT_SCHED
// --------------------------------------------------------------------------------------------------------------------
dsExtCatSched = create uo_generate_datastore	
dsExtCatSched.dataobject = "dw_generate_cfs_schedule"
dsExtCatSched.Settransobject(sqlca)
//dsExtCatSched.il_write_sql=Integer(ProfileString(s_App.sProfile,"CBASE_Service","SAVE_SQLPREV","0"))

// --------------------------------------------------------------------------------------------------------------------
// 23.06.2010 HR: DS mit Fl$$HEX1$$fc00$$ENDHEX$$gen, die nicht neu generiert werden sollen
// --------------------------------------------------------------------------------------------------------------------
dsCenOutPackets = create uo_generate_datastore
dsCenOutPackets.DataObject = "dw_cen_out_packets"
dsCenOutPackets.SetTransObject(SQLCA)

dsCenOutLos = create uo_generate_datastore
dsCenOutLos.DataObject = "dw_cen_out_los"
dsCenOutLos.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 19.09.2011 HR: Produktionsplanung
// --------------------------------------------------------------------------------------------------------------------
dsCenOutPPM = create uo_generate_datastore
dsCenOutPPM.DataObject = "dw_cen_out_ppm"
dsCenOutPPM.SetTransObject(SQLCA)

dsCenOutPPMStowages = create uo_generate_datastore
dsCenOutPPMStowages.DataObject = "dw_cen_out_ppm_stowages"
dsCenOutPPMStowages.SetTransObject(SQLCA)

dsCenOutPPMMD = create uo_generate_datastore
dsCenOutPPMMD.DataObject = "dw_cen_out_ppm_md"
dsCenOutPPMMD.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 14.01.2015 HR: Flightchecker
// --------------------------------------------------------------------------------------------------------------------
dsCenOutCheckPt = create uo_generate_datastore
dsCenOutCheckPt.DataObject = "dw_cen_out_checkpt"
dsCenOutCheckPt.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 07.07.2015 HR: CBASE-DE-CR-2015-028 Lokale Anpassungen (Umzug aus Funktion of_recalc_pax)
// --------------------------------------------------------------------------------------------------------------------
dsLocal_adjustments = create datastore
dsLocal_adjustments.dataobject="dw_altea_local_adjustments"
dsLocal_adjustments.settransobject(SQLCA)

end event

event destructor;destroy (dsjobs2generate)
destroy (dsGenerateSchedule)
destroy (dsReturnFlightSchedule)
destroy (dsGenerateRoutingPlan)
destroy (dsGenerateRoutingPlanHandling)
destroy (dsCenOut)
destroy (dsCenOutDebug)
destroy (dsGenerateProtocol)
destroy (dsCenOutHandling)
destroy (dsHandlingObjects)
destroy (dsHandlingObjects_CP)
destroy (dsHandlingDetail)
destroy (dsTrafficAreas)
destroy (dsHandlingNewspaper)
destroy (dsCenOutHandlingNews)
destroy (dsAirlineClasses)
destroy (dsAircaftVersion)
destroy (dsCenOutPax)
destroy (dsCentralForecast)
destroy (dsLocalForecast)
destroy (dsHandlingQaq)
destroy (dsCenOutQAQ)
destroy (dsHandlingNewsAddon)
destroy (dsCenOutNewsExtra)
destroy (dsLocalTimes)
destroy (dsLocalTimesFlights)
destroy (dsGenerateFlight)
destroy (dsFlightData)
destroy (dsGenerateNFB)
destroy (dsCenOutNFB)
destroy (dsHandlingMealCover)
destroy (dsCenOutMeals)
destroy (dsCenOutExtra)
destroy (dsGenerateCenExternalSchedule)
destroy (dsGenerateCenExternalSpml)
destroy (uo_calc)
destroy (uo_generate_meals)
destroy (dsDeleteMessages)
destroy (dsBillingStatus)
destroy (dsCustomerCodes)
destroy (dsHandlingInfo)
destroy (dsCenOutDispo)
destroy (dsCenOutDispoDetail)
destroy (dsExplosion)
destroy (dsFlightsForUnit)
destroy (dsCharterMemory)
destroy (dsHandlingTypeCache)
destroy (dsCenOutCache)
destroy (dsGenerateNonACType)
destroy (dsCrewQuantities)
destroy (dsCenOutQP)					// 23.06.2009 HR
destroy (dsCITPFlightData) 			// 06.07.2009 HR: Amos Abl$$HEX1$$f600$$ENDHEX$$sung
destroy (dsResultkeys) 				// 07.07.2009 HR: Amos Abl$$HEX1$$f600$$ENDHEX$$sung
destroy (dsCITPFlightDataSPML)	// 02.09.2009 HR
destroy (dsCenOutAllSPML)			// 25.11.2009 HR
destroy (dsCenOutAllSPMLDetail)	// 25.11.2009 HR
destroy (dsCenOutNotRegenerate) 	// 23.06.2010 HR
destroy (dsExtCatSched)				// 01.12.2010 HR
destroy (dsCenOutPackets)			// 04.04.2011 HR
destroy (dsCenOutLos)				// 04.04.2011 HR
destroy (dsCenOutPPM)				// 19.09.2011 HR
destroy (dsCenOutPPMStowages)	// 19.09.2011 HR
destroy (dsCenOutPPMMD)			// 19.09.2011 HR
destroy (dsCenOutCheckPt) 			// 14.01.2015 HR: Flightchecker
destroy (dsLocal_adjustments)		// 07.07.2015 HR: Lokale Anpassung
garbagecollect()
end event

