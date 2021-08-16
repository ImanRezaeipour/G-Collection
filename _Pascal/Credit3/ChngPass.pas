unit ChngPass;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Globals, MSGs;

type
  TfrmChangePassword = class(TForm)
    cmdOK: TBitBtn;
    txtUserName: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    txtBeforePassword: TEdit;
    cmdCancel: TBitBtn;
    lbl3: TLabel;
    txtNewPassword: TEdit;
    lbl4: TLabel;
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


var
  frmChangePassword : TfrmChangePassword;


implementation

uses
  DBS, Funcs, FntSel;

{$R *.DFM}

procedure TfrmChangePassword.SetWinF;
begin
  SetFontColor(TForm(frmChangePassword));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmChangePassword.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtUserName.Text := gOptions.UserName;
end;

procedure TfrmChangePassword.cmdOKClick(Sender: TObject);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Users');
    SQL.Add('WHERE User_Name = ''' + UpperCase(txtUserName.Text) + '''');
    SQL.Add('OR User_Name = ''' + txtUserName.Text + '''');
    Open;
    if EOF then
      ErrorMessage('ç‰Ì‰ ﬂ«—»—Ì ÊÃÊœ ‰œ«—œ.')
    else
    begin
      if (UpperCase(FieldByName('User_Password').AsString) <> UpperCase(txtBeforePassword.Text)) and
         (FieldByName('User_Password').AsString <> txtBeforePassword.Text) then
      begin
        ErrorMessage('ﬂ·„Â ⁄»Ê— ﬂ«—»— «‘ »«Â «” .');
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
        Edit;
        FieldByName('User_Password').AsString := txtNewPassword.Text;
        Post;
        frmDBS.adoQryG.Close;
        Self.Close;
      end;
    end;
    frmDBS.adoQryG.Close;
  end;
end;


end.
