unit RpDelRec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, FarsiApi,
  DBS;

type
  TfrmRptDelRec = class(TForm)
    qryDel: TAdoQuery;
    qrptDel: TQuickRep;
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
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    bndClmn: TQRBand;
    QRLabel4: TQRLabel;
    QRShape21: TQRShape;
    QRShape17: TQRShape;
    QRLabel10: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape3: TQRShape;
    QRLabel8: TQRLabel;
    QRShape4: TQRShape;
    QRLabel11: TQRLabel;
    QRShape5: TQRShape;
    QRLabel12: TQRLabel;
    QRShape10: TQRShape;
    QRLabel9: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape9: TQRShape;
    QRLabel14: TQRLabel;
    DetailBand1: TQRBand;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape22: TQRShape;
    QRShape24: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRSysData4: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRLabel5: TQRLabel;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRLabel17: TQRLabel;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape6: TQRShape;
    QRShape23: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRDBText4: TQRDBText;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    lbl24: TQRLabel;
    procedure FormCreate(Sender: TObject);
//    procedure qryDelCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;



implementation

{$R *.DFM}

procedure TfrmRptDelRec.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel13.Caption := (QRLabel13.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel11.Caption := (QRLabel11.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  qrptDel.ReportTitle := (qrptDel.ReportTitle);
end;

procedure TfrmRptDelRec.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryDel.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

{procedure TfrmRptDelRec.qryDelCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('CitySerial').AsString := FieldByName('D_CityName').AsString;
    if FieldByName('D_Serial').AsString <> '' then
      FieldByName('CitySerial').AsString := FieldByName('CitySerial').AsString  + '-' +
                                            FieldByName('D_Serial').AsString;

    if FieldByName('D_IsPark').AsBoolean then
      FieldByName('DelType').AsString := ('Õ–› Ê—Êœ')
    else
      FieldByName('DelType').AsString := ('Õ–› Œ—ÊÃ');

    FieldByName('Number').AsString := ConvertToFarsi(FieldByName('D_Number').AsString);
    FieldByName('ODoor').AsString := GetDoorName(FieldByName('D_ODoor').AsInteger);
    FieldByName('OPerson').AsString := GetPersonName(FieldByName('D_OPerson').AsString);
  end;
end;}

end.
