HA$PBExportHeader$uo_object_history.sru
forward
global type uo_object_history from nonvisualobject
end type
end forward

global type uo_object_history from nonvisualobject
end type
global uo_object_history uo_object_history

type variables
Datastore	dsHistory

date			dTimeStamp

long 			lAirlineKey
long			lHandlingID

integer		iSQLType
integer		iTabPage1
integer		iTabPage2
integer		iTabPage3
integer		iTabPage4
integer		iTabPage5
integer		iTabPage6
integer		iNew
integer		iDeleted

string		sObjectName
string		sRemark
string		sSuffix

long			lFlightNumber
end variables

forward prototypes
public function boolean of_update ()
public function boolean of_insert ()
end prototypes

public function boolean of_update ();If dsHistory.Update() <> 1 Then
	return False
End if

commit;
dsHistory.Reset()
return True
end function

public function boolean of_insert ();	long			lRow
	long			lSequence
	datetime		dtDateFrom,dtDateTo,dtNow
// ----------------------------------------------------
// Eintag in Tabelle sys_changes
// ----------------------------------------------------
	dtDateFrom	= datetime(Today(),time("00:00:00"))
	dtDateTo		= datetime(Today(),time("23:59:59"))
	dtNow			= datetime(today(),now())
	dsHistory.retrieve(dtDateFrom,dtDateTo)
	
	
// ----------------------------------------------------
// Mehrfache Eintr$$HEX1$$e400$$ENDHEX$$ge mit gleichen Datum unterdr$$HEX1$$fc00$$ENDHEX$$cken
// ----------------------------------------------------
	lRow = dsHistory.find("nuser_id = " + string(s_app.luser_id) + &
								 " and nairline_key = " + string(lAirlineKey) + &
								 " and nflight_number = " + string(lFlightNumber) + &
 								 " and csuffix = '" + sSuffix + "'" + &
								 " and cobject_name = '" + sObjectName + "'" + &
								 " and cremark = '" + sRemark + "'",1,dsHistory.Rowcount())
	
	If lRow <= 0 Then
		lRow = dsHistory.insertrow(0)
		lSequence = f_Sequence ("seq_sys_changes",sqlca)
		If lSequence = -1 Then
			return False
		End if	
	Else
		lSequence = dsHistory.GetitemNumber(lRow,"NCHANGE_KEY")
	End if
	
	If lRow <= 0 Then
		return False
	End if
	
	dsHistory.Setitem(lRow,"NCHANGE_KEY",lSequence)
	dsHistory.Setitem(lRow,"NUSER_ID",s_app.luser_id)
	dsHistory.Setitem(lRow,"DTIMESTAMP",dtNow)
	dsHistory.Setitem(lRow,"NAIRLINE_KEY",lAirlineKey)
	dsHistory.Setitem(lRow,"NFLIGHT_NUMBER",lFlightNumber)
	dsHistory.Setitem(lRow,"CSUFFIX",sSuffix)
	dsHistory.Setitem(lRow,"COBJECT_NAME",sObjectName)
	dsHistory.Setitem(lRow,"NSQL_TYPE",iSQLType)
	if iNew = 1 then
		dsHistory.Setitem(lRow,"NNEW",iNew)
	end if
	if iDeleted = 1 then
		dsHistory.Setitem(lRow,"NDELETED",iDeleted)
	end if 
	
	If dsHistory.GetitemNumber(lRow,"ntabpage_1") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_1",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_1",iTabPage1)
	End if
	
	If dsHistory.GetitemNumber(lRow,"ntabpage_2") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_2",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_2",iTabPage2)
	End if

	If dsHistory.GetitemNumber(lRow,"ntabpage_3") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_3",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_3",iTabPage3)
	End if
	
	If dsHistory.GetitemNumber(lRow,"ntabpage_4") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_4",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_4",iTabPage4)
	End if
	
	If dsHistory.GetitemNumber(lRow,"ntabpage_5") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_5",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_5",iTabPage5)
	End if
	
	If dsHistory.GetitemNumber(lRow,"ntabpage_6") = 1 Then
		dsHistory.Setitem(lRow,"ntabpage_6",1)
	Else
		dsHistory.Setitem(lRow,"ntabpage_6",iTabPage6)
	End if
	
	dsHistory.Setitem(lRow,"CREMARK",sRemark)

	return True
end function

on uo_object_history.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_object_history.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsHistory								= Create DataStore
dsHistory.DataObject					= "dw_object_history"
dsHistory.SetTransObject(SQLCA)
end event

event destructor;destroy dsHistory
end event

