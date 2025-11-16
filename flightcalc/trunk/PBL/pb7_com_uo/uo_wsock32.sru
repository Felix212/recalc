HA$PBExportHeader$uo_wsock32.sru
forward
global type uo_wsock32 from nonvisualobject
end type
end forward

global type uo_wsock32 from nonvisualobject
end type
global uo_wsock32 uo_wsock32

type prototypes
Function uint accept (uint s,str_sockaddr addr, ref int addrlen)  Library "wsock32.dll" alias for "accept;Ansi"
Function integer bind (uint s, str_sockaddr name, int namelen)  Library "wsock32.dll" alias for "bind;Ansi"  
Function integer closesocket (uint socket) Library "wsock32.dll"  
Function integer getsockname (uint s,ref str_sockaddr name, ref int  namelen) Library "wsock32.dll" alias for "getsockname;Ansi"  
Function integer getsockopt (uint socket, int level, int optname,str_linger optval, int optlen) Library "wsock32.dll" alias for "getsockopt;Ansi"  
Function integer htons (int hostshort) Library "wsock32.dll"  
Function integer ntohs (int netshort) Library "wsock32.dll"  
Function integer listen (uint s, int backlog) Library "wsock32.dll"  
Function integer shutdown (uint s, int how) Library "wsock32.dll"  
Function integer send (int socket, ref blob buf, int len, int flags) Library "wsock32.dll"  
Function integer setsockopt (uint socket, int level, int optname,str_linger optval, int optlen) Library "wsock32.dll" alias for "setsockopt;Ansi"  
Function uint socket (int af, int ttype, int protocol) Library "wsock32.dll"  
Function integer recv (int socket, ref blob buf, int len, int flags) Library "wsock32.dll"  
Function integer wsconnect (uint socket, str_sockaddr name, int namelen) Library "wsock32.dll" alias for "connect;Ansi"
Function integer WSACleanup ()  Library "wsock32.dll"  
Function integer WSAAsyncSelect (uint socket, uint Wnd, uint wMsg, long lEvent) Library "wsock32.dll"  
Function integer WSACancelBlockingCall () Library "wsock32.dll"  
Function integer WSAGetLastError () Library "wsock32.dll"  
Function integer WSAStartup (uint wVersionRequested, ref str_wsadata lpWSAData) Library "wsock32.dll" alias for "WSAStartup;Ansi"  
Function uint gethostname (ref String szHost, long dwHostLen) Library "wsock32.dll" alias for "gethostname;Ansi"  
Function ulong gethostbyname (String szHost) Library "wsock32.dll" alias for "gethostbyname;Ansi"  

Subroutine CopyMemoryIP (ref str_hostent  Destination , ulong Source, long Length) Library  "KERNEL32.DLL" Alias for "RtlMoveMemory;Ansi"
Subroutine CopyMemoryIP (ref blob Destination , ulong Source, long Length) Library  "KERNEL32.DLL" Alias for RtlMoveMemory
Subroutine CopyMemoryIP (ref character Destination[4] , ulong Source, long Length) Library  "KERNEL32.DLL" Alias for "RtlMoveMemory;Ansi"
Subroutine CopyMemoryIP (ref ulong Destination , ulong Source, long Length) Library  "KERNEL32.DLL" Alias for RtlMoveMemory
Function ulong LocalFree(ulong MemHandle) library "kernel32"
Function ulong LocalFree(ref str_hostent MemHandle) library "kernel32" alias for "LocalFree;Ansi"


end prototypes

type variables
public constant int MAXGETSOCKADDRSTRUCT = 16
public constant int WM_USER = 1024
public constant int FD_READ = 1
public constant int FD_OOB = 4
public constant int FD_ACCEPT = 8
public constant int FD_CONNECT = 16
public constant int FD_CLOSE = 32
public constant int SOCK_ERROR = -1
public constant int AF_INET = 2		// For UDP, TCP etc
public constant int AF_IPX = 6		// For IPX/SX
public constant int SOCK_STREAM = 1 /* stream socket */
public constant int SOCK_DGRAM = 2  /* datagram socket */
public constant int SOCK_RAW = 3    /* raw-protocol interface */
public constant int SOCK_RDM = 4    /* reliably-delivered message */
public constant int SOCK_SEQPACKET = 5 /* sequenced packet stream */


str_wsadata	i_WSAData
boolean ib_initialized



end variables

forward prototypes
public function integer uf_geterror ()
public subroutine uf_closesocket (integer asocket)
public function string uf_getipfromblob (blob lb_hostaddress)
public function integer uf_senddata (unsignedinteger asocket, blob ab_data)
public function blob uf_getrequestdata (integer asocket)
public function string uf_getwinsockversion ()
public function integer uf_startup (string ahostname, unsignedinteger aport, unsignedlong ahandle, integer aevent)
public function integer uf_initialize ()
public function integer uf_connect (string ahostname, integer aport)
public function string uf_gethostname ()
public function integer uf_accept (integer asocket, ref str_sockaddr aclient)
public function string uf_getip ()
end prototypes

public function integer uf_geterror ();
return WSAGetLastError()
end function

public subroutine uf_closesocket (integer asocket);
if ib_initialized then
	closesocket(asocket)
end if

end subroutine

public function string uf_getipfromblob (blob lb_hostaddress);string ls_IpAddress
/* Convert the pointers to scalars, and concatenate them to one string, the IP-address */
		ls_IpAddress = string(asc(string(blobmid(lb_HostAddress,1,1)))) + "."
		ls_IpAddress += string(asc(string(blobmid(lb_HostAddress,2,1)))) + "."
		ls_IpAddress += string(asc(string(blobmid(lb_HostAddress,3,1)))) + "."
		ls_IpAddress += string(asc(string(blobmid(lb_HostAddress,4,1))))

return ls_IpAddress
end function

public function integer uf_senddata (unsignedinteger asocket, blob ab_data);boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if
int retval
if not lb_error then
//	blob lb_data
//	lb_data = blob(as_data)
	retval = send(asocket,ab_data,Len(ab_data),0)
	if retval = SOCK_ERROR then
		lb_error = true
	else
		return retval
	end if
	
end if

If lb_error then
	messagebox("uf_senddata",uf_geterror())
	return SOCK_ERROR
end if

end function

public function blob uf_getrequestdata (integer asocket);
boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if

if not lb_error then
	blob{2048} lb_request
	if recv(asocket,lb_request,2048,0) = SOCK_ERROR then
		lb_error = true
	else
		return lb_request
	end if
	
end if

If lb_error then
	messagebox("uf_getrequestdata",uf_geterror())
	return blob(string(SOCK_ERROR))
end if

end function

public function string uf_getwinsockversion ();
/* the wsadata structure contains several information. 
	The description element tells us the winsock version */
	
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		return string(SOCK_ERROR)
	end if
end if
return i_WSAData.description
end function

public function integer uf_startup (string ahostname, unsignedinteger aport, unsignedlong ahandle, integer aevent);
boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if

if not lb_error then
	ulong			ll_hostip, ll_dwIpAddr
	blob{4} 		lb_hostaddress 
	uint			sock
	str_hostent l_hostip
	str_sockaddr l_sockaddr
	
	/* With the hostname, call the DLL wsock32 function gethostbyname which
	returns a structure containing the Host IP Data (hostent struct) */
	
	ll_hostip = gethostbyname(aHostName)
	
	/* Unfortunatley gethostbyname returns pointer to memory 
		call Copy Memory to move the contents of the address to our Structure */
	/* Note: CopyMemory is a psedoname for a function called RtlMoveMemory defined
		in Kernel32.dll */
	//u_test.CopyMemoryIp(l_hostip,ll_hostip,u_test.MAXGETHOSTSTRUCT)
	CopyMemoryIp(l_hostip,ll_hostip,MAXGETSOCKADDRSTRUCT)

	/* The h_Addr_List member of hostent contains a pointer to pointer for
		IP Address string. */
	ll_dwIpAddr = 0
	CopyMemoryIp(ll_dwIpAddr,l_hostip.h_Addr_List,l_hostip.h_Length)
	CopyMemoryIp(l_sockaddr.sin_addr,ll_dwIpAddr,l_hostip.h_Length)
	lb_hostaddress = l_sockaddr.sin_addr

	l_sockaddr.sin_family = AF_INET
	//Convert from Windows integer to Internet integer
	l_sockaddr.sin_port = htons(aport)
	
	//Lets create a socket
	sock = socket(AF_INET,1,0)

	//ok now bind the socket to our host
	if bind(sock,l_sockaddr,MAXGETSOCKADDRSTRUCT) = -1 then
		lb_error = true
	else
		//Note: WSAAsyncSelect helps to process the requests ansynchronously
		WSAASyncSelect(sock,ahandle,WM_USER + aevent,FD_ACCEPT)
		//Inform windows that you intend to listen on the socket
		if listen(sock,10) = -1 then
			lb_error = true
		end if
		return sock
	end if
end if

If lb_error then
	messagebox("uf_startup",uf_geterror())
	return SOCK_ERROR
end if	
end function

public function integer uf_initialize ();
if not ib_initialized then
	int			li_version
	//Initialize Winsock Version variables
	li_Version = 257
	//Initialize Winsock Library...WSAStartup needs to be called first time
	IF wsastartup ( li_version, i_WSAData ) = 0 THEN
		ib_initialized = true
		return 0
	End if
	return SOCK_ERROR
end if
return 0
end function

public function integer uf_connect (string ahostname, integer aport);
boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if

if not lb_error then
	ulong			ll_hostip, ll_dwIpAddr
	blob{4} 		lb_hostaddress 
	uint			sock
	str_hostent l_hostip
	str_sockaddr l_sockaddr
	
	/* With the hostname, call the DLL wsock32 function gethostbyname which
	returns a structure containing the Host IP Data (hostent struct) */
	
	ll_hostip = gethostbyname(aHostName)
	
	
	/* Unfortunatley gethostbyname returns pointer to memory 
		call Copy Memory to move the contents of the address to our Structure */
	/* Note: CopyMemory is a psedoname for a function called RtlMoveMemory defined
		in Kernel32.dll */
	//u_test.CopyMemoryIp(l_hostip,ll_hostip,u_test.MAXGETHOSTSTRUCT)
	CopyMemoryIp(l_hostip,ll_hostip,MAXGETSOCKADDRSTRUCT)

	/* The h_Addr_List member of hostent contains a pointer to pointer for
		IP Address string. */
	ll_dwIpAddr = 0
	CopyMemoryIp(ll_dwIpAddr,l_hostip.h_Addr_List,l_hostip.h_Length)
	CopyMemoryIp(l_sockaddr.sin_addr,ll_dwIpAddr,l_hostip.h_Length)
	lb_hostaddress = l_sockaddr.sin_addr

	l_sockaddr.sin_family = AF_INET
	//Convert from Windows integer to Internet integer
	l_sockaddr.sin_port = htons(aport)
	
	//Lets create a socket
	sock = socket(AF_INET,1,0)

	//ok now bind the socket to our host
	if wsconnect(sock,l_sockaddr,MAXGETSOCKADDRSTRUCT) = -1 then
		lb_error = true
	else
		return sock
	end if
end if

If lb_error then
	messagebox("uf_startup",uf_geterror())
	return SOCK_ERROR
end if	
end function

public function string uf_gethostname ();
boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if

if not lb_error then
	string ls_Hostname
	//initialize the hostname variable
	ls_Hostname = space(128)

	/* Now, let's find out what the hostname is of the current machine 
		we're working on */
	IF gethostname ( ls_HostName, len(ls_HostName) ) < 0 THEN
			/* Oops an Error occured. Get ErrorText from the Winsock Library */
			lb_error = true
	ELSE
		return ls_HostName
	End if
end if

If lb_error then
	return ""
end if
end function

public function integer uf_accept (integer asocket, ref str_sockaddr aclient);boolean lb_error
lb_error = false
if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if


if not lb_error then
	str_sockaddr 	l_clientaddr
	blob{2048} 		lb_request
	uint				clientsock
	int				li_clientlen

	// Lets listen for client requests
	li_clientlen = MAXGETSOCKADDRSTRUCT
	clientsock = accept(asocket,aclient,li_clientlen)
	if clientsock = 0 then

		lb_error = true
	else
		return clientsock
	end if
end if	

If lb_error then
	messagebox("uf_accept",uf_geterror())
	return SOCK_ERROR
end if
end function

public function string uf_getip ();boolean lb_error
String	sIP
String	sHostName

lb_error = false

if not ib_initialized then
	if uf_initialize() = SOCK_ERROR then
		lb_error = true
	end if
end if

if not lb_error then
	ulong			ll_hostip, ll_dwIpAddr
	blob{4} 		lb_hostaddress 
	uint			sock
	str_hostent l_hostip
	str_sockaddr l_sockaddr
	
	/* With the hostname, call the DLL wsock32 function gethostbyname which
	returns a structure containing the Host IP Data (hostent struct) */
	sHostName = uf_gethostname()	
	ll_hostip = gethostbyname(sHostName)
	
	/* Unfortunatley gethostbyname returns pointer to memory 
		call Copy Memory to move the contents of the address to our Structure */
	/* Note: CopyMemory is a psedoname for a function called RtlMoveMemory defined
		in Kernel32.dll */
	//u_test.CopyMemoryIp(l_hostip,ll_hostip,u_test.MAXGETHOSTSTRUCT)
	CopyMemoryIp(l_hostip,ll_hostip,MAXGETSOCKADDRSTRUCT)

	/* The h_Addr_List member of hostent contains a pointer to pointer for
		IP Address string. */
	ll_dwIpAddr = 0
	CopyMemoryIp(ll_dwIpAddr,l_hostip.h_Addr_List,l_hostip.h_Length)
	CopyMemoryIp(l_sockaddr.sin_addr,ll_dwIpAddr,l_hostip.h_Length)
	lb_hostaddress = l_sockaddr.sin_addr

	// DB 18.02.2008: convert blob to string ip address
	// sIP = uf_getipfromblob(lb_hostaddress)
	sIP  = String(AscA(String(BlobMid(lb_hostaddress,1,1),EncodingAnsi!)),"##0") + "."
	sIP += String(AscA(String(BlobMid(lb_hostaddress,2,1),EncodingAnsi!)),"##0") + "."
	sIP += String(AscA(String(BlobMid(lb_hostaddress,3,1),EncodingAnsi!)),"##0") + "."
	sIP += String(AscA(String(BlobMid(lb_hostaddress,4,1),EncodingAnsi!)),"##0")

end if

If lb_error then
	return "0.0.0.1"
end if	

return sIP
end function

on uo_wsock32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_wsock32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
if ib_initialized then
	WSACleanup()
end if

end event

event constructor;
ib_initialized = false
end event

