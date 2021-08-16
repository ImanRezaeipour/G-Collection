unit Relation;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, AdoDB, ExtCtrls, Mask, CPortCtl,
  RunCmnds, Menus, SyncObjs, DBClient, Provider,VidGrab,keyboard,globals;
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
    mnuMsg: TMenuItem;
    mnuCollect: TMenuItem;
    mnuRercovery: TMenuItem;
    mnuReadVersion: TMenuItem;
    mnuRestart: TMenuItem;
    mnuInitial: TMenuItem;
    mnuChangeAddr: TMenuItem;
    mnuChngBaud: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    txtTimeOut: TEdit;
    cmbRecoveryCode: TComboBox;
    Label12: TLabel;
    Label7: TLabel;
    cmbRecoveryName: TComboBox;
    N8: TMenuItem;
    cmdCalc: TBitBtn;
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
    procedure cmbRecoveryChange(Sender: TObject);
    procedure cmbRecoveryCodeChange(Sender: TObject);
    procedure cmbRecoveryNameChange(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure cmdCalcClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitialGridCels;
    procedure FillGrid;
    procedure ClearGridMessage;
    procedure MakeRdrSelIdx;

    procedure SendTab(var Key : Char);

    function Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
    function Z84GetAllRecord(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte) : Boolean;

//    procedure Z80AllCollect(rdrInf : TReaders; i : Byte);
//    procedure Z80AllRecovery(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte);

  public
    { Public declarations }
    ActionType : Byte;
    THDlIST : TThreadList;
  end;

type
  TRecs = array of TMachines;
//  TSaveRecordThread = class(TThread)
//  private
////    FClkRecs : TClkRecs;
//  protected
//    constructor Create(Recs : TMachines);
//    procedure Execute; override;
//  end;
var
  prmsn : TCriticalSection;
  thdCount : integer;

implementation

uses
  MSGs, ComTools, DateProc, FarsiApi,  DBS, CalcMsgs,
  Z80_CMD, Z84_CMD, {PicRecs, PicRec, PicRecs4, ListRec,} Funcs, Code_Sys,
  TCP_UDP, ChngAddr,ChngBaud,
  RdrList, 
  main{$ifdef BioStation},BioStation{$endif};

{$R *.DFM}

const
  MB_SEND_DT    = 0;
  MB_GET_DT     = 1;
  MB_SEND_LIMIT = 0;
  MB_GET_LIMIT  = 1;

var
  ReaderList : Set of 0..255;


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

procedure TfrmRelations.N8Click(Sender: TObject);
var frmReaders : TfrmReaders;
begin
  Application.CreateForm(TfrmReaders, frmReaders);
  frmReaders.ShowModal;
  frmReaders.Free;
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
//  AddUserAction(mnuBaud.Caption);
  Application.CreateForm(TfrmChngBaud, frmChngBaud);
  frmChngBaud.ShowModal;
  frmChngBaud.Free;
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
(*
function TfrmRelations.Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
var
  n, retVal, getVal : Byte;
  S_PK, G_PK : String;
  ClkRec, befRec : TTerminalRec;
  ErrRec : Boolean;
  p : TPerson;
  mustsave : boolean;
begin
  Z84AllCollect := False;
  befRec.rdrCode := 0;
  mustsave:=false;
  if rdrInf.R_IsCom and not ComPortInitial(rdrInf) then
    Exit;

  case rType of
    ALL_COLLECTION: Z84_MakePOcket(S_PK, rdrInf.r_Code, $02, 0, '');
    ALL_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $2E, 0, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
    NEW_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $30, 0, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
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
      Z84_GetPocket(G_PK, 30, 300, getVal)
    else if rdrInf.r_TCP then
      TCPReadData(G_PK, getVal)
    else
      UDPReadData(G_PK, getVal);

    if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.R_Code) then
    begin
      case Ord(G_PK[4]) of
        $03: //Buffer Empty
          retVal := MB_BUFFEMPTY;
        $04: //Record Exists
        begin
          retVal := MB_TRUEREC;
          ClkRec := Z84_AnalizeData(G_PK, ErrRec);
          {$ifndef Z84SDK}
          p := GetPerson(ClkRec.rdrCardCode, True);
          if p.P_BarCode <> '' then
            ClkRec.rdrCardCode := p.P_BarCode;
          {$endif}
          mustsave:=true;
          if (befRec.rdrCode <> ClkRec.rdrCode) or
             (befRec.rdrCardCode <> ClkRec.rdrCardCode) or
             (befRec.rdrDate <> ClkRec.rdrDate) or
             (befRec.rdrTime <> ClkRec.rdrTime) then
          begin
            befRec := ClkRec;
            if not ErrRec then
              Inc(RecNo)
            else
              Inc(ErrRecNo);
          end;
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
          grdRdrs.Refresh;
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

  n := 0;
  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    if retVal = MB_TRUEREC then
    begin
      Z84_MakePocket(S_PK, rdrInf.r_Code, $06, 0, '');
      n := 0;
    end
    else if retVal = MB_BADREC then
      Z84_MakePocket(S_PK, rdrInf.r_Code, $15, 0, '')
    else if retVal = ERR_OFF then
    begin
      if (n > 1) and (rType = ALL_COLLECTION) then
        //Z84AllCollect(rdrInf, aDate, rType, i, RecNo, ErrRecNo)
        Z84_Makepocket(S_PK, rdrInf.r_Code, $02, 0, '')
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
      if mustsave then SaveClockRecord(ClkRec, REC_TEST, ErrRec);
      mustsave:=false;
      if rdrInf.r_IsCom then
        Z84_Getpocket(G_PK, 30, 300, getVal)
      else if rdrInf.r_TCP then
        TCPReadData(G_PK, getVal)
      else
        UDPReadData(G_PK, getVal);
      if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.r_Code) then
      begin
        case Ord(G_PK[4]) of
          $03: //Buffer Empty
            retVal := MB_BUFFEMPTY;
          $04: //Record Exists
          begin
            retVal := MB_TRUEREC;
            n := 0;
            ClkRec := Z84_AnalizeData(G_PK,  ErrRec);
            p := GetPerson(ClkRec.rdrCardCode, True);
            if p.P_BarCode <> '' then
              ClkRec.rdrCardCode := p.P_BarCode;
            mustsave:=true;
            if (befRec.rdrCode <> ClkRec.rdrCode) or
               (befRec.rdrCardCode <> ClkRec.rdrCardCode) or
               (befRec.rdrDate <> ClkRec.rdrDate) or
               (befRec.rdrTime <> ClkRec.rdrTime) then
            begin
              befRec := ClkRec;
              if not ErrRec then
                Inc(RecNo)
              else
                Inc(ErrRecNo);
            end;
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
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
  end;
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
end;
*)

(***************** Analize Parking6 Record *****************)
function Z84_AnalizeParkingData(Data : String; var ErrData : Boolean) : TMachines;
var
  rdrRecord : TMachines;
  s : String;
  i : integer;
function delst(s : String; len : Integer) : String;
begin
  Result := Copy(s,len+1,Length(s)-len);
end;
begin
  ErrData := False;
  with rdrRecord do
  begin             
    s := IntToHex(ord(Data[1]),2); //Status
    if IsNumeric(s) then
      M_Status := Strtoint(s)
    else
      ErrData := True;
    Data := delst(Data,1);

    M_OperatorCode := IntToHex(ord(Data[1]),2) + IntToHex(ord(Data[2]),2) + IntToHex(ord(Data[3]),2) + IntToHex(ord(Data[4]),2); //Operator Code
    Data := delst(Data,4);

    M_BarCode := IntToHex(ord(Data[1]),2) + IntToHex(ord(Data[2]),2) + IntToHex(ord(Data[3]),2) + IntToHex(ord(Data[4]),2); //Card Number (Barcode)
    Data := delst(Data,4);

    s := IntToStr(ord(Data[1])); //Plaque Type
    if IsNumeric(s) then
      M_PlaqueType:= Strtoint(s)
    else
      ErrData := True;
    Data := delst(Data,1);

    s := Copy(Data, 1, 1); //Plaque Appliance
    if IsNumeric(s) then
      M_PlaqueAppliance:= Strtoint(s)
    else
      ErrData := True;
    Data := delst(Data,1);

    s :=IntToStr(ord(Data[1])) + IntToStr(ord(Data[2])); //City Serial
    if IsNumeric(s) then
      M_CitySerial:= Strtoint(s)
    else
      ErrData := True;
    Data := delst(Data,2);

    s := IntToHex(ord(Data[1]),2); //Serial (Plaque Serial)
    if IsNumeric(s) then
      M_Serial := s
    else
      ErrData := True;
    Data := delst(Data,1);

    case M_PlaqueType of
      65 : s := Copy(Data, 1, 5);
      73 : s :=Copy(Data, 4, 1) + Copy(Data, 5, 1) + Copy(Data, 6, 1) + Copy(Data, 3, 1) + Copy(Data, 1, 1) + Copy(Data, 2, 1);
    end;
//    s := Copy(Data, 1, 6); //Number (Plaque Number)
    M_Number := IR_To_Win(WIN_MICROSOFT_SYS,s);
    Data := delst(Data,6);

   case M_Status of
      21, 23, 24, 61, 62, 63, 64:
        begin
          s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //IDate
          if IsTrueDate(s) then
            M_IDate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
                             IntToStr(ord(Data[2]))); //ITime
          if IsTrueTime(s) then
            M_ITime := s
          else
            ErrData := True;
          Data := delst(Data,2);

          s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //ODate
          if s = '0/0/0' then
           M_ODate:='0000/00/00'
          else if IsTrueDate(s) then
             M_ODate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
                             IntToStr(ord(Data[2]))); //OTime
          if IsTrueTime(s) then
            M_OTime := s
          else
            ErrData := True;
          Data := delst(Data,2);
          if (M_Status = 61) or (M_Status = 62) or (M_Status = 21) then
            begin
              M_ODate := '';
              M_OTime := '';
            end;
        end;
        else
        begin
            ErrData := True;
        end;
{      61, 62:
        begin



        
          s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //IDate
          if IsTrueDate(s) then
            M_IDate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          //s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
          //                   IntToStr(ord(Data[2]))); //ITime
          s := IntToStr(ord(Data[1])) + IntToStr(ord(Data[2])); //MemberCode
          //if IsTrueTime(s) then
          M_MemberCode := s;
          //else
          //  ErrData := True;
          Data := delst(Data,2);

          s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //IDate
          if s = '0/0/0' then
           M_ODate:='0000/00/00'
          else if IsTrueDate(s) then
             M_IDate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
                             IntToStr(ord(Data[2]))); //ITime
          if IsTrueTime(s) then
            M_ITime := s
          else
            ErrData := True;
          Data := delst(Data,2);

          M_ODate := '';
          M_OTime := '';
        end;

      63, 64:
        begin
          {s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //IDate
          if IsTrueDate(s) then
            M_IDate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          //s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
          //                   IntToStr(ord(Data[2]))); //ITime
          s := IntToStr(ord(Data[1])) + IntToStr(ord(Data[2])); //MemberCode
          //if IsTrueTime(s) then
          M_MemberCode := s;
          //else
          //  ErrData := True;
          Data := delst(Data,2);

          s := BeautifulDate(IntToStr(ord(Data[1])) + '/' +
                                   IntToStr(ord(Data[2])) + '/' +
                                   IntToStr(ord(Data[3]))); //ODate
          if s = '0/0/0' then
           M_ODate:='0000/00/00'
          else if IsTrueDate(s) then
             M_ODate := s
          else
            ErrData := True;
          Data := delst(Data,3);

          s := BeautifulTime(IntToStr(ord(Data[1])) + ':' +
                             IntToStr(ord(Data[2]))); //OTime
          if IsTrueTime(s) then
            M_OTime := s
          else
            ErrData := True;
          Data := delst(Data,2);

          M_IDate := '';
          M_ITime := '';
        end; }
   end;

    s := '';
    s := IntToHex(ord(Data[4]),2) + IntToHex(ord(Data[3]),2) + IntToHex(ord(Data[2]),2) + IntToHex(ord(Data[1]),2); //Payable
    s :=IntToStr(HexToInt(s)); //Payable
    if IsNumeric(s) then
      M_Payable:= StrToCurr(s)
    else
      ErrData := True;
    if (M_Status = 61) or (M_Status = 62) or (M_Status = 63) or (M_Status = 64) then
      M_Payable := 0;
    
    Data := delst(Data,4);

{$ifdef TarehBar}
   case M_Status of
      21, 61, 62:
      begin
        s := '0';
//        s := IntToHex(ord(Data[1]),2); //CargoKind
//        s :=IntToStr(HexToInt(s)); //CargoKind
        s := Data[1]; //CargoKind
        if IsNumeric(s) then
          M_CargoKind:= StrToInt(s)
        else
          ErrData := True;

        Data := delst(Data,1);

        s := '0';
        for i := 1 to 5 do
          if Data[i] <> #0 then
            s := s + Data[i]; //CargoWeight
        if IsNumeric(s) then
          M_CargoWeight:= StrToInt(s)
        else
          ErrData := True;

        Data := delst(Data,5);

//        if Data[1] = #0 then
//          for i := 1 to 3 do
//            Data[i] := '0';
        s := '0';
        for i := 1 to 3 do
          if Data[i] <> #0 then
            s := s + Data[i]; //Salon
//        s := Data[1] + Data[2] + Data[3]; //Salon
        if IsNumeric(s) then
          M_Salon:= StrToInt(s)
        else
          ErrData := True;

        Data := delst(Data,3);

//        if Data[1] = #0 then
//          for i := 1 to 4 do
//            Data[i] := '0';
        s := '0';
        for i := 1 to 4 do
          if Data[i] <> #0 then
            s := s + Data[i]; //Loge
//        s := Data[1] + Data[2] + Data[3] + Data[4]; //Loge
        if IsNumeric(s) then
          M_Loge:= StrToInt(s)
        else
          ErrData := True;

        Data := delst(Data,4);
      end;
      else
      begin
        M_CargoKind := 0;
        M_CargoWeight := 0;
        M_Salon := 0;
        M_Loge := 0;
        Data := delst(Data,13);
      end;
   end;

{$endif TarehBar}


{kaveh
    s := Copy(Data, 11, 4); //Reader Code
    M_BarCode := IntToStr(HexToInt(s));

    s := BeautifulDate(IntToStr(ord(Data[26])) + '/' +
                             IntToStr(ord(Data[27])) + '/' +
                             IntToStr(ord(Data[28])));
    if IsTrueDate(s) then
      M_IDate := s
    else
      ErrData := True;

    s := BeautifulTime(IntToStr(ord(Data[29])) + ':' +
                       IntToStr(ord(Data[30])));
    if IsTrueTime(s) then
      M_ITime := s
    else
      ErrData := True;


    s := BeautifulDate(IntToStr(ord(Data[31])) + '/' +
                             IntToStr(ord(Data[32])) + '/' +
                             IntToStr(ord(Data[33])));
    if IsTrueDate(s) then
      M_ODate := s
    else
      ErrData := True;

    s := BeautifulTime(IntToStr(ord(Data[34])) + ':' +
                       IntToStr(ord(Data[35])));
    if IsTrueTime(s) then
      M_OTime := s
    else
      ErrData := True;
kaveh}
  end;

  Result := rdrRecord;
end;

function TfrmRelations.Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
var
  n, retVal, getVal : Byte;
  S_PK, G_PK : String;
//kaveh  {ClkRec, }befRec : TTerminalRec;
//kaveh  ClkRecs : array of TTerminalRec;
//kaveh  befRec : TMachines; //kaveh
  ClkRecs : array of TMachines; //kaveh
  j, PacketRecCount : integer;
  ErrRec : Boolean;
//  empl : TEmployee;
  mustsave : boolean;
//label kk;

begin
  Z84AllCollect := False;
//kaveh  befRec.M_rdrCode := 0; //kaveh befRec.rdrCode := 0;
  mustsave:=false;
  if rdrInf.R_IsCom and not ComPortInitial(rdrInf) then
    Exit;

  {$region 'get first Record'}
  case rType of
    ALL_COLLECTION: Z84_MakePOcket(S_PK, rdrInf.r_Code, $02, $55 , '');
    ALL_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $2E, $55, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
    NEW_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $30, $55, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
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
      Z84_GetPocket(G_PK, 0 , 500, getVal)
    else if rdrInf.r_TCP then
      TCPReadData(G_PK, getVal)
    else
      UDPReadData(G_PK, getVal);
      
////goto kk;

    if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.R_Code) then
    begin
      case Ord(G_PK[4]) of
        $03: //Buffer Empty
          retVal := MB_BUFFEMPTY;

        $5A: //Record Exists
        begin
          {$region 'multiple Record in One Packet'}
          retVal := MB_TRUEREC;
//kaveh          SetLength(ClkRecs,1{20});
//kaveh          PacketRecCount := 1;//(Ord(G_PK[2])-4) div 15;
          SetLength(ClkRecs,20);
{$ifdef TarehBar}
          PacketRecCount := (Ord(G_PK[2])-4) div 47;
{$else TarehBar}
          PacketRecCount := (Ord(G_PK[2])-4) div 34;
{$endif TarehBar}
          for j :=0 to PacketRecCount-1 do
          begin
//kaveh            ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*15),15), ErrRec);
//kaveh            ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*34),34), ErrRec);

{$ifdef TarehBar}
            ClkRecs[j] := Z84_AnalizeParkingData(copy(G_PK,6+(j*(47)),(47)), ErrRec);
{$else TarehBar}
            ClkRecs[j] := Z84_AnalizeParkingData(copy(G_PK,6+(j*34),34), ErrRec);
{$endif TarehBar}
//????
//            ClkRecs[j] := Z84_AnalizeData(UnPackRecord(copy(G_PK,6+(j*11),11)), ErrRec);
//????
            ClkRecs[j].M_rdrCode := rdrInf.R_Code;
//            empl := GetEmployee(ClkRecs[j].rdrCardCode, True);
//            if ClkRecs[j].rdrStatus <>8 then //lost Cards must identify by cardNo
//              if empl.EmplCode <> '' then
//                ClkRecs[j].rdrCardCode := empl.EmplCode;

            mustsave:=true;

{kaveh            if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
               (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
               (befRec.rdrDate <> ClkRecs[j].rdrDate) or
               (befRec.rdrTime <> ClkRecs[j].rdrTime) then
               (befRec.rdrPayment <> ClkRecs[j].rdrPayment) then  kaveh}

{kaveh            if (befRec.M_rdrCode <> ClkRecs[j].M_rdrCode) or
               (befRec.M_BarCode <> ClkRecs[j].M_BarCode) or
               (befRec.M_BarCode <> ClkRecs[j].M_BarCode) or
               (befRec.M_IDate <> ClkRecs[j].M_IDate) or
               (befRec.M_ITime <> ClkRecs[j].M_ITime) or
               (befRec.M_ODate <> ClkRecs[j].M_ODate) or
               (befRec.M_OTime <> ClkRecs[j].M_OTime) then
            begin
              befRec := ClkRecs[i];kaveh}
            if not ErrRec then
              Inc(RecNo)
            else
              Inc(ErrRecNo);
//kaveh            end;
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
/////////
//grdRdrs.Cells[1,3] := IntToStr()
{      if mustsave then
      for j := 0 to PacketRecCount-1 do
      begin
       case ClkRecs[j].M_Status of
          21:SaveInputCarRecord(ClkRecs[j]);
          23:UpdateOutputCarRecord(ClkRecs[j]);
       end;
      end;
      mustsave:=false;}
/////////n := 4;
/////////
  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
//k  while (retVal <> MB_TRUEREC) and (retVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    {$region 'get other Record'}
    if retVal = MB_TRUEREC then
    begin
//kaveh871106
      Z84_MakePocket(S_PK, rdrInf.r_Code, $06, $55 {0}, '');
      n := 0;
    end
    else if retVal = MB_BADREC then
      Z84_MakePocket(S_PK, rdrInf.r_Code, $15,$55 {0}, '')
    else if retVal = ERR_OFF then
    begin
      if (n > 1) and (rType = ALL_COLLECTION) then
        //Z84AllCollect(rdrInf, aDate, rType, i, RecNo, ErrRecNo)
        Z84_Makepocket(S_PK, rdrInf.r_Code, $02,$55 {0}, '')
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
      begin
       case ClkRecs[j].M_Status of
          21, 61, 62, 23, 24, 63, 64: SaveCollectedRecs(ClkRecs[j]);
       end;

//kaveh //*********
{       case ClkRecs[j].M_Status of
          21, 61, 62: SaveInputCarRecord(ClkRecs[j]);
          23, 24, 63, 64: UpdateOutputCarRecord(ClkRecs[j]);
//          61, 62: SaveInputCarRecordMember(ClkRecs[j]);
//          63, 64: UpdateOutputCarRecordMember(ClkRecs[j]);
       end;}

//        case ClkRecs[j].rdrStatus of
//          8 : SaveLostCardRecord(ClkRecs[j]);
///          5,10 : SaveChargeRecord(ClkRecs[j]);
//        else
//          SaveRecord(ClkRecs[j]);
//        end;
      end;
//      TSaveRecordThread.Create(false,ClkRecs);
      mustsave := false;

      if rdrInf.r_IsCom then
        Z84_Getpocket(G_PK, 0, 500, getVal)
      else if rdrInf.r_TCP then
        TCPReadData(G_PK, getVal)
      else
        UDPReadData(G_PK, getVal);

      if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.r_Code) then
      begin
        case Ord(G_PK[4]) of
          $03: //Buffer Empty
            retVal := MB_BUFFEMPTY;

//          $5A: //Record Exists
          $5A: //Record Exists
          begin
            {$region 'multiple Record in One Packet'}
            retVal := MB_TRUEREC;
//kaveh            PacketRecCount := 1;//(Ord(G_PK[2])-4) div 15;

{$ifdef TarehBar}
            PacketRecCount := (Ord(G_PK[2])-4) div 47;
{$else TarehBar}
            PacketRecCount := (Ord(G_PK[2])-4) div 34;
{$endif TarehBar}

            for j := 0 to PacketRecCount-1 do
            begin
//kaveh              ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*15),15), ErrRec);
//kaveh              ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*34),34), ErrRec);
///////////              ClkRecs[j] := Z84_AnalizeParkingData(copy(G_PK,6+(j*34),34), ErrRec);
//              empl := GetEmployee(ClkRecs[j].rdrCardCode, True);
//              if empl.EmplCode <> '' then
//                ClkRecs[j].rdrCardCode := empl.EmplCode;

{$ifdef TarehBar}
              ClkRecs[j] := Z84_AnalizeParkingData(copy(G_PK,6+(j*(47)),(47)), ErrRec);
{$else TarehBar}
              ClkRecs[j] := Z84_AnalizeParkingData(copy(G_PK,6+(j*34),34), ErrRec);
{$endif TarehBar}

              ClkRecs[j].M_rdrCode := rdrInf.R_Code;
              mustsave:=true;

{kaveh              if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
                 (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
                 (befRec.rdrDate <> ClkRecs[j].rdrDate) or
                 (befRec.rdrTime <> ClkRecs[j].rdrTime) then
              begin
                befRec := ClkRecs[i]; kaveh}
              if not ErrRec then
                Inc(RecNo)
              else
                Inc(ErrRecNo);
//kaveh              end;
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
//      if rType = ALL_RECOVERY then
        Sleep(300);
    end;
    {$endregion 'get other Record'}
    Application.ProcessMessages;
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


//function TfrmRelations.Z84AllCollect(rdrInf : TReaders; aDate, EmplNo : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
//var
//  n, retVal, getVal : Byte;
//  S_PK, G_PK : String;
//  {ClkRec,} befRec : TTerminalRec;
//  Recs : TRecs;
//  j, PacketRecCount : integer;
//  ErrRec : Boolean;
//  p : TPerson;
//  mustsave : boolean;
//  stat : integer;
//  data : string;
//  function UnPackRecord(PK : string) : string;
//  begin
//    Result := '11111' + FixLeft(IntToStr(ord(pk[1])),'0',3);
//    Result := Result + PBCD_Str(copy(pk,2,10),20);
//  end;
//begin
////  if F_Params.FastCollect = 1 then stat := $55 else stat := 0;
//  stat := 0;
//  Z84AllCollect := False;
//  befRec.rdrCode := 0;
//  mustsave:=false;
//  if rdrInf.R_IsCom and not ComPortInitial(rdrInf) then
//    Exit;
//  {$region 'get first Record'}
//  case rType of
//    ALL_COLLECTION : Z84_MakePocket(S_PK, rdrInf.r_Code, $02,  stat , '');
//    ALL_RECOVERY   :
//    begin
//      data := Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2);
//      if EmplNo <> '' then
//      begin
//        data := data + FixLeft(EmplNo,'0',8);
//        stat := Ord('X');
//      end;
//      Z84_MakePocket(S_PK, rdrInf.R_Code, $2E,  stat, Data);
//    end;
//    NEW_RECOVERY   : Z84_MakePocket(S_PK, rdrInf.R_Code, $30,  stat, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
//  end;
//
//  if rdrInf.r_IsCom and not SendPocket(S_PK) then
//    retVal := ERR_OFF
//  else if not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
//    retVal := ERR_OFF
//  else if not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
//    retVal := ERR_OFF
//  else
//  begin
//    if rdrInf.r_IsCom then
//      Z84_GetPocket(G_PK, 30 , 300, getVal)
//    else if rdrInf.r_TCP then
//    begin
//      if rType = ALL_COLLECTION  then
//        Sleep(100)
//      else
//        Sleep(4000);
//      TCPReadData(G_PK, getVal)
//    end
//    else
//    begin
//      UDPReadData(G_PK, getVal);
//    end;
//
//    if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.R_Code) then
//    begin
//      case Ord(G_PK[4]) of
//        $03: //Buffer Empty
//          retVal := MB_BUFFEMPTY;
//
//        $04: //Record Exists
//        begin
//          {$region 'one Record in one Packet'}
//          retVal := MB_TRUEREC;
//          SetLength(Recs,1);
//          PacketRecCount := 1;
////new871103          Recs[0] := Z84_AnalizeParkingData(G_PK, ErrRec);
//          mustsave:=true;
//
////          if (befRec.rdrCode <> Recs[0].rdrCode) or
////             (befRec.rdrCardCode <> Recs[0].rdrCardCode) or
////             (befRec.rdrDate <> Recs[0].rdrDate) or
////             (befRec.rdrTime <> Recs[0].rdrTime) then
////          begin
////            befRec := Recs[0];
////            if not Recs[0].rdrErrRec then
////              Inc(RecNo)
////            else
////              Inc(ErrRecNo);
////          end;
//
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
//          grdRdrs.Refresh;
//          {$endregion 'one Record in one Packet'}
//        end;
//        $5A: //Record Exists
//        begin
//          {$region 'multiple Record in One Packet'}
//          retVal := MB_TRUEREC;
//          SetLength(Recs,20);
//          PacketRecCount := (Ord(G_PK[2])-4) div 11;
////          for j :=0 to 19 do
////            Recs[j].rdrCardCode := '';
//          for j :=0 to PacketRecCount-1 do
//          begin
////new871103            Recs[j] := Z84_AnalizeParkingData(UnPackRecord(copy(G_PK,6+(j*11),11)), ErrRec);
//            mustsave:=true;
//
////            if (befRec.rdrCode <> Recs[j].rdrCode) or
////               (befRec.rdrCardCode <> Recs[j].rdrCardCode) or
////               (befRec.rdrDate <> Recs[j].rdrDate) or
////               (befRec.rdrTime <> Recs[j].rdrTime) then
////            begin
////              befRec := Recs[i];
////              if not Recs[i].rdrErrRec then
////                Inc(RecNo)
////              else
////                Inc(ErrRecNo);
////            end;
//            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo) ;
//            grdRdrs.Refresh;
//          end;
//          {$endregion 'multiple Record in One Packet'}
//        end;
//        {$region 'other'}
//        $15:
//          retVal := MB_TRUEREC;
//        else //Error in read data
//          retVal := MB_BADREC;
//        {$endregion 'other'}
//      end;
//    end
//    else if getVal = ERR_OFF then
//      retVal := ERR_OFF
//    else
//      retVal := MB_BADREC;
//  end;
//  {$endregion 'get first Record'}
//  n := 0;
//  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
//  begin
//    {$region 'get other Record'}
//    if retVal = MB_TRUEREC then
//    begin
//      Z84_MakePocket(S_PK, rdrInf.r_Code, $06, stat, '');
//      n := 0;
//    end
//    else if retVal = MB_BADREC then
//      Z84_MakePocket(S_PK, rdrInf.r_Code, $15, stat, '')
//    else if retVal = ERR_OFF then
//    begin
//      if (n > 1) and (rType = ALL_COLLECTION) then
//        Z84_Makepocket(S_PK, rdrInf.r_Code, $02,  stat, '')
//      else
//        S_PK := '';
//    end;
//
//    if rdrInf.r_IsCom and not SendPocket(S_PK) then
//      retVal := ERR_OFF
//    else if (S_PK <> '') and not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
//      retVal := ERR_OFF
//    else if (S_PK <> '') and not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
//      retVal := ERR_OFF
//    else
//    begin
////new871103      if mustsave then
////new871103        for j := 0 to PacketRecCount-1 do
////new871103          InputCar(Recs[j]);
//      mustsave:=false;
//      if rdrInf.r_IsCom then
//        Z84_Getpocket(G_PK, 0, 300, getVal)
//      else if rdrInf.r_TCP then
//      begin
//        Sleep(100);
//        TCPReadData(G_PK, getVal)
//      end
//      else
//      begin
//        UDPReadData(G_PK, getVal);
//      end;
//
//      if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.r_Code) then
//      begin
//        case Ord(G_PK[4]) of
//          $03: //Buffer Empty
//            retVal := MB_BUFFEMPTY;
//
//          $04: //Record Exists
//          begin
//            retVal := MB_TRUEREC;
//            n := 0;
////new871103            Recs[0] := Z84_AnalizeParkingData(G_PK,  ErrRec);
////            p := GetPerson(Recs[0].rdrCardCode, True);
////            if p.P_BarCode = '' then
////              p := GetPerson(Recs[0].rdrCardCode, False);
////
////            if p.P_BarCode <> '' then
////              Recs[0].rdrCardCode := p.P_BarCode;
//            mustsave:=true;
//
////            if (befRec.rdrCode <> Recs[0].rdrCode) or
////               (befRec.rdrCardCode <> Recs[0].rdrCardCode) or
////               (befRec.rdrDate <> Recs[0].rdrDate) or
////               (befRec.rdrTime <> Recs[0].rdrTime) then
////            begin
////              befRec := Recs[0];
////              if not Recs[0].rdrErrRec then
////                Inc(RecNo)
////              else
////                Inc(ErrRecNo);
////            end;
//            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo) ;
//            grdRdrs.Refresh;
//          end;
//          $5A: //Record Exists
//          begin
//            {$region 'multiple Record in One Packet'}
//            retVal := MB_TRUEREC;
//            PacketRecCount := (Ord(G_PK[2])-4) div 11;
////            for j :=0 to 19 do
////              Recs[j].rdrCardCode := '';
//
//            for j :=0 to PacketRecCount-1 do
//            begin
////new871103              Recs[j] := Z84_AnalizeParkingData(UnPackRecord(copy(G_PK,6+(j*11),11)), ErrRec);
//              mustsave:=true;
//
////              if (befRec.rdrCode <> Recs[j].rdrCode) or
////                 (befRec.rdrCardCode <> Recs[j].rdrCardCode) or
////                 (befRec.rdrDate <> Recs[j].rdrDate) or
////                 (befRec.rdrTime <> Recs[j].rdrTime) then
////              begin
////                befRec := Recs[i];
////                if not Recs[i].rdrErrRec then
////                  Inc(RecNo)
////                else
////                  Inc(ErrRecNo);
////              end;
//              grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
//              grdRdrs.Refresh;
//            end;
//            {$endregion 'multiple Record in One Packet'}
//          end;
//          $15:
//            retVal := MB_TRUEREC;
//          else //Error in read data
//            retVal := MB_BADREC;
//        end;
//      end
//      else if getVal = ERR_OFF then
//        retVal := ERR_OFF
//      else
//        retVal := MB_BADREC;
//    end;
//    if retVal in [ERR_OFF, MB_BADREC] then
//    begin
//      Inc(n);
//      if rType = ALL_RECOVERY then
//        Sleep(1000);
//    end;
//    n:= n +1;
//    {$endregion 'get other Record'}
//    Refresh;
//  end;
//  {$region 'view Opreration'}
//  while thdCount > 0 do
//  begin
//    grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo) + '   در حال ذخيره سازي : ' +  IntToStr(thdCount);
//    grdRdrs.Refresh;
//  end;
//  if RecNo > 0 then
//  begin
//    if retVal = MB_BUFFEMPTY then
//    begin
//      if ErrRecNo > 0 then
//      begin
//        Z84AllCollect := True;
//        if rType = ALL_COLLECTION then
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
//                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل جمع آوري شد'
//        else
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
//                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل بازيابي شد';
//      end
//      else
//      begin
//        Z84AllCollect := True;
//        if rType = ALL_COLLECTION then
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل جمع آوري شد'
//        else
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل بازيابي شد';
//      end;
//    end
//    else
//    begin
//      if ErrRecNo > 0 then
//      begin
//        if rType = ALL_COLLECTION then
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
//                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص جمع آوري شد'
//        else
//        begin
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
//                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص تا تاريخ ' + aDate +  ' بازيابي شد ';
//          txtRecoveryFDate.Text := aDate;
//        end;
//      end
//      else
//        if rType = ALL_COLLECTION then
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص جمع آوري شد'
//        else
//        begin
//          //Z84AllCollect := True;
//          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص تا تاريخ ' + aDate + ' بازيابي شد ';
//          txtRecoveryFDate.Text := aDate;
//        end;
//    end;
//  end
//  else if retVal = MB_BUFFEMPTY then
//  begin
//    Z84AllCollect := True;
//    if rType <> ALL_RECOVERY then
//      grdRdrs.Cells[3, i] := 'هيچ ركورد جديدي وجود ندارد'
//    else
//      grdRdrs.Cells[3, i] := 'ركوردي براي بازيابي وجود ندارد';
//  end
//  else
//    grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';
//
//  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
//  grdRdrs.Refresh;
//  {$endregion 'view Opreration'}
//end;
//
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

//function TfrmRelations.Z84GetAllRecord(rdrInf : TReaders; FDate, TDate, EmplNo : String; rType, i : Byte) : Boolean;
//var
//  GoodRec, BadRec : Integer;
//begin
//  Z84GetAllRecord := True;
//  GoodRec := 0;
//  BadRec := 0;
//  if FDate = '' then FDate := CurrentDate;
//  if TDate = '' then TDate := FDate;
//
//  while FDate <= TDate do
//  begin
//    Msg_Wait('بازيابي ركوردهاي تاريخ : ' + FDate);
//    if not Z84AllCollect(rdrInf, FDate, EmplNo, rType, i, GoodRec, BadRec) then
//    begin
//      Z84GetAllRecord := False;
//      MSG_NoWait;
//      Break;
//    end;
//    FDate := AddDate(FDate, 1);
//    MSG_NoWait;
//  end;
//end;


procedure TfrmRelations.FormCreate(Sender: TObject);
var
   j: integer;
begin
  InitialGridCels;
  FillGrid;
  prmsn := TCriticalSection.Create;

  for j := 0 to MainMenu1.Items[MNU_RELATION].Count-1 do
    MainMenu1.Items[1].Items[j].visible:=frmmain.mnuAllPark.Items[MNU_RELATION].Items[j+1].visible;

//  MainMenu1.Items[1]:=mnuClock.Items[MNU_RELATION];

  {$ifdef FreeVersion}
  MainMenu1.Items.Clear;
  {$endif}
end;

procedure TfrmRelations.FormShow(Sender: TObject);
var
  adoQry : TADOQuery;
begin
  grpSendGetDT.Visible := False;
  grpLimit.Visible := False;
  grpCardMsg.Visible := False;
  grpMsg.Visible := False;
  grpDoor.Visible := False;
  grpView.Visible := False;
  grpRecovery.Visible := False;
  grpAuthority.Visible := False;
  grpFingerPrg.Visible := False;
  cmdCalc.Visible := False;
  
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

      cmbMsg.Clear;
      cmbMsg.Items.Add('ارسال پيام');
      cmbMsg.Items.Add('خواندن پيام');
      cmbMsg.Items.Add('حذف پيام');
      cmbMsg.Items.Add('حذف كليه پيامها');
      cmbMsg.ItemIndex := 0;
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
      cmbDoorOp.Clear;
      cmbDoorOp.Items.Add('باز نمودن در با كشيدن كارت');
      cmbDoorOp.Items.Add('باز نمودن در به مدت معين');
      cmbDoorOp.Items.Add('قفل نمودن در به مدت معين');
      cmbDoorOp.ItemIndex := 0;

      grpDoor.Visible := True;
      grdRdrs.Align := alTop;
      grpDoor.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_COLLECT:
    begin
      cmdRun.Caption := '&جمع آوري';
      cmdCalc.Visible := True;
      Caption := 'جمع آوري جديد اطلاعات از دستگاهها';
      HelpContext := 77;
      grpRecovery.Hide;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_RECOVERY:
    begin
      txtRecoveryFDate.Text := CurrentDate;
      txtRecoveryTDate.Text := CurrentDate;
      cmbRecovery.Clear;
      cmbRecovery.Items.Add('کليه رکوردها');
      cmbRecovery.Items.Add('رکوردهاي جديد');
      cmbRecovery.Items.Add('رکوردهاي يک نفر');
      cmbRecovery.ItemIndex := 0;
      cmdRun.Caption := '&بازيابي';
      cmdCalc.Visible := True;
      Caption := 'بازيابي اطلاعات از دستگاهها';
      HelpContext := 78;


      grpRecovery.Visible := True;
      grdRdrs.Align := alTop;
      grpRecovery.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;

      cmbRecoveryCode.Items.Clear;
      cmbRecoveryName.Items.Clear;
      adoQry := TADOQuery.Create(Application);
//      with adoQry do
//      begin
//        Connection := frmDBS.DBConnection;
//        SQL.Clear;
//        SQL.Add('select * from persons');
//        open;
//        first;
//        while not eof do
//        begin
//          cmbRecoveryCode.Items.Add(DelLeftZero(fieldByName('P_BarCode').AsString));
//          cmbRecoveryName.Items.Add(fieldByName('P_Family').AsString + ' - ' + fieldByName('P_Name').AsString);
//          Next;
//        end;
//      end;
    end;

//    RDR_VIEWREC:
//    begin
//      cmdRun.Caption := '&جمع آوري';
//      Caption := 'جمع آوري دائمي ركوردهاي ساعت';
//      HelpContext := 79;
//      cmbView.Clear;
//      cmbView.Items.Add('نمايش چند تصويري ركوردها');
//      cmbView.Items.Add('نمايش تك تصويري ركوردها');
//      cmbView.Items.Add('نمايش ليستي ركوردها');
//      cmbView.Items.Add('نمايش تصاوير دوربين ها');
//      cmbView.ItemIndex := 0;
//
//      grpView.Visible := True;
//      grdRdrs.Align := alTop;
//      grpView.Align := alTop;
//      grpBtns.Align := alTop;
//      AutoSize := True;
//    end;

    RDR_INITIAL:
    begin
      txtRecoveryFDate.Text := CurrentDate;
      txtRecoveryTDate.Text := CurrentDate;
      cmdRun.Caption := '&پيكربندي';
      Caption := 'پيكربندي مجدد ساعت';
      cmbRecovery.Clear;
      cmbRecovery.Items.Add('کليه رکوردها');
      cmbRecovery.Items.Add('رکوردهاي جديد');
      cmbRecovery.Items.Add('رکوردهاي يک نفر');
      cmbRecovery.ItemIndex := 0;
      HelpContext := 67;

      grpRecovery.Visible := True;
      grdRdrs.Align := alTop;
      grpRecovery.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

//    RDR_Authority:
//    begin
//      cmdRun.Caption := 'اجرا';
//      Caption := ' لیست افراد مجاز به تردد';
//      cmbOperate.ItemIndex := 0;
////      HelpContext := 67;
//      cmbOperate.Clear;
//      cmbOperate.Items.Add('ارسال ليست');
//      cmbOperate.Items.Add('دريافت ليست');
//      cmbOperate.Items.Add('حذف ليست');
//      cmbOperate.ItemIndex := 0;
//      grpAuthority.Visible := True;
//      grdRdrs.Align := alTop;
//      grpAuthority.Align := alTop;
//      grpBtns.Align := alTop;
//      AutoSize := True;
//    end;

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

procedure TfrmRelations.cmbRecoveryChange(Sender: TObject);
begin
  Label12.Visible := (cmbRecovery.ItemIndex = 2);
  Label7.Visible := (cmbRecovery.ItemIndex = 2);
  cmbRecoveryCode.Visible := (cmbRecovery.ItemIndex = 2);
  cmbRecoveryName.Visible := (cmbRecovery.ItemIndex = 2);
end;

procedure TfrmRelations.cmbRecoveryCodeChange(Sender: TObject);
begin
  cmbRecoveryName.ItemIndex := cmbRecoveryCode.ItemIndex;
end;

procedure TfrmRelations.cmbRecoveryNameChange(Sender: TObject);
begin
  cmbRecoveryCode.ItemIndex := cmbRecoveryName.ItemIndex;
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

procedure TfrmRelations.cmdCalcClick(Sender: TObject);
var frmCalcMsgBox : TfrmCalcMsgBox;
{  qry : TADOQuery;
  recT : TMachines;
  iC_id : Integer;
  existRec : Boolean;}
begin
  Application.CreateForm(TfrmCalcMsgBox, frmCalcMsgBox);
  frmCalcMsgBox.ShowModal;
  frmCalcMsgBox.Free;

{  //Result := True;
  if CheckCollectedRecsTable then
     existRec := True
  else
  begin
    ErrorMessage('اشکال در ایجاد جدول جمع آوری');
    existRec := False;
  end;
  try
    qry := TAdoQuery.Create(Application);
    with qry do
    begin
      connection := frmDBS.adoConnect;
      while(existRec)do
      begin
        SQL.Clear;
  //        SQL.Add('SELECT * FROM collectedRecs ');
  //        SQL.Add('ORDER BY C_id ');
        SQL.Add('SELECT * FROM collectedRecs');
        SQL.Add(' WHERE C_id = (SELECT min(C_id)FROM collectedRecs)');
        Open;
  //        ExecSQL;
        if FieldByName('C_id').AsInteger > 0 then
        begin
          iC_id := FieldByName('C_id').AsInteger;
          recT.M_BarCode := FieldByName('M_BarCode').AsString;
          recT.M_Number := FieldByName('M_Number').AsString;
          recT.M_Serial := FieldByName('M_Serial').AsString;
          recT.M_IDate := FieldByName('M_IDate').AsString;
          recT.M_ITime := FieldByName('M_ITime').AsString;
          recT.M_rdrCode := FieldByName('M_rdrCode').AsInteger;
          recT.M_OperatorCode := FieldByName('M_OperatorCode').AsString;
          recT.M_PlaqueType := FieldByName('M_PlaqueType').AsInteger;
          recT.M_PlaqueAppliance := FieldByName('M_PlaqueAppliance').AsInteger;
          recT.M_CitySerial := FieldByName('M_CitySerial').AsInteger;
          recT.M_ODate := FieldByName('M_ODate').AsString;
          recT.M_OTime := FieldByName('M_OTime').AsString;
          recT.M_Payable := FieldByName('M_PayAble').AsFloat;
          recT.M_Status := FieldByName('M_Status').AsInteger;
          recT.M_MemberCode := FieldByName('M_MemberCode').AsString;

          case recT.M_Status of
            21, 61, 62: SaveInputCarRecord(recT);
            23, 24, 63, 64: UpdateOutputCarRecord(recT);
    //          61, 62: SaveInputCarRecordMember(ClkRecs[j]);
    //          63, 64: UpdateOutputCarRecordMember(ClkRecs[j]);
          end;
          SQL.Clear;
          SQL.Add('DELETE FROM collectedRecs');
          SQL.Add(' WHERE C_id = ' + IntToStr(iC_id));
          ExecSQL;

        end
        else
        begin
          existRec := False;
        end;

      //SQL.Add('(M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_rdrCode,');
      //SQL.Add(' M_OperatorCode, M_PlaqueType, M_PlaqueAppliance, M_CitySerial,');
      //SQL.Add(' M_ODate, M_OTime, M_PayAble, M_Status, M_MemberCode)');
      end;
      Close;
      Free;
    end;
  except
    //Result := False;
  end; }
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
  EmplCode : string;
begin
  thdCount := 0;
  LastType :=RDR_VEGA9300;
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
//                  p := GetPerson(FixLeft(ST1, '0', 8), False);
//                  if p.P_Proxi <> '' then
                    ST1 := p.P_Proxi;
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
//                  p := GetPerson(FixLeft(ST1, '0', 8), False);
//                  if p.P_Proxi <> '' then
//                    ST1 := p.P_Proxi;

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
//                  p := GetPerson(FixLeft(ST1, '0', 8), False);
//                  if p.P_Proxi <> '' then
//                    ST1 := p.P_Proxi;
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
            Application.ProcessMessages;
            MSG_Wait('درحال جمع آوري ركوردهاي جديد...');
            ClearGridMessage;
            for i := 1 to TotalReader do
             if i in ReaderList then
              begin
//            with Readers[i-1] do
//            begin
               grec := 0;
               brec := 0;
//               Z84AllCollect(Readers[i-1], '', ALL_COLLECTION, i , grec, brec);
               if CheckCollectedRecsTable then
                 Z84AllCollect(Readers[i], '', ALL_COLLECTION, i , grec, brec)
               else
                 grdRdrs.Cells[3, i] := 'اشکال در ایجاد جدول جمع آوری';
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
        else if (cmbRecovery.ItemIndex = 2) and (cmbRecoveryCode.Text ='') then
        begin
          ErrorMessage('پرسنلي انتخاب نشده است .');
          cmbRecoveryCode.SetFocus;
        end
        else
        begin
          Mouse_Wait;
          ClearGridMessage;
          if cmbRecovery.ItemIndex = 1 then
            j := NEW_RECOVERY
          else
            j := ALL_RECOVERY;
          if cmbRecovery.ItemIndex = 2 then
          begin
//            EmplCode := GetPerson(cmbRecoveryCode.Text,false).P_Proxi;
            if EmplCode = '' then
              EmplCode := cmbRecoveryCode.Text;
          end
          else
            EmplCode := '';
          for i := 1 to TotalReader do
            if i in ReaderList then
              with Readers[i] do
              begin
                 if Readers[i].R_Type = RDR_VEGA9300 then
                   Z84GetAllRecord(Readers[i], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i);
              end;
          Mouse_NoWait;
        end;
      end;

//      RDR_VIEWREC:
//      begin
//        if cmbView.ItemIndex = 0 then
//        begin
//          Application.CreateForm(TfrmAnyPictureRec, frmAnyPictureRec);
//          frmAnyPictureRec.rdrIdxSet := ReaderList;
//          frmAnyPictureRec.permanent := chkPermanent.Checked;
//          frmAnyPictureRec.ViewFromDB := chkViewFromDb.Checked;
//          frmAnyPictureRec.ShowModal;
//          frmAnyPictureRec.Free;
//        end
//        else if cmbView.ItemIndex = 1 then
//        begin
//          Application.CreateForm(TfrmPictureRec, frmPictureRec);
//          frmPictureRec.rdrIdxSet := ReaderList;
//          frmPictureRec.permanent := chkPermanent.Checked;
//          frmPictureRec.ViewFromDB:= chkViewFromDb.Checked;
//          frmPictureRec.ShowModal;
//          frmPictureRec.Free;
//        end
//        else if cmbView.ItemIndex = 2 then
//        begin
//          Application.CreateForm(TfrmListRec, frmListRec);
//          frmListRec.rdrIdxSet := ReaderList;
//          frmListRec.permanent := chkPermanent.Checked;
//          frmListRec.ViewFromDB := chkViewFromDb.Checked;
//          frmListRec.ShowModal;
//          frmListRec.Free;
//        end
//{        else if cmbView.ItemIndex = 3 then
//        begin
//          Application.CreateForm(TfrmPictureFullSize, frmPictureFullSize);
//          frmPictureFullSize.rdrIdxSet := ReaderList;
//          frmPictureFullSize.permanent := chkPermanent.Checked;
//          frmPictureFullSize.ShowModal;
//          frmPictureFullSize.Free;
//        end}
//        else if cmbView.ItemIndex = 3 then
//        begin
//          Application.CreateForm(TfrmShowCaptures, frmShowCaptures);
//          frmShowCaptures.rdrIdxSet := ReaderList;
//          frmShowCaptures.permanent := chkPermanent.Checked;
//          frmShowCaptures.ViewFromDB := chkViewFromDb.Checked;
//          frmShowCaptures.ShowModal;
//          frmShowCaptures.Free;
//        end;
//      end;

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
                 if Readers[i].R_Type = RDR_VEGA9300 then
                 begin
//                   if Z84GetAllRecord(Readers[i-1], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i) then
//                   begin
                     Sleep(500);
                     if ReaderInitial(Readers[i]) then
                      grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال انجام شد.'
                    else
                      grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال ناموفق بود';
//                   end;
                   grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
                   grdRdrs.Refresh;
                 end;
              end;
          Mouse_NoWait;
        end;
      end;
//      RDR_Authority:
//      begin
//        lst := TStringList.Create;
//        lst.Clear;
//
//        if cmbOperate.ItemIndex = 0 then   // send list
//        begin
//          ClearGridMessage;
//          for i := 1 to TotalReader do
//            if i in ReaderList  then
//            begin
//              if LastType = RDR_CLK120 then
//                Sleep(2000);
//              LastType := Readers[i].R_Type;
//
//              with adoQryPersons do
//              begin
//                close;
////                Connection := frmDBS.DBConnection;
//                SQL.Clear;
//                if rdoProxi.checked then
//                  SQL.Add('select p_proxi from persons where p_isValid = ' + IntToStr(mb_true) + ' order by p_proxi')
//                else
//                  SQL.Add('select p_barcode from persons where p_isValid = ' + IntToStr(mb_true) + ' order by p_barcode');
//                Open;
//              end;
//              Mouse_Wait;
//              MSG_Wait('در حال ارسال لیست افراد مجاز تردد...' + '  تعداد : ' + IntToStr(adoQryPersons.RecordCount));
//
//              if adoQryPersons.recordCount > 1500 then
//                InformationMessage('امکان ارسال لیست بیشتر از 1500 نفر غیرممکن است .'
//                + #13 + 'در صورت وجود پرسنل اضافی در لیست پرسنل آنها را بصورت غیر فعال درآورده و مجدادا اقدام نمایید.')
//              else
//              if SetAuthority(Readers[i], adoqryPersons) then
//                grdRdrs.Cells[3, i] := 'ارسال لیست با موفقیت انجام شد . تعداد = ' + IntToStr(adoQryPersons.RecordCount)
//              else
//                grdRdrs.Cells[3, i] := 'ارسال لیست ناموفق بود .';
//              grdRdrs.Refresh;
//              Mouse_NoWait;
//              MSG_NoWait;
//            end;
//        end
//        else if cmbOperate.ItemIndex = 1 then   // get
//        begin
//          Mouse_Wait;
//          MSG_Wait('در حال خواندن لیست افراد مجاز به تردد...');
//          ClearGridMessage;
//          for i := 1 to TotalReader do
//            if i in ReaderList  then
//            begin
//              if LastType = RDR_CLK120 then
//                Sleep(2000);
//              LastType := Readers[i].R_Type;
//              if GetAuthority(Readers[i] , lst) then
//                grdRdrs.Cells[3, i] := 'تعداد = ' + inttostr(strtoint(lst.Strings[0])-1) //(lst.Count)
//              else
//                grdRdrs.Cells[3, i] := 'خواندن لیست افراد مجاز به تردد ناموفق بود .';
//              grdRdrs.Refresh;
//            end;
//          Mouse_NoWait;
//          MSG_NoWait;
//        end
//        else if cmbOperate.ItemIndex = 2 then   // empty list
//        begin
//          lst := TStringList.Create;
//          lst.Clear;
//
//          Mouse_Wait;
//          MSG_Wait('در حال غیر فعال کردن لیست افراد مجاز به تردد ... ');
//          ClearGridMessage;
//          for i := 1 to TotalReader do
//            if i in ReaderList  then
//            begin
//              if LastType = RDR_CLK120 then
//                Sleep(2000);
//              LastType := Readers[i].R_Type;
//              if SetAuthority(Readers[i], nil) then
//                grdRdrs.Cells[3, i] := 'لیست افراد مجاز به تردد غیر فعال شد.'
//              else
//                grdRdrs.Cells[3, i] := 'ناموفق';
//              grdRdrs.Refresh;
//            end;
//          Mouse_NoWait;
//          MSG_NoWait;
//        end;
//        lst.Destroy;
//      end;
//      RDR_FingerPrg:
//      begin
//        if rdoType1.Checked then
//        begin
//          Application.CreateForm(TfrmFingerPrg, frmFingerPrg);
//          frmFingerPrg.rdrIdxSet := ReaderList;
//          frmFingerPrg.ShowModal;
//          frmFingerPrg.Free;
//        end
//        else if rdoType2.Checked then
//        begin
//          Application.CreateForm(TfrmFingerPrg2, frmFingerPrg2);
//          frmFingerPrg2.rdrIdxSet := ReaderList;
//          try
//            frmFingerPrg2.timeOut := StrToInt(txtTimeOut.text);
//          except
//            frmFingerPrg2.timeOut := 40;
//          end;
//          frmFingerPrg2.ShowModal;
//          frmFingerPrg2.Free;
//        end
//        else if rdoType3.Checked then
//        begin
//          rdrSelectedCount := 0;
//          for i := 1 to TotalReader do
//            if i in ReaderList then
//              inc(rdrSelectedCount);
//
//          if rdrSelectedCount = 1 then
//          begin
//            Application.CreateForm(TfrmFingerPrg2, frmFingerPrg2);
//            frmFingerPrg2.rdrIdxSet := ReaderList;
//            frmFingerPrg2.ChangeModeAll(Direct_Mode);
//            frmComTools.ComPort.Close;
//            Application.Minimize;
//            ShellEXECandWait(txtPath.Text);
//            Application.Restore;
//            frmFingerPrg2.ChangeModeAll(Normal_Mode);
//            frmFingerPrg2.Free;
//          end
//          else
//            ErrorMessage('براي اجراي فايل بايد فقط يک دستگاه انتخاب شود .');
//        end;
//      end;
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


