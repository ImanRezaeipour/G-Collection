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

  end;





implementation

uses
  Funcs, FntSel;

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
  mablaghst:=qry.FieldByName('mablagh').asstring;
  if mablaghst=''
  then mablagh:=0
  else mablagh:=strtoint(mablaghst);
  code:=qry.FieldByName('code').asinteger;
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
  lblmandeh.Caption:=inttostr(mandeh);
  lbldate1.Caption:=qry.FieldByName('date').asstring;
  if qry.FieldByName('time').asstring=''
  then lbltime.Caption:=''
  else lbltime.Caption:=inttotime(qry.FieldByName('time').asinteger);
end;

procedure TqrptAmar3.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptAmar3.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   radif:=0;
   mandeh:=0;
end;

end.
