unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Menus, Globals, MSGs, ExtCtrls;

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
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbUsersKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    LoginNo : Integer;

  public
    { Public declarations }

  end;

var
  frmLogin : TfrmLogin;

const
  ADMIN_NAME = 'ADMIN';
  ADMIN_PASS = 'DPSOFTWARE';


implementation


{$R *.DFM}

uses
  Code_Sys, DBS, Funcs, ADODB, Logo, Main, Keyboard, FntSel;



procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  SetFontColor(TForm(frmLogin));

  cmbUsers.Clear;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT User_Name FROM Users ORDER BY User_Name');
    Open;
    while not Eof do
    begin
      cmbUsers.Items.Add(FieldByName('User_Name').AsString);
      Next;
    end;
    Close;
  end;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT UserName, UsedDate, UsedTime FROM UserStat');
    SQL.Add('ORDER BY UsedDate, UsedTime');
    Open;
    if recordcount > 0 then
    begin
      Last;
      cmbUsers.ItemIndex := cmbUsers.Items.IndexOf(FieldByName('UserName').AsString);
    end
    else
      cmbUsers.ItemIndex := 0;
    Close;
  end;
end;

procedure TfrmLogin.cmdOKClick(Sender: TObject);
begin
  if cmbUsers.Text = '' then
  begin
    ErrorMessage('‰«„ ﬂ«—»— Ê«—œ ‰‘œÂ «” .');
    cmbUsers.SetFocus;
  end
  else
  begin
    Animat.Visible := True;
    Animat.Active := True;
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM Users');
      SQL.Add('WHERE User_Name = ''' + UpperCase(cmbUsers.Text) + '''');
      SQL.Add('OR User_Name = ''' + cmbUsers.Text + '''');
      Open;
      if RecordCount = 0 then
      begin
        ErrorMessage('ﬂ«—»— »« ç‰Ì‰ ‰«„Ì  ⁄—Ì› ‰‘œÂ «” .');
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
        {
        if (UpperCase(FieldByName('User_Password').AsString) = UpperCase(txtPassword.Text)) or
           (FieldByName('User_Password').AsString = txtPassword.Text) then
        }
        if txtPassword.Text=decodingpass(FieldByName('User_Password').AsString) then
        begin
          if not FieldByName('User_Active').AsBoolean then
            InformationMessage('Ê—Êœ ‘„« »Â ”Ì” „  Ê”ÿ „œÌ— ”Ì” „ „ÕœÊœ ‘œÂ «” !')
          else
          begin
            Hide;
            try
              gOptions.UserName := FieldByName('User_Name').AsString;
              gOptions.UserDepart := FieldByName('User_Department').AsInteger;
            except;
            end;

            Application.CreateForm(TfrmLogo, frmLogo);
            frmLogo.ShowModal;
            frmLogo.Free;

            Application.CreateForm(TfrmMain, frmMain);
            frmMain.ShowModal;
            frmMain.Free;
          end;

          Close;

          frmLogin.Close;
        end
        else
        begin
          {
          if (UpperCase(cmbUsers.Text) = ADMIN_NAME) and
             (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
          }
          if checkpass(txtPassWord.Text) then
          begin
            try
              gOptions.UserName := FieldByName('User_Name').AsString;
              gOptions.UserDepart := FieldByName('User_Department').AsInteger;
            except
            end;

            Close;
            Hide;
            Application.CreateForm(TfrmLogo, frmLogo);
            frmLogo.ShowModal;
            frmLogo.Free;

            Application.CreateForm(TfrmMain, frmMain);
            frmMain.ShowModal;
            frmMain.Free;

            frmLogin.Close;
          end
          else
          begin
            ErrorMessage('ﬂ·„Â ⁄»Ê— «‘ »«Â «” .');
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

procedure TfrmLogin.cmbUsersKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
