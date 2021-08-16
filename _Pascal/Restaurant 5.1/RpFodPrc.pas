unit RpFodPrc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc;

type
  TfrmRptFoodPrc = class(TForm)
    qrptFoodPrice: TQuickRep;
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
    qryFoodPrice: TAdoQuery;
    grpType: TQRGroup;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel6: TQRLabel;
    QRSysData3: TQRSysData;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    bndSpace: TQRBand;
    lblFromToDate: TQRLabel;
    QRDBText2: TQRDBText;
    clmnHeader: TQRBand;
    QRLabel7: TQRLabel;
    QRShape11: TQRShape;
    QRLabel8: TQRLabel;
    QRShape12: TQRShape;
    QRLabel9: TQRLabel;
    QRShape13: TQRShape;
    QRLabel10: TQRLabel;
    QRShape14: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape15: TQRShape;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qrptFoodPriceBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptFoodPrc.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  qrptFoodPrice.ReportTitle := (qrptFoodPrice.ReportTitle);
end;

procedure TfrmRptFoodPrc.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryFoodPrice.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;







procedure TfrmRptFoodPrc.qrptFoodPriceBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFoodPrice.Font.Name := RptFont;
  qrptFoodPrice.Font.Size := RptFntSize;
end;

end.
