unit SrvcUsRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,DosMove;

type
  TfrmUsedServiceRpt = class(TForm)
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
    cmbReaders: TComboBox;
    lbl4: TLabel;
    btnReaderSel: TBitBtn;
    lbl5: TLabel;
    cmbDepartment: TComboBox;
    btnDepartment: TBitBtn;
    lbl6: TLabel;
    txtDescribe: TEdit;
    GroupBox1: TGroupBox;
    rdodept: TRadioButton;
    rdoreader: TRadioButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbReadersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnReaderSelClick(Sender: TObject);
    procedure btnDepartmentClick(Sender: TObject);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    srvcSelected,
    rdrSelected,
    departSelected : String;

    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmUsedServiceRpt : TfrmUsedServiceRpt;


implementation

uses
  Funcs, ComTools, Globals, Keyboard, DateProc, MSGs, DBS,
  RpSvcUs1, Select, FntSel;

{$R *.DFM}

procedure TfrmUsedServiceRpt.SetWinF;
begin
  SetFontColor(TForm(frmUsedServiceRpt));
end;

procedure TfrmUsedServiceRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  Application.CreateForm(TfrmSelect, frmSelect);
  txtFromDate.Text := gOptions.fromDate;
  txtToDate.Text := gOptions.toDate;
  srvcSelected := '';
  rdrSelected := '';
  departSelected := '';

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Readers');
    Open;
    while not Eof do
    begin
      cmbReaders.Items.Add(FieldByName('Rdr_Code').AsString + '-' + FieldByName('Rdr_Name').AsString);
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

procedure TfrmUsedServiceRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmUsedServiceRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmUsedServiceRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmUsedServiceRpt.cmbReadersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbReaders.ItemIndex := -1;
  end;
end;

procedure TfrmUsedServiceRpt.cmbDepartmentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbDepartment.ItemIndex := -1;
  end;
end;

procedure TfrmUsedServiceRpt.cmdPrintClick(Sender: TObject);
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
          aqryReceipt.SQL.Add('SELECT sum(recit1_TotalPrice) as recit1_totalPrice, recit1_Date ');
          if rdodept.Checked
          then begin
               aqryReceipt.SQL.Add(', recit1_Department');
//               aqryReceipt.SQL.Add(', recit1_Rdr');
               isdept:=true;
          end
          else begin
               isdept:=false;
          end;
          if rdoreader.Checked
          then begin
               aqryReceipt.SQL.Add(', recit1_Rdr');
               isreader:=true;
          end
          else begin
               isreader:=false;
          end;
          aqryReceipt.SQL.Add('FROM Receipt1');
//          aqryReceipt.SQL.Add('FROM Receipt1,readers,department');
          aqryReceipt.SQL.Add('Where recit1_TotalPrice > 0 ');
//          aqryReceipt.SQL.Add('and recit1_TotalPrice > 0 ');


          if gOptions.UserDepart <> 0 then
            aqryReceipt.SQL.Add('AND recit1_Department = ' + IntToStr(gOptions.UserDepart));

          if txtFromDate.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Date <= ''' + txtToDate.Text + '''');

          if cmbReaders.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Rdr = ' + Copy(cmbReaders.Text, 1, Pos('-', cmbReaders.Text)-1))
          else if rdrSelected <> '' then
            aqryReceipt.SQL.Add('AND recit1_Rdr IN (' + rdrSelected + ')');

          if cmbDepartment.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
          else if departSelected <> '' then
            aqryReceipt.SQL.Add('AND recit1_Department IN (' + departSelected + ')');

          aqryReceipt.SQL.Add('GROUP BY ');
          if rdoreader.Checked then  aqryReceipt.SQL.Add('recit1_Rdr, ');
          if rdodept.Checked then aqryReceipt.SQL.Add('recit1_Department, ');
          aqryReceipt.SQL.Add(' recit1_Date ');
          aqryReceipt.sql.add('order by recit1_date');
        end
        else
        begin
          aqryReceipt.SQL.Add('SELECT sum(recit1_TotalPrice) as recit1_totalPrice');
          if rdodept.Checked
          then begin
//               aqryReceipt.SQL.Add(', recit1_Rdr');
               aqryReceipt.SQL.Add(', recit1_Department');
               isdept:=true;
          end
          else begin
               isdept:=false;
          end;
          if rdoreader.Checked
          then begin
               aqryReceipt.SQL.Add(', recit1_Rdr');
               isreader:=true;
          end
          else begin
               isreader:=false;
          end;
          aqryReceipt.SQL.Add('FROM Receipt1');
          aqryReceipt.SQL.Add('Where recit1_TotalPrice > 0 ');

          if gOptions.UserDepart <> 0 then
            aqryReceipt.SQL.Add('AND recit1_Department = ' + IntToStr(gOptions.UserDepart));

          if txtFromDate.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Date <= ''' + txtToDate.Text + '''');

          if cmbReaders.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Rdr = ' + Copy(cmbReaders.Text, 1, Pos('-', cmbReaders.Text)-1))
          else if rdrSelected <> '' then
            aqryReceipt.SQL.Add('AND recit1_Rdr IN (' + rdrSelected + ')');

          if cmbDepartment.Text <> '' then
            aqryReceipt.SQL.Add('AND recit1_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
          else if departSelected <> '' then
            aqryReceipt.SQL.Add('AND recit1_Department IN (' + departSelected + ')');

          aqryReceipt.SQL.Add('GROUP BY ');
          if rdoreader.Checked then aqryReceipt.SQL.Add('recit1_Rdr ');
          if rdodept.Checked then aqryReceipt.SQL.Add('recit1_Department ');
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

procedure TfrmUsedServiceRpt.btnReaderSelClick(Sender: TObject);
begin
  if cmbReaders.Items.Count > 0 then
  begin
    frmSelect.selType := SEL_RDR;
    if frmSelect.ShowModal = mrOK then
      rdrSelected := frmSelect.dataSelected
    else
      rdrSelected := '';
  end;
end;

procedure TfrmUsedServiceRpt.btnDepartmentClick(Sender: TObject);
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

procedure TfrmUsedServiceRpt.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

end.

SELECT sum(recit1_TotalPrice) as recit1_totalPrice
, recit1_Rdr
FROM Receipt1
Where recit1_TotalPrice > 0
AND recit1_Date >= '1385/03/01'
AND recit1_Date <= '1386/03/09'
GROUP BY recit1_Rdr


SELECT sum(recit1_TotalPrice) as recit1_totalPrice, recit1_Date
, recit1_Rdr
FROM Receipt1
Where recit1_TotalPrice > 0
AND recit1_Date >= '1385/03/01'
AND recit1_Date <= '1386/03/09'
GROUP BY recit1_Rdr,recit1_Date
