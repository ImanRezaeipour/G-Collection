unit RpAmar44;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,timetool,dateproc;

type
  TqrptAmar44 = class(TQuickRep)
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
    SummaryBand1: TQRBand;
    bndSign: TQRChildBand;
    qry: TADOQuery;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    SummaryBand2: TQRBand;
    lbl11: TQRLabel;
    lblReptime: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    lblmandeh1: TQRLabel;
    qry2: TADOQuery;
    QRShape5: TQRShape;
    QRLabel7: TQRLabel;
    lblpardakht1: TQRLabel;
    lblcharge1: TQRLabel;
    lbllastcharge1: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    lblDelRemain1: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRLabel10: TQRLabel;
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    procedure SetWinF_Rpt;
    function lastcharge(cardno: string;fdate:string):currency;
var
  date1,date2,cardno1,stcoposts : string;

  end;


implementation

uses
  Funcs, FntSel, DBS;

{$R *.DFM}


var
  radif : longint;
  tlastcharge,tcharge,tmandeh,tpardakht,tdelremain: currency;

procedure TqrptAmar44.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;

function TqrptAmar44.lastcharge(cardno: string;fdate:string):currency;
var
  charge : currency;
begin
  if fdate=''
  then begin
    result:=0;
    exit;
  end;

  charge:=0;
  lastcharge:=0;
  qry2.SQL.Clear;
  qry2.SQL.add('select sum(GrpPrice) as mablagh1 ');
  qry2.SQL.add('from ChargeGrp,ChargeDtl,employee');
  qry2.SQL.add('where GrpCode=DtlCode');
  qry2.SQL.add('and Empl_No =DtlEmplNo');
  qry2.SQL.add(stcoposts);
  if FDate<>''
  then qry2.SQL.add('and GrpDate<'''+fDate+'''');
  if cardno <> '' then
    qry2.SQL.Add('AND DtlEmplNo = ''' + cardno + '''');
  qry2.open;
  if not qry2.Eof
  then begin
      charge:=qry2.FieldByName('mablagh1').Ascurrency;
  end;
  qry2.Close;

  qry2.SQL.Clear;
  qry2.SQL.add('select sum(Recit1_TotalPrice) as mablagh1 ');
  qry2.SQL.add('from Receipt1,employee');
  qry2.SQL.add('where 1=1');
  qry2.SQL.add('and Empl_No =Recit1_EmplNo');
  qry2.SQL.add(stcoposts);
  if FDate<>''
  then qry2.SQL.add('and Recit1_Date<'''+fDate+'''');
  if cardno <> '' then
    qry2.SQL.Add('AND Recit1_EmplNo = ''' + cardno + '''');
  qry2.open;
  if not qry2.Eof
  then begin
      charge:=charge-qry2.FieldByName('mablagh1').Ascurrency;
  end;
  qry2.Close;

  result:=charge;
end;


procedure TqrptAmar44.SummaryBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  lastcharge1,mandeh1,charge1,pardakht1,delremain1 : currency;
begin
  lastcharge1:=trunc(lastcharge(cardno1,date1));
  lbllastcharge1.Caption:=floattostr(lastcharge1);
  if date2=''
  then mandeh1:=trunc(lastcharge(cardno1,'1500/01/01'))
  else mandeh1:=trunc(lastcharge(cardno1,adddate(date2,1)));
  lblmandeh1.Caption:=floattostr(mandeh1);

  qry2.SQL.Clear;
  qry2.SQL.add('select sum(GrpPrice) as mablagh1');
  qry2.SQL.add('from ChargeGrp,ChargeDtl,employee');
  qry2.SQL.add('where GrpCode=DtlCode');
  qry2.SQL.add('and Empl_No =DtlEmplNo');
  qry2.SQL.add(stcoposts);
  if cardno1<>''
  then qry2.SQL.add('and DtlEmplNo='''+cardno1+'''');
  if Date1<>''
  then qry2.SQL.add('and GrpDate>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and GrpDate<='''+Date2+'''');
  qry2.open;
  if not qry2.Eof
  then begin
    lblcharge1.Caption:=floattostr(qry2.FieldByName('mablagh1').AsCurrency);
    charge1:=round(qry2.FieldByName('mablagh1').AsCurrency);
  end
  else begin
       lblcharge1.Caption:='0';
       charge1:=0;
  end;
  qry2.Close;

  qry2.SQL.Clear;
  qry2.SQL.add('select sum(Recit1_TotalPrice) as mablagh1');
  qry2.SQL.add('from Receipt1,employee');
  qry2.SQL.add('where 1=1');
//  qry2.SQL.add(' AND Recit1_Status <> 14 '); //kavbeh
  qry2.SQL.add(' AND (Recit1_Status <> 14 or Recit1_Status is null) '); //kavbeh
  qry2.SQL.add('and Empl_No =Recit1_EmplNo');
  qry2.SQL.add(stcoposts);
  if cardno1<>''
  then qry2.SQL.add('and Recit1_EmplNo='''+cardno1+'''');
  if Date1<>''
  then qry2.SQL.add('and Recit1_Date>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and Recit1_Date<='''+Date2+'''');
  qry2.open;
  if not qry2.Eof
  then begin
    lblpardakht1.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency));
    pardakht1:=round(qry2.FieldByName('mablagh1').Ascurrency);
  end
  else begin
       lblpardakht1.Caption:='0';
       pardakht1:=0;
  end;
  qry2.Close;

//kaveh is
  qry2.SQL.Clear;
  qry2.SQL.add('select sum(Recit1_TotalPrice) as mablagh1');
  qry2.SQL.add('from Receipt1,employee');
  qry2.SQL.add('where 1=1');
  qry2.SQL.add(' AND Recit1_Status = 14 ');
  qry2.SQL.add('and Empl_No =Recit1_EmplNo');
  qry2.SQL.add(stcoposts);
  if cardno1<>''
  then qry2.SQL.add('and Recit1_EmplNo='''+cardno1+'''');
  if Date1<>''
  then qry2.SQL.add('and Recit1_Date>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and Recit1_Date<='''+Date2+'''');
  qry2.open;
  if not qry2.Eof
  then begin
    lblDelRemain1.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency));
    delremain1:=round(qry2.FieldByName('mablagh1').Ascurrency);
  end
  else begin
       lblDelRemain1.Caption:='0';
       delremain1:=0;
  end;
  qry2.Close;
//kaveh ie

end;

procedure TqrptAmar44.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptAmar44.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   radif:=0;
   qry2.Connection := frmDBS.adoConnect;
   tmandeh:=0;
   tlastcharge:=0;
   tcharge:=0;
   tpardakht:=0;
   tdelremain:=0; //kaveh
end;

end.
