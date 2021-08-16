unit DBMonth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfrmDBSMonth = class(TForm)
    Label1: TLabel;
    cmbMonth: TComboBox;
    Label2: TLabel;
    pnlArchive: TPanel;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation


uses
  FileCtrl, DBTables, DB, Globals, DateProc, IOTools, MSGs;

{$R *.DFM}

procedure TfrmDBSMonth.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label1.Caption := (Label1.Caption);
  for i := 0 to cmbMonth.Items.Count-1 do
    cmbMonth.Items.Strings[i] := (cmbMonth.Items.Strings[i]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmDBSMonth.FormCreate(Sender: TObject);
var
  t : String;
  m : Byte;
begin
  SetWinF;
  t := CurrentDate;
  m := StrToInt(Copy(t, 6, 2));
  if m = 1 then
    m := 12
  else
    Dec(m);

  cmbMonth.ItemIndex := m-1;
  if DirectoryExists(g_options.DB_MonthPath) then
    pnlArchive.Caption := ('Å«Ì«‰ „«Â ') + cmbMonth.Items.Strings[g_options.ArchiveDate]
  else
    pnlArchive.Caption := ('ÂÌç «‰ ﬁ«·Ì ÊÃÊœ ‰œ«—œ');
end;

procedure TfrmDBSMonth.cmdOKClick(Sender: TObject);
var
  tbl : TTable;
  qry : TQuery;
  t : String;
  y, m : Integer;
begin
  t := CurrentDate;
  y := StrToInt(Copy(t, 1, 4));
  m := StrToInt(Copy(t, 6, 2));
  if m <= cmbMonth.ItemIndex + 1 then
    Dec(y);
  m := cmbMonth.ItemIndex+1;
  t := BeautifulDate(IntToStr(y) + '/' + IntToStr(m) + '/31');
  tbl := TTable.Create(Application);

  if not DirectoryExists(g_options.DB_MonthPath) then
  begin
    if not CreatePath(g_options.DB_MonthPath) then
    begin
      ErrorMessage('«ÌÃ«œ ‘«ŒÂ „Ì”— ‰Ì” .');
      Exit;
    end;
  end;

  if not FileExists(g_options.DB_MonthPath + 'Fish.Db') or
     not FileExists(g_options.DB_MonthPath + 'FishFood.Db') then
  begin
//    tbl.DatabaseName := g_options.DB_MonthPath;
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
    tbl.IndexDefs.Add('', 'FF_Date; FF_Type; FF_FishNo; FF_Food', [ixPrimary]);
    tbl.CreateTable;

  end;

  Mouse_Wait;
  MSG_Wait('œ— Õ«· «‰ ﬁ«· «ÿ·«⁄« ...');
  qry := TQuery.Create(Application);
//  qry.DatabaseName := g_options.DataBasePath;
  qry.SQL.Clear;
  qry.SQL.Add('INSERT INTO ''' + g_options.DB_MonthPath + 'Fish.Db''');
  qry.SQL.Add('SELECT * FROM Fish WHERE Fish_Date <= ''' + t + '''');
  qry.ExecSQL;
  qry.SQL.Clear;
  qry.SQL.Add('DELETE FROM Fish');
  qry.SQL.Add('WHERE Fish_Date <= ''' + t + '''');
  qry.ExecSQL;

  {qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM FishFood');
  qry.SQL.Add('WHERE FF_Date <= ''' + t + '''');
  qry.Open;
  if qry.RecordCount > 0 then
  begin
//    tbl.DatabaseName := g_options.DB_MonthPath;
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
  qry.Close;}

  qry.SQL.Clear;
  qry.SQL.Add('INSERT INTO ''' + g_options.DB_MonthPath + 'FishFood.Db''');
  qry.SQL.Add('SELECT * FROM FishFood WHERE FF_Date <= ''' + t + '''');
  qry.ExecSQL;

  qry.SQL.Clear;
  qry.SQL.Add('DELETE FROM FishFood');
  qry.SQL.Add('WHERE FF_Date <= ''' + t + '''');
  qry.ExecSQL;

  qry.Free;
  tbl.Free;
  Mouse_NoWait;
  MSG_NoWait;

  g_options.ArchiveDate := cmbMonth.ItemIndex;
  pnlArchive.Caption := ('Å«Ì«‰ „«Â ') + cmbMonth.Items.Strings[g_options.ArchiveDate];
  SaveIniFile;
end;

end.
