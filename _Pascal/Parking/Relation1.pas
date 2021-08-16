unit Relation1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, AdoDB, ExtCtrls, Mask, MSGs,
  ComTools, RunCmnds, DateProc, Globals, FarsiApi, DBS,
  Z84_CMD, Keyboard;

type
  TfrmRelations = class(TForm)
    dtaReaders: TDataSource;
    qryReaders: TAdoQuery;
    dbgCUnit: TDBGrid;
    qryReadersTic: TStringField;
    cmdTic: TBitBtn;
    cmdExit: TBitBtn;
    lst: TListBox;
    mmoResult: TMemo;
    cmdRun: TBitBtn;
    pnlMsg: TPanel;
    lblMsg1: TLabel;
    lblMsg2: TLabel;
    txtDate: TEdit;
    lblDate: TLabel;
    lblTime: TLabel;
    txtTime: TMaskEdit;
    cmdHelp: TBitBtn;
    qryReadersR_Code: TSmallintField;
    qryReadersR_Name: TStringField;
    qryReadersR_Port: TSmallintField;
    qryReadersR_BaudNo: TSmallintField;
    tmrTime: TTimer;
    lblMessage: TLabel;
    txtMessage: TEdit;
    pnlTitle: TPanel;
    cmdInvert: TBitBtn;
    qryReadersR_Active: TStringField;
    qryReadersR_IP: TStringField;
    qryReadersR_TCP: TBooleanField;
    qryReadersR_IsCOM: TBooleanField;
    procedure cmdTicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryReadersCalcFields(DataSet: TDataSet);
    procedure dbgCUnitDblClick(Sender: TObject);
    procedure dbgCUnitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdRunClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure cmdInvertClick(Sender: TObject);
  private
    { Private declarations }
    procedure MakeReaderSel;
    procedure SetWinF;
    
  public
    { Public declarations }
    ActionType : Byte;
  end;
var RdrSel : set of 0..255;

implementation

{$R *.DFM}

const
   TableNames : array[1..4] of String[15] =
                ('Colors','CarS','Cities','BarCodes');
   FldName    : array[1..4] of String[15] =
                ('Clr_Name','Car_Name','City_Name', 'Card_Code');
   FldSort    : array[1..4] of String[15] =
                ('Clr_Code','Car_Code','City_Code', 'Card_Code');
var
  FT : file of Char;
  qry : TAdoQuery;

procedure MakeQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
end;

procedure AssignQuery(I : Byte);
begin
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ' + TableNames[I]);
  if I = 4 then
    qry.SQL.Add('WHERE Card_State = ' + IntToStr(MB_PERSONS));
  qry.SQL.Add('ORDER BY ' + FldSort[I]);
end;

procedure DestroyQuery;
begin
  qry.Close;
  qry.Free;
end;

procedure MakeTableFile;
var
  I, J : Byte;
  K : Integer;
  ST15 : String[15];
  ch : Char;
  tedads : array[1..4] of Byte;
begin
  MakeQuery;
  Assign(FT, 'FTABLES.TMP');
  ReWrite(FT);
  ch := #0;
  for i := 1 to 12 do
    Write(ft, ch);
  for I := 1 to 3 do
  begin
    AssignQuery(I);
    tedads[i] := 0;
    with qry do
    begin
      Open;
      while not EOF do
      begin
        ST15 := ConvertFromWinCode(NumReverse(FieldByName(FldName[I]).AsString));
        ST15 := FORMAT('%-15s', [ST15]);
        for J := 1 to 15 do
          Write(FT,ST15[J]);
        Inc(tedads[i]);
        Next;
      end;
      Close;
      ch := #255;
      for J := 1 to 15 do
        Write(FT, ch);
     end;
  end;

  I := 4;
  AssignQuery(I);
  tedads[I] := 0;
  with qry do
  begin
    open;
    while not EOF do
    begin
      ST15 := StrRev(BarCode4(FieldByName(FldName[I]).AsString));
      for J:=1 to 4 do
        Write(FT, ST15[J]);
      Inc(tedads[i]);
      Next;
    end;
    Close;
    ch := #255;
    for J:=1 to 4 do
      Write(FT, ch);
  end;

  CloseFile(FT);
  ReSet(FT);
  k := 12;
  for i := 1 to 4 do
  begin
    ch := Chr(tedads[i]);
    Write(FT, ch);
    ch := Chr(k mod 256);
    Write(FT, ch);
    ch := Chr(k div 256);
    Write(FT, ch);
    k := k + 15 * tedads[i] + 15;
  end;
  CloseFile(FT);
  DestroyQuery;
end;

procedure SendTableFile(var OK:Boolean);
LABEL PAYAN;
const
  PKSIZE=32;
var
  F, E : file of Byte;
  EndWork : Boolean;
  I, J ,K, L, TLOOP, ChkSum : Byte;
  FADDR, IJ : WORD;
  SIZES, TPOCKET, CP : Word;
  PK, ST, ST2 : String;
  STAT : Byte;
  TRYING, BoxEscape : Boolean;
begin
  SetUserControl;
  OK := True;
  ST := '';
  FADDR := 0;
  Z84_MakePocket(PK, curRdrCode, $50, 0, ST);
  BoxEscape := not SendPocket(PK);
  if BOXESCAPE then
    OK := False
  else
  begin
    Z84_GetPocket(PK, 9, 100, STAT);
    if STAT = ERR_NONE then
    begin
      case Ord(PK[4]) of
        $51:
        begin
          FADDR := Ord(PK[7]) * 256 + Ord(PK[6]);
          OK := True;
        end;
        else
          OK := False;
      end;
    end
    else
      OK := False;
  end;

  if OK then
  begin
    Z84_MakePocket(PK, curRdrCode, $06, 0, #$50);
    BoxEscape := not SendPocket(PK);
    if BOXESCAPE then
      OK := False;
  end
  else
    goto PAYAN;

  Assign(F, 'FTABLES.TMP');
  ReSet(F);
  Assign(E, 'FTABLES1.TMP');
  ReWrite(E);
  ChkSum := 0;
  for L := 1 to 4 do
  begin
    Read(F, K, I, J);
    IJ := J*256 + I;
    Inc(IJ, FADDR);
    I := IJ mod 256;
    J := IJ div 256;
    Write(E, K, I, J);
    Inc(ChkSum, K+I+J);
  end;

  while not Eof(F) do
  begin
    Read(F, I);
    Write(E, I);
    Inc(ChkSum, I);
  end;

  CloseFile(F);
  Write(E, ChkSum);
  CloseFile(E);
  Sleep(300);
  ReSet(E);
  SIZES := FileSize(E);
  CloseFile(E);
  TPOCKET := SIZES DIV PKSIZE + 1;
  ST := Chr(TPOCKET) + Chr(PKSIZE);
  Z84_MakePocket(PK, curRdrCode, $52, 0, ST);
  BoxEscape := not SendPocket(PK);
  if BOXESCAPE then
  begin
    BoxEscape := not SendPocket(PK);
    if BOXESCAPE then
    begin
       BoxEscape := not SendPocket(PK);
       if BOXESCAPE then OK := False;
    end;
  end;

  if OK then
  begin
    Z84_GetPocket(PK, 7, 1000, STAT);
    if STAT = ERR_NONE then
    begin
      case ORD(PK[4]) of
        $06: OK := True;
        else OK := False;
      end;
    end
    else
      OK := False;
  end;

  if not OK then
    Goto PAYAN;

  Assign(F, 'FTABLES1.TMP');
  ReSet(F);
  CP := 0;
  EndWork := False;
  repeat
    Inc(CP);
    ST := Chr(CP);
    if CP < TPOCKET then
    begin
      for J := 1 to PKSIZE do
      begin
        Read(F, K);
        ST := ST + Chr(K);
      end;
      Z84_MakePocket(PK, curRdrCode, $53, 0, ST);
    end
    else
    begin
      while not Eof(F) do
      begin
        Read(F, K);
        ST := ST + Chr(K);
      end;
      Z84_MakePocket(PK,curRdrCode,$54, 0, ST);
    end;
    TRYING := True;
    TLOOP := 0;
    ST2 := PK;

    repeat
      BoxEscape := not SendPocket(PK);
      if BOXESCAPE then
      begin
        Inc(TLOOP);
        if TLOOP >= 4 then
          OK := False
        else
          PK := ST2;
      end
      else
      begin
        Z84_GetPocket(PK, 7, 100, STAT);
        if STAT = ERR_NONE then
        begin
          case Ord(PK[4]) of
            $06:
            begin
              OK := True;
              TRYING := False;
            end;
            $15:
            begin
              Inc(TLOOP);
              if TLOOP >= 4 then
                OK := False
              else
                PK := ST2;
            end;
            else
              OK := False;
          end;
        end
        else
        begin
          Inc(TLOOP);
          if TLOOP >= 4 then
            OK := False
          else
            PK := ST2;
        end;
      end;
    until not TRYING or not OK;

    if not OK or (CP = TPOCKET) then
      EndWork := True;
  until EndWork;
  CloseFile(F);

PAYAN:
  UserControl := False;
end;


procedure TfrmRelations.SetWinF;
begin
  Caption := (Caption);
  lblMessage.Caption := (lblMessage.Caption);
  lblDate.Caption := (lblDate.Caption);
  lblTime.Caption := (lblTime.Caption);
  cmdTic.Caption := (cmdTic.Caption);
  cmdInvert.Caption := (cmdInvert.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  qryReadersR_Name.DisplayLabel := (qryReadersR_Name.DisplayLabel);
  qryReadersTic.DisplayLabel := (qryReadersTic.DisplayLabel);
end;

procedure TfrmRelations.MakeReaderSel;
var i : Byte;
begin
  RdrSel := [];
  for i := 1 to TotalReader do
    with Readers[i] do
      if lst.Items.IndexOf(IntToStr(R_Code)) <> -1 then
        RdrSel := RdrSel + [i];
end;

procedure TfrmRelations.cmdTicClick(Sender: TObject);
begin
  if lst.Items.IndexOf(qryReaders.FieldByname('R_Code').AsString) = -1 then
    lst.Items.Add(qryReaders.FieldByname('R_Code').AsString)
  else
    lst.Items.Delete(lst.Items.IndexOf(qryReaders.FieldByname('R_Code').AsString));
  qryReaders.Refresh;
end;

procedure TfrmRelations.cmdInvertClick(Sender: TObject);
begin
  qryReaders.First;
  while not qryReaders.Eof do
  begin
    if lst.Items.IndexOf(qryReaders.FieldByname('R_Code').AsString) = -1 then
      lst.Items.Add(qryReaders.FieldByname('R_Code').AsString)
    else
      lst.Items.Delete(lst.Items.IndexOf(qryReaders.FieldByname('R_Code').AsString));
    qryReaders.Next;
  end;
  qryReaders.Refresh;
end;

procedure TfrmRelations.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryReaders.connection := frmDBS.adoConnect;
  lblTime.Visible := False;
  lblDate.Visible := False;
  txtTime.Visible := False;
  txtDate.Visible := False;
  txtDate.text := CurrentDate;
  txtTime.text := CurrentTimes;
  SetDirectionFarsi(mmoResult.Handle);
  SetDirectionFarsi(txtMessage.Handle);
  lblMessage.Visible := False;
  txtMessage.Visible := False;
end;

procedure TfrmRelations.FormActivate(Sender: TObject);
begin
  case ActionType of
    MB_RESTART:
    begin
      cmdRun.Caption := ('—«Â «‰œ«“Ì &„Ãœœ');
      Caption := ('—«Â «‰œ«“Ì „Ãœœ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ —«Â «‰œ«“Ì „Ãœœ œ” ê«ÂÂ«');
      HelpContext := 204;
    end;

    MB_TEST:
    begin
      cmdRun.Caption := (' &”  «— »«ÿ');
      caption := (' ”  «— »«ÿ »« œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ «— »«ÿ »« œ” ê«ÂÂ«');
      HelpContext := 201;
    end;

    MB_DATETIME:
    begin
      lblTime.Visible := True;
      lblDate.Visible := True;
      txtTime.Visible := True;
      txtDate.Visible := True;
      cmdRun.Caption := (' ‰&ŸÌ„');
      Caption := (' ‰ŸÌ„  «—ÌŒ Ê “„«‰ œ” ê«ÂÂ«');
      tmrTime.Enabled := True;
      pnlTitle.Caption := ('‰ ÌÃÂ  ‰ŸÌ„  «—ÌŒ Ê “„«‰ œ” ê«ÂÂ«');
      HelpContext := 206;
    end;

    MB_TBLSEND:
    begin
      cmdRun.Caption := ('«—&”«· Ãœ«Ê·');
      Caption := ('«—”«· Ãœ«Ê· »Â œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ «—”«· Ãœ«Ê· »Â œ” ê«ÂÂ«');
      HelpContext := 205;
    end;

    MB_VER:
    begin
      cmdRun.Caption := ('ŒÊ«‰œ‰ ‰&”ŒÂ');
      Caption := ('ŒÊ«‰œ‰ ‰”ŒÂ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ ŒÊ«‰œ‰ ‰”ŒÂ œ” ê«ÂÂ«');
      HelpContext := 207;
    end;

    MB_MESSAGE:
    begin
      cmdRun.Caption := ('«—”«· &ÅÌ€«„');
      Caption := ('«—”«· ÅÌ€«„ »Â œ” ê«ÂÂ«');
      HelpContext := 209;
      lblMessage.Visible := True;
      txtMessage.Visible := True;
      txtMessage.Left := 8;
      txtMessage.Width := 513;
      pnlTitle.Caption := ('‰ ÌÃÂ «—”«· ÅÌ€«„ »Â œ” ê«ÂÂ«');
    end;
  end;
  qryReaders.Open;
  //LoadReaders;
end;

procedure TfrmRelations.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryReaders.Close;
end;

procedure TfrmRelations.qryReadersCalcFields(DataSet: TDataSet);
begin
  if lst.Items.IndexOf(qryReaders.FieldByname('R_Code').AsString) <> -1 then
    qryReaders.FieldByName('Tic').AsString := 'X'
  else
    qryReaders.FieldByName('Tic').AsString := '';
end;

procedure TfrmRelations.dbgCUnitDblClick(Sender: TObject);
begin
  cmdTicClick(Sender);
end;

procedure TfrmRelations.dbgCUnitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 32) then
  begin
    Key := 0;
    cmdTicClick(Sender);
  end;
end;

procedure TfrmRelations.cmdRunClick(Sender: TObject);
var
  OK, Good : Boolean;
  i,j : Byte;
  dt,tm : String[10];
  ST : String;
begin
  case ActionType of
    MB_TEST:
    begin
      MakeReaderSel;
      if RdrSel = []
      then begin
         ErrorMessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ');
         Exit;
      end;
      Mouse_Wait;
      mmoResult.Clear;
      for i := 1 to TotalReader do
        if i in RdrSel then
          with Readers[i] do
          begin
            pnlMsg.Visible := True;
            lblMsg1.caption := ('œ—Õ«· ê—› ‰ «— »«ÿ »«');
            lblMsg2.caption := R_Name;
            Refresh;
            if SwitchReader(i) then
            begin
              pnlMsg.Visible := False;
              if LinkTest(Readers[i]) then
                mmoResult.Lines.Add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' »—ﬁ—«—'))
              else
                mmoResult.Lines.Add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ *******'));
            end;
      end;
      Mouse_NoWait;
    end;

    MB_RESTART:
    begin
      MakeReaderSel;
      if RdrSel = [] then
      begin
         ErrorMessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ');
         Exit;
      end;
      Mouse_Wait;
      mmoResult.Clear;
      for i := 1 to TotalReader do
        if i in RdrSel then
          with Readers[i] do
          begin
            pnlMsg.Visible := True;
            lblMsg1.Caption := ('œ—Õ«· ê—› ‰ «— »«ÿ »«');
            lblMsg2.Caption := R_Name;
            Refresh;
            if SwitchReader(i) then
            begin
              pnlMsg.Visible := False;
              if ReStart(Readers[i]) then
                mmoResult.Lines.Add(('œ” ê«Â ' )+ R_Name + (' —«Â «‰œ«“Ì „Ãœœ ‘œ'))
              else
                mmoResult.Lines.Add(('œ” ê«Â ' )+ R_Name + (' «— »«ÿ ﬁÿ⁄ *******'));
            end;
      end;
      Mouse_NoWait;
    end;

    MB_DATETIME:
    begin
      MakeReaderSel;
      if RdrSel = [] then
      begin
         ErrorMessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ');
         Exit;
      end;
      dt := txtDate.Text;
      tm := txtTime.Text;
      good := True;
      j := StrToInt(Copy(tm, 1, 2));
      if j in [0..23] then
      else
        good := False;
      j := StrToInt(Copy(tm, 4, 2));
      if j in [0..59] then
      else
        good := False;
      j := StrToInt(Copy(tm, 7, 2));
      if j in [0..59] then
      else
        good := False;
      if not good then
      begin
        Errormessage('“„«‰ «‘ »«Â «” ');
        Exit;
      end;
      if IsTrueDate(dt) then
      begin
        dt := BeautifulDate(dt);
        txtDate.Text := dt;
      end
      else
      begin
        Errormessage(' «—ÌŒ «‘ »«Â «” ');
        Exit;
      end;
      Mouse_Wait;
      mmoResult.Clear;
      for i := 1 to TotalReader do
        if i in RdrSel then
          with Readers[i] do
          begin
            pnlMsg.Visible:=True;
            lblMsg1.caption:=('œ—Õ«·  ‰ŸÌ„  «—ÌŒ Ê “„«‰');
            lblMsg2.caption:=R_Name;
            Refresh;
            if SwitchReader(i) then
            begin
              pnlMsg.Visible := False;
              if SendDateTime(Readers[i],txtDate.Text, txtTime.Text) then
                mmoResult.Lines.Add(('»Â œ” ê«Â ' )+ R_Name + ('  «—ÌŒ Ê “„«‰  ‰ŸÌ„ ‘œ'))
              else
                mmoResult.Lines.Add(('   œ” ê«Â ' )+ R_Name +('     «— »«ÿ ﬁÿ⁄ *******'));
            end;
      end;
      Mouse_NoWait;
    end;

    MB_TBLSEND:
    begin
      MakeReaderSel;
      if RdrSel = [] then
      begin
        Errormessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ');
        Exit;
      end;
      Mouse_Wait;

      mmoResult.Clear;
      for i := 1 to TotalReader do
      if i in RdrSel then
        with Readers[i] do
        begin
          pnlMsg.Visible := True;
          lblMsg1.Caption := ('œ—Õ«· «—”«· Ãœ«Ê· »Â');
          lblMsg2.caption := R_Name;
          Refresh;
          if SwitchReader(i) then
          begin
            MakeTableFile;
            SendTableFile(OK);
            pnlMsg.Visible := False;
            if OK then
              mmoResult.Lines.Add(('»Â œ” ê«Â ' )+ R_Name +( ' Ãœ«Ê· «—”«· ‘œ'))
            else
              mmoResult.Lines.Add(('   œ” ê«Â ' )+ R_Name +(' «— »«ÿ ﬁÿ⁄ *******'));
          end;
      end;
      Mouse_NoWait;
    end;

    MB_VER:
    begin
      MakeReaderSel;
      if RdrSel = [] then
      begin
        Errormessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ');
        Exit;
      end;
      Mouse_Wait;
      mmoResult.Clear;
      for i:=1 to TotalReader do
      if i in RdrSel
      then with Readers[i] do
      begin
         pnlMsg.Visible:=True;
         lblMsg1.caption:=('œ—Õ«· ŒÊ«‰œ‰ ‰”ŒÂ');
         lblMsg2.caption := R_Name;
         Refresh;
         if SwitchReader(i) then
         begin
           pnlMsg.Visible:=False;
           if ReadVersion(Readers[i],ST) then
             mmoResult.Lines.add(('‰”ŒÂ œ” ê«Â ' )+ R_Name + ' ' + ST)
           else
             mmoResult.Lines.add(('     œ” ê«Â ' )+ R_Name +(' «— »«ÿ ﬁÿ⁄ *******'));
         end;
      end;
      Mouse_NoWait;
    end;

    MB_MESSAGE:
    begin
      MakeReaderSel;
      if RdrSel = [] then
        Errormessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” .')
      else if txtMessage.Text = '' then
        ErrorMessage('ÅÌ€«„ Ê«—œ ‰‘œÂ «” .')
      else
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in RdrSel then
            with Readers[i] do
            begin
              pnlMsg.Visible := True;
              lblMsg1.Caption := ('œ— Õ«· «—”«· ÅÌ€«„ »Â');
              lblMsg2.Caption := R_Name;
              Refresh;
              if SwitchReader(i) then
              begin
                ST := ConvertFromWinCode(NumReverse(txtMessage.Text));
                pnlMsg.Visible := False;
                if SendReaderMsg(Readers[i],ST,ST,ST,ST) then
                  mmoResult.Lines.Add(('ÅÌ€«„ »Â œ” ê«Â ' )+ R_Name + (' «—”«· ‘œ'))
                else
                  mmoResult.Lines.Add(('«—”«· ÅÌ€«„ »Â ' )+ R_Name + (' ‰«„Ê›ﬁ'));
              end;
            end;
      end;
      Mouse_NoWait;
    end;
  end;
end;

procedure TfrmRelations.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmRelations.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
   if key in ['0'..'9',#13,#8] then
     tmrTime.Enabled := False
   else
     key := #0;
end;

procedure TfrmRelations.tmrTimeTimer(Sender: TObject);
begin
  txtTime.Text := CurrentTimes;
end;




end.
