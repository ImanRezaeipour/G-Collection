object frmOnline: TfrmOnline
  Left = 0
  Top = 0
  Align = alRight
  BorderStyle = bsNone
  Caption = 'frmOnline'
  ClientHeight = 171
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 40
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object tmrRdr: TTimer
    Interval = 50
    OnTimer = tmrRdrTimer
    Left = 40
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 96
    Top = 8
  end
  object tmrSetRdrTimeDate: TTimer
    Enabled = False
    Interval = 21600000
    OnTimer = tmrSetRdrTimeDateTimer
    Left = 40
    Top = 72
  end
end
