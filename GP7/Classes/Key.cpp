#include 	"KEY.H"
#include 	"SOUND.H"
#include 	"LED.H"
#include 	"NOTIFY.H"
#include	"UTILITY.H"
#include 	"DIGITALDATA.H"
#include	"MATH.H"
#include        "BEEP.H"

KeyInfo Key::key_info[50];
int Key::key_count;
int Key::MAX_LEN = 50;

EventPointer Key::ep_any_key_press; 	

EventPointer Key::ep_ok_key_press;
EventPointer Key::ep_esc_key_press;
EventPointer Key::ep_menu_key_press;

EventPointer Key::ep_number_key_press;
EventPointer Key::ep_arrow_key_press;
EventPointer Key::ep_special_key_press;
EventPointer Key::ep_function_key_press;

EventPointer Key::ep_f1_key_press;
EventPointer Key::ep_f2_key_press;
EventPointer Key::ep_f3_key_press;
EventPointer Key::ep_f4_key_press;
	
EventPointer Key::ep_up_key_press;
EventPointer Key::ep_down_key_press;
EventPointer Key::ep_left_key_press;
EventPointer Key::ep_right_key_press;

EventPointer Key::ep_vacation_key_press;
EventPointer Key::ep_exit_key_press;
EventPointer Key::ep_mission_key_press;
EventPointer Key::ep_enter_key_press;

bool Key::enable = false;

Key::Key ()
{
	
}

Key::~Key ()
{

}

string Key::GetKeys (void)
{
	return GetKeys(0,key_count-1);
}

string Key::GetKeys (int FirstLocation, int LastLocation)
{
	if (FirstLocation<0)
		return "KeyError";

	if (LastLocation>= key_count)
		return "KeyError";

	string str;
	int ctr;	
	str.clear();

	for (ctr=FirstLocation;ctr<=LastLocation;ctr++)
		str+=GetKeyString(ctr);

	return str;
}

void Key::GetKeys (KeyInfo Info[])
{
	int ctr;

	for(ctr=0;ctr<key_count;ctr++)
		Info[ctr]=key_info[ctr];
}

string Key::GetKeyString (int Index)
{
  	KeyInfo temp;
  	string str;

  	str.clear();

  	if (Index >= key_count)
    		return "";

  	temp = key_info[Index];

	if (temp.Function == KF_Number)
		str+=Utility::ToChar(temp.Num);
	
	return str;
}

string Key::GetLastKeyString (void)
{
  	return GetKeyString(key_count-1);
}

KeyInfo Key::GetKey (int Index)
{
  	KeyInfo temp;
	temp.Function = KF_None;
	temp.Status = KS_None;
	temp.Num = 0;

	if (Index >= key_count)
		return temp;
	
  	return key_info[Index];
}

KeyInfo Key::GetLastKey (void)
{
	return GetKey(key_count-1);
}

int Key::GetKeyCount (void)
{
	return key_count;
}

void Key::ClearKeyBuffer(void)
{
  	int ctr;

	for(ctr=0;ctr<MAX_LEN;ctr++)
	{
		key_info[ctr].Function = KF_None;
		key_info[ctr].Status = KS_None;
		key_info[ctr].Num=0;
	}

	key_count = 0;
}

void Key::SetAnyKeyEvent (EventPointer EP)
{
	ep_any_key_press = EP;
}

void Key::SetOKKeyEvent (EventPointer EP)
{
	ep_ok_key_press = EP;	
}

void Key::SetESCKeyEvent (EventPointer EP)
{
	ep_esc_key_press = EP;
}

void Key::SetMenueKeyEvent (EventPointer EP)
{
	ep_menu_key_press = EP;
}		
	
void Key::SetNumberKeyEvent (EventPointer EP)
{
	ep_number_key_press = EP;
}

void Key::SetArrowKeyEvent (EventPointer EP)
{
	ep_arrow_key_press = EP;
}

void Key::SetFunctionKeyEvent (EventPointer EP)
{
	ep_function_key_press = EP;
}

void Key::SetSpecialKeyEvent (EventPointer EP)
{
	ep_special_key_press = EP;
}

void Key::SetF1KeyEvent (EventPointer EP)
{
	ep_f1_key_press = EP;
}

void Key::SetF2KeyEvent (EventPointer EP)
{
	ep_f2_key_press = EP;	
}

void Key::SetF3KeyEvent (EventPointer EP)
{
	ep_f3_key_press = EP;	
}

void Key::SetF4KeyEvent (EventPointer EP)
{
	ep_f4_key_press = EP;	
}
	
void Key::SetUpKeyEvent (EventPointer EP)
{
	ep_up_key_press = EP;
}

void Key::SetDownKeyEvent (EventPointer EP)
{
	ep_down_key_press = EP;
}

void Key::SetLeftKeyEvent (EventPointer EP)
{
	ep_left_key_press = EP;
}

void Key::SetRightKeyEvent (EventPointer EP)
{
	ep_right_key_press = EP;
}

void Key::SetVacationKeyEvent (EventPointer EP)
{
	ep_vacation_key_press = EP;
}

void Key::SetExitKeyEvent (EventPointer EP)
{
	ep_exit_key_press = EP;
}

void Key::SetMissionKeyEvent (EventPointer EP)
{
	ep_mission_key_press = EP;
}

void Key::SetEnterKeyEvent (EventPointer EP)
{
	ep_enter_key_press = EP;
}

void Key::DisableEvents (void)
{	
	ep_any_key_press = NULL; 	

	ep_ok_key_press = NULL;
	ep_esc_key_press = NULL;
	ep_menu_key_press = NULL;

	ep_number_key_press = NULL;
	ep_arrow_key_press = NULL;
	ep_special_key_press = NULL;
	ep_function_key_press = NULL;

	ep_f1_key_press = NULL;
	ep_f2_key_press = NULL;
	ep_f3_key_press = NULL;
	ep_f4_key_press = NULL;
	
	ep_up_key_press = NULL;
	ep_down_key_press = NULL;
	ep_left_key_press = NULL;
	ep_right_key_press = NULL;

	ep_vacation_key_press = NULL;
	ep_exit_key_press = NULL;
	ep_mission_key_press = NULL;
	ep_enter_key_press = NULL;
}

void Key::initial_hardware (void)
{
	Hardware  h;

	h.InitKeyPins();
	h.SetPinsInterrupt(key_interrupt);
	h.EnableKeyInterrupt();	
}

void Key::initial_critical_resources (void)
{
	//
}

void Key::initial_statuses (void)
{
	//	
}

void Key::initial_members (void)
{	
	ClearKeyBuffer();
	key_count = 0;		
}

void Key::final_initialization (void)
{
	
}	

void Key::set_enable_flag (bool flag)
{
	enable = flag;
}

void Key::disable_interrupts (void)
{
	Hardware h;
	h.DisableKeyInterrupt();
}

void Key::enable_interrupts (void)
{
	Hardware h;
	h.EnableKeyInterrupt();  	
}

void Key::create_critical_tasks (void)
{
	//	
}

void Key::create_nonecritical_tasks (void)
{
	//
}

void Key::create_timers (void)
{
	//
}

void Key::suspend_nonecritical_tasks (void)
{
	//
}

void Key::resume_nonecritical_tasks (void)
{
	//
}

void Key::start_timers (void)
{
	//
}

void Key::stop_timers (void)
{
	//
}

void Key::call_appropriate_event (void)
{
	KeyInfo last_key;
	
	last_key = GetLastKey();

	safe_call_handler(ep_any_key_press);

	if (last_key.Function == KF_OK)
		safe_call_handler(ep_ok_key_press);
	
	if (last_key.Function == KF_ESC)
		safe_call_handler(ep_esc_key_press);
	
	if (last_key.Function == KF_Menu)
		safe_call_handler(ep_menu_key_press);
		
	if (last_key.Function == KF_Number)
		safe_call_handler(ep_number_key_press);

  	if (last_key.Function == KF_Function)
	{
		safe_call_handler(ep_function_key_press);
		
		switch (last_key.Num)
		{
		case 1:
			safe_call_handler(ep_f1_key_press);
			break;
			
		case 2:
			safe_call_handler(ep_f2_key_press);
			break;
			
		case 3:
			safe_call_handler(ep_f3_key_press);
			break;
			
		case 4:
			safe_call_handler(ep_f4_key_press);
			break;
		}
	}

  	if (last_key.Function == KF_Arrow)
	{
		safe_call_handler(ep_arrow_key_press);
		
		switch (last_key.Status)
		{
		case KS_Up:
			safe_call_handler(ep_up_key_press);
			break;
			
		case KS_Down:
			safe_call_handler(ep_down_key_press);
			break;
			
		case KS_Left:
			safe_call_handler(ep_left_key_press);
			break;
			
		case KS_Right:
			safe_call_handler(ep_right_key_press);
			break;
		}
	}
			
  	if (last_key.Function == KF_Special)
	{
		safe_call_handler(ep_special_key_press);
		
		switch (last_key.Status)
		{
		case KS_Vacation:
			safe_call_handler(ep_vacation_key_press);
			break;
			
		case KS_Exit:
			safe_call_handler(ep_exit_key_press);
			break;
			
		case KS_Mission:
			safe_call_handler(ep_mission_key_press);
			break;
			
		case KS_Enter:
			safe_call_handler(ep_enter_key_press);
			break;
		}
	}
}

void Key::push_key_to_buffer (enum KeyFunction function, enum KeyStatus status, int num)
{
	if (key_count >= MAX_LEN)
		return;
	
	key_info[key_count].Function = function;
	key_info[key_count].Status = status;
	key_info[key_count].Num = num;

	key_count++;
}

void Key::key_interrupt(void)
{
	Beep b;
       
        OS_EnterInterrupt();
        OS_DI();
        //b.DoBeep(50);
        WORD col, row;
	Hardware h;
	BOOL invalid_key;
	DigitalData d;  	

        invalid_key = false;

	h.DisableKeyInterrupt();
        
	d.SetWord(0, h.GetPhysicalKey());
        
	row = d.GetByte(0);
	col = d.GetByte(1);

	if (row == 0 && col == 0)
	{
		h.KeyClearInterrupt();
		h.EnableKeyInterrupt();
                OS_EI();
                OS_LeaveInterrupt();
		return;
	}
	
	else if (row == 16 && col == 4)
		push_key_to_buffer(KF_OK, KS_None, 0);
	
	else if (row == 8 && col == 1)
		push_key_to_buffer(KF_ESC, KS_None, 0);
	
	else if (row == 8 && col == 4)
		push_key_to_buffer(KF_Menu, KS_None, 0);
	
	else if (col == 8 && row <= 8)
		push_key_to_buffer(KF_Function, KS_None, 1 + int(log((float)row)/log(2.0)));
	
	else if (col == 16 && row<=8)
	{
		switch (row)
		{
		case 1:
			push_key_to_buffer(KF_Special, KS_Enter, 0);
			break;

		case 2:
			push_key_to_buffer(KF_Special, KS_Vacation, 0);
			break;

		case 4:
			push_key_to_buffer(KF_Special, KS_Exit, 0);
			break;
		
		case 8:
			push_key_to_buffer(KF_Special, KS_Mission, 0);
			break;
		}
	}

	else if (row == 16)
	{
		switch (col)
		{
		case 1:
			push_key_to_buffer(KF_Arrow, KS_Left, 0);
			break;

		case 2:
			push_key_to_buffer(KF_Arrow, KS_Down, 0);
			break;

		case 8:
			push_key_to_buffer(KF_Arrow, KS_Right, 0);
			break;
		
		case 16:
			push_key_to_buffer(KF_Arrow, KS_Up, 0);
			break;
		}
	}	
	
	else if (col == 2 && row == 8)
		push_key_to_buffer(KF_Number, KS_None, 0);
	
	else if (col <= 4 && row <= 4)
		push_key_to_buffer(KF_Number, KS_None, 1 + 3*int(log((float)row)/log(2.0)) + int(log((float)col)/log(2.0)));
	
	else
		invalid_key = true;
	
	if (invalid_key)
	{
		h.KeyClearInterrupt();
		h.EnableKeyInterrupt();
                OS_EI();
                OS_LeaveInterrupt();
		return;
	}

	//Sound s;
	//s.PlayKey();
        b.DoBeepWithoutTask(50);

	LED l;
	l.KeyLED_100ms();
	
	call_appropriate_event();

	h.KeyClearInterrupt();
        
	OS_EI();
        
        d.SetWord(0, h.GetPhysicalKey());
        
	while(row == d.GetByte(0))
          d.SetWord(0, h.GetPhysicalKey());
        
	h.EnableKeyInterrupt();
        
        OS_LeaveInterrupt();
}


