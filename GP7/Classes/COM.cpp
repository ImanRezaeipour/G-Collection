#include 	"COM.H"
#include 	"HARDWARE.H"
#include 	"LED.H"
#include 	"LCD.H"
#include 	"BEEP.H"
#include  	"VIEW.H"
#include  	"STATUS.H"
#include        "Finger.h"
#include        "Communication.h"

CommunicationPacket COM::send_packet;
CommunicationPacket COM::receive_packet;	
Modem_State COM::Modem_Packet;
//OS_TASK COM::tcb_modem_task;
//OS_STACKPTR int COM::stack_modem_task[256];

unsigned char COM::last_received_byte;
bool COM::analyze_permission;
unsigned int COM::send_data_counter;

OS_TIMER COM::timer_rceive_analyze;
	
EventPointer COM::ep_send_complete;
EventPointer COM::ep_receive_complete;
EventPointer COM::ep_send_byte_complete;
EventPointer COM::ep_receive_byte_complete;
EventPointer COM::ep_frame_error;
EventPointer COM::ep_connect_Modem = NULL;
EventPointer COM::ep_disconnect_Modem = NULL;

EventPointer COM::ep_valid_comm_packet_received;
EventPointer COM::ep_invalid_comm_packet_received;	

bool COM::enable = false;

COM::COM()
{

}

COM::~COM()
{
	
}

void  COM::SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L)
{
	Hardware h;
  	
	disable_interrupts();
  	
  	h.UART1SetBaud(B);            //d.k
  	h.UART1SetParity(P);
  	h.UART1SetLength(L);
  	h.UART1SetStop(S);
	
  	enable_interrupts();
}

void COM::ClearSendBuffer ()
{
	send_packet.Clear();
}

void COM::ClearReceiveBuffer ()
{
	receive_packet.Clear();
}

void COM::ClearBuffers ()
{
	ClearSendBuffer();
	ClearReceiveBuffer();
}


void COM::Send (BYTE Data)
{
	send_packet.Clear();
	send_packet += Data;
	internal_send();
}

void COM::Send (string Data)
{
	send_packet.Clear();
	send_packet += Data;
	internal_send();
}

void COM::Send (BYTE* Data, int Length)
{
	send_packet.Clear();
	send_packet.Fill(Data,Length);
	internal_send();
}

void COM::Send (Buffer* P)
{
	send_packet.Clear();
	send_packet.Fill(P->GetStartAddress(), P->Size());
  	internal_send();
}

CommunicationPacket COM::GetReceivedData (void)
{
	return receive_packet;
}

int COM::GetReceivedDataLength (void)
{
	return receive_packet.Size();
}

BYTE COM::GetLastReceivedByte (void)
{
  	return last_received_byte;
}

void COM::AnalyzePermission	(bool Permission)
{
  	analyze_permission = Permission;
}

void COM::SetSendCompleteEvent (EventPointer EP)
{
	ep_send_complete = EP;	
}

void COM::SetReceiveCompleteEvent (EventPointer EP)
{
	ep_receive_complete = EP;
}

void COM::SetSendByteCompleteEvent (EventPointer EP)
{
	ep_send_byte_complete = EP;
}

void COM::SetReceiveByteCompleteEvent (EventPointer EP)
{
	ep_receive_byte_complete = EP;
}

void COM::SetFrameErrorEvent (EventPointer EP)
{
	ep_frame_error = EP;	
}

void COM::SetValidCOMMPacketReceivedEvent (EventPointer EP)
{
	ep_valid_comm_packet_received = EP;
}

void COM::SetInvalidCOMMPacketReceivedEvent (EventPointer EP)
{
	ep_invalid_comm_packet_received = EP;
}

void COM::DisableEvents (void)
{	
	ep_send_complete = NULL;
	ep_receive_complete = NULL;
	ep_send_byte_complete = NULL;
	ep_receive_byte_complete = NULL;
	ep_frame_error = NULL;
        ep_connect_Modem = NULL;
	ep_disconnect_Modem = NULL;
	
	ep_valid_comm_packet_received = NULL;
	ep_invalid_comm_packet_received = NULL;		
}

void COM::initial_hardware (void)
{
	Hardware  h;

        h.UART1Init();
        h.UART1SetInterrupt(send_receive_interrupt, 0x0d);
        Modem_Packet = MDM_None;           //d.k
}

void COM::initial_critical_resources (void)
{
	//
}

void COM::initial_statuses (void)
{
	//	
}

void COM::initial_members (void)
{	
	send_data_counter = 0;
	last_received_byte = 0;
	analyze_permission = false;

	enable = false;
}

void COM::final_initialization (void)
{
        Hardware  h;
        
	SetPort(B57600,None,One,B8);
	AnalyzePermission(true);
        h.ModemInitial();           //d.k
}	

void COM::set_enable_flag (bool flag)
{
	enable = flag;
}

void COM::disable_interrupts (void)
{
	Hardware h;
	h.UART1DisableInterrupt();      //d.k 	
}

void COM::enable_interrupts (void)
{
	Hardware h;
	h.UART1EnableInterrupt();       //d.k 	
}

void COM::create_critical_tasks (void)
{
	//	
}

void COM::create_nonecritical_tasks (void)
{
	//
}

void COM::create_timers (void)
{
	OS_CREATETIMER(&timer_rceive_analyze, timer_elapse_receive_analyze, 200);	
}

void COM::suspend_nonecritical_tasks (void)
{
	//
}

void COM::resume_nonecritical_tasks (void)
{
	//
}
	
void COM::start_timers (void)
{
	OS_StartTimer(&timer_rceive_analyze);	
}

void COM::stop_timers (void)
{
	OS_StopTimer(&timer_rceive_analyze);	
}

void COM::internal_send (void)
{
        Hardware h;

        send_data_counter = 0;
	//send_receive_interrupt();

        h.UART1SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;
}

void  COM::send_receive_interrupt (void)
{
  	OS_EnterInterrupt();
        static BYTE MDM_Status;
        
        LED l;
	Hardware h;
	BYTE status;
	
	status = h.UART1CheckStatus();

        if (!enable)
        {
                MDM_Status = U1MSR;
                MDM_Status = MDM_Status;
                OS_LeaveInterrupt();
    		return;
        }
        
  	if  (status == UART_RECV_RDA)
	{
		l.UART1LED_100ms();
		last_received_byte = h.UART1RecvByte();

                if (analyze_permission == true)
			receive_packet += last_received_byte;
                
		safe_call_handler(ep_receive_byte_complete);

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
        
        if  (status == UART_Modem)                            //d.k
  	{
		//safe_call_handler(ep_frame_error);
                
		receive_packet.Clear();
                
                //MDM_Status = U1MSR;
                
                //OS_CREATETASK_EX(&tcb_modem_task, "Is_Modem_Connect_Task", task_modem, TP_HighestPeriority, stack_modem_task,(void*) &MDM_Status);

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

	h.UART1SendByte(send_packet[send_data_counter]);
	safe_call_handler(ep_send_byte_complete);
	send_data_counter ++;

        OS_LeaveInterrupt();
}
/*
void COM::task_modem (void * state)
{
        LCD lcd(Farsi);
        StatusBar s;
	View  v;
        Hardware h;
        BYTE MDM_Status = *(BYTE*)state;
        
        OS_DI();
        if(MDM_Status & RI_STATE)
           {
              lcd.Clear();
              lcd.Write("œ— Õ«· « ’«· »Â „Êœ„ ...");
              unsigned long i=0;
                
             do{
	      MDM_Status = U1MSR;
              MDM_Status &= DCD_STATE;
              //OS_Delay(1);
              i++;
               }while(! MDM_Status & i < Fpclk); 
              if(MDM_Status)
               {
                 //connect
                 h.Com1Enable(FALSE);
                 safe_call_handler(ep_connect_Modem);
                }
               else
                {
                  //disconnet
                  h.Com1Enable(TRUE);
                 }
                v.Refresh();
	        s.Refresh();
             }
          else if(MDM_Status & DCD_STATE)
          {
             h.Com1Enable(TRUE);
             safe_call_handler(ep_disconnect_Modem);
                  //disconnect
          }
        OS_EI();
        OS_Terminate(0);
}*/

void COM::analyze_receive_packet (void)
{
	//
}

void COM::timer_elapse_receive_analyze (void)
{
  	//static  int received_buffer_length;

    	//received_buffer_length = receive_packet.Size();

    	if (receive_packet.Size() != 0)
                if(receive_packet.Size() < PacketSizeIdle)
                {
                        receive_packet.Clear();
                }
      		else if (receive_packet.GetDataLength() + PacketSizeIdle == receive_packet.Size())
      		{
			if (analyze_permission == true)
                        {
				//if (receive_packet.IsValid())
					//analyze_receive_packet();
			if(Modem_Packet == MDM_None)                          //d.k
                          safe_call_handler(ep_receive_complete);
                        else
                          Modem_Packet = MDM_Recived;
                        }
                        else
                          receive_packet.Clear();
			
			//received_buffer_length = 0 ;
		}
                else if(receive_packet.GetDataLength() + PacketSizeIdle < receive_packet.Size())
                {
                        receive_packet.Clear();
                }

	OS_RetriggerTimer(&timer_rceive_analyze);	
}

string COM::GetStrATcommand(Modem_ATcommand  AT_CMD)
{
         string AT_Str;
         
         switch(AT_CMD)
         {
         case AT_CMD_AT:
           AT_Str = "AT\r\n";
           break;
         case AT_CMD_F0:
           AT_Str = "AT&F0\r\n";
           break;
         case AT_CMD_Z0:
           AT_Str = "ATZ0\r\n";
           break;
         case AT_CMD_S0:
           AT_Str = "ATS0=1\r\n";
           break; 
         case AT_CMD_D0:
           AT_Str = "AT&D0\r\n";
           break;
         case AT_CMD_E0:
           AT_Str = "ATE0\r\n";
           break;
         case AT_CMD_W0:
           AT_Str = "AT&W0\r\n";
           break;
         case AT_CMD_L2:
           AT_Str = "ATL2\r\n";
           break;
         case AT_CMD_L3:
           AT_Str = "ATL3\r\n";
           break; 
         default:
           AT_Str = "AT\r\n";
           break;
         }
        return   AT_Str;  
}

void COM::SetConnectModemEvent (EventPointer EP)
{
	ep_connect_Modem = EP;
}

void COM::SetRemoveModemEvent (EventPointer EP)
{
	ep_disconnect_Modem = EP;
}
