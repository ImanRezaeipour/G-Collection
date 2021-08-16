unit RpPrgFod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, Qrctrls, quickrpt, ExtCtrls, Globals, DateProc, DBS_Proc, MSGs;

type
  TfrmRptProgFood = class(TForm)
    qrptFoodProg: TQuickRep;
    QRStringsBand1: TQRStringsBand;
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
    QRLabel7: TQRLabel;
    lblDate1: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel8: TQRLabel;
    lblSham1: TQRLabel;
    lblNahar1: TQRLabel;
    lblSobh1: TQRLabel;
    QRShape7: TQRShape;
    QRLabel2: TQRLabel;
    lblDate2: TQRLabel;
    QRLabel12: TQRLabel;
    lblDate3: TQRLabel;
    QRShape3: TQRShape;
    lblDate7: TQRLabel;
    QRLabel47: TQRLabel;
    QRShape6: TQRShape;
    QRLabel39: TQRLabel;
    lblDate6: TQRLabel;
    QRShape5: TQRShape;
    lblDate5: TQRLabel;
    QRLabel31: TQRLabel;
    QRShape4: TQRShape;
    lblDate4: TQRLabel;
    QRLabel23: TQRLabel;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRShape13: TQRShape;
    QRLabel4: TQRLabel;
    lblSobh2: TQRLabel;
    QRLabel5: TQRLabel;
    lblNahar2: TQRLabel;
    lblSham2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel14: TQRLabel;
    lblSobh3: TQRLabel;
    lblNahar3: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    lblSham3: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel49: TQRLabel;
    lblSobh7: TQRLabel;
    lblNahar7: TQRLabel;
    lblSham7: TQRLabel;
    QRLabel43: TQRLabel;
    lblSham6: TQRLabel;
    lblNahar6: TQRLabel;
    lblSobh6: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel35: TQRLabel;
    lblSham5: TQRLabel;
    lblNahar5: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel33: TQRLabel;
    lblSobh5: TQRLabel;
    QRLabel27: TQRLabel;
    lblSham4: TQRLabel;
    lblNahar4: TQRLabel;
    lblSobh4: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel3: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QRStringsBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptFoodProgBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    lblDates,
    lblSobhs,
    lblNahars,
    lblShams   : array[1..7] of TQRLabel;

    procedure SetWinF;

  public
    { Public declarations }
    FirstDay : String;
  end;

implementation

{$R *.DFM}

procedure TfrmRptProgFood.SetWinF;
begin
  Caption := (Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel7.Caption := (QRLabel7.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel23.Caption := (QRLabel23.Caption);
  QRLabel31.Caption := (QRLabel31.Caption);
  QRLabel39.Caption := (QRLabel39.Caption);
  QRLabel47.Caption := (QRLabel47.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel1.Caption := (QRLabel1.Caption);
  QRLabel8.Caption := (QRLabel8.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel14.Caption := (QRLabel14.Caption);
  QRLabel17.Caption := (QRLabel17.Caption);
  QRLabel18.Caption := (QRLabel18.Caption);
  QRLabel25.Caption := (QRLabel25.Caption);
  QRLabel26.Caption := (QRLabel26.Caption);
  QRLabel27.Caption := (QRLabel27.Caption);
  QRLabel33.Caption := (QRLabel33.Caption);
  QRLabel34.Caption := (QRLabel34.Caption);
  QRLabel35.Caption := (QRLabel35.Caption);
  QRLabel41.Caption := (QRLabel41.Caption);
  QRLabel42.Caption := (QRLabel42.Caption);
  QRLabel43.Caption := (QRLabel43.Caption);
  QRLabel49.Caption := (QRLabel49.Caption);
  QRLabel50.Caption := (QRLabel50.Caption);
  QRLabel51.Caption := (QRLabel51.Caption);
  lblName.Caption := (lblName.Caption);
  qrptFoodProg.ReportTitle := (qrptFoodProg.ReportTitle);
end;

procedure TfrmRptProgFood.FormCreate(Sender: TObject);
begin
  SetWinF;
  Mouse_Wait;
  Msg_Wait('...œ— Õ«· «ÌÃ«œ ê“«—‘');
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;

  lblDates[1] := lblDate1;
  lblDates[2] := lblDate2;
  lblDates[3] := lblDate3;
  lblDates[4] := lblDate4;
  lblDates[5] := lblDate5;
  lblDates[6] := lblDate6;
  lblDates[7] := lblDate7;

  lblSobhs[1] := lblSobh1;
  lblSobhs[2] := lblSobh2;
  lblSobhs[3] := lblSobh3;
  lblSobhs[4] := lblSobh4;
  lblSobhs[5] := lblSobh5;
  lblSobhs[6] := lblSobh6;
  lblSobhs[7] := lblSobh7;

  lblNahars[1] := lblNahar1;
  lblNahars[2] := lblNahar2;
  lblNahars[3] := lblNahar3;
  lblNahars[4] := lblNahar4;
  lblNahars[5] := lblNahar5;
  lblNahars[6] := lblNahar6;
  lblNahars[7] := lblNahar7;

  lblShams[1] := lblSham1;
  lblShams[2] := lblSham2;
  lblShams[3] := lblSham3;
  lblShams[4] := lblSham4;
  lblShams[5] := lblSham5;
  lblShams[6] := lblSham6;
  lblShams[7] := lblSham7;
end;


procedure TfrmRptProgFood.QRStringsBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  qry : TAdoQuery;
  i, j : Byte;
  s : String;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;

  for i := 1 to 7 do
  begin
    lblDates[i].Caption := AddDate(FirstDay, i-1);
    lblSobhs[i].Caption := '';
    lblNahars[i].Caption := '';
    lblShams[i].Caption := '';

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM Week WHERE Week_Date = ''' + lblDates[i].Caption + '''');
    qry.Open;
    while not qry.EOF do
    begin
      s := '';
      for j := 2 to 9 do
        if qry.Fields[j].AsInteger <> 0 then
          s := s + GetFoodNameInRam(qry.Fields[j].AsInteger) + ' ° ';
      case qry.FieldByName('Week_Type').AsInteger of
        MB_SOBH:  lblSobhs[i].Caption := s;
        MB_NAHAR: lblNahars[i].Caption := s;
        MB_SHAM:  lblShams[i].Caption := s;
      end;
      qry.Next;
    end;
    qry.Close;
  end;
  qry.Free;
  Msg_NoWait;
  Mouse_NoWait;
end;

procedure TfrmRptProgFood.qrptFoodProgBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFoodProg.Font.Name := RptFont;
  qrptFoodProg.Font.Size := RptFntSize;

end;

end.
