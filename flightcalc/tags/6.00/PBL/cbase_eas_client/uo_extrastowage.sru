HA$PBExportHeader$uo_extrastowage.sru
$PBExportComments$Klasse mit allen Methoden rund um extra Stauorte f$$HEX1$$fc00$$ENDHEX$$r die Diagramm Design
forward
global type uo_extrastowage from uo_graphicobject
end type
end forward

global type uo_extrastowage from uo_graphicobject
end type
global uo_extrastowage uo_extrastowage

type variables
Public:

Long			lGalleyID
Long			lExtraStowageID
Long			lEuipmentID
Long			laircraftkey
String		sGalleyName
String		sVerweisText = "see AS"
// ------------------------------
// die Hintergrundfarbe
// ------------------------------
Long			lBackColor	 = 31981567
Integer		iPrintColor 

Boolean		bDontDelete = False
Boolean		bPrintHeader = False
Boolean		bPrintFrame = True

// ------------------------------
// der anzuzeigende Text
// ------------------------------
String	sBemerkung 
String	sHeaderText
// ------------------------------
// die zu druckendenTexte 
// ------------------------------
String	sText[] 
String	sStauOrt[]
Integer 	iTextPrinted[] 

// ------------------
// key
// ------------------
Long	lID

// ---------------------
// die Zeilen im DW
// ---------------------
long lFoundRow[]
Long lFoundRowUeberlauf[]


Private:
String	isTrennZeichen[]
end variables

forward prototypes
public subroutine uf_loadsilbentrenner ()
public function string uf_silbentrennung (string stextzumtrennen)
public function string uf_cen_profilestring (string ssection, string skey, string sdefault, string spara_mandant)
public function long uf_drawreport ()
end prototypes

public subroutine uf_loadsilbentrenner ();String 	sSeperator				  
Integer	i

sSeperator = this.uf_cen_profileString("Syllabification", "Seperator", "", sMandant)
	
// ----------------------------------
// hier stehen die g$$HEX1$$fc00$$ENDHEX$$ltigen Zeichen
// nach denen getrennt werden darf
// ----------------------------------
For i = 1 To Len(sSeperator)
	this.isTrennZeichen[i] = Mid(sSeperator, i, 1)
Next


end subroutine

public function string uf_silbentrennung (string stextzumtrennen);
	// ----------------------------------
	// Diese Methode stellt sicher, da$$HEX1$$df00$$ENDHEX$$
	// der Text auch Trennbar ist, wenn
	// wir das Textfeld vergr$$HEX2$$f600df00$$ENDHEX$$ern in
	// der H$$HEX1$$f600$$ENDHEX$$he. PB macht nur einen
	// Umbruch, wenn er auf ein Leer-
	// zeichen trifft. Die Cobis-Texte
	// haben aber zum Teil die Form
	// TEXT/TEXT-TEXT
	// Genau hier setzen wir an und
	// f$$HEX1$$fc00$$ENDHEX$$gen Leerzeichen ein
	// ----------------------------------
	
	Integer	j, &
				i, &
				iIndex, &
				iLastPos
				

	String	sTrennbare[], &
				sRet, &
				sTest
				
	sTest = sTextZumTrennen
	if UpperBound(this.isTrennZeichen[]) > 0 Then
		iLastPos = 1	
		
		// --------------------------
		// damit wir bis hinten hin 
		// kommen f$$HEX1$$fc00$$ENDHEX$$gen wir das erste
		// Trennzeichen hinten an ent-
		// fernen es sp$$HEX1$$e400$$ENDHEX$$ter wieder
		// --------------------------
		sTextZumTrennen = sTextZumTrennen + this.isTrennZeichen[1]
		for i = 1 To Len(sTextZumTrennen)
			
			for j = 1 to UpperBound(this.isTrennZeichen[])
				if Mid(sTextZumTrennen, i, 1)  = this.isTrennZeichen[j] Then
					iIndex  				= UpperBound(sTrennbare[]) + 1
					
					sTrennbare[iIndex]= Trim(Mid(sTextZumTrennen, iLastPos, (i - iLastPos) + 1))
					iLastPos				= i + 1
				end if
			next
		Next
		// --------------------------
		// wir haben alle Teilsrings
		// und f$$HEX1$$fc00$$ENDHEX$$gen diese wieder mit
		// einem Leerzeichen zusammen
		// Das letzte Trennzeichen
		// entfernen
		// --------------------------
		for i = 1 To UpperBound(sTrennbare[])
			sRet = sRet  + sTrennbare[i] + " "
		next
		sRet = Left(sRet, Len(sRet) - 2)
	else
		sRet = sTextZumTrennen
	end if
	
	
	return sRet
	


end function

public function string uf_cen_profilestring (string ssection, string skey, string sdefault, string spara_mandant);string	sValue

Select 	cValue 
into 		:sValue 
from		cen_setup
where		cclient		= :spara_mandant  	and
			cSection		= :sSection				and
			cKey			= :sKey;
			
			
If SQLCA.SQLCode = 100 Then
	sValue = sDefault
	INSERT INTO cen_setup  
          (cclient,   
          csection,   
          ckey,   
          cvalue )
   VALUES (:spara_mandant,   
          :sSection,   
          :sKey,   
          :sDefault)  ;
	f_check_sql(sqlca,"Insert into cen_setup","Insert")
End if


return sValue
end function

public function long uf_drawreport ();String		sCreate, &
				sResult
	
Integer		iMaxWidth, &
				iMaxHeight, &
				iCnt, &
				iStartX, &
				iStartY, &
				iStartXStowage, &
				iTextHeight, &
				iTextHeightCheck, &
				iTextWidth, &
				iTextWidthStowage, &
				iUseTextWidthStowage, &
				iGesamtHeight, &
				iRet, &
				iAlignStowage[], &
				iKursivStowage[]
				
Boolean		bDraw = True, &
				bStop = False
				
long ll_TextHeight, ll_TextWidth

// --------------------
// Nicht Farbig ?
// --------------------
if iPrintColor > 1 then
	lLineColor 	= 0						// Linenfarbe schwarz
	lBackColor	= 16777215				// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
end if


// --------------------------
// Die Silbentrenner f$$HEX1$$fc00$$ENDHEX$$r 
// die Trennung laden
// --------------------------
uf_loadsilbentrenner()

// ---------------------------
// den Stauort erstellen
// ---------------------------
if bPrintFrame Then
		
	sObjectName 	= "entwurf_extra_rect_" + String(cpu())
	sCreate 			= "create rectangle("  																	+  &
								"band=Detail "  																	+  &
								"pointer='Arrow!' "  															+  &
								"moveable=0 "  																	+  &
								"resizeable=0 "  																	+  &
								"x='" 						+ String(lxposinpixel) 				+ "' "	+  &
								"y='" 						+ String(lyposinpixel) 				+ "' "	+  &
								"height='" 					+ String(lHeightInpixel)	 		+ "' "  	+  &
								"width='" 					+ String(lWidthInpixel) 			+ "' "  	+  &
								"name=" 						+ sObjectName 							+ " "		+  & 
								"brush.hatch='6' "  																+  &
								"brush.color='" 			+ String(lBackColor) 				+ "' "	+  &
								"pen.style='0' "  																+  & 
								"pen.width='" 				+ String(iLineWidth) 				+ "' "	+  &
								"pen.color='" 				+ String(lLineColor) 				+ "' "  	+  & 
								"background.mode='0' "  														+  & 
								"background.color='" 	+ String(lBackColor) 							+ "')"
	sResult = dsreport.Modify(sCreate)
	if sResult <> "" Then
		return -1
	end if
end if

for iCnt = 1 To UpperBound(sstauort[])
	iuo_FontCalc.of_GetTextSize(sStauort[iCnt], sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
	iTextWidthStowage	= Integer(ll_TextWidth)
	iAlignStowage[iCnt]	= 1
	iKursivStowage[iCnt]	= 0
	if iTextWidthStowage > iUseTextWidthStowage Then
		iUseTextWidthStowage = iTextWidthStowage	
	end if
next


iMaxWidth		= lWidthInpixel - 6 - iLineWidth - iUseTextWidthStowage
iStartX			= lxposinpixel + iUseTextWidthStowage + iLineWidth + 6
iStartY			= lyposinpixel + iLineWidth + 1
iStartXStowage	= lxposinpixel + iLineWidth + 1
iCnt				= 1
bDraw				= (UpperBound(sText[]) > 0)
iMaxHeight		= lHeightInpixel - (2 * iLineWidth)


if bPrintHeader Then
	sObjectName 		 = "header_" + String(CPU())
	
	if isnull(sheadertext) then sheadertext = ""
	if isnull(sFontName) then sFontName = ""
	
	iuo_FontCalc.of_GetTextSize(sheadertext, sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
	iTextHeight = Integer(ll_TextHeight)
	iTextWidth	= Integer(ll_TextWidth)
	
	if iTextWidth > iMaxWidth Then
		iTextHeight = iTextHeight * 2
		iTextWidth  = iMaxWidth
	end if
	iMaxHeight = iMaxHeight - iTextHeight
	
	sCreate = "create "																				+  & 
					"text("  																			+  &
					"band=detail "  																	+  &
					"alignment='0' "																	+  &
					"border='0' "  																	+  &
					"color='" 					+ String(lTextColor)					+ "' "	+  &
					"height='" 					+ String(iTextHeight) 				+ "' "  	+  &
					"width='" 					+ String(iTextWidth)					+ "' "  	+  &
					"x='" 						+ String(iStartXStowage)			+ "' "	+  &
					"y='" 						+ String(iStartY) 					+ "' "	+  &
					"name=" 						+ sObjectName 							+ " "		+  & 
					"text='" 					+ sHeaderText							+ "' "	+  &
					"resizeable=0 "  																	+  &
					"moveable=0 "  																	+  &	
					"font.face='"				+ sFontName								+ "' "	+  &
					"font.height='-"  		+ String(iFontSize)					+ "' "	+  &
					"font.weight='400' " 															+  &
					"font.family='2' "  																+  &
					"font.pitch='2' "  																+  &
					"font.charset='0' "  															+  &
					"font.italic='0' "															 	+  &
					"font.Underline='1'"														 		+  &
					"background.mode='1' "  														+  &
					"background.color='" 	+ String(lBackColor) 				+ "' "	+  &
					"height.autosize=No)"
	
	sResult = dsreport.Modify(sCreate)
	iStartY = iStartY + iTextHeight
end if


do while bDraw 
	iuo_FontCalc.of_GetTextSize(sText[iCnt], sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
	iTextHeight = Integer(ll_TextHeight)
	iTextWidth	= Integer(ll_TextWidth)
	
	if iTextWidth > iMaxWidth Then
		sText[iCnt] = uf_SilbenTrennung(sText[iCnt])
		iTextHeight	= iTextHeight * 2				
	end if
	
	// ---------------------
	// Flag setzen, da$$HEX1$$df00$$ENDHEX$$
	// Zeile gedruckt wurde
	// ---------------------
	iTextPrinted[iCnt] = 1
	
	// -----------------------
	// Die aktuelle Gesamth$$HEX1$$f600$$ENDHEX$$he
	// -----------------------
	iGesamtHeight		+= iTextHeight    	 
	
	sObjectName = "aufzaehlung_" + String(CPU()) + "_" + string(iCnt)	
	sCreate = "create "																				+  & 
					"text("  																			+  &
					"band=detail "  																	+  &
					"alignment='"				+ string(iAlignStowage[iCnt])					+ "' "	+  &
					"border='0' "  																	+  &
					"color='" 					+ String(lTextColor)					+ "' "	+  &
					"height='" 					+ String(iTextHeight) 				+ "' "  	+  &
					"width='" 					+ String(iUseTextWidthStowage)	+ "' "  	+  &
					"x='" 						+ String(iStartXStowage)			+ "' "	+  &
					"y='" 						+ String(iStartY) 					+ "' "	+  &
					"name=" 						+ sObjectName 							+ " "		+  & 
					"text='" 					+ sstauort[iCnt]						+ "' "	+  &
					"resizeable=0 "  																	+  &
					"moveable=0 "  																	+  &	
					"font.face='"				+ sFontName								+ "' "	+  &
					"font.height='-"  		+ String(iFontSize)					+ "' "	+  &
					"font.weight='400' " 															+  &
					"font.family='2' "  																+  &
					"font.pitch='2' "  																+  &
					"font.charset='0' "  															+  &
					"font.italic='"			+ string(iKursivStowage[iCnt])	+ "' "	+  &
					"background.mode='1' "  														+  &
					"background.color='" 	+ String(lBackColor) 				+ "' "	+  &
					"height.autosize=No)"
	
	sResult = dsreport.Modify(sCreate)
	
	sObjectName = "text_" + String(CPU()) + "_" + string(iCnt)	
	sCreate = "create "																				+  & 
					"text("  																			+  &
					"band=detail "  																	+  &
					"alignment='0' "																	+  &
					"border='0' "  																	+  &
					"color='" 					+ String(lTextColor)					+ "' "	+  &
					"height='" 					+ String(iTextHeight) 				+ "' "  	+  &
					"width='" 					+ String(iMaxWidth)					+ "' "  	+  &
					"x='" 						+ String(iStartX)						+ "' "	+  &
					"y='" 						+ String(iStartY) 					+ "' "	+  &
					"name=" 						+ sObjectName 							+ " "		+  & 
					"text='" 					+ sText[iCnt]							+ "' "	+  &
					"resizeable=0 "  																	+  &
					"moveable=0 "  																	+  &	
					"font.face='"				+ sFontName								+ "' "	+  &
					"font.height='-"  		+ String(iFontSize)					+ "' "	+  &
					"font.weight='400' " 															+  &
					"font.family='2' "  																+  &
					"font.pitch='2' "  																+  &
					"font.charset='0' "  															+  &
					"font.italic='0' "															 	+  &
					"background.mode='1' "  														+  &
					"background.color='" 	+ String(lBackColor) 				+ "' "	+  &
					"height.autosize=No)"
						
	sResult = dsreport.Modify(sCreate)
	
	if sResult <> "" then
		iRet --
	end if
	
	// --------------------------------
	// geht der n$$HEX1$$e400$$ENDHEX$$chste noch rein von
	// der H$$HEX1$$f600$$ENDHEX$$he?
	// --------------------------------
	iStartY += iTextHeight
	iCnt ++
	
	if iCnt <= UpperBound(sText[]) then
		bDraw = not bStop
	else
		exit
	end if
	
	if (iCnt + 1) <= UpperBound(sText[]) then
		iuo_FontCalc.of_GetTextSize(sText[iCnt + 1], sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
		iTextHeightCheck = Integer(ll_TextHeight)
		iTextWidth = Integer(ll_TextWidth)
		
		iuo_FontCalc.of_GetTextSize(sText[iCnt], sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
		iTextHeight	= Integer(ll_TextHeight)
		
		if iTextWidth > iMaxWidth then
			iTextHeightCheck	= iTextHeightCheck * 2				
		end if

		if (iGesamtHeight + iTextHeightCheck + iTextHeight) >= iMaxHeight then
			iuo_FontCalc.of_GetTextSize(sVerweisText, sFontName, iFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
			if ll_TextWidth >= iMaxWidth then
				// --------------------------------------------------
				// wir brauchen zwei Zeilen, ergo schon den n$$HEX1$$e400$$ENDHEX$$chsten
				// nicht mehr drucken
				// --------------------------------------------------
				sstauort[iCnt + 1] 	 		= sVerweisText
				iTextPrinted[iCnt + 1] 		= 0
				iTextHeight			 			= iTextHeight * 2
				iKursivStowage[iCnt + 1] 	= 1
				iAlignStowage[iCnt + 1]		= 0
				sText[iCnt + 1] 				= ""
			else
				// --------------------------------------------------
				// wir brauchen eine Zeile, ergo den $$HEX1$$fc00$$ENDHEX$$bern$$HEX1$$e400$$ENDHEX$$chsten
				// nicht mehr drucken
				// --------------------------------------------------					
				sstauort[iCnt] 	  		= sVerweisText
				iTextPrinted[iCnt] 		= 0
				iKursivStowage[iCnt] 	= 1
				iAlignStowage[iCnt]	 	= 0
				sText[iCnt] 				= ""
			end if
			// --------------------------------------------------
			// wir drucken die Info an die Stelle, an der normaler-
			// weise der Stauort steht
			// --------------------------------------------------			
			iUseTextWidthStowage = iMaxWidth
			bStop 					= True
		end if
	end if	
loop

return iRet
end function

on uo_extrastowage.create
call super::create
end on

on uo_extrastowage.destroy
call super::destroy
end on

