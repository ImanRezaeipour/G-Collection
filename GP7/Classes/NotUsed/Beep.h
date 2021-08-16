#ifndef 	__BEEP__
#define 	__BEEP__

#include 	"DAC.H"
#include 	"RTOS.H"

class Beep 
{
public:
	Beep ();
	~Beep ();
  
	static void DoBeep (void);
	static void DoBeep (int MiliSecond);
  
	void DoBeep (int Milisecond, int Count, int Frequency);
  
	void Ascend ();
	void Descend ();
 
	void Start (void);

	void SetFrequency (int Freq);
	void SetCount (int Count);
	void SetPeriod (int MiliSecond);
	void SetOnPeriod (int MiliSecond);
	void SetOffPeriod (int MiliSecond);
	void SetDirection (Direction D);
	void SetFreqStep (int Freq);    
  
private:
	void initial_members (void);

	static void task_beep (void);
	
	static bool is_task_running (OS_TASK* OTP);
	
	static int count;
	static int delay_on;
	static int delay_off;
	static int freq;
	static int step;
	static Direction direction;

	static OS_STACKPTR int stack_beep[128];       
	static OS_TASK tcb_beep;    
};
#endif