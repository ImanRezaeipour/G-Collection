#ifndef 	__PERSONAL__
#define 	__PERSONAL__

#include 	"DATATYPE.H"
#include 	"RTOS.H"
#include	"STRING"
#include	"MRESOURCE.H"
#include	"FS.H"

struct PersonalSummary
{
	DWORD PersonalDefinedNumbers;
	DWORD CardDefinedNumbers;
	DWORD FingerDefinedNumbers;
};

enum PersonalMessage
{
	PM_None = 0,
	PM_NormalEnter,
        PM_Enter,
	PM_Exit,
	PM_Mission,
	PM_Vacation,
	PM_InvalidPersonal,
	PM_ErrorWhileSave,
        PM_ErrorCardFirst,
	PM_HasNotFinger,
	PM_PlaceFinger,
	PM_TimeOut,
	PM_CardRepetitive,
	PM_InvalidFinger
};	

enum PersonalTaskIdentifier
{
	PTI_None = 0,
	PTI_IsPersonExist,
	PTI_GetPersonInformation,
	PTI_AddPerson,
	PTI_EditPerson,
	PTI_DeletePerson,
	PTI_DeleteAllPerson,
        PTI_DeleteAllRecords,
	PTI_HandleCard,
	PTI_HandleFinger,
	PTI_HandleKey,
	PTI_InternalSave,
	PTI_IsAdminFingerID,
        PTI_IsCardRepetitive,
        PTI_IsCardRepetitiveEx
};

enum DeviceSequence
{
	DS_Key = 1,
	DS_Finger,
	DS_Card
};
	
struct PersonInformation
{
	DWORD PersonNumber;
	DWORD Password;
	DWORD FingerID;
	DWORD CardID;
	BYTE PIS;
	BYTE PAR;
	BYTE FingerTemplateNumber;
};

struct TrafficInformation
{
        DWORD DT;
	DWORD PN;
	BYTE PIS;
	BYTE PC;
};

struct IDPerson
{
	DWORD ID;
	DWORD PersonNumber;	
};

class Personal : public MiddlewareResource
{
public:
	Personal ();
	~Personal ();
	
	void PersonIsExist (DWORD PersonNumber);
	void GetPersonInformation (DWORD PersonNumber);

	void AddPerson (PersonInformation NewPI);
	void EditPerson (PersonInformation NewPI);
	void DeletePerson (DWORD PersonNumber);
	
	void DeleteAllPerson (void);

        void DeleteAllRecords (void);
	
	//void GetLastPersonNumber (void);
	
	//void GetPersonalSummary (void);

        void IsCardRepetitive (DWORD CardID);
        void IsCardRepetitiveEx (DWORD CardID);
	
	void SetLastPersonNumberEvent (void (*)(DWORD));

	void HandleCard (DWORD CardID, PreCard PC, MifareType Type);
	void HandleFinger (DWORD FingerID, PreCard PC);
	void HandleKey (DWORD KeyID, PreCard PC);
	
	void IsAdministratorFinger (DWORD FingerID);
	
	//void SetPersonInformationRequestEvent (void (*) (PersonalSummary PS));
	void SetPersonInformationRequestEvent (void (*) (PersonInformation* PI));
	void SetPersonExistEvent (EventPointer EP);
	void SetPersonIsNotExistEvent (EventPointer EP);	
	void SetPersonAddSuccessEvent (EventPointer EP);
	void SetPersonAddFailEvent (EventPointer EP);
	void SetPersonEditSuccessEvent (EventPointer EP);
	void SetPersonEditFailEvent (EventPointer EP);
	void SetPersonDeleteSuccessEvent (EventPointer EP);
	void SetPersonDeleteFailEvent (EventPointer EP);
	void SetAllPersonDeleteSuccessEvent (EventPointer EP);
	void SetAllPersonDeleteFailEvent (EventPointer EP);
	void SetSaveTrafficEvent (void (*EP)(TrafficInformation *));
	void SetTimeoutInputEvent (EventPointer EP);
	void SetValidAdministratorFingerIDEvent (EventPointer EP);
        void SetDeleteRecordsEvent (EventPointer EP);
	void SetRepetitiveCardIDEvent (EventPointer EP);
        void SetUniqueCardIDEvent (EventPointer EP);
         void SetUniqueCardIDEventEx (EventPointer EP);
        static bool IsUserExit (DWORD PersonNumber);
        static bool IsCardRepet (DWORD CardID);
        static bool AddPersonInfo (PersonInformation NewPI);
        static bool DeleteUser (DWORD PersonNumber);
        static bool DeleteAllUser (void);
	
	void DisableEvents (void);
	
	void StopTimers (void);
        
        static bool create_file (char file_path[], char file_name[]);
	static bool append (char file_path[], char file_name[], const BYTE *data, DWORD size);
        
        static PersonInformation get_person_information (DWORD person_number);
private:
	void initial_members (void);	
	
	void create_timers (void);
	
	static bool is_file_exist (char file_path[], char file_name[]);
	static DWORD get_records_count (char file_path[], char file_name[], int record_length);
	static SearchHit search (char file_path[], char file_name[], DWORD desire_data, int record_length);
	static bool copy_file_section (char source_file_path[], char source_file_name[], char destination_file_path[], char destination_file_name[], DWORD first_record_index_on_source_file, DWORD records_count, DWORD record_lenght);

	static void create_directory (char file_path[40]);
	
	static bool insert_record (char file_path[], char file_name[], char backup_file_name[], const DWORD index, const BYTE * Data, const DWORD size);
	static bool edit_record (char file_path[], char file_name[], char backup_file_name[], const DWORD index, const BYTE * Data, const DWORD size);
	static bool delete_record (char file_path[], char file_name[], char backup_file_name[], const DWORD index, const DWORD size);
	static void save_traffic (TrafficInformation ti);
		
	/*static void task_is_person_exist (void * PN);
	static void task_get_person_information (void * PN);
	static void task_add_person (void * PI);
	static void task_edit_person (void * PI);
	static void task_delete_person (void * PI);
	static void task_delete_all_peron (void);
	static void task_get_last_person (void);
	static void task_handle_card (void * ci);	
	static void task_handle_finger (void * fi);	
	static void task_handle_key (void * ki);	
	static void task_internal_save (void);
	static void task_is_admin_finger (void *fi);*/
	
	static void task_main (void *in);
	static void task_get_person_information (void * in);

	static void timer_elapse_save (void);

  	static void E_valid_finger (void);
	static void E_invalid_finger (void);
	
	static string get_appropriate_message (PersonalMessage index, Language l);
	
	/*static OS_STACKPTR int stack_person_exist[650];
	static OS_STACKPTR int stack_get_person_information[400];
	static OS_STACKPTR int stack_add_person[350];
	static OS_STACKPTR int stack_edit_person[350];
	static OS_STACKPTR int stack_delete_person[350];
	static OS_STACKPTR int stack_delete_all_person[350];
	//static OS_STACKPTR int stack_get_last_person[256];	
	static OS_STACKPTR int stack_handle_card[450];	
	static OS_STACKPTR int stack_handle_finger[450];	
	static OS_STACKPTR int stack_handle_key[450];	
	static OS_STACKPTR int stack_internal_save[400];	
	static OS_STACKPTR int stack_is_admin_finger[450];	
	
	static OS_TASK tcb_person_exist;
	static OS_TASK tcb_get_person_information;
	static OS_TASK tcb_add_person;
	static OS_TASK tcb_edit_person;
	static OS_TASK tcb_delete_person;
	static OS_TASK tcb_delete_all_person;
	//static OS_TASK tcb_get_last_person;	
	static OS_TASK tcb_handle_card;	
	static OS_TASK tcb_handle_finger;
	static OS_TASK tcb_handle_key;
	static OS_TASK tcb_internal_save;
	static OS_TASK tcb_is_admin_finger;*/
	
	static OS_STACKPTR int stack_main_task[900];	
	static OS_STACKPTR int stack_get_person_information_task[700];	
	
	static OS_TASK tcb_main_task;
	static OS_TASK tcb_get_person_information_task;
	
	static EventPointer ep_person_exist;
	static EventPointer ep_person_not_exist;
	static EventPointer ep_person_add_success;
	static EventPointer ep_person_add_fail;
	static EventPointer ep_person_edit_success;
	static EventPointer ep_person_edit_fail;
	static EventPointer ep_person_delete_success;
	static EventPointer ep_person_delete_fail;
	static EventPointer ep_person_delete_all_success;
	static EventPointer ep_person_delete_all_fail;
	static void (*ep_save_success)(TrafficInformation *);
	static EventPointer ep_time_out_input;
	static EventPointer ep_valid_admin_finger;
	static EventPointer ep_records_delete_success;
        static EventPointer ep_card_is_unique;
        static EventPointer ep_card_is_unique_ex;
	static EventPointer ep_card_is_repetitive;
	
        static void (*ep_get_person_information) (PersonInformation *PI);
	static void (*ep_get_last_personal) (DWORD);
	
	static const BYTE MasterFileRecordLength;
	static const BYTE FingerFileRecordLength;
	static const BYTE CardFileRecordLength;
	
	static DeviceSequence first_device_sequence;
	static DeviceSequence second_device_sequence;
		
	static OS_TIMER timer_save;
	static TrafficInformation ti;
	
	static PersonalTaskIdentifier pti;
	
	static PreCard person_pre_card;
        
        static MifareType mifareType;
};

#endif
