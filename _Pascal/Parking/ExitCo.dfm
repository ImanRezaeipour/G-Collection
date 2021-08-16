object frmExitCo: TfrmExitCo
  Left = 136
  Top = 36
  HelpContext = 302
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1587#1575#1586#1605#1575#1606#1610
  ClientHeight = 356
  ClientWidth = 373
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
  OnShow = FormShow
  DesignSize = (
    373
    356)
  PixelsPerInch = 96
  TextHeight = 15
  object Label10: TLabel
    Left = 148
    Top = 11
    Width = 34
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1587#1585#1610#1575#1604' :'
  end
  object Label17: TLabel
    Left = 120
    Top = 39
    Width = 62
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1585#1606#1711' '#1582#1608#1583#1585#1608' :'
  end
  object Label3: TLabel
    Left = 326
    Top = 323
    Width = 26
    Height = 15
    Caption = #1588#1607#1585' :'
  end
  object Label9: TLabel
    Left = 314
    Top = 39
    Width = 51
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1606#1575#1605' '#1582#1608#1583#1585#1608' :'
  end
  object Label8: TLabel
    Left = 299
    Top = 11
    Width = 66
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
  end
  object Label1: TLabel
    Left = 305
    Top = 68
    Width = 60
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578' :'
    FocusControl = cmbBarCode
  end
  object Label2: TLabel
    Left = 305
    Top = 95
    Width = 60
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580' :'
  end
  object Label4: TLabel
    Left = 123
    Top = 95
    Width = 59
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580' :'
  end
  object Label5: TLabel
    Left = 308
    Top = 244
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1583#1585#1576' '#1582#1585#1608#1580' :'
    Enabled = False
    FocusControl = cmbDoorCode
  end
  object Label6: TLabel
    Left = 301
    Top = 294
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1578#1589#1583#1610' '#1582#1585#1608#1580' :'
    Enabled = False
    Visible = False
  end
  object Label7: TLabel
    Left = 334
    Top = 124
    Width = 31
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1585#1575#1606#1606#1583#1607' :'
  end
  object Label11: TLabel
    Left = 334
    Top = 182
    Width = 31
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1602#1589#1583' :'
  end
  object Label12: TLabel
    Left = 301
    Top = 153
    Width = 64
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1603#1610#1604#1608#1605#1578#1585' '#1588#1605#1575#1585' :'
  end
  object Label15: TLabel
    Left = 150
    Top = 182
    Width = 32
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1580#1608#1586' :'
  end
  object Label16: TLabel
    Left = 337
    Top = 211
    Width = 28
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1585#1581' :'
  end
  object cmdNewDriver: TSpeedButton
    Left = 79
    Top = 121
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
  end
  object Label26: TLabel
    Left = 125
    Top = 66
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1581#1604' '#1582#1585#1608#1580' :'
  end
  object cmdCancel: TBitBtn
    Left = 8
    Top = 266
    Width = 115
    Height = 22
    Cancel = True
    Caption = '&'#1575#1606#1589#1585#1575#1601
    ModalResult = 2
    TabOrder = 13
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
    Left = 250
    Top = 266
    Width = 115
    Height = 22
    Caption = '&'#1579#1576#1578
    TabOrder = 11
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
  object cmbBarCode: TComboBox
    Left = 61
    Top = 323
    Width = 114
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    MaxLength = 8
    TabOrder = 14
    Visible = False
    OnClick = cmbBarCodeExit
    OnExit = cmbBarCodeExit
    OnKeyPress = cmbBarCodeKeyPress
  end
  object txtDate: TEdit
    Left = 210
    Top = 92
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 10
    TabOrder = 0
    OnExit = txtDateExit
    OnKeyDown = txtDateKeyDown
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TEdit
    Left = 44
    Top = 92
    Width = 58
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 5
    TabOrder = 1
    OnExit = txtTimeExit
    OnKeyDown = txtTimeKeyDown
    OnKeyPress = txtTimeKeyPress
  end
  object cmbDoorCode: TComboBox
    Left = 210
    Top = 237
    Width = 85
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    TabOrder = 9
    OnClick = cmbDoorCodeClick
    OnExit = cmbDoorCodeExit
    OnKeyPress = cmbDoorCodeKeyPress
  end
  object cmbDoorName: TComboBox
    Left = 76
    Top = 237
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
    Left = 210
    Top = 294
    Width = 85
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    TabOrder = 19
    Visible = False
    OnClick = cmbPersonCodeClick
    OnExit = cmbPersonCodeExit
    OnKeyPress = cmbPersonCodeKeyPress
  end
  object cmbPersonName: TComboBox
    Left = 76
    Top = 294
    Width = 128
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    Enabled = False
    ItemHeight = 15
    TabOrder = 20
    Visible = False
    OnClick = cmbPersonNameClick
    OnKeyPress = cmbPersonCodeKeyPress
  end
  object lblName: TStaticText
    Left = 188
    Top = 36
    Width = 107
    Height = 22
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object lblColor: TStaticText
    Left = 8
    Top = 36
    Width = 94
    Height = 22
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
  end
  object lblCity: TStaticText
    Left = 221
    Top = 323
    Width = 109
    Height = 22
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
  end
  object lblSerial: TStaticText
    Left = 44
    Top = 8
    Width = 58
    Height = 22
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
  end
  object txtDriver: TEdit
    Left = -42
    Top = 121
    Width = 107
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 25
    TabOrder = 4
    Visible = False
    OnKeyPress = txtDriverKeyPress
  end
  object txtOAmper: TEdit
    Left = 188
    Top = 150
    Width = 107
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 10
    TabOrder = 5
    OnKeyPress = txtOAmperKeyPress
  end
  object lblNumber: TEdit
    Left = 210
    Top = 8
    Width = 85
    Height = 20
    TabStop = False
    Anchors = [akTop, akRight]
    Ctl3D = False
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentColor = True
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 21
  end
  object cmdHelp: TBitBtn
    Left = 129
    Top = 266
    Width = 115
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 12
    Kind = bkHelp
  end
  object txtTarget: TEdit
    Left = 188
    Top = 179
    Width = 107
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 30
    TabOrder = 6
    OnKeyPress = txtTargetKeyPress
  end
  object txtMojavez: TEdit
    Left = 8
    Top = 179
    Width = 94
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 10
    TabOrder = 7
    OnKeyPress = txtMojavezKeyPress
  end
  object txtDescribe: TEdit
    Left = 8
    Top = 208
    Width = 287
    Height = 23
    Anchors = [akTop, akRight]
    MaxLength = 50
    TabOrder = 8
    OnKeyPress = txtDescribeKeyPress
  end
  object lblBarCode: TStaticText
    Left = 188
    Top = 64
    Width = 107
    Height = 22
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
  end
  object cmbDriver: TComboBox
    Left = 108
    Top = 121
    Width = 187
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = cmbDriverChange
  end
  object cmbDriverCode: TComboBox
    Left = 137
    Top = 127
    Width = 38
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Visible = False
    OnChange = cmbDriverChange
  end
  object lblDepartment: TStaticText
    Left = 8
    Top = 64
    Width = 94
    Height = 22
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
    TabOrder = 23
  end
  object lblDepartmentCode: TStaticText
    Left = 21
    Top = 68
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
    TabOrder = 24
    Visible = False
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 234
  end
end
