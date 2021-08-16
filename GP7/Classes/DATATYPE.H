#ifndef 	__TYPE__
#define 	__TYPE__

#include	"RTOS.H"
#define         REM130

typedef OS_STACKPTR int	OS_STACK;

typedef unsigned char BOOL;
typedef unsigned char BYTE ;
typedef unsigned short int WORD ;
typedef unsigned long int DWORD ;

//id  (Event) void;
typedef void  (*EventPointer)(void);
typedef void  (*TaskRoutine)(void);

typedef struct                         //D.K
{
        bool Barcode;
        bool Finger;
        bool Mifare;
        bool GP8;
}TypeOfReader;

enum PacketSize
{
	PacketSizeIdle = 17
};	

enum PersonalAccessRight
{
	PAR_None = 0,
        PAR_Administrator,
	PAR_SpecialUser,
	PAR_User
};	

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

enum PreCard
{
	PC_None = -1,
        PC_NormalEnter=0,
        PC_Enter = 4,
	PC_Exit = 5,
	PC_Vacation = 21,
	PC_Mission = 51
};

enum MifareType
{
	MT_None = 0,
        MT_Internal,
        MT_Exernal
};

typedef struct {
    BYTE RTC_Sec;     /* Second value - [0,59] */
    BYTE RTC_Min;     /* Minute value - [0,59] */
    BYTE RTC_Hour;    /* Hour value - [0,23] */
    BYTE RTC_Mday;    /* Day of the month value - [1,31] */
    BYTE RTC_Mon;     /* Month value - [1,12] */
    WORD RTC_Year;    /* Year value - [0,4095] */
    BYTE RTC_Wday;    /* Day of week value - [0,6] */
    WORD RTC_Yday;    /* Day of year value - [1,365] */
} RTCTime;

enum Activity
{
	A_Disable = 0,
	A_Enable
};

typedef struct {
	Activity FingerFreeScanActivity;
	Activity FingerActivity;
	Activity MifareActivity;
	Activity KeyActivity;
	Activity SoundActivity;
	Activity FirstDailyAlarmActivity;
	Activity SecondDailyAlarmActivity;
	Activity SpecialAlarmActivity;
	RTCTime FirstDailyAlarmTime;
	RTCTime SecondDailyAlarmTime;
	RTCTime SpecialAlarmTime;
	char FirstAlarmMessage[20];
	char SecondAlarmMessage[20];
	char SpecialAlarmMessage[20];	
	int AlarmPeriod;
	DWORD ServerIP;
	DWORD ServerPort;
        DWORD Gateway;
	DWORD DeviceIP;
	DWORD DevicePort;
        DWORD Mask;
	DWORD DeviceID;
	DWORD Password;
	//char DeviceName[20];
	RTCTime LastCollectedRecordTD;
	DWORD LastCollectedRecordIndex;
	PersonalIdentifyScenario DeviceMode;
	PreCard DevicePreCard;
}Settings;



typedef	long	Socket;

enum  ConnectionStatus
{
  CS_Disconnect = 0,
  CS_Connect
};

enum ConnectionType
{
        CT_None = 0,
        CT_LAN,
        CT_COM
};

/*enum  NetworkStatus
{
  NS_None = 0,
  NS_Connecting,
  NS_Sending,
  //NS_Receiving,
  NS_Accepting
};  */


struct  Param
{
  void  * p1;
  void  * p2;
  void  * p3;
  void  * p4;
  void  * p5;
  void  * p6;
  void  * p7;
  void  * p8;
  void  * p9;
  void  * p10;
};


struct  SearchHit
{
  bool  Hit;
  DWORD   Index;
  DWORD Value;
};

struct ID_Time
{
  DWORD ID;
  RTCTime Time;
};

struct Point{
  int x;
  int y;
};

struct Metric
{
  int x;
  int len;
};

enum  Icon
{
  I_Keyboard=0,
  I_Card,
  I_Admin,
  I_Save,
  I_USB,
  I_LAN,
  I_Sound,
  I_Modem
};

enum FadeMode
{
  FM_On,
  FM_Off,
  FM_OnOffOn,
  FM_OffOnOff
};

enum  Speed
{
  S_VeryFast,
  S_Fast,
  S_Normal,
  S_Slow,
  S_VerySlow
};

enum TaskPeriority
{
  TP_LowestPeriority  =1,
  TP_LowPeriority    =50,
  TP_NormalPeriority =100,
  TP_HighPeriority   =150,
  TP_RealTimePeriority     =200,
  TP_HighestPeriority =255
};

enum PixelFormat
{
  PF_Normal,
  PF_Invert
};

enum MifareCommand
{
  MC_None=0,
  MC_ALLRequest=0x31,
  MC_Anticollide=0x32,
  MC_SetLED=0x2B,
  MC_SetBuzzer=0x2C,
#ifdef   REM130
  MC_SelectCard=0x33,
  MC_Reset=0x2D
#else    
  MC_SelectCard=0x73,
  MC_Reset=0x78
#endif    
};

enum  FingerCommand
{
  FC_None=0,
  FC_WriteParameter=0x01,
  FC_SaveParameter=0x02,
  FC_ReadParameter=0x03,
  FC_EnrollByScan=0x05,
  FC_VerifyByScan=0x08,
  FC_IdentifyByScan=0x11,
  FC_DeleteTemplate=0x16,
  FC_DeleteAllTemplates=0x17,
  FC_CheckUserID=0x19,
  FC_DeleteByScan=0x1e,
  FC_Cancel=0x60,
  FC_ResetModule=0xd0,
  FC_ReadTemplate=0x14,
  FC_EnrollbyTemplete=0x07,
  FC_ETwithExtendData=0x87,
  FC_RTwithExtendData=0x89
};

enum  FingerParameter
{
  FP_None=0,
  FP_TemplateSize=384,
  FP_PackSendSize=100,
  FP_Len = 13
};

enum  FingerFlag
{
  FF_None=0,
  FF_AddNew=0x71,
  FF_Continue=0x74,
  FF_AutoID=0x79,
  FF_CheckFinger=0x84,
  FF_CheckFingerAutoID=0x85,
  FF_CONTINUE=0x74,
  FF_DataError=0x82,
  FF_DataOK=0x83
};

enum  IDType
{
  IT_None,
  IT_Card,
  IT_Finger,
  IT_FingerCard
};

enum  FingerError
{
  FE_None=0,
  FE_Success=0x61,
  FE_ScanSuccess=0x62,
  FE_ScanFailed=0x63,
  FE_NoteFound=0x69,
  FE_NotMatched=0x6a,
  FE_Timeout=0x6c,
  FE_MemoryFull=0x6d,
  FE_ExistID=0x6e,
  FE_InvalidID=0x76,
  FE_TimeoutMatched=0x7a,
  FE_Busy=0x80,
  FE_CANCELED=0x81,
  FE_ExistFinger=0x86,
  FE_FingerLimit=0x72,
  FE_TryAgain=0x6B
};

enum KeyFunction
{
  KF_None,
  KF_Function,
  KF_Special,
  KF_Arrow,
  KF_OK,
  KF_ESC,
  KF_Number,
  KF_Menu
};

enum KeyStatus
{
	KS_None,
	KS_Left,
	KS_Right,
	KS_Up,
	KS_Down,
	KS_Enter,
	KS_Exit,
	KS_Vacation,
	KS_Mission
};

struct KeyInfo
{
  enum KeyFunction Function;
  enum KeyStatus Status;
  int Num;
};

enum Alignment
{
  A_Left,
  A_Right,
  A_Center
};

enum Size
{
  Small,
  Medium,
  Large
};




enum  ConstantTime
{
  MicroSecond,
  MiliSecond,
  Second,
  Minute,
  Hour
};

enum DataType
{
	Command,
	Data
};

enum Baudrate
{
  B110,
  B300,
  B1200,
  B2400,
  B4800,
  B9600,
  B19200,
  B38400,
  B57600,
  B115200,
  B230400,
  B460800,
  B921600
};

enum UART_Character_Length
{
  B5,
  B6,
  B7,
  B8
};

enum Parity
{
  Even,
  Odd,
  None,
  Forced_1_stick,
  Forced_0_stick
};

enum StopBits
{
  One,
  Two
};

enum Direction
{
  Up,
  Down,
  Left,
  Right
};

enum Color
{
  Black,
  White
};

enum Shape
{
  Dot,
  Line,
  Square,
  Rectangle,
  Circle,
  Triangle,
  Sine
};

enum Power
{
  On,
  Off,
  Standby,
  PowerDown
};

enum Language
{
	Farsi ,
	English
};

enum Answer
{
  Yes,
  No,
  Cancel,
  Ignore,
  Abort
};

#endif
