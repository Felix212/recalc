HA$PBExportHeader$uo_suppl_unit_status_release.sru
$PBExportComments$Userobjekt zur Ermittlung der Status $$HEX1$$e400$$ENDHEX$$nderungen/Freigaben anhand der Lieferanteneinstellungen~r~n~r~n- Preis~r~n- Abrechnungscodes~r~n- Breakdowncode~r~n- etc...
forward
global type uo_suppl_unit_status_release from nonvisualobject
end type
end forward

global type uo_suppl_unit_status_release from nonvisualobject
end type
global uo_suppl_unit_status_release uo_suppl_unit_status_release

type variables
//----------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bergabewerte
//----------------------------------------
Integer		itype					// 1 = Flugereignis, 2=Periodenereignis
Long			lCustomer 	 		// Der AirlineCode
Datetime		dtDate				// Flugdatum/Belegdatum
String			sUnit 		 			// Der Betrieb
Datetime		dtToday				// sollte mit Today() initialisiert werden, es sei denn es wird ein anderes Datum simuliert


//----------------------------------------
//$$HEX1$$dc00$$ENDHEX$$bergabe-/R$$HEX1$$fc00$$ENDHEX$$ckgabewerte
//----------------------------------------
Boolean					b_nstatus							// True falls i_nstatus gesetzt wurde (nur R$$HEX1$$fc00$$ENDHEX$$ckgabe)
Integer					i_nstatus								// Abrechnungsstatus
Boolean					b_nstatus_release					// True falls i_nstatus_release gesetzt wurde (nur R$$HEX1$$fc00$$ENDHEX$$ckgabe)
Integer					i_nstatus_release					// Freigabestatus
constant integer		i_Status_Release_Pax = 5    	// Freigabe Paxe durch Station
constant integer		i_Status_Release_Flight = 10 	// Freigabe Flug  durch IFMS
//----------------------------------------
//R$$HEX1$$fc00$$ENDHEX$$ckgabewerte
//----------------------------------------

Boolean					b_nqueued_release_interface	// True falls i_nqueued_release_interface gesetzt wurde
Integer					i_nqueued_release_interface	// Freigabestatus
constant integer		i_nqueued_release_ifms = 1    	// Warten auf Freigabe IFMS
constant integer		i_nqueued_interface = 2			// Warten auf zentrale Schnittstellenerstellung
constant integer		i_nqueued_release_stat = 6   	// Warten auf Freigabe Station
constant integer		i_Status_Queued_Errors = 3 		// Warten auf Fehlerbehebung
constant integer		i_Status_Queued_Web_PaxCalc = 4			// Warten auf Neuberechnung nach Pax$$HEX1$$e400$$ENDHEX$$nderung aus Web
constant integer		i_Status_Queued_Web_MasterChange = 5	// Warten auf Neuberechnung nach Flug/AC-$$HEX1$$c400$$ENDHEX$$nderung aus Web

Boolean					b_nstatus_auto_release				// True falls i_nstatus_auto_release gesetzt wurde
Integer					i_nstatus_auto_release				// 1=automatische Freigabe, 0=sonst

Boolean					b_nstatus_auto_billing				// True falls i_nstatus_auto_billing gesetzt wurde
Integer					i_nstatus_auto_billing					// 1=automatische Abrechnung, 0=sonst

Boolean					b_release_date							// True falls dt_release_date gesetzt wurde
Datetime					dt_release_date						// Datum der Freigabe

//----------------------------------------
// Lieferantenstamm-Einstellungen
//----------------------------------------
Boolean					b_suppl_auto_release_ifms			//True falls automatische Freigabe IFMS eingestellt ist und
																		// Offset $$HEX1$$fc00$$ENDHEX$$berschritten ist
Boolean					b_suppl_auto_release_stat			//True falls automatische Freigabe Station eingestellt ist und
																		// Offset $$HEX1$$fc00$$ENDHEX$$berschritten ist
Boolean					b_suppl_auto_billing					//True falls automatische Abrechnung eingestellt ist und
																		// Offset $$HEX1$$fc00$$ENDHEX$$berschritten ist

Boolean					b_suppl_auto_release_supp			//True falls automatische Freigabe Caterer eingestellt ist 
																		// (keine explizite Freigabe nach flight closed durch Abrechner notwendig)

Boolean					b_suppl_auto_interface				// True bei zentraler Schnittstellenerstellung
Boolean					b_suppl_interface_xml				// True falls XML-Schnittstelle erstellt werden soll
Boolean					b_suppl_interface_additional		// True falls weitere Schnittstelle erstellt werden soll
Integer					i_suppl_interface_add_type			// Typ  der weiteren Schnittstelle

constant integer		i_interface_type_davinci = 1  		// Schnittstellenformat f$$HEX1$$fc00$$ENDHEX$$r LH-Rechnungspr$$HEX1$$fc00$$ENDHEX$$fung DaVinci

Integer					i_suppl_interface_check_type 		// Kennzeichen welche Pr$$HEX1$$fc00$$ENDHEX$$fungen f$$HEX1$$fc00$$ENDHEX$$r Abrechnung relevant sind'
constant integer		i_suppl_interface_check_type_1 =1 	// 1 = Pr$$HEX1$$fc00$$ENDHEX$$fung auf Kostenart und Steuerkennzeichen erforderlich
constant integer		i_suppl_interface_check_type_2 =2   // 2 = Pr$$HEX1$$fc00$$ENDHEX$$fung auf Preise, Kostenart und Steuerkennzeichen erforderlich



//----------------------------------------
// Fehler
//----------------------------------------
String			sError					= ""
Integer		iError					= 0
//----------------------------------------
// Datastores
//----------------------------------------
Datastore								dsSupplierUnit  // datastore mit den Kennzeichen je Supllier/Unit/Airline

constant integer						i_isStationEntry = 1 // Kennung f$$HEX1$$fc00$$ENDHEX$$r cen_out_pax dass Erfassung durch Station


Private:


end variables

forward prototypes
public function integer of_set_defaults ()
public function long of_retrieve_ds ()
public function boolean of_check_ready_for_billing ()
public function boolean of_check_euro_status ()
public function boolean of_check_auto_release_ifms ()
end prototypes

public function integer of_set_defaults ();///=======================================================================================
//
// initialisieren der Lieferanteneinstellungen und der R$$HEX1$$fc00$$ENDHEX$$ckgabewerte
//
//=======================================================================================

//----------------------------------------
// Lieferantenstamm-Einstellungen
//----------------------------------------

this.b_suppl_auto_release_ifms = True			// automatische Freigabe IFMS 
this.b_suppl_auto_release_stat	= True			// automatische Freigabe Station
this.b_suppl_auto_billing = False					// keine automatische Abrechnung
this.b_suppl_auto_release_supp	= False		// explizite Freigabe nach flight closed durch Abrechner notwendig (setzen Status Euro Transfer)
this.b_suppl_auto_interface = False				// manuelle Schnittstellenerstellung durch User
this.b_suppl_interface_xml = True	     			// Standard  XML-Schnittstelle wird erstellt
this.b_suppl_interface_additional = False  		// keine weitere Schnittstelle erstellen
this.i_suppl_interface_add_type	= 0 			// Typ  der weiteren Schnittstelle
this.i_suppl_interface_check_type = 0				// 1 = Pr$$HEX1$$fc00$$ENDHEX$$fung auf Kostenart und Steuerkennzeichen erforderlich
															// 2 = Pr$$HEX1$$fc00$$ENDHEX$$fung auf Preise, Kostenart und Steuerkennzeichen erforderlich

//----------------------------------------
//R$$HEX1$$fc00$$ENDHEX$$ckgabewerte
//----------------------------------------

this.b_nstatus_release = False						// keine Freigabe gesetzt
this.b_nqueued_release_interface = false		// kein Einstellen in Warteschlange
this.b_nstatus_auto_release	= False				// kein Status nstatus_auto_release gesetzt
this.b_nstatus_auto_billing = False				// kein Status nstatus_auto_billing gesetzt
this.b_release_date	= False						// kein dt_release_date gesetzt
this.dt_release_date = this.dtToday				// Datum der Freigabe


return 0



end function

public function long of_retrieve_ds ();//=======================================================================================
//
// of_retrieve_ds
//
// Ermittle Zeile aus datastore 
// zu Unit und Airline
//=======================================================================================
Long lfound
Long loffset_auto_release_ifms
Long loffset_auto_release_stat
Long loffset_auto_input
Long ldiff_days

if dsSupplierUnit.RowCount() = 0 then
	dsSupplierUnit.Retrieve()
end if

of_set_defaults()

ldiff_days = daysafter(date(this.dtdate), date(this.dtToday))
	

if dsSupplierUnit.RowCount() > 0 then
	lfound=dsSupplierUnit.Find("cen_supplier_units_nairline_key=" + string(this.lcustomer) + " and sys_units_cunit='"+this.sUnit+"'",1,dsSupplierUnit.RowCount())
	if lfound > 0 then
		if this.itype = 1 then	//Flugereignis
		
			this.b_suppl_auto_release_ifms = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_aifms_f") = 1)
			this.b_suppl_auto_release_stat = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_astat_f") = 1)
			this.b_suppl_auto_interface = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_interface_f") = 1)
			this.b_suppl_auto_billing = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_input_f") = 1)
			this.b_suppl_interface_xml = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_xml") = 1)
			this.b_suppl_interface_additional = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_add_type") > 0)
			this.b_suppl_auto_release_supp= (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_rel_supp_f") = 1)
			this.i_suppl_interface_add_type = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_add_type")
			this.i_suppl_interface_check_type = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_check_type")
			
			loffset_auto_release_ifms = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_aifms_f")
			loffset_auto_release_stat = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_astat_f")
			loffset_auto_input 			= dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_input_f")
			
			if this.b_suppl_auto_release_ifms then 
				this.b_suppl_auto_release_ifms = (loffset_auto_release_ifms <= ldiff_days)
			end if
			if this.b_suppl_auto_release_stat then 
				this.b_suppl_auto_release_stat = (loffset_auto_release_stat <= ldiff_days)
			end if
			if this.b_suppl_auto_billing then 
				this.b_suppl_auto_billing = (loffset_auto_input <= ldiff_days)
			end if
	
		elseif this.itype = 2 then	// Periodenereignis
		
			this.b_suppl_auto_release_ifms = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_aifms_nf") = 1)
			this.b_suppl_auto_release_stat = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_astat_nf") = 1)
			this.b_suppl_auto_interface = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_interface_nf") = 1)
			this.b_suppl_auto_billing = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_input_nf") = 1)
			this.b_suppl_interface_xml = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_xml") = 1)
			this.b_suppl_interface_additional = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_add_type") > 0)
			this.b_suppl_auto_release_supp = (dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_nauto_rel_supp_nf") = 1)
			this.i_suppl_interface_add_type = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_add_type")
			this.i_suppl_interface_check_type = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ninterface_check_type")
	
			loffset_auto_release_ifms = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_aifms_nf")
			loffset_auto_release_stat = dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_astat_nf")
			loffset_auto_input 			= dsSupplierUnit.GetItemNumber(lfound, "cen_supplier_units_ntlimit_input_nf")
			
			if this.b_suppl_auto_release_ifms then 
				this.b_suppl_auto_release_ifms = (loffset_auto_release_ifms <= ldiff_days)
			end if
			if this.b_suppl_auto_release_stat then 
				this.b_suppl_auto_release_stat = (loffset_auto_release_stat <= ldiff_days)
			end if
			if this.b_suppl_auto_billing then 
				this.b_suppl_auto_billing = (loffset_auto_input <= ldiff_days)
			end if

		end if		
	end if
end if

return 0
end function

public function boolean of_check_ready_for_billing ();///=======================================================================================
//
// of_check_ready_for_billing
//
// Setzen des Status Fertigmeldung Caterer
//
//  Falls im Lieferantenstamm gilt:
//     -automat. Freigabe durch IFMS nicht aktiv
//       	=> Setzen nqueued_release_interface = 1      in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Freigabe durch IFMS setzen
//     -automat. Freigabe durch IFMS ist aktiv
//    		- automat. Interface $$HEX1$$fc00$$ENDHEX$$ber zentralen Server ist aktiv 
//       	   => Setzen nqueued_release_interface = 2      in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Schnittstellenverarbeitung setzen
//   	     - automat. Interface $$HEX1$$fc00$$ENDHEX$$ber zentralen Server ist nicht aktiv 
//       	   => Aufruf Verarbeitung manuelle Schnittstelle (analog bisherigem billing browser)
//		
//=======================================================================================

boolean	bReturn				= True

Integer	i

this.of_retrieve_ds()

// Flug hat falschen Freigabe-Status 
/*
i_nrelease_status = dw_1.GetitemNumber(lRow,"nstatus_release")
if isnull(i_nrelease_status ) then
	i_nrelease_status = 0
end if
*/
/*
if irelease_status = i_nrelease_status then
	lStop = CPU()
	sMessage[iCounter] = uf.translate("Freigabestatus l$$HEX2$$e400df00$$ENDHEX$$t keine Ver$$HEX1$$e400$$ENDHEX$$nderung zu.")
	dw_1.SetItem(lRow,"compute_label_errors",0)
	dw_1.Setitem(lRow,"compute_status",string((lStop - lStart) / 1000, "0.00"))
	dw_1.Setredraw(True)	
	return False
End if
*/			

if 	isnull(this.i_nstatus_release) or &
	this.i_nstatus_release <=  i_Status_Release_Pax  then

	if this.b_suppl_auto_release_ifms then
			// bei automatischer Freigabe IFMS
		this.b_nstatus_release = True
		this.i_nstatus_release	= i_Status_Release_Flight 

		this.b_nstatus_auto_release = True
		this.i_nstatus_auto_release	= 1
	
		this.b_release_date = True
	
		if this.b_suppl_auto_interface then
				// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r zentrale Schnittstellenerstellung
				b_nqueued_release_interface = True
				i_nqueued_release_interface = i_nqueued_interface
		else
				// manuelles Abarbeiten
		end if
	else
		// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Freigabe durch IFMS
		b_nqueued_release_interface = True
		i_nqueued_release_interface = i_nqueued_release_ifms
	end if
	
else  
	// Status ist bereits auf freigegeben
		if this.b_suppl_auto_interface then
				// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r zentrale Schnittstellenerstellung
				b_nqueued_release_interface = True
				i_nqueued_release_interface = i_nqueued_interface
		else
				// manuelles Abarbeiten
		end if
end if



return True



end function

public function boolean of_check_euro_status ();///=======================================================================================
//
// of_check_euro_status
//
// Aufruf durch Dienst nach setzen flight closed status
// $$HEX1$$c400$$ENDHEX$$nderung durch MonaLisa:
//      Umsetzen in Status Euro erst wenn Freigabe durch Station erfolgt ist
//=======================================================================================
Long lfound


this.of_retrieve_ds()

// Flug hat falschen Freigabe-Status 
/*
i_nrelease_status = dw_1.GetitemNumber(lRow,"nstatus_release")
if isnull(i_nrelease_status ) then
	i_nrelease_status = 0
end if
*/
/*
if irelease_status = i_nrelease_status then
	lStop = CPU()
	sMessage[iCounter] = uf.translate("Freigabestatus l$$HEX2$$e400df00$$ENDHEX$$t keine Ver$$HEX1$$e400$$ENDHEX$$nderung zu.")
	dw_1.SetItem(lRow,"compute_label_errors",0)
	dw_1.Setitem(lRow,"compute_status",string((lStop - lStart) / 1000, "0.00"))
	dw_1.Setredraw(True)	
	return False
End if
*/			

if 	isnull(this.i_nstatus_release) or &
	this.i_nstatus_release < i_Status_Release_Pax  then

	if this.b_suppl_auto_release_stat then
			// bei automatischer Freigabe Station
		this.b_nstatus_release = True
		this.i_nstatus_release	= i_Status_Release_Pax

		this.b_nstatus = True
		this.i_nstatus = 7  // setze Euro-Status
	
		this.b_nstatus_auto_release = True
		this.i_nstatus_auto_release	= 1
	
  		this.b_release_date = True
	else	
		// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Freigabe Station
		this.b_nqueued_release_interface = True
		this.i_nqueued_release_interface = i_nqueued_release_stat
	end if
	
else  
	// Status ist bereits auf freigegeben
		this.b_nstatus = True
		this.i_nstatus = 7  // setze Euro-Status

end if

if this.b_nstatus then
	if this.i_nstatus = 7 then
		
		if this.b_suppl_auto_release_supp then  
			// keine explizite Freigabe durch Caterer n$$HEX1$$f600$$ENDHEX$$tig
	
			// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Freigabe IFMS
				b_nqueued_release_interface = True
				i_nqueued_release_interface = i_nqueued_release_ifms

		end if
	end if	
end if

		


return True



end function

public function boolean of_check_auto_release_ifms ();// --------------------------------------------------
// Setzen automatische Freigabe 
//
//  Falls im Lieferantenstamm gilt:
//    		- automat. Interface $$HEX1$$fc00$$ENDHEX$$ber zentralen Server ist aktiv 
//       	   => Setzen nqueued_release_interface = 2      in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r Schnittstellenverarbeitung setzen
//   	     - automat. Interface $$HEX1$$fc00$$ENDHEX$$ber zentralen Server ist nicht aktiv 
//       	   => Aufruf Verarbeitung manuelle Schnittstelle (analog bisherigem billing browser)
//
//  Eingabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable): 	
//				- itype						1=Flug-/2=Periodenereignis
//				- lCustomer					Kunde/Airline
//				- dtDate						Flug-/Belegdatum
//				- sUnit						Werk
//				- dtToday					Tagesdatum oder Simulationsdatum
//  Ausgabe ($$HEX1$$fc00$$ENDHEX$$ber Instanzvariable):
//				- R$$HEX1$$fc00$$ENDHEX$$ckgabewerte/Lieferanteneinstellungen
// --------------------------------------------------
Long lfound

this.of_retrieve_ds()

// Flug hat falschen Freigabe-Status 

if isnull(this.i_nstatus_release ) then
	this.i_nstatus_release = 0
end if

if this.i_nstatus_release =  i_Status_Release_Flight  then
	this.sError ="Freigabestatus l$$HEX2$$e400df00$$ENDHEX$$t keine Ver$$HEX1$$e400$$ENDHEX$$nderung zu."
	this.ierror=1
	return False
End if


		this.b_nstatus_release = True
		this.i_nstatus_release	= i_Status_Release_Flight 

		this.b_nstatus_auto_release = True
		this.i_nstatus_auto_release	= 1
	
		this.b_release_date = True
	
	
if this.b_suppl_auto_interface then
				// aktiv in Warteschlange f$$HEX1$$fc00$$ENDHEX$$r zentrale Schnittstellenerstellung
				b_nqueued_release_interface = True
				i_nqueued_release_interface = i_nqueued_interface
else
				// manuelles Abarbeiten
				b_nqueued_release_interface = True
				i_nqueued_release_interface = 0


end if



return True





end function

on uo_suppl_unit_status_release.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_suppl_unit_status_release.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsSupplierUnit						= Create DataStore
dsSupplierUnit.DataObject 		= "dw_uo_suppl_unit_status_release"
dsSupplierUnit.SetTransObject(SQLCA)

end event

event destructor;destroy dsSupplierUnit	

end event

