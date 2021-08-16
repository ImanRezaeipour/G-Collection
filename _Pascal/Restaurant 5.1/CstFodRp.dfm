object frmCostUsedFoodRpt: TfrmCostUsedFoodRpt
  Left = 113
  Top = 19
  HelpContext = 307
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1607#1586#1610#1606#1607' '#1662#1585#1587#1606#1604#1610' '#1608' '#1662#1610#1605#1575#1606#1603#1575#1585#1610' '#1605#1608#1575#1583' '#1594#1584#1575#1610#1610
  ClientHeight = 402
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 371
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label3: TLabel
    Left = 347
    Top = 40
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
    FocusControl = txtPCode
  end
  object lblPFamily: TLabel
    Left = 163
    Top = 40
    Width = 53
    Height = 15
    Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575'&'#1583#1711#1610
    FocusControl = txtFamily
  end
  object Label7: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label2: TLabel
    Left = 385
    Top = 72
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object Label4: TLabel
    Left = 163
    Top = 72
    Width = 51
    Height = 15
    Caption = #1606#1608#1593' '#1575'&'#1587#1578#1582#1583#1575#1605
    FocusControl = cmbJob
  end
  object Label10: TLabel
    Left = 349
    Top = 104
    Width = 49
    Height = 15
    Caption = #1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    FocusControl = cmbreserve7
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 309
    Width = 97
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 13
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
    Top = 341
    Width = 97
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 14
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 373
    Width = 97
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 15
    Kind = bkClose
  end
  object grpPrintType: TGroupBox
    Left = 112
    Top = 301
    Width = 145
    Height = 97
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 12
    object rdoScreen: TRadioButton
      Left = 48
      Top = 16
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
      OnKeyPress = txtFamilyKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 88
      Top = 40
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
      OnKeyPress = txtFamilyKeyPress
    end
    object chkSign: TCheckBox
      Left = 24
      Top = 72
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = txtFamilyKeyPress
    end
  end
  object txtFromDate: TEdit
    Left = 264
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
  object grpType: TGroupBox
    Left = 8
    Top = 125
    Width = 401
    Height = 41
    Caption = #1608#1593#1583#1607' '#1594#1584#1575#1610#1610
    TabOrder = 6
    object chkSham: TCheckBox
      Left = 16
      Top = 16
      Width = 41
      Height = 17
      Caption = #1588#1575'&'#1605
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnKeyPress = txtFamilyKeyPress
    end
    object chkNahar: TCheckBox
      Left = 184
      Top = 16
      Width = 49
      Height = 17
      Caption = #1606#1575#1607#1575'&'#1585
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnKeyPress = txtFamilyKeyPress
    end
    object chkSobh: TCheckBox
      Left = 328
      Top = 16
      Width = 57
      Height = 17
      Caption = #1589#1576'&'#1581#1575#1606#1607
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnKeyPress = txtFamilyKeyPress
    end
  end
  object txtPCode: TEdit
    Left = 224
    Top = 40
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtPCodeKeyPress
  end
  object txtFamily: TEdit
    Left = 8
    Top = 40
    Width = 145
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtFamilyKeyPress
  end
  object rdoRptType: TRadioGroup
    Left = 216
    Top = 173
    Width = 81
    Height = 121
    BiDiMode = bdRightToLeft
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ItemIndex = 0
    Items.Strings = (
      #1605#1588#1585#1608#1581
      #1582#1604#1575#1589#1607)
    ParentBiDiMode = False
    TabOrder = 8
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
  object grpTafkik: TGroupBox
    Left = 112
    Top = 173
    Width = 97
    Height = 121
    Caption = #1578#1601#1603#1610#1603' '#1576#1585' '#1575#1587#1575#1587
    TabOrder = 9
    object chkPart: TCheckBox
      Left = 40
      Top = 32
      Width = 49
      Height = 17
      Caption = #1576#1582#1588
      TabOrder = 0
      OnKeyPress = txtFamilyKeyPress
    end
    object chkJob: TCheckBox
      Left = 8
      Top = 80
      Width = 81
      Height = 17
      Caption = #1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
      TabOrder = 1
      OnKeyPress = txtFamilyKeyPress
    end
  end
  object cmbJob: TComboBox
    Left = 8
    Top = 72
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 4
    OnKeyDown = cmbJobKeyDown
    OnKeyPress = txtFamilyKeyPress
  end
  object rdoPrice: TRadioGroup
    Left = 264
    Top = 301
    Width = 145
    Height = 97
    ItemIndex = 0
    Items.Strings = (
      #1603#1604#1610#1607' '#1575#1601#1585#1575#1583
      #1575#1601#1585#1575#1583' '#1576#1575' '#1575#1582#1584' '#1608#1580#1607
      #1575#1601#1585#1575#1583' '#1576#1583#1608#1606' '#1575#1582#1584' '#1608#1580#1607)
    TabOrder = 11
  end
  object grpPerson: TGroupBox
    Left = 304
    Top = 173
    Width = 105
    Height = 121
    Caption = #1606#1608#1593' '#1575#1601#1585#1575#1583
    TabOrder = 7
    object chkAll: TCheckBox
      Left = 8
      Top = 24
      Width = 89
      Height = 17
      Caption = #1603#1604#1610#1607' '#1575#1601#1585#1575#1583
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkAllClick
    end
    object chkNorm: TCheckBox
      Left = 8
      Top = 48
      Width = 89
      Height = 17
      Caption = #1662#1585#1587#1606#1604' '#1593#1575#1583#1610
      TabOrder = 1
      OnClick = chkNormClick
    end
    object chkRejim: TCheckBox
      Left = 8
      Top = 72
      Width = 89
      Height = 17
      Caption = #1662#1585#1587#1606#1604' '#1585#1688#1610#1605#1610
      TabOrder = 2
      OnClick = chkNormClick
    end
    object chkGuest: TCheckBox
      Left = 8
      Top = 96
      Width = 89
      Height = 17
      Caption = #1605#1610#1607#1605#1575#1606#1575#1606
      TabOrder = 3
      OnClick = chkNormClick
    end
  end
  object rdoSort: TRadioGroup
    Left = 8
    Top = 173
    Width = 97
    Height = 121
    Caption = #1576#1607' '#1578#1585#1578#1610#1576
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610)
    TabOrder = 10
  end
  object txtParts: TEdit
    Left = 220
    Top = 69
    Width = 157
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 16
  end
  object BitBtn2: TBitBtn
    Left = 222
    Top = 71
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    OnClick = BitBtn2Click
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
    Left = 220
    Top = 100
    Width = 122
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 5
  end
end
