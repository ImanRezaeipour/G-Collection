unit RpGust;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, FarsiApi,
  DBS_Proc;

type
  TfrmRptGust = class(TForm)
    qryGuest: TAdoQuery;
    qrptPerson: TQuickRep;
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
    grpPart: TQRGroup;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    lblPricable: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape20: TQRShape;
    bndGrpFooter: TQRBand;
    QRLabel8: TQRLabel;
    QRShape7: TQRShape;
    QRLabel4: TQRLabel;
    QRShape8: TQRShape;
    QRLabel2: TQRLabel;
    QRShape10: TQRShape;
    QRLabel1: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    lblPart: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPersonBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptGust.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel13.Caption := (QRLabel13.Caption);
  lblName.Caption := (lblName.Caption);
  qrptPerson.ReportTitle := (qrptPerson.ReportTitle);
end;

procedure TfrmRptGust.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryGuest.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptGust.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryGuest do
  begin
    lblPCode.Caption := DelLeftZero(FieldByName('P_BarCode').AsString);
    lblPart.Caption := GetPartNam(FieldByName('P_parts').Asstring);
    if FieldByName('P_Pricable').AsBoolean then
      lblPricable.Caption := ('ÇÎÐ æÌå')
    else
      lblPricable.Caption := ('ÈÏæä æÌå');
  end;
end;


procedure TfrmRptGust.qrptPersonBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPerson.Font.Name := RptFont;
  qrptPerson.Font.Size := RptFntSize;

end;

end.
