HA$PBExportHeader$uo_amyuni_550.sru
$PBExportComments$Unterst$$HEX1$$fc00$$ENDHEX$$tzung f$$HEX1$$fc00$$ENDHEX$$r Amyuni PDF Creator Version 5.50
forward
global type uo_amyuni_550 from uo_amyuni
end type
end forward

global type uo_amyuni_550 from uo_amyuni
end type
global uo_amyuni_550 uo_amyuni_550

type prototypes
PRIVATE:

function boolean SetLicenseKey(string szCompany, string szLicKey) library "cdintf550.dll" alias for "SetLicenseKeyA;Ansi"
function integer Lock(long hPrinter, string szLockName) library "cdintf550.dll" alias for "Lock;Ansi"
function integer TestLock(long hPrinter, string szLockName) library "cdintf550.dll" alias for "TestLock;Ansi"
function integer Unlock(long hPrinter, string szLockName, long dwTimeout) library "cdintf550.dll" alias for "Unlock;Ansi"
function integer SetDocFileProps(long hPrinter, string szDocTitle, long lOptions, string szFileDir, string szFileName) library "cdintf550.dll" alias for "SetDocFileProps;Ansi"
function integer DocOpen(ref long pedhDocument, string szFileName, string szPassword) library "cdintf550.dll" alias for "DocOpenA;Ansi"
function integer DocSave(long edhDocument, string szFileName) library "cdintf550.dll" alias for "DocSaveA;Ansi"
function integer DocPrint(long edhDocument, string szPrinterName, long lStartPage, long lEndPage, long lCopies) library "cdintf550.dll" alias for "DocPrintA;Ansi"
function integer DocAppend(long edhDocument, long edhSource) library "cdintf550.dll" alias for "DocAppend;Ansi"
function integer DocMerge(long edhDocument, long edhSource, boolean fRepeat, boolean fAbove) library "cdintf550.dll" alias for "DocMerge;Ansi"
function integer DocClose(long edhDocument) library "cdintf550.dll" alias for "DocClose;Ansi"
function long DocSetTitle(long edhDocument, string szValue) library "cdintf550.dll" alias for "DocSetTitleA;Ansi"
function long SetWatermark(long hPrinter, string szWatermark, string szFont, integer fontSize, integer Orientation, ulong color, long xPos, long yPos, boolean bForeground) library "cdintf550.dll" alias for "SetWatermark;Ansi"
function long EnablePrinter(long hPrinter, string szCompany, string szCode) library "cdintf550.dll" alias for "EnablePrinter;Ansi"
function long DriverInit(string szPrinter) library "cdintf550.dll" alias for "DriverInit;Ansi"
function integer DocGetPageCount(long edhDocument, ref integer pageCount) library "cdintf550.dll"
function integer DocSplit(long edhDocument, string prefix) library "cdintf550.dll" alias for "DocSplitA;Ansi"
//function integer DocOptimize(long edhDocument, integer iLevel) library "cdintf550.dll" alias for "DocOptimize;Ansi"
//function long BatchConvertEx(long hPrinter, string szFileName) library "cdintf550.dll" alias for "BatchConvertEx;Ansi"

subroutine DriverEnd(long hPrinter) library "cdintf550.dll" alias for "DriverEnd;Ansi"
subroutine GetLastErrorMsg(ref string Msg, long MaxMsg) library "cdintf550.dll" alias for "GetLastErrorMsg;Ansi"

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

on uo_amyuni_550.create
call super::create
end on

on uo_amyuni_550.destroy
call super::destroy
end on

event constructor;// Set reference to self for dynamic calls
self = this

// Lizenz festlegen
is_LicenseCompany = "LSG Sky Chefs"
is_LicenseKey = "WE DO NOT HAVE A VALID AMYUNI 5.5 LICENSE"

// PDF Creator OLE festlegen
is_PDFCreatorOLE = "PDFCreactiveX.PDFCreactiveX.5.5"

// Version festlegen
is_Version = "5.50"

// Amyuni Drucker festlegen
PrinterName = "CBASE PDF CONVERTER"

// Call a dynamic initialization event on application level to be able to configure instances of this object in one place
GetApplication().EVENT DYNAMIC ue_amyuni_init(self)
end event

