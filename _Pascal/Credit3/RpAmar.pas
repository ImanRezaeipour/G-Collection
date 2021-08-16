unit RpAmar;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptAmar = class(TQuickRep)
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
    lbltedad: TQRLabel;
    QRLabel3: TQRLabel;
    lbls_name: TQRLabel;
    SummaryBand2: TQRBand;
    QRExpr2: TQRExpr;
    lbl11: TQRLabel;
    QRShape5: TQRShape;
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



procedure TqrptAmar.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
//  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;


procedure TqrptAmar.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbls_name.Caption:=qry.FieldByName('s_name').asstring;
  lbltedad.Caption:=qry.FieldByName('tedad').asstring;
end;

procedure TqrptAmar.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
