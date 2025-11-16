HA$PBExportHeader$uo_container_equipment_report.sru
forward
global type uo_container_equipment_report from nonvisualobject
end type
end forward

global type uo_container_equipment_report from nonvisualobject autoinstantiate
end type

type variables


/* 
* 
* genutzte DWs:
* ========================================
*  	dw_container_sheet							(lokales external; druck-layout container)
*  	dw_equipment_sheet							(lokales external; druck-layout equipment)
*  	dw_equipment_sheet_data					(lokales tab mit db_anbindung; lesen artikel pro flug/st$$HEX1$$fc00$$ENDHEX$$ckliste)
*  	dw_equipment_sheet_data_add			(lokales tab mit db_anbindung; lesen MS0-, MS1-st$$HEX1$$fc00$$ENDHEX$$cklisten pro flug aus cen_out_master)
* ----------------------------------------------------------------------
* 
* 
* ----------------------------------------------------------------------
* instanz-daten:
* -----------
* 
* dw_invoice_catering_order 					zum holen der deliverynote-number
* 														(ids_Deliverynotes)
* dw_airline_classnames 						klassen-stammdaten (f$$HEX1$$fc00$$ENDHEX$$r den Langtext)
* 														(ids_Classes)
* dw_airlines_equipment 						container-stammdaten (f$$HEX1$$fc00$$ENDHEX$$r den Langnamen)
* 														(ids_Equipment)
* ----------------------------------------------------------------------
* 
* 
* ----------------------------------------------------------------------
* setup-daten f$$HEX1$$fc00$$ENDHEX$$r container:
* werden direkt im constructor geholt
* -----------
* Key f$$HEX1$$fc00$$ENDHEX$$r Beverage (Beverage kommt an andere Position im Report)
* 	"PL-Type", "BeverageKey", "-1"
* 
* Container (nur diese sollen angezeigt werden) 
* 	"Equip-Report", "Container", "CA9, CA, HC, SC, OV, OV7, WT, WH, IB, IC, IC9"
* 		es wird nix angezeigt, wenn sie leer bleiben
* 		es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin ist
* 
* ----------------------------------------------------------------------
* setup-daten f$$HEX1$$fc00$$ENDHEX$$r equipment:
* werden direkt im constructor geholt
* -----------
* MaterialGruppe(n) (nur Artikel mit dieser Gruppe sollen angezeigt werden)
* 	"Equip-Report", "MaterialGroup", "-1"
* 		es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn sie leer bleiben
* 		es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin ist
* 
* ProductGruppe(n) (nur Artikel mit dieser Gruppe sollen angezeigt werden)
* 	"Equip-Report", "ProductGroup", "-1"
* 		es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn sie leer bleiben
* 		es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin ist
* 
* Druckseitenh$$HEX1$$f600$$ENDHEX$$he in Pixel (es muss die maximale Anzahl Zeilen pro Seite bestimmt werden)
* "Equip-Report", "SizeHeight", 1123
* 		notwendig, damit die maximale Anzahl Zeilen pro Seite bestimmt werden kann
* 		es wird immer auf eine komplette Seite mit Leerzeilen aufgef$$HEX1$$fc00$$ENDHEX$$llt, damit das Raster gedruckt wird
* 
* ========================================
* 
*/





protected:

// die daten zum flug
Datastore 		ids_CenOut
// die daten zur beladung
Datastore		ids_Loading
// alle legs zum flug
Long 	il_ResultKeys[]

// klassen zur airline
Datastore 		ids_Classes
// container/equipment zur airline
Datastore 		ids_Equipment
// lieferscheine zum flug
Datastore 		ids_Deliverynotes

// ----------------------------------------------------------------------
// datei-z$$HEX1$$e400$$ENDHEX$$hler
Long 	il_FileCounter
// datei-namen pro detail-report (container, equipment)
String is_ReportFiles[]
// damit unterschieden werden kann ob trace (files mit header CBASE werden beim beenden automatisch gel$$HEX1$$f600$$ENDHEX$$scht)
String is_File_Header = "CBASE"

// ----------------------------------------------------------------------
// header-daten (damit sie nur einmal geholt werden m$$HEX1$$fc00$$ENDHEX$$ssen)
Long 		il_DeliverynoteNo
String 	is_Airline 			// 6
String 	is_AirlineText 		// 40
Long 		il_FlightNumber
String 	is_FlightNumbers	// ??
Date 		id_Departure
String 	is_DepartureTime 	// 5
String 	is_TLC_from 		// 3
String 	is_Configuration 	// 20
String 	is_ACType 			// 10
String 	is_AirlineOwner 	// 6
String 	is_Classes[] 		// 12
String 	is_Classes_Text[] 	// 40

//String 	is_Class 			// 12
//String 	is_Class_Text 	// 40


// ----------------------------------------------------------------------
// Key f$$HEX1$$fc00$$ENDHEX$$r Beverage (aus setup)
Long 	il_BeverageKey = -1

// Key(s) f$$HEX1$$fc00$$ENDHEX$$r Equipment (aus setup)
// es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn sie leer bleiben
// es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin ist
Long 	il_ProductGroupKeys[]
Long 	il_MaterialGroupKeys[]

// Units, die als Container gelistet werden sollen (aus setup)
// es wird nix angezeigt, wenn sie leer bleiben
// es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin ist
String 	is_ContainerUnits[]

// seitenh$$HEX1$$f600$$ENDHEX$$he (Pixel!) aus setup f$$HEX1$$fc00$$ENDHEX$$r Euqipment-Report: dort muss die maximale Anzahl Zeilen berechnet werden
Long 	il_PageHeight = 1123

// ----------------------------------------------------------------------
// trace-schalter (wird aus Handle(getapplication) im constructor bestimmt)
boolean 	ib_Trace = false

end variables

forward prototypes
protected function long of_create_container_report ()
protected function long of_create_equipment_report ()
public function long of_start (ref string as_pdffiles[])
protected function long of_check_init ()
protected function long of_set_header_data ()
protected function string of_set_unit_description (string as_unit)
public function long of_init (datastore ads_cenout, datastore ads_loading, long al_resultkeys[])
protected function boolean of_check_productgroup (long al_productgroupkey)
protected function integer of_create_acrobat (ref datastore ads_acrobat, string as_filename)
protected function boolean of_check_materialgroup (long al_materialgroupkey)
protected function boolean of_check_containerunit (string as_containerunit)
protected function string of_checknull (string as_string2check)
protected function long of_checknull (long al_long2check)
protected function long of_fillup_equipment (datastore ads_datastore)
end prototypes

protected function long of_create_container_report ();
/* 
* Funktion:			of_create_container_report
* Beschreibung: 	report container bauen aus ids_Loading, Primary-Buffer
* Besonderheit: 	ids_Loading ist gefiltert, hier keinesfalls $$HEX1$$e400$$ENDHEX$$ndern!!
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		10.07.2012		Filter auf ausgew$$HEX1$$e400$$ENDHEX$$hlte container rein
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		19.07.2012		Klassen-instance ge$$HEX1$$e400$$ENDHEX$$ndert
*	1.3 			O.H$$HEX1$$f600$$ENDHEX$$fer		16.08.2012		Translate DS vor create PDF
*
* Return Codes:
* 	0		immer
*/



// hilfsvariable
Long 		ll_Ret
Long 		ll_Row, ll_NewRow

// hilfsvariable datenpuffer
String 	ls_Unit, ls_UnitDescription
String 	ls_Class, ls_Classname

// hilfsvariable layout-DS
datastore 	lds_Datastore

// ----------------------------------------
// layout-DS vorbereiten
// ----------------------------------------
lds_Datastore = create datastore
lds_Datastore.dataobject = "dw_container_sheet"

// ----------------------------------------
// headerdaten initialisieren
// ----------------------------------------
for ll_Row = 1 to Upperbound(this.is_Classes) step 1
	if ll_Row = 1 then
		ls_Class =  this.is_Classes[ll_Row]
		ls_Classname = this.is_Classes_Text[ll_Row]
	else
		ls_Class +=  "," + this.is_Classes[ll_Row]
		ls_Classname += "," + this.is_Classes_Text[ll_Row]
	end if
next

// ----------------------------------------
// alle s$$HEX1$$e400$$ENDHEX$$tze $$HEX1$$fc00$$ENDHEX$$bertragen
// ----------------------------------------
for ll_Row = 1 to this.ids_Loading.Rowcount() step 1
		// aussortieren, was nicht rein soll
		if not of_check_containerunit(this.of_checknull(this.ids_Loading.GetItemString(ll_Row, "cen_packinglists_cunit"))) then continue
	
		ll_NewRow = lds_Datastore.InsertRow(0)
		// header
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nnumber", this.il_DeliverynoteNo)
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cairline", this.is_Airline)  // 6
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cairline_text", this.is_AirlineText)  // 40
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nflight_number", this.il_FlightNumber)
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cflight_numbers", this.is_FlightNumbers)  // 6
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "ddeparture_date", this.id_Departure)
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cdeparture_time", this.is_DepartureTime)  // 5
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "ctlc_from", this.is_TLC_from)  // 3
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cconfiguration", this.is_Configuration)  // 20
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cactype", this.is_ACType)  // 10
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cclass", ls_Class) // 12
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cclass_description", ls_Classname) // 30
		// zeile: container
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cunit", this.ids_Loading.GetItemString(ll_Row, "cen_packinglists_cunit")) // 5
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cunit_text", this.ids_Loading.GetItemString(ll_Row, "cen_packinglists_cunit")) // 40
		// zeile: stauort
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cgalley", this.ids_Loading.GetItemString(ll_Row, "cen_galley_cgalley")) // 5
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cstowage", this.ids_Loading.GetItemString(ll_Row, "cen_stowage_cstowage"))  // 5
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cplace", this.ids_Loading.GetItemString(ll_Row, "cen_stowage_cplace"))  // 3
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nsort_stowage", this.ids_Loading.GetItemNumber(ll_Row, "cen_stowage_nsort"))
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nsort_galley", this.ids_Loading.GetItemNumber(ll_Row, "cen_galley_nsort"))
		// zeile: menge
		ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nquantity", this.ids_Loading.GetItemNumber(ll_Row, "cen_loadinglists_nquantity"))
		// zeile: entscheidung, in welche column der container soll
		if this.ids_Loading.GetItemNumber(ll_Row, "cen_packinglists_npackinglist_key") = this.il_BeverageKey then
			ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nsort", 0)
		else
			ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nsort", 1)
		end if
next

// ----------------------------------------
// die s$$HEX1$$e400$$ENDHEX$$tze passend sortieren
// ----------------------------------------
ll_Ret = lds_Datastore.SetSort("cunit")
ll_Ret = lds_Datastore.Sort()

// ----------------------------------------
// die s$$HEX1$$e400$$ENDHEX$$tze erg$$HEX1$$e400$$ENDHEX$$nzen
// ----------------------------------------
for ll_Row = 1 to lds_Datastore.Rowcount() step 1
	if ls_Unit <> lds_Datastore.GetItemString(ll_Row, "cunit") then
		ls_Unit = lds_Datastore.GetItemString(ll_Row, "cunit")
		ls_UnitDescription = of_set_unit_description(ls_Unit)
	end if
	ll_Ret = lds_Datastore.SetItem(ll_Row, "cunit_text", ls_UnitDescription)
next

// ----------------------------------------
// die s$$HEX1$$e400$$ENDHEX$$tze endg$$HEX1$$fc00$$ENDHEX$$ltig sortieren
// ----------------------------------------
ll_Ret = lds_Datastore.SetSort("cunit_text, cunit, nsort_galley, nsort_stowage")
ll_Ret = lds_Datastore.Sort()
ll_Ret = lds_Datastore.GroupCalc()

/// *****************************
uf.translate_datastore(lds_Datastore )

// ----------------------------------------
// PDF erstellen
// ----------------------------------------
if lds_Datastore.RowCount() > 0 then
		if this.ib_Trace then
			lds_Datastore.saveas(f_gettemppath() + "ContainerEquipment_ldsDatastore_" + string(this.is_Classes[1]) + '_' + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + '_' + String(now(), "hhmmss") + ".XLS", excel5!, True)
		end if
		this.is_ReportFiles[1] = f_gettemppath() + this.is_File_Header + "-Container-" + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
		ll_Ret = this.of_create_acrobat(lds_Datastore, this.is_ReportFiles[1])
		if ll_Ret = -1 then
//			lb_ErrorOnAcrobat = true
			if this.ib_Trace then
				f_trace("of_create_container_report lb_Error_on_Acrobat")
			end if
		end if
else
	ll_Ret = 0
end if

// ----------------------------------------
// aufr$$HEX1$$e400$$ENDHEX$$umen
// ----------------------------------------
if IsValid(lds_Datastore) then destroy(lds_Datastore)

return ll_Ret

end function

protected function long of_create_equipment_report ();
/* 
* Funktion:			of_create_equipment_report
* Beschreibung: 	report equipment bauen aus ids_Loading, Primary-Buffer
* Besonderheit: 	ids_Loading ist gefiltert, hier keinesfalls $$HEX1$$e400$$ENDHEX$$ndern!!
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		10.05.2012		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		05.06.2012		Materialgroup rein
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		14.06.2012		MS0-, MS1-st$$HEX1$$fc00$$ENDHEX$$cklisten mit rein
*	1.3 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		04.07.2012		MS0-, MS1-st$$HEX1$$fc00$$ENDHEX$$cklisten f$$HEX1$$fc00$$ENDHEX$$r alle Fl$$HEX1$$fc00$$ENDHEX$$ge betrachten
*	1.4 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.07.2012		of_fillup_equipment eingef$$HEX1$$fc00$$ENDHEX$$gt
*	1.5 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		19.07.2012		Klassen-instance ge$$HEX1$$e400$$ENDHEX$$ndert
*	1.6 			O.H$$HEX1$$f600$$ENDHEX$$fer		16.08.2012		Translate DS vor create PDF
*
* Return Codes:
* 	0		immer
*/


// allgemeine hilfsvariable
Long 		ll_Ret, ll_Find
Long 		ll_Row, ll_NewRow, ll_RowArtikel, ll_RowClass

// hilfsvariable datenpuffer schleifen
Long 	ll_Index
Long 	ll_IndexKeys[], ll_DetailKeys[], ll_ResultKeys[]
String 	ls_Classes[]

// hilfsvariable datenpuffer
String 	ls_Unit, ls_UnitDescription
String 	ls_Class, ls_Classname

// hilfsvariable layout-DS
datastore 	lds_Datastore
// hilfsvariable zus$$HEX1$$e400$$ENDHEX$$tzliche daten
datastore 	lds_Artikel, lds_Trays

// ----------------------------------------
// layout-DS vorbereiten
// ----------------------------------------
lds_Datastore = create datastore
lds_Datastore.dataobject = "dw_equipment_sheet"
// ----------------------------------------
// hilfs-DS artikel pro st$$HEX1$$fc00$$ENDHEX$$ckliste/flug vorbereiten
// ----------------------------------------
lds_Artikel = create datastore
lds_Artikel.dataobject = "dw_equipment_sheet_data"
lds_Artikel.SetTransObject(sqlca)
// ----------------------------------------
// hilfs-DS MS0-, MS1-st$$HEX1$$fc00$$ENDHEX$$cklisten pro flug vorbereiten
// ----------------------------------------
lds_Trays = create datastore
lds_Trays.dataobject = "dw_equipment_sheet_add_data"
lds_Trays.SetTransObject(sqlca)

// ----------------------------------------
// headerdaten initialisieren
// ----------------------------------------
for ll_Row = 1 to Upperbound(this.is_Classes) step 1
	if ll_Row = 1 then
		ls_Class =  this.is_Classes[ll_Row]
		ls_Classname = this.is_Classes_Text[ll_Row]
	else
		ls_Class +=  "," + this.is_Classes[ll_Row]
		ls_Classname += "," + this.is_Classes_Text[ll_Row]
	end if
next

// ----------------------------------------
// daten aufbereiten
// ----------------------------------------

// die st$$HEX1$$fc00$$ENDHEX$$cklisten aus loading rausholen (ist bereits sortiert)
for ll_Row = 1 to this.ids_Loading.Rowcount() step 1
	if this.ids_Loading.GetItemNumber(ll_Row, "cen_packinglist_index_npackinglist_index_key") <> ll_index then
		ll_index = this.ids_Loading.GetItemNumber(ll_Row, "cen_packinglist_index_npackinglist_index_key")
		ll_IndexKeys[Upperbound(ll_IndexKeys) + 1] = ll_index
		ll_DetailKeys[Upperbound(ll_IndexKeys)] =  this.ids_Loading.GetItemNumber(ll_Row, "cen_packinglists_npackinglist_detail_key")
		ll_ResultKeys[Upperbound(ll_IndexKeys)] = this.il_ResultKeys[1]
		ls_Classes[Upperbound(ll_IndexKeys)] =  this.ids_Loading.GetItemString(ll_Row, "cen_loadinglists_cclass")
	end if
next

// die MS0-, MS1-st$$HEX1$$fc00$$ENDHEX$$cklisten dazu
for ll_Find = 1 to Upperbound(this.il_ResultKeys) step 1
	if Upperbound(this.is_Classes) > 0 then
		for ll_RowClass = 1 to Upperbound(this.is_Classes) step 1
			ll_Ret = lds_Trays.retrieve(this.il_ResultKeys[ll_Find], this.is_Classes[ll_RowClass])
			for ll_Row = 1 to lds_Trays.Rowcount() step 1
				ll_IndexKeys[Upperbound(ll_IndexKeys) + 1] = lds_Trays.GetItemNumber(ll_Row, "cen_out_master_npl_index_key")
				ll_DetailKeys[Upperbound(ll_IndexKeys)] =  lds_Trays.GetItemNumber(ll_Row, "cen_out_master_npl_detail_key")
				ll_ResultKeys[Upperbound(ll_IndexKeys)] = this.il_ResultKeys[ll_Find]
				ls_Classes[Upperbound(ll_IndexKeys)] =  this.is_Classes[ll_RowClass]
			next
		next
	end if
next

if this.ib_Trace then
	lds_Trays.saveas(f_gettemppath() + "ContainerEquipment_ldsTrays_" + string(this.is_Classes[1]) + '_' + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + '_' + String(now(), "hhmmss") + ".XLS", excel5!, True)
end if

// ----------------------------------------
// pro st$$HEX1$$fc00$$ENDHEX$$ckliste die artikel holen:
// ----------------------------------------
// wenn nach product_group wie vorhanden gesucht werden soll:
// per nitem_index_key, nitem_detail_key $$HEX1$$fc00$$ENDHEX$$ber cen_packlinglist_material nach nproduct_index_key
// ----------------------------------------
for ll_Row = 1 to Upperbound(ll_IndexKeys) step 1
	ll_Ret = lds_Artikel.retrieve(ll_ResultKeys[ll_Row], ll_IndexKeys[ll_Row], ll_DetailKeys[ll_Row], ls_Classes[ll_Row])
	if this.ib_Trace then
		lds_Artikel.saveas(f_gettemppath() + "ContainerEquipment_ldsArtikel_" + string(ls_Classes[ll_Row]) + '_' + string(ll_IndexKeys[ll_Row], "0000") + "-" + String(ll_DetailKeys[ll_Row], "00") + '_' + String(now(), "hhmmss") + ".XLS", excel5!, True)
	end if

	// ----------------------------------------
	// S$$HEX1$$e400$$ENDHEX$$tze eintragen
	// ----------------------------------------
	// artikel-menge * master-menge ist das ergebnis
	// artikel-bezeichnung ausgeben, artikel-menge ausgeben
	// ----------------------------------------
	if ll_Ret > 0 then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber gefundene artikel
		for ll_RowArtikel = 1 to lds_Artikel.RowCount()
			// passt er zur product-group ?
			if not of_check_productgroup(this.of_checknull(lds_Artikel.GetItemNumber(ll_RowArtikel, "nproduct_index_key"))) then continue
			// passt er zur material-group ?
			if not of_check_materialgroup(this.of_checknull(lds_Artikel.GetItemNumber(ll_RowArtikel, "nmaterial_index_key"))) then continue
			// schon vorhanden ? dann nur die menge erh$$HEX1$$f600$$ENDHEX$$hen
			ll_Find = lds_Datastore.Find("nindex_key=" + string(lds_Artikel.GetItemNumber(ll_RowArtikel, "nitem_index_key")), 1, lds_Datastore.RowCount())
			if ll_Find > 0 then
				ll_Ret = lds_Datastore.Setitem(ll_Find, "nquantity", lds_Datastore.GetItemNumber(ll_Find, "nquantity") + lds_Artikel.GetItemNumber(ll_RowArtikel, "nquantity_pl") * lds_Artikel.GetItemNumber(ll_RowArtikel, "nquantity_item"))
			// noch nicht vorhanden ? dann neuen satz eintragen
			else
				ll_NewRow = lds_Datastore.InsertRow(0)
				// header
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nnumber", this.il_DeliverynoteNo)
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cairline", this.is_Airline)  // 6
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cairline_text", this.is_AirlineText)  // 40
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nflight_number", this.il_FlightNumber)
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cflight_numbers", this.is_FlightNumbers)  // 6
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "ddeparture_date", this.id_Departure)
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cdeparture_time", this.is_DepartureTime)  // 5
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "ctlc_from", this.is_TLC_from)  // 3
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cconfiguration", this.is_Configuration)  // 20
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cactype", this.is_ACType)  // 10
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cclass", ls_Class) // 12
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "cclass_description", ls_Classname) // 30
				// zeile: artikel
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nindex_key", lds_Artikel.GetItemNumber(ll_RowArtikel, "nitem_index_key"))
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "citem_pl", lds_Artikel.GetItemString(ll_RowArtikel, "citem_pl")) // 5
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "citem_text", lds_Artikel.GetItemString(ll_RowArtikel, "citem_text")) // 40
				// zeile: menge
				ll_Ret = lds_Datastore.SetItem(ll_NewRow, "nquantity", lds_Artikel.GetItemNumber(ll_RowArtikel, "nquantity_pl") * lds_Artikel.GetItemNumber(ll_RowArtikel, "nquantity_item"))
			end if
		next
	end if

next

// ----------------------------------------
// die s$$HEX1$$e400$$ENDHEX$$tze endg$$HEX1$$fc00$$ENDHEX$$ltig sortieren
// ----------------------------------------
ll_Ret = lds_Datastore.SetSort("citem_text")
ll_Ret = lds_Datastore.Sort()
ll_Ret = lds_Datastore.GroupCalc()

ll_Ret = of_fillup_equipment(lds_Datastore)

// ********************************
uf.translate_datastore(lds_Datastore )

// ----------------------------------------
// PDF erstellen
// ----------------------------------------
if lds_Datastore.RowCount() > 0 then
		if this.ib_Trace then
//			f_print_datastore(lds_Datastore)
			lds_Datastore.saveas(f_gettemppath() + "ContainerEquipment_ldsDatastore_" + string(this.is_Classes[1]) + '_' + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + '_' + String(now(), "hhmmss") + ".XLS", excel5!, True)
		end if
		this.is_ReportFiles[2] = f_gettemppath() + "CBASE-Equipment-" + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
		ll_Ret = this.of_create_acrobat(lds_Datastore, this.is_ReportFiles[2])
		if ll_Ret = -1 then
//			lb_ErrorOnAcrobat = true
			if this.ib_Trace then
				f_trace("of_create_equipment_report lb_Error_on_Acrobat")
			end if
		end if
else
	ll_Ret = 0
end if

// ----------------------------------------
// aufr$$HEX1$$e400$$ENDHEX$$umen
// ----------------------------------------
if IsValid(lds_Trays) then destroy(lds_Trays)
if IsValid(lds_Artikel) then destroy(lds_Artikel)
if IsValid(lds_Datastore) then destroy(lds_Datastore)

return ll_Ret

end function

public function long of_start (ref string as_pdffiles[]);
/* 
* Funktion:			of_start
* Beschreibung: 	reports container & equipment bauen (steuerung)
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		19.07.2012		Klassen-bestimmung ge$$HEX1$$e400$$ENDHEX$$ndert
*
* Return Codes:
* -1 		fehler (input / verarbeitung)
* 	0		???
* 	1		reports vorhanden
*/

// hilfsvariable
Long 		ll_Ret, ll_Row, ll_Lauf
String 	ls_Empty[]

// hilfsvariable initialisieren klassen 
String 	ls_Classes[]
// hilfsvariable filter
String 	ls_Filter

// hilfsvariable PDF-files komplett pro klasse
String 	ls_PdfFiles[]
// hilfsvariable PDF-files typ pro klasse (1 container; 2 equipment)
String 	ls_ReportFiles[]
// hilfsvariable nicht-buchungsklassen gemacht (da die zusammengefasst werden, darf es nur einmal gemacht werden)
Boolean lb_NotBookingDone


// initialisieren
this.il_FileCounter = 0
lb_NotBookingDone = false

// -----------------------------------------------------------
// keine / unvollst$$HEX1$$e400$$ENDHEX$$ndige input-daten
// -----------------------------------------------------------
// -2: datastore(s) invalid
// -1: kein flug und/oder keine beladung
//  0: keine stammdaten zur airline (klassen / equipment)
// -----------------------------------------------------------
if this.of_check_init() < 0 then
   return -1
end if

// -----------------------------------------------------------
// klassen bestimmen
// -----------------------------------------------------------
// erstmal nach klassen sortieren... und gleich nach index_key mit, weil das nachher auch gebraucht wird
ll_Ret = this.ids_Loading.SetSort("cen_loadinglists_cclass, cen_packinglist_index_npackinglist_index_key")
ll_Ret = this.ids_Loading.Sort()

// -----------------------------------------------------------
// pro klasse daten aufbereiten
// -----------------------------------------------------------
for ll_Row = 1 to  this.ids_Classes.RowCount() step 1
	// default weglassen
	if this.ids_Classes.GetItemString(ll_Row, "cclass") = "*" then continue
	if this.ids_Classes.GetItemNumber(ll_Row, "nbooking_class") = 0 and lb_NotBookingDone then continue
	// erstmal frisch initialiseren
	this.is_Classes = ls_Classes
	this.is_Classes_Text = ls_Classes
	// erste klasse auf jeden fall eintragen
	this.is_Classes[Upperbound(this.is_Classes) + 1] = this.ids_Classes.GetItemString(ll_Row, "cclass")
	this.is_Classes_Text[Upperbound(this.is_Classes)] = this.ids_Classes.GetItemString(ll_Row, "cclass_name")
	ls_Filter = "cen_loadinglists_cclass='" + this.is_Classes[1] + "'"
	// nicht-buchungsklasse: die weiteren dazu holen
	if this.ids_Classes.GetItemNumber(ll_Row, "nbooking_class") = 0 then
		lb_NotBookingDone = true
		for ll_Lauf = ll_Row + 1 to this.ids_Classes.RowCount() step 1
			if this.ids_Classes.GetItemString(ll_Lauf, "cclass") = "*" then continue
			if this.ids_Classes.GetItemNumber(ll_Lauf, "nbooking_class") = 1 then continue
			// weitere klasse eintragen
			this.is_Classes[Upperbound(this.is_Classes) + 1] = this.ids_Classes.GetItemString(ll_Lauf, "cclass")
			this.is_Classes_Text[Upperbound(this.is_Classes)] = this.ids_Classes.GetItemString(ll_Lauf, "cclass_name")
			ls_Filter += " or cen_loadinglists_cclass='" + this.is_Classes[Upperbound(this.is_Classes)] + "'"
		next
	end if
	// auf die aktuelle(n) klasse(n) filtern und nochmal sortieren
	ll_Ret = this.ids_Loading.SetFilter(ls_Filter)
//	if ll_Ret <> 1 then 
	ll_Ret = this.ids_Loading.Filter()
//	if ll_Ret <> 1 then 
	ll_Ret = this.ids_Loading.Sort()
//	if ll_Ret <> 1 then 
	// "alte" filenamen l$$HEX1$$f600$$ENDHEX$$schen
	this.is_ReportFiles[1] = ""
	this.is_ReportFiles[2] = ""
	ls_ReportFiles = ls_Empty
		
	// PDF-z$$HEX1$$e400$$ENDHEX$$hler pflegen
	this.il_FileCounter++
	// container-report aufbereiten
	if this.ids_Loading.Rowcount() > 0 then ll_Ret = this.of_create_container_report()
//	if ll_Ret <> 1 then 
	// equipment-report aufbereiten
	ll_Ret = this.of_create_equipment_report()
//	if ll_Ret <> 1 then 
	// die beiden reports zusammensetzen
	if this.is_ReportFiles[1] <> "" then ls_ReportFiles[Upperbound(ls_ReportFiles) + 1] = this.is_ReportFiles[1]
	if this.is_ReportFiles[2] <> "" then ls_ReportFiles[Upperbound(ls_ReportFiles) + 1] = this.is_ReportFiles[2]
	// nix da: PDF-z$$HEX1$$e400$$ENDHEX$$hler wieder runter
	if Upperbound(ls_ReportFiles) = 0 then
		this.il_FileCounter --
	// was da: zusammenfassen
	else
		// die dateien zusammenfassen
		ls_PdfFiles[this.il_FileCounter] = f_gettemppath() + this.is_File_Header + "-ContainerEquipment-" + string(this.il_FileCounter, "000") + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
		if s_app.uo_pdf.of_concatenate(ls_ReportFiles, ls_PdfFiles[this.il_FileCounter], true) = 0 then
			ll_Ret =  1
		else
			ll_Ret = -1
			if this.ib_Trace then
				f_trace("of_containerequipment_start MERGE lb_Error_on_Acrobat")
			end if
		end if
	end if
	
next

for ll_Row = 1 to Upperbound(ls_PdfFiles) step 1
	as_PdfFiles[Upperbound(as_PdfFiles) + 1] = ls_PdfFiles[ll_Row]
next

return ll_Ret

end function

protected function long of_check_init ();
/* 
* Funktion:			of_check_init
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$ft, ob alle notwendigen initialisierungen da sind
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.05.2012		Erstellung
*
* Return Codes:
* 	-2		eines der DS ist invalid
* 	-1		keine flug- oder beladedaten da
* 	 0		keine klassen und/oder equipment da
* 	 1		alles ok
*
*/

// hilfsvariable
Long 	ll_Ret = 1

// zuerst das pure vorhandensein der DS pr$$HEX1$$fc00$$ENDHEX$$fen
if not IsValid(this.ids_CenOut) then ll_Ret = -2
if not IsValid(this.ids_Loading) then ll_Ret = -2
if not IsValid(this.ids_Classes) then ll_Ret = -2
if not IsValid(this.ids_Equipment) then ll_Ret = -2

// alle da, dann inhalt flug- und beladedaten pr$$HEX1$$fc00$$ENDHEX$$fen
if ll_Ret = 1 then
	if this.ids_CenOut.RowCount() < 1 then ll_Ret = -1
	if this.ids_Loading.RowCount() < 1 then ll_Ret = -1
	if Upperbound(this.il_ResultKeys) < 1 then ll_Ret = -1
end if	

// alle DS da, flug- und beladedaten haben inhalt, dann vorhandensein der stammdaten pr$$HEX1$$fc00$$ENDHEX$$fen
if ll_Ret = 1 then
	if this.ids_Classes.RowCount() < 1 then ll_Ret = 0
	if this.ids_Equipment.RowCount() < 1 then ll_Ret = 0
end if	

return ll_Ret

end function

protected function long of_set_header_data ();
/* 
* Funktion:			of_set_header_data
* Beschreibung: 	instance-variablen f$$HEX1$$fc00$$ENDHEX$$r den flug setzen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*
* Return Codes:
* 	1		immer
*/

// hilfsvariable
Long 	ll_Ret, ll_Row
datastore lds_CenOut

this.is_Airline 				= this.ids_CenOut.GetItemString(1, "cairline")
this.is_AirlineText 			= f_get_airline_text(this.ids_CenOut.GetItemNumber(1, "nairline_key"))
this.il_FlightNumber 		= this.ids_CenOut.GetItemNumber(1, "nflight_number")
this.is_FlightNumbers 	= this.is_Airline + " " + string(this.il_FlightNumber, "000")
this.id_Departure 			= date(this.ids_CenOut.GetItemDatetime(1, "ddeparture"))
this.is_DepartureTime 	= this.ids_CenOut.GetItemString(1, "cdeparture_time")
this.is_TLC_from 			= this.ids_CenOut.GetItemString(1, "ctlc_from")
this.is_Configuration 		= this.ids_CenOut.GetItemString(1, "cconfiguration")
this.is_ACType 				= this.ids_CenOut.GetItemString(1, "cactype")
this.is_AirlineOwner 		= this.ids_CenOut.GetItemString(1, "cairline_owner")

// wenn es mehr als eine flugnummer gibt (legs!)
if UpperBound(this.il_ResultKeys) > 1 then
	lds_CenOut = create datastore
	lds_CenOut.dataobject = this.ids_CenOut.dataobject
	lds_CenOut.SetTransObject(sqlca)
	for ll_Row = 2 to UpperBound(this.il_ResultKeys) step 1
		ll_Ret = lds_CenOut.retrieve(this.il_ResultKeys[ll_Row])
		if ll_Ret >= 1 then this.is_FlightNumbers += "/" + string(lds_CenOut.GetItemNumber(1, "nflight_number"), "000")
	next
	destroy lds_CenOut
end if
if len(this.is_FlightNumbers) > 40 then this.is_FlightNumbers = left(this.is_FlightNumbers,40)

// lieferscheinnummer
if this.ids_Deliverynotes.RowCount() > 0 then
	this.il_DeliverynoteNo = this.ids_Deliverynotes.GetItemNumber(1, "nnumber")
else
	this.il_DeliverynoteNo = -1
end if

return 1

end function

protected function string of_set_unit_description (string as_unit);
/* 
* Funktion:			of_set_unit_description
* Beschreibung: 	setzt den zugeh$$HEX1$$f600$$ENDHEX$$rigen langnamen zum container/equipment
* 						setzt den kurznamen, wenn langname nicht vorhanden
* Besonderheit: 	
*
* Argumente:
* string 	as_unit	der kurzname des containers/equipment
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.05.2012		Erstellung
*
* Return Codes:
* 	 ergebnis: lang- oder kurzname
*
*/

// hilfsvariable
Long 		ll_Row
String 	ls_UnitDescription


// initialisieren
ls_UnitDescription = as_Unit

for ll_Row = 1 to this.ids_Equipment.RowCount() step 1
	if this.ids_Equipment.GetItemString(ll_Row, "cunit") = as_Unit then
		ls_UnitDescription = this.ids_Equipment.GetItemString(ll_Row, "ctext")
		exit
	end if
next

return ls_UnitDescription

end function

public function long of_init (datastore ads_cenout, datastore ads_loading, long al_resultkeys[]);
/* 
* Funktion:			of_init
* Beschreibung: 	$$HEX1$$fc00$$ENDHEX$$bernimm die daten zum flug und zur beladung
* 						lies die zus$$HEX1$$e400$$ENDHEX$$tzlich ben$$HEX1$$f600$$ENDHEX$$tigten stammdaten zur airline
* Besonderheit: 	
*
* Argumente:
* 	datastore ads_CenOut 	der flug
* 	datastore ads_Loading 	die beladung
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*
* Return Codes:
* 	0		keine flug- oder beladedaten $$HEX1$$fc00$$ENDHEX$$bergeben
* 	-1		fehler beim $$HEX1$$fc00$$ENDHEX$$bernehmen der flugdaten
* 	-2		fehler beim $$HEX1$$fc00$$ENDHEX$$bernehmen der beladedaten
* 	-3		fehler beim lesen der klassen zur airline
* 	-4		fehler beim lesen des equipments zur airline
* 	-5		fehler beim lesen der lieferscheine zum flug
*
*/

// hilfsvariable
Long 	ll_Ret = 0, ll_Row
Long 	ll_Empty[]
Long 	ll_ResultKey

// vorsichtshalber erstmal initialisieren (damit keine "alten" daten bleiben, wenn was schiefgeht)
if IsValid(this.ids_CenOut) then this.ids_CenOut.Reset()
if IsValid(this.ids_Loading) then this.ids_Loading.Reset()
if IsValid(this.ids_Classes) then this.ids_Classes.Reset()
if IsValid(this.ids_Equipment) then this.ids_Equipment.Reset()
if IsValid(this.ids_Deliverynotes) then this.ids_Deliverynotes.Reset()
this.il_ResultKeys = ll_Empty


// $$HEX1$$fc00$$ENDHEX$$bernimm die flugdaten
if isValid(ads_CenOut) then
	if not IsValid(this.ids_CenOut) then this.ids_CenOut = create datastore
	if this.ids_CenOut.dataobject <> ads_CenOut.dataobject then this.ids_CenOut.dataobject = ads_CenOut.dataobject
	if ads_CenOut.RowCount() > 0 then
		ll_Ret = ads_CenOut.RowsCopy(1, ads_CenOut.RowCount(), Primary!, this.ids_CenOut, 1, Primary!)
		if ll_Ret <> 1 then ll_Ret = -1
	else
		ll_Ret = 0
	end if
else
	ll_Ret = -1
end if

// wenn flugdaten da, dann hole die restlichen legs
if ll_Ret = 1 then
	ll_ResultKey = this.ids_CenOut.GetItemNumber(1, "nresult_key")
	this.il_ResultKeys[1] = ll_ResultKey
	if Upperbound(al_ResultKeys) > 0 then
		for ll_Row = 1 to Upperbound(al_ResultKeys) step 1
			if al_ResultKeys[ll_Row] <> ll_ResultKey then this.il_ResultKeys[Upperbound(this.il_ResultKeys) + 1] = al_ResultKeys[ll_Row]
		next
	end if
end if

// wenn flugdaten da, dann hole den lieferschein dazu
if ll_Ret = 1 then
	if not IsValid(this.ids_Deliverynotes) then
		this.ids_Deliverynotes = create datastore
		this.ids_Deliverynotes.dataobject = "dw_invoice_catering_order"
		this.ids_Deliverynotes.SetTransObject(sqlca)
	end if
	// lesen lieferscheine zum flug
	ll_Ret = this.ids_Deliverynotes.retrieve(ll_ResultKey)
	if ll_Ret > 0 then
		ll_Ret = this.ids_Deliverynotes.SetSort("dtimestamp desc")
		ll_Ret = this.ids_Deliverynotes.Sort()
	end if
	if ll_Ret = -1 then ll_Ret = -5
	if ll_Ret >= 0 then ll_Ret = 1
end if

// wenn flugdaten da, dann setze schon mal die instance-werte zum flug
if ll_Ret = 1 then ll_Ret = of_set_header_data()

// wenn flugdaten da, dann f$$HEX1$$fc00$$ENDHEX$$lle die hilfs-DS mit stammdaten zur airline
// keine s$$HEX1$$e400$$ENDHEX$$tze gefunden wird zugelassen, fehler beim lesen f$$HEX1$$fc00$$ENDHEX$$hrt zum abbruch
// keine s$$HEX1$$e400$$ENDHEX$$tze gefunden wird nicht weitergegeben
if ll_Ret = 1 then
	// klassen zur airline
	if not IsValid(this.ids_Classes) then
		this.ids_Classes = create datastore
		this.ids_Classes.dataobject = "dw_airline_classnames"
		this.ids_Classes.SetTransObject(sqlca)
	end if
	// container/equipment zur airline
	if not IsValid(this.ids_Equipment) then
		this.ids_Equipment = create datastore
		this.ids_Equipment.dataobject = "dw_airlines_equipment"
		this.ids_Equipment.SetTransObject(sqlca)
	end if
	// lesen klassen zur airline
	ll_Ret = this.ids_Classes.retrieve(this.ids_CenOut.GetItemNumber(1, "nairline_key"))
	if ll_Ret = -1 then ll_Ret = -3
	// lesen container/equipment zur airline
	if ll_Ret >= 0 then
		ll_Ret = this.ids_Equipment.retrieve(this.ids_CenOut.GetItemNumber(1, "nairline_key"))
		if ll_Ret = -1 then ll_Ret = -4
	end if
	if ll_Ret >= 0 then ll_Ret = 1
end if

// wenn flugdaten da, dann $$HEX1$$fc00$$ENDHEX$$bernimm die belade-daten
if ll_Ret = 1 then
	if isValid(ads_Loading) then
		if not isValid(this.ids_Loading) then this.ids_Loading = create datastore
		if this.ids_Loading.dataobject <> ads_Loading.dataobject then this.ids_Loading.dataobject = ads_Loading.dataobject
		if ads_Loading.RowCount() > 0 then
			ll_Ret = ads_Loading.RowsCopy(1, ads_Loading.RowCount(), Primary!, this.ids_Loading, 1, Primary!)
			if ll_Ret <> 1 then ll_Ret = -2
		else
			ll_Ret = 0
		end if
	else
		ll_Ret = -2
	end if
end if

return ll_Ret

end function

protected function boolean of_check_productgroup (long al_productgroupkey);
/* 
* Funktion:			of_check_productgroup
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$ft, ob der $$HEX1$$fc00$$ENDHEX$$bergebene productgroupKey in der Liste der g$$HEX1$$fc00$$ENDHEX$$ltigen ist
* Besonderheit: 	
*
* Argumente:
* 	long 	al_ProductGroupKey
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.05.2012		Erstellung
*
* Return Codes:
* 	 false		key ist nicht in der liste
* 	 true 		key ist in der liste bzw. es soll nicht gepr$$HEX1$$fc00$$ENDHEX$$ft werden
*/




// hilfsvariable
Boolean 	lb_Ret
Long 		ll_Row

// initialisieren
lb_Ret = false

// keine product-gruppen da: nicht pr$$HEX1$$fc00$$ENDHEX$$fen
if Upperbound(this.il_ProductGroupKeys) = 0 then return true

// keine product-gruppen gesetzt: nicht pr$$HEX1$$fc00$$ENDHEX$$fen
if this.il_ProductGroupKeys[1] = -1 then return true

// product-gruppen da und gesetzt
for ll_Row = 1 to Upperbound(this.il_ProductGroupKeys) step 1
	if this.il_ProductGroupKeys[ll_Row] = al_ProductGroupKey then
		lb_Ret = true
		exit
	end if
next

return lb_Ret

end function

protected function integer of_create_acrobat (ref datastore ads_acrobat, string as_filename);
/*
* Objekt : uo_container_equipment_report
* Methode: of_create_acrobat (Function)
*
* Argument(e):
* datastore ref 	ads_Acrobat
* string 				as_FileName
*
* Beschreibung:		 
*
* Aenderungshistorie:
* Version    Wer       Wann          Was und warum
*  1.0       ???       xx.xx.xxxx    Erstellung
*  1.1       D.Bunk    19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
* Return: integer
*
*/

// hilfsvariable

String ls_AcrobatFile	= ""


// -------------------------------------------------------------------
// Pdf erstellen
// -------------------------------------------------------------------
if len(f_gettemppath()) > 0 Then
	ls_AcrobatFile = as_FileName
	ls_AcrobatFile = f_valid_filename(ls_AcrobatFile)
else
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [2]", StopSign!)
	return -1
end if

if s_app.uo_PDF.of_convert(ads_Acrobat, "ReportBrowser", ls_AcrobatFile) <> 0 then 
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [5]", StopSign!)
	return -1
end if

if not FileExists(ls_AcrobatFile) Then 
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [6]", StopSign!)
	return -1
End if	

// ------------------------------------
// Defaultdrucker setzen
// ------------------------------------	
f_setcurrentdirectory(s_app.scurrentdirectory)

return 0

end function

protected function boolean of_check_materialgroup (long al_materialgroupkey);
/* 
* Funktion:			of_check_materialgroup
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$ft, ob der $$HEX1$$fc00$$ENDHEX$$bergebene materialgroupKey in der Liste der g$$HEX1$$fc00$$ENDHEX$$ltigen ist
* Besonderheit: 	
*
* Argumente:
* 	long 	al_MaterialGroupKey
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		05.06.2012		Erstellung
*
* Return Codes:
* 	 false		key ist nicht in der liste
* 	 true 		key ist in der liste bzw. es soll nicht gepr$$HEX1$$fc00$$ENDHEX$$ft werden
*/




// hilfsvariable
Boolean 	lb_Ret
Long 		ll_Row

// initialisieren
lb_Ret = false

// keine product-gruppen da: nicht pr$$HEX1$$fc00$$ENDHEX$$fen
if Upperbound(this.il_MaterialGroupKeys) = 0 then return true

// keine product-gruppen gesetzt: nicht pr$$HEX1$$fc00$$ENDHEX$$fen
if this.il_MaterialGroupKeys[1] = -1 then return true

// product-gruppen da und gesetzt
for ll_Row = 1 to Upperbound(this.il_MaterialGroupKeys) step 1
	if this.il_MaterialGroupKeys[ll_Row] = al_MaterialGroupKey then
		lb_Ret = true
		exit
	end if
next

return lb_Ret

end function

protected function boolean of_check_containerunit (string as_containerunit);
/* 
* Funktion:			of_check_containerunit
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$ft, ob die $$HEX1$$fc00$$ENDHEX$$bergebene einheit in der Liste der g$$HEX1$$fc00$$ENDHEX$$ltigen ist
* Besonderheit: 	
*
* Argumente:
* 	string 	as_ContainerUnit
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		10.07.2012		Erstellung
*
* Return Codes:
* 	 false		key ist nicht in der liste
* 	 true 		key ist in der liste bzw. es soll nicht gepr$$HEX1$$fc00$$ENDHEX$$ft werden
*/




// hilfsvariable
Boolean 	lb_Ret
Long 		ll_Row

// initialisieren
lb_Ret = false

// keine container-einheiten da: nicht in der liste zur$$HEX1$$fc00$$ENDHEX$$ckgeben
if Upperbound(this.is_ContainerUnits) = 0 then return false

// keine container-einheiten gesetzt: nicht pr$$HEX1$$fc00$$ENDHEX$$fen
if this.is_ContainerUnits[1] = "-1" then return true

// container-einheiten da und gesetzt
for ll_Row = 1 to Upperbound(this.is_ContainerUnits) step 1
	if this.is_ContainerUnits[ll_Row] = as_ContainerUnit then
		lb_Ret = true
		exit
	end if
next

return lb_Ret

end function

protected function string of_checknull (string as_string2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem string in einen leerstring
* Besonderheit: 	
*
* Argumente:
* 	long 		as_String2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		23.07.2009		Erstellung
*
* Return Codes:
*	 as_String2Check	wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
String 	ls_Ret = ""

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(as_String2Check) then ls_Ret = as_String2Check

return ls_Ret

end function

protected function long of_checknull (long al_long2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem long in eine 0
* Besonderheit: 	
*
* Argumente:
* 	long 		al_Long2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		23.07.2009		Erstellung
*
* Return Codes:
*	 al_Long2Check		wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
Long 	ll_Ret = 0

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(al_Long2Check) then ll_Ret = al_Long2Check

return ll_Ret

end function

protected function long of_fillup_equipment (datastore ads_datastore);
/* 
* Funktion:			of_fillup_equipment
* Beschreibung: 	leer-zeilen im report equipment erg$$HEX1$$e400$$ENDHEX$$nzen, bis eine seite gef$$HEX1$$fc00$$ENDHEX$$llt ist 
* Besonderheit: 	die Seitenh$$HEX1$$f600$$ENDHEX$$he ist fest mit 1123 pixel vorbelegt, kann per setup ver$$HEX1$$e400$$ENDHEX$$ndert werden
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.07.2012		Erstellung
*
* Return Codes:
* 	0		immer
*/

// allgemeine hilfsvariable
Long ll_RowsPerPage
String ls_Temp

// hilfsvariable abmessungen
Integer li_DWHeight = 1123
Integer li_MarginTop, li_MarginBottom
Integer li_HeaderHeight, li_FooterHeight, li_SummaryHeight	
Integer li_DetailHeight

// initialisieren
li_DWHeight = this.il_PageHeight

// ---------------------------------------------------------------------------
// Gesamt-H$$HEX1$$f600$$ENDHEX$$he ermitteln
// ---------------------------------------------------------------------------
if ads_Datastore.Object.DataWindow.Print.Orientation = "1" then
	li_DWHeight	= 793  
elseif ads_Datastore.Object.DataWindow.Print.Orientation = "2" then
	li_DWHeight	= 1123 
end if	

// ---------------------------------------------------------------------------
// R$$HEX1$$e400$$ENDHEX$$nder / band-h$$HEX1$$f600$$ENDHEX$$hen ermitteln
// ---------------------------------------------------------------------------
li_MarginTop = integer(ads_Datastore.Object.DataWindow.Print.Margin.Top)
li_MarginBottom = integer(ads_Datastore.Object.DataWindow.Print.Margin.Bottom)
li_HeaderHeight = integer(ads_Datastore.Object.DataWindow.Header.Height)
li_FooterHeight = integer(ads_Datastore.Object.DataWindow.Footer.Height)	
li_SummaryHeight = integer(ads_Datastore.Object.DataWindow.Summary.Height)	
li_DetailHeight = integer(ads_Datastore.Object.DataWindow.Detail.Height)

// ---------------------------------------------------------------------------
// Maximal m$$HEX1$$f600$$ENDHEX$$gliche anzahl zeilen im detail-band errechnen
// (mit 2 multiplizieren, da zwei spalten da sind)
// ---------------------------------------------------------------------------	
ll_RowsPerPage = truncate(((li_DWHeight - (li_Headerheight + li_Footerheight + li_SummaryHeight + li_MarginTop + li_MarginBottom)) /  li_DetailHeight), 0) * 2

//MessageBox("Max Rows per Page", string(ll_RowsPerPage) + " f$$HEX1$$fc00$$ENDHEX$$r " + string(ads_Datastore.RowCount()))

// ---------------------------------------------------------------------------
// Leerzeilen einf$$HEX1$$fc00$$ENDHEX$$gen, bis ein glattes Vielfaches der Max-Anzahl zeilen im detail-band erreicht ist
// ---------------------------------------------------------------------------	
do while mod(ads_Datastore.RowCount(), ll_RowsPerPage) <> 0
	ads_Datastore.InsertRow(0)
loop

//MessageBox("Max Rows per Page", string(ll_RowsPerPage) + " f$$HEX1$$fc00$$ENDHEX$$r " + string(ads_Datastore.RowCount()))

return 0


end function

on uo_container_equipment_report.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_container_equipment_report.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert den trace-schalter und die (internen) selektionskriterien
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		05.06.2012		Materialgroup rein
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/

// hilfsvariable
String 	ls_ProductGroupKeys, ls_MaterialGroupKeys, ls_ContainerUnits
Long 		ll_Row, ll_Pos


// --------------------------------------------------
// Key f$$HEX1$$fc00$$ENDHEX$$r Beverage zum container (aus setup)
// --------------------------------------------------
this.il_BeverageKey = long(f_mandant_profilestring(sqlca, s_app.sMandant, "PL-Type", "BeverageKey", "-1"))

// --------------------------------------------------
// Keys f$$HEX1$$fc00$$ENDHEX$$r Equipment (aus setup)
// es wird nicht gepr$$HEX1$$fc00$$ENDHEX$$ft, wenn nur -1 drin steht: auf diese Weise kann abgeschaltet werden
// --------------------------------------------------
// productgroup
ls_ProductGroupKeys = f_mandant_profilestring(sqlca, s_app.sMandant, "Equip-Report", "ProductGroup", "-1")
if trim(ls_ProductGroupKeys) <> "" then
	ll_Pos = Pos(ls_ProductGroupKeys, ",")
	ll_Row = 1
	do while ll_Pos > 0
		if IsNumber(trim(left(ls_ProductGroupKeys, ll_Pos - 1))) then
			this.il_ProductGroupKeys[ll_Row] = long(trim(left(ls_ProductGroupKeys, ll_Pos - 1)))
			ll_Row += 1
		end if
		ls_ProductGroupKeys = trim(mid(ls_ProductGroupKeys, ll_Pos + 1))
		ll_Pos = Pos(ls_ProductGroupKeys, ",")
	loop
	if trim(ls_ProductGroupKeys) <> "" then
		this.il_ProductGroupKeys[ll_Row] = long(trim(ls_ProductGroupKeys))
	end if
else
	this.il_ProductGroupKeys[1] = -1
end if
// materialgroup
ls_MaterialGroupKeys = f_mandant_profilestring(sqlca, s_app.sMandant, "Equip-Report", "MaterialGroup", "-1")
if trim(ls_MaterialGroupKeys) <> "" then
	ll_Pos = Pos(ls_MaterialGroupKeys, ",")
	ll_Row = 1
	do while ll_Pos > 0
		if IsNumber(trim(left(ls_MaterialGroupKeys, ll_Pos - 1))) then
			this.il_MaterialGroupKeys[ll_Row] = long(trim(left(ls_MaterialGroupKeys, ll_Pos - 1)))
			ll_Row += 1
		end if
		ls_MaterialGroupKeys = trim(mid(ls_MaterialGroupKeys, ll_Pos + 1))
		ll_Pos = Pos(ls_MaterialGroupKeys, ",")
	loop
	if trim(ls_MaterialGroupKeys) <> "" then
		this.il_MaterialGroupKeys[ll_Row] = long(trim(ls_MaterialGroupKeys))
	end if
else
	this.il_MaterialGroupKeys[1] = -1
end if

// container-units
ls_ContainerUnits = f_mandant_profilestring(sqlca, s_app.sMandant, "Equip-Report", "Container", "CA9, CA, HC, SC, OV, OV7, WT, WH, IB, IC, IC9")
if trim(ls_ContainerUnits) <> "" then
	ll_Pos = Pos(ls_ContainerUnits, ",")
	ll_Row = 1
	do while ll_Pos > 0
		if trim(left(ls_ContainerUnits, ll_Pos - 1)) <> "" then
			this.is_ContainerUnits[ll_Row] = trim(left(ls_ContainerUnits, ll_Pos - 1))
			ll_Row += 1
		end if
		ls_ContainerUnits = trim(mid(ls_ContainerUnits, ll_Pos + 1))
		ll_Pos = Pos(ls_ContainerUnits, ",")
	loop
	if trim(ls_ContainerUnits) <> "" then
		this.is_ContainerUnits[ll_Row] = trim(ls_ContainerUnits)
	end if
end if


// seiten-h$$HEX1$$f600$$ENDHEX$$he in Pixel
this.il_PageHeight = long(f_mandant_profilestring(sqlca, s_app.sMandant, "Equip-Report", "SizeHeight", string(this.il_PageHeight)))


// --------------------------------------------------
// trace-schalter
// sonderfall hintergrund-files: 
// 	- pr$$HEX1$$e400$$ENDHEX$$fix setzen, damit sie nicht aufger$$HEX1$$e400$$ENDHEX$$umt werden beim abmelden
// --------------------------------------------------
if handle(getapplication()) = 0 then
	this.ib_Trace = true
	this.is_File_Header = "t" + this.is_File_Header
else
	this.ib_Trace = false
end if

return 0

end event

event destructor;
/* 
* Event: 				destructor
* Beschreibung: 	aufr$$HEX1$$e400$$ENDHEX$$umen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.05.2012		Erstellung
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/

// hilfsvariable



// aufr$$HEX1$$e400$$ENDHEX$$umen
if IsValid(this.ids_CenOut) then destroy this.ids_CenOut
if IsValid(this.ids_Loading) then destroy this.ids_Loading
if IsValid(this.ids_Classes) then destroy this.ids_Classes
if IsValid(this.ids_Equipment) then destroy this.ids_Equipment

return 0

end event

