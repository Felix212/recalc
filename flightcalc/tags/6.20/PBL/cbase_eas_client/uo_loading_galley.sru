HA$PBExportHeader$uo_loading_galley.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_galley from nonvisualobject
end type
end forward

global type uo_loading_galley from nonvisualobject
end type
global uo_loading_galley uo_loading_galley

type variables
// ----------------------------------
// uo_loading_galley
//
// Stellt eine Galley in einer Beladung dar
//
// Ist eine Aggregation von uo_loading
// ----------------------------------
PUBLIC:

String						sGalley
Long							lGalleyKey
INTEGER						iBellyContainer
Boolean						bIsGalley = TRUE


uo_loading_stowage		Stowages[]
Long							lStowageCount




end variables

forward prototypes
public function uo_loading_pl uf_getstowagesbypackinglist (string spl)
public function uo_loading_pl uf_getstowagesbypackinglist (long lplkey)
public function uo_loading_stowage uf_insertstowage (string sstowage, string splace)
end prototypes

public function uo_loading_pl uf_getstowagesbypackinglist (string spl);uo_loading_pl	uoLoadingPL

Long				lCnt, lUpper

uoLoadingPL = Create uo_loading_pl
lUpper = 0

For lCnt = 1 To lStowageCount
	
	if Stowages[lCnt].sPackingList = sPL Then
		lUpper = UpperBound(uoLoadingPL.Stowages[]) + 1
		uoLoadingPL.Stowages[lUpper] = Stowages[lCnt]
	end if
Next

uoLoadingPL.lStowageCount = UpperBound(uoLoadingPL.Stowages[])
Return uoLoadingPL
end function

public function uo_loading_pl uf_getstowagesbypackinglist (long lplkey);uo_loading_pl	uoLoadingPL

Long				lCnt, lUpper

uoLoadingPL = Create uo_loading_pl
lUpper = 0

For lCnt = 1 To lStowageCount
	
	if Stowages[lCnt].lPackingListKey = lPLKey Then
		lUpper = UpperBound(uoLoadingPL.Stowages[]) + 1
		uoLoadingPL.Stowages[lUpper] = Stowages[lCnt]
	end if
Next

uoLoadingPL.lStowageCount = UpperBound(uoLoadingPL.Stowages[])
Return uoLoadingPL
end function

public function uo_loading_stowage uf_insertstowage (string sstowage, string splace);Long		lStowageCnt, &
			lStowageIndex

Boolean	bIsNewStowage = TRUE


if UpperBound(Stowages[]) = 0 Then
	bIsNewStowage = TRUE
else
	For lStowageCnt = 1 To UpperBound(Stowages[])
		if Stowages[lStowageCnt].sStowage = sStowage AND &
			Stowages[lStowageCnt].sPlace = sPlace Then			// gibt es eigentlich nicht. Ist immer neu!
			
			bIsNewStowage 	= FALSE
			lStowageIndex 	= lStowageCnt
			EXIT
			
		end if
	Next
end if

if bIsNewStowage Then
	lStowageCount ++
	lStowageIndex 								= lStowageCount
	Stowages[lStowageIndex] 				= CREATE uo_loading_Stowage
	Stowages[lStowageIndex].sstowage 	= sstowage
	Stowages[lStowageIndex].splace 		= splace
	Stowages[lStowageIndex].Galley		= THIS
end if



// ---------------------------
// Das aktuelle Stowage-Objekt
// Retour
// ---------------------------
return Stowages[lStowageIndex]

end function

on uo_loading_galley.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_galley.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

