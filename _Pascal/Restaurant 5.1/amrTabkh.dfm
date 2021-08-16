object frmAmarTabkh: TfrmAmarTabkh
  Left = 222
  Top = 161
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1662#1610#1588' '#1576#1610#1606#1610' '#1570#1605#1575#1585' '#1591#1576#1582' '#1594#1584#1575
  ClientHeight = 354
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 347
    Top = 75
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 121
    Top = 75
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label10: TLabel
    Left = 331
    Top = 46
    Width = 49
    Height = 15
    Caption = #1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    FocusControl = cmbreserve7
  end
  object Label8: TLabel
    Left = 156
    Top = 46
    Width = 35
    Height = 15
    Caption = #1587#1575#1582#1578#1605#1575#1606
    FocusControl = cmbBuilding
  end
  object Label2: TLabel
    Left = 367
    Top = 15
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object Label6: TLabel
    Left = 157
    Top = 13
    Width = 31
    Height = 15
    Caption = #1575'&'#1587#1578#1582#1583#1575#1605
    FocusControl = cmbJobs
  end
  object grpPrintType: TGroupBox
    Left = 121
    Top = 243
    Width = 136
    Height = 104
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 9
    object rdoScreen: TRadioButton
      Left = 32
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 72
      Top = 47
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 80
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 260
    Width = 98
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 10
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
    Left = 8
    Top = 291
    Width = 98
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 11
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 322
    Width = 99
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 12
    Kind = bkClose
  end
  object txtFromDate: TEdit
    Left = 227
    Top = 71
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 5
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 14
    Top = 71
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 6
    OnExit = txtToDateExit
    OnKeyPress = txtToDateKeyPress
  end
  object grptafkik: TGroupBox
    Left = 8
    Top = 112
    Width = 378
    Height = 125
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 7
    object rdovadeh: TRadioButton
      Left = 280
      Top = 20
      Width = 89
      Height = 17
      Caption = #1570#1605#1575#1585' '#1575#1601#1585#1575#1583' '#1605#1580#1575#1586
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdofood: TRadioButton
      Left = 91
      Top = 20
      Width = 116
      Height = 17
      Caption = #1570#1605#1575#1585' '#1585#1586#1585#1608' ('#1582#1604#1575#1589#1607' )'
      TabOrder = 1
    end
    object rdofoods: TRadioButton
      Left = 246
      Top = 56
      Width = 123
      Height = 17
      Caption = #1570#1605#1575#1585' '#1585#1586#1585#1608' ('#1605#1588#1585#1608#1581' )'
      TabOrder = 2
    end
    object rdofoodsnoeat: TRadioButton
      Left = 11
      Top = 56
      Width = 196
      Height = 17
      Caption = #1570#1605#1575#1585' '#1585#1586#1585#1608' ('#1605#1588#1585#1608#1581' ) '#1594#1584#1575' '#1606#1582#1608#1585#1583#1607
      TabOrder = 3
    end
    object rdofoodprice: TRadioButton
      Left = 213
      Top = 92
      Width = 156
      Height = 17
      Caption = #1570#1605#1575#1585' '#1585#1586#1585#1608' ('#1605#1588#1585#1608#1581' ) '#1585#1610#1575#1604#1610
      TabOrder = 4
    end
    object rdofoodpricenoeat: TRadioButton
      Left = 3
      Top = 92
      Width = 204
      Height = 17
      Caption = #1570#1605#1575#1585' '#1585#1586#1585#1608' ('#1605#1588#1585#1608#1581' ) '#1594#1584#1575' '#1606#1582#1608#1585#1583#1607' '#1585#1610#1575#1604#1610
      TabOrder = 5
    end
  end
  object cmbparts: TBitBtn
    Left = 202
    Top = 13
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = cmbpartsClick
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
  object txtParts: TEdit
    Left = 221
    Top = 12
    Width = 137
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 0
  end
  object cmbJobs: TComboBox
    Left = 14
    Top = 13
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
  end
  object cmbBuilding: TComboBox
    Left = 14
    Top = 42
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 4
  end
  object cmbreserve7: TComboBox
    Left = 202
    Top = 42
    Width = 122
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 3
  end
  object rdoSort: TRadioGroup
    Left = 280
    Top = 253
    Width = 106
    Height = 91
    Caption = #1576#1607' '#1578#1585#1578#1610#1576
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610)
    TabOrder = 8
  end
  object Table1: TADOTable
    TableName = 'AmarTabkh'
    Left = 179
    Top = 69
  end
end
