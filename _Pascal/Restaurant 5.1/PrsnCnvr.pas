unit PrsnCnvr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, AdoDB, DBTables;

type
  TfrmPersonConvert = class(TForm)
    lbl1: TLabel;
    cmbInputFile: TComboBox;
    lbl2: TLabel;
    cmbCodePage: TComboBox;
    grpText: TGroupBox;
    lbl4: TLabel;
    txtChar: TEdit;
    txtCode: TEdit;
    lbl5: TLabel;
    lstDBS: TListBox;
    lstText: TListBox;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    cmdAddAll: TButton;
    cmdAdd: TButton;
    cmdDel: TButton;
    cmdDelAll: TButton;
    cmdUp: TBitBtn;
    cmdDown: TBitBtn;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lstFieldNo: TListBox;
    txtFieldNo: TEdit;
    opnFile: TOpenDialog;
    tblPerson: TAdoTable;
    lblRecNo: TLabel;
    lbl3: TLabel;
    txtPath: TEdit;
    cmdPath: TButton;
    grpDBF: TGroupBox;
    lbl9: TLabel;
    lblDBFRec: TLabel;
    lbl10: TLabel;
    lstDBS1: TListBox;
    lbl11: TLabel;
    lstDBF: TListBox;
    cmdAddDBF: TButton;
    cmdDelDBF: TButton;
    lstDBS_DBF: TListBox;
    lbl12: TLabel;
    tblDBF: TTable;
    procedure FormCreate(Sender: TObject);
    procedure cmbInputFileClick(Sender: TObject);
    procedure cmdAddAllClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdDelClick(Sender: TObject);
    procedure cmdDelAllClick(Sender: TObject);
    procedure cmdUpClick(Sender: TObject);
    procedure cmdDownClick(Sender: TObject);
    procedure txtCharChange(Sender: TObject);
    procedure txtCodeChange(Sender: TObject);
    procedure lstTextClick(Sender: TObject);
    procedure txtFieldNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure lstFieldNoClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPathClick(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure txtFieldNoExit(Sender: TObject);
    procedure cmbInputFileKeyPress(Sender: TObject; var Key: Char);
    procedure txtFieldNoKeyPress(Sender: TObject; var Key: Char);
    procedure lstDBSKeyPress(Sender: TObject; var Key: Char);
    procedure lstTextKeyPress(Sender: TObject; var Key: Char);
    procedure txtPathExit(Sender: TObject);
    procedure cmdAddDBFClick(Sender: TObject);
    procedure cmdDelDBFClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);

    function  ConvertCodePage(s : String) : String;

    function  GetFieldIdxInArray(fldName : String) : Integer;

    function  lstTextIndex(s : String) : Integer;
    procedure TextFieldMove;
    function  RunTextValid : Boolean;
    procedure ConvertTextFile;

    procedure OpenDBF(F_Name : String);
    function  RunDBFValid : Boolean;
    procedure ConvertDBFFile;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  Globals, Keyboard, MSGs, DBS_Proc, Code_Sys;


const
  FILE_TEXT = 0;
  FILE_DBF  = 1;
  FILE_DB   = 2;
  F_TYPENAME : array[FILE_TEXT..FILE_DB] of String =
    ('›«Ì· „ ‰Ì', '›«Ì·  DBF', '›«Ì· DB');

  Max_Field = 14;
  DB_FIELDS : array[0..Max_Field] of String = (
    'P_BarCode',
    'P_Proxi',
    'P_Name',
    'P_Family',
    'P_parts',
    'P_JobCode',
    'P_ShiftGroup',
    'P_IsValid',
    'P_ValidTest',
    'P_Pricable',
    'P_Sobhaneh',
    'P_Nahar',
    'P_Sham',
    'P_Rejim',
    'P_DblFood');

  DB_TYPE : array[0..Max_Field] of String = (
    'S',
    'S',
    'S',
    'S',
    'I',
    'I',
    'I',
    'B',
    'B',
    'B',
    'B',
    'B',
    'B',
    'B',
    'B');

  DB_NAME : array[0..Max_Field] of String = (
    '‘„«—Â Å—”‰·Ì',
    '‘„«—Â ﬂ«— ',
    '‰«„',
    '‰«„ Œ«‰Ê«œêÌ',
    '»Œ‘',
    '‰Ê⁄ «” Œœ«„',
    'ê—ÊÂ ﬂ«—Ì',
    '«Ã«“Â  —œœ',
    ' ”  ﬂ‰ —·  —œœ',
    '«Œ– ÊÃÂ',
    '„Ã«“ »Â ”—Ê ’»Õ«‰Â',
    '„Ã«“ »Â ”—Ê ‰«Â«—',
    '„Ã«“ »Â ”—Ê ‘«„',
    'Å—”‰· —éÌ„Ì',
    '€–«Ì «÷«›Ì');


var
  FieldNo : array[0..Max_Field] of Byte;




procedure TfrmPersonConvert.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

function TfrmPersonConvert.ConvertCodePage(s : String) : String;
begin
  case cmbCodePage.ItemIndex+1 of
    WIN_SINA_SYS,
    WIN_MICROSOFT_SYS: s := ChangeFromWin(s, g_options.WinType, cmbCodePage.ItemIndex+1);

    DOS_IR_SYS,
    DOS_SAYEH_SYS,
    DOS_DP_SYS: s := ChangeFromDos(s, cmbCodePage.ItemIndex+1, g_options.WinType);
  end;
  ConvertCodePage := s;
end;

function TfrmPersonConvert.GetFieldIdxInArray(fldName : String) : Integer;
var i : Byte;
begin
  GetFieldIdxInArray := -1;
  for i := 0 to Max_Field do
    if fldName = (DB_NAME[i]) then
    begin
      GetFieldIdxInArray := i;
      Break;
    end;
end;

function TfrmPersonConvert.lstTextIndex(s : String) : Integer;
var i : Byte;
begin
  lstTextIndex := -1;
  if lstText.Items.Count > 0 then
  begin
    for i := 0 to lstText.Items.Count-1 do
      if lstText.Items.Strings[i] = s then
      begin
        lstTextIndex := i;
        Break;
      end;
  end
end;

 procedure TfrmPersonConvert.TextFieldMove;
var
  n, h : Integer;
begin
  n := lstText.ItemIndex;
  h := txtFieldNo.Height-1;
  if n < 0 then  n := 0;
  txtFieldNo.Top := lstText.Top + (n * h);
  txtFieldNo.Text := IntToStr(FieldNo[n]);
end;

function TfrmPersonConvert.RunTextValid : Boolean;
begin
  if cmbCodePage.Text = '' then
  begin
    RunTextValid := False;
    ErrorMessage('”Ì” „ ﬂœÌ‰ê ›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    cmbCodePage.SetFocus;
  end
  else if (txtChar.Text = '') and (txtCode.Text = '') then
  begin
    RunTextValid := False;
    ErrorMessage('Ãœ« ﬂ‰‰œÂ ›Ì·œÂ«Ì ›«Ì· „ ‰Ì „‘Œ’ ‰Ì” .');
    txtCode.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    RunTextValid := False;
    ErrorMessage('›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    txtPath.SetFocus;
  end
  else if not FileExists(txtPath.Text) then
  begin
    RunTextValid := False;
    ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
    cmdPath.SetFocus;
  end
  else if lstFieldNo.Items.Count < 1 then
  begin
    RunTextValid := False;
    ErrorMessage('›Ì·œÂ«Ì „ ‰«Ÿ— ›«Ì· „ ‰Ì „‘Œ’ ‰Ì” .');
  end
  else
    RunTextValid := True;
end;

procedure TfrmPersonConvert.ConvertTextFile;
var
  FF : TextFile;
  p : Byte;
  LineST, s, Sep : String;
  i, j : Byte;
  a_idx, l_idx, RecNo : Integer;
  OK : Boolean;
begin
  Mouse_Wait;
  MSG_Wait('œ— Õ«· »«“Ì«»Ì «ÿ·«⁄« ...');
  lblRecNo.Visible := True;
  RecNo := 0;
  tblPerson.Open;
  if txtChar.Text <> '' then
    Sep := txtChar.Text
  else
    Sep := Chr(StrToInt(txtCode.Text));
  AssignFile(FF, txtPath.Text);
  Reset(FF);
  while not Eof(FF) do
  begin
    ReadLn(FF, LineST);
    tblPerson.Append;
    OK := True;
    for i := 0 to lstDBS.Items.Count-1 do
    begin
      l_idx := lstTextIndex(lstDBS.Items.Strings[i]);
      if l_idx > -1 then
      begin
        j := FieldNo[l_idx];
        s := Trim(LineST);
        if s[1] = Sep then Delete(s, 1, 1);
        while j > 1 do
        begin
          p := Pos(Sep, s);
          if p > 0 then Delete(s, 1, p);
          Dec(j);
        end;
        p := Pos(Sep, s);
        if p > 0 then Delete(s, p, Length(s)-p+1);
        s := Trim(s);
        a_idx := GetFieldIdxInArray(lstDBS.Items.Strings[i]);

        if DB_TYPE[a_idx] = 'S' then
        begin
          s := ConvertCodePage(s);
//          if not IsNumeric(s) then
//            s := StrRev(s);
        end;

        if a_idx = 0 then
        begin
          s := FixLeft(s, '0', 8);
          if s = '' then
            OK := False
          else
          begin
            tblPerson.FieldByName('P_Proxi').AsString := s;
            OK := not IsExistsRec_Str('Persons', 'P_BarCode', s);
            OK := (OK AND (not IsExistsRec_Str('Persons', 'P_Proxi', s)));
          end;
        end;

        if DB_TYPE[a_idx] = 'S' then
          tblPerson.FieldByName(DB_FIELDS[a_idx]).AsString := s
        else if DB_TYPE[a_idx] = 'B' then
        begin
          s := UpperCase(s);
          tblPerson.FieldByName(DB_FIELDS[a_idx]).AsBoolean := ((s='T') or (s='Y') or (s='1'));
        end
        else if DB_TYPE[a_idx] = 'I' then
          if IsNumeric(s) then
            tblPerson.FieldByName(DB_FIELDS[a_idx]).AsInteger := StrToInt(s);
      end
      else if DB_TYPE[i] = 'B' then
        tblPerson.FieldByName(DB_FIELDS[i]).Value := False;
      tblPerson.FieldByName('P_IsGuest').AsBoolean := False;
    end;
    if OK then
    begin
      tblPerson.Post;
      Inc(RecNo);
    end
    else
      tblPerson.Cancel;

    lblRecNo.Caption := IntToStr(RecNo);
    lblRecNo.Refresh;
  end;
  CloseFile(FF);
  tblPerson.Close;
  Mouse_NoWait;
  MSG_NoWait;
  lblRecNo.Visible := False;
  InformationMessage(' ⁄œ«œ ' + IntToStr(RecNo) + ' —ﬂÊ—œ »«“Ì«»Ì ‘œ.');
end;

procedure TfrmPersonConvert.OpenDBF(F_Name : String);
var
  i : Integer;
begin
  tblDBF.DatabaseName := ExtractFilePath(F_Name);
  tblDBF.TableName := ExtractFileName(F_Name);
  tblDBF.Open;
  lstDBF.Clear;
  for i := 0 to tblDBF.Fields.Count-1 do
    lstDBF.Items.Add(tblDBF.Fields[i].FieldName);
  tblDBF.Close;
end;

function TfrmPersonConvert.RunDBFValid : Boolean;
begin
  if cmbCodePage.Text = '' then
  begin
    RunDBFValid := False;
    ErrorMessage('”Ì” „ ﬂœÌ‰ê ›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    cmbCodePage.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    RunDBFValid := False;
    ErrorMessage('›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    txtPath.SetFocus;
  end
  else if lstDBS_DBF.Items.Count < 1 then
  begin
    RunDBFValid := False;
    ErrorMessage('›Ì·œÂ«Ì „ ‰«Ÿ— ›«Ì· «ÿ·«⁄« Ì „‘Œ’ ‰Ì” .');
  end
  else
    RunDBFValid := True;
end;

procedure TfrmPersonConvert.ConvertDBFFile;
var
  p : Byte;
  s, DBS_Fld, DBF_Fld : String;
  i, j : Byte;
  RecNo : Integer;
  OK : Boolean;
begin
  Mouse_Wait;
  //MSG_Wait('œ— Õ«· »«“Ì«»Ì «ÿ·«⁄« ...');
  lblDBFRec.Visible := True;
  RecNo := 0;
  tblPerson.Open;
  tblDBF.Open;
  while not tblDBF.Eof do
  begin
    tblPerson.Append;
    OK := True;
    for i := 0 to lstDBS1.Items.Count-1 do
    begin
      DBS_Fld := lstDBS1.Items.Strings[i];
      DBF_Fld := '';
      for j := 0 to lstDBS_DBF.Items.Count-1 do
      begin
        if Pos(DBS_Fld, lstDBS_DBF.Items.Strings[j]) > 0 then
        begin
          p := Pos('<-', lstDBS_DBF.Items.Strings[j]);
          if p > 0 then
            DBF_Fld := Copy(lstDBS_DBF.Items.Strings[j], p+2, Length(lstDBS_DBF.Items.Strings[j]));
          Break;
        end;
      end;

      DBS_Fld := DB_FIELDS[i];
      if DBF_Fld <> '' then
        s := Trim(tblDBF.FieldByName(DBF_Fld).AsString)
      else
        s := '';

      if DB_TYPE[i] = 'S' then
      begin
        if DB_FIELDS[i] = 'P_BarCode' then
          s := FixLeft(s, '0', 8);
        s := ConvertCodePage(s);
        if not IsNumeric(s) and (cmbCodePage.ItemIndex >= 2)then
          s := StrRev(s);
      end;

      if DBS_Fld = DB_FIELDS[0] then
      begin
        tblPerson.FieldByName('P_Proxi').AsString := s;
        OK := not IsExistsRec_Str('Persons', 'P_BarCode', s);
        OK := (OK AND (not IsExistsRec_Str('Persons', 'P_Proxi', s)));
      end;

      if DB_TYPE[i] = 'S' then
      begin
        if not ((DBS_Fld = DB_FIELDS[1]) and (s = '')) then
          tblPerson.FieldByName(DBS_Fld).AsString := s
      end
      else if DB_TYPE[i] = 'B' then
      begin
        if s <> '' then
          s := Copy(UpperCase(s), 1, 1);
        tblPerson.FieldByName(DBS_Fld).AsBoolean := ((s='T') or (s='Y') or (s='1'));
      end
      else if DB_TYPE[i] = 'I' then
      begin
        s := ConvertCodePage(s);
        if (s <> '') and IsNumeric(s) then
          tblPerson.FieldByName(DBS_Fld).AsInteger := StrToInt(s)
      end
    end;

    if OK then
    begin
      tblPerson.FieldByName('P_IsGuest').AsBoolean := False;
      Inc(RecNo);
      tblPerson.Post;
    end
    else
      tblPerson.Cancel;

    lblDBFRec.Caption := IntToStr(RecNo);
    lblDBFRec.Refresh;
    tblDBF.Next;
  end;
  tblPerson.Close;
  tblDBF.Close;
  Mouse_NoWait;
  //MSG_NoWait;
  lblDBFRec.Visible := False;
  InformationMessage(' ⁄œ«œ ' + IntToStr(RecNo) + ' —ﬂÊ—œ »«“Ì«»Ì ‘œ.');
end;

procedure TfrmPersonConvert.FormCreate(Sender: TObject);
var i : Byte;
begin
  tblPerson.connection := frmDBS.DBConnection;
  for i := FILE_TEXT to FILE_DB do
    cmbInputFile.Items.Add((F_TypeName[i]));

  for i := WIN_SINA_SYS to DOS_DP_SYS do
    cmbCodePage.Items.Add(CodePageName[i]);

  for i := 0 to Max_Field do
  begin
    lstDBS.Items.Add((DB_NAME[i]));
    lstDBS1.Items.Add((DB_NAME[i]));
    FieldNo[i] := i+1;
  end;

end;

procedure TfrmPersonConvert.FormActivate(Sender: TObject);
begin
  txtFieldNo.Height := 18;
  cmbInputFile.ItemIndex := 0;
  cmbCodePage.ItemIndex := 0;
  cmbInputFileClick(Sender);
  grpText.Top := 32;
  grpDBF.Top := 32;
end;

procedure TfrmPersonConvert.cmdPathClick(Sender: TObject);
begin
  opnFile.InitialDir := g_options.DataBasePath;
  if cmbInputFile.ItemIndex = FILE_TEXT then
    opnFile.Filter := 'Text Files (*.TXT) | *.TXT'
  else if cmbInputFile.ItemIndex = FILE_DBF then
    opnFile.Filter := 'DBase Files (*.DBF) | *.DBF'
  else if cmbInputFile.ItemIndex = FILE_DB then
    opnFile.Filter := 'Paradox DBase Files (*.DB) | *';
  if opnFile.Execute then
  begin
    txtPath.Text := opnFile.FileName;
    if cmbInputFile.ItemIndex in [FILE_DBF, FILE_DB] then
    begin
      if not FileExists(txtPath.Text) then
      begin
        ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
        cmdPath.SetFocus;
      end
      else
        OpenDBF(txtPath.Text);
    end;
  end;
end;

procedure TfrmPersonConvert.cmbInputFileClick(Sender: TObject);
begin
  grpText.Visible := (cmbInputFile.ItemIndex = FILE_TEXT);
  grpDBF.Visible := (cmbInputFile.ItemIndex = FILE_DBF) OR (cmbInputFile.ItemIndex = FILE_DB);
end;

procedure TfrmPersonConvert.cmdAddAllClick(Sender: TObject);
var i : Byte;
begin
  lstText.Clear;
  for i := 0 to lstDBS.Items.Count - 1 do
  begin
    lstText.Items.Add(lstDBS.Items.Strings[i]);
    lstFieldNo.Items.Add(IntToStr(FieldNo[i]));
  end;
  TextFieldMove;
end;

procedure TfrmPersonConvert.cmdAddClick(Sender: TObject);
begin
  if lstDBS.ItemIndex >= 0 then
    if lstTextIndex(lstDBS.Items.Strings[lstDBS.ItemIndex]) = -1 then
    begin
      lstText.Items.Add(lstDBS.Items.Strings[lstDBS.ItemIndex]);
      lstFieldNo.Items.Add(IntToStr(FieldNo[lstText.Items.Count-1]));
      TextFieldMove;
    end;
end;

procedure TfrmPersonConvert.cmdDelClick(Sender: TObject);
begin
  if lstText.ItemIndex >= 0 then
  begin
    lstFieldNo.Items.Delete(lstText.ItemIndex);
    lstText.Items.Delete(lstText.ItemIndex);
    TextFieldMove;
  end;
end;

procedure TfrmPersonConvert.cmdDelAllClick(Sender: TObject);
begin
  lstText.Clear;
  lstFieldNo.Clear;
  TextFieldMove;
  txtFieldNo.Text := '';
end;

procedure TfrmPersonConvert.cmdUpClick(Sender: TObject);
var
  l : Byte;
  s : String;
begin
  l := lstText.ItemIndex;
  if l > 0 then
  begin
    s := lstText.Items.Strings[l-1];
    lstText.Items.Strings[l-1] := lstText.Items.Strings[l];
    lstText.Items.Strings[l] := s;
    lstText.ItemIndex := l-1;
  end;
end;

procedure TfrmPersonConvert.cmdDownClick(Sender: TObject);
var
  l : Byte;
  s : String;
begin
  l := lstText.ItemIndex;
  if l < lstText.Items.Count-1 then
  begin
    s := lstText.Items.Strings[l+1];
    lstText.Items.Strings[l+1] := lstText.Items.Strings[l];
    lstText.Items.Strings[l] := s;
    lstText.ItemIndex := l+1;
  end;
end;

procedure TfrmPersonConvert.txtCharChange(Sender: TObject);
begin
  if txtChar.Text <> '' then txtCode.Text := '';
end;

procedure TfrmPersonConvert.txtCodeChange(Sender: TObject);
begin
  if txtCode.Text <> '' then txtChar.Text := '';
end;

procedure TfrmPersonConvert.lstTextClick(Sender: TObject);
begin
  lstFieldNo.ItemIndex := lstText.ItemIndex;
  TextFieldMove;
end;

procedure TfrmPersonConvert.txtFieldNoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key in [38, 40] then
  begin
    if lstFieldNo.ItemIndex < 0 then
      lstFieldNo.ItemIndex := 0;
    if txtFieldNo.Text <> '' then
    begin
      FieldNo[lstFieldNo.ItemIndex] := StrToInt(txtFieldNo.Text);
      lstFieldNo.Items.Strings[lstFieldNo.ItemIndex] := txtFieldNo.Text;
    end;

    if (Key = 38) and (lstFieldNo.ItemIndex > 0) then
      lstFieldNo.ItemIndex := lstFieldNo.ItemIndex - 1
    else if (Key = 40) and (lstFieldNo.ItemIndex < Max_Field) then
      lstFieldNo.ItemIndex := lstFieldNo.ItemIndex + 1;

    Key := 0;
    lstFieldNoClick(Sender);
  end
end;


procedure TfrmPersonConvert.lstFieldNoClick(Sender: TObject);
begin
  lstText.ItemIndex := lstFieldNo.ItemIndex;
  TextFieldMove;
end;

procedure TfrmPersonConvert.txtCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
  SendTab(Key);
end;

procedure TfrmPersonConvert.cmbInputFileKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPersonConvert.txtPathExit(Sender: TObject);
begin
  if (cmbInputFile.ItemIndex in [FILE_DBF, FILE_DB]) and  (txtPath.Text <> '') then
  begin
    if not FileExists(txtPath.Text) then
    begin
      ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
      cmdPath.SetFocus;
    end
    else
      OpenDBF(txtPath.Text);
  end;
end;

procedure TfrmPersonConvert.txtFieldNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
  SendTab(Key);
end;

procedure TfrmPersonConvert.lstDBSKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #32 then
  begin
    Key := #0;
    cmdAddClick(Sender);
  end;
  SendTab(Key);
end;

procedure TfrmPersonConvert.lstTextKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #32 then
  begin
    Key := #0;
    cmdDelClick(Sender);
  end;
  SendTab(Key);
end;

procedure TfrmPersonConvert.cmdRunClick(Sender: TObject);
begin
  case cmbInputFile.ItemIndex of
    FILE_TEXT: if RunTextValid then ConvertTextFile;
    FILE_DBF,
    FILE_DB  : if RunDBFValid then ConvertDBFFile;
    else
    begin
      ErrorMessage('‰Ê⁄ ›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
      cmbInputFile.SetFocus;
    end;
  end;
end;

procedure TfrmPersonConvert.txtFieldNoExit(Sender: TObject);
begin
  if lstFieldNo.ItemIndex < 0 then lstFieldNo.ItemIndex := 0;
  if txtFieldNo.Text <> '' then
  begin
    FieldNo[lstFieldNo.ItemIndex] := StrToInt(txtFieldNo.Text);
    lstFieldNo.Items.Strings[lstFieldNo.ItemIndex] := txtFieldNo.Text;
  end;

  lstFieldNoClick(Sender);
end;

procedure TfrmPersonConvert.cmdAddDBFClick(Sender: TObject);
var s : String;
begin
  if lstDBS1.ItemIndex >= 0 then
  begin
    if lstDBF.ItemIndex >= 0 then
    begin
      s := lstDBS1.Items.Strings[lstDBS1.ItemIndex] + '<-' +
           lstDBF.Items.Strings[lstDBF.ItemIndex];
      if lstDBS_DBF.Items.IndexOf(s) = -1 then
        lstDBS_DBF.Items.Add(s);
    end
    else
      ErrorMessage('›Ì·œ „ ‰«Ÿ— »«‰ﬂ DBF „‘Œ’ ‰Ì” .');
  end
  else
    ErrorMessage('›Ì·œ »«‰ﬂ «ÿ·«⁄«  Å—”‰· „‘Œ’ ‰Ì” .');
end;

procedure TfrmPersonConvert.cmdDelDBFClick(Sender: TObject);
var i : Byte;
begin
  if lstDBS_DBF.ItemIndex >= 0 then
  begin
    i := lstDBS_DBF.ItemIndex;
    lstDBS_DBF.Items.Delete(lstDBS_DBF.ItemIndex);
    if lstDBS_DBF.Items.Count > 0 then
      lstDBS_DBF.ItemIndex := i;
  end;

end;

end.
