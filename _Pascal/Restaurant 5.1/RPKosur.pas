unit RpKosur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls, Db, DBTables, DBS_Proc;

type
  TfrmRpTradodP = class(TForm)
    qrptPFish: TQuickRep;
    DetailBand1: TQRBand;
    bandCoName: TQRBand;
    lblCoName: TQRLabel;
    QRChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lblDate1: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lblTime1: TQRLabel;
    lblPage: TQRLabel;
    QRSysData1: TQRSysData;
    qryPFish: TQuery;
    QRShape8: TQRShape;
    lblno1: TQRLabel;
    QRShape3: TQRShape;
    QRShape1: TQRShape;
    QRShape4: TQRShape;
    lblno2: TQRLabel;
    QRShape5: TQRShape;
    lblno3: TQRLabel;
    QRShape7: TQRShape;
    lblno4: TQRLabel;
    QRShape9: TQRShape;
    lblno5: TQRLabel;
    QRShape10: TQRShape;
    lblno6: TQRLabel;
    QRShape11: TQRShape;
    lblno7: TQRLabel;
    QRShape12: TQRShape;
    lblno8: TQRLabel;
    QRShape13: TQRShape;
    lblpass1: TQRLabel;
    QRShape14: TQRShape;
    lblpass2: TQRLabel;
    QRShape15: TQRShape;
    lblpass3: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    lblPrc1: TQRLabel;
    QRShape31: TQRShape;
    lblPrc2: TQRLabel;
    QRShape32: TQRShape;
    lblPrc3: TQRLabel;
    QRShape33: TQRShape;
    lblPrc4: TQRLabel;
    QRShape34: TQRShape;
    lblPrc5: TQRLabel;
    QRShape35: TQRShape;
    lblPrc6: TQRLabel;
    lblPrc7: TQRLabel;
    QRShape36: TQRShape;
    lblConst: TQRLabel;
    lblRepDate: TQRLabel;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    lbl11: TQRLabel;
    lblDoc: TQRLabel;
    lbl13: TQRLabel;
    lbl14: TQRLabel;
    lbl16: TQRLabel;
    lblRamz: TQRLabel;
    lblUnit: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    lbl1: TQRLabel;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
    lbl4: TQRLabel;
    lbl5: TQRLabel;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    ChildBand2: TQRChildBand;
    QRShape6: TQRShape;
    QRShape2: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape23: TQRShape;
    QRShape30: TQRShape;
    lblno0: TQRLabel;
    lblno00: TQRLabel;
    lblpass0: TQRLabel;
    lblejra0: TQRLabel;
    lblejra00: TQRLabel;
    lblmelak0: TQRLabel;
    lblmelak00: TQRLabel;
    lblrial00: TQRLabel;
    lblrial0: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    bndSign: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lbl0: TQRLabel;
    QRExpr1: TQRExpr;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
    pass, cnst : String;
  end;


implementation

uses
  Globals, DateProc;

{$R *.DFM}

procedure TfrmRpTradodP.SetWinF;
begin
  Caption := (Caption);
  lblPage.Caption := (lblPage.Caption);
  lblDate1.Caption := (lblDate1.Caption);
  lblTime1.Caption := (lblTime1.Caption);
  lblName.Caption := (lblName.Caption);
  lbl0.Caption := (lbl0.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  qrptPFish.ReportTitle := (qrptPFish.ReportTitle);
end;

procedure TfrmRpTradodP.FormCreate(Sender: TObject);
begin
  SetWinF;
//  qryPFish.DatabaseName := g_options.DataBasePath;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRpTradodP.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
   tno, prc : string;
begin
  tno := FixLeft(DelLeftZero(qryPFish.FieldByName('Fish_PCode').AsString), ' ', 8);
  lblno1.Caption := tno[1];
  lblno2.Caption := tno[2];
  lblno3.Caption := tno[3];
  lblno4.Caption := tno[4];
  lblno5.Caption := tno[5];
  lblno6.Caption := tno[6];
  lblno7.Caption := tno[7];
  lblno8.Caption := tno[8];

  pass := FixLeft(pass, ' ', 3);
  lblpass1.Caption := pass[1];
  lblpass2.Caption := pass[2];
  lblpass3.Caption := pass[3];

  lblConst.Caption := cnst;

  prc := FixLeft(FloatToStr(qryPFish.FieldByName('Prc').AsCurrency), ' ', 7);
  lblPrc1.Caption := prc[1];
  lblPrc2.Caption := prc[2];
  lblPrc3.Caption := prc[3];
  lblPrc4.Caption := prc[4];
  lblPrc5.Caption := prc[5];
  lblPrc6.Caption := prc[6];
  lblPrc7.Caption := prc[7];
end;

end.
