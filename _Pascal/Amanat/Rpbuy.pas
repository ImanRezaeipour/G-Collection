unit Rpbuy;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,dbs,dateproc,Globals,
  grimgctrl;

type
  Trpbuy = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
     lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    Adobuy: TADOQuery;
    Dsbuy: TDataSource;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRPDFShape2: TQRPDFShape;
    QRSysData3: TQRSysData;
    QRPDFShape4: TQRPDFShape;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRPDFShape1: TQRPDFShape;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure aqryEmplSrvcCalcFields(DataSet: TDataSet);
    procedure QRDBText2Print(sender: TObject; var Value: String);
  private
       remain : Integer;
  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel;

{$R *.DFM}



procedure Trpbuy.SetWinF_Rpt;
begin

  Font := rpDFont;
  lblCoName.Font := rpTFont;
  QRLabel3 .Font:=rpHFont;
  QRLabel4 .Font:=rpHFont;
  QRLabel5 .Font:=rpHFont;
  QRLabel1.Font:=rpHFont  ;
  QRLabel2.Font:=rpHFont  ;
  QRExpr1.Font:=rpHFont;

end;


procedure Trpbuy.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure Trpbuy.aqryEmplSrvcCalcFields(DataSet: TDataSet);
var
  lastChargeDate : string;
  lastChargeCode : Integer; //kaveh
begin

  DataSet.FieldByName('Balance').AsCurrency := CalculBalance(DataSet.FieldByName('dtlEmplNo').AsString,'','',lastChargeDate, lastChargeCode); //kaveh
  DataSet.FieldByName('kharid').AsCurrency :=  Calculkharid(DataSet.FieldByName('dtlEmplNo').AsString);
// DataSet.FieldByName('kharid').AsCurrency := DataSet.FieldByName('Balance').AsCurrency - DataSet.FieldByName('kharid').AsCurrency;
end;

procedure Trpbuy.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//QRLabel2.Caption:=inttostr(aqryEmplSrvc.FieldByName('SumOfGrpPrice').asinteger +strtoint(QRLabel2.Caption));
end;

end.
