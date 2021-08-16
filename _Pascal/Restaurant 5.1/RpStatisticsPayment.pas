unit RpStatisticsPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptStatisticsPayment = class(TForm)
    qrptPeyman: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    FoodBnd: TQRBand;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape14: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    bndSign: TQRChildBand;
    lbl9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRDBText1: TQRDBText;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lblRepDate: TQRLabel;
    bndAll: TQRBand;
    lbl10: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape3: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    qryStatisticsPayment: TADOQuery;
    grp: TQRGroup;
    QRShape28: TQRShape;
    lblGroup: TQRLabel;
    txtCode: TQRDBText;
    QRShape27: TQRShape;
    QRShape7: TQRShape;
    QRShape29: TQRShape;
    lblRepBuilding: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure FoodBndBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure dtlRecsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFoodBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPeymanBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    PayNo, PriceNo,
    AllPayNo, AllPriceNo,
    FoodNo, AllFoodNo : Integer;
    AllTotalPrc : Currency;

    procedure SetWinF;

  public
    { Public declarations }

    MokhPrc : Boolean;
    EDate : String;
  end;

implementation

{$R *.DFM}
procedure TfrmRptStatisticsPayment.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
//  lbl5.Caption := (lbl5.Caption);
//  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl9.Caption := (lbl9.Caption);
  lbl10.Caption := (lbl10.Caption);
  lblName.Caption := (lblName.Caption);
  qrptPeyman.ReportTitle := (qrptPeyman.ReportTitle);
end;

procedure TfrmRptStatisticsPayment.FormCreate(Sender: TObject);
begin
  SetWinF;
//  grpFood.Height := 0;
//  dtlRecs.Height := 0;
  qryStatisticsPayment.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
  AllPayNo := 0;
  AllPriceNo := 0;
  AllTotalPrc := 0;
  AllFoodNo := 0;
end;

procedure TfrmRptStatisticsPayment.FoodBndBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  FCode : Integer;
  p : Currency;
begin
{
  FCode := qryStatisticsPayment.FieldByname('FF_Food').AsInteger;
  if EDate <> '' then
    p := GetFoodPriceFeeInDate(FCode, EDate)
  else
    p := GetFoodPriceFeeInRam(FCode);

//  lblPayNo.Caption := IntToStr(PayNo);
//  lblPriceNo.Caption := IntToStr(PriceNo);
  if (qryStatisticsPayment.FieldByname('Food_Type').AsInteger = MB_MOKHALAFAT) and not MokhPrc then
    FoodNo := PriceNo
  else
    FoodNo := PriceNo + PayNo;

//  lblFoodNo.Caption := IntToStr(FoodNo);
//  lblLastPrc.Caption := Format('%m', [p]);
//  lblTotPrc.Caption := Format('%m', [p * FoodNo]);

  AllFoodNo := AllFoodNo + FoodNo;
  AllTotalPrc := AllTotalPrc + (p * FoodNo);
  AllPayNo := AllPayNo + PayNo;
  AllPriceNo := AllPriceNo + PriceNo;
}
end;

procedure TfrmRptStatisticsPayment.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
{
  AllPayNo := 0;
  AllPriceNo := 0;
  AllTotalPrc := 0;
  AllFoodNo := 0;
}
end;

procedure TfrmRptStatisticsPayment.dtlRecsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
  if qryStatisticsPayment.FieldByName('FF_Pay').AsCurrency > 0 then
    Inc(PayNo, qryStatisticsPayment.FieldByName('FF_No').AsInteger)
  else
    Inc(PriceNo, qryStatisticsPayment.FieldByName('FF_No').AsInteger);
}
end;

procedure TfrmRptStatisticsPayment.grpFoodBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
  PayNo := 0;
  PriceNo := 0;
  FoodNo := 0;
}
end;

procedure TfrmRptStatisticsPayment.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
  lblAllPayNo.Caption := IntToStr(AllPayNo);
  lblAllPriceNo.Caption := IntToStr(AllPriceNo);
  lblAllFoodNo.Caption := IntToStr(AllFoodNo);
  lblAllTotPrc.Caption := Format('%m', [AllTotalPrc]);
}
end;

procedure TfrmRptStatisticsPayment.qrptPeymanBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPeyman.Font.Name := RptFont;
  qrptPeyman.Font.Size := RptFntSize;
  lblRepBuilding.Font.Name := RptTitleFont;
  lblRepBuilding.Font.Size := RptTitleFntSize;
end;

end.
