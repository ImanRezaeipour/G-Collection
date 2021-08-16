unit RpSrvEm2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,DateProc ;

type
  TqrptEmplSrvc2 = class(TQuickRep)
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
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    grpPub: TQRGroup;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    clmnGroup: TQRBand;
    clmnHead: TQRChildBand;
    lbl9: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    lbl8: TQRLabel;
    lblSrvcs: TQRLabel;
    grpDate: TQRGroup;
    aqryEmplSrvc: TADOQuery;
    QRLabel1: TQRLabel;
    lblPub: TQRLabel;
    txtGroup: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRLabel2: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    QRLabel4: TQRLabel;
    _lblRemainDate: TQRLabel;
    lblRemainDate: TQRLabel;
    lblRBedeh: TQRLabel;
    lblRemain: TQRLabel;
    QRExpr1: TQRExpr;
    lblRemainDtl: TQRLabel;
    lblRBestan: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    lblBedeh: TQRLabel;
    lblBestan: TQRLabel;
    SummaryBand1: TQRBand;
    lbl11: TQRLabel;
    QRShape12: TQRShape;
    bndSign: TQRChildBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    lblAllRemain: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape13: TQRShape;
    QRLabel6: TQRLabel;
    QRShape14: TQRShape;
    QRLabel7: TQRLabel;
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure clmnHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText5Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    remain : Integer;
  public
    procedure SetWinF_Rpt;
  end;

implementation

uses
  Funcs, FntSel, DBS, Globals;

{$R *.DFM}



procedure TqrptEmplSrvc2.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;
end;


procedure TqrptEmplSrvc2.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  s : String;
  tm : integer;
begin

  s := '';
//  with frmDBS.adoQryG do
//  begin
//    SQL.Clear;
//    SQL.Add('SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE , TM as _TIME ');
//    SQL.Add('From (');
//    SQL.Add('SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT,CHARGE_time as TM FROM CHARGE');
//    SQL.Add('UNION');
//    SQL.Add('SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_DATE as DT , RECIT1_TIME as TM FROM RECEIPT1');
//    SQL.Add(')');

    //    SQL.Add('WHERE dt = ''' + aqryEmplSrvc.FieldByName('Recit1_Date').AsString + '''');
//    SQL.Add('AND en = ''' + aqryEmplSrvc.FieldByName('Empl_No').AsString + '''');
//    Open;
//    while not Eof do
//    begin
      QRLabel7.Caption:=getcodedepart(aqryEmplSrvc.FieldByName('_recc').Asinteger);

      if aqryEmplSrvc.FieldByName('fee').AsInteger > 0 then
        s := '‘«—é ò«—  '
      else
        s := 'ò”— «⁄ »«—';
//      Next;
//    end;
//    Close;
//  end;
  lblSrvcs.Caption := s+#254;
  tm := aqryEmplSrvc.FieldByName('_Time').AsInteger ;
  remain := remain + aqryEmplSrvc.FieldByName('fee').asinteger;
  lblRemainDtl.Caption := IntToStr(remain);
  if aqryEmplSrvc.FieldByName('fee').asinteger >0 then
  begin
    lblBestan.Caption := aqryEmplSrvc.FieldByName('fee').AsString;
    lblBedeh.Caption := '0';
  end
  else
  begin
    lblBedeh.Caption := IntToStr(-aqryEmplSrvc.FieldByName('fee').asinteger);
    lblBestan.Caption := '0';
  end;




end;

procedure TqrptEmplSrvc2.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptEmplSrvc2.QRDBText5Print(sender: TObject; var Value: string);
var
  a : integer;
begin
  a := StrToInt(Value);
  Value := FixLeft(inttostr(a div 60),'0',2) + ':' + FixLeft(inttostr(a mod 60),'0',2);
end;

procedure TqrptEmplSrvc2.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  SetWinF_Rpt;
end;

procedure TqrptEmplSrvc2.clmnHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  emplNo,lastCharge : string;
begin
  if PageNumber =1 then
  begin
    remain := strtoint(currtostr((CalculBalance(aqryEmplSrvc.FieldByName('EMPL_NO').AsString,'',AddDate(gOptions.fromDate,-1),lastCharge))));
    if remain >=0 then
      lblRBestan.Caption := IntToStr(remain)
    else
      lblRBedeh.Caption := IntToStr(-remain);
    lblRemain.Caption := IntToStr(remain);
    lblRemainDate.Caption := '„«‰œÂ  « ' + gOptions.fromDate;
  end
  else
    clmnHead.Height := 36;
end;

procedure TqrptEmplSrvc2.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllRemain.Caption := IntToStr(Remain);
end;

end.

