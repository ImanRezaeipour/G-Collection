#include	"SRESOURCE.H"

SoftwareResource::SoftwareResource ()
{

}

SoftwareResource::~SoftwareResource ()
{
	
}

void SoftwareResource::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}

bool SoftwareResource::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}