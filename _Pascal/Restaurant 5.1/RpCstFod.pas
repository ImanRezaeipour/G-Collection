unit RpCstFod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRpCostUsedFood = class(TForm)
    qryPrsFood: TAdoQuery;
    qrptPrsFood: TQuickRep;
    dtlData: TQRBand;
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
    ColumnHeaderBand1: TQRBand;
    lbl11: TQRLabel;
    lbl15: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    grpPartJob: TQRGroup;
    lbl5: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lblMokhalafatPrs: TQRLabel;
    lblAllPrice: TQRLabel;
    qry: TAdoQuery;
    lbl6: TQRLabel;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    lbl16: TQRLabel;
    grpBarCode: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    ChildBand2: TQRChildBand;
    lblPCode: TQRLabel;
    TitleBand1: TQRBand;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lbl9: TQRLabel;
    QRShape8: TQRShape;
    lbl7: TQRLabel;
    QRShape11: TQRShape;
    QRShape15: TQRShape;
    lblGhazaPrs: TQRLabel;
    QRShape16: TQRShape;
    lblGhazaNo: TQRLabel;
    QRShape18: TQRShape;
    lblTotalAllPrice: TQRLabel;
    lblAllMokhalafatPrs: TQRLabel;
    lblAllGhazaPrs: TQRLabel;
    lblAllGhazaNo: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    lbl4: TQRLabel;
    QRShape4: TQRShape;
    lblRow: TQRLabel;
    lbl8: TQRLabel;
    QRShape12: TQRShape;
    lbl10: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    lblGhazaPeyman: TQRLabel;
    lblMokhalafat: TQRLabel;
    QRShape17: TQRShape;
    QRShape19: TQRShape;
    lblAllGhazaPeyman: TQRLabel;
    QRShape20: TQRShape;
    lblAllMokhalafat: TQRLabel;
    lbl14: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    lbl12: TQRLabel;
    lbl13: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    lblMokhalafatPeyman: TQRLabel;
    QRShape27: TQRShape;
    lblPrs: TQRLabel;
    QRShape28: TQRShape;
    lblPeyman: TQRLabel;
    QRShape29: TQRShape;
    lblAllMokhalafatPeyman: TQRLabel;
    QRShape30: TQRShape;
    lblAllPrs: TQRLabel;
    QRShape31: TQRShape;
    lblAllPeyman: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure dtlDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    allGhazaNo, allMokhalafatNo : Integer;
    allGhazaPrs, allGhazaPeyman,
    allMokhalafatPrs, allMokhalafatPeyman : Currency;


    procedure SetWinF;
  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
    row : Integer;
  end;

implementation

{$R *.DFM}

procedure TfrmRpCostUsedFood.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
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
  lbl11.Caption := (lbl11.Caption);
  lbl12.Caption := (lbl12.Caption);
  lbl13.Caption := (lbl13.Caption);
  lbl14.Caption := (lbl14.Caption);
  lbl15.Caption := (lbl15.Caption);
  lbl16.Caption := (lbl16.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRpCostUsedFood.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRpCostUsedFood.dtlDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  ghazaNo, mokhalafatNo : Integer;
  ghazaPrs, ghazaPeyman,
  mokhalafatPrs, mokhalafatPeyman  : Currency;
  prc : TPrice;
begin
  ghazaNo := 0;
  mokhalafatNo := 0;
  ghazaPrs:= 0;
  ghazaPeyman := 0;
  mokhalafatPrs := 0;
  mokhalafatPeyman := 0;

  Inc(row);
  lblRow.Caption := IntToStr(row);
  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
  qry.SQL.Clear;
  qry.SQL.Add('SELECT FF_Food, FF_Date, FF_No, Food_Type FROM Fish, FishFood, FoodList');
  qry.SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
  qry.SQL.Add('AND FF_Food = Food_Code');
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFood.FieldByName('P_BarCode').AsString + '''');
  qry.SQL.Add('AND FF_Date >= ''' + StartDate + '''');
  qry.SQL.Add('AND FF_Date <= ''' + EndDate + '''');
  if not Sobh_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
  if not Nahar_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
  if not Sham_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));
  qry.SQL.Add('ORDER BY Food_Type');
  qry.Open;

  while not qry.Eof do
  begin
    case qry.FieldByName('Food_Type').AsInteger of
      MB_GHAZA:
      begin
        ghazaNo := ghazaNo + qry.FieldByName('FF_No').AsInteger;
        prc := GetFoodPriceInDB(qry.FieldByName('FF_Food').AsInteger, qry.FieldByName('FF_Date').AsString);
        ghazaPrs := ghazaPrs + (prc.PricePerson * qry.FieldByName('FF_No').AsInteger);
        ghazaPeyman := ghazaPeyman + (prc.PriceFee * qry.FieldByName('FF_No').AsInteger);
      end;

      MB_MOKHALAFAT:
      begin
        mokhalafatNo := mokhalafatNo + qry.FieldByName('FF_No').AsInteger;
        prc := GetFoodPriceInDB(qry.FieldByName('FF_Food').AsInteger, qry.FieldByName('FF_Date').AsString);
        mokhalafatPrs := mokhalafatPrs + (prc.PricePerson * qry.FieldByName('FF_No').AsInteger);
        mokhalafatPeyman := mokhalafatPeyman + (prc.PriceFee * qry.FieldByName('FF_No').AsInteger);
      end;
    end;
    qry.Next;
  end;
  qry.Close;

  lblGhazaNo.Caption := IntToStr(ghazaNo);
  lblGhazaPrs.Caption := Format('%m', [ghazaPrs]);
  lblGhazaPeyman.Caption := Format('%m', [ghazaPeyman]);

  lblMokhalafat.Caption := IntToStr(mokhalafatNo);
  lblMokhalafatPrs.Caption := Format('%m', [mokhalafatPrs]);
  lblMokhalafatPeyman.Caption := Format('%m', [mokhalafatPeyman]);

  lblPrs.Caption := Format('%m', [ghazaPrs + mokhalafatPrs]);
  lblPeyman.Caption := Format('%m', [ghazaPeyman + mokhalafatPeyman]);
  lblAllPrice.Caption := Format('%m', [ghazaPrs+ghazaPeyman+mokhalafatPrs+mokhalafatPeyman]);

  allGhazaNo := allGhazaNo + ghazaNo;
  allMokhalafatNo := allMokhalafatNo + mokhalafatNo;
  allGhazaPrs := allGhazaPrs + ghazaPrs;
  allGhazaPeyman := allGhazaPeyman + ghazaPeyman;
  allMokhalafatPrs := allMokhalafatPrs + mokhalafatPrs;
  allMokhalafatPeyman := allMokhalafatPeyman + mokhalafatPeyman;
end;

procedure TfrmRpCostUsedFood.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllGhazaNo.Caption := IntToStr(allGhazaNo);
  lblAllGhazaPrs.Caption := Format('%m', [allGhazaPrs]);
  lblAllGhazaPeyman.Caption := Format('%m', [allGhazaPeyman]);
  lblAllMokhalafat.Caption := IntToStr(allMokhalafatNo);
  lblAllMokhalafatPrs.Caption := Format('%m', [allMokhalafatPrs]);
  lblAllMokhalafatPeyman.Caption := Format('%m', [allMokhalafatPeyman]);
  lblAllPrs.Caption := Format('%m', [allGhazaPrs+allMokhalafatPrs]);
  lblAllPeyman.Caption := Format('%m', [allGhazaPeyman+allMokhalafatPeyman]);
  lblTotalAllPrice.Caption := Format('%m', [allGhazaPrs+allGhazaPeyman+allMokhalafatPrs+allMokhalafatPeyman]);
end;

procedure TfrmRpCostUsedFood.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allGhazaPrs := 0;
  allGhazaPeyman := 0;
  allMokhalafatPrs := 0;
  allMokhalafatPeyman := 0;
  row := 0;
end;

procedure TfrmRpCostUsedFood.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allGhazaPrs := 0;
  allGhazaPeyman := 0;
  allMokhalafatPrs := 0;
  allMokhalafatPeyman := 0;
end;

procedure TfrmRpCostUsedFood.qrptPrsFoodBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFood.Font.Name := RptFont;
  qrptPrsFood.Font.Size := RptFntSize;

end;

end.
