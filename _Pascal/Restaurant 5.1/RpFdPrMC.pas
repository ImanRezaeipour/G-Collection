unit RpFdPrMC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsFoodMC = class(TForm)
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
    grpMonth: TQRGroup;
    qry: TAdoQuery;
    bndGrpPerson: TQRBand;
    lblPay: TQRLabel;
    QRShape10: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    lblMonth: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRLabel5: TQRLabel;
    QRShape3: TQRShape;
    lblCount: TQRLabel;
    QRShape9: TQRShape;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    lblRow: TQRLabel;
    grpBarCode: TQRGroup;
    bndMonth: TQRBand;
    QRShape2: TQRShape;
    QRExpr2: TQRExpr;
    QRShape5: TQRShape;
    lblAllPay: TQRLabel;
    QRLabel1: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndGrpPersonBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpMonthBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndMonthBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    AllPay : Currency;
    Row : Integer;

    procedure SetWinF;
  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
  end;

implementation

{$R *.DFM}
procedure TfrmRptPrsFoodMC.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  lblRepDate.Caption := (lblRepDate.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  lblPart.Caption := (lblPart.Caption);
  lblJob.Caption := (lblJob.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  lblCount.Caption := (lblCount.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  qrptPrsFood.ReportTitle := (qrptPrsFood.ReportTitle);
end;

procedure TfrmRptPrsFoodMC.FormCreate(Sender: TObject);
begin
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

  SetWinF;
end;

procedure TfrmRptPrsFoodMC.bndGrpPersonBeforePrint(Sender: TQRCustomBand;
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
  qry.SQL.Add('SELECT SUM(FF_Price + FF_Pay) AS Prc FROM Fish, FishFood');
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
  lblPay.Caption := Format('%m', [qry.FieldByName('Prc').AsCurrency]);
  AllPay := AllPay + qry.FieldByName('Prc').AsCurrency;
  qry.Close;

  lblRow.Caption := IntToStr(Row);
  Inc(Row);
end;

procedure TfrmRptPrsFoodMC.grpMonthBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Row := 1;
  AllPay := 0;
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFood.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFood.FieldByName('P_JobCode').AsInteger);
  lblMonth.Caption := MonthName[StrToInt(Copy(qryPrsFood.FieldByName('Fish_Date').AsString, 6, 2))];
end;

procedure TfrmRptPrsFoodMC.bndMonthBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
end;

procedure TfrmRptPrsFoodMC.qrptPrsFoodBeforePrint(Sender: TCustomQuickRep;
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
