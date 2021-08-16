unit Relation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, AdoDB, ExtCtrls, Mask, MSGs,
  ComTools, Ertebat, DateProc, Globals, FarsiApi, DBS_Proc,
  Z80_CMD;

type
  TfrmRelations = class(TForm)
    dtaReaders: TDataSource;
    qryReaders: TAdoQuery;
    dbgReaders: TDBGrid;
    qryReadersTic: TStringField;
    cmdTic: TBitBtn;
    cmdExit: TBitBtn;
    lst: TListBox;
    mmoResult: TMemo;
    cmdRun: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    txtDate: TEdit;
    cmdHelp: TBitBtn;
    qryReadersR_Code: TSmallintField;
    qryReadersR_Name: TStringField;
    qryReadersR_Active: TBooleanField;
    qryReadersR_Port: TSmallintField;
    qryReadersR_BaudNo: TSmallintField;
    tmrTime: TTimer;
    lblTime: TLabel;
    lblDate: TLabel;
    qryReadersR_OnLine: TBooleanField;
    chkOnLine: TCheckBox;
    pnlTitle: TPanel;
    cmdInvert: TBitBtn;
    txtTime: TEdit;
    procedure cmdTicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryReadersCalcFields(DataSet: TDataSet);
    procedure dbgReadersDblClick(Sender: TObject);
    procedure dbgReadersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdRunClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure cmdInvertClick(Sender: TObject);
  private
    { Private declarations }
    procedure MakeReaderList;

    procedure Z84_GetOffLines(var OK : Boolean; var RecNum : Integer);
    procedure Z80_GetOffLines(var OK : Boolean; var RecNum : Integer);
    function  Z84RecoveryFirstTime(TD : String; var RecNum : Integer) : Boolean;
    procedure Z80Recovery(Clk_Code : Byte; T_Date : String; var OK : Boolean; var RecNum : Integer);
    procedure SetWinF;
  public
    { Public declarations }
    ActionType : Byte;
  end;


implementation

uses
  ClckRecs, Code_Sys, BioStation;

{$R *.DFM}

var
  ReaderList : Set of 0..255;

procedure TfrmRelations.SetWinF;
begin
end;

procedure TfrmRelations.Z84_GetOffLines(var OK : Boolean; var RecNum : Integer);
var
  PK:String;
  STAT:Byte;
  EndWork : Boolean;
  P_Fish : TFish;
  p : TPerson;
  i, ErrNo : Byte;
  cnt : integer;
begin
  OK := True;
  MakePocket(PK, MicroAddress, $02, 0, '');
  if not SendPocket(PK) then
    OK := False;
  EndWork := not OK;
  RecNum := 0;
  ErrNo := 0;
  cnt := 0;
  while not EndWork do
  begin
    GetPocket(PK, True, STAT);
    if (STAT = 0) and (length(pk)>3) then
    begin
      case Ord(PK[4]) of
        $04:
            {$region 'RecExist'}
        begin
//          if length(pk)=28 then
          begin
            ErrNo := 0;
            OK := True;
            P_Fish.Fish_RdrCode := StrToInt(Copy(PK, 6, 3));
            P_Fish.Keys := Ord(PK[10]) * 256 + Ord(PK[9]);
            P_Fish.Fish_Date := BeautifulDate(Copy(PK, 11, 2) + '/' +
                                              Copy(PK, 13, 2) + '/' +
                                              Copy(PK, 15, 2));
            P_Fish.Fish_Time := BeautifulTime(Copy(PK, 17, 2) + ':' +
                                              Copy(PK, 19, 2));
            P_Fish.Fish_PCode := Copy(PK, 21, 8);
            P_Fish.ManySel := 1;
            if g_options.RunDate <> P_Fish.Fish_Date then
            begin
              g_options.RunDate := P_Fish.Fish_Date;
              InitVariables(False);
            end;
            if OK then
            begin
              for i := 1 to 8 do
                P_Fish.Fish_FoodsNo[i] := 1;
              P_Fish.Fish_UCode := 0;
              P_Fish.Fish_UKhadamat := 0;
              P_Fish.Fish_UPrc := 0;
              P_Fish.Fish_UPay := 0;
              P_Fish.IsProxi := True;
              CreateFish(P_Fish, p, False);
              SaveFish(P_Fish);
            end;
            MakePocket(PK, MicroAddress, $06, 0, '');
            if not SendPocket(PK) then OK := False;
            Inc(RecNum);
            label2.Caption := IntToStr(RecNum);
            label2.Refresh;
          end
//          else
//            Ok := false;
        end;
        {$endregion 'RecExist'}
        $03: EndWork := True;
        else
        begin
          OK := False;
          EndWork := True;
        end;
      end;
    end
    else
    begin
      Inc(ErrNo);
      if ErrNo > 3 then
      begin
        OK := False;
        EndWork := True;
      end
      else
      begin
        MakePocket(PK, MicroAddress, $15, 0, '');
        if not SendPocket(PK) then
          OK := False;
      end;
    end;
    Application.ProcessMessages;
    if OK then inc(cnt);
      frmMsgBox.Caption := ' ⁄œ«œ : ' + IntToStr(cnt);
  end;
end;

procedure TfrmRelations.Z80_GetOffLines(var OK : Boolean; var RecNum : Integer);
var
  PK : String;
  EndWork : Boolean;
  P_Fish : TFish;
  p : TPerson;
  retVal, chkSum,
  ErrNo, l, i : Byte;
begin
  retVal := MB_OK;
  if not Z80_LinkTest(MicroAddress) then
    retVal := MB_OFF
  else
  begin
    Delay(10);
    if not SendPocket('D'#$0D) then
      retVal := MB_OFF
  end;
  OK := (retVal = MB_OK);
  EndWork := not OK;
  RecNum := 0;
  ErrNo := 0;
  while not EndWork do
  begin
    Z80_GetPocket(PK, 25, 300);
    l := Length(PK);
    if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      retVal := MB_BUFFEMPTY
    else if l = 25 then
    begin
      chkSum := 0;
      for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
      chkSum := (chkSum AND $7F);
      if chkSum <> Ord(PK[25]) then
        retVal := MB_BADREC
      else
        retVal := MB_TRUEREC;
    end
    else if l > 0 then
      retVal := MB_BADREC
    else
      retVal := MB_OFF;

    if retVal in [MB_TRUEREC] then
    begin
      ErrNo := 0;
      OK := True;
      P_Fish.Fish_RdrCode := StrToInt(Copy(PK, 1, 2));
      P_Fish.Keys := Ord(PK[3]) * 128 + Ord(PK[4]);
      P_Fish.Fish_Date := BeautifulDate(Copy(PK, 5, 2) + '/' +
                                        Copy(PK, 7, 2) + '/' +
                                        Copy(PK, 9, 2));
      P_Fish.Fish_Time := BeautifulTime(Copy(PK, 11, 2) + ':' +
                                        Copy(PK, 13, 2));
      P_Fish.Fish_PCode := DelLeftZero(Copy(PK, 15, 8));
      P_Fish.ManySel := 1;
      if g_options.RunDate <> P_Fish.Fish_Date then
      begin
        g_options.RunDate := P_Fish.Fish_Date;
        InitVariables(False);
      end;

      if OK then
      begin
        for i := 1 to 8 do
          P_Fish.Fish_FoodsNo[i] := 1;
        P_Fish.Fish_UCode := 0;
        P_Fish.Fish_UKhadamat := 0;
        P_Fish.Fish_UPrc := 0;
        P_Fish.Fish_UPay := 0;
        P_Fish.IsProxi := True;
        CreateFish(P_Fish, p, False);
        SaveFish(P_Fish);
      end;
      if not SendPocket('A'#$0D) then
      begin
        OK := False;
        EndWork := True;
      end;
      Inc(RecNum);
      label2.Caption := IntToStr(RecNum);
      label2.Refresh;

    end
    else if retVal in [MB_BUFFEMPTY] then
    begin
      OK := True;
      EndWork := True;
    end
    else if retVal in [MB_BUFFEMPTY] then
    begin
      EndWork := True;
      OK := True;
    end
    else if retVal in [MB_BADREC] then
    begin
      Inc(ErrNo);
      if ErrNo > 3 then
      begin
        OK := False;
        EndWork := True;
      end
      else
      begin
        if not SendPocket('N'#$0D) then
        begin
          OK := False;
          EndWork := True;
        end;
      end;
    end
    else
    begin
      OK := False;
      EndWork := True;
    end;
  end;
end;

function TfrmRelations.Z84RecoveryFirstTime(TD : String; var RecNum : Integer) : Boolean;
var
  ClockRec : TClockRecord;
  tbl : TAdoTable;
  IsFirst : Boolean;
  retVal : Byte;
  Data : String;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.ReadOnly := False;
  tbl.TableName := g_options.ClockDBS;
  tbl.Open;

  retVal := MB_OK;
  RecNum := 0;
  IsFirst := True;
  if TD = '' then TD := CurrentDate;

  repeat
    Z84_GetRecord(TD, RECOVER_ALL, IsFirst, retVal, Data);
    if retVal = MB_TRUEREC then
    begin
      with ClockRec do
      begin
        Clock_RdrCode := MicroAddress;
        Clock_RecState := StrToInt(Copy(Data, 9, 2));
        Clock_Date := BeautifulDate(Copy(Data, 11, 2) + '/' +
                                    Copy(Data, 13, 2) + '/' +
                                    Copy(Data, 15, 2));
        Clock_Time := BeautifulTime(Copy(Data, 17, 2) + ':' +
                                    Copy(Data, 19, 2));
        Clock_BarCode := Copy(Data, 21, 8);
        Clock_RecState := 0;

        tbl.Append;
        tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
        tbl.FieldByName('Clock_Date').AsString := Clock_Date;
        tbl.FieldByName('Clock_Time').AsString := Clock_Time;
        tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
        tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
        tbl.Post;
      end;
      Inc(RecNum);
      Label2.Caption := IntToStr(RecNum);
      Label2.Refresh;
      IsFirst := False;
    end;
  until retVal <> MB_TRUEREC;

  tbl.Close;
  tbl.Free;
  Z84RecoveryFirstTime := (retVal = MB_BUFFEMPTY);
end;

procedure TfrmRelations.Z80Recovery(Clk_Code : Byte; T_Date : String; var OK : Boolean; var RecNum : Integer);
var
  tbl : TAdoTable;
  n, retVal : Byte;
  IsFirst : Boolean;
  Data : String;
  ClockRec : TClockRecord;
begin
  OK := False;
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.ReadOnly := False;
  tbl.TableName := g_options.ClockDBS;
  tbl.Open;
  IsFirst := True;
  RecNum := 0;
  n := 1;

  repeat
    Z80_RecoveryOneRecord(Clk_Code, T_Date, IsFirst, retVal, Data);
    if (n <= 3) and (retVal = MB_OFF) then
      Inc(n)
    else if (n = 4) and (retVal = MB_OFF) then
    begin
      OK := False;
      Break;
    end
    else if retVal <> MB_OFF then
      n := 1;

    if retVal = MB_TRUEREC then
    begin
      with ClockRec do
      begin
        Clock_RdrCode := MicroAddress;
        Clock_RecState := StrToInt(Copy(Data, 3, 2));
        Clock_Date := BeautifulDate(Copy(Data, 5, 2) + '/' +
                                    Copy(Data, 7, 2) + '/' +
                                    Copy(Data, 9, 2));
        Clock_Time := BeautifulTime(Copy(Data, 11, 2) + ':' +
                                    Copy(Data, 13, 2));
        Clock_BarCode := Copy(Data, 15, 8);

        tbl.Append;
        while (Length(Clock_BarCode) > 0) and (Clock_BarCode[1] = '0') do Delete(Clock_BarCode, 1, 1);
        tbl.FieldByName('Clock_BarCode').AsString := Clock_BarCode;
        tbl.FieldByName('Clock_Date').AsString := Clock_Date;
        tbl.FieldByName('Clock_Time').AsString := Clock_Time;
        tbl.FieldByName('Clock_RdrCode').AsInteger := Clock_RdrCode;
        tbl.FieldByName('Clock_RecState').AsInteger := Clock_RecState;
        tbl.Post;
      end;
      Inc(RecNum);
      label2.caption := IntToStr(RecNum);
      Refresh;
      OK := True;
    end;
  until retVal = MB_BUFFEMPTY;

  if (RecNum > 0) and (retVal = MB_BUFFEMPTY) then
    OK := True;
end;


procedure TfrmRelations.MakeReaderList;
var i : Byte;
begin
  ReaderList := [];
  for i := 1 to TotalReader do
    with Readers[i] do
      if lst.Items.IndexOf(R_Name) <> -1 then
        ReaderList := ReaderList + [i];
end;

procedure TfrmRelations.cmdTicClick(Sender: TObject);
begin
  if lst.Items.IndexOf(qryReaders.FieldByname('R_Name').AsString) = -1 then
    lst.Items.Add(qryReaders.FieldByname('R_Name').AsString)
  else
    lst.Items.Delete(lst.Items.IndexOf(qryReaders.FieldByname('R_Name').AsString));
  qryReaders.Refresh;
end;

procedure TfrmRelations.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryReaders.connection := frmDBS.DBConnection;
  lblTime.Visible := False;
  txtTime.Visible := False;
  lblDate.Visible := False;
  txtDate.Visible := False;
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTimes;
end;

procedure TfrmRelations.FormActivate(Sender: TObject);
begin
  case ActionType of
    MB_RESTART:
    begin
      cmdRun.Caption := ('—«Â «‰œ«“Ì &„Ãœœ');
      Caption := ('—«Â «‰œ«“Ì „Ãœœ œ” ê«ÂÂ«');
      pnlTitle.Caption :=('‰ ÌÃÂ «— »«ÿ »« œ” ê«ÂÂ«');
      HelpContext := 408;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type <> ' + IntToStr(RDR_PROXI));
    end;

    MB_INITIAL:
    begin
      cmdRun.Caption := ('ÅÌﬂ—&»‰œÌ');
      Caption := ('ÅÌﬂ—»‰œÌ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ ÅÌﬂ—»‰œÌ œ” ê«ÂÂ«');
      HelpContext := 408;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type <> ' + IntToStr(RDR_PROXI));
    end;

    MB_TEST:
    begin
      cmdRun.Caption := (' &”  «— »«ÿ');
      Caption := (' ”  «— »«ÿ »« œ” ê«ÂÂ«');
      pnlTitle.Caption :=('‰ ÌÃÂ «— »«ÿ »« œ” ê«ÂÂ«');
      HelpContext := 404;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type <> ' + IntToStr(RDR_PROXI));
    end;

    MB_DATETIME:
    begin
      lblTime.Visible := True;
      lblDate.Visible := True;
      txtTime.Visible := True;
      txtDate.Visible := True;
      cmdRun.Caption := (' ‰&ŸÌ„');
      Caption := (' ‰ŸÌ„  «—ÌŒ Ê “„«‰ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ «—”«·  «—ÌŒ Ê “„«‰');
      tmrTime.Enabled := True;
      HelpContext := 411;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type <> ' + IntToStr(RDR_PROXI));
    end;

    MB_TBLSEND:
    begin
      cmdRun.Caption :=('«—&”«· Ãœ«Ê·');
      Caption :=('«—”«· Ãœ«Ê· »Â œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ «—”«· Ãœ«Ê· »Â œ” ê«ÂÂ«');
      HelpContext := 410;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type = ' + IntToStr(RDR_RESTZ84));
    end;

    MB_VER:
    begin
      cmdRun.Caption := ('ŒÊ«‰œ‰ ‰&”ŒÂ');
      Caption := ('ŒÊ«‰œ‰ ‰”ŒÂ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ ŒÊ«‰œ‰ ‰”ŒÂ œ” ê«ÂÂ«');
      HelpContext := 409;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type <> ' + IntToStr(RDR_PROXI));
    end;

    MB_ONLINE:
    begin
      cmdRun.Caption := (' €ÌÌ— &«— »«ÿ');
      Caption := (' €ÌÌ— Õ«·  «— »«ÿ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ  €ÌÌ— «— »«ÿ œ” ê«ÂÂ«');
      HelpContext := 407;
      chkOnLine.Visible := True;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND R_Type = ' + IntToStr(RDR_RESTZ84));
    end;

    MB_READRECS:
    begin
      cmdRun.Caption := ('&Ã„⁄ ¬Ê—Ì');
      Caption := ('Ã„⁄ ¬Ê—Ì «ÿ·«⁄«  «“ œ” ê«ÂÂ«');
      pnlTitle.Caption := ('‰ ÌÃÂ Ã„⁄ ¬Ê—Ì «ÿ·«⁄« ');
      HelpContext := 412;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND (R_Type = ' + IntToStr(RDR_RESTZ84));
      qryReaders.SQL.Add('OR R_Type = ' + IntToStr(RDR_RESTZ80)+ ')');
    end;

    MB_RECOVERY:
    begin
      cmdRun.Caption := ('&»«“Ì«»Ì');
      Caption := ('»«“Ì«»Ì «ÿ·«⁄«  ”«⁄  Õ÷Ê— Ê €Ì«»');
      pnlTitle.Caption := ('‰ ÌÃÂ »«“Ì«»Ì «ÿ·«⁄« ');
      HelpContext := 413;
      qryReaders.SQL.Clear;
      qryReaders.SQL.Add('SELECT * FROM Readers WHERE R_Active = 1');
      qryReaders.SQL.Add('AND (R_Type = ' + IntToStr(RDR_CLOCKZ80));
      qryReaders.SQL.Add('OR R_Type = ' + IntToStr(RDR_CLOCKZ84) + ')');
    end;
  end;

  qryReaders.Open;
end;

procedure TfrmRelations.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryReaders.Close;
end;

procedure TfrmRelations.qryReadersCalcFields(DataSet: TDataSet);
begin
  if lst.Items.IndexOf(qryReaders.FieldByname('R_Name').AsString) <> -1 then
    qryReaders.FieldByName('Tic').AsString := 'X'
  else
    qryReaders.FieldByName('Tic').AsString := '';
end;

procedure TfrmRelations.dbgReadersDblClick(Sender: TObject);
begin
  cmdTicClick(Sender);
end;

procedure TfrmRelations.dbgReadersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 32) then
  begin
    Key := 0;
    cmdTicClick(Sender);
  end;
end;

procedure TfrmRelations.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
   if key in ['0'..'9',#13,#8]
   then
   else key := #0;
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

procedure TfrmRelations.cmdInvertClick(Sender: TObject);
begin
  qryReaders.First;
  while not qryReaders.Eof do
  begin
    if lst.Items.IndexOf(qryReaders.FieldByname('R_Name').AsString) = -1 then
      lst.Items.Add(qryReaders.FieldByname('R_Name').AsString)
    else
      lst.Items.Delete(lst.Items.IndexOf(qryReaders.FieldByname('R_Name').AsString));
    qryReaders.Next;
  end;
  qryReaders.Refresh;
end;

procedure TfrmRelations.cmdRunClick(Sender: TObject);
var
  OK, Good : Boolean;
  i,j : Byte;
  dt,tm : String[10];
  Versionst : String;
  qry : TAdoQuery;
  RecNum : Integer;
begin
  SetUserControl;
  MakeReaderList;
  if ReaderList = [] then
    ErrorMessage('œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «” ')
  else
  begin
    case ActionType of
      MB_TEST:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              if SwitchReader(i) then
              begin
                if Readers[i].R_Type in [RDR_RESTZ84, RDR_CLOCKZ84] then
                  Comm_Test(OK)
                else if Readers[i].R_Type in [RDR_BIOLITE,RDR_BIOSTATION] then //kaveh
                  //Comm_Test(OK)
                  OK := (LinkTest_BS(Readers[i]) = BS_SUCCESS) //kaveh
                else
                  OK := Z80_LinkTest(Readers[i].R_Code);
              end
              else
                OK := False;
              Msg_NoWait;
              refresh;
              if OK then
                mmoResult.Lines.Add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' »—ﬁ—«— «” '))
              else
                mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_RESTART:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              SwitchReader(i);
              ReStart(OK);
              Msg_NoWait;
              refresh;
              if OK then
                mmoResult.Lines.Add(('œ” ê«Â ' )+ R_Name + (' —«Â «‰œ«“Ì „Ãœœ ‘œ'))
              else
                mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name +(' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_INITIAL:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              SwitchReader(i);
              InitialRdr(OK);
              Msg_NoWait;
              refresh;
              if OK then
                mmoResult.Lines.Add(('œ” ê«Â ' )+ R_Name + (' ÅÌﬂ—»‰œÌ ‘œ'))
              else
                mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name +(' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_DATETIME:
      begin
        dt := txtDate.Text;
        tm := txtTime.Text;
        good := True;
        j := StrToInt(Copy(tm, 1, 2));
        if not (j in [0..23]) then good := False;
        j := StrToInt(Copy(tm, 4, 2));
        if not (j in [0..59]) then good := False;
        j := StrToInt(Copy(tm, 7, 2));
        if not (j in [0..59]) then good := False;

        if not good then
        begin
          ErrorMessage('“„«‰ «‘ »«Â «” ');
          Exit;
        end;
        if IsTrueDate(dt) then
        begin
          dt := BeautifulDate(dt);
          txtDate.Text := dt;
        end
        else
        begin
          ErrorMessage(' «—ÌŒ «‘ »«Â «” ');
          Exit;
        end;
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList  then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              SwitchReader(i);
              if Readers[i].R_Type in [RDR_BIOLITE,RDR_BIOSTATION] then //kaveh
                OK := (SendDateTime_BS(Readers[i],dt,tm) = BS_SUCCESS) //kaveh
              else
                SendDateTime(dt, tm, OK);
              Msg_NoWait;
              refresh;
              if OK then
                mmoResult.Lines.Add((' «—ÌŒ Ê “„«‰ œ” ê«Â ' )+ R_Name + ('  ‰ŸÌ„ ‘œ'))
              else
                mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_TBLSEND:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              SwitchReader(i);
              SendTables(OK);
              Msg_NoWait;
              refresh;
              if OK then
                mmoResult.Lines.Add(('Ãœ«Ê· »Â œ” ê«Â ' )+ R_Name + (' «—”«· ‘œ'))
              else
                mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_VER:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
               Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
               SwitchReader(i);
               ReadVersion(VersionSt, OK);
               Msg_NoWait;
               refresh;
               if OK then
                 mmoResult.Lines.Add(('‰”ŒÂ œ” ê«Â ' )+ R_Name + (' ' )+ versionst)
               else
                 mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name +(' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        Mouse_NoWait;
      end;

      MB_ONLINE:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
               Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
               SwitchReader(i);
               SetOnLineMode(chkOnLine.Checked, OK);
               Msg_NoWait;
               refresh;
               if OK then
               begin
                 qry := TAdoQuery.Create(Application);
                 qry.connection := frmDBS.DBConnection;
                 qry.SQL.Clear;
                 if chkOnLine.Checked then
                   qry.SQL.Add('UPDATE Readers SET R_OnLine = 1')
                 else
                   qry.SQL.Add('UPDATE Readers SET R_OnLine = 0');
                 qry.SQL.Add('WHERE R_Code = ' + IntToStr(Readers[i].R_Code));
                 qry.ExecSQL;
                 qry.Free;
                 mmoResult.Lines.Add((' €ÌÌ— «— »«ÿ ' )+ R_Name +  (' «‰Ã«„ ‘œ'))
               end
               else
                 mmoResult.Lines.add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
            end;
        LoadReaders(False);
        Mouse_NoWait;
      end;

      MB_READRECS:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              if not R_OnLine then
              begin
                Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
                SwitchReader(i);
                if R_Type = RDR_RESTZ84 then
                  Z84_GetOffLines(OK, RecNum)
                else if R_Type = RDR_RESTZ80 then
                  Z80_GetOffLines(OK, RecNum);

                Msg_NoWait;
                refresh;
                if OK then
                begin
                  if RecNum > 0 then
                    mmoResult.Lines.Add((' ⁄œ«œ ' )+ IntToStr(RecNum) + (' —ﬂÊ—œ «“ ') + R_Name +  (' »ÿÊ— ﬂ«„· »«“Ì«»Ì ‘œ'))
                  else
                    mmoResult.Lines.Add(('«ÿ·«⁄« Ì œ— ') + R_Name + ( ' ÊÃÊœ ‰œ«—œ'))
                end
                else
                begin
                  if RecNum > 0 then
                    mmoResult.Lines.Add((' ⁄œ«œ ' )+ IntToStr(RecNum) + (' —ﬂÊ—œ «“ ') + R_Name +  (' »ÿÊ— ‰«ﬁ’ »«“Ì«»Ì ‘œ'))
                  else
                    mmoResult.Lines.Add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
                end;
              end
              else
                mmoResult.Lines.Add(('Ã„⁄ ¬Ê—Ì œ— Õ«·  OnLine «“ œ” ê«Â ' )+ R_Name + (' «„ﬂ«‰ Å–Ì— ‰Ì” .'));

            end;

        if g_options.RunDate <> CurrentDate then
        begin
          g_options.RunDate := CurrentDate;
          InitVariables(False);
        end;
        Mouse_NoWait;
      end;

      MB_RECOVERY:
      begin
        Mouse_Wait;
        mmoResult.Clear;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
              Msg_Wait(' œ—Õ«· ê—› ‰ «— »«ÿ »« ' + R_Name);
              SwitchReader(i);
              if R_Type = RDR_CLOCKZ80 then
              begin
                Z80Recovery(Readers[i].R_Code, CurrentDate, OK, RecNum);
                Delay(1000);
              end
              else if R_Type = RDR_CLOCKZ84 then
              begin
                Recoverd := Z84RecoveryFirstTime(CurrentDate, RecNum);
                OK := Recoverd;
              end;
              Msg_NoWait;
              refresh;
              if OK then
              begin
                if RecNum > 0 then
                  mmoResult.Lines.Add((' ⁄œ«œ ' )+ IntToStr(RecNum) + (' —ﬂÊ—œ «“ ') + R_Name +  (' »ÿÊ— ﬂ«„· »«“Ì«»Ì ‘œ'))
                else
                  mmoResult.Lines.Add(('«ÿ·«⁄« Ì œ— ' )+ R_Name + ( ' ÊÃÊœ ‰œ«—œ'))
              end
              else
              begin
                if RecNum > 0 then
                  mmoResult.Lines.Add((' ⁄œ«œ ' )+ IntToStr(RecNum) + (' —ﬂÊ—œ «“ ') + R_Name +  (' »ÿÊ— ‰«ﬁ’ »«“Ì«»Ì ‘œ'))
                else
                  mmoResult.Lines.Add(('«— »«ÿ »« œ” ê«Â ' )+ R_Name + (' ﬁÿ⁄ „Ìù»«‘œ'));
              end;
            end;

        if g_options.RunDate <> CurrentDate then
        begin
          g_options.RunDate := CurrentDate;
          InitVariables(False);
        end;
        Mouse_NoWait;
      end;
    end;
  end;
  USERCONTROL := false;
end;


end.
