unit InOutRp;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpInOut, RpInOutPOS, RpInOutPOSLS, RpInOutCount, DBS, RunCmnds, ExtCtrls, DosMove;

type
  TfrmInOutRpt = class(TForm)
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
    cmbBarCode: TComboBox;
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
    rdoPaper: TRadioGroup;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    rdoParked: TRadioButton;
    rdoDoorAndOr: TRadioGroup;
    rdoPersonAndOr: TRadioGroup;
    cmdCancelFilter: TBitBtn;
    Label1: TLabel;
    cmbEntranceDepartment: TComboBox;
    cmbEntranceDepartmentCode: TComboBox;
    rdoCount: TRadioButton;
    cmbIDoorName: TComboBox;
    cmbIPersonName: TComboBox;
    cmbODoorName: TComboBox;
    cmbOPersonName: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeEnter(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtToTimeExit(Sender: TObject);
    procedure cmbIPersonKeyPress(Sender: TObject; var Key: Char);
    procedure rdoBothClick(Sender: TObject);
    procedure cmdCancelFilterClick(Sender: TObject);
    procedure grpPrintTypeClick(Sender: TObject);
    procedure cmbEntranceDepartmentChange(Sender: TObject);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmbIDoorClick(Sender: TObject);
    procedure cmbIDoorNameClick(Sender: TObject);
    procedure cmbIPersonClick(Sender: TObject);
    procedure cmbIPersonNameClick(Sender: TObject);
    procedure cmbODoorClick(Sender: TObject);
    procedure cmbODoorNameClick(Sender: TObject);
    procedure cmbOPersonClick(Sender: TObject);
    procedure cmbOPersonNameClick(Sender: TObject);
  private
    { Private declarations }
    SrchStr : String;
    
    function AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  Printers, QuickRpt;

{$R *.DFM}

procedure TfrmInOutRpt.SetWinF;
var
  i : Byte;
begin
  Caption := (Caption);
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
  rdoPaper.Caption := (rdoPaper.Caption);
  for i := 0 to rdoPaper.Items.Count - 1 do
    rdoPaper.Items.Strings[i] := (rdoPaper.Items.Strings[i]);
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count - 1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmInOutRpt.AreValidControls : Boolean;
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
  else
    AreValidControls := True;
end;


procedure TfrmInOutRpt.FormCreate(Sender: TObject);
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
{kaveh     SQL.Clear;
     SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
     Open;
     cmbCity.Items.Clear;
     while not EOF do
     begin
       cmbCity.Items.Add(FieldByName('City_Name').AsString);
       Next;
     end;   

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
     Open;
     cmbCarName.Items.Clear;
     while not EOF do
     begin
       cmbCarName.Items.Add(FieldByName('Car_Name').AsString);
       Next;
     end;  kaveh}

     Close;
     SQL.Clear;
     SQL.Add('SELECT R_Code, R_Name FROM Readers');
     Open;
     cmbIDoor.Items.Clear;
     cmbODoor.Items.Clear;
     while not EOF do
     begin
       cmbIDoor.Items.Add(FieldByName('R_Code').AsString);
       cmbIDoorName.Items.Add(FieldByName('R_Name').AsString);
       cmbODoor.Items.Add(FieldByName('R_Code').AsString);
       cmbODoorName.Items.Add(FieldByName('R_Name').AsString);
       Next;
     end;
     
//     while not EOF do
//     begin
//       case FieldByName('R_Kind').AsInteger of
//         MB_IN  : cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
//         MB_OUT : cmbODoor.Items.Add(FieldByName('R_Name').AsString);
//         MB_INOUT :
//         begin
//           cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
//           cmbODoor.Items.Add(FieldByName('R_Name').AsString);
//         end;
//       end;
//       Next;
//     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT P_BarCode, P_Name FROM Persons');
     Open;
     cmbIPerson.Items.Clear;
     cmbOPerson.Items.Clear;
     while not EOF do
     begin
       cmbIPerson.Items.Add(FieldByName('P_BarCode').AsString);
       cmbIPersonName.Items.Add(FieldByName('P_Name').AsString);
       cmbOPerson.Items.Add(FieldByName('P_BarCode').AsString);
       cmbOPersonName.Items.Add(FieldByName('P_Name').AsString);
       Next;
     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM BarCodes');
     Open;
     cmbBarCode.Items.Clear;
     cmbBarCode.Items.Clear;
     while not EOF do
     begin
       cmbBarCode.Items.Add(FieldByName('Card_Code').AsString);
       Next;
     end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT Depart_Code,Depart_Name FROM Department ');
    SQL.Add('ORDER BY Depart_Name');
    Open;
    while not qry.EOF do
    begin
      cmbEntranceDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
      cmbEntranceDepartmentCode.Items.Add(qry.FieldByName('Depart_Code').AsString);
      Next;
    end;
    Close;
    Free;
  end;
  //cmbEntranceDepartmentCode.ItemIndex := cmbEntranceDepartmentCode.Items.IndexOf(IntToStr(g_Options.Department));
  //cmbEntranceDepartment.ItemIndex := cmbEntranceDepartmentCode.ItemIndex;
  cmbEntranceDepartmentCode.ItemIndex := -1;
  cmbEntranceDepartment.ItemIndex := -1;


  SetDirectionFarsi(cmbBarCode.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);
  SetDirectionFarsi(cmbIDoor.Handle);
  SetDirectionFarsi(cmbIPerson.Handle);
  SetDirectionFarsi(cmbODoor.Handle);
  SetDirectionFarsi(cmbOPerson.Handle);

{$ifdef POSBase}
  if rdoCount.Checked then
  begin
    rdoPaper.ItemIndex := 0;
    rdoPaper.Enabled := True;
  end
  else
  begin
    rdoPaper.ItemIndex := 1;
    rdoPaper.Enabled := False;
  end;
{$endif POSBase}
{$ifdef PCBase}
  rdoPaper.Enabled := True;
{$endif PCBase}
  
end;

procedure TfrmInOutRpt.grpPrintTypeClick(Sender: TObject);
begin
  if rdoScreen.Checked then
    cmdPrint.Hint := 'پيش نمايش گزارش'
  else if rdoPrinter.Checked then
    cmdPrint.Hint := 'چاپ گزارش';
end;

procedure TfrmInOutRpt.rdoBothClick(Sender: TObject);
begin
{$ifdef POSBase}
  if rdoCount.Checked then
  begin
    rdoPaper.ItemIndex := 0;
    rdoPaper.Enabled := True;
  end
  else
  begin
    rdoPaper.ItemIndex := 1;
    rdoPaper.Enabled := False;
  end;
{$endif POSBase}
{$ifdef PCBase}
  rdoPaper.Enabled := True;
{$endif PCBase}

  Label9.Enabled := True;
  cmbIDoor.Enabled := True;
  cmbIDoorName.Enabled := True;
  Label10.Enabled:= True;
  cmbIPerson.Enabled := True;
  cmbIPersonName.Enabled := True;
  Label8.Enabled := True;
  cmbODoor.Enabled := True;
  cmbODoorName.Enabled := True;
  Label11.Enabled := True;
  cmbOPerson.Enabled := True;
  cmbOPersonName.Enabled := True;
  if (rdoBoth.Checked) or (rdoCount.Checked) then
  begin
     rdoDoorAndOr.Enabled := True;
     rdoPersonAndOr.Enabled := True;
  end
  else
  begin
     rdoDoorAndOr.Enabled := False;
     rdoPersonAndOr.Enabled := False;
  end;
  if (rdoArival.Checked) or (rdoParked.Checked) then
  begin
    Label8.Enabled := False;
    cmbODoor.Enabled := False;
    cmbODoorName.Enabled := False;
    Label11.Enabled := False;
    cmbOPerson.Enabled := False;
    cmbOPersonName.Enabled := False;
  end
  else if rdoExit.Checked then
  begin
  Label9.Enabled := False;
  cmbIDoor.Enabled := False;
  cmbIDoorName.Enabled := False;
  Label10.Enabled:= False;
  cmbIPerson.Enabled := False;
  cmbIPersonName.Enabled := False;
  end;

  if rdoCount.Checked then
    rdoSort.Enabled := False
  else
    rdoSort.Enabled := True;

end;

procedure TfrmInOutRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutRpt.txtFromTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOutRpt.txtFromTimeExit(Sender: TObject);
begin
  if txtFromTime.Text <> '' then
    txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmInOutRpt.txtToTimeExit(Sender: TObject);
begin
  if txtToTime.Text <> '' then
    txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmInOutRpt.cmbBarCodeEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmInOutRpt.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Hex(Key);
//  SrchNearst(SrchStr, cmbBarCode, Key);
end;

procedure TfrmInOutRpt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmInOutRpt.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmInOutRpt.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmInOutRpt.cmbEntranceDepartmentChange(Sender: TObject);
begin
  cmbEntranceDepartmentCode.ItemIndex := cmbEntranceDepartment.ItemIndex;
end;

procedure TfrmInOutRpt.cmbIDoorClick(Sender: TObject);
begin
  cmbIDoorName.ItemIndex := cmbIDoor.ItemIndex;
end;

procedure TfrmInOutRpt.cmbIDoorNameClick(Sender: TObject);
begin
  cmbIDoor.ItemIndex := cmbIDoorName.ItemIndex;
end;

procedure TfrmInOutRpt.cmbIPersonClick(Sender: TObject);
begin
  cmbIPersonName.ItemIndex := cmbIPerson.ItemIndex;
end;

procedure TfrmInOutRpt.cmbIPersonKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Hex(Key);
end;

procedure TfrmInOutRpt.cmbIPersonNameClick(Sender: TObject);
begin
  cmbIPerson.ItemIndex := cmbIPersonName.ItemIndex;
end;

procedure TfrmInOutRpt.cmbODoorClick(Sender: TObject);
begin
  cmbODoorName.ItemIndex := cmbODoor.ItemIndex;
end;

procedure TfrmInOutRpt.cmbODoorNameClick(Sender: TObject);
begin
  cmbODoor.ItemIndex := cmbODoorName.ItemIndex;
end;

procedure TfrmInOutRpt.cmbOPersonClick(Sender: TObject);
begin
  cmbOPersonName.ItemIndex := cmbOPerson.ItemIndex;
end;

procedure TfrmInOutRpt.cmbOPersonNameClick(Sender: TObject);
begin
  cmbOPerson.ItemIndex := cmbOPersonName.ItemIndex;
end;

procedure TfrmInOutRpt.cmdCancelFilterClick(Sender: TObject);
//var qry : TAdoQuery;
begin
//     cmbBarCode.ItemIndex := -1;
//      txtNumber.Text := '';
//      txtSerial.Text := '';
//      txtIDate.Text := '';
//      txtODate.Text := '';
//      txtITime.Text := '';
//      txtOTime.Text := '';
//      ReadData;

  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
  txtFromTime.Text := '';
  txtToTime.Text := '';
  txtNumber.Text := '';
  txtSerial.Text := '';
  rdoDoorAndOr.ItemIndex := 0;
  rdoPersonAndOr.ItemIndex := 0;
  rdoBoth.Checked := True;
  rdoScreen.Checked := True;
{$ifdef POSBase}
  if rdoCount.Checked then
  begin
    rdoPaper.ItemIndex := 0;
    rdoPaper.Enabled := True;
  end
  else
  begin
    rdoPaper.ItemIndex := 1;
    rdoPaper.Enabled := False;
  end;
{$endif POSBase}
{$ifdef PCBase}
  rdoPaper.Enabled := True;
{$endif PCBase}
  rdoSort.ItemIndex := 0;
  cmbBarCode.ItemIndex := -1;
  cmbIDoor.ItemIndex := -1;
  cmbIDoorName.ItemIndex := -1;
  cmbODoor.ItemIndex := -1;
  cmbODoorName.ItemIndex := -1;
  cmbIPerson.ItemIndex := -1;
  cmbIPersonName.ItemIndex := -1;
  cmbOPerson.ItemIndex := -1;
  cmbOPersonName.ItemIndex := -1;

  cmbEntranceDepartmentCode.ItemIndex := -1;
  cmbEntranceDepartment.ItemIndex := -1;
 
{  qry := TAdoQuery.Create(Application);
  with qry do
  begin
     connection := frmDBS.adoConnect;
     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Readers');
     Open;
     cmbIDoor.Items.Clear;
     cmbODoor.Items.Clear;
     while not EOF do
     begin
       cmbIDoor.Items.Add(FieldByName('R_Code').AsString);
       cmbODoor.Items.Add(FieldByName('R_Code').AsString);
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
       cmbIPerson.Items.Add(FieldByName('P_BarCode').AsString);
       cmbOPerson.Items.Add(FieldByName('P_BarCode').AsString);
       Next;
     end;
     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM BarCodes');
     Open;
     cmbBarCode.Items.Clear;
     cmbBarCode.Items.Clear;
     while not EOF do
     begin
       cmbBarCode.Items.Add(FieldByName('Card_Code').AsString);
       Next;
     end;
     Close;
     Free;
  end;}

end;

procedure TfrmInOutRpt.cmdPrintClick(Sender: TObject);
var
{$ifdef POSBase}
  frmRptInOutPOS : TfrmRptInOutPOS;
  frmRptInOutPOSLS : TfrmRptInOutPOSLS;
{$endif POSBase}
{$ifdef PCBase}
  frmRptInOut : TfrmRptInOut;
{$endif PCBase}
  frmRptInOutCount : TfrmRptInOutCount;
  test, stSql1, stSql2, EntranceDepart : string;
  qry : TAdoQuery;
begin
  if AreValidControls then
  begin
    if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
    AddRecToMachine;

    if not rdoCount.Checked then
    begin
{$ifdef POSBase}
     Application.CreateForm(TfrmRptInOutPOS, frmRptInOutPOS);
     with frmRptInOutPOS do
{$endif POSBase}
{$ifdef PCBase}
     Application.CreateForm(TfrmRptInOut, frmRptInOut);
     with frmRptInOut do
{$endif PCBase}
     begin

      if rdoBoth.Checked then
        lblRptName.Caption := ('گزارش ورود و خروج خودروها')
      else if rdoArival.Checked then
        lblRptName.Caption := ('گزارش ورود خودروها')
      else if rdoExit.Checked then
        lblRptName.Caption := ('گزارش خروج خودروها')
      else if rdoParked.Checked then
        lblRptName.Caption := ('گزارش توقف خودروها در پارکینگ');

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text + ('    تا تاريخ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ: ' )+ txtToDate.Text
      else
        lblFromToDate.Caption := '';

      if (txtFromTime.Text <> '') and (txtToTime.Text <> '') then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text + ('    تا ساعت: ' )+ txtToTime.Text
      else if txtFromTime.Text <> '' then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text
      else if txtToTime.Text <> '' then
        lblFromToTime.Caption := ('تا ساعت: ' )+ txtToTime.Text
      else
        lblFromToTime.Caption := '';


      with qryMachines do
      begin
        Close;
        with SQL do
        begin
          if cmbEntranceDepartmentCode.ItemIndex = -1 then
          begin
            lblDepartName.Caption := '';
            //EntranceDepart := IntToStr(g_Options.Department)
          end
          else
          begin
            EntranceDepart := cmbEntranceDepartmentCode.Text;
            qry := TAdoQuery.Create(Application);
            qry.connection := frmDBS.adoConnect;
            qry.SQL.Clear;
            qry.SQL.Add('SELECT  Depart_Code, Depart_Name ');
            qry.SQL.Add('From Department ');
            qry.SQL.Add('WHERE Depart_Code = ' + EntranceDepart);
            qry.Open;
            lblDepartName.Caption := qry.FieldByName('Depart_Name').AsString;
            qry.Close;
            qry.Free;
          end;
          Clear;
          if rdoBoth.Checked then
           begin
            stSql1 := '';
            stSql2 := '';
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              stSql1 := ' AND (M_IDate > ''' + txtFromDate.Text + ''' ';
              stSql1 := stSql1 + ' OR (M_IDate = ''' + txtFromDate.Text + ''' ';
              stSql1 := stSql1 + ' AND M_ITime >= ''' + txtFromTime.Text + ''' )) ';
              stSql1 := stSql1 + ' AND (M_IDate < ''' + txtToDate.Text + ''' ';
              stSql1 := stSql1 + ' OR (M_IDate = ''' + txtToDate.Text + ''' ';
              stSql1 := stSql1 + ' AND M_ITime <= ''' + txtToTime.Text + ''' )) ';

              stSql2 := ' AND (M_ODate > ''' + txtFromDate.Text + ''' ';
              stSql2 := stSql2 + ' OR (M_ODate = ''' + txtFromDate.Text + ''' ';
              stSql2 := stSql2 + ' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ';
              stSql2 := stSql2 + ' AND (M_ODate < ''' + txtToDate.Text + ''' ';
              stSql2 := stSql2 + ' OR (M_ODate = ''' + txtToDate.Text + ''' ';
              stSql2 := stSql2 + ' AND M_OTime <= ''' + txtToTime.Text + ''' )) ';
            end
            else
            begin
              if txtFromDate.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_IDate >= ''' + txtFromDate.Text + ''' ';
                stSql2 := stSql2 + ' AND M_ODate >= ''' + txtFromDate.Text + ''' ';
               end;
              if txtFromTime.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_ITime >= ''' + txtFromTime.Text + ''' ';
                stSql2 := stSql2 + ' AND M_OTime >= ''' + txtFromTime.Text + ''' ';
               end;
              if txtToDate.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_IDate <= ''' + txtToDate.Text + ''' ';
                stSql2 := stSql2 + ' AND M_ODate <= ''' + txtToDate.Text + ''' ';
               end;
              if txtToTime.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_ITime <= ''' + txtToTime.Text + ''' ';
                stSql2 := stSql2 + ' AND M_OTime <= ''' + txtToTime.Text + ''' ';
               end;
            end;
            Add('SELECT * FROM ( ' );
            Add('SELECT InputCar.M_rdrCode, InputCar.M_BarCode, InputCar.M_Number, InputCar.M_Serial, InputCar.M_IDate, InputCar.M_ITime, ' );
            Add('InputCar.M_OperatorCode, InputCar.M_ODate, InputCar.M_OTime, InputCar.M_IsPark, InputCar.M_IsDeleted, '{InputCar.M_Status, '} );
            Add('InputCar.M_IUserName, InputCar.M_UserName, InputCar.M_EntranceDepart, NewPersons.P_Family, NewPersons.P_Name ' );
            Add(', ');
            Add('case ');
            Add('when InputCar.M_Status between 21 and 24 then ''عادی'' ');
            Add('when InputCar.M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM InputCar LEFT OUTER JOIN ' );
            Add('NewPersons ON InputCar.M_Driver = NewPersons.P_Code ' );
            Add('WHERE InputCar.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql1 + ' ' );
//                1) AND (InputCar.M_IDate >= ''1388/01/01'') AND (InputCar.M_IDate <= ''1388/06/07'') ');
            Add('AND InputCar.M_IsPark = ' + IntToStr(CNST_TRUE) + ' ' );
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND InputCar.M_EntranceDepart = ' + EntranceDepart + ' ' );
            Add('UNION ' );
            Add('SELECT Machines.M_rdrCode, Machines.M_BarCode, Machines.M_Number, Machines.M_Serial, Machines.M_IDate, Machines.M_ITime, ' );
            Add('Machines.M_OperatorCode, Machines.M_ODate, Machines.M_OTime, Machines.M_IsPark, Machines.M_IsDeleted, '{Machines.M_Status, '} );
            Add('Machines.M_IUserName, Machines.M_UserName, Machines.M_EntranceDepart, NewPersons.P_Family, NewPersons.P_Name ' );
            Add(', ');
            Add('case ');
            Add('when Machines.M_Status between 21 and 24 then ''عادی'' ');
            Add('when Machines.M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM Machines LEFT OUTER JOIN ' );
            Add('NewPersons ON Machines.M_Driver = NewPersons.P_Code ' );
            Add('WHERE Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql2 + ' ' );
//                1) AND (Machines.M_IDate >= ''1388/01/01'') AND (Machines.M_IDate <= ''1388/06/07'') ' +
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND Machines.M_EntranceDepart = ' + EntranceDepart + ' ' );
            Add(') l1 WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE)+ ' ' );

//            SQL.Add('SELECT * FROM (SELECT M_rdrCode,M_BarCode,M_Number,M_Serial,M_IDate,M_ITime,M_OperatorCode,M_ODate,M_OTime,M_IsPark,M_IsDeleted FROM InputCar WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql1 +
//                    ' union SELECT M_rdrCode,M_BarCode,M_Number,M_Serial,M_IDate,M_ITime,M_OperatorCode,M_ODate,M_OTime,M_IsPark,M_IsDeleted FROM Machines WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql2 + ' ) l1 WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE)+ ' ' );
           end
          else if rdoArival.Checked then
          begin
            Add('SELECT InputCar.M_rdrCode, InputCar.M_BarCode, InputCar.M_Number, InputCar.M_Serial, InputCar.M_IDate, InputCar.M_ITime, ' );
            Add('InputCar.M_OperatorCode, InputCar.M_ODate, InputCar.M_OTime, InputCar.M_IsPark, InputCar.M_IsDeleted,'{ InputCar.M_Status'} );
            Add('InputCar.M_IUserName, InputCar.M_UserName, InputCar.M_EntranceDepart, NewPersons.P_Family, NewPersons.P_Name ' );
            Add(', ');
            Add('case ');
            Add('when InputCar.M_Status between 21 and 24 then ''عادی'' ');
            Add('when InputCar.M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM InputCar LEFT OUTER JOIN ' );
            Add('NewPersons ON InputCar.M_Driver = NewPersons.P_Code ' );
            Add('WHERE InputCar.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql1 + ' ' );
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND InputCar.M_EntranceDepart = ' + EntranceDepart + ' ');
//            Add('SELECT M_rdrCode,M_BarCode,M_Number,M_Serial,M_IDate,M_ITime,M_OperatorCode,M_ODate,M_OTime,M_IsPark,M_IsDeleted FROM InputCar WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE));
          end
          else if rdoExit.Checked then
          begin
            Add('SELECT Machines.M_rdrCode, Machines.M_BarCode, Machines.M_Number, Machines.M_Serial, Machines.M_IDate, Machines.M_ITime, ' );
            Add('Machines.M_OperatorCode, Machines.M_ODate, Machines.M_OTime, Machines.M_IsPark, Machines.M_IsDeleted,'{ Machines.M_Status'} );
            Add('Machines.M_IUserName, Machines.M_UserName, Machines.M_EntranceDepart, NewPersons.P_Family, NewPersons.P_Name ' );
            Add(', ');
            Add('case ');
            Add('when Machines.M_Status between 21 and 24 then ''عادی'' ');
            Add('when Machines.M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM Machines LEFT OUTER JOIN ' );
            Add('NewPersons ON Machines.M_Driver = NewPersons.P_Code ' );
            Add('WHERE Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql2 + ' ' );
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND Machines.M_EntranceDepart = ' + EntranceDepart + ' ');
//            Add('SELECT M_rdrCode,M_BarCode,M_Number,M_Serial,M_IDate,M_ITime,M_OperatorCode,M_ODate,M_OTime,M_IsPark,M_IsDeleted FROM Machines WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE));
          end
          else if rdoParked.Checked then
          begin
            Add('SELECT InputCar.M_rdrCode, InputCar.M_BarCode, InputCar.M_Number, InputCar.M_Serial, InputCar.M_IDate, InputCar.M_ITime, ' );
            Add('InputCar.M_OperatorCode, InputCar.M_ODate, InputCar.M_OTime, InputCar.M_IsPark, InputCar.M_IsDeleted,'{ InputCar.M_Status'} );
            Add('InputCar.M_IUserName, InputCar.M_UserName, InputCar.M_EntranceDepart, NewPersons.P_Family, NewPersons.P_Name ' );
            Add(', ');
            Add('case ');
            Add('when InputCar.M_Status between 21 and 24 then ''عادی'' ');
            Add('when InputCar.M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM InputCar LEFT OUTER JOIN ' );
            Add('NewPersons ON InputCar.M_Driver = NewPersons.P_Code ' );
            Add('WHERE InputCar.M_IsDeleted <>  ' + IntToStr(CNST_TRUE) + ' ' );
            Add('AND M_IsPark = ' + inttostr(CNST_TRUE) + ' ' + stSql1 + ' ' );
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND InputCar.M_EntranceDepart =  ' + EntranceDepart + ' ');
//            Add('SELECT M_rdrCode,M_BarCode,M_Number,M_Serial,M_IDate,M_ITime,M_OperatorCode,M_ODate,M_OTime,M_IsPark,M_IsDeleted FROM InputCar WHERE M_IsPark = ' + inttostr(CNST_TRUE) + ' AND M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ');
          end;

{          if rdoArival.Checked then
            Add('WHERE M_IsPark = ' + IntToStr(CNST_TRUE))
          else if rdoExit.Checked then
            Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE))
          else
            Add('WHERE (M_IsPark = ' + IntToStr(CNST_FALSE) + ' OR M_IsPark = ' + IntToStr(CNST_TRUE) + ' )');
           }

          if rdoArival.Checked then
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add(' AND (M_IDate > ''' + txtFromDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtFromDate.Text + ''' ');
              Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' )) ');

              Add(' AND (M_IDate < ''' + txtToDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtToDate.Text + ''' ');
              Add(' AND M_ITime <= ''' + txtToTime.Text + ''' )) ');
            end  //ok
            else
            begin
              if txtFromDate.Text <> '' then
                Add(' AND M_IDate >= ''' + txtFromDate.Text + ''' ');
              if txtToDate.Text <> '' then
                Add(' AND M_IDate <= ''' + txtToDate.Text + ''' ');
              if txtFromTime.Text <> '' then
                Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' ');
              if txtToTime.Text <> '' then
                Add(' AND M_ITime <= ''' + txtToTime.Text + ''' ');
            end;
          end //ok

          else if rdoExit.Checked then
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add(' AND (M_ODate > ''' + txtFromDate.Text + ''' ');
              Add(' OR (M_ODate = ''' + txtFromDate.Text + ''' ');
              Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

              Add(' AND (M_ODate < ''' + txtToDate.Text + ''' ');
              Add(' OR (M_ODate = ''' + txtToDate.Text + ''' ');
              Add(' AND M_OTime <= ''' + txtToTime.Text + ''' )) ');
            end
            else
            begin
              if txtFromDate.Text <> '' then
                Add(' AND M_ODate >= ''' + txtFromDate.Text + ''' ');
              if txtFromTime.Text <> '' then
                Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' ');
              if txtToDate.Text <> '' then
                Add(' AND M_ODate <= ''' + txtToDate.Text + ''' ');
              if txtToTime.Text <> '' then
                Add(' AND M_OTime <= ''' + txtToTime.Text + ''' ');
            end;
          end  //ok

          else if rdoParked.Checked then
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add(' AND (M_IDate > ''' + txtFromDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtFromDate.Text + ''' ');
              Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' )) ');

              Add(' AND (M_IDate < ''' + txtToDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtToDate.Text + ''' ');
              Add(' AND M_ITime <= ''' + txtToTime.Text + ''' )) ');
            end  //ok
            else
            begin
              if txtFromDate.Text <> '' then
                Add(' AND M_IDate >= ''' + txtFromDate.Text + ''' ');
              if txtToDate.Text <> '' then
                Add(' AND M_IDate <= ''' + txtToDate.Text + ''' ');
              if txtFromTime.Text <> '' then
                Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' ');
              if txtToTime.Text <> '' then
                Add(' AND M_ITime <= ''' + txtToTime.Text + ''' ');
            end;
          end; //ok

//          else if rdoBoth.Checked then
//          begin
//            if (txtFromDate.Text <> txtToDate.Text) and
//               (txtFromTime.Text <> txtToTime.Text) then
//            begin
//              Add('AND (M_IDate > ''' + txtFromDate.Text + '''');
//              Add('OR (M_IDate = ''' + txtFromDate.Text + '''');
//              Add('AND M_ITime >= ''' + txtFromTime.Text + '''))');
//
//              Add('AND (M_ODate < ''' + txtToDate.Text + '''');
//              Add('OR (M_ODate = ''' + txtToDate.Text + '''');
//              Add('AND M_OTime <= ''' + txtToTime.Text + '''))');
//            end
//            else
//            begin
//              if txtFromDate.Text <> '' then
//                Add('AND M_IDate >= ''' + txtFromDate.Text + '''');
//              if txtFromTime.Text <> '' then
//                Add('AND M_ITime >= ''' + txtFromTime.Text + '''');
//              if txtToDate.Text <> '' then
//                Add('AND M_ODate <= ''' + txtToDate.Text + '''');
//              if txtToTime.Text <> '' then
//                Add('AND M_OTime <= ''' + txtToTime.Text + '''');
//            end;
//          end;

          if cmbBarCode.Text <> '' then
            Add(' AND M_Barcode = ''' + cmbBarCode.Text + ''' ');

          if txtNumber.Text <> '' then
            Add(' AND M_Number = ''' + txtNumber.Text + ''' ');

{          if cmbCity.Text <> '' then
            Add(' AND M_CityName = ''' + cmbCity.Text + ''' ');}

          if txtSerial.Text <> '' then
            Add(' AND M_Serial = ''' + txtSerial.Text + ''' ');

          if rdoArival.Checked then
          begin
            if cmbIDoor.Text <> '' then
              Add(' AND M_rdrCode = ' + cmbIDoor.Text);
            if cmbIPerson.Text <> '' then
              Add(' AND M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
          end
          else if rdoExit.Checked then
          begin
            if cmbODoor.Text <> '' then
              Add(' AND M_rdrCode = ' + cmbODoor.Text);
            if cmbOPerson.Text <> '' then
              Add(' AND M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
          end
          else if rdoParked.Checked then
          begin
            if cmbIDoor.Text <> '' then
              Add(' AND M_rdrCode = ' + cmbIDoor.Text);
            if cmbIPerson.Text <> '' then
              Add(' AND M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
          end
         else if rdoBoth.Checked then
          begin
            if rdoDoorAndOr.ItemIndex = 0 then
            begin
              if cmbIDoor.Text <> '' then
                Add(' AND M_rdrCode = ' + cmbIDoor.Text);
              if cmbODoor.Text <> '' then
                Add(' AND M_rdrCode = ' + cmbODoor.Text);
            end
            else
            begin
              if cmbIDoor.Text <> '' then
              begin
                Add(' AND (M_rdrCode = ' + cmbIDoor.Text);
                if cmbODoor.Text <> '' then
                  Add(' OR M_rdrCode = ' + cmbODoor.Text);
                Add(' ) ');
              end
              else
              begin
                if cmbODoor.Text <> '' then
                  Add(' AND M_rdrCode = ' + cmbODoor.Text);
              end;
            end;

            if rdoPersonAndOr.ItemIndex = 0 then
            begin
              if cmbIPerson.Text <> '' then
                Add(' AND M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
              if cmbOPerson.Text <> '' then
                Add(' AND M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
            end
            else
            begin
              if cmbIPerson.Text <> '' then
              begin
                Add(' AND (M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
                if cmbOPerson.Text <> '' then
                  Add(' OR M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
                Add(' ) ');
              end
              else
              begin
                if cmbOPerson.Text <> '' then
                  Add(' AND M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
              end;
            end;
          end;
//         if cmbIDoor.Text <> '' then
//              Add(' AND M_rdrCode = ' + IntToStr(GetDoorCode(cmbIDoor.Text)));
//            if cmbIPerson.Text <> '' then
//              Add(' AND M_OperatorCode = ''' + GetPersonCode(cmbIPerson.Text) + ''' ');
//
//            if cmbODoor.Text <> '' then
//              Add(' AND M_rdrCode = ' + IntToStr(GetDoorCode(cmbODoor.Text)));
//            if cmbOPerson.Text <> '' then
//              Add(' AND M_OperatorCode = ''' + GetPersonCode(cmbOPerson.Text) + ''' ');
          case rdoSort.ItemIndex of
//kaveh            0: Add('ORDER BY M_IDate, M_ITime, M_IDoor, M_BarCode');
            0: Add('ORDER BY M_IDate, M_ITime, M_Number, M_BarCode');
            1: Add('ORDER BY M_ODate, M_OTime, M_Number, M_BarCode');
            2: Add('ORDER BY M_BarCode, M_IDate, M_ITime, M_Number');
            3: Add('ORDER BY M_Number, M_IDate, M_ITime, M_BarCode');
            4: Add('ORDER BY M_Serial, M_IDate, M_ITime, M_BarCode, M_Number');
          end;

        end;
        test := SQL.Text;
        Open;
        if RecordCount > 0 then
        begin
          while Ord(qrptMachines.Page.PaperSize) > 7 do
            qrptMachines.Page.PaperSize := Pred(qrptMachines.Page.PaperSize);

          if rdoPaper.ItemIndex <> 0 then
          begin
            qrptMachines.Page.Orientation := poPortrait;
            while Ord(qrptMachines.Page.PaperSize) <> 9 do
              qrptMachines.Page.PaperSize := Succ(qrptMachines.Page.PaperSize);
          end
          else
          begin
            qrptMachines.Page.Orientation := poLandscape;
            while Ord(qrptMachines.Page.PaperSize) <> 9 do
              qrptMachines.Page.PaperSize := Succ(qrptMachines.Page.PaperSize);
          end;


          if rdoScreen.Checked then
            qrptMachines.Preview
          else
            qrptMachines.Print;
        end
        else
        begin
          if rdoBoth.Checked then
            InformationMessage('ورود و خروجي وجود ندارد.')
          else if rdoArival.Checked then
            InformationMessage('هنوز خودرويي وارد نشده است.')
          else if rdoExit.Checked then
            InformationMessage('هنوز خودرويي خارج نشده است.')
          else
            InformationMessage('خودرویی در پارکینگ توقف نکرده است.');
        end;
        Close;
      end;
      Free;
     end;
    end

    
    else
    begin
     Application.CreateForm(TfrmRptInOutCount, frmRptInOutCount);
     with frmRptInOutCount do
     begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text + ('    تا تاريخ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ: ' )+ txtToDate.Text
      else
        lblFromToDate.Caption := '';

      if (txtFromTime.Text <> '') and (txtToTime.Text <> '') then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text + ('    تا ساعت: ' )+ txtToTime.Text
      else if txtFromTime.Text <> '' then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text
      else if txtToTime.Text <> '' then
        lblFromToTime.Caption := ('تا ساعت: ' )+ txtToTime.Text
      else
        lblFromToTime.Caption := '';
      with qryMachines do
      begin
        Close;
        with SQL do
        begin
          if cmbEntranceDepartmentCode.ItemIndex = -1 then
          begin
            lblDepartName.Caption := '';
            //EntranceDepart := IntToStr(g_Options.Department)
          end
          else
          begin
            EntranceDepart := cmbEntranceDepartmentCode.Text;
            qry := TAdoQuery.Create(Application);
            qry.connection := frmDBS.adoConnect;
            qry.SQL.Clear;
            qry.SQL.Add('SELECT  Depart_Code, Depart_Name ');
            qry.SQL.Add('From Department ');
            qry.SQL.Add('WHERE Depart_Code = ' + EntranceDepart);
            qry.Open;
            lblDepartName.Caption := qry.FieldByName('Depart_Name').AsString;
            qry.Close;
            qry.Free;
          end;
          Clear;
//          if rdoBoth.Checked then
//           begin
            stSql1 := '';
            stSql2 := '';
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              stSql1 := ' AND (M_IDate > ''' + txtFromDate.Text + ''' ';
              stSql1 := stSql1 + ' OR (M_IDate = ''' + txtFromDate.Text + ''' ';
              stSql1 := stSql1 + ' AND M_ITime >= ''' + txtFromTime.Text + ''' )) ';
              stSql1 := stSql1 + ' AND (M_IDate < ''' + txtToDate.Text + ''' ';
              stSql1 := stSql1 + ' OR (M_IDate = ''' + txtToDate.Text + ''' ';
              stSql1 := stSql1 + ' AND M_ITime <= ''' + txtToTime.Text + ''' )) ';

              stSql2 := ' AND (M_ODate > ''' + txtFromDate.Text + ''' ';
              stSql2 := stSql2 + ' OR (M_ODate = ''' + txtFromDate.Text + ''' ';
              stSql2 := stSql2 + ' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ';
              stSql2 := stSql2 + ' AND (M_ODate < ''' + txtToDate.Text + ''' ';
              stSql2 := stSql2 + ' OR (M_ODate = ''' + txtToDate.Text + ''' ';
              stSql2 := stSql2 + ' AND M_OTime <= ''' + txtToTime.Text + ''' )) ';
            end
            else
            begin
              if txtFromDate.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_IDate >= ''' + txtFromDate.Text + ''' ';
                stSql2 := stSql2 + ' AND M_ODate >= ''' + txtFromDate.Text + ''' ';
               end;
              if txtFromTime.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_ITime >= ''' + txtFromTime.Text + ''' ';
                stSql2 := stSql2 + ' AND M_OTime >= ''' + txtFromTime.Text + ''' ';
               end;
              if txtToDate.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_IDate <= ''' + txtToDate.Text + ''' ';
                stSql2 := stSql2 + ' AND M_ODate <= ''' + txtToDate.Text + ''' ';
               end;
              if txtToTime.Text <> '' then
               begin
                stSql1 := stSql1 + ' AND M_ITime <= ''' + txtToTime.Text + ''' ';
                stSql2 := stSql2 + ' AND M_OTime <= ''' + txtToTime.Text + ''' ';
               end;
            end;

            Add('SELECT M_Number, M_Serial, IStatus, COUNT(M_Number) cou FROM( ');

            Add('SELECT M_Number, M_Serial,'{ M_Status,}+' M_Barcode, M_rdrCode, M_OperatorCode, ');
            Add('case ');
            Add('when M_Status between 21 and 24 then ''عادی'' ');
            Add('when M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');

            Add('FROM InputCar ' );
            Add('WHERE InputCar.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql1 + ' ');
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND InputCar.M_EntranceDepart = ' + EntranceDepart + ' ');
            Add('UNION all ');
            Add('SELECT M_Number, M_Serial,'{ M_Status,}+' M_Barcode, M_rdrCode, M_OperatorCode, ');
            Add('case ');
            Add('when M_Status between 21 and 24 then ''عادی'' ');
            Add('when M_Status between 61 and 64 then ''مشترک'' ');
            Add('end ');
            Add('as IStatus ');
            Add('FROM Machines ' );
            Add('WHERE Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' ' + stSql2 + ' ' );
            if cmbEntranceDepartmentCode.ItemIndex > -1 then
              Add('AND Machines.M_EntranceDepart = ' + EntranceDepart + ' ' );
            Add(') l1 ');

            if cmbBarCode.Text <> '' then
              Add('Where M_Barcode = ''' + cmbBarCode.Text + ''' ')
            else
              Add('Where (M_Barcode <> '''' OR M_Barcode = '''') ' );

            if txtNumber.Text <> '' then
              Add(' AND M_Number = ''' + txtNumber.Text + ''' ');

{           if cmbCity.Text <> '' then
              Add(' AND M_CityName = ''' + cmbCity.Text + ''' ');}

            if txtSerial.Text <> '' then
              Add(' AND M_Serial = ''' + txtSerial.Text + ''' ');

            if rdoDoorAndOr.ItemIndex = 0 then
            begin
              if cmbIDoor.Text <> '' then
                Add(' AND M_rdrCode = ' + cmbIDoor.Text);
              if cmbODoor.Text <> '' then
                Add(' AND M_rdrCode = ' + cmbODoor.Text);
            end
            else
            begin
              if cmbIDoor.Text <> '' then
              begin
                Add(' AND (M_rdrCode = ' + cmbIDoor.Text);
                if cmbODoor.Text <> '' then
                  Add(' OR M_rdrCode = ' + cmbODoor.Text);
                Add(' ) ');
              end
              else
              begin
                if cmbODoor.Text <> '' then
                  Add(' AND M_rdrCode = ' + cmbODoor.Text);
              end;
            end;

            if rdoPersonAndOr.ItemIndex = 0 then
            begin
              if cmbIPerson.Text <> '' then
                Add(' AND M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
              if cmbOPerson.Text <> '' then
                Add(' AND M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
            end
            else
            begin
              if cmbIPerson.Text <> '' then
              begin
                Add(' AND (M_OperatorCode = ''' + cmbIPerson.Text + ''' ');
                if cmbOPerson.Text <> '' then
                  Add(' OR M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
                Add(' ) ');
              end
              else
              begin
                if cmbOPerson.Text <> '' then
                  Add(' AND M_OperatorCode = ''' + cmbOPerson.Text + ''' ');
              end;
            end;

            Add('GROUP BY M_Number, M_Serial, IStatus ');
{            case rdoSort.ItemIndex of
//kaveh            0: Add('ORDER BY M_IDate, M_ITime, M_IDoor, M_BarCode');
              0: Add('ORDER BY cou DESC, M_IDate ASC, M_ITime ASC, M_Number ASC, M_BarCode ASC');
              1: Add('ORDER BY cou DESC, M_ODate ASC, M_OTime ASC, M_Number ASC, M_BarCode ASC');
              2: Add('ORDER BY cou DESC, M_BarCode ASC, M_IDate ASC, M_ITime ASC, M_Number ASC');
              3: Add('ORDER BY cou DESC, M_Number ASC, M_IDate ASC, M_ITime ASC, M_BarCode ASC');
              4: Add('ORDER BY cou DESC, M_Serial ASC, M_IDate ASC, M_ITime ASC, M_BarCode ASC, M_Number ASC');
            end; }
            Add('ORDER BY cou DESC, M_Number ASC ');

        end;
        test := SQL.Text;
        Open;
        if RecordCount > 0 then
        begin
          while Ord(qrptMachines.Page.PaperSize) > 7 do
            qrptMachines.Page.PaperSize := Pred(qrptMachines.Page.PaperSize);

          if rdoPaper.ItemIndex <> 0 then
          begin
            qrptMachines.Page.Orientation := poPortrait;
            while Ord(qrptMachines.Page.PaperSize) <> 8 do
              qrptMachines.Page.PaperSize := Succ(qrptMachines.Page.PaperSize);
          end
          else
          begin
            qrptMachines.Page.Orientation := poLandscape;
            while Ord(qrptMachines.Page.PaperSize) <> 9 do
              qrptMachines.Page.PaperSize := Succ(qrptMachines.Page.PaperSize);
          end;

          if rdoScreen.Checked then
            qrptMachines.Preview
          else
            qrptMachines.Print;
        end
        else
        begin
          if rdoBoth.Checked then
            InformationMessage('ورود و خروجي وجود ندارد.')
          else if rdoArival.Checked then
            InformationMessage('هنوز خودرويي وارد نشده است.')
          else if rdoExit.Checked then
            InformationMessage('هنوز خودرويي خارج نشده است.')
          else
            InformationMessage('خودرویی در پارکینگ توقف نکرده است.');
        end;
        Close;
      end;
      Free;
     end;

    end;

    DelRecFromMachine;
    if g_options.RdrOff_Rpt = MB_TRUE then
      UserControl := False;
  end;
end;

end.
