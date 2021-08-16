unit RpSrvEm6;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,dbs, xmldom, Provider,
  Xmlxform ;

type
  TqrptEmplSrvc6 = class(TQuickRep)
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
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    grpPub: TQRGroup;
    QRSubDetail1: TQRSubDetail;
    QRDBText6: TQRDBText;
    ADOTable1: TADOTable;
    ADOTable2: TADOTable;
    DataSource1: TDataSource;
    QRShape1: TQRShape;
    QRDBText5: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText3: TQRDBText;
    ADOTable3: TADOTable;
    DataSource2: TDataSource;
    QRLabel7: TQRLabel;
    XMLTransformProvider1: TXMLTransformProvider;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel8: TQRLabel;
    ADOTable2DtlCode: TIntegerField;
    ADOTable2Dtlmoved: TBooleanField;
    ADOTable2DtlEmplNo: TWideStringField;
    ADOTable1tim: TStringField;
    ADOTable1GRPCODE: TIntegerField;
    ADOTable1GRPTIME: TWideStringField;
    ADOTable1GrpDATE: TWideStringField;
    ADOTable1grpEXPIREDATE: TWideStringField;
    ADOTable1GRPPRICE: TBCDField;
    ADOTable1GRPDESc: TWideStringField;
    ADOTable2active: TStringField;
    ADOTable3Empl_No: TWideStringField;
    ADOTable3Empl_ID: TWideStringField;
    ADOTable3Empl_Name: TWideStringField;
    ADOTable3Empl_Family: TWideStringField;
    ADOTable3Empl_Active: TBooleanField;
    ADOTable3Empl_Department: TIntegerField;
    ADOTable3Empl_CoPost: TIntegerField;
    ADOTable3Empl_Part: TIntegerField;
    ADOTable3Empl_Dscnt: TIntegerField;
    ADOTable3Empl_ExpDate: TWideStringField;
    ADOTable3Empl_Balance: TBCDField;
    QRDBText2: TQRDBText;
    QRLabel9: TQRLabel;
    qrNo: TQRLabel;
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure aqryEmplSrvcCalcFields(DataSet: TDataSet);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    i : integer;

  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel,TimeTool;

{$R *.DFM}



procedure TqrptEmplSrvc6.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  DetailBand1.Font := rpHFont;
  QRSubDetail1.Font := rpHFont;

  ReportTitle := (ReportTitle);
  lblName.Caption := (lblName.Caption);

end;


procedure TqrptEmplSrvc6.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptEmplSrvc6.ADOTable1CalcFields(DataSet: TDataSet);
begin
if  DataSet.FieldByName('grptime').AsString <> '' then
  DataSet.FieldByName('tim').AsString := inttotime(strtoint(DataSet.FieldByName('grptime').AsString));


end;

procedure TqrptEmplSrvc6.ADOTable2CalcFields(DataSet: TDataSet);
begin
 with DataSet do
  begin
    if FieldByName('DtlMoved').AsBoolean then
      FieldByName('active').Asstring  := '»·Ì'
    else
     FieldByName('active').Asstring   := 'ŒÌ—';
end;
                                              

end;

procedure TqrptEmplSrvc6.aqryEmplSrvcCalcFields(DataSet: TDataSet);
 //var  lastChargeDate:string;
 begin

//  DataSet.FieldByName('Balance').AsCurrency := CalculBalance(DataSet.FieldByName('dtlEmplNo').AsString,'','',lastChargeDate);
 end;

procedure TqrptEmplSrvc6.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrno.caption := inttostr(i);
  inc(i);
with QRShape1.Brush do
begin
 if Color=clInactiveBorder  then
 color:=cl3DLight
 else
  color:= clInactiveBorder;
 end ;
 end;

procedure TqrptEmplSrvc6.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i := 1;
end;

end.
