HA$PBExportHeader$uo_truck_sheet_control.sru
$PBExportComments$Userobjekt zur Erstellung des Truck-Check-Sheets
forward
global type uo_truck_sheet_control from nonvisualobject
end type
end forward

global type uo_truck_sheet_control from nonvisualobject
end type
global uo_truck_sheet_control uo_truck_sheet_control

type variables


datastore	dsCheckSheet	// das zu $$HEX1$$fc00$$ENDHEX$$berf$$HEX1$$fc00$$ENDHEX$$hrende Check-Sheet aus dem Print-Center

datastore	dsTruckSheet	// Pointer f$$HEX1$$fc00$$ENDHEX$$r das neu zu erstellende Truck-Sheet
datastore	dsCoverSheet	// Pointer auf Deckblatt

datastore	dsTruckSheetFinal	// Das endg$$HEX1$$fc00$$ENDHEX$$ltige Truck-Sheet


string		sAirline
integer		iFlightNumber
string		sSuffix
string		sFrom
string		sTo
date			dDeparture
string		sTime
string		sRouting
string		sCSC
string		sRegistration

string		sOwner
string		sACType
string		sVersion

uo_truck_sheet	uoTruckSheet[]	// Truck Sheet je GalleyPos

integer		iCopies

end variables

forward prototypes
public function integer of_fill_trucksheet ()
public function integer of_fill_trucksheet_old ()
end prototypes

public function integer of_fill_trucksheet ();//====================================================================================
//
// of_fill_trucksheet
//
//====================================================================================
//
// Erstellt Truck-Checksheet
//
//====================================================================================
long		i, j, k, l, m
long		lRow, lpos
long		lcnt1, lcnt2, lcnt3, lcnt4

string	sUnit
string	sCurrentUnit
string	sText
string	sGalley, sStowage, sPlace

integer	iBelly
integer	iGalleyPos, iLastGalleyPos = -999
long		lStowageSort
boolean	binsert, bfound

integer	iPageCount


if not isvalid(dsCheckSheet) then
	return -1
end if

dsCheckSheet.SetSort("compute_belly A, ngalley_pos A, cunit A, ngalley_sort A, nstowage_sort A")
dsCheckSheet.Sort()

//
// Anzahl Pages
//
for i = 1 to dsCheckSheet.RowCount()
	iGalleyPos 		= dsCheckSheet.GetItemNumber(i,"ngalley_pos")
	if isnull(iGalleyPos) then iGalleyPos=0
	if iGalleyPos <> iLastGalleyPos then
		iPageCount++
		uoTruckSheet[iPageCount] = create uo_truck_sheet
		uoTruckSheet[iPageCount].lGalleyPos = iGalleyPos
		uoTruckSheet[iPageCount].lPage = iPageCount
		iLastGalleyPos = iGalleyPos
	end if
next

for i = 1 to dsCheckSheet.RowCount()
	binsert = false
	iGalleyPos 		= dsCheckSheet.GetItemNumber(i,"ngalley_pos")
	if isnull(iGalleyPos) then iGalleyPos=0
	//
	// Suche richtiges Truck-Sheet
	//
	for j = 1 to upperbound(uoTruckSheet)
		if uoTruckSheet[j].lGalleyPos = iGalleyPos then
			dsTruckSheet = uoTruckSheet[j].dsTruckSheet
			dsCoverSheet = uoTruckSheet[j].dsCover
		end if
	next
	
	iBelly 			= dsCheckSheet.GetItemNumber(i,"nbelly")
	lStowageSort	= dsCheckSheet.GetItemNumber(i,"nstowage_sort")
	
	sGalley 			= dsCheckSheet.GetItemString(i,"cgalley")
	sStowage			= dsCheckSheet.GetItemString(i,"cstowage")
	sPlace 			= dsCheckSheet.GetItemString(i,"cplace")
	sText 			= dsCheckSheet.GetItemString(i,"ctext")
	lpos = pos(sText,"]",1)
	if lpos > 0 then
		//
		// Minus entfernen und Platz sparen
		//
		// mit PL : sText = mid(sText,1,lpos) + mid(sText,lpos + 3)
		sText = mid(sText,lpos + 4)
	end if
	
	sUnit 			= dsCheckSheet.GetItemString(i,"cunit")

	if dsTruckSheet.RowCount() = 0 then
		lRow = dsTruckSheet.InsertRow(0)
	end if
	
	dsTruckSheet.GroupCalc()
	//
	// Ausgangsl$$HEX1$$f600$$ENDHEX$$sung: Wo ist platz?
	//
	for k = 1 to 4
		if binsert = false then
			sCurrentUnit = dsTruckSheet.GetItemString(1,"cunit" + string(k))
			if sCurrentUnit = sUnit then
				//
				// Spalte mit Einheit gefunden
				//
				for j = 1 to dsTruckSheet.RowCount()
					if binsert = false then
						if j > 32 and k < 4 then
							//
							// 10.07.06 Falls Spalte $$HEX1$$fc00$$ENDHEX$$berl$$HEX1$$e400$$ENDHEX$$uft und noch nicht
							// die letzte Spalte erreicht ist
							//	
							l = k + 1
							for m = 1 to dsTruckSheet.RowCount()
								if binsert = false then
									if isnull(dsTruckSheet.GetItemString(m,"ctext" + string(l))) then
										dsTruckSheet.SetItem(m,"cunit" + string(l),sUnit)
										dsTruckSheet.SetItem(m,"ctext" + string(l),sText)
										dsTruckSheet.SetItem(m,"cstowage" + string(l),sGalley + "-" + sStowage + " " + sPlace)
										dsTruckSheet.SetItem(m,"nrows" + string(l),m)
										binsert = true
									end if
								end if
							next
						else
							if isnull(dsTruckSheet.GetItemString(j,"ctext" + string(k))) then
								dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
								dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
								dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
								dsTruckSheet.SetItem(j,"nrows" + string(k),j)
								binsert = true
							end if
						end if
					end if
				next
				if binsert = false then
					lRow = dsTruckSheet.InsertRow(0)
					dsTruckSheet.SetItem(lRow,"cunit" + string(k),sUnit)
					dsTruckSheet.SetItem(lRow,"ctext" + string(k),sText)
					dsTruckSheet.SetItem(lRow,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
					dsTruckSheet.SetItem(lRow,"nrows" + string(k),lRow)
					binsert = true
				end if
			end if
		end if
	next
	//
	// absolut nichts gefunden => neuer Eintrag
	//
	if binsert = false then
		for k = 1 to 4
			if binsert = false then
				sCurrentUnit = dsTruckSheet.GetItemString(1,"cunit" + string(k))
				if isnull(sCurrentUnit) then
					dsTruckSheet.SetItem(1,"cunit" + string(k),sUnit)
					dsTruckSheet.SetItem(1,"ctext" + string(k),sText)
					dsTruckSheet.SetItem(1,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
					dsTruckSheet.SetItem(1,"nrows" + string(k),1)
					binsert = true
				end if
			end if
		next
	end if
	//
	// Ab hier Verfahren bei mehr als 4 Einheiten...
	//
	if binsert = false then
		//
		// 1. Check: Gibt es schon Daten f$$HEX1$$fc00$$ENDHEX$$r diese Einheit
		//
		bfound = false
		for k = 1 to 4
			for j = 1 to dsTruckSheet.RowCount()
				if binsert = false then
					sCurrentUnit = dsTruckSheet.GetItemString(j,"cunit" + string(k))
					if sCurrentUnit = sUnit then
						bFound = true
						if j = dsTruckSheet.RowCount() then
							lRow = dsTruckSheet.InsertRow(0)
							dsTruckSheet.SetItem(lRow,"cunit" + string(k),sUnit)
							dsTruckSheet.SetItem(lRow,"ctext" + string(k),sText)
							dsTruckSheet.SetItem(lRow,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
							dsTruckSheet.SetItem(lRow,"nrows" + string(k),lRow)
							binsert = true
						end if
						continue
					end if
					if bFound = true then
						//
						// richtige Spalte gefunden
						//
						if isnull(sCurrentUnit) then
							dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
							dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
							dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
							dsTruckSheet.SetItem(j,"nrows" + string(k),j)
							binsert = true
						end if
					end if
				end if
			next
		next
		
		//
		// 2. Check: lege Einheit neu an
		//
		if binsert = false then
			lcnt1 = dsTruckSheet.GetItemNumber(1,"max1")
			lcnt2 = dsTruckSheet.GetItemNumber(1,"max2")
			lcnt3 = dsTruckSheet.GetItemNumber(1,"max3")
			lcnt4 = dsTruckSheet.GetItemNumber(1,"max4")
			
			k=1
			j = lcnt1 + 1
			if lcnt1 > lcnt2 then
				k=2
				j = lcnt2 + 1
				if lcnt2 > lcnt3 then
					k=3
					j = lcnt3 + 1
					if lcnt3 > lcnt4 then
						k=4
						j = lcnt4 + 1
					end if
				end if
			end if
			if lcnt1 > lcnt3 then
				k=3
				j = lcnt3 + 1
				if lcnt3 > lcnt4 then
					k=4
					j = lcnt4 + 1
				end if
			end if
				
			if j > dsTruckSheet.RowCount() then
				j = dsTruckSheet.InsertRow(0)
			end if
			dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
			dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
			dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
			dsTruckSheet.SetItem(j,"nrows" + string(k),j)
			binsert = true
		end if
		
	end if
	
next

////
//// Optimierung
////
//for j = 1 to upperbound(uoTruckSheet)
//	dsTruckSheet = uoTruckSheet[j].dsTruckSheet
//	if dsTruckSheet.RowCount() > 33 then
//		if isnull(dsTruckSheet.GetItemString(1,"cunit4") then
//			for i = 1 to dsTruckSheet.RowCount()
//				if i > 33 then
//					
//			next
//		end if
//	end if
//next

for j = 1 to upperbound(uoTruckSheet)
	dsTruckSheet = uoTruckSheet[j].dsTruckSheet
	dsCoverSheet = uoTruckSheet[j].dsCover

	for i = 1 to dsTruckSheet.RowCount()
		dsTruckSheet.SetItem(i,"ngalley_position",j)
//		dsTruckSheet.SetItem(i,"npage",uoTruckSheet[j].lPage)
		if i <= 27 then 
			dsTruckSheet.SetItem(i,"npage",1 + j)
		elseif  i <= 54 then 
			dsTruckSheet.SetItem(i,"npage",2 + j)
		elseif  i <= 81 then 
			dsTruckSheet.SetItem(i,"npage",3 + j)
		elseif  i <= 108 then 
			dsTruckSheet.SetItem(i,"npage",4 + j)
		else
			dsTruckSheet.SetItem(i,"npage",5 + j)
		end if
	next
	
	dsCoverSheet.SetItem(1,"ngalley_position",uoTruckSheet[j].lGalleyPos)

	dsTruckSheet.modify("t_airline.text ='" + sAirline + "'")
	dsTruckSheet.modify("t_flight.text ='" + string(iFlightNumber,"000") + " " + sSuffix + "'")
	dsTruckSheet.modify("t_from.text ='" + sFrom + "'")
	dsTruckSheet.modify("t_to.text ='" + sTo + "'")
	dsTruckSheet.modify("t_departure.text ='" + string(dDeparture,s_app.sDateformat) + "'")
	dsTruckSheet.modify("t_time.text ='" + sTime + "'")
	dsTruckSheet.modify("t_routing.text ='" + sRouting + "'")
	dsTruckSheet.modify("t_betrieb.text ='" + sCSC + "'")
	dsTruckSheet.modify("t_registration.text ='" + sRegistration + "'")
	dsTruckSheet.modify("t_aircraft_type.text ='" + sOwner + " " + sACType + " [" + sVersion + "]" + "'")

	dsTruckSheet.Object.t_signature.text   = s_app.sOrga
	dsTruckSheet.Object.t_printed.text  = string(today(),s_app.sDateformat) + &
										  "  " + string(now(),"HH:MM")

	dsCoverSheet.modify("t_airline_header.text ='" + sAirline + "'")
	dsCoverSheet.modify("t_flight_header.text ='" + string(iFlightNumber,"000") + " " + sSuffix + "'")
	dsCoverSheet.modify("t_departure_header.text ='" + string(dDeparture,s_app.sDateformat) + "'")

	dsCoverSheet.Object.t_signature.text   = s_app.sOrga
	dsCoverSheet.Object.t_printed.text  = string(today(),s_app.sDateformat) + &
										  "  " + string(now(),"HH:MM")
	dsCoverSheet.modify("t_registration.text ='" + sRegistration + "'")

//	f_print_datastore(dsCoverSheet)
//	f_print_datastore(dsTruckSheet)

	//
	// Alle Check-Sheets in das finale Check-Sheet kopieren
	//
	dsTruckSheet.RowsCopy(1,dsTruckSheet.RowCount(),Primary!,dsTruckSheetFinal,dsTruckSheetFinal.RowCount() + 1,Primary!)
next

//dsTruckSheetFinal.modify("t_airline_header.text ='" + sAirline + "'")
//dsTruckSheetFinal.modify("t_flight_header.text ='" + string(iFlightNumber) + " " + sSuffix + "'")
//dsTruckSheetFinal.modify("t_departure_header.text ='" + string(dDeparture,s_app.sDateformat) + "'")

dsTruckSheetFinal.modify("t_airline.text ='" + sAirline + "'")
dsTruckSheetFinal.modify("t_flight.text ='" + string(iFlightNumber) + " " + sSuffix + "'")
dsTruckSheetFinal.modify("t_from.text ='" + sFrom + "'")
dsTruckSheetFinal.modify("t_to.text ='" + sTo + "'")
dsTruckSheetFinal.modify("t_departure.text ='" + string(dDeparture,s_app.sDateformat) + "'")
dsTruckSheetFinal.modify("t_time.text ='" + sTime + "'")
dsTruckSheetFinal.modify("t_routing.text ='" + sRouting + "'")
dsTruckSheetFinal.modify("t_betrieb.text ='" + sCSC + "'")
dsTruckSheetFinal.modify("t_registration.text ='" + sRegistration + "'")

dsTruckSheetFinal.Object.t_signature.text   = s_app.sOrga
dsTruckSheetFinal.Object.t_printed.text  = string(today(),s_app.sDateformat) + &
										  "  " + string(now(),"HH:MM")
dsTruckSheetFinal.GroupCalc()

//
// Bei alter Variante mit finalem Truck-Sheet konnten die Datenstrukturen zerst$$HEX1$$f600$$ENDHEX$$rt werden
//
//for i = upperbound(uoTruckSheet) to 1 step -1 
//	destroy uoTruckSheet[i]
//next

//f_print_datastore(dsTruckSheetFinal)

return 0

end function

public function integer of_fill_trucksheet_old ();//====================================================================================
//
// of_fill_trucksheet
//
//====================================================================================
//
// Erstellt Truck-Checksheet
//
//====================================================================================
long		i, j, k
long		lRow, lpos
long		lcnt1, lcnt2, lcnt3, lcnt4

string	sUnit
string	sCurrentUnit
string	sText
string	sGalley, sStowage, sPlace

integer	iBelly
integer	iGalleyPos, iLastGalleyPos = -999
long		lStowageSort
boolean	binsert, bfound

integer	iPageCount


if not isvalid(dsCheckSheet) then
	return -1
end if

dsCheckSheet.SetSort("compute_belly A, ngalley_pos A, cunit A, ngalley_sort A, nstowage_sort A")
dsCheckSheet.Sort()
//f_print_datastore(dsCheckSheet)

//
// Anzahl Pages
//
for i = 1 to dsCheckSheet.RowCount()
	iGalleyPos 		= dsCheckSheet.GetItemNumber(i,"ngalley_pos")
	if isnull(iGalleyPos) then iGalleyPos=0
	if iGalleyPos <> iLastGalleyPos then
		iPageCount++
		uoTruckSheet[iPageCount] = create uo_truck_sheet
		uoTruckSheet[iPageCount].lGalleyPos = iGalleyPos
		iLastGalleyPos = iGalleyPos
	end if
next

for i = 1 to dsCheckSheet.RowCount()
	binsert = false
	iGalleyPos 		= dsCheckSheet.GetItemNumber(i,"ngalley_pos")
	if isnull(iGalleyPos) then iGalleyPos=0
	//
	// Suche richtiges Truck-Sheet
	//
	for j = 1 to upperbound(uoTruckSheet)
		if uoTruckSheet[j].lGalleyPos = iGalleyPos then
			dsTruckSheet = uoTruckSheet[j].dsTruckSheet
		end if
	next
	
	iBelly 			= dsCheckSheet.GetItemNumber(i,"nbelly")
	lStowageSort	= dsCheckSheet.GetItemNumber(i,"nstowage_sort")
	
	sGalley 			= dsCheckSheet.GetItemString(i,"cgalley")
	sStowage			= dsCheckSheet.GetItemString(i,"cstowage")
	sPlace 			= dsCheckSheet.GetItemString(i,"cplace")
	sText 			= dsCheckSheet.GetItemString(i,"ctext")
	lpos = pos(sText,"]",1)
	if lpos > 0 then
		//
		// Minus entfernen und Platz sparen
		//
		// mit PL : sText = mid(sText,1,lpos) + mid(sText,lpos + 3)
		sText = mid(sText,lpos + 4)
	end if
	
	sUnit 			= dsCheckSheet.GetItemString(i,"cunit")

	if dsTruckSheet.RowCount() = 0 then
		lRow = dsTruckSheet.InsertRow(0)
	end if
	
	dsTruckSheet.GroupCalc()
	//
	// Ausgangsl$$HEX1$$f600$$ENDHEX$$sung: Wo ist platz?
	//
	for k = 1 to 4
		if binsert = false then
			sCurrentUnit = dsTruckSheet.GetItemString(1,"cunit" + string(k))
			if sCurrentUnit = sUnit then
				//
				// Spalte mit Einheit gefunden
				//
				for j = 1 to dsTruckSheet.RowCount()
					if binsert = false then
						if isnull(dsTruckSheet.GetItemString(j,"ctext" + string(k))) then
							dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
							dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
							dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
							dsTruckSheet.SetItem(j,"nrows" + string(k),j)
							binsert = true
						end if
					end if
				next
				if binsert = false then
					lRow = dsTruckSheet.InsertRow(0)
					dsTruckSheet.SetItem(lRow,"cunit" + string(k),sUnit)
					dsTruckSheet.SetItem(lRow,"ctext" + string(k),sText)
					dsTruckSheet.SetItem(lRow,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
					dsTruckSheet.SetItem(lRow,"nrows" + string(k),lRow)
					binsert = true
				end if
			end if
		end if
	next
	//
	// absolut nichts gefunden => neuer Eintrag
	//
	if binsert = false then
		for k = 1 to 4
			if binsert = false then
				sCurrentUnit = dsTruckSheet.GetItemString(1,"cunit" + string(k))
				if isnull(sCurrentUnit) then
					dsTruckSheet.SetItem(1,"cunit" + string(k),sUnit)
					dsTruckSheet.SetItem(1,"ctext" + string(k),sText)
					dsTruckSheet.SetItem(1,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
					dsTruckSheet.SetItem(1,"nrows" + string(k),1)
					binsert = true
				end if
			end if
		next
	end if
	//
	// Ab hier Verfahren bei mehr als 4 Einheiten...
	//
	if binsert = false then
		//
		// 1. Check: Gibt es schon Daten f$$HEX1$$fc00$$ENDHEX$$r diese Einheit
		//
		bfound = false
		for k = 1 to 4
			for j = 1 to dsTruckSheet.RowCount()
				if binsert = false then
					sCurrentUnit = dsTruckSheet.GetItemString(j,"cunit" + string(k))
					if sCurrentUnit = sUnit then
						bFound = true
						if j = dsTruckSheet.RowCount() then
							lRow = dsTruckSheet.InsertRow(0)
							dsTruckSheet.SetItem(lRow,"cunit" + string(k),sUnit)
							dsTruckSheet.SetItem(lRow,"ctext" + string(k),sText)
							dsTruckSheet.SetItem(lRow,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
							dsTruckSheet.SetItem(lRow,"nrows" + string(k),lRow)
							binsert = true
						end if
						continue
					end if
					if bFound = true then
						//
						// richtige Spalte gefunden
						//
						if isnull(sCurrentUnit) then
							dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
							dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
							dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
							dsTruckSheet.SetItem(j,"nrows" + string(k),j)
							binsert = true
						end if
					end if
				end if
			next
		next
		
		//
		// 2. Check: lege Einheit neu an
		//
		if binsert = false then
			lcnt1 = dsTruckSheet.GetItemNumber(1,"max1")
			lcnt2 = dsTruckSheet.GetItemNumber(1,"max2")
			lcnt3 = dsTruckSheet.GetItemNumber(1,"max3")
			lcnt4 = dsTruckSheet.GetItemNumber(1,"max4")
			
			k=1
			j = lcnt1 + 1
			if lcnt1 > lcnt2 then
				k=2
				j = lcnt2 + 1
				if lcnt2 > lcnt3 then
					k=3
					j = lcnt3 + 1
					if lcnt3 > lcnt4 then
						k=4
						j = lcnt4 + 1
					end if
				end if
			end if
			if lcnt1 > lcnt3 then
				k=3
				j = lcnt3 + 1
				if lcnt3 > lcnt4 then
					k=4
					j = lcnt4 + 1
				end if
			end if
				
			if j > dsTruckSheet.RowCount() then
				j = dsTruckSheet.InsertRow(0)
			end if
			dsTruckSheet.SetItem(j,"cunit" + string(k),sUnit)
			dsTruckSheet.SetItem(j,"ctext" + string(k),sText)
			dsTruckSheet.SetItem(j,"cstowage" + string(k),sGalley + "-" + sStowage + " " + sPlace)
			dsTruckSheet.SetItem(j,"nrows" + string(k),j)
			binsert = true
		end if
		
	end if
	
next


for j = 1 to upperbound(uoTruckSheet)
	dsTruckSheet = uoTruckSheet[j].dsTruckSheet

	for i = 1 to dsTruckSheet.RowCount()
		dsTruckSheet.SetItem(i,"ngalley_position",j)
	next

	dsTruckSheet.modify("t_airline.text ='" + sAirline + "'")
	dsTruckSheet.modify("t_flight.text ='" + string(iFlightNumber) + " " + sSuffix + "'")
	dsTruckSheet.modify("t_from.text ='" + sFrom + "'")
	dsTruckSheet.modify("t_to.text ='" + sTo + "'")
	dsTruckSheet.modify("t_departure.text ='" + string(dDeparture,s_app.sDateformat) + "'")
	dsTruckSheet.modify("t_time.text ='" + sTime + "'")

	// f_print_datastore(dsTruckSheet)
	
	//
	// Alle Check-Sheets in das finale Check-Sheet kopieren
	//
	dsTruckSheet.RowsCopy(1,dsTruckSheet.RowCount(),Primary!,dsTruckSheetFinal,dsTruckSheetFinal.RowCount() + 1,Primary!)
next

dsTruckSheetFinal.modify("t_airline.text ='" + sAirline + "'")
dsTruckSheetFinal.modify("t_flight.text ='" + string(iFlightNumber) + " " + sSuffix + "'")
dsTruckSheetFinal.modify("t_from.text ='" + sFrom + "'")
dsTruckSheetFinal.modify("t_to.text ='" + sTo + "'")
dsTruckSheetFinal.modify("t_departure.text ='" + string(dDeparture,s_app.sDateformat) + "'")
dsTruckSheetFinal.modify("t_time.text ='" + sTime + "'")
dsTruckSheetFinal.modify("t_routing.text ='" + sRouting + "'")
dsTruckSheetFinal.modify("t_betrieb.text ='" + sCSC + "'")
dsTruckSheetFinal.Object.t_signature.text   = s_app.sOrga
dsTruckSheetFinal.Object.t_printed.text  = string(today(),s_app.sDateformat) + &
										  "  " + string(now(),"HH:MM")
dsTruckSheetFinal.GroupCalc()

for i = upperbound(uoTruckSheet) to 1 step -1 
	destroy uoTruckSheet[i]
next

//f_print_datastore(dsTruckSheetFinal)

return 0

end function

on uo_truck_sheet_control.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_truck_sheet_control.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsTruckSheetFinal = create datastore
dsTruckSheetFinal.Dataobject = "dw_uo_truck_check_sheet"
uf.translate_datastore(dsTruckSheetFinal)

end event

event destructor;destroy dsTruckSheetFinal

end event

