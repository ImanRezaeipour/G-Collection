#include 	"MIFARE.H"
#include 	"HARDWARE.H"
#include 	"DIGITALDATA.H"
#include 	"LED.H"
#include        "BEEP.H"


#ifdef Trace
int Mifare::t;
#endif
bool Mifare::blnGetSNMifare;

MifarePacket Mifare::send_packet;
MifarePacket Mifare::receive_packet;	

BYTE  Mifare::station_id;
MifareCommand  Mifare::last_command;
DWORD Mifare::last_card_id;

unsigned char Mifare::last_received_byte;
bool Mifare::analyze_permission;
unsigned int Mifare::send_data_counter;

OS_TIMER Mifare::timer_read_card;
OS_TIMER Mifare::timer_rceive_analyze;
	
EventPointer Mifare::ep_card_present = NULL;

EventPointer Mifare::ep_send_complete;
EventPointer Mifare::ep_receive_complete;
EventPointer Mifare::ep_send_byte_complete;
EventPointer Mifare::ep_receive_byte_complete;
EventPointer Mifare::ep_frame_error;

bool Mifare::enable = false;

Mifare::Mifare ()
{

}

Mifare::~Mifare ()
{
	
}

void  Mifare::SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L)
{
	Hardware h;
  	
	disable_interrupts();
  	
  	h.UART2SetBaud(B);
  	h.UART2SetParity(P);
  	h.UART2SetLength(L);
  	h.UART2SetStop(S);
	
  	enable_interrupts();
}

void Mifare::Send (Buffer *P)
{
	send_packet.Clear();
	send_packet.Fill(P->GetStartAddress(), P->Size());
  	internal_send();	
}

void Mifare::SendByte (BYTE B)
{
	send_packet.Clear();
	send_packet += B;
  	internal_send();	
}
	
Buffer Mifare::GetReceivedData (void)
{
	return receive_packet;
}

int Mifare::GetReceivedDataLength (void)
{
	return receive_packet.Size();
}

DWORD Mifare::GetLastCardID (void)
{
  	return last_card_id;
}

BYTE Mifare::GetLastReceivedByte (void)
{
  	return last_received_byte;
}

void Mifare::AnalyzePermission	(bool Permission)
{
  	analyze_permission = Permission;
}

void Mifare::MifareCommandRequestCard (void)
{
  	send_command(MC_ALLRequest);
}
 
void Mifare::MifareCommandGetSNCard (void)
{
  	send_command(MC_Anticollide);
}        

void Mifare::MifareCommandSelectCard (void)
{
  	send_command(MC_SelectCard);
}

void Mifare::GP8CommandSelectCard (void)
{
  //
}

void Mifare::MifareCommandResetModule (void)
{
  	send_command(MC_Reset);
}	

void Mifare::SetCardPresentEvent (EventPointer EP)
{
  	ep_card_present = EP;
}

void Mifare::SetSendCompleteEvent (EventPointer EP)
{
	ep_send_complete = EP;	
}

void Mifare::SetReceiveCompleteEvent (EventPointer EP)
{
	ep_receive_complete = EP;
}

void Mifare::SetSendByteCompleteEvent (EventPointer EP)
{
	ep_send_byte_complete = EP;
}

void Mifare::SetReceiveByteCompleteEvent (EventPointer EP)
{
	ep_receive_byte_complete = EP;
}

void Mifare::SetFrameErrorEvent (EventPointer EP)
{
	ep_frame_error = EP;	
}

void Mifare::DisableEvents (void)
{	
	ep_card_present = NULL;	
	
	ep_send_complete = NULL;
	ep_receive_complete = NULL;
	ep_send_byte_complete = NULL;
	ep_receive_byte_complete = NULL;
	ep_frame_error = NULL;
}

void Mifare::initial_hardware (void)
{
	Hardware  h;

  	h.UART2SetInterrupt(send_receive_interrupt, 0x0f);

        h.UART2Init();
}

void Mifare::initial_critical_resources (void)
{
	//
}

void Mifare::initial_statuses (void)
{
	//	
}

void Mifare::initial_members (void)
{	
	send_data_counter = 0;
	last_received_byte = 0;
	analyze_permission = false;

	enable = false;
  	
	last_command=MC_None;
	station_id=1;
	last_card_id = 0;		
}

void Mifare::final_initialization (void)
{
        if(TypeDevice.Mifare)                 //D.k
        { 
#ifdef REM130
        SetPort(B9600,None,One,B8);
#else          
         SetPort(B38400,None,One,B8); 
#endif         
	 AnalyzePermission(true);         
         Enable_GetSNMifare(false);
        }
        else if(TypeDevice.GP8)                 //D.k
        {
          SetPort(B9600,None,One,B8);
	  AnalyzePermission(true);
        }
}	

void Mifare::set_enable_flag (bool flag)
{
	enable = flag;
}

void Mifare::disable_interrupts (void)
{
	Hardware h;
	h.UART2DisableInterrupt();  	
}

void Mifare::enable_interrupts (void)
{
	Hardware h;
	h.UART2EnableInterrupt();   	
}

void Mifare::create_critical_tasks (void)
{
	//	
}

void Mifare::create_nonecritical_tasks (void)
{
	//
}

void Mifare::create_timers (void)
{
	OS_CREATETIMER(&timer_read_card, timer_elapse_read_card, 300);
	OS_CREATETIMER(&timer_rceive_analyze, timer_elapse_receive_analyze, 200);	
}

void Mifare::suspend_nonecritical_tasks (void)
{
	//
}

void Mifare::resume_nonecritical_tasks (void)
{
	//
}

void Mifare::start_timers (void)
{
	OS_StartTimer(&timer_read_card);	
	OS_StartTimer(&timer_rceive_analyze);	
}

void Mifare::stop_timers (void)
{
	OS_StopTimer(&timer_read_card);	
	OS_StopTimer(&timer_rceive_analyze);	
}

void Mifare::internal_send (void)
{
	Hardware h;

        send_data_counter = 0;
	//send_receive_interrupt();

        h.UART2SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;
}

void Mifare::send_receive_interrupt (void)
{
        OS_EnterInterrupt();

        
 	LED l;
  	Hardware h;
  	BYTE status;
	
  	status = h.UART2CheckStatus();
        
        if (!enable)
        {
                OS_LeaveInterrupt();
     		return;
        }
        

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

void Mifare::analyze_receive_packet (void)
{
      if(TypeDevice.Mifare)                 //D.k
       {
	if (last_command == MC_SelectCard)
	{
#ifdef Trace
          if(t == 0)
          {
            if (receive_packet[2] == 4)
            {
                DigitalData dg;
	  	
		dg.SetByte(0,receive_packet[6]);
	  	dg.SetByte(1,receive_packet[5]);
		dg.SetByte(2,receive_packet[4]);
		dg.SetByte(3,receive_packet[3]);
	
		last_card_id = dg.GetDword();                
	
		safe_call_handler(ep_card_present);
            }
          }
          else
          {
                 DigitalData dg;
	  	
		dg.SetByte(0,receive_packet[6]);
	  	dg.SetByte(1,receive_packet[5]);
		dg.SetByte(2,receive_packet[4]);
		dg.SetByte(3,receive_packet[3]);
	
		last_card_id = dg.GetDword();                
	
		safe_call_handler(ep_card_present);
          }
#else                
          
		if (receive_packet[2] == 4)
		{
	  	DigitalData dg;
	  	
		dg.SetByte(0,receive_packet[6]);
	  	dg.SetByte(1,receive_packet[5]);
		dg.SetByte(2,receive_packet[4]);
		dg.SetByte(3,receive_packet[3]);
	
		last_card_id = dg.GetDword();                
	
		safe_call_handler(ep_card_present);
	  	}
#endif        
	}
#ifdef REM130 
        else if(last_command == MC_ALLRequest)
        {
                 if(receive_packet[3] == 0)
                 {
                        receive_packet.Clear();
			safe_call_handler(ep_receive_complete);
                        Enable_GetSNMifare(true);
                        OS_RetriggerTimer(&timer_read_card);
                 }
                 //safe_call_handler(ep_card_present);
                   
        }
        else if(last_command == MC_Anticollide)
        {
               	if (receive_packet[2] == 5 && receive_packet[3] == 0)
		{
	  	DigitalData dg;
	  	
		dg.SetByte(0,receive_packet[7]);
	  	dg.SetByte(1,receive_packet[6]);
		dg.SetByte(2,receive_packet[5]);
		dg.SetByte(3,receive_packet[4]);
	
		last_card_id = dg.GetDword();                
	
		safe_call_handler(ep_card_present);
	  	}  
        }
#endif        
       }
      else if(TypeDevice.GP8)                 //D.k
       {
                BYTE sBuff[4]={0,0,0,0};
                
                sBuff[0] = receive_packet[10] | receive_packet[9] <<8;
                sBuff[1] = receive_packet[8] | receive_packet[7] <<8;
                sBuff[2] = receive_packet[6] | receive_packet[5] <<8;
                sBuff[3] = receive_packet[4] | receive_packet[3] <<8;
                DigitalData dg;
		dg.SetByte(0,sBuff[0]);
	  	dg.SetByte(1,sBuff[1]);
		dg.SetByte(2,sBuff[2]);
		dg.SetByte(3,sBuff[3]);
	
		last_card_id = dg.GetDword();

                Beep b;

                b.DoBeep(100);
	
		safe_call_handler(ep_card_present);
       }

}

void Mifare::Enable_GetSNMifare(bool bln)
{
        Mifare::blnGetSNMifare = bln; 
}

void Mifare::send_command (MifareCommand Command)
{
  	send_command(Command,station_id);
}

void Mifare::send_command (MifareCommand Command, BYTE StationID)
{

	last_command = Command;

	station_id = StationID;

	send_packet.Clear();

	send_packet.SetCommand(Command);
#ifdef REM130 
        send_packet.SetStationID(0);
        if(last_command == MC_ALLRequest)
           send_packet.SetParam(0x52);
        else
          send_packet.SetParam(0x93);
#else        
  	send_packet.SetStationID(StationID);
#endif
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

void Mifare::timer_elapse_read_card (void)
{
  if(TypeDevice.Mifare)
#ifdef REM130
  {
    if(Mifare::blnGetSNMifare)
    {
        Enable_GetSNMifare(false);
        MifareCommandGetSNCard();
    }
    else
        MifareCommandRequestCard();
  }
#else
        MifareCommandSelectCard();
#endif        
  else if(TypeDevice.GP8)
        GP8CommandSelectCard();
	
	OS_RetriggerTimer(&timer_read_card);	
}

void Mifare::timer_elapse_receive_analyze (void)
{
	static int received_buffer_length;
     
	received_buffer_length = receive_packet.Size();            
        
	if (received_buffer_length !=0)
		if (received_buffer_length == receive_packet.Size())
		{
			if (analyze_permission == true)
          			if (receive_packet.IsValid())
#ifdef Trace
                                {
 if( t < Trace )
 {
  analyze_receive_packet();
  safe_call_handler(ep_receive_complete);
  if (receive_packet[2] != 4)
  {
  receive_packet.Clear();
  safe_call_handler(ep_receive_complete);
  received_buffer_length = 0 ;
  }
 }
 else
 {
  t= 0; 
  receive_packet.Clear();
  safe_call_handler(ep_receive_complete);
  received_buffer_length = 0 ;
 }
                                }
                                else
                                {
                        receive_packet.Clear();
			
			safe_call_handler(ep_receive_complete);
			
			received_buffer_length = 0 ;
                                }
#else                                    
            		analyze_receive_packet();
			receive_packet.Clear();
			
			safe_call_handler(ep_receive_complete);
			
			received_buffer_length = 0 ;
#endif                        
		}
        
	OS_RetriggerTimer(&timer_rceive_analyze);	
}












	


