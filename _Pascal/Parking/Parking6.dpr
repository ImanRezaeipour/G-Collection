program Parking6;

uses
  Forms,
  SysUtils,
  Globals,
  MSGs,
  Logo,
  Login,
  DateProc,
  Code_Sys,
  Main,
  RdrStat in 'RdrStat.pas' {frmReaderState},
  DBS in 'DBS.pas' {frmDBS},
  CarStat in 'CarStat.pas' {frmCarsStatus},
  ComTools in '..\..\Shared\ComTools.pas' {frmComTools},
  TCP_UDP in '..\..\Shared\TCP_UDP.pas' {frmTcpUdp};

{$R *.RES}

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

function ProgramIsValid : Boolean;
var
  f : file of Char;
  ch, XO, Sep : Char;
  n, i, l : Integer;
  data, S_No, PassWord : String;
  softwarecode1:integer;
  softwareversion : string;

begin
  if FileExists(g_options.ProgramPath + 'Ghadir.Lic') then
  begin
    ProgramIsValid := True;
    AssignFile(f, g_options.ProgramPath + 'Ghadir.Lic');
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

{    g_options.WinType := StrToInt(data);   }

     {WinSysType := StrToInt(data);}

    l := AnsiPos(Sep, data);
{    WinSysType := StrToInt(Copy(data, 1, l-1)); }
    g_options.WinType := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    softwarecode1 := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);
    if softwarecode1 <> softwarecode  then ProgramIsValid := False;

    l := AnsiPos(Sep, data);
    softwareversion := Copy(data, 1, l-1);
    Delete(data, 1, l);
//    isscript:=(copy(softwareversion,length(softwareversion),1)<>'0');
//    if isscript
//    then AppVersion[length(AppVersion)]:='1'
//    else AppVersion[length(AppVersion)]:='0';
    if softwareversion <> AppVersion then ProgramIsValid := False;

    l := AnsiPos(Sep, data);
    maxusers := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    logocode := Copy(data, 1, l-1);
    Delete(data, 1, l);
//    islogo:=checklogo;

    CloseFile(f);
    if ChangePass(S_No) <> PassWord then
      ProgramIsValid := False
//    else
//      ProgramIsValid := True;
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
    g_options.WinType := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    softwarecode1 := StrToInt(Copy(data, 1, l-1));
    Delete(data, 1, l);
    if softwarecode1 <>softwarecode  then Result := False;

    l := AnsiPos(Sep, data);
    softwareversion := Copy(data, 1, l-1);
    Delete(data, 1, l);
//    isscript:=(copy(softwareversion,length(softwareversion),1)<>'0');
//    if isscript
//    then AppVersion[length(AppVersion)]:='1'
//    else AppVersion[length(AppVersion)]:='0';
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

function IsUserValid : Boolean;
var
  frmLogin : TfrmLogin;
  Valid : Boolean;
begin
//kaveh 880126  if not FileExists(g_options.ProgramPath + 'Security.DB') then
  if FileExists(g_options.ProgramPath + 'Security.DB') then
  begin
    ErrorMessage('»¬Ê‚ Â”»Á€ »Ë ¬ÂÊÈ  ¬€‰¬ﬁ¬  ÁÕÁ— Ê—¬”—.');
    IsUserValid := False;
  end
  else
  begin
//  Application.CreateForm(TfrmDBLogin, frmDBLogin);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmDBS, frmDBS);
  Application.CreateForm(TfrmCarsStatus, frmCarsStatus);
  Application.CreateForm(TfrmComTools, frmComTools);
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  frmLogin.ShowModal;
    Valid := frmLogin.LoginValid;
    if Valid then
    begin
      Application.CreateForm(TfrmLogo, frmLogo);
      frmLogo.ShowModal;
      frmLogo.Free;
    end;
    IsUserValid := Valid;
    frmLogin.Destroy;
  end;
end;

{ Main Procedure }
begin
  Application.Initialize;
  g_options.ProgramPath := ExtractFilePath(Application.ExeName);
  g_options.DataBasePath := g_options.ProgramPath;
  g_options.DB_MonthPath := g_options.ProgramPath + '\' + MONTH_PATH + '\';
  Application.HelpFile := 'E:\DP_Win_Prg\Parking\Ver6\MParking.hlp';
  if not ProgramIsValid_new then
  begin
//    ErrorMessage('»”Ê¬ÂË ÂÁÕÁ— ‚…È ﬂÈ”ÂÕ¬‘ ÂÈù»¬ÿ— Á ·¬»‰ ¬Õ”¬ ÊÈ÷ . —” ŸÁ”   Â¬È‰ »¬ ÿÂ¬”Ë ''8712451'' ÿ”‚  …”Á”ÿ —¬—ËùË¬  Â¬÷ »„È”È—. ');
    ErrorMessage('»—‰«„Â „ÊÃÊœ ﬂÅÌ €Ì—„Ã«“ „Ìù»«‘œ Ê ﬁ«»· «Ã—« ‰Ì” .');
    Halt;
  end
  else if IsUserValid then
    Application.CreateForm(TfrmMain, frmMain);

  case g_options.WinType of
    WIN_SINA_SYS:      Application.Title := '÷È÷ Â Â‚¬ÊÈ‘Ë …¬”‚ÈÊ„';
    WIN_MICROSOFT_SYS: Application.Title := '”Ì” „ „ﬂ«‰Ì“Â Å«—ﬂÌ‰ê';
  end;

  Application.HelpFile := 'E:\DP_Win_Prg\Parking\Ver6\MParking.hlp';
  Application.Run;
end.
