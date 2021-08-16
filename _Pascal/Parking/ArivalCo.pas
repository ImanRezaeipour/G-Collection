unit ArivalCo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, Globals,
  FarsiApi, MSGs, Keyboard, DBS, DateProc, ExtCtrls, DosMove;

type
  TfrmArivalCo = class(TForm)
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    cmbBarCode: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    txtDate: TEdit;
    Label4: TLabel;
    txtTime: TEdit;
    cmbDoorCode: TComboBox;
    Label5: TLabel;
    cmbDoorName: TComboBox;
    Label6: TLabel;
    cmbPersonCode: TComboBox;
    cmbPersonName: TComboBox;
    cmdHelp: TBitBtn;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblName: TStaticText;
    lblColor: TStaticText;
    lblCity: TStaticText;
    lblSerial: TStaticText;
    lblNumber: TEdit;
    Label3: TLabel;
    Label8: TLabel;
    lblODate: TStaticText;
    lblOTime: TStaticText;
    Label9: TLabel;
    Label10: TLabel;
    lblDriver: TStaticText;
    lblOAmper: TStaticText;
    Label15: TLabel;
    txtIAmper: TEdit;
    Label16: TLabel;
    lblMasafat: TStaticText;
    Label17: TLabel;
    lblBarCode: TStaticText;
    DosMove1: TDosMove;
    Label26: TLabel;
    lblDepartment: TStaticText;
    lblDepartmentCode: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cmbDoorNameClick(Sender: TObject);
    procedure cmbDoorCodeClick(Sender: TObject);
    procedure cmbPersonCodeClick(Sender: TObject);
    procedure cmbPersonNameClick(Sender: TObject);
    procedure txtTimeExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeExit(Sender: TObject);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDoorCodeExit(Sender: TObject);
    procedure cmbPersonCodeExit(Sender: TObject);
    procedure txtIAmperExit(Sender: TObject);
    procedure txtIAmperKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    m : TMachines;

    procedure ClearScrFields;
    procedure SetScrFields;
    procedure SetMasafat;
    procedure FillBarCodes;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmArivalCo.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label13.Caption := (Label13.Caption);
  Label11.Caption := (Label11.Caption);
  Label14.Caption := (Label14.Caption);
  Label12.Caption := (Label12.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label3.Caption := (Label3.Caption);
  Label10.Caption := (Label10.Caption);
  Label9.Caption := (Label9.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  Label15.Caption := (Label15.Caption);
  Label16.Caption := (Label16.Caption);
  Label17.Caption := (Label17.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmArivalCo.ClearScrFields;
begin
  cmbBarCode.ItemIndex := -1;
  lblName.Caption := '';
  lblColor.Caption := '';
  lblNumber.Text := '';
  lblBarCode.Caption := '';
  lblCity.Caption := '';
  lblSerial.Caption := '';
  lblODate.Caption := '';
  lblOTime.Caption := '';
  lblDriver.Caption := '';
  lblOAmper.Caption := '';
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
  txtIAmper.Text := '';
  lblMasafat.Caption := '';
end;

procedure TfrmArivalCo.SetScrFields;
begin
  lblName.Caption := m.M_CarName;
  lblColor.Caption := m.M_Color;
  lblNumber.Text := m.M_Number;
//kaveh  lblCity.Caption := m.M_CityName;
  lblSerial.Caption := m.M_Serial;
  lblBarCode.Caption := m.M_BarCode;
  lblODate.Caption := m.M_ODate;
  lblOTime.Caption := m.M_OTime;
  lblDriver.Caption := m.Co_Driver;
  lblDriver.Hint := lblDriver.Caption;
  lblDriver.ShowHint := True;
  lblOAmper.Caption := IntToStr(m.Co_OAmper);
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
  SetMasafat;
end;

procedure TfrmArivalCo.SetMasafat;
begin
  if txtIAmper.Text <> '' then
    if StrToInt(txtIAmper.Text) < StrToInt(lblOAmper.Caption) then
    begin
      ErrorMessage('کیلومترشمار فعلی نمیتواند از کیلومترشمار قبلی کوچکتر باشد.');
      txtIAmper.SetFocus;
    end
    else
      lblMasafat.Caption := IntToStr(StrToInt(txtIAmper.Text) - m.Co_OAmper)
  else
    lblMasafat.Caption := '';
end;

procedure TfrmArivalCo.FillBarCodes;
var qry : TAdoQuery;
begin
{kaveh
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  cmbBarCode.Items.Clear;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT IO_BarCode FROM InOutCo WHERE IO_IsPark = False');
  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('IO_BarCode').AsString));
    qry.Next;
  end;
  qry.Close;
}
end;

function TfrmArivalCo.AreValidFields : Boolean;
begin
{  if cmbBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('باركد وارد نشده است.');
    cmbBarCode.SetFocus;
  end
  else if cmbBarCode.Items.IndexOf(cmbBarCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('چنين باركدي وجود ندارد.');
    cmbBarCode.SetFocus;
  end
  else} if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ ورود مشخص نشده است.');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text)then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ ورود نادرست است.');
    txtDate.SetFocus;
  end
  else if txtTime.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('زمان ورود مشخص نشده است.');
    txtTime.SetFocus;
  end
  else if not IsTrueTime(txtTime.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('زمان ورود نادرست است.');
    txtTime.SetFocus;
  end
{  else if cmbDoorCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('درب ورود مشخص نشده است.');
    cmbDoorCode.SetFocus;
  end
  else if cmbDoorCode.Items.IndexOf(cmbDoorCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('چنين درب وروديي تعريف نشده است.');
    cmbDoorCode.SetFocus;
  end
  else if cmbPersonCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('متصدي درب ورود مشخص نشده است.');
    cmbPersonCode.SetFocus;
  end
  else if cmbPersonCode.Items.IndexOf(cmbPersonCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('چنين متصديي تعريف نشده است.');
    cmbPersonCode.SetFocus;
  end}
  else
    AreValidFields := True;
end;


procedure TfrmArivalCo.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(lblNumber.Handle);
  SetDirectionFarsi(cmbDoorName.Handle);
  SetDirectionFarsi(cmbPersonName.Handle);

//kaveh  FillBarCodes;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Depart_Code,Depart_Name FROM Department');
  qry.SQL.Add('WHERE Depart_Code = ' + IntToStr(g_Options.Department) + ' ');
  qry.Open;
  if not qry.EOF then
  begin
    lblDepartment.Caption := ' ' + qry.FieldByName('Depart_Name').AsString;
    lblDepartment.Hint := qry.FieldByName('Depart_Name').AsString;
    lblDepartmentCode.Caption := qry.FieldByName('Depart_Code').AsString;
  end;
  qry.Close;

{kaveh

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers WHERE R_Kind IN (' + IntToStr(MB_IN) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDoorCode.Items.Add((qry.FieldByName('R_Code').AsString));
    cmbDoorName.Items.Add((qry.FieldByName('R_Name').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Persons');
  qry.Open;
  while not qry.EOF do
  begin
    cmbPersonCode.Items.Add((qry.FieldByName('P_BarCode').AsString));
    cmbPersonName.Items.Add((qry.FieldByName('P_Name').AsString));
    qry.Next;
  end;
  qry.Close;
}
  qry.Free;

end;

procedure TfrmArivalCo.FormShow(Sender: TObject);
begin
  Height := 297;
  if lblNumber.Text <> '' then
  begin
    if RequestArivalCoByNumber(lblNumber.Text, lblSerial.Caption , m) then
      SetScrFields
    else
    begin
      ClearScrFields;
      ErrorMessage('این خودرو درون پارکینگ است.');
      cmdSave.Enabled := False;
      txtDate.Enabled := False;
      txtTime.Enabled := False;
      txtIAmper.Enabled := False;
      cmdCancel.SetFocus;
    end;
  end;
end;

procedure TfrmArivalCo.FormActivate(Sender: TObject);
begin
//kaveh  ClearScrFields;
end;

procedure TfrmArivalCo.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDate.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmArivalCo.cmbBarCodeExit(Sender: TObject);
begin
{  if cmbBarCode.Text <> '' then
  begin
    if RequestArivalCo(cmbBarCode.Text, m) then
      SetScrFields
    else
      ClearScrFields;
  end;  }
end;

procedure TfrmArivalCo.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
      txtDate.Text := CurrentDate;
end;

procedure TfrmArivalCo.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtTime.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmArivalCo.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmArivalCo.txtTimeExit(Sender: TObject);
begin
  txtTime.Text := BeautifulTime(txtTime.Text);
end;

procedure TfrmArivalCo.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
      txtTime.Text := CurrentTime;
end;

procedure TfrmArivalCo.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtIAmper.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmArivalCo.txtIAmperKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbDoorCode.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmArivalCo.txtIAmperExit(Sender: TObject);
begin
  SetMasafat;
end;

procedure TfrmArivalCo.cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbPersonCode.SetFocus;
  end;
end;

procedure TfrmArivalCo.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmArivalCo.cmbDoorCodeExit(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorCode.Items.IndexOf(cmbDoorCode.Text);
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmArivalCo.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;


procedure TfrmArivalCo.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmdSave.SetFocus;
  end;
end;

procedure TfrmArivalCo.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmArivalCo.cmbPersonCodeExit(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonCode.Items.IndexOf(cmbPersonCode.Text);
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmArivalCo.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmArivalCo.cmdSaveClick(Sender: TObject);

begin
  if AreValidFields then
  begin
    m.M_BarCode := lblBarCode.Caption; //kaveh cmbBarCode.Text;
    m.M_IDate := txtDate.Text;
    m.M_ITime := txtTime.Text;
//kaveh    m.M_IDoor := StrToInt(cmbDoorCode.Text);
//kaveh    m.M_IPerson := cmbPersonCode.Text;
    if txtIAmper.Text <> '' then
      m.Co_IAmper := StrToInt(txtIAmper.Text)
    else if lblMasafat.Caption <> '' then
      m.Co_IAmper := StrToInt(lblMasafat.Caption)
    else
      m.Co_IAmper := 0;    
//kaveh    UpdateArivalCo(cmbBarCode.Text, m);
    UpdateArivalCoByNumber(lblNumber.Text, lblSerial.Caption, m);
    ClearScrFields;
    Close;
//kaveh    FillBarCodes;
//kaveh    cmbBarCode.SetFocus;
  end;
end;















end.
