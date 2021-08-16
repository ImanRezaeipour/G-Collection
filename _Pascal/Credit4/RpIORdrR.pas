unit RpIORdrR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables,timetool,
  ADODB;

type
  TqrptInOutRdrR = class(TQuickRep)
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
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    lblTime: TQRLabel;
    lblPCode: TQRLabel;
    lblDayName: TQRLabel;
    bndSum: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep5: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    lbl4: TQRLabel;
    lbl5: TQRLabel;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
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
    grpReader: TQRGroup;
    lblReader: TQRLabel;
    lbl7: TQRLabel;
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

procedure TqrptInOutRdrR.RPTSetWinF;
begin
  lblCoName.Font.Name := F_Params.RptTitleFont;
  lblCoName.Font.Size := F_Params.RptTitleFntSize;
  lblName.Font.Name := F_Params.RptTitleFont;
  lblName.Font.Size := F_Params.RptTitleFntSize;
  bndSum.Font.Name := F_Params.RptTitleFont;
  bndSum.Font.Size := F_Params.RptTitleFntSize;
  Font.Name := F_Params.RptFont;
  Font.Size := F_Params.RptFntSize;
end;

procedure TqrptInOutRdrR.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with adoQryIO do
  begin
    lblRecDate.Caption := FieldByName('Clock_Date').AsString;
    lblDayName.Caption := (DateToWeekName(FieldByName('Clock_Date').AsString));
    lblTime.Caption := IntToTime(FieldByName('Clock_Time').AsInteger);
    lblPCode.Caption := DelLeftZero(FieldByName('Clock_BarCode').AsString);
    lblFamily.Caption := GetPersonFamilyName(FieldByName('Clock_BarCode').AsString);
  end;
end;

procedure TqrptInOutRdrR.grpReaderBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with adoQryIO do
    lblReader.Caption := IntToStr(FieldByName('Clock_RdrCode').AsInteger) + '-' +
                         GetReaderNameInRam(FieldByName('Clock_RdrCode').AsInteger);
end;

end.
