unit RdrList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, DBTables, ExtCtrls, DosMove, ADODB,
  Mask;

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
    lbl4: TLabel;
    cmbType: TComboBox;
    chkActive: TCheckBox;
    DosMove1: TDosMove;
    rdoComLan: TRadioGroup;
    grpCom: TGroupBox;
    lbl5: TLabel;
    cmbBaud: TComboBox;
    lbl3: TLabel;
    cmbPort: TComboBox;
    atblReaders: TADOTable;
    grpLan: TGroupBox;
    lbl6: TLabel;
    mskIP: TMaskEdit;
    atblReadersRdr_Code: TIntegerField;
    atblReadersRdr_Name: TWideStringField;
    atblReadersRdr_DpType: TIntegerField;
    atblReadersRdr_ComPort: TIntegerField;
    atblReadersRdr_BaudRate: TIntegerField;
    atblReadersRdr_IP: TWideStringField;
    atblReadersRdr_IsCom: TBooleanField;
    atblReadersRdr_Active: TBooleanField;
    atblReadersActive: TStringField;
    atblReadersType: TStringField;
    grpDepartment: TGroupBox;
    cmbDepartment: TComboBox;
    atblReadersRdr_Department: TIntegerField;
    atblReadersDepart: TStringField;
    Label1: TLabel;
    txtTel: TEdit;
    atblReadersRdr_Tel: TWideStringField;
    procedure txtTelKeyPress(Sender: TObject; var Key: Char);
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
    procedure dbgReadersDblClick(Sender: TObject);
    procedure mskIPKeyPress(Sender: TObject; var Key: Char);
    procedure rdoComLanClick(Sender: TObject);
    procedure atblReadersCalcFields(DataSet: TDataSet);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(edit : Boolean);
    procedure ClearFields;
    procedure Setfields;
    function  AreValidControls : Boolean;
  public
    { Public declarations }
  end;

var
  frmReaders : TfrmReaders;

implementation

uses
  Funcs, ComTools, RunCmnds, MSGs, DBS, FarsiApi, Globals, Keyboard, FntSel;

{$R *.DFM}


procedure TfrmReaders.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmReaders));

end;

procedure TfrmReaders.FormInEdit(edit : Boolean);
begin
  grpList.Enabled := not edit;
  grpInf.Enabled := edit;
  if edit then
    Height := grpList.Height + grpInf.Height
  else
    Height := grpList.Height;
  Height := Height + 25;
  Top := (Screen.Height - Height) div 2;
end;

procedure TfrmReaders.ClearFields;
begin
  txtCode.Text := '';
  txtName.Text := '';
  txtTel.Text := '';
  cmbBaud.ItemIndex := 9;
  cmbPort.ItemIndex := 1;
  cmbType.ItemIndex := 0;
  chkActive.Checked := False;
  chkActive.Checked := True;
  txtCode.SetFocus;
end;

procedure TfrmReaders.Setfields;
var depart : String;
begin
  with atblReaders do
  begin
    depart := FieldByName('Rdr_Department').AsString + '-' + GetDepartmentName(FieldByName('Rdr_Department').AsInteger);
    txtCode.Text := IntToStr(FieldByName('Rdr_Code').AsInteger);
    txtName.Text := FieldByName('Rdr_Name').AsString;
    txtTel.Text  := FieldByName('Rdr_Tel').AsString;
    cmbBaud.ItemIndex := FieldByName('Rdr_BaudRate').AsInteger;
    cmbPort.ItemIndex := FieldByName('Rdr_ComPort').AsInteger - 1;
    cmbType.ItemIndex :=  FieldByName('Rdr_DpType').AsInteger;
    cmbDepartment.ItemIndex := cmbDepartment.Items.IndexOf(depart);
    chkActive.Checked := FieldByName('Rdr_Active').AsBoolean;
    if FieldByName('Rdr_IsCom').AsBoolean then
      rdoComLan.ItemIndex := 0
    else
      rdoComLan.ItemIndex := 1;
    mskIP.Text := FieldByName('Rdr_IP').AsString;
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
  else if cmbDepartment.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('„—ﬂ“ „‘Œ’ ‰‘œÂ «” .');
    cmbDepartment.SetFocus;
  end
  else if (rdoComLan.ItemIndex = 0) and (cmbBaud.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('”—⁄  «‰ ﬁ«· „‘Œ’ ‰‘œÂ «” .');
    cmbBaud.SetFocus;
  end
  else if (rdoComLan.ItemIndex = 0) and (cmbPort.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('ÅÊ—  «— »«ÿÌ „‘Œ’ ‰‘œÂ «” .');
    cmbPort.SetFocus;
  end
  else if (rdoComLan.ItemIndex = 1) and (mskIP.Text = '   .   .   .   ') then
  begin
    AreValidControls := False;
    ErrorMessage('‘„«—Â IP Ê«—œ ‰‘œÂ «” .');
    mskIP.SetFocus;
  end
  else if cmbType.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('‰Ê⁄  —„Ì‰«· „‘Œ’ ‰‘œÂ «” .');
    cmbType.SetFocus;
  end
  else if IsExistsRec_Num('Readers', 'Rdr_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtCode.text <> atblReaders.FieldByName('Rdr_Code').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('ﬂœ œ” ê«Â  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
  begin
    if rdoComLan.ItemIndex = 0 then
    begin
      UserControl := True;
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
      UserControl := False;
    end
    else
      AreValidControls := True;
  end;
end;


procedure TfrmReaders.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  atblReaders.Connection := frmDBS.adoConnect;
  FormInEdit(False);

  cmbBaud.Items.Clear;
  for i :=0 to MaxBaudIndex do
    cmbBaud.Items.Add(IntToStr(baudrates[i]));


  for i := 1 to CNST_MAX_PORT do
    cmbPort.Items.Add('COM' + IntToStr(i));

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' +
                              FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;
  end;

  if gOptions.UserDepart <> 0 then
  begin
    atblReaders.Filter := 'Rdr_Department = ' + IntToStr(gOptions.UserDepart);
    atblReaders.Filtered := True;
  end;

  atblReaders.Open;
end;

procedure TfrmReaders.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblReaders.Close;
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
  if atblReaders.RecordCount > 0 then
  begin
    atblReaders.Edit;
    atblReaders.FieldByName('Rdr_Active').AsBoolean := not atblReaders.FieldByName('Rdr_Active').AsBoolean; 
    atblReaders.Post;
    LoadReaders;
  end;
end;

procedure TfrmReaders.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmReaders.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearFields;
  rdoComLanClick(Sender);
end;

procedure TfrmReaders.cmdEditClick(Sender: TObject);
begin
  if atblReaders.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetFields;
    rdoComLanClick(Sender);
  end;
end;

procedure TfrmReaders.cmdDeleteClick(Sender: TObject);
begin
  if (atblReaders.RecordCount > 0) then
  begin
    if IsExistsRec_Num('Receipt1', 'Recit1_Rdr', atblReaders.FieldByName('Rdr_Code').AsInteger) then
      InformationMessage('«Ì‰ „—ﬂ“ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .')
    else if ConfirmMessage('¬Ì« »—«Ì Õ–› œ” ê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      atblReaders.Delete;
      LoadReaders;
    end;
  end;
end;

procedure TfrmReaders.cmdSaveClick(Sender: TObject);
begin
  if AreValidControls then
  begin
    with atblReaders do
    begin
      if Flag = MB_NEW then
        Append
      else
        Edit;

      FieldByName('Rdr_Code').AsInteger := StrToInt(txtCode.Text);
      FieldByName('Rdr_Name').AsString := txtName.Text;
      FieldByName('Rdr_Tel').AsString := txtTel.Text;
      FieldByName('Rdr_DpType').AsInteger := cmbType.ItemIndex;
      FieldByName('Rdr_Department').AsInteger := StrToInt(Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));
      FieldByName('Rdr_IsCom').AsBoolean := (rdoComLan.ItemIndex = 0);
      FieldByName('Rdr_BaudRate').AsInteger := cmbBaud.ItemIndex;
      FieldByName('Rdr_ComPort').AsInteger := cmbPort.ItemIndex+1;
      FieldByName('Rdr_IP').AsString := mskIP.Text;
      FieldByName('Rdr_Active').AsBoolean := chkActive.Checked;
      Post;
      LoadReaders;
    end;

    if Flag = MB_NEW then
    begin
      ClearFields;
      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgReaders.SetFocus;
    end;
  end;
end;

procedure TfrmReaders.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgReaders.SetFocus;
end;

procedure TfrmReaders.mskIPKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmReaders.rdoComLanClick(Sender: TObject);
begin
  grpCom.Visible := (rdoComLan.ItemIndex = 0);
  grpLan.Visible := (rdoComLan.ItemIndex = 1);
end;

procedure TfrmReaders.atblReadersCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName('Rdr_Active').AsBoolean then
      FieldByName('Active').AsString := ('›⁄«·')
    else
      FieldByName('Active').AsString := ('€Ì—›⁄«·');
      FieldByName('Type').AsString := cmbType.Items[FieldByName('Rdr_DpType').AsInteger];
    if FieldByName('Rdr_Department').AsInteger > 0 then
      FieldByName('Depart').AsString := GetDepartmentName(FieldByName('Rdr_Department').AsInteger);
  end;
end;

procedure TfrmReaders.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmReaders.cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbDepartment.ItemIndex := -1;
end;

procedure TfrmReaders.txtTelKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
