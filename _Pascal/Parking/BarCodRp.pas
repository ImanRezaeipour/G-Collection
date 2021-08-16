unit BarCodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, FarsiApi,
  MSGs, RpBarCod, RpBrCdCr, DBS, RunCmnds, DosMove;

type
  TfrmBarCodeRpt = class(TForm)
    grpList: TGroupBox;
    rdoInCust: TRadioButton;
    rdoInPark: TRadioButton;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    rdoAll: TRadioButton;
    GroupBox1: TGroupBox;
    rdoList: TRadioButton;
    rdoCircle: TRadioButton;
    cmbCardType: TComboBox;
    Label1: TLabel;
    grpCircle: TGroupBox;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmbCards: TComboBox;
    DosMove1: TDosMove;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdoListClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmBarCodeRpt.SetWinF;
begin
  Caption := (Caption);
  rdoList.Caption := (rdoList.Caption);
  rdoCircle.Caption := (rdoCircle.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label1.Caption := (Label1.Caption);
  rdoInCust.Caption := (rdoInCust.Caption);
  rdoInPark.Caption := (rdoInPark.Caption);
  rdoAll.Caption := (rdoAll.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
end;

procedure TfrmBarCodeRpt.FormCreate(Sender: TObject);
var
  i : Integer;
  qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(cmbCardType.Handle);
  rdoPrinter.Enabled := g_options.AcesPrint;
  grpCircle.Top := grpList.Top;
  grpCircle.Left := grpList.Left;
  for i := MB_NORMAL to MB_LOST do
    cmbCardType.Items.Add((StName[i]));

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Card_Code FROM BarCodes');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCards.Items.Add(qry.FieldByName('Card_Code').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

procedure TfrmBarCodeRpt.rdoListClick(Sender: TObject);
begin
  grpList.Visible := rdoList.Checked;
  grpCircle.Visible := not grpList.Visible;
end;

procedure TfrmBarCodeRpt.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_date(Key);
end;

procedure TfrmBarCodeRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmBarCodeRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmBarCodeRpt.cmdPrintClick(Sender: TObject);
var
  frmRptBarCodeList : TfrmRptBarCodeList;
  frmRptBarCodeCircle : TfrmRptBarCodeCircle;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  AddRecToMachine;
  if rdoList.Checked then
  begin
    Application.CreateForm(TfrmRptBarCodeList, frmRptBarCodeList);
    with frmRptBarCodeList do
    begin
      qryBarCode.SQL.Clear;

      if rdoAll.Checked then
      begin
        qryBarCode.SQL.Add('SELECT * FROM BarCodes');
        if cmbCardType.Text <> '' then
          qryBarCode.SQL.Add('WHERE Card_State = ' + IntToStr(cmbCardType.ItemIndex+1));
      end
      else if rdoInCust.Checked then
      begin
        qryBarCode.SQL.Add('SELECT * FROM BarCodes, Machines');
        qryBarCode.SQL.Add('WHERE Card_Code = M_BarCode');
        qryBarCode.SQL.Add('AND M_IsPark = ' + IntToStr(CNST_TRUE));
        if cmbCardType.Text <> '' then
          qryBarCode.SQL.Add('AND Card_State = ' + IntToStr(cmbCardType.ItemIndex+1));
      end
      else
      begin
        qryBarCode.SQL.Add('SELECT * FROM BarCodes');
        qryBarCode.SQL.Add('WHERE Card_Code NOT IN (SELECT M_BarCode FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_TRUE) + ' )');
        if cmbCardType.Text <> '' then
          qryBarCode.SQL.Add('AND Card_State = ' + IntToStr(cmbCardType.ItemIndex+1));
      end;
      qryBarCode.SQL.Add('ORDER BY Card_Code');
      qryBarCode.Open;
      if qryBarCode.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptBarCode.Preview
        else if rdoPrinter.Checked then
          qrptBarCode.Print;
      end
      else
        ErrorMessage('»«—ﬂœÌ œ— ”Ì” „  ⁄—Ì› ‰‘œÂ «” .');
      qryBarCode.Close;
      Free;
    end;
  end
  else
  begin
    Application.CreateForm(TfrmRptBarCodeCircle, frmRptBarCodeCircle);
    with frmRptBarCodeCircle do
    begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('«“  «—ÌŒ: ' )+ txtFromDate.Text + ('     «  «—ÌŒ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('«“  «—ÌŒ: ' )+ txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := (' «  «—ÌŒ: ' )+ txtToDate.Text
      else
        lblFromToDate.Caption := '';

      qryBarCode.SQL.Clear;
      qryBarCode.SQL.Add('SELECT * FROM Machines WHERE NOT (M_BarCode IS NULL)');
      if txtFromDate.Text <> '' then
        qryBarCode.SQL.Add('AND M_IDate >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryBarCode.SQL.Add('AND M_ODate <= ''' + txtToDate.Text + '''');
      if cmbCards.Text <> '' then
        qryBarCode.SQL.Add('AND M_BarCode = ''' + cmbCards.Text + '''');
      qryBarCode.SQL.Add('ORDER BY M_IDate, M_ITime, M_ODate, M_OTime, M_BarCode');
      qryBarCode.Open;
      if qryBarCode.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptBarCode.Preview
        else if rdoPrinter.Checked then
          qrptBarCode.Print;
      end
      else
        ErrorMessage('»«—ﬂœÌ œ— ”Ì” „  ⁄—Ì› ‰‘œÂ «” .');
      qryBarCode.Close;
      Free;
    end;
  end;
  DelRecFromMachine;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;






end.
