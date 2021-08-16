unit RpPrcK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler,
  FarsiApi;

type
  TfrmRptGetPriceK = class(TForm)
    qrptPrc: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblTitle: TQRLabel;
    QRLabel16: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    qryPrc: TAdoQuery;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel2: TQRLabel;
    exprAll: TQRExpr;
    grp: TQRGroup;
    QRShape1: TQRShape;
    lblGroup: TQRLabel;
    txtCode: TQRDBText;
    bnd: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel3: TQRLabel;
    ChildBand2: TQRChildBand;
    txtName: TQRDBText;
    DetailBand1: TQRBand;
    QRLabel20: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel5: TQRLabel;
    QRExpr3: TQRExpr;
    lblFromToPrice: TQRLabel;
    lblFromToStay: TQRLabel;
    lblNumberSerial: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptGetPriceK.SetWinF;
begin
  Caption := (Caption);
  lblTitle.Caption := (lblTitle.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  lblGroup.Caption := (lblGroup.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  qrptPrc.ReportTitle := (qrptPrc.ReportTitle);
end;

procedure TfrmRptGetPriceK.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrc.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;


end.
