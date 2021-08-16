#ifndef 	__FINGER__
#define 	__FINGER__

#include 	"DATATYPE.H"
#include 	"FINGERPACKET.H"
#include 	"RTOS.H"
#include	"DEVICE.H"

class Finger : public Device
{
public:
	Finger ();
	~Finger ();

	void SetPort(Baudrate B, Parity P, StopBits S, UART_Character_Length L);

	void Send (Buffer *P);
        void Send (BYTE* st, int len);
	void SendByte (BYTE B);
	
	Buffer GetReceivedData (void);
	int GetReceivedDataLength (void);
	
	void ResetModule (void);
        static void CancelCommand (void);
	
	static void FreeScanMode (Power P);
	
	void EnrollByScan (void);
		
	void AddTemplate (DWORD UserID);
        void AddTemplateRepet (DWORD UserID);
        
        void EnrollByTemplete(DWORD UserID);                //Transmit
	
	void VerifyByScan (DWORD UserID);
	void IdentifyByScan (void);
	
	void DeleteByScan (void);
	void DeleteTemplates (DWORD UserID);
	void DeleteAllTemplates (void);

	BYTE GetLastReceivedByte (void);

        static void AnalyzePermission (bool Permission);

	void SetEnrollSuccessEvent (void (*EP)(DWORD));
	void SetIdentifySuccessEvent (void (*EP)(DWORD));

	void SetFreeScanChangeSuccessEvent (EventPointer EP);
	void SetFreeScanChangeFailEvent (EventPointer EP);
	void SetFreeScanSaveSuccessEvent (EventPointer EP);
	void SetFreeScanSaveFailEvent (EventPointer EP);

	void SetFirstTemplateScanSuccessEvent (EventPointer EP);
	void SetEnrollFailEvent (EventPointer EP);	
	
	void SetVerifySuccessEvent (EventPointer EP);	
	void SetVerifyFailEvent (EventPointer EP);	
        
        void SetETXSuccessEvent (EventPointer EP);	
	void SetETXfailEvent (EventPointer EP);
        void SetETXFingerExistEvent(EventPointer EP);
	
	void SetIdentifyFailEvent (EventPointer EP);	
	
	void SetDeleteByScanSuccessEvent (EventPointer EP);	
	void SetDeleteByScanFailEvent (EventPointer EP);		
	void SetDeleteTemplateSuccessEvent (EventPointer EP);	
	void SetDeleteTemplateFailEvent (EventPointer EP);		
	void SetDeleteAllTemplateSuccessEvent (EventPointer EP);	
	void SetDeleteAllTemplateFailEvent (EventPointer EP);		

	void SetSendCompleteEvent (EventPointer EP);
	void SetReceiveCompleteEvent (EventPointer EP);
	void SetSendByteCompleteEvent (EventPointer EP);
	void SetReceiveByteCompleteEvent (EventPointer EP);
	void SetFrameErrorEvent (EventPointer EP);
        
        void SetCancelSuccessEvent (EventPointer EP);
        void SetErrRecieveFinger (EventPointer EP);
        
        void SetEnrollRepetitiveEvent (EventPointer EP);

	void DisableEvents (void);

        void start_timeout (void);
	void stop_timeout (void);
        static bool is_Busy;
        
        static unsigned char last_received_byte;
        
        //void SendWithoutPacket (BYTE* st, int len);
        void SendByteWithoutPack (BYTE B);
        
        BYTE* GetFingerPrint(DWORD PN);                     //Transmit
        void startEnrollTemplate (DWORD UserID);
        void AppendFingerTemplate(BYTE* Template, WORD Size);
        void SendEnrollFinger(void);
        bool SetFingerPrint(BYTE* Templete, DWORD PN);     
        bool IS_TemplateFingerPacket();
        void GetNumOfTemplate(DWORD ID);
        void GetTemplate(DWORD ID,WORD SubIndex);
        void Set_TemplateFingerPacket(bool);                //Transmit
        
private:
        
        static void SendFingerTemplate(void);       //Transmit
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
        
        static void receive_byte_complete_finger(void);

	static void internal_send (void);
        static void internal_send_Template (void);

	static void send_receive_interrupt(void);
	static void analyze_receive_packet (void);

	static void send_command (void);
	static void send_command (BYTE Command);
	static void send_command (BYTE Command, DWORD Parameter);
	static void send_command (BYTE Command, DWORD Parameter, BYTE Flag);
	static void send_command (BYTE Command, DWORD Parameter, DWORD Size, BYTE Flag);

	static void timer_elapse_receive_analyze (void);
        static void timer_elapse_timout(void);

	void  save_parameter(void);
	void  write_parameter(BYTE id, BYTE value);
	//void  read_parameter(BYTE id);
                       
        static void AutoScanOffOn_Start (void);        //D.K

	static FingerPacket send_packet;
	static FingerPacket receive_packet;	
	
	static bool analyze_permission;
	static unsigned int send_data_counter;

	static BYTE  received_command;
	static BYTE  received_flag;
	static DWORD received_parameter;
	
	//static OS_TIMER timer_rceive_analyze;	
        static OS_TIMER timer_timout;

	static void (*ep_enroll_success) (DWORD UserID);
	static void (*ep_identify_success) (DWORD UserID);
	
	static EventPointer ep_free_scan_change_success;
	static EventPointer ep_free_scan_change_fail;
	static EventPointer ep_free_scan_save_success;
	static EventPointer ep_free_scan_save_fail;
	
	static EventPointer ep_first_template_scan_success;
	static EventPointer ep_enroll_fail;
        
        static EventPointer finger_is_repetitive;
	
	static EventPointer ep_verify_success;
	static EventPointer ep_verify_fail;
        
        static EventPointer ep_ETX_success;
	static EventPointer ep_ETX_fail;
        static EventPointer ep_ETX_Finger_Exist;
        
        static EventPointer ep_RTX_success;
	static EventPointer ep_RTX_fail;
	
	static EventPointer ep_identify_fail;
	
	static EventPointer ep_delete_by_scan_success;
	static EventPointer ep_delete_by_scan_fail;
	static EventPointer ep_delete_template_success;
	static EventPointer ep_delete_template_fail;
	static EventPointer ep_delete_all_template_success;
	static EventPointer ep_delete_all_template_fail;	
	
	static EventPointer ep_send_complete;
	static EventPointer ep_receive_complete;
	static EventPointer ep_send_byte_complete;
	static EventPointer ep_receive_byte_complete;
	static EventPointer ep_frame_error;
        
        static EventPointer ep_cancel_success;
        static EventPointer ep_Err_Recieve_Finger;
	
	static bool enable;
        
        static void task_AutoScanOffOn (void);
        //static OS_STACKPTR int stack_AutoScanOffOn[128];         //D.K
	//static OS_TASK tcb_AutoScanOffOn;
        
        static int  IndexPack;
        static BYTE BuffPack[408];
        static WORD NumPack;
        static WORD Finger_ID;
        static bool SendTemplate,RecieveTemplate;
        static bool Data_Ok;
};
#endif