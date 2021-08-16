unit RpPrcT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler,
  FarsiApi;

type
  TfrmRptGetPriceT = class(TForm)
    qrptPrc: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lbl1: TQRLabel;
    lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    qryPrc: TAdoQuery;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    SummaryBand1: TQRBand;
    lbl26: TQRLabel;
    exprAll: TQRExpr;
    grp: TQRGroup;
    lblGroup: TQRLabel;
    txtCode: TQRDBText;
    bnd: TQRBand;
    QRExpr1: TQRExpr;
    lbl25: TQRLabel;
    bndChild: TQRChildBand;
    txtName: TQRDBText;
    DetailBand1: TQRBand;
    bndClmn: TQRBand;
    lbl5: TQRLabel;
    QRShape21: TQRShape;
    QRShape17: TQRShape;
    lbl6: TQRLabel;
    lbl13: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    lbl8: TQRLabel;
    lbl7: TQRLabel;
    lbl9: TQRLabel;
    QRShape3: TQRShape;
    lbl10: TQRLabel;
    QRShape4: TQRShape;
    lbl11: TQRLabel;
    QRShape5: TQRShape;
    lbl12: TQRLabel;
    QRShape6: TQRShape;
    lbl14: TQRLabel;
    QRShape10: TQRShape;
    lbl24: TQRLabel;
    QRShape11: TQRShape;
    lbl23: TQRLabel;
    QRShape12: TQRShape;
    lbl22: TQRLabel;
    QRShape13: TQRShape;
    lbl21: TQRLabel;
    QRShape14: TQRShape;
    lbl20: TQRLabel;
    QRShape15: TQRShape;
    lbl19: TQRLabel;
    QRShape16: TQRShape;
    lbl18: TQRLabel;
    QRShape19: TQRShape;
    lbl17: TQRLabel;
    QRShape20: TQRShape;
    lbl16: TQRLabel;
    QRShape22: TQRShape;
    lbl15: TQRLabel;
    QRShape27: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    lblTimes: TQRLabel;
    qry: TAdoQuery;
    lbl29: TQRLabel;
    lbl28: TQRLabel;
    lbl27: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRShape9: TQRShape;
    QRShape23: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape18: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRLabel1: TQRLabel;
    QRShape46: TQRShape;
    QRLabel2: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel3: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel4: TQRLabel;
    QRExpr3: TQRExpr;
    QRLabel5: TQRLabel;
    QRShape47: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText12: TQRDBText;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText13: TQRDBText;
    lblFromToPrice: TQRLabel;
    lblFromToStay: TQRLabel;
    lblNumberSerial: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptGetPriceT.SetWinF;
begin
  Caption := (Caption);
  qrptPrc.ReportTitle := (qrptPrc.ReportTitle);
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
  lbl15.Caption := (lbl15.Caption);
  lbl16.Caption := (lbl16.Caption);
  lbl17.Caption := (lbl17.Caption);
  lbl18.Caption := (lbl18.Caption);
  lbl19.Caption := (lbl19.Caption);
  lbl20.Caption := (lbl20.Caption);
  lbl21.Caption := (lbl21.Caption);
  lbl22.Caption := (lbl22.Caption);
  lbl23.Caption := (lbl23.Caption);
  lbl24.Caption := (lbl24.Caption);
  lbl25.Caption := (lbl25.Caption);
  lbl26.Caption := (lbl26.Caption);
  lbl27.Caption := (lbl27.Caption);
  lbl28.Caption := (lbl28.Caption);
  lbl29.Caption := (lbl29.Caption);
end;

procedure TfrmRptGetPriceT.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrc.connection := frmDBS.adoConnect;
  qry.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptGetPriceT.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryPrc do
  begin
    lblTimes.Caption := FormatTimes(Differ(FieldByname('M_IDate_M').AsString,
                                           FieldByname('M_ITime_M').AsString,
                                           FieldByname('M_ODate_M').AsString,
                                           FieldByname('M_OTime_M').AsString));
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT R_Name FROM Readers WHERE R_Code = ' + FieldByName('M_IDoor').AsString);
//    qry.Open;
//    if qry.EOF then
//      lblIDoor.Caption := ''
//    else
//      lblIDoor.Caption := qry.FieldByName('R_Name').AsString;
//    qry.Close;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT P_Name FROM Persons WHERE P_BarCode = ''' + FieldByName('M_IPerson').AsString + '''');
//    qry.Open;
//    if qry.EOF then
//      lblIPerson.Caption := ''
//    else
//      lblIPerson.Caption := qry.FieldByName('P_Name').AsString;
//    qry.Close;
  end;
end;

end.
