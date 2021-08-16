unit Globals;

interface

uses
  Forms, SysUtils, Controls, StdCtrls, Code_Sys, Funcs, RunCmnds, types,z84_cmd;

const

  softwarecode  = 7;
  refreshpriod  = 5;

var
  maxusers:byte = 3;
  lastrefresh : integer;
  logocode    : string[4];
  islogo      : boolean = false;
  AppVersion:string  = '3.0';

(******************** Constant definition ********************)
const
  RDR_CREDIT    = 0;
  RDR_INITCARD  = 1;
  maxEmployee   = -1;



(******************** structure definition ********************)
type
  TOptions = Record
    ProgramPath  : String;
    DataBasePath : String;
    CoName       : String;
    Shobeh       : String;

    UserName     : String[15];
    UserDepart   : Integer;


    fromDate     : String[10];
    toDate       : String[10];
  end;

  {PrnTypetype=(PRN_LX,PRN_LQ,PRN_CITIZEN3551,PRN_CITIZEN3541,PRN_ITHACA);}
  TParams = Record
    department          : Integer;
    chargePrice         : Currency;

    rptSign1            : String;
    rptSign2            : String;
    rptSign3            : String;
    rptSign4            : String;
    rptSign5            : String;

    printfish           : boolean;
    PrnType             : prntypetype;
    Linefeed            : byte;
    AllFishPrc          : boolean;
  end;

Type TEmployee = Record
  EmplID          : String;
  EmplCode        : String;
  EmplPass        : String;
  EmplName        : String;
  EmplFamily      : String;
  LastCharge      : String;
  ExpireDate      : String;
  Credit          : Currency;
  EmplPart        : integer;
  Empl_Department : integer;
  Empl_CoPost     : integer;
  Empl_Active     : boolean;
  dtlcode         : Integer;
  MoRangePrice    : Currency; //kaveh
  MoRangeRemain   : Currency; //kaveh
  MoRangeMonth    : Byte; //kaveh
  MoRangeDay      : Byte; //kaveh
  MoRangeDelRemain: Boolean; //kaveh
  LastChargeCode  : Integer; //kaveh
end;





(******************** public variables definition ********************)
var
  gOptions  : TOptions;
  gParams   : TParams;
  Readers   : array of TReaders;
  rdrCount  : Byte;








(******************** subrotines definition ********************)
procedure SaveParams;
procedure LoadParams;
function checkpass(pass:string):boolean;
function CodingPass(st:string):string;
function DeCodingPass(st:string):string;





implementation
(******************** I M P L E M E N T A T I O N ********************)
uses
  MSGs;


{ save parameters into file }
procedure SaveParams;
var
  f : TextFile;
begin
  AssignFile(f, gOptions.ProgramPath + 'Params.Dta');
  ReWrite(f);

  WriteLn(f, gParams.department);
  WriteLn(f, gParams.chargePrice);

  WriteLn(f, gParams.rptSign1);
  WriteLn(f, gParams.rptSign2);
  WriteLn(f, gParams.rptSign3);
  WriteLn(f, gParams.rptSign4);
  WriteLn(f, gParams.rptSign5);
  WriteLn(f, ord(gParams.printfish));
  WriteLn(f, ord(gParams.prntype));
  WriteLn(f, gParams.linefeed);
  WriteLn(f, ord(gParams.allfishprc));

  CloseFile(f);
end;



{ Load parameters from file }
procedure LoadParams;
var
  f : TextFile;
  temp : string;
  i:byte;
  ii:prntypetype absolute i;
  b:boolean absolute i;
begin
  if FileExists(gOptions.ProgramPath + 'Params.Dta') then
  begin
    AssignFile(f, gOptions.ProgramPath + 'Params.Dta');
    Reset(f);

    try
      ReadLn(f, gParams.department);
      Readln(f, gParams.chargePrice);

      Readln(f, gParams.rptSign1);
      Readln(f, gParams.rptSign2);
      Readln(f, gParams.rptSign3);
      Readln(f, gParams.rptSign4);
      Readln(f, gParams.rptSign5);
      Readln(f, i);
      gParams.printfish := b;
      Readln(f, i);
      gParams.prntype := ii;
      Readln(f,gparams.linefeed);
      Readln(f, i);
      gParams.AllFishPrc := b;
    except
      ErrorMessage('ÇÑÇãÊÑåÇí ÓíÓÊã ÑÇ ãÌÏÏÇ ÊäÙíã äãÇííÏ.');
    end;

    CloseFile(f);
  end;
end;

// password procedures

function checkpass(pass:string):boolean;
const
//   ADMIN_PASS = 'DPSOFTWARE';
   sub_pass1  = 'MECADONIA';
   sub_pass2  = 'IND';
var
   tt,t,ttt,code:integer;
   hour,min,sec,msec:word;
   r:real;
   st:string;
begin
    pass:=UpperCase(pass);
    result:=true;
    if pos(sub_pass1,pass)=0  then result:=false;
    if pos(sub_pass2,pass)=0  then result:=false;
    st:=copy(pass,length(pass)-1,2);
    val(st,tt,code);
    decodetime(time,hour,min,sec,msec);
    t:=hour+min;
    if abs(t-tt)>=2 then result:=false;
    if not result
    then begin
      st:=copy(pass,length(pass)-2,3);
      val(st,tt,code);
      r:=frac(t/37.0);
      ttt:=trunc(r*1000);
      if abs(ttt-tt)<30 then result:=true;
    end;
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
   if st1=''
   then result:=st1
   else result:='OQG'+st1;
end;

function DeCodingPass(st:string):string;
var
   i,j,k: byte;
   st1:string;
begin
   if copy(st,1,3)<>'OQG'
   then begin
        result:=st;
        exit;
   end;
   st1:='';
   delete(st,1,3);
   if odd(length(st)) then st:=st+#200;
   for i:=1 to length(st) div 2 do
   begin
       j:=ord(st[i+i-1])-200;
       k:=ord(st[i+i])-200;
       st1:=st1+chr((j + k*16) xor 118);
   end;
   decodingpass:=st1;
end;



end.




