unit RpBrCdCr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler,
  FarsiApi;

type
  TfrmRptBarCodeCircle = class(TForm)
    qrptBarCode: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lbl1: TQRLabel;
    lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    qryBarCode: TAdoQuery;
    ColumnHeaderBand1: TQRBand;
    lbl10: TQRLabel;
    QRShape21: TQRShape;
    lbl9: TQRLabel;
    QRShape17: TQRShape;
    lbl11: TQRLabel;
    QRShape18: TQRShape;
    lbl12: TQRLabel;
    QRShape20: TQRShape;
    lbl13: TQRLabel;
    QRShape19: TQRShape;
    lbl14: TQRLabel;
    QRShape16: TQRShape;
    lbl7: TQRLabel;
    QRShape15: TQRShape;
    lbl8: TQRLabel;
    lbl6: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    lbl5: TQRLabel;
    DetailBand1: TQRBand;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    qryBarCodeM_BarCode: TStringField;
    qryBarCodeM_CarName: TStringField;
    qryBarCodeM_Number: TStringField;
    qryBarCodeM_CityName: TStringField;
    qryBarCodeM_Serial: TStringField;
    qryBarCodeM_Color: TStringField;
    qryBarCodeM_IDate: TStringField;
    qryBarCodeM_ITime: TStringField;
    qryBarCodeM_ODate: TStringField;
    qryBarCodeM_OTime: TStringField;
    qryBarCodeM_Kind: TSmallintField;
    qryBarCodeM_IDoor: TSmallintField;
    qryBarCodeM_ODoor: TSmallintField;
    qryBarCodeM_IPerson: TStringField;
    qryBarCodeM_OPerson: TStringField;
    qryBarCodeM_Price: TCurrencyField;
    qryBarCodeM_PayAble: TCurrencyField;
    qryBarCodeM_IsPark: TBooleanField;
    qryBarCodeCitySerial: TStringField;
    qryBarCodeTimes: TStringField;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    qryBarCodeNumber: TStringField;
    lblFromToDate: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryBarCodeCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptBarCodeCircle.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl9.Caption := (lbl9.Caption);
  lbl10.Caption := (lbl10.Caption);
  lbl11.Caption := (lbl11.Caption);
  lbl12.Caption := (lbl12.Caption);
  lbl13.Caption := (lbl13.Caption);
  lbl14.Caption := (lbl14.Caption);
  qrptBarCode.ReportTitle := (qrptBarCode.ReportTitle);
end;

procedure TfrmRptBarCodeCircle.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryBarCode.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptBarCodeCircle.qryBarCodeCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByname('Number').AsString := ConvertToFarsi(FieldByname('M_Number').AsString);
    if FieldByname('M_Serial').AsString <> '' then
      FieldByname('CitySerial').AsString := FieldByname('M_CityName').AsString + '-' +
                                            FieldByname('M_Serial').AsString
    else
      FieldByname('CitySerial').AsString := FieldByname('M_CityName').AsString;
    FieldByname('Times').AsString := FormatTimes(Differ(FieldByname('M_IDate').AsString,
                                                        FieldByname('M_ITime').AsString,
                                                        FieldByname('M_ODate').AsString,
                                                        FieldByname('M_OTime').AsString));
  end;
end;


end.
