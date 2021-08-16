unit DBS;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Globals, timetool, Variants;

type
  TfrmDBS = class(TForm)
    tblInputCar: TAdoTable;
    tblMachines: TAdoTable;
    qryDBS: TAdoQuery;
    adoConnect: TADOConnection;
    tblPersons: TADOTable;
    tblBarCodes: TADOTable;
    tblBarCodesCard_Code: TStringField;
    tblBarCodesStName: TStringField;
    tblBarCodesCard_State: TSmallintField;
    adoQryG: TADOQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBS: TfrmDBS;



function  ConvertFromWinCode(txt : String) : String;
function  ConvertToWinCode(txt : String) : String;

function  GetNewNumber(tbl, fld : String) : LongInt;
procedure ChangeDBSNum(tbl, fld : String; BefNum, NewNum : LongInt);
procedure ChangeDBSStr(tbl, fld : String; BefStr, NewStr : String);
procedure ChngIntegerField(tbl, fld : String; from, n : Integer);

function  IsExistsRec_Num(tbl, fld : String; fldVal : LongInt) : Boolean;
function  IsExistsRec_Str(tbl, fld, fldVal : String) : Boolean;
function  IsExistsTwoRec_Str(tbl, fld1, fld2, fldVal1, fldVal2 : String) : Boolean;

procedure InitVariables;
function  CarStat(CarNumber, CarCity, CarSerial : String) : Integer;
procedure SetCarStat(CarNumber, CarCity, CarSerial : String);
procedure Load_Cars_Type;

function  CreateTable(tblName : String; IsUpgrade : Boolean) : Boolean;
Procedure UpgradeTable(tblName : string);
function  tblExists(tblName : String): boolean;


{ CarType Procedures }
function  InCircleCarType(TypeCode : Integer) : Boolean;
function  GetTypeCode(TypeName : String) : Integer;
function  TypeCode_Index(TypeCode : Integer) : Byte;
function  FindTypeNo(CarName : String) : Byte;

{ Car Procedures }
function InCircleCar(CarName : String) : Boolean;
function IsExistsCar(tbl, fldNumber, fldCity, fldSerial, Number, City, Serial : String) : Boolean;

{ City Procedure }
function InCircleCity(CityName : String) : Boolean;

{ Color Procedure }
function InCircleColor(ClrName : String) : Boolean;

{ Department Procedure }
function InCircleDepartment(DpmCode : Integer) : Boolean;

{ CoCar Procedure }
function InCircleCoCar(CarNumber, Serial : String) : Boolean;

{ Reader Procedure }
procedure LoadReaders;
function  InCircleReader(ReaderCode : Integer) : Boolean;
function  FindReaderNameIdx(ReaderName : String) : Byte;
function  FindReaderCodeIdx(ReaderCode : Integer) : Byte;

{ Person Procedures }
function InCirclePerson(PersonCode : String) : Boolean;
function GetPersonCode(PersonName : String) : String;
function GetPersonName(PersonCode : String) : String;

{ Capacity Procedure }
function  GetMaxCapacity(CarType : Integer) : Integer;
procedure ResetCapacities;
procedure LoadCapacity;
procedure SetCapacity(CarName : String; T : Integer);
procedure ChngCapacity(CarName : String; t : Integer);

{ BarCode Procedure }
function InCircleCard(CardCode : String) : Boolean;

{ Customs Procedure }
function  InCircleCustoms(CustCode : Integer) : Boolean;
function  InCircleNewPersons(PCode : Integer) : Boolean;
function  GetCustomsRemain(CarNumber, CarCity, CarSerial : String) : Currency;
procedure SetCustomsRemain(CarNumber, CarCity, CarSerial : String; Remain : Currency);
procedure UpdateCustomsRemain(Number, City, Serial : string; Price : Currency);


{ Door Procedure }
function GetDoorCode(DoorName : String) : Integer;
function GetDoorName(DoorCode : Integer) : String;

{ Receipt Processing }
function  SaveInputCarRecord(var rec : TMachines) : Byte; //kaveh
function  SaveInputCarRecordMember(var rec : TMachines) : Byte; //kaveh
function  SaveCollectedRecs(var rec : TMachines) : Byte;
function  UpdateOutputCarRecord(var rec : TMachines) : Byte; //kaveh
function  UpdateOutputCarRecordMember(var rec : TMachines) : Byte; //kaveh
function  CheckCollectedRecsTable() : Boolean; //kaveh
function  UpdateMachinesCount(iDate : String; iDepartment : Integer; var AllParkCou : Integer; var DayParkCou : Integer; var DayAriveCou : Integer; var DayExitCou : Integer) : Boolean;
//function SaveChargeRecord(var rec : TTerminalRec) : boolean;
//function SaveLostCardRecord(var rec : TTerminalRec) : boolean;
//function  ReceiptErrorStr(errCode : Byte) : String;

{ Machines Procedures }
function  GetTakhfif(CarNumber, CarCity, CarSerial : String) : Integer;
function  CalculPrice(CarName, FDate, FTime, ToDate, ToTime : String) : Currency;
procedure CalculPriceField(var m : TMachines);
procedure InputCar(var m : TMachines);
function  UndoInCar(BarCode, IDoor : String) : TMachines;
function  OutputCar(var m : TMachines) : Integer;
function  newOutputCar(var m : TMachines) : Integer;
procedure UpdateOutputCar(var m : TMachines);
procedure newUpdateOutputCar(var m : TMachines);
procedure ChangeKarshenasi(var m : TMachines);
procedure UndoOutcar(number, idoor : String);
procedure AddExitNoCard(m : TMachines);
procedure newAddExitNoCard(m : TMachines);
procedure AddRecToMachine;
procedure DelRecFromMachine;

procedure GetCoCar(BarCode : String; var m : TMachines);
procedure ExitOutputCoCar(m : TMachines);
function  RequestArivalCo(BarCode : String;var m : TMachines) : Boolean;
function  RequestArivalCoByNumber(CarNumber, Serial : String; var m : TMachines) : Boolean;
function  RequestExitCoByNumber(CarNumber, Serial : String; var m : TMachines) : Boolean;
procedure UpdateArivalCo(BarCode : String; m : TMachines);
procedure UpdateArivalCoByNumber(CarNumber, Serial : String; m : TMachines);
procedure LoadExit_Park;


implementation

uses
  Cntroler, DateProc, PlayMSG, RunCmnds, Code_Sys, ComTools, DBLogin;


{$R *.DFM}

(***********************************************************************
  Convert from Windows to DP or Iran System Code
 ***********************************************************************)
function ConvertFromWinCode(txt : String) : String;
begin
  if Readers[FindReaderCodeIdx(curRdrCode)].R_IsReader then
    ConvertFromWinCode := WinToDos(txt, g_options.WinType, DOS_IR_SYS)
  else
    ConvertFromWinCode := WinToDos(txt, g_options.WinType, DOS_DP_SYS)
end;

(***********************************************************************
  Convert DP or Iran System Code to Windows
 ***********************************************************************)
function ConvertToWinCode(txt : String) : String;
begin
  if Readers[FindReaderCodeIdx(curRdrCode)].R_IsReader then
    ConvertToWinCode := DosToWin(txt, DOS_IR_SYS, g_options.WinType)
  else
    ConvertToWinCode := DosToWin(txt, DOS_DP_SYS, g_options.WinType)
end;

procedure TfrmDBS.FormCreate(Sender: TObject);
begin
  DBLinkTest;

  tblInputCar.connection := frmDBS.adoConnect;
  tblMachines.connection := frmDBS.adoConnect;
  tblPersons.connection := frmDBS.adoConnect;
  tblBarCodes.connection := frmDBS.adoConnect;
  qryDBS.connection := frmDBS.adoConnect;

  tblInputCar.TableName := 'InputCar';
  tblMachines.TableName := 'Machines';
  tblPersons.TableName := 'Persons';
  tblBarCodes.TableName := 'BarCodes';

end;

{ return largest number+1 of fld field's from table }
function GetNewNumber(tbl, fld : String) : LongInt;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT MAX(' + fld + ') AS Max_Num FROM ' + tbl);
  qry.Open;
  if qry.FieldByName('Max_Num').AsString <> '' then
    GetNewNumber := qry.FieldByName('Max_Num').AsInteger + 1
  else
    GetNewNumber := 1;
  qry.Close;
  qry.Free;
end;

{ Change fld fields from BefNum to NewNum }
procedure ChangeDBSNum(tbl, fld : String; BefNum, NewNum : LongInt);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + IntToStr(NewNum));
  qry.SQL.Add('WHERE ' + fld + ' = ' + IntToStr(BefNum));
  qry.ExecSQL;
  qry.Free;
end;

{ Change fld fields from BefStr to NewStr }
procedure ChangeDBSStr(tbl, fld : String; BefStr, NewStr : String);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + NewStr);
  qry.SQL.Add('WHERE ' + fld + ' = ''' + BefStr + '''');
  qry.ExecSQL;
  qry.Free;
end;

{ Increment or Decrement a field of database from a record }
procedure ChngIntegerField(tbl, fld : String; from, n : Integer);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('UPDATE ' + tbl + ' SET ' + fld + ' = ' + fld + ' + ' + IntToStr(n));
  qry.SQL.Add('WHERE ' + fld + ' >= ''' + IntToStr(from) + '''');
  qry.ExecSQL;
  qry.Free;
end;


{ return True, if Exsists fld in database }
function  IsExistsRec_Num(tbl, fld : String; fldVal : LongInt) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld + ' = ' + IntToStr(fldVal));
  qry.Open;
  IsExistsRec_Num := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ return True, if Exsists fld in database }
function  IsExistsRec_Str(tbl, fld, fldVal : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ' + tbl + ' WHERE ' + fld + ' = ''' + fldVal + '''');
  qry.Open;
  IsExistsRec_Str := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ return True, if Exsists fld1 and fld2 in database }
function  IsExistsTwoRec_Str(tbl, fld1, fld2, fldVal1, fldVal2 : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ' + tbl + ' WHERE (' + fld1 + ' = ''' + fldVal1 + ''') AND (' + fld2 + ' = ''' + fldVal2 + ''') ');
  qry.Open;
  IsExistsTwoRec_Str := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ Initialize Global Variables }
procedure InitVariables;
begin
  LoadIniFile;
  LoadReaders;
  Load_Cars_Type;
  ResetCapacities;
  LoadCapacity;
  LoadExit_Park;
end;

{ Return status of car }
function CarStat(CarNumber, CarCity, CarSerial : String) : Integer;
var
  qry : TAdoQuery;
  ret : Integer;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  ret := 0;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Cust_Code FROM Customs');
  qry.SQL.Add('WHERE Cust_CarNumber = ''' + CarNumber + '''');
  qry.SQL.Add('AND Cust_CarCity = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND Cust_CarSerial = ''' + CarSerial + '''');
  qry.SQL.Add('AND Cust_Valid = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.Open;
  if qry.RecordCount > 0 then
    ret := MB_CUSTOMS;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Specials');
  qry.SQL.Add('WHERE Spc_Number = ''' + CarNumber + '''');
  qry.SQL.Add('AND Spc_City = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND Spc_Serial = ''' + CarSerial + '''');
  qry.Open;
  if qry.RecordCount > 0 then
  begin
    if qry.FieldByName('Spc_Takhfif').AsBoolean then
      ret := ret or MB_TAKHFIF;
    if qry.FieldByName('Spc_Motavari').AsBoolean then
      ret := ret or MB_MOTAVARI;
    if qry.FieldByName('Spc_NotExit').AsBoolean then
      ret := ret or MB_NOTEXIT;
  end;
  qry.Close;
  qry.Free;
  CarStat := ret;
end;

{ Set status of car }
procedure SetCarStat(CarNumber, CarCity, CarSerial : String);
var
  qry : TAdoQuery;
  ret : Integer;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  ret := CarStat(CarNumber, CarCity, CarSerial);

  qry.SQL.Clear;
  qry.SQL.Add('UPDATE InputCar SET M_Kind = ' + IntToStr(ret));
  qry.SQL.Add('WHERE M_Number = ''' + CarNumber + '''');
  qry.SQL.Add('AND M_CityName = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND M_Serial = ''' + CarSerial + '''');
  qry.SQL.Add('AND M_IsPark = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.ExecSQL;
  qry.Free;
end;

{ Load Types and CarTypes in global variables }
procedure Load_Cars_Type;
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  with tbl do
  begin
    connection := frmDBS.adoConnect;
    TableName := 'CarTypes';
    Open;
    TotalTypes := 0;
    while not EOF do
    begin
      Inc(TotalTypes);
      with CarTypes[TotalTypes] do
      begin
        Type_Name := FieldByName('Type_Name').AsString;
        Type_Code := FieldByName('Type_Code').AsInteger;
        with Type_Nerkh do
        begin
          Voroodieh := FieldByName('Type_Vorood').AsInteger;
          with priods[1] do
          begin
            MaxMin := FieldByName('Type_FirstTime').AsInteger;
            FixMin := FieldByName('Type_FirstTime1').AsInteger;
            Mablagh := FieldByName('Type_FirstPrice').AsInteger;
            IsFirst := True;
            Rounding := FieldByName('Type_FirstRounding').AsInteger;
          end;
          with priods[2] do
          begin
            MaxMin := FieldByName('Type_SecondTime').AsInteger;
            FixMin := FieldByName('Type_SecondTime2').AsInteger;
            Mablagh := FieldByName('Type_SecondPrice').AsInteger;
            IsFirst := FieldByName('Type_SecondIsFirst').AsBoolean;
            Rounding := FieldByName('Type_SecondRounding').AsInteger;
          end;
          with priods[3] do
          begin
            MaxMin := FieldByName('Type_ThirdTime').AsInteger;
            FixMin := FieldByName('Type_ThirdTime3').AsInteger;
            Mablagh := FieldByName('Type_ThirdPrice').AsInteger;
            IsFirst := FieldByName('Type_ThirdIsFirst').AsBoolean;
            Rounding := FieldByName('Type_ThirdRounding').AsInteger;
          end;
          with priods[4] do
          begin
            MaxMin := FieldByName('Type_LastTime').AsInteger;
            FixMin := FieldByName('Type_LastTime3').AsInteger;
            Mablagh := FieldByName('Type_LastPrice').AsInteger;
            IsFirst := FieldByName('Type_LastIsFirst').AsBoolean;
            Rounding := FieldByName('Type_LastRounding').AsInteger;
          end;
          DailyPrice := FieldByName('Type_Dailyprice').AsInteger;
        end;
      end;
      Next;
    end;
    Close;

    TableName := 'Cars';
    Open;
    TotalCars := 0;
    while not EOF do
    begin
      Inc(TotalCars);
      with Cars[TotalCars] do
      begin
        Car_Name := FieldByName('Car_Name').AsString;
        Car_Type := FieldByName('Car_Type').AsInteger;
      end;
      Next;
    end;
    Close;
    Free;
  end;
end;


{ Return True, if TypeCode Exists in Cars table }
function InCircleCarType(TypeCode : Integer) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Car_Type FROM Cars WHERE Car_Type = ' + IntToStr(TypeCode));
  qry.Open;
  InCircleCarType := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ return Car TypeName from database }
function GetTypeCode(TypeName : String) : Integer;
var i : Byte;
begin
  GetTypeCode := 0;
  for i := 1 to TotalTypes do
  begin
    if CarTypes[i].Type_Name = TypeName then
    begin
      GetTypeCode := CarTypes[i].Type_Code;
      Break;
    end;
  end;
end;

{ Return index of Type from variables }
function TypeCode_Index(TypeCode : Integer) : Byte;
var
  RetVal, i : Byte;
begin
  RetVal := 0;
  for i := 1 to TotalTypes do
  begin
    if CarTypes[i].Type_Code = TypeCode then
    begin
      RetVal := i;
      Break;
    end;
  end;

  if RetVal = 0 then
  begin
    for i := 1 to TotalTypes do
    begin
      if CarTypes[i].Type_Code = g_options.DefaultType then
      begin
        RetVal := i;
        Break;
      end;
    end;
  end;
  TypeCode_Index := RetVal;
end;

{ Return index of cars from Cars variable }
function FindTypeNo(CarName : String) : Byte;
var i, m : Byte;
begin
  m := 0;
  for i := 1 to TotalCars do
    if Cars[i].Car_Name = CarName then
    begin
      m := cars[i].Car_Type;
      Break;
    end;

  FindTypeNo := TypeCode_Index(m);
end;


{ Return True, if CarName Exists in Machines table }
function InCircleCar(CarName : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
{
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M.M_CarName AS MM_CarName, I.M_CarName AS IM_CarName ');
  qry.SQL.Add('FROM Machines M CROSS JOIN InputCar I ');
  qry.SQL.Add('WHERE (M.M_CarName = ''' + CarName + ''') OR (I.M_CarName = ''' + CarName + ''') ');
//  qry.SQL.Add('SELECT M_CarName FROM Machines M, InputCar I WHERE M.M_CarName = ''' + CarName + '''');
//  qry.SQL.Add('OR I.M_CarName = ''' + CarName + '''');
  qry.Open;
  InCircleCar := not qry.EOF;
  qry.Close; }

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_CarName ');
  qry.SQL.Add('FROM Machines ');
  qry.SQL.Add('WHERE (M_CarName = ''' + CarName + ''') ');
  qry.Open;
  InCircleCar := not qry.EOF;
  if qry.EOF  then
  begin
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_CarName ');
    qry.SQL.Add('FROM InputCar ');
    qry.SQL.Add('WHERE (M_CarName = ''' + CarName + ''') ');
    qry.Open;
    InCircleCar := not qry.EOF;
    if qry.EOF then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT cars.Car_Name ');
      qry.SQL.Add('FROM NewPersons INNER JOIN ');
      qry.SQL.Add('cars ON NewPersons.P_CarName = cars.Car_Code ');
      qry.SQL.Add('WHERE (cars.Car_Name = ''' + CarName + ''') ');
      qry.Open;
      InCircleCar := not qry.EOF;
      qry.Close;
    end
    else
    begin
      qry.Close;
    end;
  end
  else
  begin
    qry.Close;  
  end;
  qry.Free;
end;

{ return True, if Exsists fld in database }
function IsExistsCar(tbl, fldNumber, fldCity, fldSerial, Number, City, Serial : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ' + tbl);
  qry.SQL.Add('WHERE ' + fldNumber + ' = ''' + Number + '''');
  qry.SQL.Add('AND ' + fldCity + ' = ''' + City + '''');
  qry.SQL.Add('AND ' + fldSerial + ' = ''' + Serial + '''');
  qry.Open;
  IsExistsCar := not qry.EOF;
  qry.Close;
  qry.Free;
end;


{ Return True, if CityName Exists in Machines table }
function InCircleCity(CityName : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_CarName FROM Machines M, InputCar I WHERE M.M_CityName = ''' + CityName + '''');
  qry.SQL.Add('OR I.M_CityName = ''' + CityName + '''');
  qry.Open;
  InCircleCity := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ Return True, if ClrName Exists in Machines table }
function InCircleColor(ClrName : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
{  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_CarName FROM Machines M, InputCar I WHERE M.M_Color = ''' + ClrName + '''');
  qry.SQL.Add('OR I.M_Color = ''' + ClrName + '''');
  qry.Open;
  InCircleColor := not qry.EOF;
  qry.Close; }
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_Color ');
  qry.SQL.Add('FROM Machines ');
  qry.SQL.Add('WHERE (M_Color = ''' + ClrName + ''') ');
  qry.Open;
  InCircleColor := not qry.EOF;
  if qry.EOF  then
  begin
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_Color ');
    qry.SQL.Add('FROM InputCar ');
    qry.SQL.Add('WHERE (M_Color = ''' + ClrName + ''') ');
    qry.Open;
    InCircleColor := not qry.EOF;
    if qry.EOF then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT Colors.Clr_Name ');
      qry.SQL.Add('FROM NewPersons INNER JOIN ');
      qry.SQL.Add('Colors ON NewPersons.P_CarColor = Colors.Clr_Code ');
      qry.SQL.Add('WHERE (Colors.Clr_Name = ''' + ClrName + ''') ');
      qry.Open;
      InCircleColor := not qry.EOF;
      qry.Close;
    end
    else
    begin
      qry.Close;
    end;
  end
  else
  begin
    qry.Close;
  end;
  qry.Free;
end;

{ Return True, if DpmName Exists in tables }
function InCircleDepartment(DpmCode : Integer) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_WorkDepart, M_EntranceDepart ');
  qry.SQL.Add('FROM InputCar ');
  qry.SQL.Add('WHERE (M_WorkDepart = ' + IntToStr(DpmCode) + ') OR (M_EntranceDepart = ' + IntToStr(DpmCode) + ') ');
  qry.Open;
  InCircleDepartment := not qry.EOF;
  if qry.EOF  then
  begin
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_WorkDepart, M_EntranceDepart ');
    qry.SQL.Add('FROM Machines ');
    qry.SQL.Add('WHERE (M_WorkDepart = ' + IntToStr(DpmCode) + ') OR (M_EntranceDepart = ' + IntToStr(DpmCode) + ') ');
    qry.Open;
    InCircleDepartment := not qry.EOF;
    if qry.EOF then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT P_Depart ');
      qry.SQL.Add('FROM NewPersons ');
      qry.SQL.Add('WHERE (P_Depart = ' + IntToStr(DpmCode) + ') ');
      qry.Open;
      InCircleDepartment := not qry.EOF;
      if qry.EOF then
      begin
        qry.Close;
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT Department ');
        qry.SQL.Add('FROM Security ');
        qry.SQL.Add('WHERE (Department = ' + IntToStr(DpmCode) + ') ');
        qry.Open;
        InCircleDepartment := not qry.EOF;
        qry.Close;
      end
      else
      begin
        qry.Close;
      end;
    end
    else
    begin
      qry.Close;
    end;
  end
  else
  begin
    qry.Close;
  end;
  qry.Free;
end;

{ Return True, if CoCar Exists in tables }
function InCircleCoCar(CarNumber, Serial : String) : Boolean;
//function InCircleDepartment(DpmCode : Integer) : Boolean;
var qry : TAdoQuery;
begin
//????
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT IO_CarNumber, IO_Serial ');
  qry.SQL.Add('FROM InOutCo ');
  qry.SQL.Add('WHERE (IO_CarNumber = ' + CarNumber + ') AND (IO_Serial = ' + Serial + ') ');
  qry.Open;
  InCircleCoCar := not qry.EOF;
{  if qry.EOF  then
  begin
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_WorkDepart, M_EntranceDepart ');
    qry.SQL.Add('FROM Machines ');
    qry.SQL.Add('WHERE (M_WorkDepart = ' + IntToStr(DpmCode) + ') OR (M_EntranceDepart = ' + IntToStr(DpmCode) + ') ');
    qry.Open;
    InCircleDepartment := not qry.EOF;
    if qry.EOF then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT P_Depart ');
      qry.SQL.Add('FROM NewPersons ');
      qry.SQL.Add('WHERE (P_Depart = ' + IntToStr(DpmCode) + ') ');
      qry.Open;
      InCircleDepartment := not qry.EOF;
      if qry.EOF then
      begin
        qry.Close;
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT Department ');
        qry.SQL.Add('FROM Security ');
        qry.SQL.Add('WHERE (Department = ' + IntToStr(DpmCode) + ') ');
        qry.Open;
        InCircleDepartment := not qry.EOF;
        qry.Close;
      end
      else
      begin
        qry.Close;
      end;
    end
    else
    begin
      qry.Close;
    end;
  end
  else
  begin
    qry.Close;
  end; }
  qry.Close;
  qry.Free;
end;



{ Load Units In Global Variables }
procedure LoadReaders;
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  with tbl do
  begin
    connection := frmDBS.adoConnect;
    TableName := 'Readers';
    Open;
    TotalReader := 0;
    TotalActvRdr := 0;
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
        if R_IsCom then R_ComType := 0 else R_ComType := 1; //kaveh
        R_TCPPort := 1001; //kaveh
        R_IP := FieldByName('R_IP').AsString;
        R_TCP := FieldByName('R_TCP').AsBoolean;
        if FieldByName('R_Type').AsString = '0' then
          R_Type := RDR_VEGA9300
        else if FieldByName('R_Type').AsString = '1' then
          R_Type := RDR_CLK6000
        else
          R_Type := RDR_VEGA9300;
        if FieldByName('R_Depart').AsString <> '' then        
          R_Depart := FieldByName('R_Depart').AsInteger;
        RdrRelation := 1;
        BuffEmpty := 0;
        MaxTimeOff := 0;

        if R_Active then Inc(TotalActvRdr);
      end;
      with ReadersLast[TotalReader] do
      begin
        CarTime := '';
        ParkCost := '';
        CarNumber := '';
        ComTime := '';
        ComStat := '';
        OP := '';
      end;
      Next;
    end;
    Close;
    Free;
  end;
end;

{ Return True, if ReaderCode Exists in Machines table }
function InCircleReader(ReaderCode : Integer) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM InputCar ');
  qry.SQL.Add('WHERE M_IDoor = ' + IntToStr(ReaderCode) + ' ');
  qry.SQL.Add('OR M_ODoor = ' + IntToStr(ReaderCode) + ' ');
  qry.SQL.Add('OR M_rdrCode = ' + IntToStr(ReaderCode) + ' ');
  qry.Open;
  if qry.EOF then
  begin
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_BarCode FROM Machines ');
    qry.SQL.Add('WHERE M_IDoor = ' + IntToStr(ReaderCode) + ' ');
    qry.SQL.Add('OR M_ODoor = ' + IntToStr(ReaderCode) + ' ');
    qry.SQL.Add('OR M_rdrCode = ' + IntToStr(ReaderCode) + ' ');
    qry.Open;
    InCircleReader := not qry.EOF;
  end
  else
  begin
    InCircleReader := not qry.EOF;
  end;
{
  qry.SQL.Add('SELECT M_BarCode FROM Machines M, InputCar I');
  qry.SQL.Add('WHERE M.M_IDoor = ' + IntToStr(ReaderCode));
  qry.SQL.Add('OR M.M_ODoor = ' + IntToStr(ReaderCode));
  qry.SQL.Add('OR I.M_IDoor = ' + IntToStr(ReaderCode));
  qry.SQL.Add('OR I.M_ODoor = ' + IntToStr(ReaderCode));
  qry.Open;
  InCircleReader := not qry.EOF;   }
  qry.Close;
  qry.Free;
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

{ Return True, if PersonCode Exists in Machines table }
function InCirclePerson(PersonCode : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add(' SELECT * FROM');
  qry.SQL.Add(' (');
  qry.SQL.Add(' SELECT M_IsPark, M_OperatorCode FROM Machines');
  qry.SQL.Add(' union all');
  qry.SQL.Add(' SELECT M_IsPark, M_OperatorCode FROM InputCar');
  qry.SQL.Add(' ) l1');
  qry.SQL.Add(' WHERE (M_OperatorCode = ''' + PersonCode + ''')');
{
  qry.SQL.Add('SELECT M_BarCode FROM Machines M, InputCar I');
  qry.SQL.Add('WHERE M.M_IPerson = ''' + PersonCode + '''');
  qry.SQL.Add('OR M.M_OPerson = ''' + PersonCode + '''');
  qry.SQL.Add('OR I.M_IPerson = ''' + PersonCode + '''');
  qry.SQL.Add('OR I.M_OPerson = ''' + PersonCode + '''');  }
  qry.Open;
  InCirclePerson := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ Return Person Name From Persons }
function GetPersonCode(PersonName : String) : String;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_BarCode FROM Persons');
  qry.SQL.Add('WHERE P_Name = ''' + PersonName + '''');
  qry.Open;
  if qry.RecordCount > 0 then
    GetPersonCode := qry.FieldByName('P_BarCode').AsString
  else
    GetPersonCode := '';
  qry.Close;
  qry.Free;
end;

{ Return Person Name From Persons }
function GetPersonName(PersonCode : String) : String;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Name FROM Persons');
  qry.SQL.Add('WHERE P_BarCode = ''' + PersonCode + '''');
  qry.Open;
  if qry.RecordCount > 0 then
    GetPersonName := qry.FieldByName('P_Name').AsString
  else
    GetPersonName := '';
  qry.Close;
  qry.Free;
end;


{ Return CarType Maximum capacity in parking }
function GetMaxCapacity(CarType : Integer) : Integer;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT SUM(Cap_Max) AS MaxCar FROM Capacity WHERE Cap_TypeCode = ' + IntToStr(CarType));
  qry.Open;
  GetMaxCapacity := qry.FieldByName('MaxCar').AsInteger;
  qry.Close;
  qry.Free;
end;

{ Reset Capacities variables}
procedure ResetCapacities;
var i, j : Byte;
begin
  for i := 1 to 20 do
  begin
    FreeCapacity[i] := 999;
    for j := 1 to 20 do
      UnitCapacity[i, j] := 999;
  end;
end;

{ Read number cars in parking and calcul free capacity }
procedure LoadCapacity;
var
  i : Integer;
  qry : TAdoQuery;
begin
  for i := 1 to TotalTypes do
  begin
    MaxCapacities[i] := GetMaxCapacity(CarTypes[i].Type_Code);
    FreeCapacity[i] := MaxCapacities[i];
  end;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_CarName FROM InputCar');
  qry.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.Open;
  while not qry.EOF do
  begin
    i := FindTypeNo(qry.FieldByName('M_CarName').AsString);
    FreeCapacity[i] := FreeCapacity[i] - 1;
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

{ Set New Value in free capacity variable }
procedure SetCapacity(CarName : String; T : Integer);
var m : Byte;
begin
  m := FindTypeNo(CarName);
  if m <> 0 then
    FreeCapacity[m] := t;
end;

{ Increment or Decrement Capacity }
procedure ChngCapacity(CarName : String; t : Integer);
var m : Byte;
begin
  m := FindTypeno(CarName);
  if m <> 0 then
    Inc(FreeCapacity[m], t);
end;


{ Return True, if CardCode Exists in Machines table }
function InCircleCard(CardCode : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM Machines M, InputCar I WHERE M.M_BarCode = ''' + CardCode + '''');
  qry.SQL.Add('OR I.M_BarCode = ''' + CardCode + '''');
  qry.Open;
  InCircleCard := not qry.EOF;
  qry.Close;
  qry.Free;
end;

{ Return True, if PtCode Exists in InputCar table }
function  InCircleNewPersons(PCode : Integer) : Boolean;
var
  qry : TAdoQuery;
//  fnd : Boolean;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
{  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM NewPersons, Machines');
  qry.SQL.Add('WHERE M_Number = P_CarNumber');
//  qry.SQL.Add('AND M_CityName = Cust_CarCity');
  qry.SQL.Add('AND M_Serial = P_CarSerial');
  qry.SQL.Add('AND Cust_Code = ' + IntToStr(CustCode));
  qry.Open;
  fnd := not qry.EOF;
  qry.Close;    }
{
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM NewPersons, InputCar');
//  qry.SQL.Add('WHERE M_Driver = P_Code');
//  qry.SQL.Add('AND M_CityName = Cust_CarCity');
//  qry.SQL.Add('AND M_Serial = Cust_CarSerial');
  qry.SQL.Add('AND M_Driver = ' + IntToStr(PCode));
  qry.Open;
  fnd := fnd or (not qry.EOF);
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM NewPersons, InputCar');
//  qry.SQL.Add('WHERE M_Driver = P_Code');
//  qry.SQL.Add('AND M_CityName = Cust_CarCity');
//  qry.SQL.Add('AND M_Serial = Cust_CarSerial');
  qry.SQL.Add('AND M_Visited = ' + IntToStr(PCode));
  qry.Open;
  fnd := fnd or (not qry.EOF);
  qry.Close;  }
  
{  qry.SQL.Clear;
  qry.SQL.Add('SELECT Pay_CustCode FROM PayCust');
  qry.SQL.Add('WHERE Pay_CustCode = ' + IntToStr(CustCode));
  qry.Open;
  if qry.RecordCount > 1 then
    fnd := fnd or True
  else
    fnd := fnd or False;
  qry.Close; }


  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_Driver, M_Visited ');
  qry.SQL.Add('FROM InputCar ');
  qry.SQL.Add('WHERE (M_Driver = ' + IntToStr(PCode) + ') OR (M_Visited = ' + IntToStr(PCode) + ') ');
  qry.Open;
  InCircleNewPersons := not qry.EOF;
  if qry.EOF  then
  begin
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_Driver, M_Visited ');
    qry.SQL.Add('FROM Machines ');
    qry.SQL.Add('WHERE (M_Driver = ' + IntToStr(PCode) + ') OR (M_Visited = ' + IntToStr(PCode) + ') ');
    qry.Open;
    InCircleNewPersons := not qry.EOF;
    qry.Close;
  end
  else
  begin
    qry.Close;
  end;
  qry.Free;
//  InCircleNewPersons := fnd;
end;

{ Return True, if CustCode Exists in Machines table }
function InCircleCustoms(CustCode : Integer) : Boolean;
var
  qry : TAdoQuery;
  fnd : Boolean;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM Customs, Machines');
  qry.SQL.Add('WHERE M_Number = Cust_CarNumber');
  qry.SQL.Add('AND M_CityName = Cust_CarCity');
  qry.SQL.Add('AND M_Serial = Cust_CarSerial');
  qry.SQL.Add('AND Cust_Code = ' + IntToStr(CustCode));
  qry.Open;
  fnd := not qry.EOF;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM Customs, InputCar');
  qry.SQL.Add('WHERE M_Number = Cust_CarNumber');
  qry.SQL.Add('AND M_CityName = Cust_CarCity');
  qry.SQL.Add('AND M_Serial = Cust_CarSerial');
  qry.SQL.Add('AND Cust_Code = ' + IntToStr(CustCode));
  qry.Open;
  fnd := fnd or (not qry.EOF);
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Pay_CustCode FROM PayCust');
  qry.SQL.Add('WHERE Pay_CustCode = ' + IntToStr(CustCode));
  qry.Open;
  if qry.RecordCount > 1 then
    fnd := fnd or True
  else
    fnd := fnd or False;
  qry.Close;
  qry.Free;

  InCircleCustoms := fnd;
end;

{ Get Remain Price Customs }
function GetCustomsRemain(CarNumber, CarCity, CarSerial : String) : Currency;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Cust_Remain FROM Customs');
  qry.SQL.Add('WHERE Cust_CarNumber = ''' + CarNumber + '''');
  qry.SQL.Add('AND Cust_CarCity = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND Cust_CarSerial = ''' + CarSerial + '''');
  qry.SQL.Add('AND Cust_Valid = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.Open;
  if qry.RecordCount > 0 then
  begin
    GetCustomsRemain := qry.FieldByName('Cust_Remain').AsCurrency
  end
  else
    GetCustomsRemain := 0;
  qry.Close;
  qry.Free;
end;

{ Set Remain Price Customs }
procedure SetCustomsRemain(CarNumber, CarCity, CarSerial : String; Remain : Currency);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('UPDATE Customs SET Cust_Remain = ' + FloatToStr(Remain));
  qry.SQL.Add('WHERE Cust_CarNumber = ''' + CarNumber + '''');
  qry.SQL.Add('AND Cust_CarCity = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND Cust_CarSerial = ''' + CarSerial + '''');
  qry.SQL.Add('AND Cust_Valid = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.ExecSQL;
  qry.Close;
  qry.Free;
end;

{ Update Customs Database }
procedure UpdateCustomsRemain(Number, City, Serial : string; Price : Currency);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('UPDATE Customs SET Cust_Remain = Cust_Remain + ' + FloatToStr(Price));
  qry.SQL.Add('WHERE Cust_CarNumber = ''' + Number + '''');
  qry.SQL.Add('AND Cust_CarCity = ''' + City + '''');
  if Serial <> '' then
    qry.SQL.Add('AND Cust_CarSerial = ''' + Serial + '''');
  qry.SQL.Add('AND Cust_Valid = ' + IntToStr(CNST_TRUE)); //Kaveh
  qry.ExecSQL;
  qry.Free;
end;


{ Return Door Code From Readers }
function GetDoorCode(DoorName : String) : Integer;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT R_Code FROM Readers');
  qry.SQL.Add('WHERE R_Name = ''' + DoorName + '''');
  qry.Open;
  if qry.RecordCount > 0 then
    GetDoorCode := qry.FieldByName('R_Code').AsInteger
  else
    GetDoorCode := -1;
  qry.Close;
  qry.Free;
end;

{ Return Door Name From Readers }
function GetDoorName(DoorCode : Integer) : String;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT R_Name FROM Readers');
  qry.SQL.Add('WHERE R_Code = ' + IntToStr(DoorCode));
  qry.Open;
  if qry.RecordCount > 0 then
    GetDoorName := qry.FieldByName('R_Name').AsString
  else
    GetDoorName := '';
  qry.Close;
  qry.Free;
end;

{ Save collected data of entered cars in database }
function  SaveInputCarRecord(var rec : TMachines) : Byte;
var
  qry : TADOQuery;
begin
  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;

  try
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    with qry do
    begin
      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT P_Barcode' );
      SQL.Add(' FROM Persons');
      SQL.Add(' WHERE (P_Barcode = ''' + rec.M_OperatorCode + '''))');
      SQL.Add(' INSERT INTO Persons');
      SQL.Add(' (P_Barcode, P_Name)');
      SQL.Add(' Values (''' + rec.M_OperatorCode + ''', ''' + rec.M_OperatorCode + ''')');
      ExecSQL;

      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT Card_Code' );
      SQL.Add(' FROM BarCodes');
      SQL.Add(' WHERE (Card_Code = ''' + rec.M_BarCode + '''))');
      SQL.Add(' INSERT INTO BarCodes');
      SQL.Add(' (Card_Code, Card_State)');
      SQL.Add(' Values (''' + rec.M_BarCode + ''', 1)');
      ExecSQL;

      if (rec.M_Status = 61) or (rec.M_Status = 62) or (rec.M_Status = 63) or (rec.M_Status = 64) then
      begin
        SQL.Clear;
        SQL.Add(' IF not EXISTS');
        SQL.Add(' (');
        SQL.Add(' SELECT P_IsCustomer');
        SQL.Add(' FROM NewPersons');
        SQL.Add(' WHERE (P_CarNumber = ''' + rec.M_Number + ''') AND (P_CarSerial = ''' + rec.M_Serial + ''')');
        SQL.Add(' )');
        SQL.Add(' INSERT INTO NewPersons');
        SQL.Add(' (P_Code, P_CarNumber, P_CarSerial, P_Family, P_Name, P_CardID, P_IsCustomer, P_Valid, P_Date)');
        SQL.Add(' Values (''' + IntToStr(GetNewNumber('NewPersons', 'P_Code')) + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_BarCode + ''', 1, 1, ''' + rec.M_IDate + ''')');
        ExecSQL;
      end;

      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_ODate, M_OTime' );
      SQL.Add(' FROM InputCar');
      SQL.Add(' WHERE (M_BarCode = ''' + rec.M_BarCode + ''') AND (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND (M_IDate = ''' + rec.M_IDate + ''') AND (M_ITime = ''' + rec.M_ITime + ''') AND (M_ODate = ''' + rec.M_ODate + ''') AND (M_OTime = ''' + rec.M_OTime + '''))');
      SQL.Add(' INSERT INTO InputCar ');
      SQL.Add(' (M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_rdrCode,');
      SQL.Add(' M_OperatorCode, M_PlaqueType, M_PlaqueAppliance, M_CitySerial,');
      SQL.Add(' M_ODate, M_OTime, M_PayAble, M_Status, M_MemberCode,');
      SQL.Add(' M_IsPark, M_Karshenasi, M_Gholnameh, M_ExitValid, M_IsDeleted');
{$ifdef TarehBar}
      SQL.Add(' , M_CargoKind, M_CargoWeight, M_Salon, M_Loge '); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
      SQL.Add(' Values(''' + rec.M_BarCode + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_IDate + ''', ''' + rec.M_ITime + ''', ' + IntToStr(rec.M_rdrCode) + ',');
      SQL.Add(      ' ''' + rec.M_OperatorCode + ''', ' + IntToStr(rec.M_PlaqueType) + ', ' + IntToStr(rec.M_PlaqueAppliance) + ', ' + IntToStr(rec.M_CitySerial) + ',');
      SQL.Add(      ' ''' + rec.M_ODate + ''', ''' + rec.M_OTime + ''', ' + FloatToStr(rec.M_Payable) + ', ' + IntToStr(rec.M_Status) + ', ''' + rec.M_MemberCode + ''',');
      SQL.Add(      ' ' + IntToStr(CNST_TRUE) + ', ' + IntToStr(CNST_FALSE) + ', ' + IntToStr(CNST_FALSE) + ', ' + IntToStr(CNST_TRUE) + ', ' + IntToStr(CNST_FALSE));
{$ifdef TarehBar}
      SQL.Add(      ' , ' + IntToStr(rec.M_CargoKind) + ', ' + IntToStr(rec.M_CargoWeight) + ', ' + IntToStr(rec.M_Salon) + ', ' + IntToStr(rec.M_Loge)); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
      ExecSQL;

      SQL.Clear;
      SQL.Add(' IF EXISTS(SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime' );
      SQL.Add(' FROM Machines');
      SQL.Add(' WHERE (M_BarCode = ''' + rec.M_BarCode + ''') AND (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND (M_IDate = ''' + rec.M_IDate + ''') AND (M_ITime = ''' + rec.M_ITime + '''))');
      SQL.Add(' UPDATE InputCar ');
      SQL.Add(' SET M_IsPark = ' + IntToStr(CNST_FALSE) + ' ');
      SQL.Add(' WHERE (M_BarCode = ''' + rec.M_BarCode + ''') AND (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''')  AND (M_IDate = ''' + rec.M_IDate + ''') AND (M_ITime = ''' + rec.M_ITime + ''')');
      ExecSQL;
      //xxx Inc(AllParkNo);
      //xxx Inc(DayParkNo);
      //xxx Inc(DayAriveNo);
    end;
  finally
      qry.Close;
      qry.Free;
  end;
{
//kaveh  Rec.rdrCardCode := FixLeft(Rec.rdrCardCode, '0', 8);
//kaveh  frmDBS.atblEmployee.Open;
  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;
  with frmDBS.tblInputCar do
  try
    if not frmDBS.tblPersons.Active then
      frmDBS.tblPersons.Open;
    if not frmDBS.tblPersons.Locate('P_Barcode', rec.M_OperatorCode, [loPartialKey]) then
     begin
      frmDBS.tblPersons.Append;
      frmDBS.tblPersons.FieldByName('P_Barcode').AsString := rec.M_OperatorCode;
      frmDBS.tblPersons.Post;
     end;
    frmDBS.tblPersons.Close;
    if not frmDBS.tblBarCodes.Active then
      frmDBS.tblBarCodes.Open;
    if not frmDBS.tblBarCodes.Locate('Card_Code', rec.M_BarCode, [loPartialKey]) then
     begin
      frmDBS.tblBarCodes.Append;
      frmDBS.tblBarCodes.FieldByName('Card_Code').AsString := rec.M_BarCode;
      frmDBS.tblBarCodes.FieldByName('Card_State').AsInteger := 1;
      frmDBS.tblBarCodes.Post;
     end;
    frmDBS.tblBarCodes.Close;
    if not Active then
      Open;
    if not Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
     begin
      Append;
      FieldByName('M_BarCode').AsString := rec.M_BarCode;
      FieldByName('M_Number').AsString := rec.M_Number;
//kaveh      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := rec.M_Serial;
//kaveh      FieldByName('M_CarName').AsString := m.M_CarName;
//kaveh      FieldByName('M_Color').AsString := m.M_Color;
      FieldByName('M_IDate').AsString := rec.M_IDate;
      FieldByName('M_ITime').AsString := rec.M_ITime;
//kaveh      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := True;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False;
      FieldByName('M_rdrCode').AsInteger := rec.M_rdrCode;
      FieldByName('M_OperatorCode').AsString := rec.M_OperatorCode; //kaveh
      FieldByName('M_PlaqueType').AsInteger := rec.M_PlaqueType; //kaveh
      FieldByName('M_PlaqueAppliance').AsInteger:= rec.M_PlaqueAppliance; //kaveh
      FieldByName('M_CitySerial').AsInteger := rec.M_CitySerial; //kaveh
      FieldByName('M_ODate').AsString := rec.M_ODate; //kaveh
      FieldByName('M_OTime').AsString := rec.M_OTime; //kaveh
      FieldByName('M_PayAble').AsFloat := rec.M_Payable; //kaveh
      FieldByName('M_Status').AsInteger := rec.M_Status; //kaveh
      FieldByName('M_MemberCode').AsString := rec.M_MemberCode; //kaveh

      if (rec.M_Status = 61) or (rec.M_Status = 62) then
      begin
        qry := TAdoQuery.Create(Application);
        qry.connection := frmDBS.adoConnect;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT count(M_Number) as RecCount FROM Machines ');
        qry.SQL.Add('WHERE (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND ((M_ODate > ''' + rec.M_IDate + ''') OR ((M_ODate = ''' + rec.M_IDate + ''') AND (M_OTime >= ''' + rec.M_ITime + '''))) ');
        qry.Open;
        qry.First;
        if qry.FieldByName('RecCount').AsInteger > 0 then
          FieldByName('M_IsPark').AsBoolean := False;
        qry.Close;
        qry.Free;
      end
      else
      begin
        if not frmDBS.tblMachines.Active then
          frmDBS.tblMachines.Open;
        if frmDBS.tblMachines.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
         begin
  //        Edit;
  //kaveh new        FieldByName('M_IsDeleted').AsBoolean := True;
          FieldByName('M_IsPark').AsBoolean := False;
  //        Post;
         end;
        frmDBS.tblMachines.Close;
      end;

{kaveh      FieldByName('Recit1_Date').AsString := rec.rdrDate;
      FieldByName('Recit1_EmplNo').AsString := rec.rdrCardCode;
      FieldByName('Recit1_Time').AsInteger := rec.rdrTime;
      FieldByName('Recit1_Rdr').AsInteger := rec.rdrCode;
      FieldByName('Recit1_TotalPrice').AsCurrency := rec.rdrPayment;
      FieldByName('Recit1_Service').AsCurrency := rec.rdrService; }
{      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
     end;
    Close;
    Filtered := False;
    Filter := '';
  except
    cancel;
  end;
{
  m.M_Kind := CarStat(m.M_Number, m.M_CityName, m.M_Serial);
  with frmDBS.tblInputCar do
  begin
    //Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_Number = ''' + m.M_Number + ''' AND M_ITime = ''' + m.M_ITime + '''';
    Filter := 'M_BarCode = ''' + m.M_BarCode + '''';
    Filtered := True;
    Open;
    if RecordCount = 0 then
      Append
    else
      Edit;
    FieldByName('M_BarCode').AsString := m.M_BarCode;
    FieldByName('M_Number').AsString := m.M_Number;
    FieldByName('M_CityName').AsString := m.M_CityName;
    FieldByName('M_Serial').AsString := m.M_Serial;
    FieldByName('M_CarName').AsString := m.M_CarName;
    FieldByName('M_Color').AsString := m.M_Color;
    FieldByName('M_IDate').AsString := m.M_IDate;
    FieldByName('M_ITime').AsString := m.M_ITime;
    FieldByName('M_IDoor').AsInteger := m.M_IDoor;
    FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh    FieldByName('M_IPerson').AsString := m.M_OperatorCode;
    FieldByName('M_Kind').AsInteger := m.M_Kind;
    FieldByName('M_IsPark').AsBoolean := True;
    FieldByName('M_Karshenasi').AsBoolean := False;
    FieldByName('M_Gholnameh').AsBoolean := False;
    FieldByName('M_ExitValid').AsBoolean := True;
    FieldByName('M_IsDeleted').AsBoolean := False;
    Post;
    Inc(AllParkNo);
    Inc(DayParkNo);
    Inc(DayAriveNo);
    Close;
    Filtered := False;
    Filter := '';
  end;
  ChngCapacity(m.M_CarName, -1); }
end;

{ Save collected data of entered cars in database }
function  SaveInputCarRecordMember(var rec : TMachines) : Byte;
begin
//kaveh  Rec.rdrCardCode := FixLeft(Rec.rdrCardCode, '0', 8);
//kaveh  frmDBS.atblEmployee.Open;
  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;
  with frmDBS.tblInputCar do
  try
    if not frmDBS.tblPersons.Active then
      frmDBS.tblPersons.Open;
    if not frmDBS.tblPersons.Locate('P_Barcode', rec.M_OperatorCode, [loPartialKey]) then
     begin
      frmDBS.tblPersons.Append;
      frmDBS.tblPersons.FieldByName('P_Barcode').AsString := rec.M_OperatorCode;
      frmDBS.tblPersons.Post;
     end;
    frmDBS.tblPersons.Close;
    if not frmDBS.tblBarCodes.Active then
      frmDBS.tblBarCodes.Open;
    if not frmDBS.tblBarCodes.Locate('Card_Code', rec.M_BarCode, [loPartialKey]) then
     begin
      frmDBS.tblBarCodes.Append;
      frmDBS.tblBarCodes.FieldByName('Card_Code').AsString := rec.M_BarCode;
      frmDBS.tblBarCodes.FieldByName('Card_State').AsInteger := 1;
      frmDBS.tblBarCodes.Post;
     end;
    frmDBS.tblBarCodes.Close;
    if not Active then
      Open;
    if not Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
     begin
      Append;
      FieldByName('M_BarCode').AsString := rec.M_BarCode;
      FieldByName('M_Number').AsString := rec.M_Number;
//kaveh      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := rec.M_Serial;
//kaveh      FieldByName('M_CarName').AsString := m.M_CarName;
//kaveh      FieldByName('M_Color').AsString := m.M_Color;

      //XXXX
      //FieldByName('M_IDate').AsString := rec.M_IDate;
      //FieldByName('M_ITime').AsString := rec.M_ITime;
      //FieldByName('M_ODate').AsString := rec.M_ODate; //kaveh
      //FieldByName('M_OTime').AsString := rec.M_OTime; //kaveh
      FieldByName('M_IDate').AsString := rec.M_ODate;
      FieldByName('M_ITime').AsString := rec.M_OTime;
      FieldByName('M_ODate').AsString := '';
      FieldByName('M_OTime').AsString := '';
      //XXXX

//kaveh      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := True;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False;
      FieldByName('M_rdrCode').AsInteger := rec.M_rdrCode;
      FieldByName('M_OperatorCode').AsString := rec.M_OperatorCode; //kaveh
      FieldByName('M_PlaqueType').AsInteger := rec.M_PlaqueType; //kaveh
      FieldByName('M_PlaqueAppliance').AsInteger:= rec.M_PlaqueAppliance; //kaveh
      FieldByName('M_CitySerial').AsInteger := rec.M_CitySerial; //kaveh
      FieldByName('M_PayAble').AsFloat := rec.M_Payable; //kaveh
      FieldByName('M_Status').AsInteger := rec.M_Status; //kaveh

      if not frmDBS.tblMachines.Active then
        frmDBS.tblMachines.Open;
      if frmDBS.tblMachines.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
       begin
        Edit;
//kaveh new        FieldByName('M_IsDeleted').AsBoolean := True;
        FieldByName('M_IsPark').AsBoolean := False;
        Post;
       end;
      frmDBS.tblMachines.Close;

{kaveh      FieldByName('Recit1_Date').AsString := rec.rdrDate;
      FieldByName('Recit1_EmplNo').AsString := rec.rdrCardCode;
      FieldByName('Recit1_Time').AsInteger := rec.rdrTime;
      FieldByName('Recit1_Rdr').AsInteger := rec.rdrCode;
      FieldByName('Recit1_TotalPrice').AsCurrency := rec.rdrPayment;
      FieldByName('Recit1_Service').AsCurrency := rec.rdrService; }
      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
     end;
    Close;
    Filtered := False;
    Filter := '';
  except
    cancel;
  end;
{
  m.M_Kind := CarStat(m.M_Number, m.M_CityName, m.M_Serial);
  with frmDBS.tblInputCar do
  begin
    //Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_Number = ''' + m.M_Number + ''' AND M_ITime = ''' + m.M_ITime + '''';
    Filter := 'M_BarCode = ''' + m.M_BarCode + '''';
    Filtered := True;
    Open;
    if RecordCount = 0 then
      Append
    else
      Edit;
    FieldByName('M_BarCode').AsString := m.M_BarCode;
    FieldByName('M_Number').AsString := m.M_Number;
    FieldByName('M_CityName').AsString := m.M_CityName;
    FieldByName('M_Serial').AsString := m.M_Serial;
    FieldByName('M_CarName').AsString := m.M_CarName;
    FieldByName('M_Color').AsString := m.M_Color;
    FieldByName('M_IDate').AsString := m.M_IDate;
    FieldByName('M_ITime').AsString := m.M_ITime;
    FieldByName('M_IDoor').AsInteger := m.M_IDoor;
    FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh    FieldByName('M_IPerson').AsString := m.M_OperatorCode;
    FieldByName('M_Kind').AsInteger := m.M_Kind;
    FieldByName('M_IsPark').AsBoolean := True;
    FieldByName('M_Karshenasi').AsBoolean := False;
    FieldByName('M_Gholnameh').AsBoolean := False;
    FieldByName('M_ExitValid').AsBoolean := True;
    FieldByName('M_IsDeleted').AsBoolean := False;
    Post;
    Inc(AllParkNo);
    Inc(DayParkNo);
    Inc(DayAriveNo);
    Close;
    Filtered := False;
    Filter := '';
  end;
  ChngCapacity(m.M_CarName, -1); }
end;

{ Save collected Records in database (table:collectedRecs)}
function  SaveCollectedRecs(var rec : TMachines) : Byte;
var
  qry : TADOQuery;
begin
//kaveh  Rec.rdrCardCode := FixLeft(Rec.rdrCardCode, '0', 8);
//kaveh  frmDBS.atblEmployee.Open;
//*****  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
//*****  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;

  try
    qry := TAdoQuery.Create(Application);
    with qry do
    begin
        connection := frmDBS.adoConnect;
        SQL.Clear;
        SQL.Add('INSERT INTO collectedRecs ');
        SQL.Add('(M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_rdrCode,');
        SQL.Add(' M_OperatorCode, M_PlaqueType, M_PlaqueAppliance, M_CitySerial,');
        SQL.Add(' M_ODate, M_OTime, M_PayAble, M_Status, M_MemberCode');
{$ifdef TarehBar}
        SQL.Add(' , M_CargoKind, M_CargoWeight, M_Salon, M_Loge '); //kaveh
{$endif TarehBar}
        SQL.Add(' )');
        SQL.Add('Values(''' + rec.M_BarCode + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_IDate + ''', ''' + rec.M_ITime + ''', ' + IntToStr(rec.M_rdrCode) + ',');
        SQL.Add(      ' ''' + rec.M_OperatorCode + ''', ' + IntToStr(rec.M_PlaqueType) + ', ' + IntToStr(rec.M_PlaqueAppliance) + ', ' + IntToStr(rec.M_CitySerial) + ',');
        SQL.Add(      ' ''' + rec.M_ODate + ''', ''' + rec.M_OTime + ''', ' + FloatToStr(rec.M_Payable) + ', ' + IntToStr(rec.M_Status) + ', ''' + rec.M_MemberCode);
{$ifdef TarehBar}
        SQL.Add(      ''' , ' + IntToStr(rec.M_CargoKind) + ', ' + IntToStr(rec.M_CargoWeight) + ', ' + IntToStr(rec.M_Salon) + ', ' + IntToStr(rec.M_Loge)); //kaveh
        SQL.Add(' )');
{$else TarehBar}
        SQL.Add(''' )');
{$endif TarehBar}
        ExecSQL;
        Close;
        Free;
    end;

  except
    Result := MB_BADREC;
  end;


{  with frmDBS.tblInputCar do
  try
//*****    if not frmDBS.tblPersons.Active then
//*****      frmDBS.tblPersons.Open;
//*****    if not frmDBS.tblPersons.Locate('P_Barcode', rec.M_OperatorCode, [loPartialKey]) then
//*****     begin
//*****      frmDBS.tblPersons.Append;
//*****      frmDBS.tblPersons.FieldByName('P_Barcode').AsString := rec.M_OperatorCode;
//*****      frmDBS.tblPersons.Post;
//*****     end;
//*****    frmDBS.tblPersons.Close;
//*****    if not frmDBS.tblBarCodes.Active then
//*****      frmDBS.tblBarCodes.Open;
//*****    if not frmDBS.tblBarCodes.Locate('Card_Code', rec.M_BarCode, [loPartialKey]) then
//*****     begin
//*****      frmDBS.tblBarCodes.Append;
//*****      frmDBS.tblBarCodes.FieldByName('Card_Code').AsString := rec.M_BarCode;
//*****      frmDBS.tblBarCodes.FieldByName('Card_State').AsInteger := 1;
//*****      frmDBS.tblBarCodes.Post;
//*****     end;
//*****    frmDBS.tblBarCodes.Close;
{    if not Active then
      Open;
    if not Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
     begin
      Append;
      FieldByName('M_BarCode').AsString := rec.M_BarCode;
      FieldByName('M_Number').AsString := rec.M_Number;
//kaveh      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := rec.M_Serial;
//kaveh      FieldByName('M_CarName').AsString := m.M_CarName;
//kaveh      FieldByName('M_Color').AsString := m.M_Color;
      FieldByName('M_IDate').AsString := rec.M_IDate;
      FieldByName('M_ITime').AsString := rec.M_ITime;
//kaveh      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := True;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False;
      FieldByName('M_rdrCode').AsInteger := rec.M_rdrCode;
      FieldByName('M_OperatorCode').AsString := rec.M_OperatorCode; //kaveh
      FieldByName('M_PlaqueType').AsInteger := rec.M_PlaqueType; //kaveh
      FieldByName('M_PlaqueAppliance').AsInteger:= rec.M_PlaqueAppliance; //kaveh
      FieldByName('M_CitySerial').AsInteger := rec.M_CitySerial; //kaveh
      FieldByName('M_ODate').AsString := rec.M_ODate; //kaveh
      FieldByName('M_OTime').AsString := rec.M_OTime; //kaveh
      FieldByName('M_PayAble').AsFloat := rec.M_Payable; //kaveh
      FieldByName('M_Status').AsInteger := rec.M_Status; //kaveh
      FieldByName('M_MemberCode').AsString := rec.M_MemberCode; //kaveh

      if (rec.M_Status = 61) or (rec.M_Status = 62) then
      begin
        qry := TAdoQuery.Create(Application);
        qry.connection := frmDBS.adoConnect;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT count(M_Number) as RecCount FROM Machines ');
        qry.SQL.Add('WHERE (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND ((M_ODate > ''' + rec.M_IDate + ''') OR ((M_ODate = ''' + rec.M_IDate + ''') AND (M_OTime >= ''' + rec.M_ITime + '''))) ');
        qry.Open;
        qry.First;
        if qry.FieldByName('RecCount').AsInteger > 0 then
          FieldByName('M_IsPark').AsBoolean := False;
        qry.Close;
        qry.Free;
      end
      else
      begin
        if not frmDBS.tblMachines.Active then
          frmDBS.tblMachines.Open;
        if frmDBS.tblMachines.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
         begin
  //        Edit;
  //kaveh new        FieldByName('M_IsDeleted').AsBoolean := True;
          FieldByName('M_IsPark').AsBoolean := False;
  //        Post;
         end;
        frmDBS.tblMachines.Close;
      end;

{kaveh      FieldByName('Recit1_Date').AsString := rec.rdrDate;
      FieldByName('Recit1_EmplNo').AsString := rec.rdrCardCode;
      FieldByName('Recit1_Time').AsInteger := rec.rdrTime;
      FieldByName('Recit1_Rdr').AsInteger := rec.rdrCode;
      FieldByName('Recit1_TotalPrice').AsCurrency := rec.rdrPayment;
      FieldByName('Recit1_Service').AsCurrency := rec.rdrService; }
{      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
     end;
    Close;
    Filtered := False;
    Filter := '';
  except
    cancel;
  end;  }
{
  m.M_Kind := CarStat(m.M_Number, m.M_CityName, m.M_Serial);
  with frmDBS.tblInputCar do
  begin
    //Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_Number = ''' + m.M_Number + ''' AND M_ITime = ''' + m.M_ITime + '''';
    Filter := 'M_BarCode = ''' + m.M_BarCode + '''';
    Filtered := True;
    Open;
    if RecordCount = 0 then
      Append
    else
      Edit;
    FieldByName('M_BarCode').AsString := m.M_BarCode;
    FieldByName('M_Number').AsString := m.M_Number;
    FieldByName('M_CityName').AsString := m.M_CityName;
    FieldByName('M_Serial').AsString := m.M_Serial;
    FieldByName('M_CarName').AsString := m.M_CarName;
    FieldByName('M_Color').AsString := m.M_Color;
    FieldByName('M_IDate').AsString := m.M_IDate;
    FieldByName('M_ITime').AsString := m.M_ITime;
    FieldByName('M_IDoor').AsInteger := m.M_IDoor;
    FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh    FieldByName('M_IPerson').AsString := m.M_OperatorCode;
    FieldByName('M_Kind').AsInteger := m.M_Kind;
    FieldByName('M_IsPark').AsBoolean := True;
    FieldByName('M_Karshenasi').AsBoolean := False;
    FieldByName('M_Gholnameh').AsBoolean := False;
    FieldByName('M_ExitValid').AsBoolean := True;
    FieldByName('M_IsDeleted').AsBoolean := False;
    Post;
    Inc(AllParkNo);
    Inc(DayParkNo);
    Inc(DayAriveNo);
    Close;
    Filtered := False;
    Filter := '';
  end;
  ChngCapacity(m.M_CarName, -1); }
end;

{ Save collected Records in database (table:collectedRecs)}
function  CheckCollectedRecsTable() : Boolean;
var
  qry : TADOQuery;
begin
  Result := True;
  try
    qry := TAdoQuery.Create(Application);
    with qry do
    begin
        connection := frmDBS.adoConnect;

        SQL.Clear;
        SQL.Add('IF not EXISTS(SELECT name ' );
        SQL.Add('FROM sysobjects ');
        SQL.Add('WHERE (name = ''collectedRecs'')) ');
        SQL.Add('create table collectedRecs ');
        SQL.Add('(');
        SQL.Add(' [C_id] [int] IDENTITY (1, 1) NOT NULL ,');
        SQL.Add(' [M_rdrCode] [smallint] NULL ,');
        SQL.Add(' [M_BarCode] [nvarchar] (8) NULL ,');
        SQL.Add(' [M_Number] [nvarchar] (6) NULL ,');
        SQL.Add(' [M_Serial] [nvarchar] (2) NULL ,');
        SQL.Add(' [M_PlaqueType] [smallint] NULL ,');
        SQL.Add(' [M_PlaqueAppliance] [smallint] NULL ,');
        SQL.Add(' [M_CitySerial] [int] NULL ,');
        SQL.Add(' [M_IDate] [nvarchar] (10) NULL ,');
        SQL.Add(' [M_ITime] [nvarchar] (5) NULL ,');
        SQL.Add(' [M_ODate] [nvarchar] (10) NULL ,');
        SQL.Add(' [M_OTime] [nvarchar] (5) NULL ,');
        SQL.Add(' [M_OperatorCode] [nvarchar] (8) NULL ,');
        SQL.Add(' [M_PayAble] [money] NULL ,');
        SQL.Add(' [M_Status] [tinyint] NULL ,');
        SQL.Add(' [M_MemberCode] [nvarchar] (8) NULL');
{$ifdef TarehBar}
        SQL.Add(', [M_CargoKind] [tinyint] NULL '); //kaveh
        SQL.Add(', [M_CargoWeight] [int] NULL '); //kaveh
        SQL.Add(', [M_Salon] [smallint] NULL '); //kaveh
        SQL.Add(', [M_Loge] [smallint] NULL '); //kaveh
{$endif TarehBar}
        SQL.Add(' )');
        ExecSQL;
        Close;
        Free;
    end;
  except
    Result := False;
  end;
end;


function  UpdateMachinesCount(iDate : String; iDepartment : Integer; var AllParkCou : Integer; var DayParkCou : Integer; var DayAriveCou : Integer; var DayExitCou : Integer) : Boolean;
var
  qry : TADOQuery;
begin
  Result := True;
  try
    qry := TAdoQuery.Create(Application);
    with qry do
    begin
        connection := frmDBS.adoConnect;

        SQL.Clear;
        SQL.Add('SELECT count(*) as cou FROM InputCar');
        SQL.Add('WHERE (M_IDate = ''' + iDate + ''') AND (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') ');
        if iDepartment > 0 then
          SQL.Add(' AND (M_EntranceDepart = ' + IntToStr(iDepartment) + ') ');
        Open;
        DayAriveCou := FieldByName('cou').AsInteger;

        SQL.Clear;
        SQL.Add('SELECT count(*) as cou FROM InputCar');
        SQL.Add('WHERE (M_IDate = ''' + iDate + ''') and (M_IsPark = ' + IntToStr(CNST_TRUE) + ') AND (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') ');
        if iDepartment > 0 then
          SQL.Add(' AND (M_EntranceDepart = ' + IntToStr(iDepartment) + ') ');
        Open;
        DayParkCou := FieldByName('cou').AsInteger;

        SQL.Clear;
        SQL.Add('SELECT count(*) as cou FROM Machines');
        SQL.Add('WHERE (M_ODate = ''' + iDate + ''') AND (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') ');
        if iDepartment > 0 then
          SQL.Add(' AND (M_EntranceDepart = ' + IntToStr(iDepartment) + ') ');
        Open;
        DayExitCou := FieldByName('cou').AsInteger;

        SQL.Clear;
        SQL.Add('SELECT count(*) as cou FROM InputCar');
        SQL.Add('WHERE (M_IsPark = ' + IntToStr(CNST_TRUE) + ') AND (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') ');
        if iDepartment > 0 then
          SQL.Add(' AND (M_EntranceDepart = ' + IntToStr(iDepartment) + ') ');
        Open;
        AllParkCou := FieldByName('cou').AsInteger;

        Close;
        Free;
    end;
  except
    Result := False;
  end;
end;

{ Save collected data of exited cars in database }
function  UpdateOutputCarRecord(var rec : TMachines) : Byte; //kaveh
var
  qry : TADOQuery;
begin
  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;

  try
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    with qry do
    begin
      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT P_Barcode' );
      SQL.Add(' FROM Persons');
      SQL.Add(' WHERE (P_Barcode = ''' + rec.M_OperatorCode + '''))');
      SQL.Add(' INSERT INTO Persons');
      SQL.Add(' (P_Barcode, P_Name)');
      SQL.Add(' Values (''' + rec.M_OperatorCode + ''', ''' + rec.M_OperatorCode + ''')');
      ExecSQL;

      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT Card_Code' );
      SQL.Add(' FROM BarCodes');
      SQL.Add(' WHERE (Card_Code = ''' + rec.M_BarCode + '''))');
      SQL.Add(' INSERT INTO BarCodes');
      SQL.Add(' (Card_Code, Card_State)');
      SQL.Add(' Values (''' + rec.M_BarCode + ''', 1)');
      ExecSQL;

      if (rec.M_Status = 61) or (rec.M_Status = 62) or (rec.M_Status = 63) or (rec.M_Status = 64) then
      begin
        SQL.Clear;
        SQL.Add(' IF not EXISTS');
        SQL.Add(' (');
        SQL.Add(' SELECT P_IsCustomer');
        SQL.Add(' FROM NewPersons');
        SQL.Add(' WHERE (P_CarNumber = ''' + rec.M_Number + ''') AND (P_CarSerial = ''' + rec.M_Serial + ''')');
        SQL.Add(' )');
        SQL.Add(' INSERT INTO NewPersons');
        SQL.Add(' (P_Code, P_CarNumber, P_CarSerial, P_Family, P_Name, P_CardID, P_IsCustomer, P_Valid, P_Date)');
        SQL.Add(' Values (''' + IntToStr(GetNewNumber('NewPersons', 'P_Code')) + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_BarCode + ''', 1, 1, ''' + rec.M_IDate + ''')');
        ExecSQL;
      end;

      SQL.Clear;
      SQL.Add(' IF not EXISTS(SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_ODate, M_OTime' );
      SQL.Add(' FROM Machines');
      SQL.Add(' WHERE (M_BarCode = ''' + rec.M_BarCode + ''') AND (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND (M_IDate = ''' + rec.M_IDate + ''') AND (M_ITime = ''' + rec.M_ITime + ''') AND (M_ODate = ''' + rec.M_ODate + ''') AND (M_OTime = ''' + rec.M_OTime + '''))');
      SQL.Add(' INSERT INTO Machines ');
      SQL.Add(' (M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_rdrCode,');
      SQL.Add(' M_OperatorCode, M_PlaqueType, M_PlaqueAppliance, M_CitySerial,');
      SQL.Add(' M_ODate, M_OTime, M_PayAble, M_Status, M_MemberCode,');
      SQL.Add(' M_IsPark, M_Karshenasi, M_Gholnameh, M_ExitValid, M_IsDeleted');
{$ifdef TarehBar}
      SQL.Add(' , M_CargoKind, M_CargoWeight, M_Salon, M_Loge '); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
      SQL.Add(' Values(''' + rec.M_BarCode + ''', ''' + rec.M_Number + ''', ''' + rec.M_Serial + ''', ''' + rec.M_IDate + ''', ''' + rec.M_ITime + ''', ' + IntToStr(rec.M_rdrCode) + ',');
      SQL.Add(      ' ''' + rec.M_OperatorCode + ''', ' + IntToStr(rec.M_PlaqueType) + ', ' + IntToStr(rec.M_PlaqueAppliance) + ', ' + IntToStr(rec.M_CitySerial) + ',');
      SQL.Add(      ' ''' + rec.M_ODate + ''', ''' + rec.M_OTime + ''', ' + FloatToStr(rec.M_Payable) + ', ' + IntToStr(rec.M_Status) + ', ''' + rec.M_MemberCode + ''',');
      SQL.Add(      ' ' + IntToStr(CNST_FALSE) + ', ' + IntToStr(CNST_FALSE) + ', ' + IntToStr(CNST_FALSE) + ', ' + IntToStr(CNST_TRUE) + ', ' + IntToStr(CNST_FALSE));
{$ifdef TarehBar}
      SQL.Add(      ' , ' + IntToStr(rec.M_CargoKind) + ', ' + IntToStr(rec.M_CargoWeight) + ', ' + IntToStr(rec.M_Salon) + ', ' + IntToStr(rec.M_Loge)); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
      ExecSQL;

      SQL.Clear;
      SQL.Add(' UPDATE InputCar ');
      SQL.Add(' SET M_IsPark = ' + IntToStr(CNST_FALSE) + ' ');
      SQL.Add(' WHERE (M_BarCode = ''' + rec.M_BarCode + ''') AND (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''')  AND (M_IDate = ''' + rec.M_IDate + ''') AND (M_ITime = ''' + rec.M_ITime + ''')');
      ExecSQL;
      //xxx Dec(AllParkNo);
      //xxx Dec(DayParkNo);
      //xxx Dec(DayAriveNo);
    end;
  finally
      qry.Close;
      qry.Free;
  end;
{  with frmDBS.tblMachines do
  try
    if not frmDBS.tblPersons.Active then
      frmDBS.tblPersons.Open;
    if not frmDBS.tblPersons.Locate('P_Barcode', rec.M_OperatorCode, [loPartialKey]) then
     begin
      frmDBS.tblPersons.Append;
      frmDBS.tblPersons.FieldByName('P_Barcode').AsString := rec.M_OperatorCode; //kaveh
      frmDBS.tblPersons.Post;
     end;
    frmDBS.tblPersons.Close;
    if not frmDBS.tblBarCodes.Active then
      frmDBS.tblBarCodes.Open;
    if not frmDBS.tblBarCodes.Locate('Card_Code', rec.M_BarCode, [loPartialKey]) then
     begin
      frmDBS.tblBarCodes.Append;
      frmDBS.tblBarCodes.FieldByName('Card_Code').AsString := rec.M_BarCode;
      frmDBS.tblBarCodes.FieldByName('Card_State').AsInteger := 1;
      frmDBS.tblBarCodes.Post;
     end;
    frmDBS.tblBarCodes.Close;


    if (rec.M_Status = 63) or (rec.M_Status = 64) then
    begin
      qry := TAdoQuery.Create(Application);
      qry.connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE InputCar ');
      qry.SQL.Add('SET M_IsPark = ' + IntToStr(CNST_FALSE) + ' ');
      qry.SQL.Add('WHERE (M_Number = ''' + rec.M_Number + ''') AND (M_Serial = ''' + rec.M_Serial + ''') AND (M_IsPark = ' + IntToStr(CNST_TRUE) + ') AND ((M_IDate < ''' + rec.M_ODate + ''') OR ((M_IDate = ''' + rec.M_ODate + ''') AND (M_ITime <= ''' + rec.M_OTime + '''))) ');
//      qry.Open;
      qry.ExecSQL;
//      if qry.RecordCount > 0 then
//        FieldByName('M_IsPark').AsBoolean := False;
      qry.Close;
      qry.Free;
    end
    else
    begin
      if not frmDBS.tblInputCar.Active then
        frmDBS.tblInputCar.Open;
      if frmDBS.tblInputCar.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
       begin
        frmDBS.tblInputCar.Edit;
//kaveh new        frmDBS.tblInputCar.FieldByName('M_IsDeleted').AsBoolean := True;
        frmDBS.tblInputCar.FieldByName('M_IsPark').AsBoolean := False;
        frmDBS.tblInputCar.Post;
       end;
      frmDBS.tblInputCar.Close;
    end;




    if not Active then
      Open;
    if not Locate('M_Barcode;M_Number;M_IDate;M_ITime;M_ODate;M_OTime'{;M_ODate;M_OTime'}{, VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime, rec.M_ODate, rec.M_OTime]), [loPartialKey]) then
     begin
      Append;
      FieldByName('M_BarCode').AsString := rec.M_BarCode;
      FieldByName('M_Number').AsString := rec.M_Number;
//kaveh      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := rec.M_Serial;
//kaveh      FieldByName('M_CarName').AsString := m.M_CarName;
//kaveh      FieldByName('M_Color').AsString := m.M_Color;
      FieldByName('M_IDate').AsString := rec.M_IDate;
      FieldByName('M_ITime').AsString := rec.M_ITime;
//kaveh      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := False;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False; //kaveh new True=>False
      FieldByName('M_rdrCode').AsInteger := rec.M_rdrCode;
      FieldByName('M_OperatorCode').AsString := rec.M_OperatorCode; //kaveh
      FieldByName('M_PlaqueType').AsInteger := rec.M_PlaqueType; //kaveh
      FieldByName('M_PlaqueAppliance').AsInteger:= rec.M_PlaqueAppliance; //kaveh
      FieldByName('M_CitySerial').AsInteger := rec.M_CitySerial; //kaveh
      FieldByName('M_ODate').AsString := rec.M_ODate; //kaveh
      FieldByName('M_OTime').AsString := rec.M_OTime; //kaveh
      FieldByName('M_PayAble').AsFloat := rec.M_Payable; //kaveh
      FieldByName('M_Status').AsInteger := rec.M_Status; //kaveh
      FieldByName('M_MemberCode').AsString := rec.M_MemberCode; //kaveh

      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
     end;
    Close;
    Filtered := False;
    Filter := '';
  except
    cancel;
  end; }
end;

{ Save collected data of exited cars in database }
function  UpdateOutputCarRecordMember(var rec : TMachines) : Byte; //kaveh
begin
  Rec.M_OperatorCode := FixLeft(Rec.M_OperatorCode, '0', 8); //kaveh
  Rec.M_BarCode := FixLeft(Rec.M_BarCode, '0', 8); //kaveh
  Result := ERR_NONE;
  with frmDBS.tblMachines do
  try
    if not frmDBS.tblPersons.Active then
      frmDBS.tblPersons.Open;
    if not frmDBS.tblPersons.Locate('P_Barcode', rec.M_OperatorCode, [loPartialKey]) then
     begin
      frmDBS.tblPersons.Append;
      frmDBS.tblPersons.FieldByName('P_Barcode').AsString := rec.M_OperatorCode; //kaveh
      frmDBS.tblPersons.Post;
     end;
    frmDBS.tblPersons.Close;
    if not frmDBS.tblBarCodes.Active then
      frmDBS.tblBarCodes.Open;
    if not frmDBS.tblBarCodes.Locate('Card_Code', rec.M_BarCode, [loPartialKey]) then
     begin
      frmDBS.tblBarCodes.Append;
      frmDBS.tblBarCodes.FieldByName('Card_Code').AsString := rec.M_BarCode;
      frmDBS.tblBarCodes.FieldByName('Card_State').AsInteger := 1;
      frmDBS.tblBarCodes.Post;
     end;
    frmDBS.tblBarCodes.Close;
    if not frmDBS.tblInputCar.Active then
      frmDBS.tblInputCar.Open;
    if frmDBS.tblInputCar.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime]), [loPartialKey]) then
     begin
      frmDBS.tblInputCar.Edit;
//kaveh new      frmDBS.tblInputCar.FieldByName('M_IsDeleted').AsBoolean := True;
      frmDBS.tblInputCar.FieldByName('M_IsPark').AsBoolean := False;
      frmDBS.tblInputCar.Post;
     end;
    frmDBS.tblInputCar.Close;   

    if not Active then
      Open;
    if not Locate('M_Barcode;M_Number;M_IDate;M_ITime'{;M_ODate;M_OTime'}, VarArrayOf([rec.M_BarCode, rec.M_Number, rec.M_IDate, rec.M_ITime, rec.M_ODate, rec.M_OTime]), [loPartialKey]) then
     begin
      Append;
      FieldByName('M_BarCode').AsString := rec.M_BarCode;
      FieldByName('M_Number').AsString := rec.M_Number;
//kaveh      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := rec.M_Serial;
//kaveh      FieldByName('M_CarName').AsString := m.M_CarName;
//kaveh      FieldByName('M_Color').AsString := m.M_Color;


      //XXXX
      //FieldByName('M_IDate').AsString := rec.M_IDate;
      //FieldByName('M_ITime').AsString := rec.M_ITime;
      //FieldByName('M_ODate').AsString := rec.M_ODate; //kaveh
      //FieldByName('M_OTime').AsString := rec.M_OTime; //kaveh
      FieldByName('M_IDate').AsString := '';
      FieldByName('M_ITime').AsString := '';
      FieldByName('M_ODate').AsString := rec.M_ODate;
      FieldByName('M_OTime').AsString := rec.M_OTime;
      //XXXX


//kaveh      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := False;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False; //kaveh new True=>False
      FieldByName('M_rdrCode').AsInteger := rec.M_rdrCode;
      FieldByName('M_OperatorCode').AsString := rec.M_OperatorCode; //kaveh
      FieldByName('M_PlaqueType').AsInteger := rec.M_PlaqueType; //kaveh
      FieldByName('M_PlaqueAppliance').AsInteger:= rec.M_PlaqueAppliance; //kaveh
      FieldByName('M_CitySerial').AsInteger := rec.M_CitySerial; //kaveh
      FieldByName('M_PayAble').AsFloat := rec.M_Payable; //kaveh
      FieldByName('M_Status').AsInteger := rec.M_Status; //kaveh

      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
     end;     
    Close;
    Filtered := False;
    Filter := '';
  except
    cancel;
  end;
end;

{ Return Perccent of takhfif }
function GetTakhfif(CarNumber, CarCity, CarSerial : String) : Integer;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Spc_Takhfif, Spc_Percent FROM Specials');
  qry.SQL.Add('WHERE Spc_Number = ''' + CarNumber + '''');
  qry.SQL.Add('AND Spc_City = ''' + CarCity + '''');
  if CarSerial <> '' then
    qry.SQL.Add('AND Spc_Serial = ''' + CarSerial + '''');
  qry.Open;
  if (qry.RecordCount > 0) and qry.FieldByName('Spc_Takhfif').AsBoolean then
    GetTakhfif := qry.FieldByName('Spc_Percent').AsInteger
  else
    GetTakhfif := 0;
  qry.Close;
  qry.Free;
end;

{ Return Price of type in range (new 1) }
function CalculPrice1(CarName, FDate, FTime, ToDate, ToTime : String) : Currency;
var
  minutes,days:integer;
  nerkh : TNerkhType;
  M:byte;
  price:currency;
  ftime1,totime1:integer;
function calcpriod(ftime,totime:integer):currency;
var
  i:byte;
  price:currency;
  t1:integer;
  remain:integer;
function pricelevel(mins,FixMin:integer;mablagh:currency;rounding:byte):currency;
var
    t:integer;
begin
    inc(mins,remain);
    case Rounding of
      MB_DOWN : t := Trunc((mins-1)/FixMin);
      MB_MID  : t := Round(mins/FixMin);
      MB_UP   : t := Trunc((mins-1)/FixMin)+1;
      else      t := 0;
    end;
    remain:=mins-fixmin*t;
    PriceLevel := t * Mablagh;
end;
begin
   price:=0;
   t1:=0;
   remain:=0;
   with nerkh do
   begin
       for i:=1 to 4 do
       with priods[i] do
       if maxmin>t1 then
       begin
         if ftime<t1
         then if totime<t1
              then begin
                   {a}
              end
              else if totime<maxmin
                   then begin
                        {b}
                        price:=price+pricelevel(totime-t1,fixmin,mablagh,rounding);
                   end
                   else begin
                        {f}
                        price:=price+pricelevel(maxmin-t1,fixmin,mablagh,rounding);
                   end
         else if ftime<maxmin
              then if totime<maxmin
                   then begin
                        {c}
                        price:=price+pricelevel(totime-ftime,fixmin,mablagh,rounding);
                   end
                   else begin
                        {d}
                        price:=price+pricelevel(maxmin-ftime,fixmin,mablagh,rounding);
                   end
              else begin
                   {e}
              end;
         t1:=maxmin;
       end;
   end;
   calcpriod:=price;
end;

begin
  m := FindTypeNo(CarName);
  if m <> 0 then
    nerkh := CarTypes[m].Type_Nerkh
  else
    nerkh := CarTypes[1].Type_Nerkh;
  minutes := Differ(FDate, FTime, ToDate, ToTime);
  ftime1:=timetoint(ftime);
  totime1:=timetoint(totime);
  days:=minutes div 1440;
  {adddate(Fdate,days);}
  minutes:=minutes-days*1440;
  with nerkh do
  begin
    price:=days*dailyprice;
    if minutes>0
    then price:=price+Voroodieh;
    if totime1>=ftime1
    then begin
         price:=price+calcpriod(ftime1,totime1);
    end
    else begin
         price:=price+calcpriod(ftime1,1440);
         price:=price+calcpriod(0,totime1);
    end;
  end;
  calculprice1 := price;
end;

{ Return Price of type in range }
function CalculPrice(CarName, FDate, FTime, ToDate, ToTime : String) : Currency;
var
  minutes:integer;
  nerkh : TNerkhType;
  n,M:byte;
  price:currency;
function PriceLevel(mins : Integer; n : Byte) : Currency;
var
  t, m : Integer;
begin
  if n = 0 then
  begin
    PriceLevel := 0;
    Exit;
  end;

  with nerkh do
    with Priods[n] do
    begin
      if IsFirst then
      begin
        case Rounding of
          MB_DOWN : t := Trunc(mins/FixMin);
          MB_MID  : t := Round(mins/FixMin);
          MB_UP   : t := Trunc((mins-1)/FixMin)+1;
          else      t := 0;
        end;
        PriceLevel := t * Mablagh;
        Exit;
      end
      else
      begin
        m := mins - Priods[n-1].MaxMin;
        case Rounding of
          MB_Down : t := Trunc(m/FixMin);
          MB_Mid  : t := Round(m/FixMin);
          MB_Up   : t := Trunc((m-1)/FixMin)+1;
          else      t := 0;
        end;
        PriceLevel := t * Mablagh + PriceLevel(Priods[n-1].Maxmin,n-1);
      end;
    end;
end;
begin
  calculprice := CalculPrice1(CarName, FDate, FTime, ToDate, ToTime );
end;

{ Calculate Price Field }
procedure CalculPriceField(var m : TMachines);
begin
  if not IsTrueDate(m.M_IDate) then
    m.M_IDate := CurrentDate;
  if not IsTrueTime(m.M_ITime) then
    m.M_ITime := CurrentTime;
    
  m.M_Price := CalculPrice(m.M_CarName, m.M_IDate, m.M_ITime, m.M_ODate, m.M_OTime);

  m.Takhfif := m.M_Price * m.Percent / 100;
  m.M_Payable := m.M_Price - m.Takhfif;

  if (m.M_Kind and MB_CUSTOMS) <> 0 then
  begin
    m.Remainder := GetCustomsRemain(m.M_Number, m.M_CityName, m.M_Serial);
    if m.M_Payable > m.Remainder then
    begin
      m.M_Payable := m.M_Payable - m.Remainder;
      m.Remainder := 0;
    end
    else
    begin
      m.Remainder := m.Remainder - m.M_Payable;
      m.M_Payable := 0;
    end;
  end;
end;


{ Save input car data in database }
procedure InputCar(var m : TMachines);
var TF : Boolean;
begin
  TF := False;
  m.M_Kind := CarStat(m.M_Number, m.M_CityName, m.M_Serial);
  with frmDBS.tblInputCar do
  begin
    //Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_Number = ''' + m.M_Number + ''' AND M_ITime = ''' + m.M_ITime + '''';
    Filter := 'M_BarCode = ''' + m.M_BarCode + ''''; 
    Filtered := True;
    Open;
    if not Locate('M_Barcode;M_Number;M_Serial;M_IDate;M_ITime;', VarArrayOf([m.M_BarCode, m.M_Number, m.M_Serial, m.M_IDate, m.M_ITime]), [loPartialKey]) then
    begin
      if RecordCount = 0 then
        Append
      else
//kaveh      Edit;
        Append; //kaveh
      FieldByName('M_BarCode').AsString := m.M_BarCode;
      FieldByName('M_Number').AsString := m.M_Number;
      FieldByName('M_CityName').AsString := m.M_CityName;
      FieldByName('M_Serial').AsString := m.M_Serial;
      FieldByName('M_CarName').AsString := m.M_CarName;
      FieldByName('M_Color').AsString := m.M_Color;
      FieldByName('M_IDate').AsString := m.M_IDate;
      FieldByName('M_ITime').AsString := m.M_ITime;
      FieldByName('M_IDoor').AsInteger := m.M_IDoor;
      FieldByName('M_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('M_IPerson').AsString := m.M_OperatorCode;
      FieldByName('M_Kind').AsInteger := m.M_Kind;
      FieldByName('M_IsPark').AsBoolean := True;
      FieldByName('M_Karshenasi').AsBoolean := False;
      FieldByName('M_Gholnameh').AsBoolean := False;
      FieldByName('M_ExitValid').AsBoolean := True;
      FieldByName('M_IsDeleted').AsBoolean := False;
      FieldByName('M_IUserName').AsString := m.M_IUserName; //kaveh
      FieldByName('M_Driver').AsString := m.M_Driver; //kaveh
      FieldByName('M_WorkDepart').AsInteger := m.M_WorkDepart; //kaveh
      FieldByName('M_Visited').AsString := m.M_Visited; //kaveh
      FieldByName('M_EntranceDepart').AsInteger := m.M_EntranceDepart; //kaveh

      Post;
      Inc(AllParkNo);
      Inc(DayParkNo);
      Inc(DayAriveNo);
      TF := True;
    end;
    Close;
    Filtered := False;
    Filter := '';
  end;
  if TF then
    ChngCapacity(m.M_CarName, -1);
end;

{ Undo Input Car from Database }
function UndoInCar(BarCode, IDoor : String) : TMachines;
var
  Rec : TMachines;
begin
  Rec.M_BarCode := '';
  Rec.M_CarName := '';
  Rec.M_Color := '';
  Rec.M_Number := '';
  Rec.M_CityName := '';
  Rec.M_Serial := '';
  Rec.M_IDate := '';
  Rec.M_ITime := '';
  Rec.M_IDoor := 0;
  Rec.M_IPerson := '';
//kaveh  Rec.M_OperatorCode := '';
  Rec.M_Kind := 0;
  with frmDBS.tblInputCar do
  begin                    
    Filtered := True;
    Filter := 'M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_BarCode = ''' + BarCode + ''' AND M_IDoor = ' + IDoor;
    Open;
    if not EOF then
    begin
      Rec.M_BarCode := FieldByName('M_BarCode').AsString;
      Rec.M_CarName := FieldByName('M_CarName').AsString;
      Rec.M_Color := FieldByName('M_Color').AsString;
      Rec.M_Number := FieldByName('M_Number').AsString;
      Rec.M_CityName := FieldByName('M_CityName').AsString;
      Rec.M_Serial := FieldByName('M_Serial').AsString;
      Rec.M_IDate := FieldByName('M_IDate').AsString;
      Rec.M_ITime := FieldByName('M_ITime').AsString;
      Rec.M_IDoor := FieldByName('M_IDoor').AsInteger;
      Rec.M_IPerson := FieldByName('M_IPerson').AsString;
//kaveh      Rec.M_OperatorCode := FieldByName('M_IPerson').AsString;
      Rec.M_Kind := FieldByName('M_Kind').AsInteger;
      Delete;
      Dec(AllParkNo);
      Dec(DayParkNo);
      Dec(DayAriveNo);
      ChngCapacity(Rec.M_CarName, 1);
    end;
    Close;
    Filtered := False;
    Filter := '';
  end;
end;

{ Set data in buffer and calculate price and return car status }
function OutputCar(var m : TMachines) : Integer;
begin
  with frmDBS.tblInputCar do
  begin
    Filter := 'M_Number = ''' + m.M_Number + ''' AND M_Serial = ''' + m.M_Serial + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_EntranceDepart = ' + IntToStr(g_Options.Department);
//kaveh    Filter := 'M_Number = ''' + m.M_Number + ''' AND M_Serial = ''' + m.M_Serial + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
//kaveh wrong    Filter := 'M_BarCode = ''' + m.M_BarCode + '''AND M_Number =' +  + 'AND M_IsDeleted = ' + IntToStr(CNST_FALSE);
    Filtered := True;
    Open;
    Sort := 'M_IDate, M_ITime';
    if RecordCount > 0 then
    begin
      Last;
      m.M_BarCode := FieldByName('M_BarCode').AsString;
      m.M_CarName := FieldByName('M_CarName').AsString;
      m.M_Color := FieldByName('M_Color').AsString;
      m.M_Number := FieldByName('M_Number').AsString;
      m.M_CityName := FieldByName('M_CityName').AsString;
      m.M_Serial := FieldByName('M_Serial').AsString;
      m.M_IDate := FieldByName('M_IDate').AsString;
      m.M_ITime := FieldByName('M_ITime').AsString;
      m.M_IDoor := FieldByName('M_IDoor').AsInteger;
      m.M_IPerson := FieldByName('M_IPerson').AsString;
//kaveh      m.M_OperatorCode := FieldByName('M_IPerson').AsString;
      m.M_Kind := FieldByName('M_Kind').AsInteger;
      m.M_KarShenasi := FieldByName('M_Karshenasi').AsBoolean;
      m.M_Gholnameh := FieldByName('M_Gholnameh').AsBoolean;
      m.M_ExitValid := FieldByName('M_ExitValid').AsBoolean;
      m.M_Driver := FieldByName('M_Driver').AsString; //kaveh
      m.M_WorkDepart := FieldByName('M_WorkDepart').AsInteger; //kaveh
      m.M_Visited := FieldByName('M_Visited').AsString; //kaveh
      m.M_EntranceDepart := FieldByName('M_EntranceDepart').AsInteger; //kaveh
      m.M_IUserName := FieldByName('M_IUserName').AsString; //kaveh

      if (m.M_Kind and MB_TAKHFIF) <> 0 then
        m.Percent := GetTakhfif(m.m_Number, m.M_CityName, m.M_Serial)
      else
        m.Percent := 0;

      if (m.M_Kind and MB_CUSTOMS) <> 0 then
        m.Remainder := GetCustomsRemain(m.m_Number, m.M_CityName, m.M_Serial)
      else
        m.Remainder := 0;

      CalculPriceField(m);

      if (m.M_Kind and MB_MOTAVARI) <> 0 then
      begin
        OutputCar := m.M_Kind;
        {PlayMessage(MSG_MOTAVARI);}
        Beep;Beep;Beep;Beep;Beep;Beep;
      end
      else if (m.M_Kind and MB_NOTEXIT) <> 0 then
      begin
        OutputCar := m.M_Kind;
        {PlayMessage(MSG_NOTEXIT);}
        Beep;Beep;Beep;Beep;Beep;Beep;
      end
      else if not m.M_ExitValid then
        OutputCar := MB_GHOLNAMEH
      else
        OutputCar := 0;
    end
    else
    begin
      m.M_Kind := MB_NOTEXIST;
      OutputCar := m.M_Kind;
    end;
    Close;
    Filtered := False;
    Filter := '';
  end;
end;

{ new version-Set data in buffer and calculate price and return car status }
function newOutputCar(var m : TMachines) : Integer;
begin
  with frmDBS.tblInputCar do
  begin
//kaveh new    Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
    Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_Number = ''' + m.M_Number + ''' AND M_IDate = ''' + m.M_IDate + ''' AND M_ITime = ''' + m.M_ITime + '''';
    Filtered := True;
    Open;
    if RecordCount > 0 then
    begin
      Last;
      m.M_BarCode := FieldByName('M_BarCode').AsString;
      m.M_CarName := FieldByName('M_CarName').AsString;
      m.M_Color := FieldByName('M_Color').AsString;
      m.M_Number := FieldByName('M_Number').AsString;
      m.M_CityName := FieldByName('M_CityName').AsString;
      m.M_Serial := FieldByName('M_Serial').AsString;
      m.M_IDate := FieldByName('M_IDate').AsString;
      m.M_ITime := FieldByName('M_ITime').AsString;
      m.M_IDoor := FieldByName('M_IDoor').AsInteger;
      m.M_IPerson := FieldByName('M_IPerson').AsString;
//kaveh      m.M_OperatorCode := FieldByName('M_IPerson').AsString;
      m.M_Kind := FieldByName('M_Kind').AsInteger;
      m.M_KarShenasi := FieldByName('M_Karshenasi').AsBoolean;
      m.M_Gholnameh := FieldByName('M_Gholnameh').AsBoolean;
      m.M_ExitValid := FieldByName('M_ExitValid').AsBoolean;

      if (m.M_Kind and MB_TAKHFIF) <> 0 then
        m.Percent := GetTakhfif(m.m_Number, m.M_CityName, m.M_Serial)
      else
        m.Percent := 0;

      if (m.M_Kind and MB_CUSTOMS) <> 0 then
        m.Remainder := GetCustomsRemain(m.m_Number, m.M_CityName, m.M_Serial)
      else
        m.Remainder := 0;

      CalculPriceField(m);

      if (m.M_Kind and MB_MOTAVARI) <> 0 then
      begin
        newOutputCar := m.M_Kind;
        {PlayMessage(MSG_MOTAVARI);}
        Beep;Beep;Beep;Beep;Beep;Beep;
      end
      else if (m.M_Kind and MB_NOTEXIT) <> 0 then
      begin
        newOutputCar := m.M_Kind;
        {PlayMessage(MSG_NOTEXIT);}
        Beep;Beep;Beep;Beep;Beep;Beep;
      end
      else if not m.M_ExitValid then
        newOutputCar := MB_GHOLNAMEH
      else
        newOutputCar := 0;
    end
    else
    begin
      m.M_Kind := MB_NOTEXIST;
      newOutputCar := m.M_Kind;
    end;
    Close;
    Filtered := False;
    Filter := '';
  end;
end;

{ Save Output car data in database }
procedure UpdateOutputCar(var m : TMachines);
begin
  if m.M_BarCode <> '' then
  begin
    with frmDBS do
    begin

      tblInputCar.Filter := 'M_Number = ''' + m.M_Number + ''' AND M_Serial = ''' + m.M_Serial + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
//kaveh880304      tblInputCar.Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
      tblInputCar.Filtered := True;
      tblInputCar.Open;
      tblInputCar.Sort := 'M_IDate, M_ITime';

      if tblInputCar.RecordCount > 0 then
      begin
        tblMachines.Open;
        tblMachines.Append;
        tblInputCar.Last;
        tblMachines.FieldByName('M_BarCode').AsString := tblInputCar.FieldByName('M_BarCode').AsString;
        tblMachines.FieldByName('M_CarName').AsString := tblInputCar.FieldByName('M_CarName').AsString;
        tblMachines.FieldByName('M_Number').AsString := tblInputCar.FieldByName('M_Number').AsString;
        tblMachines.FieldByName('M_CityName').AsString := tblInputCar.FieldByName('M_CityName').AsString;
        tblMachines.FieldByName('M_Serial').AsString := tblInputCar.FieldByName('M_Serial').AsString;
        tblMachines.FieldByName('M_Color').AsString := tblInputCar.FieldByName('M_Color').AsString;
        tblMachines.FieldByName('M_Kind').AsString := tblInputCar.FieldByName('M_Kind').AsString;
        tblMachines.FieldByName('M_IDate').AsString := tblInputCar.FieldByName('M_IDate').AsString;
        tblMachines.FieldByName('M_ITime').AsString := tblInputCar.FieldByName('M_ITime').AsString;
        tblMachines.FieldByName('M_IPerson').AsString := tblInputCar.FieldByName('M_IPerson').AsString;
        tblMachines.FieldByName('M_IDoor').AsString := tblInputCar.FieldByName('M_IDoor').AsString;
        tblMachines.FieldByName('M_ODate').AsString := m.M_ODate;
        tblMachines.FieldByName('M_OTime').AsString := m.M_OTime;
        tblMachines.FieldByName('M_ODoor').AsInteger := m.M_ODoor;
        tblMachines.FieldByName('M_OPerson').AsString := m.M_OPerson;
//kaveh        tblMachines.FieldByName('M_OPerson').AsString := m.M_OperatorCode;
        tblMachines.FieldByName('M_Price').AsCurrency := m.M_Price;
        tblMachines.FieldByName('M_PayAble').AsCurrency := m.M_Payable;
        tblMachines.FieldByName('M_Slake').AsCurrency := m.M_Slake; //kaveh
        tblMachines.FieldByName('M_IsPark').AsBoolean := False;
        tblMachines.FieldByName('M_Karshenasi').AsBoolean := tblInputCar.FieldByName('M_Karshenasi').AsBoolean;
        tblMachines.FieldByName('M_Gholnameh').AsBoolean := tblInputCar.FieldByName('M_Gholnameh').AsBoolean;
        tblMachines.FieldByName('M_ExitValid').AsBoolean := tblInputCar.FieldByName('M_ExitValid').AsBoolean;
        tblMachines.FieldByName('M_ExitValid').AsBoolean := tblInputCar.FieldByName('M_ExitValid').AsBoolean;
        tblMachines.FieldByName('M_IsDeleted').AsBoolean := False; //kaveh new True=>False
        tblMachines.FieldByName('M_UserName').AsString := m.M_UserName; //kaveh
        tblMachines.FieldByName('M_Driver').AsString := m.M_Driver; //kaveh
        tblMachines.FieldByName('M_WorkDepart').AsInteger := m.M_WorkDepart; //kaveh
        tblMachines.FieldByName('M_Visited').AsString := m.M_Visited; //kaveh
        tblMachines.FieldByName('M_EntranceDepart').AsInteger := m.M_EntranceDepart; //kaveh
        tblMachines.FieldByName('M_IUserName').AsString := m.M_IUserName;

        if tblMachines.FieldByName('M_IDate').AsString = CurrentDate then
          Dec(DayParkNo);
        tblMachines.Post;
        tblMachines.Close;
//kaveh new 871204        tblInputCar.Delete;
//kaveh is 871204
        tblInputCar.Edit;
        tblInputCar.FieldByName('M_IsPark').AsBoolean := False;
        tblInputCar.Post;
        tblInputCar.Close;
//kaveh ie 871204
        Dec(AllParkNo);
        Inc(DayExitNo)
      end;
      tblInputCar.Close;
      tblInputCar.Filtered := False;
      tblInputCar.Filter := '';
    end;
    if (m.M_Kind and MB_CUSTOMS) <> 0 then
      SetCustomsRemain(m.m_Number, m.M_CityName, m.M_Serial, m.Remainder);
    ChngCapacity(m.M_CarName, 1);
  end;
end;

{ new version-Save Output car data in database }
procedure newUpdateOutputCar(var m : TMachines);
begin
 try
 begin
  if m.M_BarCode <> '' then
  begin
    with frmDBS do
    begin
//      tblInputCar.Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
      tblInputCar.Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_Number = ''' + m.M_Number + ''' AND M_IDate = ''' + m.M_IDate + ''' AND M_ITime = ''' + m.M_ITime + '''';
      tblInputCar.Filtered := True;
      tblInputCar.Open;


      if tblInputCar.RecordCount > 0 then
      begin
        tblMachines.Open;
        tblMachines.Append;
//kaveh new        tblInputCar.Last;
        tblInputCar.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([m.M_BarCode, m.M_Number, m.M_IDate, m.M_ITime]), [loPartialKey]);
        tblMachines.FieldByName('M_BarCode').AsString := tblInputCar.FieldByName('M_BarCode').AsString;
        tblMachines.FieldByName('M_CarName').AsString := tblInputCar.FieldByName('M_CarName').AsString;
        tblMachines.FieldByName('M_Number').AsString := tblInputCar.FieldByName('M_Number').AsString;
        tblMachines.FieldByName('M_CityName').AsString := tblInputCar.FieldByName('M_CityName').AsString;
        tblMachines.FieldByName('M_Serial').AsString := tblInputCar.FieldByName('M_Serial').AsString;
        tblMachines.FieldByName('M_Color').AsString := tblInputCar.FieldByName('M_Color').AsString;
        tblMachines.FieldByName('M_Kind').AsString := tblInputCar.FieldByName('M_Kind').AsString;
        tblMachines.FieldByName('M_IDate').AsString := tblInputCar.FieldByName('M_IDate').AsString;
        tblMachines.FieldByName('M_ITime').AsString := tblInputCar.FieldByName('M_ITime').AsString;
        tblMachines.FieldByName('M_IPerson').AsString := tblInputCar.FieldByName('M_IPerson').AsString;
        tblMachines.FieldByName('M_IDoor').AsString := tblInputCar.FieldByName('M_IDoor').AsString;
        tblMachines.FieldByName('M_ODate').AsString := m.M_ODate;
        tblMachines.FieldByName('M_OTime').AsString := m.M_OTime;
        tblMachines.FieldByName('M_ODoor').AsInteger := m.M_ODoor;
        tblMachines.FieldByName('M_OPerson').AsString := m.M_OPerson;
        tblMachines.FieldByName('M_PlaqueType').AsString := tblInputCar.FieldByName('M_PlaqueType').AsString; //kaveh i
        tblMachines.FieldByName('M_PlaqueAppliance').AsString := tblInputCar.FieldByName('M_PlaqueAppliance').AsString; //kaveh i
        tblMachines.FieldByName('M_CitySerial').AsString := tblInputCar.FieldByName('M_CitySerial').AsString; //kaveh i
//kaveh        tblMachines.FieldByName('M_OPerson').AsString := m.M_OperatorCode;
        tblMachines.FieldByName('M_Price').AsCurrency := m.M_Price;
        tblMachines.FieldByName('M_PayAble').AsCurrency := m.M_Payable;
        tblMachines.FieldByName('M_IsPark').AsBoolean := False;
        tblMachines.FieldByName('M_Karshenasi').AsBoolean := tblInputCar.FieldByName('M_Karshenasi').AsBoolean;
        tblMachines.FieldByName('M_Gholnameh').AsBoolean := tblInputCar.FieldByName('M_Gholnameh').AsBoolean;
        tblMachines.FieldByName('M_ExitValid').AsBoolean := tblInputCar.FieldByName('M_ExitValid').AsBoolean;
        tblMachines.FieldByName('M_ExitValid').AsBoolean := tblInputCar.FieldByName('M_ExitValid').AsBoolean;
        tblMachines.FieldByName('M_IsDeleted').AsBoolean := False; //kaveh new True=>False
        if tblMachines.FieldByName('M_IDate').AsString = CurrentDate then
          Dec(DayParkNo);
        tblMachines.Post;
        tblMachines.Close;
//kaveh new 871204        tblInputCar.Delete;
//kaveh is 871204
        tblinputcar.Filtered := False;
        tblInputCar.Close;
        tblInputCar.Open;
        tblInputCar.Locate('M_Barcode;M_Number;M_IDate;M_ITime;', VarArrayOf([m.M_BarCode, m.M_Number, m.M_IDate, m.M_ITime]), [loPartialKey]);
        tblInputCar.Edit;
        tblInputCar.FieldByName('M_IsPark').AsBoolean := False;
        tblInputCar.Post;
        tblInputCar.Close;
//kaveh ie 871204
        Dec(AllParkNo);
        Inc(DayExitNo)
      end;
      tblInputCar.Close;
      tblInputCar.Filtered := False;
      tblInputCar.Filter := '';
    end;
    if (m.M_Kind and MB_CUSTOMS) <> 0 then
      SetCustomsRemain(m.m_Number, m.M_CityName, m.M_Serial, m.Remainder);
    ChngCapacity(m.M_CarName, 1);
  end;
 end;
 finally
 end;
end;

{ Change karshenasi property car data in database }
procedure ChangeKarshenasi(var m : TMachines);
begin
  with frmDBS.tblInputCar do
  begin
    Filter := 'M_BarCode = ''' + m.M_BarCode + ''' AND M_IsPark = ' + IntToStr(CNST_TRUE);
    Filtered := True;
    Open;
    if RecordCount > 0 then
    begin
      Last;
      Edit;
      FieldByName('M_Karshenasi').AsBoolean := m.M_KarShenasi;
      FieldByName('M_Gholnameh').AsBoolean := m.M_Gholnameh;
      FieldByName('M_ExitValid').AsBoolean := m.M_ExitValid;
      Post;
    end;
    Close;
    Filtered := False;
    Filter := '';
  end;
end;


{ Undo Output Car From database }
procedure UndoOutcar(number, idoor : String);
begin
  with frmDBS.tblInputCar do
  begin                         
    Filtered := True;
    Filter := 'M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_Nmber = ''' + number + ' AND M_Idoor = ' + idoor;
    Open;
    if not EOF then
      ChngCapacity(FieldByName('M_CarName').AsString, -1);
    Close;
    Filtered := False;
    Filter := '';
  end;
end;

{ Add a record in NoCard database }
procedure AddExitNoCard(m : TMachines);
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.adoConnect;
  tbl.TableName := 'NoCard';
  tbl.Open;
  tbl.Append;
  tbl.FieldByName('N_Number').AsString := m.M_Number;
  tbl.FieldByName('N_City').AsString := m.M_CityName;
  tbl.FieldByName('N_Serial').AsString := m.M_Serial;
  tbl.FieldByName('N_BarCode').AsString := m.M_BarCode;
  tbl.FieldByName('N_Name').AsString := m.M_CarName;
  tbl.FieldByName('N_Color').AsString := m.M_Color;
  tbl.FieldByName('N_ExitDate').AsString := m.M_ODate;
  tbl.FieldByName('N_ExitTime').AsString := m.M_OTime;
  tbl.FieldByName('N_Describe').AsString := m.N_Describe;
  tbl.FieldByName('N_Madarek').AsString := m.N_Madarek;
  tbl.FieldByName('M_IsDeleted').AsBoolean := False; //kaveh new
  tbl.Post;
  if m.M_IDate = CurrentDate then
    Dec(DayParkNo);
  Dec(AllParkNo);
  Inc(DayExitNo);
  tbl.Close;
  tbl.Free;
end;

{ new version-Add a record in NoCard database }
procedure newAddExitNoCard(m : TMachines);
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.adoConnect;
  tbl.TableName := 'NoCard';
  tbl.Open;
  tbl.Append;
  tbl.FieldByName('N_Number').AsString := m.M_Number;
  tbl.FieldByName('N_City').AsString := m.M_CityName;
  tbl.FieldByName('N_Serial').AsString := m.M_Serial;
  tbl.FieldByName('N_BarCode').AsString := m.M_BarCode;
  tbl.FieldByName('N_Name').AsString := m.M_CarName;
  tbl.FieldByName('N_Color').AsString := m.M_Color;
  tbl.FieldByName('N_ExitDate').AsString := m.M_ODate;
  tbl.FieldByName('N_ExitTime').AsString := m.M_OTime;
  tbl.FieldByName('N_Describe').AsString := m.N_Describe;
  tbl.FieldByName('N_Madarek').AsString := m.N_Madarek;
  tbl.FieldByName('N_IsDeleted').AsBoolean := False;
  tbl.Post;
  if m.M_IDate = CurrentDate then
    Dec(DayParkNo);
  Dec(AllParkNo);
  Inc(DayExitNo);
  tbl.Close;
  tbl.Free;
end;

{ Add Record from InputCar to Machines database }
procedure AddRecToMachine;
begin
{kaveh  DelRecFromMachine;
  with frmDBS.qryDBS do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO Machines SELECT * FROM InputCar');
    ExecSQL;
  end;}
end;

{ Delete records from machines }
procedure DelRecFromMachine;
begin
{kaveh new  with frmDBS.qryDBS do
  begin
    SQL.Clear;
    SQL.Add('DELETE FROM Machines WHERE M_IsDeleted = ' + IntToStr(CNST_FALSE));
    ExecSQL;
  end; kaveh new}
end;

{ Get Company Car Properties from database }
procedure GetCoCar(BarCode : String; var m : TMachines);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
    SQL.Clear;
    SQL.Add('SELECT * FROM CoCars WHERE Co_BarCode = ''' + BarCode + '''');
    Open;
    if RecordCount > 0 then
    begin
      m.M_BarCode := BarCode;
      m.M_CarName := FieldByName('Co_Name').AsString;
      m.M_Number := FieldByName('Co_CarNumber').AsString;
      m.M_CityName := FieldByName('Co_City').AsString;
      m.M_Serial := FieldByName('Co_Serial').AsString;
      m.M_Color := FieldByName('Co_Color').AsString;
    end;
    Close;
    Free;
  end;
end;

{ Exit a Company Car from parking }
procedure ExitOutputCoCar(m : TMachines);
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.adoConnect;
  tbl.TableName := 'InOutCo';
  tbl.Open;
  tbl.Append;
  tbl.FieldByName('IO_BarCode').AsString := m.M_BarCode;
  tbl.FieldByName('IO_CarNumber').AsString := m.M_Number;
  tbl.FieldByName('IO_Serial').AsString := m.M_Serial;
  tbl.FieldByName('IO_Driver').AsString := m.Co_Driver;
//kaveh  tbl.FieldByName('IO_ODoor').AsInteger := m.M_ODoor;
//kaveh  tbl.FieldByName('IO_OPerson').AsString := m.M_OPerson;
//kaveh  tbl.FieldByName('IO_OPerson').AsString := m.M_OperatorCode;
  tbl.FieldByName('IO_ODate').AsString := m.M_ODate;
  tbl.FieldByName('IO_OTime').AsString := m.M_OTime;
  tbl.FieldByName('IO_OAmper').AsInteger := m.Co_OAmper;
  tbl.FieldByName('IO_Target').AsString := m.Co_Target;
  tbl.FieldByName('IO_Mojavez').AsString := m.Co_Mojavez;
  tbl.FieldByName('IO_Describe').AsString := m.Co_Describe;
  tbl.FieldByName('IO_IsPark').AsBoolean := False;
  tbl.FieldByName('IO_ODepart').AsInteger := m.Co_ODepart;
  tbl.Post;
  tbl.Close;
  tbl.Free;
end;

{ Request for arive company car }
function RequestArivalCo(BarCode : String;var m : TMachines) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
    SQL.Clear;
    SQL.Add('SELECT * FROM CoCars, InOutCo WHERE Io_BarCode = Co_BarCode');
    SQL.Add('AND Co_BarCode = ''' + BarCode + '''');
    SQL.Add('AND IO_IsPark = ' + IntToStr(CNST_FALSE));
    Open;
    if RecordCount > 0 then
    begin
      Last;
      m.M_BarCode := FieldByName('IO_BarCode').AsString;
      m.M_CarName := FieldByName('Co_Name').AsString;
      m.M_Number := FieldByName('Co_CarNumber').AsString;
      m.M_CityName := FieldByName('Co_City').AsString;
      m.M_Serial := FieldByName('Co_Serial').AsString;
      m.M_Color := FieldByName('Co_Color').AsString;
      m.M_ODate := FieldByName('IO_ODate').AsString;
      m.M_OTime := FieldByName('IO_OTime').AsString;
      m.Co_Driver := FieldByName('IO_Driver').AsString;
      m.Co_OAmper := FieldByName('IO_OAmper').AsInteger;
      RequestArivalCo := True;
    end
    else
      RequestArivalCo := False;
    Close;
    Free;
  end;
end;


{ Request for arive company car By CarNumber and Serial}
function  RequestArivalCoByNumber(CarNumber, Serial : String; var m : TMachines) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
{
    SQL.Clear;
    SQL.Add('SELECT InOutCo.IO_CarNumber, InOutCo.IO_Serial, CoCars.Co_Name, CoCars.Co_Color, InOutCo.IO_BarCode, InOutCo.IO_ODate, ');
    SQL.Add('InOutCo.IO_OTime, InOutCo.IO_ODoor, InOutCo.IO_OAmper, InOutCo.IO_IsPark, InOutCo.IO_Driver ');
    SQL.Add('FROM InOutCo INNER JOIN ');
    SQL.Add('CoCars ON InOutCo.IO_CarNumber = CoCars.Co_CarNumber AND InOutCo.IO_Serial = CoCars.Co_Serial ');
    SQL.Add('WHERE (IO_CarNumber = ''' + CarNumber + ''') AND (IO_Serial = ''' + Serial + ''') ');
    SQL.Add('AND (InOutCo.IO_IsPark = ' + IntToStr(CNST_FALSE) + ') ');
}
    SQL.Add('SELECT InOutCo.IO_CarNumber, InOutCo.IO_Serial, CoCars.Co_Name, CoCars.Co_Color, InOutCo.IO_BarCode, InOutCo.IO_ODate, ');
    SQL.Add('InOutCo.IO_OTime, InOutCo.IO_ODoor, InOutCo.IO_OAmper, InOutCo.IO_IsPark, InOutCo.IO_Driver, NewPersons.P_Name, ');
    SQL.Add('NewPersons.P_Family ');
    SQL.Add('FROM InOutCo LEFT OUTER JOIN ');
    SQL.Add('CoCars ON InOutCo.IO_CarNumber = CoCars.Co_CarNumber AND InOutCo.IO_Serial = CoCars.Co_Serial LEFT OUTER JOIN ');
    SQL.Add('NewPersons ON InOutCo.IO_Driver = NewPersons.P_Code ');
    SQL.Add('WHERE (IO_CarNumber = ''' + CarNumber + ''') AND (IO_Serial = ''' + Serial + ''') ');
    SQL.Add('AND (IO_IsPark = ' + IntToStr(CNST_FALSE) + ') ');
    
{    SQL.Add('WHERE (InOutCo.IO_IsPark = 0)' );
    SQL.Add('SELECT * FROM CoCars, InOutCo WHERE Io_BarCode = Co_BarCode');
    SQL.Add('AND Co_BarCode = ''' + BarCode + '''');
    SQL.Add('AND IO_IsPark = ' + IntToStr(CNST_FALSE));  }
    Open;
    if RecordCount > 0 then
    begin
      Last;
      m.M_BarCode := FieldByName('IO_BarCode').AsString;
      m.M_CarName := FieldByName('Co_Name').AsString;
      m.M_Number := FieldByName('IO_CarNumber').AsString;
//kaveh      m.M_CityName := FieldByName('Co_City').AsString;
      m.M_Serial := FieldByName('IO_Serial').AsString;
      m.M_Color := FieldByName('Co_Color').AsString;
      m.M_ODate := FieldByName('IO_ODate').AsString;
      m.M_OTime := FieldByName('IO_OTime').AsString;
      m.Co_Driver := FieldByName('P_Family').AsString + '-' + FieldByName('P_Name').AsString + ' (' + FieldByName('IO_Driver').AsString + ')';
//kaveh      m.Co_Driver := FieldByName('IO_Driver').AsString;

      m.Co_OAmper := FieldByName('IO_OAmper').AsInteger;
      RequestArivalCoByNumber := True;
    end
    else
      RequestArivalCoByNumber := False;
    Close;
    Free;
  end;
end;

{ Request for Exit company car By CarNumber and Serial}
function  RequestExitCoByNumber(CarNumber, Serial : String; var m : TMachines) : Boolean;
//function  RequestArivalCoByNumber(CarNumber, Serial : String; var m : TMachines) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
    SQL.Clear;
{
    SQL.Add('SELECT InOutCo.IO_CarNumber, InOutCo.IO_Serial, CoCars.Co_Name, CoCars.Co_Color, InOutCo.IO_BarCode, InOutCo.IO_ODate, ');
    SQL.Add('InOutCo.IO_OTime, InOutCo.IO_ODoor, InOutCo.IO_OAmper, InOutCo.IO_IsPark, InOutCo.IO_Driver ');
    SQL.Add('FROM InOutCo INNER JOIN ');
    SQL.Add('CoCars ON InOutCo.IO_CarNumber = CoCars.Co_CarNumber AND InOutCo.IO_Serial = CoCars.Co_Serial ');
    SQL.Add('WHERE (IO_CarNumber = ''' + CarNumber + ''') AND (IO_Serial = ''' + Serial + ''') ');
    SQL.Add('AND (InOutCo.IO_IsPark = ' + IntToStr(CNST_FALSE) + ') ');
}
    SQL.Add('SELECT IO_CarNumber, IO_Serial, IO_BarCode, IO_IsPark ');
    SQL.Add('FROM InOutCo ');
    SQL.Add('WHERE (IO_CarNumber = ''' + CarNumber + ''') AND (IO_Serial = ''' + Serial + ''') ');
    SQL.Add('AND (InOutCo.IO_IsPark = ' + IntToStr(CNST_FALSE) + ') ');
{    SQL.Add('WHERE (InOutCo.IO_IsPark = 0)' );

    SQL.Add('SELECT * FROM CoCars, InOutCo WHERE Io_BarCode = Co_BarCode');
    SQL.Add('AND Co_BarCode = ''' + BarCode + '''');
    SQL.Add('AND IO_IsPark = ' + IntToStr(CNST_FALSE));  }
    Open;
    if RecordCount > 0 then
    begin
      RequestExitCoByNumber := False;
{      Last;
      m.M_BarCode := FieldByName('IO_BarCode').AsString;
      m.M_CarName := FieldByName('Co_Name').AsString;
      m.M_Number := FieldByName('IO_CarNumber').AsString;
//kaveh      m.M_CityName := FieldByName('Co_City').AsString;
      m.M_Serial := FieldByName('IO_Serial').AsString;
      m.M_Color := FieldByName('Co_Color').AsString;
      m.M_ODate := FieldByName('IO_ODate').AsString;
      m.M_OTime := FieldByName('IO_OTime').AsString;
      m.Co_Driver := FieldByName('IO_Driver').AsString;
      m.Co_OAmper := FieldByName('IO_OAmper').AsInteger;
      }
    end
    else
    begin
      SQL.Clear;
      SQL.Add('SELECT Co_BarCode, Co_CarNumber, Co_Serial , Co_Name, Co_Color ');
      SQL.Add('FROM CoCars ');
      SQL.Add('WHERE (Co_CarNumber = ''' + CarNumber + ''') AND (Co_Serial = ''' + Serial + ''') ');
      Open;
      if RecordCount > 0 then
      begin
        Last;
        m.M_BarCode := FieldByName('Co_BarCode').AsString;
        m.M_Number := FieldByName('Co_CarNumber').AsString;
//kaveh        m.M_CityName := FieldByName('Co_City').AsString;
        m.M_Serial := FieldByName('Co_Serial').AsString;
        m.M_CarName := FieldByName('Co_Name').AsString;
        m.M_Color := FieldByName('Co_Color').AsString;
        RequestExitCoByNumber := True;
      end
      else
        RequestExitCoByNumber := False;
    end;
    Close;
    Free;
  end;
end;


{ Save arive company car }
procedure UpdateArivalCo(BarCode : String; m : TMachines);
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  with tbl do
  begin
    connection := frmDBS.adoConnect;
    TableName := 'InOutCo';
    Filtered := True;
    Filter := 'IO_IsPark = ' + IntToStr(CNST_FALSE) + ' AND IO_BarCode = ''' + BarCode + '''';
    Open;
    if not EOF then
    begin
      Last;
      Edit;
      FieldByName('IO_IDate').AsString := m.M_IDate;
      FieldByName('IO_ITime').AsString := m.M_ITime;
      FieldByName('IO_IDoor').AsInteger := m.M_IDoor;
      FieldByName('IO_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('IO_IPerson').AsString := m.M_OperatorCode;
      FieldByName('IO_IAmper').AsInteger := m.Co_IAmper;
      FieldByName('IO_IsPark').AsBoolean := True;
      Post;
    end;
    Close;
    Free;
  end;
end;

{ Save arive company car By CarNumber and Serial}
procedure UpdateArivalCoByNumber(CarNumber, Serial : String; m : TMachines);
var tbl : TAdoTable;
begin
  tbl := TAdoTable.Create(Application);
  with tbl do
  begin
    connection := frmDBS.adoConnect;
    TableName := 'InOutCo';
    Filtered := True;
    Filter := 'IO_IsPark = ' + IntToStr(CNST_FALSE) + ' AND IO_CarNumber = ''' + CarNumber + ''' AND IO_Serial = ''' + Serial + '''';
    Open;
    if not EOF then
    begin
      Last;
      Edit;
      FieldByName('IO_IDate').AsString := m.M_IDate;
      FieldByName('IO_ITime').AsString := m.M_ITime;
//kaveh      FieldByName('IO_IDoor').AsInteger := m.M_IDoor;
//kaveh      FieldByName('IO_IPerson').AsString := m.M_IPerson;
//kaveh      FieldByName('IO_IPerson').AsString := m.M_OperatorCode;
      FieldByName('IO_IAmper').AsInteger := m.Co_IAmper;
      FieldByName('IO_IsPark').AsBoolean := True;
      Post;
    end;
    Close;
    Free;
  end;
end;

procedure LoadExit_Park;
var qry : TAdoQuery;
begin
  AddRecToMachine;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
//kaveh  qry.SQL.Add('SELECT M_BarCode FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
  qry.Open;
  AllParkNo := qry.RecordCount;
  qry.Close;

  qry.SQL.Clear;
//kaveh  qry.SQL.Add('SELECT M_BarCode FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('AND M_IDate = ''' + CurrentDate + '''');
  qry.Open;
  DayParkNo := qry.RecordCount;
  qry.Close;

  qry.SQL.Clear;
//kaveh  qry.SQL.Add('SELECT M_BarCode FROM Machines WHERE M_IDate = ''' + CurrentDate + '''');
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_IDate = ''' + CurrentDate + ''' AND M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
  qry.Open;
  DayAriveNo := qry.RecordCount;
  qry.Close;

  qry.SQL.Clear;
//kaveh  qry.SQL.Add('SELECT M_BarCode FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
  qry.SQL.Add('SELECT M_BarCode FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE)+ ' AND M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('AND M_ODate = ''' + CurrentDate + '''');
  qry.Open;
  DayExitNo := qry.RecordCount;
  qry.Close;

  qry.Free;

  DelRecFromMachine;
end;


{ create a table in database }
function CreateTable(tblName : String; IsUpgrade : Boolean) : Boolean;
var
  strList : Tstrings;
  i : Integer;
begin
  strList := TStringList.Create;
  frmDBS.adoConnect.GetTableNames(strList, False);
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

    if tblName = 'BarCodes' then
    begin
      SQL.Add('(');
      SQL.Add(' [Card_Code] [nvarchar] (8) NULL ,');
      SQL.Add(' [Card_State] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Capacity' then
    begin
      SQL.Add('(');
      SQL.Add(' [Cap_MaxPlan] [smallint] NULL ,');
      SQL.Add(' [Cap_StartPlan] [smallint] NULL ,');
      SQL.Add(' [Cap_Plan] [smallint] NULL ,');
      SQL.Add(' [Cap_TypeCode] [smallint] NULL ,');
      SQL.Add(' [Cap_Max] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'CarPark' then
    begin
      SQL.Add('(');
      SQL.Add(' [P_Number] [nvarchar] (6) NULL ,');
      SQL.Add(' [P_City] [nvarchar] (15) NULL ,');
      SQL.Add(' [P_Serial] [nvarchar] (2) NULL ,');
      SQL.Add(' [P_Color] [nvarchar] (15) NULL ,');
      SQL.Add(' [P_CarName] [nvarchar] (15) NULL ,');
      SQL.Add(' [P_Date] [nvarchar] (10) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Diff' then
    begin
      SQL.Add('(');
      SQL.Add(' [D_Number] [nvarchar] (6) NULL ,');
      SQL.Add(' [D_City] [nvarchar] (15) NULL ,');
      SQL.Add(' [D_Serial] [nvarchar] (2) NULL ,');
      SQL.Add(' [D_Color] [nvarchar] (15) NULL ,');
      SQL.Add(' [D_CarName] [nvarchar] (15) NULL ,');
      SQL.Add(' [D_Date] [nvarchar] (10) NULL ,');
      SQL.Add(' [D_Type] [smallint] NULL ,');
      SQL.Add(' [D_BarCode1] [nvarchar] (8) NULL ,');
      SQL.Add(' [D_Barcode2] [nvarchar] (8) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Cars' then
    begin
      SQL.Add('(');
      SQL.Add(' [Car_Name] [nvarchar] (15) NULL ,');
      SQL.Add(' [Car_Code] [smallint] NULL ,');
      SQL.Add(' [Car_Type] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'CarTypes' then
    begin
      SQL.Add('(');
      SQL.Add(' [Type_Code] [smallint] NULL ,');
      SQL.Add(' [Type_Name] [nvarchar] (15) NULL ,');
      SQL.Add(' [Type_Vorood] [float] NULL ,');
      SQL.Add(' [Type_FirstTime] [int] NULL ,');
      SQL.Add(' [Type_FirstTime1] [smallint] NULL ,');
      SQL.Add('	[Type_FirstPrice] [float] NULL ,');
      SQL.Add('	[Type_FirstRounding] [smallint] NULL ,');
      SQL.Add('	[Type_SecondTime] [int] NULL ,');
      SQL.Add('	[Type_SecondTime2] [smallint] NULL ,');
      SQL.Add('	[Type_SecondIsFirst] [bit] NOT NULL ,');
      SQL.Add('	[Type_SecondRounding] [smallint] NULL ,');
      SQL.Add('	[Type_SecondPrice] [float] NULL ,');
      SQL.Add('	[Type_ThirdTime] [int] NULL ,');
      SQL.Add('	[Type_ThirdTime3] [smallint] NULL ,');
      SQL.Add('	[Type_ThirdIsFirst] [bit] NOT NULL ,');
      SQL.Add('	[Type_ThirdRounding] [smallint] NULL ,');
      SQL.Add('	[Type_ThirdPrice] [float] NULL ,');
      SQL.Add('	[Type_LastTime] [int] NULL ,');
      SQL.Add('	[Type_LastTime3] [smallint] NULL ,');
      SQL.Add('	[Type_LastPrice] [float] NULL ,');
      SQL.Add('	[Type_LastIsFirst] [bit] NOT NULL ,');
      SQL.Add('	[Type_LastRounding] [smallint] NULL ,');
      SQL.Add('	[Type_DailyPrice] [float] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'NewCarTypes' then
    begin
      SQL.Add('(');
      SQL.Add('	[Type_Code] [smallint] NULL ,');
      SQL.Add('	[Type_Name] [nvarchar] (15) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Cities' then
    begin
      SQL.Add('(');
      SQL.Add('	[City_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[City_Code] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'CoCars' then
    begin
      SQL.Add('(');
      SQL.Add('	[Co_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[Co_CarNumber] [nvarchar] (6) NULL ,');
      SQL.Add('	[Co_City] [nvarchar] (15) NULL ,');
      SQL.Add('	[Co_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[Co_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[Co_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[Co_Depart] [int] NULL ,');//kaveh new
      SQL.Add('	[Co_AllDeparts] [bit] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Colors' then
    begin
      SQL.Add('(');
      SQL.Add('	[Clr_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[Clr_Code] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Customs' then
    begin
      SQL.Add('(');
      SQL.Add('	[Cust_Code] [smallint] NULL ,');
      SQL.Add('	[Cust_Name] [nvarchar] (40) NULL ,');
      SQL.Add('	[Cust_Family] [nvarchar] (25) NULL ,');
      SQL.Add('	[Cust_Tel] [nvarchar] (20) NULL ,');
      SQL.Add('	[Cust_CarNumber] [nvarchar] (6) NULL ,');
      SQL.Add('	[Cust_CarCity] [nvarchar] (15) NULL ,');
      SQL.Add('	[Cust_CarSerial] [nvarchar] (2) NULL ,');
      SQL.Add('	[Cust_CarColor] [nvarchar] (15) NULL ,');
      SQL.Add('	[Cust_CarName] [nvarchar] (15) NULL ,');
      SQL.Add('	[Cust_Date] [nvarchar] (10) NULL ,');
      SQL.Add('	[Cust_Remain] [float] NULL ,');
      SQL.Add('	[Cust_Valid] [bit] NOT NULL');
      SQL.Add(' )');
    end

    else if tblName = 'PayCust' then
    begin
      SQL.Add('(');
      SQL.Add('	[Pay_CustCode] [smallint] NULL ,');
      SQL.Add('	[Pay_Date] [nvarchar] (10) NULL ,');
      SQL.Add('	[Pay_Price] [float] NULL ,');
      SQL.Add('	[Pay_IsPay] [bit] NOT NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Deleted' then
    begin
      SQL.Add('(');
      SQL.Add('	[D_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[D_CarName] [nvarchar] (15) NULL ,');
      SQL.Add('	[D_Number] [nvarchar] (6) NULL ,');
      SQL.Add('	[D_CityName] [nvarchar] (15) NULL ,');
      SQL.Add('	[D_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[D_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[D_IDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[D_ITime] [nvarchar] (5) NULL ,');
      SQL.Add('	[D_ODate] [nvarchar] (10) NULL ,');
      SQL.Add('	[D_OTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[D_Kind] [smallint] NULL ,');
      SQL.Add('	[D_IDoor] [smallint] NULL ,');
      SQL.Add('	[D_ODoor] [smallint] NULL ,');
      SQL.Add('	[D_IPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[D_OPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[D_Price] [float] NULL ,');
      SQL.Add('	[D_PayAble] [float] NULL ,');
      SQL.Add('	[D_IsPark] [bit] NOT NULL ,');
      SQL.Add('	[D_Karshenasi] [bit] NOT NULL ,');
      SQL.Add('	[D_Gholnameh] [bit] NOT NULL ,');
      SQL.Add('	[D_ExitValid] [bit] NOT NULL ,');
      SQL.Add('	[D_UserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[D_Date] [nvarchar] (10) NULL ,');
      SQL.Add('	[D_Time] [nvarchar] (5) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'InOutCo' then
    begin
      SQL.Add('(');
      SQL.Add('	[IO_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[IO_CarNumber] [nvarchar] (6) NULL ,'); //kaveh new
      SQL.Add('	[IO_Serial] [nvarchar] (2) NULL ,'); //kaveh new
      SQL.Add('	[IO_Driver] [nvarchar] (8) NULL ,');//kaveh edit: 25 --> 8 
      SQL.Add('	[IO_ODoor] [smallint] NULL ,');
      SQL.Add('	[IO_OPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[IO_ODate] [nvarchar] (10) NULL ,');
      SQL.Add('	[IO_OTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[IO_OAmper] [int] NULL ,');
      SQL.Add('	[IO_Target] [nvarchar] (30) NULL ,');
      SQL.Add('	[IO_Mojavez] [nvarchar] (10) NULL ,');
      SQL.Add('	[IO_Describe] [nvarchar] (50) NULL ,');
      SQL.Add('	[IO_IDoor] [smallint] NULL ,');
      SQL.Add('	[IO_IPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[IO_IDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[IO_ITime] [nvarchar] (5) NULL ,');
      SQL.Add('	[IO_IAmper] [int] NULL ,');
      SQL.Add('	[IO_IsPark] [bit] NOT NULL ,');
      SQL.Add('	[IO_ODepart] [int] NULL ,');
      SQL.Add('	[IO_IDepart] [int] NULL ');
      SQL.Add(' )');
    end

    else if tblName = 'InputCar' then
    begin
      SQL.Add('(');
      SQL.Add('	[M_rdrCode] [smallint] NULL ,');
      SQL.Add('	[M_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_CarName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_Number] [nvarchar] (6) NULL ,');
      SQL.Add('	[M_CityName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[M_PlaqueType] [smallint] NULL ,');
      SQL.Add('	[M_PlaqueAppliance] [smallint] NULL ,');
      SQL.Add('	[M_CitySerial] [int] NULL ,');
      SQL.Add('	[M_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_IDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_ITime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_ODate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_OTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_Kind] [smallint] NULL ,');
      SQL.Add('	[M_IDoor] [smallint] NULL ,');
      SQL.Add('	[M_ODoor] [smallint] NULL ,');
      SQL.Add('	[M_IPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_OPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_OperatorCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_Price] [money] NULL ,');
      SQL.Add('	[M_PayAble] [money] NULL ,');
      SQL.Add('	[M_IsPark] [bit] NOT NULL ,');
      SQL.Add('	[M_Karshenasi] [bit] NOT NULL ,');
      SQL.Add('	[M_Gholnameh] [bit] NOT NULL ,');
      SQL.Add('	[M_ExitValid] [bit] NOT NULL ,');
      SQL.Add('	[M_IsDeleted] [bit] NOT NULL ,');
      SQL.Add('	[M_IUserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_UserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_DUserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_DDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_DTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_Driver] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_WorkDepart] [int] NULL ,');
      SQL.Add('	[M_Visited] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_EntranceDepart] [int] NULL ,');
      SQL.Add('	[M_Status] [tinyint] NULL ,');
      SQL.Add('	[M_MemberCode] [nvarchar] (8) NULL');
{$ifdef TarehBar}
      SQL.Add(', [M_CargoKind] [tinyint] NULL '); //kaveh
      SQL.Add(', [M_CargoWeight] [int] NULL '); //kaveh
      SQL.Add(', [M_Salon] [smallint] NULL '); //kaveh
      SQL.Add(', [M_Loge] [smallint] NULL '); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
    end

    else if tblName = 'Machines' then
    begin
      SQL.Add('(');
      SQL.Add('	[M_rdrCode] [smallint] NULL ,');
      SQL.Add('	[M_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_CarName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_Number] [nvarchar] (6) NULL ,');
      SQL.Add('	[M_CityName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[M_PlaqueType] [smallint] NULL ,');
      SQL.Add('	[M_PlaqueAppliance] [smallint] NULL ,');
      SQL.Add('	[M_CitySerial] [int] NULL ,');
      SQL.Add('	[M_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_IDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_ITime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_ODate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_OTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_Kind] [smallint] NULL ,');
      SQL.Add('	[M_IDoor] [smallint] NULL ,');
      SQL.Add('	[M_ODoor] [smallint] NULL ,');
      SQL.Add('	[M_IPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_OPerson] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_OperatorCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_Price] [money] NULL ,');
      SQL.Add('	[M_PayAble] [money] NULL ,');
      SQL.Add('	[M_BPayAble] [money] NULL ,');
      SQL.Add('	[M_Slake] [money] NULL ,');
      SQL.Add('	[M_IsPark] [bit] NOT NULL ,');
      SQL.Add('	[M_Karshenasi] [bit] NOT NULL ,');
      SQL.Add('	[M_Gholnameh] [bit] NOT NULL ,');
      SQL.Add('	[M_ExitValid] [bit] NOT NULL ,');
      SQL.Add('	[M_IsDeleted] [bit] NOT NULL ,');
      SQL.Add('	[M_IUserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_UserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_DUserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[M_DDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[M_DTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[M_Driver] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_WorkDepart] [int] NULL ,');
      SQL.Add('	[M_Visited] [nvarchar] (8) NULL ,');
      SQL.Add('	[M_EntranceDepart] [int] NULL ,');
      SQL.Add('	[M_Status] [tinyint] NULL ,');
      SQL.Add('	[M_MemberCode] [nvarchar] (8) NULL');
{$ifdef TarehBar}
      SQL.Add(', [M_CargoKind] [tinyint] NULL '); //kaveh
      SQL.Add(', [M_CargoWeight] [int] NULL '); //kaveh
      SQL.Add(', [M_Salon] [smallint] NULL '); //kaveh
      SQL.Add(', [M_Loge] [smallint] NULL '); //kaveh
{$endif TarehBar}
      SQL.Add(' )');
    end

    else if tblName = 'NoCard' then
    begin
      SQL.Add('(');
      SQL.Add('	[N_Number] [nvarchar] (6) NULL ,');
      SQL.Add('	[N_City] [nvarchar] (15) NULL ,');
      SQL.Add('	[N_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[N_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[N_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[N_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[N_ExitDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[N_ExitTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[N_Describe] [nvarchar] (255) NULL ,');
      SQL.Add('	[N_Madarek] [nvarchar] (255) NULL ,');
      SQL.Add('	[N_PutDate] [nvarchar] (10) NULL ,');
      SQL.Add('	[N_PutTime] [nvarchar] (5) NULL ,');
      SQL.Add('	[N_IsDeleted] [bit] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Persons' then
    begin
      SQL.Add('(');
      SQL.Add('	[P_BarCode] [nvarchar] (8) NULL ,');
      SQL.Add('	[P_Name] [nvarchar] (40) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Readers' then
    begin
      SQL.Add('(');
      SQL.Add('	[R_Code] [smallint] NULL ,');
      SQL.Add('	[R_Name] [nvarchar] (20) NULL ,');
      SQL.Add('	[R_Active] [nvarchar] (1) NULL ,');
      SQL.Add('	[R_Port] [smallint] NULL ,');
      SQL.Add('	[R_BaudNo] [smallint] NULL ,');
      SQL.Add('	[R_Type] [smallint] NULL ,');
      SQL.Add('	[R_Modem] [bit] NULL ,');
      SQL.Add('	[R_IP] [nvarchar] (15) NULL ,');
      SQL.Add('	[R_TCP] [bit] NOT NULL ,');
      SQL.Add('	[R_IsCOM] [bit] NOT NULL ,');
      SQL.Add('	[R_Depart] [int] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Security' then
    begin
      SQL.Add('(');
      SQL.Add('	[UserName] [nvarchar] (15) NULL ,');
      SQL.Add('	[UserPassword] [nvarchar] (15) NULL ,');
      SQL.Add('	[Entery] [bit] NOT NULL ,');
      SQL.Add('	[MenuBar] [smallint] NULL ,');
      SQL.Add('	[BaseMenu] [int] NULL ,');
      SQL.Add('	[RelationMenu] [int] NULL ,');
      SQL.Add('	[TransferMenu] [int] NULL ,');
      SQL.Add('	[SpecialMenu] [int] NULL ,');
      SQL.Add('	[ReportMenu] [int] NULL ,');
      SQL.Add('	[ToolsMenu] [int] NULL ,');
      SQL.Add('	[AccessPrint] [bit] NOT NULL ,');
      SQL.Add('	[Department] [int] NULL ,');
      SQL.Add('	[ActiveRdrCode] [smallint] NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Specials' then
    begin
      SQL.Add('(');
      SQL.Add('	[Spc_Number] [nvarchar] (6) NULL ,');
      SQL.Add('	[Spc_City] [nvarchar] (15) NULL ,');
      SQL.Add('	[Spc_Serial] [nvarchar] (2) NULL ,');
      SQL.Add('	[Spc_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[Spc_Color] [nvarchar] (15) NULL ,');
      SQL.Add('	[Spc_NotExit] [bit] NOT NULL ,');
      SQL.Add('	[Spc_Motavari] [bit] NOT NULL ,');
      SQL.Add('	[Spc_Takhfif] [bit] NOT NULL ,');
      SQL.Add('	[Spc_Percent] [smallint] NULL ,');
      SQL.Add('	[Spc_Debtor] [float] NULL ,');
      SQL.Add('	[Spc_DescribeNotExit] [nvarchar] (255) NULL ,');
      SQL.Add('	[Spc_DescribeMotavari] [nvarchar] (255) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'Department' then
    begin
      SQL.Add('(');
      SQL.Add('	[Depart_Code] [int] NULL ,');
      SQL.Add('	[Depart_Name] [nvarchar] (40) NULL');
      SQL.Add(' )');
    end

    else if tblName = 'NewPersons' then
    begin
      SQL.Add('(');
      SQL.Add('	[P_Code] [nvarchar] (8) NULL ,');
      SQL.Add('	[P_CardID] [nvarchar] (8) NULL ,');
      SQL.Add('	[P_Name] [nvarchar] (15) NULL ,');
      SQL.Add('	[P_Family] [nvarchar] (25) NULL ,');
      SQL.Add('	[P_Tel] [nvarchar] (20) NULL ,');
      SQL.Add('	[P_CarNumber] [nvarchar] (6) NULL ,');
      SQL.Add('	[P_CarSerial] [nvarchar] (2) NULL ,');
      SQL.Add('	[P_CarColor] [smallint] NULL ,');
      SQL.Add('	[P_CarName] [smallint] NULL ,');
      SQL.Add('	[P_Date] [nvarchar] (10) NULL ,');
      SQL.Add('	[P_Remain] [float] NULL ,');
      SQL.Add('	[P_Valid] [bit] NOT NULL ,');
      SQL.Add('	[P_Depart] [int] NULL ,');
      SQL.Add('	[P_IsCustomer] [bit] NOT NULL');
      SQL.Add(' )');
    end
{
    else if tblName = '' then
    begin
      SQL.Add('(');

      SQL.Add('
');
      SQL.Add(' )');
    end
}
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
    if tblName = 'Security' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO Security (UserName, Entery, AccessPrint, Department)');
        SQL.Add('VALUES(''Admin'', ' + IntToStr(MB_TRUE) + ', ' +IntToStr(MB_TRUE) + ', 1 )');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'Department' then
    begin
      if not IsUpgrade then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO Department (Depart_Code, Depart_Name)');
        SQL.Add('VALUES( 1 , ''بخش مرکزی'' )');
        try
          ExecSQL;
          Result := True;
        except
          Result := False;
        end;
      end;
    end;
    g_Options.Department := 1;
    SQL.Clear;
    if tblName = 'NewCarTypes' then
    begin
      if not IsUpgrade then
      begin
        for i := 1 to NoCarTypes do
        begin
          SQL.Clear;
          SQL.Add('INSERT INTO NewCarTypes (Type_Code, Type_Name)');
          SQL.Add('VALUES(' + IntToStr(i) + ' , ''' + StCarTypes[i] + ''' )');
          try
            ExecSQL;
            Result := True;
          except
            Result := False;
          end;
        end;
      end;
    end;

    SQL.Clear;
    if tblName = 'CarTypes' then
    begin
      if not IsUpgrade then
      begin
        for i := 1 to NoCarTypes do
        begin
          SQL.Clear;
          SQL.Add('INSERT INTO CarTypes (Type_Code, Type_Name, Type_SecondIsFirst, Type_ThirdIsFirst, Type_LastIsFirst)');
          SQL.Add('VALUES(' + IntToStr(i) + ' , ''' + StCarTypes[i] + ''', 0, 0, 0)');
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
    qry.Connection := frmDBS.adoConnect;

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
      Connection := frmDBS.adoConnect;
      TableName := tblName;
      Active := True;
    end;

    with tblOld do
    begin
      Active := false;
      Connection := frmDBS.adoConnect;
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
            tblNew.fields[i].Value := tblOld.FieldByName(tblnew.Fields[i].FieldName).Value;
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

function tblExists(tblName : String): boolean;
var
  tblLists : TStrings;
  i : integer;
begin
  result := false;
  tblLists := TStringList.Create;
  frmDBS.adoConnect.GetTableNames(tblLists , false);
  for i := 0 to tblLists.Count - 1 do
    if UpperCase(tblName) = UpperCase(tblLists[i]) then
      result := true;
  tblLists.free;
end;


end.
