unit ChngPass;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Globals, MSGs, ADODB, DosMove;

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
    adoQryLogin: TADOQuery;
    DosMove1: TDosMove;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

uses
  DBS, Funcs;

{$R *.DFM}


procedure TfrmChangePassword.FormCreate(Sender: TObject);
begin
  with adoQryLogin do
    Connection := frmDBS.DBConnection;
  txtUserName.Text := g_options.UserName;
end;

procedure TfrmChangePassword.cmdOKClick(Sender: TObject);
begin
  with adoQryLogin do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Security,users where Code = SecurityCode');
    SQL.Add('and '+ Upper_case + '(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
    SQL.Add('OR UserName = ''' + txtUserName.Text + '''');
    Open;
    if EOF then
      ErrorMessage('ç‰Ì‰ ﬂ«—»—Ì ÊÃÊœ ‰œ«—œ.')
    else
    begin
      if (UpperCase(CodingPassword(FieldByName('UserPassword').AsString)) <> UpperCase(txtBeforePassword.Text))
      and(CodingPassword(FieldByName('UserPassword').AsString) <> txtBeforePassword.Text)
      and not checkpass(txtBeforePassword.Text) 
//      and ('DPSOFTWARE' <> uppercase(txtBeforePassword.Text))
      then begin
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
        FieldByName('UserPassword').AsString := CodingPassWord(txtNewPassword.Text);
        Post;
        Close;
      end;
    end;
  end;
  Close;
end;


end.
