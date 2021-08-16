unit RpSrvEm5;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,dbs,dateproc,Globals;

type
  TqrptEmplSrvc5 = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    bndSign: TQRChildBand;
    QRShape8: TQRShape;
    QRSysData3: TQRSysData;
    QRShape13: TQRShape;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    aqryEmplSrvc: TADOQuery;
    grpPub: TQRGroup;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    clmnGroup: TQRBand;
    clmnHead: TQRChildBand;
    lbl5: TQRLabel;
    lbl7: TQRLabel;
    QRShape1: TQRShape;
    lbl6: TQRLabel;
    QRShape12: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRDBText4: TQRDBText;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel2: TQRLabel;
    QRDBText5: TQRDBText;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure aqryEmplSrvcCalcFields(DataSet: TDataSet);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
       remain : Integer;
  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel;

{$R *.DFM}



procedure TqrptEmplSrvc5.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;
end;


procedure TqrptEmplSrvc5.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptEmplSrvc5.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  SetWinF_Rpt;
end;

procedure TqrptEmplSrvc5.aqryEmplSrvcCalcFields(DataSet: TDataSet);
 var  lastChargeDate:string;
 begin

 DataSet.FieldByName('Balance').AsCurrency := CalculBalance(DataSet.FieldByName('dtlEmplNo').AsString,'','',lastChargeDate);
 DataSet.FieldByName('kharid').AsCurrency :=  Calculkharid(DataSet.FieldByName('dtlEmplNo').AsString);
 DataSet.FieldByName('charge').AsCurrency :=  DataSet.FieldByName('kharid').AsCurrency + DataSet.FieldByName('Balance').AsCurrency;
// DataSet.FieldByName('kharid').AsCurrency := DataSet.FieldByName('Balance').AsCurrency - DataSet.FieldByName('kharid').AsCurrency;
 end;

procedure TqrptEmplSrvc5.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//QRLabel2.Caption:=inttostr(aqryEmplSrvc.FieldByName('SumOfGrpPrice').asinteger +strtoint(QRLabel2.Caption));
end;

end.
