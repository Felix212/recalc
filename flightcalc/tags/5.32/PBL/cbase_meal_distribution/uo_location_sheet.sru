HA$PBExportHeader$uo_location_sheet.sru
$PBExportComments$Das Location Sheet~r~n~r~n- ein Report, kann $$HEX1$$fc00$$ENDHEX$$ber das Setup im Dokumenten-Browser ~r~n  zugeschaltet werden
forward
global type uo_location_sheet from datastore
end type
end forward

global type uo_location_sheet from datastore
string dataobject = "dw_uo_location_sheet"
end type
global uo_location_sheet uo_location_sheet

forward prototypes
public function integer of_format (string scolumnname)
end prototypes

public function integer of_format (string scolumnname);Long 		lOffset, &
			lStart, &
			lX, &
			lY, &
			lHeight, &
			lWidth, &
			lFontBold, &
			lFontSize, &
			lXOffset, &
			lAlignment
			
Integer 	I

String	sFontFace, &
			sCurrentColumn, &
			sRet, &
			sVisible

lOffSet = Long(this.Describe("t_2.x")) - Long(this.Describe("t_1.x"))
lStart  = Long(this.Describe("t_1.x"))

lX  			= Long(this.Describe(sColumnname + "_1.x"))
lY  			= Long(this.Describe(sColumnname + "_1.y"))
lHeight		= Long(this.Describe(sColumnname + "_1.height"))
lWidth		= Long(this.Describe(sColumnname + "_1.width"))
lAlignment	= Long(this.Describe(sColumnname + "_1.alignment"))
lFontBold	= Long(this.Describe(sColumnname + "_1.font.weight"))
lFontSize	= Long(this.Describe(sColumnname + "_1.font.height"))
sFontFace	= this.Describe(sColumnname + "_1.font.face")

for i = 2 to 7
	
	lXOffset = lX + (lOffset * (I - 1))

	sCurrentColumn = sColumnName + "_" + string(i)
	sVisible = "0~tif( isnull(ncopy), 0, 1)"	
		
	this.SetPosition(sCurrentColumn, "", TRUE)
	sRet = this.modify(sCurrentColumn + ".visible='" + sVisible + "'")
	sRet = this.modify(sCurrentColumn + ".x=" + string(lXOffSet))
	sRet = this.modify(sCurrentColumn + ".y=" + string(lY))
	sRet = this.modify(sCurrentColumn + ".width=" + string(lWidth))
	sRet = this.modify(sCurrentColumn + ".alignment=" + string(lAlignment))
	sRet = this.modify(sCurrentColumn + ".height=" + string(lHeight))
	sRet = this.modify(sCurrentColumn + ".font.weight=" + string(lFontBold))
	sRet = this.modify(sCurrentColumn + ".font.height=" + string(lFontSize))
	sRet = this.modify(sCurrentColumn + ".font.face='" + sFontFace + "'")
	
Next

return 0
end function

on uo_location_sheet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_location_sheet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Integer 	I
String	sVisible

// ------------------------------------------
//
// Alle Objekte im Report positionieren, 
// formatieren
// 
// ------------------------------------------
this.of_format("cunit")
this.of_format("cstowage")
this.of_format("cclass")
this.of_format("ctext1")
this.of_format("ctext2")
this.of_format("ctext3")
this.of_format("nquantity1")
this.of_format("nquantity2")
this.of_format("nquantity3")
this.of_format("nquantity4")
this.of_format("nquantity5")
this.of_format("ccontent1")
this.of_format("ccontent2")
this.of_format("ccontent3")
this.of_format("ccontent4")
this.of_format("ccontent5")
this.of_format("ccontent_pl1")
this.of_format("ccontent_pl2")
this.of_format("ccontent_pl3")
this.of_format("ccontent_pl4")
this.of_format("ccontent_pl5")
this.of_format("cpackinglist")
this.of_format("cmeal_control_code")
this.of_format("ncopy")
this.of_format("nranking")
this.of_format("nranking_spml")
this.of_format("cpl_type")
this.of_format("nheight")
this.of_format("nwidth")
this.of_format("t_size")
this.of_format("t_ranking")

end event

