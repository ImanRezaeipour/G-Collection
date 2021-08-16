unit ClckRecs;

interface

const
  RECOVER_ALL = 1;
  RECOVER_NEW = 2;




function  RecoveryFirstTime(RdrType : Byte; TD : String; var RecNum : Integer) : Boolean;
function  RecoveryNewRecords(RdrType : Byte; TD : String; var RecNum : Integer) : Boolean;
procedure Z84_GetRecord(DT : String; rType : Byte; IsFirst : Boolean; var retVal : Byte; var Data : String);

implementation

uses
  Forms, SysUtils, AdoDB, Globals, ComTools, DateProc,
  Z80_CMD, DBS_Proc;









procedure Z84_GetRecord(DT : String; rType : Byte; IsFirst : Boolean; var retVal : Byte; var Data : String);
var
  n, Stat : Byte;
  PK : String;
begin
  if IsFirst then
  begin
    case rType of
      RECOVER_ALL  : MakePocket(PK, MICROADDRESS, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
      RECOVER_NEW  : MakePocket(PK, MICROADDRESS, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    end;
  end
  else if retVal = MB_TRUEREC then
    MakePocket(PK, MICROADDRESS, $06, 0, '')
  else
    MakePocket(PK, MICROADDRESS, $15, 0, '');

  if not SendPocket(PK) then
    retVal := MB_OFF
  else
  begin
    n := 0;
    repeat
      Inc(n);
      GetPocket(PK, True, Stat);
      if length(PK)>3 then
      begin
        if (Stat = 0) and (Ord(PK[3]) = MicroAddress) then
        begin
          case Ord(PK[4]) of
            3: //Buffer Empty
              retVal := MB_BUFFEMPTY;

            4: //Record Exists
            begin
              Data := PK;
              retVal := MB_TRUEREC;
            end;

            else //Error in read data
              retVal := MB_BADREC;
          end;
        end
        else
          retVal := MB_BADREC;
      end
      else
        retVal := MB_OFF;
    until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 4);
  end;
end;

function Z84_RecoveryFirstTime(TD : String; var RecNum : Integer) : Boolean;
var
  ClockRec : TClockRecord;
  tbl : TAdoTable;
  IsFirst : Boolean;
  retVal : Byte;
  Data : String;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.ReadOnly := False;
  tbl.TableName := g_options.ClockDBS;
  tbl.Open;

  retVal := MB_OK;
  RecNum := 0;
  IsFirst := True;
  if TD = '' then TD := CurrentDate;

  repeat
    Z84_GetRecord(TD, RECOVER_ALL, IsFirst, retVal, Data);
    if retVal = MB_TRUEREC then
    begin
      with ClockRec do
      begin
        Clock_RdrCode := MicroAddress;
        Clock_RecState := StrToInt(Copy(Data, 9, 2));
        Clock_Date := BeautifulDate(Copy(Data, 11, 2) + '/' +
                                    Copy(Data, 13, 2) + '/' +
                                    Copy(Data, 15, 2));
        Clock_Time := BeautifulTime(Copy(Data, 17, 2) + ':' +
                                    Copy(Data, 19, 2));
        Clock_BarCode := Copy(Data, 21, 8);
        Clock_RecState := 0;

        tbl.Append;
        tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
        tbl.FieldByName('Clock_Date').AsString := Clock_Date;
        tbl.FieldByName('Clock_Time').AsString := Clock_Time;
        tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
        tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
        tbl.Post;
      end;
      Inc(RecNum);
      IsFirst := False;
    end;
  until retVal <> MB_TRUEREC;

  tbl.Close;
  tbl.Free;
  Z84_RecoveryFirstTime := (retVal = MB_BUFFEMPTY);
end;

function RecoveryFirstTime(RdrType : Byte; TD : String; var RecNum : Integer) : Boolean;
var
  qry : TAdoQuery;
  tmpTime, tmpDate : String;
begin
  RecoveryFirstTime := True;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  tmpTime := CurrentTime;
  tmpDate := AddDate(TD, -1);
  qry.SQL.Clear;
  qry.SQL.Add('DELETE FROM ' + g_options.ClockDBS);
  qry.SQL.Add('WHERE Clock_RdrCode = ' + IntToStr(MicroAddress));
  //Shir pastorizeh
  {if ((tmpTime >= F_Params.FromSobh) and (tmpTime >= F_Params.ToSobh)) or
     ((tmpTime >= F_Params.FromNahar) and (tmpTime >= F_Params.ToNahar)) then
    qry.SQL.Add('AND Clock_Date <= ''' + tmpDate + ''' AND Clock_Time <= ''16:00''');}

  qry.ExecSQL;
  qry.Free;

  if RdrType = RDR_CLOCKZ84 then                              
    RecoveryFirstTime := Z84_RecoveryFirstTime(TD, RecNum)
  else if RdrType = RDR_CLOCKZ80 then
  begin
    RecNum := Z80_RecoveryAllRecs(MicroAddress, TD);
    if (RecNum > 0) or (RecNum = BUFFER_EMPTY) then
      RecoveryFirstTime := True;
  end
  else
    RecoveryFirstTime := False;

end;

function RecoveryNewRecords(RdrType : Byte; TD : String; var RecNum : Integer) : Boolean;
var
  tbl : TAdoTable;
  ClockRec : TClockRecord;
  retVal : Byte;
  IsFirst : Boolean;
  Data : String;
  Recs : Integer;
begin
  retVal := MB_OK;
  RecNum := 0;
  IsFirst := True;
  if TD = '' then TD := CurrentDate;

  if RdrType = RDR_CLOCKZ84 then
  begin
    tbl := TAdoTable.Create(Application);
    tbl.connection := frmDBS.DBConnection;
    tbl.ReadOnly := False;
    tbl.TableName := g_options.ClockDBS;
    tbl.Open;
    repeat
      Z84_GetRecord(TD, RECOVER_NEW, IsFirst, retVal, Data);
      if retVal = MB_TRUEREC then
      begin
        with ClockRec do
        begin
          Clock_RdrCode := MicroAddress;
          Clock_RecState := StrToInt(Copy(Data, 9, 2));
          Clock_Date := BeautifulDate(Copy(Data, 11, 2) + '/' +
                                      Copy(Data, 13, 2) + '/' +
                                      Copy(Data, 15, 2));
          Clock_Time := BeautifulTime(Copy(Data, 17, 2) + ':' +
                                      Copy(Data, 19, 2));
          Clock_BarCode := Copy(Data, 21, 8);
          Clock_RecState := 0;

          tbl.Append;
          tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
          tbl.FieldByName('Clock_Date').AsString := Clock_Date;
          tbl.FieldByName('Clock_Time').AsString := Clock_Time;
          tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
          tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
          tbl.Post;
        end;
        Inc(RecNum);
        IsFirst := False;
      end;
    until retVal <> MB_TRUEREC;
    tbl.Close;
    tbl.Free;
  end
  else
    Z80_NewRecovery(MicroAddress, retVal, Recs);

  RecoveryNewRecords := (retVal = MB_BUFFEMPTY);
end;

end.




