unit RdrInf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, Globals, MSGs, FarsiApi,
  DateProc, Keyboard, DBS_Proc,ertebat, CPort, ExtCtrls;

type
  TfrmReaderInf = class(TForm)
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    tblReaders: TAdoTable;
    grpActive: TGroupBox;
    rdoActive: TRadioButton;
    rdoNotActive: TRadioButton;
    grpLan: TGroupBox;
    lbl6: TLabel;
    Label3: TLabel;
    cmbProtocol: TComboBox;
    txtIP: TEdit;
    rdoRelation: TRadioGroup;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    txtCode: TEdit;
    txtName: TEdit;
    cmbType: TComboBox;
    chkModem: TCheckBox;
    chkOnLine: TCheckBox;
    grpPort: TGroupBox;
    lbl3: TLabel;
    Label1: TLabel;
    cmbPort: TComboBox;
    cmbBaud: TComboBox;
    Label12: TLabel;
    cmbBuilding: TComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    chkPrintFish: TCheckBox;
    Label4: TLabel;
    cmbPrinters: TComboBox;
    Label5: TLabel;
    txtLineFeed: TEdit;
    chkAllFihPrc: TCheckBox;
    chkignorename: TCheckBox;
    procedure rdoRelationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBaudKeyPress(Sender: TObject; var Key: Char);
    procedure rdoActiveKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure chkOnLineKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTypeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPortKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTypeClick(Sender: TObject);
    procedure chkModemKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPrintersKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTypeChange(Sender: TObject);
  private
    { Private declarations }

    procedure ClearRecord;
    function  AreValidControls : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
    Code, Flag : Byte;
  end;

implementation

{$R *.DFM}
uses rdrlist,ComTools;
procedure TfrmReaderInf.SetWinF;
begin
end;

procedure TfrmReaderInf.ClearRecord;
begin
  txtCode.Text := '';
  txtName.Text := '';
  cmbBaud.ItemIndex := 9;
  chkOnLine.Checked := False;
  rdoNotActive.Checked := True;
  cmbPort.ItemIndex := 1;
  txtCode.SetFocus;
end;


function TfrmReaderInf.AreValidControls : Boolean;
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
  else if (rdoRelation.ItemIndex = 0) and (cmbBaud.Text = '') then
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
  else if IsExistsRec_Str('Readers', 'R_Name', txtName.Text) and
    ((Flag = MB_NEW) or
    ((Flag = MB_EDIT) and (txtName.text <> tblReaders.FieldByName('R_Name').AsString))) then
  begin
    AreValidControls := False;
    ErrorMessage('‰«„ œ” ê«Â  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else if cmbType.Text = '' then
  begin
    AreValidControls := False;
    ErrorMessage('‰Ê⁄ ﬂ«— ŒÊ«‰ „‘Œ’ ‰Ì” .');
    cmbType.SetFocus;
  end
  else if (rdoRelation.ItemIndex = 0) and (cmbPort.Text = '') then
  begin
    AreValidControls := False;
    ErrorMessage('ÅÊ—  «— »«ÿÌ „‘Œ’ ‰Ì” .');
    cmbPort.SetFocus;
  end
  else                   
  begin
    SetUserControl;
    if (rdoRelation.ItemIndex=0) then
    BEGIN
      frmComTools.ComPort.Close;
      frmComTools.ComPort.Port := cmbPort.Text;
      if frmComTools.ComPort.Open then
        AreValidControls := True
      else
      begin
        ErrorMessage('ÅÊ—  «‰ Œ«»Ì ‰«œ—”  «” .');
        cmbPort.SetFocus;
        AreValidControls := False;
      end;
      frmComTools.ComPort.Close;
    end
    else
      AreValidControls := True;    

    UserControl := False;
  end;
end;


procedure TfrmReaderInf.FormCreate(Sender: TObject);
var
   i:byte;
   adoQry: TAdoQuery;
const
  PrinterName : array [PRN_LX..PRN_CITIZENs2000] of string =
                ('LX Series', 'LQ Series', 'CITIZEN3551', 'CITIZEN3541', 'ithaca', 'Samsung BIXOLON 350' , 'Samsung BIXOLON 350 Plus' , 'CITIZENs2000');
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblReaders.connection := frmDBS.DBConnection;
  cmbBaud.Items.Clear;
    for i := 1 to CNST_MAX_PORT do
      cmbPort.Items.Add('COM' + IntToStr(i));

  for i := 0 to MaxBaudIndex do
    cmbBaud.Items.Add(IntToStr(baudrates[i]));
  for i := RDR_RESTZ84 to RDR_XSTATION do
    cmbType.Items.Add((ReadersName[i]));

  cmbBuilding.Items.Clear;
  adoQry := TAdoQuery.Create(Application);
  with adoQry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM building');
    Open;
    while not EOF do
    begin
      cmbBuilding.Items.Add(FieldByName('building_Code').AsString + '-' + FieldByName('building_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
  for i := PRN_LX to PRN_CITIZENs2000 do cmbPrinters.Items.Add(PrinterName[i]);
end;

procedure TfrmReaderInf.FormActivate(Sender: TObject);
var
  i : integer;
begin
  tblReaders.Open;
  if Flag = MB_EDIT then
  begin
    if tblReaders.locate('r_code' , inttostr(Code),[lopartialkey]) then
    begin
      txtCode.Text := IntToStr(Code);
      txtName.Text := tblReaders.FieldByName('R_Name').AsString;
      rdoActive.Checked := tblReaders.FieldByName('R_Active').AsBoolean;
      rdoNotActive.Checked := not rdoActive.Checked;
      cmbPort.ItemIndex := tblReaders.FieldByName('R_Port').AsInteger - 1;
      cmbBaud.ItemIndex := tblReaders.FieldByName('R_BaudNo').AsInteger;
      chkOnLine.Checked := tblReaders.FieldByName('R_OnLine').AsBoolean;
      cmbType.ItemIndex := tblReaders.FieldByName('R_Type').AsInteger;
      chkmodem.Checked := tblReaders.FieldByName('R_Modem').AsBoolean;
      cmbBuilding.ItemIndex := -1;
      if cmbBuilding.Items.Count > 0 then
        for i := 0 to cmbBuilding.Items.Count-1 do
          if StrToInt(Copy(cmbBuilding.Items.Strings[i], 1, Pos('-', cmbBuilding.Items.Strings[i])-1)) = tblReaders.FieldByName('R_Station').AsInteger then
            cmbBuilding.ItemIndex := i;

      if tblReaders.FieldByName('R_IsCOM').AsBoolean then
        rdoRelation.ItemIndex := 0
      else
        rdoRelation.ItemIndex := 1;

      if tblReaders.FieldByName('R_TCP').AsBoolean then
        cmbProtocol.ItemIndex := 0
      else
        cmbProtocol.ItemIndex := 1;

      txtIP.Text := tblReaders.FieldByName('R_IP').AsString;

      chkprintfish.checked :=tblReaders.FieldByName('R_PrintFish').AsBoolean;
      cmbPrinters.ItemIndex :=tblReaders.FieldByName('R_PrnType').AsInteger;
      txtLineFeed.Text:=inttostr(tblReaders.FieldByName('R_LineFeed').AsInteger);
      chkAllFihPrc.Checked :=tblReaders.FieldByName('R_AllFishPrc').AsBoolean;
      chkignorename.Checked :=tblReaders.FieldByName('R_IgnoreName').AsBoolean;
      cmbTypeChange(Self);
    end;
  end;
end;

procedure TfrmReaderInf.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tblReaders.Close;
end;

procedure TfrmReaderInf.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmReaderInf.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbBaud.SetFocus;
  end;
end;

procedure TfrmReaderInf.cmbBaudKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkOnLine.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmReaderInf.chkOnLineKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbType.SetFocus;
  end;
end;

procedure TfrmReaderInf.cmbTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkModem.SetFocus;
  end;
end;

procedure TfrmReaderInf.chkModemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbPort.SetFocus;
  end;
end;

procedure TfrmReaderInf.cmbPortKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoActive.Checked then
      rdoActive.SetFocus
    else
      rdoNotActive.SetFocus;
  end;
end;

procedure TfrmReaderInf.cmbPrintersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, False);
    tp.SetFocus;
  end;
end;

procedure TfrmReaderInf.rdoActiveKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmReaderInf.rdoRelationClick(Sender: TObject);
begin
  grpPort.Visible := (rdoRelation.ItemIndex = 0);
  grpLan.Visible := (rdoRelation.ItemIndex = 1);
end;

procedure TfrmReaderInf.cmdSaveClick(Sender: TObject);
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
      FieldByName('R_Type').AsInteger := cmbType.ItemIndex;
//      if not (cmbType.ItemIndex in [RDR_RESTZ84, RDR_RESTZ80]) then
//        FieldByName('R_OnLine').AsBoolean := False
//      else
      FieldByName('R_OnLine').AsBoolean := chkOnLine.Checked;
      
      FieldByName('R_Active').AsBoolean := rdoActive.Checked;
      FieldByName('R_Port').AsInteger := cmbPort.ItemIndex + 1;
      FieldByName('R_Modem').AsBoolean := chkModem.Checked;

      FieldByName('R_IsCOM').AsBoolean := (rdoRelation.ItemIndex = 0);
      FieldByName('R_TCP').AsBoolean := (cmbProtocol.ItemIndex = 0);
      FieldByName('R_IP').AsString := txtIP.Text;
      if cmbBuilding.Text <> '' then
        FieldByName('r_Station').AsInteger := StrToInt(Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1))
      else
        FieldByName('r_Station').AsInteger := 0;

      if chkPrintFish.Checked then
        FieldByName('R_PrintFish').AsBoolean := TRUE
      else
        FieldByName('R_PrintFish').AsBoolean := FALSE;
      FieldByName('R_PrnType').AsInteger := cmbPrinters.ItemIndex;
      if txtLineFeed.Text <> '' then
        FieldByName('R_LineFeed').AsInteger := StrToInt(txtLineFeed.Text)
      else
        FieldByName('R_LineFeed').AsInteger := 0;

      if chkAllFihPrc.Checked then
        FieldByName('R_AllFishPrc').AsBoolean := TRUE
      else
        FieldByName('R_AllFishPrc').AsBoolean := FALSE;

      if chkignorename.Checked then
        FieldByName('R_ignorename').AsBoolean := TRUE
      else
        FieldByName('R_ignorename').AsBoolean := FALSE;
        
      Post;
      LoadReaders(True);
    end;
    if Flag = MB_NEW then
      ClearRecord
    else
      Close;
  end;
end;


procedure TfrmReaderInf.cmbTypeChange(Sender: TObject);
begin
 if (cmbType.ItemIndex = RDR_BIOLITE) or (cmbType.ItemIndex = RDR_BIOSTATION) or (cmbType.ItemIndex = RDR_XSTATION) then
 begin
   chkModem.Enabled := False;
   chkModem.Checked := False;
//   chkOnLine.Enabled := False;
//   chkOnLine.Checked := False;
   chkPrintFish.Enabled := False;
   chkPrintFish.Checked := False;
   cmbPrinters.Enabled := False;
   cmbPrinters.ItemIndex := -1;
   txtLineFeed.Enabled := False;
   txtLineFeed.Text := '';
   chkAllFihPrc.Enabled := False;
   chkAllFihPrc.Checked := False;
   chkignorename.Enabled := False;
   chkignorename.Checked := False;
   Label4.Enabled := False;
   Label5.Enabled := False;
 end
 else
 begin
   chkModem.Enabled := True;
//   chkOnLine.Enabled := True;
   chkPrintFish.Enabled := True;
   cmbPrinters.Enabled := True;
   txtLineFeed.Enabled := True;
   chkAllFihPrc.Enabled := True;
   chkignorename.Enabled := True;
   Label4.Enabled := True;
   Label5.Enabled := True;
 end;
end;

procedure TfrmReaderInf.cmbTypeClick(Sender: TObject);
begin
  if cmbType.ItemIndex = RDR_PROXI then
    cmbBaud.ItemIndex := 10;
end;

end.
