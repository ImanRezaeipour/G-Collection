unit RpAmar1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

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
    lbls_name: TQRLabel;
    QRLabel3: TQRLabel;
    lblmablagh: TQRLabel;
    SummaryBand2: TQRBand;
    lbl11: TQRLabel;
    QRShape5: TQRShape;
    QRExpr2: TQRExpr;
    lblReptime: TQRLabel;
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel;

{$R *.DFM}



procedure TqrptAmar1.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;


procedure TqrptAmar1.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbls_name.Caption:=qry.FieldByName('s_name').asstring;
  lblmablagh.Caption:=qry.FieldByName('mablagh').asstring;
end;

procedure TqrptAmar1.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
