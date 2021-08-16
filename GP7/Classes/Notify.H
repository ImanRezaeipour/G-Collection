#ifndef 	__NOTIFYBAR__
#define 	__NOTIFYBAR__

#include	"DATATYPE.H"
#include  	"STRING"

class NotifyBar
{
public:
  	NotifyBar ();
  	~NotifyBar ();
  
  	void TurnAllIcons (Power  P);

  	void TurnSoundIcon (Power p); 
  	void TurnKeyIcon (Power P);
  	void TurnLANIcon (Power);
  	void TurnUSBIcon (Power);
  	void TurnSaveIcon (Power);
  	void TurnModeIcon (Power); 
        void TurnModemIcon (Power); 
        void ShowMessageInvertTemporarily (string  str);

  	void Refresh (void);
  
private:
	static BOOL key_icon;
	static BOOL lan_icon;
	static BOOL usb_icon;
	static BOOL save_icon;
	static BOOL smode_icon;  
	static BOOL sound_icon;
        static BOOL modem_icon;
};      
#endif