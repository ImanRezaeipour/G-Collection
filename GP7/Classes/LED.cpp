#include 	"LED.H"
#include 	"DIGITALDATA.H"
#include	"HARDWARE.H"

unsigned char LED::led_value = 0;
  
OS_TIMER LED::timer_led_uart0;
OS_TIMER LED::timer_led_uart1;
OS_TIMER LED::timer_led_uart2;
OS_TIMER LED::timer_led_uart3;
OS_TIMER LED::timer_led_key;
OS_TIMER LED::timer_led_lan;
OS_TIMER LED::timer_led_file;
OS_TIMER LED::timer_led_live;

LED::LED ()
{
	
}

LED::~LED ()
{  
	
}

void LED::UART0LED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(0);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(0);
		led_value = d.GetByte(0);
	} 

	h.SetLED(led_value);
}

void LED::UART1LED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(1);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(1);
		led_value = d.GetByte(0);
	} 
  
	h.SetLED(led_value);
}

void LED::UART2LED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(2);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(2);
		led_value = d.GetByte(0);
	} 

	h.SetLED(led_value);
}

void LED::UART3LED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(3);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(3);
		led_value = d.GetByte(0);
	} 
	
	h.SetLED(led_value);
}

void LED::KeyLED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(4);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(4);
		led_value = d.GetByte(0);
	} 

	h.SetLED(led_value);
}

void LED::LANLED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(5);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(5);
		led_value = d.GetByte(0);
	} 

	h.SetLED(led_value);
}

void LED::FileLED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(6);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(6);
		led_value = d.GetByte(0);
	} 
	
	h.SetLED(led_value);
}

void LED::LiveLED (Power P)
{
	Hardware  h;
	DigitalData d(led_value);

	if (P == On)
	{
		d.RiseBit(7);
		led_value = d.GetByte(0);
	}
	else if (P == Off)
	{
		d.FallBit(7);
		led_value = d.GetByte(0);
	} 
	
	h.SetLED(led_value);
}

void LED::ToggleLiveLED (void)
{
	Hardware h;
	DigitalData d(led_value);

	led_value = d.ToggleBit(7);  
	h.SetLED(led_value); 
}

void LED::UART0LED_100ms (void)
{
	UART0LED(On);
	OS_RetriggerTimer(&timer_led_uart0);
}

void LED::UART1LED_100ms (void)
{
	UART1LED(On);
	OS_RetriggerTimer(&timer_led_uart1);
}

void LED::UART2LED_100ms (void)
{
	UART2LED(On);  
	OS_RetriggerTimer(&timer_led_uart2);
}

void LED::UART3LED_100ms (void)
{
	UART3LED(On);  
	OS_RetriggerTimer(&timer_led_uart3);
}

void LED::KeyLED_100ms (void)
{
	KeyLED(On);
	OS_RetriggerTimer(&timer_led_key);
}

void LED::LANLED_100ms (void)
{
	LANLED(On);
	OS_RetriggerTimer(&timer_led_lan);
}

void LED::FileLED_100ms (void)
{
	FileLED(On);
	OS_RetriggerTimer(&timer_led_file);
}

void LED::LiveLED_100ms (void)
{
	LiveLED(On);
	OS_RetriggerTimer(&timer_led_live);
}

void LED::initial_hardware (void)
{
	Hardware h;

	h.InitLED();   
}

void LED::initial_members (void)
{
	led_value = 0;
}

void LED::create_timers (void)
{
	OS_CreateTimer(&timer_led_uart0, timer_elapse_led_uart0, 100);
	OS_CreateTimer(&timer_led_uart1, timer_elapse_led_uart1, 100);
	OS_CreateTimer(&timer_led_uart2, timer_elapse_led_uart2, 100);
	OS_CreateTimer(&timer_led_uart3, timer_elapse_led_uart3, 100);
	OS_CreateTimer(&timer_led_key, timer_elapse_led_key, 300);
	OS_CreateTimer(&timer_led_lan, timer_elapse_led_lan, 300);
	OS_CreateTimer(&timer_led_file, timer_elapse_led_file, 500);
	OS_CreateTimer(&timer_led_live, timer_elapse_led_live, 100);
}

void LED::timer_elapse_led_uart0 (void)
{
	UART0LED(Off);
}

void LED::timer_elapse_led_uart1 (void)
{
	UART1LED(Off);
}

void LED::timer_elapse_led_uart2 (void)
{
	UART2LED(Off);
}

void LED::timer_elapse_led_uart3 (void)
{
	UART3LED(Off);
}
  
void LED::timer_elapse_led_key (void)
{
	KeyLED(Off);
}
    
void LED::timer_elapse_led_lan (void)
{
	LANLED(Off);
}

void LED::timer_elapse_led_file (void)
{
	FileLED(Off);
}

void LED::timer_elapse_led_live (void)
{
	LiveLED(Off);
}

