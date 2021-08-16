object frmPersonRpt: TfrmPersonRpt
  Left = 71
  Top = 6
  HelpContext = 301
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1604#1610#1587#1578' '#1662#1585#1587#1606#1604
  ClientHeight = 405
  ClientWidth = 464
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
    Left = 401
    Top = 40
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
    FocusControl = cmbBarCode
  end
  object Label2: TLabel
    Left = 436
    Top = 9
    Width = 10
    Height = 15
    Caption = '&'#1606#1575#1605
  end
  object Label4: TLabel
    Left = 431
    Top = 80
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object Label5: TLabel
    Left = 209
    Top = 9
    Width = 53
    Height = 15
    Caption = #1606#1575#1605' '#1582#1575#1606'&'#1608#1575#1583#1711#1610
  end
  object Label3: TLabel
    Left = 209
    Top = 40
    Width = 51
    Height = 15
    Caption = #1606#1608#1593' '#1575'&'#1587#1578#1582#1583#1575#1605
    FocusControl = cmbJob
  end
  object Label6: TLabel
    Left = 215
    Top = 72
    Width = 47
    Height = 15
    Caption = #1711#1585#1608#1607' &'#1603#1575#1585#1610
  end
  object grpPrintType: TGroupBox
    Left = 120
    Top = 256
    Width = 129
    Height = 105
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 10
    object rdoScreen: TRadioButton
      Left = 42
      Top = 24
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = cmbNameKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 80
      Top = 50
      Width = 43
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = '&'#1670#1575#1662#1711#1585
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = cmbNameKeyPress
    end
    object chkSign: TCheckBox
      Left = 10
      Top = 83
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = cmbNameKeyPress
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 376
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 14
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 184
    Top = 376
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 13
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 352
    Top = 376
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 12
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
    Left = 272
    Top = 40
    Width = 113
    Height = 23
    ItemHeight = 15
    MaxLength = 8
    TabOrder = 2
    OnClick = cmbBarCodeClick
    OnKeyPress = cmbBarCodeKeyPress
  end
  object grpCndition: TGroupBox
    Left = 192
    Top = 152
    Width = 265
    Height = 97
    TabOrder = 6
    object Label7: TLabel
      Left = 200
      Top = 16
      Width = 54
      Height = 15
      Caption = '&'#1605#1580#1575#1586' '#1576#1607' '#1578#1585#1583#1583
      FocusControl = cmbIsValid
    end
    object Label8: TLabel
      Left = 186
      Top = 40
      Width = 68
      Height = 15
      Caption = '&'#1578#1587#1578' '#1603#1606#1578#1585#1604' '#1578#1585#1583#1583
    end
    object Label9: TLabel
      Left = 208
      Top = 64
      Width = 46
      Height = 15
      Caption = #1576#1575' '#1575#1582'&'#1584' '#1608#1580#1607
    end
    object cmbIsValid: TComboBox
      Left = 8
      Top = 16
      Width = 161
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnKeyPress = cmbNameKeyPress
      Items.Strings = (
        #1576#1583#1608#1606' '#1578#1587#1578
        #1576#1575#1588#1583
        #1606#1576#1575#1588#1583)
    end
    object cmbValidTest: TComboBox
      Left = 8
      Top = 40
      Width = 161
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      OnKeyPress = cmbNameKeyPress
      Items.Strings = (
        #1576#1583#1608#1606' '#1578#1587#1578
        #1583#1575#1585#1583
        #1606#1583#1575#1585#1583)
    end
    object cmbPricable: TComboBox
      Left = 8
      Top = 64
      Width = 161
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 2
      OnKeyPress = cmbNameKeyPress
      Items.Strings = (
        #1576#1583#1608#1606' '#1578#1587#1578
        #1576#1575#1575#1582#1584' '#1608#1580#1607
        #1576#1583#1608#1606' '#1575#1582#1584' '#1608#1580#1607)
    end
  end
  object cmbJob: TComboBox
    Left = 8
    Top = 40
    Width = 185
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 3
    OnKeyPress = cmbNameKeyPress
  end
  object grpSort: TGroupBox
    Left = 256
    Top = 256
    Width = 97
    Height = 105
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610
    TabOrder = 9
    object rdoBarCode: TRadioButton
      Left = 4
      Top = 32
      Width = 89
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = #1588#1605#1575#1585#1607' &'#1662#1585#1587#1606#1604#1610
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = cmbNameKeyPress
    end
    object rdoFamily: TRadioButton
      Left = 12
      Top = 72
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583'&'#1711#1610
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = cmbNameKeyPress
    end
  end
  object cmbGroups: TComboBox
    Left = 8
    Top = 72
    Width = 185
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 4
    OnKeyPress = cmbNameKeyPress
  end
  object rdoGroups: TRadioGroup
    Left = 8
    Top = 104
    Width = 449
    Height = 41
    Caption = #1606#1581#1608#1607' '#1578#1601#1603#1610#1603
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1576#1607' '#1578#1601#1603#1610#1603' '#1576#1582#1588#1607#1575
      #1576#1607' '#1578#1601#1603#1610#1603' '#1711#1585#1608#1607' '#1603#1575#1585#1610
      #1576#1583#1608#1606' '#1578#1601#1603#1610#1603)
    TabOrder = 5
  end
  object grpVadeh: TGroupBox
    Left = 8
    Top = 152
    Width = 177
    Height = 97
    TabOrder = 7
    object chkSobhaneh: TCheckBox
      Left = 48
      Top = 16
      Width = 121
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = #1605#1580#1575#1586' '#1576#1607' '#1587#1585#1608' &'#1589#1576#1581#1575#1606#1607
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = cmbNameKeyPress
    end
    object chkNahar: TCheckBox
      Left = 48
      Top = 40
      Width = 121
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = #1605#1580#1575#1586' '#1576#1607' '#1587#1585#1608' '#1606#1575'&'#1607#1575#1585
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = cmbNameKeyPress
    end
    object chkSham: TCheckBox
      Left = 56
      Top = 64
      Width = 113
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = #1605#1580#1575#1586' '#1576#1607' '#1587#1585#1608' &'#1588#1575#1605
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = cmbNameKeyPress
    end
  end
  object rdoRejim: TRadioGroup
    Left = 360
    Top = 256
    Width = 97
    Height = 105
    ItemIndex = 0
    Items.Strings = (
      #1603#1604#1610#1607' '#1662#1585#1587#1606#1604
      #1662#1585#1587#1606#1604' '#1593#1575#1583#1610
      #1662#1585#1587#1606#1604' '#1585#1688#1610#1605#1610)
    TabOrder = 8
  end
  object cmbName: TComboBox
    Left = 272
    Top = 8
    Width = 145
    Height = 23
    ItemHeight = 15
    TabOrder = 0
    OnClick = cmbNameClick
    OnKeyPress = cmbNameKeyPress
  end
  object cmbFamily: TComboBox
    Left = 8
    Top = 8
    Width = 185
    Height = 23
    ItemHeight = 15
    TabOrder = 1
    OnClick = cmbFamilyClick
    OnKeyPress = cmbNameKeyPress
  end
  object rdoPaper: TRadioGroup
    Left = 8
    Top = 256
    Width = 105
    Height = 105
    Caption = #1606#1608#1593' '#1670#1575#1662
    ItemIndex = 0
    Items.Strings = (
      #1575#1601#1602#1610
      #1593#1605#1608#1583#1610)
    TabOrder = 11
  end
  object txtParts: TEdit
    Left = 268
    Top = 75
    Width = 157
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 15
  end
  object BitBtn1: TBitBtn
    Left = 270
    Top = 77
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
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
