#include 	"DATETIME.H"
#include 	"UTILITY.H"
#include 	"MATH.H"

DateTime::DateTime ()
{
	
}

DateTime::~DateTime ()
{
	
}

void DateTime::SetDate (int Year,int Month, int Day)
{
	Hardware h;
	RTCTime date;

	date = h.RTCGetTime();

	date.RTC_Mday = Day;
	date.RTC_Mon = Month;
	date.RTC_Year = Year;

	h.RTCSetTime(date);
}

void DateTime::SetTime (int Hour, int Minute, int Second)
{
	Hardware h;
	RTCTime time;

	time = h.RTCGetTime();

	time.RTC_Hour = Hour;
	time.RTC_Min = Minute;
	time.RTC_Sec = Second;

	h.RTCSetTime(time);
}

void DateTime::SetYear (int Year)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Year = Year;

	h.RTCSetTime(date_time);
}

void DateTime::SetMonth (int Month)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Mon = Month;

	h.RTCSetTime(date_time);
}

void DateTime::SetDay (int Day)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Mday = Day;

	h.RTCSetTime(date_time);
}

void DateTime::SetWday (int Wday)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Wday = Wday;

	h.RTCSetTime(date_time);
}

void DateTime::SetHour (int Hour)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Hour = Hour;

	h.RTCSetTime(date_time);
}

void DateTime::SetMinute (int Minute)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Min = Minute;

	h.RTCSetTime(date_time);
}

void DateTime::SetSecond (int Second)
{
	Hardware h;
	RTCTime date_time;

	date_time = h.RTCGetTime();

	date_time.RTC_Sec = Second;

	h.RTCSetTime(date_time);
}

string  DateTime::GetDateToString (RTCTime Date)
{
	string  str;
	
	str.clear();

	str += Utility::ToString(Date.RTC_Year);
	str += "/";
	str += Utility::ToString(Date.RTC_Mon);
	str += "/";
	str += Utility::ToString(Date.RTC_Mday);

	return str;
}

string  DateTime::GetTimeToString (RTCTime Time)
{
	string str;
	
	str.clear();

	str += Utility::ToString(Time.RTC_Hour);
	str += ":";
	str += Utility::ToString(Time.RTC_Min);
	str += ":";
	str += Utility::ToString(Time.RTC_Sec);

	return str;
}

string DateTime::GetTime (void)
{
	Hardware h;
	RTCTime time;
	string str;

	time = h.RTCGetTime();

	str.clear();
	
	str+=Utility::ToString(time.RTC_Hour);
	str+=":";
	str+=Utility::ToString(time.RTC_Min);
	str+=":";
	str+=Utility::ToString(time.RTC_Sec);

	return str;
}

string DateTime::GetDate (void)
{
	Hardware h;
	RTCTime date;
	string str;

	date = h.RTCGetTime();

	str.clear();

	str+=Utility::ToString(date.RTC_Year);
	str+="/";
	str+=Utility::ToString(date.RTC_Mon);
	str+="/";
	str+=Utility::ToString(date.RTC_Mday);

	return str;
}

string DateTime::GetShamsiDate (void)
{
	string  str;
	RTCTime date;
	
	date = ConvertToShamsi(Now());

	str.clear();

	str+=Utility::ToString(date.RTC_Year);
	str+='/';
	str+=Utility::ToString(date.RTC_Mon);
	str+='/';
	str+=Utility::ToString(date.RTC_Mday);

	return str;
}

string DateTime::GetShamsiDayName (void)
{
	Hardware h;
	RTCTime date;
	string str;

	date = h.RTCGetTime();

	switch(date.RTC_Wday)
	{
		case 0:
			return "ÔäÈå";
		case 1:
			return "í˜ ÔäÈå";
		case 2:
			return "Ïæ ÔäÈå";
		case 3:
			return "Óå ÔäÈå";
		case 4:
			return "åÇÑÔäÈå";
		case 5:
			return "äÌ ÔäÈå";
		case 6:
			return "ÌãÚå";
	}
	
	return "SAP";
}

RTCTime DateTime::ConvertToShamsi (RTCTime Date)
{
	float j_day;
	int temp;
	
	j_day = 367 * Date.RTC_Year - floorf(7.0 * ( Date.RTC_Year + floorf ( ( Date.RTC_Mon + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * Date.RTC_Mon / 9 ) + Date.RTC_Mday + 1721015 ;

	/*julian_day = 367 * now.RTC_Year - floorf(7.0 * ( now.RTC_Year + floorf ( ( now.RTC_Mon + 9 ) / 12.0 ) ) / 4)
		- floorf ( 3.0 * ( floorf ( ( now.RTC_Year + ( now.RTC_Mon - 9 ) / 7 ) / 100.0 ) +1 ) /4 )
		+ floorf ( 275.0 * now.RTC_Mon / 9 ) + now.RTC_Mday + 1721028.5 + now.RTC_Hour / 24;*/

	j_day -= 1948320;

	Date.RTC_Year = (int) ( ( 33 * j_day - 30 ) / 12053 + 1 );

	temp = (int) ( j_day - 365 * ( Date.RTC_Year - 1 ) - ( 8 * Date.RTC_Year + 21) / 33 - 1 );

	if (temp > 186)
	{
		Date.RTC_Mon = ( temp - 186 ) / 30 + 7;
		Date.RTC_Mday = ( temp - 186 ) % 30 + 1 ;
	}
	else
	{
		Date.RTC_Mon = ( temp / 31 ) + 1;
		Date.RTC_Mday = temp % 31 + 1;
	}

	return Date;
}

RTCTime DateTime::ConvertToMiladi (RTCTime Date)
{
	float j_day, a, b, c, d, e, m;

	j_day = 365.0 * (Date.RTC_Year -1) + (8 * Date.RTC_Year + 21) / 33 + Date.RTC_Mday + 30 * (Date.RTC_Mon - 1) + ((6 - (Date.RTC_Mon - 1))>0?(Date.RTC_Mon - 1):6);

	j_day += 1948319;
	
	a = j_day + 32044;
	b = floorf ((4 * a + 3) / 146097);
	c = a - floorf((146097 * b) / 4);
	d = floorf((4 * c + 3) / 1461);
	e = c - floorf((1461 * d) / 4);
	m = floorf((5 * e + 2) / 153);	

	Date.RTC_Year = (int) ( 100 * b + d - 4800 + floorf(m / 10));
	Date.RTC_Mon = (int) (m + 3 - 12 * floorf(m / 10));
	Date.RTC_Mday = (int) (e - floorf((153 * m + 2) / 5) + 1);

	Date.RTC_Wday =  (DWORD) (j_day + 2) % 7 ;
	
	return Date;
}

BYTE DateTime::CalculateWday (RTCTime Date)
{
         float j_day = 367 * Date.RTC_Year - floorf(7.0 * ( Date.RTC_Year + floorf ( ( Date.RTC_Mon + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * Date.RTC_Mon / 9 ) + Date.RTC_Mday + 1721015 ;
         j_day -= 1948320;
         BYTE Wday =  (DWORD) (j_day + 4) % 7 ;
         return Wday;
}

/*
RTCTime DateTime::ConvertToMiladi (RTCTime Date)
{
	float j_day, a, b, c, d, e, m;

	j_day = 365.0 * (Date.RTC_Year -1) + (8 * Date.RTC_Year + 21) / 33 + Date.RTC_Mday + 30 * (Date.RTC_Mon - 1) + ((6 - (Date.RTC_Mon - 1))>0?(Date.RTC_Mon - 1):6);

	j_day += 1948319;
	
	a = j_day + 32044;
	b = floorf ((4 * a + 3) / 146097);
	c = a - floorf((146097 * b) / 4);
	d = floorf((4 * c + 3) / 1461);
	e = c - floorf((1461 * d) / 4);
	m = floorf((5 * e + 2) / 153);
		

	Date.RTC_Year = (int) ( 100 * b + d - 4800 + floorf(m / 10));
	Date.RTC_Mon = (int) (m + 3 - 12 * floorf(m / 10));
	Date.RTC_Mday = (int) (e - floorf((153 * m + 2) / 5) + 1);
	
	a = (14 - Date.RTC_Mon) / 12;
	//y = Date.RTC_Year - a;
	m = Date.RTC_Mon + 12 * a - 2;
	
	Date.RTC_Wday = (Date.RTC_Mday + Date.RTC_Year + Date.RTC_Year / 4 - Date.RTC_Year / 100 + Date.RTC_Year / 400 + (31 * Date.RTC_Mon) / 12) % 7; //(DWORD) (j_day + 2) % 7 ;
	Date.RTC_Wday = Date.RTC_Wday + 1;
	
	return Date;
}*/
int DateTime::GetPassedSecondes (RTCTime Instance1, RTCTime Instance2)
{
	int sec;

	sec =0;

	sec += (Instance2.RTC_Sec   -   Instance1.RTC_Sec);
	sec += (Instance2.RTC_Min   -   Instance1.RTC_Min)  *60;
	sec += (Instance2.RTC_Hour  -   Instance1.RTC_Hour) *60*60;
	sec += (Instance2.RTC_Mday  -   Instance1.RTC_Mday) *60*60*60;
	sec += (Instance2.RTC_Mon   -   Instance1.RTC_Mon)  *60*60*60*60;
	sec += (Instance2.RTC_Year  -   Instance1.RTC_Year) *60*60*60*60*60;

	return  sec;
}

int DateTime::GetPassedSecondesUntilNow (RTCTime Instance)
{
	return  GetPassedSecondes(Instance, Now());
}

RTCTime DateTime::Now (void)
{
	Hardware h;
	return h.RTCGetTime();
}

DWORD DateTime::GetPackedDateTime (RTCTime DT)
{
        float j_day_1, j_day_2;

       	j_day_1 = 367 * 2000 - floorf(7.0 * ( 2000 + floorf ( ( 1 + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * 1 / 9 ) + 1 + 1721015 ;

        j_day_2 = 367 * DT.RTC_Year - floorf(7.0 * ( DT.RTC_Year + floorf ( ( DT.RTC_Mon + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * DT.RTC_Mon / 9 ) + DT.RTC_Mday + 1721015 ;

        return ((DWORD) (j_day_2 - j_day_1) * 24*60*60 + DT.RTC_Hour * 60*60 + DT.RTC_Min * 60 + DT.RTC_Sec);
}	

RTCTime DateTime::GetRealDateTime (DWORD PackedDT)
{
	float j_day, a, b, c, d, e, m;

        RTCTime DT;

       	j_day = 367 * 2000 - floorf(7.0 * ( 2000 + floorf ( ( 1 + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * 1 / 9 ) + 1 + 1721014 ;

	j_day += PackedDT/(24*60*60);

        a = j_day + 32044;
	b = floorf ((4 * a + 3) / 146097);
	c = a - floorf((146097 * b) / 4);
	d = floorf((4 * c + 3) / 1461);
	e = c - floorf((1461 * d) / 4);
	m = floorf((5 * e + 2) / 153);
		

	DT.RTC_Year = (WORD) ( 100 * b + d - 4800 + floorf(m / 10));
	DT.RTC_Mon = (BYTE) (m + 3 - 12 * floorf(m / 10));
	DT.RTC_Mday = (BYTE) (e - floorf((153 * m + 2) / 5) + 1);

        DT.RTC_Hour = (BYTE) ((PackedDT % (24*60*60))/3600);
        DT.RTC_Min = (BYTE) ((PackedDT % (60*60))/60) ;
        DT.RTC_Sec = (BYTE) (PackedDT % 60);

	return DT;
}








