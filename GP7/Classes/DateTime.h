#ifndef  	__DATETIME__
#define  	__DATETIME__

#include 	"HARDWARE.H"
#include 	"STRING"

class DateTime
{
public:
	DateTime ();
	~DateTime ();	
	
	void SetDate (int Year,int Month, int Day);
	void SetTime (int Hour, int Minute, int Second);

	void SetYear (int Year);
	void SetMonth (int Month);
	void SetDay (int Day);
	void SetWday (int Day);

	void SetHour (int Hour);
	void SetMinute (int Minute);
	void SetSecond (int Second);
 	
	int GetShamsiMDay (void);
	int GetShamsiMonth (void);
	int GetShamsiYear (void); 	
	
	static string GetDateToString (RTCTime Date);
	static string GetTimeToString (RTCTime Time);

	string GetTime (void);
	string GetDate (void);
	string GetShamsiDate (void);

	//string GetDayName (void);
	//string GetMonthName (void);
	
	string GetShamsiDayName (void);
	//string GetShamsiMonthName (void);
        
        BYTE CalculateWday (RTCTime Date);

	static RTCTime ConvertToShamsi (RTCTime Date);
	static RTCTime ConvertToMiladi (RTCTime Date);

	static int GetPassedSecondes (RTCTime Instance1, RTCTime Instance2);
	static int GetPassedSecondesUntilNow (RTCTime Instance);

	static RTCTime Now(void);
        static DWORD GetPackedDateTime (RTCTime DT);
        static RTCTime GetRealDateTime (DWORD PackedDT);
};
#endif