unit DBLogin;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, ComCtrls, StdCtrls, Buttons, DB, ADODB ,{$ifdef webClock}UserSessionUnit{$else}DBS_Proc {$endif};

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
    ADOTable1: TADOTable;
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
  function CheckConnection : boolean;

var
  frmDBLogin: TfrmDBLogin;

implementation
uses
  globals{$IFNDEF Restaurant} ,login{$ENDIF}, Funcs;

{$R *.dfm}

function DBLinkTest : boolean;
begin
  if CheckConnection then
  begin
    result := True;
    SaveIniFile;
  end
  else
  begin
    Application.CreateForm(TfrmDBLogin , frmDBLogin);
    if frmDBLogin.ShowModal = mrOK then
    begin
      Result := true;
      frmDBLogin.Free;
    end
    else
      Result := false;

  end;
end;

function CheckConnection : boolean;
begin
  LoadIniFile;
  with frmDBS.DBConnection  do
  begin
    close;
    ConnectionString := dtaSrc;
    LoginPrompt := false;
    ConnectionTimeout := 15;
    CommandTimeout := 30;
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

//  F_Params.ServerName := txtServer.Text;
//  F_Params.sqlUseName := txtSqlUser.Text;
//  F_Params.sqlPassword := txtSqlPass.Text;
  SaveIniFile;
  if CheckConnection then
    ModalResult := mrOK;
  Animat.Active := false;
  Animat.Hide;
  lbl1.show;
  lbl2.Show;
end;

procedure TfrmDBLogin.FormActivate(Sender: TObject);
begin
  LoadIniFile;
//  txtServer.Text := F_Params.ServerName;
//  txtSqlUser.Text := F_Params.sqlUseName;
//  txtSqlPass.Text := F_Params.sqlPassword;
  if txtServer.Text = '' then
    cmdOK.Enabled := False;
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
  Application.Terminate;
end;

end.

