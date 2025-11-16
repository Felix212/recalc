HA$PBExportHeader$uo_get_aircraft.sru
$PBExportComments$Loading Diagram erstellen
forward
global type uo_get_aircraft from nonvisualobject
end type
end forward

global type uo_get_aircraft from nonvisualobject
end type
global uo_get_aircraft uo_get_aircraft

type variables
//===================================================================
//
// uo_get_aircraft
//
//===================================================================
//
// instance
//
//===================================================================

public:

//-------------------------------------------------------------------
//
// Von au$$HEX1$$df00$$ENDHEX$$en zu setzende Properties
//
//-------------------------------------------------------------------
long		lAirline_key
string	sOwner
string	sActype

string	sClass[]

integer	iVersion[]
integer	iClassNumber[]

//-------------------------------------------------------------------
//
// R$$HEX1$$fc00$$ENDHEX$$ckgabe-Treffer
//
//-------------------------------------------------------------------
long		lAircraft_key	= -1
long		lGroup_key		= -1
long		lOwner_key		= -1
string	sStatustext
string	sGalleyVersion
string	sVersionString
//-------------------------------------------------------------------
//
// interne Properties
//
//-------------------------------------------------------------------
private:
datastore	dsAircraftResearch

//
// Die ermittelte Version
//
string	sFoundClass[]
integer	iFoundVersion[]
integer	iFoundClassNumber[]

integer	iMaxBookingClass
string	sInputVersion
string	sEmptyClass[]
integer	iEmptyVersion[]
integer	iEmptyClassNumber[]

end variables

forward prototypes
public function string of_calc_booking_class ()
public function integer of_get_max_booking_class ()
public function integer of_get_aircraft ()
public function string of_get_input_version ()
end prototypes

public function string of_calc_booking_class ();//
// of_calc_booking_class
//
string	sReturn
long		i,j
boolean	bExit = false
long		lStart = 1

for i = 1 to upperbound(iFoundClassNumber)
	for j = lStart to iMaxBookingClass
		if iFoundClassNumber[i] <> j then
			sReturn += "000-"
			continue
		else
			sReturn += string(iFoundVersion[i],"000") + "-"
			lStart = iFoundClassNumber[i] + 1
			exit
		end if
	next
next	

sReturn = mid(sReturn,1,len(sReturn) -1)

return sReturn


//for i = 1 to iMaxBookingClass
//	//
//	// Versionsstring basteln
//	//
//	if i <> iClassNumber[i] then
//		sVersionString += "000/"
//	else
//		sVersionString += string(iVersion[i],"000") + "/"
//	end if
//		
//	sVersionString = mid(sVersionString,1,len(sVersionString) -1)
//next
//
//return sVersionString

end function

public function integer of_get_max_booking_class ();//
// of_get_max_booking_class
//
// Was ist die h$$HEX1$$f600$$ENDHEX$$chste Buchungsklasse f$$HEX1$$fc00$$ENDHEX$$r diese Airline
//
integer	iRet

select max(nclass_number) 
  into :iRet
  from cen_class_name
 where cen_class_name.nairline_key = :lAirline_key
	and cen_class_name.nbooking_class = 1;
	
if sqlca.sqlcode <> 0 then
	return setnull(iRet)
end if

return iRet

end function

public function integer of_get_aircraft ();//===================================================================
//
// of_get_aircraft
//
//===================================================================
//
// UserObjekt holt den passenden Aircraft-Key aus cen_aircraft_types
// und den entsprechenden Group-Key aus cen_aircraft_configurations.
//
//===================================================================
long 		lFind, lMaxFind, lFrom, lFrom_old
integer	i,j
integer	iClassCount
integer	iClassNumberCount
integer	iVersionCount
string	sFind

string	lsClass
long		llVersion
long		llGroup_key

integer	iTreffer		// Anzahl gefundene Treffer innerhalb einer Version aufgrund der Version
integer	iGesamt		// Anzahl g$$HEX1$$fc00$$ENDHEX$$ltige Flugger$$HEX1$$e400$$ENDHEX$$te

long		lAircraft_key_old
long		lCounter

//
// Pr$$HEX1$$fc00$$ENDHEX$$fe Properties
//
if len(trim(sOwner)) = 0 or isnull(sOwner) then
	sStatustext = "Property sOwner wasn't set!"
	return -1
end if

if len(trim(sActype)) = 0 or isnull(sActype) then
	sStatustext = "Property sActype wasn't set!"
	return -1
end if

iClassCount = upperbound(sClass)
if iClassCount <= 0 then
	sStatustext = "Property sClass[] wasn't set!"
	return -1
end if
	
iVersionCount = upperbound(iVersion)
if iVersionCount <= 0 then
	sStatustext = "Property iVersion[] wasn't set!"
	return -1
end if

iClassNumberCount = upperbound(iClassNumber)
if iClassNumberCount <= 0 then
	sStatustext = "Property iClassNumber[] wasn't set!"
	return -1
end if

if iClassCount <> iClassNumberCount then
	sStatustext = "Array iClassNumber[] doesn't match sClass[]!"
	return -1
end if

if iClassCount <> iVersionCount then
	sStatustext = "Array sClass[] doesn't match iVersion[]!"
	return -1
end if

//
// h$$HEX1$$f600$$ENDHEX$$chste Buchungsklasse ermitteln
//
iMaxBookingClass	= of_get_max_booking_class()

if isnull(iMaxBookingClass) then
	sStatustext = "Couldn't find the maximum classnumber for the airline!"
	return -1
end if
	
//
// $$HEX1$$dc00$$ENDHEX$$bergebene Version als String umwandeln
//
sInputVersion = of_get_input_version()

//
// Hole alle Aircraft-Typen der Eigner-Typ-Kombination
//
dsAircraftResearch.Retrieve(s_app.sMandant, sOwner, sActype)
if dsAircraftResearch.RowCount() = 0 then
	sGalleyVersion	= "XX"
	sStatustext = "No results for this aircraft: " + sOwner + " " + sActype
	return -1
end if

//
// Falls nur ein Aircraft-Key, dann eindeutig
//
if dsAircraftResearch.RowCount() = 1 then
	sStatustext 	= "Found one aircraft: " + sOwner + " " + sActype
	lAircraft_key 	= dsAircraftResearch.GetItemNumber(1,"naircraft_key")
	lGroup_key		= dsAircraftResearch.GetItemNumber(1,"ngroup_key")
	lOwner_key		= dsAircraftResearch.GetItemNumber(1,"nairline_owner_key")
	sGalleyVersion	= dsAircraftResearch.GetItemString(1,"cgalleyversion")
	sVersionString = sInputVersion
	return 0
end if


dsAircraftResearch.SetSort("naircraft_key A, ngroup_key A, cen_class_name_nclass_number A")
dsAircraftResearch.Sort()

lMaxFind = 0
lFrom		= 1	// Durchsucht ab der ersten Zeile des Datastores

//
// Solange der Datastore noch nicht durchw$$HEX1$$fc00$$ENDHEX$$hlt ist...
//
Do 
	//
	// Versuchen, die Version zu finden
	//
	for i = 1 to iClassCount
		//
		// Nach dem ersten Treffer mu$$HEX2$$df002000$$ENDHEX$$der Group-key ber$$HEX1$$fc00$$ENDHEX$$cksichtigt werden
		//
		if i > 1 then
			sFind = "cclass = '" + sClass[i] + "' and nversion = " + string(iVersion[i]) + &
					  " and ngroup_key = " + string(llGroup_key)
			lFind = dsAircraftResearch.Find(sFind,lFrom,dsAircraftResearch.RowCount())
			if lFind > lMaxFind then lMaxFind = lFind + 1
		else
			sFind = "cclass = '" + sClass[i] + "' and nversion = " + string(iVersion[i])
			lFind = dsAircraftResearch.Find(sFind,lFrom,dsAircraftResearch.RowCount())
			if lFind > lMaxFind then lMaxFind = lFind + 1
		end if
		//
		// Version bauen
		//
		if lFind > 0 then
			iFoundClassNumber[i] = dsAircraftResearch.GetItemNumber(lFind,"cen_class_name_nclass_number")
			iFoundVersion[i] 		= dsAircraftResearch.GetItemNumber(lFind,"nversion")
		end if
		
		if lFind = 0 and iGesamt = 0 then
			iFoundClassNumber	= iEmptyClassNumber
			iFoundVersion		= iEmptyVersion
		end if
		
		if lFind > 0 then
			iTreffer++
			//
			// Ab einem Treffer mu$$HEX2$$df002000$$ENDHEX$$der Group-Key gesetzt werden, um weitere Klassen aufzusp$$HEX1$$fc00$$ENDHEX$$ren
			// 
			if iTreffer = 1 then
				llGroup_key		= dsAircraftResearch.GetItemNumber(lFind,"ngroup_key")
			end if
			
			//
			// Wenn soviel Treffer wie Klassen vorhanden sind, dann haben wir einen g$$HEX1$$fc00$$ENDHEX$$ltigen AC-Typ
			//
			if iTreffer = iClassCount and iGesamt = 0 then
				lAircraft_key	= dsAircraftResearch.GetItemNumber(lFind,"naircraft_key")
				lGroup_key 		= llGroup_key
				lOwner_key		= dsAircraftResearch.GetItemNumber(lFind,"nairline_owner_key")
				sGalleyVersion	= dsAircraftResearch.GetItemString(lFind,"cgalleyversion")
				sVersionString = of_calc_booking_class()
				iGesamt++
				iTreffer = 0
			end if
			
			//
			// Wenn ein G$$HEX1$$fc00$$ENDHEX$$ltiger AC-Typ gefunden wird, dann nur verwenden, falls dieser
			// ein default-AC-Typ ist
			//
			if iTreffer = iClassCount and iGesamt >= 1 and &
				dsAircraftResearch.GetItemNumber(lFind,"ndefault_actype") = 1 then
				//
				// Problem: es gen$$HEX1$$fc00$$ENDHEX$$gt die $$HEX1$$dc00$$ENDHEX$$bereinstimmung einer Klasse um die neuen GroupKeys zu setzen
				//
				lAircraft_key	= dsAircraftResearch.GetItemNumber(lFind,"naircraft_key")
				lGroup_key 		= llGroup_key
				lOwner_key		= dsAircraftResearch.GetItemNumber(lFind,"nairline_owner_key")
				sGalleyVersion	= dsAircraftResearch.GetItemString(lFind,"cgalleyversion")
				sVersionString = of_calc_booking_class()
				iGesamt++
				iTreffer = 0
			end if
		elseif lFind = 0 and iGesamt > 0 and iTreffer = 0 then
			//
			// Es wurde ein Treffer erzielt aber keine weiteren mehr
			//
			lFrom++
			exit
		elseif lFind = 0 and iGesamt = 0 and iTreffer = 0 then
			//
			// Es wird nicht einmal mehr ein Treffer ohne Group-Key erzielt,
			// dann ist nichts mehr zu wollen.
			//
			lAircraft_key 	= -1
			lGroup_key 		= -1
			sVersionString = sInputVersion
			sGalleyVersion	= "XX"
			sStatustext = "No results for this aircraft: " + sOwner + " " + sActype
			return -1
		end if
	next
	if lFrom < lMaxfind then lFrom = lMaxfind
	//
	// Falls stets die gleichen gefunden werden mu$$HEX2$$df002000$$ENDHEX$$Endlosschleife verhindert werden
	//
	if lFrom = lFrom_old then
		lFrom++
	end if
	lFrom_old = lFrom
	iTreffer = 0
loop until lMaxFind >= dsAircraftResearch.RowCount() or lFrom >= dsAircraftResearch.RowCount()

if iGesamt = 0 then
	lAircraft_key 	= -1
	lGroup_key 		= -1
	sGalleyVersion	= "XX"
	sStatustext = "No results for this aircraft: " + sOwner + " " + sActype
	sVersionString = sInputVersion	// falls nichts gefunden, dann Version aus gesetzten Daten bilden
	return -1
end if	

return 0

end function

public function string of_get_input_version ();//
// of_get_input_version
//
string	sReturn
long		i,j
boolean	bExit = false
long		lStart = 1

for i = 1 to upperbound(iClassNumber)
	for j = lStart to iMaxBookingClass
		if iClassNumber[i] <> j then
			sReturn += "000-"
			continue
		else
			sReturn += string(iVersion[i],"000") + "-"
			lStart = iClassNumber[i] + 1
			exit
		end if
	next
next	

sReturn = mid(sReturn,1,len(sReturn) -1)

return sReturn

end function

on uo_get_aircraft.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_get_aircraft.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
dsAircraftResearch	= create datastore
dsAircraftResearch.DataObject = "dw_aircraft_research"
dsAircraftResearch.SetTransObject(SQLCA)



end event

event destructor;
destroy dsAircraftResearch

end event

