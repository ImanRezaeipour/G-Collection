#ifndef		__SOUND__
#define		__SOUND__

#include 	"SOUND.D"

class Sound
{
public:
	Sound ();
	~Sound ();
	
        void PlayAlarm (void);
	void PlayStart (void);
	void PlayError (void);
	void PlaySuccess (void);
	void PlayKey (void);
	void PlayDing (void);
	void PlayConnection (void);
	void PlayInsert (void);
	void PlayRemove (void);
	void PlayDingDang (void);

	void SetActivity (Activity A);
	Activity GetActivity (void);  
  
private:
	void play (void); 
	static void hardware_timer_expire (void); 

	static unsigned long int index, size;
	static BYTE* address;
  
	static  Activity  activity;
};
#endif