unit DateProc;

interface


function  IsNumber(num : String) : Boolean;

procedure SetTime(NewTime : String);
procedure SetDate(NewDate : String);

procedure ShToM(var Y, M, D : Integer);
function  M_DateStr(SHDate : String) : String;
function  M_Date(SHDate : String) : TDateTime;

procedure MToSh(var Y, M, D : Integer);
function  SH_DateStr(MDate : TDateTime) : String;

function  IsTrueDate(date_string : String) : Boolean;
function  IsTrueTime(time_string : String) : Boolean;
function  BeautifulDate(date_string : String) : String;
function  BeautifulTime(time_string : String) : String;
function  CurrentDate : String;
function  CurrentTime : String;
function  CurrentTimeWithSec : String;
function  IntToTime(I_T : Integer) : String;
function  CurrentTimes : String;
function  Differ(FromDate, FromTime, ToDate, ToTime : string) : LongInt;
function  DifferDate(FromDate, ToDate : String) : LongInt;
function  FormatTimes(Times : Integer) : String;

function  AddDate(date_string : String; n:Integer) : String;
procedure AddDateTime(FromDate, FromTime : String; Day, Hour : Integer; var ToDate, ToTime : String);


procedure InitialDelay;
procedure Delay(n:integer);

  function DateTimeToMSec(dateTime : String) : integer; //kaveh
  FUNCTION MSecToDateTime(TM : INTEGER) : TDateTime; //kaveh
  function Milady2Shamsi(MDate : String) : String; //kaveh
  function Shamsi2Milady(MDate : String) : String; //kaveh

var
  DelayLoop : Integer;

implementation

Uses
  SysUtils, funcs;

var
  A : array[1..15] of Byte = (10, 11, 9, 11, 10, 10, 9, 9, 9, 8, 9, 9, 10, 11, 9);
  B : array[1..15] of Byte = (20, 19, 20, 20, 21, 21, 22, 22, 22, 22, 21, 21, 20, 19, 20);

  ShamsiMonths : array[1..12] of Byte = (31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29);
  MiladyMonths : array[1..12] of Byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
const
  MILADY_LEAP_OFFSET = 0;
  SHAMSI_LEAP_OFFSET = 3;

  DATE_DELIMITER = '/';

  SHAMSI_MILADY_DiFFERENCE = 219150;



function IsNumber(num : String) : Boolean;
var i, l : Integer;
begin
  IsNumber := True;
  l := Length(num);
  for i := 1 to l do
    if not (num[i] in [#48..#57]) then
    begin
      IsNumber := False;
      Break;
    end;
end;

function InStr(input_str : String; substring : String; from : integer) : Integer;
var
  temp_str : string;
begin
  temp_str := input_str;
  Delete(temp_str, 1, from - 1);
  InStr := Pos(substring, temp_str) + from - 1;
end;


procedure SetDate(NewDate : String);
var
  c, y, m, d : Integer;
  c1, y1,m1, d1 : Byte;
begin
  y := StrToInt(Copy(NewDate, 1, 4));
  M := StrToInt(Copy(NewDate, 6, 2));
  d := StrToInt(Copy(NewDate, 9, 2));
  ShToM(y, m, d);
  c := y div 100;
  y := y mod 100;
  c1 := c div 10 * 16 + c mod 10;
  y1 := y div 10 * 16 + y mod 10;
  M1 := M div 10 * 16 + M mod 10;
  d1 := d div 10 * 16 + d mod 10;
  asm
    MOV AH, $05
    MOV CH, c1
    MOV CL, y1
    MOV DH, m1
    MOV DL, d1
    INT $1A
  end;
end;

procedure SetTime(NewTime : String);
var
  H, M, S : Byte;
  CLKH, CLKS : WORD;
begin
  S := 0;
  H := StrToInt(Copy(NewTime, 1, 2));
  M := StrToInt(Copy(NewTime, 4, 2));
  CLKH := H;
  CLKS := Round(18.2 * (M * 60 + Round(h * 0.4)));
  H := H div 10 * 16 + H mod 10;
  M := M div 10 * 16 + M mod 10;

  asm
    MOV AH, $03
    MOV CH, H
    MOV CL, M
    MOV DH, S
    MOV DL, 1
    INT $1A

    MOV AH, $01
    MOV CX, CLKH
    MOV DX, CLKS
    INT $1A;
  end;
end;


procedure ShToM(var Y, M, D : Integer);
begin
  if Y mod 4 = 3 then
    Dec(D);
  if Y mod 4 = 2 then
    A[15] := 10;
  M := M+3;
  if D > A[M] then
    D := D - A[M]
  else
  begin
    Dec(M);
    D := D + B[M];
  end;
  if M > 12 then
    M := M - 12
  else
    Dec(Y);

  if Y < 1000 then
    Y := (Y+22) mod 100
  else
    Y := Y+622;

  A[15] := 9;
end;

function M_DateStr(SHDate : String) : String;
var
  l, Y, M, D : Integer;
begin
  l := Pos('/', SHDate);
  Y := StrToInt(Copy(SHDate, 1, l-1));
  Delete(SHDate, 1, l);
  l := Pos('/', SHDate);
  M := StrToInt(Copy(SHDate, 1, l-1));
  Delete(SHDate, 1, l);
  D := StrToInt(SHDate);
  ShToM(Y, M, D);
  M_DateStr := IntToStr(Y) + '/' + IntToStr(M) + '/' + IntToStr(D);
end;

function M_Date(SHDate : String) : TDateTime;
var
  l, Y, M, D : Integer;
begin
  l := Pos('/', SHDate);
  Y := StrToInt(Copy(SHDate, 1, l-1));
  Delete(SHDate, 1, l);
  l := Pos('/', SHDate);
  M := StrToInt(Copy(SHDate, 1, l-1));
  Delete(SHDate, 1, l);
  D := StrToInt(SHDate);
  ShToM(Y, M, D);
  M_Date := EnCodeDate(Y, M, D);
end;

procedure MToSh(var Y, M, D : Integer);
begin
  if (Y mod 4 = 0) and (M > 2) or (Y mod 4 = 1) and (M <= 2)then
    Inc(D);

  if D > B[M]then
  begin
    D := D - B[M];
    Inc(M);
  end
  else
  begin
    D := D + A[M];
    if M = 3 then
      if Y mod 4 = 1 then
        Inc(D); (* ALSO 2001,2005, ... , 2001+K*4  *)
  end;
  M := M + 9;
  if M > 12 then
  begin
    M := M - 12;
    Inc(Y);
  end;

  if Y >= 1000 then
    Y := Y - 622
  else if Y >= 22 then
    Y := Y - 22
  else
    Y := Y + 78;
end;

function SH_DateStr(MDate : TDateTime) : String;
var
  WY, WM, WD : Word;
  Y, M, D : Integer;
begin
  DecodeDate(MDate, WY, WM, WD);
  Y := Integer(WY);
  M := Integer(WM);
  D := Integer(WD);
  MToSh(Y, M, D);
  SH_DateStr := IntToStr(Y) + '/' + IntToStr(M) + '/' + IntToStr(D);
end;

(***********************************************************************
  Beautiful Date
 ***********************************************************************)
function BeautifulDate(date_string : String) : String;
var
  l, pos1, pos2 : Integer;
  year_str, month_str, day_str : String;
  year_int, month_int, day_int : Integer;
  temp_string : String;
begin
  if date_string = ''
  then begin
    result:='';
    exit;
  end;
  pos1 := Pos('/', date_string);
  l := Length(date_string);
  if (pos1 = 0) and IsNumeric(date_string) and (l in[6, 8]) then
  begin
    if l = 6 then
    begin
      Insert('/', date_string, 5);
      Insert('/', date_string, 3);
    end
    else if l = 8 then
    begin
      Insert('/', date_string, 7);
      Insert('/', date_string, 5);
    end;
  end;
  pos1 := Pos('/', date_string);
  if pos1 <> 1 then
  begin
    temp_string := date_string;
    Delete(temp_string, 1, pos1);
    pos2 := Pos('/', temp_string) + pos1 + 1;

    if (pos2 <> pos1 + 1) And (pos2 <> 0) then
    begin
      year_str := Copy(date_string, 1, pos1 - 1);
      month_str := Copy(date_string, pos1 + 1, pos2 - pos1 - 2);
      day_str := Copy(date_string, pos2 , Length(date_string) - pos2 + 1);
      year_int := StrToInt(year_str);
      month_int := StrToInt(month_str);
      day_int := StrToInt(day_str);
      year_str := IntToStr(year_int);
      month_str := IntToStr(month_int);
      day_str := IntToStr(day_int);

      if (year_int <> 0) And (month_int <> 0) And (day_int <> 0) then
      begin
        if (year_int < 100) And (Length(year_str) < 3) then {if year part have 2 digit }
          year_str := '13' + year_str;                {then add 13 to start of year part }

        if (month_int < 10) And (Length(month_str) < 2) then { if month part have 1 digit }
          month_str := '0' + IntToStr(month_int);                       { then add 0 to start of month part }

        if (day_int < 10) And (Length(day_str) < 2) then   { if day part have 1 digit }
          day_str := '0' + IntToStr(day_int);                  {   then add 0 to start of day part }

      end { year_int <> 0 And month_int <> 0 And day_int <> 0 then ... }

    end; { pos2 <> pos1 }

    BeautifulDate := year_str + '/' + month_str + '/' + day_str;
  end { pos1 <> 1 }
  else
    BeautifulDate := date_string;

end; { function }

(***********************************************************************
  Beautiful Time
 ***********************************************************************)
function BeautifulTime(time_string : String) : String;
var
  p : Integer;
  ret_str : String;
begin
  p := Pos(':', time_string);
  if p > 0 then
  begin
    ret_str := Format('%2s', [Copy(time_string, 1, p-1)]);
    ret_str := ret_str + ':' + Format('%02s', [Copy(time_string, p+1, 2)]);
    for p := 1 to 5 do if ret_str[p] = ' ' then ret_str[p] := '0';
  end
  else
    ret_str := '';

  BeautifulTime := ret_str;
end;


(***********************************************************************
  Is True Date
 ***********************************************************************)
function IsTrueDate(date_string : String) : Boolean;
var
   p1, p2  : Integer;
   y_s, m_s, d_s, s : String;
   y, m, d : Integer;
begin
  if Length(date_string) < 6 then
    IsTrueDate := False
  else
  begin
    p1 := Pos('/', date_string);
    s := date_string;
    Delete(s, 1, p1);
    p2 := Pos('/', s) + p1;
    if (p1 = 0) or not (p1 in [3, 5]) or
       (p2 = 0) or not (p2 in [5..8]) then
      IsTrueDate := False
    else
    begin
      y_s := Copy(date_string, 1, p1 - 1);
      m_s := Copy(date_string, p1 + 1, p2 - p1 - 1);
      d_s := Copy(date_string, p2 + 1, Length(date_string) - p2);
      if not IsNumber(y_s) or not IsNumber(m_s) or not IsNumber(d_s) then
        IsTrueDate := False
      else
      begin
        y := StrToInt(y_s);
        m := StrToInt(m_s);
        d := StrToInt(d_s);
        if (y = 0) or not (m in [1..12]) or not (d in [1..31]) or
           ((m > 6) and (d > 30)) or
           ( (m = 12) and (d = 30) and
             (((y > 74) and (y mod 4 <> 3)) or ((y <= 74) and (y mod 4 <> 2))) ) then
          IsTrueDate := False
        else
          IsTrueDate := True;

      end;
    end;
  end;
end;

(***********************************************************************
  Is True Time
 ***********************************************************************)
function IsTrueTime(time_string : String) : Boolean;
var
  l, p : Integer;
  hs, ms : String;
begin
  l := Length(time_string);
  if (l < 3) or (l > 5) then
    IsTrueTime := False
  else
  begin
    p := Pos(':', time_string);
    if (p < 2) or (p > 3) then
      IsTrueTime := False
    else
    begin
      hs := Copy(time_string, 1, p-1);
      ms := Copy(time_string, p+1, l-p);
      if not IsNumber(hs) or not IsNumber(ms) or
         not(StrToInt(hs) in [0..23]) or not(StrToInt(ms) in [0..59]) then
        IsTrueTime := False
      else
        IsTrueTime := True;

    end;
  end;
end;


(***********************************************************************
  Milady leap
 ***********************************************************************)
function MiladyLeap(year : Word) : boolean;
begin
  if year div 4 = MILADY_LEAP_OFFSET then
    MiladyLeap := True
  else
    MiladyLeap := False;
end;




(***********************************************************************
  Current Date
 ***********************************************************************)
function CurrentDate : String;
begin
  CurrentDate := BeautifulDate(SH_DateStr(Date));
end;


(***********************************************************************
  Current Time
 ***********************************************************************)
function CurrentTime : String;
var
  TimeRet : String;
  h, m, s, ss : Word;
begin
  DecodeTime(Time, h, m, s, ss);
  TimeRet := IntToStr(h) + ':' + IntToStr(m);
  TimeRet := BeautifulTime(TimeRet);
  CurrentTime := TimeRet;
end;


//kaveh is
(***********************************************************************
  Current Time With Second
 ***********************************************************************)
function CurrentTimeWithSec : String;
var
  TimeRet : String;
  h, m, s, ss : Word;
begin
  DecodeTime(Time, h, m, s, ss);
  TimeRet := IntToStr(h) + ':' + IntToStr(m);
  TimeRet := BeautifulTime(TimeRet) + ':' + FixLeft(IntToStr(s),'0',2);
  CurrentTimeWithSec := TimeRet;
end;
//kaveh ie

(***********************************************************************
  convert time from integer format(minute) to xx:yy format
 ***********************************************************************)
function IntToTime(I_T : Integer) : String;
var
  h, m : Integer;
  s : String;
begin
  s := '';
  h := I_T div 60;
  m := I_T mod 60;

  if m < 0 then
  begin
    m := m + 60;
    h := h - 1;
  end;
  if h >= 24 then
  begin
    h := h - 24;
    s := '+';
  end;
  if h < 0 then
    h := -24 - h;
  s := s + IntToStr(h) + ':' + IntToStr(m);
  s := BeautifulTime(s);
  IntToTime := s;
end;

(***********************************************************************
  Current Time hh:mm:ss
 ***********************************************************************)
function CurrentTimes : String;
var
  h, M, s ,ms: Word;
  hh,mm,ss:string[2];
  st:string[8];
  i:byte;
begin
  Decodetime(time, h, m, s, ms);
  str(h:2,hh);
  str(m:2,mm);
  str(s:2,ss);
  st:=hh+':'+mm+':'+ss;
  for i:=1 to 8 do if st[i]=' ' then st[i]:='0';
  currenttimes:=st;
end;

function FormatTimes(Times : Integer) : String;
var s : String;
begin
  s := IntToStr(Times div 1440) + '_';
  Times := Times mod 1440;
  s := s + IntToStr(Times div 60) + '_' + IntToStr(Times mod 60);

  FormatTimes := s;
end;

function DifferTime(FromTime, ToTime : String) : Integer;
var
  h1,m1,h2,m2:integer;
begin
  if (FromTime = '') or (ToTime = '') then
    DifferTime := 0
  else
  begin
    h1 := StrToInt(Copy(FromTime, 1, 2));
    m1 := StrToInt(Copy(FromTime, 4, 2));
    h2 := StrToInt(Copy(ToTime, 1, 2));
    m2 := StrToInt(Copy(ToTime, 4, 2));
    DifferTime := (h2 - h1) * 60 + m2 - m1;
  end;
end;

function DifferDate(FromDate, ToDate : String) : LongInt;
var
  y1, y2, m, d : Integer;
  i, temp1, temp2, temp : LongInt;
begin
  if (FromDate = '') or (ToDate = '') then
    DifferDate := 0
  else
  begin
    y1 := StrToInt(Copy(FromDate, 1, 4));
    m := StrToInt(Copy(FromDate, 6, 2));
    d := StrToInt(Copy(FromDate, 9, 2));
    if m < 7 then
      temp1 := (m - 1) * 31 + d
    else
      temp1 := 186 + (m - 7) * 30 + d;

    y2 := StrToInt(Copy(ToDate, 1, 4));
    m := StrToInt(Copy(ToDate, 6, 2));
    d := StrToInt(Copy(ToDate, 9, 2));
    if m < 7 then
      temp2 := (m - 1) * 31 + d
    else
      temp2 := 186 + (m - 7) * 30 + d;

    temp := temp2 - temp1;
    for i := y1 to y2-1 do
      if i mod 4 = 3 then
        Inc(temp, 366)
      else
        Inc(temp, 365);

    DifferDate := Temp;
  end;
end;

function Differ(FromDate, FromTime, ToDate, ToTime : String) : LongInt;
begin
  if ToDate + ToTime < FromDate + FromTime then
    Differ := 0
  else
    Differ := DifferDate(FromDate, ToDate) * 1440+ DifferTime(FromTime, ToTime);
end;

function AddDate(date_string : String; n:Integer) : String;
var
  y, m, d : Integer;
  yst, mst, dst : string[4];
  i : Byte;
  maxdays:array[1..12] of byte;
begin
  maxdays[1]:=31; maxdays[2]:=31; maxdays[3]:=31;
  maxdays[4]:=31; maxdays[5]:=31; maxdays[6]:=31;
  maxdays[7]:=30; maxdays[8]:=30; maxdays[9]:=30;
  maxdays[10]:=30; maxdays[11]:=30; maxdays[12]:=29;

  y := StrToInt(Copy(date_string, 1, 4));
  m := StrToInt(Copy(date_string, 6, 2));
  d := StrToInt(Copy(date_string, 9, 2));
  if n >= 0 then
  begin
    Inc(d, n);
    if y mod 4 = 3 then
      MaxDays[12] := 30;

    while d > MaxDays[m] do
    begin
      Dec(d, MaxDays[m]);
      Inc(m);
      if m > 12 then
      begin
        m := 1;
        Inc(y);
        if y mod 4 = 3 then
          MaxDays[12] := 30
        else
          MaxDays[12] := 29;
      end;
    end;
  end
  else
  begin
    Inc(d, n);
    while d < 1 do
    begin
      Dec(m);
      if m < 1 then
      begin
        m := 12;
        Dec(y);
        if y mod 4 = 3 then
          MaxDays[12] := 30
        else
          MaxDays[12] := 29;
      end;
      Inc(d, MaxDays[m]);
    end;
  end;
  Str(y:4, yst);
  Str(m:2, mst);
  Str(d:2, dst);
  date_string := yst + '/' + mst + '/' + dst;
  for i := 1 to 10 do
    if date_string[i] = ' ' then
      date_string[i] := '0';
  AddDate := date_string;
end;

procedure AddDateTime(FromDate, FromTime : String; Day, Hour : Integer; var ToDate, ToTime : String);
var
   y,m,d,h:integer;
   yst,mst,dst,hst:string[4];
   i:byte;
   MaxDays:array[1..12] of byte;
begin
   MaxDays[1] := 31;
   MaxDays[2] := 31;
   MaxDays[3] := 31;
   MaxDays[4] := 31;
   MaxDays[5] := 31;
   MaxDays[6] := 31;
   MaxDays[7] := 30;
   MaxDays[8] := 30;
   MaxDays[9] := 30;
   MaxDays[10] := 30;
   MaxDays[11] := 30;
   MaxDays[12] := 29;

   y:=StrToInt(Copy(Fromdate,1,4));
   m:=StrToInt(Copy(Fromdate,6,2));
   d:=StrToInt(Copy(Fromdate,9,2));
   h:=StrToInt(Copy(Fromtime,1,2));
   inc(h,hour);
   inc(d, h div 24);
   h:=h mod 24;
   str(h:2,hst);
   if hst[1]=' ' then hst[1]:='0';
   totime:=hst+Copy(fromtime,3,5);
   inc(d,day);
   if y mod 4 = 3 then MaxDays[12]:=30;
   while d>MaxDays[m] do
   begin
      dec(d,MaxDays[m]);
      inc(m);
      if m>12
      then begin
           m:=1;
           inc(y);
           if y mod 4 = 3
           then MaxDays[12]:=30
           else MaxDays[12]:=29;
      end;
   end;
   str(y:4,yst);
   str(m:2,mst);
   str(d:2,dst);
   todate:=yst+'/'+mst+'/'+dst;
   for i:=1 to 10 do if todate[i]=' ' then todate[i]:='0';
end;


{********************************************************
   Delay procedures
********************************************************}
procedure delay0;
var
  i : byte;
  x : Extended;
begin
   for i := 1 to 4 do x := Sin(5.3);
end;

procedure delay1;
var
   i:integer;
   h,m,s,ss:word;
begin
   for i:=1 to DelayLoop do
   begin
      delay0;
      DecodeTime(Time, h,  m,s, ss);
   end;
end;

procedure Delay(n:integer);
var
   i:integer;
begin
   for i:=1 to n do delay1;
end;

procedure InitialDelay;
var
   num,t:longint;
   h,m,s,ss,lastss:word;
begin
   DecodeTime(Time, h,  m,s, lastss);
   repeat
       DecodeTime(Time, h,  m,s, ss);
   until ss<>lastss;
   t:=0;
   num:=0;
   DecodeTime(Time, h,  m,s, lastss);
   repeat
       delay0;
       inc(num);
       DecodeTime(Time, h,  m,s, ss);
       if ss>=lastss
       then inc(t,ss-lastss)
       else inc(t,ss+1000-lastss);
       lastss:=ss;
   until t>=1000;
   DelayLoop:=round(num/t);
end;


//kaveh is
function DateTimeToMSec(dateTime : String) : integer;
var
  CurrDate , CurrTime , since : TDateTime;
begin
  result := 0;
  if dateTime = '' then exit;

  since := EncodeDate(1970, 01, 01);
  currDate := EncodeDate(StrToIntDef(copy(datetime,7,4),0), StrToIntDef(copy(datetime,1,2),0),StrToIntDef(copy(datetime,4,2),0));
  currTime := EncodeTime(StrToIntDef(copy(datetime,12,2),0), StrToIntDef(copy(datetime,15,2),0),StrToIntDef(copy(datetime,18,2),0),0);
  result := Trunc((currDate+currTime- since) *60*60*24);
//  if TryStrToDateTime(dateTime,curr) then
//    if TryStrToDateTime('01/01/1970 00:00:00',since) then
//      result := trunc((curr-since)*60*60*24);
end;
//kaveh ie

//kaveh is
FUNCTION MSecToDateTime(TM : INTEGER) : TDateTime;
begin
  result := EncodeDate(1970,1,1);
  result := Result + tm /(60*60*24);
end;
//kaveh ie

//kaveh is
function Milady2Shamsi(MDate : String) : String;
var
  p : Byte;
  y, m, d : Integer;
  s : String;
begin
  s := '';
  y := 0;
  m := 0;
  d := 0;
  if MDate <> '' then
  begin
    p := pos('/', MDate);
    if p > 0 then
    begin
      y := StrToInt(Copy(MDate, 1, p-1));
      Delete(MDate, 1, p);
    end;

    p := pos('/', MDate);
    if p > 0 then
    begin
      m := StrToInt(Copy(MDate, 1, p-1));
      Delete(MDate, 1, p);
    end;

    if MDate <> '' then
      d := StrToInt(MDate);
  end;
  MToSh(y, m, d);
  s := BeautifulDate(IntToStr(y) + '/' + IntToStr(m) + '/' + IntToStr(d));
  Milady2Shamsi := s;
end;
//kaveh ie

//kaveh is
function Shamsi2Milady(MDate : String) : String;
var
  p : Byte;
  y, m, d : Integer;
  s : String;
begin
  s := '';
  y := 0;
  m := 0;
  d := 0;
  if MDate <> '' then
  begin
    p := pos('/', MDate);
    if p > 0 then
    begin
      y := StrToInt(Copy(MDate, 1, p-1));
      Delete(MDate, 1, p);
    end;

    p := pos('/', MDate);
    if p > 0 then
    begin
      m := StrToInt(Copy(MDate, 1, p-1));
      Delete(MDate, 1, p);
    end;

    if MDate <> '' then
      d := StrToInt(MDate);
  end;
  ShToM(y, m, d);
//  s := BeautifulDateM(IntToStr(y) + '/' + IntToStr(m) + '/' + IntToStr(d));
  s := FixLeft(IntToStr(m),'0',2) +'/' + FixLeft(IntToStr(d),'0',2) + '/' + FixLeft(IntToStr(y),'0',4);
  Shamsi2Milady := s;
end;
//kaveh ie

end.
