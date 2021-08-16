#ifndef		__BACKLIGHT__
#define		__BACKLIGHT__

#include 	"RTOS.h"
#include 	"DATATYPE.H"
#include	"HRESOURCE.H"

class BackLight : public HardwareResource
{
public:
	BackLight (FadeMode Mode, Speed S);
	~BackLight ();
  
	void SetFadeSpeed (Speed S);
	void SetFadeMode (FadeMode Mode);

	void DoFade (void);
	
	static void SharpOn (void);
	static void SharpOff (void);

private:
  	void initial_hardware (void);
	void initial_members (void);	

	void create_timers (void);
	
	static void fade_on (void);
	static void fade_off (void);

	static void task_backlight (void);

	static FadeMode fade_mode;
	static float accelerate;  

	static OS_STACKPTR int stack_backlight[128];       
  	static OS_TASK tcb_backlight;                      
};
#endif  