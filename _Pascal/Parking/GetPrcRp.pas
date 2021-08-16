unit GetPrcRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, FarsiApi,
  MSGs, RpPrcK, RpPrcT, DBS, RunCmnds, DosMove, ExtCtrls, Mask;

type
  TfrmGetPriceRpt = class(TForm)
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl3: TLabel;
    txtToDate: TEdit;
    lbl5: TLabel;
    cmbDoorCode: TComboBox;
    cmbDoorName: TComboBox;
    grpReportType: TGroupBox;
    rdoAll: TRadioButton;
    rdoTafsili: TRadioButton;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    lbl2: TLabel;
    lbl4: TLabel;
    txtFromTime: TEdit;
    txtToTime: TEdit;
    lbl6: TLabel;
    cmbPersonCode: TComboBox;
    cmbPersonName: TComboBox;
    grpTafkik: TGroupBox;
    rdoDoor: TRadioButton;
    rdoPerson: TRadioButton;
    rdoNone: TRadioButton;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    Label1: TLabel;
    cmbTypeCode: TComboBox;
    cmbTypeName: TComboBox;
    rdoType: TRadioButton;
    Label5: TLabel;
    txtNumber: TEdit;
    Label7: TLabel;
    txtSerial: TEdit;
    Label2: TLabel;
    txtFromPrice: TEdit;
    txtToPrice: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    cmdCancelFilter: TBitBtn;
    txtmskFromStay: TMaskEdit;
    txtmskToStay: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbDoorCodeClick(Sender: TObject);
    procedure cmbDoorNameClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtToTimeExit(Sender: TObject);
    procedure cmbPersonCodeClick(Sender: TObject);
    procedure cmbPersonNameClick(Sender: TObject);
    procedure cmbTypeCodeClick(Sender: TObject);
    procedure cmbTypeNameClick(Sender: TObject);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmdCancelFilterClick(Sender: TObject);
    procedure txtFromPriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtToPriceKeyPress(Sender: TObject; var Key: Char);
    procedure grpPrintTypeClick(Sender: TObject);
    procedure grpReportTypeClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmGetPriceRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  grpReportType.Caption := (grpReportType.Caption);
  rdoAll.Caption := (rdoAll.Caption);
  rdoTafsili.Caption := (rdoTafsili.Caption);
  grpTafkik.Caption := (grpTafkik.Caption);
  rdoPerson.Caption := (rdoPerson.Caption);
  rdoDoor.Caption := (rdoDoor.Caption);
  rdoNone.Caption := (rdoNone.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Caption := (rdoSort.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmGetPriceRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
  SetDirectionFarsi(cmbDoorName.Handle);
  SetDirectionFarsi(cmbPersonName.Handle);
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers'); //kaveh  WHERE R_Kind IN (' + IntToStr(MB_OUT) + ', ' + IntToStr(MB_INOUT) + ')');
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

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM NewCarTypes');
  qry.Open;
  while not qry.EOF do
  begin
    cmbTypeCode.Items.Add(qry.FieldByName('Type_Code').AsString);
    cmbTypeName.Items.Add(qry.FieldByName('Type_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;

  if rdoAll.Checked then
  begin
    Label4.Enabled := False;
    Label6.Enabled := False;
    txtmskFromStay.Enabled := False;
    txtmskToStay.Enabled := False;
    rdoSort.Enabled := False;
  end
  else if rdoTafsili.Checked then
  begin
    Label4.Enabled := False;
    Label6.Enabled := False;
    txtmskFromStay.Enabled := False;
    txtmskToStay.Enabled := False;
    rdoSort.Enabled := True;
  end;

end;

procedure TfrmGetPriceRpt.grpPrintTypeClick(Sender: TObject);
begin
  if rdoScreen.Checked then
    cmdPrint.Hint := 'پيش نمايش گزارش'
  else if rdoPrinter.Checked then
    cmdPrint.Hint := 'چاپ گزارش';
end;

procedure TfrmGetPriceRpt.grpReportTypeClick(Sender: TObject);
begin
  if rdoAll.Checked then
  begin
    Label4.Enabled := False;
    Label6.Enabled := False;
    txtmskFromStay.Enabled := False;
    txtmskToStay.Enabled := False;
    rdoSort.Enabled := False;
  end
  else if rdoTafsili.Checked then
  begin
    Label4.Enabled := False;
    Label6.Enabled := False;
    txtmskFromStay.Enabled := False;
    txtmskToStay.Enabled := False;
    rdoSort.Enabled := True;
  end;
  
end;

procedure TfrmGetPriceRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmGetPriceRpt.txtFromPriceKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmGetPriceRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmGetPriceRpt.txtToDateExit(Sender: TObject);
begin
  if txtTodate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmGetPriceRpt.txtToPriceKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmGetPriceRpt.txtFromTimeExit(Sender: TObject);
begin
  txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmGetPriceRpt.txtFromTimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmGetPriceRpt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmGetPriceRpt.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmGetPriceRpt.txtToTimeExit(Sender: TObject);
begin
  txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmGetPriceRpt.cmbDoorCodeClick(Sender: TObject);
begin
  cmbDoorName.ItemIndex := cmbDoorCode.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmbDoorNameClick(Sender: TObject);
begin
  cmbDoorCode.ItemIndex := cmbDoorName.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmbTypeCodeClick(Sender: TObject);
begin
  cmbTypeName.ItemIndex := cmbTypeCode.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmbTypeNameClick(Sender: TObject);
begin
  cmbTypeCode.ItemIndex := cmbTypeName.ItemIndex;
end;

procedure TfrmGetPriceRpt.cmdCancelFilterClick(Sender: TObject);
begin
  rdoPrinter.Enabled := g_options.AcesPrint;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
  txtFromTime.Text := '';
  txtToTime.Text := '';
  cmbDoorCode.ItemIndex := -1;
  cmbDoorName.ItemIndex := -1;
  cmbPersonCode.ItemIndex := -1;
  cmbPersonName.ItemIndex := -1;
  cmbTypeCode.ItemIndex := -1;
  cmbTypeName.ItemIndex := -1;
  txtNumber.Text := '';
  txtSerial.Text := '';
  txtFromPrice.Text := '';
  txtToPrice.Text := '';
  txtmskFromStay.Text := '';
  txtmskToStay.Text := '';
  rdoAll.Checked := True;
  rdoSort.ItemIndex := 0;
  rdoPerson.Checked := True;
  rdoScreen.Checked := True;

end;

procedure TfrmGetPriceRpt.cmdPrintClick(Sender: TObject);
var
  frmRptGetPriceK : TfrmRptGetPriceK;
  frmRptGetPriceT : TfrmRptGetPriceT;
  txtFromStay, txtToStay : string;
  testst : string;
begin
  if txtmskFromStay.Text = '(   -  -  )' then
    txtFromStay := ''
  else
    txtFromStay := txtmskFromStay.Text;
  if txtmskToStay.Text = '(   -  -  )' then
    txtToStay := ''
  else
    txtToStay := txtmskToStay.Text;

  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  AddRecToMachine;
  if rdoAll.Checked then
  begin
    Application.CreateForm(TfrmRptGetPriceK, frmRptGetPriceK);
    with frmRptGetPriceK do
    begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text + ('    تا تاريخ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ: ') + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ: ') + txtToDate.Text
      else
        lblFromToDate.Caption := '';

      if (txtFromTime.Text <> '') and (txtToTime.Text <> '') then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text + '    تا ساعت: ' + txtToTime.Text
      else if txtFromTime.Text <> '' then
        lblFromToTime.Caption := ('از ساعت: ' )+ txtFromTime.Text
      else if txtToTime.Text <> '' then
        lblFromToTime.Caption := ('تا ساعت: ' )+ txtToTime.Text
      else
        lblFromToTime.Caption := '';

      if (txtFromPrice.Text <> '') and (txtToPrice.Text <> '') then
        lblFromToPrice.Caption := ('از مبلغ: ' )+ txtFromPrice.Text + '    تا مبلغ: ' + txtToPrice.Text + ('  ریال')
      else if txtFromPrice.Text <> '' then
        lblFromToPrice.Caption := ('از مبلغ: ' )+ txtFromPrice.Text + ('  ریال')
      else if txtToPrice.Text <> '' then
        lblFromToPrice.Caption := ('تا مبلغ: ' )+ txtToPrice.Text + ('  ریال')
      else
        lblFromToPrice.Caption := '';

      if (txtFromStay <> '') and (txtToStay <> '') then
        lblFromToStay.Caption := ('مدت توقف از: ' )+ txtFromStay + '    تا: ' + txtToStay
      else if txtFromStay <> '' then
        lblFromToStay.Caption := ('مدت توقف از: ' )+ txtFromStay
      else if txtToStay <> '' then
        lblFromToStay.Caption := ('مدت توقف تا: ' )+ txtToStay
      else
        lblFromToStay.Caption := '';

      if (txtNumber.Text <> '') and (txtSerial.Text <> '') then
        lblNumberSerial.Caption := 'شماره خودرو: ' + txtNumber.Text + '   سريال: ' + txtSerial.Text
      else if txtNumber.Text <> '' then
        lblNumberSerial.Caption := 'شماره خودرو: ' + txtNumber.Text
      else if txtSerial.Text <> '' then
        lblNumberSerial.Caption := 'سريال پلاک: ' + txtSerial.Text
      else
        lblNumberSerial.Caption := '';

      qryPrc.SQL.Clear;

      if rdoPerson.Checked then
      begin
        grp.Expression := 'qryPrc.M_OperatorCode';
        lblGroup.Caption := (':متصدي خروج');
        txtCode.DataField := 'M_OperatorCode';
        txtName.DataField := 'P_Name';
//kaveh 871215        qryPrc.SQL.Add('SELECT M_OPerson, M_Payable, P_Name FROM Machines, Persons');
//kaveh 871215        qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_OPerson = P_BarCode');
        qryPrc.SQL.Add('SELECT     M_PayAble, M_OperatorCode, P_Name ');
        qryPrc.SQL.Add('FROM         Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON M_OperatorCode = P_BarCode ');

        qryPrc.SQL.Add(' where Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status = 23) OR (M_Status = 24)) ');
        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime <= ''' + txtToTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode = ' + cmbDoorCode.Text);
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Serial = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble <= ' + txtToPrice.Text);

        qryPrc.SQL.Add(' ORDER BY M_OperatorCode');
      end

      else if rdoDoor.Checked then
      begin
        grp.Expression := 'qryPrc.M_rdrCode';
        lblGroup.Caption := (':درب خروج');
        txtCode.DataField := 'M_rdrCode';
        txtName.DataField := 'R_Name';
//kaveh871217        qryPrc.SQL.Add('SELECT M_ODoor, M_Payable, R_Name FROM Machines, Readers');
//kaveh871217        qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_ODoor = R_Code');
        qryPrc.SQL.Add('SELECT     M_PayAble, M_rdrCode, R_Name ');
        qryPrc.SQL.Add('FROM         Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON M_rdrCode = R_Code ');

        qryPrc.SQL.Add(' where Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status = 23) OR (M_Status = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode = ' + cmbDoorCode.Text);
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Serial = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble <= ' + txtToPrice.Text);

        qryPrc.SQL.Add(' ORDER BY M_rdrCode ');
      end

//kaveh is
      else if rdoType.Checked then
      begin
        grp.Expression := 'qryPrc.M_PlaqueAppliance';
        lblGroup.Caption := (':نوع خودرو');
        txtCode.DataField := 'M_PlaqueAppliance';
        txtName.DataField := 'Type_Name';
        qryPrc.SQL.Add('SELECT     M_PayAble, M_PlaqueAppliance, Type_Name ');
        qryPrc.SQL.Add('FROM         Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('NewCarTypes ON M_PlaqueAppliance = Type_Code ');

        qryPrc.SQL.Add(' where Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status = 23) OR (M_Status = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode = ' + cmbDoorCode.Text);
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Serial = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble <= ' + txtToPrice.Text);
          
        qryPrc.SQL.Add(' ORDER BY M_PlaqueAppliance ');
      end
//kaveh ie

      else if rdoNone.Checked then
      begin
        grp.Enabled := False;
        bnd.Enabled := False;
        qryPrc.SQL.Add('SELECT M_Payable FROM Machines WHERE M_IsDeleted <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status = 23) OR (M_Status = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode = ' + cmbDoorCode.Text);
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Serial = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble <= ' + txtToPrice.Text);
          
      end;
      testst := qryPrc.SQL.Text;
      qryPrc.Open;
      if qryPrc.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptPrc.Preview
        else if rdoPrinter.Checked then
          qrptPrc.Print;
      end
      else
        ErrorMessage('درآمدي حاصل نشده است.');
      qryPrc.Close;
      Free;
    end;
  end

  else if rdoTafsili.Checked then
  begin
    Application.CreateForm(TfrmRptGetPriceT, frmRptGetPriceT);
    with frmRptGetPriceT do
    begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text +( '    تا تاريخ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ: ' )+ txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ( 'تا تاريخ: ')+ txtToDate.Text
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

      if (txtFromPrice.Text <> '') and (txtToPrice.Text <> '') then
        lblFromToPrice.Caption := ('از مبلغ: ' )+ txtFromPrice.Text + '    تا مبلغ: ' + txtToPrice.Text + ('  ریال')
      else if txtFromPrice.Text <> '' then
        lblFromToPrice.Caption := ('از مبلغ: ' )+ txtFromPrice.Text + ('  ریال')
      else if txtToPrice.Text <> '' then
        lblFromToPrice.Caption := ('تا مبلغ: ' )+ txtToPrice.Text + ('  ریال')
      else
        lblFromToPrice.Caption := '';

      if (txtFromStay <> '') and (txtToStay <> '') then
        lblFromToStay.Caption := ('مدت توقف از: ' )+ txtFromStay + '    تا: ' + txtToStay
      else if txtFromStay <> '' then
        lblFromToStay.Caption := ('مدت توقف از: ' )+ txtFromStay
      else if txtToStay <> '' then
        lblFromToStay.Caption := ('مدت توقف تا: ' )+ txtToStay
      else
        lblFromToStay.Caption := '';

      if (txtNumber.Text <> '') and (txtSerial.Text <> '') then
        lblNumberSerial.Caption := 'شماره خودرو: ' + txtNumber.Text + '   سريال: ' + txtSerial.Text
      else if txtNumber.Text <> '' then
        lblNumberSerial.Caption := 'شماره خودرو: ' + txtNumber.Text
      else if txtSerial.Text <> '' then
        lblNumberSerial.Caption := 'سريال پلاک: ' + txtSerial.Text
      else
        lblNumberSerial.Caption := '';
        
      qryPrc.SQL.Clear;

      if rdoPerson.Checked then
      begin
        bndClmn.Enabled := False;
//kaveh 871217        grp.Expression := 'qryPrc.M_OperatorCode';
//kaveh 871217         lblGroup.Caption := (':متصدي خروج');
//kaveh 871217         txtCode.DataField := 'M_OperatorCode';
//kaveh 871217         txtName.DataField := 'P_Name';
//kaveh 871217         qryPrc.SQL.Add('SELECT * FROM Machines, Persons, Readers ');
//kaveh 871217         qryPrc.SQL.Add(' WHERE Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND Machines.M_OperatorCode = Persons.P_BarCode AND Machines.M_rdrCode = Readers.R_Code');
        grp.Expression := 'qryPrc.M_OperatorCode_M';
        lblGroup.Caption := (':متصدي خروج');
        txtCode.DataField := 'M_OperatorCode_M';
        txtName.DataField := 'P_Name_M';
//        qryPrc.SQL.Add('SELECT     dbo.Machines.*, dbo.Persons.*, dbo.Readers.* ');
//        qryPrc.SQL.Add('FROM         dbo.Machines LEFT OUTER JOIN ');
//        qryPrc.SQL.Add('dbo.Readers ON dbo.Machines.M_rdrCode = dbo.Readers.R_Code LEFT OUTER JOIN ');
//        qryPrc.SQL.Add('dbo.Persons ON dbo.Machines.M_OperatorCode = dbo.Persons.P_BarCode ');
//        qryPrc.SQL.Add(' where Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add('SELECT *, Readers.R_Code AS R_Code_I, Readers.R_Name AS R_Name_I, Persons.P_BarCode AS P_BarCode_I, ');
        qryPrc.SQL.Add('Persons.P_Name AS P_Name_I ');
        qryPrc.SQL.Add('FROM (SELECT Machines.M_rdrCode AS M_rdrCode_M, Machines.M_BarCode AS M_BarCode_M, Machines.M_Number AS M_Number_M, ');
        qryPrc.SQL.Add('Machines.M_Serial AS M_Seria_M, Machines.M_PlaqueAppliance AS M_PlaqueAppliance_M, ');
        qryPrc.SQL.Add('Machines.M_IDate AS M_IDate_M, Machines.M_ITime AS M_ITime_M, Machines.M_ODate AS M_ODate_M, ');
        qryPrc.SQL.Add('Machines.M_OTime AS M_OTime_M, Machines.M_OperatorCode AS M_OperatorCode_M, Machines.M_Status AS M_Status_M,'); //XXX
        qryPrc.SQL.Add('Machines.M_PayAble AS M_PayAble_M, Machines.M_IsDeleted AS M_IsDeleted_M, InputCar.M_rdrCode AS M_rdrCode_I, ');
        qryPrc.SQL.Add('InputCar.M_OperatorCode AS M_OperatorCode_I, Readers.R_Code AS R_Code_M, Readers.R_Name AS R_Name_M, ');
        qryPrc.SQL.Add('Persons.P_BarCode AS P_BarCode_M, Persons.P_Name AS P_Name_M, NewCarTypes.Type_Code AS Type_Code_M, ');
        qryPrc.SQL.Add('NewCarTypes.Type_Name AS Type_Name_M ');
        qryPrc.SQL.Add('FROM Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('InputCar ON Machines.M_BarCode = InputCar.M_BarCode AND Machines.M_Number = InputCar.M_Number AND ');
        qryPrc.SQL.Add('Machines.M_Serial = InputCar.M_Serial AND Machines.M_IDate = InputCar.M_IDate AND ');
        qryPrc.SQL.Add('Machines.M_ITime = InputCar.M_ITime LEFT OUTER JOIN ');
        qryPrc.SQL.Add('NewCarTypes ON Machines.M_PlaqueAppliance = NewCarTypes.Type_Code LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON Machines.M_OperatorCode = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON Machines.M_rdrCode = Readers.R_Code) l1 LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON l1.M_OperatorCode_I = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON l1.M_rdrCode_I = Readers.R_Code ');
        qryPrc.SQL.Add('WHERE M_IsDeleted_M <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status_M = 23) OR (M_Status_M = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate_M > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate_M < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M <= ''' + txtToDate.Text + '''  ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + '''');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode_M = ' + cmbDoorCode.Text + ' ');
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode_M = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance_M = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number_M = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Seria_M = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M <= ' + txtToPrice.Text);

{
????
    lblTimes.Caption := FormatTimes(Differ(FieldByname('M_IDate_M').AsString,
                                           FieldByname('M_ITime_M').AsString,
                                           FieldByname('M_ODate_M').AsString,
                                           FieldByname('M_OTime_M').AsString));


        if txtFromStay <> '' then
          qryPrc.SQL.Add(' AND M_PayAble >= ''' + txtFromStay + '''');
        if txtToStay <> '' then
          qryPrc.SQL.Add(' AND M_PayAble <= ''' + txtToStay + '''');

????
}

        qryPrc.SQL.Add(' ORDER BY M_OperatorCode_M ');
        if rdoSort.ItemIndex = 0 then
          qryPrc.SQL.Add(' , M_IDate_M, M_ITime_M ')
        else
          qryPrc.SQL.Add(' , M_ODate_M, M_OTime_M ');
      end

      else if rdoDoor.Checked then
      begin
        bndClmn.Enabled := False;
        grp.Expression := 'qryPrc.M_rdrCode_M';
        lblGroup.Caption := (':درب خروج');
        txtCode.DataField := 'M_rdrCode_M';
        txtName.DataField := 'R_Name_M';
//        qryPrc.SQL.Add('SELECT * FROM Machines, Persons, Readers');
//        qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_OPerson = P_BarCode AND M_ODoor = R_Code');
        qryPrc.SQL.Add('SELECT *, Readers.R_Code AS R_Code_I, Readers.R_Name AS R_Name_I, Persons.P_BarCode AS P_BarCode_I, ');
        qryPrc.SQL.Add('Persons.P_Name AS P_Name_I ');
        qryPrc.SQL.Add('FROM (SELECT Machines.M_rdrCode AS M_rdrCode_M, Machines.M_BarCode AS M_BarCode_M, Machines.M_Number AS M_Number_M, ');
        qryPrc.SQL.Add('Machines.M_Serial AS M_Seria_M, Machines.M_PlaqueAppliance AS M_PlaqueAppliance_M, ');
        qryPrc.SQL.Add('Machines.M_IDate AS M_IDate_M, Machines.M_ITime AS M_ITime_M, Machines.M_ODate AS M_ODate_M, ');
        qryPrc.SQL.Add('Machines.M_OTime AS M_OTime_M, Machines.M_OperatorCode AS M_OperatorCode_M, Machines.M_Status AS M_Status_M,'); //XXX
        qryPrc.SQL.Add('Machines.M_PayAble AS M_PayAble_M, Machines.M_IsDeleted AS M_IsDeleted_M, InputCar.M_rdrCode AS M_rdrCode_I, ');
        qryPrc.SQL.Add('InputCar.M_OperatorCode AS M_OperatorCode_I, Readers.R_Code AS R_Code_M, Readers.R_Name AS R_Name_M, ');
        qryPrc.SQL.Add('Persons.P_BarCode AS P_BarCode_M, Persons.P_Name AS P_Name_M, NewCarTypes.Type_Code AS Type_Code_M, ');
        qryPrc.SQL.Add('NewCarTypes.Type_Name AS Type_Name_M ');
        qryPrc.SQL.Add('FROM Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('InputCar ON Machines.M_BarCode = InputCar.M_BarCode AND Machines.M_Number = InputCar.M_Number AND ');
        qryPrc.SQL.Add('Machines.M_Serial = InputCar.M_Serial AND Machines.M_IDate = InputCar.M_IDate AND ');
        qryPrc.SQL.Add('Machines.M_ITime = InputCar.M_ITime LEFT OUTER JOIN ');
        qryPrc.SQL.Add('NewCarTypes ON Machines.M_PlaqueAppliance = NewCarTypes.Type_Code LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON Machines.M_OperatorCode = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON Machines.M_rdrCode = Readers.R_Code) l1 LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON l1.M_OperatorCode_I = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON l1.M_rdrCode_I = Readers.R_Code ');
        qryPrc.SQL.Add('WHERE M_IsDeleted_M <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status_M = 23) OR (M_Status_M = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate_M > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate_M < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode_M = ' + cmbDoorCode.Text + ' ');
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode_M = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance_M = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number_M = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Seria_M = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M <= ' + txtToPrice.Text);

          
        qryPrc.SQL.Add(' ORDER BY M_rdrCode_M');
        if rdoSort.ItemIndex = 0 then
          qryPrc.SQL.Add(' , M_IDate_M, M_ITime_M ')
        else
          qryPrc.SQL.Add(' , M_ODate_M, M_OTime_M ');
      end

//kaveh is
      else if rdoType.Checked then
      begin
        bndClmn.Enabled := False;
        grp.Expression := 'qryPrc.M_PlaqueAppliance_M';
        lblGroup.Caption := (':نوع خودرو');
        txtCode.DataField := 'M_PlaqueAppliance_M';
        txtName.DataField := 'Type_Name_M';
//        qryPrc.SQL.Add('SELECT * FROM Machines, Persons, Readers');
//        qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_OPerson = P_BarCode AND M_ODoor = R_Code');
        qryPrc.SQL.Add('SELECT *, Readers.R_Code AS R_Code_I, Readers.R_Name AS R_Name_I, Persons.P_BarCode AS P_BarCode_I, ');
        qryPrc.SQL.Add('Persons.P_Name AS P_Name_I ');
        qryPrc.SQL.Add('FROM (SELECT Machines.M_rdrCode AS M_rdrCode_M, Machines.M_BarCode AS M_BarCode_M, Machines.M_Number AS M_Number_M, ');
        qryPrc.SQL.Add('Machines.M_Serial AS M_Seria_M, Machines.M_PlaqueAppliance AS M_PlaqueAppliance_M, ');
        qryPrc.SQL.Add('Machines.M_IDate AS M_IDate_M, Machines.M_ITime AS M_ITime_M, Machines.M_ODate AS M_ODate_M, ');
        qryPrc.SQL.Add('Machines.M_OTime AS M_OTime_M, Machines.M_OperatorCode AS M_OperatorCode_M, Machines.M_Status AS M_Status_M,'); //XXX
        qryPrc.SQL.Add('Machines.M_PayAble AS M_PayAble_M, Machines.M_IsDeleted AS M_IsDeleted_M, InputCar.M_rdrCode AS M_rdrCode_I, ');
        qryPrc.SQL.Add('InputCar.M_OperatorCode AS M_OperatorCode_I, Readers.R_Code AS R_Code_M, Readers.R_Name AS R_Name_M, ');
        qryPrc.SQL.Add('Persons.P_BarCode AS P_BarCode_M, Persons.P_Name AS P_Name_M, NewCarTypes.Type_Code AS Type_Code_M, ');
        qryPrc.SQL.Add('NewCarTypes.Type_Name AS Type_Name_M ');
        qryPrc.SQL.Add('FROM Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('InputCar ON Machines.M_BarCode = InputCar.M_BarCode AND Machines.M_Number = InputCar.M_Number AND ');
        qryPrc.SQL.Add('Machines.M_Serial = InputCar.M_Serial AND Machines.M_IDate = InputCar.M_IDate AND ');
        qryPrc.SQL.Add('Machines.M_ITime = InputCar.M_ITime LEFT OUTER JOIN ');
        qryPrc.SQL.Add('NewCarTypes ON Machines.M_PlaqueAppliance = NewCarTypes.Type_Code LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON Machines.M_OperatorCode = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON Machines.M_rdrCode = Readers.R_Code) l1 LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON l1.M_OperatorCode_I = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON l1.M_rdrCode_I = Readers.R_Code ');
        qryPrc.SQL.Add('WHERE M_IsDeleted_M <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status_M = 23) OR (M_Status_M = 24)) ');

        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate_M > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate_M < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode_M = ' + cmbDoorCode.Text + ' ');
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode_M = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance_M = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number_M = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Seria_M = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M <= ' + txtToPrice.Text);
          
        qryPrc.SQL.Add(' ORDER BY M_PlaqueAppliance_M');
        if rdoSort.ItemIndex = 0 then
          qryPrc.SQL.Add(' , M_IDate_M, M_ITime_M ')
        else
          qryPrc.SQL.Add(' , M_ODate_M, M_OTime_M ');
      end
//kaveh ie

      else if rdoNone.Checked then
      begin
        grp.Enabled := False;
        bnd.Enabled := False;
        bndChild.Enabled := False;
//        qryPrc.SQL.Add('SELECT * FROM Machines, Persons, Readers');
//        qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND M_OPerson = P_BarCode AND M_ODoor = R_Code');
        qryPrc.SQL.Add('SELECT *, Readers.R_Code AS R_Code_I, Readers.R_Name AS R_Name_I, Persons.P_BarCode AS P_BarCode_I, ');
        qryPrc.SQL.Add('Persons.P_Name AS P_Name_I ');
        qryPrc.SQL.Add('FROM (SELECT Machines.M_rdrCode AS M_rdrCode_M, Machines.M_BarCode AS M_BarCode_M, Machines.M_Number AS M_Number_M, ');
        qryPrc.SQL.Add('Machines.M_Serial AS M_Seria_M, Machines.M_PlaqueAppliance AS M_PlaqueAppliance_M, ');
        qryPrc.SQL.Add('Machines.M_IDate AS M_IDate_M, Machines.M_ITime AS M_ITime_M, Machines.M_ODate AS M_ODate_M, ');
        qryPrc.SQL.Add('Machines.M_OTime AS M_OTime_M, Machines.M_OperatorCode AS M_OperatorCode_M, Machines.M_Status AS M_Status_M,'); //XXX
        qryPrc.SQL.Add('Machines.M_PayAble AS M_PayAble_M, Machines.M_IsDeleted AS M_IsDeleted_M, InputCar.M_rdrCode AS M_rdrCode_I, ');
        qryPrc.SQL.Add('InputCar.M_OperatorCode AS M_OperatorCode_I, Readers.R_Code AS R_Code_M, Readers.R_Name AS R_Name_M, ');
        qryPrc.SQL.Add('Persons.P_BarCode AS P_BarCode_M, Persons.P_Name AS P_Name_M, NewCarTypes.Type_Code AS Type_Code_M, ');
        qryPrc.SQL.Add('NewCarTypes.Type_Name AS Type_Name_M ');
        qryPrc.SQL.Add('FROM Machines LEFT OUTER JOIN ');
        qryPrc.SQL.Add('InputCar ON Machines.M_BarCode = InputCar.M_BarCode AND Machines.M_Number = InputCar.M_Number AND ');
        qryPrc.SQL.Add('Machines.M_Serial = InputCar.M_Serial AND Machines.M_IDate = InputCar.M_IDate AND ');
        qryPrc.SQL.Add('Machines.M_ITime = InputCar.M_ITime LEFT OUTER JOIN ');
        qryPrc.SQL.Add('NewCarTypes ON Machines.M_PlaqueAppliance = NewCarTypes.Type_Code LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON Machines.M_OperatorCode = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON Machines.M_rdrCode = Readers.R_Code) l1 LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Persons ON l1.M_OperatorCode_I = Persons.P_BarCode LEFT OUTER JOIN ');
        qryPrc.SQL.Add('Readers ON l1.M_rdrCode_I = Readers.R_Code ');
        qryPrc.SQL.Add('WHERE M_IsDeleted_M <> ' + IntToStr(CNST_TRUE));
        qryPrc.SQL.Add(' AND ((M_Status_M = 23) OR (M_Status_M = 24)) ');


        if (txtFromDate.Text <> txtToDate.Text) and
           (txtFromTime.Text <> txtToTime.Text) then
        begin
          qryPrc.SQL.Add(' AND (M_ODate_M > ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtFromDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' )) ');

          qryPrc.SQL.Add(' AND (M_ODate_M < ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' OR (M_ODate_M = ''' + txtToDate.Text + ''' ');
          qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtFromTime.Text + ''' )) ');
        end
        else
        begin
          if txtFromDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M >= ''' + txtFromDate.Text + ''' ');
          if txtToDate.Text <> '' then
            qryPrc.SQL.Add(' AND M_ODate_M <= ''' + txtToDate.Text + ''' ');
          if txtFromTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M >= ''' + txtFromTime.Text + ''' ');
          if txtToTime.Text <> '' then
            qryPrc.SQL.Add(' AND M_OTime_M <= ''' + txtToTime.Text + ''' ');
        end;

        if cmbDoorCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_rdrCode_M = ' + cmbDoorCode.Text + ' ');
        if cmbPersonCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_OperatorCode_M = ''' + cmbPersonCode.Text + ''' ');
        if cmbTypeCode.Text <> '' then
          qryPrc.SQL.Add(' AND M_PlaqueAppliance_M = ''' + cmbTypeCode.Text + ''' ');

        if txtNumber.Text <> '' then
          qryPrc.SQL.Add(' AND M_Number_M = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          qryPrc.SQL.Add(' AND M_Seria_M = ''' + txtSerial.Text + '''');
        if txtFromPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M >= ' + txtFromPrice.Text);
        if txtToPrice.Text <> '' then
          qryPrc.SQL.Add(' AND M_PayAble_M <= ' + txtToPrice.Text);

        if rdoSort.ItemIndex = 0 then
          qryPrc.SQL.Add(' ORDER BY M_IDate_M, M_ITime_M ')
        else
          qryPrc.SQL.Add(' ORDER BY M_ODate_M, M_OTime_M ');
      end;
      testst := qryPrc.SQL.Text;
      qryPrc.Open;
      if qryPrc.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptPrc.Preview
        else if rdoPrinter.Checked then
          qrptPrc.Print;
      end
      else
        ErrorMessage('درآمدي حاصل نشده است.');
      qryPrc.Close;
      Free;
    end;
  end;
  DelRecFromMachine;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;


end.
