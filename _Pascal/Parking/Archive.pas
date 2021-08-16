unit Archive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, DateProc, MSGs, IOTools;

type
  TfrmArchive = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cmbMonth: TComboBox;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    cmdHelp: TBitBtn;
    lblArchive: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmbMonthKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    yy, mm : Byte;

    procedure SetMessage;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses DBS;

{$R *.DFM}

procedure TfrmArchive.SetWinF;
var
  i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  lblArchive.Caption := (lblArchive.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  for i := 0 to cmbMonth.Items.Count - 1 do
    cmbMonth.Items.Strings[i] := (cmbMonth.Items.Strings[i]);
end;

procedure TfrmArchive.SetMessage;
begin
  if g_options.ArchiveDate <> 0 then
    lblArchive.Caption := ('.ŒÊœ—ÊÂ«  « ' )+
                          cmbMonth.Items.Strings[g_options.Archivedate-1] +
                          (' „«Â »«Ìê«‰Ì ‘œÂù«‰œ')
  else
    lblArchive.Caption := ('.ÂÌç ŒÊœ—ÊÌÌ »«Ìê«‰Ì ‰‘œÂ «” ');
end;


procedure TfrmArchive.FormActivate(Sender: TObject);
begin
  yy := StrToInt(Copy(CurrentDate, 3, 2));
  mm := StrToInt(Copy(CurrentDate, 6, 2));
  if mm = 1 then
    cmbMonth.ItemIndex := 11
  else
    cmbMonth.ItemIndex := mm - 2;
  SetMessage;
end;

procedure TfrmArchive.cmbMonthKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end;
end;

procedure TfrmArchive.cmdOKClick(Sender: TObject);
var
  OK : Boolean;
  qry : TAdoQuery;
  DT : String;
  d : Byte;
begin
  Mouse_Wait;
  lblArchive.Caption := ('...œ— Õ«· »«Ìê«‰Ì «ÿ·«⁄« . ·ÿ›« ﬂ„Ì  «„· ‰„«ÌÌœ');
  OK := True;
  {$I-}
  ChDir(g_options.DB_MonthPath);
  if IOResult <> 0 then
  begin
    MkDir(g_options.DB_MonthPath);
    if IOResult <> 0 then
    begin
      ErrorMessage('«ÌÃ«œ ‘«ŒÂ ÃÂ  »«Ìê«‰Ì „Ì”— ‰Ì” .');
      OK := False;
    end;
  end
  else
    ChDir(g_options.ProgramPath);
  {$I+}

  if OK then
  begin
    if cmbMonth.ItemIndex+1 > mm then
      DT := IntToStr(yy-1) + '/' + IntToStr(cmbMonth.ItemIndex+1) + '/'
    else if cmbMonth.ItemIndex+1 = mm then
    begin
      DT := CurrentDate;
      d := StrToInt(Copy(DT, 9, 2));
      if d > 1 then
      begin
        Delete(DT, 9, 2);
        DT := DT + IntToStr(d-1);
      end
      else
        DT := IntToStr(yy) + '/' + IntToStr(cmbMonth.ItemIndex) + '/';
    end
    else
      DT := IntToStr(yy) + '/' + IntToStr(cmbMonth.ItemIndex+1) + '/';

    if cmbMonth.ItemIndex+1 <> mm then
    begin
      if cmbMonth.ItemIndex+1 in [1..6] then
        DT := DT + '31'
      else if cmbMonth.ItemIndex+1 in [7..11] then
        DT := DT + '30'
      else
        DT := DT + '29';
    end;

    DT := BeautifulDate(DT);

    qry := TAdoQuery.Create(Application);
    if not FileExists(g_options.DB_MonthPath + 'Machines.Db') then
    begin
      FileCopy(g_options.DataBasePath + 'Machines.Db', g_options.DB_MonthPath + 'Machines.Db');
      qry.connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ''' + g_options.DB_MonthPath + 'Machines.Db''');
      qry.ExecSQL;
    end;

    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO ''' + g_options.DB_MonthPath + 'Machines.Db''');
    qry.SQL.Add('SELECT * FROM Machines.Db WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
    qry.SQL.Add('AND (M_IDate <= ''' + DT + ''' OR M_ODate <= ''' + DT + ''')');
    qry.SQL.Add('AND M_Kind < ' + IntToStr(MB_CUSTOMS));
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
    qry.SQL.Add('AND (M_IDate <= ''' + DT + ''' OR M_ODate <= ''' + DT + ''')');
    qry.SQL.Add('AND M_Kind < ' + IntToStr(MB_CUSTOMS));
    qry.ExecSQL;

      if not FileExists(g_options.DB_MonthPath + 'InOutCo.Db') then
      begin
        FileCopy(g_options.DataBasePath + 'InOutCo.Db', g_options.DB_MonthPath + 'InOutCo.Db');
        qry.connection := frmDBS.adoConnect;
        qry.SQL.Clear;
        qry.SQL.Add('DELETE FROM ''' + g_options.DB_MonthPath + 'InOutCo.Db''');
        qry.ExecSQL;
      end;

      qry.connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO ''' + g_options.DB_MonthPath + 'InOutCo.Db''');
      qry.SQL.Add('SELECT * FROM InOutCo.Db WHERE IO_IsPark = ' + IntToStr(CNST_TRUE));
      qry.SQL.Add('AND (IO_IDate <= ''' + DT + ''' OR IO_ODate <= ''' + DT + ''')');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM InOutCo WHERE IO_IsPark = ' + IntToStr(CNST_TRUE));
      qry.SQL.Add('AND (IO_IDate <= ''' + DT + ''' OR IO_ODate <= ''' + DT + ''')');
      qry.ExecSQL;

      LoadExit_Park;

    qry.Free;
  end;

  g_options.ArchiveDate := cmbMonth.ItemIndex+1;
  SaveIniFile;
  SetMessage;
  Mouse_NoWait;
end;



procedure TfrmArchive.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
