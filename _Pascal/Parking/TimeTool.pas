unit TimeTool;

interface

uses
  SysUtils, DateProc, Forms;

type
   hol_type =set of 0..31;
var
   MAHWEEK:ARRAY[1..12] OF BYTE;
   MAHROOZ:ARRAY[1..12] OF BYTE;
   hollidays:array[1..12] of hol_type;
const
  MAHNAME:ARRAY[1..12] OF STRING[9] =

         ('›—Ê—œÌ‰','«—œÌ»Â‘ ','Œ—œ«œ',' Ì—','„—œ«œ','‘Â—ÌÊ—'
         ,'„Â—','¬»«‰','¬–—','œÌ','»Â„‰','«”›‰œ');
  GHAMARNAME:ARRAY[1..12] OF STRING[12] =
         ('„Õ—„','’›—','—»Ì⁄ «·«Ê·','—»Ì⁄ «·À«‰Ì','Ã„«œÌ «·«Ê·','Ã„«œÌ «·À«‰Ì'
         ,'—Ã»','‘⁄»«‰','—„÷«‰','‘Ê«·','–Ìﬁ⁄œÂ','–ÌÕÃÂ');
  MONTHNAME:ARRAY[1..12] OF STRING[9]=
         ('January','february','March','April','May','June'
         ,'July','August','September','October','November','December');
  WEEKNAME:ARRAY[0..6] OF STRING[9]=
    ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
  HAFTEHNAME:ARRAY[0..6] OF STRING[8] =
          ('‘‰»Â','Ìﬂ‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','çÂ«—‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');

  ttlfilename:array[1..2] of string =('holliday.dta','nonrasmi.dta');

function  inttostr0(i:integer):string;
function  IntToTime(I_T : Integer) : String;
function  IntToTimes(I_T : Integer) : String;
function  IntToTime0(I_T : Integer) : String;
function  IntToTimehms(I_T : Integer) : String;
function  TimeToInt(S_T : String) : Integer;
function  Time_ToInt(S_T : String) : Integer;
function  TimesToInt(S_T : String) : Integer;

PROCEDURE SHTOGH(VAR Y:integer;var M,D:BYTE);
FUNCTION  latin_WEEK_DAY(Y:INTEGER;M,D:BYTE):BYTE;
FUNCTION  FARSI_WEEK_DAY(y:integer;m,d:byte):BYTE;
function  GetFirstDayWeek(shmsiDate : String) : String;
function  datetoweekname(date_string:string):string;
PROCEDURE MAKEMAHWEEK(Y:integer);
procedure makehollidays(kind:byte);
procedure loadhollidays(kind:byte;yr:integer);
function isholliday(kind:byte;yr,mn,dy:integer):boolean;
procedure TATIL_st(M,D,M1,D1,M2,D2,W:BYTE;var hst:string;var is_hol:boolean);
function  DateInRange(CDate,FromDate,ToDate:string):boolean;

implementation

TYPE
    MAHTATILTYPE = SET OF 1..31;
const
    SHTATIL:ARRAY[1..12] OF MAHTATILTYPE =(
         [1..4,12,13],
         [],
         [14,15],
         [],
         [],
         [],
         [31],
         [31],
         [31],
         [31],
         [22,31],
         [29,30,31]
         );
    GHTATIL:ARRAY[1..12] OF MAHTATILTYPE =(
         [9,10],
         [20,28,30],
         [17],
         [],
         [],
         [3],
         [13,27],
         [15],
         [21],
         [1,25],
         [],
         [10,18]
         );




function inttostr0(i:integer):string;
begin
   if i=0
   then inttostr0:=''
   else inttostr0:=inttostr(i);
end;


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

function IntToTimes(I_T : Integer) : String;
var
  h, m : Integer;
  hst,mst:string[4];
  s : String;
  isneg:boolean;
begin
  if I_T <0
  then begin
       I_T:=-I_T;
       isneg:=true;
  end
  else isneg:=false;
  s := '';
  h := I_T div 60;
  m := I_T mod 60;
  str(h,hst);
  str(m:2,mst);
  if mst[1]=' ' then mst[1]:='0';
  s:=hst+':'+mst;
  if isneg then s:='-'+s;
  IntToTimes := s;
end;

function IntToTime0(I_T : Integer) : String;
begin
   if I_T =0
   then IntToTime0:=''
   else IntToTime0:=inttotimes(I_T);
end;

function IntToTimehms(I_T : Integer) : String;
begin
   if I_T = 0 then
      IntToTimehms := ''
   else
   begin
      IntToTimehms := IntToStr(I_T div 3600) + ':' + IntToTimes(I_T mod 3600);
   end;
end;

function TimeToInt(S_T : String) : Integer;
var
  Sign, h, m : Integer;
begin
  if S_T <> '' then
  begin
    if S_T[1] = '+' then
    begin
      Sign := 24;
      Delete(S_T, 1, 1);
    end
    else if S_T[1] = '-' then
    begin
      Sign := -24;
      Delete(S_T, 1, 1);
    end
    else
      Sign := 0;

    h := StrToInt(Copy(S_T, 1, pos(':',s_t)-1));
    m := StrToInt(Copy(S_T, pos(':',s_t)+1,2));
    h := Sign + h;
    TimeToInt := h * 60 + m;
  end
  else
    TimeToInt := 0;
end;

function Time_ToInt(S_T : String) : Integer;
var
  h, m : Integer;
  neg : boolean;
begin
  if S_T <> '' then
  begin
    if S_T[1] = '+' then
    begin
      neg:=false;
      Delete(S_T, 1, 1);
    end
    else if S_T[1] = '-' then
    begin
      neg:=true;
      Delete(S_T, 1, 1);
    end
    else
      neg:=false;

    h := StrToInt(Copy(S_T, 1, pos(':',s_t)-1));
    m := StrToInt(Copy(S_T, pos(':',s_t)+1,2));
    if neg
    then Time_ToInt := -h * 60 - m
    else Time_ToInt := h * 60 + m;
  end
  else
    Time_ToInt := 0;
end;

function TimesToInt(S_T : String) : Integer;
var
  Sign, h, m, s, p : Integer;
begin
  if S_T <> '' then
  begin
    if S_T[1] = '+' then
    begin
      Sign := 24;
      Delete(S_T, 1, 1);
    end
    else if S_T[1] = '-' then
    begin
      Sign := -24;
      Delete(S_T, 1, 1);
    end
    else
      Sign := 0;

    p := pos(':', S_T);
    h := StrToInt(Copy(S_T, 1, p-1));
    Delete(S_T, 1, p);

    p := pos(':', S_T);
    m := StrToInt(Copy(S_T, 1, p-1));
    Delete(S_T, 1, p);

    s := StrToInt(S_T);

    h := Sign + h;
    TimesToInt := h * 3600 + m * 60 + s;
  end
  else
    TimesToInt := 0;
end;



PROCEDURE SHTOGH(VAR Y:integer;var M,D:BYTE);
VAR
   M1:INTEGER;
   Y2,Y1{,X},SAL:REAL;
BEGIN
   M:=PRED(M);
   D:=PRED(D);
   SAL:=Y;
   y:=y-1300;
   IF M<6 THEN Y1:=M ELSE Y1:=6;
   Y1:=Y1+M*30+D;
   {X:=(SAL-1220)*365.242347+Y1-110;}
   Y1:=Y1+(SAL+131)*365.242347+2.5013;
   Y1:=INT(Y1+0.5);
   Y2:=INT((Y1+8.5)/29.53059072)*29.53059072+8.5;
   Y1:=Y1
        + 0.44*SIN(Y2/65.576+1.17)           { + 0.44*SIN(X/65.576+0.38)}
        - 0.095*SIN((SAL-1216)*0.336);
   IF SAL>1336 THEN Y1:=Y1+(SAL-1336)*0.004
               ELSE Y1:=Y1+(SAL-1336)*0.001;  { + 0.001*(SAL-1336)}
   Y1:=Y1{-0.13*SIN(X/55.16); }            - 0.13*SIN((Y2-493574.0)/55.16);

   Y1:=Y1+0.5;
   Y1:=Y1-27426;
   M1:=TRUNC(Y1/29.53059072);
   D:=TRUNC(Y1-M1*29.53059072)+1;
   (*ROYAT:=Y1-M1*29.53059072;   { 0..29.53 } *)
   Y:=M1 DIV 12 -58;
   M:=SUCC(M1 MOD 12);
END;

FUNCTION LATIN_WEEK_DAY(Y:INTEGER;M,D:BYTE):BYTE;
{ RETURN WEEK OF DAY FOR ANY DATE BETWEEN 1901..2099 }
{ RETURN CODE IS 0..6   ( 0 = SUN ) }
CONST
   MD : ARRAY[1..12] OF BYTE =(0,3,3,6,1,4,6,2,5,0,3,5);
VAR
   X:INTEGER;
BEGIN
   X:=Y + Y DIV 4 + MD[M] + D + 5;
   IF (M<3) AND (Y MOD 4 = 0) THEN DEC(X);
   LATIN_WEEK_DAY:= (X MOD 7);
END;

FUNCTION FARSI_WEEK_DAY(y:integer;m,d:byte):BYTE;
{ RETURN WEEK OF DAY FOR ANY DATE BETWEEN 1372..1403 }
{ RETURN CODE IS 0..6   ( 0 = SHANBEH ) }
CONST
   MD : ARRAY[1..12] OF BYTE =(0,3,6,2,5,1,4,6,1,3,5,0);
VAR
   X:INTEGER;
BEGIN
   X:=Y + Y DIV 4 + MD[M] + D;
   FARSI_WEEK_DAY:= X MOD 7;
END;

function GetFirstDayWeek(shmsiDate : String) : String;
var
  tmpDate : String;
  y : Integer;
  m, d,
  diff, p : Byte;
begin
  y := 0;
  m := 0;
  d := 0;

  tmpDate := shmsiDate;
  p := pos('/', tmpDate);
  if p <> 0 then
  begin
    y := StrToInt(Copy(tmpDate, 1, p-1));
    Delete(tmpDate, 1, p);
  end;

  p := pos('/', tmpDate);
  if p <> 0 then
  begin
    m := StrToInt(Copy(tmpDate, 1, p-1));
    Delete(tmpDate, 1, p);
  end;

  if Length(tmpDate) <> 0 then
    d := StrToInt(tmpDate);

  if (y <> 0) and (m <> 0) and (d <> 0) then
  begin
    diff := FARSI_WEEK_DAY(y, m, d);
    if diff <> 0 then
      Result := AddDate(shmsiDate, -diff)
    else
      Result := shmsiDate;
  end
  else
    Result := shmsiDate;
end;

function datetoweekname(date_string:string):string;
var
   y,m,d:integer;
begin
  if (date_string = '') or (not IsTrueDate(date_string)) then
  begin
    datetoweekname:='';
    exit;
  end;
  date_string := BeautifulDate(date_string);
  y:=strtoint(copy(date_string,1,4));
  m:=strtoint(copy(date_string,6,2));
  d:=strtoint(copy(date_string,9,2));
  datetoweekname:=HAFTEHNAME[FARSI_WEEK_DAY(y,m,d)];
end;

FUNCTION YEARWEEK(Y:integer):BYTE;
BEGIN
    y:=y-1300;
    YEARWEEK:=(Y+ Y DIV 4 -96) MOD 7;
END;

PROCEDURE MAKEMAHWEEK(Y:integer);
VAR
   M,S:BYTE;
BEGIN
   S:=YEARWEEK(Y);
   FOR M:=1 TO 12 DO
   IF M<7
   THEN BEGIN
        MAHWEEK[M]:=(S+3*M-3) MOD 7;
        MAHROOZ[M]:=31
   END
   ELSE BEGIN
        MAHWEEK[M]:=(S+2*M-10) MOD 7;
        MAHROOZ[M]:=30;
        IF Y MOD 4 <> 3 THEN MAHROOZ[12]:=29;
   END;
END;

procedure makehollidays(kind:byte);
var
   y,yy:integer;
   m,d,mm,dd:byte;
   TATILAT:MAHTATILTYPE;
   f:file of MAHTATILTYPE;
begin
   assignfile(f,ttlfilename[kind]);
   rewrite(f);
   FOR Y:=1379 TO 1405 DO
   BEGIN
      MAKEMAHWEEK(Y);
      FOR M:=1 TO 12 DO
      BEGIN
          TATILAT:=SHTATIL[M];

          D:=7-MAHWEEK[M];
          REPEAT
           TATILAT:=TATILAT+[D];
           D:=D+7;
          UNTIL D>31;

          FOR D:=1 TO 31 DO
          IF NOT (D IN TATILAT)
          THEN BEGIN
            MM:=M;
            DD:=D;
            YY:=Y;
            SHTOGH(YY,MM,DD);
            IF DD IN GHTATIL[MM]
            THEN TATILAT:=TATILAT+[D];
          END;
          write(f,tatilat);
      END;
   END;
   close(f);
end;

procedure loadhollidays(kind:byte;yr:integer);
var
   f:file of hol_type;
   m:byte;
begin
   if not FileExists(ExtractFilePath(Application.ExeName) + ttlfilename[kind]) then
     MakeHollidays(kind);
   assignfile(f, ExtractFilePath(Application.ExeName) + ttlfilename[kind]);
   reset(f);
   seek(f,(yr-1379)*12);
   for m:=1 to 12 do read(f,hollidays[m]);
   closefile(f);
end;

function isholliday(kind:byte;yr,mn,dy:integer):boolean;
var
   hollidays:array[1..12] of hol_type;
   f:file of hol_type;
   m:byte;
begin
   if not FileExists(ExtractFilePath(Application.ExeName) + ttlfilename[kind]) then
     MakeHollidays(kind);
   assignfile(f, ExtractFilePath(Application.ExeName) + ttlfilename[kind]);
   reset(f);
   seek(f,(yr-1379)*12);
   for m:=1 to 12 do read(f,hollidays[m]);
   closefile(f);
   isholliday:= (dy in hollidays[m]);
end;


procedure TATIL_st(M,D,M1,D1,M2,D2,W:BYTE;var hst:string;var is_hol:boolean);
VAR
   F:TEXT;
   I,J,MM,DD,L:BYTE;
   ST:STring;
BEGIN
   is_hol:=false;
   hst:='';
   IF fileexists(ExtractFilePath(Application.ExeName) + 'CALEN3.DAT')
   THEN BEGIN
      L:=0;
      ASSIGNfile(F,ExtractFilePath(Application.ExeName) + 'CALEN3.DAT');
      RESET(F);
      WHILE NOT EOF(F) DO
      BEGIN
         READLN(F,I,J,dd,MM,ST);
         IF (I=0)AND(M=MM)AND(D=DD)
         OR (I=1)AND(M1=MM)AND(D1=DD)
         OR (I=2)AND(M2=MM)AND(D2=DD)
         THEN BEGIN
              IF J=1 THEN is_hol:=true;
              INC(L);
              if l=1
              then hst:=st
              else hst:=hst+#13#10+st;
         END;
      END;
      CLOSE(F);
      IF (W=5)AND(M2=9)AND(D2<=30)AND(D2>=23)
      THEN BEGIN
         INC(L);
         st:='—Ê“ ÃÂ«‰Ì ﬁœ”';
         if l=1
         then hst:=st
         else hst:=hst+#13#10+st;
      END;
   END;
END;

function DateInRange(CDate,FromDate,ToDate:string):boolean;
begin
   DateInRange:=(CDate>=FromDate) and (CDate<=ToDate);
end;

end.
