object frmCustoms: TfrmCustoms
  Left = 75
  Top = -18
  HelpContext = 109
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1605#1588#1578#1585#1603#1610#1606
  ClientHeight = 557
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 446
    Height = 213
    Align = alTop
    TabOrder = 0
    object dbgCustoms: TDBGrid
      Left = 99
      Top = 14
      Width = 340
      Height = 192
      DataSource = dtaCustoms
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnKeyDown = dbgCustomsKeyDown
    end
    object cmdNew: TBitBtn
      Left = 7
      Top = 14
      Width = 86
      Height = 22
      Caption = #1605#1588#1578#1585#1603' &'#1580#1583#1610#1583
      TabOrder = 1
      OnClick = cmdNewClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    object cmdEdit: TBitBtn
      Left = 7
      Top = 42
      Width = 86
      Height = 22
      Caption = #1575'&'#1589#1604#1575#1581' '#1605#1588#1578#1585#1603
      TabOrder = 2
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
    object cmdDelete: TBitBtn
      Left = 7
      Top = 71
      Width = 86
      Height = 22
      Caption = '&'#1581#1584#1601' '#1605#1588#1578#1585#1603
      TabOrder = 3
      OnClick = cmdDeleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 7
      Top = 155
      Width = 86
      Height = 22
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 5
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 7
      Top = 184
      Width = 86
      Height = 22
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 7
      Kind = bkClose
    end
    object cmdTamdid: TBitBtn
      Left = 7
      Top = 99
      Width = 86
      Height = 22
      Caption = '&'#1578#1605#1583#1610#1583' '#1575#1588#1578#1585#1575#1603
      TabOrder = 4
      OnClick = cmdTamdidClick
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
    object cmdEndCust: TBitBtn
      Left = 7
      Top = 127
      Width = 86
      Height = 22
      Caption = '&'#1602#1591#1593' '#1575#1588#1578#1585#1575#1603
      TabOrder = 6
      OnClick = cmdEndCustClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
        44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
        00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
        33833F333383F33300003333AA463362A433333333383F333833F33300003333
        6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
        33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
        6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
        000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
        333383333333F3330000333333322AAA4333333333333833333F333300003333
        333322A4333333333333338333F333330000333333344A433333333333333338
        3F333333000033333336A24333333333333333833F333333000033333336AA43
        33333333333333833F3333330000333333336663333333333333333888333333
        0000}
      NumGlyphs = 2
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 213
    Width = 446
    Height = 197
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 394
      Top = 14
      Width = 43
      Height = 15
      Caption = '&'#1603#1583' '#1575#1588#1578#1585#1575#1603
      FocusControl = txtCode
    end
    object Label2: TLabel
      Left = 270
      Top = 14
      Width = 43
      Height = 15
      Caption = '&'#1606#1575#1605' '#1605#1588#1578#1585#1603
      FocusControl = txtName
    end
    object Label3: TLabel
      Left = 252
      Top = 85
      Width = 51
      Height = 15
      Caption = #1588'&'#1607#1585' '#1582#1608#1583#1585#1608
      FocusControl = txtCarNumber
    end
    object Label4: TLabel
      Left = 82
      Top = 14
      Width = 42
      Height = 15
      Caption = '&'#1578#1604#1601#1606' '#1578#1605#1575#1587
      FocusControl = txtTel
    end
    object Label9: TLabel
      Left = 395
      Top = 56
      Width = 43
      Height = 15
      Caption = #1606#1575#1605' &'#1582#1608#1583#1585#1608
    end
    object Label10: TLabel
      Left = 86
      Top = 85
      Width = 55
      Height = 15
      Caption = #1588#1605#1575#1585#1607' &'#1587#1585#1610#1575#1604
    end
    object Label8: TLabel
      Left = 380
      Top = 85
      Width = 58
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
    end
    object Label5: TLabel
      Left = 381
      Top = 127
      Width = 56
      Height = 15
      Caption = #1578#1575'&'#1585#1610#1582' '#1575#1588#1578#1585#1575#1603
    end
    object Label11: TLabel
      Left = 218
      Top = 127
      Width = 51
      Height = 15
      Caption = '&'#1605#1576#1604#1594' '#1575#1588#1578#1585#1575#1603
    end
    object Label12: TLabel
      Left = 105
      Top = 127
      Width = 19
      Height = 15
      Caption = #1585#1610#1575#1604
    end
    object Label17: TLabel
      Left = 211
      Top = 56
      Width = 54
      Height = 15
      Caption = '&'#1585#1606#1711' '#1582#1608#1583#1585#1608
    end
    object txtCode: TEdit
      Left = 325
      Top = 14
      Width = 71
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object txtName: TEdit
      Left = 134
      Top = 14
      Width = 135
      Height = 23
      MaxLength = 40
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object txtCarNumber: TEdit
      Left = 304
      Top = 85
      Width = 71
      Height = 23
      MaxLength = 6
      TabOrder = 5
      OnKeyPress = txtCarNumberKeyPress
    end
    object txtTel: TEdit
      Left = 7
      Top = 14
      Width = 72
      Height = 23
      MaxLength = 20
      TabOrder = 2
      OnKeyPress = txtTelKeyPress
    end
    object cmdSave: TBitBtn
      Left = 353
      Top = 169
      Width = 86
      Height = 22
      Caption = '&'#1579#1576#1578
      TabOrder = 10
      OnClick = cmdSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      NumGlyphs = 2
    end
    object cmdCancel: TBitBtn
      Left = 7
      Top = 169
      Width = 86
      Height = 22
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 11
      OnClick = cmdCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object txtSerial: TEdit
      Left = 28
      Top = 85
      Width = 51
      Height = 23
      MaxLength = 2
      TabOrder = 7
      OnKeyPress = txtSerialKeyPress
    end
    object txtDate: TEdit
      Left = 282
      Top = 127
      Width = 93
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 8
      OnExit = txtDateExit
      OnKeyPress = txtDateKeyPress
    end
    object txtPrice: TEdit
      Left = 127
      Top = 127
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 9
      OnKeyPress = txtPriceKeyPress
    end
    object cmbCarName: TComboBox
      Left = 275
      Top = 56
      Width = 114
      Height = 23
      ItemHeight = 15
      TabOrder = 3
      OnEnter = cmbCarNameEnter
      OnKeyPress = cmbCarNameKeyPress
    end
    object cmbCarColor: TComboBox
      Left = 85
      Top = 56
      Width = 128
      Height = 23
      ItemHeight = 15
      TabOrder = 4
      OnEnter = cmbCarColorEnter
      OnKeyPress = cmbCarColorKeyPress
    end
    object cmbCarCity: TComboBox
      Left = 148
      Top = 85
      Width = 107
      Height = 23
      ItemHeight = 15
      TabOrder = 6
      OnEnter = cmbCarCityEnter
      OnKeyPress = cmbCarCityKeyPress
    end
  end
  object grpTamdid: TGroupBox
    Left = 0
    Top = 410
    Width = 446
    Height = 134
    Align = alTop
    TabOrder = 2
    object Label6: TLabel
      Left = 390
      Top = 14
      Width = 43
      Height = 15
      Caption = #1603#1583' '#1575#1588#1578#1585#1575#1603
      FocusControl = txtCode
    end
    object Label7: TLabel
      Left = 390
      Top = 56
      Width = 43
      Height = 15
      Caption = #1606#1575#1605' '#1605#1588#1578#1585#1603
      FocusControl = txtName
    end
    object Label13: TLabel
      Left = 391
      Top = 106
      Width = 45
      Height = 15
      Caption = #1578#1575'&'#1585#1610#1582' '#1578#1605#1583#1610#1583
    end
    object Label14: TLabel
      Left = 249
      Top = 106
      Width = 40
      Height = 15
      Caption = '&'#1605#1576#1604#1594' '#1578#1605#1583#1610#1583
    end
    object Label15: TLabel
      Left = 141
      Top = 106
      Width = 19
      Height = 15
      Caption = #1585#1610#1575#1604
    end
    object pnlCode: TPanel
      Left = 360
      Top = 28
      Width = 79
      Height = 22
      BevelOuter = bvLowered
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pnlName: TPanel
      Left = 289
      Top = 71
      Width = 150
      Height = 22
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object dbgTamdid: TDBGrid
      Left = 99
      Top = 14
      Width = 184
      Height = 79
      DataSource = dtaTamdid
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnKeyDown = dbgTamdidKeyDown
    end
    object txtTamdidDate: TEdit
      Left = 304
      Top = 106
      Width = 85
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = txtTamdidDateExit
      OnKeyPress = txtTamdidDateKeyPress
    end
    object txtTamdidPrice: TEdit
      Left = 162
      Top = 106
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
      OnKeyPress = txtTamdidPriceKeyPress
    end
    object cmdTamdidExit: TBitBtn
      Left = 7
      Top = 71
      Width = 86
      Height = 22
      Cancel = True
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 7
      OnClick = cmdTamdidExitClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cmdTamdidSave: TBitBtn
      Left = 7
      Top = 106
      Width = 86
      Height = 22
      Caption = '&'#1579#1576#1578
      TabOrder = 6
      OnClick = cmdTamdidSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      NumGlyphs = 2
    end
    object cmdTamdidDel: TBitBtn
      Left = 7
      Top = 14
      Width = 86
      Height = 22
      Caption = '&'#1581#1584#1601' '
      TabOrder = 5
      OnClick = cmdTamdidDelClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      NumGlyphs = 2
    end
  end
  object dtaCustoms: TDataSource
    DataSet = tblCustoms
    Left = 320
    Top = 64
  end
  object tblCustoms: TADOTable
    TableName = 'Customs'
    Left = 264
    Top = 64
    object tblCustomsCust_Code: TSmallintField
      Alignment = taCenter
      DisplayLabel = ' '#1603#1583' '#1575#1588#1578#1585#1575#1603
      DisplayWidth = 8
      FieldName = 'Cust_Code'
    end
    object tblCustomsCust_Name: TStringField
      DisplayLabel = '                '#1606#1575#1605' '#1605#1588#1578#1585#1603
      DisplayWidth = 25
      FieldName = 'Cust_Name'
      Size = 40
    end
    object tblCustomsCust_Remain: TCurrencyField
      DisplayLabel = '      '#1605#1608#1580#1608#1583#1610
      DisplayWidth = 15
      FieldName = 'Cust_Remain'
    end
    object tblCustomsCust_Tel: TStringField
      FieldName = 'Cust_Tel'
      Visible = False
    end
    object tblCustomsCust_CarNumber: TStringField
      FieldName = 'Cust_CarNumber'
      Visible = False
      Size = 6
    end
    object tblCustomsCust_CarCity: TStringField
      FieldName = 'Cust_CarCity'
      Visible = False
      Size = 15
    end
    object tblCustomsCust_CarSerial: TStringField
      FieldName = 'Cust_CarSerial'
      Visible = False
      Size = 2
    end
    object tblCustomsCust_CarColor: TStringField
      FieldName = 'Cust_CarColor'
      Visible = False
      Size = 15
    end
    object tblCustomsCust_CarName: TStringField
      FieldName = 'Cust_CarName'
      Visible = False
      Size = 15
    end
    object tblCustomsCust_Date: TStringField
      FieldName = 'Cust_Date'
      Visible = False
      Size = 10
    end
    object tblCustomsCust_Valid: TBooleanField
      FieldName = 'Cust_Valid'
      Visible = False
    end
  end
  object tblTamdid: TADOTable
    TableName = 'PayCust'
    Left = 168
    Top = 288
    object tblTamdidPay_Date: TStringField
      Alignment = taCenter
      DisplayLabel = '  '#1578#1575#1585#1610#1582' '#1578#1605#1583#1610#1583
      DisplayWidth = 11
      FieldName = 'Pay_Date'
      Size = 10
    end
    object tblTamdidPay_Price: TCurrencyField
      Alignment = taLeftJustify
      DisplayLabel = '   '#1605#1576#1604#1594' '#1578#1605#1583#1610#1583
      DisplayWidth = 13
      FieldName = 'Pay_Price'
    end
    object tblTamdidPay_CustCode: TSmallintField
      FieldName = 'Pay_CustCode'
      Visible = False
    end
    object tblTamdidPay_IsPay: TBooleanField
      FieldName = 'Pay_IsPay'
      Visible = False
    end
  end
  object dtaTamdid: TDataSource
    DataSet = tblTamdid
    Left = 224
    Top = 288
  end
end
