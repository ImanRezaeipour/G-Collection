#ifndef 	__LED__
#define 	__LED__

#include 	"RTOS.H"
#include	"HRESOURCE.H"

class LED: public HardwareResource
{
public:
	LED();
	~LED();
  
	static void UART0LED (Power P);
	static void UART1LED (Power P);
	static void UART2LED (Power P);
	static void UART3LED (Power P);
	static void KeyLED (Power P);
	static void LANLED (Power P);
	static void FileLED (Power P);  
	static void LiveLED (Power P);
  
	void LiveLED_100ms (void);
	void UART0LED_100ms (void);
	void UART1LED_100ms (void);
	void UART2LED_100ms (void);
	void UART3LED_100ms (void);
	void KeyLED_100ms (void);
	void LANLED_100ms (void);
	void FileLED_100ms (void);
  
	void ToggleLiveLED (void);

private:
  	void initial_hardware (void);
	void initial_members (void);	

	void create_timers (void);

	static void timer_elapse_led_uart0 (void);  
	static void timer_elapse_led_uart1 (void);  
	static void timer_elapse_led_uart2 (void);  
	static void timer_elapse_led_uart3 (void);  
        static void timer_elapse_led_key(void);  
	static void timer_elapse_led_lan(void);  
	static void timer_elapse_led_file(void);  
	static void timer_elapse_led_live(void);  
	
	static unsigned char led_value;
  
	static OS_TIMER timer_led_uart0;
	static OS_TIMER timer_led_uart1;
	static OS_TIMER timer_led_uart2;
	static OS_TIMER timer_led_uart3;
	static OS_TIMER timer_led_key;
	static OS_TIMER timer_led_lan;
	static OS_TIMER timer_led_file;
	static OS_TIMER timer_led_live;
};
#endif
