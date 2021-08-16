unit RpLotter;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TrpLotter = class(TQuickRep)
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
    clmnHead: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    lbl5: TQRLabel;
    lbl10: TQRLabel;
    QRShape1: TQRShape;
    QRShape4: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRSysData3: TQRSysData;
    lbl6: TQRLabel;
    shp1: TQRShape;
    shp2: TQRShape;
    bndSign: TQRChildBand;
    bndDescribe: TQRChildBand;
    lblgrp: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    qrylotter: TADOQuery;
    DataSource1: TDataSource;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText5: TQRDBText;
    procedure clmnHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
  private

  public
    procedure SetWinF_Rpt;

  end;


var
   isreader,isdept : boolean;



implementation

uses
  Funcs, FntSel, DBS;

{$R *.DFM}



procedure TrpLotter.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;


procedure TrpLotter.QRExpr1Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TrpLotter.clmnHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if isdept then lblgrp.Caption:='„—ò“';
  if isreader then lblgrp.Caption:='œ” ê«Â';
end;

end.
