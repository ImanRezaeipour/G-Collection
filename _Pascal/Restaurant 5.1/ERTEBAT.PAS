unit Ertebat;

interface

uses
  Db, DBTables, FORMS, SYSUTILS, MSGs, FarsiApi, DateProc,
  Globals, Code_Sys, DBS_Proc, CPort;

function  SwitchReader(idx : Byte) : Boolean;
procedure SendTables(var OK : Boolean);
procedure SendDateTime(DT, TM : String;var OK : Boolean);
procedure ReStart(var OK : Boolean);
procedure InitialRdr(var OK : Boolean);
procedure Comm_Test(var OK : Boolean);
procedure ReadVersion(var VersionST : String; var OK : Boolean);
procedure SetOnLineMode(sw : Boolean; var OK : Boolean);
procedure GetOnLineMode(var OK : Boolean);

implementation

uses
  Cntroler,ComTools,tcp_udp;

function SwitchReader(idx:Byte) : Boolean;
var i : Byte;
begin
  RdrIndx := idx;
  with Readers[RdrIndx] do
  begin
    MicroAddress := R_Code;
    CurrRdr := Readers[RdrIndx];
    if R_IsCom then
    begin
      if  not Rs232Initial(R_BaudNo, R_Port, R_Type) then
      begin
        for i := 1 to TotalReader do
          Readers[i].R_Active := False;
        ErrorMessage('ÈÇÒÔÇíí æÑÊ ÊÑãíäÇá ' + R_Name  + ' ãíÓÑ äíÓÊ.');
        SwitchReader := False;
      end
      else
      begin
        frmComTools.ComPort.SetRTS(R_Modem);
        SwitchReader := True;
      end;
    end
    else
      SwitchReader := True;
  end;
end;

procedure SendTables(var OK : Boolean);
var
  PK, ST :String;
  len, STAT, i, tloop : Byte;
  Keys : KeyType;

procedure send_1_pocket;
var EndWork : Boolean;
begin
  EndWork := False;
  tloop := 0;
  repeat
    MakePocket(PK, MicroAddress, $48, 0, ST);
    if not SendPocket(PK) then
    begin
      Inc(tloop);
      if tloop > 3 then
      begin
        OK := False;
        EndWork := True;
      end;
    end;

    if OK then
    begin
      GetPocket(PK, True, STAT);
      if (STAT = 0) and (length(pk)>3) then
      begin
        case Ord(PK[4]) of
          $06: EndWork := True;
          else
          begin
            Inc(tloop);
            if tloop > 3 then
            begin
              OK := False;
              EndWork := True;
            end;
          end;
        end;
      end
      else
      begin
        Inc(tloop);
        if tloop > 3 then
        begin
          OK := False;
          EndWork := True;
        end;
      end;
    end;
  until EndWork;
end;

function P_BCD(ST : String; from : Byte) : Char;
begin
  if length(st)>0
   then P_BCD := Chr((Ord(ST[from])-48)*16 + Ord(ST[from+1])-48)
   else p_BCD := #0;
end;

begin
  LoadKeyPads(Keys);
  SetUserControl;
  OK := True;
  len := 30;
  ST := #1'T' + Chr(len) + FixLen(StrRev(WinToDos(Keys[0], g_options.WinType, DOS_IR_SYS)), ' ', len-3)+#13#10#0;
  send_1_pocket;
  if OK then
  begin
    ST := #1'L'#12;
    if F_Params.Vadeh[MB_SOBH] = MB_True then
      ST := ST + P_BCD(F_Params.FromSobh, 1) +
                 P_BCD(F_Params.FromSobh, 4) +
                 P_BCD(F_Params.ToSobh, 1)  +
                 P_BCD(F_Params.ToSobh, 4)
    else
      ST := ST + P_BCD('00:00', 1) +
                 P_BCD('00:00', 4) +
                 P_BCD('00:00', 1) +
                 P_BCD('00:00', 4);

    if F_Params.Vadeh[MB_NAHAR] = MB_True then
      ST := ST + P_BCD(F_Params.FromNahar, 1) +
                 P_BCD(F_Params.FromNahar, 4) +
                 P_BCD(F_Params.ToNahar, 1) +
                 P_BCD(F_Params.ToNahar, 4)
    else
      ST := ST + P_BCD('00:00', 1) +
                 P_BCD('00:00', 4) +
                 P_BCD('00:00', 1) +
                 P_BCD('00:00', 4);

    if F_Params.Vadeh[MB_SHAM] = MB_True then
      ST := ST + P_BCD(F_Params.FromSham, 1) +
                 P_BCD(F_Params.FromSham, 4) +
                 P_BCD(F_Params.ToSham, 1) +
                 P_BCD(F_Params.ToSham, 4)
    else
      ST := ST + P_BCD('00:00', 1) +
                 P_BCD('00:00', 4) +
                 P_BCD('00:00', 1) +
                 P_BCD('00:00', 4);

    send_1_pocket;
  end;

  for i := 1 to 30 do
    if OK then
    begin
      ST := Chr((i-1) div 10) +
            Chr((i mod 10)+48) +
            Chr(len) +
            FixLen(StrRev(WinToDos(Keys[i], g_options.WinType, DOS_IR_SYS)), ' ', len-3) +
            #13#10#0;
      send_1_pocket;
  end;
  UserControl := False;
end;


procedure GETTABLES(var OK:Boolean);
var
  PK,ST,ST2:String;
  STAT,i,tloop:Byte;
  companyname:string;
  foods:array[1..10] of string;
begin
  SetUserControl;
  OK := True;
  i := 0;
  repeat
    tloop := 0;
    if i = 0 then
      ST := 'T'
    else
      ST := Chr((i mod 10)+48);

    MakePocket(PK, MicroAddress, $49, 0, ST);
    if not SendPocket(PK) then
    begin
      Inc(tloop);
      if tloop > 3 then
        OK := False
    end;

    if OK then
    begin
      GetPocket(PK, True, STAT);
      if (STAT = 0) and (length(pk)>3) then
      begin
        case Ord(PK[4]) of
          $49:
          begin
            ST2 := PK;
            Delete(ST2, 1, 7);
            Delete(ST2, Length(ST2)-2, 3);
            if i = 0 then
              CompanyName := ST2
            else
              Foods[i] := ST2;
          end;
          else
          begin
            Inc(tloop);
            if tloop > 3 then
              OK := False;
          end;
        end;
      end
      else
      begin
        Inc(tloop);
        if tloop > 3 then
          OK := False;
      end;
    end;
    Inc(i);
  until (i = 8) or not OK;

  UserControl := False;
end;

procedure SendDateTime(DT,TM:String;var OK:Boolean);
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $0B, 0,
             DT[3]+DT[4]+DT[6]+DT[7]+DT[9]+DT[10]+
             TM[1]+TM[2]+TM[4]+TM[5]+TM[7]+TM[8]);

  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>3) then
    begin
      case Ord(PK[4]) of
        $15: OK := False;
        6  : OK := True;
      end;
    end
    else
      OK := False;
  end;

  UserControl := False;
end;

procedure ReStart(var OK:Boolean);
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $0C, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>3) then
      OK := (Ord(PK[4]) = $06)
    else
      OK := False;
  end;

  UserControl := False;
end;

procedure InitialRdr(var OK : Boolean);
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $1F, 0, 'REINITIALIZATION');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(PK)>3)then
      OK := (Ord(PK[4]) = $06)
    else
      OK := False;
  end;

  UserControl := False;
end;

procedure Comm_Test(var OK:Boolean);
const
  RAMZ = 'DPCOLINK';
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, CurrRdr.R_Code, $01, 0, RAMZ);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>3) then
      OK := ((ORD(PK[4]) = $01) and (Copy(PK, 6, 8) = RAMZ))
    else
      OK := False;
  end;

  UserControl := False;
end;

procedure ReadVersion(var VersionST:String;var OK:Boolean);
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $0E, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>3) then
    begin
      if Ord(PK[4]) = $0E then
      begin
        VersionST := Copy(PK, 6, 40);
        OK := True;
      end;
    end
    else
      OK := False;
  end;
  UserControl:=False;
end;

procedure SetOnLineMode(sw : Boolean;var OK : Boolean);
const
  ch : array[Boolean] of Char =('I','S');
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $11, 0, Ch[sw]);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and  (length(pk)>3) then
      OK := (Ord(PK[4]) = 6)
    else
      OK := False;
  end;

  UserControl := False;

  if OK then
    Readers[rdrIndx].R_online := sw;
end;

procedure GetOnLineMode(var OK : Boolean);
var
  PK : String;
  STAT : Byte;
begin
  SetUserControl;
  MakePocket(PK, MicroAddress, $12, 0, '');
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>5) then
    begin
      if Ord(PK[4]) = $12 then
      begin
        OK := True;
        case PK[6] of
          'I' : Readers[rdrIndx].R_online := False;
          'S' : Readers[rdrIndx].R_online := True;
          else OK := False;
        end;
      end
      else
        OK := False;
    end
    else
      OK := False;
  end;

  UserControl := False;
end;


end.

