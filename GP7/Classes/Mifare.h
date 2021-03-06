#ifndef 	__MIFARE__
#define 	__MIFARE__

//#define   Trace  10000

#include 	"DATATYPE.H"
#include 	"MIFAREPACKET.H"
#include 	"RTOS.h"
#include 	"DEVICE.H"

class Mifare : public Device
{
public:
	Mifare ();
	~Mifare ();

	void SetPort (Baudrate B, Parity P, StopBits S, UART_Character_Length L);
	
	void Send (Buffer *P);
	void SendByte (BYTE B);
	
	Buffer GetReceivedData (void);
	int GetReceivedDataLength (void);

	static void MifareCommandSelectCard (void);
        static void GP8CommandSelectCard (void);
	void MifareCommandResetModule (void);
        
        static void MifareCommandRequestCard (void);
        static void MifareCommandGetSNCard (void);
        static void Enable_GetSNMifare(bool bln);
        static bool blnGetSNMifare;

	DWORD GetLastCardID (void);
	
	BYTE GetLastReceivedByte (void);

        void AnalyzePermission (bool Permission);

	void SetCardPresentEvent (EventPointer EP);
	
	void SetSendCompleteEvent (EventPointer EP);
	void SetReceiveCompleteEvent (EventPointer EP);
	void SetSendByteCompleteEvent (EventPointer EP);
	void SetReceiveByteCompleteEvent (EventPointer EP);
	void SetFrameErrorEvent (EventPointer EP);
	
	void DisableEvents (void);
        
#ifdef Trace
static int t;
#endif

private:
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

	static void internal_send (void);
        
	static void send_receive_interrupt(void);
	static void analyze_receive_packet (void);
        
        static void send_receive_interruptEx(void);

	static void send_command(MifareCommand Command);
	static void send_command(MifareCommand Command, BYTE StationID);

	static void timer_elapse_read_card (void);
	static void timer_elapse_receive_analyze (void);
	
	static MifarePacket send_packet;
	static MifarePacket receive_packet;	
	
       	static unsigned char last_received_byte;
	static bool analyze_permission;
	static unsigned int send_data_counter;

	static DWORD last_card_id;
	static BYTE  station_id;
	static MifareCommand  last_command;

	static OS_TIMER timer_read_card;
	static OS_TIMER timer_rceive_analyze;
	
	static EventPointer ep_card_present;

	static EventPointer ep_send_complete;
	static EventPointer ep_receive_complete;
	static EventPointer ep_send_byte_complete;
	static EventPointer ep_receive_byte_complete;
	static EventPointer ep_frame_error;
	
	static bool enable;
};
#endif