HA$PBExportHeader$uo_get_rotation.sru
$PBExportComments$Userobject zum Ermittlung des Umlaufs (einer Mahlzeit oder einer Extrabeladung)
forward
global type uo_get_rotation from nonvisualobject
end type
end forward

global type uo_get_rotation from nonvisualobject
end type
global uo_get_rotation uo_get_rotation

type variables

date 			dRotationDate
date			dStartDate
long			lRotationKey
string		sUnit = ""
string		sErrorMessage = ""
integer  	iStatus


Long			lRotationSingleKey 		// Key des Umlaufs der Rotation (nrotation_name_key aus cen_rotation_names)
Long			lRotationID			 		// Nummer des Umlaufs (nrotation aus cen_rotation_names)
Long			lRotationDuration	 		// Dauer des Umlaufs (nrotation_duration aus cen_rotation_names)
Long			lRotationDurationSum		// Summer aller nrotation_duration einer Rotation
Long			lRotationType		 		// Art der Rotation (w$$HEX1$$f600$$ENDHEX$$chentlich/monatlich)
Long			lRotationOffset	 		// Versatz zum Umlauf 1

Long 			lUnitsAfter 				// Tage/Monate zwischen dtStartDate und dtRotationDate
Long 			lDivRest 					// Divisions Rest
Long			lDayToSkip
			
String		sRotationName		 		// Names der Rotation
String		sRotationText		 		// Names des Umlaufs innerhalb der Rotation

datastore	dsRotation, &
				dsRotationNames, &
				dsRotationOffset, &
				dsRotationExceptions, &
				dsRotationsZonex		//30.03.2011 MB: Datastore f$$HEX1$$fc00$$ENDHEX$$r Zone Exceptions
				
				
				
end variables

forward prototypes
public function date of_addmonth (long lmonths, date dstart)
public function integer of_calculate ()
public function integer of_decade_count (date dstart, date dende)
public function integer of_midmonth_count (date dstart, date dende)
public function integer of_month_count (date dstart, date dende)
public function integer of_get_rotation ()
public function integer of_getdirect (long lrotkey, date drotdate)
end prototypes

public function date of_addmonth (long lmonths, date dstart);Long I
Long lTag, lMonat, lJahr

lTag		= Day(dStart)
lMonat	= Month(dStart)
lJahr		= Year(dStart)

For I = 1 to lMonths
	
	lMonat ++
	
	if lMonat = 13 then
		lMonat = 1
		lJahr  ++
	end if
	
	
Next

return Date(lJahr, lMonat, lTag)

end function

public function integer of_calculate ();// -------------------------------------------------
// ermitteln des Umlaufs einer t$$HEX1$$e400$$ENDHEX$$glichen Rotation
// -------------------------------------------------
Long lRow, lDuration, lHit
Long I


if this.lRotationType = 1 then
	// --------------------------------------------------
	// Anzahl TAGE zwischen Startdatum und "Flugdatum"
	// --------------------------------------------------
	this.lUnitsAfter = DaysAfter(RelativeDate(dStartDate, -1), dRotationDate)
	
elseif this.lRotationType = 2 then
	// --------------------------------------------------
	// Anzahl MONATE zwischen Startdatum und "Flugdatum"
	// --------------------------------------------------
	this.lUnitsAfter = this.of_month_count(dStartDate, dRotationDate)
	
elseif this.lRotationType = 3 then
	// --------------------------------------------------
	// Anzahl DEKADEN zwischen Startdatum und "Flugdatum"
	// --------------------------------------------------
	this.lUnitsAfter = this.of_decade_count(dStartDate, dRotationDate)
	
elseif this.lRotationType = 4 then
	// --------------------------------------------------
	// Anzahl MONATSANF$$HEX1$$c400$$ENDHEX$$NGE u. MONATSMITTEN 
	// zwischen Startdatum und "Flugdatum"
	// --------------------------------------------------
	this.lUnitsAfter = this.of_midmonth_count(dStartDate, dRotationDate)
	
elseif this.lRotationType = 5 then
	// --------------------------------------------------
	// Anzahl ??? 
	// zwischen Startdatum und "Flugdatum"
	// --------------------------------------------------
	// Bei diesem besonderen Typ kann man die Rotation direkt aus der DB lesen
	this.of_getdirect(lRotationKey, dRotationDate)
			
	return 0
	
else
	this.sErrorMessage = "Unknown RotationType ["  + string(this.lRotationType) +  "] for "+ this.sRotationName + "!"
	this.iStatus = -1
	return -1
	
end if

// ----------------------------------------------------
// Wie oft l$$HEX1$$e400$$ENDHEX$$sst sich die Summe von nrotation_durations
// durch die Anzahl???
// Der Divisionsrest ist von interesse !!!
// ----------------------------------------------------


this.lDivRest = Mod(this.lUnitsAfter, this.lRotationDurationSum)

if this.lDivRest = 0 then 
	
	lHit = dsRotationNames.RowCount() + this.lRotationOffset
	// ----------------------------------------------
	// Die Datens$$HEX1$$e400$$ENDHEX$$tze in dsRotationNames verdoppeln
	// ----------------------------------------------
	if dsRotationNames.RowsCopy(1, dsRotationNames.RowCount(), Primary!,dsRotationNames, dsRotationNames.RowCount() + 1, Primary!) <> 1 then
		this.sErrorMessage = "Couldn't determine Offset for " + this.sRotationName + ", Rowscopy failed!"
		this.iStatus = -1
		return -1	
	end if	
	
else
	
	// ----------------------------------------------
	// Die Datens$$HEX1$$e400$$ENDHEX$$tze in dsRotationNames verdoppeln
	// ----------------------------------------------
	if dsRotationNames.RowsCopy(1, dsRotationNames.RowCount(), Primary!,dsRotationNames, dsRotationNames.RowCount() + 1, Primary!) <> 1 then
		this.sErrorMessage = "Couldn't determine Offset for " + this.sRotationName + ", Rowscopy failed!"
		this.iStatus = -1
		return -1	
	end if	
	

	
	For i = 1 + this.lRotationOffset to dsRotationNames.RowCount()
		
		lDuration += dsRotationNames.GetItemNumber(i, "nrotation_duration")
		// --------------------------------------------------
		// Treffer 
		// --------------------------------------------------
		if lDuration >= this.lDivRest then
			lHit = I
			Exit
		end if
	
	Next
	
end if

if lHit > 0 then
	this.lRotationSingleKey		= dsRotationNames.GetItemNumber(lHit, "nrotation_name_key")
	this.lRotationID				= dsRotationNames.GetItemNumber(lHit, "nrotation")
	this.lRotationDuration 		= dsRotationNames.GetItemNumber(lHit, "nrotation_duration")
	this.sRotationText			= dsRotationNames.GetItemString(lHit, "ctext")
	return 0
else
	this.sErrorMessage = "No hit in dsRotationNames ["  + string(this.lRotationType) +  "] for "+ this.sRotationName + "!"
	this.iStatus = -1
	return -1	
end if

return 0
end function

public function integer of_decade_count (date dstart, date dende);// -------------------------------------------------
//
// Anzahl der Dekaden zwischen Start und 
// Auswertungsdatum ermitteln
//
// -------------------------------------------------
Integer lCount, I, lDays, lMonth, lDay
Date dTemp

lDays = DaysAfter(dStart, dEnde)

this.lDayToSkip = Day(dStart)
lMonth = Month(dStart)

lCount = 0

for i = 1 to lDays
	
	dTemp = RelativeDate(dStart, i)
	
	if Month(dTemp) <> lMonth and Day(dTemp) >= this.lDayToSkip then
		lMonth = Month(dTemp)
		lCount ++
	end if
	
Next

// -------------------------------------------------
// Anzahl der Monat ist ermittelt, diesen Wert nun
// mit 3 multiplizieren und die Dekade des 
// Auswertungstages bestimmen.
// -------------------------------------------------

lCount = lCount * 3
lDay = Day(dEnde)

if lDay <= 10 then 
	lCount += 1
elseif lDay > 10 and lDay <= 20 then
	lCount += 2
else
	lCount += 3
end if




return lCount
end function

public function integer of_midmonth_count (date dstart, date dende);// -------------------------------------------------
//
// Anzahl der Monatsanf$$HEX1$$e400$$ENDHEX$$nge - Monatsmitten 
// zwischen Start und Auswertungsdatum ermitteln
//
// -------------------------------------------------
Integer lCount, I, lDays, lMonth, lDay
Date dTemp

lDays = DaysAfter(dStart, dEnde)

this.lDayToSkip = Day(dStart)
lMonth = Month(dStart)

lCount = 0

for i = 1 to lDays
	
	dTemp = RelativeDate(dStart, i)
	
	if Month(dTemp) <> lMonth and Day(dTemp) >= this.lDayToSkip then
		lMonth = Month(dTemp)
		lCount ++
	end if
	
Next

// -------------------------------------------------
// Anzahl der Monat ist ermittelt, diesen Wert nun
// mit 2 multiplizieren und ermitteln, in welcher
// Monatsh$$HEX1$$e400$$ENDHEX$$lfte der Auswertungstag liegt
// -------------------------------------------------

lCount = lCount * 2
lDay = Day(dEnde)

if lDay <= 15 then 
	lCount += 1
else
	lCount += 2
end if

return lCount
end function

public function integer of_month_count (date dstart, date dende);// -------------------------------------------------
//
// Anzahl der Monate zwischen Start und 
// Auswertungsdatum ermitteln
//
// -------------------------------------------------
Integer lCount, I, lDays, lMonth
Date dTemp

lDays = DaysAfter(dStart, dEnde)
this.lDayToSkip = Day(dStart)
lMonth = Month(dStart)

lCount = 1

for i = 1 to lDays
	
	dTemp = RelativeDate(dStart, i)
	
	if Month(dTemp) <> lMonth and Day(dTemp) >= this.lDayToSkip then
		lMonth = Month(dTemp)
		lCount ++
	end if
	
Next

return lCount
end function

public function integer of_get_rotation ();integer iRet
long lairline
string szone
// -----------------------------------------------------
//
// Den richtigen Umlauf anhand von Datum und Betrieb
// herausfinden
//
// -----------------------------------------------------
dsRotation.Retrieve(this.lRotationKey)
dsRotationNames.Retrieve(this.lRotationKey)	// $$HEX1$$dc00$$ENDHEX$$berfl$$HEX1$$fc00$$ENDHEX$$ssig?
dsRotationOffset.Retrieve(this.lRotationKey, this.sUnit)
dsRotationExceptions.Retrieve(this.lRotationKey, this.sUnit, this.dRotationDate)
//-----------------------------------------------------
//Gibt es Zone Exceptions?
//-----------------------------------------------------

//Erstmal nachschauen, ob der Betrieb $$HEX1$$fc00$$ENDHEX$$berhaupt zu einer Zone geh$$HEX1$$f600$$ENDHEX$$rt


// -----------------------------------------------------
//	Erstmal schaun, ob es die Rotation $$HEX1$$fc00$$ENDHEX$$berhaupt gibt
// -----------------------------------------------------
if dsRotation.RowCount() = 0 then
	this.sErrorMessage = "Couldn't find rotation " + string(this.lRotationKey) + " in cen_rotations!"
	this.iStatus = -1
	return -1
else
	// -------------------------------------------------------
	//	Wie merken uns den Namen und ob es ein w$$HEX1$$f600$$ENDHEX$$chentlicher(1)
	// monatlicher(2) dekadischer(3) monatsmitten(4)
	// oder direktzuweisungs(5) Apparat ist
	// -------------------------------------------------------
	this.sRotationName = dsRotation.GetItemString(1, "ctext")
	this.lRotationType = dsRotation.GetItemNumber(1, "nrotation_type") 
	this.dStartDate 	 = date(dsRotation.GetItemDateTime(1, "dstart_date"))
	lairline = dsRotation.GetItemNumber(1, "ncustomer_key") 
	
	if RelativeDate(this.dStartDate, -1) >= this.dRotationDate then
		this.sErrorMessage = "Startdate greater then Testdate "
		this.iStatus = -1
		return -1
	end if
	
end if

// -----------------------------------------------------
//	Schaun, ob es f$$HEX1$$fc00$$ENDHEX$$r die Rotation Details gibt          
// -----------------------------------------------------
if dsRotationNames.RowCount() = 0 then
	this.sErrorMessage = "Couldn't find detail cen_rotations_names for " + this.sRotationName + "!"
	this.iStatus = -1
	return -1
else
	// -----------------------------------------------------
	// wir merken uns die Summe der Einzelrotationen ...
	// -----------------------------------------------------
	this.lRotationDurationSum = dsRotationNames.GetItemNumber(1, "c_sum_rotation")
	// f$$HEX1$$fc00$$ENDHEX$$hr zwar zum falschen Resultat, aber besser als ein Systemerror
	// If isnull(this.lRotationDurationSum) or this.lRotationDurationSum = 0 Then this.lRotationDurationSum = 1
end if

// -----------------------------------------------------
//	Was f$$HEX1$$fc00$$ENDHEX$$r ein Offset hat der Betrieb
// -----------------------------------------------------
if dsRotationOffset.RowCount() = 1 then	// Der Betrieb hat ein abweichendes Offset

	this.lRotationOffset = dsRotationOffset.GetItemNumber(1, "nrotation_offset")
	
else // Der Betrieb hat KEIN abweichendes Offset, es wird das Default Offset gesucht
	
	dsRotationOffset.Retrieve(this.lRotationKey, "*")
	if dsRotationOffset.RowCount() = 1 then
		this.lRotationOffset = dsRotationOffset.GetItemNumber(1, "nrotation_offset")
	else
		this.sErrorMessage = "Couldn't find Offset for " + this.sRotationName + "!"
		this.iStatus = -1
		return -1
	end if
	
end if

//-----------------------------------------------------
//Gibt es Zone Exceptions?
//-----------------------------------------------------

//Erstmal nachschauen, ob der Betrieb $$HEX1$$fc00$$ENDHEX$$berhaupt zu einer Zone geh$$HEX1$$f600$$ENDHEX$$rt
Select cregion into :szone
from cen_airline_unit
where nairline_key = :lairline and cunit =:this.sUnit;

if not isNull(szone) and szone <>"" then
	//Es gibt eine zugeordnete Zone, also datastore retrieven
	dsRotationsZonex.Retrieve(this.lRotationKey, szone, this.dRotationDate)
	if dsRotationsZonex.rowcount() > 0 then
		//Es gibt eine Zone Exception, also 
		this.lRotationSingleKey		= dsRotationsZonex.GetItemNumber(1, "cen_rotation_names_nrotation_name_key")
		this.lRotationID				= dsRotationsZonex.GetItemNumber(1, "cen_rotation_zonex_nrotation")
		this.lRotationDuration 		= dsRotationsZonex.GetItemNumber(1, "cen_rotation_names_nrotation_duration")
		this.sRotationText			= dsRotationsZonex.GetItemString(1, "cen_rotation_names_ctext")
		return 0
	end if
end if
// f_print_datastore(dsRotation)
// f_print_datastore(dsRotationNames)
 // f_print_datastore(dsRotationOffset)
// f_print_datastore(dsRotationExceptions)

// -----------------------------------------------------
//	M$$HEX1$$fc00$$ENDHEX$$ssen wir $$HEX1$$fc00$$ENDHEX$$berhaupt berechnen, oder gibts es eine
// definierte Ausnahme
// -----------------------------------------------------
if dsRotationExceptions.RowCount() = 1 then // Ausnahme vorhanden

	this.lRotationSingleKey		= dsRotationExceptions.GetItemNumber(1, "nrotation_name_key")
	this.lRotationID				= dsRotationExceptions.GetItemNumber(1, "nrotation")
	this.lRotationDuration 		= dsRotationExceptions.GetItemNumber(1, "nrotation_duration")
	this.sRotationText			= dsRotationExceptions.GetItemString(1, "ctext")
	return 0
	
end if

// -----------------------------------------------------
//	Keine Ausnahme gefunden, also berechnen
// -----------------------------------------------------
iRet = this.of_calculate()	

return iRet

end function

public function integer of_getdirect (long lrotkey, date drotdate);DataStore dsDirect
dsDirect = Create DataStore
dsDirect.dataObject = "dw_uo_get_rotation_names_direct"
dsDirect.setTransObject(SQLCA)

dsDirect.retrieve(lRotKey, dRotDate, Day(dRotDate))

this.lRotationSingleKey		= dsDirect.GetItemNumber(1, "nrotation_name_key")
this.lRotationID					= dsDirect.GetItemNumber(1, "nrotation")
this.lRotationDuration 		= dsDirect.GetItemNumber(1, "nrotation_duration")
this.sRotationText				= dsDirect.GetItemString(1, "ctext")

Destroy(dsDirect)

return 0 
end function

event constructor;dsRotation				= create datastore
dsRotationNames		= create datastore
dsRotationOffset		= create datastore
dsRotationExceptions	= create datastore
dsRotationsZonex		= create datastore //MB 30.03.2011: Datastore f$$HEX1$$fc00$$ENDHEX$$r Zone exceptions


dsRotation.dataobject				= "dw_uo_get_rotation"
dsRotationNames.dataobject			= "dw_uo_get_rotation_names"		
dsRotationOffset.dataobject		= "dw_uo_get_rotation_offset"
dsRotationExceptions.dataobject	= "dw_uo_get_rotation_exception"
dsRotationsZonex.dataobject	= "dw_uo_get_rotation_zonex"

dsRotation.SettransObject(sqlca)
dsRotationNames.SettransObject(sqlca)
dsRotationOffset.SettransObject(sqlca)
dsRotationExceptions.SettransObject(sqlca)
dsRotationsZonex.SettransObject(sqlca)

end event

event destructor;Destroy(dsRotation)
Destroy(dsRotationNames)
Destroy(dsRotationOffset)
Destroy(dsRotationExceptions)
Destroy(dsRotationsZonex)
end event

on uo_get_rotation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_get_rotation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

