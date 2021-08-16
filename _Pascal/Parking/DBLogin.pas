unit DBLogin;
//{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, ComCtrls, StdCtrls, Buttons, DB, ADODB ,DosMove
  { {$ifdef webClock}{,ServerController, UserSessionUnit}{ {$ELSE}, DBS{ {$ENDIF};

type
  TfrmDBLogin = class(TForm)
    grpServer: TGroupBox;
    lblServer: TLabel;
    txtServer: TEdit;
    lbl1: TLabel;
    Label2: TLabel;
    lbl2: TLabel;
    adoQryLogin: TADOQuery;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    Animat: TAnimate;
    lblSqlUser: TLabel;
    txtSqlUser: TEdit;
    txtSqlPass: TEdit;
    lblSQLPass: TLabel;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    txtdatabase: TEdit;
    lbldatabase: TLabel;
    procedure txtdatabaseChange(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtServerChange(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DBLinkTest : boolean;
  function CheckConnection : boolean;overload;
  function CheckConnection(AppPath: string): boolean;overload;

var
  frmDBLogin: TfrmDBLogin;

implementation
uses
  globals, login, Funcs,msgs;

{$R *.dfm}

function DBLinkTest : boolean;
begin
  if CheckConnection then
  begin
    result := True;
    SaveDBIniFile;
  end
  else
  begin
    Application.CreateForm(TfrmDBLogin , frmDBLogin);
    if frmDBLogin.ShowModal = mrOK then
    begin
      Result := true;
      //{$ifndef Z84SDK}
      frmDBLogin.Free;
      //{$endif}
    end
    else
      Result := false;
  end;
end;

function CheckConnection : boolean;
begin
  LoadDBIniFile;
  with frmDBS.adoConnect do
  begin
    close;
    ConnectionString := GetConnectionString;
    LoginPrompt := false;
    ConnectionTimeout := 3;
    try
      open;
      Result := Connected;
    except
      Result := false;
    end;
  end;
end;

function CheckConnection(AppPath: string) : boolean;
begin
  LoadDBIniFile(AppPath);
  with frmDBS.adoConnect do
  begin
    close;
    ConnectionString := GetConnectionString;
    LoginPrompt := false;
    ConnectionTimeout := 3;
    try
      open;
      Result := true;
    except
      Result := false;
    end;
  end;
end;

procedure TfrmDBLogin.cmdOKClick(Sender: TObject);
begin
  lbl1.Hide;
  lbl2.Hide;
  Animat.show;
  Animat.Active := true;

  F_Params.ServerName := txtServer.Text;
  F_Params.sqlUseName := txtSqlUser.Text;
  F_Params.sqlPassword := txtSqlPass.Text;
  F_Params.DataBaseName := txtdatabase.Text;
  SaveDBIniFile;
  if CheckConnection then
    ModalResult := mrOK;
//  Animat.Active := false;
  Animat.Hide;
  lbl1.show;
  lbl2.Show;
end;

procedure TfrmDBLogin.FormActivate(Sender: TObject);
begin
  LoadDBIniFile;
  txtServer.Text := F_Params.ServerName;
  txtSqlUser.Text := F_Params.sqlUseName;
  txtSqlPass.Text := F_Params.sqlPassword;
  txtDataBase.Text := F_Params.DataBaseName;
  if txtDataBase.Text = '' then 
    txtDataBase.Text := 'Parking';
  if txtServer.Text = '' then
    cmdOK.Enabled := False;

//{$IFDEF Network}
//{$ELSE}
{  txtserver.Visible:=false;
  txtsqluser.Visible:=false;
  txtsqlpass.Visible:=false;
  txtdatabase.Visible:=false;
  lblserver.Visible:=false;
  lblsqluser.Visible:=false;
  lblsqlpass.Visible:=false;
  lbldatabase.Visible:=false;
  lbl1.Caption:='فایل parking.mdb خراب شده است';
  lbl2.Caption:='یا وجود ندارد'; }
//{$ENDIF}

end;

procedure TfrmDBLogin.txtServerChange(Sender: TObject);
begin
  if txtServer.Text <> '' then
    cmdOK.Enabled := True
  else
    cmdOK.Enabled := False;
end;

procedure TfrmDBLogin.cmdCancelClick(Sender: TObject);
begin
  {$IFDEF Z84SDK}
  frmDBLogin.Close;
  {$ELSE}
  Application.Terminate;
  {$ENDIF}
end;

procedure TfrmDBLogin.txtdatabaseChange(Sender: TObject);
begin
  if txtdatabase.Text <> '' then
    cmdOK.Enabled := True
  else
    cmdOK.Enabled := False;
end;

end.

