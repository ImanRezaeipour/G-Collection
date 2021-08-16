#ifndef 	__MENU__
#define		__MENU__

#include	"RTOS.H"
#include	"MRESOURCE.H"
#include	"STRING"
#include	"BUFFER.H"
#include 	"PERSONAL.H"
//#include        "COMMUNICATIONPACKET.H"
#include        "COM.h"

enum FixMessage
{
	FM_None = 0,
	FM_EnterPassword,
	FM_IncorrectPassword,
	FM_CurrentDate,
	FM_NewDate,
	FM_CurrentTime,
	FM_NewTime,
	FM_TimeAdjustSuceess,
	FM_TimeAdjustFail,
	FM_DateAdjustSuceess,
	FM_DateAdjustFail,
	FM_ChangePassword,
	FM_CurrentIP,
	FM_NewIP,
	FM_CurrentPort,
	FM_NewPort,
	FM_IPAdjustSuccess,
	FM_IPAdjustFail,
	FM_PortAdjustSuccess,       
	FM_PortAdjustFail,          
        FM_ModemInitSuccess,            //d.k
        FM_ModemInitFail,               //d.k
	FM_EnterPersonalNumber,
	FM_TrafficMode,
	FM_PNORCardANDFinger,
        FM_CardANDFinger,
	FM_CardOrFinger,
	FM_DeviceMode,
	FM_AccessRight,
	FM_User,
	FM_Administrator,
	FM_Password,
	FM_Card,
	FM_Finger,
	FM_TemplateCount,
	FM_Repetitive,
	FM_PlaceAgain,
	FM_Place,
	FM_Register,
	FM_NotRegister,
	FM_RepetitivePersonalNumber,
	FM_PersonAddSuccessfully,
	FM_PersonAddFail,
	FM_PersonEditSuccessfully,
	FM_PersonEditFail,
	FM_InvalidPersonalNumber,
	FM_DeleteUser,
	FM_DeleteAllUser,
	FM_Yes,
	FM_UserDeleteSuccess,
	FM_DeleteFail,
	FM_AllUserDeleteSuccess,
	FM_AllUserDeleteFail,
	FM_ChooseDeviceMode,
	FM_FingerActivity,
	FM_Enable,
	FM_Disable,
	FM_DeviceModeChangeSuccess,
	FM_DeviceModeChangeFail,
	FM_FMActivityChangeSuccess,
	FM_FMActivityChangeFail,
	FM_PreCard,
	FM_PreCardChangeSuccess,
	FM_PreCardChangeFail,
        FM_Normal,
        FM_Enter,
	FM_Exit,
	FM_Mission,
	FM_ChangePasswordFail,
	FM_ChangePasswordSuccess,
        FM_CurrentID,
        FM_NewID,
        FM_RestoreFactorySettings,
        FM_CurrentMask,
        FM_NewMask,
        FM_DeleteAllTraffics,
        FM_DeleteAllTrafficsuccess,
        FM_DeviceIDAdjustSuccess,
        FM_FactorySettingsLoadSuccess,
        FM_SubnetMaskAdjustSuccess,
        FM_DeviceIDAdjustFail,
        FM_FactorySettingsLoadFail,
        FM_SubnetMaskAdjustFail, 
        FM_EditFingers
};	

enum MenuIndex
{
	MI_None = 0,
	MI_WaitForPassword ,
	MI_MainMenu,
	MI_BaseSetting,
	MI_LANSetting,
	MI_PersonalSetting,
	MI_DeviceSetting,
        MI_SetDateTime,
	MI_SetDate,
	MI_SetTime,
	MI_ChangePassword,
        MI_SetDeviceID,
        MI_SetFactorySettings,
	MI_SetAddress,
	MI_SetPort, 
        MI_SetServerIP,
        MI_SetIP,
        MI_SetSubnetMask,
        MI_SetGateway,
        MI_InitModem,
	MI_AddPerson,
	MI_EditPerson,
	MI_DeletePerson,
	MI_DeleteAllPerson,	
	MI_DeviceMode,
	MI_FMActivity,
	MI_DevicePreCard,
        MI_DeleteTraffics
};

struct MenuCharacteristic
{
	MenuIndex FirstChild;
	MenuIndex Parent;
	MenuIndex NextMenu;
	MenuIndex PreviousMenu;
};

class Menu : public MiddlewareResource
{
public:
	Menu();
	~Menu();
	
	void Show (void);
	
	void SetExitMenuEvent (EventPointer EP);	

	void DisableEvents (void);	
	
	void StopTimers (void);

        static bool is_OK;
private:
	void initial_members (void);	
        
      	void create_timers (void);
	
        static void initial_modem_task  (void);
        static bool RecievePacket_modem_true  (string AT_string);
        static bool Send_ATcommand_Modem (Modem_ATcommand  AT_CMD);
        
	static void timer_elapse_menu (void);
	static void timer_elapse_message (void);
	static void timer_elapse_second (void);
	static void timer_elapse_special (void);
	
	static void show_message (FixMessage index, Language l);	
	
	static void key_process (void);
	static void command_process (void);
	static void command_cancel (void);
	
	static void command_execute_successfully (void);
	static void command_execute_fail (void);
	
	static void init_members_for_next_command (void);

	static void menu_handler (void);
	static void show_context (void);

	static void draw_menu (void);

	static MenuCharacteristic get_menu_characteristic (MenuIndex index);
	
	static string get_appropriate_message (FixMessage index, Language l);
	static string get_menu_title (MenuIndex index, Language l);
	
	static void person_edit_success (void);
	static void person_edit_fail (void);
	static void person_add_success (void);
	static void person_add_fail (void);
	static void person_is_exist (void);
	static void person_is_not_exist (void);
	static void last_person_number (DWORD PN);
	static void enroll_success (DWORD UserID);
        static void enroll_fail (void);
	static void idenfify_success (DWORD UserID);
	static void identify_fail (void);
	static void first_template_scan_success (void);
	static void person_information_receive (PersonInformation* PI);
	static void delete_person_success (void);
	static void delete_person_fail (void);
	static void delete_all_person_success (void);
	static void delete_all_person_fail (void);
        static void delete_template_success (void);
	static void delete_template_fail (void);
	static void delete_all_templates_success (void);
	static void delete_all_templates_fail (void);
	static void valid_admin_finger (void);
	static void delete_records_success (void);
        static void card_is_repetitive (void);
        static void card_is_unique (void);
        static void card_is_unique_ex (void);
        static void cancel_success (void);
        static void Err_Recieve_Finger(void);

	static void card_present (void);
        static void card_present_ex (void);
	
        static void finger_is_repetitive (void);
        
	static OS_TIMER timer_menu;
	static OS_TIMER timer_message;
	static OS_TIMER timer_second;	
	static OS_TIMER timer_special;	

        static DWORD last_card_id;

	static EventPointer ep_exit_menu;
	
	static enum MenuIndex menu_index;
	static enum MenuIndex highlighted_menu;
		
	static int sub_menu_temp_index;
	static PersonInformation pi;
	static Buffer keypad_data;
	static int sub_menu_index;
	//static bool delete_old_templates;
        
        static CommunicationPacket receive_packet;
        static OS_STACKPTR int stack_Modem[256];
  	static OS_TASK tcb_Modem;
        
        static int is_f1_pressed; // 1-> F1 pressed, 2-> F1 is pressed and ECS from Menu, 0-> none
};
#endif