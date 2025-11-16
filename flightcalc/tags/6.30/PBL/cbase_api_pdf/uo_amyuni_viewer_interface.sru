HA$PBExportHeader$uo_amyuni_viewer_interface.sru
$PBExportComments$Interface Objekt f$$HEX1$$fc00$$ENDHEX$$r die verschiedenen Amyuni PDF Viewer
forward
global type uo_amyuni_viewer_interface from userobject
end type
end forward

global type uo_amyuni_viewer_interface from userobject
integer width = 1623
integer height = 912
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_refresh ( )
end type
global uo_amyuni_viewer_interface uo_amyuni_viewer_interface

type variables
PUBLIC:
constant integer PRINT_RANGE_INCLUDE_ALL  = 0
constant integer PRINT_RANGE_INCLUDE_EVEN = 1
constant integer PRINT_RANGE_INCLUDE_ODD  = 2

constant integer SEARCH_OPTION_START           = -1 // Case sensitive search from the beginning of the document.
constant integer SEARCH_OPTION_CURRENT         =  0 // Case sensitive search from current position.
constant integer SEARCH_OPTION_START_NO_CASE   =  1 // Search from the beginning of the document, case-insensitive.
constant integer SEARCH_OPTION_CURRENT_NO_CASE =  2 // Search from the current position, case-insensitive.

PROTECTED:
// Konstanten f$$HEX1$$fc00$$ENDHEX$$r PDF Control Kommandos
// http://www.amyuni.com/WebHelp/Amyuni_PDF_Creator_for_NET/PDF_Creator_NET_Control/User_Interface_Commands/List_of_Commands_Provided_by_the_PDF_Control.htm
constant decimal COMMAND_PAGE_PREV  = 53771
constant decimal COMMAND_PAGE_NEXT  = 53772
constant decimal COMMAND_PAGE_FIRST = 53773
constant decimal COMMAND_PAGE_LAST  = 53774

// Hilfsarray
integer ii_Empty[]

// Array von Seitenzahlen, die gedruckt werden sollen, falls nicht alle Seiten gedruckt werden sollen
integer ii_PrintPages[]

// Gibt an, welche Seitenzahlen zum Drucken relevant sind (alle Seiten / gerade Seiten / ungerade Seiten)
integer ii_PrintRangeInclude = PRINT_RANGE_INCLUDE_ALL

// Das zuletzt ge$$HEX1$$f600$$ENDHEX$$ffnete Dokument
string is_LastFileName = ""

PRIVATE:
// Referenz auf das Elternobjekt
userobject iuo_parent
end variables

forward prototypes
public function integer of_open (string as_file)
public subroutine of_zoom (integer li_zoom)
public subroutine of_print (string as_printer)
public function integer of_get_page_count ()
public subroutine of_show_page (integer ai_page)
public function integer of_get_current_page ()
public subroutine of_show_first_page ()
public subroutine of_show_prev_page ()
public subroutine of_show_next_page ()
public subroutine of_show_last_page ()
public subroutine of_print (string as_printer, integer ai_printrangeinclude)
public subroutine of_print (string as_printer, integer ai_printrangeinclude, integer ai_printpages[])
public subroutine of_set_parent (userobject auo_parent)
public function integer of_zoom_to_fit ()
public function boolean of_search (integer ai_searchoption, string as_searchstring)
public subroutine of_refresh ()
public function string of_get_title ()
end prototypes

event ue_refresh();// Ruft das ue_refresh Event des Eltern-Objekts auf (falls vorhanden). 
// Dieses muss vorher mit of_set_parent gesetzt worden sein.
if IsValid(iuo_parent) then iuo_parent.PostEvent("ue_refresh")
end event

public function integer of_open (string as_file);// MUSS IMPLEMENTIERT WERDEN
return 0
end function

public subroutine of_zoom (integer li_zoom);// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_print (string as_printer);of_print(as_Printer, PRINT_RANGE_INCLUDE_ALL)
end subroutine

public function integer of_get_page_count ();// MUSS IMPLEMENTIERT WERDEN
return 0
end function

public subroutine of_show_page (integer ai_page);// MUSS IMPLEMENTIERT WERDEN
end subroutine

public function integer of_get_current_page ();// MUSS IMPLEMENTIERT WERDEN
return 0
end function

public subroutine of_show_first_page ();// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_show_prev_page ();// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_show_next_page ();// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_show_last_page ();// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_print (string as_printer, integer ai_printrangeinclude);// Sicherheitshalber das Array mit den Seitenzahlen, die gedruckt werden sollen, leeren
ii_PrintPages = ii_Empty
of_print(as_Printer, ai_PrintRangeInclude, ii_PrintPages)
end subroutine

public subroutine of_print (string as_printer, integer ai_printrangeinclude, integer ai_printpages[]);// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_set_parent (userobject auo_parent);/* 
* Funktion: of_set_parent
* Beschreibung: Setzt das Eltern-Objekt, auf dem dieses Viewer Objekt liegt, 
*               damit dort z.B. ein "ue_refresh" Event aufgerufen werden kann.
* Besonderheit: keine
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      13.08.2013    Erstellung
*
* Return Codes:
*   None
*/

iuo_parent = auo_parent
end subroutine

public function integer of_zoom_to_fit ();// MUSS IMPLEMENTIERT WERDEN
return 100
end function

public function boolean of_search (integer ai_searchoption, string as_searchstring);// MUSS IMPLEMENTIERT WERDEN
return false
end function

public subroutine of_refresh ();// MUSS IMPLEMENTIERT WERDEN
end subroutine

public function string of_get_title ();
// Implementierung im Descendant

return ""
end function

on uo_amyuni_viewer_interface.create
end on

on uo_amyuni_viewer_interface.destroy
end on

event constructor;// MUSS IMPLEMENTIERT WERDEN
end event

