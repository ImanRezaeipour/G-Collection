unit RpTabkhFP1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc,
  StdCtrls;

type
  TfrmRptAmarTabkhFP1 = class(TForm)
    qrptAmarTabkhFP1: TQuickRep;
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
    qryAmarTabkhFP1: TADOQuery;
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
    lblperson: TQRLabel;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    qryAmarTabkhFP1Date: TWideStringField;
    qryAmarTabkhFP1Day: TWideStringField;
    qryAmarTabkhFP1Vadeh: TSmallintField;
    qryAmarTabkhFP1food: TWideStringField;
    qryAmarTabkhFP1personno: TWideStringField;
    qryAmarTabkhFP1cnt: TSmallintField;
    qryAmarTabkhFP1Building: TWideStringField;
    qryAmarTabkhFP1p_family: TStringField;
    qryAmarTabkhFP1p_name: TStringField;
    QRLabel5: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRDBText2: TQRDBText;
    qryAmarTabkhFP1prc: TCurrencyField;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure qrptAmarTabkhFP1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qryAmarTabkhFP1CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmRptAmarTabkhFP1.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  st : string;
begin
   st:=qryAmarTabkhFP1.FieldByName('personno').asstring;
//   lblperson.Caption:=st+' - '+GetPersonFamilyName(st);
   lblperson.Caption:=st+' - '+qryAmarTabkhFP1.FieldByName('p_family').asstring+' '+qryAmarTabkhFP1.FieldByName('p_name').asstring;
end;

procedure TfrmRptAmarTabkhFP1.FormCreate(Sender: TObject);
begin
  qryAmarTabkhFP1.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptAmarTabkhFP1.qrptAmarTabkhFP1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptAmarTabkhFP1.Font.Name := RptFont;
  qrptAmarTabkhFP1.Font.Size := RptFntSize;
end;

procedure TfrmRptAmarTabkhFP1.qryAmarTabkhFP1CalcFields(DataSet: TDataSet);
var
  dt : string;
  sobhanehCnt , NaharCnt , ShamCnt : integer;
const
  days : array [1..7] of string = ('‘‰»Â','Ìò‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','çÂ«— ‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');
begin
  with qryAmarTabkhFP1 do
  begin
    dt := FieldByName('Date').Asstring;
    FieldByName('Day').AsString := days[dayOfWeek(M_Date(qryAmarTabkhFP1Date.AsString)+1)];
  end;
end;


end.
