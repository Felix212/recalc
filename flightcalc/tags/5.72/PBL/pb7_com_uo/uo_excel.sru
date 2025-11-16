HA$PBExportHeader$uo_excel.sru
forward
global type uo_excel from nonvisualobject
end type
end forward

global type uo_excel from nonvisualobject
end type
global uo_excel uo_excel

type variables
OLEObject 	oExcel
Integer		iLayoutOptimize = 1

String		sFile, &
				sColumns[],&
				sStartColumn
							
Boolean 		bGrouped

datastore	dsHeader, &
				dsDetail, &
				dsGroup[], &
				dsGroupColumns[], &
				dsGroupFooter[]
				
long 			lColumnCount

integer		iBlack 				= 1
integer		iWhite  				= 2
integer		iGrey  				= 15
integer		iYellowLight		= 19
integer		iOrange 				= 44
integer		iBlue					= 55

DataWindow 	oDw

String		sReportHeader1, &
				sReportHeader2, &
				sReportHeader3, &
				sReportHeader4

Boolean		bEnableXLSColomnAsText


// -------------------------------------------
// Microsoft Konstanten
// -------------------------------------------
long xlZero                  	=  2
long xlY                      = 1
long xlXYScatter              = -4169
long xlX                      = -4168
long xlWizardDisplayNever     = 2
long xlWizardDisplayDefault   = 0
long xlWizardDisplayAlways    = 1
long xlVertical               = -4166
long xlValue                  = 2
long xlUpward                 = -4171
long xlUp                     = -4162
long xlTriangle               = 3
long xlTransparent            = 2
long xlTop                    = -4160
long xlThin                   = 2
long xlThick                  = 4
long xlStretch                = 1
long xlStError                = 4
long xlStDev                  = -4155
long xlStar                   = 5
long xlStack                  = 2
long xlSquare                 = 1
long xlSolid                  = 1
long xlSingleAccounting       = 4
long xlSingle                 = 2
long xlShowValue              = 2
long xlShowPercent            = 3
long xlShowLabelAndPercent    = 5
long xlShowLabel              = 4
long xlSeries                 = 3
long xlSemiGray               = 7510
long xlSecondary              = 2
long xlScale                  = 3
long xlRows                   = 1
long xlRight                  = -4152
long xlRadar                  = -4151
long xlPrimary                = 1
long xlPower                  = 4
long xlPolynomial             = 3
long xlPlusValues             = 2
long xlPlus                   = 9
long xlPie                    = 5
long xlPicture                = -4147
long xlPercent                = 2
long xlOutside                = 3
long xlOpaque                 = 3
long xlNotPlotted             = 1
long xlNormal                 = -4143
long xlNone                   = -4142
long xlNoCap                  = 2
long xlNextToAxis             = 4
long xlMovingAvg              = 6
long xlMinusValues            = 3
long xlMinimum                = 4
long xlMinimized              = -4140
long xlMedium                 = -4138
long xlMaximum                = 2
long xlMaximized              = -4137
long xlLow                    = -4134
long xlLogarithmic            = -4133
long xlLinear                 = -4132
long xlLine                   = 4
long xlLightVertical          = 12
long xlLightUp                = 14
long xlLightHorizontal        = 11
long xlLightDown              = 13
long xlLeft                   = -4131
long xlJustify                = -4130
long xlInterpolated           = 3
long xlInside                 = 2
long xlHorizontal             = -4128
long xlHigh                   = -4127
long xlHairline               = 1
long xlGrid                   = 15
long xlGray8                  = 18
long xlGray75                 = -4126
long xlGray50                 = -4125
long xlGray25                 = -4124
long xlGray16                 = 17
long xlFixedValue             = 1
long xlExponential            = 5
long xlDownward               = -4170
long xlDown                   = -4121
long xlDoughnut               = -4120
long xlDoubleAccounting       = 5
long xlDouble                 = -4119
long xlDot                    = -4118
long xlDistributed            = -4117
long xlDiamond                = 2
long xlDefaultAutoFormat      = -1
long xlDashDotDot             = 5
long xlDashDot                = 4
long xlDash                   = -4115
long xlCustom                 = -4114
long xlCross                  = 4
long xlCrissCross             = 16
long xlCorner                 = 2
long xlContinuous             = 1
long xlCombination            = -4111
long xlColumns                = 2
long xlColumn                 = 3
long xlCircle                 = 8
long xlChecker                = 9
long xlCenter                 = -4108
long xlCategory               = 1
long xlCap                    = 1
long xlBuiltIn                = 0
long xlBottom                 = -4107
long xlBoth                   = 1
long xlBar                    = 2
long xlAutomatic              = -4105
long xlArea                   = 1
long xl3DSurface              = -4103
long xl3DPie                  = -4102
long xl3DLine                 = -4101
long xl3DColumn               = -4100
long xl3DBar                  = -4099
long xl3DArea                 = -409
long xlEdgeLeft               = 7
long xlEdgeTop                = 8
long xlEdgeBottom             = 9
long xlEdgeRight              = 10
long xlGeneral						= 1
long xlInsideVertical			= 11
long xlInsideHorizontal			= 12

Boolean	ib_Disable_PlugIn = FALSE
String	is_Disable_PlugIn
String	is_Enable_PlugIn

end variables

forward prototypes
public function integer of_border (long lrow, long lcolumn, boolean btop, boolean bbottom, boolean bleft, boolean bright, integer ibordercolor, integer ibackgroundcolor)
public function string of_checknull_string (string scheck)
public function integer of_optimizerowheight ()
public function string of_groupheaderline (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor)
public function boolean of_groupcheck (long lrow, integer igroup)
public function integer of_exportlinedetail_old (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor)
public function integer of_exportdetail (integer ioffset)
public function string of_exportgroupheader (long lrowdata, integer igroup)
public function integer of_analyse_printed ()
public function integer of_value (long lval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor)
public function integer of_value (string sval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor)
public function integer of_value (datetime dval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor)
public function integer of_find_header ()
public function integer of_analyse_dw ()
public function integer of_border_mass (string srange, boolean btop, boolean bbottom, boolean bleft, boolean bright, integer ibordercolor, integer ibackgroundcolor, boolean browsinside)
public function integer of_optimizecolumnwidth ()
public function string of_exportlinedetail (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor)
public function integer of_analyse_band (string sobject, datastore oband)
public function integer of_export (datawindow odata, string sfilename)
public function integer of_set_header (long lcurrentrow)
public function string of_getheadertext (long lcurrentrow)
public function string of_getfootertext ()
public function integer of_export_as_text (datawindow odata, string sfilename)
end prototypes

public function integer of_border (long lrow, long lcolumn, boolean btop, boolean bbottom, boolean bleft, boolean bright, integer ibordercolor, integer ibackgroundcolor);// ---------------------------------------------
// Rahmen um eine Zelle zeichnen
// ---------------------------------------------

if bLeft = true then
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeLeft).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeLeft).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeLeft).LineStyle = xlNone
end if

if bRight = true then
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeRight).LineStyle = xlContinuous			
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeRight).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeRight).LineStyle = xlNone
end if

if bTop = true then
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeTop).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeTop).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeTop).LineStyle = xlNone
end if

if bBottom = true then
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeBottom).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeBottom).ColorIndex = iBorderColor	
else
	oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Borders(xlEdgeBottom).LineStyle = xlNone
end if

oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Interior.ColorIndex = iBackGroundColor


return 0
end function

public function string of_checknull_string (string scheck);
Long	ll_Found


if isnull(sCheck) then
	return ""
else
	ll_Found = pos(sCheck, "~n")
	If ll_Found > 0 Then
		sCheck = '"' + sCheck + '"'
	End If

return sCheck

end if
	
end function

public function integer of_optimizerowheight ();// ---------------------------------
// Optimal Zeilenh$$HEX1$$f600$$ENDHEX$$he
// ---------------------------------

Long 		a
String 	sRange

For a = 1 to UpperBound(sColumns)
	sRange = String(a) + ":" + String(a) 
	//oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Rows.AutoFit
	//oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).RowHeight = 15
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).HorizontalAlignment = xlGeneral
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).VerticalAlignment = xlTop
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Rows.AutoFit	
Next


return 0
end function

public function string of_groupheaderline (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor);// ------------------------------------------
// Eine Zeile des Headers exportieren 
// ------------------------------------------

String	 			sFont, &
						sType, &
						sColumnType , &
						sValue, &
						sColumn, &
						sDDDWDataColumn, &
						sDDDW_display, &
						sSearch

Boolean 				bBold, 	&
						bItalic 

Integer 				iFontSize

Long 					lValue, &
						lFound

dateTime				dtValue

DataWindowChild 	dwChild

sFont 		= dsDetail.GetItemString(lRowBand, "cFont")
iFontSize	= dsDetail.GetItemNumber(lRowBand, "iFontSize")

if dsDetail.GetItemString(lRowBand, "cbold") = "400" then
	bBold = false
else
	bBold = true
end if

bItalic = false

sType = dsDetail.GetItemString(lRowBand, "cobject_type")

// --------------------------------------------
// Es ist ein Textobject im Detail Band
// --------------------------------------------
if sType = "text" then
	
	sValue = oDW.Describe(dsDetail.GetItemString(lRowBand, "cobject") + ".text")
	//of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
		
end if

// --------------------------------------------
// Es ist eine Column im Detail Band
// --------------------------------------------
if sType = "column" then
	// -----------------------------------------
	// Es ist kein DDDW
	// -----------------------------------------
	if Len(Trim(dsDetail.GetItemString(lRowBand, "dddw_display"))) = 1 then
		
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		
		if sColumnType = "datetime" then
			dtValue = oDW.GetItemDateTime(lRowData, sColumn)
			//of_value(dtValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return string(dtValue)
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			//of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return sValue
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			lValue = oDW.GetItemNumber(lRowData, sColumn)
			//of_value(lValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return string(lValue)
		else
			return ""
		end if
		
	else
	
	// -----------------------------------------
	// Es ist ein DDDW, dann wirds umst$$HEX1$$e400$$ENDHEX$$ndlich
	// -----------------------------------------
	
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		oDW.GetChild(sColumn, dwChild)
		sDDDWDataColumn = oDW.Describe(sColumn + ".dddw.datacolumn")
	
	
		// -----------------------------------------
		// Erstmal dem Wert der in der Column
		// steht auslesen
		// -----------------------------------------
		if sColumnType = "datetime" then
			sValue = String(oDW.GetItemDateTime(lRowData, sColumn), s_app.sdateformat)
			sSearch = "String(" + sDDDWDataColumn +", " + s_app.sdateformat + ")" + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			sSearch = sDDDWDataColumn + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			sValue = String(oDW.GetItemNumber(lRowData, sColumn))
			sSearch = sDDDWDataColumn + "=" + sValue + ""
		end if
			
		// -----------------------------------------
		// Dann den Wert im DDDW suchen und den
		// angezeigten Wert auslesen
		// -----------------------------------------
		//	Messagebox("lFound: " + string(lFound),"sDDDWDataColumn: " + sDDDWDataColumn + &
		//														"~nsSearch: " + sSearch + &
		//														"~n~n~nsValue: " + sValue + &
		//														" ~nsColumnType: " + sColumnType + &
		//														"~nisdddw: " + string(isdddw) + &
		//														"~nsdddw_display: " + sdddw_display)
		
		sDDDW_display = dsDetail.GetItemString(lRowBand, "dddw_display")
		
		lFound = dwChild.Find(sSearch, 1, dwChild.RowCount())
	
		if lFound > 0 then
	
			sColumnType = dwChild.Describe(sDDDW_display + ".ColType")
						
			if sColumnType = "datetime" then
				dtValue = dwChild.GetItemDateTime(lFound, sDDDW_Display)
				//of_value(dtValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return string(dtValue)
			elseif Mid(sColumnType, 1, 4) = "char" then
				sValue = dwChild.GetItemString(lFound, sDDDW_Display)
				//of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return sValue			
			elseif Mid(sColumnType, 1, 7) = "decimal" then
				lValue = dwChild.GetItemNumber(lFound, sDDDW_Display)
				//of_value(lValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return string(lValue)			
			else
				return ""
			end if
			
		else
			
			return ""
			
		end if
	
	end if
	
end if

return ""
end function

public function boolean of_groupcheck (long lrow, integer igroup);// -----------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen ob ein Gruppenwechsel finden mu$$HEX1$$df00$$ENDHEX$$
// -----------------------------------------

Long		 	a, &
				lRows
		
String 		sColumnType, &
				sColumn
		
boolean		bReturn


if dsGroupColumns[iGroup].RowCount() <= 0 then Return false

if lRow = 1 then return True

for lRows = 1 to dsGroupColumns[iGroup].RowCount()
		
	sColumn	   = 	dsGroupColumns[iGroup].GetItemString(lRows, "cobject")
	sColumnType = 	dsGroupColumns[iGroup].GetItemString(lRows, "ccolumn_type")
	
	//Messagebox("", sColumn )
	
	
	if sColumnType = "datetime" then
		if oDw.GetItemDateTime(lRow, sColumn) <> oDw.GetItemDateTime(lRow - 1 , sColumn) then
			return true
		end if
	elseif Mid(sColumnType, 1, 4) = "char" then
		if oDw.GetItemString(lRow, sColumn) <> oDw.GetItemString(lRow - 1 , sColumn) then
			return true
		end if
	elseif Mid(sColumnType, 1, 7) = "decimal" or Mid(sColumnType, 1, 6) = "number" then
		if oDw.GetItemNumber(lRow, sColumn) <> oDw.GetItemNumber(lRow - 1 , sColumn) then
			return true
		end if
	end if
		
next
// messagebox(String(lRow) + " - " + string(lRow - 1) , sColumn + " akt.:    " + oDw.GetItemString(lRow, sColumn) +"~r" + sColumn + " -1:    " + oDw.GetItemString(lRow - 1 , sColumn))
return false
	




end function

public function integer of_exportlinedetail_old (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor);// ------------------------------------------
// Eine Zeile des Headers exportieren 
// ------------------------------------------

String	 			sFont, &
						sType, &
						sColumnType , &
						sValue, &
						sColumn, &
						sDDDWDataColumn, &
						sDDDW_display, &
						sSearch

Boolean 				bBold, 	&
						bItalic 

Integer 				iFontSize

Long 					lValue, &
						lFound

dateTime				dtValue

DataWindowChild 	dwChild

sFont 		= dsDetail.GetItemString(lRowBand, "cFont")
iFontSize	= dsDetail.GetItemNumber(lRowBand, "iFontSize")

if dsDetail.GetItemString(lRowBand, "cbold") = "400" then
	bBold = false
else
	bBold = true
end if

bItalic = false

sType = dsDetail.GetItemString(lRowBand, "cobject_type")

// --------------------------------------------
// Es ist ein Textobject im Detail Band
// --------------------------------------------
if sType = "text" then
	
	sValue = oDW.Describe(dsDetail.GetItemString(lRowBand, "cobject") + ".text")
	of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
		
end if

// --------------------------------------------
// Es ist eine Column im Detail Band
// --------------------------------------------
if sType = "column" then
	// -----------------------------------------
	// Es ist kein DDDW
	// -----------------------------------------
	if Len(Trim(dsDetail.GetItemString(lRowBand, "dddw_display"))) = 1 then
		
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		
		if sColumnType = "datetime" then
			dtValue = oDW.GetItemDateTime(lRowData, sColumn)
			of_value(dtValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return 0
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return 0
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			lValue = oDW.GetItemNumber(lRowData, sColumn)
			of_value(lValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
			return 0
		else
			return -1
		end if
		
	else
	
	// -----------------------------------------
	// Es ist ein DDDW, dann wirds umst$$HEX1$$e400$$ENDHEX$$ndlich
	// -----------------------------------------
	
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		oDW.GetChild(sColumn, dwChild)
		sDDDWDataColumn = oDW.Describe(sColumn + ".dddw.datacolumn")
	
	
		// -----------------------------------------
		// Erstmal dem Wert der in der Column
		// steht auslesen
		// -----------------------------------------
		if sColumnType = "datetime" then
			sValue = String(oDW.GetItemDateTime(lRowData, sColumn), s_app.sdateformat)
			sSearch = "String(" + sDDDWDataColumn +", " + s_app.sdateformat + ")" + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			sSearch = sDDDWDataColumn + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			sValue = String(oDW.GetItemNumber(lRowData, sColumn))
			sSearch = sDDDWDataColumn + "=" + sValue + ""
		end if
			
		// -----------------------------------------
		// Dann den Wert im DDDW suchen und den
		// angezeigten Wert auslesen
		// -----------------------------------------
		//	Messagebox("lFound: " + string(lFound),"sDDDWDataColumn: " + sDDDWDataColumn + &
		//														"~nsSearch: " + sSearch + &
		//														"~n~n~nsValue: " + sValue + &
		//														" ~nsColumnType: " + sColumnType + &
		//														"~nisdddw: " + string(isdddw) + &
		//														"~nsdddw_display: " + sdddw_display)
		
		sDDDW_display = dsDetail.GetItemString(lRowBand, "dddw_display")
		
		lFound = dwChild.Find(sSearch, 1, dwChild.RowCount())
	
		if lFound > 0 then
	
			sColumnType = dwChild.Describe(sDDDW_display + ".ColType")
						
			if sColumnType = "datetime" then
				dtValue = dwChild.GetItemDateTime(lFound, sDDDW_Display)
				of_value(dtValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return 0
			elseif Mid(sColumnType, 1, 4) = "char" then
				sValue = dwChild.GetItemString(lFound, sDDDW_Display)
				of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return 0			
			elseif Mid(sColumnType, 1, 7) = "decimal" then
				lValue = dwChild.GetItemNumber(lFound, sDDDW_Display)
				of_value(lValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
				return 0			
			else
				return -2
			end if
			
		else
			
			return -3
			
		end if
	
	end if
	
end if

return -4
end function

public function integer of_exportdetail (integer ioffset);// ------------------------------------------
// dsDetail nach Excel schreiben
// ------------------------------------------

Long 			lRows, &
				lFound, &
				lPrint

String 		sObject




//For lRows = 1 to lColumnCount
//	
//	lPrint = dsHeader.GetItemNumber(lRows, "nPrint")
//	
//	if lPrint > 0 then
//	
//		lFound = dsDetail.Find("nprint = " + string(lPrint), 1, dsDetail.RowCount())
//		
//		if lFound > 0 then
//			
//			of_exportline(dsHeader, lPrint, iOffSet, lRows, iBlue)
//						
//		end if
//	
//	end if
//	
//	
//Next
//

return 0

end function

public function string of_exportgroupheader (long lrowdata, integer igroup);// ------------------------------------------
// Eine Zeile des Headers exportieren 
// ------------------------------------------

String 	sFont, &
			sType, &
			sColumnType , &
			sValue, &
			sColumn, &
			sOut

Boolean 	bBold, 	&
			bItalic 

Integer 	iFontSize

Long 		lValue, &
			lFound, &
			i

dateTime	dtValue

for i = 1 to dsGroup[iGroup].RowCount()
	
	//-----------------------------------------------------------------------
	// nach Computed Field mit dem Namen "gh_info..." suchen, diese sollen
	// dazu dienen lesbare Gruppierungsinformationen zu exportieren
	//-----------------------------------------------------------------------
	if Mid(dsGroup[iGroup].GetItemString(i, "cobject"), 1, 7) = "gh_info" then
		lFound = 1
				
		sType = dsGroup[iGroup].GetItemString(i, "cobject_type")
		sColumnType = dsGroup[iGroup].GetItemString(i, "ccolumn_type")
		sColumn = dsGroup[iGroup].GetItemString(i, "cobject")
		
		if sType = "compute" then
			
			if sColumnType = "datetime" then
				dtValue = oDW.GetItemDateTime(lRowData, sColumn)
				sOut +=  string(dtValue)
			elseif Mid(sColumnType, 1, 4) = "char" then
				sValue = oDW.GetItemString(lRowData, sColumn)
				sOut +=  sValue
			elseif Mid(sColumnType, 1, 7) = "decimal" then
				lValue = oDW.GetItemDecimal(lRowData, sColumn)
				sOut +=  string(lValue)
			elseif sColumnType = "number" then
				lValue = oDW.GetItemNumber(lRowData, sColumn)
				sOut +=  string(lValue)
			else
				sOut +=  ""
			end if

		end if

		
	end if
	
next

//-----------------------------------------------------------------------
// Es wurde kein Computed Field mit dem Namen "gh_info..." gefunden, dann
// die "reinen" Gruppierungsinformationen anzeigen
//-----------------------------------------------------------------------

if lFound = 0 then

	for i = 1 to dsGroupColumns[iGroup].RowCount()

		sOut += " " 
		sOut += dsGroupColumns[iGroup].GetItemString(i, "cobject") + " = " 
		
		sType = dsGroupColumns[iGroup].GetItemString(i, "cobject_type")
		sColumnType = dsGroupColumns[iGroup].GetItemString(i, "ccolumn_type")
		sColumn = dsGroupColumns[iGroup].GetItemString(i, "cobject")
		
				
		if sColumnType = "datetime" then
			dtValue = oDW.GetItemDateTime(lRowData, sColumn)
			sOut +=  string(dtValue)
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			sOut +=  sValue
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			lValue = oDW.GetItemDecimal(lRowData, sColumn)
			sOut +=  string(lValue)
		elseif sColumnType 				= "number" then
			lValue = oDW.GetItemNumber(lRowData, sColumn)
			sOut +=  string(lValue)
		else
			sOut +=  ""
		end if

	Next
	
end if


return sOut
end function

public function integer of_analyse_printed ();// --------------------------------------------
// Alle Objecte im dsHeader suchen, die
// einen Namensvetter im dsDetail haben
// --------------------------------------------

Long 		lRows, &
			lFound, &
			lY, &
			lDetailHeight
			
String	sSearch, &
			sObject

Integer 	i

dsHeader.Sort()
dsDetail.Sort()

// -------------------------------------------------------------------
// alle Objekte die im Detail.band sind und angezeigt werden zum
// drucken markieren
// -------------------------------------------------------------------

For lRows = 1 to dsDetail.RowCount()	
	
	lDetailHeight = Long(odw.describe("datawindow.detail.height"))
	
	if dsDetail.GetItemNumber(lRows, "ypos") <= lDetailHeight and &
		dsDetail.GetItemNumber(lRows, "ypos") >= 0 and &
		dsDetail.GetItemString(lRows, "cvisible") = "1" and &
		dsDetail.GetItemString(lRows, "cobject") <> "c_selector" then
	
		lColumnCount ++
		dsDetail.SetItem(lRows, "nprint", lColumnCount)

		// -------------------------------------------------------------------
		// im Header Suchen
		// -------------------------------------------------------------------
		sObject = Trim(dsDetail.GetItemString(lRows, "cobject"))
		sSearch = "Mid(cobject, 1, " + String(len(sObject)) +  ") = '" + sObject + "'"
		
		lFound = dsHeader.Find(sSearch, 1, dsHeader.RowCount())
		
		if lFound > 0 then
			dsHeader.SetItem(lFound, "nprint", lColumnCount)
		end if
		
		// -------------------------------------------------------------------
		// in den GroupHeadern Suchen
		// -------------------------------------------------------------------
		
		For i = 1 to 3
			
			sObject = Trim(dsDetail.GetItemString(lRows, "cobject"))
			sSearch = "Mid(cobject, 1, " + String(len(sObject)) +  ") = '" + sObject + "'"
		
			lFound = dsGroup[i].Find(sSearch, 1, dsGroup[i].RowCount())
			
			if lFound > 0 then
				dsGroup[i].SetItem(lFound, "nprint", lColumnCount)
			end if
			
		Next
		
		// -------------------------------------------------------------------
		// in den GroupFootern Suchen
		// -------------------------------------------------------------------
		
		For i = 1 to 3
			
			sObject = Trim(dsDetail.GetItemString(lRows, "cobject"))
			sSearch = "Mid(cobject, 1, " + String(len(sObject)) +  ") = '" + sObject + "'"
		
			lFound = dsGroupFooter[i].Find(sSearch, 1, dsGroupFooter[i].RowCount())
			
			if lFound > 0 then
				dsGroupFooter[i].SetItem(lFound, "nprint", lColumnCount)
			end if
			
		Next
		
	end if	
		
Next

//dsdetail.Print()
//dsheader.print()

return 0
end function

public function integer of_value (long lval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor);
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).value = lVal

oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Name = sFont
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Size = iFontSize
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Bold = bBold
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Italic = bItalic
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.ColorIndex = iColor


return 0
end function

public function integer of_value (string sval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor);
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).value = sVal

oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Name = sFont
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Size = iFontSize
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Bold = bBold
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Italic = bItalic
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.ColorIndex = iColor


return 0
end function

public function integer of_value (datetime dval, long lrow, integer lcolumn, string sfont, integer ifontsize, boolean bbold, boolean bitalic, integer icolor);
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).value = String(dVal, s_app.sDateFormat)

oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Name = sFont
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Size = iFontSize
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Bold = bBold
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.Italic = bItalic
oExcel.application.workbooks(sFile).worksheets(1).Cells(lRow,lColumn).Font.ColorIndex = iColor


return 0
end function

public function integer of_find_header ();// --------------------------------------------
// Alle Objecte im dsHeader suchen, die
// einen Namensvetter im dsDetail haben
// --------------------------------------------

Long 		lRows, &
			lFound, &
			lY, &
			lHeaderHeight, &
			lHeaderPos, &
			lObjectX, &
			lObjectWidth
			
String	sSearch, &
			sObject, &
			sValue, &
			sType

Integer 	i

dsHeader.Sort()
dsDetail.Sort()

// -------------------------------------------------------------------
// alle Objecte die im Detail.band sind und angezeigt werden zum
// drucken markieren
// -------------------------------------------------------------------

For lRows = 1 to dsDetail.RowCount()
		
	if dsDetail.GetItemNumber(lRows, "nprint") > 0 then	
		
		if not bGrouped then
			
			lHeaderHeight = Long(this.oDw.describe("datawindow.header.height"))
			lHeaderPos	  = lHeaderHeight - 30 // Die $$HEX1$$dc00$$ENDHEX$$berschrift wird in den unteren 30 Pixeln erwartet
			lObjectX			= dsDetail.GetItemNumber(lRows, "xpos")
			lObjectWidth	= dsDetail.GetItemNumber(lRows, "iwidth")
			
			
			sSearch  = "xpos >= " + string(lObjectX) 
			sSearch += " and xpos <= "  + string(lObjectX + lObjectWidth) 
			sSearch += " and ypos >= " + string(lHeaderPos) 
			
						
			// -------------------------------------------------------------------
			// im Header Suchen
			// -------------------------------------------------------------------
			lFound = dsHeader.Find(sSearch, 1, dsHeader.RowCount())
			
			if lFound > 0 then
				
				sObject = dsHeader.GetItemString(lFound, "cobject")
				sType   = dsHeader.GetItemString(lFound, "ccolumn_type")
				
				// ----------------------------------------------------------------
				// $$HEX1$$dc00$$ENDHEX$$berschrift !!!
				// ----------------------------------------------------------------
				
				sValue  = Trim(this.oDw.describe(sObject + ".text"))
								
				if len(sValue) < 10 then
					sValue = Mid(sValue + "          ", 1, 10)
				end if
				
				dsDetail.SetItem(lRows, "cheader_info", sValue)
				
			end if
			
			
		else
			
			// -------------------------------------------------------------------
			// in den GroupHeadern Suchen
			// -------------------------------------------------------------------
			For i = 1 to 3
								
				lHeaderHeight = Long(this.oDw.describe("datawindow.header." + string(i) + ".height"))
					
				lHeaderPos	  = lHeaderHeight - 30 // Die $$HEX1$$dc00$$ENDHEX$$berschrift wird in den unteren 30 Pixeln erwartet
				lObjectX			= dsDetail.GetItemNumber(lRows, "xpos")
				lObjectWidth	= dsDetail.GetItemNumber(lRows, "iwidth")
			
				sSearch  = "xpos >= " + string(lObjectX) 
				sSearch += " and xpos <= "  + string(lObjectX + lObjectWidth) 
				sSearch += " and ypos >= " + string(lHeaderPos) 
							
				lFound = dsGroup[i].Find(sSearch, 1, dsGroup[i].RowCount())
			
				if lFound > 0 then
					sObject = dsGroup[i].GetItemString(lFound, "cobject")
					
					sValue  = Trim(this.oDw.describe(sObject + ".text"))
															
					if len(sValue) < 10 then
						sValue = Mid(sValue + "          ", 1, 10)
					end if
					
					dsDetail.SetItem(lRows, "cheader_info", sValue)
					
				end if
				
			Next
			
		end if
		
	end if
		
Next


//dsdetail.Print()
//dsheader.print()

return 0
end function

public function integer of_analyse_dw ();//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sBand, &
			sSyntax

long 		lInsert

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
 sDWObjects = oDW.describe("datawindow.objects")

// ---------------------------------------
// Nachschaun, ob gruppiert ist
// ---------------------------------------

sSyntax = odw.Describe("datawindow.syntax")

// ---------------------------------------
// Maximal f$$HEX1$$fc00$$ENDHEX$$r 3 Gruppierungen
// ---------------------------------------

For i = 1 to 3
	
	// -----------------------------------------------
	// Im Syntax nach group(level=1
	// 					group(level=2
	// 					group(level=3    suchen
	// -----------------------------------------------
	iPos = Pos(sSyntax, "group(level=" + string(i))
	
	if iPos > 0 then
		
		bGrouped = true	
		
		// -----------------------------------------------
		// Wenn gefunden den String an by=( analysieren
		// hier finden sich die Columns nach denen
		// gruppiert ist
		// -----------------------------------------------
		iPos = Pos(sSyntax, "by=(", iPos)
		
		if iPos > 0 then
						
			iPos += Len("by(") + 1
			
			For j = iPos to Len(sSyntax)
				
				if Mid(sSyntax, j, 1) <> '"' then
					
					if Mid(sSyntax, j, 1) = " " then
						lInsert = dsGroupColumns[i].Insertrow(0)
						dsGroupColumns[i].SetItem(lInsert, "cobject", sTemp)
						dsGroupColumns[i].SetItem(lInsert, "ccolumn_type", odw.Describe(sTemp + ".ColType"))				
						sTemp = ""
						
					elseif Mid(sSyntax, j, 1) = ")" then
						exit
					else
						sTemp += Mid(sSyntax, j, 1)
					end if
					
				end if
				
			Next
			
		end if
		
	end if
	
Next 


// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to len(sDWObjects)
	
	if Mid(sDWObjects, i, 1) <> char(9) then
		
		sTemp += Mid(sDWObjects, i, 1)
		
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if len(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if

// ---------------------------------------
// Die Objekte nach Header und Detail Band
// trennen
// ---------------------------------------

for i = 1 to UpperBound(sObjects)
	
	sBand = odw.Describe(sObjects[i] + ".band")
	
	if sBand = "header" then
		
		of_analyse_band(sObjects[i], dsHeader)		
				
	elseif sBand = "detail" then
		
		of_analyse_band(sObjects[i], dsDetail)
		
	elseif sBand = "header.1" then
		
		of_analyse_band(sObjects[i], dsGroup[1])
		
	elseif sBand = "header.2" then
		
		of_analyse_band(sObjects[i], dsGroup[2])
		
	elseif sBand = "header.3" then
		
		of_analyse_band(sObjects[i], dsGroup[3])
		
	elseif sBand = "header.4" then
		
		uf.mbox("Achtung", "Zuviele Gruppierungen im DataWindow. ", StopSign!)
		return 0
		
	elseif sBand = "trailer.1" then
		
		of_analyse_band(sObjects[i], dsGroupFooter[1])
		//f_print_datastore(dsGroupFooter[1])
	end if
	
Next

//f_print_datastore(dsGroup[1])

// ---------------------------------------
// Die Objekte suchen, die gedruckt werden 
// sollen
// ---------------------------------------
of_analyse_printed()
of_find_header()

// f_print_datastore(dsGroupFooter[1])
// f_print_datastore(dsDetail)
//dsHeader.Print()
//dsDetail.Print()

return 0
end function

public function integer of_border_mass (string srange, boolean btop, boolean bbottom, boolean bleft, boolean bright, integer ibordercolor, integer ibackgroundcolor, boolean browsinside);// ---------------------------------------------
// Rahmen um eine Zelle zeichnen
// ---------------------------------------------

if bLeft = true then
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeLeft).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeLeft).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeLeft).LineStyle = xlNone
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeLeft).ColorIndex = xlAutomatic
end if

if bRight = true then
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeRight).LineStyle = xlContinuous			
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeRight).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeRight).LineStyle = xlNone
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeRight).ColorIndex = xlAutomatic
end if

if bTop = true then
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeTop).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeTop).ColorIndex = iBorderColor
else
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeTop).LineStyle = xlNone
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeTop).ColorIndex = xlAutomatic
end if

if bBottom = true then
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeBottom).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeBottom).ColorIndex = iBorderColor	
else
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeBottom).LineStyle = xlNone
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlEdgeBottom).ColorIndex = xlAutomatic	
end if 

if bRowsInside = true then
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlInsideVertical).LineStyle = xlContinuous
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlInsideVertical).ColorIndex = iBorderColor	
	//oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlInsideHorizontal).LineStyle = xlContinuous
	//oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Borders(xlInsideHorizontal).ColorIndex = iBorderColor	
end if

oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Interior.ColorIndex = iBackGroundColor


return 0
end function

public function integer of_optimizecolumnwidth ();// ---------------------------------
// Optimal Spaltenbreite
// ---------------------------------

Long 		a, &
			lWidth, &
			lHeight
String 	sRange

// -------------------------------------
// Spaltenbreite optimieren
// und Gesamtbreite merken f$$HEX1$$fc00$$ENDHEX$$r die
// Headeranzeige
// -------------------------------------
For a = 1 to lColumnCount
	sRange = sColumns[a] + string(1) + ":" + sColumns[a] + "10000" 
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Columns.AutoFit
	lWidth += long(oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Columns.Width)
Next


// ---------------------------------
// Firlefanz ... weglassen
// ---------------------------------
// lWidth += 5
// ---------------------------------
// Enspricht ca. einem A4 Hochformat
// ---------------------------------
//if lWidth < 416 then
//	lWidth = 416
// ---------------------------------	
// Enspricht ca. einem A4 Querformat
// ---------------------------------
//elseif lWidth > 645 then
//	lWidth = 645
//end if

// immer Querformat
//lWidth = 645
//lHeight = oExcel.application.workbooks(sFile).worksheets(1).Shapes("HeaderBackGround").Height
//oExcel.application.workbooks(sFile).worksheets(1).Shapes("HeaderBackGround").Width = lWidth
//oExcel.application.workbooks(sFile).worksheets(1).Shapes("HeaderBackGround").Height = lHeight
//oExcel.application.workbooks(sFile).worksheets(1).Shapes("Picture 2").Left = lWidth - &
//																									  oExcel.application.workbooks(sFile).worksheets(1).Shapes("Picture 2").Width &
//																									  - 5			

return 0
end function

public function string of_exportlinedetail (long lrowband, long lrowexcel, long lcolumnexcel, long lrowdata, integer icolor);// ------------------------------------------
// Eine Zeile des Headers exportieren 
// ------------------------------------------

String	 			sFont, &
						sType, &
						sColumnType , &
						sValue, &
						sColumn, &
						sDDDWDataColumn, &
						sDDDW_display, &
						sSearch

Boolean 				bBold, 	&
						bItalic 

Integer 				iFontSize

Long 					lValue, &
						lFound

decimal				decValue

dateTime				dtValue

date 					dValue

DataWindowChild 	dwChild

sFont 		= dsDetail.GetItemString(lRowBand, "cFont")
iFontSize	= dsDetail.GetItemNumber(lRowBand, "iFontSize")

if dsDetail.GetItemString(lRowBand, "cbold") = "400" then
	bBold = false
else
	bBold = true
end if

bItalic = false

sType 		= dsDetail.GetItemString(lRowBand, "cobject_type")

// --------------------------------------------
// Es ist ein Textobject im Detail Band
// --------------------------------------------
if sType = "text" then
	
	sValue = oDW.Describe(dsDetail.GetItemString(lRowBand, "cobject") + ".text")
	//of_value(sValue, lRowExcel, lColumnExcel, sFont, iFontSize, bBold, bItalic, iColor)
		
end if

// --------------------------------------------
// Es ist eine Computed Field im Detail Band
// --------------------------------------------
if sType = "compute" then
	
	sColumn 		= dsDetail.GetItemString(lRowBand, "cobject")
	sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")	
	//Messagebox("", sColumn + " in Zeile: " + string(lRowData) + " ist vom Datentyp " + sColumnType)
		
	if sColumnType = "datetime" then
		dtValue = oDW.GetItemDateTime(lRowData, sColumn)
		return string(dtValue)
	elseif sColumnType = "date" then
		dValue = oDW.GetItemDate(lRowData, sColumn)
		return string(dValue)
	elseif Mid(sColumnType, 1, 4) = "char" then
		sValue = oDW.GetItemString(lRowData, sColumn)
		return sValue
	elseif Mid(sColumnType, 1, 7) = "decimal" then
		decValue = oDW.GetItemDecimal(lRowData, sColumn)
		//Messagebox("", string(decValue))
		return string(decValue, "0.000")
	elseif sColumnType = "number" then
		
		// Checken, obs Nachkommestellen hat
		decValue = oDW.GetItemDecimal(lRowData, sColumn)
		if decValue - Truncate(decValue, 0) <> 0.000 then
			return string(decValue, "0.000")
		end if 
		
		lValue = oDW.GetItemNumber(lRowData, sColumn)
		return string(lValue)
	else
		return ""
	end if

end if

// --------------------------------------------
// Es ist eine Column im Detail Band
// --------------------------------------------
if sType = "column" then
		
	// -----------------------------------------
	// Es ist kein DDDW
	// -----------------------------------------
	if Len(Trim(dsDetail.GetItemString(lRowBand, "dddw_display"))) = 1 then
		
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		
		//Messagebox("", sColumn + " in Zeile: " + string(lRowData) + " ist vom Datentyp " + sColumnType)
		
		if sColumnType = "datetime" then
			dtValue = oDW.GetItemDateTime(lRowData, sColumn)
			return string(dtValue)
		elseif sColumnType = "date" then
			dValue = oDW.GetItemDate(lRowData, sColumn)
			return string(dValue)
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			return sValue
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			decValue = oDW.GetItemDecimal(lRowData, sColumn)
			return string(decValue)
		elseif sColumnType = "number" then
			// Checken, obs Nachkommestellen hat
			decValue = oDW.GetItemDecimal(lRowData, sColumn)
			if decValue - Truncate(decValue, 0) <> 0.000 then
				return string(decValue, "0.000")
			end if 

			lValue = oDW.GetItemNumber(lRowData, sColumn)
			return string(lValue)
		else
			return ""
		end if
		
	else
	
	// -----------------------------------------
	// Es ist ein DDDW, dann wirds umst$$HEX1$$e400$$ENDHEX$$ndlich
	// -----------------------------------------
	
		sColumnType = dsDetail.GetItemString(lRowBand, "ccolumn_type")
		sColumn = dsDetail.GetItemString(lRowBand, "cobject")
		oDW.GetChild(sColumn, dwChild)
		sDDDWDataColumn = oDW.Describe(sColumn + ".dddw.datacolumn")
	
	
		// -----------------------------------------
		// Erstmal dem Wert der in der Column
		// steht auslesen
		// -----------------------------------------
		if sColumnType = "datetime" then
			sValue = String(oDW.GetItemDateTime(lRowData, sColumn), s_app.sdateformat)
			sSearch = "String(" + sDDDWDataColumn +", " + s_app.sdateformat + ")" + "='" + sValue + "'"
		elseif sColumnType = "date" then
			sValue = String(oDW.GetItemDate(lRowData, sColumn), s_app.sdateformat)
			sSearch = "String(" + sDDDWDataColumn +", " + s_app.sdateformat + ")" + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 4) = "char" then
			sValue = oDW.GetItemString(lRowData, sColumn)
			sSearch = sDDDWDataColumn + "='" + sValue + "'"
		elseif Mid(sColumnType, 1, 7) = "decimal" then
			sValue = String(oDW.GetItemDecimal(lRowData, sColumn))
			sSearch = sDDDWDataColumn + "=" + sValue + ""
		elseif Mid(sColumnType, 1, 6) = "number" then
			sValue = String(oDW.GetItemNumber(lRowData, sColumn))
			sSearch = sDDDWDataColumn + "=" + sValue + ""
		end if
			
		// -----------------------------------------
		// Dann den Wert im DDDW suchen und den
		// angezeigten Wert auslesen
		// -----------------------------------------
		//	Messagebox("lFound: " + string(lFound),"sDDDWDataColumn: " + sDDDWDataColumn + &
		//														"~nsSearch: " + sSearch + &
		//														"~n~n~nsValue: " + sValue + &
		//														" ~nsColumnType: " + sColumnType + &
		//														"~nisdddw: " + string(isdddw) + &
		//														"~nsdddw_display: " + sdddw_display)
		
		sDDDW_display = dsDetail.GetItemString(lRowBand, "dddw_display")
		
		lFound = dwChild.Find(sSearch, 1, dwChild.RowCount())
	
		if lFound > 0 then
	
			sColumnType = dwChild.Describe(sDDDW_display + ".ColType")
						
			if sColumnType = "datetime" then
				dtValue = dwChild.GetItemDateTime(lFound, sDDDW_Display)
				return string(dtValue)
			elseif sColumnType = "date" then
				dValue = dwChild.GetItemDate(lFound, sDDDW_Display)
				return string(dValue)
			elseif Mid(sColumnType, 1, 4) = "char" then
				sValue = dwChild.GetItemString(lFound, sDDDW_Display)
				return sValue			
			elseif Mid(sColumnType, 1, 7) = "decimal" then
				decValue = dwChild.GetItemDecimal(lFound, sDDDW_Display)
				return string(decValue)			
			elseif Mid(sColumnType, 1, 6) = "number" then
				lValue = dwChild.GetItemNumber(lFound, sDDDW_Display)
				return string(lValue)			
			else
				return ""
			end if
			
		else
			
			return ""
			
		end if
	
	end if
	
end if

return ""
end function

public function integer of_analyse_band (string sobject, datastore oband);long 		lRow
string 	sType
Integer	li_Succ

sType = odw.Describe(sObject + ".type")

if sType <> "column" and &
	sType <> "text" and &
	sType <> "compute" then
	return 0
	
end if

if odw.Describe(sObject + ".tag") = "DontShow" then return 0

lRow = oBand.InsertRow(0)
oBand.SetItem(lRow, "cobject", sObject)
oBand.SetItem(lRow, "cobject_type",sType)
oBand.SetItem(lRow, "xpos", Long(odw.Describe(sObject + ".X")))
oBand.SetItem(lRow, "ypos", Long(odw.Describe(sObject + ".Y")))
oBand.SetItem(lRow, "iwidth", Long(odw.Describe(sObject + ".width")))
oBand.SetItem(lRow, "iheight", Long(odw.Describe(sObject + ".height")))
oBand.SetItem(lRow, "cfont", odw.Describe(sObject + ".font.face") )
oBand.SetItem(lRow, "ifontsize", Long(odw.Describe(sObject + ".font.height")) * -1 )
oBand.SetItem(lRow, "cbold", odw.Describe(sObject + ".font.weight") )
oBand.SetItem(lRow, "citalic", odw.Describe(sObject + ".font.italic") )
oBand.SetItem(lRow, "nprint", 0 )
oBand.SetItem(lRow, "cvisible", odw.Describe(sObject + ".visible") )
oBand.SetItem(lRow, "ccolumn_type", odw.Describe(sObject + ".coltype") )
oBand.SetItem(lRow, "dddw_display", odw.Describe(sObject + ".dddw.displaycolumn"))

// ****************************************************************************
// 2009-03-11 Bugfix 
// O. Tappe: es gibt Betriebe, die St$$HEX1$$fc00$$ENDHEX$$cklistennummer NUMERISCH !!!
// ben$$HEX1$$f600$$ENDHEX$$tigen, daher keine f$$HEX1$$fc00$$ENDHEX$$hrenden Zeroes mehr
// ****************************************************************************
// 2009-03-16
// Die Funktionalit$$HEX1$$e400$$ENDHEX$$t ist jetzt $$HEX1$$fc00$$ENDHEX$$ber user setup steuerbar
// ****************************************************************************

If bEnableXLSColomnAsText Then
	If Upper(odw.Describe(sObject + ".tag")) = "TEXT" Then
		li_Succ = oBand.SetItem(lRow, "calphanum", 1 )
	End if
	// Alle potentiellen Columns, welche St$$HEX1$$fc00$$ENDHEX$$cklistennummern zeigen, sollen Text sein
	If pos(lower(sObject), "cpackinglist") > 0 Then
		li_Succ = oBand.SetItem(lRow, "calphanum", 1 )
	End if
End If

return 0
end function

public function integer of_export (datawindow odata, string sfilename);/*
* Objekt : uo_excel
* Methode: of_export (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 31.03.2010
*
* Argument(e):
* datawindow odata
*	 string sfilename
*
* Beschreibung:		Connect zu Excel und export
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	31.03.2010		Erstkommentar; M$$HEX1$$f600$$ENDHEX$$glichkeit f$$HEX1$$fc00$$ENDHEX$$r (ext.) disable der Essbase Plug-Ins hinzu
*
*
* Return: integer
*
*/

Integer 		iResult, &
				iOpen, &
				I, &
				iGroupChecker = 0 , &
				iWatermark
				
				
string 		sPath, &
				sSaveName, &
				sObject, &
				sMsg, &
				sFileTypes, &
				sRange, &
				sDir, &
				sGroupHeaderRanges[],&
				sGroupFooterRanges[],&
				sGroupHeaderValues[],&
				sGroupFooterValues[],&
				sRegSubKeys[]
				
Long 			lRows, &
				lFound, &
				lPrint, &
				lColumn, &
				a

Integer 		iOffSet, &
				iStart, &
				iGroupCount, &
				iHeader
String		ls_Temp
Long			ll_Start, ll_Stop

Blob			bOut

odw = oData
sDir = f_GetCurrentDirectory()


if sFileName = "" then
	sFileTypes = "Excel Files (*.XLS), *.XLS"
	iOpen = GetFileSaveName(uf.translate("Speichern als"),sSaveName, sFile, "XLS", sFileTypes)
else
	sSaveName = sFileName
	iOpen = 1
end if
	
f_SetCurrentDirectory(sDir)

sPath = sDir + "\cbase_excel.dll"
sFile = "cbase_excel.dll"

if not FileExists(sPath) then
	uf.mbox("Achtung", "Excel Masterdatei nicht gefunden", StopSign!)
	return 0
end if

if FileExists(sSaveName) then
	iOpen = uf.mbox("Achtung", "Vorhandene Datei ${" + sSaveName + "} $$HEX1$$fc00$$ENDHEX$$berschreiben ?" , Question!, YesNo!, 1)
end if

if iOpen <> 1 then Return 0
	
Open(w_progress)
w_progress.wf_settitle(uf.Translate("Exceldatei wird erzeugt"))
w_progress.wf_setmessage(uf.Translate("Analysiere Daten"))
w_progress.wf_setStatus(uf.Translate("bitte warten"))
w_progress.wf_setMin(1)
w_progress.wf_setMax(oDW.RowCount())
w_progress.wf_setPosition(1)

// -------------------------
// Datawindow analysieren
// -------------------------
of_analyse_dw()

//f_print_datastore(dsHeader)
//f_print_datastore(dsDetail)
//f_print_datastore(dsGroup[1])

// ------------------------------------
// lColumnCount muss ver$$HEX1$$e400$$ENDHEX$$ndert werden
// wenn sStartColumn <> A ist. 
// Es muss die Position im Alphabet - 1 
// dazu addiert werden
// ------------------------------------
sStartColumn = "B"
lColumnCount += 1

w_progress.wf_setmessage(uf.Translate("OLE Verbindung wird erstellt"))

SetPointer(HourGlass!)
oExcel = CREATE OLEObject


// ------------------------------------------------
// Plug-in DEAKTIVIEREN
// ------------------------------------------------
If ib_Disable_PlugIn = TRUE Then
	ll_Start = cpu()
	Run(is_Disable_PlugIn, Minimized!)
	// Wait
	Yield()
	//Sleep(3)
	f_sleep(3)
	ll_Stop = cpu()
	//uf.mbox("Info", "Sleep time " + String(ll_Stop - ll_Start))
End If



// --------------------------------------------------
// OLE Objekt erstellen
// --------------------------------------------------
iResult = oExcel.ConnectToNewObject("Excel.Application") 
SetPointer(Arrow!)			
	
if iResult = 0 then
	
	ClipBoard(" ")

	OleObject oWorkBook
	oWorkBook = CREATE OleObject
	oWorkBook = oExcel.Workbooks.Open(sPath)

	OleObject oActiveSheet
	oActiveSheet = CREATE OleObject
	oActiveSheet = oWorkBook.ActiveSheet

	//--------------------------------------------------------
	// Header wegschreiben
	//--------------------------------------------------------
	
	w_progress.wf_setmessage(uf.Translate("Kopfzeile wird geschrieben"))

	oExcel.Application.DisplayAlerts = False
	
	iStart = 7
	iOffset = iStart

	oActiveSheet.Shapes("Text Box 6").select
	oExcel.Selection.Characters.Text = this.sReportHeader1
	oActiveSheet.Shapes("Text Box 7").select
	oExcel.Selection.Characters.Text = this.sReportHeader2
	oActiveSheet.Shapes("Text Box 11").select
	oExcel.Selection.Characters.Text = this.sReportHeader3
	oActiveSheet.Shapes("Text Box 9").select
	oExcel.Selection.Characters.Text = this.sReportHeader4

	
	// ------------------------------------------------
	// Formatiere Spalte explizit als Text
	Long	ll_Count
	String	ls_Columns
	For ll_Count = 1 To dsdetail.rowcount()
		lPrint = dsDetail.GetItemNumber(ll_Count, "nprint")			
		if lPrint > 0 then
			if dsDetail.GetItemNumber(ll_Count, "calphanum") = 1 Then	
				ls_Columns = sColumns[lPrint + 1] + ":" + sColumns[lPrint + 1]
				oActiveSheet.Columns(ls_Columns).Select
				oExcel.Selection.NumberFormat = "@"
			End If
		End If
	Next
	// ------------------------------------------------

	
	//--------------------------------------------------------
	// Detail's wegschreiben
	//--------------------------------------------------------
	w_progress.wf_setmessage(uf.Translate("Daten werden geschrieben"))

	bOut = Blob("")
	
	for a = 1 to oDW.RowCount()
		
		iWatermark ++
		
		if iWaterMark = 1000 and Isvalid(w_progress) then
			
			Close(w_progress)
			Open(w_progress)
			w_progress.wf_settitle(uf.Translate("Exceldatei wird erzeugt"))
			w_progress.wf_setmessage(uf.Translate("Analysiere Daten"))
			w_progress.wf_setStatus(uf.Translate("bitte warten"))
			w_progress.wf_setMin(1)
			w_progress.wf_setMax(oDW.RowCount())
			w_progress.wf_setposition(a)
			iWatermark = 0
			
		end if

		
		w_progress.wf_setstatus(uf.Translate("Zeile ${" + string(a) + "} von ${" + String(oDW.RowCount()) + "}" ))
		w_progress.wf_setposition(a)
		
		iOffset ++
		
		if bGrouped then
		
			if of_GroupCheck(a, 1) = true then 
				
				if a > 1 then
				
					bOut += Blob(of_checknull_string(of_getfootertext()))
					bOut += Blob("~r~n")
					sGroupFooterRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
					iOffset ++
					
				end if
				

				iGroupCount ++
				
				bOut += Blob(of_checknull_string(of_exportgroupheader(a, 1)))
				bOut += Blob("~r~n")
				sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++
				
				bOut += Blob(of_getheadertext(a))
				bOut += Blob("~r~n")
				sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++					
				
			end if	
				
			if of_GroupCheck(a, 2) = true then 
				iGroupChecker = 0 
				bOut += Blob(of_checknull_string(of_exportgroupheader(a, 2)))
				bOut += Blob("~r~n")
				iGroupCount ++
				sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++
				
				bOut += Blob(of_getheadertext(a))
				bOut += Blob("~r~n")
				sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++					
				
			end if	

			if of_GroupCheck(a, 3) = true then 
				iGroupChecker = 0 
				bOut += Blob(of_checknull_string(of_exportgroupheader(a, 3)))
				bOut += Blob("~r~n")
				iGroupCount ++
				sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++
				
				bOut += Blob(of_getheadertext(a))
				bOut += Blob("~r~n")
				sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++					

			end if	
			
		else
			
			// -----------------------------------------------------------
			// einmalig die Spalten$$HEX1$$fc00$$ENDHEX$$berschriften eintragen
			// -----------------------------------------------------------
			if iHeader = 0 then
				iHeader ++
				bOut += Blob(of_getheadertext(a))
				bOut += Blob("~r~n")
				sGroupHeaderValues[iHeader] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				// sGroupFooterValues[iHeader] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffSet ++					
			end if
			
		end if
		
		// -----------------------------------------------------------
		// das Detailband wegschreiben
		// -----------------------------------------------------------
		for lRows = 1 to dsDetail.RowCount()
							
			lPrint = dsDetail.GetItemNumber(lRows, "nprint")
			
			if lPrint > 0 then
			
				sObject = dsDetail.GetItemString(lRows, "cobject")
				ls_Temp = of_exportlineDetail(lRows, iOffSet, lPrint, a, iBlack)
				ls_Temp = of_checknull_string(ls_Temp) + char(9)
				bOut += Blob(ls_Temp)
//				bOut += Blob(of_checknull_string(of_exportlineDetail(lRows, iOffSet, lPrint, a, iBlack)) + char(9))
				
			end if
			
		Next
		
		bOut += Blob("~r~n")
		
	Next


	if bGrouped then
		
		iOffset ++
		bOut +=  Blob(of_checknull_string(of_getfootertext()))
		bOut += Blob("~r~n")
		sGroupFooterRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
		
		
	end if	

	
	// ----------------------------------------
	// Den String in den Zwischspeicher
	// legen und das in die Excel-Tabelle
	// kopieren
	// ----------------------------------------
	ClipBoard(String(bOut))
	sRange = sStartColumn + String(iStart + 1 ) + ":" + sColumns[lColumnCount] + String(iOffSet)
	oActiveSheet.Range(sRange).Select
	oActiveSheet.Paste()
	ClipBoard(" ")
	
	if this.iLayoutOptimize = 1 then 
	
		of_border_mass(sRange, True, True, True, True, iBlack, iWhite, True )	
		
		// ----------------------------------------
		// GroupHeader & Foorter formatieren
		// ----------------------------------------
		for a = 1 to UpperBound(sGroupHeaderRanges)
			oExcel.application.workbooks(sFile).worksheets(1).Range(sGroupHeaderRanges[a]).Font.Bold = True
			of_border_mass(sGroupHeaderRanges[a], True, True, True, True, iBlack, iYellowLight, False)
			oActiveSheet.Range(sGroupHeaderRanges[a]).Select
			oActiveSheet.Range(sGroupHeaderRanges[a]).Merge
		Next
		
		for a = 1 to UpperBound(sGroupFooterRanges)
			if sGroupFooterRanges[a] <> "" then
			oExcel.application.workbooks(sFile).worksheets(1).Range(sGroupFooterRanges[a]).Font.Bold = True
			of_border_mass(sGroupFooterRanges[a], True, True, True, True, iBlack, iYellowLight, False)
			end if
		Next
		
		for a = 1 to UpperBound(sGroupHeaderValues)
			oExcel.application.workbooks(sFile).worksheets(1).Range(sGroupHeaderValues[a]).Font.Bold = True
			of_border_mass(sGroupHeaderValues[a], True, True, True, True, iBlack, iYellowLight, False)
		Next
	
	end if

	// ----------------------------------------
	// Spaltenh$$HEX1$$f600$$ENDHEX$$he/breite und Fu$$HEX1$$df00$$ENDHEX$$zeile
	// formatieren
	// ----------------------------------------
	w_progress.wf_setmessage(uf.Translate("Optimiere Spaltenbreiten"))	
	of_OptimizeColumnWidth()
	w_progress.wf_setmessage(uf.Translate("Optimiere Zeilenh$$HEX1$$f600$$ENDHEX$$hen"))	
	of_OptimizeRowHeight()

	
	sRange = sStartColumn + String(iStart + 1 ) + ":" + sColumns[lColumnCount] + String(iOffSet)
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).Rows.AutoFit
	oExcel.application.workbooks(sFile).worksheets(1).Range(sRange).VerticalAlignment = xlTop
	
	
	oExcel.application.workbooks(sFile).worksheets(1).PageSetup.LeftFooter = "&8" + s_app.sOrga


	// ----------------------------------------
	// Den Passwortschutz aktivieren
	// ----------------------------------------
	// oExcel.application.workbooks(sFile).worksheets(1).Protect("galileo63&zb41987|itd2712")		
	oActiveSheet.Range("A1:A1").select
	oExcel.application.workbooks(1).saveas(sSaveName)
	oExcel.application.workbooks(1).close()		
	oExcel.application.quit()
	oExcel.DisconnectObject()
	DESTROY oExcel
	
	if isvalid(w_progress) then close (w_progress)
			
else

	uf.mbox("Achtung", "Es konnte keine Verbindung zu Excel hergestellt werden ! ~rWahrscheinlich ist Excel auf Ihrem System nicht installiert ! ~r" ,  StopSign!)
	DESTROY oExcel
	if isvalid(w_progress) then close (w_progress)
	return -1
	
end if

if isvalid(w_progress) then close (w_progress)
	
// f_print_datastore(dsDetail)

// ------------------------------------------------
// Plug-in reaktivieren
// ------------------------------------------------
If ib_Disable_PlugIn = TRUE Then
	If Trim(is_Enable_PlugIn) > "" Then
		Run(is_Enable_PlugIn, Minimized!)
	End If
End If



return 0
end function

public function integer of_set_header (long lcurrentrow);// --------------------------------------------
// Alle Objecte im dsHeader suchen, die
// einen Namensvetter im dsDetail haben
// --------------------------------------------

Long 		lRows, &
			lFound, &
			lY, &
			lHeaderHeight, &
			lHeaderPos, &
			lObjectX, &
			lObjectWidth
			
String	sSearch, &
			sObject, &
			sValue, &
			sType

Integer 	i

dsHeader.Sort()
dsDetail.Sort()

// -------------------------------------------------------------------
// alle Objecte die im Detail.band sind und angezeigt werden zum
// drucken markieren
// -------------------------------------------------------------------

For lRows = 1 to dsDetail.RowCount()
		
	if dsDetail.GetItemNumber(lRows, "nprint") > 0 then	
		
		if not bGrouped then
			
			lHeaderHeight = Long(this.oDw.describe("datawindow.header.height"))
			lHeaderPos	  = lHeaderHeight - 30 // Die $$HEX1$$dc00$$ENDHEX$$berschrift wird in den unteren 30 Pixeln erwartet
			lObjectX			= dsDetail.GetItemNumber(lRows, "xpos")
			lObjectWidth	= dsDetail.GetItemNumber(lRows, "iwidth")
			
			
			sSearch  = "xpos >= " + string(lObjectX) 
			sSearch += " and xpos <= "  + string(lObjectX + lObjectWidth) 
			sSearch += " and ypos >= " + string(lHeaderPos) 
			
			// -------------------------------------------------------------------
			// im Header Suchen
			// -------------------------------------------------------------------
			lFound = dsHeader.Find(sSearch, 1, dsHeader.RowCount())
			
			if lFound > 0 then
				
				sObject = dsHeader.GetItemString(lFound, "cobject")
				sType   = dsHeader.GetItemString(lFound, "ccolumn_type")
				
				if mid(sType, 1, 4) = "char" then
					sValue = oDW.GetItemString(lCurrentRow, sObject)				
				elseif sType = "number" then
					sValue = String(oDW.GetItemNumber(lCurrentRow, sObject))
				else
					sValue  = Trim(this.oDw.describe(sObject + ".text"))
				end if
				
//				// ----------------------------------------------------------------
//				// $$HEX1$$dc00$$ENDHEX$$berschrift !!!
//				// ----------------------------------------------------------------
//				
//				sValue  = Trim(this.oDw.describe(sObject + ".text"))
								
				if len(sValue) < 10 then
					sValue = Mid(sValue + "          ", 1, 10)
				end if
				
				dsDetail.SetItem(lRows, "cheader_info", sValue)
				
			end if
			
			
		else
			
			// -------------------------------------------------------------------
			// in den GroupHeadern Suchen
			// -------------------------------------------------------------------
			For i = 1 to 3
				
//				if i = 1 then
//					f_print_datastore(dsGroup[i])
//				end if
				
				lHeaderHeight = Long(this.oDw.describe("datawindow.header." + string(i) + ".height"))
					
				lHeaderPos	  = lHeaderHeight - 30 // Die $$HEX1$$dc00$$ENDHEX$$berschrift wird in den unteren 30 Pixeln erwartet
				lObjectX			= dsDetail.GetItemNumber(lRows, "xpos")
				lObjectWidth	= dsDetail.GetItemNumber(lRows, "iwidth")
			
				sSearch  = "xpos >= " + string(lObjectX) 
				sSearch += " and xpos <= "  + string(lObjectX + lObjectWidth) 
				sSearch += " and ypos >= " + string(lHeaderPos) 
				
				lFound = dsGroup[i].Find(sSearch, 1, dsGroup[i].RowCount())
			
				if lFound > 0 then
					sObject = dsGroup[i].GetItemString(lFound, "cobject")
					sType   = dsGroup[i].GetItemString(lFound, "ccolumn_type")
					
					if mid(sType, 1, 4) = "char" then
						sValue = oDW.GetItemString(lCurrentRow, sObject)				
					elseif sType = "number" then
						sValue = String(oDW.GetItemNumber(lCurrentRow, sObject))
					else
						sValue  = Trim(this.oDw.describe(sObject + ".text"))
					end if
															
					if len(sValue) < 10 then
						sValue = Mid(sValue + "          ", 1, 10)
					end if
					
					dsDetail.SetItem(lRows, "cheader_info", sValue)
					
				end if
				
			Next

			// -------------------------------------------------------------------
			// danach in den GroupFootern Suchen
			// -------------------------------------------------------------------
			For i = 1 to 3
								
				lHeaderHeight = Long(this.oDw.describe("datawindow.trailer." + string(i) + ".height"))
					
				lHeaderPos	  = lHeaderHeight - 30 // Die $$HEX1$$dc00$$ENDHEX$$berschrift wird in den unteren 30 Pixeln erwartet
				lObjectX			= dsDetail.GetItemNumber(lRows, "xpos")
				lObjectWidth	= dsDetail.GetItemNumber(lRows, "iwidth")
			
				sSearch  = "xpos >= " + string(lObjectX) 
				sSearch += " and xpos <= "  + string(lObjectX + lObjectWidth) 
				// sSearch += " and ypos >= " + string(lHeaderPos) 
							
				lFound = dsGroupFooter[i].Find(sSearch, 1, dsGroupFooter[i].RowCount())
			
				if lFound > 0 then
					sObject = dsGroupFooter[i].GetItemString(lFound, "cobject")
					sType   = dsGroupFooter[i].GetItemString(lFound, "ccolumn_type")
					
					if mid(sType, 1, 4) = "char" then
						sValue = oDW.GetItemString(lCurrentRow, sObject)				
					elseif sType = "number" then
						sValue = String(oDW.GetItemNumber(lCurrentRow, sObject))
					else
						sValue  = Trim(this.oDw.describe(sObject + ".text"))
					end if
															
					if len(sValue) < 10 then
						sValue = Mid(sValue + "          ", 1, 10)
					end if
					
					dsDetail.SetItem(lRows, "cfooter_info", sValue)
					
				end if
				
			Next
			
			
		end if
		
	end if
		
Next


//dsdetail.Print()
//dsheader.print()

return 0
end function

public function string of_getheadertext (long lcurrentrow);
string	sOut
long 		lRows

sOut = ""

//oBand.SetItem(lRow, "ccolumn_type", odw.Describe(sObject + ".coltype") )
of_set_header(lCurrentRow)

for lRows = 1 to dsDetail.RowCount()
			
	if dsDetail.GetItemNumber(lRows, "nprint") > 0 then

		sOut += of_checknull_string(dsDetail.GetItemString(lRows, "cheader_info")) + char(9)
							
	end if

next

return sOut
end function

public function string of_getfootertext ();
string	sOut
long 		lRows

sOut = ""

//oBand.SetItem(lRow, "ccolumn_type", odw.Describe(sObject + ".coltype") )
//of_set_header(lCurrentRow)

for lRows = 1 to dsDetail.RowCount()
			
	if dsDetail.GetItemNumber(lRows, "nprint") > 0 then

		sOut += of_checknull_string(dsDetail.GetItemString(lRows, "cfooter_info")) + char(9)
							
	end if

next

return sOut
end function

public function integer of_export_as_text (datawindow odata, string sfilename);Integer 		iResult, &
				iOpen, &
				I, &
				iGroupChecker = 0 
				
string 		sPath, &
				sSaveName, &
				sObject, &
				sMsg, &
				sFileTypes, &
				sRange, &
				sDir, &
				sGroupHeaderRanges[],&
				sGroupFooterRanges[],&
				sGroupHeaderValues[],&
				sGroupFooterValues[],&
				sRegSubKeys[]
				
Long 			lRows, &
				lFound, &
				lPrint, &
				lColumn, &
				a

Integer 		iOffSet, &
				iStart, &
				iGroupCount, &
				iHeader

Blob			bOut

odw = oData
sDir = f_GetCurrentDirectory()


if sFileName = "" then
	sFileTypes = "Text Files (*.TXT), *.TXT"
	iOpen = GetFileSaveName(uf.translate("Speichern als"),sSaveName, sFile, "TXT", sFileTypes)
else
	sSaveName = sFileName
	iOpen = 1
end if
	
f_SetCurrentDirectory(sDir)

if FileExists(sSaveName) then
	iOpen = uf.mbox("Achtung", "Vorhandene Datei ${" + sSaveName + "} $$HEX1$$fc00$$ENDHEX$$berschreiben ?" , Question!, YesNo!, 1)
end if

if iOpen <> 1 then Return 0
	
Open(w_progress)
w_progress.wf_settitle(uf.Translate("Textdatei wird erzeugt"))
w_progress.wf_setmessage(uf.Translate("Analysiere Daten"))
w_progress.wf_setStatus(uf.Translate("bitte warten"))
w_progress.wf_setMin(0)
w_progress.wf_setMax(oDW.RowCount())
w_progress.wf_setPosition(0)

// -------------------------
// Datawindow analysieren
// -------------------------
of_analyse_dw()

//f_print_datastore(dsHeader)
//f_print_datastore(dsDetail)
//f_print_datastore(dsGroup[1])


// ------------------------------------
// lColumnCount muss ver$$HEX1$$e400$$ENDHEX$$ndert werden
// wenn sStartColumn <> A ist. 
// Es muss die Position im Alphabet - 1 
// dazu addiert werden
// ------------------------------------
sStartColumn = "B"
lColumnCount += 1

// --------------------------------------------------
// OLE Objekt erstellen
// --------------------------------------------------
SetPointer(Arrow!)			
	
//--------------------------------------------------------
// Header wegschreiben
//--------------------------------------------------------

w_progress.wf_setmessage(uf.Translate("Bitte warten"))


iStart = 6
iOffset = iStart

//--------------------------------------------------------
// Detail's wegschreiben
//--------------------------------------------------------
w_progress.wf_setmessage(uf.Translate("Daten werden geschrieben"))

//bOut = ""

for a = 1 to oDW.RowCount()
	
	w_progress.wf_setstatus(uf.Translate("Zeile ${" + string(a) + "} von ${" + String(oDW.RowCount()) + "}" ))
	w_progress.wf_setposition(a)
	
	iOffset ++
	
	if bGrouped then
	
		if of_GroupCheck(a, 1) = true then 
			
			if a > 1 then
			
				bOut +=  Blob(of_checknull_string(of_getfootertext()))
				bOut += Blob("~r~n")
				sGroupFooterRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
				iOffset ++
				
			end if
			

			iGroupCount ++
			
			bOut += Blob(of_checknull_string(of_exportgroupheader(a, 1)))
			bOut += Blob("~r~n")
			sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++
			
			bOut += Blob(of_getheadertext(a))
			bOut += Blob("~r~n")
			sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++					
			
		end if	
			
		if of_GroupCheck(a, 2) = true then 
			iGroupChecker = 0 
			bOut += Blob(of_checknull_string(of_exportgroupheader(a, 2)))
			bOut += Blob("~r~n")
			iGroupCount ++
			sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++
			
			bOut += Blob(of_getheadertext(a))
			bOut += Blob("~r~n")
			sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++					
			
		end if	

		if of_GroupCheck(a, 3) = true then 
			iGroupChecker = 0 
			bOut += Blob(of_checknull_string(of_exportgroupheader(a, 3)))
			bOut += Blob("~r~n")
			iGroupCount ++
			sGroupHeaderRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++
			
			bOut += Blob(of_getheadertext(a))
			bOut += Blob("~r~n")
			sGroupHeaderValues[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++					

		end if	
		
	else
		
		// -----------------------------------------------------------
		// einmalig die Spalten$$HEX1$$fc00$$ENDHEX$$berschriften eintragen
		// -----------------------------------------------------------
		if iHeader = 0 then
			iHeader ++
			bOut += Blob(of_getheadertext(a))
			bOut += Blob("~r~n")
			sGroupHeaderValues[iHeader] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			// sGroupFooterValues[iHeader] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
			iOffSet ++					
		end if
		
	end if
	
	// -----------------------------------------------------------
	// das Detailband wegschreiben
	// -----------------------------------------------------------
	for lRows = 1 to dsDetail.RowCount()
						
		lPrint = dsDetail.GetItemNumber(lRows, "nprint")
		
		if lPrint > 0 then
		
			sObject = dsDetail.GetItemString(lRows, "cobject")
			bOut += Blob(of_checknull_string(of_exportlineDetail(lRows, iOffSet, lPrint, a, iBlack)) + char(9))
			
		end if
		
	Next
	
	bOut += Blob("~r~n")
	
Next


if bGrouped then
	
	iOffset ++
	bOut += Blob(of_checknull_string(of_getfootertext()))
	bOut += Blob("~r~n")
	sGroupFooterRanges[iGroupCount] = sStartColumn + String(iOffset) + ":" + sColumns[lColumnCount] + string(iOffset)
		
end if	



// ----------------------------------------
// Den Passwortschutz aktivieren
// ----------------------------------------
f_blob_to_file(sSavename, bOut)

if isvalid(w_progress) then close (w_progress)
			
	
// f_print_datastore(dsDetail)

return 0
end function

on uo_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*
* Objekt : uo_excel
* Methode: constructor (Event)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 31.03.2010
*
* Argument(e):
* none
*
* Beschreibung:		Initialisierung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	31.03.2010		Erstkommentar; M$$HEX1$$f600$$ENDHEX$$glichkeit f$$HEX1$$fc00$$ENDHEX$$r (ext.) disable der Essbase Plug-Ins hinzu
*
*
* Return: long
*
*/
String	ls_Temp


dsHeader = Create DataStore
dsDetail = Create DataStore
dsGroup[1] = Create DataStore
dsGroup[2] = Create DataStore
dsGroup[3] = Create DataStore
dsGroupColumns[1] = Create DataStore
dsGroupColumns[2] = Create DataStore
dsGroupColumns[3] = Create DataStore
dsGroupFooter[1] = Create DataStore
dsGroupFooter[2] = Create DataStore
dsGroupFooter[3] = Create DataStore



dsHeader.dataobject = "dw_analyse"
dsHeader.Modify("t_header.text='HEADER'")

dsDetail.dataobject = "dw_analyse"
dsDetail.Modify("t_header.text='DETAIL'")

dsGroup[1].dataobject = "dw_analyse"
dsGroup[1].Modify("t_header.text='GROUP_HEADER[1]'")

dsGroup[2].dataobject = "dw_analyse"
dsGroup[3].dataobject = "dw_analyse"

dsGroupColumns[1].dataobject = "dw_analyse"
dsGroupColumns[1].Modify("t_header.text='GROUP_COLUMNS[1]'")
dsGroupColumns[2].dataobject = "dw_analyse"
dsGroupColumns[3].dataobject = "dw_analyse"

dsGroupFooter[1].dataobject = "dw_analyse"
dsGroupFooter[1].Modify("t_header.text='GROUP_FOOTER[1]'")
dsGroupFooter[2].dataobject = "dw_analyse"
dsGroupFooter[2].Modify("t_header.text='GROUP_FOOTER[2]'")
dsGroupFooter[3].dataobject = "dw_analyse"
dsGroupFooter[3].Modify("t_header.text='GROUP_FOOTER[3]'")



sColumns[1] = "A"
sColumns[2] = "B"
sColumns[3] = "C"
sColumns[4] = "D"
sColumns[5] = "E"
sColumns[6] = "F"
sColumns[7] = "G"
sColumns[8] = "H"
sColumns[9] = "I"
sColumns[10] = "J"
sColumns[11] = "K"
sColumns[12] = "L"
sColumns[13] = "M"
sColumns[14] = "N"
sColumns[15] = "O"
sColumns[16] = "P"
sColumns[17] = "Q"
sColumns[18] = "R"
sColumns[19] = "S"
sColumns[20] = "T"
sColumns[21] = "U"
sColumns[22] = "V"
sColumns[23] = "W"
sColumns[24] = "X"
sColumns[25] = "Y"
sColumns[26] = "Z"
sColumns[27] = "AA"
sColumns[28] = "AB"
sColumns[29] = "AC"
sColumns[30] = "AD"
sColumns[31] = "AE"
sColumns[32] = "AF"
sColumns[33] = "AG"
sColumns[34] = "AH"
sColumns[35] = "AI"
sColumns[36] = "AJ"
sColumns[37] = "AK"
sColumns[38] = "AL"
sColumns[39] = "AM"
sColumns[40] = "AN"
sColumns[41] = "AO"
sColumns[42] = "AP"
sColumns[43] = "AQ"
sColumns[44] = "AR"
sColumns[45] = "AS"
sColumns[46] = "AT"
sColumns[47] = "AU"
sColumns[48] = "AV"
sColumns[49] = "AW"
sColumns[50] = "AX"
sColumns[51] = "AY"
sColumns[52] = "AZ"

// -------------------------------------------
// XLS Export - Spalte als Text erm$$HEX1$$f600$$ENDHEX$$glichen
// -------------------------------------------
If profilestring(s_app.sprofile,"General","EnableXLSColomnAsText","0") = "0" Then
	bEnableXLSColomnAsText = false
Else
	bEnableXLSColomnAsText = true
End if	

// -------------------------------------------
// Plugins deaktivieren - sonst Absturzgefahr
// -------------------------------------------
//Beispieleintrag
//
//[General]
//XLSDisablePlugin=c:\windows\system32\charmap.exe
//XLSEnablePlugin=c:\windows\system32\calc.exe
//  bzw. Programme->Oracle EPM System->Essbase->Essbase_Client-> disable 
// -------------------------------------------
ls_Temp = profilestring(s_app.sprofile,"General","XLSDisablePlugin","") 
If Trim(ls_temp) > ""  Then
	ib_Disable_PlugIn = TRUE
	is_Disable_PlugIn = ls_Temp
	is_Enable_PlugIn = profilestring(s_app.sprofile,"General","XLSEnablePlugin","") 
End If


end event

event destructor;Destroy(dsHeader)
Destroy(dsDetail)
Destroy(dsGroup[1])
Destroy(dsGroup[2])
Destroy(dsGroup[3])
Destroy(dsGroupColumns[1])
Destroy(dsGroupColumns[2]) 
Destroy(dsGroupColumns[3]) 
Destroy(dsGroupFooter[1])
Destroy(dsGroupFooter[2])
Destroy(dsGroupFooter[3])



end event

