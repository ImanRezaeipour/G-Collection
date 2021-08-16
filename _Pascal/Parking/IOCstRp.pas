unit IOCstRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, FarsiApi,
  MSGs, RPIoPrc, DBS, RunCmnds, DosMove, ExtCtrls;

type
  TfrmInOutCstRpt = class(TForm)
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    lbl3: TLabel;
    txtNumber: TEdit;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    lbl4: TLabel;
    txtCardCode: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtCardCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmInOutCstRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmInOutCstRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtNumber.Handle);
  rdoPrinter.Enabled := g_options.AcesPrint;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
end;

procedure TfrmInOutCstRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutCstRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutCstRpt.txtToDateExit(Sender: TObject);
begin
  if txtTodate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutCstRpt.cmdPrintClick(Sender: TObject);
var frmRptInOutPrc: TfrmRptInOutPrc;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  AddRecToMachine;
  Application.CreateForm(TfrmRptInOutPrc, frmRptInOutPrc);
  with frmRptInOutPrc do
  begin
    if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
      lblFromToDate.Caption := ('ÇÒ ÊÇÑíÎ: ' )+ txtFromDate.Text + ('    ÊÇ ÊÇÑíÎ: ' )+ txtToDate.Text
    else if txtFromDate.Text <> '' then
      lblFromToDate.Caption := ('ÇÒ ÊÇÑíÎ: ') + txtFromDate.Text
    else if txtToDate.Text <> '' then
      lblFromToDate.Caption := ('ÊÇ ÊÇÑíÎ: ') + txtToDate.Text
    else
      lblFromToDate.Caption := '';

    qryPrc.SQL.Clear;
    qryPrc.SQL.Add('SELECT * FROM Machines');
    qryPrc.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
    if txtFromDate.Text <> '' then
      qryPrc.SQL.Add('AND M_ODate >= ''' + txtFromDate.Text + '''');
    if txtToDate.Text <> '' then
      qryPrc.SQL.Add('AND M_ODate <= ''' + txtToDate.Text + '''');
    if txtNumber.Text <> '' then
      qryPrc.SQL.Add('AND M_Number = ''' + txtNumber.Text + '''');
    if txtCardCode.Text <> '' then
      qryPrc.SQL.Add('AND M_BarCode = ''' + txtCardCode.Text + '''');
    case rdoSort.ItemIndex of
      0: qryPrc.SQL.Add('ORDER BY M_Number');
      1: qryPrc.SQL.Add('ORDER BY M_BarCode, M_IDate, M_ITime');
      2: qryPrc.SQL.Add('ORDER BY M_IDate, M_ITime');
      3: qryPrc.SQL.Add('ORDER BY M_PayAble');
    end;
    qryPrc.Open;
    if qryPrc.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        qrptPrc.Preview
      else if rdoPrinter.Checked then
        qrptPrc.Print;
    end
    else
      ErrorMessage('ÊÑÏÏí æÌæÏ äÏÇÑÏ.');
    qryPrc.Close;
    Free;
  end;
  DelRecFromMachine;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;


procedure TfrmInOutCstRpt.txtNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key <> #13 then
  begin
    txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
    Key := #0;
  end;
end;

procedure TfrmInOutCstRpt.txtCardCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

end.
