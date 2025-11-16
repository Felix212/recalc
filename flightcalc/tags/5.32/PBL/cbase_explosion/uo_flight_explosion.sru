HA$PBExportHeader$uo_flight_explosion.sru
$PBExportComments$Userobject ermittelt die Beladung f$$HEX1$$fc00$$ENDHEX$$r einen Flug aus dessen Sammelst$$HEX1$$fc00$$ENDHEX$$cklisten und Zusatzbeladelisten
forward
global type uo_flight_explosion from nonvisualobject
end type
end forward

global type uo_flight_explosion from nonvisualobject
end type
global uo_flight_explosion uo_flight_explosion

type variables
// ---------------------------------
// zu setzende Userobject Properties
// ---------------------------------
	long 			lFirstArgRetrieve[]
	long			lSecondArgRetrieve[]
	DateTime 	dtDepartureDate
	
	String			sDepartureTime
	String			sVerkehrstag

	Long			lResultKey
	Long			lTransaction
	
	String			sLogPath
	
// ---------------------------------
// Interne Userobject Properties
// ---------------------------------
	Long			lArgschema
	String			sStatusText
	DataStore 	ds_loadinglist
	DataStore	ds_suplementloadingslist
	
	string			is_logFile

	boolean	bmanueldistribution
	boolean	bmzv_loaded
end variables

forward prototypes
public function boolean uf_no_action (long lrow)
public function boolean uf_exclude (long lrow)
public function long uf_get_schema ()
public function long uf_delete (datastore dsdelete)
public function integer uf_zustauen (long lrow)
public function boolean uf_offload (long lrow)
public function boolean uf_actioncode ()
public function long uf_retrieve ()
public function boolean uf_store_loading ()
public function boolean uf_restore_loading ()
public function integer uf_log (string smsg, string sfunction)
public function integer uf_compare_plsql (uo_cbase_datastore ids_loading_list_result_plsql)
end prototypes

public function boolean uf_no_action (long lrow);	long 		lActionRow,lSeekRow,i
	string	sGalley,sStowage,sPlace
	integer  iBelly
// ------------------------------------------------------------------------------
// Actioncode 'N' -> No Action
// Es werden alle Datens$$HEX1$$e400$$ENDHEX$$tze gesucht.
// Die in Galley,Stowage,Place und Belly $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// Sofern der Satz gefunden wird wird im Feld ....
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	lSeekRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
	sPlace		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cplace")
	iBelly		= ds_loadinglist.GetitemNumber(lRow,"cen_loadinglists_nbelly_container")
	
	Do while lActionRow > 0
		lActionRow = ds_loadinglist.Find("cen_galley_cgalley = '" + sGalley + "' and " + &
									  "cen_stowage_cstowage = '" + sStowage + "' and " + &
									  "cen_stowage_cplace = '" + sPlace + "' and " + &
									  "cen_loadinglists_nbelly_container = " + string(iBelly),lSeekRow, ds_loadinglist.RowCount()) 

		If lActionRow > 0	Then
			ds_loadinglist.SetItem(lActionRow,"cen_loadinglists_cadd_on_text","No Action")			
		End if
		lSeekRow = lActionRow + 1
		If lSeekRow > ds_loadinglist.RowCount()	Then
			exit
		End If
	Loop	
	
	return True
end function

public function boolean uf_exclude (long lrow);	long 		lActionRow
	string	sGalley,sStowage
// ------------------------------------------------------------------------------
// $$HEX2$$81002000$$ENDHEX$$Es werden Datens$$HEX1$$e400$$ENDHEX$$tze gesucht die in Galley und Stowage $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// $$HEX2$$81002000$$ENDHEX$$Sofern der Satz gefunden wird wird im Feld Compute Exclude der Status 1 eingetragen.
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
		
//	lActionRow = ds_exclude.Find("cgalley = '" + sGalley + "' and " + &
//						 "cstowage = '" + sStowage + "'",1,ds_exclude.RowCount()) 

	If lActionRow > 0	Then
		Return True
	Else 
		Return False
	End if
	
end function

public function long uf_get_schema ();// --------------------------------------------------
// Key wird ben$$HEX1$$f600$$ENDHEX$$tigt f$$HEX1$$fc00$$ENDHEX$$r retrieve
// --------------------------------------------------
	select min(nschema_key)
	  into :lArgSchema
	  from cen_object_schema;
	If SQLCA.SQLCODE <> 0 Then
		sStatusText = "No Schema Key available"
		return 0
	Else
		return lArgSchema
	End if	
	  
end function

public function long uf_delete (datastore dsdelete);	long i
	long lDeleted = 0
// -----------------------------------------------
// L$$HEX1$$f600$$ENDHEX$$scht Datens$$HEX1$$e400$$ENDHEX$$tze die nicht ben$$HEX1$$f600$$ENDHEX$$tigt werden.
// -----------------------------------------------
	For i = dsdelete.Rowcount() to 1 Step -1
		 If dsdelete.GetitemNumber(i,"compute_1") > 0 Then
		 	 dsdelete.deleterow(i)
			 lDeleted ++  
	 	 End if	
	Next 	
	
	Return lDeleted
end function

public function integer uf_zustauen (long lrow);// --------------------------------------------
// Eintr$$HEX1$$e400$$ENDHEX$$ge aus ZBL mit dem Actioncode Z
// (Zustauen), werden in die zugeh$$HEX1$$f600$$ENDHEX$$rige 
// Zeile der SSL $$HEX1$$fc00$$ENDHEX$$bertragen
// --------------------------------------------

Long		lStowageKey, &
			lRowStowage, &
			lQuantity
		
String	sZustautext, &
			sZustautextB, &
			sText
			

lStowageKey = ds_loadinglist.GetItemNumber(lRow, "cen_stowage_nstowage_key")

if lStowageKey = -1 Then
	return -1
end if

sZustautext	 = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext")
sZustautextB = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext_short")
lQuantity    = ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nquantity")

if isnull(sZustautext) then sZustautext = ""
if isnull(sZustautextB) then sZustautextB = ""

if lQuantity > 1 then
	sZustautext = String(lQuantity) + " x " + sZustautext
end if
	
if lQuantity > 1 then
	sZustautextB = String(lQuantity) + " x " + sZustautextB
end if	

if Len(sZustautextB) < Len(sZustautext) Then
	// -------------------------
	// den k$$HEX1$$fc00$$ENDHEX$$rzeren Text nehmen
	// -------------------------
	sZustautext = sZustautextB
	
end if

lRowStowage = 1
Do while lRowStowage > 0
	lRowStowage = ds_loadinglist.Find ("cen_stowage_nstowage_key = " + String(lStowageKey) + " and cen_loadinglist_index_nloadinglist_key = 1", lRowStowage, ds_loadinglist.RowCount())
	if lRowStowage > 0 AND lRowStowage <> lRow  Then
		sZustautextB = ds_loadinglist.GetItemString(lRowStowage, "compute_ZustauText")
		
		//if isNull(sZustautextB) OR Len(Trim(sZustautextB)) = 0 Then
			
			sText = ds_loadinglist.GetItemString(lRowStowage, "compute_ZustauText")
			
			if isNull(sText) then sText = ""
			if Trim(sText) <> "" then sText += "~r~n"
			
			ds_loadinglist.SetItem(lRowStowage, "compute_ZustauText", sText + sZustautext)
			
		//end if
	end if
	
	if lRowStowage > 0 Then
		lRowStowage ++
	end if
	
	if lRowStowage > ds_loadinglist.RowCount() Then
		lRowStowage = 0
	end if
Loop


return 1

end function

public function boolean uf_offload (long lrow);	long 		lActionRow,lSeekRow,i
	string	sGalley,sStowage,sPlace
	integer  iBelly
// ------------------------------------------------------------------------------
//   Actioncode Offload
// $$HEX2$$81002000$$ENDHEX$$Es werden Datens$$HEX1$$e400$$ENDHEX$$tze gesucht die den Loading List Type 1 (Loading List) haben.
// $$HEX2$$81002000$$ENDHEX$$Die in Galley,Stowage,Place und Belly $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// $$HEX2$$81002000$$ENDHEX$$Sofern der Satz gefunden wird wird im Feld Compute Actioncode der Status 1 eingetragen.
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	lSeekRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
	sPlace		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cplace")
	iBelly		= ds_loadinglist.GetitemNumber(lRow,"cen_loadinglists_nbelly_container")
	
	Do while lActionRow > 0
		lActionRow = ds_loadinglist.Find("cen_galley_cgalley = '" + sGalley + "' and " + &
									  "cen_stowage_cstowage = '" + sStowage + "' and " + &
									  "cen_stowage_cplace = '" + sPlace + "' and " + &
									  "cen_loadinglists_nbelly_container = " + string(iBelly) + " and " + &
									  "cen_loadinglist_index_nloadinglist_key <> " + "2",lSeekRow, ds_loadinglist.RowCount()) 

		If lActionRow > 0	Then
			ds_loadinglist.Setitem(lActionRow,"compute_actioncode",1) 	
		End if
		lSeekRow = lActionRow + 1
		If lSeekRow > ds_loadinglist.RowCount()	Then
			exit
		End If
	Loop	
	
	return True
	
end function

public function boolean uf_actioncode ();	long 		i
	 
// ----------------------------------------------------------------
// M$$HEX1$$f600$$ENDHEX$$gliche Actioncodes
//	1. L	-> Load	
//	2. O	-> Offload
//	3. C	-> Crewrequest							(l$$HEX1$$f600$$ENDHEX$$schen)
//	4. X	-> Austauschen
//	5. R	-> Auff$$HEX1$$fc00$$ENDHEX$$llen  / Replenish			(Intern Austauschen)
// 6. Z  -> Zustauen								(Intern Load)
// 7. N  -> No Action							(Keine Action)
// ----------------------------------------------------------------
	For i = 1 to ds_loadinglist.Rowcount()
		// -------------------------------------------------
		// Actioncode Crewrequest (C)
		// -------------------------------------------------
		If ds_loadinglist.GetItemString(i,"cen_loadinglists_cactioncode") = 'C' Then
			// -------------------------------------------------
			// diesen Satz in Compute Actioncode markieren.
			// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
		End If
		// -------------------------------------------------
		// Actioncode Offload (O), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
		// Supplement Loading List sind. (2)
		// -------------------------------------------------
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'O' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
			// -------------------------------------------------
			// diesen Satz in Compute Actioncode markieren.
			// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			uf_offload(i)
		End If
		// -------------------------------------------------
		// Actioncode Austauschen (X) oder Austauschen (R), 
		//	nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp Supplement Loading List
		// sind. (2)
		// -------------------------------------------------
		If (ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'X' OR &
			 ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'R') and &
			 ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
			// -------------------------------------------------------
			// dieser Satz bleibt erhalten, und wird auf Load gesetzt
			// -------------------------------------------------------
//			string sOut
//			sOut = "ActionCode: " + ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") + "~r"
//			sOut += "Stowage: " + ds_loadinglist.Getitemstring(i,"cen_galley_cgalley") + " " + ds_loadinglist.Getitemstring(i,"cen_stowage_cstowage") + "-" + ds_loadinglist.Getitemstring(i,"cen_stowage_cplace")
//			sOut += "Key: " + string(ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key"))
//			Messagebox("", sOut)
			
			uf_offload(i)
			ds_loadinglist.SetItem(i,"cen_loadinglists_cactioncode", "L") 
		End If
		// -----------------------------------------------------------
		// Actioncode Zustauen (Z), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
		// Supplement Loading List sind (2) und deren Inhalte 
		// in der Galley sind (cen_loadinglists_nbelly_container = 0)
		// Zustauorte aus der Belly nicht zustauen => gehen auf
		// auf Belly-Report
		// -----------------------------------------------------------
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'Z' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 AND &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglists_nbelly_container") = 0 Then
			// -------------------------------------------------
			// den Text der ZBL in den zugeh$$HEX1$$f600$$ENDHEX$$rigen Stauort $$HEX1$$fc00$$ENDHEX$$ber-
			// tragen
			// -------------------------------------------------
			// wurde entfernt, damit der zweite uf_delete
			// die Zeile nicht l$$HEX1$$f600$$ENDHEX$$scht
			// -------------------------------------------------
			//ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			
			uf_zustauen(i)
		End If
		// -----------------------------------------------------------
		// Actioncode Zustauen (N), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
		// Supplement Loading List sind (2) 
		// -----------------------------------------------------------		
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'N' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
			// -------------------------------------------------
			// diesen Actioncode $$HEX1$$fc00$$ENDHEX$$bertragen, und sp$$HEX1$$e400$$ENDHEX$$ter bei der 
			// SI-Code bearbeitung ber$$HEX1$$fc00$$ENDHEX$$cksichtigen.
			// -------------------------------------------------
			// -------------------------------------------------
			// diesen Satz in Compute Actioncode markieren.
			// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			uf_no_action(i)
		End If		
		
	Next
	
	return True

end function

public function long uf_retrieve ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_explosion
// Methode: uf_retrieve (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: long
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version	Autor						Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  ??.??.????	1.00		???
//  17.07.2012	1.01		Thomas Brackmann	Aufruf  uf_restore_loading und  uf_store_loading
//  22.08.2015	1.02		Thomas Schaefer		PL/SQL-Version des Loadings eingebaut (ist $$HEX1$$fc00$$ENDHEX$$ber den Schalter Standard Loading
//															- Loading PL/SQL in cen_setup steuerbar, ob die Beladung wie bisher mit PB gemacht werden
//															soll oder in PL/SQL. Steht der Schalter auf 'COMPARE' wird beides gemacht und 
//															gepr$$HEX1$$fc00$$ENDHEX$$ft, ob alles identisch ist)
// -----------------------------------------------------------------------------------------------------------------------------------------
	
Long		ll_rows
Integer	i
Long		ll_ArgRetrieve[]
boolean	lb_ret
Long		lStart, lEnde

Integer		li_rc
String			ls_plsql_switch
n_keylist		lnv_keylist_sll
n_keylist		lnv_keylist_suppl
Long			ll_session_key_sll
Long			ll_session_key_suppl
uo_cbase_Datastore		lds_loading_list_result_plsql


lStart = CPU()

// Ggf. Loading aus Sicherung holen ...
//MB 16.04.2014: Nur wenn keine manuelle Distribution gew$$HEX1$$e400$$ENDHEX$$hlt wurde...
IF bmanueldistribution = False THEN
	lb_ret =  uf_restore_loading()
	//MB 23.06.2014: Wenn aus DB, dann Schalter setzen
	bmzv_loaded = lb_ret
	IF lb_ret = True THEN
		lEnde = CPU()
		uf_log("Retrieve Loading took " + string((lEnde - lStart)/1000, "0.00") + " seconds!","uf_retrieve")
		RETURN ds_loadinglist.Rowcount()
	END IF
END IF

IF bmanueldistribution = True OR lb_ret = False THEN
	bmzv_loaded = False
	// Schalter, ob PL/SQL-Version der Beladung genutzt werden soll, auslesen
	ls_plsql_switch = f_mandant_profilestring(sqlca,s_app.smandant,"Standard Loading","Loading PL/SQL","0")
	IF ls_plsql_switch = "1" OR ls_plsql_switch = "COMPARE" THEN
		// PL/SQL-Version
		lds_loading_list_result_plsql = Create uo_cbase_DataStore
		lds_loading_list_result_plsql.DataObject = "dw_loading_list_result_plsql"
		lds_loading_list_result_plsql.SetTransObject(SQLCA)
		lStart = CPU()
		// Die Standard Loading Lists und Supplement Loading Lists in Tabelle cen_key_list schreiben
		lnv_keylist_sll = Create n_keylist
		lnv_keylist_sll.of_session_set_transaction(SQLCA)
		ll_session_key_sll = lnv_keylist_sll.of_session_start()
		FOR i = 1 TO UpperBound(lFirstArgRetrieve)
			lnv_keylist_sll.of_session_insert_data(lFirstArgRetrieve[i])
		NEXT
		lnv_keylist_sll.of_session_commit()
		lnv_keylist_suppl = Create n_keylist
		lnv_keylist_suppl.of_session_set_transaction(SQLCA)
		ll_session_key_suppl = lnv_keylist_suppl.of_session_start()
		FOR i = 1 TO UpperBound(lSecondArgRetrieve)
			lnv_keylist_suppl.of_session_insert_data(lSecondArgRetrieve[i])
		NEXT
		lnv_keylist_suppl.of_session_commit()
		// Retrieve und Bearbeitung der Actioncodes in PL/SQL
		ll_rows = lds_loading_list_result_plsql.Retrieve(-1, '0', '', ll_session_key_sll, ll_session_key_suppl, Date(dtDepartureDate), sDepartureTime, 0)
		Destroy lnv_keylist_sll
		Destroy lnv_keylist_suppl
		IF ls_plsql_switch = "1" THEN
			// Kopieren nach dw_loadinglists
			li_rc = lds_loading_list_result_plsql.RowsCopy(1, lds_loading_list_result_plsql.RowCount(), Primary!, ds_loadinglist, 1, Primary!)
			IF ds_loadinglist.RowCount() <= 0 THEN
				sStatusText = "No rows in datastore ds_loadinglist."
				If IsValid(lds_loading_list_result_plsql) THEN Destroy lds_loading_list_result_plsql
				Return 0			  
			END IF
		END IF
	END IF
	IF ls_plsql_switch = "0" OR ls_plsql_switch = "COMPARE" THEN
		// PB-Version
		lStart = CPU()
		// -------------------------------------------
		// Schema Key ermitteln
		// -------------------------------------------
		uf_get_schema()
		// -------------------------------------------
		// Retrieve des Handling Loadinglist
		// -------------------------------------------
		ll_rows = ds_loadinglist.Retrieve(lFirstArgRetrieve[], dtDepartureDate, sDepartureTime, sVerkehrstag, lArgschema)
		IF ll_rows <= 0 THEN
			sStatusText = "No rows in datastore ds_loadinglist."
			If IsValid(lds_loading_list_result_plsql) THEN Destroy lds_loading_list_result_plsql
			Return 0			  
		END IF
		// ----------------------------------------------------------------------
		// First Delete. Alles weg was nicht dem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich entspricht.
		// ----------------------------------------------------------------------
		uf_delete(ds_loadinglist)
		// -------------------------------------------------
		// Abarbeitung des Handling Supplement Loadinglist
		// -------------------------------------------------
		FOR i = 1 TO Upperbound(lSecondArgRetrieve)
			ll_ArgRetrieve[1] = lSecondArgRetrieve[i]
			ll_rows = ds_suplementloadingslist.Retrieve(ll_ArgRetrieve[], dtDepartureDate, sDepartureTime, sVerkehrstag, lArgschema)
			// ----------------------------------------------------------------------
			// First Delete. Alles weg was nicht dem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich entspricht.
			// ----------------------------------------------------------------------
			uf_delete(ds_suplementloadingslist)
			// ----------------------------------------------------------------------
			// Supplement Loadinglist zur Loadinglist kopieren
			// ----------------------------------------------------------------------
			ds_suplementloadingslist.RowsCopy(1, ds_suplementloadingslist.RowCount(), Primary!, ds_loadinglist, ds_loadinglist.RowCount() + 1, Primary!)
			// ----------------------------------------------------------------------
			// Sortierung ds_loadinglist
			// ----------------------------------------------------------------------
			ds_loadinglist.SetSort("cen_galley_nsort A, cen_stowage_nsort A")
			ds_loadinglist.Sort()
			// ----------------------------------------------------------------------
			// Wir wenden die Actioncodes an.
			//	----------------------------------------------------------------------
			uf_actioncode()
			// ----------------------------------------------------------------------
			// Second Delete. Alles weg, was den Actioncodes zum Opfer fiel.
			//	----------------------------------------------------------------------
			uf_delete(ds_loadinglist)
		NEXT
	END IF
	
	// Wenn COMPARE-Schalter gesetzt, die beiden DS ("normal"-Version und PL/SLQ-Version) vergleichen
	IF ls_plsql_switch = "COMPARE" THEN
		uf_compare_plsql(lds_loading_list_result_plsql)
	END IF

	uf_store_loading()
END IF		

lEnde = CPU()
uf_log("Retrieve Loading took " + string((lEnde - lStart)/1000, "0.00") + " seconds!","uf_retrieve")

If IsValid(lds_loading_list_result_plsql) THEN Destroy lds_loading_list_result_plsql

Return ds_loadinglist.Rowcount()

end function

public function boolean uf_store_loading ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_explosion
// Methode: uf_store_loading (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Speichern aktuelle Beladung
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  16.07.2012	1.00			Thomas Brackmann		Erstellung
//  10.06.2013	1.01			Oliver Hoefer  		Umstellung Mandant von 002 auf s_app.smandant
//  2014-07-04	1.02			MHO					Neues Labeldesigner-feld: ctext aus cen_loadinglist_index 
// -----------------------------------------------------------------------------------------------------------------------------------------

Long    		ll_nresult_key
Long    		ll_ntransaction
Long    		ll_nrecord_count
String  		ls_cstowage
String  		ls_cplace
Integer 		li_nsort_stow
Integer 		li_npage
Integer 		li_nxpos
Integer 		li_nypos
String  		ls_cgalley
Integer 		li_nsort_gal
Long    		ll_nequipment_width
Long    		ll_nequipment_height
Long    		ll_nloadinglist_index_key_lo
String  		ls_cpackinglist
String  		ls_cloadinglist
String  		ls_ctext_ll    // MHO 2014-07-04: ctext aus cen_loadinglist_index
String  		ls_ctext_pckl
String  		ls_cunit
Long   		ll_nloadinglist_key
DateTime 	ldt_dvalid_from
DateTime 	ldt_dvalid_to
String   		ls_cfrequency
String   		ls_ctime_from
String   		ls_ctime_to
String   		ls_cclass
String   		ls_cadd_on_text
String   		ls_cactioncode
Integer  		li_nbelly_container
Decimal 		lde_nquantity
Integer 		li_nlabel_quantity
Long    		ll_nlabel_type_key
String  		ls_cmeal_control_code
Long   		ll_nstowage_key
String 		ls_cfontname
Integer 		li_nfontbold
Integer 		li_nfontitalic
Long    		ll_nfontcolor
Long    		ll_nobjectborder
Long    		ll_nobjectcolor
Long    		ll_nobjectbackgroundcolor
Integer 		li_nfontsize
Integer 		li_nobjectlinewidth
Long    		ll_npackinglist_key
String  		ls_ctext_short
Long   		ll_ngalley_key
String 		ls_ctext_stow
Integer 		li_nequipment_resize
Decimal 		lde_nweight_stow
Integer 		li_nfor_to_code
Long    		ll_ntlc_key
String  		ls_ctlc
Long   		ll_npackinglist_index_key
Long   		ll_nloadinglist_detail_key
Long   		ll_nloadinglist_index_key_loi
DateTime 	ldt_dtimestamp_modification
Long     		ll_npackinglist_detail_key
Integer 		li_ngalley_group
Integer 		li_ncatering_leg
Integer 		li_nranking
Integer 		li_nlimit
Integer 		li_nranking_spml
Integer 		li_nlimit_spml
Long    		ll_nreckoning
Decimal 		lde_nweight_pckl
Decimal 		lde_nweight_gal
String  		ls_cclass1
String  		ls_cclass2
String  		ls_cclass3
Long   		ll_npl_kind_key
Integer 		li_nseparator
String  		ls_ccustomer_pl
String  		ls_ccustomer_text
Long   		ll_naccount_key
String 		ls_caccount
Integer 		li_ntransporter_cart
String  		ls_csales_rel
String  		ls_cdef_storage_location
String  		ls_cgoods_recipient
String  		ls_cclass4
String  		ls_cclass5
String  		ls_cclass6
Integer 		li_ncom_actioncode
Integer 		li_ncom_fontheight
Integer 		li_ncom_usefontsize
Integer 		li_ncom_rowprinted
String  		ls_ccom_classname
String  		ls_ccom_zustautext
Integer  		li_ncom_exclude
String  		ls_ccom_qaq_actioncode
String  		ls_ccom_sicodes
Long   		ll_ncom_handling_key
Decimal 		lde_ncom_calcweight
Long    		ll_ncom_nlabel_type
Integer 		li_ncom_nprint
Integer 		li_ncom_labelprinting
Integer 		li_ncom_stationinstruction
Long    		ll_ncom_nworkstationkey
String  		ls_ccom_cworkstation
Long   		ll_ncom_nareakey
String 		ls_ccom_carea
String 		ls_ccom_carea_code
Long   		ll_ncom_npltype
String 		ls_ccom_pldetail_text
String 		ls_ccom_pldetail_label_counter
Long   		ll_ncom_ndistribution_detail_key
Long   		ll_ncom_ndistribution_key
Integer 		li_ncom_nunit_priority
String  		ls_ccom_cdistributed_components
Integer 		li_ncom_nclass_number
Integer 		li_ncom_nremove
String  		ls_ccom_cworkstation_text
Integer 		li_ncom_nduplicated
String  		ls_ccom_cunit_time
Integer 		li_ncom_nmodified
String  		ls_ccom_crampbox
String  		ls_ccom_carea_list
String  		ls_ccom_cws_list
String  		ls_ccom_pldetail_explosion
String  		ls_ccom_pl_to_explode
Integer 		li_ncom_nrowid
Integer 		li_ncom_nramp_box_mode
String  		ls_ccom_crampbox2
String  		ls_ccom_crtn_components

Long			ll_rows
Long			ll_rownum
Long			ll_newrow
Long			ll_result
Long			i

String			ls_save_distrtibution

uo_cbase_DataStore lds_cen_out_md_lo

uo_format_mandant uo_format_mandant

// Erstmal ermitteln, ob die Mahlzeitenverteilung $$HEX1$$fc00$$ENDHEX$$berhaupt gespeichert werden soll ...
//ls_save_distrtibution = uo_format_mandant.of_mandant_profilestring(sqlca,'002','MealDistribution','SaveDistribution','0')
ls_save_distrtibution = uo_format_mandant.of_mandant_profilestring(sqlca, s_app.smandant ,'MealDistribution','SaveDistribution','0')

// Soll gespeichert werden ...
IF ls_save_distrtibution = "1" THEN

	this.uf_log("Storing Loading ...","uf_store_loading")
	
	// DataStores instanzieren ...
	lds_cen_out_md_lo = CREATE uo_cbase_DataStore
	lds_cen_out_md_lo.DataObject = "dw_cen_out_md_lo"
	lds_cen_out_md_lo.SetTransObject(SQLCA)

	// Gibt es zu diesem Flug und dieser Transaction bereits ein gespeichertes Loading ?
	ll_nresult_key	=	THIS.lResultKey
	ll_ntransaction 	=	THIS.lTransaction

	ll_rows 			= 	lds_cen_out_md_lo.Retrieve(ll_nresult_key,ll_ntransaction)
	
	//MB 23.06.2014:
	//Wenn schon vorhanden, dann l$$HEX1$$f600$$ENDHEX$$schen und neu speichern
	if ll_rows > 0 then
		
		for i=ll_rows to 1 step -1
			
			lds_cen_out_md_lo.deleterow(i)
			
		next
		ll_result = lds_cen_out_md_lo.Update()
		
		//Rowcount sollte jetzt 0 sein...
		ll_rows 			= 	lds_cen_out_md_lo.Retrieve(ll_nresult_key,ll_ntransaction)
	end if
	// Nur wenn es noch keine gibt weiter ->
	IF ll_rows = 0 THEN
	
		ll_rownum = 1
		
		DO
			ls_cstowage                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_stowage_cstowage")
			ls_cplace                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cen_stowage_cplace")
			li_nsort_stow                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_nsort")
			li_npage                                 			=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_npage")
			li_nxpos                                 				=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_nxpos")
			li_nypos                                 				=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_nypos")
			ls_cgalley                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cen_galley_cgalley")
			li_nsort_gal                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_galley_nsort")
			ll_nequipment_width                            	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_equipment_nequipment_width")
			ll_nequipment_height                         	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_equipment_nequipment_height")
			ll_nloadinglist_index_key_lo                   	=      ds_loadinglist.GetItemNumber(ll_rownum,"nloadinglist_index_key")
			ls_cpackinglist                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_packinglist_index_cpackinglist")
			ls_cloadinglist                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglist_index_cloadinglist")
			// MHO 2014-07-04: ctext aus cen_loadinglist_index
			ls_ctext_ll                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_out_handling_ctext")
			ls_ctext_pckl                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_packinglists_ctext")
			ls_cunit                                 				=      ds_loadinglist.GetItemString(ll_rownum,"cen_packinglists_cunit")
			ll_nloadinglist_key                                	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglist_index_nloadinglist_key")
			ldt_dvalid_from                                 	=      ds_loadinglist.GetItemDateTime(ll_rownum,"cen_packinglists_dvalid_from")
			ldt_dvalid_to                                 		=      ds_loadinglist.GetItemDateTime(ll_rownum,"cen_packinglists_dvalid_to")
			ls_cfrequency                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_cfrequency")
			ls_ctime_from                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_ctime_from")
			ls_ctime_to                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_ctime_to")
			ls_cclass                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_cclass")
			ls_cadd_on_text                                 	=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_cadd_on_text")
			ls_cactioncode                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_cactioncode")
			li_nbelly_container                              	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglists_nbelly_container")
			lde_nquantity                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglists_nquantity")
			li_nlabel_quantity                                	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglists_nlabel_quantity")
			ll_nlabel_type_key                               	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglists_nlabel_type_key")
			ls_cmeal_control_code                       	=      ds_loadinglist.GetItemString(ll_rownum,"cen_loadinglists_cmeal_control_code")
			ll_nstowage_key                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_nstowage_key")
			ls_cfontname                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_object_schema_cfontname")
			li_nfontbold                                			=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nfontbold")
			li_nfontitalic                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nfontitalic")
			ll_nfontcolor                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nfontcolor")
			ll_nobjectborder                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nobjectborder")
			ll_nobjectcolor                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nobjectcolor")
			ll_nobjectbackgroundcolor           			=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nobjectbackgroundcolor")
			li_nfontsize                                 			=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nfontsize")
			li_nobjectlinewidth                            	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_schema_nobjectlinewidth")
			ll_npackinglist_key                             	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglists_npackinglist_key")
			ls_ctext_short                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_packinglists_ctext_short")
			ll_ngalley_key                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_galley_ngalley_key")
			ls_ctext_stow                                 		=      ds_loadinglist.GetItemString(ll_rownum,"cen_stowage_ctext")
			li_nequipment_resize                          	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_object_equipment_nequipment_resize")
			lde_nweight_stow                               	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_stowage_nweight")
			li_nfor_to_code                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglists_nfor_to_code")
			ll_ntlc_key                                 			=      ds_loadinglist.GetItemNumber(ll_rownum,"forto_ntlc_key")
			ls_ctlc                                 				=      ds_loadinglist.GetItemString(ll_rownum,"sys_three_letter_codes_ctlc")
			ll_npackinglist_index_key                     	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglist_index_npackinglist_index_key")
			ll_nloadinglist_detail_key                      	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglists_nloadinglist_detail_key")
			ll_nloadinglist_index_key_loi     			=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_loadinglist_index_nloadinglist_index_key")
			ldt_dtimestamp_modification               	=      ds_loadinglist.GetItemDateTime(ll_rownum,"cen_loadinglists_dtimestamp_modification")
			ll_npackinglist_detail_key                   	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglists_npackinglist_detail_key")
			li_ngalley_group                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"ngalley_group")
			li_ncatering_leg                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"ncatering_leg")
			li_nranking                                 			=      ds_loadinglist.GetItemNumber(ll_rownum,"nranking")
			li_nlimit                                 				=      ds_loadinglist.GetItemNumber(ll_rownum,"nlimit")
			li_nranking_spml                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"nranking_spml")
			li_nlimit_spml                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"nlimit_spml")
			ll_nreckoning                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"nreckoning")
			lde_nweight_pckl                              	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglists_nweight")
			lde_nweight_gal                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_galley_nweight")
			ls_cclass1                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cclass1")
			ls_cclass2                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cclass2")
			ls_cclass3                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cclass3")
			ll_npl_kind_key                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"cen_packinglist_index_npl_kind_key")
			li_nseparator                                 		=      ds_loadinglist.GetItemNumber(ll_rownum,"nseparator")
			ls_ccustomer_pl                                 	=      ds_loadinglist.GetItemString(ll_rownum,"ccustomer_pl")
			ls_ccustomer_text                               	=      ds_loadinglist.GetItemString(ll_rownum,"ccustomer_text")
			ll_naccount_key                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"naccount_key")
			ls_caccount                                 		=      ds_loadinglist.GetItemString(ll_rownum,"caccount")
			li_ntransporter_cart                              	=      ds_loadinglist.GetItemNumber(ll_rownum,"ntransporter_cart")
			ls_csales_rel                                 		=      ds_loadinglist.GetItemString(ll_rownum,"csales_rel")
			ls_cdef_storage_location                   	=      ds_loadinglist.GetItemString(ll_rownum,"cdef_storage_location")
			ls_cgoods_recipient                            	=      ds_loadinglist.GetItemString(ll_rownum,"cgoods_recipient")
			ls_cclass4                                			=      ds_loadinglist.GetItemString(ll_rownum,"cclass4")
			ls_cclass5                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cclass5")
			ls_cclass6                                 			=      ds_loadinglist.GetItemString(ll_rownum,"cclass6")
			li_ncom_actioncode                              	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_actioncode")
			li_ncom_fontheight                              	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_fontheight")
			li_ncom_usefontsize                            	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_usefontsize")
			li_ncom_rowprinted                             	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_rowprinted")
			ls_ccom_classname                             	=      ds_loadinglist.GetItemString(ll_rownum,"compute_classname")
			ls_ccom_zustautext                              	=      ds_loadinglist.GetItemString(ll_rownum,"compute_zustautext")
			li_ncom_exclude                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_exclude")
			ls_ccom_qaq_actioncode                    	=      ds_loadinglist.GetItemString(ll_rownum,"compute_qaq_actioncode")
			ls_ccom_sicodes                                 	=      ds_loadinglist.GetItemString(ll_rownum,"compute_sicodes")
			ll_ncom_handling_key                         	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_handling_key")
			lde_ncom_calcweight                          	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_calcweight")
			ll_ncom_nlabel_type                            	=      ds_loadinglist.GetItemNumber(ll_rownum,"nlabel_type")
			li_ncom_nprint                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"nprint")
			li_ncom_labelprinting                           	=      ds_loadinglist.GetItemNumber(ll_rownum,"compute_labelprinting")
			li_ncom_stationinstruction                     	=      ds_loadinglist.GetItemNumber(ll_rownum,"stationinstruction")
			ll_ncom_nworkstationkey                       =      ds_loadinglist.GetItemNumber(ll_rownum,"nworkstationkey")
			ls_ccom_cworkstation                           	=      ds_loadinglist.GetItemString(ll_rownum,"cworkstation")
			ll_ncom_nareakey                                	=      ds_loadinglist.GetItemNumber(ll_rownum,"nareakey")
			ls_ccom_carea                                 	=      ds_loadinglist.GetItemString(ll_rownum,"carea")
			ls_ccom_carea_code                            	=      ds_loadinglist.GetItemString(ll_rownum,"carea_code")
			ll_ncom_npltype                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"npltype")
			ls_ccom_pldetail_text                           	=      ds_loadinglist.GetItemString(ll_rownum,"pldetail_text")
			ls_ccom_pldetail_label_counter             	=      ds_loadinglist.GetItemString(ll_rownum,"pldetail_label_counter")
			ll_ncom_ndistribution_detail_key          	=      ds_loadinglist.GetItemNumber(ll_rownum,"ndistribution_detail_key")
			ll_ncom_ndistribution_key                    	=      ds_loadinglist.GetItemNumber(ll_rownum,"ndistribution_key")
			li_ncom_nunit_priority                           =      ds_loadinglist.GetItemNumber(ll_rownum,"nunit_priority")
			ls_ccom_cdistributed_components          =      ds_loadinglist.GetItemString(ll_rownum,"cdistributed_components")
			li_ncom_nclass_number                        	=      ds_loadinglist.GetItemNumber(ll_rownum,"nclass_number")
			li_ncom_nremove                            		=      ds_loadinglist.GetItemNumber(ll_rownum,"nremove")
			ls_ccom_cworkstation_text                  	=      ds_loadinglist.GetItemString(ll_rownum,"cworkstation_text")
			li_ncom_nduplicated                            	=      ds_loadinglist.GetItemNumber(ll_rownum,"nduplicated")
			ls_ccom_cunit_time                              	=      ds_loadinglist.GetItemString(ll_rownum,"cunit_time")
			li_ncom_nmodified                               	=      ds_loadinglist.GetItemNumber(ll_rownum,"nmodified")
			ls_ccom_crampbox                              	=      ds_loadinglist.GetItemString(ll_rownum,"crampbox")
			ls_ccom_carea_list                               	=      ds_loadinglist.GetItemString(ll_rownum,"carea_list")
			ls_ccom_cws_list                                 	=      ds_loadinglist.GetItemString(ll_rownum,"pldetail_explosion")
			ls_ccom_pldetail_explosion               		=      ds_loadinglist.GetItemString(ll_rownum,"pldetail_explosion")
			ls_ccom_pl_to_explode                   		=      ds_loadinglist.GetItemString(ll_rownum,"pl_to_explode")
			li_ncom_nrowid                                 	=      ds_loadinglist.GetItemNumber(ll_rownum,"nrowid")
			li_ncom_nramp_box_mode                	=      ds_loadinglist.GetItemNumber(ll_rownum,"nramp_box_mode")
			ls_ccom_crampbox2                           	=      ds_loadinglist.GetItemString(ll_rownum,"crampbox2")
			ls_ccom_crtn_components                     =      ds_loadinglist.GetItemString(ll_rownum,"crtn_components")
			
			ll_newrow 										= 		lds_cen_out_md_lo.InsertRow(0)					
			
			lds_cen_out_md_lo.SetItem(ll_newrow,"nresult_key",ll_nresult_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ntransaction",ll_ntransaction)

			// aktueller Satzz$$HEX1$$e400$$ENDHEX$$hler ...
			lds_cen_out_md_lo.SetItem(ll_newrow,"nrecord_count",ll_newrow)					
			// ... wird auch in das originale DataStore $$HEX1$$fc00$$ENDHEX$$bernommen.
			ds_loadinglist.SetItem(ll_rownum,"nrecord_count",ll_newrow)					
			
			lds_cen_out_md_lo.SetItem(ll_newrow,"cstowage",ls_cstowage)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cplace",ls_cplace)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nsort_stow",li_nsort_stow)
			lds_cen_out_md_lo.SetItem(ll_newrow,"npage",li_npage)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nxpos",li_nxpos)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nypos",li_nypos)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cgalley",ls_cgalley)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nsort_gal",li_nsort_gal)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nequipment_width",ll_nequipment_width)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nequipment_height",ll_nequipment_height)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nloadinglist_index_key_lo",ll_nloadinglist_index_key_lo)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cpackinglist",ls_cpackinglist)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cloadinglist",ls_cloadinglist)
			// MHO 2014-07-04: ctext aus cen_loadinglist_index
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctext_ll",ls_ctext_ll)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctext_pckl",ls_ctext_pckl)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cunit",ls_cunit)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nloadinglist_key",ll_nloadinglist_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"dvalid_from",ldt_dvalid_from)
			lds_cen_out_md_lo.SetItem(ll_newrow,"dvalid_to",ldt_dvalid_to)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cfrequency",ls_cfrequency)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctime_from",ls_ctime_from)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctime_to",ls_ctime_to)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass",ls_cclass)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cadd_on_text",ls_cadd_on_text)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cactioncode",ls_cactioncode)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nbelly_container",li_nbelly_container)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nquantity",lde_nquantity)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nlabel_quantity",li_nlabel_quantity)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nlabel_type_key",ll_nlabel_type_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cmeal_control_code",ls_cmeal_control_code)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nstowage_key",ll_nstowage_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cfontname",ls_cfontname)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nfontbold",li_nfontbold)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nfontitalic",li_nfontitalic)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nfontcolor",ll_nfontcolor)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nobjectborder",ll_nobjectborder)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nobjectcolor",ll_nobjectcolor)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nobjectbackgroundcolor",ll_nobjectbackgroundcolor)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nfontsize",li_nfontsize)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nobjectlinewidth",li_nobjectlinewidth)
			lds_cen_out_md_lo.SetItem(ll_newrow,"npackinglist_key",ll_npackinglist_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctext_short",ls_ctext_short)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ngalley_key",ll_ngalley_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctext_stow",ls_ctext_stow)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nequipment_resize",li_nequipment_resize)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nweight_stow",lde_nweight_stow)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nfor_to_code",li_nfor_to_code)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ntlc_key",ll_ntlc_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ctlc",ls_ctlc)
			lds_cen_out_md_lo.SetItem(ll_newrow,"npackinglist_index_key",ll_npackinglist_index_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nloadinglist_detail_key",ll_nloadinglist_detail_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nloadinglist_index_key_loi",ll_nloadinglist_index_key_loi)
			lds_cen_out_md_lo.SetItem(ll_newrow,"dtimestamp_modification",ldt_dtimestamp_modification)
			lds_cen_out_md_lo.SetItem(ll_newrow,"npackinglist_detail_key",ll_npackinglist_detail_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ngalley_group",li_ngalley_group)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncatering_leg",li_ncatering_leg)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nranking",li_nranking)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nlimit",li_nlimit)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nranking_spml",li_nranking_spml)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nlimit_spml",li_nlimit_spml)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nreckoning",ll_nreckoning)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nweight_pckl",lde_nweight_pckl)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nweight_gal",lde_nweight_gal)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass1",ls_cclass1)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass2",ls_cclass2)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass3",ls_cclass3)
			lds_cen_out_md_lo.SetItem(ll_newrow,"npl_kind_key",ll_npl_kind_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"nseparator",li_nseparator)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccustomer_pl",ls_ccustomer_pl)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccustomer_text",ls_ccustomer_text)
			lds_cen_out_md_lo.SetItem(ll_newrow,"naccount_key",ll_naccount_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"caccount",ls_caccount)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ntransporter_cart",li_ntransporter_cart)
			lds_cen_out_md_lo.SetItem(ll_newrow,"csales_rel",ls_csales_rel)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cdef_storage_location",ls_cdef_storage_location)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cgoods_recipient",ls_cgoods_recipient)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass4",ls_cclass4)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass5",ls_cclass5)
			lds_cen_out_md_lo.SetItem(ll_newrow,"cclass6",ls_cclass6)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_actioncode",li_ncom_actioncode)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_fontheight",li_ncom_fontheight)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_usefontsize",li_ncom_usefontsize)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_rowprinted",li_ncom_rowprinted)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_classname",ls_ccom_classname)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_zustautext",ls_ccom_zustautext)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_exclude",li_ncom_exclude)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_qaq_actioncode",ls_ccom_qaq_actioncode)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_sicodes",ls_ccom_sicodes)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_handling_key",ll_ncom_handling_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_calcweight",lde_ncom_calcweight)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nlabel_type",ll_ncom_nlabel_type)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nprint",li_ncom_nprint)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_labelprinting",li_ncom_labelprinting)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_stationinstruction",li_ncom_stationinstruction)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nworkstationkey",ll_ncom_nworkstationkey)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_cworkstation",ls_ccom_cworkstation)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nareakey",ll_ncom_nareakey)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_carea",ls_ccom_carea)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_carea_code",ls_ccom_carea_code)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_npltype",ll_ncom_npltype)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_pldetail_text",ls_ccom_pldetail_text)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_pldetail_label_counter",ls_ccom_pldetail_label_counter)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_ndistribution_detail_key",ll_ncom_ndistribution_detail_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_ndistribution_key",ll_ncom_ndistribution_key)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nunit_priority",li_ncom_nunit_priority)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_cdistributed_components",ls_ccom_cdistributed_components)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nclass_number",li_ncom_nclass_number)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nremove",li_ncom_nremove)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_cworkstation_text",ls_ccom_cworkstation_text)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nduplicated",li_ncom_nduplicated)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_cunit_time",ls_ccom_cunit_time)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nmodified",li_ncom_nmodified)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_crampbox",ls_ccom_crampbox)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_carea_list",ls_ccom_carea_list)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_cws_list",ls_ccom_cws_list)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_pldetail_explosion",ls_ccom_pldetail_explosion)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_pl_to_explode",ls_ccom_pl_to_explode)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nrowid",li_ncom_nrowid)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ncom_nramp_box_mode",li_ncom_nramp_box_mode)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_crampbox2",ls_ccom_crampbox2)
			lds_cen_out_md_lo.SetItem(ll_newrow,"ccom_crtn_components",ls_ccom_crtn_components)			
			
			ll_rownum = ll_rownum + 1
		
		LOOP UNTIL ll_rownum > ds_loadinglist.RowCount()
					
	END IF
	
	ll_result = lds_cen_out_md_lo.Update()
	
	DESTROY lds_cen_out_md_lo
			
	COMMIT;
		
END IF

RETURN TRUE
end function

public function boolean uf_restore_loading ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_explosion
// Methode: of_restore_loading (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Reset aktuelle Beladung aus DB
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  16.07.2012	1.00			Thomas Brackmann		Erstellung
//  10.06.2013	1.01			Oliver Hoefer  		Umstellung Mandant von 002 auf s_app.smandant
//  2014-07-04	1.02			MHO					Neues Labeldesigner-feld: ctext aus cen_loadinglist_index 
// -----------------------------------------------------------------------------------------------------------------------------------------

Long			ll_rows
Long			ll_rownum
Long			ll_newrow
Long			ll_nresult_key	
Long			ll_ntransaction

Long    		ll_nrecord_count
String  		ls_cstowage
String  		ls_cplace
Integer 		li_nsort_stow
Integer 		li_npage
Integer 		li_nxpos
Integer 		li_nypos
String  		ls_cgalley
Integer 		li_nsort_gal
Long    		ll_nequipment_width
Long    		ll_nequipment_height
Long    		ll_nloadinglist_index_key_lo
String  		ls_cpackinglist
String  		ls_cloadinglist
String  		ls_ctext_ll    // MHO 2014-07-04: ctext aus cen_loadinglist_index
String  		ls_ctext_pckl
String  		ls_cunit
Long   		ll_nloadinglist_key
DateTime 	ldt_dvalid_from
DateTime 	ldt_dvalid_to
String   		ls_cfrequency
String   		ls_ctime_from
String   		ls_ctime_to
String   		ls_cclass
String   		ls_cadd_on_text
String   		ls_cactioncode
Integer  		li_nbelly_container
Decimal 		lde_nquantity
Integer 		li_nlabel_quantity
Long    		ll_nlabel_type_key
String  		ls_cmeal_control_code
Long   		ll_nstowage_key
String 		ls_cfontname
Integer 		li_nfontbold
Integer 		li_nfontitalic
Long    		ll_nfontcolor
Long    		ll_nobjectborder
Long    		ll_nobjectcolor
Long    		ll_nobjectbackgroundcolor
Integer 		li_nfontsize
Integer 		li_nobjectlinewidth
Long    		ll_npackinglist_key
String  		ls_ctext_short
Long   		ll_ngalley_key
String 		ls_ctext_stow
Integer 		li_nequipment_resize
Decimal 		lde_nweight_stow
Integer 		li_nfor_to_code
Long    		ll_ntlc_key
String  		ls_ctlc
Long   		ll_npackinglist_index_key
Long   		ll_nloadinglist_detail_key
Long   		ll_nloadinglist_index_key_loi
DateTime 	ldt_dtimestamp_modification
Long     		ll_npackinglist_detail_key
Integer 		li_ngalley_group
Integer 		li_ncatering_leg
Integer 		li_nranking
Integer 		li_nlimit
Integer 		li_nranking_spml
Integer 		li_nlimit_spml
Long    		ll_nreckoning
Decimal 		lde_nweight_pckl
Decimal 		lde_nweight_gal
String  		ls_cclass1
String  		ls_cclass2
String  		ls_cclass3
Long   		ll_npl_kind_key
Integer 		li_nseparator
String  		ls_ccustomer_pl
String  		ls_ccustomer_text
Long   		ll_naccount_key
String 		ls_caccount
Integer 		li_ntransporter_cart
String  		ls_csales_rel
String  		ls_cdef_storage_location
String  		ls_cgoods_recipient
String  		ls_cclass4
String  		ls_cclass5
String  		ls_cclass6
Integer 		li_ncom_actioncode
Integer 		li_ncom_fontheight
Integer 		li_ncom_usefontsize
Integer 		li_ncom_rowprinted
String  		ls_ccom_classname
String  		ls_ccom_zustautext
Integer  		li_ncom_exclude
String  		ls_ccom_qaq_actioncode
String  		ls_ccom_sicodes
Long   		ll_ncom_handling_key
Decimal 		lde_ncom_calcweight
Long    		ll_ncom_nlabel_type
Integer 		li_ncom_nprint
Integer 		li_ncom_labelprinting
Integer 		li_ncom_stationinstruction
Long    		ll_ncom_nworkstationkey
String  		ls_ccom_cworkstation
Long   		ll_ncom_nareakey
String 		ls_ccom_carea
String 		ls_ccom_carea_code
Long   		ll_ncom_npltype
String 		ls_ccom_pldetail_text
String 		ls_ccom_pldetail_label_counter
Long   		ll_ncom_ndistribution_detail_key
Long   		ll_ncom_ndistribution_key
Integer 		li_ncom_nunit_priority
String  		ls_ccom_cdistributed_components
Integer 		li_ncom_nclass_number
Integer 		li_ncom_nremove
String  		ls_ccom_cworkstation_text
Integer 		li_ncom_nduplicated
String  		ls_ccom_cunit_time
Integer 		li_ncom_nmodified
String  		ls_ccom_crampbox
String  		ls_ccom_carea_list
String  		ls_ccom_cws_list
String  		ls_ccom_pldetail_explosion
String  		ls_ccom_pl_to_explode
Integer 		li_ncom_nrowid
Integer 		li_ncom_nramp_box_mode
String  		ls_ccom_crampbox2
String  		ls_ccom_crtn_components
long			lrecord_count

String		ls_save_distrtibution

DataStore lds_cen_out_md_lo

uo_format_mandant 			uo_format_mandant

// Erstmal ermitteln, ob die Mahlzeitenverteilung $$HEX1$$fc00$$ENDHEX$$berhaupt gespeichert werden soll ...
ls_save_distrtibution = uo_format_mandant.of_mandant_profilestring(sqlca, s_app.smandant ,'MealDistribution','SaveDistribution','0')

// Soll gespeichert werden ...
IF ls_save_distrtibution = "1" THEN

	// DataStore instanzieren ...
	lds_cen_out_md_lo = CREATE DataStore
	lds_cen_out_md_lo.DataObject = "dw_cen_out_md_lo"
	lds_cen_out_md_lo.SetTransObject(SQLCA)

	ll_nresult_key	=	THIS.lResultKey
	ll_ntransaction 	=	THIS.lTransaction

	// Erst mal sehen ob in der DB $$HEX1$$fc00$$ENDHEX$$berhaupt was zu diesem Flug ist ...
	ll_rows = lds_cen_out_md_lo.Retrieve(ll_nresult_key,ll_ntransaction)
	
	// Nur wenn es etwas gibt weiter -> Daten f$$HEX1$$fc00$$ENDHEX$$r Array-Instance-Variablen aus DataStore einlesen ...
	IF ll_rows > 0 THEN
	
		this.uf_log("Restoring Loading ...","uf_restore_loading")		
		
		// DataStore reseten ...
		ds_loadinglist.Reset()					

		// Array initialisieren ...
		
		ll_rownum 		= 	1
		
		DO
	
			// Lesen ...
			ll_nresult_key  							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nresult_key")
			ll_ntransaction 							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ntransaction")
			lrecord_count      							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nrecord_count")
			ls_cstowage     						=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cstowage")
			ls_cplace       							=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cplace")
			li_nsort_stow  		 					=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nsort_stow")
			li_npage        							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"npage")
			li_nxpos        							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nxpos")
			li_nypos        							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nypos")
			ls_cgalley      							=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cgalley")
			li_nsort_gal    							=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nsort_gal")
			ll_nequipment_width   				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nequipment_width")
			ll_nequipment_height  				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nequipment_height")
			ll_nloadinglist_index_key_lo  		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nloadinglist_index_key_lo")
			ls_cpackinglist               				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cpackinglist")
			ls_cloadinglist               				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cloadinglist")
			// MHO 2014-07-04: ctext aus cen_loadinglist_index
			ls_ctext_ll                 				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctext_ll")

			ls_ctext_pckl                 				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctext_pckl")
			ls_cunit                      				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cunit")
			ll_nloadinglist_key           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nloadinglist_key")
			ldt_dvalid_from               			=			lds_cen_out_md_lo.GetItemDateTime(ll_rownum,"dvalid_from")
			ldt_dvalid_to                 				=			lds_cen_out_md_lo.GetItemDateTime(ll_rownum,"dvalid_to")
			ls_cfrequency                 			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cfrequency")
			ls_ctime_from                 			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctime_from")
			ls_ctime_to                   				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctime_to")
			ls_cclass                     				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass")
			ls_cadd_on_text               			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cadd_on_text")
			ls_cactioncode                			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cactioncode")
			li_nbelly_container           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nbelly_container")
			lde_nquantity                 			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nquantity")
			li_nlabel_quantity            			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nlabel_quantity")
			ll_nlabel_type_key            			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nlabel_type_key")
			ls_cmeal_control_code         		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cmeal_control_code")
			ll_nstowage_key               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nstowage_key")
			ls_cfontname                  			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cfontname")
			li_nfontbold                  				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nfontbold")
			li_nfontitalic                				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nfontitalic")
			ll_nfontcolor                 				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nfontcolor")
			ll_nobjectborder              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nobjectborder")
			ll_nobjectcolor               				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nobjectcolor")
			ll_nobjectbackgroundcolor     		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nobjectbackgroundcolor")
			li_nfontsize                  				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nfontsize")
			li_nobjectlinewidth           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nobjectlinewidth")
			ll_npackinglist_key           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"npackinglist_key")
			ls_ctext_short                				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctext_short")
			ll_ngalley_key                				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ngalley_key")
			ls_ctext_stow                 			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctext_stow")
			li_nequipment_resize          			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nequipment_resize")
			lde_nweight_stow              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nweight_stow")
			li_nfor_to_code               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nfor_to_code")
			ll_ntlc_key                   				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ntlc_key")
			ls_ctlc                       				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ctlc")
			ll_npackinglist_index_key     		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"npackinglist_index_key")
			ll_nloadinglist_detail_key    			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nloadinglist_detail_key")
			ll_nloadinglist_index_key_loi 		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nloadinglist_index_key_loi")
			ldt_dtimestamp_modification   		=			lds_cen_out_md_lo.GetItemDateTime(ll_rownum,"dtimestamp_modification")
			ll_npackinglist_detail_key    			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"npackinglist_detail_key")
			li_ngalley_group              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ngalley_group")
			li_ncatering_leg              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncatering_leg")
			li_nranking                   				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nranking")
			li_nlimit                     				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nlimit")
			li_nranking_spml              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nranking_spml")
			li_nlimit_spml                				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nlimit_spml")
			ll_nreckoning                 				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nreckoning")
			lde_nweight_pckl              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nweight_pckl")
			lde_nweight_gal               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nweight_gal")
			ls_cclass1                    				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass1")
			ls_cclass2                    				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass2")
			ls_cclass3                    				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass3")
			ll_npl_kind_key               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"npl_kind_key")
			li_nseparator                 				=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"nseparator")
			ls_ccustomer_pl               			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccustomer_pl")
			ls_ccustomer_text             			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccustomer_text")
			ll_naccount_key               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"naccount_key")
			ls_caccount                   				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"caccount")
			li_ntransporter_cart          			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ntransporter_cart")
			ls_csales_rel                 				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"csales_rel")
			ls_cdef_storage_location     			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cdef_storage_location")
			ls_cgoods_recipient           			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cgoods_recipient")
			ls_cclass4                    				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass4")
			ls_cclass5                    				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass5")
			ls_cclass6                   				=			lds_cen_out_md_lo.GetItemString(ll_rownum,"cclass6")
			li_ncom_actioncode            			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_actioncode")
			li_ncom_fontheight            			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_fontheight")
			li_ncom_usefontsize           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_usefontsize")
			li_ncom_rowprinted            			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_rowprinted")
			ls_ccom_classname             		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_classname")
			ls_ccom_zustautext            			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_zustautext")
			li_ncom_exclude               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_exclude")
			ls_ccom_qaq_actioncode        		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_qaq_actioncode")
			ls_ccom_sicodes               			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_sicodes")
			ll_ncom_handling_key          		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_handling_key")
			lde_ncom_calcweight           		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_calcweight")
			ll_ncom_nlabel_type           			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nlabel_type")
			li_ncom_nprint                			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nprint")
			li_ncom_labelprinting         			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_labelprinting")
			li_ncom_stationinstruction    		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_stationinstruction")
			ll_ncom_nworkstationkey       		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nworkstationkey")
			ls_ccom_cworkstation          		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_cworkstation")
			ll_ncom_nareakey              			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nareakey")
			ls_ccom_carea                 			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_carea")
			ls_ccom_carea_code            		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_carea_code")
			ll_ncom_npltype               			=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_npltype")
			ls_ccom_pldetail_text         			=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_pldetail_text")
			ls_ccom_pldetail_label_counter    	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_pldetail_label_counter")
			ll_ncom_ndistribution_detail_key  	=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_ndistribution_detail_key")
			ll_ncom_ndistribution_key         	=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_ndistribution_key")
			li_ncom_nunit_priority            		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nunit_priority")
			ls_ccom_cdistributed_components   =		lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_cdistributed_components")
			li_ncom_nclass_number             	=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nclass_number")
			li_ncom_nremove                   		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nremove")
			ls_ccom_cworkstation_text         	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_cworkstation_text")
			// 19.03. 4.92 Error Label x von Y
			//li_ncom_nduplicated               		=		lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nduplicated")
			li_ncom_nduplicated               		=	0
			ls_ccom_cunit_time                		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_cunit_time")
			li_ncom_nmodified                		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nmodified")
			ls_ccom_crampbox                  	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_crampbox")
			ls_ccom_carea_list                		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_carea_list")
			ls_ccom_cws_list                  		=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_cws_list")
			ls_ccom_pldetail_explosion        	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_pldetail_explosion")
			ls_ccom_pl_to_explode             	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_pl_to_explode")
			li_ncom_nrowid                    		=			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nrowid")
			li_ncom_nramp_box_mode           =			lds_cen_out_md_lo.GetItemNumber(ll_rownum,"ncom_nramp_box_mode")
			ls_ccom_crampbox2                 	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_crampbox2")
			ls_ccom_crtn_components 		  	=			lds_cen_out_md_lo.GetItemString(ll_rownum,"ccom_crtn_components")

			// Insert ...
			ll_newrow								=			ds_loadinglist.InsertRow(0)					

			// Schreiben ...
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_cstowage",ls_cstowage)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_cplace",ls_cplace)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_nsort",li_nsort_stow)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_npage",li_npage)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_nxpos",li_nxpos)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_nypos",li_nypos)
			ds_loadinglist.SetItem(ll_newrow,"cen_galley_cgalley",ls_cgalley)
			ds_loadinglist.SetItem(ll_newrow,"cen_galley_nsort",li_nsort_gal)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_equipment_nequipment_width",ll_nequipment_width)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_equipment_nequipment_height",ll_nequipment_height)
			ds_loadinglist.SetItem(ll_newrow,"nloadinglist_index_key",ll_nloadinglist_index_key_lo)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglist_index_cpackinglist",ls_cpackinglist)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglist_index_cloadinglist",ls_cloadinglist)
			// MHO 2014-07-04: ctext aus cen_loadinglist_index
			ds_loadinglist.SetItem(ll_newrow,"cen_out_handling_ctext",ls_ctext_ll)
			
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_ctext",ls_ctext_pckl)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_cunit",ls_cunit)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglist_index_nloadinglist_key",ll_nloadinglist_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_dvalid_from",ldt_dvalid_from)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_dvalid_to",ldt_dvalid_to)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_cfrequency",ls_cfrequency)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_ctime_from",ls_ctime_from)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_ctime_to",ls_ctime_to)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_cclass",ls_cclass)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_cadd_on_text",ls_cadd_on_text)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_cactioncode",ls_cactioncode)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_nbelly_container",li_nbelly_container)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_nquantity",lde_nquantity)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_nlabel_quantity",li_nlabel_quantity)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_nlabel_type_key",ll_nlabel_type_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_cmeal_control_code",ls_cmeal_control_code)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_nstowage_key",ll_nstowage_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_cfontname",ls_cfontname)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nfontbold",li_nfontbold)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nfontitalic",li_nfontitalic)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nfontcolor",ll_nfontcolor)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nobjectborder",ll_nobjectborder)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nobjectcolor",ll_nobjectcolor)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nobjectbackgroundcolor",ll_nobjectbackgroundcolor)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nfontsize",li_nfontsize)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_schema_nobjectlinewidth",li_nobjectlinewidth)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_npackinglist_key",ll_npackinglist_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_ctext_short",ls_ctext_short)
			ds_loadinglist.SetItem(ll_newrow,"cen_galley_ngalley_key",ll_ngalley_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_ctext",ls_ctext_stow)
			ds_loadinglist.SetItem(ll_newrow,"cen_object_equipment_nequipment_resize",li_nequipment_resize)
			ds_loadinglist.SetItem(ll_newrow,"cen_stowage_nweight",lde_nweight_stow)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_nfor_to_code",li_nfor_to_code)
			ds_loadinglist.SetItem(ll_newrow,"forto_ntlc_key",ll_ntlc_key)
			ds_loadinglist.SetItem(ll_newrow,"sys_three_letter_codes_ctlc",ls_ctlc)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglist_index_npackinglist_index_key",ll_npackinglist_index_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_nloadinglist_detail_key",ll_nloadinglist_detail_key)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglist_index_nloadinglist_index_key",ll_nloadinglist_index_key_loi)
			ds_loadinglist.SetItem(ll_newrow,"cen_loadinglists_dtimestamp_modification",ldt_dtimestamp_modification)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_npackinglist_detail_key",ll_npackinglist_detail_key)
			ds_loadinglist.SetItem(ll_newrow,"ngalley_group",li_ngalley_group)
			ds_loadinglist.SetItem(ll_newrow,"ncatering_leg",li_ncatering_leg)
			ds_loadinglist.SetItem(ll_newrow,"nranking",li_nranking)
			ds_loadinglist.SetItem(ll_newrow,"nlimit",li_nlimit)
			ds_loadinglist.SetItem(ll_newrow,"nranking_spml",li_nranking_spml)
			ds_loadinglist.SetItem(ll_newrow,"nlimit_spml",li_nlimit_spml)
			ds_loadinglist.SetItem(ll_newrow,"nreckoning",ll_nreckoning)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglists_nweight",lde_nweight_pckl)
			ds_loadinglist.SetItem(ll_newrow,"cen_galley_nweight",lde_nweight_gal)
			ds_loadinglist.SetItem(ll_newrow,"cclass1",ls_cclass1)
			ds_loadinglist.SetItem(ll_newrow,"cclass2",ls_cclass2)
			ds_loadinglist.SetItem(ll_newrow,"cclass3",ls_cclass3)
			ds_loadinglist.SetItem(ll_newrow,"cen_packinglist_index_npl_kind_key",ll_npl_kind_key)
			ds_loadinglist.SetItem(ll_newrow,"nseparator",li_nseparator)
			ds_loadinglist.SetItem(ll_newrow,"ccustomer_pl",ls_ccustomer_pl)
			ds_loadinglist.SetItem(ll_newrow,"ccustomer_text",ls_ccustomer_text)
			ds_loadinglist.SetItem(ll_newrow,"naccount_key",ll_naccount_key)
			ds_loadinglist.SetItem(ll_newrow,"caccount",ls_caccount)
			ds_loadinglist.SetItem(ll_newrow,"ntransporter_cart",li_ntransporter_cart)
			ds_loadinglist.SetItem(ll_newrow,"csales_rel",ls_csales_rel)
			ds_loadinglist.SetItem(ll_newrow,"cdef_storage_location",ls_cdef_storage_location)
			ds_loadinglist.SetItem(ll_newrow,"cgoods_recipient",ls_cgoods_recipient)
			ds_loadinglist.SetItem(ll_newrow,"cclass4",ls_cclass4)
			ds_loadinglist.SetItem(ll_newrow,"cclass5",ls_cclass5)
			ds_loadinglist.SetItem(ll_newrow,"cclass6",ls_cclass6)
			ds_loadinglist.SetItem(ll_newrow,"compute_actioncode",li_ncom_actioncode)
			ds_loadinglist.SetItem(ll_newrow,"compute_fontheight",li_ncom_fontheight)
			ds_loadinglist.SetItem(ll_newrow,"compute_usefontsize",li_ncom_usefontsize)
			ds_loadinglist.SetItem(ll_newrow,"compute_rowprinted",li_ncom_rowprinted)
			ds_loadinglist.SetItem(ll_newrow,"compute_classname",ls_ccom_classname)
			ds_loadinglist.SetItem(ll_newrow,"compute_zustautext",ls_ccom_zustautext)
			ds_loadinglist.SetItem(ll_newrow,"compute_exclude",li_ncom_exclude)
			ds_loadinglist.SetItem(ll_newrow,"compute_qaq_actioncode",ls_ccom_qaq_actioncode)
			ds_loadinglist.SetItem(ll_newrow,"compute_sicodes",ls_ccom_sicodes)
			ds_loadinglist.SetItem(ll_newrow,"compute_handling_key",ll_ncom_handling_key)
			ds_loadinglist.SetItem(ll_newrow,"compute_calcweight",lde_ncom_calcweight)
			ds_loadinglist.SetItem(ll_newrow,"nlabel_type",ll_ncom_nlabel_type)
			ds_loadinglist.SetItem(ll_newrow,"nprint",li_ncom_nprint)
			ds_loadinglist.SetItem(ll_newrow,"compute_labelprinting",li_ncom_labelprinting)
			ds_loadinglist.SetItem(ll_newrow,"stationinstruction",li_ncom_stationinstruction)
			ds_loadinglist.SetItem(ll_newrow,"nworkstationkey",ll_ncom_nworkstationkey)
			ds_loadinglist.SetItem(ll_newrow,"cworkstation",ls_ccom_cworkstation)
			ds_loadinglist.SetItem(ll_newrow,"nareakey",ll_ncom_nareakey)
			ds_loadinglist.SetItem(ll_newrow,"carea",ls_ccom_carea)
			ds_loadinglist.SetItem(ll_newrow,"carea_code",ls_ccom_carea_code)
			ds_loadinglist.SetItem(ll_newrow,"npltype",ll_ncom_npltype)
			ds_loadinglist.SetItem(ll_newrow,"pldetail_text",ls_ccom_pldetail_text)
			ds_loadinglist.SetItem(ll_newrow,"pldetail_label_counter",ls_ccom_pldetail_label_counter)
			ds_loadinglist.SetItem(ll_newrow,"ndistribution_detail_key",ll_ncom_ndistribution_detail_key)
			ds_loadinglist.SetItem(ll_newrow,"ndistribution_key",ll_ncom_ndistribution_key)
			ds_loadinglist.SetItem(ll_newrow,"nunit_priority",li_ncom_nunit_priority)
			ds_loadinglist.SetItem(ll_newrow,"cdistributed_components",ls_ccom_cdistributed_components)
			ds_loadinglist.SetItem(ll_newrow,"nclass_number",li_ncom_nclass_number)
			ds_loadinglist.SetItem(ll_newrow,"nremove",li_ncom_nremove)
			ds_loadinglist.SetItem(ll_newrow,"cworkstation_text",ls_ccom_cworkstation_text)
			ds_loadinglist.SetItem(ll_newrow,"nduplicated",li_ncom_nduplicated)
			ds_loadinglist.SetItem(ll_newrow,"cunit_time",ls_ccom_cunit_time)
			ds_loadinglist.SetItem(ll_newrow,"nmodified",li_ncom_nmodified)
			ds_loadinglist.SetItem(ll_newrow,"crampbox",ls_ccom_crampbox)
			ds_loadinglist.SetItem(ll_newrow,"carea_list",ls_ccom_carea_list)
			ds_loadinglist.SetItem(ll_newrow,"pldetail_explosion",ls_ccom_cws_list)
			ds_loadinglist.SetItem(ll_newrow,"pldetail_explosion",ls_ccom_pldetail_explosion)
			ds_loadinglist.SetItem(ll_newrow,"pl_to_explode",ls_ccom_pl_to_explode)
			ds_loadinglist.SetItem(ll_newrow,"nrowid",li_ncom_nrowid)
			ds_loadinglist.SetItem(ll_newrow,"nramp_box_mode",li_ncom_nramp_box_mode)
			ds_loadinglist.SetItem(ll_newrow,"crampbox2",ls_ccom_crampbox2)
			ds_loadinglist.SetItem(ll_newrow,"crtn_components",ls_ccom_crtn_components)
			ds_loadinglist.SetItem(ll_newrow,"nrecord_count",lrecord_count)

			ll_rownum = ll_rownum + 1
			
		LOOP UNTIL ll_rownum > ll_rows

	ELSE // IF ll_rows_1 > 0 ...
		
		// Also keine Mahlzeitenverteilung aus der Sicherung gefunden => Raus ...
		DESTROY lds_cen_out_md_lo
		RETURN FALSE
		
	END IF
	
	DESTROY lds_cen_out_md_lo


ELSE // IF ls_save_distrtibution = "1" ...
	
	// Also keine Mahlzeitenverteilung aus der Sicherung => Raus ...
	RETURN FALSE
	
END IF

RETURN TRUE
end function

public function integer uf_log (string smsg, string sfunction);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------
integer iFile
if isnull(is_logFile) then
	iFile = FileOpen(this.sLogPath + "cbase_explosion.log", LineMode!, Write!, Shared!)
else
	iFile = FileOpen(this.is_logFile, LineMode!, Write!, Shared!)// 07.09.2012 HR:
end if

FileWrite(iFile,  "0,0," + string(today(),"YYYY-MM-DD") + "," + string(now(), "hh:mm:ss") + ",[" +sfunction + "] " + sMsg)
FileClose(iFile)

return 0

end function

public function integer uf_compare_plsql (uo_cbase_datastore ids_loading_list_result_plsql);Long			ll_row
String			ls_tracedir
String			ls_zustautext1
String			ls_zustautext1_array[]
String			ls_zustautext2
String			ls_zustautext2_array[]
Boolean		lb_diff
Integer		li_j
Integer		li_i
n_string		lnv_string


// Trace-Directory holen
ls_tracedir = ProfileString ("cbase.ini", "TRACE", "DIRECTORY", "c:\")
IF Right(ls_tracedir, 1) <> "\" THEN ls_tracedir = ls_tracedir + "\"

// F$$HEX1$$fc00$$ENDHEX$$r gleiche Sortierung in den beiden DS sorgen
ids_loading_list_result_plsql.Sort()
ds_loadinglist.SetSort("cen_galley_nsort A, cen_stowage_nsort A, cen_loadinglist_index_nloadinglist_key A, cen_loadinglist_index_cloadinglist A, cen_packinglist_index_cpackinglist A, cen_loadinglists_nloadinglist_detail_key A")
ds_loadinglist.Sort()

// Vergleichen
IF ids_loading_list_result_plsql.RowCount() <> ds_loadinglist.RowCount() THEN
	// RowCount stimmt schon nicht -> Meldung
	ids_loading_list_result_plsql.saveas(ls_tracedir + String(lResultKey) + "loadinglists_plsql.xls", Excel8!, True)
	ds_loadinglist.saveas(ls_tracedir + String(lResultKey) + "loadinglists.xls", Excel8!, True)
	MessageBox("Achtung", "Different Rowcount")
ELSE
	// Columns vergleichen
	FOR ll_row = 1 TO ids_loading_list_result_plsql.RowCount()
		FOR li_j = 1 TO Integer(ids_loading_list_result_plsql.Object.Datawindow.Column.Count)
			IF li_j = 111 THEN CONTINUE		// Column nrowid darf unterschiedlich sein
			IF ids_loading_list_result_plsql.Object.Data[ll_row, li_j] <> ds_loadinglist.Object.Data[ll_row, li_j] THEN
				lb_diff = True
				IF li_j = 49 THEN		// Zustautext k$$HEX1$$f600$$ENDHEX$$nnte anders konkateniert sein. Das w$$HEX1$$e400$$ENDHEX$$re nicht als Fehler zu bewerten
					ls_zustautext1 = String(ds_loadinglist.Object.Data[ll_row, li_j])
					ls_zustautext2 = String(ids_loading_list_result_plsql.Object.Data[ll_row, li_j])
					lnv_string = Create n_string
					lnv_string.of_String2Array(ls_zustautext1, "~r~n", ls_zustautext1_array)
					lnv_string.of_String2Array(ls_zustautext2, "~r~n", ls_zustautext2_array)
					FOR li_i = 1 TO UpperBound(ls_zustautext1_array)
						ls_zustautext1_array[li_i] = Trim(ls_zustautext1_array[li_i])
					NEXT
					FOR li_i = 1 TO UpperBound(ls_zustautext2_array)
						ls_zustautext2_array[li_i] = Trim(ls_zustautext2_array[li_i])
					NEXT
					// in der pb-Version wird, wenn es mehrere Suppl. LLs gibt, der Zustautext doppelt konkateniert. Dies soll auch nicht als Fehler interpretiert werden.
					// Also einfach schauen, ob alle Eintrag im einen auch im anderen gefunden werden und umgekehrt
					lb_diff = false
					FOR li_i = 1 TO UpperBound(ls_zustautext1_array)
						IF lnv_string.of_Get_ArrayIndex(ls_zustautext2_array, ls_zustautext1_array[li_i]) = -1 THEN
							lb_diff = True
						END IF
					NEXT
					FOR li_i = 1 TO UpperBound(ls_zustautext2_array)
						IF lnv_string.of_Get_ArrayIndex(ls_zustautext1_array, ls_zustautext2_array[li_i]) = -1 THEN
							lb_diff = True
						END IF
					NEXT
					Destroy n_string
				END IF
				IF lb_diff THEN
					ids_loading_list_result_plsql.saveas(ls_tracedir + String(lResultKey) + "loadinglists_plsql.xls", Excel8!, True)
					ds_loadinglist.saveas(ls_tracedir + String(lResultKey) + "loadinglists.xls", Excel8!, True)
					MessageBox("Achtung", "Different Contents in Row " + String(ll_row) + ", Column " + String(li_j))
				END IF
			END IF
		NEXT
	NEXT
END IF

Return 0

end function

on uo_flight_explosion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_flight_explosion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// -------------------------------------
// Datastore mit Packinglists
// -------------------------------------
	ds_loadinglist					= create DataStore 
	ds_loadinglist.dataobject 	= "dw_loading_list_result"
	ds_loadinglist.Settransobject(SQLCA)
	
	ds_suplementloadingslist	= create DataStore 
	ds_suplementloadingslist.dataobject 	= "dw_loading_list_result"
	ds_suplementloadingslist.Settransobject(SQLCA)
	
	this.sLogPath 	= f_gettemppath()	
end event

event destructor;destroy(ds_loadinglist)
destroy(ds_suplementloadingslist)

end event

