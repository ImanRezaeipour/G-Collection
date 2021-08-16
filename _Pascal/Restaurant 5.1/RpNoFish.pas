unit RpNoFish;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRpNoFish = class(TForm)
    qryPersonNoFish: TAdoQuery;
    qrptNoFish: TQuickRep;
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
    QRDBText2: TQRDBText;
    lblJobType: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptNoFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    isSobhaneh , isNahar , isSham : boolean;
  end;
implementation

{$R *.DFM}

procedure TfrmRpNoFish.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  lblName.Caption := (lblName.Caption);
  qrptNoFish.ReportTitle := (qrptNoFish.ReportTitle);
end;

procedure TfrmRpNoFish.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPersonNoFish.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRpNoFish.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sb , nh , sh : boolean;
  i : integer;
begin
  with qryPersonNoFish do
  begin
    for i := 0 to DifferDate(g_Options.RptFDate,g_Options.RptTDate) do
    begin
      PersonAuthorized(FieldByName('P_BarCode').AsString,AddDate(g_Options.RptFDate,i) ,sb,nh,sh);
      if isSobhaneh then
        if not sb then
          PrintBand := false;
      if isNahar then
        if not nh then
          PrintBand := false;
      if isSham then
        if not sh then
          PrintBand := false;
    end;
    lblPCode.Caption := DelLeftZero(qryPersonNoFish.FieldByName('P_BarCode').AsString);
    lblJobType.Caption := GetJobName(qryPersonNoFish.FieldByName('P_JobCode').AsInteger);
  end;
end;

procedure TfrmRpNoFish.qrptNoFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptNoFish.Font.Name := RptFont;
  qrptNoFish.Font.Size := RptFntSize;
end;

end.
