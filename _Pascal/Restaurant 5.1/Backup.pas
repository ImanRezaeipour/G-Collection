unit Backup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, DosMove, DB, ADODB, ComCtrls, DBTables;


type
  TfrmBackup = class(TForm)
    cmdAll: TBitBtn;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    chklstDBS: TCheckListBox;
    lbl1: TLabel;
    txtPath: TEdit;
    btnPath: TButton;
    lbl2: TLabel;
    txtFDate: TEdit;
    lbl3: TLabel;
    txtTDate: TEdit;
    aqryData: TADOQuery;
    DosMove1: TDosMove;
    prgBar: TProgressBar;
    lblDBS: TLabel;
    tblData: TTable;
    procedure FormCreate(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure txtFDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFDateExit(Sender: TObject);
    procedure txtTDateExit(Sender: TObject);
  private
    { Private declarations }
    SelectedAll : Boolean;

    procedure SetWinF;
    function  IsSelectedDBS : Boolean;
    procedure BackupData(tblName : String);

  public
    { Public declarations }
  end;


implementation

uses
  Globals, MSGs, Funcs, MakeDB, SelPath, DateProc, Keyboard, DBS_Proc;

{$R *.DFM}

procedure TfrmBackup.SetWinF;
begin
end;

function TfrmBackup.IsSelectedDBS : Boolean;
var i : Byte;
begin
  Result := False;
  for i := 0 to chklstDBS.Count-1 do
    if chklstDBS.Checked[i] then
    begin
      Result := True;
      Break;
    end;
end;

procedure TfrmBackup.BackupData(tblName : String);
var
  i : Byte;
  fldName : String;
  fdate,tdate: string;
begin
  if txtFDate.Text=''
  then fdate:='0000/00/00'
  else fdate:=txtFDate.Text;
  if txttDate.Text=''
  then tdate:='9999/99/99'
  else tdate:=txttDate.Text;
  prgBar.Position := 0;

  if CreatePDoxTbl(tblName, txtPath.Text) then
  begin
    try
      if tblData.Active then tblData.Close;
      if aqryData.Active then aqryData.Close;

      tblData.TableName := tblName;
      tblData.Open;

      aqryData.SQL.Clear;
      aqryData.SQL.Add('SELECT * FROM ' + tblName);
      if (tblName = 'fish') then
        aqryData.SQL.Add('WHERE Fish_Date >= ''' + FDate + ''' AND Fish_Date <= ''' + TDate + '''')
      else if (tblName = 'fishfood') then
        aqryData.SQL.Add('WHERE FF_Date >= ''' + FDate + ''' AND FF_Date <= ''' + TDate + '''')
      else if tblName = 'UserStat' then
        aqryData.SQL.Add('WHERE User_Date >= ''' + FDate + ''' AND User_Date <= ''' + TDate + '''');
      aqryData.Open;

      prgBar.Max := aqryData.RecordCount;
      while not aqryData.Eof do
      begin
        tblData.Append;
        for i := 0 to aqryData.FieldCount-1 do
        begin
          fldName := aqryData.Fields[i].FieldName;
          tblData.FieldByName(fldName).Value := aqryData.FieldByName(fldName).Value;
        end;
        tblData.Post;

        prgBar.Position := aqryData.RecNo;
//        Refresh;
        aqryData.Next;
      end;
      tblData.Close;
      aqryData.Close;
    except
    end;
  end;
end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
  SelectedAll := False;
  SetWinF;
  aqryData.Connection := frmDBS.DBConnection;
end;

procedure TfrmBackup.cmdAllClick(Sender: TObject);
var i : Byte;
begin
  if not SelectedAll then
    cmdAll.Caption := ('Â&Ìçﬂœ«„')
  else
    cmdAll.Caption := ('Â&„Â');

  SelectedAll := not SelectedAll;
  for i := 0 to chklstDBS.Items.Count-1 do
    chklstDBS.Checked[i] := SelectedAll;
end;

procedure TfrmBackup.cmdOKClick(Sender: TObject);
var
  i : Byte;
  tbl1, tbl2 : String;
begin
  if not IsSelectedDBS then
  begin
    ErrorMessage('ÂÌç »«‰ﬂÌ «‰ Œ«» ‰‘œÂ «” .');
    chklstDBS.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    ErrorMessage('„”Ì— Å‘ Ì»«‰ êÌ—Ì „‘Œ’ ‰‘œÂ «” .');
    txtPath.SetFocus;
  end
  {
  else if (txtFDate.Text = '') and chklstDBS.Checked[1]  then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ „‘Œ’ ‰‘œÂ «” .');
    txtFDate.SetFocus;
  end
  else if (txtTDate.Text = '') and chklstDBS.Checked[1] then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ „‘Œ’ ‰‘œÂ «” .');
    txtTDate.SetFocus;
  end
  }
  else if (txtFDate.Text <> '') and not IsTrueDate(txtFDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «‘ »«Â «” .');
    txtFDate.SetFocus;
  end
  else if (txtTDate.Text <> '') and not IsTrueDate(txtTDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ «‘ »«Â «” .');
    txtFDate.SetFocus;
  end
  else if txtFDate.Text > txtTDate.Text then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «“  «—ÌŒ Å«Ì«‰ »“—ê — «” .');
    txtFDate.SetFocus;
  end
  else
  begin
    if not DirectoryExists(txtPath.Text) then
      if ConfirmMessage('„”Ì— Å‘ Ì»«‰ ÊÃÊœ ‰œ«—œ. ¬Ì« »—«Ì «ÌÃ«œ ¬‰ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        if not CreateDir(txtPath.Text) then
        begin
          ErrorMessage('«ÌÃ«œ „”Ì— Å‘ Ì»«‰ „Ì”— ‰„Ìù»«‘œ.');
          Exit;
        end;
      end;

    tblData.DatabaseName := txtPath.Text;

    for i := 0 to chklstDBS.Count-1 do
      if chklstDBS.Checked[i] then
      begin
        lblDBS.Caption := chklstDBS.Items.Strings[i];
        case i of
          0:
            BackupData('building');
          1:
            begin
              BackupData('fish');
              BackupData('fishfood');
              BackupData('dblfish');
            end;
          2:
            BackupData('foodlist');
          3:
            BackupData('foodpric');
          4:
          begin
            BackupData('groups');
            BackupData('outgroup');
          end;
          5:
            BackupData('jobtype');
          6:
            BackupData('parts');
          7:
            BackupData('Persons');
          8:
            BackupData('prgprs');
          9:
            BackupData('rdrkey');
          10:
            BackupData('readers');
          11:
            begin
              BackupData('Security');
              BackupData('userstat');
            end;
          12:
            BackupData('units');
          13:
            BackupData('week');
          14:
            BackupData('clckrecs');
        end;
      end;
    InformationMessage('Å‘ Ì»«‰êÌ—Ì «‰Ã«„ ‘œ.')
  end;

end;

procedure TfrmBackup.btnPathClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelPath, frmSelPath);
  frmSelPath.dirList.Directory := g_Options.ProgramPath;
  if frmSelPath.ShowModal = mrOK then
    txtPath.Text := frmSelPath.dirList.Directory;
  frmSelPath.Free;
end;

procedure TfrmBackup.txtFDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmBackup.txtFDateExit(Sender: TObject);
begin
  with txtFDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmBackup.txtTDateExit(Sender: TObject);
begin
  with txtTDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

end.
