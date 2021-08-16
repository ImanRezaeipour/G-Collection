unit RpFodUse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptoodUsed = class(TForm)
    qryFishFood: TAdoQuery;
    qrptFoodUsed: TQuickRep;
    dtlRecs: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    FoodBnd: TQRBand;
    QRExpr2: TQRExpr;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRShape8: TQRShape;
    grpFood: TQRGroup;
    QRExpr9: TQRExpr;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape13: TQRShape;
    lbl6: TQRLabel;
    QRShape14: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    bndSign: TQRChildBand;
    QRExpr5: TQRExpr;
    lbl12: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRShape11: TQRShape;
    QRExpr8: TQRExpr;
    QRShape16: TQRShape;
    QRDBText1: TQRDBText;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure qrptFoodUsedBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}
procedure TfrmRptoodUsed.SetWinF;
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
  lbl12.Caption := (lbl12.Caption);
  lblName.Caption := (lblName.Caption);
  qrptFoodUsed.ReportTitle := (qrptFoodUsed.ReportTitle);
end;

procedure TfrmRptoodUsed.FormCreate(Sender: TObject);
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

procedure TfrmRptoodUsed.QRExpr3Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.QRExpr4Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.QRExpr2Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.QRExpr5Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.QRExpr6Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.QRExpr7Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptoodUsed.qrptFoodUsedBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFoodUsed.Font.Name := RptFont;
  qrptFoodUsed.Font.Size := RptFntSize;
end;

end.
