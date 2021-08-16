unit RpFdPrM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodM = class(TForm)
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
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    grpPartJob: TQRGroup;
    QRLabel5: TQRLabel;
    QRShape9: TQRShape;
    qry: TAdoQuery;
    lblFamily: TQRLabel;
    bndGrpDate: TQRBand;
    lblNoPay: TQRLabel;
    QRShape5: TQRShape;
    lblPay: TQRLabel;
    QRShape10: TQRShape;
    QRExpr1: TQRExpr;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    grpDateBarCode: TQRGroup;
    bndGrpPartJob: TQRBand;
    lblMonth: TQRLabel;
    lblAllNotPay: TQRLabel;
    QRShape2: TQRShape;
    lblAllPay: TQRLabel;
    QRShape7: TQRShape;
    QRLabel1: TQRLabel;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndGrpDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndGrpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndGrpPartJobAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    AllPay, AllNotPay : Currency;

    procedure SetWinF;
  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsFoodM.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  lblRepDate.Caption := (lblRepDate.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  lblFamily.Caption := (lblFamily.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  lblPart.Caption := (lblPart.Caption);
  lblJob.Caption := (lblJob.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoodM.FormCreate(Sender: TObject);
begin
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

  SetWinF;

  AllPay := 0;
  AllNotPay := 0;
end;

procedure TfrmRptPrsFoodM.bndGrpDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  SD, ED : String;
begin
  lblPCode.Caption := DelLeftZero(qryPrsFood.FieldByName('P_BarCode').AsString);
  SD := Copy(qryPrsFood.FieldByName('Fish_Date').AsString, 1, 8) + '01';
  ED := Copy(qryPrsFood.FieldByName('Fish_Date').AsString, 1, 8) + '31';
  if (StartDate <> '') and (SD < StartDate)  then
    SD := StartDate;
  if (EndDate <> '') and (ED > EndDate)  then
    ED := EndDate;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT SUM(FF_Price) AS Prc, SUM(FF_Pay) As Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFood.FieldByName('P_BarCode').AsString + '''');
  qry.SQL.Add('AND Fish_Date >= ''' + SD + '''');
  qry.SQL.Add('AND Fish_Date <= ''' + ED + '''');
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

  lblMonth.Caption := MonthName[StrToInt(Copy(SD, 6, 2))];
end;

procedure TfrmRptPrsFoodM.bndGrpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
  lblAllNotPay.Caption := Format('%m', [AllNotPay]);
end;

procedure TfrmRptPrsFoodM.bndGrpPartJobAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  AllPay := 0;
  AllNotPay := 0;
end;

procedure TfrmRptPrsFoodM.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
end;

procedure TfrmRptPrsFoodM.qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
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
