unit Search;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Db, DBTables, ADODB, DosMove;

type
  TfrmSearch = class(TForm)
    grpAll: TGroupBox;
    lbl1: TLabel;
    txtProxi: TEdit;
    lbl2: TLabel;
    txtEstekhdami: TEdit;
    lbl3: TLabel;
    txtIDNO: TEdit;
    lbl4: TLabel;
    txtFather: TEdit;
    lbl5: TLabel;
    txtBirthDate: TEdit;
    lbl6: TLabel;
    cmbBirthPlace: TComboBox;
    lbl7: TLabel;
    cmbMadrak: TComboBox;
    lbl8: TLabel;
    cmbCurse: TComboBox;
    Bevel1: TBevel;
    lbl9: TLabel;
    cmbJob: TComboBox;
    lbl11: TLabel;
    txtJobDate: TEdit;
    lbl12: TLabel;
    txtEndJobDate: TEdit;
    lbl10: TLabel;
    cmbCoPosts: TComboBox;
    lbl13: TLabel;
    cmbGroups: TComboBox;
    lbl14: TLabel;
    cmbRule: TComboBox;
    lbl15: TLabel;
    cmbMam: TComboBox;
    chkActive: TCheckBox;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    DosMove1: TDosMove;
    txtParts: TEdit;
    Label1: TLabel;
    cmdParts: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtProxiKeyPress(Sender: TObject; var Key: Char);
    procedure txtEstekhdamiKeyPress(Sender: TObject; var Key: Char);
    procedure txtJobDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtJobDateExit(Sender: TObject);
    procedure txtEndJobDateExit(Sender: TObject);
    procedure txtBirthDateExit(Sender: TObject);
    procedure cmbGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRuleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbMamKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);
  public
    { Public declarations }
    SrchStr  : String;
    PartCode : string;
  end;



implementation

uses
  Globals, DBS, KeyBoard, TimeTool,DateProc, Funcs;

{$R *.DFM}

procedure TfrmSearch.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl,True, True, False);
    t.SetFocus;
  end;
end;


procedure TfrmSearch.FormCreate(Sender: TObject);
begin

  with frmDBS.adoQryG do
  begin
    connection := frmDBS.DBConnection;

    SQL.Clear;
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJob.Items.Add(FieldByName('Job_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM CoPosts');
    Open;
    while not EOF do
    begin
      cmbCoPosts.Items.Add(FieldByName('Post_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Grp_Name FROM Groups');
    Open;
    while not EOF do
    begin
      cmbGroups.Items.Add(FieldByName('Grp_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Rule_Name FROM Rules');
    Open;
    while not EOF do
    begin
      cmbRule.Items.Add(FieldByName('Rule_Name').AsString);
      Next;
    end;
    Close;
{
    SQL.Clear;
    SQL.Add('SELECT GrpM_Name FROM GroupM');
    Open;
    while not EOF do
    begin
      cmbMam.Items.Add(FieldByName('GrpM_Name').AsString);
      Next;
    end;
    Close;
}
    SQL.Clear;
    SQL.Add('SELECT Madrak_Name FROM Madraks ORDER BY Madrak_Name');
    Open;
    while not EOF do
    begin
      cmbMadrak.Items.Add(FieldByName('Madrak_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Curse_Name FROM Curse ORDER BY Curse_Name');
    Open;
    while not EOF do
    begin
      cmbCurse.Items.Add(FieldByName('Curse_Name').AsString);
      Next;
    end;
    Close;
  end;

end;

procedure TfrmSearch.cmdSaveClick(Sender: TObject);
begin
  SrchStr := '';
  if txtProxi.Text <> '' then
    SrchStr := 'P_Proxi = ''' + FixLeft(txtProxi.Text, '0', 8) + '''';

  if txtEstekhdami.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Estekhdami = ''' + txtEstekhdami.Text + '''';
  end;

  if txtIDNo.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_IDNo = ''' + txtIDNo.Text + '''';
  end;

  if txtFather.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Father = ''' + txtFather.Text + '''';
  end;

  if txtBirthDate.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_BirthDate = ''' + txtBirthDate.Text + '''';
  end;

  if cmbBirthPlace.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_BirthPlace = ''' + cmbBirthPlace.Text + '''';
  end;

  if cmbMadrak.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Madrak = ''' + cmbMadrak.Text + '''';
  end;

  if cmbCurse.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Curse = ''' + cmbCurse.Text + '''';
  end;

{
  if cmbP1.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Part1 = ''' + IntToStr(adoTblP1.FieldByName('P1_Code').AsInteger) + '''';
  end;

  if cmbP2.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Part2 = ''' + IntToStr(adoTblP2.FieldByName('P2_Code').AsInteger) + '''';
  end;

  if cmbP3.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Part3 = ''' + IntToStr(adoTblP3.FieldByName('P3_Code').AsInteger) + '''';
  end;

  if cmbP4.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Part4 = ''' + IntToStr(adoTblP4.FieldByName('P4_Code').AsInteger) + '''';
  end;
}
  if cmbJob.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_JobCode = ' + IntToStr(GetJobCode(cmbJob.Text));
  end;

  if cmbCoPosts.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_CoPosts = ' + IntToStr(GetPostCode(cmbCoPosts.Text));
  end;

  if txtJobDate.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_JobDate = ''' + txtJobDate.Text + '''';
  end;

  if txtEndJobDate.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_EndJobDate = ''' + txtEndJobDate.Text + '''';
  end;

  if cmbGroups.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_ShiftGroup = ' + IntToStr(GetGroupCode(cmbGroups.Text));
  end;

  if cmbRule.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_RuleGroup = ' + IntToStr(GetRuleCode(cmbRule.Text));
  end;
{
  if cmbMam.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_ShiftGroupM = ' + IntToStr(GetGroupCode(cmbMam.Text));
  end;
}
  if chkActive.Checked then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_IsValid <> 0';
  end
  else
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr + 'P_IsValid = 0';
  end;

  if txtparts.Text <> '' then
  begin
    if SrchStr <> '' then SrchStr:= SrchStr + ' AND ';
    SrchStr:= SrchStr+ 'P_Parts like ''' + GetPartCode(partcode)+'''';
  end;

end;

procedure TfrmSearch.cmdCancelClick(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmSearch.txtProxiKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmSearch.txtEstekhdamiKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmSearch.txtJobDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmSearch.txtBirthDateExit(Sender: TObject);
begin
  if txtBirthDate.Text <> '' then txtBirthDate.Text := BeautifulDate(txtBirthDate.Text);
end;

procedure TfrmSearch.txtJobDateExit(Sender: TObject);
begin
  if txtJobDate.Text <> '' then txtJobDate.Text := BeautifulDate(txtJobDate.Text);
end;

procedure TfrmSearch.txtEndJobDateExit(Sender: TObject);
begin
  if txtEndJobDate.Text <> '' then txtEndJobDate.Text := BeautifulDate(txtEndJobDate.Text);
end;


procedure TfrmSearch.cmbGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbGroups.ItemIndex := -1;
end;

procedure TfrmSearch.cmbRuleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbRule.ItemIndex := -1;
end;

procedure TfrmSearch.cmbMamKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbMam.ItemIndex := -1;
end;

end.
