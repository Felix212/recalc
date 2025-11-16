HA$PBExportHeader$uo_str_draw_columns.sru
forward
global type uo_str_draw_columns from nonvisualobject
end type
end forward

global type uo_str_draw_columns from nonvisualobject autoinstantiate
end type

type variables

public:


String 	is_ColumnName	// column-name
String 	is_ObjectName		// column-name
Decimal 	idec_Proz 			// breite in prozent der gesamtbreite

Long 	il_PosX, il_PosY 		// position (zu berechnen)
Long 	il_Width, il_Height 		// breite (zu berechnen)

// weitere eigenschaften (setzen)
Long 	il_BorderStyle 			// art des rahmens
Long 	il_Fontsize 				// schriftgr$$HEX1$$f600$$ENDHEX$$sse
Long 	il_Fontweight 			// schriftgewicht (700 fett, 400 normal)
Long 	il_FontColor 			// schriftfarbe
Long 	il_TextAlign 				// schriftausrichtung (0 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 1 rechtsb$$HEX1$$fc00$$ENDHEX$$ndig, 2 zentriert)
Long 	il_FontUnderline 		// schrift unterstrichen
Long 	il_FontItalic 				// schrift kursiv
Long 	il_BackgroundMode 	// hintergrund-art (z.b. transparent)
Long 	il_BackgroundColor 	// hintergrundfarbe
Long 	il_Resize					// resize erlaubt
Long 	il_Move 					// bewegen erlaubt

String is_Fontname 			// schriftart
String is_FontPitch = "2" 	// schriftgr$$HEX1$$f600$$ENDHEX$$sse
String is_FontFamily = "2" 	// familie der schriftart

// default-schalter: wenn false, dann darf default $$HEX1$$fc00$$ENDHEX$$berschreiben
Boolean 	ib_BorderStyle = false
Boolean 	ib_Fontsize = false
Boolean 	ib_Fontweight = false
Boolean 	ib_FontColor = false
Boolean 	ib_TextAlign = false
Boolean 	ib_FontUnderline = false
Boolean 	ib_FontItalic = false
Boolean 	ib_BackgroundMode = false
Boolean 	ib_BackgroundColor = false
Boolean 	ib_Resize = false
Boolean 	ib_Move = false

Boolean ib_Fontname = false
Boolean ib_FontPitch = false
Boolean ib_FontFamily = false

// bedingung: wenn <> "" dann eintragen (Tab wird beim anlegen erg$$HEX1$$e400$$ENDHEX$$nzt, nicht hier mit eintragen)
String 	is_If_BorderStyle = ""
String 	is_If_Fontsize = ""
String 	is_If_Fontweight = ""
String 	is_If_FontColor = ""
String 	is_If_FontUnderline = ""
String 	is_If_FontItalic = ""
String 	is_If_BackgroundColor = ""

end variables

on uo_str_draw_columns.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_str_draw_columns.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

