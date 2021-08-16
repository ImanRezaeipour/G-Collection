unit RpFdPrT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodT = class(TForm)
    qryPrsFood: TAdoQuery;
    qrptPrsFood: TQuickRep;
    DetailBand1: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel16: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape7: TQRShape;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    grpPartJob: TQRGroup;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel8: TQRLabel;
    lblFoods: TQRLabel;
    lblPay: TQRLabel;
    lblNoPay: TQRLabel;
    bndFooter: TQRBand;
    QRShape11: TQRShape;
    lblAllPay: TQRLabel;
    QRShape12: TQRShape;
    lblAllNoPay: TQRLabel;
    ChildBand2: TQRChildBand;
    qry: TAdoQuery;
    QRLabel9: TQRLabel;
    grpFamily: TQRGroup;
    lblJob: TQRLabel;
    lblPart: TQRLabel;
    QRExpr1: TQRExpr;
    lblFamily: TQRLabel;
    QRLabel1: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblVadeh: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndFooterBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFamilyBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    AllPay, AllNotPay : Currency;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoodT.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  lblPart.Caption := (lblPart.Caption);
  lblJob.Caption := (lblJob.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  lblFamily.Caption := (lblFamily.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoodT.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsFoodT.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  AllPay := 0;
  AllNotPay := 0;
end;

procedure TfrmRptPrsFoodT.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Pay, NotPay : Currency;
  s : String;
begin
  Pay := 0;
  NotPay := 0;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM FishFood');
  qry.SQL.Add('WHERE FF_FishNo = ' + qryPrsFood.FieldByName('Fish_No').AsString);
  qry.SQL.Add('AND FF_Type = ' + qryPrsFood.FieldByName('Fish_Type').AsString);
  qry.SQL.Add('AND FF_Date = ''' + qryPrsFood.FieldByName('Fish_Date').AsString + '''');
  qry.Open;
  s := '';
  while not qry.Eof do
  begin
    if s <> '' then s := s + ' - ';
    s := s + GetFoodNameInRam(qry.FieldByName('FF_Food').AsInteger);
    Pay := Pay + qry.FieldByName('FF_Pay').AsCurrency;
    NotPay := NotPay + qry.FieldByName('FF_Price').AsCurrency;
    qry.Next;
  end;
  qry.Close;

  lblFoods.Caption := s;
  lblPay.Caption := Format('%m', [Pay]);
  lblNoPay.Caption := Format('%m', [NotPay]);
  AllPay := AllPay + Pay;
  AllNotPay := AllNotPay + NotPay;

  case qryPrsFood.FieldByName('Fish_Type').AsInteger of
    MB_SOBH  : lblVadeh.Caption := ('’»Õ«‰Â');
    MB_NAHAR : lblVadeh.Caption := ('‰«Â«—');
    MB_SHAM  : lblVadeh.Caption := ('‘«„');
  end;
end;

procedure TfrmRptPrsFoodT.bndFooterBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
  lblAllNoPay.Caption := Format('%m', [AllNotPay]);
end;

procedure TfrmRptPrsFoodT.grpFamilyBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
end;

procedure TfrmRptPrsFoodT.qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFood.Font.Name := RptFont;
  qrptPrsFood.Font.Size := RptFntSize;
end;

end.
