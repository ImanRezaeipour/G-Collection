unit On_line;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,StdCtrls,
  globals,tcp_udp,adoDb, GHSDK_TLB,db, StrUtils;

type
  TfrmOnline = class(TForm)
    tmrRdr: TTimer;
    Label1: TLabel;
    Timer1: TTimer;
    tmrSetRdrTimeDate: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrRdrTimer(Sender: TObject);
    procedure ControlReader;
    procedure GetOnlineRecord(var OK : Boolean);
    procedure CutPrint(var OK : Boolean; P_Fish : TFish);
    function  makeStringCutPrint() : string;
    procedure PrintToReader(ST : String; DblWidth, Clr : Boolean; var OK : Boolean; P_Fish : TFish; printNow : Boolean = False; notInsert : Boolean = False);
    procedure RestZ84OnLine(var P_Fish : TFish; var OK : Boolean{$ifdef RestService}; var iRest_ID : Integer{$endif RestService});
    function  Z80PrnFormat(ST : String; Rev, DblWidth, Clr : Boolean) : String;
    procedure RestZ80OnLine(var P_Fish : TFish; var OK : Boolean);
    procedure LoadFishsNo(TDate : String);
    procedure Timer1Timer(Sender: TObject);
    procedure clearIFish(var i_Fish : TFish);
    function  compare2Fishs(i_Fish1 : TFish; i_Fish2 : TFish) : Boolean;
    procedure tmrSetRdrTimeDateTimer(Sender: TObject);

    procedure RestBSOnLine(var P_Fish : TFish; var OK : Boolean);

  private
    { Private declarations }
    DTTM4ReadOnline : string; //kaveh
    fstSetDT_BS : Boolean;
  public
    frmTcpUdp: TfrmTcpUdp;
    rdr : TReaders;
    Rdr_Sobh_Fish_No,
    Rdr_Nahar_Fish_No,
    Rdr_Sham_Fish_No,
    Rdr_SOBHNEXT_Fish_No  : Integer;
    bigST : string; //kaveh
    Last_Fish : TFish; //kaveh
    Last_Rest_ID : Integer; //kaveh
    {$ifdef GHSDK}
    mtt : MTT5000;
    state : integer;
    waiting : integer;
    LastRecord : string;
    CurrentRecord : string;
    {$endif}
    function SwitchReader(var rdr : TReaders) : Boolean;
  end;


implementation
uses
  main,ertebat,cntroler,rdrstat,ClckRecs,
  dateProc,dbs_proc,FishLst,msgs,Code_Sys,Z80_CMD, ComTools, BioStation;

{$R *.dfm}

procedure TfrmOnline.tmrRdrTimer(Sender: TObject);
begin
    if F_Params.CollectUser = '' then
      F_Params.CollectUser := 'ADMIN';
    if UpperCase(g_Options.UserName) = F_Params.CollectUser then
    begin
      if fstSetDT_BS then
      begin
        fstSetDT_BS := False;
        SendDateTime_BS(rdr{rdrReadOnline},CurrentDate,CurrentTimes); //kaveh
      end;
      ControlReader;
    end;
end;

procedure TfrmOnline.tmrSetRdrTimeDateTimer(Sender: TObject);
var
  DT,TM:String;
  OK : Boolean;
  PK : String;
  STAT: Byte;
begin
  DT := CurrentDate;
  TM := CurrentTimes;
  //SendDateTime(CurrentDate, CurrentTimes, OK);
  //SetUserControl;
  OK := True;
  MakePocket(PK, rdr.r_code, $0B, 0,
             DT[3]+DT[4]+DT[6]+DT[7]+DT[9]+DT[10]+
             TM[1]+TM[2]+TM[4]+TM[5]+TM[7]+TM[8]);

  if not SendPocket(self,PK) then
  begin
    OK := False;
    rdr.RdrState := '*****';
  end
  else
  begin
//    GetPocket(PK, True, STAT);
    GetPocket(self,PK, True, STAT);
//    if (STAT = 0) and (length(pk)>3) then
    if Length(pk)>3 then
    begin
      if (STAT = 0) and (Ord(PK[3]) = rdr.r_code) then
      begin

        case Ord(PK[4]) of
          $15: OK := False;
          6  : OK := True;
        end;

      end
      else
        OK := False;      
    end
    else
    begin
      OK := False;
      rdr.RdrState := '*****';
    end;
  end;

//  UserControl := False;

end;

procedure TfrmOnline.ControlReader;
var
  i, j : Byte;
  OK : Boolean;
  RecNum : Integer;
  tm : string;
begin
   if (g_options.RunDate <> CurrentDate) then
  begin
    g_options.RunDate := CurrentDate;
    InitVariables(False);
  end;

  if not USERCONTROL then
  begin
    try
      inc(AUTOCONTROL);
      begin
        with rdr do
        begin
          if R_Active and R_Online {and (R_Type in [RDR_RESTZ84, RDR_RESTZ80])} then
          begin
  //          if RdrGood = 0 then
            if (R_Type in [RDR_RESTZ84, RDR_RESTZ80]) then //kaveh
            begin
              ok := false;
              if F_Params.OffOutTime = MB_TRUE then
              begin
                tm := CurrentTime;
                if ((tm >= F_Params.FromSobh) and (tm <= F_Params.ToSobh)) or ((tm >= F_Params.FromNahar) and (tm <= F_Params.ToNahar)) or ((tm >= F_Params.FromSham) and (tm <= F_Params.ToSham)) then
                begin
                  if not frmMain.userDiscard then
                    ok := true;
                end;
              end
              else
                ok := true;
              if ok then
              begin
                if {$ifdef GHSDK} true {$else GHSDK} {$ifdef RestService}true {$else RestService} SwitchReader(rdr){$endif RestService}{$endif GHSDK} then
                begin
                  GetOnlineRecord(OK);
                  rdr.RdrState := ('برقرار');
                end
                else
                begin
                  rdr.RdrState := '*****';
                end;
                frmReaderState.ViewLastInOut(rdr);
              end;
            end
  //          else
  //            Dec(RdrGood);
            //kaveh is
            else if (R_Type in [RDR_BIOLITE, RDR_BIOSTATION, RDR_XSTATION]) then
            begin
              ok := false;
              if F_Params.OffOutTime = MB_TRUE then
              begin
                tm := CurrentTime;
                if ((tm >= F_Params.FromSobh) and (tm <= F_Params.ToSobh)) or ((tm >= F_Params.FromNahar) and (tm <= F_Params.ToNahar)) or ((tm >= F_Params.FromSham) and (tm <= F_Params.ToSham)) then
                begin
                  if not frmMain.userDiscard then
                    ok := true;
                end;
              end
              else
                ok := true;
              if ok then
              begin
                if True {SwitchReader(rdr)} then
//                Result := Connect_BS(rdr);
                begin
                  GetOnlineRecord(OK);
                  rdr.RdrState := ('برقرار');
                end
                else
                begin
                  rdr.RdrState := '*****';
                end;
                frmReaderState.ViewLastInOut(rdr);
              end;
            end;
            //kaveh ie
          end
          {$region 'clock'}
          else if R_Active and (R_Type in [RDR_CLOCKZ84, RDR_CLOCKZ80]) then
          begin
            if SwitchReader(rdr) then
            begin
              if not Recoverd and (OffClock_N < 5) then
              begin
                frmMain.StatusBar.Panels[3].Text := ('بازيابي از ') + rdr.R_Name;
                frmMain.StatusBar.Refresh;
                Recoverd := RecoveryFirstTime(R_Type, CurrentDate, RecNum);
                if not Recoverd then
                  Inc(OffClock_N)
                else
                begin
                  OffClock_N := 0;
  //                Delay(1000);
                end;
                frmMain.StatusBar.Panels[3].Text := g_options.CoName;
                if g_options.Shobeh <> '' then
                  frmMain.StatusBar.Panels[3].Text := frmMain.StatusBar.Panels[3].Text + '-' +
                                                      g_options.Shobeh;
              end
              else if not Recoverd and (OffClock_N = 5) then
                frmMain.StatusBar.Panels[3].Text := ('ارتباط با ') + R_Name + (' قطع مي باشد.')
              else if (F_Params.ClockOnLine = MB_TRUE) then
              begin
                if SycleTime = 0 then
                begin
                  frmMain.StatusBar.Panels[3].Text := ('بازيابي ركورد جديد از ') + rdr.R_Name;
                  frmMain.StatusBar.Refresh;
                  RecoveryNewRecords(R_Type, CurrentDate, RecNum);
                  SycleTime := F_Params.ClockCycle;

                  frmMain.StatusBar.Panels[3].Text := g_options.CoName;
                  if g_options.Shobeh <> '' then
                    frmMain.StatusBar.Panels[3].Text := frmMain.StatusBar.Panels[3].Text + '-' +
                                                        g_options.Shobeh;
                end
                else
                  Dec(SycleTime);
              end;
            end
            else
              rdr.R_Active := False;
              exit;
            end;
          {$endregion 'clock'}
        end;
      end;
    finally
      dec(AUTOCONTROL);
    end;
  end;
end;

function TfrmOnline.SwitchReader(var rdr : TReaders) : Boolean;
var i : Byte;
begin
  with rdr do
  begin
  {$ifdef GHSDK}
  IF mtt.MediaAssign then
    mtt.Media._Release;
  mtt.TerminalAddress := R_Code;
  if R_IsCom then
    mtt.CreateSerialMedia('com' + inttostr(r_port),38400)
  else
    mtt.CreateNetworkMedia(R_IP);
  mtt.Media.LogPath := 'f:\\';
  mtt.Media.LogFileOption := 4;
  Result := mtt.MediaAssign;
  state :=1;
  {$else}
    if R_IsCom then
    begin
      if  not Rs232Initial(R_BaudNo, R_Port, R_Type) then
      begin
        rdr.R_Active := False;
        ErrorMessage('بازگشايي پورت ترمينال ' + R_Name  + ' ميسر نيست.');
        result := False;
      end
      else
      begin
        frmComTools.ComPort.SetRTS(R_Modem);
        result := True;
      end;
    end
    else
    if not R_IsCom then
    begin
      if R_TCP then
        result := frmTcpUdp.Switch_Tcp(R_IP)
      else
        result := frmTcpUdp.Switch_Udp(R_IP);
    end;
  {$endif}
  end;
end;

procedure TfrmOnline.Timer1Timer(Sender: TObject);
var
  i : integer;
  pk : WideString;
  BCC : byte;
  res : WideString;
begin
  {$ifdef GHSDK}
  case state of
  1 :
    begin
      mtt.ReadOneRecord;
      state := 2;
      waiting := 0;
    end;
  2 :
      if mtt.LastReceivedPacket.Command = 16 then
      begin
        CurrentRecord := '';
        with mtt.LastReceivedPacket do
        begin
          res := GetFrameDataAsString;
          CurrentRecord := res;//copy(res,0,3) + char(getbyte(3))+char(getByte(4))+ GetFrameDataAsString_3(5,18);

        end;
        if CurrentRecord<>'' then
        begin
          state := 1;
        end;
      end
      else
      begin
        inc(waiting);
        if waiting > 10 then
          state := 1;
      end;
  end;
  {$endif}
end;

/// <summary>
/// Printing schema:
/// Line 1  : [نام شرکت]
/// Line 2  : [شماره فیش : [شماره فیش کلی
/// Line 3  : [شماره فیش در دستگاه [کد دستگاه] : [شماره فیش در دستگاه   /// this line have a underline
/// Line 4  : [شماره پرسنلی] + [نام و نام خانودادگی]
/// Line 5  : {پرسنل رژیمی}
/// Line 6  : {[وعده] + [تاریخ] + [زمان] + {قیمت = [قیمت]
/// Line 7  : [نام غذا]
///      .  : .
///      .  : .
/// Line N  : .
/// Line N+1: [توضیحات]
///      .  : .
///      .  : .
/// Line N+5: .
/// Line N+6: [خط خالی]
///      .  : .
///      .  : .
/// Line N+m: .
/// </summary>

procedure TfrmOnline.GetOnlineRecord(var OK : Boolean);
function AlignToRight(ST : String; ch : Char; Len : Byte; firstCall : Boolean = False) : String;
var
  i , j  : Integer;
begin
  ch := ' ';
  if Length(ST) > Len then
    ST := Copy(ST, 1, Len)
  else
  begin
    case rdr.R_PrnType of
      PRN_LX,
      PRN_LQ,
      PRN_CITIZEN3551,
      PRN_CITIZEN3541,
      PRN_SAMSUNG350:
      begin
        while Length(ST) < Len do
          ST := ST + ch;
      end;

      PRN_SAMSUNG350plus,
      PRN_CITIZENs2000,
      PRN_ITHACA:
      begin
        if firstCall then      
          ST := ST + #2 + #97 + #27;
//        while Length(ST) < Len do
//          ST := ST + ch;
      end;

{      PRN_CITIZENs2000:
      begin
        j := Len - Length(ST);
        for i := 1 to (j div 7) do
          ST := ST + #9;
        for i := 1 to (j mod 7) do
          ST := ST + ch;
///        while Length(ST) < Len do
///        begin
///          if Len > 6 then
///          begin
///            ST := ST + #9;
///            Len := Len - 7;
///          end
///          else
///            ST := ST + ' ';
///        end;
      end; }
    end;
  end;
  AlignToRight := ST;
end;
function irUnderLine(ST : String; removeUnderLine : Boolean) : String;
begin
  case rdr.R_PrnType of
    PRN_LX,
    PRN_LQ,
    PRN_CITIZEN3551,
    PRN_CITIZEN3541,
    PRN_SAMSUNG350:
    begin
      if not removeUnderLine then
        ST := AlignToRight('----------------------------------------', ' ', 40) + #13#10 + ST ;
    end;

    PRN_SAMSUNG350plus,
    PRN_CITIZENs2000,
    PRN_ITHACA:
    begin
      if removeUnderLine then
        ST := ST + #0 + #45 + #27
      else
        ST := ST + #1 + #45 + #27;
    end;
  end;
  irUnderLine := ST;
end;
var
  ST, PK, tmp, tmp2 : String;
  i : Byte;
  ij : Integer;
  P_Fish : TFish;
  retVal : Integer;
  P : TPerson;
  FP : Currency;
{$ifdef RestService}
  adoQryService : TADOQuery;
  Rest_ID : Integer;
  Rest_IsPrint : Byte;
{$endif RestService}
begin
  case rdr.R_Type of
    RDR_RESTZ84: RestZ84OnLine(P_Fish, OK{$ifdef RestService}, Rest_ID{$endif RestService});
    RDR_RESTZ80: RestZ80OnLine(P_Fish, OK);
    RDR_BIOLITE, RDR_BIOSTATION, RDR_XSTATION: RestBSOnLine(P_Fish, OK);
  end;

{$ifdef RestService}
  if OK then
  begin
    if compare2Fishs(Last_Fish,P_Fish) and ( Last_Rest_ID = Rest_ID) then
    begin
      OK := False;
      with adoQryService do
      begin
        adoQryService := TADOQuery.Create(Application);
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('update OnlineCollectedRecs');
        SQL.Add('set Rest_ReplyPacket = ''DELETE THIS RECORD!''') ;//:uParam');
        SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
        ExecSQL;
        Close;
      end;
    end
    else
    begin
      Last_Fish := P_Fish;
      Last_Rest_ID := Rest_ID;
    end

  end;
{$endif RestService}
  if OK then
  begin
    for i := 1 to 8 do
      P_Fish.Fish_FoodsNo[i] := 1;

    if P_Fish.Keys = 0 then
      P_Fish.Keys := rdr.RK_Key;
    P_Fish.Fish_UCode := 0;
    P_Fish.Fish_UKhadamat := 0;
    P_Fish.Fish_UPrc := 0;
    P_Fish.Fish_UPay := 0;
    {$ifdef RajaiiHospital}
    tmrRdr.Enabled := False;
    {$endif RajaiiHospital}
    retVal := CreateFish(P_Fish, p, True);
    {$ifdef RajaiiHospital}
    tmrRdr.Enabled := True;
    {$endif RajaiiHospital}
    case P_Fish.Fish_Type of
      MB_SOBH : P_Fish.Fish_RdrFishNo := Rdr_Sobh_Fish_No;
      MB_Nahar : P_Fish.Fish_RdrFishNo := Rdr_Nahar_Fish_No;
      MB_SHAM : P_Fish.Fish_RdrFishNo := Rdr_Sham_Fish_No;
      MB_SOBHNEXT : P_Fish.Fish_RdrFishNo := Rdr_SobhNext_Fish_No;
    end;
(*
    if retVal = 0 then
    begin
      case rdr.R_Type of
        RDR_RESTZ84:
          MakePocket(PK, rdr.R_Code, $06, 0, '');
        {$region 'z80'}
        RDR_RESTZ80:
        begin
          PK := 'A';
          if rdr.R_PrintFish = TRUE then
          begin
            PK := PK + Z80PrnFormat(g_options.CoName, True, False, False);

            ST := (FoodName[P_Fish.Fish_Type]) + ' ' + StrRev(P_Fish.Fish_Date);
            PK := PK + Z80PrnFormat(ST, True, False, False);

            if p.P_IsGuest then
              ST := (')ميهمان( ') + p.P_Family
            else
              ST := p.P_Name + '-' + p.P_Family;

            PK := PK + Z80PrnFormat(ST, True, False, False);

            ST := StrRev(P_Fish.Fish_PCode);
            PK := PK + Z80PrnFormat(ST, True, False, False);

            if p.P_Rejim then
              PK := PK + Z80PrnFormat(('پرسنل رژيمي'), True, True, True);

            for i := 1 to 8 do
              if P_Fish.Fish_Foods[i] <> 0 then
              begin
                ST := GetFoodNameInRam(P_Fish.Fish_Foods[i]);
                PK := PK + Z80PrnFormat(ST, True, False, False);
              end;

            if p.P_PriceAble or (rdr.R_AllFishPrc = TRUE) then
            begin
              Fp := 0;
              for i := 1 to 8 do
                FP := FP + P_Fish.Fish_Price[i];
              ST := ('قيمت = ') + StrRev(FloatToStr(FP));
              PK := PK + Z80PrnFormat(ST, True, False, True);
            end;

            if P_Fish.ManySel > 1 then
              ST := ('شماره') + StrRev(IntToStr(P_Fish.Fish_No+1)) + 'تا' + StrRev(IntToStr(P_Fish.Fish_No+P_Fish.ManySel))
            else
              ST := ('شماره') + StrRev(IntToStr(P_Fish.Fish_No+1));
            PK := PK + Z80PrnFormat(ST, True, True, False);

            if rdr.R_LineFeed > 0 then
            begin
              ST := '';
              for i := 1 to rdr.R_LineFeed do ST := ST + #$0A;
              PK := PK + ST;
            end;
          end;
          if Length(PK) > 100 then
            Delete(PK, 101, Length(PK)-101);
          if rdr.R_PrnType = PRN_CITIZEN3551 then
            PK := Pk + #27'd0'
          else if rdr.R_PrnType = PRN_CITIZEN3541 then
            PK := Pk + #27'P'#0;
          PK := PK + #$0D;
        end;
        {$endregion 'z80'}
      end;
    end
    else
      case rdr.R_Type of
        RDR_RESTZ84:
          MakePocket(PK, rdr.R_Code, $15, 0, Chr(retVal));
        RDR_RESTZ80:
          PK := 'N2'#$0D
      end;
    {$ifdef RestService}
    with adoQryService do
    begin
      adoQryService := TADOQuery.Create(Application);
      Connection := frmDBS.DBConnection;
      for i := 1 to length(PK) do
      begin
        tmp2 := tmp2 + fixleft(inttostr(ord(PK[i])),'0',3);
      end;
      SQL.Clear;
{      SQL.Add('update OnlineCollectedRecs');
////      SQL.Add('set Rest_ReplyPacket = ''' + PK + '''');
      SQL.Add('set Rest_ReplyPacket = ''' + tmp2 + '''');//:uParam');
      SQL.Add(' where ((Rest_BarCode = ''' + P_Fish.Fish_BarCode + ''')');
      SQL.Add(' and (Rest_Date = ''' + P_Fish.Fish_Date + ''')');
      SQL.Add(' and (Rest_Time = ' + P_Fish.Fish_mmTime + ')');
//      SQL.Add(' and (Rest_RdrCode = ' + IntToStr(P_Fish.Fish_RdrCode) + ')');
      SQL.Add(' and ((Rest_ReplyPacket is null) or (Rest_ReplyPacket = '''')))');
//      Parameters.ParamByName('uParam').DataType := ftVariant;
//      Parameters.ParamByName('uParam').value := strto(pk;
}
      SQL.Add('DELETE FROM OnlineCollectedRecs ');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
      ExecSQL;
      Close;
    end;
    FreeAndNil(adoQryService);
    {$else RestService}
    if not SendPocket(self,PK) then
      OK := False;
    {$endif RestService}
*)

    { $ifdef RestService}
    {with adoQryService do
    begin
      adoQryService := TADOQuery.Create(Application);
      Connection := frmDBS.DBConnection;
      SQL.Clear;

      SQL.Add('update OnlineCollectedRecs');
//      SQL.Add('set Rest_ReplyPacket = ''' + tmp2 + '''');//:uParam');
      SQL.Add('set Rest_ReplyPacket = ''DELETE THIS RECORD!''') ;//:uParam');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
{
      SQL.Add('DELETE FROM OnlineCollectedRecs ');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
}
{      ExecSQL;
      Close;
    end;
    FreeAndNil(adoQryService);
    { $endif RestService}

    if {OK and} (retVal = 0) then
    begin
      SaveFish(P_Fish);

      case P_Fish.Fish_Type of
{kaveh
        MB_SOBH : Inc(Rdr_Sobh_Fish_No);
        MB_Nahar : Inc(Rdr_Nahar_Fish_No);
        MB_SHAM : Inc(Rdr_Sham_Fish_No);
        MB_SOBHNEXT : Inc(Rdr_SobhNext_Fish_No);
kaveh}
        MB_SOBH : Rdr_Sobh_Fish_No := P_Fish.Fish_RdrFishNo;
        MB_Nahar : Rdr_Nahar_Fish_No := P_Fish.Fish_RdrFishNo;
        MB_SHAM : Rdr_Sham_Fish_No := P_Fish.Fish_RdrFishNo;
        MB_SOBHNEXT : Rdr_SobhNext_Fish_No := P_Fish.Fish_RdrFishNo;
      end;


      if (rdr.r_PrintFish = TRUE) and
         (rdr.R_Type = RDR_RESTZ84) then
      begin
        MaxTimeOut := 2000;

        ST := g_options.CoName;

{kaveh        if P_Fish.ManySel > 1 then
          ST := FixLen(ST, ' ', 20) + '     ' + AlignToRight(StrRev(IntToStr(P_Fish.Fish_No-P_Fish.ManySel+1)) + 'تا' + StrRev(IntToStr(P_Fish.Fish_No)), ' ', 20 , True)
        else
          ST := FixLen(ST, ' ', 33) + '  ' + AlignToRight(StrRev(IntToStr(P_Fish.Fish_No)), ' ', 5 , True);

        PrintToReader(ST, false, True, OK, P_Fish);

        ST := 'دستگاه ' + StrRev(IntToStr(P_Fish.Fish_RdrCode));

        ST := FixLen(ST, ' ', 22) + '  ' + AlignToRight(('شماره فيش : ') + StrRev(IntToStr(P_Fish.Fish_RdrFishNo)), ' ', 16);
        PrintToReader(ST, false, True, OK, P_Fish);

        ST := AlignToRight('------------------------------------------', ' ', 40);
        PrintToReader(ST, false, False, OK, P_Fish);
kaveh}

//kaveh is
//        ST := FixLen(ST, ' ', 40);
        ST := AlignToRight(ST, ' ', 40, True);
        ST := irUnderLine(ST, False);
        PrintToReader(ST, false, True, OK, P_Fish);

        if P_Fish.ManySel > 1 then
          ST := 'شماره فيش : ' + StrRev(IntToStr(P_Fish.Fish_No-P_Fish.ManySel+1)) + ' تا ' + StrRev(IntToStr(P_Fish.Fish_No))
        else
          ST := 'شماره فيش : ' + StrRev(IntToStr(P_Fish.Fish_No));
        ST := AlignToRight(ST, ' ', 40);
        ST := irUnderLine(ST, True);
        PrintToReader(ST, false, True, OK, P_Fish);

//        ST := irUnderLine(ST, True);

        ST := 'شماره فیش در دستگاه ' + StrRev(IntToStr(P_Fish.Fish_RdrCode)) + ' : ';
        if P_Fish.ManySel > 1 then
          ST := ST + StrRev(IntToStr(P_Fish.Fish_RdrFishNo-P_Fish.ManySel+1)) + ' تا ' + StrRev(IntToStr(P_Fish.Fish_RdrFishNo))
        else
          ST := ST + StrRev(IntToStr(P_Fish.Fish_RdrFishNo));
        ST := FixLen(ST, ' ', 40);
        ST := irUnderLine(ST, False);
        PrintToReader(ST, false, True, OK, P_Fish);

//kaveh ie

        if p.P_IsGuest then
          ST := AlignToRight((')ميهمان( ') + p.P_Family, ' ', 31)
        else
          if rdr.r_ignorename = TRUE 
          then st:=''
          else ST := AlignToRight(p.P_Name + '-' + p.P_Family, ' ', 31);

        ST := AlignToRight(StrRev(P_Fish.Fish_PCode) , ' ', 8) + ' ' + ST;
        ST := irUnderLine(ST, True);
        PrintToReader(ST, False, False, OK, P_Fish);


        if p.P_Rejim then
        begin
          ST := AlignToRight(('پرسنل رژيمي'), ' ', 15);
          PrintToReader(ST, False, True, OK, P_Fish);
        end;

        ST := (FoodName[P_Fish.Fish_Type]) + ' ' + StrRev(P_Fish.Fish_Date)+ ' ' + StrRev(P_Fish.Fish_Time);
        if p.P_PriceAble or (rdr.r_AllFishPrc = TRUE) then
        begin
          Fp := 0;
          for i := 1 to 8 do
            FP := FP + P_Fish.Fish_Price[i];
          ST := AlignToRight(ST, ' ', 24) + ' ' + ('قيمت = ') + StrRev(FloatToStr(FP));
        end
        else
          ST := AlignToRight(ST, ' ', 40);

        PrintToReader(ST, False, True, OK, P_Fish);
        tmp := '';
        for i := 1 to 8 do
          if P_Fish.Fish_Foods[i] <> 0 then
          begin
            ST := GetFoodNameInRam(P_Fish.Fish_Foods[i]);
{            if GetFoodType(P_Fish.Fish_Foods[i]) = MB_GHAZA then
              PrintToReader(AlignToRight(ST, ' ', 40) , True, True, OK, P_Fish)
            else
}            begin
              if tmp <> '' then
                tmp := tmp + '-';
              tmp := tmp + ST;
            end;
          end;
        PrintToReader(AlignToRight(tmp, ' ', 40), false, False, OK, P_Fish);

////kaveh test
        //////tmp := tmp + #10 + STtest;
        //////tmp :='Z' + #10 + '61' + #10 + '51' + #10 + '41' + #10 + '31' + #10 + '21' + #10 + '11' + #10 + '01' + #10 + '9' + #10 + '8' + #10 + '7' + #10 + '6' + #10 + '5' + #10 +  '4' + #10 + '3' + #10 + '2' + #10 + '1' + #10 ;
        //tmp :='06aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa06';
        //PrintToReader(AlignToRight(tmp, ' ', 60), false, False, OK, P_Fish);
        //tmp :='bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';
        //PrintToReader(AlignToRight(tmp, ' ', 63), false, False, OK, P_Fish);
        //tmp :='ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc';
        //PrintToReader(AlignToRight(tmp, ' ', 65), false, False, OK, P_Fish);
        //tmp :='07dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd07';
        //PrintToReader(AlignToRight(tmp, ' ', 70), false, False, OK, P_Fish);
//        tmp :='560eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee560';
//        PrintToReader(AlignToRight(tmp, ' ', 65), false, False, OK, P_Fish);
        //tmp :='051ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff051';
        //PrintToReader(AlignToRight(tmp, ' ', 150), false, False, OK, P_Fish);
        //tmp :='591fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff591';
        //PrintToReader(AlignToRight(tmp, ' ', 195), false, False, OK, P_Fish);
        //////tmp :='002ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff002';
        //////PrintToReader(AlignToRight(tmp, ' ', 200), false, False, OK, P_Fish);

        //tmp :='123456789a123456789b123456789c123456789d';
        //PrintToReader(tmp, false, False, OK, P_Fish);
        //tmp :='A                                      A';
        //PrintToReader(tmp, false, False, OK, P_Fish);
        //tmp := 'MALAS   ' + #9 + #9 + #9 + #9;
        //tmp := 'IBOOHK  ' + #9 + #9 + #9 + #9 + #10 + tmp ;

        //tmp := 'MALAS' + #2 + #97 + #27;
        //tmp := 'IBOOHK' + #10 + tmp ;
        //tmp := 'RABAHK EHC' + #10 + tmp ;
        //PrintToReader(tmp, false, False, OK, P_Fish);
        //tmp :='123456789c123456789d';
        //PrintToReader(tmp, false, False, OK, P_Fish);
////kaveh test

        if F_Params.Endfishactive1  then
        begin
          ST := AlignToRight(F_Params.Endfish1 , ' ', 38);
          PrintToReader(ST, false, false, OK, P_Fish);
        end;

        if F_Params.Endfishactive2  then
        begin
          ST := AlignToRight(F_Params.Endfish2 , ' ', 38);
          PrintToReader(ST, false, false, OK, P_Fish);
        end;

        if F_Params.Endfishactive3  then
        begin
          ST := AlignToRight(F_Params.Endfish3 , ' ', 38);
          PrintToReader(ST, false, false, OK, P_Fish);
        end;

        if F_Params.Endfishactive4  then
        begin
          ST := AlignToRight(F_Params.Endfish4 , ' ', 38);
          PrintToReader(ST, false, false, OK, P_Fish);
        end;

        if F_Params.Endfishactive5  then
        begin
          ST := AlignToRight(F_Params.Endfish5 , ' ', 38);
          PrintToReader(ST, false, false, OK, P_Fish);
        end;

//kaveh is
        if p.P_IsGuest then
        begin
          ST := AlignToRight('توضيح: ' + p.P_reserve1, ' ', 40);
          ST := irUnderLine(ST, True);
          PrintToReader(ST, False, False, OK, P_Fish);
        end;
//kaveh ie

        if rdr.R_LineFeed > 0 then
        begin
          ST := '';
          for i := 1 to rdr.R_LineFeed do ST := ST + #10;
          PrintToReader(ST, False, False, OK, P_Fish);
        end;
        if (P_Fish.rdrStatus <> 69) then
        begin
          ST := ''; //kaveh
          PrintToReader(ST, false, False, OK, P_Fish, True, False); //kaveh
          CutPrint(OK, P_Fish);
        end
        else
        begin
          ST := makeStringCutPrint();
          PrintToReader(ST, False, False, OK, P_Fish, False, True);
          ST := ''; //kaveh
          PrintToReader(ST, false, False, OK, P_Fish, True, True); //kaveh
        end;

{//kaveh test
        for ij := 1 to 1 do
        begin
//          tmp := '051ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff051-'+ inttostr(ij);
//          PrintToReader(AlignToRight(tmp, ' ', 155), false, False, OK, P_Fish);
//          tmp :='591fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff591';
//          PrintToReader(AlignToRight(tmp, ' ', 195), false, False, OK, P_Fish);
          tmp :='242GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG242';
          PrintToReader(AlignToRight(tmp, ' ', 242), false, False, OK, P_Fish);
        end;

        if rdr.R_LineFeed > 0 then
        begin
          ST := '';
          for i := 1 to rdr.R_LineFeed do ST := ST + #10;
          PrintToReader(ST, False, False, OK, P_Fish);
        end;

        if (P_Fish.rdrStatus <> 69) then
        begin
          ST := ''; //kaveh
          PrintToReader(ST, false, False, OK, P_Fish, True, False); //kaveh
          CutPrint(OK, P_Fish);
        end
        else
        begin
          ST := makeStringCutPrint();
          PrintToReader(ST, False, False, OK, P_Fish, False, True);
          ST := ''; //kaveh
          PrintToReader(ST, false, False, OK, P_Fish, True, True); //kaveh
        end;
//kaveh test }

        MaxTimeOut := 600;
      end;
      case rdr.R_Type of
        RDR_RESTZ84:
          MakePocket(PK, rdr.R_Code, $06, 0, '');
        {$region 'z80'}
        RDR_RESTZ80:
        begin
          PK := 'A';
          if rdr.R_PrintFish = TRUE then
          begin
            PK := PK + Z80PrnFormat(g_options.CoName, True, False, False);

            ST := (FoodName[P_Fish.Fish_Type]) + ' ' + StrRev(P_Fish.Fish_Date);
            PK := PK + Z80PrnFormat(ST, True, False, False);

            if p.P_IsGuest then
              ST := (')ميهمان( ') + p.P_Family
            else
              ST := p.P_Name + '-' + p.P_Family;

            PK := PK + Z80PrnFormat(ST, True, False, False);

            ST := StrRev(P_Fish.Fish_PCode);
            PK := PK + Z80PrnFormat(ST, True, False, False);

            if p.P_Rejim then
              PK := PK + Z80PrnFormat(('پرسنل رژيمي'), True, True, True);

            for i := 1 to 8 do
              if P_Fish.Fish_Foods[i] <> 0 then
              begin
                ST := GetFoodNameInRam(P_Fish.Fish_Foods[i]);
                PK := PK + Z80PrnFormat(ST, True, False, False);
              end;

            if p.P_PriceAble or (rdr.R_AllFishPrc = TRUE) then
            begin
              Fp := 0;
              for i := 1 to 8 do
                FP := FP + P_Fish.Fish_Price[i];
              ST := ('قيمت = ') + StrRev(FloatToStr(FP));
              PK := PK + Z80PrnFormat(ST, True, False, True);
            end;

            if P_Fish.ManySel > 1 then
              ST := ('شماره') + StrRev(IntToStr(P_Fish.Fish_No+1)) + 'تا' + StrRev(IntToStr(P_Fish.Fish_No+P_Fish.ManySel))
            else
              ST := ('شماره') + StrRev(IntToStr(P_Fish.Fish_No+1));
            PK := PK + Z80PrnFormat(ST, True, True, False);

            if rdr.R_LineFeed > 0 then
            begin
              ST := '';
              for i := 1 to rdr.R_LineFeed do ST := ST + #$0A;
              PK := PK + ST;
            end;
          end;
          if Length(PK) > 100 then
            Delete(PK, 101, Length(PK)-101);
          if rdr.R_PrnType = PRN_CITIZEN3551 then
            PK := Pk + #27'd0'
          else if rdr.R_PrnType = PRN_CITIZEN3541 then
            PK := Pk + #27'P'#0;
          PK := PK + #$0D;
        end;
        {$endregion 'z80'}
      end;

      with rdr do
      begin
        CardNumber := p.P_BarCode;
        NameFamily := p.P_Name + '-' + p.P_Family;
        FishNumber := IntToStr(P_Fish.Fish_No);
        FishTime := P_Fish.Fish_Time;
      end;
    {$ifdef RestService}
      Rest_IsPrint := 1;
    {$endif RestService}
    end
    else
    begin
      case rdr.R_Type of
        RDR_RESTZ84:
          MakePocket(PK, rdr.R_Code, $15, 0, Chr(retVal));
        RDR_RESTZ80:
          PK := 'N2'#$0D
      end;
    {$ifdef SaveErrorLogs}
      SaveErrorLog(P_Fish, p, retVal);
    {$endif SaveErrorLogs}
    {$ifdef RestService}
      Rest_IsPrint := 0;
    {$endif RestService}
    end;


    {$ifdef RestService}
    with adoQryService do
    begin
      adoQryService := TADOQuery.Create(Application);
      Connection := frmDBS.DBConnection;
      for i := 1 to length(PK) do
      begin
        tmp2 := tmp2 + fixleft(inttostr(ord(PK[i])),'0',3);
      end;
      SQL.Clear;
      SQL.Add('INSERT INTO OnlineCollectedRecs (Rest_Barcode ,Rest_Date,Rest_Time,Rest_RdrCode,Rest_RecState,Rest_User,Rest_IsPrint,Rest_ReplyPacket)');
      SQL.Add('VALUES('''', ');
      SQL.Add(''''', ');
      SQL.Add('0, ');
      SQL.Add(IntToStr(rdr.R_Code)+ ', ');
      SQL.Add('0, ');
      SQL.Add('''Rest5_1'', ');
      SQL.Add(IntToStr(Rest_IsPrint)+ ', ');
      SQL.Add('''' + tmp2 + ''') ');
      ExecSQL;
      Close;
      OK := True;
    end;

    with adoQryService do
    begin
      adoQryService := TADOQuery.Create(Application);
      Connection := frmDBS.DBConnection;
      SQL.Clear;

      SQL.Add('update OnlineCollectedRecs');
//      SQL.Add('set Rest_ReplyPacket = ''' + tmp2 + '''');//:uParam');
      SQL.Add('set Rest_ReplyPacket = ''DELETE THIS RECORD!''') ;//:uParam');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
{
      SQL.Add('DELETE FROM OnlineCollectedRecs ');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
}
      ExecSQL;
      Close;
    end;

    FreeAndNil(adoQryService);
(*    {$ifdef RestService}
    with adoQryService do
    begin
      adoQryService := TADOQuery.Create(Application);
      Connection := frmDBS.DBConnection;
      for i := 1 to length(PK) do
      begin
        tmp2 := tmp2 + fixleft(inttostr(ord(PK[i])),'0',3);
      end;
      SQL.Clear;
      SQL.Add('DELETE FROM OnlineCollectedRecs ');
      SQL.Add('WHERE Rest_ID = ' + IntToStr(Rest_ID)+ ' ');
      ExecSQL;
      Close;
    end;
    FreeAndNil(adoQryService); *)
    {$else RestService}
    case rdr.R_Type of
      RDR_RESTZ84, RDR_RESTZ80:
      begin
        if not SendPocket(self,PK) then
          OK := False;
      end;
      RDR_BIOLITE, RDR_BIOSTATION, RDR_XSTATION: OK := True;
    end;

    {$endif RestService}

    frmFishLst.ViewFish(P_Fish, p, retVal);
  end;
end;


procedure TfrmOnline.RestZ84OnLine(var P_Fish : TFish; var OK : Boolean{$ifdef RestService}; var iRest_ID : Integer{$endif RestService});
var
  PK : String;
  STAT : Byte;
  adoQryService : TADOQuery;
begin
{$ifdef RestService}
  with adoQryService do
  begin
    adoQryService := TADOQuery.Create(Application);
    Connection := frmDBS.DBConnection;
{//x//    SQL.Clear;
    SQL.Add('IF not EXISTS(SELECT name ');
    SQL.Add('FROM sysobjects ');
    SQL.Add('WHERE (name = ''OnlineCollectedRecs'' ))');
    SQL.Add('create table OnlineCollectedRecs ');
    SQL.Add('(Rest_ID int IDENTITY (1, 1) NOT NULL,');
    SQL.Add(' Rest_BarCode varchar(8),');
    SQL.Add(' Rest_Date varchar(10),');
    SQL.Add(' Rest_Time smallint,');
    SQL.Add(' Rest_RdrCode smallint,');
    SQL.Add(' Rest_RecState smallint,');
    SQL.Add(' Rest_User varchar(15),');
    SQL.Add(' Rest_IsPrint bit,');
    SQL.Add(' Rest_ReplyPacket varchar(1000), ');
    SQL.Add(' Rest_Status smallint )');
    ExecSQL;}
    
    SQL.Clear;
    SQL.Add('select * from ');
    SQL.Add('(select * ');
    SQL.Add('FROM OnlineCollectedRecs ');
    SQL.Add('where ((Rest_ReplyPacket is null) or (Rest_ReplyPacket = '''')) and Rest_RdrCode = ' + inttostr(rdr.R_Code) + ') as l1 ');
    SQL.Add('where Rest_ID = (select min(Rest_ID) ');
    SQL.Add('FROM OnlineCollectedRecs ');
    SQL.Add('where ((Rest_ReplyPacket is null) or (Rest_ReplyPacket = '''')) and Rest_RdrCode = ' + inttostr(rdr.R_Code) + ') ');
//new    SQL.Add('SELECT top 1 * ');
//new    SQL.Add('FROM OnlineCollectedRecs ');
//new    SQL.Add('where (Rest_ReplyPacket is null) or (Rest_ReplyPacket = '''')');
    Open;
    if FieldByName('Rest_BarCode').AsString <> '' then
    begin
//            if rdr.R_Code <> FieldByName('Rest_RdrCode').AsInteger  then
//               Delay(1);
            P_Fish.Fish_RdrCode :=  FieldByName('Rest_RdrCode').AsInteger;
            P_Fish.Keys := FieldByName('Rest_RecState').AsInteger;
            P_Fish.Fish_Date := FieldByName('Rest_Date').AsString;
            P_Fish.Fish_mmTime := FieldByName('Rest_Time').AsString;
            P_Fish.Fish_Time := BeautifulTime(Copy(IntToStr(FieldByName('Rest_Time').AsInteger div 60), 1, 2) + ':' +
                                              Copy(IntToStr(FieldByName('Rest_Time').AsInteger mod 60), 1, 2));
            P_Fish.Fish_PCode := FieldByName('Rest_BarCode').AsString;
            P_Fish.Fish_BarCode := FieldByName('Rest_BarCode').AsString;
            iRest_ID := FieldByName('Rest_ID').AsInteger;
//            pStatus := iRest_ID;
            P_Fish.rdrStatus := FieldByName('Rest_Status').AsInteger;
            P_Fish.IsProxi := True;

//            readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].
//            rdr.
//            LoadFishsNo(CurrentDate);
            OK := True;
    end
    else
      OK := False;
    Close;
  end;
  FreeAndNil(adoQryService);
{$else RestService}
{$ifdef GHSDK}
  Timer1Timer(self);
  case mtt.LastReceivedPacket.Command of
    $10 :
    begin
      mtt.LastReceivedPacket.Command := 0;
      trystrToInt(Copy(CurrentRecord, 1, 3),P_Fish.Fish_RdrCode);
      P_Fish.Keys := (ord(CurrentRecord[5])) * 256 + (ord(CurrentRecord[4]));
      P_Fish.Fish_Date := BeautifulDate(Copy(CurrentRecord, 6, 2) + '/' +
                                        Copy(CurrentRecord, 8, 2) + '/' +
                                        Copy(CurrentRecord, 10, 2));
      P_Fish.Fish_Time := BeautifulTime(Copy(CurrentRecord, 12, 2) + ':' +
                                        Copy(CurrentRecord, 14, 2));
      P_Fish.Fish_PCode := Copy(CurrentRecord, 16, 8);
      P_Fish.rdrStatus := mtt.LastReceivedPacket.Status; //kaveh
      P_Fish.IsProxi := True;
    end;
    $15:
    begin
      OK := False;
      with rdr do
      begin
        RdrTime := CurrentTimes;
        RdrState := 'Off Line';
      end;
    end;
    else
      OK := False;
  end;

{$else GHSDK}
  OK := True;
  MakePocket(PK, rdr.r_code, $31, 0, ''); (* Request record in online mode *)
  if not SendPocket(self,PK) then
  begin
    OK := False;
    rdr.RdrState := '*****';
  end
  else
  begin
    GetPocket(self,PK, True, STAT);
    if Length(pk)>3 then
    begin
      if (STAT = 0) and (Ord(PK[3]) = rdr.r_code) then
      begin
        case Ord(PK[4]) of
          $10: (* Get Record in online mode *)
          begin
            OK := True;
            P_Fish.Fish_RdrCode := StrToInt(Copy(PK, 6, 3));
            P_Fish.Keys := Ord(PK[10]) * 256 + Ord(PK[9]);
            P_Fish.Fish_Date := BeautifulDate(Copy(PK, 11, 2) + '/' +
                                              Copy(PK, 13, 2) + '/' +
                                              Copy(PK, 15, 2));
            P_Fish.Fish_Time := BeautifulTime(Copy(PK, 17, 2) + ':' +
                                              Copy(PK, 19, 2));
            P_Fish.Fish_PCode := Copy(PK, 21, 8);
            P_Fish.rdrStatus := Ord(PK[5]); //kaveh
            P_Fish.IsProxi := True;
          end;

          $15:
          begin
            OK := False;
            with rdr do
            begin
              RdrTime := CurrentTimes;
              RdrState := 'Off Line';
            end;
          end;

          else
            OK := False;
        end; {End of case Ord(PK[4])}
      end
      else
        OK := False;
    end
    else
    begin
      OK := False;
      rdr.RdrState := '*****';
    end;
  end;
{$endif GHSDK}
{$endif RestService}
end;


procedure TfrmOnline.RestBSOnLine(var P_Fish : TFish; var OK : Boolean);
var
  clkRecord : TTerminalRec;
  bsRet : BS_RET_CODE;
  y,m,d,hh,mm,ss,ms : word;
  findRec : Boolean;
  tempSec : Integer;
begin
  OK := True;
//  tmrReadOnline.Enabled := False;
  findRec := False;
//  iRdrCode := 0;
  bsRet := ReadFirstLogPCode_BS(rdr{rdrReadOnline},Shamsi2Milady(LeftStr(DTTM4ReadOnline,10)) + RightStr(DTTM4ReadOnline,9),'',clkRecord, findRec);
//  if bsRet <> BS_SUCCESS then
//  begin
//    lblHelp.Caption := 'خطا! ارتباط با دستگاه قطع ميباشد';
//    tmrReadOnline.Enabled := True;
//  end
//  else
//  begin
//    lblHelp.Caption := 'در حال خواندن اطلاعات از دستگاه';

  if (bsRet = BS_SUCCESS) and (findRec) {and (Ord(PK[3]) = rdr.r_code)} then
  begin
    if clkRecord.rdrCardCode <> '' then
    begin
//      iRdrCode := StrToInt(cmbRdrCode.Text);
//      lblHelp.Caption := 'آماده دريافت ليست غذا و ثبت اطلاعات';
//      cmbPCode.ItemIndex := cmbPCode.Items.IndexOf(DelLeftZero(clkRecord.rdrCardCode));
//      cmbPCodeExit(self);
//      txtDate.Text := clkRecord.rdrDate;
//      txtTime.Text := FixLeft(IntToStr(clkRecord.rdrTime div 60),'0',2) + ':' + FixLeft(IntToStr(clkRecord.rdrTime mod 60),'0',2);
//      tempSec := clkRecord.rdrTimeSec + 2;
//      DTTM4ReadOnline := txtDate.Text + ' ' + FixLeft(IntToStr(tempSec div 3600),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 3600) div 60),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 60)),'0',2);
//      cmdSave.SetFocus;
      OK := True;
      P_Fish.Fish_RdrCode := rdr.R_Code;
      P_Fish.Keys := 0;
      P_Fish.Fish_Date := clkRecord.rdrDate;
      P_Fish.Fish_Time := FixLeft(IntToStr(clkRecord.rdrTime div 60),'0',2) + ':' + FixLeft(IntToStr(clkRecord.rdrTime mod 60),'0',2);
//      clkRecord.rdrTime;
      P_Fish.Fish_PCode := clkRecord.rdrCardCode;
      P_Fish.rdrStatus := 0;
      P_Fish.IsProxi := True;
      tempSec := clkRecord.rdrTimeSec + 2;
      DTTM4ReadOnline := clkRecord.rdrDate + ' ' + FixLeft(IntToStr(tempSec div 3600),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 3600) div 60),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 60)),'0',2);
    end
    else
    begin
      OK := True;
      P_Fish.Fish_RdrCode := rdr.R_Code;
      P_Fish.Keys := 0;
      P_Fish.Fish_Date := CurrentDate;
      P_Fish.Fish_Time := CurrentTime;
      P_Fish.Fish_PCode := '';
      P_Fish.rdrStatus := 0;
      P_Fish.IsProxi := True;
      tempSec := clkRecord.rdrTimeSec + 2;
      DTTM4ReadOnline := clkRecord.rdrDate + ' ' + FixLeft(IntToStr(tempSec div 3600),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 3600) div 60),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 60)),'0',2);
    end;
  end
  else
  begin
//    tmrReadOnline.Enabled := True;
    OK := False;
//  end;
  end;


//var
//  PK : String;
//  STAT : Byte;
//  adoQryService : TADOQuery;
//begin
//  OK := True;
//  MakePocket(PK, rdr.r_code, $31, 0, ''); (* Request record in online mode *)
//  if not SendPocket(self,PK) then
//  begin
//    OK := False;
//    rdr.RdrState := '*****';
//  end
//  else
//  begin
//    GetPocket(self,PK, True, STAT);
//    if Length(pk)>3 then
//    begin
//      if (STAT = 0) and (Ord(PK[3]) = rdr.r_code) then
//      begin
//        case Ord(PK[4]) of
//          $10: (* Get Record in online mode *)
//          begin
//            OK := True;
//            P_Fish.Fish_RdrCode := StrToInt(Copy(PK, 6, 3));
//            P_Fish.Keys := Ord(PK[10]) * 256 + Ord(PK[9]);
//            P_Fish.Fish_Date := BeautifulDate(Copy(PK, 11, 2) + '/' +
//                                              Copy(PK, 13, 2) + '/' +
//                                              Copy(PK, 15, 2));
//            P_Fish.Fish_Time := BeautifulTime(Copy(PK, 17, 2) + ':' +
//                                              Copy(PK, 19, 2));
//            P_Fish.Fish_PCode := Copy(PK, 21, 8);
//            P_Fish.rdrStatus := Ord(PK[5]); //kaveh
//            P_Fish.IsProxi := True;
//          end;
//
//          $15:
//          begin
//            OK := False;
//            with rdr do
//            begin
//              RdrTime := CurrentTimes;
//              RdrState := 'Off Line';
//            end;
//          end;
//
//          else
//            OK := False;
//        end; {End of case Ord(PK[4])}
//      end
//      else
//        OK := False;
//    end
//    else
//    begin
//      OK := False;
//      rdr.RdrState := '*****';
//    end;
//  end;
end;

procedure TfrmOnline.clearIFish(var i_Fish : TFish);
var
  I : integer;
begin
  i_Fish.Fish_No := 0;
  i_Fish.Fish_RdrFishNo := 0;
  i_Fish.Fish_PCode := '';
  i_Fish.Fish_BarCode := '';
  i_Fish.Fish_Date := '';
  i_Fish.Fish_Time := '';
  i_Fish.Fish_mmTime := '';
  i_Fish.Fish_Type := 0;
  for I := 1 to 8 do
  begin
    i_Fish.Fish_Foods[I] := 0;
    i_Fish.Fish_FoodsNo[I] := 0;
    i_Fish.Fish_Price[I] := 0;
  end;
  i_Fish.Fish_RdrCode := 0;
  i_Fish.Fish_UCode := 0;
  i_Fish.Fish_UKhadamat := 0;
  i_Fish.Fish_UPrc := 0;
  i_Fish.Fish_UPay := 0;
  i_Fish.IsProxi := False;
  i_Fish.Keys := 0;
  i_Fish.IsPayed := False;
  i_Fish.ManySel := 0;
  i_Fish.PrePaid := False;
  i_Fish.rdrStatus := 0;
end;

function TfrmOnline.compare2Fishs(i_Fish1 : TFish; i_Fish2 : TFish) : Boolean;
begin
  if(
     (i_Fish1.Fish_BarCode = i_Fish2.Fish_BarCode)
     and
     (i_Fish1.Fish_Date = i_Fish2.Fish_Date)
     and
     (i_Fish1.Fish_Time = i_Fish2.Fish_Time)
     and
     (i_Fish1.Fish_RdrCode = i_Fish2.Fish_RdrCode)
    )
  then
    compare2Fishs := True
  else
    compare2Fishs := False;
end;

procedure TfrmOnline.RestZ80OnLine(var P_Fish : TFish; var OK : Boolean);
var
  Data : String;
  retVal : Byte;
  Relat : Boolean;
begin
  Z80_RestaurantRec(rdr.R_Code, retVal, Data);

  OK := True;
  Relat := True;
  if (retVal = MB_TRUEREC) and (StrToInt(Copy(Data, 1, 2)) = rdr.r_code) then
  begin
    OK := True;
    P_Fish.Fish_RdrCode := StrToInt(Copy(Data, 1, 2));
    P_Fish.Keys := Ord(Data[3]) * 128 + Ord(Data[4]);
    P_Fish.Fish_Date := BeautifulDate(Copy(Data, 5, 2) + '/' +
                                      Copy(Data, 7, 2) + '/' +
                                      Copy(Data, 9, 2));
    P_Fish.Fish_Time := BeautifulTime(Copy(Data, 11, 2) + ':' +
                                      Copy(Data, 13, 2));
    P_Fish.Fish_PCode := Copy(Data, 15, 8);
    P_Fish.IsProxi := True;

    Relat := True;
  end
  else if retVal = MB_OFF then
  begin
    OK := False;
    Relat := False;
  end
  else if retVal in [MB_BUFFEMPTY, MB_BADREC] then
  begin
    OK := False;
    Relat := True;
  end;

  if Relat then SetGood(0);

  with rdr do
  begin
    RdrTime := CurrentTimes;
    if not Relat and (rdr.RdrBad > 2) then
      RdrState := '*****'
    else                     
      RdrState := ('برقرار');
  end;

end;

procedure TfrmOnline.PrintToReader(ST : String; DblWidth, Clr : Boolean; var OK : Boolean; P_Fish : TFish; printNow : Boolean = False; notInsert : Boolean = False);
const
  MaxLoop = 5;
  MaxPrintCharacter = 240;
  MaxPrintCntr = 201;
var
  PK, tmp2 : String;
  Status, n : Byte;
  i : integer;
  adoQryService : TADOQuery;
  printCntrStatus : Byte; //kaveh
begin
  for i:=1 to length(ST) do
    if Ord(ST[i]) = 152 then ST[i] := #223; // modify KAF problem that occured in win XP version
  if not OK then Exit;

  if not notInsert then
  begin
    ST := StrRev(WinToDos(ST, WIN_MICROSOFT_SYS, DOS_IR_SYS)) + #13#10;
    case rdr.R_PrnType of
      PRN_LX:
      begin
        ST := #27#120#0 + ST;
        if DblWidth then ST := #14 + ST;
      end;

      PRN_LQ:
      begin
        ST := #27#120#1 + ST;
        if DblWidth then ST := #14 + ST;
      end;

      PRN_CITIZEN3551,
      PRN_CITIZEN3541:
      begin
        ST := #27'1' + ST;
        if DblWidth then ST := #14 + ST + #20;
        if Clr then
        begin
          if (rdr.R_PrnType = PRN_CITIZEN3551) or (rdr.R_PrnType = PRN_SAMSUNG350) or (rdr.R_PrnType = PRN_SAMSUNG350plus) then
            ST := #27'4' + ST + #27'5'
          else
            ST := #$13+ST;
        end;
      end;

      PRN_ITHACA,PRN_SAMSUNG350,PRN_SAMSUNG350plus,PRN_CITIZENs2000:
      begin
        if DblWidth then ST := #27'W'#1 + ST + #27'W'#0;
        if Clr then
          ST := #27'c'#1 + ST
        else
          ST := #27'c'#0 + ST;
      end;
    end;
  end;

  n := 0;
  repeat
    if printNow then Delay(100); //kaveh 1391/01/31
    OK := True;
    Inc(n);
    if (P_Fish.rdrStatus <> 69) or (Length(bigST) + Length(ST) > MaxPrintCharacter) or (printNow) then
    begin
      if (P_Fish.rdrStatus <> 69) then
        bigST := ST;
//kaveh      MakePocket(PK, rdr.r_code, $1C, 0, ST);


//      readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr
//      rdr.

      if (P_Fish.rdrStatus <> 69) then
        printCntrStatus := 0
      else
      begin
        { $ifdef RestService}
        {printCntrStatus := (readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr mod 200) + 1;
        inc(readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr);
        { $else RestService}
        inc(readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr);
        if readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr = MaxPrintCntr then
          readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr := 1;
        printCntrStatus := readers[FindReaderCodeIdx(P_Fish.Fish_RdrCode)].R_PrintCntr;
        { $endif RestService}
      end;

      MakePocket(PK, P_Fish.Fish_RdrCode, $1C, printCntrStatus {0}, bigST);
      {$ifdef RestService}
      with adoQryService do
      begin
        adoQryService := TADOQuery.Create(Application);
        Connection := frmDBS.DBConnection;
        for i := 1 to length(PK) do
        begin
          tmp2 := tmp2 + fixleft(inttostr(ord(PK[i])),'0',3);
        end;
{        SQL.Clear;
        SQL.Add('update OnlineCollectedRecs');
////        SQL.Add('set Rest_ReplyPacket = ''' + PK + '''');
        SQL.Add('set Rest_PrintPacket = ''' + tmp2 + '''');//:uParam');
        SQL.Add(' where ((Rest_BarCode = ''' + P_Fish.Fish_BarCode + ''')');
        SQL.Add(' and (Rest_Date = ''' + P_Fish.Fish_Date + ''')');
        SQL.Add(' and (Rest_Time = ' + P_Fish.Fish_mmTime + ')');
        SQL.Add(' and (Rest_RdrCode = ' + IntToStr(P_Fish.Fish_RdrCode) + ')');
        SQL.Add(' and ((Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> '''')))');
//        Parameters.ParamByName('uParam').DataType := ftVariant;
//        Parameters.ParamByName('uParam').value := strto(pk;
        ExecSQL;
        Close;
               }
        SQL.Clear;
        SQL.Add('INSERT INTO OnlineCollectedRecs (Rest_Barcode ,Rest_Date,Rest_Time,Rest_RdrCode,Rest_RecState,Rest_User,Rest_IsPrint,Rest_ReplyPacket)');
        SQL.Add('VALUES('''', ');
        SQL.Add(''''', ');
        SQL.Add('0, ');
        SQL.Add(IntToStr(rdr.R_Code)+ ', ');
        SQL.Add('0, ');
        SQL.Add('''Rest5_1'', ');
        SQL.Add('1, ');
        SQL.Add('''' + tmp2 + ''') ');
        ExecSQL;
        Close;
        OK := True;
      end;
      FreeAndNil(adoQryService);
      {$else RestService}
      {$ifdef GHSDK}
//      mtt.PrintData(pk);
      {$else GHSDK}
      if not SendPocket(Self,PK) then
        OK := False
      else
      begin
        GetPocket(self,PK, True, Status);
        if length(pk)>3 then
        begin
          if (Status = 0) and (Ord(PK[3]) = rdr.r_code) then
          begin
            case Ord(PK[4]) of
              $06 : OK := True;
              $15 : OK := False;
              else
              begin
                Ok := False;
                //n := MaxLoop;
              end;
            end;
          end
          else
            OK := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdr.r_code));
        end
        else
        begin
          OK := False;
          rdr.RdrState := '*****';
        end;
      end;
      {$endif GHSDK}
      {$endif RestService}
      if OK then
      begin
        if (Length(bigST) + Length(ST) > MaxPrintCharacter) then
          bigST := ST
        else
          bigST := '';
      end;
    end
    else
    begin
      bigST := bigST + ST;
      OK := True;
    end;


    
  until (n = MaxLoop) or OK;
end;

function TfrmOnline.Z80PrnFormat(ST : String; Rev, DblWidth, Clr : Boolean) : String;
begin
  ST := WinToDos(ST, g_options.WinType, DOS_IR_SYS);
  if Rev then
    ST := StrRev(ST);

  case rdr.R_PrnType of
    PRN_LX:
    begin
      if DblWidth then ST := #14 + ST;
    end;

    PRN_LQ:
    begin
      ST := #27#120#1 + ST;
      if DblWidth then ST := #14 + ST;
    end;

    PRN_CITIZEN3551,
    PRN_CITIZEN3541:
    begin
      ST := #27'1' + ST;
      if DblWidth then ST := #14 + ST + #20;
      if Clr then
      begin
        if rdr.R_PrnType = PRN_CITIZEN3551 then
          ST := #27'4' + ST + #27'5'
        else
          ST := #$13+ST;
      end;
    end;

    PRN_ITHACA:
    begin
      if DblWidth then ST := #27'W'#1 + ST + #27'W'#0;
      if Clr then
      begin
        if rdr.R_PrnType = PRN_CITIZEN3551 then
          ST := #27'4' + ST + #27'5'
        else
          ST := #$13+ST;
      end;
    end;
  end;
  ST := ST + #$0A;
  Z80PrnFormat := ST;
end;

procedure TfrmOnline.CutPrint(var OK : Boolean; P_Fish : TFish);
const
  MaxLoop = 5;
var
  ST, PK, tmp2 : String;
  Status, n : Byte;
  adoQryService : TADOQuery;
  i : Integer;
begin
  if not OK then Exit;
  if not rdr.R_PrnType in [PRN_CITIZEN3551, PRN_CITIZEN3541,PRN_ITHACA,PRN_SAMSUNG350,PRN_SAMSUNG350plus,PRN_CITIZENs2000] then Exit;

  case rdr.R_PrnType of
    PRN_CITIZEN3551,PRN_SAMSUNG350 : ST := #27'd0';
    PRN_SAMSUNG350plus,PRN_CITIZENs2000 : ST := #29 + #86 + #0;//#27'd0';
    PRN_CITIZEN3541 : ST := #27'P'#0;
    PRN_ITHACA  : ST := #27'd' + chr(10) + #27'v';
  end;

  n := 0;
  repeat
    Delay(100);
    Inc(n);
//kaveh    MakePocket(PK, rdr.r_code, $1C, 0, ST);
    MakePocket(PK, P_Fish.Fish_RdrCode, $1C, 0, ST);
    {$ifdef RestService}
      with adoQryService do
      begin
        adoQryService := TADOQuery.Create(Application);
        Connection := frmDBS.DBConnection;
        for i := 1 to length(PK) do
        begin
          tmp2 := tmp2 + fixleft(inttostr(ord(PK[i])),'0',3);
        end;
        SQL.Clear;
        SQL.Add('INSERT INTO OnlineCollectedRecs (Rest_Barcode ,Rest_Date,Rest_Time,Rest_RdrCode,Rest_RecState,Rest_User,Rest_IsPrint,Rest_ReplyPacket)');
        SQL.Add('VALUES('''', ');
        SQL.Add(''''', ');
        SQL.Add('0, ');
        SQL.Add(IntToStr(rdr.R_Code)+ ', ');
        SQL.Add('0, ');
        SQL.Add('''Rest5_1'', ');
        SQL.Add('1, ');
        SQL.Add('''' + tmp2 + ''') ');
        ExecSQL;
        Close;
        OK := True;
      end;
      FreeAndNil(adoQryService);
    {$else RestService}
    {$ifdef _GHSDK}
    mtt.PrintData(pk);
    {$else GHSDK}
    if not SendPocket(self,PK) then
      OK := False
    else
    begin
      GetPocket(self,PK, True, Status);
      if Length(pk)>3 then
      begin
        if (Status = 0) and (Ord(PK[3]) = rdr.r_code) then
        begin
          case Ord(PK[4]) of
            $06 : OK := True;
            $15 : OK := False;
            else  OK := False;
          end;
        end
        else
          OK := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdr.r_code));
      end
      else
      begin
        OK := False;
        rdr.RdrState := '*****';
      end;
    end;
    {$endif GHSDK}
    {$endif RestService}
  until (n = MaxLoop) or OK;
end;

function  TfrmOnline.makeStringCutPrint() : string;
var
  ST : String;
//  PK, tmp2 : String;
//  Status, n : Byte;
//  adoQryService : TADOQuery;
//  i : Integer;
begin
//  if not OK then Exit;
  if not rdr.R_PrnType in [PRN_CITIZEN3551, PRN_CITIZEN3541,PRN_ITHACA,PRN_SAMSUNG350,PRN_SAMSUNG350plus,PRN_CITIZENs2000] then Exit;
  case rdr.R_PrnType of
    PRN_CITIZEN3551,PRN_SAMSUNG350 : ST := #27'd0';
    PRN_SAMSUNG350plus,PRN_CITIZENs2000 : ST := #29 + #86 + #0;//#27'd0';
    PRN_CITIZEN3541 : ST := #27'P'#0;
    PRN_ITHACA  : ST := #27'd' + chr(10) + #27'v';
  end;
  makeStringCutPrint := ST;
end;

procedure TfrmOnline.FormCreate(Sender: TObject);
begin
  DTTM4ReadOnline := CurrentDate + ' ' + CurrentTimeWithSec; //kaveh
  fstSetDT_BS := True; //kaveh

  frmTcpUdp := TfrmTcpUdp.Create(Self);
  {$ifdef GHSDK}
  mtt := CoMTT5000.Create;
  {$endif}
  bigST := ''; //kaveh
  clearIFish(Last_Fish); //kaveh
  Last_Rest_ID := 0;
  {$ifdef SetDeviceTimeDate}
  {$ifndef RestService}
  tmrSetRdrTimeDate.Enabled := True;
  {$endif RestService}
  {$endif SetDeviceTimeDate}
end;

procedure TfrmOnline.FormDestroy(Sender: TObject);
begin
  frmTcpUdp.Free;
end;


procedure TfrmOnline.LoadFishsNo(TDate : String);
var
  i : Integer;
  adoQryG : TADOQuery;
begin
  Rdr_Sobh_Fish_No := 0; //kaveh 1;
  Rdr_Nahar_Fish_No := 0; //kaveh 1;
  Rdr_Sham_Fish_No := 0; //kaveh 1;
  Rdr_SobhNext_Fish_No := 0; //kaveh 1;
  with adoQryG do
  begin
    adoQryG := TADOQuery.Create(Application);
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT MAX(Fish_RdrFishNo) AS Max_Fish, fish_date , Fish_Type FROM Fish');
    SQL.Add('WHERE (Fish_Date = ''' + TDate + '''');
    SQL.Add('or Fish_Date = ''' + AddDate(TDate,1) + ''')');
    SQL.Add('AND   Fish_RdrCode = ' + IntToStr(rdr.R_Code));
    SQL.Add('GROUP BY Fish_Type,fish_Date');
    Open;
    First; //kaveh
    while not Eof do //kaveh
    begin //kaveh
      if FieldByName('Max_Fish').AsInteger <> 0 then
      begin
        if FieldByName('Fish_Date').AsString = TDate then
        begin
          case FieldByName('Fish_Type').AsInteger of
            MB_SOBH  : Rdr_Sobh_Fish_No := FieldByName('Max_Fish').AsInteger ;//kaveh + 1;
            MB_NAHAR : Rdr_Nahar_Fish_No := FieldByName('Max_Fish').AsInteger ;//kaveh + 1;
            MB_SHAM  : Rdr_Sham_Fish_No := FieldByName('Max_Fish').AsInteger ;//kaveh + 1;
            MB_SOBHNEXT : Rdr_SobhNext_Fish_No := FieldByName('Max_Fish').AsInteger ;//kaveh + 1;
          end;
        end
        else
          if FieldByName('Fish_Type').AsInteger = MB_SOBH then
            SobhNext_Fish_No := FieldByName('Max_Fish').AsInteger;
      end;
      Next;
    end; //kaveh
    Close;
  end;
end;

end.
