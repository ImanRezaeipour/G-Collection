#ifndef 	__STATUSBAR__
#define 	__STATUSBAR__

#include  	"STRING"
#include  	"RTOS.H"
#include	"MRESOURCE.H"

class StatusBar : public MiddlewareResource
{
public:
	StatusBar     ();
        ~StatusBar    ();

	void ShowMessageTemporarily (string  str);
	void ShowMessage (string  str);

	void Refresh (void);
	
	void Clear (void);

	void DisableEvents (void);	
	
	void StopTimers (void);
        
        void ShowMessageInvertTemporarily (string  str);

private:
	void initial_members (void);	

	void create_timers (void);

	static void timer_expire_status (void);

	static OS_TIMER timer_status;
};
#endif