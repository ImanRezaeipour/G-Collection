#include 	"STATUS.H"
#include  	"LCD.H"
#include  	"DATETIME.H"
#include        "Finger.h"

OS_TIMER StatusBar::timer_status;

StatusBar::StatusBar ()
{

}

StatusBar::~StatusBar ()
{

}

void StatusBar::ShowMessageTemporarily (string  str)
{
  	ShowMessage(str);
  	OS_RetriggerTimer(&timer_status);
}

void StatusBar::ShowMessage (string  str)
{
	Clear();
	
	LCD lcd(Farsi);
	lcd.font.SetSize(Small);
	lcd.SetPixelFormat(PF_Invert);
		
	lcd.Write(A_Center, 6,str);
}

void StatusBar::ShowMessageInvertTemporarily (string  str)
{
	//Clear();
	
	LCD lcd(Farsi);
	lcd.font.SetSize(Small);
	//lcd.SetPixelFormat(PF_Invert);
		
	lcd.Write(A_Center, 6,str);
        
        OS_RetriggerTimer(&timer_status);
}

void StatusBar::Refresh (void)
{
        Finger f;
  
	if (OS_GetTimerStatus(&timer_status))
		return;

	timer_expire_status();
        //f.FreeScanMode(On);
}

void StatusBar::Clear (void)
{
	LCD lcd;
	lcd.font.SetSize(Small);
	lcd.SetPixelFormat(PF_Invert);
	lcd.Clear(6, White);
	lcd.Clear(7, White);
	
	OS_StopTimer(&timer_status);	
}

void StatusBar::StopTimers (void)
{
	OS_StopTimer(&timer_status);	
}	

void StatusBar::DisableEvents (void)
{
	//
}

void StatusBar::initial_members (void)
{
	//
}

void StatusBar::create_timers (void)
{
	OS_CreateTimer(&timer_status, timer_expire_status, 7000);
}

void StatusBar::timer_expire_status (void)
{
	LCD lcd(Farsi);
	DateTime date_time;
	string  str;

	lcd.SetPixelFormat(PF_Invert);
	lcd.font.SetSize(Small);

	lcd.Clear(6,White);

	str.clear();
	str = date_time.GetShamsiDate();
	
	lcd.Write(A_Left,6,str);
	lcd.Write(A_Right,6,date_time.GetShamsiDayName());
}