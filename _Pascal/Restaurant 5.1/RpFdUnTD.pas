unit RpFdUnTD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptUnitFoodTD = class(TForm)
    qryUnitFood: TAdoQuery;
    qrptUnitFoodTU: TQuickRep;
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
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape7: TQRShape;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape8: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel8: TQRLabel;
    lblFoods: TQRLabel;
    lblPay: TQRLabel;
    lblNoPay: TQRLabel;
    bndFooter: TQRBand;
    QRShape11: TQRShape;
    lblAllPay: TQRLabel;
    QRShape12: TQRShape;
    lblAllNoPay: TQRLabel;
    ChildBand2: TQRChildBand;
    qry: TAdoQuery;
    QRLabel9: TQRLabel;
    grpDate: TQRGroup;
    QRLabel1: TQRLabel;
    QRShape13: TQRShape;
    QRLabel2: TQRLabel;
    QRShape14: TQRShape;
    QRLabel10: TQRLabel;
    QRShape15: TQRShape;
    QRLabel11: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRExpr1: TQRExpr;
    lblCost: TQRLabel;
    QRShape18: TQRShape;
    lblAllCost: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    lblKhadamat: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr2: TQRExpr;
    QRLabel12: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndFooterBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure qrptUnitFoodTUBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    AllPay, AllNotPay, AllCost: Currency;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}
procedure TfrmRptUnitFoodTD.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  lblName.Caption := (lblName.Caption);
  qrptUnitFoodTU.ReportTitle := (qrptUnitFoodTU.ReportTitle);
end;
procedure TfrmRptUnitFoodTD.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryUnitFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptUnitFoodTD.grpDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AllPay := 0;
  AllNotPay := 0;
  AllCost := 0;
end;

procedure TfrmRptUnitFoodTD.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Pay, NotPay, Cost : Currency;
  s : String;
begin
  Pay := 0;
  NotPay := 0;

  lblKhadamat.Caption := GetFoodNameInDB(qryUnitFood.FieldByName('Fish_UKhadamat').AsInteger);
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM FishFood');
  qry.SQL.Add('WHERE FF_FishNo = ' + qryUnitFood.FieldByName('Fish_No').AsString);
  qry.SQL.Add('AND FF_Type = ' + qryUnitFood.FieldByName('Fish_Type').AsString);
  qry.SQL.Add('AND FF_Date = ''' + qryUnitFood.FieldByName('Fish_Date').AsString + '''');
  qry.Open;
  s := '';
  while not qry.Eof do
  begin
    if s <> '' then s := s + ' - ';
    s := s + GetFoodNameInRam(qry.FieldByName('FF_Food').AsInteger);
    Pay := Pay + (qry.FieldByName('FF_Pay').AsCurrency * qry.FieldByName('FF_No').AsInteger);
    NotPay := NotPay + (qry.FieldByName('FF_Price').AsCurrency * qry.FieldByName('FF_No').AsInteger);
    qry.Next;
  end;
  qry.Close;

  Cost := Pay + NotPay + qryUnitFood.FieldByName('Fish_UPrc').AsCurrency +
                         qryUnitFood.FieldByName('Fish_UPay').AsCurrency;

  lblFoods.Caption := s;
  lblPay.Caption := Format('%m', [Pay]);
  lblNoPay.Caption := Format('%m', [NotPay]);
  lblCost.Caption := Format('%m', [Cost]);
  AllPay := AllPay + Pay;
  AllNotPay := AllNotPay + NotPay;
  AllCost := AllCost + Cost;
end;

procedure TfrmRptUnitFoodTD.bndFooterBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
  lblAllNoPay.Caption := Format('%m', [AllNotPay]);
  lblAllCost.Caption := Format('%m', [AllCost]);
end;

procedure TfrmRptUnitFoodTD.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTD.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTD.qrptUnitFoodTUBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptUnitFoodTU.Font.Name := RptFont;
  qrptUnitFoodTU.Font.Size := RptFntSize;
end;

end.
