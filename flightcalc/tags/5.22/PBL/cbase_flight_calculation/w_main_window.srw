HA$PBExportHeader$w_main_window.srw
$PBExportComments$Fenster zur Anzeige und zum Nachstarten einzelner Jobs
forward
global type w_main_window from window
end type
type pb_2 from picturebutton within w_main_window
end type
type st_5 from statictext within w_main_window
end type
type ddlb_functions from dropdownlistbox within w_main_window
end type
type cbx_read_cen_out from checkbox within w_main_window
end type
type rb_2 from radiobutton within w_main_window
end type
type rb_1 from radiobutton within w_main_window
end type
type em_date from editmask within w_main_window
end type
type pb_1 from picturebutton within w_main_window
end type
type cb_filter from commandbutton within w_main_window
end type
type sle_filter from singlelineedit within w_main_window
end type
type uo_statusbar from uo_comctl_statusbar within w_main_window
end type
type pb_retrieve from picturebutton within w_main_window
end type
type pb_exit from picturebutton within w_main_window
end type
type pb_run from picturebutton within w_main_window
end type
type dw_1 from datawindow within w_main_window
end type
type st_1 from statictext within w_main_window
end type
type st_2 from statictext within w_main_window
end type
type st_3 from statictext within w_main_window
end type
type st_4 from statictext within w_main_window
end type
type st_6 from statictext within w_main_window
end type
end forward

global type w_main_window from window
integer width = 3845
integer height = 2176
boolean titlebar = true
string title = "Service Flight Calculation"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_post_open ( )
pb_2 pb_2
st_5 st_5
ddlb_functions ddlb_functions
cbx_read_cen_out cbx_read_cen_out
rb_2 rb_2
rb_1 rb_1
em_date em_date
pb_1 pb_1
cb_filter cb_filter
sle_filter sle_filter
uo_statusbar uo_statusbar
pb_retrieve pb_retrieve
pb_exit pb_exit
pb_run pb_run
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_6 st_6
end type
global w_main_window w_main_window

type variables

string sSection = "WindowParameters"
uo_Flight_Calculation uoFlightCalc
Integer iselected_function
Integer		iNumberToProcess 


end variables

forward prototypes
public subroutine wf_enabled_objects (boolean benabled)
end prototypes

event ue_post_open();
Long	lRet
Time Start,Ende

Start = Now()
uo_StatusBar.of_SetText(0,0,"Starting...")
Ende = Now()
uo_StatusBar.of_SetText(0,0,"Ready in " + string(secondsAfter(start,ende),"00") + " seconds.")

end event

public subroutine wf_enabled_objects (boolean benabled);pb_1.enabled=benabled
pb_retrieve.enabled=benabled
cb_filter.enabled=benabled
pb_run.enabled=benabled
sle_filter.enabled=benabled
rb_1.enabled=benabled
rb_2.enabled=benabled
em_date.enabled=benabled
ddlb_functions.enabled=benabled
cbx_read_cen_out.enabled=benabled
end subroutine

on w_main_window.create
this.pb_2=create pb_2
this.st_5=create st_5
this.ddlb_functions=create ddlb_functions
this.cbx_read_cen_out=create cbx_read_cen_out
this.rb_2=create rb_2
this.rb_1=create rb_1
this.em_date=create em_date
this.pb_1=create pb_1
this.cb_filter=create cb_filter
this.sle_filter=create sle_filter
this.uo_statusbar=create uo_statusbar
this.pb_retrieve=create pb_retrieve
this.pb_exit=create pb_exit
this.pb_run=create pb_run
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_6=create st_6
this.Control[]={this.pb_2,&
this.st_5,&
this.ddlb_functions,&
this.cbx_read_cen_out,&
this.rb_2,&
this.rb_1,&
this.em_date,&
this.pb_1,&
this.cb_filter,&
this.sle_filter,&
this.uo_statusbar,&
this.pb_retrieve,&
this.pb_exit,&
this.pb_run,&
this.dw_1,&
this.st_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_6}
end on

on w_main_window.destroy
destroy(this.pb_2)
destroy(this.st_5)
destroy(this.ddlb_functions)
destroy(this.cbx_read_cen_out)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.em_date)
destroy(this.pb_1)
destroy(this.cb_filter)
destroy(this.sle_filter)
destroy(this.uo_statusbar)
destroy(this.pb_retrieve)
destroy(this.pb_exit)
destroy(this.pb_run)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_6)
end on

event open;Datetime dDate
Integer i

setnull(dDate)

f_profile()
cbx_read_cen_out.checked	= (ProfileString(sProfile, this.sSection, "ReadCenOut", String("true"))="true")

sle_filter.text = ProfileString(sProfile, this.sSection, "Filter", "")
em_date.text = ProfileString(sProfile, this.sSection, "Date", String(Today()))
iNumberToProcess = Integer(ProfileString(sProfile, sInstance, "NumberOfCalculationsToProcess", "1"))

dDate = Datetime(Today())
rb_1.TriggerEvent(Clicked!)

dw_1.SetTransObject(sqlca)
//dw_1.Retrieve(dDate)

cb_filter.TriggerEvent(Clicked!)

uoFlightCalc =create uo_Flight_calculation
dw_1.ShareData(uoFlightCalc.dsJobs)

uoFlightCalc.dsSysQueueFunctions.retrieve()

ddlb_functions.AddItem("(0) Alle")

For i = 1 to uoFlightCalc.dsSysQueueFunctions.RowCount()
	ddlb_functions.AddItem("(" + &
		String(uoFlightCalc.dsSysQueueFunctions.GetItemNumber(i,"nfunction")) + ") " + &
		uoFlightCalc.dsSysQueueFunctions.GetItemString(i,"ctext"))
Next
ddlb_functions.selectItem(1)
iselected_function = 1

postevent("ue_post_open")

end event

event close;
SetProfileString(sProfile, this.sSection, "Filter", sle_filter.text)
SetProfileString(sProfile, this.sSection, "Date", em_date.text)
SetProfileString(sProfile, this.sSection, "ReadCenOut", String(cbx_read_cen_out.checked))

Destroy uoFlightCalc
	

			
end event

type pb_2 from picturebutton within w_main_window
integer x = 3625
integer y = 1616
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\thermo_on.gif"
string disabledname = "..\Resource\thermo_off.gif"
alignment htextalign = left!
string powertiptext = "Instanzen-Setup"
end type

event clicked;open(w_setup)
end event

type st_5 from statictext within w_main_window
boolean visible = false
integer x = 1682
integer y = 152
integer width = 251
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Funktion"
boolean focusrectangle = false
end type

type ddlb_functions from dropdownlistbox within w_main_window
string tag = "Function"
boolean visible = false
integer x = 1934
integer y = 144
integer width = 850
integer height = 324
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event selectionchanged;iselected_function = index
end event

type cbx_read_cen_out from checkbox within w_main_window
boolean visible = false
integer x = 2843
integer y = 140
integer width = 571
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cen_out auslesen"
end type

type rb_2 from radiobutton within w_main_window
integer x = 640
integer y = 152
integer width = 512
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "alle Auftr$$HEX1$$e400$$ENDHEX$$ge vom"
end type

event clicked;
if rb_2.Checked then
	em_date.enabled = true
else
	em_date.enabled = false
end if

dw_1.dataobject="dw_job_list_all"
dw_1.settransobject(SQLCA)
end event

type rb_1 from radiobutton within w_main_window
integer x = 27
integer y = 152
integer width = 567
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "nur offene Auftr$$HEX1$$e400$$ENDHEX$$ge"
boolean checked = true
end type

event clicked;
if rb_2.Checked then
	em_date.enabled = true
else
	em_date.enabled = false
end if

dw_1.dataobject="dw_job_list_new"
dw_1.settransobject(SQLCA)
end event

type em_date from editmask within w_main_window
integer x = 1170
integer y = 144
integer width = 343
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type pb_1 from picturebutton within w_main_window
integer x = 3625
integer y = 168
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "..\Resource\diskett2.gif"
string disabledname = "Close!"
alignment htextalign = left!
string powertiptext = "Retrieve"
end type

event clicked;Integer i
Long lNull

setnull(lNull)

For i = 1 to dw_1.rowcount()
	if dw_1.getitemstatus(i, "dstart_computing",Primary!) = DataModified! then
		if isnull(dw_1.getitemdatetime(i,"dstart_computing")) then
			dw_1.setitem(i,"nerror",lNull)
		end if
	end if
next
dw_1.Update()
commit;

end event

type cb_filter from commandbutton within w_main_window
integer x = 3502
integer y = 36
integer width = 261
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filter"
boolean default = true
end type

event clicked;string a
date dDate
if rb_1.checked then
	a = sle_filter.text
else
	dDate = Date(em_date.text)
	if trim(sle_filter.text)>" " then
		a = "("+sle_filter.text +") and (date(dcreated) = date('"+string(dDate, "yyyy-mm-dd")+"') or date(dstop_computing)=date('"+string(dDate, "yyyy-mm-dd")+"'))"
	else
		a = "(date(dcreated) = date('"+string(dDate, "yyyy-mm-dd")+"') or date(dstop_computing)=date('"+string(dDate, "yyyy-mm-dd")+"'))"
	end if
end if

if dw_1.SetFilter(a)<>1 then
	setnull(a)
	dw_1.SetFilter(a)
end if
dw_1.Filter()
end event

type sle_filter from singlelineedit within w_main_window
integer x = 18
integer y = 32
integer width = 3415
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_statusbar from uo_comctl_statusbar within w_main_window
integer x = 2661
integer y = 2144
integer taborder = 40
end type

type pb_retrieve from picturebutton within w_main_window
integer x = 3625
integer y = 340
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "..\Resource\fluggeraet_color.gif"
string disabledname = "Close!"
alignment htextalign = left!
string powertiptext = "Retrieve"
end type

event clicked;Datetime dDate
Integer 	i
Integer 	iEmpty[]
string 	a

wf_enabled_objects(false)

// Verarbeitung cen_out
uoFlightCalc.bread_cen_out = cbx_read_cen_out.checked
uoFlightCalc.iProcessFunction[] = iEmpty[]
uoFlightCalc.iProcessFunction[1] = -1

if iselected_function > 1 then
	i =  iselected_function - 1
	uoFlightCalc.iProcessFunction[1] = uoFlightCalc.dsSysQueueFunctions.GetItemNumber(i,"nfunction")
	uoFlightCalc.iProcessFunction[2] = 6 //test
end if
uoFlightCalc.iNumberOfCalculationsToProcess = 1
//if rb_1.checked then
//	setnull(dDate)
//	//dw_1.Retrieve(dDate)
//	//setnull(uoFlightCalc.dCheckDate)
//	dw_1.setfilter("")
//else
//	dDate = DateTime(Date(em_date.text))
//	
//	 dw_1.setfilter("date(dcreated) = date('"+string(dDate, "yyyy-mm-dd")+"') or date(dstop_computing)=date('"+string(dDate, "yyyy-mm-dd")+"')") 
//	
//	//dw_1.Retrieve(dDate)
//	//uoFlightCalc.dCheckDate = dDate
//end if
//uoFlightCalc.of_retrieve_dsjobs(dDate)
dw_1.retrieve(uoFlightCalc.iProcessFunction, sServiceName)
cb_filter.triggerevent(clicked!)
wf_enabled_objects(true)


end event

type pb_exit from picturebutton within w_main_window
integer x = 3625
integer y = 1816
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "..\Resource\door02.gif"
string disabledname = "..\Resource\door02.gif"
alignment htextalign = left!
string powertiptext = "Run"
end type

event clicked;close(parent)
end event

type pb_run from picturebutton within w_main_window
integer x = 3625
integer y = 512
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "..\Resource\run_enabled.gif"
string disabledname = "Close!"
alignment htextalign = left!
string powertiptext = "Run"
end type

event clicked;Datetime dDate
Integer i, j
Integer iEmpty[]
long lrow
s_app.iTrace = 99
lrow=dw_1.getrow()
wf_enabled_objects(false)
SetPointer(HourGlass!)
i=messagebox("Frage","Nur den ausgew$$HEX1$$e400$$ENDHEX$$hlten Flug bearbeiten?",QUESTION!,YesNoCancel! )
if i=1 then
	if dw_1.rowcount()=0 then 
		SetPointer(Arrow!)
		wf_enabled_objects(true)
		return 0
	end if
	
	// Funktionsablauf Start
	uoFlightCalc.dsJobs.dataobject="dw_job_list_jobnr"
	uoFlightCalc.dsJobs.settransobject(SQLCA)
	uoFlightCalc.dsJobs.retrieve(dw_1.getitemnumber(lrow,"njob_nr"))
	setnull(j)
	uoFlightCalc.dsJobs.setitem(1,"cinstance",sInstance)
	uoFlightCalc.dsJobs.setitem(1,"nerror",j)
	uoFlightCalc.dsJobs.setitem(1,"cerror"," ")
	uoFlightCalc.dsJobs.setitem(1,"nprocess_status",1)
	
	uoFlightCalc.ib_check_jobstate = false // 09.10.2015 HR: Job soll unabh$$HEX1$$e400$$ENDHEX$$ngig des Status abgearbeitet werden
	
elseif i=3 then
	SetPointer(Arrow!)
	wf_enabled_objects(true)
	return 0
else
	uoFlightCalc.dsJobs.dataobject="dw_job_list_new"
	uoFlightCalc.dsJobs.settransobject(SQLCA)

	// Verarbeitung cen_out
	uoFlightCalc.bread_cen_out = cbx_read_cen_out.checked
	uoFlightCalc.iProcessFunction[] = iEmpty[]
	uoFlightCalc.iProcessFunction[1] = -1

	if iselected_function > 1 then
		i =  iselected_function - 1
		uoFlightCalc.iProcessFunction[1] = uoFlightCalc.dsSysQueueFunctions.GetItemNumber(i,"nfunction")
		uoFlightCalc.iProcessFunction[2] = 6 //test
	end if
	uoFlightCalc.iNumberOfCalculationsToProcess = 3
	if rb_1.checked then
		setnull(dDate)
	else
		dDate = DateTime(Date(em_date.text))
	end if
	uoFlightCalc.of_retrieve_dsjobs(dDate)
end if
uoFlightCalc.of_start()

// Funktionsablauf Ende

SetPointer(Arrow!)

wf_enabled_objects(true)
pb_retrieve.TriggerEvent(Clicked!)

return 0
end event

type dw_1 from datawindow within w_main_window
integer x = 14
integer y = 260
integer width = 3566
integer height = 1712
integer taborder = 10
string title = "none"
string dataobject = "dw_job_list_new"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;

if row > 0 then
	
	//openwithparm(w_result, this.GetItemNumber(row, "nresult_key"))
	
end if
end event

type st_1 from statictext within w_main_window
integer x = 3621
integer y = 508
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main_window
integer x = 3621
integer y = 1812
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_main_window
integer x = 3621
integer y = 336
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_main_window
integer x = 3621
integer y = 164
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_main_window
integer x = 3621
integer y = 1612
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

