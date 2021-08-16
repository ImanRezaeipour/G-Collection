unit InOutCRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpInOutC, DBS, RunCmnds, DosMove, ExtCtrls;

type
  TfrmInOutCoRpt = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    txtNumber: TEdit;
    txtSerial: TEdit;
    cmbCarName: TComboBox;
    cmbCity: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    txtFromTime: TEdit;
    txtToTime: TEdit;
    cmdClose: TBitBtn;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmbIDoor: TComboBox;
    cmbODoor: TComboBox;
    cmbIPerson: TComboBox;
    cmbOPerson: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    grpType: TGroupBox;
    rdoBoth: TRadioButton;
    rdoArival: TRadioButton;
    rdoExit: TRadioButton;
    Label1: TLabel;
    cmbBarCode: TComboBox;
    DosMove1: TDosMove;
    txtBarCode: TEdit;
    rdoSort: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtToTimeExit(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    SrchStr : String;
    
    function AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmInOutCoRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  Label11.Caption := (Label11.Caption);
  Label13.Caption := (Label13.Caption);
  Label14.Caption := (Label14.Caption);
  grpType.Caption := (grpType.Caption);
  rdoBoth.Caption := (rdoBoth.Caption);
  rdoArival.Caption := (rdoArival.Caption);
  rdoExit.Caption := (rdoExit.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmInOutCoRpt.AreValidControls : Boolean;
begin
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage('تاريخ شروع اشتباه است');
    AreValidControls := False;
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtTodate.Text) then
  begin
    ErrorMessage('تاريخ پايان اشتباه است');
    AreValidControls := False;
    txtToDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage('تاريخ شروع از پايان بزرگتر است');
    AreValidControls := False;
    txtToDate.SetFocus;
  end
  else if (txtFromTime.Text <> '') and not IsTrueTime(txtFromTime.Text) then
  begin
    ErrorMessage('زمان شروع اشتباه است');
    AreValidControls := False;
    txtFromTime.SetFocus;
  end
  else if (txtToTime.Text <> '') and not IsTrueTime(txtToTime.Text) then
  begin
    ErrorMessage('زمان پايان اشتباه است');
    AreValidControls := False;
    txtToTime.SetFocus;
  end
  else if (txtFromTime.Text <> '') and (txtToTime.Text <> '') and
          (txtFromTime.Text > txtToTime.Text) then
  begin
    ErrorMessage('زمان شروع از پايان بزرگتر است');
    AreValidControls := False;
    txtFromTime.SetFocus;
  end
  else
    AreValidControls := True;
end;


procedure TfrmInOutCoRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
     connection := frmDBS.adoConnect;

{     SQL.Clear;
     SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
     Open;
     cmbCity.Items.Clear;
     while not EOF do
     begin
       cmbCity.Items.Add(FieldByName('City_Name').AsString);
       Next;
     end; }

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cars ORDER BY Car_Name');
     Open;
     cmbCarName.Items.Clear;
     while not EOF do
     begin
       cmbCarName.Items.Add(FieldByName('Car_Name').AsString);
       Next;
     end;

{     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Readers');
     Open;
     cmbIDoor.Items.Clear;
     cmbODoor.Items.Clear;
     while not EOF do
     begin
       case FieldByName('R_Kind').AsInteger of
         MB_IN  : cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
         MB_OUT : cmbODoor.Items.Add(FieldByName('R_Name').AsString);
         MB_INOUT :
         begin
           cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
           cmbODoor.Items.Add(FieldByName('R_Name').AsString);
         end;
       end;
       Next;
     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Persons');
     Open;
     cmbIPerson.Items.Clear;
     cmbOPerson.Items.Clear;
     while not EOF do
     begin
       cmbIPerson.Items.Add(FieldByName('P_Name').AsString);
       cmbOPerson.Items.Add(FieldByName('P_Name').AsString);
       Next;
     end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Co_BarCode FROM CoCars');
    Open;
    cmbBarCode.Items.Clear;
    while not EOF do
    begin
      cmbBarCode.Items.Add(FieldByName('Co_BarCode').AsString);
      Next;
    end;
    Close;}
    Free;
  end;
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);
  SetDirectionFarsi(cmbIDoor.Handle);
  SetDirectionFarsi(cmbIPerson.Handle);
  SetDirectionFarsi(cmbODoor.Handle);
  SetDirectionFarsi(cmbOPerson.Handle);
end;

procedure TfrmInOutCoRpt.FormShow(Sender: TObject);
begin
  Height := 361;
end;

procedure TfrmInOutCoRpt.cmbBarCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmInOutCoRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutCoRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutCoRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutCoRpt.txtFromTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOutCoRpt.txtFromTimeExit(Sender: TObject);
begin
  if txtFromTime.Text <> '' then
    txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmInOutCoRpt.txtToTimeExit(Sender: TObject);
begin
  if txtToTime.Text <> '' then
    txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmInOutCoRpt.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmInOutCoRpt.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmInOutCoRpt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmInOutCoRpt.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmInOutCoRpt.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmInOutCoRpt.cmdPrintClick(Sender: TObject);
var frmRptInOutCo : TfrmRptInOutCo;
  test : string;
begin
  if AreValidControls then
  begin
    if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
    Application.CreateForm(TfrmRptInOutCo, frmRptInOutCo);
    with frmRptInOutCo do
    begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
      begin
        if rdoBoth.Checked then
          lblFromToDate.Caption := ('ورود از تاريخ: ' )+ txtFromDate.Text + ('    خروج تا تاريخ: ' )+ txtToDate.Text
        else if rdoArival.Checked then
          lblFromToDate.Caption := ('ورود از تاريخ: ' )+ txtFromDate.Text + ('    ورود تا تاريخ: ' )+ txtToDate.Text
        else if rdoExit.Checked then
          lblFromToDate.Caption := ('خروج از تاريخ: ' )+ txtFromDate.Text + ('    خروج تا تاريخ: ' )+ txtToDate.Text;
      end
      else if txtFromDate.Text <> '' then
      begin
        if rdoBoth.Checked then
          lblFromToDate.Caption := ('ورود از تاريخ: ' )+ txtFromDate.Text
        else if rdoArival.Checked then
          lblFromToDate.Caption := ('ورود از تاريخ: ' )+ txtFromDate.Text
        else if rdoExit.Checked then
          lblFromToDate.Caption := ('خروج از تاريخ: ' )+ txtFromDate.Text;
      end
      else if txtToDate.Text <> '' then
      begin
        if rdoBoth.Checked then
          lblFromToDate.Caption := ('خروج تا تاريخ: ' )+ txtToDate.Text
        else if rdoArival.Checked then
          lblFromToDate.Caption := ('ورود تا تاريخ: ' )+ txtToDate.Text
        else if rdoExit.Checked then
          lblFromToDate.Caption := ('خروج تا تاريخ: ' )+ txtToDate.Text;
      end
      else
        lblFromToDate.Caption := '';

      if (txtFromTime.Text <> '') and (txtToTime.Text <> '') then
      begin
        if rdoBoth.Checked then
          lblFromToTime.Caption := ('ورود از ساعت: ' )+ txtFromTime.Text + ('خروج تا ساعت: ' )+ txtToTime.Text
        else if rdoArival.Checked then
          lblFromToTime.Caption := ('ورود از ساعت: ' )+ txtFromTime.Text + ('    ورود تا ساعت: ' )+ txtToTime.Text
        else if rdoExit.Checked then
          lblFromToTime.Caption := ('خروج از ساعت: ' )+ txtFromTime.Text + ('    خروج تا ساعت: ' )+ txtToTime.Text;
      end
      else if txtFromTime.Text <> '' then
      begin
        if rdoBoth.Checked then
          lblFromToTime.Caption := ('ورود از ساعت: ' )+ txtFromTime.Text
        else if rdoArival.Checked then
          lblFromToTime.Caption := ('ورود از ساعت: ' )+ txtFromTime.Text
        else if rdoExit.Checked then
          lblFromToTime.Caption := ('خروج از ساعت: ' )+ txtFromTime.Text;
      end
      else if txtToTime.Text <> '' then
      begin
        if rdoBoth.Checked then
          lblFromToTime.Caption := ('خروج تا ساعت: ' )+ txtToTime.Text
        else if rdoArival.Checked then
          lblFromToTime.Caption := ('ورود تا ساعت: ' )+ txtToTime.Text
        else if rdoExit.Checked then
          lblFromToTime.Caption := ('خروج تا ساعت: ' )+ txtToTime.Text;
      end
      else
        lblFromToTime.Caption := '';

      if rdoBoth.Checked then
        QRLabel15.Caption := 'گزارش ورود و خروج خودروهاي سازماني'
      else if rdoArival.Checked then
        QRLabel15.Caption := 'گزارش ورود خودروهاي سازماني'
      else if rdoExit.Checked then
        QRLabel15.Caption := 'گزارش خروج خودروهاي سازماني';
      
      with qryInOutCo do
      begin
        Close;
        with SQL do
        begin
          Clear;

          Add('SELECT InOutCo.IO_CarNumber, InOutCo.IO_Serial, InOutCo.IO_BarCode, CoCars.Co_Name, CoCars.Co_Color, InOutCo.IO_ODate, ');
          Add('InOutCo.IO_OTime, InOutCo.IO_IDate, InOutCo.IO_ITime, InOutCo.IO_OAmper, InOutCo.IO_IAmper, InOutCo.IO_Mojavez, ');
          Add('InOutCo.IO_Target, InOutCo.IO_Describe, NewPersons.P_Name, NewPersons.P_Family, InOutCo.IO_Driver ');
          Add('FROM InOutCo LEFT OUTER JOIN ');
          Add('CoCars ON InOutCo.IO_CarNumber = CoCars.Co_CarNumber AND InOutCo.IO_Serial = CoCars.Co_Serial LEFT OUTER JOIN ');
          Add('NewPersons ON InOutCo.IO_Driver = NewPersons.P_Code ');

{          Add('SELECT InOutCo.IO_CarNumber, InOutCo.IO_Serial, InOutCo.IO_BarCode, CoCars.Co_Name, CoCars.Co_Color, InOutCo.IO_ODate, ');
          Add('InOutCo.IO_OTime, InOutCo.IO_IDate, InOutCo.IO_ITime, InOutCo.IO_OAmper, InOutCo.IO_IAmper, InOutCo.IO_Mojavez, ');
          Add('InOutCo.IO_Target, InOutCo.IO_Describe ');
          Add('FROM InOutCo INNER JOIN ');
          Add('CoCars ON InOutCo.IO_CarNumber = CoCars.Co_CarNumber AND InOutCo.IO_Serial = CoCars.Co_Serial ');
}

//kaveh          Add('SELECT * FROM InOutCo, CoCars WHERE IO_BarCode = Co_BarCode');
//          if rdoBoth.Checked then
          Add('WHERE (IO_IsPark = ' + IntToStr(CNST_FALSE) + ' OR IO_IsPark = ' + IntToStr(CNST_TRUE) + ' ) ');
{          else if rdoArival.Checked then
            Add('WHERE (IO_IsPark = ' + IntToStr(CNST_TRUE) + ' ) ')
          else if rdoExit.Checked then
            Add('WHERE (IO_IsPark = ' + IntToStr(CNST_FALSE) + ' ) ');}

//kaveh          if cmbBarCode.Text <> '' then
//kaveh            Add('AND IO_BarCode = ''' + cmbBarCode.Text + '''');
          if txtBarCode.Text <> '' then
            Add('AND IO_BarCode = ''' + txtBarCode.Text + ''' ');


          if rdoBoth.Checked then
          begin
            if txtFromDate.Text <> '' then
              Add('AND IO_ODate >= ''' + txtFromDate.Text + ''' ');
            if txtToDate.Text <> '' then
              Add('AND IO_IDate <= ''' + txtToDate.Text + ''' ');// OR IO_IDate is null OR IO_IDate = '''' ) ');

            if txtFromTime.Text <> '' then
              Add('AND IO_OTime >= ''' + txtFromTime.Text + ''' ');
            if txtToTime.Text <> '' then
              Add('AND IO_ITime <= ''' + txtToTime.Text + ''' ');// OR IO_ITime is null OR IO_ITime = '''' ) ');
          end
          else if rdoArival.Checked then
          begin
            if txtFromDate.Text <> '' then
              Add('AND IO_IDate >= ''' + txtFromDate.Text + ''' ');
            if txtToDate.Text <> '' then
              Add('AND IO_IDate <= ''' + txtToDate.Text + ''' ');

            if txtFromTime.Text <> '' then
              Add('AND IO_ITime >= ''' + txtFromTime.Text + ''' ');
            if txtToTime.Text <> '' then
              Add('AND IO_ITime <= ''' + txtToTime.Text + ''' ');
          end
          else if rdoExit.Checked then
          begin
            if txtFromDate.Text <> '' then
              Add('AND IO_ODate >= ''' + txtFromDate.Text + ''' ');
            if txtToDate.Text <> '' then
              Add('AND IO_ODate <= ''' + txtToDate.Text + ''' ');

            if txtFromTime.Text <> '' then
              Add('AND IO_OTime >= ''' + txtFromTime.Text + ''' ');
            if txtToTime.Text <> '' then
              Add('AND IO_OTime <= ''' + txtToTime.Text + ''' ');
          end;


          if cmbCarName.Text <> '' then
            Add('AND Co_Name = ''' + cmbCarName.Text + ''' ');

          if txtNumber.Text <> '' then
            Add('AND IO_CarNumber = ''' + txtNumber.Text + ''' ');

//kaveh          if cmbCity.Text <> '' then
//kaveh            Add('AND Co_City = ''' + cmbCity.Text + ''' ');

          if txtSerial.Text <> '' then
            Add('AND IO_Serial = ''' + txtSerial.Text + ''' ');

{kaveh
          if cmbIDoor.Text <> '' then
            Add('AND IO_IDoor = ' + IntToStr(GetDoorCode(cmbIDoor.Text)));
          if cmbIPerson.Text <> '' then
            Add('AND IO_IPerson = ''' + GetPersonCode(cmbIPerson.Text) + ''' ');

          if cmbODoor.Text <> '' then
            Add('AND IO_ODoor = ' + IntToStr(GetDoorCode(cmbODoor.Text)));
          if cmbOPerson.Text <> '' then
            Add('AND IO_OPerson = ''' + GetPersonCode(cmbOPerson.Text) + ''' ');
}
          case rdoSort.ItemIndex of
            0: Add('ORDER BY IO_ODate, IO_OTime, IO_CarNumber, IO_BarCode ');
            1: Add('ORDER BY IO_IDate, IO_ITime, IO_CarNumber, IO_BarCode ');
            2: Add('ORDER BY IO_BarCode, IO_ODate, IO_OTime, IO_CarNumber ');
            3: Add('ORDER BY IO_CarNumber, IO_Serial, IO_ODate, IO_OTime, IO_BarCode ');
            4: Add('ORDER BY IO_Serial, IO_CarNumber, IO_ODate, IO_OTime, IO_BarCode ');
          end;
//kaveh          Add('ORDER BY IO_ODate, IO_OTime, IO_ODoor, IO_BarCode');
        end;
        test := frmRptInOutCo.qryInOutCo.SQL.Text;
        Open;
        if RecordCount > 0 then
        begin
          if rdoScreen.Checked then
            qrptMachines.Preview
          else
            qrptMachines.Print;
        end
        else if rdoBoth.Checked then
          InformationMessage('ورود و خروجي وجود ندارد.')
        else if rdoArival.Checked then
          InformationMessage('گزارشي براي ورود خودروها وجود ندارد')
        else if rdoExit.Checked then
          InformationMessage('گزارشي براي خروج خودروها وجود ندارد.');
        Close;
      end;
      Free;
    end;
    if g_options.RdrOff_Rpt = MB_TRUE then
      UserControl := False;
  end;
end;



end.
