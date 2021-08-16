unit RpDblFsh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRpDblFish = class(TForm)
    qryDblFish: TAdoQuery;
    qrptDblFish: TQuickRep;
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
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape7: TQRShape;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRSysData3: TQRSysData;
    QRExpr1: TQRExpr;
    lblJobType: TQRLabel;
    lblPart: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape11: TQRShape;
    QRLabel7: TQRLabel;
    QRShape12: TQRShape;
    txtDate: TQRDBText;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptDblFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRpDblFish.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  lblName.Caption := (lblName.Caption);
  qrptDblFish.ReportTitle := (qrptDblFish.ReportTitle);
end;

procedure TfrmRpDblFish.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryDblFish.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRpDblFish.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPCode.Caption := DelLeftZero(qryDblFish.FieldByName('P_BarCode').AsString);
  lblPart.Caption := GetPartNam(qryDblFish.FieldByName('P_parts').AsString );
  lblJobType.Caption := GetJobName(qryDblFish.FieldByName('P_JobCode').AsInteger);
end;

procedure TfrmRpDblFish.qrptDblFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptDblFish.Font.Name := RptFont;
  qrptDblFish.Font.Size := RptFntSize;
end;

end.
