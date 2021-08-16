unit RPOil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls, Db, AdoDB, DBS_Proc;

type
  TfrmRptOil = class(TForm)
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
    qryPFish: TAdoQuery;
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
    lblpass2: TQRLabel;
    QRShape14: TQRShape;
    lblpass3: TQRLabel;
    QRShape15: TQRShape;
    lblpass4: TQRLabel;
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
    lbl01: TQRLabel;
    lblDoc: TQRLabel;
    lbl02: TQRLabel;
    lbl03: TQRLabel;
    lbl04: TQRLabel;
    lblRamz: TQRLabel;
    lblUnit: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    lbl8: TQRLabel;
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    lbl12: TQRLabel;
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
    lbl05: TQRLabel;
    bndSign: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lbl1: TQRLabel;
    QRShape37: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape46: TQRShape;
    QRLabel5: TQRLabel;
    lbl7: TQRLabel;
    QRShape47: TQRShape;
    lbl6: TQRLabel;
    QRShape48: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape49: TQRShape;
    QRShape56: TQRShape;
    QRShape57: TQRShape;
    QRShape58: TQRShape;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRShape63: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    lbl5: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRShape68: TQRShape;
    QRShape69: TQRShape;
    QRShape70: TQRShape;
    QRShape71: TQRShape;
    lbl4: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRShape77: TQRShape;
    lbl3: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRShape80: TQRShape;
    QRShape81: TQRShape;
    QRShape82: TQRShape;
    QRShape83: TQRShape;
    lbl2: TQRLabel;
    QRShape84: TQRShape;
    QRShape85: TQRShape;
    QRShape86: TQRShape;
    QRShape87: TQRShape;
    QRShape88: TQRShape;
    QRShape89: TQRShape;
    QRShape90: TQRShape;
    QRShape91: TQRShape;
    QRShape92: TQRShape;
    QRShape93: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    lblJob: TQRLabel;
    lblpass1: TQRLabel;
    QRShape96: TQRShape;
    PageFooterBand1: TQRBand;
    QRExpr1: TQRExpr;
    lbl13: TQRLabel;
    QRBand2: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel6: TQRLabel;
    QRExpr3: TQRExpr;
    QRLabel2: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure qrptPFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
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

procedure TfrmRptOil.SetWinF;
begin
end;

procedure TfrmRptOil.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPFish.connection := frmDBS.DBConnection;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptOil.DetailBand1BeforePrint(Sender: TQRCustomBand;
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

  pass := FixLeft(pass, ' ', 4);
  lblpass1.Caption := pass[1];
  lblpass2.Caption := pass[2];
  lblpass3.Caption := pass[3];
  lblpass4.Caption := pass[4];

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

procedure TfrmRptOil.qrptPFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPFish.Font.Name := RptFont;
  qrptPFish.Font.Size := RptFntSize;
end;

end.
