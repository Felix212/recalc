HA$PBExportHeader$uo_draw_objects.sru
$PBExportComments$packe objekte ins datastore
forward
global type uo_draw_objects from nonvisualobject
end type
end forward

global type uo_draw_objects from nonvisualobject autoinstantiate
end type

type variables


protected:

// horizontale raster-linien
Boolean 	ib_GridHorizontal = false
Long 		il_GridHorizontalColor = 0
Long 		il_GridHorizontalWidth = 1
// vertikale raster-linien
Boolean ib_GridVertical = false
Long 		il_GridVerticalColor = 0
Long 		il_GridVerticalWidth = 1

// logfile
String 	is_Logfile = ""

// trace-schalter
boolean ib_Trace = false

end variables

forward prototypes
public function long of_get_next_column_id (datastore ads_2check)
public function long of_decide_columns_horizontal (ref uo_str_draw_columns astr_columns[], long al_posx, long al_width, long al_offset)
public function long of_init_grid_vertical (boolean ab_switch)
public function long of_init_grid (boolean ab_switch)
public function long of_log (string as_msg)
public function long of_init_logfile (string as_file)
public function long of_set_columns_properties (ref uo_str_draw_columns astr_columns[], long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_fontitalic, long al_backgroundmode, long al_backgroundcolor, long al_resize, long al_move, string as_fontname, string as_fontpitch, string as_fontfamily)
public function long of_init_grid_horizontal (boolean ab_switch, long al_color, long al_width)
public function long of_init_grid_horizontal (boolean ab_switch, long al_color)
public function long of_init_grid_horizontal (boolean ab_switch)
public function long of_init_grid_vertical (boolean ab_switch, long al_color, long al_width)
public function long of_init_grid_vertical (boolean ab_switch, long al_color)
public function long of_init_grid (boolean ab_switch, long al_color, long al_width)
public function long of_init_grid (boolean ab_switch, long al_color)
public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight)
public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight, long al_textrows)
public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row)
public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long ll_posy)
public function long of_draw_line (datastore ads_2modify, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor)
public function long of_draw_line (datastore ads_2modify, string as_objectname, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor)
public function long of_draw_column_char (datastore ads_2modify, string as_objectname, long al_length, long al_posx, long al_posy, long al_height, long al_width, long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_fontitalic, long al_backgroundmode, long al_backgroundcolor, long al_resize, long al_move, string as_fontname, string as_fontpitch, string as_fontfamily)
public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long al_labeldetailkey, datastore ads_objects)
public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long ll_posy, long al_labeldetailkey, datastore ads_objects)
public function long of_insert_object (datastore ads_objects, long al_labeldetailkey, string as_objectname, long al_posx, long al_posy, long al_height, long al_width, long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_backgroundmode, long al_backgroundcolor, string as_fontname)
protected function long of_draw_column_char (datastore ads_2modify, string as_objectname, long al_length, uo_str_draw_columns astr_columns)
protected function long of_check_conditions (ref uo_str_draw_columns astr_columns[], long al_row)
public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight, long al_textrows, long al_labeldetailkey, datastore ads_objects)
end prototypes

public function long of_get_next_column_id (datastore ads_2check);
/*
* Function:	of_get_next_column_id
*
* Argument(e):
* 		ads_2Check
*
*
* Beschreibung:		n$$HEX1$$e400$$ENDHEX$$chste freie id im DS bestimmen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: Long
*	n$$HEX1$$e400$$ENDHEX$$chste freie ID
*/


// ----------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r das dynamische Einf$$HEX1$$fc00$$ENDHEX$$gen von Column-Objecten
// in ein DW ist es notwendig, da$$HEX2$$df002000$$ENDHEX$$das 
// Column Property >>ID<< fortlaufend vergeben wird,
// sonst rappelts !!
// ----------------------------------------------------

// hilfsvariable
Long 	ll_Ret, ll_Id
Long 	ll_Row, ll_ColumnCount

// initialisieren
ll_Ret = 0

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns
ll_ColumnCount = long(ads_2Check.Object.DataWindow.Column.Count)
for ll_Row = 1 to ll_ColumnCount step 1
	ll_Id = long(ads_2Check.Describe("#" + string(ll_Row) + ".Id"))
	if ll_Id > ll_Ret then ll_Ret = ll_Id
next

return ll_Ret + 1

end function

public function long of_decide_columns_horizontal (ref uo_str_draw_columns astr_columns[], long al_posx, long al_width, long al_offset);
/*
* Function:	of_decide_columns_horizontal
*
* Argument(e):
* ref	astr_columns[] 		die struktur, die es zu f$$HEX1$$fc00$$ENDHEX$$llen gilt
* 		al_PosX 					die X-position der column
* 		al_Width 				die breite der column
* 		al_Offset 				der Abstand zwischen den Spalten
*
*
* Beschreibung:		breite und x-position der columns berechnen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
Long 		ll_Row


// erste column sitzt auf der X-Position des gesamtes Feldes
astr_Columns[1].il_PosX = al_PosX
astr_Columns[1].il_Width = truncate((al_Width - (Upperbound(astr_Columns) * al_Offset)) * astr_Columns[1].idec_Proz, 0)

// die restlichen columns sitzen relativ zum vorg$$HEX1$$e400$$ENDHEX$$nger
for ll_Row = 2 to Upperbound(astr_Columns) step 1
	astr_Columns[ll_Row].il_PosX = astr_Columns[ll_Row - 1].il_PosX + astr_Columns[ll_Row - 1].il_Width + al_Offset
	astr_Columns[ll_Row].il_Width = truncate((al_Width - (Upperbound(astr_Columns) * al_Offset)) * astr_Columns[ll_Row].idec_Proz, 0)
next

return 0

end function

public function long of_init_grid_vertical (boolean ab_switch);
/*
* Function:	of_init_grid_vertical
*
* Argument(e):
* 		ab_Switch
*
*
* Beschreibung:		schalter vertikale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


return this.of_init_grid_vertical(ab_Switch, this.il_GridVerticalColor)

end function

public function long of_init_grid (boolean ab_switch);
/*
* Function:	of_init_grid
*
* Argument(e):
* 		ab_Switch 	Schalter, ob raster-linien gezeichnet werden sollen
*
*
* Beschreibung:		schalter raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/

// hilfsvariable
Long 	ll_Ret

// separat lassen, damit die separaten defaults genommen werden
ll_Ret = this.of_init_grid_horizontal(ab_Switch)
ll_Ret = this.of_init_grid_vertical(ab_Switch)

return 0

end function

public function long of_log (string as_msg);
/*
* Function:	of_log
*
* Argument(e):
* 		as_Msg
*
*
* Beschreibung:		breite und x-position der columns berechnen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung ($$HEX1$$fc00$$ENDHEX$$bernommen aus uo_label_other)
*
*
* Return: integer
*	0 	immer
*/

// hilfsvariable
integer li_File
string 	ls_filename

// 28.12.2021 HR: Filename with date
if this.ib_Trace then
	ls_filename = "tcbase_label_"
else
	ls_filename = "cbase_label_"
end if
ls_filename += string(today(), "yyyy-mm-dd") + ".log"

//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

if IsNull(this.is_LogFile) then this.is_LogFile = f_gettemppath() + ls_filename
if this.is_LogFile = "" then this.is_LogFile = f_gettemppath() + ls_filename

li_File = FileOpen(this.is_LogFile, LineMode!, Write!, Shared!)
FileWrite(li_File, string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + " " + as_Msg)
FileClose(li_File)

return 0

end function

public function long of_init_logfile (string as_file);
/*
* Function:	of_init_logfile
*
* Argument(e):
* 		as_File
*
*
* Beschreibung:		logfile-name setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


this.is_LogFile = as_File

return 0

end function

public function long of_set_columns_properties (ref uo_str_draw_columns astr_columns[], long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_fontitalic, long al_backgroundmode, long al_backgroundcolor, long al_resize, long al_move, string as_fontname, string as_fontpitch, string as_fontfamily);
/*
* Function:	of_set_columns_properties
*
* Argument(e):
* ref	astr_columns[] 		die struktur, die es zu f$$HEX1$$fc00$$ENDHEX$$llen gilt
* 		al_BorderStyle 			die Art des rahmens der column
* 		al_Fontsize 				die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
* 		al_Fontweight 			das schriftgewicht (700 fett, 400 normal) der column
* 		al_FontColor 			die schriftfarbe der column
* 		al_TextAlign 			die schriftausrichtung (0 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 1 rechtsb$$HEX1$$fc00$$ENDHEX$$ndig, 2 zentriert)
* 		al_FontUnderline 		Schalter "schrift unterstrichen" der column
* 		al_FontItalic 			Schalter "schrift kursiv" der column
* 		al_BackgroundMode 	die hintergrund-art (z.b. transparent) der column
* 		al_BackgroundColor 	die hintergrundfarbe der column
* 		al_Resize 				Schalter "resize erlaubt" der column
* 		al_Move 					Schalter "bewegen erlaubt" der column
* 		as_Fontname 			die schriftart der column
* 		as_FontPitch 			die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
* 		as_FontFamily 			die familie der schriftart der column
*
*
* Beschreibung:		f$$HEX1$$fc00$$ENDHEX$$r alle columns die gleichen (default-)eigenschaften setzen
* 							wenn der entsprechende schalter auf true: nicht tun, bereits individuell gesetzt!
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
Long 		ll_Ret, ll_Row


// schleife $$HEX1$$fc00$$ENDHEX$$ber die columns
for ll_Row = 1 to Upperbound(astr_Columns) step 1
	if not astr_Columns[ll_Row].ib_BorderStyle then astr_Columns[ll_Row].il_BorderStyle = al_BorderStyle
	if not astr_Columns[ll_Row].ib_Fontsize then astr_Columns[ll_Row].il_Fontsize = al_FontSize
	if not astr_Columns[ll_Row].ib_Fontweight then astr_Columns[ll_Row].il_Fontweight = al_FontWeight
	if not astr_Columns[ll_Row].ib_FontColor then astr_Columns[ll_Row].il_FontColor = al_FontColor
	if not astr_Columns[ll_Row].ib_TextAlign then astr_Columns[ll_Row].il_TextAlign = al_TextAlign
	if not astr_Columns[ll_Row].ib_FontUnderline then astr_Columns[ll_Row].il_FontUnderline = al_FontUnderline
	if not astr_Columns[ll_Row].ib_FontItalic then astr_Columns[ll_Row].il_FontItalic = al_FontItalic
	if not astr_Columns[ll_Row].ib_BackgroundMode then astr_Columns[ll_Row].il_BackgroundMode = al_BackgroundMode
	if not astr_Columns[ll_Row].ib_BackgroundColor then astr_Columns[ll_Row].il_BackgroundColor = al_BackgroundColor
	if not astr_Columns[ll_Row].ib_Resize then astr_Columns[ll_Row].il_Resize = al_Resize
	if not astr_Columns[ll_Row].ib_Move then astr_Columns[ll_Row].il_Move = al_Move
	if not astr_Columns[ll_Row].ib_Fontname then astr_Columns[ll_Row].is_Fontname = as_Fontname
	if not astr_Columns[ll_Row].ib_FontPitch then astr_Columns[ll_Row].is_FontPitch = as_FontPitch
	if not astr_Columns[ll_Row].ib_FontFamily then astr_Columns[ll_Row].is_FontFamily = as_FontFamily
next

return 0

end function

public function long of_init_grid_horizontal (boolean ab_switch, long al_color, long al_width);
/*
* Function:	of_init_grid_horizontal
*
* Argument(e):
* 		ab_Switch 	Schalter, ob horizontale linien gezeichnet werden sollen
* 		al_Color 		Farbe der horizontalen linien
* 		al_Width 	Breite der horizontalen linien
*
*
* Beschreibung:		schalter horizontale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


this.ib_GridHorizontal = ab_Switch
this.il_GridHorizontalColor = al_Color
this.il_GridHorizontalWidth = al_Width

return 0

end function

public function long of_init_grid_horizontal (boolean ab_switch, long al_color);
/*
* Function:	of_init_grid_horizontal
*
* Argument(e):
* 		ab_Switch 	Schalter, ob horizontale linien gezeichnet werden sollen
* 		al_Color 		Farbe der horizontalen linien
*
*
* Beschreibung:		schalter horizontale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


return this.of_init_grid_horizontal(ab_Switch, al_Color, this.il_GridHorizontalWidth)

end function

public function long of_init_grid_horizontal (boolean ab_switch);
/*
* Function:	of_init_grid_horizontal
*
* Argument(e):
* 		ab_Switch 	Schalter, ob horizontale linien gezeichnet werden sollen
*
*
* Beschreibung:		schalter horizontale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


return this.of_init_grid_horizontal(ab_Switch, this.il_GridHorizontalColor)

end function

public function long of_init_grid_vertical (boolean ab_switch, long al_color, long al_width);
/*
* Function:	of_init_grid_vertical
*
* Argument(e):
* 		ab_Switch 	Schalter, ob vertikale linien gezeichnet werden sollen
* 		al_Color 		Farbe der vertikale linien
* 		al_Width 	Breite der vertikale linien
*
*
* Beschreibung:		schalter vertikale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


this.ib_GridVertical = ab_Switch
this.il_GridVerticalColor = al_Color
this.il_GridVerticalWidth = al_Width

return 0

end function

public function long of_init_grid_vertical (boolean ab_switch, long al_color);
/*
* Function:	of_init_grid_vertical
*
* Argument(e):
* 		ab_Switch 	Schalter, ob vertikale linien gezeichnet werden sollen
* 		al_Color 		Farbe der vertikale linien
*
*
* Beschreibung:		schalter vertikale raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/


return this.of_init_grid_vertical(ab_Switch, al_Color, this.il_GridVerticalWidth)

end function

public function long of_init_grid (boolean ab_switch, long al_color, long al_width);
/*
* Function:	of_init_grid
*
* Argument(e):
* 		ab_Switch 	Schalter, ob raster-linien gezeichnet werden sollen
* 		al_Color 		Farbe der raster-linien
* 		al_Width 	Breite der raster-linien
*
*
* Beschreibung:		schalter raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/

// hilfsvariable
Long 	ll_Ret

ll_Ret = this.of_init_grid_horizontal(ab_Switch, al_Color, al_Width)
ll_Ret = this.of_init_grid_vertical(ab_Switch, al_Color, al_Width)

return 0

end function

public function long of_init_grid (boolean ab_switch, long al_color);
/*
* Function:	of_init_grid
*
* Argument(e):
* 		ab_Switch 	Schalter, ob raster-linien gezeichnet werden sollen
* 		al_Color 		Farbe der raster-linien
*
*
* Beschreibung:		schalter raster-linien setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	immer
*/

// hilfsvariable
Long 	ll_Ret

// separat lassen, damit die separaten defaults genommen werden
ll_Ret = this.of_init_grid_horizontal(ab_Switch, al_Color)
ll_Ret = this.of_init_grid_vertical(ab_Switch, al_Color)

return 0

end function

public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight);
/*
* Function:	of_draw_block
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[] 	die spezifika der columns
* 		al_PosX 				die X-Start-Position des Blocks
* 		al_PosY 				die Y-Start-Position des Blocks
* 		al_Width 			die Breite des Blocks
* 		al_Height 			die H$$HEX1$$f600$$ENDHEX$$he des Blocks
* 		al_Offset 			der Abstand zwischen den Spalten
* 		al_TextHeight 		die H$$HEX1$$f600$$ENDHEX$$he einer Textzeile
*
*
* Beschreibung:		zeichne den kompletten Block
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/


// hilfsvariable
datastore 	lds_Temp

return this.of_draw_block(ads_2Modify, astr_columns, al_PosX, al_PosY, al_Width, al_Height, al_Offset, al_TextHeight, -1, -1, lds_Temp)

end function

public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight, long al_textrows);
/*
* Function:	of_draw_block
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[] 	die spezifika der columns
* 		al_PosX 				die X-Start-Position des Blocks
* 		al_PosY 				die Y-Start-Position des Blocks
* 		al_Width 			die Breite des Blocks
* 		al_Height 			die H$$HEX1$$f600$$ENDHEX$$he des Blocks
* 		al_Offset 			der Abstand zwischen den Spalten
* 		al_TextHeight 		die H$$HEX1$$f600$$ENDHEX$$he einer Textzeile
* 		al_TextRows 		die Anzahl Textzeilen (-1, wenn hier berechnet werden soll)
*
*
* Beschreibung:		zeichne den kompletten Block
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		05.07.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/


// hilfsvariable
datastore 	lds_Temp

return this.of_draw_block(ads_2Modify, astr_columns, al_PosX, al_PosY, al_Width, al_Height, al_Offset, al_TextHeight, al_TextRows, -1, lds_Temp)

end function

public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row);
/*
* Function:	of_draw_row
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[]
* 		al_Row
*
*
* Beschreibung:		alle columns in der struktur ins DS setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
datastore 	lds_Temp

return this.of_draw_row(ads_2Modify, astr_columns, al_Row, -1, lds_Temp)

end function

public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long ll_posy);
/*
* Function:	of_draw_row
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[]
* 		al_Row
* 		al_PosY
*
*
* Beschreibung:		alle columns in der struktur ins DS setzen
* 							hier erstmal nur die Y-koordinate setzen, dann weiter in die eigentliche funktion
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
Long 		ll_Ret, ll_Row

// schleife $$HEX1$$fc00$$ENDHEX$$ber die columns
for ll_Row = 1 to Upperbound(astr_Columns) step 1
	astr_Columns[ll_Row].il_PosY = ll_PosY
next

return this.of_draw_row(ads_2Modify, astr_Columns, al_Row)

end function

public function long of_draw_line (datastore ads_2modify, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor);
/*
* Function:	of_draw_line
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		al_PosX1 
* 		al_PosY1 
* 		al_PosX2 
* 		al_PosY1 
* 		al_PenWidth 
* 		al_PenColor 
*
*
* Beschreibung:		eine linie zeichnen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_ObjectName

ls_ObjectName = "line_" + string(rand(32767))

return this.of_draw_line(ads_2Modify, ls_ObjectName, al_PosX1, al_PosY1, al_PosX2, al_PosY2, al_PenWidth, al_PenColor)

end function

public function long of_draw_line (datastore ads_2modify, string as_objectname, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor);
/*
* Function:	of_draw_line
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		as_ObjectName 
* 		al_PosX1 
* 		al_PosY1 
* 		al_PosX2 
* 		al_PosY1 
* 		al_PenWidth 
* 		al_PenColor 
*
*
* Beschreibung:		eine linie zeichnen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_SyntaxCreate, ls_Ret

ls_SyntaxCreate = "create line(band=detail" + &
			" x1='" + string(al_PosX1) + "' y1='" + string(al_PosY1) + "'" + &
			" x2='" + string(al_PosX2) + "' y2='" + string(al_PosY2) + "'" + &
			" name=" + as_ObjectName + "  moveable=0 visible='1'" + &
			" pen.style='0' pen.width='" + string(al_PenWidth) + "' pen.color='" + string(al_PenColor) + "'" + &
			" background.mode='2' background.color='16777215' )"

ls_Ret = ads_2Modify.modify(ls_SyntaxCreate)

if ls_Ret <> "" then
	of_log("Error -5, create line  : " + ls_Ret)
	of_log("Error -5, create syntax: " + ls_SyntaxCreate)
	return -5
end if

return 0

end function

public function long of_draw_column_char (datastore ads_2modify, string as_objectname, long al_length, long al_posx, long al_posy, long al_height, long al_width, long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_fontitalic, long al_backgroundmode, long al_backgroundcolor, long al_resize, long al_move, string as_fontname, string as_fontpitch, string as_fontfamily);
/*
* Function:	of_draw_column_char
*
* Argument(e):
* 		aDS_2Modify 			das zu erweiternde DS
* 		as_Objectname 		der name der column
* 		al_Length 				die l$$HEX1$$e400$$ENDHEX$$nge der column
* 		al_PosX 					die X-position der column
* 		al_PosY 					die Y-position der column
* 		al_Height 				die h$$HEX1$$f600$$ENDHEX$$he der column
* 		al_Width 				die breite der column
* 		al_BorderStyle 			die Art des rahmens der column
* 		al_Fontsize 				die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
* 		al_Fontweight 			das schriftgewicht (700 fett, 400 normal) der column
* 		al_FontColor 			die schriftfarbe der column
* 		al_TextAlign 			die schriftausrichtung (0 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 1 rechtsb$$HEX1$$fc00$$ENDHEX$$ndig, 2 zentriert)
* 		al_FontUnderline 		Schalter "schrift unterstrichen" der column
* 		al_FontItalic 			Schalter "schrift kursiv" der column
* 		al_BackgroundMode 	die hintergrund-art (z.b. transparent) der column
* 		al_BackgroundColor 	die hintergrundfarbe der column
* 		al_Resize 				Schalter "resize erlaubt" der column
* 		al_Move 					Schalter "bewegen erlaubt" der column
* 		as_Fontname 			die schriftart der column
* 		as_FontPitch 			die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
* 		as_FontFamily 			die familie der schriftart der column
*
*
* Beschreibung:		zeichne eine text-column
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// allgemeine hilfsvariable
Long 	ll_Ret

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_DWSyntax, ls_SyntaxCreate, ls_Ret, ls_NewLength
integer 	li_InsertPos
Long 		ll_NewId
String 	ls_Autosize


// ----------------------------------------------------
// initialisieren
// ----------------------------------------------------
ls_NewLength = string(al_Length)
ls_Autosize = "height.autosize=no edit.autovscroll=no"

// n$$HEX1$$e400$$ENDHEX$$chste id f$$HEX1$$fc00$$ENDHEX$$r die column bestimmen: VOR dem ersten create/modify!!
ll_NewId = this.of_get_next_column_id(ads_2Modify)

// ----------------------------------------------------
// DW Syntax holen
// ----------------------------------------------------
// DW Syntax holen und die "einsprung"-position bestimmen
ls_DWSyntax = ads_2Modify.describe("datawindow.syntax")
li_InsertPos = Pos(ls_DWSyntax, "text(name=jumppoint")

if li_InsertPos > 0 then
	ls_DWSyntax = Mid(ls_DWSyntax, 1, li_InsertPos - 4) + "column=(type=char(" + ls_NewLength + ") updatewhereclause=no name=" + as_ObjectName + " dbname='" + as_ObjectName + "')~r~n" + Mid(ls_DWSyntax, li_InsertPos - 3)
	ll_Ret = ads_2Modify.create(ls_DWSyntax)

	if this.ib_Trace then this.of_log("Trace create column: ID=" + string(ll_NewId) + ", columnname=" + as_ObjectName)
	if ll_Ret <> 1 then
		of_log("Error -4, create column: " + string(ll_Ret))
		of_log("Error -4, create syntax: " + ls_DWSyntax)
		return -4
	end if

else
	return 0
end  if

// --------------------------------------------------------
// DW Syntax - neue Column eintragen im DW-Syntax-"Detail"
// --------------------------------------------------------
ls_SyntaxCreate = "create column(band=detail id=" + string(ll_NewId) + " alignment='" + string(al_TextAlign) + &
						"' tabsequence=0 border='" + string(al_BorderStyle) + &
						"' color='" + string(al_FontColor) + &
						"' x='" + string(al_PosX, "0") + "' y='" + string(al_PosY, "0") + &
						"' height='" + string(al_Height, "0") + "' width='" + string(al_Width, "0") + &
						"' format='[General]'  name=" + as_ObjectName + &
						" resizeable=" + string(al_Resize) + "  moveable=" + string(al_Move) + &
						" edit.limit=0 edit.case=any " + ls_Autosize + " edit.autoselect=yes edit.autohscroll=yes  font.face='" + as_Fontname + &
						"' font.height='" + string(al_FontSize) + &
						"' font.weight='" +string(al_FontWeight) + &
						"' font.italic='" + string(al_FontItalic) + &
						"' font.underline='" + string(al_FontUnderline) + &
						"' font.family='" + as_FontFamily + "' font.pitch='" + as_FontPitch + "' font.charset='0' background.mode='" + string(al_BackgroundMode) + &
						"' background.color='" + string(al_BackgroundColor) +"' )"
		
ls_Ret = ads_2Modify.modify(ls_SyntaxCreate)

if ls_Ret <> "" then
	of_log("Error -4, create column: " + ls_Ret)
	of_log("Error -4, create syntax: " + ls_SyntaxCreate)
	return -4
end if

return 0

end function

public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long al_labeldetailkey, datastore ads_objects);
/*
* Function:	of_draw_row
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[]
* 		al_Row
* 		al_LabelDetailKey 	-1, wenn objects nicht gepflegt werden sollen
* 		aDS_Objects 		datastore, wo die objects ggf. reingestellt werden sollen
*
*
* Beschreibung:		alle columns in der struktur ins DS setzen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
Long 		ll_Ret = 0
Long 		ll_Row
String 	ls_Name
Long 		ll_NewLength = 30


// check die bedingungen (namen anpassen auf die aktuell betrachtete al_row)
this.of_check_conditions(astr_Columns, al_Row)

// schleife $$HEX1$$fc00$$ENDHEX$$ber die columns
for ll_Row = 1 to Upperbound(astr_Columns) step 1
	ls_Name = astr_Columns[ll_Row].is_ObjectName + "_" + String(al_Row)
	
	ll_Ret = this.of_draw_column_char (aDS_2Modify, ls_Name, ll_NewLength, astr_Columns[ll_Row])

	// fehler: abbruch
	if ll_Ret <> 0 then exit
		
	if al_LabelDetailKey <> -1 and IsValid(aDS_Objects) then
		ll_Ret = this.of_insert_object(aDS_Objects, al_LabelDetailKey, ls_Name, &
						astr_Columns[ll_Row].il_PosX, astr_Columns[ll_Row].il_PosY, astr_Columns[ll_Row].il_Height, astr_Columns[ll_Row].il_Width, &
						astr_Columns[ll_Row].il_BorderStyle, astr_Columns[ll_Row].il_FontSize, astr_Columns[ll_Row].il_FontWeight, astr_Columns[ll_Row].il_FontColor, &
						astr_Columns[ll_Row].il_TextAlign, astr_Columns[ll_Row].il_FontUnderline, &
						astr_Columns[ll_Row].il_BackgroundMode, astr_Columns[ll_Row].il_BackgroundColor, &
						astr_Columns[ll_Row].is_Fontname)
	end if
next

return ll_Ret

end function

public function long of_draw_row (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_row, long ll_posy, long al_labeldetailkey, datastore ads_objects);
/*
* Function:	of_draw_row
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[]
* 		al_Row
* 		al_PosY				Y-Position, auf der die zeile geschrieben werden soll
* 		al_LabelDetailKey 	-1, wenn objects nicht gepflegt werden sollen
* 		aDS_Objects 		datastore, wo die objects ggf. reingestellt werden sollen
*
*
* Beschreibung:		alle columns in der struktur ins DS setzen
* 							hier erstmal nur die Y-koordinate setzen, dann weiter in die eigentliche funktion
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable
Long 		ll_Ret, ll_Row

// schleife $$HEX1$$fc00$$ENDHEX$$ber die columns
for ll_Row = 1 to Upperbound(astr_Columns) step 1
	astr_Columns[ll_Row].il_PosY = ll_PosY
next

return this.of_draw_row(ads_2Modify, astr_Columns, al_Row, al_LabelDetailKey, aDS_Objects)

end function

public function long of_insert_object (datastore ads_objects, long al_labeldetailkey, string as_objectname, long al_posx, long al_posy, long al_height, long al_width, long al_borderstyle, long al_fontsize, long al_fontweight, long al_fontcolor, long al_textalign, long al_fontunderline, long al_backgroundmode, long al_backgroundcolor, string as_fontname);
/*
* Function:	of_insert_object
*
* Argument(e):
* 		aDS_Objects 			das zu erweiternde DS
* 		al_LabelDetailKey
* 		as_Objectname 		der name der column
* 		al_PosX 					die X-position der column
* 		al_PosY 					die Y-position der column
* 		al_Height 				die h$$HEX1$$f600$$ENDHEX$$he der column
* 		al_Width 				die breite der column
* 		al_BorderStyle 			die Art des rahmens der column
* 		al_Fontsize 				die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
* 		al_Fontweight 			das schriftgewicht (700 fett, 400 normal) der column
* 		al_FontColor 			die schriftfarbe der column
* 		al_TextAlign 			die schriftausrichtung (0 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 1 rechtsb$$HEX1$$fc00$$ENDHEX$$ndig, 2 zentriert)
* 		al_FontUnderline 		Schalter "schrift unterstrichen" der column
- 		al_FontItalic 			Schalter "schrift kursiv" der column
* 		al_BackgroundMode 	die hintergrund-art (z.b. transparent) der column
* 		al_BackgroundColor 	die hintergrundfarbe der column
- 		al_Resize 				Schalter "resize erlaubt" der column
- 		al_Move 					Schalter "bewegen erlaubt" der column
* 		as_Fontname 			die schriftart der column
- 		as_FontPitch 			die schriftgr$$HEX1$$f600$$ENDHEX$$sse der column
- 		as_FontFamily 			die familie der schriftart der column
*
*
* Beschreibung:		trage einen satz f$$HEX1$$fc00$$ENDHEX$$r die column ins objects-DS ein
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		13.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// allgemeine hilfsvariable
Long 	ll_Ret, ll_Row


// --------------------------------------------------------
// neue Column als neue zeile eintragen
// --------------------------------------------------------
ll_Row = aDS_Objects.InsertRow(0)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nlabel_detail_key", al_LabelDetailKey)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nobject_type", 1)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nxpos", al_PosX)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nypos", al_PosY)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nheight", al_Height)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nwidth", al_Width)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nborderstyle", al_BorderStyle)
ll_Ret = aDS_Objects.SetItem(ll_Row, "cfontname", as_Fontname)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nfontsize", al_FontSize)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nfontweight", al_FontWeight)
ll_Ret = aDS_Objects.SetItem(ll_Row, "cobject_name", as_ObjectName)
ll_Ret = aDS_Objects.SetItem(ll_Row, "ntextalign", al_TextAlign)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nfontunderline", al_FontUnderline)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nbackgroundmode", al_BackgroundMode)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nfontcolor", al_FontColor)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nbackgroundcolor", al_BackgroundColor)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nbrushcolor", al_FontColor)
ll_Ret = aDS_Objects.SetItem(ll_Row, "npencolor", al_FontColor)
ll_Ret = aDS_Objects.SetItem(ll_Row, "npenwidth", 1)
ll_Ret = aDS_Objects.SetItem(ll_Row, "nbrushhatch", 1)
ll_Ret = aDS_Objects.SetItem(ll_Row, "ccolumn", as_ObjectName)

return 0

end function

protected function long of_draw_column_char (datastore ads_2modify, string as_objectname, long al_length, uo_str_draw_columns astr_columns);
/*
* Function:	of_draw_column_char
*
* Argument(e):
* 		aDS_2Modify 			das zu erweiternde DS
* 		as_Objectname 		der name der column
* 		al_Length 				die l$$HEX1$$e400$$ENDHEX$$nge der column
* 		astr_columns 			die eigenschaften der column
*
*
* Beschreibung:		zeichne eine text-column
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// allgemeine hilfsvariable
Long 	ll_Ret

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_DWSyntax, ls_SyntaxCreate, ls_Ret, ls_NewLength
integer 	li_InsertPos
Long 		ll_NewId
String 	ls_Autosize

// hilfsvariable bedingungen
String 	ls_If_BorderStyle = ""
String 	ls_If_Fontsize = ""
String 	ls_If_Fontweight = ""
String 	ls_If_FontColor = ""
String 	ls_If_FontUnderline = ""
String 	ls_If_FontItalic = ""
String 	ls_If_BackgroundColor = ""



// ----------------------------------------------------
// initialisieren
// ----------------------------------------------------
ls_NewLength = string(al_Length)
ls_Autosize = "height.autosize=no edit.autovscroll=no"

if astr_Columns.is_If_BorderStyle <> "" then ls_If_BorderStyle = "~~t" + astr_Columns.is_If_BorderStyle
if astr_Columns.is_If_Fontsize <> "" then ls_If_Fontsize = "~~t" + astr_Columns.is_If_Fontsize
if astr_Columns.is_If_Fontweight <> "" then ls_If_Fontweight = "~~t" + astr_Columns.is_If_Fontweight
if astr_Columns.is_If_FontColor <> "" then ls_If_FontColor = "~~t" + astr_Columns.is_If_FontColor
if astr_Columns.is_If_FontUnderline <> "" then ls_If_FontUnderline = "~~t" + astr_Columns.is_If_FontUnderline
if astr_Columns.is_If_FontItalic <> "" then ls_If_FontItalic = "~~t" + astr_Columns.is_If_FontItalic
if astr_Columns.is_If_BackgroundColor <> "" then ls_If_BackgroundColor = "~~t" + astr_Columns.is_If_BackgroundColor

// n$$HEX1$$e400$$ENDHEX$$chste id f$$HEX1$$fc00$$ENDHEX$$r die column bestimmen: VOR dem ersten create/modify!!
ll_NewId = this.of_get_next_column_id(ads_2Modify)

// ----------------------------------------------------
// DW Syntax holen
// ----------------------------------------------------
// DW Syntax holen und die "einsprung"-position bestimmen
ls_DWSyntax = ads_2Modify.describe("datawindow.syntax")
li_InsertPos = Pos(ls_DWSyntax, "text(name=jumppoint")

if li_InsertPos > 0 then
	ls_DWSyntax = Mid(ls_DWSyntax, 1, li_InsertPos - 4) + "column=(type=char(" + ls_NewLength + ") updatewhereclause=no name=" + as_ObjectName + " dbname='" + as_ObjectName + "')~r~n" + Mid(ls_DWSyntax, li_InsertPos - 3)
	ll_Ret = ads_2Modify.create(ls_DWSyntax)

	if this.ib_Trace then this.of_log("Trace create column: ID=" + string(ll_NewId) + ", columnname=" + as_ObjectName)
	if ll_Ret <> 1 then
		of_log("Error -4, create column: " + string(ll_Ret))
		of_log("Error -4, create syntax: " + ls_DWSyntax)
		return -4
	end if

else
	return 0
end  if

// --------------------------------------------------------
// DW Syntax - neue Column eintragen im DW-Syntax-"Detail"
// --------------------------------------------------------
ls_SyntaxCreate = "create column(band=detail id=" + string(ll_NewId) + " alignment='" + string(astr_Columns.il_TextAlign) + &
						"' tabsequence=0 border='" + string(astr_Columns.il_BorderStyle) + ls_If_BorderStyle + &
						"' color='" + string(astr_Columns.il_FontColor) + ls_If_FontColor + &
						"' x='" + string(astr_Columns.il_PosX, "0") + "' y='" + string(astr_Columns.il_PosY, "0") + &
						"' height='" + string(astr_Columns.il_Height, "0") + "' width='" + string(astr_Columns.il_Width, "0") + &
						"' format='[General]'  name=" + as_ObjectName + &
						" resizeable=" + string(astr_Columns.il_Resize) + "  moveable=" + string(astr_Columns.il_Move) + &
						" edit.limit=0 edit.case=any " + ls_Autosize + " edit.autoselect=yes edit.autohscroll=yes  font.face='" + astr_Columns.is_Fontname + &
						"' font.height='" + string(astr_Columns.il_FontSize) + ls_If_Fontsize + &
						"' font.weight='" +string(astr_Columns.il_FontWeight) + ls_If_Fontweight + &
						"' font.italic='" + string(astr_Columns.il_FontItalic) + ls_If_FontItalic + &
						"' font.underline='" + string(astr_Columns.il_FontUnderline) + ls_If_FontUnderline + &
						"' font.family='" + astr_Columns.is_FontFamily + "' font.pitch='" + astr_Columns.is_FontPitch + "' font.charset='0' background.mode='" + string(astr_Columns.il_BackgroundMode) + &
						"' background.color='" + string(astr_Columns.il_BackgroundColor) + ls_If_BackgroundColor +"' )"
		
ls_Ret = ads_2Modify.modify(ls_SyntaxCreate)

if ls_Ret <> "" then
	of_log("Error -4, create column: " + ls_Ret)
	of_log("Error -4, create syntax: " + ls_SyntaxCreate)
	return -4
end if

return 0

end function

protected function long of_check_conditions (ref uo_str_draw_columns astr_columns[], long al_row);
/*
* Function:	of_check_conditions
*
* Argument(e):
* ref	astr_columns[] 		die struktur, die es zu f$$HEX1$$fc00$$ENDHEX$$llen gilt
* 		al_Row 					die daten-zeile, die es zu f$$HEX1$$fc00$$ENDHEX$$llen gilt (f$$HEX1$$fc00$$ENDHEX$$r den column-namen wichtig) 
*
*
* Beschreibung:		breite und x-position der columns berechnen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		03.07.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/


// hilfsvariable
Long 	ll_RowProperty, ll_RowColumn
Long 	ll_Pos, ll_Len


// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro feld (pr$$HEX1$$fc00$$ENDHEX$$fe die eigenschaften)
for ll_RowProperty = 1 to upperbound(astr_Columns) step 1

// --------------------------------------------------
// borderstyle
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_BorderStyle <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_BorderStyle, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_BorderStyle = Replace(astr_Columns[ll_RowProperty].is_If_BorderStyle, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// fontsize
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_Fontsize <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_Fontsize, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_Fontsize = Replace(astr_Columns[ll_RowProperty].is_If_Fontsize, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// fontweight
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_Fontweight <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_Fontweight, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_Fontweight = Replace(astr_Columns[ll_RowProperty].is_If_Fontweight, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// fontcolor
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_FontColor <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_FontColor, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_FontColor = Replace(astr_Columns[ll_RowProperty].is_If_FontColor, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// fontunderline
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_FontUnderline <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_FontUnderline, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_FontUnderline = Replace(astr_Columns[ll_RowProperty].is_If_FontUnderline, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// fontitalic
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_FontItalic <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_FontItalic, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_FontItalic = Replace(astr_Columns[ll_RowProperty].is_If_FontItalic, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

// --------------------------------------------------
// backgroundcolor
// --------------------------------------------------
	if astr_Columns[ll_RowProperty].is_If_BackgroundColor <> "" then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber die struktur pro columnname
		for ll_RowColumn = 1 to upperbound(astr_Columns) step 1
			// pr$$HEX1$$fc00$$ENDHEX$$fe, ob die column in der eigenschaft drin ist
			ll_Pos =  Pos(astr_Columns[ll_RowProperty].is_If_BackgroundColor, "<<" + astr_Columns[ll_RowColumn].is_Objectname +">>")
			if ll_Pos > 0 then
				ll_Len = len(astr_Columns[ll_RowColumn].is_Objectname) + 4
				astr_Columns[ll_RowProperty].is_If_BackgroundColor = Replace(astr_Columns[ll_RowProperty].is_If_BackgroundColor, ll_Pos, ll_Len, astr_Columns[ll_RowColumn].is_Objectname + "_" + string(al_Row))
			end if
		next
	end if

next

return 0


end function

public function long of_draw_block (datastore ads_2modify, uo_str_draw_columns astr_columns[], long al_posx, long al_posy, long al_width, long al_height, long al_offset, long al_textheight, long al_textrows, long al_labeldetailkey, datastore ads_objects);
/*
* Function:	of_draw_block
*
* Argument(e):
* 		aDS_2Modify 		das zu erweiternde DS
* 		astr_columns[] 	die spezifika der columns
* 		al_PosX 				die X-Start-Position des Blocks
* 		al_PosY 				die Y-Start-Position des Blocks
* 		al_Width 			die Breite des Blocks
* 		al_Height 			die H$$HEX1$$f600$$ENDHEX$$he des Blocks
* 		al_Offset 			der Abstand zwischen den Spalten
* 		al_TextHeight 		die H$$HEX1$$f600$$ENDHEX$$he einer Textzeile
* 		al_TextRows 		die Anzahl Textzeilen (-1, wenn hier berechnet werden soll)
* 		al_LabelDetailKey 	-1, wenn objects nicht gepflegt werden sollen
* 		aDS_Objects 		datastore, wo die objects ggf. reingestellt werden sollen
*
*
* Beschreibung:		zeichne den kompletten Block
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		12.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/


// hilfsvariable
Long 	ll_Ret = 0
Long 	ll_Row, ll_PosY, ll_TextRows

// hilfsvariable linien
Long ll_LinePosX1[], ll_LinePosX2[], ll_LinePosY1[], ll_LinePosY2[], ll_Width[], ll_Color[]

// --------------------------------------------------
// initialisieren
// --------------------------------------------------
ll_PosY = al_PosY

// bestimme die zeilenanzahl
if al_TextRows < 1 then
	ll_TextRows = truncate(al_Height / (al_TextHeight + 1), 0)
else
	ll_TextRows = al_TextRows
end if

if this.ib_Trace then
	of_log("Proto: ")
	of_log("Formate: Gesamth$$HEX1$$f600$$ENDHEX$$he " + string(al_Height) + ", Zeilenh$$HEX1$$f600$$ENDHEX$$he " + string(al_TextHeight) + ", Anzahl Zeilen " + string(ll_TextRows))
	of_log("Proto: ")
end if


// --------------------------------------------------
// horizontale positionen der columns bestimmen
// --------------------------------------------------
ll_Ret = this.of_decide_columns_horizontal (astr_Columns, al_PosX, al_Width, al_Offset)

// --------------------------------------------------
// wenn linien gewollt: erstmal in die arrays eintragen
// --------------------------------------------------
// vertikale linien
if this.ib_GridVertical then
	// rand links
	ll_LinePosX1[1] = al_PosX
	ll_LinePosX2[1] = ll_LinePosX1[1]
	ll_LinePosY1[1] = al_PosY
	ll_LinePosY2[1] = al_PosY + al_Height
	ll_Width[1] = this.il_GridVerticalWidth
	ll_Color[1] = this.il_GridVerticalColor
	// die trennlinien
	for ll_Row = 2 to Upperbound(astr_Columns) step 1
		ll_LinePosX1[ll_Row] = astr_Columns[ll_Row].il_PosX - truncate(al_Offset/2, 0)
		ll_LinePosX2[ll_Row] = ll_LinePosX1[ll_Row]
		ll_LinePosY1[ll_Row] = al_PosY
		ll_LinePosY2[ll_Row] = al_PosY + al_Height
		ll_Width[ll_Row] = this.il_GridVerticalWidth
		ll_Color[ll_Row] = this.il_GridVerticalColor
	next
	// rand rechts
	ll_Row = Upperbound(astr_Columns) + 1
	ll_LinePosX1[ll_Row] = al_PosX + al_Width
	ll_LinePosX2[ll_Row] = ll_LinePosX1[ll_Row]
	ll_LinePosY1[ll_Row] = al_PosY
	ll_LinePosY2[ll_Row] = al_PosY + al_Height
	ll_Width[ll_Row] = this.il_GridVerticalWidth
	ll_Color[ll_Row] = this.il_GridVerticalColor
end if
// horizontale linien
if this.ib_GridHorizontal then
	// oben
	ll_LinePosX1[Upperbound(ll_LinePosX1) + 1] = al_PosX
	ll_LinePosX2[Upperbound(ll_LinePosX1)] = al_PosX + al_Width
	ll_LinePosY1[Upperbound(ll_LinePosX1)] = ll_PosY
	ll_LinePosY2[Upperbound(ll_LinePosX1)] = ll_PosY
	ll_Width[Upperbound(ll_LinePosX1)] = this.il_GridHorizontalWidth
	ll_Color[Upperbound(ll_LinePosX1)] = this.il_GridHorizontalColor
	// pro zeile
	for ll_Row = 1 to ll_TextRows step 1
		// erh$$HEX1$$f600$$ENDHEX$$he y-koordinate
		ll_PosY += al_TextHeight
		ll_LinePosX1[Upperbound(ll_LinePosX1) + 1] = al_PosX
		ll_LinePosX2[Upperbound(ll_LinePosX1)] = al_PosX + al_Width
		ll_LinePosY1[Upperbound(ll_LinePosX1)] = ll_PosY
		ll_LinePosY2[Upperbound(ll_LinePosX1)] = ll_PosY
		ll_Width[Upperbound(ll_LinePosX1)] = this.il_GridHorizontalWidth
		ll_Color[Upperbound(ll_LinePosX1)] = this.il_GridHorizontalColor
		ll_PosY += 1
	next
	// unten nachjustieren
	ll_LinePosY1[Upperbound(ll_LinePosX1)] = al_PosY + al_Height
	ll_LinePosY2[Upperbound(ll_LinePosX1)] = al_PosY + al_Height
end if

// ----------------------------------------
// jetzt erstelle die linien, falls welche gewollt
// ----------------------------------------
for ll_Row = 1 to UpperBound(ll_LinePosX1) step 1
	ll_Ret = this.of_draw_line(ads_2Modify, ll_LinePosX1[ll_Row], ll_LinePosY1[ll_Row], ll_LinePosX2[ll_Row], ll_LinePosY2[ll_Row], ll_Width[ll_Row], ll_Color[ll_Row])
next

// ----------------------------------------
// schleife $$HEX1$$fc00$$ENDHEX$$ber die anzahl der zeilen
// erstellen der columns
// ----------------------------------------
// neu initialisieren
ll_PosY = al_PosY
	
of_log("            - draw block creating " + string(ll_TextRows) + " rows with " +  string(UpperBound(astr_columns)) + " columns" )
	
for ll_Row = 1 to ll_TextRows step 1
	// erstelle zeile (mit oder ohne eintrag ins Object-DS)
	if al_LabelDetailKey <> -1 and IsValid(aDS_Objects) then
		ll_Ret = this.of_draw_row(ads_2Modify, astr_columns, ll_Row, ll_PosY, al_LabelDetailKey, aDS_Objects)
	else
		ll_Ret = this.of_draw_row(ads_2Modify, astr_columns, ll_Row, ll_PosY)
	end if
	// fehler
	if ll_Ret <> 0 then exit
	// erh$$HEX1$$f600$$ENDHEX$$he y-koordinate
	ll_PosY += al_TextHeight + 1
next

if this.ib_Trace then
	of_log("Proto: ")
	of_log("Syntax:" + ads_2Modify.describe("datawindow.syntax"))
	of_log("Proto: ")
end if

return ll_Ret

end function

on uo_draw_objects.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_draw_objects.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

// --------------------------------------------------
// trace-schalter
// --------------------------------------------------
if handle(getapplication()) = 0 then
	this.ib_Trace = true
else
	this.ib_Trace = false
end if

return 0

end event

