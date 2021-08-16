unit CpyDisks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, FileCtrl, Globals, MSGs, IOTools;

type
  TfrmCpyAnyDsk = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    lblSource: TStaticText;
    Label2: TLabel;
    lblTarget: TStaticText;
    filList: TFileListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    S_P, T_P : String;

    Files : TStringList;
    FList : array [0..100] of String;
    n, Top,
    DiskNo : Byte;
    NextDisk : Boolean;

    procedure LoadFiles(p : String);
    function  GetTotalSize_List : Int64;
    function  GetFreeSize(P : String) : Int64;
    function  FirstFileCopyable : Integer;
    function  CopyHard : Boolean;
    function  CopyToAnyDisk : Boolean;
    function  CopySplitDisk : Boolean;
    function  CreateSplitFiles : Boolean;
    procedure CreateFileSetup;

    function  ReadFileSetup : Boolean;
    function  CopyFromDiskets : Boolean;
    function  MergFiles : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
    function  Backup(Sp, Tp : String) : Boolean;
    function  Restore(Sp, Tp : String) : Boolean;
  end;

var
  frmCpyAnyDsk: TfrmCpyAnyDsk;

const
  FileSpace = 650;

implementation

{$R *.DFM}


procedure TfrmCpyAnyDsk.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
end;

procedure TfrmCpyAnyDsk.CreateFileSetup;
var
  f : TextFile;
  i : Byte;
  fn : String;
begin
{$I-}
  fn := T_P + 'Disk' + IntToStr(DiskNo) + '.TXT';
  AssignFile(f, fn);
  ReWrite(f);
  for i := 0 to n-1 do
    Writeln(f, FList[i]);
  if NextDisk then
    Writeln(f, 'Next...');
  CloseFile(f);
{$I+}
end;

procedure TfrmCpyAnyDsk.LoadFiles(p : String);
var
  i, j : Integer;
  Sizes : TStringList;
  t : String;
begin
  filList.Directory := p;
  Sizes := TStringList.Create;

  for i := 0 to filList.Items.Count - 1 do
  begin
    if UpperCase(filList.Items.Strings[i]) <> 'USERSTAT.DB' then
    begin
      Files.Add(p + filList.Items.Strings[i]);
      Sizes.Add(IntToStr(FileLen(p + filList.Items.Strings[i])));
    end;
  end;

  for i := 0 to Sizes.Count-2 do
    for j := i+1 to Sizes.Count-1 do
      if StrToInt(Sizes.Strings[j]) > StrToInt(Sizes.Strings[i]) then
      begin
        t := Sizes.Strings[i];
        Sizes.Strings[i] := Sizes.Strings[j];
        Sizes.Strings[j] := t;

        t := Files.Strings[i];
        Files.Strings[i] := Files.Strings[j];
        Files.Strings[j] := t;
      end;
  Sizes.Destroy;
end;

function TfrmCpyAnyDsk.GetTotalSize_List : Int64;
var
  i : Integer;
  l : Int64;
begin
  l := 0;
  for i := 0 to Files.Count-1 do
    Inc(l, FileLen(Files.Strings[i]));
  GetTotalSize_List := l;
end;

function TfrmCpyAnyDsk.GetFreeSize(P : String) : Int64;
begin
  GetFreeSize := DiskFree(Ord(UpCase(P[1]))-64);
end;

function TfrmCpyAnyDsk.FirstFileCopyable : Integer;
var
  i : Integer;
  DskSpc : Int64;
begin
  FirstFileCopyable := -1;
  DskSpc := DiskFree(1) - FileSpace;
  for i := 0 to Files.Count - 1 do
    if (FileLen(Files.Strings[i]) < DskSpc) or
       FileExists(T_P + ExtractFileName(Files.Strings[i])) then
    begin
      FirstFileCopyable := i;
      Break;
    end;
end;

function TfrmCpyAnyDsk.Backup(Sp, Tp : String) : Boolean;
var
  T_Size,
  F_Size : Int64;
begin
  S_P := UpperCase(Sp);
  T_P := UpperCase(Tp);
  if Copy(S_P, Length(S_P), 1) <> '\' then
    S_P := S_P + '\';
  if Copy(T_P, Length(T_P), 1) <> '\' then
    T_P := T_P + '\';

  if not IsDriveReady(S_P[1]) then
  begin
    ErrorMessage('œ—«ÌÊ „»œ√ ¬„«œÂ ‰Ì” .');
    Backup := False;
  end
  else if not IsDriveReady(T_P[1]) then
  begin
    ErrorMessage('œ—«ÌÊ „ﬁ’œ ¬„«œÂ ‰Ì” .');
    Backup := True;
  end
  else
  begin
    Files := TStringList.Create;
    LoadFiles(S_P);
    T_Size := GetTotalSize_List;
    F_Size := GetFreeSize(T_P);
    if (T_Size > F_Size) and not (T_P[1] in ['A', 'B']) then
    begin
      ErrorMessage('œ—«ÌÊ „ﬁ’œ «‰ Œ«» ‘œÂ œ«—«Ì ›÷«Ì ﬂ«›Ì ‰„Ìù»«‘œ.');
      Backup := False;
    end
    else if not (T_P[1] in ['A', 'B']) then
      Backup := CopyHard
    else if (T_Size < F_Size) and (T_P[1] in ['A', 'B']) then
    begin
      if CopyHard then
      begin
        NextDisk := False;
        CreateFileSetup;
        Backup := True;
      end
      else
        Backup := False;
    end
    else
    begin
      if FileLen(Files.Strings[0]) < (DiskSize(1) - FileSpace) then
        Backup := CopyToAnyDisk
      else
        Backup := CopySplitDisk;
    end;
  end;
end;

function TfrmCpyAnyDsk.CopyHard : Boolean;
var
  OK : Boolean;
  i : Integer;
begin
  OK := True;
{$I-}
  ChDir(T_P);
{$I+}
  if IOResult <> 0 then
  begin
    if not ConfirmMessage('‘«ŒÂ „Ê—œ ‰Ÿ— ÊÃÊœ ‰œ«—œ. ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« «ÌÃ«œ ‰„«ÌÌœø') then
      OK := False
    else
    begin
      OK := CreatePath(T_P);
      if not OK then
        ErrorMessage('«ÌÃ«œ ‘«ŒÂ «„ﬂ«‰ Å–Ì— ‰Ì” .');
    end
  end;

  if OK then
  begin
    if not Showing then
    begin
      Show;
      Animate1.Active := True;
    end;
    DiskNo := 1;
    n := 0;
    for i := 0 to Files.Count-1 do
    begin
     lblSource.Caption := Files.Strings[i];
     lblTarget.Caption := T_P + ExtractFileName(Files.Strings[i]);
     Refresh;
     if FileCopy(lblSource.Caption, lblTarget.Caption) then
     begin
       FList[n] := ExtractFileName(Files.Strings[i]);
       Inc(n);
     end
     else
     begin
       ErrorMessage('ﬂÅÌ ‰„Êœ‰ ›«Ì·Â« «„ﬂ«‰Å–Ì— ‰Ì” .');
       OK := False;
       Break;
     end;
    end;
  end;
  Hide;
  CopyHard := OK;
end;

function TfrmCpyAnyDsk.CopyToAnyDisk : Boolean;
var
  i : Integer;
  OK : Boolean;
begin
  n := 0;
  if InformationMessage('œÌ”ﬂ  Œ«·Ì ‘„«—Â 1 —« œ«Œ· œ—«ÌÊ ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.') = mrOK then
  begin
    OK := True;
    while Files.Count > 0 do
    begin
      {$I-}
      ChDir(T_P);
      {$I+}
      if (IOResult <> 0) and not CreatePath(T_P) then
      begin
        ErrorMessage('«ÌÃ«œ ‘«ŒÂ „Ì”— ‰Ì” .');
        OK := False;
        Break;
      end;
      i := FirstFileCopyable;
      if i < 0 then
      begin
        if DiskNo = 0 then
        begin
          if InformationMessage('œÌ”ﬂ  ›÷«Ì Œ«·Ì ‰œ«—œ. ·ÿ›√ œÌ”ﬂ  œÌê—Ì ﬁ—«— œÂÌœ') <> mrOK then
          begin
            OK := False;
            Break;
          end;
        end
        else
        begin
          NextDisk := True;
          CreateFileSetup;
          n := 0;
          Hide;
          if InformationMessage('œÌ”ﬂ  ‘„«—Â '+ IntToStr(DiskNo+1) + ' —« œ«Œ· œ—«ÌÊ ê–«‘ Â Ê  √ÌÌœ ‰„«ÌÌœ.') <> mrOK then
          begin
            OK := False;
            Break;
          end;
        end;
      end
      else
      begin
        FList[n] := ExtractFileName(Files.Strings[i]);
        if not Showing then
        begin
          Show;
          Animate1.Active := True;
        end;
        lblSource.Caption := Files.Strings[i];
        lblTarget.Caption := T_P + FList[n];
        Refresh;
        if not FileCopy(Files.Strings[i], T_P + FList[n]) then
        begin
          ErrorMessage('ﬂÅÌ ﬂ—œ‰ ›«Ì·Â« «„ﬂ«‰Å–Ì— ‰Ì” .');
          OK := False;
          Break;
        end;
        if n = 0 then
          Inc(DiskNo);
        Inc(n);
        Files.Delete(i);
      end;
    end;
  end
  else
    OK := False;


  if OK then
  begin
    NextDisk := False;
    CreateFileSetup;
  end;
  CopyToAnyDisk := OK;
  Close;
end;

function TfrmCpyAnyDsk.CopySplitDisk : Boolean;
var
  OK : Boolean;
  DskSpc : Int64;
begin
  OK := True;
  n := 0;
  DiskNo := 1;
  DskSpc := 0;
  while Files.Count > 0 do
  begin
    if n = 0 then
    begin
      Hide;
      if InformationMessage('œÌ”ﬂ  Œ«·Ì ‘„«—Â '+ IntToStr(DiskNo) + ' —« œ«Œ· œ—«ÌÊ ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ') <> mrOK then
      begin
        Ok := False;
        Break;
      end
      else
      begin
        DskSpc := DiskFree(1) - FileSpace;
        if DskSpc < 100 then
        begin
          if InformationMessage('œÌ”ﬂ  ›÷«Ì ﬂ«›Ì ‰œ«—œ. œÌ”ﬂ  —«  ⁄ÊÌ÷ ‰„«ÌÌœ.') = mrOK then
            Continue
          else
          begin
            OK := False;
            Break;
          end;
        end;

        {$I-}
        ChDir(T_P);
        if IOResult <> 0 then
        begin
          OK := CreatePath(T_P);
          if not OK then
          begin
            ErrorMessage('«ÌÃ«œ ‘«ŒÂ „Ì”— ‰Ì” .');
            Break;
          end;
        end;
        {$I+}
      end;
    end
    else
    begin
      DskSpc := DiskFree(1) - FileSpace;
      if DskSpc < 100 then
      begin
        Hide;
        if InformationMessage('œÌ”ﬂ  ›÷«Ì ﬂ«›Ì ‰œ«—œ. œÌ”ﬂ  —«  ⁄ÊÌ÷ ‰„«ÌÌœ.') = mrOK then
        begin
          NextDisk := True;
          CreateFileSetup;
          n := 0;
          Inc(DiskNo);
          Continue;
        end
        else
        begin
          OK := False;
          Break;
        end;
      end;
    end;

    if not Showing then
    begin
      Show;
      Animate1.Active := True;
    end;
    lblSource.Caption := Files.Strings[0];
    lblTarget.Caption := T_P + ExtractFileName(Files.Strings[0]);
    Refresh;

    if FileLen(Files.Strings[0]) > DskSpc then
    begin
      if not CreateSplitFiles then
      begin
        ErrorMessage('«„ﬂ«‰  ﬁ”Ì„ »‰œÌ ›«Ì· —ÊÌ œÌ”ﬂ Â« ÊÃÊœ ‰œ«—œ.');
        Ok := False;
        Break;
      end;
    end
    else
    begin
      if FileCopy(lblSource.Caption, lblTarget.Caption) then
      begin
        FList[n] := ExtractFileName(Files.Strings[0]);
        Files.Delete(0);
      end
      else
      begin
        ErrorMessage('ﬂÅÌ ‰„Êœ‰ ›«Ì·Â« «„ﬂ«‰Å–Ì— ‰Ì” .');
        Ok := False;
        Break;
      end;
    end;
    Inc(n);

  end;
  if OK then
  begin
    NextDisk := False;
    CreateFileSetup;
    Hide;
    Close;
  end;
  CopySplitDisk := OK;
end;

function TfrmCpyAnyDsk.CreateSplitFiles : Boolean;
var
  In_f, Out_f : file;
  OK : Boolean;
  DskSpc : Int64;
  l, NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
  FName : String;
  N_Split : Integer;
begin
  DskSpc := 0;
  N_Split := 1;
  l := 2048;
{$I-}
  AssignFile(In_f, Files.Strings[0]);
  Reset(In_f, 1);
  OK := (IOResult = 0);
  if OK then
  begin
    repeat
      if DskSpc = 0 then
      begin
        Hide;
        if (N_Split = 1) or
           ((N_Split > 1) and (Informationmessage('œÌ”ﬂ  ‘„«—Â ' + IntToStr(DiskNo) + ' —« œ«Œ· œ—«ÌÊ ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.' ) = mrOK)) then
        begin
          DskSpc := DiskFree(1) - FileSpace;
          l := 2048;
          ChDir(T_P);
          if IOResult <> 0 then
            OK := CreatePath(T_P);
          if not OK then
          begin
            Break;
          end;
          FName := ExtractFileName(Files.Strings[0]);
          AssignFile(Out_f, T_P + Copy(FName, 1, Length(FName)-1) + IntToStr(N_Split));
          ReWrite(Out_f, 1);
          OK := (IOResult = 0);
          if not OK then
            Break;
          if not Showing then
            Show;
          lblSource.Caption := Files.Strings[0];
          lblTarget.Caption := T_P + Copy(FName, 1, Length(FName)-1) + IntToStr(N_Split);
          Refresh;
        end
        else
        begin
          OK := False;
          Break;
        end;
      end;
      BlockRead(In_f, Buf, l, NumRead);
      BlockWrite(Out_f, Buf, NumRead, NumWritten);
      Dec(DskSpc, NumWritten);
      if (DskSpc <> 0) and (DskSpc < l) then
        l := DskSpc
      else if DskSpc = 0 then
      begin
        CloseFile(Out_f);
        FList[n] := FName + '...' + Copy(FName, 1, Length(FName)-1) + IntToStr(N_Split);
        Inc(n);
        NextDisk := True;
        CreateFileSetup;
        n := 0;
        Inc(DiskNo);
        Inc(N_Split);
      end;
    until (NumRead = 0) or (NumWritten <> NumRead);
    if OK then
    begin
      CloseFile(Out_f);
      CloseFile(In_f);
      FList[n] := FName + '...' + Copy(FName, 1, Length(FName)-1) + IntToStr(N_Split);
      Files.Delete(0);
    end;
  end;
{$I+}
  CreateSplitFiles := OK;
end;


function TfrmCpyAnyDsk.ReadFileSetup : Boolean;
var
  f : TextFile;
  s, fn : String;
  p : Integer;
begin
  fn := S_P + 'Disk' + IntToStr(DiskNo) + '.TXT';
  if FileExists(fn) then
  begin
    ReadFileSetup := True;
    NextDisk := False;
    AssignFile(f, fn);
    ReSet(f);
    Files.Clear;
    n := 0;
    Top := 0;
    while not Eof(f) do
    begin
      Readln(f, s);
      if s <> 'Next...' then
      begin
        p := Pos('...', s);
        if p > 0 then
        begin
          FList[n] := T_P + Copy(s, 1, p-1);
          Delete(s, 1, p+2);
          Files.Add(S_P + s + '...');
          if not FileExists(S_P + s) then
          begin
            ReadFileSetup := False;
            Break;
          end;
          Inc(n);
        end
        else if FileExists(S_P + s) then
        begin
          Files.Add(S_P + s);
          FList[n] := T_P + s;
          Inc(n);
        end
        else
        begin
          ReadFileSetup := False;
          Break;
        end;
      end
      else
        NextDisk := True;
    end;
    CloseFile(f);
  end
  else
    ReadFileSetup := False;
end;

function TfrmCpyAnyDsk.Restore(Sp, Tp : String) : Boolean;
var
  T_Size,
  F_Size : Int64;
begin
  DiskNo := 1;
  NextDisk := False;
  S_P := UpperCase(Sp);
  T_P := UpperCase(Tp);
  if Copy(S_P, Length(S_P), 1) <> '\' then
    S_P := S_P + '\';
  if Copy(T_P, Length(T_P), 1) <> '\' then
    T_P := T_P + '\';

  if not IsDriveReady(S_P[1]) then
  begin
    ErrorMessage('œ—«ÌÊ „»œ√ ¬„«œÂ ‰Ì” .');
    ReStore := False;
  end
  else if not IsDriveReady(T_P[1]) then
  begin
    ErrorMessage('œ—«ÌÊ „ﬁ’œ ¬„«œÂ ‰Ì” .');
    ReStore := False;
  end
  else
  begin
    Files := TStringList.Create;
    if not (S_P[1] in ['A', 'B']) then
      LoadFiles(S_P)
    else if not ReadFileSetup then
      while True do
      begin
        if InformationMessage('œÌ”ﬂ  „⁄ »— ‰Ì” . œÌ”ﬂ  ‘„«—Â 1 —« ﬁ—«— œÂÌœ.') <> mrOK then
        begin
          ReStore := False;
          Exit;
        end
        else if ReadFileSetup then
          Break;
      end;

    T_Size := GetTotalSize_List;
    F_Size := GetFreeSize(T_P);
    if (T_Size > F_Size) and not (T_P[1] in ['A', 'B']) then
    begin
      ErrorMessage('œ—«ÌÊ „ﬁ’œ «‰ Œ«» ‘œÂ œ«—«Ì ›÷«Ì ﬂ«›Ì ‰„Ìù»«‘œ.');
      ReStore := False;
    end
    else if (not (T_P[1] in ['A', 'B']) and not NextDisk) or
            ((T_Size < F_Size) and (T_P[1] in ['A', 'B'])) then
      Restore := CopyHard
    else
      ReStore := CopyFromDiskets;
  end;
end;

function TfrmCpyAnyDsk.CopyFromDiskets : Boolean;
var
  RetValid : Boolean;
begin
{$I-}
  ChDir(T_P);
{$I+}
  if IOResult <> 0 then
  begin
    if ConfirmMessage('‘«ŒÂ „Ê—œ ‰Ÿ— ÊÃÊœ ‰œ«—œ. ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« «ÌÃ«œ ‰„«ÌÌœø') then
    begin
       if not CreatePath(T_P) then
       begin
         ErrorMessage('«ÌÃ«œ ‘«ŒÂ „Ì”— ‰Ì” .');
         CopyFromDiskets := False;
         Exit;
       end;
    end
    else
    begin
      CopyFromDiskets := False;
      Exit;
    end;
  end;

  CopyFromDiskets := True;
  RetValid := False;
  while not RetValid do
  begin
    if (DiskNo = 1) or ReadFileSetup then
    begin
      if not Showing then
      begin
        Show;
        Animate1.Active := True;
      end;
      while Top < n do
      begin
        lblSource.Caption := Files.Strings[0];
        lblTarget.Caption := FList[Top];
        Refresh;
        if Pos('...', Files.Strings[0]) > 0 then
        begin
          if not MergFiles then
          begin
            ErrorMessage('Ã„⁄ »‰œÌ ›«Ì·Â« «„ﬂ«‰Å–Ì— ‰Ì” .');
            RetValid := True;
            CopyFromDiskets := False;
            Break;
          end;
        end
        else
        begin
          if not FileCopy(lblSource.Caption, lblTarget.Caption) then
          begin
            ErrorMessage('ﬂÅÌ ﬂ—œ‰ ›«Ì·Â« «„ﬂ«‰Å–Ì— ‰Ì” .');
            RetValid := True;
            CopyFromDiskets := False;
            Break;
          end
          else
          begin
            Inc(Top);
            Files.Delete(0);
          end;
        end;
      end;
      if not NextDisk then
        RetValid := True
      else if not RetValid then
      begin
        Inc(DiskNo);
        Hide;
        if InformationMessage('œÌ”ﬂ  ‘„«—Â ' + IntToStr(DiskNo) + ' —« ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.') <> mrOK then
        begin
          RetValid := True;
          CopyFromDiskets := False;
        end;
      end;
    end
    else
      if InformationMessage('œÌ”ﬂ  „⁄ »— ‰Ì” . ·ÿ›√ œÌ”ﬂ  „Ã«“ —« ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.') <> mrOK then
      begin
        RetValid := True;
        CopyFromDiskets := False;
      end;
  end;
  Close;
end;

function TfrmCpyAnyDsk.MergFiles : Boolean;
var
  In_f, Out_f : file;
  doRet, OK : Boolean;
  NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
  N_Merg : Integer;
begin
  N_Merg := 1;
{$I-}
  AssignFile(Out_f, FList[Top]);
  ReWrite(Out_f, 1);
  OK := (IOResult = 0);
  if OK then
  begin
    while True do
    begin
      Hide;
      if Pos('...', Files.Strings[0]) <> 0 then
        Files.Strings[0] := Copy(Files.Strings[0], 1, Length(Files.Strings[0])-3);
      AssignFile(In_f, Files.Strings[0]);
      Reset(In_f, 1);
      OK := (IOResult = 0);
      if not OK then
        Break;
      if not Showing then
        Show;
      lblSource.Caption := Files.Strings[0];
      lblTarget.Caption := FList[Top];
      Refresh;
      repeat
        BlockRead(In_f, Buf, SizeOf(Buf), NumRead);
        BlockWrite(Out_f, Buf, NumRead, NumWritten);
      until (NumRead = 0) or (NumWritten <> NumRead);
      CloseFile(In_f);
      Files.Delete(0);
      Inc(Top);
      Inc(N_Merg);

      if Files.Count > 0 then
        Break
      else
      begin
        if NextDisk then
        begin
          Hide;
          Inc(DiskNo);
          if InformationMessage('œÌ”ﬂ  ‘„«—Â ' + IntToStr(DiskNo) + ' —« œ«Œ· œ—«ÌÊ ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.' ) = mrOK then
          begin
            repeat
              OK := ReadFileSetup;
              if not OK then
              begin
                OK := (InformationMessage('œÌ”ﬂ  „⁄ »— ‰Ì” . œÌ”ﬂ  ‘„«—Â ' + IntToStr(DiskNo) + ' —« œ«Œ· œ—«ÌÊ ﬁ—«— œ«œÂ Ê  √ÌÌœ ‰„«ÌÌœ.' ) = mrOK);
                if not OK then
                  doRet := True
                else
                  doRet := False;
              end
              else
                doRet := True;
            until doRet;
            if not OK then
              Break;
            if Pos('...', Files.Strings[0]) = 0 then
            begin
              if N_Merg = 2 then
                OK := False;
              Break;
            end;
          end
          else
          begin
            OK := False;
            Break;
          end;
        end
        else
          Break;
      end;
    end;

  end;
{$I+}
  if OK then
    CloseFile(Out_f);
  MergFiles := OK;
end;



procedure TfrmCpyAnyDsk.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
