#include 	"BEEP.H"
#include 	"DATATYPE.H"

int Beep::count;
int Beep::delay_on;
int Beep::delay_off;
int Beep::freq;
int Beep::step;
Direction Beep::direction;

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
	freq = 3000;
	step = 0;
	direction = Up;
	
	if (is_task_running(&tcb_beep))
		return;

	OS_CREATETASK(&tcb_beep, "Beep_Task", task_beep, TP_LowPeriority, stack_beep);

}


void Beep::DoBeep (int Milisecond, int Count, int Frequency)
{
	SetFrequency(Frequency);
	SetCount(Count);
	SetFreqStep(0);
	SetOffPeriod(Milisecond/2);
	SetOnPeriod(Milisecond/2);
	
	Start();
}

void Beep::Ascend ()
{
	SetFrequency(600);
	SetCount(2);
	SetFreqStep(100);
	SetOffPeriod(100);
	SetOnPeriod(200);
	SetDirection(Up);

	Start();
}

void Beep::Descend ()
{
	SetFrequency(600);
	SetCount(2);
	SetFreqStep(100);
	SetOffPeriod(100);
	SetOnPeriod(200);
	SetDirection(Down);

	Start();
}

void Beep::Start (void)
{
	if (is_task_running(&tcb_beep))
		return;

	OS_CREATETASK(&tcb_beep, "Beep_Task", task_beep, TP_LowPeriority, stack_beep);
}

void Beep::SetFrequency(int Freq)
{
	freq = Freq;
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

void Beep::SetDirection (Direction D)
{
	direction = D;
}

void Beep::SetFreqStep (int Freq)
{
	step = Freq;
}

void  Beep::initial_members (void)
{
	delay_on = 500;
	delay_off = 500;
	count =1;
	freq = 3000;
	step = 0;
	direction = Up;
}

void Beep::task_beep (void)
{
	OS_EnterRegion();

        DAC dac;
	int ctr;
	unsigned long int l_freq;

	l_freq = freq;

	for (ctr=0;ctr<count;ctr++)
	{
		dac.GenerateSquareWave(l_freq);
		OS_Delay(delay_on);

		dac.StopWaveGeneration();
	OS_Delay(delay_off);

	if (direction == Up)
		l_freq += step;

	if (direction == Down)
		l_freq -= step;
	}

	OS_LeaveRegion();
        OS_Terminate(0);
}


bool Beep::is_task_running (OS_TASK* OTP)
{
	return OS_IsTask (OTP);
}

