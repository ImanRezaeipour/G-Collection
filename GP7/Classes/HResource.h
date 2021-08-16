#ifndef 	__HARDWARERESOURCE__
#define 	__HARDWARERESOURCE__

#include	"DATATYPE.H"
#include	"RTOS.H"

class HardwareResource
{
public:
	HardwareResource();
  	~HardwareResource(); 	
	
	void Initial (void);

protected:
  	virtual void initial_hardware (void) = 0;
	virtual void initial_members (void) = 0;	

	virtual void create_timers (void) = 0;

	static void safe_call_handler (EventPointer EP);
	static bool is_task_running (OS_TASK* OTP);
};
#endif