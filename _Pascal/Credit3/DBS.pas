  unit DBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls, ExtCtrls, ComTools,globals,RunCmnds;



const
  MAX_SERVICE_SEL = 20;


type
  TfrmDBS = class(TForm)
    adoConnect: TADOConnection;
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
    atblReceipt1: TADOTable;
    atblEmployee: TADOTable;
    atblReceipt2: TADOTable;
    lblUser: TLabel;
    txtUser: TEdit;
    lblPass: TLabel;
    txtPass: TEdit;
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
  end;

  TDBSInfo = Record
  //Database information
    dbsType : Byte;   //Database type (M.S.Access or SQL.SERVER 2000)
    dbsName : String; //Database name
    dbsPath : String; //M.S.Access path or Server name
    dbsUser : String; //SQL Server User
    dbsPass : String; //SQL Server password
  end;

  TServiceSel = Record
  //Selected foods in receipt
    SS_SrvcCode : Integer;  //Servuce code
    SS_SrvcNo   : Integer;  //no. of selected service
    SS_MainPrice: Currency; //main price
    SS_Prcnd    : Real;     //Percent of discount
    SS_Price    : Currency; //service price
    SS_PrcType  : Byte;     //price type (price 1 or price 2)
  end;

//  TReceipt = Record
//  //Receipt
//    recit_Date    : String[10]; //Receipt date
//    recit_Depart  : Integer;    //Receipt Department
//    recit_Time    : String[5];  //Receipt time
//    recit_EmplNo  : String[8];  //Employee no.
//    recit_Onvan   : String[50]; //Family & name
//    recit_rdrCode : Integer;    //Reader code
//    recit_No      : Integer;    //Receipt no.
//    recit_TotalPrc: Currency;   //Total price
//  end;



(******************** CONSTANT Definition ********************)
const
  DBS_ACCESS    = 1;
  DBS_SQLSERVER = 2;


  ERR_SRVC_NOT_SEL     = 2;
  ERR_LESS_CREDIT      = 3;
  ERR_EMPL_NOT_ACTIVE  = 4;
  ERR_SRVC_NOT_FOUND   = 5;
  ERR_EMPL_NOT_FOUND   = 6;
  ERR_EMPL_EXPIRED     = 7;
  Error_Str : array[ERR_NONE..ERR_EMPL_EXPIRED] of String =
              ('', '⁄œ„ «‰ Œ«» Œœ„« ', 'ﬂ”—  «⁄ »«— ﬂ«— ',
              '›—œ €Ì— ›⁄«·', '«‰ Œ«» ‰«œ—” !', '⁄œ„  ⁄—Ì› Å—”‰·!','Å«Ì«‰ „œ  «⁄ »«—');


  PAY_CREDIT           = 1;
  PAY_CASH             = 2;
  PAY_CREDITCASH       = 3;


(******************** Public VARIABLES Definition ********************)
var
  frmDBS  : TfrmDBS;
  dbsInfo : TDBSInfo;
  dtaSrc  : String;



(******************** PROCEDURES & FUNCTIONS Definition ********************)
procedure LoadDBSInfo;
function  DBSConnect : String;

procedure CreateAllTables;
function  CreateTable(tblName : String;doInsert : boolean = True) : Boolean;
Procedure UpgradeTable(tblName : string);
function  EmployeeFull : Boolean;
function  tblExists(tblName : String): boolean;
function  IsExistsRec_Str(tblName, fldName, fldValue : String) : Boolean;
function  IsExistsRec_Num(tblName, fldName : String; fldValue : Integer) : Boolean;
function  GetNewNumber(tblName, fldName : String) : Integer;

{ Department processing }
function  GetDepartmentCode(departName : String) : Integer;
function  GetDepartmentName(departCode : Integer) : String;
 function getcodedepart (i:integer):string;

{ Unit table processing }
function  GetUnitName(unitCode : Integer) : String;
function  GetUnitCode(unitName : String) : Integer;
function  GetServiceUnit(srvcCode : Integer) : String;

{ Part table processing }
function  GetPartName(partCode : Integer) : String;

{ Co-Post processing }
function  GetCoPostName(coPostCode : Integer) : String;

{ Service table processing }
function  GetServiceCode(srvcName : String) : Integer;
function  GetServiceName(srvcCode : Integer) : String;
function  GetServicePrice(srvcCode : Integer) : Currency;

{ Discount table processing }
function  GetDiscountName(dscntCode : Integer) : String;

{ Employee processing }
function ChargeEmployee(emplNo: String; chargecode :integer; chargeTime : String; chargePrice : Currency; ExpireDate : string;mustzero:boolean) : Boolean;
function CalculBalance(emplNo : String ;FromDate , ToDate : string ; var lastCharge : string) : Currency;
function Calculkharid(emplNo : String ) : Currency;
function  GetFamilyName(emplNo : String) : String;
function  GetEmployee(Code : String; isProxi : boolean) : TEmployee;
function  GetCreditCardPrice(emplNo : String) : Currency;



{ Receipt Processing }
function SaveChargeRecord(var rec : TTerminalRec) : boolean;
function SaveLostCardRecord(var rec : TTerminalRec) : boolean;
function  SaveRecord(var rec : TTerminalRec) : Byte;
function  ReceiptErrorStr(errCode : Byte) : String;


{ Readers Processing }
procedure LoadReaders;
function  GetReaderName(rdrCode : Byte) : String;

procedure LogInLogOut(depCode : Byte; logIn : Boolean);


(********************  I M P L E M E N T A T I O N ********************)
implementation

uses
  Funcs, MSGs, ADODB_TLB, ADOX_TLB, DateProc,TimeTool;

{$R *.dfm}


{ load database type from file}
procedure LoadDBSInfo;
var
  f : TextFile;
begin
  if FileExists(gOptions.ProgramPath + 'DBSType.Dta') then
  begin
    AssignFile(f, gOptions.ProgramPath + 'DBSType.Dta');
    Reset(f);
    try
      Readln(f, dbsInfo.dbsType);
      Readln(f, dbsInfo.dbsName);
      Readln(f, dbsInfo.dbsPath);
      Readln(f, dbsInfo.dbsUser);
      Readln(f, dbsInfo.dbsPass);
    except
    end;
    CloseFile(f);
  end
  else
  begin
    dbsInfo.dbsType := DBS_ACCESS;
    dbsInfo.dbsName := '';
    dbsInfo.dbsPath := '';
    dbsInfo.dbsUser := '';
    dbsInfo.dbsPass := '';
  end;
end;
 {=============================================}
  function getcodedepart (i:integer):string;
   var code_dep:integer;
  begin
     with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('select * from Readers where Rdr_Code='+ inttostr(i) );
      Open ;
      code_dep:=FieldByName('Rdr_Department').AsInteger;
    end;

     with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('select * from Department where Depart_Code='+ inttostr(code_dep) );
      Open ;
      Result :=FieldByName('Depart_Name').AsString ;
    end;


   end;

{ checking for connecting to database }
function DBSConnect : String;
var err : String;
begin
  if dbsInfo.dbsType = DBS_ACCESS then
  begin
    dtaSrc := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
              'Jet OLEDB:Engine Type=5;' +
              'Data Source=' + dbsInfo.dbsPath + dbsInfo.dbsName;
    FLD_CURRENCY := 'Currency';
  end
  else
  begin
    dtaSrc := 'Provider=SQLOLEDB.1;' +
              'Persist Security Info=False;' +
              'User ID=' + dbsInfo.dbsUser + ';' +
              'Password=' + dbsInfo.dbsPass + ';' +
              'Data Source=' + dbsInfo.dbsPath + ';' +
              'Initial Catalog=' + dbsInfo.dbsName;//SQL Authoration

    FLD_CURRENCY := 'Money';
  end;


  with  frmDBS.adoConnect do
  begin
    if Connected then
      Close;

    ConnectionString := dtaSrc;

    try
      frmDBS.adoConnect.Open;
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

{ Creation all table which use in software }
procedure CreateAllTables;
begin
  CreateTable('Department');
  CreateTable('Units');
  CreateTable('CoPosts');
  CreateTable('Parts');
  CreateTable('Services');
  CreateTable('Discount');
  CreateTable('DscntDtl');
  CreateTable('Employee');
  CreateTable('Charge');
  CreateTable('Receipt1');
  CreateTable('Receipt2');
  CreateTable('Readers');
  CreateTable('Users');
  CreateTable('UserStat');
  CreateTable('LostCard');
end;

{ create a table in database }
function CreateTable(tblName : String;doInsert : boolean = true) : Boolean;
var strList : Tstrings;
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
    case dbsInfo.dbsType of
      DBS_ACCESS    : SQL.Add('CREATE TABLE ' + tblName);
      DBS_SQLSERVER : SQL.Add('CREATE TABLE dbo.' + tblName);
    end;

    if tblName = 'Department' then
    begin
      SQL.Add('(Depart_Code Int');
      SQL.Add(', Depart_Name NVarChar(40)');
      SQL.Add(', Depart_OnLine bit');

      SQL.Add(', PRIMARY KEY (Depart_Code))');
    end
    else if tblName = 'Units' then
    begin
      SQL.Add('(Unit_Code Int');
      SQL.Add(', Unit_Name NVarChar(40)');

      SQL.Add(', PRIMARY KEY (Unit_Code))');
    end
    else if tblName = 'CoPosts' then
    begin
      SQL.Add('(CoPost_Code Int');
      SQL.Add(', CoPost_Name NVarChar(40)');
      SQL.Add(', CoPost_S1 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S2 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S3 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S4 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S5 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S6 ' + FLD_CURRENCY);
      SQL.Add(', CoPost_S7 ' + FLD_CURRENCY);
      SQL.Add(', PRIMARY KEY (CoPost_Code))');
    end
    else if tblName = 'Parts' then
    begin
      SQL.Add('(Part_Code Int');
      SQL.Add(', Part_Name NVarChar(40)');

      SQL.Add(', PRIMARY KEY (Part_Code))');
    end
    else if tblName = 'Services' then
    begin
      SQL.Add('(S_Code Int');
      SQL.Add(', S_Name  NVarChar(40)');

      SQL.Add(', PRIMARY KEY (S_Code))');
    end
    else if tblName = 'Employee' then
    begin
      SQL.Add(' (Empl_No NVarChar(8)');
      SQL.Add(', Empl_ID NVarChar(15)');
      SQL.Add(', Empl_Name NVarChar(15)');
      SQL.Add(', Empl_Family NVarChar(25)');
      SQL.Add(', Empl_Active Bit');
      SQL.Add(', Empl_Department Int');
      SQL.Add(', Empl_CoPost Int');
      SQL.Add(', Empl_Part Int');
      SQL.Add(', Empl_Dscnt Int');
      SQL.Add(', Empl_ExpDate NVarChar(10)');
      SQL.Add(', Empl_Balance ' + FLD_CURRENCY);
      SQL.Add(', Empl_Services NVarChar(50)');
      SQL.Add(', Empl_Week Int');
      SQL.Add(', Empl_Number NVarChar(15)');
      SQL.Add(', Empl_Meli NVarChar(12)');
      SQL.Add(', Empl_Tel NVarChar(20)');
      SQL.Add(', Empl_Address NVarChar(80)');
      SQL.Add(', Empl_Sex Int');
      SQL.Add(', PRIMARY KEY (Empl_No))');
    end
    else if tblName = 'ChargeGrp' then
    begin
      SQL.Add('(GrpCode int');
      SQL.Add(',GrpTime NVarChar(5)');

      SQL.Add(', GrpExpireDate NVarChar(10)');
       SQL.Add(', GrpDate NVarChar(10)');
      SQL.Add(', GrpPrice ' + FLD_CURRENCY );
      SQL.Add(', GrpDesc nvarchar(100) ');
       SQL.Add(', PRIMARY KEY (GrpCode))');
    end

    else if tblName = 'ChargeDtl' then
    begin
      SQL.Add('(DtlCode Int');
       SQL.Add(',Dtlmoved bit');
       sql.Add(',DtlRdr int') ;
      SQL.Add(',DtlEmplNo NVarChar(15)' );
      SQL.Add(', PRIMARY KEY (DtlCode,DtlEmplNo))');



    end

    else if tblName = 'Discount' then
    begin
      SQL.Add('(Dscnt_No Int');
      SQL.Add(', Dscnt_Name NVarChar(15)');

      SQL.Add(', PRIMARY KEY (Dscnt_No))');
    end
    else if tblName = 'DscntDtl' then
    begin
      SQL.Add('(DscntDtl_No Int');
      SQL.Add(', DscntDtl_GrpNo Int');
      SQL.Add(', DscntDtl_Service Int');
      SQL.Add(', DscntDtl_Percent Int');
      SQL.Add(', DscntDtl_Limit Int');
      SQL.Add(', DscntDtl_SDate NVarChar(10)');
      SQL.Add(', DscntDtl_eDate NVarChar(10)');
      SQL.Add(', DscntDtl_Daily Bit)');
    end
    else if tblName = 'Receipt1' then
    begin
      SQL.Add('(Recit1_Date NVarChar(10)');
      SQL.Add(', Recit1_Department Int');
      SQL.Add(', Recit1_No Int');
      SQL.Add(', Recit1_EmplNo NVarChar(8)');
      SQL.Add(', Recit1_Time NVarChar(5)');
      SQL.Add(', Recit1_Rdr Int');
      SQL.Add(', Recit1_TotalPrice ' + FLD_CURRENCY);
      SQL.Add(', Recit1_Credit '  + FLD_CURRENCY);
      SQL.Add(', Recit1_Cash ' + FLD_CURRENCY);
      SQL.Add(', Recit1_PayType Int');
      SQL.Add(', Recit1_Service Int)');
    end
    else if tblName = 'Receipt2' then
    begin
      SQL.Add('(Recit2_Date NVarChar(10)');
      SQL.Add(', Recit2_Department Int');
      SQL.Add(', Recit2_No Int');
      SQL.Add(', Recit2_EmplNo NVarChar(8)');
      SQL.Add(', Recit2_Srvc Int');
      SQL.Add(', Recit2_SrvcNo Int');
      SQL.Add(', Recit2_MainPrice ' + FLD_CURRENCY);
      SQL.Add(', Recit2_Percent Int');
      SQL.Add(', Recit2_Price ' + FLD_CURRENCY);
      SQL.Add(', Recit2_PrcType Int');
      SQL.Add(', Recit2_Time NVarChar(5))');
    end
    else if tblName = 'Readers' then
    begin
      SQL.Add('(Rdr_Code Int');
      SQL.Add(', Rdr_Name NVarChar(40)');
      SQL.Add(', Rdr_DpType Int');
      SQL.Add(', Rdr_Department Int');
      SQL.Add(', Rdr_ComPort Int');
      SQL.Add(', Rdr_BaudRate Int');
      SQL.Add(', Rdr_IP NVarChar(15)');
      SQL.Add(', Rdr_IsCom Bit');
      SQL.Add(', Rdr_Active Bit');
      SQL.Add(', Rdr_Tel NVarChar(40)');
      SQL.Add(', PRIMARY KEY (Rdr_Code))');
    end
    else if tblName = 'Users' then
    begin
      SQL.Add(' (User_Name NVarChar(15)');
      SQL.Add(', User_Password NVarChar(15)');
      SQL.Add(', User_Active Bit');
      SQL.Add(', User_Menu1 NVarChar(50)');
      SQL.Add(', User_Menu2 NVarChar(50)');
      SQL.Add(', User_Menu3 NVarChar(50)');
      SQL.Add(', User_Menu4 NVarChar(50)');
      SQL.Add(', User_Menu5 NVarChar(50)');
      SQL.Add(', User_Department Int');

      SQL.Add(', PRIMARY KEY (User_Name))');
    end
    else if tblName = 'UserStat' then
    begin
      SQL.Add('(UserName NVarChar(15)');
      SQL.Add(', PrgName NVarChar(40)');
      SQL.Add(', UsedDate NVarChar(10)');
      SQL.Add(', UsedTime NVarChar(5))');
    end
    else if tblName = 'LostCard' then
    begin
      SQL.Add('(lost_Emplno NVarChar(8)');
      SQL.Add(', lost_EmplId NVarChar(15)');
      SQL.Add(', lost_Date NVarChar(10)');
      SQL.Add(', lost_RemoveDate NVarChar(10)');
      SQL.Add(', lost_RemoveTime NVarChar(5)');
      SQL.Add(', lost_Price money');
      SQL.Add(', PRIMARY KEY (lost_Emplno,lost_EmplId))');
    end
    else if tblName = 'Weeks' then
    begin
      SQL.Add('( W_Code Int');
      SQL.Add(', W_Sex Int');
      SQL.Add(', W_Name NVarChar(40)');
      SQL.Add(', W_prgDay1 NVarChar(60)');
      SQL.Add(', W_prgDay2 NVarChar(60)');
      SQL.Add(', W_prgDay3 NVarChar(60)');
      SQL.Add(', W_prgDay4 NVarChar(60)');
      SQL.Add(', W_prgDay5 NVarChar(60)');
      SQL.Add(', W_prgDay6 NVarChar(60)');
      SQL.Add(', W_prgDay7 NVarChar(60)');
      SQL.Add(', PRIMARY KEY (W_Code)) ');
    end
    else if tblName = 'Prices' then
    begin
      SQL.Add('( P_CoPost Int');
      SQL.Add(', P_Service Int');
      SQL.Add(', P_Price ' + FLD_CURRENCY);
      SQL.Add(', PRIMARY KEY (P_CoPost,P_Service))');
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
    if (tblName = 'Users') and (doInsert) then
    begin
      SQL.Add('INSERT INTO Users (User_Name, User_Active)');
      SQL.Add('VALUES(''Admin'', ' + IntToStr(MB_TRUE) + ')');
      try
        ExecSQL;
        Result := True;
      except
        Result := False;
      end;
    end;
  end;
end;

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

begin
  if not tblExists(tblName)
  then begin
       CreateTable(tblName,True);
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

    CreateTable(tblName,false);

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
    while not tblOld.Eof do
    begin
      tblNew.Append;
      for i := 0 to tblnew.FieldCount - 1 do
      begin
        fld := tblold.FindField(tblnew.Fields[i].FieldName);
        if  fld <> nil then
        begin
            tblNew.fields[i].Value := tblOld.FieldByName(tblnew.Fields[i].FieldName).Value;
        end
        else begin
            case tblNew.fields[i].DataType of
              ftSmallInt,ftInteger,ftLargeint: tblNew.fields[i].Value := 0;
              ftBoolean : tblNew.fields[i].Value := false;
              ftString  : tblNew.fields[i].Value := '';
            end;

        end;
      end;
      tblNew.Post;
      tblOld.Next;
    end;
    tblOld.close;
    tblNew.Close;
    tblOld.Destroy;
    tblNew.Destroy;

    qry.Destroy;
  end;
end;


{ Return true if there is a special record in table }
function IsExistsRec_Str(tblName, fldName, fldValue : String) : Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT ' + fldName + ' FROM ' + tblName);
    SQL.Add('WHERE ' + fldName + ' = ''' + fldValue + '''');
    Open;
    Result := (RecordCount > 0);
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

{ Return department's code from table }
function GetDepartmentCode(departName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Depart_Code FROM Department WHERE Depart_Name = ''' + departName + '''');
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Depart_Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

{ Return department's name from table }
function GetDepartmentName(departCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Depart_Name FROM Department WHERE Depart_Code = ' + IntToStr(departCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Depart_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return unit's name from table }
function GetUnitName(unitCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Unit_Name FROM Units WHERE Unit_Code = ' + IntToStr(unitCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Unit_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return unit's code from table }
function GetUnitCode(unitName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Unit_Code FROM Units WHERE Unit_Name = ''' + unitName + '''');
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Unit_Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

{ Return unit's name from table }
function GetServiceUnit(srvcCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Unit_Name FROM Units, Services WHERE S_Unit = Unit_Code');
    SQL.Add('AND S_Code = ' + IntToStr(srvcCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Unit_Name').AsString
    else
      Result := '';
    Close;
  end;
end;


{ Return part's name from table }
function GetPartName(partCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Part_Name FROM Parts WHERE Part_Code = ' + IntToStr(partCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Part_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

{ Return co-post's name from table }
function GetCoPostName(coPostCode : Integer) : String;
begin
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.SQL.Add('SELECT CoPost_Name FROM CoPosts');
  frmDBS.adoQryG.SQL.Add('WHERE CoPost_Code = ' + IntToStr(coPostCode));
  frmDBS.adoQryG.Open;
  Result := frmDBS.adoQryG.FieldByName('CoPost_Name').AsString;
  frmDBS.adoQryG.Close;
end;

(******************** Service & price Processing ********************)
{ Return Service's code from table }
function GetServiceCode(srvcName : String) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT S_Code FROM Services WHERE S_Name = ''' + srvcName + '''');
    Open;
    if RecordCount > 0 then
      Result := FieldByName('S_Code').AsInteger
    else
      Result := 0;
    Close;
  end;
end;

{ read name of Service from database }
function GetServiceName(srvcCode : Integer) : String;
begin
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.SQL.Add('SELECT S_Name FROM Services');
  frmDBS.adoQryG.SQL.Add('WHERE S_Code = ' + IntToStr(srvcCode));
  frmDBS.adoQryG.Open;
  Result := frmDBS.adoQryG.FieldByName('S_Name').AsString;
  frmDBS.adoQryG.Close;
end;

{ return price of service }
function GetServicePrice(srvcCode : Integer) : Currency;
begin
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.SQL.Add('SELECT S_Price FROM Services');
  frmDBS.adoQryG.SQL.Add('WHERE S_Code = ' + IntToStr(srvcCode));
  frmDBS.adoQryG.Open;
  if frmDBS.adoQryG.RecordCount > 0 then
    Result := frmDBS.adoQryG.FieldByName('S_Price').AsCurrency
  else
    Result := -1;
  frmDBS.adoQryG.Close;
end;



{ Return Group's name from table }
function GetGroupName(GroupCode : Integer) : String;
begin
  frmDBS.adoQryG.SQL.Clear;
  frmDBS.adoQryG.SQL.Add('SELECT Dscnt_Name FROM Discount');
  frmDBS.adoQryG.SQL.Add('WHERE Dscnt_No = ' + IntToStr(GroupCode));
  frmDBS.adoQryG.Open;
  Result := frmDBS.adoQryG.FieldByName('Dscnt_Name').AsString;
  frmDBS.adoQryG.Close;
end;


{ Return discount's name from table }
function GetDiscountName(dscntCode : Integer) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Dscnt_Name FROM Discount WHERE Dscnt_No = ' + IntToStr(dscntCode));
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Dscnt_Name').AsString
    else
      Result := '';
    Close;
  end;
end;

(******************** Employee Processing ********************)

{ Charge employee }
function ChargeEmployee(emplNo: String; chargecode :integer; chargeTime : String; chargePrice : Currency; ExpireDate : string;mustzero:boolean) : Boolean;
var
   p,today : Currency;
begin
  Result := True;

  if mustzero
  then begin
      with frmDBS.adoQryG do
      begin
        SQL.Clear;
        SQL.Add('select Empl_Balance from Employee ');
        SQL.Add('WHERE Empl_No = ''' + emplNo + '''');
        open;
        if eof
        then p:=0
        else p:=fieldbyname('Empl_Balance').AsCurrency;
        close;
      end;
  end
  else p:=0;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    sql.add('IF NOT exists (select * from Chargedtl where dtlEmplNo = ''' + emplNo + ''' AND  DtlCode = ' + inttostr(chargecode) + ')');
    sql.add('BEGIN');
    sql.add('Insert into Chargedtl(dtlEmplNo, dtlcode , dtlMoved)');
    sql.add('values (''' + emplNo + ''' , ' + inttostr(chargecode) + ' ,' + IntToStr(MB_FALSE) + ')');
    sql.add('END');
    sql.add('ELSE');
    sql.add('BEGIN');
    sql.add('update ChargeDtl set  ChargeDtl.Dtlmoved= ' + IntToStr(MB_FALSE)+ ',ChargeDtl.dtlEmplNo = ''' + emplNo + ''',dtlcode =' + inttostr(chargecode));
    sql.add('where  ChargeDtl.DtlEmplNo = ''' + emplNo + ''' AND  ChargeDtl.DtlCode = ' + inttostr(chargecode));
    sql.add('END');
    ExecSQL;

//    TableName := 'Chargedtl';
//    Open;
//    Filter := 'dtlEmplNo = ''' + emplNo + ''' AND  DtlCode = ''' + inttostr(chargecode) + '''' ;
//    Filtered := True;
//    if RecordCount > 0 then
//    begin
//
//
//
//     // today:=FieldByName('Charge_Price').AsCurrency;
//      {p := chargePrice - FieldByName('Charge_Price').AsCurrency;}
//     // Edit;
//    end
//    else
//    begin
//      today:=0;
//      {p := chargePrice;}
//      Append;
//      FieldByName('dtlEmplNo').AsString := emplNo;
//      FieldByName('dtlcode').AsInteger  := chargecode;
//      FieldByName('dtlMoved').AsBoolean := StrToBool(IntToStr(MB_FALSE));
//      Post;
//      Close;
//    end;






   //FieldByName('Charge_Date').AsString := chargeDate;
  //FieldByName('Charge_Time').AsString := IntToStr(TimeToInt(chargeTime));

   //FieldByName('Charge_Price').AsCurrency := chargePrice+today-p;
    //FieldByName('Charge_ExpireDate').AsString := ExpireDate;

  end;
end;

{kharid employee credit  card}
function Calculkharid(emplNo : String):Currency ;
begin

  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT Receipt1.Recit1_EmplNo, Sum(Receipt1.Recit1_TotalPrice) AS SumOfRecit1_TotalPrice FROM Receipt1 GROUP BY Receipt1.Recit1_EmplNo HAVING  Receipt1.Recit1_EmplNo=''' + emplNo + ''''  );
    Open;
    Result := FieldByName('SumOfRecit1_TotalPrice').AsCurrency

  end;
end;
{ Balance employee credit card }

function EmployeeFull : Boolean;
  var m:integer;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Employee');
    Open;
    m:=RecordCount;
    if (m > maxEmployee) and (maxEmployee <> -1) then
    begin
      Result:=true;
      InformationMessage('  ⁄œ«œ «›—«œ «“ Õœ „Ã«“ (' + IntToStr(maxEmployee) + ' ‰›—) ê–‘ Â «”  .');
    end
    else
    Result:=false;
  end;
end;

function CalculBalance(emplNo : String ;FromDate , ToDate : string ; var lastCharge : string) : Currency;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT EN as EMPL_NO , sum(CR) AS TOTAL_CREDIT, max(DT) as LAST_CHARGE_DATE FROM');
    SQL.Add('(');

//      SQL.Add('SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT');
  //    SQL.Add('FROM CHARGE WHERE  CHARGE_EMPLNO = ''' + emplNo + '''');

    SQL.Add('     SELECT ChargeDtl.DtlEmplNo AS EN, ChargeGrp.GrpPrice as CR, ChargeGrp.GrpDate as DT ');
   SQL.Add(' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode WHERE ChargeDtl.DtlEmplNo = ''' + emplNo + '''');



      if BeautifulDate(FromDate) <> '' then
        SQL.Add(' and chargegrp.GrpDate >= ''' + FromDate + '''');
      if BeautifulDate(ToDate) <> '' then
        SQL.Add(' and chargegrp.GrpDate <= ''' + ToDate + '''');
      SQL.Add('UNION');
      SQL.Add('SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_TIME as DT');
      SQL.Add('FROM RECEIPT1 WHERE RECIT1_EMPLNO = ''' + emplNo + '''');
      if BeautifulDate(FromDate) <> '' then
        SQL.Add('and RECIT1_DATE >= ''' + FromDate + '''');
      if BeautifulDate(ToDate) <> '' then
        SQL.Add('and RECIT1_DATE <= ''' + ToDate + '''');
    SQL.Add(') a');
    SQL.Add('GROUP BY EN');
    Open;
    IF NOT EOF THEN
    begin
      Result := FieldByName('TOTAL_CREDIT').AsCurrency;
      lastCharge := FieldByName('LAST_CHARGE_DATE').AsString;
    end
    else
    begin
      Result := 0;
      lastCharge := '';
    end;
  end;
end;




(******************** Receipt Processing ********************)

{ return new no of receipt from database }
function GetNewReceiptNo(recitDate : String; depart : Integer) : Integer;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(Recit1_No) AS recitNo FROM Receipt1 WHERE Recit1_Date = ''' + recitDate + '''');
    SQL.Add('AND Recit1_Department = ' + IntToStr(depart));
    Open;
    Result := FieldByName('recitNo').AsInteger+1;
    Close;
  end;
end;

{ Check to validity employment in group }
function ValidVadehInGroup(grpCode : Integer;  dt : String; vadeh : Byte) : Boolean;
var
  fldName, tmp : String;
  v : Integer;
begin
  fldName := 'Dtl_M' + IntToStr(StrToInt(Copy(dt, 6, 2)));
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT ' + fldName + ' FROM Grp_Dtl');
    SQL.Add('WHERE Dtl_Code = ' + IntToStr(grpCode));
    Open;
    tmp := FieldByName(fldName).AsString;
    Close;
    if tmp <> '' then
    begin
      v := Ord(tmp[StrToInt(Copy(dt, 9, 2))])-48;
      Result := ((Pow2(vadeh) AND v) <> 0);
    end
    else
      Result := False;
  end;
end;
function SaveChargeRecord(var rec : TTerminalRec) : boolean;
var
   p,today : Currency;
begin
  Result := false;
  with frmDBS.adoQryG do
  begin
    try
      SQL.Clear;
//1st query
//      SQL.Add('update CHARGEDTL set DTLMOVED = ' + IntToStr(MB_TRUE));
//      SQL.Add('WHERE DTLEMPLNO = ' +''''+ FixLeft(rec.rdrCardCode,'0',8)+''''  );

//2nd query only work in access
//      sql.add('update (SELECT ChargeDtl.DtlCode, ChargeDtl.Dtlmoved, ChargeDtl.DtlRdr, ChargeDtl.DtlEmplNo, ChargeGrp.GrpDate ');
//      sql.add('FROM ChargeGrp RIGHT JOIN ChargeDtl ON ChargeGrp.GrpCode=ChargeDtl.DtlCode) set  ChargeDtl.Dtlmoved= '+ IntToStr(MB_TRUE)+',ChargeDtl.DtlRdr ='+inttostr(rec.rdrCode));
//      sql.add('where ChargeGrp.GrpDate<='+''''+rec.rdrBDate+'''' + ' and ChargeDtl.DtlEmplNo = ' +''''+ FixLeft(rec.rdrCardCode,'0',8)+''''  );


//last Query work in sql and access
      sql.add('update ChargeDtl set  ChargeDtl.Dtlmoved= ' + IntToStr(MB_TRUE)+ ',ChargeDtl.DtlRdr = ' + inttostr(rec.rdrCode));
      sql.add('where  ChargeDtl.DtlEmplNo = ''' + FixLeft(rec.rdrCardCode,'0',8) + ''' and');
      sql.add('exists (select * from ChargeGrp where ChargeGrp.GrpCode=ChargeDtl.DtlCode and ChargeGrp.GrpDate<=''' + rec.rdrBDate + ''')');
      ExecSQL;
    finally
      Result := true;
    end;
  end;
end;

function SaveLostCardRecord(var rec : TTerminalRec) : boolean;
var
   p,today : Currency;
begin
  Result := false;
  with frmDBS.adoQryG do
  begin
    try
      SQL.Clear;
      SQL.Add('update LostCard set Lost_RemoveDate = ''' + REC.rdrDate + '''');
      SQL.Add('                   ,Lost_RemoveTime = ''' +inttostr(rec.rdrTime) + '''');
      SQL.Add('                   ,Lost_Price = ' + CurrToStr(rec.rdrPayment));
      SQL.Add('WHERE (Lost_RemoveDate = '''' or Lost_RemoveDate is null) and Lost_EmplID = '''+ FixLeft(rec.rdrCardCode,'0',8)+'''');
      ExecSQL;
    finally
      Result := true;
    end;
  end;
end;

{ Credit card Receipt control with no food program }
function  SaveRecord(var rec : TTerminalRec) : Byte;
var
  i : Byte;
  qry :TADOQuery;
begin
  Rec.rdrCardCode := FixLeft(Rec.rdrCardCode, '0', 8);
  frmDBS.atblEmployee.Open;

  Result := ERR_NONE;
  with frmDBS.atblReceipt1 do
  try
    if not Active then
      Open;
    Append;
    FieldByName('Recit1_Date').AsString := rec.rdrDate;
    FieldByName('Recit1_EmplNo').AsString := rec.rdrCardCode;
    FieldByName('Recit1_Time').AsInteger := rec.rdrTime;
    FieldByName('Recit1_Rdr').AsInteger := rec.rdrCode;
    FieldByName('Recit1_TotalPrice').AsCurrency := rec.rdrPayment;
    FieldByName('Recit1_Service').AsCurrency := rec.rdrService;    
    Post;
  except
    cancel;
//    on E: Exception do ErrorMessage(E.Message);
  end;

  {  with frmDBS.atblReceipt1 do
  begin
    if not Active then
      Open;
//    Filtered := False;
//    Filter := 'Recit1_Date = ''' + rec.rdrDate +
//              ''' AND Recit1_EmplNo = ''' + rec.rdrCardCode +
//              ''' AND Recit1_Time = ' + IntToStr(rec.rdrTime) +
//              '   AND Recit1_Rdr = ' + IntToStr(rec.rdrCode) +
//              '   AND Recit1_TotalPrice = ' + CurrToStr(rec.rdrPayment);
//    Filtered := True;
    qry := TADOQuery.Create(Application);
    with qry do
    begin
      Connection := frmDBS.adoConnect;
      sql.Add('select * from Receipt1 where');
      sql.Add('Recit1_EmplNo = ''' + rec.rdrCardCode + '''');
      sql.Add('and Recit1_Time = ''' + IntToStr(rec.rdrTime) + '''');
      sql.Add('aND Recit1_Rdr = ' + IntToStr(rec.rdrCode));
      sql.Add('AND Recit1_TotalPrice = ' + CurrToStr(rec.rdrPayment));
      Open;
    end;
    if qry.RecordCount > 0 then
    begin
      result := 10;
      qry.Close;
      qry.Free;
      Requery();//close;
      Exit;
    end
    else
    begin
      Append;
      FieldByName('Recit1_Date').AsString := rec.rdrDate;
      FieldByName('Recit1_EmplNo').AsString := rec.rdrCardCode;
      FieldByName('Recit1_Time').AsInteger := rec.rdrTime;
      FieldByName('Recit1_Rdr').AsInteger := rec.rdrCode;
      FieldByName('Recit1_TotalPrice').AsCurrency := rec.rdrPayment;
      Post;
      Requery();//close;
      qry.Close;
      qry.Free;
    end;
  end;
  }
end;

{ return Family+name of employee }
function GetFamilyName(emplNo : String) : String;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_Family, Empl_Name FROM Employee WHERE Empl_No = ''' + emplNo + '''');
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('Empl_Name').AsString <> '' then
        Result := FieldByName('Empl_Family').AsString + '-' + FieldByName('Empl_Name').AsString
      else
        Result := FieldByName('Empl_Family').AsString;

    end
    else
      Result := '';
    Close;
  end;
end;


function  GetEmployee(Code : String; isProxi : boolean) : TEmployee;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Employee WHERE');
    if isProxi then
      SQL.Add('Empl_ID = ''' + code + '''')
    else
      SQL.Add('Empl_No = ''' + code + '''');
    Open;
    if RecordCount > 0 then
    begin
      with Result do
      begin
        EmplCode := FieldByName('Empl_No').AsString;
        EmplID := FieldByName('Empl_ID').AsString;
        EmplName := FieldByName('Empl_Name').AsString;
        EmplFamily := FieldByName('Empl_Family').AsString;
        EmplPart := FieldByName('Empl_part').AsInteger;
        Empl_CoPost := FieldByName('Empl_CoPost').AsInteger;
        Empl_Department := FieldByName('Empl_Department').AsInteger;
        Empl_Active := FieldByName('Empl_Active').AsBoolean;
      end;
    end
    else
    begin
      Result.EmplCode := '';
      Result.EmplID := '';
    end;
    Close;
  end;
end;
{ return }
function GetCreditCardPrice(emplNo : String) : Currency;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_Balance FROM Employee WHERE Empl_No = ''' + emplNo + '''');
    Open;
    if RecordCount > 0 then
      Result := FieldByName('Empl_Balance').AsCurrency
    else
      Result := 0;

    Close;
  end;
end;


{ return error string }
function ReceiptErrorStr(errCode : Byte) : String;
begin
  if errCode in [ERR_SRVC_NOT_SEL..ERR_EMPL_EXPIRED] then
    Result := Error_Str[errCode]
  else
    Result := Error_Str[ERR_NONE];
end;


(************************** Reader procedures ************************)

{ Load Units In Global Variables }
procedure LoadReaders;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Readers WHERE ');//Rdr_Department = ' + IntToStr(gParams.department) + ' and ');
    SQL.Add('Rdr_Active = ' + IntToSTr(MB_TRUE));
    SQL.Add('ORDER BY Rdr_CODE');

    Open;
    rdrCount := 0;
    Setlength(Readers, RecordCount);
    while not EOF do
    begin
      with Readers[rdrCount] do
      begin
        R_Code := FieldByName('Rdr_Code').AsInteger;
        R_Name := FieldByName('Rdr_Name').AsString;
        R_Tel := FieldByName('Rdr_Tel').AsString;
        R_Active := FieldByName('Rdr_Active').AsBoolean;
        R_Port := FieldByName('Rdr_ComPort').AsInteger;
        R_BaudNo := FieldByName('Rdr_BaudRate').AsInteger;
        R_Type := RDR_VEGA9300;
        R_Model := FieldByName('Rdr_DPType').AsInteger;
        R_IP := FieldByName('Rdr_IP').AsString;
        R_IsCom := FieldByName('Rdr_IsCom').AsBoolean;
        R_TCP := true;
      end;
      Next;
      Inc(rdrCount);
    end;

    Close;
  end;
end;

{ Load Units In Global Variables }
function GetReaderName(rdrCode : Byte) : String;
var i : Byte;
begin
  Result := '';
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
      if Readers[i].R_Code = rdrCode then
      begin
        Result := Readers[i].R_Name;
        Break;
      end;
end;


{ Log in and log out department }
procedure LogInLogOut(depCode : Byte; logIn : Boolean);
begin
  with frmDBS.adoQryG do
  begin
    if Active then Close;
    SQL.Clear;
    if logIn then
      SQL.Add('UPDATE Department SET Depart_OnLine = ' + IntToStr(MB_TRUE) + ' WHERE Depart_Code = ' + IntToStr(gParams.department))
    else
      SQL.Add('UPDATE Department SET Depart_OnLine = ' + IntToStr(MB_FALSE) + ' WHERE Depart_Code = ' + IntToStr(gParams.department));
    ExecSQL;
  end;
end;






(******************** frmDBS members body ********************)

procedure TfrmDBS.FormCreate(Sender: TObject);
begin
  LoadDBSInfo;
end;

procedure TfrmDBS.FormActivate(Sender: TObject);
begin
  rdoDBS.ItemIndex := dbsInfo.dbsType - DBS_ACCESS;
  if dbsInfo.dbsType = DBS_ACCESS then
    txtPath.Text := dbsInfo.dbsPath + dbsInfo.dbsName
  else
  begin
    txtPath.Text := dbsInfo.dbsPath;
    txtDBSName.Text := dbsInfo.dbsName;
    txtUser.Text := dbsInfo.dbsUser;
    txtPass.Text := dbsInfo.dbsPass;
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
      lblUser.Visible := False;
      txtUser.Visible := False;
      lblPass.Visible := False;
      txtPass.Visible := False;
    end;

    DBS_SQLSERVER-1: //SQL Server 2000
    begin
      lbl1.Caption := ('‰«„ ”—ÊÌ” œÂ‰œÂ');
      btnPath.Visible := False;
      lbl2.Visible := True;
      lbl2.Caption := ('‰«„ »«‰ﬂ «ÿ·«⁄« Ì');
      txtDBSName.Visible := True;
      lblUser.Caption := ('ﬂ«—»— »«‰ﬂ  «ÿ·«⁄« ');
      lblUser.Visible := True;
      txtUser.Visible := True;
      lblPass.Caption := ('ﬂ·„Â ⁄»Ê—');
      lblPass.Visible := True;
      txtPass.Visible := True;
    end;

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
  else
  begin
    if dbsInfo.dbsType = DBS_ACCESS then
    begin
      dbsInfo.dbsPath := ExtractFilePath(txtPath.Text);
      dbsInfo.dbsName := ExtractFileName(txtPath.Text);
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
          adoQryG.ConnectionString := 'Provider=SQLOLEDB.1;' +
                                      'Persist Security Info=False;' +
                                      'User ID=' + dbsInfo.dbsUser + ';' +
                                      'Password=' + dbsInfo.dbsPass + ';' +
                                      'Data Source=' + dbsInfo.dbsPath;//SQL Authoration
          adoQryG.SQL.Clear;
          adoQryG.SQL.Add('CREATE DATABASE ' + dbsInfo.dbsName);
          adoQryG.SQL.Add('COLLATE Arabic_CI_AI');
          adoQryG.ExecSQL;
          adoQryG.ConnectionString := '';
          adoQryG.Connection := adoConnect;
        end;

        CreateAllTables;

        btnOKClick(Sender);
      end
      else
        ErrorMessage('« ’«· »Â »«‰ﬂ «ÿ·«⁄« Ì „Ì”— ‰Ì” !');
    end
    else if err = '' then
    begin
      AssignFile(f, gOptions.ProgramPath + 'DBSType.Dta');
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
  opnFile.InitialDir := gOptions.ProgramPath;
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
SELECT EN as EMPL_NO , sum(CR) AS TOTAL_CREDIT, max(DT) as LAST_CHARGE_DATE FROM
(
  SELECT ChargeDtl.DtlEmplNo AS EN, ChargeGrp.GrpPrice as CR, ChargeGrp.GrpDate as DT FROM ChargeGrp
  INNER JOIN
  (
    Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo
  ) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode
  WHERE ChargeDtl.DtlEmplNo = '20209440' and chargegrp.GrpDate <= '1385/09/30'
  UNION
  SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_TIME as DT FROM RECEIPT1
  WHERE RECIT1_EMPLNO = '20209440''#$D#$A'and RECIT1_DATE <= '1385/09/30''#$D#$A') GROUP BY EN'#$D#$A


select * from Receipt1 where
Recit1_EmplNo = '85262611'
and Recit1_Time = 714
aND Recit1_Rdr = 1
AND Recit1_TotalPrice = 100
