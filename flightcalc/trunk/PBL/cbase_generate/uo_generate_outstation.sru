HA$PBExportHeader$uo_generate_outstation.sru
$PBExportComments$Userobject f$$HEX1$$fc00$$ENDHEX$$r die Generierung von Fl$$HEX1$$fc00$$ENDHEX$$gen und der kompletten Beladung
forward
global type uo_generate_outstation from uo_generate
end type
end forward

global type uo_generate_outstation from uo_generate
end type
global uo_generate_outstation uo_generate_outstation

forward prototypes
public subroutine of_reorg_legs ()
end prototypes

public subroutine of_reorg_legs ();/* 
* Funktion/Event: of_reorg_legs
* Beschreibung: 	Durchnummerierung der Legs mit 1 beginnend und $$HEX1$$dc00$$ENDHEX$$bernahme der Zeiten (Abflug, Rampe, K$$HEX1$$fc00$$ENDHEX$$che) auf die weiterf$$HEX1$$fc00$$ENDHEX$$hrenden Legs
* Besonderheit: 	keine
*
**
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			H.Rothenbach	26.08.2008	Erstellung
*
*/

long ll_grp_key
long ll_grp_row
integer li_grp_leg
integer i, j
string ls_zeit

ll_grp_key = -1

//Daten nach Fluggruppen und Legnummer sortieren
dsCenOut.setsort("nresult_key_group, nleg_number")
dsCenOut.sort()

for i=1 to dsCenOut.rowcount()
	//10.06.2024 HR: Logging Job-Nr and Result_key to Graylog
	gll_log_result_key	= dsCenOut.GetItemNumber(i,"nresult_key") 

	//Gruppenwechsel?
	if ll_grp_key <> dsCenOut.getitemnumber(i,"nresult_key_group") then
		//Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel und Zeilennummer merken
		ll_grp_key = dsCenOut.getitemnumber(i,"nresult_key_group")
		ll_grp_row = i

		if dsCenOut.getitemnumber(i,"nresult_key_group") <> dsCenOut.getitemnumber(i,"nresult_key") then
			dsCenOut.setitem(i, "nresult_key_group", 	dsCenOut.getitemnumber(i,"nresult_key"))
			dsCenOut.setitem(i, "nleg_number", 			1)
			
			// LEG-DATUM/Uhrzeit setzen
			datetime ldt
						
			ldt = dsCenOut.getitemdatetime(i,"DDEPARTURE_TIME_LOC")
			dsCenOut.setitem(i, "DDEPARTURE", 							date(ldt) )
			dsCenOut.setitem(i, "DDEPARTURE_ORIG", 				date(ldt) )
			dsCenOut.setitem(i, "DORIGINAL_DEPARTURE", 	date(ldt) )
			dsCenOut.setitem(i, "DRETURN_DATE", 					date(ldt) )
						
			dsCenOut.setitem(i, "CDEPARTURE_TIME",  				string(ldt, "hh:mm") )
			dsCenOut.setitem(i, "CORIGINAL_TIME", 					string(ldt, "hh:mm") )
			dsCenOut.setitem(i, "CDEPARTURE_TIME_ORIG", 	string(ldt, "hh:mm") )
			dsCenOut.SetItem(i, "CSORT_TIME",							string(ldt, "hh:mm") )
			//CKITCHEN_TIME,
			//CRAMP_TIME,
						
			if i <>  dsCenOut.rowcount() then
				for j = i +1 to  dsCenOut.rowcount()
					if dsCenOut.getitemnumber(j, "nresult_key_group") = ll_grp_key then
						dsCenOut.setitem(j, "nresult_key_group", 	dsCenOut.getitemnumber(i,"nresult_key"))
						dsCenOut.setitem(j, "nleg_number", 			dsCenOut.getitemnumber(j -1,"nleg_number") + 1)
						dsCenOut.setitem(i, "DDEPARTURE", 			dsCenOut.getitemdatetime(i, "DDEPARTURE") )
						dsCenOut.SetItem(i, "CSORT_TIME",			dsCenOut.getitemstring(i, "CSORT_TIME") )
					else
						exit
					end if
				next
			end if
		end if
		//Legnummer auf 1 setzen
		/* HR 09.09.2008: Wegen  Problemen mit der SSL im Flugbrowser wurde die Legnummerierung ausgeschaltet
		li_grp_leg = 1
		dsCenOut.setitem(i,"nleg_number",li_grp_leg) */
	else
		//Legnummer erh$$HEX1$$f600$$ENDHEX$$hen und setzen
		/* HR 09.09.2008: Wegen  Problemen mit der SSL im Flugbrowser wurde die Legnummerierung ausgeschaltet
		li_grp_leg ++
		dsCenOut.setitem(i,"nleg_number",li_grp_leg) */
		
		//Abflugzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "cdeparture_time")
		dsCenOut.setitem(i,"cdeparture_time", ls_zeit)
		dsCenOut.SetItem(i,"CSORT_TIME",ls_zeit) // 15.11.2010 HR: Auch hier die Abflugszeit des 1. LEGS eintragen
		
		//Rampenzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "cramp_time")
		dsCenOut.setitem(i,"cramp_time", ls_zeit)
		
		//K$$HEX1$$fc00$$ENDHEX$$chenzeit von Leg 1 lesen und in aktuelle Zeile $$HEX1$$fc00$$ENDHEX$$bertragen
		ls_zeit=dsCenOut.getitemstring(ll_grp_row, "ckitchen_time")
		dsCenOut.setitem(i,"ckitchen_time", ls_zeit)
	end if
next

//10.06.2024 HR: Logging Job-Nr and Result_key to Graylog
gll_log_result_key	= 0

//Sortierung wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
dsCenOut.setsort("nrouting_group_key, nleg_number")
dsCenOut.sort()

end subroutine

on uo_generate_outstation.create
call super::create
end on

on uo_generate_outstation.destroy
call super::destroy
end on

