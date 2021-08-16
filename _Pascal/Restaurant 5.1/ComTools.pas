unit ComTools;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,SyncObjs,Globals,On_line, CPort, GHSDK_TLB;

type
  TfrmComTools = class(TForm)
    ComPort: TComPort;
    procedure FormCreate(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  MaxBaudIndex = 11;
  CNST_MAX_PORT =40;
var
  MaxTimeOut   : Integer = 600;
  AUTOCONTROL  : integer = 0;
  USERCONTROL  : Boolean = False;
  cs : TCriticalSection;

  BAUDRATES : array[0..MaxBaudIndex] of LongInt =
   (50  , 75  , 150, 200, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400);
  BAUDDIV : array[0..MaxBaudIndex] of Integer =
   (2304, 1536, 768, 576, 384, 192,   96,   48,   24,   12,     6,     3);

  MicroAddress : Byte = 1;
  CurrRdr : TReaders;
  LastBaud : Byte = 20;

  IsTest   : Boolean = False;




const UserAccess = 1;
      SystemAccess = 2;
var
  frmComTools: TfrmComTools;
  InputBuff   : String;
  RdrIndx     : Byte;

function  ConvertFromWinCode(txt : String) : String;
function  ConvertToWinCode(txt : String) : String;


procedure SetUserControl;
function  ComPortBaudIdx(idx : Byte) : Byte;
function  Rs232Initial(BaudNO, ComNo, RdrType : Byte) : Boolean;
procedure MakePocket(var PK : String; Addrss, CODE, STAT : Byte; DATA : String);

function  SendPocket(PK : String) : Boolean;overload;
//function  SendPocket(var rdr : TReaders ; PK : String) : Boolean;overload;
function  SendPocket(var frmOnline : TfrmOnline ; PK : String) : Boolean;overload;

procedure GetPocket(var PK : String; WITHSTX : Boolean; var ComState : Byte)overload;
procedure GetPocket(var frmOnline : TfrmOnline; var PK : String; WITHSTX : Boolean; var ComState : Byte)overload;
function  ValidAck(ST : String) : Byte;
procedure SetGood(n : Byte);

procedure Z80_GetPocket(var PK : String; Len, M_TimeOut : Integer);

procedure MakeProxiPocket(var PK : String; SOH, Addrss : Byte; DATA : String);
function  SendProxiPocket(PK : String) : Boolean;
procedure GetProxiPocket(var PK : String; var ComState : Byte);



procedure TestTest(ST : String; PK : String);

implementation

uses
  DBS_Proc, Code_Sys, DateProc,Msgs,tcp_udp;

{$R *.dfm}

procedure TestTest(ST : String; PK : String);
var
  i : Byte;
  ch : Char;
begin
  if IsTest then
  begin
    Write(FP_Test, ST + '  ' + CurrentTimes);
    for i := 1 to Length(PK) do
    begin
      ch := PK[i];
      if Ord(ch) <= 32 then
        Write(FP_Test, Ord(ch):4)
      else
        Write(FP_Test, ch:4);
    end;
    WriteLn(FP_Test);
  end;
end;



function ConvertFromWinCode(txt : String) : String;
begin
  ConvertFromWinCode := WinSina_To_IR(txt);
end;

(***********************************************************************
  Convert DP or Iran System Code to Windows
 ***********************************************************************)
function ConvertToWinCode(txt : String) : String;
begin
  ConvertToWinCode := IR_To_WinSina(txt);
end;

procedure SetGood(n : Byte);
begin
  with Readers[RdrIndx] do
  begin
    if n = 0 then
    begin
      RdrBad := 0;
      RdrGood := 0;
    end
    else
    begin
      if RdrBad < 40 then
        Inc(RdrBad);
      RdrGood := RdrBad div 3 + Random(2) + 1;
    end;
  end;
end;


procedure SetUserControl;
begin
  repeat until AUTOCONTROL=0;
  USERCONTROL := True;
end;


function ComPortBaudIdx(idx : Byte) : Byte;
const
  ComPort_BaudIdx : array[0..MaxBaudIndex] of Byte =
                    (0, 0, 0, 0, 2, 3, 4, 5, 6, 7, 9, 10);
begin
  if idx in [0..MaxBaudIndex] then
    ComPortBaudIdx := ComPort_BaudIdx[idx]
  else
    ComPortBaudIdx := 0;
end;

function Rs232Initial(BaudNO, ComNo, RdrType : Byte) : Boolean;
var
  BR : TBaudRate;
  ComName : String;
begin
  Rs232Initial := True;
  ComName := 'COM' + IntToStr(ComNo);
  if RdrType in [RDR_RESTZ84, RDR_RESTZ80, RDR_CLOCKZ84] then
  begin
    frmComTools.ComPort.DataBits := dbEight;
    frmComTools.ComPort.Parity.Bits := prNone;
  end
  else if RdrType in [RDR_CLOCKZ80] then
  begin
    frmComTools.ComPort.DataBits := dbSeven;
    frmComTools.ComPort.Parity.Bits := prOdd;
  end
  else if RdrType = RDR_Proxi then
  begin
    frmComTools.ComPort.DataBits := dbEight;
    frmComTools.ComPort.Parity.Bits := prEven
  end;

  if LastBaud <> BaudNo then
  begin
    LastBaud := BaudNo;
    BR := TBaudRate(ComPortBaudIdx(BaudNo));
    frmComTools.ComPort.BaudRate := BR;
  end;

  if frmComTools.ComPort.Port <> ComName then
  begin
    if frmComTools.ComPort.Connected then
    begin
      frmComTools.ComPort.Close;
      frmComTools.ComPort.Port := ComName;
      Rs232Initial := frmComTools.ComPort.Open;
    end
    else
      frmComTools.ComPort.Port := ComName;
  end;

  if not frmComTools.ComPort.Connected then
    Rs232Initial := frmComTools.ComPort.Open;
end;


procedure MakePocket(var PK : String; Addrss, CODE, STAT : Byte; DATA : String);
var
  I, BCC : Byte;
begin
  PK := #2 + Chr(Length(DATA)+4) + Chr(Addrss) + Chr(CODE) + Chr(STAT) +
        DATA + #3;
  BCC := 0;
  for I := 2 to Length(PK)-1 do BCC := BCC xor Ord(PK[I]);
  PK := PK + Chr(BCC);
end;


function SendPocket(PK : String) : Boolean;
var
  l : Integer;
  OK : Boolean;
begin
  if CurrRdr.R_IsCom then
  begin
    frmComTools.ComPort.ClearBuffer(True, True);
    l := frmComTools.ComPort.WriteStr(PK);
    OK := (l = Length(PK));

    with Readers[RdrIndx] do
    begin
      RdrTime := CurrentTimes;
      if OK and (Readers[RdrIndx].RdrBad > 1) then
        RdrState := ('äÇãæÝÞ')
      else
        RdrState := ('ÈÑÞÑÇÑ');
    end;
  end
  else
  begin
    if CurrRdr.R_TCP then
      ok := frmtcpUdp.TCPSendData(PK,CurrRdr.R_IP)
    else
      ok := frmtcpUdp.UDPSendData(PK,CurrRdr.R_IP);
  end;
  SendPocket := OK;
  TestTest('S: ', PK);
end;


procedure GetPocket(var PK : String; WITHSTX : Boolean; var ComState : Byte);
var
  I : Integer;
  L, NEWBCC : Byte;
  ENDWORK : Boolean;
  h, m , s, ms, LastMs, c : Word;
  retVal :byte;
begin
  InputBuff := '';
  ComState := 0;
  PK := '';
  L := 7;
  c := 0;
  if CurrRdr.R_IsCom then
  begin
    if not WITHSTX then InputBuff := #02 + InputBuff;
  end
  else
  begin
    if CurrRdr.R_TCP then
      frmtcpUdp.TCPReadData(InputBuff,retVal)
    else
      frmtcpUdp.UDPReadData(InputBuff,retVal);
  end;

  DecodeTime(Time, h, m, S, LastMS);
  ENDWORK := False;
  repeat
    if Length(InputBuff) > 2 then L := ORD(InputBuff[2]);
    if Length(InputBuff) = L+3 then ENDWORK := True;
    if EndWork = False then
    begin
      DecodeTime(Time, h, m, s, ms);
      if MS >= LastMs then Inc(c, ms-LastMs)
      else                 Inc(c, 1000+ms-LastMs);

      LastMs := ms;
      if c > MaxTimeOut then
      begin
        ComState := 1;
        SetGood(1);
        Break;
      end;
    end;
  until ENDWORK;

  PK := InputBuff;
  L := Length(InputBuff);
  if L > 2 then
  begin
    NEWBCC := 0;
    for I := 2 to L-2 do NEWBCC := NEWBCC xor ORD(PK[I]);
    if NEWBCC <> Ord(PK[L])then ComState := 2;
    if (Ord(PK[L-1])<>03) then ComState := 3;
    if (ORD(PK[1])<>02) then ComState := 4;
  end;

  if ComState = 0 then SetGood(0);

  with Readers[RdrIndx] do
  begin
    RdrTime := CurrentTimes;
    if (ComState <> 0) and (Readers[RdrIndx].RdrBad > 1) then
      RdrState := '*****'
    else
      RdrState := ('ÈÑÞÑÇÑ');
  end;
  TestTest('G: ', PK);
end;

function SendPocket(var frmOnline : TfrmOnline; PK : String) : Boolean;
//function  SendPocket(var rdr : TReaders ; PK : String) : Boolean;overload;
var
  l : Integer;
  OK : Boolean;
  response : string;
begin
{$ifdef _GHSDK}
  frmOnline.mtt.Media.SendToClient_2(PK);
  ok := true;
  while not frmOnline.mtt.isCommandDone do begin end;
  for i := 1 to Length(response) do
    c := c + inttostr(ord(response[i])) + '-';

  InputBuff := frmOnline.mtt.media.a.LastReceivedPacket.GetFrameDataAsString;
{$else}
  if frmOnline.Rdr.R_IsCom then
  begin
    frmComTools.ComPort.ClearBuffer(True, True);
    l := frmComTools.ComPort.WriteStr(PK);
    OK := (l = Length(PK));
  end
  else
  begin
    if frmOnline.Rdr.R_TCP then
      ok := frmOnline.frmTcpUdp.TCPSendData(PK,frmOnline.Rdr.R_IP)
    else
      ok := frmOnline.frmTcpUdp.UDPSendData(PK,frmOnline.Rdr.R_IP);
  end;
{$endif}
  with frmOnline.rdr do
  begin
    RdrTime := CurrentTimes;
    if OK and (frmOnline.rdr.RdrBad > 1) then
      RdrState := ('äÇãæÝÞ')
    else
      RdrState := ('ÈÑÞÑÇÑ');
  end;
  SendPocket := OK;
  TestTest('S: ', PK);
end;


procedure GetPocket(var frmOnline : TfrmOnline; var PK : String; WITHSTX : Boolean; var ComState : Byte);
var
  I : Integer;
  L, NEWBCC : Byte;
  ENDWORK : Boolean;
  h, m , s, ms, LastMs, c : Word;
  retVal :byte;
begin
  InputBuff := '';
  ComState := 0;
  PK := '';
  L := 7;
  c := 0;
{$ifdef _GHSDK}
//  while not frmOnline.mtt.isCommandDone do begin end;
//  InputBuff := frmOnline.mtt.LastReceivedPacket.GetFrameDataAsString;
  //  for i :=1 to Length(frmOnline.mtt.LastReceivedPacket.GetFrameDataAsString) do
//    InputBuff := ;
{$else}
  if frmOnline.rdr.R_IsCom then
  begin
    if not WITHSTX then InputBuff := #02 + InputBuff;
    DecodeTime(Time, h, m, S, LastMS);
    ENDWORK := False;
    repeat
      if Length(InputBuff) > 2 then L := ORD(InputBuff[2]);
      if Length(InputBuff) = L+3 then ENDWORK := True;
      if EndWork = False then
      begin
        DecodeTime(Time, h, m, s, ms);
        if MS >= LastMs then Inc(c, ms-LastMs)
        else                 Inc(c, 1000+ms-LastMs);

        LastMs := ms;
        if c > MaxTimeOut then
        begin
          ComState := 1;
          SetGood(1);
          Break;
        end;
      end;
    until ENDWORK;
  end
  else
  begin
    if frmOnline.Rdr.R_TCP then
      frmOnline.frmTcpUdp.TCPReadData(InputBuff,retVal)
    else
      frmOnline.frmTcpUdp.UDPReadData(InputBuff,retVal);
  end;
{$endif}
  PK := InputBuff;
  L := Length(InputBuff);
  if L > 2 then
  begin
    NEWBCC := 0;
    for I := 2 to L-2 do NEWBCC := NEWBCC xor ORD(PK[I]);
    if NEWBCC <> Ord(PK[L])then ComState := 2;
    if (Ord(PK[L-1])<>03) then ComState := 3;
    if (ORD(PK[1])<>02) then ComState := 4;
  end;

  if ComState = 0 then SetGood(0);

  with frmOnline.rdr do
  begin
    RdrTime := CurrentTimes;
    if (ComState <> 0) and (frmOnline.rdr.RdrBad > 1) then
      RdrState := '*****'
    else
      RdrState := ('ÈÑÞÑÇÑ');
  end;
  TestTest('G: ', PK);
end;

procedure Z80_GetPocket(var PK : String; Len, M_TimeOut : Integer);
var
  ENDWORK : Boolean;
  h, m , s, ms, LastMs, c : Word;
begin
  InputBuff := '';
  PK := '';
  c := 0;

  DecodeTime(Time, h, m, S, LastMS);
  ENDWORK := False;
  repeat
    PK := InputBuff;
    if Length(PK) = Len then ENDWORK := True;
    if EndWork = False then
    begin
      DecodeTime(Time, h, m, s, ms);
      if MS >= LastMs then Inc(c, ms-LastMs)
      else                 Inc(c, 1000+ms-LastMs);
      LastMs := ms;
      if c > M_TimeOut then
      begin
        SetGood(1);
        Break;
      end;
    end;
  until ENDWORK;

  PK := InputBuff;

  TestTest('G: ', PK);
end;

procedure MakeProxiPocket(var PK : String; SOH, Addrss : Byte; DATA : String);
var
  I, BCC : Byte;
begin
  PK := Chr(SOH) + 'A' + IntToStr(Addrss) + 'F' + DATA;
  BCC := 0;
  for I := 1 to Length(PK) do
    BCC := BCC xor Ord(PK[I]);
  PK := PK + ByteToHex(BCC) + Chr($0D);
end;

function SendProxiPocket(PK : String) : Boolean;
var
  l : Integer;
  OK : Boolean;
begin
  frmComTools.ComPort.SetRTS(False);
  l := frmComTools.ComPort.WriteStr(PK);
  Delay(2);
  OK := (l = Length(PK));

  with Readers[RdrIndx] do
  begin
    RdrTime := CurrentTimes;
    if OK and (Readers[RdrIndx].RdrBad > 1) then
      RdrState := ('äÇãæÝÞ')
    else
      RdrState := ('ÈÑÞÑÇÑ');
  end;

  SendProxiPocket := OK;
  frmComTools.ComPort.SetRTS(True);
  TestTest('S: ', PK);
end;

procedure GetProxiPocket(var PK : String; var ComState : Byte);
var
  I : Integer;
  L, BCC, NEWBCC : Byte;
  ENDWORK : Boolean;
  h, m , s, ms, LastMs, c : Word;
begin
  InputBuff := '';
  ComState := 0;
  PK := '';
  c := 0;

  frmComTools.ComPort.SetRTS(True);
  DecodeTime(Time, h, m, S, LastMS);
  ENDWORK := False;
  repeat
    L := Length(InputBuff);
    if (L >= 7) and (Ord(InputBuff[1]) = $0A) and (Ord(InputBuff[L]) = $0D) then
        ENDWORK := True;

    if EndWork = False then
    begin
      DecodeTime(Time, h, m, s, ms);
      if MS >= LastMs then Inc(c, ms-LastMs)
      else                 Inc(c, 1000+ms-LastMs);

      LastMs := ms;
      if c > MaxTimeOut then
      begin
        ComState := 1;
        SetGood(1);
        Break;
      end;
    end;
  until ENDWORK;

  PK := InputBuff;
  L := Length(InputBuff);
  if L > 4 then
  begin
    NEWBCC := 0;
    for I := 1 to L-3 do NEWBCC := NEWBCC xor Ord(PK[I]);

    BCC := Ord(PK[L-2]);
    if BCC < 65 then BCC := BCC - 48
    else             BCC := BCC - 55;
    BCC := BCC * 16;
    if Ord(PK[L-1]) < 65 then BCC := BCC + Ord(PK[L-1]) - 48
    else                      BCC := BCC + Ord(PK[L-1]) - 55;

    if NEWBCC    <> BCC then ComState := 2;
    if PK[2]     <> 'A' then ComState := 3;
    if ORD(PK[1])<> $0A then ComState := 4;
    if PK[4]     <> 'F' then ComState := 5;
  end;

  if ComState = 0 then SetGood(0);

  with Readers[RdrIndx] do
  begin
    RdrTime := CurrentTimes;
    if (ComState <> 0) and (Readers[RdrIndx].RdrBad > 1) then
      RdrState := '*****'
    else
      RdrState := ('ÈÑÞÑÇÑ');
  end;
  TestTest('G: ', PK);
end;


function ValidAck(ST : String) : Byte;
var i : Byte;
begin
  ValidAck := 0;
  for i := 1 to Length(ST) do
    case ST[i] of
      #$06 : ValidAck := $06;
      #$15 : ValidAck := $15;
    end;
end;

procedure TfrmComTools.ComPortRxChar(Sender: TObject; Count: Integer);
var PK : String;
begin
  frmComTools.ComPort.ReadStr(PK, Count);
  InputBuff := InputBuff + PK;
//  TestTest('C: ', InputBuff);
end;

procedure TfrmComTools.FormCreate(Sender: TObject);
begin
  cs := TCriticalSection.Create;
end;

procedure TfrmComTools.FormDestroy(Sender: TObject);
begin
  if ComPort.Connected then ComPort.Close;
end;
end.













