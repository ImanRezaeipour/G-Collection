unit RpFdMkPr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodMokhalafat = class(TForm)
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
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    grpPartJob: TQRGroup;
    lbl5: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lblMokhalafatPrice: TQRLabel;
    lblAllPrice: TQRLabel;
    qry: TAdoQuery;
    lbl6: TQRLabel;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    lbl11: TQRLabel;
    grpBarCode: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    lblPCode: TQRLabel;
    TitleBand1: TQRBand;
    lbl8: TQRLabel;
    QRShape8: TQRShape;
    lbl7: TQRLabel;
    QRShape11: TQRShape;
    QRShape15: TQRShape;
    lblGhazaPrice: TQRLabel;
    QRShape16: TQRShape;
    lblGhazaNo: TQRLabel;
    QRShape18: TQRShape;
    lblTotalAllPrice: TQRLabel;
    lblAllMokhalafatPrice: TQRLabel;
    lblAllGhazaPrice: TQRLabel;
    lblAllGhazaNo: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    lbl4: TQRLabel;
    QRShape4: TQRShape;
    lblRow: TQRLabel;
    QRBand1: TQRBand;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel1: TQRLabel;
    lblTotalAllPriceS: TQRLabel;
    lblAllMokhalafatPrices: TQRLabel;
    lblAllGhazaPrices: TQRLabel;
    QRShape14: TQRShape;
    QRShape17: TQRShape;
    lblAllGhazaNoS: TQRLabel;
    ChildBand2: TQRChildBand;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
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
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

    allGhazaNo, allMokhalafatNo : Integer;
    allGhazaPrice, allMokhalafatPrice : Currency;

    allGhazaNoS, allMokhalafatNoS : Integer;
    allGhazaPriceS, allMokhalafatPriceS : Currency;


  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
    row : Integer;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoodMokhalafat.FormCreate(Sender: TObject);
begin
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsFoodMokhalafat.dtlDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  ghazaNo, mokhalafatNo : Integer;
  ghazaPrice, mokhalafatPrice : Currency;
begin
  ghazaNo := 0;
  mokhalafatNo := 0;
  ghazaPrice := 0;
  mokhalafatPrice := 0;

  Inc(row);
  lblRow.Caption := IntToStr(row);

  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
  qry.SQL.Clear;
  qry.SQL.Add('SELECT SUM(FF_Price) AS Prc, COUNT(Food_Type) As C, Food_Type FROM Fish, FishFood, FoodList');
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
  qry.SQL.Add('GROUP BY Food_Type');
  qry.SQL.Add('ORDER BY Food_Type');
  qry.Open;

  while not qry.Eof do
  begin
    case qry.FieldByName('Food_Type').AsInteger of
      MB_GHAZA:
      begin
        ghazaNo := qry.FieldByName('C').AsInteger;
        ghazaPrice := qry.FieldByName('Prc').AsCurrency;
      end;
      MB_MOKHALAFAT:
      begin
        mokhalafatNo := qry.FieldByName('C').AsInteger;
        mokhalafatPrice := qry.FieldByName('Prc').AsCurrency;
      end;
    end;
    qry.Next;
  end;
  qry.Close;

  lblGhazaNo.Caption := IntToStr(ghazaNo);
  lblGhazaPrice.Caption := Format('%m', [ghazaPrice]);
  lblMokhalafatPrice.Caption := Format('%m', [mokhalafatPrice]);
  lblAllPrice.Caption := Format('%m', [ghazaPrice+mokhalafatPrice]);

  allGhazaNo := allGhazaNo + ghazaNo;
  allMokhalafatNo := allMokhalafatNo + mokhalafatNo;
  allGhazaPrice := allGhazaPrice + ghazaPrice;
  allMokhalafatPrice := allMokhalafatPrice + mokhalafatPrice;
end;

procedure TfrmRptPrsFoodMokhalafat.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  allGhazaNoS := allGhazaNoS + allGhazaNo;
  allGhazaPriceS := allGhazaPriceS + allGhazaPrice;
  allMokhalafatPriceS := allMokhalafatPriceS + allMokhalafatPrice;

  lblAllGhazaNo.Caption := IntToStr(allGhazaNo);
  lblAllGhazaPrice.Caption := Format('%m', [allGhazaPrice]);
  lblAllMokhalafatPrice.Caption := Format('%m', [allMokhalafatPrice]);
  lblTotalAllPrice.Caption := Format('%m', [allGhazaPrice+allMokhalafatPrice]);
end;

procedure TfrmRptPrsFoodMokhalafat.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allGhazaPrice := 0;
  allMokhalafatPrice := 0;
  row := 0;
end;

procedure TfrmRptPrsFoodMokhalafat.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allGhazaPrice := 0;
  allMokhalafatPrice := 0;
  allGhazaNoS := 0;
  allMokhalafatNoS := 0;
  allGhazaPriceS := 0;
  allMokhalafatPriceS := 0;

end;

procedure TfrmRptPrsFoodMokhalafat.qrptPrsFoodBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;

  QRBand1.Font.Name := RptTitleFont;
  QRBand1.Font.Size := RptTitleFntSize;

  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFood.Font.Name := RptFont;
  qrptPrsFood.Font.Size := RptFntSize;

end;

procedure TfrmRptPrsFoodMokhalafat.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblAllGhazaNoS.Caption := IntToStr(allGhazaNoS);
  lblAllGhazaPriceS.Caption := Format('%m', [allGhazaPriceS]);
  lblAllMokhalafatPriceS.Caption := Format('%m', [allMokhalafatPriceS]);
  lblTotalAllPriceS.Caption := Format('%m', [allGhazaPriceS+allMokhalafatPriceS]);
end;

end.
