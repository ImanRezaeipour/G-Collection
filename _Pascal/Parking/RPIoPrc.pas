unit RpIOPrc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler,
  FarsiApi;

type
  TfrmRptInOutPrc = class(TForm)
    qrptPrc: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lbl1: TQRLabel;
    lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    qryPrc: TAdoQuery;
    lblFromToDate: TQRLabel;
    DetailBand1: TQRBand;
    bndClmn: TQRBand;
    lbl7: TQRLabel;
    QRShape17: TQRShape;
    lbl8: TQRLabel;
    lbl11: TQRLabel;
    QRShape1: TQRShape;
    lbl9: TQRLabel;
    QRShape3: TQRShape;
    lbl10: TQRLabel;
    QRShape6: TQRShape;
    lbl12: TQRLabel;
    QRShape10: TQRShape;
    QRShape32: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    lblTimes: TQRLabel;
    lbl6: TQRLabel;
    QRShape2: TQRShape;
    QRSysData3: TQRSysData;
    QRShape4: TQRShape;
    lbl5: TQRLabel;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRDBText1: TQRDBText;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRDBText2: TQRDBText;
    lbl13: TQRLabel;
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

procedure TfrmRptInOutPrc.SetWinF;
begin
  Caption := (Caption);
  qrptPrc.ReportTitle := (qrptPrc.ReportTitle);
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
end;

procedure TfrmRptInOutPrc.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrc.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptInOutPrc.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryPrc do
  begin
    lblTimes.Caption := FormatTimes(Differ(FieldByname('M_IDate').AsString,
                                           FieldByname('M_ITime').AsString,
                                           FieldByname('M_ODate').AsString,
                                           FieldByname('M_OTime').AsString));
  end;
end;

end.
