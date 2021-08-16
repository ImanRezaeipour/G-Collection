#include	"HRESOURCE.H"

HardwareResource::HardwareResource()
{
	
}

HardwareResource::~HardwareResource()
{
	
}

void HardwareResource::Initial (void)
{	
	initial_hardware();
	
	initial_members();
	
	create_timers();	
}	

void HardwareResource::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}

bool HardwareResource::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}



