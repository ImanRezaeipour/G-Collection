program amanat;

uses
  ExceptionLog,
  Controls,
  Forms,
  xpMan,
  SysUtils,
  Globals,
  Logo,
  Login,
  makedb,
  ADODB,
  db,
  WinHelpViewer,
  Main in 'Main.pas' {frmMain},
  classes,
  Code_Sys in '..\..\Shared\Code_Sys.pas',
  DateProc in '..\..\Shared\DateProc.pas',
  TimeTool in '..\..\Shared\TimeTool.pas',
  Msgs in '..\..\Shared\Msgs.pas' {frmMsgBox},
  Farsiapi in '..\..\Shared\Farsiapi.pas',
  Keyboard in '..\..\Shared\Keyboard.pas',
  Z84_cmd in '..\..\Shared\Z84_cmd.pas',
  Z80_CMD in '..\..\Shared\Z80_CMD.pas',
  Modem in '..\..\Shared\Modem.pas' {frmModem},
  BackRstr in '..\..\Shared\BackRstr.pas' {frmBackupRestore},
  CpyDisks in '..\..\Shared\CpyDisks.pas' {frmCpyAnyDsk},
  Funcs in '..\..\Shared\Funcs.pas',
  RunCmnds in '..\..\Shared\RunCmnds.pas',
  DBLogin in 'DBLogin.pas' {frmDBLogin},
  DBS in 'DBS.pas' {frmDBS},
  Users in 'Users.pas' {frmUsers},
  TCP_UDP in '..\..\Shared\TCP_UDP.pas' {frmTcpUdp},
  request in 'request.pas' {frmRequest},
  ComTools in '..\..\Shared\ComTools.pas' {frmComTools};

{$R *.res}

function IsUserValid : Boolean;
var
  frmLogin : TfrmLogin;
  Valid : Boolean;
  adotbl : tadoTable;
  code : integer;
begin
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMsgBox, frmMsgBox);
  Application.CreateForm(TfrmCpyAnyDsk, frmCpyAnyDsk);
  Application.CreateForm(TfrmDBLogin, frmDBLogin);
  Application.CreateForm(TfrmDBS, frmDBS);
  Application.CreateForm(TfrmTcpUdp, frmTcpUdp);
  Application.CreateForm(TfrmRequest, frmRequest);
  Application.CreateForm(TfrmComTools, frmComTools);
  Application.CreateForm(TfrmComTools, frmComTools);
  if not tblExists('users') then
  begin
    if tblExists('security')
    then RenameTbl('security','_security');
    UpgradeTable('security');
    UpgradeTable('users');
  end;

  adoTbl := TAdoTable.Create(Application);
  adoTbl.Connection := frmDBS.DBConnection;
  adoTbl.TableName := 'Security';
  adoTbl.Open;
  if not adoTbl.Locate('Name','„œÌ— ”Ì” „',[loPartialKey]) then
  begin                   
    adoTbl.Append;
    Code := GetNewNumber('Security', 'Code');
    adoTbl.FieldByName('Code').AsInteger := code;
    adoTbl.FieldByName('Name').AsString := '„œÌ— ”Ì” „';
    adoTbl.Post;
  end;
  adoTbl.Close;
  adoTbl.TableName := 'Users';
  adoTbl.Open;
  if not adoTbl.Locate('UserName','Admin',[loPartialKey]) then
  begin
    adoTbl.Append;
    adoTbl.FieldByName('UserName').AsString := 'Admin';
    adoTbl.FieldByName('SecurityCode').AsInteger := Code;
    adoTbl.FieldByName('Entery').AsBoolean := True;
    adoTbl.FieldByName('AccessPrint').AsBoolean := True;
    adoTbl.Post;
  end;
  adoTbl.Free;
  LoadIniFileDB;
  if not tblExists('Readers')
    then UpgradeTable('readers');
  frmLogin.ShowModal;
  Valid := frmLogin.LoginValid;
  if Valid then
  begin
    Application.CreateForm(TfrmLogo, frmLogo);
    frmLogo.ShowModal;
    frmLogo.Free;
  end;
  IsUserValid := Valid;
  frmLogin.Free;

end;

{ Main Procedure }
begin
  Application.Initialize;
  g_options.ProgramPath := ExtractFilePath(Application.ExeName);
{$IFDEF Network}
  {$i-}
  chdir(dbpath);
  if ioresult<>0
  then begin
       chdir('c:');
       mkdir('c:\ghadirco');
       chdir('c:\ghadirco');
       mkdir('amanat');
       chdir('amanat');
  end;
  {$i+}
  getdir(0,g_options.DataBasePath);
  g_options.DataBasePath := g_options.DataBasePath+'\';
{$ELSE}
  g_options.DataBasePath := g_options.ProgramPath;
{$ENDIF}


  if IsUserValid then
    Application.CreateForm(TfrmMain, frmMain);

  Application.Title := '”Ì” „ „ﬂ«‰Ì“Â ’‰œÊﬁ «„«‰« ';
//  Application.HelpFile := 'E:\DP_Win_Prg\Clock2.33\Clock2_33\MCLOCK.HLP';
  Application.Run;
end.

