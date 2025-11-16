HA$PBExportHeader$uo_label_newspaper.sru
forward
global type uo_label_newspaper from nonvisualobject
end type
end forward

global type uo_label_newspaper from nonvisualobject
end type
global uo_label_newspaper uo_label_newspaper

type variables
public:
//
// Flugdaten
//
string	sAirline
long		lFlightnumber
string	sSuffix
string	sDepartureTime
string	sOwner
string	sActype
long		lNewspaperTypeKey

//
// Vor$$HEX1$$fc00$$ENDHEX$$bergehend: Erzeugung einer Instanz von uo_loading_list
//
uo_loading_list	uoLoadingList

Datastore	dsNewspaperReport		// Referenz zu Datastore

//
// Datastores f$$HEX1$$fc00$$ENDHEX$$r den echtzeit-Labeldruck
//
Datastore		dsHandlingNewspaper
Datastore		dsHandling
Datastore		dsloadinglist

Datastore		dsFlightsOfTheDay

Datastore		dsResult	// Verweis

Datastore		dsReport // Test: Liste f$$HEX1$$fc00$$ENDHEX$$r einen Flug

long		lNewsPL-Type[] //MB 09.06.2010
long		lNewsLLIndexKey
long		lNewsPLIndexKey
long		lNewsPLDetailKey
long		lLabelTypeKey
long		lClassNumber
long		lSort
long		lAction
long		lExplosion_level, lParent_Result_Key
long		lCalc_id
long		lRatiolist_key
long		lCalc_detail_key
long		lResultKey
long		lPax
long		lQuantity
long		lStowageSort
long		lLabelQuantity

date		dGenerationdate

string	sNews_LL
string	sPackinglist
string	sNewspaper
string	sGalley
string	sStowage
string	sStowage_text	// Bemerkungsfeld zu Stauorten, wichtig f$$HEX1$$fc00$$ENDHEX$$r CA-Beladung von Lesematerial
string	sPlace
string	sUnit
string	sClass
string	sAddOnText	// nachtr$$HEX1$$e400$$ENDHEX$$glich

integer	ibelly
integer	iday

decimal	dcWeight

string	sFind
long		lFind

string	sErrorText

// ---------------------------------------
// Passagiere erstes Leg
// ---------------------------------------
integer	iBostaF
integer	iBostaC
integer	iBostaM


end variables

forward prototypes
public function integer of_insert_checksheet ()
public function integer of_start_label (s_all_flight_infos strflight)
public function integer of_get_packinglists ()
public function long of_calc_ratiolist (long arg_calc_id, long arg_pax, date arg_date)
public function long of_insert_packinglists ()
public function integer of_save_results ()
end prototypes

public function integer of_insert_checksheet ();//
// of_insert_checksheet
//
// Erstellung eines Checksheets f$$HEX1$$fc00$$ENDHEX$$r alle Label, die gedruckt werden
// Der zu f$$HEX1$$fc00$$ENDHEX$$llende Datastore befindet sich in w_flight_preview_master_client
// und wird $$HEX1$$fc00$$ENDHEX$$ber uo_loading_list.uf_generate_label() hierher transportiert
//
long lRow

if not isnull(dsNewspaperReport) then
	if lQuantity > 0 then
		lRow = dsNewspaperReport.InsertRow(0)
		dsNewspaperReport.SetItem(lRow,"cairline",sAirline)	
		dsNewspaperReport.SetItem(lRow,"nflight_number",lFlightnumber)	
		dsNewspaperReport.SetItem(lRow,"csuffix",sSuffix)	
		dsNewspaperReport.SetItem(lRow,"cdeparture_time",sDepartureTime)	
		
		dsNewspaperReport.SetItem(lRow,"cen_out_master_cpackinglist",sPackinglist)	
		dsNewspaperReport.SetItem(lRow,"cen_out_master_ctext",sNewspaper)	
		dsNewspaperReport.SetItem(lRow,"cen_out_master_nquantity",lQuantity)	
		
		dsNewspaperReport.SetItem(lRow,"cowner",sOwner)	
		dsNewspaperReport.SetItem(lRow,"cactype",sActype)	
	end if
	
end if


return 0

end function

public function integer of_start_label (s_all_flight_infos strflight);// ------------------------------------------------------------------
//
// of_start_label
//
// Einstiegsfunktion f$$HEX1$$fc00$$ENDHEX$$r den Druck von Labels aus der Flight-Preview
// 
// ...wird immer nur f$$HEX1$$fc00$$ENDHEX$$r einen Flug aufgerufen!
//
// ------------------------------------------------------------------
//
// Die ganze Zeitungsbeladung f$$HEX1$$fc00$$ENDHEX$$r einen Flug mu$$HEX2$$df002000$$ENDHEX$$dynamisch geholt
// werden.
//
// ------------------------------------------------------------------
/*
 	Vorgehensweise:
	
	* 	Retrieve dw_generate_handling_objects ($$HEX1$$e400$$ENDHEX$$hnlich uo_generate)
	
		Dieser Datastore h$$HEX1$$e400$$ENDHEX$$lt alle zugeordneten Handlings zu einem in der Beladedefinition
		angewiesenen Flug.
		Argumente: 
 		strFlight.lRoutingplan_group_key bzw. strFlight.lRoutingplan_key 
		date(strFlight.sDeparturedate)
		
		Lesematerial-Handlings :
		
		Zeitungs-Loadinglist			6
		Zeitungs-Extrabeladung		7
		Zeitungs-Umladung				8
		Zeitungs-Gatelieferung		9

		siehe uo_generate.of_generate_handling_newspaper
		
	*	Retrieve auf's Newspaper-Handling-Objekt
		
		lHandlingKey aus dw_generate_handling_objects
		lAircraftKey = strFlight.lAircraft_Key
		dw_generate_handling_newspaper(lHandling_Key,dGenerationDate,lAircraftKey,sDepartureTime)
		
		Daraus gibt's dann die Newspaper Loadinglists
		
*/
	long		i, j
	long		lHandling_id		// Art des Handlingobjekts
	long		lHandling_key		// Key des Handlingobjekts
	string	sLoadinglist
	long		lFound



	dGenerationdate	= date(strFlight.sDeparturedate)
// ----------------------------
// Verkehrstag ermitteln
// ----------------------------
	iDay = DayNumber(dgenerationdate)
	iDay --
	if iDay = 0 then iDay = 7
// ------------------------------------------------------------------
// Welche Handlingobjekte sind diesem Flug zugeordnet.
// ------------------------------------------------------------------
	dsHandling.Retrieve(strFlight.lroutingplan_key,date(strFlight.sDeparturedate))
	
// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob Handlingobjekte mit Handling_id 6 vorhanden sind.
// ------------------------------------------------------------------
	lFound = dsHandling.Find("nhandling_id = 6",1,dsHandling.Rowcount())
	
	If lFound <= 0 and strFlight.lroutingplan_key_cp <> -1 Then
		// ------------------------------------------------------------------
		// Retrieve mit City Pair  Routingplan Eintrag.
		// ------------------------------------------------------------------
		dsHandling.Retrieve(strFlight.lroutingplan_key_cp,date(strFlight.sDeparturedate))
	End if	
// ------------------------------------------------
// Passagierzahlen sind nur im Tagesflugplan
// Retrieve aber nur auf diesen Flug
// -------------------------------------------------
	dsFlightsOfTheDay.Retrieve(date(strFlight.sDeparturedate),strFlight.lairline_key,integer(strFlight.sflightnumber),strFlight.sSuffix)

// ------------------------------------------------------------------
//
// Stufe 2: Was gibt's f$$HEX1$$fc00$$ENDHEX$$r Loadinglists f$$HEX1$$fc00$$ENDHEX$$r diesen Flug
//
// ------------------------------------------------------------------
for i = 1 to dsHandling.RowCount()
	lHandling_id = dsHandling.GetItemNumber(i,"nhandling_id")
	//
	// Lesematerial Loadinglists
	//
	if lHandling_id = 6 then
		lHandling_key = dsHandling.GetItemNumber(i,"nhandling_key")

		//
		// Inhalt des Handlingobjekts
		//
		dsHandlingNewspaper.Retrieve(lHandling_key,date(strFlight.sDeparturedate),strFlight.lAircraft_key,strFlight.cdeparturetime)
		//f_print_datastore(dsHandlingNewspaper)
		
		for j = 1 to dsHandlingNewspaper.RowCount()
			sLoadinglist = dsHandlingNewspaper.GetItemString(j,"cnews_ll")
			
			//
			// Inhalt Loadinglist
			//
			dsloadinglist.Retrieve(strFlight.sclient, sLoadinglist, date(strFlight.sDeparturedate), strFlight.cdeparturetime)
			//f_print_datastore(dsloadinglist)
			
			//
			// Packinglist-Auslesen
			//
			of_get_packinglists()
			
		next

	end if
next

// ------------------------------------------------------------------
//
// Stufe 3: Alles in den Datastore von uo_loading_list
//
// ------------------------------------------------------------------

//
// Das passiert in uo_loading_list...
//

// f_print_datastore(dsResult)


return 0
end function

public function integer of_get_packinglists ();//
// of_get_packinglists
//
long 	j, i,k
long	lRow
boolean btype_ok

for j = 1 to dsloadinglist.RowCount()
	btype_ok = FALSE
	for k=Lowerbound(lNewsPL-Type) to upperbound(lNewsPL-Type)
	 	if dsloadinglist.GetItemNumber(j,"cen_news_pl_index_nnews_pl_type_key") = lNewsPL-Type[k] then
			btype_ok = TRUE
		end if
	next
	if btype_ok then
	lNewsLLIndexKey  	= dsloadinglist.GetItemNumber(j,"cen_news_ll_nnews_ll_index_key")
	lNewsPLIndexKey	= dsloadinglist.GetItemNumber(j,"cen_news_ll_nnews_pl_index_key")
	lNewsPLDetailKey	= dsloadinglist.GetItemNumber(j,"nnews_pl_detail_key")
	sPackinglist		= dsloadinglist.GetItemString(j,"cen_news_pl_index_cnews_pl")
	sNewspaper			= dsloadinglist.GetItemString(j,"cen_news_pl_index_cnewspaper")
	sNews_LL				= dsloadinglist.GetItemString(j,"cen_news_ll_index_cnews_ll")
	
	sGalley				= dsloadinglist.GetItemString(j,"cen_galley_cgalley")
	sStowage				= dsloadinglist.GetItemString(j,"cen_stowage_cstowage")
	sPlace				= dsloadinglist.GetItemString(j,"cen_stowage_cplace")
	lLabelQuantity		= dsloadinglist.GetItemNumber(j,"cen_news_ll_nlabel_quantity")
	
	//
	// Wichtig: Menge zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	//
	lQuantity = 0
	
	//
	// Dummerweise ist iBelly immer 0
	// => Ersatzprozess
	//
	if sGalley = "BE" then
		ibelly = 1
	else
		ibelly = dsloadinglist.GetItemNumber(j,"cen_stowage_nbelly")
	end if
	
	//
	// k$$HEX1$$fc00$$ENDHEX$$nftig: Belly in Stammdaten
	//
	// dsloadinglist.GetItemNumber(j,"nbelly_container")
	//
	sStowage_text		= dsloadinglist.GetItemString(j,"cen_stowage_ctext")

	lNewspaperTypeKey	= dsloadinglist.GetItemNumber(j,"cen_news_pl_index_nnews_pl_type_key")	
	lLabelTypeKey		= dsloadinglist.GetItemNumber(j,"cen_news_pl_nlabel_type_key")	
	lClassNumber		= 0
	dcWeight				= 0.0
	sUnit					= dsloadinglist.GetItemString(j,"cen_news_pl_cunit")	
	lSort					= dsloadinglist.GetItemNumber(j,"cen_news_ll_nsort")	
	sAddOnText			= dsloadinglist.GetItemString(j,"cen_news_ll_cadd_on_text")	
	
	lStowageSort		= dsloadinglist.GetItemNumber(j,"cen_stowage_nsort")	
	
	lAction				= 1			// 1 = bringst Du
	lExplosion_level	= 1			// Wir bearbeiten den obersten Level
	lParent_Result_key	= 0		// und somit gibt es keinen Parent

	lCalc_id				= 3			// Innerhalb der Loadinglist gibt es nur Ratio-Beladung
	//
	// Berechnung der Auftragsmenge (falls Berechnungsart gew$$HEX1$$e400$$ENDHEX$$hlt)
	//
	lRatiolist_key 	= dsloadinglist.GetItemNumber(j,"cen_news_ll_nratiolist_key")
	lCalc_detail_key	= lRatiolist_key

	if lRatiolist_key > 0 then
		//
		// Es wurde eine Berechnung gew$$HEX1$$e400$$ENDHEX$$hlt
		//
		sClass = dsloadinglist.GetItemString(j,"cen_news_ll_cclass")
		//
		// Passagierzahlen aus cen_out_pax holen (f$$HEX1$$fc00$$ENDHEX$$r diesen Flug und diese Klasse)
		// => Find auf dsFlightsOfTheDay
		//
		
		// sFind kennt nicht den Result-Key!
//		sFind = "cen_out_nresult_key = " + string(lresultkey) + " and cen_out_pax_cclass = '" + sClass + "'"
//		lFind = dsFlightsOfTheDay.Find(sFind,1,dsFlightsOfTheDay.RowCount())
//		lPax 	= dsFlightsOfTheDay.GetItemNumber(lFind,"cen_out_pax_npax")
		
		//
		// Achtung: Nur die Passagierzahl berechnen, wenn beim Frequenzfeld eine -1 vorgesehen ist
		//
		if dsloadinglist.GetItemNumber(j,"cen_news_ll_nquantity" + string(iDay)) = -1 then
			//
			// Auftragsmenge anhand Passagierzahl Berechnen
			//
			Choose Case sClass
				Case 'F'
					lPax = iBostaF
				Case 'C'
					lPax = iBostaC
				Case 'M'
					lPax = iBostaM
			End Choose
			
			lquantity = of_calc_ratiolist(lRatiolist_key,lPax,dgenerationdate)
			if lquantity = -1 then
				//
				// Fehler bei Berechnung
				//
			end if
		else
			//
			// 16.06.2003 neu:
			// falls "0" gesetzt, dann Menge auf null zur$$HEX1$$fc00$$ENDHEX$$cksetzen
			//
			lquantity = 0
		end if
	else
		//
		// Beladung einer festen Menge (abh. vom Verkehrstag)
		//
		sClass = ""
		lquantity = dsloadinglist.GetItemNumber(j,"cen_news_ll_nquantity" + string(iDay))
	end if
	//
	// Bei Menge 0 kein Label, bei nlabel_quantity = 0 auch kein Label
	//
	if lquantity > 0 and lLabelQuantity > 0 then
		//
		// Insert in Report (Check-Sheet)
		//
		of_insert_checksheet()
		
		//
		// Insert in ds_result (Menge = 1)
		//
		lRow = of_insert_packinglists()
		
		//
		// F$$HEX1$$fc00$$ENDHEX$$r jede Menge > 1 ein weiteres Label 
		//
		if lquantity > 1 and lLabelQuantity = 2 then
			for i = 2 to lquantity
				dsResult.RowsCopy(lRow,lRow,Primary!,dsResult,lRow + 1, Primary!)
			next
		end if
	end if
end if //Typ$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung (Nur Ausgew$$HEX1$$e400$$ENDHEX$$hlte Gruppen Drucken)
next

//f_print_datastore(dsResult)

return 0

end function

public function long of_calc_ratiolist (long arg_calc_id, long arg_pax, date arg_date);//
// of_calc_ratiolist
//
// Berechnet Auftragsmenge anhand Pax-Zahl
//
long	lresult
long 	lcalc_quantity
long	lfrom_pax, lto_pax
datetime		dtDate


dtDate = datetime(arg_date)
/* ALT
 declare cratio_curs cursor for
  select nfrom_pax, nto_pax, cen_calc_ratiolist_detail.nquantity
    from cen_calc_ratiolist, cen_calc_ratiolist_detail
   where cen_calc_ratiolist.nratiolist_key =  cen_calc_ratiolist_detail.nratiolist_key
     and cen_calc_ratiolist.nratiolist_key =  :arg_calc_id
     and cen_calc_ratiolist.dvalid_from    <= :dtDate
	  and cen_calc_ratiolist.dvalid_to      >= :dtDate
order by nfrom_pax;
*/

//NEU
//HR 19.08.2008 Fehler LSY_1161 mehrer G$$HEX1$$fc00$$ENDHEX$$ltigkeiten
 declare cratio_curs cursor for
  select nfrom_pax, nto_pax, cen_calc_ratiolist_detail.nquantity
    from cen_calc_ratiolist, cen_calc_ratiolist_detail
   where cen_calc_ratiolist.nratiolist_key =  cen_calc_ratiolist_detail.nratiolist_key
     and cen_calc_ratiolist.ctext in (  SELECT ctext 
											    FROM cen_calc_ratiolist  
											   WHERE cen_calc_ratiolist.nratiolist_key = :arg_calc_id )
     and cen_calc_ratiolist.dvalid_from    <= :dtDate
	  and cen_calc_ratiolist.dvalid_to      >= :dtDate
order by nfrom_pax;
// ENDE NEU

open cratio_curs;
if sqlca.sqlcode <> 0 then
	close cratio_curs;
	sErrortext = "error at open cratio_curs: " + sqlca.sqlerrtext
	return -1
end if


do while sqlca.sqlcode = 0
	fetch cratio_curs
	 into :lfrom_pax, :lto_pax, :lcalc_quantity;
	 
	if sqlca.sqlcode = 100 then
		lresult = arg_pax
		exit
	end if
	
	if sqlca.sqlcode <> 0 then
		sErrortext = "error at fetch cratio_curs: " + sqlca.sqlerrtext
		lresult = arg_pax
		exit
	end if
	
	//
	// Ermittlung Menge
	//
	if lfrom_pax <= arg_pax and lto_pax >= arg_pax then
		lresult = lcalc_quantity
		exit
	end if
loop

close cratio_curs;
if sqlca.sqlcode <> 0 then
	sErrortext = "error at close cratio_curs: " + sqlca.sqlerrtext
	return -1
end if


return lresult

end function

public function long of_insert_packinglists ();//
// of_insert_packinglists
//
// Der Inhalt der Newspaper-Loadinglists wird in den Datastore
// von uo_loading_list zum sp$$HEX1$$e400$$ENDHEX$$teren Labeldruck geschrieben
//
long			lRow
string		sText

lRow = dsResult.InsertRow(0)

dsResult.SetItem(lRow,"npltype",2)	// die Hauptunterscheidung: Es ist eine Lesematerial-St$$HEX1$$fc00$$ENDHEX$$ckliste

dsResult.SetItem(lRow,"cen_loadinglist_index_nloadinglist_key",1)	// Kl$$HEX1$$e400$$ENDHEX$$rung: ist das ZBL/SSL Markierung?

dsResult.SetItem(lRow,"cen_loadinglist_index_nloadinglist_index_key",lNewsLLIndexKey)	
dsResult.SetItem(lRow,"cen_loadinglists_nbelly_container",ibelly)	
dsResult.SetItem(lRow,"cen_packinglist_index_npackinglist_index_key",lNewsPLIndexKey)	
//
// lQuantity abh$$HEX1$$e400$$ENDHEX$$ngig ob die Menge aufs Label gedruckt werden soll
//
if lLabelQuantity = 1 then
	dsResult.SetItem(lRow,"cen_loadinglists_nquantity",lquantity)	
elseif lLabelQuantity = 2 then
	dsResult.SetItem(lRow,"cen_loadinglists_nquantity",1)	
end if
dsResult.SetItem(lRow,"cen_packinglists_npackinglist_detail_key",lNewsPLDetailKey)	
dsResult.SetItem(lRow,"cen_loadinglists_cactioncode","L")	
dsResult.SetItem(lRow,"compute_qaq_actioncode","L")	// Kl$$HEX1$$e400$$ENDHEX$$rung: Wird ben$$HEX1$$f600$$ENDHEX$$tigt?
dsResult.SetItem(lRow,"cen_loadinglist_index_cloadinglist",sNews_LL)
dsResult.SetItem(lRow,"cen_galley_cgalley",sGalley)	
dsResult.SetItem(lRow,"cen_stowage_cstowage",sStowage)	
dsResult.SetItem(lRow,"cen_stowage_cplace",sPlace)	
dsResult.SetItem(lRow,"cen_packinglists_cunit",sUnit)	
dsResult.SetItem(lRow,"cen_loadinglists_cadd_on_text",sAddOnText)	
dsResult.SetItem(lRow,"cen_packinglist_index_cpackinglist",sPackinglist)	

if lLabelQuantity = 1 then
	//
	// Falls Menge > 1, dann Menge mit aufs Label drucken
	//
	if lQuantity > 1 then
		sText = string(lQuantity) + " x " + sNewspaper
		if len(sText) > 40 then
			sText = mid(sText,1,40)
		end if
		dsResult.SetItem(lRow,"cen_packinglists_ctext",sText)	// Der Text der St$$HEX1$$fc00$$ENDHEX$$ckliste
	else
		dsResult.SetItem(lRow,"cen_packinglists_ctext",sNewspaper)	// Der Text der St$$HEX1$$fc00$$ENDHEX$$ckliste
	end if
else
	dsResult.SetItem(lRow,"cen_packinglists_ctext",sNewspaper)	// Der Text der St$$HEX1$$fc00$$ENDHEX$$ckliste
end if

dsResult.SetItem(lRow,"cen_loadinglists_cclass",sClass)	
dsResult.SetItem(lRow,"nprint",1)		// sonst kein Druck
dsResult.SetItem(lRow,"carea_code","")	// keine andere Info vorhanden
dsResult.SetItem(lRow,"cen_stowage_nsort",lStowageSort)	// Sortierung
//
// Kl$$HEX1$$e400$$ENDHEX$$rung
//	compute_labelprinting
// Wie mu$$HEX2$$df002000$$ENDHEX$$Labeltyp gesetzt werden
dsResult.SetItem(lRow,"nlabel_type",1)		// Kl$$HEX1$$e400$$ENDHEX$$rung: Labeltype Check: search in uo_label_other
dsResult.SetItem(lRow,"cen_packinglists_nlabel_type_key",lLabelTypeKey)		// der in der PL zugeordnete Labeltyp
	
//	sClassname			= ds_loadinglist.GetItemString(i,"compute_classname")
//	sAdd_text			= ds_loadinglist.GetItemString(i,"compute_zustautext")
//	sArea_code			= ds_loadinglist.GetItemString(i,"carea_code")						// Produktionsbereich f$$HEX1$$fc00$$ENDHEX$$r Labeldruck

// $$HEX1$$dc00$$ENDHEX$$bergeordneter Schalter: wird beladen ja/nein 
dsResult.SetItem(lRow,"stationinstruction",1)		// Check uf_retrieve

//
// noch eintragen:
// klasse
//
dsResult.SetItem(lRow,"cen_stowage_ctext",sStowage_text)


return lRow


end function

public function integer of_save_results ();/*
// uf_save_results
//
// Zum Ablesen der Feldnamen des Datastores
// Original ist in uo_loading_list
//
// Speichert den Result-Datastore ds_loadinglist in die Datenbank
// f$$HEX1$$fc00$$ENDHEX$$r die Weiterverarbeitung durch die MATDISPO
//
// Object Property lResult_key (Key f$$HEX1$$fc00$$ENDHEX$$r cen_outbound) wird von au$$HEX1$$df00$$ENDHEX$$en gesetzt
//
// Da der Datastore bereits sortiert ist, wird die Variable i als nprio gesetzt.
//
// npl_type = 1 (normale St$$HEX1$$fc00$$ENDHEX$$cklisten)
// npl_detail_key
//
// offen:
//	Haben wir einen Handling-Key?
// Class-Number ist unbekannt, "C/M"-Problem
// Gewicht unbekannt
//

datastore	dsLoadinglist

long 		i
long		lSequence

boolean	bOK = true

//
// Host Variablen
//
long		lLoading_key
long		lLoadinglist_type
long		lLoadinglist_index_key
long		lBelly
long		lPackinglist_index_key
long		lPackinglist_detail_key
long		lquantity_pl
long		lquantity_label
long		llabel_type
long		lTransaction
long		lHandling_key

decimal	dcStowage_weight

string	sActioncode
string	sActioncode_qaq
string	sFor_to
string	sFor_tcl
string	sSi_codes
string	sLoadinglist
string	sAdd_on_text
string	sMeal_control_code
string	sPackinglist
string	sPL_Unit
string	sPL_text
string	sPL_text_short
string	sClassname
string	sAdd_text
string	sArea_code

integer	iPrint_label
integer	iStationinstruction

datetime	dtTimestamp


//
// Flug aus Tagesflugplan feststellen, um nresult_key setzen zu k$$HEX1$$f600$$ENDHEX$$nnen
// (kann aber schon von au$$HEX1$$df00$$ENDHEX$$en gesetzt sein)
//
//MessageBox("uf_save_results",ds_loadinglist.RowCount())

//
// Check lresultkey
//
if lresultkey = 0 or isnull(lresultkey) then
	select nresult_key, ntransaction
	  into :lresultkey, :lTransaction
	  from cen_out
	 where nairline_key		= :lAirlineKey
	   and nflight_number	= :iFlightNo
		and csuffix				= :sSuffix
		and ddeparture			= :dtDepartureDate;
	
	if sqlca.sqlcode <> 0 then
		sErrorText = "Could not find flight in cen_out."	
		return -1
	end if
end if

//MessageBox("ds_loadinglist.RowCount()", ds_loadinglist.RowCount())

//
// Falls schon Daten mit diesem Result-Key in cen_outbound_loading,
// dann diese l$$HEX1$$f600$$ENDHEX$$schen (aber nur die St$$HEX1$$fc00$$ENDHEX$$cklisten, nicht die Zeitungen)
//
delete from cen_out_ll
 where nresult_key 	= :lresultkey
   and npl_type		= 1;

if sqlca.sqlcode <> 0 then
	sErrorText = "Could not delete old loading."	
	//MessageBox("Error delete cen_outbound_loading",sqlca.sqlerrtext)
	return -1
end if



//
// ds_loadinglist durchlaufen, Daten in DB speichern
//
for i = 1 to ds_loadinglist.RowCount()
	
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lSequence = f_Sequence("seq_cen_out_ll", sqlca)
	if lSequence = -1 Then
		// -----------------------------------------
		// Messagebox muss noch getauscht werden!!!
		// -----------------------------------------
		//beep(1)
		//uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
		//									 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
		sErrorText = "Could not assign sequence for cen_out_ll."	
		return -1
	end if

	lLoading_key				= lSequence
	lLoadinglist_type			= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_key")
	lLoadinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_index_key")
	lBelly						= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nbelly_container")
	lPackinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	lquantity_pl				= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nquantity")
	// Ist das die Anzahl zu druckender Label?
	lquantity_label			= ds_loadinglist.GetItemNumber(i,"compute_labelprinting")
	// Achtung: es gibt 2 Felder Labeltype : cen_packinglists_nlabel_type_key und nlabel_type
	// Welchen nehmen?
	llabel_type					= ds_loadinglist.GetItemNumber(i,"nlabel_type")
	lPackinglist_detail_key = ds_loadinglist.GetItemNumber(i,"cen_packinglists_npackinglist_detail_key")
	
	sActioncode			= ds_loadinglist.GetItemString(i,"cen_loadinglists_cactioncode")
	sActioncode_qaq	= ds_loadinglist.GetItemString(i,"compute_qaq_actioncode")
	sFor_to				= ds_loadinglist.GetItemString(i,"compute_6")
	sFor_tcl				= ds_loadinglist.GetItemString(i,"sys_three_letter_codes_ctlc")
	sSi_codes			= ds_loadinglist.GetItemString(i,"compute_sicodes")
	sLoadinglist		= ds_loadinglist.GetItemString(i,"cen_loadinglist_index_cloadinglist")
	sGalley				= ds_loadinglist.GetItemString(i,"cen_galley_cgalley")
	sStowage				= ds_loadinglist.GetItemString(i,"cen_stowage_cstowage")
	sPlace				= ds_loadinglist.GetItemString(i,"cen_stowage_cplace")
	sAdd_on_text		= ds_loadinglist.GetItemString(i,"cen_loadinglists_cadd_on_text")
	sMeal_control_code	= ds_loadinglist.GetItemString(i,"cen_loadinglists_cmeal_control_code")
	sPackinglist		= ds_loadinglist.GetItemString(i,"cen_packinglist_index_cpackinglist")
	sPL_Unit				= ds_loadinglist.GetItemString(i,"cen_packinglists_cunit")
	sPL_text				= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext")
	sPL_text_short		= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext_short")
	sClass				= ds_loadinglist.GetItemString(i,"cen_loadinglists_cclass")
	sClassname			= ds_loadinglist.GetItemString(i,"compute_classname")
	sAdd_text			= ds_loadinglist.GetItemString(i,"compute_zustautext")
	sArea_code			= ds_loadinglist.GetItemString(i,"carea_code")						// Produktionsbereich f$$HEX1$$fc00$$ENDHEX$$r Labeldruck
	
	iPrint_label			= ds_loadinglist.GetItemNumber(i,"nprint")
	iStationinstruction	= ds_loadinglist.GetItemNumber(i,"stationinstruction")
	
	dtTimestamp = datetime(today(), now())
	
	lHandling_key = 1
	
	//
	// insert into cen_out_ll...
	//
	insert into cen_out_ll
		(	ndetail_key,
			ntransaction,
			nresult_key,
			nhandling_id,
			nhandling_key,
			nll_index_key,
			cloadinglist,
			npl_type,
			npl_index_key,
			npl_detail_key,
			cpackinglist,
			ctext,
			cadd_on_text,
			cunit,
			nclass_number,
			cclass,
			nquantity,
			nweight,
			cactioncode,
			nlabel_type_key,
			cmeal_control_code,
			cmeal_control_code2,
			cmeal_control_code3,
			cgalley,
			cstowage,
			cplace,
			nbelly,
			ngalley_sort,
			nstowage_sort,
			npl_sort,
			nprio,
			dtimestamp,
			nstatus,
			naction,
			nexplosion_level,
			nparent_result_key
		)
		values
		(	:lSequence,
			:lTransaction,
			:lResultkey,
			2,
			:lHandling_key,
			:lLoadinglist_index_key,
			:sLoadinglist,
			1,
			:lPackinglist_index_key,
			:lPackinglist_detail_key,
			:sPackinglist,
			:sPL_text,
			:sAdd_on_text,
			:sPL_Unit,
			0,
			:sClass,
			:lquantity_pl,
			0,
			:sActioncode,
			:llabel_type,
			:sMeal_control_code,
			'', '',
			:sGalley,
			:sStowage,
			:sPlace,
			:lBelly,
			0,
			0,
			:i,
			:i,
			:dtTimestamp,
			0,
			1,1,0
		);
	
	if sqlca.sqlcode <> 0 then
		bOK = false
	end if

next

if bOK = true then
	commit;
else
	sErrorText = "Could not generate loading."
	rollback;
end if


*/
return 0

end function

event constructor;//
// Datastores f$$HEX1$$fc00$$ENDHEX$$r den ON-THE-FLY-LABELDRUCK
//
dsHandling									= Create DataStore
dsHandling.DataObject					= "dw_newspaper_get_handling_objects"
dsHandling.SetTransObject(SQLCA)

dsHandlingNewspaper						= Create DataStore
dsHandlingNewspaper.DataObject		= "dw_newspaper_get_handling_detail"
dsHandlingNewspaper.SetTransObject(SQLCA)

dsloadinglist								= Create DataStore
dsloadinglist.DataObject				= "dw_newspaper_get_loadinglist_content"
dsloadinglist.SetTransObject(SQLCA)

dsFlightsOfTheDay							= Create DataStore
dsFlightsOfTheDay.DataObject			= "dw_newspaper_get_cen_out_pax"
dsFlightsOfTheDay.SetTransObject(SQLCA)

dsResult										= Create DataStore
dsResult.DataObject						= "dw_loading_list_result"


end event

on uo_label_newspaper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_label_newspaper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;

destroy	dsHandlingNewspaper
destroy	dsHandling
destroy	dsLoadinglist
destroy	dsFlightsOfTheDay



end event

