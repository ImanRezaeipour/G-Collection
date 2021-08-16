unit Globals;
{$I features}
interface

uses
  Forms, SysUtils, Controls, StdCtrls,runCmnds;

var
{$ifdef POSBase}
  AppVersion:string  = '6.1';
{$Endif POSBase}
{$ifdef PCBase}
  AppVersion:string = '6.2';
{$endif PCBase}

const
  softwarecode  = 6;

var
  maxusers:byte = 1;
  isscript : boolean;
  logocode : string[4];
  islogo : Boolean = false;
  
const
  MNU_BASE     = 0;
  MNU_RELATION = 1;
  MNU_TRANSFER = 2;
  MNU_SPECIAL  = 3;
  MNU_REPORT   = 4;
  MNU_TOOLS    = 5;

  MB_FALSE     = 0;
  MB_TRUE      = 1;

  MB_NEW       = 1;
  MB_EDIT      = 2;
  MB_DELETE    = 4;
  MB_VIEW      = 8;

  MB_READER    = 1;
  MB_KEYBOARD  = 2;

  MB_BACKUP    = 1;
  MB_RESTORE   = 2;

  MB_IN        = 1;
  MB_OUT       = 2;
  MB_INOUT     = 3;

  MB_NORMAL    = 1;
  MB_PERSONS   = 2;
  MB_LOST      = 3;
  MB_COCAR     = 4;

  RDR_TEST      = 1;
  RDR_RESTART   = 2;
  RDR_VER       = 3;
  RDR_DATETIME  = 4;
  RDR_LIMITTIME = 5;
  RDR_CARDMSG   = 6;
  RDR_DOORS     = 7;
  RDR_COLLECT   = 8;
  RDR_RECOVERY  = 9;
  RDR_VIEWREC   = 10;
  RDR_INITIAL   = 11;
  RDR_MSG       = 12;
  RDR_Authority = 13;
  RDR_FingerPrg = 14;
  

  CNST_MAX_READER = 255;

  StName : array[MB_NORMAL..MB_LOST] of string =
           ('عادي', 'پرسنل', 'مفقود');

  NoCarTypes = 8;         
  StCarTypes : array[1..NoCarTypes] of string =
           ('سواری', 'وانت', 'کامیونت', 'موتور', 'مینی بوس', 'اتوبوس', 'متفرقه اول', 'متفرقه دوم');


  MB_TAKHFIF   = 1;
  MB_MOTAVARI  = 2;
  MB_NOTEXIT   = 4;
  MB_NOTEXIST  = 8;
  MB_GHOLNAMEH = 16;
  MB_KARSHENASI= 32;
  MB_CUSTOMS   = 128;

  MB_DOWN      = 0;
  MB_MID       = 1;
  MB_UP        = 2;

  MB_ALLPRINT  = 1;
  MB_PRCPRINT  = 2;
  MB_NOPRINT   = 3;

  RDR_CLOCK_Z84 = 1;
  RDR_CLOCK_Z80 = 2;
  RDR_PROXI     = 3;


  MONTH_PATH   = 'Month';

  ADMIN_NAME   = 'ADMIN';
  PASS         = 'DPSoftWare';

  CNST_TRUE = 1;
  CNST_FALSE = 0;



Type TOptions = Record
  ProgramPath  : String;
  DataBasePath : String;
  DB_MonthPath : String;
  CoName       : String;
  Shobeh       : String;
  WinType      : Byte;
  UserName     : String;
  AcesPrint    : Boolean;
  DefaultType  : Byte;
  ArchiveDate  : Byte;
  OutPrint     : Byte;
  OutPutLines  : array[1..5] of string;
  MaxOffReader : Integer;
  RdrOff_Rpt   : Byte;
  Department   : Integer; //kaveh
  ActiveRdrCode: Byte;
end;

type TParams = Record
//kaveh is
{  param_name    : string[50];

  Part1         : String[15];
  Part2         : String[15];
  Part3         : String[15];
  Part4         : String[15];

  EndRep01      : String[50];
  EndRep02      : String[50];
  EndRep03      : String[50];
  EndRep04      : String[50];
  EndRep05      : String[50];
  IsWin2000     : integer;
  TimeOut2000   : Integer;
  FastCollect   : integer; }

  ServerName    : string;
  sqlUseName    : string;
  sqlPassword   : string;
  DataBaseName  : string;

{  fldRezerv1    : String[15];
  fldRezerv2    : String[15];
  fldRezerv3    : String[15];
  fldRezerv4    : String[15];
  fldRezerv5    : String[15];
  fldRezerv6    : String[15];
  fldRezerv7    : String[15];
  fldRezerv8    : String[15];

  RptTitleFont  : String[30];
  RptTitleFntSize : Integer;
  RptFont       : String[30];
  RptFntSize    : Integer;}
//kaveh ie
end;

Type TNerkhType = Record
  Voroodieh : currency;
  Priods : array[1..4] of record
    MaxMin : Integer;
    FixMin  : Integer;
    Mablagh : Currency;
    IsFirst : Boolean;
    Rounding: Byte;
  end;
  dailyprice:currency
end;

Type TCars = Record
  Car_Name : String[15];
  Car_Type : Byte;
end;

Type TCarType = Record
  Type_Name  : String[15];
  Type_Code  : Byte;
  Type_Nerkh : TNerkhType;
end;


//Type TReaders = record
//  R_Code        : Integer;
//  R_Name        : String[20];
//  R_Active      : Boolean;
//  R_Kind        : Byte;
//  R_Port        : Byte;
//  R_BaudNo      : Byte;
//  R_IsReader    : Boolean;
//  R_DisplayCode : Integer;
//  R_IsCom       : Boolean;
//  R_IP          : string;
//  R_TCP         : Boolean;
//
//  RdrRelation   : Byte;
//  BuffEmpty     : Byte;
//  MaxTimeOff    : Integer;
//end;

Type ReaderLastRec = record
   RdrCodeName : String[25];
   OP          : String[20];
   CardNo      : String[8];
   CarTime     : String[8];
   ParkCost    : String[15];
   CarNumber   : String[6];
   ComTime     : String[8];
   ComStat     : String[7];
end;

Type TMachines = Record
  M_BarCode    : String;
  M_rdrCode    : Byte; //kaveh
  M_Status     : Integer; //kaveh
  M_PlaqueType : Byte; //kaveh
  M_PlaqueAppliance : Byte; //kaveh
  M_CitySerial : Integer; //kaveh
  M_UserName   : String; //kaveh
  M_IUserName  : String; //kaveh
  M_CarName    : String;
  M_Number     : String;
  M_CityName   : String;
  M_Serial     : String;
  M_Color      : String;
  M_IDate      : String;
  M_ITime      : String;
  M_ODate      : String;
  M_OTime      : String;
  M_Kind       : Byte;
  M_IDoor      : Byte;
  M_ODoor      : Byte;
  M_IPerson    : String;
  M_OPerson    : String;
  M_OperatorCode : String; //kaveh
  M_Price      : Currency;
  M_Payable    : Currency;
  M_Slake      : Currency;
  M_IsPark     : Boolean;
  M_ExitValid  : Boolean;
  N_Describe   : String;
  N_Madarek    : String; //مدارک ارائه شده برای خروج بدون کارت

  Co_Driver    : String;
  Co_OAmper    : LongInt;
  Co_IAmper    : LongInt;
  Co_Target    : String;
  Co_Mojavez   : String;
  Co_Describe  : String;
  Co_ODepart   : Integer;
  Co_IDepart   : Integer;

  Remainder    : Currency;
  Percent      : Integer;
  Takhfif      : Currency;
  M_KarShenasi : Boolean;
  M_Gholnameh  : Boolean;
  
  M_Driver     : string; //kaveh
  M_WorkDepart : Integer; //kaveh
  M_Visited    : string; //kaveh
  M_EntranceDepart : Integer; //kaveh
  M_MemberCode : string;

{$ifdef TarehBar}
  M_CargoKind  : Byte; //kaveh
  M_CargoWeight: Integer; //kaveh
  M_Salon      : Smallint; //kaveh
  M_Loge       : Smallint; //kaveh
{$endif TarehBar}

end;
type TPerson = Record
  P_Proxi       : String[15];
  P_BarCode     : String[8];
  P_Name        : String[15];
  P_Family      : String[25];
  P_Picture     : String;
  P_MainPart    : Integer;
  P_DetailPart  : Integer;
  P_JobCode     : Integer;
  P_CoPosts     : Integer;
  P_JobDate     : String[10];
  P_endJobDate  : String[10];
  P_ShiftGroup  : Integer;
  P_RuleGroup   : Integer;
end;

var
  g_Options     : TOptions;
  F_Params      : TParams;
  Cars          : array[1..255] of TCars;
  CarTypes      : array[1..20] of TCarType;
  machin        : TMachines;
  Readers       : array[1..20] of TReaders;
  TotalCars,
  TotalTypes,
  TotalActvRdr,
  TotalReader   : Byte;
  FreeCapacity  : array[1..20] of Integer;
  UnitCapacity  : array[1..20,1..20] of Integer;
  MaxCapacities : array[1..20] of Integer;
  LastRec       : array[1..20] of TMachines;
  ReadersLast   : array[1..20] of ReaderLastRec;
  AllParkNo,
  DayParkNo,
  DayAriveNo,
  DayExitNo  : Integer;

  FP_Test       : Text;

  CONNECTION_STR1:string = 'Provider=SQLOLEDB.1;'
                   +'Persist Security Info=True;';

procedure Mouse_Wait;
procedure Mouse_NoWait;
function  CodingPassWord(Pass : String) : String;
function  GetRandom : LongInt;
function  Coma(txt : String; ch : Char = ',') : String;

function  Str_PBCD(ST : String; l : Byte) : String;
function  PBCD_Str(ST : String; l : Byte) : String;
function  BCDToInt(n : Byte) : Byte;
function  IntToBCD(n : Byte) : Byte;
function  BCDToStr(ch : Char) : String;
function  StrToBCD(ST : String; from : Byte) : Char;
function  BarCode4(BarCode : String) : String;
function  BarCode8(BarCode : String) : String;
function  HexToChar(hx : Byte) : Char;
function  ByteToHex(i : Byte) : String;

function  FixLen(ST : String; ch : Char; Len : Byte) : String;
function  FixLeft(ST : String; ch : Char; Len : Byte) : String;
function  StrRev(txt : String) : String;
function  NumReverse(ST : String) : String;
function  DelLeftZero(txt : String) : String;

function  GetSerialNo(drv : Char) : String;

procedure Rev_CarNum(var s : String);
function  SrchNearst(var Srch_Str : String; var cmb : TComboBox; var Key : Char) : Boolean;

function  Key_CarNumber(StNum : TCaption; Key : Char; Sel : Integer) : String;

function  textToWin(s : String) : String;

procedure LoadIniFile;
procedure SaveIniFile;
procedure OpenTestFile;
procedure CloseTestFile;

procedure LoadDBIniFile;overload; //kaveh
procedure LoadDBIniFile(AppPath: string);overload;
procedure SaveDBIniFile; //kaveh

function GetConnectionString : string; //by MKN


implementation

uses
  Code_Sys, MSGs;

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
function Coma(txt : String; ch : Char) : String;
var t : String;
begin
  t := '';
  while Length(txt) > 3 do
  begin
    t := ch + Copy(txt, Length(txt)-2, 3) + t;
    Delete(txt, Length(txt)-2, 3);
  end;
  Coma := txt + t;
end;

(***********************************************************************
  Change a String to Pack_BCD
 ***********************************************************************)
function Str_PBCD(ST : String; l : Byte) : String;
var
  i, k : Byte;
  S : String;
begin
  S := '';
  if l > 0 then ST := FixLeft(ST, '0', l);
  if Odd(Length(ST)) then ST := '0' + ST;
  l := Length(ST);
  for i := 1 to l do
    if ST[i] in ['0'..'9', 'a'..'f', 'A'..'F'] then
    begin
      if ST[i] in ['a'..'f'] then ST[i] := Chr(Ord(ST[i])-32);
    end
    else
    begin
      Str_PBCD := '';
      Exit;
    end;

  i := 1;
  while i <= l do
  begin
    if ST[i] in ['0'..'9'] then
      k := (Ord(ST[i])-48)*16
    else
      k := (Ord(ST[i])-55)*16;

    if ST[i+1] in ['0'..'9'] then
      k := k + Ord(ST[i+1])-48
    else
      k := k + Ord(ST[i+1])-55;

    S := S + Chr(k);
    Inc(i, 2);
  end;
  Str_PBCD := S;
end;

(***********************************************************************
  Change  Pack_BCD to String
 ***********************************************************************)
function PBCD_Str(ST : String; l : Byte) : String;
var
  i : Byte;
  S : String;
begin
  S := '';
  for i := 1 to Length(ST) do
    S := S + HexToChar(Ord(ST[i]) div 16) + HexToChar(Ord(ST[i]) mod 16);
  if l > 0 then S := FixLeft(S, '0', l);
  PBCD_Str := S;
end;

(***********************************************************************
  Change a BCD Number to Decimal
 ***********************************************************************)
function BCDToInt(n : Byte) : Byte;
begin
  BCDToInt := n - (n div 16 * 6);
end;

(***********************************************************************
  Change a Decimal number to BCD
 ***********************************************************************)
function IntToBCD(n : Byte) : Byte;
begin
  IntToBCD := n div 10 * 6 + n;
end;

(***********************************************************************
  Change a Character to BCD
 ***********************************************************************)
function BCDToStr(ch : Char) : String;
begin
  BCDToStr := Chr(Ord(ch) div 16 + 48) + Chr(Ord(ch) mod 16 + 48);
end;

(***********************************************************************
  Change a BCD to a Character
 ***********************************************************************)
function StrToBCD(ST : String; from : Byte) : Char;
begin
  StrToBCD := Chr((Ord(ST[from])-48)*16 + Ord(ST[from+1])-48);
end;

(***********************************************************************
  Change a Decimal number to BCD
 ***********************************************************************)
function BarCode4(BarCode : String) : String;
begin
  BarCode4 := Str_PBCD(BarCode, 8);
end;

function BarCode8(BarCode : String) : String;
begin
  BarCode8 := DelLeftZero(PBCD_Str(BarCode, 0));
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
  Fix Barcode to 8 Byte
 ***********************************************************************)
function FixLeft(ST : String; ch : Char; Len : Byte) : String;
begin
  if Length(ST) > Len then
    ST := Copy(ST, 1, Len)
  else
    while Length(ST) < Len do ST := ch + ST;

  FixLeft := ST;
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
  for i := 1 to Length(txt) do
    if txt[i] <> '0' then
      Break;
  for i := i to Length(txt) do
    S := S + txt[i];
  DelLeftZero := S;
end;



(***********************************************************************
  Get Drive Serial Number
 ***********************************************************************)
function GetSerialNo(drv : Char) : String;
begin
  GetSerialNo := 'Test';
end;


(***********************************************************************
  Search a string into a combo box
 ***********************************************************************)
function SrchNearst(var Srch_Str : String; var cmb : TComboBox; var Key : Char) : Boolean;
var
  i : Integer;
  fnd : Boolean;
begin
  fnd := False;
  if Key = #8 then
    Delete(Srch_Str, Length(Srch_Str), 1)
  else if Key = #27 then
    Srch_Str := ''
  else if Key <> #13 then
    Srch_Str := Srch_Str + Key;

  Key := #0;

  for i := 0 to cmb.Items.Count do
  begin
    if Pos(Srch_Str, Copy(cmb.Items.Strings[i], 1, Length(Srch_Str))) <> 0 then
    begin
      cmb.ItemIndex := i;
      fnd := True;
      Break;
    end;
  end;

  if not fnd then
    cmb.Text := Srch_Str;

  SrchNearst := fnd;
end;

(***********************************************************************
  Revert Car number string
 ***********************************************************************)
procedure Rev_CarNum(var s : String);
var
  l, i : Integer;
  st : String;
begin
  l := Length(s);
  if (l > 2) then
  begin
    for i := 1 to l do
      if ((g_options.WinType = WIN_SINA_SYS) and
         (s[i] in ['ب', 'ج', 'د', 'س', 'ص', 'ط', 'ع',
                   'ق', 'ل', 'م', 'ن', 'ه'])) or
{         ((g_options.WinType = WIN_MICROSOFT_SYS) and
          (s[i] in ['ب', 'ث', 'ح', 'ر', 'ژ', 'ش', 'ض',
                  'ع', 'ق', 'گ', 'ل', 'م'])) then  }
         ((g_options.WinType = WIN_MICROSOFT_SYS) and
          (s[i] in ['ا', 'ب', 'ت', 'ج', 'د', 'س', 'ص',
                    'ط', 'ع', 'ق', 'ل', 'م', 'ن', 'و', 'ه', 'ي'])) then
      begin
        st := Copy(s, i + 1, l-i);
        st := st + s[i];
        st := st + Copy(s, 1, i - 1);
        s := st;
        Break;
      end;
  end;
end;

(***********************************************************************
  proccess car number
 ***********************************************************************)
function Key_CarNumber(StNum : TCaption; Key : Char; Sel : Integer) : String;
var
  s : String;
  l : Integer;
begin
  l := Length(StNum);
  if sel = l then
    s := ''
  else
    s := StNum;

  Rev_CarNum(s);
  if (l > 0) and (Key = #8) then
    Delete(s, l, 1)
  else if l > 5 then

  else if (Key in [#49..#57]) or
          ((l = 2) and (g_options.WinType = WIN_SINA_SYS) and
           (Key in ['ب', 'ج', 'د', 'س', 'ص', 'ط', 'ع',
                    'ق', 'ل', 'م', 'ن', 'ه'])) or
          ((l = 2) and (g_options.WinType = WIN_MICROSOFT_SYS) and
{           (Key in ['ب', 'ث', 'ح', 'ر', 'ژ', 'ش', 'ض',
                    'ع', 'ق', 'گ', 'ل', 'م'])) then }
           (Key in ['ا', 'ب', 'ت', 'ج', 'د', 'س', 'ص',
                    'ط', 'ع', 'ق', 'ل', 'م', 'ن', 'و', 'ه', 'ي'])) then


    s := s + Key;

  Rev_CarNum(s);
  Key_CarNumber := s;
end;

function TextToWin(s : String) : String;
begin
    TextToWin:= ChangeFromWin(s, g_options.WinType, WIN_SINA_SYS);
end;

procedure LoadIniFile;
var
  f : Text;
  i : Byte;
begin
  if FileExists(g_options.ProgramPath + 'Parking.Ini') then
  begin
    Assign(f, g_options.ProgramPath + 'Parking.Ini');
    Reset(f);
    Readln(f, g_options.DefaultType);
    Readln(f, g_options.ArchiveDate);
    Readln(f, g_options.OutPrint);
    for i := 1 to 5 do
      Readln(f, g_options.OutPutLines[i]);
    Readln(f, g_options.MaxOffReader);
    Readln(f, g_options.RdrOff_Rpt);
    Close(f);
  end;
end;

procedure SaveIniFile;
var
  f : Text;
  i : Byte;
begin
  Assign(f, g_options.ProgramPath + 'Parking.Ini');
  ReWrite(f);
  Writeln(f, g_options.DefaultType);
  Writeln(f, g_options.ArchiveDate);
  Writeln(f, g_options.OutPrint);
  for i := 1 to 5 do
    Writeln(f, g_options.OutPutLines[i]);
  Writeln(f, g_options.MaxOffReader);
  Writeln(f, g_options.RdrOff_Rpt);
  Close(f);
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

function CodingPass(st:string):string;
var
   i,j: byte;
   st1:string;
begin
   st1:='';
   for i:=1 to length(st) do
   begin
       j:=ord(st[i]);
       j:=j xor 118;
       st1:=st1+chr(j mod 16 +200)+chr(j div 16 +200)
   end;
   codingpass:=st1;
end;

function DeCodingPass(st:string):string;
var
   i,j,k: byte;
   st1:string;
begin
   st1:='';
   if odd(length(st)) then st:=st+#200;
   for i:=1 to length(st) div 2 do
   begin
       j:=ord(st[i+i-1])-200;
       k:=ord(st[i+i])-200;
       st1:=st1+chr((j + k*16) xor 118);
   end;
   decodingpass:=st1;
end;

procedure SaveDBIniFile;
var //kaveh is
   f : Text;
begin
  Assign(f, g_options.ProgramPath + 'ParkingDB.Ini');
  ReWrite(f);
  writeln(f, 'parking_6.0');
  WriteLn(f, 'ServerName=',F_Params.ServerName);
  WriteLn(f, 'sqlUseName=',F_Params.sqlUseName);
  WriteLn(f, 'sqlPassword=',CodingPass(F_Params.sqlPassword));
  WriteLn(f, 'DataBaseName=',F_Params.DataBaseName);
  Close(f);
//kaveh ie
end;

procedure LoadDBIniFile;
var //kaveh is
   f : Text;
   temp: integer;
   st:string[30];
function readtitle:string;
var
   st:string;
   ch:char;
   endwork:boolean;
begin
   endwork:=false;
   st:='';
   repeat
      read(f,ch);
      if eof(f) or eoln(f) or (ch='=')
      then endwork:=true
      else st:=st+ch;
   until endwork;
   result:=st;
end;
begin
  if FileExists(g_options.ProgramPath + 'ParkingDB.Ini') then
  begin
    Assign(f, g_options.ProgramPath + 'ParkingDB.Ini');
    Reset(f);
    readln(f,st);
    if st<>'parking_6.0'
    then begin
        close(f);
        ErrorMessage('پارامترهاي سيستم را مجددا تنظيم نماييد.');
        exit;
    end;
    repeat
      st:=readtitle;
      if      st = 'ServerName' then readln(f,F_Params.ServerName)
      else if st = 'sqlUseName' then readln(f,F_Params.sqlUseName)
      else if st = 'sqlPassword'
      then begin
           readln(f,F_Params.sqlPassword);
           F_Params.sqlPassword:=DeCodingPass(F_Params.sqlPassword);
      end
      else if st = 'DataBaseName'
      then begin
           readln(f,F_Params.DataBaseName);
      end
      else readln(F);
    until eof(f);
    Close(f);
  end;
//kaveh ie
end;

procedure LoadDBIniFile(AppPath: string);
var //haveh is
   f : Text;
   temp: integer;
   st:string[30];
function readtitle:string;
var
   st:string;
   ch:char;
   endwork:boolean;
begin
   endwork:=false;
   st:='';
   repeat
      read(f,ch);
      if eof(f) or eoln(f) or (ch='=')
      then endwork:=true
      else st:=st+ch;
   until endwork;
   result:=st;
end;
begin
  if FileExists(AppPath + 'ParkingDB.Ini') then
  begin
    Assign(f, AppPath + 'ParkingDB.Ini');
    Reset(f);
    readln(f,st);
    if st<>'parking_6.0'
    then begin
        close(f);
        ErrorMessage('پارامترهاي سيستم را مجددا تنظيم نماييد.');
        exit;
    end;
    repeat
      st:=readtitle;
      if      st = 'ServerName' then readln(f,F_Params.ServerName)
      else if st = 'sqlUseName' then readln(f,F_Params.sqlUseName)
      else if st = 'sqlPassword'
      then begin
           readln(f,F_Params.sqlPassword);
           F_Params.sqlPassword:=DeCodingPass(F_Params.sqlPassword);
      end
      else if st = 'DataBaseName'
      then begin
           readln(f,F_Params.DataBaseName);
      end
      else readln(F);
    until eof(f);
    Close(f);
  end;
//kaveh ie
end;

function GetConnectionString : string;
begin //kaveh is
//  {$ifdef Network}
  result := CONNECTION_STR1 +
            'Initial Catalog=' + F_Params.DataBaseName +
            ';Data Source=' + F_Params.ServerName +
            ';User ID=' + F_Params.sqlUseName +
            ';Password=' + F_Params.sqlPassword;
//  {$else}
//    {$ifdef ZK_Software}
//    result := CONNECTION_STR1 + 'Data Source ='+g_options.DataBasePath+'att2000.mdb;'{+F_Params.DataBaseName+'.mdb;'};
//    {$else}
//    result := CONNECTION_STR1 + 'Data Source ='+g_options.DataBasePath+'Parking.mdb;'{+F_Params.DataBaseName+'.mdb;'};
//    {$endif}
//  {$endif}
//kaveh is
end;

end.


