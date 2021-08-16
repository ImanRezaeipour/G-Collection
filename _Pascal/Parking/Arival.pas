unit Arival;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, Globals,
  FarsiApi, MSGs, Keyboard, DBS, DateProc, ExtCtrls, DosMove, NewPersons,
  cars, colors, ArivalCo;
type
  TfrmArival = class(TForm)
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    txtSerial: TEdit;
    Label10: TLabel;
    cmbCarColor: TComboBox;
    Label17: TLabel;
    cmbCarCity: TComboBox;
    Label3: TLabel;
    cmbCarName: TComboBox;
    Label9: TLabel;
    Label8: TLabel;
    txtCarNumber: TEdit;
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
    DosMove1: TDosMove;
    Label7: TLabel;
    cmbDriver: TComboBox;
    Label11: TLabel;
    cmbWorkDepartment: TComboBox;
    cmdNewDriver: TSpeedButton;
    cmdNewOffice: TSpeedButton;
    Label12: TLabel;
    cmbVisited: TComboBox;
    cmdNewVisited: TSpeedButton;
    Label13: TLabel;
    cmbEntranceDepartment: TComboBox;
    cmdNewEntrance: TSpeedButton;
    cmdNewCarName: TSpeedButton;
    cmdNewCarColor: TSpeedButton;
    lblWorkDepartment: TStaticText;
    lblEntranceDepartment: TStaticText;
    lblResult: TStaticText;
    cmbDriverCode: TComboBox;
    cmbWorkDepartmentCode: TComboBox;
    cmbVisitedCode: TComboBox;
    lblEntranceDepartmentCode: TStaticText;
    cmdExitCar: TBitBtn;
    cmdOpenDoor: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarColorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarColorEnter(Sender: TObject);
    procedure cmbCarCityEnter(Sender: TObject);
    procedure cmbCarCityKeyPress(Sender: TObject; var Key: Char);
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
    procedure FormShow(Sender: TObject);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDriverChange(Sender: TObject);
    procedure cmbVisitedChange(Sender: TObject);
    procedure txtSerialExit(Sender: TObject);
    procedure txtCarNumberChange(Sender: TObject);
    procedure txtSerialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdNewDriverClick(Sender: TObject);
    procedure cmdExitCarClick(Sender: TObject);
    procedure cmdNewCarNameClick(Sender: TObject);
    procedure cmdNewCarColorClick(Sender: TObject);
    procedure cmdOpenDoorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    SrchStr : String;

    procedure ClearScrFields;
    procedure FillBarCodes;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;




implementation

{$R *.DFM}
uses main, ExitCar;


procedure TfrmArival.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label9.Caption := (Label9.Caption);
  Label17.Caption := (Label17.Caption);
  Label10.Caption := (Label10.Caption);
  Label3.Caption := (Label3.Caption);
  Label8.Caption := (Label8.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmArival.cmdExitCarClick(Sender: TObject);
var
  frmExitCar : TfrmExitCar;
  s : String;
begin
  Application.CreateForm(TfrmExitCar, frmExitCar);
  s := '&خروج وسيله نقليه... (دستي)';//main.mnu1ExitCar.Caption;
  Delete(s, Pos('&', s), 1);
  Delete(s, Pos('...', s), 3);
  frmExitCar.Caption := s;
  frmExitCar.ShowModal;
  frmExitCar.Free;
end;

procedure TfrmArival.cmdOpenDoorClick(Sender: TObject);
begin
  frmMain.mnu1OpenDoorClick(self);
end;

procedure TfrmArival.ClearScrFields;
begin
//kaveh  cmbBarCode.ItemIndex := -1;
  cmbCarName.ItemIndex := -1;
  cmbCarColor.ItemIndex := -1;
  txtCarNumber.Text := '';
  cmbCarCity.ItemIndex := -1;
  txtSerial.Text := '';
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
  SrchStr := '';

  cmbDriver.ItemIndex := -1;
  cmbDriver.Hint := ' ';
  cmbDriverCode.ItemIndex := -1;
  cmbWorkDepartment.ItemIndex := -1;
  cmbWorkDepartmentCode.ItemIndex := -1;
  lblWorkDepartment.Caption := '';
  lblWorkDepartment.Hint := ' ';
  cmbVisited.ItemIndex := -1;
  cmbVisited.Hint := ' ';
  cmbVisitedCode.ItemIndex := -1;

  Label7.Enabled := True;
  cmbDriver.Enabled := True;
  cmdNewDriver.Enabled := True;
  Label11.Enabled := True;
//  cmdNewOffice.Enabled := True;
  Label12.Enabled := True;
  cmbVisited.Enabled := True;
  cmdNewVisited.Enabled := True;
  Label9.Enabled := True;
  cmbCarName.Enabled := True;
  cmdNewCarName.Enabled := True;
  Label17.Enabled := True;
  cmbCarColor.Enabled := True;
  cmdNewCarColor.Enabled := True;
  lblResult.Caption := '';
end;

procedure TfrmArival.FillBarCodes;
//kaveh var qry : TAdoQuery;
begin
{kaveh  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  cmbBarCode.Items.Clear;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Card_Code FROM BarCodes');
  qry.SQL.Add('WHERE Card_State = ' + IntToStr(MB_NORMAL));
  qry.SQL.Add('AND Card_Code NOT IN (SELECT M_BarCode FROM InputCar');
  qry.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_TRUE) + ' )');

  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('Card_Code').AsString));
    qry.Next;
  end;
  qry.Close; kaveh}
end;

function TfrmArival.AreValidFields : Boolean;
begin
{kaveh  if cmbBarCode.Text = '' then
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
  end kaveh}
{kaveh  else if cmbCarName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام خودرو وارد نشده است.');
    cmbCarName.SetFocus;
  end 
  else if cmbCarColor.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('رنگ خودرو وارد نشده است.');
    cmbCarColor.SetFocus;
  end
  else} if txtCarNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره خودرو وارد نشده است.');
    txtCarNumber.SetFocus;
  end
{kaveh  else if cmbCarCity.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شهر خودرو وارد نشده است.');
    cmbCarCity.SetFocus;
  end }
//kaveh-is
  else if txtSerial.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('سریال مشخص نشده است.');
    txtSerial.SetFocus;
  end
//kaveh-ie
  else if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ مشخص نشده است.');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text)then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ نادرست است.');
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
{kaveh  else if cmbDoorCode.Text = '' then
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
  end
  else if FreeCapacity[FindTypeNo(cmbCarName.Text)] <= 0 then
  begin
    AreValidFields := False;
    ErrorMessage('ظرفيت تكميل است.');
  end}
  else
    AreValidFields := True;
end;


procedure TfrmArival.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtSerial.Handle);
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(cmbCarColor.Handle);
  SetDirectionFarsi(cmbCarCity.Handle);
  SetDirectionFarsi(cmbDoorName.Handle);
  SetDirectionFarsi(cmbPersonName.Handle);

  cmbBarCode.Text := '********'; //kaveh

//kaveh  FillBarCodes;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarName.Items.Add(qry.FieldByName('Car_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Name, NewPersons.P_Family, NewPersons.P_Depart, Department.Depart_Name ');
  qry.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
  qry.SQL.Add('Department ON NewPersons.P_Depart = Department.Depart_Code ');
//  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
//  qry.SQL.Add('WHERE (P_Depart <> ' + IntToStr(g_Options.Department) + ') OR (P_Depart is NULL) ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code ');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDriver.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
    cmbWorkDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDriverCode.Items.Add(qry.FieldByName('P_Code').AsString);
    cmbWorkDepartmentCode.Items.Add(qry.FieldByName('P_Depart').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
  qry.SQL.Add('WHERE P_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbVisited.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
    cmbVisitedCode.Items.Add(qry.FieldByName('P_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Depart_Code,Depart_Name FROM Department');
  qry.SQL.Add('WHERE Depart_Code = ' + IntToStr(g_Options.Department) + ' ');
  qry.Open;
  if not qry.EOF then
  begin
    lblEntranceDepartment.Caption := ' ' + qry.FieldByName('Depart_Name').AsString;
    lblEntranceDepartment.Hint := qry.FieldByName('Depart_Name').AsString;
    lblEntranceDepartmentCode.Caption := qry.FieldByName('Depart_Code').AsString;
  end;
  qry.Close;
  if lblEntranceDepartmentCode.Caption = '' then
    lblEntranceDepartmentCode.Caption := '0';

{  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers'); //WHERE R_Kind IN (' + IntToStr(MB_IN) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDoorCode.Items.Add(qry.FieldByName('R_Code').AsString);
    cmbDoorName.Items.Add(qry.FieldByName('R_Name').AsString);
    qry.Next;
  end;
  qry.Close;  }


{kaveh
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarCity.Items.Add(qry.FieldByName('City_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers WHERE R_Kind IN (' + IntToStr(MB_IN) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDoorCode.Items.Add(qry.FieldByName('R_Code').AsString);
    cmbDoorName.Items.Add(qry.FieldByName('R_Name').AsString);
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
   kaveh}
  qry.Free;
end;

procedure TfrmArival.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F5) and (Shift = []) then
    begin
      cmdExitCarClick(self);
    end;
  if (Key = VK_F8) and (Shift = []) then
    begin
      cmdOpenDoorClick(self);
    end;
end;

procedure TfrmArival.FormShow(Sender: TObject);
begin
  Height := 302;
end;

procedure TfrmArival.FormActivate(Sender: TObject);
begin
  ClearScrFields;
end;

procedure TfrmArival.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Integer(Key);
end;

procedure TfrmArival.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmArival.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    cmbCarColor.SetFocus;
    Key := #0;
  end
 //kaveh else
  //kaveh  SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmArival.cmbCarColorEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmArival.cmbCarColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    txtCarNumber.SetFocus;
    Key := #0;
  end
//kaveh  else
//kaveh    SrchNearst(SrchStr, cmbCarColor, Key);
end;

procedure TfrmArival.cmbCarCityEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmArival.cmbCarCityKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  fnd : Boolean;
begin
  fnd := False;
  if Key = #8 then
    Delete(SrchStr, Length(SrchStr), 1)
  else if Key = #27 then
    SrchStr := ''
  else if Key <> #13 then
    SrchStr := SrchStr + Key
  else
  begin
    txtSerial.SetFocus;
    Key := #0;
    Exit;
  end;

  Key := #0;

  for i := 0 to cmbCarCity.Items.Count do
  begin
    if Pos(SrchStr, Copy(cmbCarCity.Items.Strings[i], 1, Length(SrchStr))) <> 0 then
    begin
      cmbCarCity.ItemIndex := i;
      fnd := True;
      break;
    end;
  end;

  if not fnd then
    cmbCarCity.Text := SrchStr;
end;

procedure TfrmArival.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtDate.Text := CurrentDate;
//    else
//      txtTime.SetFocus;
  end;
end;

procedure TfrmArival.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Date(Key);
end;

procedure TfrmArival.txtSerialExit(Sender: TObject);
var
  TF : Boolean;
  qry, qry2 : TAdoQuery;
  frmArivalCo : TfrmArivalCo;
  
begin
  TF := True;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry2 := TAdoQuery.Create(Application);
  qry2.connection := frmDBS.adoConnect;

  qry2.SQL.Clear;
  qry2.SQL.Add('SELECT Co_CarNumber, Co_Serial ');
  qry2.SQL.Add('FROM CoCars ');
  qry2.SQL.Add('WHERE (Co_CarNumber = ''' + txtCarNumber.Text + ''') AND (Co_Serial = ''' + txtSerial.Text + ''') ');
  qry2.SQL.Add('AND (Co_Depart = ' + IntToStr(g_Options.Department) + ' OR Co_AllDeparts = ' + IntToStr(CNST_TRUE)+ ') ');
{
  qry2.SQL.Add('SELECT M_Number, M_Serial, M_IsPark, M_EntranceDepart ');
  qry2.SQL.Add('FROM InputCar ');
  qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') ');
  qry2.SQL.Add('ORDER BY M_IDate, M_ITime ');
  }
  qry2.Open;
  if not qry2.Eof then
  begin
    Application.CreateForm(TfrmArivalCo, frmArivalCo);
    frmArivalCo.lblNumber.Text := txtCarNumber.Text; 
    frmArivalCo.lblSerial.Caption := txtSerial.Text;
    frmArivalCo.ShowModal;
    frmArivalCo.Free;
    ClearScrFields;
    txtCarNumber.SetFocus;
//    FMsgBox(('تست'), MBOKOnly, MBCritical, ('ورود تکراری!'));
  end
  else
  begin
    qry2.SQL.Clear;
    qry2.SQL.Add('SELECT M_Number, M_Serial, max(M_IDate + M_ITime) as maxM_IDateTime, M_IsPark, M_EntranceDepart ');
    qry2.SQL.Add('FROM InputCar ');
    qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') ');
    qry2.SQL.Add('GROUP BY M_Number, M_Serial, M_IsPark, M_EntranceDepart ');
    qry2.SQL.Add('ORDER BY maxM_IDateTime ');
  {
    qry2.SQL.Add('SELECT M_Number, M_Serial, M_IsPark, M_EntranceDepart ');
    qry2.SQL.Add('FROM InputCar ');
    qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') ');
    qry2.SQL.Add('ORDER BY M_IDate, M_ITime ');
    }
    qry2.Open;
    if not qry2.Eof then
    begin
      qry2.Last;
      if qry2.FieldByName('M_IsPark').AsBoolean then
        if qry2.FieldByName('M_EntranceDepart').AsInteger = g_Options.Department then
        begin
          FMsgBox(('خودروی مورد نظر قبلا در این پارکینگ توقف کرده است!'), MBOKOnly, MBCritical, ('ورود تکراری!'));
  //        ErrorMessage('!ورود تکراری' + #13 + 'خودروی مورد نظر قبلا در این پارکینگ توقف کرده است!');
        end
        else
        begin
          FMsgBox(('خودروی مورد نظر در پارکینگ دیگری توقف کرده است!'), MBOKOnly, MBCritical, ('ورود تکراری!'));
  //        ErrorMessage('!ورود تکراری' + #13 + 'خودروی مورد نظر در پارکینگ دیگری توقف کرده است!');
        end;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Name, NewPersons.P_Family, NewPersons.P_CarSerial, NewPersons.P_CarNumber, ');
    qry.SQL.Add('NewPersons.P_CarColor, NewPersons.P_CarName, NewPersons.P_Depart, NewPersons.P_IsCustomer, cars.Car_Name, ');
    qry.SQL.Add('Colors.Clr_Name ');
    qry.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
    qry.SQL.Add('cars ON NewPersons.P_CarName = cars.Car_Code LEFT OUTER JOIN ');
    qry.SQL.Add('Colors ON NewPersons.P_CarColor = Colors.Clr_Code ');
  //  qry.SQL.Add('SELECT P_Code, P_Name, P_Family, P_CarSerial, P_CarNumber, P_CarColor, P_CarName, P_Depart, P_IsCustomer FROM NewPersons');
    qry.SQL.Add('WHERE (P_CarNumber = ''' + txtCarNumber.Text + ''') AND (P_CarSerial = ''' + txtSerial.Text + ''') ');//AND (P_Depart = ' + IntToStr(g_Options.Department)+ ') ');
  ////  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code');
    qry.Open;
    if not qry.EOF then
    begin
      if  qry.FieldByName('P_Depart').AsInteger = g_Options.Department then
      begin
        if qry.FieldByName('P_IsCustomer').AsBoolean then
          lblResult.Caption := 'مشترک : '
        else
          lblResult.Caption := 'پرسنل بدون اشتراک : ';
        lblResult.Caption := lblResult.Caption + qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
        lblResult.Caption := lblResult.Caption + ' - ' + qry.FieldByName('Car_Name').AsString + ' (' + qry.FieldByName('Clr_Name').AsString + ')';

        cmbCarName.ItemIndex := cmbCarName.Items.IndexOf(qry.FieldByName('Car_Name').AsString);
        cmbCarColor.ItemIndex := cmbCarColor.Items.IndexOf(qry.FieldByName('Clr_Name').AsString);
        cmbDriverCode.ItemIndex := cmbDriverCode.Items.IndexOf(qry.FieldByName('P_Code').AsString);
        cmbDriver.ItemIndex := cmbDriverCode.ItemIndex;
        cmbDriver.Hint := cmbDriver.Text;
        cmbWorkDepartment.ItemIndex := cmbDriverCode.ItemIndex;
        cmbWorkDepartmentCode.ItemIndex := cmbDriverCode.ItemIndex;
        lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
        lblWorkDepartment.Hint := cmbWorkDepartment.Text;

        Label7.Enabled := False;
        cmbDriver.Enabled := False;
        cmdNewDriver.Enabled := False;
        Label11.Enabled := False;
  //      cmdNewOffice.Enabled := False;
        Label12.Enabled := False;
        cmbVisited.Enabled := False;
        cmdNewVisited.Enabled := False;
        Label9.Enabled := False;
        cmbCarName.Enabled := False;
        cmdNewCarName.Enabled := False;
        Label17.Enabled := False;
        cmbCarColor.Enabled := False;
        cmdNewCarColor.Enabled := False;


  //      SelectNext(Sender as tWinControl, True, True );
  //      FindNextControl(txtSerial,True,True,True);
  //      txtDate.SetFocus;
      end
      else
      begin
        lblResult.Caption := 'پرسنل مهمان : ';
        lblResult.Caption := lblResult.Caption + qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
        lblResult.Caption := lblResult.Caption + ' - ' + qry.FieldByName('Car_Name').AsString + ' (' + qry.FieldByName('Clr_Name').AsString + ')';
        Label9.Enabled := False;
        cmbCarName.Enabled := False;
        cmdNewCarName.Enabled := False;
        Label17.Enabled := False;
        cmbCarColor.Enabled := False;
        cmdNewCarColor.Enabled := False;
        qry2.SQL.Clear;
        qry2.SQL.Add('SELECT M_CarName, M_Number, M_Serial, M_Color, M_Driver, M_Visited, M_EntranceDepart '); //M_WorkDepart,
        qry2.SQL.Add('FROM InputCar ');
        qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') AND (M_EntranceDepart = ' + lblEntranceDepartmentCode.Caption + ' ) ');
        qry2.SQL.Add('ORDER BY M_IDate, M_ITime ' );
        qry2.Open;
        if not qry2.EOF then
        begin
          qry2.Last;
          cmbDriverCode.ItemIndex := cmbDriverCode.Items.IndexOf(qry2.FieldByName('M_Driver').AsString);
          cmbDriver.ItemIndex := cmbDriverCode.ItemIndex;
          cmbDriver.Hint := cmbDriver.Text;
          cmbWorkDepartment.ItemIndex := cmbDriverCode.ItemIndex;
          cmbWorkDepartmentCode.ItemIndex := cmbDriverCode.ItemIndex;
          lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
          lblWorkDepartment.Hint := cmbWorkDepartment.Text;
          cmbVisitedCode.ItemIndex := cmbVisitedCode.Items.IndexOf(qry2.FieldByName('M_Visited').AsString);
          cmbVisited.ItemIndex := cmbVisitedCode.ItemIndex;
          cmbVisited.Hint := cmbVisited.Text;
        end;

        cmbCarName.ItemIndex := cmbCarName.Items.IndexOf(qry.FieldByName('Car_Name').AsString);
        cmbCarColor.ItemIndex := cmbCarColor.Items.IndexOf(qry.FieldByName('Clr_Name').AsString);
        if cmbDriver.ItemIndex = -1 then
        begin
          cmbDriverCode.ItemIndex := cmbDriverCode.Items.IndexOf(qry.FieldByName('P_Code').AsString);
          cmbDriver.ItemIndex := cmbDriverCode.ItemIndex;
          cmbDriver.Hint := cmbDriver.Text;
          cmbWorkDepartment.ItemIndex := cmbDriverCode.ItemIndex;
          cmbWorkDepartmentCode.ItemIndex := cmbDriverCode.ItemIndex;
          lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
          lblWorkDepartment.Hint := cmbWorkDepartment.Text;
        end;

      end;
    end
    else
    begin
        qry2.SQL.Clear;
        qry2.SQL.Add('SELECT Co_CarNumber, Co_Serial ');
        qry2.SQL.Add('FROM CoCars ');
        qry2.SQL.Add('WHERE (Co_CarNumber = ''' + txtCarNumber.Text + ''') AND (Co_Serial = ''' + txtSerial.Text + ''') ');
        qry2.Open;
        if not qry2.Eof then
          lblResult.Caption := 'مهمان (خودروی سازمانی)'
        else
          lblResult.Caption := 'مهمان';
        qry2.SQL.Clear;
        qry2.SQL.Add('SELECT M_CarName, M_Number, M_Serial, M_Color, M_Driver, M_Visited, M_EntranceDepart '); //M_WorkDepart,
        qry2.SQL.Add('FROM InputCar ');
        qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') AND (M_EntranceDepart = ' + lblEntranceDepartmentCode.Caption + ' ) ');
        qry2.SQL.Add('ORDER BY M_IDate, M_ITime ' );
        qry2.Open;
        if not qry2.EOF then
        begin
          qry2.Last;
          cmbDriverCode.ItemIndex := cmbDriverCode.Items.IndexOf(qry2.FieldByName('M_Driver').AsString);
          cmbDriver.ItemIndex := cmbDriverCode.ItemIndex;
          cmbDriver.Hint := cmbDriver.Text;
          cmbWorkDepartment.ItemIndex := cmbDriverCode.ItemIndex;
          cmbWorkDepartmentCode.ItemIndex := cmbDriverCode.ItemIndex;
          lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
          lblWorkDepartment.Hint := cmbWorkDepartment.Text;
          cmbVisitedCode.ItemIndex := cmbVisitedCode.Items.IndexOf(qry2.FieldByName('M_Visited').AsString);
          cmbVisited.ItemIndex := cmbVisitedCode.ItemIndex;
          cmbVisited.Hint := cmbVisited.Text;
          cmbCarName.ItemIndex := cmbCarName.Items.IndexOf(qry2.FieldByName('M_CarName').AsString);
          cmbCarColor.ItemIndex := cmbCarColor.Items.IndexOf(qry2.FieldByName('M_Color').AsString);
        end;
    end;
  end;

  qry.Close;
  qry.Free;
  qry2.Close;
  qry2.Free;
 {
  if TF then
    lblResult.Caption := 'مشترک'
  else if TF then
    lblResult.Caption := 'خودروی سازمانی'
  else
    lblResult.Caption := 'مهمان';  }
    
end;

procedure TfrmArival.txtSerialKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  if (Key = VK_RETURN)then
  begin
    Key := 0;
    if not cmbDriver.Enabled then
      txtDate.SetFocus;
  end;}
end;

procedure TfrmArival.txtSerialKeyPress(Sender: TObject; var Key: Char);
var
  Shift : TShiftState;
begin
  Keyboard_Integer(Key);
end;

procedure TfrmArival.txtCarNumberChange(Sender: TObject);
begin
  cmbCarName.ItemIndex := -1;
  cmbCarColor.ItemIndex := -1;
  cmbDriver.ItemIndex := -1;
  cmbDriver.Hint := ' ';
  cmbDriverCode.ItemIndex := -1;
  cmbWorkDepartment.ItemIndex := -1;
  cmbWorkDepartmentCode.ItemIndex := -1;
  lblWorkDepartment.Caption := '';
  lblWorkDepartment.Hint := ' ';
  cmbVisited.ItemIndex := -1;
  cmbVisited.Hint := ' ';
  cmbVisitedCode.ItemIndex := -1;
  Label7.Enabled := True;
  cmbDriver.Enabled := True;
  cmdNewDriver.Enabled := True;
  Label11.Enabled := True;
//  cmdNewOffice.Enabled := True;
  Label12.Enabled := True;
  cmbVisited.Enabled := True;
  cmdNewVisited.Enabled := True;
  Label9.Enabled := True;
  cmbCarName.Enabled := True;
  cmdNewCarName.Enabled := True;
  Label17.Enabled := True;
  cmbCarColor.Enabled := True;
  cmdNewCarColor.Enabled := True;
  lblResult.Caption := '';
end;

procedure TfrmArival.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);
    Key := #0;
end;

procedure TfrmArival.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
  if txtDate.Text = '//' then
    txtDate.Text := '';
end;

procedure TfrmArival.txtTimeExit(Sender: TObject);
begin
  txtTime.Text := BeautifulTime(txtTime.Text);
end;

procedure TfrmArival.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtTime.Text := CurrentTime;
//    else
//      cmbDoorCode.SetFocus;
  end;
end;

procedure TfrmArival.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Time(Key);
end;

procedure TfrmArival.cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbPersonCode.SetFocus;
  end;
end;

procedure TfrmArival.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmArival.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;


procedure TfrmArival.cmbDriverChange(Sender: TObject);
begin
  cmbDriver.Hint := cmbDriver.Text;
  cmbDriverCode.ItemIndex := cmbDriver.ItemIndex;
  cmbWorkDepartment.ItemIndex := cmbDriver.ItemIndex;
  cmbWorkDepartmentCode.ItemIndex := cmbWorkDepartment.ItemIndex;
  lblWorkDepartment.Caption := ' ' + cmbWorkDepartment.Text;
  lblWorkDepartment.Hint := cmbWorkDepartment.Text;
end;

procedure TfrmArival.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmArival.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmArival.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmArival.cmbVisitedChange(Sender: TObject);
begin
  cmbVisited.Hint := cmbVisited.Text;
  cmbVisitedCode.ItemIndex := cmbVisited.ItemIndex;
end;

procedure TfrmArival.cmdNewCarColorClick(Sender: TObject);
var
  frmColors : TfrmColors;
  qry : TAdoQuery;
begin
  Application.CreateForm(TfrmColors, frmColors);
  frmColors.ShowModal;
  frmColors.Free;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Name');
  qry.Open;
  cmbCarColor.Clear;
  while not qry.EOF do
  begin
    cmbCarColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

procedure TfrmArival.cmdNewCarNameClick(Sender: TObject);
var
  frmCars : TfrmCars;
  qry : TAdoQuery;
begin
  Application.CreateForm(TfrmCars, frmCars);
  frmCars.ShowModal;
  frmCars.Free;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Name');
  qry.Open;
  cmbCarName.Clear;
  while not qry.EOF do
  begin
    cmbCarName.Items.Add(qry.FieldByName('Car_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

procedure TfrmArival.cmdNewDriverClick(Sender: TObject);
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
  qry.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Name, NewPersons.P_Family, NewPersons.P_Depart, Department.Depart_Name ');
  qry.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
  qry.SQL.Add('Department ON NewPersons.P_Depart = Department.Depart_Code ');
//  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
  qry.SQL.Add('WHERE (P_Depart <> ' + IntToStr(g_Options.Department) + ') OR (P_Depart is NULL) ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code ');
  qry.Open;
  cmbDriver.Clear;
  cmbWorkDepartment.Clear;
  cmbDriverCode.Clear;
  cmbWorkDepartmentCode.Clear;
  while not qry.EOF do
  begin
    cmbDriver.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
    cmbWorkDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDriverCode.Items.Add(qry.FieldByName('P_Code').AsString);
    cmbWorkDepartmentCode.Items.Add(qry.FieldByName('P_Depart').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
  qry.SQL.Add('WHERE P_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY P_Family,P_Name,P_Code');
  qry.Open;
  cmbVisited.Clear;
  cmbVisitedCode.Clear;
  while not qry.EOF do
  begin
    cmbVisited.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
    cmbVisitedCode.Items.Add(qry.FieldByName('P_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;  
end;

procedure TfrmArival.cmdSaveClick(Sender: TObject);
var machin : TMachines;
begin

  if AreValidFields then
  begin
    machin.M_BarCode := cmbBarCode.Text;
    if machin.M_BarCode = '' then
      machin.M_BarCode := '********'; //kaveh
    machin.M_CarName := cmbCarName.Text;
    machin.M_Color := cmbCarColor.Text;
    machin.M_Number := txtCarNumber.Text;
    machin.M_CityName := ''; //kaveh cmbCarCity.Text;
    machin.M_Serial := txtSerial.Text;
    machin.M_IDate := txtDate.Text;
    machin.M_ITime := txtTime.Text;
    machin.M_IDoor := 0; //kaveh StrToInt(cmbDoorCode.Text);
    machin.M_IPerson := ''; //kaveh cmbPersonCode.Text;
    machin.M_IUserName := g_options.UserName;
    machin.M_Driver := cmbDriverCode.Text; //kaveh
    if cmbWorkDepartmentCode.Text <> '' then
      machin.M_WorkDepart := StrToInt(cmbWorkDepartmentCode.Text); //kaveh
    machin.M_Visited := cmbVisitedCode.Text; //kaveh
    if lblEntranceDepartmentCode.Caption <> '' then
      machin.M_EntranceDepart := StrToInt(lblEntranceDepartmentCode.Caption); //kaveh

    InputCar(machin);

    ClearScrFields;
//kaveh    FillBarCodes;
//kaveh    cmbBarCode.SetFocus;
    txtCarNumber.SetFocus; //kaveh
  end;
end;


end.
