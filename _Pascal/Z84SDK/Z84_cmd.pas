unit Z84_cmd;

interface

uses
    ShareMem, Globals, Cnstants,DB,DBTABLES;

procedure Delay(n:integer);

PROCEDURE FreeStringMem(str : pchar);stdcall;


 (*************** Z84 Commands ***************)

function  Z84_LinkTest(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;

function  Z84_ReStart(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_Initial(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_ReadVersion(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var VersionST : pchar ; is98 : boolean) : Boolean; stdcall;

function  Z84_SendDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DT, TM : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var DT, TM : STR_TYPE ; is98 : boolean) : Boolean; stdcall;

function  Z84_SendLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST1, ST2, ST3 : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST1, ST2, ST3 : STR_TYPE ; is98 : boolean) : Boolean; stdcall;

function  Z84_ChangeAddress(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewAddress : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_ChangeBaudRate(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewBD_R : LongInt ; is98 : boolean) : Boolean; stdcall;

function  Z84_SendReaderMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; msg1 , msg2, msg3, msg4 : pchar ; is98 : boolean) : Boolean; stdcall;
function  Z84_SendPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode, Msg : pchar ; is98 : boolean) : Byte; stdcall;
function  Z84_GetPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : STR_TYPE; var Msg : STR_TYPE ; is98 : boolean) : Byte; stdcall;
function  Z84_DelPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : pchar ; is98 : boolean) : Byte; stdcall;
function  Z84_DeleteAllReaderMessage(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetOpenDoor_Normal(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, DoorTime : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_SetOpenDoor_All(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_SetCloseDoor(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_DelAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_DelInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_DelAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetFunctionKeys(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, FKey1, FKey2, FKey3, FKey4 : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetFunctionKeys(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var FKey1, FKey2, FKey3, FKey4 : Byte ; is98 : boolean) : Boolean; stdcall;
function  Z84_ChangeFunctionKeysActive(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; KeyActive : Boolean ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; PishCard, CardNo : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var PishCard, CardNo : STR_TYPE ; is98 : boolean) : Boolean; stdcall;

function  Z84_SetLimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; FromCard, ToCard : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
function  Z84_GetLimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var FromCard, ToCard : STR_TYPE ; is98 : boolean) : Boolean; stdcall;

function  Z84_ChangeOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; onLine : Boolean ; is98 : boolean) : Boolean; stdcall;
function  Z84_ReadOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var onLine : Boolean ; is98 : boolean) : Boolean; stdcall;

procedure Z84_GetRecord(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : pchar; IsFirst : Boolean; var retVal : Byte; var Data : PChar; is98 : boolean); stdcall;
procedure Z84_GetRecordI(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                        var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt ; is98 : boolean); stdcall;
function  Z84_GetRecordInFile(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT, FName : STR_TYPE; var retVal : Byte ; is98 : boolean) : Integer; stdcall;

procedure MTT_OnLineRec     (RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte ; is98 : boolean); stdcall;

function  Z84_PrintToReaders(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; st : pchar; DblWidth , color , is98 : boolean):boolean;stdcall;
function  Z84_PrintToPrinter(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; st : String ; is98 : boolean):boolean; stdcall;
function  Z84_CutPrint      (RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; is98 : boolean):boolean; stdcall;

function  Z84_SendBeep(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; count : Char; is98 : boolean) : Boolean; stdcall;

function Z84_SetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : pchar;is98 :boolean) : boolean;stdcall;
function Z84_GetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;

function Z84_SetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : PChar;is98 :boolean) : boolean;stdcall;
function Z84_GetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;



///////////////////////////////////////////////LAN Function ///////////////////////////////////////////////////
function  Z84_LinkTest_LAN(RdrCode : Byte; prtcl : byte ; IP : pchar) : Boolean; stdcall;


function  Z84_ReStart_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;

function  Z84_Initial_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
function  Z84_ReadVersion_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var VersionST : STR_TYPE) : Boolean; stdcall;

function  Z84_SendDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DT, TM : STR_TYPE) : Boolean; stdcall;
function  Z84_GetDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var DT, TM : STR_TYPE) : Boolean; stdcall;

function  Z84_ChangeAddress_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; NewAddress : Byte) : Boolean; stdcall;

function  Z84_SendLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;
function  Z84_GetLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;

function  Z84_SendReaderMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; msg1 : STR_TYPE; msg2: STR_TYPE; msg3: STR_TYPE; msg4 : STR_TYPE) : Boolean; stdcall;
function  Z84_SendPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode, Msg : STR_TYPE) : Byte; stdcall;
function  Z84_GetPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode : STR_TYPE; var Msg : STR_TYPE) : Byte; stdcall;
function  Z84_DelPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode : STR_TYPE) : Byte; stdcall;
function  Z84_DeleteAllReaderMessage_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;

function  Z84_SetOpenDoor_Normal_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DoorTime : Byte) : Boolean; stdcall;
function  Z84_SetOpenDoor_All_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DoorTime : STR_TYPE) : Boolean; stdcall;
function  Z84_SetCloseDoor_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ; DoorTime : STR_TYPE) : Boolean; stdcall;

function  Z84_SetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
function  Z84_GetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE) : Boolean; stdcall;
function  Z84_DelAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;

function  Z84_SetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
function  Z84_GetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE) : Boolean; stdcall;
function  Z84_DelInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;

function  Z84_SetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
function  Z84_GetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE ) : Boolean; stdcall;
function  Z84_DelAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ) : Boolean; stdcall;

function  Z84_SetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ; FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;
function  Z84_GetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;
function  Z84_ChangeFunctionKeysActive_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; KeyActive : Boolean ) : Boolean; stdcall;

function  Z84_SetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;
function  Z84_GetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; var PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;

function  Z84_SetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;
function  Z84_GetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; var FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;

function  Z84_ChangeOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; onLine : Boolean ) : Boolean; stdcall;
function  Z84_ReadOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var onLine : Boolean ) : Boolean; stdcall;

procedure Z84_GetRecord_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; rType : Byte; DT : STR_TYPE; IsFirst : Boolean; var retVal : Byte; var Data : STR_TYPE ); stdcall;

procedure Z84_GetRecordI_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ;rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                         var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt ); stdcall;

function  Z84_GetRecordInFile_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; rType : Byte; DT, FName : STR_TYPE; var retVal : Byte ) : Integer; stdcall;

procedure MTT_OnLineRec_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte ); stdcall;

function  Z84_PrintToReaders_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; printer_type : byte ; st : string; DblWidth , color :boolean):boolean; stdcall;
function  Z84_PrintToPrinter_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; st : String ):boolean; stdcall;
function  Z84_CutPrint_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; printer_type : byte ):boolean; stdcall;

function Z84_SendBeep_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; count : Char) : Boolean; stdcall;
function Z84_SetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : ansistring) : boolean;stdcall;
function Z84_GetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : ansistring) : boolean;stdcall;

function Z84_SetAuthority_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : AnsiString) : boolean;stdcall;
function Z84_GetAuthority_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : ansistring) : boolean;stdcall;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
implementation


uses
  ComTools, Forms, SysUtils, Code_Sys, TCP_UDP, Funcs;
var
  DelayLoop : Integer;

(*************** Link Test ***************)
function  Z84_LinkTest(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
const
  RAMZ = 'DPCOLINK';
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $01, 0, RAMZ);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 15, 100, getVal,is98);
    if (getVal = ERR_NONE) and (ORD(PK[4]) = $01) and (Ord(PK[3]) = RdrCode) then
      OK := (Copy(PK, 6, 8) = RAMZ)
    else
      OK := False;
  end;

  Z84_LinkTest := OK;
  frmComTools.Destroy;
end;

(*************** ReStart ***************)
function Z84_ReStart(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0C, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_ReStart := OK;
  frmComTools.Destroy;
end;

(*************** Initial ***************)
function Z84_Initial(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $1F, 0, 'REINITIALIZATION');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_Initial := OK;
  frmComTools.Destroy;
end;


(*************** Read Version ***************)
function Z84_ReadVersion(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var VersionST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  VersionST := '';
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0E, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 50, 50, getVal,is98);
    if getVal = ERR_NONE then
    begin
      if (Ord(PK[4]) = $0E) and (Ord(PK[3]) = RdrCode) then
      begin
        VersionST := pchar(Copy(PK, 6, 40));
        OK := True;
      end
      else
        OK := False;
    end
    else
      OK := False;
  end;
  Z84_ReadVersion := OK;
  frmComTools.Destroy;
end;

(*************** Send Date & Time ***************)
function Z84_SendDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DT, TM : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0B, 0,
                             DT[3]+DT[4]+DT[6]+DT[7]+DT[9]+DT[10]+
                             TM[1]+TM[2]+TM[4]+TM[5]+TM[7]+TM[8]);

  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SendDateTime := OK;
  frmComTools.Destroy;
end;

(*************** Get Date & Time ***************)
function Z84_GetDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var DT, TM : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
  stDT ,stTM: string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $20, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 19, 100, getVal,is98);

    if (getVal = ERR_NONE) and (Ord(PK[4]) = $21) and (Ord(PK[3]) = RdrCode) then
    begin
      OK := True;
      stDT := Copy(PK, 6, 6);
      Insert('/', stDT, 3);
      Insert('/', stDT, 6);
      stTM := Copy(PK, 12, 6);
      Insert(':', stTM, 3);
      Insert(':', stTM, 6);
      DT := pchar(stDT);
      TM := pchar(stTM);
    end
    else
      OK := False;
  end;

  Z84_GetDateTime := OK;
  frmComTools.Destroy;
end;


function Z84_ChangeAddress(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewAddress : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0F, 0, Chr(NewAddress));
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = NewAddress));
  end;
  Z84_ChangeAddress := OK;
  frmComTools.Destroy;
end;

(*************** Change Baud Rate ***************)
function Z84_ChangeBaudRate(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewBD_R : LongInt ; is98 : boolean) : Boolean; stdcall;
var
  BD : Char;
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  if NewBD_R = 2400 then       NewBD_R := 7
  else if NewBD_R = 4800 then  NewBD_R := 8
  else if NewBD_R = 9600 then  NewBD_R := 9
  else if NewBD_R = 19200 then NewBD_R := 10
  else if NewBD_R= 38400 then  NewBD_R := 11
  else                         NewBD_R := 9;

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  BD := Chr(IntToBCD(NewBD_R));
  Z84_MakePocket(PK, RdrCode, $2D, 0, BD);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (ORD(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;
  Z84_ChangeBaudRate := OK;
  frmComTools.Destroy;
end;

(*************** Set Limit Time ***************)
function Z84_SendLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST1, ST2, ST3 : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  getVal : Byte;
  ST, PK : String;
  OK : Boolean;
begin
  ST := #1'L'#12;

  ST := ST + StrToBCD(ST1, 1) + StrToBCD(ST1, 4) +
             StrToBCD(ST1, 6) + StrToBCD(ST1, 9);

  ST := ST + StrToBCD(ST2, 1) + StrToBCD(ST2, 4) +
             StrToBCD(ST2, 6) + StrToBCD(ST2, 9);

  ST := ST + StrToBCD(ST3, 1) + StrToBCD(ST3, 4) +
             StrToBCD(ST3, 6) + StrToBCD(ST3, 9);

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $48, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 200, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SendLimitTime := OK;
  frmComTools.Destroy;
end;

(*************** Get Limit Time ***************)
function Z84_GetLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST1, ST2, ST3 : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  getVal : Byte;
  ST, PK : String;
  OK : Boolean;
  _ST1 ,_ST2,_ST3 : string;
begin
  ST := #1'L'#12;

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $49, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 40, 100, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[4]) = $48) and (Ord(PK[3]) = RdrCode) then
    begin
      OK := True;
      ST1 := pchar(BCDToStr(PK[09]) + ':' + BCDToStr(PK[10]) + ' - ' +
             BCDToStr(PK[11]) + ':' + BCDToStr(PK[12]));
      ST2 := pchar(BCDToStr(PK[13]) + ':' + BCDToStr(PK[14]) + ' - ' +
             BCDToStr(PK[15]) + ':' + BCDToStr(PK[16]));
      ST3 := pchar(BCDToStr(PK[17]) + ':' + BCDToStr(PK[18]) + ' - ' +
             BCDToStr(PK[19]) + ':' + BCDToStr(PK[20]));
    end
    else
      OK := False;
  end;

  Z84_GetLimitTime := OK;
  frmComTools.Destroy;
end;

(*************** Send Message To Reader ***************)
function  Z84_SendReaderMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; msg1 , msg2, msg3, msg4 : PChar ; is98 : boolean) : Boolean; stdcall;
var
  S, PK : String;
  i, getVal : Byte;
  OK : Boolean;

begin
  OK := True;
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  for i := 1 to 4 do
  begin
    case i of
      1: s := msg1;
      2: s := msg2;
      3: s := msg3;
      4: s := msg4;
    end;
   S := StrRev(WinToDos(S,WIN_MICROSOFT_SYS , DOS_IR_SYS));
    s := StrRev(StrRev(FixLeft(s,' ',16)));
    if S <> '' then
    begin
      S := chr(i-1) + #0#0 + S;
      Z84_MakePocket(PK, RdrCode, $13, 0, S);
      if not SendPocket(PK) then
        OK := OK AND False
      else
      begin
        Z84_GetPocket(PK, 7, 100, getVal,is98);
        if (getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode) then
          OK := OK AND True
        else
          OK := OK AND False;
      end;
    end;

  end;
  Z84_SendReaderMsg := OK;

  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

(*************** Send Message for personel ***************)
function Z84_SendPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode, Msg : pchar ; is98 : boolean) : Byte; stdcall;
var
  PK : String;
  i, getVal, RetVal : Byte;
  _CardCode , _msg : string;
begin
  _CardCode := CardCode;
  _msg := Msg;
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  for i := 1 to 8-Length(_CardCode) do
    _CardCode := '0' + _CardCode;
  _CardCode := BarCode4(_CardCode);
  msg := pchar(StrRev(WinToDos(_msg,WIN_MICROSOFT_SYS , DOS_IR_SYS)));
  _Msg := FixLen(_Msg, ' ', 64);
  Z84_MakePocket(PK, RdrCode, $41, 0, _CardCode + _Msg);
  if not SendPocket(PK) then
    RetVal := 0
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
      RetVal := Ord(PK[4])
    else
      RetVal := 0;
  end;

  Z84_SendPersonMsg := RetVal;
  frmComTools.Destroy;
end;

function pchartostr(pch : pchar) : string;
begin
  result := pch;
end;

function strtopchar(st : string) : pchar;
begin
  result := pchar(st);
end;

(*************** Get Personel Message ***************)
function Z84_GetPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : STR_TYPE; var Msg : STR_TYPE ; is98 : boolean) : Byte; stdcall;
var
  PK : String;
  i, getVal, RetVal : Byte;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Msg := '';
  for i := 1 to 8-Length(CardCode) do
    CardCode := StrCat('0' , CardCode);
  CardCode := pchar(BarCode4(pchartostr(CardCode)));
  Z84_MakePocket(PK, RdrCode, $44, 0, CardCode);
  if not SendPocket(PK) then
    RetVal := 0
  else
  begin
    Z84_GetPocket(PK, 75, 50, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
    begin
      RetVal := Ord(PK[4]);
      if RetVal = $46 then
      begin
        Msg := pchar(Copy(PK, 10, 64));
        Msg := pchar(Trim(Msg));
      end;
    end
    else
      RetVal := 0;
  end;

  Z84_GetPersonMsg := RetVal;
  frmComTools.Destroy;
end;

(*************** Delete Personel Message ***************)
function Z84_DelPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : pchar ; is98 : boolean) : Byte; stdcall;
var
  _CardCode , PK : String;
  i, getVal, RetVal : Byte;

begin
  _CardCode := CardCode;
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  for i := 1 to 8-Length(_CardCode) do
    _CardCode := '0' + _CardCode;
  _CardCode := BarCode4(_CardCode);
  Z84_MakePocket(PK, RdrCode, $47, 0, _CardCode);
  if not SendPocket(PK) then
    RetVal := 0
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
      RetVal := Ord(PK[4])
    else
      RetVal := 0;
  end;

  Z84_DelPersonMsg := RetVal;
  frmComTools.Destroy;
end;

(*************** Delete Personel Message ***************)
function Z84_DeleteAllReaderMessage(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $40, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (ORD(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_DeleteAllReaderMessage := OK;
  frmComTools.Destroy;
end;

(*************** Set Open Door In Normal Mode ***************)
function Z84_SetOpenDoor_Normal(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, DoorTime : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $2C, 0, Chr(DoorTime+1));
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) AND (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetOpenDoor_Normal := OK;
  frmComTools.Destroy;
end;

(*************** Set Open Door All Time ***************)
function Z84_SetOpenDoor_All(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  n : Integer;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  n := StrToInt(DoorTime);
  DoorTime := strtopchar(Chr(n mod 255) + Chr(n div 255));
  Z84_MakePocket(PK, RdrCode, $2A, 0, DoorTime);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) AND (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetOpenDoor_All := OK;
  frmComTools.Destroy;
end;

(***************** Set Close Door *****************)
function Z84_SetCloseDoor(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  n : Integer;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  n := StrToInt(DoorTime);
  DoorTime := strtopchar(Chr(n mod 256) + Chr(n div 256));
  Z84_MakePocket(PK, RdrCode, $2B, 0, DoorTime);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) AND (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetCloseDoor := OK;
  frmComTools.Destroy;
end;

(***************** Set Alarm Time *****************)
function Z84_SetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
  _ST : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + StrToBCD(ST, 1) + StrToBCD(ST, 4);
    _ST := st;
    Delete(_ST, 1, 5);
    ST := pchar(_ST);
  end;

  Z84_MakePocket(PK, RdrCode, $22, 0, S);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetAlarmTimes := OK;
  frmComTools.Destroy;
end;

(***************** Get Alarm Time *****************)
function Z84_GetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal, i : Byte;
  OK : Boolean;
  _ST : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $24, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 75, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $25) and (Ord(PK[3]) = RdrCode));
    if OK then
    begin
      _ST := '';
      i := 6;
      while i <= 44 do
      begin
        if PK[i] <> #255 then
          _ST := _ST + BCDToStr(PK[i]) + ':' + BCDToStr(PK[i+1])
        else
          _ST := _ST + '00:00';

        Inc(i, 2);
      end;

    end;
  end;
  ST := pchar(_St);
  Z84_GetAlarmTimes := OK;
  frmComTools.Destroy;
end;

(***************** Get Alarm Time *****************)
function Z84_DelAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $23, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_DelAlarmTimes := OK;
  frmComTools.Destroy;
end;

(***************** Set Invalid Card *****************)
function Z84_SetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
  _ST : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + BarCode4(Copy(ST, 1, 8));
    _ST := st;
    Delete(_ST, 1, 8);
    st := pchar(_ST);
  end;

  Z84_MakePocket(PK, RdrCode, $26, 0, S);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetInvalidCards := OK;
  frmComTools.Destroy;
end;

(***************** Get Invalid Card *****************)
function Z84_GetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  S, PK : String;
  getVal, i : Byte;
  OK : Boolean;
  _ST : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + StrToBCD(ST, 1) + StrToBCD(ST, 4);
    _ST := st;
    Delete(_ST, 1, 5);
    st := pchar(_ST);
  end;

  Z84_MakePocket(PK, RdrCode, $28, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 100, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $29) and (Ord(PK[3]) = RdrCode));
    if OK then
    begin
      ST := '';
      Delete(PK, 1, 5);
      for i := 1 to 10 do
      begin
        if PK[1] <> #255 then
        begin
          ST := StrCat(ST , pchar(FixLeft(BarCode8(Copy(PK, 1, 4)), '0', 8)));
          Delete(PK, 1, 4);
        end
        else
          ST := strcat(ST , '00000000');
      end;
    end;
  end;

  Z84_GetInvalidCards := OK;
  frmComTools.Destroy;
end;

(***************** Delete Invalid Card *****************)
function Z84_DelInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $27, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_DelInvalidCards := OK;
  frmComTools.Destroy;
end;

(***************** Set Access Code *****************)
function Z84_SetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
  _ST : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + StrToBCD(ST, 1);
    _ST := st;
    Delete(_ST, 1, 2);
    st := pchar(_ST);

  end;

  Z84_MakePocket(PK, RdrCode, $09, 0, S);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetAccessCode := OK;
  frmComTools.Destroy;
end;

(***************** Get Access Code *****************)
function Z84_GetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal, i : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0D, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 50, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $0D) and (Ord(PK[3]) = RdrCode));
    if OK then
    begin
      ST := '';
      Delete(PK, 1, 5);
      for i := 1 to 5 do
      begin
        if PK[1] <> #255 then
          ST := strcat(ST , pchar(BCDToStr(PK[1]) + BCDToStr(PK[2])))
        else
          ST := strcat(ST , '0000');

        Delete(PK, 1, 2);
      end;

    end;
  end;

  Z84_GetAccessCode := OK;
  frmComTools.Destroy;
end;

(***************** Delete Access Code *****************)
function Z84_DelAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $0A, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_DelAccessCode := OK;
  frmComTools.Destroy;
end;

(***************** Set Function Keys *****************)
function Z84_SetFunctionKeys(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, FKey1, FKey2, FKey3, FKey4 : Byte ; is98 : boolean) : Boolean; stdcall;
var
  getVal : Byte;
  ST, PK : String;
  OK : Boolean;
begin
  ST := #0'F'#8 +
        #$F1 + Str_PBCD(IntToStr(FKey1), 0) +
        #$F2 + Str_PBCD(IntToStr(FKey2), 0) +
        #$F3 + Str_PBCD(IntToStr(FKey3), 0) +
        #$F4 + Str_PBCD(IntToStr(FKey4), 0);

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $48, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 200, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetFunctionKeys := OK;
  frmComTools.Destroy;
end;

(***************** Get Function Keys *****************)
function Z84_GetFunctionKeys(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var FKey1, FKey2, FKey3, FKey4 : Byte ; is98 : boolean) : Boolean; stdcall;
var
  getVal : Byte;
  ST, PK : String;
  OK : Boolean;
begin
  ST := #0'F';

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $49, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 40, 100, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[4]) = $48) and (Ord(PK[3]) = RdrCode) then
    begin
      OK := True;
      if PK[09] = #$F1 then
        FKey1 := StrToInt(PBCD_Str(PK[10], 0))
      else
        FKey1 := 0;

      if PK[11] = #$F2 then
        FKey2 := StrToInt(PBCD_Str(PK[12], 0))
      else
        FKey2 := 0;

      if PK[13] = #$F3 then
        FKey3 := StrToInt(PBCD_Str(PK[14], 0))
      else
        FKey3 := 0;

      if PK[15] = #$F4 then
        FKey4 := StrToInt(PBCD_Str(PK[16], 0))
      else
        FKey4 := 0;
    end
    else
      OK := False;
  end;

  Z84_GetFunctionKeys := OK;
  frmComTools.Destroy;
end;

(***************** Change Functions Keys Operation *****************)
function Z84_ChangeFunctionKeysActive(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; KeyActive : Boolean ; is98 : boolean) : Boolean; stdcall;
var
  getVal : Byte;
  ST, PK : String;
  OK : Boolean;
begin
  if KeyActive then
    ST := 'E'
  else
    ST := 'D';

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $34, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_ChangeFunctionKeysActive := OK;
  frmComTools.Destroy;
end;

(***************** Get PishCard *****************)
function Z84_SetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; PishCard, CardNo : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  ST : STR_TYPE;
  getVal: Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  if (PishCard = '') or (CardNo = '') then
    ST := pchar(Chr(No) + #255#255#255#255#255)
  else
    ST := pchar(Chr(No) + BarCode4(FixLeft(CardNo, '0', 8)) + StrToBCD(FixLeft(PishCard, '0', 2), 1));

  Z84_MakePocket(PK, RdrCode, $57, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetPishCard := OK;
  frmComTools.Destroy;
end;

(***************** Get PishCard *****************)
function Z84_GetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var PishCard, CardNo : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $58, 0, Chr(No));
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 13, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $57) and (Ord(PK[3]) = RdrCode));
    if OK then
    begin
      Delete(PK, 1, 6);
      if PK[1] <> #255 then
      begin
        CardNo := pchar(BarCode8(Copy(PK, 1, 4)));
        PishCard := pchar(BCDToStr(PK[5]));
      end
      else
        CardNo := '00000000';
    end;
  end;

  Z84_GetPishCard := OK;
  frmComTools.Destroy;
end;

(***************** Set Limit Card *****************)
function Z84_SetLimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; FromCard, ToCard : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  ST : STR_TYPE;
  getVal: Byte;
  OK : Boolean;
begin
  if (FromCard = '') or (ToCard = '') then
    ST := pchar(Chr(No) + #255#255#255#255#255#255#255#255)
  else
    ST := pchar(Chr(No) + Str_PBCD(FromCard, 8) + Str_PBCD(ToCard, 8));

  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $36, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_SetLimitCard := OK;
  frmComTools.Destroy;
end;

(***************** Get Limit Card *****************)
function Z84_GetlimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var FromCard, ToCard : STR_TYPE ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $37, 0, Chr(No));
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 16, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $36) and (Ord(PK[3]) = RdrCode));
    if OK then
    begin
      Delete(PK, 1, 6);
      FromCard := pchar(PBCD_Str(Copy(PK, 1, 4), 8));
      ToCard := pchar(PBCD_Str(Copy(PK, 5, 4), 8));
    end;
  end;

  Z84_GetLimitCard := OK;
  frmComTools.Destroy;
end;

(***************** Change online/offline relation *****************)
function Z84_ChangeOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; onLine : Boolean ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  if onLine then
    Z84_MakePocket(PK, RdrCode, $11, 0, 'S')
  else
    Z84_MakePocket(PK, RdrCode, $11, 0, 'I');

  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 16, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;

  Z84_ChangeOnOffMode := OK;
  frmComTools.Destroy;
end;


(***************** Read online/offline relation *****************)
function Z84_ReadOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var onLine : Boolean ; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $12, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 16, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $12) and (Ord(PK[3]) = RdrCode));
    if OK then
      onLine := (PK[6] = 'S');
  end;

  Z84_ReadOnOffMode := OK;
  frmComTools.Destroy;
end;

(***************** Read One Record *****************)
procedure Z84_GetRecord(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : PChar; IsFirst : Boolean; var retVal : Byte; var Data : PChar ; is98 : boolean); stdcall;
var
  n, getVal : Byte;
  PK : String;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  if IsFirst then
  begin
    case rType of
      ALL_COLLECTION: Z84_MakePocket(PK, RdrCode, $02, 0, '');
      ALL_RECOVERY  : Z84_MakePocket(PK, RdrCode, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
      NEW_RECOVERY  : Z84_MakePocket(PK, RdrCode, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    end;
  end
  else if retVal = MB_TRUEREC then
    Z84_MakePocket(PK, RdrCode, $06, 0, '')
  else
    Z84_MakePocket(PK, RdrCode, $15, 0, '');

  if not SendPocket(PK) then
    retVal := ERR_OFF
  else
  begin
    n := 0;
    repeat
      Inc(n);
      //Z84_GetPocket(PK, 38, 100, getVal);//Mellat Bank
      Sleep(100);
      Z84_GetPocket(PK, 30, 100, getVal,is98);
      if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
      begin
        case Ord(PK[4]) of
          3: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          4: //Record Exists
          begin
            Data := pchar(Copy(PK, 6, 23));
            //Data := Copy(PK, 6, 31);//bank melat
            retVal := MB_TRUEREC;
          end;

          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else
        retVal := MB_BADREC;
    until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
  end;
  frmComTools.free;
end;

(***************** Read One Record *****************)
procedure Z84_GetRecordI(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                         var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt ; is98 : boolean); stdcall;
var
  n, getVal : Byte;
  PK : String;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  if IsFirst then
  begin
    case rType of
      ALL_COLLECTION: Z84_MakePocket(PK, RdrCode, $02, 0, '');
      ALL_RECOVERY  : Z84_MakePocket(PK, RdrCode, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
      NEW_RECOVERY  : Z84_MakePocket(PK, RdrCode, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    end;
  end
  else if retVal = MB_TRUEREC then
    Z84_MakePocket(PK, RdrCode, $06, 0, '')
  else
    Z84_MakePocket(PK, RdrCode, $15, 0, '');

  if not SendPocket(PK) then
    retVal := ERR_OFF
  else
  begin
    n := 0;
    repeat
      Inc(n);
      //Z84_GetPocket(PK, 38, 100, getVal);//Mellat Bank
      Z84_GetPocket(PK, 30, 100, getVal,is98);
      if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
      begin
        case Ord(PK[4]) of
          3: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          4: //Record Exists
          begin
            //Data := Copy(PK, 6, 23);

            recType := StrToInt(Copy(PK, 9, 2));
            recDate := StrToInt(Copy(PK, 11, 6));
            recTime := StrToInt(Copy(PK, 17, 4));
            recCard := StrToInt(Copy(PK, 21, 8));

            retVal := MB_TRUEREC;
          end;

          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else
        retVal := MB_BADREC;
    until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
  end;
  frmComTools.Destroy;
end;

(***************** Getting records and save to file *****************)
function Z84_GetRecordInFile(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT, FName : STR_TYPE; var retVal : Byte ; is98 : boolean) : Integer; stdcall;
var
  n, getVal : Byte;
  PK : String;
  data : STR_TYPE;
  f : TextFile;
  recCount : Integer;
begin
  recCount := 0;
  Application.CreateForm(TfrmComTools, frmComTools);
  AssignFile(f, FName);
  ReWrite(f);
  Rs232Initial(BD_R, ComNo, Prtcl);
  case rType of
    ALL_COLLECTION: Z84_MakePocket(PK, RdrCode, $02, 0, '');
    ALL_RECOVERY  : Z84_MakePocket(PK, RdrCode, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    NEW_RECOVERY  : Z84_MakePocket(PK, RdrCode, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
  end;

  n := 0;
  repeat
    if not SendPocket(PK) then
      retVal := ERR_OFF
    else
    begin
      n := 0;
      repeat
        Inc(n);
        //Z84_GetPocket(PK, 38, 100, getVal);//Mellat Bank
        Z84_GetPocket(PK, 30, 100, getVal,is98);
        if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
        begin
          case Ord(PK[4]) of
            3: //Buffer Empty
              retVal := MB_BUFFEMPTY;

            4: //Record Exists
            begin
              Inc(recCount);
              Data := pchar(Copy(PK, 6, 23));
              WriteLn(f, Data);
              //Data := Copy(PK, 6, 31);//bank melat
              retVal := MB_TRUEREC;
            end;

            else //Error in read data
              retVal := MB_BADREC;
          end;
        end
        else
          retVal := getVal;
      until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
    end;
    if retVal = MB_TRUEREC then
      Z84_MakePocket(PK, RdrCode, $06, 0, '')
    else
      Z84_MakePocket(PK, RdrCode, $15, 0, '');
  until (retVal in [MB_BUFFEMPTY, ERR_OFF]) or (n = 2);
  CloseFile(f);
  frmComTools.Destroy;
  Result := recCount;
end;


(***************** Getting MTT online records *****************)
procedure MTT_OnLineRec(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte ; is98 : boolean); stdcall;
var
  getVal : Byte;
  PK : String;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  data := '';
  if isGetRec then
    Z84_MakePocket(PK, RdrCode, $31, 0, '')
  else if retCode = 0 then
    Z84_MakePocket(PK, RdrCode, $06, 0, '')
  else
    Z84_MakePocket(PK, RdrCode, $15, 0, Chr(retCode));

  if not SendPocket(PK) then
    retCode := ERR_OFF
  else
  begin
    Z84_GetPocket(PK, 30, 100, getVal,is98);
    if (getVal = ERR_NONE) and (Ord(PK[3]) = RdrCode) then
    begin
      case Ord(PK[4]) of
        $03: //Buffer Empty
          retCode := MB_BUFFEMPTY;

        $10: //Record Exists
        begin
          data := pchar(Copy(PK, 6, 23));
          retCode := MB_TRUEREC;
        end;

        $15:
          retCode := MTT_OFFLINE;

        else //Error in read data
          retCode := MB_BADREC;
      end;
    end
    else
      retCode := MB_BADREC;
  end;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

(***************** send String to printer *****************)
function Z84_PrintToReaders(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; st : pchar; DblWidth , color , is98 : boolean):boolean; stdcall;
const
  MaxLoop = 5;
var
  PK : String;
  Status, n : Byte;
  st1 : string;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);

  ST1 := StrRev(WinToDos(pchartostr(ST),WIN_MICROSOFT_SYS , DOS_IR_SYS)) + #13#10;

  case printer_type of
    PRN_LX:
    begin
      ST1 := #27#120#0 + ST1;
      if DblWidth then ST1 := #14 + ST1;
    end;

    PRN_LQ:
    begin
      ST1 := #27#120#1 + ST1;
      if DblWidth then ST1 := #14 + ST1;
    end;

    PRN_CITIZEN3551,
    PRN_CITIZEN3541:
    begin
      ST1 := #27'1' + ST1;
      if DblWidth then ST1 := #14 + ST1 + #20;
      if Color then
      begin
        if printer_type = PRN_CITIZEN3551 then
          ST1 := #27'4' + ST1 + #27'5'
        else
          ST1 := #$13+ST1;
      end;
    end;

    PRN_ITHACA:
    begin
      if DblWidth then ST1 := #27'W'#1 + ST1 + #27'W'#0;
      if Color then
        ST1 := #27'c'#1 + ST1
      else
        ST1 := #27'c'#0 + ST1;
    end;
  end;

  n := 0;
  repeat
    Delay(100);
    result := True;
    Inc(n);
    Z84_MakePocket(PK, RdrCode, $1C, 0, ST1);
    if not SendPocket(PK) then
      result := False
    else
    begin
      Z84_GetPocket(PK, 30,100, Status,false);
      if (Status = 0) and (Ord(PK[3]) = RdrCode) then
      begin
        case Ord(PK[4]) of
          $06 : result := True;
          $15 : result := False;
          else
          begin
            result := False;
            //n := MaxLoop;
          end;
        end;
      end
      else
        result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = RdrCode));
    end;
  until (n = MaxLoop) or result;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

(***************** Direct Print to Printer *****************)
function Z84_PrintToPrinter(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; st : String ; is98 : boolean):boolean; stdcall;
const
  MaxLoop = 5;
var
  PK : String;
  Status, n : Byte;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  st := st + #13#10;
  n := 0;
  repeat
    Delay(100);
    result := True;
    Inc(n);
    Z84_MakePocket(PK, RdrCode, $1C, 0, ST);
    if not SendPocket(PK) then
      result := False
    else
    begin
      Z84_GetPocket(PK, 30,100, Status,false);
      if (Status = 0) and (Ord(PK[3]) = RdrCode) then
      begin
        case Ord(PK[4]) of
          $06 : result := True;
          $15 : result := False;
          else
          begin
            result := False;
            //n := MaxLoop;
          end;
        end;
      end
      else
        result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = RdrCode));
    end;
  until (n = MaxLoop) or result;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

(***************** send Cut Command to station *****************)
function Z84_CutPrint(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; is98 : boolean):boolean; stdcall;
const
  MaxLoop = 5;
var
  ST, PK : String;
  Status, n : Byte;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);

  if printer_type in [PRN_CITIZEN3551, PRN_CITIZEN3541] then
  begin
    if printer_type = PRN_CITIZEN3551 then
      ST := #27'd0'
    else
      ST := #27'P'#0;

    n := 0;
    repeat
      Delay(100);
      Inc(n);
      Z84_MakePocket(PK, RdrCode, $1C, 0, ST);
      if not SendPocket(PK) then
        result := False
      else
      begin
        Z84_GetPocket(PK, 30,100, Status,false);
        if (Status = 0) and (Ord(PK[3]) = RdrCode) then
        begin
          case Ord(PK[4]) of
            $06 : result := True;
            $15 : result := False;
            else  result := False;
          end;
        end
        else
          result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = RdrCode));
      end;
    until (n = MaxLoop) or result;
  end
  else if printer_type = PRN_ITHACA then
  begin
    ST := #27'd' + chr(10) + #27'v';

    n := 0;
    repeat
      Delay(100);
      Inc(n);

      Z84_MakePocket(PK, RdrCode, $1C, 0, ST);
      if not SendPocket(PK) then
        result := False
      else
      begin
        Z84_GetPocket(PK, 30,100, Status,false);
        if (Status = 0) and (Ord(PK[3]) = RdrCode) then
        begin
          case Ord(PK[4]) of
            $06 : result := True;
            $15 : result := False;
            else  result := False;
          end;
        end
        else
          result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = RdrCode));
      end;
    until (n = MaxLoop) or result;
  end;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

(***************** send beep to station Buzzer *****************)
function  Z84_SendBeep(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; count : Char; is98 : boolean) : Boolean; stdcall;
var
  PK : String;
  i, getVal : Byte;
  OK : Boolean;
begin
  OK := True;
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);
  begin
    Z84_MakePocket(PK, RdrCode, $4B, 0, count);
    if not SendPocket(PK) then
      OK := OK AND False
    else
    begin
      Z84_GetPocket(PK, 7, 100, getVal,is98);
      if (getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode) then
        OK := OK AND True
      else
        OK := OK AND False;
    end;
  end;

  Z84_SendBeep := OK;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

function Z84_SetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : pchar;is98 :boolean) : boolean;stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  S := Str_PBCD(ST, Length(ST));
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);

  Z84_MakePocket(PK, RdrCode, $3D, 0, S);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
  Result := OK;
end;

function Z84_GetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  ST := '';
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);

  repeat
    Z84_MakePocket(PK, RdrCode, $3D, 0, '');
    if not SendPocket(PK) then
      OK := False
    else
    begin
      Z84_GetPocket(PK, 100, 100, getVal,is98);
      OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $3E) and (Ord(PK[3]) = RdrCode));
      ST := ST + PBCD2Str(copy(PK,6,length(pk)-7));
    end;
  until (not ok) or (pos('FFFFFFFF',ST) <> 0);
  Result := OK;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;

function Z84_SetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;  ST : PChar;is98 :boolean) : boolean;stdcall;
var
  S, PK : String;

  getVal : Byte;
  OK : Boolean;
begin
  Application.CreateForm(TfrmComTools, frmComTools);
  S := Str_PBCD(st, Length(st));
  Rs232Initial(BD_R, ComNo, Prtcl);
  Z84_MakePocket(PK, RdrCode, $4C, 0, S);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 7, 100, getVal,is98);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RdrCode));
  end;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
  Result := OK;
end;

function Z84_GetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;
var
  S, PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  ST := '';
  Application.CreateForm(TfrmComTools, frmComTools);
  Rs232Initial(BD_R, ComNo, Prtcl);

  repeat
    Z84_MakePocket(PK, RdrCode, $4C, 0, '');
    if not SendPocket(PK) then
      OK := False
    else
    begin
      Z84_GetPocket(PK, 100, 100, getVal,is98);
      OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $4D) and (Ord(PK[3]) = RdrCode));
      ST := ST + PBCD2Str(copy(PK,6,length(pk)-7));
    end;
  until (not ok) or (pos('FFFFFFFF',ST) <> 0);
  Result := OK;
  frmComTools.ComPort.Close;
  frmComTools.Destroy;
end;







//////////////////////////////////////////////////////LAN FUNCTION/////////////////////////////////////////////


function makeRdr(RdrCode : byte ;prtcl : byte ; IP : STR_TYPE) : TReaders;
begin
  with result do
  begin
    R_Code := RdrCode;
    R_IP := ip;
    R_TCP := (prtcl=1);
    R_IsCom := false;
  end;
end;







(*************** Link Test ***************)
function  Z84_LinkTest_LAN(RdrCode : Byte; prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_LinkTest(rdr);
  frmTcpUdp.Destroy;
end;

(*************** ReStart ***************)
function  Z84_ReStart_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_ReStart(rdr);
  frmTcpUdp.Destroy;
end;

(*************** Initial ***************)
function  Z84_Initial_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_Initial(rdr);
  frmTcpUdp.Destroy;
end;

(*************** Read Version ***************)
function  Z84_ReadVersion_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var VersionST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _VersionST : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_ReadVersion(rdr,_VersionST);
  VersionST := StrAlloc(Length(_VersionST)+1);
  StrPCopy(VersionST  , _VersionST);
  frmTcpUdp.Destroy;
end;

(*************** Send Date & Time ***************)
function  Z84_SendDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DT, TM : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _dt , _tm : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _dt := dt;
  _tm := tm;
  Result := TCP_UDP_SendDateTime(rdr,_DT,_TM);
  frmTcpUdp.Destroy;
end;

(*************** Get Date & Time ***************)
function  Z84_GetDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var DT, TM : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _dt , _tm : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetDateTime(rdr,_DT,_tM);
  dt := StrAlloc(Length(_dt)+1);
  tm := StrAlloc(Length(_tm)+1);
  StrPCopy(dt,_dt);
  StrPCopy(tm,_tm);
  frmTcpUdp.Destroy;
end;

(*************** Change Address ***************)
function  Z84_ChangeAddress_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; NewAddress : Byte) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_ChangeAddress(rdr,NewAddress);
  frmTcpUdp.Destroy;
end;

(*************** Set Limit Time ***************)
function  Z84_SendLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST1,_ST2,_ST3 : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _ST1 := ST1;
  _ST2 := ST2;
  _ST3 := ST3;
  Result := TCP_UDP_SendLimitTime(rdr,_ST1,_ST2,_ST3);
  frmTcpUdp.Destroy;
end;

(*************** Get Limit Time ***************)
function  Z84_GetLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST1,_ST2,_ST3 : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetLimitTime(rdr,_ST1,_ST2,_ST3);
  StrAlloc(Length(_ST1)+1);
  StrPCopy(ST1 , _ST1);
  StrAlloc(Length(_ST2)+1);
  StrPCopy(ST2 , _ST2);
  StrAlloc(Length(_ST3)+1);
  StrPCopy(ST3 , _ST3);
  frmTcpUdp.Destroy;
end;

(*************** Send Message To Reader ***************)
function  Z84_SendReaderMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; msg1 : STR_TYPE; msg2: STR_TYPE; msg3: STR_TYPE; msg4 : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _msg1 : string;
  _msg2 : string;
  _msg3 : string;
  _msg4 : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _msg1 := msg1;
  _msg2 := msg2;
  _msg3 := msg3;
  _msg4 := msg4;
  Result := TCP_UDP_SendReaderMsg(rdr,_msg1,_msg2,_msg3,_msg4);
  frmTcpUdp.Destroy;
end;

(*************** Send Message for personel ***************)
function  Z84_SendPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode, Msg : STR_TYPE) : Byte; stdcall;
var
  rdr : TReaders;
  _CardCode , Msg1,msg2,msg3,msg4 : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _CardCode := CardCode;
  if Length(msg)>0 then
    copy(msg,1,16);
  if Length(msg)>16 then
    copy(msg,17,16);
  if Length(msg)>32 then
    copy(msg,33,16);
  if Length(msg)>48 then
    copy(msg,49,16);
  Result := TCP_UDP_SendPersonMsg(rdr,_CardCode,Msg1,Msg2,Msg3,Msg4);
  frmTcpUdp.Destroy;
end;

(*************** Get Personel Message ***************)
function  Z84_GetPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode : STR_TYPE; var Msg : STR_TYPE) : Byte; stdcall;
var
  rdr : TReaders;
  _CardCode , _Msg : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _CardCode := CardCode;
  Result := TCP_UDP_GetPersonMsg(rdr,_CardCode,_Msg);
  StrAlloc(Length(_Msg));
  StrPCopy(Msg , _Msg);
  frmTcpUdp.Destroy;
end;

(*************** Delete Personel Message ***************)
function  Z84_DelPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; CardCode : STR_TYPE) : Byte; stdcall;
var
  rdr : TReaders;
  _CardCode : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _CardCode := CardCode;
  Result := TCP_UDP_DelPersonMsg(rdr, _CardCode);
  frmTcpUdp.Destroy;
end;

(*************** Delete Personel Message ***************)
function  Z84_DeleteAllReaderMessage_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_DeleteAllReaderMessage(rdr);
  frmTcpUdp.Destroy;
end;

(*************** Set Open Door In Normal Mode ***************)
function  Z84_SetOpenDoor_Normal_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DoorTime : Byte) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_SetOpenDoor_Normal(rdr,DoorTime);
  frmTcpUdp.Destroy;
end;

(*************** Set Open Door All Time ***************)
function  Z84_SetOpenDoor_All_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; DoorTime : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _DoorTime :string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _DoorTime := DoorTime;
  Result := TCP_UDP_SetOpenDoor_All(rdr,_DoorTime);
  frmTcpUdp.Destroy;
end;

(***************** Set Close Door *****************)
function  Z84_SetCloseDoor_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ;DoorTime : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _DoorTime :string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _DoorTime := DoorTime;
  Result := TCP_UDP_SetCloseDoor(rdr,_DoorTime);
  frmTcpUdp.Destroy;
end;

(***************** Set Alarm Time *****************)
function  Z84_SetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _St : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _ST := St;
  Result := TCP_UDP_SetAlarmTimes(rdr,_ST);
  frmTcpUdp.Destroy;
end;

(***************** Get Alarm Time *****************)
function  Z84_GetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _St : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetAlarmTimes(rdr,_St);
  StrAlloc(Length(_ST));
  StrPCopy(ST , _ST);
  frmTcpUdp.Destroy;
end;

(***************** Get Alarm Time *****************)
function  Z84_DelAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_DelAlarmTimes(rdr);
  frmTcpUdp.Destroy;
end;

(***************** Set Invalid Card *****************)
function  Z84_SetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _ST := ST;
  Result := TCP_UDP_SetInvalidCards(rdr,_ST);
  frmTcpUdp.Destroy;
end;

(***************** Get Invalid Card *****************)
function  Z84_GetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetInvalidCards(rdr,_ST);
  StrAlloc(Length(_ST));
  StrPCopy(ST , _ST);
  frmTcpUdp.Destroy;
end;

(***************** Delete Invalid Card *****************)
function  Z84_DelInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_DelInvalidCards(rdr);
  frmTcpUdp.Destroy;
end;

(***************** Set Access Code *****************)
function  Z84_SetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : STR_TYPE) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _ST := ST;
  Result := TCP_UDP_SetAccessCode(rdr,_ST);
  frmTcpUdp.Destroy;
end;

(***************** Get Access Code *****************)
function  Z84_GetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
  _ST : String;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetAccessCode(rdr,_st);
  StrAlloc(Length(_ST));
  StrPCopy(ST , _ST);
  frmTcpUdp.Destroy;
end;

(***************** Delete Access Code *****************)
function  Z84_DelAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_DelAccessCode(rdr);
  frmTcpUdp.Destroy;
end;

(***************** Set Function Keys *****************)
function  Z84_SetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE ; FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_SetFunctionKeys(rdr,FKey1,FKey2,FKey3,FKey4);
  frmTcpUdp.Destroy;
end;

(***************** Get Function Keys *****************)
function  Z84_GetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetFunctionKeys(rdr,FKey1,FKey2,FKey3,FKey4);
  frmTcpUdp.Destroy;
end;

(***************** Change Functions Keys Operation *****************)
function  Z84_ChangeFunctionKeysActive_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; KeyActive : Boolean ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_ChangeFunctionKeysActive(rdr,KeyActive);
  frmTcpUdp.Destroy;
end;

(***************** Get PishCard *****************)
function  Z84_SetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
  _PishCard, _CardNo : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _PishCard := PishCard;
  _CardNo := CardNo;
  Result := TCP_UDP_SetPishCard(rdr,no,_PishCard, _CardNo);
  frmTcpUdp.Destroy;
end;

(***************** Get PishCard *****************)
function  Z84_GetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; var PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
  _PishCard, _CardNo : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetPishCard(rdr,no , _PishCard, _CardNo);
  StrAlloc(Length(_PishCard));
  StrPCopy(PishCard , _PishCard);
  StrAlloc(Length(_CardNo));
  StrPCopy(CardNo , _CardNo);
  frmTcpUdp.Destroy;
end;

(***************** Set Limit Card *****************)
function  Z84_SetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
  _FromCard, _ToCard : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _FromCard := FromCard;
  _ToCard := ToCard;
  Result := TCP_UDP_SetLimitCard(rdr,no , _FromCard,_ToCard);
  frmTcpUdp.Destroy;
end;

(***************** Get Limit Card *****************)
function  Z84_GetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; No : Byte; var FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;
var
  rdr : TReaders;
  _FromCard, _ToCard : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetLimitCard(rdr,no , _FromCard,_ToCard);

  StrAlloc(Length(_FromCard));
  StrPCopy(FromCard , _FromCard);

  StrAlloc(Length(_ToCard));
  StrPCopy(ToCard , _ToCard);

  frmTcpUdp.Destroy;
end;

(***************** Change online/offline relation *****************)
function  Z84_ChangeOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; onLine : Boolean ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
//  Result := TCP_UDP_changeO(rdr,online);
  frmTcpUdp.Destroy;
end;

(***************** Read online/offline relation *****************)
function  Z84_ReadOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var onLine : Boolean ) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
//  Result := TCP_UDP_reaSendDateTime(rdr,DT,TM);
  frmTcpUdp.Destroy;
end;

(***************** Read One Record *****************)
procedure Z84_GetRecord_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; rType : Byte; DT : STR_TYPE; IsFirst : Boolean; var retVal : Byte; var Data : pchar ); stdcall;
var
  rdr : TReaders;
  _Data : string;
  _DT : string;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  _DT := DT;
  TCP_UDP_GetRecord(rdr,rType,_DT,IsFirst,retVal,_Data);
  data := StrAlloc(Length(_Data)+1);
  StrPCopy(Data , _Data);
  frmTcpUdp.Destroy;
end;

(***************** Read One Record *****************)
procedure Z84_GetRecordI_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                         var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt ); stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  TCP_UDP_GetRecordI(rdr,rType,DT,IsFirst,retVal,recType,recDate,recDate,recCard);
  frmTcpUdp.Destroy;
end;

(***************** Getting records and save to file *****************)
function  Z84_GetRecordInFile_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; rType : Byte; DT, FName : STR_TYPE; var retVal : Byte ) : Integer; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetRecordInFile(rdr,rType,DT,FName,retVal);
  frmTcpUdp.Destroy;
end;

(***************** Getting MTT online records *****************)
procedure MTT_OnLineRec_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte );stdcall;
var
  rdr : TReaders;
  _Data : STR_TYPE;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  TCP_UDP_MTT_OnLineRec(rdr,isGetRec,_data,retCode);
  data := _data;//StrAlloc(Length(_Data)+1);
//  StrPCopy(Data , _Data);
  frmTcpUdp.Destroy;
end;

(***************** send data to reader to print it *****************)
function  Z84_PrintToReaders_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; printer_type : byte ; st : string; DblWidth , color :boolean):boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_PrintToReaders(rdr,printer_type,st,DblWidth , color);
  frmTcpUdp.Destroy;
end;
(***************** send data to printer immediately *****************)
function  Z84_PrintToPrinter_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; st : String ):boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_PrintToPrinter(rdr,st);
  frmTcpUdp.Destroy;
end;

(***************** send cut command to printer *****************)
function  Z84_CutPrint_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; printer_type : byte ):boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_CutPrint(rdr,printer_type);
  frmTcpUdp.Destroy;
end;

(***************** enable buzzer of reader *****************)
function Z84_SendBeep_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; count : Char) : Boolean; stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_SendBeep(rdr,count);
  frmTcpUdp.Destroy;
end;

(***************** send Only Card list *****************)
function Z84_SetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : AnsiString) : boolean;stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_SetOnlyCards(rdr,ST);
  frmTcpUdp.Destroy;
end;

(***************** get Only Card list *****************)
function Z84_GetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : AnsiString) : boolean;stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetOnlyCards(rdr,ST);
  frmTcpUdp.Destroy;
end;

(***************** send Authority list *****************)
function Z84_SetAuthority_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; ST : AnsiString) : boolean;stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_SetAuthority(rdr,ST);
  frmTcpUdp.Destroy;
end;

(***************** get Authority list *****************)
function Z84_GetAuthority_LAN(RdrCode : Byte;prtcl : byte ; IP : STR_TYPE; var ST : ansistring) : boolean;stdcall;
var
  rdr : TReaders;
begin
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  rdr := makeRdr(RdrCode , prtcl , IP);
  Result := TCP_UDP_GetAuthority(rdr,ST);
  frmTcpUdp.Destroy;
end;

procedure delay0;
var
  i : byte;
  x : Extended;
begin
   for i := 1 to 4 do x := Sin(5.3);
end;

procedure delay1;
var
   i:integer;
   h,m,s,ss:word;
begin
   for i:=1 to DelayLoop do
   begin
      delay0;
      DecodeTime(Time, h,  m,s, ss);
   end;
end;

procedure Delay(n:integer);
var
   i:integer;
begin
   for i:=1 to n do delay1;
end;

procedure InitialDelay;
var
   num,t:longint;
   h,m,s,ss,lastss:word;
begin
   DecodeTime(Time, h,  m,s, lastss);
   repeat
       DecodeTime(Time, h,  m,s, ss);
   until ss<>lastss;
   t:=0;
   num:=0;
   DecodeTime(Time, h,  m,s, lastss);
   repeat
       delay0;
       inc(num);
       DecodeTime(Time, h,  m,s, ss);
       if ss>=lastss
       then inc(t,ss-lastss)
       else inc(t,ss+1000-lastss);
       lastss:=ss;
   until t>=1000;
   DelayLoop:=round(num/t);
end;
PROCEDURE FreeStringMem(str : pchar);
begin
  StrDispose(str);
end;
end.
