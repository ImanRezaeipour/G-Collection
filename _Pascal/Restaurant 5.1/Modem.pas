unit Modem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, MSGs, DateProc, ComCtrls, Tabnotbk,
  Grids, Z80_cmd, CPort;

type
  TfrmModem = class(TForm)
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    tabModem: TTabbedNotebook;
    grpActive: TGroupBox;
    rdoActive: TRadioButton;
    rdoNotActive: TRadioButton;
    lbl1: TLabel;
    cmbPort: TComboBox;
    lbl2: TLabel;
    cmbBaud: TComboBox;
    grpLine: TGroupBox;
    lbl3: TLabel;
    rdoLeased: TRadioButton;
    rdoTel: TRadioButton;
    txtTel: TEdit;
    cmdDisConnect: TBitBtn;
    cmdDial: TBitBtn;
    lblTest: TLabel;
    cmdSave: TBitBtn;
    mmo: TMemo;
    lbl4: TLabel;
    cmdClear: TBitBtn;
    dbgModem: TStringGrid;
    cmdDelCommand: TBitBtn;
    lbl5: TLabel;
    txtCommand: TEdit;
    cmdAddCommand: TBitBtn;
    cmdSaveCommand: TBitBtn;
    cmdSend: TBitBtn;
    cmdUp: TBitBtn;
    cmdDown: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdDialClick(Sender: TObject);
    procedure rdoActiveKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBaudKeyPress(Sender: TObject; var Key: Char);
    procedure rdoTelKeyPress(Sender: TObject; var Key: Char);
    procedure rdoLeasedKeyPress(Sender: TObject; var Key: Char);
    procedure rdoTelClick(Sender: TObject);
    procedure cmdDisConnectClick(Sender: TObject);
    procedure mmoKeyPress(Sender: TObject; var Key: Char);
    procedure cmdClearClick(Sender: TObject);
    procedure cmdSendClick(Sender: TObject);
    procedure cmdAddCommandClick(Sender: TObject);
    procedure txtCommandKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSaveCommandClick(Sender: TObject);
    procedure cmdDelCommandClick(Sender: TObject);
    procedure dbgModemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdUpClick(Sender: TObject);
    procedure cmdDownClick(Sender: TObject);
    procedure dbgModemKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    procedure SetWinF;
    procedure InitialGrid;
    procedure ClearResult;

  public
    { Public declarations }
  end;





function  InitialModem : Boolean;
function  DialModem(TelNo : String; var ret : String) : Boolean;
function  DisConnectModem : Boolean;




implementation
uses ComTools;
{$R *.DFM}


const
  EOL = #13#10;



function AddSecondTime(time_time : TDateTime; Sec:Integer) : TDateTime;
var h, m, s, ms : Word;
begin
  DeCodeTime(time_time, h, m, s, ms);
  s := s + Sec;
  if s > 59 then
  begin
    m := m + (s div 60);
    s := s mod 60;
  end;
  if m > 59 then
  begin
    h := h + (m div 60);
    m := m mod 60;
  end;
  if h > 23 then
    h := h mod 24;
  AddSecondTime := EncodeTime(h, m, s, ms);
end;
  
{******************* Modem Procedures ***********************}

function SendToModem(ST : String) : Boolean;
var l : Byte;
begin
  l := frmComTools.ComPort.WriteStr(ST);
  SendToModem := (l = Length(ST));

  TestTest('S: ', ST);
end;

(*procedure GetModem(var PK : WideString; TimeOut : Integer);
const
  ValidNo = 8;
  ValidST : array[1..ValidNo] of String =
    ('OK', 'ERROR', 'BUSY', 'NO CARRIER', 'NO DIALTONE',
    'CONNECT', 'CCOONN', 'ONNEC');
var
  s : String;
  i : Byte;
  ExitLoop : Boolean;
  endtm : TDateTime;
begin
  frmComTools.ComPort.Timeouts.ReadTotalMultiplier := 0;
  frmComTools.ComPort.Timeouts.ReadTotalConstant := 0;
  ExitLoop := False;
  endtm := AddSecondTime(Time, TimeOut);
  while not ExitLoop do
  begin
    frmComTools.ComPort.ReadStr(s, 1);
    PK :=  PK + s;
    for i := 1 to ValidNo do
      if Pos(ValidST[i], PK) > 0 then ExitLoop := True;
    if Time > endtm then ExitLoop := True;
  end;
  if frmComTools.ComPort.InputCount > 0 then
  begin
    frmComTools.ComPort.ReadStr(s, frmComTools.ComPort.InputCount);
    PK := PK + s;
  end;

  TestTest('G: ', PK);
end;*)

procedure GetModem(var PK : WideString; TimeOut : Integer);
const
  ValidNo = 6;
  ValidST : array[1..ValidNo] of String =
    ('OK', 'ERROR', 'BUSY', 'NO CARRIER', 'NO DIALTONE',
    'CONNECT');
var
  s : String;
  i, lC : Byte;
  ExitLoop  : Boolean;
  endtm : TDateTime;
begin
  frmComTools.ComPort.Timeouts.ReadTotalMultiplier := 0;
  frmComTools.ComPort.Timeouts.ReadTotalConstant := 0;
  ExitLoop := False;
  endtm := AddSecondTime(Time, TimeOut);
  lc := 0;
  PK := '';
  while not ExitLoop do
  begin
    frmComTools.ComPort.ReadStr(s, 1);
    PK :=  PK + s;
    for i := 1 to ValidNo do
      if Pos(ValidST[i], PK) > 0 then
      begin
        lc := i;
        ExitLoop := True;
        Break;
      end;

    if Time > endtm then
      ExitLoop := True;
  end;

  if lc >= 6 then
    Sleep(3000)
  else
    Sleep(50);

  while frmComTools.ComPort.InputCount > 0 do
  begin
    frmComTools.ComPort.ReadStr(s, frmComTools.ComPort.InputCount);
    PK := PK + s;
    Sleep(50);
  end;

  {if frmComTools.ComPort.InputCount > 0 then
  begin
    Sleep(500);
    frmComTools.ComPort.ReadStr(s, frmComTools.ComPort.InputCount);
    PK := PK + s;
  end;}

  TestTest('G: ', PK);
end;


function AT_Command(AT : String) : String;
var
  ST : WideString;
  Sec : Byte;
begin
  RS232Initial(F_Params.Mdm_Baud, F_Params.Mdm_Port, RDR_RESTZ84);
  ST := '';

  if SendToModem(AT) then
  begin
    if (Pos('ATDP', AT) > 0) or (Pos('ATPD', AT) > 0) then
      Sec := 40
    else
      Sec := 3;

    GetModem(ST, Sec);
    ST := Trim(ST);
  end;

  {repeat
    i := Pos(EOL, ST);
    Delete(ST, i, 2);
  until i = 0;}
  AT_Command := ST;

  TestTest('G: ', ST);
end;


function InitialModem : Boolean;
var
  OK : Boolean;
  s : String;
begin
  OK := False;
  if (F_Params.Mdm_Active = MB_TRUE) then
  begin
    RdrIndx := 1;
    RS232Initial(F_Params.Mdm_Baud, F_Params.Mdm_Port, RDR_RESTZ84);
    s := AT_Command('AT'+EOL);
    OK := (Pos('OK', s) > 0);
  end;
  InitialModem := OK;
end;

function DialModem(TelNo : String; var ret : String) : Boolean;
var OK : Boolean;
begin
  ret := '';
  OK := False;
  if InitialModem then
  begin
    ret := AT_Command('ATDP'+TelNo+EOL);
    OK := ((Pos('CONNECT', ret) > 0) OR
           (Pos('CCOONN', ret) > 0) OR
           (Pos('ONNEC', ret) > 0));
  end;

  DialModem := OK;
end;

function DisConnectModem : Boolean;
var ret : String;
begin
  AT_Command('+++ATH'+EOL);
  ret := AT_Command('ATH0'+EOL);
  DisConnectModem := (Pos('OK', ret) > 0);
end;








{**********************************************************}
procedure TfrmModem.SetWinF;
begin
  Caption := (Caption);
  tabModem.Pages.Strings[0] := (tabModem.Pages.Strings[0]);
  tabModem.Pages.Strings[1] := (tabModem.Pages.Strings[1]);
  tabModem.Pages.Strings[2] := (tabModem.Pages.Strings[2]);
  grpActive.Caption := (grpActive.Caption);
  rdoActive.Caption := (rdoActive.Caption);
  rdoNotActive.Caption := (rdoNotActive.Caption);
  grpLine.Caption := (grpLine.Caption);
  rdoTel.Caption := (rdoTel.Caption);
  rdoLeased.Caption := (rdoLeased.Caption);
  cmdDial.Caption := (cmdDial.Caption);
  cmdDisConnect.Caption := (cmdDisConnect.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lblTest.Caption := (lblTest.Caption);
  cmdSave.Caption := (cmdSave.Caption);

  lbl4.Caption := (lbl4.Caption);
  cmdClear.Caption := (cmdClear.Caption);

  lbl5.Caption := (lbl5.Caption);
  cmdDelCommand.Caption := (cmdDelCommand.Caption);
  cmdSaveCommand.Caption := (cmdSaveCommand.Caption);
  cmdAddCommand.Caption := (cmdAddCommand.Caption);
  cmdSend.Caption := (cmdSend.Caption);
  cmdUp.Caption := (cmdUp.Caption);
  cmddown.Caption := (cmdDown.Caption);

  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmModem.InitialGrid;
var
  f : TextFile;
  s : String;
begin
  dbgModem.ColWidths[0] := 200;
  dbgModem.Cells[0, 0] := ('›—«„Ì‰');

  dbgModem.ColWidths[1] := 180;
  dbgModem.Cells[1, 0] := ('‰ ÌÃÂ');

  dbgModem.RowCount := 2;
  dbgModem.Cells[0, 1] := '';
  dbgModem.Cells[1, 1] := '';

  if FileExists(g_options.ProgramPath + 'Mdm_Cmds.Ini') then
  begin
    AssignFile(f, g_options.ProgramPath + 'Mdm_Cmds.Ini');
    Reset(f);
    while not Eof(f) do
    begin
      ReadLn(f, S);
      if dbgModem.Cells[0, dbgModem.RowCount-1] <> '' then
        dbgModem.RowCount := dbgModem.RowCount + 1;

      dbgModem.Cells[0, dbgModem.RowCount-1] := S;
    end;
    CloseFile(f);
  end;
end;

procedure TfrmModem.ClearResult;
var i : Byte;
begin
  for i := 1 to dbgModem.RowCount - 1 do
    dbgModem.Cells[1, i] := '';
end;


procedure TfrmModem.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  lblTest.Caption := '';
  cmbBaud.Items.Clear;
  for i := 0 to MaxBaudIndex do
    cmbBaud.Items.Add(IntToStr(baudrates[i]));

  rdonotActive.Checked := True;
  rdoActive.Checked := (F_Params.Mdm_Active = MB_TRUE);
  cmbPort.ItemIndex := F_Params.Mdm_Port - 1;
  cmbBaud.ItemIndex := F_Params.Mdm_Baud;
  rdoLeased.Checked := True;
  rdoTel.Checked := (F_Params.Mdm_IsTel = MB_TRUE);
  txtTel.Text := F_Params.Mdm_TelNum;
  InitialGrid;
end;



procedure TfrmModem.rdoActiveKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbPort.SetFocus;
  end;
end;

procedure TfrmModem.cmbBaudKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoTel.Checked then
      rdoTel.SetFocus
    else
      rdoLeased.SetFocus;
  end;
end;

procedure TfrmModem.rdoTelKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtTel.SetFocus;
  end;
end;

procedure TfrmModem.rdoLeasedKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if cmdDial.Enabled then
      cmdDial.SetFocus
    else
      cmdSave.SetFocus;
  end;
end;

procedure TfrmModem.rdoTelClick(Sender: TObject);
begin
  txtTel.Enabled := rdoTel.Checked;
  cmdDial.Enabled := rdoTel.Checked;
  cmdDisConnect.Enabled := rdoTel.Checked;
end;

procedure TfrmModem.cmdDisConnectClick(Sender: TObject);
begin
  Mouse_Wait;
  lblTest.Caption := ('...œ—Õ«· ﬁÿ⁄ Œÿ');
  tabModem.Refresh;
  SetUserControl;
  if DisConnectModem then
    lblTest.Caption := ('.Œÿ ﬁÿ⁄ ‘œ')
  else
    lblTest.Caption := ('.ﬁÿ⁄ Œÿ „Ì”— ‰Ì” ');
  USERCONTROL := False;
  Mouse_NoWait;
end;

procedure TfrmModem.cmdDialClick(Sender: TObject);
var ret : String;
begin
  if rdoTel.Checked and (txtTel.Text = '') then
  begin
    ErrorMessage('‘„«—Â  ·›‰ Ê«—œ ‰‘œÂ «” .');
    txtTel.SetFocus;
  end
  else if cmbPort.Text = '' then
  begin
    ErrorMessage('ÅÊ—  «— »«ÿÌ „‘Œ’ ‰Ì” .');
    cmbPort.SetFocus;
  end
  else
  begin
    SetUserControl;
    if frmComTools.ComPort.Connected then
      frmComTools.ComPort.Close;
    frmComTools.ComPort.Port := cmbPort.Text;
    if frmComTools.ComPort.Open then
    else
    begin
      ErrorMessage('ÅÊ—  «‰ Œ«» ‘œÂ ‰«œ—”  «” .');
      cmbPort.SetFocus;
      UserControl := False;
      Exit;
    end;
    UserControl := False;
    Mouse_Wait;

    SetUserControl;
    if rdoActive.Checked then
      F_Params.Mdm_Active := MB_TRUE
    else
      F_Params.Mdm_Active := MB_FALSE;

    F_Params.Mdm_Port := cmbPort.ItemIndex + 1;
    F_Params.Mdm_Baud := cmbBaud.ItemIndex;

    if rdoTel.Checked then
      F_Params.Mdm_IsTel := MB_TRUE
    else
      F_Params.Mdm_IsTel := MB_FALSE;

    if rdoTel.Checked then
      F_Params.Mdm_TelNum := txtTel.Text
    else
      F_Params.Mdm_TelNum := '';
    SaveIniFile;

    lblTest.Caption := ('...œ— Õ«· ‘„«—Â êÌ—Ì');
    tabModem.Refresh;
    if DialModem(F_Params.Mdm_TelNum, ret) then
    begin
      lblTest.Caption := ret + (' .«— »«ÿ »—ﬁ—«— «” ')
    end
    else
      lblTest.Caption := ('.«— »«ÿ ﬁÿ⁄ „Ìù»«‘œ');
    Mouse_NoWait;
    USERCONTROL := False;
  end;
end;

procedure TfrmModem.cmdSaveClick(Sender: TObject);
begin
  if rdoTel.Checked and (txtTel.Text = '') then
  begin
    ErrorMessage('‘„«—Â  ·›‰ Ê«—œ ‰‘œÂ «” .');
    txtTel.SetFocus;
  end
  else if cmbPort.Text = '' then
  begin
    ErrorMessage('ÅÊ—  «— »«ÿÌ „‘Œ’ ‰Ì” .');
    cmbPort.SetFocus;
  end
  else
  begin
    SetUserControl;
    if frmComTools.ComPort.Connected then
      frmComTools.ComPort.Close;
    frmComTools.ComPort.Port := cmbPort.Text;
    if frmComTools.ComPort.Open then
    else
    begin
      ErrorMessage('ÅÊ—  «‰ Œ«» ‘œÂ ‰«œ—”  «” .');
      cmbPort.SetFocus;
      UserControl := False;
      Exit;
    end;
    UserControl := False;

    if rdoActive.Checked then
      F_Params.Mdm_Active := MB_TRUE
    else
      F_Params.Mdm_Active := MB_FALSE;

    F_Params.Mdm_Port := cmbPort.ItemIndex + 1;
    F_Params.Mdm_Baud := cmbBaud.ItemIndex;

    if rdoTel.Checked then
      F_Params.Mdm_IsTel := MB_TRUE
    else
      F_Params.Mdm_IsTel := MB_FALSE;

    if rdoTel.Checked then
      F_Params.Mdm_TelNum := txtTel.Text
    else
      F_Params.Mdm_TelNum := '';
    SaveIniFile;
  end;
end;


procedure TfrmModem.mmoKeyPress(Sender: TObject; var Key: Char);
var
  S : WideString;
begin
  if Key = #13 then
  begin
    if not (F_Params.Mdm_Port in [1..16]) then
      ErrorMessage(' ‰ŸÌ„«  „Êœ„ «‰Ã«„ ‰‘œÂ «” .')
    else
    begin
      Key := #0;
      S := mmo.Lines.Strings[mmo.Lines.Count-1];
      S := UpperCase(S) + EOL;
      S := AT_Command(S) + EOL;
      mmo.Lines.Add(S);
    end;
  end
  else if Key = #27 then
  begin
    S := AT_Command('AT'+EOL) + EOL;
    mmo.Lines.Add(S);
  end;
end;

procedure TfrmModem.cmdClearClick(Sender: TObject);
begin
  mmo.Clear;
  mmo.SetFocus;
end;

procedure TfrmModem.cmdSendClick(Sender: TObject);
var
  S : String;
  i : Byte;
begin
  if not (F_Params.Mdm_Port in [1..16]) then
    ErrorMessage(' ‰ŸÌ„«  „Êœ„ «‰Ã«„ ‰‘œÂ «” .')
  else
  begin
    Mouse_Wait;
    ClearResult;
    for i := 1 to dbgModem.RowCount-1 do
    begin
      dbgModem.Row := i;
      dbgModem.Refresh;
      S := UpperCase(dbgModem.Cells[0, i]) + EOL;
      dbgModem.Cells[1, i] := AT_Command(S);
      dbgModem.Refresh;
    end;
    Mouse_NoWait;
  end;
end;

procedure TfrmModem.txtCommandKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdAddCommandClick(Sender);
  end;
end;

procedure TfrmModem.cmdAddCommandClick(Sender: TObject);
begin
  if txtCommand.Text <> '' then
  begin
    if (dbgModem.Cells[0, dbgModem.RowCount-1] <> '') THEN
      dbgModem.RowCount := dbgModem.RowCount + 1;

    dbgModem.Cells[0, dbgModem.RowCount-1] := txtCommand.Text;
    dbgModem.Row := dbgModem.RowCount-1; 
    txtCommand.Text := '';
    txtCommand.SetFocus;
  end;
end;

procedure TfrmModem.cmdSaveCommandClick(Sender: TObject);
var
  f : TextFile;
  i : Byte;
begin
  AssignFile(f, g_options.ProgramPath + 'Mdm_Cmds.Ini');
  ReWrite(f);
  for i := 1 to dbgModem.RowCount - 1 do
    if dbgModem.Cells[0, i] <> '' then
      WriteLn(f, dbgModem.Cells[0, i]);
  CloseFile(f);
end;

procedure TfrmModem.cmdDelCommandClick(Sender: TObject);
var i : Byte;
begin
  if dbgModem.Cells[0, dbgModem.Row] <> '' then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ›—„«‰ «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      for i := dbgModem.Row + 1 to dbgModem.RowCount-1 do
      begin
        dbgModem.Cells[0, i-1] := dbgModem.Cells[0, i];
        dbgModem.Cells[1, i-1] := dbgModem.Cells[1, i];
      end;
      i := dbgModem.RowCount-1;
      dbgModem.Cells[0, i] := '';
      dbgModem.Cells[1, i] := '';
      if dbgModem.RowCount > 2 then
        dbgModem.RowCount := dbgModem.RowCount - 1;
    end;
  end;
end;

procedure TfrmModem.dbgModemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 46) and (dbgModem.Col = 1) then
  begin
    Key := 0;
    cmdDelCommandClick(Sender);
  end;
end;

procedure TfrmModem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 9) and (Shift = [ssCtrl]) then
  begin
    if tabModem.PageIndex < tabModem.Pages.Count-1 then
      tabModem.PageIndex := tabModem.PageIndex + 1
    else
      tabModem.PageIndex := 0;
  end;
end;

procedure TfrmModem.cmdUpClick(Sender: TObject);
var t : String;
begin
  ClearResult;
  if dbgModem.Row > 1 then
  begin
    t := dbgModem.Cells[0, dbgModem.Row];
    dbgModem.Cells[0, dbgModem.Row] := dbgModem.Cells[0, dbgModem.Row-1];
    dbgModem.Cells[0, dbgModem.Row-1] := t;
    dbgModem.Row := dbgModem.Row - 1;
  end;
end;

procedure TfrmModem.cmdDownClick(Sender: TObject);
var t : String;
begin
  ClearResult;
  if dbgModem.Row < dbgModem.RowCount-1 then
  begin
    t := dbgModem.Cells[0, dbgModem.Row];
    dbgModem.Cells[0, dbgModem.Row] := dbgModem.Cells[0, dbgModem.Row+1];
    dbgModem.Cells[0, dbgModem.Row+1] := t;
    dbgModem.Row := dbgModem.Row + 1;
  end;
end;

procedure TfrmModem.dbgModemKeyPress(Sender: TObject; var Key: Char);
begin
  if dbgModem.Col = 1 then
    Key := #0;
end;

procedure TfrmModem.FormShow(Sender: TObject);
begin
  frmComTools.ComPort.Close;
  frmComTools.ComPort.SyncMethod := smThreadSync;
  frmComTools.ComPort.Open;
end;

procedure TfrmModem.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  frmComTools.ComPort.Close;
  frmComTools.ComPort.SyncMethod := smNone;
  frmComTools.ComPort.Open;
end;

end.
