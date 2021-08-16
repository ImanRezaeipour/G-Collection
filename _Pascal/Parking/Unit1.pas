unit Unit1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, AdoDB;

type
  TQuickReport1 = class(TQuickRep)
    Query1: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
  private

  public

  end;

var
  QuickReport1: TQuickReport1;

implementation

{$R *.DFM}

end.
