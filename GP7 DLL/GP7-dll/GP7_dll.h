
#include <WinSock2.h>
#include <string>

typedef enum
{
	None,
	Serial,
	Ethernet,
	Usb
}HandlePort;

enum PersonalIdentifyScenario
{
	PIS_None =0,
    PIS_CardOrFinger,
	PIS_FingerOnly,
	PIS_PersonalNumberORCardAndFinger,
	PIS_CardAndFinger,
	PIS_PersonalNumberANDFinger,
	PIS_DeviceMode
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

enum PreCard
{
	PC_None = -1,
    PC_NormalEnter=0,
    PC_Enter = 4,
	PC_Exit = 5,
	PC_Vacation = 21,
	PC_Mission = 51
};

//typedef struct
//{
//	unsigned int DateTime;
//	unsigned int UserID;
//	BYTE  PIS;			//PersonalIdentifyScenario
//	BYTE  PC;			//PreCard
//}TrafficRecord;			//10 BYTE

typedef struct
{
	unsigned int UserID;
	BYTE  PIS;			//PersonalIdentifyScenario
	BYTE  PC;			//PreCard
	BYTE  DateTime[7];
}TrafficRecord;				//13 BYTE

typedef struct
{
	BYTE Template[512];
}FingerTemplate;

enum CommunicationFlag
{
        CF_None = 0,
        CF_DeviceIsBusy,
        CF_PacketError,
        CF_CommandExecuteSuccessfully,
        CF_CommandExecuteFail,
        CF_ReceiveTimeout,
        CF_CollectionFinish,
        CF_CollectionError,
        CF_CollectionAcknowledge,
        CF_CardIsRepetitive,
        CF_FingerIsRepetitive,
        CF_PersonIsRepetitive
};

enum COMMCommand
{
        CC_SetTime = 1,
        CC_SetDate,
        CC_GetTime,
        CC_GetDate,
        CC_SetDeviceMode,
        CC_GetDeviceMode,
        CC_SetFingerFreeScan,
        CC_GetFingerFreeScan,
        CC_SetPreCard,
        CC_GetPreCard,
        CC_DeleteAllRecords,
        CC_Collect,
        CC_TestConnect,
        CC_GetPersonalCnt,
        CC_GetPersonalFile,
        CC_SetPersonalFile,
        CC_DeletePersonalFile,
        CC_GetFingerCnt,
        CC_GetFingerFile,
        CC_SetFingerFile,
        CC_DeleteFingerFile,
        CC_GetCardCnt,
        CC_GetCardFile,
        CC_SetCardFile,
        CC_DeleteCardFile,
        CC_EnableFingerTemplateMode,
        CC_EnablePeripheral,
        CC_DisablePeripheral,
        CC_SetPersonInfo,
        CC_GetPersonInfo,
		CC_DeletePerson,
        CC_DeleteAllPerson,
        CC_SetUniqueCode = 202
};

#define d_OK	0
#define d_Err	-1
#define FP_size		388

//class GP
//{
//private:
	int		str_len(BYTE* str);
	void	SetCommand (BYTE Command);
	void	SetConditionBits(BYTE chr);
	void	SetErrFlag(BYTE Err);
	void	SetFrameNumber (int PacketNumber);
	void	SetDestinationID (int DestinationID);
	void	SetExtraData (int EXData);
	void	SetExtraData (BYTE* EXData);
	void	SetData (BYTE* Data);
	void	SetData (BYTE* Data, int len);
	void	SetNotData (void);
	BYTE	GetCommand (void);
	int		GetFrameNumber (void);
	int		GetSourceID (void);
	BYTE	GetError (void);
	int		GetExtraData (void);
	void	GetExtraData (BYTE* str);
	char	GetDataLength (void);
	void	GetData(BYTE* str, int DataLength);
	void	GetData(BYTE* str);
	void	Clear(char* Str);
	void	Clear(BYTE* Str);
	void	Clear(char* Str, int Size);
	void	Clear(BYTE* Str, int Size);
	bool	IsValid (void);
	int		Str_toInt(BYTE* str);
	void	Int_toStr(BYTE* str,DWORD in);
	void	Int_toStr(BYTE* str,int in);
	BYTE	Make_BCC(int first_location, int last_location);
	void	Make_Packet(void);
	bool	Send_Command(int Handle);
	void	GetRealDateTime (BYTE* DateTime, DWORD JulianDay);
	DWORD	GetPackedDateTime (BYTE* DT);
	void	StrToPacketDateTime(BYTE* inDateTime, BYTE* outDateTime, char Splite);
	//char	operator[](int i);
	//void	operator+ (BYTE byte);
	//void	operator+ (char byte);
	//void	operator+ (char* S);
	BYTE	STX = 0x50;
	BYTE	ETX = 0x0A;
	BYTE	Packet[128];
	int		MaxSizePacket = 128;
	SOCKET  clientSock;
//public:
//	GP();
//	~GP();

	bool APIENTRY  Test_Connect(int Handle, int DeviceID);
	int  APIENTRY  Open_Serial(char* Port, int Buadrate, int& Handle);
	void APIENTRY  Close_Serial(int Handle);
	int  APIENTRY  Open_Ehternet(char* IP, int Port, int& Handle);
	void APIENTRY  Close_Ehternet(int Handle);
	int  APIENTRY  Open_Usb(int& Handle);
	void APIENTRY  Close_Usb(int Handle);
	void APIENTRY  CLOSE(int Handle);
	void APIENTRY  ConvertToShamsi (char* Date);
	bool APIENTRY  Set_Time(int Handle, char* Time, int DeviceID);
	bool APIENTRY  Get_Time(int Handle, char* Time, int DeviceID);
	bool APIENTRY  Set_Date(int Handle, char* Date, int DeviceID);
	bool APIENTRY  Get_Date(int Handle, char* Date, int DeviceID);
	bool APIENTRY  Set_DeviceMode(int Handle, int Mode, int DeviceID);
	bool APIENTRY  Get_DeviceMode(int Handle, int* Mode, int DeviceID);
	bool APIENTRY  Set_FingerActivity(int Handle, bool ON, int DeviceID);
	bool APIENTRY  Get_DeviceMode(int Handle, bool* ON, int DeviceID);
	bool APIENTRY  Set_PreCard(int Handle, int PreCard, int DeviceID);
	bool APIENTRY  Get_PreCard(int Handle, int* PreCard, int DeviceID);
	int  APIENTRY  Collect_Record(int Handle, char* fromDate, char* toDate, char* fromTime, char* toTime, int DeviceID, TrafficRecord* TF);
	int  APIENTRY  Get_UserInfo(int Handle, int DeviceID, PersonInformation &PI, FingerTemplate* FingerPrintTemplate);
	CommunicationFlag APIENTRY  Enroll_User(int Handle, int DeviceID, PersonInformation PI, FingerTemplate* FingerPrintTemplate, int NumOfFPtemplate);
	bool APIENTRY  Delete_Person(int Handle, unsigned int UserID, int DeviceID);
	bool APIENTRY  Delete_AllPerson(int Handle, int DeviceID);
	int  APIENTRY  Get_NumPerson(int Handle, int DeviceID);
	int  APIENTRY  Get_AllPerson(int Handle, int DeviceID, PersonInformation *PI);
//};