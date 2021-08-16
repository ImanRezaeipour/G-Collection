unit Cnstants;
interface

type
  STR_TYPE =  pchar;//WideString;//String[128];

const
  ALL_COLLECTION = 1;
  ALL_RECOVERY   = 2;
  NEW_RECOVERY   = 3;

  ERR_NONE     = 1;
  ERR_TIMEOUT  = 2;
  ERR_CHEKSUM  = 3;
  ERR_STX      = 4;
  ERR_ETX      = 5;
  ERR_OFF      = 6;
  MB_BUFFEMPTY = 7;
  MB_TRUEREC   = 8;
  MB_BADREC    = 9;
  MB_BADDATA   = 10;
  MTT_OFFLINE  = 15;

  RDR_Z80   = 100;
  RDR_Z84   = 101;
  RDR_PROXI = 102;

  PRN_LX          = 0;
  PRN_LQ          = 1;
  PRN_CITIZEN3551 = 2;
  PRN_CITIZEN3541 = 3;
  PRN_ITHACA      = 4;


type TReaders = record
  R_Code        : Byte;
  R_Name        : String[20];
  R_Active      : Boolean;
  R_Port        : Byte;
  R_BaudNo      : Byte;
  R_Type        : Byte;
  R_RTS         : Boolean;
  R_OnLine      : Boolean;
  R_IP          : String;
  R_IsCom       : Boolean;
  R_TCP         : Boolean;
  R_Station     : integer;
  R_display     : byte;
  R_Slave       : array[1..16] of byte;

  rTime         : String[8];
  rOffCount     : Byte;
  rValid        : Boolean;
end;

type TTerminalRec = Record
  rdrCardCode  : String[8];
  rdrDate      : String[10];
  rdrTime      : Integer;
  rdrCode      : Integer;
  rdrStatus    : Integer;

  rdrBDate     : String[10];
  rdrBTime     : Integer;
  rdrBStatus   : Integer;
  rdrBRdrCode  : Byte;
  rdrChng      : Integer;
  rdrUser      : string[15];
end;


var
  AUTOCONTROL  : Boolean = False;
  USERCONTROL  : Boolean = False;

  LastBaud     : Byte = 20;
implementation

end.
