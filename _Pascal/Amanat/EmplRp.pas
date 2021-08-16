unit EmplRp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, DB, ADODB, DBCtrls;

type
  TfrmEmployeeRpt = class(TForm)
    lbl1: TLabel;
    btnEmplSel: TBitBtn;
    lbl3: TLabel;
    cmbParts: TComboBox;
    lbl2: TLabel;
    cmbDepartment: TComboBox;
    lbl4: TLabel;
    cmbCoPosts: TComboBox;
    lbl5: TLabel;
    cmbGroups: TComboBox;
    lbl6: TLabel;
    cmbActive: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    chkSign: TCheckBox;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    grdFields: TXStringGrid;
    EditCellEditor1: TEditCellEditor;
    lbl7: TLabel;
    txtDescribe: TEdit;
    cmbEmplCode: TDBLookupComboBox;
    cmbEmplName: TDBLookupComboBox;
    ADOTable1: TADOTable;
    ADOTable1te: TStringField;
    ADOTable1Empl_No: TWideStringField;
    ADOTable1Empl_ID: TWideStringField;
    ADOTable1Empl_Name: TWideStringField;
    ADOTable1Empl_Family: TWideStringField;
    ADOTable1Empl_Active: TBooleanField;
    ADOTable1Empl_Department: TIntegerField;
    ADOTable1Empl_CoPost: TIntegerField;
    ADOTable1Empl_Part: TIntegerField;
    ADOTable1Empl_Dscnt: TIntegerField;
    ADOTable1Empl_ExpDate: TWideStringField;
    ADOTable1Empl_Balance: TBCDField;
    ADOTable2: TADOTable;
    ADOTable2te: TStringField;
    ADOTable2Empl_No: TWideStringField;
    ADOTable2Empl_ID: TWideStringField;
    ADOTable2Empl_Name: TWideStringField;
    ADOTable2Empl_Family: TWideStringField;
    ADOTable2Empl_Active: TBooleanField;
    ADOTable2Empl_Department: TIntegerField;
    ADOTable2Empl_CoPost: TIntegerField;
    ADOTable2Empl_Part: TIntegerField;
    ADOTable2Empl_Dscnt: TIntegerField;
    ADOTable2Empl_ExpDate: TWideStringField;
    ADOTable2Empl_Balance: TBCDField;
    DataSource2: TDataSource;
    DataSource1: TDataSource;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure cmbEmplNameClick(Sender: TObject);
    procedure cmbEmplCodeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbActiveChange(Sender: TObject);
    procedure cmbEmplNameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmbEmplCodeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbEmplCode1Click(Sender: TObject);
    procedure cmbEmplName2Click(Sender: TObject);
    procedure cmbEmplCode1Exit(Sender: TObject);
    procedure cmbEmplName2Exit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdFieldsDblClick(Sender: TObject);
    procedure grdFieldsKeyPress(Sender: TObject; var Key: Char);
    procedure btnEmplSelClick(Sender: TObject);
  private
    { Private declarations }
    emplSelected : String;

    procedure SetWinF;
    function  IsFieldSelected : Boolean;
    function  IsWidthValid : Boolean;
    procedure SaveFields;
    procedure LoadFields;

  public
    { Public declarations }
  end;


var
  frmEmployeeRpt: TfrmEmployeeRpt;


implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, FntSel, RpEmpLst,
    {ADODB, DB} QuickRpt, QRCtrls, Select;

{$R *.dfm}

procedure TfrmEmployeeRpt.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEmployeeRpt));
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  btnEmplSel.Caption := (btnEmplSel.Caption);
  for i := 0 to cmbActive.Items.Count-1 do
    cmbActive.Items.Strings[i] := (cmbActive.Items.Strings[i]);
  cmbActive.ItemIndex := 0;
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  for i := 0 to grdFields.ColCount-1 do
    grdFields.Cells[i, 0] := (grdFields.Cells[i, 0]);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmEmployeeRpt.SpeedButton1Click(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.Close;
end;

function TfrmEmployeeRpt.IsFieldSelected : Boolean;
var i : Byte;
begin
  Result := False;
  for i := 1 to grdFields.RowCount-1 do
    if grdFields.Cells[0, i] = 'X' then
    begin
      Result := True;
      Break;
    end;
end;

function TfrmEmployeeRpt.IsWidthValid : Boolean;
var i : Byte;
begin
  Result := True;
  for i := 1 to grdFields.RowCount-1 do
    if (grdFields.Cells[0, i] = 'X') and
       ((grdFields.Cells[2, i] = '') or (StrToInt(grdFields.Cells[2, i]) < 20)) then
    begin
      Result := False;
      Break;
    end;
end;

procedure TfrmEmployeeRpt.SaveFields;
var
  i : Byte;
  f : TextFile;
begin
  AssignFile(f, gOptions.ProgramPath + 'EmplFld.Dta');
  Rewrite(f);
  for i := 1 to grdFields.RowCount-1 do
    if grdFields.Cells[0, i] = 'X' then
      Writeln(f, i, '-', grdFields.Cells[2, i]);
  CloseFile(f);
end;

procedure TfrmEmployeeRpt.LoadFields;
var
  f : TextFile;
  s : string;
  idx : Byte;
begin
  if FileExists(gOptions.ProgramPath + 'EmplFld.Dta') then
  begin
    AssignFile(f, gOptions.ProgramPath + 'EmplFld.Dta');
    Reset(f);
    while not Eof(f) do
    begin
      ReadLn(f, s);
      if Pos('-', s) > 0 then
      begin
        idx := StrToInt(Copy(s, 1, Pos('-', s)-1));
        grdFields.Cells[0, idx] := 'X';
        grdFields.Cells[2, idx] := Copy(s, Pos('-', s)+1, 5);
      end;
    end;
    CloseFile(f);
  end;
end;


procedure TfrmEmployeeRpt.FormCreate(Sender: TObject);
begin
ADOTable1.Connection:=frmDBS.adoConnect;
ADOTable2.Connection:=frmDBS.adoConnect;
ADOTable1.Open;
ADOTable2.Open;   
  SetWinF;
  emplSelected := '';
  Application.CreateForm(TfrmSelect, frmSelect);
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Empl_Family, Empl_Name, Empl_No');
    Open;
   { while not Eof do
    begin
      cmbEmplCode.Items.Add(FieldByName('Empl_No').AsString);
      cmbEmplName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                            FieldByName('Empl_Name').AsString);
      Next;
    end;}
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Depart_Name');
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' +
                              FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Parts');
    SQL.Add('ORDER BY Part_Name');
    Open;
    while not Eof do
    begin
      cmbParts.Items.Add(FieldByName('Part_Code').AsString + '-' +
                         FieldByName('Part_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM CoPosts');
    SQL.Add('ORDER BY CoPost_Name');
    Open;
    while not Eof do
    begin
      cmbCoPosts.Items.Add(FieldByName('CoPost_Code').AsString + '-' +
                           FieldByName('CoPost_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Discount');
    SQL.Add('ORDER BY Dscnt_Name');
    Open;
    while not Eof do
    begin
      cmbGroups.Items.Add(FieldByName('Dscnt_No').AsString + '-' +
                          FieldByName('Dscnt_Name').AsString);
      Next;
    end;
    Close;
  end;

  grdFields.RowCount := FLD_BALANCE+1;

  grdFields.Cells[1, 1] := ('—œÌ›');
  grdFields.Cells[2, 1] := '50';

  grdFields.Cells[1, 2] := ('‘„«—Â');
  grdFields.Cells[2, 2] := '80';

  grdFields.Cells[1, 3] := ('‰«„ Œ«‰Ê«œêÌ - ‰«„');
  grdFields.Cells[2, 3] := '150';

  grdFields.Cells[1, 4] := ('„—ﬂ“');
  grdFields.Cells[2, 4] := '100';

  grdFields.Cells[1, 5] := ('„Õ· Œœ„ ');
  grdFields.Cells[2, 5] := '100';

  grdFields.Cells[1, 6] := ('Ã«Ìê«Â «›—«œ');
  grdFields.Cells[2, 6] := '100';

  grdFields.Cells[1, 7] := ('ê—ÊÂ  Œ›Ì›');
  grdFields.Cells[2, 7] := '100';

  grdFields.Cells[1, 8] := ('Ê÷⁄Ì ');
  grdFields.Cells[2, 8] := '75';

  grdFields.Cells[1, 9] := ('„ÊÃÊœÌ');
  grdFields.Cells[2, 9] := '100';

  LoadFields;
end;

procedure TfrmEmployeeRpt.cmbActiveChange(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.Close;
end;

procedure TfrmEmployeeRpt.cmbEmplCode1Click(Sender: TObject);
begin
//  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure TfrmEmployeeRpt.cmbEmplName2Click(Sender: TObject);
begin
//  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure TfrmEmployeeRpt.cmbEmplCode1Exit(Sender: TObject);
begin
{  if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;}
end;

procedure TfrmEmployeeRpt.cmbEmplCodeClick(Sender: TObject);
begin
ADOTable1.Open;
ADOTable2.Open;
end;

procedure TfrmEmployeeRpt.cmbEmplCodeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ADOTable1.Open;
ADOTable2.Open;
end;

procedure TfrmEmployeeRpt.cmbEmplName2Exit(Sender: TObject);
begin
{  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;}
end;

procedure TfrmEmployeeRpt.cmbEmplNameClick(Sender: TObject);
begin
ADOTable1.Open;
ADOTable2.Open;

end;

procedure TfrmEmployeeRpt.cmbEmplNameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ADOTable1.Open;
ADOTable2.Open;

end;

procedure TfrmEmployeeRpt.cmdPrintClick(Sender: TObject);
var
  qrptEmployeeList : TqrptEmployeeList;
  i : Byte;
begin

  if not IsFieldSelected then
  begin
    ErrorMessage('ÂÌç ›Ì·œÌ «‰ Œ«» ‰‘œÂ «” .');
    grdFields.SetFocus;
  end
  else if not IsWidthValid then
  begin
    ErrorMessage('⁄—÷ ›Ì·œÂ«Ì «‰ Œ«»Ì ‰«œ—”  «” .');
    grdFields.SetFocus
  end
  else
  begin
    SaveFields;

    Application.CreateForm(TqrptEmployeeList, qrptEmployeeList);
    with qrptEmployeeList do
    begin
      SetWinF_Rpt;
      lblDescribe.Caption := txtdescribe.Text;
      bndDescribe.Enabled := (txtdescribe.Text <> '');
      lblCoName.Caption := gOptions.CoName;
      if gOptions.Shobeh <> '' then
        lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
      lblDate.Caption := CurrentDate;
      bndSign.Enabled := chkSign.Checked;
      if chkSign.Checked then
      begin
        lblReptSign1.Caption := gParams.rptSign1;
        lblReptSign2.Caption := gParams.rptSign2;
        lblReptSign3.Caption := gParams.rptSign3;
        lblReptSign4.Caption := gParams.rptSign4;
        lblReptSign5.Caption := gParams.rptSign5;
      end;

      aqryEmployee.Connection := frmDBS.adoConnect;
      aqryEmployee.SQL.Clear;
      aqryEmployee.SQL.Add('SELECT * FROM Employee');
      aqryEmployee.SQL.Add('WHERE Empl_No <> ''0''');
      if gOptions.UserDepart <> 0 then
        aqryEmployee.SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

      if cmbEmplCode.Text <> '' then
        aqryEmployee.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
      else if emplSelected <> '' then
        aqryEmployee.SQL.Add('And Empl_No IN (' + emplSelected + ')');

      if cmbDepartment.Text <> '' then
        aqryEmployee.SQL.Add('AND Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

      if cmbParts.Text <> '' then
        aqryEmployee.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

      if cmbCoPosts.Text <> '' then
        aqryEmployee.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));

      if cmbGroups.Text <> '' then
        aqryEmployee.SQL.Add('AND Empl_Dscnt = ' + Copy(cmbGroups.Text, 1, Pos('-', cmbGroups.Text)-1));

      if cmbActive.ItemIndex = 1 then
        aqryEmployee.SQL.Add('AND Empl_Active = ' + IntToStr(MB_TRUE))
      else if cmbActive.ItemIndex = 2 then
        aqryEmployee.SQL.Add('AND Empl_Active = ' + IntToStr(MB_FALSE));

      case rdoSort.ItemIndex of
        0: aqryEmployee.SQL.Add('ORDER BY Empl_No');
        1: aqryEmployee.SQL.Add('ORDER BY Empl_Family, Empl_Name');
        2: aqryEmployee.SQL.Add('ORDER BY Empl_Department, Empl_Family, Empl_Name');
        3: aqryEmployee.SQL.Add('ORDER BY Empl_Part, Empl_Family, Empl_Name');
        4: aqryEmployee.SQL.Add('ORDER BY Empl_CoPost, Empl_Family, Empl_Name');
        5: aqryEmployee.SQL.Add('ORDER BY Empl_Groups, Empl_Family, Empl_Name');
      end;

      aqryEmployee.Open;
      if aqryEmployee.RecordCount > 0 then
      begin
        for i := FLD_ROW to FLD_BALANCE do
          emplFields[fldCount].emplFldCode := 0;

        fldCount := 0;
        for i := grdFields.RowCount-1 downto 1 do
        begin
          if grdFields.Cells[0, i] = 'X' then
          begin
            Inc(fldCount);
            emplFields[fldCount].emplFldCode := i;
            emplFields[fldCount].emplFldName := grdFields.Cells[1, i];
            emplFields[fldCount].emplFldSize := StrToInt(grdFields.Cells[2, i]);
          end;
        end;

        if Create_Report then
        begin
          if rdoScreen.Checked then
          
            Preview
          else
            Print;
        end
        else
          ErrorMessage('⁄—÷ ›Ì·œÂ«Ì «‰ Œ«» ‘œÂ «“ ⁄—÷ ﬂ«€– »Ì‘ — «” .');

        aqryEmployee.Close;
      end
      else
        ErrorMessage('Å—”‰·Ì »—«Ì ê“«—‘ ÊÃÊœ ‰œ«—œ.');
        
      Free;
    end;
  end;
end;

procedure TfrmEmployeeRpt.grdFieldsDblClick(Sender: TObject);
begin
  if (grdFields.Col in [0, 1]) and (grdFields.Row > 0) then
  begin
    if grdFields.Cells[0, grdFields.Row] = 'X' then
      grdFields.Cells[0, grdFields.Row] := ''
    else
      grdFields.Cells[0, grdFields.Row] := 'X';
  end;
  rdosort.SetFocus;
end;

procedure TfrmEmployeeRpt.grdFieldsKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmEmployeeRpt.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEmployeeRpt.ADOTable2CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEmployeeRpt.btnEmplSelClick(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.Close;  
//  if cmbEmplCode.Items.Count > 0 then
//  begin
    frmSelect.selType := SEL_PRS;
    if frmSelect.ShowModal = mrOK then
      emplSelected := frmSelect.dataSelected
//    else
//      emplSelected := '';
//  end;
end;                                


procedure TfrmEmployeeRpt.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

procedure TfrmEmployeeRpt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_DELETE  then
begin
ADOTable1.Close;
ADOTable2.Close;
end;
end;

end.
