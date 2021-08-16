unit SrvDepRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,DosMove;

type
  TfrmDepartServiceRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    DosMove1: TDosMove;
    chkDate: TCheckBox;
    cmbServices: TComboBox;
    lbl3: TLabel;
    btnServiceSel: TBitBtn;
    lbl4: TLabel;
    cmbDepartment: TComboBox;
    btnDepartment: TBitBtn;
    lbl5: TLabel;
    txtDescribe: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbServicesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnServiceSelClick(Sender: TObject);
    procedure btnDepartmentClick(Sender: TObject);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    srvcSelected,
    departSelected : String;

    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmDepartServiceRpt : TfrmDepartServiceRpt;


implementation

uses
  Funcs, ComTools, Globals, Keyboard, DateProc, MSGs, DBS,
  RpSvcUs1, Select, FntSel;

{$R *.DFM}

procedure TfrmDepartServiceRpt.SetWinF;
begin
  SetFontColor(TForm(frmDepartServiceRpt));
  
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  btnServiceSel.Caption := (btnServiceSel.Caption);
  lbl4.Caption := (lbl4.Caption);
  btnDepartment.Caption := (btnDepartment.Caption);
  lbl5.Caption := (lbl5.Caption);
  chkDate.Caption := (chkDate.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmDepartServiceRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  Application.CreateForm(TfrmSelect, frmSelect);
  txtFromDate.Text := gOptions.fromDate;
  txtToDate.Text := gOptions.toDate;
  srvcSelected := '';
  departSelected := '';

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Services');
    Open;
    while not Eof do
    begin
      cmbServices.Items.Add(FieldByName('S_Code').AsString + '-' + FieldByName('S_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' + FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TfrmDepartServiceRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDepartServiceRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmDepartServiceRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmDepartServiceRpt.cmbServicesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbServices.ItemIndex := -1;
  end;
end;

procedure TfrmDepartServiceRpt.cmbDepartmentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbDepartment.ItemIndex := -1;
  end;
end;

procedure TfrmDepartServiceRpt.cmdPrintClick(Sender: TObject);
var qrptUsedSrvc1 : TqrptUsedSrvc1;
begin
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
    txtToDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «» œ« «“  «—ÌŒ «‰ Â« »“—ê — «” .');
    txtToDate.SetFocus;
  end
  else
  begin
    gOptions.fromDate := txtFromDate.Text;
    gOptions.toDate := txtToDate.Text;

    Application.CreateForm(TqrptUsedSrvc1, qrptUsedSrvc1);
    try
      with qrptUsedSrvc1 do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        SetWinF_Rpt;
        lblCoName.Caption := gOptions.CoName;
        if gOptions.Shobeh <> '' then
          lblCoName.Caption := lblCoName.Caption + gOptions.Shobeh;
        lblDate.Caption := CurrentDate;
        bndDescribe.Enabled := (txtDescribe.Text <> '');
        lblDescribe.Caption := txtDescribe.Text;

        lblName.Caption := Self.Caption;

        if chkSign.Checked then
        begin
          lblReptSign1.Caption := gParams.rptSign1;
          lblReptSign2.Caption := gParams.rptSign2;
          lblReptSign3.Caption := gParams.rptSign3;
          lblReptSign4.Caption := gParams.rptSign4;
          lblReptSign5.Caption := gParams.rptSign5;
        end
        else
          bndSign.Enabled := False;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        aqryReceipt.Connection := frmDBS.adoConnect;
        aqryReceipt.SQL.Clear;
        if chkDate.Checked then
        begin
          aqryReceipt.SQL.Add('SELECT SUM(Recit2_SrvcNo) AS srvcNo, S_Name, Recit2_Date, Recit2_Srvc, Recit2_Price');
          aqryReceipt.SQL.Add('FROM Receipt1, Receipt2, Services, Employee');
          aqryReceipt.SQL.Add('WHERE Recit2_Srvc = S_Code');
          aqryReceipt.SQL.Add('AND Recit1_Date = Recit2_Date AND Recit1_No = Recit2_No AND Recit1_EmplNo = Recit2_EmplNo AND Recit1_Department = Recit2_Department');
          aqryReceipt.SQL.Add('AND Recit1_EmplNo = Empl_No');

          if gParams.department <> 0 then
            aqryReceipt.SQL.Add('AND Recit2_Department = ' + IntToStr(gParams.department));

          if txtFromDate.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Date <= ''' + txtToDate.Text + '''');

          if cmbServices.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Srvc = ' + Copy(cmbServices.Text, 1, Pos('-', cmbServices.Text)-1))
          else if srvcSelected <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Srvc IN (' + srvcSelected + ')');

          if cmbDepartment.Text <> '' then
            aqryReceipt.SQL.Add('AND Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
          else if departSelected <> '' then
            aqryReceipt.SQL.Add('AND Empl_Department IN (' + departSelected + ')')
          else
            aqryReceipt.SQL.Add('AND Empl_Department <> ' + IntToStr(gParams.department));

          aqryReceipt.SQL.Add('GROUP BY Recit2_Date, S_Name, Recit2_Srvc, Recit2_Price');
          aqryReceipt.SQL.Add('ORDER BY Recit2_Date, S_Name, Recit2_Srvc, Recit2_Price');
        end
        else
        begin
          aqryReceipt.SQL.Add('SELECT SUM(Recit2_SrvcNo) AS srvcNo, S_Name, Recit2_Srvc, Recit2_Price');
          aqryReceipt.SQL.Add('FROM Receipt1, Receipt2, Services, Employee');
          aqryReceipt.SQL.Add('WHERE Recit2_Srvc = S_Code');
          aqryReceipt.SQL.Add('AND Recit1_Date = Recit2_Date AND Recit1_No = Recit2_No AND Recit1_EmplNo = Recit2_EmplNo AND Recit1_Department = Recit2_Department');
          aqryReceipt.SQL.Add('AND Recit1_EmplNo = Empl_No');

          if gParams.department <> 0 then
            aqryReceipt.SQL.Add('AND Recit2_Department = ' + IntToStr(gParams.department));

          if txtFromDate.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Date <= ''' + txtToDate.Text + '''');

          if cmbServices.Text <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Srvc = ' + Copy(cmbServices.Text, 1, Pos('-', cmbServices.Text)-1))
          else if srvcSelected <> '' then
            aqryReceipt.SQL.Add('AND Recit2_Srvc IN (' + srvcSelected + ')');

          if cmbDepartment.Text <> '' then
            aqryReceipt.SQL.Add('AND Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
          else if departSelected <> '' then
            aqryReceipt.SQL.Add('AND Empl_Department IN (' + departSelected + ')')
          else
            aqryReceipt.SQL.Add('AND Empl_Department <> ' + IntToStr(gParams.department));

          aqryReceipt.SQL.Add('GROUP BY S_Name, Recit2_Srvc, Recit2_Price');
          aqryReceipt.SQL.Add('ORDER BY S_Name, Recit2_Srvc, Recit2_Price');
          lbl6.Enabled := False;
          lblFoodDate.Enabled := False;
          shp1.Enabled := False;
          shp2.Enabled := False;
        end;
        aqryReceipt.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if aqryReceipt.RecordCount > 0 then
        begin
          if rdoScreen.Checked then Preview
          else                      Print;
        end
        else
          InformationMessage('ÂÌç Œœ„« Ì «—«∆Â ‰‘œÂ «” .');
        aqryReceipt.Close;
      end;
    finally
      qrptUsedSrvc1.Free;
    end;
  end;
end;

procedure TfrmDepartServiceRpt.btnServiceSelClick(Sender: TObject);
begin
  if cmbServices.Items.Count > 0 then
  begin
    frmSelect.selType := SEL_SRVC;
    if frmSelect.ShowModal = mrOK then
      srvcSelected := frmSelect.dataSelected
    else
      srvcSelected := '';
  end;
end;

procedure TfrmDepartServiceRpt.btnDepartmentClick(Sender: TObject);
begin
  if cmbDepartment.Items.Count > 0 then
  begin
    frmSelect.selType := SEL_DEPRT;
    if frmSelect.ShowModal = mrOK then
      departSelected := frmSelect.dataSelected
    else
      departSelected := '';
  end;
end;

procedure TfrmDepartServiceRpt.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

end.
