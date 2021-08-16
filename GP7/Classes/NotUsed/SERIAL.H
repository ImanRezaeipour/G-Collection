#ifndef		__SERIAL__
#define 	__SERIAL__

#include	"DATATYPE.H"
#include	"BUFFER.H"

class Serial 
{
public:
	Serial();
	~Serial();
	
	virtual void SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L) = 0;
	
	virtual void Send (Buffer *P) = 0;
	virtual void SendByte (BYTE B) = 0;
	
	virtual Buffer GetReceivedData (void) = 0;
	virtual int GetReceivedDataLength (void) = 0;
	
	virtual BYTE GetLastReceivedByte (void) = 0;

	virtual void AnalyzePermission (bool Permission) = 0;
	
	virtual void SetSendCompleteEvent (EventPointer EP) = 0;
	virtual void SetReceiveCompleteEvent (EventPointer EP) = 0;
	virtual void SetSendByteCompleteEvent (EventPointer EP) = 0;
	virtual void SetReceiveByteCompleteEvent (EventPointer EP) = 0;
	virtual void SetFrameErrorEvent (EventPointer EP) = 0;
 	

}; 
#endif