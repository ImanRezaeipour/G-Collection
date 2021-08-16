object frmKolli: TfrmKolli
  Left = 129
  Top = 106
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1589#1604#1575#1581#1575#1578' '#1603#1604#1610
  ClientHeight = 175
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object lbl1: TLabel
    Left = 336
    Top = 8
    Width = 47
    Height = 16
    Caption = '&'#1575#1586' '#1588#1605#1575#1585#1607' '
  end
  object lbl2: TLabel
    Left = 117
    Top = 8
    Width = 44
    Height = 16
    Caption = '&'#1578#1575' '#1588#1605#1575#1585#1607
  end
  object lbl3: TLabel
    Left = 391
    Top = 40
    Width = 26
    Height = 16
    Caption = '&'#1576#1582#1588
  end
  object lbl4: TLabel
    Left = 165
    Top = 40
    Width = 58
    Height = 16
    Caption = '&'#1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
  end
  object cmbFrom: TComboBox
    Left = 235
    Top = 8
    Width = 105
    Height = 24
    BiDiMode = bdLeftToRight
    ItemHeight = 0
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = cmbFromExit
    OnExit = cmbFromExit
    OnKeyPress = cmbFromKeyPress
  end
  object cmbTo: TComboBox
    Left = 12
    Top = 8
    Width = 105
    Height = 24
    BiDiMode = bdLeftToRight
    ItemHeight = 0
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 1
    OnClick = cmbToExit
    OnExit = cmbToExit
    OnKeyPress = cmbFromKeyPress
  end
  object cmbPart: TComboBox
    Left = 228
    Top = 40
    Width = 160
    Height = 24
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 2
    OnKeyPress = cmbPartKeyPress
  end
  object cmbJob: TComboBox
    Left = 3
    Top = 40
    Width = 160
    Height = 24
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 3
    OnKeyPress = cmbPartKeyPress
  end
  object chkValid: TCheckBox
    Left = 336
    Top = 80
    Width = 81
    Height = 17
    Caption = '&'#1605#1580#1575#1586' '#1576#1607' '#1578#1585#1583#1583
    TabOrder = 4
    OnKeyPress = cmbPartKeyPress
  end
  object chkTaradod: TCheckBox
    Left = 232
    Top = 80
    Width = 97
    Height = 17
    Caption = #1578'&'#1587#1578' '#1603#1606#1578#1585#1604' '#1578#1585#1583#1583
    TabOrder = 5
    OnKeyPress = cmbPartKeyPress
  end
  object chkPay: TCheckBox
    Left = 143
    Top = 80
    Width = 74
    Height = 17
    Caption = #1576#1575#1575'&'#1582#1584' '#1608#1580#1607
    TabOrder = 6
    OnKeyPress = cmbPartKeyPress
  end
  object chkOver: TCheckBox
    Left = 16
    Top = 80
    Width = 113
    Height = 17
    Caption = #1575'&'#1580#1575#1586#1607' '#1594#1584#1575#1610' '#1575#1590#1575#1601#1610
    TabOrder = 7
    OnKeyPress = cmbPartKeyPress
  end
  object chkSob: TCheckBox
    Left = 344
    Top = 112
    Width = 73
    Height = 17
    Caption = '&'#1589#1576#1581#1575#1606#1607
    TabOrder = 8
    OnKeyPress = cmbPartKeyPress
  end
  object chkNahar: TCheckBox
    Left = 264
    Top = 112
    Width = 65
    Height = 17
    Caption = '&'#1606#1575#1607#1575#1585
    TabOrder = 9
    OnKeyPress = cmbPartKeyPress
  end
  object chkSham: TCheckBox
    Left = 168
    Top = 112
    Width = 49
    Height = 17
    Caption = '&'#1588#1575#1605
    TabOrder = 10
    OnKeyPress = cmbPartKeyPress
  end
  object cmdEdit: TBitBtn
    Left = 296
    Top = 144
    Width = 100
    Height = 25
    Caption = #1575#1589'&'#1604#1575#1581
    TabOrder = 11
    OnClick = cmdEditClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 160
    Top = 144
    Width = 100
    Height = 25
    Caption = '&'#1585#1575#1607#1606#1605#1575
    TabOrder = 12
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 24
    Top = 144
    Width = 100
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 13
    Kind = bkClose
  end
end
