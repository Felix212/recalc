HA$PBExportHeader$uo_form_detail_datawindow.sru
forward
global type uo_form_detail_datawindow from uo_parent_dw
end type
end forward

global type uo_form_detail_datawindow from uo_parent_dw
string dragicon = "..\Resource\dragdrop.ico"
event ue_ellapse ( string sobject )
event ue_validation_messages ( string scolumn )
event ue_mouse_up pbm_dwnlbuttonup
end type
global uo_form_detail_datawindow uo_form_detail_datawindow

type variables
public:

string	sEllapse_Column	// Column-Name falls das Ein- und Ausklappen von Gruppen
									// benutzt werden soll.

window 	wParent

datastore dsObjects

integer	iDragDrop = 0

integer	iValidationChanged = 0	//	Flag, ob die urspr. Message zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt werden soll
											// wird im editchanged-Event gesetzt

string	sSection

string	sFirstColumn

Long 		lStartBenchmark, &
			lEndBenchmark

end variables

forward prototypes
public function integer of_add_to_profile (string skey, string svalue)
private function integer of_analyse_header (ref s_choose_column strload)
private function integer of_analyse_associated_objects (ref s_choose_column strload)
public function long of_build (s_choose_column strchoose, long lxpos)
public function string of_checknull (string svalue)
public function long of_get_startpos (s_choose_column strchoose)
public function integer of_get_status ()
public function integer of_load_view (ref s_choose_column strload)
public function integer of_modify (s_choose_column strchoose)
public function integer of_modify_old (s_choose_column strchoose)
public function integer of_set_detailheight ()
public function integer of_timestamp (long lrow)
end prototypes

event ue_ellapse(string sobject);//
// ue_ellapse
//
// setzt voraus:
// 
// *	Computed Column elapse im Datawindow (default: 0)
// *	sEllapse_Column mu$$HEX2$$df002000$$ENDHEX$$mit dem Feldnamen, der die Gruppe eindeutig macht, vorbelegt sein
//
string 	sColumn, &
			sBand, &
			sColumnType, &
			sKey
			
Long 		lRow, &
			a, &
			lKey, &
			lDetailKey, &
			lHeight

DateTime	dtKey

// ---------------------------------------------------------
// Falls Ein/Ausklappen nicht verwendet wird, dann raus hier
// ---------------------------------------------------------
if sEllapse_Column = "" or isnull(sEllapse_Column) then return


// ---------------------------------------------------------
// Nachschau, ob DW PBU's oder Pixels als Einheit verwendet
// Units = 0  PBU
//       = 1  Pixel
// ---------------------------------------------------------
if this.Describe("datawindow.units") = "0" then
	lHeight = 96
elseif this.Describe("datawindow.units") = "1" then
	lHeight = 24
else
	uf.mbox("Hallo Entwickler !", "Unbekannte Einheit gew$$HEX1$$e400$$ENDHEX$$hlt")
	return
end if

// ----------------------------------------------------------
// Nachschaun, von welchem DatenTyp die Column ist
// ----------------------------------------------------------

sColumnType = this.Describe(sEllapse_Column + ".Coltype")

//
// Parameter sObject:
// String mit Namen von Band und Row (tab-separated)
//
sBand = Trim(MidA(sObject, 1, PosA(sObject, "~t") - 1))
lRow = Long(MidA(sObject, PosA(sObject, "~t") + 1))



// -----------------------------------------------
// User hat in Header der Gruppe 1 geklickt
// -----------------------------------------------

if sBand = "header.1" and lRow > 0 then 
	
	//this.ScrollToRow(lRow)
	this.SetRedraw(false)


	choose case MidA(sColumnType, 1, 5)
			
		case "decim"
			
			// -----------------------------------------------
			// Groupfield ist nummerisch
			// -----------------------------------------------

			lKey = this.GetItemNumber(lRow, sEllapse_Column)

			// -----------------------------------------------
			// Group sichtbar, dann ausblenden
			// -----------------------------------------------
			if this.GetItemNumber(lRow, "elapse") = 0 then
			
				for a = 1 to this.RowCount()
					
					if this.GetItemNumber(a, sEllapse_Column) = lKey then
						
						this.SetDetailHeight(a, a, 0)  // 88
						this.SetItem(a, "elapse", 1)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
					
				Next
		
			// -----------------------------------------------
			// Group nicht sichtbar, dann einblenden
			// -----------------------------------------------
			elseif this.GetItemNumber(lRow, "elapse") = 1 then
				
				for a = 1 to this.RowCount()
					
					if this.GetItemNumber(a, sEllapse_Column) = lKey then
						
						this.SetDetailHeight(a, a, lHeight) 
						this.SetItem(a, "elapse", 0)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
				
				Next
				
			end if
	
		case "char("
			
			// -----------------------------------------------
			// Groupfield ist ein String
			// -----------------------------------------------
			
			sKey = this.GetItemString(lRow, sEllapse_Column)

			// -----------------------------------------------
			// Group sichtbar, dann ausblenden
			// -----------------------------------------------
			if this.GetItemNumber(lRow, "elapse") = 0 then
			
				for a = 1 to this.RowCount()
					
					if this.GetItemString(a, sEllapse_Column) = sKey then
						
						this.SetDetailHeight(a, a, 0)  // 88
						this.SetItem(a, "elapse", 1)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
					
				Next
		
			// -----------------------------------------------
			// Group nicht sichtbar, dann einblenden
			// -----------------------------------------------
			elseif this.GetItemNumber(lRow, "elapse") = 1 then
				
				for a = 1 to this.RowCount()
					
					if this.GetItemString(a, sEllapse_Column) = sKey then
						
						this.SetDetailHeight(a, a, lHeight) 
						this.SetItem(a, "elapse", 0)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
				
				Next
				
			end if
			
		case "datet"
			
			// -----------------------------------------------
			// Groupfield ist ein Datetime
			// -----------------------------------------------
			
			dtKey = this.GetItemDateTime(lRow, sEllapse_Column)

			// -----------------------------------------------
			// Group sichtbar, dann ausblenden
			// -----------------------------------------------
			if this.GetItemNumber(lRow, "elapse") = 0 then
			
				for a = 1 to this.RowCount()
					
					if this.GetItemDateTime(a, sEllapse_Column) = dtKey then
						
						this.SetDetailHeight(a, a, 0)  // 88
						this.SetItem(a, "elapse", 1)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
					
				Next
		
			// -----------------------------------------------
			// Group nicht sichtbar, dann einblenden
			// -----------------------------------------------
			elseif this.GetItemNumber(lRow, "elapse") = 1 then
				
				for a = 1 to this.RowCount()
					
					if this.GetItemDateTime(a, sEllapse_Column) = dtKey then
						
						this.SetDetailHeight(a, a, lHeight) 
						this.SetItem(a, "elapse", 0)
						this.SetItemStatus(a, "elapse", Primary!, NotModified!)
						
					end if
				
				Next
				
			end if
			
		case else
			
			// -----------------------------------------------
			// Groupfield Datentype ist UNBEKANNT
			// -----------------------------------------------
			
			uf.mbox("Hallo Entwickler", "Datentyp: ${" + sColumnType +"} wird im Objekt uo_tree_detail_datawindow im Event ue_ellapse nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigt!")
			
			
			
	end choose
			
			
	
	this.SetRedraw(true)
		
end if
end event

event ue_validation_messages(string scolumn);//
// ue_validation_messages
//
// Gezieltes (Zur$$HEX1$$fc00$$ENDHEX$$ck-)Setzen einer Default-Validation-Message, nachdem ue_validation
// eine abweichende Message gesetzt hat.
//
	choose case sColumn
		
		// ---------------------------
		// G$$HEX1$$fc00$$ENDHEX$$ltig-Ab
		// ---------------------------
		case "dvalid_from"
			uf_setmessage(sColumn,"Bitte geben Sie ein g$$HEX1$$fc00$$ENDHEX$$ltiges Datum ein.")
			
		// ---------------------------
		// G$$HEX1$$fc00$$ENDHEX$$ltig-Bis
		// ---------------------------
		case "dvalid_to"
			uf_setmessage(sColumn,"Bitte geben Sie ein g$$HEX1$$fc00$$ENDHEX$$ltiges Datum ein.")
			
	end choose

	ivalidationchanged = 0


end event

event ue_mouse_up;this.iDragDrop = 0
end event

public function integer of_add_to_profile (string skey, string svalue);

// ------------------------------------------------------
// keine Section f$$HEX1$$fc00$$ENDHEX$$r loc_setup eingetragen, dann
// machen wir nichts
// ------------------------------------------------------
if Trim(this.sSection) = "" or isnull(this.sSection) then
	return -1
end if

f_setprofilestring(this.sSection, sKey, sValue )

return 0
end function

private function integer of_analyse_header (ref s_choose_column strload);//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos, &
			iAnchorY, &
			iY
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sBand, &
			sSyntax, &
			sType, &
			sTag, &
			sHeader
			
long 		lInsert

// ---------------------------------------
// Nachschaun, ob Pixel als Einheit
// gew$$HEX1$$e400$$ENDHEX$$hlt ist
// ---------------------------------------
if this.describe("datawindow.units") <> "1" then
	uf.mbox("Hallo Entwickler", "Pixels als Einheit einstellen")
	return -1
end if 

// ---------------------------------------
// Nachschaun, ob gruppiert ist
// ---------------------------------------

sSyntax = this.Describe("datawindow.syntax")

// ---------------------------------------
// Maximal f$$HEX1$$fc00$$ENDHEX$$r 3 Gruppierungen
// ---------------------------------------

// -----------------------------------------------
// Im Syntax nach group(level=1 suchen
// -----------------------------------------------
iPos = PosA(sSyntax, "group(level=1" )
	
if iPos > 0 then
	sHeader = "header.1"
else
	sHeader = "header"
end if
	
// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
 sDWObjects = this.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to LenA(sDWObjects)
	
	if MidA(sDWObjects, i, 1) <> CharA(9) then
		
		sTemp += MidA(sDWObjects, i, 1)
		
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if LenA(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if


// ---------------------------------------
// Die Linie l_anchor suchen
// ---------------------------------------

integer iFound = 0

for i = 1 to UpperBound(sObjects)
	
	if this.Describe(sObjects[i] + ".name") = "l_anchor" then
		iAnchorY  = Integer(this.Describe(sObjects[i] + ".y1"))
		iFound = 1
		exit
		
	end if
	
Next

if iFound = 0 then
	uf.mbox("Hallo Entwickler", "Linie l_anchor im Groupheader fehlt")
	return -1
end if

// ---------------------------------------
// Die Objekte nach Header und Detail Band
// trennen
// ---------------------------------------

for i = 1 to UpperBound(sObjects)
	
	sBand = this.Describe(sObjects[i] + ".band")
	sType = this.Describe(sObjects[i] + ".type")
	sTag  = of_checknull(this.Describe(sObjects[i] + ".tag"))
	
	if Trim(sTag) = "!" or Trim(sTag) = "?" then
		sTag = ""
	end if
	
	if sBand = sHeader and sType <> "bitmap" then
		
		// -----------------------------------------------------------------------
		// Nur die Objekte merken, die im Header unterhalb der Linie l_anchor sind
		// -----------------------------------------------------------------------
		
		if sType <> "line" then
			iY = Integer(this.Describe(sObjects[i] + ".y"))
		else
			iY = Integer(this.Describe(sObjects[i] + ".y1"))
		end if
		
		if iAnchorY < iY then
		
			lInsert = strLoad.dsHeader.InsertRow(0)
			strLoad.dsHeader.SetItem(lInsert, "sobject", this.Describe(sObjects[i] + ".name"))
			strLoad.dsHeader.SetItem(lInsert, "stype", sType)
			strLoad.dsHeader.SetItem(lInsert, "sband", sband)
			
			if sType <> "line" then
				strLoad.dsHeader.SetItem(lInsert, "xpos", Integer(this.Describe(sObjects[i] + ".x")))
				strLoad.dsHeader.SetItem(lInsert, "ypos", Integer(this.Describe(sObjects[i] + ".y")))
				strLoad.dsHeader.SetItem(lInsert, "iwidth", Integer(this.Describe(sObjects[i] + ".width")))
				strLoad.dsHeader.SetItem(lInsert, "iheight", Integer(this.Describe(sObjects[i] + ".height")))
				
				if sType = "text" then
					strLoad.dsHeader.SetItem(lInsert, "stext", this.Describe(sObjects[i] + ".text"))
					strLoad.dsHeader.SetItem(lInsert, "stag", sTag)
				end if
				
			else
				strLoad.dsHeader.SetItem(lInsert, "xpos", Integer(this.Describe(sObjects[i] + ".x1")))
				strLoad.dsHeader.SetItem(lInsert, "ypos", Integer(this.Describe(sObjects[i] + ".x2")))
				strLoad.dsHeader.SetItem(lInsert, "iwidth", Integer(this.Describe(sObjects[i] + ".y1")))
				strLoad.dsHeader.SetItem(lInsert, "iheight", Integer(this.Describe(sObjects[i] + ".y2")))
			end if
			
		end if		
		
	end if
	
Next

strLoad.dsHeader.Sort()

return 0
end function

private function integer of_analyse_associated_objects (ref s_choose_column strload);//----------------------------------------------------
// Im Treeview stehen nun alle Texte aus dem
// Groupheader. Nun noch die ensprechenden
// Rechtecke, Linie und Datenbankfelder suchen
// und eintragen  ............................
//----------------------------------------------------

Long 		I, &
			lFound, &
			lFoundLine, &
			lFoundRect, &
			lFoundRectDetail, &
			lFoundObjectDetail, &
			lX, &
			lXRect, &
			lWidthRect, &
			lXRectDetail, &
			lWidthRectDetail, &
			lWidth, &
			lTaborder

String	sObject, &
			sName, &
			sText, &
			sFind, &
			sTag
			
Integer  iOffset = 3


// --------------------------------------
// Erstmal die Objekt im Groupheader
// suchen und eintragen
// --------------------------------------
//strLoad.dsHeader.Print()
//strLoad.dsDetail.Print()

For i = 1 to strLoad.dsDetail.RowCount()
	
	if strLoad.dsDetail.GetItemString(i, "stype") = "column" then
	
		sObject = strLoad.dsDetail.GetItemString(i, "sobject")
		
		lX 		= strLoad.dsDetail.GetItemNumber(i, "xpos")
		lWidth 	= strLoad.dsDetail.GetItemNumber(i, "iwidth")
		sTag	 	= strLoad.dsDetail.GetItemString(i, "stag")
		
		if sTag = "timestamp" then
			sTag = ""
		end if
		
		// ------------------------------------------
		// Jetzt den Text im Header suchen
		// ------------------------------------------

		sFind = "stype = 'text' and stag = '" + sTag + "' and xpos >= " + string(lX - iOffset) + " and xpos + iWidth <= " + String(lX + lWidth + iOffset)
		lFound = strLoad.dsHeader.Find(sFind , 1, strLoad.dsHeader.RowCount())
	
		if lFound <= 0 then
			
			//Messagebox("-1    - "   + string(lFound), sFind)
			Beep(2)
			return -1
			
		else
			
			sText = strLoad.dsHeader.GetItemString(lFound, "stext")
			sName = strLoad.dsHeader.GetItemString(lFound, "sobject")
			lFound = strLoad.dsList.Find("sdetail_object = '" + sObject + "'", 1, strLoad.dsList.RowCount())			
			
			if lFound = 0 then
				//Messagebox("-2", sFind)
				beep(2)
				return -2
			else
				
				strLoad.dsList.SetItem(lFound, "sheadertext", sText)
				strLoad.dsList.SetItem(lFound, "sheader_object", sname)
				strLoad.dsList.SetItem(lFound, "sTag", sTag)
				
			end if
			
		end if
					
		// --------------------------------------
		// Rechteck im Header suchen
		// --------------------------------------
		lFoundRect = strLoad.dsHeader.Find("stype = 'rectangle' and xpos <= " + string(lX) + " and " + &
												 "xpos + iWidth >= " + String(lX + lWidth), 1, strLoad.dsHeader.RowCount())
			
		if lFoundRect > 0 then
			strLoad.dsList.SetItem(lFound, "sheader_frame", strLoad.dsHeader.GetItemString(lFoundRect, "sobject"))
			lWidthRect = strLoad.dsHeader.GetItemNumber(lFoundRect, "iwidth")
			lXRect	  = strLoad.dsHeader.GetItemNumber(lFoundRect, "xpos")		
				
			// --------------------------------------
			// Linie im Header suchen
			// --------------------------------------
				
			lFoundLine = strLoad.dsHeader.Find("stype = 'line' and xpos > " + string(lXRect) + " and " + &
													 "xpos < " + String(lXRect + lWidthRect), 1, strLoad.dsHeader.RowCount())
			if lFoundLine > 0 then
				strLoad.dsList.SetItem(lFound, "sheader_line", strLoad.dsHeader.GetItemString(lFoundLine, "sobject"))
			end if
				
		end if
			
		// --------------------------------------
		// Rechteck im Detail suchen
		// --------------------------------------
			lFoundRectDetail =  strLoad.dsDetail.Find("stype = 'rectangle' and xpos <= " + string(lX) + " and " + &
												 "xpos + iWidth >= " + String(lX + lWidth), 1, strLoad.dsDetail.RowCount())
												 
			if lFoundRectDetail > 0 then
				
				strLoad.dsList.SetItem(lFound, "sdetail_frame", strLoad.dsDetail.GetItemString(lFoundRectDetail, "sobject"))
				lWidthRectDetail = strLoad.dsHeader.GetItemNumber(lFoundRect, "iwidth")
				lXRectDetail	  = strLoad.dsHeader.GetItemNumber(lFoundRect, "xpos")		
				
			end if
												 
		end if
		
	
Next

return 0


end function

public function long of_build (s_choose_column strchoose, long lxpos);Long 		I, &
			lFound, &
			lStartPosX, &
			lX, &
			lWidth, &
			lHeight, &
			lTaborder

String	sFind, &
			sObject, &
			sObjectFrame, &
			sHeader, &
			sHeaderFrame, &
			sHeaderLine

integer 	iFound, &
			iOffset
			

//strChoose.dsList.SetFilter("")
//strChoose.dsList.Filter()

if strChoose.dsList.RowCount() = 0 then
	return -1
end if

// -----------------------------------------
// Startposition
// -----------------------------------------
lStartPosX = lXpos

// ----------------------------------------------
// So, jetzt die Objekte neu positionieren
// ----------------------------------------------

for i = 1 to strChoose.dsList.RowCount()
	
	sObjectFrame  = strChoose.dsList.GetItemString(I, "sdetail_frame")
	sObject 		  = strChoose.dsList.GetItemString(i, "sdetail_object")
	sHeader       = strChoose.dsList.GetItemString(I, "sheader_object")
	sHeaderFrame  = strChoose.dsList.GetItemString(I, "sheader_frame")
	sHeaderLine   = strChoose.dsList.GetItemString(I, "sheader_line")
	lTaborder     = strChoose.dsList.GetItemNumber(i, "ntaborder")
	
	// ------------------------------------------------
	// Object soll angezeigt werden
	// ------------------------------------------------
//	if strChoose.dsList.GetItemNumber(i, "iselected") = 1 and strChoose.dsList.GetItemNumber(i, "ihidden") <> 1 then

		
		lFound = strChoose.dsDetail.Find("sobject = '" + sObjectFrame + "'", 1, strChoose.dsDetail.RowCount())
		
		if lFound > 0 then

			// ------------------------------------------------
			// 
			// ------------------------------------------------			
			
			//this.Modify(sHeader + ".tag = '1'")
			this.Modify(sObject + ".visible = 1")
			this.Modify(sObjectFrame + ".visible = 1")
			this.Modify(sHeader + ".visible = 1")
			this.Modify(sHeaderFrame + ".visible = 1")
			this.Modify(sHeaderLine + ".visible = 1")
			
			// ------------------------------------------------
			// Breite setzen
			// ------------------------------------------------			
			lWidth = strChoose.dsDetail.GetItemNumber(lFound, "iwidth")
			
			// ------------------------------------------------
			// den Rahmen im Detail positionieren
			// ------------------------------------------------
			this.Modify(sObjectFrame + ".x = " + String(lStartPosX))
			this.Modify(sObjectFrame + ".y = " + String(1))
			// ------------------------------------------------
			// die Column im Detail positionieren			
			// ------------------------------------------------
			this.Modify(sObject + ".x = " + String(lStartPosX + 3))
			this.Modify(sObject + ".y = " + String(4))
			this.Modify(sObject + ".width = " + String(lWidth - 6))
			// ------------------------------------------------
			// F$$HEX1$$fc00$$ENDHEX$$r Columns die Tabsequence setzten
			// ------------------------------------------------
			if this.Describe(sObject + ".type") = "column" then
				// ------------------------------------------------
				// Column ins Profile schreiben
				// ------------------------------------------------
				
				of_add_to_profile(sObject, string(lTabOrder) + "," + string(i))
				
				//if integer(this.Describe(sObject + ".tabsequence")) > 0 and lTabOrder > 0 then
				if lTabOrder > 0 then
					this.Modify(sObject + ".tabsequence=" + string(100 + i))
				else
					this.Modify(sObject + ".tabsequence=" + string(0))
				end if
			end if
					
			// ------------------------------------------------
			// die Rahmen im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeaderFrame + ".x = " + String(lStartPosX ))
			this.Modify(sHeaderFrame + ".width = " + String(lWidth))
			// ------------------------------------------------
			// den Text im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeader + ".x = " + String(lStartPosX + 3))
			this.Modify(sHeader + ".width = " + String(lWidth - 6))
			// ------------------------------------------------
			// die Linie im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeaderLine + ".x1 = " + String(lStartPosX + lWidth - 2))
			this.Modify(sHeaderLine + ".x2 = " + String(lStartPosX + lWidth - 2))
			
			lStartPosX += lWidth - 1
			
		End if
	
	//end if
	
	
Next

return lStartPosX
end function

public function string of_checknull (string svalue);
if isnull(sValue) then
	return ""
end if

return sValue
end function

public function long of_get_startpos (s_choose_column strchoose);// ----------------------------------------------
// Startposition auf der X - Achse ermitteln
// ----------------------------------------------

Long 		lStartPos, &
			I, &
			lFound
			
String 	sObject, &
			sFrame, &
			sFind


lStartPos = 0

// ----------------------------------------------
// Nachschaun, ob Felder nicht ausgeblendet
// werden d$$HEX1$$fc00$$ENDHEX$$rfen, dann die maximale xPos
// dieses Objectes als StartPosition verwenden
// ----------------------------------------------

//dsObjects.SaveAs("c:\temp\dslist.xls", Excel5!, True)

for I = dsObjects.RowCount() to 1 step -1
		
	// -------------------------------------------------------
	// Nachschaun, ob es eine Column gibt, die nicht 
	// verschiebbar sein soll .....................
	// -------------------------------------------------------
	if dsObjects.GetItemString(i, "stag") = "OFF" then
		
		sObject  = dsObjects.GetItemString(I, "sobject")
		
		// ------------------------------------------------------------
		// Die Column in der Liste mi den zugeordneten Objekten suchen
		// ------------------------------------------------------------
		
		lFound = strChoose.dsList.Find("sdetail_object = '" + sObject +"'", 1, strChoose.dsList.RowCount())
		
		if lFound > 0 then
			
			// -------------------------------------------------------
			// Nun den der Column zugeordneten Rahmen, merken und 
			// diesen wieder in der "Objektliste" suchen
			// -------------------------------------------------------
			sFrame = strChoose.dsList.GetItemString(lFound, "sdetail_frame")
			
			lFound = dsObjects.Find("sobject = '" + sFrame + "'", 1, dsObjects.RowCount())
			
			if lFound > 0 then
				// -------------------------------------------------------
				// So, der Rahme ist gefunde, die Startposition ist 
				// nun die x-Position + Breite des Objektes
				// -------------------------------------------------------
				lStartPos = dsObjects.GetItemNumber(lFound, "xpos") + dsObjects.GetItemNumber(lFound, "iwidth")				
				
				return lStartPos - 1			
				
			else
				
				beep(2)
				
			end if
			
		else
			
			beep(2)
			
		end if

	end if

Next

// ---------------------------------------------
// Es gint keine Column die nicht verschiebbar
// ist, als Startposition wird die x1-Position
// der Linie l_anchor verwendet
// --------------------------------------------

if lStartPos = 0 then
	lStartPos = Long(this.Describe("l_anchor.x1"))
end if

return lStartPos
end function

public function integer of_get_status ();//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos, &
			iY
			
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sValidObjects[], &
			sBand, &
			sSyntax, &
			sObject, &
			sType, &
			lTaborder, &
			sTag

long 		lInsert, &
			lHeight

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
 sDWObjects = this.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to LenA(sDWObjects)
	
	if MidA(sDWObjects, i, 1) <> CharA(9) then
		sTemp += MidA(sDWObjects, i, 1)
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if LenA(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if

// ---------------------------------------
// Nun Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Objekte sichtbar
// im Detailband sind
// ---------------------------------------


for i = 1 to UpperBound(sObjects)
	
	sBand = this.Describe(sObjects[i] + ".band")
	sType = this.Describe(sObjects[i] + ".type")
	sTag  = of_checknull(this.Describe(sObjects[i] + ".tag"))
	
	if Trim(sTag) = "!" or Trim(sTag) = "?" then
		sTag = ""
	end if
	
	
	if sBand = "detail" and (sType = "column" or sType = "compute" or sType = "text" or sType = "rectangle") then
		
		// -----------------------------------------------------------------------
		// Nur die Objekte merken, die im Detail stehen und eine Y Koordinate
		// kleiner gleich 8 Pixels haben
		// -----------------------------------------------------------------------
		iY = Integer(this.Describe(sObjects[i] + ".y"))
	
		if iY <= 8 then
			
			lInsert = dsObjects.InsertRow(0)
			dsObjects.SetItem(lInsert, "sobject", this.Describe(sObjects[i] + ".name"))
			dsObjects.SetItem(lInsert, "stype", this.Describe(sObjects[i] + ".type"))
			dsObjects.SetItem(lInsert, "svaluetype", this.Describe(sObjects[i] + ".Coltype"))
			dsObjects.SetItem(lInsert, "xpos", 	Integer(this.Describe(sObjects[i] + ".x")))
			dsObjects.SetItem(lInsert, "ypos", 	Integer(this.Describe(sObjects[i] + ".y")))
			dsObjects.SetItem(lInsert, "iwidth", 	Integer(this.Describe(sObjects[i] + ".width")))
			dsObjects.SetItem(lInsert, "iheight", 	Integer(this.Describe(sObjects[i] + ".height")))
			
			if sType = "column" then
				dsObjects.SetItem(lInsert, "nhas_taborder", 	Integer(this.Describe(sObjects[i] + ".tabsequence")))
				dsObjects.SetItem(lInsert, "stag", 	sTag)
			end if
			
		end if
		
	end if
		
Next

dsObjects.Sort()

// -----------------------------------------------------------------------
// Erste Column mit TabSequence merken
// -----------------------------------------------------------------------

sFirstColumn = ""

For I = 1 to dsObjects.RowCount()
	
	if dsObjects.GetItemString(i, "stype") = "column" then
		
		sObject = dsObjects.GetItemString(i, "sobject")
		
		if Integer(this.Describe(sObject + ".tabsequence")) > 0 then
			this.sFirstColumn = sObject			
			exit
		end if 
		
	end if
	
Next


return 0
end function

public function integer of_load_view (ref s_choose_column strload);Long				 	lInsert, &
						lCount, &
						lSort, &
						lSelected, &
 					 	I

String				sType, &
						sObject, &
						sValue, &
						sTag

Integer 				iRet
// ------------------------------------------------------
// keine Section f$$HEX1$$fc00$$ENDHEX$$r loc_setup eingetragen, dann
// machen wir nichts
// ------------------------------------------------------
if Trim(this.sSection) = "" or isnull(this.sSection) then
	return -1
end if

// ------------------------------------------------------
// Nachshaun, ob es f$$HEX1$$fc00$$ENDHEX$$r die Section eintr$$HEX1$$e400$$ENDHEX$$ge gibt
// ------------------------------------------------------

SELECT Count(*)
 INTO :lCount  
 FROM loc_setup  
WHERE ( loc_setup.nuser_id = :s_app.lUser_ID ) AND  
		( loc_setup.csection = :this.sSection )   ;


if lCount <= 0 then
	return -2
end if

// ------------------------------------------------------
// Struktur vorbereiten
// ------------------------------------------------------
strLoad.dsList   = Create datastore
strLoad.dsHeader = Create datastore
strLoad.dsDetail = Create datastore

strLoad.dsList.dataobject   = "dw_select_column"
strLoad.dsHeader.dataobject = "dw_analyse_dw_objects"
strLoad.dsDetail.dataobject = "dw_analyse_dw_objects"

dsObjects.RowsCopy(1, dsObjects.RowCount(), Primary!, strLoad.dsDetail, 1, Primary!)

// ----------------------------------------
// Alle Objekte des Datawindows einlesen
// ----------------------------------------
for I = 1 to dsObjects.RowCount()
	
	sType   = dsObjects.GetItemString(I, "stype")
	sObject = dsObjects.GetItemString(I, "sobject")
	sTag 	  = of_checknull(dsObjects.GetItemString(I, "stag")	)
	
	if sType = "column" or sType = "compute" or sType = "text" then
	
		lInsert = strLoad.dsList.InsertRow(0)
		strLoad.dsList.SetItem(lInsert, "sdetail_object", sObject)
		
		sValue = f_profilestring(this.sSection, sObject, "-1")
		
		if sValue <> "-1" then
			lSort     = Long(MidA(sValue, PosA(sValue, ",") + 1))
			
			if sTag = "OFF" then
				strLoad.dsList.SetItem(lInsert, "nsort", lSort)
				strLoad.dsList.SetItem(lInsert, "ihidden", 1)
			else
				strLoad.dsList.SetItem(lInsert, "nsort", lSort * 100)
				strLoad.dsList.SetItem(lInsert, "ihidden", 0)
			end if
						
			strLoad.dsList.SetItem(lInsert, "iselected", 1)
			
			if sType = "column" then
				strLoad.dsList.SetItem(lInsert, "ntaborder",  Long(MidA(sValue, 1, PosA(sValue, ",") - 1)))
				strLoad.dsList.SetItem(lInsert, "stag",  sTag)
			end if
			
		else
			strLoad.dsList.SetItem(lInsert, "nsort", I + 10000)
			strLoad.dsList.SetItem(lInsert, "ihidden", 0)
			strLoad.dsList.SetItem(lInsert, "iselected", 1)
		end if
		
	end if	
	
Next 

strLoad.dsList.Sort()
//strLoad.dsList.Print()

if this.of_analyse_header(strLoad) <> 0 then
	return -3
end if

iRet = this.of_analyse_associated_objects(strLoad) 

if iRet <> 0 then
	return -4 
end if

return 0
end function

public function integer of_modify (s_choose_column strchoose);Long 		I, &
			lFound, &
			lStartPosX, &
			lX, &
			lWidth, &
			lHeight, &
			lTaborder, &
			lLenght

String	sFind, &
			sObject, &
			sObjectFrame, &
			sHeader, &
			sHeaderFrame, &
			sHeaderLine

integer 	iFound, &
			iOffset
			


strChoose.dsList.SetFilter("")
strChoose.dsList.Filter()

if strChoose.dsList.RowCount() = 0 then
	return -1
end if

this.SetRedraw(false)

// -----------------------------------------
// Zuerst alle unverschiebbaren Columns
// modifizieren ...........
// -----------------------------------------
strChoose.dsList.SetFilter("ihidden = 1")
strChoose.dsList.Filter()

if strChoose.dsList.RowCount() > 0 then
	lLenght += of_build(strChoose, Long(this.Describe("l_anchor.x1")))
end if

// -----------------------------------------
// Dann alle verschiebbaren Columns
// modifizieren ...........
// -----------------------------------------
strChoose.dsList.SetFilter("ihidden = 0")
strChoose.dsList.Filter()

if strChoose.dsList.RowCount() > 0 then
	
	// -----------------------------------------------
	// Erstmal den Filter zur$$HEX1$$fc00$$ENDHEX$$cksetzten, damit die
	// richtige Startposition gefunden werden kann
	// -----------------------------------------------
	strChoose.dsList.SetFilter("")
	strChoose.dsList.Filter()
	lStartPosX = of_get_startpos(strChoose) + 1
	
	// -----------------------------------------------
	// Dann den alten Filter wieder setzten
	// -----------------------------------------------
	strChoose.dsList.SetFilter("ihidden = 0")
	strChoose.dsList.Filter()
	
	lLenght = of_build(strChoose, lStartPosX)
end if

this.Modify("l_anchor.x2 = " + String(lLenght))
This.Modify("datawindow.horizontalscrollposition = 0")

// -----------------------------------------------------------------------
// Erste Column mit TabSequence merken
// -----------------------------------------------------------------------

For I = 1 to strChoose.dsList.RowCount()
		
	sObject = strChoose.dsList.GetItemString(i, "sdetail_object")
		
	if Integer(this.Describe(sObject + ".tabsequence")) > 0 then
		
		sFirstColumn = sObject			
		
		exit
	end if 
		
	
Next


this.SetRedraw(true)


return 0
end function

public function integer of_modify_old (s_choose_column strchoose);Long 		I, &
			lFound, &
			lStartPosX, &
			lX, &
			lWidth, &
			lHeight

String	sFind, &
			sObject, &
			sObjectFrame, &
			sHeader, &
			sHeaderFrame, &
			sHeaderLine

integer 	iFound, &
			iOffset
			


strChoose.dsList.SetFilter("")
strChoose.dsList.Filter()

if strChoose.dsList.RowCount() = 0 then
	return -1
end if

// -----------------------------------------
// Erstmal die Startposition ermitteln
// -----------------------------------------

lStartPosX = Long(this.Describe("l_anchor.x1"))

// ----------------------------------------------
// So, jetzt die Objekte neu positionieren
// ----------------------------------------------

this.SetRedraw(false)

for i = 1 to strChoose.dsList.RowCount()
	
	sObjectFrame  = strChoose.dsList.GetItemString(I, "sdetail_frame")
	sObject 		  = strChoose.dsList.GetItemString(i, "sdetail_object")
	sHeader       = strChoose.dsList.GetItemString(I, "sheader_object")
	sHeaderFrame  = strChoose.dsList.GetItemString(I, "sheader_frame")
	sHeaderLine   = strChoose.dsList.GetItemString(I, "sheader_line")

	// ------------------------------------------------
	// Object soll angezeigt werden
	// ------------------------------------------------
	if strChoose.dsList.GetItemNumber(i, "iselected") = 1 and strChoose.dsList.GetItemNumber(i, "ihidden") <> 1 then
		
		lFound = strChoose.dsDetail.Find("sobject = '" + sObjectFrame + "'", 1, strChoose.dsDetail.RowCount())
		
		if lFound > 0 then

			// ------------------------------------------------
			// Tag = 1 setzen (sichtbar)
			// ------------------------------------------------			
			
			this.Modify(sHeader + ".tag = '1'")
			this.Modify(sObject + ".visible = 1")
			this.Modify(sObjectFrame + ".visible = 1")
			this.Modify(sHeader + ".visible = 1")
			this.Modify(sHeaderFrame + ".visible = 1")
			this.Modify(sHeaderLine + ".visible = 1")
			
			// ------------------------------------------------
			// Tabsequence setzen
			// ------------------------------------------------			
			lWidth = strChoose.dsDetail.GetItemNumber(lFound, "iwidth")
			
			// ------------------------------------------------
			// den Rahmen im Detail positionieren
			// ------------------------------------------------
			this.Modify(sObjectFrame + ".x = " + String(lStartPosX))
			this.Modify(sObjectFrame + ".y = " + String(1))
			// ------------------------------------------------
			// die Column im Detail positionieren			
			// ------------------------------------------------
			this.Modify(sObject + ".x = " + String(lStartPosX + 3))
			this.Modify(sObject + ".y = " + String(4))
			this.Modify(sObject + ".width = " + String(lWidth - 6))
			// ------------------------------------------------
			// F$$HEX1$$fc00$$ENDHEX$$r Columns die Tabsequence setzten
			// ------------------------------------------------
			if this.Describe(sObject + ".type") = "column" then
				// ------------------------------------------------
				// Column ins Profile schreiben
				// ------------------------------------------------
				of_add_to_profile(sObject, "1," + string(i))
				
				if integer(this.Describe(sObject + ".tabsequence")) > 0 then
					this.Modify(sObject + ".tabsequence=" + string(i))
				end if
			end if
					
			// ------------------------------------------------
			// die Rahmen im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeaderFrame + ".x = " + String(lStartPosX ))
			this.Modify(sHeaderFrame + ".width = " + String(lWidth))
			// ------------------------------------------------
			// den Text im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeader + ".x = " + String(lStartPosX + 3))
			this.Modify(sHeader + ".width = " + String(lWidth - 6))
			// ------------------------------------------------
			// die Linie im Header positionieren			
			// ------------------------------------------------
			this.Modify(sHeaderLine + ".x1 = " + String(lStartPosX + lWidth - 2))
			this.Modify(sHeaderLine + ".x2 = " + String(lStartPosX + lWidth - 2))
			
			lStartPosX += lWidth - 1
			
		End if
		
		
		
	elseif strChoose.dsList.GetItemNumber(i, "iselected") = 0 and strChoose.dsList.GetItemNumber(i, "ihidden") <> 1 then
		
		// ------------------------------------------------
		// Tag = 0 setzen (unsichtbar)
		// ------------------------------------------------			
		this.Modify(sHeader + ".tag = '0'")
		
		this.Modify(sObject + ".visible = 0")
		
		if this.Describe(sObject + ".type") = "column" then
			// ------------------------------------------------
			// Column ins Profile schreiben
			// ------------------------------------------------
			of_add_to_profile(sObject, "0," + string(i))
		end if
		
		this.Modify(sObjectFrame + ".visible = 0")
		this.Modify(sHeader + ".visible = 0")
		this.Modify(sHeaderFrame + ".visible = 0")
		this.Modify(sHeaderLine + ".visible = 0")
		
	end if
	
	
Next

this.Modify("l_anchor.x2 = " + String(lStartPosX))
This.Modify("datawindow.horizontalscrollposition = 0")

// -----------------------------------------------------------------------
// Erste Column mit TabSequence merken
// -----------------------------------------------------------------------

For I = 1 to strChoose.dsList.RowCount()
		
	sObject = strChoose.dsList.GetItemString(i, "sdetail_object")
		
	if Integer(this.Describe(sObject + ".tabsequence")) > 0 then
		
		sFirstColumn = sObject			
		
		exit
	end if 
		
	
Next


this.SetRedraw(true)


return 0
end function

public function integer of_set_detailheight ();// ---------------------------------------------------------
// DetailHeight auf 96 PBU's bzw. 24 Pixel setzten
// wenn DetailHeight > 0 
// 
// Nachschau, ob DW PBU's oder Pixels als Einheit verwendet
// Units = 0  PBU
//       = 1  Pixel
// ---------------------------------------------------------

Long lHeight

if Long(this.Describe("datawindow.detail.height")) > 0 then

	if this.Describe("datawindow.units") = "0" then
		lHeight = 96
	elseif this.Describe("datawindow.units") = "1" then
		lHeight = 24
	end if
	
	this.Modify("datawindow.detail.height=" + string(lHeight))
	
end if

return 0

end function

public function integer of_timestamp (long lrow);// ---------------------------------------------------------------
// Nachschau, ob es eine TimeStamp Column gibt, wenn ja dann
// eintragen
// ---------------------------------------------------------------

Long 		lFound
datetime	dtToday
String	sObject

lFound = dsObjects.Find("stype = 'column' and svaluetype = 'datetime' and stag = 'timestamp'" , 1, dsObjects.RowCount())

if lFound > 0 then
	//Messagebox("", "Found")
	dtToday = Datetime(Today(), now())
	sObject = dsObjects.GetItemString(lFound, "sobject")
	this.SetItem(lRow, sObject, dtToday)
end if

return 0	
	

end function

event type integer ue_validation(string sfield, long lrow, string sdata);// -------------------------------------
// ue_validation
//
// Hier bereits angepa$$HEX1$$df00$$ENDHEX$$t auf typische 
// Eingabefelder
// -------------------------------------

long 		lId, &
			lFound, &
			lKey, &
			lFlight, &
			lGroupKey, &
			lRet

String 	sSuffix,&
			sUnit

s_select_tlc str_open_selection

Blob bBlob
//
//choose case sField
//		
//	// ---------------------------
//	//  Routing
//	// ---------------------------
//	case "crout"
//		
//		lRet = f_rout_to_number(sData)
//		
//		if lRet = -1 then
//			str_open_selection.lreturn = 1
//			SetNull(bBlob)
//			str_open_selection.bData = bBlob
//			OpenWithParm(w_select_rout, str_open_selection)
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(lRow, "nrouting_id", str_open_selection.lReturn)
//			this.post SetItem(lRow, "crout", f_rout_to_string(lKey))
//			
//		else
//			this.SetItem(lRow, "nrouting_id", lRet)
//		end if
//		
//	// ---------------------------
//	//  Abfertigungsart
//	// ---------------------------
//	case "chandling_type"
//
//		//lRet = f_handling_to_number(sData, str_params.lAirlineKey)
//		
//		if lRet = -1 then
//			str_open_selection.lreturn = 1
//			
//			SetNull(bBlob)
//			
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_abart, str_open_selection)
//			
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(lRow, "nhandling_type_key", str_open_selection.lReturn)
//			this.post SetItem(lRow, "chandling_type", f_handling_to_string(str_open_selection.lReturn))
//		else
//			this.SetItem(lRow, "nhandling_type_key", lRet)
//		end if
//
//		
//	// ---------------------------
//	//  3-Letter-Codes Departure
//	// ---------------------------
//	case "cdep"
//		
//		lId = f_check_three_letter_code(sData)
//		
//		if lID = -1 or sData = "- -" then
//		
//			SetNull(bBlob)
////			if dwTLC.RowCount() = 0 then
////				dwTLC.retrieve()
////			end if
//			//
//			// Hier kommt der Blob zum Tragen:
//			// sDataWindow mit 3-Letter-Codes wird in Blob der Struktur
//			// verpackt und an select-Fenster durchgereicht.
//			//
////			GetFullState(dwTLC, bBlob)
//			str_open_selection.lreturn = 1
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_tlc, str_open_selection)
//				
//			str_open_selection = Message.PowerObjectParm
//				
//			this.SetItem(lRow, "ntlc_from", str_open_selection.lReturn)
//			this.post SetItem(lRow, "cdep", f_check_three_letter_code_id(str_open_selection.lReturn))
//
//		else
//			
//			this.SetItem(lRow, "ntlc_from", lID)
//		end if
//
//	// ---------------------------
//	//  3-Letter-Codes Destination
//	// ---------------------------
//	case "cdest"
//		
//		lId = f_check_three_letter_code(sData)
//		
//		if lID = -1 or sData = "- -" then
//		
//			SetNull(bBlob)
////			if dwTLC.RowCount() = 0 then
////				dwTLC.retrieve()
////			end if
//						
////			GetFullState(dwTLC, bBlob)
//			str_open_selection.lreturn = 1
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_tlc, str_open_selection)
//				
//			str_open_selection = Message.PowerObjectParm
//				
//			this.SetItem(lRow, "ntlc_to", str_open_selection.lReturn)
//			this.post SetItem(lRow, "cdest", f_check_three_letter_code_id(str_open_selection.lReturn))
//
//		else
//			
//			this.SetItem(lRow, "ntlc_to", lID)
//			
//		end if
//	
//
//	// ---------------------------
//	//  Frequenz
//	// ---------------------------
//	case "cfreq"
//		
//		if f_freq_to_number(this, lRow, sData) > 0 then
//			//
//			// Setzen der Computed Fields
//			//
//			this.post setitem(lRow, "cfreq", f_freq_to_string(this, lRow))
//		else
//			return 1
//		end if
//			
//		
//	// ---------------------------
//	//  G$$HEX1$$fc00$$ENDHEX$$ltig von
//	// ---------------------------
//	case "dvalid_from"
//		
//		if not isdate(sData) then
//			return 1
//		end if
//		
//		if date(sData) > date(this.GetItemDateTime(lRow,"dvalid_to")) then
//			//
//			// Validation-Message wird modifiziert
//			//
//			uf_setmessage(sField,"G$$HEX1$$fc00$$ENDHEX$$ltig ab mu$$HEX2$$df002000$$ENDHEX$$kleiner G$$HEX1$$fc00$$ENDHEX$$ltig bis sein!")
//			//
//			// sorgt f$$HEX1$$fc00$$ENDHEX$$r das zur$$HEX1$$fc00$$ENDHEX$$cksetzen der Default-Meldung:
//			//
//			this.ivalidationchanged = 1			
//			return 1
//		end if
//	// ---------------------------
//	//  G$$HEX1$$fc00$$ENDHEX$$ltig ab
//	// ---------------------------
//	case "dvalid_to"
//		
//		if not isdate(sData) then
//			return 1
//		end if
//		
//		if date(sData) < date(this.GetItemDateTime(lRow,"dvalid_from")) then
//			uf_setmessage(sField,"G$$HEX1$$fc00$$ENDHEX$$ltig bis mu$$HEX2$$df002000$$ENDHEX$$gr$$HEX2$$f600df00$$ENDHEX$$er G$$HEX1$$fc00$$ENDHEX$$ltig ab sein!")
//			this.ivalidationchanged = 1			
//			return 1
//		end if
//	// ---------------------------
//	//  Betrieb
//	// ---------------------------
//	case "cunit_text"
//
//		sUnit = f_unit(sData) 
//
//		if sUnit = "Error" then
//			SetNull(bBlob)
//			str_open_selection.bData = bBlob
//			
//			OpenWithParm(w_select_unit, str_open_selection)
//			
//			str_open_selection = Message.PowerObjectParm
//
//			this.SetItem(lRow, "cunit", str_open_selection.sReturn)
//			this.Post SetItem(lRow, "cunit_text", f_unit_to_fullname(str_open_selection.sReturn))
//			
//		else
//			
//			this.SetItem(lRow, "cunit", sUnit)
//			this.Post SetItem(lRow, "cunit_text", f_unit_to_fullname(sUnit))
//		end if
//
//	// ---------------------------
//	// Kunde (als Airlinecode)
//	// ---------------------------
//	case "ccustomer"
//
//		lRet = f_airline_to_number(sData)
//		
//		if lRet = -1 then
//						
//			str_open_selection.lreturn = 1
//			SetNull(bBlob)
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_airline, str_open_selection)
//			
//			str_open_selection = Message.PowerObjectParm
//			
//			this.SetItem(lRow, "ncustomer_key", str_open_selection.lReturn)
//			this.Post SetItem(lRow, "ccustomer", f_airline_to_string(str_open_selection.lReturn))
//			
//		else
//			this.SetItem(lRow, "ncustomer_key", lRet)
//			
//		end if
//
//	// ---------------------------
//	//  Zeiten
//	// ---------------------------
//	case "cdeparture_time"
//		this.Post SetItem(lrow, "cdeparture_time", f_string_to_timestring(sData)) 
//
//	case "carrival_time"
//		this.Post SetItem(lrow, "carrival_time", f_string_to_timestring(sData))
//
//	case "cblock_time"
//		this.Post SetItem(lrow, "cblock_time", f_string_to_timestring(sData))
//	
//	case "ctime_from"
//		this.Post SetItem(lrow, "ctime_from", f_string_to_timestring(sData))
//
//	case "ctime_to"
//		this.Post SetItem(lrow, "ctime_to", f_string_to_timestring(sData))
//		
//	// ---------------------------
//	//  Risikotr$$HEX1$$e400$$ENDHEX$$ger
//	// ---------------------------
//	case "crisk_owner"
//		
//		lRet = f_airline_to_number(sData)
//		
//		if lRet = -1 then
//						
//			str_open_selection.lreturn = 1
//			SetNull(bBlob)
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_airline, str_open_selection)
//			
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(lrow, "nrisk_owner", str_open_selection.lReturn)
//			
//			this.Post SetItem(lrow, "crisk_owner",f_airline_to_string(str_open_selection.lReturn))
//			
//		else
//			
//			this.SetItem(lrow, "nrisk_owner", lRet)
//		
//			
//		end if
//	
//	// ----------------------------------------
//	//  Weiterf$$HEX1$$fc00$$ENDHEX$$hrende Airline (Flugnummer)
//	// ----------------------------------------	
//	case "conward_airline"
//		
//		lRet = f_airline_to_number(sData)
//		
//		if lRet = -1 then
//						
//			str_open_selection.lreturn = 1
//			SetNull(bBlob)
//			str_open_selection.bData = bBlob
//					
//			OpenWithParm(w_select_airline, str_open_selection)
//			
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(lrow, "nonward_airline", str_open_selection.lReturn)
//			
//			this.Post SetItem(lrow, "conward_airline",f_airline_to_string(str_open_selection.lReturn))
//		else
//			
//			this.SetItem(lrow, "nonward_airline", lRet)
//		
//			
//		end if
//		
//	// ---------------------------
//	//  Packinglist-Detail
//	// ---------------------------
//	case "cpackinglist_detail"
//		
//		lKey = f_get_packinglist_key(sData)
//		if lKey > 0 then
//			//
//			// Setzen der Computed Fields
//			//
//			this.post setitem(lRow, "ndetail_key",lKey)
//			this.post setitem(lRow, "cpackinglist_text",f_check_packinglist_text(lKey,&
//																			this.GetItemDateTime(lRow,"dvalid_from"),&
//																			this.GetItemDateTime(lRow,"dvalid_to")  ))
//		else
//			return 1
//		end if
//		
//
//end choose

return 0
end event

on uo_form_detail_datawindow.create
end on

on uo_form_detail_datawindow.destroy
end on

event doubleclicked;call super::doubleclicked;// -------------------------------------
// Eingaben pr$$HEX1$$fc00$$ENDHEX$$fen 3-Letter-Codes
// -------------------------------------

long 		lId, &
			lFound, &
			lKey, &
			lFlight, &
			lGroupKey, &
			lRet

String 	sSuffix, sObject

Blob bBlob

s_select_tlc str_open_selection

// ----------------------------------------------------------
// Wenn das DW disabled ist dann machen wir nat$$HEX1$$fc00$$ENDHEX$$rlich nichts
// ----------------------------------------------------------
if UPPER(this.Object.DataWindow.ReadOnly) = "YES" then
	return 0
end if



if row <= 0 then
	return 0
end if


//choose case dwo.name
//		
//	// ---------------------------
//	//  Routing
//	// ---------------------------
//	case "crout"
//		
//		str_open_selection.lreturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1
//		OpenWithParm(w_select_rout, str_open_selection)
//		str_open_selection = Message.PowerObjectParm
//		
//		if str_open_selection.lReturn <> -1 then
//			this.SetItem(row, "nrouting_id", str_open_selection.lReturn)
//			this.SetItem(row, "crout", f_rout_to_string(str_open_selection.lReturn))
//		end if
//			
//	// ---------------------------
//	//  Abfertigungsart
//	// ---------------------------
//	case "chandling_type"
//
//		str_open_selection.lreturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		//str_open_selection.lAirlineKey = 0
//		str_open_selection.iWithCancelButton = 1
//		OpenWithParm(w_select_abart, str_open_selection)
//					
//		str_open_selection = Message.PowerObjectParm
//		
//		if str_open_selection.lReturn <> -1 then
//			this.SetItem(row, "nhandling_type_key", str_open_selection.lReturn)
//			this.SetItem(row, "chandling_type", f_handling_to_string(str_open_selection.lReturn))
//
//		end if	
//		
//	// ---------------------------
//	//  3-Letter-Codes Departure
//	// ---------------------------
//	case "cdep"
//		
//		SetNull(bBlob)
////		if dwTLC.RowCount() = 0 then
////			dwTLC.retrieve()
////		end if
//		//
//		// Hier kommt der Blob zum Tragen:
//		// DataWindow mit 3-Letter-Codes wird in Blob der Struktur
//		// verpackt und an select-Fenster durchgereicht.
//		//
////		GetFullState(dwTLC, bBlob)
//		str_open_selection.lreturn = 1
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1			
//		OpenWithParm(w_select_tlc, str_open_selection)
//		
//		str_open_selection = Message.PowerObjectParm
//		
//		if str_open_selection.lReturn <> -1 then
//			this.SetItem(Row, "ntlc_from", str_open_selection.lReturn)
//			this.SetItem(Row, "cdep", f_check_three_letter_code_id(str_open_selection.lReturn))
//		end if
//
//	// ---------------------------
//	//  3-Letter-Codes Destination
//	// ---------------------------
//	case "cdest"
//	
//		SetNull(bBlob)
////		if dwTLC.RowCount() = 0 then
////			dwTLC.retrieve()
////		end if
//		//
//		// Hier kommt der Blob zum Tragen:
//		// DataWindow mit 3-Letter-Codes wird in Blob der Struktur
//		// verpackt und an select-Fenster durchgereicht.
//		//
////		GetFullState(dwTLC, bBlob)
//		str_open_selection.lreturn = 1
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1								
//		OpenWithParm(w_select_tlc, str_open_selection)
//			
//		str_open_selection = Message.PowerObjectParm
//
//		if str_open_selection.lReturn <> -1 then	
//			this.SetItem(Row, "ntlc_to", str_open_selection.lReturn)
//			this.SetItem(Row, "cdest", f_check_three_letter_code_id(str_open_selection.lReturn))
//		end if
//			
//	// ---------------------------
//	//  Betrieb
//	// ---------------------------
//	case "cunit_text"
//
//		str_open_selection.lReturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1								
//		
//		OpenWithParm(w_select_unit, str_open_selection)
//		
//		str_open_selection = Message.PowerObjectParm
//		
//		if str_open_selection.lReturn <> -1 then	
//			
//			this.SetItem(row, "cunit", str_open_selection.sReturn)
//			this.SetItem(row, "cunit_text", f_unit_to_fullname(str_open_selection.sReturn))
//			
//		end if
//		
//	// ---------------------------
//	//  Kunde
//	// ---------------------------
//	case "ccustomer"
//
//		str_open_selection.lreturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1										
//				
//		OpenWithParm(w_select_airline, str_open_selection)
//			
//		str_open_selection = Message.PowerObjectParm
//			
//		if str_open_selection.lReturn <> -1 then
//			this.SetItem(row, "ncustomer_key", str_open_selection.lReturn)
//			this.SetItem(row, "ccustomer", f_airline_to_string(str_open_selection.lReturn))
//		end if
//	
//	// ---------------------------
//	// Risikotr$$HEX1$$e400$$ENDHEX$$ger
//	// ---------------------------
//	case "crisk_owner"
//		
//		str_open_selection.lreturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1													
//		
//		OpenWithParm(w_select_airline, str_open_selection)
//
//		str_open_selection = Message.PowerObjectParm
//
//		if str_open_selection.lReturn <> -1 then		
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(row, "nrisk_owner", str_open_selection.lReturn)
//			this.SetItem(row, "crisk_owner",f_airline_to_string(str_open_selection.lReturn))
//		end if
//
//
//	// ---------------------------
//	// Weiterf$$HEX1$$fc00$$ENDHEX$$hrender Flug
//	// ---------------------------
//	case "conward_airline"
//		
//		str_open_selection.lreturn = 1
//		SetNull(bBlob)
//		str_open_selection.bData = bBlob
//		str_open_selection.iWithCancelButton = 1													
//		
//		OpenWithParm(w_select_airline, str_open_selection)
//
//		str_open_selection = Message.PowerObjectParm
//	
//		if str_open_selection.lReturn <> -1 then		
//			str_open_selection = Message.PowerObjectParm
//			this.SetItem(row, "nonward_airline", str_open_selection.lReturn)
//			this.SetItem(row, "conward_airline",f_airline_to_string(str_open_selection.lReturn))
//		end if
//		
//end choose

wParent.PostEvent('ue_masterupdate')

end event

event itemchanged;//
// Pr$$HEX1$$fc00$$ENDHEX$$fung der Eingaben
//
integer iRet

if row > 0 then
	iRet = this.trigger event ue_validation(dwo.name, row, data)
	
	if iRet <> 0 then
		return 1
	else
		this.of_timestamp(row)
	end if
end if

//
// Masterupdate
//
wParent.PostEvent('ue_masterupdate')

end event

event retrieveend;// -----------------------------------------------------------------------
// rowfocuschange nur ausf$$HEX1$$fc00$$ENDHEX$$hren,
// wenn dieses Fenster ein 
// Detail hat
// -----------------------------------------------------------------------

// -----------------------------------------------------------------------
// Beispiel:
// Nach einem Retrieve werden die f$$HEX1$$fc00$$ENDHEX$$r den Benutzer generierten Text-Felder
// $$HEX1$$fc00$$ENDHEX$$ber die entsprechenden Key-Values mit Werten gef$$HEX1$$fc00$$ENDHEX$$llt.
// Dabei mu$$HEX2$$df002000$$ENDHEX$$nat$$HEX1$$fc00$$ENDHEX$$rlich auch der Status der Row neutralisiert werden.
// -----------------------------------------------------------------------
long a
lEndBenchmark = CPU()

//if rowcount > 0 then
//	for a = 1 to rowcount
//		this.SetItem(a, "cdep", f_check_three_letter_code_id(this.GetItemNumber(a, "ntlc_from")))
//		this.SetItem(a, "cdest", f_check_three_letter_code_id(this.GetItemNumber(a, "ntlc_to")))
//		this.SetItem(a, "cfreq", f_freq_to_string(this, a))
//		this.SetItem(a, "cacowner", f_airline_to_string(this.GetItemNumber(a, "cen_aircraft_nairline_owner_key")))
//		this.SetItem(a, "ccustomer", f_airline_to_string(this.GetItemNumber(a, "ncustomer_key")))
//		this.SetItem(a, "caircraft_type", 	this.GetItemString(a, "cacowner") + " " + &
//														this.GetItemString(a, "cen_aircraft_cactype") + " [" + &
//														this.GetItemString(a, "cen_aircraft_cgalleyversion") + "] " + &
//														this.GetItemString(a, "cen_aircraft_cconfiguration"))
//
//		if not isNull(this.GetItemNumber(a, "nrisk_owner")) then
//			this.SetItem(a, "crisk_owner", f_airline_to_string(this.GetItemNumber(a, "nrisk_owner")))														
//		end if
//
//		if not isNull(this.GetItemNumber(a, "nonward_airline")) then
//			this.SetItem(a, "conward_airline", f_airline_to_string(this.GetItemNumber(a, "nonward_airline")))														
//		end if
//														
//		this.SetItemStatus(a, 0, Primary!, NotModified!)	// Ganze Row auf NotModified!
//	next
//	
//end if

this.SetRedraw(true)

end event

event retrievestart;call super::retrievestart;this.SetRedraw(false)
lStartBenchmark = CPU()

end event

event rowfocuschanged;// ----------------------------
// Nur ausf$$HEX1$$fc00$$ENDHEX$$hren,
// wenn dieses Fenster ein 
// Detail hat!
// ----------------------------
	if this.GetColumnName() = this.sFirstColumn then
		This.Modify("datawindow.horizontalscrollposition = 0")
	end if
	
	// wParent.postevent("ue_row_info")
end event

event clicked;String sObject

iDragDrop = 1

if row > 0 then
	this.ScrollToRow(row)
end if

// ----------------------------------------------------------
// Ein- und Ausblenden der Gruppen-Details im Datawindow
// ----------------------------------------------------------
sObject = this.GetBandAtPointer()
this.trigger event ue_ellapse(sObject)
end event

event editchanged;call super::editchanged;//
// Reset der Validation-Message
//
if ivalidationchanged = 1 then

	this.trigger event ue_validation_messages(dwo.name)

	ivalidationchanged = 0
end if

end event

event constructor;call super::constructor;
s_choose_column 	strLoad
integer 				iRet
long 					lHeight



dsObjects = create datastore
dsObjects.dataobject = "dw_analyse_dw_objects"

this.of_get_status()

iRet = this.of_load_view(strLoad) 

if iRet = 0 then
	
	this.of_modify(strLoad)
	
end if 

this.Post of_set_detailheight()

	
end event

event ue_mouseup;call super::ue_mouseup;iDragDrop = 0


end event

event ue_mouseout;call super::ue_mouseout;//
// Mousemove
//
//if this.iDragDrop = 1 then
//	// -------------------------------
//	// Drag
//	// -------------------------------
//	Drag(Begin!)
//end if

end event

event rbuttondown;// ---------------------
// Kein Men$$HEX2$$fc002000$$ENDHEX$$..........
// ---------------------
end event

