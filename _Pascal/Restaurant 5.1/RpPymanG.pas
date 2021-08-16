unit RpPymanG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPeymanGroup = class(TForm)
    qryFishFood: TAdoQuery;
    qrptPeyman: TQuickRep;
    dtlRecs: TQRBand;
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
    lblRepDate: TQRLabel;
    FoodBnd: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    grpRejim: TQRGroup;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape13: TQRShape;
    lbl6: TQRLabel;
    QRShape14: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    bndSign: TQRChildBand;
    lbl10: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape16: TQRShape;
    lbl9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    lblPayNo: TQRLabel;
    lblAllPayNo: TQRLabel;
    lblPriceNo: TQRLabel;
    lblAllPriceNo: TQRLabel;
    lblLastPrc: TQRLabel;
    lblTotPrc: TQRLabel;
    lblAllTotPrc: TQRLabel;
    QRDBText1: TQRDBText;
    lblFoodNo: TQRLabel;
    lblAllFoodNo: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    grpGuest: TQRGroup;
    grpFood: TQRGroup;
    lblPrsType: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FoodBndBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure dtlRecsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFoodBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpGuestBeforePrint(Sender: TQRCustomBand;
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
    groupAsFishType : boolean;
  end;

implementation

{$R *.DFM}
procedure TfrmRptPeymanGroup.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl9.Caption := (lbl9.Caption);
  lbl10.Caption := (lbl10.Caption);
  lblName.Caption := (lblName.Caption);
  qrptPeyman.ReportTitle := (qrptPeyman.ReportTitle);
end;

procedure TfrmRptPeymanGroup.FormCreate(Sender: TObject);
begin
  SetWinF;
  grpFood.Height := 0;
  grpRejim.Height := 0;
  dtlRecs.Height := 0;
  qryFishFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
  AllPayNo := 0;
  AllPriceNo := 0;
  AllTotalPrc := 0;
  AllFoodNo := 0;
  if groupAsFishType then
    grpGuest.Expression := 'qryFishFood.fish_type';
end;

procedure TfrmRptPeymanGroup.FoodBndBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  FCode : Integer;
  p : Currency;
begin
  FCode := qryFishFood.FieldByname('FF_Food').AsInteger;
  if EDate <> '' then
    p := GetFoodPriceFeeInDate(FCode, EDate)
  else
    p := GetFoodPriceFeeInRam(FCode);

  lblPayNo.Caption := IntToStr(PayNo);
  lblPriceNo.Caption := IntToStr(PriceNo);
  if (qryFishFood.FieldByname('Food_Type').AsInteger = MB_MOKHALAFAT) and not MokhPrc then
    FoodNo := PriceNo
  else
    FoodNo := PriceNo + PayNo;

  lblFoodNo.Caption := IntToStr(FoodNo);
  lblLastPrc.Caption := Format('%m', [p]);
  lblTotPrc.Caption := Format('%m', [p * FoodNo]);

  AllFoodNo := AllFoodNo + FoodNo;
  AllTotalPrc := AllTotalPrc + (p * FoodNo);
  AllPayNo := AllPayNo + PayNo;
  AllPriceNo := AllPriceNo + PriceNo;
end;

procedure TfrmRptPeymanGroup.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  AllPayNo := 0;
  AllPriceNo := 0;
  AllTotalPrc := 0;
  AllFoodNo := 0;
end;

procedure TfrmRptPeymanGroup.dtlRecsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if qryFishFood.FieldByName('FF_Pay').AsCurrency > 0 then
    Inc(PayNo, qryFishFood.FieldByName('FF_No').AsInteger)
  else
    Inc(PriceNo, qryFishFood.FieldByName('FF_No').AsInteger);
end;

procedure TfrmRptPeymanGroup.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPayNo.Caption := IntToStr(AllPayNo);
  lblAllPriceNo.Caption := IntToStr(AllPriceNo);
  lblAllFoodNo.Caption := IntToStr(AllFoodNo);
  lblAllTotPrc.Caption := Format('%m', [AllTotalPrc]);
end;

procedure TfrmRptPeymanGroup.grpFoodBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PayNo := 0;
  PriceNo := 0;
  FoodNo := 0;
end;

procedure TfrmRptPeymanGroup.grpGuestBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if groupAsFishType then
    lblPrsType.Caption := FoodName[qryFishFood.FieldByName('fish_type').AsInteger]
  else
  if not qryFishFood.FieldByName('P_Rejim').AsBoolean and
     not qryFishFood.FieldByName('P_IsGuest').AsBoolean then
    lblPrsType.Caption := ('Å—”‰· ⁄«œÌ')
  else if qryFishFood.FieldByName('P_Rejim').AsBoolean and
          not qryFishFood.FieldByName('P_IsGuest').AsBoolean then
    lblPrsType.Caption := ('Å—”‰· —éÌ„Ì')
  else if not qryFishFood.FieldByName('P_Rejim').AsBoolean and
          qryFishFood.FieldByName('P_IsGuest').AsBoolean then
    lblPrsType.Caption := ('„ÌÂ„«‰ ⁄«œÌ')
  else
    lblPrsType.Caption := ('„ÌÂ„«‰ —éÌ„Ì');
end;

procedure TfrmRptPeymanGroup.qrptPeymanBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPeyman.Font.Name := RptFont;
  qrptPeyman.Font.Size := RptFntSize;
end;

end.
