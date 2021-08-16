object frmGetPriceRpt: TfrmGetPriceRpt
  Left = 159
  Top = 72
  HelpContext = 502
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1583#1585#1570#1605#1583' '#1662#1575#1585#1603#1610#1606#1711
  ClientHeight = 469
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
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
    311
    469)
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 260
    Top = 11
    Width = 43
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' '#1578#1575#1585#1610#1582' :'
  end
  object lbl3: TLabel
    Left = 263
    Top = 40
    Width = 40
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1578#1575#1585#1610#1582' :'
    FocusControl = txtToDate
  end
  object lbl5: TLabel
    Left = 246
    Top = 69
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1583#1585#1576' '#1582#1585#1608#1580' :'
    FocusControl = cmbDoorCode
  end
  object lbl2: TLabel
    Left = 67
    Top = 11
    Width = 47
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' '#1587#1575#1593#1578' :'
  end
  object lbl4: TLabel
    Left = 70
    Top = 40
    Width = 44
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1587#1575#1593#1578' :'
    FocusControl = txtToTime
  end
  object lbl6: TLabel
    Left = 234
    Top = 98
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1578#1589#1583#1610' '#1582#1585#1608#1580' :'
    FocusControl = cmbPersonCode
  end
  object Label1: TLabel
    Left = 246
    Top = 127
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1606#1608#1593' '#1582#1608#1583#1585#1608' :'
    FocusControl = cmbTypeCode
  end
  object Label5: TLabel
    Left = 237
    Top = 156
    Width = 66
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    FocusControl = txtNumber
  end
  object Label7: TLabel
    Left = 80
    Top = 156
    Width = 34
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1587#1585#1610#1575#1604' :'
    FocusControl = txtSerial
  end
  object Label2: TLabel
    Left = 265
    Top = 187
    Width = 38
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' '#1605#1576#1604#1594' :'
  end
  object Label3: TLabel
    Left = 115
    Top = 187
    Width = 35
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1605#1576#1604#1594' :'
    FocusControl = txtToPrice
  end
  object Label4: TLabel
    Left = 238
    Top = 216
    Width = 65
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1583#1578' '#1578#1608#1602#1601' '#1575#1586' :'
  end
  object Label6: TLabel
    Left = 122
    Top = 216
    Width = 14
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' :'
  end
  object txtFromDate: TEdit
    Left = 120
    Top = 8
    Width = 107
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
    Left = 120
    Top = 37
    Width = 107
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
  object cmbDoorCode: TComboBox
    Left = 120
    Top = 66
    Width = 107
    Height = 23
    Hint = #1705#1583' '#1583#1587#1578#1711#1575#1607' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = cmbDoorCodeClick
  end
  object cmbDoorName: TComboBox
    Left = 8
    Top = 66
    Width = 107
    Height = 23
    Hint = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = cmbDoorNameClick
  end
  object grpReportType: TGroupBox
    Left = 158
    Top = 240
    Width = 145
    Height = 79
    Hint = #1606#1608#1593' '#1711#1586#1575#1585#1588' '#1605#1608#1585#1583' '#1606#1592#1585' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = grpReportTypeClick
    object rdoAll: TRadioButton
      Left = 6
      Top = 21
      Width = 131
      Height = 15
      Caption = #1711#1586#1575#1585#1588' &'#1603#1604#1610
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = grpReportTypeClick
    end
    object rdoTafsili: TRadioButton
      Left = 6
      Top = 49
      Width = 131
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1578#1601#1589#1610'&'#1604#1610
      TabOrder = 1
      OnClick = grpReportTypeClick
    end
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 325
    Width = 144
    Height = 108
    Hint = 
      #1576#1610#1606' '#1606#1605#1575#1610#1588' '#1583#1585' '#1605#1575#1606#1610#1578#1608#1585' '#1608' '#1610#1575' '#1670#1575#1662' '#1605#1587#1578#1602#1610#1605' '#1583#1585' '#1670#1575#1662#1711#1585#1548' '#1610#1705#1610' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575 +
      #1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    OnClick = grpPrintTypeClick
    object rdoScreen: TRadioButton
      Left = 6
      Top = 31
      Width = 127
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = grpPrintTypeClick
    end
    object rdoPrinter: TRadioButton
      Left = 6
      Top = 67
      Width = 127
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
      OnClick = grpPrintTypeClick
    end
  end
  object cmdPrint: TBitBtn
    Left = 208
    Top = 439
    Width = 95
    Height = 22
    Hint = #1662#1610#1588' '#1606#1605#1575#1610#1588' '#1711#1586#1575#1585#1588
    Anchors = [akRight, akBottom]
    Caption = '&'#1711#1586#1575#1585#1588
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
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
  object cmdExit: TBitBtn
    Left = 8
    Top = 439
    Width = 94
    Height = 22
    Hint = #1582#1585#1608#1580
    Anchors = [akRight, akBottom]
    Caption = '&'#1582#1585#1608#1580
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 108
    Top = 439
    Width = 94
    Height = 22
    Hint = #1585#1575#1607#1606#1605#1575
    Anchors = [akRight, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    Kind = bkHelp
  end
  object txtFromTime: TEdit
    Left = 8
    Top = 8
    Width = 53
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
    Width = 53
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
  object cmbPersonCode: TComboBox
    Left = 121
    Top = 95
    Width = 107
    Height = 23
    Hint = #1705#1583' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = cmbPersonCodeClick
  end
  object cmbPersonName: TComboBox
    Left = 8
    Top = 95
    Width = 107
    Height = 23
    Hint = #1606#1575#1605' '#1605#1578#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = cmbPersonNameClick
  end
  object grpTafkik: TGroupBox
    Left = 158
    Top = 325
    Width = 145
    Height = 108
    Hint = #1606#1581#1608#1607' '#1578#1601#1705#1610#1705' '#1711#1586#1575#1585#1588' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1578#1601#1603#1610#1603' '#1576#1585' '#1575#1587#1575#1587
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    object rdoDoor: TRadioButton
      Left = 6
      Top = 42
      Width = 131
      Height = 15
      Caption = #1583'&'#1585#1576' '#1582#1585#1608#1580
      TabOrder = 1
    end
    object rdoPerson: TRadioButton
      Left = 6
      Top = 21
      Width = 131
      Height = 15
      Caption = #1605#1578'&'#1589#1583#1610' '#1583#1585#1576' '#1582#1585#1608#1580
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoNone: TRadioButton
      Left = 6
      Top = 84
      Width = 131
      Height = 15
      Caption = #1576#1583#1608#1606' '#1578'&'#1601#1603#1610#1603' ('#1583#1585#1570#1605#1583' '#1603#1604#1610')'#8207
      TabOrder = 2
    end
    object rdoType: TRadioButton
      Left = 6
      Top = 63
      Width = 131
      Height = 15
      Caption = #1606#1608'&'#1593' '#1582#1608#1583#1585#1608
      TabOrder = 3
    end
  end
  object rdoSort: TRadioGroup
    Left = 8
    Top = 240
    Width = 144
    Height = 79
    Hint = #1606#1581#1608#1607' '#1605#1585#1578#1576' '#1587#1575#1586#1610' '#1711#1586#1575#1585#1588' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1585#1583
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580)
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object cmbTypeCode: TComboBox
    Left = 121
    Top = 124
    Width = 107
    Height = 23
    Hint = #1705#1583' '#1606#1608#1593' '#1582#1608#1583#1585#1608' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = cmbTypeCodeClick
  end
  object cmbTypeName: TComboBox
    Left = 8
    Top = 124
    Width = 107
    Height = 23
    Hint = #1606#1575#1605' '#1606#1608#1593' '#1582#1608#1583#1585#1608' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = cmbTypeNameClick
  end
  object txtNumber: TEdit
    Left = 120
    Top = 153
    Width = 107
    Height = 23
    Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnKeyPress = txtNumberKeyPress
  end
  object txtSerial: TEdit
    Left = 8
    Top = 153
    Width = 53
    Height = 23
    Hint = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnKeyPress = txtSerialKeyPress
  end
  object txtFromPrice: TEdit
    Left = 157
    Top = 182
    Width = 70
    Height = 23
    Hint = #1581#1583#1575#1602#1604' '#1605#1576#1604#1594' '#1583#1585#1610#1575#1601#1578#1610' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdRightToLeft
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnKeyPress = txtFromPriceKeyPress
  end
  object txtToPrice: TEdit
    Left = 39
    Top = 182
    Width = 70
    Height = 23
    Hint = #1581#1583#1575#1705#1579#1585' '#1605#1576#1604#1594' '#1583#1585#1610#1575#1601#1578#1610' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdRightToLeft
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnKeyPress = txtToPriceKeyPress
  end
  object cmdCancelFilter: TBitBtn
    Left = 8
    Top = 198
    Width = 25
    Height = 23
    Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
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
  object txtmskFromStay: TMaskEdit
    Left = 150
    Top = 211
    Width = 77
    Height = 23
    Hint = #1605#1583#1578' '#1578#1608#1602#1601' '#1585#1575' '#1576#1607' '#1588#1705#1604' ('#1583#1602#1610#1602#1607'-'#1587#1575#1593#1578'-'#1585#1608#1586') '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    BiDiMode = bdRightToLeft
    EditMask = '(999-99-99);1;_'
    MaxLength = 11
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Text = '(   -  -  )'
  end
  object txtmskToStay: TMaskEdit
    Left = 39
    Top = 211
    Width = 77
    Height = 23
    Hint = #1605#1583#1578' '#1578#1608#1602#1601' '#1585#1575' '#1576#1607' '#1588#1705#1604' ('#1583#1602#1610#1602#1607'-'#1587#1575#1593#1578'-'#1585#1608#1586') '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    BiDiMode = bdRightToLeft
    EditMask = '(999-99-99);1;_'
    MaxLength = 11
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Text = '(   -  -  )'
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Top = 336
  end
end
