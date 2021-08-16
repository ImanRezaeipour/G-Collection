unit RpCharge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptCharge = class(TForm)
    qryCharge: TADOQuery;
    qrptCharge: TQuickRep;
    dtlRecs: TQRBand;
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
    lblRepDate: TQRLabel;
    bndAll: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lbl4: TQRLabel;
    QRShape12: TQRShape;
    lbl5: TQRLabel;
    QRShape13: TQRShape;
    lbl6: TQRLabel;
    QRShape14: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    bndSign: TQRChildBand;
    lbl10: TQRLabel;
    QRShape3: TQRShape;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRShape1: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRExpr1: TQRExpr;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRExpr2: TQRExpr;
    QRShape7: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FoodBndBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndAllAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndAllBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptChargeBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
//    AllPrice : integer;

    procedure SetWinF;

  public
    { Public declarations }

    MokhPrc : Boolean;
    EDate : String;
  end;

implementation

{$R *.DFM}
procedure TfrmRptCharge.SetWinF;
begin
end;

procedure TfrmRptCharge.FormCreate(Sender: TObject);
begin
//  SetWinF;
//  grpFood.Height := 0;
//  dtlRecs.Height := 0;
  qrycharge.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
//  AllPrice := 0;
end;

procedure TfrmRptCharge.FoodBndBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
//var
//  price: integer;
begin
//  lbluser.Caption := qrycharge.fieldbyname('ch_user').asstring;
//  lblperson.Caption := qrycharge.fieldbyname('p_name').asstring+' '+qrycharge.fieldbyname('p_family').asstring;
//  lbldate1.Caption := qrycharge.fieldbyname('ch_date').asstring;
//  lbltime1.Caption := inttotime(qrycharge.fieldbyname('ch_time').asinteger);
//  price:=qrycharge.fieldbyname('ch_price').asinteger;
//  lblPrice.Caption := IntToStr(price);
//  allprice:=allprice+price;
end;

procedure TfrmRptCharge.bndAllAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
//  AllPrice := 0;
end;

procedure TfrmRptCharge.bndAllBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  lblAllPrice.Caption := IntToStr(AllPrice);
end;

procedure TfrmRptCharge.qrptChargeBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptcharge.Font.Name := RptFont;
  qrptcharge.Font.Size := RptFntSize;
end;

end.
