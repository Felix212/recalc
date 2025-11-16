HA$PBExportHeader$uo_healthmark.sru
$PBExportComments$Draw healthmark (DataStore / DataWindow)
forward
global type uo_healthmark from nonvisualobject
end type
end forward

global type uo_healthmark from nonvisualobject
end type
global uo_healthmark uo_healthmark

type variables


// Alignment
PUBLIC	CONSTANT		Integer			ALIGN_LEFT						= 0
PUBLIC	CONSTANT		Integer			ALIGN_CENTER					= 2
PUBLIC	CONSTANT		Integer			ALIGN_RIGHT						= 1

// Document Type
PUBLIC	CONSTANT		Integer			CARTDIAGRAM						= 1
PUBLIC	CONSTANT		Integer			DELIVERYNOTE					= 2

// Font
PUBLIC	CONSTANT		Integer			FONT_NORMAL						= 400
PUBLIC	CONSTANT		Integer			FONT_BOLD						= 700

Long		il_Object_Counter
String	is_Objects[]
end variables

forward prototypes
protected function integer of_read_settings (string as_unit, ref string ras_healthmark_1, ref string ras_healthmark_2, ref string ras_healthmark_3)
protected function integer of_modify (datastore ads, string as_mod)
protected function integer of_modify (datawindow adw, string as_mod)
protected function integer of_create_ellipse (ref datastore rads_target, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, long al_color, string as_band)
protected function integer of_create_ellipse (ref datawindow rads_target, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, long al_color, string as_band)
protected function integer of_create_text (ref datastore rads_target, string as_text, string as_font, integer ai_fontsize, integer ai_fontweight, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, integer ai_border, integer ai_align, string as_band)
protected function integer of_create_text (ref datawindow radw_target, string as_text, string as_font, integer ai_fontsize, integer ai_fontweight, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, integer ai_border, integer ai_align, string as_band)
public function integer of_draw_healthmark (ref datastore rads_target, string as_unit, integer ai_type)
public function integer of_draw_healthmark (ref datawindow radw_target, string as_unit, integer ai_type)
protected function integer of_bring_to_front (ref datastore rads_target)
protected function integer of_bring_to_front (ref datawindow radw_target)
protected function string of_unit_profilestring (string as_unit, string as_section, string as_key, string as_default)
protected function integer of_get_position (string as_unit, ref integer rai_x_pos, ref integer rai_y_pos, ref string ras_band, integer ai_type, ref integer rai_font_size, ref string ras_fontname, ref integer rai_fontweight)
public function integer of_draw_healthmark (ref datawindow radw_target, string as_unit, integer ai_type, boolean ab_header_in_footer)
public function integer of_draw_healthmark (ref datastore rads_target, string as_unit, integer ai_type, boolean ab_header_in_footer)
protected function integer of_get_position (string as_unit, ref integer rai_x_pos, ref integer rai_y_pos, ref string ras_band, integer ai_type, ref integer rai_font_size, ref string ras_fontname, ref integer rai_fontweight, boolean ab_header_in_footer)
end prototypes

protected function integer of_read_settings (string as_unit, ref string ras_healthmark_1, ref string ras_healthmark_2, ref string ras_healthmark_3);/*
* Objekt : uo_healthmark
* Methode: of_read_settings (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* string as_unit
*
* Beschreibung:		Read Healthmark Text from sys_units
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


select	su.chealthmark1, su.chealthmark2, su.chealthmark3
INTO		:ras_Healthmark_1, :ras_Healthmark_2, :ras_Healthmark_3
from		sys_units su 
where		cunit = :as_unit;

If SQLCA.SQLCode <> 0 Then
	Return -1
End if

Return 1
end function

protected function integer of_modify (datastore ads, string as_mod);/*
* Objekt : uo_healthmark
* Methode: of_modify_dsw (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
*	 datastor ads
*	 string as_mod
*
* Beschreibung:		Modify
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


String ls_Error
	
if isValid(ads) Then
	ls_Error = ads.modify(as_mod)
End If

If Trim(ls_Error) > "" Then
	// Error Occurred
	ls_Error += "!"

	f_trace("uo_healthmark.of_modify_dw ERROR " + ls_Error + ": " + as_mod)

	return -1
End If
			
return 0

end function

protected function integer of_modify (datawindow adw, string as_mod);/*
* Objekt : uo_healthmark
* Methode: of_modify_dw (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
*	 datawindow adw
*	 string as_mod
*
* Beschreibung:		Modify
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


String ls_Error
	
if isValid(adw) Then
	ls_Error = adw.modify(as_mod)
End If

If Trim(ls_Error) > "" Then
	// Error Occurred
	ls_Error += "!"

	f_trace("uo_healthmark.of_modify_dw ERROR " + ls_Error + ": " + as_mod)

	return -1
End If
			
return 0

end function

protected function integer of_create_ellipse (ref datastore rads_target, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, long al_color, string as_band);/*
* Objekt : uo_healthmark
* Methode: of_create_ellipse (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore rads_target
*	 integer ai_x_pos
*	 integer ai_y_pos
*	 integer ai_height
*	 integer ai_width
*	 long al_color
*
* Beschreibung:		Create Ellipse
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
* 1.1 			O.Hoefer	15.10.2013		CPU() liefert evtl. < 0
*
*
* Return: integer
*
*/


String	ls_Modify
Integer	li_Succ
String	ls_Object = "ellipse_" //+ String(cpu())


ls_Object += String(Now(), "hhmmssfff")

// brush.hatch="6" brush.color="16777215" pen.style="0" pen.width="1" pen.color="0"  background.mode="2" background.color="33554432"
ls_Modify = "create ellipse(band="+as_Band+" x='" + string(ai_X_pos) + "' y='" + string(ai_Y_pos) + "'" + &
				" height='" + string(ai_Height) + "' width='" + string(ai_Width) + "'  name=" + ls_Object + " visible='1' " + &
				" brush.hatch='6' brush.color='16777215' pen.style='0' pen.width='1' pen.color='0'  background.mode='2' background.color='16777215')"

li_Succ = of_modify(rads_target , ls_Modify)

is_Objects[Upperbound(is_Objects) + 1] = ls_Object

Return li_Succ
//ls_Modify = "create ellipse(band="+as_Band+" x='" + string(ai_X_pos) + "' y='" + string(ai_Y_pos) + "'" + &
//				" height='" + string(ai_Height) + "' width='" + string(ai_Width) + "'  name=" + ls_Object + " visible='1' " + &
//				" brush.hatch='7' pen.width='1' pen.color='" + string(al_color) + &
//				"' background.mode='2' )"
//
end function

protected function integer of_create_ellipse (ref datawindow rads_target, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, long al_color, string as_band);/*
* Objekt : uo_healthmark
* Methode: of_create_ellipse (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore rads_target
*	 integer ai_x_pos
*	 integer ai_y_pos
*	 integer ai_height
*	 integer ai_width
*	 long al_color
*
* Beschreibung:		Create Ellipse
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
* 1.1 			O.Hoefer	08.07.2013		Brush.Hatch auf 6 (war 7)
* 1.2 			O.Hoefer	15.10.2013		CPU() liefert evtl. < 0
*
*
* Return: integer
*
*/


String	ls_Modify
Integer	li_Succ
String	ls_Object = "ellipse_" //+ String(cpu())


ls_Object += String(Now(), "hhmmssfff")


ls_Modify = "create ellipse(band="+as_Band+" x='" + string(ai_X_pos) + "' y='" + string(ai_Y_pos) + "'" + &
				" height='" + string(ai_Height) + "' width='" + string(ai_Width) + "'  name=" + ls_Object + " visible='1' " + &
				" brush.hatch='6' brush.color='16777215' pen.style='0' pen.width='1' pen.color='0'  background.mode='2' background.color='16777215')"


li_Succ = of_modify(rads_target , ls_Modify)

is_Objects[Upperbound(is_Objects) + 1] = ls_Object


Return li_Succ
end function

protected function integer of_create_text (ref datastore rads_target, string as_text, string as_font, integer ai_fontsize, integer ai_fontweight, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, integer ai_border, integer ai_align, string as_band);/*
* Objekt : uo_healthmark
* Methode: of_create_text_ds (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore rads_target
*	 string as_text
*	 string as_font
*	 integer ai_fontsize
*	 integer ai_fontweight
*	 integer ai_x_pos
*	 integer ai_y_pos
*	 integer ai_height
*	 integer ai_width
*	 integer ai_border
*	 integer ai_align
*
* Beschreibung:		Create Text Object in DW/DS
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/

String 	ls_Create
String	ls_Ret
String	ls_Object


il_Object_Counter++
ls_Object = "text_" + String(il_Object_Counter)

if ai_X_pos < 0 Then ai_X_pos = 0

//if isnull(sTag) Then sTag = ""
if ai_Fontsize > 0 Then ai_Fontsize = ai_Fontsize * -1

//// ----------------------------------------------------------------------------
//// Maskieren von Single Quotes (') - UK Problem bei "...O'Brian..."
//// ----------------------------------------------------------------------------
//If pos(sText, "'")  > 0 then
//	lb_breakpoint=true
//	li_Replace = f_replace_string(sText, "'", "~~~'")
//End If

ls_Create = "create text(band="+as_Band+" alignment='" + string(ai_Align) + "' " + &
			"text='" + as_text + "' border='" + string(ai_Border) + "' color='" + String(0) + "' " + &
			"x='" + string(ai_X_pos) +  "' y='" + string(ai_Y_pos) + "' " + &
			" height='"+ String(ai_Height) + "' width='" + string(ai_Width) + "' " + &
			" name=" + ls_Object + &
			" font.face='" + as_Font + "' " + &
			" font.height='" + String(ai_Fontsize) + "' font.weight='" + String(ai_Fontweight) + "' font.family='2' font.pitch='2'" + &
			" font.charset='0' font.italic='0' font.underline='0'" +&
			" background.mode='1'" + &
			" background.color='536870912')"
		
if isValid(rads_target) Then
		if rads_target.Describe(ls_Object +".Text")<> "!" Then
		return 0
	Else
		ls_Ret = rads_target.modify(ls_Create)
	End If
End If

is_Objects[Upperbound(is_Objects) + 1] = ls_Object


return 1

end function

protected function integer of_create_text (ref datawindow radw_target, string as_text, string as_font, integer ai_fontsize, integer ai_fontweight, integer ai_x_pos, integer ai_y_pos, integer ai_height, integer ai_width, integer ai_border, integer ai_align, string as_band);/*
* Objekt : uo_healthmark
* Methode: of_create_text_dw (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datawindow radw_target
*	 string as_text
*	 string as_font
*	 integer ai_fontsize
*	 integer ai_fontweight
*	 integer ai_x_pos
*	 integer ai_y_pos
*	 integer ai_height
*	 integer ai_width
*	 integer ai_border
*	 integer ai_align
*
* Beschreibung:		Draw Text Object
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/

String 	ls_Create
String	ls_Ret
String	ls_Object


il_Object_Counter++
ls_Object = "text_" + String(il_Object_Counter)

// nicht nach links abdriften!
if ai_X_pos < 0 Then ai_X_pos = 0

//if isnull(sTag) Then sTag = ""
if ai_Fontsize > 0 Then ai_Fontsize = ai_Fontsize * -1

//// ----------------------------------------------------------------------------
//// Maskieren von Single Quotes (') - UK Problem bei "...O'Brian..."
//// ----------------------------------------------------------------------------
//If pos(sText, "'")  > 0 then
//	lb_breakpoint=true
//	li_Replace = f_replace_string(sText, "'", "~~~'")
//End If

ls_Create = "create text(band="+as_Band+" alignment='" + string(ai_Align) + "' " + &
			"text='" + as_text + "' border='" + string(ai_Border) + "' color='" + String(0) + "' " + &
			"x='" + string(ai_X_pos) +  "' y='" + string(ai_Y_pos) + "' " + &
			" height='"+ String(ai_Height) + "' width='" + string(ai_Width) + "' " + &
			" name=" + ls_Object + &
			" font.face='" + as_Font + "' " + &
			" font.height='" + String(ai_Fontsize) + "' font.weight='" + String(ai_Fontweight) + "' font.family='2' font.pitch='2'" + &
			" font.charset='0' font.italic='0' font.underline='0'" +&
			" background.mode='1'" + &
			" background.color='536870912')"
			

if isValid(radw_Target) Then
		if radw_Target.Describe(ls_Object +".Text")<> "!" Then
		return 0
	Else
		ls_Ret = radw_Target.modify(ls_Create)
	End If
End If

is_Objects[Upperbound(is_Objects) + 1] = ls_Object


return 1

end function

public function integer of_draw_healthmark (ref datastore rads_target, string as_unit, integer ai_type);/*
* Objekt : uo_healthmark
* Methode: of_draw_healthmark (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore	rads_target
*	 	string		as_unit
*
* Beschreibung:		Zeichne UK Healthmark
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
Integer	li_X_pos
Integer	li_Y_pos
Integer	li_Height						= 48
Integer	li_Width							= 96
Integer	li_fontsize						= 9
integer	li_fontweight					= FONT_BOLD		// BOLD	
Integer	li_align							= ALIGN_CENTER
Integer	li_border						= 0				// NONE
Integer	li_Text_height					= 15
Long		ll_color							= RGB(0, 0, 0) // Black
String	ls_healthmark_1				
String	ls_healthmark_2
String	ls_healthmark_3
String	ls_Modify
String	ls_Object
String	ls_Font							= "Arial"
String	ls_Band							= "Foreground"



// Lese 3 Healthmark Felder pro Unit
li_Succ = of_read_settings(as_Unit, ls_healthmark_1, ls_healthmark_2, ls_healthmark_3)

// wenn Text leer, dann nicht zeichnen
If IsNULL(ls_healthmark_2) OR Trim(ls_healthmark_2) = "" Then
	Return 0	
End If


// Position auf dem Ziel? 
li_Succ = of_get_position(as_unit, li_X_pos, li_Y_pos, ls_Band, ai_Type, li_fontsize, ls_Font, li_fontweight)

// Zeichne Ellipse (Gr$$HEX2$$f600df00$$ENDHEX$$e?)
li_Succ = of_create_ellipse(rads_target, li_X_pos, li_Y_pos, li_Height, li_Width, ll_color, ls_Band)

// Zeichne Zeile 1
li_y_pos += 0
li_Succ = of_create_text(rads_target, ls_healthmark_1, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 2
li_y_pos += li_Text_height
li_Succ = of_create_text(rads_target, ls_healthmark_2, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 3
li_y_pos += li_Text_height
li_Succ = of_create_text(rads_target, ls_healthmark_3, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Bring to Top
li_Succ = of_bring_to_front(rads_target)

Return 1
end function

public function integer of_draw_healthmark (ref datawindow radw_target, string as_unit, integer ai_type);/*
* Objekt : uo_healthmark
* Methode: of_draw_healthmark (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore rads_target
*	 string as_unit
*
* Beschreibung:		Zeichne UK Healthmark
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
Integer	li_X_pos
Integer	li_Y_pos
Integer	li_Height						= 48
Integer	li_Width							= 96
Integer	li_fontsize						= 9
integer	li_fontweight					= FONT_BOLD		// BOLD	
Integer	li_align							= ALIGN_CENTER
Integer	li_border						= 0				// NONE
Integer	li_Text_height					= 15
Long		ll_color							= RGB(0, 0, 0) // Black
String	ls_healthmark_1				
String	ls_healthmark_2
String	ls_healthmark_3
String	ls_Modify
String	ls_Object
String	ls_Font							= "Arial"
String	ls_Band							= "Foreground"


// Lese 3 Healthmark Felder pro Unit
li_Succ = of_read_settings(as_Unit, ls_healthmark_1, ls_healthmark_2, ls_healthmark_3)


// wenn Text leer, dann nicht zeichnen
If IsNULL(ls_healthmark_2) OR Trim(ls_healthmark_2) = "" Then
	Return 0	
End If

// Position auf dem Ziel? 
li_Succ = of_get_position(as_unit, li_X_pos, li_Y_pos, ls_Band, ai_Type, li_fontsize, ls_Font, li_fontweight)

// Zeichne Ellipse (Gr$$HEX2$$f600df00$$ENDHEX$$e?)
li_Succ = of_create_ellipse(radw_target, li_X_pos, li_Y_pos, li_Height, li_Width, ll_color, ls_Band)

// Zeichne Zeile 1
li_y_pos += 0
li_Succ = of_create_text(radw_target, ls_healthmark_1, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 2
li_y_pos += li_Text_height
li_Succ = of_create_text(radw_target, ls_healthmark_2, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 3
li_y_pos += li_Text_height
li_Succ = of_create_text(radw_target, ls_healthmark_3, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Bring to Top
li_Succ = of_bring_to_front(radw_target)


Return 1

end function

protected function integer of_bring_to_front (ref datastore rads_target);/*
* Objekt : uo_healthmark
* Methode: of_bring_to_front (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore radw_target
*
* Beschreibung:		Bring Healthmark to top
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Long		ll_Count
String	ls_Current_Object


For ll_Count = 1 To Upperbound(is_Objects)

	ls_Current_Object	= is_Objects[ll_Count]
	rads_Target.SetPosition(ls_Current_Object, "", TRUE)
		
Next

Return 1

end function

protected function integer of_bring_to_front (ref datawindow radw_target);/*
* Objekt : uo_healthmark
* Methode: of_bring_to_front (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datawindow radw_target
*
* Beschreibung:		Bring Healthmark to top
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Long		ll_Count
String	ls_Current_Object


For ll_Count = 1 To Upperbound(is_Objects)

	ls_Current_Object	= is_Objects[ll_Count]
	radw_Target.SetPosition(ls_Current_Object, "", TRUE)
		
Next

Return 1
end function

protected function string of_unit_profilestring (string as_unit, string as_section, string as_key, string as_default);/*
* Objekt : uo_healthmark
* Methode: of_mandant_profilestring (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
*	 string as_mandant
*	 string as_section
*	 string as_key
*	 string as_default
*
* Beschreibung:		Profile
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: string
*
*/

String	ls_Value

if isNull(as_default) or as_default = "" then
	as_default = " "
end if

Select 	cValue 
into 		:ls_Value 
from		loc_unit_setup
where		cunit			= :as_unit	
and		cSection		= :as_section			
and		cKey			= :as_key;
			
If SQLCA.SQLCode = 100 Then
	ls_Value = as_default
End If

Return ls_Value

end function

protected function integer of_get_position (string as_unit, ref integer rai_x_pos, ref integer rai_y_pos, ref string ras_band, integer ai_type, ref integer rai_font_size, ref string ras_fontname, ref integer rai_fontweight);/*
* Objekt : uo_healthmark
* Methode: of_get_position (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
*	 ref integer rai_x_pos
*	 ref integer rai_y_pos
*
* Beschreibung:		Position des Healthmark bestimmen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ


// lese aus Profil (pro CSC und Dokumententyp)
If ai_Type = CARTDIAGRAM Then
	rai_x_pos = 620
	rai_y_pos = 25
	//ras_band = "detail"
	ras_band = "Foreground"
	

ElseIf ai_Type = DELIVERYNOTE Then
	rai_x_pos = 123
	rai_y_pos = 81
	//ras_band = "header"
	//ras_band = "detail"
	ras_band = "Foreground"
End If
	
ras_band			= 				of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "BAND", ras_band	)
rai_x_pos		= Integer(	of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "XPOS", String(rai_x_pos)	) )
rai_y_pos		= Integer(	of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "YPOS", String(rai_y_pos)	) )
rai_Font_Size	= Integer(	of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "FONTSIZE", String(rai_Font_Size)	) )
ras_Fontname	= 				of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "FONTNAME", ras_Fontname	 )
rai_fontweight	= Integer(	of_unit_profilestring(as_unit, "HEALTHMARK", String(ai_type) + "FONTWEIGHT", String(rai_fontweight)	) )
If rai_fontweight <> FONT_BOLD and rai_fontweight <> FONT_NORMAL Then
	rai_fontweight = FONT_BOLD
End If

return li_Succ

end function

public function integer of_draw_healthmark (ref datawindow radw_target, string as_unit, integer ai_type, boolean ab_header_in_footer);/*
* Objekt : uo_healthmark
* Methode: of_draw_healthmark (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore rads_target
*	 string as_unit
*
* Beschreibung:		Zeichne UK Healthmark
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
Integer	li_X_pos
Integer	li_Y_pos
Integer	li_Height						= 48
Integer	li_Width							= 96
Integer	li_fontsize						= 9
integer	li_fontweight					= FONT_BOLD		// BOLD	
Integer	li_align							= ALIGN_CENTER
Integer	li_border						= 0				// NONE
Integer	li_Text_height					= 15
Long		ll_color							= RGB(0, 0, 0) // Black
String	ls_healthmark_1				
String	ls_healthmark_2
String	ls_healthmark_3
String	ls_Modify
String	ls_Object
String	ls_Font							= "Arial"
String	ls_Band							= "Foreground"


// Lese 3 Healthmark Felder pro Unit
li_Succ = of_read_settings(as_Unit, ls_healthmark_1, ls_healthmark_2, ls_healthmark_3)


// wenn Text leer, dann nicht zeichnen
If IsNULL(ls_healthmark_2) OR Trim(ls_healthmark_2) = "" Then
	Return 0	
End If

// Position auf dem Ziel? 
li_Succ = of_get_position(as_unit, li_X_pos, li_Y_pos, ls_Band, ai_Type, li_fontsize, ls_Font, li_fontweight, ab_header_in_footer)

// Zeichne Ellipse (Gr$$HEX2$$f600df00$$ENDHEX$$e?)
li_Succ = of_create_ellipse(radw_target, li_X_pos, li_Y_pos, li_Height, li_Width, ll_color, ls_Band)

// Zeichne Zeile 1
li_y_pos += 0
li_Succ = of_create_text(radw_target, ls_healthmark_1, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 2
li_y_pos += li_Text_height
li_Succ = of_create_text(radw_target, ls_healthmark_2, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 3
li_y_pos += li_Text_height
li_Succ = of_create_text(radw_target, ls_healthmark_3, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Bring to Top
li_Succ = of_bring_to_front(radw_target)


Return 1

end function

public function integer of_draw_healthmark (ref datastore rads_target, string as_unit, integer ai_type, boolean ab_header_in_footer);/*
* Objekt : uo_healthmark
* Methode: of_draw_healthmark (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* ref datastore	rads_target
*	 	string		as_unit
*
* Beschreibung:		Zeichne UK Healthmark
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
Integer	li_X_pos
Integer	li_Y_pos
Integer	li_Height						= 48
Integer	li_Width							= 96
Integer	li_fontsize						= 9
integer	li_fontweight					= FONT_BOLD		// BOLD	
Integer	li_align							= ALIGN_CENTER
Integer	li_border						= 0				// NONE
Integer	li_Text_height					= 15
Long		ll_color							= RGB(0, 0, 0) // Black
String	ls_healthmark_1				
String	ls_healthmark_2
String	ls_healthmark_3
String	ls_Modify
String	ls_Object
String	ls_Font							= "Arial"
String	ls_Band							= "Foreground"



// Lese 3 Healthmark Felder pro Unit
li_Succ = of_read_settings(as_Unit, ls_healthmark_1, ls_healthmark_2, ls_healthmark_3)

// wenn Text leer, dann nicht zeichnen
If IsNULL(ls_healthmark_2) OR Trim(ls_healthmark_2) = "" Then
	Return 0	
End If


// Position auf dem Ziel? 
li_Succ = of_get_position(as_unit, li_X_pos, li_Y_pos, ls_Band, ai_Type, li_fontsize, ls_Font, li_fontweight, ab_header_in_footer )

// Zeichne Ellipse (Gr$$HEX2$$f600df00$$ENDHEX$$e?)
li_Succ = of_create_ellipse(rads_target, li_X_pos, li_Y_pos, li_Height, li_Width, ll_color, ls_Band)

// Zeichne Zeile 1
li_y_pos += 0
li_Succ = of_create_text(rads_target, ls_healthmark_1, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 2
li_y_pos += li_Text_height
li_Succ = of_create_text(rads_target, ls_healthmark_2, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Zeichne Zeile 3
li_y_pos += li_Text_height
li_Succ = of_create_text(rads_target, ls_healthmark_3, ls_Font, li_fontsize, li_fontweight, li_X_pos, li_y_pos, li_Text_height, li_width, li_border, li_align, ls_Band)

// Bring to Top
li_Succ = of_bring_to_front(rads_target)

Return 1
end function

protected function integer of_get_position (string as_unit, ref integer rai_x_pos, ref integer rai_y_pos, ref string ras_band, integer ai_type, ref integer rai_font_size, ref string ras_fontname, ref integer rai_fontweight, boolean ab_header_in_footer);/*
* Objekt : uo_healthmark
* Methode: of_get_position (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
*	 ref integer rai_x_pos
*	 ref integer rai_y_pos
*
* Beschreibung:		Position des Healthmark bestimmen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
String	ls_Type

If ab_header_in_footer Then
	ls_Type = "HEALTHMARK2"
Else
	ls_Type = "HEALTHMARK"
End If


// lese aus Profil (pro CSC und Dokumententyp)
If ai_Type = CARTDIAGRAM Then
	rai_x_pos = 620
	rai_y_pos = 25
	//ras_band = "detail"
	ras_band = "Foreground"
	
	If ab_header_in_footer Then
		rai_x_pos = 150
		rai_y_pos = 40
		//ras_band = "detail"
		ras_band = "Footer"
	End If

ElseIf ai_Type = DELIVERYNOTE Then
	rai_x_pos = 123
	rai_y_pos = 81
	//ras_band = "header"
	//ras_band = "detail"
	ras_band = "Foreground"
End If
	
ras_band			= 				of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "BAND", ras_band	)
rai_x_pos		= Integer(	of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "XPOS", String(rai_x_pos)	) )
rai_y_pos		= Integer(	of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "YPOS", String(rai_y_pos)	) )
rai_Font_Size	= Integer(	of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "FONTSIZE", String(rai_Font_Size)	) )
ras_Fontname	= 				of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "FONTNAME", ras_Fontname	 )
rai_fontweight	= Integer(	of_unit_profilestring(as_unit, ls_Type, String(ai_type) + "FONTWEIGHT", String(rai_fontweight)	) )
If rai_fontweight <> FONT_BOLD and rai_fontweight <> FONT_NORMAL Then
	rai_fontweight = FONT_BOLD
End If

return li_Succ

end function

on uo_healthmark.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_healthmark.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

