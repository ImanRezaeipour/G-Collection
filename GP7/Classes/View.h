#ifndef 	__VIEW__
#define 	__VIEW__

#include  	"STRING"
#include  	"RTOS.H"
#include	"MRESOURCE.H"

class View : public MiddlewareResource
{
public:
	View ();
	~View ();
	
	void ShowMessageTemporarily  (string  str);
	void ShowMessage (string  str);

	void Refresh (void);

	void Clear (void);

	void DisableEvents (void);	
	
	void StopTimers (void);
        
        void ShowInvertMessageTemporarily (string str);
private:
	void initial_members (void);	
	
	void create_timers (void);
	
  	static void timer_expire_view (void);
	
	static OS_TIMER timer_view;
};
#endif