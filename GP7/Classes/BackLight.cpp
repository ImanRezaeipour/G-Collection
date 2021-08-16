#include 	"BACKLIGHT.H"
#include 	"HARDWARE.H"


float BackLight::accelerate;
FadeMode BackLight::fade_mode;

OS_STACKPTR int BackLight::stack_backlight[128];
OS_TASK BackLight::tcb_backlight;

BackLight::BackLight (FadeMode Mode, Speed S)
{
	SetFadeSpeed(S);
	SetFadeMode(Mode);
}

BackLight::~BackLight ()
{
	
}

void BackLight::SetFadeSpeed (Speed S)
{
	if(S == S_VeryFast)
		accelerate = 1.6;
	else if (S == S_Fast)
		accelerate = 1.3;
	else if (S == S_Normal)
		accelerate = 1.1;
	else if (S == S_Slow)
		accelerate = 1.07;
	else if (S == S_VerySlow)
		accelerate = 1.05;
}

void BackLight::SetFadeMode (FadeMode Mode)
{
  	fade_mode = Mode;
}

void BackLight::DoFade (void)
{
	if (is_task_running(&tcb_backlight))
		return;

	OS_CREATETASK(&tcb_backlight, "Backlight_Task", task_backlight, TP_LowPeriority, stack_backlight);
}

void BackLight::SharpOn (void)
{
	Hardware h;
	
	h.PWMSetDutyCycle((BYTE)0);
}

void BackLight::SharpOff (void)
{
  	Hardware h;
	
	h.PWMSetDutyCycle((BYTE)255);
}

void BackLight::initial_hardware (void)
{
	Hardware h;

	h.PWMPortInit();
}

void BackLight::initial_members (void)
{
	fade_mode = FM_On;
	accelerate = 1.1;
}

void BackLight::create_timers (void)
{
	//
}

void BackLight::fade_on (void)
{
	float step,init;
	Hardware h;

	step = -0.4;
	init = 255;

	while (init >= 0)
	{
		step = step * accelerate ;
		OS_Delay(50);
		h.PWMSetDutyCycle((int)init);
		init += step;
	}
	
	SharpOn();
}

void BackLight::fade_off (void)
{
	float step,init;
	Hardware h;

	step=0.4;
	init = 0;

	while (init <= 255)
	{
		step = accelerate * step;
		OS_Delay(50);
		h.PWMSetDutyCycle((int)init);
		init += step;
	}
	
	SharpOff();
}


void BackLight::task_backlight (void)
{
	OS_EnterRegion();

        if (fade_mode == FM_On || fade_mode == FM_OffOnOff)
		fade_on();
	if (fade_mode == FM_Off|| fade_mode == FM_OnOffOn)
		fade_off();
	if (fade_mode == FM_OnOffOn)
		fade_on();
	if (fade_mode == FM_OffOnOff)
		fade_off();

	OS_LeaveRegion();
        OS_Terminate(0);
}



