unit RpSrvEm4;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptEmplSrvc4 = class(TQuickRep)
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
    dtlData: TQRBand;
    aqryEmplSrvc: TADOQuery;
    grpEmpl: TQRGroup;
    bndEmpl: TQRBand;
    clmnHead: TQRChildBand;
    QRExpr2: TQRExpr;
    lbl5: TQRLabel;
    lbl6: TQRLabel;
    lbl7: TQRLabel;
    lbl8: TQRLabel;
    QRShape1: TQRShape;
    QRShape12: TQRShape;
    QRShape2: TQRShape;
    QRShape11: TQRShape;
    QRShape22: TQRShape;
    QRShape21: TQRShape;
    lbl9: TQRLabel;
    QRShape7: TQRShape;
    QRShape23: TQRShape;
    bndSign: TQRBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign5: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblRow: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    procedure grpEmplBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure dtlDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
  private
    row : Integer;

  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, Globals, FntSel;

{$R *.DFM}



procedure TqrptEmplSrvc4.SetWinF_Rpt;
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
  lbl9.Caption := (lbl9.Caption);
end;


procedure TqrptEmplSrvc4.grpEmplBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
end;

procedure TqrptEmplSrvc4.dtlDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(row);
  lblRow.Caption := IntToStr(row);
end;

procedure TqrptEmplSrvc4.QRDBText3Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
