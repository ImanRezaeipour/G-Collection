unit PrsnCnvr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, ADODB;

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
    tblPerson: TTable;
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
    adoTblPerson: TADOTable;
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
    procedure SetWinF;
    procedure SendTab(var Key : Char);

    function  ConvertCodePage(s : String) : String;

    function  GetFieldIdxInArray(fldName : String) : Integer;

    function  lstTextIndex(s : String) : Integer;
    procedure TextFieldMove;
    function  RunTextValid : Boolean;
    procedure ConvertTextFile;

    function  IsExistInlstDBF(s : String) : Boolean;
    procedure OpenDBF(F_Name : String);
    function  RunDBFValid : Boolean;
    procedure ConvertDBFFile;
  public
    { Public declarations }
  end;

var frmPersonConvert : TfrmPersonConvert;

implementation

{$R *.DFM}

uses
  Globals, Keyboard, MSGs, DBS, Code_Sys, DateProc, Funcs, FntSel;


const
  FILE_TEXT = 0;
  FILE_DBF  = 1;
  FILE_DB   = 2;
  F_TYPENAME : array[FILE_TEXT..FILE_DB] of String =
    ('فايل متني', 'فايل  DBF', 'فايل DB');

  MB_FLDNAME = 0;
  MB_FLDTYPE = 1;
  MB_NAME    = 2;
  Max_Field  = 10;
  DB_FIELDS : array[0..Max_Field, MB_FLDNAME..MB_NAME] of String = (
    ('Empl_No',        'S', 'شماره پرسنلي'),
    ('Empl_ID',        'S', 'شماره كارت'),
    ('Empl_Name',      'S', 'نام'),
    ('Empl_Family',    'S', 'نام خانوادگي'),
    ('Empl_Active',    'B', 'فعال'),
    ('Empl_Department','I', 'مرکز'),
    ('Empl_CoPost',    'I', 'جايگاه'),
    ('Empl_Part',      'I', 'محل خدمت'),
    ('Empl_Dscnt',     'I', 'گروه تخفيف'),
    ('Empl_ExpDate',   'I', 'تاريخ اعتبار'), //kaveh );
    ('Empl_MoRange',   'I', 'گروه سقف ماهانه')); //kaveh
var
  FieldNo : array[0..Max_Field] of Byte;


procedure TfrmPersonConvert.SetWinF;
begin
end;

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
    DOS_IR_SYS,
    DOS_SAYEH_SYS,
    DOS_DP_SYS: ConvertCodePage := DosToWin(s, cmbCodePage.ItemIndex+1, WinSysType);

    WIN_MICROSOFT_SYS:
    begin
      if WinSysType = WIN_SINA_SYS then
        ConvertCodePage := Microsoft_To_WinSina(s)
      else
        ConvertCodePage := s;
    end;
    WIN_SINA_SYS:
    begin
      if WinSysType = WIN_MICROSOFT_SYS then
        ConvertCodePage := WinSina_To_Microsoft(s)
      else
        ConvertCodePage := s;
    end;
  end;
end;

function TfrmPersonConvert.GetFieldIdxInArray(fldName : String) : Integer;
var i : Byte;
begin
  GetFieldIdxInArray := -1;
  for i := 0 to Max_Field do
    if fldName = (DB_FIELDS[i][MB_NAME]) then
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
    ErrorMessage('سيستم كدينگ فايل ورودي مشخص نيست.');
    cmbCodePage.SetFocus;
  end
  else if (txtChar.Text = '') and (txtCode.Text = '') then
  begin
    RunTextValid := False;
    ErrorMessage('جدا كننده فيلدهاي فايل متني مشخص نيست.');
    txtCode.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    RunTextValid := False;
    ErrorMessage('فايل ورودي مشخص نيست.');
    txtPath.SetFocus;
  end
  else if not FileExists(txtPath.Text) then
  begin
    RunTextValid := False;
    ErrorMessage('فايل ورودي وجود ندارد.');
    cmdPath.SetFocus;
  end
  else if lstFieldNo.Items.Count < 1 then
  begin
    RunTextValid := False;
    ErrorMessage('فيلدهاي متناظر فايل متني مشخص نيست.');
  end
  else
    RunTextValid := True;
end;

procedure TfrmPersonConvert.ConvertTextFile;
var
  F : TextFile;
  p : Byte;
  LineST, s, Sep : String;
  i, j : Byte;
  a_idx, l_idx, RecNum : Integer;
  OK : Boolean;
  pCOde,Part : string;
  procedure del(var s : string ; index , code : integer);
  begin
   delete(s,index,code);
  end;
  function _eof(Var F : TextFile) : Boolean;
  begin
    result := Eof(f);
  end;
begin
  Mouse_Wait;
  MSG_Wait('در حال بازيابي اطلاعات...');
  lblRecNo.Visible := True;
  RecNum := 0;
  with adoTblPerson do
  begin
    Open;
    if txtChar.Text <> '' then Sep := txtChar.Text
    else                       Sep := Chr(StrToInt(txtCode.Text));
    AssignFile(F, txtPath.Text);
    Reset(F);
    while not _eof(F) do
    begin
      ReadLn(F, LineST);
      OK := True;
      for i := 0 to lstDBS.Items.Count-1 do
      begin
        l_idx := lstTextIndex(lstDBS.Items.Strings[i]);
        if l_idx > -1 then
        begin
          j := FieldNo[l_idx];
          s := Trim(LineST);
          if s[1] = Sep then Del(s, 1, 1);
          while j > 1 do
          begin
            p := Pos(Sep, s);
            if p > 0 then Del(s, 1, p);
            Dec(j);
          end;
          p := Pos(Sep, s);
          if p > 0 then Del(s, p, Length(s)-p+1);
          s := Trim(s);
          a_idx := GetFieldIdxInArray(lstDBS.Items.Strings[i]);

          if DB_FIELDS[a_idx][MB_FLDTYPE] = 'S' then
          begin
            s := ConvertCodePage(s);
            if not IsNumeric(s) and not (cmbCodePage.ItemIndex+1 in [WIN_SINA_SYS, WIN_MICROSOFT_SYS]) then
              s := StrRev(s);
          end;

          if a_idx = 0 then
          begin
            s := FixLeft(s, '0', 8);
            if s = '00000000' then
              OK := False
            else
            begin
              OK := not Locate('Empl_No', s,[loPartialKey]);
              if not OK then
              BEGIN
                adoTblPerson.edit;
                pCOde := s;
              END
              ELSE
                Append;
              FieldByName('Empl_ID').AsString := '';
//            OK := (OK AND (not IsExistsRec_Str('Employee', 'P_Proxi', s)));
              pCOde := s;
            end;
          end;
          if a_idx = 7 then
          begin
            Part := s;
          end;
          if DB_FIELDS[a_idx][MB_FLDTYPE] = 'S' then
            FieldByName(DB_FIELDS[a_idx][MB_FLDNAME]).AsString := s
          else if DB_FIELDS[a_idx][MB_FLDTYPE] = 'B' then
          begin
            s := UpperCase(s);
            FieldByName(DB_FIELDS[a_idx][MB_FLDNAME]).AsBoolean := ((s='T') or (s='Y') or (s='1'));
          end
          else if DB_FIELDS[a_idx][MB_FLDTYPE] = 'I' then
          begin
            if IsNumeric(s) then
              FieldByName(DB_FIELDS[a_idx][MB_FLDNAME]).AsInteger := StrToInt(s)
            else if IsDosNumeric(s) then
              FieldByName(DB_FIELDS[a_idx][MB_FLDNAME]).AsInteger := StrToInt(NumDosToWin(s))
          end;
        end
        else if DB_FIELDS[i][MB_FLDTYPE] = 'B' then
          if DB_FIELDS[i][MB_FLDNAME] = 'Empl_Active' then
            FieldByName(DB_FIELDS[i][MB_FLDNAME]).Value := True
          else
            FieldByName(DB_FIELDS[i][MB_FLDNAME]).Value := False;
      end;
      if OK then
      begin
        Post;
        Inc(RecNum);
      end
      else
      begin
        if ConfirmMessage(' شماره پرسنلی ' + PCODE +
                              ' قبلا در سیستم وارد شده است . ' + #13 + ' کد محل خدمت درون فايل : ' + part + #13 +
                              'آياميخواهيد مشخصات جديد جايگزين گردد؟') then
        begin
          post;
          Inc(RecNum);
        end
        else
          Cancel;
      end;

      lblRecNo.Caption := IntToStr(RecNum);
      lblRecNo.Refresh;
    end;
    CloseFile(F);
    Close;
  end;
  Mouse_NoWait;
  MSG_NoWait;
  lblRecNo.Visible := False;
  InformationMessage('تعداد ' + IntToStr(RecNum) + ' ركورد بازيابي شد.');
end;

function TfrmPersonConvert.IsExistInlstDBF(s : String) : Boolean;
var i : Byte;
begin
  IsExistInlstDBF := False;
  if lstDBS_DBF.Items.Count > 0 then
  begin
    for i := 0 to lstDBS_DBF.Items.Count-1 do
      if lstDBS_DBF.Items.Strings[i] = s then
      begin
        IsExistInlstDBF := True;
        Break;
      end;
  end
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
    ErrorMessage('سيستم كدينگ فايل ورودي مشخص نيست.');
    cmbCodePage.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    RunDBFValid := False;
    ErrorMessage('فايل ورودي مشخص نيست.');
    txtPath.SetFocus;
  end
  else if lstDBS_DBF.Items.Count < 1 then
  begin
    RunDBFValid := False;
    ErrorMessage('فيلدهاي متناظر فايل اطلاعاتي مشخص نيست.');
  end
  else
    RunDBFValid := True;
end;

procedure TfrmPersonConvert.ConvertDBFFile;
var
  p : Byte;
  s, DBS_Fld, DBF_Fld : String;
  i, j : Byte;
  RecNum : Integer;
  OK : Boolean;
begin
  Mouse_Wait;
  //MSG_Wait('در حال بازيابي اطلاعات...');
  lblDBFRec.Visible := True;
  RecNum := 0;
  with adoTblPerson do
  begin
    Open;
    tblDBF.Open;
    while not tblDBF.Eof do
    begin
      Append;
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

        DBS_Fld := DB_FIELDS[i][MB_FLDNAME];
        if DBF_Fld <> '' then
          s := Trim(tblDBF.FieldByName(DBF_Fld).AsString)
        else
          s := '';

        if DB_FIELDS[i][MB_FLDTYPE] = 'S' then
        begin
          if DB_FIELDS[i][MB_FLDNAME] = 'Empl_No' then
            s := FixLeft(s, '0', 8);
          s := ConvertCodePage(s);
          if (not IsNumeric(s)) and (not IsTrueDate(s)) and (not (cmbCodePage.ItemIndex+1 in [WIN_SINA_SYS, WIN_MICROSOFT_SYS])) then
            s := StrRev(s);
        end;

//        if (DB_FIELDS[i][MB_FLDNAME] = 'P_Proxi') and (s = '') then
//          Continue;

        if DBS_Fld = DB_FIELDS[0][MB_FLDNAME] then
        begin
//          FieldByName('P_Proxi').AsString := s;
          OK := not IsExistsRec_Str('Employee', 'Empl_No', s);
//          OK := (OK AND (not IsExistsRec_Str('Persons', 'P_Proxi', s)));
        end;

        if DB_FIELDS[i][MB_FLDTYPE] = 'S' then
          FieldByName(DBS_Fld).AsString := s
        else if DB_FIELDS[i][MB_FLDTYPE] = 'B' then
        begin
          if s <> '' then
            s := Copy(UpperCase(s), 1, 1)
          else if DB_FIELDS[i][MB_FLDNAME] = 'Empl_Active' then
            s := 'T';

          FieldByName(DBS_Fld).AsBoolean := ((s='T') or (s='Y') or (s='1'));
        end
        else if DB_FIELDS[i][MB_FLDTYPE] = 'I' then
        begin
          s := ConvertCodePage(s);
          if (s <> '') and IsNumeric(s) then
            FieldByName(DBS_Fld).AsInteger := StrToInt(s)
        end
      end;

      if OK then
      begin
        Inc(RecNum);
        Post;
      end
      else
        Cancel;

      lblDBFRec.Caption := IntToStr(RecNum);
      lblDBFRec.Refresh;
      tblDBF.Next;
    end;
    Close;
  end;
  tblDBF.Close;
  Mouse_NoWait;
  //MSG_NoWait;
  lblDBFRec.Visible := False;
  InformationMessage('تعداد ' + IntToStr(RecNum) + ' ركورد بازيابي شد.');
end;

procedure TfrmPersonConvert.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetFontColor(TForm(frmPersonConvert));
  adoTblPerson.Connection := frmDBS.adoConnect;

  for i := FILE_TEXT to FILE_DB do
    cmbInputFile.Items.Add(F_TypeName[i]);

  for i := WIN_SINA_SYS to DOS_DP_SYS do
    cmbCodePage.Items.Add(CodePageName[i]);

  for i := 0 to Max_Field do
  begin
    lstDBS.Items.Add((DB_FIELDS[i][MB_NAME]));
    lstDBS1.Items.Add((DB_FIELDS[i][MB_NAME]));
    FieldNo[i] := i+1;
  end;

end;

procedure TfrmPersonConvert.FormActivate(Sender: TObject);
begin
  SetWinF;
  txtFieldNo.Height := 18;
  cmbInputFile.ItemIndex := 0;
  cmbCodePage.ItemIndex := 0;
  cmbInputFileClick(Sender);
  grpText.Top := 48;
  grpDBF.Top := 48;
end;

procedure TfrmPersonConvert.cmdPathClick(Sender: TObject);
begin
  opnFile.InitialDir := gOptions.DataBasePath;
  if cmbInputFile.ItemIndex = 0 then
    opnFile.Filter := 'Text Files (*.TXT) | *.TXT | Comma Seperated(*.CSV) | *.CSV'
  else if cmbInputFile.ItemIndex = 1 then
    opnFile.Filter := 'DBase Files (*.DBF) | *.DBF'
  else if cmbInputFile.ItemIndex = 2 then
    opnFile.Filter := 'DBase Files (*.DB) | *.DB';

  if opnFile.Execute then
  begin
    txtPath.Text := opnFile.FileName;
    if cmbInputFile.ItemIndex in [FILE_DBF, FILE_DB] then
    begin
      if not FileExists(txtPath.Text) then
      begin
        ErrorMessage('فايل ورودي وجود ندارد.');
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
  if ((cmbInputFile.ItemIndex = FILE_DBF) or (cmbInputFile.ItemIndex = FILE_DBF)) and
     (txtPath.Text <> '') then
  begin
    if not FileExists(txtPath.Text) then
    begin
      ErrorMessage('فايل ورودي وجود ندارد.');
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

procedure TfrmPersonConvert.lstTextKeyPress(Sender: TObject; var Key: Char);
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
    FILE_DB,
    FILE_DBF : if RunDBFValid then ConvertDBFFile;
    else
    begin
      ErrorMessage('نوع فايل ورودي مشخص نيست.');
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
      if not IsExistInlstDBF(s) then
        lstDBS_DBF.Items.Add(s);
    end
    else
      ErrorMessage('فيلد متناظر بانك DBF مشخص نيست.');
  end
  else
    ErrorMessage('فيلد بانك اطلاعات پرسنل مشخص نيست.');
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
