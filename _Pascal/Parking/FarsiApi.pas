unit FarsiApi;

interface

Function  ConvertToEnglish(s : String) : String;
Function  ConvertToFarsi(s : String) : String;
Function  IsFarsi(s : String) : Boolean;
Procedure SetDirectionEnglish(hWnd : Integer);
Procedure SetDirectionFarsi(h : Integer);
Function  FixString(input_str : String ; size : integer) : String;

implementation
uses
  WinProcs, SysUtils;

Const
  WM_KEYDOWN = $100;
  WM_KEYUP = $101;

Function ConvertToEnglish (s : String) : String;
begin
  if s <> '' then
  begin
    If s[1] = #254 Then
      ConvertToEnglish := Copy(s, 2, length(s) - 1)
    Else
      ConvertToEnglish := s
  end;
End;

Function ConvertToFarsi(s : String) : String;
begin
  if Length(s) > 0 then
  begin
    if s[1] = #254 Then
      ConvertToFarsi := s
    else
      ConvertToFarsi := #254 + s
  end;
End;

Procedure SetDirectionEnglish(hWnd : Integer);
begin
  SendMessage(hWnd, WM_KEYDOWN, $10, 0);
  SendMessage(hWnd, WM_KEYDOWN, $11, 0);
  SendMessage(hWnd, WM_KEYUP, $10, 0);
  SendMessage(hWnd, WM_KEYUP, $11, 0);
End;

Procedure SetDirectionFarsi(h : Integer);
begin
  SendMessage(h, WM_KEYDOWN, $10, 0);
  SendMessage(h, WM_KEYDOWN, $11, 0);
  SendMessage(h, WM_KEYUP, $10, 0);
  SendMessage(h, WM_KEYUP, $11, 0);
End;

Function IsFarsi(s : String) : Boolean;
begin
  if s[1] = #254 then
    IsFarsi := True
  else
    IsFarsi := False;
end;

Function FixString(input_str : String ; size : integer) : String;
var
  l : Integer;
  ret_str : String;
  i : Integer;
begin
  l := Length(input_str);
  if l > size then
    FixString := Copy(input_str, size - l, size)
  else
  begin
    ret_str := input_str;
    for i:=1 to size - l do
      ret_str :=  ' ' + ret_str;

    FixString := ret_str;
  end;
end;

end.
