unit RpAmar3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,timetool;

type
  TqrptAmar3 = class(TQuickRep)
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
    lbltime: TQRLabel;
    lbldate1: TQRLabel;
    lblradif: TQRLabel;
    lblmandeh1: TQRLabel;
    qry2: TADOQuery;
    QRShape5: TQRShape;
    QRShape12: TQRShape;
    QRLabel7: TQRLabel;
    lblfamilyname1: TQRLabel;
    lblDelRemain: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    procedure SetWinF_Rpt;
    function lastcharge(cardno: string;fdate:string):currency;

  end;
var
  date1,cardno1: string;


implementation

uses
  Funcs, FntSel, DBS;

{$R *.DFM}


var
  radif,mandeh : integer;

procedure TqrptAmar3.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;

function TqrptAmar3.lastcharge(cardno: string;fdate:string):currency;
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
      charge:=qry2.FieldByName('mablagh1').AsCurrency;
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
      charge:=charge-qry2.FieldByName('mablagh1').AsCurrency;
  end;
  qry2.Close;

  result:=charge;
end;


procedure TqrptAmar3.SummaryBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblmandeh1.Caption:=inttostr(mandeh);
end;

procedure TqrptAmar3.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  mablagh,code : integer;
  mablaghst : string;
begin
  inc(radif);
  lblradif.Caption:=inttostr(radif);
  mablaghst:=qry.FieldByName('mablagh1').asstring;
  if mablaghst=''
  then mablagh:=0
  else mablagh:=strtoint(mablaghst);
  code:=qry.FieldByName('code1').asinteger;
//kaveh is
  case code of
    1:begin
       lblcharge.Caption:=mablaghst;
       lblpardakht.Caption:='----';
       lblDelRemain.Caption:='----';
       inc(mandeh,mablagh);
    end;
    2:begin
       lblcharge.Caption:='----';
       lblpardakht.Caption:=mablaghst;
       lblDelRemain.Caption:='----';
       dec(mandeh,mablagh);
    end;
    3:begin
       lblcharge.Caption:='----';
       lblpardakht.Caption:='----';
       lblDelRemain.Caption:=mablaghst;
       dec(mandeh,mablagh);
    end;  
  end;

//kaveh ie
{kaveh
  if code=1
  then begin
       lblcharge.Caption:=mablaghst;
       lblpardakht.Caption:='----';
       inc(mandeh,mablagh);
  end
  else begin
       lblcharge.Caption:='----';
       lblpardakht.Caption:=mablaghst;
       dec(mandeh,mablagh);
  end;
kaveh}
  lblmandeh.Caption:=inttostr(mandeh);
  lblfamilyname1.Caption:=qry.FieldByName('Empl_Family').asstring+' '+qry.FieldByName('Empl_Name').asstring;
  lbldate1.Caption:=qry.FieldByName('date1').asstring;
  if qry.FieldByName('time1').asstring=''
  then lbltime.Caption:=''
  else lbltime.Caption:=inttotime(qry.FieldByName('time1').asinteger);
end;

procedure TqrptAmar3.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptAmar3.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   radif:=0;
   qry2.Connection := frmDBS.adoConnect;
   mandeh:=trunc(lastcharge(cardno1,date1));
end;

end.
