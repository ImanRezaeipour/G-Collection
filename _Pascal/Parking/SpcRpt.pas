unit SpcRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, FarsiApi,
  RpSpcial, RpCustCr, MSGs, RunCmnds, DosMove;

type
  TfrmSpecialRpt = class(TForm)
    grpReportType: TGroupBox;
    rdoNotExit: TRadioButton;
    rdoMotavari: TRadioButton;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    rdoTakhfif: TRadioButton;
    DosMove1: TDosMove;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmSpecialRpt.SetWinF;
begin
  Caption := (Caption);
  grpReportType.Caption := (grpReportType.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoNotExit.Caption := (rdoNotExit.Caption);
  rdoMotavari.Caption := (rdoMotavari.Caption);
  rdoTakhfif.Caption := (rdoTakhfif.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmSpecialRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
end;

procedure TfrmSpecialRpt.cmdPrintClick(Sender: TObject);
var frmRptSpc : TfrmRptSpc;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  Application.CreateForm(TfrmRptSpc, frmRptSpc);
  with frmRptSpc do
  begin
    qrySpc.SQL.Clear;
    qrySpc.SQL.Add('SELECT * FROM Specials');
    if rdoNotExit.Checked then
    begin
      Flag := MB_NOTEXIT;
      lblName.Caption := ('ÒÇÑÔ ÎæÏÑæåÇí ããäæÚ ÇáÎÑæÌ');
      qrySpc.SQL.Add('WHERE Spc_NotExit = ' + IntToStr(CNST_TRUE));
    end
    else if rdoMotavari.Checked then
    begin
      Flag := MB_MOTAVARI;
      lblName.Caption := ('ÒÇÑÔ ÎæÏÑæåÇí ãÊæÇÑí');
      qrySpc.SQL.Add('WHERE Spc_Motavari = ' + IntToStr(CNST_TRUE));
    end
    else if rdoTakhfif.Checked then
    begin
      Flag := MB_TAKHFIF;
      lblName.Caption := ('ÒÇÑÔ ÎæÏÑæåÇí ãÔãæá ÊÎİíİ');
      qrySpc.SQL.Add('WHERE Spc_Takhfif = ' + IntToStr(CNST_TRUE));
    end;
    qrySpc.Open;
    if qrySpc.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        qrptSpc.Preview
      else if rdoPrinter.Checked then
        qrptSpc.Print;
    end
    else
      ErrorMessage('ÎæÏÑæíí ÈÑÇí ÒÇÑÔ æÌæÏ äÏÇÑÏ.');
    qrySpc.Close;
    Free;
  end;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;



end.
