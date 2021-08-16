unit Users;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB, ADODB, globals,
  MSGs, funcs, DosMove;

type
  TfrmUsers = class(TForm)
    pnlSecurity: TPanel;
    dbgSecurity: TDBGrid;
    pnlUsers: TPanel;
    dbgUsers: TDBGrid;
    pnlEdit: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    txtUserName: TEdit;
    txtUserPassword: TEdit;
    cmdAdd: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    adoTblSecurity: TADOTable;
    dtaSecurity: TDataSource;
    adoTblUsers: TADOTable;
    dtaUsers: TDataSource;
    Bevel1: TBevel;
    lbl4: TLabel;
    chkEntery: TCheckBox;
    chkPrint: TCheckBox;
    Bevel2: TBevel;
    adoQry: TADOQuery;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure FormEditable(Editable : Boolean);
    procedure ControlsEnabled(enbl : Boolean);
    procedure _ClearFields;
    procedure _SetFields;
    procedure cmdEditClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    PartCode : string;
  end;


implementation

uses DBS, Math;

{$R *.dfm}

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  adoTblSecurity.Connection := frmDBS.DBConnection;
  dtaSecurity.DataSet := adoTblSecurity;
  adoTblSecurity.TableName := 'Security';
  adoTblSecurity.Open;
  adoTblSecurity.First;

  adoTblUsers.Connection := frmDBS.DBConnection;
  dtaUsers.DataSet := adoTblUsers;
  adoTblUsers.TableName := 'Users';
  adoTblUsers.Open;
  adoTblUsers.First;
end;

procedure TfrmUsers.cmdAddClick(Sender: TObject);
begin
  if (adoTblSecurity.FieldByName('Name').AsString = '„œÌ— ”Ì” „') then
    ErrorMessage('›ﬁÿ Ìò „œÌ— ”Ì” „ ﬁ«»·  ⁄—Ì› «” .')
  else
  begin
    FormEditable(True);
    txtUserName.SetFocus;
    ControlsEnabled(False);
    _ClearFields;
    with adoTblUsers do
      Append;
  end;
end;

procedure TfrmUsers.FormEditable(Editable: Boolean);
begin
  pnlSecurity.Enabled := not Editable;
  pnlUsers.Enabled := not Editable;
  pnlEdit.Visible := Editable;
  if Editable then
    Height := pnlSecurity.Height + pnlUsers.Height + pnlEdit.Height
  else
    Height := pnlSecurity.Height + pnlUsers.Height;
  Height := Height + 25;
end;

procedure TfrmUsers.ControlsEnabled(enbl: Boolean);
begin
  cmdAdd.Enabled := enbl;
  cmdEdit.Enabled := enbl;
  cmdDelete.Enabled := enbl;
  cmdExit.Enabled := enbl;
  dbgUsers.Enabled := enbl;
  dbgSecurity.Enabled := enbl;
end;

procedure TfrmUsers._ClearFields;
begin
  txtUserName.Text := '';
  txtUserPassword.Text := '';

  chkEntery.Checked := False;
  chkPrint.Checked := False;
end;

procedure TfrmUsers.cmdEditClick(Sender: TObject);
begin
  with adoTblUsers do
    if UpperCase(FieldByName('UserName').AsString) <> ADMIN_NAME then
    begin
      ControlsEnabled(False);
      _SetFields;
      Edit;
      FormEditable(True);
      txtUserName.SetFocus;
    end
    else
      ErrorMessage('„œÌ— ”Ì” „ ﬁ«»·  €ÌÌ— ‰Ì” .');
end;

procedure TfrmUsers._SetFields;
var MnuBar : Integer;
begin
  with adoTblUsers do
  begin
    _ClearFields;
    txtUserName.Text := FieldByName('UserName').AsString;
    txtUserPassword.Text := CodingPassword(FieldByName('UserPassword').AsString);

    chkEntery.Checked := FieldByName('Entery').AsBoolean;
    chkPrint.Checked := FieldByName('AccessPrint').AsBoolean;
  end;
end;

procedure TfrmUsers.cmdDeleteClick(Sender: TObject);
begin
  with adoTblUsers do
    if UpperCase(FieldByName('UserName').AsString) <> ADMIN_NAME then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø') then
        Delete;
    end
    else
      ErrorMessage('Õ–› „œÌ— ”Ì” „ «„ﬂ«‰ Å–Ì— ‰Ì” .');
end;

procedure TfrmUsers.FormActivate(Sender: TObject);
begin
  FormEditable(False);
end;

procedure TfrmUsers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  adoTblUsers.Close;
  adoTblSecurity.Close;
end;

procedure TfrmUsers.cmdSaveClick(Sender: TObject);
var i : Integer;
begin
  if txtUserName.Text = '' then
  begin
    ErrorMessage('‰«„ Ê«—œ ‰‘œÂ «” .');
    txtUserName.SetFocus;
  end
  else
  begin
    with adoQry do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('SELECT UserName FROM Users WHERE '+ Upper_case + '(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
      Open;
      if EOF or ((RecordCount = 1) and (UpperCase(adoTblUsers.FieldByName('UserName').AsString) = UpperCase(txtUserName.Text))) then
      begin
        Close;
        FormEditable(False);
        with adoTblUsers do
        begin
          FieldByName('UserName').AsString := txtUserName.Text;
          FieldByName('UserPassword').AsString := CodingPassWord(txtUserPassword.Text);
          FieldByName('Entery').AsBoolean := chkEntery.Checked;
          FieldByName('AccessPrint').AsBoolean := chkPrint.Checked;
          Post;
        end;
        ControlsEnabled(True);
        dbgUsers.SetFocus;
      end
      else
      begin
        Close;
        ErrorMessage('‰«„  ò—«—Ì «”  .');
        txtUserName.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmUsers.cmdCancelClick(Sender: TObject);
begin
  FormEditable(False);
  adoTblUsers.Cancel;
  ControlsEnabled(True);
  dbgUsers.SetFocus;
end;

end.

