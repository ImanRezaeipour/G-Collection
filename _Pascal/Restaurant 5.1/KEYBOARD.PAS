unit Keyboard;

interface
  procedure Keyboard_Integer(var Key : Char);
  procedure Keyboard_Number(var Key : char; S : String);
  procedure Keyboard_Date(var Key : char);
  procedure Keyboard_Time(var Key : char);
  procedure Keyboard_Money(var Key : Char);
  procedure Keyboard_Proxi(var Key : Char);

  Procedure SendTab(receiver : Integer);
  function  InsertChar(source_str , separator : String ; separate_count : integer) : String;
  function  RemoveChar(source_str , separator : String) : String;

  function strtoreal(s:string):real;

implementation
uses
  WinProcs, FarsiAPI,sysutils;

procedure Keyboard_Integer (var Key : char);
begin
  if not (Key in [#8, #13, #48..#57]) then Key := #0;
end;

procedure Keyboard_Number(var Key : char; S : String);
begin
  if not ((Key in [#8, #13, #45, #48..#57]) or
         ((key = #46) and (Pos('.', S) = 0))) then
    Key := #0;
end;

procedure Keyboard_Money(var Key : Char);
begin
  if not (Key in [#8, #13, #48..#57]) then Key := #0;
end;

procedure Keyboard_Proxi(var Key : Char);
begin
  case Key of
    #8, #13, #48..#57, 'A'..'F': ;
    'a'..'f': Key := UpCase(Key);
    else Key := #0;

  end;
end;

procedure Keyboard_Date(var Key : Char);
begin
  if not (Key in [#8, #13, #48..#57, '/']) then Key := #0;
end;

procedure Keyboard_Time(var Key : char);
begin
  if not (Key in [#8, #13, #48..#57, ':']) then Key := #0;
end;

Procedure SendTab(receiver : Integer);
const
  WM_COMMAND = $111;
begin
  SendMessage(receiver, WM_COMMAND, $694C, $0100694C);
  SendMessage(receiver, WM_COMMAND, $694C, $0200694C);
end;


function InsertChar (source_str , separator : string ; separate_count : integer) : string;
var
  ret_str : string ;
  index   : integer ;
  l, commas : integer;
  farsi : Boolean;
begin
  farsi := IsFarsi(source_str);
  if farsi then source_str := ConvertToEnglish(source_str) ;

  ret_str := source_str;
  l := Length(source_str);

  commas := 0;
  for index := 1 to ((l-1) div separate_count) do
  begin
    insert(separator, ret_str, Length(ret_str) - commas - index * separate_count + 1);
    inc(commas);
  end;

  if farsi then
    InsertChar := ConvertToFarsi(ret_str)
  else
    InsertChar := ret_str;

end;

Function RemoveChar(source_str, separator : String) : String;
var
  separator_len : integer;
  new_pos : Integer;
  endofproc : Boolean;
begin
  separator_len := Length(separator);

  endofproc := False;
  Repeat
    new_pos := Pos(separator, source_str);
    if new_pos <> 0 then
      Delete(source_str, new_pos, separator_len)
    else
      endofproc := True;
  Until endofproc;

  RemoveChar := source_str;
end;

function strtoreal(s:string):real;
var
  r:real;
  i,j,p:byte;
begin
  p:=pos('.',s);
  if p=0
  then begin
       r:=strtoint(s);
  end
  else begin
       j:=length(s)-p;
       delete(s,p,1);
       r:=strtoint(s);
       for i:=1 to j do r:=r/10.0;
  end;
  strtoreal:=r;
end;

end.
