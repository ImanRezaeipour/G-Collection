unit RpI_OAmr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, ExtCtrls, QuickRpt, Qrctrls;

type
  TfrmRptI_OAmar = class(TForm)
    qryMachines: TAdoQuery;
    qrptIOAmar: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblRptName: TQRLabel;
    QRLabel17: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRSysData1: TQRSysData;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    grpDoor: TQRGroup;
    grpPerson: TQRGroup;
    bndPerson: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    lblPerson: TQRLabel;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRExpr1: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel14: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure bndPersonBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
    IsArive : Boolean
  end;


implementation

uses
  Globals, DateProc, DBS;

{$R *.DFM}


procedure TfrmRptI_OAmar.SetWinF;
begin
  Caption := (Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
end;

procedure TfrmRptI_OAmar.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryMachines.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptI_OAmar.bndPersonBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if IsArive then
    lblPerson.Caption := GetPersonName(qryMachines.FieldByName('M_BarCode').AsString)
  else
    lblPerson.Caption := GetPersonName(qryMachines.FieldByName('M_BarCode').AsString)
end;

procedure TfrmRptI_OAmar.QRExpr1Print(sender: TObject; var Value: String);
begin
  value := '˛' + Value + (' œ” ê«Â');
end;

end.
