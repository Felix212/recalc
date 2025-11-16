HA$PBExportHeader$uo_datetime_functions.sru
$PBExportComments$funktions-container
forward
global type uo_datetime_functions from nonvisualobject
end type
end forward

global type uo_datetime_functions from nonvisualobject autoinstantiate
end type

forward prototypes
public function datetime of_rel_datetime_minutes (datetime adt_base, long al_offset)
end prototypes

public function datetime of_rel_datetime_minutes (datetime adt_base, long al_offset);




Long 	ll_Faktor = 1

// hilfsvariable Basistermin
Long 	ll_BaseHours, ll_BaseMinutes

// hilfsvariable Offset, Returnwerte
Long 	ll_OffsetMinutes, ll_OffsetHours, ll_OffsetDays
Long 	ll_ReturnMinutes, ll_ReturnHours, ll_ReturnDays


// bl$$HEX1$$f600$$ENDHEX$$dsinn $$HEX1$$fc00$$ENDHEX$$bergeben: nix machen
if IsNull(al_Offset) or al_Offset = 0 then return adt_Base 

// vorw$$HEX1$$e400$$ENDHEX$$rts oder r$$HEX1$$fc00$$ENDHEX$$ckw$$HEX1$$e400$$ENDHEX$$rts gehen ?
if al_Offset < 0 then
	ll_Faktor = -1
	al_Offset = al_Offset * ll_Faktor
end if

// Datum, Zeit sowie Stunden- und Minuten-Anteile aus Base holen
ll_BaseHours = Hour(time(adt_Base))
ll_BaseMinutes = Minute(time(adt_Base))

// Offest-Minuten aufsplitten in Tage, Stunden, Minuten
ll_OffsetMinutes = Mod(al_Offset, 60)
ll_OffsetHours = Mod(((al_Offset - ll_OffsetMinutes) / 60), 24)
ll_OffsetDays = (al_Offset - ll_OffsetMinutes - (ll_OffsetHours * 60)) / (24 * 60)


// ------------------------------
// vorw$$HEX1$$e400$$ENDHEX$$rts
// ------------------------------
if ll_Faktor > 0 then

	// tage addieren
	ll_ReturnDays = ll_OffsetDays

	// stunden addieren
	ll_ReturnHours = ll_BaseHours + ll_OffsetHours
	if ll_ReturnHours > 23 then
		ll_ReturnDays += 1
		ll_ReturnHours -= 24
	end if

	// minuten addieren
	ll_ReturnMinutes = ll_BaseMinutes + ll_OffsetMinutes
	if ll_ReturnMinutes > 60 then
		ll_ReturnHours += 1
		ll_ReturnMinutes -= 60
	end if

	// stunden abschliessend nochmal pr$$HEX1$$fc00$$ENDHEX$$fen (falls noch ein tag dabei rauskommt)
	if ll_ReturnHours > 23 then
		ll_ReturnDays += 1
		ll_ReturnHours -= 24
	end if

end if

// ------------------------------
// r$$HEX1$$fc00$$ENDHEX$$ckw$$HEX1$$e400$$ENDHEX$$rts
// ------------------------------
if ll_Faktor < 0 then
	
	// tage addieren
	ll_ReturnDays = ll_OffsetDays

	// stunden subtrahieren
	ll_ReturnHours = ll_BaseHours - ll_OffsetHours
	if ll_ReturnHours < 0 then
		ll_ReturnDays += 1
		ll_ReturnHours += 24
	end if

	// minuten subtrahieren
	ll_ReturnMinutes = ll_BaseMinutes - ll_OffsetMinutes
	if ll_ReturnMinutes < 0 then
		ll_ReturnHours -= 1
		ll_ReturnMinutes += 60
	end if

	// stunden abschliessend nochmal pr$$HEX1$$fc00$$ENDHEX$$fen (falls noch ein tag dabei rauskommt)
	if ll_ReturnHours < 0 then
		ll_ReturnDays += 1
		ll_ReturnHours += 24
	end if
	

end if

// return-termin zusammensetzen
return(datetime(relativedate(Date(adt_Base), ll_ReturnDays * ll_Faktor), time(ll_ReturnHours, ll_ReturnMinutes, second(time(adt_Base)))))

end function

on uo_datetime_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_datetime_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

