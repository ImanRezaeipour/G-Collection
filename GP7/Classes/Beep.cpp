#include 	"BEEP.H"
#include 	"DATATYPE.H"
#include        "HARDWARE.H"
#include        "Utility.h"

int Beep::count;
int Beep::delay_on;
int Beep::delay_off;

OS_STACKPTR int Beep::stack_beep[128];
OS_TASK Beep::tcb_beep;

Beep::Beep ()
{
  initial_members();
}

Beep::~Beep ()
{

}

void Beep::DoBeep (void)
{
	DoBeep(500);
}

void Beep::DoBeep (int MiliSecond)
{
	delay_on = delay_off = MiliSecond;
	count =1;
		
	if (is_task_running(&tcb_beep))
		return;

	OS_CREATETASK(&tcb_beep, "Beep_Task", task_beep, TP_LowPeriority, stack_beep);

}

void Beep::DoBeepWithoutTask (int MiliSecond)
{
        Utility u;
        Hardware h;
	delay_on = delay_off = MiliSecond;

        h.BuzzerON();

        u.Delay_ms(delay_on);

	h.BuzzerOFF();

	u.Delay_ms(delay_off);

}

void Beep::DoBeep (int Milisecond, int Count)
{
	SetCount(Count);	
	SetOffPeriod(Milisecond);
	SetOnPeriod(Milisecond);
	
	Start();
}

void Beep::DoBeep (int ON_ms,int OFF_ms, int Count)
{
	SetCount(Count);	
	SetOffPeriod(OFF_ms);
	SetOnPeriod(ON_ms);
	
	Start();
}

void Beep::BeepErr (void)
{
	DoBeep (200,50, 3);
}

void Beep::Start (void)
{
	if (is_task_running(&tcb_beep))
		return;

	OS_CREATETASK(&tcb_beep, "Beep_Task", task_beep, TP_LowPeriority, stack_beep);
}

void Beep::SetCount (int Count)
{
	count = Count;
}

void Beep::SetPeriod (int MiliSecond)
{
	delay_on = delay_off = MiliSecond;
}

void Beep::SetOnPeriod (int MiliSecond)
{
	delay_on = MiliSecond;
}

void Beep::SetOffPeriod (int MiliSecond)
{
	delay_off = MiliSecond;
}

void  Beep::initial_members (void)
{
	delay_on = 500;
	delay_off = 500;
	count =1;	
}

void Beep::task_beep (void)
{
        Hardware h;
       	int ctr;	
	
	for (ctr=0;ctr<count;ctr++)
	{
                h.BuzzerON();

                OS_Delay(delay_on);

		h.BuzzerOFF();

	        OS_Delay(delay_off);
	}
        OS_Terminate(0);
}


bool Beep::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}

