unit ReLogin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Menus, Globals, MSGs;

type
  TfrmReLogin = class(TForm)
    cmdOK: TBitBtn;
    txtUserName: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    txtPassword: TEdit;
    Animat: TAnimate;
    cmdCancel: TBitBtn;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtUserNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    LoginNo : Integer;

  public
    { Public declarations }
    LoginValid : Boolean;

  end;


var
  frmReLogin : TfrmReLogin;


implementation

{$R *.DFM}

uses
  Code_Sys, DBS, Funcs, Login, Keyboard, FntSel;



procedure TfrmReLogin.FormCreate(Sender: TObject);
begin
  SetFontColor(TForm(frmReLogin));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmReLogin.cmdOKClick(Sender: TObject);
begin
  Animat.Visible := True;
  Animat.Active := True;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Users');
    SQL.Add('WHERE User_Name = ''' + UpperCase(txtUserName.Text) + '''');
    SQL.Add('OR User_Name = ''' + txtUserName.Text + '''');
    Open;
    if RecordCount = 0 then
    begin
      ErrorMessage('ﬂ«—»— »« ç‰Ì‰ ‰«„Ì  ⁄—Ì› ‰‘œÂ «” .');
      txtUserName.SetFocus;
      Inc(LoginNo);
      Animat.Visible := False;
      if LoginNo = 3 then
      begin
        LoginValid := False;
        frmDBS.adoQryG.Close;
        Self.Close;
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
        begin
          InformationMessage('Ê—Êœ ‘„« »Â ”Ì” „  Ê”ÿ „œÌ— ”Ì” „ „ÕœÊœ ‘œÂ «” !');
          LoginValid := False;
        end
        else
          LoginValid := True;

        gOptions.UserName := FieldByName('User_Name').AsString;
        gOptions.UserDepart := FieldByName('User_Department').AsInteger;
        frmDBS.adoQryG.Close;

        Self.Close;
      end
      else
      begin
        {
        if (UpperCase(txtUserName.Text) = ADMIN_NAME) and
           (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
        }
        if checkpass(txtPassWord.Text) then
        begin
          LoginValid := True;
          gOptions.UserName := FieldByName('User_Name').AsString;
          gOptions.UserDepart := FieldByName('User_Department').AsInteger;
          frmDBS.adoQryG.Close;

          Self.Close;
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
            frmDBS.adoQryG.Close;
            Self.Close;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmReLogin.cmdCancelClick(Sender: TObject);
begin
  LoginValid := False;
end;

procedure TfrmReLogin.txtUserNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
