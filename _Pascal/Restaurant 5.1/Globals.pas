unit Globals;

interface

uses
  Forms, SysUtils, Controls, StdCtrls, WinSvc, Windows;

const
  AppVersion  = '5.1';
  softwarecode  = 3;
  refreshpriod  = 5;
var
  maxusers    : byte = 3;
  lastrefresh : integer;

  logocode    : string[4];
  islogo      : boolean = false;

const
  isGostar     = false;

  MB_NONE      = 0;

  MNU_BASE      = 0;
  MNU_RESTURANT = 1;
  MNU_REPORT    = 2;
  MNU_RELATION  = 3;
  MNU_TOOLS     = 4;

  MB_NEW       = 1;
  MB_EDIT      = 2;
  MB_DELETE    = 4;
  MB_VIEW      = 8;

  PRC_PERSON   = 0;
  PRC_PEYMANY  = 1;

  MB_FIRSTCARD = 0;
  MB_ODD_CARD  = 1;

  MB_FALSE     = 0;
  MB_TRUE      = 1;

  RDR_RESTZ84   = 0;
  RDR_RESTZ80   = 1;
  RDR_CLOCKZ84  = 2;
  RDR_CLOCKZ80  = 3;
  RDR_PROXI     = 4;
  RDR_BIOLITE   = 5;
  RDR_BIOSTATION= 6;
  RDR_XSTATION  = 7;
  ReadersName  : array[RDR_RESTZ84..RDR_XSTATION] of String =
                 ('رستوراني Z84', 'رستوراني Z80', 'ساعت Z84', 'ساعت Z80', 'Proximity', 'BioLite', 'BioStation', 'X-Station');

  MB_RESTART   = 1;
  MB_TEST      = 2;
  MB_DATETIME  = 3;
  MB_TBLSEND   = 4;
  MB_VER       = 5;
  MB_ONLINE    = 6;
  MB_READRECS  = 7;
  MB_RECOVERY  = 8;
  MB_INITIAL   = 9;

  MB_SOBHANEH   = 1;
  MB_GHAZA      = 2;
  MB_MOKHALAFAT = 3;
  MB_KHADAMAT   = 4;

  MB_SOBH       = 1;
  MB_NAHAR      = 2;
  MB_SHAM       = 3;
  MB_SOBHNEXT   = 4;
  MB_NEXTSOBH   = 5;
  FoodName : array[MB_SOBH..MB_SOBHNEXT] of string = ('صبحانه', 'ناهار', 'شام','صبحانه');

  ErrMsg : array[1..20] of string = (
    { 1}'كارت غير مجاز مي‌باشد.',
    { 2}'ورود فرد ثبت نشده است.',
    { 3}'درخواست خارج از محدوده زماني است.',
    { 4}'انتخاب بيش از يك غذا غير مجاز است.',
    { 5}'غذاي اضافي سرو نمي‌شود.',
    { 6}'صبحانه سرو نمي‌شود.',
    { 7}'ناهار سرو نمي‌شود.',
    { 8}'شام سرو نمي‌شود.',
    { 9}'فرد حق انتخاب اين وعده را ندارد.',
    {10}'برنامه غذايي تنظيم نشده است.',
    {11}'غذا تمام شد.',
    {12}'اجازه تردد از فرد سلب شده است.',
    {13}'انتخاب وعده در گروه و اضافه كاري نمي‌باشد.',
    {14}'تاريخ اعتبار كارت به پايان رسيده است.',
    {15}'انتخاب غذاي نامجاز.',
    {16}'رزرو انجام نشده است .',
    {17}'غذا در اين ساختمان رزرو نشده است .',
    {18}'اعتبار كافي نيست !',
    {19}'فرد حق رزرو در این ساختمان را ندارد.', //kaveh
    {20}'هیچ ساختمانی برای رزرو انتخاب نشده است.' //kaveh
    );

  MB_BACKUP    = 'BackUp';
  MB_RESTORE   = 'Restore';

  PRN_LX            = 0;
  PRN_LQ            = 1;
  PRN_CITIZEN3551   = 2;
  PRN_CITIZEN3541   = 3;
  PRN_ITHACA        = 4;
  PRN_SAMSUNG350    = 5;
  PRN_SAMSUNG350Plus= 6;
  PRN_CITIZENs2000  = 7;

  MB_NORMAL       = 0;
  MB_ANYCARD      = 1;
  MB_DATECARD     = 2;
  MB_ANYDATECARD  = 3;

  MONTH_PATH   = 'Month';

  ADMIN_NAME   = 'ADMIN';

  BUFFER_EMPTY = -20;

  MonthName : array[1..12] of String = (
              'فروردين', 'ارديبهشت', 'خرداد',
              'تير', 'مرداد', 'شهريور',
              'مهر', 'آبان', 'آذر',
              'دي', 'بهمن', 'اسفند' );



type KeyType = array[0..30] of string[30];

type TPrice = record
  PriceFee     : Currency;
  PricePerson  : Currency;
end;

Type TOptions = Record
  ProgramPath  : String;
  DataBasePath : String;
  DB_MonthPath : String;
  ClockDBS     : String;
  CoName       : String;
  Shobeh       : String;
  UserName     : String;
  WinType      : Byte;
  AcesPrint    : Boolean;
  ArchiveDate  : Byte;
  RunDate      : String[10];

  RptFDate     : String[10];
  RptTDate     : String[10];
  userPart1    : Integer;
  userPart2    : Integer;
  userPart3    : Integer;
  userPart4    : Integer;
{ $ELSE}                    //finalize needed-
  userParts    : String;
  userStations : integer;
end;



type TParams = record
  SobhFirstFish  : integer;
  NaharFirstFish : integer;
  ShamFirstFish  : integer;
  Vadeh        : array[MB_SOBH..MB_NextSOBH] of Byte;
  FromSobh     : String[5];
  ToSobh       : String[5];
  SobhKeyNo    : Byte;

  FromNahar    : String[5];
  ToNahar      : String[5];
  NaharKeyNo   : Byte;

  FromSham     : String[5];
  ToSham       : String[5];
  ShamKeyNo    : Byte;

  Mokhlafat    : Byte;
  SobhInSham   : byte;
  Kasr         : byte;
  KasrShavad   : boolean;
  OffOutTime   : Byte;

  FirstFoodPrcPerson  : Integer;
  SecondFoodPrcPerson : Integer;
  FirstFoodPrcGuest   : Integer;
  SecondFoodPrcGuest  : Integer;

  ControlBase  : Integer;
  ClockOnLine  : Byte;
  ClockCycle   : Integer;
//  RestCycle    : integer;

  PrintFish    : Byte;
  PrnType      : Byte;
  LineFeed     : Byte;
  AllFishPrc   : Byte;

  Mdm_Active   : Byte;
  Mdm_Port     : Byte;
  Mdm_Baud     : Byte;
  Mdm_IsTel    : Byte;
  Mdm_TelNum   : String;

  EndRep1       : String[30];
  EndRep2       : String[30];
  EndRep3       : String[30];
  EndRep4       : String[30];

  Endfish1      : String[30];
  Endfish2      : String[30];
  Endfish3      : String[30];
  Endfish4      : String[30];
  Endfish5      : String[30];

  Endfishactive1    : boolean;
  Endfishactive2    : boolean;
  Endfishactive3    : boolean;
  Endfishactive4    : boolean;
  Endfishactive5    : boolean;


  SobhaneMaxIn  : String[5];
  NaharMaxIn    : String[5];
  ShamMaxIn     : String[5];

  CollectFrom   : byte; // 0 : from Readers      1 : from Clock2.31 sqlServer DataBase

  ClkServerName   : string;
  Clkdatabasename : string;
  ClkSqlUseName   : string;
  ClkSqlPassword  : string;

  RestServerName     : string;
  RestSqlUseName     : string;
  RestSqlPassword    : string;

  Building   : byte;
  RunReserve : byte;
  MustReserve : byte;
  ValidInAllBuilding : byte;
  MinCredit : Currency;
  CollectUser : string;
  //FodPrcChngable: Byte;

  PrsImgsFld       : string; //kaveh
  PrsImgsFldActive : Boolean; //kaveh

  AutoLoginActive  : Boolean;
  AutoLoginUser    : string;
  AutoLoginPass    : string;

  AutoFishLstPicsActive:Boolean;
  AutoFishLstPicsRdrCodeR:string;
  AutoFishLstPicsRdrCodeL:string;
end;


type TReaders = record
  R_Code        : Byte;
  R_Name        : String[20];
  R_Active      : Boolean;
  R_Port        : Byte;
  R_BaudNo      : Byte;
  R_OnLine      : Boolean;
  R_Type        : Integer;
  R_Modem       : Boolean;
  RK_Key        : Integer;

  RdrBad        : Byte;
  RdrGood       : Byte;
  Recoverd      : Boolean;
  OnLineIdx     : Byte;
  SycleTime     : Integer;
  OffClock_N    : Byte;

  CardNumber    : String[8];
  NameFamily    : String[25];
  FishNumber    : String[6];
  FishTime      : String[5];
  RdrTime       : String[8];
  RdrState      : String[8];

  R_IP          : String[15];
  R_IsCom       : Boolean;
  R_TCP         : Boolean;
  R_Building    : integer;
  R_PrintFish   : Boolean;
  R_PrnType     : integer;
  R_LineFeed    : integer;
  R_AllFishPrc  : Boolean;
  R_ignorename  : Boolean;
  R_PrintCntr   : Byte;
end;

type TFoodList = record
  Food_Code     : Integer;
  Food_Name     : String[40];
  Food_Type     : Byte;
  FoodPrice     : TPrice;
end;

type TDayProg = record
  Keys          : array[0..9] of Integer;
  FoodAmar      : array[1..8] of Integer;
end;

type TPerson = Record
  P_BarCode     : String[8];
  P_Proxi       : String[15];
  P_Name        : String[10];
  P_Family      : String[15];
  P_Parts       : string;
  P_JobCode     : Integer;
  P_ShiftGroup  : Integer;
  P_Isvalid     : Boolean;
  p_prepaid     : boolean;
  p_sumfish     :Currency ;
  p_prepai      : boolean;
  P_ValidTest   : Boolean;
  P_PriceAble   : Boolean;
  p_credit      :Currency;
  P_Vadeh       : array[MB_SOBH..MB_SHAM] of Boolean;
  P_Rejim       : Boolean;
  P_IsGuest     : Boolean;
  P_Special     : Integer;
  P_ManyFish    : Integer;
  P_EtebarFish  : String[10];
  P_dblFoodMax  : Integer;
  P_DblFood     : Boolean;
  P_CashType    : Integer;  //define type of cashing : 1-personely 2-peymankary 3-in order to parameters setting
  p_building    : integer;
  p_exist       : boolean;
  P_reserve1    : String[50]; //kaveh
  P_MntFood     : Boolean; //kaveh
  P_MntFoodMax  : Smallint; //kaveh
  P_Picture     : String; //kaveh
end;

type TFish = record
  Fish_No       : Integer;
  Fish_RdrFishNo: Integer;
  Fish_PCode    : String[8];
  Fish_BarCode  : String[8]; //kaveh
  Fish_Date     : String[10];
  Fish_Time     : String[5];
  Fish_mmTime   : String[5]; //kaveh
  Fish_Type     : Byte;
  Fish_Foods    : array[1..8] of Integer;
  Fish_FoodsNo  : array[1..8] of Integer;
  Fish_Price    : array[1..8] of Currency;
  Fish_RdrCode  : integer;
  Fish_UCode    : Integer;
  Fish_UKhadamat: Integer;
  Fish_UPrc     : Currency;
  Fish_UPay     : Currency;

  IsProxi       : Boolean;
  Keys          : Integer;
  IsPayed       : Boolean;
  ManySel       : Integer;
  PrePaid       : boolean;
  rdrStatus     : Integer; //kaveh
  
end;

type
  TClockRecord = record
    Clock_BarCode  : String[8];
    Clock_Date     : String[10];
    Clock_Time     : String[5];
    Clock_RdrCode  : Integer;
    Clock_RecState : Integer;
  end;
  TGroup = record
    Code          : byte;
    fromSobh      : string[5];
    ToSobh        : string[5];
    fromNahar     : string[5];
    ToNahar       : string[5];
    fromSham      : string[5];
    ToSham        : string[5];
    shdirooz      : boolean;
  end;



var
  g_Options     : TOptions;
  F_Params      : TParams;
  DayGroup      : TGroup;
  Readers       : array[1..100] of TReaders;
  DayFoodList   : array[MB_SOBH..MB_SOBHNEXT] of TDayProg;
  FoodsList     : array[1..500] of TFoodList;
  UsedFoods     : array[MB_SOBH..MB_SOBHNEXT,1..8] of Integer;
  TotalFoods,
  TotalActvRdr,
  TotalOnLineRdr,
  TotalReader   : integer;
  Sobh_Fish_No,
  Nahar_Fish_No,
  Sham_Fish_No,
  SobhNext_Fish_No : Integer;
  FP_Test       : Text;
  rdrFishNumbring : boolean; 
  Linked_To_Clock: Boolean;  
Const
  RptTitleFont = 'tahoma';
  RptTitleFntSize = 10;
  RptFont = 'tahoma';
  RptFntSize = 8;


procedure Mouse_Wait;
procedure Mouse_NoWait;
function  CodingPassWord(Pass : String) : String;
function  GetRandom : LongInt;
function  Coma(txt : String) : String;
function  CurrencyFormat(s : String) : String;
function  FromBCD(n : Byte) : Byte;
function  ToBCD(n : Byte) : Byte;
function  HexToChar(hx : Byte) : Char;
function  ByteToHex(i : Byte) : String;
function  FixLen(ST : String; ch : Char; Len : Byte) : String;
function  FixLeft(ST : String; ch : Char; Len : Byte) : String;
function  IsNumeric(ST : String) : Boolean;
function  StrRev(txt : String) : String;
function  NumReverse(ST : String) : String;
function  DelLeftZero(txt : String) : String;
function  Pow2(n : Byte) : Integer;

function  GetSerialNo(drv : Char) : String;

function  TextToWin(s : String) : String;

procedure LoadIniFile;
procedure SaveIniFile;
procedure SaveKeyPads(Keys : KeyType);
procedure LoadKeyPads(var Keys : KeyType);
procedure OpenTestFile;
procedure CloseTestFile;

function ServiceGetStatus(sMachine, aServiceName: string ): DWORD;
function ServiceStart(aMachine, aServiceName : string ) : Boolean;
function ServiceStop(aMachine,aServiceName : string ) : Boolean;

implementation

uses
  Code_Sys, MSGs,main;

(***********************************************************************
  Change Mouse Cursor to Glass
 ***********************************************************************)
procedure Mouse_Wait;
begin
  Screen.Cursor := crHourGlass;
end;

(***********************************************************************
  Change Mouse Cursor to Arrow
 ***********************************************************************)
procedure Mouse_NoWait;
begin
  Screen.Cursor := crArrow;
end;

(***********************************************************************
  Coding Password
 ***********************************************************************)
function CodingPassWord(Pass : String) : String;
var
  i : Integer;
begin
  for i := 1 to Length(Pass) do
    Pass[i] := Chr(Ord(Pass[i]) xor 118);
  CodingPassWord := Pass;
end;

(*******************************************************
  Coding Password
 ***********************************************************************)
function GetRandom : LongInt;
begin
  Randomize;
  GetRandom := (Random(9000) + 1000) * 10000 + Random(10000);
end;

(***********************************************************************
  Set Coma in string
 ***********************************************************************)
function Coma(txt : String) : String;
var t : String;
begin
  t := '';
  while Length(txt) > 3 do
  begin
    t := ',' + Copy(txt, Length(txt)-2, 3) + t;
    Delete(txt, Length(txt)-2, 3);
  end;
  Coma := txt + t;
end;

function CurrencyFormat(s : String) : String;
begin
  CurrencyFormat := Coma(s) + ('ريال');
end;


(***********************************************************************
  Change a Decimal number to BCD
 ***********************************************************************)
function ToBCD(n : Byte) : Byte;
begin
  ToBCD := n div 10 * 6 + n;
end;

(***********************************************************************
  Change a BCD Number to Decimal
 ***********************************************************************)
function FromBCD(n : Byte) : Byte;
begin
  FromBCD := n - (n div 16 * 6);
end;

function HexToChar(hx : Byte) : Char;
begin
  if hx < 10 then
    HexToChar := Chr(hx + 48)
  else
    HexToChar := Chr(hx + 55);
end;

function ByteToHex(i : Byte) : String;
begin
  ByteToHex := HexToChar(I div 16) + HexToChar(I mod 16);
end;


(***********************************************************************
  Fix a string to len
 ***********************************************************************)
function FixLen(ST : String; ch : Char; Len : Byte) : String;
begin
  if Length(ST) > Len then
    ST := Copy(ST, 1, Len)
  else
    while Length(ST) < Len do
      ST := ST + ch;
  FixLen := ST;
end;

(***********************************************************************
  Fix a string to len
 ***********************************************************************)
function FixLeft(ST : String; ch : Char; Len : Byte) : String;
begin
  if Length(ST) > Len then
    ST := Copy(ST, 1, Len)
  else
    while Length(ST) < Len do
      ST := ch + ST;
  FixLeft := ST;
end;

(***********************************************************************
  Return True if st is a numeric field
 ***********************************************************************)
function IsNumeric(ST : String) : Boolean;
var i : Byte;
begin
  IsNumeric := True;
  for i := 1 to Length(ST) do
    if not (ST[i] in ['0'..'9']) then
    begin
      IsNumeric := False;
      Break;
    end;
end;


(***********************************************************************
  Return Revert of a String
 ***********************************************************************)
function StrRev(txt : String) : String;
var
  i : Byte;
  s : String;
begin
  s := '';
  for i := Length(txt) downto 1 do
    s := s + txt[i];
  StrRev := s;
end;

(***********************************************************************
  Revrert number in string
 ***********************************************************************)
function NumReverse(ST : String) : String;
const
   NUMS : set of  Char = ['0'..'9'];
var
   i, k : Byte;
   ST1, ST2 : String;
BEGIN
  ST2 := '';
  i := 1;
  while i <= Length(ST) do
  begin
    if ST[i] in NUMS then
    begin
      ST1 := '';
      while (ST[i] in NUMS) and (i <= Length(ST)) do
      begin
        ST1 := ST1 + ST[i];
        Inc(i);
      end;
      for K := Length(ST1) downto 1 do
        ST2 := ST2 + ST1[K];
    end
    else
    begin
      ST2 := ST2 + ST[i];
      Inc(i);
    end;
  end;
  NumReverse := ST2;
end;

(***********************************************************************
  Delete zero character from left side a String
 ***********************************************************************)
function DelLeftZero(txt : String) : String;
var
  i : Byte;
  S : String;
begin
  S := '';
  if txt <> '' then
  begin
    for i := 1 to Length(txt)-1 do
      if txt[i] <> '0' then
        Break;
    for i := i to Length(txt) do
      S := S + txt[i];
  end;
  DelLeftZero := S;
end;


(***********************************************************************

 ***********************************************************************)
function Pow2(n : Byte) : Integer;
var
  i : Byte;
  k : Integer;
begin
  k := 1;
  for i := 1 to n do
    k := k * 2;
  Pow2 := k;
end;


(***********************************************************************
  Get Drive Serial Number
 ***********************************************************************)
function GetSerialNo(drv : Char) : String;
begin
  GetSerialNo := 'Resturant';
end;

function TextToWin(s : String) : String;
begin
   TextToWin := ChangeFromWin(s, g_options.WinType, WIN_SINA_SYS);
end;


procedure LoadIniFile;
var
   f : Text;
   i:byte;
   s : string;
begin
  if FileExists(g_options.ProgramPath + 'Resturan.Ini') then
  begin
    Assign(f, g_options.ProgramPath + 'Resturan.Ini');
    Reset(f);
    try
      ReadLn(f, g_options.ArchiveDate);

      ReadLn(f, F_Params.Vadeh[MB_SOBH]);
      ReadLn(f, F_Params.FromSobh);
      ReadLn(f, F_Params.ToSobh);
      ReadLn(f, F_Params.SobhKeyNo);

      ReadLn(f, F_Params.Vadeh[MB_NAHAR]);
      ReadLn(f, F_Params.FromNahar);
      ReadLn(f, F_Params.ToNahar);
      ReadLn(f, F_Params.NaharKeyNo);

      ReadLn(f, F_Params.Vadeh[MB_SHAM]);
      ReadLn(f, F_Params.FromSham);
      ReadLn(f, F_Params.ToSham);
      ReadLn(f, F_Params.ShamKeyNo);
      F_Params.Vadeh[MB_SOBHNEXT] := F_Params.Vadeh[MB_SOBH];
      
      ReadLn(f, F_Params.Mokhlafat);
      ReadLn(f, F_Params.SobhInSham);
      ReadLn(f, F_Params.Kasr);
      ReadLn(f, F_Params.OffOutTime);

      ReadLn(f, F_Params.FirstFoodPrcPerson);
      ReadLn(f, F_Params.SecondFoodPrcPerson);
      ReadLn(f, F_Params.FirstFoodPrcGuest);
      ReadLn(f, F_Params.SecondFoodPrcGuest);

      ReadLn(f, F_Params.ControlBase);
      ReadLn(f, F_Params.ClockOnLine);
      ReadLn(f, F_Params.ClockCycle);
//      ReadLn(f, F_Params.RestCycle);

      ReadLn(f, F_Params.PrintFish);
      ReadLn(f, F_Params.PrnType);
      ReadLn(f, F_Params.LineFeed);
      ReadLn(f, F_Params.AllFishPrc);

      ReadLn(f, F_Params.Mdm_Active);
      ReadLn(f, F_Params.Mdm_Port);
      ReadLn(f, F_Params.Mdm_Baud);
      ReadLn(f, F_Params.Mdm_IsTel);
      ReadLn(f, F_Params.Mdm_TelNum);

      ReadLn(f, F_Params.EndRep1);
      ReadLn(f, F_Params.EndRep2);
      ReadLn(f, F_Params.EndRep3);
      ReadLn(f, F_Params.EndRep4);

      ReadLn(f, F_Params.SobhaneMaxIn);
      ReadLn(f, F_Params.NaharMaxIn);
      ReadLn(f, F_Params.ShamMaxIn);

      ReadLn(f, F_Params.CollectFrom);   // 0: from Readers      1: from Clock2.31 sqlServer DataBase

      ReadLn(f, F_Params.ClkServerName);
      ReadLn(f, F_Params.Clkdatabasename);
      ReadLn(f, F_Params.ClkSqlUseName);
      ReadLn(f, F_Params.ClkSqlPassword);

      //ReadLn(f, F_Params.FodPrcChngable);
      ReadLn(f, F_Params.SobhFirstFish);
      if F_Params.SobhFirstFish = 0 then
        F_Params.SobhFirstFish := 1;
      ReadLn(f, F_Params.NaharFirstFish);
      if F_Params.NaharFirstFish = 0 then
        F_Params.NaharFirstFish := 1;
      ReadLn(f, F_Params.ShamFirstFish);
      if F_Params.ShamFirstFish = 0 then
        F_Params.ShamFirstFish := 1;

      ReadLn(f, F_Params.RestServerName);
      ReadLn(f, F_Params.RestSqlUseName);
      ReadLn(f, F_Params.RestSqlPassword);

      ReadLn(f, F_Params.Building);
      ReadLn(f, F_Params.RunReserve);
      ReadLn(f, F_Params.MustReserve);
      ReadLn(f, F_Params.ValidInAllBuilding);

      ReadLn(f, F_Params.Endfish1);
      readln(f,i);
      F_Params.Endfishactive1:=(i=1);
      ReadLn(f, F_Params.Endfish2);
      readln(f,i);
      F_Params.Endfishactive2:=(i=1);
      ReadLn(f, F_Params.Endfish3);
      readln(f,i);
      F_Params.Endfishactive3:=(i=1);
      ReadLn(f, F_Params.Endfish4);
      readln(f,i);
      F_Params.Endfishactive4:=(i=1);
      ReadLn(f, F_Params.Endfish5);
      readln(f,i);
      F_Params.Endfishactive5:=(i=1);
      readln(f,s);
      if s<>'' then
        F_Params.minCredit := StrToCurr(s)
      else
        f_Params.minCredit := 0;

      ReadLn(f, F_Params.CollectUser);
      ReadLn(f, F_Params.PrsImgsFld); //kaveh
      readln(f,i); //kaveh
      F_Params.PrsImgsFldActive := (i=1); //kaveh

      readln(f,i); //kaveh
      F_Params.AutoLoginActive := (i=1); //kaveh
      ReadLn(f, F_Params.AutoLoginUser); //kaveh
      ReadLn(f, F_Params.AutoLoginPass); //kaveh

      readln(f,i); //kaveh
      F_Params.AutoFishLstPicsActive := (i=1); //kaveh
      ReadLn(f, F_Params.AutoFishLstPicsRdrCodeR); //kaveh
      ReadLn(f, F_Params.AutoFishLstPicsRdrCodeL); //kaveh
    except
      ErrorMessage('تنظيمات را مجددا انجام دهيد.');
    end;
    Close(f);
  end;
end;

procedure SaveIniFile;
var f : Text;
begin
  Assign(f, g_options.ProgramPath + 'Resturan.Ini');
  ReWrite(f);
  WriteLn(f, g_options.ArchiveDate);

  WriteLn(f, F_Params.Vadeh[MB_SOBH]);
  WriteLn(f, F_Params.FromSobh);
  WriteLn(f, F_Params.ToSobh);
  WriteLn(f, F_Params.SobhKeyNo);

  WriteLn(f, F_Params.Vadeh[MB_NAHAR]);
  WriteLn(f, F_Params.FromNahar);
  WriteLn(f, F_Params.ToNahar);
  WriteLn(f, F_Params.NaharKeyNo);

  WriteLn(f, F_Params.Vadeh[MB_SHAM]);
  WriteLn(f, F_Params.FromSham);
  WriteLn(f, F_Params.ToSham);
  WriteLn(f, F_Params.ShamKeyNo);

  WriteLn(f, F_Params.Mokhlafat);
  WriteLn(f, F_Params.SobhInSham);
  WriteLn(f, F_Params.Kasr);
  WriteLn(f, F_Params.OffOutTime);

  WriteLn(f, F_Params.FirstFoodPrcPerson);
  WriteLn(f, F_Params.SecondFoodPrcPerson);
  WriteLn(f, F_Params.FirstFoodPrcGuest);
  WriteLn(f, F_Params.SecondFoodPrcGuest);

  WriteLn(f, F_Params.ControlBase);
  WriteLn(f, F_Params.ClockOnLine);
  WriteLn(f, F_Params.ClockCycle);
//  WriteLn(f, F_Params.RestCycle);

  WriteLn(f, F_Params.PrintFish);
  WriteLn(f, F_Params.PrnType);
  WriteLn(f, F_Params.LineFeed);
  WriteLn(f, F_Params.AllFishPrc);

  WriteLn(f, F_Params.Mdm_Active);
  WriteLn(f, F_Params.Mdm_Port);
  WriteLn(f, F_Params.Mdm_Baud);
  WriteLn(f, F_Params.Mdm_IsTel);
  WriteLn(f, F_Params.Mdm_TelNum);

  WriteLn(f, F_Params.EndRep1);
  WriteLn(f, F_Params.EndRep2);
  WriteLn(f, F_Params.EndRep3);
  WriteLn(f, F_Params.EndRep4);

  WriteLn(f, F_Params.SobhaneMaxIn);
  WriteLn(f, F_Params.NaharMaxIn);
  WriteLn(f, F_Params.ShamMaxIn);

  WriteLn(f, F_Params.CollectFrom);   // 0: from Readers      1: from Clock2.31 sqlServer DataBase

  WriteLn(f, F_Params.ClkServerName);
  WriteLn(f, F_Params.Clkdatabasename);
  WriteLn(f, F_Params.ClkSqlUseName);
  WriteLn(f, F_Params.ClkSqlPassword);

  //WriteLn(f, F_Params.FodPrcChngable);
  WriteLn(f, F_Params.SobhFirstFish);
  WriteLn(f, F_Params.NaharFirstFish);
  WriteLn(f, F_Params.ShamFirstFish);

  WriteLn(f, F_Params.RestServerName);
  WriteLn(f, F_Params.RestSqlUseName);
  WriteLn(f, F_Params.RestSqlPassword);

  WriteLn(f, F_Params.Building);
  WriteLn(f, F_Params.RunReserve);
  WriteLn(f, F_Params.MustReserve);
  WriteLn(f, F_Params.ValidInAllBuilding);

  WriteLn(f, F_Params.Endfish1);
  WriteLn(f, ord(F_Params.Endfishactive1));
  WriteLn(f, F_Params.Endfish2);
  WriteLn(f, ord(F_Params.Endfishactive2));
  WriteLn(f, F_Params.Endfish3);
  WriteLn(f, ord(F_Params.Endfishactive3));
  WriteLn(f, F_Params.Endfish4);
  WriteLn(f, ord(F_Params.Endfishactive4));
  WriteLn(f, F_Params.Endfish5);
  WriteLn(f, ord(F_Params.Endfishactive5));
  WriteLn(f, CurrToStr(F_Params.minCredit));
  WriteLn(f, F_Params.CollectUser);
  WriteLn(f, F_Params.PrsImgsFld); //kaveh
  WriteLn(f, ord(F_Params.PrsImgsFldActive)); //kaveh

  WriteLn(f, ord(F_Params.AutoLoginActive)); //kaveh
  WriteLn(f, F_Params.AutoLoginUser); //kaveh
  WriteLn(f, F_Params.AutoLoginPass); //kaveh

  WriteLn(f, ord(F_Params.AutoFishLstPicsActive)); //kaveh
  WriteLn(f, F_Params.AutoFishLstPicsRdrCodeR); //kaveh
  WriteLn(f, F_Params.AutoFishLstPicsRdrCodeL); //kaveh

  Close(f);
end;


procedure LoadKeyPads(var Keys : KeyType);
var
  s : String;
  i : Byte;
  f : Text;
begin
  if FileExists(g_options.ProgramPath + 'KeyPad.Dta') then
  begin
    AssignFile(f, g_options.ProgramPath + 'KeyPad.Dta');
    Reset(f);
    i := 0;
    while not Eof(f) do
    begin
      ReadLn(f, s);
      Keys[i] := CodingPassWord(s);
      Inc(i);
    end;
    CloseFile(f);
  end;
end;

procedure SaveKeyPads(Keys : KeyType);
var
  i : Byte;
  f : Text;
begin
  AssignFile(f, g_options.ProgramPath + 'KeyPad.Dta');
  ReWrite(f);
  for i := 0 to 30 do
    WriteLn(f, CodingPassWord(Keys[i]));
  CloseFile(f);
end;


procedure OpenTestFile;
begin
  Assign(FP_Test, g_options.ProgramPath + 'Test.Txt');
  ReWrite(FP_Test);
end;

procedure CloseTestFile;
begin
 Close(FP_Test);
end;


(***********************************************************************
  To get status of Resturan Service
 ***********************************************************************)
function ServiceGetStatus(sMachine, aServiceName: string ): DWORD;
var
  h_manager,h_svc : SC_HANDLE;
  service_status : TServiceStatus;
  hStat : DWORD;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);

  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName), SERVICE_QUERY_STATUS);

    if h_svc > 0 then
    begin
      if(QueryServiceStatus(h_svc, service_status)) then
        hStat := service_status.dwCurrentState;

      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;

  Result := hStat;
end;

(***********************************************************************
  To Start Resturan Service
 ***********************************************************************)
function ServiceStart(aMachine, aServiceName : string ) : Boolean;
// aMachine is UNC path or local machine if left empty
var
  h_manager,h_svc: SC_HANDLE;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWORD;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), Nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName), SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,temp)) then
        if (QueryServiceStatus(h_svc, svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;

            Sleep(svc_status.dwWaitHint);

            if (not QueryServiceStatus(h_svc, svc_status)) then
              break;

            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus didn't increment dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;

(***********************************************************************
  To Stop Resturan Service
 ***********************************************************************)
function ServiceStop(aMachine,aServiceName : string ) : Boolean;
// aMachine is UNC path or local machine if left empty
var
  h_manager,h_svc : SC_HANDLE;
  svc_status : TServiceStatus;
  dwCheckPoint : DWORD;
begin
  h_manager:=OpenSCManager(PChar(aMachine), nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName), SERVICE_STOP or SERVICE_QUERY_STATUS);

    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc, svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);

            if(not QueryServiceStatus(h_svc, svc_status))then
            begin
              // couldn't check status
              break;
            end;

            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;

          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;

  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;
end.


