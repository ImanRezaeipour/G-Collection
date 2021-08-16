unit Globals;

interface

uses
  Forms, SysUtils, Controls, StdCtrls;


const
  MB_FALSE      = 0;
  MB_TRUE       = 1;

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
function  DelLeftZero(txt : String) : String;

function  IsNumeric(ST : String) : Boolean;
function  StrRev(txt : String) : String;
function  NumReverse(ST : String) : String;

function  Pow2(n : Byte) : Integer;

implementation




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
  Delete zero character from left side a String
 ***********************************************************************)
function DelLeftZero(txt : String) : String;
var
  S : String;
begin
  S := txt;
  if S <> '' then
    while (S <> '') and (S[1] = '0') do Delete(S, 1, 1);
  DelLeftZero := S;
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


end.
