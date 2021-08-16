unit Kolli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DbTables;

type
  TfrmKolli = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    cmbFrom: TComboBox;
    cmbTo: TComboBox;
    lbl3: TLabel;
    cmbPart: TComboBox;
    cmbJob: TComboBox;
    lbl4: TLabel;
    chkValid: TCheckBox;
    chkTaradod: TCheckBox;
    chkPay: TCheckBox;
    chkOver: TCheckBox;
    chkSob: TCheckBox;
    chkNahar: TCheckBox;
    chkSham: TCheckBox;
    cmdEdit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmbFromKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFromExit(Sender: TObject);
    procedure cmbToExit(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation
{$R *.DFM}

procedure TfrmKolli.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  chkValid.Caption := (chkValid.Caption);
  chkTaradod.Caption := (chkTaradod.Caption);
  chkPay.Caption := (chkPay.Caption);
  chkOver.Caption := (chkOver.Caption);
  chkSob.Caption := (chkSob.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkSham.Caption := (chkSham.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmKolli.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmKolli.FormCreate(Sender: TObject);
var
  qry : TQuery;
begin
  SetWinF;
  qry := TQuery.Create(Application);
  with qry do
  begin
    SQL.Clear;
    SQL.Add('Select * From Persons Order By P_BarCode');
    Open;
    while Not Eof do
    begin
      cmbFrom.Items.Add(FieldByName('P_BarCode').AsString);
      cmbTo.Items.Add(FieldByName('P_BarCode').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('Select * From Parts Order By Part_Code');
    Open;
    while Not Eof do
    begin
      cmbPart.Items.Add(FieldByName('Part_Code').AsString + '-' +
                        FieldByName('Part_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('Select * From JobType Order By Job_Code');
    Open;
    while Not Eof do
    begin
      cmbJob.Items.Add(FieldByName('Job_Code').AsString + '-' +
                       FieldByName('Job_Name').AsString);
      Next;
    end;
    Close;

    Free;
  end;
end;

procedure TfrmKolli.cmbFromKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmKolli.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmKolli.cmbFromExit(Sender: TObject);
begin
  with cmbFrom do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0',8))
    else
      ItemIndex := -1;
  end;
end;

procedure TfrmKolli.cmbToExit(Sender: TObject);
begin
  with cmbTo do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0',8))
    else
      ItemIndex := -1;
  end;
end;

procedure TfrmKolli.cmdEditClick(Sender: TObject);
var
  qry : TQuery;
begin
  Msg_Wait('œ— Õ«· «‰Ã«„ «’·«Õ«  ﬂ·Ì...');
  qry := TQuery.Create(Application);
  with qry do
  begin
    SQL.Clear;


    SQL.Add('UPDATE Persons SET');

    if chkValid.Checked then
      SQL.Add(' P_IsValid = True')
    else
      SQL.Add(' P_IsValid = False');

    if chkTaradod.Checked then
      SQL.Add(', P_ValidTest = True')
    else
      SQL.Add(', P_ValidTest = False');

    if chkPay.Checked then
      SQL.Add(', P_Pricable = True')
    else
      SQL.Add(', P_Pricable = False');

    if chkOver.Checked then
      SQL.Add(', P_DblFood = True')
    else
      SQL.Add(', P_DblFood = False');

    if chkSob.Checked then
      SQL.Add(', P_Sobhaneh = True')
    else
      SQL.Add(', P_Sobhaneh = False');

    if chkNahar.Checked then
      SQL.Add(', P_Nahar = True')
    else
      SQL.Add(', P_Nahar = False');

    if chkSham.Checked then
      SQL.Add(', P_Sham = True')
    else
      SQL.Add(', P_Sham = False');

    SQL.Add('WHERE NOT (P_BarCode IS NULL)');

    if cmbFrom.Text <> '' then
      SQL.Add(' AND P_BarCode >= ''' + cmbFrom.Text + '''');

    if cmbTo.Text <> '' then
      SQL.Add(' AND P_BarCode <= ''' + cmbTo.Text + '''');

    if cmbPart.Text <> '' then
      SQL.Add('AND P_parts = ' + GetPartCode(Copy(cmbPart.Text, 1, Pos('-', cmbPart.Text)-1)));

    if cmbJob.Text <> '' then
      SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

    ExecSQL;
    Free;
  end;
  Msg_NoWait;
end;

end.
