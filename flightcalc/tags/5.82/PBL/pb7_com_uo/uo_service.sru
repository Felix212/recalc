HA$PBExportHeader$uo_service.sru
forward
global type uo_service from nonvisualobject
end type
end forward

global type uo_service from nonvisualobject
end type
global uo_service uo_service

type variables
s_errormessages s_errors[]

string 	sClassNameWindow
string 	sClassNameDw

string	sPictureNames[]
string	sTooltipText[]

datastore	dsTranslate


end variables

forward prototypes
private function string f_dw_translate_validations (string buffer)
private function string f_dw_translate_values (string buffer)
public function integer mbox (string arg_title, string arg_message, icon arg_icon, button arg_button, integer arg_default)
public function integer mbox (string arg_title, string arg_message)
public function integer mbox (string arg_title, string arg_message, icon arg_icon)
public function integer mbox (integer ierrornumber, string serrortext)
public subroutine get_errormessages ()
public subroutine translate_menu (window w_window)
public function integer mbox (integer ierrornumber)
public subroutine translate_menu (menu uomenu)
public function integer uf_log (string smsg)
public subroutine translate_window_old (window w_window)
public subroutine translate_window (window w_window)
public subroutine translate_datawindow (datawindow datawindowobj)
public subroutine translate_datastore (datastore datawindowobj)
public function boolean uf_create_datastore ()
public subroutine translate_object (windowobject owindowobject)
public function string translate (string stext)
public subroutine translate_userobject (userobject oobject)
public function integer html_help (long lwindow_handle, string swindow_classname, long lhelpid)
public function integer help (long lwindow_handle, string swindow_classname)
public function string dw_translate (string buffer)
public function integer help_with_id (long lwindow_handle, string swindow_classname, long largroleid)
public function integer uf_create_tooltip_list ()
public function string uf_tooltip (string stooltip, string spicture)
public function integer translate_child (datawindowchild datawindowobj)
end prototypes

private function string f_dw_translate_validations (string buffer);string sReturnstring
 
	// --------------------------------------------------------	
	// Scanning ValidationMessages
	// Achtung:
	// Diese k$$HEX1$$f600$$ENDHEX$$nnen mit ' beginnen
	// oder auch mit ~", je nachdem, ob sie im Datawindow
	//							mit " oder ' eingegeben wurden
	// --------------------------------------------------------	
	if Pos(Buffer, '"', 1) = 1 then
		//
		// doppelte Hochkommata
		//
		if Pos(Buffer, "~~", 1) = 2 then
			//
			// erster Fall
			//
			sReturnstring = mid(buffer,4,len(Buffer) -6)
			sReturnstring = translate(sReturnstring)
		else
			//
			// Normalfall
			//
			sReturnstring = mid(buffer,3,len(Buffer) -4)
			sReturnstring = translate(sReturnstring)
		end if
		// mu$$HEX2$$df002000$$ENDHEX$$nicht mehr sein, da beim Modify Hochkommata gesetzt werden!
		//sReturnstring = "~"~~~"" + sReturnstring + "~~~"~""
		//MessageBox("doppelte Hochkommata",sReturnstring)
	elseif Pos(Buffer, "'", 1) = 1 then
		//
		// einfache Hochkommata
		//
		sReturnstring = mid(buffer,2,len(Buffer) -2)
		sReturnstring = translate(sReturnstring)
		//MessageBox("einfache Hochkommata",sReturnstring)
	end if
	
	return sReturnstring
		
end function

private function string f_dw_translate_values (string buffer);// f_dw_translate_values
//
// Values kommen als EIN string!
// Bsp.: Belastung A, Gutschrift B, Storno S
// -> Belastung<tab>A/Gutschrift<tab>B/Storno<tab>S
// Diese Teile m$$HEX1$$fc00$$ENDHEX$$ssen separat $$HEX1$$fc00$$ENDHEX$$bersetzt und anschlie$$HEX1$$df00$$ENDHEX$$end wieder zusammengebaut werden!
//
long 		iBufferPos, iBufferPos2, iBufferPos3, iBufferLen, iDiff
string 	sReturnstring, sFront, sBack, sObject
 
Buffer = "/" + Buffer

iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1

DO WHILE True
	// ----------------------------
	// $$HEX1$$dc00$$ENDHEX$$bersetzung Values
	// ----------------------------
		iBufferPos = Pos(Buffer, "/",iBufferPos)
		If iBufferPos <= 0 Then 
			EXIT		
		End if
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos + 1)
		If iBufferPos2 <= 0 Then 
			Exit
		End if	
		
		iBufferPos3 = Pos(Buffer, "/",iBufferPos2)
		if iBufferPos3 = 0 then iBufferPos3 = iBufferlen
		
		sBack = mid(Buffer,iBufferPos2,iBufferPos3 + 1 - iBufferPos2)
		
		iDiff = iBufferPos2 - iBufferPos - 1
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos +1,iDiff)
		//
		sObject = translate(sObject)
		//
		sReturnstring += sObject + sBack
		iBufferPos = iBufferPos2
Loop	

return sReturnstring
end function

public function integer mbox (string arg_title, string arg_message, icon arg_icon, button arg_button, integer arg_default);integer 	rc, iTraceFile
string  	sModText, sModTitle

sModTitle = translate(arg_title)
sModText  = translate(arg_message)

if s_app.iMessageMode = 0 or s_app.iMessageMode = 2 then
	//
	// MessageBox
	//
	rc = MessageBox(sModTitle,sModText,arg_icon,arg_button,arg_default)
end if

if s_app.iMessageMode = 1 or s_app.iMessageMode = 2 then
	//
	// Tracing
	//
	iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)
	
	FileWrite(iTraceFile, s_app.sTitle + ":" + s_app.sVersion + ":" + s_app.sHost + ":" + s_app.sUser + ":" + &
								 String(Today(),"dd.mm.yyyy")+":"+String(Now())+":" + sModTitle + ":" + sModText)
	FileClose( iTraceFile)
end if

return rc

end function

public function integer mbox (string arg_title, string arg_message);integer 	rc, iTraceFile
string  	sModText, sModTitle

//RegistryGet("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\WINLOGON","DefaultUserName",sUser)
//RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\ComputerName\ComputerName","ComputerName",sHost)

sModTitle = translate(arg_title)
sModText  = translate(arg_message)

if s_app.iMessageMode = 0 or s_app.iMessageMode = 2 then
	//
	// MessageBox
	//
	rc = MessageBox(sModTitle,sModText)
end if

if s_app.iMessageMode = 1 or s_app.iMessageMode = 2 then
	//
	// Tracing
	//
	iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)
	
	FileWrite(iTraceFile, s_app.sTitle + ":" + s_app.sVersion + ":" + s_app.sHost + ":" + s_app.sUser + ":" + &
								 String(Today(),"dd.mm.yyyy")+":"+String(Now())+":" + sModTitle + ":" + sModText)
	FileClose( iTraceFile)
end if

return rc

end function

public function integer mbox (string arg_title, string arg_message, icon arg_icon);integer 	rc, iTraceFile
string  	sModText, sModTitle

sModTitle = translate(arg_title)
sModText  = translate(arg_message)

if s_app.iMessageMode = 0 or s_app.iMessageMode = 2 then
	//
	// MessageBox
	//
	rc = MessageBox(sModTitle,sModText,arg_icon)
end if

if s_app.iMessageMode = 1 or s_app.iMessageMode = 2 then
	//
	// Tracing
	//
	iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)
	
	FileWrite(iTraceFile, s_app.sTitle + ":" + s_app.sVersion + ":" + s_app.sHost + ":" + s_app.sUser + ":" + &
								 String(Today(),"dd.mm.yyyy")+":"+String(Now())+":" + sModTitle + ":" + sModText)
	FileClose( iTraceFile)
end if

return rc

end function

public function integer mbox (integer ierrornumber, string serrortext);//
// mbox (integer) - Die MessageBox f$$HEX1$$fc00$$ENDHEX$$r die Standard-Fehlermeldungen und Spr$$HEX1$$fc00$$ENDHEX$$che
//
integer 	rc, iTraceFile, i
string  	sTitle, sText
boolean	bFound = FALSE

sTitle = "Database Error"

For i = 1 to Upperbound(s_errors)
	if s_errors[i].lerrornumber = ierrornumber then
		sText  = s_errors[i].serrortext
		bFound = True
		Exit
	end if
Next

if bFound = False then
	sText = "Datenbank Fehlercode: " + string(ierrornumber)
	sText = sText + char(13) + "Datenbank Fehlertext:" + + char(13) + char(13) + serrortext
	f_error_box("Datawindow Error",sText)
	w_error_box.bringtotop = True
end if


if s_app.iMessageMode = 0 or s_app.iMessageMode = 2 then
	//
	// MessageBox
	//
	if bFound = true then rc = MessageBox(sTitle,sText,StopSign!)
end if

if s_app.iMessageMode = 1 or s_app.iMessageMode = 2 then
	//
	// Tracing
	//
	iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)
	
	FileWrite(iTraceFile, s_app.sTitle + ":" + s_app.sVersion + ":" + s_app.sHost + ":" + s_app.sUser + ":" + &
								 String(Today(),"dd.mm.yyyy")+":"+String(Now())+":" + sTitle + ":" + sText)
	FileClose( iTraceFile)
end if

return rc

end function

public subroutine get_errormessages ();//
// get_errormessages
//

//
// Host-Variablen
//
long		lNumber, n, i
integer	iType
string	sMessage

//
// Einlesen der Fehlermeldungen
//
Declare error_curs Cursor for 
select ntype, nerrornumber, cerrortext
  from sys_errormessages;

open error_curs;
if sqlca.sqlcode <> 0 then
	mbox("Fehlermeldungen","Fehler bei open cursor " + string(sqlca.sqlcode) + "~r" + sqlca.sqlerrtext)
end if

Do While true
	Fetch error_curs
	 into :iType, 
	 		:lNumber, 
			:sMessage;
			
	if sqlca.sqlcode = 100 then
		exit
	end if
	
	if sqlca.sqlcode <> 100 and sqlca.sqlcode <> 0 then
		mbox("Fehlermeldungen","Fehler bei fetch cursor " + string(sqlca.sqlcode) + "~r" + sqlca.sqlerrtext)
	end if
	
	//
	// Counter, um Anzahl der Spalten zu z$$HEX1$$e400$$ENDHEX$$hlen
	//
	n++
	
	s_errors[n].itype 		 	= iType
	s_errors[n].lerrornumber 	= lNumber
	s_errors[n].serrortext		= sMessage
Loop

//
// Fehlermeldungen werden $$HEX1$$fc00$$ENDHEX$$bersetzt
//
For i = 1 to n
	s_errors[i].serrortext = translate(s_errors[i].serrortext)
Next

close error_curs;
if sqlca.sqlcode <> 0 then
	mbox("Fehlermeldungen","Fehler bei close cursor " + string(sqlca.sqlcode) + "~r" + sqlca.sqlerrtext)
end if

  
end subroutine

public subroutine translate_menu (window w_window);//
// $$HEX1$$dc00$$ENDHEX$$bersetze Men$$HEX1$$fc00$$ENDHEX$$texte und Microhelps der Men$$HEX1$$fc00$$ENDHEX$$punkte
//
long i, k, l, m, tot1, tot2, tot3, tot4

setpointer(HourGlass!)

tot1 = UpperBound(w_window.Menuid.Item)

FOR i = 1 to tot1
	// Find the position of the File item.
	w_window.Menuid.Item[i].text = translate(w_window.Menuid.Item[i].text)
	// Translate Microhelp
	w_window.Menuid.Item[i].Microhelp = translate(w_window.Menuid.Item[i].Microhelp)
	tot2 = UpperBound(w_window.Menuid.Item[i].Item)
	if tot2 >= 1 then
		FOR k = 1 to tot2
			// Find the Update item under File.
			if w_window.Menuid.Item[i].Item[k].Text <> '-' then
				w_window.Menuid.Item[i].Item[k].Text = translate(w_window.Menuid.Item[i].Item[k].Text)
				// Translate Microhelp
				w_window.Menuid.Item[i].Item[k].Microhelp 		= translate(w_window.Menuid.Item[i].Item[k].Microhelp)
				w_window.Menuid.Item[i].Item[k].ToolBarItemText = translate(w_window.Menuid.Item[i].Item[k].ToolBarItemText)
			end if
			
			tot3 = UpperBound(w_window.Menuid.Item[i].Item[k].Item)
			if tot3 >= 1 then
				FOR l = 1 to tot3
					if w_window.Menuid.Item[i].Item[k].Item[l].Text <> '-' then
						w_window.Menuid.Item[i].Item[k].Item[l].Text = translate(w_window.Menuid.Item[i].Item[k].Item[l].Text)
						// Translate Microhelp
						w_window.Menuid.Item[i].Item[k].Item[l].Microhelp 		= translate(w_window.Menuid.Item[i].Item[k].Item[l].Microhelp)
						w_window.Menuid.Item[i].Item[k].Item[l].ToolBarItemText = translate(w_window.Menuid.Item[i].Item[k].Item[l].ToolBarItemText)
					end if
					
					tot4 = UpperBound(w_window.Menuid.Item[i].Item[k].Item[l].Item)
					if tot4 >= 1 then
						//Messagebox("", "1")
						For m = 1 to tot4
							if w_window.Menuid.Item[i].Item[k].Item[l].Item[m].Text <> '-' then
								w_window.Menuid.Item[i].Item[k].Item[l].Item[m].Text = translate(w_window.Menuid.Item[i].Item[k].Item[l].Item[m].Text)
								// Translate Microhelp
								w_window.Menuid.Item[i].Item[k].Item[l].Item[m].Microhelp 			= translate(w_window.Menuid.Item[i].Item[k].Item[l].Item[m].Microhelp)
								w_window.Menuid.Item[i].Item[k].Item[l].Item[m].ToolBarItemText 	= translate(w_window.Menuid.Item[i].Item[k].Item[l].Item[m].ToolBarItemText)
							end if
						next
					end if
					
				Next
			end if
		NEXT
	end if
NEXT

setpointer(Arrow!)

end subroutine

public function integer mbox (integer ierrornumber);//
// mbox (integer) - Die MessageBox f$$HEX1$$fc00$$ENDHEX$$r die Standard-Fehlermeldungen und Spr$$HEX1$$fc00$$ENDHEX$$che
//
integer 	rc, iTraceFile, i
string  	sTitle, sText

sTitle = "Database Error"

For i = 1 to Upperbound(s_errors)
	if s_errors[i].lerrornumber = ierrornumber then
		sText  = s_errors[i].serrortext
	end if
Next

if s_app.iMessageMode = 0 or s_app.iMessageMode = 2 then
	//
	// MessageBox
	//
	rc = MessageBox(sTitle,sText,StopSign!)
end if

if s_app.iMessageMode = 1 or s_app.iMessageMode = 2 then
	//
	// Tracing
	//
	iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)
	
	FileWrite(iTraceFile, s_app.sTitle + ":" + s_app.sVersion + ":" + s_app.sHost + ":" + s_app.sUser + ":" + &
								 String(Today(),"dd.mm.yyyy")+":"+String(Now())+":" + sTitle + ":" + sText)
	FileClose( iTraceFile)
end if

return rc

end function

public subroutine translate_menu (menu uomenu);//
// $$HEX1$$dc00$$ENDHEX$$bersetze Men$$HEX1$$fc00$$ENDHEX$$texte und Microhelps der Men$$HEX1$$fc00$$ENDHEX$$punkte
//
long i, k, l, m, tot1, tot2, tot3, tot4

setpointer(HourGlass!)

tot1 = UpperBound(uoMenu.Item)

FOR i = 1 to tot1
	// Find the position of the File item.
	uoMenu.Item[i].text = translate(uoMenu.Item[i].text)
	// Translate Microhelp
	uoMenu.Item[i].Microhelp = translate(uoMenu.Item[i].Microhelp)
	tot2 = UpperBound(uoMenu.Item[i].Item)
	if tot2 >= 1 then
		FOR k = 1 to tot2
			// Find the Update item under File.
			if uoMenu.Item[i].Item[k].Text <> '-' then
				uoMenu.Item[i].Item[k].Text = translate(uoMenu.Item[i].Item[k].Text)
				// Translate Microhelp
				uoMenu.Item[i].Item[k].Microhelp = translate(uoMenu.Item[i].Item[k].Microhelp)
			end if
			tot3 = UpperBound(uoMenu.Item[i].Item[k].Item)
			if tot3 >= 1 then
				FOR l = 1 to tot3
					if uoMenu.Item[i].Item[k].Item[l].Text <> '-' then
						uoMenu.Item[i].Item[k].Item[l].Text = translate(uoMenu.Item[i].Item[k].Item[l].Text)
						// Translate Microhelp
						uoMenu.Item[i].Item[k].Microhelp = translate(uoMenu.Item[i].Item[k].Microhelp)
						
						tot4 = UpperBound(uoMenu.Item[i].Item[k].Item[l].Item)
						if tot4 >= 1 then
							//Messagebox("", "2")
							For m = 1 to tot4
								if uoMenu.Item[i].Item[k].Item[l].Item[m].Text <> '-' then
									uoMenu.Item[i].Item[k].Item[l].Item[m].Text = translate(uoMenu.Item[i].Item[k].Item[l].Item[m].Text)
									// Translate Microhelp
									uoMenu.Item[i].Item[k].Item[l].Item[m].Microhelp = translate(uoMenu.Item[i].Item[k].Item[l].Item[m].Microhelp)
								end if
							next
						end if
					end if
				Next
			end if
		NEXT
	end if
NEXT

setpointer(Arrow!)

end subroutine

public function integer uf_log (string smsg);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

integer iFile

//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------
iFile = FileOpen(f_gettemppath() + "cbase_translation_"+ gs_instance_name + "_" +string(today(), "yyyy-mm-dd")+".log", LineMode!, Write!, Shared!)
FileWrite(iFile, string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + " " + sMsg)
FileClose(iFile)

return 0

end function

public subroutine translate_window_old (window w_window);// --------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bersetze Objekte des Fensters
//
// 19.12.2000
// Tags von Buttons und UserObjects werden jetzt auch $$HEX1$$fc00$$ENDHEX$$bersetzt.
// --------------------------------------------------------------------------
integer i, j, k, l, m, n
integer iobjx, iobjy, iobjw, iobjh
boolean bTest
string sName
string sLBItems[], sEmpty[]
integer iPLBItems[], iEmpty[]


sClassNameWindow	= w_window.Classname()
sClassNameDW		= ""
if s_app.iLanguage = 1 then return

//
// Window-Title
//
w_window.title = translate(w_window.title)

//
// Window-Objects
//
windowobject the_object

object  type_obj

dropdownlistbox ddlb
dropdownpicturelistbox ddplb
commandbutton c_b
datawindow d_w
multilineedit m_l
singlelineedit s_l
statictext s_t
Groupbox g_b
Radiobutton r_b
Picture pic
Tab t_p
Tab tab_t_p
UserObject u_o, glob_u_o
UserObject sub_u_o
Checkbox c_bx
// Register all Window Controls
for i = 1 to UpperBound(w_window.Control[])
	
	the_object 	= w_window.Control[ i]
	sName 		= the_object.ClassName()
	type_obj 	= the_object.TypeOf( )
	
	// Get Control Var
	
	CHOOSE CASE type_obj

		CASE CommandButton!
			//
			// Der einfachste Fall: Button auf Window
			//
			c_b = the_object
			c_b.text = translate(c_b.text)
			c_b.tag = translate(c_b.tag)
			//MessageBox("Button",c_b.tag)

		Case Tab!
			t_p = the_object
			
			Windowobject tab_object
			object tab_type_object
			// 
			// Tabpage durchlaufen, besteht i.d.R. aus mehreren User-Objekten: den Pages
			//
			For j = 1 to Upperbound(t_p.Control[])
				tab_object = t_p.Control[j]
				tab_type_object = tab_object.TypeOf( )
				Choose Case tab_type_object
					Case CommandButton!
						//
						// kommt eher nicht vor
						//
						c_b = tab_object
	
						//MessageBox("inside Tab",c_b.text)
					Case UserObject!
						//
						// Eine Tabpage ist ein UserObject
						//
						u_o = tab_object
						Windowobject inside_tab_object
						object inside_tab_type_object
						//
						// "Userobject" Tabpage durchlaufen
						//
						For k = 1 to Upperbound(u_o.Control[])
							inside_tab_object = u_o.Control[k]
							inside_tab_type_object = inside_tab_object.TypeOf( )
						
							Choose Case inside_tab_type_object
								//
								// Alle Objekte der Tabpage aufsp$$HEX1$$fc00$$ENDHEX$$ren
								//
								Case CommandButton!
									c_b = inside_tab_object
									//MessageBox("inside Tab: CommandButton",c_b.text)
									c_b.text = translate(c_b.text)
									c_b.tag = translate(c_b.tag)
								CASE RadioButton!
									r_b = inside_tab_object
									r_b.text = translate(r_b.text)
								Case Statictext!
									s_t = inside_tab_object
									s_t.text = translate(s_t.text)
								Case DataWindow!
									d_w = inside_tab_object
									d_w.title = translate(d_w.title)
								Case Groupbox!			
									g_b = inside_tab_object
									g_b.text = translate(g_b.text)
								Case Checkbox!			
									c_bx = inside_tab_object
									c_bx.text = translate(c_bx.text)
								Case Tab!
									tab_t_p = inside_tab_object
									// Hier k$$HEX1$$f600$$ENDHEX$$nnten noch die $$HEX1$$dc00$$ENDHEX$$berschriften der 
									// Sub-Tabelle geholt werden.
									Windowobject subtab_object
									object subtab_type_object
									For l = 1 to Upperbound(tab_t_p.Control[])
										subtab_object = tab_t_p.Control[l]
										subtab_type_object = subtab_object.TypeOf( )
										Choose Case subtab_type_object
											Case UserObject!
												sub_u_o = subtab_object
												//MessageBox("Tab",sub_u_o.text + "," + sub_u_o.PowerTipText)
												sub_u_o.text = translate(sub_u_o.text)
												//MessageBox("Nach $$HEX1$$dc00$$ENDHEX$$bersetzung",sub_u_o.text)
												sub_u_o.PowerTipText = translate(sub_u_o.PowerTipText)
										End Choose
									Next
								// Neu: DropDownListBox
								Case DropDownListBox!
									ddlb = inside_tab_object
									if upperbound( ddlb.item ) < 1 then
										// Falls Listbox leer ist
										// exit
									end if
									For n = 1 to upperbound( ddlb.item )
										sLBItems[n] = translate(ddlb.item[n])
										//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
									Next
									For n = upperbound( sLBItems ) to 1 step -1
										ddlb.Deleteitem(n)
									Next
									For n = upperbound( sLBItems ) to 1 step -1
										ddlb.Insertitem(sLBItems[n],1)
										sLBItems[n] = ""
									Next
								// Neu: DropDownPictureListBox
								Case DropDownPictureListBox!
									ddplb = inside_tab_object
									if upperbound( ddplb.item ) < 1 then
										// Falls Listbox leer ist
										// exit
									end if
									For n = 1 to upperbound( ddplb.item )
										sLBItems[n] = translate(ddplb.item[n])
										iPLBItems[n] = ddplb.itempictureindex[n]
										//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
									Next
									For n = upperbound( sLBItems ) to 1 step -1
										ddplb.Deleteitem(n)
									Next
									For n = upperbound( sLBItems ) to 1 step -1
										ddplb.Insertitem(sLBItems[n],iPLBItems[n],1)
										sLBItems[n] = ""
									Next
									sLBItems 	= sEmpty[]
									iPLBItems 	= iEmpty[]
							End Choose
						Next
						// $$HEX1$$dc00$$ENDHEX$$berschrift Tabpage: u_o.text
						// TipText : u_o.PowerTipText
						//MessageBox("Tab",u_o.text + "," + u_o.PowerTipText)
						u_o.text = translate(u_o.text)
						u_o.PowerTipText = translate(u_o.PowerTipText)
				End Choose
			Next
			
		CASE Picture!
			pic = the_object
		
		CASE RadioButton!
			r_b = the_object
			r_b.text = translate(r_b.text)
		
		Case Statictext!
			s_t = the_object
			s_t.text = translate(s_t.text)
						
		Case Singlelineedit!
			s_l = the_object
						
		Case DataWindow!
			d_w = the_object
			d_w.title = translate(d_w.title)
						
		Case MultiLineedit!			
			m_l = the_object
			
		Case Groupbox!			
			g_b = the_object
			g_b.text = translate(g_b.text)
	
		Case Checkbox!			
			c_bx = the_object
			c_bx.text = translate(c_bx.text)

		Case DropDownPictureListBox!			
			ddplb = the_object
			if upperbound( ddplb.item ) < 1 then
				// Falls Listbox leer ist
				exit
			end if
			For n = 1 to upperbound( ddplb.item )
				sLBItems[n] = translate(ddplb.item[n])
				iPLBItems[n] = ddplb.itempictureindex[n]
				//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddplb.Deleteitem(n)
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddplb.Insertitem(sLBItems[n],iPLBItems[n],1)
				sLBItems[n] = ""
			Next

		Case DropDownListBox!			
			ddlb = the_object
			if upperbound( ddlb.item ) < 1 then
				// Falls Listbox leer ist
				exit
			end if
			For n = 1 to upperbound( ddlb.item )
				sLBItems[n] = translate(ddlb.item[n])
				//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddlb.Deleteitem(n)
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddlb.Insertitem(sLBItems[n],1)
				sLBItems[n] = ""
			Next

		Case UserObject!
			glob_u_o = the_object
			windowobject uo_objects
			object  		 uo_types
			// 
			// UserObject durchjuckeln
			//
			For m = 1 to Upperbound(glob_u_o.Control[])
				uo_objects = glob_u_o.Control[m]
				uo_types = uo_objects.TypeOf( )
				uo_objects.Tag = translate(uo_objects.Tag)

				Choose Case uo_types
					Case CommandButton!
						//
						// kommt im Filter-Fenster vor (commandbuttons serviert auf userobject)
						//
						c_b = uo_objects
						//MessageBox("inside Tab: CommandButton",c_b.text)
						c_b.text = translate(c_b.text)
						c_b.tag = translate(c_b.tag)
				end choose

				//MessageBox("UserObject! Control=" + string(m),string(uo_objects.Tag))
			Next			

		CASE ELSE
			// Dunno w_window Object!
	END CHOOSE
end for
sClassNameDw 		= ""
sClassNameWindow 	= ""
end subroutine

public subroutine translate_window (window w_window);// --------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bersetze Objekte des Fensters
//
// 19.12.2000
// Tags von Buttons und UserObjects werden jetzt auch $$HEX1$$fc00$$ENDHEX$$bersetzt.
// --------------------------------------------------------------------------
integer i, j, k, l, m, n

// Register all Window Controls
w_window.title = translate(w_window.title)

for i = 1 to UpperBound(w_window.Control[])

	translate_object(w_window.Control[i])

end for

end subroutine

public subroutine translate_datawindow (datawindow datawindowobj);//
// Alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der DataWindows
//
// 1. DataWindowObj.describe("DataWindow.Objects") liefert alle Objekte des Fensters
// 2. Diese in Array speichern
// 3. Feststellen, welches Objekt ein Textobjekt ist
// 4. Den zugeordneten Text f$$HEX1$$fc00$$ENDHEX$$r dieses Objekt holen
// 5. Text $$HEX1$$fc00$$ENDHEX$$bersetzen
//
// offen: alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der Validations
//
long 	iBufferPos
long 	iBufferPos2
long 	iBufferlen
long 	iPos, iDiff, iOffset
string	sObject, sReturnstring, buffer, sReturnstring1, sReturnstring2, sChild
boolean bIsValidation, bIsValue, bIsTextObject
String	ls_Tag
DataWindowChild dwcChild

if not isvalid(DataWindowObj) then
	return 
end if

buffer = DataWindowObj.describe("DataWindow.Objects")

iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1

sClassNameDw		= DataWindowObj.DataObject
sClassNameWindow	= ""


DO WHILE True
	// ----------------------------
	// $$HEX1$$dc00$$ENDHEX$$bersetzung $$HEX1$$dc00$$ENDHEX$$berschriften
	// ----------------------------
		//
		// Textobjekte haben i.d.R. keinen Namen und bekommen zur Laufzeit einen "internen"
		// Namen vergeben.
		//
		iBufferPos = Pos(Buffer, "obj",iBufferPos)
		If iBufferPos <= 0 Then 
			EXIT		
		End if
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos + 3)
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		sReturnstring = translate(sReturnstring)
		// $$HEX1$$dc00$$ENDHEX$$bersetzung zur$$HEX1$$fc00$$ENDHEX$$ck ins DW
		DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
				
		//MessageBox("Textobject: " + sObject,sReturnstring)
		
		iBufferPos = iBufferPos2
Loop	

//
// Texte, Validations, Values (01.01.3000 = offen): alle Objekte Scannen
//
buffer = DataWindowObj.describe("DataWindow.Objects")
iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1
DO WHILE True
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos)
		If iBufferPos2 <= 0 Then 
			//
			// +1, da das letzte Objekt sonst in der L$$HEX1$$e400$$ENDHEX$$nge falsch ermittelt wird (lang statt lang3)
			//
			iBufferPos2 = iBufferlen + 1
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		
		// ------------------------------------------------------------------------------------------
		// 20.11.2003
		// $$HEX1$$dc00$$ENDHEX$$bersetzung von Composite
		// ------------------------------------------------------------------------------------------
		if DataWindowObj.Describe("DataWindow.Processing")  = "5" and Lower(DataWindowObj.describe( sObject + ".Type")) = "report" then
			sChild = DataWindowObj.describe( sObject + ".name")
			DataWindowObj.GetChild(sChild, dwcChild)
			//Messagebox("", sChild)
			translate_child(dwcChild)
		end if
		
		
		if sReturnstring = "!" then
			//
			// Es ist kein Textobjekt -> es k$$HEX1$$f600$$ENDHEX$$nnte ein Column-Object sein
			//
			// Mal schauen, ob eine Validation oder Value (01.01.3000='offen') vorhanden ist
			//
			sReturnstring1 = DataWindowObj.describe( sObject + ".ValidationMsg")
			// Falls unbrauchbar liefert describe ein ?
			if sReturnstring1 <> "?" then bIsValidation = True
			sReturnstring2 = DataWindowObj.describe( sObject + ".Values")
			if sReturnstring2 <> "?" then bIsValue = True
		else
			bIsTextObject = True
		end if
			
		if bIsValidation then
			// $$HEX1$$dc00$$ENDHEX$$bersetzung der Validation-Message
			// liefert z.Zt. noch fehlerhafte Ergebnisse
			sReturnstring1 = f_dw_translate_validations(sReturnstring1)
			
			DataWindowObj.modify( sObject + ".ValidationMsg='" + sReturnstring1 + "'")
			//if MessageBox("Columnobject->ValidationMsg: " + sObject,sReturnstring1,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsValue then
			//
			// Values kommen als EIN string!
			// Bsp.: Belastung A, Gutschrift B, Storno S
			// -> Belastung<tab>A/Gutschrift<tab>B/Storno<tab>S
			// Diese Teile m$$HEX1$$fc00$$ENDHEX$$ssen separat $$HEX1$$fc00$$ENDHEX$$bersetzt und anschlie$$HEX1$$df00$$ENDHEX$$end wieder zusammengebaut werden!
			//
			sReturnstring2 = f_dw_translate_values(sReturnstring2)
			
			DataWindowObj.modify( sObject + ".Values='" + sReturnstring2 + "'")
			//if MessageBox("Columnobject->Values: " + sObject,sReturnstring2,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsTextObject then
			//sReturnstring = translate(sReturnstring)
			//DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
			
			// ----------------------------------------------------------------------------------------
			// Don't translate, if according tag value is set
			// ----------------------------------------------------------------------------------------
			ls_Tag = DataWindowObj.describe( sObject + ".tag")
			If Pos(ls_Tag, "DO_NOT_TRANSLATE") < 1 Then
				
				sReturnstring = translate(sReturnstring)
				DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
			End If

		end if
		
		// 17.10.2001: $$HEX1$$dc00$$ENDHEX$$bersetzung Checkbox
		sReturnstring = DataWindowObj.describe( sObject + ".checkbox.text")
		if sReturnstring <> "!" and sReturnstring <> "?" then
			sReturnstring = translate(sReturnstring)
			DataWindowObj.modify( sObject + ".checkbox.text='" + sReturnstring + "'")
			//MessageBox(sObject,DataWindowObj.describe( sObject + ".checkbox.text") + "," + &
			//				string(bIsValidation) + "," + string(bIsValue) + "," + string(bIsTextObject) )
		end if

		bIsValidation = False
		bIsValue = False
		bIsTextObject = False
		
		iBufferPos = iBufferPos2
		iBufferPos ++
		
		if iBufferPos2 >= iBufferlen then exit
Loop	

sClassNameDw 		= ""
sClassNameWindow 	= ""
end subroutine

public subroutine translate_datastore (datastore datawindowobj);//
// Alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der DataWindows
//
// 1. DataWindowObj.describe("DataWindow.Objects") liefert alle Objekte des Fensters
// 2. Diese in Array speichern
// 3. Feststellen, welches Objekt ein Textobjekt ist
// 4. Den zugeordneten Text f$$HEX1$$fc00$$ENDHEX$$r dieses Objekt holen
// 5. Text $$HEX1$$fc00$$ENDHEX$$bersetzen
//
// offen: alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der Validations
//
long 	iBufferPos, iBufferPos1
long 	iBufferPos2
long 	iBufferlen
long 	iPos, iDiff, iOffset
string	sObject, sReturnstring, buffer, sReturnstring1, sReturnstring2
boolean bIsValidation, bIsValue, bIsTextObject
String	ls_Tag
string	sChild
datawindowchild dwcChild

buffer = DataWindowObj.describe("DataWindow.Objects")

iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos1  = 1
iBufferPos2 = 1

sClassNameDw		= DataWindowObj.DataObject
sClassNameWindow	= ""
DO WHILE True
	// ----------------------------
	// $$HEX1$$dc00$$ENDHEX$$bersetzung $$HEX1$$dc00$$ENDHEX$$berschriften
	// ----------------------------
		//
		// Textobjekte haben i.d.R. keinen Namen und bekommen zur Laufzeit einen "internen"
		// Namen vergeben.
		//
		iBufferPos1 = iBufferPos
		iBufferPos = Pos(Buffer, "obj",iBufferPos)
		If iBufferPos <= 0 Then 
			// 08.02.2010 Ulrich Paudler [UP] machmal haben Texte aber einen Namen (der dann mit 't_' beginnt)
			iBufferPos = Pos(Buffer, "t_",iBufferPos1)
			If iBufferPos <= 0 Then 
				EXIT	
			end if
		End if
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos + 3)
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		sReturnstring = translate(sReturnstring)
		// $$HEX1$$dc00$$ENDHEX$$bersetzung zur$$HEX1$$fc00$$ENDHEX$$ck ins DW
		DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
		//MessageBox("Textobject: " + sObject,sReturnstring)
		
		iBufferPos = iBufferPos2
Loop	

//
// Texte, Validations, Values (01.01.3000 = offen): alle Objekte Scannen
//
buffer = DataWindowObj.describe("DataWindow.Objects")
iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1
DO WHILE True
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos)
		If iBufferPos2 <= 0 Then 
			//
			// +1, da das letzte Objekt sonst in der L$$HEX1$$e400$$ENDHEX$$nge falsch ermittelt wird (lang statt lang3)
			//
			iBufferPos2 = iBufferlen + 1
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		
		// ------------------------------------------------------------------------------------------
		// 20.11.2003
		// $$HEX1$$dc00$$ENDHEX$$bersetzung von Composite
		// ------------------------------------------------------------------------------------------
		if DataWindowObj.Describe("DataWindow.Processing")  = "5" and Lower(DataWindowObj.describe( sObject + ".Type")) = "report" then
			sChild = DataWindowObj.describe( sObject + ".name")
			DataWindowObj.GetChild(sChild, dwcChild)
			//Messagebox("", sChild)
			translate_child(dwcChild)
		end if
		
		if sReturnstring = "!" then
			//
			// Es ist kein Textobjekt -> es k$$HEX1$$f600$$ENDHEX$$nnte ein Column-Object sein
			//
			// Mal schauen, ob eine Validation oder Value (01.01.3000='offen') vorhanden ist
			//
			sReturnstring1 = DataWindowObj.describe( sObject + ".ValidationMsg")
			// Falls unbrauchbar liefert describe ein ?
			if sReturnstring1 <> "?" then bIsValidation = True
			sReturnstring2 = DataWindowObj.describe( sObject + ".Values")
			if sReturnstring2 <> "?" then bIsValue = True
		else
			bIsTextObject = True
		end if
			
		if bIsValidation then
			// $$HEX1$$dc00$$ENDHEX$$bersetzung der Validation-Message
			// liefert z.Zt. noch fehlerhafte Ergebnisse
			sReturnstring1 = f_dw_translate_validations(sReturnstring1)
			
			DataWindowObj.modify( sObject + ".ValidationMsg='" + sReturnstring1 + "'")
			//if MessageBox("Columnobject->ValidationMsg: " + sObject,sReturnstring1,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsValue then
			//
			// Values kommen als EIN string!
			// Bsp.: Belastung A, Gutschrift B, Storno S
			// -> Belastung<tab>A/Gutschrift<tab>B/Storno<tab>S
			// Diese Teile m$$HEX1$$fc00$$ENDHEX$$ssen separat $$HEX1$$fc00$$ENDHEX$$bersetzt und anschlie$$HEX1$$df00$$ENDHEX$$end wieder zusammengebaut werden!
			//
			sReturnstring2 = f_dw_translate_values(sReturnstring2)
			
			DataWindowObj.modify( sObject + ".Values='" + sReturnstring2 + "'")
			//if MessageBox("Columnobject->Values: " + sObject,sReturnstring2,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsTextObject then
			//sReturnstring = translate(sReturnstring)
			//DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
			
			// ----------------------------------------------------------------------------------------
			// Don't translate, if according tag value is set
			// ----------------------------------------------------------------------------------------
			ls_Tag = DataWindowObj.describe( sObject + ".tag")
			If Pos(ls_Tag, "DO_NOT_TRANSLATE") < 1 Then
				
				sReturnstring = translate(sReturnstring)
				DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
			End If
			
		end if
		
		// 17.10.2001: $$HEX1$$dc00$$ENDHEX$$bersetzung Checkbox
		sReturnstring = DataWindowObj.describe( sObject + ".checkbox.text")
		if sReturnstring <> "!" and sReturnstring <> "?" then
			sReturnstring = translate(sReturnstring)
			DataWindowObj.modify( sObject + ".checkbox.text='" + sReturnstring + "'")
			//MessageBox(sObject,DataWindowObj.describe( sObject + ".checkbox.text") + "," + &
			//				string(bIsValidation) + "," + string(bIsValue) + "," + string(bIsTextObject) )
		end if

		bIsValidation = False
		bIsValue = False
		bIsTextObject = False
		
		iBufferPos = iBufferPos2
		iBufferPos ++
		
		if iBufferPos2 >= iBufferlen then exit
Loop	

sClassNameDw 		= ""
sClassNameWindow 	= ""
end subroutine

public function boolean uf_create_datastore ();string	sdwsyntax
string	sColumn
integer	iPos
// ------------------------------------------------------
// entsprechend der gew$$HEX1$$e400$$ENDHEX$$hlten Sprache die Column setzen
// ------------------------------------------------------
dsTranslate = create datastore
dsTranslate.DataObject 				= "dw_translation_service"
dsTranslate.Settransobject(SQLCA)

If s_app.ilanguage = 1 Then
	sColumn = "cgerman"
ElseIf s_app.ilanguage = 2 Then
	sColumn = "cenglish"
ElseIf s_app.ilanguage = 3 Then
	sColumn = "clanguage3"
ElseIf s_app.ilanguage = 4 Then
	sColumn = "clanguage4"
ElseIf s_app.ilanguage = 5 Then
	sColumn = "clanguage5"
End if	
sdwsyntax =   "SELECT cpurpose,cgerman " + & 
				  "FROM sys_translate ORDER BY sys_translate.cpurpose ASC"

sdwsyntax = Replace(sdwsyntax,17,7,sColumn)
dsTranslate.SetSQLSelect(sdwsyntax)
dsTranslate.retrieve()


If dsTranslate.Rowcount() > 0 Then
	uf_create_tooltip_list()
	return True
Else
	return False
End if	



end function

public subroutine translate_object (windowobject owindowobject);// --------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bersetze Objekte des Fensters
//
// 19.12.2000
// Tags von Buttons und UserObjects werden jetzt auch $$HEX1$$fc00$$ENDHEX$$bersetzt.
// --------------------------------------------------------------------------
integer i, j, k, l, m, n
integer iobjx, iobjy, iobjw, iobjh
boolean bTest
string sName
string sLBItems[], sEmpty[]
integer iPLBItems[], iEmpty[]
String sToolTip,  sPicture

object  						oObjectType
Tab 							oSubTabObject
sClassNameDW		= ""

object  type_obj

dropdownlistbox ddlb
dropdownpicturelistbox ddplb
commandbutton c_b
PictureButton pb_b
datawindow d_w
multilineedit m_l
singlelineedit s_l
statictext s_t
Groupbox g_b
Radiobutton r_b
Picture pic
Tab t_p
Tab tab_t_p
UserObject u_o, glob_u_o, oSubUserObject
UserObject sub_u_o
Checkbox c_bx

// Register all Window Controls
oObjectType = oWindowObject.TypeOf()

//sName 		= oWindowObject.ClassName()
type_obj 	= oWindowObject.TypeOf()
	
// Get Control Var
	
CHOOSE CASE type_obj

	CASE CommandButton!
		//
		// Der einfachste Fall: Button auf Window
		//
		c_b = oWindowObject
		c_b.text = translate(c_b.text)
		c_b.tag = translate(c_b.tag)
		//MessageBox("Button",c_b.tag)
		
		
	CASE PictureButton!
		// ---------------------------------------------------------
		// Der (zweit-)einfachste Fall: PictureButton auf Window
		// ---------------------------------------------------------
		pb_b = oWindowObject
		pb_b.text = translate(pb_b.text)
		pb_b.tag = translate(pb_b.tag)
		
		sToolTip = translate(pb_b.PowerTipText)
		sPicture = pb_b.PictureName
		pb_b.PowerTipText = uf_tooltip(sToolTip, sPicture)
		
	Case Tab!
		t_p = oWindowObject
		oSubTabObject= oWindowObject
		For n = 1 to Upperbound(oSubTabObject.Control[])
			translate_object(oSubTabObject.Control[n])
		Next
		
	Case UserObject!
		oSubUserObject = oWindowObject
		
		oSubUserObject.Text = translate(oSubUserObject.text)
		For m = 1 to Upperbound(oSubUserObject.Control[])
			translate_object(oSubUserObject.Control[m])
		Next				
	
	CASE Picture!
		pic = oWindowObject
	
	CASE RadioButton!
		r_b = oWindowObject
		r_b.text = translate(r_b.text)
	
	Case Statictext!
		s_t = oWindowObject
		s_t.text = translate(s_t.text)
					
	Case Singlelineedit!
		s_l = oWindowObject
					
	Case DataWindow!
		d_w = oWindowObject
		d_w.title = translate(d_w.title)
					
	Case MultiLineedit!			
		m_l = oWindowObject
		
	Case Groupbox!			
		g_b = oWindowObject
		g_b.text = translate(g_b.text)

	Case Checkbox!			
		c_bx = oWindowObject
		c_bx.text = translate(c_bx.text)

	Case DropDownPictureListBox!			
		ddplb = oWindowObject
		if upperbound( ddplb.item ) >= 1 then

			For n = 1 to upperbound( ddplb.item )
				sLBItems[n] = translate(ddplb.item[n])
				iPLBItems[n] = ddplb.itempictureindex[n]
				//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddplb.Deleteitem(n)
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddplb.Insertitem(sLBItems[n],iPLBItems[n],1)
				sLBItems[n] = ""
			Next
			
		end if

	Case DropDownListBox!			
		ddlb = oWindowObject
		
		if upperbound( ddlb.item ) >= 1 then
			
			For n = 1 to upperbound( ddlb.item )
				sLBItems[n] = translate(ddlb.item[n])
				//MessageBox("DropDownListBox item " + string(n),sLBItems[n])
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddlb.Deleteitem(n)
			Next
			For n = upperbound( sLBItems ) to 1 step -1
				ddlb.Insertitem(sLBItems[n],1)
				sLBItems[n] = ""
			Next
			
		end if

	CASE ELSE
		// Dunno w_window Object!
END CHOOSE

sClassNameDw 		= ""
sClassNameWindow 	= ""
end subroutine

public function string translate (string stext);//Wenn das Translate DataStore noch nicht initialisiert wurde, geben wir den nicht $$HEX1$$fc00$$ENDHEX$$bersetzten Text zur$$HEX1$$fc00$$ENDHEX$$ck
if not isValid(dsTranslate) then return stext

// -------------------------------------------------------------------------------
// Besonderheiten:
// Sub-Strings m$$HEX1$$fc00$$ENDHEX$$ssen mit { beginnen, damit sie korrekt interpretiert werden!
// -------------------------------------------------------------------------------
	string 				sTranslation
	string 				sSelectText
	string 				sSQLStmt
	string 				sLanguage
	boolean 				bMessageBox = False, bSub = False, bLeadingSpaces = False
	
	long 					iBufferStart, iBufferEnd, i, j, n, k, m, lSubStart, lSubEnd, lSub
	string 				sFront, sBack, sMiddle, sParameter
	string 				sArguments[]
	long					lSQLCODE
	long					lUsed
	
	
	long					a, b, lSuffix, lPosition, lLength
	string				sFinish, sSuffix
	string				sMark[5] = {"!","."," ",":","?"}
	long					lFound
	
// ----------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$hrende Spaces l$$HEX1$$f600$$ENDHEX$$schen und merken
// ----------------------------------------------------------
	sParameter  = sText
	sSelectText = LeftTrim(sText)
	if len(sText) > len(sSelectText) then bLeadingSpaces = True
	if len(trim(sSelectText)) = 0 then return sSelectText

// -----------------------------------------------------------
// Satzendezeichen merken, l$$HEX1$$f600$$ENDHEX$$schen und sp$$HEX1$$e400$$ENDHEX$$ter wieder anf$$HEX1$$fc00$$ENDHEX$$gen
// -----------------------------------------------------------
	lLength = len(sSelectText)
	for a = lLength to 1 step -1
		sFinish = mid(sSelectText,a,1)
		lPosition = 0
		for b = 1 to 5
			if sFinish = sMark[b] then
				lSuffix++
				lPosition++
			end if
		next
		if lPosition = 0 then
			exit
		end if
	next

	if lSuffix > 0 then
		sSuffix = Right(sSelectText,lSuffix)
		sSelectText = Mid(sSelectText,1,lLength - lSuffix)
	end if

	Choose Case s_app.iLanguage
		Case 1
			sLanguage = "cgerman"
		Case 2
			sLanguage = "cenglish"
		Case 3
			sLanguage = "clanguage3"
		Case 4
			sLanguage = "clanguage4"
		Case 5
			sLanguage = "clanguage5"
	End Choose

// -----------------------------------------------------------
// Umsetzung der $Schl$$HEX1$$fc00$$ENDHEX$$sselw$$HEX1$$f600$$ENDHEX$$rter
// -----------------------------------------------------------
	iBufferstart = 1
	iBufferEnd = len(sSelectText)
	
	Do While i <= iBufferEnd 
		i = pos(sSelectText,"$",iBufferstart)
		if i = 0 then exit
		if i > 0 then 
			m = pos(sSelectText,"{",i)
			
			if m > 0 then
				//
				// Die neue Methode
				//
				bMessageBox = True
				// Variableninhalte aus text entfernen
				j = pos(sSelectText," ",i)
				
				//
				// Es k$$HEX1$$f600$$ENDHEX$$nnte auch ein . oder ein anderes Satzzeichen hinter einer Variablen kommen
				//
				k = j
				k = pos(sSelectText,".",i)
				// Es k$$HEX1$$f600$$ENDHEX$$nnte auch ein . nach einer Variablen kommen
				if (k > 0) and (k < j) then j = k
				
				// Neu: komplette Sub-Strings nicht $$HEX1$$fc00$$ENDHEX$$bersetzen
				lSubStart = Pos(sSelectText,"{",i)
				lSubEnd	 = Pos(sSelectText,"}",i)
				// Ist der Sub-String direkt hinter dem $ ?
				if lSubStart = (i + 1) then 
					bSub = true
					j = lSubEnd + 1
				end if
		
				// Falls Variable das Letzte Element in der Zeichenkette
				if j = 0 then j = iBufferEnd + 1
				//MessageBox("L$$HEX1$$e400$$ENDHEX$$nge",string (i) + " bis " + string(j))
				sFront = Left(sSelectText,i)
				sBack = Mid(sSelectText,j)
				n++
				
				if bSub = true then
					sMiddle = Mid(sSelectText,i +2,j -i -3)
				else
					sMiddle = Mid(sSelectText,i +1,j -i -1)
				end if
				sArguments[n] = sMiddle
				//
				// sMid sollte sich den Inhalt der Variablen in einem Array merken
				// Dieser Array wird nach dem $$HEX1$$dc00$$ENDHEX$$bersetzen ausgelesen und der Text entsprechend erg$$HEX1$$e400$$ENDHEX$$nzt
				// 
				sSelectText = sFront + sBack
				iBufferEnd = len(sSelectText)
				bSub = False
			else
				//
				// Die alte Methode
				//
				bMessageBox = True
				// Variableninhalte aus text entfernen
				j = pos(sSelectText," ",i)
			
				//
				// Es k$$HEX1$$f600$$ENDHEX$$nnte auch ein . oder ein anderes Satzzeichen hinter einer Variablen kommen
				//
				k = j
				k = pos(sSelectText,".",i)
				// Es k$$HEX1$$f600$$ENDHEX$$nnte auch ein . nach einer Variablen kommen
				if (k > 0) and (k < j) then j = k
			
				// Neu: komplette Sub-Strings nicht $$HEX1$$fc00$$ENDHEX$$bersetzen
				lSub = Pos(sSelectText,"}",i)
				if lSub > 0 then j = lSub + 1
		
				// Falls Variable das Letzte Element in der Zeichenkette
				if j = 0 then j = iBufferEnd + 1
				//MessageBox("L$$HEX1$$e400$$ENDHEX$$nge",string (i) + " bis " + string(j))
				sFront = Left(sSelectText,i)
				sBack = Mid(sSelectText,j)
				n++
				if lSub > 0 then
					sMiddle = Mid(sSelectText,i +1,j -i -2)
				else
					sMiddle = Mid(sSelectText,i +1,j -i -1)
				end if
				sArguments[n] = sMiddle
				//
				// sMid sollte sich den Inhalt der Variablen in einem Array merken
				// Dieser Array wird nach dem $$HEX1$$dc00$$ENDHEX$$bersetzen ausgelesen und der Text entsprechend erg$$HEX1$$e400$$ENDHEX$$nzt
				// 
				sSelectText = sFront + sBack
				iBufferEnd = len(sSelectText)
			end if
		end if
		iBufferstart = i + 1
	Loop
// -----------------------------------------------------------
// und nun der Find im Datastore
// -----------------------------------------------------------
	lFound = dsTranslate.Find("upper(cpurpose) = '" + upper(sSelectText) + "'",1,dsTranslate.Rowcount())
	If lFound > 0 Then
		sTranslation = dsTranslate.Getitemstring(lFound,"ctranslation")
	Else	
		sTranslation = sSelectText
		
		// -----------------------------------------------------------
		// Nicht gefunden, ggf. loggen
		// -----------------------------------------------------------
		if s_app.iTrace  = 1 then
			this.uf_log("[" + sParameter + "]=[" + sSelectText + "] - not found!")
		end if
		
	End if
// -----------------------------------------------------------
// Einf$$HEX1$$fc00$$ENDHEX$$gen der Variablen in den $$HEX1$$fc00$$ENDHEX$$bersetzten String
// -----------------------------------------------------------
	if bMessageBox Then
		iBufferstart = 1
		j=0
		For i=1 to upperbound(sArguments)
			j = pos(sTranslation,"$",iBufferstart)
			sFront = Left(sTranslation,j -1)
			sBack = Mid(sTranslation,j+1)
			sTranslation = sFront + sArguments[i] + sBack
			iBufferstart = j + 1 + len(sArguments[i])
		Next
	end if

// -----------------------------------------------------------
// Satzendezeichen wieder einf$$HEX1$$fc00$$ENDHEX$$gen
// -----------------------------------------------------------
	if lSuffix > 0 then
		sTranslation = sTranslation + sSuffix
	end if

// -----------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$hrende Leerzeichen wieder einsetzen
// -----------------------------------------------------------
	if bLeadingSpaces = True then
		sTranslation = "  " + sTranslation
	end if

	return sTranslation
end function

public subroutine translate_userobject (userobject oobject);// --------------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bersetze Objekte des Fensters
//
// 19.12.2000
// Tags von Buttons und UserObjects werden jetzt auch $$HEX1$$fc00$$ENDHEX$$bersetzt.
// --------------------------------------------------------------------------
integer i, j, k, l, m, n

// Register all Window Controls
//w_window.title = translate(w_window.title)

for i = 1 to UpperBound(oObject.Control[])

	translate_object(oObject.Control[i])

end for

end subroutine

public function integer html_help (long lwindow_handle, string swindow_classname, long lhelpid);//
// help
//
// sample call
// uf.help( handle(parent), parent.classname())
//
string	sPagename
boolean	bReturn

//
// HtmlHelp (global external function)
//
// Parameter: window-handle, helpfilename, invocation, pagename
//
// HtmlHelp( handle(parent), "..\help\PBHTMLHelp.chm", HH_DISPLAY_TOPIC, "Welcome.htm" )
//

//
// Achtung: Wenn Dokumente in einem zus$$HEX1$$e400$$ENDHEX$$tzlichen Verzeichnis gespeichert sind, mu$$HEX2$$df002000$$ENDHEX$$dieses
// dem Dokumentennamen vorangestellt werden!
//
sPagename = "templates\" + swindow_classname + ".htm"


//sPagename = 
//sPagename = swindow_classname + ".htm"
//sPagename = swindow_classname + ".htm"

//MessageBox("handle(parent)",lwindow_handle)
//MessageBox("sPagename",sPagename)
//MessageBox("s_app.sHelpFile",s_app.sHelpFile)

// ----------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob $$HEX1$$fc00$$ENDHEX$$berhaupt ein Internetexplorer mit der Version 4.0 oder gr$$HEX2$$f600df00$$ENDHEX$$er
// installiert ist
// ----------------------------------------------------------------------------

String 	sVersion
Integer 	iVersion
If RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer","Version",RegString!, sVersion) <> 1 Then
	uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~n muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", StopSign!)
	return -1
else
	iVersion = Integer(Mid(sVersion, 1, 1))
	
	if iVersion < 4 then
		uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~n muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", Information!)		
		return -1
	end if
	
End if


//bReturn = HtmlHelp( lwindow_handle, s_app.sHelpFile, HH_DISPLAY_TOPIC, sPagename)
breturn = HtmlHelp( lwindow_handle, s_app.sHelpFile,HH_HELP_CONTEXT, lhelpid)

// bReturn, leider immer True
//


return 0

end function

public function integer help (long lwindow_handle, string swindow_classname);string	sPagename
boolean	bReturn

String 	sVersion
Integer 	iVersion


// ----------------------------------------------------------------------------
// HtmlHelp (global external function)
//
// Parameter: window-handle, helpfilename, invocation, pagename
//
// HtmlHelp( handle(parent), "..\help\PBHTMLHelp.chm", HH_DISPLAY_TOPIC, "Welcome.htm" )
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Achtung: Wenn Dokumente in einem zus$$HEX1$$e400$$ENDHEX$$tzlichen Verzeichnis gespeichert sind, mu$$HEX2$$df002000$$ENDHEX$$dieses
// dem Dokumentennamen vorangestellt werden!
// ----------------------------------------------------------------------------
sPagename = "templates\" + swindow_classname + ".htm"

// ----------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob $$HEX1$$fc00$$ENDHEX$$berhaupt ein Internetexplorer mit der Version 4.0 oder gr$$HEX2$$f600df00$$ENDHEX$$er
// installiert ist
// ----------------------------------------------------------------------------
If RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer","Version",RegString!, sVersion) <> 1 Then
	uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~n muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", StopSign!)
	return -1
else
	iVersion = Integer(Mid(sVersion, 1, 1))

	if iVersion < 4 then
		uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~n muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", Information!)		
		return -1
	end if

End if

// bReturn = HtmlHelp( lwindow_handle, s_app.sHelpFile, HH_DISPLAY_TOPIC, sPagename)

bReturn = HtmlHelp( lwindow_handle, s_app.sHelpFile,HH_DISPLAY_INDEX, 0)

return 0

end function

public function string dw_translate (string buffer);long 	iBufferPos
long 	iBufferPos2
long 	iBufferlen
long	iFoundText, iFoundValidation, iFoundValue
long 	iPos, iDiff, iOffset
string	sReturnstring, sNewSyntax
string	sFrontstring, sBackstring
int	iMode

iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1

DO WHILE True
	// -----------------------	
	// Scanning
	// -----------------------	
	iFoundText = Pos(Buffer, "text=",iBufferPos)
	iFoundValidation = Pos(Buffer, "validationmsg=",iBufferPos)
	iFoundValue	= Pos(Buffer, "values=",iBufferPos)
	
	if iFoundText + iFoundValidation + iFoundValue = 0 then exit
	
	if iFoundText = 0 then iFoundText = 999999999
	if iFoundValidation = 0 then iFoundValidation = 999999999
	if iFoundValue = 0 then iFoundValue = 999999999

	if iFoundText > 0 and iFoundText < iFoundValidation and iFoundText < iFoundvalue then
		imode = 1
	end if
	if iFoundValidation > 0 and iFoundValidation < iFoundText and iFoundValidation < iFoundvalue then
		imode = 2
	end if
	if iFoundValue > 0 and iFoundValue < iFoundText and iFoundValue < iFoundValidation then
		imode = 3
	end if
	
	// -----------------------	
	// Text
	// -----------------------
	if imode = 1 then
		iBufferPos = iFoundText

		iBufferPos2 = Pos(Buffer, '"',iBufferPos + 6)
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		//
		// Differenz ohne text="
		//
		iDiff = (iBufferPos2 - iBufferPos) -6
			
		//
		// String ohne text="
		//
		sReturnstring = mid(Buffer,iBufferPos+6,iDiff)
			
		sFrontstring 	= mid(Buffer,1,iBufferPos+5)
		sBackstring		= mid(Buffer,iBufferpos2,iBufferlen)
			
		sReturnstring = uf.translate(sReturnstring)
			
		Buffer = sFrontstring + sReturnstring + sBackstring
		
		iBufferPos = iBufferPos2
	end if
	// --------------------------------------------------------	
	// Scanning ValidationMessages
	// Achtung:
	// Diese k$$HEX1$$f600$$ENDHEX$$nnen mit ' beginnen
	// oder auch mit ~", je nachdem, ob sie im Datawindow
	//							mit " oder ' eingegeben wurden
	// --------------------------------------------------------	
	if imode = 2 then
		iBufferPos = iFoundValidation
		//
		// Fallunterscheidung iBufferPos
		//
		if mid(Buffer,iBufferPos + 1 ,1) = "~~" Then
			// zwei " Weitersuchen
			iBufferPos+=2
		else
			// einfache Hochkommata
			iBufferPos++
		end if

		iBufferPos2 = Pos(Buffer,'"',iBufferPos + 15 )
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		//
		// Fallunterscheidung iBufferPos2
		//
		if mid(Buffer,iBufferpos2 - 1 ,1) = "~~" Then
			// zwei " Weitersuchen
			iBufferPos2 = Pos(Buffer, '"',iBufferPos + 17)
			iBufferPos2 = Pos(Buffer, '"',iBufferPos2)
			iOffset = 1
		else
			iOffset = 0
		end if
		
		//
		// Differenz ohne validationmsg="
		//
		iDiff = (iBufferPos2 - iBufferPos) - 16
		
		//
		// String ohne validationmsg="
		//
		sReturnstring = mid(Buffer,iBufferPos + 15 + iOffset,iDiff - iOffset)

		if iOffset = 1 then
			// der schwierige Fall: validationmsg="~"
			// iBufferPos ist bereits um 2 erh$$HEX1$$f600$$ENDHEX$$ht
			sFrontstring 	= mid(Buffer,1,iBufferPos+15)
			sBackstring		= mid(Buffer,iBufferpos2 - 1,iBufferlen)
		else
			// der Normalfall: validationmsg="'
			sFrontstring 	= mid(Buffer,1,iBufferPos+13)
			sBackstring		= mid(Buffer,iBufferpos2,iBufferlen)
		end if
		
		sReturnstring = uf.translate(sReturnstring)
		Buffer = sFrontstring + sReturnstring + sBackstring
			
		iBufferPos = iBufferPos2
	end if
	// -----------------------	
	// Values
	// -----------------------
	if imode = 3 then
		iBufferPos = iFoundValue
		
		iBufferPos2 = Pos(Buffer, '"',iBufferPos + 8)
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		//
		// Differenz ohne text="
		//
		iDiff = (iBufferPos2 - iBufferPos) -8
			
		//
		// String ohne text="
		//
		sReturnstring = mid(Buffer,iBufferPos+8,iDiff)
			
		sFrontstring 	= mid(Buffer,1,iBufferPos+7)
		sBackstring		= mid(Buffer,iBufferpos2,iBufferlen)
		
		// MessageBox("sReturn f$$HEX1$$fc00$$ENDHEX$$r Value",sReturnstring)
		sReturnstring = uf.f_dw_translate_values(sReturnstring)
			
		Buffer = sFrontstring + sReturnstring + sBackstring
		
		iBufferPos = iBufferPos2
		
	end if
Loop

return Buffer


end function

public function integer help_with_id (long lwindow_handle, string swindow_classname, long largroleid);	boolean	bReturn

	String 	sVersion
	Integer 	iVersion
// ----------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob $$HEX1$$fc00$$ENDHEX$$berhaupt ein Internetexplorer mit der Version 4.0 oder gr$$HEX2$$f600df00$$ENDHEX$$er
// installiert ist
// ----------------------------------------------------------------------------
	If RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer","Version",RegString!, sVersion) <> 1 Then
		uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~r muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", StopSign!)
		return -1
	else
		iVersion = Integer(Mid(sVersion, 1, 1))
		
		if iVersion < 4 then
			uf.mBox("Achtung", "Um mit der Hilfe von CBASE - anywhere arbeiten zu k$$HEX1$$f600$$ENDHEX$$nnen ~r muss der Internet Explorer 4.0 oder h$$HEX1$$f600$$ENDHEX$$her installiert sein.", Information!)		
			return -1
		end if
	End if

//	HtmlHelp(handle(parent),"..\cbase.chm>CBASE", HH_DISPLAY_TOPIC,em_1.text)

	bReturn = HtmlHelp( lwindow_handle,s_app.sHelpFile + ">CBASE",HH_HELP_CONTEXT,lArgRoleid)
	
	If bReturn = False Then
		HtmlHelp( lwindow_handle,s_app.sHelpFile + ">CBASE",HH_DISPLAY_TOC,0)	
	End if

	IF Handle(GetApplication()) = 0 THEN
		Messagebox("Role ID",lArgRoleid)
	End if	
  
	return 0

end function

public function integer uf_create_tooltip_list ();sPictureNames[1] = "..\Resource\diskett2.gif"
sTooltipText[1] = this.translate("Speichern")

sPictureNames[2] = "..\Resource\pencil1b.gif"
sTooltipText[2] = this.translate("Neuanlage")

sPictureNames[3] = "..\Resource\eraser0c.gif"
sTooltipText[3] = this.translate("L$$HEX1$$f600$$ENDHEX$$schen")

sPictureNames[4] = "..\Resource\printer1c.gif"
sTooltipText[4] = this.translate("Drucken")

sPictureNames[5] = "..\Resource\choose_column.gif"
sTooltipText[5] = this.translate("Spaltensortierung")

sPictureNames[6] = "..\Resource\use_objects.gif"
sTooltipText[6] = this.translate("Verwendungsdienst")

sPictureNames[7] = "..\Resource\book07.gif"
sTooltipText[7] = this.translate("Hilfe")

sPictureNames[8] = "..\Resource\door02.gif"
sTooltipText[8] = this.translate("Schlie$$HEX1$$df00$$ENDHEX$$en")

sPictureNames[9] = "..\Resource\fluggeraet_color.gif"
sTooltipText[9] = this.translate("Flugliste erstellen")

sPictureNames[10] = "..\Resource\document_color.gif"
sTooltipText[10] = this.translate("Start")

sPictureNames[11] = "..\Resource\thermo_on.gif"
sTooltipText[11] = this.translate("Einstellungen")

sPictureNames[12] = "..\Resource\edit.gif"
sTooltipText[12] = this.translate("Bearbeiten")

sPictureNames[13] = "..\Resource\info_color.gif"
sTooltipText[13] = this.translate("Informationen")

sPictureNames[14] = "..\Resource\run_enabled.gif"
sTooltipText[14] = this.translate("Start")

sPictureNames[15] = "..\Resource\mail_color.gif"
sTooltipText[15] = this.translate("E-Mail")

sPictureNames[16] = "..\Resource\date.gif"
sTooltipText[16] = this.translate("G$$HEX1$$fc00$$ENDHEX$$ltigkeit ein-/ausblenden")

sPictureNames[17] = "..\Resource\calculator_big.gif"
sTooltipText[17] = this.translate("Simulation")

sPictureNames[18] = "..\Resource\standard.gif"
sTooltipText[18] = this.translate("Wiederherstellen")

//sPictureNames[19] = ""
//sTooltipText[19] = this.translate("")

//sPictureNames[20] = ""
//sTooltipText[20] = this.translate("")



return 0
end function

public function string uf_tooltip (string stooltip, string spicture);Integer I

if len(trim(sTooltip)) > 0 then return sToolTip

For i = 1 to UpperBound(sPictureNames)

	if sPictureNames[i] = sPicture then return sToolTipText[i]

Next

return ""


end function

public function integer translate_child (datawindowchild datawindowobj);//
// Alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der DataWindows
//
// 1. DataWindowObj.describe("DataWindow.Objects") liefert alle Objekte des Fensters
// 2. Diese in Array speichern
// 3. Feststellen, welches Objekt ein Textobjekt ist
// 4. Den zugeordneten Text f$$HEX1$$fc00$$ENDHEX$$r dieses Objekt holen
// 5. Text $$HEX1$$fc00$$ENDHEX$$bersetzen
//
// offen: alternative $$HEX1$$dc00$$ENDHEX$$bersetzung der Validations
//
long 	iBufferPos
long 	iBufferPos2
long 	iBufferlen
long 	iPos, iDiff, iOffset
string	sObject, sReturnstring, buffer, sReturnstring1, sReturnstring2, sChild
boolean bIsValidation, bIsValue, bIsTextObject
DataWindowChild dwcChild

buffer = DataWindowObj.describe("DataWindow.Objects")

iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1

//sClassNameDw		= DataWindowObj.DataObject
sClassNameWindow	= ""


DO WHILE True
	// ----------------------------
	// $$HEX1$$dc00$$ENDHEX$$bersetzung $$HEX1$$dc00$$ENDHEX$$berschriften
	// ----------------------------
		//
		// Textobjekte haben i.d.R. keinen Namen und bekommen zur Laufzeit einen "internen"
		// Namen vergeben.
		//
		iBufferPos = Pos(Buffer, "obj",iBufferPos)
		If iBufferPos <= 0 Then 
			EXIT		
		End if
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos + 3)
		If iBufferPos2 <= 0 Then 
			iBufferPos2 = iBufferlen
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		sReturnstring = translate(sReturnstring)
		// $$HEX1$$dc00$$ENDHEX$$bersetzung zur$$HEX1$$fc00$$ENDHEX$$ck ins DW
		DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
				
		//MessageBox("Textobject: " + sObject,sReturnstring)
		
		iBufferPos = iBufferPos2
Loop	

//
// Texte, Validations, Values (01.01.3000 = offen): alle Objekte Scannen
//
buffer = DataWindowObj.describe("DataWindow.Objects")
iBufferLen 	= len(buffer)
iBufferPos 	= 1
iBufferPos2 = 1
DO WHILE True
		//
		// Alle DataWindow.Objects sind durch Tabulator getrennt
		//
		iBufferPos2 = Pos(Buffer, '~t',iBufferPos)
		If iBufferPos2 <= 0 Then 
			//
			// +1, da das letzte Objekt sonst in der L$$HEX1$$e400$$ENDHEX$$nge falsch ermittelt wird (lang statt lang3)
			//
			iBufferPos2 = iBufferlen + 1
		End if	
		
		iDiff = iBufferPos2 - iBufferPos
		//
		// String mit Inhalt des Objektes erzeugen
		//
		sObject = mid(Buffer,iBufferPos,iDiff)
		sReturnstring = DataWindowObj.describe( sObject + ".Text")
		
		if sReturnstring = "!" then
			//
			// Es ist kein Textobjekt -> es k$$HEX1$$f600$$ENDHEX$$nnte ein Column-Object sein
			//
			// Mal schauen, ob eine Validation oder Value (01.01.3000='offen') vorhanden ist
			//
			sReturnstring1 = DataWindowObj.describe( sObject + ".ValidationMsg")
			// Falls unbrauchbar liefert describe ein ?
			if sReturnstring1 <> "?" then bIsValidation = True
			sReturnstring2 = DataWindowObj.describe( sObject + ".Values")
			if sReturnstring2 <> "?" then bIsValue = True
		else
			bIsTextObject = True
		end if
			
		if bIsValidation then
			// $$HEX1$$dc00$$ENDHEX$$bersetzung der Validation-Message
			// liefert z.Zt. noch fehlerhafte Ergebnisse
			sReturnstring1 = f_dw_translate_validations(sReturnstring1)
			
			DataWindowObj.modify( sObject + ".ValidationMsg='" + sReturnstring1 + "'")
			//if MessageBox("Columnobject->ValidationMsg: " + sObject,sReturnstring1,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsValue then
			//
			// Values kommen als EIN string!
			// Bsp.: Belastung A, Gutschrift B, Storno S
			// -> Belastung<tab>A/Gutschrift<tab>B/Storno<tab>S
			// Diese Teile m$$HEX1$$fc00$$ENDHEX$$ssen separat $$HEX1$$fc00$$ENDHEX$$bersetzt und anschlie$$HEX1$$df00$$ENDHEX$$end wieder zusammengebaut werden!
			//
			sReturnstring2 = f_dw_translate_values(sReturnstring2)
			
			DataWindowObj.modify( sObject + ".Values='" + sReturnstring2 + "'")
			//if MessageBox("Columnobject->Values: " + sObject,sReturnstring2,Question!,YesNo!) = 2 then exit
		end if
		
		if bIsTextObject then
			sReturnstring = translate(sReturnstring)
			
			// #### wegen PB Absturz tempor$$HEX1$$e400$$ENDHEX$$r inaktiv ###
//			MessageBox("Gleich Absturz", "Textobject: " + sObject + "~r~n" + sReturnstring)
//			DataWindowObj.modify( sObject + ".Text='" + sReturnstring + "'")
			
			// if MessageBox("Textobject: " + sObject,sReturnstring,Question!,YesNo!) = 2 then exit
		end if
		
		// 17.10.2001: $$HEX1$$dc00$$ENDHEX$$bersetzung Checkbox
		sReturnstring = DataWindowObj.describe( sObject + ".checkbox.text")
		if sReturnstring <> "!" and sReturnstring <> "?" then
			sReturnstring = translate(sReturnstring)
			DataWindowObj.modify( sObject + ".checkbox.text='" + sReturnstring + "'")
			//MessageBox(sObject,DataWindowObj.describe( sObject + ".checkbox.text") + "," + &
			//				string(bIsValidation) + "," + string(bIsValue) + "," + string(bIsTextObject) )
		end if

		bIsValidation = False
		bIsValue = False
		bIsTextObject = False
		
		iBufferPos = iBufferPos2
		iBufferPos ++
		
		if iBufferPos2 >= iBufferlen then exit
Loop	

sClassNameDw 		= ""
sClassNameWindow 	= ""

return 0
end function

on uo_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

