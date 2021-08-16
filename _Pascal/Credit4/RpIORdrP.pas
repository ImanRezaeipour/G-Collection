unit RpIORdrP;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,timetool,
  ADODB;

type
  TqrptInOutRdrP = class(TQuickRep)
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
    lblDayName: TQRLabel;
    bndSum: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep5: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRShape5: TQRShape;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    lbl1: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRSysData3: TQRSysData;
    adoQryIO: TADOQuery;
    lblRecDate: TQRLabel;
    grpReader: TQRGroup;
    lbl5: TQRLabel;
    lblFamily: TQRLabel;
    lblReader: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpReaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    procedure RPTSetWinF;
  end;


implementation

uses
  Globals, DBS, Funcs;

{$R *.DFM}

procedure TqrptInOutRdrP.RPTSetWinF;
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
  lbl5.Caption := (lbl5.Caption);

  lblCoName.Font.Name := F_Params.RptTitleFont;
  lblCoName.Font.Size := F_Params.RptTitleFntSize;
  lblName.Font.Name := F_Params.RptTitleFont;
  lblName.Font.Size := F_Params.RptTitleFntSize;
  bndSum.Font.Name := F_Params.RptTitleFont;
  bndSum.Font.Size := F_Params.RptTitleFntSize;
  Font.Name := F_Params.RptFont;
  Font.Size := F_Params.RptFntSize;
end;

procedure TqrptInOutRdrP.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with adoQryIO do
  begin
    lblRecDate.Caption := FieldByName('Clock_Date').AsString;
    lblDayName.Caption := (DateToWeekName(FieldByName('Clock_Date').AsString));
    lblTime.Caption := IntToTime(FieldByName('Clock_Time').AsInteger);
    lblReader.Caption := IntToStr(FieldByName('Clock_RdrCode').AsInteger) + '-' +
                         GetReaderNameInRam(FieldByName('Clock_RdrCode').AsInteger);
  end;
end;

procedure TqrptInOutRdrP.grpReaderBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with adoQryIO do
    lblFamily.Caption := DelLeftZero(FieldByName('Clock_BarCode').AsString) + '-' +
                         GetPersonFamilyName(FieldByName('Clock_BarCode').AsString);
end;

end.
