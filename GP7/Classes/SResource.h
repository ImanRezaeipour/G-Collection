#ifndef 	__SOFTWARERESOURCE__
#define 	__SOFTWARERESOURCE__

#include	"DATATYPE.H"
#include	"RTOS.H"

class SoftwareResource 
{
public:
	SoftwareResource();
  	~SoftwareResource(); 	

protected:
	//virtual void initial_statuses (void) = 0;	
//	virtual void initial_members (void) = 0;		
	
//	virtual void disable_events (void) = 0;

	
	static void safe_call_handler (EventPointer EP);
	static bool is_task_running (OS_TASK* OTP);
};
#endif