unit Restore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, DosMove, DB, ADODB, ComCtrls, DBTables, xmldom,
  Xmlxform, Wwtable;


type
  TfrmRestore = class(TForm)
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
    chkDelData: TCheckBox;
    qryData: TQuery;
    BatchMove1: TBatchMove;
    wwTable1: TwwTable;
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
    function RestoreData(tblName : String) : boolean;

  public
    { Public declarations }
    tblIndex : integer;
  end;


implementation

uses
  Globals, MSGs, Funcs, MakeDB, SelPath, DateProc, Keyboard, DBS_Proc;

{$R *.DFM}

procedure TfrmRestore.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  for i := 0 to chklstDBS.Items.Count-1 do
    chklstDBS.Items.Strings[i] := (chklstDBS.Items.Strings[i]);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  chkDelData.Caption := (chkDelData.Caption);
  cmdAll.Caption := (cmdAll.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmRestore.IsSelectedDBS : Boolean;
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

{$REGION 'old RestoreData(tblName : String)'}
{
  procedure TfrmRestore.RestoreData(tblName : String);
  var
    i : Byte;
    tblTemp, fldName : String;
  begin
    prgBar.Position := 0;

    if not chkDelData.Checked then
    begin
      try
        tblTemp := 'TempRestore';
        if tblExists(tblTemp) then
        begin
          if aqryData.Active then aqryData.Close;
          aqryData.SQL.Clear;
          aqryData.SQL.Add('Drop table ' + tblTemp);
          aqryData.ExecSQL;
        end;
        aqryData.SQL.Clear;
        aqryData.SQL.Add('exec sp_rename ' + tblName + ', ' + tblTemp);
        aqryData.ExecSQL;
        CreateTbl(tblName);
      except
        InformationMessage('⁄„·Ì«  ‰«„Ê›ﬁ »Êœ .');
        exit;
      end;
    end
    else
      tblTemp := tblName;

    if aqryData.Active then aqryData.Close;
    aqryData.SQL.Clear;
    aqryData.SQL.Add('delete from ' + tblName);
    aqryData.ExecSQL;

    try
      if qryData.Active then qryData.Close;
      if aqryData.Active then aqryData.Close;

      qryData.SQL.Clear;
      qryData.SQL.Add('SELECT * FROM ' + tblName);
      if tblName = 'fish' then
        qryData.SQL.Add('WHERE fish_Date >= ''' + txtFDate.Text + ''' AND fish_Date <= ''' + txtTDate.Text + '''')
      else if tblName = 'fishfood' then
        qryData.SQL.Add('WHERE ff_Date >= ''' + txtFDate.Text + ''' AND ff_Date <= ''' + txtTDate.Text + '''')
      else if tblName = 'UserStat' then
        qryData.SQL.Add('WHERE User_Date >= ''' + txtFDate.Text + ''' AND User_Date <= ''' + txtTDate.Text + '''');
      qryData.Open;
  
      aqryData.SQL.Clear;
      aqryData.SQL.Add('SELECT * FROM ' + tblTemp);
      aqryData.Open;
  
      prgBar.Max := qryData.RecordCount;
      while not qryData.Eof do
      begin
        aqryData.Append;
        for i := 0 to qryData.FieldCount-1 do
        begin
          fldName := qryData.Fields[i].FieldName;
          aqryData.FieldByName(fldName).Value := qryData.FieldByName(fldName).Value;
        end;

        try
          aqryData.Post;
        except
          aqryData.Cancel;
        end;
  
        prgBar.Position := qryData.RecNo;
  //      Refresh;
        qryData.Next;
      end;
      qryData.Close;
      aqryData.Close;
  
      if tblName <> tblTemp then
      begin
        aqryData.SQL.Clear;
        aqryData.SQL.Add('INSERT INTO ' + tblName + ' SELECT DISTINCT * FROM ' + tblTemp);
        aqryData.ExecSQL;
        aqryData.SQL.Clear;
        aqryData.SQL.Add('DROP TABLE ' + tblTemp);
        aqryData.ExecSQL;
      end;
    except
    end;
  end;
}
{$ENDREGION}
function TfrmRestore.RestoreData(tblName : String) : boolean;
var
  i : Byte;
  fldName : String;
begin
  Result := false;
  prgBar.Position := 0;
  if chkDelData.Checked then
    if tblExists(tblName) then
    begin
      if aqryData.Active then aqryData.Close;
      aqryData.SQL.Clear;
      aqryData.SQL.Add('Delete from ' + tblName);
      aqryData.ExecSQL;
    end
    else
      CreateTbl(tblName);

  if qryData.Active then qryData.Close;
  if aqryData.Active then aqryData.Close;

  qryData.SQL.Clear;
  qryData.SQL.Add('SELECT * FROM ' + tblName);
  if tblName = 'fish' then
    qryData.SQL.Add('WHERE fish_Date >= ''' + txtFDate.Text + ''' AND fish_Date <= ''' + txtTDate.Text + '''')
  else if tblName = 'fishfood' then
    qryData.SQL.Add('WHERE ff_Date >= ''' + txtFDate.Text + ''' AND ff_Date <= ''' + txtTDate.Text + '''')
  else if tblName = 'dblfish' then
    qryData.SQL.Add('WHERE dbl_Date >= ''' + txtFDate.Text + ''' AND dbl_Date <= ''' + txtTDate.Text + '''')
  else if tblName = 'UserStat' then
    qryData.SQL.Add('WHERE User_Date >= ''' + txtFDate.Text + ''' AND User_Date <= ''' + txtTDate.Text + '''');

  try
    if not FileExists(txtPath.Text + '\' + tblName + '.DB') then
    begin
      InformationMessage('›«Ì·  “Ì— œ— „”Ì— Å‘ Ì»«‰ „ÊÃÊœ ‰„Ì»«‘œ .' + #13#10 + tblname + '.db');
      exit;
    end;
    qryData.Open;
    aqryData.SQL.Clear;
    aqryData.SQL.Add('SELECT * FROM ' + tblName);
    aqryData.Open;

    prgBar.Max := qryData.RecordCount;
    while not qryData.Eof do
    begin
      aqryData.Append;
      for i := 0 to qryData.FieldCount-1 do
      begin
        fldName := qryData.Fields[i].FieldName;
        if aqryData.FindField(fldName) <> nil  then
          aqryData.FieldByName(fldName).Value := qryData.FieldByName(fldName).Value
        else
        begin
  //        UpgradeTable(tblName);
  //        RestoreData(tblName);
  //        InformationMessage('ﬁ»· «“ »«“Ì«»Ì «ÿ·«⁄«  ÃœÊ· ' + chklstDBS.Items.Strings[tblIndex] + ' ¬‰—« »«“”«“Ì ‰„«ÌÌœ . ');
  //        exit;
        end;
      end;
      if UpperCase(tblName) = 'READERS' then
        aqryData.FieldByName('R_IsCom').AsBoolean := true;

      try
        aqryData.Post;
      except
        aqryData.Cancel;
      end;
      prgBar.Position := qryData.RecNo;
      qryData.Next;
    end;
    Result := true;
  except
    on e : exception do ErrorMessage(e.Message);
  end;
end;
procedure TfrmRestore.FormCreate(Sender: TObject);
begin
  SelectedAll := False;
  SetWinF;
  aqryData.Connection := frmDBS.DBConnection;
end;

procedure TfrmRestore.cmdAllClick(Sender: TObject);
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

procedure TfrmRestore.cmdOKClick(Sender: TObject);
var
  i : integer;
  tbl1, tbl2 : String;
  rslt : boolean;
begin
  if not IsSelectedDBS then
  begin
    ErrorMessage('ÂÌç »«‰ﬂÌ «‰ Œ«» ‰‘œÂ «” .');
    chklstDBS.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    ErrorMessage('„”Ì— Å‘ Ì»«‰ „‘Œ’ ‰‘œÂ «” .');
    txtPath.SetFocus;
  end
  else if (txtFDate.Text = '') and chklstDBS.Checked[1] then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ „‘Œ’ ‰‘œÂ «” .');
    txtFDate.SetFocus;
  end
  else if (txtTDate.Text = '') and chklstDBS.Checked[1]  then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ „‘Œ’ ‰‘œÂ «” .');
    txtTDate.SetFocus;
  end
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
  else if not DirectoryExists(txtPath.Text) then
  begin
    ErrorMessage('„”Ì— Å‘ Ì»«‰ ÊÃÊœ ‰œ«—œ.');
    txtPath.SetFocus;
  end
  else
  begin
    qryData.DatabaseName := txtPath.Text;

    for i := 0 to chklstDBS.Count-1 do
      if chklstDBS.Checked[i] then
      begin
        tblIndex := i;
        lblDBS.Caption := chklstDBS.Items.Strings[i];
        case i of
          0:
            rslt := RestoreData('building');
          1:
            begin
              chklstDBS.Checked[i] := RestoreData('fish');
              chklstDBS.Checked[i] := RestoreData('fishfood');
              chklstDBS.Checked[i] := RestoreData('dblfish');
            end;
          2:
            rslt := RestoreData('foodlist');
          3:
            rslt := RestoreData('foodpric');
          4:
          begin
            rslt := RestoreData('groups');
            rslt := RestoreData('outgroup');
          end;
          5:
            rslt:= RestoreData('jobtype');
          6:
            rslt:= RestoreData('parts');
          7:
            rslt:= RestoreData('Persons');
          8:
            rslt:= RestoreData('prgprs');
          9:
            rslt:= RestoreData('rdrkey');
          10:
            rslt:= RestoreData('readers');
          11:
            begin
              rslt:= RestoreData('Security');
              rslt:= RestoreData('userstat');
            end;
          12:
            rslt:= RestoreData('units');
          13:
            rslt:= RestoreData('week');
          14:
            rslt:= RestoreData('clckrecs');
        end;
        chklstDBS.Checked[i] := not rslt;
      end;
    InformationMessage('»«“Ì«»Ì «“ ›«Ì· Å‘ Ì»«‰ «‰Ã«„ ‘œ.')
  end;

end;

procedure TfrmRestore.btnPathClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelPath, frmSelPath);
  frmSelPath.dirList.Directory := g_Options.ProgramPath;
  if frmSelPath.ShowModal = mrOK then
    txtPath.Text := frmSelPath.dirList.Directory;
  frmSelPath.Free;
end;

procedure TfrmRestore.txtFDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmRestore.txtFDateExit(Sender: TObject);
begin
  with txtFDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmRestore.txtTDateExit(Sender: TObject);
begin
  with txtTDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

end.


