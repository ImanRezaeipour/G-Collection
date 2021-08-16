unit RpPrsAmrYaraneh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsAmarYaraneh = class(TForm)
    qryPrsFish: TAdoQuery;
    qrptPrsFish: TQuickRep;
    bndDetail: TQRBand;
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
    lbl7: TQRLabel;
    lbl12: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    grpPartJob: TQRGroup;
    lbl4: TQRLabel;
    QRShape9: TQRShape;
    lbl6: TQRLabel;
    SummaryBand1: TQRBand;
    lbl13: TQRLabel;
    grpBarCode: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    ChildBand2: TQRChildBand;
    TitleBand1: TQRBand;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lbl5: TQRLabel;
    QRShape4: TQRShape;
    lbl8: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    QRShape8: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    bndPrsGrp: TQRBand;
    lblRow: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape11: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRLabel7: TQRLabel;
    QRShape26: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape10: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    lblPCode: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRShape31: TQRShape;
    QRLabel8: TQRLabel;
    QRShape32: TQRShape;
    QRDBText11: TQRDBText;
    QRExpr1: TQRExpr;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPrsGrpBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }


    row,
    AllSbh, AllNhr, AllShm : Integer;
    AllPrice : Currency;

    procedure SetWinF;
  public
    { Public declarations }
    SDate, EDate : String;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsAmarYaraneh.SetWinF;
begin
end;

procedure TfrmRptPrsAmarYaraneh.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFish.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsAmarYaraneh.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  lblAllPrc.Caption := Format('%m', [AllPrice]);
end;

procedure TfrmRptPrsAmarYaraneh.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFish.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFish.FieldByName('P_JobCode').AsInteger);
  row := 0;
  AllSbh := 0;
  AllNhr := 0;
  AllShm := 0;
  AllPrice := 0;
end;

procedure TfrmRptPrsAmarYaraneh.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  AllSbh := 0;
  AllNhr := 0;
  AllShm := 0;
  AllPrice := 0;
end;

procedure TfrmRptPrsAmarYaraneh.bndPrsGrpBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  c, all : Integer;
  p : Currency;
begin
  Inc(row);
  lblRow.Caption := IntToStr(row);
  lblPCode.Caption := DelLeftZero(qryPrsFish.FieldByName('p_BarCode').AsString);
end;

procedure TfrmRptPrsAmarYaraneh.qrptPrsFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFish.Font.Name := RptFont;
  qrptPrsFish.Font.Size := RptFntSize;
end;

end.




