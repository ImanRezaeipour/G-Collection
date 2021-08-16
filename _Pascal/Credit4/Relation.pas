unit Relation;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, DBTables, ExtCtrls, Mask, CPortCtl,
  RunCmnds, Menus, ADODB, VidGrab,SyncObjs;

type
  TfrmRelations = class(TForm)
    tmrTime: TTimer;
    grdRdrs: TStringGrid;
    grpSendGetDT: TGroupBox;
    lblDate: TLabel;
    lblTime: TLabel;
    txtDate: TEdit;
    cmbDT: TComboBox;
    txtTime: TEdit;
    grpLimit: TGroupBox;
    lbl1: TLabel;
    txtFromT1: TEdit;
    txtToT1: TEdit;
    lbl2: TLabel;
    txtToT2: TEdit;
    lbl4: TLabel;
    txtFromT2: TEdit;
    lbl3: TLabel;
    txtToT3: TEdit;
    lbl6: TLabel;
    txtFromT3: TEdit;
    lbl5: TLabel;
    cmbLimit: TComboBox;
    grpCardMsg: TGroupBox;
    lblCardMsg: TLabel;
    lblCardCode: TLabel;
    txtCardCode: TEdit;
    cmbMsg: TComboBox;
    grpDoor: TGroupBox;
    lblDoorTime: TLabel;
    txtDoorTime: TEdit;
    cmbDoorOp: TComboBox;
    grpRecovery: TGroupBox;
    lblRecovery: TLabel;
    txtRecoveryFDate: TEdit;
    lbl7: TLabel;
    cmbRecovery: TComboBox;
    lbl8: TLabel;
    txtRecoveryTDate: TEdit;
    grpView: TGroupBox;
    lbl9: TLabel;
    cmbView: TComboBox;
    grpBtns: TGroupBox;
    cmdTic: TBitBtn;
    cmdExit: TBitBtn;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdInvert: TBitBtn;
    grdMsg: TStringGrid;
    grpMsg: TGroupBox;
    lbl10: TLabel;
    grdRdrMsg: TStringGrid;
    chkPermanent: TCheckBox;
    chkViewFromDb: TCheckBox;
    grpAuthority: TGroupBox;
    cmbOperate: TComboBox;
    Label2: TLabel;
    adoQryPersons: TADOQuery;
    Label3: TLabel;
    rdoProxi: TRadioButton;
    rdoBarcode: TRadioButton;
    grpFingerPrg: TGroupBox;
    Label1: TLabel;
    rdoType1: TRadioButton;
    rdoType2: TRadioButton;
    rdoType3: TRadioButton;
    txtPath: TEdit;
    cmdPath: TButton;
    opnFile: TOpenDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mnuLinkTest: TMenuItem;
    mnuDateTime: TMenuItem;
    mnuLimitTime: TMenuItem;
    mnuCardMsg: TMenuItem;
    mnuMsg: TMenuItem;
    mnuCollect: TMenuItem;
    mnuRercovery: TMenuItem;
    N9: TMenuItem;
    mnuFinger: TMenuItem;
    mnuAuthority: TMenuItem;
    mnuReadVersion: TMenuItem;
    mnuRestart: TMenuItem;
    mnuInitial: TMenuItem;
    mnuDoors: TMenuItem;
    mnu: TMenuItem;
    mnuChangeAddr: TMenuItem;
    mnuChngBaud: TMenuItem;
    N2: TMenuItem;
    mnuLimitCard: TMenuItem;
    mnuKeys: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    mnuPishCard: TMenuItem;
    mnuOnlyCard: TMenuItem;
    mnuAlarm: TMenuItem;
    mnuAccessCode: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure mnuAccessCodeClick(Sender: TObject);
    procedure mnuAlarmClick(Sender: TObject);
    procedure mnuKeysClick(Sender: TObject);
    procedure mnuLimitCardClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure mnuChngBaudClick(Sender: TObject);
    procedure mnuChangeAddrClick(Sender: TObject);
    procedure mnuFingerClick(Sender: TObject);
    procedure mnuClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure mnuRercoveryClick(Sender: TObject);
    procedure mnuCollectClick(Sender: TObject);
    procedure mnuAuthorityClick(Sender: TObject);
    procedure mnuMsgClick(Sender: TObject);
    procedure mnuCardMsgClick(Sender: TObject);
    procedure mnuDoorsClick(Sender: TObject);
    procedure mnuLimitTimeClick(Sender: TObject);
    procedure mnuInitialClick(Sender: TObject);
    procedure mnuRestartClick(Sender: TObject);
    procedure mnuDateTimeClick(Sender: TObject);
    procedure mnuReadVersionClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure mnuLinkTestClick(Sender: TObject);
    procedure cmdPathClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure tmrTimeTimer(Sender: TObject);
    procedure cmdInvertClick(Sender: TObject);
    procedure cmdTicClick(Sender: TObject);
    procedure grdRdrsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtFromT1Exit(Sender: TObject);
    procedure txtFromT1KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT1Exit(Sender: TObject);
    procedure txtToT1KeyPress(Sender: TObject; var Key: Char);
    procedure txtFromT2Exit(Sender: TObject);
    procedure txtFromT2KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT2Exit(Sender: TObject);
    procedure txtToT2KeyPress(Sender: TObject; var Key: Char);
    procedure txtFromT3Exit(Sender: TObject);
    procedure txtFromT3KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT3Exit(Sender: TObject);
    procedure txtToT3KeyPress(Sender: TObject; var Key: Char);
    procedure txtCardCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbMsgKeyPress(Sender: TObject; var Key: Char);
    procedure cmbMsgClick(Sender: TObject);
    procedure cmbDoorOpClick(Sender: TObject);
    procedure cmbLimitKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDoorOpKeyPress(Sender: TObject; var Key: Char);
    procedure txtRecoveryFDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtRecoveryFDateExit(Sender: TObject);
    procedure txtRecoveryTDateExit(Sender: TObject);
    procedure grdMsgKeyPress(Sender: TObject; var Key: Char);
    procedure grdRdrMsgKeyPress(Sender: TObject; var Key: Char);
    procedure chkViewFromDbClick(Sender: TObject);
    procedure mnuOnlyCardClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitialGridCels;
    procedure FillGrid;
    procedure ClearGridMessage;
    procedure MakeRdrSelIdx;

    procedure SendTab(var Key : Char);

    function  Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
    function  Z84GetAllRecord(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte) : Boolean;

    procedure Z80AllCollect(rdrInf : TReaders; i : Byte);
    procedure Z80AllRecovery(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte);

  public
    { Public declarations }
    ActionType : Byte;
    THDlIST : TThreadList;
  end;

type
  TClkRecs = array of TTerminalRec;
  TSaveRecordThread = class(TThread)
  private
    FClkRecs : TClkRecs;
  protected
    constructor Create(ClkRecs : TClkRecs);
    procedure Execute; override;
  end;
var
  prmsn : TCriticalSection;
  thdCount : integer;

implementation

uses
  MSGs, ComTools, DateProc, Globals, FarsiApi, Keyboard, DBS,
  Z80_CMD, Z84_CMD, Funcs, Code_Sys,
  TCP_UDP, ChngAddr,ChngBaud,
  KeyPdChg, RdrList, InVldCrd, Alarms, AcesCode, LmitCard,
  FuncKeys, fingerPrg,FingerPrg2,onlycard;

{$R *.DFM}

const
  MB_SEND_DT    = 0;
  MB_GET_DT     = 1;
  MB_SEND_LIMIT = 0;
  MB_GET_LIMIT  = 1;

var
  ReaderList : Set of 0..255;

constructor TSaveRecordThread.Create(ClkRecs : TClkRecs);
var
  i : integer;
begin
  FreeOnTerminate := true;
  inherited Create(false);
  SetLength(FClkRecs,LENGTH(ClkRecs));
  FOR I := 0 TO LENGTH(ClkRecs)-1 DO
  begin
    FClkRecs[i].rdrCardCode   := ClkRecs[i].rdrCardCode;
    FClkRecs[i].rdrDate       := ClkRecs[i].rdrDate;
    FClkRecs[i].rdrTime       := ClkRecs[i].rdrTime;
    FClkRecs[i].rdreTime      := ClkRecs[i].rdreTime;
    FClkRecs[i].rdrCode       := ClkRecs[i].rdrCode;
    FClkRecs[i].rdrStatus     := ClkRecs[i].rdrStatus;
    FClkRecs[i].rdrBDate      := ClkRecs[i].rdrBDate;
    FClkRecs[i].rdrBTime      := ClkRecs[i].rdrBTime;
    FClkRecs[i].rdrBeTime     := ClkRecs[i].rdrBeTime;
    FClkRecs[i].rdrBStatus    := ClkRecs[i].rdrBStatus;
    FClkRecs[i].rdrBRdrCode   := ClkRecs[i].rdrBRdrCode;
    FClkRecs[i].rdrChng       := ClkRecs[i].rdrChng;
    FClkRecs[i].rdrUser       := ClkRecs[i].rdrUser;
    FClkRecs[i].rdrPayment    := ClkRecs[i].rdrPayment;
    FClkRecs[i].rdrAgreeCode  := ClkRecs[i].rdrAgreeCode;
    FClkRecs[i].rdrFirstAgree := ClkRecs[i].rdrFirstAgree;
    FClkRecs[i].rdrFinalAgree := ClkRecs[i].rdrFinalAgree;
  end;
  inc(thdCount);
end;
procedure TSaveRecordThread.Execute;
var
  errrec : boolean;
  j : integer;
begin
  errrec := false;
//  prmsn.Acquire;
  for j := 0 to Length(FClkRecs)-1 do
    SaveClockRecord(FClkRecs[j], REC_TEST, ErrRec);
//  prmsn.Release;
  Terminate;
  dec(thdCount);
end;

procedure TfrmRelations.InitialGridCels;
begin
  if TotalReader = 0 then
  begin
    grdRdrs.FixedRows := 0;
    grdRdrs.RowCount := 1;
  end
  else
  begin
    grdRdrs.FixedRows := 1;
    grdRdrs.RowCount := TotalReader + 1;
  end;
  grdRdrs.FixedCols := 0;
  grdRdrs.ColCount := 4;

  grdRdrs.Cols[0].Add(' ');
  grdRdrs.ColWidths[0] := 30;

  grdRdrs.Cols[1].Add(('كد دستگاه'));
  grdRdrs.ColWidths[1] := 55;

  grdRdrs.Cols[2].Add(('نام دستگاه'));
  grdRdrs.ColWidths[2] := 155;

  grdRdrs.Cols[3].Add(('نتيجه'));
  //grdRdrs.ColWidths[3] := 280;
  grdRdrs.ColWidths[3] := grdRdrs.Width -
                          grdRdrs.ColWidths[2] -
                          grdRdrs.ColWidths[1] -
                          grdRdrs.ColWidths[0] - 10;
end;

procedure TfrmRelations.FillGrid;
var i : Byte;
begin
  for i := 1 to TotalReader do
  begin
    grdRdrs.Cells[0, i] := '';
    grdRdrs.Cells[1, i] := IntToStr(Readers[i].R_Code);
    grdRdrs.Cells[2, i] := Readers[i].R_Name;
    grdRdrs.Cells[3, i] := '';
  end;
end;

procedure TfrmRelations.ClearGridMessage;
var i : Byte;
begin
  for i := 1 to grdRdrs.RowCount do grdRdrs.Cells[3, i] := '';
  grdRdrs.Refresh;
end;

procedure TfrmRelations.MakeRdrSelIdx;
var i : Byte;
begin
  ReaderList := [];
  for i := 1 to grdRdrs.RowCount do
    if grdRdrs.Cells[0, i] = 'X' then
        ReaderList := ReaderList + [i];
end;

procedure TfrmRelations.mnuInitialClick(Sender: TObject);
begin
  ActionType := RDR_INITIAL;
  Hide;
  show;
end;

procedure TfrmRelations.mnuDateTimeClick(Sender: TObject);
begin
  ActionType := RDR_DATETIME;
  Hide;
  show;
end;

procedure TfrmRelations.mnuLinkTestClick(Sender: TObject);
begin
  ActionType := RDR_TEST;
  Hide;
  show;
end;

procedure TfrmRelations.mnuReadVersionClick(Sender: TObject);
begin
  ActionType := RDR_VER;
  Hide;
  show;
end;

procedure TfrmRelations.mnuRestartClick(Sender: TObject);
begin
  ActionType := RDR_RESTART;
  Hide;
  show;
end;

procedure TfrmRelations.mnuClick(Sender: TObject);
begin
  ActionType := RDR_VIEWREC;
  chkViewFromDb.Checked := true;
  chkViewFromDb.Hide;
  chkPermanent.Hide;
  Hide;
  show;
end;

procedure TfrmRelations.mnuFingerClick(Sender: TObject);
begin
  ActionType := RDR_FingerPrg;
  Hide;
  show;
end;

procedure TfrmRelations.mnuChangeAddrClick(Sender: TObject);
var frmChngAddr : TfrmChngAddr;
begin
//  AddUserAction(mnuChangeAddr.Caption);
  Application.CreateForm(TfrmChngAddr, frmChngAddr);
  frmChngAddr.ShowModal;
  frmChngAddr.Free;
end;

procedure TfrmRelations.N2Click(Sender: TObject);
var frmKeypayPassword : TfrmKeypayPassword;
begin
//  AddUserAction(mnuKeypadPassword.Caption);
  Application.CreateForm(TfrmKeypayPassword, frmKeypayPassword);
  frmKeypayPassword.ShowModal;
  frmKeypayPassword.Free;
end;

procedure TfrmRelations.mnuAccessCodeClick(Sender: TObject);
var frmAccessCode : TfrmAccessCode;
begin
//  AddUserAction(mnuAccessCode.Caption);
  Application.CreateForm(TfrmAccessCode, frmAccessCode);
  frmAccessCode.ShowModal;
  frmAccessCode.Free;
end;

procedure TfrmRelations.mnuKeysClick(Sender: TObject);
var frmFunctionKeys : TfrmFunctionKeys;
begin
//  AddUserAction(mnuKeys.Caption);
  Application.CreateForm(TfrmFunctionKeys, frmFunctionKeys);
  frmFunctionKeys.ShowModal;
  frmFunctionKeys.Free;
end;

procedure TfrmRelations.mnuLimitCardClick(Sender: TObject);
var frmLimitCard : TfrmLimitCard;
begin
  Application.CreateForm(TfrmLimitCard, frmLimitCard);
  frmLimitCard.ShowModal;
  frmLimitCard.Free;
end;

procedure TfrmRelations.N9Click(Sender: TObject);
begin
  ActionType := RDR_VIEWREC;
  Hide;
  show;
end;

procedure TfrmRelations.mnuRercoveryClick(Sender: TObject);
begin
  ActionType := RDR_RECOVERY;
  Hide;
  show;
end;

procedure TfrmRelations.mnuCollectClick(Sender: TObject);
begin
  ActionType := RDR_COLLECT;
  Hide;
  show;
end;

procedure TfrmRelations.mnuChngBaudClick(Sender: TObject);
var frmChngBaud: TfrmChngBaud;
begin
  Application.CreateForm(TfrmChngBaud, frmChngBaud);
  frmChngBaud.ShowModal;
  frmChngBaud.Free;
end;

procedure TfrmRelations.mnuAlarmClick(Sender: TObject);
var frmAlarms : TfrmAlarms;
begin
//  AddUserAction(mnuAlarms.Caption);
  Application.CreateForm(TfrmAlarms, frmAlarms);
  frmAlarms.ShowModal;
  frmAlarms.Free;
end;

procedure TfrmRelations.mnuAuthorityClick(Sender: TObject);
begin
  ActionType := RDR_Authority;
  Hide;
  show;
end;

procedure TfrmRelations.mnuMsgClick(Sender: TObject);
begin
  ActionType := RDR_MSG;
  Hide;
  show;
end;

procedure TfrmRelations.mnuOnlyCardClick(Sender: TObject);
var
  frmOnlyCard: TfrmOnlyCard;
begin
//  AddUserAction(mnuOnlyCard.Caption);
  Application.CreateForm(TfrmOnlyCard, frmOnlyCard);
  frmOnlyCard.ShowModal;
  frmOnlyCard.Free;
end;
procedure TfrmRelations.mnuCardMsgClick(Sender: TObject);
begin
  ActionType := RDR_CARDMSG;
  Hide;
  show;
end;

procedure TfrmRelations.mnuDoorsClick(Sender: TObject);
begin
  ActionType := RDR_DOORS;
  Hide;
  show;

end;

procedure TfrmRelations.mnuLimitTimeClick(Sender: TObject);
begin
  ActionType := RDR_LIMITTIME;
  Hide;
  show;
end;

procedure TfrmRelations.SendTab(var Key : Char);
var cntrl : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    cntrl := FindNextControl(ActiveControl, True, True, False);
    cntrl.SetFocus;
  end;
end;
function TfrmRelations.Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
var
  n, retVal, getVal : Byte;
  S_PK, G_PK : String;
  {ClkRec,} befRec : TTerminalRec;
  ClkRecs : TClkRecs;
  j, PacketRecCount : integer;
  ErrRec : Boolean;
  p : TPerson;
  mustsave : boolean;
  stat : integer;
  function UnPackRecord(PK : string) : string;
  begin
    Result := '11111' + FixLeft(IntToStr(ord(pk[1])),'0',3);
    Result := Result + PBCD_Str(copy(pk,2,10),20);
  end;
begin
  if F_Params.FastCollect = 1 then stat := $55 else stat := 0;

  Z84AllCollect := False;
  befRec.rdrCode := 0;
  mustsave:=false;
  if rdrInf.R_IsCom and not ComPortInitial(rdrInf) then
    Exit;
  {$region 'get first Record'}
  case rType of
    ALL_COLLECTION: Z84_MakePOcket(S_PK, rdrInf.r_Code, $02,  stat , '');
    ALL_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $2E,  stat, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
    NEW_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $30,  stat, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
  end;

  if rdrInf.r_IsCom and not SendPocket(S_PK) then
    retVal := ERR_OFF
  else if not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
    retVal := ERR_OFF
  else if not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
    retVal := ERR_OFF
  else
  begin
    if rdrInf.r_IsCom then
      Z84_GetPocket(G_PK, 30 , 300, getVal)
    else if rdrInf.r_TCP then
    begin
      Sleep(100);
      TCPReadData(G_PK, getVal)
    end
    else
    begin
//      Sleep(200);
      UDPReadData(G_PK, getVal);
    end;

    if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.R_Code) then
    begin
      case Ord(G_PK[4]) of
        $03: //Buffer Empty
          retVal := MB_BUFFEMPTY;

        $04: //Record Exists
        begin
          {$region 'one Record in one Packet'}
          retVal := MB_TRUEREC;
          SetLength(ClkRecs,1);
          PacketRecCount := 1;
          ClkRecs[0] := Z84_AnalizeData(G_PK, ErrRec);

          p := GetPerson(ClkRecs[0].rdrCardCode, True);
          if p.P_Code <> '' then
            ClkRecs[0].rdrCardCode := p.P_Code;
          mustsave:=true;

          if (befRec.rdrCode <> ClkRecs[0].rdrCode) or
             (befRec.rdrCardCode <> ClkRecs[0].rdrCardCode) or
             (befRec.rdrDate <> ClkRecs[0].rdrDate) or
             (befRec.rdrTime <> ClkRecs[0].rdrTime) then
          begin
            befRec := ClkRecs[0];
            if not ErrRec then
              Inc(RecNo)
            else
              Inc(ErrRecNo);
          end;

          grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
          grdRdrs.Refresh;
          {$endregion 'one Record in one Packet'}
        end;
        $5A: //Record Exists
        begin
          {$region 'multiple Record in One Packet'}
          retVal := MB_TRUEREC;
          SetLength(ClkRecs,20);
          PacketRecCount := (Ord(G_PK[2])-4) div 11;
          for j :=0 to PacketRecCount-1 do
          begin
            ClkRecs[j] := Z84_AnalizeData(UnPackRecord(copy(G_PK,6+(j*11),11)), ErrRec);
            p := GetPerson(ClkRecs[j].rdrCardCode, True);
            if p.P_Code <> '' then
              ClkRecs[j].rdrCardCode := p.P_Code;
            mustsave:=true;

            if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
               (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
               (befRec.rdrDate <> ClkRecs[j].rdrDate) or
               (befRec.rdrTime <> ClkRecs[j].rdrTime) then
            begin
              befRec := ClkRecs[i];
              if not ErrRec then
                Inc(RecNo)
              else
                Inc(ErrRecNo);
            end;
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
          end;
          {$endregion 'multiple Record in One Packet'}
        end;
        {$region 'other'}
        $15:
          retVal := MB_TRUEREC;
        else //Error in read data
          retVal := MB_BADREC;
        {$endregion 'other'}
      end;
    end
    else if getVal = ERR_OFF then
      retVal := ERR_OFF
    else
      retVal := MB_BADREC;
  end;
  {$endregion 'get first Record'}
  n := 0;
  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    {$region 'get other Record'}
    if retVal = MB_TRUEREC then
    begin
      Z84_MakePocket(S_PK, rdrInf.r_Code, $06, stat, '');
      n := 0;
    end
    else if retVal = MB_BADREC then
      Z84_MakePocket(S_PK, rdrInf.r_Code, $15, stat, '')
    else if retVal = ERR_OFF then
    begin
      if (n > 1) and (rType = ALL_COLLECTION) then
        //Z84AllCollect(rdrInf, aDate, rType, i, RecNo, ErrRecNo)
        Z84_Makepocket(S_PK, rdrInf.r_Code, $02,  stat, '')
      else
        S_PK := '';
    end;


    if rdrInf.r_IsCom and not SendPocket(S_PK) then
      retVal := ERR_OFF
    else if (S_PK <> '') and not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
      retVal := ERR_OFF
    else if (S_PK <> '') and not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
      retVal := ERR_OFF
    else
    begin
      if mustsave then
      for j := 0 to PacketRecCount-1 do
        SaveClockRecord(ClkRecs[j], REC_TEST, ErrRec);
//      TSaveRecordThread.Create(ClkRecs);
      mustsave:=false;
      if rdrInf.r_IsCom then
        Z84_Getpocket(G_PK, 0, 300, getVal)
      else if rdrInf.r_TCP then
      begin
        Sleep(100);
        TCPReadData(G_PK, getVal)
      end
      else
      begin
//        Sleep(50);
        UDPReadData(G_PK, getVal);
      end;

      if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.r_Code) then
      begin
        case Ord(G_PK[4]) of
          $03: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          $04: //Record Exists
          begin
            retVal := MB_TRUEREC;
            n := 0;
            ClkRecs[0] := Z84_AnalizeData(G_PK,  ErrRec);

            p := GetPerson(ClkRecs[0].rdrCardCode, True);
            if p.P_Code <> '' then
              ClkRecs[0].rdrCardCode := p.P_Code;
            mustsave:=true;

            if (befRec.rdrCode <> ClkRecs[0].rdrCode) or
               (befRec.rdrCardCode <> ClkRecs[0].rdrCardCode) or
               (befRec.rdrDate <> ClkRecs[0].rdrDate) or
               (befRec.rdrTime <> ClkRecs[0].rdrTime) then
            begin
              befRec := ClkRecs[0];
              if not ErrRec then
                Inc(RecNo)
              else
                Inc(ErrRecNo);
            end;
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
          end;
          $5A: //Record Exists
          begin
            {$region 'multiple Record in One Packet'}
            retVal := MB_TRUEREC;
            PacketRecCount := (Ord(G_PK[2])-4) div 11;
            for j :=0 to PacketRecCount-1 do
            begin
              ClkRecs[j] := Z84_AnalizeData(UnPackRecord(copy(G_PK,6+(j*11),11)), ErrRec);
              p := GetPerson(ClkRecs[j].rdrCardCode, True);
              if p.p_Code <> '' then
                ClkRecs[j].rdrCardCode := p.P_Code;
              mustsave:=true;

              if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
                 (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
                 (befRec.rdrDate <> ClkRecs[j].rdrDate) or
                 (befRec.rdrTime <> ClkRecs[j].rdrTime) then
              begin
                befRec := ClkRecs[i];
                if not ErrRec then
                  Inc(RecNo)
                else
                  Inc(ErrRecNo);
              end;
              grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
              grdRdrs.Refresh;
            end;
            {$endregion 'multiple Record in One Packet'}
          end;
          $15:
            retVal := MB_TRUEREC;


          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else if getVal = ERR_OFF then
        retVal := ERR_OFF
      else
        retVal := MB_BADREC;
    end;
    if retVal in [ERR_OFF, MB_BADREC] then
    begin
      Inc(n);
      if rType = ALL_RECOVERY then
        Sleep(1000);
    end;
    n:= n +1;
    {$endregion 'get other Record'}
  end;
  {$region 'view Opreration'}
  if RecNo > 0 then
  begin
    if retVal = MB_BUFFEMPTY then
    begin
      if ErrRecNo > 0 then
      begin
        Z84AllCollect := True;
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل بازيابي شد';
      end
      else
      begin
        Z84AllCollect := True;
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل بازيابي شد';
      end;
    end
    else
    begin
      if ErrRecNo > 0 then
      begin
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص بازيابي شد';
      end
      else
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص جمع آوري شد'
        else
        begin
          //Z84AllCollect := True;
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص بازيابي شد';
        end;
    end;
  end
  else if retVal = MB_BUFFEMPTY then
  begin
    Z84AllCollect := True;
    if rType <> ALL_RECOVERY then
      grdRdrs.Cells[3, i] := 'هيچ ركورد جديدي وجود ندارد'
    else
      grdRdrs.Cells[3, i] := 'ركوردي براي بازيابي وجود ندارد';
  end
  else
    grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';

  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
  grdRdrs.Refresh;
  {$endregion 'view Opreration'}
end;


function TfrmRelations.Z84GetAllRecord(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte) : Boolean;
var
  GoodRec, BadRec : Integer;
begin
  Z84GetAllRecord := True;
  GoodRec := 0;
  BadRec := 0;
  if FDate = '' then FDate := CurrentDate;
  if TDate = '' then TDate := FDate;

  while FDate <= TDate do
  begin
    Msg_Wait('بازيابي ركوردهاي تاريخ : ' + FDate);
    if not Z84AllCollect(rdrInf, FDate, rType, i, GoodRec, BadRec) then
    begin
      Z84GetAllRecord := False;
      MSG_NoWait;
      Break;
    end;
    FDate := AddDate(FDate, 1);
    MSG_NoWait;
  end;
end;
procedure TfrmRelations.Z80AllCollect(rdrInf : TReaders; i : Byte);
var
  n, retVal : Byte;
  IsFirst, ErrRec : Boolean;
  Data : String;
  RecNo, ErrRecNo : Integer;
  ClkRec : TTerminalRec;
  p : TPerson;
  mustsave:boolean;
begin
  IsFirst := True;
  retVal := MB_OK;
  n := 1;
  RecNo := 0;
  ErrRecNo := 0;
  mustsave:=false;

  OpenClockDBS(CurrentDate);
  if ComPortInitial(rdrInf) then
    repeat
      Z80_Collection(IsFirst, retVal, Data);
      if mustsave then SaveClockRecord(ClkRec, REC_TEST, ErrRec);
      mustsave:=false;
      Inc(n);

      if retVal = MB_TRUEREC then
      begin
        n := 1;
        IsFirst := False;
        ClkRec := Z80_AnalizeData(Data, p, ErrRec);
        mustsave:=true;
        if not ErrRec then
          Inc(RecNo)
        else
          Inc(ErrRecNo);
        grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + InttoStr(ErrRecNo);
        grdRdrs.Refresh;
      end;
    until (retVal = MB_BUFFEMPTY) or (n = 4);

  CloseClockDBS;
  if RecNo > 0 then
  begin
    if retVal = MB_BUFFEMPTY then
    begin
      if ErrRecNo > 0 then
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد صحيح و ' + IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل جمع آوري شد'
      else
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد بطور كامل جمع آوري شد';
    end
    else
    begin
      if ErrRecNo > 0 then
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد صحيح و ' + IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص جمع آوري شد'
      else
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد بطور ناقص جمع آوري شد';
    end;
  end
  else if retVal = MB_BUFFEMPTY then
    grdRdrs.Cells[3, i] := 'هيچ ركورد جديدي وجود ندارد'
  else
    grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';
  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
  grdRdrs.Refresh;
end;

(***************** Recovery Records *****************)
procedure TfrmRelations.Z80AllRecovery(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte);
var
  retVal, n : Byte;
  Data : String;
  RecNo, ErrRecNo : Integer;
  ClkRec : TTerminalRec;
  p : TPerson;
  IsFirst, ErrRec : Boolean;
  f : TextFile;
  mustsave:boolean;
begin
  retVal := MB_OK;
  n := 1;
  RecNo := 0;
  ErrRecNo := 0;
  mustsave:=false;

  if ComPortInitial(rdrInf) then
    while FDate <= TDate do
    begin
      IsFirst := True;
      MSG_Wait('درحال بازيابي ركوردهاي تاريخ : ' + FDate);
      if rType = ALL_RECOVERY then
      begin
        OpenClockDBS(FDate);
        repeat
          Z80_RecoveryOneRecord(FDate, IsFirst, retVal, Data);
          if mustsave then SaveClockRecord(ClkRec, REC_TEST, ErrRec);
          mustsave:=false;
          Inc(n);
          if retVal = MB_TRUEREC then
          begin
            n := 1;
            ClkRec := Z80_AnalizeData(Data, p, ErrRec);
            mustsave:=true;
            if not ErrRec then
              Inc(RecNo)
            else
              Inc(ErrRecNo);
            IsFirst := False;
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
          end;
         until (retVal = MB_BUFFEMPTY) or (n = 2);

        CloseClockDBS;
      end
      else
      begin
        Z80_RecoveryNewRecord(FDate, retVal, RecNo);
        if RecNo > 0 then
        begin
          AssignFile(f, g_options.DataBasePath+'Z80Recs.Rec');
          ReSet(f);
          RecNo := 0;
          ErrRecNo := 0;
          while not Eof(f) do
          begin
            ReadLn(f, Data);
            ClkRec := Z80_AnalizeData(Data, p, ErrRec);
            SaveClockRecord(ClkRec, REC_TEST, ErrRec);

            if not ErrRec then
              Inc(RecNo)
            else
              Inc(ErrRecNo);
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
          end;
          CloseFile(f);
          DeleteFile(g_options.DataBasePath+'Z80Recs.Rec');
        end;
      end;

      FDate := AddDate(FDate, 1);
      MSG_NoWait;
    end;

  if RecNo > 0 then
  begin
    if retVal = MB_BUFFEMPTY then
    begin
      if ErrRecNo > 0 then
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد صحيح و ' + IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل جمع آوري شد'
      else
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد بطور كامل جمع آوري شد';
    end
    else
    begin
      if ErrRecNo > 0 then
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد صحيح و ' + IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص جمع آوري شد'
      else
        grdRdrs.Cells[3, i] := 'تعداد ' + IntToStr(RecNo) + ' ركورد بطور ناقص جمع آوري شد';
    end;
  end
  else if retVal = MB_BUFFEMPTY then
    grdRdrs.Cells[3, i] := 'هيچ ركورد جديدي وجود ندارد'
  else
    grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';

  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
  grdRdrs.Refresh;
end;



procedure TfrmRelations.FormCreate(Sender: TObject);
begin
  InitialGridCels;
  FillGrid;
  prmsn := TCriticalSection.Create;
end;

procedure TfrmRelations.FormHide(Sender: TObject);
begin
      grpSendGetDT.Visible := False;
      grpLimit.Visible := False;
      grpCardMsg.Visible := False;
      grpMsg.Visible := False;
      grpDoor.Visible := False;
      grpRecovery.Visible := False;
      grpView.Visible := False;
      grpRecovery.Visible := False;
      grpAuthority.Visible := False;
      grpFingerPrg.Visible := False;
end;

procedure TfrmRelations.FormShow(Sender: TObject);
begin
  case ActionType of
    RDR_TEST:
    begin
      cmdRun.Caption := 'ت&ست ارتباط';
      Caption := 'تست ارتباط با دستگاهها';
      HelpContext := 61;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_RESTART:
    begin
      cmdRun.Caption := 'راه اندازي &مجدد';
      Caption := 'راه اندازي مجدد دستگاهها';
      HelpContext := 62;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_VER:
    begin
      cmdRun.Caption := 'خواندن ن&سخه';
      Caption := 'خواندن نسخه دستگاهها';
      HelpContext := 63;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_DATETIME:
    begin
      txtDate.Text := CurrentDate;
      txtTime.Text := CurrentTime;
      cmbDT.Clear;
      cmbDT.Items.Add(('ارسال تاريخ و زمان'));
      cmbDT.Items.Add(('خواندن تاريخ و زمان'));
      cmbDT.ItemIndex := 0;
      cmdRun.Caption := 'ا&جرا';
      Caption := 'ارسال و دريافت تاريخ و زمان دستگاهها';
      tmrTime.Enabled := True;
      HelpContext := 64;

      grpSendGetDT.Visible := True;
      grdRdrs.Align := alTop;
      grpSendGetDT.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_LIMITTIME:
    begin
      cmbLimit.Clear;
      cmbLimit.Items.Add(('ارسال محدوده'));
      cmbLimit.Items.Add(('خواندن محدوده'));
      cmbLimit.ItemIndex := 0;
      cmdRun.Caption := 'ا&جرا';
      Caption := 'ارسال و دريافت محدوده زماني فعاليت كارتخوان';
      HelpContext := 68;

      grpLimit.Visible := True;
      grdRdrs.Align := alTop;
      grpLimit.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_CARDMSG:
    begin
      cmdRun.Caption := 'ا&جرا';
      Caption := 'معرفي پيام افراد';
      HelpContext := 71;

      grpCardMsg.Visible := True;
      grdRdrs.Align := alTop;
      grpCardMsg.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_MSG:
    begin
      cmdRun.Caption := 'ا&جرا';
      Caption := 'ارسال مستقيم پيام به ساعت';
      HelpContext := 0;

      grpMsg.Visible := True;
      grdRdrs.Align := alTop;
      grpMsg.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_DOORS:
    begin
      cmdRun.Caption := 'ا&جرا';
      Caption := 'كنترل باز و بسته بودن در';
      HelpContext := 75;

      grpDoor.Visible := True;
      grdRdrs.Align := alTop;
      grpDoor.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_COLLECT:
    begin
      cmdRun.Caption := '&جمع آوري';
      Caption := 'جمع آوري جديد اطلاعات از دستگاهها';
      HelpContext := 77;

      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_RECOVERY:
    begin
      txtRecoveryFDate.Text := CurrentDate;
      txtRecoveryTDate.Text := CurrentDate;
      cmdRun.Caption := '&بازيابي';
      Caption := 'بازيابي اطلاعات از دستگاهها';
      HelpContext := 78;

      grpRecovery.Visible := True;
      grdRdrs.Align := alTop;
      grpRecovery.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_VIEWREC:
    begin
      cmdRun.Caption := '&جمع آوري';
      Caption := 'جمع آوري دائمي ركوردهاي ساعت';
      cmbView.ItemIndex := 0;
      HelpContext := 79;

      grpView.Visible := True;
      grdRdrs.Align := alTop;
      grpView.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_INITIAL:
    begin
      txtRecoveryFDate.Text := CurrentDate;
      txtRecoveryTDate.Text := CurrentDate;
      cmdRun.Caption := '&پيكربندي';
      Caption := 'پيكربندي مجدد ساعت';
      cmbRecovery.ItemIndex := 0;
      HelpContext := 67;

      grpRecovery.Visible := True;
      grdRdrs.Align := alTop;
      grpRecovery.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_Authority:
    begin
      cmdRun.Caption := 'اجرا';
      Caption := ' لیست افراد مجاز به تردد';
      cmbOperate.ItemIndex := 0;
//      HelpContext := 67;

      grpAuthority.Visible := True;
      grdRdrs.Align := alTop;
      grpAuthority.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_FingerPrg:
    begin
      cmdRun.Caption := 'اجرا';
      Caption := ' انتقال اثر انگشت';
//      HelpContext := 67;
      grpFingerPrg.Visible := True;
      grdRdrs.Align := alTop;
      grpFingerPrg.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
  end;
end;

procedure TfrmRelations.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmRelations.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
   if Key in ['0'..'9', #8] then
     tmrTime.Enabled := False
   else
   begin
     SendTab(Key);
     Keyboard_Time(Key);
   end;
end;

procedure TfrmRelations.tmrTimeTimer(Sender: TObject);
begin
  txtTime.Text := CurrentTimes;
//  cmdRun.Caption := IntToStr(thdCount);
end;


procedure TfrmRelations.grdRdrsDblClick(Sender: TObject);
begin
  cmdTicClick(Sender);
end;

procedure TfrmRelations.cmbLimitKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmRelations.txtFromT1Exit(Sender: TObject);
begin
  if txtFromT1.Text <> '' then txtFromT1.Text := BeautifulTime(txtFromT1.Text);
end;

procedure TfrmRelations.txtFromT1KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT1Exit(Sender: TObject);
begin
  if txtToT1.Text <> '' then txtToT1.Text := BeautifulTime(txtToT1.Text);
end;

procedure TfrmRelations.txtToT1KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtFromT2Exit(Sender: TObject);
begin
  if txtFromT2.Text <> '' then txtFromT2.Text := BeautifulTime(txtFromT2.Text);
end;

procedure TfrmRelations.txtFromT2KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT2Exit(Sender: TObject);
begin
  if txtToT2.Text <> '' then txtToT2.Text := BeautifulTime(txtToT2.Text);
end;

procedure TfrmRelations.txtToT2KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtFromT3Exit(Sender: TObject);
begin
  if txtFromT3.Text <> '' then txtFromT3.Text := BeautifulTime(txtFromT3.Text);
end;

procedure TfrmRelations.txtFromT3KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT3Exit(Sender: TObject);
begin
  if txtToT3.Text <> '' then txtToT3.Text := BeautifulTime(txtToT3.Text);
end;

procedure TfrmRelations.txtToT3KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtCardCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
  Keyboard_Hex(Key);
end;

procedure TfrmRelations.cmbMsgKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  if Key = #32 then
  begin
    Key := #0;
    cmdTicClick(Sender);
  end;
end;

procedure TfrmRelations.cmbMsgClick(Sender: TObject);
begin
  case cmbMsg.ItemIndex of
    0:
    begin
      lblCardCode.Visible := True;
      txtCardCode.Visible := True;
      lblCardMsg.Visible := True;
      grdMsg.Visible := True;
    end;

    1,2:
    begin
      lblCardCode.Visible := True;
      txtCardCode.Visible := True;
      lblCardMsg.Visible := False;
      grdMsg.Visible := False;
    end;

    3:
    begin
      lblCardCode.Visible := False;
      txtCardCode.Visible := False;
      lblCardMsg.Visible := False;
      grdMsg.Visible := False;
    end;
  end;
end;

procedure TfrmRelations.cmbDoorOpKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmRelations.cmbDoorOpClick(Sender: TObject);
begin
  case cmbDoorOp.ItemIndex of
    0: lblDoorTime.Caption := ('&مدت زمان باز بودن در / ثانيه');
    1: lblDoorTime.Caption := ('&مدت زمان باز بودن در / دقيقه');
    2: lblDoorTime.Caption := ('&مدت زمان قفل بودن در / دقيقه');
  end;
end;

procedure TfrmRelations.txtRecoveryFDateExit(Sender: TObject);
begin
  with txtRecoveryFDate do
    if Text <> '' then Text := BeautifulDate(Text);
end;

procedure TfrmRelations.txtRecoveryFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmRelations.txtRecoveryTDateExit(Sender: TObject);
begin
  with txtRecoveryTDate do
    if Text <> '' then Text := BeautifulDate(Text);
end;

procedure TfrmRelations.cmdTicClick(Sender: TObject);
begin
  if grdRdrs.Row > 0 then
  begin
    if grdRdrs.Cells[0, grdRdrs.Row] = 'X' then
      grdRdrs.Cells[0, grdRdrs.Row] := ''
    else
      grdRdrs.Cells[0, grdRdrs.Row] := 'X';
  end;
end;

procedure TfrmRelations.cmdInvertClick(Sender: TObject);
var
  i : Byte;
begin
  for i := 1 to grdRdrs.RowCount do
    if grdRdrs.Cells[0, i] = 'X' then
      grdRdrs.Cells[0, i] := ''
    else
      grdRdrs.Cells[0, i] := 'X';
end;

procedure TfrmRelations.cmdRunClick(Sender: TObject);
var
  Good : Boolean;
  i, j, LastType : Byte;
  ST1, ST2, ST3, ST4, ST5 : String;
  grec, brec : Integer;
  fErr : TextFile;
  p : TPerson;
  lst : TStringList;
  w : dword;
  rdrSelectedCount: Integer;
  frmFingerPrg : TfrmFingerPrg;
  frmFingerPrg2 : TfrmFingerPrg2;
begin
  thdCount := 0;
  LastType := RDR_CLK6000;
  MakeRdrSelIdx;
  if ReaderList = [] then
    ErrorMessage('دستگاهي انتخاب نشده است')
  else
  begin
    case ActionType of
      RDR_TEST:
      begin
        Mouse_Wait;
        MSG_Wait('در حال تست ارتباط...');
        ClearGridMessage;

        for i := 1 to TotalReader do
          if i in ReaderList then
          begin
            if LastType = RDR_CLK120 then
              Sleep(2000);
            LastType := Readers[i].R_Type;

            if LinkTest(Readers[i]) then
              grdRdrs.Cells[3, i] := 'ارتباط برقرار است'
            else
              grdRdrs.Cells[3, i] := 'ارتباط برقرار نيست';
            grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
            grdRdrs.Refresh;
          end;
        Mouse_NoWait;
        MSG_NoWait;
      end;

      RDR_RESTART:
      begin
        Mouse_Wait;
        MSG_Wait('در حال راه اندازي مجدد...');
        ClearGridMessage;
        for i := 1 to TotalReader do
          if i in ReaderList then
          begin
            if LastType = RDR_CLK120 then
              Sleep(2000);
            LastType := Readers[i].R_Type;
            if ReStart(Readers[i]) then
              grdRdrs.Cells[3, i] := 'دستگاه راه اندازي شد.'
            else
              grdRdrs.Cells[3, i] := 'راه اندازي دستگاه ناموفق بود';
            grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
            grdRdrs.Refresh;
          end;
        Mouse_NoWait;
        MSG_NoWait;
      end;

      RDR_VER:
      begin
        Mouse_Wait;
        MSG_Wait('در حال خواندن نسخه دستگاه...');
        ClearGridMessage;
        for i := 1 to TotalReader do
          if i in ReaderList then
          begin
             if ReadVersion(Readers[i], ST1) then
             begin
               Sleep(500);
               if ReadReaderErrors(Readers[i], ST2) then
               begin
                 ST1 := ST1 + ST2;
                 AssignFile(ferr, g_options.DataBasePath + 'RdrErr.Txt');
                 if not FileExists(g_options.DataBasePath + 'RdrErr.Txt') then
                   ReWrite(fErr)
                 else
                   Append(fErr);
                 WriteLn(fErr, CurrentDate, '= ', ST2);
                 CloseFile(fErr);
               end;
               grdRdrs.Cells[3, i] := ST1;
             end
             else
               grdRdrs.Cells[3, i] := 'خواندن نسخه دستگاه ناموفق بود';
            grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
            grdRdrs.Refresh;
          end;
        Mouse_NoWait;
        MSG_NoWait;
      end;

      RDR_DATETIME:
      begin
        if cmbDT.ItemIndex = MB_SEND_DT then
        begin
          ST1 := txtDate.Text;
          ST2 := txtTime.Text;
          good := True;
          j := StrToInt(Copy(ST2, 1, 2));
          if not (j in [0..23]) then good := False;
          j := StrToInt(Copy(ST2, 4, 2));
          if not (j in [0..59]) then good := False;
          j := StrToInt(Copy(ST2, 7, 2));
          if not (j in [0..59]) then good := False;

          if not good then
          begin
            ErrorMessage('زمان اشتباه است');
            Exit;
          end;
          if IsTrueDate(ST1) then
          begin
            ST1 := BeautifulDate(ST1);
            txtDate.Text := ST1;
          end
          else
          begin
            ErrorMessage('تاريخ اشتباه است');
            Exit;
          end;
          Mouse_Wait;
          MSG_Wait('در حال ارسال تاريخ و زمان...');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList  then
            begin
              if LastType = RDR_CLK120 then
                Sleep(2000);
              LastType := Readers[i].R_Type;
              if SendDateTime(Readers[i], ST1, ST2) then
                grdRdrs.Cells[3, i] := 'تاريخ و زمان ارسال شد'
              else
                grdRdrs.Cells[3, i] := 'ارسال تاريخ و زمان ناموفق بود';
              grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end
        else if cmbDT.ItemIndex = MB_GET_DT then
        begin
          Mouse_Wait;
          MSG_Wait('در حال خواندن تاريخ و زمان...');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList  then
            begin
              if LastType = RDR_CLK120 then
                Sleep(2000);
              LastType := Readers[i].R_Type;
              if GetDateTime(Readers[i], ST1, ST2) then
                grdRdrs.Cells[3, i] := 'تاريخ = ' + ST1 + '      زمان = ' + ST2
              else
                grdRdrs.Cells[3, i] := 'خواندن تاريخ و زمان ناموفق بود';
              grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end;
      end;

      RDR_LIMITTIME:
      begin
        if cmbLimit.ItemIndex = MB_SEND_LIMIT then
        begin
          Mouse_Wait;
          MSG_Wait('در حال ارسال محدوده...');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList then
            begin
              if txtFromT1.Text <> '' then ST1 := txtFromT1.Text
              else                         ST1 := '00:00';
              if txtToT1.Text <> '' then ST1 := ST1 + txtToT1.Text
              else                       ST1 := ST1 + '00:00';

              if txtFromT2.Text <> '' then ST2 := txtFromT2.Text
              else                         ST2 := '00:00';
              if txtToT2.Text <> '' then ST2 := ST2 + txtToT2.Text
              else                       ST2 := ST2 + '00:00';

              if txtFromT3.Text <> '' then ST3 := txtFromT3.Text
              else                         ST3 := '00:00';
              if txtToT3.Text <> '' then ST3 := ST3 + txtToT3.Text
              else                       ST3 := ST3 + '00:00';
              if SendLimitTime(Readers[i], ST1, ST2, ST3) then
                grdRdrs.Cells[3, i] := 'محدوده زماني ارسال شد'
              else
                grdRdrs.Cells[3, i] := 'ارسال محدوده زماني ناموفق بود';

              grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end
        else if cmbLimit.ItemIndex = MB_GET_LIMIT then
        begin
          Mouse_Wait;
          MSG_Wait('در حال خواندن محدوده...');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList then
            begin
              if GetLimitTime(Readers[i], ST1, ST2, ST3) then
                grdRdrs.Cells[3, i] := ST1 + ' و ' + ST2 + ' و ' + ST3
              else
                grdRdrs.Cells[3, i] := 'خواندن محدوده زماني ناموفق بود';

              grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end;
      end;

      RDR_CARDMSG:
      begin
        if cmbMsg.Text = '' then
        begin
          ErrorMessage('نوع عمليات مشخص نشده است.');
          Exit;
        end
        else if (cmbMsg.ItemIndex in [0..2]) and (txtCardCode.Text = '') then
        begin
          ErrorMessage('شماره كارت مشخص نيست.');
          Exit;
        end
        else
        begin
          case cmbMsg.ItemIndex of
            0: //Send Message for a card
            begin
              Mouse_Wait;
              MSG_Wait('در حال ارسال پيام...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  ST1 := txtCardCode.Text;
                  p := GetPerson(FixLeft(ST1, '0', 8), False);
                  ST2 := Win_To_IR(WinSysType, grdMsg.Cells[0, 0]);
                  ST3 := Win_To_IR(WinSysType, grdMsg.Cells[0, 1]);
                  ST4 := Win_To_IR(WinSysType, grdMsg.Cells[0, 2]);
                  ST5 := Win_To_IR(WinSysType, grdMsg.Cells[0, 3]);
                  case SendPersonMsg(Readers[i], ST1, ST2, ST3, ST4, ST5) of
                    $06: grdRdrs.Cells[3, i] := 'پيام ارسال شد.';
                    $42: grdRdrs.Cells[3, i] := 'شماره كارت تكراري است.';
                    $43: grdRdrs.Cells[3, i] := 'حافظه پيامها پر شده است.';
                    else grdRdrs.Cells[3, i] := 'ارسال پيام ناموفق بود.';
                  end;
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;

            1:  // Read a card message
            begin
              Mouse_Wait;
              MSG_Wait('در حال دريافت پيام...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  ST1 := txtCardCode.Text;
                  p := GetPerson(FixLeft(ST1, '0', 8), False);
                  case GetPersonMsg(Readers[i], ST1, ST2) of
                    $45: grdRdrs.Cells[3, i] := ('پيغامي براي اين كارت وجود ندارد');
                    $46: grdRdrs.Cells[3, i] := ('پيغام:') + IR_To_Win(WinSysType, ST2);
                    else grdRdrs.Cells[3, i] := ('دريافت پيام ناموفق بود');
                  end;
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;

            2:  // Delete a card message
            begin
              Mouse_Wait;
              MSG_Wait('در حال حذف پيام...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  ST1 := txtCardCode.Text;
                  p := GetPerson(FixLeft(ST1, '0', 8), False);
                  case DelPersonMsg(Readers[i], ST1) of
                    $06: grdRdrs.Cells[3, i] := 'پيام مربوطه حذف شد';
                    $45: grdRdrs.Cells[3, i] := 'پيغامي براي اين كارت وجود ندارد';
                    else grdRdrs.Cells[3, i] := 'حذف پيام ناموفق بود';
                  end;
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;

            3:  // Delete all message
            begin
              Mouse_Wait;
              MSG_Wait('در حال حذف كليه پيامها...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  if DeleteAllReaderMessage(Readers[i]) then
                    grdRdrs.Cells[3, i] := 'كليه پيامها حذف شد'
                  else
                    grdRdrs.Cells[3, i] := 'حذف پيامها امكان پذير نيست';
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                  grdRdrs.Refresh
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;
          end;
        end;
      end;

      RDR_MSG:
      begin
        Mouse_Wait;
        MSG_Wait('در حال ارسال پيام...');
        ClearGridMessage;
        for i := 1 to TotalReader do
          if i in ReaderList then
          begin
            ST1 := Win_To_IR(WinSysType, grdRdrMsg.Cells[0, 0]);
            ST2 := Win_To_IR(WinSysType, grdRdrMsg.Cells[0, 1]);
            ST3 := Win_To_IR(WinSysType, grdRdrMsg.Cells[0, 2]);
            ST4 := Win_To_IR(WinSysType, grdRdrMsg.Cells[0, 3]);
            if SendReaderMsg(Readers[i], ST1, ST2, ST3, ST4) then
              grdRdrs.Cells[3, i] := 'پيام ارسال شد.'
            else
              grdRdrs.Cells[3, i] := 'ارسال پيام ناموفق بود.';

            grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
          end;

        Mouse_NoWait;
        MSG_NoWait;
      end;


      RDR_DOORS:
      begin
        if cmbDoorOp.Text = '' then
        begin
          ErrorMessage('نوع عمليات مشخص نشده است.');
          cmbDoorOp.SetFocus;
        end
        else if txtDoorTime.Text = '' then
        begin
          ErrorMessage('مدت زمان وارد نشده است.');
          txtDoorTime.SetFocus;
        end
        else if ((StrToInt(txtDoorTime.Text) < 1) or (StrToInt(txtDoorTime.Text) > 255)) and
                (cmbDoorOp.ItemIndex = 0) then
        begin
          ErrorMessage('مدت زمان بايد بين 1 تا 255 باشد.');
          txtDoorTime.SetFocus;
        end
        else if ((StrToInt(txtDoorTime.Text) < 1) or (StrToInt(txtDoorTime.Text) > 44640)) and
                (cmbDoorOp.ItemIndex = 2) then
        begin
          ErrorMessage('مدت زمان بايد بين 1 تا 44640 (يك ماه) باشد.');
          txtDoorTime.SetFocus;
        end
        else
        begin
          case cmbDoorOp.ItemIndex of
            0: //Normal Mode + Open Time
            begin
              Mouse_Wait;
              MSG_Wait('در حال تنظيم باز بودن در...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  if LastType = RDR_CLK120 then
                    Sleep(2000);
                  LastType := Readers[i].R_Type;
                  if SetOpenDoor_Normal(Readers[i], StrToInt(txtDoorTime.Text)) then
                    grdRdrs.Cells[3, i] := 'مدت زمان باز بودن در در حالت عادي تنظيم شد'
                  else
                    grdRdrs.Cells[3, i] := 'تنظيم باز نمودن در ناموفق بود';
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                  grdRdrs.Refresh;
                end;

              Mouse_NoWait;
              MSG_NoWait;
            end;

            1:  // Always Open Door
            begin
              Mouse_Wait;
              MSG_Wait('در حال تنظيم بازبودن دائم در...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  if LastType = RDR_CLK120 then
                    Sleep(2000);
                  LastType := Readers[i].R_Type;
                  if SetOpenDoor_All(Readers[i], txtDoorTime.Text) then
                    grdRdrs.Cells[3, i] := 'مدت زمان باز بودن در در حالت دائم تنظيم شد'
                  else
                    grdRdrs.Cells[3, i] := 'تنظيم باز نمودن در ناموفق بود';
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                  grdRdrs.Refresh;
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;

            2:  // Close Door
            begin
              Mouse_Wait;
              MSG_Wait('در حال تنظيم بسته بودن در...');
              ClearGridMessage;
              for i := 1 to TotalReader do
                if i in ReaderList then
                begin
                  if LastType = RDR_CLK120 then
                    Sleep(2000);
                  LastType := Readers[i].R_Type;
                  if SetCloseDoor(Readers[i], txtDoorTime.Text) then
                    grdRdrs.Cells[3, i] := 'مدت زمان بسته بودن در تنظيم شد'
                  else
                    grdRdrs.Cells[3, i] := 'تنظيم بسته بودن در ناموفق بود';
                  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                  grdRdrs.Refresh;
                end;
              Mouse_NoWait;
              MSG_NoWait;
            end;
          end;
        end;
      end;

      RDR_COLLECT:
      begin
        Mouse_Wait;
        MSG_Wait('درحال جمع آوري ركوردهاي جديد...');
        ClearGridMessage;
        for i := 1 to TotalReader do
          if i in ReaderList then
            with Readers[i] do
            begin
               if Readers[i].R_Type = RDR_CLK120 then
                 Z80AllCollect(Readers[i], i)
               else
               begin
                 grec := 0;
                 brec := 0;
                 Z84AllCollect(Readers[i], '', ALL_COLLECTION, i, grec, brec);
               end;

            end;
        Mouse_NoWait;
        MSG_NoWait;
      end;

      RDR_RECOVERY:
      begin
        if cmbRecovery.Text = '' then
        begin
          ErrorMessage('نوع بازيابي مشخص نشده است.');
          cmbRecovery.SetFocus;
        end
        else if txtRecoveryFDate.Text = '' then
        begin
          ErrorMessage('تاريخ شروع بازيابي وارد نشده است.');
          txtRecoveryFDate.SetFocus;
        end
        else if txtRecoveryTDate.Text = '' then
        begin
          ErrorMessage('تاريخ پايان بازيابي وارد نشده است.');
          txtRecoveryTDate.SetFocus;
        end
        else if not IsTrueDate(txtRecoveryFDate.Text) then
        begin
          ErrorMessage('تاريخ شروع بازيابي نادرست است.');
          txtRecoveryFDate.SetFocus;
        end
        else if not IsTrueDate(txtRecoveryTDate.Text) then
        begin
          ErrorMessage('تاريخ پايان بازيابي نادرست است.');
          txtRecoveryTDate.SetFocus;
        end
        else if txtRecoveryTDate.Text < txtRecoveryFDate.Text then
        begin
          ErrorMessage('تاريخ پايان از تاريخ ابتدا كوچكتر است.');
          txtRecoveryTDate.SetFocus;
        end
        else
        begin
          Mouse_Wait;
          ClearGridMessage;
          if cmbRecovery.ItemIndex = 0 then
            j := ALL_RECOVERY
          else
            j := NEW_RECOVERY;
          for i := 1 to TotalReader do
            if i in ReaderList then
              with Readers[i] do
              begin
                 if Readers[i].R_Type = RDR_CLK6000 then
                   Z84GetAllRecord(Readers[i], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i)
                 else
                   Z80AllRecovery(Readers[i], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i);
              end;
          Mouse_NoWait;
        end;
      end;

      RDR_INITIAL:
      begin
        if not ConfirmMessage('با پيكربندي مجدد، كليه اطلاعات ترمينال از بين خواهد رفت. ادامه ميدهيد؟') then
          Exit;

        if cmbRecovery.Text = '' then
        begin
          ErrorMessage('نوع بازيابي مشخص نشده است.');
          cmbRecovery.SetFocus;
        end
        else if txtRecoveryFDate.Text = '' then
        begin
          ErrorMessage('تاريخ شروع بازيابي وارد نشده است.');
          txtRecoveryFDate.SetFocus;
        end
        else if txtRecoveryTDate.Text = '' then
        begin
          ErrorMessage('تاريخ پايان بازيابي وارد نشده است.');
          txtRecoveryTDate.SetFocus;
        end
        else if not IsTrueDate(txtRecoveryFDate.Text) then
        begin
          ErrorMessage('تاريخ شروع بازيابي نادرست است.');
          txtRecoveryFDate.SetFocus;
        end
        else if not IsTrueDate(txtRecoveryTDate.Text) then
        begin
          ErrorMessage('تاريخ پايان بازيابي نادرست است.');
          txtRecoveryTDate.SetFocus;
        end
        else if txtRecoveryTDate.Text < txtRecoveryFDate.Text then
        begin
          ErrorMessage('تاريخ پايان از تاريخ ابتدا كوچكتر است.');
          txtRecoveryTDate.SetFocus;
        end
        else
        begin
          Mouse_Wait;
          ClearGridMessage;
          if cmbRecovery.ItemIndex = 0 then
            j := ALL_RECOVERY
          else
            j := NEW_RECOVERY;

          for i := 1 to TotalReader do
            if i in ReaderList then
              with Readers[i] do
              begin
                 if Readers[i].R_Type = RDR_CLK6000 then
                 begin
                   if Z84GetAllRecord(Readers[i], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i) then
                   begin
                     Sleep(500);
                     if ReaderInitial(Readers[i]) then
                      grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال انجام شد.'
                    else
                      grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال ناموفق بود';
                   end;
                   grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                   grdRdrs.Refresh;
                 end
                 else
                   Z80AllRecovery(Readers[i], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i);
              end;
          Mouse_NoWait;
        end;
      end;
      RDR_Authority:
      begin
        lst := TStringList.Create;
        lst.Clear;

        if cmbOperate.ItemIndex = 0 then   // send list
        begin
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList  then
            begin
              if LastType = RDR_CLK120 then
                Sleep(2000);
              LastType := Readers[i].R_Type;

              with adoQryPersons do
              begin
                close;
                Connection := frmDBS.DBConnection;
                SQL.Clear;
                if rdoProxi.checked then
                  SQL.Add('select p_proxi from persons where p_isValid = 1 order by p_proxi')
                else
                  SQL.Add('select p_Code from persons where p_isValid = 1 order by p_Code');
                Open;
              end;
              Mouse_Wait;
              MSG_Wait('در حال ارسال لیست افراد مجاز تردد...' + '  تعداد : ' + IntToStr(adoQryPersons.RecordCount));

              if adoQryPersons.recordCount > 1500 then
                InformationMessage('امکان ارسال لیست بیشتر از 1500 نفر غیرممکن است .'
                + #13 + 'در صورت وجود مشتري  اضافی در لیست مشتريان آنها را بصورت غیر فعال درآورده و مجدادا اقدام نمایید.')
              else
              if SetAuthority(Readers[i], adoqryPersons) then
                grdRdrs.Cells[3, i] := 'ارسال لیست با موفقیت انجام شد . تعداد = ' + IntToStr(adoQryPersons.RecordCount)
              else
                grdRdrs.Cells[3, i] := 'ارسال لیست ناموفق بود .';
              grdRdrs.Refresh;
              Mouse_NoWait;
              MSG_NoWait;
            end;
        end
        else if cmbOperate.ItemIndex = 1 then   // get
        begin
          Mouse_Wait;
          MSG_Wait('در حال خواندن لیست افراد مجاز به تردد...');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList  then
            begin
              if LastType = RDR_CLK120 then
                Sleep(2000);
              LastType := Readers[i].R_Type;
              if GetAuthority(Readers[i] , lst) then
                grdRdrs.Cells[3, i] := 'تعداد = ' + lst.Strings[0] //(lst.Count)
              else
                grdRdrs.Cells[3, i] := 'خواندن لیست افراد مجاز به تردد ناموفق بود .';
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end
        else if cmbOperate.ItemIndex = 2 then   // empty list
        begin
          lst := TStringList.Create;
          lst.Clear;

          Mouse_Wait;
          MSG_Wait('در حال غیر فعال کردن لیست افراد مجاز به تردد ... ');
          ClearGridMessage;
          for i := 1 to TotalReader do
            if i in ReaderList  then
            begin
              if LastType = RDR_CLK120 then
                Sleep(2000);
              LastType := Readers[i].R_Type;
              if SetAuthority(Readers[i], nil) then
                grdRdrs.Cells[3, i] := 'لیست افراد مجاز به تردد غیر فعال شد.'
              else
                grdRdrs.Cells[3, i] := 'ناموفق';
              grdRdrs.Refresh;
            end;
          Mouse_NoWait;
          MSG_NoWait;
        end;
        lst.Destroy;
      end;
      RDR_FingerPrg:
      begin
        if rdoType1.Checked then
        begin
          Application.CreateForm(TfrmFingerPrg, frmFingerPrg);
          frmFingerPrg.rdrIdxSet := ReaderList;
          frmFingerPrg.ShowModal;
          frmFingerPrg.Free;
        end
        else if rdoType2.Checked then
        begin
          Application.CreateForm(TfrmFingerPrg2, frmFingerPrg2);
          frmFingerPrg2.rdrIdxSet := ReaderList;
          frmFingerPrg2.ShowModal;
          frmFingerPrg2.Free;
        end
        else if rdoType3.Checked then
        begin
          rdrSelectedCount := 0;
          for i := 1 to TotalReader do
            if i in ReaderList then
              inc(rdrSelectedCount);

          if rdrSelectedCount = 1 then
          begin
            Application.CreateForm(TfrmFingerPrg2, frmFingerPrg2);
            frmFingerPrg2.rdrIdxSet := ReaderList;
            frmFingerPrg2.ChangeModeAll(Direct_Mode);
            frmComTools.ComPort.Close;
            Application.Minimize;
            ShellEXECandWait(txtPath.Text);
            Application.Restore;
            frmFingerPrg2.ChangeModeAll(Normal_Mode);
            frmFingerPrg2.Free;
          end
          else
            ErrorMessage('براي اجراي فايل بايد فقط يک دستگاه انتخاب شود .');
        end;
      end;
    end;
  end;
end;


procedure TfrmRelations.grdMsgKeyPress(Sender: TObject; var Key: Char);
begin
  if (Length(grdMsg.Cells[0, grdMsg.Row]) >= 16) and (Key <> #8) then
    Key := #0;
end;

procedure TfrmRelations.grdRdrMsgKeyPress(Sender: TObject; var Key: Char);
begin
  if (Length(grdRdrMsg.Cells[0, grdRdrMsg.Row]) >= 16) and (Key <> #8) then
    Key := #0;
end;

procedure TfrmRelations.chkViewFromDbClick(Sender: TObject);
begin
  if chkViewFromDb.Checked then
    chkPermanent.Enabled := false
  else
    chkPermanent.Enabled := True;

end;


procedure TfrmRelations.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  CanClose := (thdCount = 0);
end;

procedure TfrmRelations.cmdPathClick(Sender: TObject);
begin
  opnFile.InitialDir := g_options.DataBasePath;
  opnFile.Filter := '(*.exe) | *.exe';
  if opnFile.Execute then
  begin
    if not FileExists(opnFile.FileName) then
    begin
      ErrorMessage('فايل ورودي وجود ندارد.');
      cmdPath.SetFocus;
    end
    else
      txtPath.Text := opnFile.FileName;
  end;

end;

end.


