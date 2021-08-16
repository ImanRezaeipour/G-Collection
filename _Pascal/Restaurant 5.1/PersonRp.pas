unit PersonRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, RpPerson, ExtCtrls, quickrpt,
  Qrctrls, Db, Globals, DateProc, MSGs, Keyboard, Printers,slctpart;


type
  TfrmPersonRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    cmbBarCode: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    grpCndition: TGroupBox;
    Label5: TLabel;
    Label3: TLabel;
    cmbJob: TComboBox;
    grpSort: TGroupBox;
    rdoBarCode: TRadioButton;
    rdoFamily: TRadioButton;
    Label6: TLabel;
    cmbGroups: TComboBox;
    rdoGroups: TRadioGroup;
    grpVadeh: TGroupBox;
    chkSobhaneh: TCheckBox;
    chkNahar: TCheckBox;
    chkSham: TCheckBox;
    Label7: TLabel;
    cmbIsValid: TComboBox;
    Label8: TLabel;
    cmbValidTest: TComboBox;
    cmbPricable: TComboBox;
    Label9: TLabel;
    rdoRejim: TRadioGroup;
    cmbName: TComboBox;
    cmbFamily: TComboBox;
    rdoPaper: TRadioGroup;
    chkSign: TCheckBox;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmbJobKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNameClick(Sender: TObject);
    procedure cmbFamilyClick(Sender: TObject);
    procedure cmbBarCodeClick(Sender: TObject);
  private
    { Private declarations }

    procedure SendTab(var Key : Char);
    procedure SetWinF;
  public
    PartCode : string;  { Public declarations }
  end;


implementation

uses DBS_Proc;

{$R *.DFM}

procedure TfrmPersonRpt.SetWinF;
var
  i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  chkSobhaneh.Caption := (chkSobhaneh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkSham.Caption := (chkSham.Caption);

  rdoGroups.Caption := (rdoGroups.Caption);
  for i := 0 to rdoGroups.Items.Count - 1 do
    rdoGroups.Items.Strings[i] := (rdoGroups.Items.Strings[i]);

  for i := 0 to cmbIsValid.Items.Count - 1 do
    cmbIsValid.Items.Strings[i] := (cmbIsValid.Items.Strings[i]);

  for i := 0 to cmbValidTest.Items.Count - 1 do
    cmbValidTest.Items.Strings[i] := (cmbValidTest.Items.Strings[i]);

  for i := 0 to cmbPricable.Items.Count - 1 do
    cmbPricable.Items.Strings[i] := (cmbPricable.Items.Strings[i]);

  for i := 0 to rdoRejim.Items.Count - 1 do
    rdoRejim.Items.Strings[i] := (rdoRejim.Items.Strings[i]);

  grpSort.Caption := (grpSort.Caption);
  rdoBarCode.Caption := (rdoBarCode.Caption);
  rdoFamily.Caption := (rdoFamily.Caption);

  rdoPaper.Caption := (rdoPaper.Caption);
  for i := 0 to rdoPaper.Items.Count - 1 do
    rdoPaper.Items.Strings[i] := (rdoPaper.Items.Strings[i]);

  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);

  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmPersonRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, true, False);
    t.SetFocus;
  end;
end;

procedure TfrmPersonRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT P_BarCode, P_Name, P_Family FROM Persons');
    Open;
    while not EOF do
    begin
      cmbName.Items.Add(FieldByName('P_Name').AsString);
      cmbFamily.Items.Add(FieldByName('P_Family').AsString);
      cmbBarCode.Items.Add(DelLeftZero(FieldByName('P_BarCode').AsString));
      Next;
    end;
    Close;

//    SQL.Clear;
//    SQL.Add('SELECT * FROM Parts');
//    Open;
//    while not EOF do
//    begin
//      cmbPart.Items.Add(FieldByName('Part_Code').AsString + '-' + FieldByName('Part_Name').AsString);
//      Next;
//    end;
//    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJob.Items.Add(FieldByName('Job_Code').AsString + '-' + FieldByName('Job_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Groups');
    Open;
    while not EOF do
    begin
      cmbGroups.Items.Add(FieldByName('Grp_Code').AsString + '-' + FieldByName('Grp_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmPersonRpt.cmbNameKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPersonRpt.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmPersonRpt.cmbNameClick(Sender: TObject);
begin
  cmbFamily.ItemIndex := cmbName.ItemIndex;
  cmbBarCode.ItemIndex := cmbName.ItemIndex;
end;

procedure TfrmPersonRpt.cmbFamilyClick(Sender: TObject);
begin
  cmbName.ItemIndex := cmbFamily.ItemIndex;
  cmbBarCode.ItemIndex := cmbFamily.ItemIndex;
end;

procedure TfrmPersonRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmPersonRpt.cmbBarCodeClick(Sender: TObject);
begin
  cmbName.ItemIndex := cmbBarCode.ItemIndex;
  cmbFamily.ItemIndex := cmbBarCode.ItemIndex;
end;

procedure TfrmPersonRpt.cmbGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbGroups.ItemIndex := -1;
  end;
end;

procedure TfrmPersonRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmPersonRpt.cmdPrintClick(Sender: TObject);
var frmRptPerson: TfrmRptPerson;
part_lcode:string;
begin
  Application.CreateForm(TfrmRptPerson, frmRptPerson);
  with frmRptPerson do
  begin
    bndSign.Enabled := chkSign.Checked;
    lblEndRep1.Caption := F_Params.EndRep1;
    lblEndRep2.Caption := F_Params.EndRep2;
    lblEndRep3.Caption := F_Params.EndRep3;
    lblEndRep4.Caption := F_Params.EndRep4;
    part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';

    qryPerson.SQL.Clear;
    qryPerson.SQL.Add('SELECT * FROM Persons');
    qryPerson.SQL.Add('WHERE NOT (P_BarCode IS NULL)');

    if cmbBarCode.Text <> '' then
      qryPerson.SQL.Add('AND P_BarCode = ''' + FixLeft(cmbBarCode.Text, '0', 8) + '''');

    if cmbName.Text <> '' then
      qryPerson.SQL.Add('AND P_Name = ''' + cmbName.Text + '''');

    if cmbFamily.Text <> '' then
      qryPerson.SQL.Add('AND P_Family = ''' + cmbFamily.Text + '''');

    if txtParts.Text <> '' then
      qryPerson.SQL.Add('AND  P_parts like  ' + ''''+ part_lcode + '''') ;

    if cmbJob.Text <> '' then
      qryPerson.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

    if cmbGroups.Text <> '' then
      qryPerson.SQL.Add('AND P_ShiftGroup = ' + Copy(cmbGroups.Text, 1, Pos('-', cmbGroups.Text)-1));

    if cmbIsValid.ItemIndex = 1 then
      qryPerson.SQL.Add('AND P_IsValid = 1')
    else if cmbIsValid.ItemIndex = 2 then
      qryPerson.SQL.Add('AND P_IsValid = 0');

    if cmbValidTest.ItemIndex = 1 then
      qryPerson.SQL.Add('AND P_ValidTest = 1')
    else if cmbValidTest.ItemIndex = 2 then
      qryPerson.SQL.Add('AND P_ValidTest = 0');

    if cmbPricable.ItemIndex = 1 then
      qryPerson.SQL.Add('AND P_Pricable = 1')
    else if cmbPricable.ItemIndex = 2 then
      qryPerson.SQL.Add('AND P_Pricable = 0');

    if chkSobhaneh.Checked then
      qryPerson.SQL.Add('AND P_Sobhaneh = 1');

    if chkNahar.Checked then
      qryPerson.SQL.Add('AND P_Nahar = 1');

    if chkSham.Checked then
      qryPerson.SQL.Add('AND P_Sham = 1');

    if rdoRejim.ItemIndex = 1 then
      qryPerson.SQL.Add('AND P_Rejim = 0')
    else if rdoRejim.ItemIndex = 2 then
      qryPerson.SQL.Add('AND P_Rejim = 1');

    if rdoGroups.ItemIndex = 0 then
    begin
      lblName.Caption := (lblName.Caption + ' »Â  ›ﬂÌﬂ »Œ‘Â«');
      grpPart.Expression := 'qryPerson.P_parts';
      if rdoBarCode.Checked then
       qryPerson.SQL.Add('ORDER BY P_parts, P_BarCode')
      else
       qryPerson.SQL.Add('ORDER BY P_parts, P_Family');
    end
    else if rdoGroups.ItemIndex = 1 then
    begin
      lblName.Caption := (lblName.Caption + ' »Â  ›ﬂÌﬂ ê—ÊÂ ﬂ«—Ì');
      grpPart.Expression := 'qryPerson.P_ShiftGroup';
      if rdoBarCode.Checked then
        qryPerson.SQL.Add('ORDER BY P_ShiftGroup, P_BarCode')
      else
        qryPerson.SQL.Add('ORDER BY P_ShiftGroup, P_Family');
    end
    else
    begin
      lblName.Caption := (lblName.Caption + ' »œÊ‰  ›ﬂÌﬂ');
      grpPart.Expression := '';
      if rdoBarCode.Checked then
        qryPerson.SQL.Add('ORDER BY P_BarCode')
      else
        qryPerson.SQL.Add('ORDER BY P_Family');
    end;
    frmRptPerson.qryPerson.Open;
    if frmRptPerson.qryPerson.RecordCount > 0 then
    begin
      while Ord(qrptPerson.Page.PaperSize) > 7 do
        qrptPerson.Page.PaperSize := Pred(qrptPerson.Page.PaperSize);

      if rdoPaper.ItemIndex = 0 then
      begin
        qrptPerson.Page.Orientation := poPortrait;
        while Ord(qrptPerson.Page.PaperSize) <> 8 do
          qrptPerson.Page.PaperSize := Succ(qrptPerson.Page.PaperSize);
      end
      else
      begin
        qrptPerson.Page.Orientation := poLandscape;
        while Ord(qrptPerson.Page.PaperSize) <> 9 do
          qrptPerson.Page.PaperSize := Succ(qrptPerson.Page.PaperSize);
      end;
      if rdoScreen.Checked then
        qrptPerson.Preview
      else
        qrptPerson.Print;
    end
    else
      InformationMessage('Å—”‰·  ⁄—Ì› ‰‘œÂ «” .');
    Close;
    Free;
  end;
end;










end.


SELECT * FROM Persons
WHERE NOT (P_BarCode IS NULL)
AND  P_parts like  '0101%'
ORDER BY P_parts, P_BarCode
