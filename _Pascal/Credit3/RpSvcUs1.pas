unit RpSvcUs1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptUsedSrvc1 = class(TQuickRep)
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
    clmnHead: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    lbl5: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRSysData3: TQRSysData;
    lbl6: TQRLabel;
    shp1: TQRShape;
    shp2: TQRShape;
    lblFoodDate: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    aqryReceipt: TADOQuery;
    bndSign: TQRChildBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    QRShape12: TQRShape;
    lblgrpp: TQRLabel;
    lblgrp: TQRLabel;
    procedure clmnHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure ChildBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
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



procedure TqrptUsedSrvc1.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

end;


procedure TqrptUsedSrvc1.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if lbl6.Enabled then
  begin
    if lblFoodDate.Caption <> aqryReceipt.FieldByName('Recit1_Date').AsString then
    begin
      lblFoodDate.Caption := aqryReceipt.FieldByName('Recit1_Date').AsString;
      lblFoodDate.Enabled := True;
    end
    else
      lblFoodDate.Enabled := False;
  end;
  if isdept
  then lblgrpp.Caption:=aqryReceipt.FieldByName('recit1_Department').AsString;
  if isreader
  then lblgrpp.Caption:=getreadername(aqryReceipt.FieldByName('recit1_Rdr').AsInteger);
end;

procedure TqrptUsedSrvc1.QRExpr1Print(sender: TObject; var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

procedure TqrptUsedSrvc1.ChildBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  lblFoodDate.Caption := '';
end;

procedure TqrptUsedSrvc1.clmnHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if isdept then lblgrp.Caption:='„—ò“';
  if isreader then lblgrp.Caption:='œ” ê«Â';
end;

end.
