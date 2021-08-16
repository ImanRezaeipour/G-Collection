unit RpDiff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, AdoDB, StdCtrls, Mask, DBCtrls, Qrctrls,
  Globals, DateProc;

type
  TfrmRptDiff = class(TForm)
    QuickRep1: TQuickRep;
    SummaryBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    tpark: TQRLabel;
    tbank: TQRLabel;
    tbanknopark: TQRLabel;
    tparknobank: TQRLabel;
    tpark2bank: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape1: TQRShape;
    Query1: TAdoQuery;
    QRGroup1: TQRGroup;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRBand1: TQRBand;
    TEDAD: TQRLabel;
    MOGHTYPE: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRLabel2: TQRLabel;
    RADIF: TQRLabel;
    BARCODELBL1: TQRLabel;
    BARCODE1: TQRLabel;
    BARCODE2: TQRLabel;
    BARCODELBL2: TQRLabel;
    d_number: TQRLabel;
    d_city: TQRLabel;
    d_serial: TQRLabel;
    d_carname: TQRLabel;
    d_color: TQRLabel;
    d_date: TQRLabel;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel16: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel4: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     tparknobank1,
     tbanknopark1,
     tpark2bank1,
     TEDAD1:WORD;

    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptDiff.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel22.Caption := (QRLabel22.Caption);
  QRLabel21.Caption := (QRLabel21.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel13.Caption := (QRLabel13.Caption);
  QuickRep1.ReportTitle := (QuickRep1.ReportTitle);
end;

procedure TfrmRptDiff.FormCreate(Sender: TObject);
begin
  SetWinF;
  Query1.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
   tparknobank1:=0;
   tbanknopark1:=0;
   tpark2bank1:=0;
end;

procedure TfrmRptDiff.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   tparknobank.caption:=inttostr(tparknobank1);
   tbanknopark.caption:=inttostr(tbanknopark1);
   tpark2bank.caption:=inttostr(tpark2bank1);
end;

procedure TfrmRptDiff.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  INC(TEDAD1);
  RADIF.CAPTION:=INTTOSTR(TEDAD1);
  WITH QUERY1 DO
  begin
    d_number.Caption:=#254+fieldbyname('d_number').asstring;
    d_city.Caption:=fieldbyname('d_city').asstring;
    d_serial.Caption:=#254+fieldbyname('d_serial').asstring;
    d_carname.Caption:=fieldbyname('d_carname').asstring;
    d_color.Caption:=fieldbyname('d_color').asstring;
    d_date.Caption:=fieldbyname('d_date').asstring;
    case fieldbyname('d_type').asinteger of
      0:BEGIN
         inc(tparknobank1);
         BARCODE1.CAPTION:='';
         BARCODE2.CAPTION:='';
        END;
      1:BEGIN
         inc(tbanknopark1);
         BARCODE1.CAPTION:=FIELDBYNAME('D_BARCODE1').ASSTRING;
         BARCODE2.CAPTION:='';
        END;
      2:BEGIN
         inc(tpark2bank1);
         BARCODE1.CAPTION:=FIELDBYNAME('D_BARCODE1').ASSTRING;
         BARCODE2.CAPTION:=FIELDBYNAME('D_BARCODE2').ASSTRING;
        END;
    end;
  end;
end;

procedure TfrmRptDiff.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case query1.fieldbyname('d_type').asinteger of
     0:BEGIN
         MOGHTYPE.CAPTION:= ('·Ì”  „«‘Ì‰Â«ÌÌ ﬂÂ œ—Å«—ﬂÌ‰ê Â”  Êœ— ﬂ«„ÅÌÊ — ‰Ì” ');
         BARCODELBL1.CAPTION:='';
         BARCODELBL2.CAPTION:='';
       END;
     1:BEGIN
         MOGHTYPE.CAPTION:= ('·Ì”  „«‘Ì‰Â«ÌÌ ﬂÂ œ— ﬂ«„ÅÊ —Â”  Êœ— Å«—ﬂÌ‰ê ‰Ì” ');
         BARCODELBL1.CAPTION:= ('»«—ﬂœ');
         BARCODELBL2.CAPTION:='';
       END;
     2:BEGIN
         MOGHTYPE.CAPTION:= ('·Ì”  „«‘Ì‰Â«ÌÌ ﬂÂ œ—Å«—ﬂÌ‰ê Â”  Ê œ— ﬂ«„ÅÌÊ — œÊ»«—¬„œÂ');
         BARCODELBL1.CAPTION:= ('»«—ﬂœ «Ê·');
         BARCODELBL2.CAPTION:= ('»«—ﬂœ œÊ„');
       END;
  end;
  TEDAD1:=0;
end;

procedure TfrmRptDiff.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   TEDAD.CAPTION:=INTTOSTR(TEDAD1);
end;








end.
