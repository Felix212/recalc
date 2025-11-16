HA$PBExportHeader$w_response_resizable.srw
$PBExportComments$Master f$$HEX1$$fc00$$ENDHEX$$r resizable response-fenster
forward
global type w_response_resizable from window
end type
type st_warning_2 from statictext within w_response_resizable
end type
type st_warning_1 from statictext within w_response_resizable
end type
type uo_statusbar from uo_comctl_statusbar within w_response_resizable
end type
end forward

global type w_response_resizable from window
integer width = 3931
integer height = 2176
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_post_open ( )
event type long ue_open_resize ( )
st_warning_2 st_warning_2
st_warning_1 st_warning_1
uo_statusbar uo_statusbar
end type
global w_response_resizable w_response_resizable

type prototypes
Private function long GetWindowLongW (long hWindow, integer nIndex) Library "user32.dll"
Private function long SetWindowLongW (long hWindow, integer nIndex, long dwNewLong) library "user32.dll"
Private function ulong GetSystemMenu(ulong hWnd, boolean bRevert) library "user32.dll"
Private function boolean DrawMenuBar(ulong hWnd) library "user32.dll"
Private function boolean InsertMenuW(uLong hMenu, uint uPosition, uint uFlags, uint uIDNewItem, String lpNewItem) library "user32.dll"
Private function boolean SetWindowPos(long hWnd, long hWndInsertAfter, int newX, int newY, int newWidth, int newHeight, long uFlags) library "user32.dll"
Private function Long GetSystemMetrics(Long nIndex) library "User32.dll"

end prototypes

type variables

protected:

// die section f$$HEX1$$fc00$$ENDHEX$$r profiles
String 	is_Section = ""

// ------------------------------------------------------------------
// resize
// ------------------------------------------------------------------
// mindestgr$$HEX1$$f600$$ENDHEX$$sse
Long 	il_MinHeight = 1020
Long 	il_MinWidth = 4297

uo_resize	uoResize

end variables

forward prototypes
public function long wf_customize_statusbar (boolean ab_init)
protected function boolean wf_set_user_settings ()
protected function long wf_restore_window_pos (boolean ab_resize)
protected function long wf_setresizable ()
end prototypes

event ue_post_open();
/* 
* Event: 				window.ue_post_open
* Beschreibung: 	alles, was so zu beginn nach dem open noch passieren soll
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer							Wann				Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel				08.08.2014		Erstellung
*
* Return Codes:
* keiner (PB)
*/


// hilfsvariable
Long 		ll_Ret

// -------------------------------
// fenstergroesse wiederherstellen
// -------------------------------
ll_Ret = wf_restore_window_pos(true)

// -------------------------------
// resize-funktionalit$$HEX1$$e400$$ENDHEX$$t anschalten
// -------------------------------
if (f_mandant_profilestring(sqlca, s_app.sMandant, "response", "resizable", "1") = "1") then
	ll_Ret = wf_SetResizable()
end if

end event

event type long ue_open_resize();
/* 
* Event: 				ue_open_resize
* Beschreibung: 	resize initialisieren
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer									Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel 					28.03.2013	Erstellung
*
* Return Codes:
*
*/

// hilfsvariable
Long 	ll_Ret


// =========================================================
// Resize-Funktionalit$$HEX1$$e400$$ENDHEX$$t
// format: obj, hoehe, breite, x, y, midx, midy
// zum aktivieren: close und resize event auch !!
// =========================================================

uoResize = create uo_resize
uoResize.of_set_minwidth(this.il_MinWidth)
uoResize.of_set_minheight(this.il_MinHeight)

// tab h$$HEX1$$f600$$ENDHEX$$he/breite
//uoResize.of_set_resize(tab_1, true, true)

// DW h$$HEX1$$f600$$ENDHEX$$he/breite
//uoResize.of_set_resize(dw_1, true, true)

// buttons + shadows horizontal
//uoResize.of_set_resize(pb_retrieve, false, false, true, false)
//uoResize.of_set_resize(st_shadow_retrieve, false, false, true, false)  // zu pb_retrieve

//uoResize.of_set_resize(pb_exit, false, false, true, true)
//uoResize.of_set_resize(st_shadow_exit, false, false, true, true)  // zu pb_exit

return 0

end event

public function long wf_customize_statusbar (boolean ab_init);
/* 
* Funktion:			wf_customize_statusbar
* Beschreibung: 	teilt die statusbar in die gew$$HEX1$$fc00$$ENDHEX$$nschten teile auf
* Besonderheit: 	sowohl f$$HEX1$$fc00$$ENDHEX$$r die erst-initialisierung als auch f$$HEX1$$fc00$$ENDHEX$$r resize
*
* Argumente:
* 	ab_Init 			Schalter, ob initialisiert werden soll oder "nur" resized
*
* Aenderungshistorie:
* 	Version 	Wer									Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel 					08.08.2014	Erstellung
*
* Return Codes:
*	 0		immer
*
*/

// hilfsvariable
Long 		ll_Check, ll_Parts[], ll_MaxCount
String 	ls_PartText[]
// Mindestbreite statusbar rechts f$$HEX1$$fc00$$ENDHEX$$rs datum
Long 		ll_MinWidthDate	= 110 

// welche aufteilung ist schon da ?
ll_MaxCount = uo_StatusBar.of_getparts(ll_Parts)

// ------------------------------------------------------------------
// was soll rein ?
// ------------------------------------------------------------------
if ab_Init then
	// initialisieren
	ls_PartText[1] = "Ready"
	ls_PartText[2] = "Row:"
	ls_PartText[3] = String(Today(),s_app.sDateformat)
else
	// nur resize: vorhandene daten holen
	if ll_MaxCount > 0 then uo_StatusBar.of_GetText( 0, ls_PartText[1] )
	if ll_MaxCount > 1 then uo_StatusBar.of_GetText( 1, ls_PartText[2] )
	if ll_MaxCount > 2 then uo_StatusBar.of_GetText( 2, ls_PartText[3] )
end if

// falls weniger da war als gewollt: mit den init-werten auff$$HEX1$$fc00$$ENDHEX$$llen
if Upperbound(ll_Parts) < 1 then ls_PartText[1] = "Ready"
if Upperbound(ll_Parts) < 2 then ls_PartText[2] = "Row:"
if Upperbound(ll_Parts) < 3 then ls_PartText[3] = String(Today(),s_app.sDateformat)

// ------------------------------------------------------------------
// aufteilung:
//
// Teil 1 (links) 		= 50 % (Status)
// Teil 2 (mitte) 	= 20 % (Rows)
// Teil 3 (rechts) 	der Rest (Datum)
// 
// es wird immer die rechte position $$HEX1$$fc00$$ENDHEX$$bergeben!!
// ------------------------------------------------------------------
ll_Check = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 30
if ll_Check < ll_MinWidthDate then
	ll_Parts[1] = (UnitsToPixels(this.width, YUnitsToPixels!) - ll_MinWidthDate) / 100 * 70
	ll_Parts[2] = ll_Parts[1] + (UnitsToPixels(this.width, YUnitsToPixels!) - ll_MinWidthDate) / 100 * 28
else
	ll_Parts[1] = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 50
	ll_Parts[2] = ll_Parts[1] + UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 20
end if
ll_Parts[3] = -1
// Pass array of widths/parts to statusbar
uo_StatusBar.of_SetParts( ll_Parts[] )
// Set Text for each part. NOTE: This is a ZERO based index
uo_StatusBar.of_SetText( 0, 0, ls_PartText[1] )
uo_StatusBar.of_SetText( 1, 0, ls_PartText[2] )
uo_StatusBar.of_SetText( 2, 0, ls_PartText[3])

return 0

end function

protected function boolean wf_set_user_settings ();
/* 
* Funktion: 		wf_set_user_settings
* Beschreibung: 	Letzte User Einstellungen schreiben
* Besonderheit: 	keine
*
* Argumente:
*
*
* Aenderungshistorie:
* 	Version 	Wer								Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel					08.08.2014	Erstellung
*
* Return Codes:
*	 true				Wird immer zur$$HEX1$$fc00$$ENDHEX$$ckgegeben
*/



// ------------------------------------------------------------------------
// fensterposition, -abmessung
// ------------------------------------------------------------------------
f_setprofilestring(this.is_Section, "iWindowX1", String(this.x))
f_setprofilestring(this.is_Section, "iWindowY1", String(this.y))
f_setprofilestring(this.is_Section, "iWidth", String(this.Width))
f_setprofilestring(this.is_Section, "iHeight", String(this.Height))

return true

end function

protected function long wf_restore_window_pos (boolean ab_resize);
/* 
* Funktion:			wf_restore_window_size
* Beschreibung: 	positioniert und resized das fenster auf die zuletzt genutzten werte
*
* Argumente:
* 	ab_resize 		Schalter, ob resize oder positionierung gemacht werden soll
* 						(damit die position schon im open passieren kann, verhindert "springen")
*
* Aenderungshistorie:
* 	Version 	Wer							Wann				Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel				15.05.2014		Erstellung
*
* Return Codes:
* 	0 	immer
*
*/

// hilfsvariable
Long 	ll_Ret
Long 	ll_PosX, ll_PosY, ll_ScreenWidth

// ------------------------------------------------------------------
// Fenster positionieren (nur, wenn nicht maximiert)
// ------------------------------------------------------------------
if not ab_resize then
	if this.WindowState <> Maximized! then
		// -----------------------------------------------------------------
		// Sicherstellen, dass das Fenster nicht au$$HEX1$$df00$$ENDHEX$$erhalb des
		// sichbaren Bereiches positioniert wird 
		// ------------------------------------------------------------------
		ll_PosX = long(f_profilestring(this.is_Section, "iWindowX1", "0"))
		ll_PosY = long(f_profilestring(this.is_Section, "iWindowY1", "0"))
		ll_ScreenWidth = w_mdi_master.width
		if ll_PosX > ll_ScreenWidth then
			f_centerwindow(this)
		else
			this.move(ll_PosX,ll_PosY)
		end if
	end if
end if
// ------------------------------------------------------------------
// Fenstergr$$HEX2$$f600df00$$ENDHEX$$e bestimmen
// ------------------------------------------------------------------
if ab_resize then
	if long(f_profilestring(this.is_Section, "Maximized", "0")) = 1 then
		this.WindowState = Maximized!
	else
		this.width = max(Integer(f_profilestring(this.is_Section,"iWidth", string(this.il_MinWidth))),  this.il_MinWidth)
		this.height = max(Integer(f_profilestring(this.is_Section,"iHeight", string(this.il_MinHeight))),  this.il_MinHeight)
		// erst hier, damit die vergr$$HEX1$$f600$$ENDHEX$$sserung aus entwicklungsgr$$HEX1$$f600$$ENDHEX$$sse sauber klappt
		ll_Ret = uoResize.of_set_minwidth(this.il_MinWidth)
		ll_Ret = uoResize.of_set_minheight(this.il_MinHeight)
	end if
end if

return 0

end function

protected function long wf_setresizable ();
/* 
* Function: 			wf_SetResizable
* Beschreibung:	Per Windows-Api-Calls wird ein Response-Window, das
*						von Powerbuilder aus nicht resizable sein kann, resizable
*						gemacht. 
*						Dies geschieht, indem der Rahmen des Fensters
*						gesetzt wird. (Ob ein Fenster Resizable ist, liegt an der 
*						Art des Fensterrahmens).
*						
*						Diese Funktion sollte im Open-Event eines Response-Windows
*						aufgerufen werden.
* Besonderheit: 	...
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer								Wann			Was und warum
*	1.0 		Thomas Schaefer				07.08.2014	Erstellung
*
* Return Codes:
*	 ...
*/

Long					ll_wsheight		// Workspaceheight
Long					ll_wswidth		// Workspacewidth
Integer				li_wsheightdiff
Integer				li_wswidthdiff
ulong					ll_style
ulong					ll_newstyle
ulong					hMenu
ulong					hWnd

constant int			GWL_STYLE = -16
constant uint		SWP_NOSIZE = 1
constant uint		SWP_NOMOVE = 2
constant uint		SWP_NOZORDER  = 4
constant uint		SWP_FRAMECHANGED = 32

constant ulong		WS_THICKFRAME = 262144
//constant ulong		WS_CAPTION = 12582912
//constant ulong		WS_SYSMENU = 524288	
//constant ulong		WS_MINIMIZEBOX = 65536
//constant ulong		WS_MAXIMIZEBOX = 131072

//constant uint		MF_BYCOMMAND = 0
constant uint		MF_STRING = 0
constant uint		MF_BYPOSITION = 1024

//constant uint		SC_RESTORE = 61728
//constant uint		SC_MAXIMIZE = 61488
//constant uint		SC_MINIMIZE = 61472
constant uint		SC_SIZE = 61440

IF THIS.WindowType <> Response! THEN RETURN 0

// Urspruengliche Workspacegroesse merken, da sie sich durch die folgende Aktion geaendert wird
ll_wsheight = THIS.workspaceheight()
ll_wswidth = THIS.workspacewidth()

hWnd = Handle(this)

// Get the current window style
ll_style = GetWindowLongW(hWnd, GWL_STYLE)
ll_newstyle = ll_style + WS_THICKFRAME

IF ll_style <> 0 THEN
	IF SetWindowLongW(hWnd, GWL_STYLE, ll_newstyle) <> 0 THEN
		IF THIS.ControlMenu THEN
			// Get a handle to the system menu
			hMenu = GetSystemMenu(hWnd, FALSE)
			IF hMenu > 0 THEN
				//InsertMenuW(hMenu, 1, MF_BYPOSITION + MF_STRING, SC_MAXIMIZE, "Maximize")
				//InsertMenuW(hMenu, 1, MF_BYPOSITION + MF_STRING, SC_RESTORE, "Restore")
				// The Size menu option has to be added to allow the resize gripper to work if there is a control menu
				InsertMenuW(hMenu, 1, MF_BYPOSITION + MF_STRING, SC_SIZE, "Size")
				DrawMenuBar(hWnd)
			END IF
		END IF
		// Force a repaint
		SetWindowPos(hWnd, 0, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_FRAMECHANGED)
		THIS.SetRedraw(TRUE)
	END IF
END IF

// Urspruengliche Workspacegroesse wieder herstellen
li_wsheightdiff = ll_wsheight - THIS.workspaceheight()
li_wswidthdiff = ll_wswidth - THIS.workspacewidth()
THIS.Height += li_wsheightdiff
THIS.Width += li_wswidthdiff

RETURN 1

end function

on w_response_resizable.create
this.st_warning_2=create st_warning_2
this.st_warning_1=create st_warning_1
this.uo_statusbar=create uo_statusbar
this.Control[]={this.st_warning_2,&
this.st_warning_1,&
this.uo_statusbar}
end on

on w_response_resizable.destroy
destroy(this.st_warning_2)
destroy(this.st_warning_1)
destroy(this.uo_statusbar)
end on

event open;
/* 
* Event: 				open 
* Beschreibung: 	alles, was so zu beginn anf$$HEX1$$e400$$ENDHEX$$llt
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* Version 	Wer						Wann			Was und warum
* 1.0			Margret N$$HEX1$$fc00$$ENDHEX$$ndel			08.08.2014 	Erstellung
*
* Return Codes:
*
*/



// hilfsvariable
Long 		ll_Ret
String 	ls_ErrorModify


// =========================================================
// $$HEX1$$fc00$$ENDHEX$$bergabe-parameter $$HEX1$$fc00$$ENDHEX$$bernehmen
// =========================================================
//this.str_Params = Message.PowerObjectParm

// =========================================================
// Statusbar
// =========================================================
ll_Ret = wf_customize_statusbar(true)

// =========================================================
// Datawindows vorbereiten (inklusive DDDW & Hilfs-Datawindows/-stores)
// =========================================================
//ll_Ret = this.Event ue_open_init_DWs()

// =========================================================
// Translate
// =========================================================
//ll_Ret = this.Event ue_open_translate()

// -------------------------------
// fensterposition wiederherstellen
// -------------------------------
ll_Ret = wf_restore_window_pos(false)

// =========================================================
// Resize-Funktionalit$$HEX1$$e400$$ENDHEX$$t
// format: obj, hoehe, breite, x, y, midx, midy
// zum aktivieren: close und resize event auch !!
// =========================================================
ll_Ret = this.Event ue_open_resize()

// =========================================================
// Posten des Events ue_post_open
// =========================================================
Post Event ue_post_open()

return 0

end event

event close;
/* 
* Event: 				close
* Beschreibung: 	Fenster wird geschlossen: aufr$$HEX1$$e400$$ENDHEX$$umen
*
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* Version 	Wer						Wann			Was und warum
* 1.0			Margret N$$HEX1$$fc00$$ENDHEX$$ndel			08.08.2014 	Erstellung
*
* Return Codes:
*	 0		continue (PB)
*/

// hilfsvariable
Boolean 	lb_Ret


// letzte User Einstellungen schreiben
lb_Ret = wf_set_user_settings()

// resize-objecte aufr$$HEX1$$e400$$ENDHEX$$umen
if isValid(uoResize) then destroy uoResize


return 0

end event

event resize;
/* 
* Event: 				resize
* Beschreibung: 	Fenster wurde in der gr$$HEX1$$f600$$ENDHEX$$sse ver$$HEX1$$e400$$ENDHEX$$ndert
* 						controls, die entsprechend eingetragen sind, werden angepasst
* Besonderheit: 	
*
* Argumente:
*	sizetype		welche art von resize ist passiert (PB)
*	newwidth	neue breite	(in PB Units)
*	newheight	neue h$$HEX1$$f600$$ENDHEX$$he	(in PB Units)	
*
* Aenderungshistorie:
* Version 	Wer						Wann			Was und warum
* 1.0			Margret N$$HEX1$$fc00$$ENDHEX$$ndel			08.08.2014 	Erstellung
*
* Return Codes:
*	 0		continue (PB)
*/

// hilfsvariable
Long 	ll_Ret


// -------------------------------
// userobject macht die arbeit...
// zum aktivieren: open und close event auch !!
// -------------------------------
if isValid(uoResize) then uoResize.of_resizecontrols(this)

// -------------------------------
// Ask statusbar to resize itself
// -------------------------------
uo_StatusBar.Resize(-1, -1)
// die aufteilung der statusbar auch anpassen
ll_Ret = wf_customize_statusbar(false)

//uo_StatusBar.of_SetText( 0, 0, "Breite " + string(this.Width) + " - H$$HEX1$$f600$$ENDHEX$$he " + string(this.Height))

return 0

end event

type st_warning_2 from statictext within w_response_resizable
boolean visible = false
integer x = 471
integer y = 1264
integer width = 2862
integer height = 552
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "post_open nicht $$HEX1$$fc00$$ENDHEX$$berschreiben oder IMMER schalter-abfrage mit einbauen"
boolean focusrectangle = false
end type

type st_warning_1 from statictext within w_response_resizable
boolean visible = false
integer x = 448
integer y = 168
integer width = 2862
integer height = 552
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Nur mit VORSICHT nutzen, nutzt betriebssystem-abh$$HEX1$$e400$$ENDHEX$$ngige calls, muss also f$$HEX1$$fc00$$ENDHEX$$r jede Umgebung wieder neu getestet werden !!"
boolean focusrectangle = false
end type

type uo_statusbar from uo_comctl_statusbar within w_response_resizable
integer x = 791
integer y = 868
integer taborder = 10
end type

