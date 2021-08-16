unit RpSrvEm3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TqrptEmplSrvc3 = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl3: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl4: TQRLabel;
    lbl2: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    DetailBand1: TQRBand;
    bntFooter: TQRBand;
    QRShape11: TQRShape;
    QRShape13: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    clmnGroup: TQRBand;
    clmnHead: TQRChildBand;
    lbl9: TQRLabel;
    QRShape2: TQRShape;
    lbl5: TQRLabel;
    QRShape12: TQRShape;
    lbl8: TQRLabel;
    lblSrvcs: TQRLabel;
    grpEmpl: TQRGroup;
    aqryEmplSrvc: TADOQuery;
    QRDBText2: TQRDBText;
    lbl1: TQRLabel;
    lbl6: TQRLabel;
    QRShape1: TQRShape;
    QRShape4: TQRShape;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    bndSign: TQRBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    lbl7: TQRLabel;
    QRShape5: TQRShape;
    lblDepart: TQRLabel;
    QRShape6: TQRShape;
    QRExpr2: TQRExpr;
    QRShape7: TQRShape;
    lbl10: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText4Print(sender: TObject; var Value: String);
  private

  public
    procedure SetWinF_Rpt;

  end;





implementation

uses
  Funcs, FntSel, DBS, Globals;

{$R *.DFM}



procedure TqrptEmplSrvc3.SetWinF_Rpt;
begin
  Font := rpDFont;
  lblCoName.Font := rpTFont;
  lblName.Font := rpTFont;
  clmnHead.Font := rpHFont;
  bndSign.Font := rpHFont;

  ReportTitle := (ReportTitle);
  lblName.Caption := (lblName.Caption);
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
end;


procedure TqrptEmplSrvc3.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var s : String;
begin
  lblDepart.Caption := GetDepartmentName(aqryEmplSrvc.FieldByName('Recit1_Department').AsInteger);
  s := '';
//  with frmDBS.adoQryG do
//  begin
//    SQL.Clear;
//    SQL.Add('SELECT S_Name, Recit2_SrvcNo FROM Services, Receipt2');
//    SQL.Add('WHERE S_Code = Recit2_Srvc');
//    SQL.Add('AND Recit2_Date = ''' + aqryEmplSrvc.FieldByName('Recit1_Date').AsString + '''');
//    SQL.Add('AND Recit2_EmplNo = ''' + aqryEmplSrvc.FieldByName('Empl_No').AsString + '''');
//    SQL.Add('AND Recit2_No = ' + aqryEmplSrvc.FieldByName('Recit1_No').AsString);
//    Open;
//    while not Eof do
//    begin
//      if s <> '' then s := s + '-';
//      s := s + FieldByName('S_Name').AsString + '(' + FieldByName('Recit2_SrvcNo').AsString + ')';
//      Next;
//    end;
//    Close;
//  end;
  lblSrvcs.Caption := s+#254;
end;

procedure TqrptEmplSrvc3.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value := Format('%m', [StrToFloat(Value)]);
end;

end.
