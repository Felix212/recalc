HA$PBExportHeader$uo_logo_export.sru
forward
global type uo_logo_export from nonvisualobject
end type
end forward

global type uo_logo_export from nonvisualobject
end type
global uo_logo_export uo_logo_export

type variables
public:


datastore	ds_Logos,ds_sounds

blob			bLogoColor, bLogoBW
blob			bSoundfile
end variables

forward prototypes
public function integer uf_export_logos (string spath)
public function integer uf_export_sounds (string spath)
end prototypes

public function integer uf_export_logos (string spath);//
// uf_export_logos
//
// schreibt die Blobs aller Logos in das angegebene Verzeichnis
//
long	i, lkey
string	sFileColor, sFileBw, sPathname

ds_Logos	= create Datastore

ds_Logos.DataObject = 'dw_logo_selection'
ds_Logos.SetTransObject(SQLCA)
ds_Logos.Retrieve()


For i = 1 to ds_Logos.RowCount()
	lkey 			= ds_Logos.GetItemNumber(i,"nlogo_key")
	sFileColor	= ds_Logos.GetItemString(i,"ccolor_logo")
	sFileBw		= ds_Logos.GetItemString(i,"cblack_logo")

	setnull(bLogoColor)
	setnull(bLogoBW)
	
	SELECTBLOB bpicture
			INTO :bLogoColor 
			FROM sys_logos_pictures
		  where nlogo_key 	= :lkey
		    and ncolored		= 1;
			 
	if sqlca.sqlcode <> 0 then
		continue
	end if

	SELECTBLOB bpicture
			INTO :bLogoBW 
			FROM sys_logos_pictures
		  where nlogo_key 	= :lkey
		    and ncolored		= 0; 

	if sqlca.sqlcode <> 0 then
		continue
	end if
	
	sPathname	= spath + sFileColor
	if not fileexists(sPathname) then
		// bei CITRIX: Problem bei existierenden Files
		f_blob_to_file(sPathname,bLogoColor)
	end if

	sPathname	= spath + sFileBw
	if not fileexists(sPathname) then
		// bei CITRIX: Problem bei existierenden Files
		f_blob_to_file(sPathname,bLogoBW)
	End if

Next



destroy ds_Logos
return 0

end function

public function integer uf_export_sounds (string spath);	long		i, lkey
	string	sSoundFile,sPathname
// ---------------------------------------------------------------
// schreibt die Blobs aller Sounds in das angegebene Verzeichnis
// ---------------------------------------------------------------
	ds_Sounds	= create Datastore
	ds_Sounds.DataObject = 'dw_sound_export'
	ds_Sounds.SetTransObject(SQLCA)
	ds_Sounds.Retrieve(s_app.smandant,s_app.swerk)
	
	
	For i = 1 to ds_Sounds.RowCount()
		lKey 			= ds_Sounds.GetItemNumber(i,"loc_client_setting_nclient_key")
		sSoundFile	= ds_Sounds.GetItemString(i,"loc_client_setting_csoundname")
		If Isnull(sSoundFile) Then
			continue
		End if	
		setnull(bSoundfile)
				
		SELECTBLOB bsoundfile
				INTO :bSoundfile 
				FROM loc_client_setting
			  where nclient_key = :lKey;

		sPathname	= spath + sSoundFile
		If sqlca.sqlcode <> 0 then
			continue
		End if
		If not Isnull(bSoundfile) Then
			sPathname	= spath + sSoundFile
			f_blob_to_file(sPathname,bSoundfile)
		End if	
	
	Next
	
	
	
	destroy ds_Sounds
	return 0

end function

on uo_logo_export.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_logo_export.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

