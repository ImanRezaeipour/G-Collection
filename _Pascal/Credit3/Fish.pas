unit Fish;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, DosMove, Grids, Buttons, ComCtrls,
  Online;

type
  TDelBtn = class(Tbutton)
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    Function Btns(RowNo : integer) : Tbutton;
  end;

  TfrmFish = class(TForm)
    lbl1: TLabel;
    txtDate: TEdit;
    lbl2: TLabel;
    txtTime: TEdit;
    lblVadeh: TLabel;
    lbl3: TLabel;
    cmbEmplNo: TComboBox;
    cmbFamilyName: TComboBox;
    Timer1: TTimer;
    lbl4: TLabel;
    txtMany: TEdit;
    cmbSrvcName: TComboBox;
    btnSelFood: TBitBtn;
    grdSrvc: TStringGrid;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    btnClose: TBitBtn;
    lbl6: TLabel;
    txtTotalPrice: TEdit;
    lblBalance: TLabel;
    atblSrvc: TADOTable;
    lbl5: TLabel;
    Label1: TLabel;
    cmbSrvcCode: TComboBox;
    chkPrint: TCheckBox;
    cmbReaders: TComboBox;
    lbl7: TLabel;
    procedure chkPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure cmbEmplNoClick(Sender: TObject);
    procedure cmbEmplNoExit(Sender: TObject);
    procedure cmbSrvcCodeClick(Sender: TObject);
    procedure cmbEmplNoKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSrvcCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtManyKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelFoodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbSrvcCodeExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmbSrvcNameClick(Sender: TObject);
    procedure cmbSrvcNameExit(Sender: TObject);
    procedure cmbSrvcNameKeyPress(Sender: TObject; var Key: Char);
    procedure btnDelClick(Sender: TObject);
    procedure cmbSrvcCodeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function Btns(RowNo: integer): Tbutton;
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTimeExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure cmbFamilyNameClick(Sender: TObject);
    procedure cmbFamilyNameExit(Sender: TObject);
  private
    { Private declarations }

    procedure SetWinF;
    procedure FillServices;
    procedure ClearGrid;
    procedure CalculatePrice;

  public
    { Public declarations }
  end;


var
  frmFish: TfrmFish;



implementation

uses
  Funcs, Globals, MSGs, Keyboard, DBS, DateProc, RunCmnds, FntSel, ComTools;

{$R *.dfm}


procedure TfrmFish.SetWinF;
begin
  SetFontColor(TForm(frmFish));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  btnSelFood.Caption := (btnSelFood.Caption);
  btnSave.Caption := (btnSave.Caption);
  btnCancel.Caption := (btnCancel.Caption);
  btnClose.Caption := (btnClose.Caption);
end;


procedure TfrmFish.FillServices;
begin
  cmbSrvcCode.Clear;
  cmbSrvcName.Clear;
  with atblSrvc do
  begin
    while not Eof do
    begin
      cmbSrvcCode.Items.Add(FieldByName('S_Code').AsString);
      cmbSrvcName.Items.Add(FieldByName('S_Name').AsString);
      Next;
    end;
  end;
end;

procedure TfrmFish.ClearGrid;
begin
  grdSrvc.Free;
  grdSrvc := TStringGrid.Create(Application);
  with grdSrvc do
  begin
    Parent := frmFish;
    left := 8;
    top := 144;
    Width := 377;
    Height := 185;
    ScrollBars := ssVertical;
    FixedRows := 1;
    FixedCols := 0;
    RowCount := 1;
    ColCount := 4;
    ColWidths[0] := 40;
    Cells[0, 0] := ('ÎÏãÇÊ');
    ColWidths[1] := 184;
    Cells[1, 0] := ('ÚäæÇä ÎÏãÇÊ');
    ColWidths[2] := 40;
    Cells[2, 0] := ('ÊÚÏÇÏ');
    ColWidths[3] := 105;
    Cells[3, 0] := ('ãÈáÛ');
  end;
  txtTotalPrice.Text := '';
end;

procedure TfrmFish.CalculatePrice;
var
  p : Currency;
  i : Byte;
begin
  p := 0;
  if grdSrvc.RowCount >= 2 then
    for i := 1 to grdSrvc.RowCount-1 do
      if grdSrvc.Cells[3, i] <> '' then
        p := p + StrToFloat(DelComa(grdSrvc.Cells[3, i]));

  txtTotalPrice.Text := Coma(FloatToStr(p));
end;


procedure TfrmFish.FormCreate(Sender: TObject);
var
   i : integer;
begin
  SetWinF;

  grdSrvc.ColWidths[0] := 40;
  grdSrvc.Cells[0, 0] := ('ßÏ ÎÏãÇÊ');
  grdSrvc.ColWidths[1] := 184;
  grdSrvc.Cells[1, 0] := ('äÇã ÎÏãÇÊ');
  grdSrvc.ColWidths[2] := 40;
  grdSrvc.Cells[2, 0] := ('ÊÚÏÇÏ');
  grdSrvc.ColWidths[3] := 105;
  grdSrvc.Cells[3, 0] := ('ãÈáÛ');

  atblSrvc.Connection := frmDBS.adoConnect;

  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
  if cmbReaders.Items.Count >0 then
  cmbReaders.ItemIndex := 0;
end;

procedure TfrmFish.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
  txtDate.Text := CurrentDate;
  lblVadeh.Caption := '';
  lblBalance.Caption := '';
  ClearGrid;
  atblSrvc.Open;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee WHERE Empl_Active = ' + IntToStr(MB_TRUE));
    if gOptions.UserDepart <> 0 then
      SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));
    Open;

    while not Eof do
    begin
      cmbEmplNo.Items.Add(FieldByName('Empl_No').AsString);
      cmbFamilyName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                              FieldByName('Empl_Name').AsString);
      Next;
    end;
    Close;
  end;

  cmbEmplNo.SetFocus;
  FillServices;
end;

procedure TfrmFish.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Timer1.Enabled := False;
  atblSrvc.Close;
end;

procedure TfrmFish.Timer1Timer(Sender: TObject);
begin
  txtTime.Text := CurrentTimes;
end;

procedure TfrmFish.cmbEmplNoClick(Sender: TObject);
begin
  cmbFamilyName.ItemIndex := cmbEmplNo.ItemIndex;
  frmDBS.atblEmployee.Open;
  if frmDBS.atblEmployee.Locate('Empl_No', cmbEmplNo.Text, [loCaseInsensitive]) then
    lblBalance.Caption := Coma(FloatToStr(frmDBS.atblEmployee.FieldByName('Empl_Balance').AsCurrency))
  else
    lblBalance.Caption := '';
  frmDBS.atblEmployee.Close;
end;

procedure TfrmFish.cmbEmplNoExit(Sender: TObject);
begin
  if (cmbEmplNo.Text <> '') and (cmbEmplNo.ItemIndex = -1) then
    cmbEmplNo.ItemIndex := cmbEmplNo.Items.IndexOf(cmbEmplNo.Text);


  cmbFamilyName.ItemIndex := cmbEmplNo.ItemIndex;
  frmDBS.atblEmployee.Open;
  if frmDBS.atblEmployee.Locate('Empl_No', cmbEmplNo.Text, [loCaseInsensitive]) then
    lblBalance.Caption := Coma(FloatToStr(frmDBS.atblEmployee.FieldByName('Empl_Balance').AsCurrency))
  else
    lblBalance.Caption := '';
  frmDBS.atblEmployee.Close;
end;

procedure TfrmFish.cmbSrvcCodeClick(Sender: TObject);
begin
  cmbSrvcName.ItemIndex := cmbSrvcCode.ItemIndex;
end;

procedure TfrmFish.cmbEmplNoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbSrvcCode.SetFocus;
  end;
end;

procedure TfrmFish.cmbSrvcCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = '*') then
  begin
    Key := #0;
    if not((cmbSrvcCode.Text <> '') and (cmbSrvcCode.ItemIndex = -1)) then
      txtMany.SetFocus;
  end
  else if (Key = #13) and not((cmbSrvcCode.Text <> '') and (cmbSrvcCode.ItemIndex = -1)) then
  begin
    Key := #0;
    btnSelFoodClick(Sender);
  end;
end;

procedure TfrmFish.txtManyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnSelFood.Click;
  end;
end;

procedure TfrmFish.btnSelFoodClick(Sender: TObject);
var
  prc : Currency;
  tmp : integer;
  btn : TButton;
begin
  if cmbSrvcCode.Items.IndexOf(cmbSrvcCode.Text) <> -1 then
  begin
    with grdSrvc do
    begin
      tmp := Cols[0].IndexOf(cmbSrvcCode.Text);
      if tmp <> -1 then
      begin
        Cells[2, tmp] := IntToStr(StrToInt(Cells[2, tmp]) + StrToInt(txtMany.Text));
        prc := GetServicePrice(StrToInt(cmbSrvcCode.Text));
        Cells[3, tmp] := Coma(FloatToStr(prc * StrToInt(Cells[2, tmp])));
        CalculatePrice;
      end
      else
      begin
        if RowCount <= MAX_SERVICE_SEL then
        begin
          RowCount := RowCount + 1;
          if FixedRows = 0 then
            FixedRows := 1;
          Cells[0, RowCount-1] := cmbSrvcCode.Text;
          Cells[1, RowCount-1] := cmbSrvcName.Text;
          Cells[2, RowCount-1] := txtMany.Text;
          prc := GetServicePrice(StrToInt(cmbSrvcCode.Text));
          Cells[3, RowCount-1] := Coma(FloatToStr(prc * StrToInt(txtMany.Text)));

          btn := TDelBtn.Create(Application);

          btn.Parent := grdSrvc;
          btn.Tag := RowCount-1;

          btn.Caption := ('ÍÐÝ');
          btn.Width := 30;
          btn.Left := 0;
          btn.Top := (RowCount-1) * (RowHeights[0] + 1);
          CalculatePrice;
        end
        else
          ErrorMessage('ÙÑÝíÊ ÇäÊÎÇÈ ÏÑ ÝíÔ Êßãíá ÔÏå ÇÓÊ.');
      end;
    end;
  end
  else
    ErrorMessage('ÇäÊÎÇÈ ÎÏãÇÊ äÇÏÑÓÊ!');

  cmbSrvcCode.ItemIndex := -1;
  cmbSrvcCodeClick(Sender);
  txtMany.Text := '1';
  cmbSrvcCode.SetFocus;

end;

procedure TfrmFish.cmbSrvcCodeExit(Sender: TObject);
begin
  if (cmbSrvcCode.Text <> '') and (cmbSrvcCode.ItemIndex = -1) then
    cmbSrvcCode.ItemIndex := cmbSrvcCode.Items.IndexOf(cmbSrvcCode.Text);

  cmbSrvcName.ItemIndex := cmbSrvcCode.ItemIndex;
end;

procedure TfrmFish.btnSaveClick(Sender: TObject);
//var
//  receipt : TReceipt;
//  retVal, i : Byte;
begin
//  for i := 1 to MAX_SERVICE_SEL do
//    receipt.recit_Srvcs[i].SS_SrvcCode := 0;
//
//  receipt.recit_Date := txtDate.Text;
//  receipt.recit_Time := Copy(txtTime.Text, 1, 5);
//  receipt.recit_EmplNo := cmbEmplNo.Text;
//  for i := 1 to grdSrvc.RowCount-1 do
//    if grdSrvc.Cells[0, i] <> '' then
//    begin
//      receipt.recit_Srvcs[i].SS_SrvcCode := StrToInt(grdSrvc.Cells[0, i]);
//      receipt.recit_Srvcs[i].SS_SrvcNo := StrToInt(grdSrvc.Cells[2, i]);
//      receipt.recit_Srvcs[i].SS_MainPrice := StrToFloat(DelComa(grdSrvc.Cells[3, i]));
//      receipt.recit_Srvcs[i].SS_MainPrice := receipt.recit_Srvcs[i].SS_MainPrice / receipt.recit_Srvcs[i].SS_SrvcNo;
//      receipt.recit_Srvcs[i].SS_PrcType := 1;
//    end;
//
//  if txtTotalPrice.Text <> '' then
//    receipt.recit_TotalPrc := StrToFloat(DelComa(txtTotalPrice.Text))
//  else
//    receipt.recit_TotalPrc := 0;
//
//  receipt.recit_PayType := PAY_CREDIT;
//  receipt.recit_Depart := gParams.department;
//
//  retVal := CardReciet(receipt);
//  if retVal <> ERR_NONE then
//    ErrorMessage(ReceiptErrorStr(retVal))
//  else
//  begin
//    if chkPrint.Checked then
//    begin
//       curRdrCode := Readers[cmbReaders.ItemIndex].r_code;
//       ViewRecord(receipt, retVal);
//    end;
//    ClearGrid;
//    cmbEmplNo.ItemIndex := -1;
//    cmbEmplNoClick(Sender);
//    cmbEmplNo.SetFocus;
//  end;
end;

procedure TfrmFish.btnCancelClick(Sender: TObject);
begin
  ClearGrid;
end;

procedure TfrmFish.cmbSrvcNameClick(Sender: TObject);
begin
  cmbSrvcCode.ItemIndex := cmbSrvcName.ItemIndex;
end;

procedure TfrmFish.cmbSrvcNameExit(Sender: TObject);
begin
  if (cmbSrvcName.Text <> '') and (cmbSrvcName.ItemIndex = -1) then
    cmbSrvcName.ItemIndex := cmbSrvcName.Items.IndexOf(cmbSrvcName.Text);

  cmbSrvcCode.ItemIndex := cmbSrvcName.ItemIndex;
end;

procedure TfrmFish.cmbSrvcNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '*' then
  begin
    Key := #0;
    txtMany.SetFocus;
  end
  else if Key = #13 then
  begin
    Key := #0;
    btnSelFoodClick(Sender);
  end;
end;

procedure TfrmFish.btnDelClick(Sender: TObject);
var
  i : integer;
begin
  with grdSrvc do
  begin
    for i := Row to RowCount-2 do
      Rows[i] := Rows[i+1];
    RowCount := RowCount - 1;
  end;
end;

Function TDelBtn.Btns(RowNo : integer) : Tbutton;
var
  i : integer;
begin
  Result := nil;
  with (parent as tstringGrid) do
  begin
    for i := 0 to ControlCount-1 do
      if (Controls[i] is TButton) then
        if (Controls[i] as TButton).Tag = RowNo then
          Result := Controls[i] as TButton;
  end;
end;
procedure TfrmFish.cmbSrvcCodeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (cmbSrvcCode.Text <> '') and (cmbSrvcCode.ItemIndex = -1) then
    cmbSrvcCode.ItemIndex := cmbSrvcCode.Items.IndexOf(cmbSrvcCode.Text);
  cmbSrvcName.ItemIndex := cmbSrvcCode.ItemIndex;
end;

Function TfrmFish.Btns(RowNo : integer) : Tbutton;
var
  i : integer;
begin
  Result := nil;
  with (parent as tstringGrid) do
  begin
    for i := 0 to ControlCount-1 do
      if (Controls[i] is TButton) then
        if (Controls[i] as TButton).Tag = RowNo then
          Result := Controls[i] as TButton;
  end;
end;

{ TDelBtn }

procedure TDelBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  t, j : integer;
begin
  inherited;
  t := tag;
  with (Parent as TStringGrid) do
  begin
    for j := t to RowCount-2 do
    begin
      Rows[j] := Rows[j+1];
      btns(j).Tag := j;
    end;
    btns(RowCount-1).free;
    RowCount := RowCount - 1;
    (parent as tfrmFish).CalculatePrice;
  end;
end;
procedure TfrmFish.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
  if Key in [#8, #48..#57] then
    Timer1.Enabled := False
  else if Key = #13 then
  begin
    cmbEmplNo.SetFocus;
    Key := #0;
  end;

end;

procedure TfrmFish.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then
    btnSave.Click
  else if (Key = 114) and cmbEmplNo.Enabled then
    cmbEmplNo.SetFocus;
end;

procedure TfrmFish.txtTimeExit(Sender: TObject);
begin
  if not Timer1.Enabled then
  begin
    if txtTime.Text <> '' then
      txtTime.Text := BeautifulTime(txtTime.Text);
  end;
end;

procedure TfrmFish.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmFish.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text)
  else
    txtDate.Text := CurrentDate;
end;

procedure TfrmFish.cmbFamilyNameClick(Sender: TObject);
begin
  cmbEmplNo.ItemIndex := cmbFamilyName.ItemIndex;
  frmDBS.atblEmployee.Open;
  if frmDBS.atblEmployee.Locate('Empl_No', cmbEmplNo.Text, [loCaseInsensitive]) then
    lblBalance.Caption := Coma(FloatToStr(frmDBS.atblEmployee.FieldByName('Empl_Balance').AsCurrency))
  else
    lblBalance.Caption := '';
  frmDBS.atblEmployee.Close;
end;

procedure TfrmFish.cmbFamilyNameExit(Sender: TObject);
begin
  if (cmbFamilyName.Text <> '') and (cmbFamilyName.ItemIndex = -1) then
    cmbFamilyName.ItemIndex := cmbEmplNo.Items.IndexOf(cmbFamilyName.Text);


  cmbEmplNo.ItemIndex := cmbFamilyName.ItemIndex;
  frmDBS.atblEmployee.Open;
  if frmDBS.atblEmployee.Locate('Empl_No', cmbEmplNo.Text, [loCaseInsensitive]) then
    lblBalance.Caption := Coma(FloatToStr(frmDBS.atblEmployee.FieldByName('Empl_Balance').AsCurrency))
  else
    lblBalance.Caption := '';
  frmDBS.atblEmployee.Close;
end;

procedure TfrmFish.chkPrintClick(Sender: TObject);
begin
   cmbReaders.Visible := chkPrint.Checked;
   lbl7.Visible := chkPrint.Checked;
end;

end.
