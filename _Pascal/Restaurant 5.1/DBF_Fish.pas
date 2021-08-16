unit DBF_Fish;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Grids, XStringGrid,adodb;

type
  TfrmPrsCost = class(TForm)
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    lbl4: TLabel;
    txtFileName: TEdit;
    lbl5: TLabel;
    cmbFonts: TComboBox;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    lbl3: TLabel;
    prgBar: TProgressBar;
    grdFields: TXStringGrid;
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure grdFieldsDblClick(Sender: TObject);
  private
    { Private declarations }
    FldNames : array[0..8] of String;

    procedure SendTab(var Key : Char);
    procedure InitialGrid;

    procedure SetWinF;
    procedure SaveSelectedFields;
    procedure LoadSelectedFields;
    procedure CreateDBFFile;
    function  GetPersonPrc(prcCode, sdate, edate : String; fdType : Byte) : Integer;

  public
    { Public declarations }
  end;

implementation

uses
  DB, dbTables, MSGs, Keyboard, DateProc, Globals,
  Code_Sys, DBS_Proc;


{$R *.DFM}

procedure TfrmPrsCost.SetWinF;
var i : byte;
begin
  Caption := (Caption);
  lbl1.Caption := ( lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  grdFields.Hint := (grdFields.Hint);
  cmdRun.Caption := (cmdRun.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  for i := 0 to cmbFonts.Items.Count - 1 do
    cmbFonts.Items.Strings[i] := (cmbFonts.Items.Strings[i]);
end;

procedure TfrmPrsCost.SaveSelectedFields;
var
  f : TextFile;
  s : String;
  i : Byte;
begin
  s := '';
  for i := 1 to grdFields.RowCount-1 do
    if grdFields.Cells[0, i] <> 'X' then
      s := s + '0'
    else
      s := s + '1';
  AssignFile(f, g_Options.ProgramPath+'SelField.Dta');
  Rewrite(f);
  Write(f, s);
  CloseFile(f);
end;

procedure TfrmPrsCost.LoadSelectedFields;
var
  f : TextFile;
  s : String;
  i : Byte;
begin
  if FileExists(g_Options.ProgramPath+'SelField.Dta') then
  begin
    AssignFile(f, g_Options.ProgramPath+'SelField.Dta');
    Reset(f);
    Read(f, s);
    CloseFile(f);
  end;

  if s <> '' then
    for i := 1 to Length(s) do
      if (i < grdFields.RowCount) and (s[i] = '1') then
        grdFields.Cells[0, i] := 'X';
end;

procedure TfrmPrsCost.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;


procedure TfrmPrsCost.InitialGrid;
begin
  grdFields.ColCount := 3;
  grdFields.Cells[0, 0] := ('ÇäÊÎÇÈ');
  grdFields.ColWidths[0] := 45;

  grdFields.Cells[1, 0] := ('äÇã ÝíáÏ');
  grdFields.ColWidths[1] := 110;

  grdFields.ColWidths[2] := 100;
  grdFields.Cells[2, 0] := ('ÝíáÏ ÈÇäß ÇØáÇÚÇÊí');


  grdFields.RowCount := 10;
  grdFields.Cells[1, 1] := ('ÔãÇÑå ÑÓäáí');
  grdFields.Cells[2, 1] := (FldNames[0]);

  grdFields.Cells[1, 2] := ('ÔãÇÑå ßÇÑÊ');
  grdFields.Cells[2, 2] := (FldNames[1]);

  grdFields.Cells[1, 3] := ('äÇã');
  grdFields.Cells[2, 3] := (FldNames[2]);

  grdFields.Cells[1, 4] := ('äÇã ÎÇäæÇÏí');
  grdFields.Cells[2, 4] := (FldNames[3]);

  grdFields.Cells[1, 5] := ('åÒíäå ÛÐÇ');
  grdFields.Cells[2, 5] := (FldNames[4]);

  grdFields.Cells[1, 6] := ('åÒíäå ãÎáÝÇÊ');
  grdFields.Cells[2, 6] := (FldNames[5]);

  grdFields.Cells[1, 7] := ('ßá ãÈáÛ åÒíäå ÔÏå');
  grdFields.Cells[2, 7] := (FldNames[6]);

  grdFields.Cells[1, 8] := ('ÇÒ ÊÇÑíÎ');
  grdFields.Cells[2, 8] := (FldNames[7]);

  grdFields.Cells[1, 9] := ('ÊÇ ÊÇÑíÎ');
  grdFields.Cells[2, 9] := (FldNames[8]);
end;

procedure TfrmPrsCost.CreateDBFFile;
var
  qry : TadoQuery;
  tbl : TTable;
  F_Path, F_Name : String;
  Ghaza : integer;
begin
  Mouse_Wait;
  MSG_Wait('ÏÑ ÍÇá ÇíÌÇÏ ÎÑæÌí ÈÕæÑÊ ÈÇäß ÇØáÇÚÇÊí...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Price * FF_No) AS Prc, P_Name, P_Family, P_Proxi FROM Fish, FishFood, Persons');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  qry.SQL.Add('AND Fish_PCode = P_BarCode');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('GROUP BY Fish_PCode, P_Name, P_Family, P_Proxi');
  qry.Open;
  if qry.RecordCount > 0 then
  begin
    F_Path := ExtractFilePath(txtFileName.Text);
    F_Name := ExtractFileName(txtFileName.Text);
    tbl := TTable.Create(Application);
    if F_Path <> '' then
//      tbl.DatabaseName := F_Path
    else
//      tbl.DatabaseName := g_options.DataBasePath;
    tbl.TableName := F_Name;
    tbl.TableType := ttFoxPro;
    tbl.Active := False;
    tbl.FieldDefs.Clear;
    if grdFields.Cells[0, 1] = 'X' then tbl.FieldDefs.Add(FldNames[0], ftString, 8, False);
    if grdFields.Cells[0, 2] = 'X' then tbl.FieldDefs.Add(FldNames[1], ftString, 15, False);
    if grdFields.Cells[0, 3] = 'X' then tbl.FieldDefs.Add(FldNames[2], ftString, 15, False);
    if grdFields.Cells[0, 4] = 'X' then tbl.FieldDefs.Add(FldNames[3], ftString, 20, False);
    if grdFields.Cells[0, 5] = 'X' then tbl.FieldDefs.Add(FldNames[4], ftWord, 0, False);
    if grdFields.Cells[0, 6] = 'X' then tbl.FieldDefs.Add(FldNames[5], ftWord, 0, False);
    if grdFields.Cells[0, 7] = 'X' then tbl.FieldDefs.Add(FldNames[6], ftWord, 0, False);
    if grdFields.Cells[0, 8] = 'X' then tbl.FieldDefs.Add(FldNames[7], ftString, 8, False);
    if grdFields.Cells[0, 9] = 'X' then tbl.FieldDefs.Add(FldNames[8], ftString, 8, False);
    tbl.CreateTable;

    tbl.Open;
    prgBar.Max := qry.RecordCount;
    while not qry.Eof do
    begin
      prgBar.Position := prgBar.Position + 1;
      tbl.Append;
      if grdFields.Cells[0, 1] = 'X' then
        tbl.FieldByName(FldNames[0]).AsString := qry.FieldByName('Fish_PCode').AsString;

      if grdFields.Cells[0, 2] = 'X' then
        tbl.FieldByName(FldNames[1]).AsString := qry.FieldByName('P_Proxi').AsString;

      if cmbFonts.ItemIndex >= 2 then
      begin
        if grdFields.Cells[0, 3] = 'X' then
          tbl.FieldByName(FldNames[2]).AsString := StrRev(ChangeFromWin(qry.FieldByName('P_Name').AsString, g_options.WinType, cmbFonts.ItemIndex+1));
        if grdFields.Cells[0, 4] = 'X' then
          tbl.FieldByName(FldNames[3]).AsString := StrRev(ChangeFromWin(qry.FieldByName('P_Family').AsString, g_options.WinType, cmbFonts.ItemIndex+1));
      end
      else
      begin
        if grdFields.Cells[0, 3] = 'X' then
          tbl.FieldByName(FldNames[2]).AsString := ChangeFromWin(qry.FieldByName('P_Name').AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        if grdFields.Cells[0, 4] = 'X' then
          tbl.FieldByName(FldNames[3]).AsString := ChangeFromWin(qry.FieldByName('P_Family').AsString, g_options.WinType, cmbFonts.ItemIndex+1);
      end;

      Ghaza := GetPersonPrc(qry.FieldByName('Fish_PCode').AsString, txtFromDate.Text, txtToDate.Text, MB_GHAZA);
      if grdFields.Cells[0, 5] = 'X' then
        tbl.FieldByName(FldNames[4]).AsInteger :=  Ghaza;
      if grdFields.Cells[0, 6] = 'X' then
        tbl.FieldByName(FldNames[5]).AsInteger :=  qry.FieldByName('Prc').AsInteger - Ghaza;//GetPersonPrc(qry.FieldByName('Fish_PCode').AsString, txtFromDate.Text, txtToDate.Text, MB_MOKHALAFAT);

      if grdFields.Cells[0, 7] = 'X' then
        tbl.FieldByName(FldNames[6]).AsInteger := qry.FieldByName('Prc').AsInteger;

      if grdFields.Cells[0, 8] = 'X' then
        tbl.FieldByName(FldNames[7]).AsString := Copy(txtFromDate.Text, 3, 8);
      if grdFields.Cells[0, 9] = 'X' then
        tbl.FieldByName(FldNames[8]).AsString := Copy(txtToDate.Text, 3, 8);
      tbl.Post;

      qry.Next;
    end;
    tbl.Close;
    tbl.Free;
  end;

  qry.Close;
  qry.Free;
  Mouse_NoWait;
  Msg_NoWait;

end;

function TfrmPrsCost.GetPersonPrc(prcCode, sdate, edate : String; fdType : Byte) : Integer;
begin
  with TadoQuery.Create(Application) do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT SUM(FF_Price * FF_No) AS Prc FROM Fish, FishFood, FoodList');
    SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
    SQL.Add('AND FF_Food = Food_Code');
    SQL.Add('AND Food_Type = ' + IntToStr(fdType));
    if sdate <> '' then
      SQL.Add('AND Fish_Date >= ''' + sdate + '''');
    if edate <> '' then
      SQL.Add('AND Fish_Date <= ''' +  edate + '''');
    SQL.Add('AND Fish_PCode = ''' + FixLeft(prcCode, '0', 8) + '''');
    Open;
    Result := FieldByName('prc').AsInteger;
    Close;
  end;
end;



procedure TfrmPrsCost.FormCreate(Sender: TObject);
begin
  SetWinF;
  FldNames[0] := 'P_CODE';
  FldNames[1] := 'ID_CODE';
  FldNames[2] := 'NAME';
  FldNames[3] := 'FAMILY';
  FldNames[4] := 'Food';
  FldNames[5] := 'Deser';
  FldNames[6] := 'COST';
  FldNames[7] := 'F_DATE';
  FldNames[8] := 'T_DATE';
  InitialGrid;
  cmbFonts.ItemIndex := 0;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
  LoadSelectedFields;
end;

procedure TfrmPrsCost.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmPrsCost.txtFromDateExit(Sender: TObject);
begin
  with txtFromDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptFDate := Text;
  end;
end;

procedure TfrmPrsCost.txtToDateExit(Sender: TObject);
begin
  with txtToDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptTDate := Text;
  end;
end;

procedure TfrmPrsCost.cmdRunClick(Sender: TObject);
var
  i : Byte;
  isSelFld : Boolean;
begin
  if txtFileName.Text = '' then
  begin
    ErrorMessage('äÇã ÝÇíá ãÔÎÕ äÔÏå ÇÓÊ.');
    txtFileName.SetFocus;
  end
  else if cmbFonts.Text = '' then
  begin
    ErrorMessage('ÓíÓÊã ÝæäÊ ãÔÎÕ äÔÏå ÇÓÊ.');
    cmbFonts.SetFocus;
  end
  else
  begin
    isSelFld := False;
    for i := 1 to grdFields.RowCount-1 do
      if grdFields.Cells[0, i] = 'X' then
        isSelFld := True;

    if not isSelFld then
    begin
      ErrorMessage('åí ÝíáÏí ÇäÊÎÇÈ äÔÏå ÇÓÊ.');
      grdFields.SetFocus;
    end
    else
    begin
      prgBar.Position := 0;
      SaveSelectedFields;
      CreateDBFFile;
    end;
  end;
end;

procedure TfrmPrsCost.grdFieldsDblClick(Sender: TObject);
begin
  if grdFields.Row > 0 then
    if grdFields.Cells[0, grdFields.Row] = 'X' then
      grdFields.Cells[0, grdFields.Row] := ''
    else
      grdFields.Cells[0, grdFields.Row] := 'X';
end;

end.
