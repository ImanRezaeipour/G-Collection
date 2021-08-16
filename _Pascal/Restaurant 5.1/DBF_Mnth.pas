unit DBF_Mnth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Grids, XStringGrid, Spin;

type
  TfrmDBFMonth = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    txtFileName: TEdit;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    prgBar: TProgressBar;
    spnYear: TSpinEdit;
    cmbMonth: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
  private
    { Private declarations }

    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses
  DB,  AdoDB, dbTables, MSGs, Keyboard, DateProc, Globals,
  Code_Sys, DBS_Proc;


{$R *.DFM}

procedure TfrmDBFMonth.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := ( lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  cmdRun.Caption := (cmdRun.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;




procedure TfrmDBFMonth.FormCreate(Sender: TObject);
var
  i, m : Byte;
  y : Integer;
begin
  SetWinF;
  for i := 1 to 12 do
    cmbMonth.Items.Add(MonthName[i]);

  y := StrToInt(Copy(CurrentDate, 1, 4));
  m := StrToInt(Copy(CurrentDate, 6, 2));

  if m = 1 then
  begin
    m := 11;
    Dec(y);
  end
  else
    Dec(m, 2);

  cmbMonth.ItemIndex := m;
  spnYear.Text := IntToStr(y);
end;

procedure TfrmDBFMonth.cmdRunClick(Sender: TObject);
var
  sDate : String;
  tbl : TTable;
begin
  if txtFileName.Text = '' then
  begin
    ErrorMessage('äÇã ÝÇíá ãÔÎÕ äÔÏå ÇÓÊ.');
    txtFileName.SetFocus;
  end
  else
  begin
    Mouse_Wait;
    MSG_Wait('ÏÑ ÍÇá ÇíÌÇÏ ÎÑæÌí ÈÕæÑÊ ÈÇäß ÇØáÇÚÇÊí...');
    prgBar.Position := 0;
    sDate := spnYear.Text + '/' + IntToStr(cmbMonth.ItemIndex+1) + '/';
    with TAdoQuery.Create(Application) do
    begin
      connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('SELECT SUM(FF_Price * FF_No) AS Prc, Fish_PCode FROM Fish, FishFood');
      SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
      SQL.Add('AND Fish_Date >= ''' + BeautifulDate(sDate+'01') + '''');
      SQL.Add('AND Fish_Date <= ''' + BeautifulDate(sDate+'31') + '''');
      SQL.Add('GROUP BY Fish_PCode');
      SQL.Add('ORDER BY Fish_PCode');
      Open;
      prgBar.Max := RecordCount;
      if (RecordCount = 1)  and (FieldByName('Fish_PCode').AsString = '') then
      begin
        Mouse_NoWait;
        Msg_NoWait;
        InformationMessage('åí ÝíÔí ÏÑ Çíä ãÇå ÕÇÏÑ äÔÏå ÇÓÊ.');
        Close;
        Free;
        Exit;
      end
      else
      begin
        tbl := TTable.Create(Application);
        if ExtractFilePath(txtFileName.Text) <> '' then
          tbl.DatabaseName := ExtractFilePath(txtFileName.Text)
        else
          tbl.DatabaseName := g_options.DataBasePath;
        tbl.TableName := ExtractFileName(txtFileName.Text);
        tbl.TableType := ttFoxPro;
        tbl.Active := False;
        tbl.FieldDefs.Clear;
        tbl.FieldDefs.Add('PCode', ftString, 8, False);
        tbl.FieldDefs.Add('Month', ftSmallint, 0, False);
        tbl.FieldDefs.Add('Price', ftCurrency, 0, False);
        tbl.CreateTable;

        tbl.Open;
        while not Eof do
        begin
          prgBar.Position := prgBar.Position + 1;
          tbl.Append;
          tbl.FieldByName('PCode').AsString := FieldByName('Fish_PCode').AsString;
          tbl.FieldByName('Month').AsInteger := cmbMonth.ItemIndex+1;
          tbl.FieldByName('Price').AsCurrency := FieldByName('Prc').AsCurrency;
          tbl.Post;

          Next;
        end;
        tbl.Close;
        tbl.Free;
      end;

      Close;
      Free;
    end;
    Mouse_NoWait;
    Msg_NoWait;
  end;
end;

end.
