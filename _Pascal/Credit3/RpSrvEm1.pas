unit RpSrvEm1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptEmplSrvc1 = class(TQuickRep)
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
    lbl11: TQRLabel;
    QRShape5: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRSysData3: TQRSysData;
    QRShape13: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    aqryEmplSrvc: TADOQuery;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    grpPub: TQRGroup;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    clmnGroup: TQRBand;
    clmnHead: TQRChildBand;
    lbl5: TQRLabel;
    lbl7: TQRLabel;
    lbl8: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    lbl6: TQRLabel;
    QRShape12: TQRShape;
    txtGroup: TQRDBText;
    lblPub: TQRLabel;
    QRExpr2: TQRExpr;
    PageFooterBand1: TQRBand;
    QRExpr3: TQRExpr;
    procedure QRDBText2Print(sender: TObject; var Value: String);
  private

  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel;

{$R *.DFM}



procedure TqrptEmplSrvc1.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

  ReportTitle := (ReportTitle);
  lblName.Caption := (lblName.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl11.Caption := (lbl11.Caption);
end;


procedure TqrptEmplSrvc1.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
