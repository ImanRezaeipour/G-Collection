object frmRejim: TfrmRejim
  Left = 71
  Top = 47
  HelpContext = 104
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1662#1585#1587#1606#1604' '#1585#1688#1610#1605#1610
  ClientHeight = 329
  ClientWidth = 415
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
    Width = 415
    Height = 185
    Align = alTop
    TabOrder = 0
    object dbgRejim: TDBGrid
      Left = 112
      Top = 16
      Width = 297
      Height = 157
      DataSource = dtaRejim
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnKeyDown = dbgRejimKeyDown
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 16
      Width = 97
      Height = 25
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
    object cmdDelete: TBitBtn
      Left = 8
      Top = 48
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601
      TabOrder = 2
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
      Top = 112
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 3
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 144
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 4
      Kind = bkClose
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 185
    Width = 415
    Height = 96
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 315
      Top = 10
      Width = 59
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = cmbPersonCode
    end
    object Label2: TLabel
      Left = 120
      Top = 10
      Width = 78
      Height = 15
      Caption = '&'#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
      FocusControl = cmbPersonName
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 64
      Width = 97
      Height = 25
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
    object cmdSave: TBitBtn
      Left = 312
      Top = 64
      Width = 97
      Height = 25
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
    object cmbPersonCode: TComboBox
      Left = 272
      Top = 32
      Width = 137
      Height = 23
      ItemHeight = 0
      TabOrder = 0
      OnClick = cmbPersonCodeClick
      OnExit = cmbPersonCodeExit
      OnKeyPress = cmbPersonCodeKeyPress
    end
    object cmbPersonName: TComboBox
      Left = 8
      Top = 32
      Width = 257
      Height = 23
      ItemHeight = 0
      TabOrder = 1
      OnClick = cmbPersonNameClick
      OnExit = cmbPersonNameExit
      OnKeyPress = cmbPersonCodeKeyPress
    end
  end
  object dtaRejim: TDataSource
    DataSet = tblRejim
    Left = 256
    Top = 48
  end
  object tblRejim: TADOQuery
    OnCalcFields = tblRejimCalcFields
    Parameters = <>
    Left = 216
    Top = 48
    object tblRejimPCode: TStringField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FieldKind = fkCalculated
      FieldName = 'PCode'
      Size = 8
      Calculated = True
    end
    object tblRejimNames: TStringField
      DisplayLabel = '         '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
      DisplayWidth = 26
      FieldKind = fkCalculated
      FieldName = 'Names'
      Size = 50
      Calculated = True
    end
    object tblRejimP_BarCode: TStringField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FieldName = 'P_BarCode'
      Visible = False
      Size = 8
    end
    object tblRejimP_Family: TStringField
      DisplayLabel = '         '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
      DisplayWidth = 20
      FieldName = 'P_Family'
      Visible = False
      Size = 15
    end
    object tblRejimP_Name: TStringField
      FieldName = 'P_Name'
      Visible = False
      Size = 15
    end
    object tblRejimP_Rejim: TBooleanField
      FieldName = 'P_Rejim'
      Visible = False
    end
  end
  object tblPerson: TADOTable
    TableName = 'Persons'
    Left = 176
    Top = 225
  end
end
