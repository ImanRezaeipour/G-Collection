unit Cntroler;

interface

Uses
  Controls, SysUtils, Db, DBTables, Forms, MSGs, FarsiApi,
  DateProc, ErteBat, Globals, Code_Sys, DBS_Proc;


function BarCode4(BarCode : String) : String;
function BarCode8(BarCode : String) : String;

VAR
  CurRdr : integer =1 ;

implementation

uses
  ClckRecs, Main, Z80_CMD, FishLst,ComTools,RdrStat;


function BarCode4(BarCode : String) : String;
var
 i : Byte;
 ST : String[4];
begin
  ST:='';
  while Length(BarCode) < 8 do BarCode := '0' + BarCode;
  for i := 1 to 4 do
    ST := ST + Chr((Ord(BarCode[i+i])-48)*16+Ord(BarCode[i+i-1])-48);
   BarCode4:=ST;
end;

function BarCode8(BarCode : String) : String;
var
  i, j : Byte;
  ST : String[8];
begin
  ST:='';
  for i := 1 to 4 do
  begin
    j := Ord(BarCode[i]);
    ST := ST + Chr(j mod 16 + 48) + Chr(j div 16 + 48);
  end;
  BarCode8 := NumReverse(ST);
end;



end.
