#include	"DEVICE.H"

TypeOfReader Device::TypeDevice;

Device::Device()
{
	
}

Device::~Device()
{
	
}

void Device::Initial (void)
{	
	initial_hardware();
	
	initial_statuses();
	
	initial_members();
	
	DisableEvents();
	
	initial_critical_resources();
			
	create_critical_tasks();
	create_nonecritical_tasks();
	create_timers();	
	
	enable_interrupts();	
	
	set_enable_flag(true);
	
	final_initialization();
}	

void Device::Disable (void)
{
	stop_timers();
	suspend_nonecritical_tasks();
	disable_interrupts();
	set_enable_flag(false);
}

void Device::Enable (void)
{
	start_timers();
	resume_nonecritical_tasks();
	enable_interrupts();
	set_enable_flag(true);
}

void Device::Reset (void)
{
	Disable();
	
	initial_statuses();
	DisableEvents();
	
	initial_members();
	
	Enable();
}

void  Device::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}

bool Device::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}

