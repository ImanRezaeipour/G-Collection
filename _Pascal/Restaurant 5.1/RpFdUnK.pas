unit RpFdUnK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptUnitFoodK = class(TForm)
    qrptUnitFood: TQuickRep;
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
    bndFooterUnit: TQRBand;
    grpUnit: TQRGroup;
    qryUnitFood: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRShape4: TQRShape;
    QRLabel18: TQRLabel;
    QRShape6: TQRShape;
    QRLabel20: TQRLabel;
    QRShape10: TQRShape;
    QRLabel2: TQRLabel;
    expr6: TQRExpr;
    QRShape20: TQRShape;
    expr5: TQRExpr;
    QRShape5: TQRShape;
    QRExpr3: TQRExpr;
    expr4: TQRExpr;
    QRShape1: TQRShape;
    expr3: TQRExpr;
    QRShape2: TQRShape;
    expr2: TQRExpr;
    QRShape3: TQRShape;
    expr1: TQRExpr;
    QRShape7: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    SummaryBand1: TQRBand;
    QRShape13: TQRShape;
    expr7: TQRExpr;
    QRShape14: TQRShape;
    expr8: TQRExpr;
    QRShape15: TQRShape;
    expr9: TQRExpr;
    QRShape16: TQRShape;
    expr10: TQRExpr;
    QRShape17: TQRShape;
    expr11: TQRExpr;
    QRShape18: TQRShape;
    expr12: TQRExpr;
    QRLabel8: TQRLabel;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure expr1Print(sender: TObject; var Value: String);
    procedure expr2Print(sender: TObject; var Value: String);
    procedure expr3Print(sender: TObject; var Value: String);
    procedure expr4Print(sender: TObject; var Value: String);
    procedure expr5Print(sender: TObject; var Value: String);
    procedure expr6Print(sender: TObject; var Value: String);
    procedure expr7Print(sender: TObject; var Value: String);
    procedure expr8Print(sender: TObject; var Value: String);
    procedure expr9Print(sender: TObject; var Value: String);
    procedure expr10Print(sender: TObject; var Value: String);
    procedure expr11Print(sender: TObject; var Value: String);
    procedure expr12Print(sender: TObject; var Value: String);
    procedure qrptUnitFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptUnitFoodK.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  lblName.Caption := (lblName.Caption);
  qrptUnitFood.ReportTitle := (qrptUnitFood.ReportTitle);
end;

procedure TfrmRptUnitFoodK.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryUnitFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptUnitFoodK.expr1Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr2Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr3Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr4Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr5Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr6Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr7Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr8Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr9Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr10Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr11Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.expr12Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodK.qrptUnitFoodBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptUnitFood.Font.Name := RptFont;
  qrptUnitFood.Font.Size := RptFntSize;
end;

end.
