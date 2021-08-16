unit Globals;

interface

uses
  Forms, SysUtils, Controls, StdCtrls, Code_Sys, Funcs, RunCmnds, types,z84_cmd;


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
Type DayPrg = record
  from1,to1,from2,to2,from3,to3,from4,to4   : string[5];
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
  dtlcode         :Integer ;
  Empl_Services   : string;
  Empl_weekPrg    : Integer;
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
      ErrorMessage('Å«—«„ —Â«Ì ”Ì” „ —« „Ãœœ«  ‰ŸÌ„ ‰„«ÌÌœ.');
    end;

    CloseFile(f);
  end;
end;



end.




