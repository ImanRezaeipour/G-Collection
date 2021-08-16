unit RdrList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, ExtCtrls, Globals,
  FarsiApi, MSGs, DBS, Keyboard, ComTools, CPort, RunCmnds, DosMove;

type
  TfrmReaders = class(TForm)
    DosMove1: TDosMove;
    grpList: TGroupBox;
    dbgReaders: TDBGrid;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    BitBtn1: TBitBtn;
    grpInf: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    grpLan: TGroupBox;
    lbl6: TLabel;
    Label2: TLabel;
    cmbProtocol: TComboBox;
    txtIP: TEdit;
    grpPort: TGroupBox;
    lbl3: TLabel;
    Label1: TLabel;
    cmbPort: TComboBox;
    cmbBaud: TComboBox;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    txtCode: TEdit;
    txtName: TEdit;
    grpStat: TGroupBox;
    rdoActive: TRadioButton;
    rdoNotActive: TRadioButton;
    chkModem: TCheckBox;
    cmbType: TComboBox;
    cmbStation: TComboBox;
    rdoRelation: TRadioGroup;
    tblReaders: TAdoTable;
    tblReadersR_Code: TSmallintField;
    tblReadersR_Name: TStringField;
    tblReadersType: TStringField;
    tblReadersActive: TStringField;
    tblReadersR_Port: TSmallintField;
    tblReadersR_BaudNo: TSmallintField;
    dtaReaders: TDataSource;
    tblReadersR_Active: TStringField;
    tblReadersR_IP: TStringField;
    tblReadersR_TCP: TBooleanField;
    tblReadersR_IsCOM: TBooleanField;
    tblReadersR_Type: TSmallintField;
    tblReadersR_Modem: TBooleanField;
    Label3: TLabel;
    cmbDepartment: TComboBox;
    cmbDepartmentCode: TComboBox;
    tblReadersR_Depart: TIntegerField;
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
    procedure cmbStationKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure tblReadersCalcFields(DataSet: TDataSet);
    procedure cmbDepartmentChange(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(edit : Boolean);
    procedure ClearFields;
    procedure Setfields;
    function  AreValidControls : Boolean;
    procedure SendTab(var Key : Char);
    procedure TblReadersRefresh();    
  public
    { Public declarations }
  end;

implementation


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

procedure TfrmReaders.tblReadersCalcFields(DataSet: TDataSet);
begin
  if tblReaders.FieldByName('R_Type').AsString = '0' then
    tblReaders.FieldByName('Type').AsString := 'کنترل پارکينگ PCT2000'
  else if tblReaders.FieldByName('R_Type').AsString = '1' then
    tblReaders.FieldByName('Type').AsString := 'ساعت CLK6000'
  else
    tblReaders.FieldByName('Type').AsString := 'نامعتبر!';

  if tblReaders.FieldByName('R_Active').AsBoolean then
    tblReaders.FieldByName('Active').AsString := 'فعال'
  else
    tblReaders.FieldByName('Active').AsString := 'غیرفعال';
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
  cmbBaud.ItemIndex := 4;
  cmbPort.ItemIndex := 0;
  cmbType.ItemIndex := 0;
  cmbStation.ItemIndex := -1;
  chkModem.Checked := False;
  rdoActive.Checked := True;
  rdoRelation.ItemIndex := 0;
  txtCode.SetFocus;
  if cmbDepartment.ItemIndex = -1 then
  begin
    cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(IntToStr(g_Options.Department));
    cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;
  end;  
end;

procedure TfrmReaders.Setfields;
begin
  with tblReaders do
  begin
    txtCode.Text := IntToStr(FieldByName('R_Code').AsInteger);
    txtName.Text := FieldByName('R_Name').AsString;
    cmbBaud.ItemIndex := FieldByName('R_BaudNo').AsInteger;
    rdoActive.Checked := FieldByName('R_Active').AsBoolean;
    rdoNotActive.Checked := not rdoActive.Checked;
    cmbPort.ItemIndex := FieldByName('R_Port').AsInteger-1;
    if FieldByName('R_Type').AsString <> '' then
      cmbType.ItemIndex := FieldByName('R_Type').AsInteger;
    if FieldByName('R_Depart').AsString <> '' then
    begin
      cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(FieldByName('R_Depart').AsString);
      cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;
    end
    else
    begin
      cmbDepartmentCode.ItemIndex := -1;
      cmbDepartment.ItemIndex := -1;
    end;
    if FieldByName('R_IsCOM').AsBoolean then
      rdoRelation.ItemIndex := 0
    else
      rdoRelation.ItemIndex := 1;

    if FieldByName('R_TCP').AsBoolean then
      cmbProtocol.ItemIndex := 0
    else
      cmbProtocol.ItemIndex := 1;

    txtIP.Text := FieldByName('R_IP').AsString;

  end;
  txtCode.SetFocus;
end;

function TfrmReaders.AreValidControls : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('نام دستگاه وارد نشده است.');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('كد دستگاه وارد نشده است.');
    txtCode.SetFocus;
  end
  else if cmbBaud.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('سرعت انتقال مشخص نشده است.');
    cmbBaud.SetFocus;
  end
  else if cmbPort.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('پورت ارتباطي مشخص نشده است.');
    cmbPort.SetFocus;
  end
  else if IsExistsRec_Num('Readers', 'R_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtCode.text <> tblReaders.FieldByName('R_Code').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('كد دستگاه تكراري است.');
    txtCode.SetFocus;
  end
  {else if (Flag = MB_EDIT) and InCircleReader(tblReaders.FieldByName('R_Code').AsInteger) and
         (tblReaders.FieldByName('R_Code').AsString <> txtCode.Text) then
  begin
    AreValidControls := False;
    ErrorMessage('اين دستگاه در گردش بوده و تغيير كد دستگاه مجاز نمي‌باشد.');
    txtCode.SetFocus;
  end}
  else if (rdoRelation.ItemIndex = 0) and (cmbBaud.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('سرعت انتقال مشخص نشده است.');
    cmbBaud.SetFocus;
  end
  else if (rdoRelation.ItemIndex = 0) and (cmbPort.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('پورت ارتباطي مشخص نشده است.');
    cmbPort.SetFocus;
  end
  else
  begin
    UserControl := True;
    if frmComTools.ComPort.Connected then
      frmComTools.ComPort.Close;

    frmComTools.ComPort.Port := 'COM' + IntToStr(cmbPort.ItemIndex+1);

    if frmComTools.ComPort.Open then
      AreValidControls := True
    else
    begin
      ErrorMessage('پورت ارتباطي انتخاب شده نادرست است.');
      AreValidControls := False;
    end;
    frmComTools.ComPort.Close;
    UserControl := False;
  end;


end;

procedure TfrmReaders.BitBtn1Click(Sender: TObject);
begin
//  with adoTblReaders do
//  begin
//    if recordcount>0 then
//    begin
//      try
//        SetCameraAttF := TSetCameraAttF.Create(self, FieldByName('R_Name').AsString,
//                                                     FieldByName('R_Code').AsString,
//                                                     FieldByName('R_FrameRate').AsString,
//                                                     FieldByName('R_LastFrame').AsString);
//        SetCameraAttF.ShowModal();
//      finally
//        SetCameraAttF.Free();
//        TblReadersRefresh();
//      end;
//    end;
//  end;
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
var
  i : Byte;
  qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblReaders.connection := frmDBS.adoConnect;
  cmbBaud.Items.Clear;
  cmbPort.Items.Clear;
  for i := 1 to 255 do
    cmbPort.Items.Add('COM'+IntToStr(i));
  for i := 0 to MaxBaudIndex do
    cmbBaud.Items.Add((IntToStr(baudrates[i])));

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

  qry.Free;

  tblReaders.Open;
  FormInEdit(False);
end;

procedure TfrmReaders.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblReaders.Close;
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
  if tblReaders.RecordCount > 0 then
  begin
    tblReaders.Edit;
    tblReaders.FieldByName('R_Active').AsBoolean := not tblReaders.FieldByName('R_Active').AsBoolean;
    tblReaders.Post;
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

procedure TfrmReaders.cmbDepartmentChange(Sender: TObject);
begin
  cmbDepartmentCode.ItemIndex := cmbDepartment.ItemIndex;
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
  if tblReaders.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetFields;
  end;
end;

procedure TfrmReaders.cmdDeleteClick(Sender: TObject);
begin
  if tblReaders.RecordCount > 0 then
  begin
    if not InCircleReader(tblReaders.FieldByName('R_Code').AsInteger) then
    begin
      if ConfirmMessage('آيا براي حذف دستگاه اطمينان داريد؟') then
      begin
        tblReaders.Delete;
        LoadReaders;
      end;
    end
    else
      InformationMessage('اين دستگاه در گردش بوده و حذف آن امكان پذير نيست.');
  end;
end;

procedure TfrmReaders.cmdSaveClick(Sender: TObject);
begin
  if AreValidControls then
  begin
    with tblReaders do
    begin
      if Flag = MB_NEW then
        Append
      else
        Edit;

      FieldByName('R_Code').AsInteger := StrToInt(txtCode.Text);
      FieldByName('R_Name').AsString := txtName.Text;
      FieldByName('R_BaudNO').AsInteger := cmbBaud.ItemIndex;

      FieldByName('R_Port').AsInteger := cmbPort.ItemIndex+1;

      FieldByName('R_Type').AsInteger := cmbType.ItemIndex;

      FieldByName('R_IsCOM').AsBoolean := (rdoRelation.ItemIndex = 0);
      FieldByName('R_TCP').AsBoolean := (cmbProtocol.ItemIndex = 0);
      FieldByName('R_IP').AsString := txtIP.Text;

//      case cmbType.ItemIndex of
//        0, 1 : FieldByName('R_Type').AsInteger := cmbType.ItemIndex+1;
//        2    : FieldByName('R_Type').AsInteger := RDR_mF9000;
//        3    : FieldByName('R_Type').AsInteger := RDR_bioStation;
//      end;
      FieldByName('R_Active').AsBoolean := rdoActive.Checked;
      if cmbDepartmentCode.ItemIndex > -1 then
        FieldByName('R_Depart').AsInteger := StrToInt(cmbDepartmentCode.Text);

      Post;
      LoadReaders;
    end;
    FormInEdit(False);
    cmdNew.SetFocus;
  end;
end;

procedure TfrmReaders.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgReaders.SetFocus;
end;

procedure TfrmReaders.adoTblReadersCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('R_Active').AsBoolean then
    DataSet.FieldByName('Active').AsString := ('فعال')
  else
    DataSet.FieldByName('Active').AsString := ('غير فعال');

//  if DataSet.FieldByName('R_Type').AsInteger > 0 then
//    DataSet.FieldByName('Type').AsString := (ReaderNames[DataSet.FieldByName('R_Type').AsInteger]);


//  if DataSet.FieldByName('R_station').AsInteger > 0 then
//    DataSet.FieldByName('Station').AsString :=   getStationName(Readers[FindReaderCodeIdx(DataSet.FieldByName('R_Code').AsInteger)].R_Station);
end;

procedure TfrmReaders.cmbStationKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmReaders.rdoRelationClick(Sender: TObject);
begin
  grpPort.Visible := (rdoRelation.ItemIndex = 0);
  grpLan.Visible := (rdoRelation.ItemIndex = 1);
end;
procedure TfrmReaders.TblReadersRefresh;
begin
//  with adoTblReaders do
//  begin
//    Close();
//    Connection := frmDBS.DBConnection;
//    Open();
//  end;
end;

end.
