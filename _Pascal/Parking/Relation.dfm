object frmRelations: TfrmRelations
  Left = 14
  Top = 32
  BiDiMode = bdRightToLeft
  Caption = #1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 336
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object grdRdrs: TStringGrid
    Left = 0
    Top = 0
    Width = 609
    Height = 257
    ColCount = 4
    FixedCols = 0
    TabOrder = 0
    OnDblClick = grdRdrsDblClick
    OnKeyPress = cmbMsgKeyPress
    ColWidths = (
      64
      64
      68
      64)
  end
  object grpSendGetDT: TGroupBox
    Left = 16
    Top = 63
    Width = 553
    Height = 58
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1578#1575#1585#1610#1582
    TabOrder = 1
    Visible = False
    object lblDate: TLabel
      Left = 316
      Top = 24
      Width = 22
      Height = 15
      Caption = '&'#1578#1575#1585#1610#1582
      FocusControl = txtDate
    end
    object lblTime: TLabel
      Left = 171
      Top = 24
      Width = 21
      Height = 15
      Caption = '&'#1586#1605#1575#1606
    end
    object txtDate: TEdit
      Left = 199
      Top = 24
      Width = 106
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtDateKeyPress
    end
    object cmbDT: TComboBox
      Left = 400
      Top = 24
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnKeyPress = cmbDoorOpKeyPress
    end
    object txtTime: TEdit
      Left = 96
      Top = 24
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtTimeKeyPress
    end
  end
  object grpLimit: TGroupBox
    Left = 16
    Top = 78
    Width = 553
    Height = 57
    Caption = #1575#1585#1587#1575#1604' '#1605#1581#1583#1608#1583#1607' '#1586#1605#1575#1606#1610
    TabOrder = 2
    Visible = False
    object lbl1: TLabel
      Left = 421
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object lbl2: TLabel
      Left = 356
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl4: TLabel
      Left = 210
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl3: TLabel
      Left = 272
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object lbl6: TLabel
      Left = 67
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl5: TLabel
      Left = 128
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object txtFromT1: TEdit
      Left = 368
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtFromT1Exit
      OnKeyPress = txtFromT1KeyPress
    end
    object txtToT1: TEdit
      Left = 304
      Top = 24
      Width = 48
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtToT1Exit
      OnKeyPress = txtToT1KeyPress
    end
    object txtToT2: TEdit
      Left = 160
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
      OnExit = txtToT2Exit
      OnKeyPress = txtToT2KeyPress
    end
    object txtFromT2: TEdit
      Left = 224
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = txtFromT2Exit
      OnKeyPress = txtFromT2KeyPress
    end
    object txtToT3: TEdit
      Left = 16
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 6
      OnExit = txtToT3Exit
      OnKeyPress = txtToT3KeyPress
    end
    object txtFromT3: TEdit
      Left = 80
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 5
      OnExit = txtFromT3Exit
      OnKeyPress = txtFromT3KeyPress
    end
    object cmbLimit: TComboBox
      Left = 440
      Top = 24
      Width = 105
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnKeyPress = cmbLimitKeyPress
    end
  end
  object grpCardMsg: TGroupBox
    Left = 16
    Top = 95
    Width = 553
    Height = 90
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1662#1610#1575#1605' '#1575#1601#1585#1575#1583
    TabOrder = 3
    Visible = False
    object lblCardMsg: TLabel
      Left = 225
      Top = 32
      Width = 13
      Height = 15
      Caption = '&'#1662#1610#1575#1605
    end
    object lblCardCode: TLabel
      Left = 369
      Top = 32
      Width = 52
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      FocusControl = txtCardCode
    end
    object txtCardCode: TEdit
      Left = 272
      Top = 32
      Width = 89
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtCardCodeKeyPress
    end
    object cmbMsg: TComboBox
      Left = 440
      Top = 32
      Width = 105
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnClick = cmbMsgClick
      OnKeyPress = cmbMsgKeyPress
    end
    object grdMsg: TStringGrid
      Left = 32
      Top = 8
      Width = 185
      Height = 81
      ColCount = 1
      DefaultColWidth = 150
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
      TabOrder = 2
      OnKeyPress = grdMsgKeyPress
    end
  end
  object grpBtns: TGroupBox
    Left = 0
    Top = 296
    Width = 609
    Height = 42
    TabOrder = 7
    object cmdTic: TBitBtn
      Left = 504
      Top = 12
      Width = 97
      Height = 25
      Caption = #1575'&'#1606#1578#1582#1575#1576
      TabOrder = 0
      OnClick = cmdTicClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cmdExit: TBitBtn
      Left = 5
      Top = 12
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 4
      Kind = bkClose
    end
    object cmdRun: TBitBtn
      Left = 302
      Top = 12
      Width = 97
      Height = 25
      TabOrder = 2
      OnClick = cmdRunClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000333300
        0000377777F3337777770FFFF099990FFFF07FFFF7FFFF7FFFF7000000999900
        00007777777777777777307703399330770337FF7F37F337FF7F300003399330
        000337777337F337777333333339933333333FFFFFF7F33FFFFF000000399300
        0000777777F7F37777770FFFF099990FFFF07FFFF7F7FF7FFFF7000000999900
        00007777777777777777307703399330770337FF7F37F337FF7F300003399330
        0003377773F7FFF77773333330000003333333333777777F3333333330FFFF03
        3333333337FFFF7F333333333000000333333333377777733333333333077033
        33333333337FF7F3333333333300003333333333337777333333}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 104
      Top = 12
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 3
      Kind = bkHelp
    end
    object cmdInvert: TBitBtn
      Left = 405
      Top = 12
      Width = 97
      Height = 25
      Caption = '&'#1605#1593#1603#1608#1587
      TabOrder = 1
      OnClick = cmdInvertClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cmdCalc: TBitBtn
      Left = 228
      Top = 12
      Width = 72
      Height = 25
      Caption = #1605#1581#1575#1587#1576#1607
      TabOrder = 5
      Visible = False
      OnClick = cmdCalcClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
    end
  end
  object grpMsg: TGroupBox
    Left = 16
    Top = 111
    Width = 553
    Height = 90
    Caption = #1575#1585#1587#1575#1604' '#1662#1610#1575#1605' '#1576#1585' '#1585#1608#1610' '#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
    TabOrder = 8
    Visible = False
    object lbl10: TLabel
      Left = 225
      Top = 32
      Width = 13
      Height = 15
      Caption = '&'#1662#1610#1575#1605
    end
    object grdRdrMsg: TStringGrid
      Left = 32
      Top = 8
      Width = 185
      Height = 81
      ColCount = 1
      DefaultColWidth = 150
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
      TabOrder = 0
      OnKeyPress = grdRdrMsgKeyPress
    end
  end
  object grpDoor: TGroupBox
    Left = 16
    Top = 128
    Width = 553
    Height = 57
    Caption = #1603#1606#1578#1585#1604' '#1576#1575#1586' '#1608' '#1576#1587#1578#1607' '#1606#1605#1608#1583#1606' '#1583#1585
    TabOrder = 4
    Visible = False
    object lblDoorTime: TLabel
      Left = 200
      Top = 24
      Width = 126
      Height = 15
      Caption = '&'#1605#1583#1578' '#1586#1605#1575#1606' '#1576#1575#1586' '#1576#1608#1583#1606' '#1583#1585' / '#1579#1575#1606#1610#1607
      FocusControl = txtDoorTime
    end
    object txtDoorTime: TEdit
      Left = 112
      Top = 24
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtCardCodeKeyPress
    end
    object cmbDoorOp: TComboBox
      Left = 360
      Top = 24
      Width = 185
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnClick = cmbDoorOpClick
      OnKeyPress = cmbDoorOpKeyPress
    end
  end
  object grpRecovery: TGroupBox
    Left = 16
    Top = 148
    Width = 553
    Height = 85
    Caption = #1576#1575#1586#1610#1575#1576#1610' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1587#1575#1593#1578
    TabOrder = 5
    Visible = False
    object lblRecovery: TLabel
      Left = 242
      Top = 27
      Width = 35
      Height = 15
      Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
      FocusControl = txtRecoveryFDate
    end
    object lbl7: TLabel
      Left = 481
      Top = 27
      Width = 49
      Height = 15
      Caption = '&'#1606#1608#1593' '#1576#1575#1586#1610#1575#1576#1610
      FocusControl = cmbRecovery
    end
    object lbl8: TLabel
      Left = 97
      Top = 27
      Width = 32
      Height = 15
      Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
      FocusControl = txtRecoveryTDate
    end
    object Label12: TLabel
      Left = 481
      Top = 56
      Width = 59
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      Visible = False
    end
    object Label7: TLabel
      Left = 242
      Top = 56
      Width = 70
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610'-'#1606#1575#1605
      Visible = False
    end
    object txtRecoveryFDate: TEdit
      Left = 138
      Top = 24
      Width = 96
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtRecoveryFDateExit
      OnKeyPress = txtRecoveryFDateKeyPress
    end
    object cmbRecovery: TComboBox
      Left = 333
      Top = 24
      Width = 140
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnChange = cmbRecoveryChange
      OnKeyPress = cmbDoorOpKeyPress
    end
    object txtRecoveryTDate: TEdit
      Left = 9
      Top = 24
      Width = 83
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtRecoveryTDateExit
      OnKeyPress = txtRecoveryFDateKeyPress
    end
    object cmbRecoveryCode: TComboBox
      Left = 332
      Top = 53
      Width = 141
      Height = 23
      ItemHeight = 15
      TabOrder = 3
      Visible = False
      OnChange = cmbRecoveryCodeChange
    end
    object cmbRecoveryName: TComboBox
      Left = 9
      Top = 53
      Width = 225
      Height = 23
      ItemHeight = 15
      TabOrder = 4
      Visible = False
      OnChange = cmbRecoveryNameChange
    end
  end
  object grpAuthority: TGroupBox
    Left = 16
    Top = 167
    Width = 553
    Height = 78
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1604#1610#1587#1578' '#1575#1601#1585#1575#1583' '#1605#1580#1575#1586' '#1576#1607' '#1578#1585#1583#1583
    TabOrder = 9
    Visible = False
    DesignSize = (
      553
      78)
    object Label2: TLabel
      Left = 112
      Top = 54
      Width = 426
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 
        #1578#1608#1580#1607' : '#1604#1610#1587#1578' '#1575#1601#1585#1575#1583' '#1605#1580#1575#1586' '#1576#1607' '#1578#1585#1583#1583' '#1588#1575#1605#1604' '#1575#1601#1585#1575#1583#1610' '#1575#1587#1578' '#1705#1607' '#1583#1585' '#1602#1587#1605#1578' '#1605#1593#1585#1601#1610' ' +
        #1662#1585#1587#1606#1604' '#1583#1585' '#1581#1575#1604#1578' '#1601#1593#1575#1604' '#1607#1587#1578#1606#1583'.'
    end
    object Label3: TLabel
      Left = 280
      Top = 25
      Width = 133
      Height = 15
      Caption = #1606#1608#1593' '#1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1576#1585#1575#1587#1575#1587' :'
    end
    object cmbOperate: TComboBox
      Left = 424
      Top = 22
      Width = 113
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 0
    end
    object rdoProxi: TRadioButton
      Left = 183
      Top = 24
      Width = 89
      Height = 17
      Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rdoBarcode: TRadioButton
      Left = 85
      Top = 24
      Width = 89
      Height = 17
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      TabOrder = 2
    end
  end
  object grpView: TGroupBox
    Left = 16
    Top = 148
    Width = 553
    Height = 57
    Caption = #1580#1605#1593' '#1570#1608#1585#1610' '#1583#1575#1574#1605#1610' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1587#1575#1593#1578
    TabOrder = 6
    Visible = False
    object lbl9: TLabel
      Left = 485
      Top = 24
      Width = 49
      Height = 15
      Caption = #1606'&'#1581#1608#1607' '#1606#1605#1575#1610#1588
    end
    object cmbView: TComboBox
      Left = 296
      Top = 24
      Width = 177
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      OnKeyPress = cmbDoorOpKeyPress
    end
    object chkPermanent: TCheckBox
      Left = 9
      Top = 27
      Width = 105
      Height = 17
      Caption = #1580#1605#1593' '#1570#1608#1585#1610' '#1605#1608'&'#1602#1578
      TabOrder = 0
      OnKeyPress = cmbDoorOpKeyPress
    end
    object chkViewFromDb: TCheckBox
      Left = 136
      Top = 27
      Width = 129
      Height = 17
      Caption = #1606#1605#1575#1610#1588' '#1575#1586' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578#1610
      TabOrder = 2
      OnClick = chkViewFromDbClick
      OnKeyPress = cmbDoorOpKeyPress
    end
  end
  object grpFingerPrg: TGroupBox
    Left = 16
    Top = 207
    Width = 553
    Height = 77
    Caption = #1575#1606#1578#1602#1575#1604' '#1575#1579#1585' '#1575#1606#1711#1588#1578' '
    TabOrder = 10
    Visible = False
    object Label1: TLabel
      Left = 417
      Top = 24
      Width = 109
      Height = 15
      Caption = #1605#1583#1604' '#1583#1587#1578#1711#1575#1607' '#1575#1579#1585' '#1575#1606#1711#1588#1578' : '
    end
    object rdoType1: TRadioButton
      Left = 320
      Top = 24
      Width = 82
      Height = 17
      Caption = #1606#1608#1593' '#1575#1608#1604' '
      TabOrder = 0
    end
    object rdoType2: TRadioButton
      Left = 193
      Top = 24
      Width = 113
      Height = 17
      Caption = #1606#1608#1593' '#1583#1608#1605
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rdoType3: TRadioButton
      Left = 311
      Top = 52
      Width = 91
      Height = 17
      Caption = #1575#1580#1585#1575#1610' '#1576#1585#1606#1575#1605#1607' :'
      TabOrder = 2
    end
    object txtPath: TEdit
      Left = 43
      Top = 48
      Width = 262
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
    end
    object cmdPath: TButton
      Left = 11
      Top = 48
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 4
      OnClick = cmdPathClick
    end
    object txtTimeOut: TEdit
      Left = 190
      Top = 19
      Width = 54
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 5
    end
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 32
    Top = 48
  end
  object adoQryPersons: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'Select  p_proxi,p_Barcode from persons order by p_proxi')
    Left = 232
    Top = 56
  end
  object opnFile: TOpenDialog
    Left = 88
    Top = 255
  end
  object MainMenu1: TMainMenu
    Left = 408
    Top = 256
    object N8: TMenuItem
      Caption = #1605#1593#1585#1601#1610' '#1583#1587#1578#1711#1575#1607#1607#1575
      OnClick = N8Click
    end
    object N1: TMenuItem
      Caption = #1593#1605#1604#1610#1575#1578
      object mnuLinkTest: TMenuItem
        Caption = #1578#1587#1578' '#1575#1585#1578#1576#1575#1591
        OnClick = mnuLinkTestClick
      end
      object mnuReadVersion: TMenuItem
        Caption = #1582#1608#1575#1606#1583#1606' '#1606#1587#1582#1607
        OnClick = mnuReadVersionClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuDateTime: TMenuItem
        Caption = #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606
        OnClick = mnuDateTimeClick
      end
      object mnuChngBaud: TMenuItem
        Caption = #1578#1594#1610#1610#1585' '#1587#1585#1593#1578
        OnClick = mnuChngBaudClick
      end
      object mnuChangeAddr: TMenuItem
        Caption = #1578#1594#1610#1610#1585' '#1570#1583#1585#1587
        OnClick = mnuChangeAddrClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnuRestart: TMenuItem
        Caption = #1585#1575#1607' '#1575#1606#1583#1575#1586#1610' '#1583#1587#1578#1711#1575#1607#1607#1575
        OnClick = mnuRestartClick
      end
      object mnuInitial: TMenuItem
        Caption = #1662#1610#1705#1585#1576#1606#1583#1610' '#1583#1587#1578#1711#1575#1607#1607#1575
        OnClick = mnuInitialClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mnuMsg: TMenuItem
        Caption = #1662#1610#1575#1605' '#1585#1608#1610' '#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
        OnClick = mnuMsgClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object mnuCollect: TMenuItem
        Caption = #1580#1605#1593' '#1570#1608#1585#1610' '#1575#1591#1604#1575#1593#1575#1578
        OnClick = mnuCollectClick
      end
      object mnuRercovery: TMenuItem
        Caption = #1576#1575#1586#1610#1575#1576#1610' '#1575#1591#1604#1575#1593#1575#1578
        OnClick = mnuRercoveryClick
      end
    end
  end
end
