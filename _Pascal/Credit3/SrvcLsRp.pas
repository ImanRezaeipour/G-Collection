unit SrvcLsRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBTables, ExtCtrls, DosMove;

type
  TfrmServiceRpt = class(TForm)
    lbl1: TLabel;
    cmbServices: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    chkSign: TCheckBox;
    DosMove1: TDosMove;
    lbl4: TLabel;
    txtDescribe: TEdit;
    rdoSort: TRadioGroup;
    lbl2: TLabel;
    cmbUnits: TComboBox;
    lbl3: TLabel;
    cmbPrice: TComboBox;
    txtPrice: TEdit;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtPriceKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmServiceRpt : TfrmServiceRpt;


implementation

uses
  Funcs, FarsiApi, Keyboard, Globals, DBS, ADODB, DateProc, MSGs, FntSel, RpSrvcLs;

{$R *.DFM}

procedure TfrmServiceRpt.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmServiceRpt));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  for i := 0 to cmbPrice.Items.Count-1 do
    cmbPrice.Items.Strings[i] := (cmbPrice.Items.Strings[i]);
  cmbPrice.ItemIndex := 1;
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  lbl4.Caption := (lbl4.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;


procedure TfrmServiceRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(cmbServices.Handle);

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT S_Name FROM Services');
    SQL.Add('ORDER BY S_Name');
    Open;
    while not EOF do
    begin
      cmbServices.Items.Add(FieldByname('S_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Unit_Name FROM Units');
    SQL.Add('ORDER BY Unit_Name');
    Open;
    while not EOF do
    begin
      cmbUnits.Items.Add(FieldByname('Unit_Name').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TfrmServiceRpt.cmdPrintClick(Sender: TObject);
var qrptService : TqrptService;
begin
  Application.CreateForm(TqrptService, qrptService);
  with qrptService do
  begin
    SetWinF_Rpt;
    lblDescribe.Caption := txtdescribe.Text;
    bndDescribe.Enabled := (txtdescribe.Text <> '');
    lblCoName.Caption := gOptions.CoName;
    if gOptions.Shobeh <> '' then
      lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
    lblDate.Caption := CurrentDate;
    bndSign.Enabled := chkSign.Checked;
    lblReptSign1.Caption := gParams.rptSign1;
    lblReptSign2.Caption := gParams.rptSign2;
    lblReptSign3.Caption := gParams.rptSign3;
    lblReptSign4.Caption := gParams.rptSign4;
    lblReptSign5.Caption := gParams.rptSign5;

    with aqrySrvc do
    begin
      Connection := frmDBS.adoConnect;

      SQL.Clear;
      SQL.Add('SELECT * FROM Services WHERE S_Code > 0');

      if cmbServices.Text <> '' then
        SQL.Add('AND S_Code = ' + IntToStr(GetServiceCode(cmbServices.Text)));

      if cmbUnits.Text <> '' then
        SQL.Add('AND S_Unit = ' + IntToStr(GetUnitCode(cmbUnits.Text)));

      if txtPrice.Text <> '' then
        case cmbPrice.ItemIndex of
          0: SQL.Add('AND S_Price < ' + txtPrice.Text);
          1: SQL.Add('AND S_Price = ' + txtPrice.Text);
          2: SQL.Add('AND S_Price > ' + txtPrice.Text);
        end;

      case rdoSort.ItemIndex of
        0: SQL.Add('ORDER BY S_Code');
        1: SQL.Add('ORDER BY S_Name');
        2: SQL.Add('ORDER BY S_Unit');
        3: SQL.Add('ORDER BY S_Price');
      end;

      Open;
      if RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          Preview
        else
          Print;
      end
      else
        ErrorMessage('ÂÌç Œœ„« Ì »—«Ì ê“«—‘ ÊÃÊœ ‰œ«—œ.');

      Close;
    end;
    Free;
  end;
end;

procedure TfrmServiceRpt.txtPriceKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

end.
