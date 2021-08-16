unit RpAmar4;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,timetool,dateproc;

type
  TqrptAmar4 = class(TQuickRep)
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
    QRShape9: TQRShape;
    qry: TADOQuery;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    lblpardakht: TQRLabel;
    QRLabel3: TQRLabel;
    lblmandeh: TQRLabel;
    SummaryBand2: TQRBand;
    lbl11: TQRLabel;
    lblReptime: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRShape4: TQRShape;
    QRLabel6: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    lblcharge: TQRLabel;
    lblfamilyname: TQRLabel;
    lblpno: TQRLabel;
    lblradif: TQRLabel;
    lblmandeh1: TQRLabel;
    qry2: TADOQuery;
    QRShape5: TQRShape;
    QRLabel7: TQRLabel;
    lbllastcharge: TQRLabel;
    QRShape12: TQRShape;
    QRLabel9: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    lblcardno: TQRLabel;
    lblpardakht1: TQRLabel;
    lblcharge1: TQRLabel;
    lbllastcharge1: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRLabel8: TQRLabel;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    lblghest: TQRLabel;
    QRShape21: TQRShape;
    lblghest1: TQRLabel;
    lbltghest: TQRLabel;
    lblDelRemain: TQRLabel;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRLabel10: TQRLabel;
    QRShape24: TQRShape;
    lblDelRemain1: TQRLabel;
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private

  public
    procedure SetWinF_Rpt;
    function lastcharge(cardno: string;fdate:string):currency;
var
  date1,date2,cardno1: string;
  tghest : integer;
  dontshowkharid,dontshowcharge,dontshowkharidcharge: boolean;

  end;


implementation

uses
  Funcs, FntSel, DBS;

{$R *.DFM}


var
  radif : longint;
  tlastcharge,tcharge,tmandeh,tpardakht,tdelremain: currency;
  f : textfile;

procedure TqrptAmar4.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;

function TqrptAmar4.lastcharge(cardno: string;fdate:string):currency;
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
  qry2.SQL.add('from ChargeGrp,ChargeDtl');
  qry2.SQL.add('where GrpCode=DtlCode');
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
  qry2.SQL.add('from Receipt1');
  qry2.SQL.add('where 1=1');
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


procedure TqrptAmar4.SummaryBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  closefile(f);
end;

procedure TqrptAmar4.SummaryBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblmandeh1.Caption:=floattostr(tmandeh);
  lbllastcharge1.Caption:=floattostr(tlastcharge);
  lblcharge1.Caption:=floattostr(tcharge);
  lblpardakht1.Caption:=floattostr(tpardakht);
  lblDelRemain1.Caption:=floattostr(tdelremain); //kaveh
  if tghest=0
  then lblghest1.Caption:=''
  else lblghest1.Caption:=inttostr(round(tpardakht/tghest));
end;

procedure TqrptAmar4.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  code : longint;
  lastcharge1,charge1,mandeh1,pardakht1, delremain1: currency;
  mustprint: boolean;
  ghest : integer;
begin
  inc(radif);
  lblradif.Caption:=inttostr(radif);
  cardno1:=qry.FieldByName('empl_NO').asstring;
  lblpno.caption:=cardno1;
  lblcardno.Caption:=qry.FieldByName('empl_ID').asstring+' ';
  lblfamilyname.Caption:=qry.FieldByName('empl_family').asstring+' '+qry.FieldByName('empl_name').asstring;
  lastcharge1:=trunc(lastcharge(cardno1,date1));
  lbllastcharge.Caption:=floattostr(lastcharge1);
  if date2=''
  then mandeh1:=trunc(lastcharge(cardno1,'1500/01/01'))
  else mandeh1:=trunc(lastcharge(cardno1,adddate(date2,1)));
  lblmandeh.Caption:=floattostr(mandeh1);

  qry2.SQL.Clear;
  qry2.SQL.add('select sum(GrpPrice) as mablagh1');
  qry2.SQL.add('from ChargeGrp,ChargeDtl');
  qry2.SQL.add('where GrpCode=DtlCode');
  if Date1<>''
  then qry2.SQL.add('and GrpDate>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and GrpDate<='''+Date2+'''');
  qry2.SQL.Add('AND DtlEmplNo = ''' + qry.FieldByName('empl_NO').asstring + '''');
  qry2.open;
  if not qry2.Eof
  then begin
    lblcharge.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency));
    charge1:=round(qry2.FieldByName('mablagh1').AsCurrency);
  end
  else begin
       lblcharge.Caption:='';
       charge1:=0;
  end;
  qry2.Close;

  qry2.SQL.Clear;
  qry2.SQL.add('select sum(Recit1_TotalPrice) as mablagh1');
  qry2.SQL.add('from Receipt1');
  qry2.SQL.add('where 1=1');
//  qry2.SQL.add(' AND Recit1_Status <> 14 '); //kaveh
  qry2.SQL.add(' AND (Recit1_Status <> 14 or Recit1_Status is null) '); //kaveh
  if Date1<>''
  then qry2.SQL.add('and Recit1_Date>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and Recit1_Date<='''+Date2+'''');
  qry2.SQL.Add('AND Recit1_EmplNo = ''' + qry.FieldByName('empl_NO').asstring + '''');qry2.open;
  if not qry2.Eof
  then begin
    lblpardakht.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency));
    pardakht1:=round(qry2.FieldByName('mablagh1').AsCurrency);
    if tghest=0
    then lblghest.Caption:=''
    else lblghest.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency/tghest));
  end
  else begin
       lblpardakht.Caption:='';
       pardakht1:=0;
  end;
  qry2.Close;

//kaveh is
  qry2.SQL.Clear;
  qry2.SQL.add('select sum(Recit1_TotalPrice) as mablagh1');
  qry2.SQL.add('from Receipt1');
  qry2.SQL.add('where 1=1');
  qry2.SQL.add(' AND Recit1_Status = 14 ');
  if Date1<>''
  then qry2.SQL.add('and Recit1_Date>='''+Date1+'''');
  if Date2<>''
  then qry2.SQL.add('and Recit1_Date<='''+Date2+'''');
  qry2.SQL.Add('AND Recit1_EmplNo = ''' + qry.FieldByName('empl_NO').asstring + '''');
  qry2.open;
  if not qry2.Eof
  then begin
    lblDelRemain.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency));
    delremain1:=round(qry2.FieldByName('mablagh1').AsCurrency);
//    if tghest=0
//    then lblghest.Caption:=''
//    else lblghest.Caption:=inttostr(round(qry2.FieldByName('mablagh1').AsCurrency/tghest));
  end
  else begin
       lblDelRemain.Caption:='';
       delremain1:=0;
  end;
  qry2.Close;
//kaveh ie

  mustprint:=true;
  if (pardakht1=0)and(charge1=0) and dontshowkharidcharge
    then mustprint:=false;
  if dontshowcharge and (charge1=0)
    then mustprint:=false;
  if (pardakht1=0) and dontshowkharid
    then mustprint:=false;
  if mustprint
  then begin
    tlastcharge:=tlastcharge+lastcharge1;
    tcharge:=tcharge+charge1;
    tpardakht:=tpardakht+pardakht1;
    tdelremain:=tdelremain+delremain1; //kaveh
    tmandeh:=tmandeh+mandeh1;
    DetailBand1.Height:=32;
    write(f,radif:8,';',cardno1:10,';',qry.FieldByName('empl_ID').asstring:10,';');
    write(f,qry.FieldByName('empl_family').asstring:30,';',qry.FieldByName('empl_name').asstring:20,';');
    write(f,round(lastcharge1):12,';',round(charge1):12,';',round(pardakht1):12,';');
    if tghest=0
    then ghest:=0
    else ghest:=round(pardakht1/tghest);
    if tghest=0
    then writeln(f,round(mandeh1):12)
    else writeln(f,ghest:12,';',round(mandeh1):12);
  end
  else begin
    DetailBand1.Height:=0;
    dec(radif);
  end;
end;

procedure TqrptAmar4.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptAmar4.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   radif:=0;
   qry2.Connection := frmDBS.adoConnect;
   tmandeh:=0;
   tlastcharge:=0;
   tcharge:=0;
   tpardakht:=0;
   tdelremain:=0; //kaveh
   
   assignfile(f,'report4.csv');
   rewrite(f);
end;

end.
