program Credit4;



uses
  ExceptionLog,
  Forms,
  SysUtils,
  Globals,
  Code_Sys in '..\Shared\Code_Sys.pas',
  DateProc in '..\Shared\DateProc.pas',
  TimeTool in '..\Shared\TimeTool.pas',
  Farsiapi in '..\Shared\Farsiapi.pas',
  Keyboard in '..\Shared\Keyboard.pas',
  Z84_cmd in 'C:\Documents and Settings\Administrator\Desktop\Z84_cmd.pas',
  Z80_CMD in '..\Shared\Z80_CMD.pas',
  Funcs in '..\Shared\Funcs.pas',
  RunCmnds in '..\Shared\RunCmnds.pas',
  ComTools in '..\Shared\ComTools.pas' {frmComTools},
  Msgs in '..\Shared\Msgs.pas' {frmMsgBox},
  DBS in '..\Credit4\DBS.pas' {frmDBS},
  Login in '..\Credit4\Login.pas' {frmLogin},
  SelPath in '..\Shared\SelPath.pas' {frmSelPath},
  Online in '..\Credit4\Online.pas' {frmOnline},
  WinSetup in '..\Shared\WinSetup.pas' {frmWinSetup},
  Select in '..\Credit4\Select.pas' {frmSelect},
  FntSel in '..\Shared\FntSel.pas' {frmFont},
  DprtActv in '..\Credit4\DprtActv.pas' {frmDepartActive},
  ADODB_TLB in '..\Shared\ADODB_TLB.pas',
  ADOX_TLB in '..\Shared\ADOX_TLB.pas',
  frmlottar in '..\Credit4\frmlottar.pas' {Frmlotter},
  Frmbuy in '..\Credit4\Frmbuy.pas' {frmbuyRp},
  TCP_UDP in 'C:\Documents and Settings\Administrator\Desktop\TCP_UDP.pas' {frmTcpUdp};

{$R *.RES}


{ uncode data }
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

{ License checking}
function ProgramIsValid : Boolean;
var
  f : file of Char;
  ch, XO, Sep : Char;
  n, i, l : Integer;
  data, S_No, PassWord : String;
begin
  if FileExists(gOptions.ProgramPath + 'DPCO.Lic') then
  begin
    AssignFile(f, gOptions.ProgramPath + 'DPCO.Lic');
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
    gOptions.CoName := Copy(data, 1, l-1);
    Delete(data, 1, l);

    l := AnsiPos(Sep, data);
    gOptions.Shobeh := Copy(data, 1, l-1);
    Delete(data, 1, l);

    WinSysType := StrToInt(data);

    CloseFile(f);
    if ChangePass(S_No) <> PassWord then
      ProgramIsValid := False
    else
      ProgramIsValid := True;
  end
  else
    ProgramIsValid := False;
end;

var
  dbsErr : String;

{ Main Procedure }
begin
  Application.Initialize;
  gOptions.ProgramPath := ExtractFilePath(Application.ExeName);
  gOptions.DataBasePath := gOptions.ProgramPath;

  if not ProgramIsValid then
  begin
    Application.MessageBox('Invalid copy of software. Call to Ghadir Co. (021-88312732-4)', 'Error', 0);
    Halt;
  end;

  Application.Title := '”Ì” „ ﬂ«—  «⁄ »«—Ì';

  Application.HelpFile := 'E:\DP_Win_Prg\Credit4\CREDIT1.HLP';
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmDepartActive, frmDepartActive);
  Application.CreateForm(TfrmFont, frmFont);
  Application.CreateForm(TfrmDBS, frmDBS);
  Application.CreateForm(TfrmComTools, frmComTools);
  Application.CreateForm(TfrmMsgBox, frmMsgBox);
  Application.CreateForm(TfrmSelPath, frmSelPath);
  Application.CreateForm(TfrmOnline, frmOnline);
  Application.CreateForm(TFrmlotter, Frmlotter);
  Application.CreateForm(TfrmbuyRp, frmbuyRp);
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  if dbsInfo.dbsName <> '' then
  begin
    dbsErr := DBSConnect;
    if dbsErr <> '' then
    begin
      ErrorMessage(dbsErr);
      frmDBS.ShowModal;
      if frmDBS.retCode = 0 then
        frmLogin.Timer1.Enabled := True;
    end;
  end
  else
  begin
    frmDBS.ShowModal;
    if frmDBS.retCode = 0 then
      frmLogin.Timer1.Enabled := True;
  end;

  Application.Run;
end.
