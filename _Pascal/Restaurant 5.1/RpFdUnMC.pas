unit RpFdUnMC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptUnitFoodMC = class(TForm)
    qrptUnitFood: TQuickRep;
    DetailBand1: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel16: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    bndFooterUnit: TQRBand;
    grpMonth: TQRGroup;
    qryUnitFood: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape6: TQRShape;
    QRLabel20: TQRLabel;
    QRShape10: TQRShape;
    QRExpr7: TQRExpr;
    QRShape20: TQRShape;
    QRExpr6: TQRExpr;
    QRShape5: TQRShape;
    QRExpr3: TQRExpr;
    QRShape12: TQRShape;
    SummaryBand1: TQRBand;
    QRShape17: TQRShape;
    QRExpr12: TQRExpr;
    QRShape18: TQRShape;
    QRExpr13: TQRExpr;
    QRLabel8: TQRLabel;
    grpUnit: TQRGroup;
    QRShape19: TQRShape;
    QRLabel9: TQRLabel;
    lblMonth: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    lblRow: TQRLabel;
    TitleBand1: TQRBand;
    QRShape3: TQRShape;
    QRExpr1: TQRExpr;
    QRLabel2: TQRLabel;
    QRShape4: TQRShape;
    QRExpr2: TQRExpr;
    QRShape7: TQRShape;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndFooterUnitBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr12Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr13Print(sender: TObject; var Value: String);
    procedure qrptUnitFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    Row : Integer;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptUnitFoodMC.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  lblName.Caption := (lblName.Caption); 
  qrptUnitFood.ReportTitle := (qrptUnitFood.ReportTitle);
end;

procedure TfrmRptUnitFoodMC.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryUnitFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptUnitFoodMC.bndFooterUnitBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
const Mnth : array[1..12] of string =
      ('›—Ê—œÌ‰', '«—œÌ»Â‘ ', 'Œ—œ«œ',
       ' Ì—', '„—œ«œ', '‘Â—ÌÊ—',
       '„Â—', '¬»«‰', '¬–—',
       'œÌ', '»Â„‰', '«”›‰œ');
begin
  Inc(Row);
  lblMonth.Caption := (Mnth[StrToInt(qryUnitFood.FieldByName('Fish_D').AsString)]);
  lblRow.Caption := IntToStr(Row);
end;

procedure TfrmRptUnitFoodMC.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Row := 0;
end;

procedure TfrmRptUnitFoodMC.QRExpr6Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodMC.QRExpr12Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodMC.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodMC.QRExpr13Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodMC.qrptUnitFoodBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptUnitFood.Font.Name := RptFont;
  qrptUnitFood.Font.Size := RptFntSize;
end;

end.
