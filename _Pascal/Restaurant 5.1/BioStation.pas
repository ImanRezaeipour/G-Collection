unit BioStation;
interface
uses  MSGs,SysUtils,{RunCmnds,}ComTools,Tcp_Udp,DateProc,Globals,{DBS,}funcs,adodb,variants,IOTools,CPort,DBS_Proc;
const
  BS_MAX_TNA_FUNCTION_KEY = 16;
  BS_MAX_TNA_EVENT_LEN    =16;

//kaveh is
type TTerminalRec = Record
  rdrCardCode  : String[8];
  rdrDate      : String[10];
  rdrTime      : Integer;
  rdrTimeSec   : Integer; //kaveh
  rdreTime     : Integer;
  rdrCode      : Integer;
  rdrStatus    : Integer;
  rdrIOType    : Integer;
  rdrgroup     : Integer;
  rdrBDate     : String[10];
  rdrBTime     : Integer;
  rdrBeTime     : Integer;
  rdrBStatus   : Integer;
  rdrBRdrCode  : Byte;
  rdrChng      : Integer;
  rdrUser      : string[15];
  rdrPayment   : Integer;  // used in credit3
  rdrService   : Integer;  // used in credit3
  rdrErrRec    : boolean;
  rdrAgreeCode : string[8];   //New webClock's field
  rdrFirstAgree: byte;        //New webClock's field
  rdrFinalAgree: byte;        //New webClock's field
  rdrdescription:string;      //New webClock's field
  rdrSendDate, rdrAgreeDate : string[10];  //New webClock's field
end;
//kaveh ie

type
  BS_RET_CODE ={$region}
  (
    BS_SUCCESS			= 0,

    // communication channel error
    BS_ERR_NO_AVAILABLE_CHANNEL		= -100,
    BS_ERR_INVALID_COMM_HANDLE		= -101,
    BS_ERR_CANNOT_WRITE_CHANNEL		= -102,
    BS_ERR_WRITE_CHANNEL_TIMEOUT	= -103,
    BS_ERR_CANNOT_READ_CHANNEL		= -104,
    BS_ERR_READ_CHANNEL_TIMEOUT		= -105,
    BS_ERR_CHANNEL_OVERFLOW			= -106,
    BS_ERR_CHANNEL_CLOSED			= -107,

    // socket error
    BS_ERR_CANNOT_INIT_SOCKET		= -200,
    BS_ERR_CANNOT_OPEN_SOCKET		= -201,
    BS_ERR_CANNOT_CONNECT_SOCKET	= -202,
    BS_ERR_SOCKET_CLOSED			= -203,

    // serial error
    BS_ERR_CANNOT_OPEN_SERIAL		= -220,

    // USB error
    BS_ERR_CANNOT_OPEN_USB			= -240,

    // USB memory error
    BS_ERR_INVALID_USB_MEMORY		= -260,
    BS_ERR_NO_MORE_USB_MEMORY		= -261,
    BS_ERR_CANNOT_FIND_USB_MEMORY	= -262,
    BS_ERR_VT_EXIST_IN_MEMORY		= -263,
    BS_ERR_USB_MEMORY_FULL			= -264,
    BS_ERR_NO_MORE_VT				= -265,

    // generic command error code
    BS_ERR_BUSY						= -300,
    BS_ERR_INVALID_PACKET			= -301,
    BS_ERR_CHECKSUM					= -302,
    BS_ERR_UNSUPPORTED				= -303,
    BS_ERR_FILE_IO					= -304,
    BS_ERR_DISK_FULL				= -305,
    BS_ERR_NOT_FOUND				= -306,
    BS_ERR_INVALID_PARAM			= -307,
    BS_ERR_RTC						= -308,
    BS_ERR_MEM_FULL					= -309,
    BS_ERR_DB_FULL					= -310,
    BS_ERR_INVALID_ID				= -311,
    BS_ERR_USB_DISABLED				= -312,
    BS_ERR_COM_DISABLED				= -313,
    BS_ERR_WRONG_PASSWORD			= -314,
    BS_ERR_TRY_AGAIN				= -315,
    BS_ERR_EXIST_FINGER				= -316,
    // user related error
    BS_ERR_NO_USER					= -320,

    // server error
    BS_ERR_NO_MORE_TERMINAL			= -400,
    BS_ERR_TERMINAL_NOT_FOUND		= -401,
    BS_ERR_TERMINAL_COMM_ERROR		= -402,
    BS_ERR_TERMINAL_NOT_AUTHORIZED	= -403,
    BS_ERR_TERMINAL_BUSY			= -404,

    // server db error
    BS_ERR_DB_NOT_EXIST				= -500,
    BS_ERR_CANNOT_CONNECT_TO_DB		= -501,
    BS_ERR_DB_INTERNAL_ERROR		= -502,

    // SSL error
    BS_ERR_CANNOT_INIT_SSL			= -601,
    BS_ERR_SSL_INVALID_CTX			= -602,
    BS_ERR_SSL_INVALID_CERTFILE		= -603,
    BS_ERR_SSL_INVALID_KEYFILE		= -604,
    BS_ERR_SSL_INVALID_CAFILE		= -605,
    BS_ERR_SSL_INVALID_PATH			= -606,
    BS_ERR_SSL_CANNOT_CONNECT		= -607,

    BS_ERR_UNKNOWN		= -9999
  );
  {$endregion}
  BSLogRecord = record
    eventType : byte;
    subEvent  : byte;
    tnaEvent  : word;
    eventTime : integer;
    userID    : longword;
    reserved  : longword;
  end;

  BSLogRecordEx = record
    eventType : byte;
    subEvent  : byte;
    tnaEvent  : word;
    eventTime : Cardinal;
    userID    : Cardinal;
    deviceID  : Cardinal; //kaveh
    imageSlot : Smallint; //kaveh
    reserved1 : Smallint; //kaveh
    reserved2  : Integer; //kaveh
  end;

  type ArrayOfBSLogRecord = array of BSLogRecord;
  BSTnaEventConfig = record
    enabled  : array [0..BS_MAX_TNA_FUNCTION_KEY-1] of char;
    useRelay : array [0..BS_MAX_TNA_FUNCTION_KEY-1] of char;
    eventStr : array [0..BS_MAX_TNA_FUNCTION_KEY+1 , 0..BS_MAX_TNA_EVENT_LEN-1] of char;
  end;
  procedure Suprema_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
  Function Connect_BS(rdr : TReaders) : BS_RET_CODE;
  Function DisConnect_BS(rdr : TReaders) : BS_RET_CODE;
  Function LinkTest_BS(rdr : TReaders) : BS_RET_CODE;
//kaveh  function addpishcard(var clkrec: TTerminalRec):boolean;
  Function ReadLog_BS(rdr : TReaders; startTime : String;endTime : String;var cnt : integer) : BS_RET_CODE;
  Function ReadFirstLogPCode_BS(rdr : TReaders; startTime : String;endTime : String; var clkRec : TTerminalRec; var findRec : Boolean) : BS_RET_CODE; //kaveh
//  Function ReadFirstLogPCode_BS(rdr : TReaders; startTime : String;endTime : String; var PCode : string) : BS_RET_CODE; //kaveh
  function SendDateTime_BS(rdr : TReaders; DT, TM : String) : BS_RET_CODE;
  function GetDateTime_BS(rdr : TReaders ; var DT, TM : String) : BS_RET_CODE;

  function SendNotice_BS(rdr : TReaders; var WST : WideString) : BS_RET_CODE;

  Function  BS_SendNotice(handle : Integer; msg : array of Char): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_SendNotice';

  Function  BS_InitSDK : BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_InitSDK';

  Function  BS_OpenUSB(var handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_OpenUSB';
  Function  BS_CloseUSB(var handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_CloseUSB';
  Function  BS_OpenUSBMemory(const driveLetter : ansistring;var handle : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_OpenUSBMemory';
  Function  BS_CloseUSBMemory(handle : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_CloseUSBMemory';
  Function  BS_OpenSocket(biostationAddr : ansiString ;port : integer;var handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_OpenSocket';
  Function  BS_CloseSocket(handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_CloseSocket';


  Function  BS_OpenSerial(const port : ansistring ;baudrate : integer;var handle : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_OpenSerial';
  Function  BS_CloseSerial(handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_CloseSerial';

  Function  BS_CheckSystemStatus(handle : Integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_CheckSystemStatus';

  Function  BS_GetTime(handle : Integer;var timeVal : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_GetTime';
  Function  BS_SetTime(handle : Integer;timeVal : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_SetTime';


  Function  BS_GetLogCount(handle: integer;var logCount : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_GetLogCount';
  Function  BS_ReadLog(handle : integer;startTime : integer;endTime : integer;var logCount : integer;logRecord : ansistring{array of BSLogRecord}): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ReadLog';
  Function  BS_ReadNextLog(handle : integer;startTime : integer;endTime : integer;var logCount : integer;logRecord : ansistring{array of BSLogRecord}): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ReadNextLog';
  Function  BS_ClearLogCache(handle : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ClearLogCache';
  Function  BS_ReadLogCache(handle : integer;var numOfLog : integer;logRecord : ansistring): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ReadLogCache';

  Function  BS_ReadLogEx(handle : integer;startTime : integer;endTime : integer;var logCount : integer; logRecord : ansistring{array of BSLogRecordEx}): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ReadLogEx'; //kaveh
  
  Function  BS_WriteTnaEventConfig(handle: integer;var config : BSTnaEventConfig): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_WriteTnaEventConfig';
  Function  BS_ReadTnaEventConfig (handle: integer;var config : BSTnaEventConfig): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_ReadTnaEventConfig';
  Function  BS_GetDeviceID(handle : integer;var deviceID : integer;var deviceType : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_GetDeviceID';
  Function  BS_SetDeviceID(handle : integer;deviceID : integer;deviceType : integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_SetDeviceID';
  Function  BS_SetDefaultTimeout(handle : integer ;timeout :integer): BS_RET_CODE; stdcall;external 'BS_SDK.dll' name 'BS_SetDefaultTimeout';
//kaveh  procedure make_pish_fkey(var rec:BSTnaEventConfig);
//  Function  GetAllUserInfo(rdr : TReaders;var numOfUser: longword; var numOfTemplate: longword) : UFUserInfo_Array;

var
  hndl : integer;
const
BE_EVENT_SCAN_SUCCESS 	= $58;
BE_EVENT_ENROLL_BAD_FINGER = $16;
BE_EVENT_ENROLL_SUCCESS = $17;
BE_EVENT_ENROLL_FAIL = $18;
BE_EVENT_ENROLL_CANCELED = $19;

BE_EVENT_VERIFY_BAD_FINGER = $26;
BE_EVENT_VERIFY_SUCCESS = $27;
BE_EVENT_VERIFY_FAIL = $28;
BE_EVENT_VERIFY_CANCELED = $29;
BE_EVENT_VERIFY_NO_FINGER = $2a;

BE_EVENT_IDENTIFY_BAD_FINGER = $36;
BE_EVENT_IDENTIFY_SUCCESS = $37;
BE_EVENT_IDENTIFY_FAIL = $38;
BE_EVENT_IDENTIFY_CANCELED = $39;

BE_EVENT_DELETE_BAD_FINGER = $46;
BE_EVENT_DELETE_SUCCESS = $47;
BE_EVENT_DELETE_FAIL = $48;
BE_EVENT_DELETE_ALL_SUCCESS = $49;

BE_EVENT_VERIFY_DURESS = $62;
BE_EVENT_IDENTIFY_DURESS = $63;

BE_EVENT_TAMPER_SWITCH_ON = $64;
BE_EVENT_TAMPER_SWITCH_OFF = $65;

BE_EVENT_SYS_STARTED = $6a;
BE_EVENT_IDENTIFY_NOT_GRANTED = $6d;
BE_EVENT_VERIFY_NOT_GRANTED = $6e;

BE_EVENT_IDENTIFY_LIMIT_COUNT = $6f;
BE_EVENT_IDENTIFY_LIMIT_TIME = $70;

BE_EVENT_IDENTIFY_DISABLED = $71;
BE_EVENT_IDENTIFY_EXPIRED = $72;

BE_EVENT_APB_FAIL = $73;
BE_EVENT_COUNT_LIMIT = $74;
BE_EVENT_TIME_INTERVAL_LIMIT 	= $75;
BE_EVENT_INVALID_AUTH_MODE		= $76;
BE_EVENT_EXPIRED_USER			= $77;
BE_EVENT_NOT_GRANTED			= $78;

BE_EVENT_DETECT_INPUT0	= $54;
BE_EVENT_DETECT_INPUT1 = $55;

BE_EVENT_TIMEOUT = $90;

BS_EVENT_RELAY_ON	= $80;
BS_EVENT_RELAY_OFF	= $81;

BE_EVENT_DOOR0_OPEN 	= $82;
BE_EVENT_DOOR1_OPEN		= $83;
BE_EVENT_DOOR0_CLOSED 	= $84;
BE_EVENT_DOOR1_CLOSED	= $85;

BE_EVENT_DOOR0_FORCED_OPEN	= $86;
BE_EVENT_DOOR1_FORCED_OPEN	= $87;

BE_EVENT_DOOR0_HELD_OPEN	= $88;
BE_EVENT_DOOR1_HELD_OPEN	= $89;

BE_EVENT_DOOR0_RELAY_ON		= $8A;
BE_EVENT_DOOR1_RELAY_ON		= $8B;

BE_EVENT_INTERNAL_INPUT0	= $A0;
BE_EVENT_INTERNAL_INPUT1	= $A1;
BE_EVENT_SECONDARY_INPUT0	= $A2;
BE_EVENT_SECONDARY_INPUT1	= $A3;

BE_EVENT_SIO0_INPUT0		= $B0;
BE_EVENT_SIO0_INPUT1		= $B1;
BE_EVENT_SIO0_INPUT2		= $B2;
BE_EVENT_SIO0_INPUT3		= $B3;

BE_EVENT_SIO1_INPUT0		= $B4;
BE_EVENT_SIO1_INPUT1		= $B5;
BE_EVENT_SIO1_INPUT2		= $B6;
BE_EVENT_SIO1_INPUT3		= $B7;

BE_EVENT_SIO2_INPUT0		= $B8;
BE_EVENT_SIO2_INPUT1		= $B9;
BE_EVENT_SIO2_INPUT2		= $BA;
BE_EVENT_SIO2_INPUT3		= $BB;

BE_EVENT_SIO3_INPUT0		= $BC;
BE_EVENT_SIO3_INPUT1		= $BD;
BE_EVENT_SIO3_INPUT2		= $BE;
BE_EVENT_SIO3_INPUT3		= $BF;

BE_EVENT_LOCKED			= $C0;
BE_EVENT_UNLOCKED			= $C1;

BE_EVENT_TIME_SET			= $D2;


  BS_TNA_F1 = 0;
  BS_TNA_F2 = 1;
  BS_TNA_F3 = 2;
  BS_TNA_F4 = 3;
  BS_TNA_1  = 4;
  BS_TNA_2  = 5;
  BS_TNA_3  = 6;
  BS_TNA_4  = 7;
  BS_TNA_5  = 8;
  BS_TNA_6  = 9;
  BS_TNA_7  = 10;
  BS_TNA_8  = 11;
  BS_TNA_9  = 12;
  BS_TNA_CALL = 13;
  BS_TNA_0    = 14;
  BS_TNA_ESC  = 15;

implementation

{//kaveh
procedure make_pish_fkey(var rec:BSTnaEventConfig);
const
  boolst:array[boolean]of char=(#0,#1);
  numst:array[0..1]of char=(#0,#1);
var
   i,j,k,pish_Code,pish_idx: integer;
   st : string[BS_MAX_TNA_EVENT_LEN];
begin
  for I := 0 to BS_MAX_TNA_FUNCTION_KEY-1 do
  begin
     rec.enabled[i]:=boolst[false];
     rec.useRelay[i]:=boolst[false];
//     rec.eventStr[i][0] :='A';
//     rec.eventStr[i][1] :='B';
//     rec.eventStr[i][2] :=#0;
  end;

  for pish_Code := 0 to MaxPishCard do
  begin
    pish_idx:=GetPishCardIdx(Pish_Code);
    if pish_idx>0
    then begin
      j:=PishCard_Key[pish_idx];
      if j >0 then
      begin
        rec.useRelay[j-1]:=boolst[(PishCard_ActiveRelay[pish_idx]=MB_TRUE)];
        rec.enabled[j-1]:=boolst[TRUE];
        st:= PishCard_LastName[pish_idx];
        for k:=1 to Length(st) do rec.eventStr[j+1][k-1]:=st[k];
      end;
    end;
  end;
end;
}

procedure Suprema_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
var
  L : Byte;
  SSS : String;
begin

  if TimeOut = 0 then
  begin
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := 5;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := 5;
  end
  else
  begin
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := TimeOut;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := TimeOut;
  end;

  retVal := ERR_NONE;
  frmComTools.ComPort.ReadStr(PK, Len);

  L := Length(PK);
  if L = Len then
    retVal := ERR_OFF;

  TestTest('G: ', PK);
end;
function GetEventStr(eventType : byte) : string;
begin
  case eventType of
    BE_EVENT_SCAN_SUCCESS:
                    result := 'Scan Success';

    BE_EVENT_ENROLL_BAD_FINGER:
                    result := 'Enroll Bad Finger';

    BE_EVENT_ENROLL_SUCCESS:
                    result := 'Enroll Success';

    BE_EVENT_ENROLL_FAIL:
                    result := 'Enroll Fail';

    BE_EVENT_ENROLL_CANCELED:
                    result := 'Enroll Canceled';

    BE_EVENT_VERIFY_BAD_FINGER:
                    result := 'Verify Bad Finger';

    BE_EVENT_VERIFY_SUCCESS:
                    result := 'Verify Success';

    BE_EVENT_VERIFY_FAIL:
                    result := 'Verify Fail';

    BE_EVENT_VERIFY_CANCELED:
                    result := 'Verify Canceled';

    BE_EVENT_VERIFY_NO_FINGER:
                    result := 'Verify No Finger';

    BE_EVENT_IDENTIFY_BAD_FINGER:
                    result := 'Identify Bad Finger';

    BE_EVENT_IDENTIFY_SUCCESS:
                    result := 'Identify Success';

    BE_EVENT_IDENTIFY_FAIL:
                    result := 'Identify Fail';

    BE_EVENT_IDENTIFY_CANCELED:
                    result := 'Identify Canceled';

    BE_EVENT_DELETE_BAD_FINGER:
                    result := 'Delete Bad Finger';

    BE_EVENT_DELETE_SUCCESS:
                    result := 'Delete Success';

    BE_EVENT_DELETE_FAIL:
                    result := 'Delete Fail';

    BE_EVENT_DELETE_ALL_SUCCESS:
                    result := 'Delete All';

    BE_EVENT_VERIFY_DURESS:
                    result := 'Verify Duress';

    BE_EVENT_IDENTIFY_DURESS:
                    result := 'Identify Duress';

    BE_EVENT_TAMPER_SWITCH_ON:
                    result := 'Tamper On';

    BE_EVENT_TAMPER_SWITCH_OFF:
                    result := 'Tamper Off';

    BE_EVENT_SYS_STARTED:
                    result := 'System Started';

    BE_EVENT_IDENTIFY_NOT_GRANTED:
                    result := 'Identify Not Granted';

    BE_EVENT_VERIFY_NOT_GRANTED:
                    result := 'Verify Not Granted';

    BE_EVENT_IDENTIFY_LIMIT_COUNT:
                    result := 'Identify Limit Count';

    BE_EVENT_IDENTIFY_LIMIT_TIME:
                    result := 'Identify Limit Time';

    BE_EVENT_IDENTIFY_DISABLED:
                    result := 'Identify Disabled';

    BE_EVENT_IDENTIFY_EXPIRED:
                    result := 'Identify Expired';

    BE_EVENT_APB_FAIL:
                    result := 'Anti-passback Failed';

    BE_EVENT_COUNT_LIMIT:
                    result := 'Entrance Limit Count';

    BE_EVENT_TIME_INTERVAL_LIMIT:
                    result := 'Entrance Time Interval';

    BE_EVENT_INVALID_AUTH_MODE:
                    result := 'Invalid Auth Mode';

    BE_EVENT_EXPIRED_USER:
                    result := 'Expired User';

    BE_EVENT_NOT_GRANTED:
                    result := 'Access Not Granted';

    BE_EVENT_DOOR0_OPEN:
                    result := 'Door 0 Open';

    BE_EVENT_DOOR0_CLOSED:
                    result := 'Door 0 Closed';

    BE_EVENT_DOOR1_OPEN:
                    result := 'Door 1 Open';

    BE_EVENT_DOOR1_CLOSED:
                    result := 'Door 1 Closed';

    BE_EVENT_DOOR0_FORCED_OPEN:
                    result := 'Door 0 Forced Open';

    BE_EVENT_DOOR1_FORCED_OPEN:
                    result := 'Door 1 Forced Open';

    BE_EVENT_DOOR0_HELD_OPEN:
                    result := 'Door 0 Held Open';

    BE_EVENT_DOOR1_HELD_OPEN:
                    result := 'Door 1 Held Open';

    BE_EVENT_DOOR0_RELAY_ON:
                    result := 'Door 0 Relay On';

    BE_EVENT_DOOR1_RELAY_ON:
                    result := 'Door 1 Relay On';

    BE_EVENT_TIMEOUT:
                    result := 'Timeout';

                // IO event
    BE_EVENT_INTERNAL_INPUT0:
                    result := 'Detect Internal Input 0';

    BE_EVENT_INTERNAL_INPUT1:
                    result := 'Detect Internal Input 1';

    BE_EVENT_SECONDARY_INPUT0:
                    result := 'Detect Secondary Input 0';

    BE_EVENT_SECONDARY_INPUT1:
                    result := 'Detect Secondary Input 1';

    BE_EVENT_SIO0_INPUT0:
                    result := 'Detect SIO 0 Input 0';

    BE_EVENT_SIO0_INPUT1:
                    result := 'Detect SIO 0 Input 1';

    BE_EVENT_SIO0_INPUT2:
                    result := 'Detect SIO 0 Input 2';

    BE_EVENT_SIO0_INPUT3:
                    result := 'Detect SIO 0 Input 3';

    BE_EVENT_SIO1_INPUT0:
                    result := 'Detect SIO 1 Input 0';

    BE_EVENT_SIO1_INPUT1:
                    result := 'Detect SIO 1 Input 1';

    BE_EVENT_SIO1_INPUT2:
                    result := 'Detect SIO 1 Input 2';

    BE_EVENT_SIO1_INPUT3:
                    result := 'Detect SIO 1 Input 3';

    BE_EVENT_SIO2_INPUT0:
                    result := 'Detect SIO 2 Input 0';

    BE_EVENT_SIO2_INPUT1:
                    result := 'Detect SIO 2 Input 1';

    BE_EVENT_SIO2_INPUT2:
                    result := 'Detect SIO 2 Input 2';

    BE_EVENT_SIO2_INPUT3:
                    result := 'Detect SIO 2 Input 3';

    BE_EVENT_SIO3_INPUT0:
                    result := 'Detect SIO 3 Input 0';

    BE_EVENT_SIO3_INPUT1:
                    result := 'Detect SIO 3 Input 1';

    BE_EVENT_SIO3_INPUT2:
                    result := 'Detect SIO 3 Input 2';

    BE_EVENT_SIO3_INPUT3:
                    result := 'Detect SIO 3 Input 3';

    BE_EVENT_LOCKED:
                    result := 'Locked';

    BE_EVENT_UNLOCKED:
                    result := 'Unlocked';

    BE_EVENT_TIME_SET:
                    result := 'Set Time';

    else
      result := '';
  end;
end;

function FindReaderCodeIdx(ReaderCode : Integer) : Byte;
var i : byte;
begin
  FindReaderCodeIdx := 0;
  for i := 1 to TotalReader do
    if Readers[i].R_Code = ReaderCode then
    begin
      FindReaderCodeIdx := i;
      Break;
    end;
end;

Function Connect_BS(rdr : TReaders) : BS_RET_CODE;
var
 a,b :longint;
begin

  case rdr.R_IsCom {//kaveh r_ComType}of
    True{//kaveh SERIAL} :
      begin
        result := BS_InitSDK;
        if Result <> BS_Success then
          exit;
        Result := BS_OpenSerial('COM' + IntToStr(rdr.R_Port),BAUDRATES[rdr.R_BaudNo],hndl);
//kaveh        if F_Params.IsWin2000 = MB_TRUE then
//kaveh          BS_SetDefaultTimeout(hndl,F_Params.TimeOut2000);
      end;
    False{//kaveh NETWORK} :
    begin
      result := BS_InitSDK;
      if Result <> BS_Success then
        exit;
      frmTcpUdp.tcpData.Disconnect;
      //kaveh if rdr.R_TCPPort=0 then rdr.R_TCPPort := 1470;
      if rdr.R_Type in [RDR_BIOLITE] then
        result := BS_OpenSocket(rdr.R_IP,1471{//kaveh rdr.R_TCPPort},hndl)
      else if rdr.R_Type in [RDR_BIOSTATION, RDR_XSTATION] then
        result := BS_OpenSocket(rdr.R_IP,1470{//kaveh rdr.R_TCPPort},hndl)
      else
        Result := BS_ERR_NOT_FOUND;
    end;
{//kaveh
    USB_DEVICE :
    begin
      if not Readers[FindReaderCodeIdx(rdr.r_code)].r_UsbConnected then
      begin
        result := BS_InitSDK;
        if Result <> BS_Success then
          exit;
        result := BS_OpenUSB(hndl);
        Readers[FindReaderCodeIdx(rdr.r_code)].r_UsbConnected := (result = BS_Success);
      end
      else
        result := BS_Success;
    end;
    USB_MEMORY :
      begin
        result := BS_InitSDK;
        if Result <> BS_Success then
          exit;
        result := BS_OpenUSBMemory(GetLastDrive,hndl);
//        Result := BS_GetDeviceID(hndl,a,b);
//        Result := BS_SetDeviceID(hndl,a,b);
      end; }
  end;

  Result := BS_GetDeviceID(hndl,a,b);
  Result := BS_SetDeviceID(hndl,a,b);
end;
Function DisConnect_BS(rdr : TReaders) : BS_RET_CODE;
begin
  case rdr.R_IsCom {//kaveh r_ComType} of
    True{//kaveh SERIAL} :
    begin
      bs_closeSerial(hndl);
    end;
    False{//kaveh NETWORK} :
    begin
      bs_closeSocket(hndl);
    end;
{//kaveh
    USB_DEVICE :
    begin
        result := BS_Success;//BS_closeUSB(hndl);
    end;
    USB_MEMORY :
      begin
        BS_CloseUSBMemory(hndl)
      end;
      }
  end;
end;
Function LinkTest_BS(rdr : TReaders) : BS_RET_CODE;
var a,b :longint;
begin
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
    Result := BS_GetDeviceID(hndl,a,b);
    //Result := BS_CheckSystemStatus(hndl);
  end;
  DisConnect_BS(rdr);
end;

function pishcardcode(code:string):integer;
// find pishcard for this card code
begin
  result:=0;
  if copy(code,1,6)='999999'
  then begin
       result:=strtoint(copy(code,7,2));
  end;
end;


{//kaveh
function addpishcard(var clkrec: TTerminalRec):boolean;
// if result=true then we can save record else its a pishcard for next record
var
  pishno : integer;
  code : integer;
begin
   if (clkrec.rdrStatus<-32000) or (clkrec.rdrStatus>32000)
   then clkrec.rdrStatus:=0;
   if (clkrec.rdrbStatus<-32000) or (clkrec.rdrbStatus>32000)
   then clkrec.rdrbStatus:=0;
   result:=true;
   code :=clkrec.rdrCode;
   code:=FindReaderCodeIdx(code);
   if readers[code].lastpishcard.rdrStatus <> 0
   then begin
        if differdate(clkrec.rdrDate,readers[code].lastpishcard.rdrdate)*1440
          +clkrec.rdrtime-readers[code].lastpishcard.rdrtime <=1
        then begin
          clkrec.rdrStatus:=readers[code].lastpishcard.rdrStatus;
        end;
        readers[code].lastpishcard.rdrStatus:=0;
   end;
   pishno:=pishcardcode(clkrec.rdrCardCode);
   if pishno>0
   then begin
        readers[code].lastpishcard:=clkrec;
        readers[code].lastpishcard.rdrStatus := pishno;
        result:=false;
   end;
   readers[code].lastcardok:=result;
end;
}
Function ReadLog_BS(rdr : TReaders; startTime : String;endTime : String;var cnt : integer) : BS_RET_CODE;
var
  i,j : integer;
  a : TDateTime;
  recLog : array of BSLogRecord;
  AllLog,strLog : AnsiString;
  tmp : string;
  numOfSaved : integer;
  getCnt,NumOfLog : integer;
  ClkRec : array of TTerminalRec;
  y,m,d,hh,mm,ss,ms : word;
  pish_Code: Integer;
  adoQry : tadoquery;
const
  MAX_LOG = 500000; // 50000 for BioEntry
  MAX_READ_LOG = 32768; // 8192 for BioEntry
function ii(chr : char) : string;
begin
  RESULT := inttohex(ord(chr),2);
end;
procedure fillRecLog;
var
  i : integer;
begin
  SetLength(recLog,numOfLog);
  for I := 0 to numOfLog-1 do
  begin
    tmp := copy(AllLog , i*16+1 , 16);
    with recLog[i] do
    begin
      eventType := ord(tmp[1]);
      subEvent := ord(tmp[2]);
      tnaEvent := StrToInt('$' + ii(tmp[4])+ ii(tmp[3]));
      eventTime := StrToInt('$' + ii(tmp[8])+ ii(tmp[7])+ ii(tmp[6])+ ii(tmp[5]));
      userID := StrToInt('$' + ii(tmp[12])+ ii(tmp[11])+ ii(tmp[10])+ ii(tmp[9]));
      reserved := StrToInt('$' + ii(tmp[16])+ ii(tmp[15])+ ii(tmp[14])+ ii(tmp[13]));
    end;
  end;
end;
begin
  cnt := 0;
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
    SetLength(AllLog,MAX_READ_LOG*16);
    SetLength(StrLog,MAX_READ_LOG*16);
    Result := BS_ReadLog(hndl, DateTimeToMSec(startTime), DateTimeToMSec(endTime), getCnt,AllLog);
    numOfLog := 0;
    while ( result = BS_SUCCESS ) do
    begin
      numOfLog := numOfLog + getCnt;
      if(getCnt < MAX_READ_LOG) then // end of the log
        break;
      result := BS_ReadNextLog(hndl, DateTimeToMSec(startTime) ,DateTimeToMSec(endTime), getCnt, strLog);
      AllLog := AllLog + strLog;
    end;
    fillRecLog;
    for I := 0 to numOfLog-1 do
      if recLog[i].eventType in [$27,$37,$62,$63] then
        inc(cnt);
    SetLength(ClkRec,cnt);
    j := 0;
    for I := 0 to numOfLog-1 do
    begin
      if (recLog[i].eventType in [$27,$37,$62,$63]) and  ((recLog[i].tnaEvent in [BS_TNA_F1..BS_TNA_ESC]) or  (recLog[i].tnaEvent=$FFFF)) then
      begin
        DecodeDate(MSecToDateTime(recLog[i].eventTime),y,m,d);
        DecodeTime(MSecToDateTime(recLog[i].eventTime),hh,mm,ss,ms);
        with ClkRec[j] do
        begin
          with adoQry do
          begin
            adoQry := TADOQuery.Create(nil);
            Connection := frmDBS.DBConnection;
            SQL.clear;
            SQL.Add('select P_BarCode,p_Proxi from persons where P_BarCode = ''' + FixLeft(IntToStr(recLog[i].userID),'0',8) + ''' or P_Proxi = ''' + FixLeft(IntToStr(recLog[i].userID),'0',8) + '''');
            open;
          end;

          rdrCardCode := vartostr(adoQry.lookup('P_BarCode', FixLeft(IntToStr(recLog[i].userID),'0',8) , 'P_BarCode'));
          if rdrCardCode = '' then
            rdrCardCode := vartostr(adoQry.lookup('P_Proxi', FixLeft(IntToStr(recLog[i].userID),'0',8) , 'P_BarCode'));
          if rdrCardCode = '' then
            rdrCardCode := FixLeft(IntToStr(recLog[i].userID),'0',8);
          adoQry.close;
          adoQry.free;
          rdrDate := Milady2Shamsi(IntToStr(y)+'/'+IntToStr(m)+'/'+IntToStr(d));
          rdrTime := hh*60+mm;
          rdrCode := rdr.R_Code;
{//kaveh          for pish_Code := 0 to MaxPishCard do
            if PishCard_Key[Pish_Code]=  recLog[i].tnaEvent+1 then
            rdrStatus := PishCard_No[Pish_Code];}
            rdrStatus := 0; //kaveh
          rdrBDate := rdrDate;
          rdrBTime := rdrTime;
          rdrBStatus := rdrStatus;
          rdrBRdrCode := rdr.R_Code;
          rdrChng := 0;
          rdrIOType:=0;
          if recLog[i].eventType=$37
          then rdrIOType:=1
          else if recLog[i].eventType=$27
           then case recLog[i].subevent of
                    $2B : rdrIOType:=1;
                    $2C : rdrIOType:=2;
                    $2D : rdrIOType:=3;
                    $2E : rdrIOType:=4;
                    $2F : rdrIOType:=5;
                    $30 : rdrIOType:=6;
                    $31 : rdrIOType:=7;
                    else rdrIOType:=0;
               end;
          rdrUser := G_Options.username;
        end;
        inc(j);
      end;
    end;
    numOfSaved := 0;
    for j := 0 to cnt-1 do
      if true //kaveh {//kavehaddpishcard(ClkRec[j])}
      then begin
        //kaveh if SaveClockRecord(ClkRec[j], REC_TEST, False) then inc(numOfSaved);
        inc(numOfSaved); //kaveh
      end
      {else result:=false};
    if endTime = '' then
      cnt := numOfSaved;
    DisConnect_BS(rdr);
  end;
end;

//kaveh is
Function ReadFirstLogPCode_BS(rdr : TReaders; startTime : String;endTime : String; var clkRec : TTerminalRec; var findRec : Boolean) : BS_RET_CODE;
var
  i,j : integer;
  a : TDateTime;
  recLog : {array of} BSLogRecord;
  recLogEx : BSLogRecordEx;
  AllLog{,strLog} : AnsiString;
  tmp : string;
  numOfSaved : integer;
  {getCnt,}NumOfLog : integer;
//kaveh  ClkRec : array of TTerminalRec;
  y,m,d,hh,mm,ss,ms : word;
  pish_Code: Integer;
  adoQry : tadoquery;

  cnt : integer; //kaveh
  iStartTime : integer; //kaveh
const
  MAX_LOG = 500000; // 50000 for BioEntry
  MAX_READ_LOG = 32768; // 8192 for BioEntry
function ii(chr : char) : string;
begin
  RESULT := inttohex(ord(chr),2);
end;
function fillRecLog(rdrType : Integer) : Boolean;
var
  i : integer;
begin
{//kaveh
  SetLength(recLog,numOfLog);
  for I := 0 to numOfLog-1 do
  begin
    tmp := copy(AllLog , i*16+1 , 16);
    with recLog[i] do
    begin
      eventType := ord(tmp[1]);
      subEvent := ord(tmp[2]);
      tnaEvent := StrToInt('$' + ii(tmp[4])+ ii(tmp[3]));
      eventTime := StrToInt('$' + ii(tmp[8])+ ii(tmp[7])+ ii(tmp[6])+ ii(tmp[5]));
      userID := StrToInt('$' + ii(tmp[12])+ ii(tmp[11])+ ii(tmp[10])+ ii(tmp[9]));
      reserved := StrToInt('$' + ii(tmp[16])+ ii(tmp[15])+ ii(tmp[14])+ ii(tmp[13]));
    end;
  end;
}
//kaveh is
//kaveh  SetLength(recLog,1);
  RESULT := False;
  if (rdrType = 5) or (rdrType = 6) then
  begin
    for i := 0 to numOfLog-1 do
    begin
      tmp := copy(AllLog , i*16+1 , 16);
      with recLog do
      begin
        eventType := ord(tmp[1]);
        subEvent := ord(tmp[2]);
        tnaEvent := StrToInt('$' + ii(tmp[4])+ ii(tmp[3]));
        eventTime := StrToInt('$' + ii(tmp[8])+ ii(tmp[7])+ ii(tmp[6])+ ii(tmp[5]));
        userID := StrToInt('$' + ii(tmp[12])+ ii(tmp[11])+ ii(tmp[10])+ ii(tmp[9]));
        reserved := StrToInt('$' + ii(tmp[16])+ ii(tmp[15])+ ii(tmp[14])+ ii(tmp[13]));
      end;
      if recLog.eventType in [$27,$37,$62,$63] then
      begin
        RESULT := True;
        Break;
      end;
    end;
  end
  else if rdrType = 7 then
  begin
    for i := 0 to numOfLog-1 do
    begin
      tmp := copy(AllLog , i*24+1 , 24);
      with recLogEx do
      begin
        eventType := ord(tmp[1]);
        subEvent := ord(tmp[2]);
        tnaEvent := StrToInt('$' + ii(tmp[4])+ ii(tmp[3]));
        eventTime := StrToInt('$' + ii(tmp[8])+ ii(tmp[7])+ ii(tmp[6])+ ii(tmp[5]));
        userID := StrToInt('$' + ii(tmp[12])+ ii(tmp[11])+ ii(tmp[10])+ ii(tmp[9]));
        deviceID := StrToInt('$' + ii(tmp[16])+ ii(tmp[15])+ ii(tmp[14])+ ii(tmp[13]));
        imageSlot := StrToInt('$' + ii(tmp[18])+ ii(tmp[17]));
        reserved1 := StrToInt('$' + ii(tmp[20])+ ii(tmp[19])); 
        reserved2 := StrToInt('$' + ii(tmp[24])+ ii(tmp[23])+ ii(tmp[22])+ ii(tmp[21]));
      end;
      if recLogEx.eventType in [$27,$37,$62,$63] then
      begin
        RESULT := True;
        Break;
      end;
    end;
  end
  else
    RESULT := False;
//kaveh ie
end;
begin
  cnt := 0;
  findRec := False;
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
//    SetLength(AllLog,MAX_READ_LOG*16);
//kaveh    SetLength(StrLog,MAX_READ_LOG*16);
//kaveh    Result := BS_ReadLog(hndl, DateTimeToMSec(startTime), DateTimeToMSec(endTime), getCnt,AllLog);
//    SetLength(AllLog,MAX_READ_LOG*16);
//    SetLength(StrLog,MAX_READ_LOG*16);
//    Result := BS_ReadLog(hndl, DateTimeToMSec(startTime), DateTimeToMSec(endTime), getCnt,AllLog);
//    SetLength(AllLog,MAX_READ_LOG*24);
//    SetLength(StrLog,MAX_READ_LOG*24);
//    Result := BS_ReadLogEx(hndl, DateTimeToMSec(startTime), DateTimeToMSec(endTime), getCnt, AllLog);
    try
      iStartTime := DateTimeToMSec(startTime);
      if (rdr.R_Type = 5) or (rdr.R_Type = 6) then
      begin
        SetLength(AllLog,MAX_READ_LOG*16);
        Result := BS_ReadLog(hndl, iStartTime, DateTimeToMSec(endTime), numOfLog, AllLog); //kaveh
      end
      else if (rdr.R_Type = 7) then
      begin
        SetLength(AllLog,MAX_READ_LOG*24);
        Result := BS_ReadLogEx(hndl, iStartTime, DateTimeToMSec(endTime), numOfLog, AllLog);
      end
      else
      begin
        Result := BS_ERR_UNSUPPORTED;
      end;
    except
      AllLog := '';
      DisConnect_BS(rdr);
      Result := BS_ERR_BUSY;
      Exit;
    end;
//kaveh    numOfLog := 0;

{//kaveh
    while ( result = BS_SUCCESS ) do
    begin
      numOfLog := numOfLog + getCnt;
      if(getCnt < MAX_READ_LOG) then // end of the log
        break;
      result := BS_ReadNextLog(hndl, DateTimeToMSec(startTime) ,DateTimeToMSec(endTime), getCnt, strLog);
      AllLog := AllLog + strLog;
    end;
}

//kaveh is
    if ( result <> BS_SUCCESS ) then
    begin
      AllLog := '';
      DisConnect_BS(rdr);
      Exit;
    end;

    if fillRecLog(rdr.R_Type) then
    begin
      with adoQry do
      begin
        adoQry := TADOQuery.Create(nil);
        Connection := frmDBS.DBConnection;
        SQL.clear;
        if (rdr.R_Type = 5) or (rdr.R_Type = 6) then
        begin
          SQL.Add('select P_BarCode,p_Proxi from persons where P_Proxi = ''' + FixLeft(IntToStr(recLog{[i]}.userID),'0',8) + '''');
          open;
          clkRec.rdrCardCode := adoQry.FieldByName('P_BarCode').AsString;
          DecodeDate(MSecToDateTime(recLog.eventTime),y,m,d);
          DecodeTime(MSecToDateTime(recLog.eventTime),hh,mm,ss,ms);
          clkRec.rdrDate := Milady2Shamsi(IntToStr(y)+'/'+IntToStr(m)+'/'+IntToStr(d));
          clkRec.rdrTimeSec := (hh*3600)+(mm*60)+(ss);
          clkRec.rdrTime := hh*60+mm;
          findRec := True;
        end
        else if (rdr.R_Type = 7) then
        begin
          SQL.Add('select P_BarCode,p_Proxi from persons where P_Proxi = ''' + FixLeft(IntToStr(recLogEx{[i]}.userID),'0',8) + '''');
          open;
          clkRec.rdrCardCode := adoQry.FieldByName('P_BarCode').AsString;
          DecodeDate(MSecToDateTime(recLogEx.eventTime),y,m,d);
          DecodeTime(MSecToDateTime(recLogEx.eventTime),hh,mm,ss,ms);
          clkRec.rdrDate := Milady2Shamsi(IntToStr(y)+'/'+IntToStr(m)+'/'+IntToStr(d));
          clkRec.rdrTimeSec := (hh*3600)+(mm*60)+(ss);
          clkRec.rdrTime := hh*60+mm;
          findRec := True;
        end;
        //kaveh P_BarCode = ''' + FixLeft(IntToStr(recLog{[i]}.userID),'0',8) + ''' or
        close;
        free;
      end;
    end;

    DisConnect_BS(rdr);
  end;
//kaveh is

{//kaveh
    for I := 0 to numOfLog-1 do
      if recLog{[i]}//kaveh.eventType in [$27,$37,$62,$63] then
{//kaveh
        inc(cnt);
    SetLength(ClkRec,cnt);
    j := 0;
    for I := 0 to numOfLog-1 do
    begin
      if (recLog{[i]}//kaveh.eventType in [$27,$37,$62,$63]) and  ((recLog{[i]}.tnaEvent in [BS_TNA_F1..BS_TNA_ESC]) or  (recLog{[i]}.tnaEvent=$FFFF)) then
{//kaveh
      begin
        DecodeDate(MSecToDateTime(recLog{[i]}//kaveh.eventTime),y,m,d);
{//kaveh
        DecodeTime(MSecToDateTime(recLog{[i]}//kaveh.eventTime),hh,mm,ss,ms);
{//kaveh
        with ClkRec[j] do
        begin
          with adoQry do
          begin
            adoQry := TADOQuery.Create(nil);
            Connection := frmDBS.DBConnection;
            SQL.clear;
            SQL.Add('select P_BarCode,p_Proxi from persons where P_BarCode = ''' + FixLeft(IntToStr(recLog{[i]}//kaveh.userID),'0',8) + ''' or P_Proxi = ''' + FixLeft(IntToStr(recLog{[i]}.userID),'0',8) + '''');
{//kaveh
            open;
          end;

          rdrCardCode := vartostr(adoQry.lookup('P_BarCode', FixLeft(IntToStr(recLog{[i]}//kaveh.userID),'0',8) , 'P_BarCode'));
{//kaveh
          if rdrCardCode = '' then
            rdrCardCode := vartostr(adoQry.lookup('P_Proxi', FixLeft(IntToStr(recLog{[i]}//kaveh.userID),'0',8) , 'P_BarCode'));
{//kaveh
          if rdrCardCode = '' then
            rdrCardCode := FixLeft(IntToStr(recLog{[i]}//kaveh.userID),'0',8);
{//kaveh
          adoQry.close;
          adoQry.free;
          rdrDate := Milady2Shamsi(IntToStr(y)+'/'+IntToStr(m)+'/'+IntToStr(d));
          rdrTime := hh*60+mm;
          rdrCode := rdr.R_Code;
{//kaveh          for pish_Code := 0 to MaxPishCard do
            if PishCard_Key[Pish_Code]=  recLog[i].tnaEvent+1 then
            rdrStatus := PishCard_No[Pish_Code];}
{//kaveh
            rdrStatus := 0; //kaveh
          rdrBDate := rdrDate;
          rdrBTime := rdrTime;
          rdrBStatus := rdrStatus;
          rdrBRdrCode := rdr.R_Code;
          rdrChng := 0;
          rdrIOType:=0;
          if recLog{[i]}//kaveh.eventType=$37
{//kaveh
          then rdrIOType:=1
          else if recLog{[i]}//kaveh.eventType=$27
{//kaveh
           then case recLog{[i]}//kaveh.subevent of
{//kaveh
                    $2B : rdrIOType:=1;
                    $2C : rdrIOType:=2;
                    $2D : rdrIOType:=3;
                    $2E : rdrIOType:=4;
                    $2F : rdrIOType:=5;
                    $30 : rdrIOType:=6;
                    $31 : rdrIOType:=7;
                    else rdrIOType:=0;
               end;
          rdrUser := G_Options.username;
        end;
        inc(j);
      end;
    end;
    numOfSaved := 0;
    for j := 0 to cnt-1 do
      if true //kaveh {//kavehaddpishcard(ClkRec[j])}
{//kaveh
      then begin
        //kaveh if SaveClockRecord(ClkRec[j], REC_TEST, False) then inc(numOfSaved);
        inc(numOfSaved); //kaveh
      end
      {else result:=false};
{//kaveh    if endTime = '' then
      cnt := numOfSaved;
    DisConnect_BS(rdr);
  end;
}
end;
//kaveh ie

function SendDateTime_BS(rdr : TReaders; DT, TM : String) : BS_RET_CODE;
begin
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
    Result := BS_SetTime(hndl,DateTimeToMSec(Shamsi2Milady(DT) + ' ' + TM));
  end;
  DisConnect_BS(rdr);
end;

function GetDateTime_BS(rdr : TReaders; var DT, TM : String) : BS_RET_CODE;
var
  DtTm : integer;
  y,m,d,hh,mm,ss,ms : word;
begin
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
    Result := BS_GetTime(hndl,DtTm);
    DecodeDate(MSecToDateTime(DtTm),y,m,d);
    DecodeTime(MSecToDateTime(DtTm),hh,mm,ss,ms);
    DT := Milady2Shamsi(BeautifulDate(IntToStr(y) + '/' + IntToStr(m) + '/' + IntToStr(d)));
    TM := inttostr(hh) + ':' + inttostr(mm) + ':' + inttostr(ss);
  end;
  DisConnect_BS(rdr);
end;

function SendNotice_BS(rdr : TReaders; var WST : WideString) : BS_RET_CODE;
var
//  DtTm : integer;
//  y,m,d,hh,mm,ss,ms : word;
  WSTch : array [1..10] of Char;
  I: Integer;
begin
  Result := Connect_BS(rdr);
  if Result = BS_SUCCESS then
  begin
//    for I := 0 to 10 do //Length(WST) - 1 do
//    begin
//      WSTch[i] := WST[i];
//    end;
    WSTch[1] := #$FF;
    WSTch[2] := #0;
    Result := BS_SendNotice(hndl,WSTch);

//    DecodeDate(MSecToDateTime(DtTm),y,m,d);
//    DecodeTime(MSecToDateTime(DtTm),hh,mm,ss,ms);
//    DT := Milady2Shamsi(BeautifulDate(IntToStr(y) + '/' + IntToStr(m) + '/' + IntToStr(d)));
//    TM := inttostr(hh) + ':' + inttostr(mm) + ':' + inttostr(ss);
  end;
  DisConnect_BS(rdr);
end;



//Function  GetAllUserInfo(rdr : TReaders;var numOfUser: longword; var numOfTemplate: longword) : UFUserInfo_Array;
//var
//  usersInfo     : UFUserInfo_Array;
//  MaxTemplate   : LongWord;
//  i : integer;
//begin
//  if  Connect_UF(rdr) = UF_RET_SUCCESS then
//  begin
//    UF_GetMaxNumOfTemplate(MaxTemplate);
//    SetLength(usersInfo,MaxTemplate div 2);
//    if UF_GetAllUserInfo(usersInfo,numOfUser,numOfTemplate) = UF_RET_SUCCESS then
//    begin
//      SetLength(Result,numOfUser);
//      Result := copy(usersInfo,0,numOfUser);
////      for i := 0 to length(result) - 1 do
////        Result[i].userID := strtoint(IntToHex(Result[i].userID,0));
//    end;
//    DisConnect_UF(rdr);
//  end;
//end;


end.

