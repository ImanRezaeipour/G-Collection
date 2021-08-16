unit RpMvdTbk;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptMavadTabkh = class(TForm)
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
    grpRejim: TQRGroup;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape13: TQRShape;
    lbl6: TQRLabel;
    QRShape15: TQRShape;
    lbl7: TQRLabel;
    bndSign: TQRChildBand;
    lbl8: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape16: TQRShape;
    lblMavadTabkh: TQRLabel;
    lblTotMavadTabkh: TQRLabel;
    lblPrcnt: TQRLabel;
    QRDBText1: TQRDBText;
    lblFoodNo: TQRLabel;
    lblAllFoodNo: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    grpPub: TQRGroup;
    grpFood: TQRGroup;
    lblPrsType: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FoodBndBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure dtlRecsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFoodBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPubBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    { Private declarations }
    foodNo,
    allFoodNo : Integer;
    allMavadTabkh : Currency;

    procedure SetWinF;

  public
    { Public declarations }

    Prcnt : Single;
    EDate : String;
  end;

implementation

{$R *.DFM}
procedure TfrmRptMavadTabkh.SetWinF;
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
  lblName.Caption := (lblName.Caption);
  qrptPeyman.ReportTitle := (qrptPeyman.ReportTitle);
end;

procedure TfrmRptMavadTabkh.FormCreate(Sender: TObject);
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

  foodNo := 0;
  allFoodNo := 0;
  allMavadTabkh := 0;
end;

procedure TfrmRptMavadTabkh.grpPubBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if grpRejim.Enabled then
  begin
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
  end
  else
    lblPrsType.Caption := qryFishFood.FieldByName('Unit_Name').AsString;
end;

procedure TfrmRptMavadTabkh.grpFoodBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  foodNo := 0;
end;

procedure TfrmRptMavadTabkh.dtlRecsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(foodNo, qryFishFood.FieldByName('FF_No').AsInteger);
end;

procedure TfrmRptMavadTabkh.FoodBndBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  FCode : Integer;
  p, allP : Currency;
begin
  FCode := qryFishFood.FieldByname('FF_Food').AsInteger;
  if EDate <> '' then
    p := GetFoodPriceFeeInDate(FCode, EDate)
  else
    p := GetFoodPriceFeeInRam(FCode);

  lblFoodNo.Caption := IntToStr(foodNo);
  allFoodNo := allFoodNo + foodNo;

  p := p * Prcnt / 100;
  lblPrcnt.Caption := Format('%m', [p]);

  allP := foodNo * p;
  allMavadTabkh := allMavadTabkh + allP;
  lblMavadTabkh.Caption := Format('%m', [allP]);
end;

procedure TfrmRptMavadTabkh.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllFoodNo.Caption := IntToStr(allFoodNo);
  lblTotMavadTabkh.Caption := Format('%m', [allMavadTabkh]);
end;

procedure TfrmRptMavadTabkh.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  foodNo := 0;
  allFoodNo := 0;
  allMavadTabkh := 0;
end;

end.
