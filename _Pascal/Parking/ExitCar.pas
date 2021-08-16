unit ExitCar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, ExtCtrls,
  Globals, FarsiApi, MSGs, Keyboard, DBS, DateProc, Cntroler, DosMove,
  ExitCo;

type
  TfrmExitCar = class(TForm)
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
    lblName: TStaticText;
    lblColor: TStaticText;
    lblIDate: TStaticText;
    lblCity: TStaticText;
    lblSerial: TStaticText;
    Label19: TLabel;
    Label20: TLabel;
    lblITime: TStaticText;
    lblNumber: TEdit;
    Label21: TLabel;
    lblDiff: TStaticText;
    grpPrice: TGroupBox;
    Label11: TLabel;
    Label15: TLabel;
    lblPayable: TStaticText;
    grpBtn: TGroupBox;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmbDoorName: TComboBox;
    cmbPersonName: TComboBox;
    cmbPersonCode: TComboBox;
    Label6: TLabel;
    cmbDoorCode: TComboBox;
    Label5: TLabel;
    txtTakhfif: TEdit;
    Label16: TLabel;
    lblRemain: TStaticText;
    Label18: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    txtPrice: TEdit;
    Label7: TLabel;
    DosMove1: TDosMove;
    Label22: TLabel;
    txtCarNumber: TEdit;
    Label23: TLabel;
    txtSerial: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    lblWorkDepartment: TStaticText;
    lblEntranceDepartment: TStaticText;
    Label26: TLabel;
    Label27: TLabel;
    lblDriver: TStaticText;
    lblVisited: TStaticText;
    cmdEnterCar: TBitBtn;
    cmdOpenDoor: TBitBtn;
    Label28: TLabel;
    lblEntranceUser: TStaticText;
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
    procedure txtDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTimeExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDoorCodeExit(Sender: TObject);
    procedure cmbPersonCodeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtTakhfifChange(Sender: TObject);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarNumberExit(Sender: TObject);
    procedure txtSerialExit(Sender: TObject);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOpenDoorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmdEnterCarClick(Sender: TObject);
  private
    { Private declarations }

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

uses main, Arival;


procedure TfrmExitCar.SetWinF;
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
  Label7.Caption := (Label7.Caption);
  Label13.Caption := (Label13.Caption);
  Label11.Caption := (Label11.Caption);
  Label12.Caption := (Label12.Caption);
  Label14.Caption := (Label14.Caption);
  Label15.Caption := (Label15.Caption);
  Label16.Caption := (Label16.Caption);
  Label18.Caption := (Label18.Caption);
  Label19.Caption := (Label19.Caption);
  Label20.Caption := (Label20.Caption);
  Label21.Caption := (Label21.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmExitCar.FillBarCodes;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
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

procedure TfrmExitCar.ClearScrFields;
begin
  txtCarNumber.Text := '';
  txtSerial.Text := '';
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
  lblEntranceUser.Caption := '';
  {cmbDoorCode.ItemIndex := -1;
  cmbDoorName.ItemIndex := -1;
  cmbPersonCode.ItemIndex := -1;
  cmbPersonName.ItemIndex := -1;}
  cmdSave.Enabled := True;
end;

procedure TfrmExitCar.FillScrFields;
var
  qry : TAdoQuery;
begin
  lblName.Caption := ' ' + machin.M_CarName;
  lblColor.Caption := ' ' + machin.M_Color;
  lblNumber.Text := ' ' + machin.M_Number;
  lblCity.Caption := ' ' + machin.M_CityName;
  lblSerial.Caption := ' ' + machin.M_Serial;
  lblIDate.Caption := ' ' + machin.M_IDate;
  lblITime.Caption := ' ' + machin.M_ITime;
  lblDiff.Caption := ' ' + FormatTimes(Differ(machin.M_IDate, machin.M_ITime, machin.M_ODate, machin.M_OTime));
  txtPrice.Text := FloatToStr(machin.M_Price);
  txtTakhfif.Text := FloatToStr(machin.Takhfif);
  lblPayable.Caption := ' ' + FloatToStr(machin.M_PayAble);
  lblRemain.Caption := ' ' + FloatToStr(machin.Remainder);
  lblEntranceUser.Caption := ' ' + machin.M_IUserName;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Name, NewPersons.P_Family, Department.Depart_Name ');
  qry.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
  qry.SQL.Add('Department ON NewPersons.P_Depart = Department.Depart_Code ');
  qry.SQL.Add('WHERE (NewPersons.P_Code = ''' + machin.M_Driver + ''') ');
  qry.Open;
  if not qry.Eof then
  begin
    lblDriver.Caption := ' ' + qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
    lblDriver.Hint := qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
    lblWorkDepartment.Caption := ' ' + qry.FieldByName('Depart_Name').AsString;
    lblWorkDepartment.Hint := qry.FieldByName('Depart_Name').AsString;
  end;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Name, NewPersons.P_Family, Department.Depart_Name ');
  qry.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
  qry.SQL.Add('Department ON NewPersons.P_Depart = Department.Depart_Code ');
  qry.SQL.Add('WHERE (NewPersons.P_Code = ''' + machin.M_Visited + ''') ');
  qry.Open;
  if not qry.Eof then
  begin
    lblVisited.Caption := ' ' + qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
    lblVisited.Hint := qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')';
  end;
end;

function TfrmExitCar.AreValidFields : Boolean;
begin
  {if cmbBarCode.Text = '' then
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
  end }
  if txtCarNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پلاک وارد نشده است.');
    txtCarNumber.SetFocus;
  end
  else if lblNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('چنين شماره پلاکی وجود ندارد.');
    txtCarNumber.SetFocus;
  end
  else if txtSerial.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره سریال وارد نشده است.');
    txtSerial.SetFocus;
  end
  else if lblSerial.Caption = '' then
  begin
    AreValidFields := False;
    ErrorMessage('چنين شماره سریالی وجود ندارد.');
    txtSerial.SetFocus;
  end
  else if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ مشخص نشده است.');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ نادرست است.');
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
{kaveh871106  else if cmbDoorCode.Text = '' then
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
  end }
  else
    AreValidFields := True;
end;

function TfrmExitCar.h_m_Str(m : Integer) : String;
var
  s : String;
begin
  if (m div 60) > 0 then
    s := IntToStr(m div 60) + 'h ,  ' + IntToStr(m mod 60) + ''''
  else
    s := IntToStr(m) + '''';
  h_m_Str := s;
end;

procedure TfrmExitCar.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(lblNumber.Handle);
  SetDirectionFarsi(cmbDoorName.Handle);
  SetDirectionFarsi(cmbPersonName.Handle);

  FillBarCodes;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Depart_Code,Depart_Name FROM Department');
  qry.SQL.Add('WHERE Depart_Code = ' + IntToStr(g_Options.Department) + ' ');
  qry.Open;
  if not qry.EOF then
  begin
    lblEntranceDepartment.Caption := ' ' + qry.FieldByName('Depart_Name').AsString;
    lblEntranceDepartment.Hint := qry.FieldByName('Depart_Name').AsString;
  end;
  qry.Close;

{kaveh

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers WHERE R_Kind IN (' + IntToStr(MB_OUT) + ', ' + IntToStr(MB_INOUT) + ')');
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

  qry.Free;}
end;

procedure TfrmExitCar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (Shift = []) then
    begin
      cmdEnterCarClick(self);
    end;
  if (Key = VK_F8) and (Shift = []) then
    begin
      cmdOpenDoorClick(self);
    end;
end;

procedure TfrmExitCar.FormShow(Sender: TObject);
begin
 Height := 407;
end;

procedure TfrmExitCar.FormActivate(Sender: TObject);
begin
  ClearScrFields;
end;

procedure TfrmExitCar.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Integer(Key);
end;

procedure TfrmExitCar.cmbBarCodeExit(Sender: TObject);
var ret : Integer;
begin
  if cmbBarCode.Text <> '' then
  begin
    if cmbBarCode.Items.IndexOf(cmbBarCode.Text) <> -1 then
    begin
      machin.M_BarCode := cmbBarCode.Text;
      machin.M_ODate := txtDate.Text;
      machin.M_OTime := txtTime.Text;
      ret := OutputCar(machin);
      FillScrFields;
      if ret = 0 then
        cmdSave.Enabled := True
      else
      begin
        cmdSave.Enabled := False;
        if (ret and MB_NOTEXIT) <> 0 then
          InformationMessage('اين خودرو ممنوع‌الخروج مي‌باشد. خروج آن ميسر نيست.')
        else if (ret and MB_MOTAVARI) <> 0 then
          InformationMessage('اين خودرو متواري مي‌باشد. خروج آن ميسر نيست.')
        else if (ret AND MB_GHOLNAMEH) <> 0 then
          InformationMessage('خودرو قولنامه شده و اجازه خروج ندارد.');
      end;
    end
    else
    begin
      ErrorMessage('هيچ خودرويي با چنين باركدي در پاركينگ پارك نيست.');
      cmbBarCode.SetFocus;
    end;
  end;
end;

procedure TfrmExitCar.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
    txtDate.Text := CurrentDate
end;

procedure TfrmExitCar.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Date(Key);
end;

procedure TfrmExitCar.txtCarNumberExit(Sender: TObject);
//var ret : Integer;
begin
{  if txtCarNumber.Text <> '' then
  begin
//    if cmbBarCode.Items.IndexOf(cmbBarCode.Text) <> -1 then
//    begin
      machin.M_BarCode := cmbBarCode.Text;
      machin.M_ODate := txtDate.Text;
      machin.M_OTime := txtTime.Text;

      machin.M_Number := txtCarNumber.Text; //kaveh

      ret := OutputCar(machin);
      if ret <> MB_NOTEXIST then
      begin
        FillScrFields;
        if ret = 0 then
          cmdSave.Enabled := True
        else
        begin
          cmdSave.Enabled := False;
          if (ret and MB_NOTEXIT) <> 0 then
            InformationMessage('اين خودرو ممنوع‌الخروج مي‌باشد. خروج آن ميسر نيست.')
          else if (ret and MB_MOTAVARI) <> 0 then
            InformationMessage('اين خودرو متواري مي‌باشد. خروج آن ميسر نيست.')
          else if (ret AND MB_GHOLNAMEH) <> 0 then
            InformationMessage('خودرو قولنامه شده و اجازه خروج ندارد.');
        end;
      end
      else
      begin
        ErrorMessage('هيچ خودرويي با چنين شماره پلاکی در پاركينگ پارك نيست.');
        ClearScrFields;
        txtCarNumber.SetFocus;
      end;
//    end
//    else
//    begin
//      ErrorMessage('هيچ خودرويي با چنين باركدي در پاركينگ پارك نيست.');
//      cmbBarCode.SetFocus;
//    end;
  end;  }
end;

procedure TfrmExitCar.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);
  Key := #0;
end;

procedure TfrmExitCar.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
  if txtDate.Text = '//' then
    txtDate.Text := '';
  machin.M_ODate := txtDate.Text;
  machin.M_OTime := txtTime.Text;
  CalculPriceField(machin);
  FillScrFields;
end;

procedure TfrmExitCar.txtTimeExit(Sender: TObject);
begin
  txtTime.Text := BeautifulTime(txtTime.Text);
  machin.M_ODate := txtDate.Text;
  machin.M_OTime := txtTime.Text;
  CalculPriceField(machin);
  FillScrFields;
end;

procedure TfrmExitCar.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
    txtTime.Text := CurrentTime;
end;

procedure TfrmExitCar.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
//  if Key = #13 then
//  begin
//    Key := #0;
//    if grpPrice.Visible then
//      txtPrice.SetFocus
//    else
//      cmbDoorCode.SetFocus;
//  end
//  else
    Keyboard_Time(Key);
end;

procedure TfrmExitCar.txtPriceKeyPress(Sender: TObject; var Key: Char);
begin
{  if Key = #13 then
  begin
    Key := #0;
    txtTakhfif.SetFocus;
  end
  else   }
    Keyboard_Integer(Key);
end;

procedure TfrmExitCar.txtSerialExit(Sender: TObject);
var
  ret : Integer;
  qry : TAdoQuery;
  frmExitCo : TfrmExitCo;
begin
  if (txtCarNumber.Text <> '') or (txtSerial.Text <> '') then
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Co_CarNumber, Co_Serial ');
    qry.SQL.Add('FROM CoCars ');
    qry.SQL.Add('WHERE (Co_CarNumber = ''' + txtCarNumber.Text + ''') AND (Co_Serial = ''' + txtSerial.Text + ''') ');
    qry.SQL.Add('AND (Co_Depart = ' + IntToStr(g_Options.Department) + ' OR Co_AllDeparts = ' + IntToStr(CNST_TRUE)+ ') ');
//    qry.SQL.Add('AND (Co_Serial = ''' + txtSerial.Text + ''') ');
  {
    qry2.SQL.Add('SELECT M_Number, M_Serial, M_IsPark, M_EntranceDepart ');
    qry2.SQL.Add('FROM InputCar ');
    qry2.SQL.Add('WHERE (M_Number = ''' + txtCarNumber.Text + ''') AND (M_Serial = ''' + txtSerial.Text + ''') ');
    qry2.SQL.Add('ORDER BY M_IDate, M_ITime ');
    }
    qry.Open;
    if not qry.Eof then
    begin
      Application.CreateForm(TfrmExitCo, frmExitCo);
      frmExitCo.lblNumber.Text := txtCarNumber.Text;
      frmExitCo.lblSerial.Caption := txtSerial.Text;
      frmExitCo.ShowModal;
      frmExitCo.Free;

      ClearScrFields;
      txtCarNumber.SetFocus;
//    FMsgBox(('تست'), MBOKOnly, MBCritical, ('ورود تکراری!'));
    end
    else
    begin  
//  if cmbBarCode.Items.IndexOf(cmbBarCode.Text) <> -1 then
//  begin
      machin.M_BarCode := cmbBarCode.Text;
      machin.M_ODate := txtDate.Text;
      machin.M_OTime := txtTime.Text;

      machin.M_Number := txtCarNumber.Text; //kaveh
      machin.M_Serial := txtSerial.Text; //kaveh
      
      ret := OutputCar(machin);
      if ret <> MB_NOTEXIST then
      begin
        FillScrFields;
        if ret = 0 then
          cmdSave.Enabled := True
        else
        begin
          cmdSave.Enabled := False;
          if (ret and MB_NOTEXIT) <> 0 then
            InformationMessage('اين خودرو ممنوع‌الخروج مي‌باشد. خروج آن ميسر نيست.')
          else if (ret and MB_MOTAVARI) <> 0 then
            InformationMessage('اين خودرو متواري مي‌باشد. خروج آن ميسر نيست.')
          else if (ret AND MB_GHOLNAMEH) <> 0 then
            InformationMessage('خودرو قولنامه شده و اجازه خروج ندارد.');
        end;
      end
      else
      begin
        ErrorMessage('هيچ خودرويي با چنين شماره پلاکی در پاركينگ پارك نيست.');
        ClearScrFields;
        txtCarNumber.SetFocus;
      end;
//    end
//   else
//   begin
//      ErrorMessage('هيچ خودرويي با چنين باركدي در پاركينگ پارك نيست.');
//      cmbBarCode.SetFocus;
//    end;
    end;
  end;
end;

procedure TfrmExitCar.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
    Keyboard_Integer(Key);
end;

procedure TfrmExitCar.txtTakhfifChange(Sender: TObject);
begin
  if txtPrice.Text <> '' then
  begin
    if txtTakhfif.Text = '' then
    begin
      txtTakhfif.Text := '0';
      txtTakhfif.SelectAll;
    end;
    if StrToFloat(txtTakhfif.Text) > StrToFloat(txtPrice.Text) then
    begin
      txtTakhfif.Text := txtPrice.Text;
    end;
    lblPayable.Caption := FloatToStr( StrToFloat(txtPrice.Text) - StrToFloat(txtTakhfif.Text));
  end;
end;

procedure TfrmExitCar.txtTakhfifKeyPress(Sender: TObject; var Key: Char);
begin
{  if Key = #13 then
  begin
    Key := #0;
    cmbDoorCode.SetFocus;
  end
  else  }
    Keyboard_Integer(Key);
end;

procedure TfrmExitCar.cmbDoorCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbPersonCode.SetFocus;
  end;
end;

procedure TfrmExitCar.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmExitCar.cmbDoorCodeExit(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorCode.Items.IndexOf(cmbDoorCode.Text);
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmExitCar.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;


procedure TfrmExitCar.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if cmdSave.Enabled then
      cmdSave.SetFocus
    else
      cmdCancel.SetFocus;
  end;
end;

procedure TfrmExitCar.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmExitCar.cmbPersonCodeExit(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonCode.Items.IndexOf(cmbPersonCode.Text);
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmExitCar.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmExitCar.cmdEnterCarClick(Sender: TObject);
var
  frmArival : TfrmArival;
  s : String;
begin
  Application.CreateForm(TfrmArival, frmArival);
  s := '&ورود وسيله نقليه... (دستي)';//mnu1EnterCar.Caption;
  Delete(s, Pos('&', s), 1);
  Delete(s, Pos('...', s), 3);
  frmArival.Caption := s;
  frmArival.ShowModal;
  frmArival.Free;
end;

procedure TfrmExitCar.cmdOpenDoorClick(Sender: TObject);
begin
  frmMain.mnu1OpenDoorClick(self);
end;

procedure TfrmExitCar.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    machin.M_Number := txtCarNumber.Text;
    machin.M_Serial := txtSerial.Text;
    machin.M_ODate := txtDate.Text;
    machin.M_OTime := txtTime.Text;
    machin.M_ODoor := 0; //kaveh StrToInt(cmbDoorCode.Text);
    machin.M_OPerson := ''; //kaveh  cmbPersonCode.Text;
//kaveh    machin.M_ODoor := StrToInt(cmbDoorCode.Text);
//kaveh    machin.M_OPerson := cmbPersonCode.Text;
    machin.M_Slake := StrToFloat(txtTakhfif.Text); //kaveh
    machin.M_Price := StrToFloat(txtPrice.Text);
    machin.M_Payable := StrToFloat(lblPayable.Caption);
    machin.M_UserName := g_options.UserName;
//    machin.M_Driver := 
    UpdateOutputCar(machin);
    ClearScrFields;
    FillBarCodes;
    txtCarNumber.SetFocus;
  end;
end;

end.
