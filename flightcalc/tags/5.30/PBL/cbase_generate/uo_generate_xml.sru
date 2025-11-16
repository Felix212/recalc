HA$PBExportHeader$uo_generate_xml.sru
$PBExportComments$Userobject f$$HEX1$$fc00$$ENDHEX$$r die Abrechnungsschnittstelle
forward
global type uo_generate_xml from nonvisualobject
end type
end forward

global type uo_generate_xml from nonvisualobject
end type
global uo_generate_xml uo_generate_xml

type variables
	Public:
	
// ---------------------------------------------------
// Wichtig: die Pr$$HEX1$$fc00$$ENDHEX$$fsummen aus of_write_xml_summary
// ---------------------------------------------------
// ---------------------------------------
// Counter f$$HEX1$$fc00$$ENDHEX$$r Summary
// ---------------------------------------	
	long 							lFlightCounter				= 0
	decimal 						lItemlistCounter			= 0
	decimal						dcItemListPerFlight		= 0
// ---------------------------------------
// Blob zum Speichern der XML-Datei
// ---------------------------------------	
	blob			bXMLFile
// ---------------------------------------
// Datastores
// ---------------------------------------
	datastore	dsCenOut
	datastore	dsCenOutHandling
	datastore	dsCenOutPax
	datastore	dsCenOutMeals
	datastore	dsCenOutExtra				
	datastore	dsCenOutSPML			
	datastore	dsCenOutSPMLDetail
	datastore	dsCenOutAddDelivery						// Nachbestellungen
	datastore	dsClassMapping								// KlassenMapping
																	// CBASE-Klasse -> Export-Klasse
	datastore	dsBillingStatus							// $$HEX1$$dc00$$ENDHEX$$bertragungsstatistik
	
	datastore	dsClientUnitMapping				// Export Mandant / Werk

	datastore	dsCostType							// Kostenarten
	datastore	dsMop								// Mopnummern und Bezeichnungen
	 														// Konzeptbausteinnummern und Bezeichnungen
	datastore	dsConcConcKit						// + Konzeptnummern und Bezeichnungen
	datastore	dsCalctype							// Berechnungsarten
	datastore	dsPriceCalcType					// Preisberechnungsarten
	datastore	dsRotations 							// Rotationsobjekt
	datastore   	dsRatiolistDetail					// RatiolistDetails (bis-Pax-Menge)
	datastore   	dsUnitSupplier						// Werk/Lieferant 
	datastore   	dsACGMaster						// Flugger$$HEX1$$e400$$ENDHEX$$tgruppen
	datastore   	dsCurrency							// W$$HEX1$$e400$$ENDHEX$$hrung
	datastore	dsMopSPML							// Mopnummern und Bezeichnungen
															// + Konzeptnummern und Bezeichnungen

	datastore	dsCenOutPeriod					// Periodenbeladung
	datastore	dsCenOutPeriodFlights			// Periodenbeladung unterschiedliche Fl$$HEX1$$fc00$$ENDHEX$$ge
	datastore	dsCenOutPeriodDetail				// Periodenbeladung Details
																		
	string		sBillingAirlineCode						//	aktueller Abrechnungs-Airlinecode
	string		sClient										// Mandant
	integer		iFlightPostingType = 1					// Belastung/Storno kompletter Flug
	
// ---------------------------------------
// Array f$$HEX1$$fc00$$ENDHEX$$r Retrieve der Fl$$HEX1$$fc00$$ENDHEX$$ge
// ---------------------------------------
	long							lQuantityFlights			= 0
// ---------------------------------------
// Name des Wurzelknotens
// ---------------------------------------	
	string						sRootNode					= "CbaseBilling"
// ---------------------------------------
// XMl-Header
// ---------------------------------------	
	string						sXMLHeader				
																	
// ---------------------------------------
// Welche Elemente sollen in die XML-Datei
// ---------------------------------------	
	boolean						bHeader						= True
	boolean						bFlight						= True
	boolean						bPassenger					= True
	boolean						bLoading						= True
	boolean						bAdditionalLoading		= True
	boolean						bMealLoading				= True
	boolean						bSpmlMealLoading			= True
	boolean						bSummary						= True
	boolean						bAdditionalDelivery		= True	// Nachfahrten
// -------------------------------------------------
	boolean						bPeriodicLoading			= True	// Periodenbeladung
	boolean						bPeriodicDetails			= True	// Periodenbeladung Details
		
// ---------------------------------------
// XML-Dateiname und Pfad
// ---------------------------------------	
	string					  	sFileName						= "CBASE"
	string					  	sPathName						= ""
// ---------------------------------------
// Abrechnung und/oder Production
// True 	= Abrechnung 
// False = Produktion
// ---------------------------------------	
	boolean 						bBillingStatus					= True
// ---------------------------------------
// Fehlerhandling
// ---------------------------------------	
	string						sErrorText
// ---------------------------------------
// XML-String
// ---------------------------------------	
	string						sXMLStartString				= ""
	string						sXMLEndString					= ""
	string						sXMLFlightString				= ""
	string						sNull
// ---------------------------------------
// Bestellung
// ---------------------------------------		
	decimal 						dQuantityItems					= 0
	decimal						dItemlistCounter				= 0
	
	string						sOrderMandant
	string						sOrderUnit
	string						sDeparture						= ""
	string						sDispoGroup						= ""
	
	
	string						sCarriageReturn				= "~r~n"
	
	
	string						sDepartureFrom						= ""
	string						sDepartureTo						= ""
	
// -------------------------------------------------
// Nur Mengen > 0 in Abrechnungsschnittstelle?
// -------------------------------------------------
	integer						iValuesLargerZero 			= 0	
	
// -------------------------------------------------
// Controlling-Informationen in die Abrechnungsschnittstelle?
// -------------------------------------------------
	boolean						bExtendedMode = false
	
	datastore					dsCenOutMealsAccumulator

// -------------------------------------------------
// verwende Preis-Feld nur f$$HEX1$$fc00$$ENDHEX$$r modifizierte Preise (True)
// sonst immer setzen (False)
// -------------------------------------------------
	boolean						bPreferredSalesPrice	= True
	
// -------------------------------------------------
// Monalisa-Daten f$$HEX1$$fc00$$ENDHEX$$r Repr$$HEX1$$fc00$$ENDHEX$$/SAP-BW in die Abrechnungsschnittstelle?
// -------------------------------------------------
	boolean						bMonalisaMode		= False
	
// -------------------------------------------------
// Generiere csv Format f$$HEX1$$fc00$$ENDHEX$$r die Repr$$HEX2$$fc002000$$ENDHEX$$DaVinci (IF130-Format)
// -------------------------------------------------
	boolean						bCreateDaVinciInterface	= False
// ---------------------------------------
// Repr$$HEX2$$fc002000$$ENDHEX$$DaVinci -Dateiname und Pfad
// ---------------------------------------	
	string					  	sDaVinciFileName				= "CBASE"
	string					  	sDaVinciPathName				= ""
// ---------------------------------------
// Blob zum Speichern der Repr$$HEX2$$fc002000$$ENDHEX$$DaVinci -Datei
// ---------------------------------------	
	blob			bDaVinciFile

	 						
					// Trennzeichen zwischen den Feldern der Davinci-Schnittstelle						 
	String							sSeparator= ";"   
					// Ersatzzeichen, falls Separator innerhalb von Feldinhalten gefunden wird
	String							sSeparator_Exchange= ","  
					// String f$$HEX1$$fc00$$ENDHEX$$r die Schnittstelle
	String							sDavinciFlightString  
					// LH-EH CostCenter
	String							sCostCenter = "094101"
			
					// DaVinci - Mandant - Airline	
	String							sDavinciClient="LH"
					// DaVinci - Mandant - Agentur	
	String							sDavinciAgency="IFMS"
					// DaVinci - Format Wert mit 3 Nachkommastellen
	String							sDavinciFormatValue3="0.000"
					// DaVinci - Format Wert mit 5 Nachkommastellen
	String							sDavinciFormatValue5="0.00000"


// -------------------------------------------------
// Merken der zuletzt gelesenen Keys je datastore
// -------------------------------------------------
	private long					lcosttype_customer
	private date					dcosttype_date
	private long					lrotations_customer
	private long					lratiolistdetail_customer
	private date					dratiolistdetail_date
	private long					lunitsupplier_customer
	private long					lacg_master_customer
	
	private date					drelease_date
	private string				sstatus_autorelease
	private string				sCurrencyContract
	private string				sCurrencyDocument
	private long					lpostingtype_flight
	private string				sCreationTimestamp
	
	private long					lcounter_type_10
	private long					lcounter_type_20
	private long					lcounter_type_30
	
	


	
end variables

forward prototypes
public function boolean of_write_xml_handling (long lkey)
public function boolean of_write_xml_spml (long lkey)
public function boolean of_write_xml_summary ()
public function boolean of_write_xml_header ()
public function boolean of_write_xml_root_node (boolean bparm)
public function boolean of_generate_end_order_xml ()
public function boolean of_write_xml_order_summary ()
public function boolean of_write_xml_passenger (long lkey)
public function boolean of_generate_start_xml (long lflights)
public function boolean of_write_xml_flight (long lkey)
public function boolean of_write_xml (string sxmlstring)
public function boolean of_generate_end_xml ()
public function boolean of_generate_start_order_xml (decimal ditems)
public function boolean of_write_xml_creator ()
public function boolean of_write_xml_order_creator ()
public function boolean of_write_xml_order (datawindow dw_items)
public function boolean of_write_xml_extra (long lkey)
public function boolean of_create_xml_string (string sstartelement, string svalue, string sendelement)
public function boolean of_write_xml_meal (long lkey)
public function string of_get_classname (string arg_cbase_class)
public function long of_retrieve_classnames ()
public function boolean of_save_xml ()
public function boolean of_write_add_delivery (long lkey)
public function integer of_retrieve_billing_status (string arg_client, string arg_unit, date arg_departure)
public function integer of_write_billing_status (string arg_client, date arg_departure, long arg_customer, string arg_unit)
public function string of_get_quantity_meals (integer arg_function, string arg_class, integer arg_version)
public function long of_retrieve_units ()
public function string of_get_price_calc_text (long arg_key)
public function string of_get_cost_type_text (long arg_key)
public function string of_get_airl_cost_type (long arg_key)
public function string of_get_calc_type_text (long arg_key)
public function string of_get_rotation_text (long arg_key)
public function long of_retrieve_calctype ()
public function long of_retrieve_pricecalctype ()
public function long of_retrieve_rotations (long al_cust_key)
public function long of_retrieve_costtype (long al_cust_key, date ad_date)
public function long of_retrieve_mop (long al_result_key)
public function long of_retrieve_conc_conckit (long al_result_key)
public function string of_get_conckit_number (long arg_key)
public function string of_get_conckit_text (long arg_key)
public function long of_retrieve_ratiolistdetail (long al_cust_key, date ad_date)
public function string of_get_ratiolist_topax (long arg_key)
public function string of_get_billing_category (long al_manual_input, integer al_sales_price_modified)
public function boolean of_create_davinci_string (string svalue, long lmaxlength, string sseparatortext)
public function string of_get_posting_type (long arg_posting_type)
public function string of_get_supplier_no (string arg_key)
public function string of_get_unit_tlc (string arg_key)
public function long of_retrieve_unitsupplier (long al_customer)
public function long of_retrieve_acg_master (long al_customer)
public function string of_get_acg_master (long arg_key)
public function boolean of_write_davinci (string sdavincistring)
public function boolean of_save_davinci ()
public function boolean of_write_davinci_end_record ()
public function boolean of_davinci_reset ()
public function string of_decimal_to_string (decimal decvalue, string sformat)
public function string of_get_mop_number (long arg_key, integer itype)
public function string of_get_mop_text (long arg_key, integer itype)
public function string of_get_concept_number (long arg_key, integer itype)
public function string of_get_concept_text (long arg_key, integer itype)
public function string of_get_service_level (long arg_key, integer itype)
public function long of_retrieve_mop_spml (long al_result_key, date ad_date)
public function boolean of_write_xml_periodic_event (long lkey)
public function long of_retrieve_currency (long al_customer, string as_unit, date ad_date)
public function boolean of_write_xml_periodic_header (long lkey, integer irow)
public function boolean of_write_xml_period_detail (long lkey, integer irow)
public function long of_ml_billing_interface (long al_cust_key)
public function string of_get_airline_group (string sairline)
public function string of_replace_string (string svalue, string ssearchstring, string sreplacestring)
end prototypes

public function boolean of_write_xml_handling (long lkey);	integer	i
	integer	iQuantity
// -----------------------------------------------------
// Schreibt die Handlinginfos in die XML-Datei
// -----------------------------------------------------
	If bLoading = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutHandling.Retrieve(lKey) 
	of_create_xml_string("<Loading>",sNull,sNull)
	For i = 1 to dsCenOutHandling.Rowcount()
		iQuantity = dsCenOutHandling.GetitemNumber(i,"nquantity")
		if isnull(iQuantity) then iQuantity = 1
		//
		// 20.01.2006: Nur Mengen > 0 schreiben
		//
		If iValuesLargerZero = 1 then
			if iQuantity = 0 then
				continue
			end if
		end if

		
		// ----------------------------------------------
		// 31.08.2006 - auskommentiert
		// Handlings mit Menge > 1 wurden f$$HEX1$$fc00$$ENDHEX$$r die
		// Kontrollsumme nicht mitgez$$HEX1$$e400$$ENDHEX$$hlt
		// 
		//		if iQuantity = 1 then
		//			dcItemListPerFlight ++
		//			lItemlistCounter ++
		//		end if
		// 
		// ----------------------------------------------
		dcItemListPerFlight 	+= iQuantity
		lItemlistCounter 		+= iQuantity
		
		of_create_xml_string("<Handling>",sNull,sNull)
		of_create_xml_string("<LoadingListNumber>",dsCenOutHandling.Getitemstring(i,"cloadinglist"),"</LoadingListNumber>")
		of_create_xml_string("<Quantity>",string(iQuantity,"0.000"),"</Quantity>")
		of_create_xml_string("<LoadingListType>",string(dsCenOutHandling.GetitemNumber(i,"nhandling_id")),"</LoadingListType>")
		of_create_xml_string("<PostingType>",string(dsCenOutHandling.Getitemnumber(i,"nposting_type")),"</PostingType>")
		of_create_xml_string("<BillingCode>",dsCenOutHandling.Getitemstring(i,"caccount"),"</BillingCode>")
		if bPreferredSalesPrice then
			if dsCenOutHandling.GetitemNumber(i,"nsales_price_modified") = 1 then
				of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutHandling.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
			else
				of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
			end if
		else
			of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutHandling.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
		end if
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
		if bMonalisaMode then
			
			of_create_xml_string("<NDetailKey>",String(dsCenOutHandling.GetitemNumber(i,"nprio")),"</NDetailKey>")
		//	of_create_xml_string("<ServiceLevel>",sNull,"</ServiceLevel>")
		//	of_create_xml_string("<ItemListUnit>",sNull,"</ItemListUnit>")
			of_create_xml_string("<AirlCostType>",of_get_airl_cost_type(dsCenOutHandling.GetitemNumber(i,"ncosttype")),"</AirlCostType>")
			of_create_xml_string("<TaxCode>",dsCenOutHandling.Getitemstring(i,"ctaxcode"),"</TaxCode>")
			of_create_xml_string("<ReleaseDate>",String(dRelease_Date,"YYYY-MM-DD"),"</ReleaseDate>")
			of_create_xml_string("<StatusAutoBilling>",sstatus_autorelease,"</StatusAutoBilling>")
			of_create_xml_string("<BillingCategory>",of_get_billing_category(dsCenOutHandling.Getitemnumber(i,"nmanual_input"),dsCenOutHandling.Getitemnumber(i,"nsales_price_modified")),"</BillingCategory>")
			of_create_xml_string("<CbaseCostType>",of_get_cost_type_text(dsCenOutHandling.GetitemNumber(i,"ncosttype")),"</CbaseCostType>")
		//	of_create_xml_string("<CalcType>",sNull,"</CalcType>")
		//	of_create_xml_string("<RatioPercentage>",sNull,"</RatioPercentage>")
		//	of_create_xml_string("<CalcValue>",sNull,"</CalcValue>")
		//	of_create_xml_string("<CalcToPax>",sNull,"</CalcToPax>")
			of_create_xml_string("<PriceCalcType>",of_get_price_calc_text(dsCenOutHandling.GetitemNumber(i,"nprice_calc_type")),"</PriceCalcType>")
	//		of_create_xml_string("<ConceptNumber>",sNull,"</ConceptNumber>")
	//		of_create_xml_string("<ConceptDescription>",sNull,"</ConceptDescription>")
	//		of_create_xml_string("<ConcKitNumber>",sNull,"</ConcKitNumber>")
	//		of_create_xml_string("<ConcKitDescription>",sNull,"</ConcKitDescription>")
	//		of_create_xml_string("<MopNumber>",sNull,"</MopNumber>")
	//		of_create_xml_string("<MopDescription>",sNull,"</MopDescription>")
	//		of_create_xml_string("<CycleObject>",sNull,"</CycleObject>")
 			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_xml_string("<ItemListType>","02","</ItemListType>")
		
		end if 
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$30$$HEX2$$1c202000$$ENDHEX$$- Abrechnungsdaten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung 
			
			//Satzart	numeric	2	30	Satzart Abrechnungsdaten
			of_create_davinci_string("30",2,sSeparator)
			//ID	Numeric	12		Datensatz ID aus CBASE MONALISA
			of_create_davinci_string(String(dsCenOutHandling.GetitemNumber(i,"nprio")),12,sSeparator)
			//Klasse 	Char	10	F	
			of_create_davinci_string(sNull,10,sSeparator)
			//Servicestufe	Char	2	5	
			of_create_davinci_string(sNull,2,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer	Char	18	5323701	
			of_create_davinci_string(dsCenOutHandling.Getitemstring(i,"cloadinglist"),18,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer-Bezeichnung	Char	40	Emmentaler K$$HEX1$$e400$$ENDHEX$$se	
			of_create_davinci_string(dsCenOutHandling.Getitemstring(i,"ctext"),40,sSeparator)
			//Soll-Haben-Kennzeichen	Char	1	S oder H	Soll (Belastung), H (Gutschrift)
			of_create_davinci_string(of_get_posting_type(dsCenOutHandling.Getitemnumber(i,"nposting_type")),1,sSeparator)
			//Menge	numeric	12,3	13	Abgerechnete Menge
			of_create_davinci_string(of_decimal_to_string(dsCenOutHandling.GetitemDecimal(i,"nquantity"),sDavinciFormatValue3),13,sSeparator)
			//Mengeneinheit	Char	5	ST	
			of_create_davinci_string(sNull,5,sSeparator)
			//Einzelpreis	  numeric	12,5		(mit Dezimalpunkt)	in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung			
			of_create_davinci_string(of_decimal_to_string(dsCenOutHandling.Getitemdecimal(i,"nbilling_price"),sDavinciFormatValue5),13,sSeparator)
			//Gesamtpreis	numeric	14,5	27.95	(mit Dezimalpunkt)  Menge*Einzelpreis in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(of_decimal_to_string(Round(dsCenOutHandling.Getitemdecimal(i,"nquantity") * dsCenOutHandling.Getitemdecimal(i,"nbilling_price"),4),sDavinciFormatValue5),15,sSeparator)
			//Vertragsw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(sCurrencyContract,3,sSeparator)
			//Belegw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Belegw$$HEX1$$e400$$ENDHEX$$hrung in der der Lieferant die Rechnung stellt
			of_create_davinci_string(sCurrencyDocument,3,sSeparator)
			//Airl-Kostenart	char	10	73001	Airline-Kostenart
			of_create_davinci_string(of_get_airl_cost_type(dsCenOutHandling.GetitemNumber(i,"ncosttype")),10,sSeparator)
			//Kostenstelle	Char	10	EH-Kostenstelle	Fixer Wert '94101'
			of_create_davinci_string(sCostCenter,10,sSeparator)
			//Steuerindikator	Char	2	V1	Indikator f$$HEX1$$fc00$$ENDHEX$$r Steuern und/oder Geb$$HEX1$$fc00$$ENDHEX$$hren 
			of_create_davinci_string(dsCenOutHandling.Getitemstring(i,"ctaxcode"),2,sSeparator)
			//Freigabedatum	Date	8	20070831	Datum der Freigabe
			of_create_davinci_string(String(dRelease_Date,"YYYYMMDD"),8,sSeparator)
			//Automatische Freigabe	Char	1	Leer/$$HEX1$$1920$$ENDHEX$$X$$HEX3$$192009001a20$$ENDHEX$$X$$HEX1$$1920$$ENDHEX$$, falls automatische Freigabe erfolgte
			of_create_davinci_string(sstatus_autorelease,1,sSeparator)
			//Kategorie	Char	1	1	1 (Menge+Preis bekannt), 2 (Preis bekannt, Menge unbekannt),3 (Menge+Preis unbekannt)
			of_create_davinci_string(of_get_billing_category(dsCenOutHandling.Getitemnumber(i,"nmanual_input"),dsCenOutHandling.Getitemnumber(i,"nsales_price_modified")),1,sSeparator)
			//Abrechnungscode 	Char	10	2610000000	Kundennummer bei LSG-D
			of_create_davinci_string(dsCenOutHandling.Getitemstring(i,"caccount"),10,sSeparator)
			//Cbase-Kostenart	char	30	Dienstleistung	Cbase-Kostenart
			of_create_davinci_string(of_get_cost_type_text(dsCenOutHandling.GetitemNumber(i,"ncosttype")),30,sSeparator)
			//Mengen-Berechnungsart	Char	40	Ratiolist I	
			of_create_davinci_string(sNull,40,sSeparator)			
			//Ratio-Prozent	Numeric	3	150	Anzahl laut Ratio beladene St$$HEX1$$fc00$$ENDHEX$$ck dieser Komponente, z.B. bei Br$$HEX1$$f600$$ENDHEX$$tchen oft 150%
			of_create_davinci_string(sNull,3,sSeparator)
			//Berechnungswert	Numeric	10,3	1	
			of_create_davinci_string(sNull,11,sSeparator)
			//Versionsstaffel Bis-Wert	Numeric	4	16	z.B. bei First Version 15-16
			of_create_davinci_string(sNull,4,sSeparator)
			//Preisberechnungsart	Char	40	SPML-Durchschnittl.Mz-Preis	
			of_create_davinci_string(of_get_price_calc_text(dsCenOutHandling.GetitemNumber(i,"nprice_calc_type")),40,sSeparator)
			//Konzept-Nr	char	30	IOFHD000700	
			of_create_davinci_string(sNull,30,sSeparator)
			//Konzeptbezeichnung	char	40	LH/LR, SS 5,  breakfast 2er Auswahl	
			of_create_davinci_string(sNull,40,sSeparator)
			//Konzeptbaustein 	Char	30	IOFMC (meat)	
			of_create_davinci_string(sNull,30,sSeparator)
			//Konzeptbausteinbezeichnung	char	40	plate large starter	
			of_create_davinci_string(sNull,40,sSeparator)
			//MOP-Nr	Char	30	C-HM1033-ORD	
			of_create_davinci_string(sNull,30,sSeparator)
			//MOP-Bezeichnung	char	40	Hot Meal Pricate Air	
			of_create_davinci_string(sNull,40,sSeparator)
			//Rotationsobjekt	Char	60	2 Monate/2 Rotationen		
			of_create_davinci_string(sNull,60,sSeparator)
 			//Rotation	Char	10	A	
			of_create_davinci_string(sNull,10,sSeparator)
			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_davinci_string("02",2,sCarriageReturn)
			
			lcounter_type_30 ++
		end if
		
		of_create_xml_string(sNull,sNull,"</Handling>")
	Next
	
	of_create_xml_string(sNull,sNull,"</Loading>")
	
	Return True

end function

public function boolean of_write_xml_spml (long lkey);	integer	i,j
	string	sSpmlType,sClass,sQuantity
	decimal	dcQuantity
	
	long		lMasterKey
// -----------------------------------------------------
// Schreibt die Mahlzeitenbeladung in die XML-Datei
// -----------------------------------------------------
	If bMealLoading = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutSPML.Retrieve(lKey) 
	
	of_create_xml_string("<SpmlMealLoading>",sNull,sNull)
	For i = 1 to dsCenOutSPML.Rowcount()
		lMasterKey 	= dsCenOutSPML.GetitemNumber(i,"nmaster_key")
		sSpmlType	= dsCenOutSPML.Getitemstring(i,"cspml")
		sClass		= of_get_classname(dsCenOutSPML.Getitemstring(i,"cclass"))
		sQuantity	= string(dsCenOutSPML.GetitemDecimal(i,"nquantity"),"0.000")
		//
		// 22.02.2005: Nur Mengen > 0 schreiben
		//
		If bBillingStatus = True and iValuesLargerZero = 1 then
			dcQuantity = dsCenOutSPML.GetitemDecimal(i,"nquantity")
			if dcQuantity = 0 then continue
		End if
		
		// -----------------------------------------------------
		// Retrieve Detail
		// -----------------------------------------------------	
		dsCenOutSPMLDetail.Retrieve(lMasterKey) 
		
		If bBillingStatus = True Then									// Abrechnung
			dsCenOutSPMLDetail.SetFilter("nbilling_status <> 1")
			dsCenOutSPMLDetail.Filter()
		Else	
			dsCenOutSPMLDetail.SetFilter("nbilling_status <> 2")
			dsCenOutSPMLDetail.Filter()
		End if	
	
		// -----------------------------------------------------
		// SPML ohne Detail, eigentlich ein Fehler
		// -----------------------------------------------------	
		If dsCenOutSPMLDetail.Rowcount() <= 0 Then
			lItemlistCounter 		+= dsCenOutSPML.GetitemDecimal(i,"nquantity")//<---hier war j gesetzt, dadurch wurde falsch abgerechnet! Feu$$HEX1$$df00$$ENDHEX$$ner 29.04.2005
			dcItemListPerFlight 	+= dsCenOutSPML.GetitemDecimal(i,"nquantity")//<---hier war j gesetzt, dadurch wurde falsch abgerechnet! Feu$$HEX1$$df00$$ENDHEX$$ner 29.04.2005
			of_create_xml_string("<Item>",sNull,sNull)
			of_create_xml_string("<SpmlType>",sSpmlType,"</SpmlType>")
			of_create_xml_string("<ItemListNumber>","XX","</ItemListNumber>")
			of_create_xml_string("<ItemListText>","XX","</ItemListText>")
			of_create_xml_string("<Quantity>",sQuantity,"</Quantity>")
			of_create_xml_string("<ClassName>",sClass,"</ClassName>")
			of_create_xml_string("<BillingCode>","XX","</BillingCode>")
			of_create_xml_string(sNull,sNull,"</Item>")
		End if	
		
		
		For j = 1 to dsCenOutSPMLDetail.Rowcount()
			lItemlistCounter 		+= dsCenOutSPMLDetail.GetitemDecimal(j,"nquantity")
			dcItemListPerFlight 	+= dsCenOutSPMLDetail.GetitemDecimal(j,"nquantity")
			of_create_xml_string("<Item>",sNull,sNull)
			of_create_xml_string("<SpmlType>",sSpmlType,"</SpmlType>")
			of_create_xml_string("<ItemListNumber>",dsCenOutSPMLDetail.Getitemstring(j,"cpackinglist"),"</ItemListNumber>")
			of_create_xml_string("<ItemListText>",dsCenOutSPMLDetail.Getitemstring(j,"cproduction_text"),"</ItemListText>")
			of_create_xml_string("<Quantity>",string(dsCenOutSPMLDetail.GetitemDecimal(j,"nquantity"),"0.000"),"</Quantity>")
			of_create_xml_string("<ClassName>",sClass,"</ClassName>")
			of_create_xml_string("<BillingCode>",dsCenOutSPMLDetail.Getitemstring(j,"caccount"),"</BillingCode>")
			of_create_xml_string("<PostingType>",string(dsCenOutSPMLDetail.Getitemnumber(j,"nposting_type")),"</PostingType>")
			of_create_xml_string("<AdditionalBillingCode>",dsCenOutSPMLDetail.Getitemstring(j,"cadditional_account"),"</AdditionalBillingCode>")					
			if bPreferredSalesPrice then
				if dsCenOutSPMLDetail.GetitemNumber(j,"nsales_price_modified") = 1 then
					of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutSPMLDetail.Getitemdecimal(j,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
				else
					of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
				end if
			else
				of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutSPMLDetail.Getitemdecimal(j,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
			end if
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//		
			if bMonalisaMode then
			
			of_create_xml_string("<NDetailKey>",String(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key")),"</NDetailKey>")
			of_create_xml_string("<ServiceLevel>",of_get_service_level(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),"</ServiceLevel>")
			of_create_xml_string("<ItemListUnit>",dsCenOutSPMLDetail.Getitemstring(j,"cunit"),"</ItemListUnit>")
			of_create_xml_string("<AirlCostType>",of_get_airl_cost_type(dsCenOutSPMLDetail.GetitemNumber(j,"ncosttype")),"</AirlCostType>")
			of_create_xml_string("<TaxCode>",dsCenOutSPMLDetail.Getitemstring(j,"ctaxcode"),"</TaxCode>")
			of_create_xml_string("<ReleaseDate>",String(dRelease_Date,"YYYY-MM-DD"),"</ReleaseDate>")
			of_create_xml_string("<StatusAutoBilling>",sstatus_autorelease,"</StatusAutoBilling>")
			of_create_xml_string("<BillingCategory>",of_get_billing_category(dsCenOutSPMLDetail.Getitemnumber(j,"nmanual_input"),dsCenOutSPMLDetail.Getitemnumber(j,"nsales_price_modified")),"</BillingCategory>")
			of_create_xml_string("<CbaseCostType>",of_get_cost_type_text(dsCenOutSPMLDetail.GetitemNumber(j,"ncosttype")),"</CbaseCostType>")
//			of_create_xml_string("<CalcType>",of_get_calc_type_text(dsCenOutSPMLDetail.GetitemNumber(j,"ncalc_id")),"</CalcType>")
//			of_create_xml_string("<RatioPercentage>",String(dsCenOutSPMLDetail.GetitemNumber(j,"npercentage")),"</RatioPercentage>")
//			of_create_xml_string("<CalcValue>",String(dsCenOutSPMLDetail.GetitemNumber(j,"nvalue")),"</CalcValue>")
//			of_create_xml_string("<CalcToPax>",of_get_ratiolist_topax(dsCenOutSPMLDetail.GetitemNumber(j,"ncalc_detail_key")),"</CalcToPax>")
			of_create_xml_string("<PriceCalcType>",of_get_price_calc_text(dsCenOutSPMLDetail.GetitemNumber(j,"nprice_calc_type")),"</PriceCalcType>")
			of_create_xml_string("<ConceptNumber>",of_get_concept_number(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),"</ConceptNumber>")
			of_create_xml_string("<ConceptDescription>",of_get_concept_text(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),"</ConceptDescription>")
			of_create_xml_string("<ConcKitNumber>",sNull,"</ConcKitNumber>")
			of_create_xml_string("<ConcKitDescription>",sNull,"</ConcKitDescription>")
			of_create_xml_string("<MopNumber>",of_get_mop_number(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),"</MopNumber>")
			of_create_xml_string("<MopDescription>",of_get_mop_text(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),"</MopDescription>")
			of_create_xml_string("<CycleObject>",of_get_rotation_text(dsCenOutSPMLDetail.GetitemNumber(j,"nrotation_key")),"</CycleObject>")
 			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_xml_string("<ItemListType>","01","</ItemListType>")
			 
			end if 
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$30$$HEX2$$1c202000$$ENDHEX$$- Abrechnungsdaten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung 
			
			//Satzart	numeric	2	30	Satzart Abrechnungsdaten
			of_create_davinci_string("30",2,sSeparator)
			//ID	Numeric	12		Datensatz ID aus CBASE MONALISA
			of_create_davinci_string(String(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key")),12,sSeparator)
			//Klasse 	Char	10	F	
			of_create_davinci_string(of_get_classname(dsCenOutSPML.Getitemstring(i,"cclass")),10,sSeparator)
			//Servicestufe	Char	2	5	
			of_create_davinci_string(of_get_service_level(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),2,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer	Char	18	5323701	
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"cpackinglist"),18,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer-Bezeichnung	Char	40	Emmentaler K$$HEX1$$e400$$ENDHEX$$se	
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"cproduction_text"),40,sSeparator)
			//Soll-Haben-Kennzeichen	Char	1	S oder H	Soll (Belastung), H (Gutschrift)
			of_create_davinci_string(of_get_posting_type(dsCenOutSPMLDetail.Getitemnumber(j,"nposting_type")),1,sSeparator)
			//Menge	numeric	12,3	13	Abgerechnete Menge
			of_create_davinci_string(of_decimal_to_string(dsCenOutSPMLDetail.GetitemDecimal(j,"nquantity"),sDavinciFormatValue3),13,sSeparator)
			//Mengeneinheit	Char	5	ST	
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"cunit"),5,sSeparator)
			//Einzelpreis	  numeric	12,5		(mit Dezimalpunkt)	in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung			
			of_create_davinci_string(of_decimal_to_string(dsCenOutSPMLDetail.Getitemdecimal(j,"nbilling_price"),sDavinciFormatValue5),13,sSeparator)
			//Gesamtpreis	numeric	14,5	27.95	(mit Dezimalpunkt)  Menge*Einzelpreis in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(of_decimal_to_string(Round(dsCenOutSPMLDetail.Getitemdecimal(j,"nquantity") * dsCenOutSPMLDetail.Getitemdecimal(j,"nbilling_price"),4),sDavinciFormatValue5),15,sSeparator)
			//Vertragsw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(sCurrencyContract,3,sSeparator)
			//Belegw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Belegw$$HEX1$$e400$$ENDHEX$$hrung in der der Lieferant die Rechnung stellt
			of_create_davinci_string(sCurrencyDocument,3,sSeparator)
			//Airl-Kostenart	char	10	73001	Airline-Kostenart
			of_create_davinci_string(of_get_airl_cost_type(dsCenOutSPMLDetail.GetitemNumber(j,"ncosttype")),10,sSeparator)
			//Kostenstelle	Char	10	EH-Kostenstelle	Fixer Wert '94101'
			of_create_davinci_string(sCostCenter,10,sSeparator)
			//Steuerindikator	Char	2	V1	Indikator f$$HEX1$$fc00$$ENDHEX$$r Steuern und/oder Geb$$HEX1$$fc00$$ENDHEX$$hren 
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"ctaxcode"),2,sSeparator)
			//Freigabedatum	Date	8	20070831	Datum der Freigabe
			of_create_davinci_string(String(dRelease_Date,"YYYYMMDD"),8,sSeparator)
			//Automatische Freigabe	Char	1	Leer/$$HEX1$$1920$$ENDHEX$$X$$HEX3$$192009001a20$$ENDHEX$$X$$HEX1$$1920$$ENDHEX$$, falls automatische Freigabe erfolgte
			of_create_davinci_string(sstatus_autorelease,1,sSeparator)
			//Kategorie	Char	1	1	1 (Menge+Preis bekannt), 2 (Preis bekannt, Menge unbekannt),3 (Menge+Preis unbekannt)
			of_create_davinci_string(of_get_billing_category(dsCenOutSPMLDetail.Getitemnumber(j,"nmanual_input"),dsCenOutSPMLDetail.Getitemnumber(j,"nsales_price_modified")),1,sSeparator)
			//Abrechnungscode 	Char	10	2610000000	Kundennummer bei LSG-D
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"caccount"),10,sSeparator)
			//Cbase-Kostenart	char	30	Dienstleistung	Cbase-Kostenart
			of_create_davinci_string(of_get_cost_type_text(dsCenOutSPMLDetail.GetitemNumber(j,"ncosttype")),30,sSeparator)
			//Mengen-Berechnungsart	Char	40	Ratiolist I	
			of_create_davinci_string(sNull,40,sSeparator)
			//Ratio-Prozent	Numeric	3	150	Anzahl laut Ratio beladene St$$HEX1$$fc00$$ENDHEX$$ck dieser Komponente, z.B. bei Br$$HEX1$$f600$$ENDHEX$$tchen oft 150%
			//of_create_davinci_string(String(dsCenOutSPMLDetail.GetitemNumber(j,"npercentage")),3,sSeparator)
			of_create_davinci_string(sNull,3,sSeparator)
			//Berechnungswert	Numeric	10,3	1	
			//of_create_davinci_string(String(dsCenOutSPMLDetail.GetitemNumber(j,"nvalue")),11,sSeparator)
			of_create_davinci_string(sNull,11,sSeparator)
			//Versionsstaffel Bis-Wert	Numeric	4	16	z.B. bei First Version 15-16
			//of_create_davinci_string(of_get_ratiolist_topax(dsCenOutSPMLDetail.GetitemNumber(j,"ncalc_detail_key")),4,sSeparator)
			of_create_davinci_string(sNull,4,sSeparator)
			//Preisberechnungsart	Char	40	SPML-Durchschnittl.Mz-Preis	
			of_create_davinci_string(of_get_price_calc_text(dsCenOutSPMLDetail.GetitemNumber(j,"nprice_calc_type")),40,sSeparator)
			//Konzept-Nr	char	30	IOFHD000700	
			of_create_davinci_string(of_get_concept_number(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),30,sSeparator)
			//Konzeptbezeichnung	char	40	LH/LR, SS 5,  breakfast 2er Auswahl	
			of_create_davinci_string(of_get_concept_text(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),40,sSeparator)
			//Konzeptbaustein 	Char	30	IOFMC (meat)	
			//of_create_davinci_string(of_get_conckit_number(dsCenOutSPMLDetail.GetitemNumber(j,"nhandling_detail_key")),30,sSeparator)
			of_create_davinci_string(sNull,30,sSeparator)
			//Konzeptbausteinbezeichnung	char	40	plate large starter	
			//of_create_davinci_string(of_get_conckit_text(dsCenOutSPMLDetail.GetitemNumber(j,"nhandling_detail_key")),40,sSeparator)
			of_create_davinci_string(sNull,40,sSeparator)
			//MOP-Nr	Char	30	C-HM1033-ORD	
			of_create_davinci_string(of_get_mop_number(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),30,sSeparator)
			//MOP-Bezeichnung	char	40	Hot Meal Pricate Air	
			of_create_davinci_string(of_get_mop_text(dsCenOutSPMLDetail.GetitemNumber(j,"ndetail_key"),2),40,sSeparator)
			//Rotationsobjekt	Char	60	2 Monate/2 Rotationen		
			of_create_davinci_string(of_get_rotation_text(dsCenOutSPMLDetail.GetitemNumber(j,"nrotation_key")),60,sSeparator)
 			//Rotation	Char	10	A	
			of_create_davinci_string(dsCenOutSPMLDetail.Getitemstring(j,"crotation"),10,sSeparator)
			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_davinci_string("01",2,sCarriageReturn)
			
			lcounter_type_30 ++
		end if
	
			of_create_xml_string(sNull,sNull,"</Item>")
		Next
	Next
	
	of_create_xml_string(sNull,sNull,"</SpmlMealLoading>")
	Return True


end function

public function boolean of_write_xml_summary ();	string	sString
	long		lRow
	
// -----------------------------------------------------
// Summary f$$HEX1$$fc00$$ENDHEX$$r die XML-Datei
// -----------------------------------------------------
	If bSummary = False Then Return True
// -----------------------------------------------------
// Summary
// -----------------------------------------------------	
	sXMLEndString += "<Summary>"  + sCarriageReturn
	sXMLEndString += "<QuantityFlightsTotal>" + string(lFlightCounter) + "</QuantityFlightsTotal>" + sCarriageReturn
	sXMLEndString += "<QuantityTotal>" + string(lItemlistCounter,"0.000") + "</QuantityTotal>" + sCarriageReturn
	sXMLEndString += "</Summary>" + sCarriageReturn
	
	Return True

end function

public function boolean of_write_xml_header ();// -----------------------------------------------------
// Header der XML-Datei
// -----------------------------------------------------
	If bHeader	= True Then
		sXmlHeader = sXMLEncoding + "~r~n"
		sXMLStartString += sXmlHeader
	End if
	

	Return True

end function

public function boolean of_write_xml_root_node (boolean bparm);// -----------------------------------------------------
// Wurzelknoten der XML-Datei
// -----------------------------------------------------
	If bParm = True Then
		sXMLStartString 	+= "<" + sRootNode + ">"  + sCarriageReturn
	Else
		sXMLEndString 		+= "</" + sRootNode + ">" + sCarriageReturn
	End if	
		
	Return True

end function

public function boolean of_generate_end_order_xml ();// -----------------------------------------
// Ok, alle Items sind geschrieben
// -----------------------------------------	
	sXMLEndString += "</Items>" + sCarriageReturn
// -----------------------------------------
// Summary der XML Datei
// -----------------------------------------
	of_write_xml_order_summary()
// -----------------------------------------
// Wurzelknoten
// -----------------------------------------	
	of_write_xml_root_node(False)
// -----------------------------------------
// EndeString in die XML Datei schreiben
// -----------------------------------------
	If of_write_xml(sXMLEndString)	= False Then
		sErrorText = "XML-Ende-Element konnte nicht geschrieben werden."
		return False
	End if
// -----------------------------------------
// XML Datei speichern
// -----------------------------------------
	If of_save_xml()	= False Then
		sErrorText = "XML-Datei konnte nicht geschrieben werden."
		return False
	End if
	return True
	
end function

public function boolean of_write_xml_order_summary ();	string	sString
	long		lRow
	
// -----------------------------------------------------
// Summary f$$HEX1$$fc00$$ENDHEX$$r die XML-Datei
// -----------------------------------------------------
	If bSummary = False Then Return True
// -----------------------------------------------------
// Summary
// -----------------------------------------------------	
	sXMLEndString += "<Summary>"  + sCarriageReturn
	sXMLEndString += "<QuantityItemsTotal>" + string(dItemlistCounter,"0.000") + "</QuantityItemsTotal>" + sCarriageReturn
	sXMLEndString += "</Summary>" + sCarriageReturn
	
	Return True

end function

public function boolean of_write_xml_passenger (long lkey);	integer	i
	long		lKeyArray[]
// -----------------------------------------------------
// Schreibt die Passagierinfos in die XML-Datei
// -----------------------------------------------------
	If bPassenger = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutPax.Retrieve(lKey)
	
	if bExtendedMode then
		lKeyArray[1] = lKey
		dsCenOutMealsAccumulator.Retrieve(lKeyArray) 
	end if

	of_create_xml_string("<Passenger>",sNull,sNull)
	For i = 1 to dsCenOutPax.Rowcount()
		of_create_xml_string("<CalculationBase>",sNull,sNull)
		of_create_xml_string("<ClassName>",dsCenOutPax.Getitemstring(i,"cclass"),"</ClassName>")
		of_create_xml_string("<SeatCapacity>",string(dsCenOutPax.GetitemNumber(i,"nversion")),"</SeatCapacity>")
		of_create_xml_string("<Quantity>",string(dsCenOutPax.GetitemNumber(i,"npax")),"</Quantity>")
		of_create_xml_string("<QuantitySpml>",string(dsCenOutPax.GetitemNumber(i,"npax_spml")),"</QuantitySpml>")
		of_create_xml_string("<QuantityAirline>",string(dsCenOutPax.GetitemNumber(i,"npax_airline")),"</QuantityAirline>")
		of_create_xml_string(sNull,sNull,"</CalculationBase>")
		//
		// 29.09.2006 Falls Controlling-Info mit muss
		//
		if bExtendedMode then
			of_create_xml_string("<Controlling>",sNull,sNull)
			of_create_xml_string("<ClassName>",dsCenOutPax.Getitemstring(i,"cclass"),"</ClassName>")

			of_create_xml_string("<QuantityMeal>",of_get_quantity_meals(0,dsCenOutPax.Getitemstring(i,"cclass"),dsCenOutPax.GetitemNumber(i,"nversion")),"</QuantityMeal>")
			of_create_xml_string("<QuantitySpml>",of_get_quantity_meals(1,dsCenOutPax.Getitemstring(i,"cclass"),dsCenOutPax.GetitemNumber(i,"nversion")),"</QuantitySpml>")
			of_create_xml_string(sNull,sNull,"</Controlling>")
		end if
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$20$$HEX4$$1c20200013202000$$ENDHEX$$Klassenbezogene Daten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung
			
			//Satzart	numeric	2	20	Satzart klassenbezogene Daten
			of_create_davinci_string("20",2,sSeparator)
			//Klasse	Char	10	C	
			of_create_davinci_string(dsCenOutPax.Getitemstring(i,"cclass"),10,sSeparator)
			//Anzahl Sitze	Numeric	4	80	
			of_create_davinci_string(string(dsCenOutPax.GetitemNumber(i,"nversion")),4,sSeparator)
			//Anzahl Mealpax	Numeric	4	67	Anzahl f$$HEX1$$fc00$$ENDHEX$$r PAX bestellte Mahlzeiten
			of_create_davinci_string(string(dsCenOutPax.GetitemNumber(i,"npax")),4,sSeparator)
			//Anzahl Pax	Numeric	4	66	
			of_create_davinci_string(string(dsCenOutPax.GetitemNumber(i,"npax_airline")),4,sCarriageReturn)
			
			lcounter_type_20 ++
		end if

	Next
	of_create_xml_string(sNull,sNull,"</Passenger>")
	
	Return True

end function

public function boolean of_generate_start_xml (long lflights);// -----------------------------------------
// erstellen einer XML Datei Start
// -----------------------------------------
	integer 		i
	sNull 				= ""
	sXMLStartString 	= ""
	sXMLEndString 		= ""
// -----------------------------------------
// Anzahl Fl$$HEX1$$fc00$$ENDHEX$$ge
// -----------------------------------------	
	lQuantityFlights = lFlights
// -----------------------------------------
// XML-Header
// -----------------------------------------
	of_write_xml_header()
// -----------------------------------------
// Wurzelknoten
// -----------------------------------------	
	of_write_xml_root_node(True)
// -----------------------------------------
// Created Informationen
// -----------------------------------------	
	of_write_xml_creator()
// -----------------------------------------
// Nun kommen alle Fl$$HEX1$$fc00$$ENDHEX$$ge
// -----------------------------------------		
	sXMLStartString += "<Flights>" // 11.01.05: +CR
// -----------------------------------------------------------------------------
// StartString in die XML-Datei schreiben
// -----------------------------------------------------------------------------	
	If of_write_xml(sXMLStartString)	= False Then
		sErrorText = "XML-Start-Element konnte nicht geschrieben werden."
		return False
	End if
	
	// -----------------------------------------
	// Davinci Verarbeitung (Z$$HEX1$$e400$$ENDHEX$$hler initialisieren)
	// -----------------------------------------
	if bCreateDaVinciInterface then
	  	of_davinci_reset()
	End if
	

	return True
	
end function

public function boolean of_write_xml_flight (long lkey);// ----------------------------------------------------------------------------
//
// of_write_xml_flight
//
// ----------------------------------------------------------------------------
//
// Schreibt XML f$$HEX1$$fc00$$ENDHEX$$r einen Flug und wird direkt aus w_settlement_master 
// aufgerufen. Dazu wird der Result-Key lKey $$HEX1$$fc00$$ENDHEX$$bergeben.
//
// ----------------------------------------------------------------------------
Date		dDepartureDate
string	sLocalClient
long		lCustomer, lfind
string	sLocalUnit, sUnit2, sClient2
string	sMappingUnit, sMappingClient
string sAirlineGroup

// ----------------------------------------------------------------------------
// Kontrollsumme je Flug zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// ----------------------------------------------------------------------------
dcItemListPerFlight = 0

// ----------------------------------------------------------------------------
// Erzeugt einen XML-String
// ----------------------------------------------------------------------------
sXMLFlightString = ""
sDavinciFlightString = ""
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
If dsCenOut.Retrieve(lKey) = 1 Then
	sBillingAirlineCode 	= dsCenOut.Getitemstring(1,"ccustomer")
	dDepartureDate			= date(dsCenOut.Getitemdatetime(1,"ddeparture"))
	sLocalClient			= dsCenOut.Getitemstring(1,"cclient")
	lCustomer				= dsCenOut.Getitemnumber(1,"ncustomer_key")
	sLocalUnit				= dsCenOut.Getitemstring(1,"cunit")

	if bMonalisaMode then
		// Monalisa datastores f$$HEX1$$fc00$$ENDHEX$$llen	
		of_retrieve_Rotations(lCustomer)
		of_retrieve_CalcType()
		of_retrieve_CostType(lCustomer, dDepartureDate)
		of_retrieve_PriceCalcType()
		of_retrieve_Mop(lkey)
		of_retrieve_Conc_ConcKit(lkey)	
		of_retrieve_RatiolistDetail(lCustomer, dDepartureDate)
		of_retrieve_unitsupplier(lCustomer)
		of_retrieve_acg_master(lCustomer)
		of_retrieve_mop_spml(lkey, dDepartureDate)
		of_retrieve_currency(lCustomer, slocalUnit, dDepartureDate)
		
		if dsCenOut.GetitemNumber(1,"nstatus_auto_release") = 1 then
			sstatus_autorelease	= "X"
		else
			sstatus_autorelease	= ""
		end if	
		drelease_date			= Date(dsCenOut.GetitemDatetime(1,"drelease_date"))
	end if
		
	sClient2=sLocalClient	
	sUnit2=sLocalUnit
	
	of_create_xml_string("<Flight>",sNull,sNull)
	if dsClientUnitMapping.RowCount() > 0 then
		lFind = dsClientUnitMapping.Find("cunit = '" + dsCenOut.Getitemstring(1,"cunit") + "' and cclient = '" + dsCenOut.Getitemstring(1,"cclient") + "'",1,dsClientUnitMapping.RowCount())
		if lFind > 0 then
			sMappingUnit = dsClientUnitMapping.GetItemString(lfind,"cexport_unit")
			sMappingClient = dsClientUnitMapping.GetItemString(lfind,"cexport_client")
			if len(trim(sMappingClient)) = 0 or  isnull(sMappingClient) then
				 of_create_xml_string("<Client>",dsCenOut.Getitemstring(1,"cclient"),"</Client>")
			else
				 of_create_xml_string("<Client>",sMappingClient,"</Client>")
				 sClient2=sMappingClient
			end if
			if len(trim(sMappingUnit)) = 0 or isnull(sMappingUnit) then
				 of_create_xml_string("<Unit>",dsCenOut.Getitemstring(1,"cunit"),"</Unit>" )
			else
				 of_create_xml_string("<Unit>",sMappingUnit,"</Unit>" )
				  sUnit2=sMappingUnit
			end if
			
		else
			of_create_xml_string("<Client>",dsCenOut.Getitemstring(1,"cclient"),"</Client>")
			of_create_xml_string("<Unit>",dsCenOut.Getitemstring(1,"cunit"),"</Unit>" )
		end if
	else
		of_create_xml_string("<Client>",dsCenOut.Getitemstring(1,"cclient"),"</Client>")
		of_create_xml_string("<Unit>",dsCenOut.Getitemstring(1,"cunit"),"</Unit>" )
	end if		
	
	sAirlineGroup=of_get_airline_group(dsCenOut.Getitemstring(1,"cairline"))
	
	of_create_xml_string("<AirlineCode>",dsCenOut.Getitemstring(1,"cairline"),"</AirlineCode>")
	of_create_xml_string("<AirlineType>",string(dsCenOut.Getitemnumber(1,"nairline_type")),"</AirlineType>")
	of_create_xml_string("<BillingAirlineCode>",sBillingAirlineCode,"</BillingAirlineCode>")
	of_create_xml_string("<FlightPostingType>",string(iFlightPostingType),"</FlightPostingType>")
	of_create_xml_string("<BillingCode>",dsCenOut.Getitemstring(1,"caccount"),"</BillingCode>")
	of_create_xml_string("<FlightNumber>",string(dsCenOut.Getitemnumber(1,"nflight_number")),"</FlightNumber>")
	of_create_xml_string("<Suffix>",dsCenOut.Getitemstring(1,"csuffix"),"</Suffix>")
	of_create_xml_string("<Leg>",string(dsCenOut.Getitemnumber(1,"nleg_number")),"</Leg>")
	of_create_xml_string("<Handling>",dsCenOut.Getitemstring(1,"chandling_type_text"),"</Handling>")
	of_create_xml_string("<DepartureDate>",string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYY-MM-DD"),"</DepartureDate>")
	of_create_xml_string("<DepartureTime>",dsCenOut.Getitemstring(1,"cdeparture_time"),"</DepartureTime>")
	of_create_xml_string("<DepartureStation>",dsCenOut.Getitemstring(1,"ctlc_from"),"</DepartureStation>")
	of_create_xml_string("<ArrivalStation>",dsCenOut.Getitemstring(1,"ctlc_to"),"</ArrivalStation>")
	of_create_xml_string("<TailNumber>",dsCenOut.Getitemstring(1,"cregistration"),"</TailNumber>")
	of_create_xml_string("<AircraftOwner>",dsCenOut.Getitemstring(1,"cairline_owner"),"</AircraftOwner>")
	of_create_xml_string("<AircraftType>",dsCenOut.Getitemstring(1,"cactype"),"</AircraftType>")
	of_create_xml_string("<SeatConfiguration>",dsCenOut.Getitemstring(1,"cconfiguration"),"</SeatConfiguration>")
	of_create_xml_string("<GalleyVersion>",dsCenOut.Getitemstring(1,"cgalleyversion"),"</GalleyVersion>")
	of_create_xml_string("<FlightStatus>",string(dsCenOut.GetitemNumber(1,"nflight_status")),"</FlightStatus>")		
	of_create_xml_string("<Refund>",string(dsCenOut.Getitemnumber(1,"nrefund")),"</Refund>")
	of_create_xml_string("<TrafficArea>",dsCenOut.GetitemString(1,"ctraffic_area"),"</TrafficArea>")
	of_create_xml_string("<DocumentNumber>",string(dsCenOut.Getitemnumber(1,"nbilling_key"),"000000"),"</DocumentNumber>")
	of_create_xml_string("<BoxFrom>",dsCenOut.GetitemString(1,"cbox_from"),"</BoxFrom>")
	of_create_xml_string("<BoxTo>",dsCenOut.GetitemString(1,"cbox_to"),"</BoxTo>")
	of_create_xml_string("<InternalNumber>",string(lFlightCounter),"</InternalNumber>")
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
	if bMonalisaMode then 
			
	 	of_create_xml_string("<AircraftGroup>",sAirlineGroup,"</AircraftGroup>")
		of_create_xml_string("<DepartureCountry>",dsCenOut.GetitemString(1,"ccountry_from"),"</DepartureCountry>")
		of_create_xml_string("<ArrivalCountry>",dsCenOut.GetitemString(1,"ccountry_to"),"</ArrivalCountry>")
		of_create_xml_string("<ArrivalTime>",dsCenOut.GetitemString(1,"carrival_time"),"</ArrivalTime>")
		of_create_xml_string("<ArrivalDate>",string(dsCenOut.Getitemdatetime(1,"darrival_time_loc"),"YYYY-MM-DD"),"</ArrivalDate>")
		of_create_xml_string("<DepartureDateUTC>",string(dsCenOut.Getitemdatetime(1,"ddeparture_time_UTC"),"YYYY-MM-DD"),"</DepartureDateUTC>")
		of_create_xml_string("<ArrivalDateUTC>",string(dsCenOut.Getitemdatetime(1,"darrival_time_UTC"),"YYYY-MM-DD"),"</ArrivalDateUTC>")
		of_create_xml_string("<CateringStation>",of_get_unit_tlc(dsCenOut.Getitemstring(1,"cunit")),"</CateringStation>")
		of_create_xml_string("<AirlSupplierNr>",of_get_supplier_no(dsCenOut.Getitemstring(1,"cunit")),"</AirlSupplierNr>")
		of_create_xml_string("<TitlePeriodicEvent>",sNull,"</TitlePeriodicEvent>")
		of_create_xml_string("<BillingPeriodFrom>",string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYY-MM-DD"),"</BillingPeriodFrom>")
		of_create_xml_string("<BillingPeriodTo>",string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYY-MM-DD"),"</BillingPeriodTo>")
		of_create_xml_string("<NResultKey>",String(lkey),"</NResultKey>")

	end if
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
	if bCreateDaVinciInterface then
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$10$$HEX2$$1c202000$$ENDHEX$$- Flugdaten		
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung

			//Satzart	numeric	2	10	Satzart Flugdaten
			of_create_davinci_string("10",2,sSeparator)
			
			//Mandant - Airline	Char	4	LH	
			of_create_davinci_string(sDavinciClient,4,sSeparator)
			
			//Mandant - Agentur	Char	4	IFMS	
			of_create_davinci_string(sDavinciAgency,4,sSeparator)
			
			//Abflugdatum Lokal	Date	8	20070831	Leistungserbringungsdatum:
			//			Flugdatum bei Flugereignissen, Belegdatum bei Periodenereignissen
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYYMMDD"),8,sSeparator)
			//Flugger$$HEX1$$e400$$ENDHEX$$t-Gruppe	Char	2	LC/LR	
	 		of_create_davinci_string(sAirlineGroup,2,sSeparator)
			 
			//Operierende Airline	Char	3	LH	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"cairline"),3,sSeparator)
			//of_create_xml_string("<BillingAirlineCode>",sBillingAirlineCode,"</BillingAirlineCode>")
			
			//Flugnummer	Numeric	4	4519	
			of_create_davinci_string(string(dsCenOut.Getitemnumber(1,"nflight_number"),"0000"),4,sSeparator)
			
			//Flugnummer Suffix	Char	1	A	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"csuffix"),1,sSeparator)
			
			//Legnummer	Numeric	1	1	
			of_create_davinci_string(string(dsCenOut.Getitemnumber(1,"nleg_number")),1,sSeparator)
			
			//AbflugLand	char	2	ES	
			of_create_davinci_string(dsCenOut.GetitemString(1,"ccountry_from"),2,sSeparator)
			
			//AbflugStation	char	3	AGP	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"ctlc_from"),3,sSeparator)
			
			//AbflugUhrzeit (Lokal)	time	4	1630	F$$HEX1$$fc00$$ENDHEX$$r 16:30
			of_create_davinci_string(mid(dsCenOut.Getitemstring(1,"cdeparture_time"),1,2)+mid(dsCenOut.Getitemstring(1,"cdeparture_time"),4,2),4,sSeparator)
			
			//AnkunftLand	char	2	DE	
			of_create_davinci_string(dsCenOut.GetitemString(1,"ccountry_to"),2,sSeparator)
			
			//AnkunftStation	char	3	FRA	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"ctlc_to"),3,sSeparator)
			
			//AnkunftUhrzeit (Lokal)	time	4	1935	F$$HEX1$$fc00$$ENDHEX$$r 19:35
			of_create_davinci_string(mid(dsCenOut.Getitemstring(1,"carrival_time"),1,2)+mid(dsCenOut.Getitemstring(1,"carrival_time"),4,2),4,sSeparator)
			
			//Ankunftdatum(Lokal)	date	8	20070831	
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"darrival_time_loc"),"YYYYMMDD"),8,sSeparator)
			
			//Abflugdatum (UTC)	date	8	20070831	
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"ddeparture_Time_UTC"),"YYYYMMDD"),8,sSeparator)
			
			//Ankunftdatum(UTC)	date	8	20070831	
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"darrival_Time_UTC"),"YYYYMMDD"),8,sSeparator)
			
			//Eigner	char	3	LH	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"cairline_owner"),3,sSeparator)
			
			//Aircrafttyp	Char	3	32Y	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"cactype"),3,sSeparator)
			
			//Galley-version	Char	2	1	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"cgalleyversion"),2,sSeparator)
			
			//Sitzplatzversion	Char	20	80-122	
			of_create_davinci_string(dsCenOut.Getitemstring(1,"cconfiguration"),20,sSeparator)
	
			//Beladeort	Char	3	AGP	
			of_create_davinci_string(of_get_unit_tlc(dsCenOut.Getitemstring(1,"cunit")),3,sSeparator)
			
			//WerkNr	Numeric	4	5115	Werksnummer aus Cbase
			of_create_davinci_string(sUnit2,4,sSeparator)

			//LieferantenNr	Char	10	VERB0200	Kreditorennummer aus SAP
			of_create_davinci_string(of_get_supplier_no(dsCenOut.Getitemstring(1,"cunit")),10,sSeparator)
			
			//Belegnummer	Char	12	1234567	
			of_create_davinci_string(string(dsCenOut.Getitemnumber(1,"nbilling_key")),12,sSeparator)
			
			//Titel periodisches Ereignis	Char	40	Monthly cost report standard load	
			of_create_davinci_string(sNull,40,sSeparator)
			
			//Abrechnungzeitraum-Von	Date	8	20070801	Bei periodischen Ereignissen der Zeitraum auf den sich die abgerechneten Daten beziehen
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYYMMDD"),8,sSeparator)
			
			//Abrechnungzeitraum-Bis	Date	8	20070831	
			of_create_davinci_string(string(dsCenOut.Getitemdatetime(1,"ddeparture"),"YYYYMMDD"),8,sSeparator)
			
			//Cbase-ID	Numeric	12		Cbase-interne ID des Flugereignisses bzw. des Periodenereignisses
			of_create_davinci_string(String(lkey),12,sSeparator)
	
			//Erstellungszeitpunkt	Timestamp	18	20070831-19010105	Zeitpunkt der Schnittstellenerstellung
			of_create_davinci_string(sCreationTimestamp,18,sCarriageReturn)
			
			lcounter_type_10 ++
	end if
Else
	sErrorText = "XMl-Retrieve erzielte kein Ergebnis"
	Return False
End if
// -----------------------------------------------------
// Passagierinfos f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------
of_write_xml_passenger(lKey)
// -----------------------------------------------------
// Handlinginfos f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------	
of_write_xml_handling(lKey)
// -----------------------------------------------------
// Extrabeladung f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------	
of_write_xml_extra(lKey)
// -----------------------------------------------------
// Nachlieferungen
// -----------------------------------------------------	
of_write_add_delivery(lKey)
// -----------------------------------------------------
// Mahlzeitenbeladung f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------	
of_write_xml_meal(lKey)
// -----------------------------------------------------
// SPML-Beladung f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------	
of_write_xml_spml(lKey)
// -----------------------------------------------------
// Flug Ende Element
// -----------------------------------------------------		
of_create_xml_string(sNull,sNull,"</Flight>" ) // 11.01.05: +CR
// -----------------------------------------------------
// Schreibt den kompletten Flug in die XML Datei
// -----------------------------------------------------	
If of_write_xml(sXMLFlightString)	= False Then
	return False
End if
	
if bCreateDaVinciInterface then
	If of_write_davinci(sDaVinciFlightString)	= False Then
		return False
	End if
End if
// -----------------------------------------------------
// Schreiben BillingStatus (nur bei Abrechnung)
// Flug f$$HEX1$$fc00$$ENDHEX$$r Flug
// -----------------------------------------------------	
If bBillingStatus = True Then									// Abrechnung
	of_write_billing_status(sLocalClient,dDepartureDate,lCustomer,sLocalUnit)
End if

Return True

end function

public function boolean of_write_xml (string sxmlstring);// -------------------------------------------------------
// eEncoding ist im open Event der App definiert
// -------------------------------------------------------
bXMLFile += blob(sXMLString + sCarriageReturn,EncodingANSI!)

return True

end function

public function boolean of_generate_end_xml ();// -----------------------------------------
// Ok, alle Fl$$HEX1$$fc00$$ENDHEX$$ge sind geschrieben
// -----------------------------------------	
	sXMLEndString += "</Flights>" + sCarriageReturn
// -----------------------------------------
// Summary der XML Datei
// -----------------------------------------
	of_write_xml_summary()
// -----------------------------------------
// Wurzelknoten
// -----------------------------------------	
	of_write_xml_root_node(False)
// -----------------------------------------
// EndeString in die XML Datei schreiben
// -----------------------------------------
	If of_write_xml(sXMLEndString)	= False Then
		sErrorText = "XML-Ende-Element konnte nicht geschrieben werden."
		return False
	End if

// -----------------------------------------
// XML Datei speichern
// -----------------------------------------
	If of_save_xml()	= False Then
		sErrorText = "XML-Datei konnte nicht geschrieben werden."
		return False
	End if
// -----------------------------------------
// Davinci Verarbeitung
// -----------------------------------------
	if bCreateDaVinciInterface then
	// -----------------------------------------
	// Davinci Ende-Satz erstellen
	// -----------------------------------------
		sDavinciFlightString  =""
		of_write_davinci_end_record()
	// -----------------------------------------
	// EndeString in die Davinci Datei schreiben
	// -----------------------------------------
		If of_write_davinci(sDavinciFlightString )	= False Then
			sErrorText = "Davinci-Ende-Element konnte nicht geschrieben werden."
			return False
		End if
	// -----------------------------------------
	// Davinci Datei speichern
	// -----------------------------------------
		If of_save_Davinci()	= False Then
			sErrorText = "Davinci-Datei konnte nicht geschrieben werden."
			return False
		End if



	End if
	
	return True
	
end function

public function boolean of_generate_start_order_xml (decimal ditems);// -----------------------------------------
// erstellen einer XML Datei Start
// -----------------------------------------
	integer 		i
	sNull 				= ""
	sXMLStartString 	= ""
	sXMLEndString 		= ""
// -----------------------------------------
// Anzahl Artikel
// -----------------------------------------	
	dQuantityItems = dItems
// -----------------------------------------
// XML-Header
// -----------------------------------------
	of_write_xml_header()
// -----------------------------------------
// Wurzelknoten
// -----------------------------------------	
	of_write_xml_root_node(True)
// -----------------------------------------
// Created Informationen
// -----------------------------------------	
	of_write_xml_order_creator()
// -----------------------------------------
// Nun kommen alle Fl$$HEX1$$fc00$$ENDHEX$$ge
// -----------------------------------------		
	sXMLStartString += "<Items>" //+ sCarriageReturn
// -----------------------------------------------------------------------------
// StartString in die XML-Datei schreiben
// -----------------------------------------------------------------------------	
	If of_write_xml(sXMLStartString)	= False Then
		sErrorText = "XML-Start-Element konnte nicht geschrieben werden."
		return False
	End if
	
	return True
	
end function

public function boolean of_write_xml_creator ();// -----------------------------------------------------
// Erstellerinfos f$$HEX1$$fc00$$ENDHEX$$r die XML-Datei
// -----------------------------------------------------
	sXMLStartString += "<Creator>"  + sCarriageReturn
	sXMLStartString += "<HostName>" + s_app.sHost + "</HostName>" + sCarriageReturn
	sXMLStartString += "<User>" + s_app.sUser + "</User>" + sCarriageReturn
	sXMLStartString += "<Date>" + string(Today(),"YYYY-MM-DD") + "</Date>" + sCarriageReturn
	sXMLStartString += "<Time>" + string(Now(),"HH:MM:SS") + "</Time>" + sCarriageReturn
	sXMLStartString += "<QuantityFlights>" + string(lQuantityFlights) + "</QuantityFlights>" + sCarriageReturn
	If bBillingStatus = True Then
		sXMLStartString += "<Content>" + "Billing" + "</Content>" + sCarriageReturn
	Else	
		sXMLStartString += "<Content>" + "Production" + "</Content>" + sCarriageReturn
	End if	
	sXMLStartString += "</Creator>" + sCarriageReturn
	
	if bCreateDaVinciInterface then
		sCreationTimestamp = string(Today(),"YYYYMMDD") + "-"+string(Now(),"HHMMSSFF")
	end if

	Return True
end function

public function boolean of_write_xml_order_creator ();// -----------------------------------------------------
// Erstellerinfos f$$HEX1$$fc00$$ENDHEX$$r die XML-Datei
// -----------------------------------------------------
	sXMLStartString += "<Creator>"  + sCarriageReturn
	sXMLStartString += "<HostName>" + s_app.sHost + "</HostName>"  + sCarriageReturn
	sXMLStartString += "<User>" + s_app.sUser + "</User>" + sCarriageReturn
	sXMLStartString += "<Client>" + sOrderMandant + "</Client>" + sCarriageReturn
	sXMLStartString += "<Unit>" + sOrderUnit + "</Unit>" + sCarriageReturn
	sXMLStartString += "<Date>" + string(Today(),"YYYY-MM-DD") + "</Date>" + sCarriageReturn
	sXMLStartString += "<Time>" + string(Now(),"HH:MM:SS") + "</Time>" + sCarriageReturn
	sXMLStartString += "<QuantityItems>" + string(dQuantityItems,"0.000") + "</QuantityItems>" + sCarriageReturn
	sXMLStartString += "<DepartureDateFrom>" + sDepartureFrom + "</DepartureDateFrom>" + sCarriageReturn
	sXMLStartString += "<DepartureDateTo>" + sDepartureTo + "</DepartureDateTo>" + sCarriageReturn	
	sXMLStartString += "<QuantityFlights>" + string(lQuantityFlights) + "</QuantityFlights>" + sCarriageReturn
	sXMLStartString += "<DispoGroup>" + sDispoGroup + "</DispoGroup>" + sCarriageReturn
	sXMLStartString += "<Content>" + "Order" + "</Content>" + sCarriageReturn
	
	sXMLStartString += "</Creator>"  + sCarriageReturn
	
	Return True
end function

public function boolean of_write_xml_order (datawindow dw_items);long					i
decimal				dQuantity, dReserve
string				sArtikel,sVon
sXMLFlightString 	= ""
sVon 				= lower(uf.translate("von"))
sArtikel			= uf.translate("Artikel")
// -----------------------------------------------------
// Schreibt die Artikel in die XML-Datei
// -----------------------------------------------------
For i = 1 to dw_items.Rowcount()
	w_progress.wf_setposition(i)
	w_progress.wf_setmessage(sArtikel + " " + string(i) + " " + sVon + " " + string(dw_items.Rowcount()))
	dReserve				= dw_items.GetitemDecimal(i,"compute_reserve")
	if isnull(dReserve) then dReserve = 0
	dQuantity 			= dw_items.GetitemDecimal(i,"compute_quantity") 
	dQuantity += dReserve
	dItemlistCounter += dQuantity
	of_create_xml_string("<Item>",sNull,sNull)
	of_create_xml_string("<ItemNumber>",dw_items.Getitemstring(i,"cen_out_detail_citem_pl"),"</ItemNumber>")
	of_create_xml_string("<ItemText>",dw_items.Getitemstring(i,"cen_out_detail_citem_text"),"</ItemText>")
	of_create_xml_string("<ItemUnit>",dw_items.Getitemstring(i,"cunit"),"</ItemUnit>")
	of_create_xml_string("<Quantity>",string(dQuantity,"0.000"),"</Quantity>")
	of_create_xml_string(sNull,sNull,"</Item>")
	If of_write_xml(sXMLFlightString)	= False Then
		sErrorText = "Artikel konnte nicht geschrieben werden."
		return False
	End if	
	sXMLFlightString = ""
Next

Return True




end function

public function boolean of_write_xml_extra (long lkey);	integer	i
	decimal	dcQuantity
// -----------------------------------------------------
// Extrabeladung f$$HEX1$$fc00$$ENDHEX$$r XML
// -----------------------------------------------------
	If bAdditionalLoading = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutExtra.Retrieve(lKey,1) 
	
	If bBillingStatus = True Then									// Abrechnung
		dsCenOutExtra.SetFilter("nbilling_status <> 1")
		dsCenOutExtra.Filter()
	Else	
		dsCenOutExtra.SetFilter("nbilling_status <> 2")
		dsCenOutExtra.Filter()
	End if	
	
	of_create_xml_string("<AdditionalLoading>",sNull,sNull)
	For i = 1 to dsCenOutExtra.Rowcount()
		lItemlistCounter 		+= dsCenOutExtra.GetitemDecimal(i,"nquantity")
		dcItemListPerFlight 	+= dsCenOutExtra.GetitemDecimal(i,"nquantity")
		//
		// 22.02.2005: Nur Mengen > 0 schreiben
		//
		If bBillingStatus = True and iValuesLargerZero = 1 then
			dcQuantity = dsCenOutExtra.GetitemDecimal(i,"nquantity")
			if dcQuantity = 0 then continue
		End if
		of_create_xml_string("<Item>",sNull,sNull)
		of_create_xml_string("<ItemListNumber>",dsCenOutExtra.Getitemstring(i,"cpackinglist"),"</ItemListNumber>")
		of_create_xml_string("<ItemListText>",dsCenOutExtra.Getitemstring(i,"cproduction_text"),"</ItemListText>")
		of_create_xml_string("<Quantity>",string(dsCenOutExtra.GetitemDecimal(i,"nquantity"),"0.000"),"</Quantity>")
		of_create_xml_string("<ClassName>",of_get_classname(dsCenOutExtra.Getitemstring(i,"cclass")),"</ClassName>")
		of_create_xml_string("<BillingCode>",dsCenOutExtra.Getitemstring(i,"caccount"),"</BillingCode>")	// 1
		of_create_xml_string("<PostingType>",string(dsCenOutExtra.Getitemnumber(i,"nposting_type")),"</PostingType>")
		of_create_xml_string("<AdditionalBillingCode>",dsCenOutExtra.Getitemstring(i,"cadditional_account"),"</AdditionalBillingCode>")		// 1
		if bPreferredSalesPrice then
			if dsCenOutExtra.GetitemNumber(i,"nsales_price_modified") = 1 then
				of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutExtra.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
			else
				of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
			end if
		else
			of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutExtra.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
		end if
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
		if bMonalisaMode then
			
			of_create_xml_string("<NDetailKey>",String(dsCenOutExtra.GetitemNumber(i,"ndetail_key")),"</NDetailKey>")
			of_create_xml_string("<ServiceLevel>",of_get_service_level(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),"</ServiceLevel>")
			of_create_xml_string("<ItemListUnit>",dsCenOutExtra.Getitemstring(i,"cunit"),"</ItemListUnit>")
			of_create_xml_string("<AirlCostType>",of_get_airl_cost_type(dsCenOutExtra.GetitemNumber(i,"ncosttype")),"</AirlCostType>")
			of_create_xml_string("<TaxCode>",dsCenOutExtra.Getitemstring(i,"ctaxcode"),"</TaxCode>")
			of_create_xml_string("<ReleaseDate>",String(dRelease_Date,"YYYY-MM-DD"),"</ReleaseDate>")
			of_create_xml_string("<StatusAutoBilling>",sstatus_autorelease,"</StatusAutoBilling>")
			of_create_xml_string("<BillingCategory>",of_get_billing_category(dsCenOutExtra.Getitemnumber(i,"nmanual_input"),dsCenOutExtra.Getitemnumber(i,"nsales_price_modified")),"</BillingCategory>")
			of_create_xml_string("<CbaseCostType>",of_get_cost_type_text(dsCenOutExtra.GetitemNumber(i,"ncosttype")),"</CbaseCostType>")
			of_create_xml_string("<CalcType>",of_get_calc_type_text(dsCenOutExtra.GetitemNumber(i,"ncalc_id")),"</CalcType>")
			of_create_xml_string("<RatioPercentage>",String(dsCenOutExtra.GetitemNumber(i,"npercentage")),"</RatioPercentage>")
			of_create_xml_string("<CalcValue>",String(dsCenOutExtra.GetitemNumber(i,"nvalue")),"</CalcValue>")
			of_create_xml_string("<CalcToPax>",of_get_ratiolist_topax(dsCenOutExtra.GetitemNumber(i,"ncalc_detail_key")),"</CalcToPax>")
			of_create_xml_string("<PriceCalcType>",of_get_price_calc_text(dsCenOutExtra.GetitemNumber(i,"nprice_calc_type")),"</PriceCalcType>")
			of_create_xml_string("<ConceptNumber>",of_get_concept_number(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),"</ConceptNumber>")
			of_create_xml_string("<ConceptDescription>",of_get_concept_text(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),"</ConceptDescription>")
			of_create_xml_string("<ConcKitNumber>",of_get_conckit_number(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key")),"</ConcKitNumber>")
			of_create_xml_string("<ConcKitDescription>",of_get_conckit_text(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key")),"</ConcKitDescription>")
			of_create_xml_string("<MopNumber>",of_get_mop_number(dsCenOutExtra.GetitemNumber(i,"nhandling_meal_key"),1),"</MopNumber>")
			of_create_xml_string("<MopDescription>",of_get_mop_text(dsCenOutExtra.GetitemNumber(i,"nhandling_meal_key"),1),"</MopDescription>")
			of_create_xml_string("<CycleObject>",of_get_rotation_text(dsCenOutExtra.GetitemNumber(i,"nrotation_key")),"</CycleObject>")
 			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_xml_string("<ItemListType>","03","</ItemListType>")
		
		end if 
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$30$$HEX2$$1c202000$$ENDHEX$$- Abrechnungsdaten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung 
			
			//Satzart	numeric	2	30	Satzart Abrechnungsdaten
			of_create_davinci_string("30",2,sSeparator)
			//ID	Numeric	12		Datensatz ID aus CBASE MONALISA
			of_create_davinci_string(String(dsCenOutExtra.GetitemNumber(i,"ndetail_key")),12,sSeparator)
			//Klasse 	Char	10	F	
			of_create_davinci_string(of_get_classname(dsCenOutExtra.Getitemstring(i,"cclass")),10,sSeparator)
			//Servicestufe	Char	2	5	
			of_create_davinci_string(of_get_service_level(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),2,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer	Char	18	5323701	
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"cpackinglist"),18,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer-Bezeichnung	Char	40	Emmentaler K$$HEX1$$e400$$ENDHEX$$se	
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"cproduction_text"),40,sSeparator)
			//Soll-Haben-Kennzeichen	Char	1	S oder H	Soll (Belastung), H (Gutschrift)
			of_create_davinci_string(of_get_posting_type(dsCenOutExtra.Getitemnumber(i,"nposting_type")),1,sSeparator)
			//Menge	numeric	12,3	13	Abgerechnete Menge
			of_create_davinci_string(of_decimal_to_string(dsCenOutExtra.GetitemDecimal(i,"nquantity"),sDavinciFormatValue3),13,sSeparator)
			//Mengeneinheit	Char	5	ST	
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"cunit"),5,sSeparator)
			//Einzelpreis	  numeric	12,5		(mit Dezimalpunkt)	in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung			
			of_create_davinci_string(of_decimal_to_string(dsCenOutExtra.Getitemdecimal(i,"nbilling_price"),sDavinciFormatValue5),13,sSeparator)
			//Gesamtpreis	numeric	14,5	27.95	(mit Dezimalpunkt)  Menge*Einzelpreis in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(of_decimal_to_string(Round(dsCenOutExtra.Getitemdecimal(i,"nquantity") * dsCenOutExtra.Getitemdecimal(i,"nbilling_price"),4),sDavinciFormatValue5),15,sSeparator)
			//Vertragsw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(sCurrencyContract,3,sSeparator)
			//Belegw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Belegw$$HEX1$$e400$$ENDHEX$$hrung in der der Lieferant die Rechnung stellt
			of_create_davinci_string(sCurrencyDocument,3,sSeparator)
			//Airl-Kostenart	char	10	73001	Airline-Kostenart
			of_create_davinci_string(of_get_airl_cost_type(dsCenOutExtra.GetitemNumber(i,"ncosttype")),10,sSeparator)
			//Kostenstelle	Char	10	EH-Kostenstelle	Fixer Wert '94101'
			of_create_davinci_string(sCostCenter,10,sSeparator)
			//Steuerindikator	Char	2	V1	Indikator f$$HEX1$$fc00$$ENDHEX$$r Steuern und/oder Geb$$HEX1$$fc00$$ENDHEX$$hren 
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"ctaxcode"),2,sSeparator)
			//Freigabedatum	Date	8	20070831	Datum der Freigabe
			of_create_davinci_string(String(dRelease_Date,"YYYYMMDD"),8,sSeparator)
			//Automatische Freigabe	Char	1	Leer/$$HEX1$$1920$$ENDHEX$$X$$HEX3$$192009001a20$$ENDHEX$$X$$HEX1$$1920$$ENDHEX$$, falls automatische Freigabe erfolgte
			of_create_davinci_string(sstatus_autorelease,1,sSeparator)
			//Kategorie	Char	1	1	1 (Menge+Preis bekannt), 2 (Preis bekannt, Menge unbekannt),3 (Menge+Preis unbekannt)
			of_create_davinci_string(of_get_billing_category(dsCenOutExtra.Getitemnumber(i,"nmanual_input"),dsCenOutExtra.Getitemnumber(i,"nsales_price_modified")),1,sSeparator)
			//Abrechnungscode 	Char	10	2610000000	Kundennummer bei LSG-D
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"caccount"),10,sSeparator)
			//Cbase-Kostenart	char	30	Dienstleistung	Cbase-Kostenart
			of_create_davinci_string(of_get_cost_type_text(dsCenOutExtra.GetitemNumber(i,"ncosttype")),30,sSeparator)
			//Mengen-Berechnungsart	Char	40	Ratiolist I	
			of_create_davinci_string(of_get_calc_type_text(dsCenOutExtra.GetitemNumber(i,"ncalc_id")),40,sSeparator)			
			//Ratio-Prozent	Numeric	3	150	Anzahl laut Ratio beladene St$$HEX1$$fc00$$ENDHEX$$ck dieser Komponente, z.B. bei Br$$HEX1$$f600$$ENDHEX$$tchen oft 150%
			of_create_davinci_string(String(dsCenOutExtra.GetitemNumber(i,"npercentage")),3,sSeparator)
			//Berechnungswert	Numeric	10,3	1	
			of_create_davinci_string(of_decimal_to_string(dsCenOutExtra.GetitemDecimal(i,"nvalue"),sDavinciFormatValue3),13,sSeparator)
			//Versionsstaffel Bis-Wert	Numeric	4	16	z.B. bei First Version 15-16
			of_create_davinci_string(of_get_ratiolist_topax(dsCenOutExtra.GetitemNumber(i,"ncalc_detail_key")),4,sSeparator)
			//Preisberechnungsart	Char	40	SPML-Durchschnittl.Mz-Preis	
			of_create_davinci_string(of_get_price_calc_text(dsCenOutExtra.GetitemNumber(i,"nprice_calc_type")),40,sSeparator)
			//Konzept-Nr	char	30	IOFHD000700	
			of_create_davinci_string(of_get_concept_number(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),30,sSeparator)
			//Konzeptbezeichnung	char	40	LH/LR, SS 5,  breakfast 2er Auswahl	
			of_create_davinci_string(of_get_concept_text(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key"),1),40,sSeparator)
			//Konzeptbaustein 	Char	30	IOFMC (meat)	
			of_create_davinci_string(of_get_conckit_number(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key")),30,sSeparator)
			//Konzeptbausteinbezeichnung	char	40	plate large starter	
			of_create_davinci_string(of_get_conckit_text(dsCenOutExtra.GetitemNumber(i,"nhandling_detail_key")),40,sSeparator)
			//MOP-Nr	Char	30	C-HM1033-ORD	
			of_create_davinci_string(of_get_mop_number(dsCenOutExtra.GetitemNumber(i,"nhandling_meal_key"),1),30,sSeparator)
			//MOP-Bezeichnung	char	40	Hot Meal Pricate Air	
			of_create_davinci_string(of_get_mop_text(dsCenOutExtra.GetitemNumber(i,"nhandling_meal_key"),1),40,sSeparator)
			//Rotationsobjekt	Char	60	2 Monate/2 Rotationen		
			of_create_davinci_string(of_get_rotation_text(dsCenOutExtra.GetitemNumber(i,"nrotation_key")),60,sSeparator)
 			//Rotation	Char	10	A	
			of_create_davinci_string(dsCenOutExtra.Getitemstring(i,"crotation"),10,sSeparator)
			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_davinci_string("03",2,sCarriageReturn)
			
			lcounter_type_30 ++
		end if
	
		of_create_xml_string(sNull,sNull,"</Item>")
	Next
	of_create_xml_string(sNull,sNull,"</AdditionalLoading>")
	
	Return True

end function

public function boolean of_create_xml_string (string sstartelement, string svalue, string sendelement);	long		lRow
	string	sLineFeed
// --------------------------------------------
// Erstellung eines XML Strings 
// --------------------------------------------
	sLineFeed = sCarriageReturn
	If sStartElement = "" and sValue = "" and sEndElement = "</Flight>" Then
		sLineFeed = ""
	End if

	If isnull(sStartElement) 	Then 
		sStartElement 	= ""
	End if
	
	If isnull(sValue) 			Then 
		sValue 			= ""
	End if	
	
	If Pos(sValue,"&") > 0 Then
		sValue 			= "No valid text"
	End if
	
	If Pos(sValue,"<") > 0 Then
		sValue 			= "No valid text"
	End if
	
	If Pos(sValue,">") > 0 Then
		sValue 			= "No valid text"
	End if
	
	If Pos(sValue,"'") > 0 Then
		sValue 			= "No valid text"
	End if
	
	If Pos(sValue,'"') > 0 Then
		sValue 			= "No valid text"
	End if
	// -------------------------------------------------------------------
	// Zus$$HEX1$$e400$$ENDHEX$$tzlich umsetzen der CR/LF und Tabs in Space													
	// -------------------------------------------------------------------
	sValue = of_replace_string(sValue, "~r", " ")
	sValue = of_replace_string(sValue, "~n", " ")
	sValue = of_replace_string(sValue, "~t", " ")

	If isnull(sEndElement) 		Then 
		sEndElement 		= ""
	End if	

	sXMLFlightString += sStartElement + sValue + sEndElement + sLineFeed

		
	return True
end function

public function boolean of_write_xml_meal (long lkey);	integer	i
	decimal	dcQuantity
// -----------------------------------------------------
// Schreibt die Mahlzeitenbeladung in die XML-Datei
// -----------------------------------------------------
	If bMealLoading = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutMeals.Retrieve(lKey,0) 
	
	If bBillingStatus = True Then									// Abrechnung
		dsCenOutMeals.SetFilter("nbilling_status <> 1")
		dsCenOutMeals.Filter()
	Else	
		dsCenOutMeals.SetFilter("nbilling_status <> 2")
		dsCenOutMeals.Filter()
	End if	
	
	of_create_xml_string("<MealLoading>",sNull,sNull)
	For i = 1 to dsCenOutMeals.Rowcount()
		lItemlistCounter 		+= dsCenOutMeals.GetitemDecimal(i,"nquantity")
		dcItemListPerFlight 	+= dsCenOutMeals.GetitemDecimal(i,"nquantity")
		//
		// 22.02.2005: Nur Mengen > 0 schreiben
		//
		If bBillingStatus = True and iValuesLargerZero = 1 then
			dcQuantity = dsCenOutMeals.GetitemDecimal(i,"nquantity")
			if dcQuantity = 0 then continue
		End if
		of_create_xml_string("<Item>",sNull,sNull)
		of_create_xml_string("<ItemListNumber>",dsCenOutMeals.Getitemstring(i,"cpackinglist"),"</ItemListNumber>")
		of_create_xml_string("<ItemListText>",dsCenOutMeals.Getitemstring(i,"cproduction_text"),"</ItemListText>")
		of_create_xml_string("<Quantity>",string(dsCenOutMeals.GetitemDecimal(i,"nquantity"),"0.000"),"</Quantity>")
		of_create_xml_string("<ClassName>",of_get_classname(dsCenOutMeals.Getitemstring(i,"cclass")),"</ClassName>")
		of_create_xml_string("<BillingCode>",dsCenOutMeals.Getitemstring(i,"caccount"),"</BillingCode>")
		of_create_xml_string("<PostingType>",string(dsCenOutMeals.Getitemnumber(i,"nposting_type")),"</PostingType>")
		of_create_xml_string("<AdditionalBillingCode>",trim(dsCenOutMeals.Getitemstring(i,"cadditional_account")),"</AdditionalBillingCode>")		
		if bPreferredSalesPrice then
			if dsCenOutMeals.GetitemNumber(i,"nsales_price_modified") = 1 then
				of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutMeals.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
			else
				of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
			end if
		else
			of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutMeals.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
		end if
		//
		// 29.09.2006 Controlling-Informationen schicken
		//
		if bExtendedMode or bMonalisaMode then
			of_create_xml_string("<CycleCode>",dsCenOutMeals.Getitemstring(i,"crotation"),"</CycleCode>")
		end if
		if bExtendedMode then
			of_create_xml_string("<ServiceCode>",dsCenOutMeals.Getitemstring(i,"cmeal_control_code"),"</ServiceCode>")
		end if
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
		if bMonalisaMode then
			
			of_create_xml_string("<NDetailKey>",String(dsCenOutMeals.GetitemNumber(i,"ndetail_key")),"</NDetailKey>")
			of_create_xml_string("<ServiceLevel>",of_get_service_level(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),"</ServiceLevel>")
			of_create_xml_string("<ItemListUnit>",dsCenOutMeals.Getitemstring(i,"cunit"),"</ItemListUnit>")
			of_create_xml_string("<AirlCostType>",of_get_airl_cost_type(dsCenOutMeals.GetitemNumber(i,"ncosttype")),"</AirlCostType>")
			of_create_xml_string("<TaxCode>",dsCenOutMeals.Getitemstring(i,"ctaxcode"),"</TaxCode>")
			of_create_xml_string("<ReleaseDate>",String(dRelease_Date,"YYYY-MM-DD"),"</ReleaseDate>")
			of_create_xml_string("<StatusAutoBilling>",sstatus_autorelease,"</StatusAutoBilling>")
			of_create_xml_string("<BillingCategory>",of_get_billing_category(dsCenOutMeals.Getitemnumber(i,"nmanual_input"),dsCenOutMeals.Getitemnumber(i,"nsales_price_modified")),"</BillingCategory>")
			of_create_xml_string("<CbaseCostType>",of_get_cost_type_text(dsCenOutMeals.GetitemNumber(i,"ncosttype")),"</CbaseCostType>")
			of_create_xml_string("<CalcType>",of_get_calc_type_text(dsCenOutMeals.GetitemNumber(i,"ncalc_id")),"</CalcType>")
			of_create_xml_string("<RatioPercentage>",String(dsCenOutMeals.GetitemNumber(i,"npercentage")),"</RatioPercentage>")
			of_create_xml_string("<CalcValue>",String(dsCenOutMeals.GetitemNumber(i,"nvalue")),"</CalcValue>")
			of_create_xml_string("<CalcToPax>",of_get_ratiolist_topax(dsCenOutMeals.GetitemNumber(i,"ncalc_detail_key")),"</CalcToPax>")
			of_create_xml_string("<PriceCalcType>",of_get_price_calc_text(dsCenOutMeals.GetitemNumber(i,"nprice_calc_type")),"</PriceCalcType>")
			of_create_xml_string("<ConceptNumber>",of_get_concept_number(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),"</ConceptNumber>")
			of_create_xml_string("<ConceptDescription>",of_get_concept_text(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),"</ConceptDescription>")
			of_create_xml_string("<ConcKitNumber>",of_get_conckit_number(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key")),"</ConcKitNumber>")
			of_create_xml_string("<ConcKitDescription>",of_get_conckit_text(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key")),"</ConcKitDescription>")
			of_create_xml_string("<MopNumber>",of_get_mop_number(dsCenOutMeals.GetitemNumber(i,"nhandling_meal_key"),1),"</MopNumber>")
			of_create_xml_string("<MopDescription>",of_get_mop_text(dsCenOutMeals.GetitemNumber(i,"nhandling_meal_key"),1),"</MopDescription>")
			of_create_xml_string("<CycleObject>",of_get_rotation_text(dsCenOutMeals.GetitemNumber(i,"nrotation_key")),"</CycleObject>")
 			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_xml_string("<ItemListType>","01","</ItemListType>")
		
		end if 
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$30$$HEX2$$1c202000$$ENDHEX$$- Abrechnungsdaten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung 
			
			//Satzart	numeric	2	30	Satzart Abrechnungsdaten
			of_create_davinci_string("30",2,sSeparator)
			//ID	Numeric	12		Datensatz ID aus CBASE MONALISA
			of_create_davinci_string(String(dsCenOutMeals.GetitemNumber(i,"ndetail_key")),12,sSeparator)
			//Klasse 	Char	10	F	
			of_create_davinci_string(of_get_classname(dsCenOutMeals.Getitemstring(i,"cclass")),10,sSeparator)
			//Servicestufe	Char	2	5	
			of_create_davinci_string(of_get_service_level(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),2,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer	Char	18	5323701	
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"cpackinglist"),18,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer-Bezeichnung	Char	40	Emmentaler K$$HEX1$$e400$$ENDHEX$$se	
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"cproduction_text"),40,sSeparator)
			//Soll-Haben-Kennzeichen	Char	1	S oder H	Soll (Belastung), H (Gutschrift)
			of_create_davinci_string(of_get_posting_type(dsCenOutMeals.Getitemnumber(i,"nposting_type")),1,sSeparator)
			//Menge	numeric	12,3	13	Abgerechnete Menge
			of_create_davinci_string(of_decimal_to_string(dsCenOutMeals.GetitemDecimal(i,"nquantity"),sDavinciFormatValue3),13,sSeparator)
			//Mengeneinheit	Char	5	ST	
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"cunit"),5,sSeparator)
			//Einzelpreis	  numeric	12,5		(mit Dezimalpunkt)	in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung			
			of_create_davinci_string(of_decimal_to_string(dsCenOutMeals.Getitemdecimal(i,"nbilling_price"),sDavinciFormatValue5),13,sSeparator)
			//Gesamtpreis	numeric	14,5	27.95	(mit Dezimalpunkt)  Menge*Einzelpreis in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(of_decimal_to_string(Round(dsCenOutMeals.Getitemdecimal(i,"nquantity") * dsCenOutMeals.Getitemdecimal(i,"nbilling_price"),4),sDavinciFormatValue5),15,sSeparator)
			//Vertragsw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(sCurrencyContract,3,sSeparator)
			//Belegw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Belegw$$HEX1$$e400$$ENDHEX$$hrung in der der Lieferant die Rechnung stellt
			of_create_davinci_string(sCurrencyDocument,3,sSeparator)
			//Airl-Kostenart	char	10	73001	Airline-Kostenart
			of_create_davinci_string(of_get_airl_cost_type(dsCenOutMeals.GetitemNumber(i,"ncosttype")),10,sSeparator)
			//Kostenstelle	Char	10	EH-Kostenstelle	Fixer Wert '94101'
			of_create_davinci_string(sCostCenter,10,sSeparator)
			//Steuerindikator	Char	2	V1	Indikator f$$HEX1$$fc00$$ENDHEX$$r Steuern und/oder Geb$$HEX1$$fc00$$ENDHEX$$hren 
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"ctaxcode"),2,sSeparator)
			//Freigabedatum	Date	8	20070831	Datum der Freigabe
			of_create_davinci_string(String(dRelease_Date,"YYYYMMDD"),8,sSeparator)
			//Automatische Freigabe	Char	1	Leer/$$HEX1$$1920$$ENDHEX$$X$$HEX3$$192009001a20$$ENDHEX$$X$$HEX1$$1920$$ENDHEX$$, falls automatische Freigabe erfolgte
			of_create_davinci_string(sstatus_autorelease,1,sSeparator)
			//Kategorie	Char	1	1	1 (Menge+Preis bekannt), 2 (Preis bekannt, Menge unbekannt),3 (Menge+Preis unbekannt)
			of_create_davinci_string(of_get_billing_category(dsCenOutMeals.Getitemnumber(i,"nmanual_input"),dsCenOutMeals.Getitemnumber(i,"nsales_price_modified")),1,sSeparator)
			//Abrechnungscode 	Char	10	2610000000	Kundennummer bei LSG-D
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"caccount"),10,sSeparator)
			//Cbase-Kostenart	char	30	Dienstleistung	Cbase-Kostenart
			of_create_davinci_string(of_get_cost_type_text(dsCenOutMeals.GetitemNumber(i,"ncosttype")),30,sSeparator)
			//Mengen-Berechnungsart	Char	40	Ratiolist I	
			of_create_davinci_string(of_get_calc_type_text(dsCenOutMeals.GetitemNumber(i,"ncalc_id")),40,sSeparator)			
			//Ratio-Prozent	Numeric	3	150	Anzahl laut Ratio beladene St$$HEX1$$fc00$$ENDHEX$$ck dieser Komponente, z.B. bei Br$$HEX1$$f600$$ENDHEX$$tchen oft 150%
			of_create_davinci_string(String(dsCenOutMeals.GetitemNumber(i,"npercentage")),3,sSeparator)
			//Berechnungswert	Numeric	12,3	1	
			of_create_davinci_string(of_decimal_to_string(dsCenOutMeals.GetitemDecimal(i,"nvalue"),sDavinciFormatValue3),13,sSeparator)
			//Versionsstaffel Bis-Wert	Numeric	4	16	z.B. bei First Version 15-16
			of_create_davinci_string(of_get_ratiolist_topax(dsCenOutMeals.GetitemNumber(i,"ncalc_detail_key")),4,sSeparator)
			//Preisberechnungsart	Char	40	SPML-Durchschnittl.Mz-Preis	
			of_create_davinci_string(of_get_price_calc_text(dsCenOutMeals.GetitemNumber(i,"nprice_calc_type")),40,sSeparator)
			//Konzept-Nr	char	30	IOFHD000700	
			of_create_davinci_string(of_get_concept_number(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),30,sSeparator)
			//Konzeptbezeichnung	char	40	LH/LR, SS 5,  breakfast 2er Auswahl	
			of_create_davinci_string(of_get_concept_text(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key"),1),40,sSeparator)
			//Konzeptbaustein 	Char	30	IOFMC (meat)	
			of_create_davinci_string(of_get_conckit_number(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key")),30,sSeparator)
			//Konzeptbausteinbezeichnung	char	40	plate large starter	
			of_create_davinci_string(of_get_conckit_text(dsCenOutMeals.GetitemNumber(i,"nhandling_detail_key")),40,sSeparator)
			//MOP-Nr	Char	30	C-HM1033-ORD	
			of_create_davinci_string(of_get_mop_number(dsCenOutMeals.GetitemNumber(i,"nhandling_meal_key"),1),30,sSeparator)
			//MOP-Bezeichnung	char	40	Hot Meal Pricate Air	
			of_create_davinci_string(of_get_mop_text(dsCenOutMeals.GetitemNumber(i,"nhandling_meal_key"),1),40,sSeparator)
			//Rotationsobjekt	Char	60	2 Monate/2 Rotationen		
			of_create_davinci_string(of_get_rotation_text(dsCenOutMeals.GetitemNumber(i,"nrotation_key")),60,sSeparator)
 			//Rotation	Char	10	A	
			of_create_davinci_string(dsCenOutMeals.Getitemstring(i,"crotation"),10,sSeparator)
			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_davinci_string("01",2,sCarriageReturn)
			
			lcounter_type_30 ++
		end if
		
		of_create_xml_string(sNull,sNull,"</Item>")
	Next
	of_create_xml_string(sNull,sNull,"</MealLoading>")	
	Return True




end function

public function string of_get_classname (string arg_cbase_class);//
// of_get_classname
//
// Mapping der CBASE-Klassen auf "offizielle" Export-Klassen
//
long	lFind

if dsClassMapping.RowCount() = 0 then
	return arg_cbase_class
end if

lFind = dsClassMapping.Find("cen_airlines_cairline = '" + sBillingAirlineCode + &
			"' and cen_class_name_cclass = '" + arg_cbase_class + "'",1,dsClassMapping.RowCount())

if lFind > 0 then
	return dsClassMapping.GetItemString(lFind,"cen_class_name_cclass_return")
else
	return arg_cbase_class
end if

end function

public function long of_retrieve_classnames ();//
// of_retrieve_classnames
//
// Holt die Klassen f$$HEX1$$fc00$$ENDHEX$$r das Mapping,
// wird von aussen aufgerufen
//

return dsClassMapping.Retrieve(sClient)

end function

public function boolean of_save_xml ();//=====================================================================================
//
// of_save_xml
//
// Kompletter XML-Blob in Datei schreiben
//
//=====================================================================================
long	lReturn

lReturn = f_blob_to_file_unicode(sFileName,bXMLFile)

if lReturn = 0 then
	return false
else
	return true
end if


end function

public function boolean of_write_add_delivery (long lkey);	integer	i
// -----------------------------------------------------
// Nachlieferungen f$$HEX1$$fc00$$ENDHEX$$r XML
// (gleiche Struktur wie Extrabeladung)
// -----------------------------------------------------
	If bAdditionalDelivery = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	dsCenOutAddDelivery.Retrieve(lKey) 
	
	of_create_xml_string("<AdditionalLoading>",sNull,sNull)
	For i = 1 to dsCenOutAddDelivery.Rowcount()
		lItemlistCounter 		+= dsCenOutAddDelivery.GetitemDecimal(i,"non_req_quantity")
		dcItemListPerFlight 	+= dsCenOutAddDelivery.GetitemDecimal(i,"non_req_quantity")
		of_create_xml_string("<Item>",sNull,sNull)
		of_create_xml_string("<ItemListNumber>",dsCenOutAddDelivery.Getitemstring(i,"cpackinglist"),"</ItemListNumber>")
		of_create_xml_string("<ItemListText>",dsCenOutAddDelivery.Getitemstring(i,"cremark"),"</ItemListText>")
		of_create_xml_string("<Quantity>",string(dsCenOutAddDelivery.GetitemDecimal(i,"non_req_quantity"),"0.000"),"</Quantity>")
		of_create_xml_string("<ClassName>","","</ClassName>")
		of_create_xml_string("<BillingCode>","","</BillingCode>")	// 1
		of_create_xml_string("<PostingType>","","</PostingType>")
		of_create_xml_string("<AdditionalBillingCode>","","</AdditionalBillingCode>")		// 1

		// --------------------------------------------------------------------------------------------------------------------
		// 13.01.2010 HR: CBASE-F4-EM-9036: Prefered Sales Price soll NULL sein
		// --------------------------------------------------------------------------------------------------------------------
		//of_create_xml_string("<PreferredSalesPrice>","0.00","</PreferredSalesPrice>")
		of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
		of_create_xml_string(sNull,sNull,"</Item>")
	Next
	of_create_xml_string(sNull,sNull,"</AdditionalLoading>")
	
	Return True

end function

public function integer of_retrieve_billing_status (string arg_client, string arg_unit, date arg_departure);//=================================================================================
//
// of_retrieve_billing_status
//
// Holt die Pr$$HEX1$$fc00$$ENDHEX$$fsummen f$$HEX1$$fc00$$ENDHEX$$r die Abrechnung
//
//=================================================================================

//dsBillingStatus.Retrieve(arg_departure,arg_client)
//dsBillingStatus.SetFilter("cunit = '" + arg_unit + "'")
//dsBillingStatus.Filter()


return 0

end function

public function integer of_write_billing_status (string arg_client, date arg_departure, long arg_customer, string arg_unit);//=================================================================================
//
// of_write_billing_status
//
// Schreibt die Pr$$HEX1$$fc00$$ENDHEX$$fsumme f$$HEX1$$fc00$$ENDHEX$$r den Betrieb nach sys_billing_status
//
// Datastore ist bereits nach Client, Departure, Unit gefiltert
// (siehe of_retrieve_billing_status)
//
//=================================================================================
long		lRows
long		lFlightsSent
decimal	dcQuantity

//
// Achtung: Bei Flug-Storno m$$HEX1$$fc00$$ENDHEX$$ssen die Mengen reduziert werden!!!
//
lRows = dsBillingStatus.Retrieve(arg_client,arg_unit,arg_customer,arg_departure)
if lRows > 0 then
	dcQuantity		= dsBillingStatus.GetItemDecimal(1,"nquantity_sent")
	lFlightsSent	= dsBillingStatus.GetItemNumber(1,"nflights_sent")
else
	//
	// Es wurden noch keine Protokolleintr$$HEX1$$e400$$ENDHEX$$ge gefunden
	//
	lRows = dsBillingStatus.InsertRow(0)
	dsBillingStatus.SetItem(lRows,"cclient",				arg_client)
	dsBillingStatus.SetItem(lRows,"cunit",					arg_unit)
	dsBillingStatus.SetItem(lRows,"ddeparture",			arg_departure)
	dsBillingStatus.SetItem(lRows,"nflights_total",		0)
	dsBillingStatus.SetItem(lRows,"ncustomer_key",		arg_customer)
end if

//
// Fallunterscheidung: Storno/Belastung
//
if iFlightPostingType = 1 then
	//
	// Flug-Belastung
	//
	dcQuantity += dcItemListPerFlight
	lFlightsSent ++
	dsBillingStatus.SetItem(1,"nquantity_sent",dcQuantity)
	dsBillingStatus.SetItem(1,"nflights_sent",lFlightsSent)
elseif iFlightPostingType = 2 then
	//
	// Flug-Stornierung
	//
	dcQuantity -= dcItemListPerFlight
	lFlightsSent --
	dsBillingStatus.SetItem(1,"nquantity_sent",dcQuantity)
	dsBillingStatus.SetItem(1,"nflights_sent",lFlightsSent)
end if

//
// Update sollte unmittelbar erfolgen um konkurrierenden Zugriff zu vermeiden
//
if dsBillingStatus.Update() <> 1 then
	uf.mbox("Fehler","$$HEX1$$dc00$$ENDHEX$$bertragungsprotokoll konnte nicht aktualisiert werden!",StopSign!)
	rollback;
else
	commit;
end if

return 0

end function

public function string of_get_quantity_meals (integer arg_function, string arg_class, integer arg_version);//==========================================================================================================
//
// of_get_quantity_meal
//
// Liefert die Anzahl Meals (arg_function = 0) oder SPMLs (arg_function = 1) aus der Sicht des Controlling
//
//==========================================================================================================
long 	i
long	lTotal, lSum
long	lReserveQuantity, lPaxQuantity, lTopOffQuantity, lSPMLQuantity, lQuantity
long	lReserveType, lTopOffType, lControlling
Integer iManualInput

//
// Anzahl SPML je Klasse
//
if arg_function = 1 then
	for i = 1 to dsCenOutMealsAccumulator.RowCount()
		if dsCenOutMealsAccumulator.GetItemString(i, "cclass") = arg_class then
			return string(dsCenOutMealsAccumulator.GetItemNumber(i,"nspml_quantity"))
		end if
	next
end if

//
// Anzahl Mahlzeiten je Klasse
//
if arg_function = 0 then
	lTotal 	= 0
	lSum	 	= 0
	for i = 1 to dsCenOutMealsAccumulator.RowCount()
		if dsCenOutMealsAccumulator.GetItemString(i, "cclass") = arg_class then
			lReserveQuantity		= dsCenOutMealsAccumulator.GetItemNumber(i, "nreserve_quantity")
			lPaxQuantity			= dsCenOutMealsAccumulator.GetItemNumber(i, "npax")
			lTopOffQuantity		= dsCenOutMealsAccumulator.GetItemNumber(i, "ntopoff_quantity")
			lSPMLQuantity			= dsCenOutMealsAccumulator.GetItemNumber(i, "nspml_quantity")
			lQuantity				= dsCenOutMealsAccumulator.GetItemNumber(i, "nquantity")
			lReserveType			= dsCenOutMealsAccumulator.GetItemNumber(i, "nreserve_type")
			lTopOffType				= dsCenOutMealsAccumulator.GetItemNumber(i, "ntopoff_type")
			lControlling			= dsCenOutMealsAccumulator.GetItemNumber(i, "ncontrolling")
			iManualInput			= dsCenOutMealsAccumulator.GetItemNumber(i, "nmanual_input")	
			lTotal 					= 0
			
			// $$HEX1$$dc00$$ENDHEX$$berspringt die Berechnung dieser St$$HEX1$$fc00$$ENDHEX$$ckliste, wenn der Benutzer die
			// Mahlzeitenmenge = 0 gesetzt hat 
			if lQuantity = 0 and iManualInput = 1 then continue
			
			Choose case	lControlling
					
				case 1 // Pax + Reserve + TopOff
					lTotal = lPaxQuantity
					// Reserve					
					// bis Version (1,3)
					if lTotal + lReserveQuantity > arg_version and &
						(lReserveType = 1 or lReserveType = 3) then
						
						lTotal = arg_version
						
					else // Reserve immer
						
						lTotal += lReserveQuantity
						
					end if
						
					// TopOff					
					// bis Version (1,3)
					if lTotal + lTopOffQuantity > arg_version and &
						(lTopOffType = 1 or lTopOffType = 3) then
						
						lTotal = arg_version
						
					else // TopOff immer
						
						lTotal += lTopOffQuantity
						
					end if
						
				case 2 // Pax + Reserve + TopOff + SPML
					lTotal = lPaxQuantity
					// Reserve					
					// bis Version (1,3)
					if lTotal + lReserveQuantity > arg_version and &
						(lReserveType = 1 or lReserveType = 3) then
						
						lTotal = arg_version
						
					else // Reserve immer
						
						lTotal += lReserveQuantity
						
					end if
						
					// TopOff					
					// bis Version (1,3)
					if lTotal + lTopOffQuantity > arg_version and &
						(lTopOffType = 1 or lTopOffType = 3) then
						
						lTotal = arg_version
						
					else // TopOff immer
						
						lTotal += lTopOffQuantity
						
					end if
						
					// SPML
					lTotal += lSPMLQuantity
				case 3 // Menge
					lTotal = lQuantity
					
				case 4 // Menge + SPML
					lTotal = lQuantity
					lTotal += lSPMLQuantity
					
			end choose
				
			lSum += lTotal
			
			
//			lValue = this.GetItemNumber(i, "nmeal" + string(iColumn))
//			if isnull(lValue) then lValue = 0
			
//			this.SetItem(i, "nmeal" + string(iColumn), lValue + lSum)
			
		end if
	next
end if


return string(lSum)

end function

public function long of_retrieve_units ();//
// of_retrieve_units
//
// Holt die Werke und Mandanten f$$HEX1$$fc00$$ENDHEX$$r das Mapping,
// wird von aussen aufgerufen
//

return dsClientUnitMapping.Retrieve(sClient)

end function

public function string of_get_price_calc_text (long arg_key);//==========================================================================================================
//
// of_get_price_calc_text
//
// Liefert den Text zum nprice_calc_type_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsPriceCalcType.find("nprice_calc_type_key = "+String(arg_key), &
       1, dsPriceCalcType.RowCount())
if lfind > 0 then
	sText=dsPriceCalcType.getItemString(lfind, "cshort_name")
end if

return stext

end function

public function string of_get_cost_type_text (long arg_key);//==========================================================================================================
//
// of_get_cost_type_text
//
// Liefert den Text zum ncost_type_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsCostType.find("ncost_type_key = "+String(arg_key), &
       1, dsCostType.RowCount())
if lfind > 0 then
	sText=dsCostType.getItemString(lfind, "ctext")
end if

return stext

end function

public function string of_get_airl_cost_type (long arg_key);//==========================================================================================================
//
// of_get_airl_cost_type
//
// Liefert die Airline-Kostenart zum ncost_type_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsCostType.find("ncost_type_key = "+String(arg_key), &
       1, dsCostType.RowCount())
if lfind > 0 then
	sText=dsCostType.getItemString(lfind, "ccost_type_cust")
end if

return stext

end function

public function string of_get_calc_type_text (long arg_key);//==========================================================================================================
//
// of_get_calc_type_text
//
// Liefert den Text zum ncalc_id
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsCalcType.find("ncalc_id = "+String(arg_key), &
       1, dsCalcType.RowCount())
if lfind > 0 then
	sText=dsCalcType.getItemString(lfind, "ccalc")
end if

return stext

end function

public function string of_get_rotation_text (long arg_key);//==========================================================================================================
//
// of_getrotation_text
//
// Liefert den Text zum nrotations_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsRotations.find("nrotation_key = "+String(arg_key), &
       1, dsRotations.RowCount())
if lfind > 0 then
	sText=dsRotations.getItemString(lfind, "ctext")
end if

return stext

end function

public function long of_retrieve_calctype ();//
// of_retrieve_calctype
//
// Liest die Berechnungsarten ein
//

if dsCalcType.RowCount() > 0 then

else
	dsCalcType.Retrieve()
end if
return 0

end function

public function long of_retrieve_pricecalctype ();//
// of_retrieve_pricecalctype
//
// Liest die Preisberechnungsarten ein
//

if dsPriceCalcType.RowCount() > 0 then

else
	dsPriceCalcType.Retrieve()
end if
return 0

end function

public function long of_retrieve_rotations (long al_cust_key);//
// of_retrieve_rotations
//
// Liest die Rotationsobjekte ein, wenn neue Keys vorhanden
//
if 	lrotations_customer = al_cust_key then
else
	dsRotations.Retrieve(al_cust_key)
	lrotations_customer = al_cust_key
end if

return 0

end function

public function long of_retrieve_costtype (long al_cust_key, date ad_date);//
// of_retrieve_costtype
//
// Liest die Kostenarten ein, wenn neue Keys vorhanden
//
if 	lcosttype_customer = al_cust_key and &
 	dcosttype_date = ad_date then
else
	dsCostType.Retrieve(al_cust_key, ad_date)
	lcosttype_customer = al_cust_key
	dcosttype_date = ad_date
end if

return 0

end function

public function long of_retrieve_mop (long al_result_key);//
// of_retrieve_mop
//
// Liest die Mops ein
//
dsMop.Retrieve(al_result_key)
return 0

end function

public function long of_retrieve_conc_conckit (long al_result_key);//
// of_retrieve_conc_cockit
//
// Liest die Konzepte/konzeptbausteine ein
//
dsConcConcKit.Retrieve(al_result_key)
return 0

end function

public function string of_get_conckit_number (long arg_key);//==========================================================================================================
//
// of_get_conckit_number
//
// Liefert die Konzeptbaustein-Nummer zum nhandling_detail_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsConcConcKit.find("cen_meals_detail_nhandling_detail_key = "+String(arg_key), &
	      1, dsConcConcKit.RowCount())
if lfind > 0 then
	sText=dsConcConcKit.getItemString(lfind, "cen_handlingb_ctext")
end if

return stext

end function

public function string of_get_conckit_text (long arg_key);//==========================================================================================================
//
// of_get_conckit_text
//
// Liefert den Konzeptbaustein-Text zum nhandling_detail_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsConcConcKit.find("cen_meals_detail_nhandling_detail_key = "+String(arg_key), &
	      1, dsConcConcKit.RowCount())
if lfind > 0 then
	sText=dsConcConcKit.getItemString(lfind, "cen_handlingb_cdescription")
end if

return stext

end function

public function long of_retrieve_ratiolistdetail (long al_cust_key, date ad_date);//
// of_retrieve_ratiolistdetails
//
// Liest die bisMengen der Ratiolisten ein, wenn neue Keys vorhanden
//
if 	lratiolistdetail_customer = al_cust_key and &
 	dratiolistdetail_date = ad_date then
else
	dsRatiolistDetail.Retrieve(al_cust_key, ad_date)
	lratiolistdetail_customer = al_cust_key
	dratiolistdetail_date = ad_date
end if

return 0

end function

public function string of_get_ratiolist_topax (long arg_key);//==========================================================================================================
//
// of_get_ratiolist_toPax
//
// Liefert die bis-Pax-menge der Ratiolist zum nratiolist_detail_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsRatiolistDetail.find("nratiolist_detail_key = "+String(arg_key), &
       1, dsRatiolistDetail.RowCount())
if lfind > 0 then
	sText=String(dsRatiolistDetail.getItemNumber(lfind, "ntopax"))
end if

return stext

end function

public function string of_get_billing_category (long al_manual_input, integer al_sales_price_modified);//==========================================================================================================
//
// of_get_billing_category
//
// Liefert die Abrechnungskategorie zur$$HEX1$$fc00$$ENDHEX$$ck:
//	1 (Menge+Preis bekannt),
//	2 (Preis bekannt, Menge unbekannt),
//	3 (Menge+Preis unbekannt)
//==========================================================================================================
String sText
Integer i

if al_sales_price_modified = 1 then
	// 3 (Menge+Preis unbekannt)
	i = 3
else
	if al_manual_input = 1 then
		// 2 (Preis bekannt, Menge unbekannt),
		i = 2
	else
		// 1 (Menge+Preis bekannt),
		i = 1
	end if
end if
stext = String(i)
return stext

end function

public function boolean of_create_davinci_string (string svalue, long lmaxlength, string sseparatortext);	long		lRow
	long		lstart_pos
// --------------------------------------------
// Erstellung eines Davinci-Feld Strings 
// --------------------------------------------

	If isnull(sValue) 			Then 
		sValue 			= ""
	End if	
	// -------------------------------------------------------------------
	// Separator zwischen den Feldern darf nicht innerhalb der Felder	
	// verwendet werden, wird durch ein Ersatzzeichen ausgetauscht
	// -------------------------------------------------------------------
	sValue = of_replace_string(sValue, sSeparator, sSeparator_Exchange)
	//sCarriageReturn				= "~r~n"
	// -------------------------------------------------------------------
	// Zus$$HEX1$$e400$$ENDHEX$$tzlich umsetzen der CR/LF und Tabs in Space													
	// -------------------------------------------------------------------
	sValue = of_replace_string(sValue, "~r", " ")
	sValue = of_replace_string(sValue, "~n", " ")
	sValue = of_replace_string(sValue, "~t", " ")
	
	// -------------------------------------------------------------------
	// auf maximale Feldl$$HEX1$$e400$$ENDHEX$$nge innerhalb der Schnittstelle begrenzen
	// -------------------------------------------------------------------
	sValue = Mid (sValue, 1, lmaxlength)


	If isnull(sSeparatorText) 		Then 
		sSeparatorText		= ""
	End if	

	sDavinciFlightString += sValue + sSeparatorText

		
	return True
end function

public function string of_get_posting_type (long arg_posting_type);//==========================================================================================================
//
// of_get_posting_type
//
// Liefert  'S' f$$HEX1$$fc00$$ENDHEX$$r Soll oder 'H' f$$HEX1$$fc00$$ENDHEX$$r Haben zur$$HEX1$$fc00$$ENDHEX$$ck
//==========================================================================================================

String sText

if iflightPostingType = 1 then
	if arg_posting_type = 1 then
		 sText = 'S'
	else
		sText = 'H'
	end if
else
	if arg_posting_type = 1 then
		 sText = 'H'
	else
		sText = 'S'
	end if
end if

return stext

end function

public function string of_get_supplier_no (string arg_key);//==========================================================================================================
//
// of_get_supplier_no
//
// Liefert die Airline-Lieferantennummer zum Werk
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsUnitSupplier.find("cunit = '"+arg_key+"'", &
       1, dsUnitSupplier.RowCount())
if lfind > 0 then
	sText=dsUnitSupplier.getItemString(lfind, "csupp_nr_unit")
	if isNull(sText) or sText="" then
		sText=dsUnitSupplier.getItemString(lfind, "csupp_nr_supp")
	end if
end if

return stext

end function

public function string of_get_unit_tlc (string arg_key);//==========================================================================================================
//
// of_get_unit_tlc
//
// Liefert den 3LetterCode zum Werk
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsUnitSupplier.find("cunit = '"+arg_key+"'", &
       1, dsUnitSupplier.RowCount())
if lfind > 0 then
	sText=dsUnitSupplier.getItemString(lfind, "sys_three_letter_codes_ctlc")
end if

return stext

end function

public function long of_retrieve_unitsupplier (long al_customer);//
// of_retrieve_unit_supplier
//
// Liest die Werke/Lieferanten ein
//
if lunitsupplier_customer <> al_customer then
	lunitsupplier_customer = al_customer
	return dsUnitSupplier.Retrieve(sClient, al_customer)
end if
return 0

end function

public function long of_retrieve_acg_master (long al_customer);//
// of_retrieve_acg_master
//
// Liest die Flugger$$HEX1$$e400$$ENDHEX$$tgruppen ein
//
if lacg_master_customer <> al_customer then
	lacg_master_customer = al_customer
	return dsACGMaster.Retrieve( al_customer)
end if
return 0

end function

public function string of_get_acg_master (long arg_key);//==========================================================================================================
//
// of_get_acg_master
//
// Liefert die Flugger$$HEX1$$e400$$ENDHEX$$tgrup$$HEX1$$fc00$$ENDHEX$$pe zum acg_master_key
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText

lfind = dsACGMaster.find("nacg_master_key = "+String(arg_key), &
       1, dsACGMaster.RowCount())
if lfind > 0 then
	sText=dsACGMaster.getItemString(lfind, "ctext")
end if

return stext

end function

public function boolean of_write_davinci (string sdavincistring);// -------------------------------------------------------
// eEncoding ist im open Event der App definiert
// -------------------------------------------------------

if pos(sDavinciString,sCarriageReturn,len(sDavinciString) - 2) > 0 then
	bDavinciFile += blob(sDavinciString,EncodingANSI!)
else
	bDavinciFile += blob(sDavinciString + sCarriageReturn,EncodingANSI!)
end if

return True

end function

public function boolean of_save_davinci ();//=====================================================================================
//
// of_save_davinci
//
// Kompletter Davinci-Blob in Datei schreiben
//
//=====================================================================================
long	lReturn

lReturn = f_blob_to_file_unicode(sdavinciFileName,bDavinciFile)

if lReturn = 0 then
	return false
else
	return true
end if


end function

public function boolean of_write_davinci_end_record ();// ----------------------------------------------------------------------------
//
// of_write_davinci_end_record
//
// ----------------------------------------------------------------------------
//
// Schreibt den Ende-Satz mit der Anzahl je Satzart
//
// ----------------------------------------------------------------------------
if bCreateDaVinciInterface then
		//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$99$$HEX2$$1c202000$$ENDHEX$$- Endesatz				
		//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung
		
		//Satzart	numeric	2	99	Satzart Endesatz
		of_create_davinci_string("99",2,sSeparator)
		
		//Anzahl Satzart-10	Numeric	9	22	Anzahl Flugdaten-S$$HEX1$$e400$$ENDHEX$$tze
		of_create_davinci_string(String(lcounter_type_10),9,sSeparator)
				
		//Anzahl Satzart-20	Numeric	9	46	Anzahl Klassendaten-S$$HEX1$$e400$$ENDHEX$$tze
		of_create_davinci_string(String(lcounter_type_20),9,sSeparator)
		
		//Anzahl Satzart-30	Numeric	9	2320	Anzahl Abrechnungs-S$$HEX1$$e400$$ENDHEX$$tze
		of_create_davinci_string(String(lcounter_type_30),9,sCarriageReturn	)

end if

Return True

end function

public function boolean of_davinci_reset ();// -----------------------------------------
// initialisieren der Z$$HEX1$$e400$$ENDHEX$$hler je Satzart 
// -----------------------------------------
	lcounter_type_10=0
	lcounter_type_20=0
	lcounter_type_30=0
	sDavinciFlightString  =""
	return True
	
end function

public function string of_decimal_to_string (decimal decvalue, string sformat);	long		lstart_pos_dot, lformat_pos_dot
	long		lstart_pos_comma, lFormat_Pos_Comma
	String 	sText
	String		sDot="."
	String		sComma=","
// --------------------------------------------
// Umsetzung Dezimalzahl in String, Verwendung des $$HEX1$$fc00$$ENDHEX$$bergebenen Formats
// und nicht der internen Einstellungen
// --------------------------------------------

	sText = string(decValue, sFormat)
	
	lFormat_pos_dot 		= Pos(sFormat,sDot)
	lstart_pos_dot 			= Pos(sText,sDot)
	lFormat_pos_Comma	= Pos(sFormat,sComma)
	lstart_pos_comma		= Pos(sText,sComma)
	
	if 	lFormat_pos_dot > lFormat_pos_comma then
		// Punkt als Kommazeichen gew$$HEX1$$fc00$$ENDHEX$$nscht
		if lstart_pos_comma > 0 then
			sText = Replace(sText, lstart_pos_comma,  Len(sComma), sDot)
		end if

	else
		// Komma als Kommazeichen gew$$HEX1$$fc00$$ENDHEX$$nscht
		if lstart_pos_dot > 0 then
			sText = Replace(sText, lstart_pos_dot,  Len(sDot), sComma)
		end if

	end if
	
	
	return stext
end function

public function string of_get_mop_number (long arg_key, integer itype);//==========================================================================================================
//
// of_get_mop_number
//
// Liefert die Mop-Nummer zum nhandling_meal_key
//	itype = 1: Meal
//	itype = 2: SPML
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText
if itype = 1 then
	lfind = dsMop.find("cen_meals_nhandling_meal_key = "+String(arg_key), &
  	     1, dsMop.RowCount())
	if lfind > 0 then
		sText=dsMop.getItemString(lfind, "cen_handling_ctext")	
	end if
else
	lfind = dsMopSPML.find("cen_out_spml_detail_ndetail_key = "+String(arg_key), &
  	     1, dsMopSPML.RowCount())
	if lfind > 0 then
		sText=dsMopSPML.getItemString(lfind, "cen_handling_ctext")	
	end if

end if

return stext

end function

public function string of_get_mop_text (long arg_key, integer itype);//==========================================================================================================
//
// of_get_mop_text
//
// Liefert den Mop-Text zum nhandling_meal_key
//	itype = 1: Meal
//	itype = 2: SPML
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText



if itype = 1 then
	lfind = dsMop.find("cen_meals_nhandling_meal_key = "+String(arg_key), &
		      1, dsMop.RowCount())
	if lfind > 0 then
		sText=dsMop.getItemString(lfind, "cen_mop_master_ctext")
	end if
else
	lfind = dsMopSPML.find("cen_out_spml_detail_ndetail_key = "+String(arg_key), &
  		     1, dsMopSPML.RowCount())
	if lfind > 0 then
		sText=dsMopSPML.getItemString(lfind, "cen_mop_master_ctext")	
	end if

end if
return stext

end function

public function string of_get_concept_number (long arg_key, integer itype);//==========================================================================================================
//
// of_get_concept_number
//
// Liefert die Konzept-Nummer zum nhandling_detail_key
//	itype = 1: Meal
//	itype = 2: SPML
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText



if itype = 1 then
	lfind = dsConcConcKit.find("cen_meals_detail_nhandling_detail_key = "+String(arg_key), &
		      1, dsConcConcKit.RowCount())
	if lfind > 0 then
		sText=dsConcConcKit.getItemString(lfind, "cen_handlinga_ctext")
	end if

else
	lfind = dsMopSPML.find("cen_out_spml_detail_ndetail_key = "+String(arg_key), &
  	     1, dsMopSPML.RowCount())
	if lfind > 0 then
		sText=dsMopSPML.getItemString(lfind, "cen_handling_conc_ctext")	
	end if

end if
return stext

end function

public function string of_get_concept_text (long arg_key, integer itype);//==========================================================================================================
//
// of_get_concept_text
//
// Liefert den Konzept-Text zum nhandling_detail_key
//	itype = 1: Meal
//	itype = 2: SPML
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText


if itype = 1 then
	lfind = dsConcConcKit.find("cen_meals_detail_nhandling_detail_key = "+String(arg_key), &
		      1, dsConcConcKit.RowCount())
	if lfind > 0 then
		sText=dsConcConcKit.getItemString(lfind, "cen_handlinga_cdescription")
	end if

else
	lfind = dsMopSPML.find("cen_out_spml_detail_ndetail_key = "+String(arg_key), &
  	     1, dsMopSPML.RowCount())
	if lfind > 0 then
		sText=dsMopSPML.getItemString(lfind, "cen_handling_conc_ctext")	
	end if

end if
return stext

end function

public function string of_get_service_level (long arg_key, integer itype);//==========================================================================================================
//
// of_get_service_level
//
// Liefert die Servicestufe zum nhandling_detail_key
//	itype = 1: Meal
//	itype = 2: SPML
// (erwartet einen gef$$HEX1$$fc00$$ENDHEX$$llten datastore)
//==========================================================================================================
long 	lfind
String sText


if itype = 1 then
	lfind = dsConcConcKit.find("cen_meals_detail_nhandling_detail_key = "+String(arg_key), &
		      1, dsConcConcKit.RowCount())
	if lfind > 0 then
		sText=String(dsConcConcKit.getItemNumber(lfind, "nservice_level"))	
	end if

else
	lfind = dsMopSPML.find("cen_out_spml_detail_ndetail_key = "+String(arg_key), &
  	     1, dsMopSPML.RowCount())
	if lfind > 0 then
		sText=String(dsMopSPML.getItemNumber(lfind, "nservice_level"))
	end if

end if
return stext

end function

public function long of_retrieve_mop_spml (long al_result_key, date ad_date);//
// of_retrieve_mop_spml
//
// Liest die Mops und Konzepte zu den SPML ein
//
dsMopSPML.Retrieve(al_result_key, ad_date)
return 0

end function

public function boolean of_write_xml_periodic_event (long lkey);// ----------------------------------------------------------------------------
//
// of_write_xml_periodic_event
//
// ----------------------------------------------------------------------------
//
// Schreibt XML f$$HEX1$$fc00$$ENDHEX$$r einen Periodenereignis und wird direkt aus dem window  
// aufgerufen. Dazu wird der Result-Key lKey $$HEX1$$fc00$$ENDHEX$$bergeben.
//
// ----------------------------------------------------------------------------
Date		dDepartureDate
string	sLocalClient
long		lCustomer, lfind
string	sLocalUnit
string	sMappingUnit, sMappingClient
Integer 	i
Integer irow
decimal	dcQuantity
integer	iFlightNo, iFlightNo2, iOldFlightNo	
string		sSuffix, sUnit, sFilter, sSuffix2, sUnit2, sAirline, sAirline2
string		sOldSuffix, sOldUnit, sOldAirline
Datetime		dtDate, dtDate2, dtOldDate
Long		lAirlineKey, lAirlineKey2

		
// ----------------------------------------------------------------------------
// Kontrollsumme je Flug zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// ----------------------------------------------------------------------------
dcItemListPerFlight = 0

// ----------------------------------------------------------------------------
// Erzeugt einen XML-String
// ----------------------------------------------------------------------------
sXMLFlightString = ""
sDavinciFlightString = ""
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
If dsCenOutPeriod.Retrieve(lKey) = 1 Then
	dsCenOutPeriodFlights.Retrieve(lkey,2) 
	dsCenOutPeriodDetail.Retrieve(lkey,2) 
	
	iFlightNo2=dsCenOutPeriod.GetItemNumber(1,"nflight_number")
	sSuffix2=dsCenOutPeriod.GetItemString(1,"csuffix")
	sUnit2=dsCenOutPeriod.GetItemString(1,"cunit")
	sAirline2=dsCenOutPeriod.GetItemString(1,"cairline")
	dtDate2=dsCenOutPeriod.GetItemDatetime(1,"dposting_date")
	lAirlineKey2=dsCenOutPeriod.GetItemNumber(1,"nairline_key")
	// -----------------------------------------------------	
	// Anpassen ZeilenFlight an Header-Info, falls leer/Null
	// TLE_20012009 Korrektur Fehler bei zus$$HEX1$$e400$$ENDHEX$$tzlich erfassten Positionen (cunit2 ist null oder 5174)
	// -----------------------------------------------------	
	for irow = 1 to dsCenOutPeriodFlights.RowCount()
		
		iFlightNo=dsCenOutPeriodFlights.GetItemNumber(irow,"nflight_number")
		sSuffix=dsCenOutPeriodFlights.GetItemString(irow,"csuffix")
		sUnit=dsCenOutPeriodFlights.GetItemString(irow,"cunit2")
		dtDate=dsCenOutPeriodFlights.GetItemDatetime(irow,"ddeparture")
		sAirline=dsCenOutPeriodFlights.GetItemString(irow,"cairline")
		lAirlineKey2=dsCenOutPeriodFlights.GetItemNumber(irow,"nairline_key")

		
		if isnull(iFlightNo) then
			dsCenOutPeriodFlights.SetItem(irow,"nflight_number",iFlightNo2)
		end if
		if sSuffix = "" or isnull(sSuffix) then
			dsCenOutPeriodFlights.SetItem(irow,"csuffix",sSuffix2)
		end if
		if sAirline = "" or isnull(sAirline) then
			dsCenOutPeriodFlights.SetItem(irow,"cairline",sAirline2)
			dsCenOutPeriodFlights.SetItem(irow,"nairline_key",lAirlinekey2)
		end if
		if sUnit = "" or isnull(sUnit) then
			dsCenOutPeriodFlights.SetItem(irow,"cunit2",sUnit2)
		end if
		// TLE_20012009 Korrektur Fehler bei zus$$HEX1$$e400$$ENDHEX$$tzlich erfassten Positionen (cunit2 ist null oder 5174)
		if sUnit = "5174" and sUnit2 <> "5174" then
			dsCenOutPeriodFlights.SetItem(irow,"cunit2",sUnit2)
		end if

		if  isnull(dtDate) then
			dsCenOutPeriodFlights.SetItem(irow,"ddeparture",dtDate2)
		end if
	
	Next
	
	// -----------------------------------------------------	
	// Anpassen ZeilenDetail an Header-Info, falls leer/Null
	// -----------------------------------------------------	
	for irow = 1 to dsCenOutPeriodDetail.RowCount()
		
		iFlightNo=dsCenOutPeriodDetail.GetItemNumber(irow,"nflight_number")
		sSuffix=dsCenOutPeriodDetail.GetItemString(irow,"csuffix")
		sUnit=dsCenOutPeriodDetail.GetItemString(irow,"cunit2")
		dtDate=dsCenOutPeriodDetail.GetItemDatetime(irow,"ddeparture")
		sAirline=dsCenOutPeriodDetail.GetItemString(irow,"cairline")
		
		if isnull(iFlightNo) then
			dsCenOutPeriodDetail.SetItem(irow,"nflight_number",iFlightNo2)
		end if
		if sSuffix = "" or isnull(sSuffix) then
			dsCenOutPeriodDetail.SetItem(irow,"csuffix",sSuffix2)
		end if
		if sAirline = "" or isnull(sAirline) then
			dsCenOutPeriodDetail.SetItem(irow,"cairline",sAirline2)
		end if
		if sUnit = "" or isnull(sUnit) then
			dsCenOutPeriodDetail.SetItem(irow,"cunit2",sUnit2)
		end if
			// TLE_20012009 Korrektur Fehler bei zus$$HEX1$$e400$$ENDHEX$$tzlich erfassten Positionen (cunit2 ist null oder 5174)
		if sUnit = "5174" and sUnit2 <> "5174" then
			dsCenOutPeriodDetail.SetItem(irow,"cunit2",sUnit2)
		end if

		if  isnull(dtDate) then
			dsCenOutPeriodDetail.SetItem(irow,"ddeparture",dtDate2)
		end if
	Next
	
	dsCenOutPeriodFlights.sort()
	
	// -----------------------------------------------------	
	// Periodenereignis kann Flugnummer, Datum auf Zeilenebene haben
	// Verarbeitung je unterschiedlicher Flugnummer und Datum als 'normaler Flug'
	// -----------------------------------------------------	
	for irow = 1 to dsCenOutPeriodFlights.RowCount()
		iFlightNo=dsCenOutPeriodFlights.GetItemNumber(irow,"nflight_number")
		sSuffix=dsCenOutPeriodFlights.GetItemString(irow,"csuffix")
		sUnit=dsCenOutPeriodFlights.GetItemString(irow,"cunit2")
		dtDate=dsCenOutPeriodFlights.GetItemDatetime(irow,"ddeparture")
		sAirline=dsCenOutPeriodFlights.GetItemString(irow,"cairline")
						// TLE_20012009 Korrektur Erg$$HEX1$$e400$$ENDHEX$$nzung Bedingungen f$$HEX1$$fc00$$ENDHEX$$r NULL
		if	((iOldFlightNo	=  iFlightNo) or &
			 (isnull(iOldFlightNo) and isnull( iFlightNo))) and &
			((sOldSuffix	= sSuffix) or &
			 (isnull(sOldSuffix) and isnull(sSuffix)))		and &
			((sOldUnit = sUnit) or &
			 (isnull(sOldUnit) and isnull(sUnit)))		and &
		 	 ((dtOldDate	= dtDate) or &
			 (isnull(dtOldDate) and isnull(dtDate)))		and &
			((sOldAirline	= sAirline) or &
			 (isnull(sOldAirline) and isnull(sAirline))) then
			// wurde bereits verarbeitet
			continue
		else
			//dsCenOutPeriodFlights.Retrieve(lkey,2) 
			of_write_xml_periodic_header(lkey, irow)
		end if
		iOldFlightNo	= iFlightNo
		sOldSuffix	= sSuffix
		sOldUnit		= sUnit
		dtOldDate	= dtDate
		sOldAirline	= sAirline
			
	Next
end if
// -----------------------------------------------------
// Schreiben BillingStatus (nur bei Abrechnung)
// Flug f$$HEX1$$fc00$$ENDHEX$$r Flug
// -----------------------------------------------------	
/* If bBillingStatus = True Then									// Abrechnung
	of_write_billing_status(sLocalClient,dDepartureDate,lCustomer,sLocalUnit)
End if
*/
Return True

end function

public function long of_retrieve_currency (long al_customer, string as_unit, date ad_date);//
// of_retrieve_currency
//
// Liest die W$$HEX1$$e400$$ENDHEX$$hrung ein
//
dsCurrency.Retrieve(sClient, al_customer, as_unit, ad_date)
if dsCurrency.RowCount() > 0 then
	sCurrencyContract=dsCurrency.GetItemString(1,"sys_currencies_cshort_text")
	sCurrencyDocument=dsCurrency.GetItemString(1,"sys_currencies_cshort_text_1")
else
	sCurrencyContract = ""
	sCurrencyDocument = ""
end if

return 0

end function

public function boolean of_write_xml_periodic_header (long lkey, integer irow);// ----------------------------------------------------------------------------
//
// of_write_xml_periodic_header
//
// ----------------------------------------------------------------------------
// da jedes Periodenereignis einen Flug/Flugereignisbezug im Detail
// haben kann, wird hier je unterschiedlichem Flugereignis ein Satz
// erstellt.
// ----------------------------------------------------------------------------
Date		dDepartureDate
string	sLocalClient
long		lCustomer, lfind
string	sLocalUnit
string	sMappingUnit, sMappingClient
String sCountry
String	sTlc, sUnit, sUNit2, sClient2
String sAirlineGroup,sSupplierNo

// ----------------------------------------------------------------------------
// Kontrollsumme je Flug zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// ----------------------------------------------------------------------------
dcItemListPerFlight = 0

// ----------------------------------------------------------------------------
// Erzeugt einen XML-String
// ----------------------------------------------------------------------------
sXMLFlightString = ""
sDavinciFlightString = ""
// -----------------------------------------------------
// Retrieve 
// -----------------------------------------------------	
If dscenOutPeriod.Retrieve(lKey) = 1 Then
	sBillingAirlineCode 	= dsCenOutPeriod.Getitemstring(1,"ccustomer")
	dDepartureDate		= date(dsCenOutPeriodFlights.Getitemdatetime(irow,"ddeparture"))
	sLocalClient				= dsCenOutPeriod.Getitemstring(1,"cclient")
	lCustomer				= dsCenOutPeriod.Getitemnumber(1,"ncustomer_key")
	sLocalUnit				= dsCenOutPeriodFlights.Getitemstring(irow,"cunit2")

	if bMonalisaMode then
		// Monalisa datastores f$$HEX1$$fc00$$ENDHEX$$llen	
		of_retrieve_Rotations(lCustomer)
		of_retrieve_CalcType()
		of_retrieve_CostType(lCustomer, dDepartureDate)
		of_retrieve_PriceCalcType()
		//of_retrieve_Mop(lkey)
		//of_retrieve_Conc_ConcKit(lkey)	
		of_retrieve_RatiolistDetail(lCustomer, dDepartureDate)
		of_retrieve_unitsupplier(lCustomer)
		of_retrieve_acg_master(lCustomer)
		//of_retrieve_mop_spml(lkey, dDepartureDate)
		of_retrieve_currency(lCustomer, slocalUnit, dDepartureDate)
			
		if dsCenOutPeriod.GetitemNumber(1,"nstatus_auto_release") = 1 then
			sstatus_autorelease	= "X"
		else
			sstatus_autorelease	= ""
		end if	
		drelease_date			= Date(dsCenOutPeriod.GetitemDatetime(1,"drelease_date"))
	
	end if
	sUnit = dsCenOutPeriodFlights.GetitemString(irow,"cunit2")
	sTlc=f_get_tlc_of_unit(sUnit)
	sCountry=f_get_country_cshort_from_ctlc(sTlc)
	sAirlineGroup=of_get_airline_group(dsCenOutPeriod.Getitemstring(1,"cairline"))
	sSupplierNo=of_get_supplier_no(sUnit)

	sUnit2 = sUnit
	sClient2 = sLocalClient	
	
	of_create_xml_string("<Flight>",sNull,sNull)
	if dsClientUnitMapping.RowCount() > 0 then
		lFind = dsClientUnitMapping.Find("cunit = '" + sUnit + "' and cclient = '" + dsCenOutPeriod.Getitemstring(1,"cclient") + "'",1,dsClientUnitMapping.RowCount())
		if lFind > 0 then
			sMappingUnit = dsClientUnitMapping.GetItemString(lfind,"cexport_unit")
			sMappingClient = dsClientUnitMapping.GetItemString(lfind,"cexport_client")
			if len(trim(sMappingClient)) = 0 or  isnull(sMappingClient) then
				 of_create_xml_string("<Client>",dsCenOutPeriod.Getitemstring(1,"cclient"),"</Client>")
			else
				 of_create_xml_string("<Client>",sMappingClient,"</Client>")
				 sClient2=sMappingClient
			end if
			if len(trim(sMappingUnit)) = 0 or isnull(sMappingUnit) then
				 of_create_xml_string("<Unit>",sUnit,"</Unit>" )
			else
				 of_create_xml_string("<Unit>",sMappingUnit,"</Unit>" )
				 sUnit2 = sMappingUnit
			end if
			
		else
			of_create_xml_string("<Client>",dsCenOutPeriod.Getitemstring(1,"cclient"),"</Client>")
			of_create_xml_string("<Unit>",sUnit,"</Unit>" )
		end if
	else
		of_create_xml_string("<Client>",dsCenOutPeriod.Getitemstring(1,"cclient"),"</Client>")
		of_create_xml_string("<Unit>",sUnit,"</Unit>" )
	end if		
	if dsCenOutPeriodFlights.GetitemString(irow,"cairline") = "" then
		of_create_xml_string("<AirlineCode>",dsCenOutPeriod.Getitemstring(1,"cairline"),"</AirlineCode>")
	else
		of_create_xml_string("<AirlineCode>",dsCenOutPeriodFlights.GetitemString(irow,"cairline"),"</AirlineCode>")
	end if
	
	//of_create_xml_string("<AirlineCode>",dsCenOutPeriod.Getitemstring(1,"cairline"),"</AirlineCode>")
	of_create_xml_string("<AirlineType>",sNull,"</AirlineType>")
	of_create_xml_string("<BillingAirlineCode>",sBillingAirlineCode,"</BillingAirlineCode>")
	of_create_xml_string("<FlightPostingType>",string(iFlightPostingType),"</FlightPostingType>")
	of_create_xml_string("<BillingCode>",dsCenOutPeriod.Getitemstring(1,"caccount"),"</BillingCode>")
	of_create_xml_string("<FlightNumber>",string(dsCenOutPeriodFlights.Getitemnumber(irow,"nflight_number")),"</FlightNumber>")
	of_create_xml_string("<Suffix>",dsCenOutPeriodFlights.Getitemstring(irow,"csuffix"),"</Suffix>")
	of_create_xml_string("<Leg>",sNull,"</Leg>")
	of_create_xml_string("<Handling>",sNull,"</Handling>")
	of_create_xml_string("<DepartureDate>",string(dsCenOutPeriodFlights.Getitemdatetime(irow,"ddeparture"),"YYYY-MM-DD"),"</DepartureDate>")
	of_create_xml_string("<DepartureTime>",sNull,"</DepartureTime>")
	of_create_xml_string("<DepartureStation>",sTlc,"</DepartureStation>")
	of_create_xml_string("<ArrivalStation>",sNull,"</ArrivalStation>")
	of_create_xml_string("<TailNumber>",sNull,"</TailNumber>")
	of_create_xml_string("<AircraftOwner>",sNull,"</AircraftOwner>")
	of_create_xml_string("<AircraftType>",sNull,"</AircraftType>")
	of_create_xml_string("<SeatConfiguration>",sNull,"</SeatConfiguration>")
	of_create_xml_string("<GalleyVersion>",sNull,"</GalleyVersion>")
	of_create_xml_string("<FlightStatus>",string(dsCenOutPeriod.GetitemNumber(1,"nposting_status")),"</FlightStatus>")		
	of_create_xml_string("<Refund>",string(dsCenOutPeriod.Getitemnumber(1,"nrefund")),"</Refund>")
	of_create_xml_string("<TrafficArea>",sNull,"</TrafficArea>")
	of_create_xml_string("<DocumentNumber>",string(dscenOutPeriod.Getitemnumber(1,"nbilling_key"),"000000"),"</DocumentNumber>")
	of_create_xml_string("<BoxFrom>",sNull,"</BoxFrom>")
	of_create_xml_string("<BoxTo>",sNull,"</BoxTo>")
	of_create_xml_string("<InternalNumber>",string(lFlightCounter),"</InternalNumber>")
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
	if bMonalisaMode then
			
	 	of_create_xml_string("<AircraftGroup>",sAirlineGroup,"</AircraftGroup>")
		of_create_xml_string("<DepartureCountry>",sCountry,"</DepartureCountry>")
//		of_create_xml_string("<ArrivalCountry>",dscenOutPeriod.GetitemString(1,"ccountry_to"),"</ArrivalCountry>")
//		of_create_xml_string("<ArrivalTime>",dscenOutPeriod.GetitemString(1,"carrival_time"),"</ArrivalTime>")
//		of_create_xml_string("<ArrivalDate>",string(dscenOutPeriod.Getitemdatetime(1,"darrival_time_loc"),"YYYY-MM-DD"),"</ArrivalDate>")
		of_create_xml_string("<DepartureDateUTC>",string(dsCenOutPeriodFlights.Getitemdatetime(irow,"ddeparture"),"YYYY-MM-DD"),"</DepartureDateUTC>")
//		of_create_xml_string("<ArrivalDateUTC>",string(dscenOutPeriod.Getitemdatetime(1,"darrival_time_UTC"),"YYYY-MM-DD"),"</ArrivalDateUTC>")
		of_create_xml_string("<CateringStation>",sTLC,"</CateringStation>")
		of_create_xml_string("<AirlSupplierNr>",sSupplierNo,"</AirlSupplierNr>")
		of_create_xml_string("<TitlePeriodicEvent>",dsCenOutPeriod.GetitemString(1,"ctext"),"</TitlePeriodicEvent>")
		of_create_xml_string("<BillingPeriodFrom>",string(dsCenOutPeriod.Getitemdatetime(1,"dperiod_from"),"YYYY-MM-DD"),"</BillingPeriodFrom>")
		of_create_xml_string("<BillingPeriodTo>",string(dsCenOutPeriod.Getitemdatetime(1,"dperiod_to"),"YYYY-MM-DD"),"</BillingPeriodTo>")
		of_create_xml_string("<NResultKey>",String(lkey),"</NResultKey>")

	end if
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
	if bCreateDaVinciInterface then
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$10$$HEX2$$1c202000$$ENDHEX$$- Flugdaten		
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung

			//Satzart	numeric	2	10	Satzart Flugdaten
			of_create_davinci_string("10",2,sSeparator)
			
			//Mandant - Airline	Char	4	LH	
			of_create_davinci_string(sDavinciClient,4,sSeparator)
			
			//Mandant - Agentur	Char	4	IFMS	
			of_create_davinci_string(sDavinciAgency,4,sSeparator)
			
			//Abflugdatum Lokal	Date	8	20070831	Leistungserbringungsdatum:
			//			Flugdatum bei Flugereignissen, Belegdatum bei Periodenereignissen
			of_create_davinci_string(string(dsCenOutPeriod.Getitemdatetime(1,"dposting_date"),"YYYYMMDD"),8,sSeparator)
			//Flugger$$HEX1$$e400$$ENDHEX$$t-Gruppe	Char	2	LC/LR	
	 		of_create_davinci_string(sAirlineGroup,2,sSeparator)
			 
			//Operierende Airline	Char	3	LH	
			of_create_davinci_string(dsCenOutPeriodFlights.GetitemString(irow,"cairline"),3,sSeparator)
			//of_create_xml_string("<BillingAirlineCode>",sBillingAirlineCode,"</BillingAirlineCode>")
			
			//Flugnummer	Numeric	4	4519	
			of_create_davinci_string(string(dscenOutPeriodFlights.Getitemnumber(irow,"nflight_number")),4,sSeparator)
			
			//Flugnummer Suffix	Char	1	A	
			of_create_davinci_string(dscenOutPeriodFlights.Getitemstring(irow,"csuffix"),1,sSeparator)
			
			//Legnummer	Numeric	1	1	
			of_create_davinci_string(sNull,1,sSeparator)
			
			//AbflugLand	char	2	ES	
			of_create_davinci_string(sCountry,2,sSeparator)
			
			//AbflugStation	char	3	AGP	
			of_create_davinci_string(sTlc,3,sSeparator)
			
			//AbflugUhrzeit (Lokal)	time	4	1630	F$$HEX1$$fc00$$ENDHEX$$r 16:30
			of_create_davinci_string(sNull,4,sSeparator)
			
			//AnkunftLand	char	2	DE	
			of_create_davinci_string(sNull,2,sSeparator)
			
			//AnkunftStation	char	3	FRA	
			of_create_davinci_string(snull,3,sSeparator)
			
			//AnkunftUhrzeit (Lokal)	time	4	1935	F$$HEX1$$fc00$$ENDHEX$$r 19:35
			of_create_davinci_string(sNull,4,sSeparator)
			
			//Ankunftdatum(Lokal)	date	8	20070831	
			of_create_davinci_string(sNull,8,sSeparator)
			
			//Abflugdatum (UTC)	date	8	20070831	
			of_create_davinci_string(string(dscenOutPeriodFlights.Getitemdatetime(irow,"ddeparture"),"YYYYMMDD"),8,sSeparator)
			
			
			//Ankunftdatum(UTC)	date	8	20070831	
			of_create_davinci_string(sNull,8,sSeparator)
			
			//Eigner	char	3	LH	
			of_create_davinci_string(sNull,3,sSeparator)
			
			//Aircrafttyp	Char	3	32Y	
			of_create_davinci_string(sNull,3,sSeparator)
			
			//Galley-version	Char	2	1	
			of_create_davinci_string(sNull,2,sSeparator)
			
			//Sitzplatzversion	Char	20	80-122	
			of_create_davinci_string(sNull,20,sSeparator)
	
			//Beladeort	Char	3	AGP	
			of_create_davinci_string(sTLC,3,sSeparator)
			
			//WerkNr	Numeric	4	5115	Werksnummer aus Cbase
			of_create_davinci_string(sunit2,4,sSeparator)

			//LieferantenNr	Char	10	VERB0200	Kreditorennummer aus SAP
			of_create_davinci_string(sSupplierNo,10,sSeparator)
			
			//Belegnummer	Char	12	1234567	
			of_create_davinci_string(string(dscenOutPeriod.Getitemnumber(1,"nbilling_key")),12,sSeparator)
			
			//Titel periodisches Ereignis	Char	40	Monthly cost report standard load	
			of_create_davinci_string(dscenOutPeriod.GetitemString(1,"ctext"),40,sSeparator)
			
			//Abrechnungzeitraum-Von	Date	8	20070801	Bei periodischen Ereignissen der Zeitraum auf den sich die abgerechneten Daten beziehen
			of_create_davinci_string(string(dscenOutPeriod.Getitemdatetime(1,"dperiod_from"),"YYYYMMDD"),8,sSeparator)
			
			//Abrechnungzeitraum-Bis	Date	8	20070831	
			of_create_davinci_string(string(dscenOutPeriod.Getitemdatetime(1,"dperiod_to"),"YYYYMMDD"),8,sSeparator)
			
			//Cbase-ID	Numeric	12		Cbase-interne ID des Flugereignisses bzw. des Periodenereignisses
			of_create_davinci_string(String(lkey),12,sSeparator)
	
			//Erstellungszeitpunkt	Timestamp	18	20070831-19010105	Zeitpunkt der Schnittstellenerstellung
			of_create_davinci_string(sCreationTimestamp,18,sCarriageReturn)
			
			lcounter_type_10 ++
	end if
Else
	sErrorText = "XMl-Retrieve erzielte kein Ergebnis"
	Return False
End if
// -----------------------------------------------------
// Periodendetails f$$HEX1$$fc00$$ENDHEX$$r die XML Datei
// -----------------------------------------------------
of_write_xml_period_detail(lKey,irow)
// -----------------------------------------------------
// Flug Ende Element
// -----------------------------------------------------		
of_create_xml_string(sNull,sNull,"</Flight>" ) // 11.01.05: +CR
// -----------------------------------------------------
// Schreibt den kompletten Flug in die XML Datei
// -----------------------------------------------------	
If of_write_xml(sXMLFlightString)	= False Then
	return False
End if
	
if bCreateDaVinciInterface then
	If of_write_davinci(sDaVinciFlightString)	= False Then
		return False
	End if
End if
// -----------------------------------------------------
// Schreiben BillingStatus (nur bei Abrechnung)
// Flug f$$HEX1$$fc00$$ENDHEX$$r Flug
// -----------------------------------------------------	
If bBillingStatus = True Then									// Abrechnung
	of_write_billing_status(sLocalClient,dDepartureDate,lCustomer,sLocalUnit)
End if

Return True

end function

public function boolean of_write_xml_period_detail (long lkey, integer irow);	integer	i
	decimal	dcQuantity
	integer	iFlightNo, iFlightNo2, iFlightNoDetail
	long		lbillingStatusDetail
	string		sSuffix, sUnit, sFilter, sSuffix2, sUnit2, sAirline, sAirline2, sSuffixDetail, sUnitDetail, sAirlineDetail
	Datetime		dtDate, dtDate2, dtDateDetail
// -----------------------------------------------------
// Periodenbeladung f$$HEX1$$fc00$$ENDHEX$$r XML
// -----------------------------------------------------
	If bPeriodicDetails = False Then Return True
// -----------------------------------------------------
// Retrieve
// -----------------------------------------------------	
	iFlightNo=dsCenOutPeriodFlights.GetItemNumber(irow,"nflight_number")
	sSuffix=dsCenOutPeriodFlights.GetItemString(irow,"csuffix")
	sUnit=dsCenOutPeriodFlights.GetItemString(irow,"cunit2")
	dtDate=dsCenOutPeriodFlights.GetItemDatetime(irow,"ddeparture")
	sAirline=dsCenOutPeriodFlights.GetItemString(irow,"cairline")

	iFlightNo2=dsCenOutPeriod.GetItemNumber(1,"nflight_number")
	sSuffix2=dsCenOutPeriod.GetItemString(1,"csuffix")
	sUnit2=dsCenOutPeriod.GetItemString(1,"cunit")
	sAirline2=dsCenOutPeriod.GetItemString(1,"cairline")
	dtDate2=dsCenOutPeriod.GetItemDatetime(1,"dposting_date")
/*  TLE_20012009 Umstellung auf Bedingung statt Filter, da Filter neuen retrieve macht - Anfang - 
	if isnull(sUnit) then
		// TLE_20012009 Korrektur Fehler in Filter
		sFilter = "isnull(cunit2)"
	else
		sFilter = "cunit2 = '"+sUnit+"'"
	end if
	
	if isnull( iFlightNo) then
	// TLE_20012009 Korrektur Fehler in Filter
		sFilter += " and isnull(nflight_number)"
	else
		sFilter += " and nflight_number = "+String(iFlightNo)
	end if
	
	if isNull( sSuffix) then
		// TLE_20012009 Korrektur Fehler in Filter
		sFilter += " and isnull(csuffix)"
	else
		sFilter += " and csuffix = '"+sSuffix + "'"
	end if
	
	if isNull(dtDate) then
		// TLE_20012009 Korrektur Fehler in Filter
		sFilter += " and isnull(ddeparture)"
	else
		// TLE_20012009 Korrektur Fehler in Filter
		sFilter += " and ddeparture = datetime('"+String(dtDate)+"')"
	end if
		
	if isNull(sAirline) then
		// TLE_20012009 Korrektur Fehler in Filter
		sFilter += " and isnull(cairline)"
	else
		sFilter += " and cairline = '"+sAirline + "'"
	end if
		
	
	If bBillingStatus = True Then									// Abrechnung
	// TLE_20012009 Korrektur Filter zur$$HEX1$$fc00$$ENDHEX$$cksetzen und Blank vor Erg$$HEX1$$e400$$ENDHEX$$nzung Filter
		dsCenOutPeriodDetail.SetFilter("")
		dsCenOutPeriodDetail.Filter()
		dsCenOutPeriodDetail.SetFilter(sfilter + " and nbilling_status <> 1")
		dsCenOutPeriodDetail.Filter()
	Else	
	// TLE_20012009 Korrektur Filter zur$$HEX1$$fc00$$ENDHEX$$cksetzen und Blank vor Erg$$HEX1$$e400$$ENDHEX$$nzung Filter
		dsCenOutPeriodDetail.SetFilter("")
		dsCenOutPeriodDetail.Filter()
		dsCenOutPeriodDetail.SetFilter(sfilter + "  and nbilling_status <> 2")
		dsCenOutPeriodDetail.Filter()
	End if	
	//dsCenOutPeriodDetail.Rowcount()
	// TLE_20012009 Umstellung auf Bedingung statt Filter, da Filter neuen retrieve macht - Ende -
	*/ 
	of_create_xml_string("<AdditionalLoading>",sNull,sNull)
	For i = 1 to dsCenOutPeriodDetail.Rowcount()
  		// TLE_20012009 Umstellung auf Bedingung statt Filter, da Filter neuen retrieve macht
		iFlightNoDetail=dsCenOutPeriodDetail.GetItemNumber(i,"nflight_number")
		sSuffixDetail=dsCenOutPeriodDetail.GetItemString(i,"csuffix")
		sUnitDetail=dsCenOutPeriodDetail.GetItemString(i,"cunit2")
		dtDateDetail=dsCenOutPeriodDetail.GetItemDatetime(i,"ddeparture")
		sAirlineDetail=dsCenOutPeriodDetail.GetItemString(i,"cairline")
		lBillingStatusDetail=dsCenOutPeriodDetail.GetItemNumber(i,"nbilling_status")
		
		if	((iFlightNoDetail	=  iFlightNo) or &
			 (isnull(iFlightNoDetail) and isnull( iFlightNo))) and &
			((sSuffixDetail	= sSuffix) or &
			 (isnull(sSuffixDetail) and isnull(sSuffix)))		and &
			((sUnitDetail = sUnit) or &
			 (isnull(sUnitDetail) and isnull(sUnit)))		and &
		 	 ((dtDateDetail	= dtDate) or &
			 (isnull(dtDateDetail) and isnull(dtDate)))		and &
			((sAirlineDetail	= sAirline) or &
			 (isnull(sAirlineDetail) and isnull(sAirline)))  and &
			 ((bBillingStatus = True and lBillingStatusDetail <> 1) or &
			  (bBillingStatus = False and lBillingStatusDetail <> 2)) then
		lItemlistCounter 		+= dsCenOutPeriodDetail.GetitemDecimal(i,"nquantity")
		dcItemListPerFlight 	+= dsCenOutPeriodDetail.GetitemDecimal(i,"nquantity")
		//
		// 22.02.2005: Nur Mengen > 0 schreiben
		//
		If bBillingStatus = True and iValuesLargerZero = 1 then
			dcQuantity = dsCenOutPeriodDetail.GetitemDecimal(i,"nquantity")
			if dcQuantity = 0 then continue
		End if
		of_create_xml_string("<Item>",sNull,sNull)
		of_create_xml_string("<ItemListNumber>",dsCenOutPeriodDetail.Getitemstring(i,"cpackinglist"),"</ItemListNumber>")
		of_create_xml_string("<ItemListText>",dsCenOutPeriodDetail.Getitemstring(i,"cproduction_text"),"</ItemListText>")
		of_create_xml_string("<Quantity>",string(dsCenOutPeriodDetail.GetitemDecimal(i,"nquantity"),"0.000"),"</Quantity>")
		of_create_xml_string("<ClassName>",of_get_classname(dsCenOutPeriodDetail.Getitemstring(i,"cclass")),"</ClassName>")
		of_create_xml_string("<BillingCode>",dsCenOutPeriodDetail.Getitemstring(i,"caccount"),"</BillingCode>")	// 1
		of_create_xml_string("<PostingType>",string(dsCenOutPeriodDetail.Getitemnumber(i,"nposting_type")),"</PostingType>")
		of_create_xml_string("<AdditionalBillingCode>",dsCenOutPeriodDetail.Getitemstring(i,"cadditional_account"),"</AdditionalBillingCode>")		// 1
		if bPreferredSalesPrice then
			if dsCenOutPeriodDetail.GetitemNumber(i,"nsales_price_modified") = 1 then
				of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutPeriodDetail.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
			else
				of_create_xml_string("<PreferredSalesPrice>",sNull,"</PreferredSalesPrice>")
		
			end if
		else
			of_create_xml_string("<PreferredSalesPrice>",string(dsCenOutPeriodDetail.Getitemdecimal(i,"nsales_price"),"0.00"),"</PreferredSalesPrice>")
		end if
		//
		// 01.05.2008 F$$HEX1$$fc00$$ENDHEX$$r Monalisa Zusatzinfos an RePr$$HEX1$$fc00$$ENDHEX$$/BW schicken
		// (F$$HEX1$$fc00$$ENDHEX$$r LSG-D l$$HEX1$$e400$$ENDHEX$$uft die Schnittstelle an die Repr$$HEX1$$fc00$$ENDHEX$$/BW $$HEX1$$fc00$$ENDHEX$$ber den Host)
		//
		if bMonalisaMode then
			
			of_create_xml_string("<NDetailKey>",String(dsCenOutPeriodDetail.GetitemNumber(i,"ndetail_key")),"</NDetailKey>")
			of_create_xml_string("<ServiceLevel>",sNull,"</ServiceLevel>")
			of_create_xml_string("<ItemListUnit>",dsCenOutPeriodDetail.Getitemstring(i,"cunit"),"</ItemListUnit>")
			of_create_xml_string("<AirlCostType>",of_get_airl_cost_type(dsCenOutPeriodDetail.GetitemNumber(i,"ncosttype")),"</AirlCostType>")
			of_create_xml_string("<TaxCode>",dsCenOutPeriodDetail.Getitemstring(i,"ctaxcode"),"</TaxCode>")
			of_create_xml_string("<ReleaseDate>",String(dRelease_Date,"YYYY-MM-DD"),"</ReleaseDate>")
			of_create_xml_string("<StatusAutoBilling>",sstatus_autorelease,"</StatusAutoBilling>")
			of_create_xml_string("<BillingCategory>",of_get_billing_category(dsCenOutPeriodDetail.Getitemnumber(i,"nmanual_input"),dsCenOutPeriodDetail.Getitemnumber(i,"nsales_price_modified")),"</BillingCategory>")
			of_create_xml_string("<CbaseCostType>",of_get_cost_type_text(dsCenOutPeriodDetail.GetitemNumber(i,"ncosttype")),"</CbaseCostType>")
			of_create_xml_string("<CalcType>",of_get_calc_type_text(dsCenOutPeriodDetail.GetitemNumber(i,"ncalc_id")),"</CalcType>")
			of_create_xml_string("<RatioPercentage>",String(dsCenOutPeriodDetail.GetitemNumber(i,"npercentage")),"</RatioPercentage>")
			of_create_xml_string("<CalcValue>",String(dsCenOutPeriodDetail.GetitemNumber(i,"nvalue")),"</CalcValue>")
			of_create_xml_string("<CalcToPax>",of_get_ratiolist_topax(dsCenOutPeriodDetail.GetitemNumber(i,"ncalc_detail_key")),"</CalcToPax>")
			of_create_xml_string("<PriceCalcType>",of_get_price_calc_text(dsCenOutPeriodDetail.GetitemNumber(i,"nprice_calc_type")),"</PriceCalcType>")
			of_create_xml_string("<ConceptNumber>",sNull,"</ConceptNumber>")
			of_create_xml_string("<ConceptDescription>",sNull,"</ConceptDescription>")
			of_create_xml_string("<ConcKitNumber>",sNull,"</ConcKitNumber>")
			of_create_xml_string("<ConcKitDescription>",sNull,"</ConcKitDescription>")
			of_create_xml_string("<MopNumber>",sNull,"</MopNumber>")
			of_create_xml_string("<MopDescription>",sNull,"</MopDescription>")
			of_create_xml_string("<CycleObject>",of_get_rotation_text(dsCenOutPeriodDetail.GetitemNumber(i,"nrotation_key")),"</CycleObject>")
 			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_xml_string("<ItemListType>","03","</ItemListType>")
		
		end if 
		// -----------------------------------------------------------------------------
		// ggf. das ganze noch mal im DaVinci-Schnittstellenformat erstellen
		// -----------------------------------------------------------------------------
		if bCreateDaVinciInterface then
		
			//Belegung f$$HEX1$$fc00$$ENDHEX$$r Satzart $$HEX1$$1e20$$ENDHEX$$30$$HEX2$$1c202000$$ENDHEX$$- Abrechnungsdaten				
			//Feldname	Datentyp	L$$HEX1$$e400$$ENDHEX$$nge	Beispiel	Anmerkung 
			
			//Satzart	numeric	2	30	Satzart Abrechnungsdaten
			of_create_davinci_string("30",2,sSeparator)
			//ID	Numeric	12		Datensatz ID aus CBASE MONALISA
			of_create_davinci_string(String(dsCenOutPeriodDetail.GetitemNumber(i,"ndetail_key")),12,sSeparator)
			//Klasse 	Char	10	F	
			of_create_davinci_string(of_get_classname(dsCenOutPeriodDetail.Getitemstring(i,"cclass")),10,sSeparator)
			//Servicestufe	Char	2	5	
			of_create_davinci_string(sNull,2,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer	Char	18	5323701	
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"cpackinglist"),18,sSeparator)
			//Schl$$HEX1$$fc00$$ENDHEX$$sselnummer-Bezeichnung	Char	40	Emmentaler K$$HEX1$$e400$$ENDHEX$$se	
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"cproduction_text"),40,sSeparator)
			//Soll-Haben-Kennzeichen	Char	1	S oder H	Soll (Belastung), H (Gutschrift)
			of_create_davinci_string(of_get_posting_type(dsCenOutPeriodDetail.Getitemnumber(i,"nposting_type")),1,sSeparator)
			//Menge	numeric	12,3	13	Abgerechnete Menge
			of_create_davinci_string(of_decimal_to_string(dsCenOutPeriodDetail.GetitemDecimal(i,"nquantity"),sDavinciFormatValue3),13,sSeparator)
			//Mengeneinheit	Char	5	ST	
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"cunit"),5,sSeparator)
			//Einzelpreis	  numeric	12,5		(mit Dezimalpunkt)	in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung			
			of_create_davinci_string(of_decimal_to_string(dsCenOutPeriodDetail.Getitemdecimal(i,"nbilling_price"),sDavinciFormatValue5),13,sSeparator)
			//Gesamtpreis	numeric	14,5	27.95	(mit Dezimalpunkt)  Menge*Einzelpreis in Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(of_decimal_to_string(Round(dsCenOutPeriodDetail.Getitemdecimal(i,"nquantity") * dsCenOutPeriodDetail.Getitemdecimal(i,"nbilling_price"),4),sDavinciFormatValue5),15,sSeparator)
			//Vertragsw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Vertragsw$$HEX1$$e400$$ENDHEX$$hrung
			of_create_davinci_string(sCurrencyContract,3,sSeparator)
			//Belegw$$HEX1$$e400$$ENDHEX$$hrung	Char	3	EUR	Belegw$$HEX1$$e400$$ENDHEX$$hrung in der der Lieferant die Rechnung stellt
			of_create_davinci_string(sCurrencyDocument,3,sSeparator)
			//Airl-Kostenart	char	10	73001	Airline-Kostenart
			of_create_davinci_string(of_get_airl_cost_type(dsCenOutPeriodDetail.GetitemNumber(i,"ncosttype")),10,sSeparator)
			//Kostenstelle	Char	10	EH-Kostenstelle	Fixer Wert '94101'
			of_create_davinci_string(sCostCenter,10,sSeparator)
			//Steuerindikator	Char	2	V1	Indikator f$$HEX1$$fc00$$ENDHEX$$r Steuern und/oder Geb$$HEX1$$fc00$$ENDHEX$$hren 
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"ctaxcode"),2,sSeparator)
			//Freigabedatum	Date	8	20070831	Datum der Freigabe
			of_create_davinci_string(String(dRelease_Date,"YYYYMMDD"),8,sSeparator)
			//Automatische Freigabe	Char	1	Leer/$$HEX1$$1920$$ENDHEX$$X$$HEX3$$192009001a20$$ENDHEX$$X$$HEX1$$1920$$ENDHEX$$, falls automatische Freigabe erfolgte
			of_create_davinci_string(sstatus_autorelease,1,sSeparator)
			//Kategorie	Char	1	1	1 (Menge+Preis bekannt), 2 (Preis bekannt, Menge unbekannt),3 (Menge+Preis unbekannt)
			of_create_davinci_string(of_get_billing_category(dsCenOutPeriodDetail.Getitemnumber(i,"nmanual_input"),dsCenOutPeriodDetail.Getitemnumber(i,"nsales_price_modified")),1,sSeparator)
			//Abrechnungscode 	Char	10	2610000000	Kundennummer bei LSG-D
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"caccount"),10,sSeparator)
			//Cbase-Kostenart	char	30	Dienstleistung	Cbase-Kostenart
			of_create_davinci_string(of_get_cost_type_text(dsCenOutPeriodDetail.GetitemNumber(i,"ncosttype")),30,sSeparator)
			//Mengen-Berechnungsart	Char	40	Ratiolist I	
			of_create_davinci_string(of_get_calc_type_text(dsCenOutPeriodDetail.GetitemNumber(i,"ncalc_id")),40,sSeparator)			
			//Ratio-Prozent	Numeric	3	150	Anzahl laut Ratio beladene St$$HEX1$$fc00$$ENDHEX$$ck dieser Komponente, z.B. bei Br$$HEX1$$f600$$ENDHEX$$tchen oft 150%
			of_create_davinci_string(String(dsCenOutPeriodDetail.GetitemNumber(i,"npercentage")),3,sSeparator)
			//Berechnungswert	Numeric	10,3	1	
			of_create_davinci_string(String(dsCenOutPeriodDetail.GetitemNumber(i,"nvalue")),11,sSeparator)
			//Versionsstaffel Bis-Wert	Numeric	4	16	z.B. bei First Version 15-16
			of_create_davinci_string(of_get_ratiolist_topax(dsCenOutPeriodDetail.GetitemNumber(i,"ncalc_detail_key")),4,sSeparator)
			//Preisberechnungsart	Char	40	SPML-Durchschnittl.Mz-Preis	
			of_create_davinci_string(of_get_price_calc_text(dsCenOutPeriodDetail.GetitemNumber(i,"nprice_calc_type")),40,sSeparator)
			//Konzept-Nr	char	30	IOFHD000700	
			of_create_davinci_string(sNull,30,sSeparator)
			//Konzeptbezeichnung	char	40	LH/LR, SS 5,  breakfast 2er Auswahl	
			of_create_davinci_string(sNull,40,sSeparator)
			//Konzeptbaustein 	Char	30	IOFMC (meat)	
			of_create_davinci_string(sNull,30,sSeparator)
			//Konzeptbausteinbezeichnung	char	40	plate large starter	
			of_create_davinci_string(sNull,40,sSeparator)
			//MOP-Nr	Char	30	C-HM1033-ORD	
			of_create_davinci_string(sNull,30,sSeparator)
			//MOP-Bezeichnung	char	40	Hot Meal Pricate Air	
			of_create_davinci_string(sNull,40,sSeparator)
			//Rotationsobjekt	Char	60	2 Monate/2 Rotationen		
			of_create_davinci_string(of_get_rotation_text(dsCenOutPeriodDetail.GetitemNumber(i,"nrotation_key")),60,sSeparator)
 			//Rotation	Char	10	A	
			of_create_davinci_string(dsCenOutPeriodDetail.Getitemstring(i,"crotation"),10,sSeparator)
			// Typ der Schl$$HEX1$$fc00$$ENDHEX$$sselnummer: $$HEX1$$1e20$$ENDHEX$$01$$HEX2$$1c202000$$ENDHEX$$Mahlzeiten (MOP-/ Konzeptfelder gef$$HEX1$$fc00$$ENDHEX$$llt), $$HEX1$$1e20$$ENDHEX$$02$$HEX2$$1c202000$$ENDHEX$$Beladeliste $$HEX1$$1e20$$ENDHEX$$03$$HEX2$$1c202000$$ENDHEX$$Pauschale Kosten 
			of_create_davinci_string("03",2,sCarriageReturn)
			
			lcounter_type_30 ++
		end if
	
		of_create_xml_string(sNull,sNull,"</Item>")
		end if	
	Next
	of_create_xml_string(sNull,sNull,"</AdditionalLoading>")
	
	Return True

end function

public function long of_ml_billing_interface (long al_cust_key);//
// of_ml_billing_interface
//
// 
//




return 0

end function

public function string of_get_airline_group (string sairline);//==========================================================================================================
//
// of_get_airline_group
//
// Liefert die Airlinegruppe zur Airline
// 
//==========================================================================================================
long 	lfind
String sText

if sDavinciClient = "LH" then
	if sairline = "LH" then
  	   stext = "LC" 
	else
		stext = "LR"	
	end if
end if
return stext

end function

public function string of_replace_string (string svalue, string ssearchstring, string sreplacestring);	// -------------------------------------------------------------------
	// SUche SearchString in SValue, falls vorhanden wird es durch	
	// ein Ersatzzeichen (ReplaceString) ausgetauscht
	// -------------------------------------------------------------------
	long lstart_pos
	
	lstart_pos = Pos(sValue,sSearchString)
	
	DO WHILE lstart_pos > 0

   		// Replace old_str with new_str.

   		svalue = Replace(sValue, lstart_pos,  Len(sSearchString), sReplaceString)

		// Find the next occurrence of old_str.

	    lstart_pos = Pos(sValue,sSearchString, lstart_pos+Len(sReplaceString))

	LOOP
	return sValue
end function

on uo_generate_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_generate_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
dsCenOut											= Create uo_generate_datastore
dsCenOut.DataObject 							= "dw_xml_cen_out"
dsCenOut.SetTransObject(SQLCA)

dsCenOutHandling								= Create uo_generate_datastore
dsCenOutHandling.DataObject 				= "dw_xml_cen_out_handling"
dsCenOutHandling.SetTransObject(SQLCA)

dsCenOutPax										= Create uo_generate_datastore
dsCenOutPax.DataObject 						= "dw_xml_cen_out_pax"
dsCenOutPax.SetTransObject(SQLCA)

dsCenOutMeals									= Create uo_generate_datastore
dsCenOutMeals.DataObject 					= "dw_xml_cen_out_meals"
dsCenOutMeals.SetTransObject(SQLCA)

dsCenOutExtra									= Create uo_generate_datastore
dsCenOutExtra.DataObject 					= "dw_xml_cen_out_meals"
dsCenOutExtra.SetTransObject(SQLCA)

dsCenOutAddDelivery									= Create uo_generate_datastore
dsCenOutAddDelivery.DataObject 					= "dw_xml_cen_out_add_delivery"
dsCenOutAddDelivery.SetTransObject(SQLCA)

dsCenOutSPML									= Create uo_generate_datastore
dsCenOutSPML.DataObject 					= "dw_xml_cen_out_spml"
dsCenOutSPML.SetTransObject(SQLCA)

dsCenOutSPMLDetail							= Create uo_generate_datastore
dsCenOutSPMLDetail.DataObject 			= "dw_xml_cen_out_spml_detail"
dsCenOutSPMLDetail.SetTransObject(SQLCA)

dsClassMapping									= Create uo_generate_datastore
dsClassMapping.DataObject 					= "dw_xml_class_mapping"
dsClassMapping.SetTransObject(SQLCA)

dsBillingStatus									= Create uo_generate_datastore
dsBillingStatus.DataObject 					= "dw_sys_billing_status_xml"
dsBillingStatus.SetTransObject(SQLCA)

dsCenOutMealsAccumulator								= Create uo_generate_datastore
dsCenOutMealsAccumulator.DataObject 				= "dwr_meal_accumulator_meals"
dsCenOutMealsAccumulator.SetTransObject(SQLCA)

dsClientUnitMapping									= Create uo_generate_datastore
dsClientUnitMapping.DataObject 					= "dw_xml_client_unit_mapping"
dsClientUnitMapping.SetTransObject(SQLCA)


dsCostType												= Create uo_generate_datastore
dsCostType.DataObject 								= "dw_xml_cost_type"
dsCostType.SetTransObject(SQLCA)

dsMop													= Create uo_generate_datastore
dsMop.DataObject 									= "dw_xml_mop"
dsMop.SetTransObject(SQLCA)

dsCalcType												= Create uo_generate_datastore
dsCalcType.DataObject 								= "dw_xml_calc_type"
dsCalcType.SetTransObject(SQLCA)

dsRotations												= Create uo_generate_datastore
dsRotations.DataObject 								= "dw_xml_rotations"
dsRotations.SetTransObject(SQLCA)

dsPriceCalcType										= Create uo_generate_datastore
dsPriceCalcType.DataObject 						= "dw_xml_price_calc_type"
dsPriceCalcType.SetTransObject(SQLCA)

dsConcConcKit											= Create uo_generate_datastore
dsConcConcKit.DataObject 							= "dw_xml_conc_conckit"
dsConcConcKit.SetTransObject(SQLCA)

dsRatioListDetail										= Create uo_generate_datastore
dsRatiolistDetail.DataObject 							= "dw_xml_ratiolistdetail"
dsRatiolistDetail.SetTransObject(SQLCA)

dsUnitSupplier											= Create uo_generate_datastore
dsUnitSupplier.DataObject 							= "dw_xml_unit_supplier"
dsUnitSupplier.SetTransObject(SQLCA)

dsACGMaster											= Create uo_generate_datastore
dsACGMaster.DataObject 							= "dw_xml_acg_master"
dsACGMaster.SetTransObject(SQLCA)

dsMopSPML												= Create uo_generate_datastore
dsMopSPML.DataObject 								= "dw_xml_mop_spml"
dsMopSPML.SetTransObject(SQLCA)

dsCurrency												= Create uo_generate_datastore
dsCurrency.DataObject 								= "dw_xml_currency"
dsCurrency.SetTransObject(SQLCA)

dsCenOutPeriod										= Create uo_generate_datastore
dsCenOutPeriod.DataObject 						= "dw_xml_cen_out_period"
dsCenOutPeriod.SetTransObject(SQLCA)

dsCenOutPeriodFlights								= Create uo_generate_datastore
dsCenOutPeriodFlights.DataObject 				= "dw_xml_cen_out_period_flight"
dsCenOutPeriodFlights.SetTransObject(SQLCA)

dsCenOutPeriodDetail										= Create uo_generate_datastore
dsCenOutPeriodDetail.DataObject 						= "dw_xml_cen_out_period_detail"
dsCenOutPeriodDetail.SetTransObject(SQLCA)
	
end event

event destructor;Destroy(dsCenOut)
Destroy(dsCenOutHandling)
Destroy(dsCenOutPax)
Destroy(dsCenOutMeals)
Destroy(dsCenOutExtra)
Destroy(dsCenOutSPMLDetail)
Destroy(dsClassMapping)
Destroy(dsCenOutAddDelivery)
Destroy(dsBillingStatus)
Destroy(dsCenOutMealsAccumulator)
Destroy(dsClientUnitMapping)

Destroy(dsCostType)
Destroy(dsCalcType)
Destroy(dsPriceCalcType)
Destroy(dsRotations)
Destroy(dsMop)
Destroy(dsConcConcKit)
Destroy(dsRatiolistDetail)
Destroy(dsUnitSupplier)
Destroy(dsACGMaster)
Destroy(dsMopSPML)
Destroy(dsCurrency)
Destroy(dsCenOutPeriod)
Destroy(dsCenOutPeriodFlights)
Destroy(dsCenOutPeriodDetail)
end event

