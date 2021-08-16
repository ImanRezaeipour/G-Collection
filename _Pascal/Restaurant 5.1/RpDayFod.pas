unit RpDayFod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptDayFood = class(TForm)
    qryFishFood: TAdoQuery;
    qrptFishFood: TQuickRep;
    grpType: TQRGroup;
    DetailBand1: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl12: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl13: TQRLabel;
    lbl11: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    grpPartJob: TQRGroup;
    QRBand1: TQRBand;
    QRExpr2: TQRExpr;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRBand2: TQRBand;
    lblVadeh: TQRLabel;
    QRExpr3: TQRExpr;
    lblGrpDate: TQRLabel;
    QRExpr4: TQRExpr;
    QRShape8: TQRShape;
    QRDBText1: TQRDBText;
    QRExpr5: TQRExpr;
    lbl14: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRShape11: TQRShape;
    ChildBand2: TQRChildBand;
    grpFood: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    chldType: TQRChildBand;
    lbl1: TQRLabel;
    QRShape3: TQRShape;
    lbl2: TQRLabel;
    QRShape2: TQRShape;
    lbl3: TQRLabel;
    QRShape7: TQRShape;
    lbl4: TQRLabel;
    QRShape1: TQRShape;
    lbl5: TQRLabel;
    chldPartJob: TQRChildBand;
    lbl6: TQRLabel;
    QRShape12: TQRShape;
    lbl7: TQRLabel;
    QRShape13: TQRShape;
    lbl8: TQRLabel;
    QRShape14: TQRShape;
    lbl9: TQRLabel;
    QRShape15: TQRShape;
    lbl10: TQRLabel;
    QRExpr8: TQRExpr;
    QRShape16: TQRShape;
    QRExpr9: TQRExpr;
    bndSign: TQRBand;
    QRDBText2: TQRDBText;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure grpTypeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure qrptFishFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}
procedure TfrmRptDayFood.SetWinF;
begin
  Caption := (Caption);
  lblGrpDate.Caption := (lblGrpDate.Caption);
  lblName.Caption := (lblName.Caption);
  qrptFishFood.ReportTitle := (qrptFishFood.ReportTitle);
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
  lbl14.Caption := (lbl14.Caption);
end;

procedure TfrmRptDayFood.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryFishFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptDayFood.grpTypeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblVadeh.Caption := (FoodName[qryFishFood.FieldByName('FF_Type').AsInteger]);
end;

procedure TfrmRptDayFood.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if lblPart.Enabled then
    lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryFishFood.FieldByName('P_parts').Asstring);
  if lblJob.Enabled then
    lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryFishFood.FieldByName('P_JobCode').AsInteger);
end;

procedure TfrmRptDayFood.QRExpr3Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.QRExpr4Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.QRExpr2Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.QRExpr5Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.QRExpr6Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.QRExpr7Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptDayFood.qrptFishFoodBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFishFood.Font.Name := RptFont;
  qrptFishFood.Font.Size := RptFntSize;
end;

end.
