unit RpFdUnM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptUnitFoodM = class(TForm)
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
    grpMonth: TQRGroup;
    qryUnitFood: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRShape4: TQRShape;
    QRLabel18: TQRLabel;
    QRShape6: TQRShape;
    QRLabel20: TQRLabel;
    QRShape10: TQRShape;
    QRLabel2: TQRLabel;
    QRExpr7: TQRExpr;
    QRShape20: TQRShape;
    QRExpr6: TQRExpr;
    QRShape5: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr1: TQRExpr;
    QRShape1: TQRShape;
    QRExpr2: TQRExpr;
    QRShape2: TQRShape;
    QRExpr4: TQRExpr;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
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
    QRExpr8: TQRExpr;
    QRShape14: TQRShape;
    QRExpr9: TQRExpr;
    QRShape15: TQRShape;
    QRExpr10: TQRExpr;
    QRShape16: TQRShape;
    QRExpr11: TQRExpr;
    QRShape17: TQRShape;
    QRExpr12: TQRExpr;
    QRShape18: TQRShape;
    QRExpr13: TQRExpr;
    QRLabel8: TQRLabel;
    grpUnit: TQRGroup;
    QRShape19: TQRShape;
    QRLabel9: TQRLabel;
    lblMonth: TQRLabel;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndFooterUnitBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr8Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure QRExpr10Print(sender: TObject; var Value: String);
    procedure QRExpr11Print(sender: TObject; var Value: String);
    procedure QRExpr12Print(sender: TObject; var Value: String);
    procedure QRExpr13Print(sender: TObject; var Value: String);
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

procedure TfrmRptUnitFoodM.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
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

procedure TfrmRptUnitFoodM.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryUnitFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptUnitFoodM.bndFooterUnitBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
const Mnth : array[1..12] of string =
      ('›—Ê—œÌ‰', '«—œÌ»Â‘ ', 'Œ—œ«œ',
       ' Ì—', '„—œ«œ', '‘Â—ÌÊ—',
       '„Â—', '¬»«‰', '¬–—',
       'œÌ', '»Â„‰', '«”›‰œ');
begin
  lblMonth.Caption := (Mnth[StrToInt(qryUnitFood.FieldByName('Fish_D').AsString)]);
end;

procedure TfrmRptUnitFoodM.QRExpr5Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr6Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr8Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr9Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr10Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr11Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr12Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.QRExpr13Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodM.qrptUnitFoodBeforePrint(Sender: TCustomQuickRep;
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
