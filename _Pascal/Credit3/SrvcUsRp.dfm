object frmUsedServiceRpt: TfrmUsedServiceRpt
  Left = 168
  Top = 141
  HelpContext = 306
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1608' '#1607#1586#1610#1606#1607' '#1582#1583#1605#1575#1578' '#1575#1585#1575#1574#1607' '#1588#1583#1607
  ClientHeight = 265
  ClientWidth = 384
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 339
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object lbl4: TLabel
    Left = 334
    Top = 40
    Width = 40
    Height = 15
    Caption = '&'#1603#1575#1585#1578#1582#1608#1575#1606
    FocusControl = btnReaderSel
  end
  object lbl5: TLabel
    Left = 352
    Top = 72
    Width = 22
    Height = 15
    Caption = '&'#1605#1585#1603#1586
    FocusControl = cmbDepartment
  end
  object lbl6: TLabel
    Left = 344
    Top = 104
    Width = 30
    Height = 15
    Caption = #1578#1608'&'#1590#1610#1581
    FocusControl = txtDescribe
  end
  object grpPrintType: TGroupBox
    Left = 144
    Top = 184
    Width = 233
    Height = 73
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 8
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
  object cmdExit: TBitBtn
    Left = 8
    Top = 232
    Width = 129
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 11
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 200
    Width = 129
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 10
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 168
    Width = 129
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 9
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
    Left = 232
    Top = 8
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
    Left = 8
    Top = 8
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object chkDate: TCheckBox
    Left = 8
    Top = 136
    Width = 97
    Height = 17
    Caption = #1576#1607' '#1578#1601#1603#1610#1603' '#1578#1575#1585#1610#1582
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cmbReaders: TComboBox
    Left = 144
    Top = 40
    Width = 185
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
    OnKeyDown = cmbReadersKeyDown
  end
  object btnReaderSel: TBitBtn
    Left = 8
    Top = 40
    Width = 129
    Height = 25
    Caption = #1575#1606#1578#1582#1575#1576' '#1603#1575#1585#1578#1582#1608#1575#1606
    TabOrder = 3
    OnClick = btnReaderSelClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      003337777777777777F330FFFFFFFFFFF03337F333FFFFF337F330FFF70007FF
      F03337F33777773F37F330FF08FFF80FF03337F373333373F7F330F78FFFFF87
      F03337F7F3333337F7F330F0FFFFFFF0F03337F7F333FFF7F7F330F0FFF900F0
      F03337F7F3377737F7F330F0FFF0FFF0F03337F7F337F337F7F330F78FF0FF87
      F03337F73F37F33737F330FF08F0F80FF03337F373F7FF7337F330FFF70007FF
      F03337F33777773FF7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
      F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
      333337FFFFFFFF77333330000000000333333777777777733333}
    NumGlyphs = 2
  end
  object cmbDepartment: TComboBox
    Left = 144
    Top = 72
    Width = 185
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 4
    OnKeyDown = cmbDepartmentKeyDown
  end
  object btnDepartment: TBitBtn
    Left = 8
    Top = 72
    Width = 129
    Height = 25
    Caption = #1575#1606#1578#1582#1575#1576' '#1605#1585#1603#1586
    TabOrder = 5
    OnClick = btnDepartmentClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555777555
      5555555555000757755555575500005007555570058880000075570870088078
      007555787887087777755550880FF0800007708080888F7088077088F0708F78
      88077000F0778080005555508F0008800755557878FF88777075570870080088
      0755557075888070755555575500075555555555557775555555}
  end
  object txtDescribe: TEdit
    Left = 8
    Top = 104
    Width = 321
    Height = 23
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 144
    Top = 132
    Width = 232
    Height = 49
    Caption = #1576#1607' '#1578#1601#1705#1610#1705
    TabOrder = 12
    object rdodept: TRadioButton
      Left = 128
      Top = 24
      Width = 89
      Height = 17
      Caption = #1605#1585#1705#1586
      TabOrder = 0
    end
    object rdoreader: TRadioButton
      Left = 24
      Top = 24
      Width = 49
      Height = 17
      Caption = #1583#1587#1578#1711#1575#1607
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 176
  end
end
