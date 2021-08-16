object frmGroups: TfrmGroups
  Left = 180
  Top = 239
  HelpContext = 106
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1593#1585#1610#1601' '#1711#1585#1608#1607#1607#1575#1610' '#1603#1575#1585#1610
  ClientHeight = 403
  ClientWidth = 400
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
    Width = 400
    Height = 209
    Align = alTop
    TabOrder = 0
    object dbgGroups: TDBGrid
      Left = 112
      Top = 16
      Width = 281
      Height = 185
      DataSource = dtaGroups
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgGroupsKeyDown
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 16
      Width = 97
      Height = 25
      Caption = #1711#1585#1608#1607' &'#1580#1583#1610#1583
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
      Caption = #1575'&'#1589#1604#1575#1581' '#1711#1585#1608#1607
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
      Caption = '&'#1581#1584#1601' '#1711#1585#1608#1607
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
      Top = 144
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 5
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 176
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 6
      Kind = bkClose
    end
    object cmdProg: TBitBtn
      Left = 8
      Top = 111
      Width = 97
      Height = 25
      Caption = '&'#1576#1585#1606#1575#1605#1607' '#1585#1610#1586#1610
      TabOrder = 4
      OnClick = cmdProgClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
        555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
        05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
        FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
        FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
        FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
        05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
        555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
        9055575757575757775505050505055505557575757575557555}
      NumGlyphs = 2
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 209
    Width = 400
    Height = 192
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 209
      Top = 16
      Width = 35
      Height = 15
      Caption = '&'#1606#1575#1605' '#1711#1585#1608#1607
      FocusControl = txtName
    end
    object Label2: TLabel
      Left = 354
      Top = 16
      Width = 34
      Height = 15
      Caption = '&'#1603#1583' '#1711#1585#1608#1607
      FocusControl = txtCode
    end
    object txtName: TEdit
      Left = 32
      Top = 16
      Width = 169
      Height = 23
      MaxLength = 15
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 160
      Width = 81
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
    object cmdSave: TBitBtn
      Left = 312
      Top = 160
      Width = 81
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 3
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
    object txtCode: TEdit
      Left = 280
      Top = 16
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 3
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object cmdProgs: TBitBtn
      Left = 160
      Top = 159
      Width = 97
      Height = 25
      Caption = '&'#1576#1585#1606#1575#1605#1607' '#1585#1610#1586#1610
      TabOrder = 4
      OnClick = cmdProgsClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
        555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
        05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
        FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
        FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
        FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
        05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
        555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
        9055575757575757775505050505055505557575757575557555}
      NumGlyphs = 2
    end
    object grp1: TGroupBox
      Left = 32
      Top = 52
      Width = 330
      Height = 97
      Caption = #1586#1605#1575#1606#1607#1575#1610' '#1587#1585#1608' '#1594#1584#1575
      TabOrder = 2
      object lbl1: TLabel
        Left = 235
        Top = 20
        Width = 79
        Height = 15
        Caption = #1589#1576#1581#1575#1606#1607' : '#1575#1586#1587#1575#1593#1578
      end
      object lbl2: TLabel
        Left = 131
        Top = 21
        Width = 6
        Height = 15
        Caption = #1578#1575
      end
      object lbl4: TLabel
        Left = 246
        Top = 44
        Width = 68
        Height = 15
        Caption = #1606#1575#1607#1575#1585' : '#1575#1586#1587#1575#1593#1578
      end
      object lbl5: TLabel
        Left = 131
        Top = 45
        Width = 6
        Height = 15
        Caption = #1578#1575
      end
      object lbl7: TLabel
        Left = 253
        Top = 68
        Width = 61
        Height = 15
        Caption = #1588#1575#1605' : '#1575#1586#1587#1575#1593#1578
      end
      object lbl8: TLabel
        Left = 131
        Top = 68
        Width = 6
        Height = 15
        Caption = #1578#1575
      end
      object txtFromSobh: TEdit
        Left = 156
        Top = 16
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
      object txtToSobh: TEdit
        Left = 44
        Top = 16
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
      object txtFromNahar: TEdit
        Left = 156
        Top = 40
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 2
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
      object txtToNahar: TEdit
        Left = 44
        Top = 40
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 3
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
      object txtFromSham: TEdit
        Left = 156
        Top = 64
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 4
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
      object txtToSham: TEdit
        Left = 44
        Top = 64
        Width = 65
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 5
        OnExit = txtFromSobhExit
        OnKeyPress = txtFromSobhKeyPress
      end
    end
  end
  object dtaGroups: TDataSource
    DataSet = tblGroups
    Left = 304
    Top = 72
  end
  object tblGroups: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=RestERFAN;Data Source=SERVER'
    CursorType = ctStatic
    TableName = 'Groups'
    Left = 248
    Top = 72
    object tblGroupsGrp_Code: TSmallintField
      DisplayLabel = '    '#1603#1583' '#1711#1585#1608#1607
      DisplayWidth = 10
      FieldName = 'Grp_Code'
    end
    object tblGroupsGrp_Name: TStringField
      DisplayLabel = '               '#1606#1575#1605' '#1711#1585#1608#1607
      DisplayWidth = 24
      FieldName = 'Grp_Name'
      Size = 15
    end
    object tblGroupsGrp_FromSobh: TStringField
      FieldName = 'Grp_FromSobh'
      Visible = False
      Size = 5
    end
    object tblGroupsGrp_ToSobh: TStringField
      FieldName = 'Grp_ToSobh'
      Visible = False
      Size = 5
    end
    object tblGroupsGrp_FromNahar: TStringField
      FieldName = 'Grp_FromNahar'
      Visible = False
      Size = 5
    end
    object tblGroupsGrp_ToNahar: TStringField
      FieldName = 'Grp_ToNahar'
      Visible = False
      Size = 5
    end
    object tblGroupsGrp_FromSham: TStringField
      FieldName = 'Grp_FromSham'
      Visible = False
      Size = 5
    end
    object tblGroupsGrp_ToSham: TStringField
      FieldName = 'Grp_ToSham'
      Visible = False
      Size = 5
    end
  end
end
