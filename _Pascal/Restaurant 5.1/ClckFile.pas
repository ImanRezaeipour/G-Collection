unit ClckFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, dbtables,AdoDB, Buttons, DosMove;

type
  TfrmClockRecFile = class(TForm)
    lbl1: TLabel;
    cmbInType: TComboBox;
    lbl2: TLabel;
    txtInFile: TEdit;
    cmdInFile: TButton;
    chkEmpty: TCheckBox;
    tblClock: TAdoTable;
    opnFile: TOpenDialog;
    cmdReadFile: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    lblNo: TLabel;
    lbl3: TLabel;
    chkSaveSetting: TCheckBox;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdInFileClick(Sender: TObject);
    procedure cmdReadFileClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    procedure SaveSetting;
    procedure ReadPWFClock;
    procedure ReadDPClock;
    procedure ReadTextNoSeperate;
    procedure ReadTextSeperate;

  public
    { Public declarations }
  end;


implementation

uses
  Globals, MSGs, DateProc, DBS_Proc;
{$R *.DFM}


const
  IN_WPD_DBBF          = 0;
  IN_DB_CLOCK          = 1;
  IN_TEXT_8XYYMMDDHHMM = 2;
  IN_TEXT_X_D_H        = 3;

  InTypes : array[IN_WPD_DBBF..IN_TEXT_X_D_H] of string =
            ('DBF œ‰Ì«Ì Å—œ«“‘',
             'DB Õ÷Ê— Ê €Ì«» Å—Ê—‘ œ«œÂ Â«',
             '›«Ì· „ ‰Ì »œÊ‰ Ãœ«”«“ ›Ì·œÂ« XXXXXXXXYYMMDDHHMM',
             '›«Ì· „ ‰Ì »« Ãœ«”«“ ›Ì·œÂ« ID No|Date|Time');


procedure TfrmClockRecFile.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  chkEmpty.Caption := (chkEmpty.Caption);
  chkSaveSetting.Caption := (chkSaveSetting.Caption);
  cmdReadFile.Caption := (cmdReadFile.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmClockRecFile.SaveSetting;
var f : TextFile;
begin
  AssignFile(f, g_options.ProgramPath+'IO_Text.Txt');
  ReWrite(f);
  WriteLn(f, cmbInType.ItemIndex);
  WriteLn(f, txtInFile.Text);
  if chkEmpty.Checked then
    WriteLn(f, MB_TRUE)
  else
    WriteLn(f, MB_FALSE);

  CloseFile(f);
end;


procedure TfrmClockRecFile.ReadPWFClock;
var
  tbl : TTable;
  s, currDate : String;
  RecNo : Integer;
begin
  tbl := TTable.Create(Application);
  tbl.DatabaseName := ExtractFilePath(txtInFile.Text);
  tbl.TableName := ExtractFileName(txtInFile.Text);
  tbl.Open;
  if (tbl.FindField('Date') = nil) or
     (tbl.FindField('Card') = nil) or
     (tbl.FindField('Time') = nil) then
  begin
    MSG_NoWait;
    Mouse_NoWait;
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì «‰ Œ«» ‘œÂ ‰«œ—”  «” .');
  end
  else
  begin
    if chkEmpty.Checked then
      with TADOQuery.Create(Application) do
      begin
        Connection := frmDBS.DBConnection;
        sql.add('delete from ' + g_options.ClockDBS);
        ExecSQL;
        Free;
      end;
    tblClock.Open;
    RecNo := 0;
    currDate := CurrentDate;
    while not tbl.Eof do
    begin
      s := tbl.FieldByName('Date').AsString;
      Insert('/', s, 5);
      Insert('/', s, 3);
      s := BeautifulDate(s);
      if s = currDate then
      begin
        Inc(RecNo);
        lblNo.Caption := IntToStr(RecNo);
        lblNo.Refresh;
        tblClock.Append;
        tblClock.FieldByName('Clock_BarCode').AsString := FixLeft(tbl.FieldByName('Card').AsString, '0', 8);
        tblClock.FieldByName('Clock_Date').AsString := s;
        tblClock.FieldByName('Clock_Time').AsString := IntToTime(tbl.FieldByName('Time').AsInteger);
        tblClock.FieldByName('Clock_RdrCode').AsInteger := 0;
        tblClock.FieldByName('Clock_RecState').AsInteger := 0;
        tblClock.Post;
      end;
      tbl.Next;
    end;
    tblClock.Close;
    MSG_NoWait;
    Mouse_NoWait;
  end;
  tbl.Close;
  tbl.Free;
end;

procedure TfrmClockRecFile.ReadDPClock;
var
  tbl : TTable;
  RecNo : Integer;
begin
  tbl := TTable.Create(Application);
  tbl.DatabaseName := ExtractFilePath(txtInFile.Text);
  tbl.TableName := ExtractFileName(txtInFile.Text);
  tbl.Open;
  if (tbl.FindField('Clock_BarCode') = nil) or
     (tbl.FindField('Clock_Date') = nil) or
     (tbl.FindField('Clock_Time') = nil) or
     (tbl.FindField('Clock_RdrCode') = nil) or
     (tbl.FindField('Clock_RecState') = nil) then
  begin
    MSG_NoWait;
    Mouse_NoWait;
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì «‰ Œ«» ‘œÂ ‰«œ—”  «” .');
  end
  else
  begin
    if chkEmpty.Checked then
      with TADOQuery.Create(Application) do
      begin
        Connection := frmDBS.DBConnection;
        sql.add('delete from ' + g_options.ClockDBS);
        ExecSQL;
        Free;
      end;

    tblClock.Open;
    RecNo := 0;
    tbl.Filter := 'Clock_Date = ''' + CurrentDate + '''';
    tbl.Filtered := True;
    while not tbl.Eof do
    begin
      Inc(RecNo);
      lblNo.Caption := IntToStr(RecNo);
      lblNo.Refresh;
      tblClock.Append;
      tblClock.FieldByName('Clock_BarCode').AsString := FixLeft(tbl.FieldByName('Clock_BarCode').AsString, '0', 8);
      tblClock.FieldByName('Clock_Date').AsString := tbl.FieldByName('Clock_Date').AsString;
      tblClock.FieldByName('Clock_Time').AsString := IntToTime(tbl.FieldByName('Clock_Time').AsInteger);
      tblClock.FieldByName('Clock_RdrCode').AsInteger := tbl.FieldByName('Clock_RdrCode').AsInteger;
      tblClock.FieldByName('Clock_RecState').AsInteger := tbl.FieldByName('Clock_RecState').AsInteger;
      tblClock.Post;
      tbl.Next;
    end;
    tblClock.Close;
    MSG_NoWait;
    Mouse_NoWait;
  end;
  tbl.Close;
  tbl.Free;
end;

procedure TfrmClockRecFile.ReadTextNoSeperate;
var
  fp : TextFile;
  s : String;
  RecNo : Integer;
begin
  AssignFile(fp, txtInFile.Text);
  ReSet(fp);
  if chkEmpty.Checked then
      with TADOQuery.Create(Application) do
      begin
        Connection := frmDBS.DBConnection;
        sql.add('delete from ' + g_options.ClockDBS);
        ExecSQL;
        Free;
      end;

  tblClock.Open;
  RecNo := 0;
  while not Eof(fp) do
  begin
    Inc(RecNo);
    lblNo.Caption := IntToStr(RecNo);
    lblNo.Refresh;
    ReadLn(fp, s);
    tblClock.Append;
    tblClock.FieldByName('Clock_BarCode').AsString := Copy(s, 1, 8);
    Delete(s, 1, 8);
    tblClock.FieldByName('Clock_Date').AsString := BeautifulDate(Copy(s, 1, 2) + '/' + Copy(s, 3, 2) +'/' + Copy(s, 5, 2));
    Delete(s, 1, 6);
    tblClock.FieldByName('Clock_Time').AsString := BeautifulTime(Copy(s, 1, 2) + ':' + Copy(s, 3, 2));
    tblClock.FieldByName('Clock_RdrCode').AsInteger := 0;
    tblClock.FieldByName('Clock_RecState').AsInteger := 0;
    tblClock.Post;
  end;
  tblClock.Close;
  CloseFile(fp);
  MSG_NoWait;
  Mouse_NoWait;
end;

procedure TfrmClockRecFile.ReadTextSeperate;
var
  fp : TextFile;
  s : String;
  RecNo : Integer;
  p : Byte;
begin
  AssignFile(fp, txtInFile.Text);
  ReSet(fp);
  if chkEmpty.Checked then
      with TADOQuery.Create(Application) do
      begin
        Connection := frmDBS.DBConnection;
        sql.add('delete from ' + g_options.ClockDBS);
        ExecSQL;
        Free;
      end;

  tblClock.Open;
  RecNo := 0;
  while not Eof(fp) do
  begin
    Inc(RecNo);
    lblNo.Caption := IntToStr(RecNo);
    lblNo.Refresh;
    ReadLn(fp, s);
    tblClock.Append;

    p := Pos('|', s);
    tblClock.FieldByName('Clock_BarCode').AsString := FixLeft(Copy(s, 1, p-1), '0', 8);
    Delete(s, 1, p);

    p := Pos('|', s);
    tblClock.FieldByName('Clock_Date').AsString := BeautifulDate(Copy(s, 1, p-1));
    Delete(s, 1, p);

    p := Pos('|', s);
    tblClock.FieldByName('Clock_Time').AsString := BeautifulTime(Copy(s, 1, p-1));
    tblClock.FieldByName('Clock_RdrCode').AsInteger := 0;
    tblClock.FieldByName('Clock_RecState').AsInteger := 0;
    tblClock.Post;
  end;
  tblClock.Close;
  CloseFile(fp);
  MSG_NoWait;
  Mouse_NoWait;
end;


procedure TfrmClockRecFile.FormCreate(Sender: TObject);
var
  i : Byte;
  f : TextFile;
  s : String;
begin
  SetWinF;
  tblClock.connection := frmDBS.DBConnection;
  tblClock.TableName := g_options.ClockDBS;
  for i := IN_WPD_DBBF to IN_TEXT_X_D_H do
    cmbInType.Items.Add((InTypes[i]));
  cmbInType.ItemIndex := 0;
  lblNo.Caption := '0';

  if FileExists(g_options.ProgramPath+'IO_Text.Txt') then
  begin
    AssignFile(f, g_options.ProgramPath+'IO_Text.Txt');
    ReSet(f);
    ReadLn(f, i);
    cmbInType.ItemIndex := i;
    ReadLn(f, s);
    txtInFile.Text := s;
    ReadLn(f, i);
    chkEmpty.Checked := (i = MB_TRUE);
    CloseFile(f);
  end;
end;

procedure TfrmClockRecFile.cmdInFileClick(Sender: TObject);
begin
  case cmbInType.ItemIndex of
    IN_WPD_DBBF          : opnFile.Filter := 'DBF Files |*.DBF';
    IN_DB_CLOCK          : opnFile.Filter := 'DB Files |*';
    IN_TEXT_8XYYMMDDHHMM,
    IN_TEXT_X_D_H        : opnFile.Filter := 'Text Files |*.TXT';
  end;

  if opnFile.Execute then
    txtInFile.Text := opnFile.FileName;
end;

procedure TfrmClockRecFile.cmdReadFileClick(Sender: TObject);
begin
  lblNo.Caption := '0';
  if txtInFile.Text = '' then
  begin
    ErrorMessage('›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    txtInFile.SetFocus;
  end
  else if not FileExists(txtInFile.Text) then
  begin
    ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
    txtInFile.SetFocus;
  end
  else
  begin
    Mouse_Wait;
    MSG_Wait('œ— Õ«· »«“Ì«»Ì —ﬂÊ—œÂ«...');
    SaveSetting;
    case cmbInType.ItemIndex of
      IN_WPD_DBBF          : ReadPWFClock;
      IN_DB_CLOCK          : ReadDPClock;
      IN_TEXT_8XYYMMDDHHMM : ReadTextNoSeperate;
      IN_TEXT_X_D_H        : ReadTextSeperate;
    end;
  end;
end;

end.
