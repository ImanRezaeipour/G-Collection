object frmGustCardRpt: TfrmGustCardRpt
  Left = 84
  Top = 103
  HelpContext = 302
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1604#1610#1587#1578' '#1603#1575#1585#1578#1607#1575#1610' '#1605#1610#1607#1605#1575#1606
  ClientHeight = 172
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 305
    Top = 8
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
    FocusControl = cmbBarCode
  end
  object Label2: TLabel
    Left = 311
    Top = 41
    Width = 53
    Height = 15
    Caption = '&'#1593#1606#1608#1575#1606' '#1603#1575#1585#1578
  end
  object Label4: TLabel
    Left = 343
    Top = 72
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 8
    Width = 129
    Height = 113
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 3
    object rdoScreen: TRadioButton
      Left = 40
      Top = 24
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 80
      Top = 56
      Width = 41
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1670#1575#1662#1711#1585
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = rdoScreenKeyPress
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 88
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = chkSignKeyPress
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 136
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 136
    Top = 136
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 264
    Top = 136
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 4
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
  object cmbBarCode: TComboBox
    Left = 144
    Top = 8
    Width = 145
    Height = 23
    ItemHeight = 0
    MaxLength = 8
    TabOrder = 0
    OnClick = cmbBarCodeClick
    OnKeyPress = cmbBarCodeKeyPress
  end
  object chkgrp: TCheckBox
    Left = 264
    Top = 104
    Width = 97
    Height = 17
    Alignment = taLeftJustify
    BiDiMode = bdRightToLeftNoAlign
    Caption = #1576#1607' '#1578'&'#1601#1603#1610#1603' '#1576#1582#1588#1607#1575
    Checked = True
    ParentBiDiMode = False
    State = cbChecked
    TabOrder = 2
    OnKeyPress = chkgrpKeyPress
  end
  object cmbFamily: TComboBox
    Left = 144
    Top = 40
    Width = 145
    Height = 23
    ItemHeight = 0
    TabOrder = 1
    OnClick = cmbFamilyClick
    OnKeyPress = cmbFamilyKeyPress
  end
  object txtParts: TEdit
    Left = 143
    Top = 69
    Width = 149
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 7
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 71
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
      33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
      8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
      F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
      F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
      0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
      3333333777333777333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
end
