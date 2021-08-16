#ifndef		__INTERRUPTSRV__
#define		__INTERRUPTSRV__

class InterruptSRV
{
public:
	InterruptSRV();
	~InterruptSRV();

protected:
  	virtual void initial_hardware (void) = 0;
	
	virtual void disable_interrupts (void) = 0;  	
	virtual void enable_interrupts (void) = 0;	
};

#endif