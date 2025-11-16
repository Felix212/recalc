HA$PBExportHeader$uo_loading_stowage.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_stowage from nonvisualobject
end type
end forward

global type uo_loading_stowage from nonvisualobject
end type
global uo_loading_stowage uo_loading_stowage

type variables
// ----------------------------------
// uo_loading_stowage
//
// Stellt eine Galley in einer Beladung dar
//
// Ist eine Aggregation von uo_loading_galley
// ----------------------------------
PUBLIC:

uo_loading_galley		Galley
STRING					sStowage
STRING					sPlace
LONG						lStowageKey

String					sPackingList
LONG						lPackingListKey
STRING					sPLText
STRING					sPLTextShort
STRING					sAddOnText
STRING					sZuStauText

STRING					sUnit


String					sMealCode
Double					dWeight

STRING					sLoadingList
LONG						lLoadingListKey
Long						lLoadingListType

STRING					sForToCode
INTEGER					iForToCode

STRING					sForToDestination			// TLC
LONG						lForToDestination			// TLC-Key

STRING					sClass
STRING					sClassLong

STRING					sQAQActioncode				// Actioncode aus QAQ
STRING					sSICode 
Integer					iLoadedAtLeg				// Leg, f$$HEX1$$fc00$$ENDHEX$$r den dieser Stauort beladen wurde

LONG						lQAQHandlingKey = 0



end variables

on uo_loading_stowage.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_stowage.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

