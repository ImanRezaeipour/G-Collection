#include	"COMMUNICATION.H"

EventPointer Communication::ep_send_complete;
EventPointer Communication::ep_receive_complete;
EventPointer Communication::ep_valid_packet_received;
EventPointer Communication::ep_invalid_packet_received;
	
Buffer* Communication::send_buffer;
Buffer* Communication::receive_buffer;

Communication::Communication ()
{

}

Communication::~Communication ()
{

}

void Communication::ClearSendBuffer ()
{
	send_buffer->Clear();
}

void Communication::ClearReceiveBuffer ()
{
	receive_buffer->Clear();
}

void Communication::ClearBuffers ()
{
	ClearSendBuffer();
	ClearReceiveBuffer();
}


void Communication::Send (BYTE Data)
{
	send_buffer->Clear();
	(*send_buffer) += Data;
	internal_send();
}

void Communication::Send (string Data)
{
	send_buffer->Clear();
	(*send_buffer) += Data;
	internal_send();
}

void Communication::Send (BYTE* Data, int Length)
{
	send_buffer->Clear();
	send_buffer->Fill(Data,Length);
	internal_send();
}

void Communication::Send (Buffer* P)
{
	send_buffer->Fill(P->GetStartAddress(), P->Size());
  	internal_send();
}

int Communication::GetReceivedDataLength (void)
{	
	return receive_buffer->Size();
}

Buffer Communication::GetReceivedData (void)
{
	return *receive_buffer;
}

void Communication::SetSendCompleteEvent (EventPointer EP)
{
	ep_send_complete = EP;	
}

void Communication::SetReceiveCompleteEvent (EventPointer EP)
{
	ep_receive_complete = EP;
}

void Communication::SetValidPacketReceivedEvent (EventPointer EP)
{
	ep_valid_packet_received  = EP;
}

void Communication::SetInvalidPacketReceivedEvent (EventPointer EP)
{
	ep_invalid_packet_received = EP;	
}

void Communication::disable_events (void)
{
	ep_send_complete = NULL;
	ep_receive_complete = NULL;
	ep_valid_packet_received = NULL;
	ep_invalid_packet_received = NULL;
}



