HA$PBExportHeader$uo_generate_datastore.sru
$PBExportComments$Erweiterter Datastore f$$HEX1$$fc00$$ENDHEX$$r die Fluggenerierung
forward
global type uo_generate_datastore from datastore
end type
end forward

global type uo_generate_datastore from datastore
end type
global uo_generate_datastore uo_generate_datastore

type variables
long			lSQLErrorRow
long			lSQLErrorDBCode
string			sSQLErrorText

// 26.03.2010 HR:
integer  ii_LogToFile=0



end variables

forward prototypes
public function boolean of_insert_history (string ssqlsyntax, long lrow)
end prototypes

public function boolean of_insert_history (string ssqlsyntax, long lrow);// ---------------------------------------------------------------------
// Schreibt den aktuellen Datensatz in die entsprechende History Tabelle
// ---------------------------------------------------------------------
	string 	sTable
	
	long		lPos
	
	If lRow <= 0 Then
		return True
	End if
	
// -------------------------------------------------
// Tabellennamen ermitteln
// -------------------------------------------------
	sTable 	= this.Object.DataWindow.Table.UpdateTable
	lPos		= PosA(sSqlSyntax,sTable)
// -------------------------------------------------
// Syntax modifizieren
// -------------------------------------------------	
	If lPos > 0 Then
		sSqlSyntax = ReplaceA(sSqlSyntax,lPos,LenA(sTable),sTable + "_history")
		EXECUTE IMMEDIATE :sSqlSyntax;
		If SQLCA.SQLCODE <> 0 Then
			sSQLErrorText = "History"
			return False
		End if
	Else	
		return False
	End if
	
	
	Return True
	
	
end function

on uo_generate_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_generate_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;lSQLErrorRow		= row
lSQLErrorDBCode	= sqldbcode
sSQLErrorText 		= sqlerrtext


//messagebox("", sqlerrtext)

if ii_LogToFile=1 then
	f_log2csv(1,3,this.dataobject+": Row: "+string(row)+" SQLCODE: "+string(sqldbcode)+": "+sqlerrtext)
end if
end event

event sqlpreview;//// -----------------------------------
//// Aufruf der History Funktionen
//// -----------------------------------
//	string sTest
//	If SQLTYPE  = PreviewInsert!	Then
//		Messagebox("SQL",sqlsyntax)
//
//	ElseIf SQLTYPE  = PreviewDelete!	Then	
//		Messagebox("SQL",sqlsyntax)
//
//	ElseIf SQLTYPE  = PreviewUpdate!		Then	
//		Messagebox("SQL",sqlsyntax)
//	End if	
//	
//	
	
end event

