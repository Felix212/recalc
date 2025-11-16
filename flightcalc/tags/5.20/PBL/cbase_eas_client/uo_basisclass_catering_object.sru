HA$PBExportHeader$uo_basisclass_catering_object.sru
$PBExportComments$Stellt die Basisklasse aller Catering-UserObjekte (in Powerbuilder) dar. Diese Basisklasse stellt die minimale Schnittstelle (uf_beginwork) zur Verf$$HEX1$$fc00$$ENDHEX$$gung, welche alle hiervon vererbten Klassen bereitstellen und unterst$$HEX1$$fc00$$ENDHEX$$tzen m$$HEX1$$fc00$$ENDHEX$$ssen.
forward
global type uo_basisclass_catering_object from nonvisualobject
end type
end forward

global type uo_basisclass_catering_object from nonvisualobject
end type
global uo_basisclass_catering_object uo_basisclass_catering_object

type variables
Private:


Public:
String		sLogoPath
Integer		iFlightNumber
String		sSuffix
String		sAirline
Date			dDepartureDate
Time			tDepartureTime
Long			lCatering_Userobject_Id
String		sDestination
String		sErrorText
String		sOwner
String		sACType
Long			lParentHwnd
boolean 		bPrinting							// soll instanziirtes Objekt mit Galley-Diagramm gedruckt werden
boolean 		bPreviewPrint = False			// soll instanziirtes Objekt aus dem Dialog gedruckt werden, 
														// welcher einzelne Catering-Objekte druckt (w_print_cateringobjects_preview)
Integer		iPreviewCopyCount = 1			// die Anzahl der zu druckenden Exemplare	aus dem Preview-Fenster													
Integer		iPreviewRet = 0					// Fehler-Codes f$$HEX1$$fc00$$ENDHEX$$r Preview-Druck
														// -1 = Kein Dokument in diesem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich
														// -2 = Keine g$$HEX1$$fc00$$ENDHEX$$ltigen Daten 
														// kann noch erweitert werden
														
Integer		iCopyCount = 1
														
														
String		sErrorTextPreview														
Long			lSnr					

boolean		bIsLocal = False					// sollen zentrale oder lokale Catering-Objekte verwurstelt werden?


// ------------------
// f$$HEX1$$fc00$$ENDHEX$$r uf_createpdf
// Von welchem Object
// soll ein PDF erzeugt
// werden
// ------------------
Long	lInheritCateringID

// ------------------
// Funktionen
// 1 = Drucken (default)
// 2 = Object suchen
// ------------------
integer 		iFunction = 1

// ------------------
// ein Verweis auf die
// Instanz, welches 
// dieses Objekt 
// instanziiert
// ------------------
uo_catering_object_steuerung		uoParent

// ------------------
// nachfolgendes
// Stream-Array nimmt 
// die Inhalte auf
// Jedes Array-Element
// ist ein Dok.
// ------------------
BLOB		bStream
STRING	sPDFFileName


// ------------------
// ein paar allgemeine
// Infos
// ------------------
String		sOrga
String		sMandant
String		sWerk
String		sDateFormat

// ------------------
// G$$HEX1$$fc00$$ENDHEX$$ltigkeiten
// ------------------
Date 	dValidFrom
Date 	dValidTo

n_printer			nPrintPDF
TransactionServer its_jag

uo_pdf_handler	uoPDF

String				sWhereAmI = "PB"
end variables

forward prototypes
public function boolean uf_isvalidatdate ()
protected subroutine writelog (string smsg)
public function integer uf_createpdf ()
end prototypes

public function boolean uf_isvalidatdate ();/***************************************************************************
Project		:	CBASE Web
Object		:  uo_basisclass
Function		:	uf_isvalidatdate
Author		:	Stefan Stroh
Description	:	<DESC>
							$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$ft, ob dieses Object zu einem bestimmten
							Datum gedruckt wird. Wird nur f$$HEX1$$fc00$$ENDHEX$$r Web ben$$HEX1$$f600$$ENDHEX$$tigt,
							da wir nicht alle anzeigen wollen.
					</DESC>
Usage			:	<USAGE>$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$ft, ob dieses Object zu einem bestimmten Datum gedruckt wird.</USAGE>
****************************************************************************
Reference	Date			Changed by	Description
# 001			04/11/2001	ST				First Version
***************************************************************************/



return true
end function

protected subroutine writelog (string smsg);


return
end subroutine

public function integer uf_createpdf ();



return 1

end function

on uo_basisclass_catering_object.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_basisclass_catering_object.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;sWhereAmI = "PB"




end event

event destructor;//If isvalid(its_jag) then setnull(its_jag)

end event

