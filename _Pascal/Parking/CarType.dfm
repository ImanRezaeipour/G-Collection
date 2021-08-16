object frmCarTypes: TfrmCarTypes
  Left = 47
  Top = 7
  HelpContext = 103
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1575#1606#1608#1575#1593' '#1582#1608#1583#1585#1608#1607#1575' '#1608' '#1606#1585#1582' '#1711#1584#1575#1585#1610
  ClientHeight = 427
  ClientWidth = 527
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 527
    Height = 185
    Align = alTop
    TabOrder = 0
    object dbgTypes: TDBGrid
      Left = 111
      Top = 16
      Width = 410
      Height = 157
      DataSource = dtaTypes
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDrawColumnCell = dbgTypesDrawColumnCell
      OnKeyDown = dbgTypesKeyDown
      OnMouseMove = dbgTypesMouseMove
      OnTitleClick = dbgTypesTitleClick
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 16
      Width = 97
      Height = 25
      Caption = #1606#1608#1593' &'#1580#1583#1610#1583
      Enabled = False
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
      Left = 8
      Top = 48
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1606#1608#1593
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
      Left = 8
      Top = 80
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601' '#1606#1608#1593
      Enabled = False
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
      Left = 8
      Top = 120
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 152
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 112
    Width = 527
    Height = 296
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 479
      Top = 21
      Width = 37
      Height = 15
      Caption = '&'#1603#1583' '#1606#1608#1593' :'
      FocusControl = txtTypeCode
    end
    object Label2: TLabel
      Left = 328
      Top = 21
      Width = 57
      Height = 15
      Caption = '&'#1606#1608#1593' '#1582#1608#1583#1585#1608' :'
      FocusControl = txtTypeName
    end
    object txtTypeCode: TEdit
      Left = 391
      Top = 18
      Width = 81
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = txtTypeCodeKeyPress
    end
    object txtTypeName: TEdit
      Left = 217
      Top = 18
      Width = 105
      Height = 23
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = txtTypeNameKeyPress
    end
    object cmdSave: TBitBtn
      Left = 424
      Top = 264
      Width = 97
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 4
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
      Left = 8
      Top = 264
      Width = 97
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 5
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
    object chkDefault: TCheckBox
      Left = 122
      Top = 21
      Width = 89
      Height = 17
      Caption = #1606#1608#1593' &'#1662#1610#1588' '#1601#1585#1590
      TabOrder = 2
      OnKeyPress = chkDefaultKeyPress
    end
    object grpPrice: TGroupBox
      Left = 11
      Top = 49
      Width = 513
      Height = 209
      TabOrder = 3
      object Label17: TLabel
        Left = 467
        Top = 21
        Width = 38
        Height = 15
        Caption = #1608#1585#1608#1583#1610#1607' :'
        FocusControl = txtVorood
      end
      object Label18: TLabel
        Left = 355
        Top = 21
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label16: TLabel
        Left = 160
        Top = 115
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label12: TLabel
        Left = 160
        Top = 83
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label7: TLabel
        Left = 160
        Top = 54
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label15: TLabel
        Left = 240
        Top = 115
        Width = 18
        Height = 15
        Caption = #1583#1602#1610#1602#1607
      end
      object Label11: TLabel
        Left = 240
        Top = 83
        Width = 18
        Height = 15
        Caption = #1583#1602#1610#1602#1607
      end
      object Label10: TLabel
        Left = 240
        Top = 54
        Width = 18
        Height = 15
        Caption = #1583#1602#1610#1602#1607
      end
      object Label14: TLabel
        Left = 319
        Top = 115
        Width = 16
        Height = 15
        Caption = ' '#1607#1585
        FocusControl = txtFirstTime
      end
      object Label6: TLabel
        Left = 319
        Top = 83
        Width = 16
        Height = 15
        Caption = ' '#1607#1585
        FocusControl = txtFirstTime
      end
      object Label3: TLabel
        Left = 319
        Top = 54
        Width = 16
        Height = 15
        Caption = ' '#1607#1585
        FocusControl = txtFirstTime
      end
      object Label13: TLabel
        Left = 436
        Top = 115
        Width = 69
        Height = 15
        Caption = #1587#1662#1587' '#1578#1575' '#1587#1575#1593#1578' :'
      end
      object Label5: TLabel
        Left = 436
        Top = 83
        Width = 69
        Height = 15
        Caption = #1587#1662#1587' '#1578#1575' '#1587#1575#1593#1578' :'
      end
      object Label8: TLabel
        Left = 408
        Top = 54
        Width = 97
        Height = 15
        Caption = #1575#1586' '#1606#1610#1605#1607' '#1588#1576' '#1578#1575' '#1587#1575#1593#1578' :'
      end
      object Label4: TLabel
        Left = 436
        Top = 141
        Width = 69
        Height = 15
        Caption = #1587#1662#1587' '#1578#1575' '#1587#1575#1593#1578' :'
      end
      object Label9: TLabel
        Left = 319
        Top = 141
        Width = 16
        Height = 15
        Caption = ' '#1607#1585
        FocusControl = txtFirstTime
      end
      object Label19: TLabel
        Left = 240
        Top = 141
        Width = 18
        Height = 15
        Caption = #1583#1602#1610#1602#1607
      end
      object Label20: TLabel
        Left = 160
        Top = 141
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label21: TLabel
        Left = 399
        Top = 176
        Width = 106
        Height = 15
        Caption = #1606#1585#1582' '#1588#1576#1575#1606#1607' '#1585#1608#1586' '#1576#1607' '#1585#1610#1575#1604' :'
      end
      object chkSecondIsFirst: TCheckBox
        Left = 88
        Top = 80
        Width = 73
        Height = 17
        Caption = #1575#1586' '#1576#1583#1608' '#1608#1585#1608#1583
        TabOrder = 8
        Visible = False
        OnKeyPress = chkSecondIsFirstKeyPress
      end
      object chkLastIsFirst: TCheckBox
        Left = 88
        Top = 144
        Width = 73
        Height = 17
        Caption = #1575#1586' '#1576#1583#1608' '#1608#1585#1608#1583
        TabOrder = 18
        Visible = False
        OnKeyPress = chkLastIsFirstKeyPress
      end
      object chkThirdIsFirst: TCheckBox
        Left = 88
        Top = 112
        Width = 73
        Height = 17
        Caption = #1575#1586' '#1576#1583#1608' '#1608#1585#1608#1583
        TabOrder = 13
        Visible = False
        OnKeyPress = chkThirdIsFirstKeyPress
      end
      object txtVorood: TEdit
        Left = 380
        Top = 18
        Width = 81
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 0
        Text = '1000'
        OnKeyPress = txtVoroodKeyPress
      end
      object txtFirstPrice: TEdit
        Left = 185
        Top = 51
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 3
        Text = '1000'
        OnKeyPress = txtFirstPriceKeyPress
      end
      object txtSecondPrice: TEdit
        Left = 185
        Top = 80
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 7
        Text = '0'
        OnKeyPress = txtSecondPriceKeyPress
      end
      object txtLastPrice: TEdit
        Left = 185
        Top = 138
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 17
        Text = '0'
        OnKeyPress = txtLastPriceKeyPress
      end
      object txtFirstTime1: TEdit
        Left = 264
        Top = 51
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 4
        ParentBiDiMode = False
        TabOrder = 2
        Text = '60'
        OnKeyPress = txtFirstTime1KeyPress
      end
      object txtSecondTime2: TEdit
        Left = 264
        Top = 80
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 4
        ParentBiDiMode = False
        TabOrder = 6
        Text = '5'
        OnKeyPress = txtSecondTime2KeyPress
      end
      object txtLastTime3: TEdit
        Left = 264
        Top = 138
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 4
        ParentBiDiMode = False
        TabOrder = 16
        Text = '5'
        OnKeyPress = txtLastTime3KeyPress
      end
      object txtFirstTime: TEdit
        Left = 345
        Top = 51
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 6
        ParentBiDiMode = False
        TabOrder = 1
        Text = '23:59'
        OnKeyPress = txtFirstTimeKeyPress
      end
      object txtSecondTime: TEdit
        Left = 345
        Top = 80
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 6
        ParentBiDiMode = False
        TabOrder = 5
        Text = '23:59'
        OnKeyPress = txtSecondTimeKeyPress
      end
      object txtLastTime: TEdit
        Left = 345
        Top = 138
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 6
        ParentBiDiMode = False
        TabOrder = 15
        Text = '23:59'
        OnKeyPress = txtLastTimeKeyPress
      end
      object txtThirdTime: TEdit
        Left = 345
        Top = 109
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 6
        ParentBiDiMode = False
        TabOrder = 10
        Text = '23:59'
        OnKeyPress = txtThirdTimeKeyPress
      end
      object txtThirdTime3: TEdit
        Left = 264
        Top = 109
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 4
        ParentBiDiMode = False
        TabOrder = 11
        Text = '5'
        OnKeyPress = txtThirdTime3KeyPress
      end
      object txtThirdPrice: TEdit
        Left = 185
        Top = 109
        Width = 49
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 12
        Text = '0'
        OnKeyPress = txtThirdPriceKeyPress
      end
      object txtdailyprice: TEdit
        Left = 320
        Top = 173
        Width = 73
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 20
        Text = '20000'
        OnKeyPress = txtdailypriceKeyPress
      end
      object cmbFirstRounding: TComboBox
        Left = 8
        Top = 51
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        ItemIndex = 2
        TabOrder = 4
        Text = #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575
        OnKeyPress = cmbFirstRoundingKeyPress
        Items.Strings = (
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1662#1575#1610#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1606#1586#1583#1610#1603#1578#1585#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575)
      end
      object cmbThirdRounding: TComboBox
        Left = 8
        Top = 109
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        ItemIndex = 2
        TabOrder = 14
        Text = #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575
        OnKeyPress = cmbThirdRoundingKeyPress
        Items.Strings = (
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1662#1575#1610#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1606#1586#1583#1610#1603#1578#1585#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575)
      end
      object cmbLastRounding: TComboBox
        Left = 8
        Top = 138
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        ItemIndex = 2
        TabOrder = 19
        Text = #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575
        OnKeyPress = cmbLastRoundingKeyPress
        Items.Strings = (
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1662#1575#1610#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1606#1586#1583#1610#1603#1578#1585#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575)
      end
      object cmbSecondRounding: TComboBox
        Left = 8
        Top = 80
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        ItemIndex = 2
        TabOrder = 9
        Text = #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575
        OnKeyPress = cmbSecondRoundingKeyPress
        Items.Strings = (
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1662#1575#1610#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1606#1586#1583#1610#1603#1578#1585#1610#1606
          #1711#1585#1583' '#1603#1585#1583#1606' '#1576#1607' '#1576#1575#1604#1575)
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 408
    Width = 527
    Height = 19
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 
          #1575#1586' '#1591#1585#1610#1602' '#1575#1610#1606' '#1601#1585#1605' '#1605#1610#1578#1608#1575#1606#1610#1583' '#1575#1606#1608#1575#1593' '#1582#1608#1583#1585#1608' '#1608' '#1606#1585#1582' '#1711#1584#1575#1585#1610' '#1605#1585#1576#1608#1591' '#1576#1607' '#1607#1585' '#1705#1583#1575 +
          #1605' '#1585#1575' '#1575#1593#1605#1575#1604' '#1606#1605#1575#1610#1610#1583'.'
        Width = 50
      end>
  end
  object dtaTypes: TDataSource
    DataSet = tblTypes
    Left = 464
    Top = 72
  end
  object tblTypes: TADOTable
    TableName = 'CarTypes'
    Left = 400
    Top = 72
    object tblTypesType_Code: TSmallintField
      Alignment = taCenter
      DisplayLabel = '             '#1603#1583' '#1606#1608#1593
      DisplayWidth = 18
      FieldName = 'Type_Code'
    end
    object tblTypesType_Name: TStringField
      DisplayLabel = '                   '#1606#1608#1593' '#1582#1608#1583#1585#1608
      DisplayWidth = 30
      FieldName = 'Type_Name'
      Size = 15
    end
    object tblTypesType_Vorood: TCurrencyField
      FieldName = 'Type_Vorood'
      Visible = False
    end
    object tblTypesType_FirstTime: TIntegerField
      FieldName = 'Type_FirstTime'
      Visible = False
    end
    object tblTypesType_FirstTime1: TSmallintField
      FieldName = 'Type_FirstTime1'
      Visible = False
    end
    object tblTypesType_FirstPrice: TCurrencyField
      FieldName = 'Type_FirstPrice'
      Visible = False
    end
    object tblTypesType_SecondTime: TIntegerField
      FieldName = 'Type_SecondTime'
      Visible = False
    end
    object tblTypesType_SecondTime2: TSmallintField
      FieldName = 'Type_SecondTime2'
      Visible = False
    end
    object tblTypesType_SecondPrice: TCurrencyField
      FieldName = 'Type_SecondPrice'
      Visible = False
    end
    object tblTypesType_LastTime: TIntegerField
      FieldName = 'Type_LastTime'
      Visible = False
    end
    object tblTypesType_LastTime3: TSmallintField
      FieldName = 'Type_LastTime3'
      Visible = False
    end
    object tblTypesType_LastPrice: TCurrencyField
      FieldName = 'Type_LastPrice'
      Visible = False
    end
    object tblTypesType_FirstRounding: TSmallintField
      FieldName = 'Type_FirstRounding'
      Visible = False
    end
    object tblTypesType_SecondIsFirst: TBooleanField
      FieldName = 'Type_SecondIsFirst'
      Visible = False
    end
    object tblTypesType_SecondRounding: TSmallintField
      FieldName = 'Type_SecondRounding'
      Visible = False
    end
    object tblTypesType_LastIsFirst: TBooleanField
      FieldName = 'Type_LastIsFirst'
      Visible = False
    end
    object tblTypesType_LastRounding: TSmallintField
      FieldName = 'Type_LastRounding'
      Visible = False
    end
    object tblTypesType_ThirdTime: TIntegerField
      FieldName = 'Type_ThirdTime'
      Visible = False
    end
    object tblTypesType_ThirdTime3: TSmallintField
      FieldName = 'Type_ThirdTime3'
      Visible = False
    end
    object tblTypesType_ThirdIsFirst: TBooleanField
      FieldName = 'Type_ThirdIsFirst'
      Visible = False
    end
    object tblTypesType_ThirdRounding: TSmallintField
      FieldName = 'Type_ThirdRounding'
      Visible = False
    end
    object tblTypesType_ThirdPrice: TCurrencyField
      FieldName = 'Type_ThirdPrice'
      Visible = False
    end
    object tblTypesType_DailyPrice: TCurrencyField
      FieldName = 'Type_DailyPrice'
      Visible = False
    end
  end
end
