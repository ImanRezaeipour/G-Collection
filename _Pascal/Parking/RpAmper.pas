unit RpAmper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, FarsiApi;

type
  TfrmRptAmper = class(TForm)
    qryAmper: TAdoQuery;
    qrptAmper: TQuickRep;
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
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
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
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    qryAmperIO_BarCode: TStringField;
    qryAmperIO_Driver: TStringField;
    qryAmperIO_ODoor: TSmallintField;
    qryAmperIO_OPerson: TStringField;
    qryAmperIO_ODate: TStringField;
    qryAmperIO_OTime: TStringField;
    qryAmperIO_OAmper: TIntegerField;
    qryAmperIO_Target: TStringField;
    qryAmperIO_Mojavez: TStringField;
    qryAmperIO_Describe: TStringField;
    qryAmperIO_IDoor: TSmallintField;
    qryAmperIO_IPerson: TStringField;
    qryAmperIO_IDate: TStringField;
    qryAmperIO_ITime: TStringField;
    qryAmperIO_IAmper: TIntegerField;
    qryAmperIO_IsPark: TBooleanField;
    qryAmperCo_BarCode: TStringField;
    qryAmperCo_CarNumber: TStringField;
    qryAmperCo_City: TStringField;
    qryAmperCo_Serial: TStringField;
    qryAmperCo_Name: TStringField;
    qryAmperCo_Color: TStringField;
    qryAmperNumber: TStringField;
    qryAmperCitySerial: TStringField;
    QRShape1: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
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
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRExpr1: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure qryAmperCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses DBS;

{$R *.DFM}


procedure TfrmRptAmper.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  qrptAmper.ReportTitle := (qrptAmper.ReportTitle);
end;

procedure TfrmRptAmper.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryAmper.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;





















procedure TfrmRptAmper.qryAmperCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('Number').AsString := ConvertToFarsi(FieldByName('Co_CarNumber').AsString);
    if FieldByName('Co_Serial').AsString = '' then
      FieldByName('CitySerial').AsString := FieldByName('Co_City').AsString
    else
      FieldByName('CitySerial').AsString := FieldByName('Co_City').AsString + ' - ' +
                                            FieldByName('Co_Serial').AsString;  
  end;
end;

end.
