object frmYearFdMkhRpt: TfrmYearFdMkhRpt
  Left = 123
  Top = 75
  HelpContext = 310
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1605#1589#1585#1601' '#1605#1575#1607#1575#1606#1607' '#1605#1608#1575#1583' '#1594#1584#1575#1610#1610
  ClientHeight = 174
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 245
    Top = 8
    Width = 17
    Height = 15
    Caption = '&'#1587#1575#1604
    FocusControl = cmbYear
  end
  object lbl2: TLabel
    Left = 333
    Top = 40
    Width = 25
    Height = 15
    Caption = '&'#1575#1586' '#1605#1575#1607
    FocusControl = cmbFMonth
  end
  object lbl3: TLabel
    Left = 144
    Top = 40
    Width = 22
    Height = 15
    Caption = '&'#1578#1575' '#1605#1575#1607
    FocusControl = cmbTMonth
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 80
    Width = 361
    Height = 49
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 3
    object rdoScreen: TRadioButton
      Left = 264
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 192
      Top = 24
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 144
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 136
    Top = 144
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 264
    Top = 144
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
  object cmbYear: TComboBox
    Left = 112
    Top = 8
    Width = 121
    Height = 23
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 0
    ParentBiDiMode = False
    TabOrder = 0
  end
  object cmbFMonth: TComboBox
    Left = 200
    Top = 40
    Width = 121
    Height = 23
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 0
    ParentBiDiMode = False
    TabOrder = 1
  end
  object cmbTMonth: TComboBox
    Left = 8
    Top = 40
    Width = 121
    Height = 23
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 0
    ParentBiDiMode = False
    TabOrder = 2
  end
end
