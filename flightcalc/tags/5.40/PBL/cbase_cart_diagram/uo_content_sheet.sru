HA$PBExportHeader$uo_content_sheet.sru
$PBExportComments$Collection of Data and Functions to Create a Content Spec Report/Label
forward
global type uo_content_sheet from nonvisualobject
end type
end forward

global type uo_content_sheet from nonvisualobject
end type
global uo_content_sheet uo_content_sheet

type variables
datastore 	dsLoading 
datastore 	dsLoadingHeader
datastore 	dsLoadingContents 
datastore 	dsOutput[]
datastore	dsOperations

datastore 	dsPLContents
datastore 	dsPLSubContents

integer 		iiUseLetterFormat

Long 			ilResultKey
String			isError	= ""
String			isTempPath	= "c:\temp\cbase\"
String			isOperation = ""

end variables

forward prototypes
public function integer of_create_content_sheet ()
public function integer of_debug_print ()
public function integer of_reset_datastores ()
public function integer of_prepare_details (ref datastore arg_dsdetails, datetime arg_ddeparture, string arg_sunit)
public function integer of_prepare (datastore arg_ds, datetime arg_ddeparture, string arg_sunit)
public function integer of_debug_xls (string arg_sprefix)
end prototypes

public function integer of_create_content_sheet ();

return 0
end function

public function integer of_debug_print ();
Return 1

end function

public function integer of_reset_datastores ();
return 0
end function

public function integer of_prepare_details (ref datastore arg_dsdetails, datetime arg_ddeparture, string arg_sunit);
return 0

end function

public function integer of_prepare (datastore arg_ds, datetime arg_ddeparture, string arg_sunit);
return 0

end function

public function integer of_debug_xls (string arg_sprefix);

Return 1

end function

on uo_content_sheet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_content_sheet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*
* Objekt : uo_content_sheet
* Methode: constructor (Event)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 03.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		Initialisierung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 				Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		03.03.2011			Erstellung
*
*
* Return: integer
*
*/

isTempPath = f_gettemppath()

dsLoading = create datastore 	 
dsLoading.dataobject = "dw_loading_list_result"

dsLoadingHeader = create datastore 	 
dsLoadingHeader.dataobject = "dw_loading_list_result_detail"

dsLoadingContents = create datastore 	 
dsLoadingContents.dataobject = "dw_loading_list_result_detail"

dsPLContents = create datastore 	 
dsPLContents.dataobject = "dw_uo_content_sheet_pl_contents"
dsPLContents.Settransobject(sqlca)

dsPLSubContents = create datastore 	 
dsPLSubContents.dataobject = "dw_uo_content_sheet_pl_contents"
dsPLSubContents.Settransobject(sqlca)

dsOperations = create datastore 	 
dsOperations.dataobject = "dw_uo_content_sheet_pl_operations"
dsOperations.Settransobject(sqlca)


end event

event destructor;/*
* Objekt : uo_content_sheet
* Methode: destructor (Event)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 03.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		Aufr$$HEX1$$e400$$ENDHEX$$umen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 				Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		03.03.2011			Erstellung
*
*
* Return: integer
*
*/
if isvalid(dsLoading) then destroy(dsLoading)
if isvalid(dsLoadingHeader) then destroy(dsLoadingHeader)
if isvalid(dsLoadingContents) then destroy(dsLoadingContents)
 
if isvalid(dsPLContents) then destroy(dsPLContents)
if isvalid(dsPLSubContents) then destroy(dsPLSubContents)
if isvalid(dsOperations) then destroy(dsOperations)





end event

