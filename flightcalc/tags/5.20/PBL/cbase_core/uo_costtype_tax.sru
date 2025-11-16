HA$PBExportHeader$uo_costtype_tax.sru
$PBExportComments$Userobjekt zur Ermittlung der Kostenart und Steuerkennzeichen ~r~n~r~n- Preis~r~n- Abrechnungscodes~r~n- Breakdowncode~r~n- etc...
forward
global type uo_costtype_tax from nonvisualobject
end type
end forward

global type uo_costtype_tax from nonvisualobject
end type
global uo_costtype_tax uo_costtype_tax

type variables
//----------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bergabewerte
//----------------------------------------
Long			lCustomer = 0 		// Der AirlineCode
Long			lSupplier = 0 		// Der Lieferant
Datetime		dtDate				// Flugdatum

String			sUnit = "" 			// Der Betrieb
Long			lPl_Index_key  		// PL_Index_key
Long			lPl_Detail_Key 		// PL_Detail_key

String			sPackinglist			// St$$HEX1$$fc00$$ENDHEX$$cklistennummer
String 		sAccount				//Abrechnungscode

Boolean		bMopMeal			// True- Suche $$HEX1$$fc00$$ENDHEX$$ber Mahlzeitentyp (bei Meals aus MOP)
Long			lhandling_detail_key 	// Referenz auf cen_meal_details 
											// zu f$$HEX1$$fc00$$ENDHEX$$llen wenn bMopMeal = True
String			sClass				// Klasse
										// zu f$$HEX1$$fc00$$ENDHEX$$llen wenn bMopMeal = True
Integer		iLanguage			// Spracheinstellung

//----------------------------------------
//R$$HEX1$$fc00$$ENDHEX$$ckgabewerte
//----------------------------------------
Long			lCostType_Key
String			sCostType_Text
String			sCostType_Airline_Text

Long			lTaxCode_Key
String			sTaxCode_Text
String			sTaxCode_Short

//----------------------------------------
// Fehler
//----------------------------------------
String			sError					= ""
Integer		iError					= 0
//----------------------------------------
// Datastores
//----------------------------------------
DataStore	dsCostType
DataStore	dsCostTypeAirl
DataStore	dsCostTypeTax
DataStore	dsAccountCostType
DataStore	dsMealTypeCostType
DataStore	dsTaxCodes
DataStore	dsSupplierTaxCode



Private:
Long 			lOldCustomer
Long 			lOldSupplier
Datetime		dtOldDate



end variables

forward prototypes
public function integer of_cost_type ()
public function integer of_retrieve_ds ()
public function integer of_taxcode ()
public function integer of_get_taxcode_text ()
public function integer of_get_costtype_text ()
public function integer of_get_airl_costtype ()
end prototypes

public function integer of_cost_type ();// --------------------------------------------------
// Ermittlung der Kostenart
// --------------------------------------------------
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- bMopMeal					True: Zugriff $$HEX1$$fc00$$ENDHEX$$ber Meals
//				- lhandling_detail_key 	Ref auf Cen_Meal_Detail
//				- sClass						Klasse
// 				- saccount					Abrechnungsart
//				- sPackinglist				St$$HEX1$$fc00$$ENDHEX$$cklistennummer
//				- lPl_Index_Key				Key Packinglistindex
//				- lPl_Detail_Key				Key Packinglists-G$$HEX1$$fc00$$ENDHEX$$ltigkeit
//				- sUnit						Betrieb
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- lSupplier					Lieferant
//				- ilanguage 					Spracheinstellung
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- lCostType_Key     		Key der Kostenart
//				- sCostType_Text			Bezeichnung Kostenart
//				- sCostType_Airline_Text Bezeichnung Airline-Kostenart
//				- lTaxCode_Key				Key des Steuerkennzeichens
//				- sTaxCode_Short			Kurzcode des Steuerkennzeichens
//				- sTaxCode_Text			Bezeichnung des Steuerkennzeichens
// --------------------------------------------------
Long lfound
Long lMealType_key

lCostType_Key = 0
sCostType_Text = ""
sCostType_Airline_Text = ""

sError					= ""
iError					= 0
// --------------------------------------------------
// Einlesen datastores
// --------------------------------------------------
this.of_retrieve_ds()

//---------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r Mahlzeitendefinionen $$HEX1$$fc00$$ENDHEX$$ber MOP erfolgt die
// Zuordnung der Kostenart $$HEX1$$fc00$$ENDHEX$$ber dsMealTypeCostType
// (mit Hilfe des Mahlzeitentyps aus dem Konzeptbaustein)
//---------------------------------------------------------

if bMopMeal then
	// Ermittle Konzeptbaustein-MahlzeitenTyp zu Detail-Position aus Cen_meals_detail 
	//			( in cen_out_meals als Referenz enthalten)
	
	Select 	nmealtype_key
	  into 		:lmealType_key 
	from 		cen_conc_detail
	where 	cen_conc_detail.nconc_detail_key in 
		(select nconc_detail_key from cen_mop_detail 
			where cen_mop_detail.nmop_detail_key in
				(Select 	nmop_detail_key from cen_meals_detail
				where 	cen_meals_detail.nhandling_detail_key = :lhandling_detail_key)
		);
	if sqlca.sqlcode <> 0 then
		sError += " CostType: " + sqlca.sqlerrtext + "~r~r"
		iError = 1
	else  							// Suche mit Mahlzeitentype und Klasse
		lfound=dsMealTypeCostType.Find("cen_mealtype_costtype_nmealtype_key = " + String(lmealtype_key) + " and cen_mealtype_costtype_cclass = '" + &
										      sclass + "'" , 1, dsMealTypeCostType.RowCount())
		if lfound = 0 then		// nicht gefunden, Suche mit leerer Klasse							
			lfound=dsMealTypeCostType.Find("cen_mealtype_costtype_nmealtype_key = " + String(lmealtype_key) + " and (cen_mealtype_costtype_cclass = '' " + &
												" or cen_mealtype_costtype_cclass = '*' or cen_mealtype_costtype_cclass is Null", 1, dsMealTypeCostType.RowCount())
		end if

		if lfound > 0 then   	// Eintrag gefunden
			 lCostType_key = dsMealTypeCostType.getItemNumber(lfound, "cen_mealtype_costtype_ncost_type_key")
		end if
	end if
end if

//---------------------------------------------------------
// Kostenart h$$HEX1$$e400$$ENDHEX$$ngt evtl. an der St$$HEX1$$fc00$$ENDHEX$$ckliste
//---------------------------------------------------------
if lfound = 0 then
	
	Select 	ncost_type_key 
	  into 		:lCostType_key
	  
	from 		cen_packinglists
	
	where 	cen_packinglists.npackinglist_index_key = :lPl_Index_Key 
	and 		cen_packinglists.npackinglist_detail_key = :lPl_Detail_Key ;
	
	if sqlca.sqlcode <> 0 then
		sError += " CostType PL: " + sqlca.sqlerrtext + "~r~r"
		iError = 1
	else	
		if isnull(lCostType_key) or lCostType_key = 0 then
			lfound = 0
		else
			lfound = 1
		end if
	end if
	
end if

if lfound = 0 then
//---------------------------------------------------------
// Zuordnung der Kostenart $$HEX1$$fc00$$ENDHEX$$ber dsAccountCostType
// (mit Hilfe des Abrechnungscodes)
//---------------------------------------------------------
	if not isnull(sAccount) and sAccount <> "" then
		String sFind
		sFind="'" + saccount + "' between caccount_from and caccount_to and '" + &
											      spackinglist + "' between cpl_from and cpl_to and cunit = '" + sunit + &
												 "'"
		lfound=dsAccountCostType.Find(sFind, 1, dsAccountCostType.RowCount())
		if lfound = 0 then   // Eintrag nicht gefunden, zweiter Versuch mit Werk = ""
			sFind="'" + saccount + "' between caccount_from and caccount_to and '" + &
											      spackinglist + "' between cpl_from and cpl_to and (cunit = '' or isnull(cunit)) "
			lfound=dsAccountCostType.Find(sFind, 1, dsAccountCostType.RowCount())
		end if
		if lfound > 0 then   // Eintrag gefunden
	 		 lCostType_key = dsAccountCostType.getItemNumber(lfound, "ncost_type_key")
		end if
	end if
end if

	
if lfound > 0 then
 		//---------------------------------------------------------
		// Bezeichnung zu lCostType_key ermitteln
		//---------------------------------------------------------
  	of_get_costtype_text()
 		//---------------------------------------------------------
		// Airline-Kostenart zu lCostType_key ermitteln
		//---------------------------------------------------------
	of_get_airl_costtype()
		//---------------------------------------------------------
		// Taxcode-Felder zu lCostType_key ermitteln
		//---------------------------------------------------------
	of_taxcode()
	return 0
end if

return -1
end function

public function integer of_retrieve_ds ();// --------------------------------------------------
// Datastores f$$HEX1$$fc00$$ENDHEX$$llen
// --------------------------------------------------
Integer I

if 	lOldCustomer 	=  lCustomer and &
	lOldSupplier 	=  lSupplier and &
	dtOlddate 		=  dtDate then
	// datastores sind bereits f$$HEX1$$fc00$$ENDHEX$$r die Werte bef$$HEX1$$fc00$$ENDHEX$$llt
	return 0
else
	i=dsCostType.Retrieve(lCustomer, dtDate)
	i=dsCostTypeAirl.Retrieve(lCustomer, dtDate)
	i=dsCostTypeTax.Retrieve(lCustomer, dtDate)
	i=dsAccountCostType.Retrieve(lCustomer, dtDate)
	i=dsMealTypeCostType.Retrieve(lCustomer, dtDate)
	i=dsTaxCodes.Retrieve(lCustomer, dtDate)
	i=dsSupplierTaxCode.Retrieve(lCustomer, dtDate, lSupplier)
end if

lOldCustomer 	=  lCustomer 
lOldSupplier 	=  lSupplier
dtOlddate 		=  dtDate

return 0
end function

public function integer of_taxcode ();// --------------------------------------------------
// Ermittlung des TaxCodes zu lCostType_key
//
// Zuordnung an Lieferantenstamm zu Betrieb/Lieferant
// $$HEX1$$fc00$$ENDHEX$$bersteuert Zuordnung an Kostenart
// --------------------------------------------------
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- lCostType_key 			Key der Kostenart
//				- sUnit						Betrieb
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- lSupplier					Lieferant
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- lTaxCode_Key				Key des Steuerkennzeichens
//				- sTaxCode_Short			Kurzcode des Steuerkennzeichens
//				- sTaxCode_Text			Bezeichnung des Steuerkennzeichens
// --------------------------------------------------
Long lfound

sTaxCode_Text = ""
sTaxCode_Short = ""
lTaxCode_Key = 0
// --------------------------------------------------
// Einlesen datastores
// --------------------------------------------------
this.of_retrieve_ds()

if lfound = 0 then
//---------------------------------------------------------
// Zuordnung der Taxcode $$HEX1$$fc00$$ENDHEX$$ber dsSupplierTaxCode
//---------------------------------------------------------
		lfound=dsSupplierTaxCode.Find("cen_supp_unit_tax_ncost_type_key = " + String(lCostType_key) + &
											      " and cen_supplier_units_cunit = '" + sunit + "'", 1, dsSupplierTaxCode.RowCount())
		if lfound = 0 then   // Eintrag nicht gefunden, zweiter Versuch auf Lieferant
			lfound=dsSupplierTaxCode.Find("cen_supp_unit_tax_ncost_type_key = " + String(lCostType_key) + &
											      " and cen_supplier_units_nis_supplier = 1", 1, dsSupplierTaxCode.RowCount())
		end if
		if lfound > 0 then   // Eintrag gefunden
	 		 lTaxCode_key = dsSupplierTaxCode.getItemNumber(lfound, "cen_supp_unit_tax_ntaxc_key")
		end if

end if

if lfound = 0 then
//---------------------------------------------------------
// Zuordnung der Taxcode $$HEX1$$fc00$$ENDHEX$$ber dsCostTypeTax
//---------------------------------------------------------
		lfound=dsCostTypeTax.Find("cen_cost_type_tax_ncost_type_key = " + String(lCostType_key), &
										1,dsCostTypeTax.RowCount())
		if lfound > 0 then   // Eintrag gefunden
	 		 lTaxCode_key = dsCostTypeTax.getItemNumber(lfound, "cen_cost_type_tax_ntaxc_key")
		end if
end if

if lfound > 0 then
	// Ermittle Texte to TaxCode_key
	of_get_taxcode_text()
	
  	return 0
	
else
	return -1
end if


end function

public function integer of_get_taxcode_text ();// --------------------------------------------------
// Ermittlung des TaxCodes Bezeichnungen
//
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- lTaxCode					Key des Steuerkennzeichens
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- lSupplier					Lieferant
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- sTaxCode_Short			Kurzcode des Steuerkennzeichens
//				- sTaxCode_Text			Bezeichnung des Steuerkennzeichens
// --------------------------------------------------
Long lfound

sTaxCode_Text = ""
sTaxCode_Short = ""
// --------------------------------------------------
// Einlesen datastores
// --------------------------------------------------
this.of_retrieve_ds()

lfound = dsTaxCodes.Find("ntaxc_key = " + String(lTaxCode_Key), 1, dsTaxCodes.RowCount() )
	
if lfound > 0 then
		sTaxCode_text 		= dsTaxCodes.GetItemString(lfound, "ctext")
		sTaxCode_short 	= dsTaxCodes.GetItemString(lfound, "cshort")
		return 0
end if

return -1



end function

public function integer of_get_costtype_text ();// --------------------------------------------------
// Ermittlung des CostType Bezeichnungen
//
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- lCostType_key 			Key der Kostenart
//				- ilanguage 					Spracheinstellung
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- lSupplier					Lieferant
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- sCostType_Text			Bezeichnung der Kostenart
// --------------------------------------------------
Long lfound
// --------------------------------------------------
// Einlesen datastores
// --------------------------------------------------
this.of_retrieve_ds()

sCostType_Text = ""


lfound = dsCostType.Find("ncost_type_key = " + String(lCostType_Key), 1, dsCostType.RowCount() )
	
if lfound > 0 then
	
	if  this.ilanguage = 1 then
			sCostType_Text 		= dsCostType.GetItemString(lfound, "ctext")
	elseif  this.ilanguage = 2 then
			sCostType_Text 		= dsCostType.GetItemString(lfound, "ctext2")
	elseif this.ilanguage = 3 then
			sCostType_Text 		= dsCostType.GetItemString(lfound, "ctext3")
	elseif  this.ilanguage = 4 then
			sCostType_Text 		= dsCostType.GetItemString(lfound, "ctext4")
	elseif this.ilanguage = 5 then
			sCostType_Text 		= dsCostType.GetItemString(lfound, "ctext5")
	end if			
	
	return 0
end if

return -1



end function

public function integer of_get_airl_costtype ();// --------------------------------------------------
// Ermittlung der Airline Kostenart
//
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- lCostType_key 			Key der Kostenart
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- lSupplier					Lieferant
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- sCostType_Airline_Text		Bezeichnung der Airline-Kostenart
// --------------------------------------------------
Long lfound
// --------------------------------------------------
// Einlesen datastores
// --------------------------------------------------
this.of_retrieve_ds()

sCostType_Airline_Text = ""


lfound = dsCostTypeAirl.Find("cen_cost_type_airl_ncost_type_key = " + String(lCostType_Key), 1, dsCostTypeAirl.RowCount() )
	
if lfound > 0 then
	
	sCostType_Airline_Text 		= dsCostTypeAirl.GetItemString(lfound, "cen_cost_type_airl_ccost_type_cust")
	return 0
	
end if

return -1



end function

on uo_costtype_tax.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_costtype_tax.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsCostType = create datastore
dsCostType.dataobject = "dw_uo_costtype_tax_costtype"
dsCostType.Settransobject(sqlca)


dsCostTypeAirl = create datastore
dsCostTypeAirl.dataobject = "dw_uo_costtype_tax_airl_costtype"
dsCostTypeAirl.Settransobject(sqlca)


dsCostTypeTax= create datastore
dsCostTypeTax.dataobject = "dw_uo_costtype_tax_costtype_tax"
dsCostTypeTax.Settransobject(sqlca)

dsAccountCostType = create datastore
dsAccountCostType.dataobject = "dw_uo_costtype_account"
dsAccountCostType.Settransobject(sqlca)

dsMealTypeCostType  = create datastore
dsMealTypeCostType.dataobject = "dw_uo_costtype_tax_mealtype"
dsMealTypeCostType.Settransobject(sqlca)

dsTaxCodes = create datastore
dsTaxCodes.dataobject = "dw_uo_costtype_tax_tax"
dsTaxCodes.Settransobject(sqlca)

dsSupplierTaxCode = create datastore
dsSupplierTaxCode.dataobject = "dw_uo_costtype_tax_suppl_tax"
dsSupplierTaxCode.Settransobject(sqlca)

end event

event destructor;destroy dsCostType
destroy dsCostTypeAirl
destroy dsAccountCostType
destroy dsCostTypeTax

destroy dsMealTypeCostType
destroy dsTaxCodes
destroy dsSupplierTaxCode

end event

