HA$PBExportHeader$w_manual_distribution.srw
$PBExportComments$Fenster f$$HEX1$$fc00$$ENDHEX$$r manuelle Verteilung.~r~n~r~n- Kann $$HEX1$$fc00$$ENDHEX$$ber Setup zugeschaltet werden
forward
global type w_manual_distribution from window
end type
type dw_report from datawindow within w_manual_distribution
end type
type st_6 from statictext within w_manual_distribution
end type
type pb_2 from picturebutton within w_manual_distribution
end type
type pb_1 from picturebutton within w_manual_distribution
end type
type st_5 from statictext within w_manual_distribution
end type
type dw_select from datawindow within w_manual_distribution
end type
type sle_search from singlelineedit within w_manual_distribution
end type
type pb_print from picturebutton within w_manual_distribution
end type
type dw_stowages from datawindow within w_manual_distribution
end type
type ddplb_components from dropdownpicturelistbox within w_manual_distribution
end type
type st_2 from statictext within w_manual_distribution
end type
type pb_reset from picturebutton within w_manual_distribution
end type
type p_indicator from picture within w_manual_distribution
end type
type pb_run from picturebutton within w_manual_distribution
end type
type pb_save from picturebutton within w_manual_distribution
end type
type pb_exit from picturebutton within w_manual_distribution
end type
type uo_statusbar from uo_comctl_statusbar within w_manual_distribution
end type
type st_shadow_12 from statictext within w_manual_distribution
end type
type st_shadow_1 from statictext within w_manual_distribution
end type
type st_1 from statictext within w_manual_distribution
end type
type st_3 from statictext within w_manual_distribution
end type
type dw_components from datawindow within w_manual_distribution
end type
type st_4 from statictext within w_manual_distribution
end type
type sle_1 from singlelineedit within w_manual_distribution
end type
end forward

global type w_manual_distribution from window
integer width = 3799
integer height = 2764
boolean titlebar = true
string title = "Manuelle Komponentenverteilung"
windowtype windowtype = response!
long backcolor = 67108864
event ue_masterupdate ( )
dw_report dw_report
st_6 st_6
pb_2 pb_2
pb_1 pb_1
st_5 st_5
dw_select dw_select
sle_search sle_search
pb_print pb_print
dw_stowages dw_stowages
ddplb_components ddplb_components
st_2 st_2
pb_reset pb_reset
p_indicator p_indicator
pb_run pb_run
pb_save pb_save
pb_exit pb_exit
uo_statusbar uo_statusbar
st_shadow_12 st_shadow_12
st_shadow_1 st_shadow_1
st_1 st_1
st_3 st_3
dw_components dw_components
st_4 st_4
sle_1 sle_1
end type
global w_manual_distribution w_manual_distribution

type variables


uo_distribution				uoDistribution
uo_distribution				uoDistributionSave
uo_distribution_container	uoStowages[]
s_distribution_manual 		strReturn

boolean 						bChange

Integer 						iDragDrop
String						sLabelRow


integer						iLoadingChanged
end variables

forward prototypes
public function integer wf_prepare ()
public function integer wf_insert (long lstowagekey, long lrow, long lquantity)
public function integer wf_set_priority_maximum (long lmax, long lspml)
public function integer wf_unit_priority (long lkey)
public function integer wf_move (long lrow, long lstowagesource, long lstowagedestination, long lquantity)
public function integer wf_set_stowage_sort (long lrow)
public function integer wf_unload (long lrow, long lstowagesource, long lquantity)
public function integer wf_mcd_complete ()
public function integer wf_load (integer itype)
public function integer wf_load_stowages ()
public function long wf_find_stowage (long lstowagekey)
public subroutine wf_set_statusbar ()
public function integer wf_change_loading ()
public function integer wf_set_stowage_filter (datawindow odw, long lrow)
public function integer wf_format (string scolumnname, datawindow odw)
end prototypes

event ue_masterupdate();
if bChange then 
	pb_save.enabled = true
	pb_reset.enabled = true
else
	pb_save.enabled = false
	pb_reset.enabled = false
end if


end event

public function integer wf_prepare ();



return 0
end function

public function integer wf_insert (long lstowagekey, long lrow, long lquantity);Long		lStowages, &
			a, &
			lFound, &
			lOldQuantity

String 	sPackingListToFind, &
			sText, &
			sFind
	

// ------------------------------------------------------------------------
// Stauort suchen
// ------------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoDistribution.uoStowages)
	// ------------------------------------------------------------------------
	// Treffer
	// ------------------------------------------------------------------------
	if this.uoDistribution.uoStowages[lStowages].lLoadRow = lStowageKey then
		
				
		sPackingListToFind 	= dw_components.GetItemString(lRow, "cpackinglist")
		sText 					= dw_components.GetItemString(lRow, "cproduction_text")
		
		sFind = "cpackinglist='" + sPackingListToFind + "' and ctext='" + sText + "'"
		sFind += " and cmeal_control_code='" + dw_components.GetItemString(lRow, "cmeal_control_code") +  "'"
		
		lFound = this.uoDistribution.uoStowages[lStowages].dsContent.Find(sFind, 1, this.uoDistribution.uoStowages[lStowages].dsContent.RowCount())
		
		if lFound > 0 then
			
			lOldQuantity = this.uoDistribution.uoStowages[lStowages].dsContent.GetItemNumber(lFound, "nquantity")
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(lFound, "nquantity", lQuantity + lOldQuantity)
			
		else			
		
			a = this.uoDistribution.uoStowages[lStowages].dsContent.InsertRow(0)
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "nspml", dw_components.GetItemNumber(lRow, "nspml"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "cclass", dw_components.GetItemString(lRow, "cclass"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "nquantity", lQuantity)
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "cpackinglist", dw_components.GetItemString(lRow, "cpackinglist"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "ctext", dw_components.GetItemString(lRow, "cproduction_text"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "npltype_key", dw_components.GetItemNumber(lRow, "npltype_key"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "cpl_type", dw_components.GetItemString(lRow, "sys_packinglist_types_ctext"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "nheight",  dw_components.GetItemNumber(lRow, "nheight"))
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "nwidth", dw_components.GetItemNumber(lRow, "nwidth"))
			//MB 13.07.2010: cmeal_control_code wurde nicht $$HEX1$$fc00$$ENDHEX$$bergeben
			this.uoDistribution.uoStowages[lStowages].dsContent.SetItem(a, "cmeal_control_code", dw_components.GetItemString(lRow, "cmeal_control_code"))
		
		end if
		//this.uoDistribution.uoStowages[lStowages].dsContent.saveas("c:\temp\cbase\content"+ string(lstowages) +".xls", Excel5!, True)
		exit
		
	end if
	
Next

return 0
end function

public function integer wf_set_priority_maximum (long lmax, long lspml);Long 		lRow
String 	sColumn

if lSPML = 0 then
	sColumn = "nranking"
else
	sColumn = "nranking_spml"
end if

for lRow = 1 to dw_stowages.RowCount()

//if dw_stowages.GetItemNumber(lRow, sColumn) >= 1000 or &
//		dw_stowages.GetItemNumber(lRow, sColumn) <= -1000 then
		
if dw_stowages.GetItemNumber(lRow, sColumn) = 1000 or &
		dw_stowages.GetItemNumber(lRow, sColumn) = -1000 then		
		
//		if lMax >= 1000 then 
//			lMax = lMax + 1
//		elseif lMax <= -1000 then
//			lMax = lMax - 1
//		end if

		dw_stowages.SetItem(lRow, sColumn, lMax)
		
	end if
	
next

return 0
end function

public function integer wf_unit_priority (long lkey);// -----------------------------------------------
// 
// Beh$$HEX1$$e400$$ENDHEX$$ltnispriorit$$HEX1$$e400$$ENDHEX$$t setzen
// 
// -----------------------------------------------
Long 		lRow, &
			I
			
String	sUnit

// -----------------------------------------------
// Erstmal die ggf. vorhandene Prio resetten, da 
// vom vorangegangenen St$$HEX1$$fc00$$ENDHEX$$cklistentyp noch eine
// Priorit$$HEX1$$e400$$ENDHEX$$t eingetragen sein kann
// -----------------------------------------------
for lRow = 1 to dw_stowages.RowCount()
	dw_stowages.SetItem(lRow, "nunit_priority", 1000)
next

// -----------------------------------------------
// Dann in der Reihenfolge in der die Beh$$HEX1$$e400$$ENDHEX$$lter
// eingegeben wurden durchnummerieren
// -----------------------------------------------
this.uoDistribution.dsDistributionPriority.Retrieve(lKey)

for lRow = 1 to this.uoDistribution.dsDistributionPriority.RowCount()
	
	sUnit = this.uoDistribution.dsDistributionPriority.GetItemString(lRow, "cunit")
	
	for i = 1 to dw_stowages.RowCount()
		if dw_stowages.GetItemString(i, "cunit") = sUnit then
			dw_stowages.SetItem(i, "nunit_priority", lRow)
		end if
	next
	
next

return 0
end function

public function integer wf_move (long lrow, long lstowagesource, long lstowagedestination, long lquantity);// ------------------------------------------------------------------------
//
// Komponenten verschieben innerhanl von dw_stowage
// 
// ------------------------------------------------------------------------
Long		a, &
			lFound, &
			lOldQuantity

String 	sPackingListToFind, &
			sText, &
			sFind
	
sPackingListToFind 	= this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpackinglist")
sText 					= this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "ctext")
		
sFind = "cpackinglist='" + sPackingListToFind + "' and ctext='" + sText + "'"
		
lFound = this.uoDistribution.uoStowages[lStowageDestination].dsContent.Find(sFind, 1, this.uoDistribution.uoStowages[lStowageDestination].dsContent.RowCount())

if lFound > 0 then

	lOldQuantity = this.uoDistribution.uoStowages[lStowageDestination].dsContent.GetItemNumber(lFound, "nquantity")
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(lFound, "nquantity", lQuantity + lOldQuantity)

else			

	a = this.uoDistribution.uoStowages[lStowageDestination].dsContent.InsertRow(0)
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "nspml", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nspml"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "cclass", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cclass"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "nquantity", lQuantity)
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "cpackinglist", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpackinglist"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "ctext", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "ctext"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "npltype_key", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "npltype_key"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "cpl_type", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpl_type"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "nheight", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nheight"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "nwidth", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nwidth"))
	this.uoDistribution.uoStowages[lStowageDestination].dsContent.SetItem(a, "nspml", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nspml"))

end if

// ----------------------------------------------------------------------------------------------
// Wert reduzieren
// ----------------------------------------------------------------------------------------------
this.uoDistribution.uoStowages[lStowageSource].dsContent.SetItem(lRow, "nquantity", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nquantity") - lQuantity)

if this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nquantity") = 0 then
	this.uoDistribution.uoStowages[lStowageSource].dsContent.DeleteRow(lRow)
end if

return 0
end function

public function integer wf_set_stowage_sort (long lrow);Long 								lSpml
Long								lStowageKey
Long 								lStowagePos
Long 								lParameters
Long 								lPLType

String							sSorter
String							sClass
String							sMealControlCode
Long								i
s_distribution_parameters 	strParams

// ------------------------------------------------------------------
// Erstmal aus dem Rennen genommen
// ------------------------------------------------------------------
return 0

lSPML = dw_components.GetItemNumber(lRow, "nspml") 

if dw_stowages.GetRow() <= 0 then return 0

lStowageKey = dw_stowages.GetItemNumber(1, "nstowage_key")

lStowagePos = wf_find_stowage(lStowageKey)
if lStowagePos <= 0 then return 0

lParameters 		= uoDistribution.uoStowages[lStowagePos].lDistributionMealKey
lPlType				= dw_components.GetItemNumber(lRow, "npltype_key")
sClass				= dw_components.GetItemString(lRow, "cclass")
sMealControlCode	= dw_components.GetItemString(lRow, "cmeal_control_code")

strParams = uoDistribution.of_get_distribution_parameters_detail(lParameters, sClass, lPlType, sMealControlCode, lSPML)
if strParams.iStatus = -1 then return 0

// --------------------------------------------------------
// Beh$$HEX1$$e400$$ENDHEX$$lter Sortieren
// --------------------------------------------------------
wf_unit_priority(strParams.lDistributionDetailKey)

if uoDistribution.iMCD = 0 then
	sSorter = "nclass_number, "
else
	sSorter = ""
end if

if strParams.lDirection = 1 then // Vorw$$HEX1$$e400$$ENDHEX$$rts
	
	wf_set_priority_maximum(1000, lSPML)
	
	if lSPML = 1 then
		sSorter = sSorter + "nranking_spml, nunit_priority, cen_stowage_nsort"
	else
		sSorter = sSorter + "nranking, nunit_priority , cen_stowage_nsort"
	end if 
else // R$$HEX1$$fc00$$ENDHEX$$ckwarts
	
	wf_set_priority_maximum(-1000, lSPML)
	
	if lSPML = 1 then
		sSorter = sSorter + "nranking_spml D, nunit_priority, cen_stowage_nsort D"
	else
		sSorter = sSorter + "nranking D, nunit_priority , cen_stowage_nsort D"
	end if 
end if

dw_stowages.SetSort(sSorter)
dw_stowages.Sort()

// Messagebox("", sSorter)
//wf_set_priority_maximum(1000, lSPML)

return 0
end function

public function integer wf_unload (long lrow, long lstowagesource, long lquantity);// ------------------------------------------------------------------------
//
// Komponenten verschieben innerhanl von dw_stowage
// 
// ------------------------------------------------------------------------
Long		a, &
			lFound, &
			lOldQuantity

String 	sPackingListToFind, &
			sText, &
			sFind
	
sPackingListToFind 	= this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpackinglist")
sText 					= this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "ctext")
		
sFind = "cpackinglist='" + sPackingListToFind + "' and cproduction_text='" + sText + "'"
		
lFound = dw_components.Find(sFind, 1, dw_components.RowCount())

if lFound > 0 then

	lOldQuantity = dw_components.GetItemNumber(lFound, "nquantity")
	dw_components.SetItem(lFound, "nquantity", lQuantity + lOldQuantity)

else			

	a = dw_components.InsertRow(0)
	dw_components.SetItem(a, "nspml", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nspml"))
	dw_components.SetItem(a, "cclass", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cclass"))
	dw_components.SetItem(a, "nquantity", lQuantity)
	dw_components.SetItem(a, "cpackinglist", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpackinglist"))
	dw_components.SetItem(a, "cproduction_text", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "ctext"))
	dw_components.SetItem(a, "sys_packinglist_types_ctext", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cpl_type"))
	dw_components.SetItem(a, "npltype_key", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "npltype_key"))
	dw_components.SetItem(a, "cmeal_control_code", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemString(lRow, "cmeal_control_code"))
	
	
	dw_components.SetItem(a, "nheight", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nheight"))
	dw_components.SetItem(a, "nwidth", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nwidth"))
	dw_components.SetItem(a, "nspml", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nspml"))

end if

// ----------------------------------------------------------------------------------------------
// Wert reduzieren
// ----------------------------------------------------------------------------------------------
this.uoDistribution.uoStowages[lStowageSource].dsContent.SetItem(lRow, "nquantity", this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nquantity") - lQuantity)

if this.uoDistribution.uoStowages[lStowageSource].dsContent.GetItemNumber(lRow, "nquantity") = 0 then
	this.uoDistribution.uoStowages[lStowageSource].dsContent.DeleteRow(lRow)
end if

return 0
end function

public function integer wf_mcd_complete ();// -----------------------------------------------
// 
// Die gel$$HEX1$$f600$$ENDHEX$$schten Klassen, jetzt anhand der 
// zugestauten Komponenten neu bestimmen
// 
// -----------------------------------------------
Long 		lStowages, &
			lFound, &
			lRows

String	sClass, &
			sClassMCD, &
			sClassNew

// -----------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r alle Stauorte die beackert wurden.......
// -----------------------------------------------
for lStowages = 1 to Upperbound(this.uoDistribution.uoStowages)
	
	if this.uoDistribution.uoStowages[lStowages].dsContent.RowCount() <= 0 then continue

	// ----------------------------------------------------
	// Die Stauorte im Array f$$HEX1$$fc00$$ENDHEX$$hren eine Nummer
	// mit sich die auf die Zeile im DataStore
	// referenzieren. $$HEX1$$dc00$$ENDHEX$$ber diese Nummer wird der
	// Datensatz gesucht und ggf. die Klassenbezeichnung
	// neu eingetragen
	// ----------------------------------------------------
	lFound = this.dw_stowages.Find("ndistribution_detail_key=" + String(this.uoDistribution.uoStowages[lStowages].lLoadRow), 1, this.dw_stowages.RowCount())
	
	if lFound > 0 then
		
		for lRows = 1 to this.uoDistribution.uoStowages[lStowages].dsContent.RowCount()
			
			sClass 		= f_check_null(dw_stowages.GetItemString(lFound, "cclass"))
			sClassMCD 	= f_check_null(this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(lRows, "cclass"))
			
			if Pos(sClass, sClassMCD) = 0 then
				sClassNew = sClass + sClassMCD
				dw_stowages.SetItem(lFound, "cclass", sClassNew) 
			end if
			
		next
		
		this.uoDistribution.uoStowages[lStowages].sClass1 = f_check_null(dw_stowages.GetItemString(lFound, "cclass"))

	end if
	
next

return 0
end function

public function integer wf_load (integer itype);String		sText
datastore 	dsContents 
string 		sFlight
Integer 		iRet
//dw_components.Reset()

// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// 3 = SPML
// ---------------------------------------------------
dw_components.ShareDataOff()

if iType = 1 then
	sText = uf.translate("Mahlzeiten")
	dsContents = this.uoDistribution.dsMeals
	this.uoDistribution.dsMeals.ShareData(dw_components)
	
elseif iType = 2 then
	sText = uf.translate("Extrabaladung")
	dsContents = this.uoDistribution.dsAdditional
	this.uoDistribution.dsAdditional.ShareData(dw_components)
	
elseif iType = 3 then
	sText = uf.translate("SPML")
	dsContents = this.uoDistribution.dsSPMLDistribution
	this.uoDistribution.dsSPMLDistribution.ShareData(dw_components)
	
elseif iType = 4 then
	if uoDistribution.dsDistributionErrors.RowCount() > 0 then
		sText = uf.translate("Fehler")
	else
		sText = ""
	end if
	dsContents = this.uoDistribution.dsDistributionErrors
	this.uoDistribution.dsDistributionErrors.ShareData(dw_components)
	
else
	return -1
end if 

sFlight  = this.uoDistribution.dsFlight.GetItemString(1, "cairline") + " "
sFlight += string(this.uoDistribution.dsFlight.GetItemNumber(1, "nflight_number"))
sFlight += this.uoDistribution.dsFlight.GetItemString(1, "csuffix")

dw_components.Modify("t_header1.text='" + sFlight + "'")
dw_components.Modify("t_header2.text='" + sText + "'")

dw_report.Modify("t_flight.text='" + sFlight + "'")
dw_report.Modify("t_date.text='" + string(this.uoDistribution.dsFlight.GetItemDateTime(1, "ddeparture"), s_app.sDateformat) + "'")

return 0
end function

public function integer wf_load_stowages ();Long 	lStowages, &
		lContents, &
		lLabels, &
		lCount, &
		i, a, j, k, &
		lPos

String sPlType, sMealCode, sClass
String	ls_Stowage, ls_temp, ls_cc
String	ls_Code_2

String sMealCodes[], sPLTypes[]

sMealCodes[1] = "cmeal_control_code"
sMealCodes[2] = "cmeal_control_code1"
sMealCodes[3] = "cmeal_control_code2"
sMealCodes[4] = "cmeal_control_code3"
sMealCodes[5] = "cmeal_control_code4"
sMealCodes[6] = "cmeal_control_code5"
sMealCodes[7] = "cmeal_control_code6"
sMealCodes[8] = "cmeal_control_code7"
sMealCodes[9] = "cmeal_control_code8"
sMealCodes[10] = "cmeal_control_code9"

sPlTypes[1]		= "cpl_type"
sPlTypes[2]		= "cpl_type1"
sPlTypes[3]		= "cpl_type2"
sPlTypes[4]		= "cpl_type3"
sPlTypes[5]		= "cpl_type4"
sPlTypes[6]		= "cpl_type5"
sPlTypes[7]		= "cpl_type6"
sPlTypes[8]		= "cpl_type7"
sPlTypes[9]		= "cpl_type8"
sPlTypes[10]	= "cpl_type9"

dw_stowages.Reset()

for lStowages = 1 to Upperbound(this.uoDistribution.uoStowages)
	
	this.uoDistribution.uoStowages[lStowages].dsContent.Sort()
	
	// ------------------------------------------------------
	// Es passen nur 5 Mahlzeiten auf das Label im 
	// Location Sheet. Deshalb das Teil entsprechen
	// vervielf$$HEX1$$e400$$ENDHEX$$ltigen
	// ------------------------------------------------------
	lContents = this.uoDistribution.uoStowages[lStowages].dsContent.RowCount()
	
	if lContents = 0 then
		lLabels	 = 1
	else
		lLabels   = Ceiling(lContents / 5)
	end if
	
	lCount = 1 
	
	for i = 1 to lLabels
		
		a = dw_stowages.InsertRow(0)
		dw_stowages.SetItem(a, "cunit", this.uoDistribution.uoStowages[lStowages].sUnit)
		dw_stowages.SetItem(a, "cstowage", this.uoDistribution.uoStowages[lStowages].sStowage)
		ls_Stowage =  this.uoDistribution.uoStowages[lStowages].sStowage
		dw_stowages.SetItem(a, "nloadrow", this.uoDistribution.uoStowages[lStowages].lLoadRow)
		
		
		sClass = this.uoDistribution.uoStowages[lStowages].sClass1 
		if this.uoDistribution.uoStowages[lStowages].sClass2 <> "" then sClass += "/" + this.uoDistribution.uoStowages[lStowages].sClass2 
		if this.uoDistribution.uoStowages[lStowages].sClass3 <> "" then sClass += "/" + this.uoDistribution.uoStowages[lStowages].sClass3 
		// ----------------------------------------------------------
		// Class 4,5,6
		// ----------------------------------------------------------
		if this.uoDistribution.uoStowages[lStowages].sClass4 <> "" then sClass += "/" + this.uoDistribution.uoStowages[lStowages].sClass4 
		if this.uoDistribution.uoStowages[lStowages].sClass5 <> "" then sClass += "/" + this.uoDistribution.uoStowages[lStowages].sClass5 
		if this.uoDistribution.uoStowages[lStowages].sClass6 <> "" then sClass += "/" + this.uoDistribution.uoStowages[lStowages].sClass6 

		
		dw_stowages.SetItem(a, "cclass", sClass) 
		dw_stowages.SetItem(a, "nclass_number", this.uoDistribution.of_get_classnumber(this.uoDistribution.uoStowages[lStowages].sClass1))
		dw_stowages.SetItem(a, "ctext1", this.uoDistribution.uoStowages[lStowages].sText1)
		dw_stowages.SetItem(a, "ctext2", this.uoDistribution.uoStowages[lStowages].sText2)
		
		if this.uoDistribution.uoStowages[lStowages].sStowageGroup = "-1" then
			dw_stowages.SetItem(a, "ctext3", "")
		else
			dw_stowages.SetItem(a, "ctext3", this.uoDistribution.uoStowages[lStowages].sStowageGroup)
		end if
		
		dw_stowages.SetItem(a, "cpackinglist", this.uoDistribution.uoStowages[lStowages].sPackinglist)
		dw_stowages.SetItem(a, "cworkstation", this.uoDistribution.uoStowages[lStowages].sWorkstation)
		dw_stowages.SetItem(a, "nstowage_key", this.uoDistribution.uoStowages[lStowages].lStowageKey)
		dw_stowages.SetItem(a, "nbelly", this.uoDistribution.uoStowages[lStowages].lBelly)
		dw_stowages.SetItem(a, "cen_stowage_nsort", this.uoDistribution.uoStowages[lStowages].lStowageSort)
		dw_stowages.SetItem(a, "ndistribution_detail_key", this.uoDistribution.uoStowages[lStowages].lLoadRow)
		dw_stowages.SetItem(a, "ncopy", i)
		dw_stowages.SetItem(a, "ndiv2", "/")
		
		//if this.uoStowages[lStowages].lRanking <> 1000 then this.dsLocationSheet.SetItem(a, "nranking", this.uoStowages[lStowages].lRanking)
		//if this.uoStowages[lStowages].lRankingSPML <> 1000 then this.dsLocationSheet.SetItem(a, "nranking_spml", this.uoStowages[lStowages].lRankingSPML)
		dw_stowages.SetItem(a, "nranking", this.uoDistribution.uoStowages[lStowages].lRanking)
		dw_stowages.SetItem(a, "nranking_spml", this.uoDistribution.uoStowages[lStowages].lRankingSPML)
		
		// -------------------------------------------------------------
		// Mealgang
		// H$$HEX1$$f600$$ENDHEX$$hen/Tiefen
		// St$$HEX1$$fc00$$ENDHEX$$cklistentype
		// 
		// werden nur dann eingetragen, wenn
		// sie f$$HEX1$$fc00$$ENDHEX$$r die ESL eindeutig sind
		// -------------------------------------------------------------
		if this.uoDistribution.uoStowages[lStowages].dsPackingListSize.RowCount() = 1 then
			dw_stowages.SetItem(a, "cmeal_control_code", this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "cmeal_control_code"))			
			ls_temp = this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "cmeal_control_code")
			dw_stowages.SetItem(a, "cpl_type", this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "ctext"))			
			dw_stowages.SetItem(a, "nheight", this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nheight"))			
			dw_stowages.SetItem(a, "nwidth", this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nwidth"))			
		else
			
			for J = 1 to this.uoDistribution.uoStowages[lStowages].dsPackingListSize.RowCount()
				
				if j < 10 then
					dw_stowages.SetItem(a, sMealCodes[j], this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(j, "cmeal_control_code"))								
					ls_cc = this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(j, "cmeal_control_code")								
					dw_stowages.SetItem(a, sPlTypes[j], this.uoDistribution.uoStowages[lStowages].dsPackingListSize.GetItemString(j, "ctext"))								
					
				end if
				
			next
			
		end if
		
		lPos = 0
		
		for J = lCount to lContents
			
			lPos ++
			if lPos = 6 then exit
			
			lCount ++
			
			dw_stowages.SetItem(a, "nquantity" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemNumber(J, "nquantity"))
			dw_stowages.SetItem(a, "ccontent" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(J, "ctext"))
			dw_stowages.SetItem(a, "ccontent_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(J, "cpackinglist"))
			
			dw_stowages.SetItem(a, "nheight_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemNumber(J, "nheight"))
			dw_stowages.SetItem(a, "nwidth_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemNumber(J, "nwidth"))
			dw_stowages.SetItem(a, "cpl_type_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(J, "cpl_type"))
			dw_stowages.SetItem(a, "npltype_key" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemNumber(J, "npltype_key"))
			dw_stowages.SetItem(a, "cmeal_control_code_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(J, "cmeal_control_code"))
			dw_stowages.SetItem(a, "cclass_pl" + string(lPos), this.uoDistribution.uoStowages[lStowages].dsContent.GetItemString(J, "cclass"))
			
		next
		
	next
	
next

dw_stowages.Sort()

return 0

end function

public function long wf_find_stowage (long lstowagekey);Long		lStowages, &
			a, &
			lFound, &
			lOldQuantity

String 	sPackingListToFind, &
			sText, &
			sFind 
// ---------------------------------------------------------------------------
// Stauort suchen
// ---------------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoDistribution.uoStowages)
	// ------------------------------------------------------------------------
	// Treffer
	// ------------------------------------------------------------------------
	if this.uoDistribution.uoStowages[lStowages].lLoadRow = lStowageKey then
		
		Return lStowages			
		
	end if
	
Next


//for lStowages = 1 to Upperbound(this.uoDistribution.uoStowages)
//	// ------------------------------------------------------------------------
//	// Treffer
//	// ------------------------------------------------------------------------
//	if this.uoDistribution.uoStowages[lStowages].lStowageKey = lStowageKey then
//		
//		Return lStowages			
//		
//	end if
//	
//Next

return -1
end function

public subroutine wf_set_statusbar ();// ------------------------------------------------------
// Infos f$$HEX1$$fc00$$ENDHEX$$r Statusbar
// ------------------------------------------------------
long lRow,lRowOf

if isnull(dw_components) then return 

if not isvalid(dw_components) then return 
	

If dw_components.Getrow() > 0 Then
	lRow 		= dw_components.Getrow()
	lRowOf	= dw_components.Rowcount()
End if	

If isnull(lRow) 	Then lRow 	= 0
If isnull(lRowOf) Then lRowOf = 0

uo_StatusBar.of_SetText( 1, 0, "Row " + string(lRow) + " of " + string(lRowOf))

end subroutine

public function integer wf_change_loading ();String	sLL, sHandling
Long 		lRows, I
// -------------------------------------------------
// Zum Zweck der Simulation 
// Standardbeladung tauschen
// -------------------------------------------------
Long		lAircraftKey
Boolean	bFound
 
s_distribution_sim	strSim
s_distribution_sim	strNewLoading

// -------------------------------------------------------
// Loadinglists einsammeln
// -------------------------------------------------------
for lRows = 1 to uoDistribution.dsLoadinglist.RowCount()
	
	if uoDistribution.dsLoadinglist.GetItemNumber(lRows, "cen_loadinglist_index_nloadinglist_key") = 1 then
		
		sLL = uoDistribution.dsLoadinglist.GetItemString(lRows, "cen_loadinglist_index_cloadinglist")
		bFound = False
	
		for i = 1 to Upperbound(strSim.sLL)
						
			if strSim.sLL[i] = sLL then 
				bFound = True
				exit
			end if
			
		next
		
		if not bFound then strSim.sLL[UpperBound(strSim.sLL) + 1] = sLL
		
	end if 
		
next

// -------------------------------------------------------
// SupplementLoadinglist einsammeln
// -------------------------------------------------------
for lRows = 1 to uoDistribution.dsLoadinglist.RowCount()
	
	if uoDistribution.dsLoadinglist.GetItemNumber(lRows, "cen_loadinglist_index_nloadinglist_key") = 2 then
		
		sLL = uoDistribution.dsLoadinglist.GetItemString(lRows, "cen_loadinglist_index_cloadinglist")
		bFound = False
	
		for i = 1 to Upperbound(strSim.sZBL)
						
			if strSim.sZBL[i] = sLL then 
				bFound = True
				exit
			end if
			
		next
		
		if not bFound then strSim.sZBL[UpperBound(strSim.sZBL) + 1] = sLL
		
	end if 
		
next

openwithparm(w_manual_loading, strSim)
strNewLoading = Message.PowerObjectParm

if not isValid(strNewLoading) then 
	f_set_pointer_arrow()
	return 0
end if 

if UpperBound(strNewLoading.sLL) <= 0 then
	return 0
end if

select distinct naircraft_key into :lAircraftKey from cen_loadinglist_index where cloadinglist = :strNewLoading.sLL[1];

if sqlca.sqlcode = 100 then
	uf.mbox("Achtung", "Flugger$$HEX1$$e400$$ENDHEX$$t f$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$ckliste: ${" + strNewLoading.sLL[1] + "} konnte nicht ermittelt werden", StopSign!)
	return 0
elseif sqlca.sqlcode < 0 then
	f_db_error(sqlca, "")
	return 0
end if

sHandling = ""
for i = 1 to Upperbound(strNewLoading.sLL)
	sHandling += strNewLoading.sLL[i] + " / "
Next						
for i = 1 to Upperbound(strNewLoading.sZBL)
	sHandling += strNewLoading.sZBL[i] + " / "
Next						
sHandling = Mid(sHandling, 1, len(sHandling) - 3)

f_set_pointer_hourglass(handle(this))

dw_stowages.SetRedraw(False)

str_actype strRet
strRet = f_get_actype_structure(lAircraftKey)

if uoDistribution.dsFlight.RowCount() > 0 then
	uoDistribution.dsFlight.SetItem(1, "cairline_owner", f_get_airline_name(strRet.lOwner))
	uoDistribution.dsFlight.SetItem(1, "cactype", strRet.cactype)
	uoDistribution.dsFlight.SetItem(1, "cgalleyversion", strRet.cgalleyversion) 
	uoDistribution.dsFlight.SetItem(1, "cconfiguration", strRet.cconfig)
end if

uo_client_label 	uoClientLabel 
uoClientLabel 		= Create uo_client_label //uoClientLabelEmpty	
uoClientLabel.of_get_standard_loading_userdefined(strNewLoading.sLL[], strNewLoading.sZBL[], uoDistribution.dtDeparture, "00:00")

if uoClientLabel.dsLoading.RowCount() > 0 then
	
	// -----------------------------------------------------
	// Array mit Stauorten leeren und Klassennummern 
	// zuspielen
	// -----------------------------------------------------
	uoDistribution.dsLoadinglist.Reset()
	uoClientLabel.dsLoading.RowsCopy(1, uoClientLabel.dsLoading.RowCount(), Primary!, uoDistribution.dsLoadinglist, 1, Primary!)
	
	uoDistribution.sHandlingString	= sHandling
	uoDistribution.uoStowages = this.uoStowages
	uoDistribution.of_add_classnumbers(4)
	
	uoDistribution.lAircraftKey = lAircraftKey
	// -----------------------------------------------------
	// Verteilungsparameter pro Galley einsammeln
	// -----------------------------------------------------
	if uoDistribution.of_get_distribution_parameters() <> 0 then
		uf.mbox("Achtung", uoDistribution.sError, StopSign!)
		pb_exit.TriggerEvent(Clicked!)
		close(this)
		f_set_pointer_arrow()
		return 0
	end if
	
	// -----------------------------------------------------
	// Die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen ermitteln
	// -----------------------------------------------------
	if uoDistribution.of_get_dimensions() <> 0 then
		uf.mbox("Achtung", uoDistribution.sError, StopSign!)
		pb_exit.TriggerEvent(Clicked!)
		f_set_pointer_arrow()
		return 0
	end if
		
	// -----------------------------------------------------
	// Und das Fenster aktualisieren
	// -----------------------------------------------------
	wf_load(1)
	wf_load_stowages()
	if dw_components.RowCount() > 0 then wf_set_stowage_filter(dw_components, 1)
	
else
	
	uf.mbox("Achtung", "Es konnte keine Standardbeladung ermittelt werden!", Stopsign!)
	
end if
	
Destroy(uoClientLabel)

f_set_pointer_arrow()
dw_stowages.SetRedraw(True)

return 0
end function

public function integer wf_set_stowage_filter (datawindow odw, long lrow);// ---------------------------------------------------------
//
// Die relevanten Stauorte rausfiltern
//
// ---------------------------------------------------------

String 	sPlType, sMealControlCode, sClass

if lrow <= 0 then return 0


sPlType				= oDW.GetItemString(lRow, "sys_packinglist_types_ctext")
sMealControlCode	= oDW.GetItemString(lRow, "cmeal_control_code") 
sClass				= oDW.GetItemString(lRow, "cclass")


if isnull(sPlType) then sPlType = ""
if isnull(sMealControlCode) then sMealControlCode = ""
if isnull(sClass) then sClass = ""

if this.uoDistribution.iMCD = 0 then
	//dw_stowages.SetFilter("cclass = '"  + sClass + "' and cmeal_control_code = '" + sMealControlCode + "' and cpl_type = '" + sPlType + "'")
	dw_stowages.SetFilter("Pos(cclass, '"  + sClass + "') > 0 and (cmeal_control_code = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code1 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code2 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code3 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code4 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code5 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code6 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code7 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code8 = '" + sMealControlCode + "' or " + &
																			 "cmeal_control_code9 = '" + sMealControlCode + "') and " + &
																			" (cpl_type = '" + sPlType + "' or "  + & 
																			"  cpl_type1 = '" + sPlType + "' or " + & 
																			"  cpl_type2 = '" + sPlType + "' or " + & 
																			"  cpl_type3 = '" + sPlType + "' or " + & 
																			"  cpl_type4 = '" + sPlType + "' or " + & 
																			"  cpl_type5 = '" + sPlType + "' or " + & 
																			"  cpl_type6 = '" + sPlType + "' or " + & 
																			"  cpl_type7 = '" + sPlType + "' or " + & 
																			"  cpl_type8 = '" + sPlType + "' or " + & 
																			"  cpl_type9 = '" + sPlType + "')")

else
	//dw_stowages.SetFilter("cmeal_control_code = '" + sMealControlCode + "' and cpl_type = '" + sPlType + "'")		
	dw_stowages.SetFilter("(cmeal_control_code = '" + sMealControlCode + "' or " + &
									"cmeal_control_code1 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code2 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code3 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code4 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code5 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code6 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code7 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code8 = '" + sMealControlCode + "' or " + &
									 "cmeal_control_code9 = '" + sMealControlCode + "') and " + &
									" (cpl_type = '" + sPlType + "' or "  + & 
									"  cpl_type1 = '" + sPlType + "' or " + & 
									"  cpl_type2 = '" + sPlType + "' or " + & 
									"  cpl_type3 = '" + sPlType + "' or " + & 
									"  cpl_type4 = '" + sPlType + "' or " + & 
									"  cpl_type5 = '" + sPlType + "' or " + & 
									"  cpl_type6 = '" + sPlType + "' or " + & 
									"  cpl_type7 = '" + sPlType + "' or " + & 
									"  cpl_type8 = '" + sPlType + "' or " + & 
									"  cpl_type9 = '" + sPlType + "')")
end if

dw_stowages.Filter()

	

return 0

end function

public function integer wf_format (string scolumnname, datawindow odw);// --------------------------------------------------------------------------------
//  
// Das Label - DW formatieren
//
// --------------------------------------------------------------------------------
Long 		lOffset, &
			lStart, &
			lX, &
			lY, &
			lHeight, &
			lWidth, &
			lFontBold, &
			lFontSize, &
			lXOffset, &
			lAlignment
			
Integer 	I

String	sFontFace, &
			sCurrentColumn, &
			sRet


lOffSet = Long(oDW.Describe("nhide_2.x")) - Long(oDW.Describe("nhide_1.x"))
lStart  = Long(oDW.Describe("nhide_1.x"))

lX  			= Long(oDW.Describe(sColumnname + "_1.x"))
lY  			= Long(oDW.Describe(sColumnname + "_1.y"))
lHeight		= Long(oDW.Describe(sColumnname + "_1.height"))
lWidth		= Long(oDW.Describe(sColumnname + "_1.width"))
lAlignment	= Long(oDW.Describe(sColumnname + "_1.alignment"))
lFontBold	= Long(oDW.Describe(sColumnname + "_1.font.weight"))
lFontSize	= Long(oDW.Describe(sColumnname + "_1.font.height"))
sFontFace	= oDW.Describe(sColumnname + "_1.font.face")

for i = 2 to 5
	
	lXOffset = lX + (lOffset * (I - 1))

	sCurrentColumn = sColumnName + "_" + string(i)
	//sVisible = "0~tif( isnull(ncopy_" + string(i) + "), 0, 1)"	
	//sVisible = "0~tif( isnull(ncopy), 0, 1)"	
	
	oDW.SetPosition(sCurrentColumn, "", TRUE)
	//sRet = oDW.modify(sCurrentColumn + ".visible='" + sVisible + "'")
	sRet = oDW.modify(sCurrentColumn + ".x=" + string(lXOffSet))
	sRet = oDW.modify(sCurrentColumn + ".y=" + string(lY))
	sRet = oDW.modify(sCurrentColumn + ".width=" + string(lWidth))
	sRet = oDW.modify(sCurrentColumn + ".alignment=" + string(lAlignment))
	sRet = oDW.modify(sCurrentColumn + ".height=" + string(lHeight))
	sRet = oDW.modify(sCurrentColumn + ".font.weight=" + string(lFontBold))
	sRet = oDW.modify(sCurrentColumn + ".font.height=" + string(lFontSize))
	sRet = oDW.modify(sCurrentColumn + ".font.face='" + sFontFace + "'")
	
Next





return 0
end function

on w_manual_distribution.create
this.dw_report=create dw_report
this.st_6=create st_6
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_5=create st_5
this.dw_select=create dw_select
this.sle_search=create sle_search
this.pb_print=create pb_print
this.dw_stowages=create dw_stowages
this.ddplb_components=create ddplb_components
this.st_2=create st_2
this.pb_reset=create pb_reset
this.p_indicator=create p_indicator
this.pb_run=create pb_run
this.pb_save=create pb_save
this.pb_exit=create pb_exit
this.uo_statusbar=create uo_statusbar
this.st_shadow_12=create st_shadow_12
this.st_shadow_1=create st_shadow_1
this.st_1=create st_1
this.st_3=create st_3
this.dw_components=create dw_components
this.st_4=create st_4
this.sle_1=create sle_1
this.Control[]={this.dw_report,&
this.st_6,&
this.pb_2,&
this.pb_1,&
this.st_5,&
this.dw_select,&
this.sle_search,&
this.pb_print,&
this.dw_stowages,&
this.ddplb_components,&
this.st_2,&
this.pb_reset,&
this.p_indicator,&
this.pb_run,&
this.pb_save,&
this.pb_exit,&
this.uo_statusbar,&
this.st_shadow_12,&
this.st_shadow_1,&
this.st_1,&
this.st_3,&
this.dw_components,&
this.st_4,&
this.sle_1}
end on

on w_manual_distribution.destroy
destroy(this.dw_report)
destroy(this.st_6)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_5)
destroy(this.dw_select)
destroy(this.sle_search)
destroy(this.pb_print)
destroy(this.dw_stowages)
destroy(this.ddplb_components)
destroy(this.st_2)
destroy(this.pb_reset)
destroy(this.p_indicator)
destroy(this.pb_run)
destroy(this.pb_save)
destroy(this.pb_exit)
destroy(this.uo_statusbar)
destroy(this.st_shadow_12)
destroy(this.st_shadow_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.dw_components)
destroy(this.st_4)
destroy(this.sle_1)
end on

event open;long		llParts[3], 	&
			lID, 				&
			lPicture, 		&
			I, &
			lFound
			
//this.width = 4622
//this.height = 2764			
			
llParts[1] = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 45
llParts[2] = llParts[1] + UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 20
llParts[3] = -1
uo_StatusBar.of_SetParts( llParts[] )
uo_StatusBar.of_SetText( 0, 0, "" )
uo_StatusBar.of_SetText( 1, 0, "" )
uo_StatusBar.of_SetText( 2, 0, String(Today(),s_app.sDateformat))

uoDistributionSave 	= Message.PowerObjectParm
uoDistribution = uoDistributionSave.of_clone()
dw_components.SetRowFocusIndicator(p_indicator)

// ------------------------------------------
//
// Alle Objekte im DW positionieren, 
// formatieren
// 
// ------------------------------------------
wf_format("cunit", dw_stowages)
wf_format("cstowage", dw_stowages)
wf_format("cclass", dw_stowages)
wf_format("ctext1", dw_stowages)
wf_format("ctext2", dw_stowages)
wf_format("ctext3", dw_stowages)
wf_format("nquantity1", dw_stowages)
wf_format("nquantity2", dw_stowages)
wf_format("nquantity3", dw_stowages)
wf_format("nquantity4", dw_stowages)
wf_format("nquantity5", dw_stowages)
wf_format("ccontent1", dw_stowages)
wf_format("ccontent2", dw_stowages)
wf_format("ccontent3", dw_stowages)
wf_format("ccontent4", dw_stowages)
wf_format("ccontent5", dw_stowages)
wf_format("ccontent_pl1", dw_stowages)
wf_format("ccontent_pl2", dw_stowages)
wf_format("ccontent_pl3", dw_stowages)
wf_format("ccontent_pl4", dw_stowages)
wf_format("ccontent_pl5", dw_stowages)
wf_format("cpackinglist", dw_stowages)
wf_format("cmeal_control_code", dw_stowages)
wf_format("ncopy", dw_stowages)
wf_format("nranking", dw_stowages)
wf_format("nranking_spml", dw_stowages)
wf_format("cpl_type", dw_stowages)
wf_format("nheight", dw_stowages)
wf_format("nwidth", dw_stowages)
wf_format("cworkstation", dw_stowages)
wf_format("ndiv_2", dw_stowages)

ddplb_components.Additem(uf.translate("Mahlzeiten"), 1)
ddplb_components.Additem(uf.translate("Extrabeladung"), 3)
ddplb_components.Additem(uf.translate("SPML's"), 2)
ddplb_components.SelectItem(1)

// -------------------------------------------------------
// Datastores laden
//
// Wenn es schon Datens$$HEX1$$e400$$ENDHEX$$tze in dsDistributionErrors
// gibt, dann wird davon ausgegangen, dass nur
// die Verteilung in Fehlerfalle gew$$HEX1$$fc00$$ENDHEX$$nscht ist
// -------------------------------------------------------
if this.uoDistribution.dsDistributionErrors.RowCount() > 0 then
	ddplb_components.Additem(uf.translate("Fehler"), 4)
	ddplb_components.Selectitem(4)
	ddplb_components.enabled = false	
	pb_save.enabled 	= true
	wf_load(4)
else
	wf_load(1)
end if

wf_load_stowages()

if dw_components.RowCount() > 0 then wf_set_stowage_filter(dw_components, 1)

// -----------------------------------------------------------
// Nur wenn er die Rolle "Simulation Verteilung" hat
// 
// -----------------------------------------------------------
lFound = s_app.ds_userinfo.find("nrole_id = 10740",1 ,s_app.ds_userinfo.Rowcount())

If lFound <= 0 Then
	
	st_4.visible = false
	
end if 

// ----------------------------------------------------------
// Alle Komponenten in ein Auswahl DW laden
// ----------------------------------------------------------
Integer iRet

if  this.uoDistribution.dsMeals.RowCount() > 0 then
	iRet = this.uoDistribution.dsMeals.RowsCopy(1, this.uoDistribution.dsMeals.RowCount(),Primary!, dw_select, dw_select.RowCount() + 1, Primary!)
	if iRet <> 1 then uf.mbox("Achtung", "Fehler beim Kopieren der Daten", StopSign!)
end if

if  this.uoDistribution.dsAdditional.RowCount() > 0 then
	iRet = this.uoDistribution.dsAdditional.RowsCopy(1, this.uoDistribution.dsAdditional.RowCount(),Primary!, dw_select, dw_select.RowCount() + 1, Primary!)
	if iRet <> 1 then uf.mbox("Achtung", "Fehler beim Kopieren der Daten", StopSign!)
end if

if  this.uoDistribution.dsSPMLDistribution.RowCount() > 0 then
	iRet = this.uoDistribution.dsSPMLDistribution.RowsCopy(1, this.uoDistribution.dsSPMLDistribution.RowCount(),Primary!, dw_select, dw_select.RowCount() + 1, Primary!)
	if iRet <> 1 then uf.mbox("Achtung", "Fehler beim Kopieren der Daten", StopSign!)
end if

dw_select.Sort()

uf.translate_window(this)
uf.translate_datawindow(dw_components)
uf.translate_datawindow(dw_stowages)	
f_centerwindow(this)

end event

type dw_report from datawindow within w_manual_distribution
integer x = 3959
integer y = 972
integer width = 686
integer height = 400
integer taborder = 100
string title = "none"
string dataobject = "dw_uo_location_sheet_display_x5_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_manual_distribution
integer x = 1509
integer y = 20
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_manual_distribution
integer x = 1513
integer y = 24
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\search_small.gif"
alignment htextalign = left!
end type

event clicked;
sle_search.trigger Event ue_key( KeyEnter!, 0)
if dw_select.visible then pb_1.TriggerEvent(Clicked!)

end event

type pb_1 from picturebutton within w_manual_distribution
integer x = 1403
integer y = 24
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\downarrow.gif"
alignment htextalign = left!
end type

event clicked;
if dw_select.visible then 
	
	dw_select.visible = false
	
else
	dw_select.x = this.x
	dw_select.y = this.y + this.height + 4
	dw_select.visible = true
	dw_select.SetFocus()
	
end if 




end event

type st_5 from statictext within w_manual_distribution
integer x = 1399
integer y = 20
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_select from datawindow within w_manual_distribution
event uo_mousemove pbm_dwnmousemove
event type integer ue_validation ( string sfield,  long lrow,  string sdata )
boolean visible = false
integer x = 3899
integer y = 92
integer width = 1838
integer height = 704
integer taborder = 90
string dragicon = "..\resource\dragdrop.ico"
string title = "none"
string dataobject = "dw_uo_cen_out_meals_select"
boolean vscrollbar = true
end type

event clicked;

if row > 0 then this.scrolltorow(row)
	

end event

event rowfocuschanged;
wf_set_statusbar()

if currentrow <= 0 then return 0

if iDragDrop = 0 then
	wf_set_stowage_filter(this, currentrow)
end if
end event

event doubleclicked;


if this.visible then pb_1.TriggerEvent(Clicked!)
end event

type sle_search from singlelineedit within w_manual_distribution
event ue_key pbm_keydown
integer x = 1646
integer y = 36
integer width = 430
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean border = false
textcase textcase = upper!
integer limit = 10
end type

event ue_key;String 	sFilter
Long		lLen

if key = KeyEnter! then
	
	if this.Text = "" then
		
		sFilter = ""
		dw_stowages.Setfilter(sFilter)
		dw_stowages.Filter()
		
	else
		
		lLen = Len(this.text)
		sFilter  = "Upper(Mid(cstowage, 1, " + string(lLen) + ")) = '" + this.text + "' or "
		sFilter += "Upper(Mid(ccontent_pl1, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(Mid(ccontent_pl2, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(Mid(ccontent_pl3, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(Mid(ccontent_pl4, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(Mid(ccontent_pl5, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(Mid(ctext3, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Pos(ccontent1, '" + this.text + "') > 0 " + " or "
		sFilter += "Pos(ccontent2, '" + this.text + "') > 0 " + " or "
		sFilter += "Pos(ccontent3, '" + this.text + "') > 0 " + " or "
		sFilter += "Pos(ccontent4, '" + this.text + "') > 0 " + " or "
		sFilter += "Pos(ccontent5, '" + this.text + "') > 0 " + " or "
		sFilter += "cpl_type = '" + this.text + "' or " 
		sFilter += "cpl_type1 = '" + this.text + "' or " 
		sFilter += "cpl_type2 = '" + this.text + "' or " 
		sFilter += "cpl_type3 = '" + this.text + "' or " 
		sFilter += "cpl_type4 = '" + this.text + "' or " 
		sFilter += "cpl_type5 = '" + this.text + "' or " 
		sFilter += "cpl_type6 = '" + this.text + "' or " 
		sFilter += "cpl_type7 = '" + this.text + "' or " 
		sFilter += "cpl_type8 = '" + this.text + "' or " 
		sFilter += "cpl_type9 = '" + this.text + "' or " 
		sFilter += "Upper(Mid(cpackinglist, 1, " + string(lLen) + ")) = '" + this.text + "' or " 
		sFilter += "Upper(cunit) = '" + this.text + "'" 
		
		dw_stowages.Setfilter(sFilter)
		dw_stowages.Filter()
		
	end if	
	

end if
end event

event getfocus;this.SelectText(1, len(this.text))
end event

type pb_print from picturebutton within w_manual_distribution
integer x = 3575
integer y = 692
integer width = 174
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "..\Resource\printer1c.gif"
string disabledname = "..\Resource\printer1c.gif"
alignment htextalign = left!
string powertiptext = "Standardbeladung tauschen"
end type

event clicked;

wf_format("cunit", dw_report)
wf_format("cstowage", dw_report)
wf_format("cclass", dw_report)
wf_format("ctext1", dw_report)
wf_format("ctext2", dw_report)
wf_format("ctext3", dw_report)
wf_format("nquantity1", dw_report)
wf_format("nquantity2", dw_report)
wf_format("nquantity3", dw_report)
wf_format("nquantity4", dw_report)
wf_format("nquantity5", dw_report)
wf_format("ccontent1", dw_report)
wf_format("ccontent2", dw_report)
wf_format("ccontent3", dw_report)
wf_format("ccontent4", dw_report)
wf_format("ccontent5", dw_report)
wf_format("ccontent_pl1", dw_report)
wf_format("ccontent_pl2", dw_report)
wf_format("ccontent_pl3", dw_report)
wf_format("ccontent_pl4", dw_report)
wf_format("ccontent_pl5", dw_report)
wf_format("cpackinglist", dw_report)
wf_format("cmeal_control_code", dw_report)
wf_format("ncopy", dw_report)
wf_format("nranking", dw_report)
wf_format("nranking_spml", dw_report)
wf_format("cpl_type", dw_report)
wf_format("nheight", dw_report)
wf_format("nwidth", dw_report)
wf_format("cworkstation", dw_report)
wf_format("ndiv_2", dw_report)

dw_report.Reset()
dw_stowages.RowsCopy(1, dw_stowages.RowCount(), Primary!, dw_report, 1, Primary!)
dw_report.Sort()
uf.translate_datawindow(dw_report)
f_format_datawindow_report(dw_report, uf.translate("Distribution Checksheet"))
f_get_report_datawindow_number(dw_report)
f_print(dw_report)
end event

type dw_stowages from datawindow within w_manual_distribution
event uo_mousemove pbm_dwnmousemove
integer x = 9
integer y = 832
integer width = 3529
integer height = 1744
integer taborder = 90
string dragicon = "..\resource\dragdrop.ico"
string title = "none"
string dataobject = "dw_uo_location_sheet_display_x5"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event uo_mousemove;
//uo_StatusBar.of_SetText( 0, 0, dwo.name )

if KeyDown(KeyLeftButton!) and &
	(Mid(dwo.name, 1, 9)  =  "nquantity" or &
	 Mid(dwo.name, 1, 8)	 =  "ccontent" or  &
	 Mid(dwo.name, 1, 11) =  "ccontent_pl") then

	sLabelRow = Mid(Right(dwo.name, 3), 1, 1)
	
	if row > 0 and row <> this.GetRow() then this.ScrollToRow(row)
	
	//uo_StatusBar.of_SetText( 0, 0, sLabelRow )
	
	this.Drag(Begin!)
	
end if
end event

event dragdrop;DataWindow 	dwSource
Long 			lQuantity, &
				lReturnQuantity, &
				lRowSource, &
				lStowageKeySource, &
				lStowageKeyDestination, &
				lPosSource, &
				lPosDestination, &
				lPos, &
				lRow, &
				lComponentRow

String		sFilter, &
				sVerticalScroll

s_distribution_quantities	strOpen

if row <= 0 or row > this.RowCount() then return 0

IF source.TypeOf() = DataWindow! THEN
	
	dwSource = source
	
	// --------------------------------------------------------------
	// 
	// Drop von einer neuen Komponente ins Datawindow
	// 
	// --------------------------------------------------------------
	if dwSource = dw_components then 
	
		// -----------------------------------------
		// Ins leere gedropped, dann zur$$HEX1$$fc00$$ENDHEX$$ck
		// -----------------------------------------
		if dwSource.GetRow() <= 0 then return 0
		
		// -----------------------------------------
		// Menge = 0 , dann zur$$HEX1$$fc00$$ENDHEX$$ck
		// -----------------------------------------
		lQuantity = dwSource.GetItemNumber(dwSource.GetRow(), "nquantity")
		if lQuantity = 0 then return 0
		
		
		// -----------------------------------------
		// Menge erfragen
		// -----------------------------------------
		strOpen.lQuantity = lQuantity
		strOpen.sText     = dwSource.GetItemString(dwSource.GetRow(), "cproduction_text")
		OpenWithParm(w_manual_quantity, strOpen)
		
		lReturnQuantity = Long(Message.StringParm)
		
		if isnull(lReturnQuantity) then return 0
		if lReturnQuantity <= 0 then return 0
		
		
		this.SetRedraw(false)
		dwSource.AcceptText()
		this.SetFocus()
		// -----------------------------------------
		// St$$HEX1$$fc00$$ENDHEX$$ckliste ins Stauort Array 
		// -----------------------------------------
		lComponentRow = dwSource.GetRow()
		wf_insert(this.GetItemNumber(row, "nloadrow"), lComponentRow, lReturnQuantity)
		
		// -----------------------------------------
		// Stauort Array neu ins datawindow laden
		// -----------------------------------------
		sVerticalScroll = dw_stowages.Describe("datawindow.verticalscrollposition")
		wf_load_stowages()
		this.Filter()
		this.Sort()
		
		this.ScrollToRow(row)
		dw_stowages.Modify("datawindow.verticalscrollposition=" + sVerticalScroll)
		// --------------------------------------------------------------------------
		// Wert reduzieren, wenn 0 dann Zeile l$$HEX1$$f600$$ENDHEX$$schen
		// iDragDrop setzten, damit im RowFocusChanged der Filter nicht gesetzt wird
		// --------------------------------------------------------------------------
		iDragDrop = 1
		
		dwSource.SetItem(dwSource.GetRow(), "nquantity", lQuantity - lReturnQuantity)
		if dwSource.GetItemNumber(dwSource.GetRow(), "nquantity") = 0 then
			dwSource.DeleteRow(dwSource.GetRow())
		end if
		
		iDragDrop = 0
		
		if lComponentRow <= dw_components.RowCount() then
			dw_components.ScrollToRow(lComponentRow)
		elseif lComponentRow > dw_components.RowCount() then
			dw_components.ScrollToRow(dw_components.RowCount())
		end if
		
		
		this.SetRedraw(true)
		
		bChange = true
		w_manual_distribution.trigger event ue_masterupdate()
		pb_reset.enabled = true
		
	// --------------------------------------------------------------
	// 
	// Drop innerhalb des Datawindows
	// 
	// --------------------------------------------------------------
	elseif dwSource = dw_stowages then 

		lRowSource = dwSource.GetRow()
		if isnull(sLabelRow) or sLabelRow = "" then return 0
		if lRowSource = Row then return 0
		if lRowSource <= 0 then return 0
		
		if isnull(this.GetItemnumber(lRowSource, "nquantity" + sLabelRow)) then return 0
		if this.GetItemnumber(lRowSource, "nquantity" + sLabelRow) = 0 then return 0
		
		// -------------------------------------------------------------
		// Die Stauortkeys herausfinden und die Position im Array finden
		// an der die Stauorte stehen
		// -------------------------------------------------------------
		// lStowageKeySource			= this.GetItemnumber(lRowSource, "nstowage_key")
		// lStowageKeyDestination	= this.GetItemnumber(Row, "nstowage_key")
		lStowageKeySource			= this.GetItemnumber(lRowSource, "nloadrow")
		lStowageKeyDestination	= this.GetItemnumber(Row, "nloadrow")
		
		if lStowageKeySource	= lStowageKeyDestination then return 0
		lPosSource					= wf_find_stowage(lStowageKeySource)
		lPosDestination			= wf_find_stowage(lStowageKeyDestination)
		if lPosSource <= 0 or lPosDestination <= 0 then return 0
		
		// --------------------------------------------------------------
		// Eine Label in der Vorschau kann 5 Zeilen darstellen, danach
		// wird das "Label" dupliziert, im StaurtObjekt im Array stehem
		// die Datens$$HEX1$$e400$$ENDHEX$$tze der Reihe nach im Datastore.
		// --------------------------------------------------------------
		if this.GetItemNumber(lRowSource, "ncopy") = 1 then
			lPos = Long(sLabelRow)
		elseif this.GetItemNumber(lRowSource, "ncopy") > 1 then
			lPos = ((this.GetItemNumber(lRowSource, "ncopy") - 1) * 5) + Long(sLabelRow)
		end if	
		if lPos <= 0 then return 0

		// -----------------------------------------
		// Menge = 0 , dann zur$$HEX1$$fc00$$ENDHEX$$ck
		// -----------------------------------------
		lQuantity = dwSource.GetItemNumber(lRowSource, "nquantity" + sLabelRow)
		if lQuantity = 0 then return 0
		
		// -----------------------------------------
		// Menge erfragen
		// -----------------------------------------
		strOpen.lQuantity = lQuantity
		strOpen.sText     = dwSource.GetItemString(dwSource.GetRow(), "ccontent" + sLabelRow)
		OpenWithParm(w_manual_quantity, strOpen)
		
		lReturnQuantity = Long(Message.StringParm)
		
		if isnull(lReturnQuantity) then return 0
		if lReturnQuantity <= 0 then return 0
		
		this.SetRedraw(false)
		dwSource.AcceptText()
		this.SetFocus()
		// -----------------------------------------
		// St$$HEX1$$fc00$$ENDHEX$$ckliste ins Stauort Array 
		// -----------------------------------------
		wf_move(lPos, lPosSource, lPosDestination, lReturnQuantity)
		
		// -----------------------------------------
		// Stauort Array neu ins datawindow laden
		// -----------------------------------------
		sVerticalScroll = dw_stowages.Describe("datawindow.verticalscrollposition")
		wf_load_stowages()
		this.Filter()
		this.Sort()
		
		this.ScrollToRow(row)
		dw_stowages.Modify("datawindow.verticalscrollposition=" + sVerticalScroll)
		this.SetRedraw(true)
		
		bChange = true
		w_manual_distribution.trigger event ue_masterupdate()
		pb_reset.enabled = true
		
	end if
	
end if

sLabelRow = ""

end event

event constructor;
this.SetPosition("nhide_1", "", false)
this.SetPosition("nhide_2", "", false)
this.SetPosition("nhide_3", "", false)
this.SetPosition("nhide_4", "", false)
this.SetPosition("nhide_5", "", false)
end event

event doubleclicked;Long I, lStowageKey, lBelly, lLoadRow

if row <= 0 then return 0
if row > this.RowCount() then return 0

lStowageKey = this.GetItemNumber(row, "nstowage_key")
lBelly 		= this.GetItemNumber(row, "nbelly")
lLoadRow		= this.GetItemNumber(row, "nloadrow")

for i = 1 to UpperBound(uoDistribution.uoStowages)
	
	//if uoDistribution.uoStowages[i].lStowageKey = lStowageKey and uoDistribution.uoStowages[i].lBelly = lBelly then 
	if uoDistribution.uoStowages[i].lLoadRow = lLoadRow then
		if isvalid(w_manual_distribution_show_stowage) then close(w_manual_distribution_show_stowage)
		openwithparm(w_manual_distribution_show_stowage, uoDistribution.uoStowages[i])
		exit
	end if
	
next

end event

event clicked;if dw_select.visible then pb_1.TriggerEvent(Clicked!)
end event

type ddplb_components from dropdownpicturelistbox within w_manual_distribution
integer x = 434
integer y = 20
integer width = 955
integer height = 384
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
boolean sorted = false
borderstyle borderstyle = stylelowered!
string picturename[] = {"..\resource\apple.gif","UserObject5!","DataWindow5!","Error!"}
long picturemaskcolor = 536870912
end type

event selectionchanged;
if index <= 0 then return 0

wf_load(index)
end event

type st_2 from statictext within w_manual_distribution
integer x = 55
integer y = 40
integer width = 329
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80663510
string text = "Auswahl:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_reset from picturebutton within w_manual_distribution
integer x = 3575
integer y = 508
integer width = 174
integer height = 152
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "..\Resource\standard.gif"
string disabledname = "..\Resource\standard_disabled.gif"
alignment htextalign = left!
end type

event clicked;if uf.mbox("Achtung", "M$$HEX1$$f600$$ENDHEX$$chten Sie die Einstellungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen?", Question!, YesNo!, 1) = 2 then
	return 0
end if

f_set_pointer_hourglass(handle(this))
parent.SetRedraw(false)

uoDistribution = uoDistributionSave.of_clone()

wf_load(1)
wf_load_stowages()
if dw_components.RowCount() > 0 then wf_set_stowage_filter(dw_components, 1)

ddplb_components.Enabled = true
ddplb_components.DeleteItem(4)
ddplb_components.SelectItem(1)

bChange 				= false
pb_save.enabled 	= false
pb_run.enabled 	= true


parent.trigger event ue_masterupdate()

f_set_pointer_arrow()
parent.SetRedraw(true)

end event

type p_indicator from picture within w_manual_distribution
boolean visible = false
integer x = 3918
integer y = 696
integer width = 101
integer height = 72
string picturename = "..\Resource\Indicator.bmp"
boolean focusrectangle = false
end type

type pb_run from picturebutton within w_manual_distribution
integer x = 3575
integer y = 320
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\run_enabled.gif"
string disabledname = "..\Resource\run_disabled.gif"
alignment htextalign = left!
end type

event clicked;// -----------------------------------------------------
// Los gehts ....
// Verteilung Mahlzeiten / Extrabeladung
// Parameter:
// 1 = Mahlzeiten
// 2 = Extrabeladung
// 3 = SPML's
// -----------------------------------------------------
String	sFilter

f_set_pointer_hourglass(handle(this))
parent.SetRedraw(false)

// wf_mcd_prepare()
// uoDistribution.of_distribution(3)

// -----------------------------------------------------
// 04.05.06
// Alten Filter merken
// -----------------------------------------------------
sFilter = dw_stowages.Describe("datawindow.table.filter")

if len(sFilter) <= 2 then
	sFilter = ""
end if

uoDistribution.of_distribution(3)
uoDistribution.of_distribution(1)
uoDistribution.of_distribution(2)
uoDistribution.of_to_errorlist(1)
uoDistribution.of_to_errorlist(2)
uoDistribution.of_to_errorlist(3)
uoDistribution.of_distribution_errorlist()

// -----------------------------------------------------
// 08.05.2006 
// Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse erst am Ende bef$$HEX1$$fc00$$ENDHEX$$llen
// -----------------------------------------------------
if uoDistribution.iMixed = 1 then
	uoDistribution.of_log("Removing MultiClassFlag .......")
	uoDistribution.of_remove_multiclass_flag()
	uoDistribution.of_distribution_errorlist()
end if 

if uoDistribution.iMCD = 1 then 
	dw_stowages.SetFilter("")
	dw_stowages.Filter()
	wf_mcd_complete()
end if

uoDistribution.of_to_errorlist(1)
uoDistribution.of_to_errorlist(2)
uoDistribution.of_to_errorlist(3)

if uoDistribution.dsDistributionErrors.RowCount() > 0 then
	ddplb_components.Additem(uf.translate("Fehler"), 4)
else
	ddplb_components.Additem(uf.translate("Verteilung erfolgreich"), 4)
end if
ddplb_components.Selectitem(4)
ddplb_components.enabled = false

wf_load(4)
wf_load_stowages()

if dw_components.RowCount() > 0 then 
	
	wf_set_stowage_filter(dw_components, 1)
	
else
	
	dw_stowages.SetFilter(sFilter)
	dw_stowages.Filter()
	
end if

//if uoDistribution.iMCD = 1 then
//	dw_stowages.SetSort("nranking, nunit_priority, cen_stowage_nsort")
//else
//	dw_stowages.SetSort("nclass_number, nranking, nunit_priority, cen_stowage_nsort")
//end if

dw_stowages.Sort()

pb_run.enabled 	= false
bChange = true
parent.trigger event ue_masterupdate()

parent.SetRedraw(True)
f_set_pointer_arrow()

end event

type pb_save from picturebutton within w_manual_distribution
integer x = 3575
integer y = 132
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\docs7_write.gif"
alignment htextalign = left!
end type

event clicked;uo_distribution uoReturn

if uf.mbox("Achtung", "M$$HEX1$$f600$$ENDHEX$$chten Sie die $$HEX1$$c400$$ENDHEX$$nderungen speichern und das Fenster schliessen?", Question!, YesNo!, 1) = 2 then
	return 0
end if

//uoReturn = create uo_distribution
//uoReturn = parent.uoDistribution.of_clone()
//strReturn.uoReturn		= uoReturn


//Messagebox("", uoDistribution.sHandlingString)

strReturn.uoReturn		= uoDistribution
strReturn.bSuccessful 	= true

closewithreturn(parent, strReturn)


end event

type pb_exit from picturebutton within w_manual_distribution
integer x = 3575
integer y = 2412
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
alignment htextalign = left!
end type

event clicked;int iReturn


if bChange then

	iReturn = uf.mbox("Speichern","Sie haben Daten ge$$HEX1$$e400$$ENDHEX$$ndert, m$$HEX1$$f600$$ENDHEX$$chten Sie speichern ?",Question!,YesNoCancel!,1)
	
	If iReturn = 1 Then				// Speichern
	
		strReturn.uoReturn		= parent.uoDistribution
		strReturn.bSuccessful 	= true
	
	ElseIf iReturn = 2 Then			// nicht Speichern
		
		strReturn.bSuccessful 	= false
		
	ElseIf iReturn = 3	Then		// Abbruch
		return 0
	End if

else

	strReturn.bSuccessful = false
	
end if

closewithreturn(parent, strReturn)
end event

type uo_statusbar from uo_comctl_statusbar within w_manual_distribution
integer x = 5
integer y = 2604
integer taborder = 60
end type

type st_shadow_12 from statictext within w_manual_distribution
integer x = 3570
integer y = 2408
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_shadow_1 from statictext within w_manual_distribution
integer x = 3570
integer y = 128
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_manual_distribution
integer x = 3570
integer y = 316
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_manual_distribution
integer x = 3570
integer y = 504
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_components from datawindow within w_manual_distribution
event uo_mousemove pbm_dwnmousemove
event type integer ue_validation ( string sfield,  long lrow,  string sdata )
integer x = 9
integer y = 128
integer width = 3529
integer height = 696
integer taborder = 80
string dragicon = "..\resource\dragdrop.ico"
string title = "none"
string dataobject = "dw_uo_cen_out_meals_display"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event uo_mousemove;String sObject

sObject = dwo.name

if KeyDown(KeyLeftButton!) and sObject =  "compute_row" then
	this.Drag(Begin!)
end if

end event

event type integer ue_validation(string sfield, long lrow, string sdata);s_select_tlc 	str_open_selection
s_select_tlc	str_params
blob				bBlob
s_esl			 	strESL
long 				lRet

choose case sField
		
	// ---------------------------
	//  Mealcodes
	// ---------------------------
	case "cmeal_control_code"
		
		if isnull(sData) or sData = "- -" or sData = "" or Trim(sData) = "-" then
			sData = "----"
			this.Post SetItem(lRow, sField, sData)
			return 0
		end if
				
		if f_check_mealcode(sData) <> 0 then
			str_open_selection.lreturn = 1
			SetNull(bBlob)
			str_open_selection.bData = bBlob
			OpenWithParm(w_select_mealcode, str_open_selection)
			str_open_selection = Message.PowerObjectParm
			if not isvalid(str_open_selection) then return 1
			this.Post SetItem(lRow, sField, str_open_selection.sReturn)
		end if
		
	case "cpackinglist"
		
		lRet = f_check_packinglist(sData)
	
		if lRet = -1 then
			return 1
		else
			strESL  = f_get_packinglist_text_and_type(lRet, DateTime(Today()))
			this.Post SetItem(lRow, sField, strESL.sPackinglist)
			this.SetItem(lRow, "cproduction_text", strESL.sEslText)
		end if
	
	case "sys_packinglist_types_ctext"
		
		lRet = f_get_packinglist_sys_type(sData)
	
		if lRet = -1 then
			str_open_selection.lReturn = 1
			SetNull(bBlob)
			str_open_selection.bData = bBlob
				
			OpenWithParm(w_select_packinglist_sys_type, str_open_selection)
			
			str_open_selection = Message.PowerObjectParm
			
			if not isvalid(str_open_selection) then return 1
			
			if str_open_selection.lReturn <> -1 then	
				
				this.Post SetItem(lRow, "npltype_key", str_open_selection.lReturn)
				this.Post SetItem(lRow, "sys_packinglist_types_ctext", str_open_selection.sReturn)
				
			end if
			
		else
			
			this.SetItem(lRow, "npltype_key", lRet)
			
		end if
	
end choose

return 0
end event

event buttonclicked;Blob bBlob

s_select_tlc 	str_open_selection
s_esl				strESL



choose case dwo.name
	
	// ---------------------------
	// Packinglist suche
	// ---------------------------		
	case "b_esl"
	
		str_open_selection.lreturn = 1
		SetNull(bBlob)
		str_open_selection.bData = bBlob
		str_open_selection.iWithCancelButton = 1
				
		OpenWithParm(w_select_packinglist, str_open_selection)
		
		str_open_selection = Message.PowerObjectParm
		
		if not isvalid(str_open_selection) then return 0
		
		if str_open_selection.lReturn <> -1 then
						
			this.SetItem(row, "cpackinglist", str_open_selection.sReturn)
			this.SetItem(Row, "npackinglist_index_key", str_open_selection.lReturn)
			
			strESL  = f_get_packinglist_text_and_type(str_open_selection.lReturn, DateTime(Today()))
			this.SetItem(row, "cpackinglist", strESL.sPackinglist)
			this.SetItem(row, "cproduction_text", strESL.sEslText)
			
		end if	
		
	case "b_control_code"
		
		str_open_selection.lreturn = 1
		SetNull(bBlob)
		str_open_selection.bData = bBlob
		str_open_selection.iWithCancelButton = 1
		
		OpenWithParm(w_select_mealcode, str_open_selection)
			
		str_open_selection = Message.PowerObjectParm
		
		if not isvalid(str_open_selection) then return 0

		if str_open_selection.lReturn <> -1 then
						
			this.Post SetItem(row, "cmeal_control_code", str_open_selection.sReturn)		
			
		end if	
		
	case "b_type"	
		
		str_open_selection.lReturn = 1
		SetNull(bBlob)
		str_open_selection.bData = bBlob
		str_open_selection.iWithCancelButton = 1								
		
		OpenWithParm(w_select_packinglist_sys_type, str_open_selection)
		
		str_open_selection = Message.PowerObjectParm
		
		if not isvalid(str_open_selection) then return 0
		
		if str_open_selection.lReturn <> -1 then	
			
			this.SetItem(row, "npltype_key", str_open_selection.lReturn)
			this.SetItem(row, "sys_packinglist_types_ctext", str_open_selection.sReturn)
			
		end if
			
end choose

return 0
end event

event itemchanged;//
// Pr$$HEX1$$fc00$$ENDHEX$$fung der Eingaben
//
integer iRet

if row > 0 then
	
	iRet = this.trigger event ue_validation(dwo.name, row, data)
	
	if iRet <> 0 then
		return 1
	end if
end if

end event

event rowfocuschanged;
wf_set_statusbar()

if currentrow <= 0 then return 0

if iDragDrop = 0 then
	wf_set_stowage_filter(this, currentrow)
end if
end event

event dragdrop;DataWindow 	dwSource
Long 			lQuantity, &
				lReturnQuantity, &
				lRowSource, &
				lStowageKeySource, &
				lPosSource, &
				lPos, &
				lRow

String		sFilter, &
				sVerticalScroll

s_distribution_quantities	strOpen

IF source.TypeOf() = DataWindow! THEN
	
	dwSource = source
		
	// --------------------------------------------------------------
	// 
	// Drop innerhalb des Datawindows
	// 
	// --------------------------------------------------------------
	if dwSource = dw_stowages then 

		lRowSource = dwSource.GetRow()
		if isnull(sLabelRow) or sLabelRow = "" then return 0
		if lRowSource = Row then return 0
		if lRowSource <= 0 then return 0
		
		if isnull(dwSource.GetItemnumber(lRowSource, "nquantity" + sLabelRow)) then return 0
		if dwSource.GetItemnumber(lRowSource, "nquantity" + sLabelRow) = 0 then return 0
		
		// -------------------------------------------------------------
		// Die Stauortkeys herausfinden und die Position im Array finden
		// an der die Stauorte stehen
		// -------------------------------------------------------------
		//lStowageKeySource			= dwSource.GetItemnumber(lRowSource, "nstowage_key")
		lStowageKeySource			= dwSource.GetItemnumber(lRowSource, "nloadrow")
		lPosSource					= wf_find_stowage(lStowageKeySource)
		if lPosSource <= 0 or lStowageKeySource <= 0 then return 0
		
		// --------------------------------------------------------------
		// Eine Label in der Vorschau kann 5 Zeilen darstellen, danach
		// wird das "Label" dupliziert, im StaurtObjekt im Array stehem
		// die Datens$$HEX1$$e400$$ENDHEX$$tze der Reihe nach im Datastore.
		// --------------------------------------------------------------
		if dwSource.GetItemNumber(lRowSource, "ncopy") = 1 then
			lPos = Long(sLabelRow)
		elseif dwSource.GetItemNumber(lRowSource, "ncopy") > 1 then
			lPos = ((this.GetItemNumber(lRowSource, "ncopy") - 1) * 5) + Long(sLabelRow)
		end if	
		if lPos <= 0 then return 0

		// -----------------------------------------
		// Menge = 0 , dann zur$$HEX1$$fc00$$ENDHEX$$ck
		// -----------------------------------------
		lQuantity = dwSource.GetItemNumber(lRowSource, "nquantity" + sLabelRow)
		if lQuantity = 0 then return 0
		
		// -----------------------------------------
		// Menge erfragen
		// -----------------------------------------
		strOpen.lQuantity = lQuantity
		strOpen.sText 		= dwSource.GetItemString(lRowSource, "ccontent" + sLabelRow)
		OpenWithParm(w_manual_quantity, strOpen)
		
		lReturnQuantity = Long(Message.StringParm)
		
		if isnull(lReturnQuantity) then return 0
		if lReturnQuantity <= 0 then return 0
		
		dwSource.SetRedraw(false)
		dwSource.AcceptText()
		this.SetFocus()
		// -----------------------------------------
		// St$$HEX1$$fc00$$ENDHEX$$ckliste ins Stauort Array 
		// -----------------------------------------
		//Messagebox("", "lPos " + string(lPos) + "~rlPOsSource " + string(lPosSource) )
		iDragDrop = 1
		wf_unload(lPos, lPosSource, lReturnQuantity)
		iDragDrop = 0
		// -----------------------------------------
		// Stauort Array neu ins datawindow laden
		// -----------------------------------------
		sVerticalScroll = dw_stowages.Describe("datawindow.verticalscrollposition")
		wf_load_stowages()
		dwSource.Filter()
		dwSource.Sort()
		
		dwSource.ScrollToRow(row)
		dw_stowages.Modify("datawindow.verticalscrollposition=" + sVerticalScroll)
		dwSource.SetRedraw(true)
		
		bChange = true
		w_manual_distribution.trigger event ue_masterupdate()
		pb_reset.enabled = true
		
	end if
	
end if

sLabelRow = ""

end event

event clicked;

if row > 0 then this.scrolltorow(row)

if dw_select.visible then pb_1.TriggerEvent(Clicked!)
end event

type st_4 from statictext within w_manual_distribution
integer x = 3570
integer y = 688
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_manual_distribution
integer x = 1632
integer y = 20
integer width = 457
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

