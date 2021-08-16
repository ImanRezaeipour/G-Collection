unit ViewRecs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Grids, DBGrids, AdoDB, Buttons, DBS_Proc;

type
  TfrmViewClockRecs = class(TForm)
    Label1: TLabel;
    txtBarCode: TEdit;
    dtaRecs: TDataSource;
    tblRecs: TAdoTable;
    dbgRecs: TDBGrid;
    tblRecsClock_BarCode: TStringField;
    tblRecsClock_Date: TStringField;
    tblRecsClock_Time: TStringField;
    tblRecsClock_RdrCode: TSmallintField;
    lblRecNo: TLabel;
    cmdRetry: TBitBtn;
    cmdClose: TBitBtn;
    tblRecsPCode: TStringField;
    adoQryRecs: TADOQuery;
    adoQryRecsPCode: TStringField;
    adoQryRecsClock_BarCode: TStringField;
    adoQryRecsClock_Date: TStringField;
    adoQryRecsClock_RdrCode: TSmallintField;
    adoQryRecsClock_Time: TSmallintField;
    adoQryRecsclocktime: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdRetryClick(Sender: TObject);
    procedure tblRecsCalcFields(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure adoQryRecsCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation


uses
  Globals, Keyboard, MSGs, DateProc, Ertebat, ClckRecs, Code_Sys;


{$R *.DFM}

procedure TfrmViewClockRecs.SetWinF;
begin
end;

procedure TfrmViewClockRecs.FormCreate(Sender: TObject);
var
  dt : String;
begin
  SetWinF;
  tblRecs.connection := frmDBS.DBConnection;
  adoQryRecs.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;'+
                                 'Initial Catalog='+F_Params.Clkdatabasename+';'+
                                 'Data Source=' + F_Params.ClkServerName +
                                 ';User ID=' + F_Params.ClkSqlUseName +
                                 ';Password=' + F_Params.ClkSqlPassword;
  with adoQryRecs.SQL do
  begin
    Clear;
    dt := BeautifulDate(CurrentDate);
    Add('SELECT * FROM C' + copy(dt , 1 , 4) + copy(dt , 6 , 2) + ' WHERE Clock_Date = ''' + dt + ''' and clock_chg = 0');
  end;
  if F_Params.CollectFrom = 0 then
  begin
    dtaRecs.DataSet := tblRecs;
    tblRecs.Open;
    lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(tblRecs.RecordCount);
  end
  else
  begin
    dtaRecs.DataSet := adoQryRecs;
    adoQryRecs.Open;
    lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(adoQryRecs.RecordCount);
  end

end;

procedure TfrmViewClockRecs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tblRecs.Close;
  adoQryRecs.Close;
end;

procedure TfrmViewClockRecs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 116 then
  begin
    if F_Params.CollectFrom = 0 then
    begin
//      tblRecs.Refresh;
      lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(tblRecs.RecordCount);
    end
    else
    begin
//      adoQryRecs.Refresh;
      lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(adoQryRecs.RecordCount);
    end;
  end;
end;

procedure TfrmViewClockRecs.txtBarCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if F_Params.CollectFrom = 0 then
    begin
      tblRecs.Filtered := False;
      if txtBarCode.Text = '' then
        tblRecs.Filter := ''
      else
        tblRecs.Filter := 'Clock_BarCode = ''' + FixLeft(txtBarCode.Text, '0', 8) + '''';
      tblRecs.Filtered := True;

      lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(tblRecs.RecordCount);
    end
    else
    begin
      adoQryRecs.Filtered := False;
      if txtBarCode.Text = '' then
        adoQryRecs.Filter := ''
      else
        adoQryRecs.Filter := 'Clock_BarCode = ''' + FixLeft(txtBarCode.Text, '0', 8) + '''';
      adoQryRecs.Filtered := True;

      lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(adoQryRecs.RecordCount);
    end
  end
  else
    Keyboard_Proxi(Key);
end;

procedure TfrmViewClockRecs.cmdRetryClick(Sender: TObject);
var
  i : Byte;
  RecNum : Integer;
begin
  Mouse_Wait;
  IF F_Params.CollectFrom = 0 THEN
  BEGIN
    for i := 1 to TotalReader do
      if Readers[i].R_Active and
        (Readers[i].R_Type in [RDR_CLOCKZ80, RDR_CLOCKZ84]) then
      begin
        Delay(1000);
        MSG_Wait('œ— Õ«· »«“Ì«»Ì «ÿ·«⁄«  ' + ChangeFromWin(Readers[i].R_Name, g_options.WinType, WIN_SINA_SYS));
        SwitchReader(i);
        Readers[i].Recoverd := RecoveryFirstTime(Readers[i].R_Type, CurrentDate, RecNum);
        MSG_NoWait;
      end;
//    tblRecs.Refresh;
    lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(tblRecs.RecordCount);
  END
  ELSE
  BEGIN
//    adoQryRecs.Refresh;
    lblRecNo.Caption := (' ⁄œ«œ —ﬂÊ—œÂ« : ') + IntToStr(adoQryRecs.RecordCount);
  END;
  Mouse_NoWait;
end;

procedure TfrmViewClockRecs.tblRecsCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('Clock_BarCode').AsString);
end;

procedure TfrmViewClockRecs.adoQryRecsCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('Clock_BarCode').AsString);
    FieldByName('clocktime').AsString := inttotime(FieldByName('Clock_BarCode').Asinteger);
  end;
end;

procedure TfrmViewClockRecs.FormShow(Sender: TObject);
begin
  if F_Params.CollectFrom <>0 then
    cmdRetry.Visible := false
  else
    cmdRetry.Visible := true;
end;

end.
