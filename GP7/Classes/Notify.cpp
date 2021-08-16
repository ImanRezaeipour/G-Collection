#include  	"NOTIFY.H"
#include  	"LCD.H"
#include	"STRING"
#include	"UTILITY.H"
#include	"DATETIME.H"

BOOL NotifyBar::key_icon;
BOOL NotifyBar::lan_icon;
BOOL NotifyBar::usb_icon;
BOOL NotifyBar::save_icon;
BOOL NotifyBar::smode_icon; 
BOOL NotifyBar::sound_icon;
BOOL NotifyBar::modem_icon;

NotifyBar::NotifyBar ()
{
  
}

NotifyBar::~NotifyBar ()
{
  
}

void NotifyBar::TurnAllIcons (Power  P)
{
	if (P == On)
	{
		TurnSoundIcon(On);
		TurnKeyIcon(On);
		TurnSaveIcon(On);
		TurnUSBIcon(On);
		TurnLANIcon(On);
		TurnModeIcon(On); 
                TurnModemIcon(On) ;
	}
	else
	{
		TurnSoundIcon(Off);
		TurnKeyIcon(Off);
		TurnSaveIcon(Off);
	TurnUSBIcon(Off);
	TurnLANIcon(Off);
	TurnModeIcon(Off);  
        TurnModemIcon(Off) ;
	}  
}


void NotifyBar::TurnSoundIcon (Power P)
{  
	LCD lcd;
   
	if (P == On)
	{
    		sound_icon = true;
    
		lcd.font.SetSize(Small);
		lcd.SetPixelFormat(PF_Invert);    
		lcd.DrawIcon(A_Right,0,I_Sound);
	}
	else
	{
		sound_icon = false;    
		lcd.Clear(127-lcd.font.GetIconLenght(I_Sound),0,127,1,White);
	}
}

void NotifyBar::TurnKeyIcon (Power P)
{  
	LCD lcd;
	Metric  m;
  
	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard);
  
	if (P == On)
	{
		key_icon = true;    
		lcd.font.SetSize(Small);
		lcd.SetPixelFormat(PF_Invert);    
		lcd.DrawIcon(m.x,0,I_Keyboard); 
	}
	else
	{
		key_icon = false; 
		m.len = lcd.font.GetIconLenght(I_Keyboard);
		lcd.Clear(m.x,0,m.x+m.len,1,White);  
	}
}

void NotifyBar::TurnSaveIcon (Power P)
{
	LCD lcd;
	Metric  m;

	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard)-lcd.font.GetIconLenght(I_Save);  

	if (P == On)
	{
		save_icon = true;
		lcd.font.SetSize(Small);
		lcd.SetPixelFormat(PF_Invert);
		lcd.DrawIcon(m.x,0,I_Save);      
	}
	else
	{
		save_icon = false;   
		m.len = lcd.font.GetIconLenght(I_Save);  
		lcd.Clear(m.x,0,m.x+m.len,1,White);    
	}    
}

void NotifyBar::TurnUSBIcon (Power P)
{
	LCD lcd;
	Metric  m;
  
	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard)-lcd.font.GetIconLenght(I_Save)-lcd.font.GetIconLenght(I_USB);
  
	if (P == On)
	{
		usb_icon = true;
		lcd.font.SetSize(Small);
		lcd.SetPixelFormat(PF_Invert);
		lcd.DrawIcon(m.x,0,I_USB);       
	}
	else
	{
		usb_icon = false;
		m.len = lcd.font.GetIconLenght(I_USB);
		lcd.Clear(m.x,0,m.x+m.len,1,White); 
	}  
}

void NotifyBar::TurnLANIcon (Power P)
{
	LCD lcd;
	Metric  m;
  
	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard)-lcd.font.GetIconLenght(I_Save)-lcd.font.GetIconLenght(I_USB)-lcd.font.GetIconLenght(I_LAN);
  
	if (P == On)
	{
		lan_icon = true;
		lcd.font.SetSize(Small);
		lcd.SetPixelFormat(PF_Invert);
		lcd.DrawIcon(m.x,0,I_LAN);       
	}
	else
  	{
		lan_icon = false;
		m.len = lcd.font.GetIconLenght(I_LAN);
    		lcd.Clear(m.x,0,m.x+m.len,1,White); 
  	}  
}

void NotifyBar::TurnModeIcon (Power P)
{
	LCD lcd;
	Metric m;

	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard)-lcd.font.GetIconLenght(I_Save)-lcd.font.GetIconLenght(I_USB)-lcd.font.GetIconLenght(I_LAN)-lcd.font.GetIconLenght(I_Admin);
   
	if (P == On)
	{
		smode_icon = true;
		lcd.SetPixelFormat(PF_Invert);
		lcd.DrawIcon(m.x,0,I_Admin);  
	}
	else
	{
		smode_icon = false;
		m.len = lcd.font.GetIconLenght(I_Admin);
		lcd.Clear(m.x,0,m.x+m.len,1,White); 
	}     
}

void NotifyBar::TurnModemIcon (Power P)
{
	LCD lcd;
	Metric m;

	m.x = 127-lcd.font.GetIconLenght(I_Sound)-lcd.font.GetIconLenght(I_Keyboard)-lcd.font.GetIconLenght(I_Save)-lcd.font.GetIconLenght(I_USB)-lcd.font.GetIconLenght(I_LAN)-lcd.font.GetIconLenght(I_Admin)-lcd.font.GetIconLenght(I_Card);
   
	if (P == On)
	{
		modem_icon = true;
		lcd.SetPixelFormat(PF_Invert);
		lcd.DrawIcon(m.x,0,I_Modem);  
	}
	else
	{
		modem_icon = false;
		m.len = lcd.font.GetIconLenght(I_Modem);
		lcd.Clear(m.x,0,m.x+m.len,1,White); 
	}     
}

void NotifyBar::ShowMessageInvertTemporarily (string  str)
{
	
	LCD lcd(Farsi);
	lcd.font.SetSize(Small);
		
	lcd.Write(A_Center, 0,str);

}

void NotifyBar::Refresh (void)
{
	string str;
	LCD lcd(Small, Farsi);
	lcd.SetPixelFormat(PF_Invert);
	
	lcd.Clear(0,White);	
	
	str+=Utility::ToString(DateTime::Now().RTC_Sec,2);
    
    	lcd.Write(A_Left,0,str);
	
	if (sound_icon)
		TurnSoundIcon(On);
	else 
		TurnSoundIcon(Off);
  
	if (key_icon)
		TurnKeyIcon(On);
	else 
    		TurnKeyIcon(Off);
  
	if (save_icon)
		TurnSaveIcon(On);
	else 
		TurnSaveIcon(Off);
  
	if (usb_icon)
		TurnUSBIcon(On);
	else 
    		TurnUSBIcon(Off);

	if (lan_icon)
		TurnLANIcon(On);
	else 
		TurnLANIcon(Off);    
  
	if (smode_icon)
		TurnModeIcon(On);
	else 
		TurnModeIcon(Off); 
        
        if (modem_icon)
		TurnModemIcon(On);
	else 
		TurnModemIcon(Off); 
}