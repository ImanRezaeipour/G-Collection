// ***************************************************************************
//DESCRIPTION:
//		This simple class provides SOME of the functionality of the 
//		MFC CAsyncSocket without using MFC. Most functions are mapped in the
//		same way to enable simple swaping.
//
//NOTE:
//		The events are monitored using another thread to all the On...
//		methods must be thread safe.
//
//		For instructions on how to use this see
//			www.mctainsh.com
//				Win32\Sockets (Non-MFC)
//
//REQUIREMENTS:
//		Include		#include <Winsock2.h>		// Socket support
//					#include <windows.h>		//Not necessary if using MFC
//					#include <TChar.h>			//..
//					#include <assert.h>			//..
//		Link with	Ws2_32.lib
//CREATED:
//		2-12-2000, 1:16:08 PM by john@mctainsh.com
// ***************************************************************************

#include "stdafx.h"
#include "WinSock2Async.h"							//Socket for Requesting data

#ifdef __AFX_H__
	#ifdef _DEBUG
		#define new DEBUG_NEW
		#undef THIS_FILE
		static char THIS_FILE[] = __FILE__;
	#endif
#else
	//Trun on and off the tracing display
	#define TRACE				printf
	#define	ASSERT				assert
#endif

//Local functions
DWORD WINAPI StartPlayingThread(LPVOID param);

// WSA Error code descriptions
static struct ErrorEntry 
{
	int nID;
	const char* pcMessage;
} g_aErrorList[] = 
	{
		{ 0,                     "No error" },
		{ WSAEINTR,              "Interrupted system call" },
		{ WSAEBADF,              "Bad file number" },
		{ WSAEACCES,             "Permission denied" },
		{ WSAEFAULT,             "Bad address" },
		{ WSAEINVAL,             "Invalid argument" },
		{ WSAEMFILE,             "Too many open sockets" },
		{ WSAEWOULDBLOCK,        "Operation would block" },
		{ WSAEINPROGRESS,        "Operation now in progress" },
		{ WSAEALREADY,           "Operation already in progress" },
		{ WSAENOTSOCK,           "Socket operation on non-socket" },
		{ WSAEDESTADDRREQ,       "Destination address required" },
		{ WSAEMSGSIZE,           "Message too long" },
		{ WSAEPROTOTYPE,         "Protocol wrong type for socket" },
		{ WSAENOPROTOOPT,        "Bad protocol option" },
		{ WSAEPROTONOSUPPORT,    "Protocol not supported" },
		{ WSAESOCKTNOSUPPORT,    "Socket type not supported" },
		{ WSAEOPNOTSUPP,         "Operation not supported on socket" },
		{ WSAEPFNOSUPPORT,       "Protocol family not supported" },
		{ WSAEAFNOSUPPORT,       "Address family not supported" },
		{ WSAEADDRINUSE,         "Address already in use" },
		{ WSAEADDRNOTAVAIL,      "Can't assign requested address" },
		{ WSAENETDOWN,           "Network is down" },
		{ WSAENETUNREACH,        "Network is unreachable" },
		{ WSAENETRESET,          "Net connection reset" },
		{ WSAECONNABORTED,       "Software caused connection abort" },
		{ WSAECONNRESET,         "Connection reset by peer" },
		{ WSAENOBUFS,            "No buffer space available" },
		{ WSAEISCONN,            "Socket is already connected" },
		{ WSAENOTCONN,           "Socket is not connected" },
		{ WSAESHUTDOWN,          "Can't send after socket shutdown" },
		{ WSAETOOMANYREFS,       "Too many references, can't splice" },
		{ WSAETIMEDOUT,          "Connection timed out" },
		{ WSAECONNREFUSED,       "Connection refused" },
		{ WSAELOOP,              "Too many levels of symbolic links" },
		{ WSAENAMETOOLONG,       "File name too long" },
		{ WSAEHOSTDOWN,          "Host is down" },
		{ WSAEHOSTUNREACH,       "No route to host" },
		{ WSAENOTEMPTY,          "Directory not empty" },
		{ WSAEPROCLIM,           "Too many processes" },
		{ WSAEUSERS,             "Too many users" },
		{ WSAEDQUOT,             "Disc quota exceeded" },
		{ WSAESTALE,             "Stale NFS file handle" },
		{ WSAEREMOTE,            "Too many levels of remote in path" },
		{ WSASYSNOTREADY,        "Network subsystem is unavailable" },
		{ WSAVERNOTSUPPORTED,    "Winsock version not supported" },
		{ WSANOTINITIALISED,     "Winsock not yet initialized" },
		{ WSAHOST_NOT_FOUND,     "Host not found" },
		{ WSATRY_AGAIN,          "Non-authoritative host not found" },
		{ WSANO_RECOVERY,        "Non-recoverable errors" },
		{ WSANO_DATA,            "Valid name, no data record of requested type" },
		{ WSAEDISCON,            "Graceful disconnect in progress" },
		{ WSASYSCALLFAILURE,     "System call failure" },
		{ WSA_NOT_ENOUGH_MEMORY, "Insufficient memory available" },
		{ WSA_OPERATION_ABORTED, "Overlapped operation aborted" },
		{ WSA_IO_INCOMPLETE,  	 "Overlapped I/O object not signalled" },
		{ WSA_IO_PENDING,        "Overlapped I/O will complete later" },
		//{ WSAINVALIDPROCTABLE,   "Invalid proc. table from service provider") },
		//{ WSAINVALIDPROVIDER,    "Invalid service provider version number") },
		//{ WSAPROVIDERFAILEDINIT, "Unable to init service provider") },
		{ WSA_INVALID_PARAMETER, "One or more parameters are invalid" },
		{ WSA_INVALID_HANDLE,    "Event object handle not valid" }
	};
const int NUM_WSERROR_MESSAGES = sizeof(g_aErrorList) / sizeof(ErrorEntry);


// **************************************************************************
//DESCRIPTION:
//		Construction/Destruction
//CREATED:
//		9-3-2000, 11:48:00 by John McTainsh
// ***************************************************************************
CWinSock2Async::CWinSock2Async() :
	m_Sd( INVALID_SOCKET ),
	m_WSAEvent( WSA_INVALID_EVENT ),
	m_ThreadState( eThreadNoStarted ),
	m_bConnected( false )
{
	//TRACE( "CWinSock2Async::CWinSock2Async()\n" );
	InitializeCriticalSection( &m_csRecieve );
	InitializeCriticalSection( &m_csSend );
}

CWinSock2Async::~CWinSock2Async()
{
	//TRACE( "CWinSock2Async::~CWinSock2Async()\n" );
	//Close();
	//DeleteCriticalSection( &m_csRecieve );
	//DeleteCriticalSection( &m_csSend );
}


// ***************************************************************************
//DESCRIPTION:
//		Initiates use of Ws2_32.dll by a process and verifys the current 
//		version.
//PARAMS:
//		lpwsaData	Pointer to a WSADATA structure or NULL to use
//					an internal one.
//RETURN:
//		See help on WSAStartup for most return codes
//CREATED:
//		26-11-2000, 20:28:45 by john@mctainsh.com
// ***************************************************************************
BOOL CWinSock2Async::SocketInit( WSADATA* lpwsaData )
{
	//TRACE( "CWinSock2Async::SocketInit( %p ) const\n", lpwsaData );
	//
	//Load the Required Version of the sockets DLL
	//
	WSADATA wsaData = { 0 };
	if( lpwsaData == NULL )
		lpwsaData = &wsaData;

	int nError = WSAStartup ( MAKEWORD( 2, 2 ), lpwsaData );
	if( nError )
		return nError;

	// Confirm that the WinSock DLL supports 2.2.
	// Note that if the DLL supports versions greater    
	// than 2.2 in addition to 2.2, it will still return 
	// 2.2 in wVersion since that is the version we      
	// requested.                                        
	if ( LOBYTE( wsaData.wVersion ) != 2 || HIBYTE( wsaData.wVersion ) != 2 ) 
	{
		nError = WSAVERNOTSUPPORTED;
	    // Tell the user that we could not find a usable 
		// WinSock DLL.                                  
	    WSACleanup( );
	}
	return nError; 
}



// **************************************************************************
//DESCRIPTION:
//		Try to setup the socket
//PARAMS:
//      nPort	If non zero, this will be the port listening will
//				occur on.
//RETURN:
//		True if a connection was made
//CREATED:
//		10-3-2000, 14:57:34 by John McTainsh
// ***************************************************************************
bool CWinSock2Async::Create( char* IP, int nPort)
{
	//TRACE( "CWinSock2Async::Create()\n");

	//
	// Create a stream socket
	//
	SOCKET sockNew = socket(AF_INET, SOCK_STREAM, 0);
	if( sockNew == INVALID_SOCKET ) 
		return false;

	//
	//Create the worker thread to monitor the Socket events
	//
	if( !SetupEvents( sockNew ) )
		return false;

	if( nPort == 0 )
		return true;
	//
	//Setup for listening if necessary
	//
	u_long nRemoteAddress = LookupAddress((LPCTSTR)IP);
	if (nRemoteAddress == INADDR_NONE) 
	{
		TCHAR szWASError[WSA_ERROR_LEN];
		WSAGetLastErrorMessage( szWASError );
		TRACE( "*** lookup address: %s\n", szWASError );
		return false;
	}
	in_addr Address;
	memcpy(&Address, &nRemoteAddress, sizeof(u_long)); 
	
	sockaddr_in sinRemote;
	sinRemote.sin_family = AF_INET;
	sinRemote.sin_addr.s_addr = nRemoteAddress;
	sinRemote.sin_port = htons((unsigned short)nPort);

	return(  bind( m_Sd, (sockaddr*)&sinRemote, sizeof(sockaddr_in) ) == 0 );
}


// **************************************************************************
//DESCRIPTION:
//		Try to make a connection to the Server
//PARAMS:
//		sAddress	Clear text name of server to connect to
//		nPort		Port to connect to
//RETURN:
//		True if a connection was made
//CREATED:
//		10-3-2000, 14:57:34 by John McTainsh
// ***************************************************************************
bool CWinSock2Async::Connect( LPCTSTR sAddress, int nPort )
{
	//TRACE( "CWinSock2Async::Connect( %s, %d )\n", sAddress, nPort );

	//
	//Resolve Address
	//
	u_long nRemoteAddress = LookupAddress(sAddress);
	if (nRemoteAddress == INADDR_NONE) 
	{
		TCHAR szWASError[WSA_ERROR_LEN];
		WSAGetLastErrorMessage( szWASError );
		TRACE( "*** lookup address: %s\n", szWASError );
		return false;
	}
	in_addr Address;
	memcpy(&Address, &nRemoteAddress, sizeof(u_long)); 
	//TRACE( "Connecting to %s : %d\n", inet_ntoa(Address), nPort );

	//
	//Connect
	//
	sockaddr_in sinRemote;
	sinRemote.sin_family = AF_INET;
	sinRemote.sin_addr.s_addr = nRemoteAddress;
	sinRemote.sin_port = htons((unsigned short)nPort);
	if( connect( m_Sd, (sockaddr*)&sinRemote, sizeof(sockaddr_in)) == SOCKET_ERROR ) 
	{
		if( WSAGetLastError() != WSAEWOULDBLOCK )
		{
			m_Sd = INVALID_SOCKET;
			TCHAR szWASError[WSA_ERROR_LEN];
			WSAGetLastErrorMessage( szWASError );
			TRACE( "ERROR : Connecting.: %s\n", szWASError );
			return false;
		}
	}
	return true;
}


// ***************************************************************************
//DESCRIPTION:
//      Places a socket a state where it is listening for an incoming 
//      connection.
//PARAMS:
//      nConnectionBacklog  Maximum length of the queue of pending connections. 
//                          If set to SOMAXCONN, the underlying service provider 
//                          will set the backlog to a maximum reasonable value.
//RETURN:
//      If no error occurs, returns zero. Otherwise, a value of SOCKET_ERROR 
//      is returned, and a specific error code can be retrieved by calling 
//      WSAGetLastError.
//CREATED:
//      1-12-2000, 6:56:01 PM by john@mctainsh.com
// ***************************************************************************
bool CWinSock2Async::Listen( int nConnectionBacklog )
{
    //TRACE( "CWinSock2Async::Listen( %d )\n", nConnectionBacklog );
    return( listen( m_Sd, nConnectionBacklog ) == 0 );
}


// ***************************************************************************
//DESCRIPTION:
//		Gracefully shuts the connection. 
//RETURN:
//		true if we're successful, false otherwise.
//CREATED:
//		26-11-2000, 18:24:37 by john@mctainsh.com
// ***************************************************************************
bool CWinSock2Async::ShutdownConnection()
{
	//TRACE( "CWinSock2Async::ShutdownConnection()\n");
	// Disallow any further data sends.  This will tell the other side
	// that we want to go away now.  If we skip this step, we don't
	// shut the connection down nicely.
	if( shutdown( m_Sd, SD_SEND ) == SOCKET_ERROR ) 
	{
		m_Sd = INVALID_SOCKET;
		return false;
	}

	// Receive any extra data still sitting on the socket.  After all
	// data is received, this call will block until the remote host
	// acknowledges the TCP control packet sent by the shutdown above.
	// Then we'll get a 0 back from recv, signalling that the remote
	// host has closed its side of the connection.
	char chBuff[WINSOCK_READ_BUFF_SIZE+1];
	int nNewBytes;
	do
	{
		nNewBytes = Recieve( chBuff, WINSOCK_READ_BUFF_SIZE );
		//TRACE( "FYI, received %d unexpected bytes during shutdown.\n", nNewBytes );
	} while( nNewBytes > 0 );

	// Close the socket if not SOCKET_ERROR
	if( /*nNewBytes == 0 &&*/ closesocket( m_Sd ) != SOCKET_ERROR )
	{
		m_Sd = INVALID_SOCKET;
		return true;
	}

	//Socket already dead
	m_Sd = INVALID_SOCKET;
	return false;
}


// ***************************************************************************
//DESCRIPTION:
//		Create the event annd event handler for the socket. This must only
//		be done once. This should only be called once.
//PARAMS:
//		New socket handle for this connection.
//RETURN:
//		True if events were sucessfully established.
//CREATED:
//		2-12-2000, 4:42:03 AM by john@mctainsh.com
// ***************************************************************************
bool CWinSock2Async::SetupEvents( SOCKET newSocket )
{
	//TRACE( "CWinSock2Async::SetupEvents()\n" );

	//Assign the new socket handle
	ASSERT( m_Sd == INVALID_SOCKET );
	m_Sd = newSocket;

	//Create the event
	ASSERT( m_WSAEvent == WSA_INVALID_EVENT );
	m_WSAEvent = WSACreateEvent();
	if( m_WSAEvent == WSA_INVALID_EVENT )
	{
		closesocket( m_Sd );
		m_Sd = INVALID_SOCKET;
		return false;
	}

	//Attach the event to the socket
	int nError = WSAEventSelect( m_Sd, m_WSAEvent, 
		FD_ACCEPT | FD_CONNECT| FD_READ | FD_WRITE | FD_CLOSE );
	if( nError )
	{
		WSACloseEvent( m_WSAEvent );
		m_WSAEvent = WSA_INVALID_EVENT;

		closesocket( m_Sd );
		m_Sd = INVALID_SOCKET;

		return false;
	}

	//Run the monitoting thread.
	DWORD dwThreadId;
	CreateThread(
			NULL,									// SD
			102400,									// initial stack size
			StartPlayingThread,						// thread function
			this,									// thread argument
			0,										// creation option
			&dwThreadId );							// thread identifier
	return true;
}


// ***************************************************************************
//DESCRIPTION:
//		Gets the address of the peer socket to which the socket is connected
//PARAMS:
//		See help on getpeername
//RETURN:
//		See help on getpeername
//CREATED:
//		26-11-2000, 19:19:04 by john@mctainsh.com
// ***************************************************************************
BOOL CWinSock2Async::GetPeerName( LPTSTR sAddress, int* const pnPort )
{
	//TRACE( "CWinSock2Async::GetPeerName()\n" );
	ASSERT( sAddress );
	ASSERT( pnPort );

	SOCKADDR SockAddr;
	int nSockAddrLen = sizeof( SockAddr );
	int nError = getpeername( m_Sd, &SockAddr, &nSockAddrLen );
	if( nError == 0 )
	{
		LPSOCKADDR_IN psi = (LPSOCKADDR_IN)&SockAddr;
		*pnPort = psi->sin_port;
		sprintf( (char*)sAddress,  "%d.%d.%d.%d", 
				psi->sin_addr.S_un.S_un_b.s_b1, 
				psi->sin_addr.S_un.S_un_b.s_b2,
				psi->sin_addr.S_un.S_un_b.s_b3,
				psi->sin_addr.S_un.S_un_b.s_b4 );

	}
	return nError;
}


// **************************************************************************
//DESCRIPTION:
//		Resolve the IP address
//PARAMS:
//		pcHost Name to resolve
//RETURN:
//		IP address in reveres order 10.1.1.23 = 0x1701010A
//CREATED:
//		10-3-2000, 14:08:41 by John McTainsh
// ***************************************************************************
u_long CWinSock2Async::LookupAddress( LPCTSTR szHost )
{
	//TRACE( "CWinSock2Async::LookupAddress(%s) const\n", szHost );
    u_long nRemoteAddr = inet_addr((const char*) szHost );
    if( nRemoteAddr == INADDR_NONE ) 
	{
        // pcHost isn't a dotted IP, so resolve it through DNS
		// WARNING : This takes time and so will stop processing!
        hostent* pHE = gethostbyname((const char*) szHost );
        if (pHE == 0) 
		{
            return INADDR_NONE;
        }
        nRemoteAddr = *((u_long*)pHE->h_addr_list[0]);
    }
    return nRemoteAddr;
}


// ***************************************************************************
//DESCRIPTION:
//		The functions reads the WSAGetLastError error code and then
//		tries to match it with a pre defined code and return a copy of that
//		string. The string recieving the error must be bigger than 50 chars.
//PARAMS:
//		sError	String to write error to. ( alteast WSA_ERROR_LEN)
//CREATED:
//		2-12-2000, 10:48:35 AM by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::WSAGetLastErrorMessage( LPTSTR sError )
{
	//TRACE( _T("CWinSock2Async::WSAGetLastErrorMessage()\n") );

	ASSERT( sError );
	int nLastError = WSAGetLastError();
	int i;
	for( i = 0; i < NUM_WSERROR_MESSAGES; ++i ) 
	{
		if (g_aErrorList[i].nID == nLastError) 
		{
			_tcsncpy( sError, (const wchar_t*) g_aErrorList[i].pcMessage, WSA_ERROR_LEN );
			sError[WSA_ERROR_LEN-1] = NULL;
			return;
		}
	}
	// Didn't find error in list, so make up a generic one
	_tcsncpy( sError, _T("unknown error"), WSA_ERROR_LEN );
	sError[WSA_ERROR_LEN-1] = NULL;
}



// ***************************************************************************
//DESCRIPTION:
//		Close should shut down everything about the socket connection
//		This will include the worker thread and events
//CREATED:
//		7-12-2000, 4:27:44 AM by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::Close()
{
	//Wait for worker thread to terminate (3 seconds max)
	if( m_ThreadState == eThreadRunning )
	{
		m_ThreadState = eThreadShuttingDown;
		WSASetEvent( m_WSAEvent );
		int nTrys = 3000;
		while( ( m_ThreadState != eThreadShutdown ) && ( nTrys-- ) )
		{
			Sleep( 1 );
		}
		nTrys++;
	}

	//Free event handler
	if( m_WSAEvent != WSA_INVALID_EVENT )
		WSACloseEvent( m_WSAEvent );

	//Close the conneciton
	ShutdownConnection();
}



// ***************************************************************************
//DESCRIPTION:
//		Called to determine how much data is waiting in the input que for
//		reading with Recieve.
//RETURN:
//		As above.
//CREATED:
//		26-11-2000, 16:46:43 by john@mctainsh.com
// ***************************************************************************
DWORD CWinSock2Async::RecievePendingSize()
{
	//TRACE( "CWinSock2Async::RecievePendingSize()\n" );
	EnterCriticalSection( &m_csRecieve );
	//Determine the amount of data available to read
	DWORD dwRecBufSize = 0;
	if( ioctlsocket( m_Sd, FIONREAD, &dwRecBufSize ) )
		dwRecBufSize = 0;
	LeaveCriticalSection( &m_csRecieve );
	return dwRecBufSize;
}



// ***************************************************************************
//DESCRIPTION:
//		Read a block of data from the input stream. This is a thread safe 
//		call. Call RecievePendingSize() before calling this to determine if any
//		data exists to read.
//PARAMS:
//		pchBuff		Pointer to a char buffer to write data into.
//		nBuffLen	Maximum number of bytes to recieve
//		nFlags		See help on recv
//RETURN:
//		If no error occurs, returns the number of bytes received. 
//		If the connection has been gracefully closed, the return value is zero. 
//		Otherwise, a value of SOCKET_ERROR is returned, and a specific error 
//		code can be retrieved by calling WSAGetLastError.
//CREATED:
//		26-11-2000, 16:27:55 by john@mctainsh.com
// ***************************************************************************
int CWinSock2Async::Recieve( char* pchBuff, int nBuffLen, int nFlags )
{
//	TRACE( _T("CWinSock2Async::Recieve(%p, %d, %d )\n"),  pchBuff, nBuffLen, nFlags );
	ASSERT( pchBuff );
	EnterCriticalSection( &m_csRecieve );
	int nNoRead = recv( m_Sd, pchBuff, nBuffLen, nFlags );
	LeaveCriticalSection( &m_csRecieve );
	return nNoRead;
}


// ***************************************************************************
//DESCRIPTION:
//		Used to write outgoing data on a connected socket. For 
//		message-oriented sockets, care must be taken not to exceed the maximum 
//		packet size of the underlying provider, which can be obtained by 
//		using getsockopt to retrieve the value of socket option 
//		SO_MAX_MSG_SIZE.
//WARNING:
//		The successful completion of a send does not indicate that the data 
//		was successfully delivered. 
//PARAMS:
//		pchBuff		Pointer to a char buffer to send data from.
//		nLen		Maximum number of bytes to send from the buffer.
//		nFlags		See help on send
//RETURN:
//		If no error occurs, returns the total number of bytes sent, which can 
//		be less than the number indicated by nLen for nonblocking sockets. 
//		Otherwise, a value of SOCKET_ERROR is returned, and a specific error 
//		code can be retrieved by calling WSAGetLastError.
//CREATED:
//		26-11-2000, 16:27:55 by john@mctainsh.com
// ***************************************************************************
int CWinSock2Async::Send( char* pchBuff, int nLen, int nFlags )
{
//	TRACE( _T("CWinSock2Async::Send( %p, %d, %d )\n"), pchBuff, nLen, nFlags );
	ASSERT( nLen > 0 );
	EnterCriticalSection( &m_csSend );
	int nNoSent = send( m_Sd, pchBuff, nLen, nFlags );
	LeaveCriticalSection( &m_csSend );
	return nNoSent;
}


// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
//		Operatons below this line are ONLY called from the worker thread.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************


// ***************************************************************************
//DESCRIPTION:
//		Recieved data event.
//		For FD_READ network event, network event recording and event object 
//		signaling are level-triggered. This means that if Recieve() routine
//		is called and data is still in the input buffer after the call, the 
//		FD_READ event is recorded and FD_READ event object is set. This allows 
//		an application to be event-driven and not be concerned with the amount 
//		of data that arrives at any one time
//		With these semantics, an application need not read all available data 
//PARAMS:
//		nError	Error code
//CREATED:
//		26-11-2000, 16:54:46 by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::OnRecieve( int nError )
{
	//TRACE( "CWinSock2Async::OnRecieve(%d)\n", nError );
//	char chBuff[WINSOCK_READ_BUFF_SIZE+1];
//	int nRead;
//	while( ( nRead = Recieve( chBuff, WINSOCK_READ_BUFF_SIZE ) ) > 0 );
//	{
//		chBuff[nRead] = NULL;
//		TRACE( _T("Recieved %d, {%s}"), nRead, chBuff );
//		//TODO : Process the read data.
//		//for example Echo below
//		Send( chBuff, nRead );
//	}
}




// ***************************************************************************
//DESCRIPTION:
//		An FD_WRITE network event is recorded when a socket is first connected 
//		with connect/WSAConnect or accepted with accept/WSAAccept, and then 
//		after a send fails with WSAEWOULDBLOCK and buffer space becomes 
//		available. Therefore, an application can assume that sends are 
//		possible starting from the first FD_WRITE network event setting and 
//		lasting until a send returns WSAEWOULDBLOCK. After such a failure the 
//		application will find out that sends are again possible when OnSend 
//		is fired.
//PARAMS:
//		nError	Error code
//CREATED:
//		26-11-2000, 19:46:38 by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::OnSend( int nError )
{
	//TRACE( "CWinSock2Async::OnSend(%d)\n", nError );
}



// ***************************************************************************
//DESCRIPTION:
//		Triggered when a connection failes a new connection is sucessful
//		that was blocked when  the connection was requested. If an error is
//		returned then it may be necessary to delete this object in the same
//		manner as when a connection  is closed from the other end.
//PARAMS:
//		nError	 Connection error code.
//CREATED:
//		2-12-2000, 5:09:00 AM by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::OnConnect( int nError )
{
	//TRACE( "CWinSock2Async::OnConnect(%d)\n", nError );
	m_bConnected = ( nError == 0 );
}


// ***************************************************************************
//DESCRIPTION:
//		Called by the framework to notify a listening socket that it can 
//		accept pending connection requests by calling the Accept member 
//		function.
//PARAMS:
//		The most recent error on a socket. The following error codes 
//		applies to the OnAccept member function: 
//			0			The function executed successfully.
//			WSAENETDOWN The Windows Sockets implementation detected 
//						that the network subsystem failed. 
//CREATED:
//		2-12-2000, 7:10:28 AM by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::OnAccept( int nError )
{
	//TRACE( "CWinSock2Async::OnAccept(%d)\n", nError );

	//Typical connection example (note this leaks)
//	CWinSock2Async *pSockNew = new CWinSock2Async();
//	if( Accept( pSockNew ) )
//	{
//		//TODO: Some error display
//	}
}


// ***************************************************************************
//DESCRIPTION:
//		Permits an incoming connection attempt on a socket. It is usually
//		called in connection with a OnAccept event.
//PARAMS:
//		pSockNew	New port to create connection to client on.
//		lpSockAddr	NULL or structure to copy connection data into.
//		pnLen		NULL or return size of the above structure.
//RETURN:
//		Nonzero if the function is successful; otherwise 0, and a specific 
//		error code can be retrieved by calling GetLastError.
//CREATED:
//		2-12-2000, 7:12:48 AM by john@mctainsh.com
// ***************************************************************************
bool CWinSock2Async::Accept( CWinSock2Async *pSockNew, sockaddr* lpSockAddr, int* pnLen )
{
	//TRACE( "CWinSock2Async::Accept( %p, %p, %p )\n", pSockNew, lpSockAddr, pnLen );
	SOCKET sockNew = accept( m_Sd, lpSockAddr, pnLen );

	if( sockNew == INVALID_SOCKET )
		return false;

	return pSockNew->SetupEvents( sockNew );
}

//void CWinSock2Async::Close( void)
//{
//	closesocket(m_Sd);
//}

// ***************************************************************************
//DESCRIPTION:
//		The FD_CLOSE network event is recorded when a close indication is 
//		received for the virtual circuit corresponding to the socket. In TCP 
//		terms, this means that the FD_CLOSE is recorded when the connection 
//		goes into the TIME WAIT or CLOSE WAIT states. This results from the 
//		remote end performing a shutdown on the send side or a closesocket. 
//		FD_CLOSE being posted after all data is read from a socket. An 
//		application should check for remaining data upon receipt of FD_CLOSE 
//		to avoid any possibility of losing data.
//PARAMS:
//		nError	Error code
//CREATED:
//		26-11-2000, 16:23:21 by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::OnClose( int nError )
{
	//TRACE( "CWinSock2Async::OnClose(%d)\n", nError );
	m_bConnected = false;
	//Check for any remaining data
//	char chBuff[WINSOCK_READ_BUFF_SIZE+1];
//	int nRead;
//	while( ( nRead = Recieve( chBuff, WINSOCK_READ_BUFF_SIZE ) ) > 0 )
//	{
//		//TODO : Process the read data.
//	}
}



// ***************************************************************************
//DESCRIPTION:
//		This is the section of code that is processed by the thread.
//		It MUST NOT be called from any location other than the thread.
//		It will run until the socket is closed.
//CREATED:
//		25-11-2000, 21:23:32 by john@mctainsh.com
// ***************************************************************************
void CWinSock2Async::ThreadRunner()
{
	//TRACE( "CWinSock2Async::ThreadRunner()\n" );
	m_ThreadState = eThreadRunning;
	while( m_ThreadState == eThreadRunning )
	{
        // Wait for an event (or a queued callback function) to wake 
        // us up.  This is an alertable wait state (fAlertable == TRUE). 
        WSAWaitForMultipleEvents(
				1, 
				&m_WSAEvent, 
				FALSE,        
				WSA_INFINITE, 
				TRUE );       

		WSANETWORKEVENTS NetEvents = { 0 };		//Event that occured
   
		// Find out what happened and act accordingly. 
		if( WSAEnumNetworkEvents( m_Sd, m_WSAEvent, &NetEvents) == SOCKET_ERROR ) 
		{ 
			TCHAR szWASError[WSA_ERROR_LEN];
			WSAGetLastErrorMessage( szWASError );
			TRACE( "*** ERROR : In Event Enum.: %s\n", szWASError );
			//TODO : Do something with this error type
		} 
		else 
		{
			//Process each bit in the input event
			if( NetEvents.lNetworkEvents & FD_ACCEPT )
				OnAccept( NetEvents.iErrorCode[FD_ACCEPT_BIT] );

			if( NetEvents.lNetworkEvents & FD_CONNECT )
				OnConnect( NetEvents.iErrorCode[FD_CONNECT_BIT] );

			if( NetEvents.lNetworkEvents & FD_READ )
				OnRecieve( NetEvents.iErrorCode[FD_READ_BIT] );

			if( NetEvents.lNetworkEvents & FD_WRITE )
				OnSend( NetEvents.iErrorCode[FD_WRITE_BIT] );

			if( NetEvents.lNetworkEvents & FD_CLOSE )
				OnClose( NetEvents.iErrorCode[FD_CLOSE_BIT] );

		}
	}
	m_ThreadState = eThreadShutdown;
}



// ***************************************************************************
//DESCRIPTION:
//		Function to launch the class Run method. It is in a seperate
//		thread but the same address space.
//PARAMS:
//		param	Pointer to CWinSock2Async object to run.
//RETURN:
//		Not used.
//CREATED:
//		25-11-2000, 23:03:21 by john@mctainsh.com
// ***************************************************************************
DWORD WINAPI StartPlayingThread(LPVOID param)
{
    //TRACE( "StartPlayingThread(%p)\n", param );
    CWinSock2Async* pWinSock = (CWinSock2Async*)param;
    ASSERT( pWinSock );
	pWinSock->ThreadRunner();
    return 392;
}
