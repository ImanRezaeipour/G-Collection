unit RpPymanU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPeymanUnit = class(TForm)
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
    grpUnits: TQRGroup;
    QRShape2: TQRShape;
    lblPayNo: TQRLabel;
    lblPriceNo: TQRLabel;
    lblLastPrc: TQRLabel;
    lblTotPrc: TQRLabel;
    QRDBText1: TQRDBText;
    lblFoodNo: TQRLabel;
    grpFood: TQRGroup;
    bndAll: TQRBand;
    lblAllTotPrc: TQRLabel;
    QRShape3: TQRShape;
    QRShape10: TQRShape;
    lblAllFoodNo: TQRLabel;
    QRShape9: TQRShape;
    lblAllPriceNo: TQRLabel;
    lblAllPayNo: TQRLabel;
    QRShape11: TQRShape;
    QRShape16: TQRShape;
    lbl10: TQRLabel;
    QRDBText2: TQRDBText;
    ChildBand2: TQRChildBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape13: TQRShape;
    lbl6: TQRLabel;
    QRShape14: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    lbl9: TQRLabel;
    QRShape1: TQRShape;
    bndSign: TQRChildBand;
    lbl11: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FoodBndBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure dtlRecsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpUnitsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrptPeymanBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    PayNo, PriceNo,
    AllPayNo, AllPriceNo,
    FoodNo, AllFoodNo : Integer;
    mabalegh,lastmablagh : currency;
    AllTotalPrc : Currency;

    procedure SetWinF;

  public
    { Public declarations }

    MokhPrc : Boolean;
  end;

implementation

{$R *.DFM}
procedure TfrmRptPeymanUnit.SetWinF;
begin
end;

procedure TfrmRptPeymanUnit.FormCreate(Sender: TObject);
begin
  SetWinF;
  grpFood.Height := 0;
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
  mabalegh:=0;
end;

procedure TfrmRptPeymanUnit.FoodBndBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  FCode : Integer;
  p : Currency;
begin
  FCode := qryFishFood.FieldByname('FF_Food').AsInteger;
//  p := qryFishFood.FieldByname('FF_price').AsInteger;
  p := GetFoodPriceFeeInRam(FCode);

  lblPayNo.Caption := IntToStr(PayNo);
  lblPriceNo.Caption := IntToStr(PriceNo);
  if (qryFishFood.FieldByname('Food_Type').AsInteger = MB_MOKHALAFAT) and not MokhPrc then
    FoodNo := PriceNo
  else
    FoodNo := PriceNo + PayNo;

  lblFoodNo.Caption := IntToStr(FoodNo);
//  lblLastPrc.Caption := Format('%m', [p]);
  lblLastPrc.Caption := Format('%m', [lastmablagh]);
//  lblTotPrc.Caption := Format('%m', [p * FoodNo]);
  lblTotPrc.Caption := Format('%m', [mabalegh]);
  AllFoodNo := AllFoodNo + FoodNo;
  AllTotalPrc := AllTotalPrc + mabalegh; //(p * FoodNo);
  AllPayNo := AllPayNo + PayNo;
  AllPriceNo := AllPriceNo + PriceNo;
  mabalegh:=0;
end;

procedure TfrmRptPeymanUnit.dtlRecsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  mablagh,mablaghs : currency;
  tedad : integer;
begin
  if qryFishFood.FieldByName('FF_Pay').AsCurrency > 0
  then begin
    Inc(PayNo, qryFishFood.FieldByName('FF_No').AsInteger);
    tedad:=qryFishFood.FieldByName('FF_No').AsInteger;
//    mablagh:=qryFishFood.FieldByName('FF_price').Ascurrency;
    mablagh:=GetFoodPriceInDB(qryFishFood.FieldByName('Food_code').AsInteger,qryFishFood.FieldByName('FF_date').Asstring).PriceFee;
    mablaghs:=mablagh*tedad;
    mablaghs:=mablagh*tedad;
  end
  else begin
    Inc(PriceNo, qryFishFood.FieldByName('FF_No').AsInteger);
    tedad:=qryFishFood.FieldByName('FF_No').AsInteger;
//    mablagh:=qryFishFood.FieldByName('FF_price').Ascurrency;
    mablagh:=GetFoodPriceInDB(qryFishFood.FieldByName('Food_code').AsInteger,qryFishFood.FieldByName('FF_date').Asstring).PriceFee;
    mablaghs:=mablagh*tedad;
    lastmablagh:=mablagh;
  end;
  mabalegh:=mabalegh+mablaghs;
end;

procedure TfrmRptPeymanUnit.grpUnitsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PayNo := 0;
  PriceNo := 0;
  FoodNo := 0;
end;

procedure TfrmRptPeymanUnit.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPayNo.Caption := IntToStr(AllPayNo);
  lblAllPriceNo.Caption := IntToStr(AllPriceNo);
  lblAllFoodNo.Caption := IntToStr(AllFoodNo);
  lblAllTotPrc.Caption := Format('%m', [AllTotalPrc]);
end;

procedure TfrmRptPeymanUnit.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  AllPayNo := 0;
  AllPriceNo := 0;
  AllTotalPrc := 0;
  AllFoodNo := 0;
  mabalegh:=0;
end;

procedure TfrmRptPeymanUnit.qrptPeymanBeforePrint(Sender: TCustomQuickRep;
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
