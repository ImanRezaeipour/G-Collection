object frmPrsAmarRpt: TfrmPrsAmarRpt
  Left = 139
  Top = 20
  HelpContext = 305
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585#1610' '#1601#1610#1588#1607#1575#1610' '#1662#1585#1587#1606#1604
  ClientHeight = 417
  ClientWidth = 374
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
  object Label2: TLabel
    Left = 161
    Top = 114
    Width = 21
    Height = 15
    Caption = '&'#1576#1582#1588
  end
  object Label3: TLabel
    Left = 307
    Top = 80
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
    FocusControl = txtPCode
  end
  object Label4: TLabel
    Left = 315
    Top = 112
    Width = 53
    Height = 15
    Caption = #1606#1575#1605' '#1582#1575#1606'&'#1608#1575#1583#1711#1610
    FocusControl = txtFamily
  end
  object Label5: TLabel
    Left = 358
    Top = 144
    Width = 10
    Height = 15
    Caption = #1606'&'#1575#1605
    FocusControl = txtName
  end
  object Label6: TLabel
    Left = 151
    Top = 80
    Width = 31
    Height = 15
    Caption = #1575'&'#1587#1578#1582#1583#1575#1605
    FocusControl = cmbJobs
  end
  object Label8: TLabel
    Left = 150
    Top = 148
    Width = 35
    Height = 15
    Caption = #1587#1575#1582#1578#1605#1575#1606
    FocusControl = cmbBuilding
  end
  object Label9: TLabel
    Left = 155
    Top = 180
    Width = 30
    Height = 15
    Caption = #1578#1585#1605#1610#1606#1575#1604
    FocusControl = cmbTerminal
  end
  object Label10: TLabel
    Left = 322
    Top = 179
    Width = 49
    Height = 15
    Caption = #1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    FocusControl = cmbreserve7
  end
  object grp2: TGroupBox
    Left = 8
    Top = 32
    Width = 361
    Height = 38
    TabOrder = 18
    object Label11: TLabel
      Left = 305
      Top = 11
      Width = 21
      Height = 15
      Caption = #1587#1575#1604':'
    end
    object Label12: TLabel
      Left = 142
      Top = 11
      Width = 28
      Height = 15
      Caption = #1576#1585#1580' : '
    end
    object cmbYear: TComboBox
      Left = 241
      Top = 7
      Width = 57
      Height = 23
      ItemHeight = 15
      TabOrder = 0
      Text = '1387'
      Items.Strings = (
        #13'1380'
        '1381'
        '1382'
        '1383'
        '1384'#10
        '1385'
        '1386'
        '1387'
        '1388'
        '1389'
        '1390'
        '1391'
        '1392'
        '1393'
        '1394'
        '1395'
        '1396'
        '1397'
        '1398'
        '1399')
    end
    object cmbMonth: TComboBox
      Left = 75
      Top = 7
      Width = 63
      Height = 23
      ItemHeight = 15
      TabOrder = 1
      Text = '01'
      Items.Strings = (
        '01'
        '02'
        '03'
        '04'
        '05'
        '06'
        '07'
        '08'
        '09'
        '10'
        '11'
        '12')
    end
  end
  object grp1: TGroupBox
    Left = 8
    Top = 32
    Width = 361
    Height = 38
    TabOrder = 17
    object Label1: TLabel
      Left = 323
      Top = 11
      Width = 35
      Height = 15
      Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
      FocusControl = txtFromDate
    end
    object Label7: TLabel
      Left = 142
      Top = 11
      Width = 32
      Height = 15
      Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
      FocusControl = txtToDate
    end
    object txtFromDate: TEdit
      Left = 191
      Top = 8
      Width = 105
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtFromDateExit
      OnKeyPress = txtFromDateKeyPress
    end
    object txtToDate: TEdit
      Left = 40
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
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 315
    Width = 363
    Height = 56
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 7
    object rdoScreen: TRadioButton
      Left = 264
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
      Left = 192
      Top = 24
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
      OnKeyPress = rdoScreenKeyPress
    end
    object chkSign: TCheckBox
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = chkSignKeyPress
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 379
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 10
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 136
    Top = 379
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 9
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 264
    Top = 379
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 8
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
  object txtPCode: TEdit
    Left = 199
    Top = 80
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnKeyPress = txtPCodeKeyPress
  end
  object txtFamily: TEdit
    Left = 199
    Top = 112
    Width = 105
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 1
    OnKeyPress = txtFamilyKeyPress
  end
  object txtName: TEdit
    Left = 199
    Top = 144
    Width = 105
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtNameKeyPress
  end
  object rdoSort: TRadioGroup
    Left = 166
    Top = 208
    Width = 107
    Height = 99
    BiDiMode = bdRightToLeft
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607' &'#1662#1585#1587#1606#1604#1610
      #1606#1575#1605' '#1582#1575#1606#1608#1575'&'#1583#1711#1610)
    ParentBiDiMode = False
    TabOrder = 5
  end
  object cmbJobs: TComboBox
    Left = 8
    Top = 80
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 3
    OnKeyDown = cmbJobsKeyDown
  end
  object rdoPerson: TRadioGroup
    Left = 280
    Top = 208
    Width = 91
    Height = 99
    Caption = #1606#1608#1593' '#1575#1601#1585#1575#1583
    ItemIndex = 0
    Items.Strings = (
      '&'#1603#1604#1610#1607' '#1575#1601#1585#1575#1583
      #1662#1585#1587#1606#1604' &'#1593#1575#1583#1610
      #1662#1585#1587#1606#1604' '#1585'&'#1688#1610#1605#1610
      #1605'&'#1610#1607#1605#1575#1606#1575#1606)
    TabOrder = 4
  end
  object grpTafkik: TGroupBox
    Left = 8
    Top = 208
    Width = 152
    Height = 99
    Caption = #1578#1601#1603#1610#1603' '#1711#1586#1575#1585#1588
    TabOrder = 6
    object chkPart: TCheckBox
      Left = 12
      Top = 31
      Width = 130
      Height = 17
      Caption = #1576#1585' '#1575#1587#1575#1587' '#1576#1582#1588
      TabOrder = 0
      OnKeyPress = chkPartKeyPress
    end
    object chkJob: TCheckBox
      Left = 8
      Top = 69
      Width = 137
      Height = 17
      Caption = #1576#1585' '#1575#1587#1575#1587' '#1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
      TabOrder = 1
    end
  end
  object cmbBuilding: TComboBox
    Left = 8
    Top = 144
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 11
    OnKeyPress = cmbPartKeyPress
  end
  object cmbTerminal: TComboBox
    Left = 8
    Top = 176
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 13
    OnKeyPress = cmbPartKeyPress
  end
  object txtParts: TEdit
    Left = 8
    Top = 109
    Width = 137
    Height = 23
    MaxLength = 15
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 14
  end
  object BitBtn1: TBitBtn
    Left = 9
    Top = 111
    Width = 19
    Height = 19
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
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
    Left = 199
    Top = 176
    Width = 117
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 12
  end
  object chkYaraneh: TCheckBox
    Left = 12
    Top = 8
    Width = 353
    Height = 17
    Caption = #1711#1586#1575#1585#1588' '#1589#1608#1585#1578#1581#1587#1575#1576' '#1610#1575#1585#1575#1606#1607' '#1594#1584#1575#1610' '#1605#1589#1585#1601#1610
    TabOrder = 16
    OnClick = chkYaranehClick
    OnKeyPress = chkSignKeyPress
  end
end
