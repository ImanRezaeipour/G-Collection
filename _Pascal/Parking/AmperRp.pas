unit AmperRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, DateProc, MSGs, Keyboard, FarsiApi,
  RpAmper, RunCmnds, DosMove;

type
  TfrmAmperRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    cmbBarCode: TComboBox;
    Label2: TLabel;
    txtTarget: TEdit;
    Label3: TLabel;
    txtFromDate: TEdit;
    Label4: TLabel;
    txtToDate: TEdit;
    Label5: TLabel;
    txtMasafat: TEdit;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}


procedure TfrmAmperRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmAmperRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtTarget.Handle);
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;

  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
    SQL.Clear;
    SQL.Add('SELECT Co_BarCode FROM CoCars');
    Open;
    while not EOF do
    begin
      cmbBarCode.Items.Add(FieldByName('Co_BarCode').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmAmperRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmAmperRpt.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmAmperRpt.cmdPrintClick(Sender: TObject);
var frmRptAmper: TfrmRptAmper;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  Application.CreateForm(TfrmRptAmper, frmRptAmper);
  with frmRptAmper do
  begin
    qryAmper.SQL.Clear;
    qryAmper.SQL.Add('SELECT * FROM InOutCo, CoCars WHERE IO_BarCode = Co_BarCode');
    if txtFromDate.Text <> '' then
      qryAmper.SQL.Add('AND IO_ODate >= ''' + txtFromDate.Text + '''');
    if txtToDate.Text <> '' then
      qryAmper.SQL.Add('AND IO_IDate <= ''' + txtToDate.Text + '''');
    if cmbBarCode.Text <> '' then
      qryAmper.SQL.Add('AND IO_BarCode = ''' + cmbBarCode.Text + '''');
    if txtMasafat.Text <> '' then
      qryAmper.SQL.Add('AND (IO_IAmper-IO_OAmper) >= ' + txtMasafat.Text);
    qryAmper.Open;
    if qryAmper.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        qrptAmper.Preview
      else
        qrptAmper.Print;
    end
    else
      InformationMessage('ê“«—‘Ì œ— «Ì‰ „ÕœÊœÂ ÊÃÊœ ‰œ«—œ.');
    Close;
    Free;
  end;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;

end.
