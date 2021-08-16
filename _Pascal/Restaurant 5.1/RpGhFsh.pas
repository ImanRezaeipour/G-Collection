unit RpGhFsh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRpGhFish = class(TForm)
    qryGhFish: TADOQuery;
    qrptGhFish: TQuickRep;
    DetailBand1: TQRBand;
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
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape7: TQRShape;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRSysData3: TQRSysData;
    QRExpr1: TQRExpr;
    lblJobType: TQRLabel;
    lblPart: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape11: TQRShape;
    QRLabel7: TQRLabel;
    QRShape12: TQRShape;
    txtDate: TQRDBText;
    lblPCode: TQRLabel;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    QRShape13: TQRShape;
    QRLabel8: TQRLabel;
    QRShape14: TQRShape;
    lblstat: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptGhFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRpGhFish.SetWinF;
begin
end;

procedure TfrmRpGhFish.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryGhFish.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

function GetPishCardFullName(PishCardCode : Byte) : String;
begin
  case pishcardcode of
    31..39 : result:='مرخصی بی حقوق';
    41..49 : result:='مرخصی باحقوق';
    61..69 : result:='ماموریت روزانه';
    71..79 : result:='ماموریت شبانه روزی';
    91 : result:='غیبت';
    97:result:= 'تردد ناقص'
    else result:= '';
  end;
end;

procedure TfrmRpGhFish.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPCode.Caption := DelLeftZero(qryGhFish.FieldByName('P_BarCode').AsString);
  lblPart.Caption := GetPartNam(qryGhFish.FieldByName('P_parts').AsString );
  lblJobType.Caption := GetJobName(qryGhFish.FieldByName('P_JobCode').AsInteger);
  lblstat.Caption := GetPishCardFullName(qryGhFish.FieldByName('gh_statday').AsInteger);
end;

procedure TfrmRpGhFish.qrptGhFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptGhFish.Font.Name := RptFont;
  qrptGhFish.Font.Size := RptFntSize;
end;

end.
