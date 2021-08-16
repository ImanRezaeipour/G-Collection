object frmGustCard: TfrmGustCard
  Left = 79
  Top = 0
  HelpContext = 105
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1603#1575#1585#1578#1607#1575#1610' '#1605#1610#1607#1605#1575#1606
  ClientHeight = 492
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 479
    Height = 257
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 370
      Top = 48
      Width = 34
      Height = 15
      Caption = '&'#1603#1583' '#1576#1582#1588
      FocusControl = cmbPartCode
    end
    object Label6: TLabel
      Left = 352
      Top = 16
      Width = 52
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      FocusControl = txtSearchCode
    end
    object Label5: TLabel
      Left = 432
      Top = 32
      Width = 30
      Height = 15
      Caption = #1580#1587#1578#1580#1608
    end
    object Label7: TLabel
      Left = 203
      Top = 48
      Width = 35
      Height = 15
      Caption = '&'#1606#1575#1605' '#1576#1582#1588
    end
    object Bevel1: TBevel
      Left = 1
      Top = 80
      Width = 477
      Height = 5
      Shape = bsTopLine
    end
    object dbgGuest: TDBGrid
      Left = 112
      Top = 88
      Width = 361
      Height = 157
      DataSource = dtaGuest
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgGuestKeyDown
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 88
      Width = 97
      Height = 25
      Caption = #1605#1610#1607#1605#1575#1606' &'#1580#1583#1610#1583
      TabOrder = 4
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
      Left = 8
      Top = 120
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1605#1610#1607#1605#1575#1606
      TabOrder = 5
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
      Left = 8
      Top = 152
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601' '#1605#1610#1607#1605#1575#1606
      TabOrder = 6
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
      Left = 8
      Top = 184
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 7
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 216
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 8
      Kind = bkClose
    end
    object cmbPartCode: TComboBox
      Left = 248
      Top = 48
      Width = 97
      Height = 23
      ItemHeight = 15
      TabOrder = 1
      OnClick = cmbPartCodeClick
      OnExit = cmbPartCodeClick
      OnKeyPress = cmbPartCodeKeyPress
    end
    object cmbPartName: TComboBox
      Left = 40
      Top = 48
      Width = 153
      Height = 23
      ItemHeight = 15
      TabOrder = 2
      OnClick = cmbPartNameClick
      OnExit = cmbPartNameClick
      OnKeyPress = cmbPartCodeKeyPress
    end
    object txtSearchCode: TEdit
      Left = 248
      Top = 16
      Width = 97
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtSearchCodeExit
      OnKeyPress = txtSearchCodeKeyPress
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 257
    Width = 479
    Height = 227
    Align = alTop
    TabOrder = 1
    DesignSize = (
      479
      227)
    object Label1: TLabel
      Left = 407
      Top = 25
      Width = 63
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1588#1606#1575#1587#1575#1610#1610
      FocusControl = txtBarCode
    end
    object Label2: TLabel
      Left = 407
      Top = 54
      Width = 53
      Height = 15
      Caption = '&'#1593#1606#1608#1575#1606' '#1603#1575#1585#1578
      FocusControl = txtDescribe
    end
    object Label4: TLabel
      Left = 407
      Top = 113
      Width = 21
      Height = 15
      Caption = '&'#1576#1582#1588
    end
    object Label9: TLabel
      Left = 407
      Top = 83
      Width = 52
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      FocusControl = txtProxi
    end
    object Label8: TLabel
      Left = 155
      Top = 22
      Width = 43
      Height = 15
      Caption = #1606#1608#1593' '#1603#1575#1585#1578
    end
    object Label11: TLabel
      Left = 414
      Top = 164
      Width = 30
      Height = 15
      Caption = #1578#1608#1590#1610#1581
      FocusControl = txtremark
    end
    object txtBarCode: TEdit
      Left = 288
      Top = 22
      Width = 113
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtBarCodeKeyPress
    end
    object cmdCancel: TBitBtn
      Left = 7
      Top = 193
      Width = 105
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 6
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
    object cmdSave: TBitBtn
      Left = 128
      Top = -150
      Width = 105
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 5
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
    object txtDescribe: TEdit
      Left = 256
      Top = 51
      Width = 145
      Height = 23
      MaxLength = 30
      TabOrder = 2
      OnKeyPress = txtDescribeKeyPress
    end
    object chkPricable: TCheckBox
      Left = 331
      Top = 138
      Width = 73
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1576#1575' '#1575#1582'&'#1584' '#1608#1580#1607
      ParentBiDiMode = False
      TabOrder = 3
      OnKeyPress = chkPricableKeyPress
    end
    object txtProxi: TEdit
      Left = 256
      Top = 80
      Width = 145
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtProxiKeyPress
    end
    object chkDblFood: TCheckBox
      Left = 80
      Top = 138
      Width = 175
      Height = 17
      Caption = #1575#1580#1575#1586#1607' '#1594'&'#1584#1575#1610' '#1575#1590#1575#1601#1610'    '#1578#1593#1583#1575#1583
      TabOrder = 4
      OnClick = chkDblFoodClick
      OnKeyPress = chkDblFoodKeyPress
    end
    object txtParts: TEdit
      Left = 256
      Top = 110
      Width = 145
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 15
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 7
    end
    object BitBtn2: TBitBtn
      Left = 258
      Top = 112
      Width = 19
      Height = 19
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
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
    object cmbType: TComboBox
      Left = 17
      Top = 19
      Width = 129
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 9
      OnClick = cmbTypeClick
      OnKeyPress = cmbTypeKeyPress
      Items.Strings = (
        #1603#1575#1585#1578' '#1593#1575#1583#1610
        #1603#1575#1585#1578' '#1578#1593#1583#1575#1583#1610
        #1603#1575#1585#1578' '#1578#1575#1585#1610#1582' '#1583#1575#1585
        #1705#1575#1585#1578' '#1578#1593#1583#1575#1583#1610' '#1578#1575#1585#1610#1582' '#1583#1575#1585)
    end
    object pnlMany: TPanel
      Left = 17
      Top = 50
      Width = 221
      Height = 27
      BevelOuter = bvNone
      TabOrder = 10
      Visible = False
      object lbl1: TLabel
        Left = 133
        Top = 8
        Width = 55
        Height = 15
        Caption = '&'#1578#1593#1583#1575#1583' '#1606#1601#1585#1575#1578'  '
        FocusControl = txtMany
      end
      object txtMany: TEdit
        Left = 2
        Top = 2
        Width = 129
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 3
        ParentBiDiMode = False
        TabOrder = 0
        OnKeyPress = txtManyKeyPress
      end
    end
    object pnlDate: TPanel
      Left = 18
      Top = 79
      Width = 220
      Height = 61
      BevelOuter = bvNone
      TabOrder = 11
      object Label10: TLabel
        Left = 137
        Top = 7
        Width = 74
        Height = 15
        Caption = '&'#1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1575#1593#1578#1576#1575#1585
        FocusControl = txtDate
      end
      object txtDate: TEdit
        Left = 1
        Top = 2
        Width = 128
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 10
        ParentBiDiMode = False
        TabOrder = 0
        OnExit = txtDateExit
        OnKeyPress = txtDateKeyPress
      end
    end
    object txtCount: TEdit
      Left = 47
      Top = 134
      Width = 68
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 3
      ParentBiDiMode = False
      TabOrder = 12
      OnKeyPress = txtCountKeyPress
    end
    object BitBtn1: TBitBtn
      Left = 369
      Top = 193
      Width = 105
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 14
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
    object txtremark: TEdit
      Left = 150
      Top = 161
      Width = 254
      Height = 23
      MaxLength = 50
      TabOrder = 13
      OnKeyPress = txtremarkKeyPress
    end
  end
  object dtaGuest: TDataSource
    DataSet = tblGuest
    Left = 312
    Top = 160
  end
  object tblGuest: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=rest'
    CursorType = ctStatic
    Filter = 'P_IsGuest = True'
    Filtered = True
    OnCalcFields = tblGuestCalcFields
    TableName = 'Persons'
    Left = 256
    Top = 160
    object tblGuestPCode: TStringField
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'PCode'
      Size = 8
      Calculated = True
    end
    object tblGuestP_BarCode: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 11
      FieldName = 'P_BarCode'
      Visible = False
      Size = 8
    end
    object tblGuestP_Family: TStringField
      DisplayLabel = '        '#1593#1606#1608#1575#1606' '#1603#1575#1585#1578
      DisplayWidth = 17
      FieldName = 'P_Family'
      Size = 30
    end
    object tblGuestPart: TStringField
      DisplayLabel = '           '#1576#1582#1588
      DisplayWidth = 17
      FieldKind = fkCalculated
      FieldName = 'Part'
      Calculated = True
    end
    object tblGuestP_Pricable: TBooleanField
      FieldName = 'P_Pricable'
      Visible = False
    end
    object tblGuestP_IsGuest: TBooleanField
      FieldName = 'P_IsGuest'
      Visible = False
    end
    object tblGuestP_IsValid: TBooleanField
      FieldName = 'P_IsValid'
      Visible = False
    end
    object tblGuestP_ValidTest: TBooleanField
      FieldName = 'P_ValidTest'
      Visible = False
    end
    object tblGuestP_Sobhaneh: TBooleanField
      FieldName = 'P_Sobhaneh'
      Visible = False
    end
    object tblGuestP_Nahar: TBooleanField
      FieldName = 'P_Nahar'
      Visible = False
    end
    object tblGuestP_Sham: TBooleanField
      FieldName = 'P_Sham'
      Visible = False
    end
    object tblGuestP_Special: TSmallintField
      FieldName = 'P_Special'
      Visible = False
    end
    object tblGuestP_ManyFish: TSmallintField
      FieldName = 'P_ManyFish'
      Visible = False
    end
    object tblGuestP_EtebarFish: TStringField
      FieldName = 'P_EtebarFish'
      Visible = False
      Size = 10
    end
    object tblGuestP_Proxi: TStringField
      FieldName = 'P_Proxi'
      Visible = False
      Size = 15
    end
    object tblGuestP_ShiftGroup: TSmallintField
      FieldName = 'P_ShiftGroup'
      Visible = False
    end
    object tblGuestP_Rejim: TBooleanField
      FieldName = 'P_Rejim'
      Visible = False
    end
    object tblGuestP_DblFood: TBooleanField
      FieldName = 'P_DblFood'
      Visible = False
    end
    object tblGuestP_Parts: TWideStringField
      FieldName = 'P_Parts'
      Size = 50
    end
    object tblGuestP_dblFoodMax: TSmallintField
      FieldName = 'P_dblFoodMax'
    end
    object tblGuestP_Reserve1: TStringField
      FieldName = 'P_reserve1'
      Size = 50
    end
  end
end
