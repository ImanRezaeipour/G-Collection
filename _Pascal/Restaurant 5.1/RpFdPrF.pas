unit RpFdPrF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodCount = class(TForm)
    qryPrsFood: TAdoQuery;
    qrptPrsFood: TQuickRep;
    dtlData: TQRBand;
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
    ColumnHeaderBand1: TQRBand;
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    QRShape1: TQRShape;
    lbl7: TQRLabel;
    QRShape4: TQRShape;
    grpPartJob: TQRGroup;
    lbl8: TQRLabel;
    QRShape9: TQRShape;
    bndFooter: TQRBand;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    lbl11: TQRLabel;
    grpFamily: TQRGroup;
    lblJob: TQRLabel;
    lblPart: TQRLabel;
    QRExpr1: TQRExpr;
    lbl5: TQRLabel;
    lbl4: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    grpFood: TQRGroup;
    lbl6: TQRLabel;
    QRShape3: TQRShape;
    bndFoodGroup: TQRBand;
    ChildBand2: TQRChildBand;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    lblFoods: TQRLabel;
    lblRow: TQRLabel;
    QRExpr3: TQRExpr;
    QRShape6: TQRShape;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFamilyBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndFoodGroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    row : Integer;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoodCount.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
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
  lblPart.Caption := (lblPart.Caption);
  lblJob.Caption := (lblJob.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoodCount.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
  grpFood.Height := 0;
  dtlData.Height := 0;
end;

procedure TfrmRptPrsFoodCount.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
end;

procedure TfrmRptPrsFoodCount.grpFamilyBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
end;

procedure TfrmRptPrsFoodCount.bndFoodGroupBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Inc(row);
  lblRow.Caption := IntToStr(row);
  lblFoods.Caption := GetFoodNameInRam(qryPrsFood.FieldByName('FF_Food').AsInteger);
end;

procedure TfrmRptPrsFoodCount.qrptPrsFoodBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFood.Font.Name := RptFont;
  qrptPrsFood.Font.Size := RptFntSize;
end;

end.
