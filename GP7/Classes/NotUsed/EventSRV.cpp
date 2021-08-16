#include	"EVENTSRV.H"

EventSRV::EventSRV()
{

}

EventSRV::~EventSRV()
{
	
}

void  EventSRV::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}
