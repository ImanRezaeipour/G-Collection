object frmAmarPriceRpt: TfrmAmarPriceRpt
  Left = 121
  Top = 47
  HelpContext = 306
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1605#1589#1585#1601' '#1594#1584#1575#1610#1610' '#1576#1585' '#1581#1587#1576' '#1602#1610#1605#1578
  ClientHeight = 363
  ClientWidth = 399
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
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 355
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
  object lbl3: TLabel
    Left = 364
    Top = 48
    Width = 26
    Height = 15
    Caption = '&'#1662#1585#1587#1606#1604
  end
  object lbl4: TLabel
    Left = 369
    Top = 80
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object lbl5: TLabel
    Left = 155
    Top = 80
    Width = 51
    Height = 15
    Caption = #1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
  end
  object Label10: TLabel
    Left = 345
    Top = 112
    Width = 49
    Height = 15
    Caption = #1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    FocusControl = cmbreserve7
  end
  object grpPrintType: TGroupBox
    Left = 120
    Top = 255
    Width = 273
    Height = 97
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 8
    object rdoScreen: TRadioButton
      Left = 176
      Top = 32
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 216
      Top = 64
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 16
      Top = 72
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object rdoGroup: TRadioGroup
    Left = 8
    Top = 143
    Width = 129
    Height = 113
    Caption = #1606#1608#1593' '#1578#1601#1603#1610#1603
    ItemIndex = 0
    Items.Strings = (
      #1662#1585#1587#1606#1604
      #1576#1582#1588
      #1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
      #1576#1583#1608#1606' '#1578#1601#1603#1610#1603)
    TabOrder = 7
  end
  object grpType: TGroupBox
    Left = 144
    Top = 143
    Width = 249
    Height = 113
    TabOrder = 5
    object chkNahar: TCheckBox
      Left = 160
      Top = 48
      Width = 81
      Height = 17
      Caption = #1606'&'#1575#1607#1575#1585' / '#1588#1575#1605
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkSobh: TCheckBox
      Left = 184
      Top = 16
      Width = 57
      Height = 17
      Caption = #1589#1576'&'#1581#1575#1606#1607
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkMokhalafat: TCheckBox
      Left = 184
      Top = 80
      Width = 57
      Height = 17
      Caption = '&'#1605#1582#1604#1601#1575#1578
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cmbSobh: TComboBox
      Left = 8
      Top = 16
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 1
      OnKeyDown = cmbSobhKeyDown
    end
    object cmbNahar: TComboBox
      Left = 8
      Top = 48
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 3
      OnKeyDown = cmbNaharKeyDown
    end
    object cmbMokhalafat: TComboBox
      Left = 8
      Top = 80
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 5
      OnKeyDown = cmbMokhalafatKeyDown
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 327
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 11
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 295
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 10
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 263
    Width = 105
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
    Left = 248
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
  object cmbPCode: TComboBox
    Left = 216
    Top = 48
    Width = 137
    Height = 23
    BiDiMode = bdLeftToRight
    ItemHeight = 0
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = cmbPCodeClick
    OnExit = cmbPCodeExit
  end
  object cmbFamilyName: TComboBox
    Left = 8
    Top = 48
    Width = 201
    Height = 23
    ItemHeight = 0
    TabOrder = 3
    OnClick = cmbFamilyNameClick
    OnExit = cmbFamilyNameExit
  end
  object cmbJobType: TComboBox
    Left = 8
    Top = 80
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 4
    OnKeyDown = cmbJobTypeKeyDown
  end
  object txtParts: TEdit
    Left = 208
    Top = 80
    Width = 142
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 12
  end
  object BitBtn1: TBitBtn
    Left = 209
    Top = 80
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
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
  object cmbreserve7: TComboBox
    Left = 216
    Top = 110
    Width = 122
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 6
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 24
    Top = 104
  end
end
