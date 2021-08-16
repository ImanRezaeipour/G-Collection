#ifndef		__COMMUNICATION__
#define		__COMMUNICATION__

#include 	"STRING"
#include 	"BUFFER.H"

class Communication
{
public:
	Communication ();
	~Communication ();
	
	void ClearSendBuffer();
	void ClearReceiveBuffer();
	void ClearBuffers();
	
	void Send (BYTE B);
	void Send (string S);
	void Send (BYTE* Data, int Length);
	void Send (Buffer* P);
	
	Buffer GetReceivedData (void);
	int GetReceivedDataLength (void);
	
	void SetSendCompleteEvent (EventPointer EP);
	void SetReceiveCompleteEvent (EventPointer EP);
	void SetValidPacketReceivedEvent (EventPointer EP);
	void SetInvalidPacketReceivedEvent (EventPointer EP);	

protected:
	virtual void internal_send (void) = 0;
	
	void disable_events (void);
	
	static EventPointer ep_send_complete;
	static EventPointer ep_receive_complete;
	static EventPointer ep_valid_packet_received;
	static EventPointer ep_invalid_packet_received;

	static Buffer* send_buffer;
	static Buffer* receive_buffer;
};
#endif
	

	
	
	
	