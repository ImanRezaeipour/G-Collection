unit RpFdUnTU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptUnitFoodTU = class(TForm)
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
    QRShape5: TQRShape;
    bndFooterUnit: TQRBand;
    ChildBand2: TQRChildBand;
    QRLabel9: TQRLabel;
    grpUnit: TQRGroup;
    QRLabel1: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRExpr3: TQRExpr;
    ChildBand3: TQRChildBand;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRShape9: TQRShape;
    QRLabel8: TQRLabel;
    QRShape21: TQRShape;
    QRLabel12: TQRLabel;
    QRShape22: TQRShape;
    QRDBText1: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText7: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    bndFooterFish: TQRBand;
    lblKhadamat: TQRLabel;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    ChildBand4: TQRChildBand;
    QRExpr5: TQRExpr;
    QRLabel13: TQRLabel;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    qryUnitFood: TAdoQuery;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    QRExpr8: TQRExpr;
    QRLabel11: TQRLabel;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRShape2: TQRShape;
    QRExpr11: TQRExpr;
    QRDBText3: TQRDBText;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    lblVadeh: TQRDBText;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndFooterFishBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr10Print(sender: TObject; var Value: String);
    procedure QRExpr11Print(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr13Print(sender: TObject; var Value: String);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr12Print(sender: TObject; var Value: String);
    procedure qrptUnitFoodTUBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptUnitFoodTU.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel13.Caption := (QRLabel13.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  lblName.Caption := (lblName.Caption);
  qrptUnitFoodTU.ReportTitle := (qrptUnitFoodTU.ReportTitle);
end;

procedure TfrmRptUnitFoodTU.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryUnitFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptUnitFoodTU.bndFooterFishBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblKhadamat.Caption := GetFoodNameInDB(qryUnitFood.FieldByName('Fish_UKhadamat').AsInteger);
  if lblKhadamat.Caption = '' then
    lblKhadamat.Caption := ('Œœ„« '); 
end;

procedure TfrmRptUnitFoodTU.QRExpr6Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr10Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr11Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr9Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr13Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case qryUnitFood.FieldByName('Fish_Type').AsInteger of
    MB_SOBH  : lblVadeh.Caption := ('’»Õ«‰Â');
    MB_NAHAR : lblVadeh.Caption := ('‰«Â«—');
    MB_SHAM  : lblVadeh.Caption := ('‘«„');
  end;
end;

procedure TfrmRptUnitFoodTU.QRExpr5Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.QRExpr12Print(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptUnitFoodTU.qrptUnitFoodTUBeforePrint(
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
