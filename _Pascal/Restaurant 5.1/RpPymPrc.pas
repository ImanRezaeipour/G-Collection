unit RpPymPrc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPymnPrcntGrp = class(TForm)
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
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    grpRejim: TQRGroup;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape14: TQRShape;
    lbl6: TQRLabel;
    QRShape15: TQRShape;
    lbl7: TQRLabel;
    bndSign: TQRChildBand;
    lbl9: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape16: TQRShape;
    lblMavadPrc: TQRLabel;
    lblTotMavadPrc: TQRLabel;
    lblTabkhPrc: TQRLabel;
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
    lblTotTabkhPrc: TQRLabel;
    QRShape1: TQRShape;
    lbl8: TQRLabel;
    lblTotal: TQRLabel;
    QRShape2: TQRShape;
    lblAllTotal: TQRLabel;
    QRShape3: TQRShape;
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
    procedure qrptPeymanBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    foodNo,
    allFoodNo : Integer;
    allMavadPrc,
    allTabkhPrc : Currency;

    procedure SetWinF;

  public
    { Public declarations }

    mavadPrcnt, tabkhPrcnt : Single;
    EDate : String;
  end;

implementation

{$R *.DFM}
procedure TfrmRptPymnPrcntGrp.SetWinF;
begin
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl9.Caption := (lbl9.Caption);
end;

procedure TfrmRptPymnPrcntGrp.FormCreate(Sender: TObject);
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
end;

procedure TfrmRptPymnPrcntGrp.grpPubBeforePrint(Sender: TQRCustomBand;
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

procedure TfrmRptPymnPrcntGrp.grpFoodBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  foodNo := 0;
end;

procedure TfrmRptPymnPrcntGrp.dtlRecsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(foodNo, qryFishFood.FieldByName('FF_No').AsInteger);
end;

procedure TfrmRptPymnPrcntGrp.FoodBndBeforePrint(Sender: TQRCustomBand;
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

  allP := p * foodNo;
  lblTotal.Caption := Format('%m', [allP]);

  p := allP * mavadPrcnt / 100;
  allMavadPrc := allMavadPrc + p;
  lblMavadPrc.Caption := Format('%m', [p]);

  p := allP * tabkhPrcnt / 100;
  allTabkhPrc := allTabkhPrc + p;
  lblTabkhPrc.Caption := Format('%m', [p]);

end;

procedure TfrmRptPymnPrcntGrp.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllFoodNo.Caption := IntToStr(allFoodNo);
  lblTotMavadPrc.Caption := Format('%m', [allMavadPrc]);
  lblTotTabkhPrc.Caption := Format('%m', [allTabkhPrc]);
  lblAllTotal.Caption := Format('%m', [allMavadPrc + allTabkhPrc]);
end;

procedure TfrmRptPymnPrcntGrp.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  foodNo := 0;
  allFoodNo := 0;
  allMavadPrc := 0;
  allTabkhPrc := 0;
end;

procedure TfrmRptPymnPrcntGrp.qrptPeymanBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPeyman.Font.Name := RptFont;
  qrptPeyman.Font.Size := RptFntSize;
end;

end.
