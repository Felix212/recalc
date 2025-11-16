HA$PBExportHeader$uo_dn_barcode.sru
$PBExportComments$Create Barcode for Delivery Notes
forward
global type uo_dn_barcode from nonvisualobject
end type
end forward

global type uo_dn_barcode from nonvisualobject
end type
global uo_dn_barcode uo_dn_barcode

type variables


String	isLastError


CONSTANT Integer		TYPE_COLUMN   = 1
CONSTANT Integer		TYPE_FIXED    = 2
CONSTANT Integer		TYPE_DYNAMIC  = 3

Long		il_Archive_BArcode_Key  = 0
Boolean	ib_Save_Archive_Barcode = FALSE

uo_pps_barcodes iuoPpsBarcodes
end variables

forward prototypes
protected function integer of_create_bc_content (long al_result_key, long al_setting_key, ref string ras_content)
protected function integer of_create_barcode (integer ai_type, string as_file, string as_text, integer ai_width, integer ai_height, integer ai_dpi)
public function integer of_create_and_save (integer ai_customer_bbill, long al_result_key, long al_transaction, long al_airlinekey, datetime adt_departure, ref string ras_file_name)
public function integer of_create_barcode_for_archive (long al_result_key, ref string ras_code)
end prototypes

protected function integer of_create_bc_content (long al_result_key, long al_setting_key, ref string ras_content);
// --------------------------------------------------------------------------------
// Objekt : uo_dn_barcode
// Methode: of_create_bc_content (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 09.01.2017
//
// Argument(e):
//  long al_result_key
//	 long al_setting_key
//	 ref string ras_content
//
// Beschreibung:		Barcode Inhalte (Feste & dynamische Bestandteile)
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	09.01.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


Long			ll_Rows
Long			ll_Flight_Rows
Long			ll_Counter
Long			ll_Number
Long			ll_Type
Long			ll_Return	
DatetIme		ldt_Date
String		ls_String
String		ls_Part
String		ls_Temp
String		ls_Datatype
String		ls_Format
String		ls_Return
String		ls_Content
DataStore	lds_barcode_parts
DataStore	lds_flight_info


lds_barcode_parts = CREATE DataStore
lds_barcode_parts.DataObject = "dw_dn_barcode_parts"
lds_barcode_parts.SetTransobject( SQLCA)

lds_flight_info = CREATE DataStore
lds_flight_info.DataObject = "dw_dn_bc_flight_info"
lds_flight_info.SetTransobject( SQLCA)


ras_Content = "TEST"
//dw_dn_bc_flight_info
ll_Rows = lds_barcode_parts.Retrieve(al_Setting_key)

ll_Flight_Rows = lds_flight_info.retrieve( al_result_key)

If ll_Flight_Rows < 1 then
	// Error - Flight not valid
	
Else
	For ll_Counter = 1 To ll_Rows
		ll_Type		= lds_barcode_parts.GetItemNumber(ll_Counter , "ntype")
		ls_Datatype	= lds_barcode_parts.GetItemString(ll_Counter , "cdatatype")
		ls_Part		= lds_barcode_parts.GetItemString(ll_Counter , "cpart")
		ls_Format	= lds_barcode_parts.GetItemString(ll_Counter , "cformat")
		If ll_Type = TYPE_COLUMN Then
			ls_Datatype = lower(ls_Datatype)
			ls_Datatype = trim(ls_Datatype)
			Choose CASE ls_Datatype 
				CASE "string"
					ls_Temp = lds_flight_info.GetItemString(1 , ls_Part)
					If isNULL(ls_Temp) Then ls_Temp = ""
					
				CASE "date"
					ldt_Date = lds_flight_info.GetItemDatetime(1 , ls_Part)
					If isnull(ls_Format) Then ls_Format = s_app.sdateformat
					If trim(ls_Format) = "" Then ls_Format = s_app.sdateformat					
					ls_Temp = String(ldt_Date, ls_Format)
					If isNULL(ls_Temp) Then ls_Temp = ""
					
				CASE "number"
					ll_Number = lds_flight_info.GetItemNumber(1 , ls_Part)
					If isnull(ls_Format) OR Trim(ls_Format) = "" Then
						ls_Temp = String(ll_Number)
						If isNULL(ls_Temp) Then ls_Temp = ""
					Else
						ls_Temp = String(ll_Number, ls_Format)
						If isNULL(ls_Temp) Then ls_Temp = ""					
					End If
			End Choose
			
			ls_Return += ls_Temp
			
		End If
		If ll_Type = TYPE_FIXED Then
			
			ls_Return += ls_Part
			
		End If
		If ll_Type = TYPE_DYNAMIC Then
			If ls_Part = "cdoc_type" Then
				
				select   ctype 
				into     :ls_Temp 
				from     sys_archive_doctypes 
				where    ndelivery_note = 1;
				
				If sqlca.sqlcode = 0 then
					if isnull(ls_Temp) then ls_Temp = ""
					If len(ls_Temp) < 3 then
						// Fill with leading Zeroes
						ls_return += Fill("0", 3 -len(ls_Temp))
					End If
					ls_Return += ls_Temp
					
				End If
			End If
			
			If upper(ls_Part) = "BARCODESEQUENCE" Then
				
				// create new entry for barcode
				// seq_cen_barcode...
				// Insert set properties....
				// cen_barcode_assignment
				
				f_trace(classname() + ".of_create_bc_content Result Key " + String(al_result_key ))
				
				ll_Return = of_create_barcode_for_archive( al_result_key, ls_Content)
				ls_Return += ls_Content

			End If
			
		End If
		
		
//1	ddeparture_date	date
//2	"
//"	string
//1	cairline	string
//2	"
//"	string
//1	nflight_number	number
//1	csuffix	string
//2	"
//"	string
//1	ctlc_from	string
//1	ctlc_to	string
	//TYPE_COLUMN
	
	Next
	
End If
	
ras_Content = ls_Return


DESTROY	lds_barcode_parts
DESTROY	lds_flight_info


return 1

end function

protected function integer of_create_barcode (integer ai_type, string as_file, string as_text, integer ai_width, integer ai_height, integer ai_dpi);/* ### Event: of_create_barcode *******************************************
 *
 * Beschreibung : Funktion zur Erstellung eines Barcodes
 *
 *	Parameter : 	ai_type 	= 	37: Barcode DataMatrix
 * 									 	14: Barcode Code128
 * 						as_file	=	Filename (incl Pfad) des Barcodes
 *						as_text 	= 	Text der im Barcode codiert werden soll
 *			 			ai_width	=	Breite des Barcodes
 *			 			ai_height	=	H$$HEX1$$f600$$ENDHEX$$he des Barcodes
 *			 			ai_dpi		=	Aufl$$HEX1$$f600$$ENDHEX$$sung des Barcodes
 *
 * Aenderungshistorie
 *  Version  Wer                        			Wann        		Was und warum
 *   1.0     	H.Rothenbach /LSY IS       	19.11.2007  	Erstellung
 *	  1.1 		H.Rothenbach /LSY IS       	05.06.2008  	Austausch des Barcodes
 *   1.2		Klaus								21.09.2012		Aus PPS $$HEX1$$fc00$$ENDHEX$$bernommen
 * ### END Eventdoku ***************************************************
 */
return iuoPpsBarcodes.of_create_barcode(ai_type, as_file, as_text, ai_width, ai_height, ai_dpi)

// #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

end function

public function integer of_create_and_save (integer ai_customer_bbill, long al_result_key, long al_transaction, long al_airlinekey, datetime adt_departure, ref string ras_file_name);
// --------------------------------------------------------------------------------
// Objekt : uo_dn_barcode
// Methode: of_create_and_save (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 09.01.2017
//
// Argument(e):
// integer ai_customer_bbill
//	 long al_result_key
//	 long al_transaction
//	 long al_airlinekey
//	 datetime adt_departure
//	 ref string ras_file_name
//
// Beschreibung:		Save Barcode Bitmap
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	09.01.2017		Erstellung
// 1.1         OH       17.01.2024     Fix for Barcode Setting "OFF" 
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


Integer	li_Succ
String	ls_Content
Integer	li_Return
Long		ll_Setting_Key
Long		ll_Code_Type
Long		ll_Rows
Long		ll_TBarcode_ID
Long		ll_Pic_Rows
String	ls_File_Name
DataStore		lds_Settings

lds_Settings = CREATE DataStore

li_Return = 1

//dw_custom_boarding_bill

If ai_Customer_BBill =1 Then 
	lds_Settings.DataObject = "dw_custom_boarding_bill"
	lds_Settings.SetTransobject(SQLCA)
	ll_Rows = lds_Settings.Retrieve(al_airlinekey, adt_departure)
	
	If ll_Rows > 0 Then
		ll_Setting_Key = lds_Settings.GetItemNumber(1, "ndn_bc_setting")
		ll_Code_Type   = lds_Settings.GetItemNumber(1, "ndn_bc_type")

	End If
	// Customer BB
	
	//dw_custom_boarding_bill airline_key, departure
	
	// > 0 => get type, get setting key
	//ndn_bc_type, bb.ndn_bc_setting
	//al_AirlineKey
Else
	lds_Settings.DataObject = "dw_delivery_note_edit"
	lds_Settings.SetTransobject(SQLCA)
	ll_Rows = lds_Settings.Retrieve(al_airlinekey)
	If ll_Rows > 0 Then
		ll_Setting_Key = lds_Settings.GetItemNumber(1, "ndn_bc_setting")
		ll_Code_Type   = lds_Settings.GetItemNumber(1, "ndn_bc_type")
				
	End If
End If

If isnull(ll_Setting_Key) Then
	DESTROY lds_Settings
	return -1
End If

If ll_Setting_Key = 0 Then
	DESTROY lds_Settings
	return -1
End If

If isnull(ll_Code_Type) Then
	DESTROY lds_Settings
	return -1
End If

If ll_Code_Type > 0 Then

	select	ntype_id 
	into		:ll_TBarcode_ID 
	from		sys_dn_bc_type 
	where		ntype = :ll_Code_Type ;
	
End If

// 2024-01-17 OH Barcode Setting "OFF" = ll_TBarcode_ID 0
IF IsNULL(ll_TBarcode_ID) OR ll_TBarcode_ID < 1 THEN
	Return 0
END IF

li_Succ = of_create_bc_content( al_result_key, ll_Setting_Key, ls_content )

f_trace( classname() + ".of_create_and_save of_create_bc_content " + String(li_Succ) + " " + ls_content ) 

If trim(ls_content) = "" Then 
	DESTROY lds_Settings
	return -1
	
End If

If li_Succ = 1 Then 
	//ls_content
	//string ls_type
	//long ll_type
	//uo_barcode luo_barcode
		
	ls_File_Name = f_gettemppath() + "BC_" + String(al_result_key) + "_" + String(now(),"hhmmssfff") + ".bmp"
	
	if FileExists(ls_File_Name) then
		FileDelete(ls_File_Name)
	end if
	
	//	case "QR-Code" 		ll_TBarcode_ID = 58
	//	case "Datamatrix"		ll_TBarcode_ID = 71
	//	case "Code 128"		ll_TBarcode_ID = 20		
	//	case else      		ll_TBarcode_ID = 20
	
	//mle_trace.text += "try creating barcode ("+ls_type+"="+string(ll_type)+") BITMAP ~r~n"
	
	try
		li_Succ = of_create_barcode(ll_TBarcode_ID, ls_File_Name, ls_content , 120,120, 75) 
		f_trace( "try creating barcode BITMAP DONE")
	catch(runtimeerror rte)
		f_trace( "EXCEPTION:"+ rte.text )
		f_trace( "LastError:"+ islasterror)
		li_Return = -1
	end try
	
	// Bei Erfolg: file to blob, blob to db
	If fileexists(ls_File_Name) then
	
//		cen_out_dn_barcode
//		nresult_key , ntransaction, dtimestamp  bpicture
		
		select count(*)
		into	:ll_Pic_Rows
		from 	cen_out_dn_barcode
		where nresult_key		= :al_result_key
		and	ntransaction	= :al_Transaction;
		
		If ll_Pic_Rows < 1 Then
			INSERT into cen_out_dn_barcode (nresult_key , ntransaction, dtimestamp)
			values (:al_result_key, :al_Transaction, sysdate);
			If sqlca.SQLCode = 0 Then 
				COMMIT;
			End If
		End If
		
		long ll_rc = 0
		blob lb_blob
		setnull(lb_Blob)
					
		if (f_file_to_blob(ls_File_Name, lb_blob, true) = 0) then
			uf.mbox("Attention", "File is empty, please adjust!", stopsign!)
			ll_rc = 1
			li_Return = -1
			//return ll_rc
			
		end if
			  
		updateblob cen_out_dn_barcode
		set      bpicture          	=	:lb_blob       
		where    nresult_key 			=	:al_result_key
		AND 		ntransaction 			=	:al_Transaction;
								  
		if sqlca.sqlcode <> 0 then
//			f_db_error(sqlca, "wf_save_report failed")
			ll_rc = 2
			li_Return = -1
		Else
			COMMIT;
		end if

	End If
	
Else
	 // Error
End If

If li_Return = 1 Then
	If ib_save_archive_barcode Then
		If il_archive_barcode_key > 0 Then
			updateblob CEN_BARCODES
			set      bpicture          	=	:lb_blob       
			where NBARCODE_KEY		= :il_archive_barcode_key;
			if sqlca.sqlcode <> 0 then
				//li_Return = -1
				f_trace(classname() + ".of_create_and_save updateblob CEN_BARCODES failed " )
			Else
				COMMIT;
			end if
		
		End If
	End If
End If
ib_save_archive_barcode = FALSE
il_archive_barcode_key = 0

DESTROY lds_Settings

If fileexists(ls_File_Name) then
	ras_File_Name = ls_File_Name
End If

return li_Return


end function

public function integer of_create_barcode_for_archive (long al_result_key, ref string ras_code);
// --------------------------------------------------------------------------------
// Objekt : ncst_archive_functions
// Methode: of_create_barcode_for_archive (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 01.02.2017
//
// Argument(e):
// long al_result_keys[]
//	 ncst_archive_parameters anv_parameters
//
// Beschreibung:		Create Barcodes
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	01.02.2017		Erstellung
// 1.1 			O.Hoefer	08.05.2017		"...soll $$HEX1$$1e20$$ENDHEX$$Lieferschein$$HEX2$$1c202000$$ENDHEX$$(DE) $$HEX1$$1e20$$ENDHEX$$Catering Order (EN) hei$$HEX1$$df00$$ENDHEX$$en."
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

Integer		li_Succ
Integer		li_Return
Long			ll_Count
Long			ll_Print_Counter
String		ls_Event_Type 
String		ls_Document_Type
Long			ll_Relevant
String		ls_Description
Long			ll_Document_Type_Key
String		ls_File_ID
Long			ll_Event_Type = 1
Long			ll_Barcode_Key
Long			ll_Barcode_Row
Long			ll_Assignment_Row
Long			ll_Assignment_Key
Long			ll_Existing_Barcode_Key, ll_Rows, ll_BC_Rows
Integer		li_Width, li_Height
String		ls_BC_File
String		ls_Mod_Error
String		ls_Existing_Barcode
INTEGER	CI_JOB_OK    =  0
INTEGER	CI_JOB_ERROR = -1


uo_cbase_DataStore	lds_Barcodes
uo_cbase_DataStore	lds_Barcode_Assignment
uo_cbase_DataStore	lds_Existing_Barcode


lds_Barcodes = CREATE uo_cbase_DataStore
lds_Barcodes.DataObject = "dw_barcode_label"
lds_Barcodes.SetTransObject(SQLCA)

lds_Barcode_Assignment = CREATE uo_cbase_DataStore
lds_Barcode_Assignment.DataObject = "dw_barcode_assignment"
lds_Barcode_Assignment.SetTransObject(SQLCA)

lds_Existing_Barcode = CREATE uo_cbase_DataStore
lds_Existing_Barcode.DataObject = "dw_dn_barcode_assignment"
lds_Existing_Barcode.SetTransObject(SQLCA)


li_Return = CI_JOB_OK

f_trace(classname() +  ".of_create_barcode_for_archive START")


select ndoctype_key, ctype
INTO  :ll_Document_Type_Key,  :ls_Document_Type
from sys_archive_doctypes  
where ndelivery_note = 1;


ls_Event_Type       =  "FLIGHT" //anv_parameters.is_Event_Type
//ls_Document_Type    = anv_parameters.is_Document_Type
ll_Relevant         = 1 //anv_parameters.il_Relevant

if s_app.ilanguage = 1 Then
	ls_Description	= "Lieferschein"
Else
	ls_Description = "Catering Order"
End If

//select  ndoctype_key
//into    :ll_Document_Type_Key
//from    sys_archive_doctypes
//where   ctype = :ls_Document_Type;

f_trace( "of_create_barcode_for_archive type is          : " + ls_Event_Type)
f_trace( "of_create_barcode_for_archive document type is : " + ls_Document_Type)
f_trace( "of_create_barcode_for_archive relevant flag is : " + String(ll_Relevant))
f_trace( "of_create_barcode_for_archive description is   : " + ls_Description)

If ls_Event_Type = "FLIGHT" Then
	ll_Event_Type = 1
ElseIf ls_Event_Type = "POSTING" Then
	ll_Event_Type = 2
End If

f_trace( "of_create_barcode_for_archive Result Key " + String(al_result_key ))

//For ll_Print_Counter = 1 To ll_Copies
//	f_trace( "of_create_barcodes Print Barcode #" + String(ll_Print_Counter, "##0") + " /" + String(ll_Copies, "##0"))
//Next


// =================================================================
// - generiere UID zu jedem Label
// - erstelle Barcode Inhalte (Aufbau?) und Bitmap (File / Blob)
// - Drucke Barcode auf Drucker (Setup?)
// - Speichern "Barcode XY zu Result Key erstellt", Properties
//
// =================================================================


// =================================================================
// Existiert bereits ein Barcode-Lieferschein
// 
// =================================================================
// dw_dn_barcode_assignment
ll_Existing_Barcode_Key = 0
ll_Rows = lds_Existing_Barcode.Retrieve(al_result_key )
If ll_Rows > 0 then	
	ll_Existing_Barcode_Key = lds_Existing_Barcode.GetItemNumber(1, "nbarcode_key")
	ls_Existing_Barcode = lds_Existing_Barcode.GetItemString(1, "cbarcode_content")
End If

If ll_Existing_Barcode_Key > 0 then
	// Code wiederverwenden
	 ll_BC_Rows = lds_Barcodes.Retrieve(ls_Existing_Barcode)
	 ll_Barcode_Key = ll_Existing_Barcode_Key
Else
	ll_Barcode_Key = f_Sequence ("seq_cen_barcodes", sqlca)
	if ll_Barcode_Key = -1 then
		// Error	
		uf.mbox( "Error", "Sequence seq_cen_barcodes failed")
		DESTROY lds_Barcodes
		DESTROY lds_Barcode_Assignment
		DESTROY lds_Existing_Barcode
		return -1
	End If
	
	ll_Barcode_Row = lds_Barcodes.InsertRow(0)
	li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "nbarcode_key", ll_Barcode_Key)
	li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "NDOCUMENT_TYPE_KEY", ll_Document_Type_Key)
	li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "NRELEVANT", ll_Relevant)
	li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "ndeliverynote", 1)
	li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "ccomment", ls_Description)

End If

//ls_File_ID = "BC" + String( ll_Barcode_Key , "0000000000")
ls_File_ID = String( ll_Barcode_Key , "0000000000")

ras_Code = ls_File_ID

ls_File_ID =  "BC" + String( ll_Barcode_Key , "0000000000")

li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "CBARCODE_CONTENT", ls_File_ID )


If ll_Existing_Barcode_Key = 0 then
	
	// lds Set Item Key Seq
	li_Succ = lds_Barcodes.update( )
	If li_Succ = 1 Then
		// Save Properties for each Result Key
			ll_Assignment_Key = f_Sequence ("seq_cen_barcode_assignment", sqlca)
			if ll_Assignment_Key = -1 then
				// Error	
				uf.mbox( "Error", "Sequence seq_cen_barcode_assignment failed")
				DESTROY lds_Barcodes
				DESTROY lds_Barcode_Assignment
				DESTROY lds_Existing_Barcode
				return -1
			End If 
		
			ll_Assignment_Row = lds_Barcode_Assignment.InsertRow(0)
		
			li_Succ = lds_Barcode_Assignment.SetItem(ll_Assignment_Row, "nbarcode_key", ll_Barcode_Key)
			li_Succ = lds_Barcode_Assignment.SetItem(ll_Assignment_Row, "nbarcode_assignment_key", ll_Assignment_Key)
			li_Succ = lds_Barcode_Assignment.SetItem(ll_Assignment_Row, "nresult_key", al_result_key)
			li_Succ = lds_Barcode_Assignment.SetItem(ll_Assignment_Row, "ntype", ll_Event_Type)
			
		// Update
		li_Succ = lds_Barcode_Assignment.update( )
		If li_Succ = 1 Then
			// OK
			COMMIT;
		End If
	Else
		uf.mbox( "Error", "Save barcode failed")
	End If
	
	IF li_Succ >= 0 then
		li_Succ = lds_Barcodes.SetItem(ll_Barcode_Row, "nstatus", 1)
		il_Archive_Barcode_Key  = ll_Barcode_Key
		ib_Save_Archive_Barcode = TRUE
		li_Succ = lds_Barcodes.update( )
		If li_Succ = 1 Then
			COMMIT;
		End If
	End If

End If

//select cbasejars.cbase_2d_codes.get_qr_code_image('12343233242', 'UTF8' , 'JPG') into :ll_Blob from dual

f_trace(classname() +  ".of_create_barcode_for_archive END")

DESTROY lds_Barcodes
DESTROY lds_Barcode_Assignment
DESTROY lds_Existing_Barcode

Return li_Return

end function

on uo_dn_barcode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_dn_barcode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

