unit RpInOutP;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Db, AdoDB, Qrctrls, Globals, DateProc, FarsiApi,
  DBS;

type
  TfrmRptInOutPrcnt = class(TForm)
    qryMachines: TADOQuery;
    qrptMachines: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    lbl4: TQRLabel;
    lbl5: TQRLabel;
    lbl6: TQRLabel;
    lbl7: TQRLabel;
    lbl8: TQRLabel;
    lbl9: TQRLabel;
    lbl12: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
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
    QRShape22: TQRShape;
    QRShape24: TQRShape;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblRptName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    lblFromToDate: TQRLabel;
    lblFromToTime: TQRLabel;
    lbl13: TQRLabel;
    lbl14: TQRLabel;
    lbl15: TQRLabel;
    QRShape4: TQRShape;
    lblC1: TQRLabel;
    lblC2: TQRLabel;
    lblC3: TQRLabel;
    lblC4: TQRLabel;
    lblC5: TQRLabel;
    lblP1: TQRLabel;
    lblP2: TQRLabel;
    lblP3: TQRLabel;
    lblP4: TQRLabel;
    lblP5: TQRLabel;
    qryCars: TADOQuery;
    lblAll: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryMachinesCalcFields(DataSet: TDataSet);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmRptInOutPrcnt.SetWinF;
begin
  Caption := (Caption);
  lblRptName.Caption := (lblRptName.Caption);
  qrptMachines.ReportTitle := (qrptMachines.ReportTitle);
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
  lbl15.Caption := (lbl15.Caption);
end;

procedure TfrmRptInOutPrcnt.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryMachines.connection := frmDBS.adoConnect;
  qryCars.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptInOutPrcnt.qryMachinesCalcFields(DataSet: TDataSet);
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

procedure TfrmRptInOutPrcnt.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  c1, c2, c3, c4, c5, allC : Integer;
  tm : LongInt;
begin
  c1 := 0;
  c2 := 0;
  c3 := 0;
  c4 := 0;
  c5 := 0;
  allC := qryMachines.FieldByName('c').AsInteger;
  qryCars.SQL.Clear;
  qryCars.SQL.Add('SELECT M_IDate, M_ITime, M_ODate, M_OTime FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
  //qryCars.SQL.Add('AND M_IDate = ''' + qryMachines.FieldByName('M_IDate').AsString + '''');
  qryCars.SQL.Add('AND M_IDate = ''' + qryMachines.FieldByName('M_IDate').AsString + '''');
  qryCars.Open;
  while not qryCars.Eof do
  begin
    tm := Differ(qryCars.FieldByName('M_IDate').AsString, qryCars.FieldByName('M_ITime').AsString,
                 qryCars.FieldByName('M_ODate').AsString, qryCars.FieldByName('M_OTime').AsString);

    if tm <= 30 then      Inc(c1)
    else if tm < 60 then  Inc(c2)
    else if tm < 120 then Inc(c3)
    else if tm < 180 then Inc(c4)
    else                  Inc(c5);

    qryCars.Next;
  end;
  qryCars.Close;


  lblC1.Caption := IntToStr(c1);
  lblC2.Caption := IntToStr(c2);
  lblC3.Caption := IntToStr(c3);
  lblC4.Caption := IntToStr(c4);
  lblC5.Caption := IntToStr(c5);
  if allC <> 0 then
  begin
    lblP1.Caption := Format('%5.2f', [c1 * 100 / allC]) + ' %';
    lblP2.Caption := Format('%5.2f', [c2 * 100 / allC]) + ' %';
    lblP3.Caption := Format('%5.2f', [c3 * 100 / allC]) + ' %';
    lblP4.Caption := Format('%5.2f', [c4 * 100 / allC]) + ' %';
    lblP5.Caption := Format('%5.2f', [c5 * 100 / allC]) + ' %';
  end
  else
  begin
    lblP1.Caption := '0%';
    lblP2.Caption := '0%';
    lblP3.Caption := '0%';
    lblP4.Caption := '0%';
    lblP5.Caption := '0%';
  end;

  lblAll.Caption := IntToStr(c1 + c2 + c3 + c4 + c5);

end;

end.
