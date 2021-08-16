unit RpEnter;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,timetool,
  ADODB, jpeg;

type
  TqrptEnter = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    lblCoName: TQRLabel;
    DetailBand1: TQRBand;
    lblName: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
    lblFTDate: TQRLabel;
    QRLabel1: TQRLabel;
    Label2: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape3: TQRShape;
    name: TQRLabel;
    family: TQRLabel;
    Box: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape2: TQRShape;
    QRLabel5: TQRLabel;
    contract: TQRLabel;
    QRLabel10: TQRLabel;
    ADOQuery1: TADOQuery;
    QRLabel11: TQRLabel;
    QRDBText1: TQRDBText;
    QRImage1: TQRImage;
    QRLabel4: TQRLabel;
    Code: TQRLabel;
    QRLabel7: TQRLabel;
    BranchCode: TQRLabel;
    BranchName: TQRLabel;
    QRLabel13: TQRLabel;
  private

  public
    procedure RPTSetWinF;
  end;


implementation

uses
  Globals, DBS, Funcs;

{$R *.DFM}

procedure TqrptEnter.RPTSetWinF;
begin
  lblCoName.Font.Name := F_Params.RptTitleFont;
  lblCoName.Font.Size := F_Params.RptTitleFntSize;
  lblName.Font.Name := F_Params.RptTitleFont;
  lblName.Font.Size := F_Params.RptTitleFntSize;
  Font.Name := F_Params.RptFont;
  Font.Size := F_Params.RptFntSize;
end;

end.
