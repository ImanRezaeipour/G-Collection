#include 	"GP8.H"
#include 	"HARDWARE.H"
#include 	"DIGITALDATA.H"
#include 	"LED.H"
#include        "BEEP.H"

GP8Packet GP8::send_packet;
GP8Packet GP8::receive_packet;	

BYTE  GP8::station_id;
MifareCommand  GP8::last_command;
DWORD GP8::last_card_id;

unsigned char GP8::last_received_byte;
bool GP8::analyze_permission;
unsigned int GP8::send_data_counter;

OS_TIMER GP8::timer_read_card;
OS_TIMER GP8::timer_rceive_analyze;
	
EventPointer GP8::ep_card_present = NULL;

EventPointer GP8::ep_send_complete;
EventPointer GP8::ep_receive_complete;
EventPointer GP8::ep_send_byte_complete;
EventPointer GP8::ep_receive_byte_complete;
EventPointer GP8::ep_frame_error;

bool GP8::enable = false;

GP8::GP8 ()
{

}

GP8::~GP8 ()
{
	
}

void  GP8::SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L)
{
	Hardware h;
  	
	disable_interrupts();
  	
  	h.UART2SetBaud(B);
  	h.UART2SetParity(P);
  	h.UART2SetLength(L);
  	h.UART2SetStop(S);
	
  	enable_interrupts();
}
/*
void GP8::Send (Buffer *P)
{
	send_packet.Clear();
	send_packet.Fill(P->GetStartAddress(), P->Size());
  	internal_send();	
}

void GP8::SendByte (BYTE B)
{
	send_packet.Clear();
	send_packet += B;
  	internal_send();	
}
	
Buffer GP8::GetReceivedData (void)
{
	return receive_packet;
}

int GP8::GetReceivedDataLength (void)
{
	return receive_packet.Size();
}
*/
DWORD GP8::GetLastCardID (void)
{
  	return last_card_id;
}
/*
BYTE GP8::GetLastReceivedByte (void)
{
  	return last_received_byte;
}
*/
void GP8::AnalyzePermission	(bool Permission)
{
  	analyze_permission = Permission;
}

void GP8::GP8CommandSelectCard (void)
{
  	send_command(MC_SelectCard);
}
/*
void GP8::MifareCommandResetModule (void)
{
  	send_command(MC_Reset);
}	
*/
void GP8::SetCardPresentEvent (EventPointer EP)
{
  	ep_card_present = EP;
}
/*
void GP8::SetSendCompleteEvent (EventPointer EP)
{
	ep_send_complete = EP;	
}

void GP8::SetReceiveCompleteEvent (EventPointer EP)
{
	ep_receive_complete = EP;
}

void GP8::SetSendByteCompleteEvent (EventPointer EP)
{
	ep_send_byte_complete = EP;
}

void GP8::SetReceiveByteCompleteEvent (EventPointer EP)
{
	ep_receive_byte_complete = EP;
}

void GP8::SetFrameErrorEvent (EventPointer EP)
{
	ep_frame_error = EP;	
}
*/
void GP8::DisableEvents (void)
{	
	ep_card_present = NULL;	
	
	ep_send_complete = NULL;
	ep_receive_complete = NULL;
	ep_send_byte_complete = NULL;
	ep_receive_byte_complete = NULL;
	ep_frame_error = NULL;
}

void GP8::initial_hardware (void)
{
	Hardware  h;

  	h.UART2SetInterrupt(send_receive_interrupt, 0x0e);

        h.UART2Init();
}

void GP8::initial_critical_resources (void)
{
	//
}

void GP8::initial_statuses (void)
{
	//	
}

void GP8::initial_members (void)
{	
	send_data_counter = 0;
	last_received_byte = 0;
	analyze_permission = false;

	enable = false;
  	
	last_command=MC_None;
	station_id=1;
	last_card_id = 0;		
}

void GP8::final_initialization (void)
{
	SetPort(B57600,None,One,B8);
	AnalyzePermission(true);
}	

void GP8::set_enable_flag (bool flag)
{
	enable = flag;
}

void GP8::disable_interrupts (void)
{
	Hardware h;
	h.UART2DisableInterrupt();  	
}

void GP8::enable_interrupts (void)
{
	Hardware h;
	h.UART2EnableInterrupt();   	
}

void GP8::create_critical_tasks (void)
{
	//	
}

void GP8::create_nonecritical_tasks (void)
{
	//
}

void GP8::create_timers (void)
{
	OS_CREATETIMER(&timer_read_card, timer_elapse_read_card, 200);
	OS_CREATETIMER(&timer_rceive_analyze, timer_elapse_receive_analyze, 200);	
}

void GP8::suspend_nonecritical_tasks (void)
{
	//
}

void GP8::resume_nonecritical_tasks (void)
{
	//
}

void GP8::start_timers (void)
{
	OS_StartTimer(&timer_read_card);	
	OS_StartTimer(&timer_rceive_analyze);	
}

void GP8::stop_timers (void)
{
	OS_StopTimer(&timer_read_card);	
	OS_StopTimer(&timer_rceive_analyze);	
}

void GP8::internal_send (void)
{
	Hardware h;

        send_data_counter = 0;
	//send_receive_interrupt();

        h.UART2SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;
}

void GP8::send_receive_interrupt (void)
{
        OS_EnterInterrupt();

        if (!enable)
        {
                OS_LeaveInterrupt();
     		return;
        }

 	LED l;
  	Hardware h;
  	BYTE status;
	
  	status = h.UART2CheckStatus();

   	if  (status == UART_RECV_RDA)
	{
		l.UART2LED_100ms();

		last_received_byte = h.UART2RecvByte();
		
		safe_call_handler(ep_receive_byte_complete);

		if (analyze_permission == true)
			receive_packet += last_received_byte;

                OS_LeaveInterrupt();
                return;
	}

	if  (status == UART_ERROR)
	{
		safe_call_handler(ep_frame_error);
		receive_packet.Clear();

                OS_LeaveInterrupt();
		return;
	}

 	// if  (status == UART_SEND_READY)
	if (send_data_counter == send_packet.Size())
	{
		safe_call_handler(ep_send_complete);

                OS_LeaveInterrupt();
		return;
	}
	
	h.UART2SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;

        OS_LeaveInterrupt();
}

void GP8::analyze_receive_packet (void)
{
	if (last_command == MC_SelectCard)
	{
		if (receive_packet[2] == 4)
		{
	  	DigitalData dg;
	  	
		dg.SetByte(0,receive_packet[6]);
	  	dg.SetByte(1,receive_packet[5]);
		dg.SetByte(2,receive_packet[4]);
		dg.SetByte(3,receive_packet[3]);
	
		last_card_id = dg.GetDword();

                Beep b;

                b.DoBeep(100);
	
		safe_call_handler(ep_card_present);
	  	}
	}

}

void GP8::send_command (MifareCommand Command)
{
  	send_command(Command,station_id);
}

void GP8::send_command (MifareCommand Command, BYTE StationID)
{

	last_command = Command;

	station_id = StationID;

	send_packet.Clear();

	send_packet.SetCommand(Command);
  	send_packet.SetStationID(StationID);

  	send_packet.Make();

  	//send();
	//use send body  becouse of avoiding declare send function as the static in the parrent class
	
	//send_data_counter = 0;
	//send_receive_interrupt();

        //internal_send();

        Hardware h;

        send_data_counter = 0;
	//send_receive_interrupt();

        h.UART2SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;
}

void GP8::timer_elapse_read_card (void)
{
	MifareCommandSelectCard();
	
	OS_RetriggerTimer(&timer_read_card);	
}

void GP8::timer_elapse_receive_analyze (void)
{
	static int received_buffer_length;

	received_buffer_length = receive_packet.Size();

	if (received_buffer_length !=0)
		if (received_buffer_length == receive_packet.Size())
		{
			if (analyze_permission == true)
          			if (receive_packet.IsValid())
            				analyze_receive_packet();
        		
			receive_packet.Clear();
			
			safe_call_handler(ep_receive_complete);
			
			received_buffer_length = 0 ;
		}
	
	OS_RetriggerTimer(&timer_rceive_analyze);	
}












	


