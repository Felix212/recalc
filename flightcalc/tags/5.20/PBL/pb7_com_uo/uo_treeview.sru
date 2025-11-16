HA$PBExportHeader$uo_treeview.sru
forward
global type uo_treeview from treeview
end type
end forward

shared variables

end variables

global type uo_treeview from treeview
integer width = 480
integer height = 400
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
borderstyle borderstyle = stylelowered!
string picturename[] = {"..\Resource\folder_close.gif","..\Resource\folder_open.gif","..\Resource\folder_close_selected.gif","..\Resource\folder_open_selected.gif","..\Resource\folder_date_close.gif","..\Resource\folder_date_open.gif"}
long picturemaskcolor = 16777215
string statepicturename[] = {"..\Resource\folder_stop.gif"}
long statepicturemaskcolor = 536870912
event type boolean ue_selectionchange_check ( )
event ue_find ( string ssearchstring )
end type
global uo_treeview uo_treeview

type variables
	uo_treeview_data	tv_new_data
	uo_treeview_data	tv_old_data
	uo_treeview_data	tv_search_data
	long					tv_new_handle
	long					tv_old_handle
	long					tv_items
	long					lSelectHandle
	private:
// ----------------------------
// Internes Handling
// ----------------------------
	long		lLast_Handle[]
	boolean 	bAction
	long		lTotalItemsIndex[]
	long		lTotalItems
	
	
	
end variables

forward prototypes
public function boolean uf_tv_init ()
public subroutine uf_getdata ()
public function long uf_insert_item (integer ilevel, uo_treeview_data uo_parm, long lhandle)
public function integer uf_delete_all ()
public function boolean uf_fill_level (integer ilevel, uo_treeview_data uo_parm)
end prototypes

event type boolean ue_selectionchange_check();// -----------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Selectionchange durch -
// gef$$HEX1$$fc00$$ENDHEX$$hrt werden kann
// -----------------------------------------


	return True
end event

event ue_find(string ssearchstring);// --------------------------------------
// kompletten Baum absuchen
// --------------------------------------
	long 				lSearchHandle,i,lPos
	TreeViewItem 	tv_search
	PowerObject 	pObject

	lPos = Pos(sSearchString,"*")
	If lPos > 1 then 
		sSearchString = mid(sSearchString,1,lPos -1) + "\" + mid(sSearchString,lPos)
	End if

	For i = 1 to lTotalItems	
		lSearchHandle = lTotalItemsIndex[i]
	
		If This.GetItem(lSearchHandle,tv_search) <> -1 Then
			pObject 			= tv_search.data
			tv_search_data = pObject
			If match(tv_search_data.search,"^" + sSearchString) Then
				this.SelectItem(lSearchHandle)
				exit
			End if	
		End if		
	Next

end event

public function boolean uf_tv_init ();// -------------------------------
// alles l$$HEX1$$f600$$ENDHEX$$schen
// -------------------------------
	destroy tv_new_data
	destroy tv_old_data
	destroy tv_search_data
	uf_delete_all()
// -------------------------------
// UserObject  erstellen
// -------------------------------
	tv_new_data			= Create uo_treeview_data
	tv_old_data			= Create uo_treeview_data
	tv_search_data		= Create uo_treeview_data
	tv_items				= 0
	lTotalItems			= 0
	return true
end function

public subroutine uf_getdata ();// -------------------------------------
// Daten nach tv_new_data + tv_old_data
// -------------------------------------
	TreeViewItem tv_current
	PowerObject 	pObject
	
	This.GetItem(tv_new_handle,tv_current)
	pObject 		= tv_current.data
	tv_new_data = pObject
	

	This.GetItem(tv_old_handle,tv_current)
	pObject 		= tv_current.data
	tv_old_data = pObject
	
end subroutine

public function long uf_insert_item (integer ilevel, uo_treeview_data uo_parm, long lhandle);		long lLastHandle	
		Long lParentHandle,lAfterHandle

		bAction = True	   
	// ----------------------------------
	// Treeview Items f$$HEX1$$fc00$$ENDHEX$$llen
	// ----------------------------------
		treeviewitem tv_new
	// -------------------------------
	// Standard Pictures
	// -------------------------------
		tv_new.PictureIndex 				= uo_parm.PictureIndex	
		tv_new.SelectedPictureIndex 	= uo_parm.SelectedPictureIndex	
	// -------------------------------
	// Treeview Item Label
	// -------------------------------		
		tv_new.Label	= uo_parm.Label
	// -------------------------------
	// Insert Treeview Item
	// -------------------------------	
		If iLevel = 1 Then
			lParentHandle 	= 0
			lAfterHandle 	= lHandle 
		// ------------------------------------------------------------
		// Ist lHandle gleich Null gab es noch keinen Treeview Eintrag
		// ------------------------------------------------------------
			If lAfterHandle = 0 Then
				lLast_Handle[iLevel] = this.InsertItemLast(0,tv_new)
			Else
				lLast_Handle[iLevel] = this.InsertItem(lParentHandle,lAfterHandle,tv_new)
			End if
		Else
			lParentHandle 	= lHandle //this.FindItem(parenttreeitem!,lHandle)
			lAfterHandle 	= lHandle
			lLast_Handle[iLevel] = this.InsertItem(lParentHandle,lAfterHandle,tv_new)
		End if	

		If lLast_Handle[iLevel] <> -1 Then
			lLastHandle = lLast_Handle[iLevel]
			lTotalItems ++
			tv_items		++
			lTotalItemsIndex[lTotalItems] = lLastHandle
			lSelectHandle = lLastHandle
			This.GetItem(lLastHandle,tv_new)
			uo_parm.handle		= lLastHandle
			uo_parm.level		= iLevel
			tv_new.Data			= uo_parm
			This.SetItem(lLastHandle,tv_new)
			bAction = False
		// ------------------------------------
		// Den ersten Insert merken wir uns
		// ------------------------------------
			If tv_items = 1 Then
				tv_new_handle = lLastHandle
				tv_old_handle = lLastHandle
				uf_getdata()
			End if	
			return lLastHandle
		Else
			bAction = False
			Return -1
		End if
			
end function

public function integer uf_delete_all ();// -------------------------------------
// Alle Eintr$$HEX1$$e400$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen
// -------------------------------------
	this.setredraw(False)
	bAction = True
	DO UNTIL this.FindItem(RootTreeItem!,0) = -1
		this.DeleteItem(0)
	LOOP
	this.setredraw(True)
	bAction = False
	Return 0
	

end function

public function boolean uf_fill_level (integer ilevel, uo_treeview_data uo_parm);		long		lLastHandle

		bAction = True	   
	// ----------------------------------
	// Treeview Items f$$HEX1$$fc00$$ENDHEX$$llen
	// ----------------------------------
		treeviewitem tv_new
	// -------------------------------
	// Standard Pictures
	// -------------------------------
		tv_new.PictureIndex 				= uo_parm.PictureIndex	
		tv_new.SelectedPictureIndex 	= uo_parm.SelectedPictureIndex	
	// -------------------------------
	// Treeview Item Label
	// -------------------------------		
		tv_new.Label	= uo_parm.Label
	// -------------------------------
	// Insert Treeview Item
	// -------------------------------	
		If iLevel = 1 Then
			lLastHandle = 0
		Else
			lLastHandle = lLast_Handle[iLevel - 1]
		End if	
		
		lLast_Handle[iLevel] 	= this.InsertItemLast(lLastHandle,tv_new)
		
		If lLast_Handle[iLevel] <> -1 Then
			lLastHandle = lLast_Handle[iLevel]
			lTotalItems ++
			tv_items		++
			lTotalItemsIndex[lTotalItems] = lLastHandle
			lSelectHandle = lLastHandle
			This.GetItem(lLastHandle,tv_new)
			uo_parm.handle		= lLastHandle
			uo_parm.level		= iLevel
			tv_new.Data			= uo_parm
			This.SetItem(lLastHandle,tv_new)
		// ------------------------------------
		// Den ersten Eintrag merken wir uns
		// ------------------------------------
			If tv_items = 1 Then
				tv_new_handle = lLastHandle
				tv_old_handle = lLastHandle
				uf_getdata()
			End if	
		Else
			bAction = False
			Return False
		End if
			
		bAction = False
		return True
end function

on uo_treeview.create
end on

on uo_treeview.destroy
end on

event itemexpanded;	TreeViewItem tv_current
// ----------------------------------------
// entsprechend Expanded Pictures
// ----------------------------------------
	If bAction Then Return 0
	This.GetItem(handle, tv_current)
	tv_current.PictureIndex 			= tv_new_data.ExpandedPictureIndex
	tv_current.SelectedPictureIndex 	= tv_new_data.ExpandedSelectedPictureIndex

	This.SetItem(handle,tv_current)		
	Return 0
end event

event itemcollapsed;	TreeViewItem tv_current
// ----------------------------------------
// entsprechend Expanded Pictures
// ----------------------------------------
	If bAction Then Return 0
	This.GetItem(handle, tv_current)
	tv_current.PictureIndex 			= tv_new_data.CollapsedPictureIndex
	tv_current.SelectedPictureIndex 	= tv_new_data.CollapsedSelectedPictureIndex
	This.SetItem(handle,tv_current)		
	Return 0
end event

event selectionchanging;	TreeViewItem tv_current
// --------------------------------------------------------	
// beim l$$HEX1$$f600$$ENDHEX$$schen k$$HEX1$$f600$$ENDHEX$$nnen wir uns das alles sparen.
// --------------------------------------------------------	
	If bAction Then Return 0
	
	This.GetItem(newhandle,tv_current)

// -----------------------------------------------------	
// Daten nach tv_new_data 
// -----------------------------------------------------	
	tv_new_handle = newhandle
	tv_old_handle = oldhandle
	uf_getdata()
// -----------------------------------------------------	
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob Selectionchanged durchgef$$HEX1$$fc00$$ENDHEX$$hrt werden kann.
// -----------------------------------------------------		
	If not this.Trigger Event ue_selectionchange_check() Then
	// ------------------------------------------------------
	// Positions Informationen r$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngig machen old nach ...
	// ------------------------------------------------------	
		tv_new_handle = oldhandle
		tv_old_handle = oldhandle
		uf_getdata()
		return 1
	End if	
end event

event selectionchanged;	Treeviewitem tv_old,tv_new
	If bAction Then Return 0
// ------------------------------------------------------
// Statepicture entfernen
// ------------------------------------------------------
	If oldhandle > 0 Then
		This.GetItem(oldhandle,tv_old)
		tv_old.StatePictureIndex = 0
		This.SetItem(oldhandle,tv_old)	
	End if	
// ------------------------------------------------------
// StatePicture falls bChanges False ist
// ------------------------------------------------------
	If tv_new_data.bchanges = False Then
		This.GetItem(newhandle,tv_new)
		tv_new.StatePictureIndex = 1
		This.SetItem(newhandle,tv_new)
	End if
end event

