unit RpSpcial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, Db, AdoDB, Globals, DateProc, FarsiApi;

type
  TfrmRptSpc = class(TForm)
    qrptSpc: TQuickRep;
    qrySpc: TAdoQuery;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lblPDate: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lblPTime: TQRLabel;
    lblPage: TQRLabel;
    QRSysData1: TQRSysData;
    lbl6: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    lbl5: TQRLabel;
    lbl4: TQRLabel;
    lbl3: TQRLabel;
    lbl2: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    lbl1: TQRLabel;
    QRShape6: TQRShape;
    QRSysData3: TQRSysData;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    qrySpcSpc_Number: TStringField;
    qrySpcSpc_City: TStringField;
    qrySpcSpc_Serial: TStringField;
    qrySpcSpc_Name: TStringField;
    qrySpcSpc_Color: TStringField;
    qrySpcSpc_NotExit: TBooleanField;
    qrySpcSpc_Motavari: TBooleanField;
    qrySpcSpc_Takhfif: TBooleanField;
    qrySpcSpc_Percent: TSmallintField;
    qrySpcSpc_Debtor: TCurrencyField;
    qrySpcSpc_DescribeNotExit: TStringField;
    qrySpcSpc_DescribeMotavari: TStringField;
    qrySpcSharh: TStringField;
    qrySpcCity_Serial: TStringField;
    QRDBText1: TQRDBText;
    qrySpcNumber: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure qrySpcCalcFields(DataSet: TDataSet);
  private
    { Private declarations }

    procedure SetWinF;
  public
    { Public declarations }
    Flag : Byte;
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmRptSpc.SetWinF;
begin
  lblPDate.Caption := (lblPDate.Caption);
  lblPTime.Caption := (lblPTime.Caption);
  lblPage.Caption := (lblPage.Caption);
  qrptSpc.ReportTitle := (qrptSpc.ReportTitle);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
end;

procedure TfrmRptSpc.FormCreate(Sender: TObject);
begin
  SetWinF;
  qrySpc.connection := frmDBS.adoConnect;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptSpc.qrySpcCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName('Spc_Serial').AsString = '' then
      FieldByName('City_Serial').AsString := FieldByName('Spc_City').AsString
    else
      FieldByName('City_Serial').AsString := FieldByName('Spc_City').AsString + '-' +
                                             FieldByName('Spc_Serial').AsString;
    if Flag = MB_TAKHFIF then
    begin
      if FieldByName('Spc_Percent').AsInteger = 100 then
        FieldByName('Sharh').AsString := '«” ›«œÂ —«Ìê«‰ «“ Å«—ﬂÌ‰ê'
      else
        FieldByName('Sharh').AsString := '«” ›«œÂ «“ Å«—ﬂÌ‰ê »« ' + FieldByName('Spc_Percent').AsString + ' œ—’œ  Œ›Ì›';
    end
    else if Flag = MB_MOTAVARI then
      FieldByName('Sharh').AsString := FieldByName('Spc_DescribeMotavari').AsString
    else if Flag = MB_NOTEXIT then
      FieldByName('Sharh').AsString := FieldByName('Spc_DescribeNotExit').AsString;

    FieldByName('Number').AsString := ConvertToFarsi(FieldByName('Spc_Number').AsString);
  end;
end;

end.
