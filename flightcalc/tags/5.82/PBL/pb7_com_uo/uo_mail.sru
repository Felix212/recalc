HA$PBExportHeader$uo_mail.sru
forward
global type uo_mail from nonvisualobject
end type
end forward

global type uo_mail from nonvisualobject
end type
global uo_mail uo_mail

forward prototypes
public function boolean uf_zipfile (string sfilenames[], string sattachmentfile)
public function boolean uf_mail_send (string snotetext, string ssubject, string srecipient[], string sattachmentfile, integer idisplaymode)
public function boolean uf_create_mail (string srecipient[], string sflight, string sfilenames[], string sattachmentfile, integer idisplaymode, string ssubject, string snotetext)
public function boolean uf_zipfile (string sfilenames[], string sattachmentfile, boolean ab_preserve_paths)
end prototypes

public function boolean uf_zipfile (string sfilenames[], string sattachmentfile);	long 			lSuccess
	boolean		bSuccess
	oleobject	ole_zip
	integer 		i
	string		sFiles
	ole_zip = Create OleObject	

// ---------------------------------
// Connect to Object
// ---------------------------------
	if ole_zip.ConnectToNewObject ("XceedSoftware.XceedZip.4") <> 0 Then
		uf.mbox("Fehler","Keine Verbindung zur Zip ActiveX Library.",Stopsign!)
		return False
	end if

// ---------------------------------
// Object License
// ---------------------------------
	bSuccess	= ole_zip.License("1823BC7BDF1B877EEAEB773176EA13EC")
	If not bSuccess Then
		uf.mbox("Fehler","Zip ActiveX Library ist nicht lizenziert.")
		return False
	End if	
// ---------------------------------
// Files to zip
// ---------------------------------
	sFiles = ""
	For i = 1 to Upperbound(sfilenames)
		sFiles = sFiles + sFilenames[i] + Char(13) + Char(10)
	Next
	ole_zip.FilesToProcess(sFiles)
// ---------------------------------
// Archiv Name
// ---------------------------------

	ole_zip.ZipFilename(sattachmentfile)
	lSuccess = ole_zip.Zip()


	If lSuccess <> 0 AND lSuccess <> 526 Then
		uf.mbox("Fehler","Zip-Archiv konnte nicht erstellt werden.~nFehlercode:" + string(lSuccess))
		return False	
	End if
	
	return true
end function

public function boolean uf_mail_send (string snotetext, string ssubject, string srecipient[], string sattachmentfile, integer idisplaymode);// -----------------------------------
// Mail versenden
// ----------------------------------
	string					sMailProfile
	boolean 					bReturnCode = False
	integer 					i
	mailSession				mSession
	mailMessage				mConfirmMsg
	mailReturnCode			mConfirmRet
	mailFileDescription  mAttachment
	
	mSession = create mailSession		

// -----------------------------------
// DefaultProfile aus Registry
// ----------------------------------
	If RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles","DefaultProfile",RegString!,sMailProfile) <> 1 Then
		uf.mbox("Registry","Es kann kein g$$HEX1$$fc00$$ENDHEX$$ltige Mail-Profil aus der Registry gelesen werden.",Stopsign!)
	End if	
// -----------------------------------
// Mail Logon
// ----------------------------------
	mConfirmRet = mSession.mailLogon (sMailProfile,"",mailNewSession!)

	If mConfirmRet = mailReturnSuccess! Then
		// OK
	ElseIf mConfirmRet = mailReturnLoginFailure! Then
		uf.mbox("Mail Login","Fehlerhaftes Mail-Login.",Stopsign!)
		bReturnCode = True
	ElseIf mConfirmRet = mailReturnInsufficientMemory! Then
		uf.mbox("Mail Login","Zu wenig Speicher.",Stopsign!)
		bReturnCode = True
	ElseIf mConfirmRet = mailReturnTooManySessions! Then
		uf.mbox("Mail Login","Zu viele Mail-Sessions.",Stopsign!)
		bReturnCode = True
	ElseIf mConfirmRet = mailReturnUserAbort! Then
		// OK
		bReturnCode = True
	Else
		uf.mbox("Mail Login","Unbekannter Mail-Login-Error.",Stopsign!)
		bReturnCode = True
	End if	
// -----------------------------------
// Ups, Mail Logon mit Fehler
// ----------------------------------
	If	bReturnCode Then
		destroy mSession	
		return False
	End if	
// -----------------------------------
// Mail Recipient aus Addressbook
// ----------------------------------
	If iDisplayMode  = 1 Then
		mSession.mailAddress(mConfirmMsg)
		mConfirmMsg.Subject 	= sSubject
		mConfirmMsg.NoteText = sNoteText
		If sAttachmentFile <> "" Then	
			mAttachment.FileType = mailAttach!
			mAttachment.FileName = sAttachmentFile
			mAttachment.PathName = sAttachmentFile // sAttachmentPath BUG
			mAttachment.Position = len(sNotetext) - 1		
			mConfirmMsg.AttachmentFile[1]	= mAttachment		
		End if
// -----------------------------------
// Mail Recipient aus Array
// ----------------------------------
	Elseif iDisplayMode  = 2 Then
		For i = 1 to Upperbound(sRecipient)
			mConfirmMsg.Recipient[i].name  = sRecipient[i]
			mConfirmMsg.Subject 				 = sSubject
			mConfirmMsg.NoteText 			 = sNoteText
		Next
		If sAttachmentFile <> "" Then	
			mAttachment.FileType = mailAttach!
			mAttachment.FileName = sAttachmentFile
			mAttachment.PathName = sAttachmentFile // Achtung BUG PathName
			mAttachment.Position = len(sNotetext) - 1		
			mConfirmMsg.AttachmentFile[1]	= mAttachment
		End if
// -----------------------------------
// Nachrichtendialog
// ----------------------------------		
	Elseif iDisplayMode  = 3 Then		
//		mSession.mailAddress(mConfirmMsg)
		mConfirmMsg.Subject 	= sSubject
		mConfirmMsg.NoteText = sNoteText
		If sAttachmentFile <> "" Then	
			mAttachment.FileType = mailAttach!
			mAttachment.FileName = sAttachmentFile
			mAttachment.PathName = sAttachmentFile // sAttachmentPath BUG
			mAttachment.Position = len(sNotetext) - 1		
			mConfirmMsg.AttachmentFile[1]	= mAttachment		
		End if
	End if	
// -----------------------------------
// Mail senden
// ----------------------------------
	mConfirmRet = mSession.mailSend (mConfirmMsg)

	If mConfirmRet = mailReturnSuccess! then
		bReturnCode = True
		// OK
	Elseif mConfirmRet = mailReturnFailure! then
		uf.mbox("Mail Send","Return Fehler beim senden.",Stopsign!)
	Elseif mConfirmRet = mailReturnInsufficientMemory! then		
		uf.mbox("Mail Send","Zu wenig Speicher.",Stopsign!)
	Elseif mConfirmRet = mailReturnUserAbort! then		
		uf.mbox("Mail Send","Abbruch durch Benutzer.",Stopsign!)
	Elseif mConfirmRet = mailReturnDiskFull! then		
		uf.mbox("Mail Send","Keine Festplattenkapazit$$HEX1$$e400$$ENDHEX$$t vorhanden.",Stopsign!)
	Elseif mConfirmRet = mailReturnTooManySessions! then
		uf.mbox("Mail Send","Zu viele Mail-Sessions.",Stopsign!)		
	Elseif mConfirmRet = mailReturnTooManyFiles! then	
		uf.mbox("Mail Send","Zu viele Dateien.",Stopsign!)		
	Elseif mConfirmRet = mailReturnTooManyRecipients! then
		uf.mbox("Mail Send","Zu viele Mail-Empf$$HEX1$$e400$$ENDHEX$$nger.",Stopsign!)		
	Elseif mConfirmRet = mailReturnUnknownRecipient! then	
		uf.mbox("Mail Send","Unbekannter Mail-Empf$$HEX1$$e400$$ENDHEX$$nger.",Stopsign!)		
	Elseif mConfirmRet = mailReturnAttachmentNotFound! then	
		uf.mbox("Mail Send","Attachment nicht gefunden.",Stopsign!)		
	Else
		uf.mbox("Mail Send","Unbekannter Mail-Send-Error.",Stopsign!)
	End if	

// -----------------------------------
// Mail-Logoff und Object vernichten.
// ----------------------------------
	mConfirmRet = mSession.mailLogoff()
	
	If mConfirmRet = mailReturnSuccess! then
		// OK
	Elseif mConfirmRet = mailReturnFailure! then
		uf.mbox("Mail Logoff","Return Fehler beim senden.",Stopsign!)
		bReturnCode = False
	Elseif mConfirmRet = mailReturnInsufficientMemory! then		
		uf.mbox("Mail Logoff","Zu wenig Speicher.",Stopsign!)
		bReturnCode = False
	Else
		uf.mbox("MailLogoff","Unbekannter Mail-Send-Error.",Stopsign!)
		bReturnCode = False
	End if	

	Destroy mSession	
	Return  bReturnCode

end function

public function boolean uf_create_mail (string srecipient[], string sflight, string sfilenames[], string sattachmentfile, integer idisplaymode, string ssubject, string snotetext);
// -----------------------------------------------------------
// bei iDisplayMode 1 wird das Addressbook ge$$HEX1$$f600$$ENDHEX$$ffnet
// bei iDisplayMode 2 wird der srecipient verwendet
// bei iDisplayMode 3 wird der Nachrichtendialog ge$$HEX1$$f600$$ENDHEX$$ffnet
// -----------------------------------------------------------

// -----------------------------------------------------------
// Zip-File erstellen
// -----------------------------------------------------------
	FileDelete(sAttachmentfile)
	If uf_zipfile(sfilenames,sattachmentfile) Then
		//sSubject			 	= "Catering Instructions for " + sflight
		//sNoteText 			= "E-mail from CBASE anywhere " + s_app.sVersion
		uf_mail_send(sNotetext,sSubject,sRecipient,sAttachmentFile,iDisplayMode)
	End if
	
	return true
end function

public function boolean uf_zipfile (string sfilenames[], string sattachmentfile, boolean ab_preserve_paths);	long 			lSuccess
	boolean		bSuccess
	oleobject	ole_zip
	integer 		i
	string		sFiles
	ole_zip = Create OleObject	

// ---------------------------------
// Connect to Object
// ---------------------------------
	if ole_zip.ConnectToNewObject ("XceedSoftware.XceedZip.4") <> 0 Then
		uf.mbox("Fehler","Keine Verbindung zur Zip ActiveX Library.",Stopsign!)
		return False
	end if

// ---------------------------------
// Object License
// ---------------------------------
	bSuccess	= ole_zip.License("1823BC7BDF1B877EEAEB773176EA13EC")
	If not bSuccess Then
		uf.mbox("Fehler","Zip ActiveX Library ist nicht lizenziert.")
		return False
	End if	
// ---------------------------------
// Files to zip
// ---------------------------------
	sFiles = ""
	For i = 1 to Upperbound(sfilenames)
		sFiles = sFiles + sFilenames[i] + Char(13) + Char(10)
	Next
	ole_zip.FilesToProcess(sFiles)
// ---------------------------------
// Archiv Name
// ---------------------------------

	ole_zip.ZipFilename(sattachmentfile)
	
	If not ab_preserve_paths Then
		ole_zip.PreservePaths(False) 
	End If
	
	lSuccess = ole_zip.Zip()


	If lSuccess <> 0 AND lSuccess <> 526 Then
		uf.mbox("Fehler","Zip-Archiv konnte nicht erstellt werden.~nFehlercode:" + string(lSuccess))
		return False	
	End if
	
	return true
end function

on uo_mail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

