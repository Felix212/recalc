HA$PBExportHeader$w_loading_rotations.srw
forward
global type w_loading_rotations from window
end type
type rte_1 from richtextedit within w_loading_rotations
end type
end forward

global type w_loading_rotations from window
boolean visible = false
integer width = 3465
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rte_1 rte_1
end type
global w_loading_rotations w_loading_rotations

type variables
DataStore	 dsHeader
DataStore	 dsloading_rot_meals
end variables

event open;/*************************************************************
* Objekt : w_loading_rotations
* Methode: open (Event)
* Autor  : G. Brosch
* Datum  : 14.04.2009
* Argument(e):
*
* Return: long
*
*
* Druck Rotationsinfo-Texte bei Mahlzeitendefinition
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
* 14.04.2009		1.0		G. Brosch	   Erstellung
* 16.04.2010 	1.1		T. Leutner 	   Druck muss nun aus 3 Richtext-Objekten erstellt werden
*
*************************************************************/
//nur Druckfunktionalit$$HEX1$$e400$$ENDHEX$$t, nicht anzeigen...
this.hide()

uo_delivery_note myDeliveryNote

long  al_billing_key    = -1
long  al_result_key     = -1
integer al_PrintPreview = -1

//Object aus $$HEX1$$dc00$$ENDHEX$$bergabe auslesen und Variablen best$$HEX1$$fc00$$ENDHEX$$cken...
myDeliveryNote  = Message.PowerObjectParm
al_billing_key  = myDeliveryNote.lBillingKey
al_result_key   = myDeliveryNote.lResultKey
al_PrintPreview = myDeliveryNote.iPrintPreview

//Datastores f$$HEX1$$fc00$$ENDHEX$$r Daten...
dsHeader = create DataStore
dsHeader.dataobject = "dw_delivery_note_header"
dsHeader.SetTransObject(sqlca)

dsloading_rot_meals = create datastore
dsloading_rot_meals.dataobject = "dw_load_rot_meals"
dsloading_rot_meals.SetTransobject(sqlca)

integer n_rc         = 0
string s_airline     = ""
string s_airline_no  = ""
string s_suffix      = ""
string s_departure   = ""
string s_dep_time    = ""
string s_from        = ""
string s_to          = ""
string s_routing     = ""
string s_cat_unit    = ""
string s_owner       = ""
string s_actype      = ""
string s_acreg       = ""
string s_handling    = ""
string s_number      = ""
string s_rotation    = ""
string s_class_name    = ""
long  	l_class 
long 	l_airline_key
long	l_section
String	s_separation

dsHeader.retrieve(al_result_key)

//*** Listenkopf best$$HEX1$$fc00$$ENDHEX$$cken...
s_airline    = dsHeader.getitemstring(1, "cairline")
l_airline_key = dsHeader.getitemnumber(1, "nairline_key")
s_airline_no = string(dsHeader.getitemnumber(1, "nflight_number"))
s_suffix     = dsHeader.getitemstring(1, "csuffix")
s_departure  = left(string(dsHeader.getitemdatetime(1, "ddeparture")), 10)
s_dep_time   = dsHeader.getitemstring(1, "cdeparture_time")
s_from       = dsHeader.getitemstring(1, "ctlc_from")
s_to         = dsHeader.getitemstring(1, "ctlc_to")
s_routing    = dsHeader.getitemstring(1, "crouting_text")
s_cat_unit   = dsHeader.getitemstring(1, "sys_units_ctext")
s_owner      = dsHeader.getitemstring(1, "cairline_owner")
s_actype     = dsHeader.getitemstring(1, "cactype")
s_acreg      = dsHeader.getitemstring(1, "cregistration")
s_handling   = dsHeader.getitemstring(1, "cen_out_chandling_type_text")

if isnull(s_acreg) then
	s_acreg = "     "
end if

// *** Kopf drucken...
// 2 Newlines zum Absetzen des Textes...
rte_1.replacetext("~r~n~r~n")	
	
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(space(65))
rte_1.SetTextStyle (true, true, false, false, false, false)
rte_1.replacetext("Overview Rotation Meals")
rte_1.replacetext("~r~n~r~n")

rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext("Flight: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_airline + s_airline_no)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" Departure: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_departure + " " + s_dep_time)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" From/To: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_from + " " + s_to)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" Routing: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_from + " " + s_routing)
rte_1.replacetext("~r~n")

rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext("Catering Unit: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_cat_unit)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" Aircraft: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_owner + " " + s_actype)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" Registration: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_acreg)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(" Handling: ")
rte_1.SetTextStyle (false, false, false, false, false, false)
rte_1.replacetext(s_handling)
rte_1.SetTextStyle (true, false, false, false, false, false)
rte_1.replacetext(space(5) + "# " + string(al_billing_key))

//*** jetzt den Inhalt drucken...
integer  i = 1
long nhandling_meal_key
long nrotation
string sUeberschrift
Blob lb_blob
Blob{32000} bbuffer
integer n
long l_fromline
long l_fromchar

l_fromline = rte_1.linecount()
l_fromchar = 1

dsloading_rot_meals = create datastore
dsloading_rot_meals.dataobject = "dw_load_rot_meals"
dsloading_rot_meals.SetTransobject(sqlca)

//Daten holen...
dsloading_rot_meals.retrieve(al_result_key)

//Falls kein Satz gelesen wurde, oder der Freetext = 0 ist, dann nicht drucken...
if dsloading_rot_meals.rowcount() = 0  then	
	return n_rc
elseif dsloading_rot_meals.getitemnumber(1, "cen_delivery_note_nfreetext") = 0 then
	return n_rc
end if

setnull(bbuffer)

//Insertion-Point ans Ende setzen...
l_fromline = rte_1.linecount() //letzte Zeile
l_fromchar = 999
rte_1.SelectText(l_fromline, l_fromchar, 0, 0)
		
// TLE 16.04.2010 DW-Ergebnis kann nun mehrere Textabschnitte zur gleichen Mahlzeitenposition und Rotation enthalten, alle werden hintereinander angedruckt
long l_old_nrotation
long l_old_nhandling_meal_key

for i = 1 to dsloading_rot_meals.rowcount()
	nhandling_meal_key = dsloading_rot_meals.getitemnumber (i, "cen_meals_rottext_nhandling_meal_key")
	nrotation          = dsloading_rot_meals.getitemnumber (i, "cen_meals_rottext_nrotation")
	if 	(l_old_nhandling_meal_key <> nhandling_meal_key) or &
	   	(l_old_nrotation  <> nrotation) &
	then 
		sUeberschrift      = dsloading_rot_meals.getitemstring(i,  "cen_out_meals_chandling_text")
 	 	s_rotation         = dsloading_rot_meals.getitemstring(i,  "cen_out_meals_crotation")
		  
		// TLE 16.04.2010 Anzeige Classname hinter Rotation 
	 	l_class            = dsloading_rot_meals.getitemnumber(i,  "cen_out_meals_nclass_number")	
		s_class_name = f_get_classname(l_airline_key ,l_class)

  		 sUeberschrift = sUeberschrift + " / Rotation " + s_rotation + ":" + "                     " + "Class:" + s_class_name
	
	  	 //2 Newlines zum Absetzen des Textes...
 		rte_1.replacetext("~r~n~r~n")	
	
		//$$HEX1$$dc00$$ENDHEX$$berschrift schreiben in blau...
   		rte_1.SetTextColor (16711680)//Blau 
   		rte_1.SetTextStyle(true, true, false, false, false, false )//bold, underline
   		rte_1.replacetext(sUeberschrift)
	end if
   	//Newline...
 	rte_1.replacetext("~r~n")	
	 // Trennzeile
	 s_separation = '____________________________________________________________________________________'
	rte_1.replacetext(s_separation)
  	//Newline...
 	rte_1.replacetext("~r~n")	
	//jetzt Blob lesen...
	setnull(lb_blob)				 				
	l_section		 = dsloading_rot_meals.getitemnumber (i, "cen_meals_rottext_nsection")
				 
	SELECTBLOB brichtext
	INTO       :lb_blob 
	FROM       cen_meals_rottext
  	WHERE      nhandling_meal_key = :nhandling_meal_key
	AND        nrotation          = :nrotation
	AND		nsection 		  = :l_section;
					
	if SQLCA.SQLCODE < 0 Then
	   f_db_error(sqlca, "cen_meals_rottext, selectblob")
	   n_rc = -1
		return n_rc
	end if
	
	//Blob-Inhalt schreiben in schwarz...
	rte_1.SetTextColor(0)//schwarz
	rte_1.pasteRTF(string(lb_blob, EncodingANSI!))

	//Insertion-Point zur Sicherheit wieder ans Ende setzen...
     l_fromline = rte_1.linecount() //letzte Zeile
	l_fromchar = 999
   	rte_1.SelectText(l_fromline, l_fromchar, 0, 0)
		
	l_old_nhandling_meal_key = nhandling_meal_key 
	l_old_nrotation  = nrotation
	
next

String sCurrentPrinter, sDeliveryNotePrinter
sCurrentPrinter = PrintGetPrinter()
sDeliveryNotePrinter = f_profilestring("changebrowser","PRINTER1",sCurrentPrinter) 
f_set_printer(sDeliveryNotePrinter)
rte_1.print(myDeliveryNote.icopies, "Delivery Note - [" + s_airline + s_airline_no + "]", true, true )
f_set_printer(sCurrentPrinter)
end event

on w_loading_rotations.create
this.rte_1=create rte_1
this.Control[]={this.rte_1}
end on

on w_loading_rotations.destroy
destroy(this.rte_1)
end on

type rte_1 from richtextedit within w_loading_rotations
integer x = 37
integer y = 64
integer width = 3365
integer height = 1696
integer taborder = 10
boolean init_headerfooter = true
long init_leftmargin = 2
long init_topmargin = 2
long init_rightmargin = 1
long init_bottommargin = 2
borderstyle borderstyle = stylelowered!
end type

