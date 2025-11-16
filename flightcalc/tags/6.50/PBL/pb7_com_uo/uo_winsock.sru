HA$PBExportHeader$uo_winsock.sru
forward
global type uo_winsock from nonvisualobject
end type
type wsadata from structure within uo_winsock
end type
end forward

type wsadata from structure
	unsignedinteger		wversion
	unsignedinteger		whighversion
	character		szdescription[257]
	character		szsystemstatus[129]
	unsignedinteger		imaxsockets
	unsignedinteger		imaxudgdg
	string		lpvendorinfo
end type

global type uo_winsock from nonvisualobject
end type
global uo_winsock uo_winsock

type prototypes

Private:

// vier externe Funktionen der Winsock
Function Long gethostname (REF String HostName, Long NameLen) LIBRARY "Wsock32.dll" alias for "gethostname;Ansi"	// den Hostnamen ermitteln
Function Long WSAStartup (Int wVersionRequested, REF wsadata lpWSAData) LIBRARY "Wsock32.dll" alias for "WSAStartup;Ansi"	// Init auf die DLL 
Function Long WSACleanup () LIBRARY "Wsock32.dll"	// Freigeben

Function long inet_addr(ref string addr) library "wsock32.dll" alias for "inet_addr;Ansi"



//Function long gethostbyaddr ( REF uLong Address, int AddressLen, int AddressType) LIBRARY "Wsock32.dll"
//Function long gethostbyaddr ( REF String Address, int AddressLen, int AddressType) LIBRARY "Wsock32.dll"
//SUBROUTINE CopyMemory ( ref s_hostent d, long s, long l )  LIBRARY "kernel32.dll"  ALIAS FOR RtlMoveMemory
//function ulong GlobalAlloc(ulong uFlags, long dwBytes ) library 'kernel32.dll'
//function ulong GlobalLock(ulong hMem ) library 'kernel32.dll'
//function ulong GlobalUnlock(ulong hMem ) library 'kernel32.dll'
//function ulong GlobalFree(ulong hMem ) library 'kernel32.dll'


end prototypes

type variables
Private:

	Boolean	WSAStartUpFailed
	
	








end variables

forward prototypes
public function integer localip (ref string sip)
public function integer localhostname (ref string hostname)
end prototypes

public function integer localip (ref string sip);// **********************************************
//
//		Function Integer LocalIP(REF String sIP)
//
//			Diese Funktion ermittelt die IP-Adresse
//			aus der Registry, indem sie die prim$$HEX1$$e400$$ENDHEX$$re
//			Netzkarte ermittelt und dann die IP
//			fest
// **********************************************


String 	sKarte, sZweig, sBuffIP[], sDHCPIP, sAllCards[], sAllIP[]
Integer	i, j
j = 0

// **********************************************
// alle Netzkarten ermitteln
// **********************************************

if RegistryKeys ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards", &
						sAllCards[]) = -1 Then
	// **********************************************
	//	keine Netzwerkkarte. Wie funktioniert dann dieses
	// Programm ?
	// **********************************************
	return -1
end if

For i = 1 To Upperbound(sAllCards[])
	// **********************************************
	// die IP-Adressen aller Netzkarten ermitteln
	// es kann auch sein, da$$HEX2$$df002000$$ENDHEX$$keine vorhanden ist
	// **********************************************
	if RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\" +sAllCards[i], &
					"ServiceName", RegString!, sKarte) = 1 Then

		sZweig = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\" + &
					sKarte + "\Parameters\Tcpip"
				
		RegistryGet(sZweig, "IPAddress", RegMultiString!, sBuffIP[])
		// **********************************************
		// RegistryGet() mit RegMultiString! liefert immer 
		// -1 (!). Warum auch immer, also auf Upperbound
		// checken und ggf. dem Array zuordnen. Wir sortieren
		// sp$$HEX1$$e400$$ENDHEX$$ter
		// **********************************************
		if Upperbound(sBuffIP[])  > 0 Then
			if Len(sBuffIP[1]) > 0 and sBuffIP[1] <> "0.0.0.0" Then
				j ++		
				sAllIP[j] 	= sBuffIP[1]
				sBuffIP[1] 	= ""
			else
				// --------------------------------------------------------
				// 19.04.2005, Klaus
				// Bei DHCP Kisten hat sich gezeigt, dass die Adresse in 
				// einem anderen Key steht, deshalb, wenn IP=0.0.0.0 dann
				// nochmal bei DhcpIPAddress vorbeischaun
				// --------------------------------------------------------
				RegistryGet(sZweig, "DhcpIPAddress", RegString!, sDHCPIP)
				if Len(sDHCPIP) > 0 Then
					j ++		
					sAllIP[j] 	= sDHCPIP
					sDHCPIP 	= ""
				end if 
				
			end if
		end if
	end if
Next

//messagebox("", sDHCPIP)
	
// **********************************************
//	jetzt sind alle IP's bekannt
// 18.04.2005 Klaus
// Wenn im Laufe des Lebenszyklus eines PC's
// mal die IP - Adresse ge$$HEX1$$e400$$ENDHEX$$ndert wurde, dann
// steht immer die aktuelle am Ende, deshalb
// das Array nicht mehr von oben nach unten,
// sondern jetzt von unten nach oben durchlaufen.
// **********************************************
//For i = 1 To Upperbound(sAllIP[])
For i = Upperbound(sAllIP[]) to 1 step -1
	// **********************************************
	//	wir checken, ob der Wert einer IP-Adresse ent-
	// spricht: Also xxx.xxx.xxx.xxx
	// Regul$$HEX1$$e400$$ENDHEX$$rer Ausdruck = [0-9]+\.[0-9]+\.[0-9]+\.[0-9]
	// **********************************************
	
	if Match(sAllIP[i], "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]") Then
		// **********************************************
		// der erste Treffer reicht	
		// **********************************************		
		sIP = sAllIP[i]
		exit
	end if
Next

if sIP = "0.0.0.0" Then
	return -1
end if 

Return 0

 




end function

public function integer localhostname (ref string hostname);// **********************************************
//
//		Function Integer LocalHostName(REF String Hostname)
//
//			Diese Funktion ermittelt den Hostnamen
//			der lokalen Maschine und gibt sie als
//			Referenz zur$$HEX1$$fc00$$ENDHEX$$ck
//
// **********************************************

String	 		ls_HostName
Long				ll_HostLen, ll_Ret


if not WSAStartUpFailed Then

	ls_HostName = Space (256)			// wie immer erst mal vorinitialisieren
	ll_HostLen	= Len(ls_HostName)	// die L$$HEX1$$e400$$ENDHEX$$nge
	
	
	// der eigentliche aufruf
	ll_Ret = GetHostName (ls_HostName, ll_HostLen)
	
	if ll_Ret <> 0 Then
		// Fehler 
		return -1
	end if
	
	// nun noch ein Trim auf die Variable
	// da diese ja mit 256 Spaces vorinitialisiert wurde
	HostName = trim(ls_HostName)

else
	
	return -1	
	
end if


Return 0

 




end function

on uo_winsock.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_winsock.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Long				ll_Ret 
wsadata  		wsInfo

// es mu$$HEX2$$df002000$$ENDHEX$$immer erst WSAStartup aufgerufen werden
// um die Verwendung der wsock32.dll zu initiallieren

ll_Ret = wsaStartup(257,wsInfo) // 257 ist binary high byte = 1 low byte = 1

if ll_Ret <> 0 Then		
	// Fehler 
	Messagebox ("Attention", "Winsock-Error")
	
	WSAStartUpFailed = True
  	
else
	
	WSAStartUpFailed = False
	
end if 
end event

event destructor;// wird die Verwendung der Winsock-Dll nicht mehr ben$$HEX1$$f600$$ENDHEX$$tigt,
// so mu$$HEX2$$df002000$$ENDHEX$$WSACleanUP() aufgerufen werden
// diese terminiert die Verwendung der DLL
// WICHTIG

WSACleanup()
end event

