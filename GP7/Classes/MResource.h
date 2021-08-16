#ifndef 	__MIDDLEWARERESOURCE__
#define 	__MIDDLEWARERESOURCE__

#include	"DATATYPE.H"
#include	"RTOS.H"

class MiddlewareResource
{
public:
	MiddlewareResource();
  	~MiddlewareResource(); 	
	
	void Initial (void);

	virtual void DisableEvents (void) = 0;
	
	virtual void StopTimers (void) = 0;
protected:
	virtual void initial_members (void) = 0;	

	virtual void create_timers (void) = 0;
	
	static void safe_call_handler (EventPointer EP);
	static bool is_task_running (OS_TASK* OTP);
};
#endif