unit PicRecs;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Globals, Buttons, ComCtrls, RunCmnds, DB, ADODB, MPlayer;

type
  TfrmAnyPictureRec = class(TForm)
    pnl3: TPanel;
    img3: TImage;
    pnl2: TPanel;
    img2: TImage;
    pnl1: TPanel;
    img1: TImage;
    lbl1_1: TLabel;
    pnl8: TPanel;
    img8: TImage;
    pnl7: TPanel;
    img7: TImage;
    pnl6: TPanel;
    img6: TImage;
    pnl5: TPanel;
    img5: TImage;
    lbl2_1: TLabel;
    lbl3_1: TLabel;
    lbl4_1: TLabel;
    lbl5_1: TLabel;
    lbl6_1: TLabel;
    lbl7_1: TLabel;
    lbl8_1: TLabel;
    lbl1: TLabel;
    lblRecNo: TLabel;
    lbl1_2: TLabel;
    lbl2_2: TLabel;
    lbl3_2: TLabel;
    lbl4_2: TLabel;
    lbl5_2: TLabel;
    lbl6_2: TLabel;
    lbl7_2: TLabel;
    lbl8_2: TLabel;
    lblConnect: TLabel;
    pn4: TPanel;
    img4: TImage;
    prgBar: TProgressBar;
    Timer1: TTimer;
    adotblRecs: TADOQuery;
    lblCredit1: TLabel;
    lblCredit3: TLabel;
    lblCredit2: TLabel;
    lblCredit4: TLabel;
    lblCredit5: TLabel;
    lblCredit6: TLabel;
    lblCredit7: TLabel;
    lblCredit8: TLabel;
    mp: TMediaPlayer;
    lbl1_3: TLabel;
    lbl2_3: TLabel;
    lbl3_3: TLabel;
    lbl4_3: TLabel;
    lbl5_3: TLabel;
    lbl6_3: TLabel;
    lbl7_3: TLabel;
    lbl8_3: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    RecNo, ErrRecNo : Integer;
    ErrRec : Boolean;
    R_Idx, Pic_Idx,
    ErrCount : Byte;
    rdrIdx : array[1..CNST_MAX_READER] of Byte;
    img : array[1..8] of TImage;
    lbl : array[1..24] of TLabel;
    LastRec : Integer;
    ViewLastRec : boolean;
    Currdate : string;

    procedure SetWinF;
    procedure ViewSymbol(IsRec : Boolean);
    procedure ViewRecord(p : TPerson; ClkRec : TTerminalRec);
    procedure Z84GetRecord(rdrInfo : TReaders);
    procedure Z80GetRecord(rdrInfo : TReaders);
    Procedure InitDB;

  public
    { Public declarations }

    rdrIdxSet  : Set of 0..255;
    permanent  : Boolean;
    ViewFromDB : Boolean;
  end;
var
  tmrBusy : Boolean = false;

implementation

uses
  DBS, Z84_CMD, Z80_CMD, ComTools, TimeTool,DateProc, Funcs, TCP_UDP;


{$R *.DFM}


procedure TfrmAnyPictureRec.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
end;

procedure TfrmAnyPictureRec.ViewSymbol(IsRec : Boolean);
begin
  if IsRec then
  begin
    if not ErrRec then
      Inc(RecNo)
    else
      Inc(ErrRecNo);
    lblRecNo.Caption := IntToStr(RecNo) + (':ÕÍíÍ  ') + IntToStr(ErrRecNo) + (':ÎØÇ');
  end;

  if prgBar.Position + 2 > 100 then
    prgBar.Position := 0
  else
    prgBar.Position := prgBar.Position + 2;
end;

procedure TfrmAnyPictureRec.ViewRecord(p : TPerson; ClkRec : TTerminalRec);
var
   outofdate:boolean;
   myRect: TRect;
begin
  if Pic_Idx <> 0 then
  begin
    lbl[Pic_Idx].Font.Color := clBlue;
    lbl[Pic_Idx+8].Font.Color := clBlue;
    lbl[Pic_Idx+16].Font.Color := clBlue;
  end;
  Inc(Pic_Idx);
  if Pic_Idx = 9 then Pic_Idx := 1;

  if p.P_BarCode = '' then
  begin
    lbl[Pic_Idx].Caption := ClkRec.rdrCardCode;
    lbl[Pic_Idx].BiDiMode := bdLeftToRight;
  end
  else
  begin
    outofdate:=(p.P_endJobDate<>'') and (p.P_endJobDate<currentdate);
    lbl[Pic_Idx].Caption := p.P_Name + '-' + p.P_Family;
    if outofdate then lbl[Pic_Idx].Caption := lbl[Pic_Idx].Caption+'*||||*';
    lbl[Pic_Idx].BiDiMode := bdRightToLeft;
  end;
  lbl[Pic_Idx+8].Caption := ('ÏÑÈ:') + IntToStr(ClkRec.rdrCode) + ('    ÒãÇä:') + IntToTime(ClkRec.rdrTime);
//  lbl[Pic_Idx+16].Caption := GetPishCardFullName(ClkRec.rdrStatus);
  if FileExists(p.P_Picture)
  then begin
    img[Pic_Idx].Picture.LoadFromFile(p.P_Picture);
    case Pic_Idx of
      1 : lblCredit1.Visible := outofdate;
      2 : lblCredit2.Visible := outofdate;
      3 : lblCredit3.Visible := outofdate;
      4 : lblCredit4.Visible := outofdate;
      5 : lblCredit5.Visible := outofdate;
      6 : lblCredit6.Visible := outofdate;
      7 : lblCredit7.Visible := outofdate;
      8 : lblCredit8.Visible := outofdate;
    end;
  end
  else
    img[Pic_Idx].Picture.Bitmap := nil;

  lbl[Pic_Idx].Font.Color := clRed;
  lbl[Pic_Idx+8].Font.Color := clRed;
  lbl[Pic_Idx+16].Font.Color := clRed;
  if outofdate
  then with MP do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'credit.WAV';
    Open;
    Play;
  end;
end;

procedure TfrmAnyPictureRec.Z84GetRecord(rdrInfo : TReaders);
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
//          p := GetPerson(ClkRec.rdrCardCode, True);
//          if p.P_BarCode = '' then
//            p := GetPerson(ClkRec.rdrCardCode, false);

//          if p.P_BarCode <> '' then
//            ClkRec.rdrCardCode := p.P_BarCode;
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
//            if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
            //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
            begin
              ViewSymbol(True);
              ViewRecord(p, ClkRec);
            end;
          lblConnect.Caption := '';
          ErrCount := 0;
        end;

        else //Error in read data
        begin
          Z84_MakePocket(PK, rdrInfo.R_Code, $15, 0, '');

          if rdrInfo.r_IsCom then
            isSent := SendPocket(pk)
          else if not rdrInfo.r_IsCom and rdrInfo.r_TCP then
            isSent := TCPSendData(pk, rdrInfo.r_IP)
          else if not rdrInfo.r_IsCom and not rdrInfo.r_TCP then
            isSent := UDPSendData(pk, rdrInfo.r_IP)
          else
            isSent := False;
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
//
//procedure TfrmAnyPictureRec.Z80GetRecord(rdrInfo : TReaders);
//var
//  n, retVal : Byte;
//  Data : String;
//  ClkRec : TTerminalRec;
//  p : TPerson;
//  PK : String;
//  l, i, chkSum : Byte;
//begin
//  if not Z80_LinkTest then
//    retVal := ERR_OFF
//  else
//  begin
//    if not SendPocket('D'#$0D) then
//      retVal := ERR_OFF
//    else
//    begin
//      Z80_GetPocket(PK, 25, 40);
//      l := Length(PK);
//      if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
//      begin
//        retVal := MB_BUFFEMPTY;
//        ViewSymbol(False);
//        lblConnect.Caption := '';
//        ErrCount := 0;
//      end
//      else if l = 25 then
//      begin
//        chkSum := 0;
//        for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
//        chkSum := (chkSum AND $7F);
//        if chkSum <> Ord(PK[25]) then
//          retVal := MB_BADREC
//        else
//        begin
//          retVal := MB_TRUEREC;
//          Data := Copy(PK, 1, 22);
////          ClkRec := Z80_AnalizeData(Data, p, ErrRec);
//          if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
//          //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
//          begin
//            ViewSymbol(True);
//            ViewRecord(p, ClkRec);
//          end;
//          lblConnect.Caption := '';
//          ErrCount := 0;
//        end;
//      end
//      else if l > 0 then
//        retVal := MB_BADREC
//      else
//      begin
//        retVal := ERR_OFF;
//        if ErrCount < 254 then
//          Inc(ErrCount);
//        if ErrCount > 50 then
//          lblConnect.Caption := ('ÇÑÊÈÇØ ÞØÚ')
//        else
//          lblConnect.Caption := '';
//      end;
//    end;
//  end;
//
//  n := 0;
//  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
//  begin
//    if retVal = MB_TRUEREC then
//      PK := 'A'#$0D
//    else
//      PK := 'N'#$0D;
//
//    if not SendPocket(PK) then
//      retVal := ERR_OFF
//    else
//    begin
//      Z80_GetPocket(PK, 25, 40);
//      l := Length(PK);
//      if (l = 3) and (Pos('E'#$0D#$0A, PK) <> 0) then
//      begin
//        retVal := MB_BUFFEMPTY;
//        ViewSymbol(False);
//        lblConnect.Caption := '';
//        ErrCount := 0;
//      end
//      else if l = 25 then
//      begin
//        chkSum := 0;
//        for i := 1 to 22 do Inc(chkSum, Ord(PK[i]));
//        chkSum := (chkSum AND $7F);
//        if chkSum <> Ord(PK[25]) then
//          retVal := MB_BADREC
//        else
//        begin
//          retVal := MB_TRUEREC;
//          Data := Copy(PK, 1, 22);
//          ClkRec := Z80_AnalizeData(Data, p, ErrRec);
//          if SaveClockRecord(ClkRec, REC_TEST, ErrRec) then
//          //SaveClockRecord(ClkRec, REC_TEST, ErrRec);
//          begin
//            ViewSymbol(True);
//            ViewRecord(p, ClkRec);
//          end;
//          lblConnect.Caption := '';
//          ErrCount := 0;
//        end;
//      end
//      else if l > 0 then
//        retVal := MB_BADREC
//      else
//      begin
//        retVal := ERR_OFF;
//        if ErrCount < 254 then
//          Inc(ErrCount);
//        if ErrCount > 50 then
//          lblConnect.Caption := ('ÇÑÊÈÇØ ÞØÚ')
//        else
//          lblConnect.Caption := '';
//      end;
//    end;
//
//    if retVal in [ERR_OFF, MB_BADREC] then Inc(n);
//  end;
//end;
//

procedure TfrmAnyPictureRec.FormCreate(Sender: TObject);
var
  i : Byte;
  dt,tm : string;
begin
  lblConnect.Caption := '';
  ErrCount := 0;
//  OpenClockDBS(CurrentDate);
  lblRecNo.Caption := '';
  R_Idx := 1;
  Pic_Idx := 0;
  RecNo := 0;
  ErrRecNo := 0;
  img[1] := img1;
  img[2] := img2;
  img[3] := img3;
  img[4] := img4;
  img[5] := img5;
  img[6] := img6;
  img[7] := img7;
  img[8] := img8;

  lbl[1] := lbl1_1;
  lbl[9] := lbl1_2;
  lbl[17]:= lbl1_3;
  lbl[2] := lbl2_1;
  lbl[10]:= lbl2_2;
  lbl[18]:= lbl2_3;
  lbl[3] := lbl3_1;
  lbl[11]:= lbl3_2;
  lbl[19]:= lbl3_3;
  lbl[4] := lbl4_1;
  lbl[12]:= lbl4_2;
  lbl[20]:= lbl4_3;
  lbl[5] := lbl5_1;
  lbl[13]:= lbl5_2;
  lbl[21]:= lbl5_3;
  lbl[6] := lbl6_1;
  lbl[14]:= lbl6_2;
  lbl[22]:= lbl6_3;
  lbl[7] := lbl7_1;
  lbl[15]:= lbl7_2;
  lbl[23]:= lbl7_3;
  lbl[8] := lbl8_1;
  lbl[16]:= lbl8_2;
  lbl[24]:= lbl8_3;
  for i := 1 to 24 do lbl[i].Caption := '';
  InitDB;
end;

procedure TfrmAnyPictureRec.FormActivate(Sender: TObject);
var
  i, j : Byte;
begin
  LoadReaders;
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

procedure TfrmAnyPictureRec.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CloseClockDBS;
end;

procedure TfrmAnyPictureRec.Timer1Timer(Sender: TObject);
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

procedure TfrmAnyPictureRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
  begin
    Timer1.Enabled := False;
    Close;
  end;
end;
procedure TfrmAnyPictureRec.InitDB;
var
  tblName : string;
begin
  CurrDate := CurrentDate;
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
