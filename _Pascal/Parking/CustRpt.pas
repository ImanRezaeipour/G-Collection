unit CustRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, FarsiApi,
  RpCustM, RpCustCr, RpNewPersons, MSGs, RunCmnds, DosMove;

type
  TfrmCustomsRpt = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtCuFromDate: TEdit;
    txtCuToDate: TEdit;
    Label4: TLabel;
    cmbCustCode: TComboBox;
    cmbCustName: TComboBox;
    grpReportType: TGroupBox;
    rdoMojodi: TRadioButton;
    rdoCircular: TRadioButton;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    DosMove1: TDosMove;
    rdoBaseInfo: TRadioButton;
    Label5: TLabel;
    cmbDepartmentCode: TComboBox;
    cmbDepartment: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    txtNumber: TEdit;
    txtSerial: TEdit;
    cmdCancelFilter: TBitBtn;
    cmbCardID: TComboBox;
    Label9: TLabel;
    txtIFromDate: TEdit;
    Label10: TLabel;
    txtIToDate: TEdit;
    Label11: TLabel;
    txtOFromDate: TEdit;
    Label12: TLabel;
    txtOToDate: TEdit;
    Label3: TLabel;
    txtFromCustCode: TEdit;
    Label13: TLabel;
    txtToCustCode: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure txtCuFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtCuFromDateExit(Sender: TObject);
    procedure txtCuToDateExit(Sender: TObject);
    procedure cmbCustCodeClick(Sender: TObject);
    procedure cmbCustNameClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure rdoMojodiClick(Sender: TObject);
    procedure cmbCustCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdCancelFilterClick(Sender: TObject);
    procedure cmbCardIDClick(Sender: TObject);
    procedure cmbDepartmentChange(Sender: TObject);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure txtCuFromDateEnter(Sender: TObject);
    procedure txtIFromDateEnter(Sender: TObject);
    procedure txtOFromDateEnter(Sender: TObject);
    procedure txtCuFromDateChange(Sender: TObject);
    procedure txtIFromDateChange(Sender: TObject);
    procedure txtOFromDateChange(Sender: TObject);
    procedure txtIFromDateExit(Sender: TObject);
    procedure txtOFromDateExit(Sender: TObject);
    procedure txtIFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtOFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtIToDateExit(Sender: TObject);
    procedure txtOToDateExit(Sender: TObject);
    procedure txtIToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtOToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromCustCodeEnter(Sender: TObject);
    procedure cmbCustCodeEnter(Sender: TObject);
    procedure txtFromCustCodeChange(Sender: TObject);
    procedure cmbCustCodeChange(Sender: TObject);
    procedure txtFromCustCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtToCustCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}
const
  filterCustomer = 1;
  filterInpute = 2;
  filterOutput = 3;
  filterOneCousCode = 4;
  filterSomeCousCode = 5;

var
  filterType : byte;
  filterType2 : byte;


procedure TfrmCustomsRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  grpReportType.Caption := (grpReportType.Caption);
  rdoMojodi.Caption := (rdoMojodi.Caption);
  rdoCircular.Caption := (rdoCircular.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmCustomsRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
  SetDirectionFarsi(cmbCustName.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code, P_CardID, P_Family+''-''+P_Name AS P_Family_Name FROM NewPersons ');
  qry.SQL.Add('ORDER BY P_Family, P_Name, P_Code, P_CardID');
//kaveh  qry.SQL.Add('SELECT Cust_Code, Cust_Name FROM Customs');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCustCode.Items.Add(qry.FieldByName('P_Code').AsString);
    cmbCustName.Items.Add(qry.FieldByName('P_Family_Name').AsString);
    cmbCardID.Items.Add(qry.FieldByName('P_CardID').AsString);
//kaveh    cmbCustCode.Items.Add(qry.FieldByName('Cust_Code').AsString);
//kaveh    cmbCustName.Items.Add(qry.FieldByName('Cust_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Department ORDER BY Depart_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDepartmentCode.Items.Add(qry.FieldByName('Depart_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;

{  if (not rdoMojodi.Enabled) and (not rdoCircular.Enabled) then
  begin
    Label1.Enabled := False;
    Label2.Enabled := False;
    txtCuFromDate.Enabled := False;
    Label3.Enabled := False;
    txtCuToDate.Enabled := False;
    rdoBaseInfo.Checked := True;
  end
  else if (not rdoMojodi.Enabled) and (rdoCircular.Enabled) then
    rdoCircular.Checked := True;}

  if (rdoMojodi.Checked) or (rdoCircular.Checked) then
  begin
    Label1.Enabled := True;
    txtCuFromDate.Enabled := True;
    Label2.Enabled := True;
    txtCuToDate.Enabled := True;

    Label9.Enabled := True;
    txtIFromDate.Enabled := True;
    Label10.Enabled := True;
    txtIToDate.Enabled := True;
    Label11.Enabled := True;
    txtOFromDate.Enabled := True;
    Label12.Enabled := True;
    txtOToDate.Enabled := True;
  end;
  if rdoBaseInfo.Checked then
  begin
    Label1.Enabled := False;
    txtCuFromDate.Enabled := False;
    Label2.Enabled := False;
    txtCuToDate.Enabled := False;

    Label9.Enabled := False;
    txtIFromDate.Enabled := False;
    Label10.Enabled := False;
    txtIToDate.Enabled := False;
    Label11.Enabled := False;
    txtOFromDate.Enabled := False;
    Label12.Enabled := False;
    txtOToDate.Enabled := False;
  end;

       
  
end;

procedure TfrmCustomsRpt.rdoMojodiClick(Sender: TObject);
begin
  if (rdoMojodi.Checked) or (rdoCircular.Checked) then
  begin
    Label1.Enabled := True;
    txtCuFromDate.Enabled := True;
    Label2.Enabled := True;
    txtCuToDate.Enabled := True;

    Label9.Enabled := True;
    txtIFromDate.Enabled := True;
    Label10.Enabled := True;
    txtIToDate.Enabled := True;
    Label11.Enabled := True;
    txtOFromDate.Enabled := True;
    Label12.Enabled := True;
    txtOToDate.Enabled := True;
  end;
  if rdoBaseInfo.Checked then
  begin
    Label1.Enabled := False;
    txtCuFromDate.Enabled := False;
    Label2.Enabled := False;
    txtCuToDate.Enabled := False;

    Label9.Enabled := False;
    txtIFromDate.Enabled := False;
    Label10.Enabled := False;
    txtIToDate.Enabled := False;
    Label11.Enabled := False;
    txtOFromDate.Enabled := False;
    Label12.Enabled := False;
    txtOToDate.Enabled := False;
  end;
end;

procedure TfrmCustomsRpt.txtCuFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCustomsRpt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
{  if Key = #13 then
    cmbCarCity.SetFocus
  else
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);
}
  Key := #0;
end;

procedure TfrmCustomsRpt.txtOFromDateChange(Sender: TObject);
begin
  if filterType = filterOutput then
  begin
    txtCuFromDate.Text := '';
    txtCuToDate.Text := '';
    txtIFromDate.Text := '';
    txtIToDate.Text := '';
  end;
end;

procedure TfrmCustomsRpt.txtOFromDateEnter(Sender: TObject);
begin
  filterType := filterOutput;
end;

procedure TfrmCustomsRpt.txtOFromDateExit(Sender: TObject);
begin
  if txtOFromDate.Text <> '' then
    txtOFromDate.Text := BeautifulDate(txtOFromDate.Text);
end;

procedure TfrmCustomsRpt.txtOFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCustomsRpt.txtOToDateExit(Sender: TObject);
begin
  if txtOTodate.Text <> '' then
    txtOToDate.Text := BeautifulDate(txtOToDate.Text);
end;

procedure TfrmCustomsRpt.txtOToDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCustomsRpt.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDate.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure TfrmCustomsRpt.txtToCustCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmCustomsRpt.txtCuFromDateChange(Sender: TObject);
begin
  if filterType = filterCustomer then
  begin
    txtIFromDate.Text := '';
    txtIToDate.Text := '';
    txtOFromDate.Text := '';
    txtOToDate.Text := '';
  end;
end;

procedure TfrmCustomsRpt.txtCuFromDateEnter(Sender: TObject);
begin
  filterType := filterCustomer;
end;

procedure TfrmCustomsRpt.txtCuFromDateExit(Sender: TObject);
begin
  if txtCuFromDate.Text <> '' then
    txtCuFromDate.Text := BeautifulDate(txtCuFromDate.Text);
end;

procedure TfrmCustomsRpt.txtCuToDateExit(Sender: TObject);
begin
  if txtCuTodate.Text <> '' then
    txtCuToDate.Text := BeautifulDate(txtCuToDate.Text);
end;

procedure TfrmCustomsRpt.txtIFromDateChange(Sender: TObject);
begin
  if filterType = filterInpute then
  begin
    txtCuFromDate.Text := '';
    txtCuToDate.Text := '';
    txtOFromDate.Text := '';
    txtOToDate.Text := '';
  end;
end;

procedure TfrmCustomsRpt.txtIFromDateEnter(Sender: TObject);
begin
  filterType := filterInpute;
end;

procedure TfrmCustomsRpt.txtIFromDateExit(Sender: TObject);
begin
  if txtIFromDate.Text <> '' then
    txtIFromDate.Text := BeautifulDate(txtIFromDate.Text);
end;

procedure TfrmCustomsRpt.txtIFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCustomsRpt.txtIToDateExit(Sender: TObject);
begin
  if txtITodate.Text <> '' then
    txtIToDate.Text := BeautifulDate(txtIToDate.Text);
end;

procedure TfrmCustomsRpt.txtIToDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCustomsRpt.cmbCardIDClick(Sender: TObject);
begin
  cmbCustCode.ItemIndex := cmbCardID.ItemIndex;
  cmbCustName.ItemIndex := cmbCardID.ItemIndex;
end;

procedure TfrmCustomsRpt.cmbCustCodeChange(Sender: TObject);
begin
  if filterType2 = filterOneCousCode then
  begin
    txtFromCustCode.Text := '';
    txtToCustCode.Text := '';
  end;
end;

procedure TfrmCustomsRpt.cmbCustCodeClick(Sender: TObject);
begin
  cmbCustName.ItemIndex := cmbCustCode.ItemIndex;
  cmbCardID.ItemIndex := cmbCustCode.ItemIndex;
end;

procedure TfrmCustomsRpt.cmbCustCodeEnter(Sender: TObject);
begin
  filterType2 := filterOneCousCode;
end;

procedure TfrmCustomsRpt.cmbCustCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbCustCode.ItemIndex := -1;
      cmbCustName.ItemIndex := -1;
      cmbCardID.ItemIndex := -1;
    end;
end;

procedure TfrmCustomsRpt.cmbCustNameClick(Sender: TObject);
begin
  cmbCustCode.ItemIndex := cmbCustName.ItemIndex;
  cmbCardID.ItemIndex := cmbCustName.ItemIndex;
end;

procedure TfrmCustomsRpt.cmbDepartmentChange(Sender: TObject);
begin
  cmbDepartmentCode.ItemIndex := cmbDepartment.ItemIndex;
end;

procedure TfrmCustomsRpt.cmbDepartmentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbDepartment.ItemIndex := -1;
      cmbDepartmentCode.ItemIndex := -1;
    end;
end;

procedure TfrmCustomsRpt.cmdCancelFilterClick(Sender: TObject);
begin
  txtCuFromDate.Text := '';
  txtCuToDate.Text := '';
  txtIFromDate.Text := '';
  txtIToDate.Text := '';
  txtOFromDate.Text := '';
  txtOToDate.Text := '';
  cmbCustCode.ItemIndex := -1;
  cmbCustName.ItemIndex := -1;
  cmbCardID.ItemIndex := -1;
  txtNumber.Text := '';
  txtSerial.Text := '';
  cmbDepartmentCode.ItemIndex := -1;
  cmbDepartment.ItemIndex := -1;
end;

procedure TfrmCustomsRpt.cmdPrintClick(Sender: TObject);
var
  frmRptCustMojodi : TfrmRptCustMojodi;
  frmRptCustCircle : TfrmRptCustCircle;
  frmRptNewPersons : TfrmRptNewPersons;
  test : string;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  if rdoMojodi.Checked then
  begin
    Application.CreateForm(TfrmRptCustMojodi, frmRptCustMojodi);
    with frmRptCustMojodi do
    begin
      qryCust.SQL.Clear;
      qryCust.SQL.Add('SELECT Cust_Code, Cust_Name, Cust_Tel, Cust_Date, Cust_Remain FROM Customs');
      if cmbCustCode.Text <> '' then
        qryCust.SQL.Add('WHERE Cust_Code = ' + cmbCustCode.Text);
      qryCust.SQL.Add('ORDER BY Cust_Date');
      qryCust.Open;
      if qryCust.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptCust.Preview
        else if rdoPrinter.Checked then
          qrptCust.Print;
      end
      else
        ErrorMessage('مشتركي براي گزارش وجود ندارد.');
      qryCust.Close;
      Free;
    end;
  end
  else if rdoCircular.Checked then
  begin
    Application.CreateForm(TfrmRptCustCircle, frmRptCustCircle);
    with frmRptCustCircle do
    begin
      if (txtCuFromDate.Text <> '') and (txtCuToDate.Text <> '') then
        lblFromToDate.Caption := ('تاریخ اشتراک از: ' )+ txtCuFromDate.Text + ('    تا : ' )+ txtCuToDate.Text
      else if txtCuFromDate.Text <> '' then
        lblFromToDate.Caption := ('تاریخ اشتراک از: ' )+ txtCuFromDate.Text
      else if txtCuToDate.Text <> '' then
        lblFromToDate.Caption := ('تاریخ اشتراک تا: ' )+ txtCuToDate.Text
      else
      begin
        if (txtIFromDate.Text <> '') and (txtIToDate.Text <> '') then
          lblFromToDate.Caption := ('تاریخ ورود از: ' )+ txtIFromDate.Text + ('    تا : ' )+ txtIToDate.Text
        else if txtIFromDate.Text <> '' then
          lblFromToDate.Caption := ('تاریخ ورود از: ' )+ txtIFromDate.Text
        else if txtIToDate.Text <> '' then
          lblFromToDate.Caption := ('تاریخ ورود تا: ' )+ txtIToDate.Text
        else
        begin
          if (txtOFromDate.Text <> '') and (txtOToDate.Text <> '') then
            lblFromToDate.Caption := ('تاریخ خروج از: ' )+ txtOFromDate.Text + ('    تا : ' )+ txtOToDate.Text
          else if txtOFromDate.Text <> '' then
            lblFromToDate.Caption := ('تاریخ خروج از: ' )+ txtOFromDate.Text
          else if txtOToDate.Text <> '' then
            lblFromToDate.Caption := ('تاریخ خروج تا: ' )+ txtOToDate.Text
          else
            lblFromToDate.Caption := '';
        end;
      end;

      if (txtFromCustCode.Text <> '') and (txtToCustCode.Text <> '') then
        lblFromToCustCode.Caption := ('شماره اشتراک از: ' )+ txtFromCustCode.Text + ('    تا : ' )+ txtToCustCode.Text
      else if txtFromCustCode.Text <> '' then
        lblFromToCustCode.Caption := ('شماره اشتراک از: ' )+ txtFromCustCode.Text
      else if txtToCustCode.Text <> '' then
        lblFromToCustCode.Caption := ('شماره اشتراک تا: ' )+ txtToCustCode.Text
      else
      begin
       if cmbCustCode.Text <> '' then
        lblFromToCustCode.Caption := ('شماره اشتراک: ' )+ cmbCustCode.Text
       else
        lblFromToCustCode.Caption := '';
      end;


      
      //  lblFromToDate.Caption := '';

      qryCust.SQL.Clear;
      with qryCust.SQL do
      begin
        Add(' ('); // NewPersons.P_CardID,
        Add(' SELECT NewPersons.P_Code, NewPersons.P_Family + '' - '' + NewPersons.P_Name AS FamilyName, NewPersons.P_CarNumber,');
        Add(' NewPersons.P_CarSerial, NewPersons.P_Date, NewPersons.P_Tel, ''ورود'' as act,');
        Add(' InputCar.M_IDate, InputCar.M_ITime, InputCar.M_ODate, InputCar.M_OTime, InputCar.M_Status');
        Add(' FROM NewPersons LEFT OUTER JOIN');
        Add(' InputCar ON NewPersons.P_CarSerial = InputCar.M_Serial AND NewPersons.P_CarNumber = InputCar.M_Number');
        Add(' WHERE (P_IsCustomer = 1)');
        Add(' AND (M_Status = 61 OR M_Status = 62)');
        
        if (txtCuFromDate.Text <> '') AND (txtCuFromDate.Text <> '//')then
          Add(' AND P_Date >= ''' + txtCuFromDate.Text + '''');
        if (txtCuToDate.Text <> '') AND (txtCuToDate.Text <> '//') then
          Add(' AND P_Date <= ''' + txtCuToDate.Text + '''');
        if (txtIFromDate.Text <> '') AND (txtIFromDate.Text <> '//')then
          Add(' AND M_IDate >= ''' + txtIFromDate.Text + '''');
        if (txtIToDate.Text <> '') AND (txtIToDate.Text <> '//') then
          Add(' AND M_IDate <= ''' + txtIToDate.Text + '''');
        if (txtOFromDate.Text <> '') AND (txtOFromDate.Text <> '//')then
          Add(' AND M_ODate >= ''' + txtOFromDate.Text + '''');
        if (txtOToDate.Text <> '') AND (txtOToDate.Text <> '//') then
          Add(' AND M_ODate <= ''' + txtOToDate.Text + '''');
        if cmbCustCode.Text <> '' then
          Add(' AND P_Code = ''' + cmbCustCode.Text + '''');

        if txtFromCustCode.Text <> '' then
          Add(' AND CONVERT(integer,P_Code) >= ' + txtFromCustCode.Text);
        if txtToCustCode.Text <> '' then
          Add(' AND CONVERT(integer,P_Code) <= ' + txtToCustCode.Text);

        if cmbCardID.Text <> '' then
          Add(' AND P_CardID = ''' + cmbCardID.Text + '''');
        if txtNumber.Text <> '' then
          Add(' AND P_CarNumber = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          Add(' AND P_CarSerial = ''' + txtSerial.Text + '''');
        if cmbDepartmentCode.Text <> '' then
          Add(' AND P_Depart = ' + cmbDepartmentCode.Text);

        Add(' )');
        Add(' union');
        Add(' ('); // NewPersons.P_CardID,
        Add(' SELECT NewPersons.P_Code, NewPersons.P_Family + '' - '' + NewPersons.P_Name AS FamilyName, NewPersons.P_CarNumber,');
        Add(' NewPersons.P_CarSerial, NewPersons.P_Date, NewPersons.P_Tel, ''خروج'' as act,');
        Add(' Machines.M_IDate, Machines.M_ITime, Machines.M_ODate, Machines.M_OTime, Machines.M_Status');
        Add(' FROM NewPersons LEFT OUTER JOIN');
        Add(' Machines ON NewPersons.P_CarSerial = Machines.M_Serial AND NewPersons.P_CarNumber = Machines.M_Number');
        Add(' WHERE (P_IsCustomer = 1)');
        Add(' AND (M_Status = 63 OR M_Status = 64)');

        if (txtCuFromDate.Text <> '') AND (txtCuFromDate.Text <> '//')then
          Add(' AND P_Date >= ''' + txtCuFromDate.Text + '''');
        if (txtCuToDate.Text <> '') AND (txtCuToDate.Text <> '//') then
          Add(' AND P_Date <= ''' + txtCuToDate.Text + '''');
        if (txtIFromDate.Text <> '') AND (txtIFromDate.Text <> '//')then
          Add(' AND M_IDate >= ''' + txtIFromDate.Text + '''');
        if (txtIToDate.Text <> '') AND (txtIToDate.Text <> '//') then
          Add(' AND M_IDate <= ''' + txtIToDate.Text + '''');
        if (txtOFromDate.Text <> '') AND (txtOFromDate.Text <> '//')then
          Add(' AND M_ODate >= ''' + txtOFromDate.Text + '''');
        if (txtOToDate.Text <> '') AND (txtOToDate.Text <> '//') then
          Add(' AND M_ODate <= ''' + txtOToDate.Text + '''');
        if cmbCustCode.Text <> '' then
          Add(' AND P_Code = ''' + cmbCustCode.Text + '''');

        if txtFromCustCode.Text <> '' then
          Add(' AND CONVERT(integer,P_Code) >= ' + txtFromCustCode.Text);
        if txtToCustCode.Text <> '' then
          Add(' AND CONVERT(integer,P_Code) <= ' + txtToCustCode.Text);

        if cmbCardID.Text <> '' then
          Add(' AND P_CardID = ''' + cmbCardID.Text + '''');
        if txtNumber.Text <> '' then
          Add(' AND P_CarNumber = ''' + txtNumber.Text + '''');
        if txtSerial.Text <> '' then
          Add(' AND P_CarSerial = ''' + txtSerial.Text + '''');
        if cmbDepartmentCode.Text <> '' then
          Add(' AND P_Depart = ' + cmbDepartmentCode.Text);
        
        Add(' )');
        
        Add(' ORDER BY P_Code, M_IDate, M_ITime, M_ODate, M_OTime');
      end;
      
{
      qryCust.SQL.Add('SELECT * FROM PayCust, Customs');
      qryCust.SQL.Add('WHERE Pay_CustCode = Cust_Code');
      if txtCuFromDate.Text <> '' then
        qryCust.SQL.Add('AND Pay_Date >= ''' + txtCuFromDate.Text + '''');
      if txtCuToDate.Text <> '' then
        qryCust.SQL.Add('AND Pay_Date <= ''' + txtCuToDate.Text + '''');
      if cmbCustCode.Text <> '' then
        qryCust.SQL.Add('AND Cust_Code = ' + cmbCustCode.Text);
      qryCust.SQL.Add('ORDER BY Pay_CustCode, Pay_Date');
}

      test := qryCust.SQL.Text;      
      qryCust.Open;

      if qryCust.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptCustCr.Preview
        else if rdoPrinter.Checked then
          qrptCustCr.Print;
      end
      else
        ErrorMessage('مشتركي براي گزارش وجود ندارد.');
      qryCust.Close;
      Free;
    end;
  end
  else if rdoBaseInfo.Checked then
  begin
    Application.CreateForm(TfrmRptNewPersons, frmRptNewPersons);
    with frmRptNewPersons do
    begin
      if cmbDepartment.Text <> '' then
        lblDepartName.Caption := cmbDepartment.Text
      else
        lblDepartName.Caption := '';//'کليه محلهاي خدمت';

      qryNewPersons.SQL.Clear;
      qryNewPersons.SQL.Add('SELECT NewPersons.P_Code, NewPersons.P_Family, NewPersons.P_Name, NewPersons.P_CarNumber, NewPersons.P_CarSerial, ');
      qryNewPersons.SQL.Add('NewPersons.P_CardID, NewPersons.P_Tel, cars.Car_Name, Colors.Clr_Name, Department.Depart_Name, ');
      qryNewPersons.SQL.Add('NewPersons.P_Date, NewPersons.P_IsCustomer ');
      qryNewPersons.SQL.Add('FROM NewPersons LEFT OUTER JOIN ');
      qryNewPersons.SQL.Add('Department ON NewPersons.P_Depart = Department.Depart_Code LEFT OUTER JOIN ');
      qryNewPersons.SQL.Add('Colors ON NewPersons.P_CarColor = Colors.Clr_Code LEFT OUTER JOIN ');
      qryNewPersons.SQL.Add('cars ON NewPersons.P_CarName = cars.Car_Code ');

      if cmbDepartment.Text <> '' then
        qryNewPersons.SQL.Add('WHERE P_Depart = ' + cmbDepartmentCode.Text + ' ')
      else 
        qryNewPersons.SQL.Add('WHERE (P_Code > -1) ');

      if cmbCustCode.Text <> '' then
        qryNewPersons.SQL.Add('AND P_Code = ' + cmbCustCode.Text + ' ');

      if txtNumber.Text <> '' then
        qryNewPersons.SQL.Add(' AND P_CarNumber = ''' + txtNumber.Text + ''' ');

      if txtSerial.Text <> '' then
        qryNewPersons.SQL.Add(' AND P_CarSerial = ''' + txtSerial.Text + ''' ');

      qryNewPersons.SQL.Add('ORDER BY P_Family, P_Name, P_Code, P_CardID');
      test := qryNewPersons.SQL.Text;
      qryNewPersons.Open;
      if qryNewPersons.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptNewPersons.Preview
        else if rdoPrinter.Checked then
          qrptNewPersons.Print;
      end
      else
        ErrorMessage('مشتركي براي گزارش وجود ندارد.');
      qryNewPersons.Close;
      Free;
    end;
  end;
  
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;

procedure TfrmCustomsRpt.txtFromCustCodeChange(Sender: TObject);
begin
  if filterType2 = filterSomeCousCode then
  begin
    cmbCustCode.ItemIndex := -1;
    cmbCustName.ItemIndex := -1;
    cmbCardID.ItemIndex := -1;
  end;
end;

procedure TfrmCustomsRpt.txtFromCustCodeEnter(Sender: TObject);
begin
  filterType2 := filterSomeCousCode;
end;

procedure TfrmCustomsRpt.txtFromCustCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

end.
