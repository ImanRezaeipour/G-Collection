unit RpCustCr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, Cntroler;

type
  TfrmRptCustCircle = class(TForm)
    qrptCustCr: TQuickRep;
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
    qrpCode: TQRGroup;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    qryPark111: TADOQuery;
    lblIDate: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRBand1: TQRBand;
    lblOp: TQRLabel;
    lblITime: TQRLabel;
    lblRemain: TQRLabel;
    lblPayable: TQRLabel;
    lblOTime: TQRLabel;
    lblTimesOLD: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    lblODate: TQRLabel;
    QRLabel12: TQRLabel;
    qry111: TADOQuery;
    QRDBText5: TQRDBText;
    QRLabel11: TQRLabel;
    qryCust: TAdoQuery;
    lblFromToDate: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText9: TQRDBText;
    QRDBText6: TQRDBText;
    QRShape35: TQRShape;
    QRLabel1: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape16: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRLabel7: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText11: TQRDBText;
    QRLabel13: TQRLabel;
    QRDBText12: TQRDBText;
    QRExpr1: TQRExpr;
    lblTimes: TQRLabel;
    lblFromToCustCode: TQRLabel;
    bnd: TQRBand;
    lbl25: TQRLabel;
    QRShape29: TQRShape;
    QRShape31: TQRShape;
    QRLabel14: TQRLabel;
    QRExpr3: TQRExpr;
    QRShape30: TQRShape;
    lblCustomerCount: TQRLabel;
    QRShape32: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure qrpCodeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    Remain : Currency;

    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptCustCircle.SetWinF;
begin
  Caption := (Caption);
  lblName.Caption := (lblName.Caption);
  QRLabel16.Caption := (QRLabel16.Caption);
  QRLabel19.Caption := (QRLabel19.Caption);
  QRLabel15.Caption := (QRLabel15.Caption);
  QRLabel2.Caption := (QRLabel2.Caption);
  QRLabel3.Caption := (QRLabel3.Caption);
  QRLabel4.Caption := (QRLabel4.Caption);
  QRLabel6.Caption := (QRLabel6.Caption);
  QRLabel10.Caption := (QRLabel10.Caption);
  QRLabel12.Caption := (QRLabel12.Caption);
  QRLabel5.Caption := (QRLabel5.Caption);
  QRLabel9.Caption := (QRLabel9.Caption);
  qrptCustCr.ReportTitle := (qrptCustCr.ReportTitle);
end;

procedure TfrmRptCustCircle.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with qryCust do
  begin
    if (FieldByname('M_Status').AsInteger = 63) OR(FieldByname('M_Status').AsInteger = 64) then
      lblTimes.Caption := FormatTimes(Differ(FieldByname('M_IDate').AsString,
                                             FieldByname('M_ITime').AsString,
                                             FieldByname('M_ODate').AsString,
                                             FieldByname('M_OTime').AsString))
    else
      lblTimes.Caption := '';
  end;
end;

procedure TfrmRptCustCircle.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryCust.connection := frmDBS.adoConnect;
//  qryPark.connection := frmDBS.adoConnect;
//  qry.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;


  QRShape15.Left := 0;
  QRShape15.Top := DetailBand1.Height - 3;
  QRShape15.Width := DetailBand1.Width - 1;

end;

procedure TfrmRptCustCircle.qrpCodeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
  Remain := 0;
  }
  QRExpr1.Reset;
  lblCustomerCount.Caption := IntToStr(StrToInt(lblCustomerCount.Caption)+1);
end;

procedure TfrmRptCustCircle.grpDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);

{var
  td : String;
  DisConect : Boolean; }

begin
{
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Pay_Date, Pay_IsPay FROM PayCust');
  qry.SQL.Add('WHERE Pay_CustCode = ' + qryCust.FieldByName('Pay_CustCode').AsString);
  qry.SQL.Add('AND Pay_Date > ''' + qryCust.FieldByName('Pay_Date').AsString + '''');
  qry.SQL.Add('ORDER BY Pay_Date');
  qry.Open;
  if qry.RecordCount > 0 then
  begin
    td := qry.FieldByName('Pay_Date').AsString;
    Disconect := not qry.FieldByName('Pay_IsPay').AsBoolean;
  end
  else
  begin
    td := '';
    Disconect := False;
  end;
  qry.Close;

  qryPark.Close;
  if qryCust.FieldByName('Pay_IsPay').AsBoolean then
  begin
  with qryPark.SQL do
  begin
    Clear;
    Add('SELECT * FROM Machines');
    Add('WHERE M_Number = ''' + qryCust.FieldByName('Cust_CarNumber').AsString + '''');
    Add('AND M_CityName = ''' + qryCust.FieldByName('Cust_CarCity').AsString + '''');
    Add('AND M_Serial = ''' + qryCust.FieldByName('Cust_CarSerial').AsString + '''');
    Add('AND M_ODate >= ''' + qryCust.FieldByName('Pay_Date').AsString + '''');
    if Disconect then
      Add('AND M_ODate <= ''' + td + '''')
    else if td <> '' then
      Add('AND M_ODate < ''' + td + '''');
  end;
  qryPark.Open;
  end;

  if qryCust.FieldByName('Pay_IsPay').AsBoolean then
  begin
    Remain := Remain + qryCust.FieldByname('Pay_Price').AsCurrency;
    if qryCust.FieldByName('Pay_Date').AsString = qryCust.FieldByName('Cust_Date').AsString then
      lblPayOp.Caption := ('ÇÝÊÊÇÍ ÇÔÊÑÇß')
    else
      lblPayOp.Caption := ('ÊãÏíÏ ÇÔÊÑÇß');
  end
  else
  begin
    Remain := Remain - qryCust.FieldByname('Pay_Price').AsCurrency;
    lblPayOp.Caption := ('ÞØÚ ÇÔÊÑÇß');
  end;
  lblPayRemain.Caption := Format('%m', [Remain]);
 }
end;

procedure TfrmRptCustCircle.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
var PrintBand: Boolean);
begin
  {Remain := Remain - qryPark.FieldByName('M_Payable').AsCurrency;}
{
  Remain := Remain - qryPark.FieldByName('M_Price').AsCurrency;
  if Remain < 0 then
    Remain := 0;
  lblIDate.Caption := qryPark.FieldByName('M_IDate').AsString;
  lblOP.Caption := ('ÇÓÊÝÇÏå ÇÒ ÇÑßíä');
  lblITime.Caption := qryPark.FieldByName('M_ITime').AsString;
  lblODate.Caption := qryPark.FieldByName('M_ODate').AsString;
  lblOTime.Caption := qryPark.FieldByName('M_OTime').AsString;
  lblTimes.Caption := IntToStr(Differ(lblIDate.Caption, lblITime.Caption, lblODate.Caption, lblOTime.Caption));
  {lblPayable.Caption := Format('%m', [qryPark.FieldByName('M_Payable').AsCurrency]);}
{  lblPayable.Caption := Format('%m', [qryPark.FieldByName('M_Price').AsCurrency]);
  lblRemain.Caption := Format('%m', [Remain]);
}
end;




end.
