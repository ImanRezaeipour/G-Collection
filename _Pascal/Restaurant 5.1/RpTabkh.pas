unit RpTabkh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc,
  StdCtrls;

type
  TfrmRptAmarTabkh = class(TForm)
    qrptAmarTabkh: TQuickRep;
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
    qryAmarTabkh: TAdoQuery;
    qryAmarTabkhDate: TStringField;
    qryAmarTabkhsobhaneh: TIntegerField;
    qryAmarTabkhnahar: TIntegerField;
    qryAmarTabkhSham: TIntegerField;
    qryAmarTabkhday: TStringField;
    ClmnHeader: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
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
    QRDBText8: TQRDBText;
    QRSysData4: TQRSysData;
    QRShape16: TQRShape;
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
    procedure FormCreate(Sender: TObject);
    procedure qrptAmarTabkhBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qryAmarTabkhCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmRptAmarTabkh.FormCreate(Sender: TObject);
begin
  qryAmarTabkh.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;







procedure TfrmRptAmarTabkh.qrptAmarTabkhBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptAmarTabkh.Font.Name := RptFont;
  qrptAmarTabkh.Font.Size := RptFntSize;
end;

procedure TfrmRptAmarTabkh.qryAmarTabkhCalcFields(DataSet: TDataSet);
var
  dt : string;
  sobhanehCnt , NaharCnt , ShamCnt : integer;
const
  days : array [1..7] of string = ('‘‰»Â','Ìò‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','çÂ«— ‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');
begin
  with qryAmarTabkh do
  begin
    dt := FieldByName('Date').Asstring;
    GetPresentPersons(dt,sobhanehCnt,NaharCnt,ShamCnt);
    FieldByName('sobhaneh').AsInteger := sobhanehCnt;
    FieldByName('Nahar').AsInteger := NaharCnt;
    FieldByName('Sham').AsInteger := ShamCnt;
    FieldByName('Day').AsString := days[dayOfWeek(M_Date(qryAmarTabkhDate.AsString))+1];
  end;
end;


end.
