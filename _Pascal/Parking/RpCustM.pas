unit RpCustM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, Db, AdoDB, Globals, DateProc;

type
  TfrmRptCustMojodi = class(TForm)
    qrptCust: TQuickRep;
    qryCust: TAdoQuery;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel16: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel7: TQRLabel;
    QRShape6: TQRShape;
    QRSysData3: TQRSysData;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
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

procedure TfrmRptCustMojodi.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  qrptCust.ReportTitle := (qrptCust.ReportTitle);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
end;

procedure TfrmRptCustMojodi.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryCust.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;
















end.
