unit RpLstFsh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptListFish = class(TForm)
    qryFish: TAdoQuery;
    qryFishFood: TAdoQuery;
    qrptFish: TQuickRep;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    QRChildBand1: TQRChildBand;
    lblName: TQRLabel;
    QRLabel11: TQRLabel;
    lblDate: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRSysData4: TQRSysData;
    lblRepDate: TQRLabel;
    QRBand2: TQRBand;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel21: TQRLabel;
    QRShape18: TQRShape;
    QRLabel22: TQRLabel;
    QRShape19: TQRShape;
    qrpDateType: TQRGroup;
    grpPartJob: TQRGroup;
    DetailBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText1: TQRDBText;
    QRShape8: TQRShape;
    QRDBText2: TQRDBText;
    QRShape7: TQRShape;
    QRShape6: TQRShape;
    QRExpr2: TQRExpr;
    QRShape5: TQRShape;
    lblFoods: TQRLabel;
    QRShape11: TQRShape;
    lblPayed: TQRLabel;
    QRShape12: TQRShape;
    lblNotPay: TQRLabel;
    bndDate: TQRBand;
    lblAllNotPay: TQRLabel;
    QRShape13: TQRShape;
    lblAllPay: TQRLabel;
    ChildBand1: TQRChildBand;
    lblType: TQRLabel;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    lblPCode: TQRLabel;
    lblFishCount: TQRLabel;
    QRShape1: TQRShape;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qrpDateTypeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }

    FshNo : Integer;
    AllPay,
    AllNotPay : Currency;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptListFish.FormCreate(Sender: TObject);
begin

  qryFish.connection := frmDBS.DBConnection;
  qryFishFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
  AllPay := 0;
  AllNotPay := 0;
  FshNo := 0;
end;

procedure TfrmRptListFish.qrpDateTypeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AllPay := 0;
  AllNotPay := 0;
  FshNo := 0;
  lblType.Caption := (FoodName[qryFish.FieldByName('Fish_Type').AsInteger]);
end;

procedure TfrmRptListFish.DetailBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  s : String;
  Pay, NotPay : Currency;
begin
  s := '';
  pay := 0;
  NotPay := 0;
  Inc(FshNo);
  lblPCode.Caption := DelLeftZero(qryFish.FieldByName('Fish_PCode').AsString);
  with qryFishFood do
  begin
    close;
    SQL.Clear;
    sql.Add(' SELECT * FROM FishFood');
    sql.Add(' WHERE FF_FishNo = ' + qryFish.FieldByName('Fish_No').AsString);
    sql.Add(' and   FF_Type   = ' + qryFish.FieldByName('Fish_Type').AsString);
    sql.Add(' and   FF_Date   = ''' + qryFish.FieldByName('Fish_Date').AsString + '''');
  end;
  qryFishFood.Open;
  while not qryFishFood.Eof do
  begin
    if s <> '' then s := s + ' - ';
    s := s + GetFoodNameInRam(qryFishFood.FieldByName('FF_Food').AsInteger);
    Pay := Pay + qryFishFood.FieldByName('FF_Pay').AsCurrency;
    NotPay := NotPay + qryFishFood.FieldByName('FF_Price').AsCurrency;
    qryFishFood.Next;
  end;
  qryFishFood.Close;
  lblFoods.Caption := s;
  lblPayed.Caption := Format('%m', [Pay]);
  lblNotPay.Caption := Format('%m', [NotPay]);
  AllPay := AllPay + Pay;
  AllNotPay := AllNotPay + NotPay;
end;

procedure TfrmRptListFish.bndDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllPay.Caption := Format('%m', [AllPay]);
  lblAllNotPay.Caption := Format('%m', [AllNotPay]);
  lblFishCount.Caption := (' ⁄œ«œ ›Ì‘Â« : ' + IntToStr(FshNo));
end;

procedure TfrmRptListFish.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘: ') + GetPartNam(qryFish.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„: ') + GetJobName(qryFish.FieldByName('P_JobCode').AsInteger);
end;

procedure TfrmRptListFish.qrptFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptFish.Font.Name := RptFont;
  qrptFish.Font.Size := RptFntSize;
end;

end.
