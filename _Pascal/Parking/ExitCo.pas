unit ExitCo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, ExtCtrls,
  Globals, FarsiApi, MSGs, Keyboard, DBS, DateProc, Cntroler, DosMove,
  NewPersons;

type
  TfrmExitCo = class(TForm)
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    Label10: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label8: TLabel;
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
    lblName: TStaticText;
    lblColor: TStaticText;
    lblCity: TStaticText;
    lblSerial: TStaticText;
    Label7: TLabel;
    Label11: TLabel;
    txtDriver: TEdit;
    Label12: TLabel;
    txtOAmper: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    lblNumber: TEdit;
    cmdHelp: TBitBtn;
    txtTarget: TEdit;
    txtMojavez: TEdit;
    txtDescribe: TEdit;
    lblBarCode: TStaticText;
    DosMove1: TDosMove;
    cmbDriver: TComboBox;
    cmbDriverCode: TComboBox;
    cmdNewDriver: TSpeedButton;
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
    procedure cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cmbDoorNameClick(Sender: TObject);
    procedure cmbDoorCodeClick(Sender: TObject);
    procedure cmbPersonCodeClick(Sender: TObject);
    procedure cmbPersonNameClick(Sender: TObject);
    procedure cmbBarCodeExit(Sender: TObject);
    procedure txtDriverKeyPress(Sender: TObject; var Key: Char);
    procedure txtOAmperKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTimeExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTargetKeyPress(Sender: TObject; var Key: Char);
    procedure txtMojavezKeyPress(Sender: TObject; var Key: Char);
    procedure txtDescribeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDoorCodeExit(Sender: TObject);
    procedure cmbPersonCodeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbDriverChange(Sender: TObject);
    procedure cmdNewDriverClick(Sender: TObject);
  private
    { Private declarations }
    m : TMachines;

    procedure FillBarCodes;
    procedure ClearScrFields;
    procedure FillScrFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;




implementation

{$R *.DFM}

procedure TfrmExitCo.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label11.Caption := (Label11.Caption);
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

procedure TfrmExitCo.FillBarCodes;
var qry : TAdoQuery;
begin
{kaveh
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Co_BarCode FROM CoCars');
  qry.SQL.Add('WHERE Co_BarCode NOT IN (SELECT IO_BarCode FROM InOutCo WHERE IO_IsPark = False)');
  qry.Open;

  cmbBarCode.Items.Clear;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('Co_BarCode').AsString));
    qry.Next;
  end;
  qry.Close;
  qry.Close;
  qry.Free;
}
end;

procedure TfrmExitCo.ClearScrFields;
begin
  lblBarCode.Caption := '';
  cmbBarCode.ItemIndex := -1;
  cmbDriver.ItemIndex := -1;
  cmbDriverCode.ItemIndex := -1;
  lblName.Caption := '';
  lblColor.Caption := '';
  lblNumber.Text := '';
  lblCity.Caption := '';
  lblSerial.Caption := '';
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
  txtDriver.Text := '';
  txtOAmper.Text := '';
  txtTarget.Text := '';
  txtMojavez.Text := '';
  txtDescribe.Text := '';
//  cmdSave.Enabled := True;
end;

procedure TfrmExitCo.FillScrFields;
begin
  lblName.Caption := m.M_CarName;
  lblColor.Caption := m.M_Color;
  lblNumber.Text := m.M_Number;
//  lblCity.Caption := m.M_CityName;
  lblSerial.Caption := m.M_Serial;
  lblBarCode.Caption := m.M_BarCode;
{
  lblName.Caption := machin.M_CarName;
  lblColor.Caption := machin.M_Color;
  lblNumber.Text := machin.M_Number;
  lblCity.Caption := machin.M_CityName;
  lblSerial.Caption := machin.M_Serial;
}
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
end;

function TfrmExitCo.AreValidFields : Boolean;
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
    ErrorMessage('تاريخ خروج مشخص نشده است.');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ خروج نادرست است.');
    txtDate.SetFocus;
  end
  else if txtTime.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('زمان خروج مشخص نشده است.');
    txtTime.SetFocus;
  end
  else if not IsTrueTime(txtTime.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('زمان خروج نادرست است.');
    txtTime.SetFocus;
  end
{  else if cmbDoorCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('درب خروج مشخص نشده است.');
    cmbDoorCode.SetFocus;
  end
  else if cmbDoorCode.Items.IndexOf(cmbDoorCode.Text) = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('چنين ‏درب خروجي تعريف نشده است.');
    cmbDoorCode.SetFocus;
  end
  else if cmbPersonCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('متصدي درب خروج مشخص نشده است.');
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


procedure TfrmExitCo.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(lblNumber.Handle);
  SetDirectionFarsi(txtDriver.Handle);
  SetDirectionFarsi(txtTarget.Handle);
  SetDirectionFarsi(txtDescribe.Handle);
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

  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
  qry.SQL.Add('WHERE P_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDriver.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
//    cmbWorkDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDriverCode.Items.Add(qry.FieldByName('P_Code').AsString);
//    cmbWorkDepartmentCode.Items.Add(qry.FieldByName('P_Depart').AsString);
    qry.Next;
  end;
  qry.Close;
  
{kaveh
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers WHERE R_Kind IN (' + IntToStr(MB_OUT) + ', ' + IntToStr(MB_INOUT) + ')');
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
    cmbPersonCode.Items.Add(qry.FieldByName('P_BarCode').AsString);
    cmbPersonName.Items.Add(qry.FieldByName('P_Name').AsString);
    qry.Next;
  end;
  qry.Close;
}
  qry.Free;
end;

procedure TfrmExitCo.FormShow(Sender: TObject);
begin
  Height := 328;
  if lblNumber.Text <> '' then
  begin
    if RequestExitCoByNumber(lblNumber.Text, lblSerial.Caption , m) then
      FillScrFields
//      SetScrFields
    else
    begin
      ClearScrFields;
      ErrorMessage('این خودرو قبلا خارج شده است و یا اطلاعات آن موجود نیست.');
      cmdSave.Enabled := False;
      txtDate.Enabled := False;
      txtTime.Enabled := False;
      cmbDriver.Enabled := False;
      cmdNewDriver.Enabled := False;
      txtDriver.Enabled := False;
      txtOAmper.Enabled := False;
      txtTarget.Enabled := False;
      txtMojavez.Enabled := False;
      txtDescribe.Enabled := False;
      cmdCancel.SetFocus;
    end;
  end;
end;

procedure TfrmExitCo.FormActivate(Sender: TObject);
begin
//kaveh  ClearScrFields;
end;

procedure TfrmExitCo.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDate.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmExitCo.cmbBarCodeExit(Sender: TObject);
begin
  if cmbBarCode.Text <> '' then
  begin
    if cmbBarCode.Items.IndexOf(cmbBarCode.Text) <> -1 then
    begin
      GetCoCar(cmbBarCode.Text, machin);
      FillScrFields;
    end
    else
    begin
      ErrorMessage('خودرو با چنين باركدي در پاركينگ نيست.');
      cmbBarCode.SetFocus;
    end;
  end;
end;

procedure TfrmExitCo.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtDate.Text := CurrentDate;
  end;
end;

procedure TfrmExitCo.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtTime.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmExitCo.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmExitCo.txtTimeExit(Sender: TObject);
begin
  txtTime.Text := BeautifulTime(txtTime.Text);
end;

procedure TfrmExitCo.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtTime.Text := CurrentTime;
  end;
end;

procedure TfrmExitCo.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDriver.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmExitCo.txtDriverKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtOAmper.SetFocus;
  end;
end;

procedure TfrmExitCo.txtOAmperKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtTarget.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmExitCo.txtTargetKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtMojavez.SetFocus;
  end;
end;

procedure TfrmExitCo.txtMojavezKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDescribe.SetFocus;
  end;
end;

procedure TfrmExitCo.txtDescribeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbDoorCode.SetFocus;
  end;
end;

procedure TfrmExitCo.cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbPersonCode.SetFocus;
  end;
end;

procedure TfrmExitCo.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmExitCo.cmbDoorCodeExit(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorCode.Items.IndexOf(cmbDoorCode.Text);
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmExitCo.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;


procedure TfrmExitCo.cmbDriverChange(Sender: TObject);
begin
  cmbDriver.Hint := cmbDriver.Text;
  cmbDriverCode.ItemIndex := cmbDriver.ItemIndex;
{  cmbWorkDepartment.ItemIndex := cmbDriver.ItemIndex;
  cmbWorkDepartmentCode.ItemIndex := cmbWorkDepartment.ItemIndex;
  lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
  lblWorkDepartment.Hint := cmbWorkDepartment.Text;}
end;

procedure TfrmExitCo.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
{    if cmdSave.Enabled then
      cmdSave.SetFocus
    else
      cmdCancel.SetFocus; }
  end;
end;

procedure TfrmExitCo.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmExitCo.cmbPersonCodeExit(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonCode.Items.IndexOf(cmbPersonCode.Text);
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmExitCo.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmExitCo.cmdNewDriverClick(Sender: TObject);
var
  frmNewPersons : TfrmNewPersons;
  qry : TAdoQuery;
begin
  Application.CreateForm(TfrmNewPersons, frmNewPersons);
  frmNewPersons.ShowModal;
  frmNewPersons.Free;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
  qry.SQL.Add('WHERE P_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDriver.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
//    cmbWorkDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDriverCode.Items.Add(qry.FieldByName('P_Code').AsString);
//    cmbWorkDepartmentCode.Items.Add(qry.FieldByName('P_Depart').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;  

end;

procedure TfrmExitCo.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    m.M_BarCode := lblBarCode.Caption; //kaveh cmbBarCode.Text;
    m.M_ODate := txtDate.Text;
    m.M_OTime := txtTime.Text;
//kaveh    m.M_ODoor := StrToInt(cmbDoorCode.Text);
//kaveh    m.M_OPerson := cmbPersonCode.Text;
    m.Co_Driver := cmbDriverCode.Text;//kaveh txtDriver.Text;
    m.M_Number := lblNumber.Text;
    m.M_Serial := lblSerial.Caption;
    m.Co_ODepart := StrToInt(lblDepartmentCode.Caption);
    if txtOAmper.Text <> '' then
      m.Co_OAmper := StrToInt(txtOAmper.Text)
    else
      m.Co_OAmper := 0;
    m.Co_Target := txtTarget.Text;
    m.Co_Mojavez := txtMojavez.Text;
    m.Co_Describe := txtDescribe.Text;
    
    ExitOutputCoCar(m);

{kaveh
    machin.M_BarCode := cmbBarCode.Text;
    machin.M_ODate := txtDate.Text;
    machin.M_OTime := txtTime.Text;
    machin.M_ODoor := StrToInt(cmbDoorCode.Text);
    machin.M_OPerson := cmbPersonCode.Text;
    machin.Co_Driver := txtDriver.Text;
    if txtOAmper.Text <> '' then
      machin.Co_OAmper := StrToInt(txtOAmper.Text)
    else
      machin.Co_OAmper := 0;
    machin.Co_Target := txtTarget.Text;
    machin.Co_Mojavez := txtMojavez.Text;
    machin.Co_Describe := txtDescribe.Text;
    ExitOutputCoCar(machin);
}
    ClearScrFields;
    Close;
//kaveh    FillBarCodes;
//kaveh    cmbBarCode.SetFocus;
  end;
end;






























end.
