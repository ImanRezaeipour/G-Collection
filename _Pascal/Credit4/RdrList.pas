unit RdrList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, DBTables, ExtCtrls, Globals,
  FarsiApi, MSGs, DBS, Keyboard, ComTools, CPort, RunCmnds, ADODB, DosMove;

type
  TfrmReaders = class(TForm)
    grpList: TGroupBox;
    dbgReaders: TDBGrid;
    grpInf: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaReaders: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    lbl2: TLabel;
    txtName: TEdit;
    grpStat: TGroupBox;
    rdoActive: TRadioButton;
    rdoNotActive: TRadioButton;
    chkModem: TCheckBox;
    lbl4: TLabel;
    cmbType: TComboBox;
    adoTblReaders: TADOTable;
    adoTblReadersR_Code: TSmallintField;
    adoTblReadersR_Name: TStringField;
    adoTblReadersR_Active: TStringField;
    adoTblReadersR_Port: TSmallintField;
    adoTblReadersR_BaudNo: TSmallintField;
    adoTblReadersR_Type: TSmallintField;
    adoTblReadersR_Modem: TBooleanField;
    adoTblReadersType: TStringField;
    adoTblReadersActive: TStringField;
    adoTblReadersStation: TStringField;
    grpPort: TGroupBox;
    lbl3: TLabel;
    Label1: TLabel;
    cmbPort: TComboBox;
    cmbBaud: TComboBox;
    rdoRelation: TRadioGroup;
    grpLan: TGroupBox;
    lbl6: TLabel;
    Label2: TLabel;
    cmbProtocol: TComboBox;
    txtIP: TEdit;
    adoTblReadersR_IP: TWideStringField;
    adoTblReadersR_TCP: TBooleanField;
    adoTblReadersR_IsCOM: TBooleanField;
    DosMove1: TDosMove;
    procedure rdoRelationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgReadersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure dbgReadersDblClick(Sender: TObject);
    procedure cmbBaudKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPortKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTypeKeyPress(Sender: TObject; var Key: Char);
    procedure chkModemKeyPress(Sender: TObject; var Key: Char);
    procedure rdoActiveKeyPress(Sender: TObject; var Key: Char);
    procedure adoTblReadersCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(edit : Boolean);
    procedure ClearFields;
    procedure Setfields;
    function  AreValidControls : Boolean;
    procedure SendTab(var Key : Char);
  public
    { Public declarations }
  end;

implementation

uses
  Funcs;

{$R *.DFM}


procedure TfrmReaders.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  dbgReaders.Hint := (dbgReaders.Hint);
  for i := 0 to dbgReaders.Columns.Count-1 do
    dbgReaders.Columns[i].Title.Caption := (dbgReaders.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
//  lblBaud.Caption := (lblBaud.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  chkModem.Caption := (chkModem.Caption);
  grpStat.Caption := (grpStat.Caption);
  rdoActive.Caption := (rdoActive.Caption);
  rdoNotActive.Caption := (rdoNotActive.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmReaders.FormInEdit(edit : Boolean);
begin
  grpList.Visible := not edit;
  grpInf.Visible := edit;
  if edit then
    Height := grpInf.Height
  else
    Height := grpList.Height;
  Height := Height + 25;
end;

procedure TfrmReaders.ClearFields;
begin
  txtCode.Text := '';
  txtName.Text := '';
  cmbBaud.ItemIndex := 9;
  cmbPort.ItemIndex := 1;
  cmbType.ItemIndex := 0;
  chkModem.Checked := False;
  rdoNotActive.Checked := True;
  txtCode.SetFocus;
end;

procedure TfrmReaders.Setfields;
begin
  with adoTblReaders do
  begin
    txtCode.Text := IntToStr(FieldByName('R_Code').AsInteger);
    txtName.Text := FieldByName('R_Name').AsString;
    cmbBaud.ItemIndex := FieldByName('R_BaudNo').AsInteger;
    if FieldByName('R_IsCOM').AsBoolean then
      rdoRelation.ItemIndex := 0
    else
      rdoRelation.ItemIndex := 1;

    cmbPort.ItemIndex := FieldByName('R_Port').AsInteger - 1;
    case FieldByName('R_Type').AsInteger of
      RDR_CLK120,
      RDR_CLK6000: cmbType.ItemIndex := FieldByName('R_Type').AsInteger-1;
      RDR_mF9000  : cmbType.ItemIndex := 2;
    end;
    if FieldByName('R_TCP').AsBoolean then
      cmbProtocol.ItemIndex := 0
    else
      cmbProtocol.ItemIndex := 1;

    txtIP.Text := FieldByName('R_IP').AsString;

    chkModem.Checked := FieldByName('R_Modem').AsBoolean;
    rdoActive.Checked := FieldByName('R_Active').AsBoolean;
  end;
  txtCode.SetFocus;
end;

function TfrmReaders.AreValidControls : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('ﬂœ œ” ê«Â Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('‰«„ œ” ê«Â Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  {else if not IsNumeric(Copy(txtName.Text, 1, 4)) then
  begin
    AreValidControls := False;
    ErrorMessage('‘—Ê⁄ ‰«„ œ” ê«Â »«Ìœ »« ⁄œœ çÂ«— —ﬁ„Ì »«‘œ.');
    txtName.SetFocus;
  end}
  else if (rdoRelation.ItemIndex = 0) and (cmbBaud.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('”—⁄  «‰ ﬁ«· „‘Œ’ ‰‘œÂ «” .');
    cmbBaud.SetFocus;
  end
  else if (rdoRelation.ItemIndex = 0) and (cmbPort.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('ÅÊ—  «— »«ÿÌ „‘Œ’ ‰‘œÂ «” .');
    cmbPort.SetFocus;
  end
  else if cmbType.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('‰Ê⁄ ”«⁄  „‘Œ’ ‰‘œÂ «” .');
    cmbType.SetFocus;
  end
 else if IsExistsRec_Num('Readers', 'R_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtCode.text <> adoTblReaders.FieldByName('R_Code').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('ﬂœ œ” ê«Â  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Readers', 'R_Name', txtName.Text) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtName.text <> adoTblReaders.FieldByName('R_Name').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('‰«„ œ” ê«Â  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  {else if (Flag = MB_EDIT) and InCircleReader(tblReaders.FieldByName('R_Code').AsInteger) and
         (tblReaders.FieldByName('R_Code').AsString <> txtCode.Text) then
  begin
    AreValidControls := False;
    ErrorMessage('«Ì‰ œ” ê«Â œ— ê—œ‘ »ÊœÂ Ê  €ÌÌ— ﬂœ œ” ê«Â „Ã«“ ‰„Ìù»«‘œ.');
    txtCode.SetFocus;
  end}
  else
  begin
    UserControl := True;
    if (rdoRelation.ItemIndex=0) then
    begin
      if frmComTools.ComPort.Connected then
        frmComTools.ComPort.Close;
      frmComTools.ComPort.Port := cmbPort.Text;

      if frmComTools.ComPort.Open then
        AreValidControls := True
      else
      begin
        ErrorMessage('ÅÊ—  «— »«ÿÌ «‰ Œ«» ‘œÂ ‰«œ—”  «” .');
        cmbPort.SetFocus;
        AreValidControls := False;
      end;
      frmComTools.ComPort.Close;
    end
//kavhe is
    else
    begin
      AreValidControls := True
    end;
//kaveh ie
    UserControl := False;
  end;
end;

procedure TfrmReaders.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := Self.FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmReaders.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetDirectionFarsi(txtName.Handle);
  with adoTblReaders do
  begin
    Connection := frmDBS.DBConnection;
    dtaReaders.DataSet := adoTblReaders;
    Open;
    cmbBaud.Items.Clear;
    for i :=0 to MaxBaudIndex do
      cmbBaud.Items.Add(IntToStr(baudrates[i]));

    cmbType.Items.Add((ReaderNames[RDR_CLK120]));
    cmbType.Items.Add((ReaderNames[RDR_CLK6000]));
    cmbType.Items.Add((ReaderNames[RDR_mF9000]));

    for i := 1 to CNST_MAX_PORT do
      cmbPort.Items.Add('COM' + IntToStr(i));
  end;
  FormInEdit(False);
end;

procedure TfrmReaders.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  with adoTblReaders do
    Close;
end;

procedure TfrmReaders.dbgReadersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmReaders.dbgReadersDblClick(Sender: TObject);
begin
  with adoTblReaders do
    if RecordCount > 0 then
    begin
      Edit;
      FieldByName('R_Active').AsBoolean := not FieldByName('R_Active').AsBoolean;
      Post;
      LoadReaders;
    end;
end;

procedure TfrmReaders.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmReaders.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.cmbBaudKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.cmbPortKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.cmbTypeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.chkModemKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.rdoActiveKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearFields;
end;

procedure TfrmReaders.cmdEditClick(Sender: TObject);
begin
  if adoTblReaders.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetFields;
  end;
end;

procedure TfrmReaders.cmdDeleteClick(Sender: TObject);
begin
  with adoTblReaders do
    if (RecordCount > 0) and
       ConfirmMessage('¬Ì« »—«Ì Õ–› œ” ê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      Delete;
      LoadReaders;
    end;
end;

procedure TfrmReaders.cmdSaveClick(Sender: TObject);
begin
  if AreValidControls then
  begin
    with adoTblReaders do
    begin
      if Flag = MB_NEW then
        Append
      else
        Edit;

      FieldByName('R_Code').AsInteger := StrToInt(txtCode.Text);
      FieldByName('R_Name').AsString := txtName.Text;
      FieldByName('R_BaudNO').AsInteger := cmbBaud.ItemIndex;
      FieldByName('R_Port').AsInteger := cmbPort.ItemIndex+1;
      FieldByName('R_IsCOM').AsBoolean := (rdoRelation.ItemIndex = 0);
      FieldByName('R_TCP').AsBoolean := (cmbProtocol.ItemIndex = 0);
      FieldByName('R_IP').AsString := txtIP.Text;

      case cmbType.ItemIndex of
        0, 1 : FieldByName('R_Type').AsInteger := cmbType.ItemIndex+1;
        2    : FieldByName('R_Type').AsInteger := RDR_mF9000;
      end;
      FieldByName('R_Active').AsBoolean := rdoActive.Checked;
      FieldByName('R_Modem').AsBoolean := chkModem.Checked;
      Post;
      LoadReaders;
    end;
    FormInEdit(False);
    cmdNew.SetFocus;
  end;
//  adoTblReaders.Refresh;
end;

procedure TfrmReaders.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgReaders.SetFocus;
end;

procedure TfrmReaders.adoTblReadersCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('R_Active').AsBoolean then
    DataSet.FieldByName('Active').AsString := ('›⁄«·')
  else
    DataSet.FieldByName('Active').AsString := ('€Ì— ›⁄«·');

  if DataSet.FieldByName('R_Type').AsInteger > 0 then
    DataSet.FieldByName('Type').AsString := (ReaderNames[DataSet.FieldByName('R_Type').AsInteger]);


end;

procedure TfrmReaders.rdoRelationClick(Sender: TObject);
begin
  grpPort.Visible := (rdoRelation.ItemIndex = 0);
  grpLan.Visible := (rdoRelation.ItemIndex = 1);
end;

end.
