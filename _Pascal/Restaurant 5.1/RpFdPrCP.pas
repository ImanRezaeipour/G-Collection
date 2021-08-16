unit RpFdPrCP;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, AdoDB;

type
  TfrmRptPrsFoodCntPrc = class(TQuickRep)
    grpPartJob: TQRGroup;
    QRSubDetail1: TQRSubDetail;
    lblFoods: TQRLabel;
    lblRow: TQRLabel;
    QRShape8: TQRShape;
    QRShape2: TQRShape;
    QRShape10: TQRShape;
    lblPrsFee: TQRLabel;
    QRShape5: TQRShape;
    lblPrsAll: TQRLabel;
    QRShape15: TQRShape;
    lblPeyFee: TQRLabel;
    QRShape16: TQRShape;
    lblPeyAll: TQRLabel;
    QRBand1: TQRBand;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape6: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    lblAllPey: TQRLabel;
    lblAllPrs: TQRLabel;
    bndCoName: TQRBand;
    ChildBand1: TQRChildBand;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    grpFamily: TQRGroup;
    QRExpr2: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    lbl9: TQRLabel;
    lbl12: TQRLabel;
    QRShape1: TQRShape;
    QRShape4: TQRShape;
    lbl8: TQRLabel;
    QRShape9: TQRShape;
    lbl6: TQRLabel;
    QRShape3: TQRShape;
    QRShape7: TQRShape;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    QRShape13: TQRShape;
    lbl13: TQRLabel;
    QRShape14: TQRShape;
    lbl14: TQRLabel;
    qryPrs: TAdoQuery;
    qryFood: TAdoQuery;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lblNo: TQRLabel;
    lblAllFood: TQRLabel;
    lblPCode: TQRLabel;
    lblRepDate: TQRLabel;
    lbl1: TQRLabel;
    lbl3: TQRLabel;
    lbl2: TQRLabel;
    lblName: TQRLabel;
    lblCoName: TQRLabel;
    lbl7: TQRLabel;
    lbl5: TQRLabel;
    lbl4: TQRLabel;
    lblJob: TQRLabel;
    lblPart: TQRLabel;
    QRLabel1: TQRLabel;
    procedure grpFamilyBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    row,
    allFood : Integer;
    allPrs,
    allPey : Currency;

  public
    StartDate, EndDate : String;
    procedure SetRptWinF;
  end;


implementation

uses
  Globals, DBS_Proc;


{$R *.DFM}

procedure TfrmRptPrsFoodCntPrc.SetRptWinF;
begin
end;

procedure TfrmRptPrsFoodCntPrc.grpFamilyBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var s:string;
begin
  row := 0;
  allFood := 0;
  allPrs := 0;
  allPey := 0;
  lblPCode.Caption := DelLeftZero(qryPrs.FieldByName('P_BarCode').AsString);
  qryFood.Close;
  with qryFood do
  begin
    SQL.Clear;

    sql.Add('SELECT SUM(FF_No) AS FdNo,sum(FF_Price)as price, sum(FF_Pay)as pay, FF_Food FROM Fish, FishFood');
    sql.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
    sql.Add('AND Fish_PCode = ''' + qryPrs.FieldByName('P_BarCode').AsString + '''');
    sql.Add('AND Fish_Date >= ''' + StartDate + '''');
    sql.Add('AND Fish_Date <= ''' + EndDate + '''');
    sql.Add('GROUP BY FF_Food');
    sql.Add('ORDER BY FF_Food');
    s:=qryFood.SQL.Text;
    Open;
  end;
end;

procedure TfrmRptPrsFoodCntPrc.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var prc : TPrice;
begin
  Inc(row);
  lblRow.Caption := IntToStr(row);
  lblFoods.Caption := GetFoodNameInRam(qryFood.FieldByName('FF_Food').AsInteger);
  lblNo.Caption := IntToSTr(qryFood.FieldByName('FdNo').AsInteger);
  prc := GetFoodPriceInRam(qryFood.FieldByName('FF_Food').AsInteger);
//  prc := GetFoodPriceFeeInDate(qryFood.FieldByName('FF_Food').AsInteger,);
  lblPrsFee.Caption := Format('%m', [prc.PricePerson]);
  lblPrsAll.Caption := Format('%m', [prc.PricePerson * qryFood.FieldByName('FdNo').AsInteger]);
//  lblPrsAll.Caption := Format('%m', [qryFood.FieldByName('pay').AsCurrency]);
  lblPeyFee.Caption := Format('%m', [prc.PriceFee]);
//  lblPeyAll.Caption := Format('%m', [prc.PriceFee * qryFood.FieldByName('FdNo').AsInteger]);
  lblPeyAll.Caption := Format('%m', [qryFood.FieldByName('price').AsCurrency]);
  allPrs := allPrs + (prc.PricePerson * qryFood.FieldByName('FdNo').AsInteger);
//  allPey := allPey + (prc.PriceFee * qryFood.FieldByName('FdNo').AsInteger);
//  allPrs := allPrs + qryFood.FieldByName('pay').Asinteger;
  allPey := allPey + qryFood.FieldByName('price').Asinteger;
  Inc(allFood, qryFood.FieldByName('FdNo').AsInteger);
end;

procedure TfrmRptPrsFoodCntPrc.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllFood.Caption := IntToStr(allFood);
  lblAllPrs.Caption := Format('%m', [allPrs]);
  lblAllPey.Caption := Format('%m', [allPey]);
end;

end.
