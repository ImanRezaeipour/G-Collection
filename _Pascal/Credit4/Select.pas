unit Select;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ADODb, DBTables, DosMove;

type
  TfrmSelect = class(TForm)
    GroupBox1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    cmbFromNo: TComboBox;
    cmbFromFamily: TComboBox;
    cmbToNo: TComboBox;
    cmbToFamily: TComboBox;
    cmdSelect: TBitBtn;
    cmdDelete: TBitBtn;
    cmdDeleteAll: TBitBtn;
    lstSelect: TListBox;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    DosMove1: TDosMove;
    procedure cmbFromNoKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFromNoExit(Sender: TObject);
    procedure cmbFromFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFromFamilyExit(Sender: TObject);
    procedure cmbToNoExit(Sender: TObject);
    procedure cmbToFamilyExit(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure cmdDeleteAllClick(Sender: TObject);
    procedure cmbToNoKeyPress(Sender: TObject; var Key: Char);
    procedure cmbToFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure lstSelectKeyPress(Sender: TObject; var Key: Char);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function IsNot_InList(Item : String):Boolean;

  public
    { Public declarations }
  end;

var
  frmSelect: TfrmSelect;

implementation

uses
  Globals, KeyBoard, DBS, Msgs, Funcs;


{$R *.DFM}

function TfrmSelect.IsNot_InList(Item : String):Boolean;
var
  i : Integer;
begin
  IsNot_InList := True;
  for i := 0 to lstSelect.Items.Count - 1 do
    if lstSelect.Items.Strings[i] = Item then
    begin
      IsNot_InList := False;
      Exit;
    end;
end;

procedure TfrmSelect.FormShow(Sender: TObject);
var
  qry : TAdoQuery;
begin
  cmbFromNo.Clear;
  cmbToNo.Clear;
  cmbFromFamily.Clear;
  cmbToFamily.Clear;

  with qry do
  begin
    qry := TAdoQuery.Create(Application);
    Connection := frmDBS.DBConnection;
    SQL.Add('SELECT * FROM nPersons '); //kaveh WHERE P_IsValid <> 0');

{//kaveh
    if g_Options.userPart1 <> 0 then SQL.Add('AND P_Part1 = ' + IntToStr(g_Options.userPart1));
    if g_Options.userPart2 <> 0 then SQL.Add('AND P_Part2 = ' + IntToStr(g_Options.userPart2));
    if g_Options.userPart3 <> 0 then SQL.Add('AND P_Part3 = ' + IntToStr(g_Options.userPart3));
    if g_Options.userPart4 <> 0 then SQL.Add('AND P_Part4 = ' + IntToStr(g_Options.userPart4));
}//kaveh

//kaveh    SQL.Add('ORDER BY P_BarCode');
    SQL.Add('ORDER BY np_code'); //kaveh
    Open;
    while not Eof do
    begin
//kaveh      cmbFromNo.Items.Add(FieldByName('P_Barcode').AsString);
      cmbFromNo.Items.Add(FieldByName('np_code').AsString); //kaveh
//kaveh      cmbToNo.Items.Add(FieldByName('P_Barcode').AsString);
      cmbToNo.Items.Add(FieldByName('np_code').AsString); //kaveh
      cmbFromFamily.Items.Add(FieldByName('nP_Family').AsString +'-'+ FieldByName('nP_Name').AsString);
      cmbToFamily.Items.Add(FieldByName('nP_Family').AsString +'-'+ FieldByName('nP_Name').AsString);
      Next;
    end;

    cmbFromNo.ItemIndex := -1;
    cmbFromFamily.ItemIndex := -1;
    cmbToNo.ItemIndex := -1;
    cmbToFamily.ItemIndex := -1;

    Close;
    Free;
  end;
end;

procedure TfrmSelect.cmdSelectClick(Sender: TObject);
var
  i : Integer;
begin
  if (cmbFromNo.Text <> '') and (cmbFromFamily.Text <> '') then
  begin
    if (cmbToNo.Text <> '') and (cmbToFamily.Text <> '')then
    begin
      if cmbFromNo.ItemIndex > cmbToNo.ItemIndex then
      begin
        ErrorMessage('‘«Œ’ ‘—Ê⁄ «“ ‘«Œ’ Å«Ì«‰ »“—ê — „Ì »«‘œ');
        Exit;
      end
      else
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· œ—Ã «”«„Ì...');
        for i := cmbFromNo.ItemIndex to cmbToNo.ItemIndex do
          if IsNot_InList(cmbFromNo.Items.Strings[i]) then
            lstSelect.Items.Add(cmbFromNo.Items.Strings[i]);
        Msg_NoWait;
        Mouse_NoWait;
      end;
    end
    else
      if IsNot_InList(cmbFromNo.Text) then
        lstSelect.Items.Add(cmbFromNo.Text);
  end
  else
    ErrorMessage('„‘ —Ì «Ì »—«Ì «÷«›Â ﬂ—œ‰ »Â ·Ì”  «‰ Œ«» ‰‘œÂ «” ');
end;

procedure TfrmSelect.cmdDeleteClick(Sender: TObject);
begin
  if lstSelect.Items.Count > 0 then
    if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø') then
      lstSelect.Items.Delete(lstSelect.ItemIndex);
end;

procedure TfrmSelect.cmdDeleteAllClick(Sender: TObject);
begin
  if lstSelect.Items.Count > 0 then
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂ·ÌÂ «”«„Ì «ÿ„Ì‰«‰ œ«—Ìœø') then
      lstSelect.Items.Clear;
end;

procedure TfrmSelect.cmbFromNoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    cmbFromFamily.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure TfrmSelect.cmbFromFamilyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    cmbToNo.SetFocus;
  end;
end;

procedure TfrmSelect.cmbToNoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    cmbToFamily.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure TfrmSelect.cmbToFamilyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    cmdSelect.SetFocus;
  end;
end;

procedure TfrmSelect.cmbFromNoExit(Sender: TObject);
begin
  with cmbFromNo do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0',8))
    else
      ItemIndex := -1;

      cmbFromFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmSelect.cmbFromFamilyExit(Sender: TObject);
begin
  with cmbFromFamily do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(Text)
    else
      ItemIndex := -1;

      cmbFromNo.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmSelect.cmbToNoExit(Sender: TObject);
begin
  with cmbToNo do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0',8))
    else
      ItemIndex := -1;

      cmbToFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmSelect.cmbToFamilyExit(Sender: TObject);
begin
  with cmbToFamily do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(Text)
    else
      ItemIndex := -1;

      cmbToNo.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmSelect.lstSelectKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    cmdSave.SetFocus;
  end;
end;

end.
