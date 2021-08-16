object frmReaderList: TfrmReaderList
  Left = 71
  Top = 47
  HelpContext = 401
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1583#1587#1578#1711#1575#1607#1607#1575#1610' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 191
  ClientWidth = 449
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
    Width = 449
    Height = 185
    Align = alTop
    TabOrder = 0
    object dbgRdrList: TDBGrid
      Left = 112
      Top = 16
      Width = 329
      Height = 157
      Hint = 'DoublleClick = '#1578#1594#1610#1610#1585' '#1608#1590#1593#1610#1578
      DataSource = dtaRdrList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = dbgRdrListDblClick
      OnKeyDown = dbgRdrListKeyDown
    end
    object cmdNew: TBitBtn
      Left = 9
      Top = 17
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
      Top = 80
      Width = 97
      Height = 25
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
      Left = 8
      Top = 112
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
    object cmdEdit: TBitBtn
      Left = 8
      Top = 48
      Width = 97
      Height = 25
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
  end
  object dtaRdrList: TDataSource
    DataSet = qryRdrList
    Left = 304
    Top = 48
  end
  object qryRdrList: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=RestFalat;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = qryRdrListCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Readers')
    Left = 256
    Top = 48
    object qryRdrListR_Code: TSmallintField
      Alignment = taCenter
      DisplayLabel = '  '#1603#1583' '#1583#1587#1578#1711#1575#1607
      FieldName = 'R_Code'
      Origin = '"Readers.DB".R_Code'
    end
    object qryRdrListR_Name: TStringField
      DisplayLabel = '          '#1606#1575#1605' '#1583#1587#1578#1711#1575#1607
      DisplayWidth = 20
      FieldName = 'R_Name'
      Origin = '"Readers.DB".R_Name'
    end
    object qryRdrListActiveType: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1608#1590#1593#1610#1578
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ActiveType'
      Size = 10
      Calculated = True
    end
    object qryRdrListR_Port: TSmallintField
      FieldName = 'R_Port'
      Origin = '"Readers.DB".R_Port'
      Visible = False
    end
    object qryRdrListR_BaudNo: TSmallintField
      FieldName = 'R_BaudNo'
      Origin = '"Readers.DB".R_BaudNo'
      Visible = False
    end
    object qryRdrListR_Type: TSmallintField
      FieldName = 'R_Type'
      Origin = 'RESTURAN."Readers.DB".R_Type'
      Visible = False
    end
    object qryRdrListR_Active: TBooleanField
      FieldName = 'R_Active'
    end
    object qryRdrListR_OnLine: TBooleanField
      FieldName = 'R_OnLine'
    end
  end
end
