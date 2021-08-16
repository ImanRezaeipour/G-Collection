object frmSpecials: TfrmSpecials
  Left = 72
  Top = 13
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1582#1608#1583#1585#1608#1607#1575#1610' '#1608#1610#1688#1607' - '#1605#1605#1606#1608#1593#8204#1575#1604#1582#1585#1608#1580' - '#1605#1578#1608#1575#1585#1610
  ClientHeight = 319
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 445
    Height = 156
    Align = alTop
    TabOrder = 0
    object dbgSpc: TDBGrid
      Left = 99
      Top = 14
      Width = 340
      Height = 135
      DataSource = dtaSpc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnKeyDown = dbgSpcKeyDown
    end
    object cmdNew: TBitBtn
      Left = 7
      Top = 14
      Width = 86
      Height = 22
      Caption = '&'#1580#1583#1610#1583
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
      Caption = #1575'&'#1589#1604#1575#1581
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
      Caption = '&'#1581#1584#1601
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
      Top = 99
      Width = 86
      Height = 22
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 7
      Top = 127
      Width = 86
      Height = 22
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 156
    Width = 445
    Height = 134
    Align = alTop
    TabOrder = 1
    object Label3: TLabel
      Left = 252
      Top = 42
      Width = 51
      Height = 15
      Caption = #1588'&'#1607#1585' '#1582#1608#1583#1585#1608
      FocusControl = txtCarNumber
    end
    object Label9: TLabel
      Left = 395
      Top = 14
      Width = 43
      Height = 15
      Caption = #1606#1575#1605' &'#1582#1608#1583#1585#1608
    end
    object Label10: TLabel
      Left = 86
      Top = 42
      Width = 55
      Height = 15
      Caption = #1588#1605#1575#1585#1607' &'#1587#1585#1610#1575#1604
    end
    object Label8: TLabel
      Left = 380
      Top = 42
      Width = 58
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
    end
    object Label17: TLabel
      Left = 211
      Top = 14
      Width = 54
      Height = 15
      Caption = '&'#1585#1606#1711' '#1582#1608#1583#1585#1608
    end
    object txtCarNumber: TEdit
      Left = 304
      Top = 42
      Width = 71
      Height = 23
      MaxLength = 6
      TabOrder = 2
      OnKeyPress = txtCarNumberKeyPress
    end
    object txtSerial: TEdit
      Left = 28
      Top = 42
      Width = 51
      Height = 23
      MaxLength = 2
      TabOrder = 4
      OnKeyPress = txtSerialKeyPress
    end
    object cmbCarName: TComboBox
      Left = 275
      Top = 14
      Width = 114
      Height = 23
      ItemHeight = 15
      TabOrder = 0
      OnEnter = cmbCarNameEnter
      OnKeyPress = cmbCarNameKeyPress
    end
    object cmbCarColor: TComboBox
      Left = 85
      Top = 14
      Width = 128
      Height = 23
      ItemHeight = 15
      TabOrder = 1
      OnEnter = cmbCarColorEnter
      OnKeyPress = cmbCarColorKeyPress
    end
    object cmbCarCity: TComboBox
      Left = 148
      Top = 42
      Width = 107
      Height = 23
      ItemHeight = 15
      TabOrder = 3
      OnEnter = cmbCarCityEnter
      OnKeyPress = cmbCarCityKeyPress
    end
    object cmdSave: TBitBtn
      Left = 7
      Top = 78
      Width = 86
      Height = 22
      Caption = '&'#1579#1576#1578
      TabOrder = 7
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
      Top = 106
      Width = 86
      Height = 22
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 8
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
    object pnlSpc: TPanel
      Left = 99
      Top = 70
      Width = 339
      Height = 51
      BevelOuter = bvNone
      TabOrder = 6
      Visible = False
      object Label2: TLabel
        Left = 311
        Top = 21
        Width = 20
        Height = 15
        Caption = '&'#1588#1585#1581
      end
      object txtDescribe: TEdit
        Left = 7
        Top = 21
        Width = 297
        Height = 22
        AutoSize = False
        TabOrder = 0
        OnKeyPress = rdoRayganKeyPress
      end
    end
    object pnlTakhfif: TPanel
      Left = 226
      Top = 71
      Width = 213
      Height = 57
      BevelOuter = bvNone
      TabOrder = 5
      Visible = False
      object Label1: TLabel
        Left = 69
        Top = 7
        Width = 55
        Height = 15
        Caption = '&'#1583#1585#1589#1583' '#1578#1582#1601#1610#1601
      end
      object rdoTakhfif: TRadioButton
        Left = 127
        Top = 7
        Width = 79
        Height = 15
        Caption = '&'#1605#1588#1605#1608#1604' '#1578#1582#1601#1610#1601
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdoTakhfifClick
        OnKeyPress = rdoTakhfifKeyPress
      end
      object rdoRaygan: TRadioButton
        Left = 162
        Top = 35
        Width = 44
        Height = 15
        Caption = '&'#1585#1575#1610#1711#1575#1606
        TabOrder = 1
        OnClick = rdoTakhfifClick
        OnKeyPress = rdoRayganKeyPress
      end
      object txtPercent: TEdit
        Left = 7
        Top = 7
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 2
        ParentBiDiMode = False
        TabOrder = 2
        OnKeyPress = txtPercentKeyPress
      end
    end
  end
  object dtaSpc: TDataSource
    DataSet = tblSpc
    Left = 320
    Top = 64
  end
  object tblSpc: TADOTable
    OnCalcFields = tblSpcCalcFields
    IndexFieldNames = 'Spc_Number;Spc_City;Spc_Serial'
    TableName = 'Specials'
    Left = 264
    Top = 64
    object tblSpcSpc_Name: TStringField
      DisplayLabel = '      '#1606#1575#1605' '#1582#1608#1583#1585#1608
      DisplayWidth = 15
      FieldName = 'Spc_Name'
      Size = 15
    end
    object tblSpcNumber: TStringField
      Alignment = taRightJustify
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      DisplayWidth = 13
      FieldKind = fkCalculated
      FieldName = 'Number'
      Size = 7
      Calculated = True
    end
    object tblSpcSpc_City: TStringField
      DisplayLabel = '          '#1588#1607#1585
      DisplayWidth = 15
      FieldName = 'Spc_City'
      Size = 15
    end
    object tblSpcSpc_Serial: TStringField
      Alignment = taCenter
      DisplayLabel = #1587#1585#1610#1575#1604
      FieldName = 'Spc_Serial'
      Size = 2
    end
    object tblSpcSpc_Number: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      DisplayWidth = 13
      FieldName = 'Spc_Number'
      Visible = False
      Size = 6
    end
    object tblSpcSpc_Color: TStringField
      FieldName = 'Spc_Color'
      Visible = False
      Size = 15
    end
    object tblSpcSpc_NotExit: TBooleanField
      FieldName = 'Spc_NotExit'
      Visible = False
    end
    object tblSpcSpc_Motavari: TBooleanField
      FieldName = 'Spc_Motavari'
      Visible = False
    end
    object tblSpcSpc_Takhfif: TBooleanField
      FieldName = 'Spc_Takhfif'
      Visible = False
    end
    object tblSpcSpc_Percent: TSmallintField
      FieldName = 'Spc_Percent'
      Visible = False
    end
    object tblSpcSpc_Debtor: TCurrencyField
      FieldName = 'Spc_Debtor'
      Visible = False
    end
    object tblSpcSpc_DescribeNotExit: TStringField
      FieldName = 'Spc_DescribeNotExit'
      Visible = False
      Size = 255
    end
    object tblSpcSpc_DescribeMotavari: TStringField
      FieldName = 'Spc_DescribeMotavari'
      Visible = False
      Size = 255
    end
  end
end
