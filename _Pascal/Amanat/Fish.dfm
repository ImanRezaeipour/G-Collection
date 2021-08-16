object frmFish: TfrmFish
  Left = 264
  Top = 110
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1585#1575#1574#1607' '#1582#1583#1605#1575#1578' '#1583#1587#1578#1610
  ClientHeight = 435
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 328
    Top = 8
    Width = 22
    Height = 15
    Caption = #1578#1575#1585#1610#1582
  end
  object lbl2: TLabel
    Left = 185
    Top = 8
    Width = 21
    Height = 15
    Caption = #1586#1605#1575#1606
  end
  object lblVadeh: TLabel
    Left = 33
    Top = 10
    Width = 81
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblVadeh'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 369
    Top = 40
    Width = 13
    Height = 15
    Caption = #1601#1585#1583
  end
  object lbl4: TLabel
    Left = 335
    Top = 96
    Width = 28
    Height = 15
    Alignment = taCenter
    Caption = #1582#1583#1605#1575#1578
    WordWrap = True
  end
  object lbl6: TLabel
    Left = 137
    Top = 333
    Width = 21
    Height = 15
    Caption = #1605#1576#1604#1594' '
  end
  object lblBalance: TLabel
    Left = 12
    Top = 44
    Width = 58
    Height = 15
    Caption = 'lblBalance'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 111
    Top = 84
    Width = 15
    Height = 15
    Caption = #1593#1583#1583
  end
  object Label1: TLabel
    Left = 201
    Top = 86
    Width = 8
    Height = 15
    Caption = 'X'
  end
  object lbl7: TLabel
    Left = 165
    Top = 368
    Width = 117
    Height = 15
    Caption = #1670#1575#1662' '#1585#1608#1610' '#1662#1585#1610#1606#1578#1585' '#1605#1578#1589#1604' '#1576#1607' '
    Visible = False
  end
  object txtDate: TEdit
    Left = 232
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtDateExit
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TEdit
    Left = 112
    Top = 8
    Width = 65
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    ReadOnly = True
    TabOrder = 1
    OnExit = txtTimeExit
    OnKeyPress = txtTimeKeyPress
  end
  object cmbEmplNo: TComboBox
    Left = 240
    Top = 40
    Width = 122
    Height = 23
    BiDiMode = bdLeftToRight
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = cmbEmplNoClick
    OnExit = cmbEmplNoExit
    OnKeyPress = cmbEmplNoKeyPress
  end
  object cmbFamilyName: TComboBox
    Left = 73
    Top = 40
    Width = 168
    Height = 23
    ItemHeight = 15
    TabOrder = 3
    OnClick = cmbFamilyNameClick
    OnExit = cmbFamilyNameExit
    OnKeyPress = cmbEmplNoKeyPress
  end
  object txtMany: TEdit
    Left = 136
    Top = 80
    Width = 49
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 5
    Text = '1'
    OnKeyPress = txtManyKeyPress
  end
  object cmbSrvcName: TComboBox
    Left = 112
    Top = 112
    Width = 217
    Height = 23
    ItemHeight = 15
    TabOrder = 6
    OnClick = cmbSrvcNameClick
    OnExit = cmbSrvcNameExit
    OnKeyPress = cmbSrvcNameKeyPress
  end
  object btnSelFood: TBitBtn
    Left = 8
    Top = 80
    Width = 97
    Height = 57
    Caption = #1575#1606#1578#1582#1575#1576
    TabOrder = 7
    OnClick = btnSelFoodClick
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
  object grdSrvc: TStringGrid
    Left = 8
    Top = 144
    Width = 377
    Height = 185
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 8
    RowHeights = (
      24
      24)
  end
  object btnSave: TBitBtn
    Left = 200
    Top = 400
    Width = 89
    Height = 25
    Caption = #1579#1576#1578
    TabOrder = 10
    OnClick = btnSaveClick
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
  object btnCancel: TBitBtn
    Left = 104
    Top = 400
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1575#1606#1589#1585#1575#1601
    TabOrder = 11
    OnClick = btnCancelClick
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
  object btnClose: TBitBtn
    Left = 8
    Top = 400
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 12
    Kind = bkClose
  end
  object txtTotalPrice: TEdit
    Left = 8
    Top = 328
    Width = 121
    Height = 23
    Enabled = False
    TabOrder = 9
  end
  object cmbSrvcCode: TComboBox
    Left = 224
    Top = 80
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 4
    OnClick = cmbSrvcCodeClick
    OnExit = cmbSrvcCodeExit
    OnKeyPress = cmbSrvcCodeKeyPress
    OnKeyUp = cmbSrvcCodeKeyUp
  end
  object chkPrint: TCheckBox
    Left = 313
    Top = 369
    Width = 67
    Height = 17
    Caption = #1670#1575#1662' '#1601#1610#1588
    TabOrder = 13
    OnClick = chkPrintClick
  end
  object cmbReaders: TComboBox
    Left = 8
    Top = 364
    Width = 153
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 14
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 48
    Top = 208
  end
  object atblSrvc: TADOTable
    TableName = 'Services'
    Left = 162
    Top = 242
  end
end
