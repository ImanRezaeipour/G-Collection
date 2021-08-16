unit Admin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, Mask,
  DBCtrls, Menus, Math, ADODB, CheckLst, DosMove;

type
  TfrmAdmin = class(TForm)
    pnlUsers: TPanel;
    dbgUsers: TDBGrid;
    cmdAdd: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdExit: TBitBtn;
    dtaUsers: TDataSource;
    pnlChecks: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    txtUserName: TEdit;
    txtUserPassword: TEdit;
    chkActive: TCheckBox;
    cmdHelp: TBitBtn;
    lbl4: TLabel;
    atblUsers: TADOTable;
    chklstPrg: TCheckListBox;
    DosMove1: TDosMove;
    lbl3: TLabel;
    cmbDepartment: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure dbgUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure chklstPrgClickCheck(Sender: TObject);
    procedure txtUserNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure SetWinF;
    procedure FormEditable(Editable : Boolean);
    function  LaunchMenuItemSet(Caption : String; mnuBarIdx : Byte; mnuItem : String) : String;


  public
    { Public declarations }
    mnus : TMainMenu;
  end;


var
  frmAdmin : TfrmAdmin;


function IsSelPrg(s : String) : Boolean;


implementation

uses
  Funcs, DBS, MnuSet, Login, MSGs, Keyboard, FntSel;

{$R *.DFM}


function IsSelPrg(s : String) : Boolean;
var i : Byte;
begin
  Result := False;
  if Length(s) > 0 then
    for i := 1 to Length(s) do
      if s[i] = '1' then
        Result := True;
end;




procedure TfrmAdmin.SetWinF;
begin
  SetFontColor(TForm(frmAdmin));

  Caption := (Caption);
  dbgUsers.Columns[0].Title.Caption := (dbgUsers.Columns[0].Title.Caption);
  cmdAdd.Caption := (cmdAdd.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);

  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  chkActive.Caption := (chkActive.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmAdmin.FormEditable(Editable : Boolean);
begin
  pnlUsers.Enabled := not Editable;
  pnlChecks.Visible := Editable;
  if Editable then
    Height := pnlUsers.Height + pnlChecks.Height
  else
    Height := pnlUsers.Height;
  Height := Height + 25;
end;


function TfrmAdmin.LaunchMenuItemSet(Caption : String; mnuBarIdx : Byte; mnuItem : String) : String;
begin
  Application.CreateForm(TfrmMnuItemList, frmMnuItemList);
  frmMnuItemList.mnus := mnus;
  frmMnuItemList.Caption := ('“Ì— »—‰«„Â Â«Ì ') + Caption;
  frmMnuItemList.MnuBarIdx := mnuBarIdx;
  frmMnuItemList.MnuItemVal := mnuItem;
  frmMnuItemList.ShowModal;
  LaunchMenuItemSet := frmMnuItemList.MnuItemVal;
  frmMnuItemList.Destroy;
end;


procedure TfrmAdmin.FormCreate(Sender: TObject);
begin
  atblUsers.Connection := frmDBS.adoConnect;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    SQL.Add('ORDER BY Depart_Name');
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;
  end;

  atblUsers.Open;
end;

procedure TfrmAdmin.FormActivate(Sender: TObject);
var
  i : Integer;
begin
  SetWinF;
  for i := 0 to mnus.Items.Count-1 do
    chklstPrg.Items.Add(DelShortCut(mnus.Items[i].Caption));

  FormEditable(False);
end;

procedure TfrmAdmin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  atblUsers.Close;
end;

procedure TfrmAdmin.cmdAddClick(Sender: TObject);
var i : Byte;
begin
  txtUserName.Text := '';
  txtUserPassword.Text := '';
  cmbDepartment.ItemIndex := -1;
  chkActive.Checked := True;
  for i := 0 to chklstPrg.Count-1 do
    chklstPrg.Checked[i] := False;
    
  FormEditable(True);
  txtUserName.SetFocus;
  atblUsers.Append;
end;

procedure TfrmAdmin.cmdEditClick(Sender: TObject);
var i : Byte;
begin
  with atblUsers do
    if UpperCase(FieldByName('User_Name').AsString) <> ADMIN_NAME then
    begin
      txtUserName.Text := FieldByName('User_Name').AsString;
      txtUserPassword.Text := FieldByName('User_Password').AsString;
      cmbDepartment.ItemIndex := cmbDepartment.Items.IndexOf(GetDepartmentname(FieldByName('User_Department').AsInteger));
      chkActive.Checked := FieldByName('User_Active').AsBoolean;

      for i := 1 to 5 do
        chklstPrg.Checked[i-1] := IsSelPrg(FieldByName('User_Menu'+IntToStr(i)).AsString);

      FormEditable(True);
      txtUserName.SetFocus;
      Edit;
    end
    else
      ErrorMessage('«ÿ·«⁄«  „œÌ— ”Ì” „ ﬁ«»·  €ÌÌ— ‰Ì” .');
end;


procedure TfrmAdmin.cmdDeleteClick(Sender: TObject);
begin
  with atblUsers do
    if UpperCase(FieldByName('User_Name').AsString) <> ADMIN_NAME then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂ«—»— «ÿ„Ì‰«‰ œ«—Ìœø') then
        Delete;
    end
    else
      ErrorMessage('Õ–› „œÌ— ”Ì” „ «„ﬂ«‰ Å–Ì— ‰Ì” .');
end;


procedure TfrmAdmin.dbgUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    cmdEditClick(Sender)
  else if Key = 45 then
    cmdAddClick(Self)
  else if Key = 46 then
    cmdDeleteClick(Self);
end;

procedure TfrmAdmin.cmdSaveClick(Sender: TObject);
var i : Integer;
begin
  if txtUserName.Text = '' then
  begin
    ErrorMessage('‰«„ ﬂ«—»— Ê«—œ ‰‘œÂ «” .');
    txtUserName.SetFocus;
  end
  else
  begin
    with atblUsers do
    begin
      FieldByName('User_Name').AsString := txtUserName.Text;
      FieldByName('User_Password').AsString := txtUserPassword.Text;
      FieldByName('User_Department').AsInteger := GetDepartmentCode(cmbDepartment.Text);
      FieldByName('User_Active').AsBoolean := chkActive.Checked;
      for i := 0 to chklstPrg.Count-1 do
        if not chklstPrg.Checked[i] then
          FieldByName('User_Menu' + IntToStr(i+1)).AsString := FixLen('', '0', 50);
      Post;
      FormEditable(False);
      dbgUsers.SetFocus;
    end;
  end;
end;

procedure TfrmAdmin.cmdCancelClick(Sender: TObject);
begin
  FormEditable(False);
  atblUsers.Cancel;
  dbgUsers.SetFocus;
end;





procedure TfrmAdmin.chklstPrgClickCheck(Sender: TObject);
var
  MnuItemVal : String[50];
  fldName : String;
begin
  if chklstPrg.ItemIndex > -1 then
    if chklstPrg.Checked[chklstPrg.ItemIndex] then
    begin
      fldName := 'User_Menu' + IntToStr(chklstPrg.ItemIndex+1);
      MnuItemVal := LaunchMenuItemSet(chklstPrg.Items.Strings[chklstPrg.ItemIndex], chklstPrg.ItemIndex, atblUsers.FieldByName(fldName).AsString);
      atblUsers.FieldByName(fldName).AsString := MnuItemVal;
    end;
end;

procedure TfrmAdmin.txtUserNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmAdmin.cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbDepartment.ItemIndex := -1;
end;

end.
