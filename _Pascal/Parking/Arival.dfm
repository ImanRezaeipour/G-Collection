object frmArival: TfrmArival
  Left = 73
  Top = 115
  Hint = 'M_Visited'
  HelpContext = 301
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1608#1585#1608#1583' '#1582#1608#1583#1585#1608
  ClientHeight = 319
  ClientWidth = 494
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    494
    319)
  PixelsPerInch = 96
  TextHeight = 15
  object Label10: TLabel
    Left = 181
    Top = 40
    Width = 34
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1587#1585#1610#1575#1604' :'
    ExplicitLeft = 178
  end
  object Label17: TLabel
    Left = 153
    Top = 185
    Width = 62
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1585#1606#1711' '#1582#1608#1583#1585#1608' :'
    ExplicitLeft = 150
  end
  object Label3: TLabel
    Left = 121
    Top = 276
    Width = 26
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588'&'#1607#1585' :'
    FocusControl = txtCarNumber
    Visible = False
  end
  object Label9: TLabel
    Left = 435
    Top = 185
    Width = 51
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1606#1575#1605' &'#1582#1608#1583#1585#1608' :'
    ExplicitLeft = 377
  end
  object Label8: TLabel
    Left = 420
    Top = 40
    Width = 66
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    ExplicitLeft = 362
  end
  object Label1: TLabel
    Left = 428
    Top = 11
    Width = 58
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1576#1575#1585#1603#1583' :'
    Enabled = False
    FocusControl = cmbBarCode
    ExplicitLeft = 315
  end
  object Label2: TLabel
    Left = 430
    Top = 69
    Width = 56
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1578#1575#1585#1610#1582' '#1608#1585#1608#1583' :'
    ExplicitLeft = 372
  end
  object Label4: TLabel
    Left = 160
    Top = 72
    Width = 55
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1586#1605#1575#1606' '#1608#1585#1608#1583' :'
    ExplicitLeft = 157
  end
  object Label5: TLabel
    Left = 425
    Top = 156
    Width = 61
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1583#1585#1576' '#1608#1585#1608#1583#1610' :'
    Enabled = False
    FocusControl = cmbDoorCode
    ExplicitLeft = 367
  end
  object Label6: TLabel
    Left = 421
    Top = 276
    Width = 65
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1605#1578#1589#1583#1610' '#1608#1585#1608#1583' :'
    Visible = False
    ExplicitLeft = 363
  end
  object Label7: TLabel
    Left = 441
    Top = 98
    Width = 45
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1606#1575#1605' '#1585#1575#1606#1606#1583#1607' :'
    ExplicitLeft = 383
  end
  object Label11: TLabel
    Left = 159
    Top = 98
    Width = 56
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1581#1604' '#1582#1583#1605#1578' :'
    ExplicitLeft = 156
  end
  object cmdNewDriver: TSpeedButton
    Left = 221
    Top = 95
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
    OnClick = cmdNewDriverClick
    ExplicitLeft = 218
  end
  object Label12: TLabel
    Left = 422
    Top = 127
    Width = 64
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1604#1575#1602#1575#1578' '#1588#1608#1606#1583#1607' :'
    ExplicitLeft = 364
  end
  object cmdNewVisited: TSpeedButton
    Left = 221
    Top = 124
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
    OnClick = cmdNewDriverClick
    ExplicitLeft = 218
  end
  object Label13: TLabel
    Left = 162
    Top = 127
    Width = 53
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1581#1604' '#1608#1585#1608#1583' :'
    ExplicitLeft = 159
  end
  object cmdNewEntrance: TSpeedButton
    Left = 8
    Top = 124
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
    Visible = False
  end
  object cmdNewCarName: TSpeedButton
    Left = 221
    Top = 182
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
    OnClick = cmdNewCarNameClick
    ExplicitLeft = 218
  end
  object cmdNewCarColor: TSpeedButton
    Left = 8
    Top = 182
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
    OnClick = cmdNewCarColorClick
  end
  object cmdNewOffice: TSpeedButton
    Left = 8
    Top = 95
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Flat = True
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
  object cmdCancel: TBitBtn
    Left = 8
    Top = 240
    Width = 91
    Height = 22
    Hint = #1575#1606#1589#1585#1575#1601
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&'#1575#1606#1589#1585#1575#1601
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
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
  object cmdSave: TBitBtn
    Left = 395
    Top = 240
    Width = 91
    Height = 22
    Hint = #1579#1576#1578' '#1575#1591#1604#1575#1593#1575#1578
    Anchors = [akTop, akRight]
    Caption = '&'#1579#1576#1578
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
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
  object txtSerial: TEdit
    Left = 32
    Top = 37
    Width = 115
    Height = 23
    Hint = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = txtCarNumberChange
    OnExit = txtSerialExit
    OnKeyDown = txtSerialKeyDown
    OnKeyPress = txtSerialKeyPress
  end
  object cmbCarColor: TComboBox
    Left = 32
    Top = 182
    Width = 115
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 12
    OnEnter = cmbCarColorEnter
    OnKeyPress = cmbCarColorKeyPress
  end
  object cmbCarCity: TComboBox
    Left = 9
    Top = 273
    Width = 114
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 16
    Visible = False
    OnEnter = cmbCarCityEnter
    OnKeyPress = cmbCarCityKeyPress
  end
  object cmbCarName: TComboBox
    Left = 245
    Top = 182
    Width = 169
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 11
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCarNameKeyPress
  end
  object txtCarNumber: TEdit
    Left = 245
    Top = 37
    Width = 169
    Height = 23
    Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    MaxLength = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = txtCarNumberChange
    OnKeyPress = txtCarNumberKeyPress
  end
  object cmbBarCode: TComboBox
    Left = 245
    Top = 8
    Width = 169
    Height = 23
    Hint = #1588#1605#1575#1585#1607' '#1576#1575#1585#1705#1583' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    MaxLength = 8
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyPress = cmbBarCodeKeyPress
  end
  object txtDate: TEdit
    Left = 245
    Top = 66
    Width = 169
    Height = 23
    Hint = 'Ctrl + Enter : '#1575#1605#1585#1608#1586
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnExit = txtDateExit
    OnKeyDown = txtDateKeyDown
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TEdit
    Left = 32
    Top = 66
    Width = 115
    Height = 23
    Hint = 'Ctrl + Enter : '#1575#1705#1606#1608#1606
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnExit = txtTimeExit
    OnKeyDown = txtTimeKeyDown
    OnKeyPress = txtTimeKeyPress
  end
  object cmbDoorCode: TComboBox
    Left = 328
    Top = 153
    Width = 86
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    TabOrder = 9
    OnClick = cmbDoorCodeClick
    OnKeyPress = cmbDoorCodeKeyPress
  end
  object cmbDoorName: TComboBox
    Left = 194
    Top = 153
    Width = 128
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    TabOrder = 10
    OnClick = cmbDoorNameClick
    OnKeyPress = cmbDoorCodeKeyPress
  end
  object cmbPersonCode: TComboBox
    Left = 322
    Top = 273
    Width = 86
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 17
    Visible = False
    OnClick = cmbPersonCodeClick
    OnKeyPress = cmbPersonCodeKeyPress
  end
  object cmbPersonName: TComboBox
    Left = 188
    Top = 273
    Width = 128
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 18
    Visible = False
    OnClick = cmbPersonNameClick
    OnKeyPress = cmbPersonCodeKeyPress
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 240
    Width = 91
    Height = 22
    Hint = #1585#1575#1607#1606#1605#1575
    Anchors = [akTop, akRight]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Kind = bkHelp
  end
  object cmbDriver: TComboBox
    Left = 245
    Top = 95
    Width = 169
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnChange = cmbDriverChange
  end
  object cmbVisited: TComboBox
    Left = 245
    Top = 124
    Width = 169
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnChange = cmbVisitedChange
  end
  object lblWorkDepartment: TStaticText
    Left = 32
    Top = 95
    Width = 115
    Height = 23
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
  end
  object lblEntranceDepartment: TStaticText
    Left = 32
    Top = 124
    Width = 115
    Height = 23
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
  end
  object lblResult: TStaticText
    Left = 8
    Top = 211
    Width = 478
    Height = 23
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    BiDiMode = bdRightToLeftNoAlign
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
  end
  object cmbDriverCode: TComboBox
    Left = 346
    Top = 99
    Width = 38
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    Visible = False
    OnChange = cmbDriverChange
  end
  object cmbWorkDepartmentCode: TComboBox
    Left = 85
    Top = 106
    Width = 38
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
    Visible = False
    OnChange = cmbDriverChange
  end
  object cmbVisitedCode: TComboBox
    Left = 346
    Top = 128
    Width = 38
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    Visible = False
    OnChange = cmbDriverChange
  end
  object lblEntranceDepartmentCode: TStaticText
    Left = 85
    Top = 135
    Width = 33
    Height = 23
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    Visible = False
  end
  object cmbWorkDepartment: TComboBox
    Left = -34
    Top = 106
    Width = 113
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 6
    Visible = False
  end
  object cmbEntranceDepartment: TComboBox
    Left = -34
    Top = 135
    Width = 113
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 8
    Visible = False
  end
  object cmdExitCar: TBitBtn
    Left = 298
    Top = 240
    Width = 91
    Height = 22
    Hint = #1582#1585#1608#1580' '#1582#1608#1583#1585#1608
    Anchors = [akTop, akRight]
    Caption = '&'#1582#1585#1608#1580' '#1582#1608#1583#1585#1608'(F5)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
    OnClick = cmdExitCarClick
    NumGlyphs = 2
  end
  object cmdOpenDoor: TBitBtn
    Left = 201
    Top = 240
    Width = 91
    Height = 22
    Hint = #1582#1585#1608#1580' '#1582#1608#1583#1585#1608
    Anchors = [akTop, akRight]
    Caption = '&'#1576#1575#1586#1705#1585#1583#1606' '#1576#1575#1604#1575#1576#1585'(F8)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 27
    OnClick = cmdOpenDoorClick
    NumGlyphs = 2
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 8
  end
end
