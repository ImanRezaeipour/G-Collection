unit Readers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, Globals, ComTools, MSGs, FarsiApi,
  DateProc, Keyboard, DBS, RunCmnds;

type
  TfrmReaders = class(TForm)
    cmbLast: TBitBtn;
    cmdFirst: TBitBtn;
    cmdNext: TBitBtn;
    cmdBefore: TBitBtn;
    cmdDelete: TBitBtn;
    cmdNew: TBitBtn;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    cmdExit: TBitBtn;
    tblReaders: TAdoTable;
    grpFields: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    lblBaud: TLabel;
    txtCode: TEdit;
    txtName: TEdit;
    cmbBaud: TComboBox;
    grpActive: TGroupBox;
    grpKind: TGroupBox;
    grpPort: TGroupBox;
    rdoActive: TRadioButton;
    rdoNotActive: TRadioButton;
    rdoExit: TRadioButton;
    rdoBoth: TRadioButton;
    rdoCom1: TRadioButton;
    rdoCom2: TRadioButton;
    rdoEnter: TRadioButton;
    cmdEdit: TBitBtn;
    grpRelation: TGroupBox;
    rdoReader: TRadioButton;
    rdoComputer: TRadioButton;
    Label2: TLabel;
    txtDisplayCode: TEdit;
    cmdHelp: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdFirstClick(Sender: TObject);
    procedure cmbLastClick(Sender: TObject);
    procedure cmdBeforeClick(Sender: TObject);
    procedure cmdNextClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBaudKeyPress(Sender: TObject; var Key: Char);
    procedure rdoActiveKeyPress(Sender: TObject; var Key: Char);
    procedure rdoEnterKeyPress(Sender: TObject; var Key: Char);
    procedure rdoCom1KeyPress(Sender: TObject; var Key: Char);
    procedure cmdEditClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rdoReaderKeyPress(Sender: TObject; var Key: Char);
    procedure rdoEnterClick(Sender: TObject);
    procedure rdoExitKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure ViewRecord;
    procedure ClearRecord;
    procedure Editable(t : Boolean);
    function  AreValidControls : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmReaders.Editable(t : Boolean);
begin
  grpFields.Enabled := t;
  cmdNew.Enabled := not t;
  cmdEdit.Enabled := not t;
  cmdDelete.Enabled := not t;
  cmdSave.Enabled := t;
  cmdCancel.Enabled := t;
end;

procedure TfrmReaders.ClearRecord;
begin
  rdoReader.Checked := True;
  txtCode.Text := '';
  txtName.Text := '';
  cmbBaud.ItemIndex := 9;
  txtDisplayCode.Text := '';
  rdoNotActive.Checked := True;
  rdoEnter.Checked := True;
  rdoCom2.Checked := True;
end;

procedure TfrmReaders.ViewRecord;
begin
  with tblReaders do
  begin
    txtCode.Text := IntToStr(FieldByName('R_Code').AsInteger);
    txtName.Text := FieldByName('R_Name').AsString;
    cmbBaud.ItemIndex := FieldByName('R_BaudNo').AsInteger;
    rdoActive.Checked := FieldByName('R_Active').AsBoolean;
    rdoNotActive.Checked := not rdoActive.Checked;
    case FieldByName('R_Kind').AsInteger of
      MB_IN : rdoEnter.Checked := True;
      MB_OUT : rdoExit.Checked := True;
      MB_INOUT : rdoBoth.Checked := True;
    end;
    txtDisplayCode.Text := IntToStr(FieldByName('R_DisplayCode').AsInteger);
    case FieldByName('R_Port').AsInteger of
      1 : rdoCom1.Checked := True;
      2 : rdoCom2.Checked := True;
    end;
    rdoComputer.Checked := True;
    rdoReader.Checked := FieldByName('R_IsReader').AsBoolean;
  end;
end;

function TfrmReaders.AreValidControls : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('‰«„ œ” ê«Â Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('ﬂœ œ” ê«Â Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if cmbBaud.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('”—⁄  «‰ ﬁ«· „‘Œ’ ‰‘œÂ «” .');
    cmbBaud.SetFocus;
  end
  else if IsExistsRec_Num('Readers', 'R_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtCode.text <> tblReaders.FieldByName('R_Code').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('ﬂœ œ” ê«Â  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  {else if (Flag = MB_EDIT) and InCircleReader(tblReaders.FieldByName('R_Code').AsInteger) and
         (tblReaders.FieldByName('R_Code').AsString <> txtCode.Text) then
  begin
    AreValidControls := False;
    ErrorMessage('«Ì‰ œ” ê«Â œ— ê—œ‘ »ÊœÂ Ê  €ÌÌ— ﬂœ œ” ê«Â „Ã«“ ‰„Ìù»«‘œ.');
    txtCode.SetFocus;
  end}
  else
    AreValidControls := True;
end;


procedure TfrmReaders.FormCreate(Sender: TObject);
var
   i:byte;
begin
  SetDirectionFarsi(txtName.Handle);
  tblReaders.connection := frmDBS.adoConnect;
  cmbBaud.Items.Clear;
  for i:=0 to MaxBaudIndex do
    cmbBaud.Items.Add(IntToStr(baudrates[i]));

  tblReaders.Open;
  if tblReaders.RecordCount > 0 then
  begin
    ViewRecord;
    Editable(False);
  end
  else
  begin
    Flag := MB_NEW;
    Editable(True);
  end;

end;

procedure TfrmReaders.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tblReaders.Close;
end;

procedure TfrmReaders.rdoReaderKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmReaders.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmReaders.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbBaud.SetFocus;
  end;
end;

procedure TfrmReaders.cmbBaudKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoEnter.Checked then
      rdoEnter.SetFocus
    else if rdoExit.Checked then
      rdoExit.SetFocus
    else
      rdoBoth.SetFocus;
  end;
end;

procedure TfrmReaders.rdoActiveKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoCom1.Checked then
      rdoCom1.SetFocus
    else
      rdoCom2.SetFocus;
  end;
end;

procedure TfrmReaders.rdoEnterKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoActive.Checked then
      rdoActive.SetFocus
    else
      rdoNotActive.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmReaders.rdoExitKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtDisplayCode.SetFocus;
  end;
end;

procedure TfrmReaders.rdoEnterClick(Sender: TObject);
begin
  txtDisplayCode.Enabled := not rdoEnter.Checked;
end;

procedure TfrmReaders.rdoCom1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if cmdSave.Enabled then
      cmdSave.SetFocus
    else
      cmdFirst.SetFocus;
  end;
end;

procedure TfrmReaders.cmdFirstClick(Sender: TObject);
begin
  Editable(False);
  tblReaders.First;
  if tblReaders.RecordCount > 0 then
    ViewRecord
  else
    ClearRecord;
end;

procedure TfrmReaders.cmbLastClick(Sender: TObject);
begin
  Editable(False);
  tblReaders.Last;
  if tblReaders.RecordCount > 0 then
    ViewRecord
  else
    ClearRecord;
end;

procedure TfrmReaders.cmdBeforeClick(Sender: TObject);
begin
  if not tblReaders.BOF then
  begin
    Editable(False);
    tblReaders.Prior;
    if tblReaders.RecordCount > 0 then
      ViewRecord
    else
      ClearRecord;
  end;
end;

procedure TfrmReaders.cmdNextClick(Sender: TObject);
begin
  if not tblReaders.EOF then
  begin
    Editable(False);
    tblReaders.Next;
    if tblReaders.RecordCount > 0 then
      ViewRecord
    else
      ClearRecord;
  end;
end;

procedure TfrmReaders.cmdNewClick(Sender: TObject);
begin
  Flag := MB_NEW;
  ClearRecord;
  Editable(True);
  rdoReader.SetFocus;
end;

procedure TfrmReaders.cmdEditClick(Sender: TObject);
begin
  if tblReaders.RecordCount > 0 then
  begin
    Flag := MB_EDIT;
    Editable(True);
    if rdoReader.Checked then
      rdoReader.SetFocus
    else
      rdoComputer.SetFocus;
  end;
end;

procedure TfrmReaders.cmdDeleteClick(Sender: TObject);
begin
  if tblReaders.RecordCount > 0 then
  begin
    if not InCircleReader(tblReaders.FieldByName('R_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› œ” ê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblReaders.Delete;
        LoadReaders;
      end;
      if tblReaders.RecordCount > 0 then
        ViewRecord
      else
        ClearRecord;
    end
    else
      InformationMessage('«Ì‰ œ” ê«Â œ— ê—œ‘ »ÊœÂ Ê  €ÌÌ— ﬂœ œ” ê«Â „Ã«“ ‰„Ìù»«‘œ.');
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
      FieldByName('R_Active').AsBoolean := rdoActive.Checked;
      if rdoEnter.Checked then
      begin
        FieldByName('R_Kind').AsInteger := MB_IN;
        FieldByName('R_DisplayCode').AsInteger := 0;
      end
      else if rdoExit.Checked then
      begin
        FieldByName('R_Kind').AsInteger := MB_OUT;
        FieldByName('R_DisplayCode').AsInteger := StrToInt(txtDisplayCode.Text);
      end
      else if rdoBoth.Checked then
      begin
        FieldByName('R_Kind').AsInteger := MB_INOUT;
        FieldByName('R_DisplayCode').AsInteger := StrToInt(txtDisplayCode.Text);
      end;

      if rdoCom1.Checked then
        FieldByName('R_Port').AsInteger := 1
      else if rdoCom2.Checked then
        FieldByName('R_Port').AsInteger := 2;

      FieldByName('R_IsReader').AsBoolean := rdoReader.Checked;

      Post;
      LoadReaders;
    end;
    Editable(False);
    cmdNew.SetFocus;
  end;
end;

procedure TfrmReaders.cmdCancelClick(Sender: TObject);
begin
  ViewRecord;
  Editable(False);
end;








end.
