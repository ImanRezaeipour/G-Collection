unit MBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfrmMonthBackup = class(TForm)
    lbl1: TLabel;
    cmbMonth: TComboBox;
    lbl2: TLabel;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    txtYear: TEdit;
    rdoFishes: TRadioGroup;
    chkDisk: TCheckBox;
    chkDelFish: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmbMonthKeyPress(Sender: TObject; var Key: Char);
    procedure txtYearKeyPress(Sender: TObject; var Key: Char);
    procedure txtYearExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    procedure SendTab(var Key : Char);

  public
    { Public declarations }
  end;


implementation


uses
  FileCtrl, DBTables, DB, Globals, DateProc, IOTools, MSGs, Keyboard;

{$R *.DFM}

procedure TfrmMonthBackup.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  for i := 0 to cmbMonth.Items.Count-1 do
    cmbMonth.Items.Strings[i] := (cmbMonth.Items.Strings[i]);
  for i := 0 to rdoFishes.Items.Count-1 do
    rdoFishes.Items.Strings[i] := (rdoFishes.Items.Strings[i]);

  chkDisk.Caption := (chkDisk.Caption);
  chkDelFish.Caption := (chkDelFish.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmMonthBackup.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus
  end;
end;

procedure TfrmMonthBackup.FormCreate(Sender: TObject);
var
  t : String;
  m : Byte;
begin
  SetWinF;
  t := CurrentDate;
  m := StrToInt(Copy(t, 6, 2));
  if m = 1 then m := 12
  else          Dec(m);

  cmbMonth.ItemIndex := m-1;
  txtYear.Text := Copy(t, 1, 4);
end;

procedure TfrmMonthBackup.cmdOKClick(Sender: TObject);
var
  tbl : TTable;
  qry : TQuery;
  sDate, eDate, mDir : String;
begin
  if cmbMonth.Text = '' then
  begin
    ErrorMessage('„«Â „‘Œ’ ‰‘œÂ «” .');
    cmbMonth.SetFocus;
  end
  else if txtYear.Text = '' then
  begin
    ErrorMessage('”«· „‘Œ’ ‰‘œÂ «” .');
    txtYear.SetFocus;
  end
  else if (StrToInt(txtYear.Text) < 1375) or (StrToInt(txtYear.Text) > 1475) then
  begin
    ErrorMessage('”«· »«Ì” Ì œ— „ÕœÊœÂ 1375 Ê 1475 »«‘œ.');
    txtYear.SetFocus;
  end
  else
  begin
    if cmbMonth.ItemIndex < 9 then
      mDir := g_options.ProgramPath + 'M' + txtYear.Text + '0' + IntToStr(cmbMonth.ItemIndex+1) + '\'
    else
      mDir := g_options.ProgramPath + 'M' + txtYear.Text + IntToStr(cmbMonth.ItemIndex+1) + '\';

    tbl := TTable.Create(Application);

    if not DirectoryExists(mDir) then
      if not CreatePath(mDir) then
      begin
        ErrorMessage('«ÌÃ«œ ‘«ŒÂ „Ì”— ‰Ì” .');
        Exit;
      end
      else
      begin
//        tbl.DatabaseName := mDir;
        tbl.Active := False;
        tbl.TableType := ttDefault;

        tbl.TableName := 'Fish.DB';
        tbl.FieldDefs.Clear;
        tbl.IndexDefs.Clear;
        tbl.FieldDefs.Add('Fish_Date', ftString, 10, False);
        tbl.FieldDefs.Add('Fish_Type', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('Fish_No', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('Fish_Time', ftString, 5, False);
        tbl.FieldDefs.Add('Fish_PCode', ftString, 8, False);
        tbl.FieldDefs.Add('Fish_RdrCode', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('Fish_UCode', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('Fish_UKhadamat', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('Fish_UPrc', ftCurrency, 0, False);
        tbl.FieldDefs.Add('Fish_UPay', ftCurrency, 0, False);
        tbl.IndexDefs.Add('', 'Fish_Date; Fish_Type; Fish_No', [ixPrimary]);
        tbl.CreateTable;

        tbl.TableName := 'FishFood.DB';
        tbl.FieldDefs.Clear;
        tbl.IndexDefs.Clear;
        tbl.FieldDefs.Add('FF_Date', ftString, 10, False);
        tbl.FieldDefs.Add('FF_Type', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('FF_FishNo', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('FF_Food', ftSmallInt, 0, False);
        tbl.FieldDefs.Add('FF_Price', ftCurrency, 0, False);
        tbl.FieldDefs.Add('FF_Pay', ftCurrency, 0, False);
        tbl.FieldDefs.Add('FF_No', ftSmallInt, 0, False);
        tbl.CreateTable;
      end;

    sDate := BeautifulDate(txtYear.Text + '/' + IntToStr(cmbMonth.ItemIndex+1) + '/01');
    eDate := BeautifulDate(txtYear.Text + '/' + IntToStr(cmbMonth.ItemIndex+1) + '/31');
    Mouse_Wait;
    MSG_Wait('œ— Õ«· «‰ ﬁ«· «ÿ·«⁄« ...');
    qry := TQuery.Create(Application);
//    qry.DatabaseName := g_options.DataBasePath;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO ''' + mDir + 'Fish.Db''');
    qry.SQL.Add('SELECT * FROM Fish WHERE Fish_Date >= ''' + SDate + '''');
    qry.SQL.Add('AND Fish_Date <= ''' + EDate + '''');
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM FishFood');
    qry.SQL.Add('WHERE FF_Date >= ''' + sDate + '''');
    qry.SQL.Add('AND FF_Date <= ''' + eDate + '''');
    qry.Open;
    if qry.RecordCount > 0 then
    begin
//      tbl.DatabaseName := mDir;
      tbl.TableName := 'FishFood.Db';
      tbl.Open;
      while not qry.Eof do
      begin
        tbl.Filtered := False;
        tbl.Filter := 'FF_Date = ''' + qry.FieldByName('FF_Date').AsString + '''' +
                      ' AND FF_Type = ' + qry.FieldByName('FF_Type').AsString +
                      ' AND FF_FishNo = ' + qry.FieldByName('FF_FishNo').AsString +
                      ' AND FF_Food = ' + qry.FieldByName('FF_Food').AsString;
        tbl.Filtered := True;
        if tbl.RecordCount = 0 then
        begin
          tbl.Append;
          tbl.FieldByName('FF_Date').AsString := qry.FieldByName('FF_Date').AsString;
          tbl.FieldByName('FF_Type').AsInteger := qry.FieldByName('FF_Type').AsInteger;
          tbl.FieldByName('FF_FishNo').AsInteger := qry.FieldByName('FF_FishNo').AsInteger;
          tbl.FieldByName('FF_Food').AsInteger := qry.FieldByName('FF_Food').AsInteger;
          tbl.FieldByName('FF_Price').AsInteger := qry.FieldByName('FF_Price').AsInteger;
          tbl.FieldByName('FF_Pay').AsInteger := qry.FieldByName('FF_Pay').AsInteger;
          tbl.FieldByName('FF_No').AsInteger := qry.FieldByName('FF_No').AsInteger;
          tbl.Post;
        end;

        qry.Next;
      end;
      tbl.Close;
    end;
    qry.Close;

    if chkDelFish.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Fish');
      qry.SQL.Add('WHERE Fish_Date >= ''' + sDate + '''');
      qry.SQL.Add('AND Fish_Date <= ''' + eDate + '''');

      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FishFood');
      qry.SQL.Add('WHERE FF_Date >= ''' + sDate + '''');
      qry.SQL.Add('AND FF_Date <= ''' + eDate + '''');
      qry.ExecSQL;
    end;


    qry.Free;
    tbl.Free;
    Mouse_NoWait;
    MSG_NoWait;
  end;
end;

procedure TfrmMonthBackup.cmbMonthKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmMonthBackup.txtYearKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmMonthBackup.txtYearExit(Sender: TObject);
begin
  if Length(txtYear.Text) = 2 then
    txtYear.Text := '13' + txtYear.Text;
end;

end.
