unit RpYearFd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptYearFdMkh = class(TForm)
    qryFishPrs: TAdoQuery;
    qrptFoodMonth: TQuickRep;
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
    ColumnHeaderBand1: TQRBand;
    lbl5: TQRLabel;
    lbl6: TQRLabel;
    lbl7: TQRLabel;
    lbl8: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape7: TQRShape;
    lbl4: TQRLabel;
    QRShape4: TQRShape;
    bndTotal: TQRBand;
    lbl15: TQRLabel;
    lbl13: TQRLabel;
    lbl14: TQRLabel;
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    lbl12: TQRLabel;
    grpMonth: TQRGroup;
    grpGuest: TQRGroup;
    bndresult: TQRBand;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape14: TQRShape;
    QRShape13: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    lblMonth: TQRLabel;
    lblNNo: TQRLabel;
    lblNPay: TQRLabel;
    lblNPrice: TQRLabel;
    lblGPrice: TQRLabel;
    lblGPay: TQRLabel;
    lblGNo: TQRLabel;
    lblTNo: TQRLabel;
    lblTCost: TQRLabel;
    qry: TAdoQuery;
    bndGuest: TQRBand;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lbl16: TQRLabel;
    lblTNNo: TQRLabel;
    lblTNPay: TQRLabel;
    lblTNPrice: TQRLabel;
    lblTGNo: TQRLabel;
    lblTGPay: TQRLabel;
    lblTGPrice: TQRLabel;
    lblTTNo: TQRLabel;
    lblTTCost: TQRLabel;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    TitleBand1: TQRBand;
    procedure FormCreate(Sender: TObject);
    procedure bndresultBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpMonthBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpGuestBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptFoodMonthBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    nNo, gNo,
    tNNo, tGNo : Integer;
    nPay, nPrice,
    gPay, gPrice,
    tNPay, tNPrice,
    tGPay, tGPrice : Currency;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptYearFdMkh.SetWinF;
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
  qrptFoodMonth.ReportTitle := (qrptFoodMonth.ReportTitle);
end;

procedure TfrmRptYearFdMkh.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryFishPrs.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

  tNNo := 0;
  tGNo := 0;
  tNPay := 0;
  tNPrice := 0;
  tGPay := 0;
  tGPrice := 0;
end;

procedure TfrmRptYearFdMkh.bndresultBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var m : Byte;
begin
  if qryFishPrs.FieldByName('FF_Date').AsString <> '' then
  begin
    m := StrToInt(Copy(qryFishPrs.FieldByName('FF_Date').AsString, 6, 2));
    lblMonth.Caption := MonthName[m];
  end
  else
    lblMonth.Caption := '';

  lblNNo.Caption := IntToStr(nNo);
  lblNPay.Caption := Format('%m', [nPay]);
  lblNPrice.Caption := Format('%m', [nPrice]);

  lblGNo.Caption := IntToStr(gNo);
  lblGPay.Caption := Format('%m', [gPay]);
  lblGPrice.Caption := Format('%m', [gPrice]);

  lblTNo.Caption := IntToStr(nNo + gNo);
  lblTCost.Caption := Format('%m', [nPay+nPrice + gPay+gPrice]);

  tNNo := tNNo + nNo;
  tGNo := tGNo + gNo;
  tNPay := tNPay + nPay;
  tNPrice := tNPrice + nPrice;
  tGPay := tGPay + gPay;
  tGPrice := tGPrice + gPrice;
end;

procedure TfrmRptYearFdMkh.grpMonthBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  nNo := 0;
  gNo := 0;
  nPay := 0;
  nPrice := 0;
  gPay := 0;
  gPrice := 0;
end;

procedure TfrmRptYearFdMkh.grpGuestBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var sDate, eDate : String;
begin
  sDate := Copy(qryFishPrs.FieldByName('FF_Date').AsString, 1, 8) + '01';
  eDate := Copy(qryFishPrs.FieldByName('FF_Date').AsString, 1, 8) + '31';
  qry.SQL.Clear;
  qry.SQL.Add('SELECT COUNT(Fish_No) AS c');
  qry.SQL.Add('FROM Persons, Fish');
  qry.SQL.Add('WHERE Fish_PCode = P_BarCode');
  if qryFishPrs.FieldByName('P_IsGuest').AsBoolean then
    qry.SQL.Add('AND P_IsGuest = 1')
  else
    qry.SQL.Add('AND P_IsGuest = 0');

  qry.SQL.Add('AND Fish_Date >= ''' + sDate + ''' AND Fish_Date <= ''' + eDate + '''');

  qry.Open;
  if qryFishPrs.FieldByName('P_IsGuest').AsBoolean then
  begin
    gNo := qry.FieldByName('C').AsInteger;
    gPay := gPay + qryFishPrs.FieldByName('Pay').AsCurrency;
    gPrice := gPrice + qryFishPrs.FieldByName('Price').AsCurrency;
  end
  else
  begin
    nNo := qry.FieldByName('C').AsInteger;
    nPay := nPay + qryFishPrs.FieldByName('Pay').AsCurrency;
    nPrice := nPrice + qryFishPrs.FieldByName('Price').AsCurrency;
  end;
  qry.Close;

end;

procedure TfrmRptYearFdMkh.bndTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblTNNo.Caption := IntToStr(tNNo);
  lblTNPay.Caption := Format('%m', [tNPay]);
  lblTNPrice.Caption := Format('%m', [tNPrice]);

  lblTGNo.Caption := IntToStr(tGNo);
  lblTGPay.Caption := Format('%m', [tGPay]);
  lblTGPrice.Caption := Format('%m', [tGPrice]);

  lblTTNo.Caption := IntToStr(tNNo + tGNo);
  lblTTCost.Caption := Format('%m', [tNPay+tNPrice + tGPay+tGPrice]);
end;

procedure TfrmRptYearFdMkh.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  tNNo := 0;
  tGNo := 0;
  tNPay := 0;
  tNPrice := 0;
  tGPay := 0;
  tGPrice := 0;
end;

procedure TfrmRptYearFdMkh.qrptFoodMonthBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFoodMonth.Font.Name := RptFont;
  qrptFoodMonth.Font.Size := RptFntSize;
end;

end.
