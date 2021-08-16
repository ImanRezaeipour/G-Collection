unit RpSrvcLs;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptService = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    aqrySrvc: TADOQuery;
    clmnHead: TQRBand;
    DetailBand1: TQRBand;
    lbl4: TQRLabel;
    lbl5: TQRLabel;
    lbl6: TQRLabel;
    lbl7: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    bndSign: TQRBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRSysData3: TQRSysData;
    lblUnit: TQRLabel;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    lbl8: TQRLabel;
    QRShape7: TQRShape;
    QRDBText3: TQRDBText;
    QRShape8: TQRShape;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
  private

  public
    procedure SetWinF_Rpt;

  end;


implementation

uses
  DBS, Funcs, FntSel;

{$R *.DFM}

procedure TqrptService.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

  ReportTitle := (ReportTitle);
  lblName.Caption := (lblName.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
end;

procedure TqrptService.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblUnit.Caption := GetUnitName(aqrySrvc.FieldByName('S_Unit').AsInteger);
end;

procedure TqrptService.QRDBText3Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
