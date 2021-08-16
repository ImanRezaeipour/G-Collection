unit RpAllFdp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptAllFoodpart = class(TForm)
    qryAllFood: TAdoQuery;
    qrptAllFoodpart: TQuickRep;
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
    lblRepDate: TQRLabel;
    QRBand1: TQRBand;
    bndGuestFooter: TQRBand;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    lblweek: TQRLabel;
    bndDate: TQRBand;
    ChildBand2: TQRChildBand;
    bndSign: TQRChildBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    QRShape24: TQRShape;
    shpMid1: TQRShape;
    shpMid2: TQRShape;
    shpMid3: TQRShape;
    shpMid4: TQRShape;
    shpMid5: TQRShape;
    shpMid6: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    txtP1: TQRDBText;
    txtP2: TQRDBText;
    txtP3: TQRDBText;
    txtP4: TQRDBText;
    txtP5: TQRDBText;
    txtP6: TQRDBText;
    txtP7: TQRDBText;
    grpDate: TQRGroup;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    lblP7: TQRLabel;
    shpTop1: TQRShape;
    lblP1: TQRLabel;
    shpTop2: TQRShape;
    lblP2: TQRLabel;
    shpTop3: TQRShape;
    lblP3: TQRLabel;
    shpTop4: TQRShape;
    lblP4: TQRLabel;
    shpTop5: TQRShape;
    lblP5: TQRLabel;
    shpTop6: TQRShape;
    lblP6: TQRLabel;
    QRSysData4: TQRSysData;
    exprP1: TQRExpr;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    shpDown1: TQRShape;
    shpDown2: TQRShape;
    shpDown3: TQRShape;
    shpDown4: TQRShape;
    shpDown5: TQRShape;
    shpDown6: TQRShape;
    exprP2: TQRExpr;
    exprP3: TQRExpr;
    exprP4: TQRExpr;
    exprP5: TQRExpr;
    exprP6: TQRExpr;
    exprP7: TQRExpr;
    QRExpr8: TQRExpr;
    QRLabel2: TQRLabel;
    QRShape17: TQRShape;
    QRLabel1: TQRLabel;
    QRShape30: TQRShape;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    QRShape31: TQRShape;
    QRDBText11: TQRDBText;
    QRShape32: TQRShape;
    QRExpr9: TQRExpr;
    QRShape33: TQRShape;
    procedure bndGuestFooterBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndGuestFooterAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpDateBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure exprPayPrint(sender: TObject; var Value: String);
    procedure exprNotPayPrint(sender: TObject; var Value: String);
    procedure exprAllPrcPrint(sender: TObject; var Value: String);
    procedure exprSPayPrint(sender: TObject; var Value: String);
    procedure exprSNotPayPrint(sender: TObject; var Value: String);
    procedure exprSAllPrcPrint(sender: TObject; var Value: String);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure review;    
  private
    { Private declarations }
    LastFish, TotFish,
    AllTotFish, AllDateFish : Integer;

    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRptAllFoodpart.SetWinF;
begin
end;

procedure TfrmRptAllFoodpart.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryAllFood.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
//  bndDetail.Enabled := True;
//  bndDetail.Height := 0;
end;

procedure TfrmRptAllFoodpart.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AllTotFish := 0;
  AllDateFish := 0;
end;

procedure TfrmRptAllFoodpart.bndDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  if LastFish <> qryAllFood.FieldByName('FF_FishNo').AsInteger then
//  begin
//    LastFish := qryAllFood.FieldByName('FF_FishNo').AsInteger;
//    Inc(TotFish);
//    Inc(AllDateFish);
//  end;
end;

procedure TfrmRptAllFoodpart.bndGuestFooterAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  AllTotFish := AllTotFish + TotFish;
  LastFish := -1;
  TotFish := 0;
end;

procedure TfrmRptAllFoodpart.bndGuestFooterBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
const
  days : array [1..7] of string = ('‘‰»Â','Ìò‘‰»Â','œÊ‘‰»Â','”Â ‘‰»Â','ÃÂ«— ‘‰»Â','Å‰Ã ‘‰»Â','Ã„⁄Â');
begin
  lblweek.Caption := days[dayOfWeek(M_Date(qryAllFood.FieldByName('fish_date').AsString))];
end;

procedure TfrmRptAllFoodpart.bndDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  lblTotDate.Caption := IntToStr(AllDateFish);
end;

procedure TfrmRptAllFoodpart.grpDateBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
   qry : TADOQuery;
begin
  review;
  AllDateFish := 0;
  qry := TADOQuery.Create(Application);
  qry.Connection := frmDBS.DBConnection;
  with qry do
  begin
    SQL.Add('select * from parts where len(p_code) = 2 order by p_code');
  end;
  qry.open;
  qry.First;
  if NOT QRY.Eof then
  begin
    lblP1.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
    qry.next;
    if NOT QRY.Eof then
    begin
      lblP2.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
      qry.next;
      if NOT QRY.Eof then
      begin
        lblP3.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
        qry.next;
        if NOT QRY.Eof then
        begin
          lblP4.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
          qry.next;
          if NOT QRY.Eof then
          begin
            lblP5.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
            qry.next;
            if NOT QRY.Eof then
            begin
              lblP6.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
              qry.next;
              if NOT QRY.Eof then
              begin
                lblP7.Caption := GetPartNam(qry.fieldbyname('p_customCode').AsString);
              end
              else
            end;
          end;
        end;
      end;
    end;
  end;
  qry.close;
  qry.Free;
end;

procedure TfrmRptAllFoodpart.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  lblAllTotFish.Caption := IntToStr(AllTotFish);
end;

procedure TfrmRptAllFoodpart.exprPayPrint(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.exprNotPayPrint(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.exprAllPrcPrint(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.exprSPayPrint(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.exprSNotPayPrint(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.exprSAllPrcPrint(sender: TObject;
  var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.QRExpr6Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.QRExpr7Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.QRExpr9Print(sender: TObject; var Value: String);
begin
  Value := CurrencyFormat(Value);
end;

procedure TfrmRptAllFoodpart.review;
var
   qry : TADOQuery;
begin
  qry := TADOQuery.Create(Application);
  qry.Connection := frmDBS.DBConnection;
  with qry do
  begin
    SQL.Add('select * from parts where len(p_code) = 2 order by p_code');
  end;
  qry.open;
  qry.First;
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptAllFoodpart.Font.Name := RptFont;
  qrptAllFoodpart.Font.Size := RptFntSize;
  if qry.RecordCount < 7 then
  begin
    lblP7.Hide;  Visible := false;
    txtP7.Visible := false;
    exprP7.Visible := false;
  end;
  if qry.RecordCount < 6 then
  begin
    lblP6.Visible := false;
    exprP6.Visible := false;
    txtP6.Visible := false;
    shpTop6.Visible := false;
    shpMid6.Visible := false;
    shpDown6.Visible := false;
  end;
  if qry.RecordCount < 5 then
  begin
    lblP5.Visible := false;
    exprP5.Visible := false;
    txtP5.Visible := false;
    shpTop5.Visible := false;
    shpMid5.Visible := false;
    shpDown5.Visible := false;
  end;
  if qry.RecordCount < 4 then
  begin
    lblP4.Visible := false;
    exprP4.Visible := false;
    txtP4.Visible := false;
    shpTop4.Visible := false;
    shpMid4.Visible := false;
    shpDown4.Visible := false;
  end;
  if qry.RecordCount < 3 then
  begin
    lblP3.Visible := false;
    exprP6.Visible := false;
    txtP4.Visible := false;
    shpTop4.Visible := false;
    shpMid4.Visible := false;
    shpDown4.Visible := false;
  end;
  if qry.RecordCount < 3 then
  begin
    lblP3.Visible := false;
    exprP3.Visible := false;
    txtP3.Visible := false;
    shpTop3.Visible := false;
    shpMid3.Visible := false;
    shpDown3.Visible := false;
  end;
  if qry.RecordCount < 2 then
  begin
    lblP2.Visible := false;
    exprP2.Visible := false;
    txtP2.Visible := false;
    shpTop2.Visible := false;
    shpMid2.Visible := false;
    shpDown2.Visible := false;
  end;

  if qry.RecordCount < 1 then
  begin
    lblP1.Visible := false;
    exprP1.Visible := false;
    txtP1.Visible := false;
    shpTop1.Visible := false;
    shpMid1.Visible := false;
    shpDown1.Visible := false;
  end;
  qry.close;
  qry.Free;
end;

end.
