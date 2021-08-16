﻿unit RpInOutPOSLS;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, AdoDB, Qrctrls, Globals, DateProc, FarsiApi,
  DBS;

type
  TfrmRptInOutPOSLS = class(TForm)
    qryMachines: TADOQuery;
    qrptMachines: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
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
    QRShape21: TQRShape;
    QRShape22: TQRShape;
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
    QRDBText5: TQRDBText;
    QRLabel16: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel20: TQRLabel;
    qryMachinesM_rdrCode: TSmallintField;
    qryMachinesM_BarCode: TWideStringField;
    qryMachinesM_Number: TWideStringField;
    qryMachinesM_Serial: TWideStringField;
    qryMachinesM_IDate: TWideStringField;
    qryMachinesM_ITime: TWideStringField;
    qryMachinesM_ODate: TWideStringField;
    qryMachinesM_OTime: TWideStringField;
    qryMachinesM_OperatorCode: TWideStringField;
    qryMachinesM_IsPark: TBooleanField;
    qryMachinesM_IsDeleted: TBooleanField;
    qryMachinesIOperatorCode: TStringField;
    qryMachinesOOperatorCode: TStringField;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    qryMachinesIrdrCode: TStringField;
    qryMachinesOrdrCode: TStringField;
    qryMachinesODate: TStringField;
    qryMachinesOTime: TStringField;
    qryMachinesRowCount: TIntegerField;
    QRShape28: TQRShape;
    QRLabel1: TQRLabel;
    QRShape29: TQRShape;
    QRSysData4: TQRSysData;
    QRShape23: TQRShape;
    lblDepartName: TQRLabel;
    QRExpr1: TQRExpr;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    qryMachinesIStatus: TStringField;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryMachinesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmRptInOutPOSLS.SetWinF;
begin
  Caption := (Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
//  QRLabel1.Caption := (QRLabel1.Caption);
//  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
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
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel20.Caption := (QRLabel20.Caption);
  qrptMachines.ReportTitle := (qrptMachines.ReportTitle);
end;

procedure TfrmRptInOutPOSLS.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryMachines.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
  QRShape1.Left := 0;
  QRShape1.Top := 0;
  QRShape1.Width := ColumnHeaderBand1.Width;
//  QRShape1.Height := ColumnHeaderBand1.Height - 1;
  QRShape2.Left := 0;
  QRShape2.Top := DetailBand1.Height - 4;
  QRShape2.Width := DetailBand1.Width;
//  QRShape2.Height := DetailBand1.Height - 1;
  QRShape23.Left := 0;
  QRShape23.Top := ColumnHeaderBand1.Height - 4;
  QRShape23.Width := ColumnHeaderBand1.Width;

end;

procedure TfrmRptInOutPOSLS.qryMachinesCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if (FieldByName('M_ODate').AsString = '') or (FieldByName('M_ODate').AsString = '0000/00/00') then
     begin
      FieldByName('IrdrCode').AsString := FieldByName('M_rdrCode').AsString;
      FieldByName('IOperatorCode').AsString := FieldByName('M_OperatorCode').AsString;
      FieldByName('OrdrCode').AsString := '';
      FieldByName('OOperatorCode').AsString := '';
      if FieldByName('IrdrCode').AsString = '' then
        FieldByName('IrdrCode').AsString := 'دستی';
     end
    else
     begin
      FieldByName('IrdrCode').AsString := '';
      FieldByName('IOperatorCode').AsString := '';
      FieldByName('OrdrCode').AsString := FieldByName('M_rdrCode').AsString;
      FieldByName('OOperatorCode').AsString := FieldByName('M_OperatorCode').AsString;
      if FieldByName('OrdrCode').AsString = '' then
        FieldByName('OrdrCode').AsString := 'دستی';
     end;
    if FieldByName('M_ODate').AsString = '0000/00/00' then
      FieldByName('ODate').AsString := ''
    else
      FieldByName('ODate').AsString := FieldByName('M_ODate').AsString;
    if FieldByName('M_OTime').AsString = '00:00' then
      FieldByName('OTime').AsString := ''
    else
      FieldByName('OTime').AsString := FieldByName('M_OTime').AsString;

{kaveh     FieldByName('Number').AsString := ConvertToFarsi(FieldByName('M_Number').AsString);
     FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString;
     if FieldByName('M_Serial').AsString <> '' then
       FieldByName('CitySerial').AsString := FieldByName('CitySerial').AsString + '-' +
                                             FieldByName('M_Serial').AsString;
     FieldByName('IPerson').AsString := GetPersonName(FieldByName('M_IPerson').AsString);
     FieldByName('IDoor').AsString := GetDoorName(FieldByName('M_IDoor').AsInteger);
     FieldByName('OPerson').AsString := GetPersonName(FieldByName('M_OPerson').AsString);
     FieldByName('ODoor').AsString := GetDoorName(FieldByName('M_ODoor').AsInteger); kaveh}
   end;
end;

end.
