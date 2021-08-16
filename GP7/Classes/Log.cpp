#include 	"LOG.H"
#include 	"FS.H"
#include 	"UTILITY.H"
#include 	"LED.H"
#include  	"Notify.H"
#include	"CODING.H"
#include  	"NOTIFY.H"
#include	"DIGITALDATA.H"
	
Settings Log::set;
DWORD Log::finger_id;
DWORD Log::mifare_id;

OS_STACKPTR int Log::stack_log_mifare[256];
OS_TASK Log::tcb_log_mifare;
OS_STACKPTR int Log::stack_log_finger[256];
OS_TASK Log::tcb_log_finger;
OS_STACKPTR int Log::stack_save_settings[256];
OS_TASK Log::tcb_save_settings;

EventPointer Log::ep_save_setting_success;
EventPointer Log::ep_save_setting_fail;

EventPointer Log::ep_save_record_success;
EventPointer Log::ep_save_record_fail;


Log::Log ()
{

}

Log::~Log ()
{

}

void Log::Finger (DWORD ID)
{
	if (is_task_running(&tcb_log_finger))
		return;
	
	finger_id = ID;
	
	OS_CREATETASK(&tcb_log_finger, "Log_Finger_Task", task_log_finger, TP_HighestPeriority, stack_log_finger);		
}

void Log::Mifare (DWORD ID)
{
	if (is_task_running(&tcb_log_mifare))
		return;
	
	mifare_id = ID;
	
	OS_CREATETASK(&tcb_log_mifare, "Log_Mifare_Task", task_log_mifare, TP_HighestPeriority, stack_log_mifare);		
}

void Log::SaveSettings (Settings* S)
{
	if (is_task_running(&tcb_save_settings))
		return;
	
	set = *S;
	
	OS_CREATETASK(&tcb_save_settings, "Save_Setting_Task", task_save_settings, TP_HighestPeriority, stack_save_settings);		
}

void Log::SetSaveSettingsSuccessEvent (EventPointer EP)
{
	ep_save_setting_success = EP;		
}

void Log::SetSaveSettingFailEvent (EventPointer EP)
{
	ep_save_setting_fail = EP;	
}

void Log::SetSaveRecordSuccessEvent (EventPointer EP)
{
	ep_save_record_success = EP;	
}

void Log::SetSaveRecordFailEvent (EventPointer EP)
{
	ep_save_record_fail = EP;
}
	
void Log::initial_members (void)
{
	finger_id = 0;
	mifare_id = 0;
}

void Log::disable_events (void)
{
	ep_save_setting_success = NULL;
	ep_save_setting_fail = NULL;
}	

void Log::create_timers (void)
{
	//
}

void Log::crate_appropriate_directory (char file_path[40])
{
	char p[40];
	int ctr_main, ctr_sub;

	strcpy(p, "");
	
	ctr_sub = 0;
	
	for (ctr_main = 0; ctr_main<strlen(file_path); ctr_main++, ctr_sub++)
	{
		if (file_path[ctr_main] == '\\')
		{
			p[ctr_sub] = 0;
			FS_MkDir(p);
			strcat(p, "\\");
		}
		
		p[ctr_sub] = file_path[ctr_main];
	}
	
	p[ctr_sub] = 0;
	
	FS_MkDir(p);
}

void Log::get_appropriate_path (RTCTime time, char file_path[40])
{
	char temp[10];
	
	strcpy(temp, "");
	strcpy(file_path, "");
		
	Utility::ToString(time.RTC_Year, temp);
	strcat(file_path , temp);
	strcat(file_path , "\\");
	strcpy(temp , "");
	
	Utility::ToString(time.RTC_Mon, temp);
	strcat(file_path , temp);
	strcat(file_path , "\\");
	strcpy(temp , "");

	Utility::ToString(time.RTC_Mday, temp);
	strcat(file_path , temp);	
}

void Log::task_log_mifare (void)
{
	LED  l;
	FS_FILE   *fp;
	char path[40];
	Buffer b(10);
	RTCTime t;
	Coding c;	
	DigitalData d;	
 	
	OS_EnterRegion();
	
	t = DateTime::ConvertToShamsi(DateTime::Now());
	
	get_appropriate_path(t, path);
	
	crate_appropriate_directory(path);

	strcat(path, "\\Mifare.INF");
	
	fp = FS_FOpen(path,"ab");

	if (fp)
	{
		l.FileLED_100ms();

		b.Clear();
		d.SetDword (mifare_id);
		
		b += t.RTC_Hour;
		b += t.RTC_Min;
		b += t.RTC_Sec;
		
		b += d.GetByte(0);	
		b += d.GetByte(1);	
		b += d.GetByte(2);	
		b += d.GetByte(3);	
		
		c.DoCoding(&b);
		
		FS_Write(fp, b.GetStartAddress(), b.Size());		

		FS_FClose(fp);
		
		safe_call_handler(ep_save_record_success);
	}

	else
		safe_call_handler(ep_save_record_fail);

	OS_LeaveRegion();
	
	OS_Terminate(0);
}

void Log::task_log_finger (void)
{
	LED  l;
	FS_FILE   *fp;
	char path[40];
	Buffer b(10);
	RTCTime t;
	Coding c;	
	DigitalData d;	
 	
	OS_EnterRegion();
	
	t = DateTime::ConvertToShamsi(DateTime::Now());
	
	get_appropriate_path(t, path);
	
	crate_appropriate_directory(path);

	strcat(path, "\\Finger.INF");
	
	fp = FS_FOpen(path,"ab");

	if (fp)
	{
		l.FileLED_100ms();

		b.Clear();
		d.SetDword (finger_id);
		
		b += t.RTC_Hour;
		b += t.RTC_Min;
		b += t.RTC_Sec;
		
		b += d.GetByte(0);	
		b += d.GetByte(1);	
		b += d.GetByte(2);	
		b += d.GetByte(3);	
		
		c.DoCoding(&b);
		
		FS_Write(fp, b.GetStartAddress(), b.Size());		

		FS_FClose(fp);
		
		safe_call_handler(ep_save_record_success);
	}

	else
		safe_call_handler(ep_save_record_fail);
	
	OS_LeaveRegion();
	
	OS_Terminate(0);
}




