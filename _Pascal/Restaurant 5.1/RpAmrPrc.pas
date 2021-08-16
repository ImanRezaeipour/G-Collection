unit RpAmrPrc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptAmarPrice = class(TForm)
    qryFishFood: TAdoQuery;
    qrptPeyman: TQuickRep;
    dtlRecs: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    FoodBnd: TQRBand;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape14: TQRShape;
    lbl5: TQRLabel;
    QRShape15: TQRShape;
    lbl6: TQRLabel;
    bndSign: TQRChildBand;
    lbl8: TQRLabel;
    QRShape10: TQRShape;
    lbl7: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRShape6: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRSysData3: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    lbl1: TQRLabel;
    grpFood: TQRGroup;
    QRBand1: TQRBand;
    procedure FormCreate(Sender: TObject);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure qrptPeymanBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    procedure SetWinF;

  public
    { Public declarations }

  end;

implementation

{$R *.DFM}
procedure TfrmRptAmarPrice.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lblName.Caption := (lblName.Caption);
  qrptPeyman.ReportTitle := (qrptPeyman.ReportTitle);
end;

procedure TfrmRptAmarPrice.FormCreate(Sender: TObject);
begin
  SetWinF;
  grpFood.Height := 0;
  dtlRecs.Height := 0;
  qryFishFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

end;

procedure TfrmRptAmarPrice.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TfrmRptAmarPrice.qrptPeymanBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPeyman.Font.Name := RptFont;
  qrptPeyman.Font.Size := RptFntSize;
end;

end.
