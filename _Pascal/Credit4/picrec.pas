unit PicRec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Globals, Buttons, Grids, ComCtrls, RunCmnds, DB,
  ADODB, MPlayer, VrControls, VrAnalog,msgs;

type
  TfrmPictureRec = class(TForm)
    Timer1: TTimer;
    grdRecs: TStringGrid;
    prgBar: TProgressBar;
    lblConnect: TLabel;
    adotblRecs: TADOQuery;
    mp: TMediaPlayer;
    pnlPicture: TPanel;
    imgPicture: TImage;
    lblCredit: TLabel;
    lblCommonBox: TLabel;
    procedure btnYesClick(Sender: TObject);
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
    procedure ViewRecord(p : TPerson; ClkRec : TTerminalRec);
    procedure ViewSymbol(IsRec : Boolean);
    Procedure InitDB;
  public
    { Public declarations }
    p : TPerson;
    rdrIdxSet : Set of 0..255;
    permanent : Boolean;
    ViewFromDB : Boolean;
    authorized : TStringList;
    function SendAuthority : boolean;
  end;


implementation

uses
  DBS, Z84_CMD, Z80_CMD, ComTools, TimeTool,DateProc, Funcs, TCP_UDP,request,main;


{$R *.DFM}




procedure TfrmPictureRec.SetWinF;
begin
  Caption := (Caption);
end;

procedure TfrmPictureRec.InitialGridCels;
begin
  grdRecs.FixedCols := 0;
  grdRecs.ColCount := 5;
  grdRecs.RowCount := 2;

  grdRecs.Cols[0].Add(('شماره صندوق'));
  grdRecs.ColWidths[0] := 90;

  grdRecs.Cols[1].Add(('نام خانوادگي - نام'));
  grdRecs.ColWidths[1] := 300;

  grdRecs.Cols[2].Add(('تاريخ سررسيد قرارداد'));
  grdRecs.ColWidths[2] := 150;

  grdRecs.Cols[3].Add(('زمان'));
  grdRecs.ColWidths[3] := 50;

  grdRecs.Cols[4].Add(('وضعيت'));
  grdRecs.ColWidths[4] := 200;
end;


procedure TfrmPictureRec.ViewSymbol(IsRec : Boolean);
begin
  if IsRec then
  begin
    if not ErrRec then
      Inc(RecNo)
    else
      Inc(ErrRecNo);
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

  grdRecs.Cells[0, r] := p.P_Box;

  if p.P_IsLegalCustomer then
    grdRecs.Cells[1, r] := p.P_Family + '-' + p.P_Name + ' (شرکت ' + p.p_CoName + ')'
  else
    grdRecs.Cells[1, r] := p.P_Family + '-' + p.P_Name;

  grdRecs.Cells[2, r] := '   ' + p.P_ContractEndDate + '   ';
  grdRecs.Cells[3, r] := IntToTime(ClkRec.rdrTime);
  if ClkRec.rdrCode = readers[1].R_Code then
    grdRecs.Cells[4, r] := 'درخواست مجوز ورود'
  else if ClkRec.rdrCode = readers[2].R_Code then
    grdRecs.Cells[4, r] := 'ورود'
  else if ClkRec.rdrCode = readers[3].R_Code then
    grdRecs.Cells[4, r] := 'خروج';

//  lblBoxNo.Caption := 'صندوق شماره : ' + IntToStr(p.P_BoxNo);
//  lblName.Caption := p.P_Family + '-' + p.P_Name;
//  lblContractEndDate.Caption := 'سررسيد قرارداد : ' + p.P_ContractEndDate;

  if (p.P_ContractEndDate<>'') and (p.P_ContractEndDate<currentdate) then
      outofdate:=true
  else
      outofdate:=false;
  lblCredit.Caption := 'فاقد اعتبار';
  lblCredit.Visible := outofdate;
  if p.p_IsBlocked then
  begin
    lblCredit.Caption := 'مسدود شده';
    lblCredit.Visible := true;
  end;
//kaveh is
  if p.P_IsProvisionalBlocked then
  begin
    lblCredit.Caption := 'انسداد موقت';
    lblCredit.Visible := true;
  end;

  if p.P_IsCommonBox then
  begin

    if p.P_IsLegalCustomer then
    begin
      lblCommonBox.Caption := 'مشتری حقوقی';
      lblCommonBox.Visible := True;
    end
    else
    begin
      case p.P_CommonBoxType of
        0:begin
          lblCommonBox.Caption := 'مشترک گروهی';
          lblCommonBox.Visible := True;
        end;
        1:begin
          lblCommonBox.Caption := 'مشترک فردی';
          lblCommonBox.Visible := True;
        end;
        2:begin
          lblCommonBox.Caption := 'مشترک ترکیبی';
          lblCommonBox.Visible := True;
        end;
      end;
    end;

//    lblCommonBox.Caption := 'صندوق مشترک';
//    lblCommonBox.Visible := true;
  end
  else
  begin
    lblCommonBox.Visible := False;
  end;

//kaveh ie
  if FileExists(p.P_Picture) then
  begin
    imgPicture.Picture.LoadFromFile(p.P_Picture);
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
  isSent : boolean;
  frmRQ : tfrmrequest;
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
//          p := GetPerson(ClkRec.rdrCardCode, true); //kaveh
          p := GetnPerson(ClkRec.rdrCardCode, true); //kaveh
          if p.P_Code <> '' then
            ClkRec.rdrCardCode := p.P_Code;

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
            begin
              ViewSymbol(True);
              ViewRecord(p, ClkRec);
              if ClkRec.rdrCode = Readers[1].R_Code then
              begin
                frmRQ := TfrmRequest.Create(Application);
                frmRQ.p := p;
                frmRQ.Parent := frmMain;
                frmRQ.Align := alRight;
                frmRQ.BorderStyle := bsNone;
                frmRQ.Show;
              end
              else if (ClkRec.rdrCode = Readers[3].R_Code) then
              begin
                if authorized.IndexOf(p.P_Code) <> -1 then
                  authorized.Delete(authorized.IndexOf(p.P_Code));
                SendAuthority;
              end;
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
        lblConnect.Caption := ('ارتباط قطع')
      else
        lblConnect.Caption := '';
    end;
  end;
end;


procedure TfrmPictureRec.FormCreate(Sender: TObject);
begin
  SetWinF;
  OpenClockDBS(CurrentDate);
  R_Idx := 1;
  RecNo := 0;
  ErrRecNo := 0;
  InitialGridCels;
  lblConnect.Caption := '';
  ErrCount := 0;
  authorized := TStringList.Create;
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
  if TotalActvRdr =0 then exit;
  if Readers[R_Idx].r_IsCom then
  begin
    if  ComPortInitial(Readers[R_Idx]) then
      isTrue := true
    else
      isTrue := false;
  end
  else
    isTrue := true;


  if isTrue then
    Z84GetRecord(Readers[R_Idx]);

  Inc(R_Idx);
  if (R_Idx > TotalReader) then
    R_Idx := 1;


  if (FullScreen) and (frmMain.WindowState <> wsMaximized) then
  begin
    frmMain.WindowState := wsMaximized;
    FullScreen := False;
  end;
  with frmMain.StatusBar do
  begin
    Panels[0].Text := TimeToStr(Time);
    Panels[1].Text := CurrentDate + '  ' + LongDayNames[DayOfWeek(Date)];
  end;
end;

procedure TfrmPictureRec.btnYesClick(Sender: TObject);
var
  adoQry : TADOQuery;
begin
  with adoQry do
  begin
    adoQry := TADOQuery.Create(Application);
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select p_Code from persons where p_Code = ''' + FixLeft(p.P_Code,'0',8) + '''');
    Open;
  end;
  Timer1.Enabled := false;
  if SetAuthority(Readers[2], adoqry) then
      lblConnect.Caption := 'مجاز به ورود';
  Timer1.Enabled := true;
end;

procedure TfrmPictureRec.cmdExitClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TfrmPictureRec.InitDB;
begin
  CurrDate := CurrentDate;
  InitialGridCels;
  with adotblRecs do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from C' + copy(Currdate,1,4) + copy(Currdate,6,2) + ' where Clock_Date = ''' + Currdate + '''');
    SQL.Add('and Clock_Time >= ' + IntToStr(TimeToInt(CurrentTime)));
    SQL.Add('and Clock_chg = 0');
    Open;
    Last;
    LastRec := RecNo;
    ViewLastRec := false;
  end;
end;

function TfrmPictureRec.SendAuthority : boolean;
var
  adoQry : TADOQuery;
  s : string;
begin
  with adoQry do
  begin
    adoQry := TADOQuery.Create(Application);
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    s := frmPicRec.authorized.DelimitedText;
//    if F_Params.Admin_User <> '' then
//    begin
//      if s<>'' then
//        s := s + ',';
//      s := s;
//    end;

    if s='' then
      s := '0' ; //kaveh
//kaveh      s := 'xxxxxxxx' ;

//    InformationMessage(s);


//    SQL.Add('select p_proxi from persons where p_Code in (' + s  + ' ) union select ''' + fixleft(F_Params.Admin_User,'0',8)+ '''');
    SQL.Add('(select np_proxi from nPersons where (np_Code in (' + s  + ' )) and (np_proxi <> '''')) union (select ''' + fixleft(F_Params.Admin_User,'0',8)+ ''')');

//             (select np_proxi from nPersons where (np_code in (00000002  )) and (np_proxi <> ''  )) union (select '12345678')
    Open;
  end;
  result := SetAuthority(Readers[2], adoqry);
end;

end.
