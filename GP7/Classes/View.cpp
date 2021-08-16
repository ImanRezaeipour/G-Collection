#include 	"VIEW.H"
#include  	"LCD.H"
#include 	"UTILITY.H"
#include	"DATETIME.H"
#include        "SHOWTIME.h"
#include        "Notify.h"

OS_TIMER View::timer_view;

View::View ()
{

}

View::~View ()
{

}

void View::ShowMessageTemporarily (string  str)
{
	ShowMessage(str);
	
	OS_RetriggerTimer(&timer_view);
}

void View::ShowInvertMessageTemporarily (string str)
{
        Font font;
        LCD lcd(Medium, Farsi);
        ShowTime st;
        
        st.UpdateNotifyScopePermission(false);
        
        lcd.Clear(White);
        lcd.SetPixelFormat(PF_Invert);
        lcd.Write(str);
        
        font.SetSize(Small);
        lcd.Clear(0);
        lcd.Clear(6);
        //lcd.ClearSmallest(2,Black);
        //lcd.ClearSmallest(5,White);
        OS_RetriggerTimer(&timer_view);
}

void  View::ShowMessage (string  str)
{
	Clear();
	
	LCD lcd(Medium, Farsi);
		
        lcd.font.SetSize(Medium);
	
	lcd.Write(str);
}

void  View::Refresh(void)
{
	if (OS_GetTimerStatus(&timer_view))
		return;
	
	timer_expire_view();
}

void  View::Clear (void)
{
	LCD lcd(Small, Farsi);
        	
	lcd.Clear(2);
	lcd.Clear(4);
}

void View::DisableEvents (void)
{
	//
}
void View::StopTimers (void)
{
	OS_StopTimer(&timer_view);
}

void View::initial_members (void)
{
	//
}

void View::create_timers (void)
{
	OS_CreateTimer(&timer_view, timer_expire_view, 7000);
}

void View::timer_expire_view (void)
{
	LCD lcd(Farsi);
	string str;
        ShowTime st;
        NotifyBar nb;
	lcd.font.SetSize(Large);
        
	str.clear();
	
	lcd.Clear(2,Black);
  	
	str+=Utility::ToString(DateTime::Now().RTC_Hour,2);
	str+=":";
	str+=Utility::ToString(DateTime::Now().RTC_Min,2);
   /*
        str+=Utility::ToString(DateTime::Now().RTC_Min,2);
        str+=":";
        str+=Utility::ToString(DateTime::Now().RTC_Hour,2);
 */  
	lcd.Write(str);
        nb.Refresh();
        st.UpdateNotifyScopePermission(true);
}