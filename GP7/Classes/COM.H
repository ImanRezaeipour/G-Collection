#ifndef 	__COM__
#define 	__COM__

#include 	"DATATYPE.H"
#include 	"DEVICE.H"
#include 	"RTOS.h"
#include	"BUFFER.H"
#include 	"COMMUNICATIONPACKET.H"

enum Modem_State
{
        MDM_None = 0,
        MDM_IS_Packet,
        MDM_Recived
};

enum Modem_ATcommand
{
        AT_CMD_AT,
        AT_CMD_F0,
        AT_CMD_Z0,
        AT_CMD_S0,
        AT_CMD_D0,
        AT_CMD_E0,
        AT_CMD_W0,
        AT_CMD_L2,
        AT_CMD_L3
};          

class COM : public Device
{
public:
	COM();
	~COM();
	
	void SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L);
	
	void ClearSendBuffer();
	void ClearReceiveBuffer();
	void ClearBuffers();

       	void Send (BYTE B);
	void Send (string S);
	void Send (BYTE* Data, int Length);
	void Send (Buffer* P);
	
	CommunicationPacket GetReceivedData (void);
	int GetReceivedDataLength (void);

	BYTE GetLastReceivedByte (void);

        void AnalyzePermission (bool Permission);

	void SetSendCompleteEvent (EventPointer EP);
	void SetReceiveCompleteEvent (EventPointer EP);
	void SetSendByteCompleteEvent (EventPointer EP);
	void SetReceiveByteCompleteEvent (EventPointer EP);
	void SetFrameErrorEvent (EventPointer EP);
	
	void SetValidCOMMPacketReceivedEvent (EventPointer EP);
	void SetInvalidCOMMPacketReceivedEvent (EventPointer EP);
	
	void DisableEvents (void);
        
        string GetStrATcommand(Modem_ATcommand  AT_CMD);
         
        static Modem_State Modem_Packet;
        static CommunicationPacket receive_packet;	
        
        void SetConnectModemEvent (EventPointer EP);
        void SetRemoveModemEvent (EventPointer EP);
        
        static unsigned char last_received_byte;
private:
        //static OS_TASK tcb_modem_task;
	//static OS_STACKPTR int stack_modem_task[256];	
        //static void task_modem(void * state);
  
	void initial_hardware (void);
	void initial_critical_resources (void);	
	void initial_statuses (void);	
	void initial_members (void);
	void final_initialization (void);	
	void set_enable_flag (bool flag);
	
	void disable_interrupts (void);  	
	void enable_interrupts (void);	
	
	void create_critical_tasks (void);	
	void create_nonecritical_tasks (void);	
	void create_timers (void);
	
	void suspend_nonecritical_tasks (void);
	void resume_nonecritical_tasks (void); 		
	
	void start_timers (void);
	void stop_timers (void);

	void internal_send (void);
        
	static void send_receive_interrupt (void);
	static void analyze_receive_packet (void);
	
	static void timer_elapse_receive_analyze (void);

	static CommunicationPacket send_packet;
	
	static bool analyze_permission;
	static unsigned int send_data_counter;
	
	static OS_TIMER timer_rceive_analyze;
	
	static EventPointer ep_send_complete;
	static EventPointer ep_receive_complete;
	static EventPointer ep_send_byte_complete;
	static EventPointer ep_receive_byte_complete;
	static EventPointer ep_frame_error;
        static EventPointer ep_connect_Modem;
	static EventPointer ep_disconnect_Modem;
	
	static EventPointer ep_valid_comm_packet_received;
	static EventPointer ep_invalid_comm_packet_received;	
	
	static bool enable;
};

#endif