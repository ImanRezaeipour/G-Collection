object frmDiffRpt: TfrmDiffRpt
  Left = 175
  Top = 111
  HelpContext = 506
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1604#1610#1587#1578' '#1605#1594#1575#1610#1585#1578' '#1570#1605#1575#1585#1711#1585
  ClientHeight = 91
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
  object grpPrintType: TGroupBox
    Left = 99
    Top = 0
    Width = 114
    Height = 86
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 0
    object rdoScreen: TRadioButton
      Left = 28
      Top = 28
      Width = 79
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 64
      Top = 56
      Width = 43
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object cmdPrint: TBitBtn
    Left = 7
    Top = 7
    Width = 80
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 1
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
  object cmdHelp: TBitBtn
    Left = 7
    Top = 35
    Width = 79
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 2
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 7
    Top = 64
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkClose
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 88
    Top = 24
  end
end
