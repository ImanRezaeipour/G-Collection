unit RpFdPrs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoods = class(TForm)
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
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    grpPartJob: TQRGroup;
    QRLabel5: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lblPay: TQRLabel;
    lblNoPay: TQRLabel;
    qry: TAdoQuery;
    lblFamily: TQRLabel;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    lblAllNotPay: TQRLabel;
    lblAllPay: TQRLabel;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    QRLabel7: TQRLabel;
    grpBarCode: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    ChildBand2: TQRChildBand;
    lblPCode: TQRLabel;
    TitleBand1: TQRBand;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    AllPay,
    AllNotPay : Currency;

    procedure SetWinF;
  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoods.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  lblFamily.Caption := (lblFamily.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoods.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsFoods.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
  qry.SQL.Clear;
  qry.SQL.Add('SELECT SUM(FF_Price) AS Prc, SUM(FF_Pay) As Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFood.FieldByName('P_BarCode').AsString + '''');
  qry.SQL.Add('AND FF_Date >= ''' + StartDate + '''');
  qry.SQL.Add('AND FF_Date <= ''' + EndDate + '''');
  if not Sobh_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
  if not Nahar_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
  if not Sham_Valid then
    qry.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));
  qry.Open;
  lblPay.Caption := Format('%m', [qry.FieldByName('Pay').AsCurrency]);
  lblNoPay.Caption := Format('%m', [qry.FieldByName('Prc').AsCurrency]);
  AllPay := AllPay + qry.FieldByName('Pay').AsCurrency;
  AllNotPay := AllNotPay + qry.FieldByName('Prc').AsCurrency;
  qry.Close;
end;

procedure TfrmRptPrsFoods.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
  lblAllNotPay.Caption := Format('%m', [AllNotPay]);
end;

procedure TfrmRptPrsFoods.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  AllPay := 0;
  AllNotPay := 0;
end;

procedure TfrmRptPrsFoods.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AllPay := 0;
  AllNotPay := 0;
end;

procedure TfrmRptPrsFoods.qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
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
