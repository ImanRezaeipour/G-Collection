object frmUsers: TfrmUsers
  Left = 477
  Top = 93
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1593#1585#1610#1601' '#1603#1575#1585#1576#1585#1575#1606
  ClientHeight = 449
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlSecurity: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 151
    Align = alTop
    TabOrder = 0
    object dbgSecurity: TDBGrid
      Left = 8
      Top = 8
      Width = 385
      Height = 138
      DataSource = dtaSecurity
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1587#1591#1608#1581' '#1583#1587#1578#1585#1587#1610
          Width = 351
          Visible = True
        end>
    end
  end
  object pnlUsers: TPanel
    Left = 0
    Top = 151
    Width = 400
    Height = 145
    Align = alTop
    TabOrder = 1
    object dbgUsers: TDBGrid
      Left = 128
      Top = 8
      Width = 265
      Height = 130
      DataSource = dtaUsers
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'UserName'
          Title.Alignment = taCenter
          Title.Caption = #1705#1575#1585#1576#1585#1575#1606
          Width = 230
          Visible = True
        end>
    end
    object cmdAdd: TBitBtn
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Caption = #1603#1575#1585#1576#1585' &'#1580#1583#1610#1583
      TabOrder = 1
      OnClick = cmdAddClick
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
      Top = 35
      Width = 105
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1603#1575#1585#1576#1585
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
      Top = 62
      Width = 105
      Height = 25
      Caption = '&'#1581#1584#1601' '#1603#1575#1585#1576#1585
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
      Top = 89
      Width = 105
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
    object cmdExit: TBitBtn
      Left = 8
      Top = 116
      Width = 105
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
  end
  object pnlEdit: TPanel
    Left = 0
    Top = 296
    Width = 400
    Height = 152
    Align = alTop
    TabOrder = 2
    object lbl1: TLabel
      Left = 349
      Top = 14
      Width = 37
      Height = 15
      Caption = '&'#1606#1575#1605' '#1603#1575#1585#1576#1585
      FocusControl = txtUserName
    end
    object lbl2: TLabel
      Left = 125
      Top = 14
      Width = 44
      Height = 15
      Caption = #1603#1604#1605#1607' &'#1593#1576#1608#1585
      FocusControl = txtUserPassword
    end
    object Bevel1: TBevel
      Left = -1
      Top = 46
      Width = 401
      Height = 4
      Shape = bsBottomLine
    end
    object lbl4: TLabel
      Left = 326
      Top = 41
      Width = 63
      Height = 15
      Caption = #1605#1580#1608#1586' '#1583#1587#1578#1585#1587#1610
    end
    object Bevel2: TBevel
      Left = -1
      Top = 115
      Width = 401
      Height = 4
      Shape = bsBottomLine
    end
    object cmdSave: TBitBtn
      Left = 269
      Top = 123
      Width = 121
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 0
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
      Top = 123
      Width = 121
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 1
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
    object txtUserName: TEdit
      Left = 191
      Top = 10
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 2
    end
    object txtUserPassword: TEdit
      Left = 16
      Top = 10
      Width = 105
      Height = 24
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 15
      ParentBiDiMode = False
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object chkEntery: TCheckBox
      Left = 239
      Top = 78
      Width = 121
      Height = 17
      Caption = #1575#1580#1575#1586#1607' '#1608#1585#1608#1583' '#1576#1607' &'#1587#1610#1587#1578#1605
      TabOrder = 4
    end
    object chkPrint: TCheckBox
      Left = 42
      Top = 78
      Width = 113
      Height = 17
      Caption = #1575#1580#1575#1586#1607' &'#1670#1575#1662' '#1711#1586#1575#1585#1588#1575#1578
      TabOrder = 5
    end
  end
  object adoTblSecurity: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Initial Catalog=Clock;Data Source=notebook'
    CursorType = ctStatic
    TableName = 'Security'
    Left = 272
    Top = 64
  end
  object dtaSecurity: TDataSource
    DataSet = adoTblSecurity
    Left = 328
    Top = 64
  end
  object adoTblUsers: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Initial Catalog=Clock;Data Source=notebook'
    CursorType = ctStatic
    IndexFieldNames = 'SecurityCode'
    MasterFields = 'Code'
    MasterSource = dtaSecurity
    TableName = 'users'
    Left = 272
    Top = 240
  end
  object dtaUsers: TDataSource
    DataSet = adoTblUsers
    Left = 328
    Top = 240
  end
  object adoQry: TADOQuery
    Parameters = <>
    Left = 136
    Top = 16
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
