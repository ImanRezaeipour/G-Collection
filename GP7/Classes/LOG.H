#ifndef 	__LOG__
#define 	__LOG__

#include 	"RTOS.H"
#include 	"STRING"
#include 	"BUFFER.H"
#include 	"DATETIME.H"
#include	"MRESOURCE.H"

class Log : public MiddlewareResource
{
public:
	Log();
	~Log();

	void Finger (DWORD ID);
	void Mifare (DWORD ID);

	//void Key (string Str);
	
	//void System (SystemEvent SE);
	
	//void LogCommunicationReceivedCommand ();


        void SaveSettings (Settings* S);

	void SetSaveSettingsSuccessEvent (EventPointer EP);
	void SetSaveSettingFailEvent (EventPointer EP);
	
	void SetSaveRecordSuccessEvent (EventPointer EP);
	void SetSaveRecordFailEvent (EventPointer EP);

private:
	void initial_members (void);	
	
	void disable_events (void);

	void create_timers (void);
	
	static void crate_appropriate_directory (char file_path[40]);

	static void get_appropriate_path (RTCTime time, char file_path[40]);
	
	static void task_log_mifare (void);
	static void task_log_finger (void);
	static void task_save_settings (void);
	
	static Settings set;
	static DWORD finger_id;
	static DWORD mifare_id;
	
	static OS_STACKPTR int stack_log_mifare[256];
	static OS_TASK tcb_log_mifare;
	static OS_STACKPTR int stack_log_finger[256];
	static OS_TASK tcb_log_finger;
	static OS_STACKPTR int stack_save_settings[256];
	static OS_TASK tcb_save_settings;
	
	static EventPointer ep_save_setting_success;
	static EventPointer ep_save_setting_fail;

	static EventPointer ep_save_record_success;
	static EventPointer ep_save_record_fail;
};
#endif
