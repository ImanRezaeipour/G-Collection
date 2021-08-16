unit RpRemain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, FarsiApi,
  DBS_Proc;

type
  TfrmRptRemain = class(TForm)
    qryPerson: TAdoQuery;
    qrptRemain: TQuickRep;
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
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    bndGrpFooter: TQRBand;
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
    lblPCode: TQRLabel;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRLabel5: TQRLabel;
    lblremain: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptRemainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptRemain.SetWinF;
begin
end;

procedure TfrmRptRemain.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPerson.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptRemain.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryPerson do
  begin
    lblPCode.Caption := DelLeftZero(FieldByName('P_BarCode').AsString);
    lblGroup.Caption := GetGroupNameInDB(FieldByName('P_ShiftGroup').AsInteger);
    lblPart.Caption := GetPartNam(FieldByName('P_parts').Asstring);
    lblremain.Caption:= Format('%m', [FieldByName('P_Credit').AsCurrency]);
  end;
end;


procedure TfrmRptRemain.qrptRemainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptRemain.Font.Name := RptFont;
  qrptRemain.Font.Size := RptFntSize;
end;

end.
