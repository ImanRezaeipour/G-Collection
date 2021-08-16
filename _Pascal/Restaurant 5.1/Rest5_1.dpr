program Rest5_1;
{$I features}

uses
  ExceptionLog,
  ComTools in 'ComTools.pas' {frmComTools},
  xpman,
  WinHelpViewer,
  Forms,
  SysUtils,
  Globals,
  MSGs,
  Logo,
  Login,
  DateProc,
  Code_Sys,
  Main,
  MakeDB,
  DBS_Proc in 'DBS_Proc.pas' {frmDBS},
  charge in 'charge.pas' {frmcharge},
  Parts in '..\..\Clock2.33\Clock2_33\Parts.pas' {frmParts},
  vt in '..\..\Clock2.33\Clock2_33\vt.pas',
  On_line in 'On_line.pas' {frmOnline},
  TCP_UDP in 'TCP_UDP.pas' {frmTcpUdp},
  GHSDK_TLB in '..\..\Shared\GHSDK_TLB.pas';
//  funcs in '..\..\Shared\funcs.pas', //kaveh
//  mscorlib_TLB in '..\..\Shared\mscorlib_TLB.pas'; //kaveh
{$R *.RES}
var
  Valid : Boolean;
  dbsErr: string;

function ChangePass(S_No : String) : String;
var
  PassWord : String;
  RndPass1, RndPass2,
  tmprndPass1, tmprndPass2, Base : SmallInt;
begin
  RndPass1 := StrToInt(Copy(S_No, 1, 4));
  RndPass2 := StrToInt(Copy(S_No, 5, 4));
  tmprndPass1 := RndPass1;
  tmprndPass2 := RndPass2;
  RndPass1 := tmprndPass1 div 100;
  RndPass1 := RndPass1 * 31;
  Base := RndPass1;
  if RndPass1 < 1000 then
    RndPass1 := RndPass1 + 1000;
  RndPass1 := RndPass1 mod 1000;
  RndPass1 := RndPass1 div 10;
  if RndPass1 < 10 then
    RndPass1 := RndPass1 + 10;
  if ((RndPass1 >= 65) and(RndPass1 <= 90)) or ((RndPass1 >= 97) and(RndPass1 <= 122)) then
    Password := Chr(RndPass1)
   else
     if (RndPass1 > 90) and (RndPass1 < 97) then
       PassWord := Chr(RndPass1 + 7)
      else
       begin
         RndPass1 := RndPass1 mod 10;
         PassWord := IntToStr(RndPass1);
       end;

  RndPass2 := tmprndPass2 mod 100;
  RndPass2 := RndPass2 * 27;
  if RndPass2 < 1000 then
    RndPass2 := RndPass2 + 1000;
  RndPass2 := RndPass2 mod 1000;
  RndPass2 := RndPass2 div 10;
  if RndPass2 < 10 then
    RndPass2 := RndPass2 + 10;
  if ((RndPass2 >= 65) and(RndPass2 <= 90)) or ((RndPass2 >= 97) and(RndPass2 <= 122)) then
    Password := PassWord + Chr(RndPass2)
   else
     if (RndPass2 > 90) and (RndPass2 < 97) then
       PassWord := PassWord + Chr(RndPass2 + 7)
      else
       begin
         RndPass2 := RndPass2 mod 10;
         PassWord := PassWord + IntToStr(RndPass2);
       end;

  Base := Base div 100;
  Base := Base * 19;
  if Base < 1000 then
    Base := Base + 1000;
  PassWord := PassWord + IntToStr(Base);
  ChangePass := UpperCase(PassWord);
end;

function ProgramIsValid1 : Boolean;
var
  f : file of Char;
  ch, XO, Sep : Char;
  n, i, l : Integer;
  data, S_No, PassWord : String;
  softwarecode1:integer;
  softwareversion : string;
  s : string;
begin
  Result := True;
  if FileExists(g_options.ProgramPath + 'ghadir.Lic') then
  begin
    AssignFile(f, g_options.ProgramPath + 'ghadir.Lic');
    Reset(f);
    Read(f, ch);
    n := Ord(ch) * 256;
    Read(f, ch);
    n := n + Ord(ch);
    Read(f, XO);
    Read(f, ch);
    l := Ord(ch);
    Read(f, Sep);

    data := '';
    Seek(f, n);
    for i := 1 to l do
    begin
      Read(f, ch);
      ch := Chr(Ord(ch) xor Ord(Xo));
      data := data + ch;
    end;

    l := AnsiPos(Sep, data);
    S_No := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    PassWord := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.CoName := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.Shobeh := Copy(data, 1, l-1);
    Delete(data, 1, l);

    {WinSysType := StrToInt(data);}

    l := AnsiPos(Sep, data);
//    WinSysType := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    softwarecode1 := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);
    if softwarecode1 <>softwarecode  then Result := False;

    l := AnsiPos(Sep, data);
    softwareversion := Copy(data, 1, l-1);
    Delete(data, 1, l);
    {
    isscript:=(copy(softwareversion,length(softwareversion),1)<>'0');
    if isscript
    then AppVersion[length(AppVersion)]:='1'
    else AppVersion[length(AppVersion)]:='0';
    }
    if softwareversion < AppVersion then result := False;

    l := AnsiPos(Sep, data);
    maxusers := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    logocode := Copy(data, 1, l-1);
    Delete(data, 1, l);
//    islogo:=checklogo;

    CloseFile(f);
    s := ChangePass(S_No);
    if s <> PassWord then Result := False;
  end
  else
    Result := False;
end;

function ProgramIsValid : Boolean;
var
  f : file of Char;
  ch, XO, Sep : Char;
  n, i, l : Integer;
  data, S_No, PassWord : String;
begin
  if FileExists(g_options.ProgramPath + 'DPCo.Lic') then
  begin
    AssignFile(f, g_options.ProgramPath + 'DPCo.Lic');
    Reset(f);
    Read(f, ch);
    n := Ord(ch) * 256;
    Read(f, ch);
    n := n + Ord(ch);
    Read(f, XO);
    Read(f, ch);
    l := Ord(ch);
    Read(f, Sep);

    data := '';
    Seek(f, n);
    for i := 1 to l do
    begin
      Read(f, ch);
      ch := Chr(Ord(ch) xor Ord(Xo));
      data := data + ch;
    end;

    l := AnsiPos(Sep, data);
    S_No := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    PassWord := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.CoName := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.Shobeh := Copy(data, 1, l-1);
    Delete(data, 1, l);

    g_options.WinType := StrToInt(data);

    CloseFile(f);
    if ChangePass(S_No) <> PassWord then
      ProgramIsValid := False
    else
      ProgramIsValid := True;
  end
  else
    ProgramIsValid := False;
end;

//read
function ProgramIsValid_new : Boolean;
var
  f : file of Char;
  ch, XO, Sep : Char;
  n, i, l : Integer;
  data,data1, S_No, PassWord : String;
  softwarecode1:integer;
  softwareversion : string;
  s : string;
begin
  Result := True;
  if FileExists(g_options.ProgramPath + 'ghadir.Lic') then
  begin
    AssignFile(f, g_options.ProgramPath + 'ghadir.Lic');
    Reset(f);
    Seek(f, 100);
    Read(f, ch);
    n := Ord(ch) * 256;
    Read(f, ch);
    n := n + Ord(ch);
    Read(f, XO);
    Read(f, ch);
    l := Ord(ch);
    Read(f, Sep);

    data1 := '';
    Seek(f, n);
    for i := 1 to l do
    begin
      Read(f, ch);
      data1 := data1 + ch;
    end;

    data := '';
    Seek(f, n+1000);
    for i := 1 to l do
    begin
      Read(f, ch);
      ch := Chr(Ord(ch) xor Ord(data1[i]));
      data := data + ch;
    end;
    closefile(f);

    l := AnsiPos(Sep, data);
    S_No := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    PassWord := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.CoName := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    g_options.Shobeh := Copy(data, 1, l-1);
    Delete(data, 1, l);

    {WinSysType := StrToInt(data);}

    l := AnsiPos(Sep, data);
//    WinSysType := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    softwarecode1 := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);
    if softwarecode1 <>softwarecode  then Result := False;

    l := AnsiPos(Sep, data);
    softwareversion := Copy(data, 1, l-1);
    Delete(data, 1, l);
    {
    isscript:=(copy(softwareversion,length(softwareversion),1)<>'0');
    if isscript
    then AppVersion[length(AppVersion)]:='1'
    else AppVersion[length(AppVersion)]:='0';
    }
    if softwareversion < AppVersion then result := False;

    l := AnsiPos(Sep, data);
    maxusers := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    logocode := Copy(data, 1, l-1);
    Delete(data, 1, l);
//    islogo:=checklogo;

//    CloseFile(f);
    s := ChangePass(S_No);
    if s <> PassWord then Result := False;
  end
  else
    Result := False;
end;


{ Main Procedure }
begin
  Application.Initialize;
  Application.Title := '”Ì” „ „ﬂ«‰Ì“Â —” Ê—«‰';
  InitialDelay;
  g_options.ProgramPath := ExtractFilePath(Application.ExeName);
  g_options.DataBasePath := g_options.ProgramPath;
  g_options.DB_MonthPath := g_options.ProgramPath + MONTH_PATH + '\';

//  if not ProgramIsValid then
//  if not ProgramIsValid1 then
  if not ProgramIsValid_new then
  begin
    ErrorMessage('»—‰«„Â „ÊÃÊœ ﬂÅÌ €Ì—„Ã«“ „Ìù»«‘œ Ê ﬁ«»· «Ã—« ‰Ì” .');
    Halt;
  end;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmDBS, frmDBS);
  Application.CreateForm(TfrmComTools, frmComTools);
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  if dbsInfo.dbsName <> '' then
  begin
    dbsErr := DBSConnect;
    if dbsErr <> '' then
    begin
      ErrorMessage(dbsErr);
      frmDBS.ShowModal;
      frmLogin.Timer1.Enabled := True;
    end;
  end
  else
  begin
    frmDBS.ShowModal;
    if frmDBS.retCode = 0 then
      frmLogin.Timer1.Enabled := True;
  end;
  appType := appResturant;

{$ifndef OperatorBase}
//kaveh 13910419  UpgradeTable('readers');

//kaveh is 13910419
//  if changedTbl('readers') then
  UpgradeTableOLD('readers');
//kaveh ie 13910419

{$endif OperatorBase}

  if not tblExists('Security') then
  begin
    ErrorMessage('»«‰ﬂ „—»Êÿ »Â «„‰Ì  «ÿ·«⁄«  ÊÃÊœ ‰œ«—œ.');
    halt;
  end;

//  IF AUTHORIZED then
  Application.Run;
end.



