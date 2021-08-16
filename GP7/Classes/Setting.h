#ifndef		__SETTING__
#define		__SETTING__

#include	"DATATYPE.H"
#include	"STRING"
#include	"MRESOURCE.H"
#include        "RTOS.H"

class Setting : public MiddlewareResource
{
public:
	Setting ();
	~Setting ();

	void UploadEssentialSettings (void);
	void SaveSettings (void);
       	void SaveSettingsforCOMMService (void);
	
	void SetTime (RTCTime Time);
	void SetDate (RTCTime Date);
	
	void SetFingerFreeScanActivity (Activity A);
	void SetFingerActivity (Activity A);
	void SetMifareActivity (Activity A);
	void SetKeyActivity (Activity A);
	void SetSoundActivity (Activity A);

	void SetFirstDailyAlarmActivity (Activity A);
	void SetSecondDailyAlarmActivity (Activity A);
	void SetSpecialAlarmActivity (Activity A);	
	
	void SetFirstDailyAlarm (RTCTime Time);	
	void SetSecondDailyAlarm (RTCTime Time);	
	void SetSpecialAlarm (RTCTime Time);

	void SetFirstDailyAlarmMessage (string Message);
	void SetSecondDailyAlarmMessage (string Message);
	void SetSpecialAlarmMessage (string Message);

	void SetAlarmPeriod (int Second);

	void SetServerIP (DWORD IP);
	void SetServerPort (DWORD Port);
	void SetDeviceIP (DWORD IP);
	void SetDevicePort (DWORD Port);
        void SetAddressMask (DWORD Mask);
        void SetGatewaye (DWORD IP);
	
	void SetDeviceID (DWORD ID);
	
	void SetDeviceName (string Name);

	void SetPassword (DWORD PW);

	void SetCollectionInfo (RTCTime LastCollectedRecordTimeDate, DWORD LastCollectedRecordFileIndex);
	
	void SetDeviceMode (PersonalIdentifyScenario DeviceMode);
	
	void SetDevicePreCard (PreCard PC);
	
	Settings GetSettings (void);
	
	void SetCommandExecuteSuccessEvent (EventPointer EP);
	void SetCommandExecuteFailEvent (EventPointer EP);
       	void SetCommandExecuteSuccessEventforCOMMService (EventPointer EP);
	void SetCommandExecuteFailEventforCOMMService (EventPointer EP);

	void DisableEvents (void);

	void LoadFactorySettings (void);
	
	void StopTimers (void);

private:
	void initial_members (void);	

	void create_timers (void);

	void prepare_for_execute_Setting (void);
	
	void download_essential_settings (void);
	
	void restore_settings (void);
	
	static void task_save_settings (void);
       	static void task_save_settings_for_comm (void);
	
	static OS_STACKPTR int stack_save_settings[256];
	static OS_TASK tcb_save_settings;
	
	static OS_STACKPTR int stack_save_settings_for_comm[256];
	static OS_TASK tcb_save_settings_for_comm;

	static EventPointer ep_command_execute_success;
	static EventPointer ep_command_execute_fail;
       	static EventPointer ep_command_execute_success_for_comm;
	static EventPointer ep_command_execute_fail_for_comm;

	static Settings set;
        static OS_CSEMA sema;
};
#endif