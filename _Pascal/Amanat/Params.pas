unit Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DosMove;

type
  TfrmParams = class(TForm)
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    grp1: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    txtRptSign1: TEdit;
    txtRptSign2: TEdit;
    txtRptSign3: TEdit;
    txtRptSign4: TEdit;
    lbl6: TLabel;
    txtRptSign5: TEdit;
    lbl8: TLabel;
    txtCardCredMonthly: TEdit;
    lbl7: TLabel;
    DosMove1: TDosMove;
    lbl1: TLabel;
    cmbDepartment: TComboBox;
    rdoDayOfChange: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtCardCredMonthlyKeyPress(Sender: TObject; var Key: Char);
    procedure txtRptSign1KeyPress(Sender: TObject; var Key: Char);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmParams : TfrmParams;

implementation

{$R *.DFM}

uses
  Funcs, Globals, Keyboard, DateProc, FntSel, DBS;

procedure TfrmParams.SetWinF;
begin
  SetFontColor(TForm(frmParams));

  Caption := (Caption);

  grp1.Caption := (grp1.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);

  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;


procedure TfrmParams.FormCreate(Sender: TObject);
var
  depart : String;
begin
  SetWinF;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' +
                              FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;
  end;

  depart := IntToStr(gParams.department) + '-' + GetDepartmentName(gParams.department);
  cmbDepartment.ItemIndex := cmbDepartment.Items.IndexOf(depart);

  with gParams do
  begin
    txtCardCredMonthly.Text := FloatToStr(gParams.chargePrice);

    txtRptSign1.Text := gParams.rptSign1;
    txtRptSign2.Text := gParams.rptSign2;
    txtRptSign3.Text := gParams.rptSign3;
    txtRptSign4.Text := gParams.rptSign4;
    txtRptSign5.Text := gParams.rptSign5;
  end;

//kaveh is
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Params');
    SQL.Add('Where Params_Code = 1');
    Open;
    if FieldByName('Params_Code').AsString = '1' then
      if (FieldByName('Params_DayOfChangeType').AsString = '0') or (FieldByName('Params_DayOfChangeType').AsString = '1') then
        rdoDayOfChange.ItemIndex := FieldByName('Params_DayOfChangeType').AsInteger
      else
        rdoDayOfChange.ItemIndex := -1
    else
      rdoDayOfChange.ItemIndex := -1;
    Close;
  end;
//kaveh ie

end;

procedure TfrmParams.cmdOKClick(Sender: TObject);
begin
  with gParams do
  begin
    if cmbDepartment.Text <> '' then
      department := StrToInt(Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
    else
      department := 0;

    if txtCardCredMonthly.Text <> '' then
      chargePrice := StrToFloat(txtCardCredMonthly.Text)
    else
      chargePrice := 0;

    rptSign1 := txtRptSign1.Text;
    rptSign2 := txtRptSign2.Text;
    rptSign3 := txtRptSign3.Text;
    rptSign4 := txtRptSign4.Text;
    rptSign5 := txtRptSign5.Text;
  end;

  SaveParams;

//kaveh is
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('IF NOT exists (SELECT * FROM Params Where Params_Code = 1) ');
    SQL.Add('BEGIN ');
    SQL.Add('INSERT INTO Params ');
    SQL.Add('(Params_Code,Params_DayOfChangeType) ');
    SQL.Add('Values (1, ' + IntToStr(rdoDayOfChange.ItemIndex) + ')');
    SQL.Add('END ');
    SQL.Add('ELSE ');
    SQL.Add('BEGIN ');
    SQL.Add('Update Params ');
    SQL.Add('SET Params_DayOfChangeType = ' + IntToStr(rdoDayOfChange.ItemIndex) + ' ');
    SQL.Add('WHERE Params_Code = 1');
    SQL.Add('END ');
    ExecSQL;
    Close;
  end;
//kaveh ie

end;

procedure TfrmParams.txtCardCredMonthlyKeyPress(Sender: TObject;
  var Key: Char);
begin
   Keyboard_Integer(Key);
end;

procedure TfrmParams.txtRptSign1KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmParams.cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbDepartment.ItemIndex := -1;
end;

end.
