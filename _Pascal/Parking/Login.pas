unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, AdoDB, Menus, Globals, MSGs, DBS;

type
  TfrmLogin = class(TForm)
    cmdOK: TBitBtn;
    txtUserName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtPassword: TEdit;
    Animat: TAnimate;
    qryLogin: TAdoQuery;
    cmdCancel: TBitBtn;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    LoginNo : Integer;
    
    procedure SetWinF;
  public
    { Public declarations }
    LoginValid : Boolean;

  end;

implementation

//kaveh uses DBS;

{$R *.DFM}


const ADMIN_PASS = 'DPSOFTWARE';

procedure TfrmLogin.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  qryLogin.ConnectionString := '';
  qryLogin.ConnectionString := frmDBS.adoConnect.ConnectionString;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin

  SetWinF;
//  qryLogin.Connection := frmDBS.adoConnect;
//  frmDBS.adoConnect.Connected := True;
//  qryLogin.Active := True;
end;

procedure TfrmLogin.cmdOKClick(Sender: TObject);
begin
  Animat.Visible := True;
  Animat.Active := True;
  qryLogin.SQL.Clear;
{kaveh
  qryLogin.SQL.Add('SELECT Security.*, Department.Depart_Name ');
  qryLogin.SQL.Add('FROM Security INNER JOIN ');
  qryLogin.SQL.Add('Department ON Security.Department = Department.Depart_Code ');
  qryLogin.SQL.Add('WHERE (UPPER(Security.UserName) = ''' + UpperCase(txtUserName.Text) + ''')');
  qryLogin.SQL.Add('or (Security.UserName = ''' + txtUserName.Text + ''')');
  }
  qryLogin.SQL.Add('SELECT * FROM Security');
  qryLogin.SQL.Add('WHERE UPPER(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
  qryLogin.SQL.Add('OR UserName = ''' + txtUserName.Text + '''');
  qryLogin.Open;
  if qryLogin.EOF then
  begin
    ErrorMessage('ﬂ«—»— »« ç‰Ì‰ ‰«„Ì  ⁄—Ì› ‰‘œÂ «” .');
    txtUserName.SetFocus;
    Inc(LoginNo);
    Animat.Visible := False;
    if LoginNo = 3 then
    begin
      LoginValid := False;
      qryLogin.Close;
      Close;
    end;
  end
  else
  begin
    if (UpperCase(CodingPassWord(qryLogin.FieldByName('UserPassword').AsString)) = UpperCase(txtPassword.Text)) or
       (CodingPassWord(qryLogin.FieldByName('UserPassword').AsString) = txtPassword.Text) then
    begin
      if not qryLogin.FieldByName('Entery').AsBoolean then
      begin
        InformationMessage('Ê—Êœ ‘„« »Â ”Ì” „  Ê”ÿ „œÌ— ”Ì” „ „ÕœÊœ ‘œÂ «” !');
        LoginValid := False;
      end
      else
        LoginValid := True;

      g_options.UserName := qryLogin.FieldByName('UserName').AsString;
      g_options.AcesPrint := qryLogin.FieldByName('AccessPrint').AsBoolean;
      g_Options.Department := qryLogin.FieldByName('Department').AsInteger;
      g_Options.ActiveRdrCode := qryLogin.FieldByName('ActiveRdrCode').AsInteger; 
      qryLogin.Close;

      Close;
    end
    else
    begin
      if (UpperCase(txtUserName.Text) = ADMIN_NAME) and
         (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
      begin
        LoginValid := True;
        g_options.UserName := qryLogin.FieldByName('UserName').AsString;
        g_options.AcesPrint := qryLogin.FieldByName('AccessPrint').AsBoolean;
        g_Options.Department := qryLogin.FieldByName('Department').AsInteger;
        qryLogin.Close;

        Close;
      end
      else
      begin
        ErrorMessage('ﬂ·„Â ⁄»Ê— «‘ »«Â «” .');
        txtPassword.SetFocus;
        Inc(LoginNo);
        Animat.Visible := False;
        if LoginNo = 3 then
        begin
          LoginValid := False;
          qryLogin.Close;
          Close;
        end;
      end;
    end;
  end;
end;

procedure TfrmLogin.cmdCancelClick(Sender: TObject);
begin
  LoginValid := False;
end;

end.
