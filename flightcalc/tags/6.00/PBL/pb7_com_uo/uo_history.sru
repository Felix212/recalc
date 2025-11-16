HA$PBExportHeader$uo_history.sru
forward
global type uo_history from nonvisualobject
end type
end forward

global type uo_history from nonvisualobject
end type
global uo_history uo_history

type variables
string 	sSQLType[]
string 	sSyntax[]
long		lIndex = 0
 
end variables

forward prototypes
public function boolean uf_write_history ()
public function long uf_add_history (string stype, string ssqlsyntax)
end prototypes

public function boolean uf_write_history ();long i
string sNow

// -------------------------------------
// 03.12.2003
// Keine History mehr wegschreiben
// -------------------------------------
Return True


//For i = 1 to Upperbound(sSyntax)
//	  sNow = string(Today(),"YYYY.MM.DD") + " " + string(Now(),"hh:mm:ss") + ":" + string(i)
//	  INSERT INTO sys_history  
//         ( cusername,   
//           chost_ip,   
//           cclient,   
//           cunit,   
//           stimestamp,   
//           cSQLType,   
//           cSQLSyntax )  
//  VALUES ( :s_app.sUser,   
//           :s_app.sclientip,   
//           :s_app.sMandant,   
//           :s_app.sWerk,   
//           :sNow,   
//           :sSQLType[i],   
//           :sSyntax[i] )  ;
//			  
//	 If SQLCA.sqlcode <> 0 then
//		 rollback;
//		 return FALSE			  
//	 End if
//Next	
//	
//	
//return True	
end function

public function long uf_add_history (string stype, string ssqlsyntax);
Return 0

lIndex ++
sSQLType[lIndex]	= sType
sSyntax[lIndex] 	= sSqlSyntax

return lIndex
end function

on uo_history.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_history.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

