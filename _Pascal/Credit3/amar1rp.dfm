object frmamar1rp: Tfrmamar1rp
  Left = 118
  Top = 80
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1583#1585#1570#1605#1583' '#1587#1575#1604#1606' '#1607#1575
  ClientHeight = 256
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 347
    Top = 16
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 126
    Top = 16
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label1: TLabel
    Left = 122
    Top = 56
    Width = 36
    Height = 15
    Caption = #1578#1575' '#1587#1575#1593#1578
    FocusControl = txtfromtime
  end
  object Label2: TLabel
    Left = 343
    Top = 56
    Width = 39
    Height = 15
    Caption = #1575#1586' '#1587#1575#1593#1578
    FocusControl = txttotime
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 222
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 7
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 149
    Top = 223
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 6
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 285
    Top = 223
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 5
    OnClick = cmdPrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000CE0E0000D80E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      88888800000000000888808888888880808800000000000008080888888BBB88
      0008088888877788080800000000000008800888888888808080800000000008
      0800880FFFFFFFF080808880F00000F000088880FFFFFFFF088888880F00000F
      088888880FFFFFFFF08888888000000000888888888888888888}
  end
  object txtFromDate: TEdit
    Left = 240
    Top = 16
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 16
    Top = 16
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object grpPrintType: TGroupBox
    Left = 149
    Top = 128
    Width = 233
    Height = 73
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 4
    object rdoScreen: TRadioButton
      Left = 128
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 168
      Top = 48
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 40
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object txtfromtime: TEdit
    Left = 264
    Top = 53
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtfromtimeKeyPress
  end
  object txttotime: TEdit
    Left = 40
    Top = 53
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtfromtimeKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 200
    Top = 9
  end
end
