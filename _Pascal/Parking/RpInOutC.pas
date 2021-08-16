unit RpInOutC;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, AdoDB, Qrctrls, Globals, DateProc, FarsiApi,
  DBS;

type
  TfrmRptInOutCo = class(TForm)
    qryInOutCo: TADOQuery;
    qrptMachines: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRSysData1: TQRSysData;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel16: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel14: TQRLabel;
    QRLabel20: TQRLabel;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    qryInOutCoIO_CarNumber: TWideStringField;
    qryInOutCoIO_Serial: TWideStringField;
    qryInOutCoIO_BarCode: TWideStringField;
    qryInOutCoCo_Name: TWideStringField;
    qryInOutCoCo_Color: TWideStringField;
    qryInOutCoIO_ODate: TWideStringField;
    qryInOutCoIO_OTime: TWideStringField;
    qryInOutCoIO_IDate: TWideStringField;
    qryInOutCoIO_ITime: TWideStringField;
    qryInOutCoIO_OAmper: TIntegerField;
    qryInOutCoIO_IAmper: TIntegerField;
    qryInOutCoIO_Mojavez: TWideStringField;
    qryInOutCoIO_Target: TWideStringField;
    qryInOutCoIO_Describe: TWideStringField;
    QRLabel24: TQRLabel;
    QRShape25: TQRShape;
    QRSysData4: TQRSysData;
    QRShape26: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    qryInOutCoP_Name: TWideStringField;
    qryInOutCoP_Family: TWideStringField;
    qryInOutCoIO_Driver: TWideStringField;
    qryInOutCoP_Family_Name: TWideStringField;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel25: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryInOutCoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmRptInOutCo.SetWinF;
begin
  Caption := (Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
//  QRLabel10.Caption := (QRLabel10.Caption);
//  QRLabel11.Caption := (QRLabel11.Caption);
//  QRLabel12.Caption := (QRLabel12.Caption);
//  QRLabel13.Caption := (QRLabel13.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  QRLabel21.Caption := (QRLabel21.Caption);
  QRLabel22.Caption := (QRLabel22.Caption);
  QRLabel23.Caption := (QRLabel23.Caption);
  qrptMachines.ReportTitle := (qrptMachines.ReportTitle);
end;

procedure TfrmRptInOutCo.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryInOutCo.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptInOutCo.qryInOutCoCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
     FieldByName('P_Family_Name').AsString := FieldByName('P_Family').AsString + '-' +
                                              FieldByName('P_Name').AsString;
{     FieldByName('Number').AsString := ConvertToFarsi(FieldByName('CO_CarNumber').AsString);
     FieldByName('CitySerial').AsString := FieldByName('Co_City').AsString;
     if FieldByName('Co_Serial').AsString <> '' then
       FieldByName('CitySerial').AsString := FieldByName('CitySerial').AsString + '-' +
                                             FieldByName('Co_Serial').AsString;
     FieldByName('IPerson').AsString := GetPersonName(FieldByName('IO_IPerson').AsString);
     FieldByName('IDoor').AsString := GetDoorName(FieldByName('IO_IDoor').AsInteger);
     FieldByName('OPerson').AsString := GetPersonName(FieldByName('IO_OPerson').AsString);
     FieldByName('ODoor').AsString := GetDoorName(FieldByName('IO_ODoor').AsInteger);
}
   end;
end;


end.
