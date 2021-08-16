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

        void DoBeep (int Milisecond, int Count);
        void DoBeep (int ON_ms,int OFF_ms, int Count);
        void BeepErr (void);

	void Start (void);

	void SetFrequency (int Freq);
	void SetCount (int Count);
	void SetPeriod (int MiliSecond);
	void SetOnPeriod (int MiliSecond); 	
       	void SetOffPeriod (int MiliSecond); 
        void DoBeepWithoutTask (int MiliSecond);	

private:
	void initial_members (void);

	static void task_beep (void);
	
	static bool is_task_running (OS_TASK* OTP);
	
	static int count;
	static int delay_on;
	static int delay_off;
	
	static OS_STACKPTR int stack_beep[128];
	static OS_TASK tcb_beep;
};
#endif