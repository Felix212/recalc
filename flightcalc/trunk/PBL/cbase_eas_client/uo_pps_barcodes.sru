HA$PBExportHeader$uo_pps_barcodes.sru
forward
global type uo_pps_barcodes from nonvisualobject
end type
end forward

global type uo_pps_barcodes from nonvisualobject autoinstantiate
end type

type variables
boolean ib_show_error = true
end variables

forward prototypes
public function long of_create_barcode (long ai_type, string as_file, string as_text, long ai_width, long ai_height, long ai_dpi)
end prototypes

public function long of_create_barcode (long ai_type, string as_file, string as_text, long ai_width, long ai_height, long ai_dpi);
/* ### Event: of_create_barcode *******************************************
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
 * ### END Eventdoku ***************************************************
 */

long result
OLEObject myoleobject

string sbarcode

//Aus der INI auslesen, welcher Barcode benutzt werden soll
sbarcode = ProfileString(s_app.sProfile,"Barcode",  "Barcodetyp"  , "ActiveBarcode")	
SetProfileString(s_app.sProfile,"Barcode",  "Barcodetyp"  ,sbarcode)	

myoleobject = CREATE OLEObject

//HR 18.08.2008: Es wird nur noch mit dem neuen Barcode gedruckt.
/* Neuer Barcode */
//if sbarcode = "TBarcode8" then
	SetProfileString(s_app.sProfile,"Barcode",  "#Barcodetyp"  , "ActiveBarcode")	
	//---------------------------------------------------------------------------------
	// Code f$$HEX1$$fc00$$ENDHEX$$r TBarcode8
	//---------------------------------------------------------------------------------
	result = myoleobject.ConnectToNewObject("TBarCode8.TBarCode8")
	
	if result <> 0 then

		choose case result
			case -1
				sbarcode = "Invalid Call: the argument is the Object property of a control"
			case -2
				sbarcode = "Class TBarCode8.TBarCode8 not found"
			case -3
				sbarcode = "Object could not be created"
			case -4
				sbarcode = "Could not connect to object"
			case -9
				sbarcode = "Other error"
			case -15
				sbarcode = "COM+ is not loaded on this computer"
			case -16
				sbarcode = " Invalid Call: this function not applicable"
			case else
				sbarcode = "Error Code " + string(result)
		end choose
		
		if ib_show_error then
			uf.mbox( "Achtung", "Error create Barcode: " + sbarcode)
			ib_show_error = false
		end if
		
	else
	
	myoleobject.LicenseMe("Mem: Lufthansa Systems Business Solutions GmbH", 3, 1, "71636CB6AA94C8F74F7A837E4F68D978", 33)
	
	if  ai_type = 37 then
		 myoleobject.BarCode =71
	elseif  ai_type = 58 then
		 myoleobject.BarCode =58 	 
	else
		myoleobject.BarCode =20 
		myoleobject.PrintDataText = FALSE //true
		myoleobject.BackStyle = 1 
		ai_width = myoleobject.CountModules() * 3
		ai_height = 60
	end if
	
	if isnull(as_text) then
		uf.mbox("Achtung","Der $$HEX1$$fc00$$ENDHEX$$bergebene Barcodetext ist NULL. Es kann kein Barcode erstellt werden")
		myoleobject.text=" "
	else
		if s_app.iTrace  = 1  then f_trace("File: "+as_file+" Code: "+as_text)
		
		myoleobject.text=as_text
		myoleobject.SaveImage(as_file, 0, ai_width,ai_height, 96, 96) 
	end if
	
	myoleobject.DisconnectObject() 

end if

destroy myoleobject

return 1

// #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

end function

on uo_pps_barcodes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pps_barcodes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

