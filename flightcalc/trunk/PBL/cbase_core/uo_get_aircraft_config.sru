HA$PBExportHeader$uo_get_aircraft_config.sru
$PBExportComments$Userobject welches alle g$$HEX1$$fc00$$ENDHEX$$ltigen Sitzplatz-Versionen f$$HEX1$$fc00$$ENDHEX$$r ein Flugger$$HEX1$$e400$$ENDHEX$$t anzeigt
forward
global type uo_get_aircraft_config from userobject
end type
type st_1 from statictext within uo_get_aircraft_config
end type
type p_indicator from picture within uo_get_aircraft_config
end type
type dw_1 from uo_parent_dw within uo_get_aircraft_config
end type
end forward

global type uo_get_aircraft_config from userobject
integer width = 1353
integer height = 468
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_rowfocuschanged ( )
event ue_doubleclicked ( )
st_1 st_1
p_indicator p_indicator
dw_1 dw_1
end type
global uo_get_aircraft_config uo_get_aircraft_config

type variables
//======================================================================================
//
// uo_get_aircraft_config
//
// Erzeugt einen Datastore mit allen g$$HEX1$$fc00$$ENDHEX$$ltigen Sitzplatz-Versionen f$$HEX1$$fc00$$ENDHEX$$r einen AC-Typ
//
//======================================================================================

public:

string		sErrortext			// Fehlertext

datastore	dsConfigurations	// Sitzplatzversionen (roh)

private:


end variables

forward prototypes
public function integer uf_retrieve (long arg_aircraftkey)
end prototypes

event ue_rowfocuschanged();//
// Wir reichen den RowFocusChanged nach au$$HEX1$$df00$$ENDHEX$$en
//

end event

event ue_doubleclicked();//
// Wir reichen den Doppelclick nach au$$HEX1$$df00$$ENDHEX$$en
//

end event

public function integer uf_retrieve (long arg_aircraftkey);//======================================================================================
//
// uf_retrieve
//
// Erzeugt einen Datastore mit allen g$$HEX1$$fc00$$ENDHEX$$ltigen Sitzplatz-Versionen f$$HEX1$$fc00$$ENDHEX$$r einen AC-Typ
//
//======================================================================================
long		lRow
long		lNewRow
long		i
long		lClassCounter
long		lVersionGroupKey
string	sVersion, sVersionFormat
integer	iVersion
integer	iDefault

if isnull(arg_aircraftkey) then
	sErrortext = "Property lAircraftKey was not set!"
	return -1
end if

dw_1.Reset()

lRow = dsConfigurations.Retrieve(arg_aircraftkey) 

// --------------------------------------------------------------
// Versionsstring erstellen und in external Datastore eintragen
// --------------------------------------------------------------
sVersion 			= ""
lVersionGroupKey = -1
for i = 1 to lRow
	if dsConfigurations.Getitemnumber(i,"ngroup_key") <>  lVersionGroupKey then
		sVersion 			= ""
		lVersionGroupKey 	= dsConfigurations.Getitemnumber(i,"ngroup_key")
		lNewRow 				= dw_1.insertrow(0)
		dw_1.Setitem(lNewRow,"ngroup_key",lVersionGroupKey)
		lClassCounter		= 0
	end if
	lClassCounter++
	iVersion = dsConfigurations.Getitemnumber(i,"nversion")
	if len(string(iVersion)) = 1 Then
		sVersionFormat = "000"
	elseIf len(string(iVersion)) = 2 Then
		sVersionFormat = "000"
	else
		sVersionFormat = "000"
	end if	
	 
	if sVersion = "" Then
		sVersion = string(iVersion,sVersionFormat)
	else
		sVersion = sVersion + "-" + string(iVersion,sVersionFormat)
	end if
	
	iDefault = dsConfigurations.Getitemnumber(i,"ndefault")
	
	dw_1.Setitem(lNewRow,"sversion",sVersion)
	dw_1.Setitem(lNewRow,"nclasses",lClassCounter)
	dw_1.Setitem(lNewRow,"ndefault",iDefault)
next

dw_1.SetSort("sversion a")
dw_1.Sort()

return 0

end function

on uo_get_aircraft_config.create
this.st_1=create st_1
this.p_indicator=create p_indicator
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.p_indicator,&
this.dw_1}
end on

on uo_get_aircraft_config.destroy
destroy(this.st_1)
destroy(this.p_indicator)
destroy(this.dw_1)
end on

event constructor;//
// Retrieve-Datastore f$$HEX1$$fc00$$ENDHEX$$r Datenbank
//
dsConfigurations									= Create uo_generate_datastore
dsConfigurations.DataObject 					= "dw_change_aircraft_version"
dsConfigurations.SetTransObject(SQLCA)

uf.translate_datawindow(dw_1)
dw_1.SetRowFocusIndicator(p_indicator)

st_1.visible = false

//this.height = 460
dw_1.height = this.height - 8 //448
dw_1.width = this.width - 14 //1339

// Cream 15793151
dw_1.modify("datawindow.color=15793151")
dw_1.object.t_1.background.color="15793151"

end event

event destructor;destroy dsConfigurations
end event

type st_1 from statictext within uo_get_aircraft_config
integer x = 215
integer y = 208
integer width = 974
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Gr$$HEX2$$f600df00$$ENDHEX$$e wird automatisch angepa$$HEX1$$df00$$ENDHEX$$t..."
boolean focusrectangle = false
end type

type p_indicator from picture within uo_get_aircraft_config
integer x = 2107
integer y = 216
integer width = 105
integer height = 72
boolean originalsize = true
string picturename = "..\Resource\Indicator.bmp"
boolean focusrectangle = false
end type

type dw_1 from uo_parent_dw within uo_get_aircraft_config
integer x = 5
integer y = 4
integer width = 1339
integer height = 448
integer taborder = 10
string dataobject = "dw_change_aircraft_configuration"
boolean border = true
end type

event rowfocuschanged;parent.triggerevent('ue_rowfocuschanged')

//if currentrow > 1 then
//	//
//	// nur bei mehr als einer Zeile kann man vom Wechsel der Version ausgehen
//	//
//	parent.triggerevent('ue_rowfocuschanged')
//end if


end event

event doubleclicked;call super::doubleclicked;parent.triggerevent('ue_doubleclicked')


end event

event getfocus;call super::getfocus;this.modify("datawindow.color=16777215")
this.object.t_1.background.color="16777215"


end event

event losefocus;call super::losefocus;// Cream 15793151
this.modify("datawindow.color=15793151")
this.object.t_1.background.color="15793151"

end event

