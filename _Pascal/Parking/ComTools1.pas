unit ComTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPort, CPortCtl;

type
  TfrmComTools = class(TForm)
    ComPort: TComPort;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


{$J+}

const
  ERR_NONE    = 1;
  ERR_TIMEOUT = 2;
  ERR_CHEKSUM = 3;
  ERR_STX     = 4;
  ERR_ETX     = 5;
  ERR_OFF     = 6;

  MB_BAD      = 0;
  MB_GOOD     = 1;

  IsTest      : Boolean = False;





var
  frmComTools : TfrmComTools;
  RdrIndx     : Byte;



function  SendPocket(PK : String) : Boolean;

procedure Z84_MakePocket(var PK : String; ADRS, CODE, STAT : Byte; DATA : String);
procedure Z84_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
procedure Z80_GetPocket(var PK : String; Len, TimeOut : Integer);

procedure MakeProxiPocket(var PK : String; SOH, Addrss : Byte; DATA : String);
function  SendProxiPocket(PK : String) : Boolean;
procedure GetProxiPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);


procedure TestTest(ST : String; PK : String);


implementation

uses
  Globals, DateProc, RunCmnds;


{$R *.DFM}


procedure TestTest(ST : String; PK : String);
var
  i : Byte;
  ch : Char;
begin
  if IsTest then
  begin
    Write(FP_Test, ST);
    for i := 1 to Length(PK) do
    begin
      ch := PK[i];
      Write(FP_Test, Ord(ch):4);
    end;
    WriteLn(FP_Test);
  end;
end;


procedure SetRelation(good_bad : Byte);
begin
  with Readers[RdrIndx] do
  begin
    if good_bad = MB_GOOD then
      RdrRelation := MB_GOOD
    else
      Inc(RdrRelation);
  end;
end;



function SendPocket(PK : String) : Boolean;
var
  l : Integer;
  OK : Boolean;
begin
  frmComTools.ComPort.ClearBuffer(True, True);
  l := frmComTools.ComPort.WriteStr(PK);
  OK := (l = Length(PK));

  with ReadersLast[RdrIndx] do
  begin
    ComTime := CurrentTimes;
    if OK and (Readers[RdrIndx].RdrRelation > 1) then
      ComStat := '*****'
    else
      ComStat := ('ÈÑÞÑÇÑ');
  end;

  SendPocket := OK;
  TestTest('S: ', PK);
end;


procedure Z84_MakePocket(var PK : String; ADRS, CODE, STAT : Byte; DATA : String);
var
  I, BCC : Byte;
begin
  PK := #2 + Chr(Length(DATA)+4) + Chr(ADRS) + Chr(CODE) + Chr(STAT) +
        DATA + #3;
  BCC := 0;
  for I := 2 to Length(PK)-1 do BCC := BCC xor Ord(PK[I]);
  PK := PK + Chr(BCC);
end;

procedure Z84_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
var
  I : Integer;
  L, ChekSum : Byte;
  SSS : String;
begin
  if TimeOut = 0 then
  begin
    frmComTools.ComPort.Timeouts.ReadInterval := -1;
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := 5;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := 5;
  end
  else
  begin
    frmComTools.ComPort.Timeouts.ReadInterval := -1;
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := TimeOut;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := TimeOut;
  end;

  retVal := ERR_NONE;
  //frmComTools.ComPort.ReadStr(PK, Len);
  frmComTools.ComPort.ReadStr(PK, 7);
  if (PK <> '') and ((Length(PK)-3) < Ord(PK[2])) then
    frmComTools.ComPort.ReadStr(SSS, Ord(PK[2])-4);
  PK := PK + SSS;
  L := Length(PK);
  if L > 2 then
  begin
    ChekSum := 0;
    for I := 2 to L-2 do ChekSum := ChekSum xor ORD(PK[I]);
    if ChekSum <> Ord(PK[L])then retVal := ERR_CHEKSUM
    else if Ord(PK[L-1]) <> 03 then retVal := ERR_ETX
    else if ORD(PK[1]) <> 02 then retVal := ERR_STX;
  end
  else
  begin
    retVal := ERR_OFF;
    SetRelation(MB_BAD);
  end;

  if retVal = ERR_NONE then SetRelation(MB_GOOD);
  
  with ReadersLast[RdrIndx] do
  begin
    ComTime := CurrentTimes;
    if (retVal <> ERR_NONE) and (Readers[RdrIndx].RdrRelation > 1) then
    begin
      ComStat := '*****';
      LastBaud := 20;
    end
    else
      ComStat := ('ÈÑÞÑÇÑ');
  end;
  TestTest('G: ', PK);
end;


procedure Z80_GetPocket(var PK : String; Len, TimeOut : Integer);
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
  frmComTools.ComPort.ReadStr(PK, Len);
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
  Sleep(5);
  OK := (l = Length(PK));

  SendProxiPocket := OK;
  frmComTools.ComPort.SetRTS(True);
  TestTest('S: ', PK);
end;

procedure GetProxiPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
var
  i, l,
  NewChekSum, ChekSum : Byte;
begin
  frmComTools.ComPort.SetRTS(True);
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
  l := Length(PK);
  if (l >= 7) and (Ord(PK[1]) = $0A) and (Ord(PK[l]) = $0D) then
  begin
    NewChekSum := 0;
    for i := 1 to l-3 do NewChekSum := NewChekSum xor Ord(PK[i]);

    ChekSum := Ord(PK[l-2]);
    if ChekSum < 65 then ChekSum := ChekSum - 48
    else                 ChekSum := ChekSum - 55;
    ChekSum := ChekSum * 16;
    if Ord(PK[l-1]) < 65 then ChekSum := ChekSum + Ord(PK[l-1]) - 48
    else                      ChekSum := ChekSum + Ord(PK[l-1]) + 55;

    if ChekSum <> NewChekSum then retVal := ERR_CHEKSUM
    else if PK[2] <> 'A' then retVal := ERR_STX
    else if ORD(PK[1])<> $0A then retVal := ERR_STX
    else if PK[4] <> 'F' then retVal := ERR_STX;
  end
  else
  begin
    retVal := ERR_OFF;
    SetRelation(MB_BAD);
  end;

  if retVal = ERR_NONE then SetRelation(MB_GOOD);

  with ReadersLast[RdrIndx] do
  begin
    ComTime := CurrentTimes;
    if retVal <> ERR_NONE then
      ComStat := '*****'
    else
      ComStat := ('ÈÑÞÑÇÑ');
  end;
  TestTest('GP:', PK);
end;


procedure TfrmComTools.FormDestroy(Sender: TObject);
begin
  if ComPort.Connected then ComPort.Close;
end;
end.
