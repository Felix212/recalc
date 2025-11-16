HA$PBExportHeader$uo_documents.sru
$PBExportComments$Userobjekt zum Speichern der erstellten Produktinformationen
forward
global type uo_documents from nonvisualobject
end type
end forward

global type uo_documents from nonvisualobject
end type
global uo_documents uo_documents

type variables
String 				sAirline
Long   				lFlightNumber
String			 	sSuffix
String			 	sDepartureStation, sArrivalStation
Date				 	dDepartureDate
String				sDepartureTime
String				sPrinter
String				sLoadingSequence[]

// -----------------------------------
// GalleyDiagramm
// -----------------------------------
Integer	iGalley
String 	sGalleyFile
Long		lGalleyStatus
String	sGalleyMessage
String 	sGalleyFiles[]
String 	sGalleyDescription[]

// -----------------------------------
// Dokumente
// -----------------------------------
Integer	iDocument
String 	sDocumentFile
String 	sDocumentFiles[]
String 	sDocumentDescription[]
Long	 	lDocumentStatus
String 	sDocumentMessage

// -----------------------------------
// FlightInfo
// -----------------------------------
Integer	iFlightInfo
String 	sFlightInfoFile

// -----------------------------------
// Lesematerial
// -----------------------------------
Integer	iNewspaper
String 	sNewspaperFile

// -----------------------------------
// Labels
// -----------------------------------
Integer	iLabel
Integer	iLocationSheet
String	sLocationSheetFile
Integer	iDistributionError
String	sDistributionErrorFile
uo_distribution	uoDistribution
String 	sLabelFiles[]
String 	sLabelTypes[]
String 	sLabelDescription[]
String 	sGeneratedForPrinter[]
Long	 	lLabelStatus
Boolean	bLocationSheet
String 	sLabelMessage
Boolean	bBelly
Integer	iLabelSort
Integer	iLabelPageBreak

// -----------------------------------
// CheckSheet
// -----------------------------------
Integer 	iCheckSheet
String	sCheckSheetFile
// -----------------------------------
// CheckSheet
// -----------------------------------
Integer	iSPMLSummary
String	sSPMLSummaryFile


// 19.08.2009 Ulrich Paudler [UP]
// -----------------------------------
// CartdiagramSheet
// -----------------------------------
Integer 	iCartdiagramSheet
String	sCartdiagramSheetFile


// 17.02.2010 Ulrich Paudler [UP]
// -----------------------------------
// DeliveryNoteSheet
// -----------------------------------
Integer 	iDeliveryNoteSheet
String		sDeliveryNoteSheetFile

// 06.07.2010 Matthias Barfknecht
// -----------------------------------
// RampboxSheet
// -----------------------------------
Integer 		iRampboxSheet
String		sRampboxSheetFile


// 20.07.2010 
// -----------------------------------
// TR Cart Diagramm & Trip Ticket
// -----------------------------------
Integer		iTRCartDiagram
String		sTRCartDiagramFile
Integer		iTripTicket
String		sTripTicketFile

// Content Sheet
Integer		iContentSheet
String		sContentSheet

// -----------------------------------
// Container & Equipment
// 07.05.2012 M. N$$HEX1$$fc00$$ENDHEX$$ndel
// -----------------------------------
Integer 	iContainerEquipment
String	sContainerEquipmentFile

// -----------------------------------
// Kundenreport
// 11.05.2012 D. Bunk
// -----------------------------------
Integer 	iCustomerReport
String	sCustomerReportFile

end variables

on uo_documents.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_documents.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isvalid(uo_distribution) then Destroy(uo_distribution)
end event

