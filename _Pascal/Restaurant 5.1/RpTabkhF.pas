unit RpTabkhF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc,
  StdCtrls;

type
  TfrmRptAmarTabkhF = class(TForm)
    qrptAmarTabkhF: TQuickRep;
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
    lblFromToDate: TQRLabel;
    qryAmarTabkhF: TADOQuery;
    ClmnHeader: TQRBand;
    DetailBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRShape3: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRLabel7: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRSysData4: TQRSysData;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRDBText9: TQRDBText;
    QRShape20: TQRShape;
    QRDBText10: TQRDBText;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    qryAmarTabkhFbuilding: TWideStringField;
    qryAmarTabkhFVADEH: TSmallintField;
    qryAmarTabkhFdate: TWideStringField;
    qryAmarTabkhFfood: TWideStringField;
    qryAmarTabkhFcnts: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure qrptAmarTabkhFBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qryAmarTabkhFCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmRptAmarTabkhF.FormCreate(Sender: TObject);
begin
  qryAmarTabkhF.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptAmarTabkhF.qrptAmarTabkhFBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptAmarTabkhF.Font.Name := RptFont;
  qrptAmarTabkhF.Font.Size := RptFntSize;
end;

procedure TfrmRptAmarTabkhF.qryAmarTabkhFCalcFields(DataSet: TDataSet);
var
  dt : string;
  sobhanehCnt , NaharCnt , ShamCnt : integer;
const
  days : array [1..7] of string = ('‘‰»Â','Ìò‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','çÂ«— ‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');
begin
  with qryAmarTabkhF do
  begin
    dt := FieldByName('Date').Asstring;
    FieldByName('Day').AsString := days[dayOfWeek(M_Date(qryAmarTabkhFDate.AsString)+1)];
  end;
end;


end.
