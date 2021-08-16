object frmSpecialRpt: TfrmSpecialRpt
  Left = 163
  Top = 92
  HelpContext = 505
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1604#1610#1587#1578' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1608#1610#1688#1607
  ClientHeight = 139
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpReportType: TGroupBox
    Left = 113
    Top = 7
    Width = 142
    Height = 93
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 0
    object rdoNotExit: TRadioButton
      Left = 7
      Top = 21
      Width = 128
      Height = 15
      Caption = #1582#1608#1583#1585#1608#1607#1575#1610' &'#1605#1605#1606#1608#1593' '#1575#1604#1582#1585#1608#1580
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoMotavari: TRadioButton
      Left = 35
      Top = 42
      Width = 100
      Height = 15
      Caption = #1582#1608#1583#1585#1608#1607#1575#1610' '#1605'&'#1578#1608#1575#1585#1610
      TabOrder = 1
    end
    object rdoTakhfif: TRadioButton
      Left = 7
      Top = 64
      Width = 128
      Height = 15
      Caption = #1582#1608#1583#1585#1608#1607#1575#1610' '#1605#1588#1605#1608#1604' '#1578#1582'&'#1601#1610#1601
      TabOrder = 2
    end
  end
  object grpPrintType: TGroupBox
    Left = 7
    Top = 7
    Width = 100
    Height = 93
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 1
    object rdoScreen: TRadioButton
      Left = 14
      Top = 28
      Width = 79
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 49
      Top = 64
      Width = 44
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object cmdPrint: TBitBtn
    Left = 176
    Top = 113
    Width = 81
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 2
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
  object cmdExit: TBitBtn
    Left = 7
    Top = 113
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 4
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 92
    Top = 113
    Width = 78
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 3
    Kind = bkHelp
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 8
  end
end
