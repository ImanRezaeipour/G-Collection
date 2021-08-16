object frmCars: TfrmCars
  Left = 103
  Top = 37
  HelpContext = 104
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1593#1610#1610#1606' '#1606#1575#1605' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 337
  ClientWidth = 393
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
    Width = 393
    Height = 234
    Align = alTop
    TabOrder = 0
    DesignSize = (
      393
      234)
    object Label3: TLabel
      Left = 328
      Top = 17
      Width = 57
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608'&'#1593' '#1582#1608#1583#1585#1608' :'
      FocusControl = cmbTypeCode
      ExplicitLeft = 289
    end
    object Label4: TLabel
      Left = 306
      Top = 56
      Width = 79
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1580'&'#1587#1578#1580#1608#1610' '#1582#1608#1583#1585#1608' :'
      FocusControl = txtSearch
      ExplicitLeft = 267
    end
    object Bevel1: TBevel
      Left = 2
      Top = 42
      Width = 353
      Height = 5
      Shape = bsTopLine
    end
    object dbgCars: TDBGrid
      Left = 99
      Top = 82
      Width = 286
      Height = 145
      Anchors = [akTop, akRight]
      DataSource = dtaCars
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDrawColumnCell = dbgCarsDrawColumnCell
      OnKeyDown = dbgCarsKeyDown
      OnMouseMove = dbgCarsMouseMove
      OnTitleClick = dbgCarsTitleClick
    end
    object cmdNew: TBitBtn
      Left = 7
      Top = 82
      Width = 86
      Height = 22
      Caption = #1582#1608#1583#1585#1608' &'#1580#1583#1610#1583
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
      Left = 7
      Top = 110
      Width = 86
      Height = 22
      Caption = #1575'&'#1589#1604#1575#1581' '#1582#1608#1583#1585#1608
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
      Left = 7
      Top = 138
      Width = 86
      Height = 22
      Caption = '&'#1581#1584#1601' '#1582#1608#1583#1585#1608
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
      Left = 7
      Top = 176
      Width = 86
      Height = 23
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 7
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 7
      Top = 205
      Width = 86
      Height = 22
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 8
      Kind = bkClose
    end
    object cmbTypeCode: TComboBox
      Left = 243
      Top = 14
      Width = 79
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 0
      OnClick = cmbTypeCodeClick
      OnKeyPress = cmbTypeCodeKeyPress
    end
    object cmbTypeName: TComboBox
      Left = 77
      Top = 14
      Width = 160
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 1
      OnClick = cmbTypeNameClick
      OnKeyPress = cmbTypeCodeKeyPress
    end
    object txtSearch: TEdit
      Left = 99
      Top = 53
      Width = 201
      Height = 23
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnChange = txtSearchChange
      OnKeyPress = txtSearchKeyPress
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 234
    Width = 393
    Height = 85
    Align = alTop
    TabOrder = 1
    DesignSize = (
      393
      85)
    object Label1: TLabel
      Left = 334
      Top = 24
      Width = 51
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1606#1575#1605' '#1582#1608#1583#1585#1608' :'
      FocusControl = txtName
    end
    object Label2: TLabel
      Left = 99
      Top = 24
      Width = 38
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1575#1608'&'#1604#1608#1610#1578' :'
      FocusControl = txtCode
    end
    object txtName: TEdit
      Left = 143
      Top = 21
      Width = 185
      Height = 23
      Anchors = [akTop, akRight]
      MaxLength = 15
      TabOrder = 0
      OnKeyPress = txtNameKeyPress
    end
    object txtCode: TEdit
      Left = 7
      Top = 21
      Width = 86
      Height = 23
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtCodeKeyPress
    end
    object cmdSave: TBitBtn
      Left = 299
      Top = 55
      Width = 86
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '&'#1579#1576#1578
      TabOrder = 2
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
      Top = 55
      Width = 86
      Height = 23
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 3
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
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 318
    Width = 393
    Height = 19
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 
          #1575#1586' '#1591#1585#1610#1602' '#1575#1610#1606' '#1601#1585#1605' '#1605#1610#1578#1608#1575#1606#1610#1583' '#1606#1575#1605' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1607#1585' '#1705#1583#1575#1605' '#1575#1586' '#1575#1606#1608#1575#1593' '#1582#1608#1583#1585#1608' '#1585#1575' ' +
          #1578#1593#1610#1610#1606' '#1606#1605#1575#1610#1610#1583'.'
        Width = 50
      end>
  end
  object dtaCars: TDataSource
    DataSet = tblCars
    Left = 312
    Top = 120
  end
  object tblCars: TADOTable
    IndexFieldNames = 'Car_Name'
    TableName = 'Cars'
    Left = 248
    Top = 120
    object tblCarsCar_Name: TStringField
      DisplayLabel = '             '#1606#1575#1605' '#1582#1608#1583#1585#1608
      DisplayWidth = 24
      FieldName = 'Car_Name'
      Size = 15
    end
    object tblCarsCar_Code: TSmallintField
      Alignment = taCenter
      DisplayLabel = '  '#1603#1583' '#1575#1608#1604#1608#1610#1578
      FieldName = 'Car_Code'
    end
    object tblCarsCar_Type: TSmallintField
      FieldName = 'Car_Type'
      Visible = False
    end
  end
end
