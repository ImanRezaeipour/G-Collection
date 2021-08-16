#include 	"SHOWTIME.H"
#include 	"DATETIME.H"
#include 	"CONTROL.H"
#include 	"SOUND.H"
#include 	"LED.H"
#include 	"NOTIFY.H"
#include  	"STATUS.H"
#include  	"VIEW.H"

bool ShowTime::update_view_permission = true;
bool ShowTime::update_status_permission = true;
bool ShowTime::update_notify_permission = true;

bool ShowTime::play_sound_4_second_permission = false;	
bool ShowTime::play_sound_4_hour_permission = false;	

OS_STACKPTR int ShowTime::stack_showtime[300];
OS_TASK ShowTime::tcb_showtime;

ShowTime::ShowTime ()
{

}

ShowTime::~ShowTime ()
{

}

void ShowTime::Start (void)
{
	UpdateScreenPermission (true);
	
	OS_CREATETASK(&tcb_showtime, "ShowTime_Task", task_showtime, TP_RealTimePeriority, stack_showtime);
}

void ShowTime::UpdateScreenPermission (bool Permission)
{
	update_notify_permission = Permission;
	update_status_permission = Permission;
	update_view_permission = Permission;
}

void ShowTime::UpdateViewScopePermission (bool Permission)
{
	update_view_permission = Permission;
}

void ShowTime::UpdateNotifyScopePermission (bool Permission)
{
	update_notify_permission = Permission;
}

void ShowTime::UpdateStatusScopePermission (bool Permission)
{
	update_status_permission = Permission;
}

void ShowTime::PlaySound4Seond (bool Permission)
{
	play_sound_4_second_permission = Permission;	
}

void ShowTime::PlaySound4Hour (bool Permission)
{
	play_sound_4_hour_permission = Permission;
}

void ShowTime::task_showtime (void)
{
	int sec,min,hour;

	OS_Delay(5000);

	//Control c;
	//c.InitialDevices();

	LED l;
	NotifyBar n;
	StatusBar s;
	View  v;

	sec = DateTime::Now().RTC_Sec;
	min = DateTime::Now().RTC_Min;
	hour = DateTime::Now().RTC_Hour;

	v.Refresh();
	n.Refresh();
	s.Refresh();

	while(1)
	{
		OS_Delay(300);
		
		l.ToggleLiveLED();		
		
		if (sec != DateTime::Now().RTC_Sec)
		{
			if (update_notify_permission)
				n.Refresh();
			
			if (play_sound_4_second_permission)
			{
				Sound s;
				s.PlayDing();
			}

			sec = DateTime::Now().RTC_Sec;
		}

		if (min != DateTime::Now().RTC_Min)
		{
			if (play_sound_4_hour_permission)
				if (hour != DateTime::Now().RTC_Hour)
				{
					hour = DateTime::Now().RTC_Hour;
					
					Sound s;
					s.PlayDingDang();
				}
			
			if (update_view_permission)
				v.Refresh();
			
			if (update_status_permission)
				s.Refresh();
		}
			
		min = DateTime::Now().RTC_Min;
	}
}


