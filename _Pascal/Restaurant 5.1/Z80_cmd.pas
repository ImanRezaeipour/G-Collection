unit Z80_CMD;

interface


const
  MB_OK        = 0;
  MB_OFF       = 1;
  MB_BUFFEMPTY = 2;
  MB_TRUEREC   = 3;
  MB_BADREC    = 4;
  MB_BADDATA   = 5;


type STR_3 = array[1..3] of String;

function  Z80_LinkTest(Clk_Code : Byte) : Boolean;
function  Z80_ReadDateTime(Clk_Code : Byte) : String;
function  Z80_SetDateTime(Clk_Code : Byte; TDate, TTime : String) : Boolean;
function  Z80_ReadAccessCode(Clk_Code : Byte) : String;
function  Z80_CancelAccessCode(Clk_Code : Byte) : Boolean;
function  Z80_SetAccessCode(Clk_Code : Byte; AcesCode : String) : Byte;
procedure Z80_Collection(Clk_Code : Byte; var IsFirst : Boolean; var retVal : Byte; var Data : String);
function  Z80_RecoveryAllRecs(Clk_Code : Byte; T_Date : String) : Integer;
procedure Z80_RecoveryOneRecord(Clk_Code : Byte; T_Date : String; var IsFirst : Boolean; var retVal : Byte; var Data : String);
procedure Z80_NewRecovery(Clk_Code : Byte; var retVal : Byte; var Recs : Integer);
procedure Z80_RestaurantRec(Clk_Code : Byte; var retVal : Byte; var Data : String);
procedure Z80_Help(Clk_Code : Byte; var m : STR_3);

implementation

uses
  Forms, SysUtils, AdoDB, comtools, DateProc, Globals, DBS_Proc;




function Z80_LinkTest(Clk_Code : Byte) : Boolean;
var
  i : Byte;
  S, Rslt : String;
  PK : String;
begin
  S := IntToStr(Clk_Code);
  if Clk_Code < 10 then
    S := '0' + S;
  for i := 1 to 1 do
  begin
    if not SendPocket('B'#$0D'B'#$0D'B'#$0D#$11+'#'+S+#$0D) then
    begin
      Z80_LinkTest := False;
      Exit;
    end;
    Delay(10);
  end;

  Rslt := S + #$0D#$0A;
  Z80_GetPocket(PK, 20, 150);
  Z80_LinkTest := (Pos(Rslt, PK) > 0);
end;


function Z80_ReadDateTime(Clk_Code : Byte) : String;
var PK : String;
begin
  if Z80_LinkTest(Clk_Code) then
  begin
    Delay(100);
    if not SendPocket('?'#$0D'B'#$0D) then
      Z80_ReadDateTime := ''
    else
    begin
      Z80_GetPocket(PK, 20, 800);
      if Length(PK) <> 20 then
        Z80_ReadDateTime := ''
      else
      begin
        Delete(PK, 18, 3);
        PK[3] := '/';
        PK[6] := '/';
        PK[12] := ':';
        PK[15] := ':';
        Z80_ReadDateTime := PK;
      end;
    end;
  end
  else
    Z80_ReadDateTime := '';
end;

function Z80_SetDateTime(Clk_Code : Byte; TDate, TTime : String) : Boolean;
var OK : Boolean;
begin
  if Z80_LinkTest(Clk_Code) then
  begin
    // Send Date
    Delay(100);
    Delete(TDate, 8, 1);
    Delete(TDate, 5, 1);
    Delete(TDate, 1, 2);
    OK := SendPocket('%'+TDate+#$0D);

    if OK then
    begin
      // Send Time
      Delay(100);
      Delete(TTime, 6, 1);
      Delete(TTime, 3, 1);
      OK := SendPocket('*'+TTime+#$0D);
    end;
  end
  else
    OK := False;

  Z80_SetDateTime := OK;
end;

function Z80_ReadAccessCode(Clk_Code : Byte) : String;
var
  PK : String;
  i, l : Byte;
begin
  if Z80_LinkTest(Clk_Code) then
  begin
    Delay(100);
    if not SendPocket('RN'#$0D) then
      Z80_ReadAccessCode := ''
    else
    begin
      Z80_GetPocket(PK, 22, 800);
      l := Length(PK);
      case l of
        6, 10, 14, 18, 22:
        begin
          if PK = #45#45#45#45#$0D#$0A then
            PK := '0000,0000,0000,0000,0000'
          else
          begin
            Delete(PK, l-1, 2);
            Dec(l, 2);
            i := 0;
            while i < l-5 do
            begin
              Inc(i, 5);
              Insert(',', PK, i);
            end;
          end;
          Z80_ReadAccessCode := PK;
        end;

        else Z80_ReadAccessCode := '';
      end;
    end;
  end
  else
    Z80_ReadAccessCode := '';
end;


function Z80_CancelAccessCode(Clk_Code : Byte) : Boolean;
var PK : String;
begin
  if Z80_LinkTest(Clk_Code) then
  begin
    // Send Date
    Delay(100);
    if not SendPocket('CN'#$0D) then
      Z80_CancelAccessCode := False
    else
    begin
      Z80_GetPocket(PK, 12, 800);
      if (Length(PK) = 12) and (PK = 'DATA RX OK'#$D#$A)then
        Z80_CancelAccessCode := True
      else
        Z80_CancelAccessCode := False;
    end;
  end
  else
    Z80_CancelAccessCode := False;
end;

function Z80_SetAccessCode(Clk_Code : Byte; AcesCode : String) : Byte;
var PK : String;
const
  Aces_OK = 'DATA RX OK'#$D#$A;
  Aces_Error = 'CLOCK ACCESS NO. RX ERROR OR SWITCH NOT SET'#$0D#$0A;
begin
  if Z80_CancelAccessCode(Clk_Code) then
  begin
    Delay(500);
    if Z80_LinkTest(Clk_Code) then
    begin
      // Send Date
      Delay(100);
      if not SendPocket('SN'+AcesCode+#$0D) then
        Z80_SetAccessCode := MB_OFF
      else
      begin
        Z80_GetPocket(PK, 45, 2000);
        if Length(PK) > 0 then
        begin
          if PK = Aces_OK then
            Z80_SetAccessCode := MB_OK
          else if PK = Aces_Error then
            Z80_SetAccessCode := MB_BADDATA
          else
            Z80_SetAccessCode := MB_OFF;
        end
        else
          Z80_SetAccessCode := MB_OFF;
      end;
    end
    else
      Z80_SetAccessCode := MB_OFF;
  end
  else
    Z80_SetAccessCode := MB_OFF;
end;

procedure Z80_Collection(Clk_Code : Byte; var IsFirst : Boolean; var retVal : Byte; var Data : String);
var
  PK : String;
  i, l, chkSum : Byte;
begin
  if IsFirst then
  begin
    if not Z80_LinkTest(Clk_Code) then
      retVal := MB_OFF
    else
    begin
      Delay(100);
      if not SendPocket('D'#$0D) then
        retVal := MB_OFF
    end;
  end
  else if retVal = MB_TRUEREC then
  begin
    if not SendPocket('A'#$0D) then
      retVal := MB_OFF;
  end
  else if retVal = MB_BADREC then
  begin
    if not SendPocket('N'#$0D) then
      retVal := MB_OFF;
  end;


  if retVal <> MB_OFF then
  begin
    Z80_GetPocket(PK, 25, 1200);
    l := Length(PK);
    if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      retVal := MB_BUFFEMPTY
    else if l = 25 then
    begin
      chkSum := 0;
      for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
      chkSum := (chkSum AND $7F);
      if chkSum <> Ord(PK[25]) then
        retVal := MB_BADREC
      else
      begin
        retVal := MB_TRUEREC;
        Data := Copy(PK, 1, 22);
      end;
      IsFirst := False;
    end
    else if l > 0 then
      retVal := MB_BADREC
    else
      retVal := MB_OFF;
  end;
end;

function Z80_RecoveryAllRecs(Clk_Code : Byte; T_Date : String) : Integer;
var
  tbl : TAdoTable;
  n, retVal : Byte;
  IsFirst : Boolean;
  Data : String;
  RecNo : Integer;
  ClockRec : TClockRecord;
begin
  Z80_RecoveryAllRecs := -1;
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.ReadOnly := False;
  tbl.TableName := g_options.ClockDBS;
  tbl.Open;
  IsFirst := True;
  RecNo := 0;
  n := 1;

  repeat
    Z80_RecoveryOneRecord(Clk_Code, T_Date, IsFirst, retVal, Data);
    if (n <= 3) and (retVal = MB_OFF) then
      Inc(n)
    else if (n = 4) and (retVal = MB_OFF) then
    begin
      Z80_RecoveryAllRecs := -1;
      Break;
    end
    else if retVal <> MB_OFF then
      n := 1;

    if retVal = MB_TRUEREC then
    begin
      with ClockRec do
      begin
        Clock_RdrCode := MicroAddress;
        Clock_RecState := StrToInt(Copy(Data, 3, 2));
        Clock_Date := BeautifulDate(Copy(Data, 5, 2) + '/' +
                                    Copy(Data, 7, 2) + '/' +
                                    Copy(Data, 9, 2));
        Clock_Time := BeautifulTime(Copy(Data, 11, 2) + ':' +
                                    Copy(Data, 13, 2));
        Clock_BarCode := Copy(Data, 15, 8);

        tbl.Append;
        tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
        tbl.FieldByName('Clock_Date').AsString := Clock_Date;
        tbl.FieldByName('Clock_Time').AsString := Clock_Time;
        tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
        tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
        tbl.Post;
      end;
      Inc(RecNo);
      Z80_RecoveryAllRecs := RecNo;
    end;
  until retVal = MB_BUFFEMPTY;

  if (RecNo > 0) and (retVal = MB_BUFFEMPTY) then
    Z80_RecoveryAllRecs := BUFFER_EMPTY;
end;

procedure Z80_RecoveryOneRecord(Clk_Code : Byte; T_Date : String; var IsFirst : Boolean; var retVal : Byte; var Data : String);
var
  PK : String;
  l, i, chkSum : Byte;
begin
  if IsFirst then
  begin
    if not Z80_LinkTest(Clk_Code) then
      retVal := MB_OFF
    else
    begin
      Delay(300);
      T_Date := BeautifulDate(T_Date);
      Delete(T_Date, 8, 1);
      Delete(T_Date, 1, 5);
      if not SendPocket('NL'+T_Date+#$0D) then
        retVal := MB_OFF
    end;
  end
  else if retVal = MB_TRUEREC then
  begin
    if not SendPocket('A'#$0D) then
      retVal := MB_OFF;
  end
  else if retVal = MB_BADREC then
  begin
    if not SendPocket('N'#$0D) then
      retVal := MB_OFF;
  end;


  if retVal <> MB_OFF then
  begin
    Z80_GetPocket(PK, 25, 20000);
    l := Length(PK);
    if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      retVal := MB_BUFFEMPTY
    else if l = 25 then
    begin
      chkSum := 0;
      for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
      chkSum := (chkSum AND $7F);
      if chkSum <> Ord(PK[25]) then
        retVal := MB_BADREC
      else
      begin
        retVal := MB_TRUEREC;
        Data := Copy(PK, 1, 22);
      end;
      IsFirst := False;
    end
    else if l > 0 then
      retVal := MB_BADREC
    else
      retVal := MB_OFF;
  end;
end;

procedure Z80_NewRecovery(Clk_Code : Byte; var retVal : Byte; var Recs : Integer);
var
  tbl : TAdoTable;
  ClockRec : TClockRecord;
  PK, s : String;
  p : Byte;
  ENDWORK : Boolean;
begin
  retVal := MB_OK;
  if not Z80_LinkTest(Clk_Code) then
    retVal := MB_OFF
  else
  begin
    frmComTools.ComPort.ClearBuffer(True, True);
    if not SendPocket('RNR'#$0D) then
      retVal := MB_OFF;
  end;

  if retVal <> MB_OFF then
  begin
    tbl := TAdoTable.Create(Application);
    tbl.connection := frmDBS.DBConnection;
    tbl.ReadOnly := False;
    tbl.TableName := g_options.ClockDBS;
    tbl.Open;

    Recs := 0;
    EndWork := False;
    repeat
      PK := '';
      Z80_GetPocket(s, 240, 1100);
      PK := PK + s;

      TestTest('G: ', s);
      if Pos('E'#$0D#$0A, PK) > 0 then
      begin
        retVal := MB_BUFFEMPTY;
        EndWork := True;
      end
      else if PK = '' then
      begin
        retVal := MB_OFF;
        EndWork := True;
      end;

      p := Pos(#$0D#$0A, PK);
      while P > 0 do
      begin
        if p > 3 then
        begin
          Inc(Recs);

          with ClockRec do
          begin
            Clock_RdrCode := StrToInt(Copy(PK, 1, 2));
            Clock_Date := BeautifulDate(Copy(PK, 5, 2) + '/' +
                                        Copy(PK, 7, 2) + '/' +
                                        Copy(PK, 9, 2));
            Clock_Time := BeautifulTime(Copy(PK, 11, 2) + ':' +
                                        Copy(PK, 13, 2));
            Clock_BarCode := Copy(PK, 15, 8);
            Clock_RecState := 0;

            tbl.Append;
            tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
            tbl.FieldByName('Clock_Date').AsString := Clock_Date;
            tbl.FieldByName('Clock_Time').AsString := Clock_Time;
            tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
            tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
            tbl.Post;
          end;
        end;

        Delete(PK, 1, p+1);
        p := Pos(#$0D#$0A, PK);
      end;
    until EndWork;
    tbl.Close;
    tbl.Free;
  end;
end;

procedure Z80_RestaurantRec(Clk_Code : Byte; var retVal : Byte; var Data : String);
var
  PK : String;
  l, i, chkSum : Byte;
begin
  retVal := MB_OK;
  if not Z80_LinkTest(Clk_Code) then
    retVal := MB_OFF
  else
  begin
    Delay(10);
    if not SendPocket('RST2'#$0D) then
      retVal := MB_OFF
  end;

  if retVal <> MB_OFF then
  begin
    Delay(10);
    Z80_GetPocket(PK, 25, 80);
    l := Length(PK);
    if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      retVal := MB_BUFFEMPTY
    else if l = 25 then
    begin
      chkSum := 0;
      for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
      chkSum := (chkSum AND $7F);
      if chkSum <> Ord(PK[25]) then
        retVal := MB_BADREC
      else
      begin
        retVal := MB_TRUEREC;
        Data := Copy(PK, 1, 22);
      end;
    end
    else if l > 0 then
      retVal := MB_BADREC
    else
      retVal := MB_OFF;
  end;
end;

procedure Z80_Help(Clk_Code : Byte; var m : STR_3);
var
  PK : String;
  lop : Byte;
begin
  if Z80_LinkTest(Clk_Code) then
  begin
    Delay(100);
    if not SendPocket('H'#$0D) then
      m[1] := ''
    else
    begin
      lop := 0;
      repeat
        Inc(lop);
        Z80_GetPocket(PK, 255, 2000);
        if Length(PK) > 0 then
          m[lop] := PK;
      until (PK = '') or (lop = 5);
    end;
  end
  else
    m[1] := '';
end;





end.
