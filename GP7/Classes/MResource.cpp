#include	"MRESOURCE.H"

MiddlewareResource::MiddlewareResource()
{
	
}

MiddlewareResource::~MiddlewareResource()
{
	
}

void MiddlewareResource::Initial (void)
{	
	initial_members();
	
	DisableEvents();
	
	create_timers();	
}	

void MiddlewareResource::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}

bool MiddlewareResource::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}



