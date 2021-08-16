object frmTcpUdp: TfrmTcpUdp
  Left = 467
  Top = 297
  Caption = 'frmTcpUdp'
  ClientHeight = 96
  ClientWidth = 189
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object udpData: TIdUDPClient
    BufferSize = 255
    Port = 1001
    Left = 152
    Top = 8
  end
  object tcpData: TIdTCPClient
    OnWork = tcpDataWork
    ConnectTimeout = 200
    Host = '192.168.2.88'
    IPVersion = Id_IPv4
    Port = 1001
    ReadTimeout = 2000
    Left = 80
    Top = 8
  end
end
