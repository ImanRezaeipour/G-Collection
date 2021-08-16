unit RpAmar1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB,timetool;

type
  TqrptAmar1 = class(TQuickRep)
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
    lblfamilyname: TQRLabel;
    QRLabel3: TQRLabel;
    lblcardno: TQRLabel;
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
    lblmablagh: TQRLabel;
    lbltime: TQRLabel;
    lbldate1: TQRLabel;
    lblradif: TQRLabel;
    lblsum: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel7: TQRLabel;
    QRShape5: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape12: TQRShape;
    QRLabel10: TQRLabel;
    QRShape13: TQRShape;
    QRLabel11: TQRLabel;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRLabel12: TQRLabel;
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
  radif,sum : integer;

procedure TqrptAmar1.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;


procedure TqrptAmar1.SummaryBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblsum.Caption:=inttostr(sum);
end;

procedure TqrptAmar1.DetailBand1BeforePrint(Sender: TQRCustomBand;
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
  inc(sum,mablagh);
  lblmablagh.Caption:=qry.FieldByName('mablagh1').asstring;
  lblcardno.Caption:=qry.FieldByName('Empl_No').asstring;
  lblfamilyname.Caption:=qry.FieldByName('Empl_Family').asstring+' - '+qry.FieldByName('Empl_Name').asstring;
  lbldate1.Caption:=qry.FieldByName('date1').asstring;
  if qry.FieldByName('time1').asstring=''
  then lbltime.Caption:=''
  else lbltime.Caption:=inttotime(qry.FieldByName('time1').asinteger);
end;

procedure TqrptAmar1.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptAmar1.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   radif:=0;
   sum:=0;
end;

end.
