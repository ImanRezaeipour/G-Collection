unit IOTools;

interface

function  FileLen(FileName : String) : Longint;
function  FileCopy(SourceFile, TargetFile : String) : Boolean;
function  IsDriveReady(drv : Char) : Boolean;
function  CreatePath(p : String) : Boolean;


implementation

uses
  SysUtils;

(***********************************************************************
  Return file length
 ***********************************************************************)
function FileLen(FileName : String) : Longint;
var f: file of Byte;
begin
{$I-}
  FileLen := 0;
  if FileExists(FileName) then
  begin
    AssignFile(f, FileName);
    Reset(f);
    FileLen := FileSize(f);
    CloseFile(f);
  end;
{$I+}
end;

(***********************************************************************
  Copy a file to another file
 ***********************************************************************)
function FileCopy(SourceFile, TargetFile : String) : Boolean;
var
  FromF, ToF : file;
  NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
begin
{$I-}
  FileCopy := True;
  AssignFile(FromF, SourceFile); { Open input file }
  Reset(FromF, 1);	         { Record size = 1 }
  if IOResult = 0 then
  begin
    AssignFile(ToF, TargetFile); { Open output file }
    ReWrite(ToF, 1);	         { Record size = 1 }
    if IOResult = 0 then
    begin
      repeat
        BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
        BlockWrite(ToF, Buf, NumRead, NumWritten);
      until (NumRead = 0) or (NumWritten <> NumRead);
      CloseFile(FromF);
      CloseFile(ToF);
    end
    else
      FileCopy := False;
  end
  else
    FileCopy := False;
{$I+}
end;

(***********************************************************************
  Test drive for ready
 ***********************************************************************)
function IsDriveReady(drv : Char) : Boolean;
begin
  IsDriveReady := (DiskFree(Ord(UpCase(drv))-64) >= 0);
end;

(***********************************************************************
  Test drive for ready
 ***********************************************************************)
function CreatePath(p : String) : Boolean;
var
  pos1, pos2 : Integer;
  d, CurrDir : String;
begin
  CreatePath := True;
  if Copy(p, 2, 2) <> ':\' then
    CreatePath := False
  else
  begin
    {$I-}
    GetDir(Ord(UpCase(p[1]))-64, CurrDir);
    if Copy(p, Length(p), 1) <> '\' then
      p := p + '\';
    pos1 := 3;
    pos2 := Pos('\', Copy(p, pos1+1, Length(p)-Pos1));
    while pos2 > 0 do
    begin
      Inc(pos2, pos1);
      d := Copy(p, 1, pos2-1);
      ChDir(d);
      if IOResult <> 0 then
      begin
        MkDir(d);
        if IOResult <> 0 then
        begin
          CreatePath := False;
          Break;
        end;
      end;
      pos1 := Pos2;
      pos2 := Pos('\', Copy(p, pos1+1, Length(p)-Pos1));
    end;
    ChDir(CurrDir);
    {$I+}
  end;
end;

end.
