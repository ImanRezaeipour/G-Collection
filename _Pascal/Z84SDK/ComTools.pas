unit ComTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPort, CPortCtl, StdCtrls;

type
  TfrmComTools = class(TForm)
    ComPort: TComPort;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  procedure TestTest(ST : ansiString; PK : String);
  function ValidAck(ST : String) : Byte;
  function Rs232Initial(BaudRate : Longint; ComNo, Prtcl : Byte) : Boolean;

  function  SendPocket(PK : String) : Boolean;

  procedure Z84_MakePocket(var PK : String; ADRS, CODE, STAT : Byte; DATA : String);
  procedure Z84_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte ; is98 : boolean);
  procedure Z80_GetPocket(var PK : String; Len, TimeOut : Integer);

  procedure MakeProxiPocket(var PK : String; SOH, Addrss : Byte; DATA : String);
  function  SendProxiPocket(PK : String) : Boolean;
  procedure GetProxiPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);

const
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

  MaxBaudIndex   = 4;
  CNST_MAX_PORT  = 32;

var
  frmComTools: TfrmComTools;









implementation

uses
  Globals, Cnstants;


{$R *.DFM}





function Rs232Initial(BaudRate : LongInt; ComNo, Prtcl : Byte) : Boolean;
var
  BR : TBaudRate;
  bd_r_Idx : Byte;
  ComName : String;
begin
  if BaudRate = 2400 then        bd_r_Idx := 5
  else if BaudRate = 4800 then   bd_r_Idx := 6
  else if BaudRate = 9600 then   bd_r_Idx := 7
  else if BaudRate = 19200 then  bd_r_Idx := 9
  else if BaudRate = 38400 then  bd_r_Idx := 10
  else                           bd_r_Idx := 7;


  BR := TBaudRate(bd_r_Idx);
  frmComTools.ComPort.BaudRate := BR;

  ComName := 'COM' + IntToStr(ComNo);
  if frmComTools.ComPort.Port <> ComName then
    frmComTools.ComPort.Port := ComName;

  case Prtcl of
   RDR_Z84:
    begin
      frmComTools.ComPort.DataBits := dbEight;
      frmComTools.ComPort.Parity.Bits := prNone;
    end;

    RDR_Z80:
    begin
      frmComTools.ComPort.DataBits := dbSeven;
      frmComTools.ComPort.Parity.Bits := prOdd;
    end;

    RDR_PROXI:
    begin
      frmComTools.ComPort.DataBits := dbEight;
      frmComTools.ComPort.Parity.Bits := prEven
    end;
  end;

  if not frmComTools.ComPort.Connected then
    Rs232Initial := frmComTools.ComPort.Open;
end;

function SendPocket(PK : String) : Boolean;
var
  l : Integer;
  OK : Boolean;
begin
  frmComTools.ComPort.ClearBuffer(True, True);
  l := frmComTools.ComPort.WriteStr(PK);
  OK := (l = Length(PK));
  SendPocket := OK;
//  TestTest('S: ', PK);
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

procedure Z84_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte ; is98 : boolean);
var
  I : Integer;
  L, ChekSum : Byte;
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
  SSS := '';
  frmComTools.ComPort.ReadStr(PK, 7);
  if (PK <> '') and ((Length(PK)-3) < Ord(PK[2])) then
  begin
    if not Is98 then
      Sleep(150);
    frmComTools.ComPort.ReadStr(SSS, Ord(PK[2])-4);
  end;
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
    retVal := ERR_OFF;

//  TestTest('G: ', PK);
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
    for i := 1 to l-3 do
      NewChekSum := NewChekSum xor Ord(PK[i]);

    ChekSum := Ord(PK[l-2]);
    if ChekSum < 65 then ChekSum := ChekSum - 48
    else                 ChekSum := ChekSum - 55;
    ChekSum := ChekSum * 16;
    if Ord(PK[l-1]) < 65 then ChekSum := ChekSum + Ord(PK[l-1]) - 48
    else                      ChekSum := ChekSum + Ord(PK[l-1]) - 55;

    if ChekSum <> NewChekSum then retVal := ERR_CHEKSUM
    else if PK[2] <> 'A' then retVal := ERR_STX
    else if ORD(PK[1])<> $0A then retVal := ERR_STX
    else if PK[4] <> 'F' then retVal := ERR_STX;
  end
  else
    retVal := ERR_OFF;

end;


procedure TfrmComTools.FormDestroy(Sender: TObject);
begin
  if ComPort.Connected then ComPort.Close;
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
procedure TestTest(ST : String; PK : AnsiString);
var
  i, l : Byte;
  ch : Char;
  FP_Test     : TextFile;
begin
    AssignFile(FP_Test, 'Test.Txt');
    Append(FP_Test);

    Write(FP_Test, ST);
    l := Length(PK);

    if l > 0 then
    begin
      for i := 1 to l do
      begin
        ch := PK[i];
        if (Ord(ch) <= 32) or (i < 6) then
          Write(FP_Test, Ord(ch):4)
        else
          Write(FP_Test, ch:4);
      end;
      end
    else
      Write(FP_Test, 'T=');
    WriteLn(FP_Test);
    CloseFile(FP_Test);
end;

end.
