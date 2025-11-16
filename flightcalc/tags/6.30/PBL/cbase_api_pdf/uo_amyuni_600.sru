HA$PBExportHeader$uo_amyuni_600.sru
$PBExportComments$Unterst$$HEX1$$fc00$$ENDHEX$$tzung f$$HEX1$$fc00$$ENDHEX$$r Amyuni PDF Creator Version 6.00
forward
global type uo_amyuni_600 from uo_amyuni
end type
end forward

global type uo_amyuni_600 from uo_amyuni
end type
global uo_amyuni_600 uo_amyuni_600

type prototypes
PRIVATE:

function boolean SetLicenseKey(string szCompany, string szLicKey) library "cdintf600.dll" alias for "SetLicenseKeyA;Ansi"
function integer Lock(long hPrinter, string szLockName) library "cdintf600.dll" alias for "Lock;Ansi"
function integer TestLock(long hPrinter, string szLockName) library "cdintf600.dll" alias for "TestLock;Ansi"
function integer Unlock(long hPrinter, string szLockName, long dwTimeout) library "cdintf600.dll" alias for "Unlock;Ansi"
function integer SetDocFileProps(long hPrinter, string szDocTitle, long lOptions, string szFileDir, string szFileName) library "cdintf600.dll" alias for "SetDocFileProps;Ansi"
function integer DocOpen(ref long pedhDocument, string szFileName, string szPassword) library "cdintf600.dll" alias for "DocOpenA;Ansi"
function integer DocSave(long edhDocument, string szFileName) library "cdintf600.dll" alias for "DocSaveA;Ansi"
function integer DocPrint(long edhDocument, string szPrinterName, long lStartPage, long lEndPage, long lCopies) library "cdintf600.dll" alias for "DocPrintA;Ansi"
function integer DocAppend(long edhDocument, long edhSource) library "cdintf600.dll" alias for "DocAppend;Ansi"
function integer DocMerge(long edhDocument, long edhSource, boolean fRepeat, boolean fAbove) library "cdintf600.dll" alias for "DocMerge;Ansi"
function integer DocClose(long edhDocument) library "cdintf600.dll" alias for "DocClose;Ansi"
function long DocSetTitle(long edhDocument, string szValue) library "cdintf600.dll" alias for "DocSetTitleA;Ansi"
function long SetWatermark(long hPrinter, string szWatermark, string szFont, integer fontSize, integer Orientation, ulong color, long xPos, long yPos, boolean bForeground) library "cdintf600.dll" alias for "SetWatermark;Ansi"
function long EnablePrinter(long hPrinter, string szCompany, string szCode) library "cdintf600.dll" alias for "EnablePrinter;Ansi"
function long DriverInit(string szPrinter) library "cdintf600.dll" alias for "DriverInit;Ansi"
function integer DocGetPageCount(long edhDocument, ref integer pageCount) library "cdintf600.dll"
function integer DocSplit(long edhDocument, string prefix) library "cdintf600.dll" alias for "DocSplitA;Ansi"
//function integer DocOptimize(long edhDocument, integer iLevel) library "cdintf600.dll" alias for "DocOptimize;Ansi"
//function long BatchConvertEx(long hPrinter, string szFileName) library "cdintf600.dll" alias for "BatchConvertEx;Ansi"

subroutine DriverEnd(long hPrinter) library "cdintf600.dll" alias for "DriverEnd;Ansi"
subroutine GetLastErrorMsg(ref string Msg, long MaxMsg) library "cdintf600.dll" alias for "GetLastErrorMsg;Ansi"

// HINWEIS:
// DocOptimize macht leider Probleme, wenn es mehrmals aufgerufen wird (komischerweise geht es in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version).
// Es k$$HEX1$$f600$$ENDHEX$$nnte allerdings m$$HEX1$$f600$$ENDHEX$$gliche Probleme mit PDF Dokumenten beheben, die nicht mit Amyuni erstellt wurden.
// Da es aber zur Zeit noch keinen Bedarf gibt, es zu verwenden, ist es auskommentiert.
//
// BatchConvertEx funktioniert leider nicht mit der neuen SetDocFileProps Funktion zusammen, mit der es m$$HEX1$$f600$$ENDHEX$$glich w$$HEX1$$e400$$ENDHEX$$re,
// mehrere Dateien gleichzeitig nach PDF zu konvertieren.
// Stattdessen m$$HEX1$$fc00$$ENDHEX$$ssen f$$HEX1$$fc00$$ENDHEX$$r jeden Auftrag Defaults f$$HEX1$$fc00$$ENDHEX$$r den PDF Drucker definiert werden, was keine gute Idee ist.
end prototypes

type variables

end variables

on uo_amyuni_600.create
call super::create
end on

on uo_amyuni_600.destroy
call super::destroy
end on

event constructor;call super::constructor;// Lizenz festlegen
If ServerMode Then
	is_LicenseCompany = "Amyuni Tech Eval"
	is_LicenseKey = "07EFCDAB01000100FB0841E7D3A4FDC952023E0C9C3E4379357194AE3F4F4552C9C0582EA24B1FC4ED4FE1400AEC99BC49991EDD49926BB8DEE79B4E7D76F36E"
Else
	is_LicenseCompany = "LSG Sky Chefs"
	is_LicenseKey = "07EFCDAB0100010054F8D2FCE23CB30685B5B09B4F5595FB452654C766270EB6AF17AACAC6C103F4A4292D1570A884D4C3613D3480E8"
End If

// PDF Creator OLE festlegen
is_PDFCreatorOLE = "PDFCreactiveX.PDFCreactiveX.6.0"

// Version festlegen
is_Version = "6.00"

// Amyuni Drucker festlegen
PrinterName = "CBASE PDF CONVERTER"




end event

