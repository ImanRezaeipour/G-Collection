unit RpPerson;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, FarsiApi,
  DBS_Proc;

type
  TfrmRptPerson = class(TForm)
    qryPerson: TAdoQuery;
    qrptPerson: TQuickRep;
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
    grpPart: TQRGroup;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    lblIsValid: TQRLabel;
    lblValidTest: TQRLabel;
    lblPricable: TQRLabel;
    lblSobhaneh: TQRLabel;
    lblNahar: TQRLabel;
    lblSham: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    bndGrpFooter: TQRBand;
    QRLabel11: TQRLabel;
    QRShape1: TQRShape;
    QRLabel10: TQRLabel;
    QRShape2: TQRShape;
    QRLabel9: TQRLabel;
    QRShape3: TQRShape;
    QRLabel8: TQRLabel;
    QRShape4: TQRShape;
    QRLabel7: TQRLabel;
    QRShape5: TQRShape;
    QRLabel6: TQRLabel;
    QRShape6: TQRShape;
    QRLabel5: TQRLabel;
    QRShape7: TQRShape;
    QRLabel4: TQRLabel;
    QRShape8: TQRShape;
    QRLabel3: TQRLabel;
    QRShape9: TQRShape;
    QRLabel2: TQRLabel;
    QRShape10: TQRShape;
    QRLabel1: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRLabel14: TQRLabel;
    lblGroup: TQRLabel;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    lblPCode: TQRLabel;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPersonBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptPerson.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel13.Caption := (QRLabel13.Caption);
  qrptPerson.ReportTitle := (qrptPerson.ReportTitle);
end;

procedure TfrmRptPerson.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPerson.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPerson.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryPerson do
  begin
    lblPCode.Caption := DelLeftZero(FieldByName('P_BarCode').AsString);
    lblGroup.Caption := GetGroupNameInDB(FieldByName('P_ShiftGroup').AsInteger);
    lblJob.Caption := GetJobName(FieldByName('P_JobCode').AsInteger);
    lblPart.Caption := GetPartNam(FieldByName('P_parts').Asstring);
    if FieldByName('P_IsValid').AsBoolean then
      lblIsValid.Caption := ('œ«—œ')
    else
      lblIsValid.Caption := ('‰œ«—œ');

    if FieldByName('P_ValidTest').AsBoolean then
      lblValidTest.Caption := ('»·Ì')
    else
      lblValidTest.Caption := ('ŒÌ—');

    if FieldByName('P_Pricable').AsBoolean then
      lblPricable.Caption := ('«Œ– ÊÃÂ')
    else
      lblPricable.Caption := ('»œÊ‰ ÊÃÂ');

    if FieldByName('P_Sobhaneh').AsBoolean then
      lblSobhaneh.Caption := ('œ«—œ')
    else
      lblSobhaneh.Caption := ('‰œ«—œ');

    if FieldByName('P_Nahar').AsBoolean then
      lblNahar.Caption := ('œ«—œ')
    else
      lblNahar.Caption := ('‰œ«—œ');

    if FieldByName('P_Sham').AsBoolean then
      lblSham.Caption := ('œ«—œ')
    else
      lblSham.Caption := ('‰œ«—œ');
  end;
end;


procedure TfrmRptPerson.qrptPersonBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPerson.Font.Name := RptFont;
  qrptPerson.Font.Size := RptFntSize;
end;

end.
