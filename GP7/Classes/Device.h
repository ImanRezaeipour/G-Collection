#ifndef 	__DEVICE__
#define 	__DEVICE__

#include	"DATATYPE.H"
#include	"RTOS.H"

class Device
{
public:
	Device();
  	~Device(); 	
	
	void Initial (void);

        void Enable (void);
	void Disable (void);
	
	void Reset (void);
	
	virtual void DisableEvents (void) = 0;
        static TypeOfReader TypeDevice;

protected:
  	virtual void initial_hardware (void) = 0;
	virtual void initial_critical_resources (void) = 0;	
	virtual void initial_statuses (void) = 0;	
	virtual void initial_members (void) = 0;	
	virtual void final_initialization (void) = 0;



	virtual void set_enable_flag (bool flag) = 0;
	
	virtual void disable_interrupts (void) = 0;  	
	virtual void enable_interrupts (void) = 0;	

	virtual void create_critical_tasks (void) = 0;	
	virtual void create_nonecritical_tasks (void) = 0;	
	virtual void create_timers (void) = 0;

	virtual void resume_nonecritical_tasks (void) = 0;
	virtual void suspend_nonecritical_tasks (void) = 0;

	virtual void start_timers (void) = 0;
	virtual void stop_timers (void) = 0;

	static void safe_call_handler (EventPointer EP);
	static bool is_task_running (OS_TASK* OTP);
        
};
#endif