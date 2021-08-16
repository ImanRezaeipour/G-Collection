unit Admin;
{$I features}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, Globals, Mask,
  DBCtrls, Menus, Math, MSGs, MnuSet;

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
    Label1: TLabel;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    Bevel2: TBevel;
    chkBase: TCheckBox;
    chkResturant: TCheckBox;
    chkReport: TCheckBox;
    chkTools: TCheckBox;
    txtUserName: TEdit;
    txtUserPassword: TEdit;
    chkEntery: TCheckBox;
    qry: TAdoQuery;
    cmdHelp: TBitBtn;
    chkPrint: TCheckBox;
    Bevel1: TBevel;
    chkRelation: TCheckBox;
    Label3: TLabel;
    tblUsers: TAdoTable;
    tblUsersUserName: TStringField;
    tblUsersUserPassword: TStringField;
    tblUsersEntery: TBooleanField;
    tblUsersMenuBar: TSmallintField;
    tblUsersBaseMenu: TIntegerField;
    tblUsersResturantMenu: TIntegerField;
    tblUsersReportMenu: TIntegerField;
    tblUsersRelationMenu: TIntegerField;
    tblUsersToolsMenu: TIntegerField;
    tblUsersAccessPrint: TBooleanField;
    Label4: TLabel;
    cmbRdrName: TComboBox;
    cmbRdrCode: TComboBox;
    qryReaders: TADOQuery;
    tblUsersrdrCode4Fish: TIntegerField;
    chkGuestOnly: TCheckBox;
    tblUsersGuestOnly4Fish: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure dbgUsersKeyPress(Sender: TObject; var Key: Char);
    procedure dbgUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure chkBaseClick(Sender: TObject);
    procedure chkRelationClick(Sender: TObject);
    procedure chkReportClick(Sender: TObject);
    procedure chkToolsClick(Sender: TObject);
    procedure chkResturantClick(Sender: TObject);
    procedure cmbRdrNameChange(Sender: TObject);
  private
    { Private declarations }

    procedure FormEditable(Editable : Boolean);
    procedure ControlsEnabled(enbl : Boolean);
    function  LaunchMenuItemSet(Caption : String; mnuBar, mnuItem : LongInt) : LongInt;
    procedure SetFields;
    procedure ClearFields;
    procedure SetWinF;


  public
    { Public declarations }
    mnus : TMainMenu;
  end;


implementation

uses DBS_Proc;

{$R *.DFM}

procedure TfrmAdmin.SetWinF;
begin
  Caption := (Caption);
  cmdAdd.Caption := (cmdAdd.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  tblUsersUserName.DisplayLabel := (tblUsersUserName.DisplayLabel);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  chkBase.Caption := (chkBase.Caption);
  chkRelation.Caption := (chkRelation.Caption);
  chkResturant.Caption := (chkResturant.Caption);
  chkTools.Caption := (chkTools.Caption);
  chkReport.Caption := (chkReport.Caption);
  chkEntery.Caption := (chkEntery.Caption);
  chkPrint.Caption := (chkPrint.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmAdmin.FormEditable(Editable : Boolean);
begin
  Self.Height := pnlUsers.Height;
  if Editable then
    Self.Height := Self.Height + pnlChecks.Height + 10;
  pnlChecks.Visible := Editable;
  Self.Height := Self.Height + 25;
end;

procedure TfrmAdmin.SetFields;
var MnuBar : Integer;
//    i : integer;
begin
  MnuBar := tblUsers.FieldByName('MenuBar').AsInteger;

  ClearFields;

  txtUserName.Text := tblUsers.FieldByName('UserName').AsString;
  txtUserPassword.Text := CodingPassword(tblUsers.FieldByName('UserPassword').AsString);
  chkEntery.Checked := tblUsers.FieldByName('Entery').AsBoolean;
  chkPrint.Checked := tblUsers.FieldByName('AccessPrint').AsBoolean;

//kaveh is
//{$ifdef Bank Markazi}
  cmbRdrCode.ItemIndex := cmbRdrCode.Items.IndexOf(tblUsers.FieldByName('rdrCode4Fish').AsString);
  cmbRdrName.ItemIndex := cmbRdrCode.ItemIndex;
  chkGuestOnly.Checked := tblUsers.FieldByName('GuestOnly4Fish').AsBoolean;
//{$else Bank Markazi}
//      cmbRdrCode.ItemIndex := 0;
//      cmbRdrName.ItemIndex := 0;
//{$endif Bank Markazi}
//kaveh ie

  if (MnuBar and Round(Power(2, MNU_BASE))) <> 0 then
    chkBase.Checked := True;

  if (MnuBar and Round(Power(2, MNU_RESTURANT))) <> 0 then
    chkResturant.Checked := True;

  if (MnuBar and Round(Power(2, MNU_REPORT))) <> 0 then
    chkReport.Checked := True;

  if (MnuBar and Round(Power(2, MNU_RELATION))) <> 0 then
    chkRelation.Checked := True;

  if (MnuBar and Round(Power(2, MNU_TOOLS))) <> 0 then
    chkTools.Checked := True;
end;

procedure TfrmAdmin.ClearFields;
begin
  txtUserName.Text := '';
  txtUserPassword.Text := '';
  chkEntery.Checked := False;
  chkPrint.Checked := False;
  chkBase.Checked := False;
  chkResturant.Checked := False;
  chkReport.Checked := False;
  chkRelation.Checked := False;
  chkTools.Checked := False;
  chkPrint.Checked := False;
//kaveh is
  cmbRdrName.ItemIndex := -1;
  cmbRdrCode.ItemIndex := -1;
  chkGuestOnly.Checked := False;
//kaveh ie
end;

function TfrmAdmin.LaunchMenuItemSet(Caption : String; mnuBar, mnuItem : LongInt) : LongInt;
var frmMnuItemList : TfrmMnuItemList;
begin
  Application.CreateForm(TfrmMnuItemList, frmMnuItemList);
  frmMnuItemList.mnus := mnus;
  frmMnuItemList.Caption := ('“Ì— »—‰«„Â Â«Ì ') + Caption;
  frmMnuItemList.MnuBarVal := mnuBar;
  frmMnuItemList.MnuItemVal := mnuItem;
  frmMnuItemList.ShowModal;
  LaunchMenuItemSet := frmMnuItemList.MnuItemVal;
  frmMnuItemList.Destroy;
end;

procedure TfrmAdmin.ControlsEnabled(enbl : Boolean);
begin
  cmdAdd.Enabled := enbl;
  cmdEdit.Enabled := enbl;
  cmdDelete.Enabled := enbl;
  cmdExit.Enabled := enbl;
  dbgUsers.Enabled := enbl;
end;


procedure TfrmAdmin.FormCreate(Sender: TObject);
begin
  SetWinF;
  tblUsers.connection := frmDBS.DBConnection;
  tblUsers.TableName := 'Security';
//{$ifdef BankM arkazi}
  qryReaders.connection := frmDBS.DBConnection;
//{$endif Bank Markazi}
end;

procedure TfrmAdmin.FormActivate(Sender: TObject);
var
  chk : array[MNU_BASE..MNU_TOOLS] of TCheckBox;
  i : Integer;
begin
  chk[MNU_BASE] := chkBase;
  chk[MNU_RESTURANT] := chkResturant;
  chk[MNU_REPORT] := chkReport;
  chk[MNU_RELATION] := chkRelation;
  chk[MNU_TOOLS] := chkTools;
  for i := MNU_BASE to MNU_TOOLS do
  begin
    chk[i].Caption := mnus.Items[i].Caption;
    chk[i].Visible := mnus.Items[i].Visible;
  end;

  FormEditable(False);
  tblUsers.Filtered := True;
  tblUsers.Filter := 'UserName <> ''' + ADMIN_NAME + '''';
  tblUsers.Open;
//kaveh is
//{$ifdef Bank Markazi}
  Label4.Visible := True;
  cmbRdrName.Visible := True;
  with qryReaders do
  begin
    Open;
    while not Eof do
    begin
      cmbRdrName.Items.Add(FieldByName('R_Name').AsString);
      cmbRdrCode.Items.Add(FieldByName('R_Code').AsString);
      Next;
    end;
    close;
  end;
//{$else Bank Markazi}
//  Label4.Visible := False;
//  cmbRdrName.Visible := False;
//{$endif Bank Markazi}
//kaveh ie

end;

procedure TfrmAdmin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tblUsers.Close;
end;

procedure TfrmAdmin.cmbRdrNameChange(Sender: TObject);
begin
  cmbRdrCode.ItemIndex := cmbRdrName.ItemIndex;
end;

procedure TfrmAdmin.cmdAddClick(Sender: TObject);
begin
  FormEditable(True);
  txtUserName.SetFocus;
  ControlsEnabled(False);
  ClearFields;
  tblUsers.Append;
end;

procedure TfrmAdmin.cmdEditClick(Sender: TObject);
begin
  if UpperCase(tblUsers.FieldByName('UserName').AsString) <> ADMIN_NAME then
  begin
    ControlsEnabled(False);
    SetFields;
    tblUsers.Edit;
    FormEditable(True);
    txtUserName.SetFocus;
  end
  else
    ErrorMessage('«ÿ·«⁄«  „œÌ— ”Ì” „ ﬁ«»·  €ÌÌ— ‰Ì” .');
end;


procedure TfrmAdmin.cmdDeleteClick(Sender: TObject);
begin
  if UpperCase(tblUsers.FieldByName('UserName').AsString) <> ADMIN_NAME then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂ«—»— «ÿ„Ì‰«‰ œ«—Ìœø') then
      tblUsers.Delete;
  end
  else
    ErrorMessage('Õ–› „œÌ— ”Ì” „ «„ﬂ«‰ Å–Ì— ‰Ì” .');
end;


procedure TfrmAdmin.dbgUsersKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
  begin
    Key := #0;
    cmdEditClick(Self);
  end;
end;

procedure TfrmAdmin.dbgUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmdDeleteClick(Self);
  end
  else if Key = 45 then
  begin
    Key := 0;
    cmdAddClick(Self);
  end
end;

procedure TfrmAdmin.chkBaseClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkBase.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkBase.Caption, MNU_BASE, tblUsers.FieldByName('BaseMenu').AsInteger);
    if MnuItemVal = 0 then
      chkBase.Checked := False;
    tblUsers.FieldByName('BaseMenu').AsInteger := MnuItemVal;
  end;
end;

procedure TfrmAdmin.chkResturantClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkResturant.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkresturant.Caption, MNU_RESTURANT, tblUsers.FieldByName('ResturantMenu').AsInteger);
    if MnuItemVal = 0 then
      chkResturant.Checked := False;
    tblUsers.FieldByName('ResturantMenu').AsInteger := MnuItemVal;
  end;
end;

procedure TfrmAdmin.chkReportClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkReport.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkReport.Caption, MNU_REPORT, tblUsers.FieldByName('ReportMenu').AsInteger);
    if MnuItemVal = 0 then
      chkReport.Checked := False;
    tblUsers.FieldByName('ReportMenu').AsInteger := MnuItemVal;
  end;
end;

procedure TfrmAdmin.chkRelationClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkRelation.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkRelation.Caption, MNU_RELATION, tblUsers.FieldByName('RelationMenu').AsInteger);
    if MnuItemVal = 0 then
      chkRelation.Checked := False;
    tblUsers.FieldByName('RelationMenu').AsInteger := MnuItemVal;
  end;
end;

procedure TfrmAdmin.chkToolsClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkTools.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkTools.Caption, MNU_TOOLS, tblUsers.FieldByName('ToolsMenu').AsInteger);
    if MnuItemVal = 0 then
      chkTools.Checked := False;
    tblUsers.FieldByName('ToolsMenu').AsInteger := MnuItemVal;
  end;
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
    qry.connection := frmDBS.DBConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT UserName FROM Security WHERE UPPER(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
    qry.Open;
    if qry.EOF or ((qry.RecordCount = 1) and (UpperCase(tblUsers.FieldByName('UserName').AsString) = UpperCase(txtUserName.Text))) then
    begin
      qry.Close;
      FormEditable(False);
      tblUsers.FieldByName('UserName').AsString := txtUserName.Text;
      tblUsers.FieldByName('UserPassword').AsString := CodingPassWord(txtUserPassword.Text);
      tblUsers.FieldByName('Entery').AsBoolean := chkEntery.Checked;
      tblUsers.FieldByName('AccessPrint').AsBoolean := chkPrint.Checked;
//kaveh is
//{$ifdef Bank Markazi}
      if cmbRdrCode.ItemIndex > -1 then
        tblUsers.FieldByName('rdrCode4Fish').AsInteger := StrToInt(cmbRdrCode.Text)
      else
        tblUsers.FieldByName('rdrCode4Fish').AsInteger := 0;
      tblUsers.FieldByName('GuestOnly4Fish').AsBoolean := chkGuestOnly.Checked;
//{$else Bank Markazi}
//      tblUsers.FieldByName('rdrCode4Fish').AsInteger := 0;
//{$endif Bank Markazi}
//kaveh ie

      if not chkBase.Checked then
        tblUsers.FieldByName('BaseMenu').AsInteger := 0;

      if not chkResturant.Checked then
        tblUsers.FieldByName('ResturantMenu').AsInteger := 0;

      if not chkReport.Checked then
        tblUsers.FieldByName('ReportMenu').AsInteger := 0;

      if not chkRelation.Checked then
        tblUsers.FieldByName('RelationMenu').AsInteger := 0;

      if not chkTools.Checked then
        tblUsers.FieldByName('ToolsMenu').AsInteger := 0;

      tblUsers.FieldByName('MenuBar').AsInteger := 0;
      for i := MNU_BASE to MNU_TOOLS do
        if tblUsers.Fields[i+4].AsInteger > 0 then
          tblUsers.FieldByName('MenuBar').AsInteger := tblUsers.FieldByName('MenuBar').AsInteger or Trunc(Power(2, i));

      tblUsers.Post;
      ControlsEnabled(True);
      dbgUsers.SetFocus;
    end
    else
    begin
      qry.Close;
      ErrorMessage('ﬂ«—»— »« ç‰Ì‰ ‰«„Ì ÊÃÊœ œ«—œ.');
      txtUserName.SetFocus;
    end;
  end;
end;

procedure TfrmAdmin.cmdCancelClick(Sender: TObject);
begin
  FormEditable(False);
  tblUsers.Cancel;
  ControlsEnabled(True);
  dbgUsers.SetFocus;
end;





end.
