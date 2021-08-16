unit DBS;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Globals, RunCmnds, ADODB, msgs, comtools;

  
type
  recPart = record
    Father    : string;
    LChild    : string;
    RSibling  : String;
    Code      : String;
    Name      : String;
    P1Code    : String;
    P2Code    : String;
    P3Code    : String;
    P4Code    : String;
    ChildCount: Integer;
  end;

type
  TfrmDBS = class(TForm)
    DBConnection: TADOConnection;
    adoTblPersons: TADOTable;
    adoQryG: TADOQuery;
    adoTblClkDBS: TADOTable;
    adoTblBargehDBS: TADOTable;
    adoTblG: TADOTable;
    adoTblTmpPersons: TADOTable;
    adotblPart: TADOTable;
    adoTblEDBS: TADOTable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  REC_TEST = 1;
  REC_ADD  = 2;
  REC_EDIT = 3;

{$IFNDEF webClock}
var
  frmDBS: TfrmDBS;
{$ENDIF}



function  tblExists(tblName : String): boolean;//by MKN
procedure EmptyTbl(tblName : String); //by MKN

function  GetNewNumber(tbl, fld : String) : LongInt;
// not used start
function  GetNewNumberInType(tbl, fld, fld_type : String; value : Byte) : LongInt;
procedure ChangeDBSNum(tbl, fld : String; BefNum, NewNum : LongInt);
procedure ChangeDBSStr(tbl, fld : String; BefStr, NewStr : String);
procedure ChngIntegerField(tbl, fld : String; from, n : Integer);
// not used end
function  IsExistsRec_Num(tbl, fld : String; fldVal : LongInt) : Boolean;
function  IsExistsRec_2Num(tbl, fld1, fld2 : String; fld1Val, fld2Val : LongInt) : Boolean;
function  IsExistsRec_Str(tbl, fld, fldVal : String) : Boolean;

procedure InitVariables;
procedure LoadIniFileDB;
procedure SaveIniFileDB;

procedure LoadPishCardDB;
procedure SavePishCardDB;

procedure loadcustomrepsDB;
procedure savecustomrepsDB;
procedure loadcustomdepthDB;
procedure savecustomdepthDB;

procedure loadmktextrepsDB;
procedure savemktextrepsDB;

procedure loadhollidaysDB(yr:integer);
procedure savehollidaysDB(yr:integer);
function IsHolidayDB(dt : String) : Boolean;

{ Reader Procedure }
procedure LoadReaders;
function  FindReaderNameIdx(ReaderName : String) : Byte;
function  FindReaderCodeIdx(ReaderCode : Integer) : Byte;
function  GetReaderNameInRam(ReaderCode : Integer) : String;
function  GetReaderCode(ReaderName : String) : Integer;
function  GetReaderName(ReaderCode : Integer) : String;
{ Station Procedures }
function  GetStationCode(stName : String) : Integer;
function  GetStationName(StCode : Integer) : String;
{ Person Procedures }
function InCirclePerson(PersonCode : String) : Boolean;
function GetPersonCode(PersonName : String) : String;
function GetPersonCodeB(PersonEstekhdami: String) : String;
function GetPersonCodeEX(PersonFamilyName : String) : String;
function GetPersonName(PersonCode : String) : String;
function GetPersonFamily(PersonCode : String) : String;
function GetPersonFamilyName(PersonCode : String) : String;
function GetPerson(PersonCode : String; IsProxi : Boolean) : TPerson;
function GetnPerson(nPersonCode : String; IsProxi : Boolean) : TPerson; //kaveh

{ tmpPersons Procedures }
function GetTmpPersonCode(PersonName : String) : String;
function GetTmpPersonName(PersonCode : String) : String;
function GetTmpPersonFamilyName(PersonCode : String) : String;


{ JobType Procedures }
function GetJobName(JobCode : Integer) : String;
function GetJobCode(JobName : String) : Integer;


{ Part Procedures }
function GetPartName(P1, P2, P3, P4 : LongInt; Lvl : Byte) : String;overload;
function GetPartCode(PartName : String; Lvl : Byte) : Integer;overload;
function GetPartCodeEX(PrivPartCode: integer;PartName : String; Lvl : Byte) : Integer;
function GetAllPartName(P1, P2, P3, P4 : LongInt) : String;overload;

function GetPartName(CustomCode : String) : String;overload;
function GetPartCode(CustomCode : String) : String;overload;
function GetPartCustomCode(Code : String) : String;
function GetAllPartName(Code : String;dlmtr : string = '-') : String;overload;
procedure ConvertParts;
// The next function was designed only for ConvertParts procedure
function FindIndexOfPartinArray(TempTbl: array of recPart; WhichField: Integer;
                P1Code, P2Code, P3Code : String): Integer;
{ CoPost Procedures }
function GetPostName(PostCode : Integer) : String;
function GetPostCode(PostName : String) : Integer;


{ Group & Shift Procedures }
function GetGroupName(GroupCode : Integer) : String;
function GetGroupCode(GroupName : String) : Integer;
function GetRuleName(RuleCode : Integer) : String;
function GetRuleCode(RuleName : String) : Integer;
{
function GetGroupMName(GroupMCode : Integer) : String;
function GetGroupMCode(GroupMName : String) : Integer;
}

{ Mission place Procedures }
function GetMission1Name(m1Code : Integer) : String;
function GetMission1Code(m1Name : String) : Integer;

function GetMission2Name(m2Code : Integer) : String;
function GetMission2Code(m2Name : String) : Integer;

function GetAllMissionName(M2_Code : Integer) : String;

{ Diseases & Doctors Procedures }
function GetDiseasesName(Code : Integer) : String;
function GetDiseasesCode(Name : String) : Integer;

function GetDoctorsName(Code : Integer) : String;
function GetDoctorsCode(Name : String) : Integer;

function getAddFreeTypeName(Code : Integer) : String;

function GetBoxName(BoxCode : integer) : String;

procedure LoadShifts;


procedure CreateClockDBS(TD : String);
procedure CreateClkDBSFName(fName : String);
procedure OpenClockDBS(TD : String);
procedure OpenTempClockDBS(TD : String);
procedure OpenTempAddWorkDBS(TD : String);
procedure OpenTempDBS(TD : String);
procedure CloseClockDBS;
function  SaveClockRecord(ClkRec : TTerminalRec; RecTest : Byte; ErrData : Boolean) : Boolean;
function  SaveTempClockRecord(ClkRec : TTerminalRec; RecTest : Byte; ErrData : Boolean) : Boolean;
procedure CreateInOutTbl(SDate, EDate : String);

function FindBargehNo(dt, tm, pCode, ioType : String;var bargeNo,Type1,type2 : integer): Integer;
Procedure FindBargehNos(dt, pCode : String; var brgs , typ1,typ2:string);
function  SaveBargehRecord(ClkRec : TTerminalRec; BrgNo : Integer; type1 , type2 : integer ; RecTest : Byte; ErrData : Boolean) : Boolean;
function  IncFileName(filename:string):string;

function authorized:boolean;

function  CreateTable(tblName : String; IsUpgrade : Boolean) : Boolean;
Procedure UpgradeTable(tblName : string);

implementation


uses
  TimeTool,DateProc, Funcs, DBLogin, Math, Makedb
  {$ifdef webClock}, UserSessionUnit, ServerController{$ENDIF};

{$R *.DFM}

procedure TfrmDBS.FormCreate(Sender: TObject);
begin
{$IFNDEF webClock}
{$IFNDEF Z84SDK}
  if DBLinkTest then
    adoTblPersons.Open;
{$ELSE}
  DBLinkTest;
{$ENDIF}
{$ENDIF}
end;




(********************** Global Database procedures *******************)

function tblExists(tblName : String): boolean; //by MKN
var
  tblLists : TStrings;
  i : integer;
begin
  result := false;
  if (Pos('p1', tblName) > 0) or (Pos('P1', tblName) > 0) then
  begin
    if FileExists(g_Options.DataBasePath + tblName + '.DB') then
      Result := True;
  end
  else
  begin
    tblLists := TStringList.Create;
    frmDBS.DBConnection.GetTableNames(tblLists , false);
    for i := 0 to tblLists.Count - 1 do
      if UpperCase(tblName) = UpperCase(tblLists[i]) then
        result := true;
    tblLists.free;
  end;
end;

Procedure EmptyTbl(tblName : String);
var
  qry : TADOQuery;
begin
  qry := TADOQuery.Create(Application);
  with qry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('Delete FROM ' + tblName);
    ExecSQL;
    close;
    free;
  end;
end;

{ return largest number+1 of fld field's from table }
function GetNewNumber(tbl, fld : String) : LongInt;
begin
  if tblExists(tbl) then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT MAX(' + fld + ') AS Max_Num FROM ' + tbl);
      Open;
      if FieldByName('Max_Num').AsString <> '' then
        Result := FieldByName('Max_Num').AsInteger + 1
      else
        Result := 1;
      Close;
    end;
  end
  else
    Result := 1;
end;


{ return largest number+1 of fld field's from table of tbl_type }
function GetNewNumberInType(tbl, fld, fld_type : String; value : Byte) : LongInt;
begin
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.SQL.Add('SELECT MAX(' + fld + ') AS Max_Num FROM ' + tbl);
  frmDBS.adoQryG.SQL.Add('WHERE ' + fld_type + ' = ' + IntToStr(value));
  frmDBS.adoQryG.Open;
  GetNewNumberInType := frmDBS.adoQryG.FieldByName('Max_Num').AsInteger + 1;
  frmDBS.adoQryG.Close;
end;

{ Change fld fields from BefNum to NewNum }
procedure ChangeDBSNum(tbl, fld : String; BefNum, NewNum : LongInt);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + IntToStr(NewNum));
    SQL.Add('WHERE ' + fld + ' = ' + IntToStr(BefNum));
    ExecSQL;
  end;
end;

{ Change fld fields from BefStr to NewStr }
procedure ChangeDBSStr(tbl, fld : String; BefStr, NewStr : String);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + NewStr);
    {$IFDEF Network}
    SQL.Add('WHERE ' + fld + ' = N''' + BefStr + '''');
    {$ELSE}
    SQL.Add('WHERE ' + fld + ' = ''' + BefStr + '''');
    {$ENDIF}
    ExecSQL;
  end;
end;

{ Increment or Decrement a field of database from a record }
procedure ChngIntegerField(tbl, fld : String; from, n : Integer);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + fld + ' + ' + IntToStr(n));
    {$IFDEF Network}
    SQL.Add('WHERE ' + fld + ' >= N''' + IntToStr(from) + '''');
    {$else}
    SQL.Add('WHERE ' + fld + ' >= ''' + IntToStr(from) + '''');
    {$ENDIF}
    ExecSQL;
  end;
end;

{ return True, if Exsists fld in database }
function IsExistsRec_Num(tbl, fld : String; fldVal : LongInt) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld + ' = ' + IntToStr(fldVal));
    Open;
    IsExistsRec_Num := not frmDBS.adoQryG.EOF;
    Close;
  end;
end;

{ return True, if Exsists fld1, fld2 in database }
function IsExistsRec_2Num(tbl, fld1, fld2 : String; fld1Val, fld2Val : LongInt) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld1 + ' = ' + IntToStr(fld1Val));
    SQL.Add('AND ' + fld2 + ' = ' + IntToStr(fld2Val));
    Open;
    IsExistsRec_2Num := not frmDBS.adoQryG.EOF;
    Close;
  end;
end;

{ return True, if Exsists fld in database }
function IsExistsRec_Str(tbl, fld, fldVal : String) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    {$IFDEF Network}
    SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld + ' = N''' + fldVal + '''');
    {$else}
    SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld + ' = ''' + fldVal + '''');
    {$ENDIF}
    Open;
    IsExistsRec_Str := not frmDBS.adoQryG.EOF;
    Close;
  end;
end;

{ Initialize Global Variables }
procedure InitVariables;
begin
  LoadIniFileDB;
  LoadDBIniFile;
  LoadPishCardDB;
  LoadReaders;
  LoadShifts;
end;


(************************** initial system procedures ************************)

procedure LoadIniFileDB;
var
   adoTbl : TADOTable;
   temp: integer;
   title:string[30];
begin
  monthnormal:=true;
  for temp:=1 to 12 do monthends[temp]:=28;
  archiveday:=0;
  F_Params.fldRezerv1 := ('فيلد رزرو 1');
  F_Params.fldRezerv2 := ('فيلد رزرو 2');
  F_Params.fldRezerv3 := ('فيلد رزرو 3');
  F_Params.fldRezerv4 := ('فيلد رزرو 4');
  F_Params.fldRezerv5 := ('فيلد رزرو 5');
  F_Params.fldRezerv6 := ('فيلد رزرو 6');
  F_Params.fldRezerv7 := ('فيلد رزرو 7');
  F_Params.fldRezerv8 := ('فيلد رزرو 8');

  F_Params.Part1 := ('بخش');
  F_Params.Part2 := ('زير بخش');
  F_Params.Part3 := ('زير بخش');
  F_Params.Part4 := ('زير بخش');

  F_Params.RptTitleFont := 'Arial';
  F_Params.RptTitleFntSize := 16;
  F_Params.RptFont := 'Arial';
  F_Params.RptFntSize := 10;

  if not tblExists('init') then
    CreateTbl('init');

  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'Init';
    Open;
    first;
    while not EOF do
    begin
      Title := FieldByName('init_title').AsString;
      if      title = 'archiveday' then archiveday:=fieldbyname('init_value').AsInteger
      else if title = 'PrsRptSetST' then PrsRptSetST:=fieldbyname('init_value').AsString
      else if title = 'LhzRptSetST' then LhzRptSetST:=fieldbyname('init_value').AsString
      else if title = 'EndRep01' then F_Params.EndRep01:=fieldbyname('init_value').AsString
      else if title = 'EndRep02' then F_Params.EndRep02:=fieldbyname('init_value').AsString
      else if title = 'EndRep03' then F_Params.EndRep03:=fieldbyname('init_value').AsString
      else if title = 'EndRep04' then F_Params.EndRep04:=fieldbyname('init_value').AsString
      else if title = 'EndRep05' then F_Params.EndRep05:=fieldbyname('init_value').AsString
      else if title = 'TimeOut2000'
      then begin
           F_Params.TimeOut2000:=fieldbyname('init_value').AsInteger;
           delay2000 := F_Params.TimeOut2000;
      end
      else if title = 'IsWin2000'
      then begin
           F_Params.IsWin2000:=fieldbyname('init_value').AsInteger;
           Is2000 := (F_Params.IsWin2000 = MB_TRUE);
      end
      else if title = 'FastCollect' then F_Params.FastCollect :=fieldbyname('init_value').AsInteger
      else if title = 'Admin_User' then F_Params.Admin_User :=fieldbyname('init_value').AsString
      else if title = 'Part1' then F_Params.Part1:=fieldbyname('init_value').AsString
      else if title = 'Part2' then F_Params.Part2:=fieldbyname('init_value').AsString
      else if title = 'Part3' then F_Params.Part3:=fieldbyname('init_value').AsString
      else if title = 'Part4' then F_Params.Part4:=fieldbyname('init_value').AsString

      else if title = 'fldRezerv1' then F_Params.fldRezerv1:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv2' then F_Params.fldRezerv2:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv3' then F_Params.fldRezerv3:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv4' then F_Params.fldRezerv4:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv5' then F_Params.fldRezerv5:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv6' then F_Params.fldRezerv6:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv7' then F_Params.fldRezerv7:=fieldbyname('init_value').AsString
      else if title = 'fldRezerv8' then F_Params.fldRezerv8:=fieldbyname('init_value').AsString
      else if title = 'RptTitleFont' then F_Params.RptTitleFont:=fieldbyname('init_value').AsString
      else if title = 'RptTitleFntSize' then F_Params.RptTitleFntSize:=fieldbyname('init_value').AsInteger
      else if title = 'RptFont' then F_Params.RptFont:=fieldbyname('init_value').AsString
      else if title = 'RptFntSize' then F_Params.RptFntSize:=fieldbyname('init_value').AsInteger
      else if title = 'BranchCode' then F_Params.BranchCode:=fieldbyname('init_value').AsString //kaveh
      else if title = 'BranchName' then F_Params.BranchName:=fieldbyname('init_value').AsString //kaveh
      else if title = 'monthnormal'
      then begin
           temp:=fieldbyname('init_value').AsInteger;
           monthnormal:=(temp=0);
      end
      else if title = 'monthends'
      then begin
          temp:=fieldbyname('init_value').AsInteger div 100;
          monthends[temp]:=fieldbyname('init_value').AsInteger mod 100;
      end;
      next;
    end;
    close;
    free;
  end;
end;

procedure SaveIniFileDB;
var
   adoTbl : TADOTable;
   temp: integer;
begin
  if not tblExists('init') then
    CreateTbl('init');
  EmptyTbl('init');
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'init';
    open;
    append;
    FieldByName('init_title').AsString:='archiveday';
    FieldByName('init_Value').AsInteger:=archiveday;
    post;
    append;
    FieldByName('init_title').AsString:='PrsRptSetST';
    FieldByName('init_Value').AsString:=PrsRptSetST;
    post;
    append;
    FieldByName('init_title').AsString:='LhzRptSetST';
    FieldByName('init_Value').AsString:=LhzRptSetST;
    post;
    append;
    FieldByName('init_title').AsString:='EndRep01';
    FieldByName('init_Value').AsString:=F_Params.EndRep01;
    post;
    append;
    FieldByName('init_title').AsString:='EndRep02';
    FieldByName('init_Value').AsString:=F_Params.EndRep02;
    post;
    append;
    FieldByName('init_title').AsString:='EndRep03';
    FieldByName('init_Value').AsString:=F_Params.EndRep03;
    post;
    append;
    FieldByName('init_title').AsString:='EndRep04';
    FieldByName('init_Value').AsString:=F_Params.EndRep04;
    post;
    append;
    FieldByName('init_title').AsString:='EndRep05';
    FieldByName('init_Value').AsString:=F_Params.EndRep05;
    post;
    append;
    FieldByName('init_title').AsString:='IsWin2000';
    FieldByName('init_Value').AsInteger:=F_Params.IsWin2000;
    post;
    append;
    FieldByName('init_title').AsString:='TimeOut2000';
    FieldByName('init_Value').AsInteger:=F_Params.TimeOut2000;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv1';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv1;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv2';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv2;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv3';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv3;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv4';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv4;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv5';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv5;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv6';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv6;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv7';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv7;
    post;
    append;
    FieldByName('init_title').AsString:='fldRezerv8';
    FieldByName('init_Value').AsString:=F_Params.fldRezerv8;
    post;
    append;
    FieldByName('init_title').AsString:='RptTitleFont';
    FieldByName('init_Value').AsString:=F_Params.RptTitleFont;
    post;
    append;
    FieldByName('init_title').AsString:='RptTitleFntSize';
    FieldByName('init_Value').AsInteger:=F_Params.RptTitleFntSize;
    post;
    append;
    FieldByName('init_title').AsString:='RptFont';
    FieldByName('init_Value').AsString:=F_Params.RptFont;
    post;
    append;
    FieldByName('init_title').AsString:='RptFntSize';
    FieldByName('init_Value').AsInteger:=F_Params.RptFntSize;
    post;

    append;
    FieldByName('init_title').AsString:='FastCollect';
    FieldByName('init_Value').AsInteger:=F_Params.FastCollect;
    post;

    append;
    FieldByName('init_title').AsString:='Admin_User';
    FieldByName('init_Value').AsString :=F_Params.Admin_User;
    post;

    append;
    FieldByName('init_title').AsString:='BranchCode';
    FieldByName('init_Value').AsString :=F_Params.BranchCode;
    post;

    append;
    FieldByName('init_title').AsString:='BranchName';
    FieldByName('init_Value').AsString :=F_Params.BranchName;
    post;
    
    if monthnormal
    then begin
        temp:=0;
        append;
        FieldByName('init_title').AsString:='monthnormal';
        FieldByName('init_Value').AsInteger:=temp;
        post;
    end
    else begin
        temp:=1;
        append;
        FieldByName('init_title').AsString:='monthnormal';
        FieldByName('init_Value').AsInteger:=temp;
        post;
        for temp:=1 to 12 do
        begin
          append;
          FieldByName('init_title').AsString:='monthends';
          FieldByName('init_Value').AsInteger:=temp*100+monthends[temp];
          post;
        end
    end;
    close;
    free;
  end;
end;

(************************** pish card procedures ************************)

procedure LoadPishCardDB;
var
  adoTbl : TADOTable;
  pish_code,pish_idx : integer;
begin
  if not tblExists('PishCard')
  then begin
    LoadPishCard;
    SavePishCardDB;
  end;
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'pishCard';
    Open;
    first;
    while not EOF do
    begin
      Pish_Code := FieldByName('Pish_Code').AsInteger;
      pish_idx:=GetPishCardIdx(Pish_Code);
      PishCard_LastName[pish_idx] := FieldByName('Pish_LastName').AsString;
      case FieldByName('Pish_active').AsBoolean of
           false:PishCard_Active[pish_idx] :=MB_FALSE;
           True :PishCard_Active[pish_idx] :=MB_TRUE;
      end;
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure SavePishCardDB;
var
  i : Byte;
  adoTbl : TADOTable;
begin
  if not tblExists('PishCard') then
    CreateTbl('PishCard');
  EmptyTbl('PishCard');
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'pishCard';
    open;
    for i := 1 to MaxPishCard do
    begin
      append;
      FieldByName('Pish_Code').AsInteger:=PishCard_No[I];
      FieldByName('Pish_LastName').AsString:=PishCard_LastName[i];
      if PishCard_Active[i]=MB_FALSE then FieldByName('Pish_active').AsBoolean:=false;
      if PishCard_Active[i]=MB_TruE then FieldByName('Pish_active').AsBoolean:=True;
      post;
    end;
    close;
    free;
  end;
end;

//    custom reports
procedure loadcustomrepsDB;
var
  adoTbl : TADOTable;
  j,n:integer;
  flds,lastyr:string;
  st:string[5];
  b:boolean;
begin
  customrepcount:=0;
  if not tblExists('customrp')
  then begin
//    loadcustomreps;
    SavecustomrepsDB;
  end;
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'customrp';
    Open;
    first;
    while not EOF do
    begin
      inc(customrepcount);
      customreps[customrepcount].repname:=FieldByName('customrp_RepName').AsString;
      customreps[customrepcount].reppaper:=FieldByName('customrp_RepPaper').AsInteger;
      customreps[customrepcount].repsize:=FieldByName('customrp_repsize').AsInteger;
      customreps[customrepcount].fieldcount:=FieldByName('customrp_fieldcount').AsInteger;
      flds:=FieldByName('customrp_repfields').AsString;
      for j:=1 to customreps[customrepcount].fieldcount do
      begin
        st:=copy(flds,j*5-4,5);
        n:=strtoint(st);
        customreps[customrepcount].repfields[j]:=customindex(n);
      end;
      lastyr:=FieldByName('CustomRp_isprevmonth').AsString;
      for j:=1 to customreps[customrepcount].fieldcount do
      begin
        case lastyr[j] of
             '0':b:=false;
             '1':b:=true;
        end;
        customreps[customrepcount].isprevmonth[j]:=b;
      end;
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure savecustomrepsDB;
var
  i,j,n : Integer;
  b:boolean;
  adoTbl : TADOTable;
  flds:string;
  lastyr:string;
  st:string[5];
begin
  if not tblExists('customrp') then
    CreateTbl('customrp');
  EmptyTbl('customrp');
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'customrp';
    open;
    for i := 1 to customrepcount do
    begin
      append;
      FieldByName('customrp_RepName').AsString:=customreps[i].repname;
      FieldByName('customrp_RepPaper').AsInteger:=customreps[i].reppaper;
      FieldByName('customrp_RepSize').AsInteger:=customreps[i].repsize;
      FieldByName('customrp_Fieldcount').AsInteger:=customreps[i].fieldcount;
      flds:='';
      for j:=1 to customreps[i].fieldcount do
      begin
        n:=reptypes[customreps[i].repfields[j]].r_code;
        str(n:5,st);
        flds:=flds+st;
      end;
      FieldByName('customrp_RepFields').AsString:=flds;
      lastyr:='';
      for j:=1 to customreps[i].fieldcount do
      begin
        b:=customreps[i].isprevmonth[j];
        if b
        then st:='1'
        else st:='0';
        lastyr:=lastyr+st;
      end;
      FieldByName('CustomRp_isprevmonth').AsString:=lastyr;
      post;
    end;
    close;
    free;
  end;
end;

procedure loadcustomdepthDB;
var
  adoTbl : TADOTable;
  n:integer;
begin
  for n:=1 to maxreptypes do
  with reptypes[n] do
  begin
        r_clen:=r_len;
        r_ctitle:=r_title;
  end;
  if not tblExists('customdp')
  then begin
    loadcustomdepth;
    SavecustomdepthDB;
  end;
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'customdp';
    Open;
    first;
    while not EOF do
    begin
      n:=FieldByName('customdp_Code').AsInteger;
      n:=customindex(n);
      reptypes[n].r_clen:=FieldByName('customdp_Clen').AsInteger;
      reptypes[n].r_ctitle:=FieldByName('customdp_CTitle').AsString;
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure savecustomdepthDB;
var
  i : Byte;
  adoTbl : TADOTable;
begin
  if not tblExists('customdp') then
    CreateTbl('customdp');
  EmptyTbl('customdp');
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'customdp';
    open;
    for i:=1 to maxreptypes do
    begin
      append;
      FieldByName('customdp_Code').AsInteger:=reptypes[i].r_code;
      FieldByName('customdp_CLen').AsInteger:=reptypes[i].r_clen;
      FieldByName('customdp_CTitle').AsString:=reptypes[i].r_ctitle;
      post;
    end;
    close;
    free;
  end;
end;

procedure savemktextrepsDB;
var
  i,j,n : Integer;
  b:boolean;
  adoTbl : TADOTable;
  flds:string;
  st:string[11];
begin
  if not tblExists('mktextrp') then
    CreateTbl('mktextrp');
  EmptyTbl('mktextrp');
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'mktextrp';
    open;
    for i:= 1 to mktextrepcount do
    begin
      append;
      FieldByName('mktextrp_RepName').AsString:=mktextreps[i].repname;
      FieldByName('mktextrp_FieldCount').AsInteger:=mktextreps[i].fieldcount;
      FieldByName('mktextrp_Delimiter').AsString:=mktextreps[i].delimiter;

      flds:='';
      for j:=1 to mktextreps[i].fieldcount do
      begin
        n:=mktextreps[i].repfields[j];
        str(n:5,st);
        flds:=flds+st;
      end;
      FieldByName('mktextrp_RepFields').AsString:=flds;

      flds:='';
      for j:=1 to mktextreps[i].fieldcount do
      begin
        n:=mktextreps[i].replens[j];
        str(n:5,st);
        flds:=flds+st;
      end;
      FieldByName('mktextrp_RepLens').AsString:=flds;

      flds:='';
      for j:=1 to mktextreps[i].fieldcount do
      begin
         st:=mktextreps[i].repdbfname[j];
         while length(st)<11 do st:=' '+st;
         flds:=flds+st;
      end;
      FieldByName('mktextrp_RepDBFNames').AsString:=flds;

      post;
    end;
    close;
    free;
  end;
end;

procedure loadmktextrepsDB;
var
  adoTbl : TADOTable;
  i,j,n:integer;
  flds:string;
  st:string[11];
begin
  mktextrepcount:=0;
  if not tblExists('mktextrp')
  then begin
    loadmktextreps;
    SavemktextrepsDB;
  end;
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'mktextrp';
    Open;
    first;
    while not EOF do
    begin
      inc(mktextrepcount);
      mktextreps[mktextrepcount].repname:=FieldByName('mktextrp_RepName').AsString;
      mktextreps[mktextrepcount].fieldcount:=FieldByName('mktextrp_FieldCount').AsInteger;
      mktextreps[mktextrepcount].delimiter:=FieldByName('mktextrp_Delimiter').AsString;

      flds:=FieldByName('mktextrp_repfields').AsString;
      for j:=1 to mktextreps[mktextrepcount].fieldcount do
      begin
        st:=copy(flds,j*5-4,5);
        n:=strtoint(st);
        mktextreps[mktextrepcount].repfields[j]:=n;
      end;

      flds:=FieldByName('mktextrp_repLens').AsString;
      for j:=1 to mktextreps[mktextrepcount].fieldcount do
      begin
        st:=copy(flds,j*5-4,5);
        n:=strtoint(st);
        mktextreps[mktextrepcount].repLens[j]:=n;
      end;

      flds:=FieldByName('mktextrp_repDBFNames').AsString;
      for j:=1 to mktextreps[mktextrepcount].fieldcount do
      begin
        st:=copy(flds,j*11-9,10);
        while (length(st)>1) and (st[1]=' ')  do st:=copy(st,2,10);
        while (length(st)>1) and (st[length(st)]=' ') do st:=copy(st,1,length(st)-1);
        mktextreps[mktextrepcount].repDBFName[j]:=st;
      end;

      Next;
    end;
    Close;
    Free;
  end;
end;

//  holidays procedures
procedure loadhollidaysDB(yr:integer);
var
   m,d:byte;
   kind:byte;
   qry : TADOQuery;
   st:string;
   y:integer;
begin
  if curr_holl_year =yr then exit;
  curr_holl_year :=yr;
  if not tblExists('holiday')
  then begin
    CreateTbl('holiday');
    for kind := 1 to 1 do
    if FileExists(ExtractFilePath(Application.ExeName) + ttlfilename[kind])
    then begin
       for y := 1379 to 1405 do
       begin
         loadhollidays(y);
         savehollidaysDB(y);
       end;
    end;
  end;
  for m:=1 to 12 do
  begin
    hollidays[1][m]:=[];
    hollidays[2][m]:=[];
  end;
  qry := TADOQuery.Create(Application);
  with qry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * FROM holiday' );
    SQL.Add('where holiday_year='+inttostr(yr));
    open;
    while not eof do
    begin
        m:=fieldbyname('holiday_month').AsInteger;
        st:=fieldbyname('holiday_rasmi').AsString;
        for d := 1 to length(st) do
        begin
           if st[d]='1'
           then hollidays[1][m]:=hollidays[1][m]+[d];
        end;
        st:=fieldbyname('holiday_Nonrasmi').AsString;
        for d := 1 to length(st) do
        begin
           if st[d]='1'
           then hollidays[2][m]:=hollidays[2][m]+[d];
        end;
        next;
    end;
    close;
    free;
  end;
end;

procedure savehollidaysDB(yr:integer);
var
   m,d:byte;
   qry : TADOQuery;
   adoTbl : TADOTable;
   st:string;
begin
  if not tblExists('holiday') then
    CreateTbl('holiday');
  qry := TADOQuery.Create(Application);
  with qry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('delete FROM holiday' );
    SQL.Add('where holiday_year='+inttostr(yr));
    execsql;
    free;
  end;

  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'holiday';
    open;
    for m:= 1 to 12 do
    begin
      append;
      FieldByName('holiday_Year').AsInteger:=yr;
      FieldByName('holiday_Month').AsInteger:=m;

      st:='0000000000000000000000000000000';
      for d := 1 to 31 do
       if d in hollidays[1][m]
        then st[d]:='1';
      FieldByName('holiday_rasmi').AsString:=st;

      st:='0000000000000000000000000000000';
      for d := 1 to 31 do
       if d in hollidays[2][m]
        then st[d]:='1';
      FieldByName('holiday_Nonrasmi').AsString:=st;

      post;
    end;
    close;
    free;
  end;
end;

function CheckHolidayDB(kind : Byte; yr, mn, dy : Integer) : Boolean;
var
  temp:integer;
begin
//   temp:=curr_holl_year;
   loadhollidaysDB(yr);
   Result := (dy in hollidays[kind][mn]);
//   _loadhollidays(temp);
end;

function IsHolidayDB(dt : String) : Boolean;
begin
  if IsTrueDate(dt) then
    Result :=CheckHolidayDB(1, StrToInt(Copy(dt, 1, 4)), StrToInt(Copy(dt, 6, 2)), StrToInt(Copy(dt, 9, 2)))
          or CheckHolidayDB(2, StrToInt(Copy(dt, 1, 4)), StrToInt(Copy(dt, 6, 2)), StrToInt(Copy(dt, 9, 2)))
  else
    Result := False;
end;

(************************** Reader procedures ************************)

{ Load Units In Global Variables }
procedure LoadReaders;
var
  adoTbl : TADOTable;
begin
  adoTbl := TADOTable.Create(Application);
  with adoTbl do
  begin
    Connection := frmDBS.DBConnection;
    TableName := 'Readers';
    Open;
    TotalReader := 0;
    TotalActvRdr := 0;
    TotalOnLineRdr := 0;
    first;
    while not EOF do
    begin
      Inc(TotalReader);
      with Readers[TotalReader] do
      begin
        R_Code := FieldByName('R_Code').AsInteger;
        R_Name := FieldByName('R_Name').AsString;
        R_Active := FieldByName('R_Active').AsBoolean;
        R_Port := FieldByName('R_Port').AsInteger;
        R_BaudNo := FieldByName('R_BaudNo').AsInteger;
        R_IsCom := FieldByName('R_IsCOM').AsBoolean;
//kaveh is
        if R_IsCom then
          R_ComType := SERIAL
        else
          R_ComType := NETWORK;
//kaveh ie
        R_IP := FieldByName('R_IP').AsString;
        R_TCP := FieldByName('R_TCP').AsBoolean;
        R_Type := FieldByName('R_Type').AsInteger;
        R_RTS := FieldByName('R_Modem').AsBoolean;
        if R_Active then Inc(TotalActvRdr);
      end;
      Next;
    end;
    Close;
    Free;
  end;
end;

{ Return Index of Reader in variables }
function FindReaderNameIdx(ReaderName : String) : Byte;
var i : byte;
begin
  FindReaderNameIdx := 0;
  for i := 1 to TotalReader do
    with Readers[i] do
      if R_Name = ReaderName then
      begin
        FindReaderNameIdx := i;
        Break;
      end;
end;

{ Return Index of Reader in variables }
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

{ Return Reader Name From Variables }
function GetReaderNameInRam(ReaderCode : Integer) : String;
var
  i : Byte;
  s : String;
begin
  s := '';
  for i := 1 to TotalReader do
    if Readers[i].R_Code = ReaderCode then
    begin
      s := Readers[i].R_Name;
      Break;
    end;
  GetReaderNameInRam := s;
end;

{ Return Door Code From Readers }
function GetReaderCode(ReaderName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT R_Code FROM Readers');
    {$IFDEF Network}
    SQL.Add('WHERE R_Name = N''' + ReaderName + '''');
    {$else}
    SQL.Add('WHERE R_Name = ''' + ReaderName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetReaderCode := FieldByName('R_Code').AsInteger
    else
      GetReaderCode := -1;
    Close;
  end;
end;

{ Return Door Name From Readers }
function GetReaderName(ReaderCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT R_Name FROM Readers');
    SQL.Add('WHERE R_Code = ' + IntToStr(ReaderCode));
    Open;
    if RecordCount > 0 then
      GetReaderName := FieldByName('R_Name').AsString
    else
      GetReaderName := '';
    Close;
  end;
end;

(************************ Stations Procedures **************************)

function GetStationCode(stName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT st_Code FROM stations');
    {$IFDEF Network}
    SQL.Add('WHERE st_Name = N''' + stName + '''');
    {$else}
    SQL.Add('WHERE st_Name = ''' + stName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('st_Code').AsInteger
    else
      Result := -1;
    Close;
  end;
end;

{ Return Station Name From Stations }
function GetStationName(StCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT St_Name FROM Stations');
    SQL.Add('WHERE st_Code = ' + IntToStr(StCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('st_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

(************************ Person Procedures **************************)

{ Return True, if PersonCode Exists in Machines table }
function InCirclePerson(PersonCode : String) : Boolean;
begin
  With frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT M_BarCode FROM Machines');
    {$IFDEF Network}
    SQL.Add('WHERE M_IPerson = N''' + PersonCode + '''');
    SQL.Add('OR M_OPerson = N''' + PersonCode + '''');
    {$else}
    SQL.Add('WHERE M_IPerson = ''' + PersonCode + '''');
    SQL.Add('OR M_OPerson = ''' + PersonCode + '''');
    {$ENDIF}
    Open;
    InCirclePerson := not frmDBS.adoQryG.EOF;
    Close;
  end;
end;

{ Return Person Name From Persons }
function GetPersonCode(PersonName : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Name = N''' + PersonName + '''');
    {$else}
    SQL.Add('WHERE P_Name = ''' + PersonName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPersonCode := FieldByName('P_Code').AsString
    else
      GetPersonCode := '';
    Close;
  end;
end;

function GetPersonCodeB(PersonEstekhdami : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Estekhdami = N''' + PersonEstekhdami + '''');
    {$else}
    SQL.Add('WHERE P_Estekhdami = ''' + PersonEstekhdami + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPersonCodeB := FieldByName('P_Code').AsString
    else
      GetPersonCodeB := '';
    Close;
  end;
end;

{ Return Person Name From Persons }
function GetPersonCodeEX(PersonFamilyName : String) : String;
var
  PersonName, PersonFamily : string;
  position : integer;
begin
  with frmDBS.adoQryG do
  begin
    position := pos('-', PersonFamilyName);
    PersonFamily := Copy(PersonFamilyName, 1, position - 1);
    PersonName := Copy(PersonFamilyName, position + 1, length(PersonFamilyName));
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Name = N''' + PersonName + ''' ');
    SQL.Add('AND P_Family = N''' + PersonFamily + '''');
    {$else}
    SQL.Add('WHERE P_Name = ''' + PersonName + ''' ');
    SQL.Add('AND P_Family = ''' + PersonFamily + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      result := FieldByName('P_Code').AsString
    else
      result := '';
    Close;
  end;
end;


{ Return Person Name From Persons }
function GetPersonName(PersonCode : String) : String;
begin
  with frmDBS.adoTblPersons do
    if locate('P_Code' , PersonCode , [LoPArtialKey]) then
      GetPersonName := FieldByName('P_Name').AsString
    else
      GetPersonName := '';
end;

{ Return Person Name From Persons }
function GetPersonFamilyName(PersonCode : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT nP_Name, nP_Family FROM nPersons');
    {$IFDEF Network}
    SQL.Add('WHERE nP_Code = N''' + PersonCode + '''');
    {$else}
    SQL.Add('WHERE nP_Code = ''' + PersonCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPersonFamilyName := FieldByName('nP_Family').AsString + '-' +
                             FieldByName('nP_Name').AsString
    else
      GetPersonFamilyName := '';
    Close;
  end;
end;

{ Return Person Family From Persons }
function GetPersonFamily(PersonCode : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Family FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Code = N''' + PersonCode + '''');
    {$else}
    SQL.Add('WHERE P_Code = ''' + PersonCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('P_Family').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return Person Information From Persons }
function GetPerson(PersonCode : String; IsProxi : Boolean) : TPerson;
var
  p : TPerson;
  isFound : boolean;
  qry : TADOQuery;
begin
  isFound := false;
  qry := TADOQuery.Create(Application);
  with qry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Add('select * from persons');
    SQL.Add('left outer join proxies on p_code = P_CustomerCode');
    SQL.Add('left outer join cashes on p_BoxNo=c_code');
    open;
    if IsProxi then
    begin
      if Locate('P_Proxi' , PersonCode , [LoPArtialKey]) then
        isFound := true;
    end
    else
    begin
      if locate('P_Code' , PersonCode , [LoPArtialKey]) then
        isFound := true;
    end;
    if isFound then
    begin
      p.P_Code := FieldByName('P_Code').AsString;
      p.P_Proxi := FieldByName('P_Proxi').AsString;
      p.P_Name := FieldByName('P_Name').AsString;
      p.P_Family := FieldByName('P_Family').AsString;
      p.P_Picture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture').AsString;
//      p.P_V1Name := FieldByName('P_V1Name').AsString;
//      p.P_V1Family := FieldByName('P_V1Family').AsString;
//      p.P_V1Picture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V1Picture').AsString;
//      p.P_V2Name := FieldByName('P_V2Name').AsString;
//      p.P_V2Family := FieldByName('P_V2Family').AsString;
//      p.P_V2Picture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V2Picture').AsString;
      p.P_ContractNo := FieldByName('P_ContractNo').AsString;
      p.P_ContractDate := FieldByName('P_ContractDate').AsString;
      p.P_ContractEndDate := FieldByName('P_ContractEndDate').AsString;
      p.P_FatherName := FieldByName('P_Father').AsString;
      p.P_IDNO := FieldByName('p_IDNO').AsString;
      p.p_BirthDate := FieldByName('p_BirthDate').AsString;
      p.P_Box := FieldByName('c_place').AsString + '-' + FieldByName('C_Name').AsString;
      p.P_IsBlocked := FieldByName('P_IsBlocked').Asboolean;
      p.P_SignPicture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_SignPicture').AsString; //kaveh
//      p.P_VakilSignPicture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V1SignPicture').AsString; //kaveh
//      p.P_Vakil2SignPicture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V2SignPicture').AsString; //kaveh
      p.P_IsProvisionalBlocked := FieldByName('P_IsProvisionalBlocked').Asboolean; //kaveh
//      p.P_NameSec := FieldByName('P_Name_Sec').AsString; //kaveh
//      p.P_FamilySec := FieldByName('P_Family_Sec').AsString; //kaveh
//      p.P_PictureSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture_Sec').AsString; //kaveh
//      p.P_SignPictureSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_SignPicture_Sec').AsString; //kaveh
      p.P_IsCommonBox := FieldByName('P_IsCommonBox').Asboolean; //kaveh
    end
    else
    begin
      p.P_Code := '';
      p.P_Proxi := '';
      p.P_Name := '';
      p.P_Family := '';
      p.P_Picture := '';
//      p.P_V1Name := '';
//      p.P_V1Family := '';
//      p.P_V1Picture := '';
//      p.P_V2Name := '';
//      p.P_V2Family := '';
//      p.P_V2Picture := '';
      p.P_ContractDate := '';
      p.P_ContractEndDate := '';
      p.P_FatherName := '';
      p.P_IDNO := '';
      p.p_BirthDate := '';
      p.P_Box := '';
      p.P_IsBlocked := False;
      p.P_SignPicture := ''; //kaveh
//      p.P_VakilSignPicture := ''; //kaveh
//      p.P_Vakil2SignPicture := ''; //kaveh
      p.P_IsProvisionalBlocked := False; //kaveh
//      p.P_NameSec := ''; //kaveh
//      p.P_FamilySec := ''; //kaveh
//      p.P_PictureSec := ''; //kaveh
//      p.P_SignPictureSec := ''; //kaveh
      p.P_IsCommonBox := False; //kaveh

    end;
  end;
  GetPerson := p;
end;


{ Return Person Information From nPersons }
function GetnPerson(nPersonCode : String; IsProxi : Boolean) : TPerson;
var
  p : TPerson;
//  isFound : boolean;
  qry : TADOQuery;
begin
//  isFound := false;
  qry := TADOQuery.Create(Application);
  if not IsProxi then
  begin
    with qry do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Add('SELECT nP_Code, nP_Proxi, nP_Name, nP_Family, nP_Picture, P_ContractNo,P_ContractDate, P_ContractEndDate, ');
      SQL.Add('nP_Father, np_IDNO, np_BirthDate, c_place, C_Name, P_IsBlocked, nP_SignPicture, P_IsProvisionalBlocked, P_IsCommonBox, ');
      SQL.Add('p_CommonBoxType, p_IsLegalCustomer, p_CoName, np_IsMemberCommonBoxType3');
      SQL.Add('FROM Persons LEFT OUTER JOIN ');
      SQL.Add('nPersons ON Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
      SQL.Add('Cashes ON Persons.p_BoxNo = Cashes.c_code ');
      SQL.Add('where nP_Code = ''' + nPersonCode + ''' ');
      open;

      First;
      if RecordCount > 0 then
      begin
        p.P_Code := FieldByName('nP_Code').AsString;
        p.P_Proxi := FieldByName('nP_Proxi').AsString;
        p.P_Name := FieldByName('nP_Name').AsString;
        p.P_Family := FieldByName('nP_Family').AsString;
        p.P_Picture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_Picture').AsString;
        p.P_ContractNo := FieldByName('P_ContractNo').AsString;
        p.P_ContractDate := FieldByName('P_ContractDate').AsString;
        p.P_ContractEndDate := FieldByName('P_ContractEndDate').AsString;
        p.P_FatherName := FieldByName('nP_Father').AsString;
        p.P_IDNO := FieldByName('np_IDNO').AsString;
        p.p_BirthDate := FieldByName('np_BirthDate').AsString;
        p.P_Box := FieldByName('c_place').AsString + '-' + FieldByName('C_Name').AsString;
        p.P_IsBlocked := FieldByName('P_IsBlocked').Asboolean;
        p.P_SignPicture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_SignPicture').AsString;
        p.P_IsProvisionalBlocked := FieldByName('P_IsProvisionalBlocked').Asboolean;
        p.P_IsCommonBox := FieldByName('P_IsCommonBox').Asboolean;
        p.P_CommonBoxType := FieldByName('p_CommonBoxType').AsInteger; 
        p.P_IsLegalCustomer := FieldByName('p_IsLegalCustomer').Asboolean;
        p.p_CoName := FieldByName('p_CoName').AsString;
        p.P_IsMemberCommonBoxType3 := FieldByName('np_IsMemberCommonBoxType3').Asboolean; 
      end
      else
      begin
        p.P_Code := '';
        p.P_Proxi := '';
        p.P_Name := '';
        p.P_Family := '';
        p.P_Picture := '';
        p.P_ContractNo := '';
        p.P_ContractDate := '';
        p.P_ContractEndDate := '';
        p.P_FatherName := '';
        p.P_IDNO := '';
        p.p_BirthDate := '';
        p.P_Box := '';
        p.P_IsBlocked := False;
        p.P_SignPicture := '';
        p.P_IsProvisionalBlocked := False;
        p.P_IsCommonBox := False;
        p.P_CommonBoxType := 0;
        p.P_IsLegalCustomer := False;
        p.p_CoName := '';
        p.P_IsMemberCommonBoxType3 := False;
      end;
    end;
{    p.P_Code := '';
    p.P_Proxi := '';
    p.P_Name := '';
    p.P_Family := '';
    p.P_Picture := '';
//    p.P_V1Name := '';
//    p.P_V1Family := '';
//    p.P_V1Picture := '';
//    p.P_V2Name := '';
//    p.P_V2Family := '';
//    p.P_V2Picture := '';
    p.P_ContractNo := '';
    p.P_ContractDate := '';
    p.P_ContractEndDate := '';
    p.P_FatherName := '';
    p.P_IDNO := '';
    p.p_BirthDate := '';
    p.P_Box := '';
    p.P_IsBlocked := False;
    p.P_SignPicture := '';
//    p.P_VakilSignPicture := '';
//    p.P_Vakil2SignPicture := '';
    p.P_IsProvisionalBlocked := False;
//    p.P_NameSec := '';
//    p.P_FamilySec := '';
//    p.P_PictureSec := '';
//    p.P_SignPictureSec := '';
    p.P_IsCommonBox := False;
    p.P_CommonBoxType := 0;
    p.P_IsLegalCustomer := False;
    p.p_CoName := '';
    p.P_IsMemberCommonBoxType3 := False;  }
  end
  else
  begin
    with qry do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Add('SELECT nP_Code, nP_Proxi, nP_Name, nP_Family, nP_Picture, P_ContractNo,P_ContractDate, P_ContractEndDate, ');
      SQL.Add('nP_Father, np_IDNO, np_BirthDate, c_place, C_Name, P_IsBlocked, nP_SignPicture, P_IsProvisionalBlocked, P_IsCommonBox, ');
      SQL.Add('p_CommonBoxType, p_IsLegalCustomer, p_CoName, np_IsMemberCommonBoxType3');
      SQL.Add('FROM Persons LEFT OUTER JOIN ');
      SQL.Add('nPersons ON Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
  //    SQL.Add('nProxies ON Persons.p_code = nProxies.nP_CustomerCode LEFT OUTER JOIN ');
      SQL.Add('Cashes ON Persons.p_BoxNo = Cashes.c_code ');
      SQL.Add('where nP_Proxi = ''' + nPersonCode + ''' ');
  //    SQL.Add('order by np_VProxi');
      open;
  //    if IsProxi then
  //    begin
  //      if Locate('P_Proxi' , nPersonCode , [LoPArtialKey]) then
  //        isFound := true;
  //    end
  //    else
  //    begin
  //      if locate('P_Code' , nPersonCode , [LoPArtialKey]) then
  //        isFound := true;
  //    end;
  //    while not Eof do
  //    begin
  //      if FieldByName('np_VProxi').AsString = '1' then
  //      begin
  //
  //      end
  //      else if FieldByName('np_VProxi').AsString = '2' then
  //      begin
  //
  //      end;
  //
  //    end;

      First;
      if RecordCount > 0 then
      begin
        p.P_Code := FieldByName('nP_Code').AsString;
        p.P_Proxi := FieldByName('nP_Proxi').AsString;
        p.P_Name := FieldByName('nP_Name').AsString;
        p.P_Family := FieldByName('nP_Family').AsString;
        p.P_Picture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_Picture').AsString;
//        p.P_V1Name := '';
//        p.P_V1Family := '';
//        p.P_V1Picture := '';
//        p.P_V2Name := '';
//        p.P_V2Family := '';
//        p.P_V2Picture := '';
        p.P_ContractNo := FieldByName('P_ContractNo').AsString;
        p.P_ContractDate := FieldByName('P_ContractDate').AsString;
        p.P_ContractEndDate := FieldByName('P_ContractEndDate').AsString;
        p.P_FatherName := FieldByName('nP_Father').AsString;
        p.P_IDNO := FieldByName('np_IDNO').AsString;
        p.p_BirthDate := FieldByName('np_BirthDate').AsString;
        p.P_Box := FieldByName('c_place').AsString + '-' + FieldByName('C_Name').AsString;
        p.P_IsBlocked := FieldByName('P_IsBlocked').Asboolean;
        p.P_SignPicture := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_SignPicture').AsString;
//        p.P_VakilSignPicture := '';
//        p.P_Vakil2SignPicture := '';
        p.P_IsProvisionalBlocked := FieldByName('P_IsProvisionalBlocked').Asboolean;
//        p.P_NameSec := '';
//        p.P_FamilySec := '';
//        p.P_PictureSec := '';
//        p.P_SignPictureSec := '';
        p.P_IsCommonBox := FieldByName('P_IsCommonBox').Asboolean;
        p.P_CommonBoxType := FieldByName('p_CommonBoxType').AsInteger; 
        p.P_IsLegalCustomer := FieldByName('p_IsLegalCustomer').Asboolean;
        p.p_CoName := FieldByName('p_CoName').AsString;
        p.P_IsMemberCommonBoxType3 := FieldByName('np_IsMemberCommonBoxType3').Asboolean; 
      end
      else
      begin
        p.P_Code := '';
        p.P_Proxi := '';
        p.P_Name := '';
        p.P_Family := '';
        p.P_Picture := '';
//        p.P_V1Name := '';
//        p.P_V1Family := '';
//        p.P_V1Picture := '';
//        p.P_V2Name := '';
//        p.P_V2Family := '';
//        p.P_V2Picture := '';
        p.P_ContractNo := '';
        p.P_ContractDate := '';
        p.P_ContractEndDate := '';
        p.P_FatherName := '';
        p.P_IDNO := '';
        p.p_BirthDate := '';
        p.P_Box := '';
        p.P_IsBlocked := False;
        p.P_SignPicture := '';
//        p.P_VakilSignPicture := '';
//        p.P_Vakil2SignPicture := '';
        p.P_IsProvisionalBlocked := False;
//        p.P_NameSec := '';
//        p.P_FamilySec := '';
//        p.P_PictureSec := '';
//        p.P_SignPictureSec := '';
        p.P_IsCommonBox := False;
        p.P_CommonBoxType := 0;
        p.P_IsLegalCustomer := False;
        p.p_CoName := ''; 
        p.P_IsMemberCommonBoxType3 := False;
      end;
    end;
  end;
  GetnPerson := p;
end;

(************************ tmpPersons Procedures **************************)

{ Return Person Name From Persons }
function GetTmpPersonCode(PersonName : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM TmpPersons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Name = N''' + PersonName + '''');
    {$else}
    SQL.Add('WHERE P_Name = ''' + PersonName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetTmpPersonCode := FieldByName('P_Code').AsString
    else
      GetTmpPersonCode := '';
    Close;
  end;
end;

{ Return Person Name From Persons }
function GetTmpPersonName(PersonCode : String) : String;
begin
  with frmDBS.adoTblTmpPersons do
    if locate('P_Code' , PersonCode , [LoPArtialKey]) then
      GetTmpPersonName := FieldByName('P_Name').AsString
    else
      GetTmpPersonName := '';
end;

{ Return Person Name From Persons }
function GetTmpPersonFamilyName(PersonCode : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Name, P_Family FROM TmpPersons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Code = N''' + PersonCode + '''');
    {$else}
    SQL.Add('WHERE P_Code = ''' + PersonCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetTmpPersonFamilyName := FieldByName('P_Family').AsString + '-' +
                                FieldByName('P_Name').AsString
    else
      GetTmpPersonFamilyName := '';
    Close;
  end;
end;


(************************ JobType Procedures ****************************)

{ Return Job_Name from JobType database }
function GetJobName(JobCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Job_Name FROM JobType');
    SQL.Add('WHERE Job_Code = ' + IntToStr(JobCode));
    Open;
    if RecordCount > 0 then
      GetJobName := FieldByName('Job_Name').AsString
    else
      GetJobName := '';
    Close;
  end;
end;

{ Return JobCode from JobType database }
function GetJobCode(JobName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Job_Code FROM JobType');
    {$IFDEF Network}
    SQL.Add('WHERE Job_Name = N''' + JobName + '''');
    {$else}
    SQL.Add('WHERE Job_Name = ''' + JobName + '''');
    {$ENDIF}

    Open;
    if RecordCount > 0 then
      GetJobCode := FieldByName('Job_Code').AsInteger
    else
      GetJobCode := 0;
    Close;
  end;
end;




(************************ Part Procedures ****************************)


{ Return PartName from partLvl database }
function GetPartName(P1, P2, P3, P4 : LongInt; Lvl : Byte) : String;overload;
begin
  with frmDBS.adoQryG do
  begin
    if Lvl = 1 then
    begin
      SQL.Clear;
      SQL.Add('SELECT P1_Name FROM Part1');
      SQL.Add('WHERE P1_Code = ' + IntToStr(P1));
      Open;
      if RecordCount > 0 then
        result := FieldByName('P1_Name').AsString
      else
        result := '';
      Close;
    end
    else if Lvl = 2 then
    begin
      SQL.Clear;
      SQL.Add('SELECT P2_Name FROM Part2');
      SQL.Add('WHERE P2_P1Code = ' + IntToStr(P1));
      SQL.Add('AND P2_Code = ' + IntToStr(P2));
      Open;
      if RecordCount > 0 then
        result := FieldByName('P2_Name').AsString
      else
        result := '';
      Close;
    end
    else if Lvl = 3 then
    begin
      SQL.Clear;
      SQL.Add('SELECT P3_Name FROM Part3');
      SQL.Add('WHERE P3_P1Code = ' + IntToStr(P1));
      SQL.Add('AND P3_P2Code = ' + IntToStr(P2));
      SQL.Add('AND P3_Code = ' + IntToStr(P3));
      Open;
      if RecordCount > 0 then
        result := FieldByName('P3_Name').AsString
      else
        result := '';
      Close;
    end
    else if Lvl = 4 then
    begin
      SQL.Clear;
      SQL.Add('SELECT P4_Name FROM Part4');
      SQL.Add('WHERE P4_P1Code = ' + IntToStr(P1));
      SQL.Add('AND P4_P2Code = ' + IntToStr(P2));
      SQL.Add('AND P4_P3Code = ' + IntToStr(P3));
      SQL.Add('AND P4_Code = ' + IntToStr(P4));
      Open;
      if RecordCount > 0 then
        result := FieldByName('P4_Name').AsString
      else
        result := '';
      Close;
    end
    else
      result := '';
  end;
end;

function GetPartName(CustomCode : String) : String;overload;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Name FROM Parts');
    {$IFDEF Network}
    SQL.Add('WHERE P_CustomCode = N''' + CustomCode + '''');
    {$else}
    SQL.Add('WHERE P_CustomCode = ''' + CustomCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPartName := FieldByName('P_Name').AsString
    else
      GetPartName := '';
    Close;
  end;
end;

function GetPartCustomCode(Code : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_CustomCode FROM Parts');
    {$IFDEF Network}
    SQL.Add('WHERE P_Code = N''' + Code + '''');
    {$else}
    SQL.Add('WHERE P_Code = ''' + Code + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPartCustomCode := FieldByName('P_CustomCode').AsString
    else
      GetPartCustomCode := '';
    Close;
  end;
end;

function GetPartCode(CustomCode : String) : String;overload;
var
  adoQry : TADOQuery;
begin
  adoQry := TADOQuery.Create(Application);
  with adoQry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM Parts');
    {$IFDEF Network}
    SQL.Add('WHERE P_CustomCode = N''' + CustomCode + '''');
    {$else}
    SQL.Add('WHERE P_CustomCode = ''' + CustomCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('P_Code').AsString
    else
      Result := '';
    Close;
    Free;
  end;
end;

function GetPartCode(PartName : String; Lvl : Byte) : Integer;overload;
var
  fldName, fldCode : String;
begin
  with frmDBS.adoQryG do
  begin
    if Lvl in [1..4] then
    begin
      fldName := 'P' + IntToStr(Lvl) + '_Name';
      fldCode := 'P' + IntToStr(Lvl) + '_Code';
      SQL.Clear;
      SQL.Add('SELECT ' + fldCode + ' FROM Part' + IntToStr(Lvl));
    {$IFDEF Network}
      SQL.Add('WHERE ' + fldName + ' = N''' + PartName + '''');
    {$else}
      SQL.Add('WHERE ' + fldName + ' = ''' + PartName + '''');
    {$ENDIF}
      Open;
      if RecordCount > 0 then
        GetPartCode := FieldByName(fldCode).AsInteger
      else
        GetPartCode := 0;
      Close;
    end
    else
      GetPartCode := 0;
  end;
end;

function GetPartCodeEX(PrivPartCode: integer;PartName : String; Lvl : Byte) : Integer;
var
  fldPrvName, fldName, fldCode : String;
begin
  with frmDBS.adoQryG do
  begin
    if Lvl in [1..4] then
    begin
      fldPrvName := 'P' + IntToStr(Lvl) + '_P' + IntToStr(Lvl - 1) + 'Code';
      fldName := 'P' + IntToStr(Lvl) + '_Name';
      fldCode := 'P' + IntToStr(Lvl) + '_Code';
      SQL.Clear;
      SQL.Add('SELECT ' + fldCode + ' FROM Part' + IntToStr(Lvl));
    {$IFDEF Network}
      SQL.Add('WHERE ' + fldName + ' = N''' + partName + '''');
    {$else}
      SQL.Add('WHERE ' + fldName + ' = ''' + partName + '''');
    {$ENDIF}
      if Lvl <> 1 then
        SQL.Add(' AND ' + fldPrvName + ' = ' + IntToStr(PrivPartCode));
      Open;
      if RecordCount > 0 then
        Result := FieldByName(fldCode).AsInteger
      else
        Result := 0;
      Close;
    end
    else
      Result := 0;
  end;
end;

function GetAllPartName(Code : String;dlmtr : string = '-') : String;overload;
var
  i : integer;
  C : string;
begin
  result := '';
//code := GetPartCode(CustomCode);
  C := Code;
  for i := 0 to ((length(code) div 2) - 1) do
  begin
    C := copy(code , 0 , length(code) - 2*i);
    if Result <> '' then
      Result := dlmtr + Result;
    Result := GetPartName(getpartCustomCode(C)) + Result;
  end;
end;

function GetAllPartName(P1, P2, P3, P4 : LongInt) : String;overload;
var
  s : String;
begin
  with frmDBS.adoQryG do
  begin
    s := '';
    SQL.Clear;
    SQL.Add('SELECT P1_Name FROM Part1');
    SQL.Add('WHERE P1_Code = ' + IntToStr(P1));
    Open;
    if RecordCount > 0 then
      s := s + FieldByName('P1_Name').AsString;
    Close;

    SQL.Clear;
    SQL.Add('SELECT P2_Name FROM Part2');
    SQL.Add('WHERE P2_P1Code = ' + IntToStr(P1));
    SQL.Add('AND P2_Code = ' + IntToStr(P2));
    Open;
    if RecordCount > 0 then
      s := s + ' - ' + FieldByName('P2_Name').AsString;
    Close;

    SQL.Clear;
    SQL.Add('SELECT P3_Name FROM Part3');
    SQL.Add('WHERE P3_P1Code = ' + IntToStr(P1));
    SQL.Add('AND P3_P2Code = ' + IntToStr(P2));
    SQL.Add('AND P3_Code = ' + IntToStr(P3));
    Open;
    if RecordCount > 0 then
      s := s + ' - ' + FieldByName('P3_Name').AsString;
    Close;

    SQL.Clear;
    SQL.Add('SELECT P4_Name FROM Part4');
    SQL.Add('WHERE P4_P1Code = ' + IntToStr(P1));
    SQL.Add('AND P4_P2Code = ' + IntToStr(P2));
    SQL.Add('AND P4_P3Code = ' + IntToStr(P3));
    SQL.Add('AND P4_Code = ' + IntToStr(P4));
    Open;
    if RecordCount > 0 then
      s := s + ' - ' + FieldByName('P4_Name').AsString;
    Close;

    GetAllPartName := s;
  end;
end;


(************************ CoPost Procedures ****************************)

{ Return Post_Name from CoPost database }
function GetPostName(PostCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Post_Name FROM CoPosts');
    SQL.Add('WHERE Post_Code = ' + IntToStr(PostCode));
    Open;
    if RecordCount > 0 then
      GetPostName := FieldByName('Post_Name').AsString
    else
      GetPostName := '';
    Close;
  end;
end;

{ Return PostCode from CoPosts database }
function GetPostCode(PostName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Post_Code FROM CoPosts');
    {$IFDEF Network}
    SQL.Add('WHERE Post_Name = N''' + PostName + '''');
    {$else}
    SQL.Add('WHERE Post_Name = ''' + PostName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetPostCode := FieldByName('Post_Code').AsInteger
    else
      GetPostCode := 0;
    Close;
  end;
end;





(************************ Group Procedures ****************************)

{ Return Group_Name from Groups database }
function GetGroupName(GroupCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Grp_Name FROM Groups');
    SQL.Add('WHERE Grp_Code = ' + IntToStr(GroupCode));
    Open;
    if RecordCount > 0 then
      GetGroupName := FieldByName('Grp_Name').AsString
    else
      GetGroupName := '';
    Close;
  end;
end;

{ Return GroupCode from Groups database }
function GetGroupCode(GroupName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Grp_Code FROM Groups');
    {$IFDEF Network}
    SQL.Add('WHERE Grp_Name = N''' + GroupName + '''');
    {$else}
    SQL.Add('WHERE Grp_Name = ''' + GroupName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetGroupCode := FieldByName('Grp_Code').AsInteger
    else
      GetGroupCode := 0;
    Close;
  end;
end;





(************************ Rule Procedures ****************************)

{ Return Rule_Name from Rules database }
function GetRuleName(RuleCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Rule_Name FROM Rules');
    SQL.Add('WHERE Rule_Code = ' + IntToStr(RuleCode));
    Open;
    if RecordCount > 0 then
      GetRuleName := FieldByName('Rule_Name').AsString
    else
      GetRuleName := '';
    Close;
  end;
end;

{ Return RuleCode from Rules database }
function GetRuleCode(RuleName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Rule_Code FROM Rules');
    {$IFDEF Network}
    SQL.Add('WHERE Rule_Name = N''' + RuleName + '''');
    {$else}
    SQL.Add('WHERE Rule_Name = ''' + RuleName + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetRuleCode := FieldByName('Rule_Code').AsInteger
    else
      GetRuleCode := 0;
    Close;
  end;
end;

{ Return GroupM_Name from GroupM database }
{
function GetGroupMName(GroupMCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT GrpM_Name FROM GroupM');
    SQL.Add('WHERE GrpM_Code = ' + IntToStr(GroupMCode));
    Open;
    if RecordCount > 0 then
      GetGroupMName := FieldByName('GrpM_Name').AsString
    else
      GetGroupMName := '';
    Close;
  end;
end;
}
{ Return GroupCode from GroupM database }
{
function GetGroupMCode(GroupMName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT GrpM_Code FROM GroupM');
    SQL.Add('WHERE GrpM_Name = N''' + GroupMName + '''');
    Open;
    if RecordCount > 0 then
      GetGroupMCode := FieldByName('GrpM_Code').AsInteger
    else
      GetGroupMCode := 0;
    Close;
  end;
end;
}

(************************ Mission place Procedures ****************************)

{ Return M1_Name from mission1 database }
function GetMission1Name(m1Code : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Mission1');
    SQL.Add('Where M1_Code = ' + inttostr(m1Code));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('M1_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return M1_Code from Mission1 database }
function Getmission1Code(m1Name : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Mission1');
    {$IFDEF Network}
    SQL.Add('Where M1_Name = N''' + m1Name + '''');
    {$else}
    SQL.Add('Where M1_Name = ''' + m1Name + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('M1_Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

{ Return M2_Name from mission2 database }
function GetMission2Name(m2Code : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Mission2');
    SQL.Add('Where M2_Code = ' + inttostr(m2Code));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('M2_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return M2_Code from Mission2 database }
function Getmission2Code(m2Name : String) : Integer;
begin
  if m2name=''
  then begin
       result:=-1;
       exit;
  end;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Mission2');
    {$IFDEF Network}
    SQL.Add('Where M2_Name = N''' + m2Name + '''');
    {$else}
    SQL.Add('Where M2_Name = ''' + m2Name + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('M2_Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

function GetAllMissionName(M2_Code : Integer) : String;
var
  tmp : integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Mission2');
    SQL.Add('Where M2_Code = ' + inttostr(M2_Code));
    Open;
    if RecordCount > 0 then
    begin
      Result := FieldByName('M2_Name').AsString;
      tmp := fieldByName('M2_M1Code').AsInteger;
      close;
      SQL.Clear;
      SQL.Add('select * from Mission1');
      SQL.Add('Where M1_Code = ' + IntToStr(tmp));
      Open;
      Result := fieldByName('M1_Name').AsString +  ' - ' + Result;
    end
    else
      Result := '';
    Close;
  end;
end;




{ Diseases & Doctors Procedures }


{ Return Diseases_Name from Diseases database }
function GetDiseasesName(Code : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from diseases');
    SQL.Add('Where code = ' + inttostr(Code));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return Diseases_Code from Diseases database }
function GetDiseasesCode(Name : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from diseases');
    {$IFDEF Network}
    SQL.Add('Where Name = N''' + Name + '''');
    {$else}
    SQL.Add('Where Name = ''' + Name + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

{ Return doctors_Name from doctors database }
function GetDoctorsName(Code : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from Doctors');
    SQL.Add('Where code = ' + inttostr(Code));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Name').AsString
    else
      Result := '';
    Close;
  end;
end;
{ Return doctors_Code from doctors database }
function GetDoctorsCode(Name : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('select * from doctors');
    {$IFDEF Network}
    SQL.Add('Where Name = N''' + Name + '''');
    {$else}
    SQL.Add('Where Name = ''' + Name + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

function getAddFreeTypeName(Code : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT AddT_Name FROM aFreeTyp');
    SQL.Add('WHERE AddT_Code = ' + inttostr(Code));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('AddT_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

procedure LoadShifts;
begin
end;



(************************ Foods Procedures ***************************)


{ Load Fish Number from Database }

function GetGroupNameInDB(GroupCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Grp_Name FROM Groups');
    SQL.Add('WHERE Grp_Code = ' + IntToStr(GroupCode));
    Open;
    if RecordCount > 0 then
      GetGroupNameInDB := FieldByName('Grp_Name').AsString
    else
      GetGroupNameInDB := '';
    Close;
  end;
end;





{ Return vadeh of personel in AddWork }
function GetAddWork(PCode : String) : Byte;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT OG_Vadeh FROM OutGroup WHERE OG_PCode = ''' + PCode + '''');
    {$IFDEF Network}
    SQL.Add('AND OG_Date = N''' + CurrentDate + '''');
    {$else}
    SQL.Add('AND OG_Date = ''' + CurrentDate + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      GetAddWork := FieldByName('OG_Vadeh').AsInteger
    else
      GetAddWork := 0;
    Close;
  end;
end;


procedure CreateClockDBS(TD : String);
begin
  g_options.ClockDBS := 'C' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(g_options.ClockDBS) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + g_options.ClockDBS + '(');
      SQL.Add('Clock_BarCode VarChar(8) ,');
      SQL.Add('Clock_BDate VarChar(10) ,');
      SQL.Add('Clock_BTime SmallInt ,');
      SQL.Add('Clock_BRdrCode SmallInt ,');
      SQL.Add('Clock_BRecState SmallInt ,');
      SQL.Add('Clock_Date VarChar(10) ,');
      SQL.Add('Clock_Time SmallInt ,');
      SQL.Add('Clock_RdrCode SmallInt ,');
      SQL.Add('Clock_Chg SmallInt ,');
      SQL.Add('Clock_RecState SmallInt ,');
      SQL.Add('Clock_User VarChar(15))');
      ExecSQL;
    end;
  end;
end;

procedure CreateTempClockDBS(TD : String);
begin
  g_options.ClockDBS := 'TC' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(g_options.ClockDBS) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + g_options.ClockDBS + '(');
      SQL.Add('Clock_BarCode VarChar(8) ,');
      SQL.Add('Clock_Date VarChar(10) ,');
      SQL.Add('Clock_SendDate VarChar(10) ,');
      SQL.Add('Clock_AgreeDate VarChar(10) ,');
      SQL.Add('Clock_Time SmallInt ,');
      SQL.Add('Clock_eTime SmallInt ,');
      SQL.Add('Clock_RdrCode SmallInt ,');
      SQL.Add('Clock_Chg SmallInt ,');
      SQL.Add('Clock_RecState SmallInt ,');
      SQL.Add('Clock_User VarChar(15),');
      SQL.Add('Clock_RecDes text,');
      SQL.Add('Clock_FirstlyAgree SmallInt,');
      SQL.Add('Clock_FirstlyAgree_BarCode varchar(15),');
      SQL.Add('Clock_FinallyAgree SmallInt)');
      ExecSQL;
    end;
  end;
end;

procedure CreateTempAddWorkDBS(TD : String);
begin
  g_options.ClockDBS := 'TE' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(g_options.ClockDBS) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + g_options.ClockDBS + '(');
      SQL.Add('E_PCode NVarChar(8) ,');
      SQL.Add('E_D01 Smallint      ,');
      SQL.Add('E_D02 Smallint      ,');
      SQL.Add('E_D03 Smallint      ,');
      SQL.Add('E_D04 Smallint      ,');
      SQL.Add('E_D05 Smallint      ,');
      SQL.Add('E_D06 Smallint      ,');
      SQL.Add('E_D07 Smallint      ,');
      SQL.Add('E_D08 Smallint      ,');
      SQL.Add('E_D09 Smallint      ,');
      SQL.Add('E_D10 Smallint      ,');
      SQL.Add('E_D11 Smallint      ,');
      SQL.Add('E_D12 Smallint      ,');
      SQL.Add('E_D13 Smallint      ,');
      SQL.Add('E_D14 Smallint      ,');
      SQL.Add('E_D15 Smallint      ,');
      SQL.Add('E_D16 Smallint      ,');
      SQL.Add('E_D17 Smallint      ,');
      SQL.Add('E_D18 Smallint      ,');
      SQL.Add('E_D19 Smallint      ,');
      SQL.Add('E_D20 Smallint      ,');
      SQL.Add('E_D21 Smallint      ,');
      SQL.Add('E_D22 Smallint      ,');
      SQL.Add('E_D23 Smallint      ,');
      SQL.Add('E_D24 Smallint      ,');
      SQL.Add('E_D25 Smallint      ,');
      SQL.Add('E_D26 Smallint      ,');
      SQL.Add('E_D27 Smallint      ,');
      SQL.Add('E_D28 Smallint      ,');
      SQL.Add('E_D29 Smallint      ,');
      SQL.Add('E_D30 Smallint      ,');
      SQL.Add('E_D31 Smallint      ,');
      SQL.Add('EmailCount Smallint,');
      SQL.Add('FirstlyAgree NVarChar(31) ,');
      SQL.Add('FinallyAgree NVARChar(31) )');
      ExecSQL;
    end;
  end;
end;

procedure CreateTempDBS(TD : String);
begin
  g_options.ClockDBS := 'T' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(g_options.ClockDBS) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + g_options.ClockDBS + '(');
      SQL.Add('Clock_BarCode VarChar(8) ,');
      SQL.Add('Clock_Date VarChar(10) ,');
      SQL.Add('Clock_Time SmallInt ,');
      SQL.Add('Clock_eTime SmallInt ,');
      SQL.Add('Clock_RecState SmallInt )');
      ExecSQL;
    end;
  end;
end;

procedure CreateClkDBSFName(fName : String);
begin
  if not tblExists(fName) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + fName + '(');
      SQL.Add('Clock_BarCode VarChar(8) ,');
      SQL.Add('Clock_BDate VarChar(10) ,');
      SQL.Add('Clock_BTime SmallInt ,');
      SQL.Add('Clock_BRdrCode SmallInt ,');
      SQL.Add('Clock_BRecState SmallInt ,');
      SQL.Add('Clock_Date VarChar(10) ,');
      SQL.Add('Clock_Time SmallInt ,');
      SQL.Add('Clock_RdrCode SmallInt ,');
      SQL.Add('Clock_Chg SmallInt ,');
      SQL.Add('Clock_RecState SmallInt ,');
      SQL.Add('Clock_User VarChar(15) )');

      ExecSQL;
    end;
  end
  else
    EmptyTbl('IORdr');
end;

procedure OpenClockDBS(TD : String);
var s : String;
begin
  s := 'C' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if frmDBS.adoTblClkDBS.Active then
  begin
    if frmDBS.adoTblClkDBS.TableName <> s then
    begin
      frmDBS.adoTblClkDBS.Close;
      CreateClockDBS(TD);
      frmDBS.adoTblClkDBS.TableName := g_options.ClockDBS;
      frmDBS.adoTblClkDBS.Open;
    end;
  end
  else
  begin
    CreateClockDBS(TD);
    frmDBS.adoTblClkDBS.TableName := g_options.ClockDBS;
    frmDBS.adoTblClkDBS.Open;
  end;
end;

procedure OpenTempClockDBS(TD : String);
var
  s : String;
begin
  s := 'TC' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(s) then
    CreateTempClockDBS(TD);
end;

procedure OpenTempAddWorkDBS(TD : String);
var
  s : String;
begin
  s := 'TE' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(s) then
    CreateTempAddWorkDBS(TD);
end;

procedure OpenTempDBS(TD : String);
var
  s : String;
begin
  s := 'T' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(s) then
  begin
    if frmDBS.adoTblClkDBS.TableName <> s then
    begin
      frmDBS.adoTblClkDBS.Close;
      CreateTempDBS(TD);
      frmDBS.adoTblClkDBS.TableName := s;
      frmDBS.adoTblClkDBS.Open;
    end;
  end
  else
  begin
    frmDBS.adoTblClkDBS.Close;
    frmDBS.adoTblClkDBS.TableName := s;
    frmDBS.adoTblClkDBS.Open;
  end;
end;

procedure CloseClockDBS;
begin
  if frmDBS.adoTblClkDBS.Active then frmDBS.adoTblClkDBS.Close;
end;

function SaveClockRecord(ClkRec : TTerminalRec; RecTest : Byte; ErrData : Boolean) : Boolean;
var f : TextFile;
begin
  SaveClockRecord := True;
  if not ErrData then
  begin
    OpenClockDBS(ClkRec.rdrDate);
    with frmDBS.adoTblClkDBS do
    begin
      ClkRec.rdrCardCode := FixLeft(ClkRec.rdrCardCode, '0', 8);
      if RecTest = REC_ADD then
      begin
        Append;
        FieldByName('Clock_BDate').AsString := ClkRec.rdrDate;
        FieldByName('Clock_BTime').AsInteger := ClkRec.rdrTime;
        FieldByName('Clock_BRdrCode').AsInteger := ClkRec.rdrCode;
        FieldByName('Clock_BRecState').AsInteger := ClkRec.rdrStatus;
        FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
        {$IFDEF webClock}
        FieldByName('Clock_User').Asstring := UserSession.MemberCode;
        {$ELSE}
        FieldByName('Clock_User').Asstring := G_Options.username
        {$ENDIF}
      end
      else if RecTest = REC_TEST then
      begin
        Filtered := False;
        Filter := 'Clock_BarCode = ''' + ClkRec.rdrCardCode +
                  ''' AND Clock_RdrCode = ' + IntToStr(ClkRec.rdrCode)+
                  '   AND Clock_Date = ''' + ClkRec.rdrDate +
                  ''' AND Clock_Time = ' + IntToStr(ClkRec.rdrTime);

        Filtered := True;
        if RecordCount > 0 then
        begin
          SaveClockRecord := False;
          Exit;
        end
        else
        begin
          Append;
          FieldByName('Clock_BDate').AsString := ClkRec.rdrDate;
          FieldByName('Clock_BTime').AsInteger := ClkRec.rdrTime;
          FieldByName('Clock_BRdrCode').AsInteger := ClkRec.rdrCode;
          FieldByName('Clock_BRecState').AsInteger := ClkRec.rdrStatus;
          FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
          {$IFDEF webClock}
          FieldByName('Clock_User').Asstring := UserSession.MemberCode;
          {$ELSE}
          FieldByName('Clock_User').Asstring := G_Options.username;
          {$ENDIF}
        end;
      end
      else if RecTest = REC_EDIT then
      begin
        Filtered := False;
        Filter := 'Clock_BarCode = ''' + ClkRec.rdrCardCode +
                  ''' AND Clock_BDate = ''' + ClkRec.rdrBDate +
                  ''' AND Clock_BTime = ' + IntToStr(ClkRec.rdrBTime);
        Filtered := True;
        if RecordCount > 0 then
          Edit
        else
        begin
          Append;
          FieldByName('Clock_BDate').AsString := ClkRec.rdrDate;
          FieldByName('Clock_BTime').AsInteger := ClkRec.rdrTime;
          FieldByName('Clock_BRdrCode').AsInteger := ClkRec.rdrCode;
          FieldByName('Clock_BRecState').AsInteger := ClkRec.rdrStatus;
          FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
          {$IFDEF webClock}
          FieldByName('Clock_User').Asstring := UserSession.MemberCode;
          {$ELSE}
          FieldByName('Clock_User').Asstring := G_Options.username;
          {$ENDIF}

        end;
      end;

      FieldByName('Clock_BarCode').AsString := ClkRec.rdrCardCode;
      FieldByName('Clock_Date').AsString := ClkRec.rdrDate;
      FieldByName('Clock_Time').AsInteger := ClkRec.rdrTime;
      FieldByName('Clock_RdrCode').AsInteger := ClkRec.rdrCode;
      FieldByName('Clock_RecState').AsInteger := ClkRec.rdrStatus;
      FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
      {$IFDEF webClock}
      FieldByName('Clock_User').Asstring := UserSession.MemberCode;
      {$ELSE}
      FieldByName('Clock_User').Asstring := G_Options.username;
      {$ENDIF}

      Post;
      Filtered := False;
      Filter := '';
    end;
  end
  else
  begin
    AssignFile(f, g_options.ProgramPath + 'ErrRec.Txt');
    if FileExists(g_options.ProgramPath + 'ErrRec.Txt') then
      Append(f)
    else
      ReWrite(f);

    WriteLn(f, ClkRec.rdrCardCode, ' ',
               ClkRec.rdrDate, ' ',
               ClkRec.rdrTime, ' ',
               ClkRec.rdrCode, ' ',
               ClkRec.rdrStatus);
    CloseFile(f);
  end;
end;


function SaveTempClockRecord(ClkRec : TTerminalRec; RecTest : Byte; ErrData : Boolean) : Boolean;
var f : TextFile;
begin
  result := True;
  if not ErrData then
  begin
    with frmDBS.adoTblClkDBS do
    begin
      OpenTempClockDBS(ClkRec.rdrDate);
      Close();
      TableName := 'TC' + Copy(ClkRec.rdrDate, 1, 4) + Copy(ClkRec.rdrDate, 6, 2);
      Open();
      ClkRec.rdrCardCode := FixLeft(ClkRec.rdrCardCode, '0', 8);
      if RecTest = REC_ADD then
      begin
        Append;
        FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
        FieldByName('Clock_User').Asstring := ClkRec.rdruser;
      end
      else if RecTest = REC_TEST then
      begin
        Filtered := False;
        Filter := 'Clock_BarCode = ''' + ClkRec.rdrCardCode + '''' +
                  ' AND Clock_Date = ''' + ClkRec.rdrDate + '''';
//        if not IsPishCardDaily(ClkRec.rdrStatus) then
          Filter := Filter + ' AND Clock_Time = ' + IntToStr(ClkRec.rdrTime);
        Filtered := True;
        if RecordCount > 0 then
        begin
          result := False;
          Exit;
        end
        else
        begin
          Append;
          FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
          FieldByName('Clock_User').Asstring := ClkRec.rdruser;
        end;
      end
      else if RecTest = REC_EDIT then
      begin
        Filtered := False;
        Filter := 'Clock_BarCode = ''' + ClkRec.rdrCardCode  +
                  ''' AND Clock_Date = ''' + ClkRec.rdrDate + '''';
        if not IsPishCardDaily(ClkRec.rdrStatus) then
          Filter := Filter + ' AND Clock_Time = ' + IntToStr(ClkRec.rdrTime);
        Filtered := True;
        if RecordCount > 0 then
          Edit                              
        else
        begin
          Append;
          FieldByName('Clock_Chg').AsInteger := ClkRec.rdrChng;
          FieldByName('Clock_User').Asstring := ClkRec.rdruser;
        end;
      end;
      FieldByName('Clock_BarCode').AsString := ClkRec.rdrCardCode;
      FieldByName('Clock_Date').AsString := ClkRec.rdrDate;
      FieldByName('Clock_SendDate').AsString := ClkRec.rdrSendDate;
      FieldByName('Clock_AgreeDate').AsString := ClkRec.rdrAgreeDate;
      FieldByName('Clock_Time').AsInteger := ClkRec.rdrTime;
      FieldByName('Clock_eTime').AsInteger := ClkRec.rdreTime;
      FieldByName('Clock_RdrCode').AsInteger := ClkRec.rdrCode;
      FieldByName('Clock_RecState').AsInteger := ClkRec.rdrStatus;
      FieldByName('Clock_RecDes').AsVariant := ClkRec.rdrdescription;
      FieldByName('Clock_FirstlyAgree_BarCode').AsString := ClkRec.rdrAgreeCode;
      FieldByName('Clock_FirstlyAgree').AsInteger := ClkRec.rdrFirstAgree;
      FieldByName('Clock_FinallyAgree').AsInteger := ClkRec.rdrFinalAgree;
      Post;
      Filtered := False;
      Filter := '';
    end;
  end
  else
  begin
    AssignFile(f, g_options.ProgramPath + 'ErrRec.Txt');
    if FileExists(g_options.ProgramPath + 'ErrRec.Txt') then
      Append(f)
    else
      ReWrite(f);

    WriteLn(f, ClkRec.rdrCardCode, ' ',
               ClkRec.rdrDate, ' ',
               ClkRec.rdrTime, ' ',
               ClkRec.rdrCode, ' ',
               ClkRec.rdrStatus);
    CloseFile(f);

  end;
end;





{ bargeh routines }

function FindBargehNo(dt, tm, pCode, ioType : String;var bargeNo,Type1,type2 : integer): Integer;
var
   txttime1 : string;
   tbl : string;
   txtpishcard1 : string;
begin
  FindBargehNo := 0;
  tbl := 'N'+Copy(dt, 1, 4) + Copy(dt, 6, 2);
  if not tblExists(tbl) then
    Exit;
  txttime1 := IntToStr(TimeToInt(tm));
  if Pos('-', ioType) > 1 then
    txtpishcard1 := Copy(ioType, 1, Pos('-', ioType)-1)
  else
    txtpishcard1 := ioType;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + tbl);
    {$IFDEF Network}
    SQL.Add('WHERE N_Date = N''' + dt + '''');
    SQL.Add('AND N_Time = ' + txttime1);
    SQL.Add('AND N_PCode = N''' + pCode + '''');
    {$else}
    SQL.Add('WHERE N_Date = ''' + dt + '''');
    SQL.Add('AND N_Time = ' + txttime1);
    SQL.Add('AND N_PCode = ''' + pCode + '''');
    {$ENDIF}
    SQL.Add('AND N_IOType = ' + txtpishcard1);
    Open;
    if FindField('N_Type1')=nil
    then begin
        close;
        UpgradeTable(tbl);
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + tbl);
        {$IFDEF Network}
        SQL.Add('WHERE N_Date = N''' + dt + '''');
        SQL.Add('AND N_Time = ' + txttime1);
        SQL.Add('AND N_PCode = N''' + pCode + '''');
        {$else}
        SQL.Add('WHERE N_Date = ''' + dt + '''');
        SQL.Add('AND N_Time = ' + txttime1);
        SQL.Add('AND N_PCode = ''' + pCode + '''');
        {$ENDIF}
        SQL.Add('AND N_IOType = ' + txtpishcard1);
        Open;
    end;
    if not Eof then
    begin
      bargeNo := fieldbyname('N_BargehNo').AsInteger;
      Type1   := fieldbyname('N_Type1').AsInteger;
      Type2   := fieldbyname('N_Type2').AsInteger;
    end;
    Close;
  end;
end;

procedure FindBargehNos(dt, pCode : String; var brgs ,typ1, typ2 : string);
var
   tbl : string;
   st:string;
begin
  brgs := '';
  tbl := 'N'+Copy(dt, 1, 4) + Copy(dt, 6, 2);
  if not tblExists(tbl) then
    Exit;
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.sql.Add('SELECT * FROM ' + tbl);
 {$IFDEF Network}
  frmDBS.adoQryG.SQL.Add('WHERE N_Date = N''' + dt + '''');
  frmDBS.adoQryG.SQL.Add('AND N_PCode = N''' + pCode + '''');
 {$else}
  frmDBS.adoQryG.SQL.Add('WHERE N_Date = ''' + dt + '''');
  frmDBS.adoQryG.SQL.Add('AND N_PCode = ''' + pCode + '''');
 {$ENDIF}
  frmDBS.adoQryG.Open;
  st:='';
  typ1 := frmDBS.adoQryG.fieldbyname('N_type1').AsString;
  typ2 := frmDBS.adoQryG.fieldbyname('N_type2').AsString;
  while not frmDBS.adoQryG.Eof do
  begin
    if st<> '' then
      st:=st+',';
    st := st + inttostr(frmDBS.adoQryG.fieldbyname('N_BargehNo').AsInteger);
    frmDBS.adoQryG.next;
  end;
  brgs :=st;
  frmDBS.adoQryG.Close;
end;

procedure CreateBargehDBS(TD : String);
var
   tblname : string;
begin
  tblname := 'N' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if not tblExists(tblName) then
  begin
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + tblName + '(');
      SQL.Add('N_PCode VarChar(8) ,');
      SQL.Add('N_Date VarChar(10) ,');
      SQL.Add('N_Time Integer ,');
      SQL.Add('N_IOType SmallInt ,');
      SQL.Add('N_BargehNo SmallInt)');
      ExecSQL;
    end;
  end;
end;

procedure OpenBargehDBS(TD : String);
var s : String;
begin
  s := 'N' + Copy(TD, 1, 4) + Copy(TD, 6, 2);
  if frmDBS.adoTblBargehDBS.Active then
  begin
    if frmDBS.adoTblBargehDBS.TableName <> s then
    begin
      frmDBS.adoTblBargehDBS.Close;
      CreateBargehDBS(TD);
      frmDBS.adoTblBargehDBS.TableName := s;
      frmDBS.adoTblBargehDBS.Open;
    end;
  end
  else
  begin
    CreateBargehDBS(TD);
    frmDBS.adoTblBargehDBS.TableName := s;
    frmDBS.adoTblBargehDBS.Open;
  end;
end;

procedure CloseBargehDBS;
begin
  if frmDBS.adoTblBargehDBS.Active then frmDBS.adoTblBargehDBS.Close;
end;

function SaveBargehRecord(ClkRec : TTerminalRec; BrgNo : Integer; type1 , type2 : integer ; RecTest : Byte; ErrData : Boolean) : Boolean;
var f : TextFile;
begin
  SaveBargehRecord := True;
  if not ErrData then
  begin
    OpenBargehDBS(ClkRec.rdrDate);
    with frmDBS.adoTblBargehDBS do
    begin
      ClkRec.rdrCardCode := FixLeft(ClkRec.rdrCardCode, '0', 8);
      if RecTest = REC_ADD then
      begin
        Append;
      end
      else if RecTest = REC_TEST then
      begin
        Filtered := False;
        Filter := 'N_PCode = ''' + ClkRec.rdrCardCode   +
                  ''' AND N_Date = ''' + ClkRec.rdrDate + '''';
        Filter := 'N_PCode = ''' + ClkRec.rdrCardCode   +
                  ''' AND N_Date = ''' + ClkRec.rdrDate + '''';
       if not IsPishCardDaily(ClkRec.rdrStatus) then
          Filter := Filter + ' AND N_Time = ' + IntToStr(ClkRec.rdrTime);
        Filtered := True;
        if RecordCount > 0 then
        begin
          SaveBargehRecord := False;
          Exit;
        end
        else
        begin
          Append;
        end;
      end
      else if RecTest = REC_EDIT then
      begin
//        Filtered := False;
        Filter := 'N_PCode = ''' + ClkRec.rdrCardCode    +
                  ''' AND N_Date = ''' + ClkRec.rdrBDate + '''';
        if not IsPishCardDaily(ClkRec.rdrStatus) then
          Filter := Filter + ' AND N_Time = ' + IntToStr(ClkRec.rdrTime);
        Filtered := True;
        if RecordCount > 0 then
          Edit
        else
        begin
          Append;
        end;
      end;

      FieldByName('N_PCode').AsString := ClkRec.rdrCardCode;
      FieldByName('N_Date').AsString := ClkRec.rdrDate;
      FieldByName('N_Time').AsInteger := ClkRec.rdrTime;
      FieldByName('N_IOType').AsInteger := ClkRec.rdrStatus;
      FieldByName('N_BargehNo').AsInteger := BrgNo;
      FieldByName('N_Type1').AsInteger := type1;
      FieldByName('N_Type2').AsInteger := type2;

      Post;
      Filtered := False;
      Filter := '';
    end;
  end
  else
  begin
    AssignFile(f, g_options.ProgramPath + 'ErrRec.Txt');
    if FileExists(g_options.ProgramPath + 'ErrRec.Txt') then
      Append(f)
    else
      ReWrite(f);

    WriteLn(f, ClkRec.rdrCardCode, ' ',
               ClkRec.rdrDate, ' ',
               ClkRec.rdrTime, ' ',
               ClkRec.rdrCode, ' ',
               ClkRec.rdrStatus);
    CloseFile(f);

  end;
end;

function incfilename(filename:string):string;
var
   y,m,i:integer;
   yst,mst,st:string[6];
   fchar:char;
begin
   fchar:=filename[1];
   y:=strtoint(copy(filename,2,4));
   m:=strtoint(copy(filename,6,2));
   inc(m);
   if m>12
   then begin
      m:=1;
      inc(y);
   end;
   str(y:4,yst);
   str(m:2,mst);
   st:=yst+mst;
   for i:=1 to 6 do if st[i]=' ' then st[i]:='0';
   incfilename := fchar + st;
end;

procedure CreateInOutTbl(SDate, EDate : String);
var
  qry : TADOQuery;
  FileName1, FileName2 : String;
begin
  CreateClkDBSFName('IORdr');
  qry := TADOQuery.Create(Application);
  qry.Connection := frmDBS.DBConnection;

  FileName1 := UpperCase('C' + Copy(SDate, 1, 4) + Copy(SDate, 6, 2));
  FileName2 := UpperCase('C' + copy(EDate,1 , 4) + Copy(EDate, 6, 2));
  with qry do
  begin
    while FileName1 <= FileName2 do
    begin
      if tblExists(FileName1) then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO IORdr SELECT * FROM ' + FileName1);
        SQL.Add('WHERE Clock_Date >= N''' + SDate + '''');
        SQL.Add('AND Clock_Date <= N''' + EDate + '''');
        ExecSQL;
      end;
      FileName1 := UpperCase(IncFileName(FileName1));
    end;
    Free;
  end;
end;
function equalstr(a,b:string):boolean;
begin
  result:=false;
  if a='-1' then a:='0';
  if b='-1' then b:='0';
  if a='0' then a:='';
  if b='0' then b:='';
  if a=b then result:=true;
end;

procedure ConvertParts;
var
  i,j, TempIndex, iEnd : Integer;
  strID : String;
  TempTbl : array[1..1000] of recPart;
  equal: boolean;

begin
  i := 1;
  strID := '01';
  try
    frmDBS.adoTblPart.TableName := 'Part1';
    frmDBS.adoTblPart.Connection := frmDBS.DBConnection;
    frmDBS.adotblPart.Open;
  except
    exit;
  end;
  frmDBS.adotblPart.First;
  while (not frmDBS.adotblPart.Eof) and (i<=1000) do
    begin
    with TempTbl[i] do
      begin
      Code := strID;
      ChildCount := 0;
      Father := '-1';
      Name := frmDBS.adotblPart.fieldbyname('P1_Name').AsString;
      P1Code := frmDBS.adotblPart.fieldbyname('P1_Code').AsString;
      P2Code := '-1';
      P3Code := '-1';

      strID := IntToStr(StrToInt(strID)+1);
      strID := FixLeft(strID, '0', 2);
      if frmDBS.adotblPart.Eof then
        RSibling := '-1'
      else
        RSibling := strID;
      end;

    Inc(i);
    frmDBS.adotblPart.Next;
    end;
  // part1 finished

  frmDBS.adotblPart.Close;
  frmDBS.adotblPart.TableName := 'Part2';
  frmDBS.adotblPart.Connection := frmDBS.DBConnection;
  frmDBS.adotblPart.Open;

  frmDBS.adotblPart.First;
  while (not frmDBS.adotblPart.Eof) and (i<=1000) do
  with TempTbl[i] do
  begin
      TempIndex := FindIndexOfPartinArray(TempTbl, 6, frmDBS.adotblPart.fieldbyname('P2_P1Code').AsString, '-1', '-1');
      if TempIndex>=0
      then begin
        Inc(TempIndex);
        Father := TempTbl[TempIndex].Code;
        strID := IntToStr(TempTbl[TempIndex].ChildCount+1);
        strID := FixLeft(strID, '0', 2);
        strId := Father + strID;
        Code := strID;
        Inc(TempTbl[TempIndex].ChildCount);
        if TempTbl[TempIndex].LChild = '' then
          TempTbl[TempIndex].LChild := Code;
        Name := frmDBS.adotblPart.fieldbyname('P2_Name').AsString;
        P1Code := frmDBS.adotblPart.fieldbyname('P2_P1Code').AsString;
        P2Code := frmDBS.adotblPart.fieldbyname('P2_Code').AsString;
        P3Code := '-1';

        RSibling := '-1';
        if (not frmDBS.adotblPart.Eof) then
        begin
          frmDBS.adotblPart.Next;
          strID := IntToStr(StrToInt(strID)+1);
          strID := FixLeft(strID, '0', 4);
          if frmDBS.adotblPart.fieldbyname('P2_P1Code').AsString=P1Code then
            RSibling := strID;
        end
        else i:=1000;
        Inc(i);
      end
      else begin
        if (not frmDBS.adotblPart.Eof)
        then frmDBS.adotblPart.Next
        else i:=1000;
      end;
  end;
  // part2 finished

  frmDBS.adotblPart.Close;
  frmDBS.adotblPart.TableName := 'Part3';
  frmDBS.adotblPart.Connection := frmDBS.DBConnection;
  frmDBS.adotblPart.Open;

  frmDBS.adotblPart.First;
  while (not frmDBS.adotblPart.Eof) and (i<=1000) do
  with TempTbl[i] do
  begin
      TempIndex := FindIndexOfPartinArray(TempTbl, 7, frmDBS.adotblPart.fieldbyname('P3_P1Code').AsString,
                                   frmDBS.adotblPart.fieldbyname('P3_P2Code').AsString, '-1');
      if TempIndex>=0
      then
      begin
        Inc(TempIndex);
        Father := TempTbl[TempIndex].Code;
        strID := IntToStr(TempTbl[TempIndex].ChildCount+1);
        strID := FixLeft(strID, '0', 2);
        strId := Father + strID;
        Code := strID;
        Inc(TempTbl[TempIndex].ChildCount);
        if TempTbl[TempIndex].LChild = '' then
          TempTbl[TempIndex].LChild := Code;
        Name := frmDBS.adotblPart.fieldbyname('P3_Name').AsString;
        P1Code := frmDBS.adotblPart.fieldbyname('P3_P1Code').AsString;
        P2Code := frmDBS.adotblPart.fieldbyname('P3_P2Code').AsString;
        P3Code := frmDBS.adotblPart.fieldbyname('P3_Code').AsString;

        RSibling := '-1';
        if (not frmDBS.adotblPart.Eof) then
        begin
          strID := IntToStr(StrToInt(strID)+1);
          strID := FixLeft(strID, '0', 6);
          frmDBS.adotblPart.Next;
          if (frmDBS.adotblPart.fieldbyname('P3_P1Code').AsString=P1Code) and
             (frmDBS.adotblPart.fieldbyname('P3_P2Code').AsString=P2Code) then
            RSibling := strID;
        end
        else i:=1000;
        Inc(i);
      end
      else begin
        if (not frmDBS.adotblPart.Eof)
        then frmDBS.adotblPart.Next
        else i:=1000;
      end;
  end;
  // part3 finished

  frmDBS.adotblPart.Close;
  frmDBS.adotblPart.TableName := 'Part4';
  frmDBS.adotblPart.Connection := frmDBS.DBConnection;
  frmDBS.adotblPart.Open;

  frmDBS.adotblPart.First;
  while (not frmDBS.adotblPart.Eof) and (i<=1000) do
  with TempTbl[i] do
  begin
//      Str(strID, Code);
      TempIndex := FindIndexOfPartinArray(TempTbl, 8, frmDBS.adotblPart.fieldbyname('P4_P1Code').AsString,
                                   frmDBS.adotblPart.fieldbyname('P4_P2Code').AsString,
                                   frmDBS.adotblPart.fieldbyname('P4_P3Code').AsString);
      if TempIndex>=0
      then
      begin
        Inc(TempIndex);
        Father := TempTbl[TempIndex].Code;
        strID := IntToStr(TempTbl[TempIndex].ChildCount+1);
        strID := FixLeft(strID, '0', 2);
        strId := Father + strID;
        Code := strID;
        Inc(TempTbl[TempIndex].ChildCount);
        if TempTbl[TempIndex].LChild = '' then
          TempTbl[TempIndex].LChild := Code;
        Name := frmDBS.adotblPart.fieldbyname('P4_Name').AsString;
        P1Code := frmDBS.adotblPart.fieldbyname('P4_P1Code').AsString;
        P2Code := frmDBS.adotblPart.fieldbyname('P4_P2Code').AsString;
        P3Code := frmDBS.adotblPart.fieldbyname('P4_P3Code').AsString;
        P4Code := frmDBS.adotblPart.fieldbyname('P4_Code').AsString;

        RSibling := '-1';
        if (not frmDBS.adotblPart.Eof) then
        begin
          frmDBS.adotblPart.Next;
          strID := IntToStr(StrToInt(strID)+1);
          strID := FixLeft(strID, '0', 8);
          if (frmDBS.adotblPart.fieldbyname('P4_P1Code').AsString=P1Code) and
             (frmDBS.adotblPart.fieldbyname('P4_P2Code').AsString=P2Code) and
             (frmDBS.adotblPart.fieldbyname('P4_P3Code').AsString=P3Code) then
            RSibling := strID;
        end
        else i:=1000;
        Inc(i);
      end
      else begin
        if (not frmDBS.adotblPart.Eof)
        then frmDBS.adotblPart.Next
        else i:=1000;
      end;
  end;
  // part4 finished
  iEnd := i-1;

  frmDBS.adotblPart.Close;
  frmDBS.adotblPart.TableName := 'Parts';
  frmDBS.adotblPart.Connection := frmDBS.DBConnection;
  frmDBS.adotblPart.Open;

  frmDBS.adotblPart.First;
  while not frmDBS.adotblPart.Eof do
    frmDBS.adotblPart.Delete;

  for i:=1 to iEnd do
  begin
    j:=i;
    if TempTbl[i].LChild = '' then
      TempTbl[i].LChild := '-1';
    frmDBS.adotblPart.InsertRecord([TempTbl[i].Code, TempTbl[i].Code, TempTbl[i].Name, TempTbl[i].LChild, TempTbl[i].RSibling, TempTbl[i].Father]);
    {
    if TempTbl[i].p1code = '-1' then TempTbl[i].p1code := '';
    if TempTbl[i].p2code = '-1' then TempTbl[i].p2code := '';
    if TempTbl[i].p3code = '-1' then TempTbl[i].p3code := '';
    if TempTbl[i].p4code = '-1' then TempTbl[i].p4code := '';
    if TempTbl[i].p1code = '' then TempTbl[i].p2code := '';
    if TempTbl[i].p2code = '' then TempTbl[i].p3code := '';
    if TempTbl[i].p3code = '' then TempTbl[i].p4code := '';
    }
  end;

  if iEnd>0 then
  with frmDBS.adotblpersons do
  begin
     close;
     open;
     while not eof do
     begin
        i:=0;
        repeat
           inc(i);
           equal:=false;
           {
           if TempTbl[i].p1code=fieldbyname('P_Part1').asstring
           then if TempTbl[i].p2code=fieldbyname('P_Part2').asstring
           then if TempTbl[i].p3code=fieldbyname('P_Part3').asstring
           then if TempTbl[i].p4code=fieldbyname('P_Part4').asstring
           then equal:=true;
           }
           if equalstr(TempTbl[i].p1code,fieldbyname('P_Part1').asstring)
           then if equalstr(TempTbl[i].p2code,fieldbyname('P_Part2').asstring)
           then if equalstr(TempTbl[i].p3code,fieldbyname('P_Part3').asstring)
           then if equalstr(TempTbl[i].p4code,fieldbyname('P_Part4').asstring)
           then equal:=true;
           if equal
           Then begin
                edit;
                fieldbyname('P_Parts').asstring:=TempTbl[i].code;
                post;
           end;
        until equal or (i>=iEnd);
        next;
     end;
  end;

end;

function FindIndexOfPartinArray(TempTbl : array of recPart; WhichField : Integer; P1Code, P2Code, P3Code : String) : Integer;
var
  i : Integer;
begin
  result:=-1;
  case WhichField of
    6 :
      begin
      i:=0;
      while (i<1000) do
        begin
        if (TempTbl[i].P1Code = P1Code) then
          begin
          Result := i;
          i:=1000;
          end;
        Inc(i);
        end;
      end;
    7 :
      begin
      i:=0;
      while (i<1000) do
        begin
        if (TempTbl[i].P1Code = P1Code) and (TempTbl[i].P2Code = P2Code) then
          begin
          Result := i;
          i:=1000;
          end;
        Inc(i);
        end;
      end;
    8 :
      begin
      i:=0;
      while (i<1000) do
        begin
        if (TempTbl[i].P1Code = P1Code) and (TempTbl[i].P2Code = P2Code) and (TempTbl[i].P3Code = P3Code) then
          begin
          Result := i;
          i:=1000;
          end;
        Inc(i);
        end;
      end;
  end;
end;

function authorized:boolean;
var
    ctime,ftime,etime,lasttime:integer;
    ctimestr,ftimestr,etimestr: string;
    n: integer;
    mojaz: boolean;
    ismidnight:boolean;
    lastpcname : string;
    pcname   : string;
    psize    : dword;
    pcname1  : pansichar;
begin
    {result := true;
    exit;}
    ctime:=timetoint(copy(currenttime,1,5));
    pSize := MAX_COMPUTERNAME_LENGTH + 1;
    pcName1 := strAlloc( pSize );
    if getcomputername(pcname1,psize)
    then pcname:=pcname1
    else pcname:='';

    ismidnight:=false;
    ftime:=ctime-refreshpriod-2;
    etime:=ctime+2;
    if ftime<0
    then begin
         ftime:=ftime+1440;
         ismidnight:=true;
    end;
    if etime>=1440
    then begin
         etime:=etime-1440;
         ismidnight:=true;
    end;
    ctimestr:=inttostr(ctime);
    ftimestr:=inttostr(ftime);
    etimestr:=inttostr(etime);
    mojaz:=true;
    with frmDBS.adoqryg do
    begin
        close;
        with sql do
        begin
            clear;
            add('select count(*) as n from users');

            if ismidnight
            then begin
                add(' where (lastaccess >='+ftimestr);
                add(' or lastaccess <='+etimestr);
                add(') AND lastaccess >=0');
            end
            else begin
                add(' where lastaccess >='+ftimestr);
                add(' and lastaccess <='+etimestr);
            end;
        end;
        open;
        n:=fieldbyname('n').asinteger;
        close;
        if n>=maxusers
        then begin
             mojaz:=false;
             result:=false;
             errormessage('تعداد كاربران در اين زمان به حد مجاز رسيده است');
             exit;
        end;
        with sql do
        begin
            clear;
            add('select * from users where username='''+g_Options.UserName+'''');
        end;
        open;
        lasttime:=fieldbyname('lastaccess').asinteger;
        lastpcname:=fieldbyname('pcname').asstring;
        close;
        if (not ismidnight) and (lasttime>=ftime)and(lasttime<=etime)
        or ismidnight and ((lasttime>=ftime)or(lasttime<=etime)) AND (lasttime>=0)
        then if lastpcname<>pcname
        then begin
             mojaz:=false;
             result:=false;
             errormessage('كاربر ديگري با همين اسم در حال اجراي برنامه است');
             exit;
        end
        else begin

        end;
    end;

    result:=mojaz;
end;

function GetBoxName(BoxCode : integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT c_Name FROM Cashes');
    SQL.Add('WHERE c_Code = ' + IntToStr(BoxCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('C_Type').AsString + '-' + FieldByName('C_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ create a table in database }
function CreateTable(tblName : String; IsUpgrade : Boolean) : Boolean;
var
  strList : Tstrings;
  i : Integer;
begin
  strList := TStringList.Create;
  frmDBS.DBConnection.GetTableNames(strList, False);
  if strList.IndexOf(tblName) <> -1 then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('DROP TABLE ' + tblName);
      ExecSQL;
    end;
  end;
  strList.Free;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
{    case dbsInfo.dbsType of
      DBS_ACCESS    : SQL.Add('CREATE TABLE ' + tblName);
      DBS_SQLSERVER : SQL.Add('CREATE TABLE dbo.' + tblName);
    end; }
    SQL.Add('CREATE TABLE dbo.' + tblName);

    if tblName = 'Cashes' then
    begin
      SQL.Add('(');
      SQL.Add(' [c_code] [int] NULL ,');
      SQL.Add(' [c_name] [nvarchar] (50) NULL ,');
      SQL.Add(' [c_Place] [nvarchar] (8) NULL ,');
      SQL.Add(' [c_Type] [int] NULL');
      SQL.Add(' )');
    end
    
    else if tblName = 'Cities' then
    begin
      SQL.Add('(');
      SQL.Add('	[c_name] [nvarchar] (50) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'init' then
    begin
      SQL.Add('(');
      SQL.Add('	[Init_Title] [nvarchar] (30) NULL ,');
      SQL.Add('	[Init_Value] [nvarchar] (30) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'pishcard' then
    begin
      SQL.Add('(');
      SQL.Add('	[Pish_Code] [smallint] NULL ,');
      SQL.Add('	[Pish_LastName] [nvarchar] (30) NULL ,');
      SQL.Add('	[Pish_active] [bit] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Persons' then
    begin
      SQL.Add('(');
      SQL.Add('	[p_code] [nvarchar] (8) NOT NULL ,');
      SQL.Add('	[p_Proxi] [nvarchar] (8) NULL ,');
      SQL.Add('	[p_NAME] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_FAMILY] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_IDNO] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_Picture] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_FATHER] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_NATION] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_IsMarried] [int] NULL ,');
      SQL.Add('	[p_POST] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_BirthDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_BirthPlace] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_ADDRESS] [nvarchar] (200) NULL ,');
      SQL.Add('	[p_HomeTel] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_WorkTel] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_MOBILE] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_BoxNo] [int] NULL ,');
      SQL.Add('	[p_contractno] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_DEPOSITE] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_BIMEH] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_AccountNo] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_AccountType] [int] NULL ,');
      SQL.Add('	[p_AccountBranch] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_ContractDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_ContractEndDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_IsBlocked] [bit] NULL ,');
      SQL.Add('	[p_IsColleague] [bit] NULL ,');
      SQL.Add('	[p_BlockDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_BlockDesc] [nvarchar] (100) NULL ,');
      SQL.Add('	[p_SignPicture] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_IsProvisionalBlocked] [bit] NULL ,');
      SQL.Add('	[p_ProvisionalBlockDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_ProvisionalBlockDesc] [nvarchar] (100) NULL ,');
      SQL.Add('	[p_IsCommonBox] [bit] NULL ,');
      SQL.Add('	[p_NAME_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_FAMILY_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_IDNO_Sec] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_Picture_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_FATHER_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_NATION_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_IsMarried_Sec] [int] NULL ,');
      SQL.Add('	[p_POST_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_BirthDate_Sec] [nvarchar] (10) NULL ,');
      SQL.Add('	[p_BirthPlace_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_ADDRESS_Sec] [nvarchar] (200) NULL ,');
      SQL.Add('	[p_HomeTel_Sec] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_WorkTel_Sec] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_MOBILE_Sec] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_SignPicture_Sec] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_CommonBoxType] [smallint] NULL ,');
      SQL.Add('	[p_IsLegalCustomer] [bit] NULL ,');
      SQL.Add('	[p_CoName] [nvarchar] (50) NULL ');
      SQL.Add(' )');
    end

    else if tblName = 'nPersons' then
    begin
      SQL.Add('(');
      SQL.Add('	[np_code] [nvarchar] (8) NOT NULL ,');
      SQL.Add('	[np_Proxi] [nvarchar] (8) NULL ,');
      SQL.Add('	[np_NAME] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_FAMILY] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_IDNO] [nvarchar] (20) NULL ,');
      SQL.Add('	[nP_Picture] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_FATHER] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_NATION] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_IsMarried] [int] NULL ,');
      SQL.Add('	[np_POST] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_BirthDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[np_BirthPlace] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_ADDRESS] [nvarchar] (200) NULL ,');
      SQL.Add('	[np_HomeTel] [nvarchar] (20) NULL ,');
      SQL.Add('	[np_WorkTel] [nvarchar] (20) NULL ,');
      SQL.Add('	[np_MOBILE] [nvarchar] (20) NULL ,');
      SQL.Add('	[np_SignPicture] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_IsMemberCommonBoxType3] [bit] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Proxies' then
    begin
      SQL.Add('(');
      SQL.Add('	[P_CustomerCode] [nvarchar] (8) NOT NULL ,');
      SQL.Add('	[P_V1NAME] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V1FAMILY] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V1IDNO] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_V1FATHER] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V1BirthPlace] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V1ExpireDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[P_V1ProxyID] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_V2NAME] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V2FAMILY] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V2IDNO] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_V2FATHER] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V2BirthPlace] [nvarchar] (50) NULL ,');
      SQL.Add('	[P_V2ExpireDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[P_V2ProxyID] [nvarchar] (20) NULL ,');
      SQL.Add('	[p_V1Picture] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_V2Picture] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_V1SignPicture] [nvarchar] (50) NULL ,');
      SQL.Add('	[p_V2SignPicture] [nvarchar] (50) NULL');
      SQL.Add(' )');
    end
    
    else if tblName = 'nProxies' then
    begin
      SQL.Add('(');
      SQL.Add('	[nP_CustomerCode] [nvarchar] (8) NOT NULL ,');
      SQL.Add('	[nP_VNAME] [nvarchar] (50) NULL ,');
      SQL.Add('	[nP_VFAMILY] [nvarchar] (50) NULL ,');
      SQL.Add('	[nP_VIDNO] [nvarchar] (20) NULL ,');
      SQL.Add('	[nP_VFATHER] [nvarchar] (50) NULL ,');
      SQL.Add('	[nP_VBirthPlace] [nvarchar] (50) NULL ,');
      SQL.Add('	[nP_VExpireDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[nP_VProxyID] [nvarchar] (20) NULL ,');
//      SQL.Add('	[nP_V2NAME] [nvarchar] (50) NULL ,');
//      SQL.Add('	[nP_V2FAMILY] [nvarchar] (50) NULL ,');
//      SQL.Add('	[nP_V2IDNO] [nvarchar] (20) NULL ,');
//      SQL.Add('	[nP_V2FATHER] [nvarchar] (50) NULL ,');
//      SQL.Add('	[nP_V2BirthPlace] [int] NULL ,');
//      SQL.Add('	[nP_V2ExpireDate] [nvarchar] (8) NULL ,');
//      SQL.Add('	[nP_V2ProxyID] [nvarchar] (20) NULL ,');
      SQL.Add('	[np_VPicture] [nvarchar] (50) NULL ,');
//      SQL.Add('	[np_V2Picture] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_VSignPicture] [nvarchar] (50) NULL ,');
      SQL.Add('	[np_VProxi] [nvarchar] (8) NULL ');
//      SQL.Add('	[np_V2SignPicture] [nvarchar] (50) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'IORdr' then
    begin
      SQL.Add('(');
      SQL.Add('	[Clock_BarCode] [varchar] (8) NULL ,');
      SQL.Add('	[Clock_BDate] [varchar] (10) NULL ,');
      SQL.Add('	[Clock_BTime] [smallint] NULL ,');
      SQL.Add('	[Clock_BRdrCode] [smallint] NULL ,');
      SQL.Add('	[Clock_BRecState] [smallint] NULL ,');
      SQL.Add('	[Clock_Date] [varchar] (10) NULL ,');
      SQL.Add('	[Clock_Time] [smallint] NULL ,');
      SQL.Add('	[Clock_RdrCode] [smallint] NULL ,');
      SQL.Add('	[Clock_Chg] [smallint] NULL ,');
      SQL.Add('	[Clock_RecState] [smallint] NULL ,');
      SQL.Add('	[Clock_User] [varchar] (15) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'readers' then
    begin
      SQL.Add('(');
      SQL.Add('	[R_Code] [smallint] NOT NULL ,');
      SQL.Add('	[R_Name] [nvarchar] (20) NULL ,');
      SQL.Add('	[R_Active] [nvarchar] (1) NULL ,');
      SQL.Add('	[R_Port] [smallint] NULL ,');
      SQL.Add('	[R_BaudNo] [smallint] NULL ,');
      SQL.Add('	[R_Type] [smallint] NULL ,');
      SQL.Add('	[R_Modem] [bit] NULL ,');
      SQL.Add('	[R_IP] [nvarchar] (15) NULL ,');
      SQL.Add('	[R_TCP] [bit] NULL ,');
      SQL.Add('	[R_IsCOM] [bit] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'security' then
    begin
      SQL.Add('(');
      SQL.Add('	[Code] [smallint] NOT NULL ,');
      SQL.Add('	[Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[MenuBar] [smallint] NULL ,');
      SQL.Add('	[BaseMenu] [int] NULL ,');
      SQL.Add('	[ReportMenu] [int] NULL ,');
      SQL.Add('	[SetupMenu] [int] NULL ,');
      SQL.Add('	[RelationMenu] [int] NULL ,');
      SQL.Add('	[ToolsMenu] [int] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'users' then
    begin
      SQL.Add('(');
      SQL.Add('	[UserName] [nvarchar] (15) NOT NULL ,');
      SQL.Add('	[UserPassword] [nvarchar] (15) NULL ,');
      SQL.Add('	[SecurityCode] [smallint] NULL ,');
      SQL.Add('	[Parts] [nvarchar] (255) NULL ,');
      SQL.Add('	[Entery] [bit] NULL ,');
      SQL.Add('	[AccessPrint] [bit] NULL ,');
      SQL.Add('	[Station] [smallint] NULL ,');
      SQL.Add('	[LastAccess] [smallint] NULL ,');
      SQL.Add('	[PCName] [nvarchar] (50) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'History' then
    begin
      SQL.Add('(');
      SQL.Add('	[h_id] [int] IDENTITY (1, 1) NOT NULL ,');
      SQL.Add('	[h_Date] [nvarchar] (10) NULL ,');
      SQL.Add('	[h_Time] [smallint] NULL ,');
      SQL.Add('	[h_Code] [nvarchar] (8) NULL ,');
      SQL.Add('	[h_BoxNo] [int] NULL ,');
      SQL.Add('	[h_ContractNo] [nvarchar] (20) NULL ,');
      SQL.Add('	[h_ContractDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[h_ContractEndDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[h_IsBlocked] [bit] NULL ,');
      SQL.Add('	[h_BlockDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[h_BlockDesc] [nvarchar] (100) NULL ,');
      SQL.Add('	[h_IsProvisionalBlocked] [bit] NULL ,');
      SQL.Add('	[h_ProvisionalBlockDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[h_ProvisionalBlockDesc] [nvarchar] (100) NULL');
      SQL.Add(' )');
    end

    else
    begin
      Result := False;
      Exit;
    end;

    try
      ExecSQL;
      Result := True;
    except
      Result := False;
    end;

    SQL.Clear;
    if tblName = 'Persons' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('ALTER TABLE dbo.Persons WITH NOCHECK ADD');
        SQL.Add(' CONSTRAINT [PK_Persons] PRIMARY KEY  CLUSTERED');
        SQL.Add(' (');
        SQL.Add(' [p_code]');
        SQL.Add(' )');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'Proxies' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('ALTER TABLE [dbo].[Proxies] WITH NOCHECK ADD');
        SQL.Add(' CONSTRAINT [PK_Proxies] PRIMARY KEY  CLUSTERED');
        SQL.Add(' (');
        SQL.Add(' [P_CustomerCode]');
        SQL.Add(' )');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'users' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('ALTER TABLE [dbo].[users] WITH NOCHECK ADD');
        SQL.Add(' PRIMARY KEY  CLUSTERED');
        SQL.Add(' (');
        SQL.Add(' [UserName]');
        SQL.Add(' )');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'users' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO users (UserName, UserPassword, SecurityCode, Entery, AccessPrint)');
        SQL.Add('VALUES(''Admin'', '''', 1, 1, 1)');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'security' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO Security (Code, Name)');
        SQL.Add('VALUES(1, ''مدير سيستم'')');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

  end;
end;

{ Upgrade a table in database }
Procedure UpgradeTable(tblName : string);
var
  tblOld , tblNew : TAdoTable;
  qry : TAdoQuery;
  i : integer;
  fld : TField;
  fldhigh,idxhigh:byte;
  indexname : string;
  indexcount: byte;
  indexnames: array[1..10] of string;
  mustadd: boolean;
begin
  if not tblExists(tblName)
  then begin
       CreateTable(tblName, False);
       exit;
  end
  else begin
    tblOld := TAdoTable.Create(Application);
    tblNew := TAdoTable.Create(Application);
    qry := TAdoQuery.Create(Application);
    qry.Connection := frmDBS.DBConnection;

    if tblExists('Temp')
    then begin
         qry.SQL.clear;
         qry.SQL.Add('drop table temp');
         qry.ExecSQL;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('select distinct * into temp from '+tblname);
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('drop table '+tblname);
    qry.ExecSQL;

    CreateTable(tblName, True);

    with tblNew do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Active := True;
    end;

    with tblOld do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := 'temp';
      Active := True;
    end;

    tblOld.First;
    mustadd:=true;
    while not tblOld.Eof do
    begin
      if mustadd then tblNew.Append;
      mustadd:=true;
      for i := 0 to tblnew.FieldCount - 1 do
      begin
        fld := tblold.FindField(tblnew.Fields[i].FieldName);
        if  fld <> nil then
        begin
            if tblName = 'History' then
            begin
              if not (fld.FieldName = 'h_id') then
                tblNew.fields[i].Value := tblOld.FieldByName(tblnew.Fields[i].FieldName).Value;
            end
            else
            begin
                tblNew.fields[i].Value := tblOld.FieldByName(tblnew.Fields[i].FieldName).Value;
            end;
            if tblname='Users'
            then if fld.FieldName='User_Name'
            then if tblNew.fields[i].Value='Admin'
             then mustadd:=false;
        end
        else begin
            case tblNew.fields[i].DataType of
              ftSmallInt,ftInteger,ftLargeint: tblNew.fields[i].Value := 0;
              ftBoolean : tblNew.fields[i].Value := false;
              ftString  : tblNew.fields[i].Value := '';
            end;
        end;
      end;
      if mustadd then tblNew.Post;
      tblOld.Next;
    end;
    tblOld.close;
    tblNew.Close;
    tblOld.Destroy;
    tblNew.Destroy;

    qry.Destroy;
  end;
end;
end.


