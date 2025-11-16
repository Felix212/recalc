HA$PBExportHeader$uo_pl_explosion.sru
$PBExportComments$Matdispo: Userobject zur Durchf$$HEX1$$fc00$$ENDHEX$$hrung der St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r Lesematerial und f$$HEX1$$fc00$$ENDHEX$$r die normale Beladung, d.h. f$$HEX1$$fc00$$ENDHEX$$r alle St$$HEX1$$fc00$$ENDHEX$$cklisten aus den Sammelst$$HEX1$$fc00$$ENDHEX$$cklisten und der Mahlzeiten-, Extra- und SPML-Beladung
forward
global type uo_pl_explosion from nonvisualobject
end type
end forward

global type uo_pl_explosion from nonvisualobject
end type
global uo_pl_explosion uo_pl_explosion

type variables
// =============================================================================================
//
// uo_pl_explosion
//	
// Neues UserObject f$$HEX1$$fc00$$ENDHEX$$r die komplette Matdispo.
//
// =============================================================================================
///-------- SUCHE ctext_short
public:

// =============================================================================================
//
// Wichtigste Properties
//
// =============================================================================================
date				dGenerationDate

long				lPLType					// St$$HEX1$$fc00$$ENDHEX$$cklistentyp: 1 = St$$HEX1$$fc00$$ENDHEX$$ckliste, 2 = Zeitung

string				sClient					// Mandant
string				sPlant						// Betrieb
string				sAirline					// Airline
long				lAirlineKey				// Airline (aus Airlinecode)

integer			iJobType	= 40			// Art des Jobs
												// 40		= Matdispo Neuanlage (default)
												// 110	= Matdispo Artikelaufl$$HEX1$$f600$$ENDHEX$$sung

long				lJobKey

long				lNumberFlights			// f$$HEX1$$fc00$$ENDHEX$$r's Protokoll: Wieviele Fl$$HEX1$$fc00$$ENDHEX$$ge wurden bearbeitet

integer			iCNXFlag	= 0				// f$$HEX1$$fc00$$ENDHEX$$r Einzelflug-Matdispo, wenn Flug CNX gesetzt wurde

integer			iGebindeFlag = 1		// 1 = Multipl. Menge mal Gebinde (default)
												// 0 = Gebinde nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
												
integer			iCalculatorMode		// 0 = 10er Liste mit $$HEX1$$fc00$$ENDHEX$$bergeordneter PL
												// 1 = 10er Liste mit Master PL

integer			iGetNewDetailKey = 0 // 25.05.2010 HR:
												// 0 = keinen neuen Detailkey f$$HEX1$$fc00$$ENDHEX$$r PLholen
												// 1= neuen Key f$$HEX1$$fc00$$ENDHEX$$r G$$HEX1$$fc00$$ENDHEX$$ltigkeit holen


// =============================================================================================
//
// Debugging und Errors
//
// =============================================================================================

string								sErrortext				// Fehlertext

string								sMatDispoTraceFile	= "c:\matdispo.txt"
integer							iDebugLevel				= 1

datastore						dsGenerateProtocol

//
// Tracing durch den Dienst, Einf$$HEX1$$fc00$$ENDHEX$$hrung neuer Trace-Parameter
//
integer							iTraceFormat			= 0	// 0 = std., 1 = csv
integer							iInfoType					= 1
long								lJobNumber				= 0

// =============================================================================================
//
// Datastores
//
// =============================================================================================
datastore						dsLocalWorkstations		// lokale Bereiche f$$HEX1$$fc00$$ENDHEX$$r cen_out_master

datastore						dsFlightsOnly				// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r eine Unit

datastore						dsFlightsOfTheDay			// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r eine Unit inkl. 
																	// Pax-Zahlen

datastore						dsExplosionHandling		// Alle LL und SLL zu einem Flug

datastore						dsPackingList				// 

datastore						dsNewspaperLoading		// Alle Lesematerial LL zu einem Flug

datastore						dsNewspaperExtra			// Extrabeladung Lesematerial zu einem Flug

datastore						dsNewsLoadingList			// Inhalt einer Lesematerial LL

datastore						dsCenOutNFB					// NonFlightBusiness Auftr$$HEX1$$e400$$ENDHEX$$ge in cen_out_nfb

datastore						dsLoadingNFB				// Beladung NonFlightBusiness

datastore						dsSimulation				// f$$HEX1$$fc00$$ENDHEX$$r Simulation

datastore						dsCenOutSMPL				// SPML-Aufl$$HEX1$$f600$$ENDHEX$$sung

//
// Spezial-Datastores
//
uo_generate_datastore		dsCenOutMaster		
uo_generate_datastore		dsCenOutMasterLevel1
uo_generate_datastore		dsCenOutMasterLevelN
uo_generate_datastore		dsCenOutDetail		// Artikel einer Packing List
uo_generate_datastore		dsCenOutMasterNFB	// f$$HEX1$$fc00$$ENDHEX$$r NonFlightBusiness-Zugriff auf cen_out_master 
uo_generate_datastore		dsCenOutMeals		// f$$HEX1$$fc00$$ENDHEX$$r die Matdispo der Mahlzeiten

// =============================================================================================
//
// User Objects
//
// =============================================================================================
uo_meal_calculation			uo_calc

// =============================================================================================
//
// Wichtige Instanz-Variablen
//
// =============================================================================================
integer							iDay
integer							iStatus

time								tdepartureTime

long								lArea_Key
long								lWorkstation_Key
long								lTransaction
long								lFlightNumber

decimal							dcReserve

string								sAirlineCode

// =============================================================================================
//
// Host-Variablen
//
// =============================================================================================
long				lResultKey
long				lPLIndexKey
long				lPLDetailKey
long				lAction
long				lHandlingID			// Handlingobjekt, aus dem die PL stammt
string				sPackinglist
string				sText
string				sUnit
string				sLoadingList

decimal			dcQuantity
decimal			dcOldQuantity
decimal			dcWeight

long				lLLIndexKey
long				lLabelTypeKey
long				lClassNumber
long				lSort
long				lCalc_ID
long				lCalc_detail_key
long				lQuantity
long				lPriority
long				lHandlingKey
long				lExplosion_level
long				lRatiolist_key
long				lPax
long				lItemIndexKey
long				lItemDetailKey
long				lGebinde

string				sGalley
string				sStowage
string				sPlace
string				sClass
string				sItem
string				sItemText
string				sItemUnit
integer			iBelly
integer			iPackingListLevel

long				lmaterial_group_key		// Key zur (SAP) Warengruppe
long				lreckoning					// Key Steuerzeichen Matdispo

long				lPackinglistKind				// Key f$$HEX1$$fc00$$ENDHEX$$r ESL, MS0, ...
long				lPackinglistType			// Key f$$HEX1$$fc00$$ENDHEX$$r APP, DES, SAL, ...

LONGLONG		lMasterDetailKey			// 23.04.2009 HR: Detailkey der urspr$$HEX1$$fc00$$ENDHEX$$nglichen St$$HEX1$$fc00$$ENDHEX$$ckliste (18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast)
LONGLONG		lAncesterDetailKey			// 23.04.2009 HR: Detailkey der $$HEX1$$fc00$$ENDHEX$$bergeordneten St$$HEX1$$fc00$$ENDHEX$$ckliste (18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast)

long				lMasterIndexKey			// PL-Key der urspr. St$$HEX1$$fc00$$ENDHEX$$ckliste
													// bei rekursiver Aufl$$HEX1$$f600$$ENDHEX$$sung
long				lMasterAreaKey				// Workstation-Key, Area-Key
long				lMasterWorkstationKey	// bei rekursiver Aufl$$HEX1$$f600$$ENDHEX$$sung	
decimal			dcMasterReserve



long				lSubAreaKey					// Workstation-Key, Area-Key
long				lSubWorkstationKey		// bei rekursiver Aufl$$HEX1$$f600$$ENDHEX$$sung	

integer			iReservePercent			// ist Reserve prozentual oder absolut

boolean			bCalculator	= false		// Calculator-Modus: Keine Sequence verwenden

// 04.02.2009 HR:
string 			sfromloadinglist //Ursprungsloadinglist

// 31.03.2009 HR:
long 				lMealExplosionWithBillingonly
string 			is_Mandant

// 23.04.2009 TBR:
long 				ilGroupPlByClass
String				is_cclass = ""
Integer			ii_nclass_number = 0

// 13.07.2009 OH - Customer Number => Artikel (cen_out_detail)
string				sCustomer_PL
string				sCustomer_PL_Text

String				sAccount
Long				lAccount_Key

integer 			iConvertGtoKG = -1        			// 11.09.2009 HR: Schalter, um die Automatische Umrechnung G -> KG auszuschalten
Long				il_FillEmptyCustomerPL 			// 13.01.10 Leere Customer PL aus cPAckinglist bef$$HEX1$$fc00$$ENDHEX$$llen
integer 			iDoNotSet0ForCxFlights = 0 		// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX

// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Forecast-Projekt
// --------------------------------------------------------------------------------------------------------------------
integer 			iFillForcastFields = 0
Long 				il_routing_id
Long				il_routingplan_index_key
long 				il_FC_Parm1, il_FC_Parm2, il_FC_Parm3, il_FC_Parm_min
datastore 		dsForecast
datastore 		dsForecast_AS

// --------------------------------------------------------------------------------------------------------------------
// 24.03.2011 HR: neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
// --------------------------------------------------------------------------------------------------------------------
string                 	sSalesRel
string                 	sDefStorageLocation
string                 	sGoodsRecipient
string 				sAccountFight 

string 				sPostTypeShort 			= " " 		// 30.08.2011 HR:
boolean				ibPostingBrowser 			= false	// 13.09.2011 HR: Aufruf von ein einem Ereignis des Postingbrowsers
integer 				iReckoning[]								// 13.09.2011 HR: F$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung

// --------------------------------------------------------------------------------------------------------------------
// 31.01.2012 HS: new parameter for PLSQL explosion
// --------------------------------------------------------------------------------------------------------------------
integer 				ii_explode_plsql

// --------------------------------------------------------------------------------------------------------------------
// 16.04.2012 mnu: kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
// --------------------------------------------------------------------------------------------------------------------
datastore			idsCustomerId

// --------------------------------------------------------------------------------------------------------------------
// 06.06.2012 HR: Neue Gruppierung nach SSL/ZBL/AcountCode2
// --------------------------------------------------------------------------------------------------------------------
integer				ii_GroupPlBySslZblAc2 	= 0		
string 				sAdditionalAccount						

long 					il_customer_key 				// 01.10.2012 HR: Zur Bestimmung des Warenempf$$HEX1$$e400$$ENDHEX$$ngers
decimal				dcPortion							// 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste

decimal				dcquantity_version				// 30.01.2013 HR: SL-Menge f$$HEX1$$fc00$$ENDHEX$$r die Versionsmenge
decimal				dcMasterReserve_version	// 30.01.2013 HR: Reserve f$$HEX1$$fc00$$ENDHEX$$r die Versionsmenge

long					il_pltimeframe_index			// 19.03.2013 HR: Schl$$HEX1$$fc00$$ENDHEX$$ssel des Produktionszeitfensters
date					id_prod_date					// 21.03.2013 HR: Produktionstag
datastore			ids_prod_time_frame			// 19.03.2013 HR: Datastore mit den Produktionszeitfenstern f$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$cklisten

string					isPackinglistXsl					// 24.07.2013 HR: CBASE-DE-CR-2013-005

string					isPackinglistShortText			// 23.05.2014 HR: CBASE-HKG-CR-2014-005

string 				is_logFlightZeile  = ""			// 12.09.2014 HR: Flugnummer f$$HEX1$$fc00$$ENDHEX$$r die Ausgabe

integer				ii_NPARTIALSUBSTITUTION	// 10.10.2014 HR: LokaleErsetzung EU-Labeling

// --------------------------------------------------------------------------------------------------------------------
// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
string 				is_itm_csales_rel
string 				is_itm_cgoods_recipient
end variables

forward prototypes
public function integer of_check_packinglist_explosion ()
public function integer of_delete_old_loading ()
public function integer of_generate_extra_newspaper ()
public function integer of_insert_cen_out_detail ()
public function boolean of_start_for_airline (string arg_client, string arg_unit, date arg_generationdate, long arg_airline)
public function boolean of_start_for_nfb (string arg_client, string arg_unit, date arg_generationdate)
public function boolean of_start_packinglist_explosion (string arg_client, date arg_generationdate)
public subroutine of_trace (integer arg_infotype, integer arg_level, string arg_trace_text)
public function integer of_write_loading ()
public function integer of_write_loading_detail ()
public function boolean of_start_for_flight (long arg_resultkey)
public function integer of_generate_loading_newspaper (long arg_row)
public function integer of_generate_loading_nfb ()
public function integer of_generate_pl_explosion (integer infb_only)
public function integer of_generate_pl_explosion_for_one_flight ()
public function integer of_generate_loading (long arg_row)
public function integer of_generate_spml_explosion ()
public function integer of_generate_meal_explosion ()
public function long of_get_detail_key (long arg_index_key)
public function boolean of_check_global_explosion ()
public function integer of_generate_sub_pl_explosion (long arg_row)
public function boolean of_start_for_packinglists (string arg_client, string arg_unit, date arg_generationdate, long arg_airline)
public function long of_get_loadinglist_index_key (string arg_loadinglist)
public function boolean of_start_calculator (string arg_client, string arg_unit, date arg_departure, long arg_airlinekey)
public function integer of_generate_loading_for_calculator (long arg_row)
public function long of_get_airline_for_packinglist (long arg_index_key)
public function integer of_get_master_packinglist (ref string arg_pl, ref string arg_pl_text, long arg_master_key)
public function string of_cen_profilestring (string ssection, string skey, string sdefault, string smandant)
protected function integer of_insert_cen_out_master (integer arg_level)
public function boolean of_get_class_number (string ps_cclass)
public function string of_get_airline_name (long arg_nairline_key)
public function long of_min_forcast (long arg_value1, long arg_value2)
public function string of_get_goodsrecipient (long arg_nairline_key, string arg_caccount)
public function boolean of_start_for_postingbrowser (long arg_resultkey)
public function integer of_generate_psr_contents (long arg_row)
public function integer of_generate_sub_pl_explosion_plsql (long arg_row)
protected function long of_get_customer_id (long al_indexkey, long al_detailkey, long al_airlinekey, ref string ref_as_customerid, ref string ref_as_customertext, boolean ab_all)
public function boolean of_start_for_flight_areachange (long arg_resultkey, long arg_packinglist_index_key)
public function integer of_resolve_packinglist (long arg_index_key, decimal arg_master_quantity, integer arg_level, integer arg_reckoning, decimal arg_master_reserve, integer arg_master_percentage, long arg_master_area, long arg_master_ws, longlong arg_master_detail_key, longlong arg_ancester_detail_key, string arg_cclass, integer arg_nclass_number, string arg_csalesrel, string arg_cdefstoragelocation, string arg_cgoodsrecipient, string arg_caccount, long arg_naccount, decimal arg_master_quantity_vers, decimal arg_master_reserve_vers)
public function string of_ctext_short (string arg_ctext, string arg_ctext_short)
public function integer of_get_account4goodsrecipient (long arg_customer_key, string arg_we, ref string arg_caccount, ref long arg_naccount_key)
end prototypes

public function integer of_check_packinglist_explosion ();// ==========================================================================
//
// of_check_packinglist_explosion
//
// Schaut nach, ob Packinglist schon aufgel$$HEX1$$f600$$ENDHEX$$st vorliegt
// Falls ja, dann wird gel$$HEX1$$f600$$ENDHEX$$scht
// Achtung PL-Type f$$HEX1$$fc00$$ENDHEX$$r Zeitungen wird Ber$$HEX1$$fc00$$ENDHEX$$cksichtigt!
//
// ==========================================================================
long		lcnt
datetime	dtRunDateFrom, dtRunDateTo

//
// Vorher: Konvertierung; nur so klappt's mit dem Datum
//
//dtRunDateFrom	= datetime(dGenerationDate,time("00:00:00"))
//dtRunDateTo		= datetime(dGenerationDate,time("23:59:59"))
//
// 16.02.2006: date hinzuf$$HEX1$$fc00$$ENDHEX$$gen: datetime(today(),time("00:00:00"))
//
dtRunDateFrom		= datetime(date(today()),time("00:00:00"))
dtRunDateTo		= datetime(date(today()),time("23:59:59"))

//
// Check normale St$$HEX1$$fc00$$ENDHEX$$cklisten
//
if lPLType = 1 then
	// --------------------------------------------------------------------------------------------------------------------
	// 21.11.2014 HR: Brauchen wir nur noch bei der 'Explode with service' Funktion
	// --------------------------------------------------------------------------------------------------------------------
	if ii_explode_plsql = 0 then
		
		select count(*)
		  into :lcnt
		  from cen_out_detail
		 where npl_index_key 	= :lPlindexkey
			and npl_detail_key	= :lPLDetailKey
			and npl_type			= :lPLType
			and nfreq_key			= 0
			and dtimestamp			>= :dtRunDateFrom 
			and dtimestamp			<=	:dtRunDateTo;
			
			// falls heute noch keine Matdispo, dann auf jeden Fall
			// evtl. vorhandene alte Matdispos l$$HEX1$$f600$$ENDHEX$$schen
			if lcnt = 0 then
				delete from cen_out_detail
				 where npl_index_key 	= :lPlindexkey
					and npl_detail_key	= :lPLDetailKey
					and npl_type			= :lPLType
					and nfreq_key			= 0;
				
				if sqlca.sqlcode <> 0 then
					return -1
				end if
	
				// --------------------------------------------------------------------------------------------------------------------
				// 13.09.2011 HR: Da es jetzt sein kann, dass es eine St$$HEX1$$fc00$$ENDHEX$$ckliste mehrmals 
				//                           existiert, schauen wir hier nochmal, ob wir ihn f$$HEX1$$fc00$$ENDHEX$$r diesen 
				//                           Flug schon habenschon angelegt haben
				// --------------------------------------------------------------------------------------------------------------------
				if dsCenOutDetail.find ("npl_index_key = "+string(lPLIndexKey)+" and npl_detail_key ="+string(lPLDetailKey),1,dsCenOutDetail.rowcount()) >0 then
					return 1 
				end if
				
				// Returnwert ist in diesem Fall 0
				// => es wird auf jeden Fall eine St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung ausgel$$HEX1$$f600$$ENDHEX$$st
				
				// 16.02.2006: Auftrag auf jeden Fall erteilen!
				return 0
			end if
		else
			return 1
		end if
			
// Check Zeitungsbeladung
elseif lPLType = 2 then
	select count(*)
	  into :lcnt
	  from cen_out_detail
	 where npl_index_key 	= :lPlindexkey
		and npl_detail_key	= :lPLDetailKey
		and npl_type			= :lpltype
		and nfreq_key			= :iDay
		and dtimestamp			>= :dtRunDateFrom 
		and dtimestamp			<=	:dtRunDateTo;
		
		//
		// falls heute noch keine Matdispo, dann auf jeden Fall
		// evtl. vorhandene alte Matdispos l$$HEX1$$f600$$ENDHEX$$schen
		//
		if lcnt = 0 then
			delete from cen_out_detail
			 where npl_index_key 	= :lPlindexkey
				and npl_detail_key	= :lPLDetailKey
				and npl_type			= :lPLType
				and nfreq_key			= :iDay;
			
			if sqlca.sqlcode <> 0 then
				return -1
			end if
		end if
		
end if

return lcnt

end function

public function integer of_delete_old_loading ();// =============================================================================
//
// of_delete_old_loading
//
// L$$HEX1$$f600$$ENDHEX$$scht St$$HEX1$$fc00$$ENDHEX$$cklisten f$$HEX1$$fc00$$ENDHEX$$r einen Flug aus cen_out_master.
// Wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r die Einzelflug-Matdispo, da dort nicht der ganze Flug
// neu generiert wurde, sondern sich lediglich die Beladung $$HEX1$$e400$$ENDHEX$$ndert.
//
// =============================================================================
delete from cen_out_master
 where nresult_key		= :lResultKey;

if sqlca.sqlcode <> 0 then
	return -1
end if


return 0

end function

public function integer of_generate_extra_newspaper ();// ==========================================================================
//
// of_generate_extra_newspaper
//
// Nur f$$HEX1$$fc00$$ENDHEX$$r Zeitungsbeladung!
//
// Zeitungsbeladung Extrabeladung aus cen_out_news_extra
//
// nhandling_id	=	7	Extrabeladung
//							8	Umladung
//							9	Gatebeladung
//
// (nur Flugabh$$HEX1$$e400$$ENDHEX$$ngige Beladung, keine Lounge..)
//
// ==========================================================================
//
// Neu f$$HEX1$$fc00$$ENDHEX$$r die Eintr$$HEX1$$e400$$ENDHEX$$ge in dieser Tabelle (cen_out_news_extra):
// Alle darin vorkommenden Packinglists geh$$HEX1$$f600$$ENDHEX$$ren nach cen_out_master
//
// Die Aufl$$HEX1$$f600$$ENDHEX$$sung der Packinglists erfolgt bei der Aufl$$HEX1$$f600$$ENDHEX$$sung von cen_out_master
// und wurde hier entfernt.
//
// 04.02.03:	Umladung bekommt folgende nAction-Values gesetzt:
//					2	=	Holst Du
//					3	=	Bringst Du (Umladung)
//					w$$HEX1$$e400$$ENDHEX$$hrend der Rest mit nAction 1 und 2 arbeitet (1 = Bringst Du)
//
// 08.05.03:	cen_out_master bekommt den nhandling_id gesetzt
//					Dieser mu$$HEX2$$df002000$$ENDHEX$$bei der Kumulierung ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden!
//					Fehlerbehebung: Der Betrieb wurde nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigt!
//
// 17.06.03:	nFreq_key wird ber$$HEX1$$fc00$$ENDHEX$$cksichtigt
//
// ==========================================================================
long 		i, j
long		lRow
long		lFind, lFind2
long		lcnt
string		sFind
datetime	dtNow
string		sQuantity

of_trace(1,1,"[of_generate_extra_newspaper] Start newspaper extra handling.")

//
// Hole die Extra-Beladung des Tages f$$HEX1$$fc00$$ENDHEX$$r einen Flug...
//
// Information $$HEX1$$fc00$$ENDHEX$$ber die alle in Handlingobjekten
// direkt angewiesenen Packinglists sind hier gespeichert.
//
dsNewspaperExtra.Retrieve(lResultKey)

//
// Was w$$HEX1$$e400$$ENDHEX$$re jetzt, wenn ein "Merge" mit einer Umladungstabelle erfolgen w$$HEX1$$fc00$$ENDHEX$$rde?
// nhandling_id = 8 w$$HEX1$$e400$$ENDHEX$$re zu ignorieren (dsExtraLoading4Day where-Bedingung $$HEX1$$e400$$ENDHEX$$ndern)
// Retrieve auf ein Datastore mit Umladungen (aus neuer Tabelle)
// Insert dieser Umladungen, damit eine Matdispo durchgef$$HEX1$$fc00$$ENDHEX$$hrt wird.
// Keine $$HEX1$$c400$$ENDHEX$$nderungen an der cen_out-Struktur.
//

//
// 2. Variante
// Es werden nur Beladungen aus Umladungen in der Beladedefinition angewiesen.
// Jede Umladung wei$$HEX1$$df00$$ENDHEX$$, von welchem Inbound-Flug sie stammt (Flugnummer und Offset).
//

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
isPackinglistXsl=""

for i = 1 to dsNewspaperExtra.RowCount()
	lPLIndexKey		= dsNewspaperExtra.GetItemNumber(i,"cen_out_news_extra_nnews_pl_index_key")
	lPLDetailKey	= dsNewspaperExtra.GetItemNumber(i,"cen_out_news_extra_nnews_pl_detail_key")
	sPackinglist 		= dsNewspaperExtra.GetItemString(i,"cen_out_news_extra_cnews_pl")
	sText				= dsNewspaperExtra.GetItemString(i,"cen_out_news_extra_cnewspaper")
	lQuantity			= dsNewspaperExtra.GetItemNumber(i,"cen_out_news_extra_nquantity")
	sUnit				= "PC"	// sUnit	fehlt noch in cen_out_news_extra	
	lAction			= dsNewspaperExtra.GetItemNumber(i,"cen_out_news_extra_naction")
	dtNow				= datetime(today(),now())
	lHandlingID		= dsNewspaperExtra.GetItemNumber(i,"cen_out_news_extra_nhandling_id")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 25.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	sSalesRel 				= " "
	sDefStorageLocation	= " "
	sGoodsRecipient		= " "

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Loadinglist und Abrechnungscode2 leeren
	// --------------------------------------------------------------------------------------------------------------------
	sAdditionalAccount		= " "
	sfromloadinglist		= " "
	isPackinglistShortText = sText // 23.05.2014 HR: CBASE-HKG-CR-2014-005
	//
	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung) und nhandling_id!
	//
	sFind = "naction = 1 and npl_type = 2 and npl_index_key = " + string(lPLIndexKey) + &
				" and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + &
				" and nhandling_id = " + string(lHandlingID) + &
				" and nfreq_key = " + string(iDay)
	lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())
	
	//
	// Erste Suche mit naction = 1 (bringst Du)
	//
	if lFind > 0 then
		//
		// Packinglist gibt's schon => kumulieren
		//
		dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
		dcOldQuantity	= dcOldQuantity + lQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcOldQuantity)

		// --------------------------------------------------------------------------------------------------------------------
		// 06.03.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + lQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
	else
		//
		// Zweite Suche mit naction = 3 (bringst Du Umladung) 
		// nhandling_id ist hier egal, da naction=3 nur bei handling_id = 8
		//
		sFind = "naction = 3 and npl_type = 2 and npl_index_key = " + string(lPLIndexKey) + &
					" and npl_detail_key = " + string(lPLDetailKey) + &
					" and nresult_key = " + string(lresultkey) + " and nfreq_key = " + string(iDay)
		lFind2 = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())
		if lFind2 > 0 then
			//
			// Packinglist gibt's schon => kumulieren
			//
			dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind2,"nquantity")
			dcOldQuantity	= dcOldQuantity + lQuantity
			dsCenOutMasterLevel1.SetItem(lFind2,"nquantity", dcOldQuantity)
		
			// --------------------------------------------------------------------------------------------------------------------
			// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
			dcquantity_version	= dcOldQuantity + lQuantity
			dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
		
		else
			//
			// Packinglist gibt's noch nicht => insert
			//
			dcQuantity = lQuantity
			
			dcquantity_version = dcQuantity // 30.01.2013 HR: Menge f$$HEX1$$fc00$$ENDHEX$$r Version ist identisch zur Menge
			
			// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
			ii_NPARTIALSUBSTITUTION = 0

			of_insert_cen_out_master(1)
		end if
	end if

next

return 0


end function

public function integer of_insert_cen_out_detail ();// ==========================================================================
//
// of_insert_cen_out_detail
//
// Einf$$HEX1$$fc00$$ENDHEX$$gen einer Zeile in den Ergebnis-Datastore der aufgel$$HEX1$$f600$$ENDHEX$$sten PL
// zur Speicherung in cen_out_detail
// zun$$HEX1$$e400$$ENDHEX$$chst zus$$HEX1$$e400$$ENDHEX$$tzlich zur Speicherung in cen_out_pl
//
// ==========================================================================
// 16.04.2012 mnu: bestimmen customer_pl erweitert
// 18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereiche angepast

// 21.11.2014 HR: Wenn es sich um eine St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung handelt und die PLSQL an ist, dann raus hier
if lPLType = 1 and ii_explode_plsql>0 then return 0

long 			lRow
LONGLONG	lSequence  //  18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast
datetime		dtnow
String			ls_PL, ls_Text

dtnow = datetime(today(),now())

if bCalculator	= false then
	lSequence = f_Sequence("seq_cen_out_detail", sqlca)
	// -----------------------------------------
	// liefert -1 bei Fehler
	// -----------------------------------------
	If lSequence = -1 Then
		return -1
	end if
end if

lRow = dsCenOutDetail.InsertRow(0)
dsCenOutDetail.SetItem(lRow,"ndetail_key",lSequence)
dsCenOutDetail.SetItem(lRow,"ntransaction",lTransaction)
dsCenOutDetail.SetItem(lRow,"npl_type",lPLType)
dsCenOutDetail.SetItem(lRow,"npl_index_key",lPLIndexKey)
dsCenOutDetail.SetItem(lRow,"npl_detail_key",lPLDetailKey)
dsCenOutDetail.SetItem(lRow,"nitem_index_key",lItemIndexKey)
dsCenOutDetail.SetItem(lRow,"nitem_detail_key",lItemDetailKey)
dsCenOutDetail.SetItem(lRow,"citem_pl",sItem)
// --------------------------------------------------------------------------------------------------------------------
// 27.09.2011 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen hier, ob sItemText NULL ist, damit wir kein Problem beim Speichern haben
// --------------------------------------------------------------------------------------------------------------------
if isnull(sItemText) or trim(sItemText)="" then
   dsCenOutDetail.SetItem(lRow,"citem_text",'n/a')
else
   dsCenOutDetail.SetItem(lRow,"citem_text",sItemText)
end if

dsCenOutDetail.SetItem(lRow,"citem_add_on_text","")
dsCenOutDetail.SetItem(lRow,"cunit",sItemUnit)

// --------------------------------------------------------------------------------------------------------------------
// 14.08.2012 HR: Alte Funktion wieder aktiviert / Neue auskommentiert
// --------------------------------------------------------------------------------------------------------------------
// Customer Number - 13.07.2009
dsCenOutDetail.SetItem(lRow,"ccustomer_pl",sCustomer_PL)
dsCenOutDetail.SetItem(lRow,"ccustomer_pl_text",sCustomer_PL_Text)
// ----------------------------------------------------------------------------------------
// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
// ----------------------------------------------------------------------------------------
If il_FillEmptyCustomerPL = 1 Then
	If IsNULL(sCustomer_PL) OR Trim(sCustomer_PL) = "" Then
		dsCenOutDetail.SetItem(lRow,"ccustomer_pl", sItem)
	End If
	If IsNULL(sCustomer_PL_Text) OR Trim(sCustomer_PL_Text) = "" Then
		dsCenOutDetail.SetItem(lRow,"ccustomer_pl_text", sItemText)
	End If
End If

if lPlType = 1 then
	// 17.05.2006
	if sItemUnit = "GR" then
		dcquantity = dcquantity / 1000
		dsCenOutDetail.SetItem(lRow,"cunit","KG")
	end if
	if sItemUnit = "ML" then
		dcquantity = dcquantity / 1000
		dsCenOutDetail.SetItem(lRow,"cunit","LT")
	end if
	
	dsCenOutDetail.SetItem(lRow,"nquantity",dcquantity)
else
	dsCenOutDetail.SetItem(lRow,"nquantity",lquantity)
end if
dsCenOutDetail.SetItem(lRow,"nsort",lPriority)
dsCenOutDetail.SetItem(lRow,"dtimestamp",dtnow)
dsCenOutDetail.SetItem(lRow,"nstatus",0)

// neu: Frequenz-Key
if lPLType = 1 then
	dsCenOutDetail.SetItem(lRow,"nfreq_key",0)
elseif lPLType = 2 then
	dsCenOutDetail.SetItem(lRow,"nfreq_key",iDay)
end if

// Warengruppe und Berechnung
dsCenOutDetail.SetItem(lRow,"nreckoning",lreckoning)
dsCenOutDetail.SetItem(lRow,"nmaterial_index_key",lmaterial_group_key)
dsCenOutDetail.SetItem(lRow,"citem_text_short",isPackinglistShortText) // 23.05.2014 HR: CBASE-HKG-CR-2014-005

// --------------------------------------------------------------------------------------------------------------------
// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
dsCenOutDetail.SetItem(lRow,"csales_rel", is_itm_csales_rel)
dsCenOutDetail.SetItem(lRow,"cgoods_recipient", is_itm_cgoods_recipient)

return 0

end function

public function boolean of_start_for_airline (string arg_client, string arg_unit, date arg_generationdate, long arg_airline);// =============================================================================
//
// of_start_for_airline
//
// f$$HEX1$$fc00$$ENDHEX$$hrt komplette Matdispo (Zeitungen und normales Zeug) f$$HEX1$$fc00$$ENDHEX$$r einen Mandant,
// Betrieb und Airline f$$HEX1$$fc00$$ENDHEX$$r einen ganzen Tag aus
//
// Einstiegsmethode von uo_generate.of_generate_explosion
//
// =============================================================================
//
// Datum			Aktion
// -----------------------------------------------------------------------------
// 10.11.2003	Komplette $$HEX1$$dc00$$ENDHEX$$berarbeitung gem$$HEX3$$e400df002000$$ENDHEX$$neuem Konzept
//					Neuausrichtung: Matdispo wird je Flug durchgef$$HEX1$$fc00$$ENDHEX$$hrt
//
//
// =============================================================================
long					i

ibPostingBrowser = false // 13.09.2011 HR:

//	
// Setzen der notwendigen Objekt-Properties
//
dgenerationdate 	= arg_generationdate
sClient				= arg_client			// Mandant
sPlant				= arg_unit				// Betrieb
lAirlineKey			= arg_airline			// Airline (aus Airlinecode)

//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7


//
// Check der notwendigen Objekt-Properties
//
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

sAirline = of_get_airline_name(lAirlineKey)

// 06.09.2010 HR: Projekt Forcast
iFillForcastFields 		= integer(of_cen_profilestring("OnlineExplosion","FillForcastFields","0",sClient))

// 06.06.2012 HR: Neuer Schalter f$$HEX1$$fc00$$ENDHEX$$r Gruppierung in CEN_OUT_MASTER
ii_GroupPlBySslZblAc2 = integer(of_cen_profilestring("OnlineExplosion","GroupPlBySslZblAc2","0",sClient))

// 09.03.2012 HR:
ii_explode_plsql = integer(of_cen_profilestring("OnlineExplosion","ExplodeWithPLSQL","0",sClient))
if ii_explode_plsql >= 1 then
	of_trace(1,1,"Online Item Explosion being performed by PLSQL" )
end if

// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Datastore mit den Forecast-Werten lesen
// --------------------------------------------------------------------------------------------------------------------
if iFillForcastFields=1 then
	dsForecast.retrieve(lAirlineKey, dgenerationdate)
	dsForecast_AS.retrieve(lAirlineKey)
else
	dsForecast.reset()
	dsForecast_AS.reset()
end if

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX
// --------------------------------------------------------------------------------------------------------------------
iDoNotSet0ForCxFlights = integer(of_cen_profilestring("OnlineExplosion","DoNotSet0ForCxFlights","0",sClient))


of_trace(1,1,"Start Packing List Explosion for Client = " + sClient + "; Unit = " + sPlant + &
					"; Airline = " + sAirline + "! [" + string(lAirlineKey) + "] Date " + String(arg_generationdate) + " [of_start_for_airline]")

// =============================================================================
//
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
//
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

// =============================================================================
//
// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge mit Passagierzahlen holen f$$HEX1$$fc00$$ENDHEX$$r Mengenermittlung Lesematerial
//
// =============================================================================
dsFlightsOfTheDay.Retrieve(sClient, sPlant, dgenerationdate, lAirlineKey)

// =============================================================================
//
// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r die Unit holen und durchlaufen...
//
// =============================================================================
dsFlightsOnly.Retrieve(sClient, sPlant, dgenerationdate, lAirlineKey)

of_trace(1,1,"dsLocalWorkstations contains: " + String(dsLocalWorkstations.RowCount()) + " rows")
of_trace(1,1,"  dsFlightsOfTheDay contains: " + String(dsFlightsOfTheDay.RowCount()) + " rows")
of_trace(1,1,"      dsFlightsOnly contains: " + String(dsFlightsOnly.RowCount()) + " rows")

for i = 1 to dsFlightsOnly.RowCount()
	lNumberFlights++
	lResultKey 		= dsFlightsOnly.GetItemNumber(i,"cen_out_nresult_key")
	sAirlineCode	= dsFlightsOnly.GetItemString(i,"cen_out_cairline")
	lFlightNumber 	= dsFlightsOnly.GetItemNumber(i,"cen_out_nflight_number")
	lTransaction	= dsFlightsOnly.GetItemNumber(i,"cen_out_ntransaction")
	tdepartureTime	= time(dsFlightsOnly.GetItemString(i,"cen_out_cdeparture_time"))

	// 12.09.2014 HR: ZeilenNr + Flugnummer f$$HEX1$$fc00$$ENDHEX$$r die Ausgaben
	is_logFlightZeile = "["+string(i) + " of " + string(dsFlightsOnly.RowCount()) + ": " + sAirlineCode + " " + string(lFlightNumber) + "] "

	il_customer_key= dsFlightsOnly.GetItemNumber(i,"ncustomer_key")// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key

	// 07.09.2010 HR: Projekt Forcast
	il_routing_id					= dsFlightsOnly.GetItemNumber(i,"cen_out_nrouting_id")
	il_routingplan_index_key	= dsFlightsOnly.GetItemNumber(i,"cen_out_nroutingplan_index")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 30.06.2010 HR: Nicht nur bei CX eines Fluges, sondern auch beim 
	//Nachberechnen von CX-Fl$$HEX1$$fc00$$ENDHEX$$gen muss dass Kennzeichen gesetzt sein
	// --------------------------------------------------------------------------------------------------------------------
	if dsFlightsOnly.GetItemNumber(i,"cen_out_nflight_status")=1 then
		iCNXFlag = 1
	else
		iCNXFlag = 0
	end if
	
	of_trace(1,10,"Packing List Explosion for flight (" + string(i) + " of " + string(dsFlightsOnly.RowCount()) + ") " + sAirlineCode + " " + &
						string(lFlightNumber) + ": ResultKey = " + string(lResultKey) + &
						" [of_start_for_airline]")
						
	// --------------------------------------------------------------------------------------------------------------------
	// 19.03.2013 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Produktionszeitfenster einer St$$HEX1$$fc00$$ENDHEX$$ckliste
	// am 29.07.2014 auch f$$HEX1$$fc00$$ENDHEX$$r ganze Airline $$HEX1$$fc00$$ENDHEX$$bernommen
	// --------------------------------------------------------------------------------------------------------------------
	if ii_explode_plsql = 0 then
		ids_prod_time_frame.retrieve(sPlant, dgenerationdate, string(tdepartureTime, "hh:mm"), "%"+string(iDay)+"%", lAirlineKey )
		of_trace(1,10, "[of_start_for_airline] Rows in ids_prod_time_frame: "+string(ids_prod_time_frame.rowcount()))
	end if

	// =============================================================================
	//
	// Matdispo Standardbeladung 
	//
	// =============================================================================
	lPltype				= 1
	
	//
	// Packinglists aus Loadinglists, Extrabeladung und Mahlzeiten holen
	//
	if of_generate_loading(i) <> 0 then
		sErrortext = "Error generating Loadinglist Explosion."
		//of_write_protocol(lJobKey,1,1,2,sAirline,string(dGenerationDate,s_app.sDateformat),sErrortext)
		of_trace(2,1,sErrortext + " [of_start_for_airline]" )
	end if
	
	//
	// Zu diesem Zeitpunkt befinden sich alle in der Beladung angewiesenen St$$HEX1$$fc00$$ENDHEX$$cklisten
	// in dsCenOutMasterLevel1. Jetzt kann mit der Aufl$$HEX1$$f600$$ENDHEX$$sung der Sub-Packing-Lists begonnen
	// werden
	//
	
	//
	// Aufl$$HEX1$$f600$$ENDHEX$$sung Sub-Packinglists
	//
	if ii_explode_plsql >= 1 then
		if of_generate_sub_pl_explosion_plsql(1) <> 0 then
			sErrortext = "Error generating Sub-Packing-List Explosion."
			of_trace(2,1,sErrortext + " [of_start_for_airline]" )
		end if
	else
		if of_generate_sub_pl_explosion(1) <> 0 then
			sErrortext = "Error generating Sub-Packing-List Explosion."
			of_trace(2,1,sErrortext + " [of_start_for_airline]" )
		end if
	end if

	// =============================================================================
	//
	// Matdispo Lesematerial
	//
	// =============================================================================
	lPltype				= 2
	//
	// Beladung zusammenstellen
	//
	if of_generate_loading_newspaper(i) <> 0 then
		sErrortext = "Error generating Loading List Explosion for Newspaper."
		of_trace(2,1,sErrortext + " [of_start_for_airline]" )
	end if
	
	//
	// Extrabeladung zusammenstellen
	//
	if of_generate_extra_newspaper() <> 0 then
		sErrortext = "Error generating Extra Loadingfor Newspaper."
		of_trace(2,1,sErrortext + " [of_start_for_airline]" )
	end if
	
	//f_print_datastore(dsCenOutMasterLevel1)
	//f_print_datastore(dsCenOutMasterLevelN)

	// =============================================================================
	//
	// Result-Datastore speichern und Reset nach jedem Flug.
	// Dann ist die Aufl$$HEX1$$f600$$ENDHEX$$sung der Packinglists beendet
	//
	// =============================================================================
	if of_write_loading() <> 0 then
		//
		// Fehler
		//
		of_trace(2,1,"Error of_write_loading(): " + sairlineCode + " " + string(lFlightNumber) + " " + &
					  " (key " + string(lResultKey) + ") [of_start_for_airline]" )
		rollback;
		return false
	end if
	
next

// 12.09.2014 HR: Wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
is_logFlightZeile = ""

commit;

if of_check_global_explosion() then
	of_trace(1,1,"Info: No Packing List Explosion due to global job 110. [of_start_for_airline]")
	return true
end if

// =============================================================================
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
//
// =============================================================================
//
// Diese Methode ist sp$$HEX1$$e400$$ENDHEX$$ter ggf. pro Betrieb bzw. pro Mandant auszuf$$HEX1$$fc00$$ENDHEX$$hren.
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend wird dies f$$HEX1$$fc00$$ENDHEX$$r eine Airline durchgef$$HEX1$$fc00$$ENDHEX$$hrt.
// Es wird cen_out_detail gef$$HEX1$$fc00$$ENDHEX$$llt.
//
// =============================================================================

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
//
lPltype				= 1

// 09.03.2012 HR: Bei PLSQL greift der Trigger
if ii_explode_plsql >= 1 then
	// Nothing to do here
else
	of_generate_pl_explosion(0)
end if

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Zeitungen
//
lPltype				= 2
of_generate_pl_explosion(0)

//
// Schreiben nach cen_out_detail incl. commit
//
of_write_loading_detail()

//f_print_datastore(dsCenOutMasterLevel1)
//f_print_datastore(dsCenOutDetail)


return true

end function

public function boolean of_start_for_nfb (string arg_client, string arg_unit, date arg_generationdate);// =============================================================================
//
// of_start_for_nfb
//
// St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung Non-Flight-Business
//
// =============================================================================
long					i

ibPostingBrowser = false // 13.09.2011 HR:

//	
// Setzen der notwendigen Objekt-Properties
//
dgenerationdate 	= arg_generationdate
sClient				= arg_client			// Mandant
sPlant				= arg_unit				// Betrieb

//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

//
// Check der notwendigen Objekt-Properties
//
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

// 06.09.2010 HR: Projekt Forcast
iFillForcastFields = integer(of_cen_profilestring("OnlineExplosion","FillForcastFields","0",sClient))

// 06.06.2012 HR: Neuer Schalter f$$HEX1$$fc00$$ENDHEX$$r Gruppierung in CEN_OUT_MASTER
ii_GroupPlBySslZblAc2 = integer(of_cen_profilestring("OnlineExplosion","GroupPlBySslZblAc2","0",sClient))

// 09.03.2012 HR:
ii_explode_plsql = integer(of_cen_profilestring("OnlineExplosion","ExplodeWithPLSQL","0",sClient))
if ii_explode_plsql >= 1 then
	of_trace(1,1,"Online Item Explosion being performed by PLSQL" )
end if


of_trace(1,1,"Start Packing List Explosion for Non-Flight-Business: Client = " + sClient + &
				"; Unit = " + sPlant + "! [of_start_for_nfb]")

// =============================================================================
//
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
//
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)


// =============================================================================
//
// Alle Packing Lists holen
//
// =============================================================================
if of_generate_loading_nfb() <> 0 then
	sErrortext = "Error generate loading for Non-Flight-Business."
	of_trace(2,1,sErrortext + " [of_start_for_nfb]")
	return false
end if

commit;

if of_check_global_explosion() then
	of_trace(1,1,"Info: No Packing List Explosion due to global job 110. [of_start_for_nfb]")
	return true
end if

// =============================================================================
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
//
// =============================================================================
//
// Diese Methode ist sp$$HEX1$$e400$$ENDHEX$$ter ggf. pro Betrieb bzw. pro Mandant auszuf$$HEX1$$fc00$$ENDHEX$$hren.
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend wird dies f$$HEX1$$fc00$$ENDHEX$$r eine Airline durchgef$$HEX1$$fc00$$ENDHEX$$hrt.
// Es wird cen_out_detail gef$$HEX1$$fc00$$ENDHEX$$llt.
//
// =============================================================================

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
//
lPltype				= 1
of_generate_pl_explosion(1)

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Zeitungen
//
lPltype				= 2
of_generate_pl_explosion(1)

//
// Schreiben nach cen_out_detail incl. commit
//
// --------------------------------------------------------------------------------------------------------------------
// 15.05.2013 HR: Returnvalue abfragen und je nach Wert True oder false weiterreichen
// --------------------------------------------------------------------------------------------------------------------
if of_write_loading_detail() = 0 then
	return true
else
	return false
end if
end function

public function boolean of_start_packinglist_explosion (string arg_client, date arg_generationdate);// =============================================================================
//
// of_start_packinglist_explosion
//
// f$$HEX1$$fc00$$ENDHEX$$hrt komplette Matdispo f$$HEX1$$fc00$$ENDHEX$$r alle St$$HEX1$$fc00$$ENDHEX$$cklisten aus
//
// cen_out_master => cen_out_detail
//
// =============================================================================

ibPostingBrowser = false // 13.09.2011 HR:

//	
// Setzen der notwendigen Objekt-Properties
//
dgenerationdate 	= arg_generationdate
sClient				= arg_client			// Mandant

//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

//
// Check der notwendigen Objekt-Properties
//
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

of_trace(1,1,"Start Packing List Explosion for Client = " + sClient + "! [of_start_packinglist_explosion]")

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
//
lPltype				= 1
of_generate_pl_explosion(0)

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Zeitungen
//
lPltype				= 2
of_generate_pl_explosion(0)

//
// Schreiben nach cen_out_detail incl. commit
//
// --------------------------------------------------------------------------------------------------------------------
// 15.05.2013 HR: Returnvalue abfragen und je nach Wert True oder false weiterreichen
// --------------------------------------------------------------------------------------------------------------------
if of_write_loading_detail() = 0 then
	return true
else
	return false
end if
end function

public subroutine of_trace (integer arg_infotype, integer arg_level, string arg_trace_text);integer	iTraceFile
string	sLogMessage

//
// Tracing in zwei Formaten
//
if iTraceFormat = 0 then
	//
	// unwichtiges filtern
	//
	if arg_level > this.idebuglevel then return
	
	iTraceFile	= FileOpen(smatdispotracefile, LineMode!, Write!, LockWrite!, Append!)

	// 12.09.2014 HR: is_logFlightZeile mit ausgeben
	FileWrite(iTraceFile, String(Today())+"|"+String(Now())+"|OE" + is_logFlightZeile + arg_trace_text)
	
	FileClose(iTraceFile)
else
	// ----------------------------------------------------
	// Logging im CSV-Format
	// Infotype		0 = Erfolg
	// 				1 = Information
	//					2 = Fehler
	//					3 = SQL Fehler
	// ----------------------------------------------------
	//
	// unwichtiges filtern
	//
	if arg_level > this.idebuglevel then return
	// 12.09.2014 HR: is_logFlightZeile mit ausgeben
	sLogMessage = string(arg_infotype) + "," + string(lJobNumber) + "," + string(today(),"YYYY-MM-DD") + "," + string(now(), "hh:mm:ss") + "," + is_logFlightZeile + arg_trace_text
	iTraceFile = FileOpen(smatdispotracefile, LineMode!, Write!, Shared!)
	FileWrite(iTraceFile,sLogMessage)
	FileClose(iTraceFile)


	
end if

end subroutine

public function integer of_write_loading ();// ==========================================================================
//
// of_write_loading
//
// Die Beladung, die in dsCenOutMasterLevel1 steht, 
// und aus der Loadinglist, Mahlzeiten und Zeitungen erstellt wurde,
// wird jetzt gespeichert.
//
// ==========================================================================
// 20.04.2012 RUS RTN Interface; Enqueue Flight for Interface INT007_LOAD
// ==========================================================================


long      lSQLCode
long      lSQLRow
string    sSQLErrorText, ls_ret
long      lCount, ll_ret
long 		lStart, lStop
Long		ll_Succ
// Queue Functions (sys_bill_unit_queue)
uo_rtn_queue	luo_rtn_queue


//
// 23.12.05   Pr$$HEX1$$fc00$$ENDHEX$$fung, ob bereits eine Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r den Flug vorliegt.
//            Falls ja, dann erst l$$HEX1$$f600$$ENDHEX$$schen, da es sonst zu doppelten Mengen kommt.
//
select count(*)
  into :lCount
  from cen_out_master
 where nresult_key = :lResultKey;
 
of_trace(1,1,"[of_write_loading] Start Packing List Explosion Write")
 
if lcount > 0 then
   of_trace(1,1,"[of_write_loading] Delete Packing List Explosion for flight " + sAirlineCode + " " + string(lFlightNumber) + &
               "; result_key = " + string(lResultKey) )
               
   delete from cen_out_master
    where nresult_key = :lResultKey;
   

   
   if sqlca.sqlcode <> 0 then
      of_trace(1,1,"[of_write_loading] Error deleting Packing List Explosion for flight " + sAirlineCode + " " + string(lFlightNumber) + &
               "; result_key = " + string(lResultKey) )
   end if
end if

of_trace(1,1, "[of_write_loading] Flight " + sAirlineCode + " " + string(lFlightNumber)+" INSERT STARTED Rows: "+string(dsCenOutMasterLevel1.rowcount()))
lStart = CPU()
if ii_explode_plsql <= 1 then

   if dsCenOutMasterLevel1.Update() <> 1 then
      lSQLCode       = dsCenOutMasterLevel1.lSQLErrorDBCode
      lSQLRow        = dsCenOutMasterLevel1.lSQLErrorRow
      sSQLErrorText   = dsCenOutMasterLevel1.sSQLErrorText
   
      //of_trace(1,1,"[of_write_loading] Error writing the result of the Packing List Explosion! (see xls output...)")
      of_trace(3,1,"[of_write_loading] Error writing to database table cen_out_master: code/row/text: " + string(lSQLCode) + "/" + &
                  string(lSQLRow) + "/" + sSQLErrorText )
      
   //   dsCenOutMasterLevel1.SaveAs("C:\dsCenOutMaster" + string(lresultkey) + ".xls",Excel5!,True)
      rollback;
      //
      // 20.10.05 Reset hat gefehlt
      //
      dsCenOutMasterLevel1.Reset()
      dsCenOutMasterLevelN.Reset()
      //
      //  20.10.05 sys_explosion.nstatus im Fehlerfall auf 2 setzen?
      //
   
      return -1
   end if

elseif ii_explode_plsql  = 2 then // PLSQL-Bulkupdate
   
   of_trace(1,1,"[of_write_loading] Starting PL/SQL Bulk Update")
   uo_bulk_insert luo_bulk
   luo_bulk = Create uo_bulk_insert   
   
   if luo_bulk.of_connect(sqlca) <> 0 then
      of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert connection error: " + luo_bulk.sqlerrtext)
   else
      of_trace(1,1,"[of_write_loading] PL/SQL Bulk Update Array initialize started")
      ll_ret = luo_bulk.of_load_arrays(dsCenOutMasterLevel1)
      if ll_ret <= 0 then
         of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert found no rows to insert")
      else
         of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert Array initialize done")
         ls_ret = luo_bulk.of_bulk_insert() 
         
         of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert Message: " +ls_ret )
         if luo_bulk.SqlCode <> 0 then
            of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert ERROR: " + luo_bulk.sqlerrtext )
            rollback;
         else
            of_trace(1,1,"[of_write_loading] PL/SQL Bulk Insert DONE")
         end if
      end if
   end if
   
   disconnect using luo_bulk;
   Destroy luo_bulk
   
end if
lStop = CPU()
of_trace(1,1, "[of_write_loading] Flight " + sAirlineCode + " " + string(lFlightNumber)+" INSERT DONE " +string(lStop - lStart, "#,##0")+" msek")

// --------------------------------------------------------
// Enqueue flight for INT007_LOAD processing
// --------------------------------------------------------
If luo_rtn_queue.of_is_enabled(sclient, SQLCA ) then
	ll_Succ = luo_rtn_queue.of_enqueue_flight(lresultkey, "INT007_LOAD", SQLCA, "uo_pl_explosion.of_write_loading")	
	ll_Succ = luo_rtn_queue.of_enqueue_flight(lresultkey, "INT012_LOAD", SQLCA, "uo_pl_explosion.of_write_loading")	// 23.05.2014 HR: Weitere Berechnung f$$HEX1$$fc00$$ENDHEX$$r RUS
End if

dsCenOutMasterLevel1.Reset()
dsCenOutMasterLevelN.Reset()   

of_trace(1,1,"[of_write_loading] Packing List Explosion Write done")
return 0

end function

public function integer of_write_loading_detail ();//
// of_write_loading_detail
//
// Die in cen_out_news_ll gespeicherte Beladung wurde PL f$$HEX1$$fc00$$ENDHEX$$r PL aufgel$$HEX1$$f600$$ENDHEX$$st und jetzt 
// nach cen_out_news_ll gespeichert.
//
long		lSQLCode
long		lSQLRow
string	sSQLErrorText

// --------------------------------------------------------------------------------------------------------------------
// 21.11.2014 HR: Brauchen wir nur noch bei der Explode with service funktion
// --------------------------------------------------------------------------------------------------------------------
if ii_explode_plsql <> 0 then return 0

of_trace(1,1,"[of_write_loading_detail] Start writing details for Client = " + sClient + "; Unit = " + sPlant + "; Airline = " + sAirline )

if dsCenOutDetail.Update() <> 1 then
	lSQLCode 		= dsCenOutDetail.lSQLErrorDBCode
	lSQLRow  		= dsCenOutDetail.lSQLErrorRow
	sSQLErrorText	= dsCenOutDetail.sSQLErrorText
	
	of_trace(1,1,"[of_write_loading_detail] Error writing the result of the Packing List Explosion! (see xls output...) ")
	of_trace(3,1,"[of_write_loading_detail] Error writing to database table cen_out_detail: code/row/text: " + string(lSQLCode) + "/" + &
					string(lSQLRow) + "/" + sSQLErrorText )
	rollback;
	return -1
end if

commit;

of_trace(1,1,"[of_write_loading_detail] End writing details for Client = " + sClient + "; Unit = " + sPlant + "; Airline = " + sAirline )

return 0

end function

public function boolean of_start_for_flight (long arg_resultkey);// =============================================================================
//
// of_start_for_flight
//
// f$$HEX1$$fc00$$ENDHEX$$hrt komplette Matdispo (Zeitungen und normales Zeug) f$$HEX1$$fc00$$ENDHEX$$r einen Flug aus
//
// =============================================================================
//
// Datum			Aktion
// -----------------------------------------------------------------------------
//	12.02.2004	Matdispo f$$HEX1$$fc00$$ENDHEX$$r SPML wird eingef$$HEX1$$fc00$$ENDHEX$$hrt
//
// =============================================================================
long					i

ibPostingBrowser = false // 13.09.2011 HR:

// DataObjects anpassen: Einzelflug hat Result-Key als Retrieval Argument
// Aus Kompatiblit$$HEX1$$e400$$ENDHEX$$tsgr$$HEX1$$fc00$$ENDHEX$$nden zu den $$HEX1$$fc00$$ENDHEX$$brigen Methoden werden die Datastores
// beibehalten.
dsFlightsOnly.DataObject						= "dw_exp_pax_of_one_flight"
dsFlightsOnly.SetTransObject(SQLCA)
dsFlightsOfTheDay.DataObject				= "dw_exp_pax_of_one_flight"
dsFlightsOfTheDay.SetTransObject(SQLCA)

// Mit Result-Key nach cen_out, Properties holen und setzen, dann Matdispo ansto$$HEX1$$df00$$ENDHEX$$en.
dsFlightsOnly.Retrieve(arg_resultkey)
if dsFlightsOnly.RowCount() = 0 then
	return false
end if

dsFlightsOfTheDay.Retrieve(arg_resultkey)
if dsFlightsOfTheDay.RowCount() = 0 then
	return false
end if

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX
// --------------------------------------------------------------------------------------------------------------------
is_Mandant 					= dsFlightsOnly.GetItemString(1,"cen_out_cclient")
iDoNotSet0ForCxFlights 	= integer(of_cen_profilestring("OnlineExplosion","DoNotSet0ForCxFlights","0",is_Mandant))

// 06.09.2010 HR: Projekt Forcast
iFillForcastFields 			= integer(of_cen_profilestring("OnlineExplosion","FillForcastFields","0",is_Mandant))

// 06.06.2012 HR: Neuer Schalter f$$HEX1$$fc00$$ENDHEX$$r Gruppierung in CEN_OUT_MASTER
ii_GroupPlBySslZblAc2 	= integer(of_cen_profilestring("OnlineExplosion","GroupPlBySslZblAc2","0",is_Mandant))

// HShipman 31.01.2012
ii_explode_plsql = integer(of_cen_profilestring("OnlineExplosion","ExplodeWithPLSQL","0",is_Mandant))
if ii_explode_plsql >= 1 then
	of_trace(1,1, "[of_start_for_flight] "+"Online Item Explosion being performed by PLSQL" )
end if


// --------------------------------------------------------------------------------------------------------------------
// Setzen der notwendigen Objekt-Properties
// --------------------------------------------------------------------------------------------------------------------
dgenerationdate 			= date(dsFlightsOnly.GetItemDateTime(1,"cen_out_ddeparture"))
sClient						= dsFlightsOnly.GetItemString(1,"cen_out_cclient")
sPlant							= dsFlightsOnly.GetItemString(1,"cen_out_cunit")
lAirlineKey					= dsFlightsOnly.GetItemNumber(1,"cen_out_nairline_key")
lResultKey 					= arg_resultkey
sAirlineCode					= dsFlightsOnly.GetItemString(1,"cen_out_cairline")
lFlightNumber 				= dsFlightsOnly.GetItemNumber(1,"cen_out_nflight_number")
lTransaction					= dsFlightsOnly.GetItemNumber(1,"cen_out_ntransaction")
tdepartureTime				= time(dsFlightsOnly.GetItemString(1,"cen_out_cdeparture_time"))

// 07.09.2010 HR: Projekt Forcast
il_routing_id					= dsFlightsOnly.GetItemNumber(1,"cen_out_nrouting_id")
il_routingplan_index_key	= dsFlightsOnly.GetItemNumber(1,"cen_out_nroutingplan_index")

// 12.09.2014 HR: ZeilenNr + Flugnummer f$$HEX1$$fc00$$ENDHEX$$r die Ausgaben
is_logFlightZeile = "[" + sAirlineCode + " " + string(lFlightNumber) + "] "

// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Datastore mit den Forecast-Werten lesen
// --------------------------------------------------------------------------------------------------------------------
if iFillForcastFields=1 then
	dsForecast.retrieve(lAirlineKey, dgenerationdate)
	dsForecast_AS.retrieve(lAirlineKey)
else
	dsForecast.reset()
	dsForecast_AS.reset()
end if

// --------------------------------------------------------------------------------------------------------------------
// 30.06.2010 HR: Nicht nur bei CX eines Fluges, sondern auch beim 
//Nachberechnen von CX-Fl$$HEX1$$fc00$$ENDHEX$$gen muss dass Kennzeichen gesetzt sein
// --------------------------------------------------------------------------------------------------------------------
if dsFlightsOnly.GetItemNumber(1,"cen_out_nflight_status")=1 then
	iCNXFlag = 1
else
	iCNXFlag = 0
end if

il_customer_key= dsFlightsOnly.GetItemNumber(1,"ncustomer_key")// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key

// Verkehrstag ermitteln
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

// Check der notwendigen Objekt-Properties
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

sAirline = sAirlineCode   //of_get_airline_name(lAirlineKey)

of_trace(1,1, "[of_start_for_flight] "+"Start Packing List Explosion for one flight: Client = " + sClient + "; Unit = " + sPlant + "; Flight = " + sAirline  +" " + string(lFlightNumber)+"/"+string(dgenerationdate,"dd.mm.yy"))

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2013 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Produktionszeitfenster einer St$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
if ii_explode_plsql = 0 then
	ids_prod_time_frame.retrieve(sPlant, dgenerationdate, string(tdepartureTime, "hh:mm"), "%"+string(iDay)+"%", lAirlineKey )
	of_trace(1,10, "[of_start_for_flight] Rows in ids_prod_time_frame: "+string(ids_prod_time_frame.rowcount()))
end if

// =============================================================================
// Sonderbehandlung f$$HEX1$$fc00$$ENDHEX$$r CNX-Flug
// =============================================================================
if iCNXFlag = 1 and iDoNotSet0ForCxFlights =0 then
	of_trace(1,1, "[of_start_for_flight] "+"CNX-Flag ist gesetzt => Matdispo auf 0" )
	
	// 22.09.2006 Bei CNX mal etwas warten...
	sleep(60)
	
	update cen_out_master set nquantity = 0 where nresult_key = :arg_resultkey;
	
	if sqlca.sqlcode <> 0 then
		of_trace(1,1, "[of_start_for_flight] "+"Error updating cen_out_master for CNX" )
		return false
	end if
	
	return true
end if

// =============================================================================
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

of_trace(1,10, "[of_start_for_flight] "+"Packing List Explosion for flight " + sAirlineCode + " " + string(lFlightNumber) + ": ResultKey = " + string(lResultKey) )

// =============================================================================
// Matdispo Standardbeladung 
// =============================================================================
lPltype				= 1

// 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste zu Beginn auf NULL setzen
setnull(dcPortion)
	
// Packinglists aus Loadinglists, Extrabeladung und Mahlzeiten holen
if of_generate_loading(1) <> 0 then
	sErrortext = "Error generating Loadinglist Explosion."
	of_trace(2,1, "[of_start_for_flight] "+sErrortext )
end if
	
// Zu diesem Zeitpunkt befinden sich alle in der Beladung angewiesenen St$$HEX1$$fc00$$ENDHEX$$cklisten
// in dsCenOutMasterLevel1. Jetzt kann mit der Aufl$$HEX1$$f600$$ENDHEX$$sung der Sub-Packing-Lists begonnen
// werden
	
// Aufl$$HEX1$$f600$$ENDHEX$$sung Sub-Packinglists

if ii_explode_plsql >= 1 then
	if of_generate_sub_pl_explosion_plsql(1) <> 0 then
		sErrortext = "Error generating Sub-Packing-List Explosion."
		of_trace(2,1, "[of_start_for_flight] "+sErrortext )
	end if
else
	if of_generate_sub_pl_explosion(1) <> 0 then
		sErrortext = "Error generating Sub-Packing-List Explosion."
		of_trace(2,1, "[of_start_for_flight] "+sErrortext )
	end if
end if

// 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste bei Zeitungen auf NULL setzen
setnull(dcPortion)

// =============================================================================
//
// Matdispo Lesematerial
//
// =============================================================================
lPltype				= 2
//
// Beladung zusammenstellen
//
if of_generate_loading_newspaper(1) <> 0 then
	sErrortext = "Error generating Loading List Explosion for Newspaper."
	of_trace(2,1, "[of_start_for_flight] "+sErrortext )
end if
	
//
// Extrabeladung zusammenstellen
//
if of_generate_extra_newspaper() <> 0 then
	sErrortext = "Error generating Extra Loading for Newspaper."
	of_trace(2,1, "[of_start_for_flight] "+sErrortext  )
end if
	
//f_print_datastore(dsCenOutMasterLevel1)
//f_print_datastore(dsCenOutMasterLevelN)

// =============================================================================
//
// Alte Beladung l$$HEX1$$f600$$ENDHEX$$schen
//
// =============================================================================
if of_delete_old_loading() <> 0 then
	sErrortext = "Error delete old loading for Flight."
	of_trace(2,1, "[of_start_for_flight] "+sErrortext  )
end if


// =============================================================================
//
// Result-Datastore speichern und Reset nach jedem Flug.
// Dann ist die Aufl$$HEX1$$f600$$ENDHEX$$sung der Packinglists beendet
//
// =============================================================================
if of_write_loading() <> 0 then
	// Fehler
	sErrortext = "Error writing loading: " + sairlineCode + " " + string(lFlightNumber) + " (key " + string(lResultKey) + ")"
	of_trace(2,1, "[of_start_for_flight] "+sErrortext  )
	rollback;
	return false
end if
	
// =============================================================================
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
// =============================================================================
// Diese Methode ist sp$$HEX1$$e400$$ENDHEX$$ter ggf. pro Betrieb bzw. pro Mandant auszuf$$HEX1$$fc00$$ENDHEX$$hren.
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend wird dies f$$HEX1$$fc00$$ENDHEX$$r eine Airline durchgef$$HEX1$$fc00$$ENDHEX$$hrt.
// Es wird cen_out_detail gef$$HEX1$$fc00$$ENDHEX$$llt.
// =============================================================================

// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
lPltype				= 1

if ii_explode_plsql >= 1 then
	// Nothing to do here
else
	of_generate_pl_explosion_for_one_flight()
end if

// Aufl$$HEX1$$f600$$ENDHEX$$sung Zeitungen
lPltype				= 2
of_generate_pl_explosion_for_one_flight()

// Schreiben nach cen_out_detail incl. commit
of_write_loading_detail()

// 12.09.2014 HR: Wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
is_logFlightZeile = ""

//f_print_datastore(dsCenOutMeals)
//f_print_datastore(dsCenOutDetail)

return true

end function

public function integer of_generate_loading_newspaper (long arg_row);// =============================================================================
//
// of_generate_loading_newspaper
//
// =============================================================================
//
// Loadinglists f$$HEX1$$fc00$$ENDHEX$$r kompletten Tag werden aufgel$$HEX1$$f600$$ENDHEX$$st
//
// =============================================================================
long 		i, j
long		lRow
long		lFind
string		sFind

of_trace(1,1,"[of_generate_loading_newspaper] Start generating newspaper loading")

if not isvalid(uo_calc) then
	of_trace(2,1,"[of_generate_loading_newspaper] Error: uo_calc was not instanciated! ")
	return -1
end if
	
//
// Lokale Bereiche setzen
//
lArea_Key			= 0	// der lokale Bereich
lWorkstation_Key	= 0	// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master

//
// Hole die Beladung des Tages...
//
// Information $$HEX1$$fc00$$ENDHEX$$ber die alle LL je Flug sind hier gespeichert
// => Mehrere Datens$$HEX1$$e400$$ENDHEX$$tze je Flug m$$HEX1$$f600$$ENDHEX$$glich (einen je Loadinglist)
//
dsNewspaperLoading.Retrieve(lResultKey)

//
// Kompatiblit$$HEX1$$e400$$ENDHEX$$t mit "normaler" Beladung
//
lReckoning			= 0
lPackinglistKind		= 0
lPackinglistType	= 0

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
isPackinglistXsl=""

for i = 1 to dsNewspaperLoading.RowCount()

	sLoadingList 	= dsNewspaperLoading.GetItemString(i,"cen_out_news_cnews_ll")
	lPriority		= dsNewspaperLoading.GetItemNumber(i,"cen_out_news_nprio")
	//
	// Key aus HandlingObjekt, aus dem die Beladung stammt
	//
	lHandlingKey	= dsNewspaperLoading.GetItemNumber(i,"nhandling_key")			
	lHandlingID		= 6	// nhandling_id wird automatisch auf 6 = Lesematerial gesetzt

	//
	// Retrieve auf cen_news_ll mit dem Abflugdatum und Loadinglist
	//
	dsNewsLoadingList.Retrieve(sClient, sLoadinglist, dgenerationdate, string(tDepartureTime, "HH:MM"))
	
	for j = 1 to dsNewsLoadingList.RowCount()
		lLLIndexKey  		= dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nnews_ll_index_key")
		lPLIndexKey			= dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nnews_pl_index_key")
		lPLDetailKey		= dsNewsLoadingList.GetItemNumber(j,"nnews_pl_detail_key")
		sPackinglist		= dsNewsLoadingList.GetItemString(j,"cen_news_pl_index_cnews_pl")
		sText					= dsNewsLoadingList.GetItemString(j,"cen_news_pl_index_cnewspaper")
		
		sGalley				= dsNewsLoadingList.GetItemString(j,"cen_galley_cgalley")
		sStowage				= dsNewsLoadingList.GetItemString(j,"cen_stowage_cstowage")
		sPlace				= dsNewsLoadingList.GetItemString(j,"cen_stowage_cplace")
		ibelly				= dsNewsLoadingList.GetItemNumber(j,"cen_stowage_nbelly")

		lLabelTypeKey		= dsNewsLoadingList.GetItemNumber(j,"cen_news_pl_index_nnews_pl_type_key")	
		lClassNumber		= 0
		dcWeight				= 0.0
		sUnit					= dsNewsLoadingList.GetItemString(j,"cen_news_pl_cunit")	
		lSort					= dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nsort")	
		
		lAction				= 1			// 1 = bringst Du
		lExplosion_level	= 1			// Wir bearbeiten den obersten Level

		lCalc_id				= 3			// Innerhalb der Loadinglist gibt es nur Ratio-Beladung
		//
		// Berechnung der Auftragsmenge (falls Berechnungsart gew$$HEX1$$e400$$ENDHEX$$hlt)
		//
		lRatiolist_key 	= dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nratiolist_key")
		lCalc_detail_key	= lRatiolist_key
		
		isPackinglistShortText = sText // 23.05.2014 HR: CBASE-HKG-CR-2014-005
		
		//
		// Mengen zur$$HEX1$$fc00$$ENDHEX$$cksetzen!
		//
		lQuantity 	= 0
		dcQuantity	= 0.00

		if lRatiolist_key > 0 then
			//
			// Es wurde eine Berechnung gew$$HEX1$$e400$$ENDHEX$$hlt
			//
			sClass = dsNewsLoadingList.GetItemString(j,"cen_news_ll_cclass")
			//
			// Passagierzahlen aus cen_out_pax holen (f$$HEX1$$fc00$$ENDHEX$$r diesen Flug und diese Klasse)
			// => Find auf dsFlightsOfTheDay
			//
			sFind = "cen_out_nresult_key = " + string(lresultkey) + " and cen_out_pax_cclass = '" + sClass + "'"
			lFind = dsFlightsOfTheDay.Find(sFind,1,dsFlightsOfTheDay.RowCount())
			if lFind > 0 then
				lPax 	= dsFlightsOfTheDay.GetItemNumber(lFind,"cen_out_pax_npax")
			else
				lPax = 0
			end if
			
			//
			// Achtung: Nur die Passagierzahl berechnen, wenn beim Frequenzfeld eine -1 vorgesehen ist
			//
			if dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nquantity" + string(iDay)) = -1 then
				//
				// Auftragsmenge anhand Passagierzahl Berechnen
				//
				uo_calc.lcalcdetailkey	= lCalc_detail_key
				uo_calc.dgenerationdate	= dGenerationDate
				uo_calc.lCalcBasis		= lPax
				uo_calc.lAirlineKey		= lAirlineKey			// 07.10.2005
				uo_calc.il_FillEmptyCustomerPL = il_FillEmptyCustomerPL
				uo_calc.sClient = this.is_mandant   //08.12.2011
				
				lquantity = uo_calc.uf_calc_ratiolist()
				if lquantity = -1 then
					//
					// Fehler bei Berechnung
					//
					of_trace(2,1,"[of_generate_loading_newspaper] Error calculating the newspaper loading: of_calc_ratiolist returns -1; lresultkey = " + string(lresultkey) )
				end if
			end if
		else
			//
			// Beladung einer festen Menge (abh. vom Verkehrstag)
			//
			sClass = ""
			lquantity = dsNewsLoadingList.GetItemNumber(j,"cen_news_ll_nquantity" + string(iDay))
		end if
		
		if isnull(lquantity) then
			of_trace(2,1,"[of_generate_loading_newspaper] Error calculating the newspaper loading: lquantity is null; lresultkey = " + string(lresultkey))
			lquantity = 0
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 25.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
		// --------------------------------------------------------------------------------------------------------------------
		sSalesRel 				= " "
		sDefStorageLocation	= " "
		sGoodsRecipient		= " "

		//
		// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master,
		// aber bitte sch$$HEX1$$f600$$ENDHEX$$n den Flug (lresultkey) nicht vergessen!
		// handling_id braucht hier nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigt zu werden, weil cen_out_master v$$HEX1$$f600$$ENDHEX$$llig leer ist
		// aber nfreq_key
		//
		sFind = "npl_type = " + string(lPlType) + " and npl_index_key = " + string(lPLIndexKey) + &
					" and npl_detail_key = " + string(lPLDetailKey) + &
					" and nresult_key = " + string(lresultkey) + " and nfreq_key = " + string(iDay)
		lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())
		if lFind > 0 then
			//
			// Packinglist gibt's schon => kumulieren
			//
			dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
			dcOldQuantity	= dcOldQuantity + lQuantity
			dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcOldQuantity)
		
			// --------------------------------------------------------------------------------------------------------------------
			// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
			dcquantity_version	= dcOldQuantity + lQuantity
			dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
		else
			//
			// Packinglist gibt's noch nicht => insert
			//
			dcQuantity		= lquantity
			
			dcquantity_version = dcQuantity // 30.01.2013 HR: Menge f$$HEX1$$fc00$$ENDHEX$$r Version ist identisch zur Menge
			
			// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
			ii_NPARTIALSUBSTITUTION = 0

			of_insert_cen_out_master(1)
		end if
	next
next

return 0

end function

public function integer of_generate_loading_nfb ();// =============================================================================
//
// of_generate_loading_nfb
//
// Drittmarkt (Handling_id = 10)
//
// Matdispo f$$HEX1$$fc00$$ENDHEX$$r alle "normalen" Einzelst$$HEX1$$fc00$$ENDHEX$$cklisten aus dem Drittmarkt
//
// =============================================================================
//
// Es mu$$HEX2$$df002000$$ENDHEX$$lediglich cen_out_master gef$$HEX1$$fc00$$ENDHEX$$llt werden.
// Der Rest wird von of_generate_packinglist_explosion erledigt!
//
// Versuch, soweit wie m$$HEX1$$f600$$ENDHEX$$glich die vorhandenen Funktionen zu nutzen.
//
// Achtung:
// Es werden auch einzelne Artikel/Zeitungen nach cen_out_master geschrieben.
// =============================================================================
long		i, j, k
long		lRow
long		lFind
long		lNonFlightKey
string	sFind

of_trace(1,1,"[of_generate_loading_nfb] Start generating Non-Flight-Business!")

//
// Lokale Bereiche setzen
//
lArea_Key			= 0		// der lokale Bereich
lWorkstation_Key	= 0		// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master

//
// Alles NFB-Gelumpe f$$HEX1$$fc00$$ENDHEX$$r einen Betrieb holen
//
dsCenOutNFB.Retrieve(sClient, sPlant, dgenerationdate)

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
isPackinglistXsl=""

//
// Alle Auftr$$HEX1$$e400$$ENDHEX$$ge durchlaufen
//
for i = 1 to dsCenOutNFB.RowCount()
	lNonFlightKey 	= dsCenOutNFB.GetItemNumber(i,"nnon_flight_key")
	lresultkey		= dsCenOutNFB.GetItemNumber(i,"nresult_key")
	lTransaction	= dsCenOutNFB.GetItemNumber(i,"ntransaction")
	tdepartureTime	= time(dsCenOutNFB.GetItemString(i,"cdelivery_time"))
	//
	// Inhalt des Auftrags ermitteln
	//
	dsLoadingNFB.Retrieve(lNonFlightKey)
	
	// =============================================================================
	//
	// Alle Auftragspositionen durchlaufen und PLs ermitteln
	//
	// =============================================================================
	for k = 1 to dsLoadingNFB.RowCount()
		//
		// $$HEX1$$dc00$$ENDHEX$$bertrag nach cen_out_master
		//
		lPltype 				= dsLoadingNFB.GetItemNumber(k,"cen_nfb_pl_npl_type")
		lPLIndexKey			= dsLoadingNFB.GetItemNumber(k,"cen_nfb_pl_npackinglist_index_key")
		sLoadinglist		= ""
		isPackinglistShortText = "" // 23.05.2014 HR: CBASE-HKG-CR-2014-005
		
		//
		// Abh$$HEX1$$e400$$ENDHEX$$ngig von lPltype die Detail-Infos holen
		//
		if lPltype = 1 then
			//
			// Normale St$$HEX1$$fc00$$ENDHEX$$ckliste
			//
			dsPackingList.DataObject				= "dw_explosion_packinglist_infos"
			dsPackingList.SetTransObject(SQLCA)
			
			dspackinglist.Retrieve(lPLIndexKey, dgenerationdate)
			for j = 1 to dspackinglist.RowCount()
				lPLDetailKey		= dspackinglist.GetItemNumber(j,"cen_packinglists_npackinglist_detail_key")
				sPackinglist		= dspackinglist.GetItemString(j,"cen_packinglist_index_cpackinglist")
				sText					= dspackinglist.GetItemString(j,"cen_packinglists_ctext")
				sUnit					= dspackinglist.GetItemString(j,"cen_packinglists_cunit")
				lReckoning			= 0
				lPackinglistKind	= dspackinglist.GetItemNumber(j,"cen_packinglist_index_npl_kind_key")
				lPackinglistType	= dspackinglist.GetItemNumber(j,"cen_packinglists_npackinglist_key")	
				// 20.08.2009 Customer_PL
				scustomer_pl		= dspackinglist.GetItemString(j,"ccustomer_pl")
				scustomer_pl_text	= dspackinglist.GetItemString(j,"ccustomer_text")
			next
		elseif lPltype = 2 then
			//
			// Lesematerial St$$HEX1$$fc00$$ENDHEX$$ckliste
			//
			dsPackingList.DataObject				= "dw_news_packinglist_infos"
			dsPackingList.SetTransObject(SQLCA)
			
			dspackinglist.Retrieve(lPLIndexKey, dgenerationdate)
			for j = 1 to dspackinglist.RowCount()
				lPLDetailKey		= dspackinglist.GetItemNumber(j,"cen_news_pl_nnews_pl_detail_key")
				sPackinglist		= dspackinglist.GetItemString(j,"cen_news_pl_index_cnews_pl")
				sText					= dspackinglist.GetItemString(j,"cen_news_pl_index_cnewspaper")
				sUnit					= "" // Newspaper erstmal keine Einheit
				lReckoning			= 0
				lPackinglistKind	= 0
				lPackinglistType	= 0
				scustomer_pl		= ""
				scustomer_pl_text = ""
			next
		end if
		
		//
		// Mengen zur$$HEX1$$fc00$$ENDHEX$$cksetzen!
		//
		lQuantity 	= 0
		dcQuantity	= 0.00
		
		lQuantity			= dsLoadingNFB.GetItemNumber(k,"cen_nfb_pl_nquantity" + string(iDay) )
		dcquantity			= lQuantity
		lAction				= 1
		lHandlingID			= 10 	// Drittmarkt
		
		//
		// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Auftrag schon in cen_out_master
		// aber Vorsicht: naction = 1 (Beladung)
		//
		if lPLType = 1 then
			sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
						string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
						" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0 "
		else
			sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
						string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
						" and nresult_key = " + string(lresultkey) + " and nfreq_key = " + string(iDay)
		end if
	
		lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())
		
		dcquantity_version = dcQuantity // 06.03.2013 HR:
		
		if lFind > 0 then
			//
			// Packinglist gibt's schon => kumulieren
			//
			dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
			dcQuantity		= dcOldQuantity + dcquantity
			dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcQuantity)
		
			// --------------------------------------------------------------------------------------------------------------------
			// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
			dcquantity_version	= dcOldQuantity + dcquantity_version
			dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
		else
			// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
			ii_NPARTIALSUBSTITUTION = 0

			// Packinglist gibt's noch nicht => insert
			of_insert_cen_out_master(1)
		end if
	next
	
	// =============================================================================
	//
	// Aufl$$HEX1$$f600$$ENDHEX$$sung PL in PL je Auftrag, aber nur f$$HEX1$$fc00$$ENDHEX$$r "normale" St$$HEX1$$fc00$$ENDHEX$$cklisten
	//
	// =============================================================================
	lPltype				= 1
	if of_generate_sub_pl_explosion(1) <> 0 then
		sErrortext = "Error generating Sub-Packing-List Explosion for Non-Flight-Business."
		of_trace(2,1,"[of_generate_loading_nfb] "+sErrortext )
	end if
	
	// =============================================================================
	//
	// Packing List Datastore speichern je Auftrag
	//
	// =============================================================================
	if of_write_loading() <> 0 then
		//
		// Fehler
		//
		of_trace(2,1,"[of_generate_loading_nfb] Error writing the loading: " + sairlineCode + " " + string(lFlightNumber) + " " + &
					  " (key " + string(lResultKey) + ")" )
		rollback;
		return -1
	end if
	
next

return 0

end function

public function integer of_generate_pl_explosion (integer infb_only);// ==========================================================================
//
// of_generate_pl_explosion
//
// St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung auf Basis von cen_out_master
// Es werden nur noch Artikel aufgel$$HEX1$$f600$$ENDHEX$$st!!!
//
// Parameter infb_only: Non-Flight-Business Only (0 oder 1, nein oder ja)
//
// ==========================================================================
long			i, j
datastore	dsDetail
integer		iCountToDo, iCountDone

of_trace(1,10,"Start explosion of the packing lists! Client = " + sClient + "; Unit = " + sPlant + & 
				"; Airline = " + sAirline + "; PL-Type = " + string(lPLType) + " [of_generate_pl_explosion]")

//
// Detail-Datastore anlegen
//
dsDetail	= Create DataStore

//
// Detail-Datastore abh$$HEX1$$e400$$ENDHEX$$ngig vom St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//
Choose Case lPLType
	case 1
		dsDetail.DataObject	= "dw_packinglist_content"
	case 2
		dsDetail.DataObject	= "dw_news_packinglist_content"
end choose

dsDetail.SetTransObject(SQLCA)

//
// Retrieve auf cen_out_master => alle unterschiedlichen Packinglists je Tag
// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigt wird NonFlightBusiness
//
if infb_only = 0 then
	if iJobType = 110 then
		//
		// Matdispo f$$HEX1$$fc00$$ENDHEX$$r kompletten Mandanten
		//
		dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_master_complete"
		dsCenOutMasterLevel1.SetTransObject(SQLCA)
		dsCenOutMasterLevel1.Retrieve(sClient, dgenerationdate, lPLType)
	else
		//
		// Matdispo f$$HEX1$$fc00$$ENDHEX$$r Mandant, Unit, Airline
		//
		dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_master"
		dsCenOutMasterLevel1.SetTransObject(SQLCA)
		dsCenOutMasterLevel1.Retrieve(sClient, sPlant, dgenerationdate, lAirlineKey, lPLType)
	end if
elseif infb_only = 1 then
	if iJobType = 110 then
		//
		// Matdispo f$$HEX1$$fc00$$ENDHEX$$r kompletten Mandanten
		//
		dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_master_complete"
		dsCenOutMasterLevel1.SetTransObject(SQLCA)
		dsCenOutMasterLevel1.Retrieve(sClient, dgenerationdate, lPLType)
	else
		//
		// Matdispo f$$HEX1$$fc00$$ENDHEX$$r Mandant, Unit, Airline
		//
		dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_nfb"
		dsCenOutMasterLevel1.SetTransObject(SQLCA)
		dsCenOutMasterLevel1.Retrieve(sClient, sPlant, dgenerationdate, lPLType)
	end if
end if

//
// 01.09.2005 Achtung: 
// Durch ge$$HEX1$$e400$$ENDHEX$$nderte Kumulierung kann mehrmals die gleiche PL in dsCenOutMasterLevel1 haben
//
for i = 1 to dsCenOutMasterLevel1.RowCount()
	lPLIndexKey		= dsCenOutMasterLevel1.GetItemNumber(i,"npl_index_key")
	lPLDetailKey	= dsCenOutMasterLevel1.GetItemNumber(i,"npl_detail_key")
	
	// Nur/mindestens einmal t$$HEX1$$e400$$ENDHEX$$glich sollte eine Packinglist 
	// in cen_out_detail aktualisiert werden!
	// Dieser Tanz hat hier gefehlt!
	if of_check_packinglist_explosion() > 0 then
		// Packinglist wurde schon aufgel$$HEX1$$f600$$ENDHEX$$st!
		of_trace(1,50,"Info: No need for Packing List Explosion (index-key/detail-key): (" + &
							string(lPLIndexKey) + "/" + string(lPLDetailKey) + ") [of_generate_pl_explosion]")
		iCountDone++
		continue
	else
		of_trace(1,50,"Info: Need a new Packing List Explosion (index-key/detail-key): (" + &
							string(lPLIndexKey) + "/" + string(lPLDetailKey) + ") [of_generate_pl_explosion]")
		// Anm.: Es gibt Packing Lists, die keine Inhalte haben und dadurch wieder
		//			und wieder eine Aufl$$HEX1$$f600$$ENDHEX$$sung ben$$HEX1$$f600$$ENDHEX$$tigen, da der count() auf cen_out_detail
		//			0 ergibt.
		//
		iCountToDo++
	end if
	
	// Retrieve auf PL Stammdaten
	dsDetail.Retrieve(lPLIndexKey, dgenerationdate)

	// Packinglist-Details ermitteln
	for j = 1 to dsDetail.RowCount()
		choose case lPLType
			case 1
				sPackinglist					= dsDetail.GetItemString(j,"cen_packinglist_index_cpackinglist")
				sText							= dsDetail.GetItemString(j,"cen_packinglists_ctext")
				dcQuantity					= dsDetail.GetItemDecimal(j,"cen_packinglist_detail_nquantity")
				lPriority						= dsDetail.GetItemNumber(j,"cen_packinglist_detail_nsort")
				lItemIndexKey				= dsDetail.GetItemNumber(j,"item_npackinglist_index_key")
				lItemDetailKey				= dsDetail.GetItemNumber(j,"item_npackinglist_detail_key")
				sItem							= dsDetail.GetItemString(j,"item_cpackinglist")
				sItemText					= dsDetail.GetItemString(j,"item_ctext")
				iPackinglistLevel			= dsDetail.GetItemNumber(j,"item_npacking_list_level")
				sItemUnit					= dsDetail.GetItemString(j,"item_cunit")
	         	sCustomer_PL      			= dsDetail.GetItemString(j,"ccustomer_pl")
				sCustomer_PL_Text   		= dsDetail.GetItemString(j,"ccustomer_text")

				// Anzahl Gebinde mu$$HEX2$$df002000$$ENDHEX$$ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
				lGebinde						= dsDetail.GetItemNumber(j,"nnumber_packages")
				if lGebinde > 0 then
					dcQuantity 				= dcQuantity * lGebinde
				end if
				lmaterial_group_key		= dsDetail.GetItemNumber(j,"nmaterial_index_key")
				if isnull(lmaterial_group_key) then lmaterial_group_key = -1
				lreckoning					= dsDetail.GetItemNumber(j,"nreckoning")
				if isnull(lreckoning) then lreckoning = 0
				isPackinglistShortText 	= of_ctext_short(dsDetail.GetItemString(j,"item_ctext"), dsDetail.GetItemString(j,"cen_packinglists_ctext_short")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005
				
				// --------------------------------------------------------------------------------------------------------------------
				// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
				// --------------------------------------------------------------------------------------------------------------------
				is_itm_csales_rel			= dsDetail.GetItemString(j,"csales_rel")
 				is_itm_cgoods_recipient 	= right(dsDetail.GetItemString(j,"cgoods_recipient"), 7) // 09.09.2015 HR: Immer 7 Stellen von rechts
				 
			case 2
				sPackinglist					= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl")
				sText							= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper")
				lQuantity						= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nquantity" + string(iDay) )
				lPriority						= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nsort")
				lItemIndexKey				= dsDetail.GetItemNumber(j,"cen_news_pl_detail_ndetail_key")
				lItemDetailKey				= dsDetail.GetItemNumber(j,"cen_news_pl_nnews_pl_detail_key")
				sItem							= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl_1")
				sItemText					= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper_1")
				iPackinglistLevel			= dsDetail.GetItemNumber(j,"cen_news_pl_npacking_list_level")
				sItemUnit					= ""	// Newspaper erstmal keine Einheit
				lmaterial_group_key		= 0
				lreckoning					= 0
	        		sCustomer_PL         		= ""
				sCustomer_PL_Text   		= ""
				isPackinglistShortText 	= sItemText // 23.05.2014 HR: CBASE-HKG-CR-2014-005
				// --------------------------------------------------------------------------------------------------------------------
				// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
				// --------------------------------------------------------------------------------------------------------------------
				is_itm_csales_rel			= ""
 				is_itm_cgoods_recipient 	= ""
				
		end choose
		
		//
		// Check Packinglist-Level:
		// Die Aufl$$HEX1$$f600$$ENDHEX$$sung erfolgt nur f$$HEX1$$fc00$$ENDHEX$$r Artikel!
		//
		if iPackinglistLevel = 3 then
			if of_insert_cen_out_detail() <> 0 then
				of_trace(2,1,"Error writing the packing list details! Packing List Index Key = " + &
									string(lPLIndexKey) + " [of_generate_pl_explosion]")
			end if
			
		end if
		
	next

next

of_trace(1,20,"Info: Total amount of Packing Lists computed: " + string(iCountToDo) + &
				"; amount of Packing Lists already computed: " + string(iCountDone) + &
				" [of_generate_pl_explosion]")

destroy(dsDetail)

return 0

end function

public function integer of_generate_pl_explosion_for_one_flight ();// ==========================================================================
//
// of_generate_pl_explosion_for_one_flight
//
// St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung auf Basis von cen_out_master f$$HEX1$$fc00$$ENDHEX$$r einen Flug
// Es werden nur noch Artikel aufgel$$HEX1$$f600$$ENDHEX$$st!!!
//
// ==========================================================================
long			i, j
datastore	dsDetail
integer		iCountToDo, iCountDone

of_trace(1,10,"[of_generate_pl_explosion_for_one_flight] Start Packing List Explosion: Result-Key = " + string(lResultKey) )

//
// Detail-Datastore anlegen
//
dsDetail	= Create DataStore

//
// Detail-Datastore abh$$HEX1$$e400$$ENDHEX$$ngig vom St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//
Choose Case lPLType
	case 1
		dsDetail.DataObject	= "dw_packinglist_content"
		
		
	case 2
		dsDetail.DataObject	= "dw_news_packinglist_content"
end choose

dsDetail.SetTransObject(SQLCA)

// Retrieve auf cen_out_master => alle Packing Lists f$$HEX1$$fc00$$ENDHEX$$r einen Flug
// 13.09.2011 HR: F$$HEX1$$fc00$$ENDHEX$$r Postingbrowser anderes Datawindow

if ibPostingBrowser then
	dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_master_postingbrowser"
else
	dsCenOutMasterLevel1.DataObject	= "dw_exp_cen_out_master_one_flight"
end if
dsCenOutMasterLevel1.SetTransObject(SQLCA)
dsCenOutMasterLevel1.Retrieve(lResultKey, lPLType)

//
// Achtung: Durch ge$$HEX1$$e400$$ENDHEX$$nderte Kumulierung kann mehrmals die gleiche PL in dsCenOutMasterLevel1 haben
//
for i = 1 to dsCenOutMasterLevel1.RowCount()
	lPLIndexKey		= dsCenOutMasterLevel1.GetItemNumber(i,"npl_index_key")
	lPLDetailKey	= dsCenOutMasterLevel1.GetItemNumber(i,"npl_detail_key")
	
	//
	// Nur/mindestens einmal t$$HEX1$$e400$$ENDHEX$$glich sollte eine Packinglist 
	// in cen_out_detail aktualisiert werden!
	//
	if of_check_packinglist_explosion() > 0 then
		//
		// Packinglist wurde schon aufgel$$HEX1$$f600$$ENDHEX$$st!
		//
		of_trace(1,50,"[of_generate_pl_explosion_for_one_flight] Info: No need for Packing List Explosion (index-key/detail-key): (" + &
							string(lPLIndexKey) + "/" + string(lPLDetailKey) + ")")
		iCountDone++
		continue
	else
		of_trace(1,50,"[of_generate_pl_explosion_for_one_flight] Info: Need a new Packing List Explosion (index-key/detail-key): (" + &
							string(lPLIndexKey) + "/" + string(lPLDetailKey) + ")")
		//
		// Anm.: Es gibt Packing Lists, die keine Inhalte haben und dadurch wieder
		//			und wieder eine Aufl$$HEX1$$f600$$ENDHEX$$sung ben$$HEX1$$f600$$ENDHEX$$tigen, da der count() auf cen_out_detail
		//			0 ergibt.
		//
		iCountToDo++
	end if
	
	//
	// Retrieve auf PL Stammdaten
	//
	dsDetail.Retrieve(lPLIndexKey, dgenerationdate)
	
	if dsDetail.rowcount()>0 then // 13.09.2011 HR: Wie bisher

		//
		// Packinglist-Details ermitteln
		//
		for j = 1 to dsDetail.RowCount()
			choose case lPLType
				case 1
					sPackinglist					= dsDetail.GetItemString(j,"cen_packinglist_index_cpackinglist")
					sText							= dsDetail.GetItemString(j,"cen_packinglists_ctext")
					dcQuantity					= dsDetail.GetItemDecimal(j,"cen_packinglist_detail_nquantity")
					lPriority						= dsDetail.GetItemNumber(j,"cen_packinglist_detail_nsort")
					lItemIndexKey				= dsDetail.GetItemNumber(j,"item_npackinglist_index_key")
					lItemDetailKey				= dsDetail.GetItemNumber(j,"item_npackinglist_detail_key")
					sItem							= dsDetail.GetItemString(j,"item_cpackinglist")
					sItemText					= dsDetail.GetItemString(j,"item_ctext")
					iPackinglistLevel			= dsDetail.GetItemNumber(j,"item_npacking_list_level")
					sItemUnit					= dsDetail.GetItemString(j,"item_cunit")
					//
					// Anzahl Gebinde mu$$HEX2$$df002000$$ENDHEX$$ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
					//
					lGebinde						= dsDetail.GetItemNumber(j,"nnumber_packages")
					if lGebinde > 0 then
						dcQuantity 				= dcQuantity * lGebinde
					end if
					lmaterial_group_key		= dsDetail.GetItemNumber(j,"nmaterial_index_key")
					if isnull(lmaterial_group_key) then lmaterial_group_key = -1
					lreckoning					= dsDetail.GetItemNumber(j,"nreckoning")
					if isnull(lreckoning) then lreckoning = 0
					
					// Customer PL 
					sCustomer_PL				= dsDetail.GetItemString(j,"ccustomer_pl")
					sCustomer_PL_Text		= dsDetail.GetItemString(j,"ccustomer_text")
					isPackinglistShortText 	= of_ctext_short(sItemText, dsDetail.GetItemString(j,"cen_packinglists_ctext_short")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005
					
					// --------------------------------------------------------------------------------------------------------------------
					// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
					// --------------------------------------------------------------------------------------------------------------------
					is_itm_csales_rel			= dsDetail.GetItemString(j,"csales_rel")
					is_itm_cgoods_recipient 	= right(dsDetail.GetItemString(j,"cgoods_recipient"), 7) // 09.09.2015 HR: Immer 7 Stellen von rechts
					
				case 2
					sPackinglist					= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl")
					sText							= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper")
					lQuantity						= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nquantity" + string(iDay) )
					lPriority						= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nsort")
					lItemIndexKey				= dsDetail.GetItemNumber(j,"cen_news_pl_detail_ndetail_key")
					lItemDetailKey				= dsDetail.GetItemNumber(j,"cen_news_pl_nnews_pl_detail_key")
					sItem							= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl_1")
					sItemText					= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper_1")
					iPackinglistLevel			= dsDetail.GetItemNumber(j,"cen_news_pl_npacking_list_level")
					sItemUnit					= ""	// Newspaper erstmal keine Einheit
					lmaterial_group_key		= 0
					lreckoning					= 0
					sCustomer_PL				= ""
					sCustomer_PL_Text		= ""
					isPackinglistShortText		= sItemText  // 23.05.2014 HR: CBASE-HKG-CR-2014-005
					
					// --------------------------------------------------------------------------------------------------------------------
					// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
					// --------------------------------------------------------------------------------------------------------------------
					is_itm_csales_rel			= ""
					is_itm_cgoods_recipient 	= ""
					
			end choose
			
			//
			// Check Packinglist-Level:
			// Die Aufl$$HEX1$$f600$$ENDHEX$$sung erfolgt nur f$$HEX1$$fc00$$ENDHEX$$r Artikel!
			//
			if iPackinglistLevel = 3 then
				if of_insert_cen_out_detail() <> 0 then
					of_trace(1,1,"[of_generate_pl_explosion_for_one_flight] Error at of_insert_cen_out_detail; Packing List Index Key = " + string(lPLIndexKey) )
				end if
				
			end if
			
		next
	elseif ibPostingBrowser = true  then// 13.09.2011 HR:
		
		// --------------------------------------------------------------------------------------------------------------------
		// 13.09.2011 HR: Sollten keine Detail gefunden worden sein, dann schauen wir 
		//  					   beim Postingbrowser nach, ob es sich um einen Artikel handelt.
		// --------------------------------------------------------------------------------------------------------------------
		
		  SELECT cen_packinglists.npacking_list_level  
		 INTO :j
		 FROM cen_packinglists  
		WHERE ( cen_packinglists.npackinglist_index_key = :lPLIndexKey ) AND  
				( :dgenerationdate between cen_packinglists.dvalid_from and cen_packinglists.dvalid_to )   ;


		if sqlca.sqlcode=0 then
			if j <> 3 then continue // Kein Artikel, dann zum n$$HEX1$$e400$$ENDHEX$$chsten
			j=i
			sPackinglist					= dsCenOutMasterLevel1.GetItemString(j,"cpackinglist")
			sText							= dsCenOutMasterLevel1.GetItemString(j,"ctext")
			dcQuantity					= 1 //dsCenOutMasterLevel1.GetItemDecimal(j,"cen_packinglist_detail_nquantity")
			lPriority						= 1 // dsCenOutMasterLevel1.GetItemNumber(j,"cen_packinglist_detail_nsort")
			lItemIndexKey				= dsCenOutMasterLevel1.GetItemNumber(j,"npl_index_key")
			lItemDetailKey				= dsCenOutMasterLevel1.GetItemNumber(j,"npl_detail_key")
			sItem							= sPackinglist //dsCenOutMasterLevel1.GetItemString(j,"item_cpackinglist")
			sItemText					= sText //dsCenOutMasterLevel1.GetItemString(j,"item_ctext")
			iPackinglistLevel			= dsCenOutMasterLevel1.GetItemNumber(j,"cen_out_master_nlevel")
			sItemUnit					= dsCenOutMasterLevel1.GetItemString(j,"cen_out_master_cunit")
			lGebinde						= 0 //dsCenOutMasterLevel1.GetItemNumber(j,"nnumber_packages")
//			if lGebinde > 0 then
//				dcQuantity 		= dcQuantity * lGebinde
//			end if
			lmaterial_group_key		= dsCenOutMasterLevel1.GetItemNumber(j,"cen_out_master_nmaster_index_key")
			if isnull(lmaterial_group_key) then lmaterial_group_key = -1
			lreckoning					= dsCenOutMasterLevel1.GetItemNumber(j,"cen_out_master_nreckoning")
			if isnull(lreckoning) then lreckoning = 0
			sCustomer_PL				= dsCenOutMasterLevel1.GetItemString(j,"cen_out_master_ccustomer_pl")
			sCustomer_PL_Text		= dsCenOutMasterLevel1.GetItemString(j,"cen_out_master_ccustomer_pl_text")
			isPackinglistShortText 	= of_ctext_short(sItemText, dsCenOutMasterLevel1.GetItemString(j,"cen_out_master_ctext_short")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005

			// --------------------------------------------------------------------------------------------------------------------
			// 19.05.2015 HR: Diese 2 neuen Felder werden von SAP noch ben$$HEX1$$f600$$ENDHEX$$tigt
			// --------------------------------------------------------------------------------------------------------------------
			is_itm_csales_rel			= dsCenOutMasterLevel1.GetItemString(j,"csales_rel")
			is_itm_cgoods_recipient 	= right(dsCenOutMasterLevel1.GetItemString(j,"cgoods_recipient"), 7) // 09.09.2015 HR: Immer 7 Stellen von rechts
			
			if of_insert_cen_out_detail() <> 0 then
					of_trace(1,1,"[of_generate_pl_explosion_for_one_flight] Error at of_insert_cen_out_detail; Packing List Index Key = " + string(lPLIndexKey))
			end if
			
		else
			of_trace(1,20,"[of_generate_pl_explosion_for_one_flight] Fehler Ermittlung Packinglistlevel f$$HEX1$$fc00$$ENDHEX$$r "+string(lPLIndexKey)+": "+sqlca.sqlerrtext)
		end if
	end if

next

of_trace(1,20,"[of_generate_pl_explosion_for_one_flight] Info: Total amount of Packing Lists computed: " + string(iCountToDo) + &
				"; amount of Packing Lists already computed: " + string(iCountDone) )


destroy(dsDetail)

return 0

end function

public function integer of_generate_loading (long arg_row);// ==========================================================================
//
// of_generate_loading
//
// Aufruf von uo_flight_explosion zur Erstellung der aktuellen Beladung.
// Speicherung nach cen_out_master.
//
// ==========================================================================
//
// Datum			Aktion
// -----------------------------------------------------------------------------
//	12.02.2004	Matdispo f$$HEX1$$fc00$$ENDHEX$$r SPML wird eingef$$HEX1$$fc00$$ENDHEX$$hrt (kommt bei der Einzelflug-
//					Matdispo zum Tragen)
// 21.04.2004	Kumulierung der Packing Lists auch nach nreckoning
// 26.08.2004	lPackinglistKind und lPackinglistType setzen
//
// 10.09.2009	Account Code & Key
// ==========================================================================
long						j, k, l, m
long						lRow, lFind
string						sFind
String						ls_cclass_temp
integer					iCounter
Boolean					lbo_loop
uo_flight_explosion	uo_loading4flight
boolean					lbo_ll_with_class

of_trace(1,1,"[of_generate_loading] Start generation of loading" )
of_trace(1,10,"[of_generate_loading] Parameters: lPLType = " + string(lPLType) + "; iDay for " + string(dgenerationdate) + " = " + string(iDay) )

// Lokale Bereiche setzen
lArea_Key			= 0	// der lokale Bereich
lWorkstation_Key	= 0	// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
	
// UserObjekt instanziieren
// Merker: alternativ evtl. leeres uo_loading_list immer wieder zuweisen, um create zu sparen...
uo_loading4flight = create uo_flight_explosion
uo_loading4flight.is_logfile = smatdispotracefile // 07.09.2012 HR:

if not isvalid(uo_loading4flight) then
	of_trace(2,1,"[of_generate_loading] Error: uo_loading4flight is not valid for lResultKey = " + string(lResultKey) + "  lTransaction = " + string(lTransaction) )
	return -1
end if

sAirlineCode = dsFlightsOnly.GetItemString(arg_row,"cen_out_cairline")

sAccountFight 	= dsFlightsOnly.GetItemString(arg_row,"cen_out_caccount")// 22.08.2011 HR:
//ll_nairline_key 	= dsFlightsOnly.GetItemNumber(arg_row,"cen_out_nairline_key")// 22.08.2011 HR:

// 31.03.2009 HR:
is_Mandant = dsFlightsOnly.GetItemString(arg_row,"cen_out_cclient")
lMealExplosionWithBillingonly = long(of_cen_profilestring("OnlineExplosion","WithBillingOnly","0",is_Mandant))
// 23.04.2009 TBR:
ilGroupPlByClass = long(of_cen_profilestring("OnlineExplosion","GroupPlByClass","0",is_Mandant))

// 17.09.2015 HR: Russland braucht die Klassen bei den LL
lbo_ll_with_class = ( of_cen_profilestring("OnlineExplosion","LL_With_Class","0",is_Mandant) = "1")

// Leere Customer PL bef$$HEX1$$fc00$$ENDHEX$$llen
il_fillemptycustomerpl = Long(of_cen_profilestring("OnlineExplosion","FillEmptyCustomerPL","0",is_Mandant))

// Die Beladung f$$HEX1$$fc00$$ENDHEX$$r den Flug (LL, SLL)
dsExplosionHandling.Retrieve(lResultKey)

// ---------------------------------------------------------------------
//
// Properties setzen
//
// dazu geh$$HEX1$$f600$$ENDHEX$$ren auch zwei Arrays mit den Keys der SSLs und ZBLs
//
// ---------------------------------------------------------------------
uo_loading4flight.dtDepartureDate	= dsFlightsOnly.GetItemDateTime(arg_row,"cen_out_ddeparture")
uo_loading4flight.sDepartureTime	= dsFlightsOnly.GetItemString(arg_row,"cen_out_cdeparture_time")

uo_loading4flight.sVerkehrstag		= string(iDay)

// ---------------------------------------------------------------------
// das Array mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------	
iCounter = 0
For m = 1 to dsExplosionHandling.Rowcount()
	If dsExplosionHandling.Getitemnumber(m,"nhandling_id") = 1 Then
		// 28.05.2009 HR:
		if m>1 then
			if dsExplosionHandling.find("cloadinglist='"+dsExplosionHandling.GetitemString(m,"cloadinglist")+"'",1, m - 1)>0 then continue
		end if
		iCounter ++
		uo_loading4flight.lFirstArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsExplosionHandling.GetitemString(m,"cloadinglist"))
		//26.10.05 uo_loading4flight.lFirstArgRetrieve[iCounter] = dsExplosionHandling.Getitemnumber(m,"nloadinglist_index_key")
	End if	
Next	

// ---------------------------------------------------------------------
// das Array mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For m = 1 to dsExplosionHandling.Rowcount()
	If dsExplosionHandling.Getitemnumber(m,"nhandling_id") = 2 Then
		// 28.05.2009 HR:
		if m>1 then
			if dsExplosionHandling.find("cloadinglist='"+dsExplosionHandling.GetitemString(m,"cloadinglist")+"'",1, m - 1)>0 then continue
		end if

		iCounter ++
		uo_loading4flight.lSecondArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsExplosionHandling.GetitemString(m,"cloadinglist"))
		// 26.10.05 uo_loading4flight.lSecondArgRetrieve[iCounter] = dsExplosionHandling.Getitemnumber(m,"nloadinglist_index_key")		
	End if	
Next	

// 
// Ermitteln der Beladung
// 
if uo_loading4flight.uf_retrieve() <= 0 then
	of_trace(2,1,"[of_generate_loading] uo_loading4flight.uf_retrieve(): " + sairlineCode + " " + string(lFlightNumber) + " " + " (key " + string(lResultKey) + "): " + uo_loading4flight.sStatusText  )
end if

//f_print_datastore(uo_loading4flight.ds_loadinglist)

//uo_loading4flight.ds_loadinglist.saveas("D:\LOADINGLISTINHALT_1.XLS",EXCEL!,TRUE)

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
isPackinglistXsl=""

for j = 1 to uo_loading4flight.ds_loadinglist.RowCount()
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lPLIndexKey			= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
	lPLDetailKey 		= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglists_npackinglist_detail_key")
	sPackinglist			= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglist_index_cpackinglist")
	sText					= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglists_ctext")
	
	// Customer PL
	scustomer_pl		= uo_loading4flight.ds_loadinglist.GetItemString(j,"ccustomer_pl")
	scustomer_pl_text	= uo_loading4flight.ds_loadinglist.GetItemString(j,"ccustomer_text")
	// Account Code & Key 10.09.2009
	saccount				= uo_loading4flight.ds_loadinglist.GetItemString(j,"caccount")
	lAccount_Key		= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"naccount_key")
	
	//isPackinglistShortText =  sText // lds.GetItemString(j,"cen_packinglists_ctext_short") // 23.05.2014 HR: CBASE-HKG-CR-2014-005
	isPackinglistShortText = of_ctext_short(sText,  uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglists_ctext_short")) // 19.04.2016 HR: CBASE-HKG-CR-2014-005

	sUnit					= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglists_cunit")
	dcQuantity			= uo_loading4flight.ds_loadinglist.GetItemDecimal(j,"cen_loadinglists_nquantity")
	lAction				= 1		// immer beladen (bringst Du)
	// 04.02.2009 HR: Zur Unterscheidung, wo die PL herkommt (SL, ZBL)
	//	lHandlingID			= 1		// f$$HEX1$$fc00$$ENDHEX$$r normale Beladung immer 1
	lHandlingID			= uo_loading4flight.ds_loadinglist.GetItemDecimal(j,"cen_loadinglist_index_nloadinglist_key")
	lReckoning			= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"nreckoning")
	lPackinglistKind		= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npl_kind_key")
	lPackinglistType	= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglists_npackinglist_key")
	
	// 04.02.2009 HR:
	sfromloadinglist =  uo_loading4flight.ds_loadinglist.GetItemstring(j,"cen_loadinglist_index_cloadinglist")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	sSalesRel 				= uo_loading4flight.ds_loadinglist.GetItemstring(j,"csales_rel")
	sDefStorageLocation	= uo_loading4flight.ds_loadinglist.GetItemstring(j,"cdef_storage_location")
	sGoodsRecipient		= right(uo_loading4flight.ds_loadinglist.GetItemstring(j,"cgoods_recipient"), 7) // 09.09.2015 HR: Immer 7 Stellen von rechts
	
	
	if isnull(sSalesRel) then sSalesRel=" "
	if isnull(sDefStorageLocation) then sDefStorageLocation=" "
	
	// 07.09.2011 HR: Falls die Menge der LL oder ZBL im Abrechnungsbrowser auf 0 gesetzt wurde, dann Menge auf 0 setzen
	m = dsExplosionHandling.find("cloadinglist = '"+sfromloadinglist+"'",1,dsExplosionHandling.rowcount())
	if m>0 and sfromloadinglist > " " then
		if dsExplosionHandling.Getitemnumber(m,"nquantity")=0 then 
			dcQuantity = 0
		end if
	end if
	
	if m>0 then
		// 20.01.2012 HR: Wir brauchen hier auch den Abrechnungscode
		choose case dsExplosionHandling.GetItemNumber(m,"nposting_type")
		case 1
			sPostTypeShort ="1"
		case 2
			sPostTypeShort ="2"
		case else
			sPostTypeShort =" "
		end choose
	else
		sPostTypeShort =" "
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Wir merken uns auch den Abrechnungscode 2
	// --------------------------------------------------------------------------------------------------------------------
	if m>0 then
		sAdditionalAccount = dsExplosionHandling.GetItemstring(m,"cadditional_account")
		if isnull(sAdditionalAccount) then sAdditionalAccount= " "
		
		// --------------------------------------------------------------------------------------------------------------------
		// 11.06.2012 HR: Falls ACCOUNT NULL nehmen wir den von der SSL/ZBL
		// --------------------------------------------------------------------------------------------------------------------
		if isnull(saccount) then
			saccount				= dsExplosionHandling.GetItemString(m,"cen_out_handling_caccount")
			lAccount_Key		= dsExplosionHandling.GetItemNumber(m,"cen_out_handling_naccount_key")
		end if
	else
		sAdditionalAccount = " "
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 22.08.2011 HR: Falls die Position keinen  Warenempf$$HEX1$$e400$$ENDHEX$$ger hat, dann nehmen wir ihn von der Beladung oder Flug
	// --------------------------------------------------------------------------------------------------------------------
	if isnull(sGoodsRecipient) then 
		if isnull(saccount) then
			//06.09.2011: Falls die Zeile keinen AccountCode hat, dann suchen wir beim Handling und sonst beim Flug
			m = dsExplosionHandling.find("cloadinglist = '"+sfromloadinglist+"'",1,dsExplosionHandling.rowcount())
			if m>0 and sfromloadinglist > " "then
				if isnull(dsExplosionHandling.getitemstring(m,"cen_out_handling_caccount")) or trim(dsExplosionHandling.getitemstring(m,"cen_out_handling_caccount"))="" then
					sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, sAccountFight)	// 01.10.2012 HR:  Wir brauchen den Kunden-key und nicht den Airline-key
					
				else
					sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, dsExplosionHandling.getitemstring(m,"cen_out_handling_caccount"))// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key
					
				end if
			    
			else
				sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, sAccountFight)	// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key
				
			end if
		else
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, saccount)	// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key
			
		end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 08.09.2015 HR: CCS-TEMP-2015-1308 Anpassen des Accountcodes bei abweichendem Warenemf$$HEX1$$e400$$ENDHEX$$nger
	// --------------------------------------------------------------------------------------------------------------------
	elseif sSalesRel="1" then
		of_get_Account4GoodsRecipient(il_customer_key, sGoodsRecipient, saccount, lAccount_Key)
	end if
	
	// 05.09.2011 HR:
	if isnull(sGoodsRecipient) then sGoodsRecipient="n/a"
	
	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- START
	is_cclass				=  uo_loading4flight.ds_loadinglist.GetItemstring(j,"cen_loadinglists_cclass") 

	IF 	NOT IsNull(is_cclass) THEN

		// Ermittlung der zu der Klasse geh$$HEX1$$f600$$ENDHEX$$renden Sortiernummer ...
		IF 	NOT of_get_class_number(is_cclass) THEN
			is_cclass 			=	" "
			ii_nclass_number 	=	0		
		END IF
		
	ELSE // => is_cclass IS NULL
		
		is_cclass 			= " "
		ii_nclass_number 	= 0		
		
	END IF // IF 	IsNull(is_cclass) 

	// 30.04.2009 HR: Wenn keine Gruppierung auf Klasse dan auf 0 setzen
	// 06.01.2014 HR: Bei der LL $$HEX1$$fc00$$ENDHEX$$bernehmen wir keine Klassen, daher setzen wir sie immer auf Blank/0 (Fehlerliste 4.98 - 010)
	//if ilGroupPlByClass=0 then
	// 17.09.2015 HR: Russland braucht die Klassen bei den LL
	if not lbo_ll_with_class then
		is_cclass 			= " "
		ii_nclass_number 	= 0		
	end if 

	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- ENDE	

	if isnull(lReckoning) then lReckoning = 0
		
	// --------------------------------------------------------------------------------------------------------------------
	// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
	// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
	// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
	
		choose case lReckoning
			case 1
				dcQuantity = 0
			case 0
				lReckoning = 2
		 end choose

	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden noch folgende Werte
	// 					   ben$$HEX1$$f600$$ENDHEX$$tigt und anschlie$$HEX1$$df00$$ENDHEX$$end die Bewertungs-Werte ermittelt
	// --------------------------------------------------------------------------------------------------------------------

	if iFillForcastFields=1 and dsForecast.rowcount()>0 then
		sFind += "ntype=2" 
		sFind += " and (nrouting_id = "+string(il_routing_id)+" or nrouting_id=0)" 
		sFind += " and (nroutingplan_index_key  = "+string(il_routingplan_index_key)+" or nroutingplan_index_key=0)"  
		sFind += " and (nhandling_key   = "+string(lHandlingID)+" or nhandling_key=0)" 
		
		lFind = dsForecast.find(sFind,1,dsForecast.rowcount())
				
		if lfind=0 then
			il_FC_Parm1 = 0
			il_FC_Parm2 = 0
			il_FC_Parm3 = 0
			il_FC_Parm_min = 0 

			of_trace(50,50,"[of_generate_loading] not found sFind = "+sFind )
		else
			il_FC_Parm1 = dsForecast.getitemnumber(lFind,"nparams_key1")
			il_FC_Parm2 = dsForecast.getitemnumber(lFind,"nparams_key2")
			il_FC_Parm3 = dsForecast.getitemnumber(lFind,"nparams_key3")

			of_trace(50,50,"[of_generate_loading] found sFind = "+sFind )
			
			il_FC_Parm_min = of_min_forcast(il_FC_Parm1, il_FC_Parm2)
			il_FC_Parm_min = of_min_forcast(il_FC_Parm_min, il_FC_Parm3)
		end if
	else
		of_trace(50,50,"[of_generate_loading] not found sFind = "+sFind )

		il_FC_Parm1 = -1
		il_FC_Parm2 = -1
		il_FC_Parm3 = -1
		il_FC_Parm_min = -1 
	end if
	
	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung)
	sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
				string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0 " + &
				" and nreckoning =" + string(lReckoning)	 +  /* 21.04.2004 */ &
				" and cclass ='" + is_cclass + "' and nclass_number = " + string(ii_nclass_number) +  /* TBR 23.04.2004 */ &
				" and csales_rel ='" + sSalesRel	 +"'" /*HR 24.03.11 Findet erweitert um CSALES_REL */ + &
				" and cpost_type_short = '"+sPostTypeShort+"' " /* 20.01.2012 HR: Abrechnungskennzeichen einbeziehenn */+ &
				" and cgoods_recipient ='"+sGoodsRecipient+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ + &
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */
				
	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if ii_GroupPlBySslZblAc2 = 1 then
		sFind += " and cloadinglist = '"+sfromloadinglist+"'"
		sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
	end if
	
	//" and nhandling_id = "+string(lHandlingID) + &  //find m$$HEX1$$fc00$$ENDHEX$$sste noch erweitert werden, wird aber in Schritt 1 noch nicht getan um doppelte SL zu vermeiden


	lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())

	dcquantity_version = dcQuantity // 06.03.2013 HR:
	
	if lFind > 0 then
		//
		// Packinglist gibt's schon => kumulieren
		//
		dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
		dcQuantity		= dcOldQuantity + dcQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcQuantity)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + dcquantity_version
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
	else
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		ii_NPARTIALSUBSTITUTION = 0

		// Packinglist gibt's noch nicht => insert
		of_insert_cen_out_master(1)
	end if
	
next		// PL

//dsCenOutMasterLevel1.saveas("D:\LOADINGLIST_dsCenOutMasterLevel1-1.XLS",EXCEL!,TRUE)
//
// $$HEX1$$dc00$$ENDHEX$$bertrag der Mahlzeitenbeladung nach cen_out_master
//
dsCenOutMeals.Retrieve(lResultKey)
of_generate_meal_explosion()

//
// $$HEX1$$dc00$$ENDHEX$$bertrag der SPML-Beladung nach cen_out_master
//
dsCenOutSMPL.Retrieve(lResultKey)
of_generate_spml_explosion()

//
// Userobjekt zerst$$HEX1$$f600$$ENDHEX$$ren
//
destroy uo_loading4flight


return 0

end function

public function integer of_generate_spml_explosion ();// ==========================================================================
//
// of_generate_spml_explosion
//
// ==========================================================================
//
// Transfer der SPML-St$$HEX1$$fc00$$ENDHEX$$cklisten nach cen_out_master
//
// 02.09.2005	Reine Abrechnungss$$HEX1$$e400$$ENDHEX$$tze werden ignoriert
//
// ==========================================================================
long		i, lFind
string	sFind
String		ls_cclass_temp
//Long		ll_nairline_key

//
// Reset lReckoning
//
lReckoning = 0

// 04.02.2009 HR:
sfromloadinglist = ""
//
// Mahlzeitenst$$HEX1$$fc00$$ENDHEX$$cklisten werden zun$$HEX1$$e400$$ENDHEX$$chst im Level-1-Datastore gespeichert
//
dsCenOutMaster = dsCenOutMasterLevel1

// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
of_trace(50,50,"[of_generate_spml_explosion] dsCenOutMaster.rowcount() vorher: "+string(dsCenOutMaster.rowcount()))
of_trace(50,50,"[of_generate_spml_explosion] dsCenOutSMPL.rowcount(): "+string(dsCenOutSMPL.RowCount()))

for i = 1 to dsCenOutSMPL.RowCount()
	// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
	of_trace(50,50,"[of_generate_spml_explosion] "+dsCenOutSMPL.GetItemString(i,"cpackinglist")+" "+string(dsCenOutSMPL.GetItemNumber(i,"npackinglist_index_key"))+" - BillStat: "+string(dsCenOutSMPL.GetItemNumber(i,"nbilling_status") ))
	//
	// 02.09.2005: Reine Abrechnungss$$HEX1$$e400$$ENDHEX$$tze werden ignoriert
	// nbilling_status = 2
	//
	// 31.03.2009 HR: $$HEX1$$c400$$ENDHEX$$nderung f$$HEX1$$fc00$$ENDHEX$$r HGK
	// Wenn der Systamschalter lMealExplosionWithBillingonly auf 0 gesetzt ist, dann wie bisher reine Abrechnung raus
	// ansonsten wird der Status in lreckoning $$HEX1$$fc00$$ENDHEX$$bernommen und ausgewertet
	if lMealExplosionWithBillingonly=0 then
		lreckoning	= 0
		
		// 20.05.2009 HR:Falscher Datastore getauscht
		if dsCenOutSMPL.GetItemNumber(i,"nbilling_status") = 2 then continue
	else
		// 20.05.2009 HR:Falscher Datastore getauscht
		lreckoning = dsCenOutSMPL.GetItemNumber(i,"nbilling_status")
	end if	
	
	// 20.01.2012 HR: Wir brauchen hier auch den Abrechnungscode
	choose case dsCenOutSMPL.GetItemNumber(i,"nposting_type")
	case 1
		sPostTypeShort ="1"
	case 2
		sPostTypeShort ="2"
	case else
		sPostTypeShort =" "
	end choose

	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lPLIndexKey			= dsCenOutSMPL.GetItemNumber(i,"npackinglist_index_key")
	
	// 25.05.2010 HR: Falls Schalter vom aufrufenden Programm gesetzt wurde, dann werden wieder die aktuellen Keys ermittelt, ansonsten wie bisher
	if iGetNewDetailKey =1 then
		lPLDetailKey = of_get_detail_key(lPLIndexKey)
	else
		lPLDetailKey = dsCenOutSMPL.GetItemNumber(i,"npackinglist_detail_key")
	end if
	
	lPackinglistKind	= dsCenOutSMPL.GetItemNumber(i,"npl_kind_key")
	lPackinglistType	= dsCenOutSMPL.GetItemNumber(i,"npackinglist_key")

	isPackinglistShortText	= of_ctext_short(sText, dsCenOutSMPL.GetItemString(i,"cproduction_text")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
	// --------------------------------------------------------------------------------------------------------------------
	// 04.09.2015 HR: SPMLs haben keine Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
	// 22.10.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r BRU brauchen wir es doch wieder
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl		= dsCenOutSMPL.GetItemString(i,"cpackinglist_xsl")

	// 19.02.2014 HR: Wenn NULL dann BLANK
	if isnull(isPackinglistXsl) then isPackinglistXsl = ""
	
	sPackinglist		= dsCenOutSMPL.GetItemString(i,"cpackinglist")
	// vorher: sText					= f_get_packinglist_text(lPLIndexKey,datetime(dGenerationDate))
	sText					= dsCenOutSMPL.GetItemString(i,"ctext")
	sUnit					= dsCenOutSMPL.GetItemString(i,"cunit")
	dcQuantity			= dsCenOutSMPL.GetItemDecimal(i,"nquantity")

	// 20.08.2009 Customer_PL
	scustomer_pl		= dsCenOutSMPL.GetItemString(i,"ccustomer_pl")
	scustomer_pl_text	= dsCenOutSMPL.GetItemString(i,"ccustomer_text")

	// --------------------------------------------------------------------------------------------------------------------
	// 22.08.2011 HR: Falls die Position keinen  Warenempf$$HEX1$$e400$$ENDHEX$$ger hat, dann nehmen wir ihn von der Beladung oder Flug
	// --------------------------------------------------------------------------------------------------------------------

    	sSalesRel = " " //uo_loading4flight.ds_loadinglist.GetItemstring(j,"csales_rel")
	setnull(sGoodsRecipient) //= uo_loading4flight.ds_loadinglist.GetItemstring(j,"cen_loadinglists_cgoods_recipient")
	
	if isnull(sSalesRel) then sSalesRel=" "
	if isnull(sDefStorageLocation) then sDefStorageLocation=" "
	saccount =  dsCenOutSMPL.GetItemString(i,"caccount")

	if isnull(sGoodsRecipient) then 
		if isnull(saccount) then
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, sAccountFight) // 01.10.2012 HR:  Wir brauchen den Kunden-key und nicht den Airline-key
		else
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, saccount) // 01.10.2012 HR:  Wir brauchen den Kunden-key und nicht den Airline-key
		end if
	// --------------------------------------------------------------------------------------------------------------------
	// 08.09.2015 HR: CCS-TEMP-2015-1308 Anpassen des Accountcodes bei abweichendem Warenemf$$HEX1$$e400$$ENDHEX$$nger
	// --------------------------------------------------------------------------------------------------------------------
	elseif sSalesRel="1" then
		of_get_Account4GoodsRecipient(il_customer_key, sGoodsRecipient, saccount, lAccount_Key)
	end if

	// 05.09.2011 HR:
	if isnull(sGoodsRecipient) then sGoodsRecipient="n/a"
	  

  SELECT cen_packinglists.cdef_storage_location  
		 	INTO :sDefStorageLocation
		 	FROM cen_packinglists  
			WHERE ( cen_packinglists.npackinglist_index_key = :lPLIndexKey ) AND  
						( cen_packinglists.npackinglist_detail_key = :lPLDetailKey )  ;


	lAction				= 1		// immer beladen (bringst Du)
	// 04.02.2009 HR: Hier muss erkennbar sein, das es ein SPML ist
	//	lHandlingID			= 1		// f$$HEX1$$fc00$$ENDHEX$$r normale Beladung immer 1
	lHandlingID			= 14
	
	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- START
	is_cclass				= dsCenOutSMPL.GetItemstring(i,"cclass")

	IF 	NOT IsNull(is_cclass) THEN

		// Ermittlung der zu der Klasse geh$$HEX1$$f600$$ENDHEX$$renden Sortiernummer ...
		IF 	NOT of_get_class_number(is_cclass) THEN
			is_cclass 			=	" "
			ii_nclass_number 	=	0		
		END IF
		
	ELSE // => is_cclass IS NULL
		
		is_cclass 			= " "
		ii_nclass_number 	= 0		
		
	END IF // IF 	IsNull(is_cclass) 
	
	// 30.04.2009 HR: Wenn keine Gruppierung auf Klasse dan auf 0 setzen
	if ilGroupPlByClass=0 then
		is_cclass 			= " "
		ii_nclass_number 	= 0		
	end if 

	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- ENDE	


	// --------------------------------------------------------------------------------------------------------------------
	// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
	// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
	// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
	
		choose case lReckoning
			case 1
				dcQuantity = 0
			case 0
				lReckoning = 2
		 end choose

	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden hier die Bewertungs-
	//                          Werte erst mal auf -1 gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	il_FC_Parm1 = -1
	il_FC_Parm2 = -1
	il_FC_Parm3 = -1
	il_FC_Parm_min = -1 

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Wir merken uns auch den Abrechnungscode 2
	// --------------------------------------------------------------------------------------------------------------------
	sAdditionalAccount = dsCenOutSMPL.GetItemstring(i,"cadditional_account")
	if isnull(sAdditionalAccount) then sAdditionalAccount= " "

	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung)
	sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
				string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0 " + &
				" and nreckoning =  "+string(lreckoning)	/* 31.03.2009 HR: 0 durch string(lreckoning) ersetzt */ + &
				" and cclass ='" + is_cclass + "' and nclass_number = " + string(ii_nclass_number)  /* TBR 23.04.2004 */+ &
				" and cpost_type_short = '"+sPostTypeShort+"' " /* 20.01.2012 HR: Abrechnungskennzeichen einbeziehenn */+ &
				" and cgoods_recipient ='"+sGoodsRecipient+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ +&
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */
				// 26.04.2004 
				//" and nhandling_id = "+string(lHandlingID) + &  //find m$$HEX1$$fc00$$ENDHEX$$sste noch erweitert werden, wird aber in Schritt 1 noch nicht getan um doppelte SL zu vermeiden

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if ii_GroupPlBySslZblAc2 = 1 then
		sFind += " and cloadinglist = '"+sfromloadinglist+"'"
		sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
	end if

	lFind = dsCenOutMaster.Find(sFind,1,dsCenOutMaster.RowCount())

	dcquantity_version = dcQuantity // 06.03.2013 HR:
	
	// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
	if dsCenOutSMPL.GetItemNumber(i,"nlocal_sub")=1 and dsCenOutSMPL.GetItemString(i,"cpackinglist_ori") =  dsCenOutSMPL.GetItemString(i,"cpackinglist") then
		ii_NPARTIALSUBSTITUTION = 1
	else
		ii_NPARTIALSUBSTITUTION = 0
	end if
	
	if lFind > 0 then
		// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
		of_trace(50,50,"[of_generate_spml_explosion]  -> QUANTITY ADDED")  

		// Packinglist gibt's schon => kumulieren
		dcOldQuantity	= dsCenOutMaster.GetItemDecimal(lFind,"nquantity")
		dcQuantity		= dcOldQuantity + dcQuantity
		dsCenOutMaster.SetItem(lFind,"nquantity", dcQuantity)
		
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		if ii_NPARTIALSUBSTITUTION = 1 then
			dsCenOutMaster.setitem(lFind,"NPARTIALSUBSTITUTION", ii_NPARTIALSUBSTITUTION)
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + dcquantity_version
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
	else
 
		// Packinglist gibt's noch nicht => insert
		of_insert_cen_out_master(1)

		// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
		of_trace(50,50,"[of_generate_spml_explosion] -> Insert New")

	end if
next

// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
of_trace(50,50,"[of_generate_spml_explosion] dsCenOutMaster.rowcount() "+string(dsCenOutMaster.rowcount()))


return 0

end function

public function integer of_generate_meal_explosion ();// ==========================================================================
//
// of_generate_meal_explosion
//
// ==========================================================================
//
// Transfer der Mahlzeitenst$$HEX1$$fc00$$ENDHEX$$cklisten nach cen_out_master
//
//	26.04.2004	lreckoning setzen
// 26.08.2004	lPackinglistKind und lPackinglistType setzen
// 02.09.2005	Reine Abrechnungss$$HEX1$$e400$$ENDHEX$$tze werden ignoriert
//
// ==========================================================================
long       	i, lFind
string     	sFind
String     	ls_cclass_temp
//Long       	ll_nairline_key
long 		ll_nclass_number, ll_nhandling_key, ll_nrotation_key, ll_nrotation_name_key

//
// Default: Prod + Abr
//
lreckoning	= 0

// 04.02.2009 HR:
sfromloadinglist = ""

//
// Mahlzeitenst$$HEX1$$fc00$$ENDHEX$$cklisten werden zun$$HEX1$$e400$$ENDHEX$$chst im Level-1-Datastore gespeichert
//
dsCenOutMaster = dsCenOutMasterLevel1

// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
of_trace(50,50,"[of_generate_meal_explosion] dsCenOutMaster.rowcount() vorher: "+string(dsCenOutMaster.rowcount()))
of_trace(50,50,"[of_generate_meal_explosion] dsCenOutMeals.rowcount()  "+string(dsCenOutMeals.rowcount()))

for i = 1 to dsCenOutMeals.RowCount()
	// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
	of_trace(50,50,"[of_generate_meal_explosion] "+dsCenOutMeals.GetItemString(i,"cpackinglist")+" "+string(dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key"))+" - BillStat: "+string(dsCenOutMeals.GetItemNumber(i,"nbilling_status") ))

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl		= dsCenOutMeals.GetItemString(i,"cpackinglist_xsl")

	// 19.02.2014 HR: Wenn NULL dann BLANK
	if isnull(isPackinglistXsl) then isPackinglistXsl = ""
	

	// 02.09.2005: Reine Abrechnungss$$HEX1$$e400$$ENDHEX$$tze werden ignoriert
	// nbilling_status = 2

	// 31.03.2009 HR: $$HEX1$$c400$$ENDHEX$$nderung f$$HEX1$$fc00$$ENDHEX$$r HGK
	// Wenn der Systamschalter lMealExplosionWithBillingonly auf 0 gesetzt ist, dann wie bisher reine Abrechnung raus
	// ansonsten wird der Status in lreckoning $$HEX1$$fc00$$ENDHEX$$bernommen und ausgewertet
	if lMealExplosionWithBillingonly=0 then
		lreckoning	= 0
		
		if dsCenOutMeals.GetItemNumber(i,"nbilling_status") = 2 then continue
	else
		lreckoning = dsCenOutMeals.GetItemNumber(i,"nbilling_status")
	end if
	
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lPLIndexKey			= dsCenOutMeals.GetItemNumber(i,"npackinglist_index_key")

	// 20.01.2012 HR: Wir brauchen hier auch den Abrechnungscode
	choose case dsCenOutMeals.GetItemNumber(i,"nposting_type")
	case 1
		sPostTypeShort ="1"
	case 2
		sPostTypeShort ="2"
	case else
		sPostTypeShort =" "
	end choose

	// 25.05.2010 HR: Falls Schalter vom aufrufenden Programm gesetzt wurde, dann werden wieder die aktuellen Keys ermittelt, ansonsten wie bisher
	if iGetNewDetailKey =1 then
		lPLDetailKey = of_get_detail_key(lPLIndexKey)
	else
		lPLDetailKey = dsCenOutMeals.GetItemNumber(i,"npackinglist_detail_key")
	end if
	
	lPackinglistKind	= dsCenOutMeals.GetItemNumber(i,"npl_kind_key")
	lPackinglistType	= dsCenOutMeals.GetItemNumber(i,"npackinglist_key")
	
	sPackinglist		= dsCenOutMeals.GetItemString(i,"cpackinglist")
	// vorher: sText					= f_get_packinglist_text(lPLIndexKey,datetime(dGenerationDate))
	sText					= dsCenOutMeals.GetItemString(i,"ctext")
	sUnit					= dsCenOutMeals.GetItemString(i,"cunit")
	dcQuantity			= dsCenOutMeals.GetItemDecimal(i,"nquantity")
			
	dcquantity_version =  dsCenOutMeals.GetItemDecimal(i,"nquantity_version") // 30.01.2013 HR: Menge f$$HEX1$$fc00$$ENDHEX$$r Version lesen

	// Customer_PL
	scustomer_pl		= dsCenOutMeals.GetItemString(i,"ccustomer_pl")
	scustomer_pl_text	= dsCenOutMeals.GetItemString(i,"ccustomer_text")

	isPackinglistShortText	= of_ctext_short(sText, dsCenOutMeals.GetItemString(i,"cproduction_text")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005

	if isnull(lPLDetailKey) then
		// 10.08.2009 HR: Falls aus irgend einem Grund die Daten nicht vorhanden sind, dann online holen
		
		  SELECT cen_packinglists.npackinglist_detail_key,   
				cen_packinglist_index.npl_kind_key,   
				cen_packinglists.npackinglist_key,   
				cen_packinglists.ctext,   
				cen_packinglists.cunit,
				cen_packinglists.cdef_storage_location  
		 INTO :lPLDetailKey,   
				:lPackinglistKind,   
				:lPackinglistType,   
				:sText,
				:sUnit,
				:sDefStorageLocation
		 FROM cen_packinglist_index,   
				cen_packinglists  
		WHERE ( cen_packinglists.npackinglist_index_key = cen_packinglist_index.npackinglist_index_key ) and  
				( ( cen_packinglist_index.npackinglist_index_key = :lPLIndexKey ) AND  
				( :dGenerationDate between cen_packinglists.dvalid_from and cen_packinglists.dvalid_to ) )   ;

		of_trace(1,1,"[of_generate_meal_explosion] npackinglist_detail_key is null in dsCenOutMeals for PL "+sPackinglist)
	else
		
		  
		  
		  SELECT cen_packinglists.cdef_storage_location  
		 	INTO :sDefStorageLocation
		 	FROM cen_packinglists  
			WHERE ( cen_packinglists.npackinglist_index_key = :lPLIndexKey ) AND  
						( cen_packinglists.npackinglist_detail_key = :lPLDetailKey )  ;

		
	end if 
	lAction				= 1		// immer beladen (bringst Du)
	
	//lHandlingID			= 1		// f$$HEX1$$fc00$$ENDHEX$$r normale Beladung immer 1

	// 04.02.2009 HR: Unterscheidung welche Art von Beladung
	if dsCenOutMeals.GetItemNumber(i,"nmodule_type")=0 then
		lHandlingID			= 11		// f$$HEX1$$fc00$$ENDHEX$$r Mahlzeitenbeladung
	else
		lHandlingID			= 5		// f$$HEX1$$fc00$$ENDHEX$$r Extrabeladung
	end if
	
	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- START
	is_cclass				=  dsCenOutMeals.GetItemstring(i,"cclass")

	IF 	NOT IsNull(is_cclass) THEN

		// Ermittlung der zu der Klasse geh$$HEX1$$f600$$ENDHEX$$renden Sortiernummer ...
		IF 	NOT of_get_class_number(is_cclass) THEN
			is_cclass 			=	" "
			ii_nclass_number 	=	0		
		END IF
		
	ELSE // => is_cclass IS NULL
		
		is_cclass 			= " "
		ii_nclass_number 	= 0		
		
	END IF // IF 	IsNull(is_cclass) 
	
	ll_nclass_number = ii_nclass_number //07.09.2010 HR: Forecast-Projekt
		
	// 30.04.2009 HR: Wenn keine Gruppierung auf Klasse dan auf 0 setzen
	if ilGroupPlByClass=0 then
		is_cclass 			= " "
		ii_nclass_number 	= 0		
	end if 

	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- ENDE	

	// --------------------------------------------------------------------------------------------------------------------
	// 22.08.2011 HR: Falls die Position keinen  Warenempf$$HEX1$$e400$$ENDHEX$$ger hat, dann nehmen wir ihn von der Beladung oder Flug
	// --------------------------------------------------------------------------------------------------------------------
    	sSalesRel = " " //uo_loading4flight.ds_loadinglist.GetItemstring(j,"csales_rel")
	setnull(sGoodsRecipient) //= uo_loading4flight.ds_loadinglist.GetItemstring(j,"cen_loadinglists_cgoods_recipient")
	
	if isnull(sSalesRel) then sSalesRel=" "
	if isnull(sDefStorageLocation) then sDefStorageLocation=" "
	saccount =  dsCenOutMeals.GetItemString(i,"caccount")

	if isnull(sGoodsRecipient) then 
		if isnull(saccount) then
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, sAccountFight) // 01.10.2012 HR:  Wir brauchen den Kunden-key und nicht den Airline-key
		else
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, saccount) // 01.10.2012 HR:  Wir brauchen den Kunden-key und nicht den Airline-key
		end if
	end if

	// 05.09.2011 HR:
	if isnull(sGoodsRecipient) then sGoodsRecipient="n/a"
	  
	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden noch folgende Werte
	// 					   ben$$HEX1$$f600$$ENDHEX$$tigt (zu der Klassennummer von oben) und 
	//					   anschlie$$HEX1$$df00$$ENDHEX$$end die Bewertungs-Werte ermittelt
	// --------------------------------------------------------------------------------------------------------------------
	 ll_nhandling_key = dsCenOutMeals.GetItemNumber(i,"nhandling_key")
	 ll_nrotation_name_key = dsCenOutMeals.GetItemNumber(i,"nrotation_name_key")
	 ll_nrotation_key = dsCenOutMeals.GetItemNumber(i,"nrotation_key")

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Wir merken uns auch den Abrechnungscode 2
	// --------------------------------------------------------------------------------------------------------------------
	sAdditionalAccount = dsCenOutMeals.GetItemstring(i,"cadditional_account")
	if isnull(sAdditionalAccount) then sAdditionalAccount= " "

	if iFillForcastFields=1 and dsForecast.rowcount()>0 then
		sFind = "(nclass_number = "+string(ll_nclass_number)+" or nclass_number=0)" 
		sFind += " and (nrouting_id = "+string(il_routing_id)+" or nrouting_id=0)" 
		sFind += " and (nroutingplan_index_key  = "+string(il_routingplan_index_key)+" or nroutingplan_index_key=0)"  
		sFind += " and (nhandling_key   = "+string(ll_nhandling_key)+" or nhandling_key=0)" 
		sFind += " and (nrotation_key   = "+string(ll_nrotation_key)+" or nrotation_key=0)" 
		sFind += " and (nrotation_name_key  = "+string(ll_nrotation_name_key)+" or nrotation_name_key=0)" 
		sFind += " and ntype=0" 
		
		lFind = dsForecast.find(sFind,1,dsForecast.rowcount())
				
		if lfind=0 then
			il_FC_Parm1 = 0
			il_FC_Parm2 = 0
			il_FC_Parm3 = 0
			il_FC_Parm_min = 0 

			of_trace(50,50,"[of_generate_meal_explosion] not found sFind = "+sFind )
		else
			il_FC_Parm1 = dsForecast.getitemnumber(lFind,"nparams_key1")
			il_FC_Parm2 = dsForecast.getitemnumber(lFind,"nparams_key2")
			il_FC_Parm3 = dsForecast.getitemnumber(lFind,"nparams_key3")

			of_trace(50,50,"[of_generate_meal_explosion] found sFind = "+sFind )
			
			il_FC_Parm_min = of_min_forcast(il_FC_Parm1, il_FC_Parm2)
			il_FC_Parm_min = of_min_forcast(il_FC_Parm_min, il_FC_Parm3)
			
		end if
	else
		of_trace(50,50,"[of_generate_meal_explosion] not found sFind = "+sFind )

		il_FC_Parm1 = -1
		il_FC_Parm2 = -1
		il_FC_Parm3 = -1
		il_FC_Parm_min = -1 
	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
	// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
	// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
	
		choose case lReckoning
			case 1
				dcQuantity = 0
				dcquantity_version =0 // 06.03.2013 HR:
				
			case 0
				lReckoning = 2
		 end choose

	end if

	//
	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung)
	sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
				string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0" + &
				" and nreckoning =  "+string(lreckoning)	/* 31.03.2009 HR: 0 durch string(lreckoning) ersetzt */ + &
				" and cclass ='" + is_cclass + "' and nclass_number = " + string(ii_nclass_number)  /* TBR 23.04.2004 */ + &
				" and cpost_type_short = '"+sPostTypeShort+"' " /* 20.01.2012 HR: Abrechnungskennzeichen einbeziehenn */+ &
				" and cgoods_recipient ='"+sGoodsRecipient+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ +&
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */
				// 26.04.2004 
				//" and nhandling_id = "+string(lHandlingID) + &  //find m$$HEX1$$fc00$$ENDHEX$$sste noch erweitert werden, wird aber in Schritt 1 noch nicht getan um doppelte SL zu vermeiden

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if ii_GroupPlBySslZblAc2 = 1 then
		sFind += " and cloadinglist = '"+sfromloadinglist+"'"
		sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
	end if
	
	// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
	if dsCenOutMeals.GetItemNumber(i,"nlocal_sub")=1 and dsCenOutMeals.GetItemString(i,"cpackinglist_ori") =  dsCenOutMeals.GetItemString(i,"cpackinglist") then
		ii_NPARTIALSUBSTITUTION = 1
	else
		ii_NPARTIALSUBSTITUTION = 0
	end if
				
	lFind = dsCenOutMaster.Find(sFind,1,dsCenOutMaster.RowCount())

	if lFind > 0 then
		// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
		of_trace(50,50,"[of_generate_meal_explosion]  -> QUANTITY ADDED")  

		// Packinglist gibt's schon => kumulieren
		dcOldQuantity	= dsCenOutMaster.GetItemDecimal(lFind,"nquantity")
		dcQuantity		= dcOldQuantity + dcQuantity
		dsCenOutMaster.SetItem(lFind,"nquantity", dcQuantity)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMaster.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + dcquantity_version
		dsCenOutMaster.SetItem(lFind,"nquantity_version", dcquantity_version)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 09.09.2010 HR: 
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutMaster.SetItem(lFind,"nparams_key1", of_min_forcast(il_FC_Parm1, dsCenOutMaster.GetItemNumber(lFind,"nparams_key1")))
		dsCenOutMaster.SetItem(lFind,"nparams_key2", of_min_forcast(il_FC_Parm2, dsCenOutMaster.GetItemNumber(lFind,"nparams_key2")))
		dsCenOutMaster.SetItem(lFind,"nparams_key3", of_min_forcast(il_FC_Parm3, dsCenOutMaster.GetItemNumber(lFind,"nparams_key3")))
		dsCenOutMaster.SetItem(lFind,"nparams_min",of_min_forcast(dsCenOutMaster.GetItemNumber(lFind,"nparams_key1"), dsCenOutMaster.GetItemNumber(lFind,"nparams_key2")))
		dsCenOutMaster.SetItem(lFind,"nparams_min",of_min_forcast(dsCenOutMaster.GetItemNumber(lFind,"nparams_min"), dsCenOutMaster.GetItemNumber(lFind,"nparams_key3")))
		
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		if ii_NPARTIALSUBSTITUTION = 1 then
			dsCenOutMaster.setitem(lFind,"NPARTIALSUBSTITUTION", ii_NPARTIALSUBSTITUTION)
		end if

	else
		// Packinglist gibt's noch nicht => insert
		of_insert_cen_out_master(1)

		// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
		of_trace(50,50,"[of_generate_meal_explosion] -> Insert New")
	end if
next
// 14.08.2009 HR: Protokoll eingef$$HEX1$$fc00$$ENDHEX$$gt
of_trace(50,50,"[of_generate_meal_explosion] dsCenOutMaster.rowcount() "+string(dsCenOutMaster.rowcount()))
return 0

end function

public function long of_get_detail_key (long arg_index_key);//
// of_get_detail_key
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
	lDetailKey	= -1
	return lDetailKey
end if

return lDetailKey

end function

public function boolean of_check_global_explosion ();// ==========================================================================
//
// of_check_global_explosion
//
// Sollte es einen Job zur St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r einen Mandanten geben
// (Job-ID 110), dann mu$$HEX2$$df002000$$ENDHEX$$die Aufl$$HEX1$$f600$$ENDHEX$$sung cen_out_master -> cen_out_detail
// nicht je Airline und Betrieb durchgef$$HEX1$$fc00$$ENDHEX$$hrt werden.
//
// ==========================================================================
long	lcnt


select count(*)
  into :lcnt
  from loc_jobs
 where njob_type = 110;
 
if lcnt > 0 then
	//
	// Es gibt den "globalen" Matdispo-Job
	//
	of_trace(1,10,"[of_check_global_explosion] Found global Packing List Explosion!")
	return true
else
	//
	// Es gibt keinen "globalen" Matdispo-Job, also 
	//
	of_trace(1,10,"[of_check_global_explosion] Global Packing List Explosion not found!")
	return false
end if

end function

public function integer of_generate_sub_pl_explosion (long arg_row);// =============================================================================
//
// of_generate_sub_pl_explosion
//
// =============================================================================
//
// Ermittlung der Sub-Packing-Lists
//
// In dsCenOutMasterLevel1 befinden sich die Packing Lists aus der Beladung.
// Diese werden jetzt nacheinander abgearbeitet. Sub-Packing-Lists werden in 
// dsCenOutMasterLevelN gespeichert.
//
//   21.04.2004: nreckoning ber$$HEX1$$fc00$$ENDHEX$$cksichtigen!
//   26.08.2004: St$$HEX1$$fc00$$ENDHEX$$cklistentypen ber$$HEX1$$fc00$$ENDHEX$$cksichtigen!
//   30.08.2005: PL-Key der $$HEX1$$fc00$$ENDHEX$$bergeordneten St$$HEX1$$fc00$$ENDHEX$$ckliste durchreichen
//               => Erweiterung der Kumulierung
//   17.05.2006:   Durchreichen von Status nreckoning (A/P/I) und Reserven
//
//   10.09.2009: Account Code & Key
//   16.04.2012 mnu: bestimmen customer_pl erweitert
//   18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich Schluesselfelder angepast
//   30.01.2013 Versionsberechnung
// =============================================================================
long     	 		j,i
long     	 		lFind
long     	 		lRow
LONGLONG 		lSequence  //  18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast
Long      			lAncestorKey
string    			sFind
datetime  		dttimestamp
long      			lCheckArea
long      			lLevel
decimal   		dcOldReserve
integer   			itest
// 23.04.2009 HR: [18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast]
LONGLONG 		lLocalMasterDetailKey, lLocalAncesterDetailKey, lLocalDetailKey
// 24.04.2009 TBR
String    			ls_cclass
Integer   			li_nclass_number
String				ls_PL, ls_Text
string 			lsAccount
long 				llaccount_key

of_trace(1,10,"Start generate Sub-Packing-List-Explosion for flight " + sAirlineCode + " " + string(lFlightNumber) + " , " + &
               string(dgenerationdate) + "! [of_generate_sub_pl_explosion]")

dttimestamp = datetime(today(),now())

// =============================================================================
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung aller in cen_out_master enthaltenen Packing Lists
//
// =============================================================================
for j = 1 to dsCenOutMasterLevel1.RowCount()
   
	lPLIndexKey       	= dsCenOutMasterLevel1.GetItemNumber(j,"npl_index_key")
	lPLDetailKey      	= dsCenOutMasterLevel1.GetItemNumber(j,"npl_detail_key")
	lTransaction      	= dsCenOutMasterLevel1.GetItemNumber(j,"ntransaction")
	iStatus           		= dsCenOutMasterLevel1.GetItemNumber(j,"nstatus")
	dcQuantity        	= dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity")
	dcquantity_version	= dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity_version")// 30.01.2013 HR:
	lMasterIndexKey	= lPLIndexKey
	
	// 23.04.2009 HR:
	lMasterDetailKey	=   dsCenOutMasterLevel1.GetItemNumber(j,"ndetail_key")
	lAncesterDetailKey	=   dsCenOutMasterLevel1.GetItemNumber(j,"ndetail_key")

	// 24.04.2009 TBR
	ls_cclass            	=   dsCenOutMasterLevel1.GetItemString(j,"cclass")
	li_nclass_number	=   dsCenOutMasterLevel1.GetItemNumber(j,"nclass_number")

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl 		= dsCenOutMasterLevel1.GetItemString(j,"cpackinglist_xsl")

	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden hier die Bewertungs-
	//                          Werte erst mal auf -1 gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	il_FC_Parm1		= dsCenOutMasterLevel1.GetItemNumber(j,"nparams_key1")
	il_FC_Parm2 		= dsCenOutMasterLevel1.GetItemNumber(j,"nparams_key2")
	il_FC_Parm3 		= dsCenOutMasterLevel1.GetItemNumber(j,"nparams_key3")
	il_FC_Parm_min 	= dsCenOutMasterLevel1.GetItemNumber(j,"nparams_min")


	// nreckoning wird vom "Master" geholt und dementsprechend gesetzt!
	lReckoning      = dsCenOutMasterLevel1.GetItemNumber(j,"nreckoning")
	if isnull(lReckoning) then lReckoning = 0
	
	// 31.08.05   Workstation Key vom Master bereits jetzt ermitteln und 
	//            bei den enthaltenen PLs setzen
	sFind =    "npackinglist_index_key = " + string(lPLIndexKey) + &
				" and ctime_from <= '" + string(tdepartureTime,"hh:mm") + &
				"' and ctime_to >= '" + string(tdepartureTime,"hh:mm") + "'"
	lFind = dsLocalWorkstations.Find(sFind,1,dsLocalWorkstations.RowCount())
	
	if lFind > 0 then
		lMasterAreaKey          = dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
		lMasterWorkstationKey   = dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
		iReservePercent         = dsLocalWorkstations.GetItemNumber(lFind,"npercent")

		// Reserve wird zun$$HEX1$$e400$$ENDHEX$$chst nicht durchgereicht, da dies ungewollte Folgen haben k$$HEX1$$f600$$ENDHEX$$nnte
		//dcMasterReserve         = 0
		if isnull(iReservePercent) then iReservePercent = 0 // fixe Menge

		// 17.05.06 Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		dcMasterReserve         		= dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
		// 30.01.2013 HR:
		dcMasterReserve_version	= dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
		// Problem: Per Default werden St$$HEX1$$fc00$$ENDHEX$$cklisten in der Bereichszuordnung mit Menge 0 und 
		// Reserve % angelegt. Dann w$$HEX1$$fc00$$ENDHEX$$rde der % alle fixen Mengen der unteren Ebenen zu % 
		// umwandeln...
		// L$$HEX1$$f600$$ENDHEX$$sung am 04.07.06: Pr$$HEX1$$fc00$$ENDHEX$$fung ob % = 1 und nday = 0 ist
		if iReservePercent = 1 and dcMasterReserve = 0 then
			iReservePercent = 0
		end if
	else
		lMasterAreaKey            		= 0
		lMasterWorkstationKey   		= 0
		dcMasterReserve         		= 0
		dcMasterReserve_version 	= 0	// 30.01.2013 HR:
		iReservePercent         		= 0
	end if
	
	// 17.05.06 Jetzt werden bereits hier die Reserven gesetzt!
	dsCenOutMasterLevel1.SetItem(j,"nreserve",dcMasterReserve)
	dsCenOutMasterLevel1.SetItem(j,"nreserve_version",dcMasterReserve_version)// 30.01.2013 HR:
	dsCenOutMasterLevel1.SetItem(j,"npercent",iReservePercent)

	// --------------------------------------------------------------------------------------------------------------------
	// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	sSalesRel 				= dsCenOutMasterLevel1.GetItemstring(j,"csales_rel")
	sDefStorageLocation	= dsCenOutMasterLevel1.GetItemstring(j,"cdef_storage_location")
	sGoodsRecipient 		= dsCenOutMasterLevel1.GetItemstring(j,"cgoods_recipient")

	// 01.09.2005   Rekursions-Level setzen
	dsCenOutMasterLevel1.SetItem(j,"nlevel",1)
	
	// 31.08.2011 HR: Abrechnungskennzeichen mit kopieren
	sPostTypeShort 		= dsCenOutMasterLevel1.GetItemstring(j,"cpost_type_short")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR:Es kann sein, dass wir auch nach Loadinglist und Abrechnungscode2 gruppieren m$$HEX1$$fc00$$ENDHEX$$ssen
	// --------------------------------------------------------------------------------------------------------------------
	sfromloadinglist 		= dsCenOutMasterLevel1.GetItemString(j,"cloadinglist")
	sAdditionalAccount 	= dsCenOutMasterLevel1.GetItemString(j,"cadditional_account")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 11.06.2012 HR: Account auch nach unten weiter$$HEX1$$fc00$$ENDHEX$$bergeben
	// --------------------------------------------------------------------------------------------------------------------
	lsAccount 				= dsCenOutMasterLevel1.GetItemString(j,"caccount")
	llaccount_key 			= dsCenOutMasterLevel1.GetItemNumber(j,"naccount_key")

	// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
	ii_NPARTIALSUBSTITUTION	= dsCenOutMasterLevel1.GetItemNumber(j,"NPARTIALSUBSTITUTION")

	if of_resolve_packinglist(lPLIndexKey, dcQuantity, 2, lReckoning, dcMasterReserve, iReservePercent, lMasterAreaKey, lMasterWorkstationKey, lMasterDetailKey, lAncesterDetailKey, ls_cclass, li_nclass_number, sSalesRel, sDefStorageLocation, sGoodsRecipient, lsAccount, llaccount_key, dcquantity_version, dcMasterReserve_version) <> 0 then
		return -1
	end if
next
//f_print_datastore(dsCenOutMasterLevel1)

// =============================================================================
// R$$HEX1$$fc00$$ENDHEX$$ck$$HEX1$$fc00$$ENDHEX$$bertragung und Kumulierung aller Level von 
// dsCenOutMasterLevelN nach dsCenOutMasterLevel1
// =============================================================================
for j = 1 to dsCenOutMasterLevelN.RowCount()
	lPLIndexKey         			= dsCenOutMasterLevelN.GetItemNumber(j,"npl_index_key")
	lPLDetailKey      			= dsCenOutMasterLevelN.GetItemNumber(j,"npl_detail_key")
	lAncestorKey      			= dsCenOutMasterLevelN.GetItemNumber(j,"nancestor_index_key")
	dcQuantity         			= dsCenOutMasterLevelN.GetItemDecimal(j,"nquantity")
	dcQuantity_version		= dsCenOutMasterLevelN.GetItemDecimal(j,"nquantity_version") // 30.01.2013 HR:
	lReckoning         			= dsCenOutMasterLevelN.GetItemNumber(j,"nreckoning")
	if isnull(lReckoning) then lReckoning = 0
	lPackinglistKind   			= dsCenOutMasterLevelN.GetItemNumber(j,"npl_kind_key")
	lPackinglistType   			= dsCenOutMasterLevelN.GetItemNumber(j,"npackinglist_key")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl 				= dsCenOutMasterLevelN.GetItemString(j,"cpackinglist_xsl")

	lMasterIndexKey         	= dsCenOutMasterLevelN.GetItemNumber(j,"nmaster_index_key")
	lMasterAreaKey            	= dsCenOutMasterLevelN.GetItemNumber(j,"narea_key")
	lMasterWorkstationKey   	= dsCenOutMasterLevelN.GetItemNumber(j,"nworkstation_key")
	dcMasterReserve         	= dsCenOutMasterLevelN.GetItemDecimal(j,"nreserve")
	dcMasterReserve_version = dsCenOutMasterLevelN.GetItemDecimal(j,"nreserve_version") // 30.01.2013 HR:
	
	lLevel                  			= dsCenOutMasterLevelN.GetItemDecimal(j,"nlevel")
	iReservePercent         	= dsCenOutMasterLevelN.GetItemNumber(j,"npercent")
   
	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden hier die Bewertungs-
	//                          Werte erst mal auf -1 gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	il_FC_Parm1			= dsCenOutMasterLevelN.GetItemNumber(j,"nparams_key1")
	il_FC_Parm2 		= dsCenOutMasterLevelN.GetItemNumber(j,"nparams_key2")
	il_FC_Parm3 		= dsCenOutMasterLevelN.GetItemNumber(j,"nparams_key3")
	il_FC_Parm_min 	= dsCenOutMasterLevelN.GetItemNumber(j,"nparams_min")
	
	if lPLIndexKey = 257828 then // Salat 17.05.2006
		i++
	end if
	
	// 23.04.2009 HR:
	lLocalMasterDetailKey   	=   dsCenOutMasterLevelN.GetItemNumber(j,"nmaster_detail_key")
	lLocalAncesterDetailKey 	=   dsCenOutMasterLevelN.GetItemNumber(j,"nancestor_detail_key")
	lLocalDetailKey 			= dsCenOutMasterLevelN.GetItemNumber(j,"ndetail_key")
	
	// 24.04.2009 TBR
	ls_cclass            	=   dsCenOutMasterLevelN.GetItemString(j,"cclass")
	li_nclass_number 	=   dsCenOutMasterLevelN.GetItemNumber(j,"nclass_number")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	sSalesRel 				= dsCenOutMasterLevelN.GetItemstring(j,"csales_rel")
	sDefStorageLocation	= dsCenOutMasterLevelN.GetItemstring(j,"cdef_storage_location")
	sGoodsRecipient 		= dsCenOutMasterLevelN.GetItemstring(j,"cgoods_recipient")

	// 31.08.2011 HR: Abrechnungskennzeichen mit kopieren
	sPostTypeShort 		= dsCenOutMasterLevelN.GetItemstring(j,"cpost_type_short")

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR:Es kann sein, dass wir auch nach Loadinglist und Abrechnungscode2 gruppieren m$$HEX1$$fc00$$ENDHEX$$ssen
	// --------------------------------------------------------------------------------------------------------------------
	sfromloadinglist 	 = dsCenOutMasterLevelN.GetItemString(j,"cloadinglist")
	sAdditionalAccount = dsCenOutMasterLevelN.GetItemString(j,"cadditional_account")

	// --------------------------------------------------------------------------------------------------------------------
	// 22.11.2012 HR: NPORTION muss auch $$HEX1$$fc00$$ENDHEX$$bertragen werden
	// --------------------------------------------------------------------------------------------------------------------
	dcPortion				 = dsCenOutMasterLevelN.GetItemDecimal(j,"nPortion")

	// --------------------------------------------------------------------------------------------------------------------
	// 19.03.2013 HR: F$$HEX1$$fc00$$ENDHEX$$llen des Zeigers auf das Produktionszeitfensters
	// --------------------------------------------------------------------------------------------------------------------
	il_pltimeframe_index 	= dsCenOutMasterLevelN.GetitemNumber(j, "npltimeframe_index")
	id_prod_date 			= date(dsCenOutMasterLevelN.getItemDatetime(j, "dprod_date"))
	
	// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
	ii_NPARTIALSUBSTITUTION	= dsCenOutMasterLevelN.GetItemNumber(j,"NPARTIALSUBSTITUTION")
	isPackinglistShortText 		= dsCenOutMasterLevelN.GetItemString(j,"ctext_short")

	// Increment oder Insert
	//
	// Dies ist die Stelle, an der der Grad der Kumulierung f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
	// entschieden wird.
	//
	// 30.08.05: Muss noch erweitert werden um lMasterIndexKey
	// 08.05.07: lMasterIndexKey war noch nicht die L$$HEX1$$f600$$ENDHEX$$sung aller Probleme
	//           lAncestorKey ist der IndexKey der direkt $$HEX1$$fc00$$ENDHEX$$bergeordneten SL
	sFind = "npl_type = " + string(lPltype) + " and npl_index_key = " + string(lPLIndexKey) + &
				" and npl_detail_key = " + string(lPLDetailKey) + &
				" and nreckoning = " + string(lReckoning)   + & 
				" and nmaster_index_key = " + string(lMasterIndexKey)   + & 
				" and nancestor_index_key = " + string(lAncestorKey) + &
				" and cclass ='" + is_cclass + "' and nclass_number = " + string(ii_nclass_number)  /* TBR 23.04.2004 */   +   &      
				" and csales_rel ='" + sSalesRel + "'" /* HR 24.03.2011 */ + &
				" and cpost_type_short = '"+sPostTypeShort+"' " /* 31.08.2011 HR: Abrechnungskennzeichen einbeziehenn */+ &
				" and cgoods_recipient ='"+sGoodsRecipient+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ + &
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if ii_GroupPlBySslZblAc2 = 1 then
		sFind += " and cloadinglist = '"+sfromloadinglist+"'"
		sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
	end if
				
// 08.01.2015 HR: Beim Zur$$HEX1$$fc00$$ENDHEX$$ckkopieren der Aufl$$HEX1$$f600$$ENDHEX$$sung schauen wir nicht mehr, ob es eine SL schon gibt, sondern kopieren immer
//	lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())
	lFind = 0
	
	if lFind > 0 then
		// Packinglist gibt's schon => kumulieren
		dcOldQuantity   = dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
		dcOldQuantity   = dcOldQuantity + dcQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcOldQuantity)

		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r Version
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity   = dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcOldQuantity   = dcOldQuantity + dcQuantity_version
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcOldQuantity)
		
		dsCenOutMasterLevel1.SetItem(lFind,"nstatus",98)

		// 17.05.2006 Auch Reserven zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
		dcOldReserve   = dsCenOutMasterLevel1.GetItemDecimal(lFind,"nreserve")
		dcOldReserve   = dcOldReserve + dcMasterReserve
		dsCenOutMasterLevel1.SetItem(lFind,"nreserve", dcOldReserve)

		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r Version
		// --------------------------------------------------------------------------------------------------------------------
		dcOldReserve   = dsCenOutMasterLevel1.GetItemDecimal(lFind,"nreserve_version")
		dcOldReserve   = dcOldReserve + dcMasterReserve_version
		dsCenOutMasterLevel1.SetItem(lFind,"nreserve_version", dcOldReserve)
		
		// 23.04.2009 HR: Wenn kummuliert wird, dann muss der ancester_detail_key f$$HEX1$$fc00$$ENDHEX$$r alle evtl. untergeordnete SL angepa$$HEX1$$df00$$ENDHEX$$t werden.
		for i=1 to dsCenOutMasterLevel1.rowcount()
			if (   dsCenOutMasterLevel1.GetItemNumber(i,"nmaster_detail_key")=lLocalMasterDetailKey) and &
				(dsCenOutMasterLevel1.GetItemNumber(i,"nancestor_detail_key")= lLocalAncesterDetailKey) then
				
				dsCenOutMasterLevel1.SetItem(i,"nancestor_detail_key", dsCenOutMasterLevel1.GetItemNumber(lFind,"nancestor_detail_key"))
			end if
		next
		
		// 23.04.2009 HR: Wenn kummuliert wird, dann muss der ancester_detail_key f$$HEX1$$fc00$$ENDHEX$$r alle evtl. untergeordnete SL angepa$$HEX1$$df00$$ENDHEX$$t werden.
		for i=1 to dsCenOutMasterLevelN.rowcount()
			if (   dsCenOutMasterLevelN.GetItemNumber(i,"nmaster_detail_key")=lLocalMasterDetailKey) and &
				(dsCenOutMasterLevelN.GetItemNumber(i,"nancestor_detail_key")= lLocalAncesterDetailKey) then
				
				dsCenOutMasterLevelN.SetItem(i,"nancestor_detail_key", dsCenOutMasterLevel1.GetItemNumber(lFind,"nancestor_detail_key"))
			end if
		next
	else
		lRow = dsCenOutMasterLevel1.InsertRow(0)
		dsCenOutMasterLevel1.SetItem(lRow,"cpart_unit",sPlant) // 14.03.2012 HR: Partitionierung nach Betrieb
		dsCenOutMasterLevel1.SetItem(lRow,"nlevel_of_explosion",0)
		dsCenOutMasterLevel1.SetItem(lRow,"ntransaction",lTransaction)
		dsCenOutMasterLevel1.SetItem(lRow,"nresult_key",lResultKey)
		dsCenOutMasterLevel1.SetItem(lRow,"npl_type",lPLType)
		dsCenOutMasterLevel1.SetItem(lRow,"npl_index_key",lPLIndexKey)
		dsCenOutMasterLevel1.SetItem(lRow,"npl_detail_key",lPLDetailKey)
		dsCenOutMasterLevel1.SetItem(lRow,"nancestor_index_key", lAncestorKey)
		dsCenOutMasterLevel1.SetItem(lRow,"cpackinglist",dsCenOutMasterLevelN.GetItemString(j,"cpackinglist"))
		dsCenOutMasterLevel1.SetItem(lRow,"ctext",dsCenOutMasterLevelN.GetItemString(j,"ctext"))
		dsCenOutMasterLevel1.SetItem(lRow,"cunit",dsCenOutMasterLevelN.GetItemString(j,"cunit"))   // Einheit
		dsCenOutMasterLevel1.SetItem(lRow,"nquantity",dcQuantity)
		dsCenOutMasterLevel1.SetItem(lRow,"nquantity_version",dcQuantity_version) // 30.01.2013 HR:
		dsCenOutMasterLevel1.SetItem(lRow,"naction",1)
		dsCenOutMasterLevel1.SetItem(lRow,"nhandling_id",1)   // Handling-ID = 1
		dsCenOutMasterLevel1.SetItem(lRow,"dtimestamp",dttimestamp)
		if lPLType = 1 then
			dsCenOutMasterLevel1.SetItem(lRow,"nfreq_key",0)
		else
			dsCenOutMasterLevel1.SetItem(lRow,"nfreq_key",iDay)
		end if
		dsCenOutMasterLevel1.SetItem(lRow,"nstatus",99)
		dsCenOutMasterLevel1.SetItem(lRow,"nreckoning",lReckoning)
		dsCenOutMasterLevel1.SetItem(lRow,"npl_kind_key",lPackinglistKind)
		dsCenOutMasterLevel1.SetItem(lRow,"npackinglist_key",lPackinglistType)
		dsCenOutMasterLevel1.SetItem(lRow,"nmaster_index_key",lMasterIndexKey)
		dsCenOutMasterLevel1.SetItem(lRow,"narea_key",lMasterAreaKey)
		dsCenOutMasterLevel1.SetItem(lRow,"nworkstation_key",lMasterWorkstationKey)
		dsCenOutMasterLevel1.SetItem(lRow,"nreserve",dcMasterReserve)
		dsCenOutMasterLevel1.SetItem(lRow,"nreserve_version",dcMasterReserve_version) // 30.01.2013 HR:
		dsCenOutMasterLevel1.SetItem(lRow,"nlevel",lLevel)
		dsCenOutMasterLevel1.SetItem(lRow,"npercent",iReservePercent)

		// --------------------------------------------------------------------------------------------------------------------
		// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden hier die Bewertungs-
		//                          Werte erst mal auf -1 gesetzt
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutMasterLevel1.SetItem(lRow,"nparams_key1", il_FC_Parm1)
		dsCenOutMasterLevel1.SetItem(lRow,"nparams_key2", il_FC_Parm2)
		dsCenOutMasterLevel1.SetItem(lRow,"nparams_key3", il_FC_Parm3)
		dsCenOutMasterLevel1.SetItem(lRow,"nparams_min", il_FC_Parm_min)
		
		// 23.04.2009 HR:
		dsCenOutMasterLevel1.SetItem(lRow,"nmaster_detail_key",lLocalMasterDetailKey )
		dsCenOutMasterLevel1.SetItem(lrow,"nancestor_detail_key", lLocalAncesterDetailKey)
		dsCenOutMasterLevel1.SetItem(lrow,"ndetail_key", lLocalDetailKey)
		
		// 24.04.2009 TBR:
		dsCenOutMasterLevel1.SetItem(lRow,"cclass",ls_cclass)
		dsCenOutMasterLevel1.SetItem(lRow,"nclass_number",li_nclass_number)      
		
		// --------------------------------------------------------------------------------------------------------------------
		// 14.08.2012 HR: Alte Funktion wieder aktiviert / Neue auskommentiert
		// --------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------
		// 17.06.2009 customer_pl ccustomer_text hinzu
		dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl", dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl"))
		dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl_text", dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl_text"))
		// ----------------------------------------------------------------------------------------
		// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
		// ----------------------------------------------------------------------------------------
		String   	ls_Temp
		If il_FillEmptyCustomerPL = 1 Then
			ls_temp = dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl")
			
			If IsNULL(ls_temp) OR Trim(ls_temp) = "" Then
				dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl", dsCenOutMasterLevelN.GetItemString(j,"cpackinglist"))
			End If
			
			ls_Temp = dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl_text")
			
			If IsNULL(ls_temp) OR Trim(ls_temp) = "" Then
				dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl_text", dsCenOutMasterLevelN.GetItemString(j,"ctext"))
			End If
		End If

//		// 16.04.2012 mnu: funktion vorschalten vor instance-werte
//		if  of_get_customer_id(lPLIndexKey, lPLDetailKey, lAirlineKey, ls_PL, ls_Text, false) <= 0 then
//			// nix anderes gefunden: nimm die bereits gelesenen werte
//			ls_PL = dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl")
//			ls_Text = dsCenOutMasterLevelN.GetItemString(j,"ccustomer_pl_text")
//		end if
//		dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl", ls_PL)
//		dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl_text", ls_Text)
//		// ----------------------------------------------------------------------------------------
//		// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
//		// ----------------------------------------------------------------------------------------
//		If il_FillEmptyCustomerPL = 1 Then
//			If IsNULL(ls_PL) OR Trim(ls_PL) = "" Then
//				dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl", dsCenOutMasterLevelN.GetItemString(j,"cpackinglist"))
//			End If
//			If IsNULL(ls_Text) OR Trim(ls_Text) = "" Then
//				dsCenOutMasterLevel1.SetItem(lRow,"ccustomer_pl_text", dsCenOutMasterLevelN.GetItemString(j,"ctext"))
//			End If
//		End If
//		// ende 16.04.2012 mnu
//	
		// --------------------------------------------------------------------------------------------------------------------
		// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutMasterLevel1.SetItem(lRow,"csales_rel",sSalesRel)
		dsCenOutMasterLevel1.SetItem(lRow,"cdef_storage_location",sDefStorageLocation)
		dsCenOutMasterLevel1.SetItem(lRow,"cgoods_recipient",sGoodsRecipient)

		// 31.08.2011 HR: Abrechnungskennzeichen mit kopieren
		dsCenOutMasterLevel1.SetItem(lRow,"cpost_type_short",sPostTypeShort)
		
		// ----------------------------------------------------------------------------------------
		// 10.09.2009 Account Code & Key		 
		dsCenOutMasterLevel1.SetItem(lRow,"caccount", dsCenOutMasterLevelN.GetItemString(j,"caccount"))
		dsCenOutMasterLevel1.SetItem(lRow,"naccount_key", dsCenOutMasterLevelN.GetItemNumber(j,"naccount_key"))
		// ----------------------------------------------------------------------------------------

		// 06.06.2012 HR:  Loadinglist und Abrechnungscode2 $$HEX1$$fc00$$ENDHEX$$bernehmen
		dsCenOutMasterLevel1.SetItem(lRow,"cloadinglist",sfromloadinglist)
		dsCenOutMasterLevel1.SetItem(lRow,"cadditional_account",sAdditionalAccount)

		// --------------------------------------------------------------------------------------------------------------------
		// 22.11.2012 HR: NPORTION muss auch $$HEX1$$fc00$$ENDHEX$$bertragen werden
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutMasterLevel1.SetItem(lRow,"nPortion",dcPortion)

		// --------------------------------------------------------------------------------------------------------------------
		// 19.03.2013 HR: F$$HEX1$$fc00$$ENDHEX$$llen des Zeigers auf das Produktionszeitfensters
		// --------------------------------------------------------------------------------------------------------------------
		dsCenOutMasterLevel1.setitem(lRow,"npltimeframe_index", il_pltimeframe_index)
		dsCenOutMasterLevel1.setitem(lRow,"dprod_date", id_prod_date)

		dsCenOutMasterLevel1.SetItem(lRow,"cpackinglist_xsl",isPackinglistXsl)  // 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
		
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		dsCenOutMasterLevel1.SetItem(lRow,"NPARTIALSUBSTITUTION", ii_NPARTIALSUBSTITUTION)
		dsCenOutMasterLevel1.SetItem(lRow,"ctext_short",isPackinglistShortText)
	end if
next

//f_print_datastore(dsCenOutMasterLevelN)

// =============================================================================
//
// Lokale Bereichszuordnung setzen und Verteilung der Sequences
// 17.05.2006   Dividieren der Einheiten "GR" und "ML"
// 29.11.2007   Das Dividieren erfolgt leider ein wenig sp$$HEX1$$e400$$ENDHEX$$t, da durch Multiplikation $$HEX1$$fc00$$ENDHEX$$ber mehrere Ebenen riesige Summen entstehen
//
// =============================================================================
for j = 1 to dsCenOutMasterLevel1.RowCount()
	lPLIndexKey   = dsCenOutMasterLevel1.GetItemNumber(j,"npl_index_key")

	// Lokale Daten (Bereiche und Reserven) rausfuscheln
	sFind =    "npackinglist_index_key = " + string(lPLIndexKey) + &
				" and ctime_from <= '" + string(tdepartureTime,"hh:mm") + &
				"' and ctime_to >= '" + string(tdepartureTime,"hh:mm") + "'"
	lFind = dsLocalWorkstations.Find(sFind,1,dsLocalWorkstations.RowCount())
	
	if lFind > 0 then
		// falls explizit eine Zuordnung f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste gefunden wird
		lArea_Key         		= dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
		lWorkstation_Key   = dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
		dcReserve         	= dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
		iReservePercent   	= dsLocalWorkstations.GetItemNumber(lFind,"npercent")
		
		if isnull(iReservePercent) then iReservePercent = 0
	
		dsCenOutMasterLevel1.SetItem(j,"narea_key",lArea_Key)
		dsCenOutMasterLevel1.SetItem(j,"nworkstation_key",lWorkstation_Key)
	
		// 17.05.2006 Das w$$HEX1$$e400$$ENDHEX$$re an dieser Stelle nicht mehr richtig!!!
		//dsCenOutMasterLevel1.SetItem(j,"nreserve",dcReserve)
		//dsCenOutMasterLevel1.SetItem(j,"npercent",iReservePercent)
	else
		//      lArea_Key         = 0
		//      lWorkstation_Key   = 0
		//      dcReserve          = 0
	end if   
	
	if isnull(dsCenOutMasterLevel1.GetItemNumber(j,"narea_key")) then
		dsCenOutMasterLevel1.SetItem(j,"narea_key",0)
	end if
	
	if isnull(dsCenOutMasterLevel1.GetItemNumber(j,"nworkstation_key")) then
		dsCenOutMasterLevel1.SetItem(j,"nworkstation_key",0)
	end if

	if isnull(dsCenOutMasterLevel1.GetItemNumber(j,"nreserve")) then
		dsCenOutMasterLevel1.SetItem(j,"nreserve",0)
	end if

	// Nur wenn nDetailKey leer ist (insert)
	if dsCenOutMasterLevel1.GetItemNumber(j,"ndetail_key") = 0 or &
		isnull(dsCenOutMasterLevel1.GetItemNumber(j,"ndetail_key")) then
		
		// --------------------------------------------------------------------------------------------------------------------
		// 26.02.2013 HR: Umstellung der Sequence auf LONGLONG
		// --------------------------------------------------------------------------------------------------------------------
		lSequence = f_Sequence_ll("seq_cen_out_master", sqlca)
		If lSequence = -1 Then
			return -1
		end if
		dsCenOutMasterLevel1.SetItem(j,"ndetail_key",lSequence)
	end if
	
	// --------------------------------------------------------------------------------
	// 11.09.2009 HR: Umrechnung soll nur noch bei gesetztem Schalter erfolgen
	//                         (Schalter wird pro Durchlauf nur beim ersten Mal gelesen)
	// --------------------------------------------------------------------------------
	if iConvertGtoKG = -1 then // Schalter noch nicht gelesen, dann erst mal lesen
		iConvertGtoKG = integer(of_cen_profilestring("OnlineExplosion","ConvertGtoKG","1",sClient)	)
	end if
	
	if iConvertGtoKG = 1 then
		// 17.05.2006   Dividieren der Einheiten "GR" und "ML"
		sUnit = dsCenOutMasterLevel1.GetItemString(j,"cunit")
		
		if sUnit = "GR" then
			dcOldQuantity = dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity")
			dcQuantity = dcOldQuantity / 1000
			dsCenOutMasterLevel1.SetItem(j,"nquantity",dcQuantity)

			// --------------------------------------------------------------------------------------------------------------------
			// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r Version
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity = dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity_version")
			dcQuantity = dcOldQuantity / 1000
			dsCenOutMasterLevel1.SetItem(j,"nquantity_version",dcQuantity)

			dsCenOutMasterLevel1.SetItem(j,"cunit","KG")
		end if
	
		if sUnit = "ML" then
			dcOldQuantity = dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity")
			dcQuantity = dcOldQuantity / 1000
			dsCenOutMasterLevel1.SetItem(j,"nquantity",dcQuantity)
			dsCenOutMasterLevel1.SetItem(j,"cunit","LT")
	
			// --------------------------------------------------------------------------------------------------------------------
			// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r Version
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity = dsCenOutMasterLevel1.GetItemDecimal(j,"nquantity_version")
			dcQuantity = dcOldQuantity / 1000
			dsCenOutMasterLevel1.SetItem(j,"nquantity_version",dcQuantity)
		end if
	end if
next
//f_print_datastore(dsCenOutMasterLevel1)

return 0

end function

public function boolean of_start_for_packinglists (string arg_client, string arg_unit, date arg_generationdate, long arg_airline);// =============================================================================
//
// of_start_for_packinglists
//
// f$$HEX1$$fc00$$ENDHEX$$hrt komplette Matdispo f$$HEX1$$fc00$$ENDHEX$$r eine Liste von Packing Lists aus
//
// =============================================================================
//
// Datum			Aktion
// -----------------------------------------------------------------------------
//	02.09.2005	Neu erstellt um die M$$HEX1$$f600$$ENDHEX$$glichkeit einer beliebigen PL-Aufl$$HEX1$$f600$$ENDHEX$$sung 
//					zu schaffen
//
// =============================================================================
long					i

ibPostingBrowser = false // 13.09.2011 HR:

//	
// Setzen der notwendigen Objekt-Properties
//
dgenerationdate 	= arg_generationdate
sClient				= arg_client			// Mandant
sPlant				= arg_unit				// Betrieb
lAirlineKey			= arg_airline			// Airline (aus Airlinecode)

//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

sAirline = of_get_airline_name(lAirlineKey)

//
// Die "Top-Level-Packinglists" werden direkt in dsCenOutMasterLevel1 eingetragen.
// Dieser erf$$HEX1$$e400$$ENDHEX$$hrt eine normale St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung.
//
// Zu f$$HEX1$$fc00$$ENDHEX$$llende Felder in dsCenOutMasterLevel1:
//
// npl_index_key, npl_detail_key, nquantity
//
if dsCenOutMasterLevel1.RowCount() = 0 then
	return false
end if

//
// Verkehrstag ermitteln
//
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

//
// Check der notwendigen Objekt-Properties
//
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

sAirline = of_get_airline_name(lAirlineKey)

// =============================================================================
//
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
//
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

// =============================================================================
//
// Matdispo Standardbeladung 
//
// =============================================================================
lPltype				= 1
	
//
// Packinglists aus Loadinglists, Extrabeladung und Mahlzeiten holen
//
// of_generate_loading(1) entf$$HEX1$$e400$$ENDHEX$$llt
//
	
//
// Zu diesem Zeitpunkt befinden sich alle in der Beladung angewiesenen St$$HEX1$$fc00$$ENDHEX$$cklisten
// in dsCenOutMasterLevel1. Jetzt kann mit der Aufl$$HEX1$$f600$$ENDHEX$$sung der Sub-Packing-Lists begonnen
// werden
//
	
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Sub-Packinglists
//
if of_generate_sub_pl_explosion(1) <> 0 then
	sErrortext = "Error generating Sub-Packing-List Explosion."
	of_trace(2,1,sErrortext + " [of_start_for_flight]" )
end if

	
//f_print_datastore(dsCenOutMasterLevel1)

// =============================================================================
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
//
// =============================================================================

lPltype				= 1
of_generate_pl_explosion(0)


return true

end function

public function long of_get_loadinglist_index_key (string arg_loadinglist);Long lIndex
  
SELECT cen_loadinglist_index.nloadinglist_index_key  
 INTO :lIndex  
 FROM cen_loadinglist_index  
WHERE ( cen_loadinglist_index.cloadinglist = :arg_loadinglist ) AND  
		( cen_loadinglist_index.dvalid_from <= :this.dGenerationDate ) AND  
		( cen_loadinglist_index.dvalid_to >= :this.dGenerationDate )   ;

if sqlca.sqlcode = 100 then 
	return -1
elseif sqlca.sqlcode < 0 then 	
	return -1	
end if

return lIndex

end function

public function boolean of_start_calculator (string arg_client, string arg_unit, date arg_departure, long arg_airlinekey);// =============================================================================
//
// of_start_calculator
//
// f$$HEX1$$fc00$$ENDHEX$$hrt St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r eine Reihe von St$$HEX1$$fc00$$ENDHEX$$cklisten aus
//
// Ergebnis wird in eine 10er-Listen-Darstellung in dsCenOutDetail angelegt
//
// =============================================================================
long					i, j
datastore			dsDetail
long 					lRow
decimal				dcPLQuantity
string				sPLText
long					lFind, lkey
string				lsAirline

long					llPLReckoning
long					llArea
long					llWorkstation
string				lsArea
string				lsWorkstation

String				lsCustomer_PL, lsCustomer_Text

Datastore			dsLocUnitWS		// Texte f$$HEX1$$fc00$$ENDHEX$$r Bereiche

ibPostingBrowser = false // 13.09.2011 HR:

bCalculator	= true		// Calc-Modus ein

// Setzen der notwendigen Objekt-Properties
dgenerationdate 	= arg_departure
sClient				= arg_client
sPlant					= arg_unit
lAirlineKey			= arg_airlinekey

// Verkehrstag ermitteln
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

// Check der notwendigen Objekt-Properties
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

sAirline = of_get_airline_name(lAirlineKey)

of_trace(1,1,"Start calculator: Client = " + sClient + "; Unit = " + sPlant + "; Airline = " + sAirline + "! [of_start_for_flight]")

// Airline-Keys f$$HEX1$$fc00$$ENDHEX$$r Master-St$$HEX1$$fc00$$ENDHEX$$cklisten holen
for i = 1 to dsCenOutMasterLevel1.RowCount()
	lkey = of_get_airline_for_packinglist(dsCenOutMasterLevel1.GetItemNumber(i,"npl_index_key"))
	dsCenOutMasterLevel1.SetItem(i,"cen_out_nairline_key",lkey)
next

// =============================================================================
//
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
//
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

// Bereichsbezeichnungen
dsLocUnitWS = create datastore
dsLocUnitWS.Dataobject = "dw_exp_loc_unit_workstation"
dsLocUnitWS.SetTransObject(sqlca)
dsLocUnitWS.Retrieve(sClient, sPlant)

// =============================================================================
//
// Matdispo Standardbeladung 
//
// =============================================================================
lPltype				= 1

if dsFlightsOnly.RowCount() = 1 then
	of_generate_loading_for_calculator(1)
end if

// Zu diesem Zeitpunkt befinden sich alle in der Beladung angewiesenen St$$HEX1$$fc00$$ENDHEX$$cklisten
// in dsCenOutMasterLevel1. Jetzt kann mit der Aufl$$HEX1$$f600$$ENDHEX$$sung der Sub-Packing-Lists begonnen
// werden
	
// Aufl$$HEX1$$f600$$ENDHEX$$sung Sub-Packinglists
if of_generate_sub_pl_explosion(1) <> 0 then
	sErrortext = "Error generating Sub-Packing-List Explosion."
	of_trace(2,1,sErrortext + " [of_start_for_flight]" )
end if



// =============================================================================
//
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
//
// =============================================================================
//
// Diese Methode ist sp$$HEX1$$e400$$ENDHEX$$ter ggf. pro Betrieb bzw. pro Mandant auszuf$$HEX1$$fc00$$ENDHEX$$hren.
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend wird dies f$$HEX1$$fc00$$ENDHEX$$r eine Airline durchgef$$HEX1$$fc00$$ENDHEX$$hrt.
// Es wird cen_out_detail gef$$HEX1$$fc00$$ENDHEX$$llt.
//
// =============================================================================

//
// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
//
lPltype				= 1

dsDetail	= Create DataStore
dsDetail.DataObject	= "dw_packinglist_content"
dsDetail.SetTransObject(SQLCA)

dsCenOutDetail.DataObject	= "dw_forcast_calc_result"

//f_print_datastore(dsCenOutMasterLevel1)


// --------------------------------------------------------------------------------------------------------------------
// 13.09.2011 HR: Falls das Array gef$$HEX1$$fc00$$ENDHEX$$llt ist, setzen wir den Filter auf die
//                           $$HEX1$$fc00$$ENDHEX$$bergebenen Reconnings, um nur von den gew$$HEX1$$fc00$$ENDHEX$$nschten 
//					   die Artikel zu erstellen
// --------------------------------------------------------------------------------------------------------------------
if upperbound(iReckoning) >=5 then 
	string sFilterPackinglist = " "
	
	if iReckoning[1] = 0 then
		sFilterPackinglist = "nreckoning = 0"
	end if
	if iReckoning[2] = 1 then
		if len(sFilterPackinglist) > 0 then sFilterPackinglist += " or "
		sFilterPackinglist += "nreckoning = 1"
	end if
	if iReckoning[3] = 2 then
		if len(sFilterPackinglist) > 0 then sFilterPackinglist += " or "
		sFilterPackinglist += "nreckoning = 2"
	end if
	if iReckoning[4] = 3 then
		if len(sFilterPackinglist) > 0 then sFilterPackinglist += " or "
		sFilterPackinglist += "nreckoning = 3"
	end if
	if iReckoning[5] = 4 then
		if len(sFilterPackinglist) > 0 then sFilterPackinglist += " or "
		sFilterPackinglist += "nreckoning = 4"
	end if
	
	dsCenOutMasterLevel1.setfilter(sFilterPackinglist)
	dsCenOutMasterLevel1.filter()
end if

for i = 1 to dsCenOutMasterLevel1.RowCount()
	lPLIndexKey			= dsCenOutMasterLevel1.GetItemNumber(i,"npl_index_key")
	lPLDetailKey			= dsCenOutMasterLevel1.GetItemNumber(i,"npl_detail_key")
	dcPLQuantity		= dsCenOutMasterLevel1.GetItemDecimal(i,"nquantity")
	lMasterIndexKey 	= dsCenOutMasterLevel1.GetItemNumber(i,"nmaster_index_key")
	llPLReckoning		= dsCenOutMasterLevel1.GetItemNumber(i,"nreckoning")
	llArea					= dsCenOutMasterLevel1.GetItemNumber(i,"narea_key")
	llWorkstation		= dsCenOutMasterLevel1.GetItemNumber(i,"nworkstation_key")
	
	// 02.06.06 Bereich / Workstation zuspielen
	lFind = dsLocUnitWS.Find("narea_key = " + string(llArea) + &
				" and nworkstation_key = " + string(llWorkstation),1,dsLocUnitWS.RowCount())
	if lfind > 0 then
		lsArea			= dsLocUnitWS.GetItemString(lfind,"loc_unit_areas_ctext")
		lsWorkstation	= dsLocUnitWS.GetItemString(lfind,"ctext")
		dsCenOutMasterLevel1.SetItem(i,"carea_text",lsArea)
		dsCenOutMasterLevel1.SetItem(i,"cws_text",lsWorkstation)
	end if

	// 28.04.06 Darstellung 10er Liste
	if iCalculatorMode = 0 then
		sPackinglist	= dsCenOutMasterLevel1.GetItemString(i,"cpackinglist")	
		sPLText			= dsCenOutMasterLevel1.GetItemString(i,"ctext")
		lFind = dsCenOutMasterLevel1.Find("npl_index_key = " + string(lMasterIndexKey),1,dsCenOutMasterLevel1.RowCount())
		if lFind > 0 then
			lsAirline		= of_get_airline_name(dsCenOutMasterLevel1.GetItemNumber(lFind,"cen_out_nairline_key"))
		else
			lsAirline		= of_get_airline_name(dsCenOutMasterLevel1.GetItemNumber(i,"cen_out_nairline_key"))
		end if
	else
		lFind = dsCenOutMasterLevel1.Find("npl_index_key = " + string(lMasterIndexKey),1,dsCenOutMasterLevel1.RowCount())
		if lFind > 0 then
			sPackinglist	= dsCenOutMasterLevel1.GetItemString(lFind,"cpackinglist")	
			sPLText			= dsCenOutMasterLevel1.GetItemString(lFind,"ctext")
			lsAirline		= of_get_airline_name(dsCenOutMasterLevel1.GetItemNumber(lFind,"cen_out_nairline_key"))
		else
			sPackinglist	= dsCenOutMasterLevel1.GetItemString(i,"cpackinglist")	
			sPLText			= dsCenOutMasterLevel1.GetItemString(i,"ctext")
			lsAirline		= of_get_airline_name(dsCenOutMasterLevel1.GetItemNumber(i,"cen_out_nairline_key"))
		end if
	end if

	// Retrieve auf PL Stammdaten
	dsDetail.Retrieve(lPLIndexKey, dgenerationdate)

	// Packinglist-Details ermitteln
	for j = 1 to dsDetail.RowCount()
//		sPackinglist			= dsDetail.GetItemString(j,"cen_packinglist_index_cpackinglist")
//		sText						= dsDetail.GetItemString(j,"cen_packinglists_ctext")
		dcQuantity				= dsDetail.GetItemDecimal(j,"cen_packinglist_detail_nquantity")
		lPriority				= dsDetail.GetItemNumber(j,"cen_packinglist_detail_nsort")
		lItemIndexKey			= dsDetail.GetItemNumber(j,"item_npackinglist_index_key")
		lItemDetailKey			= dsDetail.GetItemNumber(j,"item_npackinglist_detail_key")
		sItem						= dsDetail.GetItemString(j,"item_cpackinglist")
		sItemText				= dsDetail.GetItemString(j,"item_ctext")
		iPackinglistLevel		= dsDetail.GetItemNumber(j,"item_npacking_list_level")
		sItemUnit				= dsDetail.GetItemString(j,"item_cunit")
		// Customer PL / Text
		lsCustomer_PL			= dsDetail.GetItemString(j,"ccustomer_pl")
		lsCustomer_Text			= dsDetail.GetItemString(j,"ccustomer_text")
		
		//
		// Anzahl Gebinde mu$$HEX2$$df002000$$ENDHEX$$ber$$HEX1$$fc00$$ENDHEX$$cksichtigt wer
		//
		lGebinde				= dsDetail.GetItemNumber(j,"nnumber_packages")
		if lGebinde > 0 then
			if iGebindeFlag = 1 then
				dcQuantity 		= dcQuantity * lGebinde
			end if
		end if
		lmaterial_group_key	= dsDetail.GetItemNumber(j,"nmaterial_index_key")
		if isnull(lmaterial_group_key) then lmaterial_group_key = -1
		lreckoning				= dsDetail.GetItemNumber(j,"nreckoning")
		if isnull(lreckoning) then lreckoning = 0

		//
		// Check Packinglist-Level:
		// Die Aufl$$HEX1$$f600$$ENDHEX$$sung erfolgt nur f$$HEX1$$fc00$$ENDHEX$$r Artikel!
		//
		if iPackinglistLevel = 3 then
			lRow = dsCenOutDetail.InsertRow(0)
			dsCenOutDetail.SetItem(lRow,"carticle",sItem)
			dsCenOutDetail.SetItem(lRow,"carticle_text",sItemText)
			dsCenOutDetail.SetItem(lRow,"cpackinglist",sPackinglist)
			dsCenOutDetail.SetItem(lRow,"cpackinglist_text",sPLText)
			dsCenOutDetail.SetItem(lRow,"nquantity",dcquantity * dcPLQuantity)
			dsCenOutDetail.SetItem(lRow,"cunit",sItemUnit)
			dsCenOutDetail.SetItem(lRow,"cairline",lsAirline)
			// Customer PLK / Text
			dsCenOutDetail.SetItem(lRow,"ccustomer_pl", lsCustomer_PL)
			dsCenOutDetail.SetItem(lRow,"ccustomer_text", lsCustomer_Text)
			
			
			//
			// 02.06.06 Setzen von Reckoning, abh$$HEX1$$e400$$ENDHEX$$ngig vom Status der PL
			//
			choose case llPLReckoning
				case 2
					if lreckoning = 3 or lreckoning = 4 then
						dsCenOutDetail.SetItem(lRow,"nreckoning",lreckoning)
					else
						dsCenOutDetail.SetItem(lRow,"nreckoning",llPLReckoning)
					end if
				case 3, 4
					dsCenOutDetail.SetItem(lRow,"nreckoning",llPLReckoning)
				case else
					dsCenOutDetail.SetItem(lRow,"nreckoning",lreckoning)
			end choose
			
			// --------------------------------------------------------------------------------------------------------------------
			// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
			// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
			// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
			// --------------------------------------------------------------------------------------------------------------------
			if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
			
				choose case dsCenOutDetail.GetItemNumber(lRow,"nreckoning")
					case 1
						 dsCenOutDetail.SetItem(lRow,"nquantity",0)
					case 0
						dsCenOutDetail.SetItem(lRow,"nreckoning",2)
				 end choose
			end if

			dsCenOutDetail.SetItem(lRow,"narea_key",llArea)
			dsCenOutDetail.SetItem(lRow,"nworkstation_key",llWorkstation)
			dsCenOutDetail.SetItem(lRow,"carea",lsArea)
			dsCenOutDetail.SetItem(lRow,"cworkstation",lsWorkstation)
			dsCenOutDetail.SetItem(lRow,"nmaterial_index_key",lmaterial_group_key)
					
//			dsCenOutDetail.SetItem(lRow,"npl_index_key",lPLIndexKey)
//			dsCenOutDetail.SetItem(lRow,"npl_detail_key",lPLDetailKey)
//			dsCenOutDetail.SetItem(lRow,"nitem_index_key",lItemIndexKey)
//			dsCenOutDetail.SetItem(lRow,"nitem_detail_key",lItemDetailKey)
//			dsCenOutDetail.SetItem(lRow,"citem_pl",sItem)
//			dsCenOutDetail.SetItem(lRow,"citem_text",sItemText)
//			dsCenOutDetail.SetItem(lRow,"citem_add_on_text","")
//			dsCenOutDetail.SetItem(lRow,"nquantity",dcquantity * dcPLQuantity)
//			dsCenOutDetail.SetItem(lRow,"nsort",lPriority)
//			dsCenOutDetail.SetItem(lRow,"cunit",sItemUnit)
		end if
	next
next

destroy dsLocUnitWS

return true

end function

public function integer of_generate_loading_for_calculator (long arg_row);// ==========================================================================
//
// of_generate_loading_for_calculator
//
// Aufruf von uo_flight_explosion zur Erstellung der aktuellen Beladung.
// Angepasst f$$HEX1$$fc00$$ENDHEX$$r die manuelle St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung
//
// ==========================================================================
//
// Datum			Aktion
// -----------------------------------------------------------------------------
//	22.04.2006	Neu
//
// 10.09.2009	Account Code & Key
// ==========================================================================
long		j, k, l, m
long		lRow, lFind
string	sFind

integer	iCounter

uo_flight_explosion		uo_loading4flight


of_trace(1,1,"[of_generate_loading_for_calculator] Start generation of loading" )
of_trace(1,10,"[of_generate_loading_for_calculator] Parameters: lPLType = " + string(lPLType) + "; iDay for " + string(dgenerationdate) + " = " + string(iDay) )

//
// Lokale Bereiche setzen
//
lArea_Key			= 0	// der lokale Bereich
lWorkstation_Key	= 0	// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
	
//
// UserObjekt instanziieren
//
// Merker: alternativ evtl. leeres uo_loading_list immer wieder zuweisen, um create zu sparen...
//
uo_loading4flight = create uo_flight_explosion

if not isvalid(uo_loading4flight) then
	of_trace(2,1,"[of_generate_loading_for_calculator] Error generate loading: uo_loading4flight is not valid for lResultKey = " + string(lResultKey) + "  lTransaction = " + string(lTransaction) )
	return -1
end if

sAirlineCode = dsFlightsOnly.GetItemString(arg_row,"cen_out_cairline")

// 22.04.2009 HR:
is_Mandant = dsFlightsOnly.GetItemString(arg_row,"cen_out_cclient")
lMealExplosionWithBillingonly = long(of_cen_profilestring("OnlineExplosion","WithBillingOnly","0",is_Mandant))

//
// Die Beladung f$$HEX1$$fc00$$ENDHEX$$r den Flug (LL, SLL)
//
//dsExplosionHandling.Retrieve(lResultKey)

// ---------------------------------------------------------------------
//
// Properties setzen
//
// dazu geh$$HEX1$$f600$$ENDHEX$$ren auch zwei Arrays mit den Keys der SSLs und ZBLs
//
// ---------------------------------------------------------------------
uo_loading4flight.dtDepartureDate	= datetime(dgenerationdate)
uo_loading4flight.sDepartureTime		= "00:00"

uo_loading4flight.sVerkehrstag		= string(iDay)

// ---------------------------------------------------------------------
// das Array mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------	
iCounter = 0
For m = 1 to dsExplosionHandling.Rowcount()
	If dsExplosionHandling.Getitemnumber(m,"nhandling_id") = 1 Then
		
		// 20.11.2009 HR:
		if m>1 then
			if dsExplosionHandling.find("cloadinglist='"+dsExplosionHandling.GetitemString(m,"cloadinglist")+"'",1, m - 1)>0 then continue
		end if

		iCounter ++
		uo_loading4flight.lFirstArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsExplosionHandling.GetitemString(m,"cloadinglist"))
		//26.10.05 uo_loading4flight.lFirstArgRetrieve[iCounter] = dsExplosionHandling.Getitemnumber(m,"nloadinglist_index_key")
	End if	
Next	

// ---------------------------------------------------------------------
// das Array mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For m = 1 to dsExplosionHandling.Rowcount()
	If dsExplosionHandling.Getitemnumber(m,"nhandling_id") = 2 Then

		// 20.11.2009 HR:
		if m>1 then
			if dsExplosionHandling.find("cloadinglist='"+dsExplosionHandling.GetitemString(m,"cloadinglist")+"'",1, m - 1)>0 then continue
		end if

		iCounter ++
		uo_loading4flight.lSecondArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsExplosionHandling.GetitemString(m,"cloadinglist"))
		// 26.10.05 uo_loading4flight.lSecondArgRetrieve[iCounter] = dsExplosionHandling.Getitemnumber(m,"nloadinglist_index_key")		
	End if	
Next	

// 
// Ermitteln der Beladung
// 
if uo_loading4flight.uf_retrieve() <= 0 then
	of_trace(2,1,"[of_generate_loading_for_calculator] Error uo_loading4flight.uf_retrieve(): " + sairlineCode + " " + string(lFlightNumber) + "  (key " + string(lResultKey) + ")" )
	of_trace(2,1,"[of_generate_loading_for_calculator] Error uo_loading4flight.uf_retrieve(): " + uo_loading4flight.sStatusText )
end if

//f_print_datastore(uo_loading4flight.ds_loadinglist)

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
isPackinglistXsl=""

for j = 1 to uo_loading4flight.ds_loadinglist.RowCount()
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lPLIndexKey			= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
	lPLDetailKey 		= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglists_npackinglist_detail_key")
	sPackinglist			= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglist_index_cpackinglist")
	sText					= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglists_ctext")
	sUnit					= uo_loading4flight.ds_loadinglist.GetItemString(j,"cen_packinglists_cunit")
	dcQuantity			= uo_loading4flight.ds_loadinglist.GetItemDecimal(j,"cen_loadinglists_nquantity")
	dcquantity_version = dcQuantity// 06.03.2013 HR:
	isPackinglistShortText	= sText // // 23.05.2014 HR: CBASE-HKG-CR-2014-005
	lAction				= 1		// immer beladen (bringst Du)
	lHandlingID			= 1		// f$$HEX1$$fc00$$ENDHEX$$r normale Beladung immer 1
	lReckoning			= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"nreckoning")
	lPackinglistKind		= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npl_kind_key")
	lPackinglistType	= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"cen_packinglists_npackinglist_key")
	
	if isnull(lReckoning) then lReckoning = 0

	// Customer_PL
	scustomer_pl		= uo_loading4flight.ds_loadinglist.GetItemString(j,"ccustomer_pl")
	scustomer_pl_text	= uo_loading4flight.ds_loadinglist.GetItemString(j,"ccustomer_text")

	// 10.09.2009 Account Code & Key
	sAccount          	= uo_loading4flight.ds_loadinglist.GetItemString(j,"cAccount")
	laccount_key      	= uo_loading4flight.ds_loadinglist.GetItemNumber(j,"nAccount_Key")

	//
	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung)
	//
	sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
				string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0 " + &
				" and nreckoning = " + string(lReckoning)	// 21.04.2004

	lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())

	if lFind > 0 then
		//
		// Packinglist gibt's schon => kumulieren
		//
		dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
		dcQuantity		= dcOldQuantity + dcQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcQuantity)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + dcquantity_version
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
	else
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		ii_NPARTIALSUBSTITUTION = 0

		// Packinglist gibt's noch nicht => insert
		of_insert_cen_out_master(1)
	end if
	
next		// PL

//
// Userobjekt zerst$$HEX1$$f600$$ENDHEX$$ren
//
destroy uo_loading4flight


return 0

end function

public function long of_get_airline_for_packinglist (long arg_index_key);Long lkey
  
SELECT cen_packinglists.nairline_key
 INTO :lkey  
 FROM cen_packinglists  
WHERE ( cen_packinglists.npackinglist_index_key = :arg_index_key ) AND  
		( cen_packinglists.dvalid_from <= :this.dGenerationDate ) AND  
		( cen_packinglists.dvalid_to >= :this.dGenerationDate )   ;

if sqlca.sqlcode = 100 then 
	return -1
elseif sqlca.sqlcode < 0 then 	
	return -1	
end if

return lkey

end function

public function integer of_get_master_packinglist (ref string arg_pl, ref string arg_pl_text, long arg_master_key);//======================================================================================
//
// of_get_master_packinglist
//
// Holt Informationen zur Master-Packinglist
//
//======================================================================================

select cen_packinglist_index.cpackinglist, cen_packinglists.ctext
  into :arg_pl, :arg_pl_text
  from cen_packinglist_index, cen_packinglists
 where cen_packinglist_index.npackinglist_index_key 	= cen_packinglists.npackinglist_index_key
   and cen_packinglists.dvalid_from 						<= :dGenerationDate
	and cen_packinglists.dvalid_to 							>= :dGenerationDate
	and cen_packinglist_index.npackinglist_index_key 	= :arg_master_key;

if sqlca.sqlcode <> 0 then
	return -1
end if

return 0

end function

public function string of_cen_profilestring (string ssection, string skey, string sdefault, string smandant);// --------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_cen_profilestring (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// string ssection
//  string skey
//  string sdefault
//  string smandant
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung: liefert analog der funktion f_cen_profilestring einen Mandantenparameter zur$$HEX1$$fc00$$ENDHEX$$ck, nur das der mandant zus$$HEX1$$e400$$ENDHEX$$tzliches Argument ist.
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  31.03.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------
string	sValue

Select 	cValue 
into 		:sValue 
from		cen_setup
where		cclient		= :smandant  	and
			cSection		= :sSection				and
			cKey			= :sKey;

If SQLCA.SQLCode = 100 Then
	sValue = sDefault
	INSERT INTO cen_setup  
          (cclient,   
          csection,   
          ckey,   
          cvalue )
   VALUES (:smandant,   
          :sSection,   
          :sKey,   
          :sDefault)  ;
End if


return sValue
end function

protected function integer of_insert_cen_out_master (integer arg_level);// ==========================================================================
//
// of_insert_cen_out_master
//
// Einf$$HEX1$$fc00$$ENDHEX$$gen einer Zeile in den Ergebnis-Datastore
// zur Speicherung in cen_out_master
//
// ==========================================================================
//
// 11.11.2003	$$HEX1$$dc00$$ENDHEX$$bergabe eines Levels:
//					Steuert, in welchen Datastore der Datensatz abgelegt 
//					werden soll
//
// ==========================================================================
// --------------------------------------------------------------------------
// 17.06.2009 ccustomer_pl & ccustomer_text hinzu 
// 10.09.2009 Account Code & Key
// 16.04.2012 mnu: bestimmen customer_pl erweitert
// 18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast
// --------------------------------------------------------------------------
long 			lRow
LONGLONG	lSequence  //  18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast
datetime		dtnow 
long			lFind
string			sFind
Integer		li_Succ
String	ls_PL, ls_Text


dtnow = datetime(today(),now())

// --------------------------------------------------------------------------------------------------------------------
// 26.02.2013 HR: Umstellung der Sequence auf LONGLONG
// --------------------------------------------------------------------------------------------------------------------
lSequence = f_Sequence_ll("seq_cen_out_master", sqlca)
if lSequence = -1 then
	return -1
end if
// Level steuert, in welchen Datastore gespeichert wird
choose case arg_level
	case 1
		dsCenOutMaster = dsCenOutMasterLevel1
	case 2
		dsCenOutMaster = dsCenOutMasterLevelN
end choose
lRow = dsCenOutMaster.InsertRow(0)
dsCenOutMaster.SetItem(lRow,"cpart_unit",sPlant) // 14.03.2012 HR: Partitionierung nach Betrieb

// npl_type: Hard Coded St$$HEX1$$fc00$$ENDHEX$$cklistentyp 2 = Lesematerial
dsCenOutMaster.SetItem(lRow,"npl_type",lPltype)
dsCenOutMaster.SetItem(lRow,"ndetail_key",lSequence)
dsCenOutMaster.SetItem(lRow,"ntransaction",lTransaction)
dsCenOutMaster.SetItem(lRow,"nresult_key",lresultkey)
dsCenOutMaster.SetItem(lRow,"npl_index_key",lPLIndexKey)
dsCenOutMaster.SetItem(lRow,"npl_detail_key",lPLDetailKey)
dsCenOutMaster.SetItem(lRow,"nancestor_index_key",lPLIndexKey)
dsCenOutMaster.SetItem(lRow,"cpackinglist",sPackinglist)

// --------------------------------------------------------------------------------------------------------------------
// 27.09.2011 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen hier, ob sText NULL ist, damit wir kein Problem beim Speichern haben
// --------------------------------------------------------------------------------------------------------------------
if isnull(sText) or trim(sText)="" then
   dsCenOutMaster.SetItem(lRow,"ctext",'n/a')
else
   dsCenOutMaster.SetItem(lRow,"ctext",sText)
end if
dsCenOutMaster.SetItem(lRow,"cunit",sUnit)	// Einheit
dsCenOutMaster.SetItem(lRow,"nquantity",dcquantity)
dsCenOutMaster.SetItem(lRow,"naction",lAction)
dsCenOutMaster.SetItem(lRow,"dtimestamp",dtnow)
dsCenOutMaster.SetItem(lRow,"nstatus",0)
dsCenOutMaster.SetItem(lRow,"cclass",is_cclass) // TBR 23.04.2009
dsCenOutMaster.SetItem(lRow,"nclass_number",ii_nclass_number)  // TBR 23.04.2009
// neu: nhandling_id auch in cen_out_master setzen
// Damit wissen wir sp$$HEX1$$e400$$ENDHEX$$ter, aufgrund welches Handling-Typs der Baustein beladen wurde
// und k$$HEX1$$f600$$ENDHEX$$nnen z.B. die Anzahl "Spiegel" je Gate ermitteln
dsCenOutMaster.SetItem(lRow,"nhandling_id",lHandlingID)
// 04.02.2009 HR: UrsprungsLoadinglist vermerken
dsCenOutMaster.SetItem(lRow,"cloadinglist",sfromloadinglist)
// Frequenz-Key (Falls die Menge vom Verkehrstag abh$$HEX1$$e400$$ENDHEX$$ngt)
if lPLType = 1 then
	dsCenOutMaster.SetItem(lRow,"nfreq_key",0)
elseif lPLType = 2 then
	dsCenOutMaster.SetItem(lRow,"nfreq_key",iDay)
	dsCenOutMaster.SetItem(lRow,"narea_key",0)
	dsCenOutMaster.SetItem(lRow,"nworkstation_key",0)
	dsCenOutMaster.SetItem(lRow,"nreserve",0)
end if
// Level of explosion: F$$HEX1$$fc00$$ENDHEX$$r die Gliederungsebene
dsCenOutMaster.SetItem(lRow,"nlevel_of_explosion",arg_level)
// Steuerzeichen nreckoning
dsCenOutMaster.SetItem(lRow,"nreckoning",lreckoning)
// St$$HEX1$$fc00$$ENDHEX$$cklistentypen System und Packinglist
dsCenOutMaster.SetItem(lRow,"npl_kind_key",lPackinglistKind)
dsCenOutMaster.SetItem(lRow,"npackinglist_key",lPackinglistType)
// Urspr. Vorg$$HEX1$$e400$$ENDHEX$$nger der St$$HEX1$$fc00$$ENDHEX$$ckliste
dsCenOutMaster.SetItem(lRow,"nmaster_index_key",lPLIndexKey)
dsCenOutMaster.SetItem(lRow,"nlevel",1)		// Hier handelt es sich immer um Top-Level-St$$HEX1$$fc00$$ENDHEX$$cklisten
// 23.04.2009 HR: Merken des Detailkeys als Kopf und $$HEX1$$dc00$$ENDHEX$$bergeordneten Schl$$HEX1$$fc00$$ENDHEX$$ssel
dsCenOutMaster.SetItem(lRow,"nmaster_detail_key",lSequence)
dsCenOutMaster.SetItem(lRow,"nancestor_detail_key",lSequence)

// --------------------------------------------------------------------------------------------------------------------
// 14.08.2012 HR: Alte Funktion wieder aktiviert / Neue auskommentiert
// --------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// 17.06.2009 ccustomer_pl ccustomer_text hinzu
// ----------------------------------------------------------------------------------------
dsCenOutMaster.SetItem(lRow,"ccustomer_pl", sCustomer_PL)
dsCenOutMaster.SetItem(lRow,"ccustomer_pl_text", sCustomer_PL_Text)
// ----------------------------------------------------------------------------------------
// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
// ----------------------------------------------------------------------------------------
If il_FillEmptyCustomerPL = 1 Then
	If IsNULL(sCustomer_PL) OR Trim(sCustomer_PL) = "" Then
		dsCenOutMaster.SetItem(lRow,"ccustomer_pl", sPackinglist)
	End If
	If IsNULL(sCustomer_PL_Text) OR Trim(sCustomer_PL_Text) = "" Then
		dsCenOutMaster.SetItem(lRow,"ccustomer_pl_text", sText)
	End If
End If

//// ----------------------------------------------------------------------------------------
//// 17.06.2009 ccustomer_pl ccustomer_text hinzu
//// 16.04.2012 mnu: funktion vorschalten vor instance-werte
//// ----------------------------------------------------------------------------------------
//if  of_get_customer_id(lPLIndexKey, lPLDetailKey, lAirlineKey, ls_PL, ls_Text, false) <= 0 then
//	// nix anderes gefunden: nimm die instance-werte
//	ls_PL = sCustomer_PL
//	ls_Text = sCustomer_PL_Text
//end if
//dsCenOutMaster.SetItem(lRow,"ccustomer_pl", ls_PL)
//dsCenOutMaster.SetItem(lRow,"ccustomer_pl_text", ls_Text)
//// ----------------------------------------------------------------------------------------
//// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
//// 16.04.2012 mnu: gegen lokale werte pr$$HEX1$$fc00$$ENDHEX$$fen
//// ... oder sollte man lieber die instance-felder anpassen ?
//// ----------------------------------------------------------------------------------------
//If il_FillEmptyCustomerPL = 1 Then
//	If IsNULL(ls_PL) OR Trim(ls_PL) = "" Then
//		dsCenOutMaster.SetItem(lRow,"ccustomer_pl", sPackinglist)
//	End If
//	If IsNULL(ls_Text) OR Trim(ls_Text) = "" Then
//		dsCenOutMaster.SetItem(lRow,"ccustomer_pl_text", sText)
//	End If
//End If
//// ende 16.04.2012 mnu

// ----------------------------------------------------------------------------------------
// 10.09.2009 Account Code
// ----------------------------------------------------------------------------------------
li_Succ = dsCenOutMaster.SetItem(lRow,"caccount", saccount )
li_Succ = dsCenOutMaster.SetItem(lRow,"naccount_key", laccount_key )
dsCenOutMaster.SetItem(lRow,"npercent",iReservePercent)		// Hier handelt es sich immer um Top-Level-St$$HEX1$$fc00$$ENDHEX$$cklisten

// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Werte f$$HEX1$$fc00$$ENDHEX$$r Forcastprojekt speichern
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMaster.SetItem(lRow,"nparams_key1",il_FC_Parm1)
dsCenOutMaster.SetItem(lRow,"nparams_key2",il_FC_Parm2)
dsCenOutMaster.SetItem(lRow,"nparams_key3",il_FC_Parm3)
dsCenOutMaster.SetItem(lRow,"nparams_min",il_FC_Parm_min)

// --------------------------------------------------------------------------------------------------------------------
// 24.03.2011 HR: Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMaster.SetItem(lRow,"csales_rel",sSalesRel)
dsCenOutMaster.SetItem(lRow,"cgoods_recipient",sGoodsRecipient)
dsCenOutMaster.SetItem(lRow,"cdef_storage_location",sDefStorageLocation)

// --------------------------------------------------------------------------------------------------------------------
// 31.08.2011 HR: Abrechnungskennzeichen setzen
// --------------------------------------------------------------------------------------------------------------------
if isnull(sPostTypeShort) then sPostTypeShort= " "
dsCenOutMaster.SetItem(lRow,"cpost_type_short",sPostTypeShort)

// --------------------------------------------------------------------------------------------------------------------
// 06.06.2012 HR: Wir schreiben den Abrechnungscode2
// --------------------------------------------------------------------------------------------------------------------
if isnull(sAdditionalAccount) then sAdditionalAccount= " "
dsCenOutMaster.SetItem(lRow,"cadditional_account",sAdditionalAccount)

// --------------------------------------------------------------------------------------------------------------------
// 05.11.2012 HR: Setze Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMaster.SetItem(lRow,"nportion", dcPortion)

// --------------------------------------------------------------------------------------------------------------------
// 30.01.2013 HR: Menge zur Versionsmenge soll auch gespeichert werden
// --------------------------------------------------------------------------------------------------------------------
dsCenOutMaster.SetItem(lRow,"nquantity_version", dcquantity_version)

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2013 HR: F$$HEX1$$fc00$$ENDHEX$$llen des Zeigers auf das Produktionszeitfensters
// --------------------------------------------------------------------------------------------------------------------
lfind = ids_prod_time_frame.find("npackinglist_index_key = "+string(lPLIndexKey), 1, ids_prod_time_frame.rowcount())
if lfind > 0 then
	il_pltimeframe_index = ids_prod_time_frame.getitemnumber(lfind, "npltimeframe_index")
	id_prod_date			= relativedate(dGenerationDate, -1 *   ids_prod_time_frame.getitemnumber(lfind, "noffset"))
else
	setnull(il_pltimeframe_index)
	setnull(id_prod_date)
end if
dsCenOutMaster.setitem(lRow,"npltimeframe_index", il_pltimeframe_index)
dsCenOutMaster.setitem(lRow,"dprod_date", id_prod_date)

// --------------------------------------------------------------------------------------------------------------------
// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
if isnull(isPackinglistXsl) then isPackinglistXsl=""
dsCenOutMaster.setitem(lRow,"cpackinglist_xsl", isPackinglistXsl)

// --------------------------------------------------------------------------------------------------------------------
// 23.05.2014 HR: CBASE-HKG-CR-2014-005
// 09.10.2014 HR: Wir sollen ggf. auch den Text mit einf$$HEX1$$fc00$$ENDHEX$$gen
// --------------------------------------------------------------------------------------------------------------------

dsCenOutMaster.setitem(lRow,"ctext_short", isPackinglistShortText)

// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
dsCenOutMaster.setitem(lRow,"NPARTIALSUBSTITUTION", ii_NPARTIALSUBSTITUTION)

return 0

end function

public function boolean of_get_class_number (string ps_cclass);// Ermittlung der Sortiernummer zu einer $$HEX1$$fc00$$ENDHEX$$bergebenen Klasse. Besonderheit: Der $$HEX1$$fc00$$ENDHEX$$bergebene
// String kann mehrere Klassen enthalten (z.b. "CM"). Dann gilt die Sortiernummer der jeweils
// ersten Klasse 

String		ls_cclass_temp
Boolean	lbo_loop	, lbo_return

ii_nclass_number 	=	0

// Ermittlung Klassennummer ...					

ls_cclass_temp =	trim(ps_cclass)
lbo_loop 			=	TRUE

// 05.05.2009 HR: 
lbo_return = false

// Es k$$HEX1$$f600$$ENDHEX$$nnen mehrere Klassen aneinander h$$HEX1$$e400$$ENDHEX$$ngen z.B. "CM"
// Zur Sortierung muss die Sortiernummer der jeweils ersten
// ermittelt werden...

DO WHILE lbo_loop

	// Suche der Sortiernummer mit dem aktuellen Substring ...
	SELECT	NCLASS_NUMBER
	INTO		:ii_nclass_number
	FROM		CEN_CLASS_NAME
	WHERE	NAIRLINE_KEY 	=	:lairlinekey AND
				CCLASS 			= 	:ls_cclass_temp;
				
	IF 			sqlca.sqlcode = 100 THEN
				// Nicht gefunden ...
				IF 	Len(ls_cclass_temp) 	<=	1 THEN
					// Substring nur noch ein Zeichen lang => Ende => gar nicht gefunden
					lbo_loop 					=	FALSE
					EXIT
				ELSE
					// Substing noch l$$HEX1$$e400$$ENDHEX$$nger als ein Zeichen => letztes weg, neuer Versuch ...
					ls_cclass_temp = Mid(ls_cclass_temp,1,Len(ls_cclass_temp) - 1)
				END IF
				
	ELSEIF 	sqlca.sqlcode <> 0 THEN
				of_trace(2,1,"DB-Error bei SELECT NCLASS_NUMBER FROM CEN_CLASS_NAMES: " + String(sqlca.sqlcode) + " " + sqlca.sqlerrtext )
				RETURN FALSE
				
	ELSEIF 	sqlca.sqlcode = 0 THEN
				// => Klasse gefunden, erste reicht => raus hier ...
				// 05.05.2009 HR:
				lbo_return = True 
				EXIT
	END IF

LOOP	
	
// Wenn nichts gefunden NULL vermeiden...
IF 	IsNull(ii_nclass_number) THEN 
	ii_nclass_number = 0
END IF

RETURN lbo_return
end function

public function string of_get_airline_name (long arg_nairline_key);// --------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_get_airline_name (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// long arg_nairline_key
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
//  11.08.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------

String sReturn

SELECT cen_airlines.cairline
 INTO :sReturn  
 FROM cen_airlines  
WHERE cen_airlines.nairline_key = :arg_nairline_key;

if sqlca.sqlcode = 0 then
	return sReturn
elseif sqlca.sqlcode = 100 then
	return "N/A"
else
	return "N/A"
end if
end function

public function long of_min_forcast (long arg_value1, long arg_value2);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_min_forcast (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_value1
//  long arg_value2
// --------------------------------------------------------------------------------------------------------------------
// Return: long
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Liefert den Schl$$HEX1$$fc00$$ENDHEX$$ssel f$$HEX1$$fc00$$ENDHEX$$r den kleineren Bewertungsstatus
//                           zur$$HEX1$$fc00$$ENDHEX$$ck
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  09.09.2010	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
long lrow1, lrow2

if arg_value1 = arg_value2 then return arg_value1

if arg_value1 <=0 then return arg_value2

lrow1=dsForecast_AS.find("nparams_key = "+string(arg_value1),1,dsForecast_AS.rowcount())
lrow2=dsForecast_AS.find("nparams_key = "+string(arg_value2),1,dsForecast_AS.rowcount())

if lrow1 > lrow2 then
	return arg_value2
else
	return arg_value1
end if
end function

public function string of_get_goodsrecipient (long arg_nairline_key, string arg_caccount);string a, b
long l

b= trim(arg_caccount)
if isnull(b) then b=" "

if arg_nairline_key >0 then
	l = arg_nairline_key
else
	l = lAirlineKey
end if

  SELECT cen_airline_accounts.csap_code  
    INTO :a  
    FROM cen_airline_accounts  
   WHERE ( cen_airline_accounts.nairline_key = :l ) AND  
         ( cen_airline_accounts.caccount = :b )   ;

if sqlca.sqlcode<>0 then
	a = 'n/a'
	of_trace(1,1,"of_get_goodsrecipient: SAP_CODE not found  for Airlinekey:"+string(l)+" ACCOUNT "+b)
end if

return a
end function

public function boolean of_start_for_postingbrowser (long arg_resultkey);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_start_for_postingbrowser (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_resultkey
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
//  29.08.2011	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long					i

ibPostingBrowser = true // 13.09.2011 HR:

// DataObjects anpassen: Einzelflug hat Result-Key als Retrieval Argument
// Aus Kompatiblit$$HEX1$$e400$$ENDHEX$$tsgr$$HEX1$$fc00$$ENDHEX$$nden zu den $$HEX1$$fc00$$ENDHEX$$brigen Methoden werden die Datastores
// beibehalten.
dsFlightsOnly.DataObject					= "dw_exp_pax_of_postingbrowser"
dsFlightsOnly.SetTransObject(SQLCA)
dsFlightsOfTheDay.DataObject				= "dw_exp_pax_of_postingbrowser"
dsFlightsOfTheDay.SetTransObject(SQLCA)

// Mit Result-Key nach cen_out, Properties holen und setzen, dann Matdispo ansto$$HEX1$$df00$$ENDHEX$$en.
dsFlightsOnly.Retrieve(arg_resultkey)
if dsFlightsOnly.RowCount() = 0 then
	return false
end if

dsFlightsOfTheDay.Retrieve(arg_resultkey)
if dsFlightsOfTheDay.RowCount() = 0 then
	return false
end if

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX
// --------------------------------------------------------------------------------------------------------------------
is_Mandant = dsFlightsOnly.GetItemString(1,"cclient")
iDoNotSet0ForCxFlights = integer(of_cen_profilestring("OnlineExplosion","DoNotSet0ForCxFlights","0",is_Mandant))

// 06.09.2010 HR: Projekt Forcast
iFillForcastFields = integer(of_cen_profilestring("OnlineExplosion","FillForcastFields","0",is_Mandant))

// 21.11.2014 HR: Auch beim Buchungsbrowser er$$HEX1$$fc00$$ENDHEX$$cksichtigen wir auf den Schalter
ii_explode_plsql = integer(of_cen_profilestring("OnlineExplosion","ExplodeWithPLSQL","0",is_Mandant))
if ii_explode_plsql >= 1 then
	of_trace(1,1, "[of_start_for_postingbrowser] "+"Online Item Explosion being performed by PLSQL" )
end if

// --------------------------------------------------------------------------------------------------------------------
// Setzen der notwendigen Objekt-Properties
// --------------------------------------------------------------------------------------------------------------------
dgenerationdate 			= date(dsFlightsOnly.GetItemDateTime(1,"dbeldat"))
sClient						= dsFlightsOnly.GetItemString(1,"cclient")
sPlant							= dsFlightsOnly.GetItemString(1,"cunit")
lAirlineKey					= dsFlightsOnly.GetItemNumber(1,"nairline_key")

il_customer_key			= dsFlightsOnly.GetItemNumber(1,"nairline_key")// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key

// 07.09.2010 HR: Projekt Forcast
il_routing_id					= dsFlightsOnly.GetItemNumber(1,"nrouting_id")
il_routingplan_index_key	= 0 //dsFlightsOnly.GetItemNumber(1,"cen_out_nroutingplan_index")

// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Datastore mit den Forecast-Werten lesen
// --------------------------------------------------------------------------------------------------------------------
if iFillForcastFields=1 then
	dsForecast.retrieve(lAirlineKey, dgenerationdate)
	dsForecast_AS.retrieve(lAirlineKey)
else
	dsForecast.reset()
	dsForecast_AS.reset()
end if

//// --------------------------------------------------------------------------------------------------------------------
//// 30.06.2010 HR: Nicht nur bei CX eines Fluges, sondern auch beim 
////Nachberechnen von CX-Fl$$HEX1$$fc00$$ENDHEX$$gen muss dass Kennzeichen gesetzt sein
//// --------------------------------------------------------------------------------------------------------------------
//if dsFlightsOnly.GetItemNumber(1,"cen_out_nflight_status")=1 then
//	iCNXFlag = 1
//else
//	iCNXFlag = 0
//end if

// Verkehrstag ermitteln
iDay = DayNumber(dgenerationdate)
iDay --
if iDay = 0 then iDay = 7

// Check der notwendigen Objekt-Properties
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

sAirline = of_get_airline_name(lAirlineKey)

of_trace(1,1,"Start Packing List Explosion for posting Flight: Client = " + sClient + "; Unit = " + sPlant + "; Airline = " + sAirline + "! [of_start_for_postingbrowser]")

// =============================================================================
// Sonderbehandlung f$$HEX1$$fc00$$ENDHEX$$r CNX-Flug
// =============================================================================
if iCNXFlag = 1 and iDoNotSet0ForCxFlights =0 then
	of_trace(1,1,"CNX-Flag ist gesetzt => Matdispo auf 0 [of_start_for_postingbrowser]" )
	
	// 22.09.2006 Bei CNX mal etwas warten...
	sleep(60)
	
	update cen_out_master set nquantity = 0 where nresult_key = :arg_resultkey;
	
	if sqlca.sqlcode <> 0 then
		of_trace(1,1,"Error updating cen_out_master for CNX [of_start_for_postingbrowser]" )
		return false
	end if
	
	return true
end if

// =============================================================================
// Lokale Bereichszuspielung f$$HEX1$$fc00$$ENDHEX$$r Packinglists in cen_out_master
// =============================================================================
dsLocalWorkstations.Retrieve(sClient, sPlant, dgenerationdate)

lResultKey 		= arg_resultkey
sAirlineCode		= dsFlightsOnly.GetItemString(1,"cairline")
lFlightNumber 	= dsFlightsOnly.GetItemNumber(1,"nflight_number")
lTransaction		= 1 //dsFlightsOnly.GetItemNumber(1,"ntransaction")
tdepartureTime	= time(dsFlightsOnly.GetItemString(1,"cdeparture_time"))

// 22.08.2013 HR: Checknull vor Airline und Flugnummer gesetzt, da im Buchungsbrowser diese nicht immer gef$$HEX1$$fc00$$ENDHEX$$llt sind
of_trace(1,10,"Packing List Explosion for Posting-flight " + f_check_null(sAirlineCode) + " " + &
					f_check_null(string(lFlightNumber)) + ": ResultKey = " + string(lResultKey) + &
					" [of_start_for_postingbrowser]")

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2013 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r die Produktionszeitfenster einer St$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------------------------------------------------------------------
ids_prod_time_frame.reset()

// =============================================================================
// Matdispo Standardbeladung 
// =============================================================================
lPltype				= 1
	
// Contents nach dsCenOutMasterLevel1 $$HEX1$$fc00$$ENDHEX$$bertragern
if of_generate_psr_contents(1) <> 0 then
	sErrortext = "Error generating Contents Explosion."
	of_trace(2,1,sErrortext + " [of_start_for_postingbrowser]" )
end if
	
// =============================================================================
// Zu diesem Zeitpunkt befinden sich alle in der Beladung angewiesenen St$$HEX1$$fc00$$ENDHEX$$cklisten
// in dsCenOutMasterLevel1. Jetzt kann mit der Aufl$$HEX1$$f600$$ENDHEX$$sung der Sub-Packing-Lists begonnen
// werden
// =============================================================================

// Aufl$$HEX1$$f600$$ENDHEX$$sung Sub-Packinglists
if of_generate_sub_pl_explosion(1) <> 0 then
	sErrortext = "Error generating Sub-Packing-List Explosion."
	of_trace(2,1,sErrortext + " [of_start_for_postingbrowser]" )
end if

// =============================================================================
// Alte Beladung l$$HEX1$$f600$$ENDHEX$$schen
// =============================================================================
if of_delete_old_loading() <> 0 then
	sErrortext = "Error delete old loading for Flight."
	of_trace(2,1,sErrortext + " [of_start_for_postingbrowser]" )
end if

// =============================================================================
// Result-Datastore speichern und Reset nach jedem Flug.
// Dann ist die Aufl$$HEX1$$f600$$ENDHEX$$sung der Packinglists beendet
// =============================================================================
if of_write_loading() <> 0 then
	// Fehler
	sErrortext = "Error writing loading: " + sairlineCode + " " + string(lFlightNumber) + &
						" (key " + string(lResultKey) + ")"
	of_trace(2,1,sErrortext + " [of_start_for_postingbrowser]" )
	rollback;
	return false
end if
	
// =============================================================================
// Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Artikel 
// =============================================================================
// Diese Methode ist sp$$HEX1$$e400$$ENDHEX$$ter ggf. pro Betrieb bzw. pro Mandant auszuf$$HEX1$$fc00$$ENDHEX$$hren.
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend wird dies f$$HEX1$$fc00$$ENDHEX$$r eine Airline durchgef$$HEX1$$fc00$$ENDHEX$$hrt.
// Es wird cen_out_detail gef$$HEX1$$fc00$$ENDHEX$$llt.
// =============================================================================

// Aufl$$HEX1$$f600$$ENDHEX$$sung Artikel
lPltype				= 1
of_generate_pl_explosion_for_one_flight()

// Aufl$$HEX1$$f600$$ENDHEX$$sung Zeitungen
lPltype				= 2
of_generate_pl_explosion_for_one_flight()

// Schreiben nach cen_out_detail incl. commit
of_write_loading_detail()

return true

end function

public function integer of_generate_psr_contents (long arg_row);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_generate_psr_contents (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_row
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
//  29.08.2011	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
datastore		lds
long			j, lFind
string			sFind
//Long			ll_nairline_key

of_trace(1,1,"Start generation of loading [of_generate_loading]" )
of_trace(1,10,"Parameters: lPLType = " + string(lPLType) + "; iDay for " + string(dgenerationdate) + " = " + string(iDay) + " [of_generate_psr_contents]")

// Lokale Bereiche setzen
lArea_Key			= 0	// der lokale Bereich
lWorkstation_Key	= 0	// die lokale Workstation f$$HEX1$$fc00$$ENDHEX$$r cen_out_master
	
lds = create datastore
lds.dataobject = "dw_exp_cen_out_psr_contents"
lds.settransobject(SQLCA)

sAirlineCode 		= dsFlightsOnly.GetItemString(arg_row,"cairline")
sAccountFight 		= dsFlightsOnly.GetItemString(arg_row,"caccount")

is_Mandant 							= dsFlightsOnly.GetItemString(arg_row,"cclient")
lMealExplosionWithBillingonly 	= long(of_cen_profilestring("OnlineExplosion","WithBillingOnly","0",is_Mandant))
ilGroupPlByClass 					= long(of_cen_profilestring("OnlineExplosion","GroupPlByClass","0",is_Mandant))
il_fillemptycustomerpl 			= Long(of_cen_profilestring("OnlineExplosion","FillEmptyCustomerPL","0",is_Mandant))

// Die Contens f$$HEX1$$fc00$$ENDHEX$$r den Flug lesen
if lds.Retrieve(lResultKey) <= 0 then
	of_trace(2,1,"Error Contens-Retrieve: " + sairlineCode + " " + string(lFlightNumber) + " " + &
					" (key " + string(lResultKey) + ") [of_generate_psr_contents]" )
end if

for j = 1 to lds.RowCount()
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	lPLIndexKey				= lds.GetItemNumber(j,"npackinglist_index_key")
	lPLDetailKey 			= lds.GetItemNumber(j,"cen_packinglists_npackinglist_detail_key")
	sPackinglist				= lds.GetItemString(j,"cpackinglist")
	sText						= lds.GetItemString(j,"cpackinglist_text")
	isPackinglistShortText	= of_ctext_short(sText, lds.GetItemString(j,"cen_packinglists_ctext_short")) // 23.05.2014 HR: CBASE-HKG-CR-2014-005
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl		= lds.GetItemString(j,"cpackinglist_xsl")

	// 19.02.2014 HR: Wenn NULL dann BLANK
	if isnull(isPackinglistXsl) then isPackinglistXsl = ""
	
	// Customer PL
	scustomer_pl		= " " //lds.GetItemString(j,"ccustomer_pl")
	scustomer_pl_text	= " " //lds.GetItemString(j,"ccustomer_text")

	// Account Code & Key 10.09.2009
	saccount				= lds.GetItemString(j,"caccount")
	lAccount_Key		= lds.GetItemNumber(j,"naccount_key")

	sUnit					= lds.GetItemString(j,"cpackinglist_cunit")
	dcQuantity			= lds.GetItemDecimal(j,"nvalue")
	dcQuantity_version = dcQuantity // 06.03.2013 HR:
	lAction				= 1		// immer beladen (bringst Du)
	// 04.02.2009 HR: Zur Unterscheidung, wo die PL herkommt (SL, ZBL)
	lHandlingID			= 1		// f$$HEX1$$fc00$$ENDHEX$$r normale Beladung immer 1
	//lHandlingID		= lds.GetItemDecimal(j,"cen_loadinglist_index_nloadinglist_key")
	lReckoning			= lds.GetItemNumber(j,"nstatus")
	lPackinglistKind		= lds.GetItemNumber(j,"cen_packinglist_index_npl_kind_key")
	lPackinglistType	= lds.GetItemNumber(j,"cen_packinglists_npackinglist_key")
	
	// 30.08.2011 HR:
	sPostTypeShort		= lds.GetItemString(j,"cpost_type_short")
	if isnull(sPostTypeShort) then sPostTypeShort = ' '
	
	
	// 04.02.2009 HR:
	sfromloadinglist 	=  " " //lds.GetItemstring(j,"cen_loadinglist_index_cloadinglist")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	setnull(sSalesRel) // 				= " " //lds.GetItemstring(j,"csales_rel")
	
	// 13.09.2011 HR: Wir nehmen aber erst dens ggf. eingetragenen Warenempf$$HEX1$$e400$$ENDHEX$$nger
	sDefStorageLocation				= lds.GetItemstring(j,"cstorage")
	if isnull(sDefStorageLocation) then
		sDefStorageLocation				= lds.GetItemstring(j,"cdef_storage_location")
	end if
	
	setnull(sGoodsRecipient) //		= lds.GetItemstring(j,"cen_loadinglists_cgoods_recipient")
	
	if isnull(sSalesRel) then sSalesRel=" "
	if isnull(sDefStorageLocation) then sDefStorageLocation=" "
	
	// --------------------------------------------------------------------------------------------------------------------
	// 22.08.2011 HR: Falls die Position keinen  Warenempf$$HEX1$$e400$$ENDHEX$$ger hat, dann nehmen wir ihn von der Beladung oder Flug
	// --------------------------------------------------------------------------------------------------------------------
	if isnull(sGoodsRecipient) then 
		if isnull(saccount) then
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, sAccountFight)
		else
			sGoodsRecipient = of_get_GoodsRecipient(il_customer_key, saccount)
		end if
	// --------------------------------------------------------------------------------------------------------------------
	// 08.09.2015 HR: CCS-TEMP-2015-1308 Anpassen des Accountcodes bei abweichendem Warenemf$$HEX1$$e400$$ENDHEX$$nger
	// --------------------------------------------------------------------------------------------------------------------
	elseif sSalesRel="1" then
		of_get_Account4GoodsRecipient(il_customer_key, sGoodsRecipient, saccount, lAccount_Key)
	end if

	// 05.09.2011 HR:
	if isnull(sGoodsRecipient) then sGoodsRecipient="n/a"

	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- START
	is_cclass				=  lds.GetItemstring(j,"cclass") 

	IF 	NOT IsNull(is_cclass) THEN

		// Ermittlung der zu der Klasse geh$$HEX1$$f600$$ENDHEX$$renden Sortiernummer ...
		IF 	NOT of_get_class_number(is_cclass) THEN
			is_cclass 			=	" "
			ii_nclass_number 	=	0		
		END IF
		
	ELSE // => is_cclass IS NULL
		
		is_cclass 			= " "
		ii_nclass_number 	= 0		
		
	END IF // IF 	IsNull(is_cclass) 

	// 30.04.2009 HR: Wenn keine Gruppierung auf Klasse dan auf 0 setzen
	if ilGroupPlByClass=0 then
		is_cclass 			= " "
		ii_nclass_number 	= 0		
	end if 
	// 23.04.2009 TBR -------------------------------------------------------------------------------------------------------------------------------- ENDE	

	if isnull(lReckoning) then lReckoning = 0
		
	// --------------------------------------------------------------------------------------------------------------------
	// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
	// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
	// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
	
		choose case lReckoning
			case 1
				dcQuantity = 0
				dcQuantity_version = dcQuantity // 06.03.2013 HR:
			case 0
				lReckoning = 2
		 end choose

	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt werden noch folgende Werte
	// 					   ben$$HEX1$$f600$$ENDHEX$$tigt und anschlie$$HEX1$$df00$$ENDHEX$$end die Bewertungs-Werte ermittelt
	// --------------------------------------------------------------------------------------------------------------------

	if iFillForcastFields=1 and dsForecast.rowcount()>0 then
		sFind += "ntype=2" 
		sFind += " and (nrouting_id = "+string(il_routing_id)+" or nrouting_id=0)" 
		sFind += " and (nroutingplan_index_key  = "+string(il_routingplan_index_key)+" or nroutingplan_index_key=0)"  
		sFind += " and (nhandling_key   = "+string(lHandlingID)+" or nhandling_key=0)" 
		
		lFind = dsForecast.find(sFind,1,dsForecast.rowcount())
				
		if lfind=0 then
			il_FC_Parm1 = 0
			il_FC_Parm2 = 0
			il_FC_Parm3 = 0
			il_FC_Parm_min = 0 

			of_trace(50,50,"of_generate_psr_contents: not found sFind = "+sFind )
		else
			il_FC_Parm1 = dsForecast.getitemnumber(lFind,"nparams_key1")
			il_FC_Parm2 = dsForecast.getitemnumber(lFind,"nparams_key2")
			il_FC_Parm3 = dsForecast.getitemnumber(lFind,"nparams_key3")

			of_trace(50,50,"of_generate_psr_contents: found sFind = "+sFind )
			
			il_FC_Parm_min = of_min_forcast(il_FC_Parm1, il_FC_Parm2)
			il_FC_Parm_min = of_min_forcast(il_FC_Parm_min, il_FC_Parm3)
		end if
	else
		of_trace(50,50,"of_generate_psr_contents: not found sFind = "+sFind )

		il_FC_Parm1 = -1
		il_FC_Parm2 = -1
		il_FC_Parm3 = -1
		il_FC_Parm_min = -1 
	end if

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Abrechnungscode 2 ist hier nicht vorhanden, daher setzen wir die Variable auf LEER
	// --------------------------------------------------------------------------------------------------------------------
	sAdditionalAccount = " " //dsCenOutSMPL.GetItemstring(i,"cadditional_account")

	
	
	// Nachschauen, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r diesen Flug schon in cen_out_master
	// aber Vorsicht: naction = 1 (Beladung)
	sFind = "naction = 1 and npl_type = " + string(lpltype) + " and npl_index_key = " + &
				string(lPLIndexKey) + " and npl_detail_key = " + string(lPLDetailKey) + &
				" and nresult_key = " + string(lresultkey) + " and nfreq_key = 0 " + &
				" and nreckoning =" + string(lReckoning)	 +  /* 21.04.2004 */ &
				" and cclass ='" + is_cclass + "' and nclass_number = " + string(ii_nclass_number) +  /* TBR 23.04.2004 */ &
				" and csales_rel ='" + sSalesRel +"'" + /*HR 24.03.11 Findet erweitert um CSALES_REL */ &
				" and cpost_type_short = '"+sPostTypeShort+"' " /*31.08.2011 HR: Abrechnungskennzeichen muss ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden */ + &
				" and cgoods_recipient ='"+sGoodsRecipient+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ + &
            		" and cdef_storage_location = '"+sDefStorageLocation+"'" /* HR 06.08.2012 Bei Artikeln ist der Lagerort auch wichtig */ +&
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if ii_GroupPlBySslZblAc2 = 1 then
		sFind += " and cloadinglist = '"+sfromloadinglist+"'"
		sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
	end if
				
	lFind = dsCenOutMasterLevel1.Find(sFind,1,dsCenOutMasterLevel1.RowCount())

	if lFind > 0 then
		//
		// Packinglist gibt's schon => kumulieren
		//
		dcOldQuantity	= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity")
		dcQuantity		= dcOldQuantity + dcQuantity
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity", dcQuantity)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Wir summieren auch die VersionsMenge auf
		// --------------------------------------------------------------------------------------------------------------------
		dcOldQuantity		= dsCenOutMasterLevel1.GetItemDecimal(lFind,"nquantity_version")
		dcquantity_version	= dcOldQuantity + dcquantity_version
		dsCenOutMasterLevel1.SetItem(lFind,"nquantity_version", dcquantity_version)
	else
		// Packinglist gibt's noch nicht => insert
			
		dcquantity_version = dcQuantity // 30.01.2013 HR: Menge f$$HEX1$$fc00$$ENDHEX$$r Version ist identisch zur Menge
			
		// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
		ii_NPARTIALSUBSTITUTION = 0

		of_insert_cen_out_master(1)

	end if
	
next		// PL

destroy lds

return 0

end function

public function integer of_generate_sub_pl_explosion_plsql (long arg_row);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_generate_sub_pl_explosion_plsql (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_row
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Ermittlung der Sub-Packing-Lists mit PLSQL
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       		Version	Autor          		Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  09.03.2012		1.0		H.Rothenbach	Erstellung
//  16.04.2012		1.1      	M.N$$HEX1$$fc00$$ENDHEX$$ndel 		bestimmen customer_pl erweitert
//  31.01.2013		1.2		H.Rothenbach	Versionsberechnung eingebaut
// --------------------------------------------------------------------------------------------------------------------

long     		j,i,k,a
long			ll_index_key, ll_qty, ll_reckoning, ll_status
string 		ls_sales_rel, ls_def_storage_location, ls_goods_recipient
datastore 	lds_explosion, lds_explosion_container
String			ls_PL, ls_Text
string 		lsAccount
long 			llaccount_key

lds_explosion = create datastore 
lds_explosion.dataobject = "dw_plsql_explode"
lds_explosion.setTransObject(SQLCA)

lds_explosion_container = create datastore 
lds_explosion_container.dataobject = dsCenOutMasterLevel1.dataobject

// 05.03.2012 HR: Brauchen wir f$$HEX1$$fc00$$ENDHEX$$r die Aufl$$HEX1$$f600$$ENDHEX$$sung
if iConvertGtoKG = -1 then
	iConvertGtoKG = integer(of_cen_profilestring("OnlineExplosion","ConvertGtoKG","1",sClient)	)
end if

//dsCenOutMasterLevel1.saveas("D:\TESTXLS\TEST-VOR.XLS",EXCEL!,TRUE)

for j = 1 to dsCenOutMasterLevel1.RowCount()
	ll_index_key					= dsCenOutMasterLevel1.GetItemNumber(j, "npl_index_key")
	dcQuantity					= dsCenOutMasterLevel1.GetItemDecimal(j, "nquantity") // 17.09.2012 HR: NUMBER -> DECIMAL
	dcquantity_version			= dsCenOutMasterLevel1.GetItemDecimal(j, "nquantity_version")	// 31.01.2013 HR:
	ll_reckoning					= dsCenOutMasterLevel1.GetItemNumber(j, "nreckoning")
	
	// --------------------------------------------------------------------------------------------------------------------
	// 05.03.2012 HR: Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	ll_status						= dsCenOutMasterLevel1.GetItemNumber(j, "nstatus")
	ls_sales_rel					= dsCenOutMasterLevel1.GetItemString(j, "csales_rel")
	ls_def_storage_location	= dsCenOutMasterLevel1.GetItemString(j, "cdef_storage_location")
	ls_goods_recipient			= dsCenOutMasterLevel1.GetItemString(j, "cgoods_recipient")

	// --------------------------------------------------------------------------------------------------------------------
	// 14.06.2012 HR: Es kann sein, dass wir auch nach Loadinglist und Abrechnungscode2 gruppieren m$$HEX1$$fc00$$ENDHEX$$ssen
	// --------------------------------------------------------------------------------------------------------------------
	sfromloadinglist 			= dsCenOutMasterLevel1.GetItemString(j,"cloadinglist")
	sAdditionalAccount 		= dsCenOutMasterLevel1.GetItemString(j,"cadditional_account")

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
	// --------------------------------------------------------------------------------------------------------------------
	isPackinglistXsl 				= dsCenOutMasterLevel1.GetItemString(j,"cpackinglist_xsl")

	// 19.02.2014 HR: Wenn NULL dann BLANK
	if isnull(isPackinglistXsl) then isPackinglistXsl = ""
	
	// --------------------------------------------------------------------------------------------------------------------
	// 14.06.2012 HR: Account auch nach unten weiter$$HEX1$$fc00$$ENDHEX$$bergeben
	// --------------------------------------------------------------------------------------------------------------------
	lsAccount 					= dsCenOutMasterLevel1.GetItemString(j,"caccount")
	llaccount_key 				= dsCenOutMasterLevel1.GetItemNumber(j,"naccount_key")

	// 05.03.2012 HR: Retrieve angepa$$HEX1$$df00$$ENDHEX$$t
	// 31.05.2012 HR:	Retrieve angepa$$HEX1$$df00$$ENDHEX$$t lAirlineKey
	// 30.08.2012 HR: Retrieve angepa$$HEX1$$df00$$ENDHEX$$t llaccount_key, lsAccount
	// 12.09.2012 HR: Retrieve angepa$$HEX1$$df00$$ENDHEX$$t il_FillEmptyCustomerPL
	k = lds_explosion.retrieve(ll_index_key, dGenerationDate, 1, sPlant, lAirlineKey,  dcQuantity, dcquantity_version, lMealExplosionWithBillingonly, ll_reckoning, string(tdepartureTime, "hh:mm"), &
	                                      iCNXFlag, iConvertGtoKG, iDoNotSet0ForCxFlights, ls_sales_rel, ls_def_storage_location, ls_goods_recipient, ll_status, llaccount_key, lsAccount, il_FillEmptyCustomerPL )

	// 15.10.2014 HR: Wenn PLSQL nicht mindestens eine Zeile liefert, dann hat was mit der PLSQL-Funktion nicht geklappt und wir protokollieren die Aufrufparamter raus
	if k < 1 then
		of_trace(1,1,"[of_generate_sub_pl_explosion_plsql] Processing item list: " + dsCenOutMasterLevel1.GetItemString(j, "cpackinglist") + " Return: "+string(k)+" Parameter: cbase_explosion.pf_explode_pl("+string(ll_index_key)+", '"+string(dGenerationDate, "dd.mm.yyyy")+"', 1, '"+sPlant+"', "+string(lAirlineKey)+", "+string(dcQuantity)+", "+string(dcquantity_version)+", "+string(lMealExplosionWithBillingonly)+", "+string(ll_reckoning)+", '"+string(tdepartureTime, "hh:mm")+"', " + &
	                                      string(iCNXFlag)+", "+string(iConvertGtoKG)+", "+string(iDoNotSet0ForCxFlights)+", '"+ls_sales_rel+"', '"+ls_def_storage_location+"', '"+ls_goods_recipient+"', "+string(ll_status)+", "+string(llaccount_key)+", '"+lsAccount+"', "+string(il_FillEmptyCustomerPL)+");") 
	end if
	
//	lds_explosion.saveas("D:\TESTXLS\TEST-"+string(j,"00000")+"-RETURN.XLS",EXCEL!,TRUE)
	of_trace(1,10,"[of_generate_sub_pl_explosion_plsql] Processing item list: " + dsCenOutMasterLevel1.GetItemString(j, "cpackinglist") + " record  " + string(j) + " of " + string(dsCenOutMasterLevel1.RowCount())+": Rows "+string(k))
	
	for k = 1 to lds_explosion.RowCount()
		if lds_explosion.getItemNumber(k,"npackinglist_key") = 3 and lds_explosion.getItemNumber(k,"nlevel") > 1 then continue
		
		string sfind
		long lFind
		LONGLONG lLocalAncesterDetailKey, lLocalMasterDetailKey //  18.12.2012 CBASE-CR-LSY-12002 KLW: Wertebereich angepast
		decimal dcOldReserve

		sFind = "npl_type = " + string(lPltype) + " and npl_index_key = " + string(lds_explosion.getItemNumber(k,"npackinglist_index_key")) + &
				" and npl_detail_key = " + string(lds_explosion.getItemNumber(k,"npackinglist_detail_key")) + &
				" and nreckoning = " + string(lds_explosion.getItemNumber(k,"nreckoning"))   + & 
				" and nmaster_index_key = " + string(lds_explosion.getItemNumber(k,"nmaster_index_key"))   + & 
				" and nancestor_index_key = " + string(lds_explosion.getItemNumber(k,"nancestor_pl_index_key")) + &
				" and cclass ='" + dsCenOutMasterLevel1.getItemString(j,"cclass") + "' and nclass_number = " + string(dsCenOutMasterLevel1.getItemNumber(j,"nclass_number"))  /* TBR 23.04.2004 */   +   &      
				" and csales_rel ='" + lds_explosion.getItemString(k,"csales_rel") + "'" /* HR 24.03.2011 */ + &
				" and cpost_type_short = '"+dsCenOutMasterLevel1.getItemString(j,"cpost_type_short")+"' " /* 31.08.2011 HR: Abrechnungskennzeichen einbeziehenn */+ &
				" and cgoods_recipient ='"+lds_explosion.getItemString(k,"cgoods_recipient")+"'" /* HR 05.09.2011 Findet erweitert um cgoods_recipient */ +&
				" and cpackinglist_xsl ='"+isPackinglistXsl+"'" /* 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste */

		// --------------------------------------------------------------------------------------------------------------------
		// 14.06.2012 HR: Falls Schalter eingeschaltet, dann Gruppieren wir noch nach Loadinglist und Abrechnungscode2
		// --------------------------------------------------------------------------------------------------------------------
		if ii_GroupPlBySslZblAc2 = 1 then
			sFind += " and cloadinglist = '"+sfromloadinglist+"'"
			sFind += " and cadditional_account = '"+sAdditionalAccount+"'"
		end if

		lFind = lds_explosion_container.Find(sFind,1,lds_explosion_container.RowCount())
	
		if lFind > 0 then
			lLocalAncesterDetailKey   = lds_explosion.GetItemNumber(k,"nancestor_seq_nr")
			lLocalMasterDetailKey 	=  lds_explosion.GetItemNumber(k,"nmaster_seq_nr")
			
			// Packinglist gibt's schon => kumulieren
			dcOldQuantity   = lds_explosion_container.GetItemDecimal(lFind,"nquantity")
			dcOldQuantity   = dcOldQuantity + lds_explosion.getItemDecimal(k,"nquantity_cal")
			lds_explosion_container.SetItem(lFind,"nquantity", dcOldQuantity)
			
			// --------------------------------------------------------------------------------------------------------------------
			// 31.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r die Version
			// --------------------------------------------------------------------------------------------------------------------
			dcOldQuantity   = lds_explosion_container.GetItemDecimal(lFind,"nquantity_version")
			dcOldQuantity   = dcOldQuantity + lds_explosion.getItemDecimal(k,"nquantity_version")
			lds_explosion_container.SetItem(lFind,"nquantity_version", dcOldQuantity)
			
			lds_explosion_container.SetItem(lFind,"nstatus",98)
	
			// 17.05.2006 Auch Reserven zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
			dcOldReserve   = lds_explosion_container.GetItemDecimal(lFind,"nreserve")
			dcOldReserve   = dcOldReserve + lds_explosion.getItemNumber(k,"nreserve")
			lds_explosion_container.SetItem(lFind,"nreserve", dcOldReserve)

			// --------------------------------------------------------------------------------------------------------------------
			// 31.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r die Version
			// --------------------------------------------------------------------------------------------------------------------
			dcOldReserve   = lds_explosion_container.GetItemDecimal(lFind,"nreserve_version")
			dcOldReserve   = dcOldReserve + lds_explosion.getItemNumber(k,"nreserve_version")
			lds_explosion_container.SetItem(lFind,"nreserve_version", dcOldReserve)
			
			// 23.04.2009 HR: Wenn kummuliert wird, dann muss der ancester_detail_key f$$HEX1$$fc00$$ENDHEX$$r alle evtl. untergeordnete SL angepa$$HEX1$$df00$$ENDHEX$$t werden.
			for i=1 to lds_explosion.rowcount()
				if (   lds_explosion.GetItemNumber(i,"nmaster_seq_nr")=lLocalMasterDetailKey) and &
					(lds_explosion.GetItemNumber(i,"nancestor_seq_nr")= lLocalAncesterDetailKey) then
					
					lds_explosion.SetItem(i,"nancestor_seq_nr", lds_explosion_container.GetItemNumber(lFind,"nancestor_detail_key"))
				end if
			next
		else
			a=lds_explosion_container.insertRow(0)
			lds_explosion_container.SetItem(a,"cpart_unit",sPlant) // 14.03.2012 HR: Partitionierung nach Betrieb
			lds_explosion_container.setitem(a,"ndetail_key",lds_explosion.getItemNumber(k,"nsequence"))  
			lds_explosion_container.setitem(a,"npl_index_key",lds_explosion.getItemNumber(k,"npackinglist_index_key"))  
			lds_explosion_container.setitem(a,"npl_detail_key",lds_explosion.getItemNumber(k,"npackinglist_detail_key"))    
			lds_explosion_container.setitem(a,"cpackinglist",lds_explosion.getItemString(k,"cpackinglist"))      
			lds_explosion_container.setitem(a,"ctext",lds_explosion.getItemString(k,"ctext"))        
			lds_explosion_container.setitem(a,"cunit",lds_explosion.getItemString(k,"cunit"))          
			lds_explosion_container.setitem(a,"nquantity",lds_explosion.getItemDecimal(k,"nquantity_cal"))            
			lds_explosion_container.setitem(a,"nquantity_version",lds_explosion.getItemDecimal(k,"nquantity_version"))  // 31.01.2013 HR:
			lds_explosion_container.setitem(a,"nstatus",lds_explosion.getItemNumber(k,"nstatus"))  
			lds_explosion_container.setitem(a,"narea_key",lds_explosion.getItemNumber(k,"narea_key"))      
			lds_explosion_container.setitem(a,"nworkstation_key",lds_explosion.getItemNumber(k,"nworkstation_key"))    
			lds_explosion_container.setitem(a,"nreserve",lds_explosion.getItemNumber(k,"nreserve"))      
			lds_explosion_container.setitem(a,"nreserve_version",lds_explosion.getItemNumber(k,"nreserve_version"))    // 31.01.2013 HR:    
			lds_explosion_container.setitem(a,"nreckoning",lds_explosion.getItemNumber(k,"nreckoning"))   
			lds_explosion_container.setitem(a,"npl_kind_key",lds_explosion.getItemNumber(k,"npl_kind_key"))     
			lds_explosion_container.setitem(a,"npackinglist_key",lds_explosion.getItemNumber(k,"npl_type_key"))       
			lds_explosion_container.setitem(a,"nmaster_index_key",lds_explosion.getItemNumber(k,"nmaster_index_key"))         
			lds_explosion_container.setitem(a,"nlevel",lds_explosion.getItemNumber(k,"nlevel"))           
			lds_explosion_container.setitem(a,"npercent",lds_explosion.getItemNumber(k,"npercent"))             
			lds_explosion_container.setitem(a,"nancestor_index_key",lds_explosion.getItemNumber(k,"nancestor_pl_index_key"))            
			lds_explosion_container.setitem(a,"nancestor_detail_key", lds_explosion.getItemNumber(k,"nancestor_seq_nr"))  
			lds_explosion_container.setitem(a,"ccustomer_pl",lds_explosion.getItemString(k,"ccustomer_pl"))        
			lds_explosion_container.setitem(a,"ccustomer_pl_text",lds_explosion.getItemString(k,"ccustomer_text"))     
			lds_explosion_container.setitem(a,"csales_rel", lds_explosion.getItemString(k,"csales_rel"))       
			lds_explosion_container.setitem(a,"cgoods_recipient", lds_explosion.getItemString(k,"cgoods_recipient"))       
			lds_explosion_container.setitem(a,"cdef_storage_location", lds_explosion.getItemString(k,"cdef_storage_location"))     
			lds_explosion_container.setitem(a,"nmaster_detail_key", lds_explosion.getItemNumber(k,"nmaster_seq_nr"))  
			
			lds_explosion_container.setitem(a,"nhandling_id",dsCenOutMasterLevel1.getItemNumber(j,"nhandling_id"))  
			lds_explosion_container.setitem(a,"nfreq_key",dsCenOutMasterLevel1.getItemNumber(j,"nfreq_key"))    
			lds_explosion_container.setitem(a,"cloadinglist",dsCenOutMasterLevel1.getItemString(j,"cloadinglist"))      
			lds_explosion_container.setitem(a,"cclass" ,dsCenOutMasterLevel1.getItemString(j,"cclass"))       
			lds_explosion_container.setitem(a,"nclass_number" ,dsCenOutMasterLevel1.getItemNumber(j,"nclass_number"))         
			lds_explosion_container.setitem(a,"naccount_key",  dsCenOutMasterLevel1.getItemNumber(j,"naccount_key"))   
			lds_explosion_container.setitem(a,"caccount", dsCenOutMasterLevel1.getItemString(j,"caccount"))         
			lds_explosion_container.setitem(a,"nparams_key1",  dsCenOutMasterLevel1.getItemNumber(j,"nparams_key1"))     
			lds_explosion_container.setitem(a,"nparams_key2",  dsCenOutMasterLevel1.getItemNumber(j,"nparams_key2"))     
			lds_explosion_container.setitem(a,"nparams_key3",  dsCenOutMasterLevel1.getItemNumber(j,"nparams_key3"))     
			lds_explosion_container.setitem(a,"nparams_min",  dsCenOutMasterLevel1.getItemNumber(j,"nparams_min"))     
			lds_explosion_container.setitem(a,"cpost_type_short", dsCenOutMasterLevel1.getItemString(j,"cpost_type_short"))          
			
			lds_explosion_container.setitem(a,"ntransaction",lTransaction) 
			lds_explosion_container.setitem(a,"nresult_key",lResultKey)
			lds_explosion_container.setitem(a,"npl_type",lplType)  
			lds_explosion_container.setitem(a,"naction",1)  
			lds_explosion_container.setitem(a,"dtimestamp",datetime(today(),now()))

			// --------------------------------------------------------------------------------------------------------------------
			// 14.06.2012 HR: Die neu f$$HEX1$$fc00$$ENDHEX$$r CateringCore zu f$$HEX1$$fc00$$ENDHEX$$llenden Felder werden gef$$HEX1$$fc00$$ENDHEX$$llt.
			// --------------------------------------------------------------------------------------------------------------------
			lds_explosion_container.setitem(a,"cloadinglist",sfromloadinglist)
			lds_explosion_container.setitem(a,"cadditional_account",sAdditionalAccount)
			
			// --------------------------------------------------------------------------------------------------------------------
			// 30.08.2012 HR: ACCOUNT-Infos werden jetzt von der Aufl$$HEX1$$f600$$ENDHEX$$sung mit gef$$HEX1$$fc00$$ENDHEX$$llt
			// --------------------------------------------------------------------------------------------------------------------
			//lds_explosion_container.setitem(a,"caccount",lsAccount)
			//lds_explosion_container.setitem(a,"naccount_key",llaccount_key)
			lds_explosion_container.setitem(a,"caccount", lds_explosion.getItemstring(k,"caccount"))
			lds_explosion_container.setitem(a,"naccount_key", lds_explosion.getItemNumber(k,"naccount_key"))
			
			// --------------------------------------------------------------------------------------------------------------------
			// 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste
			// --------------------------------------------------------------------------------------------------------------------
			lds_explosion_container.setitem(a,"nportion", lds_explosion.getItemDecimal(k,"nportion"))
			
			// --------------------------------------------------------------------------------------------------------------------
			// 19.03.2013 HR: F$$HEX1$$fc00$$ENDHEX$$llen des Zeigers auf das Produktionszeitfensters
			// --------------------------------------------------------------------------------------------------------------------
			lds_explosion_container.setitem(a,"npltimeframe_index", lds_explosion.getItemNumber(k,"npltimeframe_index"))
			lds_explosion_container.setitem(a,"dprod_date", lds_explosion.getItemDatetime(k,"dprod_date"))

			// --------------------------------------------------------------------------------------------------------------------
			// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
			// --------------------------------------------------------------------------------------------------------------------
			lds_explosion_container.setitem(a,"cpackinglist_xsl", isPackinglistXsl)
			
			// --------------------------------------------------------------------------------------------------------------------
			// 23.05.2014 HR: CBASE-HKG-CR-2014-005: Speichern des Produktionstextes
			// --------------------------------------------------------------------------------------------------------------------
			lds_explosion_container.setitem(a,"ctext_short",  lds_explosion.getItemstring(k,"ctext_short"))
			
			// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
			lds_explosion_container.setitem(a,"NPARTIALSUBSTITUTION", dsCenOutMasterLevel1.GetItemNumber(j, "NPARTIALSUBSTITUTION"))
		end if		
	next	
	//lds_explosion_container.saveas("D:\TESTXLS\TEST-"+string(j,"00000")+"-Ziel.XLS",EXCEL!,TRUE)

next

dsCenOutMasterLevel1.reset()
lds_explosion_container.rowscopy(1,lds_explosion_container.rowCount(),primary!,dsCenOutMasterLevel1,1,primary!)
//dsCenOutMasterLevel1.saveas("D:\TESTXLS\TEST-NACH.XLS",EXCEL!,TRUE)

destroy(lds_explosion)
destroy(lds_explosion_container)
return 0
end function

protected function long of_get_customer_id (long al_indexkey, long al_detailkey, long al_airlinekey, ref string ref_as_customerid, ref string ref_as_customertext, boolean ab_all);
/* 
* Function: 			of_get_customer_id  (intern)
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

public function boolean of_start_for_flight_areachange (long arg_resultkey, long arg_packinglist_index_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_start_for_flight_areachange (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_resultkey
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
// f$$HEX1$$fc00$$ENDHEX$$hrt komplette Matdispo (Zeitungen und normales Zeug) f$$HEX1$$fc00$$ENDHEX$$r einen Flug aus nach einer 
// Bereichszuordnungs$$HEX1$$e400$$ENDHEX$$nderung einer SL
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  04.09.2012	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long							i, lrow, lfind, lreplace, lmaster, j, lrow2
long 							lSQLCode
long 							lSQLRow
uo_generate_datastore 	lds_explode
uo_generate_datastore 	lds_cen_out_master
string							ls_abflug
string 						sSQLErrorText

dsFlightsOnly.DataObject						= "dw_exp_pax_of_one_flight"
dsFlightsOnly.SetTransObject(SQLCA)

// Mit Result-Key nach cen_out, Properties holen und setzen, dann Matdispo ansto$$HEX1$$df00$$ENDHEX$$en.
dsFlightsOnly.Retrieve(arg_resultkey)
if dsFlightsOnly.RowCount() = 0 then
	return false
end if

// --------------------------------------------------------------------------------------------------------------------
// Setzen der notwendigen Objekt-Properties
// --------------------------------------------------------------------------------------------------------------------
sAirlineCode					= dsFlightsOnly.GetItemString(1,"cen_out_cairline")
lFlightNumber 				= dsFlightsOnly.GetItemNumber(1,"cen_out_nflight_number")
sAirline						= sAirlineCode
dgenerationdate 			= date(dsFlightsOnly.GetItemDateTime(1,"cen_out_ddeparture"))
sClient						= dsFlightsOnly.GetItemString(1,"cen_out_cclient")
sPlant							= dsFlightsOnly.GetItemString(1,"cen_out_cunit")
ls_abflug						= dsFlightsOnly.GetItemString(1,"cen_out_cdeparture_time")
lAirlineKey					= dsFlightsOnly.GetItemNumber(1,"cen_out_nairline_key")

il_customer_key			= dsFlightsOnly.GetItemNumber(1,"ncustomer_key")// 01.10.2012 HR: Wir brauchen den Kunden-key und nicht den Airline-key

// Check der notwendigen Objekt-Properties
if isnull(dgenerationdate) then
	return false
end if

if isnull(sClient) then
	return false
end if

if isnull(sPlant) then
	return false
end if

if isnull(lAirlineKey) then
	return false
end if

of_trace(1,1,"[of_start_for_flight_areachange] "+"Start Packing List Explosion for one flight (AREACHANGE): Client = " + sClient + "; Unit = " + sPlant + "; Flight = " + sAirline +" " + string(lFlightNumber)+" / "+string(dgenerationdate,"dd.mm.yy"))

lds_cen_out_master = create uo_generate_datastore
lds_cen_out_master.dataobject="dw_cen_out_master_for_flight"
lds_cen_out_master.SetTransObject(SQLCA)
lds_cen_out_master.retrieve(arg_resultkey)

if lds_cen_out_master.rowcount()=0 then
	of_trace(1,1,"[of_start_for_flight_areachange] "+"No Rows in cen_out_master for Flight")
	destroy(lds_cen_out_master)
	return false
else
	of_trace(1,1,"[of_start_for_flight_areachange] "+string(lds_cen_out_master.rowcount())+" Rows in cen_out_master for Flight" )
end if

lds_explode = create uo_generate_datastore
lds_explode.dataobject="dw_plsql_explode_one_sl"
lds_explode.SetTransObject(SQLCA)

lds_explode.retrieve(arg_packinglist_index_key,  dgenerationdate, sPlant, ls_abflug)
if lds_explode.rowcount()=0 then
	of_trace(1,1,"[of_start_for_flight_areachange] "+"No Rows in Explosion for PL " + string(arg_packinglist_index_key))
	destroy(lds_explode)
	destroy(lds_cen_out_master)
	return false
else
	of_trace(1,1,"[of_start_for_flight_areachange] "+string(lds_explode.rowcount())+" Rows in Explosion for PL " + string(arg_packinglist_index_key) )
end if

lrow = 0 
lreplace = 0
do
	lfind = lds_cen_out_master.find("npl_index_key = "+string(lds_explode.getitemnumber(1,"npackinglist_index_key")),lrow +1, lds_cen_out_master.rowcount())
	
	if lfind > lrow then
		lrow = lfind
		lds_cen_out_master.setitem(lrow,"narea_key",lds_explode.getitemnumber(1,"narea_key"))
		lds_cen_out_master.setitem(lrow,"nworkstation_key",lds_explode.getitemnumber(1,"nworkstation_key"))
		lmaster = lds_cen_out_master.getitemnumber(lrow,"nmaster_index_key")
		lreplace++
	else
		lrow = -1
		exit
	end if	
	
	if lds_explode.rowcount()>1 then
		for i = 2 to lds_explode.rowcount()
			lrow2 = lrow 
			do
				lfind = lds_cen_out_master.find("nmaster_index_key = "+string(lmaster)+" and nancestor_index_key = "+string(lds_explode.getitemnumber(i,"nancestor_pl_index_key"))+" and npl_index_key = "+string(lds_explode.getitemnumber(i,"npackinglist_index_key")),lrow2 +1, lds_cen_out_master.rowcount())
				
				if lfind > lrow2 then
					lrow2 = lfind
					lds_cen_out_master.setitem(lrow2,"narea_key",lds_explode.getitemnumber(i,"narea_key"))
					lds_cen_out_master.setitem(lrow2,"nworkstation_key",lds_explode.getitemnumber(i,"nworkstation_key"))
					lreplace++
				else
					lrow2 = -1
					exit
				end if
			loop until lrow2 = -1
		next		
	end if
loop until lrow = -1

of_trace(1,1,"[of_start_for_flight_areachange] "+"Exchange " + string(lreplace) + " Rows in cen_out_master")

lrow = CPU()

if lds_cen_out_master.Update() <> 1 then
	lSQLCode       	= lds_cen_out_master.lSQLErrorDBCode
	lSQLRow        	= lds_cen_out_master.lSQLErrorRow
	sSQLErrorText  = lds_cen_out_master.sSQLErrorText
	
	of_trace(3,1,"[of_start_for_flight_areachange] "+"Error writing to database table cen_out_master: code/row/text: " + string(lSQLCode) + "/" + string(lSQLRow) + "/" + sSQLErrorText )
	
	rollback;
	
	destroy(lds_cen_out_master)
	destroy(lds_explode)
	
	return false	
end if

lfind = CPU()

of_trace(1,1,"[of_start_for_flight_areachange] "+"Save cen_out_master " + string(lfind - lrow,"#,##0") + " msek")

destroy(lds_cen_out_master)
destroy(lds_explode)

return true

end function

public function integer of_resolve_packinglist (long arg_index_key, decimal arg_master_quantity, integer arg_level, integer arg_reckoning, decimal arg_master_reserve, integer arg_master_percentage, long arg_master_area, long arg_master_ws, longlong arg_master_detail_key, longlong arg_ancester_detail_key, string arg_cclass, integer arg_nclass_number, string arg_csalesrel, string arg_cdefstoragelocation, string arg_cgoodsrecipient, string arg_caccount, long arg_naccount, decimal arg_master_quantity_vers, decimal arg_master_reserve_vers);// ===========================================================================================================
//
// of_resolve_packinglist
//
// Rekursive St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung
//
// ===========================================================================================================
//
// 26.08.2004:  St$$HEX1$$fc00$$ENDHEX$$cklistentypen ber$$HEX1$$fc00$$ENDHEX$$cksichtigen!
// 30.08.2005:  PL-Key der $$HEX1$$fc00$$ENDHEX$$bergeordneten St$$HEX1$$fc00$$ENDHEX$$ckliste durchreichen
// 06.09.2005:  lMasterAreaKey oder "vor$$HEX1$$fc00$$ENDHEX$$bergehenden" Master als Bereich verwenden
// 17.05.2006:  Durchreichen von Status nreckoning (A/P/I) und Reserven
// 18.05.2006:  Durchreichen von Area und Workstation als Parameter
// 20.09.2006:  Ausstieg bei arg_level > 20
// 05.10.2007:  Reserven nur noch berechnen, wenn nuse_reserve in sys_packinglist_kinds gesetzt ist
// 23.04.2009:  2 neue Parameter eingef$$HEX1$$fc00$$ENDHEX$$hrt, die den Schl$$HEX1$$fc00$$ENDHEX$$ssel des vorg$$HEX1$$e400$$ENDHEX$$ngers und Toplevel-SL enthalten (HR)
// 20.08.2009:  Customer PL & Text 
// 10.09.2009:  Account Code / Key
// ===========================================================================================================
long         	j
long         	lRow, lRowDetail
long         	lcnt2
long         	lFind2, lFindPackinglist, lFind
string       	sFind2, sFind
LONGLONG  	lSequence
datetime     	dttimestamp
datetime     	dtnow
datastore    	dsDetail

//
// Host-Variablen lokal wg. rekursivem Aufruf
//
string       	lsPackinglist
string       	lsPLText
string       	lsPLTextShort
string       	lsItemlist
string       	lsItemlistText
string       	lsItemlist_Unit
long         	llQuantity
long         	llPriority
long         	llItemIndexKey
long         	llItemDetailKey
long         	llGebinde
decimal      	ldcQuantity
decimal 		ldcQuantityVersion		// 30.01.2013 HR:
decimal      	ldcOldQuantity
integer      	liPackinglistLevel
integer      	liReckoning
decimal      	ldcReserve
decimal      	ldcReserveVersion		// 30.01.2013 HR:
integer      	liReservePercent
long         	llArea
long         	llWorkstation
integer      	iUseReserve
String       	lsCustomer_PL
String       	lsCustomer_PL_Text
String       	lsAccount
Long         	llAccount_Key
Integer      	li_Succ

string ls_SalesRel, ls_DefStorageLocation, ls_GoodsRecipient

//
// Ausstieg bei Level > 20
//
if arg_level > 20 then
   of_trace(1,1,"Fatal Error: Resolve Packinglist Level " + &
                  string(arg_level) + " beyond limit of 20!!! [of_resolve_packingist]")
   return -1
end if

dtnow = datetime(today(),now())

of_trace(1,50,"Result_key = " + string(lResultKey) + "; Resolve Packinglist Level " + &
               string(arg_level) + " [of_resolve_packingist]")
//of_trace(1,50,"Result_key = " + string(lResultKey) + "; PL: " + &
//               f_get_packinglist(arg_index_key) + " Menge: " + string(arg_master_quantity) + " [of_resolve_packingist]")
//
//
// Detail-Datastore anlegen
//
dsDetail   = Create DataStore

//
// Detail-Datastore abh$$HEX1$$e400$$ENDHEX$$ngig vom St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//
Choose Case lPLType
   case 1
      dsDetail.DataObject   = "dw_packinglist_content"
   case 2
      dsDetail.DataObject   = "dw_news_packinglist_content"
end choose

dsDetail.SetTransObject(SQLCA)


//
// Retrieve auf PL Stammdaten
//
dsDetail.Retrieve(arg_index_key, dgenerationdate)
lcnt2 = dsDetail.RowCount()

//
// 06.10.2003: Suche nach Packinglist in Packinglist
//
lFindPackinglist = dsDetail.find("item_npacking_list_level = 2",1,dsDetail.RowCount() )
if lFindPackinglist = 0 then
   destroy dsDetail
   return 0
end if

//
// Packinglist-Details ermitteln
//
for j = 1 to dsDetail.RowCount()
   Choose Case lPLType
      case 1
         //
         // St$$HEX1$$fc00$$ENDHEX$$cklisten
         //
			lsPackinglist         		= dsDetail.GetItemString(j,"cen_packinglist_index_cpackinglist")
			lsPLText              		= dsDetail.GetItemString(j,"cen_packinglists_ctext")
			ldcQuantity           		= dsDetail.GetItemDecimal(j,"cen_packinglist_detail_nquantity")   // Anzahl St$$HEX1$$fc00$$ENDHEX$$ckliste in der St$$HEX1$$fc00$$ENDHEX$$ckliste
			dcPortion           		= dsDetail.GetItemDecimal(j,"cen_packinglist_detail_nquantity")   // 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r Schneideliste
			llPriority            		= dsDetail.GetItemNumber(j,"cen_packinglist_detail_nsort")
			llItemIndexKey        	= dsDetail.GetItemNumber(j,"item_npackinglist_index_key")
			llItemDetailKey       	= dsDetail.GetItemNumber(j,"item_npackinglist_detail_key")
			lsItemlist            		= dsDetail.GetItemString(j,"item_cpackinglist")
			lsItemlistText        	= dsDetail.GetItemString(j,"item_ctext")
			liPackinglistLevel    	= dsDetail.GetItemNumber(j,"item_npacking_list_level")
			lsItemlist_Unit       	= dsDetail.GetItemString(j,"item_cunit")                        // Die Einheit der St$$HEX1$$fc00$$ENDHEX$$ckliste 
			iUseReserve           	= dsDetail.GetItemNumber(j,"nuse_reserve")
			lsCustomer_PL       	= dsDetail.GetItemString(j,"ccustomer_pl")
			lsCustomer_PL_Text	= dsDetail.GetItemString(j,"ccustomer_text")
			
			lsPLTextShort			= of_ctext_short(lsItemlistText, dsDetail.GetItemString(j,"cen_packinglists_ctext_short"))	// 23.05.2014 HR: CBASE-HKG-CR-2014-005
			// 20.11.2014 HR: lsPLText durch lsItemlistText ersetzten
			
			lsAccount             		= dsDetail.GetItemString(j,"cAccount")
			llaccount_key         	= dsDetail.GetItemNumber(j,"nAccount_Key")
			
			if isnull(lsAccount) then
				lsAccount = arg_caccount
				llaccount_key = arg_naccount
			end if
			
			if isnull(iUseReserve) then iUseReserve = 0
         
			// --------------------------------------------------------
			// 07.01.2009, KF
			// Zusatztexte (St$$HEX1$$fc00$$ENDHEX$$ckliste Z) nicht aufl$$HEX1$$f600$$ENDHEX$$sen !!!
			// --------------------------------------------------------
			if Trim(lsItemlist) = "Z" then continue
						
			//
			// Anzahl Gebinde mu$$HEX2$$df002000$$ENDHEX$$ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
			//
			llGebinde            = dsDetail.GetItemNumber(j,"nnumber_packages")
			if llGebinde > 0 then
				//
				// 22.04.2006 Nur ber$$HEX1$$fc00$$ENDHEX$$cksichtigen, wenn Gebindeflag gesetzt
				//
				if iGebindeFlag = 1 then
					ldcQuantity       = ldcQuantity * llGebinde
				end if
			end if
			//
			// Reckoning vom Detail
			//   19.05.06: lireckoning verwenden
			//
			lireckoning            	= dsDetail.GetItemNumber(j,"nreckoning")
			if isnull(lireckoning) then lireckoning = 0
			lPackinglistKind 	= dsDetail.GetItemNumber(j,"cen_packinglist_index_npl_kind_key")
			lPackinglistType  	= dsDetail.GetItemNumber(j,"cen_packinglists_npackinglist_key")
			
			// --------------------------------------------------------------------------------------------------------------------
			// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
			// --------------------------------------------------------------------------------------------------------------------
			if dsDetail.GetItemstring(j,"csales_rel")>' ' then 
				ls_SalesRel = dsDetail.GetItemstring(j,"csales_rel")
			else
				ls_SalesRel = arg_cSalesRel
			end if
			
			if dsDetail.GetItemstring(j,"cdef_storage_location")>' ' then 
				ls_DefStorageLocation	= dsDetail.GetItemstring(j,"cdef_storage_location")
			else
				ls_DefStorageLocation	= arg_cDefStorageLocation
			end if
				
				
			if dsDetail.GetItemstring(j,"cgoods_recipient")>' ' then 
				ls_GoodsRecipient = right(dsDetail.GetItemstring(j,"cgoods_recipient"), 7) // 09.09.2015 HR: Immer 7 Stellen von rechts
			else
				ls_GoodsRecipient = arg_cGoodsRecipient
			end if
			
			// --------------------------------------------------------------------------------------------------------------------
			// 10.09.2015 HR: CCS-TEMP-2015-1308, Bei SALES-REL m$$HEX1$$fc00$$ENDHEX$$ssen wir den richtigen ACCOUNTCODE holen 
			// --------------------------------------------------------------------------------------------------------------------
			if ls_SalesRel = "1" then
				of_get_account4goodsrecipient(lAirlineKey, ls_GoodsRecipient, lsAccount, llaccount_key)
			end if

      case 2
			//
			// Lesematerial
			//
			
			lsPackinglist          	= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl")
			lsPLText               		= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper")
			llQuantity             		= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nquantity" + string(iDay) )
			llPriority             		= dsDetail.GetItemNumber(j,"cen_news_pl_detail_nsort")
			llItemIndexKey    		= dsDetail.GetItemNumber(j,"cen_news_pl_detail_ndetail_key")
			llItemDetailKey  		= dsDetail.GetItemNumber(j,"cen_news_pl_nnews_pl_detail_key")
			lsItemlist             		= dsDetail.GetItemString(j,"cen_news_pl_index_cnews_pl_1")
			lsItemlistText     		= dsDetail.GetItemString(j,"cen_news_pl_index_cnewspaper_1")
			liPackinglistLevel		= dsDetail.GetItemNumber(j,"cen_news_pl_npacking_list_level")
			lsItemlist_Unit   		= ""   // Newspaper erstmal keine Einheit
			iUseReserve      		= 0  // 05.10.2007, KF, Keine Reserven f$$HEX1$$fc00$$ENDHEX$$r Zeitungen
			
			setnull(dcPortion)					// 05.11.2012 HR: Portionsgr$$HEX2$$f600df00$$ENDHEX$$e bei Zeitungen irelevant
			setnull(il_pltimeframe_index)	// 19.03.2013 HR: Produktionszeitfenster bei Zeitungen irelevant
			lsPLTextShort			= ""		// 23.05.2014 HR: CBASE-HKG-CR-2014-005
			liReckoning        		= 0
			lPackinglistKind  		= 0
			lPackinglistType   		= 0
			lsCustomer_PL     		= ""
			lsCustomer_PL_Text 	= ""
			lsAccount               	= ""
			SetNULL(llAccount_Key)
			
			// --------------------------------------------------------------------------------------------------------------------
			// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
			// --------------------------------------------------------------------------------------------------------------------
			ls_SalesRel 				= ' '
			ls_DefStorageLocation 	= ' '
			ls_GoodsRecipient 		= ' '
   end choose
   
   //
   // Menge ist Master-Menge mal Menge
   //
	
	ldcQuantityVersion = ldcQuantity * arg_master_quantity_vers // 30.01.2013 HR: Aufl$$HEX1$$f600$$ENDHEX$$sung f$$HEX1$$fc00$$ENDHEX$$r die Versionsmenge
	
  	ldcQuantity = ldcQuantity * arg_master_quantity
   
   //
   // Check Packinglist-Level:
   // Haben wir St$$HEX1$$fc00$$ENDHEX$$cklisten in der St$$HEX1$$fc00$$ENDHEX$$ckliste?
   // Falls ja, dann keinen cen_out_detail-Eintrag f$$HEX1$$fc00$$ENDHEX$$r die St$$HEX1$$fc00$$ENDHEX$$ckliste erzeugen, 
   // jedoch f$$HEX1$$fc00$$ENDHEX$$r die Inhalte!
   //
   if liPackinglistLevel = 2 and lPLType = 1 then
      //
      // kein Increment, nur Insert in den neuen Datastore dsCenOutMasterLevelN
      //
      //
      // Packinglist wird in dsCenOutMasterLevelN anlegt
      //
      // keine Sequence, da diese erst vor dem Speichern vergeben werden sollte,
      // also nach dem $$HEX1$$dc00$$ENDHEX$$bertrag und der Kumulierung in dsCenOutMasterLevel1
      //
      
	// 23.04.2009 HR: Sequence wird ben$$HEX1$$f600$$ENDHEX$$tigt, um die abh$$HEX1$$e400$$ENDHEX$$ngigkeiten festzuhalten 
	// --------------------------------------------------------------------------------------------------------------------
	// 26.02.2013 HR: Umstellung der Sequence auf LONGLONG
	// --------------------------------------------------------------------------------------------------------------------
	lSequence = f_Sequence_ll("seq_cen_out_master", sqlca)
	if lSequence = -1 then
		return -1
	end if
	
		
      //
      // 06.09.05   Workstation Key vom aktuellen Master bereits jetzt ermitteln und 
      //            bei den enthaltenen PLs setzen
      //            Achtung: Find weicht ab: llItemIndexKey
      //
      sFind =    "npackinglist_index_key = " + string(llItemIndexKey) + &
               " and ctime_from <= '" + string(tdepartureTime,"hh:mm") + &
               "' and ctime_to >= '" + string(tdepartureTime,"hh:mm") + "'"
      lFind = dsLocalWorkstations.Find(sFind,1,dsLocalWorkstations.RowCount())
      
      if lFind > 0 then
         lSubAreaKey               	= dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
         lSubWorkstationKey  	= dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
         //
         // 18.05.06 Neue Ermittlung Area/Workstation
         //
         llArea  		 	= dsLocalWorkstations.GetItemNumber(lFind,"narea_key")
         llWorkstation	= dsLocalWorkstations.GetItemNumber(lFind,"nworkstation_key")
         //
         // 17.05.06 Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
         //
         liReservePercent         = dsLocalWorkstations.GetItemNumber(lFind,"npercent")   
         if isnull(liReservePercent) then liReservePercent = 0 // 04.07.06 immer fixe Menge
         
         ldcReserve               = dsLocalWorkstations.GetItemNumber(lFind,"loc_unit_pl_reserve_nday" + string(iDay))
         
         //
         // L$$HEX1$$f600$$ENDHEX$$sung am 04.07.06: Pr$$HEX1$$fc00$$ENDHEX$$fung ob % = 1 und nday = 0 ist
         //
         if liReservePercent = 1 and ldcReserve = 0 then
            iReservePercent = 0
         end if
      else
         //   vor 18.05.06
         //         if arg_level = 2 then
         //            lSubAreaKey               = lMasterAreaKey
         //            lSubWorkstationKey      = lMasterWorkstationKey
         //         end if
         //
         // 18.05.06 Neue Ermittlung Area/Workstation
         //
         llArea           		= arg_master_area
         llWorkstation		= arg_master_ws
         //
         // 17.05.06 Reserven ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
         //
         liReservePercent	= arg_master_percentage
         ldcReserve			= 0
      end if
      
      //
      // Berechnung der Reserve abh$$HEX1$$e400$$ENDHEX$$ngig vom Reservetyp (Prozentual, Fix)
      //
      if arg_master_percentage = 1 then
         //
         // Wenn Master-Reserve in Prozent, dann ab sofort Prozent
         // Ausserdem gilt: H$$HEX1$$f600$$ENDHEX$$here Prozentzahl gewinnt
         //
         liReservePercent = 1

         // --------------------------------------------------------------------------------------------------------------------
		// 30.01.2013 HR: Das Ganze auch f$$HEX1$$fc00$$ENDHEX$$r die Versionsreseve
		// --------------------------------------------------------------------------------------------------------------------
		if ldcReserveVersion > arg_master_reserve_vers then
            ldcReserveVersion = ldcReserve
         else
            ldcReserveVersion = arg_master_reserve_vers
         end if
         
		if ldcReserve > arg_master_reserve then
            ldcReserve = ldcReserve
         else
            ldcReserve = arg_master_reserve
         end if

	else
         //
         // Master-Reserve feste Menge
         //
         if liReservePercent = 1 then
            //
            // Wenn Master-Reserve fix war, und neue Reserve Prozent wird,
            // dann ab sofort weiter mit Prozent und ohne die Master-Reserve
            //
            // PL kam als feste Menge rein und wird zu Prozent
            //
            	ldcReserve 			= ldcReserve 
			ldcReserveVersion = ldcReserve // 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r die Version
         else
            //
            // falls decimalstellen, dann nix
            //
				
            if ldcQuantity = int(ldcQuantity) then
               // alt: ldcReserve = ldcReserve + arg_master_reserve

					  // --------------------------------------------------------------------------------------------------------------------
				// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r die Version berechnen
				// --------------------------------------------------------------------------------------------------------------------
				if ldcReserve > arg_master_reserve_vers then
					ldcReserveVersion = ldcReserve
				else
					ldcReserveVersion = arg_master_reserve_vers
				end if
               
				if ldcReserve > arg_master_reserve then
					ldcReserve = ldcReserve
				else
					ldcReserve = arg_master_reserve
				end if
            else
               	ldcReserve = 0
				ldcReserveVersion=0
            end if
         end if
      end if
            
      
	dttimestamp   = datetime(today(),now())
	lRow = dsCenOutMasterLevelN.InsertRow(0)
	dsCenOutMasterLevelN.SetItem(lRow,"cpart_unit",sPlant) // 14.03.2012 HR: Partitionierung nach Betrieb
	dsCenOutMasterLevelN.SetItem(lRow,"nlevel_of_explosion",arg_level)
	dsCenOutMasterLevelN.SetItem(lRow,"nancestor_index_key",arg_index_key)
	dsCenOutMasterLevelN.SetItem(lRow,"ntransaction",lTransaction)
	dsCenOutMasterLevelN.SetItem(lRow,"nresult_key",lResultKey)
	dsCenOutMasterLevelN.SetItem(lRow,"npl_type",lPLType)
	dsCenOutMasterLevelN.SetItem(lRow,"ndetail_key",lSequence)
	dsCenOutMasterLevelN.SetItem(lRow,"npl_index_key",llItemIndexKey)
	dsCenOutMasterLevelN.SetItem(lRow,"npl_detail_key",llItemDetailKey)
	dsCenOutMasterLevelN.SetItem(lRow,"cpackinglist",lsItemlist)
	dsCenOutMasterLevelN.SetItem(lRow,"ctext",lsItemlistText)
	dsCenOutMasterLevelN.SetItem(lRow,"cunit",lsItemlist_Unit)   // Einheit
	dsCenOutMasterLevelN.SetItem(lRow,"nquantity",ldcQuantity)
	dsCenOutMasterLevelN.SetItem(lRow,"nquantity_version",ldcQuantityVersion) // 30.01.2013 HR:
	dsCenOutMasterLevelN.SetItem(lRow,"naction",1)
	dsCenOutMasterLevelN.SetItem(lRow,"dtimestamp",dttimestamp)
	dsCenOutMasterLevelN.SetItem(lRow,"nPortion",dcPortion) // 05.11.2012 HR: Speichern der Portionsgr$$HEX2$$f600df00$$ENDHEX$$e der SL
	
	// --------------------------------------------------------------------------------------------------------------------
	// 23.05.2014 HR: CBASE-HKG-CR-2014-005
	// 09.10.2014 HR: Wir sollen ggf. auch den Text mit einf$$HEX1$$fc00$$ENDHEX$$gen
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMasterLevelN.setitem(lRow,"ctext_short", lsPLTextShort)
	
	// --------------------------------------------------------------------------------------------------------------------
	// 19.03.2013 HR: F$$HEX1$$fc00$$ENDHEX$$llen des Zeigers auf das Produktionszeitfensters
	// --------------------------------------------------------------------------------------------------------------------
	lfind = ids_prod_time_frame.find("npackinglist_index_key = "+string(llItemIndexKey), 1, ids_prod_time_frame.rowcount())
	if lfind > 0 then
		il_pltimeframe_index = ids_prod_time_frame.getitemnumber(lfind, "npltimeframe_index")
		id_prod_date			= relativedate(dGenerationDate, -1 *   ids_prod_time_frame.getitemnumber(lfind, "noffset"))
	else
		setnull(il_pltimeframe_index)
		setnull(id_prod_date)
	end if
	dsCenOutMasterLevelN.setitem(lRow,"npltimeframe_index", il_pltimeframe_index)
	dsCenOutMasterLevelN.setitem(lRow,"dprod_date", id_prod_date)
	
	// --------------------------------------------------------------------------------------------------------------------
	// 07.09.2010 HR: Werte f$$HEX1$$fc00$$ENDHEX$$r Forcastprojekt speichern
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMasterLevelN.SetItem(lRow,"nparams_key1",il_FC_Parm1)
	dsCenOutMasterLevelN.SetItem(lRow,"nparams_key2",il_FC_Parm2)
	dsCenOutMasterLevelN.SetItem(lRow,"nparams_key3",il_FC_Parm3)
	dsCenOutMasterLevelN.SetItem(lRow,"nparams_min",il_FC_Parm_min)
	
	// 23.04.2009 HR:
	dsCenOutMasterLevelN.SetItem(lRow,"nmaster_detail_key",arg_master_detail_key)
	dsCenOutMasterLevelN.SetItem(lRow,"nancestor_detail_key",arg_ancester_detail_key)
	
	// 24.04.2009 TBR
	dsCenOutMasterLevelN.SetItem(lRow,"cclass",arg_cclass)
	dsCenOutMasterLevelN.SetItem(lRow,"nclass_number",arg_nclass_number)
	
	// --------------------------------------------------------------------------------------------------------------------
	// 24.03.2011 HR: Neue Felder f$$HEX1$$fc00$$ENDHEX$$r CateringCore
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMasterLevelN.SetItem(lRow,"csales_rel",ls_SalesRel)
	dsCenOutMasterLevelN.SetItem(lRow,"cdef_storage_location",ls_DefStorageLocation)
	dsCenOutMasterLevelN.SetItem(lRow,"cgoods_recipient",ls_GoodsRecipient)

	// --------------------------------------------------------------------------------------------------------------------
	// 31.08.2011 HR: Abrechnungskennzeichen setzen
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMasterLevelN.SetItem(lRow,"cpost_type_short",sPostTypeShort)

	// ----------------------------------------------------------------------------------------
      If lPLType = 1 Then // St$$HEX1$$fc00$$ENDHEX$$ckliste: Customer PL & Text
         dsCenOutMasterLevelN.SetItem(lRow,"ccustomer_pl", lsCustomer_PL)
         dsCenOutMasterLevelN.SetItem(lRow,"ccustomer_pl_text", lsCustomer_PL_Text)
			// ----------------------------------------------------------------------------------------
			// Wenn Schalter FillEmptyCustomerPL f$$HEX1$$fc00$$ENDHEX$$r Client gesetzt: leere Customer PL ersetzen
			// ----------------------------------------------------------------------------------------
			If il_FillEmptyCustomerPL = 1 Then
				If IsNULL(lsCustomer_PL) OR Trim(lsCustomer_PL) = "" Then
					dsCenOutMasterLevelN.SetItem(lRow,"ccustomer_pl", lsItemlist)
				End If
				If IsNULL(lsCustomer_PL_Text) OR Trim(lsCustomer_PL_Text) = "" Then
					dsCenOutMasterLevelN.SetItem(lRow,"ccustomer_pl_text", lsItemlistText)
				End If
			End If
			
			// Account
		   li_Succ = dsCenOutMasterLevelN.SetItem(lRow,"naccount_key", llaccount_key )
         li_Succ = dsCenOutMasterLevelN.SetItem(lRow,"caccount", lsaccount )
			
      End If
		// ----------------------------------------------------------------------------------------

      if lPLType = 1 then
         dsCenOutMasterLevelN.SetItem(lRow,"nfreq_key",0)
      else
         dsCenOutMasterLevelN.SetItem(lRow,"nfreq_key",iDay)
      end if
      dsCenOutMasterLevelN.SetItem(lRow,"nstatus",99)
      //
      // bis 16.05.06: Reckoning nicht vom Master setzen   (nreckoning)
      //
      //dsCenOutMasterLevelN.SetItem(lRow,"nreckoning",lReckoning)
      
      //
      // 17.05.06: Reckoning ggf. vom Master setzen (=arg_reckoning)
      //
		
      choose case arg_reckoning
		case 0	// Produktion + Abrechnung
         				liReckoning = liReckoning
							
         	case 1	// Produktion
					// 22.04.2009 HR: Wenn Schalter lMealExplosionWithBillingonly=0 dann wie gehabt, sonst $$HEX1$$c400$$ENDHEX$$nderung bei Abr/Prod und Abrechnung
					// 13.09.2011 HR: Schalter lMealExplosionWithBillingonly kann jetz auch 2 sein (Abrechnung f$$HEX1$$fc00$$ENDHEX$$r CateringCore
					
					choose case lMealExplosionWithBillingonly
						case 0
			         				liReckoning = liReckoning
						case 1,2
						      	choose case liReckoning
									case 0,1
										liReckoning = 1
									case 2,3
										liReckoning = 3
									case 4
										liReckoning = 4
								end choose
					end choose

		case 2	// Abrechnung
					choose case lMealExplosionWithBillingonly
						case 0,1
								if liReckoning = 3 or liReckoning = 4 then
									liReckoning = liReckoning
								else
									liReckoning = 2
								end if
						case 2
						      	choose case liReckoning
									case 0,2
										liReckoning = 2
									case 1,3
										liReckoning = 3
									case 4
										liReckoning = 4
								end choose
					end choose

		case 3, 4	// Information, Request
					dsCenOutMasterLevelN.SetItem(lRow,"nreckoning",arg_reckoning)
					liReckoning = arg_reckoning
	end choose
		
	dsCenOutMasterLevelN.SetItem(lRow,"nreckoning",liReckoning)

	// --------------------------------------------------------------------------------------------------------------------
	// 29.06.2010 HR: CBASE-NAM-CR-0011-Flt CX:
	// Bei CX-Flug und gesetztem Schalter wird bei Produktion die Menge 
	// auf 0 gesetzt. Bei Prod/Abrechnung wird der DS auf Abrechnung gesetzt
	// --------------------------------------------------------------------------------------------------------------------
	if iCNXFlag = 1 and iDoNotSet0ForCxFlights =1 then 
	
		choose case liReckoning
			case 1
				 dsCenOutMasterLevelN.SetItem(lRow,"nquantity",0)
			case 0
				dsCenOutMasterLevelN.SetItem(lRow,"nreckoning",2)
				liReckoning = 2
		 end choose

	end if
		
      dsCenOutMasterLevelN.SetItem(lRow,"npl_kind_key",lPackinglistKind)
      dsCenOutMasterLevelN.SetItem(lRow,"npackinglist_key",lPackinglistType)
      //
      // Rekursive Eintragungen:
      //
      // Urspr. Vorg$$HEX1$$e400$$ENDHEX$$nger der St$$HEX1$$fc00$$ENDHEX$$ckliste, Bereich des Vorg$$HEX1$$e400$$ENDHEX$$ngers, ...
      //
      dsCenOutMasterLevelN.SetItem(lRow,"nmaster_index_key",lMasterIndexKey)
//      dsCenOutMasterLevelN.SetItem(lRow,"narea_key",lSubAreaKey)
//      dsCenOutMasterLevelN.SetItem(lRow,"nworkstation_key",lSubWorkstationKey)
      dsCenOutMasterLevelN.SetItem(lRow,"narea_key",llArea)   // 18.05.06
      dsCenOutMasterLevelN.SetItem(lRow,"nworkstation_key",llWorkstation)
      dsCenOutMasterLevelN.SetItem(lRow,"nlevel",arg_level)
            
      // -----------------------------------------------------------------------------------------
      // 05.10.2007, KF
      // Wenn Reserveberechnung ausgeschaltet wurde, dann die zuvor berechneten Werte resetten      
      // -----------------------------------------------------------------------------------------
      if iUseReserve = 0 then
         ldcReserve 			= 0
         ldcReserveVersion	= 0	// 30.01.2013 HR: Auch f$$HEX1$$fc00$$ENDHEX$$r Version
         liReservePercent 	= 0
      end if
      
      dsCenOutMasterLevelN.SetItem(lRow,"nreserve",ldcReserve)   // 17.05.06
      dsCenOutMasterLevelN.SetItem(lRow,"nreserve_version",ldcReserveVersion)   // 30.01.2013 HR:

      dsCenOutMasterLevelN.SetItem(lRow,"npercent",liReservePercent)

	// --------------------------------------------------------------------------------------------------------------------
	// 06.06.2012 HR: Wir schreiben den Abrechnungscode2
	// --------------------------------------------------------------------------------------------------------------------
	if isnull(sAdditionalAccount) then sAdditionalAccount= " "
	dsCenOutMasterLevelN.SetItem(lRow,"cadditional_account",sAdditionalAccount)
	dsCenOutMasterLevelN.SetItem(lRow,"cloadinglist",sfromloadinglist)

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2013 HR: CBASE-DE-CR-2013-005: Speichern der Servicest$$HEX1$$fc00$$ENDHEX$$ckliste 
	// --------------------------------------------------------------------------------------------------------------------
	dsCenOutMasterLevelN.SetItem(lRow,"cpackinglist_xsl",isPackinglistXsl)
		
	// 10.10.2014 HR: teilweise LokaleErsetzung EU-Labeling
	dsCenOutMasterLevelN.SetItem(lRow,"NPARTIALSUBSTITUTION", ii_NPARTIALSUBSTITUTION)

   	// --------------------------------------------------------------------------------
	// 11.09.2009 HR: Umrechnung soll nur noch bei gesetztem Schalter erfolgen
	//                         (Schalter wird pro Durchlauf nur beim ersten Mal gelesen)
	// --------------------------------------------------------------------------------
	  if iConvertGtoKG = -1 then
			iConvertGtoKG = integer(of_cen_profilestring("OnlineExplosion","ConvertGtoKG","1",sClient)	)
	  end if
	  
	  if iConvertGtoKG = 1 then
			// -----------------------------------------------------------------------------------------
			// 29.11.2007   Dividieren der Einheiten "GR" und "ML"
			// -----------------------------------------------------------------------------------------
			if lsItemlist_Unit = "GR" then
				ldcQuantity = ldcQuantity / 1000
				dsDetail.SetItem(j,"cen_packinglist_detail_nquantity",ldcQuantity)
				dsDetail.SetItem(j,"item_cunit","KG")
			end if
			if lsItemlist_Unit = "ML" then
				ldcQuantity = ldcQuantity / 1000
				dsDetail.SetItem(j,"cen_packinglist_detail_nquantity",ldcQuantity)
				dsDetail.SetItem(j,"item_cunit","LT")
			end if
	  end if      
      //
      // n$$HEX1$$e400$$ENDHEX$$chste Ebene kontrollieren
      //
//      if of_resolve_packinglist(llItemIndexKey, ldcQuantity, arg_level + 1, liReckoning, ldcReserve, liReservePercent, llArea, llWorkstation, arg_master_detail_key, lSequence) <> 0 then

      // TBR 24.04.2009 
	 // 30.01.2013 HR: Um Versionsmenge erweitern
      if of_resolve_packinglist(llItemIndexKey, ldcQuantity, arg_level + 1, liReckoning, ldcReserve, liReservePercent, llArea, llWorkstation, arg_master_detail_key, lSequence, arg_cclass, arg_nclass_number, ls_SalesRel, ls_DefStorageLocation, ls_GoodsRecipient, lsAccount, llaccount_key, ldcQuantityVersion, ldcReserveVersion ) <> 0 then         
		   return -1
      end if

   end if

next

destroy dsDetail
return 0

end function

public function string of_ctext_short (string arg_ctext, string arg_ctext_short);string ls_ctext_short

if isnull(arg_ctext) or trim(arg_ctext)='' then
  	ls_ctext_short = arg_ctext_short
elseif isnull(arg_ctext_short) or trim(arg_ctext_short)='' then
  	ls_ctext_short = arg_ctext
elseif arg_ctext = arg_ctext_short then
  	ls_ctext_short = arg_ctext_short
else
  	ls_ctext_short = arg_ctext_short + ' ' + arg_ctext
end if; 

return ls_ctext_short   
end function

public function integer of_get_account4goodsrecipient (long arg_customer_key, string arg_we, ref string arg_caccount, ref long arg_naccount_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_pl_explosion
// Methode: of_get_account4goodsrecipient (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_customer_key
//  string arg_we
//  ref string arg_caccount
//  ref long arg_naccount_key
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
//  09.09.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string ls_account
long	ll_account_key

if len(arg_we) > 7 then
	arg_we = right(arg_we, 7)
end  if

SELECT 	cen_airline_accounts.naccount_key,   
			cen_airline_accounts.caccount  
    INTO 	:ll_account_key,   
         	:ls_account  
    FROM cen_airline_accounts  
   WHERE ( cen_airline_accounts.nairline_key 	= :arg_customer_key ) 
	  AND  ( cen_airline_accounts.csap_code 	= :arg_we ) 
	  AND  ( rownum = 1 );

if sqlca.sqlcode=0 then
	arg_caccount		= ls_account
	arg_naccount_key	= ll_account_key
else
	of_trace(2, 0, "[of_get_account4goodsrecipient] Found no ACCOUNT-Info for NAIRLINE_KEY: " + string(arg_customer_key) + " and sGoodsRecipient: " + arg_we + ": "+string(sqlca.sqlcode)  )
	arg_caccount =" "
	setnull(arg_naccount_key)
end if

return 1
end function

on uo_pl_explosion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pl_explosion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
// Tracing
//
sMatDispoTraceFile	= ProfileString("CBASE_SERVICES.INI", "CBASE_Service", "ExplosionLog", "c:\")	
sMatDispoTraceFile	+= "Explosion_log_" + string(today(),"yyyy-mm-dd") + ".txt"	

//
// Protokollierung
//
dsGenerateProtocol						= Create DataStore
dsGenerateProtocol.DataObject 		= "dw_generate_protocol"
dsGenerateProtocol.SetTransObject(SQLCA)

//
// Loadinglists in cen_out_master bekommen lokale Bereiche zugespielt
//
dsLocalWorkstations							= Create DataStore
dsLocalWorkstations.DataObject			= "dw_local_workstations_for_pl"
dsLocalWorkstations.SetTransObject(SQLCA)

//
// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge f$$HEX1$$fc00$$ENDHEX$$r einen Tag: Client, Unit, Datum
//
dsFlightsOnly									= Create DataStore
dsFlightsOnly.DataObject					= "dw_exp_flights_of_the_day"
dsFlightsOnly.SetTransObject(SQLCA)

//
// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge mit Join auf cen_out_pax
//
dsFlightsOfTheDay								= Create DataStore
dsFlightsOfTheDay.DataObject				= "dw_exp_pax_of_the_day"
dsFlightsOfTheDay.SetTransObject(SQLCA)

//
// Die zu beladenen LLs und SLLs je Flug
//
dsExplosionHandling						= Create DataStore
dsExplosionHandling.DataObject		= "dw_cen_out_all_loadinglists"
dsExplosionHandling.SetTransObject(SQLCA)

//
// Datastores f$$HEX1$$fc00$$ENDHEX$$r Matdispo Einzelst$$HEX1$$fc00$$ENDHEX$$cklisten
//

//
// Datastore zum Speichern
//
dsCenOutMasterLevel1						= Create uo_generate_datastore
dsCenOutMasterLevel1.DataObject		= "dw_cen_out_master"
dsCenOutMasterLevel1.SetTransObject(SQLCA)
//
// Datastore zum Aufl$$HEX1$$f600$$ENDHEX$$sen von Sub-Packing-Lists
//
dsCenOutMasterLevelN						= Create uo_generate_datastore
dsCenOutMasterLevelN.DataObject		= "dw_cen_out_master"

//
// Datastore zum Speichern der Artikel
//
dsCenOutDetail							= Create uo_generate_datastore
dsCenOutDetail.DataObject			= "dw_cen_out_detail"
dsCenOutDetail.SetTransObject(SQLCA)

//
// Mahlzeitenaufl$$HEX1$$f600$$ENDHEX$$sung
//
dsCenOutMeals								= Create uo_generate_datastore
dsCenOutMeals.DataObject				= "dw_cen_out_meals"
dsCenOutMeals.SetTransObject(SQLCA)

//
// SPML-Aufl$$HEX1$$f600$$ENDHEX$$sung
//
dsCenOutSMPL								= Create DataStore
dsCenOutSMPL.DataObject					= "dw_cen_out_spml_detail"
dsCenOutSMPL.SetTransObject(SQLCA)

//
// Inhalte der Einzelst$$HEX1$$fc00$$ENDHEX$$cklisten
//
dsPackingList								= Create DataStore

//
// Lesematerial Loading Lists
//
dsNewspaperLoading						= Create DataStore
dsNewspaperLoading.DataObject			= "dw_exp_news_loading"
dsNewspaperLoading.SetTransObject(SQLCA)

//
// Lesematerial Extrabeladung
//
dsNewspaperExtra							= Create DataStore
dsNewspaperExtra.DataObject			= "dw_exp_news_extra"
dsNewspaperExtra.SetTransObject(SQLCA)

//
// Inhalt Lesematerial Loading List
//
dsNewsLoadingList							= Create DataStore
dsNewsLoadingList.DataObject			= "dw_news_loadinglist_content"
dsNewsLoadingList.SetTransObject(SQLCA)

//
// NonFlightBusiness
//
dsCenOutNFB									= Create DataStore
dsCenOutNFB.DataObject					= "dw_cen_out_nfb_orders"
dsCenOutNFB.SetTransObject(SQLCA)

dsCenOutMasterNFB							= Create uo_generate_datastore
dsCenOutMasterNFB.DataObject			= "dw_cen_out_master_nfb"
dsCenOutMasterNFB.SetTransObject(SQLCA)

//
// Beladung aus einem NFB-Auftrag
//
dsLoadingNFB							= Create DataStore
dsLoadingNFB.DataObject				= "dw_content_nfb"
dsLoadingNFB.SetTransObject(SQLCA)

//
// Darstellung f$$HEX1$$fc00$$ENDHEX$$r Simulation Matdispo
//
dsSimulation							= Create DataStore
dsSimulation.DataObject				= "dw_sim_explosion"
 
//
// f$$HEX1$$fc00$$ENDHEX$$r Berechnungen in Lesematerial Loading List...
//
uo_calc = create  uo_meal_calculation


// --------------------------------------------------------------------------------------------------------------------
// 07.09.2010 HR: Datastore f$$HEX1$$fc00$$ENDHEX$$r das Forecast-Projekt
// --------------------------------------------------------------------------------------------------------------------
dsForecast							= Create DataStore
dsForecast.DataObject			= "dw_exp_forecast_values"
dsForecast.SetTransObject(SQLCA)

dsForecast_AS							= Create DataStore
dsForecast_AS.DataObject			= "dw_exp_forecast_airlinestatus"
dsForecast_AS.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 16.04.2012 mnu: kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
// --------------------------------------------------------------------------------------------------------------------
this.idsCustomerId = create datastore
this.idsCustomerId.DataObject = "dw_check_customer_id"
this.idsCustomerId.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2013 HR: Datastore mit den Produktionszeitfenstern f$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$cklisten
// --------------------------------------------------------------------------------------------------------------------
ids_prod_time_frame = create datastore
ids_prod_time_frame.DataObject = "dw_exp_prod_time_frame"
ids_prod_time_frame.SetTransObject(SQLCA)
end event

event destructor;//
// Alles wieder zerst$$HEX1$$f600$$ENDHEX$$ren
//
destroy(dsGenerateProtocol)

destroy(dsLocalWorkstations)

destroy(dsFlightsOnly)
destroy(dsFlightsOfTheDay)

destroy(dsExplosionHandling)

destroy(dsCenOutMasterLevel1)
destroy(dsCenOutMasterLevelN)
destroy(dsCenOutDetail)


destroy(dsCenOutMeals)
destroy(dsCenOutSMPL)

destroy(dsPackingList)

destroy(dsNewspaperLoading)
destroy(dsNewspaperExtra)
destroy(dsNewsLoadingList)

destroy(dsCenOutNFB)
destroy(dsCenOutMasterNFB)
destroy(dsLoadingNFB)

destroy(dsSimulation)

destroy uo_calc

destroy(dsForecast) // 07.09.2010 HR:
destroy(dsForecast_AS) // 07.09.2010 HR:


// 16.04.2012 mnu: kundenspezifische st$$HEX1$$fc00$$ENDHEX$$cklisten-ID
if isValid(this.idsCustomerId) then destroy this.idsCustomerId

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2013 HR: Datastore mit den Produktionszeitfenstern f$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$cklisten
// --------------------------------------------------------------------------------------------------------------------
destroy (ids_prod_time_frame)

end event

