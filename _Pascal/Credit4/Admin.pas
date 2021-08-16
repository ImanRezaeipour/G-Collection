unit Admin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, Globals, Mask,
  DBCtrls, Menus, Math, MSGs, MnuSet, DBS, ADODB, DosMove;

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
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    Bevel2: TBevel;
    chkBase: TCheckBox;
    chkReport: TCheckBox;
    chkTools: TCheckBox;
    txtUserName: TEdit;
    cmdHelp: TBitBtn;
    chkRelation: TCheckBox;
    lbl3: TLabel;
    chkSetup: TCheckBox;
    adoTblUsers: TADOTable;
    adoQry: TADOQuery;
    DosMove1: TDosMove;
    Bevel3: TBevel;
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
    procedure chkClockClick(Sender: TObject);
    procedure chkSetupClick(Sender: TObject);

  private
    { Private declarations }

    procedure FormEditable(Editable : Boolean);
    procedure ControlsEnabled(enbl : Boolean);
    function  LaunchMenuItemSet(Caption : String; mnuBar, mnuItem : LongInt) : LongInt;
    procedure _SetFields;
    procedure _ClearFields;
  public
    { Public declarations }
    mnus : TMainMenu;
  end;


implementation

uses
  Funcs;

{$R *.DFM}

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

procedure TfrmAdmin._SetFields;
var MnuBar : Integer;
begin
  with adoTblUsers do
  begin
    MnuBar := FieldByName('MenuBar').AsInteger;
    _ClearFields;
    txtUserName.Text := FieldByName('Name').AsString;
//    txtUserPassword.Text := CodingPassword(FieldByName('UserPassword').AsString);
  end;

  if (MnuBar and Round(Power(2, MNU_BASE))) <> 0 then
    chkBase.Checked := True;

  if (MnuBar and Round(Power(2, MNU_REPORT))) <> 0 then
    chkReport.Checked := True;

  if (MnuBar and Round(Power(2, MNU_SETUP))) <> 0 then
    chkSetup.Checked := True;

  if (MnuBar and Round(Power(2, MNU_RELATION))) <> 0 then
    chkRelation.Checked := True;

  if (MnuBar and Round(Power(2, MNU_TOOLS))) <> 0 then
    chkTools.Checked := True;

{
  if adoTblP1.Locate('P1_Code', adoTblUsers.FieldByName('Part1').AsInteger, [loCaseInsensitive]) then
  begin
    cmbP1.ItemIndex := adoTblP1.RecNo-1;
    SetPart2;
  end;
  if adoTblP2.Locate('P2_Code', adoTblUsers.FieldByName('Part2').AsInteger, [loCaseInsensitive]) then
  begin
    cmbP2.ItemIndex := adoTblP2.RecNo-1;
    SetPart3;
  end;
  if adoTblP3.Locate('P3_Code', adoTblUsers.FieldByName('Part3').AsInteger, [loCaseInsensitive]) then
  begin
    cmbP3.ItemIndex := adoTblP3.RecNo-1;
    SetPart4
  end;
  if adoTblP4.Locate('P4_Code', adoTblUsers.FieldByName('Part4').AsInteger, [loCaseInsensitive]) then
    cmbP4.ItemIndex := adoTblP4.RecNo-1;
}
end;

procedure TfrmAdmin._ClearFields;
begin
  txtUserName.Text := '';
//  txtUserPassword.Text := '';
  chkBase.Checked := False;
  chkReport.Checked := False;
  chkSetup.Checked := False;
  chkRelation.Checked := False;
  chkTools.Checked := False;
{
  cmbP1.ItemIndex := -1;
  cmbP2.ItemIndex := -1;
  cmbP3.ItemIndex := -1;
  cmbP4.ItemIndex := -1;
}
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
  adoTblUsers.Connection := frmDBS.DBConnection;
  dtaUsers.DataSet := adoTblUsers;
  adoTblUsers.TableName := 'Security';
  adoTblUsers.Open;
end;

procedure TfrmAdmin.FormActivate(Sender: TObject);
var
  chk : array[MNU_BASE..MNU_TOOLS] of TCheckBox;
  i : Integer;
begin
  chk[MNU_BASE] := chkBase;
  chk[MNU_REPORT] := chkReport;
  chk[MNU_SETUP] := chkSetup;
  chk[MNU_RELATION] := chkRelation;
  chk[MNU_TOOLS] := chkTools;
  for i := MNU_BASE to MNU_TOOLS do
  begin
    chk[i].Caption := mnus.Items[i].Caption;
    chk[i].Visible := mnus.Items[i].Visible;
  end;

  FormEditable(False);
end;

procedure TfrmAdmin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  with adoTblUsers do
    Close;
end;

procedure TfrmAdmin.cmdAddClick(Sender: TObject);
begin
  FormEditable(True);
  txtUserName.SetFocus;
  ControlsEnabled(False);
  _ClearFields;
  with adoTblUsers do
    Append;
end;

procedure TfrmAdmin.cmdEditClick(Sender: TObject);
begin
  with adoTblUsers do
    if UpperCase(FieldByName('Name').AsString) <> '„œÌ— ”Ì” „' then
    begin
      ControlsEnabled(False);
      _SetFields;
      Edit;
      FormEditable(True);
      txtUserName.SetFocus;
    end
    else
      ErrorMessage('”ÿÕ œ” —”Ì „œÌ— ”Ì” „ ﬁ«»·  €ÌÌ— ‰Ì” .');
end;


procedure TfrmAdmin.cmdDeleteClick(Sender: TObject);
begin
  with adoTblUsers do
    if UpperCase(FieldByName('Name').AsString) <> '„œÌ— ”Ì” „' then
    begin
      with frmDBS.adoQryG do
      begin
        SQL.Clear;
        SQL.Add('SELECT * FROM Users WHERE SecurityCode =' + adoTblUsers.FieldByName('Code').AsString);
        Open;
        First;
        if not Eof then
        begin
          ErrorMessage('«Ì‰ ”ÿÕ œ” —”Ì œ— ê—œ‘ «”  .');
          exit;
        end;
        Close;
      end;

      if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø') then
        Delete;
    end
    else
      ErrorMessage('Õ–› ”ÿÕ œ” —”Ì „œÌ— ”Ì” „ «„ﬂ«‰ Å–Ì— ‰Ì” .');
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
  with adoTblUsers do
    if chkBase.Checked and pnlChecks.Visible then
    begin
      MnuItemVal := LaunchMenuItemSet(chkBase.Caption, MNU_BASE, FieldByName('BaseMenu').AsInteger);
      if MnuItemVal = 0 then
        chkBase.Checked := False;
      FieldByName('BaseMenu').AsInteger := MnuItemVal;
    end;
end;

procedure TfrmAdmin.chkClockClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
end;

procedure TfrmAdmin.chkReportClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  with adoTblUsers do
    if chkReport.Checked and pnlChecks.Visible then
    begin
      MnuItemVal := LaunchMenuItemSet(chkReport.Caption, MNU_REPORT, FieldByName('ReportMenu').AsInteger);
      if MnuItemVal = 0 then
        chkReport.Checked := False;
      FieldByName('ReportMenu').AsInteger := MnuItemVal;
    end;
end;

procedure TfrmAdmin.chkSetupClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  with adoTblUsers do
    if chkSetup.Checked and pnlChecks.Visible then
    begin
      MnuItemVal := LaunchMenuItemSet(chkSetup.Caption, MNU_SETUP, FieldByName('SetupMenu').AsInteger);
      if MnuItemVal = 0 then
        chkSetup.Checked := False;
      FieldByName('SetupMenu').AsInteger := MnuItemVal;
    end;
end;

procedure TfrmAdmin.chkRelationClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  with adoTblUsers do
    if chkRelation.Checked and pnlChecks.Visible then
    begin
      MnuItemVal := LaunchMenuItemSet(chkRelation.Caption, MNU_RELATION, FieldByName('RelationMenu').AsInteger);
      if MnuItemVal = 0 then
        chkRelation.Checked := False;
      FieldByName('RelationMenu').AsInteger := MnuItemVal;
    end;
end;

procedure TfrmAdmin.chkToolsClick(Sender: TObject);
var MnuItemVal : LongInt;
begin
  with adoTblUsers do
    if chkTools.Checked and pnlChecks.Visible then
    begin
      MnuItemVal := LaunchMenuItemSet(chkTools.Caption, MNU_TOOLS, FieldByName('ToolsMenu').AsInteger);
      if MnuItemVal = 0 then
        chkTools.Checked := False;
      FieldByName('ToolsMenu').AsInteger := MnuItemVal;
    end;
end;

procedure TfrmAdmin.cmdSaveClick(Sender: TObject);
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
      SQL.Add('SELECT Name FROM Security WHERE '+ Upper_case + ' (Name) = ''' + UpperCase(txtUserName.Text) + '''');
      Open;
      if EOF or ((RecordCount = 1) and (UpperCase(adoTblUsers.FieldByName('Name').AsString) = UpperCase(txtUserName.Text))) then
      begin
        Close;
        FormEditable(False);
        with adoTblUsers do
        begin
          if adoTblUsers.State <> dsEdit then
            FieldByName('Code').AsString := IntToStr(GetNewNumber('security', 'Code'));
          FieldByName('Name').AsString := txtUserName.Text;
//          FieldByName('UserPassword').AsString := CodingPassWord(txtUserPassword.Text);

          if not chkBase.Checked then
            FieldByName('BaseMenu').AsInteger := 0;

          if not chkReport.Checked then
            FieldByName('ReportMenu').AsInteger := 0;

          if not chkSetup.Checked then
            FieldByName('SetupMenu').AsInteger := 0;

          if not chkRelation.Checked then
            FieldByName('RelationMenu').AsInteger := 0;

          if not chkTools.Checked then
            FieldByName('ToolsMenu').AsInteger := 0;

          FieldByName('MenuBar').AsInteger := 0;
          for i := MNU_BASE to MNU_TOOLS do
            if Fields[i+3{4}].AsInteger > 0 then
              FieldByName('MenuBar').AsInteger := FieldByName('MenuBar').AsInteger or Trunc(Power(2, i));

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

procedure TfrmAdmin.cmdCancelClick(Sender: TObject);
begin
  FormEditable(False);
  with adoTblUsers do
    Cancel;
  ControlsEnabled(True);
  dbgUsers.SetFocus;
end;


end.
