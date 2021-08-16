unit RpRdrFsh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptRdrFish = class(TForm)
    qryRdrFish: TAdoQuery;
    qrptRdrFish: TQuickRep;
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
    lbl6: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    lbl4: TQRLabel;
    lbl5: TQRLabel;
    SummaryBand1: TQRBand;
    bndSign: TQRChildBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    DetailBand1: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRExpr1: TQRExpr;
    QRDBText1: TQRDBText;
    lblReader: TQRLabel;
    QRExpr2: TQRExpr;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    lbl7: TQRLabel;
    lbl8: TQRLabel;
    lblClkRecs: TQRLabel;
    QRShape5: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptRdrFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptRdrFish.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  qrptRdrFish.ReportTitle := (qrptRdrFish.ReportTitle);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
end;

procedure TfrmRptRdrFish.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryRdrFish.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptRdrFish.QRExpr1Print(sender: TObject; var Value: String);
begin
  Value := (Value);
end;

procedure TfrmRptRdrFish.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if qryRdrFish.FieldByName('Fish_RdrCode').AsInteger = 0 then
    lblReader.Caption := ('›Ì‘ œ” Ì')
  else
    lblReader.Caption := GetReaderName(qryRdrFish.FieldByName('Fish_RdrCode').AsInteger);
end;

procedure TfrmRptRdrFish.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var qry: TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT DISTINCT Clock_BarCode FROM ClckRecs');
  qry.Open;
  lblClkRecs.Caption := IntToStr(qry.RecordCount);
  qry.Close;
  qry.Free;
end;

procedure TfrmRptRdrFish.qrptRdrFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptRdrFish.Font.Name := RptFont;
  qrptRdrFish.Font.Size := RptFntSize;
end;

end.
