unit PicRec;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Globals, Buttons, Grids, ComCtrls, RunCmnds, DB,
  ADODB, MPlayer;

type
  TfrmPictureRec = class(TForm)
    pnlPicture: TPanel;
    Timer1: TTimer;
    cmdExit: TBitBtn;
    lblRec: TLabel;
    imgPicture: TImage;
    grdRecs: TStringGrid;
    lbl1: TLabel;
    prgBar: TProgressBar;
    lblConnect: TLabel;
    adotblRecs: TADOQuery;
    lblCredit: TLabel;
    mp: TMediaPlayer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
  private
    { Private declarations }
    R_Idx,
    ErrCount : Byte;
    rdrIdx : array[1..CNST_MAX_READER] of Byte;
    RecNo, ErrRecNo : Integer;
    ErrRec : Boolean;
    LastRec : Integer;
    ViewLastRec : boolean;
    Currdate : string;

    procedure SetWinF;
    procedure InitialGridCels;
    procedure Z84GetRecord(rdrInfo : TReaders);
    procedure Z80GetRecord(rdrInfo : TReaders);
    procedure ViewRecord(p : TPerson; ClkRec : TTerminalRec);
    procedure ViewSymbol(IsRec : Boolean);
    Procedure InitDB;
  public
    { Public declarations }

    rdrIdxSet : Set of 0..255;
    permanent : Boolean;
    ViewFromDB : Boolean;
  end;


implementation

uses
  DBS, Z84_CMD, Z80_CMD, ComTools, TimeTool,DateProc, Funcs, TCP_UDP;


{$R *.DFM}




procedure TfrmPictureRec.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmPictureRec.InitialGridCels;
begin
  grdRecs.FixedCols := 0;
  grdRecs.ColCount := 5;
  grdRecs.RowCount := 2;

  grdRecs.Cols[0].Add(('ÊÑãíäÇá'));
  grdRecs.ColWidths[0] := 50;


  grdRecs.Cols[1].Add(('   ÔãÇÑå ßÇÑÊ'));
  grdRecs.ColWidths[1] := 90;

  grdRecs.Cols[2].Add(('   æÖÚíÊ'));
  grdRecs.ColWidths[2] := 70;

  grdRecs.Cols[3].Add((' äÇã ÎÇäæÇÏí - äÇã'));
  grdRecs.ColWidths[3] := 115;

  grdRecs.Cols[4].Add(('  ÒãÇä'));
  grdRecs.ColWidths[4] := 50;
end;


procedure TfrmPictureRec.ViewSymbol(IsRec : Boolean);
begin
  if IsRec then
  begin
    if not ErrRec then
      Inc(RecNo)
    else
      Inc(ErrRecNo);
    lblRec.Caption := IntToStr(RecNo) + (':ÕÍíÍ  ') + IntToStr(ErrRecNo) + (':ÎØÇ');
  end;
  if prgBar.Position + 2 > 100 then
    prgBar.Position := 0
  else
    prgBar.Position := prgBar.Position + 2;
end;

procedure TfrmPictureRec.ViewRecord(p : TPerson; ClkRec : TTerminalRec);
var
  r : Integer;
  i : Byte;
  outofdate:boolean;
begin
  if RecNo = 1 then
    r := 1
  else
  begin
    if grdRecs.RowCount = 100 then
    begin
      for i := 2 to grdRecs.RowCount do
        grdRecs.Rows[i-1] := grdRecs.Rows[i];
      r := grdRecs.RowCount - 1;
    end
    else
    begin
      r := grdRecs.RowCount;
      grdRecs.RowCount := grdRecs.RowCount + 1;
    end;
  end;

  grdRecs.Cells[0, r] := IntToStr(Readers[rdrIdx[R_Idx]].R_Code);
  grdRecs.Cells[1, r] := DelLeftZero(ClkRec.rdrCardCode);
  grdRecs.Cells[2, r] := GetPishCardFullName(ClkRec.rdrStatus);
  grdRecs.Cells[3, r] := p.P_Family + '-' + p.P_Name;
  grdRecs.Cells[4, r] := IntToTime(ClkRec.rdrTime);
  if (p.P_endJobDate<>'') and (p.P_endJobDate<currentdate)
  then begin
      outofdate:=true;
      grdRecs.Cells[5, r] := 'ÝÇÞÏ ÇÚÊÈÇÑ';//p.P_endJobDate+' *|||*';
  end
  else begin
      outofdate:=false;
      grdRecs.Cells[5, r] := p.P_endJobDate;
  end;
  if FileExists(p.P_Picture)
  then begin
    imgPicture.Picture.LoadFromFile(p.P_Picture);
    lblCredit.Visible := outofdate;
  end
  else
    imgPicture.Picture.Bitmap := nil;
  grdRecs.Row := r;
  if outofdate
  then with MP do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'credit.WAV';
    Open;
    Play;
  end;
end;

procedure TfrmPictureRec.Z84GetRecord(rdrInfo : TReaders);
var
  getVal : Byte;
  PK, DT : String;
  ClkRec : TTerminalRec;
  p : TPerson;
  isSent : boolean;
begin
  DT := CurrentDate;
  if permanent then
    Z84_MakePocket(PK, rdrInfo.R_Code, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2))
  else
    Z84_MakePocket(PK, rdrInfo.R_Code, $02, 0, '');

  if rdrInfo.r_IsCom then
    isSent := SendPocket(pk)
  else if not rdrInfo.r_IsCom and rdrInfo.r_TCP then
    isSent := TCPSendData(pk, rdrInfo.r_IP)
  else if not rdrInfo.r_IsCom and not rdrInfo.r_TCP then
    isSent := UDPSendData(pk, rdrInfo.r_IP)
  else
    isSent := False;

  if isSent then
  begin
    if rdrInfo.r_IsCom then
      Z84_GetPocket(pk, 30, 100, getVal)
    else if not rdrInfo.r_IsCom and rdrInfo.r_TCP then
      TCPReadData(pk, getVal)
    else if not rdrInfo.r_IsCom and not rdrInfo.r_TCP then
      UDPReadData(pk, getVal)
    else
      getVal := ERR_OFF;
    if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
    begin
      case Ord(PK[4]) of
        3: //Buffer Empty
        begin
          ViewSymbol(False);
          lblConnect.Caption := '';
          ErrCount := 0;
        end;

        4: //Record Exists
        begin
          ClkRec := Z84_AnalizeData(PK, ErrRec);
          p := GetPerson(ClkRec.rdrCardCode, True);
          if p.P_BarCode = '' then
            p := GetPerson(ClkRec.rdrCardCode, False);

          if p.P_BarCode <> '' then
            ClkRec.rdrCardCode := p.P_BarCode;

          Z84_MakePocket(PK, rdrInfo.R_Code, $06, 0, '');

          if rdrInfo.r_IsCom then
            isSent := SendPocket(pk)
          else if not rdrInfo.r_IsCom and rdrInfo.r_TCP then
            isSent := TCPSendData(pk, rdrInfo.r_IP)
          else if not rdrInfo.r_IsCom and not rdrInfo.r_TCP then
            isSent := UDPSendData(pk, rdrInfo.r_IP)
          else             
            isSent := False;

          if isSent then
            if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
            //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
            begin
              ViewSymbol(True);
              ViewRecord(p, ClkRec);
            end;

          lblConnect.Caption := '';
          ErrCount := 0;
        end;
      end;
    end
    else if getVal = ERR_OFF then
    begin
      if ErrCount < 254 then
        Inc(ErrCount);
      if ErrCount > 50 then
        lblConnect.Caption := ('ÇÑÊÈÇØ ÞØÚ')
      else
        lblConnect.Caption := '';
    end;
  end;
end;

procedure TfrmPictureRec.Z80GetRecord(rdrInfo : TReaders);
var
  n, retVal : Byte;
  Data : String;
  ClkRec : TTerminalRec;
  p : TPerson;
  PK : String;
  l, i, chkSum : Byte;
begin
  if not Z80_LinkTest then
    retVal := ERR_OFF
  else
  begin
    if not SendPocket('D'#$0D) then
      retVal := ERR_OFF
    else
    begin
      Z80_GetPocket(PK, 25, 40);
      l := Length(PK);
      if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      begin
        retVal := MB_BUFFEMPTY;
        ViewSymbol(False);
        lblConnect.Caption := '';
        ErrCount := 0;
      end
      else if l = 25 then
      begin
        chkSum := 0;
        for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
        chkSum := (chkSum AND $7F);
        if chkSum <> Ord(PK[25]) then
          retVal := MB_BADREC
        else
        begin
          retVal := MB_TRUEREC;
          Data := Copy(PK, 1, 22);
          ClkRec := Z80_AnalizeData(Data, p, ErrRec);
          if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
          //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
          begin
            ViewSymbol(True);
            ViewRecord(p, ClkRec);
          end;
          lblConnect.Caption := '';
          ErrCount := 0;
        end;
      end
      else if l > 0 then
        retVal := MB_BADREC
      else
      begin
        retVal := ERR_OFF;
        if ErrCount < 254 then
          Inc(ErrCount);
        if ErrCount > 50 then
          lblConnect.Caption := ('ÇÑÊÈÇØ ÞØÚ')
        else
          lblConnect.Caption := '';
      end;
    end;
  end;

  n := 0;
  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    if retVal = MB_TRUEREC then
      PK := 'A'#$0D
    else
      PK := 'N'#$0D;

    if not SendPocket(PK) then
      retVal := ERR_OFF
    else
    begin
      Z80_GetPocket(PK, 25, 40);
      l := Length(PK);
      if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
      begin
        retVal := MB_BUFFEMPTY;
        ViewSymbol(False);
        lblConnect.Caption := '';
        ErrCount := 0;
      end
      else if l = 25 then
      begin
        chkSum := 0;
        for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
        chkSum := (chkSum AND $7F);
        if chkSum <> Ord(PK[25]) then
          retVal := MB_BADREC
        else
        begin
          retVal := MB_TRUEREC;
          Data := Copy(PK, 1, 22);
          ClkRec := Z80_AnalizeData(Data, p, ErrRec);
          if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
          //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
          begin
            ViewSymbol(True);
            ViewRecord(p, ClkRec);
          end;
          lblConnect.Caption := '';
          ErrCount := 0;
        end;
      end
      else if l > 0 then
        retVal := MB_BADREC
      else
      begin
        retVal := ERR_OFF;
        if ErrCount < 254 then
          Inc(ErrCount);
        if ErrCount > 50 then
          lblConnect.Caption := ('ÇÑÊÈÇØ ÞØÚ')
        else
          lblConnect.Caption := '';
      end;
    end;

    if retVal in [ERR_OFF, MB_BADREC] then Inc(n);
  end;
end;



procedure TfrmPictureRec.FormCreate(Sender: TObject);
begin
  SetWinF;
  OpenClockDBS(CurrentDate);
  R_Idx := 1;
  RecNo := 0;
  ErrRecNo := 0;
  lblRec.Caption := '0';
  InitialGridCels;
  lblConnect.Caption := '';
  ErrCount := 0;
  initDB;
end;

procedure TfrmPictureRec.FormActivate(Sender: TObject);
var
  i, j : Byte;
begin
  for i := 1 to CNST_MAX_READER do
      rdrIdx[i] := 0;
  j := 1;
  for i := 1 to TotalReader do
    if i in rdrIdxSet then
    begin
      rdrIdx[j] := i;
      Inc(j);
    end;
end;

procedure TfrmPictureRec.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CloseClockDBS;
end;

procedure TfrmPictureRec.Timer1Timer(Sender: TObject);
var
  ClkRec : TTerminalRec;
  p : TPerson;
  isTrue : boolean;
begin
  if ViewFromDB then
  begin
    if Currdate <> CurrentDate then
      InitDB;
    with adotblRecs do
    begin
      Requery([eoAsyncFetch	]);
      if LastRec <> -1 then
        RecNo := LastRec;
      if RecordCount = 0 then Exit;
      if (RecNo < RecordCount) or ((RecNo = RecordCount) and (not ViewLastRec)) then
        begin
          Next;
          ClkRec.rdrCardCode := FieldByName('Clock_BarCode').AsString;
          ClkRec.rdrDate := FieldByName('Clock_Date').AsString;
          ClkRec.rdrTime := FieldByName('Clock_Time').AsInteger;
          ClkRec.rdrCode := FieldByName('Clock_RdrCode').AsInteger;
          ClkRec.rdrStatus := FieldByName('Clock_RecState').AsInteger;
          p := GetPerson(ClkRec.rdrCardCode, false);
          if p.P_BarCode = '' then
            p := GetPerson(ClkRec.rdrCardCode, True);

          if p.P_BarCode <> '' then
            ClkRec.rdrCardCode := p.P_BarCode;
          ViewSymbol(True);
          ViewRecord(p, ClkRec);
          lblConnect.Caption := '';
          if (RecNo = RecordCount) then ViewLastRec := True;
          if (RecNo < RecordCount) then ViewLastRec := False;
          LastRec := RecNo;
        end;
    end;
  end
  else if not ViewFromDB then
  begin
    if Readers[rdrIdx[R_Idx]].r_IsCom then
    begin
      if  ComPortInitial(Readers[rdrIdx[R_Idx]]) then
        isTrue := true
      else
        isTrue := false;
    end
    else
      isTrue := true;


    if isTrue then
      if Readers[rdrIdx[R_Idx]].R_Type = RDR_CLK6000 then
        Z84GetRecord(Readers[rdrIdx[R_Idx]])
      else
        Z80GetRecord(Readers[rdrIdx[R_Idx]]);

    Inc(R_Idx);
    if (R_Idx > TotalReader) or
       (rdrIdx[R_Idx] = 0) then
      R_Idx := 1
  end;
end;

procedure TfrmPictureRec.cmdExitClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TfrmPictureRec.InitDB;
var
  tblName : string;
begin
  CurrDate := CurrentDate;
  InitialGridCels;
  with adotblRecs do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    {$ifdef Z84SDK}
    tblName := GhadirIO;
    {$else}
    tblName := 'C' + copy(Currdate,1,4) + copy(Currdate,6,2);
    {$endif}

    SQL.Add('select * from ' + tblName + ' where Clock_Date = ''' + Currdate + '''');

    SQL.Add('and Clock_Time >= ' + IntToStr(TimeToInt(CurrentTime)));
    SQL.Add('and Clock_chg = 0');
    Open;
    Last;
    LastRec := RecNo;
    ViewLastRec := false;
  end;
end;

end.
