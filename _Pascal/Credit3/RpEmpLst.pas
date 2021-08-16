unit RpEmpLst;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

const
  FLD_ROW         = 1;
  FLD_EMPL_NO     = 2;
  FLD_FAMILY_NAME = 3;
  FLD_DEPARTMENT  = 4;
  FLD_PART        = 5;
  FLD_COPOST      = 6;
  FLD_GROUP       = 7;
  FLD_ACTIVE      = 8;
  FLD_BALANCE     = 9;
  FLD_Number      = 10;
  FLD_Meli        = 11;
  FLD_Tel         = 12;
  FLD_address     = 13;
  FLD_Sex         = 14;

  FLD_Max         = 14;

  sex_str : array[-1..1] of string = ('','ãÑÏ','Òä');
type
  TEmplFields = record
    emplFldCode : Byte;
    emplFldName : String[40];
    emplFldSize : Integer;
  end;

  TqrptEmployeeList = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    bndName: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    sysPage: TQRSysData;
    aqryEmployee: TADOQuery;
    dtlData: TQRBand;
    bndSign: TQRBand;
    lblReptSign4: TQRLabel;
    lblReptSign3: TQRLabel;
    lblReptSign2: TQRLabel;
    lblReptSign1: TQRLabel;
    lblReptSign5: TQRLabel;
    clmnHead: TQRBand;
    TitleBand1: TQRBand;
    bndDescribe: TQRChildBand;
    lblDescribe: TQRLabel;
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure dtlDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

    hLbls,
    dLbls : array[FLD_ROW..FLD_Max] of TQRLabel;
    hShapes,
    dShapes : array[FLD_ROW..FLD_Max-1] of TQRShape;

    row : Integer;

  public
    emplFields : array[FLD_ROW..FLD_Max] of TEmplFields;
    fldCount : Byte;

    procedure SetWinF_Rpt;
    function  Create_Report : Boolean;
  end;


implementation

uses
  Funcs, Globals, DBS, Printers, FntSel;

{$R *.DFM}

procedure TqrptEmployeeList.SetWinF_Rpt;
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
end;

function TqrptEmployeeList.Create_Report : Boolean;
var
  i : Byte;
  w, m : Integer;
begin
  w := 0;
  for i := FLD_ROW to fldCount do
  begin
    hLbls[i] := TQRLabel.Create(Self);
    hLbls[i].Caption := emplFields[i].emplFldName;
    hLbls[i].Width := emplFields[i].emplFldSize;
    hLbls[i].AutoSize := False;
    hLbls[i].Top := 8;
    hLbls[i].Alignment := taCenter;
    hLbls[i].Parent := clmnHead;
    hLbls[i].Enabled := True;
    hLbls[i].ParentFont := True;
    if i = 1 then
      hLbls[i].Left := 8
    else
      hLbls[i].Left := hLbls[i-1].Left + hLbls[i-1].Width + 8;

    dLbls[i] := TQRLabel.Create(Self);
    dLbls[i].Caption := emplFields[i].emplFldName;
    dLbls[i].Width := emplFields[i].emplFldSize;
    dLbls[i].AutoSize := False;
    dLbls[i].Top := 8;
    dLbls[i].Alignment := taCenter;
    dLbls[i].Parent := dtlData;
    dLbls[i].Enabled := True;
    dLbls[i].ParentFont := True;
    dLbls[i].Left := hLbls[i].Left;

    if i > 1 then
    begin
      hShapes[i-1] := TQRShape.Create(Self);
      hShapes[i-1].Width := 8;
      hShapes[i-1].Top := 0;
      hShapes[i-1].Height := clmnHead.Height;
      hShapes[i-1].Left := hLbls[i-1].Left + hLbls[i-1].Width;
      hShapes[i-1].Shape := qrsVertLine;
      hShapes[i-1].Parent := clmnHead;

      dShapes[i-1] := TQRShape.Create(Self);
      dShapes[i-1].Width := 8;
      dShapes[i-1].Top := 0;
      dShapes[i-1].Height := clmnHead.Height;
      dShapes[i-1].Left := hLbls[i-1].Left + hLbls[i-1].Width;
      dShapes[i-1].Shape := qrsVertLine;
      dShapes[i-1].Parent := dtlData;
    end;
    w := dLbls[i].Left + dLbls[i].Width;
  end;

  if w < 300 then
    w := 300;

  if w <= dtlData.Width then
  begin
    Result := True;
    m := Round((dtlData.Width - w) * 0.13);
    Page.LeftMargin := Page.LeftMargin + m;
    Page.RightMargin := Page.RightMargin + m;
  end
  else
  begin
    Page.Orientation := poLandscape;
    if w <= dtlData.Width then
    begin
      Result := True;
      m := Round((dtlData.Width - w) * 0.13);
      Page.LeftMargin := Page.LeftMargin + m;
      Page.RightMargin := Page.RightMargin + m;
    end
    else
      Result := False;
  end;
  lblCoName.Width := bndCoName.Width - 16;
  lblDescribe.Width := bndDescribe.Width;
  lblName.Width := bndName.Width - 300;
  lbl1.Left := bndName.Width - 45;
  sysPage.Left := lbl1.Left - sysPage.Width - 8; 
end;



procedure TqrptEmployeeList.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
end;

procedure TqrptEmployeeList.dtlDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i : Byte;
begin
  Inc(row);
  for i := FLD_ROW to fldCount do
    case emplFields[i].emplFldCode of
      FLD_ROW:        dLbls[i].Caption := IntToStr(row);
      FLD_EMPL_NO:    dLbls[i].Caption := aqryEmployee.FieldByName('Empl_No').AsString;
      FLD_FAMILY_NAME:dLbls[i].Caption := aqryEmployee.FieldByName('Empl_Family').AsString + '-' + aqryEmployee.FieldByName('Empl_Name').AsString;
      FLD_DEPARTMENT: dLbls[i].Caption := GetDepartmentName(aqryEmployee.FieldByName('Empl_Department').AsInteger);
      FLD_PART:       dLbls[i].Caption := GetPartName(aqryEmployee.FieldByName('Empl_Part').AsInteger);
      FLD_COPOST:     dLbls[i].Caption := GetCoPostName(aqryEmployee.FieldByName('Empl_CoPost').AsInteger);
      FLD_GROUP:      dLbls[i].Caption := GetDiscountName(aqryEmployee.FieldByName('Empl_Dscnt').AsInteger);
      FLD_ACTIVE:
      begin
        if aqryEmployee.FieldByName('Empl_Active').AsBoolean then
          dLbls[i].Caption := ('ÝÚÇá')
        else
          dLbls[i].Caption := ('ÛíÑ ÝÚÇá');
      end;
      FLD_BALANCE: dLbls[i].Caption := Format('%m', [aqryEmployee.FieldByName('Empl_Balance').AsCurrency]);
      FLD_Number : dLbls[i].Caption := aqryEmployee.FieldByName('Empl_Number').AsString;
      FLD_Meli   : dLbls[i].Caption := aqryEmployee.FieldByName('Empl_Meli').AsString;
      FLD_Tel    : dLbls[i].Caption := aqryEmployee.FieldByName('Empl_Tel').AsString;
      FLD_Address: dLbls[i].Caption := aqryEmployee.FieldByName('Empl_Address').AsString;
      FLD_Sex    : dLbls[i].Caption := sex_str[aqryEmployee.FieldByName('Empl_Sex').AsInteger];
    end;
end;

end.
