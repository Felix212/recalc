HA$PBExportHeader$uo_meal_calculation.sru
$PBExportComments$Userobject zur Generierung der Mahlzeitenbeladung und Durchf$$HEX1$$fc00$$ENDHEX$$hrung aller dazu notwendigen Berechnungen sowie des $$HEX1$$dc00$$ENDHEX$$bertrags der alten Mengen
forward
global type uo_meal_calculation from nonvisualobject
end type
end forward

global type uo_meal_calculation from nonvisualobject
end type
global uo_meal_calculation uo_meal_calculation

type variables
//=================================================================================================
//
// uo_meal_calculation
//
// Userobjekt zur Mahlzeitenberechnung
//
//=================================================================================================
//
// Bitte vor der Verwendung der gew$$HEX1$$fc00$$ENDHEX$$nschten Funktion die Pflicht-Properties setzen!
//
//=================================================================================================
/*
Ben$$HEX1$$f600$$ENDHEX$$tigte Datastores:

- Passagierzahlen
- cen_meal_cover
- cen_meal

Methoden:

*	uf_start_from_scratch
	Erste Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung bei der Flug-Generierung.

*	uf_start_simulation( )
	Simulation einer Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung aus der Stammdatenpflege
	

*/
Public:

boolean 						ib_SLReplaceForACType		= true // 08.06.2016 HR:

// =============================================================================================
//
// Pflicht-Properties f$$HEX1$$fc00$$ENDHEX$$r Generierung
//
// =============================================================================================
long							lResultKey					// Resultkey des Fluges bzw. Legs
date							dGenerationDate			// Datum, f$$HEX1$$fc00$$ENDHEX$$r das die Berechnung durchgef$$HEX1$$fc00$$ENDHEX$$hrt wird
date  						dGenerationDateUTC		// 01.10.2010 HR: Flugdatum in UTC
long							lAircraftKey					// Zugrundeliegender AC-Typ
long							lTransaction					// Die gerade verwendete Transaktion
string						sPlant							// F$$HEX1$$fc00$$ENDHEX$$r welchen Betrieb ist das ganze?
long							lLegnumber					// welches Leg (wg.M-Gang)
datastore					dsCenOutPax				// Passagierzahlen des Legs
long							lFlightStatus = 0			// neu: Flugstatus
Boolean						bCalculateConcDiff	= True	// muss abweichende Beladung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
Long							lRoutingPlanDetailKey

uo_generate_datastore	dsHandlingMealCover		// Meal-Cover-Tabelle f$$HEX1$$fc00$$ENDHEX$$r Flug

Long							il_FillEmptyCustomerPL

integer						iImportBobValues = 0 		// 09.06.2010 HR: Schalter, ob BOB-Werte aus Importtabelle verwendet werden sollen

// zus$$HEX1$$e400$$ENDHEX$$tzlich wegen Matdispo:
string							sClient						// Mandant (zur Vollst$$HEX1$$e400$$ENDHEX$$ndigkeit)
long							lAirlineKey					// Airline-Key f$$HEX1$$fc00$$ENDHEX$$r Matdispo

// Handling-Type ber$$HEX1$$fc00$$ENDHEX$$cksichtigen (Abfertigungsart, nhandling_type_key)
// die in uo_generate gefilterte dsHandlingMealCover liefert zu viele Treffer
long							lHandlingTypeKey

//Unterbeladung
integer						ii_mlFlight

// =============================================================================================
// Pflicht-Properties f$$HEX1$$fc00$$ENDHEX$$r Mahlzeiten$$HEX1$$e400$$ENDHEX$$nderung durch wf_change_center
// =============================================================================================
// Nicht vergessen:
//	lResultKey
//   dGenerationDate
//   lAircraftKey
//   lTransaction
//   sPlant
//	dsCenOutPax
//   dsHandlingMealCover
// =============================================================================================

uo_generate_datastore	dsSPML				// Momentan vorhandene SPML
uo_generate_datastore	dsCenOutMealsOld	// Ergebnisdatastore mit den aufgel$$HEX1$$f600$$ENDHEX$$sten Mahlzeiten
uo_generate_datastore	dsCurrentMeals		// Neu: aufgel$$HEX1$$f600$$ENDHEX$$ste MZ mit aktuellen Anwender$$HEX1$$e400$$ENDHEX$$nderungen
														// z.B. Anzahl der Reserve wurde ge$$HEX1$$e400$$ENDHEX$$ndert
integer						iStatus				// Generierungsstatus
														// nstatus aus cen_out:
														// 1=Gen, 2=Upd, 3=Planung, 4=Prod1, 5=Prod2, ...
uo_generate_datastore	dsOldMeals			// urspr. Mahlzeiteneingaben
integer						iUseSequence = 1	// Sequence verwenden
integer						iDelivery = 0		// Es handelt sich um eine Delivery
Boolean						bCallByWebService = False  // Aufruf $$HEX1$$fc00$$ENDHEX$$ber Web (kein Ausz$$HEX1$$e400$$ENDHEX$$hldidalog nutzen)

// =============================================================================================
// Pflicht-Properties f$$HEX1$$fc00$$ENDHEX$$r Simulation
// =============================================================================================
// Nicht vergessen:
//   dGenerationDate
//   sPlant
// =============================================================================================
long				lSimulatePax			= 0
long				lSimulateSPML
long				lSimulateSPMLKey			// Der Key des zu simulierenden SPML
long				lSimulateVersion

long				lHandlingMealKey			// Sequence aus cen_meals (nhandling_meal_key aus cen_meals)
long				lMCOKey						// Sequence aus cen_mco_details (nmco_key aus cen_mco_details)
//long				lMCORotationKey			// Rotation_Key der f$$HEX1$$fc00$$ENDHEX$$r die MCO Simulation gew$$HEX1$$e400$$ENDHEX$$hlt wurde (nrotation_key aus cen_mco_details)
long				lMCOGroupKey				// MCO_Group_Key der f$$HEX1$$fc00$$ENDHEX$$r die MCO Simulation gew$$HEX1$$e400$$ENDHEX$$hlt wurde (nmco_group_key aus cen_mco_details)
long				lMCOPrio						// nprio wert
String				sMCOClass					// sCurrentClass
integer			ilanguage					// s_app.ilanguage als instanzvariable
string				swerk							// s_app.sWerk als instanzvariable

// =============================================================================================
// Ergebnisse
// =============================================================================================
uo_generate_datastore	dsCenOutMeals	// Ergebnisdatastore mit den aufgel$$HEX1$$f600$$ENDHEX$$sten Mahlzeiten
uo_generate_datastore	dsSPMLDetail	// F$$HEX1$$fc00$$ENDHEX$$r die Ergebnisse der SPML-Kalkulation

// =============================================================================================
// Debugging und Errors
// =============================================================================================
string					sApplicationProfile
string					sErrortext				// Fehlertext
integer				iDebugLevel				= 0
string					sTraceFile				= "d:\temp\debug_meal_calc.txt"

// =============================================================================================
// Interne Properties mit Zugriffserlaubnis von aussen
// =============================================================================================
long					lCalcDetailKey
long					lPax							// Ermittelte Passagierzahl f$$HEX1$$fc00$$ENDHEX$$r Klasse
long					lCalcBasis					// Berechnungsgrundlage

// Gunnar Brosch, 01.11.2012 >>>
long					il_calcbasis_ver				//Analog lCalcBasis alle Berechnungen durchf$$HEX1$$fc00$$ENDHEX$$hren
decimal				idc_quantity_ver			//analog dcQuantity
//<<<

datastore			dsRotationCache			// bereits ermittelte Rotations
														// Rotation-Cache mu$$HEX2$$df002000$$ENDHEX$$von uo_generate aus
														// zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt werden k$$HEX1$$f600$$ENDHEX$$nnen, wenn sich das
														// Datum $$HEX1$$e400$$ENDHEX$$ndert!
long					lHandlingSort				// Sortierung aus Beladedef	

// Ratiolist-Cache kann von aussen gesetzt werden
datastore			dsRatioCache				// Caching Ratiolist

// Public DataStore f$$HEX1$$fc00$$ENDHEX$$r die MCO Simulation
datastore			dsCenMCO

// 05.05.2010 HR: Citypairs f$$HEX1$$fc00$$ENDHEX$$r Berechung uf_calc_percent_cp
long 					il_tlc_from 								= -1
long 					il_tlc_to 									= -1

// --------------------------------------------------------------------------------------------------------------------
// 12.08.2010 HR:
// --------------------------------------------------------------------------------------------------------------------
string 				is_airline
string 				is_suffix
long 					il_flgnr
string 				is_tlc_from


// --------------------------------------------------------------------------------------------------------------------
// 17.01.2011 HR: 
// --------------------------------------------------------------------------------------------------------------------
boolean 				ib_OnlySimulation 						= false  
integer				ii_class_numbers[]
integer				ii_pax_numbers[]
integer				ii_version_numbers[]
string					is_class_names[]
long					il_nlocal_sub_flight 					= 0   		// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)

// --------------------------------------------------------------------------------------------------------------------
// 01.03.2013 KF: 
// --------------------------------------------------------------------------------------------------------------------
integer				iIgnoreReserve 						= 0 		// Schalter wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r die RUS Return Meal Calculation im Buchungsbrowser 
long					lManuelReserveReturnMealCalc 				// Schalter wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r die RUS Return Meal Calculation im Buchungsbrowser 
Integer				iIgnoreTopOff 							= 0		// Schalter wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r die RUS Return Meal Calculation im Buchungsbrowser 
Boolean				bInReturnCalcMode 					= False 	// Schalter wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r die RUS Return Meal Calculation im Buchungsbrowser 

// --------------------------------------------------------------------------------------------------------------------
// 15.07.2015 HR: CBASE-DE-CR-2015-049
// --------------------------------------------------------------------------------------------------------------------
datastore			ids_ask4passenger
boolean				ib_ask4passenger 						= true

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
datastore			ids_cen_meals_det_deduction

// =============================================================================================
// =============================================================================================
// Interne Properties
// =============================================================================================
// =============================================================================================
private:
long					lMasterKey					// = cen_meals.nhandling_meal_key

// Steuerung $$HEX1$$dc00$$ENDHEX$$berbeladung
long					lMasterKeyOld
long					lComponentGroupOld

long					lPaxManual	=  0			// User gibt abweichende Pax-Zahl ein (Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog)
integer				iVersion						// Die Versionsgrenze f$$HEX1$$fc00$$ENDHEX$$r diese Klasse
long					lCurrentRow					// Aktuelle Zeile im Meal-Datastore

long					lClassNumber
long					lCalcID

long					lRotation_key				// Key des Umlauf-Objekts
long					lRotationNameKey			// Key des aktuellen Umlaufs
string					sRotation						// Umlaufbuchstabe des aktuellen Umlaufs

long					lHandlingDetailKey			// Sequence aus Mahlzeit (nhandling_detail_key aus cen_meals_detail)
long					lHandlingCoverKey			// Handling-Key des Cover-Objekts (nhandling_key aus cen_meal_cover)
long					lHandlingKey				// Handling-Key des Meal-Objekts (nhandling_key aus cen_meals)
long					lHandlingKeyOld			// Handling-Key des Meal-Objekts zum Steuern von

// Mahlzeitenwechsel
//
// Manuell aufgenommene Reserven (dsCurrentMeals)
//
long					lManualReserveQuantity
long					lManualTopOffQuantity

long					lReserveQuantity
long					lTopOffQuantity
integer				iReserveType
integer				iTopOffType
integer				iModuleType				// Typ der Definition (Mahlzeit, NonFood, ...)
integer				iAsk4Passenger				// 1 = Gruppen sollen ausgez$$HEX1$$e400$$ENDHEX$$hlt werden
integer				iPassengerGroup			// 1 = Mahlzeit geh$$HEX1$$f600$$ENDHEX$$rt zu der ausgez$$HEX1$$e400$$ENDHEX$$hlten Gruppe
integer				iPlanningPercent			// F$$HEX1$$fc00$$ENDHEX$$r Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialoge: Dieser Prozentsatz soll bei
														// der Generierung f$$HEX1$$fc00$$ENDHEX$$r diese Gruppe zugrundegelegt werden.
long					lQuantityGroup				// Menge, die bei Ausz$$HEX1$$e400$$ENDHEX$$hlung eingegeben wurde
string					sUnit							// die Einheit der St$$HEX1$$fc00$$ENDHEX$$ckliste
integer				iComponentGroup
long					lCoverPrio					// Sortierung im Container-Objekt cen_meals_cover
long					lMealsDetailPrio			// Sortierung innerhalb der Mahlzeit
long					lPackinglistIndexKey		// Die zu berechnende Packinglist
long					lPackinglistDetailKey		// Der f$$HEX1$$fc00$$ENDHEX$$r diesen Zeitpunkt zutreffende Detail-Key
long					lMopDetailKey				// Key zum Mop-Detail
long					lForeignObject				// Mahlzeit, mit der eine $$HEX1$$dc00$$ENDHEX$$berbeladung zu verrechnen ist
integer				iForeignGroup				// Gruppe,  mit der eine $$HEX1$$dc00$$ENDHEX$$berbeladung zu verrechnen ist
long					lAccountKey					// Key des Von-An-Codes
long					lDefaultAccountKey		// Key des Kopf-Von-An-Codes
Long					il_spml_count				// SPML count for calc_id 45
integer				iBillingStatus				// 0 = P/A, 1 = P, 2 = Abrechnung
integer				iPercentage					// 
integer				iSPMLDeduction			// SPML-Abzug auf Componentenebene
integer				iACTransfer					// $$HEX1$$dc00$$ENDHEX$$bertrag der Infos nach einem AC-Change
string					sClass
string					sQuestionText				// Die Frage, die bei der Ausz$$HEX1$$e400$$ENDHEX$$hlung gestellt wird
string					sMealControlCode
string					sProductionText
string					sRemark						// Bemerkungsfeld zur Info f$$HEX1$$fc00$$ENDHEX$$r den Dispatcher
string					sHandlingText				// Text des Handling-Objekts
string					sPackinglist					// St$$HEX1$$fc00$$ENDHEX$$ckliste
string					sHandlingCoverText		// Text des Cover-Objekts
string					sMultiClasses				// F$$HEX1$$fc00$$ENDHEX$$r calc_ids 29 bis 60

string					sProductionTextReplace=""		//Variable f$$HEX1$$fc00$$ENDHEX$$r den neuen Produktionstext bei Rati2 mit Texttausch HR 07.07.2008
string					sProductionTextReplace_ver=""	//08.11.12, Gunnar Brosch: QuantityVersion

decimal				dcValue
decimal				dcQuantity
decimal				dcOldQuantity

long					lOverloadSet				// Menge der $$HEX1$$dc00$$ENDHEX$$berbeladenen Mahlzeiten zum Speichern
long					lOverloadSet_ver			//05.11.12, Gunnar Brosch: QuantityVersion
long					lOverloadGet				// $$HEX1$$dc00$$ENDHEX$$berbeladenen Mahlzeiten holen
long					lOverloadInRow			// Zeile in dsCenOutMeals, in der die $$HEX1$$dc00$$ENDHEX$$berbeladung
														// gefunden wurde (gleichzeitig ein Signal)

long					lPLTypeKey					// Der St$$HEX1$$fc00$$ENDHEX$$cklistentyp der Einzelst$$HEX1$$fc00$$ENDHEX$$ckliste
														// aus sys_packinglist_types
														
uo_get_rotation 	uoRotation					// Umlaufobjekt

boolean 				bInSimulation 	= false	// Falls nur eine Aufl$$HEX1$$f600$$ENDHEX$$sung simuliert werden soll
boolean				bInChange		= false	// Falls im $$HEX1$$c400$$ENDHEX$$nderungsmodus (anderer Datasource)
boolean				bInGeneration	= false	// User-Object l$$HEX1$$e400$$ENDHEX$$uft im Generierungsbetrieb

boolean				bNextMeal		= false	// Stellt Mahlzeitenwechsel fest
														// durch Vergleich von lHandlingKey

boolean				bShowProgressWindow	= false	// Zeigt f$$HEX1$$fc00$$ENDHEX$$r die Dauer der Mahlzeitenberechnung
																	// ein Statusfenster (nur im Dialog-Betrieb)
																

datastore			dsCenMeals

integer				iManualInput = 0			// Merker in DB: Passagierzahl wurde vom Anwender
														// auf Komponentenebene ver$$HEX1$$e400$$ENDHEX$$ndert

s_new_handling_explosion		s_pax_counts				// $$HEX1$$dc00$$ENDHEX$$bergabestruktur f$$HEX1$$fc00$$ENDHEX$$r Ausz$$HEX1$$e400$$ENDHEX$$hlungsfenster

//Unterbeladung
datastore			dsHandlingDiff
long					lPaxManualConcDiff			//Korrigierte Passagierzahl gem. abweichender Belandung Konzept
Boolean				ibo_concdiff			// Kennzeichen dass konzeptbezogene Korrektur erfolgt ist															

//
// SPML-Verarbeitung
//
datastore			dsSPMLAssignment			// Welche SPML sind den ermittelten Mahlzeiten zugeordnet
datastore			dsSPMLDefinition			// SPML Stammdaten zu einem SPML-Objekt

long					lSPMLKeyOld					// Gruppenwechsel: Falls SPML mehrere Komponenten hat

string					sMealControlCodeOld		// wechselt der MCC, dann k$$HEX1$$f600$$ENDHEX$$nnte ein neues SPML-Objekt vorliegen
string					sSPMLRotation
long					lSPMLRotationNameKey
long					lHandlingSPMLKey
long					lSpmlRotationKey
long					lSPMLKey
long					lSPMLMasterKey
long					lSPMLHandlingKey
decimal				dcSPMLQuantity
decimal				dcSPMLQuantity_old
long					lSPMLPrio
long					lSPMLPLIndexKey
string					sSPMLPackingList
string					sSPMLUnit
string					sSPMLProductionText
long					lSPMLAccountKey
string					sSPMLAccount
integer				iSPMLManualInput
string					sSPMLHandlingText
integer				iSPMLBillingStatus		// 0 = P/A, 1 = P, 2 = Abrechnung
integer				iSPMLACTransfer			// $$HEX1$$dc00$$ENDHEX$$bertrag der Infos nach einem AC-Change
long					lSPMLPLTypeKey				// St$$HEX1$$fc00$$ENDHEX$$cklistentyp SPML-Komponenten

integer				iOnTopSPML					// SPML wird bereits laut cen_out_spml OnTop beladen
														// weil z.B. die Zeitregel greift

integer				iUseSPMLDeduction			// 1 = SPML reduziert Mahlzeitenkomponenten
														// 0 = SPML hat keine Auswirkungen auf Mahlzeiten
long					lNumberOfSPML				// Summierung der SPML														

decimal				dcSPMLMasterQuantity		// vom User eingegebene Anzahl eines SPML

long					lClassNumberOld

long					lNumberOld

string					sSPMLMasterAddText		// Zusatztext zum SPML
string					sSPMLMasterAddTextOld	// Zusatztext zum SPML
string					sSPMLMasterName			// Name des Passagiers
string					sSPMLMasterNameOld		// Name des Passagiers

integer				iTopOffSPML					// SPML wird vom User in cen_out_spml auf "TopOff"
														// gesetzt. Dann wird SPML auf keinen Fall von irgend-
														// einer Mahlzeit reduziert!
														
long					lSPMLMasterKeyOld			// Feststellen Wechsel SPML (ab 12.07.04)

long					lSPMLPLKindKey					// Key f$$HEX1$$fc00$$ENDHEX$$r MS0, MS1, MS2, ...
long					lSPMLPackinglistKey			// Key f$$HEX1$$fc00$$ENDHEX$$r APP, DES, ...
long					lSPMLPLDetailKey				// Detail-Key der Packinglist
string					sSPMLPackinglistText			// Bezeichnung der Packinglist

//
// Abrechnung
//
string					sAreaHost					// Bereich (110 = Produktion)
string					sEffortHost					// Produktgruppe (H3)
string					sAdditionalAccountCode	// Der neue Super-Account-Code (char18)
string					sSPMLAddAccountCode		// Der neue Super-Account-Code (char18) f$$HEX1$$fc00$$ENDHEX$$r SPML

//
// Performance-Tuning
//
datastore			dsCenAirlineAccounts		// Alle KVAs
datastore			dsPLTypes					// evtl. nur zum Test, siehe uf_get_pl_type_key

//
// Neue St$$HEX1$$fc00$$ENDHEX$$cklisten-Struktur
//
long					lPLKindKey					// Key f$$HEX1$$fc00$$ENDHEX$$r MS0, MS1, MS2, ...
long					lPackinglistKey			// Key f$$HEX1$$fc00$$ENDHEX$$r APP, DES, ...
long					lPLDetailKey				// Detail-Key der Packinglist
string					sPackinglistText			// Bezeichnung der Packinglist

//
// Meal-/SPML-Verteilung unterdr$$HEX1$$fc00$$ENDHEX$$cken ja/nein
//
integer				iDistribute					// MZ-Verteilung ja/nein
integer				iSPMLDistribute			// SPML-Verteilung ja/nein

//
// Datastore f$$HEX1$$fc00$$ENDHEX$$r Ratiolists
//
datastore			dsRatiolistDefinition	// dw_exp_ratiolist_definition
datastore			dsRatiolistTyp1			// dw_exp_ratiolist_typ1
datastore			dsFindRatiolist			// Verfahren zur Suche einer neuen G$$HEX1$$fc00$$ENDHEX$$ltigkeit
														// einer bereits vorhandenen Ratiolist

datastore			dsRatioReplacement		// Ersetzung Berechnungen von Ratiolist3

long					lControllingFlag
long					lDeliveryNoteFlag
string					sDeliveryNoteText
string					sDeliveryNoteSNR

//
// 23.02.2006 Manuell eingegebene Reserven
//
long					lManualReserve				// cen_out_pax.nmanual_reserve

// 17.02.2010, KF: H$$HEX1$$f600$$ENDHEX$$chstwert einer Berechnugsart
Long 					lMaxValue

// 20.09.2013 HR: Minimalwert einer Berechnungsart (CBASE-CR-NAM-12085)
Long					lMinValue

// 08.06.2010 HR: eingestellte BOB-Werte sichern
integer 				ii_bob
long 					il_bob_percentage
long 					il_bob_min
long 					il_bob_max				// 27.09.2013 HR: (CBASE-CR-NAM-12085)
long 					il_bob_value				// 27.09.2013 HR: (CBASE-CR-NAM-12085)

datastore 			dsFlightData


// 21.06.2010 HR: IMView 262
integer 				ii_ReplaceProdText 			//Produktionstext durch SL-Produktionstext ersetzen
integer				ii_ReplaceProdTextSpml		// 06.02.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r SPML (Produktionstext durch SL-Produktionstext ersetzen)
// 14.09.2010 HR: SKY_MEAL_ORDERS
long 					il_SkyMealOrderQuantity 		= -1

// 09.09.2010 IH: Calc-Id's-Grenzen f$$HEX1$$fc00$$ENDHEX$$r Berechnungsarten mit mehreren Klassen
Constant long il_MIN_CALC_ID_MULTI_CLASSES 	= 29
Constant long il_MAX_CALC_ID_MULTI_CLASSES 	= 60

// TBR 04.10.2010: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r "Japan-Tool"
Integer 				ii_nservice
Integer 				ii_nethnic
Integer 				ii_CalcFromForecast				= 0
Boolean 				ibo_pax_from_forecast

// kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
datastore			idsCustomerId

datastore			idsLocalSubst 				// 24.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_nlocal_sub 				// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_npl_index_key_ori		// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
string				is_cpackinglist_ori 			// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
string				is_ctext_ori 					// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_ncalc_id_ori 				// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_ncalc_detail_key_ori 	// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_npercentage_ori 		// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_nvalue_ori 				// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
long 					il_nmax_value_ori 			// 25.09.2012 HR: Variable f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)

//Gunnar: Testing
integer 				in_fileno = -1;

string				is_packinglist_xsl			// 24.07.2013 HR: CBASE-DE-CR-2013-005 Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
string				is_packinglist_spml_xsl	// 22.10.2015 HR: Servicest$$HEX1$$fc00$$ENDHEX$$ckliste SPML

// --------------------------------------------------------------------------------------------------------------------
// 02.06.2014 HR: CBASE-NAM-CR-14020: Auch bei SPMLs soll eine lokale Ersetzung m$$HEX1$$f600$$ENDHEX$$glich sein
// --------------------------------------------------------------------------------------------------------------------
integer 				ii_spml_nlocal_sub 			= 0	
long 					il_spml_npl_index_key_ori
string				is_spml_cpackinglist_ori
string				is_spml_ctext_ori
integer				ii_spml_nlocal_sub_flight 	= -1

// --------------------------------------------------------------------------------------------------------------------
// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling
// --------------------------------------------------------------------------------------------------------------------
datastore 			idsLocalEuSubst					
integer				ii_partial_substitution			= 0
integer				ii_spml_partial_substitution	= 0

boolean				ib_Ask4PassengerMass		= false  // 17.07.2015 HR: CBASE-DE-CR-2015-049

// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
// --------------------------------------------------------------------------------------------------------------------
string 				icmc_cprefix
integer				icmc_nreduce
string 				icmc_coverunderload
integer				icmc_nservice_sequence
string				is_sap_code
end variables

forward prototypes
public function integer uf_calc_percent_multiple ()
public function long uf_get_detail_key (long arg_index_key)
public function integer uf_item_list_explosion_old ()
public function integer uf_switch_datasource ()
public function integer uf_item_list_explosion ()
public function integer uf_calc_percent_abs ()
public function integer uf_check_overload ()
public function integer uf_reduce_overload ()
public function integer uf_manual_rescue ()
public function integer uf_compare_new_old ()
public function integer uf_compare_new_current ()
public subroutine uf_trace (integer arg_level, string arg_trace_text)
public function string uf_get_packinglist (long lkey)
public function integer uf_write_cen_out_meals ()
public function string uf_get_handling_text (long lkey)
public function integer uf_filter_actype ()
public function string uf_get_account_code (long lkey)
public function integer uf_calc_booking_classes ()
public function integer uf_calc_bosta_minus ()
public function integer uf_calc_bosta_plus ()
public function integer uf_calc_difference_fullhouse ()
public function integer uf_calc_multiple ()
public function integer uf_get_pax_manual ()
public function integer uf_retrieve_accounts ()
public function integer uf_start_change ()
public function integer uf_start_change_on_cen_out ()
public function integer uf_start_from_scratch ()
public function integer uf_get_rotation (long arg_rotation_key, integer arg_rotation_type)
public function integer uf_compile_spml ()
public function string uf_get_packinglist_unit (long lkey)
public function integer uf_start_simulation ()
public function integer uf_insert_cen_out_spml_detail ()
public function integer uf_set_meal_properties (long lrow)
public function long uf_get_pl_type_key (long arg_key, long arg_detailkey)
public function integer uf_insert_cen_out_meals ()
public function integer uf_calc_integer ()
public function integer uf_compile ()
public function long uf_calc_ratiolist2 ()
public function integer uf_ask4passenger ()
public function long uf_calc_ratiolist ()
public function integer uf_start_change_on_cen_out_old ()
public function integer uf_calc_percent_abs_minus ()
public function integer uf_calc_multiple_m ()
public function integer uf_calc_percent_zero ()
public function integer uf_ask4passenger_old ()
public function long uf_get_booking_classes ()
public function long uf_get_booking_class_1_2 ()
public function integer uf_get_calc_basis_old ()
public function integer uf_get_calc_basis ()
public function integer uf_set_spml_properties (long lrow)
public function long uf_get_foreign_object (long arg_old_meal_key)
public function integer uf_replace_ratiolist3 ()
public function integer uf_get_calc_basis_feb ()
public function integer uf_start_mco_simulation ()
public function integer uf_calc_classes (integer iclasses[])
public function integer uf_calc_classes_percentage (integer iclasses[])
public function integer uf_calc_classes_multiple (integer iclasses[])
public function integer uf_calc_multi_class_sum (integer icolumn)
public function integer uf_calc_percent_multiple_for_groups ()
public function long uf_percent_multiple (decimal dsvalueparm, long lcalcbasisparm, long lpercentageparm)
protected function integer uf_calculate (long lrow)
protected function integer uf_calc_percent_com ()
public function long uf_calc_paxconcdiff ()
public function integer uf_calc_n_percent_for_class_lh ()
public function integer uf_calc_percent_com_no_null ()
public function integer uf_calc_version_n_classes_percent_lh ()
public function integer uf_calc_percent_round_down (decimal dcargument, integer idefault)
public function integer uf_calculate4paula (long lrow, ref decimal radec_quantity, ref datastore rads_meals, long al_pax_num, string as_class)
public function integer uf_calc_percent_by_cp (decimal dcargument)
public function integer uf_calc_bob_percent (integer arg_icalc)
public function integer uf_calc_bob_percent_round_down (integer arg_icalc)
public function integer uf_calc_bob_percent_com (integer arg_icalc)
public function integer uf_calc_bob_fixed ()
public function integer uf_calc_fixed_cp ()
public function integer uf_change_flightdataobject (string arg_dataobject)
public function long uf_get_value_from_ratio (long arg_lcalcdetailkey, long arg_lcalcbasis)
public function integer uf_add_number_for_classes (long al_calcid, s_number_per_class astr_noperclassesarray[])
public function integer uf_get_max_classes (ref string as_maxclassesarray[], ref boolean ab_paxnumberrequired, ref boolean ab_versionrequired)
public function integer uf_ask4number_per_class (string as_maxclassesarray[], ref s_number_per_class astr_noperclassesarray[], boolean ab_paxnumberrequired, boolean ab_versionrequired)
public function integer uf_add_return_flight_pax ()
public function long uf_calc_ratiolist_percentage (decimal dcargument)
public function integer uf_calc_pax_via_forecast_ratio ()
public function integer uf_calc_multiclass_sum_ratiolist (integer icolumn)
public function integer uf_calc_multiclass_sum_ratiolist_spml (integer icolumn)
public function integer uf_calc_fixed_ac_version ()
public function string uf_cen_profilestring (string ssection, string skey, string sdefault)
protected function long uf_get_customer_id (long al_indexkey, long al_detailkey, long al_airlinekey, ref string ref_as_customerid, ref string ref_as_customertext, boolean ab_all)
public function integer uf_calc_percent_version_cutoff ()
public function long uf_get_percentage_from_ratio (long arg_lcalcdetailkey, long arg_lcalcbasis)
public subroutine uf_calc_percent_aa ()
public subroutine uf_calc_linked_aa ()
protected function integer uf_calc_percent (decimal dcargument)
public subroutine uf_calc_multiple_fixed_aa ()
public function integer uf_calc_bob_multiple (integer nwithmax)
public function integer uf_calc_percent_round_off_with_absolute ()
public function integer uf_retrieve_local_subst (string arg_cunit, long arg_nairline_key, long arg_nflight_number, string arg_csuffix, date arg_ddeparture, string arg_cdeparture_time, long arg_naircraft_key, long arg_nrouting_id, long arg_ntlc_from, long arg_ntlc_to, long arg_nhandling_type_key, long arg_nresult_key)
public function integer uf_calc_pax_via_forecast_ratio_mass (string arg_cclass, long arg_npax, long arg_nservice, ref integer arg_nstatus)
public function integer uf_get_flight_parm_diff (long arg_handling_detail_key, long arg_nflight_number, string arg_csuffix, ref integer arg_npercentage, ref decimal arg_nvalue, ref long arg_nmin_value, ref long arg_nmax_value)
public function integer uf_calc_fixed_acver_tlcfrom ()
public function integer uf_replace_pl_for_aircraft ()
public function integer uf_calc_multiple_m_cp ()
public function integer uf_calc_bosta_plus_reserve ()
public function integer uf_new_flight ()
end prototypes

public function integer uf_calc_percent_multiple ();//=================================================================================================
//
// uf_calc_percent_multiple
//
// Berechnet Prozent-Vielfaches
//
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long lValue
long lValue_ver; // 06.11.12, Gunnar Brosch: QuantityVersion
long lResult
long lResult_ver; // 06.11.12, Gunnar Brosch: QuantityVersion

lValue = ceiling(lCalcBasis * iPercentage / 100)	// Prozentwert
lValue_ver = ceiling(il_calcbasis_ver * iPercentage / 100); // 06.11.12, Gunnar Brosch: QuantityVersion

if dcValue = 0 then dcValue = 1

lResult = truncate(lValue / dcValue, 0)							// Vielfaches
lResult_ver = truncate(lValue_ver / dcValue, 0); 				// 06.11.12, Gunnar Brosch: QuantityVersion

If Mod(lValue, integer(dcValue)) > 0 then lResult++			// Falls Rest aus Division, dann bis zum
																			// n$$HEX1$$e400$$ENDHEX$$chsten Schritt
if mod(lValue_ver, integer(dcValue)) > 0 then lResult_ver++; // 06.11.12, Gunnar Brosch: QuantityVersion																	

dcQuantity = lResult
idc_quantity_ver = lResult_ver; // 06.11.12, Gunnar Brosch: QuantityVersion

return 0

end function

public function long uf_get_detail_key (long arg_index_key);//
// uf_get_detail_key
//
// Holt den passenden Detail-Key f$$HEX1$$fc00$$ENDHEX$$r eine Packinglist
//
long	lDetailKey

select npackinglist_detail_key
  into :lDetailKey
  from cen_packinglists
 where npackinglist_index_key = :arg_index_key
   and dvalid_from				<= :dGenerationDate
	and dvalid_to					>=	:dGenerationDate;

if sqlca.sqlcode <> 0 then
	return -1
end if

return lDetailKey

end function

public function integer uf_item_list_explosion_old ();//=================================================================================================
//
// uf_item_list_explosion_old
//
//=================================================================================================
//
// Materialdisposition der Mahlzeitenschl$$HEX1$$fc00$$ENDHEX$$sselnummern
//
//=================================================================================================
//long		i, lRow
//long		lSequence
//long		lFind
//integer	iDay
//string	sFind
//string	sPLText
//datetime	dtnow
//
//long				lArea_Key				// der lokale Bereich
//long				lWorkstation_Key		// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
//decimal			dcReserve				// Prozentuale lokale Reserve 
//
//uo_packinglist_explosion	uo_pl_expl
//uo_generate_datastore		dsCenOutMaster
//datastore						dsLocalWorkstations
//
//time				tdepartureTime
//
//dtnow = datetime(today(),now())
////
//// Verkehrstag ermitteln
////
//iDay = DayNumber(dgenerationdate)
//iDay --
//if iDay = 0 then iDay = 7
//
////
//// Mahlzeitenschl$$HEX1$$fc00$$ENDHEX$$sselnummern durchlaufen
//// cen_out_meals -> cen_out_master
////
//uo_pl_expl = create uo_packinglist_explosion
//
//uo_pl_expl.sClient		= sClient		// Mandant
//uo_pl_expl.sPlant			= sPlant			// Betrieb
//uo_pl_expl.lAirlineKey	= lAirlineKey	// Airline (aus Airlinecode)
//uo_pl_expl.iDebugLevel 	= 0
//
//dsCenOutMaster				= uo_pl_expl.dsCenOutMaster
//dsLocalWorkstations		= uo_pl_expl.dsLocalWorkstations
//
////MessageBox("dsCenOutMeals.RowCount()",dsCenOutMeals.RowCount())
////f_print_datastore(dsCenOutMeals)
//
//for i = 1 to dsCenOutMeals.RowCount()
//	lPackinglistIndexKey	= dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key")
//	
//	lPackinglistDetailKey = uf_get_detail_key(lPackinglistIndexKey)
//	if lPackinglistDetailKey = -1 then
//		//
//		// Detail-Key konnte nicht ermittelt werden
//		//
//		destroy uo_pl_expl
//		return -1
//	end if
//	
//	sPLText	= f_get_packinglist_text(lPackinglistIndexKey,datetime(dGenerationDate))
//	
//	lSequence = f_Sequence("seq_cen_out_master", sqlca)
//	// -----------------------------------------
//	// liefert -2 bei Fehler
//	// -----------------------------------------
//	If lSequence = -1 Then
//		destroy uo_pl_expl
//		return -2
//	end if
//	
//	//
//	// Lokale Daten (Bereiche und Reserven) rausfuscheln
//	//
//	sFind = 	"npackinglist_index_key = " + string(lPackinglistIndexKey) + &
//			" and ctime_from <= '" + string(tdepartureTime,"hh:mm") + &
//			"' and ctime_to >= '" + string(tdepartureTime,"hh:mm") + "'"
//	lFind = dsLocalWorkstations.Find(sFind,1,dsLocalWorkstations.RowCount())
//	
//	if lFind > 0 then
//		lArea_Key			= dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
//		lWorkstation_Key	= dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
//		dcReserve			= dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
//	else
//		lArea_Key			= 0
//		lWorkstation_Key	= 0
//		dcReserve 			= 0
//	end if
//	
//	
//	lRow = dsCenOutMaster.InsertRow(0)
//	dsCenOutMaster.SetItem(lRow,"npl_type",1)
//	
//	dsCenOutMaster.SetItem(lRow,"ndetail_key",	lSequence)
//	dsCenOutMaster.SetItem(lRow,"ntransaction",	lTransaction)
//	dsCenOutMaster.SetItem(lRow,"nresult_key",	lresultkey)
//	
//	dsCenOutMaster.SetItem(lRow,"npl_index_key",	lPackinglistIndexKey)
//	dsCenOutMaster.SetItem(lRow,"npl_detail_key",lPackinglistDetailKey)
//	dsCenOutMaster.SetItem(lRow,"cpackinglist",	dsCenOutMeals.GetItemString(i,"cpackinglist"))
//	dsCenOutMaster.SetItem(lRow,"ctext",			sPLText)	// PL-Text cen_packinglists!
//	dsCenOutMaster.SetItem(lRow,"cunit",			dsCenOutMeals.GetItemString(i,"cunit"))	// Einheit
//	dsCenOutMaster.SetItem(lRow,"nquantity",		dcquantity)
//	dsCenOutMaster.SetItem(lRow,"naction",			1)
//	dsCenOutMaster.SetItem(lRow,"dtimestamp",		dtnow)
//	dsCenOutMaster.SetItem(lRow,"nstatus",			0)
//	dsCenOutMaster.SetItem(lRow,"narea_key",		lArea_Key)
//	dsCenOutMaster.SetItem(lRow,"nworkstation_key",lWorkstation_Key)
//	dsCenOutMaster.SetItem(lRow,"nreserve",		dcReserve)
//	//
//	// neu: nhandling_id auch in cen_out_master setzen
//	// Damit wissen wir sp$$HEX1$$e400$$ENDHEX$$ter, aufgrund welches Handling-Typs der Baustein beladen wurde
//	// und k$$HEX1$$f600$$ENDHEX$$nnen z.B. die Anzahl "Spiegel" je Gate ermitteln
//	//
//	dsCenOutMaster.SetItem(lRow,"nhandling_id",	12)
//	dsCenOutMaster.SetItem(lRow,"nfreq_key",		0)
//	
//next
//
////f_print_datastore(dsCenOutMaster)
//
////
//// Matdispo f$$HEX1$$fc00$$ENDHEX$$r cen_out_master Struktur
////
//if not uo_pl_expl.of_start_meal_explosion() then
//	destroy uo_pl_expl
//	sErrorText = "Can't generate a Packing List explosion for the meal loading!"
//	return -3
//end if
//
////f_print_datastore(dsCenOutMaster)
//
////
//// Wegschreiben von dsCenOutMaster: Wann erfolgt update()
////
//
//
//destroy uo_pl_expl
//
return 0

end function

public function integer uf_switch_datasource ();//=================================================================================================
//
// uf_switch_datasource
//
// $$HEX1$$c400$$ENDHEX$$ndert Datasource f$$HEX1$$fc00$$ENDHEX$$r das Change-Management
//	
// von dw_cen_out_meals (Verwendung bei der Generierung) nach dw_change_cen_out_meals
//=================================================================================================

dsCenOutMeals.DataObject 					= "dw_change_cen_out_meals"
dsCenOutMeals.SetTransObject(SQLCA)

dsCenOutMealsOld.DataObject 				= "dw_change_cen_out_meals"
dsCenOutMealsOld.SetTransObject(SQLCA)

return 0

end function

public function integer uf_item_list_explosion ();//=================================================================================================
//
// uf_item_list_explosion
//
//=================================================================================================
//
// Materialdisposition der Mahlzeitenschl$$HEX1$$fc00$$ENDHEX$$sselnummern
// Ausrangiert am 03.11.2003
//
//=================================================================================================
long		i, lRow
longlong	lSequence
long		lFind
integer	iDay
string	sFind
string	sPLText
datetime	dtnow

long				lArea_Key				// der lokale Bereich
long				lWorkstation_Key		// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
decimal			dcReserve				// Prozentuale lokale Reserve 

uo_generate_datastore		dsCenOutMaster
datastore						dsLocalWorkstations

time				tdepartureTime

dtnow = datetime(today(),now())
//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

//
// Mahlzeitenschl$$HEX1$$fc00$$ENDHEX$$sselnummern durchlaufen
// cen_out_meals -> cen_out_master
//
dsCenOutMaster = create uo_generate_datastore
dsCenOutMaster.DataObject			= "dw_cen_out_master"
dsCenOutMaster.SetTransObject(SQLCA)

dsLocalWorkstations							= Create DataStore
dsLocalWorkstations.DataObject			= "dw_local_workstations_for_pl"
dsLocalWorkstations.SetTransObject(SQLCA)

dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

//MessageBox("dsCenOutMeals.RowCount()",dsCenOutMeals.RowCount())
//f_print_datastore(dsCenOutMeals)

for i = 1 to dsCenOutMeals.RowCount()
	lPackinglistIndexKey	= dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key")
	
	lPackinglistDetailKey = uf_get_detail_key(lPackinglistIndexKey)
	if lPackinglistDetailKey = -1 then
		//
		// Detail-Key konnte nicht ermittelt werden
		//
		destroy dsCenOutMaster
		destroy dsLocalWorkstations
		return -1
	end if
	
	sPLText	= f_get_packinglist_text(lPackinglistIndexKey,datetime(dGenerationDate))
	
	// --------------------------------------------------------------------------------------------------------------------
	// 26.02.2013 HR: Umstellung der Sequence auf LONGLONG
	// --------------------------------------------------------------------------------------------------------------------
	lSequence = f_Sequence_ll("seq_cen_out_master", sqlca)
	
	// -----------------------------------------
	// liefert -2 bei Fehler
	// -----------------------------------------
	If lSequence = -1 Then
		destroy dsCenOutMaster
		destroy dsLocalWorkstations
		return -2
	end if
	
	//
	// Lokale Daten (Bereiche und Reserven) rausfuscheln
	//
	sFind = 	"npackinglist_index_key = " + string(lPackinglistIndexKey) + &
			" and ctime_from <= '" + string(tdepartureTime,"hh:mm") + &
			"' and ctime_to >= '" + string(tdepartureTime,"hh:mm") + "'"
	lFind = dsLocalWorkstations.Find(sFind,1,dsLocalWorkstations.RowCount())
	
	if lFind > 0 then
		lArea_Key			= dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
		lWorkstation_Key	= dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
		dcReserve			= dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
	else
		lArea_Key			= 0
		lWorkstation_Key	= 0
		dcReserve 			= 0
	end if
	
	
	lRow = dsCenOutMaster.InsertRow(0)
	dsCenOutMaster.SetItem(lRow,"npl_type",1)
	
	dsCenOutMaster.SetItem(lRow,"ndetail_key",	lSequence)
	dsCenOutMaster.SetItem(lRow,"ntransaction",	lTransaction)
	dsCenOutMaster.SetItem(lRow,"nresult_key",	lresultkey)
	
	dsCenOutMaster.SetItem(lRow,"npl_index_key",	lPackinglistIndexKey)
	dsCenOutMaster.SetItem(lRow,"npl_detail_key",lPackinglistDetailKey)
	dsCenOutMaster.SetItem(lRow,"cpackinglist",	dsCenOutMeals.GetItemString(i,"cpackinglist"))
	dsCenOutMaster.SetItem(lRow,"ctext",			sPLText)	// PL-Text cen_packinglists!
	dsCenOutMaster.SetItem(lRow,"cunit",			dsCenOutMeals.GetItemString(i,"cunit"))	// Einheit
	dsCenOutMaster.SetItem(lRow,"nquantity",		dcquantity)
	dsCenOutMaster.SetItem(lRow,"naction",			1)
	dsCenOutMaster.SetItem(lRow,"dtimestamp",		dtnow)
	dsCenOutMaster.SetItem(lRow,"nstatus",			0)
	dsCenOutMaster.SetItem(lRow,"narea_key",		lArea_Key)
	dsCenOutMaster.SetItem(lRow,"nworkstation_key",lWorkstation_Key)
	dsCenOutMaster.SetItem(lRow,"nreserve",		dcReserve)
	//
	// neu: nhandling_id auch in cen_out_master setzen
	// Damit wissen wir sp$$HEX1$$e400$$ENDHEX$$ter, aufgrund welches Handling-Typs der Baustein beladen wurde
	// und k$$HEX1$$f600$$ENDHEX$$nnen z.B. die Anzahl "Spiegel" je Gate ermitteln
	//
	dsCenOutMaster.SetItem(lRow,"nhandling_id",	12)
	dsCenOutMaster.SetItem(lRow,"nfreq_key",		0)
	
next

//f_print_datastore(dsCenOutMaster)

//
// Wegschreiben von dsCenOutMaster: Wann erfolgt update()
//
if dsCenOutMaster.Update() <> 1 then
	sErrorText = "Can't write to dsCenOutMaster!"
	return -3
end if

destroy dsCenOutMaster
destroy dsLocalWorkstations

return 0

end function

public function integer uf_calc_percent_abs ();//=================================================================================================
//
// uf_calc_percent_abs
//
// Berechnet Prozent plus absoluten Wert
//
//=================================================================================================
long lValue
long lResult

lValue = ceiling(lCalcBasis * iPercentage / 100)	// Prozentwert

lResult = lValue + dcValue

dcQuantity = lResult

return 0

end function

public function integer uf_check_overload ();//=================================================================================================
//
// uf_check_overload
//
// Achtung: Diese Methode wird nicht mehr ben$$HEX1$$f600$$ENDHEX$$tigt.
// Der $$HEX1$$dc00$$ENDHEX$$bertrag der $$HEX1$$dc00$$ENDHEX$$berbeladung erfolgt ab sofort in w_change_center.wf_change_meals,
// da nur am Ende der kompletten MZ-Aufl$$HEX1$$f600$$ENDHEX$$sung sichergestellt ist, dass auch wirklich
// alle Mahlzeiten berechnet wurde. Die Klasse fehlt n$$HEX1$$e400$$ENDHEX$$mlich in cen_handling.
//
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob die gerade kalkulierte Mahlzeit von einer $$HEX1$$dc00$$ENDHEX$$berbeladung betroffen ist.
//
//=================================================================================================
//
// $$HEX1$$dc00$$ENDHEX$$berbelademengen sind (tempor$$HEX1$$e400$$ENDHEX$$r) in dsCenOutMeals.noverload gespeichert, da dies der
// einzige "best$$HEX1$$e400$$ENDHEX$$ndige" Datastore ist.
// Dort ist auch die Objekt-ID und die Gruppe, von der die $$HEX1$$dc00$$ENDHEX$$berbeladung reduziert werden soll.
//
//=================================================================================================
/*

$$HEX1$$dc00$$ENDHEX$$berlegungen:

Sollte die Verrechnung von $$HEX1$$dc00$$ENDHEX$$berbeladungen in einem "second pass" am Ende der kompletten 
Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung aller Fl$$HEX1$$fc00$$ENDHEX$$ge laufen?

Wenn $$HEX1$$dc00$$ENDHEX$$berbeladung sich auf eine Gruppe von Positionen bezieht (mehr als eine), dann 
sollte anhand der Beladeprozente die $$HEX1$$dc00$$ENDHEX$$berbeladung reduziert werden!

*/
long		lFind
string	sFind

sFind	= 	"nresult_key = " + string(lResultKey) + &
			" and nforeign_object = " + string(lMasterKey) + &
			" and nforeign_group = " + string(iComponentGroup) + &
			" and noverload > 0 "

lFind = dsCenOutMeals.Find(sFind,1,dsCenOutMeals.RowCount())

if lFind > 0 then
	//
	// Wir haben eine $$HEX1$$dc00$$ENDHEX$$berbeladung f$$HEX1$$fc00$$ENDHEX$$r dieses Objekt gefunden
	//
	// Der exakte Wert der $$HEX1$$dc00$$ENDHEX$$berbeladung steht im Feld noverload (wird nicht gespeichert)
	// und zwar auf jeder Zeile der Gruppe
	//
	lOverloadInRow = lFind
	lOverloadGet	= dsCenOutMeals.GetItemNumber(lFind,"noverload")
	
	lCalcBasis		= lCalcBasis - lOverloadGet
	
end if

return 0

end function

public function integer uf_reduce_overload ();//-------------------------------------------------------------------------------
// uf_reduce_overload
// Aufruf aus uo_generate.of_generate_handling_objects()
// nach kompletten Aufl$$HEX1$$f600$$ENDHEX$$sung aller Mahlzeiten
//-------------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berbeladung von Mahlzeiten kann erst nach der vollst$$HEX1$$e400$$ENDHEX$$ndigen Erstellung der
// Mahlzeitenbeladung reduziert werden, da die einzelnen Handling Objekte keiner
// Klassensortierung folgen.
//-------------------------------------------------------------------------------
string		sFind, sFind1
long		i, j, lFinds, lFind, lFind1, lOverload, lPercentage, lReduction, lReduce, lQuantity, lNewQuantity, llocalObject
long		llocalComponentGroup, llocalResultKey, lforeignMealKey, lReductionCheck

// 17.06.2016 HR:
dsCenOutMeals.setfilter("nresult_key = "+string(lResultKey))
dsCenOutMeals.filter()

for i = 1 to dsCenOutMeals.RowCount()

	// Problem: Es wird gepr$$HEX1$$fc00$$ENDHEX$$ft, ob nhandling_meal_key als abzugsf$$HEX1$$e400$$ENDHEX$$higes nforeign_object auftaucht.
	// 			    Bei neuen G$$HEX1$$fc00$$ENDHEX$$ltigkeiten ist aber nforeign_object ggf. ein anderer nhandling_meal_key!
	//			    Eindeutig w$$HEX1$$e400$$ENDHEX$$re es nur $$HEX1$$fc00$$ENDHEX$$ber den nhandling_key herauszufinden.
	llocalObject 					= dsCenOutMeals.GetItemNumber(i,"nhandling_meal_key")
	llocalComponentGroup	= dsCenOutMeals.GetItemNumber(i,"ncomponent_group")
	llocalResultKey				= dsCenOutMeals.GetItemNumber(i,"nresult_key")
	
	sFind1 =	"nresult_key = " + string(llocalResultKey) + &
				" and nforeign_object = " + string(llocalObject) + &
			    " and nforeign_group = " + string(llocalComponentGroup) 
					
	ids_cen_meals_det_deduction.setfilter(sFind1)
	ids_cen_meals_det_deduction.filter()
	ids_cen_meals_det_deduction.sort()

	if ids_cen_meals_det_deduction.rowcount()>0 then
	
		lforeignMealKey = 0 

		for lFind1 = 1 to ids_cen_meals_det_deduction.rowcount()			
			if ids_cen_meals_det_deduction.getitemnumber(lFind1, "nhandling_meal_key") = lforeignMealKey then continue

			// 25.09.2015 HR: Hier muss die $$HEX1$$c400$$ENDHEX$$nderunge auch rein (Overload Korrektur - CBASE-HKG-EM-15001)
			// 10.10.2016 HR: ALM-ID #1687: Nur eingeschaltetem Abz$$HEX1$$fc00$$ENDHEX$$ge ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			sFind = "noverload  > nreduced and nhandling_detail_key = "+string(ids_cen_meals_det_deduction.getitemnumber(lFind1, "nhandling_detail_key"))	 + " and nreduce = 1" 				
			
			lFind = dsCenOutMeals.Find(sFind,1,dsCenOutMeals.RowCount())
	
			if lFind > 0 then
				lforeignMealKey =  dsCenOutMeals.GetItemNumber(lFind, "nhandling_meal_key")
	
				// Es wurde eine $$HEX1$$dc00$$ENDHEX$$berbeladung f$$HEX1$$fc00$$ENDHEX$$r diese Mahlzeitenkomponente gefunden
				lOverload	= dsCenOutMeals.GetItemNumber(lFind,"noverload")
				lReduction 	= dsCenOutMeals.GetItemNumber(lFind,"nreduced")	// das was schon reduziert wurde
				if isnull(lReduction) then lReduction = 0
		
				lPercentage = dsCenOutMeals.GetItemNumber(i,"npercentage")
				lQuantity 	= dsCenOutMeals.GetItemNumber(i,"nquantity")
				
				if lPercentage = 0 or lPercentage = 100 then
					lReduce = lOverload
				else
					lReduce = ceiling(lOverload * lPercentage / 100)				// das was aktuell zu reduzieren ist
					if lReduce = 0 then lReduce = 1
					lReductionCheck = lReduction + lReduce
				end if
		
				if lReductionCheck > lOverload then
					// falls mehr abgezogen werden soll, als noch vorhanden ist
					lNewQuantity = lQuantity - (lOverload - lReduction)
				else
					lNewQuantity = lQuantity - lReduce
				end if
				
				if lNewQuantity < 0 then lNewQuantity = 0
				
				if lNewQuantity <> lQuantity then
					dsCenOutMeals.SetItem(i,"nquantity",lNewQuantity)
				end if
				lReduction = lReduction + lReduce
				dsCenOutMeals.SetItem(lFind,"nreduced",lReduction)
				
			end if
		next
	end if
next

// 17.06.2016 HR:
dsCenOutMeals.setfilter("")
dsCenOutMeals.filter()

return 0

end function

public function integer uf_manual_rescue ();//=================================================================================================
//
// uf_manual_rescue
//
//=================================================================================================
//
// Rettet die manuell aufgenommenen Mahlzeiten vor dem L$$HEX1$$f600$$ENDHEX$$schen
// Damit in w_change_center nichts gel$$HEX1$$f600$$ENDHEX$$scht wird, erhalten sie den Status
// nmanual_processing = 2???
//
//=================================================================================================
long		i, lCheckManual
long		lCheckHandlingKey, lCheckHandlingKeyOld
long		lCheckPrio, lCheckPrioOld
long		lCheckCoverPrio, lCheckCoverPrioOld
long		lRow
string	sDebugPL

long		lCheckCoverKey
boolean	bCheckStatus	// Verhinderung Doppelpr$$HEX1$$fc00$$ENDHEX$$fung einer Zeile

for i = 1 to dsCenOutMealsOld.RowCount()
	lCheckManual 		= dsCenOutMealsOld.GetItemNumber(i,"nmanual_processing")
	lCheckCoverKey		= dsCenOutMealsOld.GetItemNumber(i,"ncover_key")
	lCheckHandlingKey	= dsCenOutMealsOld.GetItemNumber(i,"nhandling_key")
	lCheckPrio				= dsCenOutMealsOld.GetItemNumber(i,"nprio")
	lCheckCoverPrio		= dsCenOutMealsOld.GetItemNumber(i,"ncover_prio")
	sDebugPL				= dsCenOutMealsOld.GetItemString(i,"cpackinglist")
	
	bCheckStatus		= false

	// 25.02.2005: $$HEX1$$c400$$ENDHEX$$nderung
	//	if lCheckHandlingKey <> lCheckHandlingKeyOld and &
	//		lCheckPrio			<>	lCheckPrioOld and &
	if lCheckHandlingKey <> lCheckHandlingKeyOld and &
		lCheckCoverPrio	<>	lCheckCoverPrioOld then
			
		if lCheckManual > 0 then
			// InsertRow nach dsHandlingMealCover
			lRow = dsHandlingMealCover.InsertRow(0)
			dsHandlingMealCover.SetItem(lRow,"nhandling_type_key",		0) //Abfertigung
			dsHandlingMealCover.SetItem(lRow,"nprio",								lCheckCoverPrio)
			dsHandlingMealCover.SetItem(lRow,"nhandling_key",				0)	// CoverKey
			dsHandlingMealCover.SetItem(lRow,"nhandling_foreign_key",	lCheckHandlingKey)
			
			// --------------------------------------------------------------------------------------------------------------------
			// 23.09.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
			// --------------------------------------------------------------------------------------------------------------------
			dsHandlingMealCover.SetItem(lRow,"nplanning_percent",		dsCenOutMealsOld.GetItemNumber(i,"nplanning_percent"))
			dsHandlingMealCover.SetItem(lRow,"cprefix", 						dsCenOutMealsOld.GetItemString(i,"cprefix"))
			dsHandlingMealCover.SetItem(lRow,"nreduce",					dsCenOutMealsOld.GetItemNumber(i,"nreduce"))
			dsHandlingMealCover.SetItem(lRow,"coverunderload", 			dsCenOutMealsOld.GetItemString(i,"coverunderload"))
			dsHandlingMealCover.SetItem(lRow,"nservice_sequence",	dsCenOutMealsOld.GetItemNumber(i,"nservice_sequence"))
				
			// 29.09.2016 HR: CBASEalm ID #1639: Auch die 3 Felder m$$HEX1$$fc00$$ENDHEX$$ssen wir $$HEX1$$fc00$$ENDHEX$$bernommen
			dsHandlingMealCover.SetItem(lRow,"cquestion_text",	dsCenOutMealsOld.GetItemString(i,"cquestion_text"))
			dsHandlingMealCover.SetItem(lRow,"nask4passenger",	dsCenOutMealsOld.GetItemNumber(i,"nask4passenger"))
			dsHandlingMealCover.SetItem(lRow,"nplanning_percent",	dsCenOutMealsOld.GetItemNumber(i,"nplanning_percent"))

			bCheckStatus = true
			
			// 08.10.2014 HR: Wenn wir keine Alten Werte haben, dann kopieren wir hier die aktuellen f$$HEX1$$fc00$$ENDHEX$$r uf_compare_new_current (Fehlerliste 5.0 #155)
			if not isvalid(dsOldMeals) then
				dsOldMeals = create uo_generate_datastore
				dsOldMeals.dataobject = dsCurrentMeals.dataobject
				dsCurrentMeals.rowscopy(1, dsCurrentMeals.rowcount(), primary!, dsOldMeals, 1, primary!)
			end if
		end if
	
		if bCheckStatus = false then
			// Wenn eine manuell aufgenommene Komponente erst mal im Rennen ist, erh$$HEX1$$e400$$ENDHEX$$lt sie durch 
			// sp$$HEX1$$e400$$ENDHEX$$tere Neu-Berechnungen nmanual_processing = 0
			// Deshalb Pr$$HEX1$$fc00$$ENDHEX$$fung auf conver-key
			if lCheckCoverKey = 0 then
				lRow = dsHandlingMealCover.InsertRow(0)
				dsHandlingMealCover.SetItem(lRow,"nhandling_type_key",		0) //Abfertigung
				dsHandlingMealCover.SetItem(lRow,"nprio",								lCheckCoverPrio)
				dsHandlingMealCover.SetItem(lRow,"nhandling_key",				0)	// CoverKey
				dsHandlingMealCover.SetItem(lRow,"nhandling_foreign_key",	lCheckHandlingKey)

				// --------------------------------------------------------------------------------------------------------------------
				// 23.09.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
				// --------------------------------------------------------------------------------------------------------------------
				dsHandlingMealCover.SetItem(lRow,"nplanning_percent",		dsCenOutMealsOld.GetItemNumber(i,"nplanning_percent"))
				dsHandlingMealCover.SetItem(lRow,"cprefix", 						dsCenOutMealsOld.GetItemString(i,"cprefix"))
				dsHandlingMealCover.SetItem(lRow,"nreduce",					dsCenOutMealsOld.GetItemNumber(i,"nreduce"))
				dsHandlingMealCover.SetItem(lRow,"coverunderload", 			dsCenOutMealsOld.GetItemString(i,"coverunderload"))
				dsHandlingMealCover.SetItem(lRow,"nservice_sequence",	dsCenOutMealsOld.GetItemNumber(i,"nservice_sequence"))
				
				// 29.09.2016 HR: CBASEalm ID #1639: Auch die 3 Felder m$$HEX1$$fc00$$ENDHEX$$ssen wir $$HEX1$$fc00$$ENDHEX$$bernommen
				dsHandlingMealCover.SetItem(lRow,"cquestion_text",	dsCenOutMealsOld.GetItemString(i,"cquestion_text"))
				dsHandlingMealCover.SetItem(lRow,"nask4passenger",	dsCenOutMealsOld.GetItemNumber(i,"nask4passenger"))
				dsHandlingMealCover.SetItem(lRow,"nplanning_percent",	dsCenOutMealsOld.GetItemNumber(i,"nplanning_percent"))
	
				// 08.10.2014 HR: Wenn wir keine Alten Werte haben, dann kopieren wir hier die aktuellen f$$HEX1$$fc00$$ENDHEX$$r uf_compare_new_current (Fehlerliste 5.0 #155)
				if not isvalid(dsOldMeals) then
					dsOldMeals = create uo_generate_datastore
					dsOldMeals.dataobject = dsCurrentMeals.dataobject
					dsCurrentMeals.rowscopy(1, dsCurrentMeals.rowcount(), primary!, dsOldMeals, 1, primary!)
				end if

			end if
			bCheckStatus = true
		end if
		lCheckPrioOld 				= lCheckPrio
		lCheckHandlingKeyOld		= lCheckHandlingKey
		lCheckCoverPrioOld			= lCheckCoverPrio
	end if

next

//f_print_datastore(dsHandlingMealCover)

return 0

end function

public function integer uf_compare_new_old ();//=================================================================================================
//
// uf_compare_new_old 	(Nicht l$$HEX1$$f600$$ENDHEX$$schen, da in Verwendung!!!)
//
//=================================================================================================
//
// Umkehr zu uf_compare
//
// Vergleich von dsCenOutMeals (neu ermittelt) mit dsCenOutMealsOld
// Setzen der Statusfelder f$$HEX1$$fc00$$ENDHEX$$r die Markierung
//
// Feld nmanual_input wird in uf_insert_cen_out_meals gesetzt.
//
// 24.11.2003: $$HEX1$$dc00$$ENDHEX$$berarbeitung
//
//=================================================================================================
long		i, j
long		lFind
string		sFind
long		lPriorPackinglistIndexKey
long		lPriorClassNumber
long		lPriorResultKey
long		lPriorHandlingKey

decimal	dcPriorQuantity
decimal	dcNewQuantity
decimal	dcPriorQuantity1

integer	iPriorPaxManual
integer	iPriorReserve
integer	iPriorTopOff

integer	iNewReserve
integer	iNewTopOff

// Falls nach einem AC-Change bzw. nach einer Neukalkulation
// die alten Mengen $$HEX1$$fc00$$ENDHEX$$bertragen werden m$$HEX1$$fc00$$ENDHEX$$ssen

//
// Statusfelder sind (manchmal) auch zu $$HEX1$$fc00$$ENDHEX$$bertragen
//
integer	iStatusPaxManual
integer	iStatusReserve
integer	iStatusTopOff


//f_print_datastore(dsCenOutMealsOld)
//f_print_datastore(dsCenOutMeals)

//
// $$HEX1$$dc00$$ENDHEX$$bertrag der alten Mengen
// Diesmal: Durchlauf in dsCenOutMeals und Suche im dsCenOutMealsOld
//
for i = 1 to dsCenOutMeals.RowCount()
	//
	// Worauf's ankommt:
	//	npackinglist_index_key, nclass_number, nresult_key
	// nhandling_key nur bedingt, da es eine neue Mahlzeitenbeladung gegeben haben k$$HEX1$$f600$$ENDHEX$$nnte
	//
	lPackinglistIndexKey	= dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key")
	lClassNumber			= dsCenOutMeals.GetItemNumber(i,"nclass_number")
	lResultKey				= dsCenOutMeals.GetItemNumber(i,"nresult_key")
	lHandlingKey			= dsCenOutMeals.GetItemNumber(i,"nhandling_key")
	dcQuantity				= dsCenOutMeals.GetItemDecimal(i,"nquantity")	// die neu-kalkulierte Auftragsmenge
	iACTransfer				= dsCenOutMeals.GetItemNumber(i,"nac_transfer")
	
//	iPriorPaxManual				= dsCenOutMealsOld.GetItemNumber(i,"npax_manual")
	
	sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
				" and nclass_number = " 		+ string(lClassNumber) + &
				" and nresult_key = " 			+ string(lResultKey) + &
				" and nhandling_key = " 		+ string(lHandlingKey)
	//
	// 1. Versuch: Vielleicht wird gleiches Meal-Objekt verwendet
	//
	lFind = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
	if lFind > 0 then
		dcPriorQuantity 	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity")
		iNewReserve		= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
		iNewTopOff			= dsCenOutMealsOld.GetItemNumber(lFind,"ntopoff_quantity")
		iStatusReserve		= dsCenOutMealsOld.GetItemNumber(lFind,"status_nreserve_quantity")
		iStatusTopOff		= dsCenOutMealsOld.GetItemNumber(lFind,"status_ntopoff_quantity")
		iStatusPaxManual	= dsCenOutMealsOld.GetItemNumber(lFind,"status_npax_manual")
		dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantity)
		
		// 21.11.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer diesen Wert mit $$HEX1$$fc00$$ENDHEX$$bertragen, da er nicht verloren gehen darf
		dsCenOutMeals.SetItem(i,"nquantity_mis", dsCenOutMealsOld.GetItemNumber(lFind,"nquantity_mis"))

		//
		// alte Mengen setzen, aber nur bis zum aktuellen Status
		//
		j = 1
		Do 
			dcPriorQuantity1	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity" + string(j))
			dsCenOutMeals.SetItem(i,"nquantity" + string(j),dcPriorQuantity1)
			j++
		Loop While j < iStatus
		//
		// Markierungen setzen
		//
		dsCenOutMeals.SetItem(i,"status_npax_manual",iStatusPaxManual)
		if dcQuantity <> dcPriorQuantity then
			dsCenOutMeals.SetItem(i,"status_nquantity",1)
		end if
		if iStatusReserve = 1 then
			dsCenOutMeals.SetItem(i,"status_nreserve_quantity",1)
//			dsCenOutMeals.SetItem(i,"nreserve_quantity",iNewReserve)
			
		end if
		if iStatusTopOff = 1 then
			dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",1)
		end if
		//
		// Auf AC-Change reagieren und Mengen setzen bzw. incrementieren
		// M$$HEX1$$fc00$$ENDHEX$$ssen auch Statusfelder gesetzt werden???
		//
		if iACTransfer = 1 then
			dsCenOutMeals.SetItem(i,"nquantity",dcQuantity + dcPriorQuantity)
		end if
	else
		//
		// 2. Versuch: Mal schauen, ob in jedem Fall das Gleiche zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
		//
		sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
					" and nclass_number = " 		+ string(lClassNumber) + &
					" and nresult_key = " 			+ string(lResultKey)

		// --------------------------------------------------------------------------------------------------------------------
		// 16.03.2016 HR: CBASE-NAM-EM-15005 Manuell eingegebene SL d$$HEX1$$fc00$$ENDHEX$$rfen nicht mit aus Handlingobjekte 
		//                        kommende SL vermischt werden
		// --------------------------------------------------------------------------------------------------------------------
		if lHandlingKey >0 then
			sFind += " and nhandling_key > 0"
		else
			sFind += " and nhandling_key = 0"
		end if

		lFind = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
		if lFind > 0 then
			dcPriorQuantity 	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity")
			iNewReserve			= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
			iNewTopOff			= dsCenOutMealsOld.GetItemNumber(lFind,"ntopoff_quantity")
			iStatusReserve		= dsCenOutMealsOld.GetItemNumber(lFind,"status_nreserve_quantity")
			iStatusTopOff		= dsCenOutMealsOld.GetItemNumber(lFind,"status_ntopoff_quantity")
			iStatusPaxManual	= dsCenOutMealsOld.GetItemNumber(lFind,"status_npax_manual")

			dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantity)
		
			// 21.11.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer diesen Wert mit $$HEX1$$fc00$$ENDHEX$$bertragen, da er nicht verloren gehen darf
			dsCenOutMeals.SetItem(i,"nquantity_mis", dsCenOutMealsOld.GetItemNumber(lFind,"nquantity_mis"))

			//
			// alte Mengen setzen, aber nur bis zum aktuellen Status
			//
			j = 1
			Do 
				dcPriorQuantity1	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity" + string(j))
				dsCenOutMeals.SetItem(i,"nquantity" + string(j),dcPriorQuantity1)
				j++
			Loop While j < iStatus
			//
			// Markierung setzen
			//
			dsCenOutMeals.SetItem(i,"status_npax_manual",iStatusPaxManual)
			if dcQuantity <> dcPriorQuantity then
				dsCenOutMeals.SetItem(i,"status_nquantity",1)
			end if
			if iStatusReserve = 1 then
				dsCenOutMeals.SetItem(i,"status_nreserve_quantity",1)
			end if
			if iStatusTopOff = 1 then
				dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",1)
			end if
			//
			// Auf AC-Change reagieren und Mengen setzen bzw. incrementieren
			//
			if iACTransfer = 1 then
				dsCenOutMeals.SetItem(i,"nquantity",dcQuantity + dcPriorQuantity)
			end if
		else
			//
			// Es wurde keine alte Menge gefunden
			// => Packinglist als "neu" markieren
			// Leider lFind = 0!!!
			//
			dsCenOutMeals.SetItem(i,"status_cpackinglist",1)
			//
			// Handelt es sich vielleicht um eine Ratiolist 2?
			//
			sFind = 	"ncalc_id = 18 " + &
						" and nclass_number = " 		+ string(lClassNumber) + &
						" and nhandling_key = " 		+ string(lHandlingKey)
			lFind = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
			if lFind > 0 then
				//
				// Auf jeden Fall setzen...
				//
				dsCenOutMeals.SetItem(i,"status_npax_manual",1)
			end if
		end if
	end if
	
	
next



return 0

end function

public function integer uf_compare_new_current ();//=================================================================================================
//
//	uf_compare_new_current
//
//=================================================================================================
//
// Mischung aus dsCenOutMealsOld und dsCurrentMeals (beide haben identische Anzahl Zeilen!!!)
//
// dcPriorQuantity kommt aus dsCenOutMealsOld
// der Rest aus dsCurrentMeals
//
// Vergleich von dsCenOutMeals (neu berechnet) mit dsCurrentMeals (dem aktuellen dw_meals aus
// der Maske)
// Setzen der Statusfelder f$$HEX1$$fc00$$ENDHEX$$r die Markierung
//
// Feld nmanual_input wird in uf_insert_cen_out_meals gesetzt.
//
// 16.01.2004: Neu erstellt
//	25.02.2004:	Falls sich (w$$HEX1$$e400$$ENDHEX$$hrend der Benutzer auf dem Flug steht) die Stammdaten $$HEX1$$e400$$ENDHEX$$ndern,
//					dann hat dsCenOutMealsOld eine Abweichende Anzahl Zeilen!
// 07.07.2004: Falls User Mahlzeiten manuell l$$HEX1$$f600$$ENDHEX$$scht, dann muss Sonderbehandlung her
// 13.07.2004: Grundlage wird dsCenOutMealsOld
//	18.11.2004: Bei $$HEX1$$dc00$$ENDHEX$$bernahme nach AC-Change Farbmarkierung entfernen
// 12.04.2005:	status_npax_manual bei Ratiolist2 gekillt
// 13.04.2005:	Bei Ausz$$HEX1$$e400$$ENDHEX$$hlungen darf Menge=0 nicht gesetzt werden
// 12.02.2008: nstationentry mit$$HEX1$$fc00$$ENDHEX$$bertragen aus der History, ML-Web bracht das 
//
//=================================================================================================
long		i, j
long		lFind
string		sFind
string		sPL
long		lPriorPackinglistIndexKey
long		lPriorClassNumber
long		lPriorResultKey
long		lPriorHandlingKey
long		lPriorCalcID
long		llCalcID
long 		llRemarkManual

decimal	dcPriorQuantity
decimal	dcPriorQuantityOld
decimal	dcNewQuantity
decimal	dcPriorQuantity1

integer	iPriorPaxManual
integer	iPriorReserve
integer	iPriorTopOff
integer	iPriorManualInput	// Zeile wurde vom Anwender manipuliert, z.B. gel$$HEX1$$f600$$ENDHEX$$scht
integer	iPriorAsk4Pax		// 13.05.: Diese Zeilen d$$HEX1$$fc00$$ENDHEX$$rfen nicht 0 gesetzt werden
integer	iNewReserve
integer	iNewTopOff
integer	iTookOldQuantity
string		sPriorRemark		// 26.06.06: Bemerkung zu Mahlzeit
integer	iPriorStationEntry
// Falls nach einem AC-Change bzw. nach einer Neukalkulation
// die alten Mengen $$HEX1$$fc00$$ENDHEX$$bertragen werden m$$HEX1$$fc00$$ENDHEX$$ssen

//
// Statusfelder sind (manchmal) auch zu $$HEX1$$fc00$$ENDHEX$$bertragen
//
integer	iStatusPaxManual
integer	iStatusReserve
integer	iStatusTopOff

integer	iChecked
long		lSequence

uo_generate_datastore	dsOldValues		// Flexibilisierung 

//
// Original: aktueller Stand von dw_meals ist die Grundlage
//
//dsOldValues = dsCurrentMeals

// f_print_datastore(dsOldMeals)

//
// Urspr$$HEX1$$fc00$$ENDHEX$$nglicher Stand von dw_meals ist die Grundlage!
//
dsOldValues = dsOldMeals

if not isvalid(dsOldValues) then
	uf_trace(1,"uf_compare_new_current: dsOldValues is not valid!!!")
	return 0
end if

//f_print_datastore(dsCenOutMeals)	//wird bei mehreren Handling Objekten v$$HEX1$$f600$$ENDHEX$$llig zerst$$HEX1$$f600$$ENDHEX$$rt!?!
//f_print_datastore(dsCurrentMeals)		// ist stets ok
//f_print_datastore(dsOldValues)

//
// $$HEX1$$dc00$$ENDHEX$$bertrag der alten Mengen
// Diesmal: Durchlauf in dsCenOutMeals und Suche im dsCenOutMealsOld
//
for i = 1 to dsCenOutMeals.RowCount()
	
	// Messagebox("", "Row " + string(i))
	//
	// Worauf's ankommt:
	//	npackinglist_index_key, nclass_number, nresult_key
	// nhandling_key nur bedingt, da es eine neue Mahlzeitenbeladung gegeben haben k$$HEX1$$f600$$ENDHEX$$nnte
	//
	
	iTookOldQuantity 		= 0
	
	lPackinglistIndexKey	= dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key")
	lClassNumber			= dsCenOutMeals.GetItemNumber(i,"nclass_number")
	lResultKey				= dsCenOutMeals.GetItemNumber(i,"nresult_key")
	lHandlingKey			= dsCenOutMeals.GetItemNumber(i,"nhandling_key")
	dcQuantity				= dsCenOutMeals.GetItemDecimal(i,"nquantity")	// die neu-kalkulierte Auftragsmenge
	iACTransfer				= dsCenOutMeals.GetItemNumber(i,"nac_transfer")
	sPL						= dsCenOutMeals.GetItemString(i,"cpackinglist")
	llCalcID					= dsCenOutMeals.GetItemNumber(i,"ncalc_id")	// Was f$$HEX1$$fc00$$ENDHEX$$r eine Berechung
//	iPriorPaxManual		= dsCenOutMealsOld.GetItemNumber(i,"npax_manual")
	
	sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
				" and nclass_number = " 		+ string(lClassNumber) + &
				" and nresult_key = " 			+ string(lResultKey) + &
				" and nhandling_key = " 		+ string(lHandlingKey) + &
				" and ncompare = 0"
				
	//
	// 1. Versuch: Vielleicht wird gleiches Meal-Objekt verwendet
	//
	lFind = dsOldValues.Find(sFind,1,dsOldValues.RowCount())

	if sPL = "1001_C_DP" then	
		sPL = "1001_C_DP"
	end if 
	
	if lFind > 0 then
		//
		// 02.06.:Pr$$HEX1$$fc00$$ENDHEX$$fung auf abweichende Anzahl Rows entfernt!
		//		if dsCenOutMealsOld.RowCount() <> dsOldValues.RowCount() then
		//			dcPriorQuantity	= 0
		//		else
		//			dcPriorQuantity 	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity")
		//		end if

		// ****    Bleyer: doppelte Schl$$HEX1$$fc00$$ENDHEX$$sselnummern Problematik ******
		dsOldValues.SetItem(lFind,"ncompare",1)
		
		dcPriorQuantity 		= dsOldValues.GetItemDecimal(lFind,"nquantity")
		dcPriorQuantityOld		= dsOldValues.GetItemDecimal(lFind,"nquantity_old")

		iNewReserve			= dsOldValues.GetItemNumber(lFind,"nreserve_quantity")
		iNewTopOff				= dsOldValues.GetItemNumber(lFind,"ntopoff_quantity")
		iStatusReserve			= dsOldValues.GetItemNumber(lFind,"status_nreserve_quantity")
		iStatusTopOff			= dsOldValues.GetItemNumber(lFind,"status_ntopoff_quantity")
		iStatusPaxManual		= dsOldValues.GetItemNumber(lFind,"status_npax_manual")
		iPriorManualInput		= dsOldValues.GetItemNumber(lFind,"nmanual_input")
		lPriorCalcID				= dsOldValues.GetItemNumber(lFind,"ncalc_id")
		
		// 12.02.2009, KF: ML Web ben$$HEX1$$f600$$ENDHEX$$tigt das Feld
		iPriorStationEntry 		= dsOldValues.GetItemNumber(lFind,"nstationentry")
		//
		// 26.06.06 Bemerkungen zu Mahlzeiten $$HEX1$$fc00$$ENDHEX$$bertragen
		//

		// --------------------------------------------------------------------------------------------------------------------
		// 22.08.2012 HR: CBASE-CR-NAM-12062A: Bemerkung soll nicht mehr $$HEX1$$fc00$$ENDHEX$$berschrieben werden, au$$HEX1$$df00$$ENDHEX$$er 
		//                                                             sie wurde manuell erfa$$HEX1$$df00$$ENDHEX$$t
		// --------------------------------------------------------------------------------------------------------------------
		sPriorRemark			= dsOldValues.GetItemString(lFind,"cremark")
		llRemarkManual		= dsOldValues.GetItemNumber(lFind,"nremark_manual")
		
		if not isnull(sPriorRemark) then
			if len(trim(sPriorRemark)) > 0 and llRemarkManual = 1 then
				dsCenOutMeals.SetItem(i,"cremark",sPriorRemark)
				dsCenOutMeals.SetItem(i,"nremark_manual",1)
			end if
		end if
		
		dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantity)
		dsCenOutMeals.SetItem(i,"nstationentry",iPriorStationEntry)
		
		// 21.11.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer diesen Wert mit $$HEX1$$fc00$$ENDHEX$$bertragen, da er nicht verloren gehen darf
		dsCenOutMeals.SetItem(i,"nquantity_mis", dsOldValues.GetItemNumber(lFind,"nquantity_mis"))
		
		//
		// Falls User eine Mahlzeit gel$$HEX1$$f600$$ENDHEX$$scht hat, dann nicht mehr aktivieren
		//
		iPriorAsk4Pax = dsOldValues.GetItemNumber(lFind,"nask4passenger")
		
		// --------------------------------------------------------------------------------------------------------------------
		// 21.07.2014 HR: CBASE-F4-CR-2014-015: Neuer Schalter an der Mahlzeit, der bei manuell hinzugef$$HEX1$$fc00$$ENDHEX$$gten
		//                         Handlingobjekten mit Pax =0 die Mengen neu berechnet, wenn die Paxzahlen ge$$HEX1$$e400$$ENDHEX$$ndert 
		//                         werden
		// --------------------------------------------------------------------------------------------------------------------
		if iPriorManualInput = 1 then
			if dsOldValues.GetItemNumber(lFind,"nmanual_comp") = 0	and dcPriorQuantity = 0 then
				if iPriorAsk4Pax = 0 then
					dsCenOutMeals.SetItem(i,"nmanual_input",1)
					dsCenOutMeals.SetItem(i,"nquantity",0)
					dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
				end if
			end if
		end if

		// Falls User ein Festmengenfeld ge$$HEX1$$e400$$ENDHEX$$ndert hat, dann letzte Eingabe $$HEX1$$fc00$$ENDHEX$$bernehmen
		// llCalcID = 1: Feste Menge
		if iPriorManualInput = 1 and dcPriorQuantity > 0 and llCalcID = 1 then
			dsCenOutMeals.SetItem(i,"nmanual_input",1)
			if lFlightStatus = 2 then  // 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
				dcPriorQuantity = 0
			else
				dsCenOutMeals.SetItem(i,"nquantity",dcPriorQuantity)
				dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
			end if
			iTookOldQuantity = 1
		// -------------------------------------------------------------------
		// Manuell ge$$HEX1$$e400$$ENDHEX$$nderte Menge $$HEX1$$fc00$$ENDHEX$$bernehmen	 
		// -------------------------------------------------------------------
		elseif iPriorManualInput = 1 and dcPriorQuantity > 0 and lPriorCalcID = 1 then
			dsCenOutMeals.SetItem(i,"nmanual_input",1)
			if lFlightStatus = 2 then  // 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
				dcPriorQuantity = 0
			else
				dsCenOutMeals.SetItem(i,"nquantity",dcPriorQuantity)
				dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
			end if
			dsCenOutMeals.SetItem(i,"ncalc_id",1)
			iTookOldQuantity = 1
		end if
		
		//
		// alte Mengen setzen, aber nur bis zum aktuellen Status
		//
		j = 1
		Do 
			if dsCenOutMealsOld.RowCount() = dsOldValues.RowCount() then
				dcPriorQuantity1	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity" + string(j))
				dsCenOutMeals.SetItem(i,"nquantity" + string(j),dcPriorQuantity1)
			else
				dsCenOutMeals.SetItem(i,"nquantity" + string(j),0)
			end if
			j++
		Loop While j < iStatus
		//
		// Markierungen setzen
		//
		dsCenOutMeals.SetItem(i,"status_npax_manual",iStatusPaxManual)
		if dcQuantity <> dcPriorQuantity then
			dsCenOutMeals.SetItem(i,"status_nquantity",1)
		end if
		
		if iStatusReserve = 1 then
			dsCenOutMeals.SetItem(i,"status_nreserve_quantity",1)
//			dsCenOutMeals.SetItem(i,"nreserve_quantity",iNewReserve)
		end if
		if iStatusTopOff = 1 then
			dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",1)
		end if
		//
		// Auf AC-Change reagieren und Mengen setzen bzw. incrementieren
		// M$$HEX1$$fc00$$ENDHEX$$ssen auch Statusfelder gesetzt werden???
		//
		if iACTransfer = 1 then
			dsCenOutMeals.SetItem(i,"nquantity",dcQuantity + dcPriorQuantity)
			// 18.11.04: sonst immer markiert, da dcQuantity <> dcPriorQuantity
			dsCenOutMeals.SetItem(i,"status_nquantity",0)
		end if
		
		// -------------------------------------------------
		// 27.03.2007, KF
		// alte Menge wurde $$HEX1$$fc00$$ENDHEX$$bernommen, dann Statusfeld
		// f$$HEX1$$fc00$$ENDHEX$$r Menge zur$$HEX1$$fc00$$ENDHEX$$cksetzen
		// -------------------------------------------------
		if iTookOldQuantity = 1 then
			// Messagebox("iTookOldQuantity = 1", sPL)
			dsCenOutMeals.SetItem(i,"status_nquantity", 0)
		end if
		
		//
		// 17.10.2005	$$HEX1$$dc00$$ENDHEX$$bernahme Sequence
		//
		if iUseSequence = 0 then
			dsCenOutMeals.SetItem(i,"ndetail_key",dsOldValues.GetItemNumber(lFind,"ndetail_key"))
		end if
		
	else
		
		//
		// 2. Versuch: Mal schauen, ob in jedem Fall das Gleiche zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
		//
		sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
					" and nclass_number = " 		+ string(lClassNumber) + &
					" and nresult_key = " 			+ string(lResultKey) + &
					" and ncompare = 0"
		
		// --------------------------------------------------------------------------------------------------------------------
		// 16.03.2016 HR: CBASE-NAM-EM-15005 Manuell eingegebene SL d$$HEX1$$fc00$$ENDHEX$$rfen nicht mit aus Handlingobjekte 
		//                        kommende SL vermischt werden
		// --------------------------------------------------------------------------------------------------------------------
		if lHandlingKey >0 then
			sFind += " and nhandling_key > 0"
		else
			sFind += " and nhandling_key = 0"
		end if
		
		lFind = dsOldValues.Find(sFind,1,dsOldValues.RowCount())
		
		// Messagebox(" - 2 -    ", sFind + "~r~rlFind= " + string(lFind))

		
		if lFind > 0 then
			
			// ****    Bleyer: doppelte Schl$$HEX1$$fc00$$ENDHEX$$sselnummern Problematik ******
			dsOldValues.SetItem(lFind,"ncompare",1)
			
			if dsCenOutMealsOld.RowCount() <> dsOldValues.RowCount() then
				dcPriorQuantity	= 0
			else
				dcPriorQuantity	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity")
			end if
			iNewReserve		= dsOldValues.GetItemNumber(lFind,"nreserve_quantity")
			iNewTopOff			= dsOldValues.GetItemNumber(lFind,"ntopoff_quantity")
			iStatusReserve		= dsOldValues.GetItemNumber(lFind,"status_nreserve_quantity")
			iStatusTopOff		= dsOldValues.GetItemNumber(lFind,"status_ntopoff_quantity")
			iStatusPaxManual	= dsOldValues.GetItemNumber(lFind,"status_npax_manual")
			lPriorCalcID			= dsOldValues.GetItemNumber(lFind,"ncalc_id")
			
			dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantity)
			
			// 21.11.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer diesen Wert mit $$HEX1$$fc00$$ENDHEX$$bertragen, da er nicht verloren gehen darf
			dsCenOutMeals.SetItem(i,"nquantity_mis", dsOldValues.GetItemNumber(lFind,"nquantity_mis"))
			
			//
			// 26.06.06 Bemerkungen zu Mahlzeiten $$HEX1$$fc00$$ENDHEX$$bertragen
			//

			// --------------------------------------------------------------------------------------------------------------------
			// 22.08.2012 HR: CBASE-CR-NAM-12062A: Bemerkung soll nicht mehr $$HEX1$$fc00$$ENDHEX$$berschrieben werden, au$$HEX1$$df00$$ENDHEX$$er 
			//                                                             sie wurde manuell erfa$$HEX1$$df00$$ENDHEX$$t
			// --------------------------------------------------------------------------------------------------------------------
			sPriorRemark		= dsOldValues.GetItemString(lFind,"cremark")
			llRemarkManual	= dsOldValues.GetItemNumber(lFind,"nremark_manual")
			
			if not isnull(sPriorRemark) then
				if len(trim(sPriorRemark)) > 0 and llRemarkManual = 1 then
					dsCenOutMeals.SetItem(i,"cremark",sPriorRemark)
					dsCenOutMeals.SetItem(i,"nremark_manual",1)
				end if
			end if

			//
			// 31.01.2005
			// Falls User eine Mahlzeit gel$$HEX1$$f600$$ENDHEX$$scht hat, dann nicht mehr aktivieren
			//
			iPriorManualInput		= dsOldValues.GetItemNumber(lFind,"nmanual_input")
			dcPriorQuantityOld		= dsOldValues.GetItemDecimal(lFind,"nquantity_old")
			iPriorAsk4Pax 			= dsOldValues.GetItemNumber(lFind,"nask4passenger")
			
			if iPriorManualInput = 1 and dcPriorQuantity = 0 then
				if iPriorAsk4Pax = 0 then
					dsCenOutMeals.SetItem(i,"nmanual_input",1)
					dsCenOutMeals.SetItem(i,"nquantity",0)
					dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
				end if
			end if
			//
			// Falls User ein Festmengenfeld ge$$HEX1$$e400$$ENDHEX$$ndert hat, dann letzte Eingabe $$HEX1$$fc00$$ENDHEX$$bernehmen
			//
			if iPriorManualInput = 1 and dcPriorQuantity > 0 and llCalcID = 1 then
				dsCenOutMeals.SetItem(i,"nmanual_input",1)
				if lFlightStatus = 2 then  // 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
					dcPriorQuantity = 0
				else
					dsCenOutMeals.SetItem(i,"nquantity",dcPriorQuantity)
					dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
				end if
				iTookOldQuantity = 1 
			// -------------------------------------------------------------------
			// Manuell ge$$HEX1$$e400$$ENDHEX$$nderte Menge $$HEX1$$fc00$$ENDHEX$$bernehmen	 
			// -------------------------------------------------------------------
			elseif iPriorManualInput = 1 and dcPriorQuantity > 0 and lPriorCalcID = 1 then
				dsCenOutMeals.SetItem(i,"nmanual_input",1)
				if lFlightStatus = 2 then  // 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
					dcPriorQuantity = 0
				else
					dsCenOutMeals.SetItem(i,"nquantity",dcPriorQuantity)
					dsCenOutMeals.SetItem(i,"nquantity_old",dcPriorQuantityOld)
				end if
				dsCenOutMeals.SetItem(i,"ncalc_id",1)
				iTookOldQuantity = 1
			end if				
		
			//
			// alte Mengen setzen, aber nur bis zum aktuellen Status
			//
			j = 1
			Do 
				if dsCenOutMealsOld.RowCount() = dsOldValues.RowCount() then
					dcPriorQuantity1	= dsCenOutMealsOld.GetItemDecimal(lFind,"nquantity" + string(j))
					dsCenOutMeals.SetItem(i,"nquantity" + string(j),dcPriorQuantity1)
				else
					dsCenOutMeals.SetItem(i,"nquantity" + string(j),0)
				end if
				j++
			Loop While j < iStatus
			//
			// Markierung setzen
			//
			dsCenOutMeals.SetItem(i,"status_npax_manual",iStatusPaxManual)
			if dcQuantity <> dcPriorQuantity then
				dsCenOutMeals.SetItem(i,"status_nquantity",1)
			end if
			if iStatusReserve = 1 then
				dsCenOutMeals.SetItem(i,"status_nreserve_quantity",1)
			end if
			if iStatusTopOff = 1 then
				dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",1)
			end if
			//
			// Auf AC-Change reagieren und Mengen setzen bzw. incrementieren
			//
			if iACTransfer = 1 then
				dsCenOutMeals.SetItem(i,"nquantity",dcQuantity + dcPriorQuantity)
			end if
			
			// -------------------------------------------------
			// 27.03.2007, KF
			// alte Menge wurde $$HEX1$$fc00$$ENDHEX$$bernommen, dann Statusfeld
			// f$$HEX1$$fc00$$ENDHEX$$r Menge zur$$HEX1$$fc00$$ENDHEX$$cksetzen
			// -------------------------------------------------
			if iTookOldQuantity = 1 then
				dsCenOutMeals.SetItem(i,"status_nquantity", 0)
			end if

						//
			// 17.10.2005	$$HEX1$$dc00$$ENDHEX$$bernahme Sequence
			//
			if iUseSequence = 0 then
				dsCenOutMeals.SetItem(i,"ndetail_key",dsOldValues.GetItemNumber(lFind,"ndetail_key"))
			end if
		else
			//
			// Es wurde keine alte Menge gefunden
			// => Packinglist als "neu" markieren
			// Leider lFind = 0!!!
			//
			dsCenOutMeals.SetItem(i,"status_cpackinglist",1)
			//
			// Handelt es sich vielleicht um eine Ratiolist 2?
			//
			sFind = 	"ncalc_id = 18 " + &
						" and nclass_number = " 		+ string(lClassNumber) + &
						" and nhandling_key = " 		+ string(lHandlingKey)
			lFind = dsOldValues.Find(sFind,1,dsOldValues.RowCount())
			if lFind > 0 then
				//
				// Auf jeden Fall setzen...
				// 12.04.2005: Warum? Hat dazu gef$$HEX1$$fc00$$ENDHEX$$hrt, dass npax_manual ausschliesslich 
				// die erste Passagier-$$HEX1$$c400$$ENDHEX$$nderung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt hat...
				// dsCenOutMeals.SetItem(i,"status_npax_manual",1)
				
				//
				// Markierung setzen
				//
				dsCenOutMeals.SetItem(i,"status_nquantity",1)
			end if
		end if
	end if
next

// f_print_datastore(dsCenOutMeals)

// ****    Bleyer: doppelte Schl$$HEX1$$fc00$$ENDHEX$$sselnummern Problematik ******
for i = 1 to dsOldValues.RowCount()
	dsOldValues.SetItem(i,"ncompare",0)
Next	

return 0

return 0

end function

public subroutine uf_trace (integer arg_level, string arg_trace_text);// =============================================================================================
//
// uf_trace
//
// Tracing Matdispo
//
// =============================================================================================

integer	iTraceFile



if arg_level > idebuglevel then return

iTraceFile	= FileOpen(sTraceFile, LineMode!, Write!, LockWrite!, Append!)

FileWrite(iTraceFile, "   " + String(Today())+"|"+String(Now(),"hh:mm:ss fff")+"|" + string(cpu()) + "|" + arg_trace_text)

FileClose(iTraceFile)

end subroutine

public function string uf_get_packinglist (long lkey);//=================================================================================================
//
// uf_get_packinglist
//
// Holt die Packinglist zum Key
//
//=================================================================================================
string sText

//
// npackinglist_index_key ist PK dieser Tabelle
//
select cpackinglist
  into :sText
  from cen_packinglist_index
 where npackinglist_index_key = :lkey;
 
if sqlca.sqlcode <> 0 then
	return ""
else
	return sText
end if

end function

public function integer uf_write_cen_out_meals ();//=================================================================================================
//
// uf_write_cen_out_meals
//
// Schreibt die kalkulierten Mahlzeiten in die Tabelle
//
//=================================================================================================

if dsCenOutMeals.Update() = -1 then
	sErrortext = "Can't write into table cen_out_meals: " + sqlca.sqlerrtext
//	f_print_datastore(dsCenOutMeals)
	return -1
end if

//
// Kein Reset, da die Mahlzeiten aller Fl$$HEX1$$fc00$$ENDHEX$$ge geschrieben werden m$$HEX1$$fc00$$ENDHEX$$ssen
// dsCenOutMeals.Reset()
//

return 0

end function

public function string uf_get_handling_text (long lkey);//=================================================================================================
//
// uf_get_handling_text
//
// Holt Text eines Handling-Objects
//
//=================================================================================================
string	sText

//
// nhandling_key ist PK dieser Tabelle
//
select	ctext
  into	:sText
  from	cen_handling
 where	nhandling_key = :lKey;

if sqlca.sqlcode <> 0 then
	return ""
else
	return sText
end if


end function

public function integer uf_filter_actype ();//=================================================================================================
//
// uf_filter_actype
//
// Findet den richtigen AC-Typ aus cen_meal_cover und filtert den betreffenden raus
// => lAircraftKey wird ggf. auf den Default-AC-Typ gesetzt
// Ausserdem wird ab 1.76 auch auf die Abfertigung gefiltert!!!
//
// Achtung: $$HEX1$$c400$$ENDHEX$$nderung ab 2.00.1202
// Aircraft-Typ wird bereits in uo_generate.uo_generate_handling_meals gefiltert.
//
//=================================================================================================
//
// Abfrage nach npax_from, npax_to fehlt noch...
//
//=================================================================================================
long 		lFind
string	sFind


//dsHandlingMealCover.RowsDiscard(1,dsHandlingMealCover.RowCount(),Filter!)

//sFind = "naircraft_key = " + string(lAircraftKey)

//f_print_datastore(dsHandlingMealCover)
//lFind = dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
//if lFind <= 0 then
//	//
//	// Suche Default-AC-Typ
//	//
//	sFind = "naircraft_default = 1" 
//	lFind = dsHandlingMealCover.Find(sFind,1,dsHandlingMealCover.RowCount())
//	
//	if lFind > 0 then
//		lAircraftKey = dsHandlingMealCover.GetItemNumber(lFind,"naircraft_key")
//	else
//		sErrorText="Neither Meal Loading found for AC-Type nor for default AC-Type."
//		uf_trace(10,"uf_filter_actype: Error - Neither Meal Loading found for AC-Type nor for default AC-Type")
//		return -1
//	end if
//	
//end if
//	
//dsHandlingMealCover.SetFilter("naircraft_key = " + string(lAircraftKey) + " and nhandling_type_key = " + string(lHandlingTypeKey) )
//dsHandlingMealCover.Filter()
//f_print_datastore(dsHandlingMealCover)

uf_trace(10,"uf_filter_actype: Rows for naircraft_key = " + string(lAircraftKey) + " and nhandling_type_key = " + string(lHandlingTypeKey) + ": " + &
				string(dsHandlingMealCover.RowCount()))
//
// Wichtig: Sortierung auf cen_handling_meal_cover
//
dsHandlingMealCover.SetSort("nprio A")
dsHandlingMealCover.Sort()


return 0

end function

public function string uf_get_account_code (long lkey);//=================================================================================================
//
// uf_get_account_code
//
// Holt den passenden AccountCode zum Text
//
//=================================================================================================
string	sText
long		lFind

if dsCenAirlineAccounts.RowCount() > 0 then
	lFind = dsCenAirlineAccounts.Find("naccount_key = " + string(lKey),1,dsCenAirlineAccounts.RowCount())
	if lFind > 0 then
		sText = dsCenAirlineAccounts.GetItemString(lFind,"caccount")
	else
		sText = ""
	end if
	return sText
else
	return ""
end if


////
//// naccount_key ist PK dieser Tabelle
////
//select caccount
//  into :sText
//  from cen_airline_accounts
// where naccount_key = :lkey;
// 
//if sqlca.sqlcode <> 0 then
//	return ""
//else
//	return sText
//end if

end function

public function integer uf_calc_booking_classes ();//=================================================================================================
//
// uf_calc_booking_classes
//
// Berechnet die Gesamtpassagierzahl aller Buchungsklassen
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long	i
long	iBookingClass
long	lResult
long	lValue
long	lValue_ver; //29.11.2012, G. Brosch

for i = 1 to dsCenOutPax.RowCount()
	lResult 			= dsCenOutPax.GetItemNumber(i,"nresult_key") 
	iBookingClass	= dsCenOutPax.GetItemNumber(i,"nbooking_class")
	//
	// Nur gebuchte Passagiere
	//
	if lCalcID = 15 then
		if lResult = lresultkey and &
			iBookingClass = 1 then
			lValue += dsCenOutPax.GetItemNumber(i,"npax")
			lValue_ver += dsCenOutPax.GetItemNumber(i,"nversion")	//29.11.2012, G. Brosch
		end if
	end if
	//
	// Passagiere + Crew
	//
	if lCalcID = 16 then
		if lResult = lresultkey then
			lValue += dsCenOutPax.GetItemNumber(i,"npax")
			if iBookingClass = 1 then
				lValue_ver += dsCenOutPax.GetItemNumber(i,"nversion")	//29.11.2012, G. Brosch
			else
				lValue_ver += dsCenOutPax.GetItemNumber(i,"nPax")			//29.11.2012, G. Brosch
			end if
		end if
	end if
	//
	// Crew
	//
	if lCalcID = 17 then
		if lResult = lresultkey and &
			iBookingClass = 0 then
			lValue += dsCenOutPax.GetItemNumber(i,"npax")
			lValue_ver += dsCenOutPax.GetItemNumber(i,"nPax")			//29.11.2012, G. Brosch
		end if
	end if
	
next

dcQuantity = lValue
idc_quantity_ver = lValue; // 06.11.12, Gunnar Brosch: QuantityVersion

return 0

end function

public function integer uf_calc_bosta_minus ();//=================================================================================================
//
// uf_calc_bosta_minus
//
// Auftragsmenge ist Bosta - Prozentzahl oder absolutem Wert (je nach Calc-ID)
//
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long lResult
long lResult_ver; // 06.11.12, Gunnar Brosch: QuantityVersion

if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if lCalcBasis > 0 then
		if lCalcID = 11 then
			lResult = lCalcBasis - int(dcValue)
		else
			lResult = lCalcBasis - Int(lCalcBasis * ipercentage / 100) 
		end if
	else
		lResult = 0
	end if
else
	if lCalcID = 11 then
		lResult = lCalcBasis - int(dcValue)
	else
		lResult = lCalcBasis - Int(lCalcBasis * ipercentage / 100) 
	end if
end if

if lResult < 0 then lResult = 0

dcQuantity = lResult

// 06.11.12, Gunnar Brosch: QuantityVersion *** >>>>>>>>>>>>>>>>>>>>>>>>>>><
if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if il_calcbasis_ver > 0 then
		if lCalcID = 11 then
			lResult_ver = il_calcbasis_ver - int(dcValue)
		else
			lResult_ver = il_calcbasis_ver - Int(il_calcbasis_ver * ipercentage / 100) 
		end if
	else
		lResult_ver = 0
	end if
else
	if lCalcID = 11 then
		lResult_ver = il_calcbasis_ver - int(dcValue)
	else
		lResult_ver = il_calcbasis_ver - Int(il_calcbasis_ver * ipercentage / 100) 
	end if
end if

lResult_ver = max(0, lResult_ver);
idc_quantity_ver = lResult_ver;
// 06.11.12, Gunnar Brosch: QuantityVersion *** <<<<<<<<<<<<<<<<<<<<<<<<<<<<

return 0

end function

public function integer uf_calc_bosta_plus ();//=================================================================================================
//
// uf_calc_bosta_plus
//
// Auftragsmenge ist Bosta + Prozentzahl oder absolutem Wert (je nach Calc-ID)
//
// 20.07.2005: Es darf nur eine Berechnung stattfinden, wenn in der
//					Ausz$$HEX1$$e400$$ENDHEX$$hlung > 0 ist
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long lResult
long lResult_ver; //06.11.12, Gunnar Brosch: QuantityVersion

if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if lCalcBasis > 0 then
		if lCalcID = 9 then
			lResult = lCalcBasis + int(dcValue)
		else
			lResult = lCalcBasis + Int(lCalcBasis * ipercentage / 100) 
		end if
	else
		lResult = 0
	end if
else
	if lCalcID = 9 then
		lResult = lCalcBasis + int(dcValue)
	else
		lResult = lCalcBasis + Int(lCalcBasis * ipercentage / 100) 
	end if
end if

dcQuantity = lResult

//06.11.12, Gunnar Brosch: QuantityVersion ************ >>>>>>>>>>>>>>>
if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if il_calcbasis_ver > 0 then
		if lCalcID = 9 then
			lResult_ver = il_calcbasis_ver + int(dcValue)
		else
			lResult_ver = il_calcbasis_ver + Int(il_calcbasis_ver * ipercentage / 100) 
		end if
	else
		lResult_ver = 0
	end if
else
	if lCalcID = 9 then
		lResult_ver = il_calcbasis_ver + int(dcValue)
	else
		lResult_ver = il_calcbasis_ver + Int(il_calcbasis_ver * ipercentage / 100) 
	end if
end if

idc_quantity_ver= lResult_ver;
//06.11.12, Gunnar Brosch: QuantityVersion ************ <<<<<<<<<<<<<<<<<

return 0

end function

public function integer uf_calc_difference_fullhouse ();//=================================================================================================
//
// uf_calc_difference_fullhouse
//
// Berechnet die Differenz zu Full-House (der vollen Version) f$$HEX1$$fc00$$ENDHEX$$r Leerausdeckungen
// 08.11.12, Gunnar Brosch: Quantity Version eingebaut
//=================================================================================================
long	lValue
long	lValue_ver; // 08.11.12, Gunnar Brosch: Quantity Version

//
// 15.03.06 Merker:
// Keine Leerausdeckung bei Ausz$$HEX1$$e400$$ENDHEX$$hlung und gezielter Eingabe von 0
// wurde wieder zur$$HEX1$$fc00$$ENDHEX$$ckgenommen...
//if iAsk4Passenger = 1 and lCalcBasis = 0 then
//	dcQuantity = 0
//	return 0
//end if

lValue	= iVersion - lCalcBasis
lValue_ver	= iVersion - il_calcbasis_ver; // 08.11.12, Gunnar Brosch: Quantity Version

if lValue > 0 then
	dcQuantity = lValue
else
	dcQuantity = 0
end if

// 08.11.12, Gunnar Brosch: Quantity Version >>>
if lValue_ver > 0 then
	idc_quantity_ver = lValue_ver;
else
	idc_quantity_ver = 0
end if
//<<<

return 0

end function

public function integer uf_calc_multiple ();//=================================================================================================
//
// uf_calc_multiple
//
// Berechnet Vielfaches
// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
//=================================================================================================
long lResult
long lresult_ver = 0; // 06.11.12, Gunnar Brosch: QuantityVersion

if dcValue = 0 then dcValue = 1
lResult = truncate(lCalcBasis / dcValue, 0)				// Vielfaches
lresult_ver = truncate(il_calcbasis_ver / dcValue, 0); 	// 06.11.12, Gunnar Brosch: QuantityVersion

If Mod(lCalcBasis, integer(dcValue)) > 0 then lResult++	// Falls Rest aus Division, dann bis zum
																			// n$$HEX1$$e400$$ENDHEX$$chsten Schritt
																			
if mod(il_calcbasis_ver, integer(dcValue)) > 0 then lresult_ver++; 	// 06.11.12, Gunnar Brosch: QuantityVersion																		

dcQuantity 			= lResult
idc_quantity_ver 	= lresult_ver; // 06.11.12, Gunnar Brosch: QuantityVersion			

return 0

end function

public function integer uf_get_pax_manual ();//=================================================================================================
//
// uf_get_pax_manual
//
//=================================================================================================
//
// Manuell (auf Mahlzeitenebene) eingegebene Pax-Zahl holen.
// Nachdem die neue Beladung geholt wurde, wird gepr$$HEX1$$fc00$$ENDHEX$$ft, ob f$$HEX1$$fc00$$ENDHEX$$r diese Komponente bereits
// vorher eine abweichende Passagierzahl eingegeben wurde.
//
// Darf nur ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden, wenn der Status auch gesetzt ist.
//
//=================================================================================================
//
// Auswertung: nmanual_input, nmanual_processing!!!
//
// iManualInput: Falls gesetzt, dann ist stets die manuell gesetzte Pax-Zahl zu verwenden
//	
//	16.01.2004	$$HEX1$$c400$$ENDHEX$$nderung: Grundlage wird dsCurrentMeals (vorher: dsCenOutMealsOld)!
//=================================================================================================
long		i
long		lFind
long		lReserveManual
long		lTopOffManual
string	sFind

integer	iStatusPaxManual

sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
			" and nclass_number = " 		+ string(lClassNumber) + &
			" and nhandling_key = " 		+ string(lHandlingKey)
			
lPaxManual = 0
if isvalid(dsCurrentMeals) then
	if dsCurrentMeals.RowCount() > 0 then
		//
		// Suche Manuell eingegebene Pax
		//
		lFind = dsCurrentMeals.Find(sFind,1,dsCurrentMeals.RowCount())
		
		if lFind > 0 then
			lPaxManual 			= dsCurrentMeals.GetItemNumber(lFind,"npax_manual")
			lReserveManual		= dsCurrentMeals.GetItemNumber(lFind,"nreserve_quantity")
			lTopOffManual		= dsCurrentMeals.GetItemNumber(lFind,"ntopoff_quantity")
			iStatusPaxManual 	= dsCurrentMeals.GetItemNumber(lFind,"status_npax_manual")
			iManualInput 		= dsCurrentMeals.GetItemNumber(lFind,"nmanual_input")
			if iManualInput > 0 then
				return lPaxManual
			else
				return lPax
			end if
//			//
//			// Entscheidung: Wenn eine Zeile manuell bearbeitet wurde, dann sind immer die manuellen 
//			// Reserven und TopOffs zu verwenden
//			//
//			
//			//		if (lPaxManual <> lPax or lReserveManual <> lReserveQuantity or lTopOffManual <> lTopOffQuantity) and &
//			//			(iStatusPaxManual = 1 or iManualInput = 1) then
//			if (iStatusPaxManual = 1 or iManualInput = 1) then
//				//
//				// Nur wenn manuelle Pax-Zahl abweicht und gerade erst ge$$HEX1$$e400$$ENDHEX$$ndert wurde
//				// oder generell eine manuelle Eingabe get$$HEX1$$e400$$ENDHEX$$tig wurde.
//				//
//				lReserveQuantity	= dsCurrentMeals.GetItemNumber(lFind,"nreserve_quantity")
//				lTopOffQuantity	= dsCurrentMeals.GetItemNumber(lFind,"ntopoff_quantity")
//	//			return lPaxManual
//				return lPax
//			else
//				return lPax
//			end if
		else
			//
			// Suche mit calc_id = 18 (Ratiolist 2), da hier der npackinglist_index_key getauscht wird
			//
			sFind = 	"ncalc_id = 18 " + &
						" and nclass_number = " 		+ string(lClassNumber) + &
						" and nhandling_key = " 		+ string(lHandlingKey)
			lFind = dsCurrentMeals.Find(sFind,1,dsCurrentMeals.RowCount())
			
			if lFind > 0 then
				lPaxManual 			= dsCurrentMeals.GetItemNumber(lFind,"npax_manual")
				lReserveManual		= dsCurrentMeals.GetItemNumber(lFind,"nreserve_quantity")
				lTopOffManual		= dsCurrentMeals.GetItemNumber(lFind,"nreserve_quantity")
				iStatusPaxManual 	= dsCurrentMeals.GetItemNumber(lFind,"status_npax_manual")
				iManualInput 		= dsCurrentMeals.GetItemNumber(lFind,"nmanual_input")
				
				if (lPaxManual <> lPax or lReserveManual <> lReserveQuantity or lTopOffManual <> lTopOffQuantity) and &
					(iStatusPaxManual = 1 or iManualInput = 1) then
					//
					// Nur wenn manuelle Pax-Zahl abweicht und gerade erst ge$$HEX1$$e400$$ENDHEX$$ndert wurde
					// oder generell eine manuelle Eingabe get$$HEX1$$e400$$ENDHEX$$tig wurde.
					//
					lReserveQuantity	= dsCurrentMeals.GetItemNumber(lFind,"nreserve_quantity")
					lTopOffQuantity	= dsCurrentMeals.GetItemNumber(lFind,"ntopoff_quantity")
					//
					// 24.09.04: Nur wenn lPax > 0 ist
					//
					if lPax > 0  then
						return lPaxManual
					else
						return lPax
					end if
				else
					return lPax
				end if
			else
				return lPax
			end if
		end if
	end if
end if


//long		i
//long		lFind
//long		lReserveManual
//long		lTopOffManual
//string	sFind
//
//integer	iStatusPaxManual
//
//sFind = 	"npackinglist_index_key = " 	+ string(lPackinglistIndexKey) + &
//			" and nclass_number = " 		+ string(lClassNumber) + &
//			" and nhandling_key = " 		+ string(lHandlingKey)
//			
//lPaxManual = 0
////
//// Suche Manuell eingegebene Pax
////
//lFind = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
//
//if lFind > 0 then
//	lPaxManual 			= dsCenOutMealsOld.GetItemNumber(lFind,"npax_manual")
//	lReserveManual		= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
//	lTopOffManual		= dsCenOutMealsOld.GetItemNumber(lFind,"ntopoff_quantity")
//	iStatusPaxManual 	= dsCenOutMealsOld.GetItemNumber(lFind,"status_npax_manual")
//	iManualInput 		= dsCenOutMealsOld.GetItemNumber(lFind,"nmanual_input")
//	
//	if (lPaxManual <> lPax or lReserveManual <> lReserveQuantity or lTopOffManual <> lTopOffQuantity) and &
//		(iStatusPaxManual = 1 or iManualInput = 1) then
//		//
//		// Nur wenn manuelle Pax-Zahl abweicht und gerade erst ge$$HEX1$$e400$$ENDHEX$$ndert wurde
//		// oder generell eine manuelle Eingabe get$$HEX1$$e400$$ENDHEX$$tig wurde.
//		//
//		lReserveQuantity	= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
//		lTopOffQuantity	= dsCenOutMealsOld.GetItemNumber(lFind,"ntopoff_quantity")
//		return lPaxManual
//	else
//		return lPax
//	end if
//else
//	//
//	// Suche mit calc_id = 18 (Ratiolist 2), da hier der npackinglist_index_key getauscht wird
//	//
//	sFind = 	"ncalc_id = 18 " + &
//				" and nclass_number = " 		+ string(lClassNumber) + &
//				" and nhandling_key = " 		+ string(lHandlingKey)
//	lFind = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
//	
//	if lFind > 0 then
//		lPaxManual 			= dsCenOutMealsOld.GetItemNumber(lFind,"npax_manual")
//		lReserveManual		= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
//		lTopOffManual		= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
//		iStatusPaxManual 	= dsCenOutMealsOld.GetItemNumber(lFind,"status_npax_manual")
//		iManualInput 		= dsCenOutMealsOld.GetItemNumber(lFind,"nmanual_input")
//		
//		if (lPaxManual <> lPax or lReserveManual <> lReserveQuantity or lTopOffManual <> lTopOffQuantity) and &
//			(iStatusPaxManual = 1 or iManualInput = 1) then
//			//
//			// Nur wenn manuelle Pax-Zahl abweicht und gerade erst ge$$HEX1$$e400$$ENDHEX$$ndert wurde
//			// oder generell eine manuelle Eingabe get$$HEX1$$e400$$ENDHEX$$tig wurde.
//			//
//			lReserveQuantity	= dsCenOutMealsOld.GetItemNumber(lFind,"nreserve_quantity")
//			lTopOffQuantity	= dsCenOutMealsOld.GetItemNumber(lFind,"ntopoff_quantity")
//			return lPaxManual
//		else
//			return lPax
//		end if
//	else
//		return lPax
//	end if
//end if
//
end function

public function integer uf_retrieve_accounts ();//=================================================================================================
//
// uf_retrieve_accounts
//
// F$$HEX1$$fc00$$ENDHEX$$r die Ermittlung des KVA
//
//=================================================================================================

uf_trace(50,"uf_retrieve_accounts(): start retrieve dsCenAirlineAccounts")
dsCenAirlineAccounts.Retrieve(lairlinekey)
uf_trace(50,"uf_retrieve_accounts(): end retrieve dsCenAirlineAccounts")

////
//// 05.10.2005 Ratio-Cache
////
//uf_trace(50,"uf_retrieve_accounts(): start retrieve Ratiolist-Cache")
//dsRatioCache.Retrieve(dgenerationdate)
//uf_trace(50,"uf_retrieve_accounts(): end retrieve Ratiolist-Cache")


//
// Achtung: tausende Datens$$HEX1$$e400$$ENDHEX$$tze!!!
// 25.02.2005: dsPLTypes geht aus dem Rennen
//
//uf_trace(50,"uf_retrieve_accounts(): start retrieve dsPLTypes")
//dsPLTypes.Retrieve()
//uf_trace(50,"uf_retrieve_accounts(): end retrieve dsPLTypes, rows = " + string(dsPLTypes.RowCount()))

return 0

end function

public function integer uf_start_change ();//=================================================================================================
//
// uf_start_change
//
//=================================================================================================
//
// Verarbeitung einer Ver$$HEX1$$e400$$ENDHEX$$nderung von Passagierzahlen
//
// Wichtig: 
// Vor dem Nutzen dieser Methode ist der Datasource von dsCenOutMeals
// und dsCenOutMealsOld zu tauschen (Methode uf_switch_datasource)!!!
//
//=================================================================================================
/*

Nicht vergessen:
================
- npax_manual mu$$HEX2$$df002000$$ENDHEX$$hier speziell ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden!!!
- Trennung von "einfacher Mengen/Pax$$HEX1$$e400$$ENDHEX$$nderung" und "Masterchange"???
- Uhrzeit und Passagierzahl haben bereits Auswirkungen auf cen_meal_cover
- nresultkey ist nur das erste Leg. Bei AC-Change m$$HEX1$$fc00$$ENDHEX$$ssen alle Legs ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden.
- Menge alt darf nur einmal je Transaktion $$HEX1$$fc00$$ENDHEX$$bertragen werden
*/

bInChange	= true

//
//	dsCenOutMealsOld enth$$HEX1$$e400$$ENDHEX$$lt die vorhandenen Mahlzeiten
// seit Version 1.74 ist es nicht mehr notwendig, alte Infos zu haben
//
//if dsCenOutMealsOld.RowCount() = 0 then
//	sErrortext = "Meal Calculation got no information about prior meals!"
//	return -1
//end if
	
//
// Check Properties
//
if lResultKey = 0 or isnull(lResultKey) then
	sErrortext = "Meal Calculation got no valid result key!"
	return -1
end if

if lAircraftKey = 0 or isnull(lAircraftKey) then
	sErrortext = "Meal Calculation got no aircraft related information!"
	return -1
end if

if dsCenOutPax.RowCount() = 0 then
	//
	// In dsCenOutPax stehen doch tats$$HEX1$$e400$$ENDHEX$$chlich die Pax-Zahlen aller Fl$$HEX1$$fc00$$ENDHEX$$ge(!)
	//
	sErrortext = "Meal Calculation got no pax information!"
	return -1
end if

//-------------------------------------------------------------------------------------
//
// Debugging aus Profile
//
//-------------------------------------------------------------------------------------
iDebugLevel = integer(profilestring(sApplicationProfile,"TRACE","MEALCALCTRACE","0"))
uf_trace(10,"Start uf_start_change(): lResultKey=" + string(lResultKey))


//-------------------------------------------------------------------------------------
//
// G$$HEX1$$fc00$$ENDHEX$$ltige KVAs und Packinglist-Types f$$HEX1$$fc00$$ENDHEX$$r Airline holen
//
//-------------------------------------------------------------------------------------
uf_retrieve_accounts()

//-------------------------------------------------------------------------------------
//
// Meal-Cover wird vorgefiltert diesem UserObject von uo_generate $$HEX1$$fc00$$ENDHEX$$bergeben...
// Es ist lediglich der AC-Typ (bzw. Default-AC-Typ) herauszufinden
//
//-------------------------------------------------------------------------------------
uf_trace(10,"Start uf_filter_actype()")
uf_filter_actype()

//f_print_datastore(dsCenOutMealsOld)
//f_print_datastore(dsCenOutMeals)
//f_print_datastore(dsCurrentMeals)
//f_print_datastore(dsHandlingMealCover)
//f_print_datastore(dsCenOutPax)

//-------------------------------------------------------------------------------------
//
// Merker: 	Eintrag der manuell selektierten Mahlzeitenbeladung-Objekte
//				nach dsHandlingMealCover:
//				MZ aus dsCenOutMealsOld mit nmanual_processing = 1
//
//-------------------------------------------------------------------------------------
uf_trace(10,"Start uf_manual_rescue()")
uf_manual_rescue()

//-------------------------------------------------------------------------------------
//
// Mahlzeitenbeladung zusammenstellen
//
//-------------------------------------------------------------------------------------
uf_trace(10,"Start uf_compile()")
uf_compile()

//-------------------------------------------------------------------------------------
//
// Vergleich alt <-> neu
//
//-------------------------------------------------------------------------------------
uf_trace(10,"Start uf_compare_new_current()")
uf_compare_new_current()


//
// 17.10.05	fehlende Sequences holen
//
long	lSequence, i, lfind, lcurrentDetailKey
if iUseSequence = 0 then
	//f_print_datastore(dsCenOutMeals)
	uf_trace(10,"uf_compile(): Check empty sequences...")
	for i = 1 to dsCenOutMeals.RowCount()
		lcurrentDetailKey = dsCenOutMeals.GetItemNumber(i,"ndetail_key")
		if lcurrentDetailKey = 0 then
			lSequence = f_Sequence("seq_cen_out_meals", sqlca)
			dsCenOutMeals.SetItem(i,"ndetail_key",lSequence)
			uf_trace(50,"uf_compile(): Not enough sequences in old datastore..." + string(lSequence))
		end if
//		lfind = dsOldMeals.find("ndetail_key = " + string(lcurrentDetailKey),1,dsOldMeals.RowCount())
//		if lfind <> i then
//			if lfind > 0 then
//				lSequence = f_Sequence("seq_cen_out_meals", sqlca)
//				dsCenOutMeals.SetItem(i,"ndetail_key",lSequence)
//				uf_trace(50,"uf_compile(): Fixed duplicated sequence from " + string(lcurrentDetailKey) + " to "  + string(lSequence))
//			end if
//		end if
	next
end if


uf_trace(10,"End uf_start_change")

return 0

end function

public function integer uf_start_change_on_cen_out ();//=================================================================================================
//
// uf_start_change_on_cen_out
//
// F$$HEX1$$fc00$$ENDHEX$$hrt eine Mahlzeitenkalkulation auf Basis der generierten Daten aus.
// (Geeignet f$$HEX1$$fc00$$ENDHEX$$r Option "Tausche keine Mahlzeiten", wenn sich aber die Passagierzahl ver$$HEX1$$e400$$ENDHEX$$ndert)
//
//=================================================================================================
//
// Verarbeitung einer Ver$$HEX1$$e400$$ENDHEX$$nderung von Passagierzahlen
//
// Wichtig: 
// Vor dem Nutzen dieser Methode ist der Datasource von dsCenOutMeals
// und dsCenOutMealsOld zu tauschen (Methode uf_switch_datasource)!!!
//
//=================================================================================================
/*

Nicht vergessen:
================
*/
long		i, j, lRow, lFind
long		lSequence
datetime	dtTimeStamp
long		liComponentGroup	
long		llRotationNameKey	
long		llMealsDetailPrio	
long		liPercentage
long		llCalcID
long		llLastCalcID
long		llLastComponentGroup
long		llTopOffSPML
long		llQuantity


bInChange	= true

//-------------------------------------------------------------------------------------
// Debugging aus Profile
//-------------------------------------------------------------------------------------
iDebugLevel = integer(profilestring(sApplicationProfile,"TRACE","MEALCALCTRACE","0"))


//
//	dsCenOutMealsOld enth$$HEX1$$e400$$ENDHEX$$lt die vorhandenen Mahlzeiten
//
if dsCenOutMealsOld.RowCount() = 0 then
	sErrortext = "Meal Calculation got no information about prior meals!"
	return -1
end if
	
//
// Check Properties
//
if lResultKey = 0 or isnull(lResultKey) then
	sErrortext = "Meal Calculation got no valid result key!"
	return -1
end if

if lAircraftKey = 0 or isnull(lAircraftKey) then
	sErrortext = "Meal Calculation got no aircraft related information!"
	return -1
end if

if dsCenOutPax.RowCount() = 0 then
	//
	// In dsCenOutPax stehen doch tats$$HEX1$$e400$$ENDHEX$$chlich die Pax-Zahlen aller Fl$$HEX1$$fc00$$ENDHEX$$ge(!)
	//
	sErrortext = "Meal Calculation got no pax information!"
	return -1
end if

//
// $$HEX1$$dc00$$ENDHEX$$bertrag 
//
dsCenOutMealsOld.RowsCopy(1,dsCenOutMealsOld.RowCount(),Primary!,dsCenOutMeals,dsCenOutMeals.RowCount() + 1,Primary!)

dsCenOutMeals.SetSort("nclass_number A, ncover_prio A, nprio A")
dsCenOutMeals.Sort()

//
// Mahlzeitenbeladung aufgrund vorheriger Beladung neu zusammenstellen
// (Abl$$HEX1$$f600$$ENDHEX$$sung uf_compile)
// 
for i = 1 to dsCenOutMeals.RowCount()
	//--------------------------------------------------------------------------------
	//
	// Es sind lediglich Mengen neu zu berechnen, 
	// auf keinen Fall ist irgendetwas aus dem Stammdaten zu holen
	//
	//--------------------------------------------------------------------------------
	iComponentGroup	= dsCenOutMeals.GetItemNumber(i,"ncomponent_group")
	lRotationNameKey	= dsCenOutMeals.GetItemNumber(i,"nrotation_name_key")
	lMealsDetailPrio	= dsCenOutMeals.GetItemNumber(i,"nprio")
	lClassNumber		= dsCenOutMeals.GetItemNumber(i,"nclass_number")
	lCalcID		 		= dsCenOutMeals.GetItemNumber(i,"ncalc_id")
	lCalcDetailKey		= dsCenOutMeals.GetItemNumber(i,"ncalc_detail_key")
	lReserveQuantity	= dsCenOutMeals.GetItemNumber(i,"nreserve_quantity")
	lTopOffQuantity		= dsCenOutMeals.GetItemNumber(i,"ntopoff_quantity")
	iReserveType		= dsCenOutMeals.GetItemNumber(i,"nreserve_type")
	iTopOffType			= dsCenOutMeals.GetItemNumber(i,"ntopoff_type")
	iModuleType		= dsCenOutMeals.GetItemNumber(i,"nmodule_type")
	iAsk4Passenger		= dsCenOutMeals.GetItemNumber(i,"nask4passenger")
	iPassengerGroup	= dsCenOutMeals.GetItemNumber(i,"npassenger_group")
	sQuestionText		= dsCenOutMeals.GetItemString(i,"cquestion_text")
	iBillingStatus		= dsCenOutMeals.GetItemNumber(i,"nbilling_status")
	iPercentage			= dsCenOutMeals.GetItemNumber(i,"npercentage")
	dcValue				= dsCenOutMeals.GetItemDecimal(i,"nvalue")
	sMultiClasses		= dsCenOutMeals.GetItemString(i,"cclasses")
	iSPMLDeduction	= dsCenOutMeals.GetItemNumber(i,"nspml_deduction")
	iACTransfer			= dsCenOutMeals.GetItemNumber(i,"nac_transfer")
	

	// --------------------------------------------------------------------------------------------------------------------
	// 07.08.2015 HR: CBASE-DE-CR-2015-054
	// --------------------------------------------------------------------------------------------------------------------
	string sFind
	
	lHandlingMealKey		= dsCenOutMeals.GetItemNumber(i, "nhandling_meal_key")
	lHandlingDetailKey		= dsCenOutMeals.GetItemNumber(i, "nhandling_detail_key")
 	lMinValue					= dsCenOutMeals.GetItemNumber(i, "nmin_value")
	lMaxValue					= dsCenOutMeals.GetItemNumber(i, "nmax_value")
	lForeignObject			= dsCenOutMeals.GetItemNumber(i, "nforeign_object")
	iForeignGroup			= dsCenOutMeals.GetItemNumber(i, "nforeign_group")
	
	
	// --------------------------------------------------------------------------------------------------------------------
	// 10.10.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
	// --------------------------------------------------------------------------------------------------------------------
	iPlanningPercent				= dsCenOutMeals.GetItemNumber(i,"nplanning_percent")
	icmc_cprefix						= dsCenOutMeals.GetItemString(i,"cprefix")
	icmc_nreduce					= dsCenOutMeals.GetItemNumber(i,"nreduce")
	icmc_coverunderload			= dsCenOutMeals.GetItemString(i,"coverunderload")
	icmc_nservice_sequence	= dsCenOutMeals.GetItemNumber(i,"nservice_sequence"	)
	is_sap_code						= dsCenOutMeals.GetItemString(i,"csap_code")

	if icmc_nreduce = 1 then

		if ids_cen_meals_det_deduction.find("nhandling_detail_key = "+string(lHandlingDetailKey), 1, ids_cen_meals_det_deduction.rowcount())=0 then
			datastore lds 
			
			lds = create datastore
			lds.dataobject = ids_cen_meals_det_deduction.dataobject
			lds.settransobject(SQLCA)
			lds.retrieve(lHandlingDetailKey, lResultKey, dGenerationDate) // 17.06.2016 HR:
			
			if lds.rowcount()>0 then
				lds.rowscopy(1, lds.rowcount(), primary!, ids_cen_meals_det_deduction, 1, primary!)
			end if
			
			destroy lds
		end if
	
		if not isnull(lForeignObject) then
			// --------------------------------------------------------------------------------------------------------------------
			// 07.08.2015 HR: CBASE-DE-CR-2015-054 Wir schauen, ob wir f$$HEX1$$fc00$$ENDHEX$$r diese Zeile schon was retrieved haben,
			//                         ansonsten legen wir eine Zeile an
			// --------------------------------------------------------------------------------------------------------------------
			sFind = "nhandling_detail_key = " + string(lHandlingDetailKey)
			sFind += "and nresult_key = " + string(lResultKey)
			
			if ids_cen_meals_det_deduction.find(sFind, 1, ids_cen_meals_det_deduction.rowcount())=0 then
				ids_cen_meals_det_deduction.insertrow(1)
				
				ids_cen_meals_det_deduction.setitem(1, "nhandling_detail_key", lHandlingDetailKey)
				ids_cen_meals_det_deduction.setitem(1, "nresult_key", lResultKey)
				ids_cen_meals_det_deduction.setitem(1, "nforeign_object", lForeignObject)
				ids_cen_meals_det_deduction.setitem(1, "nforeign_group", iForeignGroup)
				ids_cen_meals_det_deduction.setitem(1, "nclass_number", lClassNumber)
				ids_cen_meals_det_deduction.setitem(1, "cen_handling_ctext", "TEST")
				ids_cen_meals_det_deduction.setitem(1, "nhandling_meal_key", lHandlingMealKey)
			end if
		end if
	end if
	//--------------------------------------------------------------------------------
	// Berechnung der neuen Auftragsmengen
	//--------------------------------------------------------------------------------
	lFind = dsCenOutPax.find("nresult_key = " + string(lresultkey) + " and nclass_number = " + string(lClassNumber),1,dsCenOutPax.RowCount())
	if lFind <= 0 then
		sErrortext = "No passenger information found"
		return -1
	end if
	
	lPax 					= dsCenOutPax.GetItemNumber(lFind,"npax")
	sClass				= dsCenOutPax.GetItemString(lFind,"cclass")
	iVersion				= dsCenOutPax.GetItemNumber(lFind,"nversion")
	
	//
	// Change-Gesch$$HEX1$$e400$$ENDHEX$$ft:
	// lPaxManual befindet sich auf Zeilenebene
	// Reserve- und TopOffMengen k$$HEX1$$f600$$ENDHEX$$nnten ge$$HEX1$$e400$$ENDHEX$$ndert worden sein
	//
	lPaxManual 			= uf_get_pax_manual()

	//
	// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Ausz$$HEX1$$e400$$ENDHEX$$hlung angesagt ist ($$HEX1$$fc00$$ENDHEX$$berschreibt dann die lPax)
	//
	uf_ask4passenger()
	
	//
	// Ermittlung der Berechnungsgrundlage lCalcBasis
	//
	uf_get_calc_basis()
	
	//
	// Falls SPML-Abzug f$$HEX1$$fc00$$ENDHEX$$r aktuelle MZ-Komponente, dann hier durchf$$HEX1$$fc00$$ENDHEX$$hren
	//
	lNumberOfSPML = 0
	if iSPMLDeduction = 1 then
		for j = 1 to dsSPML.RowCount()
			if dsSPML.GetItemNumber(j,"nclass_number") = lClassNumber then
				llTopOffSPML = dsSPML.GetItemNumber(j,"ntopoff")
				//
				// TopOff-SPML d$$HEX1$$fc00$$ENDHEX$$rfen keinen Abzug erfahren
				//
				if llTopOffSPML = 0 then
					llQuantity = dsSPML.GetItemNumber(j,"nquantity")
					lNumberOfSPML += llQuantity
				end if
			end if
		next
		lCalcBasis -= lNumberOfSPML
		if lCalcBasis < 0 then lCalcBasis = 0
	end if
	
	//
	// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob eine $$HEX1$$dc00$$ENDHEX$$berbeladung verrechnet werden soll
	//
	uf_check_overload()
	
	//
	// Simulation zur$$HEX1$$fc00$$ENDHEX$$ck
	//
	if llLastCalcID <> lCalcID or llLastComponentGroup <> liComponentGroup then
		dscenmeals.Reset()
		lCurrentRow = 0
		
		// --------------------------------------------------------------------------------------------------------------------
		// 25.06.2014 HR: Wir holen uns die Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung aus den Bewegungsdaten
		// --------------------------------------------------------------------------------------------------------------------
		for j = 1 to dsCenOutMeals.RowCount()
			liComponentGroup	= dsCenOutMeals.GetItemNumber(j,"ncomponent_group")
			llRotationNameKey	= dsCenOutMeals.GetItemNumber(j,"nrotation_name_key")
			llMealsDetailPrio	= dsCenOutMeals.GetItemNumber(j,"nprio")
			liPercentage			= dsCenOutMeals.GetItemNumber(j,"npercentage")
			llCalcID		 		= dsCenOutMeals.GetItemNumber(j,"ncalc_id")
		
			//
			// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
			// => dsCenMeals simulieren
			//
			lRow = dsCenMeals.InsertRow(0)
			dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	liComponentGroup)
			dsCenMeals.SetItem(lRow,"nrotation_name_key",							llRotationNameKey)
			dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",						llMealsDetailPrio)
			dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			liPercentage)
			dsCenMeals.SetItem(lRow,"nstatus", 												0)
			dsCenMeals.SetItem(lRow,"cen_meals_detail_ncalc_id", 					llCalcID)
			dsCenMeals.SetItem(lRow,"cen_packinglist_index_cpackinglist", 		dsCenOutMeals.GetItemString(j,"cpackinglist"))

		next
		
	end if
	
	//HR 07.07.2008 CBASE-UK-EM-4402
	//Variable zur$$HEX1$$fc00$$ENDHEX$$cksetzen, so dass der normale Produktionstext benutzt wird.
	sProductionTextReplace = ""

	// --------------------------------------------------------------------------------------------------------------------
	// 06.08.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	Choose Case lCalcID
		case 1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			uf_get_flight_parm_diff ( lHandlingDetailKey, il_flgnr, is_suffix, iPercentage, dcValue, lMinValue, lMaxValue)
	End Choose

	// Berechnung
	choose case lCalcID
		case 1
			//
			// Feste Menge
			//
			// 27.03.2014 HR:
			//dcQuantity = dcValue
			dcQuantity = dsCenOutMeals.GetItemNumber(i,"nquantity")
		case 2
			//
			// 100% f$$HEX1$$fc00$$ENDHEX$$r Klasse
			//
			dcQuantity = iVersion
		case 3
			//
			// Ratiolist
			//
			uf_calc_ratiolist()
		case 4
			//
			// Normal
			//
			dcQuantity = lCalcBasis
		case 5
			//
			// Prozent
			//
			//
			// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
			// => dsCenMeals simulieren
			//
			if dscenmeals.RowCount() = 0 then
				//
				// Vollst$$HEX1$$e400$$ENDHEX$$ndigen Stammdaten-Baustein simulieren!
				//
				for j = i to dsCenOutMeals.RowCount()
					liComponentGroup	= dsCenOutMeals.GetItemNumber(j,"ncomponent_group")
					llRotationNameKey	= dsCenOutMeals.GetItemNumber(j,"nrotation_name_key")
					llMealsDetailPrio	= dsCenOutMeals.GetItemNumber(j,"nprio")
					liPercentage		= dsCenOutMeals.GetItemNumber(j,"npercentage")
					llCalcID		 		= dsCenOutMeals.GetItemNumber(j,"ncalc_id")
					
					if llCalcID <> 5 then exit
				
					//
					// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
					// => dsCenMeals simulieren
					//
					lRow = dsCenMeals.InsertRow(0)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	liComponentGroup)
					dsCenMeals.SetItem(lRow,"nrotation_name_key",						llRotationNameKey)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",					llMealsDetailPrio)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			liPercentage)
				next
			end if
			lCurrentRow++
			uf_calc_percent(0)
		case 6
			//
			// Prozent kfm.
			//
			
			//
			// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
			// => dsCenMeals simulieren
			//
			if dscenmeals.RowCount() = 0 then
				//
				// Vollst$$HEX1$$e400$$ENDHEX$$ndigen Stammdaten-Baustein simulieren!
				//
				for j = i to dsCenOutMeals.RowCount()
					liComponentGroup	= dsCenOutMeals.GetItemNumber(j,"ncomponent_group")
					llRotationNameKey	= dsCenOutMeals.GetItemNumber(j,"nrotation_name_key")
					llMealsDetailPrio	= dsCenOutMeals.GetItemNumber(j,"nprio")
					liPercentage		= dsCenOutMeals.GetItemNumber(j,"npercentage")
					llCalcID		 		= dsCenOutMeals.GetItemNumber(j,"ncalc_id")
					
					if llCalcID <> 6 then exit
				
					//
					// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
					// => dsCenMeals simulieren
					//
					lRow = dsCenMeals.InsertRow(0)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	liComponentGroup)
					dsCenMeals.SetItem(lRow,"nrotation_name_key",						llRotationNameKey)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",					llMealsDetailPrio)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			liPercentage)
				next
			end if

			lCurrentRow++
			uf_calc_percent_com()
		case 7, 68
			//
			// Vielfaches
			//
			uf_calc_multiple()
			// Bei Berechnungsart 68 hinterher nochmal gegen die Obergrenze pr$$HEX1$$fc00$$ENDHEX$$fen
			if lCalcID = 68 and dcQuantity > lMaxValue then
				dcQuantity = lMaxValue
			end if
		case 8
			//
			// Ganzzahliges
			//
			uf_calc_integer()
		case 9, 10
			//
			// Bosta-Plus
			//
			uf_calc_bosta_plus()
		case 11,12
			//
			// Bosta-Minus
			//
			uf_calc_bosta_minus()
		case 13
			//
			// Prozent-Vielfach
			//
			uf_calc_percent_multiple()
		case 14
			//
			// Prozent absolut
			//
//			uf_calc_percent_abs()
			//
			// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
			// => dsCenMeals simulieren
			//
			if dscenmeals.RowCount() = 0 then
				//
				// Vollst$$HEX1$$e400$$ENDHEX$$ndigen Stammdaten-Baustein simulieren!
				//
				for j = i to dsCenOutMeals.RowCount()
					liComponentGroup	= dsCenOutMeals.GetItemNumber(j,"ncomponent_group")
					llRotationNameKey	= dsCenOutMeals.GetItemNumber(j,"nrotation_name_key")
					llMealsDetailPrio	= dsCenOutMeals.GetItemNumber(j,"nprio")
					liPercentage		= dsCenOutMeals.GetItemNumber(j,"npercentage")
					llCalcID		 		= dsCenOutMeals.GetItemNumber(j,"ncalc_id")
					
					if llCalcID <> 6 then exit
				
					//
					// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
					// => dsCenMeals simulieren
					//
					lRow = dsCenMeals.InsertRow(0)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	liComponentGroup)
					dsCenMeals.SetItem(lRow,"nrotation_name_key",						llRotationNameKey)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",					llMealsDetailPrio)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			liPercentage)
				next
			end if

			lCurrentRow++
			uf_calc_percent(dcValue);  	
		case 15, 16, 17
			//
			// Gesamtpassagierzahl
			//
			uf_calc_booking_classes()
		case 18
			//
			// St$$HEX1$$fc00$$ENDHEX$$cklisten Ratiolist
			//
			uf_calc_ratiolist2()
		case 19
			//
			// Differenz zu Full-House
			//
			uf_calc_difference_fullhouse()
		case 20
			//
			// Prozent minus absolut
			//
//			uf_calc_percent_abs_minus()
			//
			// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
			// => dsCenMeals simulieren
			//
			if dscenmeals.RowCount() = 0 then
				//
				// Vollst$$HEX1$$e400$$ENDHEX$$ndigen Stammdaten-Baustein simulieren!
				//
				for j = i to dsCenOutMeals.RowCount()
					liComponentGroup	= dsCenOutMeals.GetItemNumber(j,"ncomponent_group")
					llRotationNameKey	= dsCenOutMeals.GetItemNumber(j,"nrotation_name_key")
					llMealsDetailPrio	= dsCenOutMeals.GetItemNumber(j,"nprio")
					liPercentage		= dsCenOutMeals.GetItemNumber(j,"npercentage")
					llCalcID		 		= dsCenOutMeals.GetItemNumber(j,"ncalc_id")
					
					if llCalcID <> 6 then exit
				
					//
					// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
					// => dsCenMeals simulieren
					//
					lRow = dsCenMeals.InsertRow(0)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	liComponentGroup)
					dsCenMeals.SetItem(lRow,"nrotation_name_key",						llRotationNameKey)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",					llMealsDetailPrio)
					dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			liPercentage)
				next
			end if

			lCurrentRow++
			uf_calc_percent(dcValue * -1);  
		case 21
			//
			// Vielfaches m
			//
			uf_calc_multiple_m()
		case 22
			//
			// Feste Menge ab i Paxe
			//
			if lCalcBasis >= iPercentage then
				dcQuantity = dcValue
			else
				dcQuantity = 0
			end if
		case 23
			//
			// Prozent inkl. Ergebnis 0
			//
			lCurrentRow++ // 25.06.2014 HR:
			uf_calc_percent_zero()
		case 24
			//
			// Ratiolist auf Buchungsklassen
			//
			lCalcBasis = uf_get_booking_classes()
			uf_calc_ratiolist()
		case 25
			//
			// Ratiolist II auf Buchungsklassen
			//
			lCalcBasis = uf_get_booking_classes()
			uf_calc_ratiolist2()
		case 26
			//
			// Ratiolist auf Buchungsklassen
			//
			lCalcBasis = uf_get_booking_class_1_2()
			uf_calc_ratiolist()
		case 27
			//
			// Ratiolist II auf Buchungsklassen
			//
			lCalcBasis = uf_get_booking_class_1_2()
			uf_calc_ratiolist2()
			

			// --------------------------------------------------------------------------------------------------------------------
			// 27.03.2014 HR: 28 - 103 aus uf_calculate $$HEX1$$fc00$$ENDHEX$$bernommen
			// --------------------------------------------------------------------------------------------------------------------
			
	case 28
		// n% f$$HEX1$$fc00$$ENDHEX$$r Klasse
		if iPercentage > 0 then
			dcQuantity = Round(iVersion * iPercentage / 100, 0)
		else
			dcQuantity = 0
		end if
	case 29
		// Paxe n Klassen
		dcQuantity = uf_calc_multi_class_sum(1); 	
	case 30
		// Paxe n Klassen + Prozent
		uf_calc_multi_class_sum(1)														
		dcQuantity 			= Round(dcQuantity + (dcQuantity* iPercentage / 100), 0); 	
	case 31
		// Paxe n Klassen Vielfach
		lCalcBasis 		= uf_calc_multi_class_sum(1)	
		uf_calc_multiple()										
	case 32
		// Paxe n Klassen Absolut
		dcQuantity 			= uf_calc_multi_class_sum(1) + dcValue	
	case 33
		//  Paxe n Klassen - Absolut
		dcQuantity = uf_calc_multi_class_sum(1) - dcValue	
		if dcQuantity <= 0 then dcQuantity = 0
	case 34
		// Paxe n Klassen - Prozent  immer aufrunden 
		uf_calc_multi_class_sum(1)											
		dcQuantity = Ceiling(dcQuantity - (dcQuantity * iPercentage / 100))	
	case 35
		// Version n Klassen
		dcQuantity 			= uf_calc_multi_class_sum(2)	
	case 36
		// Version n Klassen + Prozent
		uf_calc_multi_class_sum(2) 															
		dcQuantity = Round(dcQuantity+ (dcQuantity * iPercentage / 100), 0)					
	case 37
		// Version n Klassen Vielfach
		lCalcBasis 		= uf_calc_multi_class_sum(2)
		uf_calc_multiple()										
	case 38
		// Version n Klassen Absolut
		dcQuantity 			= uf_calc_multi_class_sum(2) + dcValue	
	case 39
		// Version n Klassen - Absolut
		dcQuantity = uf_calc_multi_class_sum(2) - dcValue		
		if dcQuantity <= 0 then dcQuantity = 0
	case 40
		// Version n Klassen - Prozent immer aufrunden 
		uf_calc_multi_class_sum(2)											
		dcQuantity = Ceiling(dcQuantity - (dcQuantity * iPercentage / 100))	
	case 41
		// Paxe n Klassen Prozent
		uf_calc_multi_class_sum(1) 
		dcQuantity = Round(dcQuantity * iPercentage / 100, 0)				
	case 42
		// Version n Klassen Prozent
		uf_calc_multi_class_sum(2)
		dcQuantity = Round(dcQuantity* iPercentage / 100, 0)				
	case 43
		// Sitz Paxe n Klassen
		dcQuantity = uf_calc_multi_class_sum(3)		
	case 44
		// Version n Klassen Prozent LH Rundung
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_version_n_classes_percent_lh(); 	
	case 45
		// Paxe n Klassen vielfach mit SPML-Abzug TBR 16.05.2013
		lCalcBasis 		= uf_calc_multi_class_sum(4)
		lCalcBasis = lCalcBasis  - il_spml_count
		uf_calc_multiple()		
		
// -----------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r CalcID 61,62,63
// -----------------------------------------------------------------
//MHO 2016-09-30: Werte kleiner Null f$$HEX1$$fc00$$ENDHEX$$r lCalcBasis werden auf Null gesetzt
//https://cbasealm.ads.dlh.de/plugins/tracker/?aid=1397
//If the pax count is greater than config, then the system will calculate the wrong figures.
//The correct quantity should be 0.
// -----------------------------------------------------------------
		
	case 61
		// Diff. Full House Prozent
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		uf_calc_percent(0)									
	case 62
		// Diff. Full House Prozent kfm.
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_com();	
	case 63
		// Diff. Full House Prozent inkl 0
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_zero()	
	case 64
		// Prozent Vielfach f$$HEX1$$fc00$$ENDHEX$$r Gruppen
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_multiple_for_groups();	
	case 65, 66	// 07.11.12, Gunnar Brosch: QuantityVersion
		// Prozent abrunden
		lCurrentRow++ // 25.06.2014 HR:
		if lCalcID = 65 then
			uf_calc_percent_round_down(0, 1);
		else
			uf_calc_percent_round_down(0, 0);
		end if
	case 67
		// Prozentbeladung mit den Prozenten am City pair
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_by_cp(0);
//	case 68 		
		// keine eignen Funktion 68, siehe 7
	case 69	
		// 69 = n% f$$HEX1$$fc00$$ENDHEX$$r Klasse LH Rundung
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_n_percent_for_class_lh();
	case 70,71		
		// 16.04.2010 HR:   70 Bob Percentage + Minimum
		//						 71 Bob Percentage - xx%  + Minimum
		uf_calc_bob_percent(lCalcID);
	case 72,73
		// 17.05.2010 HR:   72 Bob Percentage + Minimum (Immer abrunden)
		//						73 Bob Percentage - xx% + Minimum (Immer abrunden)
		uf_calc_bob_percent_round_down(lCalcID); 	
	case 74,75
		// 10.06.2010 HR:   74 Bob Percentage + Minimum (k$$HEX1$$e400$$ENDHEX$$ufm$$HEX1$$e400$$ENDHEX$$nnisch Runden)
		//						75 Bob Percentage - xx% + Minimum (k$$HEX1$$e400$$ENDHEX$$ufm$$HEX1$$e400$$ENDHEX$$nnisch Runden)
		uf_calc_bob_percent_com(lCalcID);			
	case 76
		// 17.06.2010 HR: Prozent abrunden +/- Absolut (R$$HEX1$$fc00$$ENDHEX$$ckgabe kann 0 sein)
		uf_calc_percent_round_down(dcValue, 0);	
	case 77
		// Feste Menge BOB
		uf_calc_bob_fixed()	
	case 78
		// Feste Menge City Pair
		uf_calc_fixed_cp()		
	case 79		
		//	BOB % CP Round Up with max 
		uf_calc_bob_percent(lCalcID);
	case 80
		// 80	= BOB % CP Round Down with max 
		uf_calc_bob_percent_round_down(lCalcID);
	case 81
		// 81	= BOB % CP Com with max 
		uf_calc_bob_percent_com(lCalcID);	
	case 82
		// 82 = Ratiolist Precentage
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_ratiolist_percentage(0);
	case 83
		// 83  = Ratiolist Precentage incl. Return Flight Pax Figures
		uf_add_return_flight_pax()		
		uf_calc_ratiolist()				
	case 84
		// 84  = Ratiolist I auf addierte Paxe aus n Klassen anwenden
		uf_calc_multiclass_sum_ratiolist(1)
		uf_calc_ratiolist()					
	case 85
		// 85  = Ratiolist II auf addierte Paxe aus n Klassen anwenden
		uf_calc_multiclass_sum_ratiolist(1) 
		uf_calc_ratiolist2()				
	case 86
		// 86  = Ratiolist I auf addierte Versionen aus n Klassen anwenden
		uf_calc_multiclass_sum_ratiolist(2) 
		uf_calc_ratiolist()					
	case 87
		// 87  = Ratiolist II auf addierte Versionen aus n Klassen anwenden
		uf_calc_multiclass_sum_ratiolist(2) 
		uf_calc_ratiolist2()				
	case 88
		// 88  = Ratiolist I auf addierte Versionen aus n Klassen - SPML anwenden
		uf_calc_multiclass_sum_ratiolist_spml(2) 
		uf_calc_ratiolist()						
	case 89
		// 89  = Ratiolist II auf addierte Versionen aus n Klassen - SPML anwenden
		uf_calc_multiclass_sum_ratiolist_spml(2) 
		uf_calc_ratiolist2()					
	case 90
		// Feste Menge pro AC Version
		uf_calc_fixed_ac_version()				
	case 91
		// 91 = Ratiolist Percentage + Group + Version Cutoff
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_version_cutoff()		
	case 92
		// 22.01.2013 HR: 92 = BOB Multiple N  (z.B. 3 St$$HEX1$$fc00$$ENDHEX$$ck pro 5 Paxe)
		uf_calc_bob_multiple(0)
	case 93
		// 22.01.2013 HR: 93 = BOB Multiple N  with Max (z.B. 3 St$$HEX1$$fc00$$ENDHEX$$ck pro 5 Paxe)
		uf_calc_bob_multiple(1)
	case 94
		// 94 = Link Calculation nach American Airlines
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_linked_aa();
	case 95   // 22.01.2013 HR: vorher 92
		// 95 = Multiple & Fixed Calculation nach American Airlines
		uf_calc_multiple_fixed_aa();
		
	case 96   // 22.01.2013 HR: vorher 93
		// 96 = Percentage Calculation nach American Airlines
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_aa();
		
	case 98   // 27.03.2013 CBASE-ZA-CR-8005
		// 98 = percentage round-off with absolute
		lCurrentRow++ // 25.06.2014 HR:
		uf_calc_percent_round_off_with_absolute()

	case 99 // 99 = Platzhalter f$$HEX1$$fc00$$ENDHEX$$r DL Bob Ersetzung (ID nicht anderweitig benutzen)
		uf_calc_bob_percent(lCalcID); 		

	case 100
		// 100 = Feste Menge bis zur Version/Pax-Differenz  ( 24.05.2013 HR) /  Fehlerliste 4.93 #7
		if iVersion - lPax - lReserveQuantity >= dcValue then
			dcQuantity 			= dcValue		
		else
			dcQuantity 			=  iVersion - lPax	- lReserveQuantity	
		end if
	case 101		
		// 101 = BOB % CP Round Off with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		uf_calc_bob_percent_com(lCalcID);			
	case 102
		// 102 = BOB % CP Round Down with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		uf_calc_bob_percent_round_down(lCalcID);	
	case 103
		//	103 = BOB % CP Round Up with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		uf_calc_bob_percent(lCalcID);	
			
	case 105
		// --------------------------------------------------------------------------------------------------------------------
		// 105 = Feste Menge pro AC Typ & Version und Departure Station (CBASE-CR-UK-2015-014)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_fixed_acver_tlcfrom() 

	case else
			//
			// Im Zweifel immer 1:1
			//
			dcQuantity = lCalcBasis
	end choose
	
	llLastCalcID = lCalcID
	llLastComponentGroup = liComponentGroup
	//--------------------------------------------------------------------------------
	//
	// Neue Werte eintragen
	//
	//--------------------------------------------------------------------------------
	dtTimeStamp = datetime(today(),now())
	
	lSequence = f_Sequence("seq_cen_out_meals", sqlca)
	// -----------------------------------------
	// liefert -1 bei Fehler
	// -----------------------------------------
	If lSequence = -1 Then
		return -1
	end if
	
	dsCenOutMeals.SetItem(i,"ndetail_key",					lSequence)
	dsCenOutMeals.SetItem(i,"dtimestamp",					dtTimeStamp)
	dsCenOutMeals.SetItem(i,"nquantity",					dcQuantity)
	dsCenOutMeals.SetItem(i,"nquantity_old",				dcOldQuantity)
	dsCenOutMeals.SetItem(i,"ncalc_basis",					lCalcBasis)	// Berechnungsgrundlage speichern
	dsCenOutMeals.SetItem(i,"npax",							lPax)
	dsCenOutMeals.SetItem(i,"npax_manual",					lPaxManual)
	dsCenOutMeals.SetItem(i,"noverload",lOverloadSet)		// $$HEX1$$dc00$$ENDHEX$$berbeladung aus Prozentberechnung wird nur temp. im Datastore gespeichert
	dsCenOutMeals.SetItem(i,"noverload_version",lOverloadSet_ver)
	
	if iStatus > 0 and iStatus < 8 then
		for j = iStatus to 7 
			dsCenOutMeals.SetItem(j,"nquantity" + string(j),dcQuantity)
		next
	end if
	
	if bInChange then
		//
		// Change-Modus hat mehr Felder im Datasource
		//
		dsCenOutMeals.SetItem(i,"status_nreserve_quantity",0)
		dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",0)
	end if
next

//
// Vergleich alt <-> neu
//
uf_compare_new_old()

// 03.04.2014 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen hier die Datens$$HEX1$$e400$$ENDHEX$$tze mit nmanual_processing=2 ausfiltern, da diese beim Einspielen im DW stehen bleiben und sich dann verdoppeln w$$HEX1$$fc00$$ENDHEX$$rden
i = dsCenOutMeals.setfilter("nmanual_processing < 2")
dsCenOutMeals.filter()

return 0

end function

public function integer uf_start_from_scratch ();//=================================================================================================
//
// uf_start_from_scratch
//
//=================================================================================================
//
// Erster Aufruf einer Mahlzeitenermittlung bei der Generierung eines Fluges.
//
//
//=================================================================================================
long		i, j

bInGeneration = true

//-------------------------------------------------------------------------------------
// Debugging aus Profile
//-------------------------------------------------------------------------------------
iDebugLevel = integer(profilestring(sApplicationProfile,"TRACE","MEALCALCTRACE","0"))

//
// Check Properties
//
if lResultKey = 0 or isnull(lResultKey) then
	sErrortext = "Meal Calculation got no valid result key!"
	uf_trace(20,"uf_start_from_scratch(): Error - " + sErrorText)
	return -1
end if

if lAircraftKey = 0 or isnull(lAircraftKey) then
	sErrortext = "Meal Calculation got no aircraft related information!"
	uf_trace(20,"uf_start_from_scratch(): Error - " + sErrorText)
	return -1
end if

if dsCenOutPax.RowCount() = 0 then
	//
	// In dsCenOutPax stehen doch tats$$HEX1$$e400$$ENDHEX$$chlich die Pax-Zahlen aller Fl$$HEX1$$fc00$$ENDHEX$$ge(!)
	//
	sErrortext = "Meal Calculation got no pax information!"
	uf_trace(20,"uf_start_from_scratch(): Error - " + sErrorText)
	return -1
end if

//
// Bevor es losgeht: Reset auf dsCenOutMeals, da bei der Generierung die Instanz nicht
// zerst$$HEX1$$f600$$ENDHEX$$rt wird
//
// Verschoben nach uo_generate: dsCenOutMeals.Reset()

//-------------------------------------------------------------------------------------
//
// G$$HEX1$$fc00$$ENDHEX$$ltige KVAs f$$HEX1$$fc00$$ENDHEX$$r Airline holen
//
//-------------------------------------------------------------------------------------
uf_retrieve_accounts()

//
// Meal-Cover wird vorgefiltert diesem UserObject von uo_generate $$HEX1$$fc00$$ENDHEX$$bergeben...
// Es ist lediglich der AC-Typ (bzw. Default-AC-Typ) herauszufinden
//
uf_filter_actype()

//f_print_datastore(dsHandlingMealCover)

//
// Mahlzeitenbeladung zusammenstellen
//
uf_compile()

//
// Matdispo: $$HEX1$$dc00$$ENDHEX$$bertrag von cen_out_meals nach cen_out_master
//					Passiert k$$HEX1$$fc00$$ENDHEX$$nftig erst bei Matdispo in uo_packinglist_explosion.of_generate_loading_new
//
//if uf_item_list_explosion() <> 0 then
//	
//end if


//
// Schreiben und Zur$$HEX1$$fc00$$ENDHEX$$cksetzen von dsCenOutMeals
// Achtung: Verlagert nach uo_generate
//
//if uf_write_cen_out_meals() <> 0 then
//	MessageBox("Fehler beim Speichern Meals",sErrortext,StopSign!)
//	return -1
//end if

return 0

end function

public function integer uf_get_rotation (long arg_rotation_key, integer arg_rotation_type);// =============================================================================================
//
// uf_get_rotation
//
// lrotation_key ist Rotation-Key aus cen_meals
//
// arg_rotation_type = 0	Meal
// arg_rotation_type = 1	SPML
// =============================================================================================
long	lRow, lFind

uoRotation.dRotationDate 	= dGenerationDate
uoRotation.lRotationKey 		= arg_rotation_key
uoRotation.sUnit 				= sPlant

uf_trace(60,"uf_get_rotation(): init uoRotation: uoRotation.dRotationDate=" &
				+ string(uoRotation.dRotationDate) + &
				", uoRotation.lRotationKey=" + string(uoRotation.lRotationKey) + &
				", uoRotation.sUnit=" + uoRotation.sUnit )

// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Umlauf bereits im Cache liegt
// 01.07.2013 HR: Datum mit in die Suche aufnehmen
lFind = dsRotationCache.Find("nrotation_key = " + string(arg_rotation_key) + &
										" and cplant = '" + sPlant + "' and drotation_date = date('"+string(dGenerationDate, "YYYY-MM-DD")+"')",1,dsRotationCache.RowCount())
if lFind > 0 then
	// Umlauf liegt aufgel$$HEX1$$f600$$ENDHEX$$st im Cache
	uf_trace(30,"uf_get_rotation(): cache access")
	if arg_rotation_type = 0 then
		lRotationNameKey		= dsRotationCache.GetItemNumber(lFind,"nrotation_name_key")
		sRotation				= dsRotationCache.GetItemString(lFind,"crotation")
		uf_trace(60,"uf_get_rotation(): cache access: lRotationNameKey=" &
						+ string(lRotationNameKey) + ", sRotation=" + sRotation)
	else
		lSPMLRotationNameKey	= dsRotationCache.GetItemNumber(lFind,"nrotation_name_key")
		sSPMLRotation			= dsRotationCache.GetItemString(lFind,"crotation")
		uf_trace(60,"uf_get_rotation(): cache access: lSPMLRotationNameKey=" &
						+ string(lSPMLRotationNameKey) + ", sSPMLRotation=" + sSPMLRotation )
	end if
else
	// Umlauf mu$$HEX2$$df002000$$ENDHEX$$errechnet werden
	uf_trace(30,"uf_get_rotation(): database access")
	uoRotation.of_get_rotation()
	
	if uoRotation.iStatus <> 0 then
		sErrortext = "Fehler bei der Rotationspr$$HEX1$$fc00$$ENDHEX$$fung:~r~r" + uoRotation.sErrorMessage
		uf_trace(30,"uf_get_rotation(): error - " + sErrortext)
		return -1
	end if
	
	uf_trace(60,"uf_get_rotation(): uoRotation.of_get_rotation(): uoRotation.lRotationSingleKey=" &
					+ string(uoRotation.lRotationSingleKey) + &
					", uoRotation.crotation=" + string(uoRotation.sRotationText)  )

	// Cache bef$$HEX1$$fc00$$ENDHEX$$llen
	lRow = dsRotationCache.InsertRow(0)
	dsRotationCache.SetItem(lRow,"nrotation_key",			arg_rotation_key)
	dsRotationCache.SetItem(lRow,"cplant",						sPlant)
	dsRotationCache.SetItem(lRow,"nrotation_name_key",	uoRotation.lRotationSingleKey)
	dsRotationCache.SetItem(lRow,"crotation",					uoRotation.sRotationText)
	dsRotationCache.SetItem(lRow,"drotation_date", 			dGenerationDate) // 01.07.2013 HR: Datum auch bef$$HEX1$$fc00$$ENDHEX$$llen
	
	if arg_rotation_type = 0 then
		lRotationNameKey	= uoRotation.lRotationSingleKey	// dieser Umlauf ist dran
		sRotation				= uoRotation.sRotationText
	else
		lSPMLRotationNameKey	= uoRotation.lRotationSingleKey	// dieser Umlauf ist dran
		sSPMLRotation				= uoRotation.sRotationText
	end if
end if

return 0

end function

public function integer uf_compile_spml ();//=================================================================================================
//
// uf_compile_spml
//
// Hier werden die SPML berechnet
//
//=================================================================================================
/*

So funktioniert's:
==================
Die bestellten SPML (ohne Schl$$HEX1$$fc00$$ENDHEX$$sselnummer, aus cen_out_spml) werden dsSPML $$HEX1$$fc00$$ENDHEX$$bergeben.

Zum Zeitpunkt dieses Methodenaufrufs ist der f$$HEX1$$fc00$$ENDHEX$$r die Ermittlung der SPML-Definition ben$$HEX1$$f600$$ENDHEX$$tigte
nhandling_meal_key bereits ermittelt: lmasterkey

Zuerst wird die SPML-Aufl$$HEX1$$f600$$ENDHEX$$sung durchgef$$HEX1$$fc00$$ENDHEX$$hrt.

Danach wird anhand von 
	cen_spml_detail_ndeduction und cen_meals_detail_nspml_deduction
entschieden, ob f$$HEX1$$fc00$$ENDHEX$$r eine Komponente SPML ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden oder nicht.

13.01.2012 HR: Es k$$HEX1$$f600$$ENDHEX$$nnen jetzt mehrere SPML zu einer Mahlzeit zugeordnet werden (CBASE-HKG-CR-0034)

*///===============================================================================================
string		sFilter
string		sRotationFilter
long		i
long		j
long		lSPMLClassNumber
long		lFind
long		iHit
long		lReturn
long 		lRow

uf_trace(20,"Start uf_compile_spml()")

// Ist f$$HEX1$$fc00$$ENDHEX$$r das ermittelte Mahlzeitenobjekt ein SPML-Objekt hinterlegt?
lReturn = dsSPMLAssignment.Retrieve(lmasterkey, dGenerationDate, sMealControlCode)
if dsSPMLAssignment.RowCount() = 0 then
	uf_trace(20,"End uf_compile_spml() - dsSPMLAssignment is empty")
	return 0
end if

// 13.01.2012 HR: Wir laufen hier in einer Schleife, da jetzt mehrere Eintr$$HEX1$$e400$$ENDHEX$$ge m$$HEX1$$f600$$ENDHEX$$glich sind (Ersetzen von 1 durch lrow)
for lRow=1 to dsSPMLAssignment.rowcount()
	// Der Handling-Key des SPML-Objektes ist die Relevante Info um
	// herauszufinden, welche SPML-Definition gew$$HEX1$$fc00$$ENDHEX$$nscht ist

	//lHandlingSPMLKey = dsSPMLAssignment.GetItemNumber(1,"nhandling_key_spml")
	lHandlingSPMLKey = dsSPMLAssignment.GetItemNumber(lRow,"nhandling_key_spml")

	// Retrieve auf das SPML-Objekt: Holen der SPML-Definition
	uf_trace(50,"uf_compile_spml(): dsSPMLDefinition retrieve start")
	
	// 10.10.2005 Filter vor Retrieve wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen!!!
	dsSPMLDefinition.SetFilter("")
	lReturn = dsSPMLDefinition.Retrieve(lHandlingSPMLKey, dGenerationDate)
	
	uf_trace(50,"uf_compile_spml(): dsSPMLDefinition retrieve end")
	if dsSPMLDefinition.RowCount() = 0 then
		uf_trace(20,"End uf_compile_spml() - dsSPMLDefinition is empty")
//		return 0
		continue
	end if
	
	// Umlauf des SPML-Objektes ermitteln
	lSpmlRotationKey = dsSPMLDefinition.GetItemNumber(1,"cen_spml_nrotation_key")
	uf_trace(30,"uf_compile_spml(): start uf_get_rotation()")
	if uf_get_rotation(lSpmlRotationKey,1) <> 0 then	// Rotation-Key aus cen_meals
		// Fehler beim Umlauf => Daten nicht schreiben
		uf_trace(20,"End uf_compile_spml() - error uf_get_rotation()")
		return -1
	end if
	uf_trace(30,"uf_compile_spml(): end uf_get_rotation()")
	
	// Filter auf Detail-S$$HEX1$$e400$$ENDHEX$$tze, die nicht dem aktuellen Umlauf entsprechen
	sRotationFilter	= "cen_spml_detail_nrotation_name_key = " + string(lSPMLRotationNameKey)
	
	// Jetzt sind die zum Umlauf passenden Details ermittelt
	// => Abgleich mit den bestellten SPML und Speichern in cen_out_spml_detail
	for i = 1 to dsSPML.RowCount()
		// (dw_change_cen_out_spml)
		lSPMLClassNumber		= dsSPML.GetItemNumber(i,"nclass_number")
		if lSPMLClassNumber <> lClassNumber then
			// Nur die SPML f$$HEX1$$fc00$$ENDHEX$$r die aktuelle Klasse der Mahlzeiten ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			continue
		end if
		lSPMLKey					= dsSPML.GetItemNumber(i,"nspml_key")
		lSPMLMasterKey			= dsSPML.GetItemNumber(i,"nmaster_key")
		iSPMLManualInput			= dsSPML.GetItemNumber(i,"nmanual_input")
		dcSPMLMasterQuantity	= dsSPML.GetItemDecimal(i,"nquantity")
		sSPMLMasterAddText		= dsSPML.GetItemString(i,"cadd_text")
		sSPMLMasterName		= dsSPML.GetItemString(i,"cname")
		// 22.08.2005
		if isnull(sSPMLMasterName) then sSPMLMasterName = ""
		if isnull(sSPMLMasterAddText) then sSPMLMasterAddText = ""
		
		// Anwender hat entschieden, dass es sich um ein TopOff-SPML handelt
		iTopOffSPML				= dsSPML.GetItemNumber(i,"ntopoff")

		// 0 = SPML wird OnTop beladen
		// 1 = SPML muss in die Mahlzeitenberechnung einfliessen
		iOnTopSPML				= dsSPML.GetItemNumber(i,"ndeduction")	
		
		sFilter = sRotationFilter + " and cen_spml_detail_nspml_key = " + string(lSPMLKey)
		dsSPMLDefinition.SetFilter(sFilter)
		dsSPMLDefinition.Filter()
		dsSPMLDefinition.sort() // 13.11.2015 HR:Sortierung eingef$$HEX1$$fc00$$ENDHEX$$gt, das XSLs immer in der richten Reihenfolge bearbeiten wird 

		ii_spml_nlocal_sub_flight = 0 // 02.06.2014 HR: CBASE-NAM-CR-14020: Auch bei SPMLs soll eine lokale Ersetzung m$$HEX1$$f600$$ENDHEX$$glich sein
		
		// --------------------------------------------------------------------------------------------------------------------
		// 22.10.2015 HR: In BRU gibt es f$$HEX1$$fc00$$ENDHEX$$r die SPMLs jetzt auch Servicest$$HEX1$$fc00$$ENDHEX$$cklisten
		// --------------------------------------------------------------------------------------------------------------------
		is_packinglist_spml_xsl = ""

		for j = 1 to dsSPMLDefinition.RowCount()
			// Daten aus dsSPMLDefinition auslesen (dw_exp_spml_definition)
			uf_trace(30,"uf_compile_spml(): start uf_set_spml_properties_ok(" + string(j) + ")")
	
			// August 2005: Andi setzt uf_set_spml_properties(j)
			uf_set_spml_properties(j)
			uf_trace(30,"uf_compile_spml(): end uf_set_spml_properties_ok(" + string(j) + ")")
			
			// Satz nach cen_out_spml_detail schreiben
			uf_trace(30,"uf_compile_spml(): start uf_insert_cen_out_spml_detail()")
			uf_insert_cen_out_spml_detail()
			uf_trace(30,"uf_compile_spml(): end uf_insert_cen_out_spml_detail()")
		next
		
		if ii_spml_nlocal_sub_flight = 1 then
			// 02.06.2014 HR: CBASE-NAM-CR-14020: Auch bei SPMLs soll eine lokale Ersetzung m$$HEX1$$f600$$ENDHEX$$glich sein
			dsSPML.setItem(i,"nlocal_sub", 1)
		end if
	next
next
uf_trace(20,"End uf_compile_spml()")

return 0

end function

public function string uf_get_packinglist_unit (long lkey);//=================================================================================================
//
// uf_get_packinglist_unit
//
// Holt die Einheit (Unit) zur Packing List
//
//=================================================================================================
string sText

select cunit
  into :sText
  from cen_packinglists
 where npackinglist_index_key = 	:lkey
   and dvalid_from				<= :dGenerationDate
	and dvalid_to					>=	:dGenerationDate;
 
if sqlca.sqlcode <> 0 then
	return ""
else
	return sText
end if

end function

public function integer uf_start_simulation ();//=================================================================================================
//
// uf_start_simulation
//
//=================================================================================================
//
// Der Simulationslauf f$$HEX1$$fc00$$ENDHEX$$r eine Mahlzeitendefinition
//
//=================================================================================================
long		i, j, ll_calcId
integer 	li_classNumbers[], li_paxNumbers[]
String 	ls_maxClassesArray[]
s_number_per_class lstr_noPerClassesArray[]
boolean lb_paxNumberRequired, lb_versionRequired

bInSimulation	= true

//-------------------------------------------------------------------------------------
//
// Datastores Tauschen 
//
//-------------------------------------------------------------------------------------
uf_switch_datasource()

//-------------------------------------------------------------------------------------
//
// Check Properties
//
//-------------------------------------------------------------------------------------
if isnull(lSimulatePax) then
	sErrortext = "Meal Calculation got no passenger count!"
	return -1
end if

if isnull(lSimulateSPML) then
	lSimulateSPML = 0
end if

if lSimulateVersion = 0 or isnull(lSimulateVersion) then
	sErrortext = "Meal Calculation got no version boundary!"
	return -1
end if

if lHandlingMealKey = 0 or isnull(lHandlingMealKey) then
	sErrortext = "Meal Calculation got no meal key!"
	return -1
end if

if isnull(dGenerationDate) then
	dGenerationDate = today()
end if

if isnull(sPlant) then
	sErrortext = "Meal Calculation needs a plant!"
	return -1
end if

//-------------------------------------------------------------------------------------
//
// Fake der Properties 
//
//-------------------------------------------------------------------------------------
lResultKey = 4711

i = dsCenOutPax.InsertRow(0)
dsCenOutPax.SetItem(i,"nresult_key",4711)
dsCenOutPax.SetItem(i,"nclass_number",2)
// 09.09.2010 IH: $$HEX1$$c400$$ENDHEX$$nderung cclass von C auf FAKE, damit mehrklassige Berechnungsart funktioniert
// da Zugriff bei Mehrklassen-Berechnung $$HEX1$$fc00$$ENDHEX$$ber cclass erfolgt - eingegebener Wert von Klasse muss 
// dabei verwendet werden, FAKE-Eintrag wird f$$HEX1$$fc00$$ENDHEX$$r alle anderen Berechnungsarten verwendet
dsCenOutPax.SetItem(i,"cclass","FAKE")
dsCenOutPax.SetItem(i,"nversion",lSimulateVersion)
dsCenOutPax.SetItem(i,"npax",lSimulatePax)
dsCenOutPax.SetItem(i,"npax_spml",lSimulateSPML)
dsCenOutPax.SetItem(i,"cclass_name","Simulation")
dsCenOutPax.SetItem(i,"nbooking_class",1)
dsCenOutPax.SetItem(i,"ntransaction",4711)
dsCenOutPax.SetItem(i,"dtimestamp",datetime(today(),now()))
dsCenOutPax.SetItem(i,"nstatus",0)

//-------------------------------------------------------------------------------------
//
// G$$HEX1$$fc00$$ENDHEX$$ltige KVAs f$$HEX1$$fc00$$ENDHEX$$r Airline holen
//
//-------------------------------------------------------------------------------------
uf_retrieve_accounts()

//-------------------------------------------------------------------------------------
//
// Retrieve auf das Mahlzeitenobjekt
//
//-------------------------------------------------------------------------------------
dsCenMeals.Retrieve(lHandlingMealKey, dgenerationdate)

//
// 09.02.2006 Anmerkung: Dies w$$HEX1$$e400$$ENDHEX$$re die geeignete Stelle, die Ratiolist3-Ersetzung vorzunehmen
// F$$HEX1$$fc00$$ENDHEX$$r alle ncalc_id = 99 wird der nratiolist_key in cen_calc_ratio3.nratiolist_key gesucht.
// Anschl. werden die Daten ausgetauscht.
//
uf_replace_ratiolist3()

dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()
//f_print_datastore(dsCenMeals)

if dsCenMeals.RowCount() > 0 then
	//
	// Umlauf holen (einmal je Mahlzeitendefinition)
	//
	lRotation_key = dsCenMeals.GetItemNumber(1,"cen_meals_nrotation_key")
	if uf_get_rotation(lRotation_key,0) <> 0 then	// Rotation-Key aus cen_meals
		//
		// Fehler beim Umlauf => Daten nicht schreiben
		//
		return -1
	end if
end if
//
// 17.03.2005: Umlauf filtern
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

// 09.09.2010 IH: Ermittlung der maximalen Klassen f$$HEX1$$fc00$$ENDHEX$$r die Eingabe der Anzahl pro Klasse sp$$HEX1$$e400$$ENDHEX$$ter
uf_get_max_classes(ls_maxClassesArray, lb_paxNumberRequired, lb_versionRequired)

// 09.09.2010 IH: Eingabe der Anzahl pro Klasse
uf_ask4number_per_class(ls_maxClassesArray, lstr_noPerClassesArray, lb_paxNumberRequired, lb_versionRequired)

// --------------------------------------------------------------------------------------------------------------------
// 04.09.2015 HR: CBASE-DE-CR-2013-005 Servicest$$HEX1$$fc00$$ENDHEX$$ckliste leeren
// --------------------------------------------------------------------------------------------------------------------
is_packinglist_xsl = ""

for j = 1 to dsCenMeals.RowCount()
	if dsCenMeals.GetItemNumber(j,"nrotation_name_key") <> lRotationNameKey then
		//
		// Datensatz ist f$$HEX1$$fc00$$ENDHEX$$r anderen Umlauf bestimmt
		//
		continue
	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 04.09.2015 HR: CBASE-DE-CR-2013-005 Servicest$$HEX1$$fc00$$ENDHEX$$ckliste leeren
	// --------------------------------------------------------------------------------------------------------------------
	if dsCenMeals.GetItemNumber(j,"sys_packinglist_kinds_nxsl")= 1 then
		is_packinglist_xsl = dsCenMeals.GetItemString(j,"cen_packinglist_index_cpackinglist")
	end if
	
	// 08.06.2010 HR: BOB-Kennzeichen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	ii_Bob=0
	
	// 09.09.2010 IH: Setzen der Anzahl pro Klasse als Eintrag in die dsCenOutPax f$$HEX1$$fc00$$ENDHEX$$r 
	//					   die richtige klassenbezogene Berechnung in uf_calculate() sp$$HEX1$$e400$$ENDHEX$$ter
	// CalcID hier selbst holen, da diese erst sp$$HEX1$$e400$$ENDHEX$$ter in uf_set_meal_properties() von uf_calculate() gesetzt werden	
	ll_calcId = dsCenMeals.GetItemNumber(j,"cen_meals_detail_ncalc_id")
	//	if il_MIN_CALC_ID_MULTI_CLASSES <= ll_calcId and ll_calcId <= il_MAX_CALC_ID_MULTI_CLASSES then 
	// Um die hinzu gekommenen Berechnungsarten 84-89 erweitert - TBR 110130
		if ( il_MIN_CALC_ID_MULTI_CLASSES <= 	ll_calcId 	and 	ll_calcId 	<= 	il_MAX_CALC_ID_MULTI_CLASSES ) 	OR &
		   ( 84 										<= 	ll_calcId 	and 	ll_calcId 	<= 	89 ) 											THEN
			
			uf_add_number_for_classes(ll_calcId, lstr_noPerClassesArray)
	end if
	
	//
	// Satz berechnen
	//
	if uf_calculate(j) <> 0 then
		//
		// Fehler bei Berechnung der Mahlzeit, Daten nicht schreiben
		//
		return -1
	end if
	//
	// Kurz-Von-An setzen (da uf_compile nicht aufgerufen wird)
	//
	lAccountKey				= dsCenMeals.GetItemNumber(j,"cen_meals_detail_naccount_key")
	lDefaultAccountKey 	= dsCenMeals.GetItemNumber(j,"ndefault_account_key")
	
	if isnull(lAccountKey) or lAccountKey = 0 then
		//
		// Falls kein KVA auf Zeile gesetzt, dann Default verwenden
		//
		lAccountKey = lDefaultAccountKey
	end if
	//
	// $$HEX1$$dc00$$ENDHEX$$bertrag nach cen_out_meals (dsCenOutMeals)
	//
	uf_insert_cen_out_meals()
next

dsCenMeals.SetFilter("")
dsCenMeals.Filter()

return 0

end function

public function integer uf_insert_cen_out_spml_detail ();//=================================================================================================
//
// uf_insert_cen_out_spml_detail
//
// $$HEX1$$dc00$$ENDHEX$$bertrag der Mahlzeitendefinitions-Daten in die Ergebnismenge
//
//=================================================================================================
//
// 26.08.2004	St$$HEX1$$fc00$$ENDHEX$$cklistentyp, Detail-Keys auch nach cen_out_spml_detail
// 20.01.2012 HR: Handlingkey der Mahlzeit beim SPML speichen
// 16.04.2012 mnu: bestimmen customer_pl erweitert
//
//=================================================================================================
long 		ll_Ret
long		i
long 		lRow
long		lSequence
datetime	dtTimeStamp
string	sNewMealControlCode
String	ls_PL, ls_Text

dtTimeStamp = datetime(today(),now())

lSequence = f_Sequence("seq_cen_out_spml_detail", sqlca)
// -----------------------------------------
// liefert -1 bei Fehler
// -----------------------------------------
If lSequence = -1 Then
	return -1
end if

lRow = dsSPMLDetail.InsertRow(0)

dsSPMLDetail.SetItem(lRow,"ndetail_key",					lSequence)
dsSPMLDetail.SetItem(lRow,"ntransaction",					lTransaction)
dsSPMLDetail.SetItem(lRow,"nmaster_key",					lSPMLMasterKey)	// Key zu cen_out_spml

// 20.01.2012 HR: Handlingkey der Mahlzeit beim SPML speichen
//dsSPMLDetail.SetItem(lRow,"nhandling_key",				lSPMLHandlingKey)
dsSPMLDetail.SetItem(lRow,"nhandling_key",				lmasterkey) 

dsSPMLDetail.SetItem(lRow,"nhandling_spml_key",			lHandlingSPMLKey)
dsSPMLDetail.SetItem(lRow,"chandling_text",				sSPMLHandlingText)
dsSPMLDetail.SetItem(lRow,"nrotation_key",				lSpmlRotationKey)
dsSPMLDetail.SetItem(lRow,"nrotation_name_key",			lSPMLRotationNameKey)
dsSPMLDetail.SetItem(lRow,"crotation",						sSPMLRotation)
dsSPMLDetail.SetItem(lRow,"nprio",							lSPMLPrio)
dsSPMLDetail.SetItem(lRow,"npackinglist_index_key",	lSPMLPLIndexKey)
dsSPMLDetail.SetItem(lRow,"cpackinglist",					sSPMLPackingList)
dsSPMLDetail.SetItem(lRow,"cunit",							sSPMLUnit)
dsSPMLDetail.SetItem(lRow,"cproduction_text",			sSPMLProductionText)
dsSPMLDetail.SetItem(lRow,"naccount_key",					lSPMLAccountKey)
dsSPMLDetail.SetItem(lRow,"caccount",						sSPMLAccount)
dsSPMLDetail.SetItem(lRow,"nbilling_status",				iSPMLBillingStatus)
dsSPMLDetail.SetItem(lRow,"nac_transfer",					iSPMLACTransfer)
dsSPMLDetail.SetItem(lRow,"nquantity",						dcSPMLQuantity)
dsSPMLDetail.SetItem(lRow,"nquantity_old",				dcSPMLQuantity_old)
dsSPMLDetail.SetItem(lRow,"nmanual_input",				iSPMLManualInput)
dsSPMLDetail.SetItem(lRow,"dtimestamp",					dtTimeStamp)
dsSPMLDetail.SetItem(lRow,"nstatus",						iStatus)
dsSPMLDetail.SetItem(lRow,"cdescription",					"")
dsSPMLDetail.SetItem(lRow,"cadditional_account",		sSPMLAddAccountCode)
dsSPMLDetail.SetItem(lRow,"npltype_key",					lSPMLPLTypeKey)
dsSPMLDetail.SetItem(lRow,"nposting_type",				1)	// Kartenart "Belastung"

// MCC mit aktuellem Leg
if len(sMealControlCode) < 4 then
	sNewMealControlCode = string(lLegNumber) + sMealControlCode
	sNewMealControlCode = mid(sNewMealControlCode,1,4)
else
	sNewMealControlCode = sMealControlCode
	sNewMealControlCode = mid(sNewMealControlCode,1,4)
end if
dsSPMLDetail.SetItem(lRow,"cmeal_control_code",		sNewMealControlCode)

// Neu:
// Abh$$HEX1$$e400$$ENDHEX$$ngig vom Generierungsstatus wird die Anzahl Mahlzeiten gesetzt
// Und weil nicht innerhalb jedes Status' eine Mahlzeitenberechnung stattfindet,
// mu$$HEX2$$df002000$$ENDHEX$$von iStatus bis Status 7 alles gesetzt werden!
if iStatus > 0 and iStatus < 8 then
	for i = iStatus to 7 
		dsSPMLDetail.SetItem(lRow,"nquantity" + string(i),dcSPMLQuantity)
	next
end if

//
// 26.08.2004 Diverse Keys
//
dsSPMLDetail.SetItem(lRow,"npackinglist_detail_key",	lSPMLPLDetailKey)
dsSPMLDetail.SetItem(lRow,"ctext",							sSPMLPackinglistText)
dsSPMLDetail.SetItem(lRow,"npl_kind_key",					lSPMLPLKindKey)
dsSPMLDetail.SetItem(lRow,"npackinglist_key",			lSPMLPackinglistKey)

dsSPMLDetail.SetItem(lRow,"ndistribute",					iSPMLDistribute)


// ----------------------------------------------------------------------------------------
// customer_pl ccustomer_text

//SELECT	CEN_PACKINGLISTS.CCUSTOMER_PL,   
//			CEN_PACKINGLISTS.CCUSTOMER_TEXT
//INTO		:ls_PL, :ls_Text
//FROM		CEN_PACKINGLISTS,   
//			CEN_PACKINGLIST_INDEX  
//WHERE		CEN_PACKINGLIST_INDEX.NPACKINGLIST_INDEX_KEY = CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY
//AND		CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY = :lSPMLPLIndexKey
//AND		CEN_PACKINGLISTS.NPACKINGLIST_DETAIL_KEY = :lSPMLPLDetailKey;

// 16.04.2012 mnu: funktion statt direktem select
ll_Ret = uf_get_customer_id(lSPMLPLIndexKey, lSPMLPLDetailKey, lAirlineKey, ls_PL, ls_Text, true)

dsSPMLDetail.SetItem(lRow,"ccustomer_pl", ls_PL)
dsSPMLDetail.SetItem(lRow,"ccustomer_text", ls_Text)
// ----------------------------------------------------------------------------------------
// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
// ----------------------------------------------------------------------------------------
If il_FillEmptyCustomerPL = 1 Then
	If IsNULL(ls_PL) OR Trim(ls_PL) = "" Then
		dsSPMLDetail.SetItem(lRow,"ccustomer_pl", sSPMLPackingList)
	End If
	If IsNULL(ls_Text) OR Trim(ls_Text) = "" Then
		dsSPMLDetail.SetItem(lRow,"ccustomer_text", sSPMLPackinglistText)
	End If
End If
// ----------------------------------------------------------------------------------------
	 
// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Falls es sich um eine Servicest$$HEX1$$fc00$$ENDHEX$$ckliste handelt diese merken
// --------------------------------------------------------------------------------------------------------------------
// 04.09.2015 HR: SPMLs haben keine Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
//if isnull(is_packinglist_xsl) then is_packinglist_xsl = ""
//dsSPMLDetail.SetItem(lRow,"cpackinglist_xsl", is_packinglist_xsl)
// 22.10.2015 HR: In BRU gibt es f$$HEX1$$fc00$$ENDHEX$$r die SPMLs jetzt auch Servicest$$HEX1$$fc00$$ENDHEX$$cklisten
dsSPMLDetail.SetItem(lRow,"cpackinglist_xsl", is_packinglist_spml_xsl)

// --------------------------------------------------------------------------------------------------------------------
// 02.06.2014 HR: CBASE-NAM-CR-14020: Auch bei SPMLs soll eine lokale Ersetzung m$$HEX1$$f600$$ENDHEX$$glich sein
// --------------------------------------------------------------------------------------------------------------------
dsSPMLDetail.SetItem(lRow,"nlocal_sub", ii_spml_nlocal_sub)
dsSPMLDetail.SetItem(lRow,"npl_index_key_ori", il_spml_npl_index_key_ori)
dsSPMLDetail.SetItem(lRow,"cpackinglist_ori", is_spml_cpackinglist_ori)
dsSPMLDetail.SetItem(lRow,"ctext_ori", is_spml_ctext_ori)
 
 if ii_spml_partial_substitution = 1 then
	// --------------------------------------------------------------------------------------------------------------------
	// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling: Bei der teilweisen Ersetzung dupplizieren wir die Zeile
	// --------------------------------------------------------------------------------------------------------------------

	lSequence = f_Sequence("seq_cen_out_spml_detail", sqlca)
	// -----------------------------------------
	// liefert -1 bei Fehler
	// -----------------------------------------
	If lSequence = -1 Then
		return -1
	end if

	dsSPMLDetail.rowscopy( lRow, lRow, PRIMARY!, dsSPMLDetail, lRow + 1, PRIMARY!)
	dsSPMLDetail.SetItem(lRow +1, "ndetail_key",	lSequence)	
	
	dsSPMLDetail.SetItem(lRow +1,"npl_index_key"	, il_spml_npl_index_key_ori)
	dsSPMLDetail.SetItem(lRow +1,"cpackinglist"		, is_spml_cpackinglist_ori)
	dsSPMLDetail.SetItem(lRow +1,"ctext"				, is_spml_ctext_ori)
	dsSPMLDetail.SetItem(lRow +1,"nquantity"			,0)
	dsSPMLDetail.SetItem(lRow +1,"nquantity_old"		,0)
	
end if
 
return 0

end function

public function integer uf_set_meal_properties (long lrow);//=================================================================================================
//
// uf_set_meal_properties
//
// Setzen aller Properties mit den Daten aus dem Datastore dsCenMeals
//
//=================================================================================================


//=================================================================================================
//
// Infos aus Mahlzeitendefinition holen
//
//=================================================================================================
lMasterKey					= dsCenMeals.GetItemNumber(lRow,"cen_meals_nhandling_meal_key")

lPackinglistIndexKey		= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_npackinglist_index_key")

lClassNumber				= dsCenMeals.GetItemNumber(lRow,"cen_meals_nclass_number")
lCalcID		 				= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_ncalc_id")
lCalcDetailKey				= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_ncalc_detail_key")
lHandlingKey				= dsCenMeals.GetItemNumber(lRow,"cen_meals_nhandling_key")

lReserveQuantity			= dsCenMeals.GetItemNumber(lRow,"cen_meals_nreserve_quantity")
lTopOffQuantity				= dsCenMeals.GetItemNumber(lRow,"cen_meals_ntopoff_quantity")
iReserveType				= dsCenMeals.GetItemNumber(lRow,"cen_meals_nreserve_type")
iTopOffType					= dsCenMeals.GetItemNumber(lRow,"cen_meals_ntopoff_type")

iModuleType				= dsCenMeals.GetItemNumber(lRow,"cen_meals_nmodule_type")
//iAsk4Passenger				= dsCenMeals.GetItemNumber(lRow,"cen_meals_nask4passenger")
iPassengerGroup			= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_npassenger_group")
//sQuestionText				= dsCenMeals.GetItemString(lRow,"cen_meals_cquestion_text")
//iPlanningPercent			= dsCenMeals.GetItemNumber(lRow,"cen_meals_nplanning_percent")

lHandlingDetailKey			= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nhandling_detail_key")
lMealsDetailPrio			= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nprio")
sMealControlCode			= dsCenMeals.GetItemString(lRow,"cen_meals_detail_cmeal_control_code")
sProductionText			= dsCenMeals.GetItemString(lRow,"cen_meals_detail_cproduction_text")

lHandlingMealKey			= dsCenMeals.GetItemNumber(lRow, "cen_meals_nhandling_meal_key")

// TBR 01.10.2010: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r "Japan-Tool"
ii_nservice					= dsCenMeals.GetItemNumber(lRow,"cen_meals_nservice")
ii_nethnic					= dsCenMeals.GetItemNumber(lRow,"cen_meals_nethnic")

// --------------------------------------------------------------------------------------------------------------------
// 21.06.2010 HR: IMView 262: Produktionstext durch SL-Produktionstext ersetzen falls eingestellt
// --------------------------------------------------------------------------------------------------------------------
ii_ReplaceProdText 		=  dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nreplacetext")
if  ii_ReplaceProdText =1 then 
	sProductionText		= dsCenMeals.GetItemString(lRow,"cen_packinglists_ctext_short")
end if

iComponentGroup			= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_ncomponent_group")

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
string sFind

if ids_cen_meals_det_deduction.find("nhandling_detail_key = "+string(lHandlingDetailKey), 1, ids_cen_meals_det_deduction.rowcount())=0 then
	datastore lds 
	
	lds = create datastore
	lds.dataobject = ids_cen_meals_det_deduction.dataobject
	lds.settransobject(SQLCA)
	lds.retrieve(lHandlingDetailKey, lResultKey, dGenerationDate) // 17.06.2016 HR:
	
	if lds.rowcount()>0 then
		lds.rowscopy(1, lds.rowcount(), primary!, ids_cen_meals_det_deduction, 1, primary!)
	end if
	
	destroy lds
end if

// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: CR CBASE-CCS-CR-2016-009: Abzug im Objekt nur noch wenn Schalter an
// --------------------------------------------------------------------------------------------------------------------
if icmc_nreduce = 1 then
	lForeignObject				= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nforeign_object")
	if not isnull(lForeignObject) then
		lForeignObject 			= uf_get_foreign_object(lForeignObject)
		
	end if
	iForeignGroup				= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nforeign_group")
else
	setnull(lForeignObject)
	setnull(iForeignGroup)
end if
	
if not isnull(lForeignObject) then
	// --------------------------------------------------------------------------------------------------------------------
	// 07.08.2015 HR: CBASE-DE-CR-2015-054 Wir schauen, ob wir f$$HEX1$$fc00$$ENDHEX$$r diese Zeile schon was retrieved haben,
	//                         ansonsten legen wir eine Zeile an
	// --------------------------------------------------------------------------------------------------------------------

	sFind = "nhandling_detail_key = "+string(lHandlingDetailKey)
	sFind += "and nresult_key = " + string(lResultKey)
	
	if ids_cen_meals_det_deduction.find(sFind, 1, ids_cen_meals_det_deduction.rowcount())=0 then
		ids_cen_meals_det_deduction.insertrow(1)
		
		ids_cen_meals_det_deduction.setitem(1, "nhandling_detail_key", lHandlingDetailKey)
		ids_cen_meals_det_deduction.setitem(1, "nresult_key", lResultKey)
		ids_cen_meals_det_deduction.setitem(1, "nforeign_object", lForeignObject)
		ids_cen_meals_det_deduction.setitem(1, "nforeign_group", iForeignGroup)
		ids_cen_meals_det_deduction.setitem(1, "nclass_number", lClassNumber)
		ids_cen_meals_det_deduction.setitem(1, "cen_handling_ctext", "TEST")
		ids_cen_meals_det_deduction.setitem(1, "nhandling_meal_key", lHandlingMealKey)
	end if
end if

sRemark						= dsCenMeals.GetItemString(lRow,"cen_meals_detail_cremark")
lAccountKey					= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_naccount_key")
lDefaultAccountKey		= dsCenMeals.GetItemNumber(lRow,"ndefault_account_key")
iBillingStatus				= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nbilling_status")
iPercentage					= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_npercentage")
dcValue						= dsCenMeals.GetItemDecimal(lRow,"cen_meals_detail_nvalue")
lMaxValue					= dsCenMeals.GetItemDecimal(lRow,"cen_meals_detail_nmax_value")
sMultiClasses				= dsCenMeals.GetItemString(lRow,"cen_meals_detail_cclasses")
iSPMLDeduction			= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nspml_deduction")

iACTransfer					= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nac_transfer")
//ersetzt:sUnit					= uf_get_packinglist_unit(lPackinglistIndexKey)
sUnit							= dsCenMeals.GetItemString(lRow,"cen_packinglists_cunit")
sAreaHost					= dsCenMeals.GetItemString(lRow,"cen_meals_detail_carea_host")
sEffortHost					= dsCenMeals.GetItemString(lRow,"cen_meals_detail_ceffort_host")
sAdditionalAccountCode	= 	dsCenMeals.GetItemString(lRow,"cen_meals_detail_cadditional_account")	
//Neu f$$HEX1$$fc00$$ENDHEX$$r Unterbeladung
lMopDetailKey				= 	dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nmop_detail_key")	

// Neue Properties nach Performance-Optimierung vom 12.08.2004
sHandlingText				= dsCenMeals.GetItemString(lRow,"cen_handling_ctext")
sPackinglist					= dsCenMeals.GetItemString(lRow,"cen_packinglist_index_cpackinglist")
lPLKindKey					= dsCenMeals.GetItemNumber(lRow,"cen_packinglist_index_npl_kind_key")
lPackinglistKey				= dsCenMeals.GetItemNumber(lRow,"cen_packinglists_npackinglist_key")
lPLDetailKey					= dsCenMeals.GetItemNumber(lRow,"cen_packinglists_npackinglist_detail_key")
sPackinglistText			= dsCenMeals.GetItemString(lRow,"cen_packinglists_ctext")

iDistribute					= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_ndistribute")
//wird zun$$HEX1$$e400$$ENDHEX$$chst beibehalten:lPLTypeKey			= uf_get_pl_type_key(lPackinglistIndexKey)
lPLTypeKey					= uf_get_pl_type_key(lPackinglistIndexKey,lPLDetailKey)	// entsch$$HEX1$$e400$$ENDHEX$$rft!

//=================================================================================================
// Catering Delivery Note und Controlling Schalter
//=================================================================================================
lControllingFlag				= dsCenMeals.GetItemNumber(lRow,"ncontrolling")
lDeliveryNoteFlag			= dsCenMeals.GetItemNumber(lRow,"ndelivery_note")
sDeliveryNoteText			= dsCenMeals.GetItemString(lRow,"cdelivery_text")
sDeliveryNoteSNR			= dsCenMeals.GetItemString(lRow,"cdelivery_snr")

if isnull(lControllingFlag)  	Then lControllingFlag 		= 0
if isnull(lDeliveryNoteFlag) 	Then lDeliveryNoteFlag 	= 0
if isnull(sDeliveryNoteText) 	Then sDeliveryNoteText 	= ""
if isnull(sDeliveryNoteSNR)  	Then sDeliveryNoteSNR 	= ""

// --------------------------------------------------------------------------------------------------------------------
// 25.09.2012 HR: $$HEX1$$c400$$ENDHEX$$nderungen durch Lokalen Ersetzungen (CBASE-NAM-CR-11009)
// --------------------------------------------------------------------------------------------------------------------
il_nlocal_sub 				= dsCenMeals.GetItemNumber(lRow,"nlocal_sub")
il_npl_index_key_ori 		= dsCenMeals.GetItemNumber(lRow,"npl_index_key_ori")
is_cpackinglist_ori 			= dsCenMeals.GetItemString(lRow,"cpackinglist_ori")
is_ctext_ori 					= dsCenMeals.GetItemString(lRow,"ctext_ori")
il_ncalc_id_ori 				= dsCenMeals.GetItemNumber(lRow,"ncalc_id_ori")
il_ncalc_detail_key_ori 	= dsCenMeals.GetItemNumber(lRow,"ncalc_detail_key_ori")
il_npercentage_ori 		= dsCenMeals.GetItemNumber(lRow,"npercentage_ori")
il_nvalue_ori 				= dsCenMeals.GetItemNumber(lRow,"nvalue_ori")
il_nmax_value_ori 			= dsCenMeals.GetItemNumber(lRow,"nmax_value_ori")

// --------------------------------------------------------------------------------------------------------------------
// 20.09.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r die 3 Berechungsarten 101 - 103 soll es neben Max auch einen MinWert geben (CBASE-CR-NAM-12085)
// --------------------------------------------------------------------------------------------------------------------
lMinValue 					= dsCenMeals.GetItemNumber(lRow,"cen_meals_detail_nmin_value")

// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: CCS-CR-1541: Feld $$HEX1$$fc00$$ENDHEX$$bernehemen
// --------------------------------------------------------------------------------------------------------------------
is_sap_code				= dsCenMeals.GetItemString(lRow,"cen_meals_csap_code")

//=================================================================================================
//
// Diese Infos k$$HEX1$$f600$$ENDHEX$$nnen sp$$HEX1$$e400$$ENDHEX$$ter mit Infos aus bereits aufgel$$HEX1$$f600$$ENDHEX$$sten Mahlzeiten $$HEX1$$fc00$$ENDHEX$$berschrieben werden.
//
//=================================================================================================

if lMasterKey <> lMasterKeyOld and lComponentGroupOld <> iComponentGroup then
	//
	// Tempor$$HEX1$$e400$$ENDHEX$$re Infos l$$HEX1$$f600$$ENDHEX$$schen bei Gruppenwechsel
	//
	lOverloadSet			= 0	// $$HEX1$$dc00$$ENDHEX$$berbeladung wurde errechnet
	lOverloadSet_ver		= 0	//30.11.2012, Gunnar Brosch
	lOverloadInRow		= 0	// Verweis auf Mahlzeit mit $$HEX1$$dc00$$ENDHEX$$berbeladung
	lOverloadGet			= 0	// $$HEX1$$dc00$$ENDHEX$$berbeladung liegt vor
	lMasterKeyOld			= lMasterKey
	lComponentGroupOld	= iComponentGroup
	iManualInput			= 0
end if




return 0

end function

public function long uf_get_pl_type_key (long arg_key, long arg_detailkey);//=================================================================================================
//
// uf_get_pl_type_key
//
// Holt den St$$HEX1$$fc00$$ENDHEX$$cklistentyp zur Speicherung in cen_out_meals
//
// 25.02.2005: Out of order!
//
//-------------------------------------------------------------------------------------------------
//
// Eine St$$HEX1$$fc00$$ENDHEX$$ckliste kann zwar mehrere St$$HEX1$$fc00$$ENDHEX$$cklistentypen haben, 
// eine Mahlzeitenst$$HEX1$$fc00$$ENDHEX$$ckliste darf aber nur einem Typen zugeordnet sein.
//
// Vorsichtshalber nehmen wir das MIN
//
//=================================================================================================
long	lPL_Type_Key
long	lFind

return 0

//lFind = dsPLTypes.Find(	"npackinglist_index_key = " + string(arg_key) + &
//								" and npackinglist_detail_key = " + string(arg_detailkey), &
//								1,dsPLTypes.RowCount())
//if lFind > 0 then
//	lPL_Type_Key = dsPLTypes.GetItemNumber(lFind,"npltype_key")
//	return lPL_Type_Key
//else
//	return 0
//end if


end function

public function integer uf_insert_cen_out_meals ();/*
* Objekt : uo_meal_calculation
* Methode: uf_insert_cen_out_meals (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 17.06.2009
*
* Argument(e):
* none
*
* Beschreibung:		$$HEX1$$dc00$$ENDHEX$$bertrag der Mahlzeitendefinitions-Daten in die Ergebnismenge
*
* Aenderungshistorie:
* Version 	Wer				Wann			Was und warum
* 1.0			<unknown>
* 1.0 			O.Hoefer			17.06.2009	Erweiterung um Kundenst$$HEX1$$fc00$$ENDHEX$$cklistennummer
* 1.1			HR					08.06.2010	Sichern der BOB-Werte
* 1.2			M.N$$HEX1$$fc00$$ENDHEX$$ndel			16.04.2012	bestimmen customer_pl erweitert
* 1.3 			O.Hoefer			12.06.2012	Bei BOB fixed Qty nicht % & min speichern
* 1.4            G. Brosch		23.11.2012	Quantity Version eingebaut
* Return: integer
*
*/

long 		ll_Ret
long 		lRow
long		i
long		lSequence
datetime	dtTimeStamp
string	sNewMealControlCode

string	sCheckCoverText
integer	iSetManualProcessing = 0

dtTimeStamp = datetime(today(),now())

//
// 17.10.05	Sequence nur wenn Schalter gesetzt
//
if iUseSequence = 1 then
	//
	// 28.10.05 Wenn in Simulation, dann keine Sequence verwenden
	//				Achtung: Auch bei Neuaufnahme einer Komponente wird Simulation 
	//				gestartet, es wird allerdings beim Abspeichern eine neue Sequence
	//				gesetzt
	//
	if bInSimulation	= false then
		lSequence = f_Sequence("seq_cen_out_meals", sqlca)
		// -----------------------------------------
		// liefert -1 bei Fehler
		// -----------------------------------------
		If lSequence = -1 Then
			return -2
		end if
	end if
end if
lRow = dsCenOutMeals.InsertRow(0)

dsCenOutMeals.SetItem(lRow,"ndetail_key",					lSequence)
dsCenOutMeals.SetItem(lRow,"nresult_key",					lResultKey)
dsCenOutMeals.SetItem(lRow,"nhandling_detail_key",		lHandlingDetailKey)
dsCenOutMeals.SetItem(lRow,"ntransaction",				lTransaction)
dsCenOutMeals.SetItem(lRow,"nhandling_key",				lHandlingKey)
//ersetzt: dsCenOutMeals.SetItem(lRow,"chandling_text",				uf_get_handling_text(lHandlingKey))
dsCenOutMeals.SetItem(lRow,"chandling_text",				sHandlingText)
dsCenOutMeals.SetItem(lRow,"ncover_key",					lHandlingCoverKey)
//
// Falls Komponente manuell aufgenommen wurde, dann ist lHandlingCoverKey = 0
//
//ersetzt:
//if lHandlingCoverKey = 0 then
//	sCheckCoverText = "n/a"
//else	
//	sCheckCoverText = uf_get_handling_text(lHandlingCoverKey)
//end if

//
// Feld ist not null und muss bei manuell aufgenommenen Mahlzeiten gesetzt werden!
//
if lHandlingCoverKey = 0 then
	sHandlingCoverText = "n/a"
end if
dsCenOutMeals.SetItem(lRow,"ccover_text",					sHandlingCoverText) // sCheckCoverText)
// Die Sortierung aus der Beladedefinition
If lHandlingSort <= 0 or isnull(lHandlingSort) Then lHandlingSort = 1

dsCenOutMeals.SetItem(lRow,"ncover_prio",					(lHandlingSort * 1000) + lCoverPrio)
dsCenOutMeals.SetItem(lRow,"nhandling_meal_key",		lMasterKey)
dsCenOutMeals.SetItem(lRow,"nclass_number",				lClassNumber)
dsCenOutMeals.SetItem(lRow,"cclass",						sClass)
dsCenOutMeals.SetItem(lRow,"nreserve_quantity",			lReserveQuantity)
dsCenOutMeals.SetItem(lRow,"nreserve_type",				iReserveType)
dsCenOutMeals.SetItem(lRow,"ntopoff_quantity",			lTopOffQuantity)
dsCenOutMeals.SetItem(lRow,"ntopoff_type",				iTopOffType)
dsCenOutMeals.SetItem(lRow,"nrotation_key",				lRotation_key)
dsCenOutMeals.SetItem(lRow,"nrotation_name_key",		lRotationNameKey)
dsCenOutMeals.SetItem(lRow,"crotation",					sRotation)
dsCenOutMeals.SetItem(lRow,"nmodule_type",				iModuleType)
dsCenOutMeals.SetItem(lRow,"nprio",							lMealsDetailPrio)
dsCenOutMeals.SetItem(lRow,"npackinglist_index_key",	lPackinglistIndexKey)
//ersetzt: dsCenOutMeals.SetItem(lRow,"cpackinglist",				uf_get_packinglist(lPackinglistIndexKey))
dsCenOutMeals.SetItem(lRow,"cpackinglist",				sPackinglist)

//HR 07.07.2008 CBASE-UK-EM-4402
//Falls die Variable sProductionTextReplace gef$$HEX1$$fc00$$ENDHEX$$llt ist diesen Text als Produktiontext eintragen, sonst den normalen Produktionstext
// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r CR CBASE-CCS-CR-2016-009
// --------------------------------------------------------------------------------------------------------------------
string ls_prodtext
if sProductionTextReplace<>"" then
	ls_prodtext = sProductionTextReplace
else
	// 25.06.2014 HR: Falls wir keinen Produktionstext haben, dann nehmen wir den SL-Text
	if isnull(sProductionText) then
		ls_prodtext = sPackinglistText
	else
		ls_prodtext = sProductionText
	end if
end if 

if icmc_cprefix > " " then
	// Wenn ein Prefix eingegeben, dann stellen wir diesen voran und schneiden auf 40 Zeichen ab
	ls_prodtext = left(icmc_cprefix + ls_prodtext, 40)
end if

dsCenOutMeals.SetItem(lRow,"cproduction_text", ls_prodtext)

dsCenOutMeals.SetItem(lRow,"ncomponent_group",			iComponentGroup)
dsCenOutMeals.SetItem(lRow,"nforeign_object",			lForeignObject)
dsCenOutMeals.SetItem(lRow,"nforeign_group",				iForeignGroup)
dsCenOutMeals.SetItem(lRow,"nask4passenger",				iAsk4Passenger)
dsCenOutMeals.SetItem(lRow,"cquestion_text",				sQuestionText)
dsCenOutMeals.SetItem(lRow,"npassenger_group",			iPassengerGroup)
dsCenOutMeals.SetItem(lRow,"cremark",						sRemark)
dsCenOutMeals.SetItem(lRow,"naccount_key",				lAccountKey)
//uf_get_account_code wurde umgebaut
dsCenOutMeals.SetItem(lRow,"caccount",						uf_get_account_code(lAccountKey))
dsCenOutMeals.SetItem(lRow,"nbilling_status",			iBillingStatus)
dsCenOutMeals.SetItem(lRow,"ncalc_id",						lCalcID)
dsCenOutMeals.SetItem(lRow,"ncalc_detail_key",			lCalcDetailKey)
dsCenOutMeals.SetItem(lRow,"npercentage",					iPercentage)
dsCenOutMeals.SetItem(lRow,"nvalue",						dcValue)
dsCenOutMeals.SetItem(lRow,"cclasses",						sMultiClasses)
dsCenOutMeals.SetItem(lRow,"nspml_deduction",			iSPMLDeduction)
dsCenOutMeals.SetItem(lRow,"nac_transfer",				iACTransfer)
dsCenOutMeals.SetItem(lRow,"nquantity",					dcQuantity)

dsCenOutMeals.SetItem(lRow,"nquantity_version",			idc_quantity_ver);		//23.11.12, Gunnar Brosch, Quantity Version

dsCenOutMeals.SetItem(lRow,"nquantity_old",				dcOldQuantity)
dsCenOutMeals.SetItem(lRow,"nmanual_input",				iManualInput)			// jmd. hat die Auftragsmenge manuell $$HEX1$$fc00$$ENDHEX$$berschrieben
dsCenOutMeals.SetItem(lRow,"nmanual_processing",		iSetManualProcessing)// jmd. hat manuell die Mahlzeitenkomponente aufgenommen
dsCenOutMeals.SetItem(lRow,"dtimestamp",					dtTimeStamp)
dsCenOutMeals.SetItem(lRow,"nstatus",						iStatus)
dsCenOutMeals.SetItem(lRow,"cdescription","")
dsCenOutMeals.SetItem(lRow,"cunit",							sUnit)
dsCenOutMeals.SetItem(lRow,"nquantity_group",			lQuantityGroup)
dsCenOutMeals.SetItem(lRow,"ncalc_basis",					lCalcBasis)	// Berechnungsgrundlage speichern
dsCenOutMeals.SetItem(lRow,"npax",							lPax)
dsCenOutMeals.SetItem(lRow,"npltype_key",					lPLTypeKey)	// St$$HEX1$$fc00$$ENDHEX$$cklistentyp
dsCenOutMeals.SetItem(lRow,"nposting_type",				1)	// Kartenart "Belastung"
//
// npax_manual
// vorher: lPaxManual, jetzt: lPax
// Hier sollte eine manuell eingegebene Pax-Zahl zur Berechnung verwendet werden.
// Das f$$HEX1$$fc00$$ENDHEX$$hrt aber dazu, dass auch bei der manuellen $$HEX1$$c400$$ENDHEX$$nderung einer Reservemenge 
// nie wieder eine aktuelle Pax-Zahl, sondern immer die manuelle Pax-Zahl als
// Berechnungsgrundlage f$$HEX1$$fc00$$ENDHEX$$r sp$$HEX1$$e400$$ENDHEX$$tere Berechnungen herangezogen wird.
//
// 18.05.2004: dsCenOutMeals.SetItem(lRow,"npax_manual",					lPax)	
dsCenOutMeals.SetItem(lRow,"npax_manual",					lPaxManual)	

dsCenOutMeals.SetItem(lRow,"noverload",lOverloadSet)		// $$HEX1$$dc00$$ENDHEX$$berbeladung aus Prozentberechnung, wird nur temp. im Datastore gespeichert
dsCenOutMeals.SetItem(lRow,"noverload_version",lOverloadSet_ver)	//30.11.2012, Gunnar Brosch

// --------------------------------------------------------------------------------------------------------------------
// 09.12.2015 HR: Wir setzen das hier zur$$HEX1$$fc00$$ENDHEX$$ck auf 0, damit nur die erste Zeile einer Gruppe die Menge hat
// --------------------------------------------------------------------------------------------------------------------
lOverloadSet 		= 0
lOverloadSet_ver 	= 0

// Neu: Anzahl der zugrunde liegenden SPML
dsCenOutMeals.SetItem(lRow,"nspml_quantity",				lNumberOfSPML)

//
// Neu:
// Abh$$HEX1$$e400$$ENDHEX$$ngig vom Generierungsstatus wird die Anzahl Mahlzeiten gesetzt
// Und weil nicht innerhalb jedes Status' eine Mahlzeitenberechnung stattfindet,
// mu$$HEX2$$df002000$$ENDHEX$$von iStatus bis Status 7 alles gesetzt werden!
//
if iStatus > 0 and iStatus < 8 then
	if iStatus > 1 then
		for i = 1 to iStatus
			dsCenOutMeals.SetItem(lRow,"nquantity" + string(i),0)
		next
	end if
	for i = iStatus to 7 
		dsCenOutMeals.SetItem(lRow,"nquantity" + string(i),dcQuantity)
	next
end if

if bInChange then
	//
	// Change-Modus hat mehr Felder im Datasource
	//
	dsCenOutMeals.SetItem(lRow,"status_nreserve_quantity",0)
	dsCenOutMeals.SetItem(lRow,"status_ntopoff_quantity",0)
end if

//
// Neu:
// MealControlCode aus Mahlzeitendefinition wird um die Legnummer erg$$HEX1$$e400$$ENDHEX$$nzt
//
if lLegNumber > 9 then
	lLegNumber = 9
end if

if len(sMealControlCode) < 4 then
	sNewMealControlCode = string(lLegNumber) + sMealControlCode
else
	sNewMealControlCode = sMealControlCode
end if
dsCenOutMeals.SetItem(lRow,"cmeal_control_code",		sNewMealControlCode)

//
// Abrechnung: Host-Schwindel eintragen
//
dsCenOutMeals.SetItem(lRow,"carea_host",					sAreaHost)
dsCenOutMeals.SetItem(lRow,"ceffort_host",				sEffortHost)
dsCenOutMeals.SetItem(lRow,"cadditional_account",		sAdditionalAccountCode)

//
// Neue St$$HEX1$$fc00$$ENDHEX$$cklisten-Typen eintragen
//
dsCenOutMeals.SetItem(lRow,"npl_kind_key",				lPLKindKey)
dsCenOutMeals.SetItem(lRow,"npackinglist_key",			lPackinglistKey)
dsCenOutMeals.SetItem(lRow,"npackinglist_detail_key",	lPLDetailKey)
dsCenOutMeals.SetItem(lRow,"ctext",							sPackinglistText)

dsCenOutMeals.SetItem(lRow,"ndistribute",					iDistribute)

//=================================================================================================
// Catering Delivery Note und Controlling Schalter
//=================================================================================================
dsCenOutMeals.SetItem(lRow,"ncontrolling",lControllingFlag)
dsCenOutMeals.SetItem(lRow,"ndelivery_note",lDeliveryNoteFlag)
dsCenOutMeals.SetItem(lRow,"cdelivery_text",sDeliveryNoteText)
dsCenOutMeals.SetItem(lRow,"cdelivery_snr",sDeliveryNoteSNR)


// ----------------------------------------------------------------------------------------
// 17.06.2009 Kundest$$HEX1$$fc00$$ENDHEX$$cklistennummer customer_pl ccustomer_text hinzu
// customer_pl ccustomer_text in cen_out_meals
String ls_PL, ls_Text
//SELECT	CEN_PACKINGLISTS.CCUSTOMER_PL,   
//			CEN_PACKINGLISTS.CCUSTOMER_TEXT
//INTO		:ls_PL, :ls_Text
//FROM		CEN_PACKINGLISTS,   
//			CEN_PACKINGLIST_INDEX  
//WHERE		CEN_PACKINGLIST_INDEX.NPACKINGLIST_INDEX_KEY = CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY
//AND		CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY = :lPackinglistIndexKey
//AND		CEN_PACKINGLISTS.NPACKINGLIST_DETAIL_KEY = :lPLDetailKey;

// 16.04.2012 mnu: funktion statt direktem select
ll_Ret = uf_get_customer_id(lPackinglistIndexKey, lPLDetailKey, lAirlineKey, ls_PL, ls_Text, true)

dsCenOutMeals.SetItem(lRow,"ccustomer_pl", ls_PL)
dsCenOutMeals.SetItem(lRow,"ccustomer_text", ls_Text)
// ----------------------------------------------------------------------------------------
// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
// ----------------------------------------------------------------------------------------
If il_FillEmptyCustomerPL = 1 Then
	If IsNULL(ls_PL) OR Trim(ls_PL) = "" Then
		dsCenOutMeals.SetItem(lRow,"ccustomer_pl", sPackinglist)
	End If
	If IsNULL(ls_Text) OR Trim(ls_Text) = "" Then
		
		if sProductionTextReplace<>"" then
			dsCenOutMeals.SetItem(lRow,"ccustomer_text",			sProductionTextReplace)
		else
			dsCenOutMeals.SetItem(lRow,"ccustomer_text",			sProductionText)
			If isnull(sProductionText) OR sProductionText = "" Then
				dsCenOutMeals.SetItem(lRow,"ccustomer_text", sPackinglistText)
			End If
		end if 
	End If
End If

// --------------------------------------------------------------------------------------------------------------------
// 08.06.2010 HR: BOB-Werte speichern
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMeals.SetItem(lRow,"nimport_from_bob",ii_Bob )	
if ii_Bob = 1 then
	if isnull(il_bob_percentage) 	then il_bob_percentage = 0

	// --------------------------------------------------------------------------------------------------------------------
	// 27.09.2013 HR: Wir speichern die BOB-Werte in die richtigen Felder  (CBASE-CR-NAM-12085)
	// --------------------------------------------------------------------------------------------------------------------
	if isnull(il_bob_min) 			then il_bob_min = 0	
	if isnull(il_bob_max) 			then il_bob_max = 0	
	if isnull(il_bob_value) 			then il_bob_value = 0	
	
	dsCenOutMeals.SetItem(lRow,"npercentage",	il_bob_percentage)
	dsCenOutMeals.SetItem(lRow,"nvalue", 			il_bob_value)	
	dsCenOutMeals.SetItem(lRow,"nmax_value", 	il_bob_max)	
	dsCenOutMeals.SetItem(lRow,"nmin_value", 	il_bob_min)	
else
	// --------------------------------------------------------------------------------------------------------------------
	// 01.04.2015 HR: Wenn nicht BOB, dann speichern wir die Orginalwerte
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMeals.SetItem(lRow,"nmax_value", 	lMaxValue)	
	dsCenOutMeals.SetItem(lRow,"nmin_value", 	lMinValue)	
end if	 

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Falls es sich um eine Servicest$$HEX1$$fc00$$ENDHEX$$ckliste handelt diese merken
// --------------------------------------------------------------------------------------------------------------------
if isnull(is_packinglist_xsl) then is_packinglist_xsl = ""
dsCenOutMeals.SetItem(lRow,"cpackinglist_xsl", is_packinglist_xsl)

// --------------------------------------------------------------------------------------------------------------------
// 25.09.2012 HR: $$HEX1$$c400$$ENDHEX$$nderungen durch Lokalen Ersetzungen (CBASE-NAM-CR-11009)
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMeals.SetItem(lRow,"nlocal_sub", il_nlocal_sub)

if il_nlocal_sub = 1 then
	dsCenOutMeals.SetItem(lRow,"nmax_value_ori", il_nmax_value_ori)
	dsCenOutMeals.SetItem(lRow,"cpackinglist_ori", is_cpackinglist_ori)
	dsCenOutMeals.SetItem(lRow,"nvalue_ori", il_nvalue_ori)
	dsCenOutMeals.SetItem(lRow,"npercentage_ori", il_npercentage_ori)
	dsCenOutMeals.SetItem(lRow,"ncalc_detail_key_ori", il_ncalc_detail_key_ori)
	dsCenOutMeals.SetItem(lRow,"ncalc_id_ori", il_ncalc_id_ori)
	dsCenOutMeals.SetItem(lRow,"ctext_ori", is_ctext_ori)
	dsCenOutMeals.SetItem(lRow,"npl_index_key_ori", il_npl_index_key_ori)
end if

dsCenOutMeals.SetItem(lRow,"nreduced", 0) // 23.09.2015 HR: Mit 0 vorbelegen (Overload Korrektur - CBASE-HKG-EM-15001)

// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMeals.SetItem(lRow,"nplanning_percent",		iPlanningPercent)
dsCenOutMeals.SetItem(lRow,"cprefix",						icmc_cprefix)
dsCenOutMeals.SetItem(lRow,"nreduce",					icmc_nreduce)
dsCenOutMeals.SetItem(lRow,"coverunderload",			icmc_coverunderload)
dsCenOutMeals.SetItem(lRow,"nservice_sequence",	icmc_nservice_sequence)
dsCenOutMeals.SetItem(lRow,"csap_code",					is_sap_code)


return 0

end function

public function integer uf_calc_integer ();//=================================================================================================
//
// uf_calc_integer
//
// Berechnet Ganzzahliges
//
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long 		lResult
long		lResult_ver;	 		// 06.11.12, Gunnar Brosch: QuantityVersion
integer	iInteger
long		lQuotient
long		lQuotient_ver; 		// 06.11.12, Gunnar Brosch: QuantityVersion

if dcValue = 0 then dcValue = 1
lQuotient = int(lCalcBasis / dcValue)
lQuotient_ver = int(il_calcbasis_ver / dcValue); // 06.11.12, Gunnar Brosch: QuantityVersion

iInteger = int(dcValue)

If Mod(lCalcBasis, iInteger) > 0 then 
	lResult = lQuotient * iInteger + iInteger
else
	lResult = lQuotient * iInteger
end if

// 06.11.12, Gunnar Brosch: QuantityVersion >>>
if mod(il_calcbasis_ver, iInteger) > 0 then 
	lResult_ver = lQuotient_ver * iInteger + iInteger;
else
	lResult_ver = lQuotient_ver * iInteger;
end if
//<<<

dcQuantity = lResult
idc_quantity_ver = lResult_ver; // 06.11.12, Gunnar Brosch: QuantityVersion

return 0

end function

public function integer uf_compile ();//=================================================================================================
//
// uf_compile
//
//=================================================================================================
//
// Zusammenstellung der Mahlzeitenbeladung 
// (Erstellung von cen_out_meals)
//
//=================================================================================================
long		i,j, lfound
long		lActHandlingTypeKey
Boolean	bCalculateConcDiff_Orig 
long		ll_nhandling_detail_key
string		ls_sub_ori, ls_sub_new, ls_find
bCalculateConcDiff_Orig = bCalculateConcDiff  // LT310708  Merken der Eingabe LT310708 

// 17.07.2015 HR: Im Profile nachsehen, ob die Zahlen aus dem Meal Forecast berechnet werden sollen. (aus uf_ask4passenger hierher umgezogen)
ii_CalcFromForecast = integer(uf_cen_profilestring('MealCalculation','CalcFromForecast',"0"))

// 17.07.2015 HR: CBASE-DE-CR-2015-049 Neuer Schalter f$$HEX1$$fc00$$ENDHEX$$r Masseneingbae Passagierausz$$HEX1$$e400$$ENDHEX$$hlungsdialog
ib_Ask4PassengerMass = (uf_cen_profilestring('MealCalculation','UseMassAsk4Passenger',"1") = "1")

// Retrieve auf das Mahlzeitenobjekt
// F$$HEX1$$fc00$$ENDHEX$$r jede Mahlzeitendefinition in meal-cover

// --------------------------------------------------------------------------------------------------------------------
// 09.06.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r BOB werden hier die Werte gelesen
// --------------------------------------------------------------------------------------------------------------------
if iImportBobValues=1 then
	if dsFlightData.DataObject = "dw_change_bob_pax_flight" then
		i = dsFlightData.Retrieve(lResultKey)	
	else
		i = dsFlightData.Retrieve( is_airline,il_flgnr ,is_suffix ,dGenerationDate,is_tlc_from )	
	end if
end if

for i = 1 to dsHandlingMealCover.RowCount()
	uf_trace(20,"uf_compile(): dsHandlingMealCover row " + string(i))

	// --------------------------------------------------------------------------------------------------------------------
	// 23.09.2016 HR: Neue Felder aus CR CBASE-CCS-CR-2016-009 + CCS-CR-1541
	// --------------------------------------------------------------------------------------------------------------------
	icmc_cprefix						= dsHandlingMealCover.GetItemString(i,"cprefix")
	icmc_nreduce					= dsHandlingMealCover.GetItemNumber(i,"nreduce")
	icmc_coverunderload			= dsHandlingMealCover.GetItemString(i,"coverunderload")
	icmc_nservice_sequence	= dsHandlingMealCover.GetItemNumber(i,"nservice_sequence")
	sQuestionText					= dsHandlingMealCover.GetItemString(i,"cquestion_text")
	iAsk4Passenger					= dsHandlingMealCover.GetItemNumber(i,"nask4passenger")
	iPlanningPercent				= dsHandlingMealCover.GetItemNumber(i,"nplanning_percent")
	
	if isnull(icmc_cprefix) then icmc_cprefix=""
	if isnull(icmc_coverunderload) then icmc_coverunderload=""

	// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung des HandlingTypeKeys (=Abfertigungsart *, T, G, N...)
	lActHandlingTypeKey	= dsHandlingMealCover.GetItemNumber(i,"nhandling_type_key")
	
	// Mahlzeitendefinition holen
	lCoverPrio					= dsHandlingMealCover.GetItemNumber(i,"nprio")
	lHandlingCoverKey 		= dsHandlingMealCover.GetItemNumber(i,"nhandling_key")
	lHandlingMealKey		= dsHandlingMealCover.GetItemNumber(i,"nhandling_foreign_key")
	sHandlingCoverText 	= dsHandlingMealCover.GetItemString(i,"cen_handling_ctext")

	// 15.09.2010 HR: Auftragsmenge aus Sky-Tabelle holen, falls vorhanden ( ansonsten ist es -1)
	il_SkyMealOrderQuantity	= dsHandlingMealCover.GetItemNumber(i,"nsky_quantity")

	uf_trace(50,"uf_compile(): dsCenMeals retrieve start")
	dsCenMeals.Retrieve(lHandlingMealKey, dgenerationdate)
	
	if dsCenMeals.RowCount() > 0 then
		// --------------------------------------------------------------------------------------------------------------------
		// 11.03.2016 HR: CBASE-UK-CR-2015-032: Wir pr$$HEX1$$fc00$$ENDHEX$$fen, ob wir f$$HEX1$$fc00$$ENDHEX$$r den AC-Type was ersetzen m$$HEX1$$fc00$$ENDHEX$$ssen
		// 08.06.2016 HR: Schalter wegen Performanceproblem zum Deaktivieren
		// --------------------------------------------------------------------------------------------------------------------
		if ib_SLReplaceForACType then
			uf_replace_pl_for_aircraft()
		end if
		
		for j = 1 to dsCenMeals.RowCount()
			lfound 					= 0
			ii_partial_substitution 	= 0

			if 	idsLocalSubst.rowcount()>0 then
				// --------------------------------------------------------------------------------------------------------------------
				// 24.09.2012 HR: Hier tauschen/l$$HEX1$$f600$$ENDHEX$$schen wir die definierten Lokale Ersetzungen aus (CBASE-NAM-CR-11009)
				// --------------------------------------------------------------------------------------------------------------------
				ls_find = "loc_subst_itemlist_npl_index_from = "+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_npackinglist_index_key"))
				ls_find +=" and ( loc_subst_itemlist_nclass_number = "+string(dsCenMeals.getitemnumber(j,"cen_meals_nclass_number"))+" or loc_subst_itemlist_nclass_all = 1)"
				
				lfound = idsLocalSubst.find(ls_find ,1,idsLocalSubst.rowcount())		
				
				if lfound > 0 then
					ls_sub_ori = string(dsCenMeals.getitemnumber(j,"cen_meals_detail_npackinglist_index_key"))
					ls_sub_ori += " "+dsCenMeals.getitemstring(j,"cen_packinglist_index_cpackinglist")
					ls_sub_ori += " "+dsCenMeals.getitemstring(j,"cen_meals_detail_cproduction_text")
	
					// --------------------------------------------------------------------------------------------------------------------
					// 31.10.2012 HR: bei -1 in npl_index_to soll die SL gel$$HEX1$$f600$$ENDHEX$$scht werden
					// --------------------------------------------------------------------------------------------------------------------
					if idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npl_index_to") = -1 then
						uf_trace(3,"uf_compile(): Local Substitution: Handling_MEAL_KEY: "+string(lHandlingMealKey)+" -> Delete ORI: " +ls_sub_ori)
						dsCenMeals.deleterow(j)
						j --
						continue
					end if
					
					dsCenMeals.setitem(j,"nlocal_sub",1)
					dsCenMeals.setitem(j,"npl_index_key_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_npackinglist_index_key"))
					dsCenMeals.setitem(j,"cpackinglist_ori",dsCenMeals.getitemstring(j,"cen_packinglist_index_cpackinglist"))
					dsCenMeals.setitem(j,"ctext_ori",dsCenMeals.getitemstring(j,"cen_meals_detail_cproduction_text"))
					dsCenMeals.setitem(j,"ncalc_id_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_ncalc_id"))
					dsCenMeals.setitem(j,"ncalc_detail_key_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_ncalc_detail_key"))
					dsCenMeals.setitem(j,"npercentage_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_npercentage"))
					dsCenMeals.setitem(j,"nvalue_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_nvalue"))
					dsCenMeals.setitem(j,"nmax_value_ori",dsCenMeals.getitemnumber(j,"cen_meals_detail_nmax_value"))
	
					dsCenMeals.setitem(j,"cen_meals_detail_npackinglist_index_key",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npl_index_to"))
					dsCenMeals.setitem(j,"cen_packinglist_index_cpackinglist",idsLocalSubst.getitemstring(lfound,"cen_packinglist_index_cpackinglist"))
					dsCenMeals.setitem(j,"cen_packinglists_npackinglist_detail_key",idsLocalSubst.getitemnumber(lfound,"cen_packinglists_npackinglist_detail_key"))
					
					dsCenMeals.setitem(j,"cen_packinglists_ctext",idsLocalSubst.getitemstring(lfound,"cen_packinglists_ctext"))
					// 19.11.2012 HR: Wir nehmen den Text_TO, da er durch den Anwender diesen $$HEX1$$e400$$ENDHEX$$ndern kann
					dsCenMeals.setitem(j,"cen_meals_detail_cproduction_text"	,idsLocalSubst.getitemstring(lfound,"loc_subst_itemlist_cpl_ctext_to"))
					
					// 06.02.2014 HR: CBASE-F4-EM-13004 Item List Type muss auch ersetzet werden
					dsCenMeals.setitem(j,"cen_packinglists_npackinglist_key", dsCenMeals.getitemnumber(j,"cen_packinglists_npackinglist_key"))
					
					ls_sub_new = string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npl_index_to"))
					ls_sub_new += " "+idsLocalSubst.getitemstring(lfound,"cen_packinglist_index_cpackinglist")
					ls_sub_new += " "+idsLocalSubst.getitemstring(lfound,"loc_subst_itemlist_cpl_ctext_to")
	
					if idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_id")<> -1 then
						ls_sub_ori += " ncalc_id:"+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_ncalc_id"))
						dsCenMeals.setitem(j,"cen_meals_detail_ncalc_id",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_id"))
						ls_sub_new += " ncalc_id:"+string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_id"))
	
						if idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_detail_key")<> -1 then
							ls_sub_ori += ", ncalc_detail_key:"+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_ncalc_detail_key"))
							dsCenMeals.setitem(j,"cen_meals_detail_ncalc_detail_key",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_detail_key"))
							ls_sub_new += ", ncalc_detail_key:"+string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_ncalc_detail_key"))
						end if
						
						if not isnull(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npercentage")) then
							ls_sub_ori += ", npercentage:"+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_npercentage"))
							dsCenMeals.setitem(j,"cen_meals_detail_npercentage",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npercentage"))
							ls_sub_new += ", npercentage:"+string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npercentage"))
						end if
						if not isnull(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nvalue")) then
							ls_sub_ori += ", nvalue:"+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_nvalue"))
							dsCenMeals.setitem(j,"cen_meals_detail_nvalue",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nvalue"))
							ls_sub_new += ", nvalue:"+string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nvalue"))
						end if
						if not isnull(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nmax_value")) then
							ls_sub_ori += ", nmax_value:"+string(dsCenMeals.getitemnumber(j,"cen_meals_detail_nmax_value"))
							dsCenMeals.setitem(j,"cen_meals_detail_nmax_value",idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nmax_value"))
							ls_sub_new += ", nmax_value:"+string(idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_nmax_value"))
						end if
					end if
					
					uf_trace(3,"uf_compile(): Local Substitution: Handling_MEAL_KEY: "+string(lHandlingMealKey)+" -> ORI: " +ls_sub_ori)
					uf_trace(3,"uf_compile(): Local Substitution: Handling_MEAL_KEY: "+string(lHandlingMealKey)+" -> NEW: " +ls_sub_new)
					il_nlocal_sub_flight = 1
				end if
			end if

			if dsCenMeals.getitemnumber(j,"cen_meals_detail_ncalc_id") = 99 then
				if iImportBobValues=0 then
					if dsFlightData.DataObject = "dw_change_bob_pax_flight" then
						dsFlightData.Retrieve(lResultKey)	
					else
						dsFlightData.Retrieve( is_airline,il_flgnr ,is_suffix ,dGenerationDate,is_tlc_from )	
					end if
					iImportBobValues = 1
				end if
				
				
				// --------------------------------------------------------------------------------------------------------------------
				// 22.01.2013 HR: Hier tauschen wir die Dummy CalcID 99 gegen die richtige aus der BOB-Tabellen aus
				// --------------------------------------------------------------------------------------------------------------------
				lfound = dsFlightData.find("cpackinglist = '"+dsCenMeals.getitemstring(j,"cen_packinglist_index_cpackinglist")+"'",1,dsFlightData.rowcount())
				if lfound>0 then
					dsCenMeals.setitem(j,"cen_meals_detail_ncalc_id", dsFlightData.GetItemNumber(lfound,"ncalc_id"))
				end if
			end if
		next
	end if
	
	bCalculateConcDiff = bCalculateConcDiff_Orig  // LT310708 wieder auf Ursprungswert zur$$HEX1$$fc00$$ENDHEX$$cksetzen

	If bCalculateConcDiff Then
		If ii_mlFlight = 0 Then 
			bCalculateConcDiff = False
		Else
			//Datastore mit Unterbeladung f$$HEX1$$fc00$$ENDHEX$$llen
			//dsHandlingDiff.Retrieve(lHandlingDetailKey)
//			dsHandlingDiff.Retrieve(lRoutingPlanDetailKey, lHandlingMealKey, dGenerationDate)
			dsHandlingDiff.Retrieve(lHandlingCoverKey, dGenerationDate) // TBR 20.10.2008
			If dsHandlingDiff.RowCount() = 0 Then bCalculateConcDiff = False
		End If
	End If
	
	//
	// 09.02.2006 Anmerkung: Dies w$$HEX1$$e400$$ENDHEX$$re die geeignete Stelle, die Ratiolist3-Ersetzung vorzunehmen
	// F$$HEX1$$fc00$$ENDHEX$$r alle ncalc_id = 99 wird der nratiolist_key in cen_calc_ratio3.nratiolist_key gesucht.
	// Anschl. werden die Daten ausgetauscht.
	//
	uf_replace_ratiolist3()
	
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	uf_trace(50,"uf_compile(): dsCenMeals retrieve end")
	//f_print_datastore(dsCenMeals)

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005 Servicest$$HEX1$$fc00$$ENDHEX$$ckliste leeren
	// --------------------------------------------------------------------------------------------------------------------
	is_packinglist_xsl = ""
	
	if dsCenMeals.RowCount() > 0 then
		//
		// Umlauf holen (einmal je Mahlzeitendefinition)
		//
		uf_trace(30,"uf_compile(): start uf_get_rotation(lRotation_key)")
		lRotation_key = dsCenMeals.GetItemNumber(1,"cen_meals_nrotation_key")
		if uf_get_rotation(lRotation_key,0) <> 0 then	// Rotation-Key aus cen_meals
			//
			// Fehler beim Umlauf => Daten nicht schreiben
			//
			continue
		end if
		uf_trace(30,"uf_compile(): end uf_get_rotation(lRotation_key)")
	end if
	
	//
	// 01.02.05: Umlauf filtern
	//
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey))
	dsCenMeals.Filter()
	// 07.11.2013 HR: Sortierung aus DW $$HEX1$$fc00$$ENDHEX$$bernommen, damit ServiceSL am Anfang stehen (Testliste 4.96-099)
	// 20.12.2013 HR: Sortierung Servicest$$HEX1$$fc00$$ENDHEX$$ckliste wieder raus (4.96-103)
	dsCenMeals.SetSort("cen_meals_detail_nprio A")

	dsCenMeals.Sort()

	for j = 1 to dsCenMeals.RowCount()
//		//
//		// 01.02.05: Umlauf filtern
//		//
//		dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey))
//		dsCenMeals.Filter()
//		dsCenMeals.SetSort("cen_meals_detail_nprio A")
//		dsCenMeals.Sort()
		uf_trace(20,"uf_compile(): dsCenMeals row " + string(j))
		uf_trace(20,"uf_compile(): dsCenMeals.RowCount() " + string(dsCenMeals.RowCount()))
		if dsCenMeals.GetItemNumber(j,"nrotation_name_key") <> lRotationNameKey then
			//
			// Datensatz ist f$$HEX1$$fc00$$ENDHEX$$r anderen Umlauf bestimmt
			//
			continue
		end if
		
		// 08.06.2010 HR: BOB-Kennzeichen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
		ii_Bob=0
		
		// --------------------------------------------------------------------------------------------------------------------
		// 24.07.2013 HR: CBASE-DE-CR-2013-005: Falls es sich um eine Servicest$$HEX1$$fc00$$ENDHEX$$ckliste handelt diese merken
		// --------------------------------------------------------------------------------------------------------------------
		if dsCenMeals.GetItemNumber(j,"sys_packinglist_kinds_nxsl")= 1 then
			is_packinglist_xsl = dsCenMeals.GetItemString(j,"cen_packinglist_index_cpackinglist")
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// Satz berechnen
		// --------------------------------------------------------------------------------------------------------------------
		if uf_calculate(j) <> 0 then
			// Fehler bei Berechnung der Mahlzeit, Daten nicht schreiben
			continue
		end if

		// Kurz-Von-An setzen
		if j <= dsCenMeals.RowCount() then
			lAccountKey				= dsCenMeals.GetItemNumber(j,"cen_meals_detail_naccount_key")
			lDefaultAccountKey 	= dsCenMeals.GetItemNumber(j,"ndefault_account_key")
		else
			uf_trace(20,"uf_compile(): Filter schr$$HEX1$$e400$$ENDHEX$$nkt RowCount() ein!")
			uf_trace(20,"uf_compile(): after uf_calculate() dsCenMeals row " + string(j))
			uf_trace(20,"uf_compile(): after uf_calculate() dsCenMeals.RowCount() " + string(dsCenMeals.RowCount()))
			uf_trace(20,"uf_compile(): after uf_calculate() dsCenMeals.AccessRow = " + string(j))
		end if
		
		if isnull(lAccountKey) or lAccountKey = 0 then
			// Falls kein KVA auf Zeile gesetzt, dann Default verwenden
			lAccountKey = lDefaultAccountKey
		end if
		
		// $$HEX1$$dc00$$ENDHEX$$bertrag nach cen_out_meals (dsCenOutMeals)
		uf_trace(30,"uf_compile(): start uf_insert_cen_out_meals()")
		uf_insert_cen_out_meals()
		uf_trace(30,"uf_compile(): end uf_insert_cen_out_meals()")
	
	next
	dsCenMeals.SetFilter("")
	dsCenMeals.Filter()

next

//
// 17.10.05	Sequence nur wenn Schalter gesetzt
//
//long	lSequence
//if iUseSequence = 0 then
//	uf_trace(10,"uf_compile(): do not use sequences")
//	for i = 1 to dsCenOutMeals.RowCount()
//		if dsCenOutMeals.GetRow() <= dsOldMeals.RowCount() then
//			dsCenOutMeals.SetItem(i,"ndetail_key",dsOldMeals.GetItemNumber(i,"ndetail_key"))
//		else
//			uf_trace(50,"uf_compile(): not enough sequences in old datastore...")
//			lSequence = f_Sequence("seq_cen_out_meals", sqlca)
//			dsCenOutMeals.SetItem(i,"ndetail_key",lSequence)
//		end if
//	next
//end if

return 0

end function

public function long uf_calc_ratiolist2 ();//=================================================================================================
//
// uf_calc_ratiolist2
//
// Berechnet die Auftragsmenge einer Ratiolist und liefert abweichende St$$HEX1$$fc00$$ENDHEX$$ckliste
//
//=================================================================================================
//
// 02.09.04	Umstellung auf Datastore
// 08.03.06 Ratiolist-Suche erweitert
// 08.11.12, Gunnar Brosch: QuantityVersion eingebaut
// 06.05.13 HR QuantityVersion (SL und SL-Text f$$HEX1$$fc00$$ENDHEX$$r die Version nicht $$HEX1$$fc00$$ENDHEX$$bernehmen, da hier die Werte f$$HEX1$$fc00$$ENDHEX$$r die Pax-Menge $$HEX1$$fc00$$ENDHEX$$berschrieben wurde)
//=================================================================================================
long			lresult
long 			lQuantity
long			lNewIndexKey
long			lfrom_pax, lto_pax
datetime		dtDate
long			lFind
long			lRows

string		sRatioText
string		sFind
long			lRatioKey

uf_trace(50,"uf_calc_ratiolist2(): start")

//HR 07.07.2008 CBASE-UK-EM-4402
//Variable zur$$HEX1$$fc00$$ENDHEX$$cksetzen, so dass der normale Produktionstext benutzt wird.
sProductionTextReplace = ""

lRows = dsRatiolistDefinition.Retrieve(lcalcdetailkey,dgenerationdate)
//
// 20.04.2005: Falls gar nichts da ist
//
if lRows = 0 then
	uf_trace(1,"uf_calc_ratiolist2(): Found no valid Ratiolist Definition! Try to search again...")
	if dsFindRatiolist.RowCount() = 0 then
		dsFindRatiolist.Retrieve()
	end if
	lFind = dsFindRatiolist.Find("nratiolist_key = " + string(lcalcdetailkey), 1, dsFindRatiolist.RowCount())
	if lFind > 0 then
		sRatioText = dsFindRatiolist.GetItemString(lFind,"ctext")
		
//		lFind = dsFindRatiolist.Find("ctext = '" + sRatioText + &
//					"' and string(dvalid_from,'dd.mm.yyyy') = '" + string(dgenerationdate,"dd.mm.yyyy") + "'", 1, dsFindRatiolist.RowCount())
// 23.06.2010 HR:
//		sFind = "ctext = '" + sRatioText + &
//					"' and date(string(dvalid_from,'dd.mm.yyyy')) <= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and date(string(dvalid_to,'dd.mm.yyyy')) >= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and ncustomer_key = " + string(lAirlineKey)
//					
		sFind = "ctext = '" + sRatioText + &
					"' and date(string(dvalid_from,'yyyy-mm-dd')) <= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and date(string(dvalid_to,'yyyy-mm-dd')) >= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and ncustomer_key = " + string(lAirlineKey)
		

		lFind = dsFindRatiolist.Find(sFind, 1, dsFindRatiolist.RowCount())
		if lFind > 0 then
			lcalcdetailkey = dsFindRatiolist.GetItemNumber(lFind,"nratiolist_key")
			lRows = dsRatiolistDefinition.Retrieve(lcalcdetailkey,dgenerationdate)
			uf_trace(1,"uf_calc_ratiolist2(): Found new key for Ratiolist Definition!")
		else
			uf_trace(1,"uf_calc_ratiolist2(): Found no valid Ratiolist Definition!!!")
			//
			// urspr. Packinglist bleibt erhalten!
			//
			lResult					= 0
			dcQuantity 				= lResult
			idc_quantity_ver 		= lResult; //08.11.12, Gunnar Brosch: QuantityVersion eingebaut
			return lResult
		end if
	end if
end if

lFind = dsRatiolistDefinition.Find("nfrom_pax <= " + string(lCalcBasis) + &
												" and nto_pax >= " + string(lCalcBasis),1,dsRatiolistDefinition.RowCount())
if lFind > 0 then
	lResult					= dsRatiolistDefinition.GetItemNumber(lFind,"nquantity")
	lNewIndexKey			= dsRatiolistDefinition.GetItemNumber(lFind,"nindex_key")
	lPackinglistIndexKey	= lNewIndexKey
	lPLDetailKey			= dsRatiolistDefinition.GetItemNumber(lFind,"npackinglist_detail_key")	
	sPackinglist			= dsRatiolistDefinition.GetItemString(lFind,"cpackinglist")
	sUnit						= dsRatiolistDefinition.GetItemString(lFind,"cunit")
	dcQuantity 				= lResult

	//HR 07.07.2008 CBASE-UK-EM-4402
	//Wenn der Schalter Replacetext angeschaltet ist, dann den St$$HEX1$$fc00$$ENDHEX$$cklistentext merken um den Produktionstext $$HEX1$$e400$$ENDHEX$$ndern zu k$$HEX1$$f600$$ENDHEX$$nnen
	if dsRatiolistDefinition.GetItemNumber(lFind,"nreplace_text")=1 then
		sProductionTextReplace = dsRatiolistDefinition.GetItemstring(lFind,"cen_packinglists_ctext")		
		if isnull(sProductionTextReplace) then sProductionTextReplace=""
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 21.06.2010 HR: IMView 262: Produktionstext durch SL-Produktionstext ersetzen falls eingestellt
	// --------------------------------------------------------------------------------------------------------------------
	if  ii_ReplaceProdText =1 or ii_ReplaceProdTextSpml=1 then  // 06.02.2013 HR: auch f$$HEX1$$fc00$$ENDHEX$$r SPML
		sProductionTextReplace = dsRatiolistDefinition.GetItemstring(lFind,"cen_packinglists_ctext_short")		
		if isnull(sProductionTextReplace) then sProductionTextReplace=""
	end if
else
	//
	// urspr. Packinglist bleibt erhalten!
	//
	lResult					= 0
	dcQuantity 				= lResult
end if

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
//15.10.2009, DB: Der Fall sollte eigentlich nie auftreten, aber wenn doch, dann sollte zumindest kein
//Powerbuilder Fehler kommen.
if dsRatiolistDefinition.RowCount() > 0 then
	
	if dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nto_pax") < lCalcBasis then
		lResult					= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nquantity")
		lNewIndexKey			= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nindex_key")
		lPackinglistIndexKey	= lNewIndexKey
		lPLDetailKey			= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"npackinglist_detail_key")	
		sPackinglist			= dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cpackinglist")
		sUnit						= dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cunit")
		dcQuantity 				= lResult
		
		//HR 07.07.2008 CBASE-UK-EM-4402
		//Wenn der Schalter Replacetext angeschaltet ist, dann den St$$HEX1$$fc00$$ENDHEX$$cklistentext merken um den Produktionstext $$HEX1$$e400$$ENDHEX$$ndern zu k$$HEX1$$f600$$ENDHEX$$nnen
		if dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nreplace_text")=1 then
			sProductionTextReplace = dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cen_packinglists_ctext")		
			if isnull(sProductionTextReplace) then sProductionTextReplace=""
		end if
	end if

end if

// 08.11.12, Gunnar Brosch, Desgleiche, auch f$$HEX1$$fc00$$ENDHEX$$r die QuantityVariation *** >>>>>>>>>>>>
// 02.05.2013 HR: Bei der Berechnung mit der Version d$$HEX1$$fc00$$ENDHEX$$rfen wir vorerst nicht die SL tauschen
lFind = dsRatiolistDefinition.Find("nfrom_pax <= " + string(il_calcbasis_ver) + &
												" and nto_pax >= " + string(il_calcbasis_ver),1,dsRatiolistDefinition.RowCount())
if lFind > 0 then
	idc_quantity_ver			= dsRatiolistDefinition.GetItemNumber(lFind,"nquantity")
	//lNewIndexKey			= dsRatiolistDefinition.GetItemNumber(lFind,"nindex_key")
	//lPackinglistIndexKey	= lNewIndexKey
	//lPLDetailKey				= dsRatiolistDefinition.GetItemNumber(lFind,"npackinglist_detail_key")	
	//sPackinglist				= dsRatiolistDefinition.GetItemString(lFind,"cpackinglist")
	//sUnit						= dsRatiolistDefinition.GetItemString(lFind,"cunit")
	//idc_quantity_ver		= lResult

	//HR 07.07.2008 CBASE-UK-EM-4402
	//Wenn der Schalter Replacetext angeschaltet ist, dann den St$$HEX1$$fc00$$ENDHEX$$cklistentext merken um den Produktionstext $$HEX1$$e400$$ENDHEX$$ndern zu k$$HEX1$$f600$$ENDHEX$$nnen
//	if dsRatiolistDefinition.GetItemNumber(lFind,"nreplace_text")=1 then
//		sProductionTextReplace_ver = dsRatiolistDefinition.GetItemstring(lFind,"cen_packinglists_ctext")		
//		if isnull(sProductionTextReplace) then sProductionTextReplace_ver=""
//	end if
//	
	// --------------------------------------------------------------------------------------------------------------------
	// 21.06.2010 HR: IMView 262: Produktionstext durch SL-Produktionstext ersetzen falls eingestellt
	// --------------------------------------------------------------------------------------------------------------------
//	if  ii_ReplaceProdText =1 then 
//		sProductionTextReplace_ver = dsRatiolistDefinition.GetItemstring(lFind,"cen_packinglists_ctext_short")		
//		if isnull(sProductionTextReplace_ver) then sProductionTextReplace_ver=""
//	end if
else
	// urspr. Packinglist bleibt erhalten!
	idc_quantity_ver		= 0
end if

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
//15.10.2009, DB: Der Fall sollte eigentlich nie auftreten, aber wenn doch, dann sollte zumindest kein
//Powerbuilder Fehler kommen.
if dsRatiolistDefinition.RowCount() > 0 then
	
	if dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nto_pax") < il_calcbasis_ver then
		idc_quantity_ver		= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nquantity")
//		lNewIndexKey			= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nindex_key")
//		lPackinglistIndexKey	= lNewIndexKey
//		lPLDetailKey				= dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"npackinglist_detail_key")	
//		sPackinglist				= dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cpackinglist")
//		sUnit						= dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cunit")
//		idc_quantity_ver		= lResult
		
		//HR 07.07.2008 CBASE-UK-EM-4402
		//Wenn der Schalter Replacetext angeschaltet ist, dann den St$$HEX1$$fc00$$ENDHEX$$cklistentext merken um den Produktionstext $$HEX1$$e400$$ENDHEX$$ndern zu k$$HEX1$$f600$$ENDHEX$$nnen
//		if dsRatiolistDefinition.GetItemNumber(dsRatiolistDefinition.RowCount(),"nreplace_text")=1 then
//			sProductionTextReplace_ver = dsRatiolistDefinition.GetItemString(dsRatiolistDefinition.RowCount(),"cen_packinglists_ctext")		
//			if isnull(sProductionTextReplace_ver) then sProductionTextReplace_ver=""
//		end if
	end if

end if
// 08.11.12, Gunnar Brosch, Desgleiche, auch f$$HEX1$$fc00$$ENDHEX$$r die QuantityVariation *** <<<<<<<<<<<<


return lResult
end function

public function integer uf_ask4passenger ();//=================================================================================================
// uf_ask4passenger
//
// Nachfragen, ob ein Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog ge$$HEX1$$f600$$ENDHEX$$ffnet werden soll.
// Wird $$HEX1$$fc00$$ENDHEX$$brigens f$$HEX1$$fc00$$ENDHEX$$r jede Zeile angesprungen.
//=================================================================================================
// Im Dialogbetrieb ist ein Fenster zu $$HEX1$$f600$$ENDHEX$$ffnen,
// bei der Generierung sind Annahmen bzgl. der erwarteten Pax-Zahl zu treffen.
// 18.03.2005: Zugriff auf dsCurrentMeals
//=================================================================================================

long		lFind, lFind2, i, j
string		sFind
long		lOldValue
Integer	li_pax_calc, li_pax, li_classnr, li_status

// Im Profile nachsehen, ob die Zahlen aus dem Meal Forecast berechnet werden sollen.
// ii_CalcFromForecast = integer(uf_cen_profilestring('MealCalculation','CalcFromForecast',"0")) (17.07.2015 HR nach uf_compile umgezogen)

ibo_pax_from_forecast = FALSE


if bInGeneration then // Generierung l$$HEX1$$e400$$ENDHEX$$uft
	// Wenn die Zahlen aus dem Meal Forecast berechnet werden sollen und AskForPassengers gesetzt ist 
	// => ermittlung der Paxzahl f$$HEX1$$fc00$$ENDHEX$$r den Service oder als Vorgabe f$$HEX1$$fc00$$ENDHEX$$r den Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog
	IF ii_CalcFromForecast = 1 AND iAsk4Passenger = 1 THEN
		li_pax_calc = uf_calc_pax_via_forecast_ratio()
	END IF
	
	IF ibo_pax_from_forecast 	THEN	// TBR 04.10.2010 wenn Forecast-Pax vorhanden
		lPaxManual = li_pax_calc			// => errechnete Pax verwenden
	ELSE
		if iAsk4Passenger = 1 then
			if iPlanningPercent > 0 then
				lPaxManual = Int((lPaxManual * iPlanningPercent / 100) + 0.5)
			elseif iPlanningPercent = 0 then
				lPaxManual = 0
			end if
		end if
	END IF // IF 	ibo_forecast_ratio_found ... TBR 04.10.2010
end if // Generierung l$$HEX1$$e400$$ENDHEX$$uft


if bInChange and iAsk4Passenger = 1 then // Dialog-Betrieb
	// --------------------------------------------------------------------------------------------------------------------
	// 15.07.2015 HR: CBASE-DE-CR-2015-049
	// --------------------------------------------------------------------------------------------------------------------
	if ib_ask4passenger then
		//Beim ersten Auftreten f$$HEX1$$fc00$$ENDHEX$$llen wir die alten Parameter, wenn es die Masseneingabe eingeschaltet ist
		if ib_Ask4PassengerMass then 
			          
			ids_ask4passenger.retrieve(lResultKey)
			
			if ids_ask4passenger.rowcount()>0 then
				// --------------------------------------------------------------------------------------------------------------------
				// 05.11.2015 HR: Jetzt schauen wir erst mal nach, ob sich in der Klasse was ge$$HEX1$$e400$$ENDHEX$$ndert hat
				// --------------------------------------------------------------------------------------------------------------------
				for i = 1 to dsCenOutPax.rowcount()
					if dsCenOutPax.getitemnumber(i, "status_npax")=0 then continue
					
					for j = 1 to ids_ask4passenger.rowcount()
					
						if ids_ask4passenger.getitemstring(j, "cclass") <> dsCenOutPax.getitemstring(i, "cclass") then continue
						
						ids_ask4passenger.setitem(j, "npaxchanged", 1)
					next
				next
				
				// --------------------------------------------------------------------------------------------------------------------
				// 18.03.2016 HR: Wenn wir mehre $$HEX1$$c400$$ENDHEX$$nderungen ohne zu Speichern durchf$$HEX1$$fc00$$ENDHEX$$hren, dann wollen wir die 
				//                        ge$$HEX1$$e400$$ENDHEX$$nderten Werte anzeigen (CBASE-DE-EM-16002)
				// --------------------------------------------------------------------------------------------------------------------
				for i = 1 to ids_ask4passenger.rowcount()
					sFind = "cclass = '" + ids_ask4passenger.getitemstring(i, "cclass") +"' "
					sFind += " and nhandling_key = " + string(ids_ask4passenger.getitemnumber(i, "nhandling_key"))
					sFind += " and nhandling_meal_key = " + string(ids_ask4passenger.getitemnumber(i, "nhandling_meal_key"))
					sFind += " and cquestion_text = '" + ids_ask4passenger.getitemstring(i, "cquestion_text") + "' "
					
					lFind = dsCurrentMeals.find(sFind, 1, dsCurrentMeals.rowcount())
					if lFind > 0 then
						ids_ask4passenger.setitem(i, "nnewvalue", dsCurrentMeals.getitemnumber(lFind, "npax_manual"))
					end if
				next
				
			end if			
		else
			ids_ask4passenger.reset()
		end if
		
		if ids_ask4passenger.rowcount()>0 then
			//Nur wenn sich in irgendeiner Klasse die Paxe ge$$HEX1$$e400$$ENDHEX$$ndert haben
			lFind = dsCenOutPax.Find("status_npax = 1",1,dsCenOutPax.RowCount())
			if lFind > 0 then
				if not bCallByWebService  then  // bei Aufruf $$HEX1$$fc00$$ENDHEX$$ber Service kein Dialog
					sFind 		= "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
								     string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
					lFind 		= ids_ask4passenger.find(sFind, 1, ids_ask4passenger.rowcount())

					if lFind = 0 then
						lFind = ids_ask4passenger.insertrow(0)
						ids_ask4passenger.setitem(lFind, "nresult_key", 				1)
						ids_ask4passenger.setitem(lFind, "nclass_number", 			lClassNumber)
						ids_ask4passenger.setitem(lFind, "cclass", 						sClass)
						ids_ask4passenger.setitem(lFind, "chandling_text", 			sHandlingText)
						ids_ask4passenger.setitem(lFind, "nhandling_key", 			lHandlingKey)
						ids_ask4passenger.setitem(lFind, "nhandling_meal_key", 	lMasterKey)
						ids_ask4passenger.setitem(lFind, "cquestion_text", 			sQuestionText)
						ids_ask4passenger.setitem(lFind, "npax_manual", 			0)
						ids_ask4passenger.setitem(lFind, "nnewvalue", 				0)
						ids_ask4passenger.sort()
					end if
					
					IF ii_CalcFromForecast = 1 then
						//Jetzt m$$HEX1$$fc00$$ENDHEX$$ssen wir noch ggf. pro Klasse und Service die Paxe berechnen
						
						li_classnr = -1
						
						for i = 1 to ids_ask4passenger.rowcount()
							if ids_ask4passenger.getitemnumber(i, "nresult_key")<1 then continue
						
							if li_classnr <> ids_ask4passenger.getitemnumber(i, "nclass_number") then
								li_classnr = ids_ask4passenger.getitemnumber(i, "nclass_number")
								lFind = dsCenOutPax.Find("nclass_number = "+string(li_classnr), 1, dsCenOutPax.RowCount())	
								if lFind > 0 then
									li_pax = dsCenOutPax.getitemnumber(lFind, "npax")
								else
									li_pax = 0
								end if
							end if
							
							li_pax_calc = uf_calc_pax_via_forecast_ratio_mass(sClass, li_pax, ids_ask4passenger.getitemnumber(i, "nservice"), li_status)
							
							// Jetzt tragen wir die R$$HEX1$$fc00$$ENDHEX$$ckgabewerte bei allen Eintr$$HEX1$$e400$$ENDHEX$$gen der gleiche Klasse und Service ein
							for j = i to  ids_ask4passenger.rowcount()
								//Beim Klassenwechsel raus hier
								if ids_ask4passenger.getitemnumber(i, "nclass_number") <> ids_ask4passenger.getitemnumber(j, "nclass_number") then exit
								
								// Andere Service dann zum n$$HEX1$$e400$$ENDHEX$$chsten
								if ids_ask4passenger.getitemnumber(i, "nservice") <> ids_ask4passenger.getitemnumber(j, "nservice") then continue
								
								ids_ask4passenger.setitem(j, "nresult_key", 	li_status)
								if li_status = -2 then
									ids_ask4passenger.setitem(j, "nnewvalue", 		li_pax_calc)
								end if
								
							next
						next
					end if 
					
					Openwithparm(w_meal_pax_counts_mass, this)
				end if
			end if
		end if
		
		ib_ask4passenger = false
	end if
	
	if ids_ask4passenger.rowcount()>0 then
		//Wenn die Werte als ganzes aktuallisiert wurde, dann suchen wir erst mal in diesem DS
		sFind 		= "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
					     string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
		
		lFind 		= ids_ask4passenger.find(sFind, 1, ids_ask4passenger.rowcount())
		lFind2 	= dsCurrentMeals.Find(sFind,1,dsCurrentMeals.RowCount())
		
		if lFind >0 then
			//Wert gefunden, dann $$HEX1$$fc00$$ENDHEX$$bernehemen
			if lFind2 > 0 then
				s_pax_counts.loldvalue 	= dsCurrentMeals.GetItemNumber(lFind2,"npax_manual")	
			else
				s_pax_counts.loldvalue 	= 0
			end if
			
			s_pax_counts.lvalue 			= ids_ask4passenger.getitemnumber(lFind, "nnewvalue") 
			s_pax_counts.bsuccessful 	= True
			
			if ids_ask4passenger.getitemnumber(lFind, "nresult_key")  = -2 then
				ibo_pax_from_forecast 	= TRUE
			end if
		else
			// Wenn die Zahlen aus dem Meal Forecast berechnet werden sollen und AskForPassengers gesetzt ist 
			// => ermittlung der Paxzahl f$$HEX1$$fc00$$ENDHEX$$r den Service oder als Vorgabe f$$HEX1$$fc00$$ENDHEX$$r den Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog
			IF ii_CalcFromForecast = 1 AND iAsk4Passenger = 1 THEN
				li_pax_calc = uf_calc_pax_via_forecast_ratio()
			END IF

			//Nicht gefunden, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir noch mal nachfragen
			s_pax_counts.loldvalue 			= 0
			s_pax_counts.sdescription 		= sQuestionText
			
			IF 	ibo_pax_from_forecast   		THEN 					
				s_pax_counts.lvalue 			= li_pax_calc		
			ELSE															
				s_pax_counts.lvalue 			= lPaxManual
			END IF																		
			
			if not bCallByWebService  then  // bei Aufruf $$HEX1$$fc00$$ENDHEX$$ber Service kein Dialog
				OpenWithParm(w_meal_pax_counts, s_pax_counts)
				s_pax_counts = Message.PowerObjectParm
				lFind = ids_ask4passenger.insertrow(0)
				ids_ask4passenger.setitem(lFind, "nclass_number", 			lClassNumber)
				ids_ask4passenger.setitem(lFind, "cclass", 						sClass)
				ids_ask4passenger.setitem(lFind, "chandling_text", 			sHandlingText)
				ids_ask4passenger.setitem(lFind, "nhandling_key", 			lHandlingKey)
				ids_ask4passenger.setitem(lFind, "nhandling_meal_key", 	lMasterKey)
				ids_ask4passenger.setitem(lFind, "cquestion_text", 			sQuestionText)
				ids_ask4passenger.setitem(lFind, "npax_manual", 			0)
				ids_ask4passenger.setitem(lFind, "nnewvalue", 				s_pax_counts.lvalue)
				ids_ask4passenger.sort()	
			else
				s_pax_counts.bsuccessful 	= True
			end if			
		end if
		
		lPaxManual 		= s_pax_counts.lvalue
		iManualInput 	= 1
		
	else	
		// Wenn die Zahlen aus dem Meal Forecast berechnet werden sollen und AskForPassengers gesetzt ist 
		// => ermittlung der Paxzahl f$$HEX1$$fc00$$ENDHEX$$r den Service oder als Vorgabe f$$HEX1$$fc00$$ENDHEX$$r den Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog
		IF ii_CalcFromForecast = 1 AND iAsk4Passenger = 1 THEN
			li_pax_calc = uf_calc_pax_via_forecast_ratio()
		END IF
		
		// Neu: nur dann $$HEX1$$f600$$ENDHEX$$ffnen, wenn auch wirklich in der entsprechenden Klasse ge$$HEX1$$e400$$ENDHEX$$ndert wurde (dsCenOutPax.status_npax)
		lFind = dsCenOutPax.Find("status_npax = 1 and nclass_number = " + string(lClassNumber),1,dsCenOutPax.RowCount())
		if lFind > 0 then
			// Innerhalb einer Mahlzeitenkomponente soll Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog nicht mehrfach $$HEX1$$f600$$ENDHEX$$ffnen
			if bNextMeal and iAsk4Passenger = 1 then

				lOldValue = 0

				// 12.04.05: Finden der korrekten Menge npax_manual in dsCurrentMeals
				sFind = "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
							string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
				lFind2 = dsCurrentMeals.Find(sFind,1,dsCurrentMeals.RowCount())
				if lFind2 > 0 then
					// 20.01.2011 HR:
					s_pax_counts.loldvalue = dsCurrentMeals.GetItemNumber(lFind2,"npax_manual")
					
					IF 	ibo_pax_from_forecast   		THEN 					// TBR 05.10.2010 ---
						s_pax_counts.lvalue 			= li_pax_calc		// wenn Forecast-Pax vorhanden
					ELSE															// dann diese verwenden
						s_pax_counts.lvalue 			= dsCurrentMeals.GetItemNumber(lFind2,"npax_manual")
					END IF														// --- TBR 05.10.2010 
	
					lOldValue = s_pax_counts.lvalue
				else
					s_pax_counts.loldvalue = lPaxManual
	
					IF 	ibo_pax_from_forecast    	THEN 					// TBR 05.10.2010 ---
						s_pax_counts.lvalue 			= li_pax_calc		// wenn Forecast-Pax vorhanden
					ELSE															// dann diese verwenden
						s_pax_counts.lvalue 			= lPaxManual
					END IF														// --- TBR 05.10.2010 					
	
				end if
				
				// Ausz$$HEX1$$e400$$ENDHEX$$hlfenster nur noch $$HEX1$$f600$$ENDHEX$$ffnen, wenn auch tats. Menge ge$$HEX1$$e400$$ENDHEX$$ndert
				s_pax_counts.sdescription 	= sQuestionText
				
				// Die Entscheidung, ob ausgez$$HEX1$$e400$$ENDHEX$$hlt wird oder nicht, sollte nicht von lOldValue <> lPaxManual getroffen werden!!!
				if not bCallByWebService  then  // bei Aufruf $$HEX1$$fc00$$ENDHEX$$ber Service kein Dialog
					OpenWithParm(w_meal_pax_counts, s_pax_counts)
					s_pax_counts = Message.PowerObjectParm
				else
					 s_pax_counts.bsuccessful = True
					 
				end if
			end if
	
			// Wert der Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$f600$$ENDHEX$$ffnen
			if iAsk4Passenger = 1 then
				if s_pax_counts.bsuccessful then
	
					// setzen der neuen Eingaben
					lPaxManual = s_pax_counts.lvalue
					iManualInput = 1
				end if
			end if
		else
	
			// falls Klasse nicht ver$$HEX1$$e400$$ENDHEX$$ndert wurde, dann letzte Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$fc00$$ENDHEX$$bernehmen
			sFind = "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
						string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
			lFind2 = dsCurrentMeals.Find(sFind,1,dsCurrentMeals.RowCount())
			
			if lFind2 > 0 then
				lPaxManual = dsCurrentMeals.GetItemNumber(lFind2,"npax_manual")   // alter Wert einsetzen
			else
	
				// nichts gefunden, dann halt nochmal ausz$$HEX1$$e400$$ENDHEX$$hlen
				if bNextMeal and iAsk4Passenger = 1 then
	
					IF 	ibo_pax_from_forecast   		THEN 					// TBR 05.10.2010 ---
						s_pax_counts.lvalue 			= li_pax_calc		// wenn Forecast-Pax vorhanden
					ELSE															// dann diese verwenden
						s_pax_counts.lvalue 			= lPaxManual
					END IF														// --- TBR 05.10.2010 					
					
					s_pax_counts.sdescription 		= sQuestionText
					
					if not bCallByWebService  then  // bei Aufruf $$HEX1$$fc00$$ENDHEX$$ber Service kein Dialog
						OpenWithParm(w_meal_pax_counts, s_pax_counts)
						s_pax_counts = Message.PowerObjectParm
					else
						 s_pax_counts.bsuccessful = True
					end if
				end if
	
				// Wert der Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$f600$$ENDHEX$$ffnen
				if iAsk4Passenger = 1 then
					if s_pax_counts.bsuccessful then
						// setzen der neuen Eingaben
						lPaxManual 		= s_pax_counts.lvalue
						iManualInput 	= 1
					end if
				end if
			end if
		end if
	end if
end if // Dialog-Betrieb

return 0

end function

public function long uf_calc_ratiolist ();//=================================================================================================
//
// uf_calc_ratiolist
//
// Berechnet die Auftragsmenge einer Ratiolist
//
//=================================================================================================
//
// 02.09.04	Umstellung auf Datastore
// 03.03.06 Ratiolist-Suche erweitert
// 01.06.12 UK Schalter "consider aircraft version by calculating the meals"
// 26.06.12 Bugfix UK Schalter "consider aircraft version by calculating the meals"
// 08.11.12 Gunnar Brosch: QuantityVersion eingebaut
//=================================================================================================
long			lresult
long 			lQuantity
long			lfrom_pax, lto_pax
datetime		dtDate
long			lFind_cache
long			lFind_cache_ver	; // 08.11.12 Gunnar Brosch: QuantityVersion eingebaut
long			lFind_ratiolist
long			lFind_rl_typ1
long			lRows
string			sRatioText
string			sFind
Integer		iMAX_LOAD_VERSION
// 08.11.12, Gunnar Brosch: da hier in bestimmten F$$HEX1$$e400$$ENDHEX$$llen rausgesprungen wird, muss die Steuerung umgeschrieben werden :-(
boolean		lb_calcbasis_fertig = false;
boolean		lb_calcbasis_ver_fertig = false;

uf_trace(50,"uf_calc_ratiolist(): start")

//
// Zugriff auf Ratio-Cache m$$HEX1$$f600$$ENDHEX$$glich?
//
if isvalid(dsRatioCache) then
	if dsRatioCache.RowCount() > 0 then
		
		lFind_cache = dsRatioCache.Find("nratiolist_key = " + string(lcalcdetailkey) + " and nfrom_pax <= " + string(lCalcBasis) + &
												" and nto_pax >= " + string(lCalcBasis),1,dsRatioCache.RowCount())
		if lFind_cache > 0 then
			lResult					= dsRatioCache.GetItemNumber(lFind_cache,"nquantity")
			dcQuantity 				= lResult
			uf_trace(50,"uf_calc_ratiolist(): Ratio-Cache access succeeded!")
	
			// -------------------------------------------------------------------------------------------------
			// "Adding a tag on Ratio List header: consider aircraft version by calculating the meals"
			// "Meal calculation then will check, if the calculated quantity is higher than version capacity. 
			// If so, the quantity will be adjusted to aircraft version."
			// -------------------------------------------------------------------------------------------------
			// NMAX_LOAD_VERSION
			iMAX_LOAD_VERSION = dsRatioCache.GetItemNumber(lFind_cache,"NMAX_LOAD_VERSION")
			
			If iMAX_LOAD_VERSION = 1 Then
				If dcQuantity > iVersion Then
					dcQuantity = iVersion
					// 08.11.12, Gunnar Brosch: wir d$$HEX1$$fc00$$ENDHEX$$rfen hier nicht einfach raus, sonst kann ich die Variation nicht berechnen!!!>>>
					//return iVersion					
					//<<<
				End If
			End If
	
			// 08.11.12, Gunnar Brosch: wir d$$HEX1$$fc00$$ENDHEX$$rfen hier nicht einfach raus, sonst kann ich die Variation nicht berechnen!!!>>>
			//return lResult
			lb_calcbasis_fertig = true;
			//<<<			
		end if // lFind_cache > 0
		
		// 08.11.12, Gunnar Brosch: Jetzt dergleichen f$$HEX1$$fc00$$ENDHEX$$r die Variation >>>
		lFind_cache_ver = dsRatioCache.Find("nratiolist_key = " + string(lcalcdetailkey) + " and nfrom_pax <= " + string(il_calcbasis_ver) + &
												" and nto_pax >= " + string(il_calcbasis_ver),1,dsRatioCache.RowCount())
		if lFind_cache_ver > 0 then
			lResult				= dsRatioCache.GetItemNumber(lFind_cache_ver,"nquantity")
			idc_quantity_ver	= lResult
			uf_trace(50,"uf_calc_ratiolist(): Ratio-Cache access succeeded!")
	
			// -------------------------------------------------------------------------------------------------
			// "Adding a tag on Ratio List header: consider aircraft version by calculating the meals"
			// "Meal calculation then will check, if the calculated quantity is higher than version capacity. 
			// If so, the quantity will be adjusted to aircraft version."
			// -------------------------------------------------------------------------------------------------
			// NMAX_LOAD_VERSION
			iMAX_LOAD_VERSION = dsRatioCache.GetItemNumber(lFind_cache_ver,"NMAX_LOAD_VERSION")
			
			If iMAX_LOAD_VERSION = 1 Then
				If idc_quantity_ver > iVersion Then
					idc_quantity_ver = iVersion
					// 08.11.12, Gunnar Brosch: wir d$$HEX1$$fc00$$ENDHEX$$rfen hier nicht einfach raus, sonst kann ich die Variation nicht berechnen!!!>>>
					//return iVersion					
					//<<<
				End If
			End If
	
			// 08.11.12, Gunnar Brosch: wir d$$HEX1$$fc00$$ENDHEX$$rfen hier nicht einfach raus, sonst kann ich die Variation nicht berechnen!!!>>>
			//return lResult
			lb_calcbasis_ver_fertig = true;
			//<<<			
		end if // lFind_cache_ver > 0		
		//<<<
		
	end if // dsRatioCache.RowCount() > 0
end if //isvalid(dsRatioCache)

// 08.11.12, Gunnar Brosch:  Dies nur machen, wenn lb_calcbasis_fertig = false oder lb_calcbasis_ver = false>>>>>>>>>>>>>	
if lb_calcbasis_fertig = false or lb_calcbasis_ver_fertig = false then	// 08.11.12, Gunnar Brosch: neu eingef$$HEX1$$fc00$$ENDHEX$$gt
lRows = dsRatiolistTyp1.Retrieve(lcalcdetailkey,dgenerationdate)
//
// 20.04.2005: Falls gar nichts da ist
//
if lRows = 0 then
	uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition! Try to search again...")
	if dsFindRatiolist.RowCount() = 0 then
		dsFindRatiolist.Retrieve()
	end if
	lFind_ratiolist = dsFindRatiolist.Find("nratiolist_key = " + string(lcalcdetailkey), 1, dsFindRatiolist.RowCount())
	if lFind_ratiolist > 0 then
		sRatioText = dsFindRatiolist.GetItemString(lFind_ratiolist, "ctext")
//		lFind = dsFindRatiolist.Find("ctext = '" + sRatioText + &
//					"' and string(dvalid_from,'dd.mm.yyyy') = '" + string(dgenerationdate,"dd.mm.yyyy") + "'", 1, dsFindRatiolist.RowCount())
		//
		// 07.10.2005: Airline bei der Suche ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		//
//		sFind = "ctext = '" + sRatioText + &
//					"' and string(dvalid_from,'dd.mm.yyyy') = '" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"' and ncustomer_key = " + string(lAirlineKey)
//		sFind = "ctext = '" + sRatioText + &
//					"' and date(dvalid_from) <= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and date(dvalid_to) >= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and ncustomer_key = " + string(lAirlineKey)

// 22.06.2010 HR:

//		sFind = "ctext = '" + sRatioText + &
//					"' and date(string(dvalid_from,'dd.mm.yyyy')) <= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and date(string(dvalid_to,'dd.mm.yyyy')) >= date('" + string(dgenerationdate,"dd.mm.yyyy") + &
//					"') and ncustomer_key = " + string(lAirlineKey)
//
					
		sFind = "ctext = '" + sRatioText + &
					"' and date(string(dvalid_from,'yyyy-mm-dd')) <= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and date(string(dvalid_to,'yyyy-mm-dd')) >= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and ncustomer_key = " + string(lAirlineKey)
					
//					yyyy-mm-dd
					
		lFind_ratiolist = dsFindRatiolist.Find(sFind, 1, dsFindRatiolist.RowCount())
		if lFind_ratiolist > 0 then
			lcalcdetailkey = dsFindRatiolist.GetItemNumber(lFind_ratiolist,"nratiolist_key")
			
			// NMAX_LOAD_VERSION
			iMAX_LOAD_VERSION = dsFindRatiolist.GetItemNumber(lFind_ratiolist, "NMAX_LOAD_VERSION")
			
			lRows = dsRatiolistTyp1.Retrieve(lcalcdetailkey,dgenerationdate)
			uf_trace(1,"uf_calc_ratiolist(): Found new key for Ratiolist Definition!")
		else
			uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition!!!")
			//
			// urspr. Packinglist bleibt erhalten!
			//
			lResult = 0
			
			// 08.11.12, Gunnar Brosch: jetzt abfragen f$$HEX1$$fc00$$ENDHEX$$r wen...
			if not lb_calcbasis_fertig then
				dcQuantity = lResult
				lb_calcbasis_fertig = true;
			end if
			if not lb_calcbasis_ver_fertig then
				idc_quantity_ver = lResult
				lb_calcbasis_ver_fertig = true;
			end if
			
			//08.11.12, Gunnar Brosch: abgeklemmt >>>
			//return lResult
			//<<<
		end if
	end if
end if //if lRows = 0
end if //if lb_calcbasis_fertig = false or lb_calcbasis_ver = false

// 08.11.12, Gunnar Brosch: weiter mit dem Rest >>>********************************************
if not lb_calcbasis_fertig then
lFind_rl_typ1 = dsRatiolistTyp1.Find("nfrom_pax <= " + string(lCalcBasis) + &
										" and nto_pax >= " + string(lCalcBasis),1,dsRatiolistTyp1.RowCount())
if lFind_rl_typ1 > 0 then
	lResult					= dsRatiolistTyp1.GetItemNumber(lFind_rl_typ1,"nquantity")
	dcQuantity 				= lResult
	
	// NMAX_LOAD_VERSION
	iMAX_LOAD_VERSION = dsRatiolistTyp1.GetItemNumber(lFind_rl_typ1, "NMAX_LOAD_VERSION")
	
else
	lResult					= 0
	dcQuantity 				= 0
end if

//
// Falls gar nichts da ist
//
if dsRatiolistTyp1.RowCount() = 0 then
	uf_trace(50,"uf_calc_ratiolist(): dsRatiolistTyp1.RowCount() = 0, lcalcdetailkey = " + string(lcalcdetailkey))
	uf_trace(50,"uf_calc_ratiolist(): end")
	lResult = 0	
	
// 08.11.12, Gunnar Brosch: jetzt mit else-Zweig	>>>
	dcQuantity = lResult;	//08.11.12, Gunnar Brosch: hunzugef$$HEX1$$fc00$$ENDHEX$$gt
	//return lResult
//end if
else
//<<<

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
	if dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nto_pax") < lCalcBasis then
		lResult					= dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nquantity")
		dcQuantity 				= lResult
	end if

end if // 08.11.12, Gunnar Brosch: jetzt mit else-Zweig

// -------------------------------------------------------------------------------------------------
// "Adding a tag on Ratio List header: consider aircraft version by calculating the meals"
// "Meal calculation then will check, if the calculated quantity is higher than version capacity. 
// If so, the quantity will be adjusted to aircraft version."
// -------------------------------------------------------------------------------------------------
If iMAX_LOAD_VERSION = 1 Then
	If dcQuantity > iVersion Then
		dcQuantity = iVersion
	End If
End If
end if // 08.11.12, Gunnar Brosch: weiter mit dem Rest <<<********************************************

// 08.11.12, Gunnar Brosch: weiter mit dem Rest >>>********************************************
if not lb_calcbasis_ver_fertig then
lFind_rl_typ1 = dsRatiolistTyp1.Find("nfrom_pax <= " + string(il_calcbasis_ver) + &
										" and nto_pax >= " + string(il_calcbasis_ver),1,dsRatiolistTyp1.RowCount())
if lFind_rl_typ1 > 0 then
	lResult					= dsRatiolistTyp1.GetItemNumber(lFind_rl_typ1,"nquantity")
	idc_quantity_ver		= lResult
	
	// NMAX_LOAD_VERSION
	iMAX_LOAD_VERSION = dsRatiolistTyp1.GetItemNumber(lFind_rl_typ1, "NMAX_LOAD_VERSION")
	
else
	lResult					= 0
	idc_quantity_ver		= 0
end if

//
// Falls gar nichts da ist
//
if dsRatiolistTyp1.RowCount() = 0 then
	uf_trace(50,"uf_calc_ratiolist(): dsRatiolistTyp1.RowCount() = 0, lcalcdetailkey = " + string(lcalcdetailkey))
	uf_trace(50,"uf_calc_ratiolist(): end")
	lResult = 0	
	
// 08.11.12, Gunnar Brosch: jetzt mit else-Zweig	>>>
	idc_quantity_ver = lResult;	//08.11.12, Gunnar Brosch: hunzugef$$HEX1$$fc00$$ENDHEX$$gt
	//return lResult
//end if
else
//<<<

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
	if dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nto_pax") < il_calcbasis_ver then
		lResult					= dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nquantity")
		idc_quantity_ver		= lResult
	end if

end if // 08.11.12, Gunnar Brosch: jetzt mit else-Zweig

// -------------------------------------------------------------------------------------------------
// "Adding a tag on Ratio List header: consider aircraft version by calculating the meals"
// "Meal calculation then will check, if the calculated quantity is higher than version capacity. 
// If so, the quantity will be adjusted to aircraft version."
// -------------------------------------------------------------------------------------------------
If iMAX_LOAD_VERSION = 1 Then
	If idc_quantity_ver > iVersion Then
		idc_quantity_ver = iVersion
	End If
End If
end if // 08.11.12, Gunnar Brosch: weiter mit dem Rest <<<********************************************


uf_trace(50,"uf_calc_ratiolist(): end")

// 18.04.2013 HR: Wir geben hier die Menge f$$HEX1$$fc00$$ENDHEX$$r die Zeitungsbeladung zur$$HEX1$$fc00$$ENDHEX$$ck
//return lResult
return dcQuantity

end function

public function integer uf_start_change_on_cen_out_old ();//=================================================================================================
//
// uf_start_change_on_cen_out_old
//
// (vor $$HEX1$$c400$$ENDHEX$$nderung vom 05.10.2004)
//
// F$$HEX1$$fc00$$ENDHEX$$hrt eine Mahlzeitenkalkulation auf Basis der generierten Daten aus.
// (Geeignet f$$HEX1$$fc00$$ENDHEX$$r Option "Tausche keine Mahlzeiten", wenn sich aber die Passagierzahl ver$$HEX1$$e400$$ENDHEX$$ndert)
//
//=================================================================================================
//
// Verarbeitung einer Ver$$HEX1$$e400$$ENDHEX$$nderung von Passagierzahlen
//
// Wichtig: 
// Vor dem Nutzen dieser Methode ist der Datasource von dsCenOutMeals
// und dsCenOutMealsOld zu tauschen (Methode uf_switch_datasource)!!!
//
//=================================================================================================
/*

Nicht vergessen:
================
*/
long		i, j, lRow, lFind
long		lSequence
datetime	dtTimeStamp

bInChange	= true

//
//	dsCenOutMealsOld enth$$HEX1$$e400$$ENDHEX$$lt die vorhandenen Mahlzeiten
//
if dsCenOutMealsOld.RowCount() = 0 then
	sErrortext = "Meal Calculation got no information about prior meals!"
	return -1
end if
	
//
// Check Properties
//
if lResultKey = 0 or isnull(lResultKey) then
	sErrortext = "Meal Calculation got no valid result key!"
	return -1
end if

if lAircraftKey = 0 or isnull(lAircraftKey) then
	sErrortext = "Meal Calculation got no aircraft related information!"
	return -1
end if

if dsCenOutPax.RowCount() = 0 then
	//
	// In dsCenOutPax stehen doch tats$$HEX1$$e400$$ENDHEX$$chlich die Pax-Zahlen aller Fl$$HEX1$$fc00$$ENDHEX$$ge(!)
	//
	sErrortext = "Meal Calculation got no pax information!"
	return -1
end if


//
// $$HEX1$$dc00$$ENDHEX$$bertrag 
//
dsCenOutMealsOld.RowsCopy(1,dsCenOutMealsOld.RowCount(),Primary!,dsCenOutMeals,dsCenOutMeals.RowCount() + 1,Primary!)


//
// Mahlzeitenbeladung aufgrund vorheriger Beladung neu zusammenstellen
// (Abl$$HEX1$$f600$$ENDHEX$$sung uf_compile)
// 
for i = 1 to dsCenOutMeals.RowCount()
	//--------------------------------------------------------------------------------
	//
	// Es sind lediglich Mengen neu zu berechnen, 
	// auf keinen Fall ist irgendetwas aus dem Stammdaten zu holen
	//
	//--------------------------------------------------------------------------------
	iComponentGroup	= dsCenOutMeals.GetItemNumber(i,"ncomponent_group")
	lRotationNameKey	= dsCenOutMeals.GetItemNumber(i,"nrotation_name_key")
	lMealsDetailPrio	= dsCenOutMeals.GetItemNumber(i,"nprio")
	lClassNumber		= dsCenOutMeals.GetItemNumber(i,"nclass_number")
	lCalcID		 		= dsCenOutMeals.GetItemNumber(i,"ncalc_id")
	lCalcDetailKey		= dsCenOutMeals.GetItemNumber(i,"ncalc_detail_key")
	lReserveQuantity	= dsCenOutMeals.GetItemNumber(i,"nreserve_quantity")
	lTopOffQuantity	= dsCenOutMeals.GetItemNumber(i,"ntopoff_quantity")
	iReserveType		= dsCenOutMeals.GetItemNumber(i,"nreserve_type")
	iTopOffType			= dsCenOutMeals.GetItemNumber(i,"ntopoff_type")
	iModuleType			= dsCenOutMeals.GetItemNumber(i,"nmodule_type")
	iAsk4Passenger		= dsCenOutMeals.GetItemNumber(i,"nask4passenger")
	iPassengerGroup	= dsCenOutMeals.GetItemNumber(i,"npassenger_group")
	sQuestionText		= dsCenOutMeals.GetItemString(i,"cquestion_text")
	iBillingStatus		= dsCenOutMeals.GetItemNumber(i,"nbilling_status")
	iPercentage			= dsCenOutMeals.GetItemNumber(i,"npercentage")
	dcValue				= dsCenOutMeals.GetItemDecimal(i,"nvalue")
	iSPMLDeduction		= dsCenOutMeals.GetItemNumber(i,"nspml_deduction")
	iACTransfer			= dsCenOutMeals.GetItemNumber(i,"nac_transfer")

	//--------------------------------------------------------------------------------
	//
	// Berechnung der neuen Auftragsmengen
	//
	//--------------------------------------------------------------------------------
	lFind = dsCenOutPax.find("nresult_key = " + string(lresultkey) + " and nclass_number = " + string(lClassNumber),1,dsCenOutPax.RowCount())
	if lFind <= 0 then
		sErrortext = "No passenger information found"
		return -1
	end if
	
	lPax 		= dsCenOutPax.GetItemNumber(lFind,"npax")
	sClass	= dsCenOutPax.GetItemString(lFind,"cclass")
	iVersion	= dsCenOutPax.GetItemNumber(lFind,"nversion")
	
	//
	// Change-Gesch$$HEX1$$e400$$ENDHEX$$ft:
	// lPaxManual befindet sich auf Zeilenebene
	// Reserve- und TopOffMengen k$$HEX1$$f600$$ENDHEX$$nnten ge$$HEX1$$e400$$ENDHEX$$ndert worden sein
	//
	lPaxManual = uf_get_pax_manual()

	//
	// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Ausz$$HEX1$$e400$$ENDHEX$$hlung angesagt ist ($$HEX1$$fc00$$ENDHEX$$berschreibt dann die lPax)
	//
	uf_ask4passenger()
	
	//
	// Ermittlung der Berechnungsgrundlage lCalcBasis
	//
	uf_get_calc_basis()
	
	//
	// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob eine $$HEX1$$dc00$$ENDHEX$$berbeladung verrechnet werden soll
	//
	uf_check_overload()
	
	
	//
	// uf_calc_funktionen k$$HEX1$$f600$$ENDHEX$$nnen nicht verwendet werden, da sie Daten aus dsCenMeals holen
	// => dsCenMeals simulieren
	//
	lRow = dsCenMeals.InsertRow(0)
	dsCenMeals.SetItem(lRow,"cen_meals_detail_ncomponent_group",	iComponentGroup)
	dsCenMeals.SetItem(lRow,"nrotation_name_key",						lRotationNameKey)
	dsCenMeals.SetItem(lRow,"cen_meals_detail_nprio",					lMealsDetailPrio)
	dsCenMeals.SetItem(lRow,"cen_meals_detail_npercentage",			iPercentage)
	
	lCurrentRow	= lRow
	
	//
	// Berechnung
	//
	choose case lCalcID
		case 1
			//
			// Feste Menge
			//
			dcQuantity = dcValue
		case 2
			//
			// 100% f$$HEX1$$fc00$$ENDHEX$$r Klasse
			//
			dcQuantity = iVersion
		case 3
			//
			// Ratiolist
			//
			uf_calc_ratiolist()
		case 4
			//
			// Normal
			//
			dcQuantity = lCalcBasis
		case 5
			//
			// Prozent
			//
			uf_calc_percent(0)
		case 6
			//
			// Prozent kfm.
			//
			uf_calc_percent_com()
		case 7
			//
			// Vielfaches
			//
			uf_calc_multiple()
		case 8
			//
			// Ganzzahliges
			//
			uf_calc_integer()
		case 9, 10
			//
			// Bosta-Plus
			//
			uf_calc_bosta_plus()
		case 11,12
			//
			// Bosta-Minus
			//
			uf_calc_bosta_minus()
		case 13
			//
			// Prozent-Vielfach
			//
			uf_calc_percent_multiple()
		case 14
			//
			// Prozent absolut
			//
			uf_calc_percent_abs()
		case 15, 16, 17
			//
			// Gesamtpassagierzahl
			//
			uf_calc_booking_classes()
		case 18
			//
			// St$$HEX1$$fc00$$ENDHEX$$cklisten Ratiolist
			//
			uf_calc_ratiolist2()
		case 19
			//
			// Differenz zu Full-House
			//
			uf_calc_difference_fullhouse()
		case else
			//
			// Im Zweifel immer 1:1
			//
			dcQuantity = lCalcBasis
	end choose
	
	
	
	//--------------------------------------------------------------------------------
	//
	// Neue Werte eintragen
	//
	//--------------------------------------------------------------------------------
	dtTimeStamp = datetime(today(),now())
	
	lSequence = f_Sequence("seq_cen_out_meals", sqlca)
	// -----------------------------------------
	// liefert -1 bei Fehler
	// -----------------------------------------
	If lSequence = -1 Then
		return -1
	end if
	
	dsCenOutMeals.SetItem(i,"ndetail_key",					lSequence)
	dsCenOutMeals.SetItem(i,"dtimestamp",					dtTimeStamp)
	dsCenOutMeals.SetItem(i,"nquantity",					dcQuantity)
	dsCenOutMeals.SetItem(i,"nquantity_old",				dcOldQuantity)
	dsCenOutMeals.SetItem(i,"ncalc_basis",					lCalcBasis)	// Berechnungsgrundlage speichern
	dsCenOutMeals.SetItem(i,"npax",							lPax)
	dsCenOutMeals.SetItem(i,"npax_manual",					lPaxManual)
	dsCenOutMeals.SetItem(i,"noverload",lOverloadSet)		// $$HEX1$$dc00$$ENDHEX$$berbeladung aus Prozentberechnung, wird nur temp. im Datastore gespeichert
	dsCenOutMeals.SetItem(i,"noverload_version",lOverloadSet_ver)	//3011.2012, Gunnar Brosch
	
	if iStatus > 0 and iStatus < 8 then
		for j = iStatus to 7 
			dsCenOutMeals.SetItem(j,"nquantity" + string(j),dcQuantity)
		next
	end if
	
	if bInChange then
		//
		// Change-Modus hat mehr Felder im Datasource
		//
		dsCenOutMeals.SetItem(i,"status_nreserve_quantity",0)
		dsCenOutMeals.SetItem(i,"status_ntopoff_quantity",0)
	
	end if
	
next

//
// Vergleich alt <-> neu
//
uf_compare_new_old()



return 0

end function

public function integer uf_calc_percent_abs_minus ();//=================================================================================================
//
// uf_calc_percent_abs_minus
//
// Berechnet Prozent minus absoluten Wert
//							-----
//=================================================================================================
long lValue
long lResult

lValue = ceiling(lCalcBasis * iPercentage / 100)	// Prozentwert

lResult = lValue - dcValue
if lResult < 0 then lResult = 0

dcQuantity = lResult

return 0

end function

public function integer uf_calc_multiple_m ();//=================================================================================================
//
// uf_calc_multiple_m
//
// Berechnet Vielfaches m-fach
//
// Alle n Passagiere Menge m beladen, iPercentage wird als n interpretiert!
//
// 07.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long lResult
long lResult_ver; // 07.11.12, Gunnar Brosch: QuantityVersion

//
// dcValue: 		Feld Menge wird als Menge interpretiert
//	iPercentage:	Feld % wird als Passagierzahl interpretiert
//
if iPercentage = 0 then iPercentage = 1
lResult = truncate(lCalcBasis / iPercentage, 0)			// Vielfaches
lResult_ver = truncate(il_calcbasis_ver / iPercentage, 0); // 07.11.12, Gunnar Brosch: QuantityVersion


If Mod(lCalcBasis, iPercentage) > 0 then lResult++					// Falls Rest aus Division, dann bis zum n$$HEX1$$e400$$ENDHEX$$chsten Schritt
if mod(il_calcbasis_ver, iPercentage) > 0 then lResult_ver++	;	// 07.11.12, Gunnar Brosch: QuantityVersion															

dcQuantity = lResult * dcValue					// m mal Result
idc_quantity_ver = lResult_ver * dcValue; 	// 07.11.12, Gunnar Brosch: QuantityVersion

return 0

end function

public function integer uf_calc_percent_zero ();//=================================================================================================
//
// uf_calc_percent_zero
//
// Prozentberechnung mit LH Rundung, 0 Mengen m$$HEX1$$f600$$ENDHEX$$glich
//
// 07.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long		i
long		lFind

integer	iPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents			// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter			// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	li_MealCounter_ver;	// 07.11.12, Gunnar Brosch: QuantityVersion
decimal	dcResult
decimal	dcResult_ver; 			// 07.11.12, Gunnar Brosch: QuantityVersion

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version") ; // 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )

dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()
iComponents = dscenmeals.RowCount()

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i, "cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	if mod(i,2) = 1 then
		//
		// ungerade Werte aufrunden
		//
		//dcResult		= round( (((lCalcBasis * iPerc)/100) + 0.5),0) // evtl. mu$$HEX2$$df002000$$ENDHEX$$nichts dazugez$$HEX1$$e400$$ENDHEX$$hlt werden
		dcResult		= ceiling((lCalcBasis * iPerc)/100)
		dcResult_ver= ceiling((il_calcbasis_ver * iPerc)/100); 				// 07.11.12, Gunnar Brosch: QuantityVersion
		
	else
		dcResult		= truncate( ((lCalcBasis * iPerc)/100) ,0)
		if dcResult < 1 then dcResult = 0

		dcResult_ver= truncate( ((il_calcbasis_ver * iPerc)/100) ,0);		// 07.11.12, Gunnar Brosch: QuantityVersion
		if dcResult_ver < 1 then dcResult_ver = 0;							// 07.11.12, Gunnar Brosch: QuantityVersion
		
	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	iMealCounter += dcResult
	
	dscenmeals.SetItem(i,"nquantity_version", dcResult_ver);					// 07.11.12, Gunnar Brosch: QuantityVersion
	li_MealCounter_ver += dcResult_ver;										// 07.11.12, Gunnar Brosch: QuantityVersion
	
next

// 07.11.12, Gunnar Brosch: QuantityVersion: Nach hinten verschieben *******************>>>>>>>>>>>>>>>>>>>>
/*
//
// Bei CalcBasis = 0: raus hier
//
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
end if
*/
// 07.11.12, Gunnar Brosch: QuantityVersion: Nach hinten verschieben *******************<<<<<<<<<<<<<<<<<<<<<<

/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/
//f_print_datastore(dscenmeals)
//
// Check gegen Passagierzahl und Status setzen
//

// 07.11.12, Gunnar Brosch: QuantityVersion: Nur noch f$$HEX1$$fc00$$ENDHEX$$r  lCalcBasis > 0 *******************>>>>>>>>>>>>>>>>>>>>
if lCalcBasis > 0 then
if iMealCounter > lCalcBasis then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult > 1 then
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		//
		// Falls zu viel beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity")
			if dcResult >= 1 then
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult --
			iMealCounter --
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis  then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if

//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 
end if
// 07.11.12, Gunnar Brosch: QuantityVersion: Nur noch f$$HEX1$$fc00$$ENDHEX$$r  lCalcBasis > 0 *******************<<<<<<<<<<<<<<<<<

// 07.11.12, Gunnar Brosch: QuantityVersion: F$$HEX1$$fc00$$ENDHEX$$r  il_calcbasis_ver > 0 *******************>>>>>>>>>>>>>>>>>>>>
if il_calcbasis_ver > 0 then
if li_MealCounter_ver > il_calcbasis_ver then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and li_MealCounter_ver > il_calcbasis_ver and li_MealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult_ver > 1 then
				dcResult_ver --
				li_MealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and li_MealCounter_ver < il_calcbasis_ver then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			li_MealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		//
		// Falls zu viel beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and li_MealCounter_ver > il_calcbasis_ver then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version")
			if dcResult_ver >= 1 then
				dcResult_ver --
				li_MealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and li_MealCounter_ver > il_calcbasis_ver and li_MealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver --
			li_MealCounter_ver --
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and li_MealCounter_ver < il_calcbasis_ver  then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			li_MealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if

//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet_ver = li_Mealcounter_ver - il_calcbasis_ver;
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 
end if
// 07.11.12, Gunnar Brosch: QuantityVersion: F$$HEX1$$fc00$$ENDHEX$$r  il_calcbasis_ver > 0 *******************<<<<<<<<<<<<<<<<<<<<<<

// 07.11.12, Gunnar Brosch: QuantityVersion: Verarbeitung der Nullmengen nach hinten verlegt...
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
end if

if il_calcbasis_ver = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0;
end if

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_ask4passenger_old ();//=================================================================================================
//
// uf_ask4passenger (Sicherung): dsCenOutMealsOld war immer leer
//
// Nachfragen, ob ein Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog ge$$HEX1$$f600$$ENDHEX$$ffnet werden soll.
// Wird $$HEX1$$fc00$$ENDHEX$$brigens f$$HEX1$$fc00$$ENDHEX$$r jede Zeile angesprungen.
//
//=================================================================================================
//
// Im Dialogbetrieb ist ein Fenster zu $$HEX1$$f600$$ENDHEX$$ffnen,
// bei der Generierung sind Annahmen bzgl. der erwarteten Pax-Zahl zu treffen.
//
//=================================================================================================
long		lFind, lFind2
string	sFind
long		lOldValue
long		lCnt

//
// Generierung l$$HEX1$$e400$$ENDHEX$$uft
//
if bInGeneration then
	if iAsk4Passenger = 1 then
		if iPlanningPercent > 0 then
			lPaxManual = Int((lPaxManual * iPlanningPercent / 100) + 0.5)
		end if
	end if
end if

//
// Dialog-Betrieb
//
if bInChange and iAsk4Passenger = 1 then
	//
	// Neu: nur dann $$HEX1$$f600$$ENDHEX$$ffnen, wenn auch wirklich in der entsprechenden Klasse ge$$HEX1$$e400$$ENDHEX$$ndert wurde
	// dsCenOutPax.status_npax
	//
	lFind = dsCenOutPax.Find("status_npax = 1 and nclass_number = " + string(lClassNumber),1,dsCenOutPax.RowCount())
	if lFind > 0 then
		// (ab hier: alte Verarbeitung)
		// Innerhalb einer Mahlzeitenkomponente soll Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog nicht mehrfach $$HEX1$$f600$$ENDHEX$$ffnen
		//
		if bNextMeal and iAsk4Passenger = 1 then
			// vorher: s_pax_counts.lvalue 			= lPaxManual
			lOldValue = 0
			//
			// jetzt: Finden der korrekten Menge npax_manual in dsCenOutMealsOld
			//
			sFind = "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
						string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
			lFind2 = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
			if lFind2 > 0 then
				s_pax_counts.lvalue 			= dsCenOutMealsOld.GetItemNumber(lFind2,"npax_manual")
				lOldValue = s_pax_counts.lvalue
			else
				s_pax_counts.lvalue 			= lPaxManual
			end if
			//
			// Ausz$$HEX1$$e400$$ENDHEX$$hlfenster nur noch $$HEX1$$f600$$ENDHEX$$ffnen, wenn auch tats. Menge ge$$HEX1$$e400$$ENDHEX$$ndert
			//
			s_pax_counts.sdescription 	= sQuestionText
			
			if lOldValue <> lPaxManual then
				OpenWithParm(w_meal_pax_counts, s_pax_counts)
				s_pax_counts = Message.PowerObjectParm
			end if
		end if
		//
		// Wert der Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$f600$$ENDHEX$$ffnen
		//
		if iAsk4Passenger = 1 then
			if s_pax_counts.bsuccessful then
				//
				// setzen der neuen Eingaben
				//
				lPaxManual = s_pax_counts.lvalue
			end if
		end if
	else
		//
		// falls Klasse nicht ver$$HEX1$$e400$$ENDHEX$$ndert wurde, dann letzte Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$fc00$$ENDHEX$$bernehmen
		//
		// Wo steht die?	dsCenOutMealsOld.npax
		//						dw_change_cen_out_meals
		//	cmeal_control_code?
		lCnt = dsCenOutMealsOld.RowCount()
		sFind = "nhandling_key = " + string(lHandlingKey) + " and nhandling_meal_key = " + &
					string(lMasterKey) + " and nclass_number = " + string(lClassNumber)
		lFind2 = dsCenOutMealsOld.Find(sFind,1,dsCenOutMealsOld.RowCount())
		if lFind2 > 0 then
			//
			// alter Wert einsetzen
			// Problem: Falls noch von Generierung gef$$HEX1$$fc00$$ENDHEX$$llt, dann sind die 
			//				Planungsprozente ber$$HEX1$$fc00$$ENDHEX$$cksichtigt. Ein $$HEX1$$dc00$$ENDHEX$$bertrag $$HEX1$$fc00$$ENDHEX$$bertr$$HEX1$$e400$$ENDHEX$$gt die 100!
			// ncalc_basis ist falsch, da hier die topoff noch dazu kommen
			//	npax_manual w$$HEX1$$e400$$ENDHEX$$re ok, wird allerdings bei der Generierung falsch gesetzt
			// lPaxManual = dsCenOutMealsOld.GetItemNumber(lFind2,"npax")
			lPaxManual = dsCenOutMealsOld.GetItemNumber(lFind2,"npax_manual")
		else
			//
			// nichts gefunden, dann halt nochmal ausz$$HEX1$$e400$$ENDHEX$$hlen
			//
			if bNextMeal and iAsk4Passenger = 1 then
				s_pax_counts.lvalue 			= lPaxManual
				s_pax_counts.sdescription 	= sQuestionText
				
				OpenWithParm(w_meal_pax_counts, s_pax_counts)
				
				s_pax_counts = Message.PowerObjectParm
			end if
			//
			// Wert der Ausz$$HEX1$$e400$$ENDHEX$$hlung $$HEX1$$f600$$ENDHEX$$ffnen
			//
			if iAsk4Passenger = 1 then
				if s_pax_counts.bsuccessful then
					//
					// setzen der neuen Eingaben
					//
					lPaxManual = s_pax_counts.lvalue
				end if
			end if
		end if
	end if
end if

return 0

end function

public function long uf_get_booking_classes ();//=================================================================================================
//
// uf_get_booking_classes
//
// Berechnet die Gesamtpassagierzahl aller Buchungsklassen
// und gibt diese zur$$HEX1$$fc00$$ENDHEX$$ck
//
//=================================================================================================
long	i
long	iBookingClass
long	lResult
long	lValue
long	lValue_ver	//29.11.2012, g. Brosch

for i = 1 to dsCenOutPax.RowCount()
	lResult 			= dsCenOutPax.GetItemNumber(i,"nresult_key") 
	iBookingClass	= dsCenOutPax.GetItemNumber(i,"nbooking_class")
	//
	// Nur gebuchte Passagiere
	//
	if lResult = lresultkey and &
		iBookingClass = 1 then
		lValue += dsCenOutPax.GetItemNumber(i,"npax")
		lValue_ver += dsCenOutPax.GetItemNumber(i,"nversion")	//29.11.2012, g. Brosch
	end if
next

lCalcBasis = lValue					//29.11.2012, g. Brosch
il_calcbasis_ver = lValue_ver		//29.11.2012, g. Brosch

return lValue;



end function

public function long uf_get_booking_class_1_2 ();//=================================================================================================
//
// uf_get_booking_class_1_2
//
// Berechnet die Gesamtpassagierzahl der Buchungsklassen 1 und 2
// und gibt diese zur$$HEX1$$fc00$$ENDHEX$$ck
//
//=================================================================================================
long		i
long		lResult
long		lValue
long		lValue_ver	//29.11.2012, G. Brosch
integer	iBookingClass
integer	iClassNumber

for i = 1 to dsCenOutPax.RowCount()
	lResult 			= dsCenOutPax.GetItemNumber(i,"nresult_key") 
	iBookingClass	= dsCenOutPax.GetItemNumber(i,"nbooking_class")
	iClassNumber	= dsCenOutPax.GetItemNumber(i,"nclass_number")
	//
	// Nur gebuchte Passagiere
	//
	if lResult = lresultkey and &
		iBookingClass = 1 and &
		(iClassNumber = 1 or iClassNumber = 2 ) then
		lValue += dsCenOutPax.GetItemNumber(i,"npax")
		lValue_ver += dsCenOutPax.GetItemNumber(i,"nversion")
	end if
next

lCalcBasis = lValue					//29.11.2012, g. Brosch
il_calcbasis_ver = lValue_ver		//29.11.2012, g. Brosch

return lValue

end function

public function integer uf_get_calc_basis_old ();//=================================================================================================
//
// uf_get_calc_basis (bis 21.07.2005)
//
// Ermittelt die Berechnungsgrundlage
//
//=================================================================================================
long	lPaxOriginal

//
// Original-Pax merken
//
lPaxOriginal = lPax

//
// Nicht vergessen:
// Alle manuellen Eingaben werden im Feld lPaxManual gespeichert!!!
// Damit schickt in der Operation lPaxManual den Wert von lPax aus dem Rennen.
// lPaxManual kann aber auch 0 sein, deshalb hier nicht lPaxManual > 0 abfragen.
//
//if lPaxManual > 0 then
if iAsk4Passenger = 1 then
	lPax = lPaxManual	
end if

//
// Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = Reserve bis Sitzplatzversion
// 0 = immer Reserve
//
if iReserveType = 1 then
	if lPax + lReserveQuantity > iVersion then
		lCalcBasis = iVersion
	else
		lCalcBasis = lPax + lReserveQuantity
	end if
else
	lCalcBasis = lPax + lReserveQuantity
end if

//
// TopOff ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = TopOff bis Sitzplatzversion
// 0 = immer TopOff
//
if lPax > iVersion then
	//
	// Falls $$HEX1$$dc00$$ENDHEX$$berbucht wird, dann darf die TopOff-Regel nicht zu einer Reduktion f$$HEX1$$fc00$$ENDHEX$$hren
	//
	lCalcBasis = lPax
else
	if iTopOffType = 0 then
		lCalcBasis = lCalcBasis + lTopOffQuantity
	else
		if lCalcBasis + lTopOffQuantity > iVersion then
			lCalcBasis = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
		else
			lCalcBasis = lCalcBasis + lTopOffQuantity
		end if
	end if
end if
//
// Original-Pax wiederherstellen
//
lPax = lPaxOriginal

return 0

end function

public function integer uf_get_calc_basis ();//=================================================================================================
//
// uf_get_calc_basis (ab 21.07.2005)
//
// Ermittelt die Berechnungsgrundlage
//
// 20.07.2005
// Erweiterung der TopOff- und Reservetypen:
// 0 = immer Reserve
// 1 = Reserve bis Sitzplatzversion
// 2 = immer Reserve ab 1 Pax
// 3 = Reserve bis Sitzplatzversion ab 1 Pax
//
// 08.03.2006
// $$HEX1$$dc00$$ENDHEX$$berarbeitung: Topoff-Regel hat gegriffen trotz Topoff = 0
// Jetzt werden Regeln erst dann angesprungen, wenn Topoff- oder
// Reserve-Menge > 0 sind
//
// 16.11.12.	Gunnar Brosch, Angepasst mit Heiko Rothenbach f$$HEX1$$fc00$$ENDHEX$$r Quantity Version
// 30.10.13    O.Hoefer: A.Wenninger => bei non-booking class: calc Basis Version = PAX
//=================================================================================================
long	lPaxOriginal
long	lPaxVersion
string  ls_ouloadpro

//// --------------------------------------------------------------------------------------------------------------------
//// 23.09.2016 HR: CR CBASE-CCS-CR-2016-009: Over/Underloading Absolut oder %
//// --------------------------------------------------------------------------------------------------------------------
//if icmc_coverunderload > " " then
//	if right(icmc_coverunderload, 1)="%" then
//		ls_ouloadpro = trim(left(icmc_coverunderload, len(icmc_coverunderload) -1))
//		if isnumber(ls_ouloadpro) then
//			lPax = lPax	 + lPax * Integer(ls_ouloadpro) / 100
//		end if
//	elseif isnumber(icmc_coverunderload) then
//		lPax = lPax + Integer(icmc_coverunderload)
//	end if
//	
//	if lPax < 0 then lPax = 0 // 04.11.2016 HR: Keine negativen Paxe (issue #1770)
//	
//end if

// Original-Pax merken
lPaxOriginal = lPax
lPaxVersion = iVersion // 07.09.2016 HR: Wir merken uns die Version f$$HEX1$$fc00$$ENDHEX$$r die Mengenberechnung mir Version

// Nicht vergessen:
// Alle manuellen Eingaben werden im Feld lPaxManual gespeichert!!!
// Damit schickt in der Operation lPaxManual den Wert von lPax aus dem Rennen.
// lPaxManual kann aber auch 0 sein, deshalb hier nicht lPaxManual > 0 abfragen.
//
//if lPaxManual > 0 then
if iAsk4Passenger = 1 then
	// TBR 25.02.2009: Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung abweichender Beladung gem. Konzept
	IF ibo_concdiff THEN
		lPax = lPaxManualConcDiff	
	ELSE
		lPax = lPaxManual	
	END IF
	
	// 07.09.2016 HR: Bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog schauen wir das Verh$$HEX1$$e400$$ENDHEX$$ltnis Manuelle Menge zu Paxe und rechnen dies auf die Version hoch
	
	// 27.10.2016 OH: aus Flight Calc
	if IsNULL(lPaxOriginal) then lPaxOriginal = 0
	// 22.09.2016 HR: Division durch null abfangen
	if lPaxOriginal = 0 then
		lPaxVersion = 0
	else
		lPaxVersion = lPax * iVersion / lPaxOriginal 
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// 23.09.2016 HR: CR CBASE-CCS-CR-2016-009: Over/Underloading Absolut oder %
// 21.11.2016 HR: issue #1769: Nach der ggf durch Ask4Passagner ge$$HEX1$$e400$$ENDHEX$$nderte Menge durchf$$HEX1$$fc00$$ENDHEX$$hren
// --------------------------------------------------------------------------------------------------------------------
if icmc_coverunderload > " " then
	if right(icmc_coverunderload, 1)="%" then
		ls_ouloadpro = trim(left(icmc_coverunderload, len(icmc_coverunderload) -1))
		if isnumber(ls_ouloadpro) then
			lPax = lPax	 + lPax * Integer(ls_ouloadpro) / 100
		end if
	elseif isnumber(icmc_coverunderload) then
		lPax = lPax + Integer(icmc_coverunderload)
	end if
	
	if lPax < 0 then lPax = 0 // 04.11.2016 HR: Keine negativen Paxe (issue #1770)
	
end if
//
// Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = Reserve bis Sitzplatzversion
// 0 = immer Reserve
//
lCalcBasis = lPax
//il_calcbasis_ver = iVersion //HR 26.11.2012
il_calcbasis_ver = lPaxVersion //HR 07.09.2016

if iIgnoreReserve = 0 then
	if lReserveQuantity > 0 then
		if iReserveType = 0 then
			lCalcBasis = lPax + lReserveQuantity
			il_calcbasis_ver = il_calcbasis_ver+ lReserveQuantity
			
		elseif iReserveType = 1 then
			if lPax + lReserveQuantity > iVersion then
				lCalcBasis = iVersion
			else
				lCalcBasis = lPax + lReserveQuantity
			end if
			
			// 07.09.2016 HR: Da die calcbasis_vers jetzt auch kleiner Version sein kann, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir dies auch ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			if il_calcbasis_ver + lReserveQuantity > iVersion then
				il_calcbasis_ver = iVersion
			else
				il_calcbasis_ver = il_calcbasis_ver + lReserveQuantity
			end if
			
		elseif iReserveType = 2 then
			if lPax > 0 then
				lCalcBasis = lPax + lReserveQuantity
			else
				lCalcBasis = 0
			end if
			
			if il_calcbasis_ver > 0 then
				il_calcbasis_ver = il_calcbasis_ver + lReserveQuantity
			else
				il_calcbasis_ver = 0
			end if
			
		elseif iReserveType = 3 then
			if lPax > 0 then
				if lPax + lReserveQuantity > iVersion then
					lCalcBasis = iVersion
				else
					lCalcBasis = lPax + lReserveQuantity
				end if
				
			else
				lCalcBasis = 0
			end if
			
			if il_calcbasis_ver > 0 then
				if il_calcbasis_ver + lReserveQuantity > iVersion then
					il_calcbasis_ver = iVersion
				else
					il_calcbasis_ver = lPax + lReserveQuantity
				end if
				
			else
				il_calcbasis_ver = 0
			end if
			
		end if
	end if
end if
//
// TopOff ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = TopOff bis Sitzplatzversion
// 0 = immer TopOff
//
if lPax > iVersion then
	//
	// Falls $$HEX1$$dc00$$ENDHEX$$berbucht wird, dann darf die TopOff-Regel nicht zu einer Reduktion f$$HEX1$$fc00$$ENDHEX$$hren
	// Hier soll nicht gegen die Version gek$$HEX1$$fc00$$ENDHEX$$rzt werden!!!
	//
	lCalcBasis = lPax
else
	if iIgnoreTopOff = 0 then
		if lTopOffQuantity > 0 then
			if iTopOffType = 0 then
				lCalcBasis = lCalcBasis + lTopOffQuantity
			elseif iTopOffType = 1 then
				if lCalcBasis + lTopOffQuantity > iVersion then
					lCalcBasis = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
				else
					lCalcBasis = lCalcBasis + lTopOffQuantity
				end if
			elseif iTopOffType = 2 then
				if lPax > 0 then
					lCalcBasis = lCalcBasis + lTopOffQuantity
				else
					// 08.03. muss nicht sein, da TopOffQuantity = 0 ist
	//				lCalcBasis = 0
				end if
			elseif iTopOffType = 3 then
				if lPax > 0 then
					if lCalcBasis + lTopOffQuantity > iVersion then
						lCalcBasis = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
					else
						lCalcBasis = lCalcBasis + lTopOffQuantity
					end if
				end if
			end if
		end if
	end if
end if

if il_calcbasis_ver > iVersion then
	//
	// Falls $$HEX1$$dc00$$ENDHEX$$berbucht wird, dann darf die TopOff-Regel nicht zu einer Reduktion f$$HEX1$$fc00$$ENDHEX$$hren
	// Hier soll nicht gegen die Version gek$$HEX1$$fc00$$ENDHEX$$rzt werden!!!
	//
	il_calcbasis_ver = il_calcbasis_ver
else
	if iIgnoreTopOff = 0 then
		if lTopOffQuantity > 0 then
			if iTopOffType = 0 then
				il_calcbasis_ver += lTopOffQuantity 
			elseif iTopOffType = 1 then
				if il_calcbasis_ver + lTopOffQuantity > iVersion then
					il_calcbasis_ver = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
				else
					il_calcbasis_ver += lTopOffQuantity
				end if
			elseif iTopOffType = 2 then
				if il_calcbasis_ver > 0 then
					il_calcbasis_ver += lTopOffQuantity
				end if
			elseif iTopOffType = 3 then
				if il_calcbasis_ver > 0 then
					if il_calcbasis_ver + lTopOffQuantity > iVersion then
						il_calcbasis_ver = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
					else
						il_calcbasis_ver += lTopOffQuantity
					end if
				end if
			end if
		end if
	end if
end if


// --------------------------------------------------------------------------------------------------------------------
// 15.09.2010 HR: Falls es eine Menge aus den SKY-Tabellen gibt, dann
// diese verwenden
// --------------------------------------------------------------------------------------------------------------------
if il_SkyMealOrderQuantity<> -1  then
	lCalcBasis = il_SkyMealOrderQuantity
end if

//
// Original-Pax wiederherstellen
//
lPax = lPaxOriginal

return 0

end function

public function integer uf_set_spml_properties (long lrow);//============================================================================================
//
// uf_set_spml_properties 
//
// $$HEX1$$dc00$$ENDHEX$$berarbeitet am 23.08.2005, war uf_set_spml_properties_ok 
//
//============================================================================================
string		sFind, ls_find, ls_sub_new, ls_sub_ori
long		lFind, lFound

lSPMLHandlingKey			= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_nhandling_key")
dcSPMLQuantity			= dsSPMLDefinition.GetItemDecimal(lRow,"cen_spml_detail_nquantity")
//dcSPMLQuantity_old	= dsSPMLDefinition.GetItemDecimal(lRow,"")
lSPMLPrio					= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_nprio")
lSPMLPLIndexKey			= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_npackinglist_index_key")
//ersetzt:sSPMLPackingList		= uf_get_packinglist(lSPMLPLIndexKey)
sSPMLPackingList			= dsSPMLDefinition.GetItemString(lRow,"cen_packinglist_index_cpackinglist")
//ersetzt:sSPMLUnit				= uf_get_packinglist_unit(lSPMLPLIndexKey)
sSPMLUnit					= dsSPMLDefinition.GetItemString(lRow,"cen_packinglists_cunit")
sSPMLProductionText		= dsSPMLDefinition.GetItemString(lRow,"cen_spml_detail_cproduction_text")
//ersetzt:sSPMLHandlingText		= uf_get_handling_text(lSPMLHandlingKey)
sSPMLHandlingText		= dsSPMLDefinition.GetItemString(lRow,"cen_handling_ctext")
iSPMLBillingStatus			= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_nbilling_status")
iSPMLACTransfer			= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_nac_transfer")

lSPMLAccountKey			= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_naccount_key")
sSPMLAccount				= uf_get_account_code(lSPMLAccountKey)

if isnull(lSPMLAccountKey) or lSPMLAccountKey = 0 then
	lSPMLAccountKey		= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_ndefault_account_key")
	sSPMLAccount			= uf_get_account_code(lSPMLAccountKey)
end if

sSPMLAddAccountCode	= dsSPMLDefinition.GetItemString(lRow,"cen_spml_detail_cadditional_account")

//
// Berechnung der Menge
//
dcSPMLQuantity *= dcSPMLMasterQuantity

//
// Steuerung SPML-Abzug:	
//
//	lNumberOfSPML: Die Anzahl SPML einer Klasse, die Auswirkungen auf den Mahlzeitenabzug haben!
//
// iUseSPMLDeduction = 1	SPML wird bei der Ermittlung der Mahlzeiten ber$$HEX1$$fc00$$ENDHEX$$cksichtigt und f$$HEX1$$fc00$$ENDHEX$$hrt
//									somit zu einer Reduzierung der Komponenten, bei denen der Schalter
//									ndeduction = 1 gesetzt ist
//	iUseSPMLDeduction = 0	SPML wird On Top beladen und hat keine Auswirkungen auf die Komponenten
//									der Mahlzeit
//
// Neu: 	In wf_change_center wird zun$$HEX1$$e400$$ENDHEX$$chst grunds$$HEX1$$e400$$ENDHEX$$tzlich entschieden, ob ein SPML onTop beladen
//			wird. Das muss jetzt hier ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden.
//			Motto: Einmal OnTop, immer OnTop!
//
// 07.07.04: Wenn Anwender iTopOffSPML = 1 setzt, dann niemals SPML-Abzug
//
if iOnTopSPML = 1 then
	iUseSPMLDeduction		= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_ndeduction")
	if iUseSPMLDeduction = 1 then
		//
		// if lSPMLKey <> lSPMLKeyOld ist wichtig f$$HEX1$$fc00$$ENDHEX$$r den Gruppenwechsel,
		// sonst w$$HEX1$$fc00$$ENDHEX$$rde f$$HEX1$$fc00$$ENDHEX$$r jede SPML-Komponente lNumberOfSPML hochgez$$HEX1$$e400$$ENDHEX$$hlt,
		// was zu einem riesigen SPML-Abzug f$$HEX1$$fc00$$ENDHEX$$hren w$$HEX1$$fc00$$ENDHEX$$rde
		//
		if lSPMLKey <> lSPMLKeyOld then
			if iTopOffSPML = 0 then
				lNumberOfSPML += long(dcSPMLMasterQuantity)	// vorher dcSPMLQuantity
			end if
			lSPMLKeyOld 					= lSPMLKey
			sSPMLMasterNameOld		= sSPMLMasterName
			sSPMLMasterAddTextOld		= sSPMLMasterAddText
		else
			//
			// Problem: gleiches SPML wurde f$$HEX1$$fc00$$ENDHEX$$r mehrere Namen bestellt
			//
			if sSPMLMasterName 		<> sSPMLMasterNameOld or &
				sSPMLMasterAddText	<> sSPMLMasterAddTextOld then
				
				if iTopOffSPML = 0 then
					lNumberOfSPML += long(dcSPMLMasterQuantity)	// vorher dcSPMLQuantity
				end if
				// Problem hier: es werden Variablen zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt, die 
				lSPMLKeyOld 					= lSPMLKey
				sSPMLMasterNameOld		= sSPMLMasterName
				sSPMLMasterAddTextOld		= sSPMLMasterAddText
			end if
		end if
	else
		//
		// An dieser Stelle ndeduction in cen_out_spml setzen
		// => SPML wird "nachtr$$HEX1$$e400$$ENDHEX$$glich" durch die Definition bedingt zu einem OnTop-SPML
		//		(z.B. LH BBML)
		//
		sFind = "nclass_number = " + string(lClassNumber) + " and nspml_key = " + string(lSPMLKey)
		lFind = dsSPML.Find(sFind,1,dsSPML.RowCount())
		if lFind > 0 then
			dsSPML.SetItem(lFind,"ndeduction",0)
		end if
	end if
end if

//
// 26.08.2004 Diverse Keys
//
lSPMLPLKindKey			= dsSPMLDefinition.GetItemNumber(lRow,"cen_packinglist_index_npl_kind_key")	// Key f$$HEX1$$fc00$$ENDHEX$$r MS0, MS1, MS2, ...
lSPMLPackinglistKey		= dsSPMLDefinition.GetItemNumber(lRow,"cen_packinglists_npackinglist_key")	// Key f$$HEX1$$fc00$$ENDHEX$$r APP, DES, ...
lSPMLPLDetailKey			= dsSPMLDefinition.GetItemNumber(lRow,"cen_packinglists_npackinglist_detail_key")	// Detail-Key der Packinglist
sSPMLPackinglistText		= dsSPMLDefinition.GetItemString(lRow,"cen_packinglists_ctext")	// Bezeichnung der Packinglist

iSPMLDistribute				= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_ndistribute")	// Verteilung an/aus

lSPMLPLTypeKey			= uf_get_pl_type_key(lSPMLPLIndexKey,lSPMLPLDetailKey)

// --------------------------------------------------------------------------------------------------------------------
// 06.02.2013 HR: Produktionstext durch SL-Produktionstext ersetzen falls eingestellt (Auch bei SPMLs)
// --------------------------------------------------------------------------------------------------------------------
ii_ReplaceProdTextSpml 	= dsSPMLDefinition.GetItemNumber(lRow,"cen_spml_detail_nreplacetext")
if  ii_ReplaceProdTextSpml =1 then 
	sProductionText		= dsSPMLDefinition.GetItemString(lRow,"cen_packinglists_ctext_short")
end if

// --------------------------------------------------------------------------------------------------------------------
// 22.10.2015 HR: In BRU gibt es f$$HEX1$$fc00$$ENDHEX$$r die SPMLs jetzt auch Servicest$$HEX1$$fc00$$ENDHEX$$cklisten
// --------------------------------------------------------------------------------------------------------------------
if dsSPMLDefinition.GetItemNumber(lRow,"sys_packinglist_kinds_nxsl") = 1 then
	is_packinglist_spml_xsl = dsSPMLDefinition.GetItemString(lRow,"cen_packinglist_index_cpackinglist")
end if




// 19.09.2014 HR:

lfound 							= 0
ii_spml_partial_substitution 	= 0

// 23.10.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus
/*  Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus 
if idsLocalEuSubst.rowcount()>0 then
	// --------------------------------------------------------------------------------------------------------------------
	// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling
	// --------------------------------------------------------------------------------------------------------------------
	ls_find = "loc_pl_subst_npl_index_key = "+string(lSPMLPLIndexKey)
	
	lfound = idsLocalEuSubst.find(ls_find ,1,idsLocalEuSubst.rowcount())		
	
	if lfound > 0 then
		ls_sub_ori = string(lSPMLPLIndexKey)
		ls_sub_ori += " "+ sSPMLPackingList
		ls_sub_ori += " "+ sSPMLProductionText

		ii_spml_nlocal_sub 			= 1
		ii_spml_nlocal_sub_flight		= 1
		il_spml_npl_index_key_ori	= lSPMLPLIndexKey
		is_spml_cpackinglist_ori		= sSPMLPackingList
		is_spml_ctext_ori				= sSPMLProductionText

	  	ii_spml_partial_substitution 	=  idsLocalEuSubst.getitemnumber(lfound,"loc_pl_subst_flights_npartial_substitution")

		lSPMLPLIndexKey 				= idsLocalEuSubst.getitemnumber(lfound,"loc_pl_subst_npl_index_key_subst")
		sSPMLPackingList				= idsLocalEuSubst.getitemstring(lfound,"cen_packinglist_index_cpackinglist")
		sSPMLProductionText			= idsLocalEuSubst.getitemstring(lfound,"cen_packinglists_ctext")

		ls_sub_new = string(lSPMLPLIndexKey)
		ls_sub_new += " "+ sSPMLPackingList
		ls_sub_new += " "+ sSPMLProductionText
		
		uf_trace(3,"uf_compile(): Local EU Substitution: SPML -> ORI: " +ls_sub_ori)
		uf_trace(3,"uf_compile(): Local EU Substitution: SPML -> NEW: " +ls_sub_new)
		il_nlocal_sub_flight = 1
	else
		ii_spml_nlocal_sub 			= 0
		setnull(il_spml_npl_index_key_ori)
		setnull(is_spml_cpackinglist_ori)
		setnull(is_spml_ctext_ori)
	end if		
end if
Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus */

// --------------------------------------------------------------------------------------------------------------------
// 19.09.2014 HR: Wenn keine lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling erfolgte, dann pr$$HEX1$$fc00$$ENDHEX$$fen wir wie bisher
// --------------------------------------------------------------------------------------------------------------------
if 	idsLocalSubst.rowcount()>0 and lfound = 0 then
	// --------------------------------------------------------------------------------------------------------------------
	// 02.06.2014 HR: Hier tauschen/l$$HEX1$$f600$$ENDHEX$$schen wir die definierten Lokale Ersetzungen aus (CBASE-NAM-CR-14020)
	// --------------------------------------------------------------------------------------------------------------------
	ls_find = "loc_subst_itemlist_npl_index_from = "+string(lSPMLPLIndexKey)
	ls_find +=" and ( loc_subst_itemlist_nclass_number = "+string(lClassNumber)+" or loc_subst_itemlist_nclass_all = 1)"
	
	lfound = idsLocalSubst.find(ls_find ,1,idsLocalSubst.rowcount())		
	
	if lfound > 0 then
		ls_sub_ori = string(lSPMLPLIndexKey)
		ls_sub_ori += " "+ sSPMLPackingList
		ls_sub_ori += " "+ sSPMLProductionText

		if idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npl_index_to") = -1 then
			uf_trace(3,"uf_compile(): Local Substitution: SPML:  -> Delete ORI: " +ls_sub_ori)
			return -1
		end if

		ii_spml_nlocal_sub 			= 1
		ii_spml_nlocal_sub_flight		= 1
		il_spml_npl_index_key_ori	= lSPMLPLIndexKey
		is_spml_cpackinglist_ori		= sSPMLPackingList
		is_spml_ctext_ori				= sSPMLProductionText
		
		lSPMLPLIndexKey 				= idsLocalSubst.getitemnumber(lfound,"loc_subst_itemlist_npl_index_to")
		sSPMLPackingList				= idsLocalSubst.getitemstring(lfound,"cen_packinglist_index_cpackinglist")
		sSPMLProductionText			= idsLocalSubst.getitemstring(lfound,"loc_subst_itemlist_cpl_ctext_to")
		
		// 16.11.2015 HR: Wir ben$$HEX1$$f600$$ENDHEX$$tigen auch bei den SPMLs den richtigen Detailkey
		lSPMLPLDetailKey 				= idsLocalSubst.getitemnumber(lfound,"cen_packinglists_npackinglist_detail_key")

		ls_sub_new = string(lSPMLPLIndexKey)
		ls_sub_new += " "+ sSPMLPackingList
		ls_sub_new += " "+ sSPMLProductionText
		
		uf_trace(3,"uf_compile(): Local Substitution: SPML -> ORI: " +ls_sub_ori)
		uf_trace(3,"uf_compile(): Local Substitution: SPML -> NEW: " +ls_sub_new)
		il_nlocal_sub_flight = 1
	else
		ii_spml_nlocal_sub 			= 0
		setnull(il_spml_npl_index_key_ori)
		setnull(is_spml_cpackinglist_ori)
		setnull(is_spml_ctext_ori)
	end if
elseif lfound = 0 then
	// 19.09.2014 HR: Falls es keine EU-Ersetzung gegeben hat, dann setzen wir alles auf NULL
	ii_spml_nlocal_sub 			= 0
	setnull(il_spml_npl_index_key_ori)
	setnull(is_spml_cpackinglist_ori)
	setnull(is_spml_ctext_ori)
end if

return 0

end function

public function long uf_get_foreign_object (long arg_old_meal_key);//=================================================================================================
//
// uf_get_foreign_object
//
// Hole richtigen nhandling_meal_key!
//
//=================================================================================================
long	lForeignHandlingKey
long	lForeignHandlingMealKey

setnull(lForeignHandlingMealKey)

//
// Zuerst den richtigen nhandling_key ermitteln
//
select nhandling_key
  into :lForeignHandlingKey
  from cen_meals
 where nhandling_meal_key = :arg_old_meal_key;
 
if sqlca.sqlcode <> 0 then
	return lForeignHandlingMealKey
end if

//
// Jetzt den zum Stichtag passenden nhandling_meal_key ermitteln
//
select nhandling_meal_key
  into :lForeignHandlingMealKey
  from cen_meals
 where nhandling_key = 	:lForeignHandlingKey
   and dvalid_from 	<= :dGenerationDate
	and dvalid_to		>=	:dGenerationDate;
	
if sqlca.sqlcode <> 0 then
	return lForeignHandlingMealKey
end if

return lForeignHandlingMealKey

end function

public function integer uf_replace_ratiolist3 ();//=================================================================================================
//
// uf_replace_ratiolist3
//
//=================================================================================================
//
// Ersetzung kompletter Berechnungsarten 
//
//=================================================================================================
//
// 09.02.2006 Anmerkung: Dies ist die geeignete Stelle, die Ratiolist3-Ersetzung vorzunehmen
// F$$HEX1$$fc00$$ENDHEX$$r alle ncalc_id = 99 wird der nratiolist_key in cen_calc_ratio3.nratiolist_key gesucht.
// Anschl. werden die Daten direkt in dsCenMeals ausgetauscht.
//
//=================================================================================================
long	i

if dsCenMeals.Find("cen_meals_detail_ncalc_id = 99",1,dsCenMeals.RowCount()) > 0 then
	if lAirlineKey > 0 then
		dsRatioReplacement.Retrieve(lAirlineKey,dGenerationDate)
		
		for i = 1 to dsCenMeals.RowCount()
			if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 99 then
				
			
				// Felder ersetzen:
				// cen_meals_detail_ncalc_id, cen_meals_detail_ncalc_detail_key, 
				// cen_meals_detail_npercentage, cen_meals_detail_nvalue
			
			end if
			
			
		next
	
		
	end if
end if



return 0

end function

public function integer uf_get_calc_basis_feb ();//=================================================================================================
//
// uf_get_calc_basis (Sicherung Stand bis Februar 2006)
//
// Ermittelt die Berechnungsgrundlage
//
// 20.07.2005
// Erweiterung der TopOff- und Reservetypen:
// 0 = immer Reserve
// 1 = Reserve bis Sitzplatzversion
// 2 = immer Reserve ab 1 Pax
// 3 = Reserve bis Sitzplatzversion ab 1 Pax
//
//=================================================================================================
long	lPaxOriginal

//
// Original-Pax merken
//
lPaxOriginal = lPax

//
// Nicht vergessen:
// Alle manuellen Eingaben werden im Feld lPaxManual gespeichert!!!
// Damit schickt in der Operation lPaxManual den Wert von lPax aus dem Rennen.
// lPaxManual kann aber auch 0 sein, deshalb hier nicht lPaxManual > 0 abfragen.
//
//if lPaxManual > 0 then
if iAsk4Passenger = 1 then
	lPax = lPaxManual	
end if

//
// Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = Reserve bis Sitzplatzversion
// 0 = immer Reserve
//
if iReserveType = 0 then
	lCalcBasis = lPax + lReserveQuantity
elseif iReserveType = 1 then
	if lPax + lReserveQuantity > iVersion then
		lCalcBasis = iVersion
	else
		lCalcBasis = lPax + lReserveQuantity
	end if
elseif iReserveType = 2 then
	if lPax > 0 then
		lCalcBasis = lPax + lReserveQuantity
	end if
elseif iReserveType = 3 then
	if lPax > 0 then
		if lPax + lReserveQuantity > iVersion then
			lCalcBasis = iVersion
		else
			lCalcBasis = lPax + lReserveQuantity
		end if
	end if
end if

//
// TopOff ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// 1 = TopOff bis Sitzplatzversion
// 0 = immer TopOff
//
if lPax > iVersion then
	//
	// Falls $$HEX1$$dc00$$ENDHEX$$berbucht wird, dann darf die TopOff-Regel nicht zu einer Reduktion f$$HEX1$$fc00$$ENDHEX$$hren
	//
	lCalcBasis = lPax
else
	if iTopOffType = 0 then
		lCalcBasis = lCalcBasis + lTopOffQuantity
	elseif iTopOffType = 1 then
		if lCalcBasis + lTopOffQuantity > iVersion then
			lCalcBasis = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
		else
			lCalcBasis = lCalcBasis + lTopOffQuantity
		end if
	elseif iTopOffType = 2 then
		if lPax > 0 then
			lCalcBasis = lCalcBasis + lTopOffQuantity
		end if
	elseif iTopOffType = 3 then
		if lPax > 0 then
			if lCalcBasis + lTopOffQuantity > iVersion then
				lCalcBasis = iVersion	// unver$$HEX1$$e400$$ENDHEX$$ndert lassen, einfach keine Topoff dazuz$$HEX1$$e400$$ENDHEX$$hlen
			else
				lCalcBasis = lCalcBasis + lTopOffQuantity
			end if
		end if
	end if
end if
//
// Original-Pax wiederherstellen
//
lPax = lPaxOriginal

return 0

end function

public function integer uf_start_mco_simulation ();//=================================================================================================
//
// uf_start_mco_simulation
//

//=================================================================================================
//
// Der Simulationslauf f$$HEX1$$fc00$$ENDHEX$$r eine Master Catering Order
//
//=================================================================================================
long	i, j, lRows
DateTime dtValidFrom, dtValidTo
DataStore dsMCODetails
String sClassName, sRotationName, sServiceName
				
bInSimulation	= true

//-------------------------------------------------------------------------------------
//
// Datastores Tauschen 
//
//-------------------------------------------------------------------------------------
uf_switch_datasource()

//-------------------------------------------------------------------------------------
//
// Check Properties
//
//-------------------------------------------------------------------------------------
if isnull(lSimulatePax) then
	sErrortext = "Calculation got no passenger count!"
	return -1
end if

if isnull(lSimulateSPML) then
	lSimulateSPML = 0
end if

if lSimulateVersion = 0 or isnull(lSimulateVersion) then
	sErrortext = "Calculation got no version boundary!"
	return -1
end if

if lMCOKey = 0 or isnull(lMCOKey) then
	sErrortext = "Calculation got no MCO key!"
	return -1
end if

if lMCOGroupKey = 0 or isnull(lMCOGroupKey) then
	sErrortext = "Calculation got no MCO-Group key!"
	return -1
end if

if isnull(dGenerationDate) then
	dGenerationDate = today()
end if

if isnull(sPlant) then
	sErrortext = "Calculation needs a plant!"
	return -1
end if

//-------------------------------------------------------------------------------------
//
// G$$HEX1$$fc00$$ENDHEX$$ltige KVAs f$$HEX1$$fc00$$ENDHEX$$r Airline holen
//
//-------------------------------------------------------------------------------------
uf_retrieve_accounts()

// -------------------------------------------------------------------------------------------
// Vorsichtshalber ein eigenens Datastore verwenden 
// (Entspricht dw_meals_and_meals_detail bzw. dw_cen_out_meals erweitert um Felder f$$HEX1$$fc00$$ENDHEX$$r Klasse, Service und Rotation)
// -------------------------------------------------------------------------------------------
dsCenMeals.DataObject 		= "dw_mco_simulation_data"
dsCenOutMeals.DataObject 	= "dw_cen_out_mco"
dsCenMeals.reset( )
dsCenOutMeals.reset( )

//-------------------------------------------------------------------------------------
//
// Retrieve auf das MCO Objekt
//
//-------------------------------------------------------------------------------------
dsMCODetails = create DataStore
dsMCODetails.dataobject = "dw_mco_simulation" 
dsMCODetails.SettransObject(sqlca)

dsMCODetails.retrieve(lMCOKey, DateTime(dGenerationdate), this.ilanguage )

// Die nicht zutreffenden Zeilen rausl$$HEX1$$f600$$ENDHEX$$schen

For i = dsMCODetails.RowCount() to 1 Step -1
	
	// -------------------------------------------------------------------------------------
	// Daten auf die aktuell g$$HEX1$$fc00$$ENDHEX$$ltigen Rotationen Filtern
	// -------------------------------------------------------------------------------------
	uoRotation						= create uo_get_rotation
	uoRotation.dRotationDate 	= dGenerationdate
	uoRotation.lRotationKey 	= dsMCODetails.GetItemNumber(i, "nrotation_key")
	
	uoRotation.sUnit 				= sWerk
	
	uoRotation.of_get_rotation()
	
	if uoRotation.iStatus <> 0 then
		sErrorText = uoRotation.sErrorMessage
		return -5
	end if
	
	if dsMCODetails.GetItemstring(i, "cen_rotation_names_ctext") <> uoRotation.srotationtext then
		dsMCODetails.deleterow(i)
	end if
	
	Destroy(uoRotation)
Next

//////////////////////////////////////////////////////////////////
// DB 19.06.07: Filter verhindert Fehler bei Berechnungen		 //
// bei denen abwechselnd auf und ab gerundet wird					 //
//////////////////////////////////////////////////////////////////
dsMCODetails.setFilter("nmco_group_key = " + String(lMCOGroupKey) + &
							  "and cclass = '" + sMCOClass + "'")
dsMCODetails.filter()
//dsMCODetails.setFilter("nmco_group_key = " + String(lMCOGroupKey))
//dsMCODetails.filter()

// dsMCODetails durchlaufen und alle Daten f$$HEX1$$fc00$$ENDHEX$$r dsCenOutMeals setzen
Long a	
For lRows = 1 to dsMCODetails.RowCount()

	// Variablen f$$HEX1$$fc00$$ENDHEX$$r dsCenMeals f$$HEX1$$fc00$$ENDHEX$$llen
	lpackinglistindexkey = dsMCODetails.getItemNumber(lRows, "npackinglist_index_key")
	lRotation_Key 			= dsMCODetails.getItemNumber(lRows, "nrotation_key")
	lRotationNameKey 		= dsMCODetails.getItemNumber(lRows, "nrotation_name_key")
	lcalcid			 		= dsMCODetails.getItemNumber(lRows, "ncalc_id")
	lcalcdetailkey	 		= dsMCODetails.getItemNumber(lRows, "ncalc_detail_key")
	dtValidFrom				= dsMCODetails.getItemDateTime(lRows, "dvalid_from")
	dtValidTo				= dsMCODetails.getItemDateTime(lRows, "dvalid_to")
	iPercentage		 		= dsMCODetails.getItemNumber(lRows, "npercentage")
	dcValue					= dsMCODetails.getItemNumber(lRows, "nvalue")
	iBillingStatus			= dsMCODetails.getItemNumber(lRows, "nbilling_status")
	iSPMLDeduction			= dsMCODetails.getItemNumber(lRows, "nspml_deduction")
	iComponentGroup		= dsMCODetails.getItemNumber(lRows, "ncomponent_group")
	lAccountKey 			= dsMCODetails.getItemNumber(lRows, "naccount_key")
	lDefaultAccountKey 	= dsMCODetails.getItemNumber(lRows, "naccount_key")
	sRemark					= dsMCODetails.getItemString(lRows, "cen_mco_detail_cremark")
	sPackinglist			= dsMCODetails.getItemString(lRows, "cpackinglist")
	sProductionText		= dsMCODetails.getItemString(lRows, "cen_packinglists_ctext")
	sClassName				= dsMCODetails.getItemString(lRows, "cclass")
	sServiceName			= dsMCODetails.getItemString(lRows, "cen_mco_group_ctext")
	sRotationName			= dsMCODetails.getItemString(lRows, "cen_rotation_names_ctext")
	lMCOGroupKey			= dsMCODetails.getItemNumber(lRows, "nmco_group_key")
	sMultiClasses			= dsMCODetails.getItemString(lRows, "cclasses")
			
	// dsCenMeals f$$HEX1$$fc00$$ENDHEX$$llen
	a = dsCenMeals.InsertRow(0)
	dsCenMeals.SetItem(a, "cen_meals_detail_npackinglist_index_key", lpackinglistindexkey)
	dsCenMeals.SetItem(a, "cen_meals_nrotation_key", lRotation_Key )
	dsCenMeals.SetItem(a, "nrotation_name_key", lRotationNameKey)
	dsCenMeals.SetItem(a, "cen_meals_detail_ncalc_id", lcalcid)
	dsCenMeals.SetItem(a, "cen_meals_detail_ncalc_detail_key", lcalcdetailkey)
	dsCenMeals.SetItem(a, "cen_meals_detail_dvalid_from", dtValidFrom)
	dsCenMeals.SetItem(a, "cen_meals_detail_dvalid_to", dtValidTo)
	dsCenMeals.SetItem(a, "cen_meals_detail_npercentage", iPercentage)
	dsCenMeals.SetItem(a, "cen_meals_detail_nvalue", dcValue)
	dsCenMeals.SetItem(a, "cen_meals_detail_nbilling_status", iBillingStatus)
	dsCenMeals.SetItem(a, "cen_meals_detail_nspml_deduction", iSPMLDeduction)
	dsCenMeals.SetItem(a, "cen_meals_detail_ncomponent_group", iComponentGroup)
	dsCenMeals.SetItem(a, "cen_meals_detail_naccount_key", lAccountKey)
	dsCenMeals.SetItem(a, "ndefault_account_key", lDefaultAccountKey)
	dsCenMeals.SetItem(a, "cen_meals_detail_cremark", sRemark)
	dsCenMeals.SetItem(a, "cen_packinglist_index_cpackinglist", sPackinglist)
		
	//HR 07.07.2008 CBASE-UK-EM-4402
	//Falls die Variable sProductionTextReplace gef$$HEX1$$fc00$$ENDHEX$$llt ist diesen Text als Produktiontext eintragen, sonst den normalen Produktionstext
	if sProductionTextReplace<>""then
		dsCenMeals.SetItem(a, "cen_meals_detail_cproduction_text",			sProductionTextReplace)
	else
		dsCenMeals.SetItem(a, "cen_meals_detail_cproduction_text",			sProductionText)
	end if 
	

	dsCenMeals.SetItem(a, "cclass_name", sClassName)
	dsCenMeals.SetItem(a, "cservice_name", sServiceName)
	dsCenMeals.SetItem(a, "crotation_name", sRotationName)
	dsCenMeals.SetItem(a, "nmco_group_key", lMCOGroupKey)
	dsCenMeals.SetItem(a, "cen_meals_detail_nprio", lrows)
	dsCenMeals.SetItem(a, "cen_meals_detail_cclasses", sMultiClasses)
Next
Destroy (dsMCODetails)

//
// 09.02.2006 Anmerkung: Dies w$$HEX1$$e400$$ENDHEX$$re die geeignete Stelle, die Ratiolist3-Ersetzung vorzunehmen
// F$$HEX1$$fc00$$ENDHEX$$r alle ncalc_id = 99 wird der nratiolist_key in cen_calc_ratio3.nratiolist_key gesucht.
// Anschl. werden die Daten ausgetauscht.
//
uf_replace_ratiolist3()

//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()
//f_print_datastore(dsCenMeals)

//if dsCenMeals.RowCount() > 0 then
//	//
//	// Umlauf holen (einmal je Mahlzeitendefinition)
//	//
//	if uf_get_rotation(lMCORotationKey,0) <> 0 then	// Rotation-Key aus cen_mco_detail
//		//
//		// Fehler beim Umlauf => Daten nicht schreiben
//		//
//		MessageBox("","test")
//		return -1
//	end if
//end if
//
// 17.03.2005: Umlauf filtern
//
//dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey))
//dsCenMeals.Filter()
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()

String sRot

for j = 1 to dsCenMeals.RowCount()
//		if dsCenMeals.GetItemNumber(j,"nrotation_name_key") <> lRotationNameKey then
//			//
//			// Datensatz ist f$$HEX1$$fc00$$ENDHEX$$r anderen Umlauf bestimmt
//			//
//			continue
//		end if

	///////////////////////////////////////////////////////////////////
	// 23.04.2007 DB - Den aktuellen RotationNameKey manuell setzen  //
	///////////////////////////////////////////////////////////////////
	lRotationNameKey = dsCenMeals.GetItemNumber(j,"nrotation_name_key")
	
//	//
//	// Vorfiltern TEST
//	//
//	lCalcID = dsCenMeals.getItemNumber(j, "cen_meals_detail_ncalc_id")
//	dsCenMeals.SetFilter("cen_meals_detail_ncalc_id = " + String(lCalcID))
//	dsCenMeals.Filter()
	
	// 08.06.2010 HR: BOB-Kennzeichen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	ii_Bob=0

	
	//
	// Satz berechnen
	//
	if uf_calculate(j) <> 0 then
		//
		// Fehler bei Berechnung der Mahlzeit, Daten nicht schreiben
		//
		return -1
	end if
	//
	// Kurz-Von-An setzen (da uf_compile nicht aufgerufen wird)
	//
	
	if isnull(lAccountKey) or lAccountKey = 0 then
		//
		// Falls kein KVA auf Zeile gesetzt, dann Default verwenden
		//
		lAccountKey = lDefaultAccountKey
	end if

	//
	// $$HEX1$$dc00$$ENDHEX$$bertrag nach cen_mco (dsCenMCO)
	//
	uf_insert_cen_out_meals( )	
	
	// Kleiner Hack, um die uf_insert_cen_out_meals( ) Funktion nicht $$HEX1$$e400$$ENDHEX$$ndern zu m$$HEX1$$fc00$$ENDHEX$$ssen
	dsCenMeals.SetFilter("")
	dsCenMeals.Filter()
	sRot = dsCenMeals.GetItemString(j, "crotation_name")
	dsCenOutMeals.SetItem(dsCenOutMeals.RowCount(), "crotation_name", sRot)
	dsCenOutMeals.SetItem(dsCenOutMeals.RowCount(), "cservice_name", dsCenMeals.GetItemString(j, "cservice_name") )
	dsCenOutMeals.SetItem(dsCenOutMeals.RowCount(), "cclass_name", dsCenMeals.GetItemString(j, "cclass_name") )
	dsCenOutMeals.SetItem(dsCenOutMeals.RowCount(), "nmco_group_key", dsCenMeals.GetItemNumber(j, "nmco_group_key") )
next

return 0
end function

public function integer uf_calc_classes (integer iclasses[]);//=================================================================================================
//
// uf_calc_classes
//
// Berechnet die Gesamtpassagierzahl aller Buchungsklassen in iClasses[]
//
//=================================================================================================
long	i, j 
long	lResult
long	lValue = 0

for i = 1 to dsCenOutPax.RowCount()
	
	lResult = dsCenOutPax.GetItemNumber(i,"nresult_key") 
	
	if lResult = lresultkey then
		
		for j = 1 to upperbound(iClasses)
			if dsCenOutPax.GetItemNumber(i,"nclass_number") = iClasses[j] then
				lValue += dsCenOutPax.GetItemNumber(i,"npax")
			end if
		next
		
	end if
	
next

return lValue

end function

public function integer uf_calc_classes_percentage (integer iclasses[]);//=================================================================================================
//
// uf_calc_classes_percentage
//
// Berechnet die Gesamtpassagierzahl aller Buchungsklassen in iClasses[], davon dann iPercentage
//
//=================================================================================================
long	i, j 
long	lResult
long	lValue = 0

for i = 1 to dsCenOutPax.RowCount()
	
	lResult = dsCenOutPax.GetItemNumber(i,"nresult_key") 
	
	if lResult = lresultkey then
		
		for j = 1 to upperbound(iClasses)
			if dsCenOutPax.GetItemNumber(i,"nclass_number") = iClasses[j] then
				lValue += dsCenOutPax.GetItemNumber(i,"npax")
			end if
		next
		
	end if
	
next

if lValue > 0 and iPercentage > 0 then
	lValue = Round(lValue * iPercentage / 100, 0)
else
	lValue = 0
end if

return lValue

end function

public function integer uf_calc_classes_multiple (integer iclasses[]);//=================================================================================================
//
// uf_calc_classes_multiple
//
// Berechnet die Gesamtpassagierzahl aller Buchungsklassen in iClasses[], davon dann multiple dcValue
//
//=================================================================================================
long	i, j 
long	lResult
Long	lMultiple
long	lValue = 0

for i = 1 to dsCenOutPax.RowCount()
	
	lResult = dsCenOutPax.GetItemNumber(i,"nresult_key") 
	
	if lResult = lresultkey then
		
		for j = 1 to upperbound(iClasses)
			if dsCenOutPax.GetItemNumber(i,"nclass_number") = iClasses[j] then
				lValue += dsCenOutPax.GetItemNumber(i,"npax")
			end if
		next
		
	end if
	
next

if lValue > 0 and iPercentage > 0 then
	lValue = Round(lValue * iPercentage / 100, 0)
else
	lValue = 0
end if

// Vielfaches berechnen 

if dcValue = 0 then dcValue = 1

lMultiple = truncate(lValue / dcValue, 0)			// Vielfaches

If Mod(lValue, integer(dcValue)) > 0 then lMultiple++	// Falls Rest aus Division, dann bis zum
																		// n$$HEX1$$e400$$ENDHEX$$chsten Schritt
return lMultiple




end function

public function integer uf_calc_multi_class_sum (integer icolumn);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_multi_class_sum (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer icolumn
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: integer
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  ??.??.????	1.00			???							Erstellung
//  16.05.2013	1.01			Thomas Brackmann		iColumn 4 => Aufruf aus ncalc_id = 45 (SPML der Klassen aufaddieren)
//  06.08.2013	1.02			Thomas Brackmann		iColumn 4 => sColumn = "npax" anstelle von "nversion"	
// -----------------------------------------------------------------------------------------------------------------------------------------

String	sColumn
String 	sClassArray[] 
Integer	i
Long		lFound
Long		lValue
Long		lValue_ver	//29.11.2012, G. Brosch

// --------------------------------------------
// Welche Spalte aus dsCenOutPax soll
// kummuliert werden
// --------------------------------------------
if iColumn = 1 or iColumn = 4 then
	sColumn = "npax"
elseif iColumn = 3 then
	sColumn = "npax_airline"
else // 2
	sColumn = "nversion"	
end if

il_spml_count = 0

// --------------------------------------------
// Die Klassen des MultiClass String in ein 
// Array packen
// sMultiClass k$$HEX1$$f600$$ENDHEX$$nnte sein BC+EY
// --------------------------------------------
f_string_to_array(this.sMultiClasses, "+", sClassArray)

// --------------------------------------------
// Die Werte der Klassen aus sMultiClass 
// zusammenaddieren 
// --------------------------------------------
lValue = 0

For i = 1 to Upperbound(sClassArray)
	
	// 06.03.2013 HR: Wir suchen mit NRESULT_KEY, damit wir immer den richtigen Flug anpacken
//	lFound = dsCenOutPax.Find("cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	lFound = dsCenOutPax.Find("nresult_key = "+string(lResultKey)+" and cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	
	if lFound <= 0 then continue
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.10.2011 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen hier auf NULL pr$$HEX1$$fc00$$ENDHEX$$fen, da es bei der Generierung sein kann, das npax_airline null ist
	// --------------------------------------------------------------------------------------------------------------------
	if not isnull(dsCenOutPax.GetItemNumber(lFound, sColumn)) then
		lValue += dsCenOutPax.GetItemNumber(lFound, sColumn)
		
		// Aufaddieren SPML-Anzahlen bei Calc-Id 45 TBR 16.05.2013
		IF 	iColumn = 4 THEN
			IF 	NOT isnull(dsCenOutPax.GetItemNumber(lFound, "npax_spml")) THEN
				il_spml_count = il_spml_count + dsCenOutPax.GetItemNumber(lFound, "npax_spml")
			END IF
		END IF
		
	end if
	
	lValue_ver += dsCenOutPax.GetItemNumber(lFound, "nversion")	//29.11.2012, G. Brosch
next

dcQuantity 			= lValue					//29.11.2012, G. Brosch
idc_quantity_ver 	= lValue_ver				//29.11.2012, G. Brosch

return lValue
end function

public function integer uf_calc_percent_multiple_for_groups ();// --------------------------------------------------------------------------
// 19.02.2007
// 
// uf_calc_percent_multiple_for_groups
// 
// Berechnet Prozent-Vielfaches unter Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung der Gruppen
// 
// 07.11.12, Gunnar Brosch: QuantityVersion
// --------------------------------------------------------------------------
long		i
long		lFind

decimal	dcPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer  	iTotalPercent
integer	iQuantity
integer	iComponents			// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter			// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	li_MealCounter_ver; 	// 07.11.12, Gunnar Brosch: QuantityVersion
decimal	dcResult
decimal	dcResult_ver;			// 07.11.12, Gunnar Brosch: QuantityVersion	
decimal	dcRelativePercentage[]
long 		lValue
long 		lValue_ver;				// 07.11.12, Gunnar Brosch: QuantityVersion	
long 		lResult
long 		lResult_ver;				// 07.11.12, Gunnar Brosch: QuantityVersion	
string 		sOut

if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version"); // 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )
							
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

if  dsCenmeals.RowCount() = 0 then return 0

// ------------------------------------------------------
//
// Zuerst das Endergebnis ermitteln
//
// ------------------------------------------------------

// ------------------------------------------------------
// Prozente aufsummieren
// ------------------------------------------------------
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iTotalPercent			+= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
next

// ------------------------------------------------------
// anteilige Prozentwerte ermitteln
// ------------------------------------------------------
for i = 1 to dscenmeals.RowCount()
	dcRelativePercentage[Upperbound(dcRelativePercentage) + 1] = dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage") / (iTotalPercent / 100)
next

lValue 		= ceiling(lCalcBasis * iTotalPercent / 100)			// Prozentwert
lValue_ver	= ceiling(il_calcbasis_ver * iTotalPercent / 100);	// 07.11.12, Gunnar Brosch: QuantityVersion	

if dcValue = 0 then dcValue = 1
lResult 		= truncate(lValue / dcValue, 0)							// Vielfaches
lResult_ver 	= truncate(lValue_ver / dcValue, 0);					// 07.11.12, Gunnar Brosch: QuantityVersion				

If Mod(lValue, integer(dcValue)) > 0 then lResult++				// Falls Rest aus Division, dann bis zum n$$HEX1$$e400$$ENDHEX$$chsten Schritt
if Mod(lValue_ver, integer(dcValue)) > 0 then lResult_ver++;	// 07.11.12, Gunnar Brosch: QuantityVersion

sOut 		= "100% = " + string(lResult) + " - "

// ------------------------------------------------------
// Mengen der einzelnen Positionen ermitteln
// ------------------------------------------------------
if Upperbound(dcRelativePercentage) <> dscenmeals.RowCount() then 
	dcQuantity = -1
	idc_quantity_ver = -1;		// 07.11.12, Gunnar Brosch: QuantityVersion
	return 0
end if

for i = 1 to dscenmeals.RowCount()
	
	dscenmeals.SetItem(i,"nstatus",1)
	dcPerc			= dcRelativePercentage[i] 
		
	sOut 		+= dsCenMeals.GetItemString(i,"cen_packinglist_index_cpackinglist") + " - " + String(dcPerc)  + "%"
	
	// -------------------------------------------------------
	// 21.02.07, KF doch kein abwechselndes auf und 
	//           abrunden gew$$HEX1$$fc00$$ENDHEX$$nscht
	// -------------------------------------------------------
	//	if mod(i,2) = 1 then
	//		dcResult		= ceiling((lResult * dcPerc)/100) 
	//	else
	//		dcResult		= truncate( ((lResult * dcPerc)/100) ,0)
	//		if dcResult < 1 then dcResult = 1
	//	end if
	
	dcResult		=  Round((lResult * dcPerc)/100, 0)
	dcResult_ver = Round((lResult_ver * dcPerc)/100, 0); // 07.11.12, Gunnar Brosch: QuantityVersion
	
//	Messagebox(sOut + "         ", dcResult)
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver); // 07.11.12, Gunnar Brosch: QuantityVersion
	iMealCounter += dcResult
	li_MealCounter_ver += dcResult_ver;							// 07.11.12, Gunnar Brosch: QuantityVersion
	
next

// ----------------------------------------
//
// Rundungsdifferenzen entfernen
// 
// ----------------------------------------
integer 	iDiff, iAdd, iOldQuantity
Integer	iMax
Long		lRow, j

if iMealCounter <> lResult then 
	
	iDiff = lResult - iMealCounter
	
	if iDiff < 0 then 
		iDiff = iDiff * -1
		iAdd = -1
	else
		iAdd = 1
	end if
	
	// --------------------------------------------------------------------
	// Zeile mit der h$$HEX1$$f600$$ENDHEX$$chsten Menge finden und dort 1 abziehen/draufpacken 
	// --------------------------------------------------------------------
	for j = 1 to iDiff
		iMax = 0
		lRow = 0
		for i = 1 to dscenmeals.RowCount()
			if dsCenMeals.GetItemNumber(i, "nquantity") > iMax then
				iMax = dsCenMeals.GetItemNumber(i, "nquantity")
				lRow = i
			end if
		next
		
		if lRow > 0 then
//			messagebox("", "Modify in row " + string(LRow))
			iOldQuantity = dsCenMeals.GetItemNumber(lRow, "nquantity")
			dsCenMeals.SetItem(lRow, "nquantity", iOldQuantity + iAdd)
		end if
	
	next
	
end if

// 07.11.12, Gunnar Brosch: QuantityVersion: Und jetzt auch f$$HEX1$$fc00$$ENDHEX$$r il_quantity_ver ********************>>>>>>>>>>>>>>>>>>>>>>>
if li_MealCounter_ver <> lResult_ver then 
	
	iDiff = lResult_ver - li_MealCounter_ver
	
	if iDiff < 0 then 
		iDiff = iDiff * -1
		iAdd = -1
	else
		iAdd = 1
	end if
	
	// --------------------------------------------------------------------
	// Zeile mit der h$$HEX1$$f600$$ENDHEX$$chsten Menge finden und dort 1 abziehen/draufpacken 
	// --------------------------------------------------------------------
	for j = 1 to iDiff
		iMax = 0
		lRow = 0
		for i = 1 to dscenmeals.RowCount()
			if dsCenMeals.GetItemNumber(i, "nquantity_version") > iMax then
				iMax = dsCenMeals.GetItemNumber(i, "nquantity_version")
				lRow = i
			end if
		next
		
		if lRow > 0 then
//			messagebox("", "Modify in row " + string(LRow))
			iOldQuantity = dsCenMeals.GetItemNumber(lRow, "nquantity_version")
			dsCenMeals.SetItem(lRow, "nquantity_version", iOldQuantity + iAdd)
		end if
	
	next
	
end if
// 07.11.12, Gunnar Brosch: QuantityVersion: Und jetzt auch f$$HEX1$$fc00$$ENDHEX$$r il_quantity_ver ********************<<<<<<<<<<<<<<<<<<<<<<<<

//f_print_datastore(dscenmeals)
if dsCenMeals.RowCount() > 0 then
	dcQuantity 			= dsCenMeals.GetItemNumber(1, "nquantity")
	idc_quantity_ver 	= dsCenMeals.GetItemNumber(1, "nquantity_version");	//07.11.12, Gunnar Brosch: QuantityVersion
end if

dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0






//
//
////
//// Bei CalcBasis = 0: raus hier
////
//if lCalcBasis = 0 then
//	for i = 1 to dscenmeals.RowCount()
//		dscenmeals.SetItem(i,"nquantity",0)
//		//
//		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
//		//
//		dscenmeals.SetItem(i,"nstatus",1)
//	next	
//	dcQuantity = 0
//	//
//	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//	//
//	// 27.04.2005 dsCenMeals.SetFilter("")
//	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
//	dsCenMeals.Filter()
//	dsCenMeals.SetSort("cen_meals_detail_nprio A")
//	dsCenMeals.Sort()
//	return 0
//end if
//
///* Merker:
//
//- Mindestens eine Mahlzeit bei Auswahlessen
//- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
//- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
//- Abzug von Mahlzeiten anderer Klassen nicht vergessen
//
//*/
////f_print_datastore(dscenmeals)
////
//// Check gegen Passagierzahl und Status setzen
////
//if iMealCounter > lCalcBasis then
//	for i = dscenmeals.RowCount() to 1 step -1
//		//
//		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
//		//
//		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
//			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
//			//
//			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
//			//
//			if dcResult > 1 then
//				dcResult --
//				iMealCounter --
//				dscenmeals.SetItem(i,"nquantity",dcResult)
//			end if
//		end if
//		//
//		// Falls zu wenig beladen wurde durch Rundungsprobleme...
//		//
//		if iPercCounter = 100 and iMealCounter < lCalcBasis then
//			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
//			dcResult ++
//			iMealCounter ++
//			dscenmeals.SetItem(i,"nquantity",dcResult)
//		end if
//		
//		//
//		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
//		//
//		dscenmeals.SetItem(i,"nstatus",1)
//	
//	next
//else
//	for i = 1 to dscenmeals.RowCount()
//		//
//		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
//		//
//		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
//			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
//			dcResult --
//			iMealCounter --
//			dscenmeals.SetItem(i,"nquantity",dcResult)
//		end if
//		//
//		// Falls zu wenig beladen wurde durch Rundungsprobleme...
//		//
//		if iPercCounter = 100 and iMealCounter < lCalcBasis  then
//			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
//			dcResult ++
//			iMealCounter ++
//			dscenmeals.SetItem(i,"nquantity",dcResult)
//		end if
//		
//		//
//		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
//		//
//		dscenmeals.SetItem(i,"nstatus",1)
//	
//	next
//end if
//
////
//// Sicherheit: keine 0
//// Auskommentiert 23.01.
////
////lFind = dscenmeals.Find("nquantity = 0",1,dscenmeals.RowCount())
////if lFind > 0 then
////	dscenmeals.SetItem(lFind,"nquantity",1)
////	lFind = dscenmeals.Find("nquantity > 1",dscenmeals.RowCount(),1)
////	if lFind > 0 then
////		dscenmeals.SetItem(lFind,"nquantity",dscenmeals.GetItemNumber(lFind,"nquantity") -1)
////	end if
////end if
//	
//
////f_print_datastore(dscenmeals)
//
////
//// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
////
//if iPercCounter > 100 then
//	lOverloadSet = iMealCounter - lCalcBasis
//end if
//
////
//// Menge des ersten Wertes der Gruppe setzen
////
//dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 
//
//
////
//// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
////
//dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
//dsCenMeals.Filter()
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()
//
////dsCenMeals.SetFilter("")
////dsCenMeals.Filter()
////
////dsCenMeals.SetSort("cen_meals_detail_nprio A")
////dsCenMeals.Sort()
//
//return 0
//
end function

public function long uf_percent_multiple (decimal dsvalueparm, long lcalcbasisparm, long lpercentageparm);//=================================================================================================
//
// uf_percent_multiple
//
// Berechnet Prozent-Vielfaches
//
//=================================================================================================
long lValue
long lResult

lValue = ceiling(lCalcBasisParm * lPercentageParm / 100)	// Prozentwert

if dsValueParm = 0 then dcValue = 1
lResult = truncate(lValue / dsValueParm, 0)			// Vielfaches

If Mod(lValue, integer(dsValueParm)) > 0 then lResult++	// Falls Rest aus Division, dann bis zum
																		// n$$HEX1$$e400$$ENDHEX$$chsten Schritt

return lResult
end function

protected function integer uf_calculate (long lrow);//=================================================================================================uf_calc_ratiolist_percentage
//
// uf_calculate
//
// Berechnet die Auftragsmenge

// *************************************************************************************************************
// *************************************************************************************************************
// ***   
// ***   Achtung: $$HEX1$$c400$$ENDHEX$$nderungen und Erweiterung von CalcIDs m$$HEX1$$fc00$$ENDHEX$$ssen auch in  UF_START_CHANGE_ON_CEN_OUT nachgezogen werden   
// ***   
// *************************************************************************************************************
// *************************************************************************************************************

//
//=================================================================================================
//
// Argumente:
//	lRow				Zeile in dsCenMeals
//
//=================================================================================================
//
// Berechnungsarten: (aus sys_calculator)
// =================
//  1	=	Feste Menge
//	 2	=	100% f$$HEX1$$fc00$$ENDHEX$$r Klasse 			Full House
//	 3	=	Ratiolist					Detail-Key beachten
//	 4	=	Normal						Passagierzahl wird 1:1 durchgereicht
//	 5 =	Prozent						Prozentberechnung LH-Rundung
//	 6 =	Prozent kfm.				Prozentberechnung kaufm$$HEX1$$e400$$ENDHEX$$nnisch runden
//	 7	=	Vielfaches					Alle n Paxe ein Anteil
//	 8	=	Ganzzahliges				In n Schritten bis die Anzahl Pax erreicht ist
//	 9	=	Bosta + Absolut			Passagierzahl plus feste Menge
//	10	=	Bosta + Prozent			Passagierzahl plus Prozentwert
//	11	=	Bosta - Absolut			Passagierzahl minus feste Menge
//	12	=	Bosta - Prozent			Passagierzahl minus Prozentwert
//	13	=	Prozent Vielfach	
//	14	=	Prozent + Absolut
//	15	=	Passagiere
//	16	=	Passagiere + Crew
//	17	=	Crew only
//	18	=	St$$HEX1$$fc00$$ENDHEX$$cklisten Ratiolist	Ratiolist liefert andere Schl$$HEX1$$fc00$$ENDHEX$$sselnummer und Menge zur$$HEX1$$fc00$$ENDHEX$$ck
//	19	=	Differenz Full House
//	20 =	Prozent - Absolut			Passagiere in Prozent minus feste Menge
//	21 =	Vielfaches n				Alle i Paxe n Anteile
// 22 =	Feste Menge ab Passagiere				Ab Passagierzahl (iPercent) feste Menge
//	23 =	Prozent						Prozentberechnung LH-Rundung, Menge 0 m$$HEX1$$f600$$ENDHEX$$glich
// 24 =	Ratio Klassen				Ratiolist auf alle Buchungsklassen	
// 25 =	Ratio II Klassen			Ratiolist 2 auf alle Buchungsklassen	
// 26 =	Ratio Klassen 1+2			Ratiolist auf Buchungsklassen	1 und 2
// 27 =	Ratio II Klassen 1+2		Ratiolist 2 auf Buchungsklassen	1 und 2	
// ------------------------------------------------------------------------------------------------
// ab 16.02.07, KF
// ------------------------------------------------------------------------------------------------
// 28 = n% f$$HEX1$$fc00$$ENDHEX$$r Klasse 				
// 29 = Paxe n Klassen
// 30 = Paxe n Klassen + Prozent
// 31 = Paxe n Klassen Vielfach
// 32 = Paxe n Klassen Absolut
// 33 = Paxe n Klassen - Absolut
// 34 = Paxe n Klassen - Prozent
// 35 = Version n Klassen
// 36 = Version n Klassen + Prozent
// 37 = Version n Klassen Vielfach
// 38 = Version n Klassen Absolut
// 39 = Version n Klassen - Absolut
// 40 = Version n Klassen - Prozent
// 41 = Paxe n Klassen Prozent
// 42 = Version n Klassen Prozent
// 43 = Sitz Paxe n Klassen
// 44 = Version n Klassen - Prozent - LH Rundung
// 45 = Paxe n Klassen vielfach mit SPML-Abzug (TBR 16.05.2013)
// 46 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 47 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 48 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 49 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 50 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 51 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 52 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 53 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 54 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 55 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 56 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 57 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 58 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 59 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 60 = RESERVIERT f$$HEX1$$fc00$$ENDHEX$$r weitere MultiClass Berechnungsart
// 61 = Diff. Full House Prozent
// 62 = Diff. Full House Prozent kfm.
// 63 = Diff. Full House Prozent inkl. 0
// 64 = Prozent Vielfach f$$HEX1$$fc00$$ENDHEX$$r Gruppen
// 65 = Prozent abrunden (R$$HEX1$$fc00$$ENDHEX$$ckgabe immer mind. 1)
// 66 = Prozent abrunden (R$$HEX1$$fc00$$ENDHEX$$ckgabe kann 0 sein)
// 67 = Prozent City Pair 
// 68 = Vielfaches Max.			Wie Berechnugsart Vielfaches nur mit definierbarem H$$HEX1$$f600$$ENDHEX$$chstwert
// 69 = n% f$$HEX1$$fc00$$ENDHEX$$r Klasse - LH Rundung
// 70 = Bob Percentage + Minimum
// 71 = Bob Percentage - xx%
// 72 = Bob Percentage + Minimum (Immer abrunden)
// 73 = Bob Percentage - xx% (Immer abrunden)
// 74 = Bob Percentage + Minimum (kaufm$$HEX1$$e400$$ENDHEX$$nnisches Runden)
// 75 = Bob Percentage - xx% (kaufm$$HEX1$$e400$$ENDHEX$$nnisches Runden)
// 76 = Prozent abrunden +/- Absolut (R$$HEX1$$fc00$$ENDHEX$$ckgabe kann 0 sein)
// 77 = Feste Menge BOB
// 78	= Fixed Quantity (CP)
// 79	= BOB % CP Round Up with max 
// 80	= BOB % CP Round Down with max 
// 81	= BOB % CP Com with max 
// 82  = Ratiolist Percentage
// 83  = Ratiolist Percentage incl. Return Flight Pax Figures
// 90 = Value pro AC Type + Version
// 90 = Ratiolist Percentage + Group + Version Cutoff
//=================================================================================================
// 28.08.09, KF:
// Keine Ahnung wof$$HEX1$$fc00$$ENDHEX$$r Berechnungsart 66 & 67 vorgesehen waren, sind jedenfalls nicht in
// sys_calculator eingetragen, Code auskommentiert
// 66 = Prozent kaufm$$HEX1$$e400$$ENDHEX$$nnisch mit Vermeidung von 0
// =================================================================================================
// 01.11.2012, Gunnar Brosch
// 92 = Multiple & Fixed Calculation nach American Airlines
// 93 = Percentage Calculation nach American Airlines
// 94 = Link Calculation nach American Airlines
// 22.01.2013 HR:
// Verschieben 92 -> 95
// Verschieben 93 -> 96
// 92 = BOB Multiple N
// 93 = BOB Multiple N with Max
// 98 = percentage round-off with absolute
// 99 = Platzhalter f$$HEX1$$fc00$$ENDHEX$$r DL Bob Ersetzung
// 100 = Feste Menge bis zur Version/Pax-Differenz  ( 24.05.2013 HR)
// 101 = BOB % CP Round Off with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
// 102 = BOB % CP Round Down with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
// 103 = BOB % CP Round Up with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
// 104 = BOB %-xx% CP Round Up with max (CBASE-NAM-CR-13050 / 15.01.2014 OH)
// 105 = Feste Menge pro AC Typ & Version und Departure Station (CBASE-CR-UK-2015-014)
//	106 =	Vielfaches n; alle i Paxe n Anteile pro City Pair (Kopie von Calc Id 21; UK CR 2016-003)
//	107 = Analog bosta+ percentage, aber eben bis max config f$$HEX1$$fc00$$ENDHEX$$r die Klasse
//
// 02.11.2012: Gunnar Brosch: QuantityVersion eingebaut
// In il_calcbasis_ver steht das Analogon zur lCalcBasis
//=================================================================================================
long		lFind, j
Integer  iClasses[], iPax

long		llTopOffSPML
long		llQuantity

uf_trace(20,"uf_calculate(): start uf_set_meal_properties(" + string(lrow) + ")")

//
// Eigenschaften der Mahlzeit setzen
//
uf_set_meal_properties(lRow)
uf_trace(20,"uf_calculate(): end uf_set_meal_properties(), sProductionText=" + sProductionText)

//
// Mahlzeitenwechsel?
//
bNextMeal = false
if lHandlingKeyOld <> lHandlingKey then
	bNextMeal = true
	lHandlingKeyOld = lHandlingKey
end if

//
// SPML ermitteln
//
// lNumberOfSPML = Summe der SPML, die Auswirkungen auf Komponenten der Mahlzeit haben
//							(CALC-Basis)
//
// lMasterKey wurde in uf_set_meal_properties() ermittelt
// Dies ist der nhandling_meal_key, dem jetzt evtl. in cen_meals_spml ein 
// SPML-Objekt zugeordnet wurde.
// Diese Methode wird f$$HEX1$$fc00$$ENDHEX$$r jede Zeile der MZ-Def angesprungen. So h$$HEX1$$e400$$ENDHEX$$ufig mu$$HEX2$$df002000$$ENDHEX$$das SPML-
// Objekt jedoch nicht retrieved werden, da es maximal f$$HEX1$$fc00$$ENDHEX$$r jede ServiceStufe hinterlegt
// werden kann.
//
integer ideb
if lClassNumber = 3 then
	ideb++
end if

if isvalid(dsSPML) then
	if dsSPML.RowCount() > 0 then
		//
		// Achtung Fehlerbehebung:
		// 19.09.2006 Fehler behoben, aber zun$$HEX1$$e400$$ENDHEX$$chst auskommentiert...
		// bis auf weiteres bleibt alte Version erhalten
		
		//
		//	24.10.2005	if lHandlingKey 		<> lHandlingKeyOld	or &
		//					Neu: Wechsel der Mahlzeitendefinition wird als Anlass zur 
		//					Neuermittlung der SPML-Beladung genommen
		//
//		if sMealControlCode 	<> sMealControlCodeOld or &
//			lClassNumber		<> lClassNumberOld	then
//			lNumberOfSPML	= 0		// Summe der abzugsf$$HEX1$$e400$$ENDHEX$$higen SPML auf 0 setzen
//			lSPMLKeyOld		= 0		// Zum Klassenwechsel darf auch der SPML-Key resettet werden
//			uf_compile_spml()
//			sMealControlCodeOld = sMealControlCode
//			lClassNumberOld		= lClassNumber
//		end if
		//
		//	19.09.2006	Neu: Wechsel der Mahlzeitendefinition wird als Anlass zur 
		//					Neuermittlung der SPML-Beladung genommen
		//
		if bNextMeal or &
			sMealControlCode 	<> sMealControlCodeOld or &
			lClassNumber		<> lClassNumberOld	then
			lNumberOfSPML	= 0		// Summe der abzugsf$$HEX1$$e400$$ENDHEX$$higen SPML auf 0 setzen
			lSPMLKeyOld		= 0		// Zum Klassenwechsel darf auch der SPML-Key resettet werden
			uf_compile_spml()
			sMealControlCodeOld	= sMealControlCode
			lClassNumberOld		= lClassNumber
		end if
	else
		// --------------------------------------------------------------------------------------------------------------------
		// 05.11.2015 HR: Wenn wir keine SPMLs haben, dann setzen wir das auch auf 0
		// --------------------------------------------------------------------------------------------------------------------
		lNumberOfSPML	= 0		// Summe der abzugsf$$HEX1$$e400$$ENDHEX$$higen SPML auf 0 setzen
		lSPMLKeyOld		= 0		// Zum Klassenwechsel darf auch der SPML-Key resettet werden
	end if
end if
//
// Jetzt liegen die Details f$$HEX1$$fc00$$ENDHEX$$r jedes SPML vor
//

//
// Passagierzahl f$$HEX1$$fc00$$ENDHEX$$r Klasse ermitteln
//
if bInSimulation then
	//
	// bei der Simulation spielt die Klasse keine Rolle
	//
	lFind = dsCenOutPax.find("nresult_key = " + string(lresultkey) ,1,dsCenOutPax.RowCount())
else
	lFind = dsCenOutPax.find("nresult_key = " + string(lresultkey) + " and nclass_number = " + string(lClassNumber),1,dsCenOutPax.RowCount())
end if


if lFind <= 0 then
	sErrortext = "No passenger information found"
	return -1
end if

lPax 				= dsCenOutPax.GetItemNumber(lFind,"npax")
sClass				= dsCenOutPax.GetItemString(lFind,"cclass")
// --------------------------------------------------------------------------------------------------------------------
// 07.11.2013 HR: Nur bei Buchungsklassen nehmen wir die Version, Bei NBC nehmen wir die Paxe als Version
//                        Testingliste (LSY-4.96-083)
// --------------------------------------------------------------------------------------------------------------------
//iVersion			= dsCenOutPax.GetItemNumber(lFind,"nversion")
if  dsCenOutPax.GetItemNumber(lFind,"nbooking_class") = 1 then
	iVersion	= dsCenOutPax.GetItemNumber(lFind,"nversion")
else
	iVersion	= lPax
end if

//
// 24.02.2006 Manuell eingegebene Reserven $$HEX1$$fc00$$ENDHEX$$berschreiben die
// ermittelte Reserve aus uf_set_meal_properties
//
if not bInSimulation then
	setnull(lManualReserve)
	lManualReserve		= dsCenOutPax.GetItemNumber(lFind,"nmanual_reserve")	// 23.02.
	if not isnull(lManualReserve) then
		lReserveQuantity = lManualReserve
	end if
elseif bInReturnCalcMode then // 09.03., KF: RUS Returnmeal Calculation
	if not isnull( lManuelReserveReturnMealCalc	) then
		lReserveQuantity =  lManuelReserveReturnMealCalc	
	end if
end if

//
// Bei der Generierung ist die Manuelle Menge = der Pax-Zahl
//
// 18.03.05: if dsCenOutMealsOld.RowCount() = 0 then
if not isvalid(dsCurrentMeals) then
	dsCurrentMeals = Create uo_generate_datastore
end if
if dsCurrentMeals.RowCount() = 0 then
	lPaxManual = lPax
else
	//
	// Change-Gesch$$HEX1$$e400$$ENDHEX$$ft:
	// lPaxManual befindet sich auf Zeilenebene
	// Reserve- und TopOffMengen k$$HEX1$$f600$$ENDHEX$$nnten ge$$HEX1$$e400$$ENDHEX$$ndert worden sein
	//
	lPaxManual = uf_get_pax_manual()
end if

//
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Ausz$$HEX1$$e400$$ENDHEX$$hlung angesagt ist ($$HEX1$$fc00$$ENDHEX$$berschreibt dann die lPax)
//
uf_ask4passenger()

//11.06.2008 Neu: Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung der Unterbeladung auf Konzept-Ebene f$$HEX1$$fc00$$ENDHEX$$r Paxe, 
//				 wenn nicht manuell ge$$HEX1$$e400$$ENDHEX$$ndert
//If iManualInput = 0 And bCalculateConcDiff Then
//	uf_calc_paxConcDiff()
//End If

// TBR 25.02.2009: Abfrage iManualInput in die Funktion verlegt ...
If bCalculateConcDiff Then
	uf_calc_paxConcDiff()
End If
//
// Ermittlung der Berechnungsgrundlage lCalcBasis
//
uf_get_calc_basis()

//
// Falls SPML-Abzug f$$HEX1$$fc00$$ENDHEX$$r aktuelle Mahlzeitenkomponente gew$$HEX1$$fc00$$ENDHEX$$nscht, dann
// wird jetzt die lCalcBasis modifiziert
//
if iSPMLDeduction = 1 then
	lCalcBasis -= lNumberOfSPML
	if lCalcBasis < 0 then lCalcBasis = 0
end if

//
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob eine $$HEX1$$dc00$$ENDHEX$$berbeladung verrechnet werden soll
// findet testweise im w_change_center.wf_change_meals statt,
// da nur zum endg$$HEX1$$fc00$$ENDHEX$$ltigen Zeitpunkt der kompletten MZ-Kalkulation alles drin ist
//
//uf_check_overload()

lCurrentRow	= lRow	// Zeile im Meal-Datastore

//HR 07.07.2008 CBASE-UK-EM-4402
//Variable zur$$HEX1$$fc00$$ENDHEX$$cksetzen, so dass der normale Produktionstext benutzt wird.
sProductionTextReplace = ""


//If spackinglist = "0XLH40003" OR spackinglist = "OXLH40003" Then
//	spackinglist = spackinglist
//End If

// --------------------------------------------------------------------------------------------------------------------
// 06.08.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
// --------------------------------------------------------------------------------------------------------------------
Choose Case lCalcID
	case 1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95, 106
		uf_get_flight_parm_diff ( lHandlingDetailKey, il_flgnr, is_suffix, iPercentage, dcValue, lMinValue, lMaxValue)
End Choose

If isnull(dcValue) then
	dcValue = 0 
end if

// *************************************************************************************************************
// *************************************************************************************************************
// ***   
// ***   Achtung: $$HEX1$$c400$$ENDHEX$$nderungen und Erweiterung von CalcIDs m$$HEX1$$fc00$$ENDHEX$$ssen auch in  UF_START_CHANGE_ON_CEN_OUT nachgezogen werden   
// ***   
// *************************************************************************************************************
// *************************************************************************************************************
// Berechnung
Choose Case lCalcID
	case 1
		//
		// Feste Menge
		//
		dcQuantity 			= dcValue		
		idc_quantity_ver 	= dcValue;	 //02.11.2012: Gunnar Brosch: QuantityVersion
	case 2
		//
		// 100% f$$HEX1$$fc00$$ENDHEX$$r Klasse
		//
		dcQuantity 			= iVersion		
		idc_quantity_ver 	= iVersion;	//02.11.2012: Gunnar Brosch: QuantityVersion
	case 3
		//
		// Ratiolist
		//
		uf_calc_ratiolist(); 					// 08.11.12 Gunnar Brosch: QuantityVersion eingebaut
	case 4
		//
		// Normal
		//
		dcQuantity 			= lCalcBasis		
		idc_quantity_ver 	= il_calcbasis_ver; // 02.11.2012: Gunnar Brosch: QuantityVersion
	case 5
		//
		// Prozent
		//
		uf_calc_percent(0)					// 05.11.12: Gunnar Brosch: QuantityVersion eingebaut
	case 6
		//
		// Prozent kfm.
		//
		uf_calc_percent_com() 			// 06.11.12: Gunnar Brosch: QuantityVersion eingebaut
	case 7, 68
		//
		// Vielfaches
		//
		uf_calc_multiple(); 				// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
		
		// ------------------------------------------------
		// Bei Berechnungsart 68 hinterher nochmal gegen
		// die Obergrenze pr$$HEX1$$fc00$$ENDHEX$$fen
		// ------------------------------------------------
		if lCalcID = 68 and dcQuantity > lMaxValue then
			dcQuantity = lMaxValue
		end if
		//02.11.2012: Gunnar Brosch: QuantityVersion >>>
		if lCalcID = 68 and idc_quantity_ver > lMaxValue then
			idc_quantity_ver = lMaxValue;
		end if
		//<<<
	case 8
		//
		// Ganzzahliges
		//
		uf_calc_integer(); 					// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 9, 10
		//
		// Bosta-Plus
		//
		uf_calc_bosta_plus(); 				// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 11,12
		//
		// Bosta-Minus
		//
		uf_calc_bosta_minus(); 			// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 13
		//
		// Prozent-Vielfach
		//
		uf_calc_percent_multiple(); 		// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 14
		//
		// Prozent absolut
		//
		uf_calc_percent(dcValue);  		// 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
		// uf_calc_percent_abs()
	case 15, 16, 17
		//
		// Gesamtpassagierzahl
		//
		uf_calc_booking_classes();		 // 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 18
		//
		// St$$HEX1$$fc00$$ENDHEX$$cklisten Ratiolist
		//
		uf_calc_ratiolist2(); 				// 08.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 19
		//
		// Differenz zu Full-House
		//
		uf_calc_difference_fullhouse(); // 08.11.12, Gunnar Brosch: Quantity Version eingebaut
	case 20
		//
		// Prozent minus absolut
		//
		// uf_calc_percent_abs_minus()
		uf_calc_percent(dcValue * -1);  // 06.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 21
		//
		// Vielfaches m
		//
		uf_calc_multiple_m(); 			//07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 22
		//
		// Feste Menge ab i Paxe
		//
		if lCalcBasis >= iPercentage then
			dcQuantity = dcValue
		else
			dcQuantity = 0
		end if
		//02.11.2012: Gunnar Brosch: QuantityVersion >>>
		if il_calcbasis_ver >= iPercentage then
			idc_quantity_ver = dcValue;
		else
			idc_quantity_ver = 0;
		end if
		//<<<
	case 23
		//
		// Prozent inkl. Ergebnis 0
		//
		uf_calc_percent_zero(); 						// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 24
		//
		// Ratiolist auf Buchungsklassen
		//
		lCalcBasis = uf_get_booking_classes()	;	// Gunnar Brosch: Keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis, aber von nVersion
		uf_calc_ratiolist(); 								// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 25
		//
		// Ratiolist II auf Buchungsklassen
		//
		lCalcBasis = uf_get_booking_classes();	// Gunnar Brosch: Keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis, aber von nVersion
		uf_calc_ratiolist2(); 							// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 26
		//
		// Ratiolist auf Buchungsklassen
		//
		lCalcBasis = uf_get_booking_class_1_2(); //Gunnar Brosch: Keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist(); 								// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 27
		//
		// Ratiolist II auf Buchungsklassen
		//
		lCalcBasis = uf_get_booking_class_1_2()	// Gunnar Brosch: Keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist2(); 							// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	case 28
		// -----------------------------------------------------
		// n% f$$HEX1$$fc00$$ENDHEX$$r Klasse
		// -----------------------------------------------------

		// ------------------------------------------------------------------------------------------------------
		// TBR 17.12.2013 - Wegen Versionsbezug mu$$HEX2$$df002000$$ENDHEX$$die Anzahl SPML hier ermittelt werden
		lNumberOfSPML = 0
		if iSPMLDeduction = 1 then
			//MB 20.05.2015, damit auch manuelle Fluganlage funktioniert:
			if isvalid(dsspml) then
			for j = 1 to dsSPML.RowCount()
				if dsSPML.GetItemNumber(j,"nclass_number") = lClassNumber then
					llTopOffSPML = dsSPML.GetItemNumber(j,"ntopoff")
					//
					// TopOff-SPML d$$HEX1$$fc00$$ENDHEX$$rfen keinen Abzug erfahren
					//
					if llTopOffSPML = 0 then
						llQuantity = dsSPML.GetItemNumber(j,"nquantity")
						lNumberOfSPML += llQuantity
					end if
				end if
			next
			end if
		end if
		// ------------------------------------------------------------------------------------------------------		
		
		if iPercentage > 0 then
//			dcQuantity = Round(iVersion * iPercentage / 100, 0)
			dcQuantity = Round((iVersion - lNumberOfSPML) * iPercentage / 100, 0) // TBR 17.12.2013
		else
			dcQuantity = 0
		end if
		
		idc_quantity_ver = dcQuantity;	//02.11.2012: Gunnar Brosch: Keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis, daher so gesetzt
	case 29
		// -----------------------------------------------------
		// Paxe n Klassen
		// -----------------------------------------------------
		dcQuantity = uf_calc_multi_class_sum(1); 	// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut

		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
	
	
	case 30
		// -----------------------------------------------------
		// Paxe n Klassen + Prozent
		// -----------------------------------------------------
		uf_calc_multi_class_sum(1)																					// 29.11.12, Gunnar Brosch
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		dcQuantity 			= Round(dcQuantity + (dcQuantity* iPercentage / 100), 0); 					// 29.11.12, Gunnar Brosch
		idc_quantity_ver 	= Round(idc_quantity_ver + (idc_quantity_ver * iPercentage / 100), 0);	// 29.11.12, Gunnar Brosch																							
		
	case 31
		// -----------------------------------------------------
		// Paxe n Klassen Vielfach
		// -----------------------------------------------------
		lCalcBasis 		= uf_calc_multi_class_sum(1)	// 07.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		il_calcbasis_ver = idc_quantity_ver; 				// 29.11.12, Gunnar Brosch: siehe case 29
		uf_calc_multiple()										// 08.11.12, Gunnar Brosch: Quantity Version eingebaut
				
	case 32
		// -----------------------------------------------------
		// Paxe n Klassen Absolut
		// -----------------------------------------------------
		dcQuantity 			= uf_calc_multi_class_sum(1) + dcValue	// Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		idc_quantity_ver 	= idc_quantity_ver + dcValue;				// 29.11.12, Gunnar Brosch, daher so gesetzt
		
	case 33
		// -----------------------------------------------------
		//  Paxe n Klassen - Absolut
		// -----------------------------------------------------
		dcQuantity = uf_calc_multi_class_sum(1) - dcValue		// 07.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		if dcQuantity <= 0 then dcQuantity = 0
		idc_quantity_ver 	= idc_quantity_ver - dcValue;		// 29.11.12, Gunnar Brosch: daher so gesetzt.
		if idc_quantity_ver <= 0 then idc_quantity_ver = 0		// 29.11.12, Gunnar Brosch: daher so gesetzt.
		
	case 34
		// -----------------------------------------------------
		// Paxe n Klassen - Prozent
		// immer aufrunden 
		// -----------------------------------------------------
		uf_calc_multi_class_sum(1)																				//29.11.12, Gunnar Brosch: daher so gesetzt.
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		dcQuantity = Ceiling(dcQuantity - (dcQuantity * iPercentage / 100))							// 29.11.12, Gunnar Brosch: daher so gesetzt.
		idc_quantity_ver 	= Ceiling(idc_quantity_ver - (idc_quantity_ver * iPercentage / 100))	// 29.11.12, Gunnar Brosch: daher so gesetzt.
		
		
	case 35
		// -----------------------------------------------------
		// Version n Klassen
		// -----------------------------------------------------
		dcQuantity 			= uf_calc_multi_class_sum(2)	// 07.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
	
	case 36
		// -----------------------------------------------------
		// Version n Klassen + Prozent
		// -----------------------------------------------------
		uf_calc_multi_class_sum(2) 																				//29.11.12, Gunnar Brosch: daher so gesetzt.
		dcQuantity = Round(dcQuantity+ (dcQuantity * iPercentage / 100), 0)							// 29.11.12, Gunnar Brosch: daher so gesetzt.
		idc_quantity_ver = Round(idc_quantity_ver+ (idc_quantity_ver * iPercentage / 100), 0)	// 29.11.12, Gunnar Brosch: daher so gesetzt.																								// 08.11.12, Gunnar Brosch: daher so gesetzt.
				
	case 37
		// -----------------------------------------------------
		// Version n Klassen Vielfach
		// -----------------------------------------------------
		lCalcBasis 		= uf_calc_multi_class_sum(2)	// 07.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		il_calcbasis_ver = idc_quantity_ver;				// 29.11.12, Gunnar Brosch: daher so gesetzt.
		uf_calc_multiple()										// Quantity Version eingebaut
		 						
	case 38
		// -----------------------------------------------------
		// Version n Klassen Absolut
		// -----------------------------------------------------
		dcQuantity 			= uf_calc_multi_class_sum(2) + dcValue	// 08.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		idc_quantity_ver 	= idc_quantity_ver + dcValue;				// 29.11.12, Gunnar Brosch: daher so gesetzt.
						
	case 39
		// -----------------------------------------------------
		// Version n Klassen - Absolut
		// -----------------------------------------------------
		dcQuantity = uf_calc_multi_class_sum(2) - dcValue				// 08.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		if dcQuantity <= 0 then dcQuantity = 0
		idc_quantity_ver 	= idc_quantity_ver - dcValue;				// 29.11.12, Gunnar Brosch: daher so gesetzt.
		if idc_quantity_ver <= 0 then idc_quantity_ver = 0				// 29.11.12, Gunnar Brosch: daher so gesetzt.
						
	case 40
		// -----------------------------------------------------
		// Version n Klassen - Prozent
		// immer aufrunden 
		// -----------------------------------------------------
		uf_calc_multi_class_sum(2)																			//29.11.12, Gunnar Brosch: daher so gesetzt.
		dcQuantity = Ceiling(dcQuantity - (dcQuantity * iPercentage / 100))						// 29.11.12, Gunnar Brosch: daher so gesetzt.
		idc_quantity_ver = Ceiling(idc_quantity_ver - (idc_quantity_ver * iPercentage / 100));	// 29.11.12, Gunnar Brosch: daher so gesetzt.
		
	
	case 41
		// -----------------------------------------------------
		// Paxe n Klassen Prozent
		// -----------------------------------------------------
		uf_calc_multi_class_sum(1) 
		IF 	dcQuantity	>= 	il_spml_count THEN  // TBR 16.12.2013
			dcQuantity	  = 	dcQuantity  - il_spml_count
		END IF
		dcQuantity = Round(dcQuantity * iPercentage / 100, 0)				// 29.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung
		idc_quantity_ver = Round(idc_quantity_ver * iPercentage / 100, 0);	// 29.11.12, Gunnar Brosch: daher so gesetzt.

	case 42
		// -----------------------------------------------------
		// Version n Klassen Prozent
		// -----------------------------------------------------
		uf_calc_multi_class_sum(2)
		dcQuantity = Round(dcQuantity* iPercentage / 100, 0)					// 29.11.12, Gunnar Brosch: keine $$HEX1$$c400$$ENDHEX$$nderung, keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		idc_quantity_ver = Round(idc_quantity_ver* iPercentage / 100, 0)	// 29.11.12, Gunnar Brosch: daher so gesetzt.

	case 43
		// -----------------------------------------------------
		// Sitz Paxe n Klassen
		// -----------------------------------------------------
		dcQuantity = uf_calc_multi_class_sum(3)			// 08.11.12, Gunnar Brosch
		
	case 44
		// -----------------------------------------------------
		// Version n Klassen Prozent LH Rundung
		// -----------------------------------------------------
		uf_calc_version_n_classes_percent_lh(); 			// 07.11.12, Gunnar Brosch: QunatityVersion eingebaut
		

	case 45
		// -----------------------------------------------------------------
		// Paxe n Klassen vielfach mit SPML-Abzug TBR 16.05.2013
		// -----------------------------------------------------------------
		lCalcBasis 		= uf_calc_multi_class_sum(4)
		//09.08.2013 MB: SPML von Calcbasis abziehen, nicht vom Ergebnis
		lCalcBasis = lCalcBasis  - il_spml_count
		il_calcbasis_ver = idc_quantity_ver;			
		uf_calc_multiple()		
		//dcQuantity		= dcQuantity - il_spml_count


// -----------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r CalcID 61,62,63
// -----------------------------------------------------------------
//MHO 2016-09-30: Werte kleiner Null f$$HEX1$$fc00$$ENDHEX$$r lCalcBasis werden auf Null gesetzt
//https://cbasealm.ads.dlh.de/plugins/tracker/?aid=1397
//If the pax count is greater than config, then the system will calculate the wrong figures.
//The correct quantity should be 0.
// -----------------------------------------------------------------

	case 61
		// -----------------------------------------------------
		// Diff. Full House Prozent
		// -----------------------------------------------------
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		il_calcbasis_ver = iVersion - il_calcbasis_ver; 	// 07.11.12, Gunnar Brosch: QuantityVersion
		uf_calc_percent(0)										// Gunnar Brosch: QuantityVersion eingebaut
				
	case 62
		// -----------------------------------------------------
		// Diff. Full House Prozent kfm.
		// -----------------------------------------------------
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		il_calcbasis_ver = iVersion - il_calcbasis_ver; 	// 07.11.12, Gunnar Brosch: QuantityVersion
		uf_calc_percent_com();								// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
		
	case 63
		// -----------------------------------------------------
		// Diff. Full House Prozent inkl 0
		// -----------------------------------------------------
		lCalcBasis 		= iVersion - lCalcBasis
		if lCalcBasis < 0 then lCalcBasis = 0
		il_calcbasis_ver = iVersion - il_calcbasis_ver; 	// 07.11.12, Gunnar Brosch: QuantityVersion
		uf_calc_percent_zero()								// Gunnar Brosch: QuantityVersion eingebaut

	case 64
		// -----------------------------------------------------
		// Prozent Vielfach f$$HEX1$$fc00$$ENDHEX$$r Gruppen
		// -----------------------------------------------------
		uf_calc_percent_multiple_for_groups();			// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut
	
	case 65, 66	// 07.11.12, Gunnar Brosch: QuantityVersion
		// -----------------------------------------------------
		// Prozent abrunden
		// -----------------------------------------------------
		if lCalcID = 65 then
			uf_calc_percent_round_down(0, 1);		// Gunnar Brosch: QuantityVersion eingebaut
		else
			uf_calc_percent_round_down(0, 0);		// Gunnar Brosch: QuantityVersion eingebaut
		end if

		
//	case 66
//		// -----------------------------------------------------
//		// Prozent kfm. inkl. null
//		// -----------------------------------------------------
//		uf_calc_percent_com_no_null()


	case 67
		// -----------------------------------------------------
		// Prozentbeladung mit den Prozenten am City pair
		// -----------------------------------------------------
		uf_calc_percent_by_cp(0);						// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut

	
//	case 68 		
		// -----------------------------------------------------
		// F$$HEX1$$fc00$$ENDHEX$$r Berechnungsart 68 wurde keine eigene Funktion
		// erstellt, siehe Berechnungsart 7
		// -----------------------------------------------------	
	
	
	case 69	
		// -----------------------------------------------------
		// 69 = n% f$$HEX1$$fc00$$ENDHEX$$r Klasse LH Rundung
		// -----------------------------------------------------
		uf_calc_n_percent_for_class_lh();				// 07.11.12, Gunnar Brosch: QuantityVersion
	
	
	case 70,71, 104		
		// --------------------------------------------------------------------------------------------------------------------
		// 16.04.2010 HR:   70 Bob Percentage + Minimum
		//						 71 Bob Percentage - xx%  + Minimum
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent(lCalcID); 		// 07.11.12, Gunnar Brosch: QuantityVersion eingebaut

	case 72,73
		// --------------------------------------------------------------------------------------------------------------------
		// 17.05.2010 HR:   72 Bob Percentage + Minimum (Immer abrunden)
		//						73 Bob Percentage - xx% + Minimum (Immer abrunden)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_round_down(lCalcID); 	// 07.11.12, Gunnar Brosch: QuantityVersion: angepasst
	
	case 74,75
		// --------------------------------------------------------------------------------------------------------------------
		// 10.06.2010 HR:   74 Bob Percentage + Minimum (k$$HEX1$$e400$$ENDHEX$$ufm$$HEX1$$e400$$ENDHEX$$nnisch Runden)
		//						75 Bob Percentage - xx% + Minimum (k$$HEX1$$e400$$ENDHEX$$ufm$$HEX1$$e400$$ENDHEX$$nnisch Runden)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_com(lCalcID);			// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut

	case 76
		// --------------------------------------------------------------------------------------------------------------------
		// 17.06.2010 HR: Prozent abrunden +/- Absolut (R$$HEX1$$fc00$$ENDHEX$$ckgabe kann 0 sein)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_percent_round_down(dcValue, 0);	// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut
	
	case 77
		// --------------------------------------------------------------------------------------------------------------------
		//
		// Feste Menge BOB
		//
		// --------------------------------------------------------------------------------------------------------------------
		//dcQuantity = dcValue
		uf_calc_bob_fixed()				// 28.11.12, Gunnar Brosch: QuantityVersion:  keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		idc_quantity_ver = dcQuantity;	// 28.11.12, Gunnar Brosch: daher so gesetzt.: 
	
	case 78
		// --------------------------------------------------------------------------------------------------------------------
		//
		// Feste Menge City Pair
		//
		// --------------------------------------------------------------------------------------------------------------------
		//dcQuantity = dcValue
		uf_calc_fixed_cp()					// Gunnar Brosch: QuantityVersion:  keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		idc_quantity_ver = dcQuantity;	// 14.11.12, Gunnar Brosch: daher so gesetzt.:
	
	case 79		
		// --------------------------------------------------------------------------------------------------------------------
		//	BOB % CP Round Up with max 
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent(lCalcID);		// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut

	case 80
		// --------------------------------------------------------------------------------------------------------------------
		// 80	= BOB % CP Round Down with max 
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_round_down(lCalcID);	// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut
	
	case 81
		// --------------------------------------------------------------------------------------------------------------------
		// 81	= BOB % CP Com with max 
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_com(lCalcID);			// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut.
	
		// 78	= Fixed Quantity (CP)
		// 79	= BOB % CP Round Up with max 
		// 80	= BOB % CP Round Down with max 
		// 81	= BOB % CP Com with max 
		
	case 82
		// --------------------------------------------------------------------------------------------------------------------
		// 82 = Ratiolist Precentage
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_ratiolist_percentage(0);					// 14.11.12, Gunnar Brosch: QuantityVersion eingebaut.
		
	case 83
		// --------------------------------------------------------------------------------------------------------------------
		// 83  = Ratiolist Precentage incl. Return Flight Pax Figures
		// --------------------------------------------------------------------------------------------------------------------
		uf_add_return_flight_pax()						// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.
		uf_calc_ratiolist()									// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.

	case 84
		// --------------------------------------------------------------------------------------------------------------------
		// 84  = Ratiolist I auf addierte Paxe aus n Klassen anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist(1) 			// 16.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist()									// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.
		
	case 85
		// --------------------------------------------------------------------------------------------------------------------
		// 85  = Ratiolist II auf addierte Paxe aus n Klassen anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist(1) 			// 20.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist2()									// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.

	case 86
		// --------------------------------------------------------------------------------------------------------------------
		// 86  = Ratiolist I auf addierte Versionen aus n Klassen anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist(2) 			// 20.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist()									// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.

	case 87
		// --------------------------------------------------------------------------------------------------------------------
		// 87  = Ratiolist II auf addierte Versionen aus n Klassen anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist(2) 			// 20.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist2()									// 20.11.12, Gunnar Brosch: Quantity Version eingebaut

	case 88
		// --------------------------------------------------------------------------------------------------------------------
		// 88  = Ratiolist I auf addierte Versionen aus n Klassen - SPML anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist_spml(2) 	// 20.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist()									// 15.11.12, Gunnar Brosch: QuantityVersion eingebaut.

	case 89
		// --------------------------------------------------------------------------------------------------------------------
		// 89  = Ratiolist II auf addierte Versionen aus n Klassen - SPML anwenden
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_multiclass_sum_ratiolist_spml(2) 	// 20.11.12, Gunnar Brosch: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit von lCalcBasis
		uf_calc_ratiolist2()									// 20.11.12, Gunnar Brosch: Quantity Version eingebaut

	case 90
		// --------------------------------------------------------------------------------------------------------------------
		//
		// Feste Menge pro AC Version
		//
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_fixed_ac_version()						// 20.11.12, Gunnar Brosch: Quantity Version eingebaut
	
	case 91
		// --------------------------------------------------------------------------------------------------------------------
		// 91 = Ratiolist Percentage + Group + Version Cutoff
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_percent_version_cutoff()				// 20.11.12, Gunnar Brosch: Quantity Version eingebaut

	case 92
		// --------------------------------------------------------------------------------------------------------------------
		// 22.01.2013 HR: 92 = BOB Multiple N  (z.B. 3 St$$HEX1$$fc00$$ENDHEX$$ck pro 5 Paxe)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_multiple(0)
		
	case 93
		// --------------------------------------------------------------------------------------------------------------------
		// 22.01.2013 HR: 93 = BOB Multiple N  with Max (z.B. 3 St$$HEX1$$fc00$$ENDHEX$$ck pro 5 Paxe)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_multiple(1)
		
	//Gunnar Brosch, 10.10.2012
	case 94
		// --------------------------------------------------------------------------------------------------------------------
		// 94 = Link Calculation nach American Airlines
		// --------------------------------------------------------------------------------------------------------------------
		uf_trace(5, "uf_calculate: case=" + string(lCalcID) +  ", lCurrentRow=" + string(lCurrentRow));
		uf_calc_linked_aa();

	//Gunnar Brosch, 10.10.2012
	case 95   // 22.01.2013 HR: vorher 92
		// --------------------------------------------------------------------------------------------------------------------
		// 95 = Multiple & Fixed Calculation nach American Airlines
		// --------------------------------------------------------------------------------------------------------------------
		uf_trace(5, "uf_calculate: case=" + string(lCalcID) +  ", lCurrentRow=" + string(lCurrentRow));
		uf_calc_multiple_fixed_aa();
		
	//Gunnar Brosch, 10.10.2012
	case 96   // 22.01.2013 HR: vorher 93
		// --------------------------------------------------------------------------------------------------------------------
		// 96 = Percentage Calculation nach American Airlines
		// --------------------------------------------------------------------------------------------------------------------
		uf_trace(5, "uf_calculate: case=" + string(lCalcID) +  ", lCurrentRow=" + string(lCurrentRow));
		uf_calc_percent_aa();
		
	case 98   // 27.03.2013 CBASE-ZA-CR-8005
		// --------------------------------------------------------------------------------------------------------------------
		// 98 = percentage round-off with absolute
		// --------------------------------------------------------------------------------------------------------------------
		uf_trace(5, "uf_calculate: case=" + string(lCalcID) +  ", lCurrentRow=" + string(lCurrentRow))
		uf_calc_percent_round_off_with_absolute()

	// --------------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------------------------------------------------------------------------
	case 99 // 99 = Platzhalter f$$HEX1$$fc00$$ENDHEX$$r DL Bob Ersetzung (ID nicht anderweitig benutzen)
		// --------------------------------------------------------------------------------------------------------------------
		// 19.08.2013 HR: Falls hier immer noch 99 stehen sollte, dann rechnen wir wie bei 
		// 						BOB % CP Round UP with minimum (CALC-ID 70)
		//                        CBASE-NAM-CR-13029
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent(lCalcID); 		

	// --------------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------------------------------------------------------------------------

	case 100
		// --------------------------------------------------------------------------------------------------------------------
		// 100 = Feste Menge bis zur Version/Pax-Differenz  ( 24.05.2013 HR) /  Fehlerliste 4.93 #7
		// --------------------------------------------------------------------------------------------------------------------
		uf_trace(5, "uf_calculate: case=" + string(lCalcID) +  ", lCurrentRow=" + string(lCurrentRow))
		
		// 28.05.2013 HR: lCalcBasis durch lPax ersetzt
		// 19.07.2013 HR: Reserve(lReserveQuantity) soll noch mit ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
		if iVersion - lPax - lReserveQuantity >= dcValue then
			dcQuantity 			= dcValue		
		else
			dcQuantity 			=  iVersion - lPax	- lReserveQuantity	
		end if

			
		idc_quantity_ver 	= 0

	case 101		
		// --------------------------------------------------------------------------------------------------------------------
		// 101 = BOB % CP Round Off with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_com(lCalcID);			
		
	case 102
		// --------------------------------------------------------------------------------------------------------------------
		// 102 = BOB % CP Round Down with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent_round_down(lCalcID);	

	case 103
		// --------------------------------------------------------------------------------------------------------------------
		//	103 = BOB % CP Round Up with MinMax  (CBASE-CR-NAM-12085 / 20.09.2013 HR)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_bob_percent(lCalcID);	

	case 105
		// --------------------------------------------------------------------------------------------------------------------
		// 105 = Feste Menge pro AC Typ & Version und Departure Station (CBASE-CR-UK-2015-014)
		// --------------------------------------------------------------------------------------------------------------------
		uf_calc_fixed_acver_tlcfrom() 
		
	case 106
		//
		// Vielfaches m / City Pair
		//
		uf_calc_multiple_m_cp(); 			//2016-04-01 UK-CR-2016-003
		
	case 107
		//
		// "Analog bosta+ percentage, aber eben bis max config f$$HEX1$$fc00$$ENDHEX$$r die Klasse"
		//
		uf_calc_bosta_plus_reserve(); 				// CBASE-DE-CR-2016-020


	case else
		//
		// Im Zweifel immer 1:1
		//
		dcQuantity = lCalcBasis
		idc_quantity_ver = il_calcbasis_ver;
		
End Choose

//
// 04.02.05 OnRequest ergibt immer 0
//
if lFlightStatus = 2 then
	dcQuantity = 0
end if
//
// 26.10.05 Delivery ergibt auch immer 0
// 28.10.05 MUC m$$HEX1$$f600$$ENDHEX$$chte doch nicht
//
//if iDelivery = 1 then
//	dcQuantity = 0
//end if

uf_trace(20,"uf_calculate(): end")

return 0

end function

protected function integer uf_calc_percent_com ();//=================================================================================================
//
// uf_calc_percent_com
//
// Prozentberechnung mit kaufm$$HEX1$$e400$$ENDHEX$$nnischer Rundung
//
// 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
//=================================================================================================
long		i

integer	iPerc
integer	iPercCounter						// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents					// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter					// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	li_MealCounter_ver = 0;		// 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
integer	iExpectedMeals					// Anzahl der Malzeiten, wenn iPercCounter direkt mit Berechnungs-
												// Grundlage multipliziert wird als Abgleich
integer	li_ExpectedMeals_ver = 0;	// 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut										
decimal	dcResult
decimal	dcResult_ver = 0; 				// 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version"); //06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )

dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	dcResult			= Int((lCalcBasis * iPerc / 100) + 0.5)
	dcResult_ver 	= int((il_calcbasis_ver * iPerc / 100) + 0.5); // 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
	
	// *RR* hier zu fr$$HEX1$$fc00$$ENDHEX$$h? m$$HEX1$$fc00$$ENDHEX$$sste ggf. als allerletztes umgesetzt werden 
	if dcResult < 1 then dcResult = 1	
	dcResult_ver = max(1, dcResult_ver); // 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver); // 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut
	iMealCounter 			+= dcResult
	li_MealCounter_ver 	+= dcResult_ver; // 06.11.12, Gunnar Brosch: QuantiyVersion eingebaut	
next


/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/

// 06.11.12, Gunnar Brosch: an das Ende gestzt, da sonst keine il_calcbasis_ver-Berechnung mehr durchgef$$HEX1$$fc00$$ENDHEX$$hrt w$$HEX1$$fc00$$ENDHEX$$rde ************>>>
/*
//
// Bei CalcBasis = 0: raus hier, sonst Probleme mit iExpectedMeals
//
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
end if
*/
//**********************************************************************************************<<<<<<<<<<<G. Brosch
//


// 06.11.12, Gunnar Brosch: Nur f$$HEX1$$fc00$$ENDHEX$$r  lCalcBasis > 0 *********************************************>>>
if lCalcBasis > 0 then
// Diese Anzahl Mahlzeiten darf auf keinen Fall $$HEX1$$fc00$$ENDHEX$$berschritten werden
//
iExpectedMeals	= Int((lCalcBasis * iPercCounter / 100) + 0.5)

if iMealCounter < iExpectedMeals then
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if iMealCounter > lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if iMealCounter < lCalcBasis then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if iMealCounter > iExpectedMeals and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			if iMealCounter < iExpectedMeals then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
else
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if iMealCounter > lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				//
				// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
				//
				if dcResult > 1 then
					dcResult --
					iMealCounter --
					dscenmeals.SetItem(i,"nquantity",dcResult)
				end if
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if iMealCounter < lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if iMealCounter > iExpectedMeals and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			if iMealCounter < iExpectedMeals then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
end if

//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 

end if // 06.11.12, Gunnar Brosch: Nur f$$HEX1$$fc00$$ENDHEX$$r lCalcBasis > 0 ************************************************<<<<

// 06.11.12, Gunnar Brosch: Nur f$$HEX1$$fc00$$ENDHEX$$r  il_calcbasis_ver > 0 > 0 *********************************************>>>
if il_calcbasis_ver > 0 then
// Diese Anzahl Mahlzeiten darf auf keinen Fall $$HEX1$$fc00$$ENDHEX$$berschritten werden
//
li_ExpectedMeals_ver= Int((il_calcbasis_ver * iPercCounter / 100) + 0.5)

if li_MealCounter_ver < li_ExpectedMeals_ver then
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if li_MealCounter_ver > il_calcbasis_ver and li_MealCounter_ver > iComponents then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver --
				li_MealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if li_MealCounter_ver < il_calcbasis_ver then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver ++
				li_MealCounter_ver ++
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if li_MealCounter_ver > li_ExpectedMeals_ver and li_MealCounter_ver > iComponents then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver --
				li_MealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
			if li_MealCounter_ver < li_ExpectedMeals_ver then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver ++
				li_MealCounter_ver ++
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
else
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if li_MealCounter_ver > il_calcbasis_ver and li_MealCounter_ver > iComponents then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				//
				// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
				//
				if dcResult_ver > 1 then
					dcResult_ver --
					li_MealCounter_ver --
					dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
				end if
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if li_MealCounter_ver < il_calcbasis_ver and li_MealCounter_ver > iComponents then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver ++
				li_MealCounter_ver ++
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if li_MealCounter_ver > li_ExpectedMeals_ver and li_MealCounter_ver > iComponents then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver --
				li_MealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
			if li_MealCounter_ver < li_ExpectedMeals_ver then
				dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
				dcResult_ver ++
				li_MealCounter_ver ++
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
end if

//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet_ver = li_MealCounter_ver - il_calcbasis_ver;
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 

end if // 06.11.12, Gunnar Brosch: Nur f$$HEX1$$fc00$$ENDHEX$$r lCalcBasis > 0 **************************************<<<<

//06.11.12, Gunnar Brosch: jetzt die beiden 0-F$$HEX1$$e400$$ENDHEX$$lle *******************************************>>>
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
end if

if il_calcbasis_ver = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0
end if

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

//06.11.12, Gunnar Brosch: QuantityVerion: Und tsch$$HEX1$$fc00$$ENDHEX$$ss...
return 0;
end function

public function long uf_calc_paxconcdiff ();///Berechnung der Paxe unter Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung abweichender Beladung
Long		ll_mealCatKey
Decimal	ldec_percent
Decimal	ldec_value
String	ls_find
Long		ll_row
Integer	li_nask4passenger
Long		ll_nhandling_key_conc

// iManualInput
//Ermittlung der Meal-Kategorie

If Not IsNull(lMopDetailKey) And lMopDetailKey > 0 Then
	
	SELECT 	CEN_CONC_KIT_DETAIL.NMEAL_CAT_KEY
	
	INTO 		:ll_mealCatKey
	
	FROM 	CEN_CONC_KIT_DETAIL
	
	JOIN		CEN_MOP_DETAIL
	ON			CEN_MOP_DETAIL.NCONC_KIT_DETAIL_KEY			=	CEN_CONC_KIT_DETAIL.NCONC_KIT_DETAIL_KEY
	
	WHERE	CEN_MOP_DETAIL.NMOP_DETAIL_KEY 				= :lMopDetailKey																								AND	
				:dGenerationDate 								  BETWEEN CEN_MOP_DETAIL.DVALID_FROM        	AND	CEN_MOP_DETAIL.DVALID_TO 				AND
				:dGenerationDate 								  BETWEEN CEN_CONC_KIT_DETAIL.DVALID_FROM 	AND	CEN_CONC_KIT_DETAIL.DVALID_TO;
			
	//If SQLCA.SQLCode = 100 Then Return lPaxManual  //Kein Mop => keine Unterbeladung
	IF	SQLCA.SQLCode = 100 Then 
		ibo_concdiff	 = FALSE //  keine Unterbeladung
		RETURN lPax  //Kein Mop => keine Unterbeladung
	ELSE
		SELECT 	CEN_MOP_MASTER.NASK4PASSENGER ,
					CEN_MOP_MASTER.NHANDLING_KEY_CONC
		INTO		:li_nask4passenger,
					:ll_nhandling_key_conc // TBR 07.05.09 Konzept-Key mit aufgenommen
		FROM		CEN_MOP_DETAIL
		JOIN		CEN_MOP_MASTER
		ON			CEN_MOP_MASTER.NMOP_KEY = CEN_MOP_DETAIL.NMOP_KEY
		WHERE	CEN_MOP_DETAIL.NMOP_DETAIL_KEY 				= :lMopDetailKey;																								
	END IF

	// TBR 07.05.2009: 	Folgende Einschr$$HEX1$$e400$$ENDHEX$$nkung nach R$$HEX1$$fc00$$ENDHEX$$cksprache mit Herrn Vogel ausgebaut.
	//							Die Abweichende Beladung soll grunds$$HEX1$$e400$$ENDHEX$$tzlich auch bei manueller Eingabe
	//							ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
	
								//	// TBR 25.02.2009
								//	//	Wenn manuelle Eingabe und KEIN Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog => keine abweichende Beladung
								//	
								//	IF li_nask4passenger = 0 AND  iManualInput = 1 THEN
								//		ibo_concdiff	 = FALSE //  keine Unterbeladung		
								//		RETURN lPax
								//	END IF

	// TBR 25.02.2009
	//  D.h. auch: Es geht hier nur weiter wenn: 	- Mop zu MZ-Def vorhanden (=> nur Auslandscaterer s.o.) 		UND
	//															- Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog (egal ob manuell oder nicht) 					ODER
	//														 	- keine manuelle Eingabe
	// Dies ist wichtig, weil weiter unten immer auch lPaxManual berechnet wird (wegen uf_get_calc_basis), 
	// aber eben nur unter den o.a. Bedingungen
End If

ls_find = "nhandling_key_conc = " + String(ll_nhandling_key_conc) +" and nmeal_cat_key = " + String(ll_mealCatKey) // TBR 07.05.09 Konzept mit in Filter aufgenommen
ll_row = dsHandlingDiff.Find(ls_find, 1, dsHandlingDiff.RowCount())

//Falls die Mahlzeitenkategorie nicht gefunden wurde, 
//pr$$HEX1$$fc00$$ENDHEX$$fen ob eine Unterbeladung f$$HEX1$$fc00$$ENDHEX$$r alle Mahlzeitenkategorien angegeben ist (nmeal_cat_key ist NULL)
//Diese wird dann verwendet
If ll_row <= 0 Then 
	ls_find =  "nhandling_key_conc = " + String(ll_nhandling_key_conc) + " and IsNull(nmeal_cat_key)" // TBR 07.05.09 Konzept mit in Filter aufgenommen
	ll_row = dsHandlingDiff.Find(ls_find, 1, dsHandlingDiff.RowCount())
	
	If ll_row <= 0 Then
		ibo_concdiff	 = FALSE //  keine Unterbeladung				
		Return lPaxManual
	END IF
	
End If

ldec_percent = dsHandlingDiff.GetItemDecimal(ll_row, "npercentage")
ldec_value = dsHandlingDiff.GetItemDecimal(ll_row, "nvalue")

If IsNull(ldec_percent) Then ldec_percent = 0
If IsNull(ldec_value) Then ldec_value = 0

ldec_percent = ldec_percent / 100
//Berechnung (immer aufgerundet)
//lPaxManual = Ceiling(lPaxManual + lPaxManual * ldec_percent + ldec_value)
lPax 						= Ceiling(lPax + lPax * ldec_percent + ldec_value)

// TBR 25.02.2009
// wegen uf_get_calc_basis muss auch das manuelle Feld hier berechnet werden
// (Erkl$$HEX1$$e400$$ENDHEX$$rung siehe weiter oben)

lPaxManualConcDiff	= Ceiling(lPaxManual + lPaxManual * ldec_percent + ldec_value)
ibo_concdiff	 			= TRUE		

Return  lPax
end function

public function integer uf_calc_n_percent_for_class_lh ();//=================================================================================================
//
// uf_calc_n_percent_for_class_lh
//
// n% f$$HEX1$$fc00$$ENDHEX$$r Klasse Berechnung mit LH Rundung
//
// 07.11.12, Gunnar Brosch: QuantityVersion
// 17.12.12, Thomas Brackmann: Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung SPNL-Abzug eingebaut
//=================================================================================================
long		i
long		j

integer	iPerc
integer	iComponents		// Anzahl der Mahlzeiten in der Componentengruppe

decimal	dcResult

long		llTopOffSPML
long		llQuantity

// TBR 17.12.2013 - Wegen Versionsbezug mu$$HEX2$$df002000$$ENDHEX$$die Anzahl SPML hier ermittelt werden
lNumberOfSPML = 0
if iSPMLDeduction = 1 then
	for j = 1 to dsSPML.RowCount()
		if dsSPML.GetItemNumber(j,"nclass_number") = lClassNumber then
			llTopOffSPML = dsSPML.GetItemNumber(j,"ntopoff")
			//
			// TopOff-SPML d$$HEX1$$fc00$$ENDHEX$$rfen keinen Abzug erfahren
			//
			if llTopOffSPML = 0 then
				llQuantity = dsSPML.GetItemNumber(j,"nquantity")
				lNumberOfSPML += llQuantity
			end if
		end if
	next
end if
// ------------------------------------------------------------------------------------------------------		

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity")
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");	// 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if


//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc	= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	
	if iPerc > 0 then
		if mod(i, 2) = 1 then

			//aufrunden

			IF iSPMLDeduction = 1 THEN
				IF iVersion 	  >= lNumberOfSPML THEN
					dcResult 		= Ceiling(((iVersion - lNumberOfSPML) * iPerc) / 100)
				ELSE
					dcResult 		= 0
				END IF
			ELSE
					dcResult		= Ceiling((iVersion * iPerc) / 100)
			END IF
			
	else
		
			//abrunden
			
			IF iSPMLDeduction = 1 THEN
				IF iVersion 	  >= 	lNumberOfSPML THEN
					dcResult 		= 	Truncate((((iVersion - lNumberOfSPML) * iPerc) / 100), 0)
				ELSE
					dcResult 	  	= 	0
				END IF
			ELSE
					dcResult 		= Truncate(((iVersion * iPerc) / 100), 0)			
			END IF
				
		end if
	else
		dcResult = 0
	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult); // 07.11.12, Gunnar Brosch: QuantityVersion (dcResult unabh$$HEX1$$e400$$ENDHEX$$ngig von calcbasis)
	dscenmeals.SetItem(i,"nstatus",1)
next

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity 			= dscenmeals.GetItemDecimal(1,"nquantity")
idc_quantity_ver 	= dscenmeals.GetItemDecimal(1,"nquantity_version"); // 07.11.12, Gunnar Brosch: QuantityVersion
//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_calc_percent_com_no_null ();//=================================================================================================
//
// uf_calc_percent_com_no_null
//
// Prozentberechnung mit kaufm$$HEX1$$e400$$ENDHEX$$nnischer Rundung und Vermeidung von 0-Ergebnissen
//
//=================================================================================================
long		i

integer	iPerc
integer	iPercCounter	// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents		// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter	// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	iExpectedMeals	// Anzahl der Malzeiten, wenn iPercCounter direkt mit Berechnungs-
								// Grundlage multipliziert wird als Abgleich
decimal	dcOverload		// k$$HEX1$$fc00$$ENDHEX$$nstlich erzeugte $$HEX1$$dc00$$ENDHEX$$berbeladung, die dann wieder reduziert werden soll
decimal	dcResult

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )

dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenOutMeals.GetItemNumber(i, "nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	dcResult		= Int((lCalcBasis * iPerc / 100) + 0.5)
	
	// *RR* hier zu fr$$HEX1$$fc00$$ENDHEX$$h? m$$HEX1$$fc00$$ENDHEX$$sste ggf. als allerletztes umgesetzt werden 
	if dcResult < 1 then dcResult = 1
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	iMealCounter += dcResult
	
next


/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/

//
// Bei CalcBasis = 0: raus hier, sonst Probleme mit iExpectedMeals
//
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
end if

//
// Diese Anzahl Mahlzeiten darf auf keinen Fall $$HEX1$$fc00$$ENDHEX$$berschritten werden
//
iExpectedMeals	= Int((lCalcBasis * iPercCounter / 100) + 0.5)

if iMealCounter < iExpectedMeals then
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if iMealCounter > lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if iMealCounter < lCalcBasis then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if iMealCounter > iExpectedMeals and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			if iMealCounter < iExpectedMeals then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
else
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei 100%...
		//
		if iPercCounter = 100 then 
			if iMealCounter > lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				//
				// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
				//
				if dcResult > 1 then
					dcResult --
					iMealCounter --
					dscenmeals.SetItem(i,"nquantity",dcResult)
				end if
			end if
			//
			// Falls zu wenig beladen wurde durch Rundungsprobleme...
			//
			if iMealCounter < lCalcBasis and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme bei ungleich 100%...
		//
		if iPercCounter <> 100 then
			//
			// Gegenprobe gegen erwartete Meals bei Gesamtprozenten <> 100
			//
			if iMealCounter > iExpectedMeals and iMealCounter > iComponents then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
			if iMealCounter < iExpectedMeals then
				dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
				dcResult ++
				iMealCounter ++
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next
end if



//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 

//
// 29.11.07 Es darf auf keinen Fall eine 0 entstehen
//
for i = 1 to dscenmeals.RowCount()
	dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
	if dcResult < 1 then 
		dcResult = 1
		// k$$HEX1$$fc00$$ENDHEX$$nstliche $$HEX1$$dc00$$ENDHEX$$berbeladung erzeugen
		dcOverload++
		dscenmeals.SetItem(i,"nquantity",dcResult)
	end if
next
//
// k$$HEX1$$fc00$$ENDHEX$$nstliche $$HEX1$$dc00$$ENDHEX$$berbeladung wieder reduzieren, aber ohne dass es wider zu null-Mengen kommt
//
if dcOverload > 0 then
	for i = dscenmeals.RowCount() to 1 step -1
		dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
		if dcResult > 1 and dcOverload > 0 then
			dcResult --
			dcOverload --
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
	next
end if

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_calc_version_n_classes_percent_lh ();//=================================================================================================
//
// uf_calc_version_n_classes_percent_lh
//
// Version n Klassen - Prozent - Berechnung mit LH Rundung
//
// 07.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long		i

integer	iPerc
integer	iComponents		// Anzahl der Mahlzeiten in der Componentengruppe

decimal	dcResult
decimal	dcResult_ver	//29.11.2012, G. Brosch

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version") ; // 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if


//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc	= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	
	if iPerc > 0 then
		uf_calc_multi_class_sum(2)	//29.11.2012, G. Brosch
		if mod(i, 2) = 1 then
			//aufrunden
			dcResult = Ceiling(dcQuantity * iPerc / 100)				//29.11.2012, G. Brosch
			dcResult_ver = Ceiling(idc_quantity_ver * iPerc / 100)	//29.11.2012, G. Brosch
		else
			//abrunden
			dcResult = Truncate((dcQuantity * iPerc / 100), 0)					//29.11.2012, G. Brosch
			dcResult_ver = Truncate((idc_quantity_ver * iPerc / 100), 0)		//29.11.2012, G. Brosch
			
		end if
	else
		dcResult = 0
		dcResult_ver = 0	//29.11.2012, G. Brosch
	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver); 	// 07.11.12, Gunnar Brosch: QuantityVersion: Da die Berechnung oben unabh$$HEX1$$e400$$ENDHEX$$ngig
																		// von lCalcBasis ist, Wert $$HEX1$$fc00$$ENDHEX$$bernommen
	dscenmeals.SetItem(i,"nstatus",1)
next

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") ; // 07.11.12, Gunnar Brosch: QuantityVersion

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_calc_percent_round_down (decimal dcargument, integer idefault);//=================================================================================================
//
// uf_calc_percent_round_down
//
// Prozentberechnung immer abrunden
//
// 07.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long		i
long		lFind

integer	iPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents			// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter			// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	li_MealCounter_ver;
decimal	dcResult
decimal	dcResult_ver;			// 07.11.12, Gunnar Brosch: QuantityVersion

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");  // 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if

// --------------------------------------------------------------
// Komplette Gruppe holen
// --------------------------------------------------------------
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

// --------------------------------------------------------------
// Prozente ausrechnen immer abrunden
// 28.08.2009, KF
// CBASE-DE-EM-2059 wollte auch 0 als m$$HEX1$$f600$$ENDHEX$$glichen Wert, hierf$$HEX1$$fc00$$ENDHEX$$r
// neue Berechnungsart 66 und Parameter iDefault eingebaut
// --------------------------------------------------------------
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	dcResult		= truncate( ((lCalcBasis * iPerc)/100) ,0)
	dcResult_ver= truncate( ((il_calcbasis_ver * iPerc)/100) ,0);	// 07.11.12, Gunnar Brosch: QuantityVersion
	if dcResult < 1 		then dcResult 		= iDefault
	if dcResult_ver < 1 then dcResult_ver 	= iDefault; 				// 07.11.12, Gunnar Brosch: QuantityVersion
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver);		// 07.11.12, Gunnar Brosch: QuantityVersion
	
	iMealCounter 		+= dcResult
	li_MealCounter_ver	+= dcResult_ver;								// 07.11.12, Gunnar Brosch: QuantityVersion
	
	// --------------------------------------------------------------
	// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
	// --------------------------------------------------------------
	dscenmeals.SetItem(i,"nstatus",1)
	
next

// --------------------------------------------------------------
// 09.03.2007, KF
// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
// --------------------------------------------------------------
if dcArgument <> 0 then
	for i = 1 to dscenmeals.RowCount()
			
		dcResult 			= dscenmeals.GetItemDecimal(i, "nquantity") 			+ dcArgument
		dcResult_ver 	= dscenmeals.GetItemDecimal(i, "nquantity_version") + dcArgument;	// 07.11.12, Gunnar Brosch: QuantityVersion
		
		if dcResult 		< 0 then dcResult = 0
		if dcResult_ver 	< 0 then dcResult_ver = 0;					// 07.11.12, Gunnar Brosch: QuantityVersion		
		
		dscenmeals.SetItem(i,"nquantity",dcResult)
		dscenmeals.SetItem(i,"nquantity_version",dcResult_ver);	// 07.11.12, Gunnar Brosch: QuantityVersion		
	
	next 
end if

// --------------------------------------------------------------
// Menge des ersten Wertes der Gruppe setzen
// --------------------------------------------------------------
dcQuantity 			= dscenmeals.GetItemDecimal(1,"nquantity")
idc_quantity_ver 	= dscenmeals.GetItemDecimal(1,"nquantity_version");	// 07.11.12, Gunnar Brosch: QuantityVersion

// --------------------------------------------------------------
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
// --------------------------------------------------------------
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()


return 0

end function

public function integer uf_calculate4paula (long lrow, ref decimal radec_quantity, ref datastore rads_meals, long al_pax_num, string as_class);//=================================================================================================
//
// uf_start_simulation
//
//=================================================================================================
//
// Der Simulationslauf f$$HEX1$$fc00$$ENDHEX$$r eine Mahlzeitendefinition
//
//=================================================================================================
long		ll_Pax_Row, ll_Meals_Row
Integer li_Succ

bInSimulation	= true

//-------------------------------------------------------------------------------------
//
// Datastores Tauschen 
//
//-------------------------------------------------------------------------------------
//uf_switch_datasource()


//-------------------------------------------------------------------------------------
//
// Check Properties
//
//-------------------------------------------------------------------------------------

lSimulatePax = al_pax_num

if isnull(lSimulatePax) then
	sErrortext = "Meal Calculation got no passenger count!"
	return -1
end if

if isnull(lSimulateSPML) then
	lSimulateSPML = 0
end if

//if lSimulateVersion = 0 or isnull(lSimulateVersion) then
//	sErrortext = "Meal Calculation got no version boundary!"
//	return -1
//end if
//
//if lHandlingMealKey = 0 or isnull(lHandlingMealKey) then
//	sErrortext = "Meal Calculation got no meal key!"
//	return -1
//end if

if isnull(dGenerationDate) then
	dGenerationDate = today()
end if

//if isnull(sPlant) then
//	sErrortext = "Meal Calculation needs a plant!"
//	return -1
//end if

//-------------------------------------------------------------------------------------
//
// Fake der Properties 
//
//-------------------------------------------------------------------------------------
lResultKey = 4711

// Test ############
dsCenOutPax.reset()

ll_Pax_Row = dsCenOutPax.InsertRow(0)
dsCenOutPax.SetItem(ll_Pax_Row, "nresult_key",4711)
dsCenOutPax.SetItem(ll_Pax_Row, "nclass_number",2)
If as_Class = "" OR IsNULL(as_Class) Then as_Class = "C"
dsCenOutPax.SetItem(ll_Pax_Row, "cclass",as_Class)
dsCenOutPax.SetItem(ll_Pax_Row, "nversion",lSimulateVersion)
dsCenOutPax.SetItem(ll_Pax_Row, "npax",lSimulatePax)
dsCenOutPax.SetItem(ll_Pax_Row, "npax_spml",lSimulateSPML)
dsCenOutPax.SetItem(ll_Pax_Row, "cclass_name","Simulation")
dsCenOutPax.SetItem(ll_Pax_Row, "nbooking_class",1)
dsCenOutPax.SetItem(ll_Pax_Row, "ntransaction",4711)
dsCenOutPax.SetItem(ll_Pax_Row, "dtimestamp",datetime(today(),now()))
dsCenOutPax.SetItem(ll_Pax_Row, "nstatus",0)


//-------------------------------------------------------------------------------------
//
// G$$HEX1$$fc00$$ENDHEX$$ltige KVAs f$$HEX1$$fc00$$ENDHEX$$r Airline holen
//
//-------------------------------------------------------------------------------------
uf_retrieve_accounts()

//-------------------------------------------------------------------------------------
//
// Retrieve auf das Mahlzeitenobjekt
//
//-------------------------------------------------------------------------------------
//dsCenMeals.Retrieve(lHandlingMealKey, dgenerationdate)
// ##### Zeile nach dsCenMeals kopieren
dsCenMeals.reset()
li_Succ = rads_meals.rowscopy(lrow  ,lrow , Primary!, dsCenMeals, 1, Primary!)
// ....rowscopy(rads_meals)....
//If li_Succ = Then
// long startrow, long endrow, DWBuffer copybuffer, datawindow targetdw, long beforerow, DWBuffer targetbuffer
uf_replace_ratiolist3()

dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()
//f_print_datastore(dsCenMeals)

if dsCenMeals.RowCount() > 0 then
	//
	// Umlauf holen (einmal je Mahlzeitendefinition)
	//
	lRotation_key = dsCenMeals.GetItemNumber(1,"cen_meals_nrotation_key")
//	if uf_get_rotation(lRotation_key,0) <> 0 then	// Rotation-Key aus cen_meals
//		//
//		// Fehler beim Umlauf => Daten nicht schreiben
//		//
//		return -1
//	end if
end if
////
//// 17.03.2005: Umlauf filtern
////
//dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey))
//dsCenMeals.Filter()
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()

for ll_Meals_Row = 1 to dsCenMeals.RowCount()
//	if dsCenMeals.GetItemNumber(j,"nrotation_name_key") <> lRotationNameKey then
//		//
//		// Datensatz ist f$$HEX1$$fc00$$ENDHEX$$r anderen Umlauf bestimmt
//		//
//		continue
//	end if
	
	// 08.06.2010 HR: BOB-Kennzeichen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	ii_Bob=0

	//
	// Satz berechnen
	//
	if uf_calculate(ll_Meals_Row) <> 0 then
		//
		// Fehler bei Berechnung der Mahlzeit, Daten nicht schreiben
		//
		return -1
	end if
	//
	// Kurz-Von-An setzen (da uf_compile nicht aufgerufen wird)
	//
//	lAccountKey				= dsCenMeals.GetItemNumber(ll_Meals_Row, "cen_meals_detail_naccount_key")
//	lDefaultAccountKey 	= dsCenMeals.GetItemNumber(ll_Meals_Row, "ndefault_account_key")
	
//	if isnull(lAccountKey) or lAccountKey = 0 then
//		//
//		// Falls kein KVA auf Zeile gesetzt, dann Default verwenden
//		//
//		lAccountKey = lDefaultAccountKey
//	end if
//	//
//	// $$HEX1$$dc00$$ENDHEX$$bertrag nach cen_out_meals (dsCenOutMeals)
//	//
//	uf_insert_cen_out_meals()

	radec_quantity = dcQuantity

next

dsCenMeals.SetFilter("")
dsCenMeals.Filter()

return 0

end function

public function integer uf_calc_percent_by_cp (decimal dcargument);// --------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_percent_by_cp (Function)
// Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
// --------------------------------------------------------------------------------
// Argument(e):
// decimal dcargument
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:
//	Prozente sind am City Pair angewiesen
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  26.01.2010	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
//  14.11.2012			  Gunnar Brosch		QuantityVersion eingebaut
// --------------------------------------------------------------------------------

//=================================================================================================
long		i
long		lFind

integer	iPerc
integer	iPercCounter	// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents		// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter	// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	iMealCounter_ver	// 09.11.2012, Gunnar Brosch: QuantityVersion 
decimal	dcResult
decimal	dcResult_ver;		// 09.11.2012, Gunnar Brosch: QuantityVersion 
long		ll_tlc_from
long		ll_tlc_to
long		ll_handling_detail_key
long		ll_percentage
//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version"); // 09.11.2012, Gunnar Brosch: QuantityVersion 
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

// ---------------------------------------------------------------------
//
// Prozente aus der Datenbank holen und in den Datastore eintragen
//
// ---------------------------------------------------------------------

select ntlc_from, ntlc_to into :ll_tlc_from, :ll_tlc_to from cen_out
where nresult_key = :this.lResultKey;

if sqlca.sqlcode <> 0 then
	// 05.05.2010 HR: Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
	if il_tlc_from = -1 and il_tlc_from = -1 then
		uf_trace(3,"uf_calc_percent_by_cp(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
		dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
		dsCenMeals.Filter()
		dsCenMeals.SetSort("cen_meals_detail_nprio A")
		dsCenMeals.Sort()
		dcQuantity = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
		idc_quantity_ver = dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");	// 14.11.2012, Gunnar Brosch:QuantityVersion
		return 1
	else
		// 05.05.2010 HR: $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
		ll_tlc_from = il_tlc_from
		ll_tlc_to = il_tlc_to
	end if
end if	

for i = 1 to dscenmeals.RowCount()
	
	ll_handling_detail_key = dscenmeals.Getitemnumber(i, "cen_meals_detail_nhandling_detail_key")
	
	// Nur bei Berechnungsart 67 (Percentage CP) nach den Prozenten
	if dscenmeals.Getitemnumber(i, "cen_meals_detail_ncalc_id") = 67 then
		select npercentage into :ll_percentage 
			from cen_meals_cp_percent 
			where nhandling_detail_key = :ll_handling_detail_key and ntlc_from = :ll_tlc_from and ntlc_to = :ll_tlc_to ;
		
		if sqlca.sqlcode = 0 then
			dsCenMeals.Setitem(i,"cen_meals_detail_npercentage", ll_percentage)
		else
			uf_trace(20,"uf_calc_percent_by_cp(): no record in cen_meals_cp_percent for result_key " + string(this.lResultKey) + ", nhandling_detail_key " + string(ll_handling_detail_key))
			uf_trace(20,"uf_calc_percent_by_cp(): SqlErrtext: " + sqlca.sqlerrtext)
			
			// ----------------------------------------------
			// Filter zur$$HEX1$$fc00$$ENDHEX$$cksetzten			
			// ----------------------------------------------
			dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
			dsCenMeals.Filter()
			dsCenMeals.SetSort("cen_meals_detail_nprio A")
			dsCenMeals.Sort()
			dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
			idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");	// 14.11.2012, Gunnar Brosch:QuantityVersion

			return 1
		end if
		
	end if

next

//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
		
	dcResult 			= Round(lCalcBasis * iPerc/100, 0)
	dcResult_ver	= Round(il_calcbasis_ver * iPerc/100, 0);	// 14.11.2012, Gunnar Brosch:QuantityVersion
	
//	if mod(i,2) = 1 then
//		//
//		// ungerade Werte aufrunden
//		//
//		//dcResult		= round( (((lCalcBasis * iPerc)/100) + 0.5),0) // evtl. mu$$HEX2$$df002000$$ENDHEX$$nichts dazugez$$HEX1$$e400$$ENDHEX$$hlt werden
//		dcResult		= ceiling((lCalcBasis * iPerc)/100) 
//	else
//		dcResult		= truncate( ((lCalcBasis * iPerc)/100) ,0)
//		if dcResult < 1 then dcResult = 1
//	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	iMealCounter += dcResult
	
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver);	// 14.11.2012, Gunnar Brosch:QuantityVersion
	iMealCounter_ver += dcResult_ver;							// 14.11.2012, Gunnar Brosch:QuantityVersion
	
next

//
// Bei CalcBasis = 0: raus hier
//
// 14.11.2012, Gunnar Brosch: Jetzt nicht mehr raus, da sonst die QuantityVer nicht mehr berechnet werden kann >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	// 27.04.2005 dsCenMeals.SetFilter("")
	
	/*** 14.11.12: Gunnar Brosch 
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
	*/
end if

//14.11.12: Gunnar Brosch: jetzt auch f$$HEX1$$fc00$$ENDHEX$$r quantityversion
if il_calcbasis_ver = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0
end if

// 14.11.2012, Gunnar Brosch: Jetzt nicht mehr raus, da sonst die QuantityVer nicht mehr berechnet wird <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/
//f_print_datastore(dscenmeals)
//
// Check gegen Passagierzahl und Status setzen
//
// 14.11.2012, Gunnar Brosch: Ab jetzt nur f$$HEX1$$fc00$$ENDHEX$$r lCalcBasis > 0 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if lCalcBasis > 0 then
if iMealCounter > lCalcBasis then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult > 1 then
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult --
			iMealCounter --
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis  then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if


// --------------------------------------------------------------
// 09.03.2007, KF
// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
// --------------------------------------------------------------
Long 		lMultiply
Decimal 	decTemp

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult = dscenmeals.GetItemDecimal(i, "nquantity") + decTemp
		
		if dcResult < 0 then dcResult = 0
		
		dscenmeals.SetItem(i,"nquantity",dcResult)
		
	
	next 
end if


//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
// 14.11.12, Gunnar Brosch: Filter abgeklemmt 
/*
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()
*/
//<<<

//dsCenMeals.SetFilter("")
//dsCenMeals.Filter()
//
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()
end if //lCalcBasis > 0: 14.11.12, Gunnar Brosch <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// 14.11.2012, Gunnar Brosch: Und jetzt nur f$$HEX1$$fc00$$ENDHEX$$r Quantiversion > 0 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if il_calcbasis_ver > 0 then
if iMealCounter_ver > il_calcbasis_ver then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver > il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult_ver > 1 then
				dcResult_ver --
				iMealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver < il_calcbasis_ver then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver > il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver --
			iMealCounter_ver --
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver < il_calcbasis_ver  then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if


// --------------------------------------------------------------
// 09.03.2007, KF
// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
// --------------------------------------------------------------

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult_ver = dscenmeals.GetItemDecimal(i, "nquantity_version") + decTemp
		
		if dcResult_ver< 0 then dcResult = 0
		
		dscenmeals.SetItem(i,"nquantity_version",dcResult)
		
	
	next 
end if


//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet_ver = iMealCounter_ver - il_calcbasis_ver
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 


//<<<
end if //il_calcbasis_ver > 0: 14.11.12, Gunnar Brosch <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//

dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_calc_bob_percent (integer arg_icalc);//=================================================================================================
//
// uf_calc_bob_percent
//
// Berechnet f$$HEX1$$fc00$$ENDHEX$$r BOB
//
//=================================================================================================
// 28.05.2010 statt dsOldMeals wird dsCurrentMeals verwendet
// 14.07.2010 calc_id 79 Max Value
// 07.11.2012, Gunnar Brosch: QuantityVersion
// 20.09.2013 HR Max Berechnung mit Max-Feld, Min-Berechnung mit MIN-Feld
// 22.10.2013 Prozent / min / max vorbelegen, wenn nicht ersetzt wurde = Calc Id = 99
// 15.01.2014 CBASE 4.99 / CBASE-NAM-CR-13050 Calc Id 104 - wie 71, aber Max statt Min
//=================================================================================================

long i, ll_min, ll_max, ll_value, ll_percentage, ll_tlc_from, ll_tlc_to

// --------------------------------------------------------------------------------------------------------------------
// 19.08.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r ID 99 brauchen  wir nichts zu ermitteln
//                        CBASE-NAM-CR-13029
// --------------------------------------------------------------------------------------------------------------------
if arg_icalc <> 99 then
	// 09.06.2010 HR: Schalter eingebaut, um direkt vom BOB-Import Werte zu holen
	if iImportBobValues=0 then
		// 21.05.2010 KF: dsCurrentMeals existiert nicht bei Generierungen
		if isvalid(dsCurrentMeals) then
		
			// 19.05.2010 HR: Falsches Datawindow korrigiert
			i = dsCurrentMeals.find("nhandling_detail_key = "+string(lHandlingDetailKey), 1, dsCurrentMeals.rowcount())
			
			if i>0 then
				ii_Bob = dsCurrentMeals.GetItemNumber(i,"nimport_from_bob")	
			else
				ii_Bob=0
			end if	
		else
			
			ii_Bob=0
			
		end if
	else
		//Keine Daten im Importdatastore f$$HEX1$$fc00$$ENDHEX$$r den Flug?
		If dsFlightData.Rowcount() <= 0 Then
			ii_Bob=0
		else
			//Sind auch Daten f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste vorhanden?
			//i=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
			// 09.08.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			i=dsFlightData.find("cpackinglist = '"+sPackinglist+"' and cclass='" + sclass +  "'"  ,1,dsFlightData.rowcount())
			
			if i=0 then
				ii_Bob=0
			else
				ii_Bob=1
				ll_percentage	= dsFlightData.GetItemNumber(i,"nload_scale")
				ll_min 			= dsFlightData.GetItemNumber(i,"nload_minimum")
				ll_max			= dsFlightData.GetItemNumber(i,"nload_maximum") 	// 27.09.2013 HR:
				ll_value			= dsFlightData.GetItemNumber(i,"nfixed_qty") 			// 27.09.2013 HR:
			end if			
		end if
	end if
	
	if ii_Bob = 1 then
		if iImportBobValues=0 then
			ll_percentage	= dsCurrentMeals.GetItemNumber(i,"npercentage")
			ll_value			= dsCurrentMeals.GetItemNumber(i,"nvalue") 			// 27.09.2013 HR:
			ll_max			= dsCurrentMeals.GetItemNumber(i,"nmax_value") 	// 27.09.2013 HR:
			ll_min				= dsCurrentMeals.GetItemNumber(i,"nmin_value") 	// 27.09.2013 HR:
		end if
		
		// 08.06.2010 HR: BOB-Werte sichern
		il_bob_percentage	= ll_percentage
		il_bob_min			= ll_min
		il_bob_max			= ll_max 	// 27.09.2013 HR:
		il_bob_value			= ll_value 	// 27.09.2013 HR:
	else
		ii_Bob=0
		
		select ntlc_from, ntlc_to 
		   into :ll_tlc_from, :ll_tlc_to 
		  from cen_out
		where nresult_key = :this.lResultKey;
		
		if sqlca.sqlcode <> 0 then
			// 12.05.2010 HR: Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
			if il_tlc_from = -1 and il_tlc_from = -1 then
				uf_trace(20,"uf_calc_bob_percent(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
				return 1
			else
				// 12.05.2010 HR: $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
				ll_tlc_from 	= il_tlc_from
				ll_tlc_to 		= il_tlc_to
			end if
		end if	
		
		select npercentage, nmin_value, nmax_value, NFIXED_QTY 
		   into :ll_percentage, :ll_min, :ll_max, :ll_value  
		  from cen_meals_cp_percent 
		where nhandling_detail_key = :lHandlingDetailKey 
		    and ntlc_from = :ll_tlc_from 
		    and ntlc_to = :ll_tlc_to ;

		if sqlca.sqlcode <> 0 then
			ll_percentage 	= iPercentage
			
			// 27.09.2013 HR:
			ll_min 			= lMinValue
			ll_max 			= lMaxValue
			ll_value			= dcValue
		else
			if isnull(ll_min) 				then ll_min=0
			if isnull(ll_max) 			then ll_max=0 			// 27.09.2013 HR:
			if isnull(ll_value) 			then ll_value=0 		// 27.09.2013 HR:
			if isnull(ll_percentage) 	then ll_percentage=0
			
			iPercentage = ll_percentage
			
			// 27.09.2013 HR:
			dcValue = ll_value		
		end if
	end if
Else
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2013 Prozent / min / max belegen
	// --------------------------------------------------------------------------------------------------------------------
	// Calc ID = 99	
	ll_percentage 	= iPercentage
	ll_min 			= lMinValue
	ll_max 			= lMaxValue
	ll_value			= dcValue
	ii_Bob				= 0 // 31.03.2015 HR:
end if

if arg_icalc=71 then
	// --------------------------------------------------------------------------------------------------------------------
	// 22.04.2010 HR: Bei BOB-Percentage -xx% wird der Prozentwert um xx% verringert
	// --------------------------------------------------------------------------------------------------------------------
	ll_percentage -= ll_percentage * ll_value / 100
end if

if arg_icalc = 104 then
	// --------------------------------------------------------------------------------------------------------------------
	// 15.01.2014: Bei BOB-Percentage -xx% wird der Prozentwert um xx% verringert
	// --------------------------------------------------------------------------------------------------------------------
	ll_percentage -= ll_percentage * ll_value / 100
end if

dcQuantity 			= ceiling(lCalcBasis * ll_percentage / 100)	
idc_quantity_ver 	= ceiling(il_calcbasis_ver * ll_percentage / 100)	; // 07.11.12, Gunnar Brosch: QuantityVersion

choose case arg_icalc
	case 70, 71, 99
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

	case 79
		
		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		End If
		
	case 104
		// 15.01.2014
		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
		f_trace("BOB %-xx% CP Round Up with max => ID 104, Qty: " + String(dcQuantity) +  "  Max: " + String(ll_max))

	case 103
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
		
end choose

return 0

end function

public function integer uf_calc_bob_percent_round_down (integer arg_icalc);//=================================================================================================
//
// uf_calc_bob_percent_round_down
//
// Berechnet f$$HEX1$$fc00$$ENDHEX$$r BOB wobei immer abgerundet wird 
//
//=================================================================================================
// 28.05.2010 statt dsOldMeals wird dsCurrentMeals verwendet
//=================================================================================================
// 14.07.2010	calc_id 80 Max Value
// 14.11.2012	Gunnar Brosch, Qunatity Version eingebaut
// 20.09.2013 HR Max Berechnung mit Max-Feld, Min-Berechnung mit MIN-Feld
// 2014-05-16 Calc Id with MAX but no max supplied
//=================================================================================================

long i, ll_min, ll_max, ll_value, ll_percentage, ll_tlc_from, ll_tlc_to

//long lValue, ll_tlc_from, ll_tlc_to, ll_handling_detail_key,ll_percentage
//long lValue_ver;	// 14.11.2012, Gunnar Brosch,
//long lResult, i, ll_min
//integer iPerc
//decimal dcResult
//
// 09.06.2010 HR: Schalter eingebaut, um direkt vom BOB-Import Werte zu holen
if iImportBobValues=0 then
	// 21.05.2010 KF: dsCurrentMeals existiert nicht bei Generierungen
	if isvalid(dsCurrentMeals) then
	
		// 19.05.2010 HR: Falsches Datawindow korrigiert
		//i=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
		// 09.08.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		//i=dsFlightData.find("cpackinglist = '"+sPackinglist+"' and cclass='" + sclass +  "'"  ,1,dsFlightData.rowcount())

		// 07.03.2017 OH: DataStore korrigiert
		i = dsCurrentMeals.find("cpackinglist = '"+sPackinglist+"' and cclass='" + sclass +  "'"  , 1, dsCurrentMeals.rowcount())
		
		if i>0 then
			ii_Bob = dsCurrentMeals.GetItemNumber(i,"nimport_from_bob")	
		else
			ii_Bob=0
		end if	
	else
		
		ii_Bob=0
		
	end if
else
	//Keine Daten im Importdatastore f$$HEX1$$fc00$$ENDHEX$$r den Flug?
	If dsFlightData.Rowcount() <= 0 Then
		ii_Bob=0
	else
		//Sind auch Daten f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste vorhanden?
		i=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
		if i=0 then
			ii_Bob=0
		else
			ii_Bob=1
			ll_percentage	 = dsFlightData.GetItemNumber(i,"nload_scale")
			ll_min 			= dsFlightData.GetItemNumber(i,"nload_minimum")
			ll_max			= dsFlightData.GetItemNumber(i,"nload_maximum") 	// 27.09.2013 HR:
			ll_value			= dsFlightData.GetItemNumber(i,"nfixed_qty") 			// 27.09.2013 HR:
		end if			
	end if
end if

if ii_Bob = 1 then
	if iImportBobValues=0 then
		ll_percentage 	= dsCurrentMeals.GetItemNumber(i,"npercentage")
		ll_value 			= dsCurrentMeals.GetItemNumber(i,"nvalue") 			// 27.09.2013 HR:
		ll_max 			= dsCurrentMeals.GetItemNumber(i,"nmax_value") 	// 27.09.2013 HR:
		ll_min				= dsCurrentMeals.GetItemNumber(i,"nmin_value") 	// 27.09.2013 HR:
	end if
	
	// 08.06.2010 HR: BOB-Werte sichern
	il_bob_percentage = ll_percentage
	il_bob_min 			= ll_min
	il_bob_max 			= ll_max 	// 27.09.2013 HR:
	il_bob_value			= ll_value 	// 27.09.2013 HR:
else
	ii_Bob=0
	
	select ntlc_from, ntlc_to into :ll_tlc_from, :ll_tlc_to from cen_out
	where nresult_key = :this.lResultKey;
	
	if sqlca.sqlcode <> 0 then
		// Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
		if il_tlc_from = -1 and il_tlc_from = -1 then
			uf_trace(20,"uf_calc_bob_percent(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
			return 1
		else
			// $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
			ll_tlc_from 	= il_tlc_from
			ll_tlc_to 		= il_tlc_to
		end if
	end if	
	
	select npercentage, nmin_value, nmax_value, NFIXED_QTY into :ll_percentage, :ll_min, :ll_max, :ll_value 
		from cen_meals_cp_percent 
		where nhandling_detail_key = :lHandlingDetailKey and ntlc_from = :ll_tlc_from and ntlc_to = :ll_tlc_to ;
	
	if sqlca.sqlcode <> 0 then
		ll_percentage 	= iPercentage
			
		// 27.09.2013 HR:
		ll_min 			= lMinValue
		ll_max 			= lMaxValue
		ll_value			= dcValue

//		ll_min = dcValue
//	
//		if arg_icalc = 80 then
//			ll_min = lMaxValue
//		End If
	else
		if isnull(ll_min) 				then ll_min=0
		if isnull(ll_max) 			then ll_max=0 			// 27.09.2013 HR:
		if isnull(ll_value) 			then ll_value=0 		// 27.09.2013 HR:
		if isnull(ll_percentage) 	then ll_percentage=0
		
		iPercentage = ll_percentage
		
		// 27.09.2013 HR:
		//dcValue 		= ll_min
		dcValue = ll_value		
	end if
end if

if arg_icalc=73 then
	// --------------------------------------------------------------------------------------------------------------------
	// Bei BOB-Percentage -xx% wird der Prozentwert um xx% verringert
	// --------------------------------------------------------------------------------------------------------------------
	ll_percentage -= ll_percentage * ll_value / 100
end if

dcQuantity 			= Truncate(lCalcBasis * ll_percentage / 100, 0)	// Prozentwert
idc_quantity_ver 	= Truncate(il_calcbasis_ver * ll_percentage / 100, 0)	// 14.11.2012, Gunnar Brosch

choose case arg_icalc
	case 72, 73
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

	case 80
		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
		
	case 102
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
end choose

//if arg_icalc = 80 then
//	// Max Value
//	if  lValue > ll_min then
//		dcQuantity = ll_min
//	else
//		dcQuantity = lValue
//	end if
//Else
//	if  lValue < ll_min then
//		dcQuantity = ll_min
//	else
//		dcQuantity = lValue
//	end if
//end if
//
//// 14.11.2012, Gunnar Brosch, Qunatity Version >>>
//if arg_icalc = 80 then
//	// Max Value
//	if  lValue_ver > ll_min then
//		idc_quantity_ver = ll_min
//	else
//		idc_quantity_ver = lValue_ver
//	end if
//Else
//	if  lValue_ver < ll_min then
//		idc_quantity_ver = ll_min
//	else
//		idc_quantity_ver = lValue_ver
//	end if
//end if
////<<<
return 0

end function

public function integer uf_calc_bob_percent_com (integer arg_icalc);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_bob_percent_com (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer arg_icalc
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: BOB-Berechnungsart  mit kaufm$$HEX1$$e400$$ENDHEX$$nnischem Runden
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  10.06.2010	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
//  14.07.2010 calc_id 81 Max Value
//  14.11.2012, Gunnar Brosch, Quantity Version
//  20.09.2013 HR Max Berechnung mit Max-Feld, Min-Berechnung mit MIN-Feld
// 2014-05-16 Calc Id with MAX but no max supplied
// 08.08.2016 BOB Daten Suche mit Klasse
// --------------------------------------------------------------------------------------------------------------------

long i, ll_min, ll_max, ll_value, ll_percentage, ll_tlc_from, ll_tlc_to

// Schalter eingebaut, um direkt vom BOB-Import Werte zu holen
if iImportBobValues=0 then
	// dsCurrentMeals existiert nicht bei Generierungen
	if isvalid(dsCurrentMeals) then
	
		i = dsCurrentMeals.find("nhandling_detail_key = "+string(lHandlingDetailKey	), 1, dsCurrentMeals.rowcount())
		
		if i>0 then
			ii_Bob = dsCurrentMeals.GetItemNumber(i,"nimport_from_bob")	
		else
			ii_Bob=0
		end if	
	else
		
		ii_Bob=0
		
	end if
else
	//Keine Daten im Importdatastore f$$HEX1$$fc00$$ENDHEX$$r den Flug?
	If dsFlightData.Rowcount() <= 0 Then
		ii_Bob=0
	else
		//Sind auch Daten f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste vorhanden?
		//i=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
		// 08.08.2016 OH: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		i=dsFlightData.find("cpackinglist = '"+sPackinglist+"' AND cclass='" + sclass + "'",1,dsFlightData.rowcount())
		
		if i=0 then
			ii_Bob=0
		else
			ii_Bob=1
			ll_percentage 	= dsFlightData.GetItemNumber(i,"nload_scale")
			ll_min 			= dsFlightData.GetItemNumber(i,"nload_minimum")
			ll_max			= dsFlightData.GetItemNumber(i,"nload_maximum") 	// 27.09.2013 HR:
			ll_value			= dsFlightData.GetItemNumber(i,"nfixed_qty") 			// 27.09.2013 HR:
		end if			
	end if
end if

if ii_Bob = 1 then
	if iImportBobValues=0 then
		ll_percentage 	= dsCurrentMeals.GetItemNumber(i,"npercentage")
		ll_value 			= dsCurrentMeals.GetItemNumber(i,"nvalue") 			// 27.09.2013 HR:
		ll_max 			= dsCurrentMeals.GetItemNumber(i,"nmax_value") 	// 27.09.2013 HR:
		ll_min				= dsCurrentMeals.GetItemNumber(i,"nmin_value") 	// 27.09.2013 HR:
	end if
	
	// BOB-Werte sichern
	il_bob_percentage = ll_percentage
	il_bob_min 			= ll_min
	il_bob_max 			= ll_max 	// 27.09.2013 HR:
	il_bob_value			= ll_value 	// 27.09.2013 HR:
else
	ii_Bob=0
	
	select ntlc_from, ntlc_to into :ll_tlc_from, :ll_tlc_to from cen_out
	where nresult_key = :this.lResultKey;
	
	if sqlca.sqlcode <> 0 then
		// Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
		if il_tlc_from = -1 and il_tlc_from = -1 then
			uf_trace(20,"uf_calc_bob_percent(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
			return 1
		else
			// $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
			ll_tlc_from 	= il_tlc_from
			ll_tlc_to 		= il_tlc_to
		end if
	end if	
	
	select npercentage, nmin_value, nmax_value, NFIXED_QTY  into :ll_percentage, :ll_min, :ll_max, :ll_value   
		from cen_meals_cp_percent 
		where nhandling_detail_key = :lHandlingDetailKey and ntlc_from = :ll_tlc_from and ntlc_to = :ll_tlc_to ;
	
	if sqlca.sqlcode <> 0 then
		ll_percentage 	= iPercentage
		
		// 27.09.2013 HR:
		ll_min 			= lMinValue
		ll_max 			= lMaxValue
		ll_value			= dcValue


//		ll_min = dcValue
//
//		if arg_icalc = 81 then
//			ll_min = lMaxValue
//		End If
//
	else
		if isnull(ll_min) 				then ll_min=0
		if isnull(ll_percentage) 	then ll_percentage=0
		if isnull(ll_value) 			then ll_value=0 		// 27.09.2013 HR:
		if isnull(ll_percentage) 	then ll_percentage=0
		
		iPercentage = ll_percentage
		// 27.09.2013 HR:
		//dcValue 		= ll_min
		dcValue 		= ll_value		
	end if
end if

if arg_icalc=75 then
	// --------------------------------------------------------------------------------------------------------------------
	// Bei BOB-Percentage -xx% wird der Prozentwert um xx% verringert
	// --------------------------------------------------------------------------------------------------------------------
	ll_percentage -= ll_percentage * ll_value / 100
end if

dcQuantity 			= int((lCalcBasis * ll_percentage / 100) + 0.5)
idc_quantity_ver 	= int((il_calcbasis_ver * ll_percentage / 100) + 0.5);	//14.11.2012, Gunnar Brosch: Quantity Version

choose case arg_icalc
	case 74, 75
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

	case 81
		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
		
	case 101
		if dcQuantity < ll_min 		then dcQuantity = ll_min
		if idc_quantity_ver < ll_min 	then idc_quantity_ver = ll_min

		// 2014-05-16 Calc Id with MAX but no max supplied
		If ll_max > 0 then
			if dcQuantity > ll_max 		then dcQuantity = ll_max
			if idc_quantity_ver > ll_max	then idc_quantity_ver = ll_max
		end if
end choose

//if arg_icalc = 81 then
//	// Max Value
//	if  lValue > ll_min then
//		dcQuantity = ll_min
//	else
//		dcQuantity = lValue
//	end if
//Else
//	
//	if  lValue < ll_min then
//		dcQuantity = ll_min
//	else
//		dcQuantity = lValue
//	end if
//End If
//
////14.11.2012, Gunnar Brosch: Quantity Version
//if arg_icalc = 81 then
//	// Max Value
//	if  lValue_ver > ll_min then
//		idc_quantity_ver = ll_min
//	else
//		idc_quantity_ver = lValue
//	end if
//Else
//	
//	if  lValue_ver < ll_min then
//		idc_quantity_ver = ll_min
//	else
//		idc_quantity_ver = lValue
//	end if
//End If
////<<<
//
return 0

end function

public function integer uf_calc_bob_fixed ();//=================================================================================================
//
// uf_calc_bob_fixed
//
// Berechnet f$$HEX1$$fc00$$ENDHEX$$r BOB: Fixed Quantity (mit City Pair)
//
// 14.11.2012: Gunnar Brosch, Quantity Version: keine Abh$$HEX1$$e400$$ENDHEX$$ngigkeit bzgl. lCalcBasis, daher derselbe Wert auch f$$HEX1$$fc00$$ENDHEX$$r il_quantity_ver. Keine $$HEX1$$c400$$ENDHEX$$nderung.
//=================================================================================================

Long	lValue,  ll_handling_detail_key
Long	ll_Found
Long	ll_tlc_from, ll_tlc_to
Long	ll_fixed_qty


// 09.06.2010 HR: Schalter eingebaut, um direkt vom BOB-Import Werte zu holen
if iImportBobValues=0 then
	// 21.05.2010 KF: dsCurrentMeals existiert nicht bei Generierungen
	if isvalid(dsCurrentMeals) then
	
		// 19.05.2010 HR: Falsches Datawindow korrigiert
		ll_Found = dsCurrentMeals.find("nhandling_detail_key = "+ string(lHandlingDetailKey	), 1, dsCurrentMeals.rowcount())
		
		if ll_Found > 0 then
			ii_Bob = dsCurrentMeals.GetItemNumber(ll_Found,"nimport_from_bob")	
			// dsCurrentMeals VALUE LESEN
			lValue = dsCurrentMeals.GetItemNumber(ll_Found,"nvalue")
		else
			ii_Bob=0
		end if	
	else
		
		ii_Bob=0
		
	end if
else
	//Keine Daten im Importdatastore f$$HEX1$$fc00$$ENDHEX$$r den Flug?
	If dsFlightData.Rowcount() <= 0 Then
		ii_Bob=0
	else
		//Sind auch Daten f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste vorhanden?
		//ll_Found=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
		// 09.08.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		ll_Found=dsFlightData.find("cpackinglist = '"+sPackinglist+"' and cclass='" + sclass +  "'"  ,1,dsFlightData.rowcount())

		if ll_Found=0 then
			ii_Bob=0
		else
			ii_Bob=1
//			ll_percentage = dsFlightData.GetItemNumber(i,"nload_scale")
//			ll_min = dsFlightData.GetItemNumber(i,"nload_minimum")
//			lValue = dsFlightData.GetItemNumber(ll_Found,"nvalue")
			// -------------------------------------------------------------------
			// 18.04.2012 nvalue fehlt im DataObject, nfixed_qty hinzu gef$$HEX1$$fc00$$ENDHEX$$gt
			// -------------------------------------------------------------------
			lValue = dsFlightData.GetItemNumber(ll_Found,"nfixed_qty")
		end if			
	end if
end if

if ii_Bob = 1 then
	// -------------------------------------------------------------------
	// 18.04.2012 dsCurrentMeals VALUE nicht mehr LESEN, da ggf. aus 
	// dsFlightData gelesener Wert (siehe nfixed_qty) $$HEX1$$fc00$$ENDHEX$$berschrieben wird
	// -------------------------------------------------------------------
	//lValue = dsCurrentMeals.GetItemNumber(ll_Found,"nvalue")
	dcQuantity = lValue
	il_bob_percentage = 0
Else
	dcQuantity = dcValue
	il_bob_percentage = 0
	
		
	// --------------------------
	// City Pair
	// --------------------------
	select	ntlc_from, ntlc_to 
	into		:ll_tlc_from, :ll_tlc_to 
	from		cen_out
	where		nresult_key = :this.lResultKey;
		
	if sqlca.sqlcode <> 0 then
		// 12.05.2010 HR: Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
		if il_tlc_from = -1 and il_tlc_from = -1 then
			uf_trace(20,"uf_calc_bob_percent(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
			return 1
		else
			// 12.05.2010 HR: $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
			ll_tlc_from = il_tlc_from
			ll_tlc_to = il_tlc_to
		end if
	end if	
	
	select	nfixed_qty 
	into		:ll_fixed_qty 
	from		cen_meals_cp_percent 
	where		nhandling_detail_key = :lHandlingDetailKey 
	and		ntlc_from = :ll_tlc_from 
	and		ntlc_to = :ll_tlc_to ;
	
	if sqlca.sqlcode <> 0 then
		ll_fixed_qty = dcValue
	else
		if isnull(ll_fixed_qty) then ll_fixed_qty=0
		
		dcQuantity = ll_fixed_qty
		
	end if
End If

//	if iImportBobValues=0 then
//		lValue = dsCurrentMeals.GetItemNumber(i,"nvalue")
////		ll_percentage = dsCurrentMeals.GetItemNumber(i,"npercentage")
////		ll_min = dsCurrentMeals.GetItemNumber(i,"nvalue")
//	end if
//	
////	// 08.06.2010 HR: BOB-Werte sichern
////	il_bob_percentage = ll_percentage
////	il_bob_min = ll_min
//else
//	ii_Bob=0
//	
////	ll_percentage = iPercentage
////	ll_min = dcValue
////	else
////		if isnull(ll_min) then ll_min=0
////		if isnull(ll_percentage) then ll_percentage=0
////		
////		iPercentage = ll_percentage
////		dcValue = ll_min
////	end if
//end if

// 11.03.2014 HR: Wir m$$HEX1$$fc00$$ENDHEX$$sse uns die Menge auch in den BOB-Variablen merken, damit diese f$$HEX1$$fc00$$ENDHEX$$r die Nachberechnung zur Verf$$HEX1$$fc00$$ENDHEX$$gung steht
il_bob_value = dcQuantity

Return 0

end function

public function integer uf_calc_fixed_cp ();/*
* Objekt : uo_meal_calculation
* Methode: uf_calc_fixed_cp (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 14.07.2010
*
* Argument(e):
* none
*
* Beschreibung:		Feste Menge pro City Pair
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	14.07.2010		Erstellung
*
*
* Return: integer
*
*/


Long		ll_Value
long		ll_tlc_from
long		ll_tlc_to


select	ntlc_from, ntlc_to 
into		:ll_tlc_from, :ll_tlc_to 
from		cen_out
where		nresult_key = :this.lResultKey;
	
if sqlca.sqlcode <> 0 then
	// 12.05.2010 HR: Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
	if il_tlc_from = -1 and il_tlc_from = -1 then
		uf_trace(20,"uf_calc_fixed_cp(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
		return 1
	else
		// 12.05.2010 HR: $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
		ll_tlc_from = il_tlc_from
		ll_tlc_to = il_tlc_to
	end if
end if	
	
select	nfixed_qty
into		:ll_Value 
from		cen_meals_cp_percent 
where		nhandling_detail_key = :lHandlingDetailKey 
and		ntlc_from = :ll_tlc_from 
and		ntlc_to = :ll_tlc_to ;
	
if sqlca.sqlcode <> 0 then
	// Kein Eintrag f$$HEX1$$fc00$$ENDHEX$$r City Pair: nehme Meal Def?
	//	ll_Value = dcValue
	dcQuantity =  dcvalue
else
	if isnull(ll_Value) then ll_Value=0
	
	dcQuantity = ll_Value
end if


Return 0

end function

public function integer uf_change_flightdataobject (string arg_dataobject);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_change_flightdataobject (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_dataobject
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
//  17.08.2010	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
dsFlightData.dataobject=arg_dataobject
dsFlightData.settransobject(SQLCA)
return 1

end function

public function long uf_get_value_from_ratio (long arg_lcalcdetailkey, long arg_lcalcbasis);
/*
* Objekt : uo_meal_calculation
* Methode: uf_get_value_from_ratio (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 01.09.2010
*
* Argument(e):
* long lratiokey
*	 integer ipax
*
* Beschreibung:		Ermitteln des richtigen Beladewertes/Beladeprozentwertes bei gegebener Passagieranzahl
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		01.09.2010			Erstellung
*
*
* Return: integer
*
*/
long			lresult
long 			lQuantity
long			lfrom_pax, lto_pax
datetime		dtDate
long			lFind
long			lRows
string		sRatioText
string		sFind

uf_trace(50,"uf_calc_ratiolist(): start")

//
// Zugriff auf Ratio-Cache m$$HEX1$$f600$$ENDHEX$$glich?
//
if isvalid(dsRatioCache) then
	if dsRatioCache.RowCount() > 0 then
		lFind = dsRatioCache.Find("nratiolist_key = " + string(arg_lcalcdetailkey) + " and nfrom_pax <= " + string(arg_lCalcBasis) + &
												" and nto_pax >= " + string(arg_lCalcBasis),1,dsRatioCache.RowCount())
		if lFind > 0 then
			lResult					= dsRatioCache.GetItemNumber(lFind,"nquantity")
			dcQuantity 				= lResult
			uf_trace(50,"uf_calc_ratiolist(): Ratio-Cache access succeeded!")
	
			return lResult
		end if
	end if
end if
		
lRows = dsRatiolistTyp1.Retrieve(arg_lcalcdetailkey,dgenerationdate)
//
// 20.04.2005: Falls gar nichts da ist
//
if lRows = 0 then
	uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition! Try to search again...")
	if dsFindRatiolist.RowCount() = 0 then
		dsFindRatiolist.Retrieve()
	end if
	lFind = dsFindRatiolist.Find("nratiolist_key = " + string(arg_lcalcdetailkey), 1, dsFindRatiolist.RowCount())
	if lFind > 0 then
		sRatioText = dsFindRatiolist.GetItemString(lFind,"ctext")
				
		sFind = "ctext = '" + sRatioText + &
					"' and date(string(dvalid_from,'yyyy-mm-dd')) <= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and date(string(dvalid_to,'yyyy-mm-dd')) >= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and ncustomer_key = " + string(lAirlineKey)
					
//					yyyy-mm-dd
					
		lFind = dsFindRatiolist.Find(sFind, 1, dsFindRatiolist.RowCount())
		if lFind > 0 then
			lcalcdetailkey = dsFindRatiolist.GetItemNumber(lFind,"nratiolist_key")
			lRows = dsRatiolistTyp1.Retrieve(arg_lcalcdetailkey,dgenerationdate)
			uf_trace(1,"uf_calc_ratiolist(): Found new key for Ratiolist Definition!")
		else
			uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition!!!")
			//
			// urspr. Packinglist bleibt erhalten!
			//
			lResult					= 0
			dcQuantity 				= lResult
			return lResult
		end if
	end if
end if

lFind = dsRatiolistTyp1.Find("nfrom_pax <= " + string(arg_lCalcBasis) + &
										" and nto_pax >= " + string(arg_lCalcBasis),1,dsRatiolistTyp1.RowCount())
if lFind > 0 then
	lResult					= dsRatiolistTyp1.GetItemNumber(lFind,"nquantity")
	dcQuantity 				= lResult
else
	lResult					= 0
	dcQuantity 				= 0
end if

//
// Falls gar nichts da ist
//
if dsRatiolistTyp1.RowCount() = 0 then
	uf_trace(50,"uf_calc_ratiolist(): dsRatiolistTyp1.RowCount() = 0, lcalcdetailkey = " + string(arg_lcalcdetailkey))
	uf_trace(50,"uf_calc_ratiolist(): end")
	lResult = 0
	return lResult
end if

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
if dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nto_pax") < arg_lCalcBasis then
	lResult					= dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nquantity")
	dcQuantity 				= lResult
end if

uf_trace(50,"uf_calc_ratiolist(): end")

return lResult



end function

public function integer uf_add_number_for_classes (long al_calcid, s_number_per_class astr_noperclassesarray[]);	/*
* Methode: uf_add_number_for_classes (Function)
*
* Argument(e):
*	al_calcid						Berechnungsart-ID
*	alstr_noPerClassesArray[] s_number_per_class-Array mit der Klassennummer und der Anzahl pro Klasse
* 
* Beschreibung:	Setzt $$HEX1$$fc00$$ENDHEX$$bergebene Anzahl pro Klasse als FAKE-Eintrag in die dsCenOutPax, wobei der erste schon vorhandene 
*						FAKE-Eintrag mit der aktuellen Anzahl $$HEX1$$fc00$$ENDHEX$$berschrieben wird
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		09.09.2010 		Erstellung
*  1.1	     T. Brackmann		14.03.2011 		Neue Berechnungsarten erg$$HEX1$$e400$$ENDHEX$$nzt
*
* Return: 
* 0 	alles OK
* -1	Fehler
*/

Long ll_index, ll_findFirstEntry, ll_find, li_classNumber, li_number, ll_resultKey
String ls_class, ls_amountColumn

if upperBound(astr_noPerClassesArray) <= 0 then return -1

// Ermittle entsprechende Mengenspalte
choose case al_calcid
case 29 TO 34, 41, 84, 85
	ls_amountColumn = "npax"
case 35 TO 40, 42, 44, 86, 87, 88, 89
	ls_amountColumn = "nversion"
case 43
	ls_amountColumn = "npax_airline"
case else // Rest: 45-60
	ls_amountColumn = "npax"
end choose

// Result-Key auslesen und erh$$HEX1$$f600$$ENDHEX$$hen, da neue Eintr$$HEX1$$e400$$ENDHEX$$ge hinter dem FAKE-Eintrag eingef$$HEX1$$fc00$$ENDHEX$$gt werden
//MB 15.04.2014: Alle Klassen f$$HEX1$$fc00$$ENDHEX$$r 4711 eintragen, sonst geht das nicht...
ll_resultKey = lresultkey

ll_findFirstEntry = dsCenOutPax.find("nresult_key = " + string(lresultkey) ,1,dsCenOutPax.RowCount())
	
if ll_findFirstEntry <= 0 then
	sErrortext = "No passenger information found"
	return -1
end if

if upperBound(astr_noPerClassesArray) > 0 then
	
	for ll_index=1 to upperBound(astr_noPerClassesArray)
			
		ls_class = astr_noPerClassesArray[ll_index].sclass
		li_classNumber = astr_noPerClassesArray[ll_index].iclass_number
		
		// abh$$HEX1$$e400$$ENDHEX$$ngig von der Mengenspalte die entsprechende eingegebene Anzahl auslesen
		choose case ls_amountColumn 
		case "npax"
			li_number = astr_noPerClassesArray[ll_index].ipax_number
		case "nversion", "npax_airline"
			li_number = astr_noPerClassesArray[ll_index].iversion
		end choose
		//Nicht $$HEX1$$fc00$$ENDHEX$$ber Result_key, sondern $$HEX1$$fc00$$ENDHEX$$ber class_number suchen
		// Suche, ob Eintrag bereits vorhanden ist
		ll_find = dsCenOutPax.find("cclass = '" + ls_class +"'",1,dsCenOutPax.RowCount())
				
		// falls Zeile bereits existiert, dann nur Daten $$HEX1$$fc00$$ENDHEX$$berschreiben
		// ansonsten neueZeile hinzuf$$HEX1$$fc00$$ENDHEX$$gen, vorher vorhandene Zeile kopieren
		if ll_find > 0 then
			// Daten von gefundenen Eintrag $$HEX1$$fc00$$ENDHEX$$berschreiben
			dsCenOutPax.SetItem(ll_find,"nclass_number", li_classNumber)
			dsCenOutPax.SetItem(ll_find,"cclass",ls_class)
			dsCenOutPax.SetItem(ll_find,ls_amountColumn,li_number)
		else
			// 1.FAKE-Zeile kopieren und am Ende einf$$HEX1$$fc00$$ENDHEX$$gen
			If dsCenOutPax.rowscopy(ll_findFirstEntry, ll_findFirstEntry, Primary!, dsCenOutPax, dsCenOutPax.RowCount() + 1, Primary!) = 1 Then
				// kopierte Daten inklusive neuen Schl$$HEX1$$fc00$$ENDHEX$$ssel $$HEX1$$fc00$$ENDHEX$$berschreiben
				dsCenOutPax.SetItem(dsCenOutPax.RowCount(),"nresult_key", ll_resultKey)
				dsCenOutPax.SetItem(dsCenOutPax.RowCount(),"nclass_number", li_classNumber)
				dsCenOutPax.SetItem(dsCenOutPax.RowCount(),"cclass",ls_class)
				dsCenOutPax.SetItem(dsCenOutPax.RowCount(),ls_amountColumn, li_number)
			End if
		end if
			
		// Schl$$HEX1$$fc00$$ENDHEX$$ssel erh$$HEX1$$f600$$ENDHEX$$hen 
	//	ll_resultKey++
	next
else
	return -1
end if // Pr$$HEX1$$fc00$$ENDHEX$$fung Array-Gr$$HEX2$$f600df00$$ENDHEX$$e

return 0
end function

public function integer uf_get_max_classes (ref string as_maxclassesarray[], ref boolean ab_paxnumberrequired, ref boolean ab_versionrequired);/*
* Methode: uf_get_max_classes (Function)
*
* Argument(e):
*	as_maxclassesarray[]		String-Array mit den Klassennamen, das gef$$HEX1$$fc00$$ENDHEX$$llt wird
*  ab_paxNumberRequired	Indikator, ob Passagieranzahl gesetzt werden muss
*  ab_versionRequired	     Indikator, ob Version gesetzt werden muss
*
* Beschreibung:	Ermittelt die maximalen Klassen aus dsCenMeals f$$HEX1$$fc00$$ENDHEX$$r die Berechungsarten mit mehreren Klassen 
*						und setzt diese in as_maxclassesarray
*						Ermittelt au$$HEX1$$df00$$ENDHEX$$erdem welche Menge(n) gesetzt werden m$$HEX1$$fc00$$ENDHEX$$ssen
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		09.09.2010 		Erstellung
*  1.1	     T. Brackmann		14.03.2011 		Neue Berechnungsarten erg$$HEX1$$e400$$ENDHEX$$nzt
*
* Return: 
* 0 	alles OK
*/
Long k, l, m, ll_calcId, ll_classArraySize
Integer li_pos
String ls_multiClasses, ls_classArray[]
boolean lb_classFound

for k= 1 to dsCenMeals.RowCount()
	ll_calcId = dsCenMeals.GetItemNumber(k,"cen_meals_detail_ncalc_id")
	//	if il_MIN_CALC_ID_MULTI_CLASSES <= ll_calcId and ll_calcId <= il_MAX_CALC_ID_MULTI_CLASSES then	
	// Um die hinzu gekommenen Berechnungsarten 84-89 erweitert - TBR 110130
	if ( il_MIN_CALC_ID_MULTI_CLASSES <= 	ll_calcId 	and 	ll_calcId 	<= 	il_MAX_CALC_ID_MULTI_CLASSES ) 	OR &
	   ( 84 										<= 	ll_calcId 	and 	ll_calcId 	<= 	89 ) 											THEN
		
		ls_multiClasses = dsCenMeals.GetItemString(k,"cen_meals_detail_cclasses")
		
		// Pr$$HEX1$$fc00$$ENDHEX$$fung das Multi-Klassen-String auch gef$$HEX1$$fc00$$ENDHEX$$llt ist, da die Eingabe nicht mandatory ist
		if isNull(ls_multiClasses) OR len(trim(ls_multiClasses)) = 0 then continue

		// Erst mal den "Rest" hinter den Klassen abschneiden TBR 110130
		 li_pos = Pos(ls_multiClasses,"/",1)
		// ... aber nur, wenn
		IF li_pos > 0 THEN
			 ls_multiClasses = Trim(Mid(ls_multiClasses,1, li_pos - 1))
		 END IF
		 
		// Klassen aus String in Array umwandeln: ls_multiClasses k$$HEX1$$f600$$ENDHEX$$nnte sein BC+EY
		ll_classArraySize = f_string_to_array(ls_multiClasses, "+", ls_classArray)

		if ll_classArraySize <= 0 then continue
		
		if upperBound(as_maxclassesarray) = 0 then
			as_maxclassesarray = ls_classArray
		else 
			
			// Hinzuf$$HEX1$$fc00$$ENDHEX$$gen der neuen Klassen, falls sie noch nicht vorhanden sind
			for l = 1 to ll_classArraySize
				lb_classFound = False
				for m = 1 to upperBound(as_maxclassesarray)
					if ls_classArray[l] = as_maxclassesarray[m] then 
						lb_classFound = True
						exit
					end if  
				next
				if lb_classFound = False then
					as_maxclassesarray[upperBound(as_maxclassesarray) + 1] = ls_classArray[l]
				end if 
			next 
		end if // Pr$$HEX1$$fc00$$ENDHEX$$fung Gr$$HEX2$$f600df00$$ENDHEX$$e as_maxclassesarray[]
		
		// Pr$$HEX1$$fc00$$ENDHEX$$fung welche Menge gesetzt werden soll
		choose case ll_calcId
		case 29 TO 34, 41, 84, 85
			ab_paxNumberRequired = true
		case 35 TO 40, 42, 44
			ab_versionRequired = true
		case 43, 86, 87, 88, 89
			ab_versionRequired = true
		case else // Rest: 45-60
			ab_paxNumberRequired = true
		end choose

	end if // Pr$$HEX1$$fc00$$ENDHEX$$fung ll_calcId
next	

return 0
end function

public function integer uf_ask4number_per_class (string as_maxclassesarray[], ref s_number_per_class astr_noperclassesarray[], boolean ab_paxnumberrequired, boolean ab_versionrequired);/*
* Methode: uf_ask4number_per_class (Function)
*
* Argument(e):
*	as_maxClassesArray[]		String-Array mit den Klassen
* 	astr_noPerClassesArray[] 	s_number_per_class-Array mit den Klassen, -nummern, der Passagieranzahl und Version, 
*										das gef$$HEX1$$fc00$$ENDHEX$$llt wird
*  ab_paxNumberRequired		Indikator, ob Passagieranzahl gesetzt werden muss
*  ab_versionRequired	    	 	Indikator, ob Version gesetzt werden muss
*
* Beschreibung:	$$HEX1$$d600$$ENDHEX$$ffnet ein Engabefenster f$$HEX1$$fc00$$ENDHEX$$r die Eingabe der Anzahl pro Klasse, und setzt diese sowie 
*						die entsprechende Klassennummer in das $$HEX1$$fc00$$ENDHEX$$bergebene Array astr_noperclassesarray[]
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		09.09.2010 		Erstellung
*
* Return: 
* 0 	alles OK
* -1	Fehler
*/

s_number_per_class_parameters lstr_Open
integer i,j

if upperBound(as_maxClassesArray) > 0 then
	// 17.01.2011 HR: Dialog soll nur in der Simulation aufgehen
	if  ib_OnlySimulation = True then

		// Fenster f$$HEX1$$fc00$$ENDHEX$$r Eingabe der Paxanzahl pro Klasse $$HEX1$$f600$$ENDHEX$$ffnen
		lstr_Open.lAirline_key = lairlinekey
		lstr_Open.sClass_array = as_maxClassesArray
		lstr_Open.bPax_number_required = ab_paxNumberRequired
		lstr_Open.bVersion_required = ab_versionRequired
		
		// #############################################################################################
		// Sollte das Window W_NUMBER_PER_CLASS im Service fehlen, dann W_NUMBER_PER_CLASS_DUMMY in eine
		// serviceeigene PBL als W_NUMBER_PER_CLASS kopieren
		// #############################################################################################
		OpenWithParm(w_number_per_class, lstr_Open)
		
		lstr_Open = Message.PowerObjectParm
				
		if not isvalid(lstr_Open) then return -1
				
		if lstr_Open.bSuccessful then	
			// Array mit eingegeben Daten setzen
			astr_noPerClassesArray = lstr_Open.strNo_per_class_array
		end if
	else
		for i=1 to upperbound(as_maxClassesArray)
			for j=1 to upperbound(is_class_names)
				if as_maxClassesArray[i] = is_class_names[j] then
					astr_noPerClassesArray[i].iclass_number = ii_class_numbers[j]
					if ab_paxNumberRequired then
						astr_noPerClassesArray[i].ipax_number = ii_pax_numbers[j]
					else
						astr_noPerClassesArray[i].ipax_number=0
					end if
					if ab_versionRequired then
						astr_noPerClassesArray[i].iversion = ii_version_numbers[j]
					else
						astr_noPerClassesArray[i].iversion = 0
					end if
					astr_noPerClassesArray[i].sclass = is_class_names[j]
					exit
				end if
			next
		next
		i=i
	end if
end if

return 0
end function

public function integer uf_add_return_flight_pax ();/*
* Methode: uf_add_return_flight_pax (Function)
*
* Argument(e):

* 
* Beschreibung:	Paxe des R$$HEX1$$fc00$$ENDHEX$$ckluges zu lCalcId dazuaddieren
*						
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				K.F$$HEX1$$f600$$ENDHEX$$rster		09.09.2010 		Erstellung
*
* Return: 
* 0 	alles OK
* -1	Fehler
*/

long ll_ReturnFlightPax
long ll_ReturnFlight_ver	//29.11.2012, G. Brosch

  SELECT cen_out_pax.npax , cen_out_pax.nversion		//29.11.2012, G. Brosch
	  	INTO :ll_ReturnFlightPax, :ll_ReturnFlight_ver	//29.11.2012, G. Brosch
   	    FROM cen_out,   
                  cen_out_pax  
      WHERE cen_out_pax.nresult_key = cen_out.nresult_key AND  
				cen_out.nresult_key_group = :this.lResultKey AND  
				cen_out.nleg_ident = 3 AND  
				cen_out_pax.nclass_number = :this.lClassNumber;
				
	if sqlca.sqlcode = 0 then // Alles OK
	    	this.lCalcBasis +=  ll_ReturnFlightPax
		this.il_calcbasis_ver +=  ll_ReturnFlight_ver	 //29.11.2012, G. Brosch
	elseif sqlca.sqlcode = 100 then // Es gibt keinen R$$HEX1$$fc00$$ENDHEX$$ckflug 
											// oder wir befinden uns im Generierungsmodus
											// dann w$$HEX1$$e400$$ENDHEX$$re das hier die Stelle um weiterzumachen 
											
	else /// Mist
		uf_trace(1, "uf_calc_ratiolist_percentage sqlca.sqlerrtext = " + sqlca.sqlerrtext)
	end if

return 0


end function

public function long uf_calc_ratiolist_percentage (decimal dcargument);/*
* Objekt : uo_meal_calculation
* Methode: uf_calc_ratiolist_percentage (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 01.09.2010
*
* Argument(e):
* none
*
* Beschreibung:	Die Funktion rechnet analog der Funktion uf_calc_percentage, lediglich die Prozentwerte werden anh$$HEX1$$e400$$ENDHEX$$ngig von den Paxzahlen ermittelt
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		01.09.2010			Erstellung
* 1.1			Gunnar Brosch			14.11.2012			Quantity Version
*
*
* Return: long
*
*/

long		i
long		lFind

integer	iPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents			// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter			// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	iMealCounter_ver;		// 14.11.2012, Gunnar Brosch
decimal	dcResult
decimal	dcResult_ver			// 14.11.2012, Gunnar Brosch
//long		ll_CalcBasis
long		ll_ReturnFlightPax
long		ll_CalcBasisOrigin


// -----------------------------------------------------------------------------------------------
// 21.09.2010, KF
// Mal die ursprungliche Berechnungsgrunglage merken, weil wir sie im 
// Verlauf der Berechung hin und her toggeln m$$HEX1$$fc00$$ENDHEX$$ssen.
// -----------------------------------------------------------------------------------------------
ll_CalcBasisOrigin = this.lCalcBasis

// ----------------------------------------------------------------------------------------------
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
// ----------------------------------------------------------------------------------------------
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	// ----------------------------------------------------------------------------------------------
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	// ----------------------------------------------------------------------------------------------
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version") ;	// 14.11.2012, Gunnar Brosch: Quantity Version
	return 1
end if

// ----------------------------------------------------------------------------------------------
// Komplette Gruppe holen
// ----------------------------------------------------------------------------------------------
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()
// ----------------------------------------------------------------------------------------------
// Prozente ausrechnen
// ----------------------------------------------------------------------------------------------
for i = 1 to dscenmeals.RowCount()
	
	// ---------------------------------------------------------------------------------------------------------------------------------------------------
	// 01.09.2010, KF
	// Hier statt iPerc aus cen_meals_detail_npercentage zu nehmen, den richtigen Prozentwert aus der Ratioliste holen
	// uf_calc_percentage macht das an der Stelle so: iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	// Sollte innerhalb einer Gruppe eine andere Berechnungsart als Ratiolist Percentage oder Percentage vorkommen,
	// dann den Prozentwert auf 1 setzen
	if  dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 82 then
		
		lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
		
		
		iPerc					= uf_get_value_from_ratio(lCalcDetailKey, this.lCalcBasis )
	else
		iPerc					= 1
	end if
	
	iPercCounter += iPerc
	
	if mod(i,2) = 1 then
		// ----------------------------------------------------------------------------------------------
		// ungerade Werte aufrunden
		// ----------------------------------------------------------------------------------------------
		//dcResult		= round( (((ll_CalcBasis * iPerc)/100) + 0.5),0) // evtl. mu$$HEX2$$df002000$$ENDHEX$$nichts dazugez$$HEX1$$e400$$ENDHEX$$hlt werden
		dcResult		= ceiling((this.lCalcBasis * iPerc)/100) 
		dcResult_ver= ceiling((this.il_calcbasis_ver * iPerc)/100);		//14.11.2012, Gunnar Brosch
	else
		dcResult		= truncate( ((this.lCalcBasis * iPerc)/100) ,0)	
		if dcResult < 1 then dcResult = 1
		
		dcResult_ver= truncate( ((this.il_calcbasis_ver * iPerc)/100) ,0);	//14.11.2012, Gunnar Brosch
		if dcResult_ver < 1 then dcResult_ver = 1;								//14.11.2012, Gunnar Brosch
	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	dscenmeals.SetItem(i,"nquantity_version",dcResult_ver);					//14.11.2012, Gunnar Brosch
	
	iMealCounter 		+= dcResult
	iMealCounter_ver 	+= dcResult_ver;											//14.11.2012, Gunnar Brosch
	
next

// ----------------------------------------------------------------------------------------------
// Bei CalcBasis = 0: raus hier
// ----------------------------------------------------------------------------------------------
if this.lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	// ----------------------------------------------------------------------------------------------
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	// ----------------------------------------------------------------------------------------------
	// 27.04.2005 dsCenMeals.SetFilter("")
	
	/*** 14.11.2012, Gunnar Brosch, abgeklemmt
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
	*/
end if

if this.il_calcbasis_ver = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0
end if

/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/
 
// ----------------------------------------------------------------------------------------------
// Check gegen Passagierzahl und Status setzen
// ----------------------------------------------------------------------------------------------
// 14.11.2012, Gunnar Brosch: Nur, wenn lCalcBasis > 0
if this.lCalcBasis > 0 then
if iMealCounter > this.lCalcBasis then
	for i = dscenmeals.RowCount() to 1 step -1
		// ----------------------------------------------------------------------------------------------
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter > this.lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			// ----------------------------------------------------------------------------------------------
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			// ----------------------------------------------------------------------------------------------
			if dcResult > 1 then
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		// ----------------------------------------------------------------------------------------------
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter < this.lCalcBasis then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		// ----------------------------------------------------------------------------------------------
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter > this.lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult --
			iMealCounter --
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		// ----------------------------------------------------------------------------------------------
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter < this.lCalcBasis  then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if


// --------------------------------------------------------------
// 01.09.2010, KF
// die Funktion uf_calc_ratiolist_percentage, kombinierbar mit +/- Absolut
// --------------------------------------------------------------
Long 		lMultiply
Decimal 	decTemp

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult = dscenmeals.GetItemDecimal(i, "nquantity") + decTemp
		
		if dcResult < 0 then dcResult = 0
		
		dscenmeals.SetItem(i,"nquantity",dcResult)
		
	
	next 
end if


// ----------------------------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
// ----------------------------------------------------------------------------------------------
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - this.lCalcBasis
end if

// ----------------------------------------------------------------------------------------------
// Menge des ersten Wertes der Gruppe setzen
// ----------------------------------------------------------------------------------------------
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 
end if //this.lCalcBasis > 0, 14.11.2012, Gunnnar Brosch

// 14.11.2012, Gunnnar Brosch: Und jetzt dergleichen f$$HEX1$$fc00$$ENDHEX$$r il_calcbasis_ver
if this.il_calcbasis_ver > 0 then
if iMealCounter_ver > this.il_calcbasis_ver then
	for i = dscenmeals.RowCount() to 1 step -1
		// ----------------------------------------------------------------------------------------------
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter_ver > this.il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			// ----------------------------------------------------------------------------------------------
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			// ----------------------------------------------------------------------------------------------
			if dcResult_ver > 1 then
				dcResult_ver --
				iMealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			end if
		end if
		// ----------------------------------------------------------------------------------------------
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter_ver < this.il_calcbasis_ver then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		// ----------------------------------------------------------------------------------------------
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter_ver > this.il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver --
			iMealCounter_ver --
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		// ----------------------------------------------------------------------------------------------
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		// ----------------------------------------------------------------------------------------------
		if iPercCounter = 100 and iMealCounter_ver < this.il_calcbasis_ver  then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		// ----------------------------------------------------------------------------------------------
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		// ----------------------------------------------------------------------------------------------
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if


// --------------------------------------------------------------
// 01.09.2010, KF
// die Funktion uf_calc_ratiolist_percentage, kombinierbar mit +/- Absolut
// --------------------------------------------------------------

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult_ver = dscenmeals.GetItemDecimal(i, "nquantity_version") + decTemp
		
		if dcResult_ver < 0 then dcResult_ver = 0
		
		dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		
	
	next 
end if


// ----------------------------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
// ----------------------------------------------------------------------------------------------
if iPercCounter > 100 then
	lOverloadSet_ver = iMealCounter_ver - this.il_calcbasis_ver
end if

// ----------------------------------------------------------------------------------------------
// Menge des ersten Wertes der Gruppe setzen
// ----------------------------------------------------------------------------------------------
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 
end if //this.lCalcBasis > 0, 14.11.2012, Gunnnar Brosch


// ----------------------------------------------------------------------------------------------
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
// ----------------------------------------------------------------------------------------------
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public function integer uf_calc_pax_via_forecast_ratio ();
// --------------------------------------------------------------------------------------------------------------------
// 17.07.2015 HR: Eine neue Kopie der Funktion, die nicht auf Umgebungsvariablen zugreift, sondern die
//                        Werte als Parameter erh$$HEX1$$e400$$ENDHEX$$lt
// --------------------------------------------------------------------------------------------------------------------

integer li_pax_calc, li_status

li_pax_calc = uf_calc_pax_via_forecast_ratio_mass(sclass, lpax, ii_nservice, li_status)

if li_status = -2 then
	ibo_pax_from_forecast = TRUE
end if

return li_pax_calc

/*
// --------------------------------------------------------------------------------------------
// Sonderbehandlung Meal-Forecast ("Japan-Tool") -----------------------------------
// --------------------------------------------------------------------------------------------

Decimal   lde_nratio
Long		 ll_rownum
Long		 ll_count
String		 ls_cspml
String	  	 ls_cclass
Integer	 li_ntype
Integer	 ll_nfcspml_key
Decimal	 lde_spml_ethnic
Decimal	 lde_spml_western
Decimal	 lde_npax_netto
Decimal	 lde_npax_ethnic
Decimal	 lde_npax_western
Integer	 li_nquantity
Integer	 li_npax_ethnic
Integer	 li_npax_western
DateTime ldt_GenerationDateUTC

DataStore lds_forecast_ratio
DataStore lds_forecast_ethnic_spml

lds_forecast_ratio = Create DataStore
lds_forecast_ratio.DataObject = "dw_forecast_ratio"
lds_forecast_ratio.SetTransObject(SQLCA)

ldt_GenerationDateUTC = DateTime(dGenerationDateUTC)

// Erst mal nachsehen, ob f$$HEX1$$fc00$$ENDHEX$$r den Flug an diesem Tag $$HEX1$$fc00$$ENDHEX$$berhaupt ein Ratio zur Berechnung da ist ...
lds_forecast_ratio.Retrieve(lAirlineKey,il_flgnr,sclass,ii_nservice,ldt_GenerationDateUTC)

// Ok, ist da -> Ratio und Typ merken ...
IF 	lds_forecast_ratio.RowCount() > 0 THEN

	lde_nratio				= 	lds_forecast_ratio.GetItemNumber(1,"nratio")
	li_ntype					=	lds_forecast_ratio.GetItemNumber(1,"ntype")

	DESTROY lds_forecast_ratio

	lde_npax_netto			=	0
	lde_spml_ethnic		=	0
	lde_spml_western		=	0

	// Special Meals des Fluges durchlesen und ethnische und nicht-ethnische SPML z$$HEX1$$e400$$ENDHEX$$hlen ...
	IF 	dsspml.RowCount() > 0 THEN

		lds_forecast_ethnic_spml = Create DataStore
		lds_forecast_ethnic_spml.DataObject = "dw_forecast_ethnic_spml"
		lds_forecast_ethnic_spml.SetTransObject(SQLCA)

		ll_rownum = 1

		DO
			// Pro Special Meal - Test ob in der zur Flugnummer geh$$HEX1$$f600$$ENDHEX$$renden Tabelle mit ethnischen SPML ...
			ls_cclass		=  dsspml.GetItemString(ll_rownum,"cclass")
			ls_cspml 		=  dsspml.GetItemString(ll_rownum,"cspml")
			li_nquantity 	=  dsspml.GetItemNumber(ll_rownum,"nquantity")

			//SPML der aktuellen Klasse ?
			IF ls_cclass = sclass THEN
				
				// Handelt es sich bei dem SPML um ein ethnisches SPML ?
				ll_count	= lds_forecast_ethnic_spml.Retrieve(lAirlineKey,il_flgnr,sclass,ls_cspml ,ldt_GenerationDateUTC)
		
				// Wenn gefunden => Anzahl ethnischer Meals erh$$HEX1$$f600$$ENDHEX$$hen ...
				IF	ll_count > 0 THEN
					lde_spml_ethnic 	= 	lde_spml_ethnic + li_nquantity
				ELSE
					// Wenn nicht gefunden => Anzahl westlicher Meals erh$$HEX1$$f600$$ENDHEX$$hen ...
					lde_spml_western	=	lde_spml_western + li_nquantity
				END IF
				
			END IF				

			ll_rownum = ll_rownum + 1
			
		LOOP UNTIL ll_rownum > dsspml.RowCount()
		
		DESTROY lds_forecast_ethnic_spml		
	
	END IF // IF 	dsspml.RowCount() > 0 ...
	
	// Netto-Pax = Pax - SPMLs
	lde_npax_netto = lpax - lde_spml_western - lde_spml_ethnic

	// ethnische MZ-Def ...
	IF li_ntype = 1 THEN
		lde_npax_ethnic = 								(	lde_npax_netto * lde_nratio	)	-  lde_spml_ethnic
	ELSE
		// Westliche MZ-Def ...
		lde_npax_ethnic = lde_npax_netto   - 	(	(	lde_npax_netto * lde_nratio	) 	-  lde_spml_ethnic	)
	END IF

	// Pr$$HEX1$$fc00$$ENDHEX$$fungen der ethnischen Paxe
	IF lde_npax_netto - lde_npax_ethnic 	<	2 THEN

		IF 	lde_npax_netto < 10 THEN
			lde_npax_ethnic = lde_npax_ethnic - 1
		ELSE
			lde_npax_ethnic = lde_npax_ethnic - 2						
		END IF
	
		IF 	lde_npax_ethnic < 0 THEN
			lde_npax_ethnic = 0
		END IF
		
	END IF

	// Westliche Paxe
	lde_npax_western = lde_npax_netto -  lde_npax_ethnic + lde_spml_western + lde_spml_ethnic

	// Pr$$HEX1$$fc00$$ENDHEX$$fungen der westlichen Paxe
	IF 	lde_npax_western < 0 THEN
		lde_npax_western = 0
	END IF
	
ELSE // IF 	lds_forecast_ratio.RowCount() > 0 ...
	
	// F$$HEX1$$fc00$$ENDHEX$$r den Flug ist an diesem Tag kein Ratio zur Berechnung da 
	// =>regul$$HEX1$$e400$$ENDHEX$$re Paxzahl zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
	
	RETURN lPax
	
END IF // IF 	lds_forecast_ratio.RowCount() > 0 ...

li_npax_ethnic 		= ROUND(lde_npax_ethnic,0)
li_npax_western 	= ROUND(lde_npax_western,0)

ibo_pax_from_forecast = TRUE

// Wenn Etnische Mahlzeit => ethnische Paxe zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
IF ii_nethnic = 1 THEN
	RETURN li_npax_ethnic
ELSE
// Wenn westliche Mahlzeit => westliche Paxe zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
	RETURN li_npax_western
END IF	
*/
end function

public function integer uf_calc_multiclass_sum_ratiolist (integer icolumn);String		sColumn
String 	sClassArray[] 
String		ls_cclasses
Integer	i
Long		lFound
Long		lValue, ll_spml

if iColumn = 1 then
	sColumn = "npax"
elseif iColumn = 2 then
	sColumn = "nversion"
end if

// --------------------------------------------
// Die Klassen des MultiClass String in ein 
// Array packen
// sMultiClass k$$HEX1$$f600$$ENDHEX$$nnte sein BC+EY
// --------------------------------------------
ls_cclasses = MID(this.sMultiClasses,1,POS(this.sMultiClasses,"/",1) -1)

f_string_to_array(ls_cclasses, "+", sClassArray)

// --------------------------------------------
// Die Werte der Klassen aus sMultiClass 
// zusammenaddieren 
// --------------------------------------------
lCalcBasis = 0

For i = 1 to Upperbound(sClassArray)
	
	// 06.03.2013 HR: Wir suchen mit NRESULT_KEY, damit wir immer den richtigen Flug anpacken
//	lFound = dsCenOutPax.Find("cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	lFound = dsCenOutPax.Find("nresult_key = "+string(lResultKey)+" and cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	
	if lFound <= 0 then continue
	
	lCalcBasis 		+=  dsCenOutPax.GetItemNumber(lFound, sColumn)
	il_calcbasis_ver += dsCenOutPax.GetItemNumber(lFound, "nversion")	//29.11.2012, G. Brosch
	ll_spml 	 +=  dsCenOutPax.GetItemNumber(lFound, "npax_spml")
next

if iSPMLDeduction = 1 then
	lCalcBasis = lCalcBasis - ll_spml
	il_calcbasis_ver = il_calcbasis_ver - ll_spml
end if

return 0
end function

public function integer uf_calc_multiclass_sum_ratiolist_spml (integer icolumn);// 20.22.12, Gunnar Brosch: Quantity Version eingebaut

String	sColumn
String 	sClassArray[] 
String		ls_cclasses
Integer	i
Long		lFound
Long		lValue
Long		ll_spml

if iColumn = 1 then
	sColumn = "npax"
elseif iColumn = 2 then
	sColumn = "nversion"
end if

// --------------------------------------------
// Die Klassen des MultiClass String in ein 
// Array packen
// sMultiClass k$$HEX1$$f600$$ENDHEX$$nnte sein BC+EY
// --------------------------------------------
ls_cclasses = MID(this.sMultiClasses,1,POS(this.sMultiClasses,"/",1) -1)

f_string_to_array(ls_cclasses, "+", sClassArray)

// --------------------------------------------
// Die Werte der Klassen aus sMultiClass 
// zusammenaddieren 
// --------------------------------------------
lCalcBasis = 0
ll_spml = 0

For i = 1 to Upperbound(sClassArray)
	
	// 06.03.2013 HR: Wir suchen mit NRESULT_KEY, damit wir immer den richtigen Flug anpacken
//	lFound = dsCenOutPax.Find("cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	lFound = dsCenOutPax.Find("nresult_key = "+string(lResultKey)+" and cclass = '" + sClassArray[i] + "'", 1, dsCenOutPax.RowCount())
	
	if lFound <= 0 then continue
	
	lCalcBasis += 	dsCenOutPax.GetItemNumber(lFound, sColumn)
	il_calcbasis_ver += dsCenOutPax.GetItemNumber(lFound, "nversion")	//29.11.2012, G. Brosch
	ll_spml 		= 	ll_spml + dsCenOutPax.GetItemNumber(lFound, "npax_spml")
	
	lCalcBasis = lCalcBasis - ll_spml	
	il_calcbasis_ver = il_calcbasis_ver - ll_spml	
	
next

return 0
end function

public function integer uf_calc_fixed_ac_version ();/*
* Objekt : uo_meal_calculation
* Methode: uf_calc_fixed_ac_version (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 22.12.2010
*
* Argument(e):
* none
*
* Beschreibung:		Feste Menge pro AC Typ & Version
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	22.12.2010		Erstellung
* 1.1			Gunnar Brosch, 20.11.12: Quantity Version
*
* Return: integer
*
*/


Long		ll_Value
Long		ll_AC_Type
Long		ll_Meal_Detail_Key


ll_AC_Type				= laircraftkey
ll_Meal_Detail_Key		= lHandlingDetailKey

SELECT	nvalue  
INTO		:ll_Value  
FROM		cen_meals_ac_ver_val  
WHERE		nhandling_detail_key		= :ll_Meal_Detail_Key  
AND		naircraft_key				= :ll_AC_Type    ;

if sqlca.sqlcode <> 0 then
	// Kein Eintrag f$$HEX1$$fc00$$ENDHEX$$r AC Type vorhanden => Default
	//	ll_Value = dcValue
	dcQuantity =  dcvalue
else
	if isnull(ll_Value) then ll_Value=0
	
	dcQuantity = ll_Value
end if

idc_quantity_ver = dcQuantity;	// Gunnar Brosch, 20.11.12: Quantity Version

Return 0

end function

public function string uf_cen_profilestring (string ssection, string skey, string sdefault);string	sValue

Select cValue 
  into :sValue 
from cen_setup
where cclient = :sClient 	
   and cSection = :sSection				
   and cKey = :sKey;
			
If SQLCA.SQLCode = 100 Then
	sValue = sDefault
	INSERT INTO cen_setup  
          (cclient,   
          csection,   
          ckey,   
          cvalue )
   VALUES (:sClient,   
          :sSection,   
          :sKey,   
          :sDefault)  ;
	//f_check_sql(sqlca,"Insert into cen_setup","Insert")
End if


return sValue


end function

protected function long uf_get_customer_id (long al_indexkey, long al_detailkey, long al_airlinekey, ref string ref_as_customerid, ref string ref_as_customertext, boolean ab_all);
/* 
* Function: 			uf_get_customer_id  (intern)
* Beschreibung: 	Ermitteln kundenspezifischer IDs pro st$$HEX1$$fc00$$ENDHEX$$ckliste
* Besonderheit: 	sowenig lesen wie m$$HEX1$$f600$$ENDHEX$$glich: nicht, wenn kein g$$HEX1$$fc00$$ENDHEX$$ltiger airline-key
*
* Argumente:
* 	al_IndexKey				St$$HEX1$$fc00$$ENDHEX$$ckliste MasterKey
* 	al_DetailKey				St$$HEX1$$fc00$$ENDHEX$$ckliste DetailKey
* 	al_AirlineKey				Airline Key
* 	ref_as_CustomerId		R$$HEX1$$fc00$$ENDHEX$$ckgabebuffer	CustomerId
* 	ref_as_CustomerText 	R$$HEX1$$fc00$$ENDHEX$$ckgabebuffer CustomerText
* 	ab_All 						Schalter, ob auch st$$HEX1$$fc00$$ENDHEX$$ckliste selber gelesen werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		16.04.2012		Erstellung
*
* Return Codes:
*	 1		was gefunden
*	 0		nix gefunden
*	 -1		fehler
*/

// hilfsvariable
Long 	ll_Ret = 1
String ls_Null, ls_customer_pl, ls_customer_text


// ----------------------------------------------
// daten lesen
// (nur, wenn g$$HEX1$$fc00$$ENDHEX$$ltiger airlinekey da)
// ----------------------------------------------
if not IsNull(al_AirlineKey) and al_AirlineKey > 0 then
	ll_Ret = this.idsCustomerId.Retrieve(al_IndexKey, al_DetailKey, al_AirlineKey)
else
	ll_Ret = 0
end if

// ----------------------------------------------
// keine s$$HEX1$$e400$$ENDHEX$$tze zugeordnet: ggf. haupteintrag lesen
// ----------------------------------------------
if this.idsCustomerId.RowCount() > 0 then
	ref_as_CustomerId	= this.idsCustomerId.GetItemString(1, "ccustomer_pl")
	ref_as_CustomerText	= this.idsCustomerId.GetItemString(1, "ccustomer_text")
	ll_Ret = 1
else
	ref_as_CustomerId	= ls_Null
	ref_as_CustomerText	= ls_Null
	if ab_All and ll_Ret = 0 then
		select ccustomer_pl,  ccustomer_text
		  into :ls_customer_pl, :ls_customer_text
		  from cen_packinglists  
		 where npackinglist_index_key = :al_IndexKey
		   and npackinglist_detail_key = :al_DetailKey;
	
		if SQLCA.SQLCode = 0 then
			ref_as_CustomerId	= ls_customer_pl
			ref_as_CustomerText	= ls_customer_text
			ll_Ret = 1
		elseif SQLCA.SQLCode = 100 then
			ll_Ret = 0
		else 
			ll_Ret = -1
		end if
	end if

end if

// ----------------------------------------------
// blanks rauswerfen
// ----------------------------------------------
if trim(ref_as_CustomerId) = "" then SetNull(ref_as_CustomerId)
if trim(ref_as_CustomerText) = "" then SetNull(ref_as_CustomerText)

return ll_Ret

end function

public function integer uf_calc_percent_version_cutoff ();/*
* Objekt : uo_meal_calculation
* Methode: uf_calc_percent_version_cutoff (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.07.2012
*
* Argument(e):
* none
*
* Beschreibung:		UK Berechnugsart RL Prozent mit Cutoff bei Version
*							wobei die RL "normal" nicht "%" sein soll und die Prozente erst sp$$HEX1$$e400$$ENDHEX$$ter
*							ins Spiel kommen (bei $$HEX1$$dc00$$ENDHEX$$berschreitung der Version f$$HEX1$$fc00$$ENDHEX$$r Summe der Gruppe)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.07.2012		Erstellung
* 1.1 			O.Hoefer	17.07.2012		SPML bei Vergleich mit einbeziehen
* 1.2 			O.Hoefer	18.07.2012		nstatus = 1 fehlte; "RL mit Pax ohne SPML Abzug rechnen" (AM)
* 1.3 			O.Hoefer	23.07.2012		"RL mit Pax MIT SPML Abzug rechnen" (AM)
* 1.4 			O.Hoefer	24.07.2012		"RL mit Pax ohne SPML Abzug rechnen", wenn summe > version - spml:
*													(summe - spml) * Prozent der Meal Def
*1.5			G. Brosch 20.12.2012		Qauntity Version eingebaut
*
*
* Return: integer
*
*/

//=================================================================================================
//
// Ratiolistberechnung mit Gruppe und Begranzung auf Version mit Prozent
//
//=================================================================================================
long		i
long		lFind
Integer	li_Succ
integer	iPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents			// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter			// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iMealCounter_ver;		//20.11.12, Gunnar Brosch
decimal	dcResult
decimal	dcResult_ver;			//20.11.12, Gunnar Brosch
Long		ll_New_Calc_Basis
Integer	li_Num_SPML
Long		ll_Count
Long		ll_TopOffSPML
Long		ll_Quantity
Long		ll_local_calc_basis
Long		ll_Sum_Meals_From_RL
Long		ll_Sum_Meals_From_RL_ver	//29.11.12, Gunnar Brosch
Decimal	ldcResult_Linear
Decimal	ldcResult_Linear_ver			//29.11.12, Gunnar Brosch


ll_local_calc_basis = lPax
//ll_local_calc_basis = lCalcbasis


// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");	//20.11.12, Gunnar Brosch
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

If isvalid(dsRatioCache) then
	dsRatioCache.reset()
End If

// ------------------------------------
// Ermittle abzuziehende SPML
// ------------------------------------
li_Num_SPML = 0 

// ------------------------------------
// Alternative SPML Z$$HEX1$$e400$$ENDHEX$$hlung via PAX-DataStore
// ------------------------------------
// 06.03.2013 HR: Wir suchen mit NRESULT_KEY, damit wir immer den richtigen Flug anpacken
//	ll_Count = dsCenOutPax.Find("cclass = '" + sclass + "'", 1, dsCenOutPax.RowCount())
ll_Count = dsCenOutPax.Find("nresult_key = "+string(lResultKey)+" and cclass = '" + sclass + "'", 1, dsCenOutPax.RowCount())
if ll_Count > 0 then
	li_Num_SPML = 	li_Num_SPML + dsCenOutPax.GetItemNumber(ll_Count, "npax_spml")
end if

//// ----------------------------------------
//// Ratioliste ausrechnen je Zeile
//// ----------------------------------------
//for i = 1 to dscenmeals.RowCount()
//	if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 91 then
//		lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
//		dcResult					= uf_get_value_from_ratio(lCalcDetailKey, ll_local_calc_basis)
//		//iPerc					= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage") //uf_get_value_from_ratio(lCalcDetailKey, this.lCalcBasis )
//	else
//		dcResult					= 1
//	end if
//	li_Succ = dscenmeals.SetItem(i,"nquantity",dcResult)
//	// 18.07.2012 - nstatus = 1 fehlte
//	li_Succ = dscenmeals.SetItem(i,"nstatus",1)
//	iMealCounter += dcResult
//next

// -------------------------------------------------------------------------------------------------------
// Ratioliste ausrechnen je Zeile UND SPML anteilig abziehen
// z.B. PL X: RL 20, PL Y: PL 15, SPML 10 => Summe Gruppe muss 20 + 15 - 10 = 25 werden
// -------------------------------------------------------------------------------------------------------
iMealCounter = 0
iMealCounter_ver = 0;		//20.11.12., Gunnar Brosch

// Ermittle Summe Ratio Listen
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer  li_Percentage
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 91 then
		lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
		dcResult				= uf_get_value_from_ratio(lCalcDetailKey, ll_local_calc_basis)
		dcResult_ver		= uf_get_value_from_ratio(lCalcDetailKey, iversion)	//29.11.2012, G. Brosch
		iPerc					= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	else
		dcResult			= 1
		dcResult_ver	= 1	//29.11.2012, G. Brosch ???
	end if
	
	li_Succ = dscenmeals.SetItem(i,"nquantity",dcResult)
	li_Succ = dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)	//29.11.2012, G. Brosch
	
	li_Succ = dscenmeals.SetItem(i,"nstatus",1)
	iMealCounter 		+= dcResult
	iMealCounter_ver 	+= dcResult_ver	//29.11.2012, G. Brosch
next

ll_Sum_Meals_From_RL 		= iMealCounter
ll_Sum_Meals_From_RL_ver	= iMealCounter_ver	//29.11.2012, G. Brosch

//If ll_Sum_Meals_From_RL > (iversion - li_Num_SPML) Then
	iMealCounter = 0
	iMealCounter_ver = 0;	//29.11.2012, G. Brosch
	
	// Abzug SPML anteilig vom Summe Gruppe
	for i = 1 to dscenmeals.RowCount()
		if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 91 then
			lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
			dcResult				= uf_get_value_from_ratio(lCalcDetailKey, ll_local_calc_basis)
			dcResult_ver		= uf_get_value_from_ratio(lCalcDetailKey, iversion)	//29.11.2012, G. Brosch
			iPerc					= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
			If iPerc = 0 Then iPerc = 100
			
			ldcResult_Linear 		=  (ll_Sum_Meals_From_RL - li_Num_SPML) * iPerc / 100 
			ldcResult_Linear_ver 	=  (ll_Sum_Meals_From_RL_ver - li_Num_SPML) * iPerc / 100 //29.11.2012, G. Brosch
			
//			ldcResult_Linear	= dcResult * (ll_Sum_Meals_From_RL - li_Num_SPML) / ll_Sum_Meals_From_RL 
//			ldcResult_Perc	= dcResult * iPerc / 100 
		else
			dcResult					= 1
			dcResult_ver			= 1	//29.11.2012, G. Brosch
		end if
		
		dcResult 			= 	ldcResult_Linear //ldcResult_Perc
		dcResult_ver 	= 	ldcResult_Linear_ver //29.11.2012, G. Brosch
		
		if mod(i,2) = 1 then
			// ------------------------------
			// ungerade Werte aufrunden
			// ------------------------------
			dcResult			= ceiling(ldcResult_Linear) 
			dcResult_ver	= ceiling(ldcResult_Linear_ver) //29.11.2012, G. Brosch
		else
			dcResult		= truncate(ldcResult_Linear ,0)
			if dcResult < 1 then dcResult = 1
									
			dcResult_ver	= truncate(ldcResult_Linear_ver ,0)	//29.11.2012, G. Brosch
			if dcResult_ver < 1 then dcResult_ver = 1					//29.11.2012, G. Brosch
		end if
		
		If ll_Sum_Meals_From_RL < li_Num_SPML Then
			dcResult = 0
		End If
		If dcResult < 0 then
			dcResult = 0
		End If
		
		//30.11.2012, G. Brosch >>>
		If ll_Sum_Meals_From_RL_ver < li_Num_SPML Then
			dcResult_ver = 0
		End If
		If dcResult_ver < 0 then
			dcResult_ver = 0
		End If
		//<<<
		
		li_Succ = dscenmeals.SetItem(i,"nquantity",dcResult)
		// 18.07.2012 - nstatus = 1 fehlte
		li_Succ = dscenmeals.SetItem(i,"nstatus",1)
		iMealCounter += dcResult
		
		//30.11.2012, G. Brosch >>>
		li_Succ = dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		iMealCounter_ver += dcResult_ver
		//<<<
		
	next
//End if

//
// Bei CalcBasis = 0: raus hier
//
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	// 27.04.2005 dsCenMeals.SetFilter("")
	
	//30.11.2012, G. Brosch: abgeklemmt , da wir eventuell f$$HEX1$$fc00$$ENDHEX$$r QuantityVersion weiter machen m$$HEX1$$fc00$$ENDHEX$$ssen>>>>
	/*
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
	*/
	//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
end if

//30.11.2012, G. Brosch >>>
if iversion = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0
end if
//<<<

// ------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fe Summe gegen Version - SPML
// ------------------------------------
If iSPMLDeduction = 0 Then li_Num_SPML = 0 

// ********* 30.11.2012, G. Brosch: jetzt nur noch bei lCalcBasis > 0 **************
if lCalcBasis > 0 then
If iMealCounter > (iversion - li_Num_SPML) then
//If (iSPMLDeduction = 1 AND iMealCounter > iversion) then	

	iPercCounter = 0
	If iSPMLDeduction = 1 Then
		ll_New_Calc_Basis = iVersion - li_Num_SPML
	Else
		ll_New_Calc_Basis = iVersion
	End if
	// Anzahl gr$$HEX2$$f600df00$$ENDHEX$$er Version => neue Calc Basis ist iVersion - SPML
	for i = 1 to dscenmeals.RowCount()
		if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 91 then
			lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
			iPerc					= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage") 
		else
			iPerc					= 1
		end if
		iPercCounter += iPerc
		if mod(i,2) = 1 then
			// ----------------------------------------------------------------------------------------------
			// ungerade Werte aufrunden
			// ----------------------------------------------------------------------------------------------			
			dcResult		= ceiling((ll_New_Calc_Basis * iPerc)/100) 
		else
			dcResult		= truncate( ((ll_New_Calc_Basis * iPerc)/100) ,0)
			if dcResult < 1 then dcResult = 1
		end if
		dscenmeals.SetItem(i,"nquantity",dcResult)
		dscenmeals.SetItem(i,"nstatus",1)
		iMealCounter += dcResult
	Next
End If

//f_print_datastore(dscenmeals)

// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 
end if //******* 30.11.2012, G. Brosch: jetzt nur noch bei lCalcBasis > 0 **********



//30.11.2012: G. Brosch, dergleichen f$$HEX1$$fc00$$ENDHEX$$r Quantity Version... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
if iversion > 0 then
If iMealCounter_ver > (iversion - li_Num_SPML) then
//If (iSPMLDeduction = 1 AND iMealCounter > iversion) then	

	iPercCounter = 0
	If iSPMLDeduction = 1 Then
		ll_New_Calc_Basis = iVersion - li_Num_SPML
	Else
		ll_New_Calc_Basis = iVersion
	End if
	// Anzahl gr$$HEX2$$f600df00$$ENDHEX$$er Version => neue Calc Basis ist iVersion - SPML
	for i = 1 to dscenmeals.RowCount()
		if dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_id") = 91 then
			lCalcDetailKey		= dsCenMeals.GetItemNumber(i,"cen_meals_detail_ncalc_detail_key")
			iPerc					= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage") 
		else
			iPerc					= 1
		end if
		iPercCounter += iPerc
		if mod(i,2) = 1 then
			// ----------------------------------------------------------------------------------------------
			// ungerade Werte aufrunden
			// ----------------------------------------------------------------------------------------------			
			dcResult_ver = ceiling((ll_New_Calc_Basis * iPerc)/100) 
		else
			dcResult_ver		= truncate( ((ll_New_Calc_Basis * iPerc)/100) ,0)
			if dcResult_ver < 1 then dcResult_ver = 1
		end if
		dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		dscenmeals.SetItem(i,"nstatus",1)
		iMealCounter_ver += dcResult_ver
	Next
End If

//f_print_datastore(dscenmeals)

// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
if iPercCounter > 100 then
	lOverloadSet = iMealCounter_ver - iversion
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 
end if
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


//
// Filter und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()


return 0

end function

public function long uf_get_percentage_from_ratio (long arg_lcalcdetailkey, long arg_lcalcbasis);
/*
* Objekt : uo_meal_calculation
* Methode: uf_get_value_from_ratio (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 01.09.2010
*
* Argument(e):
* long lratiokey
*	 integer ipax
*
* Beschreibung:		Ermitteln des richtigen Beladewertes/Beladeprozentwertes bei gegebener Passagieranzahl
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		01.09.2010			Erstellung
*
*
* Return: integer
*
*/
long			lresult
long 			lQuantity
long			lfrom_pax, lto_pax
datetime		dtDate
long			lFind
long			lRows
string		sRatioText
string		sFind

uf_trace(50,"uf_calc_ratiolist(): start")

//
// Zugriff auf Ratio-Cache m$$HEX1$$f600$$ENDHEX$$glich?
//
if isvalid(dsRatioCache) then
	if dsRatioCache.RowCount() > 0 then
		lFind = dsRatioCache.Find("nratiolist_key = " + string(arg_lcalcdetailkey) + " and nfrom_pax <= " + string(arg_lCalcBasis) + &
												" and nto_pax >= " + string(arg_lCalcBasis),1,dsRatioCache.RowCount())
		if lFind > 0 then
			//lResult					= dsRatioCache.GetItemNumber(lFind,"nquantity")
			lResult					= dsRatioCache.GetItemNumber(lFind,"nquantity")
			dcQuantity 				= lResult
			uf_trace(50,"uf_calc_ratiolist(): Ratio-Cache access succeeded!")
	
			return lResult
		end if
	end if
end if
		
lRows = dsRatiolistTyp1.Retrieve(arg_lcalcdetailkey,dgenerationdate)
//
// 20.04.2005: Falls gar nichts da ist
//
if lRows = 0 then
	uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition! Try to search again...")
	if dsFindRatiolist.RowCount() = 0 then
		dsFindRatiolist.Retrieve()
	end if
	lFind = dsFindRatiolist.Find("nratiolist_key = " + string(arg_lcalcdetailkey), 1, dsFindRatiolist.RowCount())
	if lFind > 0 then
		sRatioText = dsFindRatiolist.GetItemString(lFind,"ctext")
				
		sFind = "ctext = '" + sRatioText + &
					"' and date(string(dvalid_from,'yyyy-mm-dd')) <= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and date(string(dvalid_to,'yyyy-mm-dd')) >= date('" + string(dgenerationdate,"yyyy-mm-dd") + &
					"') and ncustomer_key = " + string(lAirlineKey)
					
//					yyyy-mm-dd
					
		lFind = dsFindRatiolist.Find(sFind, 1, dsFindRatiolist.RowCount())
		if lFind > 0 then
			lcalcdetailkey = dsFindRatiolist.GetItemNumber(lFind,"nratiolist_key")
			lRows = dsRatiolistTyp1.Retrieve(arg_lcalcdetailkey,dgenerationdate)
			uf_trace(1,"uf_calc_ratiolist(): Found new key for Ratiolist Definition!")
		else
			uf_trace(1,"uf_calc_ratiolist(): Found no valid Ratiolist Definition!!!")
			//
			// urspr. Packinglist bleibt erhalten!
			//
			lResult					= 0
			dcQuantity 				= lResult
			return lResult
		end if
	end if
end if

lFind = dsRatiolistTyp1.Find("nfrom_pax <= " + string(arg_lCalcBasis) + &
										" and nto_pax >= " + string(arg_lCalcBasis),1,dsRatiolistTyp1.RowCount())
if lFind > 0 then
	lResult					= dsRatiolistTyp1.GetItemNumber(lFind,"nquantity")
	dcQuantity 				= lResult
else
	lResult					= 0
	dcQuantity 				= 0
end if

//
// Falls gar nichts da ist
//
if dsRatiolistTyp1.RowCount() = 0 then
	uf_trace(50,"uf_calc_ratiolist(): dsRatiolistTyp1.RowCount() = 0, lcalcdetailkey = " + string(arg_lcalcdetailkey))
	uf_trace(50,"uf_calc_ratiolist(): end")
	lResult = 0
	return lResult
end if

//
// Sonderbehandlung: CalcBasis $$HEX1$$fc00$$ENDHEX$$berschreitet Definition der Ratiolist
//
if dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nto_pax") < arg_lCalcBasis then
	lResult					= dsRatiolistTyp1.GetItemNumber(dsRatiolistTyp1.RowCount(),"nquantity")
	dcQuantity 				= lResult
end if

uf_trace(50,"uf_calc_ratiolist(): end")

return lResult



end function

public subroutine uf_calc_percent_aa ();//=================================================================================================
//
// uf_calc_percent_aa
//
// Prozentberechnung nach American Airlines. Analog dem alten Dokument
// Autor: Gunnar Brosch
// Datum: 11.10.2012
// 
// 02.11.2012: Gunnar Brosch, QuantityVersion eingebaut
//=================================================================================================
long		ll_i = 0
long		ll_ComponentGroup = 0;
long 		ll_count = 0;
long		ll_percentage = 0;
long		ll_quantity = 0;
long		ll_S1 = 0; 
long		ll_S2 = 0; 
long		ll_SumPercentage = 0;
long		ll_RowCount = 0;
long 		ll_status = 0;
long		ll_quantity_ver = 0;	// *** QuantityVersion ***
long		ll_S1_ver = 0;			// *** QuantityVersion ***
long 		ll_S2_ver = 0;			// *** QuantityVersion ***

ll_status 					= dsCenMeals.GetItemNumber(lCurrentRow,"nstatus");
ll_ComponentGroup 	= dsCenMeals.GetItemNumber(lCurrentRow, "cen_meals_detail_ncomponent_group");
ll_percentage 			= dsCenMeals.GetItemNumber(lCurrentRow, "cen_meals_detail_npercentage");

//31.10.2012: Gunnar Brosch, Testing >>>
string	ls_module = "uf_calc_percent_aa";
string ls_cpackinglist = "";
ls_cpackinglist = dsCenMeals.GetItemString(lCurrentRow, "cen_packinglist_index_cpackinglist");
//FileWrite(in_fileno,  "[" + ls_module +"] " + "Entering: lCurrentRow=" + string(lCurrentRow) + ", ls_cpackinglist="+ls_cpackinglist+ ", ll_ComponentGroup="+string(ll_ComponentGroup) + ", nrotation_name_key=" + string(lRotationNameKey) + ", nstatus="+string(ll_status)+", ll_percentage="+string(ll_percentage)+"...");
//FileWrite(in_fileno,  "[" + ls_module +"] " + "Entering: il_calcbasis_ver=" + string(il_calcbasis_ver)+", lCalcBasis="+string(lCalcBasis));
//<<<

// Wenn Detail schon behandelt, Wert holen und fertig.
if ll_status = 1 then
	dcQuantity 		= dsCenMeals.GetItemDecimal(lCurrentRow, "nquantity");
	idc_quantity_ver= dsCenMeals.GetItemDecimal(lCurrentRow, "nquantity_version"); // *** QuantityVersion ***
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "nstatus=1, dcQuantity		="+string(truncate(dcQuantity,0))+ ", ...Leaving: schon behandelt");
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "nstatus=1, idc_quantity_ver	="+string(truncate(idc_quantity_ver,0))+ ", ...Leaving: schon behandelt"); // *** QuantityVersion ***
	return;
end if

//Komplette Gruppe zu diesem BillingCounttype und lcalcid (!) holen...
string ls_filter = "";
ls_filter = "cen_meals_detail_ncomponent_group = " + string(ll_ComponentGroup) + " and nrotation_name_key = " + string(lRotationNameKey) + " and cen_meals_detail_ncalc_id = " + string(lcalcid);
////FileWrite(in_fileno,  "[" + ls_module +"] " + "Filter="+ls_filter);
dsCenMeals.SetFilter(ls_filter);
dsCenMeals.Filter();
dsCenMeals.SetSort("cen_meals_detail_npercentage A");
dsCenMeals.Sort();

//**********************************************************************
//	Algorithmus nach Uralt-Unterlagen von LSG-NAM
//====================================================
//	STEP 1: Zun$$HEX1$$e400$$ENDHEX$$chst Quantites berechnen:
//	Quantity := kaufm$$HEX1$$e400$$ENDHEX$$nnisches_runden(cen_meals_detail_npercentage * PAX / 100)
//	Man beachte: kaufm$$HEX1$$e400$$ENDHEX$$nnisches_runden(x) = Abrunden(0.5 + x) = truncate(0.5 + x)
//	S1 := Summe(Quantity)
//
//	STEP 2:
//	Zweite Summe bilden: S2 := Aufrunden[ PAX/100 * Summe(cen_meals_detail_npercentage)]
//	Wenn beide Summen gleich => Fertig
//	Wenn S1 < S2 => erh$$HEX1$$f600$$ENDHEX$$he die Quantities der Items mit gr$$HEX2$$f600df00$$ENDHEX$$ter Percentage um 1 solange bis S1=S2
//	Wenn S1 > S2 => verringere die Quantities der Items mit gr$$HEX2$$f600df00$$ENDHEX$$ter Percentage um 1 solange bis S1=S2
//**********************************************************************
ll_S1 = 0;
ll_S2 = 0;
ll_S1_ver = 0; // *** QuantityVersion ***
ll_S2_ver = 0; // *** QuantityVersion ***
ll_SumPercentage = 0;

// STEP 1:
ll_RowCount = dsCenMeals.RowCount();
//FileWrite(in_fileno,  "[" + ls_module +"] " + "RowCount="+string(ll_RowCount));

//Gunnar Brosch, Testing >>>
string	ls_test_cpackinglist = "";
long	ll_test_calcid = 0;
//<<<

for ll_i = 1 to ll_RowCount		
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	integer li_Succ, li_Percentage
	Choose Case dsCenMeals.GetItemNumber(ll_i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(ll_i, "cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(ll_i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	ll_percentage 	= dsCenMeals.GetItemNumber(ll_i, "cen_meals_detail_npercentage");
	ll_quantity 		= truncate(0.5 + (ll_percentage * lCalcBasis) / 100, 0);		
	ll_quantity_ver	= truncate(0.5 + (ll_percentage * il_calcbasis_ver) / 100, 0); // *** QuantityVersion ***
	ll_S1 += ll_quantity;		
	ll_S1_ver += ll_quantity_ver; // *** QuantityVersion ***	
	ll_SumPercentage += ll_percentage;
		
	//Gunnar Brosch, Testing >>>
	ls_test_cpackinglist = dsCenMeals.GetItemString(ll_i, "cen_packinglist_index_cpackinglist");
	ll_test_calcid = dsCenMeals.GetItemNumber(ll_i, "cen_meals_detail_ncalc_id");
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_i="+string(ll_i)+": cpackinglist=" + ls_test_cpackinglist + ", ll_percentage="+string(ll_percentage) + ", ll_quantity="+string(ll_quantity) + ", ll_test_calcid="+string(ll_test_calcid));
	//<<<
	
	//Schon mal Quantity und Status setzen. Eventuell muss die Quantity nochmal ver$$HEX1$$e400$$ENDHEX$$ndert werden. Dazu sp$$HEX1$$e400$$ENDHEX$$ter...
	dsCenMeals.SetItem(ll_i, "nquantity", ll_quantity); 		
	dsCenMeals.SetItem(ll_i, "nquantity_version", ll_quantity_ver); // *** QuantityVersion ***	
	dsCenMeals.SetItem(ll_i, "nstatus", 1);
next

//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1="+string(ll_S1) + ", ll_S1_ver=" + string(ll_S1_ver));

// STEP 2:
//ll_S2 = ceiling((lCalcBasis / 100) * ll_SumPercentage); 

// 24.03.2015: CBASE-HKG-EM-15001 ( "ceiling((7 / 100) * 100) = 8")
ll_S2 = lCalcBasis * ll_SumPercentage
ll_S2 = ceiling(ll_S2 / 100)


ll_S2_ver = ceiling((il_calcbasis_ver / 100) * ll_SumPercentage); // *** QuantityVersion ***	

//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S2="+string(ll_S2) + ", ll_S2_ver=" + string(ll_S2_ver));

//Check, ob die Summen verschieden sind, denn dann m$$HEX1$$fc00$$ENDHEX$$ssen Quantities ver$$HEX1$$e400$$ENDHEX$$ndert werden...
if ll_S1 < ll_S2 then
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1 < ll_S2");
	ll_i = 1;
	do while ll_S1 < ll_S2
		ll_quantity = dsCenMeals.GetItemNumber(ll_i, "nquantity");
		dsCenMeals.SetItem(ll_i, "nquantity", ll_quantity + 1);
	
		//FileWrite(in_fileno,  "[" + ls_module +"] " + "Correct dcQuantity for " + dsCenMeals.GetItemString(ll_i, "cen_packinglist_index_cpackinglist") + " by +1");
	
		ll_i 	+= 1;
		ll_S1 	+= 1;
	loop
end if

if ll_S1 > ll_S2 then
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1 > ll_S2");
	ll_i = 1;
	do while ll_S1 > ll_S2
		ll_quantity = dsCenMeals.GetItemNumber(ll_i, "nquantity");
		if  ll_quantity > 1 then
			dsCenMeals.SetItem(ll_i, "nquantity", ll_quantity - 1);
		end if
		
		//FileWrite(in_fileno,  "[" + ls_module +"] " + "Correct dcQuantity for " + dsCenMeals.GetItemString(ll_i, "cen_packinglist_index_cpackinglist") + " by -1");
			
		ll_i 	+= 1;
		ll_S1 	-= 1;
	loop
end if

// *** QuantityVersion *** >>>
if ll_S1_ver < ll_S2_ver then
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1_ver < ll_S2_ver");
	ll_i = 1;
	do while ll_S1_ver < ll_S2_ver
		ll_quantity_ver = dsCenMeals.GetItemNumber(ll_i, "nquantity_version");
		dsCenMeals.SetItem(ll_i, "nquantity_version", ll_quantity_ver + 1);
	
		//FileWrite(in_fileno,  "[" + ls_module +"] " + "Correct idc_quantity_ver for " + dsCenMeals.GetItemString(ll_i, "cen_packinglist_index_cpackinglist") + " by +1");
	
		ll_i 		+= 1;
		ll_S1_ver	+= 1;
	loop
end if

if ll_S1_ver > ll_S2_ver then
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1_ver > ll_S2_ver");
	ll_i = 1;
	do while ll_S1_ver > ll_S2_ver
		ll_quantity_ver = dsCenMeals.GetItemNumber(ll_i, "nquantity_version");
		if  ll_quantity_ver > 1 then
			dsCenMeals.SetItem(ll_i, "nquantity_version", ll_quantity_ver - 1);
		end if
		
		//FileWrite(in_fileno,  "[" + ls_module +"] " + "Correct idc_quantity_ver for " + dsCenMeals.GetItemString(ll_i, "cen_packinglist_index_cpackinglist") + " by -1");
			
		ll_i 	+= 1;
		ll_S1_ver	-= 1;
	loop
end if
// *** <<<

//Jetzt ist also ll_S1 = ll_S2, bzw. ll_S1_ver = ll_S2_ver
//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1 =" + string(ll_S1) + ", ll_S2="+string(ll_S2));
//FileWrite(in_fileno,  "[" + ls_module +"] " + "ll_S1_ver	=" + string(ll_S1_ver) + ", ll_S2_ver="+string(ll_S2_ver));

// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) );
dsCenMeals.Filter();
dsCenMeals.SetSort("cen_meals_detail_nprio A");
dsCenMeals.Sort();

//Instanzvariablen setzen...
dcQuantity 			= dsCenMeals.GetItemDecimal(lCurrentRow, "nquantity");
idc_quantity_ver	= dsCenMeals.GetItemDecimal(lCurrentRow, "nquantity_version");

//FileWrite(in_fileno,  "[" + ls_module +"] " + "...Leaving: dcQuantity		="+string(truncate(dcQuantity,0)) );
//FileWrite(in_fileno,  "[" + ls_module +"] " + "...Leaving: idc_quantity_ver	="+string(truncate(idc_quantity_ver,0)));

return;
end subroutine

public subroutine uf_calc_linked_aa ();//=================================================================================================
//
// uf_calc_linked_aa
// Autor: Gunnar Brosch
// Datum: 11.10.2012
// 
// Als CurrentRow wird ein Detail vom Typ="Passenger" $$HEX1$$fc00$$ENDHEX$$bergeben. Das verlinkte "Meal"-Detail wird gesucht und dessen Quantity
// $$HEX1$$fc00$$ENDHEX$$bernommen (es sollte existieren).
// 
// 02.11.2012: Gunnar Brosch: QuantityVersion eingebaut
//=================================================================================================
long	ll_packinglist_index_key_l = 0;
long	ll_ComponentGroup = 0;
long	ll_rowid = 0;
long	ll_currentrow_save = 0;
long	ll_calcid_save = 0;
long 	ll_status = 0;

ll_status = dsCenMeals.GetItemNumber(lCurrentRow,"nstatus");
ll_ComponentGroup = dsCenMeals.GetItemNumber(lCurrentRow, "cen_meals_detail_ncomponent_group");

//31.10.2012: Gunnar Brosch, Testing >>>
string	ls_module = "uf_calc_linked_aa";
string ls_cpackinglist = "";
string ls_cpackinglist_linked = "";
ls_cpackinglist = dsCenMeals.GetItemString(lCurrentRow, "cen_packinglist_index_cpackinglist");
//FileWrite(in_fileno,  "[" + ls_module +"] " + "Entering: lCurrentRow=" + string(lCurrentRow) + ", ls_cpackinglist="+ls_cpackinglist+ ", ll_ComponentGroup="+string(ll_ComponentGroup) + ", nrotation_name_key=" + string(lRotationNameKey) + ", nstatus="+string(ll_status)+"...");
//<<<

// Falls Detail schon behandelt wurde: R$$HEX1$$fc00$$ENDHEX$$ckgabe der bereits berechneten Quantity
if ll_status = 1 then
	// Mahlzeit wurde schon berechnet, einfach die schon berechnete Qunantity holen und Instanzvariablen setzen!
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow, "nquantity");
	idc_quantity_ver	= dscenmeals.GetItemDecimal(lCurrentRow, "nquantity_version"); // *** QuantityVersion ***
	
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "nstatus=1, dcQuantity		="+string(truncate(dcQuantity,0))+ ", ...Leaving: schon behandelt");
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "nstatus=1, idc_quantity_ver	="+string(truncate(idc_quantity_ver,0))+ ", ...Leaving: schon behandelt"); // *** QuantityVersion ***

	return;
end if

// Im "cen_meals_detail_npackinglist_index_key_l" steht der "cen_meals_detail_npackinglist_index_key" der verlinkten Mahlzeit.
ll_packinglist_index_key_l = dscenmeals.GetItemNumber(lCurrentRow, "cen_meals_detail_npackinglist_index_key_l");

//Suchen den verlinkten Satz...
string ls_filter = "";
ls_filter = "cen_meals_detail_npackinglist_index_key = " + string(ll_packinglist_index_key_l) + " and nrotation_name_key = " + string(lRotationNameKey);	
//FileWrite(in_fileno,  "[" + ls_module +"] " + "Filter=" + ls_filter);	
ll_rowid = dsCenMeals.find(ls_filter, 1, dscenmeals.rowcount());

// 03.02.2016 HR: Nicht nur bei kleiner 0 sondern auch bei 0 raus
if ll_rowid <= 0 then
	//ERROR
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "Keine verlinkte Mahlzeit gefunden !!!");
	return;
end if

//Testing >>>
ls_cpackinglist_linked = dsCenMeals.GetItemString(ll_rowid, "cen_packinglist_index_cpackinglist");
//FileWrite(in_fileno,  "[" + ls_module +"] " + "Verlinkte Mahlzeit="+ls_cpackinglist_linked);
//<<<

//Meal wurde gefunden. 
//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Meal schon behandelt wurde, wenn nicht, dann $$HEX1$$fc00$$ENDHEX$$ber Aufruf der calc_percent_aa()-Funktion abhandeln:
if dscenmeals.GetItemNumber(ll_rowid, "nstatus") = 0 then
	//FileWrite(in_fileno,  "[" + ls_module +"] " + "Meal wurde noch nicht behandelt, also jetzt Quantity berechnen...");
	//jetzt kurz die CurrentRow verbiegen...
	ll_currentrow_save = lCurrentRow;
	ll_calcid_save = lcalcid;
	lCurrentRow = ll_rowid;
	lcalcid = 96;  // 26.03.2013 HR: Auch hier die Calcid von 93 auf 96 ge$$HEX1$$e400$$ENDHEX$$ndert
	uf_calc_percent_aa(); //Danach sind die Instanzvariablen dcQuantity, idc_quantity_ver gesetzt!!!
	
	//und jetzt wieder umbiegen...
	lCurrentRow = ll_currentrow_save;
	lcalcid = ll_calcid_save;
end if

//Quantities speichern. Satz als erledigt markieren...
dsCenMeals.SetItem(lCurrentRow, "nquantity", dcQuantity);
dsCenMeals.SetItem(lCurrentRow, "nquantity_version", idc_quantity_ver); // *** QuantityVersion ***
dsCenMeals.SetItem(lCurrentRow, "nstatus", 1);

//Gunnar Brosch, 31.10.2012>>>
//FileWrite(in_fileno,  "[" + ls_module +"] " + "...Leaving: dcQuantity			="+string(truncate(dcQuantity,0)));
//FileWrite(in_fileno,  "[" + ls_module +"] " + "...Leaving: idc_Quantity_ver	="+string(truncate(idc_Quantity_ver,0))); // *** QuantityVersion ***
//<<<

return;
end subroutine

protected function integer uf_calc_percent (decimal dcargument);//=================================================================================================
//
// uf_calc_percent
//
// Prozentberechnung mit LH Rundung
//
//02.11.12: Gunnar Brosch: QuantityVersion eingebaut
//=================================================================================================

Integer	li_Succ
long		i
long		lFind
Integer	li_Percentage
integer	iPerc
integer	iPercCounter	// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQuantity
integer	iComponents		// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter	// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
decimal	dcResult
decimal	dcResult_ver = 0; 		//05.11.12, Gunnar Brosch: QuantityVersion
integer	iMealCounter_ver = 0;	//05.11.12, Gunnar Brosch: QuantityVersion

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 	
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version"); //05.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if

//
// Komplette Gruppe holen
//
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey))
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()
//
// Prozente ausrechnen
//
for i = 1 to dscenmeals.RowCount()
	// --------------------------------------------------------------------------------------------------------------------
	// 22.10.2015 HR: CBASE-DE-CR-2015-054: Bei bestimmten Berechnungsarten gibt es flugnummernabh$$HEX1$$e400$$ENDHEX$$ngige
	//                        Werte f$$HEX1$$fc00$$ENDHEX$$r die Berechnung
	// --------------------------------------------------------------------------------------------------------------------
	Choose Case dsCenMeals.GetItemNumber(i, "cen_meals_detail_ncalc_id")
		case 5,6 //1, 4, 5, 6, 7, 9, 10, 11, 12, 13, 21, 22, 95
			li_Succ = uf_get_flight_parm_diff ( dsCenMeals.GetItemNumber(i,"cen_meals_detail_nhandling_detail_key"), il_flgnr, is_suffix, li_Percentage, dcValue, lMinValue, lMaxValue)
			If li_Percentage > 0 Then
				dsCenMeals.SetItem(i,"cen_meals_detail_npercentage", li_Percentage)
			End If
				
	End Choose

	iPerc			= dsCenMeals.GetItemNumber(i,"cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	if mod(i,2) = 1 then
		//
		// ungerade Werte aufrunden
		//
		//dcResult		= round( (((lCalcBasis * iPerc)/100) + 0.5),0) // evtl. mu$$HEX2$$df002000$$ENDHEX$$nichts dazugez$$HEX1$$e400$$ENDHEX$$hlt werden
		dcResult		= ceiling((lCalcBasis * iPerc)/100)
		dcResult_ver= ceiling((il_calcbasis_ver * iPerc)/100); //05.11.12, Gunnar Brosch: QuantityVersion		
	else
		dcResult		= truncate( ((lCalcBasis * iPerc)/100) ,0)
		if dcResult < 1 then dcResult = 1		
		dcResult_ver = max(truncate( ((il_calcbasis_ver * iPerc)/100) ,0), 1); //05.11.12, Gunnar Brosch: QuantityVersion
	end if
	
	dscenmeals.SetItem(i,"nquantity",dcResult)
	iMealCounter += dcResult
	
	//05.11.12, Gunnar Brosch: QuantityVersion >>>
	dscenmeals.SetItem(i,"nquantity_version", dcResult_ver);
	iMealCounter_ver += dcResult_ver;
	//<<<
	
next

//
// Bei CalcBasis = 0: raus hier
//

// 05.11.12: Gunnar Brosch: QuantityVersion: Wir k$$HEX1$$f600$$ENDHEX$$nnen jetzt hier nicht einfach aussteigen, da sonst bei il_calcbasis_ver > 0
// keine Berechnung stattfindet. Also hier auskommentiert und ganz ans Ende gesetzt.
/*
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
	//
	// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
	//
	// 27.04.2005 dsCenMeals.SetFilter("")
	dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
	dsCenMeals.Filter()
	dsCenMeals.SetSort("cen_meals_detail_nprio A")
	dsCenMeals.Sort()
	return 0
end if
*/
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

/* Merker:

- Mindestens eine Mahlzeit bei Auswahlessen
- 100% darf nicht gr$$HEX2$$f600df00$$ENDHEX$$er oder kleiner als die Gesamtpassagierzahl sein
- Unter- oder $$HEX1$$fc00$$ENDHEX$$ber-100% ist m$$HEX1$$f600$$ENDHEX$$glich
- Abzug von Mahlzeiten anderer Klassen nicht vergessen

*/
//f_print_datastore(dscenmeals)
//
// Check gegen Passagierzahl und Status setzen
//

//05.11.12: Gunnar Brosch: QuantityVersion: Hier nur, wenn lCalcBasis > 0, also $$HEX1$$fc00$$ENDHEX$$bergeordnetes if eingef$$HEX1$$fc00$$ENDHEX$$gt: s.o. >>>>>>>>>>>>>>>>>>>>>>>>>>>
if lCalcBasis > 0 then 
if iMealCounter > lCalcBasis then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult > 1 then
				dcResult --
				iMealCounter --
				dscenmeals.SetItem(i,"nquantity",dcResult)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter > lCalcBasis and iMealCounter > iComponents then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult --
			iMealCounter --
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter < lCalcBasis  then
			dcResult = dscenmeals.GetItemDecimal(i,"nquantity") 
			dcResult ++
			iMealCounter ++
			dscenmeals.SetItem(i,"nquantity",dcResult)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if

// --------------------------------------------------------------
// 09.03.2007, KF
// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
// --------------------------------------------------------------
Long 		lMultiply
Decimal 	decTemp

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult = dscenmeals.GetItemDecimal(i, "nquantity") + decTemp
		
		if dcResult < 0 then dcResult = 0
		
		dscenmeals.SetItem(i,"nquantity",dcResult)
		
	
	next 
end if


//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet = iMealCounter - lCalcBasis
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
dcQuantity = dscenmeals.GetItemDecimal(1,"nquantity") 


// 05.11.12, Gunnar Brosch: Abgeklemmt, da ja jetzt noch weitere Berechnungen folgen... >>>>
/*
//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()
*/
//<<< abgeklemmt

//dsCenMeals.SetFilter("")
//dsCenMeals.Filter()
//
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()

end if	//05.11.12, Gunnar Brosch: QuantityVersion: Rest nur, wenn lCalcBasis > 0, s.o. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//05.11.12: Gunnar Brosch: QuantityVersion: Rest nur, wenn il_calcbasis_ver > 0, s.o. >>>>>>>>>>>>>>>>>>>>>>>>>>>
if il_calcbasis_ver > 0 then 
if iMealCounter_ver > il_calcbasis_ver then
	for i = dscenmeals.RowCount() to 1 step -1
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver > il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			//
			// neu: Sch$$HEX1$$fc00$$ENDHEX$$tzt die letzte Komponente vor dem null werden
			//
			if dcResult_ver > 1 then
				dcResult_ver --
				iMealCounter_ver --
				dscenmeals.SetItem(i,"nquantity_version", dcResult_ver)
			end if
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver < il_calcbasis_ver then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version", dcResult_ver)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
else
	for i = 1 to dscenmeals.RowCount()
		//
		// Falls $$HEX1$$dc00$$ENDHEX$$berbeladung durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver > il_calcbasis_ver and iMealCounter_ver > iComponents then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver --
			iMealCounter_ver --
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		//
		// Falls zu wenig beladen wurde durch Rundungsprobleme...
		//
		if iPercCounter = 100 and iMealCounter_ver < il_calcbasis_ver  then
			dcResult_ver = dscenmeals.GetItemDecimal(i,"nquantity_version") 
			dcResult_ver ++
			iMealCounter_ver ++
			dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
		end if
		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	
	next
end if

// --------------------------------------------------------------
// 09.03.2007, KF
// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
// --------------------------------------------------------------
//Long 		lMultiply
//Decimal 	decTemp

if dcArgument < 0 then
	lMultiply = -1
else
	lMultiply = 1
end if
	
if dcArgument <> 0 then
	
	for i = 1 to dscenmeals.RowCount()
		
		decTemp = dsCenMeals.GetItemDecimal(i,"cen_meals_detail_nvalue") * lMultiPly
		
		dcResult_ver = dscenmeals.GetItemDecimal(i, "nquantity_version") + decTemp
		
		if dcResult_ver < 0 then dcResult_ver = 0
		
		dscenmeals.SetItem(i,"nquantity_version",dcResult_ver)
			
	next 
end if


//
// $$HEX1$$dc00$$ENDHEX$$berbeladungen in cen_out_meals.noverload temp. merken
//
if iPercCounter > 100 then
	lOverloadSet_ver = iMealCounter_ver - il_calcbasis_ver
end if

//
// Menge des ersten Wertes der Gruppe setzen
//
idc_quantity_ver = dscenmeals.GetItemDecimal(1,"nquantity_version") 

//dsCenMeals.SetFilter("")
//dsCenMeals.Filter()
//
//dsCenMeals.SetSort("cen_meals_detail_nprio A")
//dsCenMeals.Sort()

end if	//05.11.12, Gunnar Brosch: QuantityVersion: Rest nur, wenn lCalcBasis > 0, s.o. <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//05.11.12, Gunnar Brosch: den Fall jetzt ans Ende verlegt
if lCalcBasis = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity",0)		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	dcQuantity = 0
end if

if il_calcbasis_ver = 0 then
	for i = 1 to dscenmeals.RowCount()
		dscenmeals.SetItem(i,"nquantity_version",0)		
		//
		// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
		//
		dscenmeals.SetItem(i,"nstatus",1)
	next	
	idc_quantity_ver = 0
end if

//
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
//
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0

end function

public subroutine uf_calc_multiple_fixed_aa ();//=================================================================================================
//
// uf_calc_multiple_fixed_aa
//
// Prozentberechnung nach American Airlines. Analog dem alten Dokument
// Autor: Gunnar Brosch
// Datum: 08.01.2013
// Nach Absprche mit Fr. Schlegel wird im 
// Wert-Feld:  Multiple
// Max-Feld: Fixed eingetragen (hier wird Max-Feld also umfunktioniert)
//=================================================================================================


// dcValue: Multiple
// lMaxValue: Fixed

// --------------------------------------------------------------------------------------------------------------------
// 27.12.2016 HR: Falls Stammdatenfehler und Menge gleich 0 ist, diff by null verhindern
// --------------------------------------------------------------------------------------------------------------------
if dcValue = 0 then
	dcQuantity = 0 
	idc_quantity_ver = 0
else
	dcQuantity = ceiling(lCalcBasis/dcValue) + lMaxValue;
	if isnull(dcQuantity) then dcQuantity=0 // 27.03.2013 HR:
	
	
	// und dergleichen f$$HEX1$$fc00$$ENDHEX$$r die Variation
	idc_quantity_ver =ceiling(il_calcbasis_ver/dcValue) + lMaxValue;
	if isnull(idc_quantity_ver) then idc_quantity_ver=0 // 27.03.2013 HR:
	
end if	

end subroutine

public function integer uf_calc_bob_multiple (integer nwithmax);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_bob_multiple (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer nwithmax
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
//  22.01.2013	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long lResult, i
long lresult_ver = 0
long lBRTM, lBRTN, lMXQTY

If dsFlightData.Rowcount() <= 0 Then
	dcQuantity 			= 0
	idc_quantity_ver	= 0
	lMXQTY 				= 0
else
	//Sind auch Daten f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste vorhanden?
	//i=dsFlightData.find("cpackinglist = '"+sPackinglist+"'",1,dsFlightData.rowcount())
	// 09.08.2016 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen auch die Klasse ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
	i=dsFlightData.find("cpackinglist = '"+sPackinglist+"' and cclass='" + sclass +  "'"  ,1,dsFlightData.rowcount())
			
	if i=0 then
		dcQuantity 			= 0
		idc_quantity_ver	= 0
		lMXQTY				= 0
	else
		
		lBRTM	=  dsFlightData.GetItemNumber(i,"nbrtm")
		lBRTN		=  dsFlightData.GetItemNumber(i,"nbrtn")
		lMXQTY	=  dsFlightData.GetItemNumber(i,"nload_minimum")
		
		if lBRTN = 0 then lBRTN = 1
		
		// --------------------------------------------------------------------------------------------------------------------
		// 22.01.2016 HR: Wenn Null, dann setzen wir sie auf 1
		// --------------------------------------------------------------------------------------------------------------------
		if isnull(lBRTN) then lBRTN = 1 
		if isnull(lBRTM) then lBRTM = 1 
				
		lResult = truncate(lCalcBasis / lBRTN, 0)				
		lresult_ver = truncate(il_calcbasis_ver / lBRTN, 0)
		
		If Mod(lCalcBasis, integer(lBRTN)) > 0 then lResult++	// Falls Rest aus Division, dann bis zum n$$HEX1$$e400$$ENDHEX$$chsten Schritt
		if mod(il_calcbasis_ver, integer(lBRTN)) > 0 then lresult_ver++																
		
		dcQuantity 			= lResult * lBRTM
		idc_quantity_ver 	= lresult_ver * lBRTM
	end if			
end if

dcValue = lBRTN

if nwithmax = 1 then
	if dcQuantity > lMXQTY then  dcQuantity = lMXQTY
	
	if idc_quantity_ver > lMXQTY then  idc_quantity_ver = lMXQTY
end if

return 0

end function

public function integer uf_calc_percent_round_off_with_absolute ();/*
* Objekt : uo_meal_calculation
* Methode: uf_calc_percent_round_off_with_absolute (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 02.04.2013
*
* Argument(e):
* none
*
* Beschreibung:		CBASE-ZA-CR-8005; Berechnet Prozent mit kfm. Rundung plus absoluten Wert
*							angepasste Kopie von uf_calc_percent_round_down
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	02.04.2013		Erstellung
*
*
* Return: integer
*
*/


//=================================================================================================
//
// uf_calc_percent_round_off_with_absolute
//
// Prozentberechnung kfm. runden plus absolut
//
//=================================================================================================
long		ll_Count
long		lFind

integer	iPerc
integer	iPercCounter				// der Prozentz$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt
integer	iQty_Abs
integer	iComponents					// Anzahl der Mahlzeiten in der Componentengruppe
integer	iMealCounter				// der Quantity-Z$$HEX1$$e400$$ENDHEX$$hler, der $$HEX1$$dc00$$ENDHEX$$ber/Unterbeladungen feststellt 
integer	li_MealCounter_ver
decimal	dcResult
decimal	dcResult_ver				// 07.11.12, Gunnar Brosch: QuantityVersion

//
// Achtung: 
// Wenn Prozentberechnung 3-zeilig im Datastore ist, ist sie trotzdem als Einheit zu betrachten.
// Merker setzen: Mahlzeit wurde ber$$HEX1$$fc00$$ENDHEX$$cksichtigt (dscenmeals.nstatus)
// In diesem Fall wird lediglich die bereits kalkulierte Auftragsmenge geholt.
//
if dscenmeals.GetItemNumber(lCurrentRow,"nstatus") = 1 then
	//
	// Mahlzeit wurde schon berechnet, einfach die vorkalkulierte Menge setzen!
	// dcQuantity = ...
	//
	dcQuantity 			= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity") 
	idc_quantity_ver 	= dscenmeals.GetItemDecimal(lCurrentRow,"nquantity_version");  // 07.11.12, Gunnar Brosch: QuantityVersion
	return 1
end if

// --------------------------------------------------------------
// Komplette Gruppe holen
// --------------------------------------------------------------
dsCenMeals.SetFilter("cen_meals_detail_ncomponent_group = " + string(iComponentGroup) + &
							" and nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

iComponents = dscenmeals.RowCount()

// --------------------------------------------------------------
// Prozente ausrechnen kfm. runden
// --------------------------------------------------------------
for ll_Count = 1 to dscenmeals.RowCount()
	iQty_Abs    = dsCenMeals.GetItemDecimal(ll_Count, "cen_meals_detail_nvalue")
	iPerc			= dsCenMeals.GetItemNumber(ll_Count, "cen_meals_detail_npercentage")
	iPercCounter += iPerc
	
	// Vorlage: immer abrunden
	//dcResult		= truncate( ((lCalcBasis * iPerc)/100) ,0)
	//dcResult_ver= truncate( ((il_calcbasis_ver * iPerc)/100) ,0);	// 07.11.12, Gunnar Brosch: QuantityVersion
	
	dcResult			= (lCalcBasis * iPerc / 100) + 0.5
	dcResult			= Truncate(dcResult, 0)	
	dcResult_ver 	= (il_calcbasis_ver * iPerc / 100) + 0.5
	dcResult_ver	= Truncate(dcResult_ver, 0)	
		
	//	if dcResult < 1 		then dcResult 		= iDefault
	//	if dcResult_ver < 1 then dcResult_ver 	= iDefault; 				// 07.11.12, Gunnar Brosch: QuantityVersion
		
	dcResult			+= iQty_Abs
	dcResult_ver	+= iQty_Abs
		
		
	If dcResult < 0 then dcResult = 0 
	If dcResult_ver < 0 then dcResult_ver = 0 
	
		
	dscenmeals.SetItem(ll_Count,"nquantity",dcResult)
	dscenmeals.SetItem(ll_Count,"nquantity_version",dcResult_ver);		// 07.11.12, Gunnar Brosch: QuantityVersion
	
	iMealCounter 		+= dcResult
	li_MealCounter_ver	+= dcResult_ver;								// 07.11.12, Gunnar Brosch: QuantityVersion
	
	// --------------------------------------------------------------
	// Status setzen, damit n$$HEX1$$e400$$ENDHEX$$chster Lauf nicht noch einmal kalkuliert
	// --------------------------------------------------------------
	dscenmeals.SetItem(ll_Count,"nstatus",1)
	
next

//// --------------------------------------------------------------
//// 09.03.2007, KF
//// die Funktion uf_calc_percent, kombinierbar mit +/- Absolut
//// --------------------------------------------------------------
//if dcArgument <> 0 then
//	for i = 1 to dscenmeals.RowCount()
//			
//		dcResult 			= dscenmeals.GetItemDecimal(i, "nquantity") 			+ dcArgument
//		dcResult_ver 	= dscenmeals.GetItemDecimal(i, "nquantity_version") + dcArgument;	// 07.11.12, Gunnar Brosch: QuantityVersion
//		
//		if dcResult 		< 0 then dcResult = 0
//		if dcResult_ver 	< 0 then dcResult_ver = 0;					// 07.11.12, Gunnar Brosch: QuantityVersion		
//		
//		dscenmeals.SetItem(i,"nquantity",dcResult)
//		dscenmeals.SetItem(i,"nquantity_version",dcResult_ver);	// 07.11.12, Gunnar Brosch: QuantityVersion		
//	
//	next 
//end if

// --------------------------------------------------------------
// Menge des ersten Wertes der Gruppe setzen
// --------------------------------------------------------------
dcQuantity 			= dscenmeals.GetItemDecimal(1,"nquantity")
idc_quantity_ver 	= dscenmeals.GetItemDecimal(1,"nquantity_version");	// 07.11.12, Gunnar Brosch: QuantityVersion

// --------------------------------------------------------------
// Filter zur$$HEX1$$fc00$$ENDHEX$$ck und Sortierung wiederherstellen
// --------------------------------------------------------------
dsCenMeals.SetFilter("nrotation_name_key = " + string(lRotationNameKey) )
dsCenMeals.Filter()
dsCenMeals.SetSort("cen_meals_detail_nprio A")
dsCenMeals.Sort()

return 0


end function

public function integer uf_retrieve_local_subst (string arg_cunit, long arg_nairline_key, long arg_nflight_number, string arg_csuffix, date arg_ddeparture, string arg_cdeparture_time, long arg_naircraft_key, long arg_nrouting_id, long arg_ntlc_from, long arg_ntlc_to, long arg_nhandling_type_key, long arg_nresult_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_retrieve_local_subst (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
//  string arg_cunit
//  long arg_nairline_key
//  long arg_nflight_number
//  string arg_csuffix
//  date arg_ddeparture
//  string arg_cdeparture_time
//  long arg_naircraft_key
//  long arg_nrouting_id
//  long arg_ntlc_from
//  long arg_ntlc_to
//  long arg_nhandling_type_key
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
//  25.09.2012	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
integer iDay, i

//Wochentag ermitteln
iDay = daynumber(arg_ddeparture) -1
if iDay =0 then iDay = 7

//Filter auf Wochentag setzen
idsLocalSubst.setfilter("loc_subst_flight_nfreq"+string(iDay)+" =1")
idsLocalSubst.filter()

//Locale Ersetzungen lesen
i = idsLocalSubst.retrieve(arg_cunit, arg_nairline_key, arg_nflight_number, arg_csuffix, arg_ddeparture, arg_cdeparture_time, arg_naircraft_key, arg_nrouting_id, arg_ntlc_from, arg_ntlc_to, arg_nhandling_type_key )

uf_trace(3, "uf_retrieve_local_subst: Rows in idsLocalSubst: "+string(idsLocalSubst.rowcount()))

il_nlocal_sub_flight = 0

// 23.10.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus
/*  Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus
// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling
i = idsLocalEuSubst.retrieve(arg_nresult_key)
uf_trace(3, "uf_retrieve_local_subst: Rows in idsLocalEuSubst: "+string(idsLocalEuSubst.rowcount()))
 Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling wieder raus */
 
return 1
end function

public function integer uf_calc_pax_via_forecast_ratio_mass (string arg_cclass, long arg_npax, long arg_nservice, ref integer arg_nstatus);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_pax_via_forecast_ratio_mass (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_cclass
//  long arg_npax
//  long arg_nservice
//  ref integer arg_nstatus
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
//  16.07.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------
// Sonderbehandlung Meal-Forecast ("Japan-Tool") -----------------------------------
// --------------------------------------------------------------------------------------------

Decimal   lde_nratio
Long		 ll_rownum
Long		 ll_count
String		 ls_cspml
String	  	 ls_cclass
Integer	 li_ntype
Integer	 ll_nfcspml_key
Decimal	 lde_spml_ethnic
Decimal	 lde_spml_western
Decimal	 lde_npax_netto
Decimal	 lde_npax_ethnic
Decimal	 lde_npax_western
Integer	 li_nquantity
Integer	 li_npax_ethnic
Integer	 li_npax_western
DateTime ldt_GenerationDateUTC

DataStore lds_forecast_ratio
DataStore lds_forecast_ethnic_spml

lds_forecast_ratio = Create DataStore
lds_forecast_ratio.DataObject = "dw_forecast_ratio"
lds_forecast_ratio.SetTransObject(SQLCA)

ldt_GenerationDateUTC = DateTime(dGenerationDateUTC)

// Erst mal nachsehen, ob f$$HEX1$$fc00$$ENDHEX$$r den Flug an diesem Tag $$HEX1$$fc00$$ENDHEX$$berhaupt ein Ratio zur Berechnung da ist ...
lds_forecast_ratio.Retrieve(lAirlineKey, il_flgnr, arg_cClass, arg_nService, ldt_GenerationDateUTC)

arg_nStatus  = -1

// Ok, ist da -> Ratio und Typ merken ...
IF 	lds_forecast_ratio.RowCount() > 0 THEN

	lde_nratio				= 	lds_forecast_ratio.GetItemNumber(1,"nratio")
	li_ntype					=	lds_forecast_ratio.GetItemNumber(1,"ntype")

	lde_npax_netto			=	0
	lde_spml_ethnic		=	0
	lde_spml_western		=	0

	// Special Meals des Fluges durchlesen und ethnische und nicht-ethnische SPML z$$HEX1$$e400$$ENDHEX$$hlen ...
	IF 	dsspml.RowCount() > 0 THEN

		lds_forecast_ethnic_spml = Create DataStore
		lds_forecast_ethnic_spml.DataObject = "dw_forecast_ethnic_spml"
		lds_forecast_ethnic_spml.SetTransObject(SQLCA)

		for ll_rownum = 1 to  dsspml.RowCount()

			// Pro Special Meal - Test ob in der zur Flugnummer geh$$HEX1$$f600$$ENDHEX$$renden Tabelle mit ethnischen SPML ...
			ls_cclass		=  dsspml.GetItemString(ll_rownum,"cclass")
			ls_cspml 		=  dsspml.GetItemString(ll_rownum,"cspml")
			li_nquantity 	=  dsspml.GetItemNumber(ll_rownum,"nquantity")

			//SPML der aktuellen Klasse ?
			IF ls_cclass = arg_cClass THEN
				
				// Handelt es sich bei dem SPML um ein ethnisches SPML ?
				ll_count	= lds_forecast_ethnic_spml.Retrieve(lAirlineKey, il_flgnr, arg_cClass, ls_cspml, ldt_GenerationDateUTC)
		
				// Wenn gefunden => Anzahl ethnischer Meals erh$$HEX1$$f600$$ENDHEX$$hen ...
				IF	ll_count > 0 THEN
					lde_spml_ethnic 	= 	lde_spml_ethnic + li_nquantity
				ELSE
					// Wenn nicht gefunden => Anzahl westlicher Meals erh$$HEX1$$f600$$ENDHEX$$hen ...
					lde_spml_western	=	lde_spml_western + li_nquantity
				END IF
				
			END IF				

		next 		
		
	END IF // IF 	dsspml.RowCount() > 0 ...
	
	// Netto-Pax = Pax - SPMLs
	lde_npax_netto = arg_nPax - lde_spml_western - lde_spml_ethnic

	// ethnische MZ-Def ...
	IF li_ntype = 1 THEN
		lde_npax_ethnic = 								(	lde_npax_netto * lde_nratio	)	-  lde_spml_ethnic
	ELSE
		// Westliche MZ-Def ...
		lde_npax_ethnic = lde_npax_netto   - 	(	(	lde_npax_netto * lde_nratio	) 	-  lde_spml_ethnic	)
	END IF

	// Pr$$HEX1$$fc00$$ENDHEX$$fungen der ethnischen Paxe
	IF lde_npax_netto - lde_npax_ethnic 	<	2 THEN

		IF 	lde_npax_netto < 10 THEN
			lde_npax_ethnic = lde_npax_ethnic - 1
		ELSE
			lde_npax_ethnic = lde_npax_ethnic - 2						
		END IF
	
		IF 	lde_npax_ethnic < 0 THEN
			lde_npax_ethnic = 0
		END IF
		
	END IF

	// Westliche Paxe
	lde_npax_western = lde_npax_netto -  lde_npax_ethnic + lde_spml_western + lde_spml_ethnic

	// Pr$$HEX1$$fc00$$ENDHEX$$fungen der westlichen Paxe
	IF 	lde_npax_western < 0 THEN
		lde_npax_western = 0
	END IF
	
ELSE // IF 	lds_forecast_ratio.RowCount() > 0 ...
	
	// F$$HEX1$$fc00$$ENDHEX$$r den Flug ist an diesem Tag kein Ratio zur Berechnung da => regul$$HEX1$$e400$$ENDHEX$$re Paxzahl zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
	DESTROY lds_forecast_ethnic_spml		
	DESTROY lds_forecast_ratio
	
	RETURN arg_nPax
	
END IF // IF 	lds_forecast_ratio.RowCount() > 0 ...

DESTROY lds_forecast_ethnic_spml		
DESTROY lds_forecast_ratio

li_npax_ethnic 		= ROUND(lde_npax_ethnic,0)
li_npax_western 	= ROUND(lde_npax_western,0)

arg_nStatus 		= -2

// Wenn Etnische Mahlzeit => ethnische Paxe zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
IF ii_nethnic = 1 THEN
	RETURN li_npax_ethnic
ELSE
// Wenn westliche Mahlzeit => westliche Paxe zur$$HEX1$$fc00$$ENDHEX$$ckgeben ...
	RETURN li_npax_western
END IF	
end function

public function integer uf_get_flight_parm_diff (long arg_handling_detail_key, long arg_nflight_number, string arg_csuffix, ref integer arg_npercentage, ref decimal arg_nvalue, ref long arg_nmin_value, ref long arg_nmax_value);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_get_flight_parm_diff (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_handling_detail_key
//  long arg_nflight_number
//  string arg_csuffix
//  ref integer arg_npercentage
//  ref decimal arg_nvalue
//  ref decimal arg_nmin_value
//  ref decimal arg_nmax_value
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
//  06.08.2015	   1.0      H.Rothenbach   Erstellung
//  19.1$$HEX1$$df00$$ENDHEX$$.2015		1.1      O.Hoefer       NULL => 0
//
// --------------------------------------------------------------------------------------------------------------------

long		ll_handling_detail_key, ll_percentage
decimal	ldec_value, ldec_min_value, ldec_max_value

SELECT cen_meals_det_dev_calc_mode.nhandling_detail_key,   
         cen_meals_det_dev_calc_mode.npercentage,   
         cen_meals_det_dev_calc_mode.nvalue,   
         cen_meals_det_dev_calc_mode.nmin_value,   
         cen_meals_det_dev_calc_mode.nmax_value  
 INTO :ll_handling_detail_key,   
         :ll_percentage,   
         :ldec_value,   
         :ldec_min_value,   
         :ldec_max_value  
FROM cen_meals_det_dev_calc_mode  
WHERE cen_meals_det_dev_calc_mode.nhandling_detail_key = :arg_handling_detail_key
    AND cen_meals_det_dev_calc_mode.nflight_number = :arg_nflight_number 
	USING SQLCA	;

/*	   AND cen_meals_det_dev_calc_mode.csuffix = :arg_csuffix     aktuell noch nicht relevant/pflegbar */


if sqlca.sqlcode=0 then
	//Falls SQL ohne Fehler zur$$HEX1$$fc00$$ENDHEX$$ck kommt $$HEX1$$fc00$$ENDHEX$$bernehmen wir die Werte
	if isnull(ll_percentage) then
		arg_npercentage 	= 0
	else
		arg_npercentage 	= ll_percentage
	end if
	
	if isnull(ldec_value) then
		ldec_value 	= 0
	end if
	
	if isnull(arg_nvalue) then
		arg_nvalue 	= 0
	else
		arg_nvalue 			= ldec_value
	end if
		
	arg_nmin_value 	= ldec_min_value
	arg_nmax_value 	= ldec_max_value
Else
	
	if isnull(ldec_value) then
		ldec_value 	= 0
	end if
	
end if

return 1

end function

public function integer uf_calc_fixed_acver_tlcfrom ();/*
* Objekt : uo_meal_calculation
* Methode: function integer uf_calc_fixed_acver_tlcfrom ()
* Autor  : MHO
* Datum  : 21.10.2015
*
* Argument(e):
* none
*
* Beschreibung:         Feste Menge pro AC Typ & Version und Departure Station
*                   (CBASE-CR-UK-2015-014)
*
* Aenderungshistorie:
* Version         Wer               Wann              Was und warum
* 1.0                   MHO         27.10.2015       Erstellung 
*                                           auf Basis von uf_calc_fixed_ac_version
*                                           (CBASE-CR-UK-2015-014)
* Return: integer
*
*/

Long        ll_Value
Long        ll_AC_Type
Long        ll_Meal_Detail_Key

long        ll_tlc_from

ll_AC_Type				= laircraftkey
ll_Meal_Detail_Key		= lHandlingDetailKey

select ntlc_from
   into :ll_tlc_from
  from cen_out
where nresult_key = :this.lResultKey;

if sqlca.sqlcode <> 0 then
	// Kein Abflughafen gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
	if il_tlc_from = -1  then
		uf_trace(20,"uf_calc_fixed_acver_tlcfrom(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
		return 1
	else
		// $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
		ll_tlc_from = il_tlc_from
	end if
end if	

SELECT	nvalue  
   INTO	:ll_Value  
  FROM	CEN_MEALS_ACVERVALDEPCTY  
WHERE	nhandling_detail_key	= :ll_Meal_Detail_Key  
    AND	naircraft_key            	= :ll_AC_Type
    AND	ntlc_from				= :ll_tlc_from;

if sqlca.sqlcode <> 0 then
      // Kein Eintrag f$$HEX1$$fc00$$ENDHEX$$r AC Type + Dept Station vorhanden => Default
      dcQuantity =  dcvalue
else
      if isnull(ll_Value) then ll_Value=0
      
      dcQuantity = ll_Value
end if

idc_quantity_ver = dcQuantity;     // Gunnar Brosch, 20.11.12: Quantity Version

Return 0


end function

public function integer uf_replace_pl_for_aircraft ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_replace_pl_for_aircraft (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Wir schauen f$$HEX1$$fc00$$ENDHEX$$r die ermittelten Mahlzeiten, ob wir da f$$HEX1$$fc00$$ENDHEX$$r den Aircraftkey eine andere
//                       St$$HEX1$$fc00$$ENDHEX$$ckliste gezogen werden soll
//                       (CBASE-UK-CR-2015-032: Add aircraft to Handling Object)
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  11.03.2016	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long 			j
datastore 	lds

lds = create datastore
lds.dataobject = "dw_exp_cen_meals_det_plsubst"
lds.settransobject(SQLCA)

for j = 1 to dsCenMeals.RowCount()
	
	lds.retrieve(dsCenMeals.getitemnumber(j, "cen_meals_detail_nhandling_detail_key") , lAircraftKey, dGenerationDate)
	
	if lds.rowcount()>0 then
		uf_trace(20,"[uf_replace_pl_for_aircraft] Found Replacement for Entry: "+string(dsCenMeals.getitemnumber(j, "cen_meals_detail_nhandling_detail_key"))+" and AC-Key: "+string(lAircraftKey))

		dsCenMeals.setitem(j,"cen_meals_detail_npackinglist_index_key",		lds.getitemnumber(1,"npl_index_key_subst"))
		dsCenMeals.setitem(j,"cen_packinglist_index_cpackinglist",				lds.getitemstring(1,"cen_packinglist_index_cpackinglist"))
		dsCenMeals.setitem(j,"cen_packinglists_npackinglist_detail_key",		lds.getitemnumber(1,"cen_packinglists_npackinglist_detail_key"))
		dsCenMeals.setitem(j,"cen_packinglists_ctext",								lds.getitemstring(1,"cen_packinglists_ctext"))
		dsCenMeals.setitem(j,"cen_meals_detail_cproduction_text",				lds.getitemstring(1,"cen_packinglists_ctext_short"))
		dsCenMeals.setitem(j,"cen_packinglists_npackinglist_key", 				lds.getitemnumber(1,"cen_packinglists_npackinglist_key"))
	 	dsCenMeals.setitem(j,"cen_meals_detail_ncalc_id",						lds.getitemnumber(1,"ncalc_id"))
		dsCenMeals.setitem(j,"cen_meals_detail_ncalc_detail_key",				lds.getitemnumber(1,"ncalc_detail_key"))
		dsCenMeals.setitem(j,"cen_meals_detail_npercentage",					lds.getitemnumber(1,"npercentage"))
		dsCenMeals.setitem(j,"cen_meals_detail_nvalue",							lds.getitemnumber(1,"nvalue"))
		dsCenMeals.setitem(j,"cen_meals_detail_nmax_value",					lds.getitemnumber(1,"nmax_value"))
		dsCenMeals.setitem(j,"cen_meals_detail_nmin_value",					lds.getitemnumber(1,"nmin_value"))
		dsCenMeals.setitem(j,"cen_meals_detail_nspml_deduction",			lds.getitemnumber(1,"nspml_deduction"))
		dsCenMeals.setitem(j,"cen_meals_detail_cclasses",						lds.getitemstring(1,"cclasses"))
	end if
next

destroy lds

return 1
end function

public function integer uf_calc_multiple_m_cp ();//=================================================================================================
//
// uf_calc_multiple_m_cp
//
// Berechnet Vielfaches m-fach mit City Pair (CBASE-UK-CR-2016-003 New Calc mode Multiple CP)
//
// Alle n Passagiere Menge m beladen, iPercentage wird als n interpretiert!
//
// 01.04.2016 Neu als Lopie von #21 plus CIty Pair 
//=================================================================================================
long		lResult
long		lResult_ver; // 07.11.12, Gunnar Brosch: QuantityVersion
Long		ll_Value
long		ll_tlc_from
long		ll_tlc_to


// Check City Pair
select	ntlc_from, ntlc_to 
into		:ll_tlc_from, :ll_tlc_to 
from		cen_out
where		nresult_key = :this.lResultKey;
	
if sqlca.sqlcode <> 0 then
	// 12.05.2010 HR: Kein Citypair gefunden und auch keine $$HEX1$$fc00$$ENDHEX$$bergeben, dann Log-Eintrag und raus hier
	if il_tlc_from = -1 and il_tlc_from = -1 then
		uf_trace(20,"uf_calc_fixed_cp(): no record in cen_out for result_key " + string(this.lResultKey) + ")")
		return 1
	else
		// 12.05.2010 HR: $$HEX1$$dc00$$ENDHEX$$bergebene Citypairs verwenden
		ll_tlc_from = il_tlc_from
		ll_tlc_to = il_tlc_to
	end if
end if	

select	nfixed_qty
into		:ll_Value 
from		cen_meals_cp_percent 
where		nhandling_detail_key = :lHandlingDetailKey 
and		ntlc_from = :ll_tlc_from 
and		ntlc_to = :ll_tlc_to ;
	
if sqlca.sqlcode <> 0 then
	// Kein Eintrag f$$HEX1$$fc00$$ENDHEX$$r City Pair: nehme Meal Def
	//ll_Value = dcValue
	//dcQuantity =  dcvalue
else
	if isnull(ll_Value) then ll_Value=0
	dcValue = ll_Value
	//dcQuantity = ll_Value
end if

//
// dcValue: 		Feld Menge wird als Menge interpretiert
//	iPercentage:	Feld % wird als Passagierzahl interpretiert
//
if iPercentage = 0 then iPercentage = 1
lResult = truncate(lCalcBasis / iPercentage, 0)			// Vielfaches
lResult_ver = truncate(il_calcbasis_ver / iPercentage, 0); // 07.11.12, Gunnar Brosch: QuantityVersion


If Mod(lCalcBasis, iPercentage) > 0 then lResult++					// Falls Rest aus Division, dann bis zum n$$HEX1$$e400$$ENDHEX$$chsten Schritt
if mod(il_calcbasis_ver, iPercentage) > 0 then lResult_ver++	;	// 07.11.12, Gunnar Brosch: QuantityVersion															

dcQuantity = lResult * dcValue					// m mal Result
idc_quantity_ver = lResult_ver * dcValue; 	// 07.11.12, Gunnar Brosch: QuantityVersion

return 0


end function

public function integer uf_calc_bosta_plus_reserve ();
// --------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_calc_bosta_plus_reserve (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 12.07.2016
//
// Argument(e):
// none
//
// Beschreibung:		CBASE-DE-CR-2016-020 neue Berechnungsart (calc_id 107)
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	12.07.2016		Erstellung als Kopie von uf_calc_bosta_plus
// 1.1 			O.Hoefer	28.07.2016		ohne +0.5 f$$HEX1$$fc00$$ENDHEX$$r Rundung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

//=================================================================================================
// CBASE-DE-CR-2016-020 neue Berechnungsart
// Kopie von uf_calc_bosta_plus
//=================================================================================================
//
// uf_calc_bosta_plus_reserve
//
// Auftragsmenge ist Bosta + Prozentzahl oder absolutem Wert (je nach Calc-ID)
//
// 20.07.2005: Es darf nur eine Berechnung stattfinden, wenn in der
//					Ausz$$HEX1$$e400$$ENDHEX$$hlung > 0 ist
// 06.11.12, Gunnar Brosch: QuantityVersion
//=================================================================================================
long lResult
long lResult_ver; //06.11.12, Gunnar Brosch: QuantityVersion
Long	ll_Count
Integer	li_Num_SPML
// ------------------------------------
// Ermittle abzuziehende SPML
// ------------------------------------
li_Num_SPML = 0 

// ------------------------------------
// Alternative SPML Z$$HEX1$$e400$$ENDHEX$$hlung via PAX-DataStore
// ------------------------------------
// 06.03.2013 HR: Wir suchen mit NRESULT_KEY, damit wir immer den richtigen Flug anpacken
//	ll_Count = dsCenOutPax.Find("cclass = '" + sclass + "'", 1, dsCenOutPax.RowCount())
ll_Count = dsCenOutPax.Find("nresult_key = "+string(lResultKey)+" and cclass = '" + sclass + "'", 1, dsCenOutPax.RowCount())
if ll_Count > 0 then
	li_Num_SPML = 	li_Num_SPML + dsCenOutPax.GetItemNumber(ll_Count, "npax_spml")
end if

// AW: Menge=wenn (Pax-SPML + PAX*10%Aufschlag<= version - spml; Pax-SPML + PAX*10%Aufschlag; version-spml)

if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if lCalcBasis > 0 then
		lResult = lCalcBasis + Int(lCalcBasis * ipercentage / 100) 
	else
		lResult = 0
	end if
else
	//lResult = lCalcBasis + Int(lCalcBasis * ipercentage / 100) 	
	//Menge=wenn (Pax-SPML + PAX*10%Aufschlag<= version - spml; Pax-SPML + PAX*10%Aufschlag; version-spml)

	//lResult = (lCalcBasis) + round(((lCalcBasis + li_Num_SPML) * ipercentage / 100) + 0.5 , 0) 	
	lResult = (lCalcBasis) + round(((lCalcBasis + li_Num_SPML) * ipercentage / 100), 0) 	
	
end if

// ---------------------------------------
// Abschneiden bei Version
// ---------------------------------------
If lResult > (il_calcbasis_ver  - li_Num_SPML) then
	lResult = il_calcbasis_ver - li_Num_SPML
End If
dcQuantity = lResult

//06.11.12, Gunnar Brosch: QuantityVersion ************ >>>>>>>>>>>>>>>
if iAsk4Passenger = 1 then
	//
	// Verhalten bei Ausz$$HEX1$$e400$$ENDHEX$$hlungsdialog:
	// Nur wenn in User ein Wert > 0 eingegeben hat soll Bosta+ greifen
	//
	if il_calcbasis_ver > 0 then
		lResult_ver = il_calcbasis_ver + Int(il_calcbasis_ver * ipercentage / 100) 
	else
		lResult_ver = 0
	end if
else
	lResult_ver = il_calcbasis_ver + Int(il_calcbasis_ver * ipercentage / 100) 
end if

// ---------------------------------------
// Abschneiden bei Version
// ---------------------------------------
If lResult_ver > il_calcbasis_ver then
	lResult_ver = il_calcbasis_ver // lResult_ver
End If

idc_quantity_ver= lResult_ver;
//06.11.12, Gunnar Brosch: QuantityVersion ************ <<<<<<<<<<<<<<<<<

return 0

end function

public function integer uf_new_flight ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_meal_calculation
// Methode: uf_new_flight (Function)
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
//  09.08.2016	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

sMealControlCodeOld 	= " "
lClassNumberOld 			= 0
lHandlingKeyOld 			= 0

return 1

end function

on uo_meal_calculation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_meal_calculation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
// Tracing
sTraceFile	= ProfileString("CBASE_SERVICES.INI", "CBASE_Service", "MealCalcLog", "d:\temp\")	
sTraceFile	+= "Debug_Meal_Calc_" + string(today(),"yyyy-mm-dd") + ".txt"	
iDebugLevel = integer(ProfileString("CBASE_SERVICES.INI", "CBASE_Service", "Debuglevel", "0"))

// Passagierzahlen f$$HEX1$$fc00$$ENDHEX$$r Flug
dsCenOutPax									= Create DataStore
dsCenOutPax.DataObject						= "dw_Cen_Out_Pax"
dsCenOutPax.SetTransObject(SQLCA)

// Ergebnisdatastore zum Speichern in cen_out_meals
dsCenOutMeals									= Create uo_generate_datastore
dsCenOutMeals.DataObject 					= "dw_cen_out_meals"
dsCenOutMeals.SetTransObject(SQLCA)

// Mahlzeiten vor einer $$HEX1$$c400$$ENDHEX$$nderung
dsCenOutMealsOld									= Create uo_generate_datastore
dsCenOutMealsOld.DataObject 					= "dw_cen_out_meals"
dsCenOutMealsOld.SetTransObject(SQLCA)

// Meal-Cover-Objekt
dsHandlingMealCover								= Create uo_generate_datastore
dsHandlingMealCover.DataObject 				= "dw_generate_handling_meals"
dsHandlingMealCover.SetTransObject(SQLCA)

// Mahlzeitendefinition
dsCenMeals								= Create DataStore
dsCenMeals.DataObject				= "dw_meals_and_meals_detail"
dsCenMeals.SetTransObject(SQLCA)

//Unterbeladung
dsHandlingDiff							= Create Datastore
dsHandlingDiff.DataObject			= "dw_exp_cen_handling_diff"
dsHandlingDiff.SetTransObject(SQLCA)

// MCO Simulation
dsCenMCO									= Create DataStore
dsCenMCO.DataObject					= "dw_mco_simulation_data"
dsCenMCO.SetTransObject(SQLCA)

// aktuelle SPML-Beladung aus cen_out_spml
dsSPML									= Create uo_generate_datastore
dsSPML.DataObject 					= "dw_change_cen_out_spml"
dsSPML.SetTransObject(SQLCA)

// aktuelle SPML-Beladung aus cen_out_spml
dsSPMLAssignment									= Create DataStore
dsSPMLAssignment.DataObject 					= "dw_exp_spml_assignment"
dsSPMLAssignment.SetTransObject(SQLCA)

// SPML-Definition aus den Stammdaten
dsSPMLDefinition									= Create DataStore
dsSPMLDefinition.DataObject 					= "dw_exp_spml_definition"
dsSPMLDefinition.SetTransObject(SQLCA)

// Datastore zum Speichern der SPML-Details
dsSPMLDetail									= Create uo_generate_datastore
dsSPMLDetail.DataObject 					= "dw_cen_out_spml_detail"
dsSPMLDetail.SetTransObject(SQLCA)

// KVA f$$HEX1$$fc00$$ENDHEX$$r entsprechende Airline
dsCenAirlineAccounts									= Create uo_generate_datastore
dsCenAirlineAccounts.DataObject 					= "dw_exp_airline_accounts"
dsCenAirlineAccounts.SetTransObject(SQLCA)

// Performance: St$$HEX1$$fc00$$ENDHEX$$cklistentypen einmalig ziehen
dsPLTypes									= Create uo_generate_datastore
dsPLTypes.DataObject 					= "dw_exp_pltype_keys"
dsPLTypes.SetTransObject(SQLCA)

// Performance: Caching von Umlaufinformationen
dsRotationCache							= Create uo_generate_datastore
dsRotationCache.DataObject 			= "dw_exp_rotation_cache"

// Ratiolists
dsRatiolistDefinition					= Create uo_generate_datastore
dsRatiolistDefinition.DataObject 	= "dw_exp_ratiolist_definition"
dsRatiolistDefinition.SetTransObject(SQLCA)

dsRatiolistTyp1							= Create uo_generate_datastore
dsRatiolistTyp1.DataObject 			= "dw_exp_ratiolist_typ1"
dsRatiolistTyp1.SetTransObject(SQLCA)

dsFindRatiolist							= Create datastore
dsFindRatiolist.DataObject 			= "dw_find_ratiolist"
dsFindRatiolist.SetTransObject(SQLCA)

// Ersetzung von Berechnungsarten
dsRatioReplacement							= Create datastore
dsRatioReplacement.DataObject 			= "dw_replace_calculation"
dsRatioReplacement.SetTransObject(SQLCA)

// Umlaufgenerierung
uoRotation						= create uo_get_rotation

// 09.06.2010 HR:
dsFlightData = Create datastore
dsFlightData.DataObject 					= "dw_change_bob_pax_flight"
dsFlightData.SetTransObject(SQLCA)

// 16.04.2012 mnu: kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
this.idsCustomerId = create datastore
this.idsCustomerId.DataObject = "dw_check_customer_id"
this.idsCustomerId.SetTransObject(SQLCA)

// 24.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
this.idsLocalSubst = create datastore
this.idsLocalSubst.DataObject = "dw_local_substitutions"
this.idsLocalSubst.SetTransObject(SQLCA)

// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling
this.idsLocalEuSubst = create datastore
this.idsLocalEuSubst.DataObject = "dw_local_eu_substitutions"
this.idsLocalEuSubst.SetTransObject(SQLCA)

// 15.07.2015 HR: CBASE-DE-CR-2015-049
this.ids_ask4passenger= create datastore
this.ids_ask4passenger.DataObject = "dw_ask4passanger_mass"
this.ids_ask4passenger.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
this.ids_cen_meals_det_deduction= create datastore
this.ids_cen_meals_det_deduction.DataObject = "dw_exp_cen_meals_det_deduction"


end event

event destructor;
destroy		dsCenOutPax
destroy		dsCenOutMeals
destroy		dsCenMco
destroy		dsCenOutMealsOld
destroy		dsHandlingMealCover
destroy		dsCenMeals
destroy		dsSPML
destroy		dsSPMLAssignment
destroy		dsSPMLDefinition
destroy		dsSPMLDetail
destroy		dsCenAirlineAccounts
destroy		dsPLTypes
destroy		dsRotationCache
destroy		dsRatiolistDefinition
destroy		dsRatiolistTyp1
destroy		dsFindRatiolist
destroy		uoRotation
destroy		dsRatioReplacement
destroy 		dsFlightData													// 09.06.2010 HR: SKY_MEAL_ORDERS
if isValid(this.idsCustomerId) then destroy this.idsCustomerId 	// 16.04.2012 mnu: kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
destroy 		this.idsLocalSubst											// 24.09.2012 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Lokalen Ersetzungen (CBASE-NAM-CR-11009)
destroy 		this.idsLocalEuSubst										// 19.09.2014 HR: Lokale Ersetzung f$$HEX1$$fc00$$ENDHEX$$r EU-Labeling
destroy 		this.ids_ask4passenger									// 15.07.2015 HR: CBASE-DE-CR-2015-049
destroy 		this.ids_cen_meals_det_deduction						// 07.08.2015 HR: CBASE-DE-CR-2015-054
end event

