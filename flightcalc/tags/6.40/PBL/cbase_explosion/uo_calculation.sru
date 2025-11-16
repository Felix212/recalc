HA$PBExportHeader$uo_calculation.sru
$PBExportComments$Userobject zur Berechnung der Auftragsmenge f$$HEX1$$fc00$$ENDHEX$$r das Lesematerial aus einer Ratiolist
forward
global type uo_calculation from nonvisualobject
end type
end forward

global type uo_calculation from nonvisualobject
end type
global uo_calculation uo_calculation

type variables
// =========================================================================================
//
// uo_calculation
//
// Berechnungsobjekt
//
// =========================================================================================

public:

// =========================================================================================
//
// Pflicht-Properties:
//
// =========================================================================================

long				lCalcID					// Art der Berechnung (sys_calculate)
long				lCalcDetailKey			// z.B. welche Ratiostaffel

Date				dDate						// Bezugsdatum

long				lPax
long				lSpml =0 

// =========================================================================================
//
// sonstige Properties
//
// =========================================================================================

string			sErrortext



end variables

forward prototypes
public function integer of_calc_ratiolist ()
end prototypes

public function integer of_calc_ratiolist ();//=================================================================================================
//
// of_calc_ratiolist
//
// Berechnet Auftragsmenge anhand Pax-Zahl aus einer Ratiolist
//
// lcalcid 			= 3
// lcalcdetailkey = Key der gew$$HEX1$$fc00$$ENDHEX$$nschten Ratiolist
//
// 21.01.22, SMH #7929 Check and chane the calculation where the SPMLs are added 
//=================================================================================================
long			lresult
long 			lQuantity
long			lfrom_pax, lto_pax
datetime		dtDate

Integer		Iconsider_spml

dtDate = datetime(ddate)

 declare cratio_curs cursor for
  select nfrom_pax, nto_pax, cen_calc_ratiolist_detail.nquantity, cen_calc_ratiolist.consider_spml
    from cen_calc_ratiolist, cen_calc_ratiolist_detail
   where cen_calc_ratiolist.nratiolist_key =  cen_calc_ratiolist_detail.nratiolist_key
     and cen_calc_ratiolist.nratiolist_key =  :lcalcdetailkey
     and cen_calc_ratiolist.dvalid_from    <= :dtDate
	  and cen_calc_ratiolist.dvalid_to      >= :dtDate
order by nfrom_pax;


open cratio_curs;
if sqlca.sqlcode <> 0 then
	close cratio_curs;
	sErrortext = "error at open cratio_curs: " + sqlca.sqlerrtext
	return -1
end if


do while sqlca.sqlcode = 0
	fetch cratio_curs
	 into :lfrom_pax, :lto_pax, :lquantity, :Iconsider_spml;
	 
	if sqlca.sqlcode = 100 then
		lresult = lpax
		exit
	end if
	
	if sqlca.sqlcode <> 0 then
		sErrortext = "error at fetch cratio_curs: " + sqlca.sqlerrtext
		lresult = lpax
		exit
	end if
	
	//
	// Ermittlung Menge
	//
	// 21.01.22, SMH #7929 
	if Iconsider_spml = 1 then 
			if lfrom_pax <= (lpax - lSpml) and lto_pax >= (lpax - lSpml) then
				lresult = lquantity
				exit
			end if	
	else 
	if lfrom_pax <= lpax and lto_pax >= lpax then
		lresult = lquantity
		exit
	end if
	end if
loop

close cratio_curs;
if sqlca.sqlcode <> 0 then
	sErrortext = "error at close cratio_curs: " + sqlca.sqlerrtext
	return -1
end if


return lresult

end function

on uo_calculation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_calculation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

