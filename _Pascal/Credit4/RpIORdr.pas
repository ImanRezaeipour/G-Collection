unit RpIORdr;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,timetool,
  ADODB;

type
  TqrptInOutRdr = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lblDate1: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lblTime1: TQRLabel;
    lblPage: TQRLabel;
    QRSysData1: TQRSysData;
    qryIO: TQuery;
    lblFTDate: TQRLabel;
    DetailBand1: TQRBand;
    QRShape4: TQRShape;
    lblTime: TQRLabel;
    lblStatus: TQRLabel;
    lblDayName: TQRLabel;
    QRShape8: TQRShape;
    bndSum: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep5: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRShape2: TQRShape;
    lbl4: TQRLabel;
    lbl7: TQRLabel;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
    QRShape7: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lbl6: TQRLabel;
    QRShape11: TQRShape;
    lbl1: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRSysData3: TQRSysData;
    adoQryIO: TADOQuery;
    lblRecDate: TQRLabel;
    lblFamily: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    lblBoxNo: TQRLabel;
    hl01: TQRShape;
    QRShape5: TQRShape;
    hl02: TQRShape;
    QRShape6: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    hl03: TQRShape;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public
    procedure RPTSetWinF;
  end;


implementation

uses
  Globals, DBS, Funcs;

{$R *.DFM}

procedure TqrptInOutRdr.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  hl01.Left := 2;
  hl01.Top := -1;
  hl01.Width := ColumnHeaderBand1.Width - 4;
  hl02.Left := hl01.Left;
  hl02.Top := ColumnHeaderBand1.Height - 2;
  hl02.Width := hl01.Width;
  hl03.Left := hl01.Left;
  hl03.Top := DetailBand1.Height - 2;
  hl03.Width := hl01.Width;
end;

procedure TqrptInOutRdr.RPTSetWinF;
begin
  ReportTitle := (ReportTitle);
  lblName.Caption := (lblName.Caption);
  lblPage.Caption := (lblPage.Caption);
  lblDate1.Caption := (lblDate1.Caption);
  lblTime1.Caption := (lblTime1.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);

  lblCoName.Font.Name := F_Params.RptTitleFont;
  lblCoName.Font.Size := F_Params.RptTitleFntSize;
  lblName.Font.Name := F_Params.RptTitleFont;
  lblName.Font.Size := F_Params.RptTitleFntSize;
  bndSum.Font.Name := F_Params.RptTitleFont;
  bndSum.Font.Size := F_Params.RptTitleFntSize;
  Font.Name := F_Params.RptFont;
  Font.Size := F_Params.RptFntSize;
end;

procedure TqrptInOutRdr.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  p : TPerson;
begin
  with adoQryIO do
  begin
    lblRecDate.Caption := FieldByName('Clock_Date').AsString;
    lblDayName.Caption := (DateToWeekName(FieldByName('Clock_Date').AsString));
    lblTime.Caption := IntToTime(FieldByName('Clock_Time').AsInteger);
//    lblPCode.Caption := DelLeftZero(FieldByName('Clock_BarCode').AsString);
    p := GetnPerson(FieldByName('Clock_BarCode').AsString,False);
    lblFamily.Caption := FixRight(p.P_Family, ' ' , 40) + p.P_Name;
    lblBoxNo.Caption := p.P_Box;
    case FieldByName('Clock_RdrCode').AsInteger of
      1 : lblStatus.Caption := '«Ã«“Â Ê—Êœ';
      2 : lblStatus.Caption := 'Ê—Êœ »Â ’‰œÊﬁ';
      3 : lblStatus.Caption := 'Œ—ÊÃ «“ ’‰œÊﬁ';
      else
          lblStatus.Caption := '';
    end;
  end;
end;

end.
