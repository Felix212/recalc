HA$PBExportHeader$uo_getfile_params.sru
forward
global type uo_getfile_params from nonvisualobject
end type
end forward

global type uo_getfile_params from nonvisualobject autoinstantiate
end type

type variables



public:

// Word-Text
String 	is_FileDOC_DefaultExt = "doc"
String 	is_FileDOC_ImportFilter = "Word Document (*.doc;*.docx),*.doc;*.docx"	
String 	is_FileDOC_ExportFilter = "Word Document (*.doc),*.doc"	

// Excel-Kalkulation
String 	is_FileXLS_DefaultExt = "xls"
String 	is_FileXLS_ImportFilter = "Excel Document (*.xls;*.xlsx),*.xls;*.xlsx"	
String 	is_FileXLS_ExportFilter = "Excel Document (*.xls),*.xls"	

// Powerpoint-Pr$$HEX1$$e400$$ENDHEX$$sentation
String 	is_FilePPT_DefaultExt = "ppt"
String 	is_FilePPT_ImportFilter = "Powerpoint Document (*.ppt;*.pptx),*.ppt;*.pptx"	
String 	is_FilePPT_ExportFilter = "Powerpoint Document (*.ppt),*.ppt"	

// PDF-Dokument
String 	is_FilePDF_DefaultExt = "pdf"
String 	is_FilePDF_ImportFilter = "Acrobat Document (*.pdf),*.pdf"	
String 	is_FilePDF_ExportFilter = "Acrobat Document (*.pdf),*.pdf"	

// Richtext-Dokument
String 	is_FileRTF_DefaultExt = "rtf"
String 	is_FileRTF_ImportFilter = "Richtext Document (*.rtf),*.rtf"
String 	is_FileRTF_ExportFilter = "Richtext Document (*.rtf),*.rtf"

// Plaintext-Dokument
String 	is_FileTXT_DefaultExt = "txt"
String 	is_FileTXT_ImportFilter = "Text Document (*.txt),*.txt"
String 	is_FileTXT_ExportFilter = "Text Document (*.txt),*.txt"


end variables

on uo_getfile_params.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_getfile_params.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert... hier die parameter lesen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		05.07.2012		Erstellung
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/


// hilfsvariable
String ls_Section = "GetFileParameter"


// Word-Text
this.is_FileDOC_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "DOC_Default", this.is_FileDOC_DefaultExt)
this.is_FileDOC_ImportFilter =  f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "DOC_Import", this.is_FileDOC_ImportFilter)
this.is_FileDOC_ExportFilter =  f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "DOC_Export", this.is_FileDOC_ExportFilter)

// Excel-Kalkulation
this.is_FileXLS_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "XLS_Default", this.is_FileXLS_DefaultExt)
this.is_FileXLS_ImportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "XLS_Import", this.is_FileXLS_ImportFilter)
this.is_FileXLS_ExportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "XLS_Export", this.is_FileXLS_ExportFilter)

// Powerpoint-Pr$$HEX1$$e400$$ENDHEX$$sentation
this.is_FilePPT_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PPT_Default", this.is_FilePPT_DefaultExt)
this.is_FilePPT_ImportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PPT_Import", this.is_FilePPT_ImportFilter)
this.is_FilePPT_ExportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PPT_Export", this.is_FilePPT_ExportFilter)

// PDF-Dokument
this.is_FilePDF_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PDF_Default", this.is_FilePDF_DefaultExt)
this.is_FilePDF_ImportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PDF_Import", this.is_FilePDF_ImportFilter)
this.is_FilePDF_ExportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "PDF_Export", this.is_FilePDF_ExportFilter)

// Richtext-Dokument
this.is_FileRTF_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "RTF_Default", this.is_FileRTF_DefaultExt)
this.is_FileRTF_ImportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "RTF_Import", this.is_FileRTF_ImportFilter)
this.is_FileRTF_ExportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "RTF_Export", this.is_FileRTF_ExportFilter)

// Plaintext-Dokument
this.is_FileTXT_DefaultExt = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "TXT_Default", this.is_FileTXT_DefaultExt)
this.is_FileTXT_ImportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "TXT_Import", this.is_FileTXT_ImportFilter)
this.is_FileTXT_ExportFilter = f_mandant_profilestring(sqlca, s_app.sMandant, ls_Section, "TXT_Export", this.is_FileTXT_ExportFilter)

return 0

end event

