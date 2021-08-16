unit Rptedad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRpttedad = class(TForm)
    qryPrsFood: TAdoQuery;
    qrpttedad: TQuickRep;
    dtlData: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    lbl9: TQRLabel;
    QRShape3: TQRShape;
    QRShape6: TQRShape;
    lbl5: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lblghaza: TQRLabel;
    qry: TAdoQuery;
    lbl6: TQRLabel;
    SummaryBand1: TQRBand;
    lbl11: TQRLabel;
    lbltarikh: TQRLabel;
    TitleBand1: TQRBand;
    lbl8: TQRLabel;
    QRShape8: TQRShape;
    lbl7: TQRLabel;
    QRShape11: TQRShape;
    QRShape15: TQRShape;
    lblsham: TQRLabel;
    QRShape16: TQRShape;
    lblnahar: TQRLabel;
    QRShape18: TQRShape;
    lbl4: TQRLabel;
    QRShape4: TQRShape;
    lblRow: TQRLabel;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    ChildBand2: TQRChildBand;
    bndSign: TQRChildBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lblsobh: TQRLabel;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRShape5: TQRShape;
    QRLabel4: TQRLabel;
    QRShape7: TQRShape;
    QRLabel5: TQRLabel;
    QRShape12: TQRShape;
    lblghaza1: TQRLabel;
    QRShape13: TQRShape;
    lblsham1: TQRLabel;
    QRShape14: TQRShape;
    lblnahar1: TQRLabel;
    QRShape17: TQRShape;
    lblsobh1: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure dtlDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrpttedadBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }

    ttghaza,ttsobh,ttnahar,ttsham : integer;

  public
    { Public declarations }
    StartDate, EndDate : String;
    Sobh_Valid, Nahar_Valid, Sham_Valid : Boolean;
    row : Integer;
    ss : string;
  end;

implementation

{$R *.DFM}

procedure TfrmRpttedad.FormCreate(Sender: TObject);
begin
  qryPrsFood.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRpttedad.dtlDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  tghaza,tsobh,tnahar,tsham : Integer;
  tarikh : string;
begin
  tsobh :=0;
  tnahar:=0;
  tsham :=0;
  tghaza:=0;

  Inc(row);
  lblRow.Caption := IntToStr(row);
  tarikh := qryprsfood.FieldByName('fish_date').asstring;
  lbltarikh.Caption := tarikh;
  tghaza:=qryprsfood.FieldByName('tghaza').asinteger;
  lblghaza.Caption := IntToStr(tghaza);
  begin
        qry.SQL.Clear;
        qry.SQL.Add('SELECT fish_type FROM Fish, Persons WHERE Fish_PCode = P_BarCode');
        qry.SQL.Add(ss);
        qry.SQL.Add('AND Fish_Date = ''' + tarikh + '''');

        qry.Open;
        while not qry.Eof do
        begin
          case qry.FieldByName('fish_type').asinteger of
               MB_SOBH : inc(tsobh);
               MB_nahar: inc(tnahar);
               MB_Sham : inc(tsham);
          end;
          qry.Next;
        end;
        qry.Close;
  end;

  lblsobh.Caption := IntToStr(tsobh);
  lblnahar.Caption := IntToStr(tnahar);
  lblsham.Caption := IntToStr(tsham);

  inc(ttghaza,tghaza);
  inc(ttnahar,tnahar);
  inc(ttsobh,tsobh);
  inc(ttsham,tsham);

end;

procedure TfrmRpttedad.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  {
  allGhazaNoS := allGhazaNoS + allGhazaNo;
  allGhazaPriceS := allGhazaPriceS + allGhazaPrice;
  allMokhalafatPriceS := allMokhalafatPriceS + allMokhalafatPrice;
  
  lblAllGhazaNo.Caption := IntToStr(allGhazaNo);
  lblAllGhazaPrice.Caption := Format('%m', [allGhazaPrice]);
  lblAllMokhalafatPrice.Caption := Format('%m', [allMokhalafatPrice]);
  lblTotalAllPrice.Caption := Format('%m', [allGhazaPrice+allMokhalafatPrice]);
  }
end;

procedure TfrmRpttedad.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  ttghaza := 0;
  ttnahar := 0;
  ttsobh := 0;
  ttsham := 0;
end;

procedure TfrmRpttedad.qrpttedadBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;

  QRBand1.Font.Name := RptTitleFont;
  QRBand1.Font.Size := RptTitleFntSize;

  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrpttedad.Font.Name := RptFont;
  qrpttedad.Font.Size := RptFntSize;

end;

procedure TfrmRpttedad.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblghaza1.Caption := IntToStr(ttghaza);
  lblsobh1.Caption := IntToStr(ttsobh);
  lblnahar1.Caption := IntToStr(ttnahar);
  lblsham1.Caption := IntToStr(ttsham);
end;

end.
