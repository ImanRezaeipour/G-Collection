#ifndef		__EVENTSRV__
#define		__EVENTSRV__

#include	"DATATYPE.H"

class EventSRV
{
public:
	EventSRV();
	~EventSRV();

protected:
	virtual void disable_events (void) = 0;
	static void safe_call_handler (EventPointer EP);
};

#endif