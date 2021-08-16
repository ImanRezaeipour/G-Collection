#ifndef		__ALARM__
#define		__ALARM__

#include	"DATATYPE.H"
#include 	"RTOS.H"
#include	"STRING"
#include	"MRESOURCE.H"

class Alarm : public MiddlewareResource
{
public:
	Alarm ();
	~Alarm ();

	void SetFirstDailyAlarmTime (RTCTime Time);
	void SetSecondDailyAlarmTime (RTCTime Time);
	void SetSpecialAlarmTime (RTCTime Time);
	
	void SetFirstDailyAlarmMessage (string Message);
	void SetSecondDailyAlarmMessage (string Message);
	void SetSpecialAlarmMessage (string Message);
	
	void FirstDailyAlarmActivity (Activity A);
	void SecondDailyAlarmActivity (Activity A);
	void SpecialAlarmActivity (Activity A);	
	
	void SetAlarmPeriod (int Second);
	
	void DisableEvents (void);
	
	void StopTimers (void);
	
private:
	void initial_members (void);	

	void create_timers (void);
	
	static void play_alarm (void);
	
	static void timer_elepse_alarm (void);

	static void timer_elapse_instant_plaing_alarm (void);
	
	static int plaing_counter;
	static int instant_plaing_counter;
	
	static bool is_plaing;
	
	static Activity first_daily_alarm_activity;
	static Activity second_daily_alarm_activity;
	static Activity special_alarm_activity;
	
	static RTCTime first_daily_alarm_time;
	static RTCTime second_daily_alarm_time;
	static RTCTime special_alarm_time;
	
	static string first_daily_alarm_message;
	static string second_daily_alarm_message;
	static string special_alarm_message;
	
	static OS_TIMER timer_alarm;
	static OS_TIMER timer_alarm_instant_plaing;
};
#endif
	
	
	
	
	
