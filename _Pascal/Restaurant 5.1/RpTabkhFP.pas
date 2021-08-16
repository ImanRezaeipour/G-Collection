unit RpTabkhFP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc,
  StdCtrls;

type
  TfrmRptAmarTabkhFP = class(TForm)
    qrptAmarTabkhFP: TQuickRep;
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
    qryAmarTabkhFP: TADOQuery;
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
    qryAmarTabkhFPDate: TWideStringField;
    qryAmarTabkhFPDay: TWideStringField;
    qryAmarTabkhFPVadeh: TSmallintField;
    qryAmarTabkhFPfood: TWideStringField;
    qryAmarTabkhFPpersonno: TWideStringField;
    qryAmarTabkhFPcnt: TSmallintField;
    qryAmarTabkhFPBuilding: TWideStringField;
    qryAmarTabkhFPp_family: TStringField;
    qryAmarTabkhFPp_name: TStringField;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure qrptAmarTabkhFPBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qryAmarTabkhFPCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmRptAmarTabkhFP.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  st : string;
begin
   st:=qryAmarTabkhFP.FieldByName('personno').asstring;
//   lblperson.Caption:=st+' - '+GetPersonFamilyName(st);
   lblperson.Caption:=st+' - '+qryAmarTabkhFP.FieldByName('p_family').asstring+' '+qryAmarTabkhFP.FieldByName('p_name').asstring;
end;

procedure TfrmRptAmarTabkhFP.FormCreate(Sender: TObject);
begin
  qryAmarTabkhFP.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptAmarTabkhFP.qrptAmarTabkhFPBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptAmarTabkhFP.Font.Name := RptFont;
  qrptAmarTabkhFP.Font.Size := RptFntSize;
end;

procedure TfrmRptAmarTabkhFP.qryAmarTabkhFPCalcFields(DataSet: TDataSet);
var
  dt : string;
  sobhanehCnt , NaharCnt , ShamCnt : integer;
const
  days : array [1..7] of string = ('‘‰»Â','Ìò‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','çÂ«— ‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');
begin
  with qryAmarTabkhFP do
  begin
    dt := FieldByName('Date').Asstring;
    FieldByName('Day').AsString := days[dayOfWeek(M_Date(qryAmarTabkhFPDate.AsString)+1)];
  end;
end;


end.
