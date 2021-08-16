unit TCP_UDP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, OleCtrls, Sockets,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  ScktComp, IdTCPConnection, IdTCPClient, IdCmdTCPClient;

type
  TfrmTcpUdp = class(TForm)
    udpData: TIdUDPClient;
    tcpData: TIdTCPClient;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    recievdData  : boolean;
    Function  Switch_Tcp(ip : String) : Boolean;
    function  TCPSendData(pkt, ip : String) : Boolean;
    procedure TCPReadData(var pkt: String; var retVal : Byte);

    Function Switch_Udp(ip : String) : Boolean;
    function  UDPSendData(pkt, ip : String) : Boolean;
    procedure UDPReadData(var pkt: String; var retVal : Byte);
  end;
var
  frmTcpUdp: TfrmTcpUdp;

const
  ERR_NONE     = 1;
  ERR_TIMEOUT  = 2;
  ERR_CHEKSUM  = 3;
  ERR_STX      = 4;
  ERR_ETX      = 5;
  ERR_OFF      = 6;
  MB_BUFFEMPTY = 7;
  MB_TRUEREC   = 8;
  MB_BADREC    = 9;
  MB_BADDATA   = 10;

implementation

uses
  Funcs, DateProc, IdIOHandler,msgs;


{$R *.dfm}



(*******************************************************************************
                                  TCP Connection
*******************************************************************************)
Function TfrmTcpUdp.Switch_Tcp(ip : String) : Boolean;
var
  i : Integer;
begin
  if tcpData.Connected and (tcpData.Host = ip) then
  begin
    result := true;
    exit;
  end;
  result := false;
//  try
    i := 1;
    while tcpData.Connected and (i <= 500) do
    begin
      tcpData.IOHandler.InputBufferAsString;
      tcpData.Disconnect;
      inc(i);
    end;
    tcpData.Host := ip;
    tcpData.Connect;
    if tcpData.Connected then
      result := true;
//  except
//    result := false;
//  end;
end;

{ Send data to tcp protocol }
function TfrmTcpUdp.TCPSendData(pkt, ip : String) : Boolean;
begin
  if switch_Tcp(ip) then
  begin
    tcpData.IOHandler.Write(pkt);
    Result := True;
  end
  else
    Result := False;
end;

{ Read dsata from TCP protocol}
procedure TfrmTcpUdp.TCPReadData(var pkt: String; var retVal : Byte);
var
  i : Integer;
  l, checkSum : Byte;
  ss : char;
begin
  Sleep(150);
  pkt := '';
  retVal := ERR_NONE;

  if tcpData.Connected then
  begin
    try
      i := 0;
      repeat
        ss := tcpData.IOHandler.ReadChar;
        pkt := pkt + ss;
        inc(i);
      until  tcpData.IOHandler.InputBufferIsEmpty or (i = 500);
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
  if retVal = ERR_NONE then
    tcpData.Disconnect;
end;


(*******************************************************************************
                                  UDP Connection
*******************************************************************************)
Function TfrmTcpUdp.Switch_Udp(ip : String) : Boolean;
begin
  if udpData.Active then
    udpData.Active := False;
  udpData.Host := ip;
  udpData.Active := True;
  Result := udpData.Active;
end;
{ Send data to UDP protocol }
function TfrmTcpUdp.UDPSendData(pkt, ip : String) : Boolean;
//var
 //  bff : array of byte;
//  i : Integer;
begin
{  for i := 1 to Length(pkt) do
  begin
    bff[i] := ord(pkt[i]);
    bff[i+1] := 0;
  end;
}
  if Switch_Udp(IP) then
    try
  //    frmTcpUdp.udpData.SendBuffer(bff, Length(pkt));   //delphi6,7
      udpData.Send(pkt);
      Result := True;
    except
      Result := False;
    end;
end;


{ Read dsata from UDP protocol}
procedure TfrmTcpUdp.UDPReadData(var pkt: String; var retVal : Byte);
var
  i, l : Integer;
  checkSum : Byte;
//  bff : array[1..10] of char;
begin
//  Sleep(150);
  pkt := '';
  retVal := ERR_NONE;
  pkt := udpData.ReceiveString(1500);
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


(***************************** Events *****************************)
procedure TfrmTcpUdp.FormCreate(Sender: TObject);
begin
//  tcpData.ConnectTimeout := 1000;
end;

end.
