unit DBS_Proc;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls, ExtCtrls, DBTables, TimeTool, Globals, StrUtils
  {$ifdef RajaiiHospital}
  ,Link2Timex_TLB
  {$endif RajaiiHospital}
  ;
type
  TfrmDBS = class(TForm)
    DBConnection : TAdoConnection;
    rdoDBS: TRadioGroup;
    lbl1: TLabel;
    lbl2: TLabel;
    txtPath: TEdit;
    txtDBSName: TEdit;
    btnPath: TButton;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    opnFile: TOpenDialog;
    adoQryG: TADOQuery;
    adoTblG: TADOTable;
    TblPersons: TADOTable;
    lbl3: TLabel;
    txtUser: TEdit;
    lbl4: TLabel;
    txtPass: TEdit;
    tblPrgPersons: TADOTable;
    tblFishFood: TADOTable;
    tblFish: TADOTable;
    _tblPrgPersons: TTable;
    _tblFishFood: TTable;
    _tblFish: TTable;
    _tblPersons: TTable;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rdoDBSClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
     { Private declarations }
  public
    { Public declarations }
    retCode : Byte;
    procedure UpgradeFishTbl;
  end;

  TDBSInfo = Record
  //Database information
    dbsType : Byte;   //Database type (M.S.Access or SQL.SERVER 2000)
    dbsName : String; //Database name
    dbsPath : String; //M.S.Access path or Server name
    dbsUser : String; //SQL Server User name
    dbsPass : String;  //SQL Server password
  end;

  shifttype  = record
                  ftime : integer;
                  etime : integer;
              end;
  iotypes = array[1..20] of integer;
  shift3type = array[1..3] of shifttype;
  shiftrec   = record
    shiftcode    : byte;
    shiftcount   : byte;
    shiftname    : string[20];
    shift3       : shift3type;
    shiftkind    : byte;
    shiftnesab   : integer;
    shiftdaytype : integer;
    shiftSobhaneh:boolean;
    shiftNahar   :boolean;
    shiftSham    :boolean;
    shiftnextSobhaneh:boolean;
  end;

(******************** CONSTANT Definition ********************)
const
  DBS_ACCESS    = 1;
  DBS_SQLSERVER = 2;
  DBConnectionTimeOut : Integer = 15;
  DBCommandTimeOut : Integer = 60;

(******************** Public VARIABLES Definition ********************)
var
  {$ifndef webClock}
    frmDBS  : TfrmDBS;
    dtaSrc  : String;
  {$endif}
  dbsInfo : TDBSInfo;
  {$ifdef RajaiiHospital}
  dbsInfoRH : TDBSInfo;
  {$endif RajaiiHospital}
  shifts:array[0..255] of shiftrec;
  tshift:byte;


(******************** PROCEDURES & FUNCTIONS Definition ********************)
procedure LoadDBSInfo;
{$ifdef RajaiiHospital}
procedure LoadDBSInfoRH;
{$endif RajaiiHospital}
function  DBSConnect : String;

function  tblExists(tblName : String): boolean;
procedure EmptyTbl(tblName : String);

function  GetNewNumber(tblName, fldName : String) : Integer;
function  GetNewNumberInType(tbl, fld, fld_type : String; value : Byte) : LongInt;
procedure ChangeDBSNum(tbl, fld : String; BefNum, NewNum : LongInt);
procedure ChangeDBSStr(tbl, fld : String; BefStr, NewStr : String);
procedure ChngIntegerField(tbl, fld : String; from, n : Integer);
function GetPartName(P1, P2, P3, P4 : LongInt; Lvl : Byte) : String;overload;
function GetPartName(CustomCode : String) : String;overload;
function GetAllPartName(P1, P2, P3, P4 : LongInt) : String;overload;
function GetPartCode(CustomCode : String) : String;overload;

function GetPartCustomCode(Code : String) : String;

function GetPartCodeEX(PrivPartCode: integer;PartName : String; Lvl : Byte) : Integer;
function GetPartNam(P1, P2, P3, P4 : LongInt; Lvl : Byte) : String;overload;
function GetPartNam(CustomCode : String) : String;overload;
function  IsExistsRec_Str(tblName, fldName, fldValue : String) : Boolean;
function  IsExistsRec_Num(tblName, fldName : String; fldValue : Integer) : Boolean;

procedure CreateClockDBS;

procedure InitVariables(RefreshReaders : Boolean);

{ Reader Procedure }
procedure LoadReaders(SetRecover : Boolean);
function  FindReaderNameIdx(ReaderName : String) : Byte;
function  FindReaderCodeIdx(ReaderCode : Integer) : Byte;
function  GetReaderCode(ReaderName : String) : Integer;
function  GetReaderName(ReaderCode : Integer) : String;
function  GetReaderNameInRam(ReaderCode : Integer) : String;
function  GetReaderKey(ReaderCode : Integer) : Integer;


{ Persons Procedures }
function GetPersonFamily(PersonCode : String) : String;
function GetPersonFamilyName(PersonCode : String) : String;
function GetPerson(PersonCode : String; IsProxi : Boolean) : TPerson;
function GetPersonCodeEX(PersonFamilyName : String) : String;
function PersonArived(ProxiCode : String; Vadeh : byte) : Boolean;
Procedure GetPresentPersons(Date : string ;var SobhanehCnt , NaharCnt , ShamCnt : integer);
Procedure PersonAuthorized(PersonCode : String; Date : string ;var Sobhaneh , Nahar , Sham : Boolean);

{ JobType Procedures }
function GetJobName(JobCode : Integer) : String;
function GetJobCode(JobName : String) : Integer;


{ Part Procedures }
//function GetPartName(PartCode : Integer) : String;
//function GetPartCode(PartName : String) : Integer;

{ Units Procedures }
function GetUnitName(UnitCode : Integer) : String;
function GetUnitCode(UnitName : String) : Integer;


{ Foods & Programs Procedures }
procedure LoadFoodList(TDate : String);
procedure LoadFoodPrice(TDate : String);
procedure LoadDayProg(TDate : String);
procedure LoaDayGroup(TDate : String;GroupCode : integer);
procedure LoadFishsNo(TDate : String);
function  GetFoodNameInDB(FoodCode : Integer) : String;
function  GetFoodCodeInDB(FoodName : String) : Integer;
function  GetFoodPriceInDB(FoodCode : Integer; TDate : String) : TPrice;
Procedure GetAllFoodPriceInDB(TDate : String);
function  GetGroupNameInDB(GroupCode : Integer) : String;
function  GetFoodNameInRam(FoodCode : Integer) : String;
function  GetFoodCodeInRam(FoodName : String) : Integer;
function  GetFoodCodeIndexInProg(Vadeh : Byte; FoodCode : Integer) : Integer;
function  GetFoodPriceInRam(FoodCode : Integer) : TPrice;
function  GetFoodPriceFeeInRam(FoodCode : Integer) : Currency;
function  GetFoodPricePersonInRam(FoodCode : Integer) : Currency;
function  GetFoodPriceFeeInDate(FoodCode : Integer; TDate : String) : Currency;
function  GetFoodAmar(FoodCode : Integer; Vadeh : Byte; TDate : String) : Integer;
function  GetFoodType(FoodCode : Integer) : Byte;
function  IsFood(FoodCode : Integer) : Boolean;
function  IsPersonServed(PCode, TD : String; Vadeh : Byte) : Integer;
function  GetAddWork(PCode : String) : Byte;
function  GetAddWorkDate(PCode,date : String) : Byte;
function  CreateFish(var PersonFish : TFish; var p : TPerson; ErrTest : Boolean) : Integer;
function IsExistsRec_2Num(tbl, fld1, fld2 : String; fld1Val, fld2Val : LongInt) : Boolean;
function  CreateOnLineFish(var PersonFish : TFish; var p : TPerson) : Integer;
procedure SaveFish(var PersonFish : TFish);
procedure SaveErrorLog(PersonFish : TFish; p : TPerson; ErrTest : Byte);
function  sumdelfish(fishno:integer;fishdate:string;fishtype:integer):integer;
procedure blankshift(var shift:shift3type);
procedure LoadShifts;

function authorized:boolean;
procedure refreshUser(avval:boolean);
procedure ENDOFUser;
procedure IsResident(tyesterdayio: integer;
                   yesterdayio : iotypes;
                   ttodayio: integer;
                   todayio : iotypes;
                   sptime : integer;
                   yesterdayshift,todayshift:shifttype;
                   var isready,isreadyday:boolean);
procedure IsResidentPerson(cardno:string;
                     spdate : string;
                     sptime : integer;
                     var isready,isreadyday : boolean;
                     var statday:integer);

function noacceptaddwork(cardno:string; spdate : string;var addtime:integer): boolean;

function getMntCnt(fPCode,fDate : String) : Smallint; //kaveh

(********************  I M P L E M E N T A T I O N ********************)
implementation

uses
  Funcs, MSGs, ADODB_TLB, ADOX_TLB, DateProc, makedb,main,comtools
  {$IFDEF WebClock},UserSessionUnit, ServerController{$ENDIF};

{$R *.dfm}
 {return sum of delete fish}

function  sumdelfish(fishno:integer;fishdate:string;fishtype:integer):integer;
var qrysumdel_fish:TADOQuery;
begin
with  qrysumdel_fish do
begin
close;
sql.Clear;
sql.Add('SELECT  fish.Fish_PCode, SUM(fishfood.FF_Pay) AS sumofdelfish' +
         ' FROM  fishfood INNER JOIN ' +
         ' fish ON fishfood.FF_FishNo = fish.Fish_No AND fishfood.FF_Type = fish.Fish_Type AND ' +
         ' fishfood.FF_Date = fish.Fish_Date '+
         ' WHERE  fish.Fish_No = '+ inttostr(fishno) +
         ' AND fish.Fish_Date =  '+ ''''+ fishdate +'''' +
         ' AND fish.Fish_Type =  '+ inttostr(fishtype )+
         ' GROUP BY fish.Fish_PCode ');
Open;
sumdelfish:=FieldByName('sumofdelfish').AsInteger;


end;
end;


{ load database type from file }
procedure LoadDBSInfo;
var
  f : TextFile;
begin
  if FileExists(g_Options.ProgramPath + 'DBSType.Dta') then
  begin
    AssignFile(f, g_Options.ProgramPath + 'DBSType.Dta');
    Reset(f);
    try
      Readln(f, dbsInfo.dbsType);
      Readln(f, dbsInfo.dbsName);
      Readln(f, dbsInfo.dbsPath);
      Readln(f, dbsInfo.dbsUser);
      Readln(f, dbsInfo.dbsPass);
      if dbsInfo.dbsType = DBS_ACCESS then
        g_Options.DataBasePath := dbsInfo.dbsPath;
    finally
      CloseFile(f);

    end;
  end
  else
  begin
    dbsInfo.dbsType := DBS_ACCESS;
    dbsInfo.dbsName := '';
    dbsInfo.dbsPath := '';
    g_Options.DataBasePath := dbsInfo.dbsPath;
  end;
end;

{$ifdef RajaiiHospital}
{ load database type RH from file }
procedure LoadDBSInfoRH;
var
  f : TextFile;
begin
  if FileExists(g_Options.ProgramPath + 'DBSTypeRH.Dta') then
  begin
    AssignFile(f, g_Options.ProgramPath + 'DBSTypeRH.Dta');
    Reset(f);
    try
      //Readln(f, dbsInfoRH.dbsType);
      dbsInfoRH.dbsType := 2;
      Readln(f, dbsInfoRH.dbsName);
      Readln(f, dbsInfoRH.dbsPath);
      Readln(f, dbsInfoRH.dbsUser);
      Readln(f, dbsInfoRH.dbsPass);
      if dbsInfoRH.dbsType = DBS_ACCESS then
        g_Options.DataBasePath := dbsInfoRH.dbsPath;
    finally
      CloseFile(f);

    end;
  end
  else
  begin
    dbsInfoRH.dbsType := 2;
    dbsInfoRH.dbsName := '';
    dbsInfoRH.dbsPath := '';
//    g_Options.DataBasePath := dbsInfoRH.dbsPath;
  end;
end;
{$endif RajaiiHospital}

{ checking for connecting to database }
function DBSConnect : String;
var err : String;
begin
  if dbsInfo.dbsType = DBS_ACCESS then
    dtaSrc := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
              'Jet OLEDB:Engine Type=5;' +
              'Data Source=' + dbsInfo.dbsPath + dbsInfo.dbsName
  else
  begin
    {dtaSrc := 'Provider=SQLOLEDB.1;' +
              'Persist Security Info=False;' +
              'Integrated Security=SSPI;' +
              'Data Source=' + dbsInfo.dbsPath + ';' +
              'Initial Catalog=' + dbsInfo.dbsName;}
    frmDBS.DBConnection.ConnectionTimeout := DBConnectionTimeOut;
    frmDBS.DBConnection.CommandTimeout := DBCommandTimeOut;
    dtaSrc := 'Provider=SQLOLEDB.1;' +
              'Persist Security Info=False;' +
              'User ID=' + dbsInfo.dbsUser + ';' +
              'Password=' + dbsInfo.dbsPass + ';' +
              'Data Source=' + dbsInfo.dbsPath + ';' +
              'Initial Catalog=' + dbsInfo.dbsName;
    FLD_CURRENCY := 'Money';
  end;


  with frmDBS.DBConnection do
  begin
    if Connected then
      Close;

    ConnectionString := dtaSrc;
    try
      frmDBS.DBConnection.Open;
      err := '';
    except
      on  E: Exception  do  err := E.Message;
    end;

    if err <> '' then
    begin
      if Pos('SQL server not found' , err) > 0 then
        Result := '”—ÊÌ” œÂ‰œÂ ÊÃÊœ ‰œ«—œ.'
      else if (Pos('Cannot open database' , err) > 0) or
              (Pos('Could not find file' , err) > 0) then
        Result := '»«“ê‘«ÌÌ »«‰ﬂ «ÿ·«⁄« Ì „Ì”— ‰Ì” .'
      else if Pos('Invalid object name', err) > 0 then
        Result := '»«“ê‘«ÌÌ ÃœÊ· «ÿ·«⁄« Ì „Ì”— ‰Ì” .'
      else if Pos('Cannot drop the table', err) > 0 then
        Result := 'Õ–› ÃœÊ· «ÿ·«⁄« Ì „Ì”— ‰Ì” .'
      else if (Pos('Cannot drop the database', err) > 0) and (Pos('in use', err) > 0) then
        Result := '»«‰ﬂ «ÿ·«⁄« Ì œ— Õ«· «” ›«œÂ „Ìù»«‘œ Ê Õ–› ¬‰ „Ì”— ‰Ì” .'
      else
        Result := err;
    end
    else
      Result := '';

  end;
end;

function tblExists(tblName : String): boolean;
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

{ return the maximum value of fldName from table }
function GetNewNumber(tblName, fldName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(' + fldName + ') AS maxFld FROM ' + tblName);
    Open;
    Result := FieldByName('maxFld').AsInteger+1;
    Close;
  end;
end;
{ return largest number+1 of fld field's from table of tbl_type }
function GetNewNumberInType(tbl, fld, fld_type : String; value : Byte) : LongInt;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(' + fld + ') AS Max_Num FROM ' + tbl);
    SQL.Add('WHERE ' + fld_type + ' = ' + IntToStr(value));
    Open;
    GetNewNumberInType := FieldByName('Max_Num').AsInteger + 1;
    Close;
  end;
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
    SQL.Add('WHERE ' + fld + ' = ''' + BefStr + '''');
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
    SQL.Add('WHERE ' + fld + ' >= ''' + IntToStr(from) + '''');
    ExecSQL;
  end;
end;


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

{ Return true if there is a special record in table }
function IsExistsRec_Str(tblName, fldName, fldValue : String) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + tblName + ' WHERE ' + fldName+ ' = N''' + fldValue + '''');
    Open;
    IsExistsRec_Str := not frmDBS.adoQryG.EOF;
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

function IsExistsRec_Num(tblName, fldName : String; fldValue : Integer) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT ' + fldName + ' FROM ' + tblName);
    SQL.Add('WHERE ' + fldName + ' = ' + IntToStr(fldValue));
    Open;
    Result := (RecordCount > 0);
    Close;
  end;
end;


procedure CreateClockDBS;
begin
  g_Options.ClockDBS := 'ClckRecs';
  if not tblExists('ClckRecs') then
    CreateTbl('ClckRecs')
  else
    EmptyTbl('ClckRecs');
end;

{ Initialize Global Variables }
procedure InitVariables(RefreshReaders : Boolean);
begin
  LoadIniFile;
  LoadFoodList(g_options.RunDate);
  LoadDayProg(g_options.RunDate);
//  LoaDayGroup(g_options.RunDate);
  LoadFishsNo(g_options.RunDate);
  LoadReaders(RefreshReaders);
  CreateClockDBS;
end;




(************************** Reader procedures ************************)

{ Load Units In Global Variables }
procedure LoadReaders(SetRecover : Boolean);
begin
  with frmDBS.adoQryG do
  begin
   SQL.Clear;
    SQL.Add('SELECT * FROM Readers');
    SQL.Add('where R_Active = 1');
    Open;
    TotalReader := 0;
    TotalActvRdr := 0;
    TotalOnLineRdr := 0;
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
        R_OnLine := FieldByName('R_OnLine').AsBoolean;
        R_Type := FieldByName('R_Type').AsInteger;
        R_Modem := FieldByName('R_Modem').AsBoolean;

        R_IsCom := FieldByName('R_IsCOM').AsBoolean;
        R_IP := FieldByName('R_IP').AsString;
        R_TCP := FieldByName('R_TCP').AsBoolean;
        R_Building := FieldByName('R_Station').AsInteger;

        R_PrintFish   :=FieldByName('R_PrintFish').asBoolean;
        R_PrnType     :=FieldByName('R_PrnType').AsInteger;
        R_LineFeed    :=FieldByName('R_LineFeed').AsInteger;
        R_AllFishPrc  :=FieldByName('R_AllFishPrc').asBoolean;
        R_ignorename  :=FieldByName('R_ignorename').asBoolean;

        if R_Active and (R_Type in [RDR_RESTZ84, RDR_RESTZ80]) then
        begin
          Inc(TotalActvRdr);
          if R_OnLine then
          begin
            Inc(TotalOnLineRdr);
            OnLineIdx := TotalOnLineRdr;
          end;
        end;
        RK_Key := GetReaderKey(R_Code);
        rdrGood := 0;
        rdrBad := 0;
        SycleTime := 0;
        OffClock_N := 0;
        Recoverd := not SetRecover;

      end;
      Next;
    end;
    Close;
  end;
  frmMain.ReCreateOnlineFrms;

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

{ Return Door Code From Readers }
function GetReaderCode(ReaderName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT R_Code FROM Readers');
    SQL.Add('WHERE R_Name = ''' + ReaderName + '''');
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

{ Return Reader Name From Ram }
function GetReaderNameInRam(ReaderCode : Integer) : String;
var i : byte;
begin
  GetReaderNameInRam := '';
  for i := 1 to TotalReader do
    if Readers[i].R_Code = ReaderCode then
    begin
      GetReaderNameInRam := Readers[i].R_Name;
      Break;
    end;
end;

{ Return reader default key from RdrKey database }
function GetReaderKey(ReaderCode : Integer) : Integer;
var
  ret : Integer;
  i : Byte;
  s : String;
  qry : TADOQuery;
begin
  with Qry do
  begin
    qry := TADOQuery.Create(application);
    qry.Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT RK_Keys FROM RdrKey');
    SQL.Add('WHERE RK_RdrCode = ' + IntToStr(ReaderCode));
    Open;
    if RecordCount > 0 then
      s := FieldByName('RK_Keys').AsString
    else
      s := '';
    Close;
  end;

  ret := 0;
  if Length(s) = 8 then
    for i := 1 to 8 do
      if s[i] <> '0' then
        ret := ret OR Pow2(i);

  GetReaderKey := ret;
end;

{ Return Person Family From Persons }
function GetPersonFamily(PersonCode : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Family FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_BarCode = N''' + PersonCode + '''');
    {$else}
    SQL.Add('WHERE P_BarCode = ''' + PersonCode + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      Result := FieldByName('P_Family').AsString
    else
      Result := '';
    Close;
  end;
end;

function GetPersonFamilyName(PersonCode : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT p_Family, p_Name FROM persons WHERE p_barcode = ''' + PersonCode + '''');
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('p_Name').AsString <> '' then
        Result := FieldByName('p_Family').AsString + '-' + FieldByName('p_Name').AsString
      else
        Result := FieldByName('p_Family').AsString;

    end
    else
      Result := '';
    Close;
  end;
end;

{ Return Person Information From Persons }
function GetPerson(PersonCode : String; IsProxi : Boolean) : TPerson;
var p : TPerson;
begin
  PersonCode := FixLeft(PersonCode, '0', 8);
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM persons');

    if IsProxi then
      SQL.Add('where P_Proxi = ''' + PersonCode + '''')
    else
      SQL.Add('where P_Barcode = ''' + PersonCode + '''');

    Open;
    if RecordCount >0 then
    begin
      p.p_exist :=true;
      p.P_BarCode := FieldByName('P_BarCode').AsString;
      p.P_Proxi := FieldByName('P_Proxi').AsString;
      p.P_Name := FieldByName('P_Name').AsString;
      p.P_Family := FieldByName('P_Family').AsString;
      p.P_parts := FieldByName('P_parts').Asstring ;
      p.P_JobCode := FieldByName('P_JobCode').AsInteger;
      p.P_ShiftGroup := FieldByName('P_ShiftGroup').AsInteger;
      p.P_Isvalid := FieldByName('P_IsValid').AsBoolean;
      p.P_ValidTest := FieldByName('P_ValidTest').AsBoolean;
      p.p_prepaid := FieldByName('P_prepaid').AsBoolean;
      p.P_PriceAble := FieldByName('P_Pricable').AsBoolean;
      p.P_Vadeh[MB_SOBH] := FieldByName('P_Sobhaneh').AsBoolean;
      p.P_Vadeh[MB_NAHAR] := FieldByName('P_Nahar').AsBoolean;
      p.P_Vadeh[MB_SHAM] := FieldByName('P_Sham').AsBoolean;
      p.P_Rejim := FieldByName('P_Rejim').AsBoolean;
      p.P_IsGuest := FieldByName('P_IsGuest').AsBoolean;
      p.P_Special := FieldByName('P_Special').AsInteger;
      p.P_DblFood := FieldByName('P_DblFood').AsBoolean;
      p.P_CashType := FieldByName('P_CashType').AsInteger;
      p.p_building := FieldByName('P_Building').AsInteger;
      p.p_credit := FieldByName('P_credit').AsCurrency;
      p.P_dblFoodMax := FieldByName('P_dblFoodMax').AsInteger;
      p.P_reserve1 := FieldByName('P_reserve1').AsString; //kaveh
      p.P_MntFood := FieldByName('P_MntFood').AsBoolean; //kaveh
      p.P_MntFoodMax := FieldByName('P_MntFoodMax').AsInteger; //kaveh
      p.P_Picture := FieldByName('P_Picture').AsString; //kaveh
      
      if p.P_Special = MB_ANYCARD then
        p.P_ManyFish := FieldByName('P_ManyFish').AsInteger
      else if (p.P_Special = MB_DATECARD) or (p.P_Special = MB_ANYDATECARD) then
      begin
        p.P_ManyFish := FieldByName('P_ManyFish').AsInteger;
        p.P_EtebarFish := FieldByName('P_EtebarFish').AsString;
        p.P_dblFoodMax := FieldByName('P_dblFoodMax').AsInteger;
      end;
      if not P.P_DblFood then
        p.P_dblFoodMax := 0;
    end
    else
    begin
      p.p_exist :=false;
      p.P_BarCode := PersonCode;
//      p.P_BarCode := '';
      p.P_Name := '';
      p.P_Family := '';
      p.P_parts := '0';
      p.P_JobCode := 0;
      p.P_Isvalid := False;
      p.P_ValidTest := False;
      p.P_PriceAble := False;
      p.P_Vadeh[MB_SOBH] := False;
      p.P_Vadeh[MB_NAHAR] := False;
      p.P_Vadeh[MB_SHAM] := False;
      p.P_Rejim := False;
      p.P_IsGuest := False;
      p.P_Special := MB_NORMAL;
      p.P_DblFood := False;
      p.P_ManyFish := 1;
      p.P_dblFoodMax := 0;
    end;
  end;
  GetPerson := p;
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
    SQL.Add('SELECT P_BarCode FROM Persons');
    {$IFDEF Network}
    SQL.Add('WHERE P_Name = N''' + PersonName + ''' ');
    SQL.Add('AND P_Family = N''' + PersonFamily + '''');
    {$else}
    SQL.Add('WHERE P_Name = ''' + PersonName + ''' ');
    SQL.Add('AND P_Family = ''' + PersonFamily + '''');
    {$ENDIF}
    Open;
    if RecordCount > 0 then
      result := FieldByName('P_BarCode').AsString
    else
      result := '';
    Close;
  end;
end;

{ Test for person arived }
function PersonArived(ProxiCode : String; Vadeh : byte) : Boolean;
var
  qry : TQuery;
  OK : Boolean;
  adoQry : TADOQuery;
  dt : String;
begin
  if F_Params.CollectFrom = 0 then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      dt := BeautifulDate(CurrentDate);
      SQL.Add('SELECT * FROM ' + g_options.ClockDBS + ' WHERE Clock_Date = ''' + dt + ''' and Clock_Barcode = ''' + FixLeft(ProxiCode,'0',8) + ''' and clock_chg = 0');
      Open;
      OK := True;
      if RecordCount = 0 then
        ok:=false
      else
      begin
        if not Odd(RecordCount) and (F_Params.ControlBase = MB_ODD_CARD) then
          OK := False
        else
        begin
          case Vadeh of
            MB_SOBH :
              if F_Params.SobhaneMaxIn > '00:00' then
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.SobhaneMaxIn then
                  ok:=false
                else
                  ok:=True;
            MB_NAHAR :
              if F_Params.NaharMaxIn > '00:00' then
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.NaharMaxIn then
                  ok:=false
                else
                  ok:=True;
            MB_SHAM :
              if F_Params.ShamMaxIn > '00:00' then
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.ShamMaxIn then
                  ok:=false
                else
                  ok:=True;
          end;
        end;
      end;
      Close;
      Free;
    end;
  end
  else
  begin
    adoQry := TAdoQuery.Create(Application);
    adoQry.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
                               'Initial Catalog='+F_Params.Clkdatabasename+';'+
                               'Data Source=' + F_Params.ClkServerName +
                               ';User ID=' + F_Params.ClkSqlUseName +
                               ';Password=' + F_Params.ClkSqlPassword;
    with adoQry do
    begin
      SQL.Clear;
      dt := BeautifulDate(CurrentDate);
      SQL.Add('SELECT * FROM C' + copy(dt , 1 , 4) + copy(dt , 6 , 2) + ' WHERE Clock_Date = ''' + dt + '''  and Clock_Barcode = ''' + FixLeft(GetPerson(ProxiCode,true).P_BarCode,'0',8) + ''' and clock_chg = 0');
      Open;
      OK := True;
      if RecordCount = 0
      then ok:=false
      else begin
        if not {resident()}Odd(RecordCount) and (F_Params.ControlBase = MB_ODD_CARD)then
          OK := False
        else
        begin
          case Vadeh of
            MB_SOBH :
              if F_Params.SobhaneMaxIn > '00:00' then
              begin
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.SobhaneMaxIn then
                  ok:=false
                else
                  ok:=True;
              end
              else
                ok:=True;
            MB_NAHAR :
              if F_Params.NaharMaxIn > '00:00' then
              begin
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.NaharMaxIn then
                  ok:=false
                else
                  ok:=True;
              end
              else
                ok:=True;
            MB_SHAM :
              if F_Params.ShamMaxIn > '00:00' then
              begin
                if IntToTime(fieldbyname('Clock_Time').AsInteger) > F_Params.ShamMaxIn then
                  ok:=false
                else
                    ok:=True;
              end
              else
                ok:=True;
          end;
        end;
      end;
      Close;
      Free;
    end;

  end;
  PersonArived := OK;
end;

Procedure GetPresentPersons(Date : string ;var SobhanehCnt , NaharCnt , ShamCnt : integer);
const
  KEY2VADEH : array[0..7] of Byte =
             (0, 2, 4, 8, 6, 12, 10, 14);
begin
  with frmDBS.adoQryG do
  begin
    if f_params.vadeh[mb_sobh]=mb_true
    then begin
      Close;
      SQL.Clear;
      SQL.Add('select * from persons where P_ShiftGroup = 0 or P_ShiftGroup is null and P_Sobhaneh = 1');
      open;
      sobhanehCnt := RecordCount;
    end
    else sobhanehCnt := 0;
    if f_params.vadeh[mb_nahar]=mb_true
    then begin
      close;
      SQL.Clear;
      SQL.Add('select * from persons where P_ShiftGroup =0 or P_ShiftGroup is null and P_Nahar = 1');
      open;
      naharCnt := RecordCount;
    end
    else naharCnt := 0;
    if f_params.vadeh[mb_sham]=mb_true
    then begin
      close;
      SQL.Clear;
      SQL.Add('select * from persons where P_ShiftGroup = 0 or P_ShiftGroup is null and P_Sham = 1');
      open;
      ShamCnt := RecordCount;
    end
    else ShamCnt := 0;

    close;
    SQL.Clear;
    SQL.Add('select * from persons where P_ShiftGroup <> 0 and P_ShiftGroup is not null ');
    open;
    first;
    while not Eof do
    begin
      LoaDayGroup(Date,FieldByName('P_ShiftGroup').AsInteger);
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_SOBH)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_SOBH) then
        inc(SobhanehCnt);
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_NAHAR)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_NAHAR) then
        inc(NaharCnt);
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_SHAM)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_SHAM) then
        inc(ShamCnt);

      next;
    end;
  end;
end;
Procedure PersonAuthorized(PersonCode : String; Date : string ;var Sobhaneh , Nahar , Sham : Boolean);
const
  KEY2VADEH : array[0..7] of Byte =
             (0, 2, 4, 8, 6, 12, 10, 14);
var
  adoQry : TADOQuery;
begin
  with adoQry do
  begin
    adoQry := TADOQuery.Create(Application);
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from persons where P_barcode = ''' + FixLeft(PersonCode ,'0',8) +  '''');
    open;

    LoaDayGroup(Date,FieldByName('P_ShiftGroup').AsInteger);

    if FieldByName('P_ShiftGroup').AsInteger <> 0 then
    begin
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_SOBH)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_SOBH) then
        Sobhaneh := True;
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_NAHAR)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_NAHAR) then
        Nahar := true;
      if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_SHAM)) <> 0) or
          (GetAddWork(FieldByName('P_BarCode').AsString) = MB_SHAM) then
        Sham := true;
      {
      if not Sobhaneh
      then begin
        LoaDayGroup(adddate(Date,-1),FieldByName('P_ShiftGroup').AsInteger);
        if ((KEY2VADEH[DayGroup.code] AND Pow2(MB_SOBH)) <> 0) or
         (GetAddWorkDate(FieldByName('P_BarCode').AsString,adddate(Date,-1)) = MB_SOBHNEXT)
          then Sobhaneh := True;
      end;
      }
    end
    else
    begin
      Sobhaneh := FieldByName('P_Sobhaneh').AsBoolean;
      Nahar := FieldByName('P_Nahar').AsBoolean;
      Sham := FieldByName('P_Sham').AsBoolean;
    end;
    close;
    free;
  end;
end;

function GetJobName(JobCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    close;
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

function GetPartCode(CustomCode : String) : String;overload;
var
  adoQry : TADOQuery;
begin
  adoQry := TADOQuery.Create(Application);
  with adoQry do
  begin
    Connection := frmDBS.DBConnection ;
    SQL.Clear;
    SQL.Add('SELECT P_Code FROM Parts');
    SQL.Add('WHERE P_CustomCode = ''' + CustomCode + '''');
    Open;
    if RecordCount > 0 then
      Result := FieldByName('P_Code').AsString
    else
      Result := '';
     Close;
     Free;
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
      SQL.Add('WHERE ' + fldName + ' = ''' + partName + '''');
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

{ Return JobCode from JobType database }
function GetJobCode(JobName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Job_Code FROM JobType');
    SQL.Add('WHERE Job_Name = ''' + JobName + '''');
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
function GetPartNam(P1, P2, P3, P4 : LongInt; Lvl : Byte) : String;overload;
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

function GetPartNam(CustomCode : String) : String;overload;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT P_Name FROM Parts');
    SQL.Add('WHERE P_CustomCode = N''' + CustomCode + '''');
    Open;
    if RecordCount > 0 then
      GetPartNam := FieldByName('P_Name').AsString
    else
      GetPartNam := '';
    Close;
  end;

end;



{ Return PartName from parts database }{
function GetPartName(PartCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Part_Name FROM Parts');
    SQL.Add('WHERE Part_Code = ' + IntToStr(PartCode));
    Open;
    if RecordCount > 0 then
      GetPartName := FieldByName('Part_Name').AsString
    else
      GetPartName := '';
    Close;
  end;
end;

{ Return PartCode from Party database } {
function GetPartCode(PartName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Part_Code FROM Parts');
    SQL.Add('WHERE Part_Name = ''' + PartName + '''');
    Open;
    if RecordCount > 0 then
      GetPartCode := FieldByName('Part_Code').AsInteger
    else
      GetPartCode := 0;
    Close;
  end;
end;    }


{ Units Procedures }
function GetUnitName(UnitCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Unit_Name FROM Units');
    SQL.Add('WHERE Unit_Code = ' + IntToStr(UnitCode));
    Open;
    if RecordCount > 0 then
      GetUnitName := FieldByName('Unit_Name').AsString
    else
      GetUnitName := '';
    Close;
  end;
end;

function GetUnitCode(UnitName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Unit_Code FROM Units');
    SQL.Add('WHERE Unit_Name = ''' + UnitName + '''');
    Open;
    if RecordCount > 0 then
      GetUnitCode := FieldByName('Unit_Code').AsInteger
    else
      GetUnitCode := 0;
    Close;
  end;
end;

(******************** Foods & price Processing ********************)


{ Load Food List in Global variables }
procedure LoadFoodList(TDate : String);
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT * FROM FoodList order by food_code');
    Open;
    TotalFoods := 0;
    while not EOF do
    begin
//j      Inc(TotalFoods);
      TotalFoods:=FieldByName('Food_Code').AsInteger;
      FoodsList[TotalFoods].Food_Code := FieldByName('Food_Code').AsInteger;
      FoodsList[TotalFoods].Food_Name := FieldByName('Food_Name').AsString;
      FoodsList[TotalFoods].Food_Type := FieldByName('Food_Type').AsInteger;
      Next;
    end;
    Close;
  end;
  LoadFoodPrice(TDate);
end;

{ Load food price in global variables }
procedure LoadFoodPrice(TDate : String);
var i : Byte;
begin
  GetAllFoodPriceInDB(TDate);
//  for i := 1 to TotalFoods do FoodsList[i].FoodPrice := GetFoodPriceInDB(FoodsList[i].Food_Code, TDate);
end;

{ Load current day program in global variables }
procedure LoadDayProg(TDate : String);
var
  i, j : Byte;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 8 do
    begin
      DayFoodList[i].Keys[j] := 0;
      DayFoodList[i].FoodAmar[j] := 0;
    end;
    DayFoodList[i].Keys[9] := 0;
    DayFoodList[i].Keys[0] := 0;
  end;
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Week');
    SQL.Add('WHERE Week_Date = ''' + TDate + '''');
    SQL.Add('OR Week_Date = ''' + AddDate(TDate,1) + '''');
    Open;
    while not EOF do
    begin
      i := FieldByName('Week_Type').AsInteger;
      if (FieldByName('Week_Date').AsString <> TDate) then
      begin
        if (i=MB_SOBH) then
          i := MB_SOBHNEXT
        else
          i := 0;
      end;
      if i<>0 then
      begin
        for j := 1 to 8 do
        begin
          DayFoodList[i].Keys[j] := FieldByName('Week_Key'+IntToStr(j)).AsInteger;
          DayFoodList[i].FoodAmar[j] := FieldByName('Week_N'+IntToStr(j)).AsInteger;
        end;
        DayFoodList[i].Keys[9] := FieldByName('Week_Key9').AsInteger;
        DayFoodList[i].Keys[0] := FieldByName('Week_Key0').AsInteger;
      end;
      Next;
    end;
    Close;
  end;
end;

{ Load day group in variable }
procedure LoaDayGroup(TDate : String;GroupCode : integer);
var
  i, d, m : integer;
  S, FldName,FldName1 : String;
  adoqryDtl : TADOQuery;
  stm,stm1 : String[31];
  function MakeCode(sh : shiftrec) : integer;
  var
    a,b,c,d : boolean;
  begin
    with sh do
    begin
      a := shiftSobhaneh;
      b := shiftNahar;
      c := shiftSham;
      d := shiftnextSobhaneh;
    end;

    if a
    then if DayGroup.shdirooz
    then if not d
    then a:=false;

    result := 0;
    if a then result := 1;
    if b then result := 2;
    if c then result := 3;
    if a and b then result := 4;
    if b and c then result := 5;
    if a and c then result := 6;
    if a and b and c then result := 7;
//    if d then result:=result+8;
  end;
begin
  adoqryDtl := TADOQuery.Create(Application);
  adoqryDtl.Connection := frmDBS.DBConnection;

  DayGroup.shdirooz:=false;
  
  if IsTrueDate(TDate) then
  begin
    d := StrToInt(Copy(TDate, 9, 2));
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM Groups where Grp_Code = ' + inttostr(GroupCode));
      Open;
      Linked_To_Clock := (FindField('grp_m1') = nil);
      if Linked_To_Clock then
        FldName := 'Grd_M' + IntToStr(StrToInt(Copy(TDate, 6, 2)))
      else
        FldName := 'Grp_M' + IntToStr(StrToInt(Copy(TDate, 6, 2)));

      if Linked_To_Clock then
      begin
        LoadShifts;
        with adoqryDtl do
        begin
          with SQL DO
          begin
             CLEAR;
             ADD('select * from grp_Dtl');
             add('where Grd_code =' + inttostr(GroupCode));
             add('and Grd_year =' + Copy(TDate, 1, 4))
          end;
          open;
          if eof then
            DayGroup.Code := 0
          else
          begin
            stm:=fieldbyname(FldName).asstring;
            if stm='' then
              DayGroup.Code := 0
            else
              DayGroup.Code := MakeCode(shifts[ord(stm[d])-1]);
          end;
          if DayGroup.Code = 0
          then begin
            DayGroup.shdirooz:=true;
            if copy(TDate, 9, 2)='01'
            then begin
              m:=strtoint(copy(TDate, 6, 2));
              if m>1
              then begin
                FldName1 := 'Grd_M' + IntToStr(m-1);
                stm1:=fieldbyname(FldName).asstring;
                if stm1<>'' then
                 if m in [2..7]
                  then DayGroup.Code := MakeCode(shifts[ord(stm1[31])-1])
                  else DayGroup.Code := MakeCode(shifts[ord(stm1[30])-1]);
              end;
            end
            else begin
              DayGroup.Code := MakeCode(shifts[ord(stm[d-1])-1]);
            end;
          end;
        end;
      end
      else
      if not Linked_To_Clock then
      begin
        S := FieldByName(FldName).AsString;
        if S <> '' then DayGroup.Code := StrToInt(S[d]);
      end;

      with DayGroup do
      begin
        fromSobh := FieldByName('Grp_FromSobh').AsString;
        ToSobh := FieldByName('Grp_ToSobh').AsString;
        fromNahar := FieldByName('Grp_FromNahar').AsString;
        ToNahar := FieldByName('Grp_ToNahar').AsString;
        fromSham := FieldByName('Grp_FromSham').AsString;
        ToSham := FieldByName('Grp_ToSham').AsString;
        if fromSobh = '' then
          fromSobh := F_Params.FromSobh;
        if toSobh = '' then
          toSobh := F_Params.toSobh;
        if fromNahar = '' then
          fromNahar := F_Params.fromNahar;
        if toNahar = '' then
          toNahar := F_Params.toNahar;
        if fromSham = '' then
          fromSham := F_Params.fromSham;
        if toSham = '' then
          toSham := F_Params.toSham;
      end;
      Close;
    end;
  end;
end;
{ Load Fish Number from Database }
procedure LoadFishsNo(TDate : String);
var
  i : Integer;
begin
  Sobh_Fish_No := F_Params.SobhFirstFish -1 ;
  Nahar_Fish_No := F_Params.NaharFirstFish -1 ;
  Sham_Fish_No := F_Params.shamFirstFish -1;
  SobhNext_Fish_No := F_Params.SobhFirstFish -1 ;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(Fish_No) AS Max_Fish, Fish_Date, Fish_Type FROM Fish');
    SQL.Add('WHERE Fish_Date = ''' + TDate + '''');
    SQL.Add('or Fish_Date = ''' + AddDate(TDate,1) + '''');
    SQL.Add('GROUP BY Fish_Type,Fish_Date');
    Open;
    while not Eof do
    begin
      if FieldByName('Fish_Date').AsString = TDate then
      begin
        case FieldByName('Fish_Type').AsInteger of
          MB_SOBH  : Sobh_Fish_No := FieldByName('Max_Fish').AsInteger;
          MB_NAHAR : Nahar_Fish_No := FieldByName('Max_Fish').AsInteger;
          MB_SHAM  : Sham_Fish_No := FieldByName('Max_Fish').AsInteger;
        end;
      end
      else
      if FieldByName('Fish_Type').AsInteger = MB_SOBH then
        SobhNext_Fish_No := FieldByName('Max_Fish').AsInteger;
      Next;
    end;
    Close;

    for i := 1 to 8 do
    begin
      UsedFoods[MB_SOBH][i] := 0;
      UsedFoods[MB_NAHAR][i] := 0;
      UsedFoods[MB_SHAM][i] := 0;
      UsedFoods[MB_SOBHNEXT][i] := 0;
    end;
    SQL.Clear;
    SQL.Add('SELECT FF_Food, SUM(FF_No) AS C FROM FishFood WHERE FF_Date = ''' + TDate + '''');
    SQL.Add('AND  FF_Type = ' + IntToStr(MB_SOBH));
    SQL.Add('GROUP BY FF_Food');
    Open;
    while not EOF do
    begin
      i := GetFoodCodeIndexInProg(MB_SOBH, FieldByName('FF_Food').AsInteger);
      if i <> 0 then
        UsedFoods[MB_SOBH][i] := FieldByName('C').AsInteger;
      Next;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT FF_Food, SUM(FF_No) AS C FROM FishFood WHERE FF_Date = ''' + TDate + '''');
    SQL.Add('AND FF_Type = ' + IntToStr(MB_NAHAR));
    SQL.Add('GROUP BY FF_Food');
    Open;
    while not EOF do
    begin
      i := GetFoodCodeIndexInProg(MB_NAHAR, FieldByName('FF_Food').AsInteger);
      if i <> 0 then
        UsedFoods[MB_NAHAR][i] := FieldByName('C').AsInteger;
      Next;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT FF_Food, SUM(FF_No) AS C FROM FishFood WHERE FF_Date = ''' + TDate + '''');
    SQL.Add('AND FF_Type = ' + IntToStr(MB_SHAM));
    SQL.Add('GROUP BY FF_Food');
    Open;
    while not EOF do
    begin
      i := GetFoodCodeIndexInProg(MB_SHAM, FieldByName('FF_Food').AsInteger);
      if i <> 0 then
        UsedFoods[MB_SHAM][i] := FieldByName('C').AsInteger;
      Next;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT FF_Food, SUM(FF_No) AS C FROM FishFood WHERE FF_Date = ''' + AddDate(TDate,1) + '''');
    SQL.Add('AND FF_Type = ' + IntToStr(MB_SOBH));
    SQL.Add('GROUP BY FF_Food');
    Open;
    while not EOF do
    begin
      i := GetFoodCodeIndexInProg(MB_SOBHNEXT, FieldByName('FF_Food').AsInteger);
      if i <> 0 then
        UsedFoods[MB_SOBHNEXT][i] := FieldByName('C').AsInteger;
      Next;
    end;
  end;
end;

{ Return FoodName from FoodList database }
function GetFoodNameInDB(FoodCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT Food_Name FROM FoodList');
    SQL.Add('WHERE Food_Code = ' + IntToStr(FoodCode));
    Open;
    if RecordCount > 0 then
      GetFoodNameInDB := FieldByName('Food_Name').AsString
    else
      GetFoodNameInDB := '';
    Close;
  end;
end;

{ Return FoodCode from FoodList database }
function GetFoodCodeInDB(FoodName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT Food_Code FROM FoodList');
    SQL.Add('WHERE Food_Name = ''' + FoodName + '''');
    Open;
    if RecordCount > 0 then
      GetFoodCodeInDB := FieldByName('Food_Code').AsInteger
    else
      GetFoodCodeInDB := 0;
    Close;
  end;
end;

{ Return FoodPrice from FoodPrice database }
function GetFoodPriceInDB(FoodCode : Integer;TDate : String) : TPrice;
var
  FP : TPrice;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT FP_PriceFee, FP_PricePerson FROM FoodPric');
    SQL.Add('WHERE FP_FoodCode = ' + IntToStr(FoodCode));
    SQL.Add('AND FP_Date <= ''' + TDate + '''');
    Open;
    if RecordCount > 0 then
    begin
      Last;
      FP.PriceFee := FieldByName('FP_PriceFee').AsCurrency;
      FP.PricePerson := FieldByName('FP_PricePerson').AsCurrency;
    end
    else
    begin
      FP.PriceFee := 0;
      FP.PricePerson := 0;
    end;
    GetFoodPriceInDB := FP;
    Close;
  end;
end;

Procedure GetAllFoodPriceInDB(TDate : String);
var
  FP : TPrice;
  i,idx  : integer;

begin
  for i := 1 to TotalFoods do
  begin
    FoodsList[i].FoodPrice.PriceFee := 0;
    FoodsList[i].FoodPrice.PricePerson := 0;
  end;

  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from  FoodPric right outer join');
    SQL.Add('(SELECT FP_FoodCode,FP_Date=max(FP_Date)FROM FoodPric');
    SQL.Add('where FP_Date <= ''' + TDate + '''');
    SQL.Add('group by fp_foodcode) a');
    SQL.Add('on foodpric.FP_Date=a.FP_Date and foodpric.FP_FoodCode=a.FP_FoodCode');
    Open;
    while not eof do
    begin
      if FieldByName('FP_FoodCode').asinteger<=TotalFoods then
      begin
        idx := -1;
        for I := 1 to TotalFoods do
          if FoodsList[I].Food_Code = FieldByName('FP_FoodCode').asinteger then
          begin
            idx := I;
            break;
          end;
        if idx <> -1 then
        begin
          FoodsList[idx].FoodPrice.PriceFee := FieldByName('FP_PriceFee').AsCurrency;
          FoodsList[idx].FoodPrice.PricePerson := FieldByName('FP_PricePerson').AsCurrency;
        end;
      end;
      Next;
    end;
    Close;
  end;
end;

function GetGroupNameInDB(GroupCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    Close;
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

{ Return FoodPrice Fee from FoodPrice database }
function GetFoodPriceFeeInDate(FoodCode : Integer; TDate : String) : Currency;
var FP : TPrice;
begin
  FP := GetFoodPriceInDB(FoodCode, TDate);
  GetFoodPriceFeeInDate := FP.PriceFee;
end;

{ Return FoodName from FoodList variables }
function GetFoodNameInRam(FoodCode : Integer) : String;
var i : Byte;
begin
  GetFoodNameInRam := '';
  for i := 1 to TotalFoods do
    if FoodsList[i].Food_Code = FoodCode then
    begin
      GetFoodNameInRam := FoodsList[i].Food_Name;
      Break;
    end;
end;

{ Return FoodCode from FoodList variables }
function GetFoodCodeInRam(FoodName : String) : Integer;
var i : integer;
begin
  GetFoodCodeInRam := 0;
  for i := 1 to TotalFoods do
    if FoodsList[i].Food_Name = FoodName then
    begin
      GetFoodCodeInRam := FoodsList[i].Food_Code;
      Break;
    end;
end;

{ Return FoodCode Index in day prog }
function GetFoodCodeIndexInProg(Vadeh : Byte; FoodCode : Integer) : Integer;
var i : Byte;
begin
  GetFoodCodeIndexInProg := 0;
  if FoodCode <> 0 then
    for i := 1 to 8 do
      if DayFoodList[Vadeh].Keys[i] = FoodCode then
      begin
        GetFoodCodeIndexInProg := i;
        Break;
      end;
end;

{ Return FoodPrice from FoodPList variable }
function GetFoodPriceInRam(FoodCode : Integer) : TPrice;
var
//  i : Byte;
  FP : TPrice;
begin
  FP.PriceFee := 0;
  FP.PricePerson := 0;
//  for i := 1 to TotalFoods do
//    if FoodsList[i].Food_Code = FoodCode then
//    begin
      FP := FoodsList[FoodCode].FoodPrice;
//      Break;
//    end;
  GetFoodPriceInRam := FP;
end;

{ Return FoodPriceFee from FoodPList variable }
function GetFoodPriceFeeInRam(FoodCode : Integer) : Currency;
var
  FP : Currency;
  i : Byte;
begin
  FP := 0;
  for i := 1 to TotalFoods do
    if FoodsList[i].Food_Code = FoodCode then
    begin
      FP := FoodsList[i].FoodPrice.PriceFee;
      Break;
    end;

  GetFoodPriceFeeInRam := FP;
end;

{ Return FoodPricePerson from FoodPList variable }
function GetFoodPricePersonInRam(FoodCode : Integer) : Currency;
var
  cntr : integer;
  FP : Currency;
begin
  FP := 0;
  cntr := 1;
  while cntr <= TotalFoods do
  begin
    if FoodsList[cntr].Food_Code = FoodCode then
    begin
      FP := FoodsList[cntr].FoodPrice.PricePerson;
      Break;
    end;
    cntr := cntr + 1;
  end;
  GetFoodPricePersonInRam := FP;
end;

{ Return foods amar from database in special date }
function GetFoodAmar(FoodCode : Integer; Vadeh : Byte; TDate : String) : Integer;
var
  i : Byte;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    GetFoodAmar := 0;
    SQL.Clear;
    SQL.Add('SELECT * FROM Week');
    SQL.Add('WHERE Week_Date = ''' + TDate + '''');
    SQL.Add('AND Week_Type = ' + IntToStr(Vadeh));
    SQL.Add('AND (Week_Key1 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key2 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key3 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key4 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key5 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key6 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key7 = ' + IntToStr(FoodCode));
    SQL.Add('OR Week_Key8 = ' + IntToStr(FoodCode) + ')');
    Open;
    if RecordCount > 0 then
    begin
      for i := 1 to 8 do
      begin
        if FieldByName('Week_Key'+IntToStr(i)).AsInteger = FoodCode then
        begin
          GetFoodAmar := FieldByName('Week_N'+IntToStr(i)).AsInteger;
          Break;
        end;
      end;
    end;
    Close;
  end;
end;

function GetFoodType(FoodCode : Integer) : Byte;
var i : Byte;
begin
  Result := 0;
  for i := 1 to TotalFoods do
    if FoodsList[i].Food_Code = FoodCode then
    begin
      Result := FoodsList[i].Food_Type;
      Break;
    end;
end;

function IsFood(FoodCode : Integer) : Boolean;
var qry3 : TADOQuery;
begin
  result := true;
  qry3 := TADOQuery.Create(Application);
  qry3.Connection := frmDBS.DBConnection;
  qry3.SQL.Clear;
  qry3.SQL.Add('SELECT Food_Name FROM FoodList WHERE Food_Code = ' + IntToStr(FoodCode));
  qry3.SQL.Add('AND (Food_Type = ' + IntToStr(MB_GHAZA) + 'OR Food_Type = ' + IntToStr(MB_SOBHANEH)+ ')');
  qry3.Open;
  Result := (qry3.RecordCount > 0);
  qry3.Close;
  qry3.free;
end;


{ Is personel served food before }
function IsPersonServed(PCode, TD : String; Vadeh : Byte) : Integer;
var qry{,qry2} : TADOQuery;
begin
//optimized code
  result := 0;
  qry  := TADOQuery.Create(Application);
  with qry do
  begin
    IsPersonServed := 0;
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select count(*) as cnt from fish,fishfood,foodlist');
    SQL.Add('where Fish_Date=FF_Date and Fish_Type=FF_Type and Fish_No = FF_FishNo and FF_Food= Food_Code');
    SQL.Add(' AND Food_Type = 2 '); //kaveh 1390/10/20
    SQL.Add('AND Fish_PCode = ''' + PCode + '''');
    SQL.Add('AND Fish_Date = ''' + TD + '''');
    SQL.Add('AND Fish_Type = ' + IntToStr(Vadeh));
//    SQL.Clear;
//    SQL.Add('SELECT count(*) as cnt ');
//    SQL.Add('FROM fish INNER JOIN ');
//    SQL.Add('fishfood ON fish.Fish_Date = fishfood.FF_Date AND fish.Fish_Type = fishfood.FF_Type AND ');
//    SQL.Add('fish.Fish_No = fishfood.FF_FishNo INNER JOIN ');
//    SQL.Add('foodlist ON fishfood.FF_Food = foodlist.Food_Code ');
//    SQL.Add('where ');
//    SQL.Add('Food_Type = 2 '); //kaveh 1390/10/20
//    SQL.Add('AND Fish_PCode = ''' + PCode + '''');
//    SQL.Add('AND Fish_Date = ''' + TD + '''');
//    SQL.Add('AND Fish_Type = ' + IntToStr(Vadeh));
    Open;
    first;
    result := FieldByName('cnt').AsInteger;
    close;
    Free;
  end;
 //not optimized code
//  qry  := TADOQuery.Create(Applicatiozn);
//  qry2 := TADOQuery.Create(Application);
//  with qry do
//  begin
//    IsPersonServed := 0;
//    Connection := frmDBS.DBConnection;
//    SQL.Clear;
//    SQL.Add('SELECT Fish_No FROM Fish WHERE Fish_PCode = ''' + PCode + '''');
//    SQL.Add('AND Fish_Date = ''' + TD + '''');
//    SQL.Add('AND Fish_Type = ' + IntToStr(Vadeh));
//    Open;
//    first;
//    while not eof do
//    begin
//      qry2.close;
//      qry2.Connection := frmDBS.DBConnection;
//      qry2.SQL.Clear;
//      qry2.SQL.Add('SELECT * FROM FishFood WHERE FF_FishNo = ' + qry.fieldByName('Fish_No').AsString);
//      qry2.SQL.Add('AND FF_Date = ''' + TD + '''');
//      qry2.SQL.Add('AND FF_Type = ' + IntToStr(Vadeh));
//      qry2.Open;
//      qry2.First;
//      while not qry2.Eof do
//      begin
//        if isfood(qry2.fieldByName('FF_Food').AsInteger) then
//        begin
//          inc(Result);
//        end;
//        qry2.Next;
//      end;
//      qry2.close;
//      qry.next;
//    end;
//    qry.Close;
//  end;
//  qry.close;
//  qry.Free;
//  qry2.Free;
end;

{ Return vadeh of personel in AddWork }
function GetAddWork(PCode : String) : Byte;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT OG_Vadeh FROM OutGroup WHERE OG_PCode = ''' + PCode + '''');
    SQL.Add('AND OG_Date = ''' + CurrentDate + '''');
    Open;
    if RecordCount > 0 then
      GetAddWork := FieldByName('OG_Vadeh').AsInteger
    else
      GetAddWork := 0;
    Close;
  end;
end;

function GetAddWorkDate(PCode,date : String) : Byte;
begin
  with frmDBS.adoQryG do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT OG_Vadeh FROM OutGroup WHERE OG_PCode = ''' + PCode + '''');
    SQL.Add('AND OG_Date = ''' + Date + '''');
    Open;
    if RecordCount > 0 then
      GetAddWorkDate := FieldByName('OG_Vadeh').AsInteger
    else
      GetAddWorkDate := 0;
    Close;
  end;
end;

{ Create a record for save into the database }
function CreateFish(var PersonFish : TFish; var P : TPerson; ErrTest : Boolean) : Integer;
var
  i : Byte;
  FoodSel, IsFirst : Boolean;
  tblperpaid, qryPrgPersons:TADOQuery;
  pric:Currency;
  dblCount : integer;
//kaveh is
{$ifdef RajaiiHospital}
  rajaiiTimex : TclsTimex;
{$endif RajaiiHospital}
{$ifdef OperatorBase}
  MntCntLmt : Boolean;
{$endif OperatorBase}
//kaveh ie

begin
{$REGION 'Update Run Date'}
    if (g_options.RunDate <> PersonFish.Fish_Date) and ErrTest then
  begin
    g_options.RunDate := PersonFish.Fish_Date;
    InitVariables(False);
  end;
{$ENDREGION}
{$REGION 'Check Card Validation'}
  p := GetPerson(PersonFish.Fish_PCode, PersonFish.IsProxi);
  if p.P_BarCode=''
  then begin
    p := GetPerson(PersonFish.Fish_PCode, not PersonFish.IsProxi);
  end;
  if ErrTest and (not p.P_exist) then
  begin
    {Invalid Card}
    CreateFish := 1;
    Exit;
  end;
  PersonFish.Fish_PCode := p.P_BarCode;
{$ENDREGION}
{$REGION 'Check Vadeh and Out of time'}
  CreateFish := 0;
  if (p.P_ShiftGroup <> 0) then
    LoaDayGroup(PersonFish.Fish_Date,p.P_ShiftGroup);
  if (PersonFish.Fish_Time<>'') and ((F_Params.Vadeh[MB_SOBH]= MB_TRUE) and
     ((p.P_ShiftGroup = 0) and
      (PersonFish.Fish_Time >= F_Params.FromSobh) and
      (PersonFish.Fish_Time <= F_Params.ToSobh)
     ) or
     ((p.P_ShiftGroup <> 0) and
      (PersonFish.Fish_Time >= DayGroup.FromSobh) and
      (PersonFish.Fish_Time <= DayGroup.ToSobh)
     ))
  then
  begin
    PersonFish.Fish_Type := MB_SOBH;
    PersonFish.Fish_No := Sobh_Fish_No;
  end
  else
  if (PersonFish.Fish_Time<>'') and ((F_Params.Vadeh[MB_NAHAR] = MB_TRUE) and
     ((p.P_ShiftGroup = 0) and
      (PersonFish.Fish_Time >= F_Params.FromNahar) and
      (PersonFish.Fish_Time <= F_Params.ToNahar)
     )or
     ((p.P_ShiftGroup <> 0) and
      (PersonFish.Fish_Time >= DayGroup.FromNahar) and
      (PersonFish.Fish_Time <= DayGroup.ToNahar)
     ))
  then
  begin
    PersonFish.Fish_Type := MB_NAHAR;
    PersonFish.Fish_No := Nahar_Fish_No;
  end
  else
  if (PersonFish.Fish_Time<>'') and ((F_Params.Vadeh[MB_SHAM] = MB_TRUE) and
     ((p.P_ShiftGroup = 0) and
      (PersonFish.Fish_Time >= F_Params.FromSham) and
      (PersonFish.Fish_Time <= F_Params.ToSham)
     )or
     ((p.P_ShiftGroup <> 0) and
      (PersonFish.Fish_Time >= DayGroup.FromSham) and
      (PersonFish.Fish_Time <= DayGroup.ToSham)
     ))
  then
  begin
    PersonFish.Fish_Type := MB_SHAM;
    PersonFish.Fish_No := Sham_Fish_No;
  end
  else
  begin
    if ErrTest then
    begin
      {Out of time}
      CreateFish := 3;
      if AUTOCONTROL = 1 then
        Exit;
    end
    else
    begin
      PersonFish.Fish_Type := MB_NAHAR;
      PersonFish.Fish_No := Nahar_Fish_No;
    end;
  end;

  dblCount := IsPersonServed(PersonFish.Fish_PCode, PersonFish.Fish_Date, PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3);
  IsFirst := (dblCount=0);
  if (f_params.SobhInSham = MB_TRUE) and not p.P_IsGuest then
    if (dblCount>p.P_dblFoodMax) and (PersonFish.Fish_Type = MB_SHAM) then
    begin
      PersonFish.Fish_Type := MB_SOBHNEXT;
      PersonFish.Fish_Date := AddDate(PersonFish.Fish_Date,1);
//      g_options.RunDate := PersonFish.Fish_Date;
//      InitVariables(False);
      PersonFish.Fish_No := SobhNext_Fish_No;
      dblCount := IsPersonServed(PersonFish.Fish_PCode, PersonFish.Fish_Date, PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3);
      IsFirst := (dblCount=0);
    end;
{$ENDREGION}
{$REGION 'No serve this vadeh'}
  if ErrTest and (PersonFish.Fish_Type in [MB_SOBH..MB_SOBHNEXT]) and
     (F_Params.Vadeh[PersonFish.Fish_Type] = MB_FALSE) then
  begin
    {No serve this vadeh}
    CreateFish := PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3  + 5;
    Exit;
  end;
{$ENDREGION}
{$REGION 'Food Program not set'}
  for i := 1 to 8 do
    if DayFoodList[PersonFish.Fish_Type].Keys[i] <> 0 then
      Break;
  if i = 9 then
  begin
    {Food Program not set}
    CreateFish := 10;
    Exit;
  end;
{$ENDREGION}
{$REGION 'Rajaii Hospital Timex'}
  {$ifdef RajaiiHospital}
  LoadDBSInfoRH();
  rajaiiTimex := TclsTimex.Create(frmDBS);
  rajaiiTimex.SetConnectionString(dbsInfoRH.dbsPath, dbsInfoRH.dbsName, dbsInfoRH.dbsUser, dbsInfoRH.dbsPass);
  rajaiiTimex.GetShiftTimex(DelLeftZero(p.P_Proxi), PersonFish.Fish_Date, StrToInt(Copy(PersonFish.Fish_Time, 1, 2)), StrToInt(Copy(PersonFish.Fish_Time, 4, 2)));
  if (rajaiiTimex.ErrorNumber <> '0') or (DelLeftZero(p.P_Proxi) <> rajaiiTimex.BarCode) then
  begin
    {Error in using Timex Link2Timex.dll}
    CreateFish := 1;
    Exit;
  end;
  if not rajaiiTimex.IsTimex then
  begin
    {IsTimex is False}
    CreateFish := 2;
    Exit;
  end;
  if not rajaiiTimex.IsShift then
  begin
    {IsShift is False}
    CreateFish := 9;
    Exit;
  end;
  {$endif RajaiiHospital}
{$ENDREGION}
{$REGION 'Reserve Food'}
  IF (F_Params.RunReserve = MB_TRUE) then
  begin
    if (PersonFish.keys = 0) or (F_Params.MustReserve = MB_TRUE) then
    begin
{//kaveh 901008
      if (frmDBS.tblPrgPersons.State <> dsInactive) then
        frmDBS.tblPrgPersons.Close;
      frmDBS.tblPrgPersons.Open;
      if frmDBS.tblPrgPersons.locate('pp_Date;pp_Type;pp_PCode',VarArrayOf([PersonFish.Fish_Date, PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3 , PersonFish.Fish_PCode]),[loPartialKey]) then
//kaveh 901008}
//kaveh is 901008 
      qryPrgPersons := TADOQuery.Create(Application);
      qryPrgPersons.Connection := frmDBS.DBConnection;
      qryPrgPersons.SQL.Clear;
      qryPrgPersons.SQL.Add('select * from PrgPrs');
      qryPrgPersons.SQL.Add(' where (PP_Date = ''' + PersonFish.Fish_Date + ''')');
      qryPrgPersons.SQL.Add(' and (PP_Type = ' + IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ')');
      qryPrgPersons.SQL.Add(' and (PP_PCode = ''' + PersonFish.Fish_PCode + ''')');
      qryPrgPersons.Open;
//kaveh ie 901008
      if qryPrgPersons.RecordCount > 0 then
      begin
        if F_Params.ValidInAllBuilding = MB_FALSE then
        begin
          if (p.p_building <> readers[FindReaderCodeIdx(PersonFish.Fish_RdrCode)].R_Building{F_Params.Building})
          and (readers[FindReaderCodeIdx(PersonFish.Fish_RdrCode)].R_Building<>0)
          then begin
            {Reserved in Other Building}
            CreateFish := 17;
//kaveh 901008            frmDBS.tblPrgPersons.Close;
            qryPrgPersons.Close; //kaveh 901008
            qryPrgPersons.Free; //kaveh 901008
            exit;
          end;
        end;
//kaveh 901008        PersonFish.Keys := frmDBS.tblPrgPersons.FieldByname('PP_Keys').AsInteger;
        PersonFish.Keys := qryPrgPersons.FieldByname('PP_Keys').AsInteger; //kaveh 901008
      end
      else if (F_Params.MustReserve = MB_TRUE) then
      begin
        {did not Reserved}
        CreateFish := 16;
//kaveh 901008        frmDBS.tblPrgPersons.Close;
            qryPrgPersons.Close; //kaveh 901008
            qryPrgPersons.Free; //kaveh 901008
        Exit;
      end;
//kaveh 901008      frmDBS.tblPrgPersons.Close;
            qryPrgPersons.Close; //kaveh 901008
            qryPrgPersons.Free; //kaveh 901008
    end;
  end
  else begin
//kaveh 901008      if (frmDBS.tblPrgPersons.State <> dsInactive) then
//kaveh 901008        frmDBS.tblPrgPersons.Close;
//kaveh 901008      frmDBS.tblPrgPersons.Open;
      if F_Params.ValidInAllBuilding = MB_FALSE then
      begin
        if (p.p_building <> readers[FindReaderCodeIdx(PersonFish.Fish_RdrCode)].R_Building{F_Params.Building})
        and (readers[FindReaderCodeIdx(PersonFish.Fish_RdrCode)].R_Building<>0)
        then begin
          {Reserved in Other Building}
          CreateFish := 17;
          frmDBS.tblPrgPersons.Close;
          exit;
        end;
//      PersonFish.Keys := frmDBS.tblPrgPersons.FieldByname('PP_Keys').AsInteger;
      end;
      frmDBS.tblPrgPersons.Close;
  end;

{$ENDREGION}
{$REGION 'Check Many Fish'}
  PersonFish.IsPayed := p.P_PriceAble;
  for i := 1 to 8 do PersonFish.Fish_Foods[i] := 0;
  if p.P_Special <> MB_NORMAL then
  begin
    PersonFish.ManySel := p.P_ManyFish;

    if ErrTest and ((p.P_Special = MB_DATECARD) or (p.P_Special = MB_ANYDATECARD)) then
    begin
      if (p.P_ManyFish = 0) or
         (p.P_EtebarFish < CurrentDate) then
      begin
        {Card Etebar}
        CreateFish := 14;
        Exit;
      end;
    end;
  end
  else
    PersonFish.ManySel := 1;
{$ENDREGION}
{$REGION 'Food Not Selected'}
    if PersonFish.Keys = 0 then
    begin
      {food not select}
      if p.P_Rejim and (DayFoodList[PersonFish.Fish_Type].Keys[0] <> 0) then
        PersonFish.Keys := 1
  
      else
        if DayFoodList[PersonFish.Fish_Type].Keys[9] <> 0 then
        begin
          if (F_Params.RunReserve=0) or ((F_Params.RunReserve=1) and (F_Params.MustReserve=0)) then
            PersonFish.Keys := Pow2(9)
          else
          begin
            {Food Program not set}
            CreateFish := 15;
            Exit;
          end
        end
        else
        begin
          {Food Program not set}
          CreateFish := 10;
          Exit;
        end;
    end;

{$ENDREGION}
{$REGION 'check Key pressed'}
  if (PersonFish.Keys AND Pow2(0)) <> 0 then
  begin
    {Rejimi key pressed}
    if not p.P_Rejim and ErrTest then
    begin
      {Invalid Food Select}
      CreateFish := 15;
      Exit;
    end
    else
      for i := 1 to 8 do
        if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) <> 0 then
          PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
  end
  else if (PersonFish.Keys AND Pow2(9)) <> 0 then
  begin
    {Default Key Pressed}
    if p.P_Rejim and ErrTest then
    begin
      {Invalid Food Select}
      CreateFish := 15;
      Exit;
    end
    else
      for i := 1 to 8 do
        if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) <> 0 then
          PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
  end
  else
  begin
    {any Key pressed}
    FoodSel := False;
    for i := 1 to 8 do
      if ((PersonFish.Keys AND Pow2(i)) <> 0) and
         (DayFoodList[PersonFish.Fish_Type].Keys[i] <> 0) then
      begin
        FoodSel := True;
        Break;
      end;
  
    if FoodSel then
    begin
      for i := 1 to 8 do
        if (PersonFish.Keys AND Pow2(i)) <> 0 then
        begin
          if (p.P_Rejim and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) <> 0) and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) = 0)) or
             (not p.P_Rejim and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) <> 0) and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) = 0)) and
             ErrTest then
          begin
            {Invalid Food Select}
            CreateFish := 15;
            Exit;
          end
          else
            PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
        end;
    end
    else if not FoodSel and ErrTest then
    begin
      {Invalid Food Select}
      CreateFish := 15;
      Exit;
    end;
  end;
{$ENDREGION}

{$REGION 'Bank-Markazi'}
{$ifdef OperatorBase}
  MntCntLmt := False;
  if p.P_MntFood then
    if getMntCnt(PersonFish.Fish_PCode, PersonFish.Fish_Date) >= p.P_MntFoodMax then
      MntCntLmt := True;
//  getMntCnt(PersonFish.Fish_PCode, PersonFish.Fish_Date);
{$endif OperatorBase}
{$ENDREGION}

{$REGION 'Calcule Price of fish'}
  for i := 1 to 8 do
  begin
    if PersonFish.Fish_Foods[i] <> 0 then
    begin
      if IsFirst then
      begin
        if not p.P_IsGuest then
        begin
          case p.P_CashType of
            0 :
              begin
                if F_Params.FirstFoodPrcPerson = PRC_PERSON then
                  PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                else
                  PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
              end;
            1 : PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i]);
            2:  PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
          end;
        end
        else
        begin
          case p.P_CashType of
            0 :
              begin
                if F_Params.FirstFoodPrcGuest = PRC_PERSON then
                  PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                else
                  PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
              end;
            1 : PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i]);
            2 : PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
          end;
        end
      end
      else
      begin
        if not p.P_IsGuest then
        begin
          case p.P_CashType of
            0 :
              begin
                if F_Params.SecondFoodPrcPerson = PRC_PERSON then
                  PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                else if F_Params.SecondFoodPrcPerson = PRC_PEYMANY then
                  PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i])
                else if F_Params.SecondFoodPrcPerson = -1 then
                  if F_Params.FirstFoodPrcPerson = PRC_PERSON then
                    PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                  else
                    PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
              end;
            1 : PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i]);
            2 : PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
          end;
        end
        else
        begin
          case p.P_CashType of
            0 :
              begin
                if F_Params.SecondFoodPrcGuest = PRC_PERSON then
                  PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                else if F_Params.SecondFoodPrcGuest = PRC_PEYMANY then
                  PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i])
                else if F_Params.SecondFoodPrcGuest = -1 then
                  if F_Params.FirstFoodPrcGuest = PRC_PERSON then
                    PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
                  else
                    PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
              end;
            1 : PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i]);
            2 : PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
          end;
        end;
      end;

{$ifdef OperatorBase}
      if (MntCntLmt) and (IsFirst) then
      begin
        case PersonFish.Fish_Type of
          MB_NAHAR:
            if (i <= F_Params.NaharKeyNo) and (PersonFish.Fish_Foods[i] <> 0) then
              PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
          MB_SHAM :
            if (i <= F_Params.ShamKeyNo) and (PersonFish.Fish_Foods[i] <> 0) then
              PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
        end;
//        PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
      end;
{$endif OperatorBase}
    end
    else
      PersonFish.Fish_Price[i] := 0;
  end;
{$ENDREGION}
{$REGION 'prepaid persons'}
 PersonFish.prePaid := p.p_Prepaid;
 if  p.p_prepaid = true  then
   begin
      for i:= 1 to 8 do
       p.p_sumfish:=p.p_sumfish+PersonFish.Fish_Price[i];
     if p.p_credit <  (p.p_sumfish + F_Params.MinCredit) then
      begin
        {credit not enough}
        CreateFish := 18;
        Exit;
      end ;
  end;
  //**** end of prepaid************************************************

{$endregion}
{$REGION 'Foods not exist'}
  if ErrTest then
  begin
    for i := 1 to 8 do
    begin
      if (PersonFish.Fish_Foods[i] <> 0) and
         ((UsedFoods[PersonFish.Fish_Type][i]+PersonFish.Fish_FoodsNo[i] > DayFoodList[PersonFish.Fish_Type].FoodAmar[i]) or
          ((p.P_Special = MB_ANYCARD) and (UsedFoods[PersonFish.Fish_Type][i]+PersonFish.ManySel > DayFoodList[PersonFish.Fish_Type].FoodAmar[i]))) then
      begin
        {Foods not exist}
        CreateFish := 11;
        Exit;
      end;
    end;
    CreateFish := CreateOnLineFish(PersonFish, P);
  end;
{$ENDREGION}
end;

{ Create a record for save into the database in OnLine Mode}
function CreateOnLineFish(var PersonFish : TFish; var P : TPerson) : Integer;
const
  KEY2VADEH : array[0..7] of Byte =
             (0, 2, 4, 8, 6, 12, 10, 14);
var
  i, j,
  FoodN : Byte;
  isFoodSel : Boolean;
  dblCount : integer;
begin
  CreateOnLineFish := 0;
  f_params.KasrShavad := false;
  isFoodSel := False;

  for i := 1 to 8 do
    if IsFood(PersonFish.Fish_Foods[i]) then
    begin
      isFoodSel := True;
      Break;
    end;
  if ((PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) = MB_SOBH) then
    isFoodSel := True;
  dblCount := IsPersonServed(PersonFish.Fish_PCode, PersonFish.Fish_Date, PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3);
//  if p.P_BarCode = '' then
  if not p.P_exist then
  begin
    {Invalid card}
    CreateOnLineFish := 1;
    Exit;
  end
  else if not p.P_Isvalid then
  begin
    {Invalid card - no transmit}
    CreateOnLineFish := 12;
    Exit;
  end
  else if not p.P_IsGuest and isFoodSel and
          (dblCount >= 1)  and
          ((F_Params.SecondFoodPrcPerson < 0) or not p.P_DblFood or (dblcount>p.P_dblFoodMax)) then
  begin
    {don't serve another food}
    CreateOnLineFish := 5;
    Exit;
  end
  else if p.P_IsGuest and isFoodSel and
          (dblCount >= 1) and
          ((F_Params.SecondFoodPrcGuest < 0) or not p.P_DblFood or (dblcount>p.P_dblFoodMax)) then
  begin
    {don't serve another food}
    CreateOnLineFish := 5;
    Exit;
  end
  else if not p.P_Vadeh[PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3] then
  begin
    {person don't select this vadeh}
    CreateOnLineFish := 9;
    Exit;
  end
  else if not p.P_IsGuest and p.P_ValidTest and not PersonArived(p.P_Proxi,PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) then
  begin
    {person not arived}
    CreateOnLineFish := 2;
    if AutoCONTROL = 1 then
      Exit;
//    frmFishLst.ViewFish(PersonFish, p, 2);
  end
  else if (not p.P_IsGuest) and (p.P_ShiftGroup <> 0) and
          ((KEY2VADEH[DayGroup.code] AND Pow2(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3)) = 0) and
          (GetAddWork(p.P_BarCode) <> PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) then
  begin
    {Personel group not serve this vadeh and not in AddWork}
    if F_Params.kasr = mb_false then
    begin
      CreateOnLineFish := 13;
      Exit;
    end
    else
      F_Params.kasrshavad := true;
  end;
  if result = 0 then
  begin
    case PersonFish.Fish_Type of
      MB_NAHAR: j := F_Params.NaharKeyNo;
      MB_SHAM : j := F_Params.ShamKeyNo;
      else      j := 0;
    end;
    FoodN := 0;
    for i := 1 to j do
    begin
      if (PersonFish.Fish_Foods[i] <> 0) and (FoodN > 0) then
      begin
        {Can not select any Foods}
        CreateOnLineFish := 4;
        Exit;
      end
      else if PersonFish.Fish_Foods[i] <> 0 then
        Inc(FoodN);
    end;
  end;
end;

{ Save fish in database }
procedure SaveFish(var PersonFish : TFish);
var
  i, n, j : integer;
  strColfood : string; //kaveh
  var p : TPerson;
  adoQryFish,adoQryFishFood,tblperpaid : TADOQuery;
  Sumfish : Currency;
  saveColMnt : Boolean; //kaveh
  
  function  RegisterFishNo(iDate : String; Vadeh : Byte):integer;
  var
    fishNo : integer;
    qry : TADOQuery;
  begin
    result := -1;
    qry := TADOQuery.Create(Application);
    qry.Connection := frmDBS.DBConnection;
    repeat
      try
        LoadFishsNo(iDate);
        case Vadeh of
          MB_SOBH : fishNo := Sobh_Fish_No + 1;
          MB_Nahar : fishNo := Nahar_Fish_No + 1;
          MB_SHAM : fishNo := Sham_Fish_No + 1;
          MB_SOBHNEXT : fishNo := SobhNext_Fish_No + 1;
        end;
        with qry do
        begin
          with SQL do
          begin
            Clear;
            Add('Insert into fish (Fish_No,Fish_Type,Fish_Date)');
            Add('values(' + IntToStr(fishNo) + ',' + inttostr(Vadeh) + ',''' + iDate + ''')');
            ExecSQL;
          end;
        end;
        Result := fishNo;
      except
      end;
    until result>=0;
  end;
begin
  adoQryFish := TADOQuery.Create(Application);
  adoQryFish.Connection := frmDBS.DBConnection;
  adoQryFishFood := TADOQuery.Create(Application);
  adoQryFishFood.Connection := frmDBS.DBConnection;

//  frmDBS.tblFish.Open;
//  frmDBS.tblFishFood.Open;
  for n := 1 to PersonFish.ManySel do
  begin
{$ifdef OperatorBase}
    PersonFish.Fish_No := RegisterFishNo(PersonFish.Fish_Date, (PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3));
{$else OperatorBase}
    Inc(PersonFish.Fish_No);
{$endif OperatorBase}
    Inc(PersonFish.Fish_RdrFishNo); //kaveh
    with adoQryFish do
    begin
      with SQL do
      begin
        Clear;
{$ifdef OperatorBase}
        Add(' Update fish set ');
        Add(' Fish_rdrFishNo = ' + IntToStr(PersonFish.Fish_RdrFishNo) + ',');
        Add(' Fish_Time = ''' + PersonFish.Fish_Time + ''',');
        Add(' Fish_PCode = ''' + PersonFish.Fish_PCODE + ''',');
        Add(' Fish_RdrCode = ' + IntToStr(PersonFish.Fish_RdrCode) + ',');
        Add(' Fish_UCode = ' + IntToStr(PersonFish.Fish_UCode) + ',');
        Add(' Fish_UKhadamat = ' + IntToStr(PersonFish.Fish_UKhadamat) + ',');
        Add(' Fish_UPrc = ' + CurrToStr(PersonFish.Fish_UPrc) + ',');
        Add(' Fish_UPay = ' + CurrToStr(PersonFish.Fish_UPay));
        Add(' where Fish_No = ' + inttostr(PersonFish.Fish_No) + ' and Fish_Type = ' + IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' and Fish_Date = ''' + PersonFish.Fish_Date + '''' );
{$else OperatorBase}
        Add('Insert into fish (Fish_No,Fish_rdrFishNo,Fish_Type,Fish_Date,Fish_Time,Fish_PCode,Fish_RdrCode,Fish_UCode,Fish_UKhadamat,Fish_UPrc,Fish_UPay)');
        add('values(' + IntToStr(PersonFish.Fish_No) + ',' +
                        IntToStr(PersonFish.Fish_RdrFishNo) + ',' +
                        IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' , ''' +
                        PersonFish.Fish_Date + ''' , ''' +
                        PersonFish.Fish_Time + ''',''' +
                        PersonFish.Fish_PCODE + ''',' +
                        IntToStr(PersonFish.Fish_RdrCode) + ',' +
                        IntToStr(PersonFish.Fish_UCode) + ',' +
                        IntToStr(PersonFish.Fish_UKhadamat) + ',' +
                        CurrToStr(PersonFish.Fish_UPrc) + ',' +
                        CurrToStr(PersonFish.Fish_UPay) +
                        ')');
{$endif OperatorBase}
        ExecSQL;
      end;

      if PersonFish.Fish_Time=''
        then PersonFish.Fish_Time:=currenttime;
      if (frmMain.mnuFishLst1.Enabled) and (frmMain.mnuFishLst1.Visible) then
      begin
        with SQL do
        begin
          Clear;
          strColfood := '';
          if PersonFish.Fish_Foods[1] <> 0 then
            strColfood := GetFoodNameInDB(PersonFish.Fish_Foods[1]) + '-';
          if PersonFish.Fish_Foods[2] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[2]) + '-';
          if PersonFish.Fish_Foods[3] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[3]) + '-';
          if PersonFish.Fish_Foods[4] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[4]) + '-';
          if PersonFish.Fish_Foods[5] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[5]) + '-';
          if PersonFish.Fish_Foods[6] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[6]) + '-';
          if PersonFish.Fish_Foods[7] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[7]) + '-';
          if PersonFish.Fish_Foods[8] <> 0 then
            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[8]);
          if RightStr(strColfood,1) = '-' then
            strColfood := LeftStr(strColfood,Length(strColfood)-1);
          Add('Insert into collect (col_FishNo,col_pno,col_familyname,col_reader,col_food,col_date,col_time)');
          add('values(''' + IntToStr(PersonFish.Fish_No) + ''',''' +
                          PersonFish.Fish_PCODE + ''',''' +
                          GetPersonFamilyName(PersonFish.Fish_PCODE) + ''',''' +
                          GetReaderName(PersonFish.Fish_RdrCode) + ''',''' +
                          strColfood + ''',''' + //kaveh
//kaveh                          GetFoodNameInDB(PersonFish.Fish_Foods[1]) + ''',''' +
                          PersonFish.Fish_Date + ''' , ''' +
                          PersonFish.Fish_Time +''''+
                          ')');
          ExecSQL;
        end;
      end;
//kaveh is
{$ifdef OperatorBase}
      saveColMnt := False;
      case PersonFish.Fish_Type of
        MB_NAHAR: j := F_Params.NaharKeyNo;
        MB_SHAM : j := F_Params.ShamKeyNo;
        else      j := 0;
      end;
      for i := 1 to j do
      begin
        if PersonFish.Fish_Foods[i] <> 0 then
          saveColMnt := True;
      end;
      if saveColMnt then
      begin
        with SQL do
        begin
          Clear;
          Add('if not exists (select ColMnt_PCode from collectMnt where ');
          Add('(ColMnt_PCode = ''' + PersonFish.Fish_PCODE + ''' and ');
          Add('ColMnt_Date = ''' + PersonFish.Fish_Date + ''' and ');
          Add('ColMnt_Type = ' + IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' and ');
          Add('ColMnt_RdrCode = ' + IntToStr(PersonFish.Fish_RdrCode) + '))');
          Add('Insert into collectMnt (ColMnt_PCode, ColMnt_Date, ColMnt_Type, ColMnt_RdrCode)');
          Add('values(''' + PersonFish.Fish_PCODE + ''', ''' +
                          PersonFish.Fish_Date + ''', ' +
                          IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ', ' +
                          IntToStr(PersonFish.Fish_RdrCode) +
                          ')');
          ExecSQL;
        end;
      end;
{$endif OperatorBase}
//kaveh ie
    end;
    Sumfish := 0;
    for i:= 1 to 8 do
      Sumfish:= Sumfish + PersonFish.Fish_Price[i];

//**********************these operation handled with Triggers*************************************************
//    if PersonFish.prepaid= true  then
//    begin
//      tblperpaid:=TADOQuery.Create(tblperpaid);
//      tblperpaid.Connection:=frmDBS.DBConnection;
//      tblperpaid.close;
//      tblperpaid.SQL.Clear;
//      tblperpaid.SQL.add('select * from persons where p_barcode='+''''+ PersonFish.Fish_PCode +'''');
//      tblperpaid.Open;
//      tblperpaid.Edit;
//      tblperpaid.FieldByName('p_credit').AsCurrency := tblperpaid.FieldByName('p_credit').AsCurrency - sumfish;
//      tblperpaid.Post;
//    end;
//**********************these operation handled with Triggers*************************************************


{    frmDBS.tblFish.Append;
    frmDBS.tblFish.FieldByName('Fish_No').AsInteger := PersonFish.Fish_No;
    frmDBS.tblFish.FieldByName('Fish_Type').AsInteger := PersonFish.Fish_Type;
    frmDBS.tblFish.FieldByName('Fish_Date').AsString := PersonFish.Fish_Date;
    frmDBS.tblFish.FieldByName('Fish_Time').AsString := PersonFish.Fish_Time;
    frmDBS.tblFish.FieldByName('Fish_PCode').AsString := PersonFish.Fish_PCode;
    frmDBS.tblFish.FieldByName('Fish_RdrCode').AsInteger := PersonFish.Fish_RdrCode;
    frmDBS.tblFish.FieldByName('Fish_UCode').AsInteger := PersonFish.Fish_UCode;
    frmDBS.tblFish.FieldByName('Fish_UKhadamat').AsInteger := PersonFish.Fish_UKhadamat;
    frmDBS.tblFish.FieldByName('Fish_UPrc').AsCurrency := PersonFish.Fish_UPrc;
    frmDBS.tblFish.FieldByName('Fish_UPay').AsCurrency := PersonFish.Fish_UPay;
    frmDBS.tblFish.Post;
}

    for i := 1 to 8 do
    begin
      if PersonFish.Fish_Foods[i] <> 0 then
      begin
        with adoQryFish do
        begin
          with SQL do
          begin
            Clear;
            Add('Insert into fishfood (FF_FishNo,FF_Type,FF_Date,FF_Food,FF_No,FF_Price,FF_Pay)');
            Add('values(' + IntToStr(PersonFish.Fish_No)         + ',' +
                            IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3)       + ' , ''' +
                            PersonFish.Fish_Date                 + ''' ,' +
                            inttostr(PersonFish.Fish_Foods[i])   + ',' +
                            inttostr(PersonFish.Fish_FoodsNo[i]) + ','
            );
            if PersonFish.IsPayed then
              Add('0 , ' + CurrToStr(PersonFish.Fish_Price[i]) + ')')
            else
              Add(CurrToStr(PersonFish.Fish_Price[i]) + ', 0)');
            ExecSQL;
          end;
        end;
{
        frmDBS.tblFishFood.Append;
        frmDBS.tblFishFood.FieldByName('FF_FishNo').AsInteger := PersonFish.Fish_No;
        frmDBS.tblFishFood.FieldByName('FF_Type').AsInteger := PersonFish.Fish_Type;
        frmDBS.tblFishFood.FieldByName('FF_Date').AsString := PersonFish.Fish_Date;
        frmDBS.tblFishFood.FieldByName('FF_Food').AsInteger := PersonFish.Fish_Foods[i];
        frmDBS.tblFishFood.FieldByName('FF_No').AsInteger := PersonFish.Fish_FoodsNo[i];
        if PersonFish.IsPayed then
        begin
          frmDBS.tblFishFood.FieldByName('FF_Price').AsCurrency := 0;
          frmDBS.tblFishFood.FieldByName('FF_Pay').AsCurrency := PersonFish.Fish_Price[i]
        end
        else
        begin
          frmDBS.tblFishFood.FieldByName('FF_Price').AsCurrency := PersonFish.Fish_Price[i];
          frmDBS.tblFishFood.FieldByName('FF_Pay').AsCurrency := 0;
        end;
        frmDBS.tblFishFood.Post;
}
        UsedFoods[PersonFish.Fish_Type][i] := UsedFoods[PersonFish.Fish_Type][i] + PersonFish.Fish_FoodsNo[i];
      end;
    end;

    case PersonFish.Fish_Type of
      MB_SOBH : Inc(Sobh_Fish_No);
      MB_Nahar : Inc(Nahar_Fish_No);
      MB_SHAM : Inc(Sham_Fish_No);
      MB_SOBHNEXT : Inc(SobhNext_Fish_No);
    end;
  end;
//  frmDBS.tblFish.Close;
//  frmDBS.tblFishFood.Close;
end;

{ Save Error Logs in database }
procedure SaveErrorLog(PersonFish : TFish; p : TPerson; ErrTest : Byte);
var
  {i,} n{, j} : integer;
//  strColfood : string;
//  var p : TPerson;
  adoQryErrLog{adoQryFish,adoQryFishFood,tblperpaid} : TADOQuery;
//  Sumfish : Currency;
//  saveColMnt : Boolean;
//



//  function  RegisterFishNo(iDate : String; Vadeh : Byte):integer;
//  var
//    fishNo : integer;
//    qry : TADOQuery;
//  begin
//    result := -1;
//    qry := TADOQuery.Create(Application);
//    qry.Connection := frmDBS.DBConnection;
//    repeat
//      try
//        LoadFishsNo(iDate);
//        case Vadeh of
//          MB_SOBH : fishNo := Sobh_Fish_No + 1;
//          MB_Nahar : fishNo := Nahar_Fish_No + 1;
//          MB_SHAM : fishNo := Sham_Fish_No + 1;
//          MB_SOBHNEXT : fishNo := SobhNext_Fish_No + 1;
//        end;
//        with qry do
//        begin
//          with SQL do
//          begin
//            Clear;
//            Add('Insert into fish (Fish_No,Fish_Type,Fish_Date)');
//            Add('values(' + IntToStr(fishNo) + ',' + inttostr(Vadeh) + ',''' + iDate + ''')');
//            ExecSQL;
//          end;
//        end;
//        Result := fishNo;
//      except
//      end;
//    until result>=0;
//  end;
begin
  adoQryErrLog := TADOQuery.Create(Application);
  adoQryErrLog.Connection := frmDBS.DBConnection;
  if PersonFish.ManySel = 0 then
    PersonFish.ManySel := 1;
  for n := 1 to PersonFish.ManySel do
  begin
    with adoQryErrLog do
    begin
      with SQL do
      begin
        Clear;
        Add('Insert into errorlogs (ErrLog_PNo, ErrLog_FamilyName, ErrLog_Reader, ErrLog_Caption, ErrLog_Date, ErrLog_Time) ');
        Add('values(''' + PersonFish.Fish_PCODE + ''',''' +
                          GetPersonFamilyName(PersonFish.Fish_PCODE) + ''',''' +
                          GetReaderName(PersonFish.Fish_RdrCode) + ''',''' +
                          ErrMsg[ErrTest] + ''',''' +
                          PersonFish.Fish_Date + ''' , ''' +
                          PersonFish.Fish_Time +''''+
                          ')');
        ExecSQL;        
      end;
    end;
  end;
  adoQryErrLog.Close;
  adoQryErrLog.Free;
  
//  adoQryFishFood := TADOQuery.Create(Application);
//  adoQryFishFood.Connection := frmDBS.DBConnection;

////  frmDBS.tblFish.Open;
////  frmDBS.tblFishFood.Open;
//  for n := 1 to PersonFish.ManySel do
//  begin
//{$ifdef OperatorBase}
//    PersonFish.Fish_No := RegisterFishNo(PersonFish.Fish_Date, (PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3));
//{$else OperatorBase}
//    Inc(PersonFish.Fish_No);
//{$endif OperatorBase}
//    Inc(PersonFish.Fish_RdrFishNo);
//    with adoQryFish do
//    begin
//      with SQL do
//      begin
//        Clear;
//{$ifdef OperatorBase}
//        Add(' Update fish set ');
//        Add(' Fish_rdrFishNo = ' + IntToStr(PersonFish.Fish_RdrFishNo) + ',');
//        Add(' Fish_Time = ''' + PersonFish.Fish_Time + ''',');
//        Add(' Fish_PCode = ''' + PersonFish.Fish_PCODE + ''',');
//        Add(' Fish_RdrCode = ' + IntToStr(PersonFish.Fish_RdrCode) + ',');
//        Add(' Fish_UCode = ' + IntToStr(PersonFish.Fish_UCode) + ',');
//        Add(' Fish_UKhadamat = ' + IntToStr(PersonFish.Fish_UKhadamat) + ',');
//        Add(' Fish_UPrc = ' + CurrToStr(PersonFish.Fish_UPrc) + ',');
//        Add(' Fish_UPay = ' + CurrToStr(PersonFish.Fish_UPay));
//        Add(' where Fish_No = ' + inttostr(PersonFish.Fish_No) + ' and Fish_Type = ' + IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' and Fish_Date = ''' + PersonFish.Fish_Date + '''' );
//{$else OperatorBase}
//        Add('Insert into fish (Fish_No,Fish_rdrFishNo,Fish_Type,Fish_Date,Fish_Time,Fish_PCode,Fish_RdrCode,Fish_UCode,Fish_UKhadamat,Fish_UPrc,Fish_UPay)');
//        add('values(' + IntToStr(PersonFish.Fish_No) + ',' +
//                        IntToStr(PersonFish.Fish_RdrFishNo) + ',' +
//                        IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' , ''' +
//                        PersonFish.Fish_Date + ''' , ''' +
//                        PersonFish.Fish_Time + ''',''' +
//                        PersonFish.Fish_PCODE + ''',' +
//                        IntToStr(PersonFish.Fish_RdrCode) + ',' +
//                        IntToStr(PersonFish.Fish_UCode) + ',' +
//                        IntToStr(PersonFish.Fish_UKhadamat) + ',' +
//                        CurrToStr(PersonFish.Fish_UPrc) + ',' +
//                        CurrToStr(PersonFish.Fish_UPay) +
//                        ')');
//{$endif OperatorBase}
//        ExecSQL;
//      end;
//
//      if PersonFish.Fish_Time=''
//        then PersonFish.Fish_Time:=currenttime;
//      if (frmMain.mnuFishLst1.Enabled) and (frmMain.mnuFishLst1.Visible) then
//      begin
//        with SQL do
//        begin
//          Clear;
//          strColfood := '';
//          if PersonFish.Fish_Foods[1] <> 0 then
//            strColfood := GetFoodNameInDB(PersonFish.Fish_Foods[1]) + '-';
//          if PersonFish.Fish_Foods[2] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[2]) + '-';
//          if PersonFish.Fish_Foods[3] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[3]) + '-';
//          if PersonFish.Fish_Foods[4] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[4]) + '-';
//          if PersonFish.Fish_Foods[5] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[5]) + '-';
//          if PersonFish.Fish_Foods[6] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[6]) + '-';
//          if PersonFish.Fish_Foods[7] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[7]) + '-';
//          if PersonFish.Fish_Foods[8] <> 0 then
//            strColfood := strColfood + GetFoodNameInDB(PersonFish.Fish_Foods[8]);
//          if RightStr(strColfood,1) = '-' then
//            strColfood := LeftStr(strColfood,Length(strColfood)-1);
//          Add('Insert into collect (col_FishNo,col_pno,col_familyname,col_reader,col_food,col_date,col_time)');
//          add('values(''' + IntToStr(PersonFish.Fish_No) + ''',''' +
//                          PersonFish.Fish_PCODE + ''',''' +
//                          GetPersonFamilyName(PersonFish.Fish_PCODE) + ''',''' +
//                          GetReaderName(PersonFish.Fish_RdrCode) + ''',''' +
//                          strColfood + ''',''' +
////                          GetFoodNameInDB(PersonFish.Fish_Foods[1]) + ''',''' +
//                          PersonFish.Fish_Date + ''' , ''' +
//                          PersonFish.Fish_Time +''''+
//                          ')');
//          ExecSQL;
//        end;
//      end;
//
//{$ifdef OperatorBase}
//      saveColMnt := False;
//      case PersonFish.Fish_Type of
//        MB_NAHAR: j := F_Params.NaharKeyNo;
//        MB_SHAM : j := F_Params.ShamKeyNo;
//        else      j := 0;
//      end;
//      for i := 1 to j do
//      begin
//        if PersonFish.Fish_Foods[i] <> 0 then
//          saveColMnt := True;
//      end;
//      if saveColMnt then
//      begin
//        with SQL do
//        begin
//          Clear;
//          Add('if not exists (select ColMnt_PCode from collectMnt where ');
//          Add('(ColMnt_PCode = ''' + PersonFish.Fish_PCODE + ''' and ');
//          Add('ColMnt_Date = ''' + PersonFish.Fish_Date + ''' and ');
//          Add('ColMnt_Type = ' + IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ' and ');
//          Add('ColMnt_RdrCode = ' + IntToStr(PersonFish.Fish_RdrCode) + '))');
//          Add('Insert into collectMnt (ColMnt_PCode, ColMnt_Date, ColMnt_Type, ColMnt_RdrCode)');
//          Add('values(''' + PersonFish.Fish_PCODE + ''', ''' +
//                          PersonFish.Fish_Date + ''', ' +
//                          IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3) + ', ' +
//                          IntToStr(PersonFish.Fish_RdrCode) +
//                          ')');
//          ExecSQL;
//        end;
//      end;
//{$endif OperatorBase}
//
//    end;
//    Sumfish := 0;
//    for i:= 1 to 8 do
//      Sumfish:= Sumfish + PersonFish.Fish_Price[i];
//
////**********************these operation handled with Triggers*************************************************
////    if PersonFish.prepaid= true  then
////    begin
////      tblperpaid:=TADOQuery.Create(tblperpaid);
////      tblperpaid.Connection:=frmDBS.DBConnection;
////      tblperpaid.close;
////      tblperpaid.SQL.Clear;
////      tblperpaid.SQL.add('select * from persons where p_barcode='+''''+ PersonFish.Fish_PCode +'''');
////      tblperpaid.Open;
////      tblperpaid.Edit;
////      tblperpaid.FieldByName('p_credit').AsCurrency := tblperpaid.FieldByName('p_credit').AsCurrency - sumfish;
////      tblperpaid.Post;
////    end;
////**********************these operation handled with Triggers*************************************************
//
//
//{    frmDBS.tblFish.Append;
//    frmDBS.tblFish.FieldByName('Fish_No').AsInteger := PersonFish.Fish_No;
//    frmDBS.tblFish.FieldByName('Fish_Type').AsInteger := PersonFish.Fish_Type;
//    frmDBS.tblFish.FieldByName('Fish_Date').AsString := PersonFish.Fish_Date;
//    frmDBS.tblFish.FieldByName('Fish_Time').AsString := PersonFish.Fish_Time;
//    frmDBS.tblFish.FieldByName('Fish_PCode').AsString := PersonFish.Fish_PCode;
//    frmDBS.tblFish.FieldByName('Fish_RdrCode').AsInteger := PersonFish.Fish_RdrCode;
//    frmDBS.tblFish.FieldByName('Fish_UCode').AsInteger := PersonFish.Fish_UCode;
//    frmDBS.tblFish.FieldByName('Fish_UKhadamat').AsInteger := PersonFish.Fish_UKhadamat;
//    frmDBS.tblFish.FieldByName('Fish_UPrc').AsCurrency := PersonFish.Fish_UPrc;
//    frmDBS.tblFish.FieldByName('Fish_UPay').AsCurrency := PersonFish.Fish_UPay;
//    frmDBS.tblFish.Post;
//}
//
//    for i := 1 to 8 do
//    begin
//      if PersonFish.Fish_Foods[i] <> 0 then
//      begin
//        with adoQryFish do
//        begin
//          with SQL do
//          begin
//            Clear;
//            Add('Insert into fishfood (FF_FishNo,FF_Type,FF_Date,FF_Food,FF_No,FF_Price,FF_Pay)');
//            Add('values(' + IntToStr(PersonFish.Fish_No)         + ',' +
//                            IntToStr(PersonFish.Fish_Type - (PersonFish.Fish_Type DIV 4)*3)       + ' , ''' +
//                            PersonFish.Fish_Date                 + ''' ,' +
//                            inttostr(PersonFish.Fish_Foods[i])   + ',' +
//                            inttostr(PersonFish.Fish_FoodsNo[i]) + ','
//            );
//            if PersonFish.IsPayed then
//              Add('0 , ' + CurrToStr(PersonFish.Fish_Price[i]) + ')')
//            else
//              Add(CurrToStr(PersonFish.Fish_Price[i]) + ', 0)');
//            ExecSQL;
//          end;
//        end;
//{
//        frmDBS.tblFishFood.Append;
//        frmDBS.tblFishFood.FieldByName('FF_FishNo').AsInteger := PersonFish.Fish_No;
//        frmDBS.tblFishFood.FieldByName('FF_Type').AsInteger := PersonFish.Fish_Type;
//        frmDBS.tblFishFood.FieldByName('FF_Date').AsString := PersonFish.Fish_Date;
//        frmDBS.tblFishFood.FieldByName('FF_Food').AsInteger := PersonFish.Fish_Foods[i];
//        frmDBS.tblFishFood.FieldByName('FF_No').AsInteger := PersonFish.Fish_FoodsNo[i];
//        if PersonFish.IsPayed then
//        begin
//          frmDBS.tblFishFood.FieldByName('FF_Price').AsCurrency := 0;
//          frmDBS.tblFishFood.FieldByName('FF_Pay').AsCurrency := PersonFish.Fish_Price[i]
//        end
//        else
//        begin
//          frmDBS.tblFishFood.FieldByName('FF_Price').AsCurrency := PersonFish.Fish_Price[i];
//          frmDBS.tblFishFood.FieldByName('FF_Pay').AsCurrency := 0;
//        end;
//        frmDBS.tblFishFood.Post;
//}
//        UsedFoods[PersonFish.Fish_Type][i] := UsedFoods[PersonFish.Fish_Type][i] + PersonFish.Fish_FoodsNo[i];
//      end;
//    end;
//
//    case PersonFish.Fish_Type of
//      MB_SOBH : Inc(Sobh_Fish_No);
//      MB_Nahar : Inc(Nahar_Fish_No);
//      MB_SHAM : Inc(Sham_Fish_No);
//      MB_SOBHNEXT : Inc(SobhNext_Fish_No);
//    end;
//  end;
////  frmDBS.tblFish.Close;
////  frmDBS.tblFishFood.Close;
end;

(******************** frmDBS members body ********************)

procedure TfrmDBS.FormCreate(Sender: TObject);
begin
  //SetFontColor(TForm(frmDBS));
  LoadDBSInfo;
end;

procedure TfrmDBS.FormActivate(Sender: TObject);
begin
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);

  rdoDBS.ItemIndex := dbsInfo.dbsType - DBS_ACCESS;
  if dbsInfo.dbsType = DBS_ACCESS then
    txtPath.Text := dbsInfo.dbsPath + dbsInfo.dbsName
  else
  begin
    txtPath.Text := dbsInfo.dbsPath;
    txtDBSName.Text := dbsInfo.dbsName;
  end;
  rdoDBSClick(Sender);
end;

procedure TfrmDBS.rdoDBSClick(Sender: TObject);
begin
  case rdoDBS.ItemIndex of
    DBS_ACCESS-1: //M.S. Access
    begin
      lbl1.Caption := ('„”Ì— »«‰ﬂ «ÿ·«⁄« Ì');
      btnPath.Visible := True;
      lbl2.Visible := False;
      txtDBSName.Visible := False;

      lbl3.Visible := False;
      txtUser.Visible := False;
      lbl4.Visible := False;
      txtPass.Visible := False;
    end;

    DBS_SQLSERVER-1: //SQL Server 2000
    begin
      lbl1.Caption := ('‰«„ ”—ÊÌ” œÂ‰œÂ');
      btnPath.Visible := False;
      lbl2.Visible := True;
      lbl2.Caption := ('‰«„ »«‰ﬂ «ÿ·«⁄« Ì');
      txtDBSName.Visible := True;

      lbl3.Visible := True;
      txtUser.Visible := True;
      lbl4.Visible := True;
      txtPass.Visible := True;
    end;

  end;
end;

procedure TfrmDBS.UpgradeFishTbl;
var
  aqry : TADOQuery;
begin
  try
    aQry := TADOQuery.Create(Application);
    with aQry do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('select top(1) * from fish');
      Open;
      if FindField('fish_rdrFishNo') = nil then
      begin
        Close;
        sql.clear;
        sql.Add('alter table fish add fish_rdrFishNo smallint Null');
        ExecSQL;
        SQL.Clear;
      end;
      Close;
    end;
  Except
    on e : exception do ErrorMessage(e.Message);
  end;
end;

procedure TfrmDBS.btnOKClick(Sender: TObject);
var
  f : TextFile;
  err : String;
  Catalog: _Catalog;
begin
  dbsInfo.dbsType := rdoDBS.ItemIndex + DBS_ACCESS;
  txtPath.Text := UpperCase(txtPath.Text);

  if (dbsInfo.dbsType = DBS_ACCESS) and (txtPath.Text = '') then
  begin
    ErrorMessage('„”Ì— »«‰ﬂ «ÿ·«⁄« Ì Ê«—œ ‰‘œÂ «” !');
    txtPath.SetFocus;
  end
  else if (dbsInfo.dbsType = DBS_ACCESS) and (Pos('.MDB', txtPath.Text) = 0) then
  begin
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì „‘Œ’ ‰‘œÂ «” !');
    txtPath.SetFocus;
  end
  else if (dbsInfo.dbsType = DBS_SQLSERVER) and (txtPath.Text = '') then
  begin
    ErrorMessage('”—ÊÌ” œÂ‰œÂ „‘Œ’ ‰‘œÂ «” !');
    txtPath.SetFocus;
  end
  else if (dbsInfo.dbsType = DBS_SQLSERVER) and (txtDBSName.Text = '') then
  begin
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì „‘Œ’ ‰‘œÂ «” !');
    txtDBSName.SetFocus;
  end
  else if (dbsInfo.dbsType = DBS_SQLSERVER) and (txtUser.Text = '') then
  begin
    ErrorMessage('ﬂ«—»— »«‰ﬂ «ÿ·«⁄« Ì „‘Œ’ ‰‘œÂ «” !');
    txtUser.SetFocus;
  end
  else
  begin
    if dbsInfo.dbsType = DBS_ACCESS then
    begin
      dbsInfo.dbsPath := ExtractFilePath(txtPath.Text);
      dbsInfo.dbsName := ExtractFileName(txtPath.Text);
      g_Options.DataBasePath := dbsInfo.dbsPath;
      dbsInfo.dbsUser := '';
      dbsInfo.dbsPass := '';
    end
    else
    begin
      dbsInfo.dbsPath := txtPath.Text;
      dbsInfo.dbsName := txtDBSName.Text;
      dbsInfo.dbsUser := txtUser.Text;
      dbsInfo.dbsPass := txtPass.Text;
    end;

    err := DBSConnect;
    if err = '»«“ê‘«ÌÌ »«‰ﬂ «ÿ·«⁄« Ì „Ì”— ‰Ì” .' then
    begin
      if ConfirmMessage('»«‰ﬂ «ÿ·«⁄« Ì ÊÃÊœ ‰œ«—œ. ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« «ÌÃ«œ ‰„«ÌÌœø') then
      begin
        if dbsInfo.dbsType = DBS_ACCESS then
        begin
          Catalog := CoCatalog.Create;
          Catalog.Create(dtaSrc);
        end
        else if dbsInfo.dbsType = DBS_SQLSERVER then
        begin
          adoQryG.ConnectionString := {'Provider=SQLOLEDB.1;' +
                                      'Persist Security Info=False;' +
                                      'Integrated Security=SSPI;' +
                                      'Data Source=' + dbsInfo.dbsPath;}
                                      'Provider=SQLOLEDB.1;' +
                                      'Persist Security Info=False;' +
                                      'User ID=' + dbsInfo.dbsUser + ';' +
                                      'Password=' + dbsInfo.dbsPass + ';' +
                                      'Data Source=' + dbsInfo.dbsPath;
          adoQryG.SQL.Clear;
          adoQryG.SQL.Add('CREATE DATABASE ' + dbsInfo.dbsName);
          adoQryG.SQL.Add('COLLATE Arabic_CI_AI');
          adoQryG.ExecSQL;
          adoQryG.ConnectionString := '';
          adoQryG.Connection := DBConnection;
        end;

//        CreateAllTables;

        btnOKClick(Sender);
      end
      else
        ErrorMessage('« ’«· »Â »«‰ﬂ «ÿ·«⁄« Ì „Ì”— ‰Ì” !');
    end
    else if err = '' then
    begin
      AssignFile(f, g_Options.ProgramPath + 'DBSType.Dta');
      Rewrite(f);
      Writeln(f, dbsInfo.dbsType);
      Writeln(f, dbsInfo.dbsName);
      Writeln(f, dbsInfo.dbsPath);
      Writeln(f, dbsInfo.dbsUser);
      Writeln(f, dbsInfo.dbsPass);
      CloseFile(f);
      retCode := 1;
      Close;
    end
    else
      ErrorMessage(err);
  end;
end;

procedure TfrmDBS.btnPathClick(Sender: TObject);
begin
  opnFile.InitialDir := g_Options.ProgramPath;
  if opnFile.Execute then
    txtPath.Text := opnFile.FileName;
end;


procedure TfrmDBS.btnCancelClick(Sender: TObject);
begin
  retCode := 0;
  Close;
end;

procedure TfrmDBS.FormShow(Sender: TObject);
begin
  Caption := (Caption);
  rdoDBS.Caption := (rdoDBS.Caption);
  btnOK.Caption := (btnOK.Caption);
  btnCancel.Caption := (btnCancel.Caption);
end;


procedure blankshift(var shift:shift3type);
var
   j:byte;
begin
   for j:=1 to 3 do
   begin
       shift[j].ftime:=0;
       shift[j].etime:=0;
   end;
end;

procedure LoadShifts;
var
//  adoShTable : TADOTable;
  adoShTable : TADOQuery;
begin
  tshift := 0;
  with shifts[0] do
  begin
      shiftcount:=0;
      shiftname:= ('«” —«Õ  ‘Ì› ');
      shiftcode:=0;
      shiftdaytype:=0;
      blankshift(shift3);
  end;
  with adoShTable do
  begin
//     adoShTable := TADOTable.Create(Application);
     adoShTable := TADOQuery.Create(Application);
     Connection := frmDBS.DBConnection;
//     TableName:='shifts';
     SQL.Clear;
     SQL.Add('select * from shifts ');
     SQL.Add('order by SH_Code ');
     open;
     while not eof do
     begin
        inc(tshift);
        with shifts[tshift] do
        begin
           Shiftcode:=FieldByName('sh_code').AsInteger;
           Shiftcount:=FieldByName('sh_count').AsInteger;
           shiftname:=FieldByName('sh_name').AsString;
           shift3[1].ftime := FieldByName('sh_from1').AsInteger;
           shift3[1].etime := FieldByName('sh_to1').AsInteger;
           shift3[2].ftime := FieldByName('sh_from2').AsInteger;
           shift3[2].etime := FieldByName('sh_to2').AsInteger;
           shift3[3].ftime := FieldByName('sh_from3').AsInteger;
           shift3[3].etime := FieldByName('sh_to3').AsInteger;
           shiftkind := FieldByName('sh_kind').AsInteger;
           shiftnesab := FieldByName('sh_Nesab').AsInteger;
           shiftdaytype := FieldByName('sh_type').AsInteger;
           shiftSobhaneh := FieldByName('sh_sobhaneh').AsBoolean;
           shiftnahar := FieldByName('sh_nahar').AsBoolean;
           shiftSham := FieldByName('sh_sham').AsBoolean;
           shiftnextSobhaneh := FieldByName('sh_nextsobhaneh').AsBoolean;
        end;
        next;
     end;
     close;
     free;
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
             errormessage(' ⁄œ«œ ﬂ«—»—«‰ œ— «Ì‰ “„«‰ »Â Õœ „Ã«“ —”ÌœÂ «” ');
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
             errormessage('ﬂ«—»— œÌê—Ì »« Â„Ì‰ «”„ œ— Õ«· «Ã—«Ì »—‰«„Â «” ');
             exit;
        end
        else begin

        end;
    end;
    if mojaz then refreshUser(true);
    result:=mojaz;
end;

procedure refreshUser(avval:boolean);
var
   ctime    : integer;
   ctimestr : string;
   lasttime :integer;
   pcname   : pansichar;
   psize    : dword;
begin
    ctime:=timetoint(copy(currenttime,1,5));
    ctimestr:=inttostr(ctime);
    pSize := MAX_COMPUTERNAME_LENGTH + 1;
    pcName := strAlloc( pSize );
    if getcomputername(pcname,psize)
    then
    else pcname:='';
    with frmDBS.adoqryg do
    begin
        if not avval
        then begin
            close;
            with sql do
            begin
                clear;
                {$IFDEF Network}
                add('select * from users where username=N'''+g_Options.UserName+'''');
                {$else}
                add('select * from users where username='''+g_Options.UserName+'''');
                {$endif}
            end;
            open;
            lasttime:=fieldbyname('lastaccess').asinteger;
            if lastrefresh<>lasttime
            then begin
                 halt(0);
            end;
        end;

        close;
        with sql do
        begin
            clear;
            add('update users set LastAccess='+ctimestr);
            add(',PCName='''+pcname+'''');
            add(' where username='''+g_Options.UserName+'''');
        end;
        execsql;
    end;
    lastrefresh:=ctime;
end;

procedure EndOfUser;
var
   ctime:integer;
   ctimestr: string;
begin
    ctime:=-100;
    ctimestr:=inttostr(ctime);
    with frmDBS.adoqryg do
    begin
        close;
        with sql do
        begin
            clear;
            add('update users set LastAccess='+ctimestr);
            add('where username='''+g_Options.UserName+'''');
        end;
        execsql;
    end;
end;

function calculgroup(barcode:string):integer;
var
  qry : TAdoQuery;
  i:integer;
begin
   begin
     calculgroup:=0;
     qry := TAdoQuery.Create(Application);
     qry.Connection := frmDBS.DBConnection;

     with qry do
     begin
        with sql do
        begin
            clear;
            add('select * from persons');
            add('where p_Barcode='''+barcode+'''');
        end;
        open;
        if recordcount>0
        then begin
             i:=fieldbyname('p_shiftgroup').asinteger;
             if i<1 then i:=1;
             calculgroup:=i;
        end;
        close;
        free;
     end;
   end;
end;

function findshiftno(shcode:byte):integer;
var
  i:byte;
begin
  begin
    for i:=0 to tshift do
    with shifts[i] do
    if shiftcode=shcode
    then begin
        findshiftno:=i;
        exit;
    end;
    findshiftno:=-1;
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

function GetShiftNo(cardno , date : string) : byte;
var
   tbl:TAdoTable;
   i:integer;
   dy:integer;
   dyst:string[31];
   yrst:string;
   shiftcode,shiftno,spshiftcode:integer;
   mnst:string[2];
begin
   yrst:=copy(date,1,4);

   tbl := TAdoTable.Create(application);
//   tbl.connection := frmDBS.DBConnection;
   tbl.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
                               'Initial Catalog='+F_Params.Clkdatabasename+';'+
                               'Data Source=' + F_Params.ClkServerName +
                               ';User ID=' + F_Params.ClkSqlUseName +
                               ';Password=' + F_Params.ClkSqlPassword;
   tbl.tablename:='grp_dtl';

   yrst:=copy(date,1,4);

   with tbl do
   begin
      close;
      filtered:=False;
      filter:='grd_year='+yrst+' and grd_code= '+ IntToStr(calculgroup(FixLeft((cardno),'0',8))) + ' ';
      filtered:=true;
      open;
      if recordcount=0
      then begin
           close;
           free;
           Result := 0;
           exit;
      end;
   end;
   mnst:=copy(date,6,2);
   if mnst[1]='0' then delete(mnst,1,1);

   dy:=strtoint(copy(date,9,2));
   dyst:=tbl.fieldbyname('grd_m'+mnst).asstring;

   shiftcode:=ord(dyst[dy])-1;

   if shiftcode<>0
   then begin
        shiftno:=findshiftno(shiftcode);
        if shiftno=-1 then shiftno:=0;
   end
   else
     shiftno := 0;

   result := shiftno;
   tbl.close;
   tbl.free;
end;

procedure IsResident(tyesterdayio: integer;
                   yesterdayio : iotypes;
                   ttodayio: integer;
                   todayio : iotypes;
                   sptime : integer;
                   yesterdayshift,todayshift:shifttype;
                   var isready,isreadyday : boolean);
var
    t_hozoors : integer;
    trds : array[1..40] of integer;
    inouts : array[1..20] of shifttype;
    i,j,ttrd,tinout,base,m,ndx1,def1,ndx2,def2 : integer;

function istrueshift(sh: shifttype): boolean;
begin
  result:=true;
  if (sh.ftime=0) and (sh.etime=0)
  then result:=false;
  if sh.etime<=sh.ftime then result:=true;
end;

procedure findbestmatch(time:integer;var ndx,def:integer);
var
  i: integer;
  df: integer;
begin
   def:=10000;
   ndx:=1;
   for I := 1 to ttrd do
   begin
       df:=trds[i]-time;
       if df<0 then df:=-df;
       if df<def
       then begin
            def:=df;
            ndx:=i;
       end;
   end;
end;

begin
    isready:=false;
    isreadyday:=(ttodayio>0); 
    ttrd:=0;
    for I := 1 to tyesterdayio do
    begin
       inc(ttrd);
       trds[ttrd]:=yesterdayio[i];
    end;
    for I := 1 to ttodayio do
    begin
       inc(ttrd);
       trds[ttrd]:=todayio[i]+1440;
    end;
    if ttrd=0
    then begin
         isready:=false;
         exit;
    end
    else begin
      if istrueshift(yesterdayshift)
      then begin
           findbestmatch(yesterdayshift.ftime,ndx1,def1);
           findbestmatch(yesterdayshift.etime,ndx2,def2);
           if def1<def2
           then begin
                if odd(ndx1)
                then base:=1
                else base:=2;
           end
           else begin
                if odd(ndx2)
                then base:=2
                else base:=1;
           end;
      end
      else if istrueshift(todayshifT)
      then begin
           findbestmatch(todayshift.ftime+1440,ndx1,def1);
           findbestmatch(todayshift.etime+1440,ndx2,def2);
           if def1<def2
           then begin
                if odd(ndx1)
                then base:=1
                else base:=2;
           end
           else begin
                if odd(ndx2)
                then base:=2
                else base:=1;
           end;
      end
      else begin
           base:=1;
      end;
      if base=2
      then begin
          for I := ttrd downto 1 do
            trds[i+1]:=trds[i];
          inc(ttrd);
          trds[1]:=-500;
          base:=1;
      end;
      if odd(ttrd)
      then begin
           inc(ttrd);
           trds[ttrd]:=trds[ttrd-1]+500;
           if trds[ttrd]<2880 then trds[ttrd]:=2880;
      end;
      tinout:=ttrd div 2;
      for I := 1 to tinout do
      begin
        inouts[i].ftime:=inouts[i*2-1].ftime;
        inouts[i].etime:=inouts[i*2].etime;
      end;
      for I := 1 to tinout do
      begin
        if sptime >=inouts[i].ftime
        then if sptime<=inouts[i].etime
        then begin
            isready:=true;
            break;
        end;
      end;
    end;
end;

procedure IsResidentPerson(cardno:string;
                     spdate : string;
                     sptime : integer;
                     var isready,isreadyday : boolean;
                     var statday:integer);
var
  qry : TADOQuery;
  filename,filename1 : string;
  fdate,edate : string;
  tyesterdayio: integer;
  yesterdayio : iotypes;
  ttodayio: integer;
  todayio : iotypes;
  yesterdayshift,todayshift:shifttype;
  s : shiftrec;
begin
  statday:=0;
  tyesterdayio:=0;
  ttodayio:=0;
  fdate:=adddate(spdate,-1);
  edate:=spdate;
  filename :='c'+copy(fdate,1,4)+copy(fdate,6,2);
  filename1:='c'+copy(edate,1,4)+copy(edate,6,2);
  qry:=TAdoQuery.Create(application);
//  qry.connection := frmDBS.DBConnection;
  Qry.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
                               'Initial Catalog='+F_Params.Clkdatabasename+';'+
                               'Data Source=' + F_Params.ClkServerName +
                               ';User ID=' + F_Params.ClkSqlUseName +
                               ';Password=' + F_Params.ClkSqlPassword;
  while filename<=filename1 do
  with qry do
  begin
    with sql do
    begin
        clear;
        add('select * from ' + filename + ' ');
        add('where clock_BarCode='''+cardno+'''');
        add('and clock_date >='''+fdate+'''');
        add('and clock_date <='''+spdate+'''');
        add('order by clock_date,clock_time');
    end;
    try
      open;
    except
       isready:=false;
       isreadyday:=false;
       qry.free;
       exit;
    end;
    while not eof do
    begin
      if qry.FieldByName('clock_date').asstring=fdate
      then begin
        if qry.FieldByName('clock_recstate').asinteger in [31..39,41..49,61..79,91]
        then begin

        end
        else begin
           inc(tyesterdayio);
           yesterdayio[tyesterdayio]:=qry.FieldByName('clock_time').asinteger;
        end;
      end
      else begin
        if qry.FieldByName('clock_recstate').asinteger in [31..39,41..49,61..79,91]
        then begin
             statday:=qry.FieldByName('clock_recstate').asinteger;
        end
        else begin
           inc(ttodayio);
           todayio[ttodayio]:=qry.FieldByName('clock_time').asinteger;
        end;
      end;

      next;
    end;
    close;
    filename:=incfilename(filename);
  end;
  qry.free;
  s:=shifts[getshiftno(cardno,fdate)];
  if s.shiftcount=0
  then begin
       yesterdayshift.ftime:=0;
       yesterdayshift.etime:=0;
  end
  else begin
       yesterdayshift.ftime:=s.shift3[1].ftime;
       yesterdayshift.etime:=s.shift3[s.shiftcount].etime;
  end;
  s:=shifts[getshiftno(cardno,edate)];
  if s.shiftcount=0
  then begin
       todayshift.ftime:=0;
       todayshift.etime:=0;
  end
  else begin
       todayshift.ftime:=s.shift3[1].ftime;
       todayshift.etime:=s.shift3[s.shiftcount].etime;
  end;

  IsResident(tyesterdayio,
             yesterdayio ,
             ttodayio,
             todayio,
             sptime ,
             yesterdayshift,todayshift,
             isready,isreadyday);

end;

function noacceptaddwork(cardno:string; spdate : string;var addtime:integer): boolean;
var
  qry : TADOQuery;
  filename : string;
  std : string;
begin
  result:=false;
  addtime:=0;
  qry:=TAdoQuery.Create(application);
//  qry.connection := frmDBS.DBConnection;
  Qry.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
                               'Initial Catalog='+F_Params.Clkdatabasename+';'+
                               'Data Source=' + F_Params.ClkServerName +
                               ';User ID=' + F_Params.ClkSqlUseName +
                               ';Password=' + F_Params.ClkSqlPassword;
  {
  filename :='a'+copy(spdate,1,4)+copy(spdate,6,2);
  with qry do
  begin
    with sql do
    begin
        clear;
        add('select * from ' + filename + ' ');
        add('where E_PCode='''+cardno+'''');
    end;
    try
      open;
    except
       qry.free;
       exit;
    end;
    if not eof
    then begin
      std:='E_D'+copy(spdate,9,2);
      if qry.FieldByName(std).asinteger>0
      then begin
           result:=true;
      end
    end;
    close;
  end;
  }
  filename :='p'+copy(spdate,1,4)+copy(spdate,6,2);
  with qry do
  begin
    with sql do
    begin
        clear;
        add('select * from ' + filename + ' ');
        add('where prc_PCode='''+cardno+'''');
        add('and prc_date='''+spdate+'''');
    end;
    try
      open;
    except
       qry.free;
       exit;
    end;
    if not eof
    then begin
      if qry.FieldByName('Prc_InvalidAddWork').asinteger>0
      then begin
           result:=true;
           addtime:=qry.FieldByName('Prc_InvalidAddWork').asinteger;
      end
    end;
    close;
  end;

  qry.free;

end;

//kaveh is
function getMntCnt(fPCode,fDate : String) : Smallint; //kaveh
//function checkMntCntLmt(fPCode,fDate : String; fType, fRdrCode : Smallint) : Boolean;
var
  qry : TADOQuery;
begin
  getMntCnt := 0;
  qry:=TAdoQuery.Create(application);
  qry.connection := frmDBS.DBConnection;
//  Qry.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
//                               'Initial Catalog='+F_Params.Clkdatabasename+';'+
//                               'Data Source=' + F_Params.ClkServerName +
//                               ';User ID=' + F_Params.ClkSqlUseName +
//                               ';Password=' + F_Params.ClkSqlPassword;
  with qry do
  begin
    with sql do
    begin
      clear;

      Add('select count(ColMnt_PCode) as MntCnt from collectmnt where');
      Add('(ColMnt_PCode = ''' + fPCode + ''') and ');
      Add('(left(ColMnt_Date,7)= ''' + LeftStr(fDate,7) + ''')');

//      Add('select ColMnt_PCode from collectMnt where ');
//      Add('(ColMnt_PCode = ''' + fPCode + ''' and ');
//      Add('ColMnt_Date = ''' + fDate + ''' and ');
//      Add('ColMnt_Type = ' + IntToStr(fType) + ' and ');
//      Add('ColMnt_RdrCode = ' + IntToStr(fRdrCode) + ')');
    end;
    try
      open;
      getMntCnt := FieldByName('MntCnt').AsInteger;
    except
      qry.free;
      exit;
    end;
//    while not eof do
//    begin
  end;

end;
//kaveh ie
end.

