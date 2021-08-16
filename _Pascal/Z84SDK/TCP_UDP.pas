unit TCP_UDP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, OleCtrls, Sockets,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdTCPConnection,
  IdTCPClient,{RunCmnds ,}comtools,
  ScktComp,Cnstants;

type
  TfrmTcpUdp = class(TForm)
    udpData: TIdUDPClient;
    tcpData: TIdTCPClient;
    procedure FormCreate(Sender: TObject);
    procedure tcpDataWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
  private
    { Private declarations }
  public
    recievdData  : boolean;
  end;

var
  frmTcpUdp: TfrmTcpUdp;




function  TCPSendData(pkt:AnsiString; ip : String) : Boolean;
procedure TCPReadData(var pkt: String; var retVal : Byte);

function  UDPSendData(pkt, ip : String) : Boolean;
procedure UDPReadData(var pkt: String; var retVal : Byte);



function  TCP_UDP_LinkTest(rdrInfo : TReaders) : Boolean;

function  TCP_UDP_ReStart(rdrInfo : TReaders) : Boolean;
function  TCP_UDP_Initial(rdrInfo : TReaders) : Boolean;
function  TCP_UDP_ReadVersion(rdrInfo : TReaders; var versionST : String) : Boolean;

function  TCP_UDP_SendDateTime(rdrInfo : TReaders; DT, TM : String) : Boolean;
function  TCP_UDP_GetDateTime(rdrInfo : TReaders; var DT, TM : String) : Boolean;

function  TCP_UDP_SendLimitTime(rdrInfo : TReaders; ST1, ST2, ST3 : String) : Boolean;
function  TCP_UDP_GetLimitTime(rdrInfo : TReaders; var ST1, ST2, ST3 : String) : Boolean;

function  TCP_UDP_SetLimitCard(rdrInfo : TReaders; no : Byte; fromCard, toCard : String) : Boolean;
function  TCP_UDP_GetLimitCard(rdrInfo : TReaders; no : Byte; var fromCard, toCard : String) : Boolean;

function  TCP_UDP_SendPersonMsg(rdrInfo : TReaders; CardCode, Msg1, Msg2, Msg3, Msg4 : String) : Byte;
function  TCP_UDP_GetPersonMsg(rdrInfo : TReaders; CardCode : String; var msg : String) : Byte;
function  TCP_UDP_DelPersonMsg(rdrInfo : TReaders; CardCode : String) : Byte;
function  TCP_UDP_DeleteAllReaderMessage(rdrInfo : TReaders) : Boolean;

function  TCP_UDP_SendReaderMsg(rdrInfo : TReaders; Msg1, Msg2, Msg3, Msg4 : String) : Boolean;

function  TCP_UDP_ChangeAddress(rdrInfo : TReaders; newAddrs : Byte) : Boolean;
function  TCP_UDP_ChangReaderPassword(rdrInfo : TReaders; newPass : String) : Boolean;

function  TCP_UDP_SetOpenDoor_Normal(rdrInfo : TReaders; doorTime : Byte) : Boolean;
function  TCP_UDP_SetOpenDoor_All(rdrInfo : TReaders; doorTime : String) : Boolean;
function  TCP_UDP_SetCloseDoor(rdrInfo : TReaders; doorTime : String) : Boolean;

function  TCP_UDP_SetFunctionKeys(rdrInfo : TReaders; FKey1, FKey2, FKey3, FKey4 : Byte) : Boolean;
function  TCP_UDP_GetFunctionKeys(rdrInfo : TReaders; var FKey1, FKey2, FKey3, FKey4 : Byte) : Boolean;
function  TCP_UDP_ChangeFunctionKeysActive(rdrInfo : TReaders; KeyActive : Boolean) : Boolean;

function  TCP_UDP_SetInvalidCards(rdrInfo : TReaders; ST : String) : Boolean;
function  TCP_UDP_GetInvalidCards(rdrInfo : TReaders; var ST : String) : Boolean;
function  TCP_UDP_DelInvalidCards(rdrInfo : TReaders) : Boolean;

function  TCP_UDP_SetAlarmTimes(rdrInfo : TReaders; ST : String) : Boolean;
function  TCP_UDP_GetAlarmTimes(rdrInfo : TReaders; var ST : String) : Boolean;
function  TCP_UDP_DelAlarmTimes(rdrInfo : TReaders) : Boolean;

function  TCP_UDP_SetAccessCode(rdrInfo : TReaders; ST : String) : Boolean;
function  TCP_UDP_GetAccessCode(rdrInfo : TReaders; var ST : String) : Boolean;
function  TCP_UDP_DelAccessCode(rdrInfo : TReaders) : Boolean;

function  TCP_UDP_SetPishCard(rdrInfo : TReaders; No : Byte; PishCard, CardNo : String) : Boolean;
function  TCP_UDP_GetPishCard(rdrInfo : TReaders; No : Byte; var PishCard, CardNo : String) : Boolean;

function TCP_UDP_ChangeOnOffMode(rdrInfo : TReaders; onLine : Boolean ) : Boolean;
function TCP_UDP_ReadOnOffMode(rdrInfo : TReaders; var onLine : Boolean) : Boolean;

function TCP_UDP_GetRecord(rdrInfo : TReaders ; rType : Byte; DT : String; IsFirst : Boolean; var retVal : Byte; var Data : string) : boolean;
function TCP_UDP_GetRecordI(rdrInfo : TReaders ;  rType : Byte; DT : STR_TYPE; IsFirst : Boolean ; var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt): boolean;
function TCP_UDP_GetRecordInFile(rdrInfo : TReaders ;  rType : Byte; DT, FName : STR_TYPE; var retVal : Byte) : Integer;

procedure TCP_UDP_MTT_OnLineRec(rdrInfo : TReaders ; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte);
function TCP_UDP_PrintToReaders(rdrInfo : TReaders ; printer_type : byte ; st : string; DblWidth , color: boolean):boolean;
function TCP_UDP_PrintToPrinter(rdrInfo : TReaders; st : String):boolean;
function TCP_UDP_CutPrint(rdrInfo : TReaders ; printer_type : byte):boolean;
function  TCP_UDP_SendBeep(rdrInfo : TReaders; count : Char) : Boolean;
function  TCP_UDP_ReadReaderErrors(rdrInfo : TReaders; var errCount : String) : Boolean;
function TCP_UDP_SetOnlyCards(rdrInfo : TReaders; ST : ansistring) : boolean;
function TCP_UDP_GetOnlyCards(rdrInfo : TReaders; var ST : ansistring) : boolean;
function TCP_UDP_SetAuthority(rdrInfo : TReaders; ST : ansistring) : boolean;
function TCP_UDP_GetAuthority(rdrInfo : TReaders; var ST : ansistring) : boolean;

implementation

uses
  Funcs, DateProc, Code_Sys;


{$R *.dfm}



(*******************************************************************************
                                  TCP Connection
*******************************************************************************)

{ Send data to tcp protocol }
function TCPSendData(pkt:AnsiString; ip : String) : Boolean;
begin
  while frmTcpUdp.tcpData.Connected do
  begin
    frmTcpUdp.tcpData.IOHandler.InputBufferAsString;
    frmTcpUdp.tcpData.Disconnect;
  end;
  frmTcpUdp.tcpData.Host := ip;
  try
    frmTcpUdp.tcpData.Connect;
    if frmTcpUdp.tcpData.Connected then
    begin
      frmTcpUdp.tcpData.IOHandler.WriteLn(pkt);
//      frmTcpUdp.tcpData.SendBuffer(@pkt[1], Length(pkt));    //for TNMMSG componentfrom fastNet package
      Result := True;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;{ Send data to tcp protocol }

{ Read dsata from TCP protocol}
procedure TCPReadData(var pkt: AnsiString; var retVal : Byte);
var
  i : Integer;
  l, checkSum : Byte;
  ss : char;  //NEW
  Vbuf : array of Byte; //NEW
begin
  Sleep(150);
  pkt := '';
  retVal := ERR_NONE;
  i := 0;
  if frmTcpUdp.tcpData.Connected then
  begin
    try
      repeat
        ss := frmTcpUdp.tcpData.IOHandler.ReadChar;
        pkt := pkt + ss;
        i := i +1;
      until  frmTcpUdp.tcpData.IOHandler.InputBufferIsEmpty;
//      pkt := frmTcpUdp.tcpData.IOHandler.InputBufferAsString; OLD
    except
    end;
  end;


  l := Length(pkt);
  if l > 2 then
  begin
    checkSum := 0;
    for i := 2 to l-2 do checkSum := checkSum XOR Ord(pkt[i]);
    if checkSum <> Ord(pkt[l])then retVal := ERR_CHEKSUM
    else if Ord(pkt[L-1]) <> 03 then retVal := ERR_ETX
    else if Ord(pkt[1]) <> 02 then retVal := ERR_STX;
  end
  else
    retVal := ERR_OFF;
end;{ Read dsata from TCP protocol}







(*******************************************************************************
                                  UDP Connection
*******************************************************************************)

{ Send data to UDP protocol }
function UDPSendData(pkt, ip : String) : Boolean;
var
//  bff : array of byte;
  i : Integer;
begin
  if frmTcpUdp.udpData.Active then
    frmTcpUdp.udpData.Active := False;
  frmTcpUdp.udpData.Host := ip;
  frmTcpUdp.udpData.Active := True;
{  for i := 1 to Length(pkt) do
  begin
    bff[i] := ord(pkt[i]);
    bff[i+1] := 0;
  end;
}
  try
//    frmTcpUdp.udpData.SendBuffer(bff, Length(pkt));   //delphi6,7
    frmTcpUdp.udpData.Send(pkt);
    Result := True;
  except
    Result := False;
  end;
end;


{ Read dsata from UDP protocol}
procedure UDPReadData(var pkt: String; var retVal : Byte);
var
  i, l : Integer;
  checkSum : Byte;
  bff : array[1..10] of char;
begin
  pkt := '';
  retVal := ERR_NONE;
  pkt := frmTcpUdp.udpData.ReceiveString(1000);
{  l := length(bff);
  if l > 0 then
  begin
    for i := 1 to l do
      pkt := pkt + bff[i];
  end;
}
  l := Length(pkt);
  if l > 2 then
  begin
    checkSum := 0;
    for i := 2 to l-2 do checkSum := checkSum XOR Ord(pkt[i]);
    if checkSum <> Ord(pkt[l])then retVal := ERR_CHEKSUM
    else if Ord(pkt[L-1]) <> 03 then retVal := ERR_ETX
    else if Ord(pkt[1]) <> 02 then retVal := ERR_STX;
  end
  else
    retVal := ERR_OFF;
end;{ Read dsata from UDP protocol}





(*******************************************************************************
                            TCP/UDP Routines
*******************************************************************************)

{ Link test command }
function TCP_UDP_LinkTest(rdrInfo : TReaders) : Boolean;
const
  LINK_DATA = 'DPCOLINK';
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $01, 0, LINK_DATA);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;
  if (getVal = ERR_NONE) and (Ord(pkt[4]) = $01) and (Ord(pkt[3]) = rdrInfo.R_Code) then
    Result := (Copy(pkt, 6, 8) = LINK_DATA)
  else
    Result := False;

end;{ Link test command }



{ Reset command }
function TCP_UDP_ReStart(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0C, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Link test command }



{ Initial Commant }
function TCP_UDP_Initial(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $1F, 0, 'REINITIALIZATION');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end; { Initial Commant }



{ Read reader version command }
function TCP_UDP_ReadVersion(rdrInfo : TReaders;var versionST : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0E, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $0E) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
    versionST := Copy(pkt, 6, Length(pkt)-7)
  else
    versionST := '';
end;{ Read reader version command }



{ Read no. of error on reader command }
function TCP_UDP_ReadReaderErrors(rdrInfo : TReaders; var errCount : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
  err : Word;
begin
  errCount := '';
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $1E, 0, 'R'#1);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $1E) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    err := (Ord(pkt[6]) * 256) + Ord(pkt[7]);
    if err = $FFFF then
      err := 0;

    errCount := 'Err=' + IntToStr(err);
  end;
end;{ Read no. of error on reader command }


{ Send date and time Command }
function TCP_UDP_SendDateTime(rdrInfo : TReaders; DT, TM : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0B, 0,
             DT[3]+DT[4]+DT[6]+DT[7]+DT[9]+DT[10]+
             TM[1]+TM[2]+TM[4]+TM[5]+TM[7]+TM[8]);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Send date and time Commant }



{ Read date and time Command }
function TCP_UDP_GetDateTime(rdrInfo : TReaders; var DT, TM : String) : Boolean;
var
  pkt, t : String;
  i, getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $20, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $21) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    DT := Copy(pkt, 6, 6);
    if IsNumeric(DT) then
    begin
      Insert('/', DT, 3);
      Insert('/', DT, 6);
      DT := BeautifulDate(DT);
    end
    else
    begin
      t := '';
      for i := 1 to Length(DT) do
        t := t + IntToStr(Ord(DT[i])) + ' ';
      DT := t;
    end;

    TM := Copy(pkt, 12, 6);
    if IsNumeric(TM) then
    begin
      Insert(':', TM, 3);
      Insert(':', TM, 6);
    end
    else
    begin
      t := '';
      for i := 1 to Length(TM) do
        t := t + IntToStr(Ord(TM[i])) + ' ';
      TM := t;
    end;
  end;
end;{ Read no. of error on reader command }




{ Send limitation time Command }
function TCP_UDP_SendLimitTime(rdrInfo : TReaders; ST1, ST2, ST3 : String) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  ST := #1'L'#12;

  ST := ST + StrToBCD(ST1, 1) + StrToBCD(ST1, 4) +
             StrToBCD(ST1, 6) + StrToBCD(ST1, 9);

  ST := ST + StrToBCD(ST2, 1) + StrToBCD(ST2, 4) +
             StrToBCD(ST2, 6) + StrToBCD(ST2, 9);

  ST := ST + StrToBCD(ST3, 1) + StrToBCD(ST3, 4) +
             StrToBCD(ST3, 6) + StrToBCD(ST3, 9);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $48, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Send limitation time Command }




{ Get limitation time Command }
function TCP_UDP_GetLimitTime(rdrInfo : TReaders; var ST1, ST2, ST3 : String) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  ST := #1'L'#12;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $49, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $48) and (Ord(pkt[3]) = rdrInfo.R_Code);
  ST1 := ''; ST2 := ''; ST3 := '';
  if Result then
  begin
    ST1 := BCDToStr(pkt[09]) + ':' + BCDToStr(pkt[10]) + ' - ' +
           BCDToStr(pkt[11]) + ':' + BCDToStr(pkt[12]);
    ST2 := BCDToStr(pkt[13]) + ':' + BCDToStr(pkt[14]) + ' - ' +
           BCDToStr(pkt[15]) + ':' + BCDToStr(pkt[16]);
    ST3 := BCDToStr(pkt[17]) + ':' + BCDToStr(pkt[18]) + ' - ' +
           BCDToStr(pkt[19]) + ':' + BCDToStr(pkt[20]);
  end;
end;{ Get limitation time Command }




{ Send limitation card Command }
function TCP_UDP_SetLimitCard(rdrInfo : TReaders; No : Byte; FromCard, ToCard : String) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  if (FromCard = '') or (ToCard = '') then
    ST := Chr(No) + #255#255#255#255#255#255#255#255
  else
    ST := Chr(No) + Str_PBCD(FromCard, 8) + Str_PBCD(ToCard, 8);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $36, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Send limitation card Command }



{ Get limitation card Command }
function TCP_UDP_GetLimitCard(rdrInfo : TReaders; no : Byte; var fromCard, toCard : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $37, 0, Chr(no));
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      //Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $36) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    Delete(pkt, 1, 6);
    fromCard := PBCD_Str(Copy(pkt, 1, 4), 8);
    toCard := PBCD_Str(Copy(pkt, 5, 4), 8);
  end;
end;{ get limitation card Command }



{ Send message for card command }
function TCP_UDP_SendPersonMsg(rdrInfo : TReaders; CardCode, Msg1, Msg2, Msg3, Msg4 : String) : Byte;
var
  pkt, S : String;
  getVal, i : Byte;
begin
  Result := 0;
  S := AlphaReverse(StrRev(FixLen(Msg1, ' ', 16))) +
       AlphaReverse(StrRev(FixLen(Msg2, ' ', 16))) +
       AlphaReverse(StrRev(FixLen(Msg3, ' ', 16))) +
       AlphaReverse(StrRev(FixLen(Msg4, ' ', 16)));
  for i := 1 to 8-Length(CardCode) do
    CardCode := '0' + CardCode;
  CardCode := BarCode4(CardCode);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $41, 0, CardCode + S);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;
  if (getVal = ERR_NONE) and (Ord(pkt[3]) = rdrInfo.R_Code) then
    Result := Ord(pkt[4]);
end;{ Send message for card command }



{ Get card message command }
function TCP_UDP_GetPersonMsg(rdrInfo : TReaders; CardCode : String; var msg : String) : Byte;
var
  pkt, S : String;
  getVal, i : Byte;
begin
  Result := 0;
  Msg := '';
  for i := 1 to 8-Length(CardCode) do
    CardCode := '0' + CardCode;
  CardCode := BarCode4(CardCode);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $44, 0, CardCode);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  if (getVal = ERR_NONE) and (Ord(pkt[3]) = rdrInfo.R_Code) then
  begin
    Result := Ord(pkt[4]);
    if Result = $46 then
    begin
      msg := Copy(pkt, 10, 64);
      S := StrRev(Copy(msg, 1, 16));
      S := S + ' ' + StrRev(Copy(msg, 17, 16));
      S := S + ' ' + StrRev(Copy(msg, 33, 16));
      S := S + ' ' + StrRev(Copy(msg, 49, 16));
      msg := Trim(AlphaReverse(S));
    end;
  end;
end;{ Get card message command }



{ Delete card message command }
function TCP_UDP_DelPersonMsg(rdrInfo : TReaders; CardCode : String) : Byte;
var
  pkt : String;
  getVal, i : Byte;
begin
  Result := 0;
  for i := 1 to 8-Length(CardCode) do
    CardCode := '0' + CardCode;
  CardCode := BarCode4(CardCode);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $47, 0, CardCode);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  if (getVal = ERR_NONE) and (Ord(pkt[3]) = rdrInfo.R_Code) then
    Result := Ord(pkt[4]);
end;{ Delete card message command }



{ Delete All card message command }
function TCP_UDP_DeleteAllReaderMessage(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $40, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      TCPReadData(pkt, getVal)
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;
  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Delete all card message command }





{ Send reader message command }
function TCP_UDP_SendReaderMsg(rdrInfo : TReaders; Msg1, Msg2, Msg3, Msg4 : String) : Boolean;
var
  pkt, S : String;
  getVal, i : Byte;
  OK : Boolean;
begin
  OK := True;
  for i := 1 to 4 do
  begin
    case i of
      1: s := Msg1;
      2: s := Msg2;
      3: s := Msg3;
      4: s := Msg4;
    end;
    S := StrRev(WinToDos(S,WIN_MICROSOFT_SYS , DOS_IR_SYS));
    s := StrRev(StrRev(FixLeft(s,' ',16)));
    if S <> '' then
    begin
      S := chr(i-1) + #0#0 + S;
      Z84_MakePocket(PKt, rdrinfo.R_Code, $13, 0, S);
      if rdrInfo.R_TCP then
      begin
        if TCPSendData(pkt, rdrInfo.R_IP) then
          TCPReadData(pkt, getVal)
        else
          OK := OK AND False;
      end
      else
      begin
        if UDPSendData(pkt, rdrInfo.R_IP) then
          UDPReadData(pkt, getVal)
        else
          OK := OK AND False;
      end;

      if OK then
        OK := OK and (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
    end;

  end;
  Result := OK;
end;{ Send reader message command }




{ change reader address command }
function TCP_UDP_ChangeAddress(rdrInfo : TReaders; newAddrs : Byte) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0F, 0, Chr(newAddrs));
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = newAddrs);
end;{ change reader address command }

{ change reader password command }
function TCP_UDP_ChangReaderPassword(rdrInfo : TReaders; newPass : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  newPass := 'W' + newPass;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $1A, 0, newPass);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ change reader password command }




{ Set timeout openning door command }
function TCP_UDP_SetOpenDoor_Normal(rdrInfo : TReaders; doorTime : Byte) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $2C, 0, Chr(doorTime+1));
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set timeout openning door command }




{ Set openning door command }
function TCP_UDP_SetOpenDoor_All(rdrInfo : TReaders; doorTime : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
  n : Integer;
begin
  Result := False;
  n := StrToInt(DoorTime);
  DoorTime := Chr(n mod 255) + Chr(n div 255);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $2A, 0, DoorTime);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set openning door command }




{ Set Close door command }
function TCP_UDP_SetCloseDoor(rdrInfo : TReaders; doorTime : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
  n : Integer;
begin
  Result := False;
  n := StrToInt(DoorTime);
  DoorTime := Chr(n mod 256) + Chr(n div 256);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $2B, 0, DoorTime);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set Close door command }




{ Set function key command }
function TCP_UDP_SetFunctionKeys(rdrInfo : TReaders; FKey1, FKey2, FKey3, FKey4 : Byte) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  ST := #0'F'#8 +
        #$F1 + Str_PBCD(IntToStr(FKey1), 0) +
        #$F2 + Str_PBCD(IntToStr(FKey2), 0) +
        #$F3 + Str_PBCD(IntToStr(FKey3), 0) +
        #$F4 + Str_PBCD(IntToStr(FKey4), 0);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $48, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $6) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set function key command }




{ Get function key command }
function TCP_UDP_GetFunctionKeys(rdrInfo : TReaders; var FKey1, FKey2, FKey3, FKey4 : Byte) : Boolean;
var
  pkt, ST, keyVal : String;
  getVal : Byte;
begin
  Result := False;
  ST := #0'F';
  Z84_MakePocket(pkt, rdrInfo.R_Code, $49, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $48) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    if pkt[09] = #$F1 then
    begin
      keyVal := PBCD_Str(pkt[10], 0);
      if KeyVal <> 'FF' then
        FKey1 := StrToInt(keyVal)
      else
        FKey1 := 0;
    end
    else
      FKey1 := 0;

    if pkt[11] = #$F2 then
    begin
      keyVal := PBCD_Str(pkt[12], 0);
      if KeyVal <> 'FF' then
        FKey2 := StrToInt(keyVal)
      else
        FKey2 := 0;
    end
    else
      FKey2 := 0;

    if pkt[13] = #$F3 then
    begin
      keyVal := PBCD_Str(pkt[14], 0);
      if KeyVal <> 'FF' then
        FKey3 := StrToInt(keyVal)
      else
        FKey3 := 0;
    end
    else
      FKey3 := 0;

    if pkt[15] = #$F4 then
    begin
      keyVal := PBCD_Str(pkt[16], 0);
      if KeyVal <> 'FF' then
        FKey4 := StrToInt(keyVal)
      else
        FKey4 := 0;
    end
    else
      FKey4 := 0;
  end;
end;{ Get function key command }



{ Active function key command }
function TCP_UDP_ChangeFunctionKeysActive(rdrInfo : TReaders; KeyActive : Boolean) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  if KeyActive then ST := 'E'
  else              ST := 'D';
  Z84_MakePocket(pkt, rdrInfo.R_Code, $34, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Active function key command }




{ Set Invalid card command }
function TCP_UDP_SetInvalidCards(rdrInfo : TReaders; ST : String) : Boolean;
var
  pkt, S : String;
  getVal : Byte;
begin
  Result := False;
  S := Str_PBCD(ST, Length(ST));
  Z84_MakePocket(pkt, rdrInfo.R_Code, $26, 0, S);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set Invalid card command }



{ Get Invalid card command }
function TCP_UDP_GetInvalidCards(rdrInfo : TReaders; var ST : String) : Boolean;
var
  pkt, S : String;
  getVal : Byte;
begin
  Result := False;
  S := Str_PBCD(ST, Length(ST));
  Z84_MakePocket(pkt, rdrInfo.R_Code, $28, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $29) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    ST := '';
    Delete(pkt, Length(pkt)-1, 2);
    Delete(pkt, 1, 5);
    ST := PBCD_Str(pkt, Length(pkt)*2);
  end;
end;{ Get Invalid card command }




{ Delete Invalid card command }
function TCP_UDP_DelInvalidCards(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $27, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Delete Invalid card command }




{ Set alarm command }
function TCP_UDP_SetAlarmTimes(rdrInfo : TReaders; ST : String) : Boolean;
var
  pkt, S : String;
  getVal : Byte;
begin
  Result := False;
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + StrToBCD(ST, 1) + StrToBCD(ST, 4) + ST[6] + ST[7];
    Delete(ST, 1, 7);
  end;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $22, 0, S);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set alarm command }




{ Get alarm command }
function TCP_UDP_GetAlarmTimes(rdrInfo : TReaders; var ST : String) : Boolean;
var
  pkt : String;
  i, getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $24, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $25) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    ST := '';
    Delete(pkt, 1, 5);
    for i := 1 to 15 do
    begin
      if (pkt[1] <> #255) and (Length(pkt) >= 4) then
        ST := ST + BCDToStr(pkt[1]) + ':' + BCDToStr(pkt[2]) + pkt[3] + pkt[4]
      else
        ST := ST + '00:00'#0#0;

      if Length(pkt) > 4 then
        Delete(pkt, 1, 4)
      else
        pkt[1] := #255;
    end;

  end;
end;{ Set alarm command }





{ Delete alarm command }
function TCP_UDP_DelAlarmTimes(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $23, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Delete alarm command }




{ Set Access code command }
function TCP_UDP_SetAccessCode(rdrInfo : TReaders; ST : String) : Boolean;
var
  pkt, S : String;
  getVal : Byte;
begin
  Result := False;
  S := '';
  while Length(ST) > 0 do
  begin
    S := S + StrToBCD(ST, 1);
    Delete(ST, 1, 2);
  end;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $09, 0, S);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set Access code command }



{ Get access code command }
function TCP_UDP_GetAccessCode(rdrInfo : TReaders; var ST : String) : Boolean;
var
  pkt : String;
  i, getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0D, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $0D) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    ST := '';
    Delete(pkt, 1, 5);
    for i := 1 to 5 do
    begin
      if pkt[1] <> #255 then
        ST := ST + BCDToStr(pkt[1]) + BCDToStr(pkt[2])
      else
        ST := ST + '0000';

      Delete(pkt, 1, 2);
    end;
  end;
end;{ Get access code command }





{ Delete Access code command }
function  TCP_UDP_DelAccessCode(rdrInfo : TReaders) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $0A, 0, '');
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Delete Access code command }




{ Set pish card command }
function TCP_UDP_SetPishCard(rdrInfo : TReaders; No : Byte; PishCard, CardNo : String) : Boolean;
var
  pkt, ST : String;
  getVal : Byte;
begin
  Result := False;
  if (PishCard = '') or (CardNo = '') then
    ST := Chr(No) + #255#255#255#255#255
  else
    ST := Chr(No) + BarCode4(FixLeft(CardNo, '0', 8)) + StrToBCD(FixLeft(PishCard, '0', 2), 1);
  Z84_MakePocket(pkt, rdrInfo.R_Code, $57, 0, ST);
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
    begin
      Sleep(100);
      TCPReadData(pkt, getVal);
    end
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $06) and (Ord(pkt[3]) = rdrInfo.R_Code);
end;{ Set pish card command }

{ Get pish card command }
function  TCP_UDP_GetPishCard(rdrInfo : TReaders; No : Byte; var PishCard, CardNo : String) : Boolean;
var
  pkt : String;
  getVal : Byte;
begin
  Result := False;
  Z84_MakePocket(pkt, rdrInfo.R_Code, $58, 0, Chr(No));
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pkt, rdrInfo.R_IP) then
      TCPReadData(pkt, getVal)
    else
      Exit;
  end
  else
  begin
    if UDPSendData(pkt, rdrInfo.R_IP) then
      UDPReadData(pkt, getVal)
    else
      Exit;
  end;

  Result := (getVal = ERR_NONE) and (Ord(pkt[4]) = $57) and (Ord(pkt[3]) = rdrInfo.R_Code);
  if Result then
  begin
    Delete(pkt, 1, 6);
    if pkt[1] <> #255 then
    begin
      CardNo := BarCode8(Copy(pkt, 1, 4));
      PishCard := BCDToStr(pkt[5]);
    end
    else
      CardNo := '00000000';
  end;
end;{ Get pish card command }

function TCP_UDP_ChangeOnOffMode(rdrInfo : TReaders; onLine : Boolean ) : Boolean;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
  isSent: Boolean;
begin
  if onLine then
    Z84_MakePocket(PK, rdrInfo.R_Code, $11, 0, 'S')
  else
    Z84_MakePocket(PK, rdrInfo.R_Code, $11, 0, 'I');
  isSent := false;
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end
  else
  begin
    if UDPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end;
  if not isSent then
    OK := False
  else
  begin
    if rdrInfo.R_TCP then
      TCPReadData(pk, getVal)
    else
      UDPReadData(pk, getVal);
    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
  end;
  Result := OK;
end;


function TCP_UDP_ReadOnOffMode(rdrInfo : TReaders; var onLine : Boolean) : Boolean;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
  isSent: Boolean;
begin
  Z84_MakePocket(PK, rdrinfo.R_Code , $12, 0, '');
  isSent := false;
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end
  else
  begin
    if UDPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end;

  if not isSent then
    OK := False
  else
  begin
    if rdrInfo.R_TCP then
      TCPReadData(pk, getVal)
    else
      UDPreadData(pk, getVal);

    OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $12) and (Ord(PK[3]) = rdrInfo.R_Code));
    if OK then
      onLine := (PK[6] = 'S');
  end;
  result := OK;
end;

{Get Record command}
function TCP_UDP_GetRecord(rdrInfo : TReaders ; rType : Byte; DT : String; IsFirst : Boolean; var retVal : Byte; var Data : string): boolean;
var
  n, getVal : Byte;
  PK : AnsiString;
  isSent : boolean;
begin
  if IsFirst then
  begin
    case rType of
      ALL_COLLECTION: Z84_MakePocket(PK, rdrInfo.R_Code, $02, 0, '');
      ALL_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
      NEW_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    end;
  end
  else if retVal = MB_TRUEREC then
    Z84_MakePocket(PK, rdrInfo.R_Code, $06, 0, '')
  else
    Z84_MakePocket(PK, rdrInfo.R_Code, $15, 0, '');
  isSent := false;
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end
  else
  begin
    if UDPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end;

  if not isSent then
    retVal := ERR_OFF
  else
  begin
    n := 0;
    repeat
      Inc(n);
      Sleep(300);
      if rdrInfo.R_TCP then
        TCPReadData(pk, getVal)
      else
        UDPReadData(pk, getVal);
      if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
      begin
        case Ord(PK[4]) of
          3: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          4: //Record Exists
          begin
            Data := Copy(PK, 6, 23);
            //Data := Copy(PK, 6, 31);//bank melat
            retVal := MB_TRUEREC;
          end;

          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else
        retVal := MB_BADREC;
    until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
  end;
end;{Get Record command}

function TCP_UDP_GetRecordI(rdrInfo : TReaders ;  rType : Byte; DT : STR_TYPE; IsFirst : Boolean ; var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt): boolean;
var
  n, getVal : Byte;
  PK : String;
  isSent: Boolean;
begin
  if IsFirst then
  begin
    case rType of
      ALL_COLLECTION: Z84_MakePocket(PK, rdrInfo.R_Code, $02, 0, '');
      ALL_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
      NEW_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    end;
  end
  else if retVal = MB_TRUEREC then
    Z84_MakePocket(PK, rdrInfo.R_Code, $06, 0, '')
  else
    Z84_MakePocket(PK, rdrInfo.R_Code, $15, 0, '');

  isSent := false;
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end
  else
  begin
    if UDPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end;

  if not isSent then
    retVal := ERR_OFF
  else
  begin
    n := 0;
    repeat
      Inc(n);
      if rdrInfo.R_TCP then
        TCPReadData(pk, getVal)
      else
        UDPReadData(pk, getVal);

      if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
      begin
        case Ord(PK[4]) of
          3: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          4: //Record Exists
          begin
            //Data := Copy(PK, 6, 23);

            recType := StrToInt(Copy(PK, 9, 2));
            recDate := StrToInt(Copy(PK, 11, 6));
            recTime := StrToInt(Copy(PK, 17, 4));
            recCard := StrToInt(Copy(PK, 21, 8));

            retVal := MB_TRUEREC;
          end;

          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else
        retVal := MB_BADREC;
    until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
  end;
end;
(***************** Getting records and save to file *****************)

function TCP_UDP_GetRecordInFile(rdrInfo : TReaders ;  rType : Byte; DT, FName : STR_TYPE; var retVal : Byte) : Integer;
var
  n, getVal : Byte;
  PK : String;
  data : STR_TYPE;
  f : TextFile;
  recCount : Integer;
  isSent: Boolean;
  fileName : string;
begin
  recCount := 0;
  fileName := FName;
  AssignFile(f, fileName);
  ReWrite(f);
  case rType of
    ALL_COLLECTION: Z84_MakePocket(PK, rdrInfo.R_Code, $02, 0, '');
    ALL_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $2E, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
    NEW_RECOVERY  : Z84_MakePocket(PK, rdrInfo.R_Code, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
  end;

  n := 0;
  repeat
    isSent := false;
    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end;

    if not isSent then
      retVal := ERR_OFF
    else
    begin
      n := 0;
      repeat
        Inc(n);
        if rdrInfo.R_TCP then
          TCPReadData(pk, getVal)
        else
          UDPReadData(pk, getVal);
        if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
        begin
          case Ord(PK[4]) of
            3: //Buffer Empty
              retVal := MB_BUFFEMPTY;

            4: //Record Exists
            begin
              Inc(recCount);
              Data := pchar(Copy(PK, 6, 23));
              WriteLn(f, Data);
              //Data := Copy(PK, 6, 31);//bank melat
              retVal := MB_TRUEREC;
            end;

            else //Error in read data
              retVal := MB_BADREC;
          end;
        end
        else
          retVal := getVal;
      until (retVal in [MB_BUFFEMPTY, MB_TRUEREC]) or (n = 2);
    end;
    if retVal = MB_TRUEREC then
      Z84_MakePocket(PK, rdrInfo.R_Code, $06, 0, '')
    else
      Z84_MakePocket(PK, rdrInfo.R_Code, $15, 0, '');
    SLEEP(150);
  until (retVal in [MB_BUFFEMPTY, ERR_OFF]) or (n = 3);
  CloseFile(f);
  Result := recCount;
end;


(***************** Getting MTT online records *****************)
procedure TCP_UDP_MTT_OnLineRec(rdrInfo : TReaders ; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte);
var
  getVal : Byte;
  PK : String;
  isSent: Boolean;
begin
  data := '';
  if isGetRec then
    Z84_MakePocket(PK, rdrInfo.R_Code, $31, 0, '')
  else if retCode = 0 then
    Z84_MakePocket(PK, rdrInfo.R_Code, $06, 0, '')
  else
    Z84_MakePocket(PK, rdrInfo.R_Code, $15, 0, Chr(retCode));

  isSent := false;
  if rdrInfo.R_TCP then
  begin
    if TCPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end
  else
  begin
    if UDPSendData(pk, rdrInfo.R_IP) then
      isSent :=true;
  end;

  if not isSent then
    retCode := ERR_OFF
  else if  isGetRec then
  begin
    if rdrInfo.R_TCP then
      TCPReadData(pk, getVal)
    else
      UDPReadData(pk, getVal);
    if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
    begin
      case Ord(PK[4]) of
        $03: //Buffer Empty
          retCode := MB_BUFFEMPTY;

        $10: //Record Exists
        begin
//          Data := StrAlloc(23);
//          StrPCopy(Data , Copy(PK, 6, 23));
          Data := pchar(Copy(PK, 6, 23));
          retCode := MB_TRUEREC;
        end;

        $15:
          retCode := MTT_OFFLINE;

        else //Error in read data
          retCode := MB_BADREC;
      end;
    end
    else
      retCode := MB_BADREC;
  end;
end;

(***************** send String to printer *****************)
function TCP_UDP_PrintToReaders(rdrInfo : TReaders ; printer_type : byte ; st : string; DblWidth , color: boolean):boolean;
const
  MaxLoop = 5;
var
  PK : String;
  Status, n : Byte;
  isSent: boolean;
begin
  ST := StrRev(WinToDos(ST,WIN_MICROSOFT_SYS , DOS_IR_SYS)) + #13#10;
  case printer_type of
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
      if Color then
      begin
        if printer_type = PRN_CITIZEN3551 then
          ST := #27'4' + ST + #27'5'
        else
          ST := #$13+ST;
      end;
    end;

    PRN_ITHACA:
    begin
      if DblWidth then ST := #27'W'#1 + ST + #27'W'#0;
      if Color then
        ST := #27'c'#1 + ST
      else
        ST := #27'c'#0 + ST;
    end;
  end;

  n := 0;
  repeat
//    Delay(100);
    result := True;
    Inc(n);
    Z84_MakePocket(PK, rdrInfo.R_Code, $1C, 0, ST);
    isSent := false;
    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end;

    if not isSent then
      result := False
    else
    begin
      if rdrInfo.R_TCP then
        TCPReadData(pk, Status)
      else
        UDPReadData(pk, Status);
      if (Status = 0) and (Ord(PK[3]) = rdrInfo.R_Code) then
      begin
        case Ord(PK[4]) of
          $06 : result := True;
          $15 : result := False;
          else
          begin
            result := False;
            //n := MaxLoop;
          end;
        end;
      end
      else
        result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
    end;
  until (n = MaxLoop) or result;
end;

(***************** Direct Print to Printer *****************)
function TCP_UDP_PrintToPrinter(rdrInfo : TReaders; st : String):boolean;
const
  MaxLoop = 5;
var
  PK : String;
  Status, n : Byte;
  isSent: Boolean;
begin
  st := st + #13#10;
  n := 0;
  repeat
//    Delay(100);
    result := True;
    Inc(n);
    Z84_MakePocket(PK, rdrInfo.R_Code, $1C, 0, ST);
    isSent := false;
    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end;

    if not isSent then
      result := False
    else
    begin
      if rdrInfo.R_TCP then
        TCPReadData(pk, Status)
      else
        UDPReadData(pk, Status);
      if (Status = 0) and (Ord(PK[3]) = rdrInfo.R_Code) then
      begin
        case Ord(PK[4]) of
          $06 : result := True;
          $15 : result := False;
          else
          begin
            result := False;
            //n := MaxLoop;
          end;
        end;
      end
      else
        result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
    end;
  until (n = MaxLoop) or result;
end;

(***************** send Cut Command to station *****************)
function TCP_UDP_CutPrint(rdrInfo : TReaders ; printer_type : byte):boolean;
const
  MaxLoop = 5;
var
  ST, PK : String;
  Status, n : Byte;
  isSent: Boolean;
begin
  if printer_type in [PRN_CITIZEN3551, PRN_CITIZEN3541] then
  begin
    if printer_type = PRN_CITIZEN3551 then
      ST := #27'd0'
    else
      ST := #27'P'#0;

    n := 0;
    repeat
//      Delay(100);
      Inc(n);
      Z84_MakePocket(PK, rdrInfo.R_Code, $1C, 0, ST);
      isSent := false;
      if rdrInfo.R_TCP then
      begin
        if TCPSendData(pk, rdrInfo.R_IP) then
          isSent :=true;
      end
      else
      begin
        if UDPSendData(pk, rdrInfo.R_IP) then
          isSent :=true;
      end;
      if not isSent then
        result := False
      else
      begin
        if rdrInfo.R_TCP then
          TCPReadData(pk, Status)
        else
          UDPReadData(pk, Status);
        if (Status = 0) and (Ord(PK[3]) = rdrInfo.R_Code) then
        begin
          case Ord(PK[4]) of
            $06 : result := True;
            $15 : result := False;
            else  result := False;
          end;
        end
        else
          result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
      end;
    until (n = MaxLoop) or result;
  end
  else if printer_type = PRN_ITHACA then
  begin
    ST := #27'd' + chr(10) + #27'v';

    n := 0;
    repeat
//      Delay(100);
      Inc(n);

      Z84_MakePocket(PK, rdrInfo.R_Code, $1C, 0, ST);
      isSent := false;
      if rdrInfo.R_TCP then
      begin
        if TCPSendData(pk, rdrInfo.R_IP) then
          isSent :=true;
      end
      else
      begin
        if UDPSendData(pk, rdrInfo.R_IP) then
          isSent :=true;
      end;
      if not isSent then
        result := False
      else
      begin
        if rdrInfo.R_TCP then
          TCPReadData(pk, Status)
        else
          UDPReadData(pk, Status);
        if (Status = 0) and (Ord(PK[3]) = rdrInfo.R_Code) then
        begin
          case Ord(PK[4]) of
            $06 : result := True;
            $15 : result := False;
            else  result := False;
          end;
        end
        else
          result := ((ValidAck(PK) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
      end;
    until (n = MaxLoop) or result;
  end;
end;

(***************** send beep to station Buzzer *****************)
function  TCP_UDP_SendBeep(rdrInfo : TReaders; count : Char) : Boolean;
var
  PK : String;
  i, getVal : Byte;
  OK : Boolean;
  isSent: Boolean;
begin
  OK := True;
  begin
    Z84_MakePocket(PK, rdrInfo.R_Code, $4B, 0, count);
    isSent := false;
    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        isSent :=true;
    end;
    if not isSent then
      OK := OK AND False
    else
    begin
      if rdrInfo.R_TCP then
        TCPReadData(pk, getVal)
      else
        UDPReadData(pk, getVal);
      if (getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = rdrInfo.R_Code) then
        OK := OK AND True
      else
        OK := OK AND False;
    end;
  end;
  Result := OK;
end;

function TCP_UDP_SetOnlyCards(rdrInfo : TReaders; ST : ansistring) : boolean;
var
  S, PK : String;
  getVal : Byte;
begin
  Result := false;
  S := Str_PBCD(ST, Length(ST));
  Z84_MakePocket(PK, rdrInfo.R_Code, $3D, 0, S);

  if rdrInfo.R_TCP then
  begin
    if not TCPSendData(pk, rdrInfo.R_IP) then Exit;
  end
  else
    if not UDPSendData(pk, rdrInfo.R_IP) then Exit;

  if rdrInfo.R_TCP then
    TCPReadData(pk, getVal)
  else
    UDPReadData(pk, getVal);

  Result := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
end;

function TCP_UDP_GetOnlyCards(rdrInfo : TReaders; var ST : ansistring) : boolean;
var
  S, PK : String;
  getVal : Byte;
  Ok : boolean;
begin
  ST := '';
  repeat
    Z84_MakePocket(PK, rdrInfo.R_Code, $3D, 0, '');

    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        TCPReadData(pk, getVal)
      else
      OK := False
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        UDPReadData(pk, getVal)
      else
      OK := False
    end;
     OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $3E) and (Ord(PK[3]) = rdrInfo.R_Code));
    ST := ST + PBCD2Str(copy(PK,6,length(pk)-7));
  until (not ok) or (pos('FFFFFFFF',ST) <> 0);
  Result := OK;
end;

function TCP_UDP_SetAuthority(rdrInfo : TReaders; ST : ansistring) : boolean;
var
  S, PK : String;
  getVal : Byte;
begin
  Result := false;
  S := Str_PBCD(ST, Length(ST));
  Z84_MakePocket(PK, rdrInfo.R_Code, $4C, 0, S);

  if rdrInfo.R_TCP then
  begin
    if not TCPSendData(pk, rdrInfo.R_IP) then Exit;
  end
  else
    if not UDPSendData(pk, rdrInfo.R_IP) then Exit;

  if rdrInfo.R_TCP then
    TCPReadData(pk, getVal)
  else
    UDPReadData(pk, getVal);

  Result := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = rdrInfo.R_Code));
end;

function TCP_UDP_GetAuthority(rdrInfo : TReaders; var ST : ansistring) : boolean;
var
  S, PK : String;
  getVal : Byte;
  Ok : boolean;
begin
  ST := '';
  repeat
    Z84_MakePocket(PK, rdrInfo.R_Code, $4C, 0, '');

    if rdrInfo.R_TCP then
    begin
      if TCPSendData(pk, rdrInfo.R_IP) then
        TCPReadData(pk, getVal)
      else
      OK := False
    end
    else
    begin
      if UDPSendData(pk, rdrInfo.R_IP) then
        UDPReadData(pk, getVal)
      else
      OK := False
    end;
     OK := ((getVal = ERR_NONE) and (Ord(PK[4]) = $4D) and (Ord(PK[3]) = rdrInfo.R_Code));
    ST := ST + PBCD2Str(copy(PK,6,length(pk)-7));
  until (not ok) or (pos('FFFFFFFF',ST) <> 0);
  Result := OK;
end;
(***************************** Events *****************************)
procedure TfrmTcpUdp.tcpDataWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  recievdData := True;
end;

procedure TfrmTcpUdp.FormCreate(Sender: TObject);
begin
  tcpData.ConnectTimeout := 1000;
end;

end.
