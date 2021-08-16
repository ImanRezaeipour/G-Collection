unit RpFdTPrs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodType = class(TForm)
    qryPrsFood: TAdoQuery;
    qrptPrsFood: TQuickRep;
    DetailBand1: TQRBand;
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
    lbl12: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    grpPartJob: TQRGroup;
    lbl4: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lblMokhalafatPrice: TQRLabel;
    lblAllPrice: TQRLabel;
    qry: TAdoQuery;
    lbl5: TQRLabel;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    lbl13: TQRLabel;
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
    lbl10: TQRLabel;
    QRShape4: TQRShape;
    lbl9: TQRLabel;
    QRShape8: TQRShape;
    lbl8: TQRLabel;
    QRShape11: TQRShape;
    lbl7: TQRLabel;
    QRShape12: TQRShape;
    lbl6: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    lblGhazaPrice: TQRLabel;
    lblMokhalafatNo: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    lblSobhPrice: TQRLabel;
    lblGhazaNo: TQRLabel;
    lblSobhNo: TQRLabel;
    QRShape18: TQRShape;
    lblTotalAllPrice: TQRLabel;
    lblAllMokhalafatPrice: TQRLabel;
    lblAllMokhalafatNo: TQRLabel;
    lblAllGhazaPrice: TQRLabel;
    lblAllGhazaNo: TQRLabel;
    lblAllSobhPrice: TQRLabel;
    lblAllSobhNo: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
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

    allSobhNo, allGhazaNo, allMokhalafatNo : Integer;
    allSobhPrice, allGhazaPrice, allMokhalafatPrice : Currency;


    procedure SetWinF;
  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoodType.SetWinF;
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
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoodType.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsFoodType.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sobhNo, ghazaNo, mokhalafatNo : Integer;
  sobhPrice, ghazaPrice, mokhalafatPrice : Currency;
begin
  sobhNo := 0;
  ghazaNo := 0;
  mokhalafatNo := 0;
  sobhPrice := 0;
  ghazaPrice := 0;
  mokhalafatPrice := 0;

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
      MB_SOBHANEH:
      begin
        sobhNo := qry.FieldByName('C').AsInteger;
        sobhPrice := qry.FieldByName('Prc').AsCurrency;
      end;
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

  lblSobhNo.Caption := IntToStr(sobhNo);
  lblSobhPrice.Caption := Format('%m', [sobhPrice]);
  lblGhazaNo.Caption := IntToStr(ghazaNo);
  lblGhazaPrice.Caption := Format('%m', [ghazaPrice]);
  lblMokhalafatNo.Caption := IntToStr(mokhalafatNo);
  lblMokhalafatPrice.Caption := Format('%m', [mokhalafatPrice]);
  lblAllPrice.Caption := Format('%m', [sobhPrice+ghazaPrice+mokhalafatPrice]);

  allSobhNo := allSobhNo + sobhNo;
  allGhazaNo := allGhazaNo + ghazaNo;
  allMokhalafatNo := allMokhalafatNo + mokhalafatNo;
  allSobhPrice := allSobhPrice + sobhPrice;
  allGhazaPrice := allGhazaPrice + ghazaPrice;
  allMokhalafatPrice := allMokhalafatPrice + mokhalafatPrice;
end;

procedure TfrmRptPrsFoodType.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllSobhNo.Caption := IntToStr(allSobhNo);
  lblAllSobhPrice.Caption := Format('%m', [allSobhPrice]);
  lblAllGhazaNo.Caption := IntToStr(allGhazaNo);
  lblAllGhazaPrice.Caption := Format('%m', [allGhazaPrice]);
  lblAllMokhalafatNo.Caption := IntToStr(allMokhalafatNo);
  lblAllMokhalafatPrice.Caption := Format('%m', [allMokhalafatPrice]);
  lblTotalAllPrice.Caption := Format('%m', [allSobhPrice+allGhazaPrice+allMokhalafatPrice]);
end;

procedure TfrmRptPrsFoodType.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  allSobhNo := 0;
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allSobhPrice := 0;
  allGhazaPrice := 0;
  allMokhalafatPrice := 0;
end;

procedure TfrmRptPrsFoodType.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  allSobhNo := 0;
  allGhazaNo := 0;
  allMokhalafatNo := 0;
  allSobhPrice := 0;
  allGhazaPrice := 0;
  allMokhalafatPrice := 0;
end;

procedure TfrmRptPrsFoodType.qrptPrsFoodBeforePrint(
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
