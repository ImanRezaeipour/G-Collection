unit RpInOutA;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, AdoDB, Qrctrls, Globals, DateProc, FarsiApi,
  DBS;

type
  TfrmRptInOutAmar = class(TForm)
    qryMachines: TADOQuery;
    qrptMachines: TQuickRep;
    SummaryBand1: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel17: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRSysData1: TQRSysData;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    QRGroup1: TQRGroup;
    DetailBand1: TQRBand;
    QRExpr1: TQRExpr;
    SummaryBand2: TQRBand;
    QRExpr2: TQRExpr;
    lblCarNo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel14: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryMachinesCalcFields(DataSet: TDataSet);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmRptInOutAmar.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  lblCarNo.Caption := (lblCarNo.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  qrptMachines.ReportTitle := (qrptMachines.ReportTitle);
end;

procedure TfrmRptInOutAmar.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryMachines.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptInOutAmar.qryMachinesCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
     FieldByName('Number').AsString := ConvertToFarsi(FieldByName('M_Number').AsString);
     FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString;
     if FieldByName('M_Serial').AsString <> '' then
       FieldByName('CitySerial').AsString := FieldByName('CitySerial').AsString + '-' +
                                             FieldByName('M_Serial').AsString;
     FieldByName('IPerson').AsString := GetPersonName(FieldByName('M_IPerson').AsString);
     FieldByName('IDoor').AsString := GetDoorName(FieldByName('M_IDoor').AsInteger);
     FieldByName('OPerson').AsString := GetPersonName(FieldByName('M_OPerson').AsString);
     FieldByName('ODoor').AsString := GetDoorName(FieldByName('M_ODoor').AsInteger);
   end;
end;

procedure TfrmRptInOutAmar.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if qryMachines.FieldByName('M_IsPark').AsBoolean then
    lblCarNo.Caption := (': ⁄œ«œ ŒÊœ—ÊÂ«Ì „ÊÃÊœ œ— Å«—ﬂÌ‰ê')
  else
    lblCarNo.Caption := (': ⁄œ«œ ŒÊœ—ÊÂ«Ì Œ«—Ã ‘œÂ');
end;

end.
