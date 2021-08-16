unit ChngPass;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, AdoDB, Globals, MSGs;

type
  TfrmChangePassword = class(TForm)
    cmdOK: TBitBtn;
    txtUserName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtBeforePassword: TEdit;
    qryLogin: TAdoQuery;
    cmdCancel: TBitBtn;
    Label3: TLabel;
    txtNewPassword: TEdit;
    Label4: TLabel;
    txtRepeatPassword: TEdit;
    cmdHelp: TBitBtn;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses DBS_Proc;

{$R *.DFM}

procedure TfrmChangePassword.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmChangePassword.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryLogin.connection := frmDBS.DBConnection;
  txtUserName.Text := g_options.UserName;
end;

procedure TfrmChangePassword.cmdOKClick(Sender: TObject);
begin
  qryLogin.SQL.Clear;
  qryLogin.SQL.Add('SELECT * FROM Security');
  qryLogin.SQL.Add('WHERE UPPER(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
  qryLogin.SQL.Add('OR UserName = ''' + txtUserName.Text + '''');
  qryLogin.Open;
  if qryLogin.EOF then
    ErrorMessage('ç‰Ì‰ ﬂ«—»—Ì ÊÃÊœ ‰œ«—œ.')
  else
  begin
    if (UpperCase(CodingPassword(qryLogin.FieldByName('UserPassword').AsString)) <> UpperCase(txtBeforePassword.Text)) and
       (CodingPassword(qryLogin.FieldByName('UserPassword').AsString) <> txtBeforePassword.Text) then
    begin
      ErrorMessage('ﬂ·„Â ⁄»Ê— ﬂ«—»— «‘ »«Â «” ..');
      txtBeforePassword.SetFocus;
    end
    else if (UpperCase(txtNewPassword.Text) <> UpperCase(txtRepeatPassword.Text)) and
            (txtNewPassword.Text <> txtRepeatPassword.Text) then 
    begin
      ErrorMessage('ﬂ·„Â ⁄»Ê— ÃœÌœ »«  ﬂ—«— ¬‰ Ìﬂ”«‰ ‰Ì” .');
      txtRepeatPassword.SetFocus;
    end
    else
    begin
      qryLogin.Edit;
      qryLogin.FieldByName('UserPassword').AsString := CodingPassWord(txtNewPassword.Text);
      qryLogin.Post;
      qryLogin.Close;
      Close;
    end;
  end;
  qryLogin.Close;
end;


end.
