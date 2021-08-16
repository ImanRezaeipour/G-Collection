unit RpNoCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler,
  FarsiApi;

type
  TfrmRptNoCard = class(TForm)
    qrptNoCard: TQuickRep;
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
    qryNoCard: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    QRShape21: TQRShape;
    QRLabel6: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRLabel12: TQRLabel;
    QRShape20: TQRShape;
    QRLabel5: TQRLabel;
    QRShape19: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    DetailBand1: TQRBand;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel4: TQRLabel;
    lblNumber: TQRLabel;
    lblCitySerial: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}


procedure TfrmRptNoCard.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  qrptNoCard.ReportTitle := (qrptNoCard.ReportTitle);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
end;

procedure TfrmRptNoCard.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryNoCard.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptNoCard.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryNoCard do
  begin
    lblNumber.Caption := ConvertToFarsi(FieldByname('N_Number').AsString);
    if FieldByname('N_Serial').AsString <> '' then
      lblCitySerial.Caption := FieldByname('N_City').AsString + '-' +
                               FieldByname('N_Serial').AsString
    else
      lblCitySerial.Caption := FieldByname('N_City').AsString;
  end;
end;

end.
