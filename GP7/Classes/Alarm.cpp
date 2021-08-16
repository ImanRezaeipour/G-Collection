#include 	"ALARM.H"
#include	"STATUS.H"
#include	"DATETIME.H"
#include	"SOUND.H"

int Alarm::plaing_counter = 0;
int Alarm::instant_plaing_counter = 0;

bool Alarm::is_plaing = 0;

Activity Alarm::first_daily_alarm_activity;
Activity Alarm::second_daily_alarm_activity;
Activity Alarm::special_alarm_activity;

RTCTime Alarm::first_daily_alarm_time;
RTCTime Alarm::second_daily_alarm_time;
RTCTime Alarm::special_alarm_time;
	
string Alarm::first_daily_alarm_message;
string Alarm::second_daily_alarm_message;
string Alarm::special_alarm_message;
	
OS_TIMER Alarm::timer_alarm;
OS_TIMER Alarm::timer_alarm_instant_plaing;

Alarm::Alarm ()
{

}

Alarm::~Alarm ()
{

}

void Alarm::SetFirstDailyAlarmTime (RTCTime Time)
{
	first_daily_alarm_time = Time;	
}

void Alarm::SetSecondDailyAlarmTime (RTCTime Time)
{
	second_daily_alarm_time = Time;
}

void Alarm::SetSpecialAlarmTime (RTCTime Time)
{
	special_alarm_time = Time;
}

void Alarm::SetFirstDailyAlarmMessage (string Message)
{
	first_daily_alarm_message = Message;
}
	
void Alarm::SetSecondDailyAlarmMessage (string Message)
{
	second_daily_alarm_message = Message;
}

void Alarm::SetSpecialAlarmMessage (string Message)
{
	special_alarm_message = Message;
}	

void Alarm::FirstDailyAlarmActivity (Activity A)
{
	first_daily_alarm_activity = A;	
}
		
void Alarm::SecondDailyAlarmActivity (Activity A)
{
	second_daily_alarm_activity = A;	
}

void Alarm::SpecialAlarmActivity (Activity A)
{
	special_alarm_activity = A;	
}

void Alarm::SetAlarmPeriod (int Second)
{
	plaing_counter  = Second * 1000 / 2000 /*4000*/;
}

void Alarm::DisableEvents (void)
{

}

void Alarm::StopTimers (void)
{
	OS_StopTimer(&timer_alarm);
	OS_StopTimer(&timer_alarm_instant_plaing);
}

void Alarm::initial_members (void)
{
	RTCTime time;

	time.RTC_Sec = 0;
	time.RTC_Min = 0;
	time.RTC_Hour = 0;	
	time.RTC_Mday = 0;	
	time.RTC_Mon = 0;
	time.RTC_Year = 0;
	time.RTC_Wday = 0;
	time.RTC_Yday = 0;
	
	first_daily_alarm_time = time;
	second_daily_alarm_time = time;
	special_alarm_time = time;
	
	first_daily_alarm_message = "";
	second_daily_alarm_message = "";
	special_alarm_message = "";
	
	first_daily_alarm_activity = A_Disable;
	second_daily_alarm_activity = A_Disable;
	special_alarm_activity = A_Disable;
	
	plaing_counter = 0;	
	instant_plaing_counter = 0;

	is_plaing = 0;
}

void Alarm::create_timers (void)
{
	OS_CREATETIMER(&timer_alarm, timer_elepse_alarm, 300);
	OS_CreateTimer(&timer_alarm_instant_plaing, timer_elapse_instant_plaing_alarm, 4000);
}

void Alarm::play_alarm (void)
{
	if (is_plaing)
		return;
	
	is_plaing = true;
	
	instant_plaing_counter = 0;
	
	Sound s;
	
	s.PlayAlarm();
	
  	OS_RetriggerTimer(&timer_alarm_instant_plaing); 	
}	

void Alarm::timer_elepse_alarm (void)
{
	StatusBar s;
	
	if (first_daily_alarm_activity == A_Enable)
		if (first_daily_alarm_time.RTC_Hour == DateTime::Now().RTC_Hour &&
		    first_daily_alarm_time.RTC_Min == DateTime::Now().RTC_Min &&
		    first_daily_alarm_time.RTC_Sec == DateTime::Now().RTC_Sec )
		{
			play_alarm();
			
			if (first_daily_alarm_message.size()>0)
				s.ShowMessageTemporarily(first_daily_alarm_message);
		}

	if (second_daily_alarm_activity == A_Enable)
		if (second_daily_alarm_time.RTC_Hour == DateTime::Now().RTC_Hour &&
		    second_daily_alarm_time.RTC_Min == DateTime::Now().RTC_Min &&
		    second_daily_alarm_time.RTC_Sec == DateTime::Now().RTC_Sec )
		{
			play_alarm();
			
			if (second_daily_alarm_message.size()>0)
				s.ShowMessageTemporarily(second_daily_alarm_message);
		}
	
	if (special_alarm_activity == A_Enable)
		if (special_alarm_time.RTC_Year == DateTime::Now().RTC_Year &&
		    special_alarm_time.RTC_Mon == DateTime::Now().RTC_Mon &&
		    special_alarm_time.RTC_Mday == DateTime::Now().RTC_Mday &&
		    special_alarm_time.RTC_Hour == DateTime::Now().RTC_Hour &&
		    special_alarm_time.RTC_Min == DateTime::Now().RTC_Min &&
		    special_alarm_time.RTC_Sec == DateTime::Now().RTC_Sec)
		{
			play_alarm();
			
			if (special_alarm_message.size()>0)
				s.ShowMessageTemporarily(special_alarm_message);
		}
	
  	OS_RetriggerTimer(&timer_alarm);
}

void Alarm::timer_elapse_instant_plaing_alarm (void)
{
	if (plaing_counter == instant_plaing_counter)
	{
		is_plaing = false;
		
		return;
	}
	
	Sound s;
	
	s.PlayAlarm();
	
	instant_plaing_counter ++;	
	
	OS_RetriggerTimer(&timer_alarm_instant_plaing);
}
