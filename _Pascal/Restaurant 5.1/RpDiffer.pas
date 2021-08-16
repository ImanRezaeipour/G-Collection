unit RpDiffer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc,
  DBS_Proc;

type
  TfrmRptDiffer = class(TForm)
    qryDiffer: TAdoQuery;
    qrptDiffer: TQuickRep;
    grpType: TQRGroup;
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
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    grpFood: TQRGroup;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    exprCount: TQRExpr;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRBand2: TQRBand;
    lblVadeh: TQRLabel;
    lblGrpDate: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRDBText1: TQRDBText;
    QRLabel6: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    ChildBand2: TQRChildBand;
    QRLabel7: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel8: TQRLabel;
    QRShape14: TQRShape;
    lblPercent: TQRLabel;
    QRShape15: TQRShape;
    QRShape1: TQRShape;
    QRShape16: TQRShape;
    lblN_Food: TQRLabel;
    lblCost: TQRLabel;
    lblPercentPrice: TQRLabel;
    lblPayAble: TQRLabel;
    lblFee: TQRLabel;
    QRShape11: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape17: TQRShape;
    lblUsePrice: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    lblDiffPrice: TQRLabel;
    QRShape2: TQRShape;
    lblGrpCost: TQRLabel;
    QRShape5: TQRShape;
    QRShape22: TQRShape;
    QRExpr2: TQRExpr;
    QRShape23: TQRShape;
    lblGrpUsePrice: TQRLabel;
    lblGrpDiffPrice: TQRLabel;
    lblGrpPercentPrice: TQRLabel;
    lblGrpPayAble: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRShape24: TQRShape;
    lblAllCost: TQRLabel;
    QRShape25: TQRShape;
    QRExpr1: TQRExpr;
    lblAllPayAble: TQRLabel;
    QRShape26: TQRShape;
    lblAllPercentPrice: TQRLabel;
    QRShape27: TQRShape;
    lblAllDiffPrice: TQRLabel;
    QRShape28: TQRShape;
    lblAllUsePrice: TQRLabel;
    QRShape29: TQRShape;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure grpTypeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ColumnHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptDifferBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    GrpCostPrc, GrpUsedPrc, GrpDiffprc, GrpPrcentPrc, GrpPayAble : Currency;
    AllCostPrc, AllUsedPrc, AllDiffprc, AllPrcentPrc, AllPayAble : Currency;

    procedure SetWinF;
  public
    { Public declarations }
    Percent : Real;
  end;

implementation

{$R *.DFM}

procedure TfrmRptDiffer.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  lblRepDate.Caption := (lblRepDate.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  lblGrpDate.Caption := (lblGrpDate.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  lblName.Caption := (lblName.Caption);
  qrptDiffer.ReportTitle := (qrptDiffer.ReportTitle);
end;

procedure TfrmRptDiffer.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryDiffer.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

  AllCostPrc := 0;
  AllUsedPrc := 0;
  AllDiffprc := 0;
  AllPrcentPrc := 0;
  AllPayAble :=0;
end;

procedure TfrmRptDiffer.ColumnHeaderBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPercent.Caption := (FloatToStr(Percent) + ' œ—’œ «Œ ·«›');
end;

procedure TfrmRptDiffer.grpTypeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  GrpCostPrc := 0;
  GrpUsedPrc := 0;
  GrpDiffprc := 0;
  GrpPrcentPrc := 0;
  GrpPayAble :=0;

  lblVadeh.Caption := (FoodName[qryDiffer.FieldByName('FF_Type').AsInteger]);
end;

procedure TfrmRptDiffer.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Amar : Integer;
  Fee, CostPrc, UsedPrc, Diffprc, PrcentPrc, PayAble : Currency;
begin
  Amar := GetFoodAmar(qryDiffer.FieldByName('FF_Food').AsInteger,
                      qryDiffer.FieldByName('FF_Type').AsInteger,
                      qryDiffer.FieldByName('FF_Date').AsString);

  Fee := GetFoodPriceFeeInDate(qryDiffer.FieldByName('FF_Food').AsInteger,
                               qryDiffer.FieldByName('FF_Date').AsString);
  CostPrc := Fee * Amar;
  UsedPrc := Fee * exprCount.Value.intResult;
  DiffPrc := CostPrc - UsedPrc;
  PrcentPrc := DiffPrc * Percent / 100;
  PayAble := UsedPrc + PrcentPrc;

  GrpCostPrc := GrpCostPrc + CostPrc;
  GrpUsedPrc := GrpUsedPrc + UsedPrc;
  GrpDiffprc := GrpDiffprc + Diffprc;
  GrpPrcentPrc := GrpPrcentPrc + PrcentPrc;
  GrpPayAble := GrpPayAble + PayAble;

  lblFee.Caption := Format('%m', [Fee]);
  lblN_Food.Caption := (IntToStr(Amar));
  lblCost.Caption := Format('%m', [CostPrc]);
  lblUseprice.Caption := Format('%m', [UsedPrc]);
  lblDiffprice.Caption := Format('%m', [DiffPrc]);
  lblPercentPrice.Caption := Format('%m', [PrcentPrc]);
  lblPayAble.Caption := Format('%m', [PayAble]);
end;

procedure TfrmRptDiffer.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AllCostPrc := GrpCostPrc + AllCostPrc;
  AllUsedPrc := GrpUsedPrc + AllUsedPrc;
  AllDiffprc := GrpDiffprc + AllDiffprc;
  AllPrcentPrc := GrpPrcentPrc + AllPrcentPrc;
  AllPayAble := GrpPayAble + AllPayAble;

  lblGrpCost.Caption := Format('%m', [GrpCostPrc]);
  lblGrpUseprice.Caption := Format('%m', [GrpUsedPrc]);
  lblGrpDiffprice.Caption := Format('%m', [GrpDiffPrc]);
  lblGrpPercentPrice.Caption := Format('%m', [GrpPrcentPrc]);
  lblGrpPayAble.Caption := Format('%m', [GrpPayAble]);
end;

procedure TfrmRptDiffer.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllCost.Caption := Format('%m', [AllCostPrc]);
  lblAllUseprice.Caption := Format('%m', [AllUsedPrc]);
  lblAllDiffprice.Caption := Format('%m', [AllDiffPrc]);
  lblAllPercentPrice.Caption := Format('%m', [AllPrcentPrc]);
  lblAllPayAble.Caption := Format('%m', [AllPayAble]);
end;

procedure TfrmRptDiffer.qrptDifferBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptDiffer.Font.Name := RptFont;
  qrptDiffer.Font.Size := RptFntSize;

end;

end.
