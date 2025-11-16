HA$PBExportHeader$uo_graphicobject.sru
$PBExportComments$Basisklasse f$$HEX1$$fc00$$ENDHEX$$r alle Design-Objekte rund um Galley Diagramm Design
forward
global type uo_graphicobject from nonvisualobject
end type
end forward

global type uo_graphicobject from nonvisualobject
end type
global uo_graphicobject uo_graphicobject

type variables
Public:
// ---------------------------------------
// Der Proxy
// ---------------------------------------
Long						lXPosInPixel, &
							lYPosInPixel, &
							lHeightInPixel, &
							lWidthInPixel
							
Integer					iLeftMargin			


Long						lLineColor
Long						lTextColor

String					sFontName
Integer					iFontSize
Integer					iLineWidth

// ------------------------------
// der Stauort wird auf Seite 
// iPage gedruckt
// ------------------------------
Integer					iPage
DataWindow				dwReport
DataStore				dsReport
// ------------------------------
// L$$HEX1$$f600$$ENDHEX$$schkennzeichen
// ------------------------------
Long 		lIndex
String	sObjectName

// ------------------------------
// Ein paar User-Settings
// ------------------------------
String	sDateFormat
String	sMandant


Protected:			
// Objekt zur Berechnung von Schriftarten
uo_font_calc iuo_FontCalc

Private:

end variables

forward prototypes
public function long uf_drawreport ()
end prototypes

public function long uf_drawreport ();
return 1
end function

on uo_graphicobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_graphicobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Objekt zur Berechnung von Schriftarten erzeugen
iuo_FontCalc = CREATE uo_font_calc
end event

event destructor;// Objekt zur Berechnung von Schriftarten zerst$$HEX1$$f600$$ENDHEX$$ren
DESTROY iuo_FontCalc
end event

