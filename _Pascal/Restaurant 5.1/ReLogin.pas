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
    procedure cmdCancelClick(Sender: TObject);
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
  Code_Sys, DBS_proc, Funcs, Login, FntSel;



procedure TfrmReLogin.cmdOKClick(Sender: TObject);
begin
  Animat.Visible := True;
  Animat.Active := True;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Security');
    SQL.Add('WHERE UserName = ''' + UpperCase(txtUserName.Text) + '''');
    SQL.Add('OR UserName = ''' + txtUserName.Text + '''');
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
      if (UpperCase(FieldByName('UserPassword').AsString) = UpperCase(CodingPassWord(txtPassword.Text))) or
         (FieldByName('UserPassword').AsString = CodingPassWord(txtPassword.Text)) then
      begin
        if not FieldByName('Entery').AsBoolean then
        begin
          InformationMessage('Ê—Êœ ‘„« »Â ”Ì” „  Ê”ÿ „œÌ— ”Ì” „ „ÕœÊœ ‘œÂ «” !');
          LoginValid := False;
        end
        else
          LoginValid := True;

       g_options.UserName := FieldByName('UserName').AsString;
       g_options.AcesPrint := FieldByName('AccessPrint').AsBoolean;
       frmDBS.adoQryG.Close;

        Self.Close;
      end
      else
      begin
        if (UpperCase(txtUserName.Text) = ADMIN_NAME) and
           (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
        begin
          LoginValid := True;
          g_options.UserName := FieldByName('UserName').AsString;
          g_options.AcesPrint := FieldByName('AccessPrint').AsBoolean;
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

end.
