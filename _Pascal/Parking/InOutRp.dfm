object frmInOutRpt: TfrmInOutRpt
  Left = 169
  Top = 105
  HelpContext = 501
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 482
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    374
    482)
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel
    Left = 323
    Top = 11
    Width = 43
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' &'#1578#1575#1585#1610#1582' :'
    FocusControl = txtFromDate
  end
  object Label3: TLabel
    Left = 326
    Top = 40
    Width = 40
    Height = 15
    Anchors = [akTop, akRight]
    BiDiMode = bdRightToLeft
    Caption = #1578#1575' '#1578'&'#1575#1585#1610#1582' :'
    FocusControl = txtToDate
    ParentBiDiMode = False
  end
  object Label4: TLabel
    Left = 306
    Top = 69
    Width = 60
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588'&'#1605#1575#1585#1607' '#1705#1575#1585#1578' :'
    FocusControl = cmbBarCode
  end
  object Label5: TLabel
    Left = 121
    Top = 69
    Width = 66
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575'&'#1585#1607' '#1582#1608#1583#1585#1608' :'
    FocusControl = txtNumber
  end
  object Label6: TLabel
    Left = 128
    Top = 114
    Width = 59
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1588#1607#1585' '#1582#1608#1583#1585#1608' :'
    Enabled = False
    FocusControl = cmbCity
    Visible = False
  end
  object Label7: TLabel
    Left = 120
    Top = 98
    Width = 67
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1587#1585#1610#1575#1604' '#1582#1608#1583#1585#1608' :'
    FocusControl = txtSerial
  end
  object Label9: TLabel
    Left = 313
    Top = 127
    Width = 53
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1583#1585#1576' '#1608#1585#1608#1583' :'
    FocusControl = cmbIDoor
  end
  object Label10: TLabel
    Left = 122
    Top = 127
    Width = 65
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1578#1589#1583'&'#1610' '#1608#1585#1608#1583' :'
    FocusControl = cmbIPerson
  end
  object Label13: TLabel
    Left = 140
    Top = 11
    Width = 47
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' &'#1587#1575#1593#1578' :'
    FocusControl = txtFromTime
  end
  object Label14: TLabel
    Left = 143
    Top = 40
    Width = 44
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1587#1575'&'#1593#1578' :'
    FocusControl = txtToTime
  end
  object Label11: TLabel
    Left = 118
    Top = 212
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1605#1578#1589#1583#1610' '#1582#1585#1608#1580' :'
    FocusControl = cmbOPerson
  end
  object Label8: TLabel
    Left = 309
    Top = 212
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1583#1585'&'#1576' '#1582#1585#1608#1580' :'
    FocusControl = cmbODoor
  end
  object Label1: TLabel
    Left = 313
    Top = 98
    Width = 53
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1581#1604' '#1608#1585#1608#1583' :'
    FocusControl = cmbEntranceDepartment
  end
  object rdoDoorAndOr: TRadioGroup
    Left = 208
    Top = 170
    Width = 158
    Height = 36
    Hint = #1575#1585#1578#1576#1575#1591' '#1605#1610#1575#1606' '#1583#1585#1576' '#1608#1585#1608#1583' '#1608' '#1583#1585#1576' '#1582#1585#1608#1580' ( '#1608' / '#1610#1575' )'
    Anchors = [akTop, akRight]
    Columns = 2
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      #1608
      #1610#1575)
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
  end
  object rdoPersonAndOr: TRadioGroup
    Left = 8
    Top = 170
    Width = 163
    Height = 36
    Hint = #1575#1585#1578#1576#1575#1591' '#1605#1610#1575#1606' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1608#1585#1608#1583' '#1608' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580' ( '#1608' / '#1610#1575' )'
    Anchors = [akTop, akRight]
    Columns = 2
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      #1608
      #1610#1575)
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
  end
  object txtFromDate: TEdit
    Left = 194
    Top = 8
    Width = 106
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 194
    Top = 37
    Width = 106
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtNumber: TEdit
    Left = 8
    Top = 66
    Width = 106
    Height = 23
    Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnKeyPress = txtNumberKeyPress
  end
  object txtSerial: TEdit
    Left = 8
    Top = 95
    Width = 106
    Height = 23
    Hint = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnKeyPress = txtSerialKeyPress
  end
  object cmbBarCode: TComboBox
    Left = 194
    Top = 66
    Width = 106
    Height = 23
    Hint = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnEnter = cmbBarCodeEnter
    OnKeyPress = cmbBarCodeKeyPress
  end
  object cmbCity: TComboBox
    Left = 16
    Top = 111
    Width = 106
    Height = 23
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 6
    Visible = False
    OnEnter = cmbBarCodeEnter
    OnKeyPress = cmbCityKeyPress
  end
  object txtFromTime: TEdit
    Left = 8
    Top = 8
    Width = 106
    Height = 23
    Hint = #1587#1575#1593#1578' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 6
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnExit = txtFromTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object txtToTime: TEdit
    Left = 8
    Top = 37
    Width = 106
    Height = 23
    Hint = #1587#1575#1593#1578' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 6
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnExit = txtToTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object cmdClose: TBitBtn
    Left = 3
    Top = 452
    Width = 103
    Height = 22
    Hint = #1582#1585#1608#1580
    Anchors = [akRight, akBottom]
    Caption = '&'#1582#1585#1608#1580
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    Kind = bkClose
    ExplicitTop = 402
  end
  object cmdPrint: TBitBtn
    Left = 3
    Top = 395
    Width = 103
    Height = 22
    Hint = #1662#1610#1588' '#1606#1605#1575#1610#1588' '#1711#1586#1575#1585#1588
    Anchors = [akRight, akBottom]
    Caption = '&'#1711#1586#1575#1585#1588
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
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
    ExplicitTop = 345
  end
  object cmdHelp: TBitBtn
    Left = 3
    Top = 423
    Width = 103
    Height = 23
    Hint = #1585#1575#1607#1606#1605#1575
    Anchors = [akRight, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    Kind = bkHelp
    ExplicitTop = 373
  end
  object cmbIDoor: TComboBox
    Left = 194
    Top = 124
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1583#1587#1578#1711#1575#1607' '#1608#1585#1608#1583' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = cmbIDoorClick
  end
  object grpPrintType: TGroupBox
    Left = 76
    Top = 263
    Width = 95
    Height = 126
    Hint = 
      #1576#1610#1606' '#1606#1605#1575#1610#1588' '#1583#1585' '#1605#1575#1606#1610#1578#1608#1585' '#1608' '#1610#1575' '#1670#1575#1662' '#1605#1587#1578#1602#1610#1605' '#1583#1585' '#1670#1575#1662#1711#1585#1548' '#1610#1705#1610' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575 +
      #1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = grpPrintTypeClick
    ExplicitTop = 213
    object rdoScreen: TRadioButton
      Left = 4
      Top = 33
      Width = 79
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabStop = True
      OnClick = grpPrintTypeClick
    end
    object rdoPrinter: TRadioButton
      Left = 39
      Top = 89
      Width = 44
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = grpPrintTypeClick
    end
  end
  object grpType: TGroupBox
    Left = 177
    Top = 263
    Width = 189
    Height = 126
    Hint = #1606#1608#1593' '#1711#1586#1575#1585#1588' '#1605#1608#1585#1583' '#1606#1592#1585' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    ExplicitTop = 213
    DesignSize = (
      189
      126)
    object rdoBoth: TRadioButton
      Left = 2
      Top = 18
      Width = 182
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1711'&'#1586#1575#1585#1588' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1608#1575#1585#1583' '#1608' '#1582#1575#1585#1580' '#1588#1583#1607
      Checked = True
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TabStop = True
      OnClick = rdoBothClick
    end
    object rdoArival: TRadioButton
      Left = 2
      Top = 39
      Width = 182
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1711#1586#1575#1585#1588' '#1582'&'#1608#1583#1585#1608#1607#1575#1610' '#1608#1575#1585#1583' '#1588#1583#1607
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = rdoBothClick
    end
    object rdoExit: TRadioButton
      Left = 2
      Top = 60
      Width = 182
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1711#1586#1575#1585#1588' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1582#1575#1585'&'#1580' '#1588#1583#1607
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = rdoBothClick
    end
    object rdoParked: TRadioButton
      Left = 2
      Top = 81
      Width = 182
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1711#1586#1575#1585#1588' '#1582'&'#1608#1583#1585#1608#1607#1575#1610' '#1662#1575#1585#1603' '#1588#1583#1607
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnClick = rdoBothClick
    end
    object rdoCount: TRadioButton
      Left = 2
      Top = 102
      Width = 182
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1711#1586#1575#1585#1588' '#1578#1593#1583#1575#1583' '#1578#1585#1583#1583' '#1582#1608#1583#1585#1608#1607#1575
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      OnClick = rdoBothClick
    end
  end
  object rdoPaper: TRadioGroup
    Left = 4
    Top = 263
    Width = 66
    Height = 126
    Hint = #1606#1608#1593' '#1670#1575#1662' '#1605#1608#1585#1583' '#1606#1592#1585' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1670#1575#1662
    ItemIndex = 0
    Items.Strings = (
      #1575#1601#1602#1610
      #1593#1605#1608#1583#1610)
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    ExplicitTop = 213
  end
  object rdoSort: TRadioGroup
    Left = 112
    Top = 395
    Width = 254
    Height = 79
    Hint = #1606#1581#1608#1607' '#1605#1585#1578#1576' '#1587#1575#1586#1610' '#1711#1586#1575#1585#1588' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1583
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580
      #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      #1587#1585#1610#1575#1604' '#1662#1604#1575#1705)
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    ExplicitTop = 345
  end
  object cmdCancelFilter: TBitBtn
    Left = 177
    Top = 179
    Width = 25
    Height = 23
    Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    TabStop = False
    OnClick = cmdCancelFilterClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
  end
  object cmbIPerson: TComboBox
    Left = 8
    Top = 124
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1608#1585#1608#1583' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = cmbIPersonClick
    OnKeyPress = cmbIPersonKeyPress
  end
  object cmbOPerson: TComboBox
    Left = 8
    Top = 209
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = cmbOPersonClick
    OnKeyPress = cmbIPersonKeyPress
  end
  object cmbODoor: TComboBox
    Left = 194
    Top = 209
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1583#1587#1578#1711#1575#1607' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = cmbODoorClick
  end
  object cmbEntranceDepartment: TComboBox
    Left = 194
    Top = 95
    Width = 106
    Height = 23
    Hint = #1605#1581#1604' '#1608#1585#1608#1583' '#1585#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    OnChange = cmbEntranceDepartmentChange
  end
  object cmbEntranceDepartmentCode: TComboBox
    Left = 228
    Top = 100
    Width = 38
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
    Visible = False
  end
  object cmbIDoorName: TComboBox
    Left = 194
    Top = 149
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1583#1587#1578#1711#1575#1607' '#1608#1585#1608#1583' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    OnClick = cmbIDoorNameClick
  end
  object cmbIPersonName: TComboBox
    Left = 8
    Top = 149
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1608#1585#1608#1583' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    OnClick = cmbIPersonNameClick
    OnKeyPress = cmbIPersonKeyPress
  end
  object cmbODoorName: TComboBox
    Left = 194
    Top = 234
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1583#1587#1578#1711#1575#1607' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
    OnClick = cmbODoorNameClick
  end
  object cmbOPersonName: TComboBox
    Left = 8
    Top = 234
    Width = 106
    Height = 23
    Hint = #1705#1583' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 27
    OnClick = cmbOPersonNameClick
    OnKeyPress = cmbIPersonKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 4
  end
end
