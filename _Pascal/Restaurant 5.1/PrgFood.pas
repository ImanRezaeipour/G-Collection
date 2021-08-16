unit PrgFood;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, ExtCtrls, Db, Globals, DateProc, FarsiApi,
  DayProg, DBS_Proc;

type
  TfrmProgFood = class(TForm)
    txtDate1: TEdit;
    txtDate2: TEdit;
    txtDate3: TEdit;
    txtDate4: TEdit;
    txtDate5: TEdit;
    txtDate6: TEdit;
    txtDate7: TEdit;
    lblDate1: TLabel;
    lblDate2: TLabel;
    lblDate3: TLabel;
    lblDate4: TLabel;
    lblDate5: TLabel;
    lblDate6: TLabel;
    lblDate7: TLabel;
    Label8: TLabel;
    lblNahar: TLabel;
    lblSham: TLabel;
    cmdNext: TBitBtn;
    cmdPrior: TBitBtn;
    cmdProgram: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    lstSobh1: TListBox;
    lstNahar1: TListBox;
    lstSham1: TListBox;
    lstSobh2: TListBox;
    lstNahar2: TListBox;
    lstSham2: TListBox;
    lstSobh3: TListBox;
    lstNahar3: TListBox;
    lstSham3: TListBox;
    lstSobh4: TListBox;
    lstNahar4: TListBox;
    lstSham4: TListBox;
    lstSobh5: TListBox;
    lstNahar5: TListBox;
    lstSham5: TListBox;
    lstSobh6: TListBox;
    lstNahar6: TListBox;
    lstSham6: TListBox;
    lstSobh7: TListBox;
    lstNahar7: TListBox;
    lstSham7: TListBox;
    lblSobh: TLabel;
    qryWeek: TAdoQuery;
    cmdOldProg: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdNextClick(Sender: TObject);
    procedure cmdPriorClick(Sender: TObject);
    procedure cmdProgramClick(Sender: TObject);
    procedure txtDate1Enter(Sender: TObject);
    procedure lstSobh1Enter(Sender: TObject);
    procedure cmdOldProgClick(Sender: TObject);
    procedure lstSobh1DblClick(Sender: TObject);
  private
    { Private declarations }
    Dates : array [1..7] of TEdit;
    lblDates : array [1..7] of TLabel;
    Foods : array [1..21] of TListBox;
    TableDate : String;
    Row, Col : Byte;

    procedure InitialTables;
    procedure LableActive(clr : TColor);
    procedure FillDateCol(DT : String);
    procedure FillFoods;
    function  GetRow : Byte;
    function  GetActiveList : Byte;
    function  GetCol : Byte;
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmProgFood.SetWinF;
begin
  Caption := (Caption);
  lblDate1.Caption := (lblDate1.Caption);
  lblDate2.Caption := (lblDate2.Caption);
  lblDate3.Caption := (lblDate3.Caption);
  lblDate4.Caption := (lblDate4.Caption);
  lblDate5.Caption := (lblDate5.Caption);
  lblDate6.Caption := (lblDate6.Caption);
  lblDate7.Caption := (lblDate7.Caption);
  Label8.Caption := (Label8.Caption);
  lblSobh.Caption := (lblSobh.Caption);
  lblNahar.Caption := (lblNahar.Caption);
  lblSham.Caption := (lblSham.Caption);
  cmdNext.Caption := (cmdNext.Caption);
  cmdPrior.Caption := (cmdPrior.Caption);
  cmdProgram.Caption := (cmdProgram.Caption);
  cmdOldProg.Caption := (cmdOldProg.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmProgFood.InitialTables;
var i : Byte;
begin
  Dates[1] := txtDate1;
  Dates[2] := txtDate2;
  Dates[3] := txtDate3;
  Dates[4] := txtDate4;
  Dates[5] := txtDate5;
  Dates[6] := txtDate6;
  Dates[7] := txtDate7;

  lblDates[1] := lblDate1;
  lblDates[2] := lblDate2;
  lblDates[3] := lblDate3;
  lblDates[4] := lblDate4;
  lblDates[5] := lblDate5;
  lblDates[6] := lblDate6;
  lblDates[7] := lblDate7;

  Foods[1] := lstSobh1;
  Foods[2] := lstSobh2;
  Foods[3] := lstSobh3;
  Foods[4] := lstSobh4;
  Foods[5] := lstSobh5;
  Foods[6] := lstSobh6;
  Foods[7] := lstSobh7;

  Foods[8] := lstNahar1;
  Foods[9] := lstNahar2;
  Foods[10] := lstNahar3;
  Foods[11] := lstNahar4;
  Foods[12] := lstNahar5;
  Foods[13] := lstNahar6;
  Foods[14] := lstNahar7;

  Foods[15] := lstSham1;
  Foods[16] := lstSham2;
  Foods[17] := lstSham3;
  Foods[18] := lstSham4;
  Foods[19] := lstSham5;
  Foods[20] := lstSham6;
  Foods[21] := lstSham7;

  if F_Params.Vadeh[MB_SOBH] = MB_FALSE then
  begin
    lblSobh.Caption := ('ÕÈÍÇäå ÓÑæ äãíÔæÏ');
    for i := 1 to 7 do
      Foods[i].Enabled := False;
  end;

  if F_Params.Vadeh[MB_NAHAR] = MB_FALSE then
  begin
    lblNahar.Caption := ('äÇåÇÑ ÓÑæ äãíÔæÏ');
    for i := 8 to 14 do
      Foods[i].Enabled := False;
  end;

  if F_Params.Vadeh[MB_SHAM] = MB_FALSE then
  begin
    lblSham.Caption := ('ÔÇã ÓÑæ äãíÔæÏ');
    for i := 15 to 21 do
      Foods[i].Enabled := False;
  end;
end;

procedure TfrmProgFood.LableActive(clr : TColor);
begin
  lblDates[Row].Font.Color := clr;
  case Col of
    MB_SOBH  : lblSobh.Font.Color := clr;
    MB_NAHAR : lblNahar.Font.Color := clr;
    MB_SHAM  : lblSham.Font.Color := clr;
  end;
end;

procedure TfrmProgFood.FillDateCol(DT : String);
var i : Byte;
begin
  for i := 1 to 7 do
    Dates[i].Text := AddDate(DT, i-1);
end;

procedure TfrmProgFood.FillFoods;
var
  r, i : Byte;
begin
  Mouse_Wait;
  with qryWeek do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Week WHERE Week_Date >= ''' + Dates[1].Text + '''');
    SQL.Add('AND Week_Date <= ''' + Dates[7].Text + '''');
    Open;
    for r := 1 to 7 do
    begin
      Foods[r].Clear;
      Foods[r+7].Clear;
      Foods[r+14].Clear;

      Filtered := False;
      Filter := 'Week_Date = ''' + Dates[r].Text + '''';
      Filtered := True;
      if RecordCount > 0 then
      begin
        while not EOF do
        begin
          i := ((FieldByName('Week_Type').AsInteger - 1) * 7) + r;
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key1').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key2').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key3').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key4').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key5').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key6').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key7').AsInteger));
          Foods[i].Items.Add(GetFoodNameInRam(FieldByName('Week_Key8').AsInteger));
          Next;
        end;
      end;
    end;
    Close;
  end;
  Mouse_NoWait;
end;

function TfrmProgFood.GetRow : Byte;
var i : Byte;
begin
  for i := 1 to 7 do
    if Dates[i].Focused then
      Break;
  if i > 7  then
    i := 1;
  GetRow := i;
end;

function TfrmProgFood.GetCol : Byte;
var c : Byte;
begin
  c := GetActiveList;
  if c in [1..7] then
    c := MB_SOBH
  else if c in [8..14] then
    c := MB_NAHAR
  else
    c := MB_SHAM;
  GetCol := c;
end;

function TfrmProgFood.GetActiveList : Byte;
var i : Byte;
begin
  for i := 1 to 21 do
    if Foods[i].Focused then
      Break;
  if i > 21 then
    Dec(i);
  GetActiveList := i;
end;

procedure TfrmProgFood.FormCreate(Sender: TObject);
var d : Integer;
begin
  SetWinF;
  qryWeek.connection := frmDBS.DBConnection;
  InitialTables;
  Row := 1;
  Col := MB_NAHAR;
  LableActive(clRed);

  TableDate := CurrentDate;
  d := DayOfWeek(M_Date(TableDate));
  if d = 7 then
    d := 0
  else
    d := -1 * d;

  TableDate := AddDate(TableDate, d);
  FillDateCol(TableDate);
  FillFoods;
end;

procedure TfrmProgFood.txtDate1Enter(Sender: TObject);
begin
  LableActive(clBlack);
  Row := GetRow;
  LableActive(clRed);
end;

procedure TfrmProgFood.lstSobh1Enter(Sender: TObject);
var c : Byte;
begin
  LableActive(clBlack);
  c := GetActiveList;
  Col := GetCol;
  Row := c mod 7;
  if Row = 0 then
    Row := 7;
  LableActive(clRed);
end;

procedure TfrmProgFood.cmdNextClick(Sender: TObject);
begin
  TableDate := AddDate(TableDate, 7);
  FillDateCol(TableDate);
  FillFoods;
end;

procedure TfrmProgFood.cmdPriorClick(Sender: TObject);
begin
  TableDate := AddDate(TableDate, -7);
  FillDateCol(TableDate);
  FillFoods;
end;

procedure TfrmProgFood.cmdProgramClick(Sender: TObject);
var frmSobhInf: TfrmSobhInf;
begin
  Application.CreateForm(TfrmSobhInf, frmSobhInf);
  frmSobhInf.lblDate.Caption := Dates[Row].Text;
  frmSobhInf.FoodType := Col;
  frmSobhInf.ShowModal;
  frmSobhInf.Free;
  FillFoods;
end;

procedure TfrmProgFood.cmdOldProgClick(Sender: TObject);
var
  SDate : String;
  tbl : TAdoTable;
  qry : TAdoQuery;
begin
  Mouse_Wait;
  SDate := AddDate(TableDate, -7);
  tbl := TAdoTable.Create(Application);
  qry := TAdoQuery.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  tbl.TableName := 'Week';

  qry.SQL.Clear;
  qry.SQL.Add('DELETE FROM Week WHERE Week_Date >= ''' + TableDate + '''');
  qry.SQL.Add('AND Week_Date <= ''' + AddDate(TableDate, 6) + '''');
  qry.ExecSQL;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Week WHERE Week_Date >= ''' + SDate + '''');
  qry.SQL.Add('AND Week_Date < ''' + TableDate + '''');
  tbl.Open;
  qry.Open;
  while not qry.EOF do
  begin
    tbl.Append;
    tbl.FieldByName('Week_Date').AsString := AddDate(qry.FieldByName('Week_Date').AsString, 7);
    tbl.FieldByName('Week_Type').AsInteger := qry.FieldByName('Week_Type').AsInteger;
    tbl.FieldByName('Week_Key1').AsInteger := qry.FieldByName('Week_Key1').AsInteger;
    tbl.FieldByName('Week_N1').AsInteger := qry.FieldByName('Week_N1').AsInteger;
    tbl.FieldByName('Week_Key2').AsInteger := qry.FieldByName('Week_Key2').AsInteger;
    tbl.FieldByName('Week_N2').AsInteger := qry.FieldByName('Week_N2').AsInteger;
    tbl.FieldByName('Week_Key3').AsInteger := qry.FieldByName('Week_Key3').AsInteger;
    tbl.FieldByName('Week_N3').AsInteger := qry.FieldByName('Week_N3').AsInteger;
    tbl.FieldByName('Week_Key4').AsInteger := qry.FieldByName('Week_Key4').AsInteger;
    tbl.FieldByName('Week_N4').AsInteger := qry.FieldByName('Week_N4').AsInteger;
    tbl.FieldByName('Week_Key5').AsInteger := qry.FieldByName('Week_Key5').AsInteger;
    tbl.FieldByName('Week_N5').AsInteger := qry.FieldByName('Week_N5').AsInteger;
    tbl.FieldByName('Week_Key6').AsInteger := qry.FieldByName('Week_Key6').AsInteger;
    tbl.FieldByName('Week_N6').AsInteger := qry.FieldByName('Week_N6').AsInteger;
    tbl.FieldByName('Week_Key7').AsInteger := qry.FieldByName('Week_Key7').AsInteger;
    tbl.FieldByName('Week_N7').AsInteger := qry.FieldByName('Week_N7').AsInteger;
    tbl.FieldByName('Week_Key8').AsInteger := qry.FieldByName('Week_Key8').AsInteger;
    tbl.FieldByName('Week_N8').AsInteger := qry.FieldByName('Week_N8').AsInteger;
    tbl.FieldByName('Week_Key9').AsInteger := qry.FieldByName('Week_Key9').AsInteger;
    tbl.FieldByName('Week_Key0').AsInteger := qry.FieldByName('Week_Key0').AsInteger;
    tbl.Post;
    qry.Next;
  end;
  tbl.Close;
  qry.Close;
  tbl.Free;
  qry.Free;
  FillFoods;
  Mouse_NoWait;
end;



procedure TfrmProgFood.lstSobh1DblClick(Sender: TObject);
begin
  cmdProgramClick(Sender);
end;

end.
