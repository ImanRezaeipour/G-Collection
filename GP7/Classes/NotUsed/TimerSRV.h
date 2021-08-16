#ifndef		__TIMERSRV__
#define		__TIMERSRV__

class TimerSRV
{
public:
	TimerSRV();
	~TimerSRV();

protected:	
  	virtual void create_timers (void) = 0;
	
	virtual void start_timers (void) = 0;
	virtual void stop_timers (void) = 0;
};

#endif