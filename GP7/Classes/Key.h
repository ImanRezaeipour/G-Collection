#ifndef 	__KEY__
#define 	__KEY__

#include 	"DATATYPE.H"
#include 	"HARDWARE.H"
#include 	"BUFFER.H"
#include 	"STRING"
#include 	"DEVICE.H"

class Key : public Device
{
public:
	Key ();
	~Key ();
	
  	string GetKeys (void);
	string GetKeys (int FirstLocation,int LastLocation);
	void GetKeys (KeyInfo Info[]);

	static string GetKeyString (int Index);
	static string GetLastKeyString (void);
	
	static KeyInfo GetKey (int Index);
	static KeyInfo GetLastKey (void);

	int GetKeyCount (void);

	static void ClearKeyBuffer (void);
	
	void SetAnyKeyEvent (EventPointer EP);

	void SetOKKeyEvent (EventPointer EP);
	void SetESCKeyEvent (EventPointer EP);
	void SetMenueKeyEvent (EventPointer EP);
	
	void SetNumberKeyEvent (EventPointer EP);
	void SetArrowKeyEvent (EventPointer EP);
	void SetFunctionKeyEvent (EventPointer EP);
	void SetSpecialKeyEvent (EventPointer EP);
	
	void SetF1KeyEvent (EventPointer EP);
	void SetF2KeyEvent (EventPointer EP);
	void SetF3KeyEvent (EventPointer EP);
	void SetF4KeyEvent (EventPointer EP);
	
	void SetUpKeyEvent (EventPointer EP);
	void SetDownKeyEvent (EventPointer EP);
	void SetLeftKeyEvent (EventPointer EP);
	void SetRightKeyEvent (EventPointer EP);
	
	void SetVacationKeyEvent (EventPointer EP);
	void SetExitKeyEvent (EventPointer EP);
	void SetMissionKeyEvent (EventPointer EP);
	void SetEnterKeyEvent (EventPointer EP);
	
	void DisableEvents (void);

private:
	void initial_hardware (void);
	void initial_critical_resources (void);	
	void initial_statuses (void);	
	void initial_members (void);
	void final_initialization (void);	
	void set_enable_flag (bool flag);
	
	void disable_interrupts (void);  	
	void enable_interrupts (void);	
	
	void create_critical_tasks (void);	
	void create_nonecritical_tasks (void);	
	void create_timers (void);
	
	void suspend_nonecritical_tasks (void);
	void resume_nonecritical_tasks (void); 		
	
	void start_timers (void);
	void stop_timers (void);

	static void call_appropriate_event (void);

	static void push_key_to_buffer (enum KeyFunction function, enum KeyStatus status, int num);
	
	static void key_interrupt (void);

	static KeyInfo key_info[50];
  	static int key_count;
	static int MAX_LEN;
	
	static EventPointer ep_any_key_press; 	

	static EventPointer ep_ok_key_press;
	static EventPointer ep_esc_key_press;
	static EventPointer ep_menu_key_press;

	static EventPointer ep_number_key_press;
	static EventPointer ep_arrow_key_press;
	static EventPointer ep_special_key_press;
	static EventPointer ep_function_key_press;

	static EventPointer ep_f1_key_press;
	static EventPointer ep_f2_key_press;
	static EventPointer ep_f3_key_press;
	static EventPointer ep_f4_key_press;
	
	static EventPointer ep_up_key_press;
	static EventPointer ep_down_key_press;
	static EventPointer ep_left_key_press;
	static EventPointer ep_right_key_press;

	static EventPointer ep_vacation_key_press;
	static EventPointer ep_exit_key_press;
	static EventPointer ep_mission_key_press;
	static EventPointer ep_enter_key_press;
	
	static bool enable;
};

#endif