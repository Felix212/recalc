HA$PBExportHeader$uo_stowage.sru
$PBExportComments$Klasse mit allen Methoden rund um Stauorte f$$HEX1$$fc00$$ENDHEX$$r die Diagramm Design
forward
global type uo_stowage from uo_graphicobject
end type
end forward

global type uo_stowage from uo_graphicobject
end type
global uo_stowage uo_stowage

type variables
Public:

// ------------------------------
// die allgemeinen Eigenschaften
// ------------------------------
String 	sGalley
String	sStowage
String	sPlace
Integer	iBelly


Integer  iResize

// ----------------------------
// Zus$$HEX1$$e400$$ENDHEX$$tzliche Infos f$$HEX1$$fc00$$ENDHEX$$r den 
// richtigen Druck
// ----------------------------
String	sPLText
String	sMealCode
String	sAddOnText
String	sSNR
String	sProdBereich
Integer	iMealMenge
String	sMOPSNR
String	sMealBez
String	sEinheit
String	sZustauText
Double	dGewicht
String	sNew
Integer	iSecondFontSize


Integer	iGalleyItalic,  		iGalleyBold,  		iGalleyAlign
Integer	iStowageItalic, 		iStowageBold, 		iStowageAlign
Integer	iPlaceItalic, 	 		iPlaceBold,   		iPlaceAlign
Integer	iPLTextItalic,  		iPLTextBold,  		iPLTextAlign
Integer	iMealCodeItalic,		iMealCodeBold,		iMealCodeAlign
Integer	iAddOnTextItalic, 	iAddOnTextBold,  	iAddOnTextAlign
Integer	iSNRItalic,  			iSNRBold,  			iSNRAlign
Integer	iProdBereichItalic,  iProdBereichBold, iProdBereichAlign
Integer	iMealMengeItalic,  	iMealMengeBold,  	iMealMengeAlign
Integer	iMOPSNRItalic,  		iMOPSNRBold,  		iMOPSNRAlign
Integer	iMealBezItalic,  		iMealBezBold,  	iMealBezAlign
Integer	iEinheitItalic,  		iEinheitBold,  	iEinheitAlign
Integer	iZustauTextItalic,	iZustauTextBold, 	iZustauTextAlign
Integer	iGewichtItalic,		iGewichtBold, 		iGewichtAlign
Integer	iNewItalic,				iNewBold, 			iNewAlign


// ------------------------------
// das zugeordnete Equipment
// ------------------------------
Long		lEquipmentID
String	sEquipmentName

// ------------------------------
// der PK-Wert aus der DB
// ------------------------------
Long 		lStowageID


// ------------------------------
// Der Selektierte ?
// ------------------------------
Boolean	bSelected = False
Boolean	bSecondSelected = False

// ------------------------------
// Die Hintergrundfarbe
// ------------------------------
Long		lBackColor = 33549013

// ------------------------------
// Flag, ob Zustautext und 
// PL-Text gedruckt wurde
// ------------------------------
Boolean	bZustauTextPrinted 	= False
Boolean	bPLTextPrinted			= False

// ------------------------------
// Der QAQ Actioncode
// ------------------------------
String	sQAQActionCode
Long		lQAQTextColor

// ------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Caterer markieren
// ------------------------------
BOOLEAN	bMarkNoCatererAction = FALSE
Long		lMarkNoCatererActionColor

// ------------------------------
// For-To Code
// ------------------------------
String	sForToCode
Long		lForToTextColor

// ------------------------------
// Geh$$HEX1$$f600$$ENDHEX$$rt dieser Stauort zur 
//	Klasse
// ------------------------------
Boolean	bIsClassStowage 					= True
Integer	iBrushHatch							= 6				// Standard ist Solid
Long		lBrushColor							= 0

Private:
Integer	iBackgroundMode					= 1 // 0 $$HEX2$$14202000$$ENDHEX$$Make the control's background opaque      1 $$HEX2$$14202000$$ENDHEX$$Make the control's background transparent
String	isTrennZeichen[]



end variables

forward prototypes
public subroutine uf_resize_equipment (long lnewbackgroundcolor, long lnewlinecolor, long lnewlinewidth)
public subroutine uf_loadsilbentrenner ()
private function integer uf_drawqaq ()
public function long uf_drawreport ()
private function string uf_silbentrennung (string stextzumtrennen)
public function integer uf_drawforto ()
public function string uf_cen_profilestring (string ssection, string skey, string sdefault, string spara_mandant)
public function integer uf_log (string smsg)
end prototypes

public subroutine uf_resize_equipment (long lnewbackgroundcolor, long lnewlinecolor, long lnewlinewidth);	string 	sCreate, &
				sResult
		
	// --------------------------
	// geh$$HEX1$$f600$$ENDHEX$$rt dieser Stauort zur
	// Klasse, so ist Standard-
	// F$$HEX1$$fc00$$ENDHEX$$llung angesagt.
	// Andernfalls schraffiert,
	// nach dem was der Parent 
	// gesetzt hat
	// --------------------------
	if bIsClassStowage Then
		lBrushColor					= lNewBackgroundColor
		iBrushHatch					= 6								// Standard ist Solid
	else
		lNewBackgroundColor		= lBrushColor
		iBrushHatch					= 6								// Standard ist Solid
	end if
	
	if bMarkNoCatererAction Then
		lNewBackgroundColor  = lMarkNoCatererActionColor
		lBrushColor  			= lMarkNoCatererActionColor
		iBrushHatch	 			= 6	
	end if
	
	
	// -------------------------------------------------------------
	// den Stauort $$HEX1$$fc00$$ENDHEX$$berschreiben und dem Partner-Stauort angleichen
	// -------------------------------------------------------------
	sObjectName 	= "resize_stauort_rect_" + String(lStowageID)
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
								"brush.hatch='"			+ String(iBrushHatch)				+ "' "  	+  &
								"brush.color='" 			+ String(lBrushColor)			 	+ "' "	+  &								
								"pen.style='0' "  																+  & 
								"pen.width='"				+ String(lNewLineWidth) 			+ "' "	+  & 
								"pen.color='" 				+ String(lNewLineColor) 			+ "' "  	+  & 
								"background.mode='0'"															+  & 
								"background.color='" 	+ String(lNewBackgroundColor) 				+ "')"
	sResult = dsreport.Modify(sCreate)

	
	if sResult <> "" Then
		return 
	end if
	
	// ---------------------------------------------------
	// das folgende Rechteck $$HEX1$$fc00$$ENDHEX$$berzeichnet die obere Kante,
	// somit wird aus einem halben Wagen ein Ganzer
	// ---------------------------------------------------	
	sObjectName 	= "resize_stauort_line_" + String(lStowageID)
	sCreate 			= "create rectangle("  																					+  &
								"band=Detail "  																					+  &
								"pointer='Arrow!' "  																			+  &
								"moveable=0 "  																					+  &
								"resizeable=0 "  																					+  &
								"x='" 						+ String(lxposinpixel + iLineWidth) 			+ "' "	+  &
								"y='" 						+ String(lyposinpixel - iLineWidth) 			+ "' "	+  &
								"height='" 					+ String((2 * iLineWidth))	 						+ "' "  	+  &
								"width='" 					+ String(lWidthInpixel - (2 * iLineWidth)) 	+ "' "  	+  &
								"name=" 						+ sObjectName 											+ " "		+  & 
								"brush.hatch='"			+ String(iBrushHatch)	 							+ "' "  	+  &
								"brush.color='" 			+ String(lBrushColor) 								+ "' "	+  &								
								"pen.style='5' "  																	+  & 
								"pen.width='1' "																		+  & 
								"pen.color='" 				+ String(lNewBackgroundColor) 					+ "' "  	+  & 
								"background.mode='0' " 																+  & 
								"background.color='" 	+ String(lNewBackgroundColor) 					+ "')"
	sResult = dsreport.Modify(sCreate)
	
	if sResult <> "" Then
		return 
	end if
	

end subroutine

public subroutine uf_loadsilbentrenner ();String 	sSeperator				  
Integer	i

sSeperator =  "/ -." //this.uf_cen_profileString("Syllabification", "Seperator", "", sMandant)
	

// ----------------------------------
// hier stehen die g$$HEX1$$fc00$$ENDHEX$$ltigen Zeichen
// nach denen getrennt werden darf
// ----------------------------------
For i = 1 To Len(sSeperator)
	this.isTrennZeichen[i] = Mid(sSeperator, i, 1)
Next


end subroutine

private function integer uf_drawqaq ();String	sCreate, &
			sResult

Integer	iTextHeight, &
			iTextPosX, &
			iTextPosY, &
			iUseFontSize

long ll_TextHeight, ll_TextWidth

// ------------------------------
// die Schrift kann zu
// gro$$HEX2$$df002000$$ENDHEX$$werden ab einem
// Verh$$HEX1$$e400$$ENDHEX$$ltnis von Breite 
// zu H$$HEX1$$f600$$ENDHEX$$he < 0.5
// Haben wir ein gr$$HEX2$$f600df00$$ENDHEX$$eres
// Verh$$HEX1$$e400$$ENDHEX$$ltnis zu skalieren wir
//
// Falls wir noch den FOR-To-Code
// haben, so nehmen wir nur die 
// H$$HEX1$$e400$$ENDHEX$$lfte
// ------------------------------

iuo_FontCalc.of_GetOptFontSize(sQAQActionCode, sFontName, iUseFontSize, false, false, false, lHeightInPixel, lWidthInpixel, false)
if iUseFontSize > 10 then iUseFontSize = 10

iuo_FontCalc.of_GetTextSize(sQAQActionCode, sFontName, iUseFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
iTextHeight	 	= Integer(ll_TextHeight) 
iTextPosX 		= lXPosInPixel + 5

if NOT isNull(sForToCode) AND LEN(TRIM(sForToCode)) > 0 Then
	// oberhalb der Mitte drucken
	iTextPosY 	= lYPosInPixel + (lheightinpixel / 2) - (iTextHeight / 2) - 5
else
	// genau in die Mitte drucken
	iTextPosY 	= lYPosInPixel + (lheightinpixel / 2) - (iTextHeight / 2)
end if


sObjectName = "qaq_" + String(CPU()) + "_" + String(iTextPosX)
sCreate = "create "																				+  & 
					"text("  																			+  &
					"band=detail "  																	+  &
					"alignment='2' "																	+  &
					"border='0' "  																	+  &
					"color='" 					+ String(lQAQTextColor)				+ "' "	+  &
					"height='" 					+ String(iTextHeight)				+ "' "  	+  &
					"width='" 					+ String(lWidthInpixel - 10)		+ "' "  	+  &
					"x='" 						+ String(iTextPosX)					+ "' "	+  &
					"y='" 						+ String(iTextPosY) 					+ "' "	+  &
					"name=" 						+ sObjectName 							+ " "		+  & 
					"text='" 					+ sQAQActionCode	 					+ "' "	+  &
					"resizeable=0 "  																	+  &
					"moveable=0 "  																	+  &	
					"font.face='"				+ sFontName								+ "' "	+  &
					"font.height='"	  		+ String(iUseFontSize)				+ "' "	+  &
					"font.weight='700' "																+  &
					"font.family='2' "  																+  &
					"font.pitch='2' "  																+  &
					"font.charset='0' "  															+  &
					"font.italic='0' "  																+  &
					"background.mode='1' "															+  &
					"height.autosize=No)"

sResult = dsreport.Modify(sCreate)
if Len(Trim(sResult)) > 0 Then
	return -1
end if

return 0
end function

public function long uf_drawreport ();String	sCreate, &
			sResult, &
			sTextToPrint[], &
			sGehtNichtRein = "...", &
			sTemp, &
			sLog
			
Long		lRet

Integer	iBoldPropertie[], &
			iItalicPropertie[], &
			iAlignPropertie[], &
			iTextPosX[], &
			iTextPosY[], &		
			iTextWidth[], &	
			iUseFontSize[], &
			iTextHeight[], &
			iIndex, &
			iStartXUnten, &
			iStartYUnten, &
			iStartX, &
			iStartY, &
			iMaxWidth, &
			iMaxHeight, &
			iGesamtHeight, &
			i, j, iBuffer, &
			iCnt, iPrevY, &
			iIndexZustauText, &
			iIndexPLText, &
			iEndXPosSnr, &
			iPosXBuffer, &
			iBufferWidth, &
			iPosYTextRec, &
			iPosXTextRec, &
			iPosTextHeight, &
			iStartYFooter = 0, &
			iRectWidth, &
			iFooterHeight, &
			iFooterBorder = 0

long ll_TextHeight, ll_TextWidth

integer		iFontchange = 0

Boolean		bHasUnit = False, &
				bDraw = True, &
				bStop = False, &
				bBold, bItalic, &
				bSNRPrinted = False, &
				bPrintFooter, &
				bFooterWasPrinted = False

String		sDrawFontname,sDrawFontfamily,sDrawFontPitch,sDrawFontCharSet

// --------------------------
// Die Silbentrenner f$$HEX1$$fc00$$ENDHEX$$r 
// die Trennung laden
// --------------------------
uf_loadsilbentrenner()

sLog = f_check_null(sGalley) + "~t" + f_check_null(sStowage) + "~t" + f_check_null(sPlace) + "~t"

// --------------------------
// geh$$HEX1$$f600$$ENDHEX$$rt dieser Stauort zur
// Klasse, so ist Standard-
// F$$HEX1$$fc00$$ENDHEX$$llung angesagt.
// Andernfalls schraffiert,
// nach dem was der Parent 
// gesetzt hat
// --------------------------
if bIsClassStowage Then
	lBrushColor			= lBackColor
	iBrushHatch			= 6					// Standard ist Solid
else
	lBackColor			= lBrushColor
	iBrushHatch			= 6					// Standard ist Solid
end if

if bMarkNoCatererAction Then
	lBackColor   = lMarkNoCatererActionColor
	lBrushColor  = lMarkNoCatererActionColor
	iBrushHatch	 = 6	
end if

sObjectName 	= "entwurf_stauort_rect_" + String(lStowageID)
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
							"brush.hatch='"			+ String(iBrushHatch)				+ "' "  	+  &
							"brush.color='" 			+ String(lBrushColor) 				+ "' "	+  &								
							"pen.style='0' "  																+  & 
							"pen.width='"				+ String(iLineWidth) 				+ "' "	+  & 
							"pen.color='" 				+ String(lLineColor) 				+ "' "  	+  & 
							"background.mode='0' "  														+  & 
							"background.color='" 	+ String(lBackColor) 							+ "')"
sResult = dsReport.Modify(sCreate)


if sResult <> "" Then
	return -1
end if

// --------------------------
// Die Startkoordinaten unten
//	und rechts
// --------------------------
iMaxWidth		= lWidthInpixel - (2 * iLineWidth) - 2
iRectWidth		= iMaxWidth		

iStartYUnten	= (lYPosInPixel + lheightinpixel) - iLineWidth 
iStartXUnten 	= (lXPosInPixel + lWidthInPixel)  - iLineWidth

// --------------------------
// Die Startkoordinaten oben
// und links
// --------------------------
iStartX 			= lXPosInPixel + iLineWidth
iStartY 			= lYPosInPixel + iLineWidth
iPosXTextRec	= iStartX

iIndex			= 0

// ----------
// SNR 
// ----------	
if Not isNull(sSNR) And Len(sSNR) > 0 Then
	iIndex ++ 		
	iFooterBorder ++
	bBold		= (iSNRbold = 1)
	bItalic	= (iSNRitalic = 1)
	
	if iSNRbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iSNRItalic
	iAlignPropertie[iIndex]				= iSNRAlign
	
	iuo_FontCalc.of_GetTextSize(sSNR, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextWidth[iIndex]					= Integer(ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sSNR	
	
	iTextPosX[iIndex] 					= iStartX
	iTextPosY[iIndex]						= iStartYUnten - iTextHeight[iIndex]
	iUseFontSize[iIndex]					= iSecondFontSize
	
	iStartYFooter 							= iTextPosY[iIndex]		// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
	bFooterWasPrinted						= TRUE						// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
	iFooterHeight 							= iTextHeight[iIndex]	// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
	
	bSNRPrinted = True
	iEndXPosSnr	= iTextWidth[iIndex] + iStartX
	
	
	//uf_log(sLog + "SNR" + "~t" + f_check_null(sSNR) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
	
end if



// ----------
// Place
// ----------
if Not isNull(sPlace) And Len(sPlace) > 0 Then
	iFooterBorder ++
	if bSNRPrinted Then
		iuo_FontCalc.of_GetTextSize(sPlace, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
		iBufferWidth = Integer(ll_TextWidth)
		iPosXBuffer  = iStartXUnten - iBufferWidth - 3
		
		if iPosXBuffer > iEndXPosSnr Then
			bPrintFooter = true
		else
			bPrintFooter = False
		end if
	else
		bPrintFooter = true
	end if
	
		// --------------------
		// SNR hat Priorit$$HEX1$$e400$$ENDHEX$$t
		// Falls $$HEX1$$dc00$$ENDHEX$$berschneidung,
		// das weglassen
		// --------------------
		if bPrintFooter Then	
			iIndex ++ 		
				
			bBold		= (iplacebold = 1)
			bItalic	= (iplaceitalic = 1)
				
			if iplacebold = 1 Then
				bBold 						= True
				iBoldPropertie[iIndex]	= 700
			else
				bBold = False
				iBoldPropertie[iIndex]	= 400
			end if
			iItalicPropertie[iIndex]			= iplaceitalic
			iAlignPropertie[iIndex]				= iPlaceAlign
			iuo_FontCalc.of_GetTextSize(sPlace, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
			iTextWidth[iIndex]					= Integer(ll_TextWidth)
			iTextHeight[iIndex]					= Integer(ll_TextHeight)
			sTextToPrint[iIndex] 				= sPlace	
			iTextPosX[iIndex]						= iStartXUnten - iTextWidth[iIndex] - 3
			iTextPosY[iIndex]						= iStartYUnten - iTextHeight[iIndex]
			iUseFontSize[iIndex]					= iSecondFontSize
			iStartXUnten 							= iTextPosX[iIndex] - 1
			iStartYFooter 							= iTextPosY[iIndex]		// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			bFooterWasPrinted						= TRUE						// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			
			if iTextHeight[iIndex] > iFooterHeight Then
				iFooterHeight = iTextHeight[iIndex]	// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			end if
			
			//uf_log(sLog + "PLACE" + "~t" + f_check_null(sPlace) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
			
		end if
	end if
		
	// ----------
	// Stowage
	// ----------	
	if Not isNull(sStowage) And Len(sStowage) > 0 Then
		iFooterBorder ++
		if bSNRPrinted Then
			iuo_FontCalc.of_GetTextSize(sStowage, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
			iBufferWidth = Integer(ll_TextWidth)
			iPosXBuffer  = iStartXUnten - iBufferWidth - 3
			
			if iPosXBuffer > iEndXPosSnr Then
				bPrintFooter = true
			else
				bPrintFooter = False
			end if
		else
			bPrintFooter = true
		end if
	
		// --------------------
		// SNR hat Priorit$$HEX1$$e400$$ENDHEX$$t
		// Falls $$HEX1$$dc00$$ENDHEX$$berschneidung,
		// das weglassen
		// --------------------
						
		if bPrintFooter Then	
			iIndex ++ 		
			
			bBold		= (iStowagebold = 1)
			bItalic	= (iStowageitalic = 1)
			
			if iStowagebold = 1 Then
				bBold 						= True
				iBoldPropertie[iIndex]	= 700
			else
				bBold = False
				iBoldPropertie[iIndex]	= 400
			end if
				
			iItalicPropertie[iIndex]			= iStowageitalic
			iAlignPropertie[iIndex]				= iStowageAlign
			iuo_FontCalc.of_GetTextSize(sStowage, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
			iTextWidth[iIndex]					= Integer(ll_TextWidth)
			iTextHeight[iIndex]					= Integer(ll_TextHeight)
			sTextToPrint[iIndex] 				= sStowage	
			iTextPosX[iIndex]						= iStartXUnten - iTextWidth[iIndex] - 3
			iTextPosY[iIndex]						= iStartYUnten - iTextHeight[iIndex]
			iUseFontSize[iIndex]					= iSecondFontSize
			iStartXUnten 							= iTextPosX[iIndex] - 1
			iStartYFooter 							= iTextPosY[iIndex]		// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			bFooterWasPrinted						= TRUE						// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
							
			if iTextHeight[iIndex] > iFooterHeight Then
				iFooterHeight = iTextHeight[iIndex]	// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			end if
			
			//uf_log(sLog +"Stowage" + "~t" + f_check_null(sStowage) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
		else
			//uf_log(sLog + "Stowage" + "~t" + f_check_null("bPrintFooter=False") + "~t" + string(-1) + "~t" + string(-1) + "~t" + sFontName)
		end if
		
	else
		
		//uf_log(sLog + "Stowage" + "~t" + f_check_null("NULL") + "~t" + string(-1) + "~t" + string(-1) + "~t" + sFontName)
		
	end if


	// ----------
	// Galley
	// ----------	
	if Not isNull(sGalley) And Len(sGalley) > 0 Then
		if bSNRPrinted Then
			iuo_FontCalc.of_GetTextSize(sGalley, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
			iBufferWidth = Integer(ll_TextWidth)
			iPosXBuffer  = iStartXUnten - iBufferWidth - 3
			
			if iPosXBuffer > iEndXPosSnr Then
				bPrintFooter = true
			else
				bPrintFooter = False
			end if
		else
			bPrintFooter = true
		end if
		
		// --------------------
		// SNR hat Priorit$$HEX1$$e400$$ENDHEX$$t
		// Falls $$HEX1$$dc00$$ENDHEX$$berschneidung,
		// das weglassen
		// --------------------
		if bPrintFooter Then	
			iIndex ++ 		
				
			bBold		= (iGalleybold = 1)
			bItalic	= (iGalleyitalic = 1)
				
			if iGalleybold = 1 Then
				bBold 						= True
				iBoldPropertie[iIndex]	= 700
			else
				bBold = False
				iBoldPropertie[iIndex]	= 400
			end if
			iItalicPropertie[iIndex]			= iGalleyItalic
			iAlignPropertie[iIndex]				= iGalleyAlign
			iuo_FontCalc.of_GetTextSize(sGalley, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
			iTextWidth[iIndex]					= Integer(ll_TextWidth)
			iTextHeight[iIndex]					= Integer(ll_TextHeight)
			sTextToPrint[iIndex] 				= sGalley	
			iTextPosX[iIndex]						= iStartXUnten - iTextWidth[iIndex] - 3
			iTextPosY[iIndex]						= iStartYUnten - iTextHeight[iIndex]
			iUseFontSize[iIndex]					= iSecondFontSize
			iStartXUnten 							= iTextPosX[iIndex] - 1
			iStartYFooter 							= iTextPosY[iIndex]		// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			bFooterWasPrinted						= TRUE						// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
							
			//uf_log(sLog + "GALELY" + "~t" + f_check_null(sGalley) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
							
			if iTextHeight[iIndex] > iFooterHeight Then
				iFooterHeight = iTextHeight[iIndex]	// f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$dc00$$ENDHEX$$bermalung
			end if
		end if
	end if


// ------------------------------------------------------------------------------------------------
// diese 3 Informationen k$$HEX1$$f600$$ENDHEX$$nnen unterschiedlichen Fonteigenschaften haben (Fett / Kursiv).
// Hieraus resultiert einen unterschiedliche H$$HEX1$$f600$$ENDHEX$$he. Um ein einheitliches Bild zu garantieren,
// die kleinste y-Koord. finden und zuordnen. Wir sortieren mal mit Bubble-Sort
// ------------------------------------------------------------------------------------------------

if UpperBound(iTextPosY[]) > 1 Then
	For i = 1 to UpperBound(iTextPosY[])
		For j = UpperBound(iTextPosY[]) To 2 Step -1
			if iTextPosY[j - 1] < iTextPosY[i] Then
				iBuffer 			 = iTextPosY[j - 1]
				iTextPosY[j - 1]= iTextPosY[j]
				iTextPosY[j]	= iBuffer
			end if
		next
	next
	// ---------------------------------------------
	// an der ersten Stelle steht der kleinste Wert
	// ---------------------------------------------
	For i = 1 to UpperBound(iTextPosY[])
		iTextPosY[i] = iTextPosY[1] 
	Next
end if
// ------------------------------------------------------------------------------------------------
//
// 											Die untere Ecke ist abgearbeitet 
// 									         Jetzt fangen wir oben an. 
//
// ------------------------------------------------------------------------------------------------

// ------------------------
// die verbleibende max.
// H$$HEX1$$f600$$ENDHEX$$he
// ------------------------
If UpperBound(iTextPosY[]) > 0 Then
	iMaxHeight = iTextPosY[1] - lYPosInpixel - iLineWidth
else
	iMaxHeight = lHeightInpixel - (2 * iLineWidth)
	
end if
// ----------
// Bezeichnung 
// ----------	
if Not isNull(sPLText) And Len(sPLText) > 0 Then
	iIndex ++ 
	iIndexPLText = iIndex
			
	bBold		= (iPLTextbold = 1)
	bItalic	= (iPLTextitalic = 1)
	
	if iPLTextbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iPLTextItalic
	iAlignPropertie[iIndex]				= iPLTextAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sPLText, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	
	if ll_TextWidth > iMaxWidth Then
		sPLText 			  	  = uf_SilbenTrennung(sPLText)
		iTextHeight[iIndex] = iTextHeight[iIndex]	* 2				
	End if
	
	sTextToPrint[iIndex] 				= sPLText	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	
	//uf_log(sLog + "TEXT" + "~t" + f_check_null(sPLText) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
	
end if

// ----------
// Zusatztext
// ----------	
if Not isNull(sAddOnText) And Len(sAddOnText) > 0 Then
	iIndex ++ 		
	
	bBold		= (iAddOnTextbold = 1)
	bItalic	= (iAddOnTextitalic = 1)
	
	if iAddOnTextbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iAddOnTextItalic
	iAlignPropertie[iIndex]				= iAddOnTextAlign
	
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sAddOnText, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	
	if ll_TextWidth > iMaxWidth Then
		sAddOnText 			  = uf_SilbenTrennung(sAddOnText)
		iTextHeight[iIndex] = iTextHeight[iIndex]	* 2				
	End if

	sTextToPrint[iIndex] 				= sAddOnText	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]

	//uf_log(sLog + "ADDONTEXT" + "~t" + f_check_null(sAddOnText) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)

end if

// ----------
// Zustautext 
// ----------	
if Not isNull(sZustauText) And Len(sZustauText) > 0 Then
	iIndex ++ 		
	iIndexZustauText = iIndex
	
	bBold		= (iZustauTextbold = 1)
	bItalic	= (iZustauTextitalic = 1)
	
	if iZustauTextbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iZustauTextItalic
	iAlignPropertie[iIndex]				= iZustauTextAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sZustauText, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	
	if ll_TextWidth > iMaxWidth Then
		sZustauText		  	  = uf_SilbenTrennung(sZustauText)
		iTextHeight[iIndex] = iTextHeight[iIndex]	* 2				
	End if
	
	sTextToPrint[iIndex] 				= sZustauText	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	
	//uf_log(sLog + "ZUSTAUTEXT" + "~t" + f_check_null(sZustauText) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)

else
	bzustautextprinted = True
end if

// ----------------
// Mealcode = 6
// ----------------
if Not isNull(sMealCode) And Len(sMealCode) > 0 Then
	iIndex ++ 		
	
	bBold		= (iMealCodebold = 1)
	bItalic	= (iMealCodeitalic = 1)
	
	if iMealCodebold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iMealCodeItalic
	iAlignPropertie[iIndex]				= iMealCodeAlign
	iTextWidth[iIndex]					= (iMaxWidth / 2)
	iuo_FontCalc.of_GetTextSize(sMealCode, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sMealCode	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] 
	// --------------------------------------------
	// die Startkoordinate f$$HEX1$$fc00$$ENDHEX$$r den n$$HEX1$$e400$$ENDHEX$$chsten Text
	//
	// Flag setzen
	// --------------------------------------------
	bHasUnit = True
	
	//uf_log(sLog + "MEALCODE" + "~t" + f_check_null(sMealCode) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex])+ "~t" + sFontName )

	
end if

// ------------
// Gewicht
// ------------	
if Not isNull(dGewicht) Then
	iIndex ++ 		
	
	bItalic	= (iGewichtItalic = 1)
	
	if iGewichtBold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if

	sTemp										= String(dGewicht)
	
	iItalicPropertie[iIndex]			= iGewichtItalic
	iAlignPropertie[iIndex]				= iGewichtAlign
	iTextWidth[iIndex]					= (iMaxWidth / 2)
	iuo_FontCalc.of_GetTextSize(sTemp, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sTemp	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] 
	// --------------------------------------------
	// die Startkoordinate f$$HEX1$$fc00$$ENDHEX$$r den n$$HEX1$$e400$$ENDHEX$$chsten Text
	//
	// Flag setzen
	// --------------------------------------------
	bHasUnit = True
	
	//uf_log(sLog + "GEWICHT" + "~t" + f_check_null(sTemp) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)

	
end if	
// ------------
// Einheit
// ------------	
if Not isNull(sEinheit) And Len(sEinheit) > 0 Then
	iIndex ++ 		
	bBold		= (iEinheitbold = 1)
	bItalic	= (iEinheititalic = 1)
	
	if iEinheitbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iEinheitItalic
	if bHasUnit Then
		iAlignPropertie[iIndex]			= iEinheitAlign
	else
		// ansonsten linksb$$HEX1$$fc00$$ENDHEX$$ndig
		iAlignPropertie[iIndex]				= 0
	end if
	
	iuo_FontCalc.of_GetTextSize(sEinheit, sFontName, iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sEinheit	
	
	if bHasUnit Then
		iTextPosX[iIndex] 					= lxposinpixel + (lWidthInPixel / 2) 
		iTextWidth[iIndex]					= (iMaxWidth  / 2)
	else
		iTextPosX[iIndex]	= iStartX
		iTextWidth[iIndex]					= iMaxWidth  
	end if
	
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] // + iTextHeight[iIndex]
	//uf_log(sLog + "EINHEIT" + "~t" + f_check_null(sEinheit) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)

end if


// ----------------
// New Kennzeichen
// -----------------
if len(sNew) > 0 Then
	iIndex ++ 	
	iFontchange = iIndex
	bBold		= (iNewbold = 1)
	bItalic	= (iNewitalic = 1)
	
	if iNewbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= 0
	iAlignPropertie[iIndex]				= iNewAlign
	iuo_FontCalc.of_GetTextSize(sNew, "Wingdings", iSecondFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sNew	
	
	iTextPosX[iIndex]						= lxposinpixel + (lWidthInPixel / 2) 
	iTextWidth[iIndex]					= 30
			
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= 20
	iStartY 									= iTextPosY[iIndex]
	
	//uf_log(sLog + "NEWFLAG" + "~t" + f_check_null(sNew) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)

	
Else
	iFontchange = 0
end if	

// ------------
// Produktions-
// bereich
// ------------	
if Not isNull(sProdBereich) And Len(sProdBereich) > 0 Then
	iIndex ++ 		
	
	bBold		= (iProdBereichbold = 1)
	bItalic	= (iProdBereichitalic = 1)
	
	if iProdBereichbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iProdBereichItalic
	iAlignPropertie[iIndex]				= iProdBereichAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sProdBereich, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sProdBereich	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	
	//uf_log(sLog + "PRODAREA" + "~t" + f_check_null(sProdBereich) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) + "~t" + sFontName)
	
end if

// ------------
// Mealmenge
// ------------	
if Not isNull(iMealMenge) And iMealMenge > 0 Then
	iIndex ++ 		
	
	bBold		= (iMealMengebold = 1)
	bItalic	= (iMealMengeitalic = 1)
	
	if iMealMengebold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iMealMengeItalic
	iAlignPropertie[iIndex]				= iMealMengeAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(String(iMealMenge), sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= String(iMealMenge)	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	//uf_log(sLog + "MEALMENGE" + "~t" + f_check_null(String(iMealmenge)) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) )

end if

// ------------
// MOPSNR
// ------------	
if Not isNull(sMOPSNR) And Len(sMOPSNR) > 0 Then
	iIndex ++ 		
	
	bBold		= (iMOPSNRbold = 1)
	bItalic	= (iMOPSNRitalic = 1)
	
	if iMOPSNRbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iMOPSNRItalic
	iAlignPropertie[iIndex]				= iMOPSNRAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sMOPSNR, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sMOPSNR	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	//uf_log(sLog + "MOPSNR" + "~t" + f_check_null(sMOPSNR) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) )

end if

// ------------
// MealBezeichnung
// ------------	
if Not isNull(sMealBez) And Len(sMealBez) > 0 Then
	iIndex ++ 		
	
	bBold		= (iMealBezbold = 1)
	bItalic	= (iMealBezitalic = 1)
	
	if iMealBezbold = 1 Then
		bBold 						= True
		iBoldPropertie[iIndex]	= 700
	else
		bBold = False
		iBoldPropertie[iIndex]	= 400
	end if
	iItalicPropertie[iIndex]			= iMealBezItalic
	iAlignPropertie[iIndex]				= iMealBezAlign
	iTextWidth[iIndex]					= iMaxWidth
	iuo_FontCalc.of_GetTextSize(sMealBez, sFontName, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
	iTextHeight[iIndex]					= Integer(ll_TextHeight)
	sTextToPrint[iIndex] 				= sMealBez	
	iTextPosX[iIndex]						= iStartX
	iTextPosY[iIndex]						= iStartY
	iUseFontSize[iIndex]					= iFontSize
	iStartY 									= iTextPosY[iIndex] + iTextHeight[iIndex]
	//uf_log(sLog + "MEALBEZ" + "~t" + f_check_null(sMealBez) + "~t" + string(iTextWidth[iIndex]) + "~t" + string(iTextHeight[iIndex]) )

end if

// ---------------------------------------------
// Einzeichnen
// ---------------------------------------------
i 					= 1
bDraw				= (UpperBound(sTextToPrint[]) > 0)
iPrevY			= 1

do While bDraw 

	// ---------------------------
	// es mu$$HEX2$$df002000$$ENDHEX$$gecheckt werden, ob
	// der Zustautext & PL-Text
	// gedruckt worden sind
	// andernfalls mu$$HEX2$$df002000$$ENDHEX$$er in den
	// Extra-Stauort wandern
	// ---------------------------
	
	if i = iIndexPLText Then
		if Len(sTextToPrint[i]) > 0 Then
			bpltextprinted = True
		end if
		if sTextToPrint[i] = sGehtNichtRein Then
			bpltextprinted = False
		end if
	end if
	
	if i = iIndexZustauText Then
		if Len(sTextToPrint[i]) > 0 Then
			bzustautextprinted = True
		end if
		if sTextToPrint[i] = sGehtNichtRein Then
			bzustautextprinted = False
		end if
	end if
// ---------------------------------------
// Font auf Wingdings f$$HEX1$$fc00$$ENDHEX$$r New Kennzeichen 
// ---------------------------------------
	If i = iFontchange Then
		sDrawFontname 		= "Wingdings"
		sDrawFontfamily	= "0"
		sDrawFontPitch 	= "2"
		sDrawFontCharSet 	= "2"
	Else
		sDrawFontname 		= sFontName
		sDrawFontfamily 	= "2"
		sDrawFontPitch 	= "2"
		sDrawFontCharSet 	= "0"
	End if	
	
	sObjectName = "text_" + String(CPU()) + "_" + string(i)
	sCreate = "create "																				+  & 
						"text("  																			+  &
						"band=detail "  																	+  &
						"alignment='"				+ string(iAlignPropertie[i])		+ "' "	+  &
						"border='0' "  																	+  &
						"color='" 					+ String(lTextColor)					+ "' "	+  &
						"height='" 					+ String(iTextHeight[i]) 			+ "' "  	+  &
						"width='" 					+ String(iTextWidth[i])				+ "' "  	+  &
						"x='" 						+ String(iTextPosX[i])				+ "' "	+  &
						"y='" 						+ String(iTextPosY[i]) 				+ "' "	+  &
						"name=" 						+ sObjectName 							+ " "		+  & 
						"text='" 					+ sTextToPrint[i] 					+ "' "	+  &
						"resizeable=0 "  																	+  &
						"moveable=0 "  																	+  &	
						"font.face='"				+ sDrawFontname						+ "' "	+  &
						"font.height='-"  		+ String(iUseFontSize[i])			+ "' "	+  &
						"font.weight='" 			+ String(iBoldPropertie[i])		+ "' "	+  &
						"font.family='"  			+ sDrawFontfamily						+ "' "	+  &
						"font.pitch='"  			+ sDrawFontPitch						+ "' "	+  &
						"font.charset='"  		+ sDrawFontCharSet					+ "' "	+  &
						"font.italic='"			+ String(iItalicPropertie[i])		+ "' "  	+  &
						"background.mode='"		+ String(iBackgroundMode)			+ "' "	+  &
						"background.color='" 	+ String(lBackColor) 				+ "' "	+  &
						"height.autosize=No)"
							
	sResult = dsreport.Modify(sCreate)
	if sResult <> "" Then
		lRet --
	end if
	
	// -------------------------------------------------------------------------------------
	// wir haben ein kleines Problem!
	// wir rechnen zwar die H$$HEX1$$f600$$ENDHEX$$he eines Textfeldes aus und geben die H$$HEX1$$f600$$ENDHEX$$he 
	// explizit mit. Die st$$HEX1$$f600$$ENDHEX$$rt das DW aber nicht die Bohne. Es macht es 
	// einfach gr$$HEX2$$f600df00$$ENDHEX$$er, trotz height.autosize=NO.
	//
	// Also kleiner Kunstgriff. Wir zeichnen ein gef$$HEX1$$fc00$$ENDHEX$$lltest Rechteck zwischen unterer Kante 
	// des Textfeldes und unterer Kante des Stauorts und haben somit die $$HEX1$$fc00$$ENDHEX$$berfl$$HEX1$$fc00$$ENDHEX$$ssige
	// Info $$HEX1$$fc00$$ENDHEX$$bermalt.
	// Das ganze machen wir aber nur f$$HEX1$$fc00$$ENDHEX$$r Texte ungleich der Fu$$HEX1$$df00$$ENDHEX$$zeile. Dies signalisiert
	// der iFooterBorder. Hier steht der max. Index im Array, was Fu$$HEX1$$df00$$ENDHEX$$zeile ist.
	// -------------------------------------------------------------------------------------		
	if i > iFooterBorder AND iBrushHatch = 6 Then
		// nicht bei Anwenden bei den Informationen im Fu$$HEX2$$df002000$$ENDHEX$$des Stauorts
		// und wenn Schraffierung angesagt ist
			
		iPosYTextRec = iTextPosY[i] + iTextHeight[i] 
		
		if bFooterWasPrinted Then
			iPosTextHeight = iStartYFooter - iTextPosY[i] - iFooterHeight - iTextHeight[i]
		else
			iPosTextHeight = lHeightInPixel - (iTextPosY[i] - lYPosInPixel) - iTextHeight[i] - iLineWidth
		end if
		
		if iPosTextHeight > 0 Then		// kleiner 0 macht keinen Sinn
				
			sObjectName 	= "text_rect_" + String(CPU()) + "_" + String(lStowageID)
			sCreate 			= "create rectangle("  																										+  &
									"band=Detail "  																											+  &
									"pointer='Arrow!' "  																									+  &
									"moveable=0 "  																											+  &
									"resizeable=0 "  																											+  &
									"x='" 						+ String(iPosXTextRec) 																	+ "' "	+  &
									"y='" 						+ String(iPosYTextRec) 																	+ "' "	+  &
									"height='" 					+ String(iPosTextHeight)																		+ "' "  	+  &
									"width='" 					+ String(iRectWidth) 																	+ "' "  	+  &
									"name=" 						+ sObjectName 																				+ " "		+  & 
									"brush.hatch='"			+ String(iBrushHatch)				+ "' "  	+  &
									"brush.color='" 			+ String(lBrushColor) 				+ "' "	+  &								
									"pen.style='0' "  																										+  & 
									"pen.width='0' "																											+  & 
									"pen.color='" 				+ String(lBackColor) 																	+ "' "  	+  & 
									"background.mode='0' "  																								+  & 
									"background.color='" 	+ String(lBackColor) + "')"
									
			sResult = dsreport.Modify(sCreate)
		end if
		
	end if
	
	
	if iTextPosY[i] <> iPrevY Then
		iGesamtHeight	= iGesamtHeight + iTextHeight[i]
	end if
	iPrevY 			= iTextPosY[i]
	
	// --------------------------------
	// geht der n$$HEX1$$e400$$ENDHEX$$chste noch rein von
	// der H$$HEX1$$f600$$ENDHEX$$he?
	// --------------------------------
	if i = UpperBound(sTextToPrint[]) Then
		exit
	else
		bDraw = (True = (NOT bStop))
	end if
	
	if (i + 1) <= UpperBound(sTextToPrint[]) Then
		if (iGesamtHeight + iTextHeight[i + 1]) >= iMaxHeight AND iTextPosY[i + 1] > iPrevY Then
			sTextToPrint[i + 1] 	= sGehtNichtRein
			iuo_FontCalc.of_GetTextSize(sGehtNichtRein, sFontName, iUseFontSize[i + 1], false, false, false, ll_TextHeight, ll_TextWidth)
			iTextWidth[i + 1]	 	= Integer(ll_TextWidth)
			iTextHeight[i + 1]	= Integer(ll_TextHeight)
			iTextPosX[i + 1]		= iStartX
			iTextPosY[i + 1]		= iTextPosY[i + 1] - 2		// die P$$HEX1$$fc00$$ENDHEX$$nktchen sind nicht so hoch 
			bStop = True
		end if
	end if	
	i ++
Loop

// ------------
// QAQ-ActionCode
// ------------	
if Not isNull(sQAQActionCode) And Len(TRIM(sQAQActionCode)) > 0 Then
	sQAQActionCode = TRIM(sQAQActionCode)
	uf_drawQAQ()
end if

// ------------
// For-To-Code
// ------------
if Not isNull(sForToCode) And Len(TRIM(sForToCode)) > 0 Then
	sForToCode = TRIM(sForToCode)
	uf_drawForTo()
end if

//yield()
return 0
end function

private function string uf_silbentrennung (string stextzumtrennen);
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

public function integer uf_drawforto ();String	sCreate, &
			sResult

Integer	iTextHeight, &
			iTextPosX, &
			iTextPosY, &
			iUseFontSize

long ll_TextHeight, ll_TextWidth

// ------------------------------
// die Schrift ist immer 1/7 der
// Breite des Stauorts in Pixel
// da wir max 7 Zeichen haben k$$HEX1$$f600$$ENDHEX$$nnen
//
// Falls wir noch den Action-Code
// haben, so starten wir nach 
// der H$$HEX1$$e400$$ENDHEX$$lfte
// ------------------------------
integer iTest
integer	iTextHeightVor

iuo_FontCalc.of_GetOptFontSize(sForToCode, sFontName, iUseFontSize, false, false, false, lHeightInpixel, lWidthInpixel, false)
if iUseFontSize > 10 then iUseFontSize = 10

iuo_FontCalc.of_GetTextSize(sForToCode, sFontName, iUseFontSize, false, false, false, ll_TextHeight, ll_TextWidth)
iTextHeight	= Integer(ll_TextHeight) 

if NOT isNull(sQAQActionCode) AND LEN(TRIM(sQAQActionCode)) > 0 Then
	// unterhalb der Mitte drucken
	iTextPosY 	= lYPosInPixel + (lheightinpixel / 2) + 5
	iTextPosX 	= lXPosInPixel + 5
	iTextHeight = (lHeightInpixel / 2) - 5
	iTest = 1
else
	// genau in die Mitte drucken
	iTextHeightVor = iTextHeight
	iTextPosY 	= lYPosInPixel + (lheightinpixel / 2) - (iTextHeight / 2)
	iTextPosX 	= lXPosInPixel + 5
//	iTextHeight = lHeightInpixel  - 5
	iTest = 2
end if

//if iTextPosY + iTextHeight > 650 then
//	Messagebox("Test:" + string(iTest), "iTextHeightVor:" + string(iTextHeightVor) +"~n" + &
//													"iTextPosY:" + string(iTextPosY) +"~n" + &
//													"lYPosInPixel:" + string(lYPosInPixel) +"~n" + &
//													"lheightinpixel:" + string(lheightinpixel) +"~n" + &
//													"iTextHeight:" + string(iTextHeight))
//	uf_log("[" + f_check_null(sQAQActionCode) + "]" + sCreate)
//	return 0
//end if

sObjectName = "forto_" + String(CPU()) + "_" + String(iTextPosX)
sCreate = "create "																				+  & 
					"text("  																			+  &
					"band=detail "  																	+  &
					"alignment='2' "																	+  &
					"border='0' "  																	+  &
					"color='" 					+ String(lForToTextColor)			+ "' "	+  &
					"height='" 					+ String(iTextHeight)				+ "' "  	+  &
					"width='" 					+ String(lWidthInpixel - 10)		+ "' "  	+  &
					"x='" 						+ String(iTextPosX)					+ "' "	+  &
					"y='" 						+ String(iTextPosY) 					+ "' "	+  &
					"name=" 						+ sObjectName 							+ " "		+  & 
					"text='" 					+ sForToCode		 					+ "' "	+  &
					"resizeable=0 "  																	+  &
					"moveable=0 "  																	+  &	
					"font.face='"				+ sFontName								+ "' "	+  &
					"font.height='"	  		+ String(iUseFontSize)				+ "' "	+  &
					"font.weight='700' "																+  &
					"font.family='2' "  																+  &
					"font.pitch='2' "  																+  &
					"font.charset='0' "  															+  &
					"font.italic='0' "  																+  &
					"background.mode='1' "															+  &
					"height.autosize=No)"

sResult = dsreport.Modify(sCreate)

if Len(Trim(sResult)) > 0 Then
	return -1
end if


return 0

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

public function integer uf_log (string smsg);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

integer iFile

// -----------------------------------------
// l$$HEX1$$e400$$ENDHEX$$uft Lokal
// -----------------------------------------
iFile = FileOpen("grafik.log", LineMode!, Write!, Shared!)
FileWrite(iFile, string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + " " + sMsg)
FileClose(iFile)

return 0
end function

on uo_stowage.create
call super::create
end on

on uo_stowage.destroy
call super::destroy
end on

event constructor;call super::constructor;SetNull(dGewicht)

end event

