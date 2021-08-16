#include	"SETTING.H"
#include	"SOUND.H"
#include 	"MIFARE.H"
#include	"FINGER.H"
#include	"KEY.H"
#include	"DATETIME.H"
#include 	"FS.H"
#include 	"LED.H"
#include	"STATUS.H"
//#include	"LOG.H"
#include	"NETWORK.H"
#include	"UTILITY.H"
#include	"ALARM.H"


OS_STACKPTR int Setting::stack_save_settings[256];
OS_TASK Setting::tcb_save_settings;

OS_STACKPTR int Setting::stack_save_settings_for_comm[256];
OS_TASK Setting::tcb_save_settings_for_comm;

EventPointer Setting::ep_command_execute_success;
EventPointer Setting::ep_command_execute_fail;
EventPointer Setting::ep_command_execute_success_for_comm;
EventPointer Setting::ep_command_execute_fail_for_comm;

Settings Setting::set;

OS_CSEMA Setting::sema;

Setting::Setting ()
{

}

Setting::~Setting ()
{
	
}

void Setting::UploadEssentialSettings (void)
{
	FS_FILE   *fp;
	char path[40];
	LED l;
	//Coding c;
	//Buffer b(sizeof(Settings));
	
	//b.Clear();
	
	strcpy(path, "Settings");
	FS_MkDir(path);
	
	strcat(path, "\\Settings.INF");
		
	fp = FS_FOpen(path, "rb");
	
	if (fp)
	{
		l.FileLED_100ms();
		
		FS_Read(fp, &set, sizeof(Settings));
		
		restore_settings();

                FS_FClose(fp);
	}
	
	else
	{
		LoadFactorySettings();
	
		fp = FS_FOpen(path, "wb");
		
		StatusBar st;

		if (fp)
		{
			l.FileLED_100ms();
		
			FS_Write(fp, &set, sizeof(Settings)); 			

                        FS_FClose(fp);

			st.ShowMessageTemporarily("–ŒÌ—Â ›«Ì·  ‰ŸÌ„« ");
		}
		else
			st.ShowMessageTemporarily("«‘ò«· –ŒÌ—Â  ‰ŸÌ„« ");
	
                restore_settings();
        }
}	

void Setting::SaveSettings (void)
{
	if (is_task_running(&tcb_save_settings))
		return;
	
	OS_CREATETASK(&tcb_save_settings, "Save_Setting_Task", task_save_settings, TP_RealTimePeriority, stack_save_settings);		
}

void Setting::SaveSettingsforCOMMService (void)
{
	if (is_task_running(&tcb_save_settings_for_comm))
		return;
	
	OS_CREATETASK(&tcb_save_settings_for_comm, "Save_Setting_Task_COMM_Services", task_save_settings_for_comm, TP_RealTimePeriority, stack_save_settings_for_comm);		
}

void Setting::SetTime (RTCTime Time)
{
	Time.RTC_Mday = DateTime::Now().RTC_Mday;
	Time.RTC_Mon = DateTime::Now().RTC_Mon;
	Time.RTC_Year = DateTime::Now().RTC_Year;
	
	Time.RTC_Wday = DateTime::Now().RTC_Wday;
	Time.RTC_Yday = DateTime::Now().RTC_Yday;

	Hardware  h;
	
	h.RTCSetTime(Time);
}
	
void Setting::SetDate (RTCTime Date)
{
	Date.RTC_Sec = DateTime::Now().RTC_Sec;
	Date.RTC_Min = DateTime::Now().RTC_Min;
	Date.RTC_Hour = DateTime::Now().RTC_Hour;
	
	Date.RTC_Yday = DateTime::Now().RTC_Yday;
        //Date.RTC_Wday = DateTime::Now().RTC_Wday;
        
	Hardware  h;
	
	h.RTCSetTime(Date);
}

void Setting::SetFingerFreeScanActivity (Activity A)
{
	Finger f;

	/*if (A == A_Disable)
		f.FreeScanMode(Off);
	
	if (A == A_Enable)
		f.FreeScanMode(On);*/
	
	set.FingerFreeScanActivity = A;
}

void Setting::SetFingerActivity (Activity A)
{
	Finger f;

	if (A == A_Disable)
		f.Disable();
	
	if (A == A_Enable)
		f.Enable();
	
	set.FingerActivity = A;
}

void Setting::SetMifareActivity (Activity A)
{
	Mifare m;
	
	if (A == A_Disable)
		m.Disable();
	
	if (A == A_Enable)
		m.Enable();
	
	set.MifareActivity = A;
}

void Setting::SetKeyActivity (Activity A)
{
	Key k;
	
	if (A == A_Disable)
		k.Disable();
	
	if (A == A_Enable)
		k.Enable();	
	
	set.KeyActivity = A;
}

void Setting::SetSoundActivity (Activity A)
{
	//Sound s;

	//s.SetActivity(A);	
	
	//set.SoundActivity = A;
}

void Setting::SetFirstDailyAlarmActivity (Activity A)
{
	Alarm a;
	
	a.FirstDailyAlarmActivity (A);
	
	set.FirstDailyAlarmActivity = A;
}

void Setting::SetSecondDailyAlarmActivity (Activity A)
{
	Alarm a;
	
	a.SecondDailyAlarmActivity (A);
	
	set.SecondDailyAlarmActivity = A;
}

void Setting::SetSpecialAlarmActivity (Activity A)
{
	Alarm a;
	
	a.SpecialAlarmActivity (A);
	
	set.SpecialAlarmActivity = A;
}

void Setting::SetFirstDailyAlarm (RTCTime Time)
{
	Alarm a;

	a.SetFirstDailyAlarmTime(Time);
	
	set.FirstDailyAlarmTime = Time;
}

void Setting::SetSecondDailyAlarm (RTCTime Time)
{
	Alarm a;

	a.SetSecondDailyAlarmTime(Time);
	
	set.SecondDailyAlarmTime = Time;
}

void Setting::SetSpecialAlarm (RTCTime Time)
{
	Alarm a;

	a.SetSpecialAlarmTime(Time);
	
	set.SpecialAlarmTime = Time;
}

void Setting::SetFirstDailyAlarmMessage (string Message)
{
	Alarm a;
	
	a.SetFirstDailyAlarmMessage(Message);
	
	Utility::ToCharArray(Message, set.FirstAlarmMessage);
}

void Setting::SetSecondDailyAlarmMessage (string Message)
{
	Alarm a;
	
	a.SetSecondDailyAlarmMessage(Message);
	
	Utility::ToCharArray(Message, set.SecondAlarmMessage);
}

void Setting::SetSpecialAlarmMessage (string Message)
{
	Alarm a;
	
	a.SetSpecialAlarmMessage(Message);
	
	Utility::ToCharArray(Message, set.SpecialAlarmMessage);
}

void Setting::SetAlarmPeriod (int Second)
{
	Alarm a;
	
	a.SetAlarmPeriod(Second);
	
	set.AlarmPeriod = Second;
}	
	

void Setting::SetServerIP (DWORD IP)
{
	Network n;

	n.SetServerAddress(IP, set.ServerPort);
	
	set.ServerIP = IP;
}

void Setting::SetServerPort (DWORD Port)
{
	Network n;

	n.SetServerAddress(set.ServerIP, Port);
	
	set.ServerPort = Port;
}

void Setting::SetGatewaye (DWORD IP)
{
	Network n;

	n.SetLocalGateway(IP);
	
	set.Gateway = IP;
}
	
void Setting::SetDeviceIP (DWORD IP)
{
	Network n;

	n.SetLocalAddress(IP, set.DevicePort, set.Mask);
	
	set.DeviceIP = IP;
}

void Setting::SetDevicePort (DWORD Port)
{
	Network n;

	n.SetLocalAddress(set.DeviceIP, Port, set.Mask);
	
	set.DevicePort = Port;
}

void Setting::SetAddressMask (DWORD Mask)
{
       	Network n;

	n.SetLocalAddress(set.DeviceIP, set.DevicePort, Mask);
	
	set.Mask = Mask;
}

void Setting::SetDeviceID (DWORD ID)
{
	set.DeviceID = ID;
}

void Setting::SetDeviceName (string Name)
{
	//Utility::ToCharArray(Name, set.DeviceName);
}

void Setting::SetPassword (DWORD PW)
{
	set.Password = PW;
}	

void Setting::SetCollectionInfo (RTCTime LastCollectedRecordTimeDate, DWORD LastCollectedRecordFileIndex)
{
	set.LastCollectedRecordTD = LastCollectedRecordTimeDate;
	set.LastCollectedRecordIndex = LastCollectedRecordFileIndex;
}

void Setting::SetDeviceMode (PersonalIdentifyScenario DeviceMode)
{
	set.DeviceMode = DeviceMode;
}

void Setting::SetDevicePreCard (PreCard PC)
{
	set.DevicePreCard = PC;
}

Settings Setting::GetSettings (void)
{
	return set;
}

void Setting::SetCommandExecuteSuccessEvent (EventPointer EP)
{
	ep_command_execute_success = EP;	
}

void Setting::SetCommandExecuteFailEvent (EventPointer EP)
{
	ep_command_execute_fail = EP;
}


void Setting::SetCommandExecuteSuccessEventforCOMMService (EventPointer EP)
{
	ep_command_execute_success_for_comm = EP;	
}

void Setting::SetCommandExecuteFailEventforCOMMService (EventPointer EP)
{
	ep_command_execute_fail_for_comm = EP;
}

void Setting::DisableEvents (void)
{
	ep_command_execute_success = NULL;
	ep_command_execute_fail = NULL;
}	

void Setting::StopTimers (void)
{
	//
}

void Setting::initial_members (void)
{
	OS_CreateCSema (&sema,1);
}

void Setting::create_timers (void)
{
	//
}

void Setting::LoadFactorySettings (void)
{
	set.FingerFreeScanActivity = A_Enable;
	set.FingerActivity = A_Enable;
	set.MifareActivity = A_Enable;
	set.KeyActivity = A_Enable;
	set.SoundActivity = A_Disable;
	
	set.FirstDailyAlarmActivity = A_Disable;
	set.SecondDailyAlarmActivity = A_Disable;
	set.SpecialAlarmActivity = A_Disable;
	
	RTCTime t;
	
	t.RTC_Min = 0;
	t.RTC_Sec = 0;
	t.RTC_Mday = 1;
	t.RTC_Mon = 1;
	t.RTC_Year = 1500;
	t.RTC_Wday = 1;
	t.RTC_Yday = 1;
	
	t.RTC_Hour = 8;
	set.FirstDailyAlarmTime = t;
	
	t.RTC_Hour = 17;
	set.SecondDailyAlarmTime = t;
	
       	t.RTC_Hour = 0;
	set.SpecialAlarmTime = t;
	
	strcpy(set.FirstAlarmMessage, "“‰ê —Ê“«‰Â «Ê·");
	strcpy(set.SecondAlarmMessage, "“‰ê —Ê“«‰Â œÊ„");
	strcpy(set.SpecialAlarmMessage, "");
	
	set.AlarmPeriod = 30;	
	
	set.ServerIP = 0xc0a80a01; 	//192.168.10.1
	set.ServerPort = 5000;
	set.DeviceIP = 0xC0A80aC8; 	//192.168.10.200
	set.DevicePort = 5000;
        set.Mask = 0xFFFFFF00;
	//set.DeviceID = 1;
	set.Password = 9999;
	set.Gateway = 0;     //0
	//strcpy(set.DeviceName, "Ghadir Co. Device");

	//set.LastCollectedRecordTD = t;
	//set.LastCollectedRecordIndex = 0;

	set.DeviceMode = PIS_CardOrFinger;
	set.DevicePreCard = PC_NormalEnter;
}

void Setting::restore_settings (void)
{
	SetSoundActivity(set.SoundActivity);
	//SetMifareActivity(set.MifareActivity);
	//SetFingerActivity(set.FingerActivity);
	//SetKeyActivity(set.KeyActivity);

	SetServerIP(set.ServerIP);
	SetDeviceIP(set.DeviceIP);
        SetGatewaye(set.Gateway);
	//SetDeviceID(set.DeviceID);
	
	//SetDeviceName(set.DeviceName);
			
	SetFirstDailyAlarmActivity(set.FirstDailyAlarmActivity);
	SetSecondDailyAlarmActivity(set.SecondDailyAlarmActivity);
	SetSpecialAlarmActivity(set.SpecialAlarmActivity);
		
	SetFirstDailyAlarm(set.FirstDailyAlarmTime);
	SetSecondDailyAlarm(set.SecondDailyAlarmTime);
	SetSpecialAlarm(set.SpecialAlarmTime);	

	SetFirstDailyAlarmMessage(set.FirstAlarmMessage);
	SetSecondDailyAlarmMessage(set.SecondAlarmMessage);
	SetSpecialAlarmMessage(set.SpecialAlarmMessage);			
	
	SetAlarmPeriod(set.AlarmPeriod);	
}

void Setting::task_save_settings (void)
{
        OS_WaitCSema(&sema);

        OS_EnterRegion();
	
        LED  l;
	FS_FILE   *fp;
	char path[40];
	
	strcpy(path, "Settings");
	
	FS_MkDir(path);
	
	strcat(path, "\\Settings.INF");
	
	fp = FS_FOpen(path,"wb");

	if (fp)
	{
		l.FileLED_100ms();

		FS_Write(fp, &set, sizeof(Settings));

		FS_FClose(fp);
		
		safe_call_handler(ep_command_execute_success);
	}
	else
		safe_call_handler(ep_command_execute_fail);	

        OS_SignalCSema(&sema);

        OS_LeaveRegion();
	
	OS_Terminate(0);
}

void Setting::task_save_settings_for_comm (void)
{
	OS_WaitCSema(&sema);

        OS_EnterRegion();

        LED  l;
	FS_FILE   *fp;
	char path[40];
	 	
	strcpy(path, "Settings");
	
	FS_MkDir(path);
	
	strcat(path, "\\Settings.INF");
	
	fp = FS_FOpen(path,"wb");

	if (fp)
	{
		l.FileLED_100ms();

		FS_Write(fp, &set, sizeof(Settings));

		FS_FClose(fp);
		
		safe_call_handler(ep_command_execute_success_for_comm);
	}
	else
		safe_call_handler(ep_command_execute_fail_for_comm);	

        OS_SignalCSema(&sema);
	
	OS_LeaveRegion();

	OS_Terminate(0);
}
