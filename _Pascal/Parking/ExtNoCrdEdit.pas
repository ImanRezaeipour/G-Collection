unit ExtNoCrdEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, ExtCtrls,
  Globals, FarsiApi, MSGs, Keyboard, DBS, DateProc, Cntroler, DosMove, ComCtrls;

type
  TfrmExitNoCardEdit = class(TForm)
    Panel1: TPanel;
    Label10: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    cmbBarCode: TComboBox;
    txtDate: TEdit;
    txtTime: TEdit;
    cmbDoorCode: TComboBox;
    cmbDoorName: TComboBox;
    cmbPersonCode: TComboBox;
    cmbPersonName: TComboBox;
    lblName: TStaticText;
    lblColor: TStaticText;
    lblIDate: TStaticText;
    lblCity: TStaticText;
    lblSerial: TStaticText;
    txtPrice: TEdit;
    txtTakhfif: TEdit;
    lblPayable: TStaticText;
    lblRemain: TStaticText;
    lblITime: TStaticText;
    lblNumber: TEdit;
    lblDiff: TStaticText;
    txtDescribe: TEdit;
    txtMadarek: TEdit;
    cmdHelp: TBitBtn;
    txtCarNumber: TEdit;
    cmdSearch: TBitBtn;
    DosMove1: TDosMove;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cmbDoorNameClick(Sender: TObject);
    procedure cmbDoorCodeClick(Sender: TObject);
    procedure cmbPersonCodeClick(Sender: TObject);
    procedure cmbPersonNameClick(Sender: TObject);
    procedure cmbBarCodeExit(Sender: TObject);
    procedure txtPriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtTakhfifKeyPress(Sender: TObject; var Key: Char);
    procedure txtPriceExit(Sender: TObject);
    procedure txtDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTimeExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDescribeKeyPress(Sender: TObject; var Key: Char);
    procedure txtMadarekKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSearchClick(Sender: TObject);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    machinNoCard : TMachines;
    procedure FillBarCodes;
    procedure ClearScrFields;
    procedure FillScrFields;
    function  AreValidFields : Boolean;
    function  h_m_Str(m : Integer) : String;
    procedure SetWinF;

  public
    { Public declarations }
  end;




implementation

{$R *.DFM}

procedure TfrmExitNoCardEdit.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label24.Caption := (Label24.Caption);
  Label9.Caption := (Label9.Caption);
  Label17.Caption := (Label17.Caption);
  Label8.Caption := (Label8.Caption);
  Label3.Caption := (Label3.Caption);
  Label10.Caption := (Label10.Caption);
  Label19.Caption := (Label19.Caption);
  Label20.Caption := (Label20.Caption);
  Label21.Caption := (Label21.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  Label7.Caption := (Label7.Caption);
  Label13.Caption := (Label13.Caption);
  Label12.Caption := (Label12.Caption);
  Label14.Caption := (Label14.Caption);
  Label11.Caption := (Label11.Caption);
  Label15.Caption := (Label15.Caption);
  Label16.Caption := (Label16.Caption);
  Label18.Caption := (Label18.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label22.Caption := (Label22.Caption);
  Label23.Caption := (Label23.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  cmdSearch.Caption := (cmdSearch.Caption);
end;

procedure TfrmExitNoCardEdit.FillBarCodes;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_Barcode <> ''********'' AND M_IsPark = ' + IntToStr(CNST_TRUE) + ' AND M_IsDeleted = '+ IntToStr(CNST_False));
  qry.Open;

  cmbBarCode.Items.Clear;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('M_BarCode').AsString));
    qry.Next;
  end;
  qry.Close;
  qry.Close;
  qry.Free;
end;

procedure TfrmExitNoCardEdit.ClearScrFields;
begin
  txtCarNumber.Text := '';
  cmbBarCode.ItemIndex := -1;
  lblName.Caption := '';
  lblColor.Caption := '';
  lblNumber.Text := '';
  lblCity.Caption := '';
  lblSerial.Caption := '';
  lblIDate.Caption := '';
  lblITime.Caption := '';
  lblDiff.Caption := '';
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
  txtPrice.Text := '';
  txtTakhfif.Text := '';
  lblPayAble.Caption := '';
  lblRemain.Caption := '';
  cmbDoorCode.ItemIndex := -1;
  cmbDoorName.ItemIndex := -1;
  cmbPersonCode.ItemIndex := -1;
  cmbPersonName.ItemIndex := -1;
  cmdSave.Enabled := True;
end;

procedure TfrmExitNoCardEdit.FillScrFields;
begin
  lblName.Caption := machin.M_CarName;
  lblColor.Caption := machin.M_Color;
  lblNumber.Text := machin.M_Number;
  lblCity.Caption := machin.M_CityName;
  lblSerial.Caption := machin.M_Serial;
  lblIDate.Caption := machin.M_IDate;
  lblITime.Caption := machin.M_ITime;
  lblDiff.Caption := FormatTimes(Differ(machin.M_IDate, machin.M_ITime, machin.M_ODate, machin.M_OTime));
  txtPrice.Text := FloatToStr(machin.M_Price);
  txtTakhfif.Text := FloatToStr(machin.Takhfif);
  lblPayable.Caption := FloatToStr(machin.M_PayAble);
  if machin.Remainder <> 0 then
    lblRemain.Caption := FloatToStr(machin.Remainder);
end;

function TfrmExitNoCardEdit.AreValidFields : Boolean;
begin
  if cmbBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('»«—ﬂœ Ê«—œ ‰‘œÂ «” .');
    cmbBarCode.SetFocus;
  end
  else if cmbBarCode.Items.IndexOf(cmbBarCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('ç‰Ì‰ »«—ﬂœÌ ÊÃÊœ ‰œ«—œ.');
    cmbBarCode.SetFocus;
  end
  else if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text) then
  begin
    AreValidFields := False;
    ErrorMessage(' «—ÌŒ ‰«œ—”  «” .');
    txtDate.SetFocus;
  end
  else if txtTime.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ Œ—ÊÃ „‘Œ’ ‰‘œÂ «” .');
    txtTime.SetFocus;
  end
  else if not IsTrueTime(txtTime.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ Œ—ÊÃ ‰«œ—”  «” .');
    txtTime.SetFocus;
  end
{kaveh871106  else if cmbDoorCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('œ—» Œ—ÊÃ „‘Œ’ ‰‘œÂ «” .');
    cmbDoorCode.SetFocus;
  end
  else if cmbDoorCode.Items.IndexOf(cmbDoorCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('ç‰Ì‰ ˛œ—» Œ—ÊÃÌ  ⁄—Ì› ‰‘œÂ «” .');
    cmbDoorCode.SetFocus;
  end
  else if cmbPersonCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('„ ’œÌ œ—» Œ—ÊÃ „‘Œ’ ‰‘œÂ «” .');
    cmbPersonCode.SetFocus;
  end
  else if cmbPersonCode.Items.IndexOf(cmbPersonCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('ç‰Ì‰ „ ’œÌÌ  ⁄—Ì› ‰‘œÂ «” .');
    cmbPersonCode.SetFocus;
  end}
  else
    AreValidFields := True;
end;

function TfrmExitNoCardEdit.h_m_Str(m : Integer) : String;
var
  s : String;
begin
  if (m div 60) > 0 then
    s := IntToStr(m div 60) + 'h ,  ' + IntToStr(m mod 60) + ''''
  else
    s := IntToStr(m) + '''';
  h_m_Str := s;
end;

procedure TfrmExitNoCardEdit.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(lblNumber.Handle);
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtDescribe.Handle);
  SetDirectionFarsi(txtMadarek.Handle);

  FillBarCodes;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
{kaveh  qry.SQL.Add('SELECT * FROM Readers WHERE R_Kind IN (' + IntToStr(MB_OUT) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDoorCode.Items.Add(qry.FieldByName('R_Code').AsString);
    cmbDoorName.Items.Add(qry.FieldByName('R_Name').AsString);
    qry.Next;
  end;
  qry.Close; kaveh}

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Persons');
  qry.Open;
  while not qry.EOF do
  begin
    cmbPersonCode.Items.Add(qry.FieldByName('P_BarCode').AsString);
    cmbPersonName.Items.Add(qry.FieldByName('P_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
end;

procedure TfrmExitNoCardEdit.FormActivate(Sender: TObject);
begin
  ClearScrFields;
end;

procedure TfrmExitNoCardEdit.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    txtDate.SetFocus;
  end
  else kaveh}
    Keyboard_Hex(Key);
end;

procedure TfrmExitNoCardEdit.txtCarNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
{kaveh  if Key = #13 then
    cmdSearchClick(Sender)
  else  kaveh}
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);

  Key := #0;
end;

procedure TfrmExitNoCardEdit.cmdSearchClick(Sender: TObject);
var
  qry : TAdoQuery;
  BCode : String;
begin
  if txtCarNumber.Text <> '' then
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT M_BarCode, M_Number, M_IDate, M_ITime FROM InputCar WHERE (m_IDate = (SELECT max(M_IDate) FROM InputCar WHERE (M_IsPark = ' + IntToStr(CNST_TRUE) + ' ) AND (M_Number = ''' + txtCarNumber.Text + ''')))');
//    qry.SQL.Add('
//                        M_BarCode
//                'SELECT M_BarCode FROM InputCar WHERE (m_IDate = (select max(m_IDate) from InputCar where (M_IsPark = 1)                             and (M_Number = '123')))
    qry.Open;
    if qry.RecordCount > 0 then
    begin
      machinNoCard.M_BarCode := qry.FieldByName('M_BarCode').AsString;
      machinNoCard.M_Number := qry.FieldByName('M_Number').AsString;
      machinNoCard.M_IDate := qry.FieldByName('M_IDate').AsString;
      machinNoCard.M_ITime := qry.FieldByName('M_ITime').AsString;
      BCode := qry.FieldByName('M_BarCode').AsString;
      cmbBarCode.ItemIndex := cmbBarCode.Items.IndexOf(BCode);
      cmbBarCodeExit(Sender);
    end
    else
    begin
      ErrorMessage('ŒÊœ—Ê »« ç‰Ì‰ ‘„«—Âù«Ì ÊÃÊœ ‰œ«—œ.');
      txtCarNumber.SetFocus;
    end;
    qry.Close;
    qry.Free;
  end
  else
    if cmbBarCode.Text = '' then
      ClearScrFields;
end;

procedure TfrmExitNoCardEdit.cmbBarCodeExit(Sender: TObject);
var ret : Integer;
begin
  if cmbBarCode.Text <> '' then
  begin
    if cmbBarCode.Items.IndexOf(cmbBarCode.Text) <> -1 then
    begin
      machin.M_BarCode := machinNoCard.M_BarCode;
      machin.M_Number := machinNoCard.M_Number;
      machin.M_IDate := machinNoCard.M_IDate;
      machin.M_ITime := machinNoCard.M_ITime;
      machin.M_ODate := txtDate.Text;
      machin.M_OTime := txtTime.Text;
//kaveh new      ret := OutputCar(machin);
      ret := newOutputCar(machin);
      FillScrFields;
      if ret = 0 then
        cmdSave.Enabled := True
      else
      begin
        cmdSave.Enabled := False;
        if (ret and MB_NOTEXIT) <> 0 then
          InformationMessage('«Ì‰ ŒÊœ—Ê „„‰Ê⁄ù«·Œ—ÊÃ „Ìù»«‘œ. Œ—ÊÃ ¬‰ „Ì”— ‰Ì” .')
        else if (ret and MB_MOTAVARI) <> 0 then
          InformationMessage('«Ì‰ ŒÊœ—Ê „ Ê«—Ì „Ìù»«‘œ. Œ—ÊÃ ¬‰ „Ì”— ‰Ì” .');
      end;
    end
    else
    begin
      ErrorMessage('ÂÌç ŒÊœ—ÊÌÌ »« ç‰Ì‰ »«—ﬂœÌ œ— Å«—ﬂÌ‰ê Å«—ﬂ ‰Ì” .');
      cmbBarCode.SetFocus;
    end;
  end
  else
    if txtCarNumber.Text = '' then
      ClearScrFields;
end;

procedure TfrmExitNoCardEdit.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtDate.Text := CurrentDate;
{kaveh    else
      txtTime.SetFocus; kaveh}
  end;
end;

procedure TfrmExitNoCardEdit.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmExitNoCardEdit.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);

  machin.M_ODate := txtDate.Text;
  machin.M_OTime := txtTime.Text;
  CalculPriceField(machin);
  FillScrFields;
end;

procedure TfrmExitNoCardEdit.txtTimeExit(Sender: TObject);
begin
  txtTime.Text := BeautifulTime(txtTime.Text);
  machin.M_ODate := txtDate.Text;
  machin.M_OTime := txtTime.Text;
  CalculPriceField(machin);
  FillScrFields;
end;

procedure TfrmExitNoCardEdit.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtTime.Text := CurrentTime;
{kaveh    else
      txtPrice.SetFocus; kaveh}
  end;
end;

procedure TfrmExitNoCardEdit.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmExitNoCardEdit.txtPriceKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    txtTakhfif.SetFocus;
  end
  else kaveh}
    Keyboard_Integer(Key);
end;

procedure TfrmExitNoCardEdit.txtPriceExit(Sender: TObject);
begin
{  if txtPrice.Text <> '' then
  begin
    if txtTakhfif.Text <> '' then
      lblPayable.Caption := FloatToStr(StrToFloat(txtPrice.Text) - StrToFloat(txtTakhfif.Text))
    else
      lblPayable.Caption := txtPrice.Text;
  end
  else
    lblPayable.Caption := '';}
end;

procedure TfrmExitNoCardEdit.txtTakhfifKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    cmbDoorCode.SetFocus;
  end
  else kaveh}
    Keyboard_Integer(Key);
end;

procedure TfrmExitNoCardEdit.cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbPersonCode.SetFocus;
  end;
end;

procedure TfrmExitNoCardEdit.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmExitNoCardEdit.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;


procedure TfrmExitNoCardEdit.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtDescribe.SetFocus;
  end;
end;

procedure TfrmExitNoCardEdit.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmExitNoCardEdit.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmExitNoCardEdit.txtDescribeKeyPress(Sender: TObject;
  var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    txtMadarek.SetFocus;
  end; kaveh}
end;

procedure TfrmExitNoCardEdit.txtMadarekKeyPress(Sender: TObject;
  var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    if cmdSave.Enabled then
      cmdSave.SetFocus
    else
      cmdCancel.SetFocus;
  end; kaveh}
end;

procedure TfrmExitNoCardEdit.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    machin.M_ODate := txtDate.Text;
    machin.M_OTime := txtTime.Text;
//kaveh    machin.M_ODoor := StrToInt(cmbDoorCode.Text);
//kaveh    machin.M_OPerson := cmbPersonCode.Text;
//kaveh    machin.M_ODoor := StrToInt(cmbDoorCode.Text);
//kaveh    machin.M_OPerson := cmbPersonCode.Text;
//kaveh    machin.M_Price := StrToFloat(txtPrice.Text);
    machin.M_Payable := StrToFloat(lblPayable.Caption);
    newUpdateOutputCar(machin);
    machin.N_Describe := txtDescribe.Text;
    machin.N_Madarek := txtMadarek.Text;
    newAddExitNoCard(machin);
    ClearScrFields;
    FillBarCodes;
    txtCarNumber.SetFocus;
  end;
end;
end.
