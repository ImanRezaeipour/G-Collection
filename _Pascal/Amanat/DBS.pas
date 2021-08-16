  unit DBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls, ExtCtrls, ComTools,globals,RunCmnds, StrUtils;

//kaveh is
type
  TNewField = record
    fieldName : string;
    fieldType : TFieldType;
    fieldSize : Smallint;
  end;
  TNewIndex = record
    indexName : string;
    fieldName : string;
    idxOption    : TIndexOptions;
  end;
//kaveh ie

//kaveh is
////////////////////Structure Of Persons Table////////////////////////////
//const personsIdx : array [0..2] of TNewIndex =
//(
//  (indexName : ''        ; fieldName : 'P_BarCode , P_Proxi'; idxOption : [ixPrimary]),
//  (indexName : 'BCodeIdx'; fieldName : 'P_BarCode'; idxOption : [ixUnique]),
//  (indexName : 'ProxiIdx'; fieldName : 'P_Proxi'  ; idxOption : [ixUnique])
//);
//
//const personsTbl : array [0..67] of TNewField =
//(
//   (fieldName : 'P_BarCode'     ; fieldType : ftString    ; fieldSize : 8  ),
//   (fieldName : 'P_Proxi'       ; fieldType : ftString    ; fieldSize : 8  ),
//   (fieldName : 'P_Estekhdami'  ; fieldType : ftString    ; fieldSize : 12 ),
//   (fieldName : 'P_Name'        ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_Family'      ; fieldType : ftString    ; fieldSize : 35 ),
//   (fieldName : 'P_Father'      ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_IDNo'        ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_MeliCode'    ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_FromPlace'   ; fieldType : ftString    ; fieldSize : 15 ),
//   (fieldName : 'P_BirthDate'   ; fieldType : ftString    ; fieldSize : 10 ),
//   (fieldName : 'P_BirthPlace'  ; fieldType : ftString    ; fieldSize : 15 ),
//   (fieldName : 'P_Madrak'      ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_Curse'       ; fieldType : ftString    ; fieldSize : 30 ),
//   (fieldName : 'P_Sex'         ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_Marry'       ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_Military'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_Address'     ; fieldType : ftString    ; fieldSize : 80 ),
//   (fieldName : 'P_Tel'         ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_Domain'      ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_ADUserName'  ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Param'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
//   (fieldName : 'P_Picture'     ; fieldType : ftString    ; fieldSize : 255),
//   (fieldName : 'P_Part1'       ; fieldType : ftInteger   ; fieldSize : 0  ),
//   (fieldName : 'P_Part2'       ; fieldType : ftInteger   ; fieldSize : 0  ),
//   (fieldName : 'P_Part3'       ; fieldType : ftInteger   ; fieldSize : 0  ),
//   (fieldName : 'P_Part4'       ; fieldType : ftInteger   ; fieldSize : 0  ),
//   (fieldName : 'P_Parts'       ; fieldType : ftString    ; fieldSize : 255),
//   (fieldName : 'P_JobCode'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_CoPosts'     ; fieldType : ftInteger   ; fieldSize : 0  ),
//   (fieldName : 'P_Station'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_JobDate'     ; fieldType : ftString    ; fieldSize : 10 ),
//   (fieldName : 'P_EndJobDate'  ; fieldType : ftString    ; fieldSize : 10 ),
//   (fieldName : 'P_ShiftGroup'  ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_RuleGroup'   ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_ShiftGroupM' ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_Vaz'         ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_Reserve1'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Reserve2'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Reserve3'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Reserve4'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Reserve5'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_Reserve6'    ; fieldType : ftString    ; fieldSize : 50 ),
//   (fieldName : 'P_reserve7'    ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_reserve8'    ; fieldType : ftString    ; fieldSize : 20 ),
//   (fieldName : 'P_IsValid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_IsValidweb'  ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_ValidTest'   ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Pricable'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_PrePaid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Credit'      ; fieldType : ftCurrency  ; fieldSize : 0  ),
//   (fieldName : 'P_Sobhaneh'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Nahar'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Sham'        ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_NextSobhaneh'; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Rejim'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_IsGuest'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Special'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_ManyFish'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_EtebarFish'  ; fieldType : ftString    ; fieldSize : 10 ),
//   (fieldName : 'P_dblFoodMax'  ; fieldType : ftSmallInt  ; fieldSize : 10 ),
//   (fieldName : 'P_DblFood'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_CashType'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_DeserNoFood' ; fieldType : ftBoolean   ; fieldSize : 0  ),
//   (fieldName : 'P_Building'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_service'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
//   (fieldName : 'P_Sabegheh'    ; fieldType : ftString    ; fieldSize : 8  ),
//   (fieldName : 'P_MntFoodMax'  ; fieldType : ftSmallInt  ; fieldSize : 10 ),  //kaveh
//   (fieldName : 'P_MntFood'     ; fieldType : ftBoolean   ; fieldSize : 0  )   //kaveh
//);
//kaveh ie

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
function  CreateTable(tblName : String) : Boolean;
Procedure UpgradeTable(tblName : string);
function  changedTbl(dbName : string) : Boolean; //kaveh
Procedure findTbl(var tblName : string;var flds : pointer;var fldhigh:byte;var idxs : pointer;var idxhigh:byte); //kaveh
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
function CalculBalance(emplNo : String ;FromDate , ToDate : string ; var lastCharge : string; var lastChargeCode : Integer) : Currency;
//function CalculMoRangeBalance(emplNo : String ;ToDate : string ; var Credit, MoRangePrice : Currency; var MoRangeMonth, MoRangeDay : Byte; var MoRangeDelRemain : Boolean) : Currency; //kaveh
//function CalculMoRangeBalance(emplNo : String ;{ToDate : string ;} var {Credit,} MoRangePrice : Currency; var MoRangeMonth, MoRangeDay : Byte; var MoRangeDelRemain : Boolean) : Currency; //kaveh
function CalculMoRangeBalance(emplNo : String ;{ToDate, }LastCharge : string ; var {Credit,} MoRangePrice : Currency; var MoRangeMonth, MoRangeDay : Byte; var MoRangeDelRemain : Boolean) : Currency; //kaveh
function Calculkharid(emplNo : String ) : Currency;
function  GetFamilyName(emplNo : String) : String;
function  GetEmployee(Code : String; isProxi : boolean) : TEmployee;
function  GetCreditCardPrice(emplNo : String) : Currency;



{ Receipt Processing }
function SaveChargeRecord(var rec : TTerminalRec) : boolean;
function SaveLostCardRecord(var rec : TTerminalRec) : boolean;
function  SaveRecord(var rec : TTerminalRec) : Byte;
function  ReceiptErrorStr(errCode : Byte) : String;

function UpdateAllChargeRecords(emplNo : String; ADRS : Integer; ToDate : string) : boolean;

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
      dbsInfo.dbsPass:=decodingpass(dbsInfo.dbsPass);
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
              'Password=' + {codingpass(}dbsInfo.dbsPass + ';' +
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
function CreateTable(tblName : String) : Boolean;
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

      SQL.Add(', PRIMARY KEY (CoPost_Code))');
    end
//kaveh is
    else if tblName = 'MoRanges' then
    begin
      SQL.Add('(MoRange_Code Int');
      SQL.Add(', MoRange_Name NVarChar(40)');
      SQL.Add(', MoRange_Price ' + FLD_CURRENCY);
      SQL.Add(', MoRange_Day SmallInt');
      SQL.Add(', MoRange_DelRemain bit');

      SQL.Add(', PRIMARY KEY (MoRange_Code))');
    end
    else if tblName = 'Params' then
    begin
      SQL.Add('(Params_Code Int');
      SQL.Add(', Params_DayOfChangeType SmallInt');

      SQL.Add(', PRIMARY KEY (Params_Code))');
    end
//kaveh ie
    else if tblName = 'Parts' then
    begin
      SQL.Add('(Part_Code Int');
      SQL.Add(', Part_Name NVarChar(40)');
      SQL.Add(', Part_Day SmallInt'); //kaveh
      SQL.Add(', Part_DelRemain bit'); //kaveh

      SQL.Add(', PRIMARY KEY (Part_Code))');
    end
    else if tblName = 'Services' then
    begin
      SQL.Add('(S_Code Int');
      SQL.Add(', S_Name  NVarChar(40)');
      SQL.Add(', S_Price ' + FLD_CURRENCY);
      SQL.Add(', S_Unit  Int');

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
      SQL.Add(', Empl_MoRange Int');
                 
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
      SQL.Add(', Recit1_Status Smallint)'); //kaveh
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
      SQL.Add('(User_Name NVarChar(15)');
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
      SQL.Add(', lost_Price ' + FLD_CURRENCY);
	  SQL.Add(', PRIMARY KEY (lost_Emplno,lost_EmplId))');
    end
    else if tblName = 'Amar3Tbl' then
    begin
      SQL.Add('(date1 NVarChar(10)');
      SQL.Add(', pno1 NVarChar(15)');
      SQL.Add(', time1 int');
      SQL.Add(', mablagh1 '+ FLD_CURRENCY);
      SQL.Add(', code1 int)');
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
    if tblName = 'Users' then
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
  mustadd: boolean;
begin
  if not tblExists(tblName)
  then begin
       CreateTable(tblName);
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

    CreateTable(tblName);

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

//kaveh is
function changedTbl(dbName : string) : Boolean;
{type
  af = array[0..1] of TNewField;
  ax = array[0..1] of TNewIndex;
var
  i : Integer;
  sLoop, eLoop : Byte;
  tbl : tadotable;
  fld : TField;
  flds : ^af;
  idxs : ^ax;
  fldptr : pointer absolute flds;
  idxptr : pointer absolute idxs;
  fldhigh,idxhigh:byte;}
begin
{ $ifndef SqlTools}
{    if not tblexists(dbname)
    then begin
         result:=true;
         exit;
    end;
{ $EndIf}
{    result:=false;

    findtbl(dbname,fldptr,fldhigh,idxptr,idxhigh);

    tbl:=TAdoTable.Create(Application);
    with tbl do
    begin
      Active := false;
      Connection := { $ifdef SqlTools}{frmSQLMenu.adoConct{$else}frmDBS.adoConnect{ $EndIf};
{      TableName := DbName;
      Active := True;
    end;

    sLoop := 0;
    eLoop := fldHigh;
    i:=sloop;
    while not result and (i<=eloop) do
    begin
        fld := tbl.FindField(flds[i].fieldName);
        if  fld = nil
        then result:=true;
        inc(i);
    end;
    tbl.close;
    tbl.Destroy; }
end;
//kaveh ie

//kaveh is
Procedure findTbl(var tblName : string;var flds : pointer;var fldhigh:byte;var idxs : pointer;var idxhigh:byte);
begin
{  tblName := LowerCase(tblName);
  if tblName = 'Department' then
    begin
    flds:=addr(DepartmentTbl);  idxs:=addr(rulesIdx);  fldhigh:=high(rulestbl); idxhigh:=high(rulesIdx);
    end
  else if tblName = 'rulesetc' then
    begin
    flds:=addr(rulesetcTbl);  idxs:=addr(rulesetcIdx);  fldhigh:=high(rulesetctbl); idxhigh:=high(rulesetcIdx);
    end
  else if tblName = 'persons' then
    begin
    flds:=addr(personsTbl);  idxs:=addr(personsIdx);  fldhigh:=high(personsTbl); idxhigh:=high(personsIdx);
    end
  else if tblName = 'personsanpr' then //kaveh
    begin
    flds:=addr(personsANPRTbl);  idxs:=addr(personsANPRIdx);  fldhigh:=high(personsANPRTbl); idxhigh:=high(personsANPRIdx);
    end
  else if tblName = 'tmppersons' then
    begin
    flds:=addr(tmpPersonsTbl);  idxs:=addr(tmpPersonsIdx);  fldhigh:=high(tmpPersonsTbl); idxhigh:=high(tmpPersonsIdx);
    end
  else if tblName = 'cities' then
    begin
      flds:=addr(cityTbl);  idxs:=addr(cityIdx);  fldhigh:=high(cityTbl); idxhigh:=high(cityIdx);
    end
  else if tblName = 'curse' then
    begin
    flds:=addr(curseTbl);  idxs:=addr(curseIdx);  fldhigh:=high(curseTbl); idxhigh:=high(curseIdx);
    end
  else if tblName = 'coposts' then
    begin
    flds:=addr(coPostsTbl);  idxs:=addr(coPostsIdx);  fldhigh:=high(coPostsTbl); idxhigh:=high(coPostsIdx);
    end
  else if tblName = 'jobtype' then
    begin
    flds:=addr(jobTypeTbl);  idxs:=addr(jobTypeIdx);  fldhigh:=high(jobTypeTbl); idxhigh:=high(jobTypeIdx);
    end
  else if tblName = 'parts' then
    begin
    flds:=addr(partsTbl);  idxs:=addr(partsIdx);      fldhigh:=high(partsTbl); idxhigh:=high(partsIdx);
    end
  else if tblName = 'part1' then
    begin
    flds:=addr(part1Tbl);  idxs:=addr(part1Idx);      fldhigh:=high(part1Tbl); idxhigh:=high(part1Idx);
    end
  else if tblName = 'part2' then
    begin
    flds:=addr(part2Tbl);  idxs:=addr(part2Idx);      fldhigh:=high(part2Tbl); idxhigh:=high(part2Idx);
    end
  else if tblName = 'part3' then
    begin
    flds:=addr(part3Tbl);  idxs:=addr(part3Idx);      fldhigh:=high(part3Tbl); idxhigh:=high(part3Idx);
    end
  else if tblName = 'part4' then
    begin
    flds:=addr(part4Tbl);  idxs:=addr(part4Idx);      fldhigh:=high(part4Tbl); idxhigh:=high(part4Idx);
    end
  else if tblName = 'shifts' then
    begin
    flds:=addr(shiftsTbl);  idxs:=addr(shiftsIdx);    fldhigh:=high(shiftsTbl); idxhigh:=high(shiftsIdx);
    end
  else if tblName = 'spshift' then
    begin
    flds:=addr(spShiftTbl);  idxs:=addr(spShiftIdx);  fldhigh:=high(spShiftTbl); idxhigh:=high(spShiftIdx);
    end
  else if tblName = 'spgroup' then
    begin
    flds:=addr(spGroupTbl);  idxs:=addr(spGroupIdx);  fldhigh:=high(spGroupTbl); idxhigh:=high(spGroupIdx);
    end
  else if tblName = 'groups' then
    begin
    flds:=addr(groupsTbl);  idxs:=addr(groupsIdx);    fldhigh:=high(groupsTbl); idxhigh:=high(groupsIdx);
    end
  else if tblName = 'grp_dtl' then
    begin
    flds:=addr(grp_DtlTbl);  idxs:=addr(grp_DtlIdx);  fldhigh:=high(grp_DtlTbl); idxhigh:=high(grp_DtlIdx);
    end
  else if tblName = 'groupm' then
    begin
    flds:=addr(groupMTbl);  idxs:=addr(groupMIdx);    fldhigh:=high(groupMTbl); idxhigh:=high(groupMIdx);
    end
  else if tblName = 'grpm_dtl' then
    begin
    flds:=addr(grpM_DtlTbl);  idxs:=addr(grpM_DtlIdx); fldhigh:=high(grpM_DtlTbl); idxhigh:=high(grpM_DtlIdx);
    end
  else if tblName = 'errors' then
    begin
    flds:=addr(errorsTbl);  idxs:=addr(errorsIdx);    fldhigh:=high(errorsTbl); idxhigh:=high(errorsIdx);
    end
  else if tblName = 'morkhasi' then
    begin
    flds:=addr(morkhasiTbl);  idxs:=addr(morkhasiIdx); fldhigh:=high(morkhasiTbl); idxhigh:=high(morkhasiIdx);
    end
  else if tblName = 'spmor' then
    begin
    flds:=addr(SpMorTbl);  idxs:=addr(SpMorIdx);       fldhigh:=high(SpMorTbl); idxhigh:=high(SpMorIdx);
    end
  else if tblName = 'readers' then
    case appType of
      appClock     : begin flds:=addr(readersTbl);  idxs:=addr(readersIdx);   fldhigh:=high(readersTbl); idxhigh:=high(readersIdx); end;
      appResturant : begin flds:=addr(readersTblr);  idxs:=addr(readersIdxr);   fldhigh:=high(readersTblr); idxhigh:=high(readersIdxr); end;
    end
  else if tblName = 'readersanpr' then //kaveh
    begin
    flds:=addr(readersANPRTbl);  idxs:=addr(readersANPRIdx);   fldhigh:=high(readersANPRTbl); idxhigh:=high(readersANPRIdx);
    end
  else if tblName = 'security' then
    case appType of
      appClock     : begin flds:=addr(securityTbl);  idxs:=addr(securityIdx); fldhigh:=high(securityTbl); idxhigh:=high(securityIdx); end;
      appResturant : begin flds:=addr(securityTblr);  idxs:=addr(securityIdxr); fldhigh:=high(securityTblr); idxhigh:=high(securityIdxr); end;
    end
  else if tblName = 'securityanpr' then //kaveh
    begin
    flds:=addr(securityANPRTbl);  idxs:=addr(securityANPRIdx); fldhigh:=high(securityANPRTbl); idxhigh:=high(securityANPRIdx);
    end
  else if tblName = 'users' then
    begin
    flds:=addr(UsersTbl);  idxs:=addr(UsersIdx);       fldhigh:=high(UsersTbl); idxhigh:=high(UsersIdx);
    end
  else if tblName = 'usersanpr' then //kaveh
    begin
    flds:=addr(UsersANPRTbl);  idxs:=addr(UsersANPRIdx);       fldhigh:=high(UsersANPRTbl); idxhigh:=high(UsersANPRIdx);
    end
  else if tblName = 'userstat' then
    begin
    flds:=addr(userStatTbl);  idxs:=addr(userStatIdx); fldhigh:=high(userStatTbl); idxhigh:=high(userStatIdx);
    end
  else if tblName = 'userstatanpr' then //kaveh
    begin
    flds:=addr(userStatANPRTbl);  idxs:=addr(userStatANPRIdx); fldhigh:=high(userStatANPRTbl); idxhigh:=high(userStatANPRIdx);
    end
  else if tblName = 'lahzeh' then
    begin
    flds:=addr(lahzehTbl);  idxs:=addr(lahzehIdx);     fldhigh:=high(lahzehTbl); idxhigh:=high(lahzehIdx);
    end
  else if tblName = 'madraks' then
    begin
    flds:=addr(madrakTbl);  idxs:=addr(madrakIdx);     fldhigh:=high(madrakTbl); idxhigh:=high(madrakIdx);
    end
  else if tblName = 'reserve7' then
    begin
    flds:=addr(reserve7Tbl);  idxs:=addr(reserve7Idx);     fldhigh:=high(reserve7Tbl); idxhigh:=high(reserve7Idx);
    end
  else if tblName = 'reserve8' then
    begin
    flds:=addr(reserve8Tbl);  idxs:=addr(reserve8Idx);     fldhigh:=high(reserve8Tbl); idxhigh:=high(reserve8Idx);
    end
  else if tblName = 'addfree' then
    begin
    flds:=addr(addFreeTbl);  idxs:=addr(addFreeIdx);   fldhigh:=high(addFreeTbl); idxhigh:=high(addFreeIdx);
    end
  else if tblName = 'finger' then
    begin
    flds:=addr(fingerTbl);  idxs:=addr(FingerIdx);     fldhigh:=high(fingerTbl); idxhigh:=high(fingerIdx);
    end
  else if tblName = 'fgr_dtl' then
    begin
    flds:=addr(fgr_DtlTbl);  idxs:=addr(fgr_DtlIdx);   fldhigh:=high(fgr_DtlTbl); idxhigh:=high(fgr_DtlIdx);
    end
  else if tblName = 'smorkhasi' then
    begin
    flds:=addr(smorkhasiTbl);  idxs:=addr(morkhasiIdx); fldhigh:=high(smorkhasiTbl); idxhigh:=high(smorkhasiIdx);
    end
  else if copy(tblName, 1, 2) = 'p1' then
    begin
    flds:=addr(mahanehTbl);  idxs:=addr(mahanehIdx);   fldhigh:=high(mahanehTbl); idxhigh:=high(mahanehIdx);
    end
  else if (copy(tblName, 1, 2) = 'e1') or (copy(tblName, 1, 2) = 'a1') then
    begin
    flds:=addr(addWorkTbl);  idxs:=addr(addWorkIdx);   fldhigh:=high(addWorkTbl); idxhigh:=high(addWorkIdx);
    end
  else if Copy(tblName, 1, 2) = 'c1' then
    begin
    flds:=addr(monthTbl);  idxs:=addr(monthIdx);       fldhigh:=high(monthTbl); idxhigh:=high(monthIdx);
    end
  else if Copy(tblName, 1, 2) = 'i1' then
    begin
    flds:=addr(IOtypeTbl);  idxs:=addr(IOtypeIdx);       fldhigh:=high(IOTypeTbl); idxhigh:=high(IOTypeIdx);
    end
  else if Copy(tblName, 1, 2) = 't1' then
    begin
    flds:=addr(mojavvezTbl);  idxs:=addr(mojavvezIdx); fldhigh:=high(mojavvezTbl); idxhigh:=high(mojavvezIdx);
    end
  else if Copy(tblName, 1, 2) = 'n1' then
    begin
    flds:=addr(bargehTbl);  idxs:=addr(bargehIdx); fldhigh:=high(bargehTbl); idxhigh:=high(bargehIdx);
    end
  else if tblName = 'doctors' then
    begin
    flds:=addr(doctorsTbl);  idxs:=addr(doctorsIdx);   fldhigh:=high(doctorsTbl); idxhigh:=high(doctorsIdx);
    end
  else if tblName = 'diseases' then
    begin
    flds:=addr(diseasesTbl);  idxs:=addr(diseasesIdx); fldhigh:=high(diseasesTbl); idxhigh:=high(diseasesIdx);
    end
  else if tblName = 'mission1' then
    begin
    flds:=addr(mission1Tbl);  idxs:=addr(mission1Idx); fldhigh:=high(mission1Tbl); idxhigh:=high(mission1Idx);
    end
  else if tblName = 'mission2' then
    begin
    flds:=addr(mission2Tbl);  idxs:=addr(mission2Idx); fldhigh:=high(mission2Tbl); idxhigh:=high(mission2Idx);
    end
  else if tblName = 'onlycard' then
    begin
    flds:=addr(OnlyCardTbl);  idxs:=addr(OnlyCardIdx); fldhigh:=high(OnlyCardTbl); idxhigh:=high(OnlyCardIdx);
    end
  else if tblName = 'afreetyp' then
    begin
    flds:=addr(aFreeTypTbl);  idxs:=addr(aFreeTypIdx); fldhigh:=high(aFreeTypTbl); idxhigh:=high(aFreeTypIdx);
    end
  else if tblName = 'stations' then
    begin
    flds:=addr(StationsTbl);  idxs:=addr(StationsIdx); fldhigh:=high(StationsTbl); idxhigh:=high(StationsIdx);
    end
  else if tblName = 'help' then
    begin
    flds:=addr(HelpTbl);  idxs:=addr(HelpIdx);         fldhigh:=high(HelpTbl); idxhigh:=high(HelpIdx);
    end
  else if tblName = 'pishcard' then
    begin
    flds:=addr(pishcardTbl);  idxs:=addr(pishcardIdx); fldhigh:=high(pishcardTbl); idxhigh:=high(pishcardIdx)
    end
  else if tblName = 'init' then
    begin
    flds:=addr(InitTbl);  idxs:=addr(InitIdx); fldhigh:=high(InitTbl); idxhigh:=high(InitIdx);
    end
  else if tblName = 'initanpr' then //kaveh
    begin
    flds:=addr(InitANPRTbl);  idxs:=addr(InitANPRIdx); fldhigh:=high(InitANPRTbl); idxhigh:=high(InitANPRIdx);
    end
  else if tblName = 'customrp' then
    begin
    flds:=addr(customrpTbl);  idxs:=addr(customrpIdx); fldhigh:=high(customrpTbl); idxhigh:=high(customrpIdx);
    end
  else if tblName = 'customdp' then
    begin
    flds:=addr(customdpTbl);  idxs:=addr(customdpIdx); fldhigh:=high(customdpTbl); idxhigh:=high(customdpIdx);
    end
  else if tblName = 'mktextrp' then
    begin
    flds:=addr(mktextrpTbl);  idxs:=addr(mktextrpIdx); fldhigh:=high(mktextrpTbl); idxhigh:=high(mktextrpIdx);
    end
  else if tblName = 'holiday' then
    begin
    flds:=addr(holidayTbl);  idxs:=addr(holidayIdx); fldhigh:=high(holidayTbl); idxhigh:=high(holidayIdx);
    end
//////////////resturant///////////////////////////////////////
  else if tblName = 'week'  then
    begin
    flds:=addr(Weektbl);  idxs:=addr(WeekIdx); fldhigh:=high(Weektbl); idxhigh:=high(WeekIdx);
    end
  else if tblName = 'units' then
    begin
    flds:=addr(Unitstbl);  idxs:=addr(UnitsIdx); fldhigh:=high(Unitstbl); idxhigh:=high(UnitsIdx);
    end
  else if tblName = 'rdrkey' then
    begin
    flds:=addr(RdrKeytbl);  idxs:=addr(RdrKeyIdx); fldhigh:=high(RdrKeytbl); idxhigh:=high(RdrKeyIdx);
    end
  else if tblName = 'prgprs' then
    begin
    flds:=addr(PrgPrstbl);  idxs:=addr(PrgPrsIdx); fldhigh:=high(PrgPrstbl); idxhigh:=high(PrgPrsIdx);
    end
  else if tblName = 'outgroup' then
    begin
    flds:=addr(OutGrouptbl);  idxs:=addr(OutGroupIdx); fldhigh:=high(OutGrouptbl); idxhigh:=high(OutGroupIdx);
    end
  else if tblName = 'foodpric' then
    begin
    flds:=addr(FoodPricetbl);  idxs:=addr(FoodPriceIdx); fldhigh:=high(FoodPricetbl); idxhigh:=high(FoodPriceIdx);
    end
  else if tblName = 'foodlist' then
    begin
    flds:=addr(FoodListtbl);  idxs:=addr(FoodListIdx); fldhigh:=high(FoodListtbl); idxhigh:=high(FoodListIdx);
    end
  else if tblName = 'fishfood' then
    begin
    flds:=addr(FishFoodTbl);  idxs:=addr(FishFoodIdx); fldhigh:=high(FishFoodTbl); idxhigh:=high(FishFoodIdx);
    end
  else if tblName = 'fish' then
    begin
    flds:=addr(Fishtbl);  idxs:=addr(FishIdx); fldhigh:=high(Fishtbl); idxhigh:=high(FishIdx);
    end
  else if tblName = 'dblfish' then
    begin
    flds:=addr(DblFishTbl);  idxs:=addr(DblFishidx); fldhigh:=high(DblFishTbl); idxhigh:=high(DblFishidx);
    end
  else if tblName = 'ghfish' then
    begin
    flds:=addr(GhFishTbl);  idxs:=addr(GhFishidx); fldhigh:=high(GhFishTbl); idxhigh:=high(GhFishidx);
    end
  else if tblName = 'clckrecs' then
    begin
    flds:=addr(ClckRecsTbl);  idxs:=addr(ClckRecsidx); fldhigh:=high(ClckRecsTbl); idxhigh:=high(ClckRecsidx);
    end
  else if tblName = 'building' then
    begin
    flds:=addr(BuildingTbl);  idxs:=addr(BuildingIdx); fldhigh:=high(BuildingTbl); idxhigh:=high(BuildingIdx);
    end
  else if tblName = 'amartabkh' then
    begin
    flds:=addr(AmarTabkhtbl);  idxs:=addr(AmarTabkhIdx); fldhigh:=high(AmarTabkhtbl); idxhigh:=high(AmarTabkhIdx);
    end
  else if tblName = 'amartabkhf' then
    begin
    flds:=addr(AmarTabkhFtbl);  idxs:=addr(AmarTabkhFIdx); fldhigh:=high(AmarTabkhFtbl); idxhigh:=high(AmarTabkhFIdx);
    end
  else if tblName = 'reservtype' then
    begin
    flds:=addr(ReservTypetbl);  idxs:=addr(ReservTypeIdx); fldhigh:=high(ReservTypetbl); idxhigh:=high(ReservTypeIdx);
    end
  else if tblName = 'charge' then
    begin
    flds:=addr(chargeTbl);  idxs:=addr(chargeIdx); fldhigh:=high(chargeTbl); idxhigh:=high(chargeIdx);
    end
  else if tblName = 'mochlog' then
    begin
    flds:=addr(mochTbl);  idxs:=addr(mochIdx); fldhigh:=high(mochTbl); idxhigh:=high(mochIdx);
    end
  else if tblName = 'yaraneh' then
    begin
    flds:=addr(yaranehTbl);  idxs:=addr(yaranehIdx); fldhigh:=high(yaranehTbl); idxhigh:=high(yaranehIdx);
    end
  else if tblName = 'limitusr' then
    begin
    flds:=addr(limitTbl);  idxs:=addr(limitIdx); fldhigh:=high(limitTbl); idxhigh:=high(limitIdx);
    end
  else if tblName = 'collect' then
    begin
    flds:=addr(collectTbl);  idxs:=addr(collectIdx); fldhigh:=high(collectTbl); idxhigh:=high(collectIdx);
    end
  else if tblName = 'ptemp' then
    begin
    flds:=addr(mahanehTbl);  idxs:=addr(mahanehIdx); fldhigh:=high(mahanehTbl); idxhigh:=high(mahanehIdx);
    end
  else if tblName = 'uhfioanpr' then //kaveh
    begin
    flds:=addr(UHFIOANPRTbl);  idxs:=addr(UHFIOANPRIdx); fldhigh:=high(UHFIOANPRTbl); idxhigh:=high(UHFIOANPRIdx);
    end
  else if tblName = 'ebank' then
    begin
    flds:=addr(ebankTbl);  idxs:=addr(ebankIdx); fldhigh:=high(ebankTbl); idxhigh:=high(ebankIdx);
    end
  else if tblName = 'service' then
    begin
    flds:=addr(serviceTbl);  idxs:=addr(serviceIdx); fldhigh:=high(serviceTbl); idxhigh:=high(serviceIdx);
    end
  else if tblName = 'dservice' then
    begin
    flds:=addr(dserviceTbl);  idxs:=addr(dserviceIdx); fldhigh:=high(dserviceTbl); idxhigh:=high(dserviceIdx);
    end
}
end;

//kaveh is



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
  end;

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

function CalculBalance(emplNo : String ;FromDate , ToDate : string ; var lastCharge : string; var lastChargeCode : Integer) : Currency;
begin
  with frmDBS.adoQryG do
  begin
    close;
    SQL.Clear;
//kaveh    SQL.Add('SELECT EN as EMPL_NO , sum(CR) AS TOTAL_CREDIT, max(DT) as LAST_CHARGE_DATE FROM');
    SQL.Add('SELECT EN as EMPL_NO , sum(CR) AS TOTAL_CREDIT, max(DT) as LAST_CHARGE_DATE, max(DTCD) as LAST_CHARGE_CODE FROM '); //kaveh

    SQL.Add('( ');

////      SQL.Add('SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT');
  ////    SQL.Add('FROM CHARGE WHERE  CHARGE_EMPLNO = ''' + emplNo + '''');

//kaveh    SQL.Add('SELECT ChargeDtl.DtlEmplNo AS EN, ChargeGrp.GrpPrice as CR, ChargeGrp./Grp Date as DT ');
    SQL.Add('SELECT ChargeDtl.DtlEmplNo AS EN, ChargeGrp.GrpPrice as CR, ChargeGrp.GrpDate as DT, ChargeGrp.GrpCode as DTCD '); //kaveh
    SQL.Add(' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode WHERE ChargeDtl.DtlEmplNo = ''' + emplNo + '''');


    if BeautifulDate(FromDate) <> '' then
      SQL.Add(' and chargegrp.GrpDate >= ''' + FromDate + '''');
    if BeautifulDate(ToDate) <> '' then
      SQL.Add(' and chargegrp.GrpDate <= ''' + ToDate + '''');
    SQL.Add(' UNION ALL');
//kaveh    SQL.Add('SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , '''' as DT '); ////kaveh RECIT1_TIME as DT');
    SQL.Add('SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , '''' as DT, '''' as DTCD '); //kaveh
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
      lastChargeCode := FieldByName('LAST_CHARGE_CODE').AsInteger;
    end
    else
    begin
      Result := 0;
      lastCharge := '';
      lastChargeCode := 0;
    end;
  end;
end;

//kaveh is
function CalculMoRangeBalance(emplNo : String ;{ToDate, }LastCharge : string ; var {Credit,} MoRangePrice : Currency; var MoRangeMonth, MoRangeDay : Byte; var MoRangeDelRemain : Boolean) : Currency;
var
  FromDate, ToDate, maxRECIT1_DATE{,maxRECIT1_FromDate,maxRECIT1_ToDate} : string;
  DayOfChangeType : Smallint; //kaveh
{  maxRECIT1_Month : Byte; }
begin
  with frmDBS.adoQryG do
  begin
    close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Params');
    SQL.Add('Where Params_Code = 1');
    Open;

    if FieldByName('Params_Code').AsString = '1' then
      if (FieldByName('Params_DayOfChangeType').AsString = '0') or (FieldByName('Params_DayOfChangeType').AsString = '1') then
        DayOfChangeType := FieldByName('Params_DayOfChangeType').AsInteger
      else
        DayOfChangeType := 0
    else
      DayOfChangeType := 0;



    case DayOfChangeType of
      0:
      begin
        SQL.Clear;
        SQL.Add('SELECT Employee.Empl_No , Employee.Empl_MoRange, ');
        SQL.Add('MoRanges.MoRange_Price, MoRanges.MoRange_Day, MoRanges.MoRange_DelRemain ');
        SQL.Add('FROM Employee LEFT OUTER JOIN MoRanges ');
        SQL.Add('ON Employee.Empl_MoRange = MoRanges.MoRange_Code ');
        SQL.Add('WHERE Employee.Empl_No = ''' + emplNo + '''');
      end;
      1:
      begin
        SQL.Clear;
        SQL.Add('SELECT Employee.Empl_No, Employee.Empl_MoRange, ');
        SQL.Add('MoRanges.MoRange_Price, Parts.Part_Day as MoRange_Day, Parts.Part_DelRemain as MoRange_DelRemain ');
        SQL.Add('FROM Employee LEFT OUTER JOIN ');
        SQL.Add('Parts ON Employee.Empl_Part = Parts.Part_Code LEFT OUTER JOIN ');
        SQL.Add('MoRanges ON Employee.Empl_MoRange = MoRanges.MoRange_Code ');
        SQL.Add('WHERE Employee.Empl_No = ''' + emplNo + '''');
      end;
    end;

//    SQL.Clear;
//    SQL.Add('SELECT Employee.Empl_No , Employee.Empl_MoRange, ');
//    SQL.Add('MoRanges.MoRange_Price, MoRanges.MoRange_Day, MoRanges.MoRange_DelRemain ');
//    SQL.Add('FROM Employee LEFT OUTER JOIN MoRanges ');
//    SQL.Add('ON Employee.Empl_MoRange = MoRanges.MoRange_Code ');
//    SQL.Add('WHERE Employee.Empl_No = ''' + emplNo + '''');
    Open;

    if FieldByName('Empl_MoRange').AsInteger = 0 then
    begin
      MoRangePrice := 2147483647;
//      MoRangeMonth := StrToInt(MidStr(ToDate,6,2));
      MoRangeMonth := StrToInt(MidStr(CurrentDate,6,2));
      MoRangeDay := 1;
      MoRangeDelRemain := False;
      Result := 2147483647;
    end
    else
    begin

      MoRangePrice := FieldByName('MoRange_Price').AsCurrency;
      MoRangeDay := FieldByName('MoRange_Day').AsInteger;
      MoRangeDelRemain := FieldByName('MoRange_DelRemain').AsBoolean;

      close;
      SQL.Clear;
      SQL.Add('SELECT max(RECIT1_DATE) as maxRECIT1_DATE');
      SQL.Add('FROM RECEIPT1 ');
      SQL.Add('where (RECIT1_EMPLNO = ''' + emplNo + ''') ');
      Open;
      maxRECIT1_DATE := FieldByName('maxRECIT1_DATE').AsString;
      if maxRECIT1_DATE = '' then
        if LastCharge <> '' then
          maxRECIT1_DATE := LastCharge
        else
          maxRECIT1_DATE := CurrentDate;

      if StrToInt(RightStr(maxRECIT1_DATE,2)) >= MoRangeDay then
        MoRangeMonth := StrToInt(MidStr(maxRECIT1_DATE,6,2))
      else
      begin
        if StrToInt(MidStr(maxRECIT1_DATE,6,2)) = 1  then
          MoRangeMonth := 12
        else
          MoRangeMonth := StrToInt(MidStr(maxRECIT1_DATE,6,2)) - 1;
      end;
      FromDate := LeftStr(maxRECIT1_DATE,5) + FixLeft(IntToStr(MoRangeMonth),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2);
      if MoRangeMonth = 12 then
        ToDate := IntToStr(StrToInt(LeftStr(FromDate,4)) + 1) + '/' + FixLeft(IntToStr(MoRangeMonth + 1),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2)
      else
        ToDate := LeftStr(FromDate,5) + FixLeft(IntToStr(MoRangeMonth + 1),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2);

{
      if StrToInt(RightStr(ToDate,2)) >= MoRangeDay then
        MoRangeMonth := StrToInt(MidStr(ToDate,6,2))
      else
        MoRangeMonth := StrToInt(MidStr(ToDate,6,2)) - 1;
      FromDate := LeftStr(ToDate,5) + FixLeft(IntToStr(MoRangeMonth),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2);
}

      close;
      SQL.Clear;
      SQL.Add('SELECT EN as EMPL_NO , sum(CR) AS RECIT1_TOTALPRICE FROM ');
      SQL.Add('( ');
      SQL.Add('SELECT RECIT1_EMPLNO as EN , RECIT1_TOTALPRICE as CR  ');
      SQL.Add('FROM RECEIPT1 ');
      SQL.Add('WHERE (RECIT1_EMPLNO = ''' + emplNo + ''') and (RECIT1_DATE >= ''' + FromDate + ''') and (RECIT1_DATE <= ''' + ToDate + ''') ');
//      SQL.Add('and (Recit1_Status <> 14)'); //kaveh
      SQL.Add('and (Recit1_Status <> 14 or Recit1_Status is null) '); //kaveh
      SQL.Add(') a ');
      SQL.Add('GROUP BY EN ');
      Open;


      if MoRangePrice - FieldByName('RECIT1_TOTALPRICE').AsCurrency < 0 then
        Result := 0
      else
        Result := MoRangePrice - FieldByName('RECIT1_TOTALPRICE').AsCurrency;

{
      if MoRangeDelRemain then
      begin
        close;
        SQL.Clear;
        SQL.Add('SELECT max(RECIT1_DATE) as maxRECIT1_DATE');
        SQL.Add('FROM RECEIPT1 ');
        SQL.Add('where (RECIT1_EMPLNO = ''' + emplNo + ''') ');
        Open;
        maxRECIT1_DATE := FieldByName('maxRECIT1_DATE').AsString;

        if StrToInt(RightStr(maxRECIT1_DATE,2)) >= MoRangeDay then
          maxRECIT1_Month := StrToInt(MidStr(maxRECIT1_DATE,6,2))
        else
          maxRECIT1_Month := StrToInt(MidStr(maxRECIT1_DATE,6,2)) - 1;
        maxRECIT1_FromDate := LeftStr(maxRECIT1_DATE,5) + FixLeft(IntToStr(maxRECIT1_Month),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2);
        maxRECIT1_ToDate := LeftStr(maxRECIT1_FromDate,5) + FixLeft(IntToStr(maxRECIT1_Month + 1),'0',2) + '/' + FixLeft(IntToStr(MoRangeDay),'0',2);
        close;
        SQL.Clear;
        SQL.Add('SELECT EN as EMPL_NO , sum(CR) AS RECIT1_TOTALPRICE FROM ');
        SQL.Add('( ');
        SQL.Add('SELECT RECIT1_EMPLNO as EN , RECIT1_TOTALPRICE as CR  ');
        SQL.Add('FROM RECEIPT1 ');
        SQL.Add('WHERE (RECIT1_EMPLNO = ''' + emplNo + ''') and (RECIT1_DATE >= ''' + maxRECIT1_FromDate+ ''') and (RECIT1_DATE <= ''' + maxRECIT1_DATE + ''') ');
        SQL.Add(') a ');
        SQL.Add('GROUP BY EN ');
        Open;
        Credit := Credit - (MoRangePrice - FieldByName('RECIT1_TOTALPRICE').AsCurrency);
      end;
}



    end;
  end;
end;
//kaveh ie

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
//      sql.add('update (SELECT ChargeDtl.DtlCode, ChargeDtl.Dtlmoved, ChargeDtl.DtlRdr, ChargeDtl.DtlEmplNo, ChargeGrp./Grp Date ');
//      sql.add('FROM ChargeGrp RIGHT JOIN ChargeDtl ON ChargeGrp.GrpCode=ChargeDtl.DtlCode) set  ChargeDtl.Dtlmoved= '+ IntToStr(MB_TRUE)+',ChargeDtl.DtlRdr ='+inttostr(rec.rdrCode));
//      sql.add('where ChargeGrp./Grp Date<='+''''+rec.rdrBDate+'''' + ' and ChargeDtl.DtlEmplNo = ' +''''+ FixLeft(rec.rdrCardCode,'0',8)+''''  );


//last Query work in sql and access
      sql.add('update ChargeDtl set  ChargeDtl.Dtlmoved= ' + IntToStr(MB_TRUE)+ ',ChargeDtl.DtlRdr = ' + inttostr(rec.rdrCode));
      sql.add('where  ChargeDtl.DtlEmplNo = ''' + FixLeft(rec.rdrCardCode,'0',8) + ''' and');
//kaveh      sql.add('exists (select * from ChargeGrp where ChargeGrp.GrpCode=ChargeDtl.DtlCode and ChargeGrp./Grp Date<=''' + rec.rdrBDate + ''')');
      sql.add('exists (select * from ChargeGrp where ChargeGrp.GrpCode=ChargeDtl.DtlCode and ChargeGrp.GrpCode<=' + IntToStr(rec.rdrPayment) + ')'); //kaveh
      ExecSQL;
    finally
      Result := true;
    end;
  end;
end;

//kaveh is
function UpdateAllChargeRecords(emplNo : String; ADRS : Integer; ToDate : string) : boolean;
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
//      sql.add('update (SELECT ChargeDtl.DtlCode, ChargeDtl.Dtlmoved, ChargeDtl.DtlRdr, ChargeDtl.DtlEmplNo, ChargeGrp./Grp Date ');
//      sql.add('FROM ChargeGrp RIGHT JOIN ChargeDtl ON ChargeGrp.GrpCode=ChargeDtl.DtlCode) set  ChargeDtl.Dtlmoved= '+ IntToStr(MB_TRUE)+',ChargeDtl.DtlRdr ='+inttostr(rec.rdrCode));
//      sql.add('where ChargeGrp./Grp Date<='+''''+rec.rdrBDate+'''' + ' and ChargeDtl.DtlEmplNo = ' +''''+ FixLeft(rec.rdrCardCode,'0',8)+''''  );

//last Query work in sql and access


      sql.add('update ChargeDtl set  ChargeDtl.Dtlmoved = ' + IntToStr(MB_TRUE)+ ',ChargeDtl.DtlRdr = ' + inttostr(ADRS));
      sql.add('where  ChargeDtl.DtlEmplNo = ''' + FixLeft(emplNo,'0',8) + ''' and');
      sql.add('exists (select * from ChargeGrp where ChargeGrp.GrpCode = ChargeDtl.DtlCode and ChargeGrp.GrpDate <= ''' + ToDate + ''')');
{kaveh
      sql.add('update ChargeDtl set  ChargeDtl.Dtlmoved= ' + IntToStr(MB_TRUE)+ ',ChargeDtl.DtlRdr = ' + inttostr(rec.rdrCode));
      sql.add('where  ChargeDtl.DtlEmplNo = ''' + FixLeft(rec.rdrCardCode,'0',8) + ''' and');
      sql.add('exists (select * from ChargeGrp where ChargeGrp.GrpCode=ChargeDtl.DtlCode and ChargeGrp./Grp Date<=''' + rec.rdrBDate + ''')');
kaveh}
      ExecSQL;
    finally
      Result := true;
    end;
  end;
end;
//kaveh ie

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
  try
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    with qry do
    begin
      SQL.Clear;
      SQL.Add(' IF not EXISTS');
      SQL.Add(' (');
      SQL.Add(' SELECT Recit1_EmplNo');
      SQL.Add(' FROM Receipt1');
      SQL.Add(' WHERE (Recit1_Date = ''' + rec.rdrDate + ''') AND (Recit1_EmplNo = ''' + rec.rdrCardCode + ''') AND (Recit1_Time = ''' + IntToStr(rec.rdrTime) + ''') AND (Recit1_Rdr = ' + IntToStr(rec.rdrCode) + ')');
      SQL.Add(' AND (Recit1_TotalPrice = ' + IntToStr(rec.rdrPayment) + ')'); //kaveh
      SQL.Add(' )');
      SQL.Add(' INSERT INTO Receipt1');
      SQL.Add(' (Recit1_Date, Recit1_EmplNo, Recit1_Time, Recit1_Rdr, Recit1_TotalPrice, Recit1_Status)');
      SQL.Add(' Values (''' + rec.rdrDate + ''', ''' + rec.rdrCardCode + ''', ''' + IntToStr(rec.rdrTime) + ''', ' + IntToStr(rec.rdrCode)+ ', ' + IntToStr(rec.rdrPayment) + ', ' + IntToStr(rec.rdrStatus) + ' )');
      ExecSQL;
    end;
  finally
      qry.Close;
      qry.Free;
  end;

{kaveh
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
    Post;
  except
    cancel;
//    on E: Exception do ErrorMessage(E.Message);
  end;
kaveh}
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
                                      'Password=' + codingpass(dbsInfo.dbsPass) + ';' +
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
      Writeln(f, codingpass(dbsInfo.dbsPass));
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
  SELECT ChargeDtl.DtlEmplNo AS EN, ChargeGrp.GrpPrice as CR, ChargeGrp./Grp Date as DT FROM ChargeGrp
  INNER JOIN
  (
    Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo
  ) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode
  WHERE ChargeDtl.DtlEmplNo = '20209440' and chargegrp./Grp Date <= '1385/09/30'
  UNION
  SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_TIME as DT FROM RECEIPT1
  WHERE RECIT1_EMPLNO = '20209440''#$D#$A'and RECIT1_DATE <= '1385/09/30''#$D#$A') GROUP BY EN'#$D#$A


select * from Receipt1 where
Recit1_EmplNo = '85262611'
and Recit1_Time = 714
aND Recit1_Rdr = 1
AND Recit1_TotalPrice = 100
