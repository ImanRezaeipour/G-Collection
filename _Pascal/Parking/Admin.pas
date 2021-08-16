unit Admin;

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
    tblUsers: TAdoTable;
    dtaUsers: TDataSource;
    pnlChecks: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    Bevel2: TBevel;
    chkBase: TCheckBox;
    chkTransfer: TCheckBox;
    chkReport: TCheckBox;
    chkTools: TCheckBox;
    txtUserName: TEdit;
    txtUserPassword: TEdit;
    chkEntery: TCheckBox;
    qry: TAdoQuery;
    cmdHelp: TBitBtn;
    chkPrint: TCheckBox;
    Bevel1: TBevel;
    tblUsersUserName: TStringField;
    tblUsersUserPassword: TStringField;
    tblUsersEntery: TBooleanField;
    tblUsersMenuBar: TSmallintField;
    tblUsersBaseMenu: TIntegerField;
    tblUsersTransferMenu: TIntegerField;
    tblUsersReportMenu: TIntegerField;
    tblUsersToolsMenu: TIntegerField;
    tblUsersAccessPrint: TBooleanField;
    chkRelation: TCheckBox;
    tblUsersRelationMenu: TIntegerField;
    Label3: TLabel;
    chkSpecial: TCheckBox;
    tblUsersSpecialMenu: TIntegerField;
    Label18: TLabel;
    cmbDepartment: TComboBox;
    cmbDepartmentCode: TComboBox;
    tblUsersDepartment: TIntegerField;
    lbl4: TLabel;
    cmbActiveRdrOpenDoorCode: TComboBox;
    cmbActiveRdrOpenDoor: TComboBox;
    tblUsersActiveRdrCode: TSmallintField;
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
    procedure chkTransferClick(Sender: TObject);
    procedure chkReportClick(Sender: TObject);
    procedure chkToolsClick(Sender: TObject);
    procedure chkSpecialClick(Sender: TObject);
    procedure cmbDepartmentChange(Sender: TObject);
    procedure cmbActiveRdrOpenDoorCodeChange(Sender: TObject);
    procedure cmbActiveRdrOpenDoorChange(Sender: TObject);
  private
    { Private declarations }

    procedure ChangeSize(IsPanelChck : Boolean);
    procedure ControlsEnabled(enbl : Boolean);
    function  LaunchMenuItemSet(Capt : String; mnuBar, mnuItem : LongInt) : LongInt;
    procedure SetFields;
    procedure ClearFields;
    procedure SetWinF;


  public
    { Public declarations }
    mnus : TMainMenu;
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmAdmin.SetWinF;
begin
  Caption := (Caption);
  cmdAdd.Caption := (cmdAdd.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  tblUsersUserName.DisplayLabel := (tblUsersUserName.DisplayLabel);
  chkBase.Caption := (chkBase.Caption);
  chkSpecial.Caption := (chkSpecial.Caption);
  chkRelation.Caption := (chkRelation.Caption);
  chkReport.Caption := (chkReport.Caption);
  chkTransfer.Caption := (chkTransfer.Caption);
  chkTools.Caption := (chkTools.Caption);
  chkEntery.Caption := (chkEntery.Caption);
  chkPrint.Caption := (chkPrint.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmAdmin.ChangeSize(IsPanelChck : Boolean);
begin
  pnlChecks.Height := 210;
  Self.Height := pnlUsers.Height;
  if IsPanelChck then
    Self.Height := Self.Height + pnlChecks.Height;
  pnlChecks.Visible := IsPanelChck;
  Self.Height := Self.Height + 30;
end;

procedure TfrmAdmin.SetFields;
var MnuBar : Integer;
begin
  MnuBar := tblUsers.FieldByName('MenuBar').AsInteger;

  ClearFields;

  txtUserName.Text := tblUsers.FieldByName('UserName').AsString;
  txtUserPassword.Text := CodingPassword(tblUsers.FieldByName('UserPassword').AsString);
  chkEntery.Checked := tblUsers.FieldByName('Entery').AsBoolean;
  chkPrint.Checked := tblUsers.FieldByName('AccessPrint').AsBoolean;
  cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(tblUsers.FieldByName('Department').AsString);
  cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;

  if  tblUsers.FieldByName('ActiveRdrCode').AsString <> '' then
  begin
    cmbActiveRdrOpenDoorCode.ItemIndex := cmbActiveRdrOpenDoorCode.Items.IndexOf(tblUsers.FieldByName('ActiveRdrCode').AsString);
    cmbActiveRdrOpenDoor.ItemIndex := cmbActiveRdrOpenDoorCode.ItemIndex;
  end
  else
  begin
    cmbActiveRdrOpenDoorCode.ItemIndex := -1;
    cmbActiveRdrOpenDoor.ItemIndex := -1;
  end;
   
  if (MnuBar and Round(Power(2, MNU_BASE))) <> 0 then
    chkBase.Checked := True;

  if (MnuBar and Round(Power(2, MNU_RELATION))) <> 0 then
    chkRelation.Checked := True;

  if (MnuBar and Round(Power(2, MNU_TRANSFER))) <> 0 then
    chkTransfer.Checked := True;

  if (MnuBar and Round(Power(2, MNU_SPECIAL))) <> 0 then
    chkSpecial.Checked := True;

  if (MnuBar and Round(Power(2, MNU_REPORT))) <> 0 then
    chkReport.Checked := True;

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
  chkTransfer.Checked := False;
  chkReport.Checked := False;
  chkTools.Checked := False;
  chkPrint.Checked := False;
  cmbDepartment.ItemIndex := 0;
  cmbDepartmentCode.ItemIndex := 0;
  cmbActiveRdrOpenDoor.ItemIndex := -1;
  cmbActiveRdrOpenDoorCode.ItemIndex := -1;
end;

function TfrmAdmin.LaunchMenuItemSet(Capt : String; mnuBar, mnuItem : LongInt) : LongInt;
var
  frmMnuItemList : TfrmMnuItemList;
begin
  Delete(Capt, Pos('&', Capt), 1);
  Application.CreateForm(TfrmMnuItemList, frmMnuItemList);
  frmMnuItemList.mnus := mnus;
  frmMnuItemList.Caption := ('“Ì— »—‰«„Â Â«Ì ') + Capt;
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
var qry : TAdoQuery;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Department ORDER BY Depart_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDepartmentCode.Items.Add(qry.FieldByName('Depart_Code').AsString);
    qry.Next;
  end;
  qry.Close;
  cmbDepartment.ItemIndex := 0;
  cmbDepartmentCode.ItemIndex := 0;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers ');
  qry.SQL.Add('WHERE (R_Active = ''T'' OR R_Active = ''t'') AND R_Type = 1 AND R_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY R_Name ');
  qry.Open;
  while not qry.EOF do
  begin
    cmbActiveRdrOpenDoor.Items.Add(qry.FieldByName('R_Name').AsString);
    cmbActiveRdrOpenDoorCode.Items.Add(qry.FieldByName('R_Code').AsString);
    qry.Next;
  end;
  qry.Close;
  
  tblUsers.connection := frmDBS.adoConnect;
  tblUsers.TableName := 'Security';
end;

procedure TfrmAdmin.FormActivate(Sender: TObject);
var
  chk : array[MNU_BASE..MNU_TOOLS] of TCheckBox;
  i : Integer;
begin
  chk[0] := chkBase;
  chk[1] := chkRelation;
  chk[2] := chkTransfer;
  chk[3] := chkSpecial;
  chk[4] := chkReport;
  chk[5] := chkTools;
  for i := MNU_BASE to MNU_TOOLS do
  begin
    chk[i].Caption := mnus.Items[i].Caption;
    chk[i].Visible := mnus.Items[i].Visible;
  end;

  ChangeSize(False);
  tblUsers.Filtered := True;
  tblUsers.Filter := 'UserName <> ''' + ADMIN_NAME + '''';
  tblUsers.Open;
end;

procedure TfrmAdmin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tblUsers.Close;
end;

procedure TfrmAdmin.cmbActiveRdrOpenDoorChange(Sender: TObject);
begin
  cmbActiveRdrOpenDoorCode.ItemIndex := cmbActiveRdrOpenDoor.ItemIndex;
end;

procedure TfrmAdmin.cmbActiveRdrOpenDoorCodeChange(Sender: TObject);
begin
  cmbActiveRdrOpenDoor.ItemIndex := cmbActiveRdrOpenDoorCode.ItemIndex;
end;

procedure TfrmAdmin.cmbDepartmentChange(Sender: TObject);
begin
  cmbDepartmentCode.ItemIndex := cmbDepartment.ItemIndex;
end;

procedure TfrmAdmin.cmdAddClick(Sender: TObject);
begin
  ChangeSize(True);
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
    ChangeSize(True);
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

procedure TfrmAdmin.chkTransferClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkTransfer.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkTransfer.Caption, MNU_TRANSFER, tblUsers.FieldByName('TransferMenu').AsInteger);
    if MnuItemVal = 0 then
      chkTransfer.Checked := False;
    tblUsers.FieldByName('TransferMenu').AsInteger := MnuItemVal;
  end;
end;

procedure TfrmAdmin.chkSpecialClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  if chkSpecial.Checked and pnlChecks.Visible then
  begin
    MnuItemVal := LaunchMenuItemSet(chkSpecial.Caption, MNU_SPECIAL, tblUsers.FieldByName('SpecialMenu').AsInteger);
    if MnuItemVal = 0 then
      chkSpecial.Checked := False;
    tblUsers.FieldByName('SpecialMenu').AsInteger := MnuItemVal;
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
  else if cmbDepartment.ItemIndex = -1 then
  begin
    ErrorMessage('„Õ· Œœ„  «‰ Œ«» ‰‘œÂ «” .');
    cmbDepartment.SetFocus;
  end       
  else
  begin
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT UserName FROM Security WHERE UPPER(UserName) = ''' + UpperCase(txtUserName.Text) + '''');
    qry.Open;
    if qry.EOF or ((qry.RecordCount = 1) and (UpperCase(tblUsers.FieldByName('UserName').AsString) = UpperCase(txtUserName.Text))) then
    begin
      qry.Close;
      ChangeSize(False);
      tblUsers.FieldByName('UserName').AsString := txtUserName.Text;
      tblUsers.FieldByName('UserPassword').AsString := CodingPassWord(txtUserPassword.Text);
      tblUsers.FieldByName('Entery').AsBoolean := chkEntery.Checked;
      tblUsers.FieldByName('AccessPrint').AsBoolean := chkPrint.Checked;
      tblUsers.FieldByName('Department').AsInteger := StrToInt(cmbDepartmentCode.Text);
      if cmbActiveRdrOpenDoorCode.ItemIndex > -1 then
      begin
        tblUsers.FieldByName('ActiveRdrCode').AsInteger := StrToInt(cmbActiveRdrOpenDoorCode.Text);
        g_Options.ActiveRdrCode := StrToInt(cmbActiveRdrOpenDoorCode.Text);
      end
      else
      begin
        tblUsers.FieldByName('ActiveRdrCode').AsInteger := 0;
        g_Options.ActiveRdrCode := 0;
      end;

      if not chkBase.Checked then
        tblUsers.FieldByName('BaseMenu').AsInteger := 0;

      if not chkRelation.Checked then
        tblUsers.FieldByName('RelationMenu').AsInteger := 0;

      if not chkTransfer.Checked then
        tblUsers.FieldByName('TransferMenu').AsInteger := 0;

      if not chkSpecial.Checked then
        tblUsers.FieldByName('SpecialMenu').AsInteger := 0;

      if not chkReport.Checked then
        tblUsers.FieldByName('ReportMenu').AsInteger := 0;

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
  ChangeSize(False);
  tblUsers.Cancel;
  ControlsEnabled(True);
  dbgUsers.SetFocus;
end;




end.
