object frmStatisticsUseRpt: TfrmStatisticsUseRpt
  Left = 124
  Top = 102
  HelpContext = 306
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586' '#1585#1587#1578#1608#1585#1575#1606#1607#1575
  ClientHeight = 201
  ClientWidth = 319
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
    Left = 276
    Top = 11
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label2: TLabel
    Left = 111
    Top = 11
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label9: TLabel
    Left = 429
    Top = 40
    Width = 30
    Height = 15
    Caption = #1578#1585#1605#1610#1606#1575#1604
    FocusControl = cmbTerminal
    Visible = False
  end
  object Label10: TLabel
    Left = 429
    Top = 72
    Width = 49
    Height = 15
    Caption = #1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    FocusControl = cmbreserve7
    Visible = False
  end
  object Label8: TLabel
    Left = 226
    Top = 48
    Width = 85
    Height = 15
    Caption = #1587#1575#1582#1578#1605#1575#1606' ('#1585#1587#1578#1608#1585#1575#1606')'
    FocusControl = cmbBuilding
  end
  object Label3: TLabel
    Left = 501
    Top = 6
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
    Visible = False
  end
  object Label6: TLabel
    Left = 501
    Top = 40
    Width = 31
    Height = 15
    Caption = #1575'&'#1587#1578#1582#1583#1575#1605
    FocusControl = cmbJobs
    Visible = False
  end
  object grpPrintType: TGroupBox
    Left = 182
    Top = 78
    Width = 129
    Height = 113
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 3
    object rdoScreen: TRadioButton
      Left = 32
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 72
      Top = 56
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
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
    Top = 168
    Width = 160
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 124
    Width = 160
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 82
    Width = 160
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
  object txtFromDate: TEdit
    Left = 173
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
    Left = 312
    Top = 102
    Width = 225
    Height = 113
    TabOrder = 7
    Visible = False
    object chkNahar: TCheckBox
      Left = 136
      Top = 48
      Width = 81
      Height = 17
      Caption = #1606'&'#1575#1607#1575#1585' / '#1588#1575#1605
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkSobh: TCheckBox
      Left = 160
      Top = 16
      Width = 57
      Height = 17
      Caption = #1589#1576'&'#1581#1575#1606#1607
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkMokhalafat: TCheckBox
      Left = 160
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
      Width = 129
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      OnKeyDown = cmbSobhKeyDown
    end
    object cmbNahar: TComboBox
      Left = 8
      Top = 48
      Width = 129
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 3
      OnKeyDown = cmbNaharKeyDown
    end
    object cmbMokhalafat: TComboBox
      Left = 8
      Top = 80
      Width = 129
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 5
      OnKeyDown = cmbMokhalafatKeyDown
    end
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
    OnKeyPress = txtToDateKeyPress
  end
  object chkMokhPrice: TCheckBox
    Left = 368
    Top = 222
    Width = 169
    Height = 17
    Caption = #1605'&'#1581#1575#1587#1576#1607' '#1602#1610#1605#1578' '#1575#1582#1584' '#1588#1583#1607' '#1605#1582#1604#1601#1575#1578' '
    TabOrder = 8
    Visible = False
    OnKeyPress = chkMokhPriceKeyPress
  end
  object rdoGroup: TRadioGroup
    Left = 352
    Top = 238
    Width = 185
    Height = 105
    Caption = #1606#1608#1593' '#1578#1601#1603#1610#1603
    ItemIndex = 0
    Items.Strings = (
      #1576#1607' '#1578#1601#1603#1610#1603' '#1662#1585#1587#1606#1604' '#1608' '#1605#1610#1607#1605#1575#1606
      #1576#1607' '#1578#1601#1705#1610#1705' '#1608#1593#1583#1607
      #1576#1607' '#1578#1601#1705#1610#1705' ('#1593#1575#1583#1610' '#1585#1688#1610#1605#1610')'
      #1576#1583#1608#1606' '#1578#1601#1603#1610#1603)
    TabOrder = 9
    Visible = False
  end
  object cmbTerminal: TComboBox
    Left = 286
    Top = 37
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 10
    Visible = False
    OnKeyDown = cmbTerminalKeyDown
  end
  object cmbreserve7: TComboBox
    Left = 286
    Top = 69
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 11
    Visible = False
    OnKeyDown = cmbreserve7KeyDown
  end
  object cmbBuilding: TComboBox
    Left = 8
    Top = 45
    Width = 212
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
    OnKeyDown = cmbBuildingKeyDown
    OnKeyPress = cmbBuildingKeyPress
  end
  object txtParts: TEdit
    Left = 357
    Top = 3
    Width = 137
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 12
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 360
    Top = 5
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Visible = False
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
  object cmbJobs: TComboBox
    Left = 357
    Top = 37
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 14
    Visible = False
    OnKeyDown = cmbJobsKeyDown
  end
end
