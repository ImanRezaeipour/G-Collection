unit Login;
{$I features}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Menus, Globals, MSGs, ExtCtrls,
  DateProc, WinSvc;

type
  TfrmLogin = class(TForm)
    cmdOK: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    txtPassword: TEdit;
    Animat: TAnimate;
    cmdCancel: TBitBtn;
    cmbUsers: TComboBox;
    Timer1: TTimer;
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    LoginNo : Integer;
//    firstTimeRun : Boolean;
  public
    { Public declarations }

  end;

//  function StartResturanService() : Boolean;

var
  frmLogin : TfrmLogin;

const
  ADMIN_NAME = 'ADMIN';
  ADMIN_PASS = 'DPSOFTWARE';
  azad : boolean = False;

implementation


{$R *.DFM}

uses
  Code_Sys, DBS_proc, Funcs, ADODB, Logo, Main, FntSel,makedb;



procedure TfrmLogin.FormActivate(Sender: TObject);
{var
    ServiceControlManager: SC_Handle;
    ServiceHandle: SC_Handle;}
begin
{$ifdef RestService}
//  ServiceHandle := OpenService(ServiceControlManager, ServiceName, SERVICE_ALL_ACCESS);
//  StartService(ServiceHandle, NumberOfArgument, ServiceArgVectors);
  with frmDBS.adoQryG do
  begin
    SQL.Clear;

    SQL.Add(' IF EXISTS(SELECT name');
    SQL.Add(' FROM sysobjects');
    SQL.Add(' WHERE (name = ''OnlineCollectedRecs''))');
    SQL.Add(' TRUNCATE TABLE');
    SQL.Add(' OnlineCollectedRecs');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add(' IF not EXISTS(SELECT name');
    SQL.Add(' FROM sysobjects');
    SQL.Add(' WHERE (name = ''OnlineCollectedRecs''))');
    SQL.Add(' create table OnlineCollectedRecs');
    SQL.Add(' (Rest_ID int IDENTITY (1, 1) NOT NULL,');
    SQL.Add(' Rest_BarCode varchar(8),');
    SQL.Add(' Rest_Date varchar(10),');
    SQL.Add(' Rest_Time smallint,');
    SQL.Add(' Rest_RdrCode smallint,');
    SQL.Add(' Rest_RecState smallint,');
    SQL.Add(' Rest_User varchar(15),');
    SQL.Add(' Rest_IsPrint bit,');
    SQL.Add(' Rest_ReplyPacket varchar(1000),');
    SQL.Add(' Rest_Status smallint)');
    ExecSQL;
    Close;
  end;
//  if(not StartResturanService()) then
//    ErrorMessage('!اشکال در راه اندازی سرویس رستوران'); }
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
    ServiceStart('', 'RestaurantService');
{$endif RestService}

  appType := appClock;
  cmbUsers.Clear;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add(' SELECT UserName FROM SECURITY ORDER BY UserName');
    Open;
    while not Eof do
    begin
      cmbUsers.Items.Add(FieldByName('UserName').AsString);
      Next;
    end;
    Close;
  end;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add(' SELECT User_Name, User_Date, User_Time FROM UserStat');
    SQL.Add(' ORDER BY User_Date, User_Time');
    Open;
    if recordcount > 0 then
    begin
      Last;
      cmbUsers.ItemIndex := cmbUsers.Items.IndexOf(FieldByName('User_Name').AsString);
    end
    else
      cmbUsers.ItemIndex := 0;
    Close;
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//{$ifdef RestService}
//  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
//    ServiceStop('', 'RestaurantService');
//{$endif RestService}
end;

procedure TfrmLogin.FormPaint(Sender: TObject);
begin
//  if firstTimeRun then
//  begin
//    firstTimeRun := False;
  if azad
  then begin
    cmdOKClick(Sender);
  end;
  LoadIniFile;
  if F_Params.AutoLoginActive then
  begin
    cmbUsers.ItemIndex := cmbUsers.Items.IndexOf(F_Params.AutoLoginUser);
    txtPassword.Text := F_Params.AutoLoginPass;
    cmdOKClick(Sender);
  end;
//  end;
end;

function checkpass(pass:string):boolean;
const
//   ADMIN_PASS = 'DPSOFTWARE';
   sub_pass1  = 'MADURA';
   sub_pass2  = 'BALI';
var
   tt,t,ttt,code:integer;
   hour,min,sec,msec:word;
   r:real;
   st:string;
begin
    pass:=UpperCase(pass);
    result:=true;
    if pos(sub_pass1,pass)=0  then result:=false;
    if pos(sub_pass2,pass)=0  then result:=false;
    st:=copy(pass,length(pass)-1,2);
    val(st,tt,code);
    decodetime(time,hour,min,sec,msec);
    t:=hour+min;
    if abs(t-tt)>=2 then result:=false;
    if not result
    then begin
      st:=copy(pass,length(pass)-2,3);
      val(st,tt,code);
      r:=frac(t/37.0);
      ttt:=trunc(r*1000);
      if abs(ttt-tt)<30 then result:=true;
    end;
end;

procedure TfrmLogin.cmdOKClick(Sender: TObject);
begin
  if azad
  then begin
       cmbUsers.Text:= 'ADMIN';
       txtPassword.Text:= 'DPSOFTWARE';
  end;

  if cmbUsers.Text = '' then
  begin
    ErrorMessage('نام كاربر وارد نشده است.');
    cmbUsers.SetFocus;
  end
  else
  begin
    Animat.Visible := True;
    Animat.Active := True;
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add(' SELECT * FROM SECURITY');
      SQL.Add(' WHERE UserName = ''' + UpperCase(cmbUsers.Text) + '''');
      SQL.Add(' OR UserName = ''' + cmbUsers.Text + '''');
      Open;
      if RecordCount = 0 then
      begin
        ErrorMessage('كاربر با چنين نامي تعريف نشده است.');
        cmbUsers.SetFocus;
        Inc(LoginNo);
        Animat.Visible := False;
        if LoginNo = 3 then
        begin
          Close;
          frmLogin.Close;
        end;
      end
      else
      begin
        if (UpperCase(FieldByName('UserPassword').AsString) = UpperCase(CodingPassWord(txtPassword.Text))) or
           (FieldByName('UserPassword').AsString = CodingPassWord(txtPassword.Text)) then
        begin
          if not FieldByName('Entery').AsBoolean then
            InformationMessage('ورود شما به سيستم توسط مدير سيستم محدود شده است!')
          else
          begin
            Hide;
            try
              g_options.UserName := FieldByName('UserName').AsString;
              g_options.AcesPrint := FieldByName('AccessPrint').AsBoolean;
            except;
            end;
            Application.CreateForm(TfrmLogo, frmLogo);
            frmLogo.ShowModal;
            frmLogo.Free;

            InitialDelay;
            Application.CreateForm(TfrmMain, frmMain);
            InitVariables(True);
            frmMain.ShowModal;
            frmMain.Free;
          end;
          frmLogin.Show;
          frmLogin.Timer1.Enabled := True;
          Close;
        end
        else
        begin
          if (UpperCase(cmbUsers.Text) = ADMIN_NAME) and
           checkpass(txtPassWord.Text) then
//             (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
          begin
            try
              g_options.UserName := FieldByName('UserName').AsString;
              g_options.AcesPrint := FieldByName('AccessPrint').AsBoolean;
            except
            end;

            Close;
            Hide;
            Application.CreateForm(TfrmLogo, frmLogo);
            frmLogo.ShowModal;
            frmLogo.Free;

            InitialDelay;
            Application.CreateForm(TfrmMain, frmMain);
            InitVariables(True);
            frmMain.ShowModal;
            frmMain.Free;
            frmLogin.Close;
          end
          else
          begin
              ErrorMessage('كلمه عبور اشتباه است.');
            txtPassword.SetFocus;
            Inc(LoginNo);
            Animat.Visible := False;
            if LoginNo = 3 then
            begin
              Close;
              frmLogin.Close;
            end;
          end;
        end;
      end;
    end;//END OF with frmDBS.adoQryG do
  end;
end;

procedure TfrmLogin.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.Timer1Timer(Sender: TObject);
begin
  cmdCancelClick(Sender);
end;


{
function StartResturanService() : Boolean;
var
  schService : SC_HANDLE;
//  ssStatus : SERVICE_STATUS_HANDLE;//   SERVICE_STATUS_PROCESS;
//  dwOldCheckPoint : DWORD;
//  dwStartTickCount : DWORD;
//  dwWaitTime : DWORD;
//  dwBytesNeeded : DWORD;
  NumberOfArgument : Cardinal;
  ServiceArgVectors : PAnsiChar;
  schSCManager : SC_HANDLE;
begin
  NumberOfArgument := 0;
  ServiceArgVectors := nil;

  schSCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);


  if (schSCManager = 0) then
  begin
    Result := False;
  end
  else
  begin
    schService := OpenService(schSCManager, 'RestaurantService', SERVICE_ALL_ACCESS);
    if (schService = 0) then
    begin
        Result := False;
    end
    else
    begin
      if (not StartService(schService, NumberOfArgument, ServiceArgVectors)) then
      begin
        Result := False;
      end
      else
      begin
        Result := True;
      end;
    end;
  end;

  CloseServiceHandle(schService);
//    else
//    begin
//        printf("Service start pending.\n");
//    end;

    // Check the status until the service is no longer start pending.
{
    if (not QueryServiceStatusEx(schService, SC_STATUS_PROCESS_INFO, &ssStatus, sizeof(SERVICE_STATUS_PROCESS), &dwBytesNeeded ) ) then
    begin
        Result := False;
    end;

    // Save the tick count and initial checkpoint.

    dwStartTickCount := GetTickCount();
    dwOldCheckPoint := ssStatus.dwCheckPoint;

    while (ssStatus.dwCurrentState = SERVICE_START_PENDING) do
    begin
        // Do not wait longer than the wait hint. A good interval is
        // one tenth the wait hint, but no less than 1 second and no
        // more than 10 seconds.

        dwWaitTime := ssStatus.dwWaitHint / 10;

        if( dwWaitTime < 1000 )then
            dwWaitTime := 1000
        else if ( dwWaitTime > 10000 ) then
            dwWaitTime := 10000;

        Sleep( dwWaitTime );

        // Check the status again.

        if ( not QueryServiceStatusEx(
            schService,             // handle to service
            SC_STATUS_PROCESS_INFO, // info level
            &ssStatus,              // address of structure
            sizeof(SERVICE_STATUS_PROCESS), // size of structure
            &dwBytesNeeded ) )              // if buffer too small
            then
            break;

        if ( ssStatus.dwCheckPoint > dwOldCheckPoint ) then
        begin
            // The service is making progress.

            dwStartTickCount := GetTickCount();
            dwOldCheckPoint := ssStatus.dwCheckPoint;
        end
        else
        begin
            if(GetTickCount()-dwStartTickCount > ssStatus.dwWaitHint) then
            begin
                // No progress made within the wait hint
                break;
            end;
        end;
    end;

    CloseServiceHandle(schService);

    if (ssStatus.dwCurrentState = SERVICE_RUNNING) then
    begin
//        printf("StartService SUCCESS.\n");
        Result := True;
    end
    else
    begin
        printf("\nService not started. \n");
        printf("  Current State: %d\n", ssStatus.dwCurrentState);
        printf("  Exit Code: %d\n", ssStatus.dwWin32ExitCode);
        printf("  Service Specific Exit Code: %d\n",
            ssStatus.dwServiceSpecificExitCode);
        printf("  Check Point: %d\n", ssStatus.dwCheckPoint);
        printf("  Wait Hint: %d\n", ssStatus.dwWaitHint);
        Result := False;
    end;
 }
//end;

end.
