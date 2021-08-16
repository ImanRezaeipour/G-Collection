#include        "DATATYPE.H"
#include        "COMMUNICATIONPACKET.H"

class Communication
{
public:
        Communication ();
        ~Communication ();

        void Initial (void);

        void SetActivity (Activity A);

        static OS_CSEMA sema;
        static void command_execute_successfully (void);
        
        static ConnectionType communication_type;
        
        void  SendPersonRecordWithNumofFinger(DWORD num);
        void  SendBuffTemplateFinger(BYTE* buff);
private:
        static void send_Acknowledge_success (void);
        static void receive_byte_complete_com(void);
        
        static void send_Serial_Number_IC(void);
        static void lan_packet_is_available (void);
        static void com_packet_is_available (void);

        static void handle_received_packet (void);

        static void command_execute_fail (void);
        
        static void send_command_With_ErrFlag (COMMFlag flg);

        static void EnablePeripheral();
        static void DisablePeripheral();
        
        static void send_busy_packet (void);
        static void send_time_out_packet (void);
        static void send_packet_error (void);

        static void collection_end_detection (void);
        static void send_records (void);
        static void send_records (COMMFlag flag);
        static void send_records (COMMFlag flag, bool LastRecord);
        static void error_detect_on_collection (void);
        static void send_simple_command_execute_success (void);
        static void send_simple_command_execute_fail (void);

        static void send_to_media (void);

       	static bool is_file_exist (char file_path[], char file_name[]);
	static DWORD get_records_count (char file_path[], char file_name[], int record_length);
	static SearchHit search (char file_path[], char file_name[], DWORD desire_data, int record_length);

        static void timer_elapse_time_out (void);

        static void task_fill_packet_with_records (void* OperationMode);
        
        static void command_ETX_fail();
        static void command_ETX_finger_exist_fail(void);

        static CommunicationPacket send_packet;
        static CommunicationPacket receive_packet;

        static OS_TIMER time_out;

       	static OS_STACKPTR int stack_fill[384];
  	static OS_TASK tcb_fill;

        static DWORD record_index;
        static DWORD from_dt, to_dt;
        
        static RTCTime from, to;

        static bool is_busy;
        static Activity activity;
        static char KindCode;                 //kkk
        static DWORD FINGERID,indexTemplate;
        static BYTE BUFF[408];
};


