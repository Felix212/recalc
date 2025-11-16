HA$PBExportHeader$uo_amyuni_251.sru
$PBExportComments$Unterst$$HEX1$$fc00$$ENDHEX$$tzung f$$HEX1$$fc00$$ENDHEX$$r Amyuni PDF Creator Version 2.51
forward
global type uo_amyuni_251 from uo_amyuni
end type
end forward

global type uo_amyuni_251 from uo_amyuni
string is_licensecompany = "LSG Sky Chefs"
string is_licensekey = "07EFCDAB0100010054F8D2FC003CB306BCB5B09B4D5595EB442654C763270DB7AFE8A3CAC3C0030B94292D1D78AAE7D4C35A5E3480E080FB113AB5429D61C1"
end type
global uo_amyuni_251 uo_amyuni_251

type prototypes
PRIVATE:

function boolean SetLicenseKey(string szCompany, string szLicKey) library "cdintf251.dll" alias for "SetLicenseKeyA;Ansi"
function integer Lock(long hPrinter, string szLockName) library "cdintf251.dll" alias for "Lock;Ansi"
function integer TestLock(long hPrinter, string szLockName) library "cdintf251.dll" alias for "TestLock;Ansi"
function integer Unlock(long hPrinter, string szLockName, long dwTimeout) library "cdintf251.dll" alias for "Unlock;Ansi"
function integer SetDocFileProps(long hPrinter, string szDocTitle, long lOptions, string szFileDir, string szFileName) library "cdintf251.dll" alias for "SetDocFileProps;Ansi"
function integer DocOpen(ref long pedhDocument, string szFileName, string szPassword) library "cdintf251.dll" alias for "DocOpenA;Ansi"
function integer DocSave(long edhDocument, string szFileName) library "cdintf251.dll" alias for "DocSaveA;Ansi"
function integer DocPrint(long edhDocument, string szPrinterName, long lStartPage, long lEndPage, long lCopies) library "cdintf251.dll" alias for "DocPrintA;Ansi"
function integer DocAppend(long edhDocument, long edhSource) library "cdintf251.dll"
function integer DocMerge(long edhDocument, long edhSource, boolean fRepeat, boolean fAbove) library "cdintf251.dll"
function integer DocClose(long edhDocument) library "cdintf251.dll"
// function integer DocOptimize(long edhDocument, integer iLevel) library "cdintf251.dll"
function long SetWatermark(long hPrinter, string szWatermark, string szFont, integer fontSize, integer Orientation, ulong color, long xPos, long yPos, boolean bForeground) library "cdintf251.dll" alias for "SetWatermark;Ansi"
function long EnablePrinter(long hPrinter, string szCompany, string szCode) library "cdintf251.dll" alias for "EnablePrinter;Ansi"
function long DriverInit(string szPrinter) library "cdintf251.dll" alias for "DriverInit;Ansi"
subroutine DriverEnd(long hPrinter) library "cdintf251.dll"
subroutine GetLastErrorMsg(ref string Msg, long MaxMsg) library "cdintf251.dll"

// HINWEIS:
// DocOptimize macht leider Probleme, wenn es mehrmals aufgerufen wird (komischerweise geht es in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version).
// Es k$$HEX1$$f600$$ENDHEX$$nnte allerdings m$$HEX1$$f600$$ENDHEX$$gliche Probleme mit PDF Dokumenten beheben, die nicht mit Amyuni erstellt wurden.
// Da es aber zur Zeit noch keinen Bedarf gibt, es zu verwenden, ist es auskommentiert.
end prototypes

type variables

end variables

on uo_amyuni_251.create
call super::create
end on

on uo_amyuni_251.destroy
call super::destroy
end on

event constructor;call super::constructor;// Lizenz festlegen
is_LicenseCompany = "LSG Sky Chefs"
is_LicenseKey = "07EFCDAB0100010054F8D2FC003CB306BCB5B09B4D5595EB442654C763270DB7AFE8A3CAC3C0030B94292D1D78AAE7D4C35A5E3480E080FB113AB5429D61C1"

// Amyuni Drucker festlegen
PrinterName = "CBASE PDF CONVERTER"
end event

