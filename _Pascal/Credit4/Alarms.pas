unit Alarms;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DosMove;

type
  TfrmAlarms = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    grdAlarms: TStringGrid;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure grdAlarmsKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure SetWinF;
    procedure InitialGrid;
  public
    { Public declarations }
  end;


implementation

uses
  Globals, Keyboard, MSGs, RunCmnds, TimeTool,DateProc, Funcs;

{$R *.DFM}



procedure TfrmAlarms.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmAlarms.InitialGrid;
var i : Byte;
begin
  grdAlarms.ColWidths[0] := 35;
  grdAlarms.ColWidths[1] := 100;
  grdAlarms.ColWidths[2] := 120;

  grdAlarms.Cells[0, 0] := ('—œÌ›');
  grdAlarms.Cells[1, 0] := ('“„«‰ ¬·«—„ hh:mm');
  grdAlarms.Cells[2, 0] := ('„œ  “„«‰ hh:mm:ss');

  for i := 1 to 15 do
    grdAlarms.Cells[0, i] := IntToStr(i);

end;


procedure TfrmAlarms.FormCreate(Sender: TObject);
var i : Byte;
begin
  for i := 1 to TotalReader do
    cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
  SetWinF;
  InitialGrid;
  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
end;

procedure TfrmAlarms.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmAlarms.cmdOkClick(Sender: TObject);
const
  SET_ALARM = 0;
  GET_ALARM = 1;
  DEL_ALARM = 2;

var
  i : Byte;
  OK : Boolean;
  ST : String;
  t : String[2];
begin
  if cmbReaders.Text = '' then
  begin
    ErrorMessage(' —„Ì‰«· „‘Œ’ ‰‘œÂ «” .');
    cmbReaders.SetFocus;
  end
  else if cmbOperate.Text = '' then
  begin
    ErrorMessage('⁄„·Ì«  „‘Œ’ ‰‘œÂ «” .');
    cmbReaders.SetFocus;
  end
  else
  begin
    case cmbOperate.ItemIndex of
      SET_ALARM:
      begin
        for i := 1 to 15 do
          if (grdAlarms.Cells[1, i] <> '') and (not IsTrueTime(grdAlarms.Cells[1, i])) then
          begin
            ErrorMessage('“„«‰ «‘ »«Â «” .');
            grdAlarms.Row := i;
            grdAlarms.Col := 1;
            grdAlarms.SetFocus;
            Exit;
          end;

        Mouse_Wait;
        MSG_Wait('œ— Õ«·  ‰ŸÌ„ “„«‰Â«Ì ¬·«—„...');
        ST := '';
        if Readers[cmbReaders.ItemIndex+1].R_Type = RDR_CLK6000 then
        begin
          for i := 1 to 15 do
            if (grdAlarms.Cells[1, i] <> '') or (grdAlarms.Cells[2, i] <> '') then
            begin
              t[1] := Char(TimesToInt(grdAlarms.Cells[2, i]) div 255);
              t[2] := Char(TimesToInt(grdAlarms.Cells[2, i]) mod 255);
              ST := ST + grdAlarms.Cells[1, i] + t[1] + t[2];
            end
            else
              ST := ST + '??:??'#0#0;
        end
        else
        begin
          for i := 1 to 15 do
            if grdAlarms.Cells[1, i] <> '' then
              ST := ST + grdAlarms.Cells[1, i];
        end;

        OK := SetAlarmTimes(Readers[cmbReaders.ItemIndex+1], ST);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('“„«‰Â«Ì ¬·«—„  —„Ì‰«·  ‰ŸÌ„ ‘œ.')
        else
          InformationMessage(' ‰ŸÌ„ “„«‰Â«Ì ¬·«—„ ‰«„Ê›ﬁ »Êœ.');
      end;

      GET_ALARM:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ “„«‰Â«Ì ¬·«—„...');
        OK := GetAlarmTimes(Readers[cmbReaders.ItemIndex+1], ST);
        for i := 1 to 15 do
        begin
          if Copy(ST, 1, 5) = '00:00' then
          begin
            grdAlarms.Cells[1, i] := '';
            grdAlarms.Cells[2, i] := '';
          end
          else
          begin
            grdAlarms.Cells[1, i] := Copy(ST, 1, 5);
            if Readers[cmbReaders.ItemIndex+1].R_Type = RDR_CLK6000 then
              grdAlarms.Cells[2, i] := BeautifulTimes(IntToTimehms(Ord(ST[6]) * 255 + Ord(ST[7])))
            else
              grdAlarms.Cells[2, i] := '';

          end;
          Delete(ST, 1, 7);
        end;
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('“„«‰Â«Ì ¬·«—„  —„Ì‰«· ŒÊ«‰œÂ ‘œ.')
        else
          InformationMessage('ŒÊ«‰œ‰ “„«‰Â«Ì ¬·«—„ ‰«„Ê›ﬁ »Êœ.');
      end;

      DEL_ALARM:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· Õ–› “„«‰Â«Ì ¬·«—„...');
        OK := DelAlarmTimes(Readers[cmbReaders.ItemIndex+1]);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('“„«‰Â«Ì ¬·«—„  —„Ì‰«· Õ–› ‘œ.')
        else
          InformationMessage('Õ–› “„«‰Â«Ì ¬·«—„ ‰«„Ê›ﬁ »Êœ.');
      end;
    end;
  end;
end;

procedure TfrmAlarms.grdAlarmsKeyPress(Sender: TObject; var Key: Char);
var r, c : Byte;
begin
  Keyboard_Time(Key);
  if Key = #13 then
  begin
    r := grdAlarms.Row;
    c := grdAlarms.Col;
    if c = 1 then
      grdAlarms.Cells[c, r] := BeautifulTime(grdAlarms.Cells[c, r])
    else
      grdAlarms.Cells[c, r] := BeautifulTimes(grdAlarms.Cells[c, r]);

    if c = 1 then
      c := 2
    else if (c = 2) and (r < 15) then
    begin
      c := 1;
      r := r + 1;
    end;

    grdAlarms.Row := r;
    grdAlarms.Col := c;
  end
end;

end.
