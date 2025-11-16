HA$PBExportHeader$uo_loading.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading from nonvisualobject
end type
end forward

global type uo_loading from nonvisualobject
end type
global uo_loading uo_loading

type variables
// ----------------------------------
// uo_loading
//
// Stellt eine Beladung f$$HEX1$$fc00$$ENDHEX$$r ein
// Flugereignis dar
//
// ----------------------------------

PUBLIC:

STRING				sAirlineCode
LONG					lAirlineKey

Integer				iFlightNumber
STRING				sSuffix
INTEGER				iLeg


uo_loading_galley	Galley[]
Long					lGalleyCount = 0

String				sLoadingLists[]

PRIVATE:
end variables

forward prototypes
public function uo_loading_galley uf_insertgalley (long lgalleykey, string sgalley, integer ibellycontainer)
public function uo_loading_pl uf_getstowagesbypackinglist (string spl)
public function uo_loading_pl uf_getstowagesbypackinglist (long lplkey)
public function uo_loading_stowage uf_insertstowage (long lgalleykey, string sgalley, integer ibellycontainer, string sstowage, string splace)
public function uo_loading_packinglist uf_getallpackinglists ()
public function uo_loading_loadinglist uf_getallloadinglists ()
public function uo_loading_qaqs uf_getallqaq ()
end prototypes

public function uo_loading_galley uf_insertgalley (long lgalleykey, string sgalley, integer ibellycontainer);Long		lGalleyCnt, &
			lGalleyIndex

Boolean	bIsNewGalley = TRUE

if UpperBound(Galley[]) = 0 Then
	lGalleyCount									= 1
	Galley[lGalleyCount] 						= CREATE uo_loading_galley
	Galley[lGalleyCount].lGalleyKey			= lGalleyKey
	Galley[lGalleyCount].sGalley 				= sGalley
	Galley[lGalleyCount].iBellyContainer	= iBellyContainer
	Galley[lGalleyCount].bIsGalley			= (iBellyContainer = 0)
	lGalleyIndex									= lGalleyCount
else

	For lGalleyCnt = 1 To UpperBound(Galley[])
		if Galley[lGalleyCnt].lGalleyKey = lGalleyKey Then
			bIsNewGalley 	= FALSE
			lGalleyIndex 	= lGalleyCnt
			EXIT
		end if
	Next
	
	if bIsNewGalley Then
		lGalleyCount ++
		Galley[lGalleyCount] 						= CREATE uo_loading_galley
		Galley[lGalleyCount].lGalleyKey			= lGalleyKey
		Galley[lGalleyCount].sGalley 				= sGalley
		Galley[lGalleyCount].iBellyContainer	= iBellyContainer
		Galley[lGalleyCount].bIsGalley			= (iBellyContainer = 0)
		lGalleyIndex									= lGalleyCount
	end if
end if

// ---------------------------
// Das aktuelle Galley-Objekt
// Retour
// ---------------------------
return Galley[lGalleyIndex]

end function

public function uo_loading_pl uf_getstowagesbypackinglist (string spl);uo_loading_pl	uoLoadingPL
uo_loading_pl	uoLoadingPLPartResult

Long				lCnt, lPartCnt, lUpper

uoLoadingPL = Create uo_loading_pl
lUpper = 0

For lCnt = 1 To lgalleycount
	uoLoadingPLPartResult = Galley[lCnt].uf_getstowagesbypackinglist(spl)
	if isValid(uoLoadingPLPartResult) Then
		lUpper = UpperBound(uoLoadingPL.Stowages[])
		For lPartCnt = 1 To UpperBound(uoLoadingPLPartResult.Stowages[])
			uoLoadingPL.Stowages[lUpper + lPartCnt] = uoLoadingPLPartResult.Stowages[lPartCnt]
		Next
	end if
Next

uoLoadingPL.lStowageCount = UpperBound(uoLoadingPL.Stowages[])
Return uoLoadingPL
end function

public function uo_loading_pl uf_getstowagesbypackinglist (long lplkey);uo_loading_pl	uoLoadingPL
uo_loading_pl	uoLoadingPLPartResult

Long				lCnt, lPartCnt, lUpper

uoLoadingPL = Create uo_loading_pl
lUpper = 0

For lCnt = 1 To lgalleycount
	uoLoadingPLPartResult = Galley[lCnt].uf_getstowagesbypackinglist(lplkey)
	if isValid(uoLoadingPLPartResult) Then
		lUpper = UpperBound(uoLoadingPL.Stowages[])
		For lPartCnt = 1 To UpperBound(uoLoadingPLPartResult.Stowages[])
			uoLoadingPL.Stowages[lUpper + lPartCnt] = uoLoadingPLPartResult.Stowages[lPartCnt]
		Next
	end if
Next

uoLoadingPL.lStowageCount = UpperBound(uoLoadingPL.Stowages[])
Return uoLoadingPL
end function

public function uo_loading_stowage uf_insertstowage (long lgalleykey, string sgalley, integer ibellycontainer, string sstowage, string splace);Long						lGalleyCnt, &
							lGalleyIndex
uo_loading_galley 	uoLoadingGalley 


uoLoadingGalley = uf_InsertGalley(lGalleyKey, sGalley, iBellyContainer)

// ---------------------------
// Ein Stauort einf$$HEX1$$fc00$$ENDHEX$$gen und 
// diesen Retour
// ---------------------------
return uoLoadingGalley.uf_insertstowage(sStowage, sPlace)

end function

public function uo_loading_packinglist uf_getallpackinglists ();uo_loading_packinglist uoLoadingPackinglist
Long		lGalley, &
			lStowage, &
			lFoundStowages, &
			lNew, &
			lNewStowage
			
Long		lPlKey
Boolean	bIsNew 

uoLoadingPackinglist = CREATE uo_loading_packinglist 


For lGalley = 1 To lGalleyCount
	
	For lStowage = 1 To Galley[lGalley].lStowageCount
		bIsNew  	= True
		lPlKey 	= Galley[lGalley].Stowages[lStowage].lPackingListKey
				
		for lFoundStowages = 1 To uoLoadingPackinglist.lPackingListCount
			if uoLoadingPackinglist.PackingLists[lFoundStowages].lPackingListKey = lPlKey Then
				
				// die ESL haben wir schon
				// wir f$$HEX1$$fc00$$ENDHEX$$gen nur den Stauort an
				bIsNew  	= False
				
				uoLoadingPackinglist.PackingLists[lFoundStowages].lStowageCount ++
				
				lNewStowage = uoLoadingPackinglist.PackingLists[lFoundStowages].lStowageCount
				
				uoLoadingPackinglist.PackingLists[lFoundStowages].Stowages[lNewStowage] = CREATE uo_loading_stowage
				uoLoadingPackinglist.PackingLists[lFoundStowages].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
				exit
				
			end if
		Next
		
		if bIsNew Then
			// die ist neu wir speichern die ESL
			// und den Stauort
			uoLoadingPackinglist.lPackingListCount ++
			lNew = uoLoadingPackinglist.lPackingListCount
			
			uoLoadingPackinglist.PackingLists[lNew]						= CREATE uo_loading_pl
			uoLoadingPackinglist.PackingLists[lNew].sPackingList		= Galley[lGalley].Stowages[lStowage].sPackingList
			uoLoadingPackinglist.PackingLists[lNew].lPackingListKey  = Galley[lGalley].Stowages[lStowage].lPackingListKey
			uoLoadingPackinglist.PackingLists[lNew].sUnit				= Galley[lGalley].Stowages[lStowage].sUnit
			
			// noch die Stauorte merken
			uoLoadingPackinglist.PackingLists[lNew].lStowageCount ++
			
			lNewStowage = uoLoadingPackinglist.PackingLists[lNew].lStowageCount 
			
			uoLoadingPackinglist.PackingLists[lNew].Stowages[lNewStowage] = CREATE uo_loading_stowage
			uoLoadingPackinglist.PackingLists[lNew].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
		end if
	Next
Next

return uoLoadingPackinglist


end function

public function uo_loading_loadinglist uf_getallloadinglists ();uo_loading_loadinglist 	uoLoadingList
Long		lGalley, &
			lStowage, &
			lFoundStowages, &
			lNew, &
			lNewStowage
			
Long		lSslKey
Boolean	bIsNew 

uoLoadingList = CREATE uo_loading_loadinglist 


For lGalley = 1 To lGalleyCount
	
	For lStowage = 1 To Galley[lGalley].lStowageCount
		bIsNew  	= True
		lSslKey 	= Galley[lGalley].Stowages[lStowage].lLoadingListKey
				
		for lFoundStowages = 1 To uoLoadingList.lLoadingListCount 
			if uoLoadingList.LoadingLists[lFoundStowages].lLoadingListKey = lSslKey Then
				
				// die ESL haben wir schon
				// wir f$$HEX1$$fc00$$ENDHEX$$gen nur den Stauort an
				bIsNew  	= False
				
				uoLoadingList.LoadingLists[lFoundStowages].lStowageCount ++
				
				lNewStowage = uoLoadingList.LoadingLists[lFoundStowages].lStowageCount
				
				uoLoadingList.LoadingLists[lFoundStowages].Stowages[lNewStowage] = CREATE uo_loading_stowage
				uoLoadingList.LoadingLists[lFoundStowages].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
				exit
				
			end if
		Next
		
		if bIsNew Then
			// die ist neu wir speichern die ESL
			// und den Stauort
			uoLoadingList.lLoadingListCount ++
			lNew = uoLoadingList.lLoadingListCount
			
			uoLoadingList.LoadingLists[lNew]							= CREATE uo_loading_ssl
			uoLoadingList.LoadingLists[lNew].sLoadingList		= Galley[lGalley].Stowages[lStowage].sLoadingList
			uoLoadingList.LoadingLists[lNew].lLoadingListKey  	= Galley[lGalley].Stowages[lStowage].lLoadingListKey
			uoLoadingList.LoadingLists[lNew].lLoadingListType	= Galley[lGalley].Stowages[lStowage].lLoadingListType
			uoLoadingList.LoadingLists[lNew].iLoadedAtLeg		= Galley[lGalley].Stowages[lStowage].iLoadedAtLeg
			
			// noch die Stauorte merken
			uoLoadingList.LoadingLists[lNew].lStowageCount ++
			
			lNewStowage = uoLoadingList.LoadingLists[lNew].lStowageCount 
			
			uoLoadingList.LoadingLists[lNew].Stowages[lNewStowage] = CREATE uo_loading_stowage
			uoLoadingList.LoadingLists[lNew].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
		end if
	Next
Next

return uoLoadingList


end function

public function uo_loading_qaqs uf_getallqaq ();uo_loading_qaqs uoQAQs
Long		lGalley, &
			lStowage, &
			lFoundStowages, &
			lNew, &
			lNewStowage
			
Long		lQAQHandlingKey
Boolean	bIsNew 

uoQAQs = CREATE uo_loading_qaqs 


For lGalley = 1 To lGalleyCount
	
	For lStowage = 1 To Galley[lGalley].lStowageCount
		bIsNew  	= True
		lQAQHandlingKey 	= Galley[lGalley].Stowages[lStowage].lQAQHandlingKey
		
		if lQAQHandlingKey > 0 Then		// Der Default
			
			for lFoundStowages = 1 To uoQAQs.lQAQSCount 
				if uoQAQs.QAQS[lFoundStowages].lQAQHandlingKey = lQAQHandlingKey Then
					
					// die ESL haben wir schon
					// wir f$$HEX1$$fc00$$ENDHEX$$gen nur den Stauort an
					bIsNew  	= False
					
					uoQAQs.QAQS[lFoundStowages].lStowageCount ++
					
					lNewStowage = uoQAQs.QAQS[lFoundStowages].lStowageCount
					
					uoQAQs.QAQS[lFoundStowages].Stowages[lNewStowage] = CREATE uo_loading_stowage
					uoQAQs.QAQS[lFoundStowages].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
					exit
					
				end if
			Next
			
			if bIsNew Then
				// die ist neu wir speichern die ESL
				// und den Stauort
				uoQAQs.lQAQSCount ++
				lNew = uoQAQs.lQAQSCount
				
				uoQAQs.QAQS[lNew]							= CREATE uo_handling_qaq
				uoQAQs.QAQS[lNew].lQAQHandlingKey	= Galley[lGalley].Stowages[lStowage].lQAQHandlingKey
				uoQAQs.QAQS[lNew].iLoadedAtLeg		= Galley[lGalley].Stowages[lStowage].iLoadedAtLeg
				
				// noch die Stauorte merken
				uoQAQs.QAQS[lNew].lStowageCount ++
				
				lNewStowage = uoQAQs.QAQS[lNew].lStowageCount 
				
				uoQAQs.QAQS[lNew].Stowages[lNewStowage] = CREATE uo_loading_stowage
				uoQAQs.QAQS[lNew].Stowages[lNewStowage] = Galley[lGalley].Stowages[lStowage]
			end if
		end if
	Next
Next


return uoQAQs

end function

on uo_loading.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

