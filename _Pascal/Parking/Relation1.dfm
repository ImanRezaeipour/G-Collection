object frmRelations: TfrmRelations
  Left = 40
  Top = 101
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607#1607#1575#1610' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 210
  ClientWidth = 502
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
  object lblDate: TLabel
    Left = 368
    Top = 155
    Width = 22
    Height = 15
    Caption = '&'#1578#1575#1585#1610#1582
    FocusControl = txtDate
  end
  object lblTime: TLabel
    Left = 218
    Top = 155
    Width = 21
    Height = 15
    Caption = '&'#1586#1605#1575#1606
    FocusControl = txtTime
  end
  object lblMessage: TLabel
    Left = 469
    Top = 155
    Width = 18
    Height = 15
    Caption = #1662#1610#1594'&'#1575#1605
  end
  object dbgCUnit: TDBGrid
    Left = 304
    Top = 7
    Width = 191
    Height = 142
    DataSource = dtaReaders
    TabOrder = 0
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnDblClick = dbgCUnitDblClick
    OnKeyDown = dbgCUnitKeyDown
  end
  object cmdTic: TBitBtn
    Left = 409
    Top = 184
    Width = 86
    Height = 22
    Caption = #1575'&'#1606#1578#1582#1575#1576
    Default = True
    TabOrder = 8
    OnClick = cmdTicClick
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
  object cmdExit: TBitBtn
    Left = 7
    Top = 184
    Width = 86
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 12
    Kind = bkClose
  end
  object mmoResult: TMemo
    Left = 7
    Top = 28
    Width = 290
    Height = 121
    TabOrder = 3
  end
  object cmdRun: TBitBtn
    Left = 198
    Top = 184
    Width = 106
    Height = 22
    Caption = #1578#1587#1578' '#1575#1585#1578#1576#1575#1591
    TabOrder = 10
    OnClick = cmdRunClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000333300
      0000377777F3337777770FFFF099990FFFF07FFFF7FFFF7FFFF7000000999900
      00007777777777777777307703399330770337FF7F37F337FF7F300003399330
      000337777337F337777333333339933333333FFFFFF7F33FFFFF000000399300
      0000777777F7F37777770FFFF099990FFFF07FFFF7F7FF7FFFF7000000999900
      00007777777777777777307703399330770337FF7F37F337FF7F300003399330
      0003377773F7FFF77773333330000003333333333777777F3333333330FFFF03
      3333333337FFFF7F333333333000000333333333377777733333333333077033
      33333333337FF7F3333333333300003333333333337777333333}
    NumGlyphs = 2
  end
  object pnlMsg: TPanel
    Left = 120
    Top = 99
    Width = 241
    Height = 50
    Color = clGreen
    TabOrder = 4
    Visible = False
    object lblMsg1: TLabel
      Left = 14
      Top = 7
      Width = 213
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblMsg1'
      Color = clGreen
      Font.Charset = ARABIC_CHARSET
      Font.Color = clYellow
      Font.Height = -12
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblMsg2: TLabel
      Left = 14
      Top = 28
      Width = 213
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblMsg2'
      Color = clGreen
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object txtDate: TEdit
    Left = 275
    Top = 155
    Width = 86
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 6
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TMaskEdit
    Left = 141
    Top = 155
    Width = 72
    Height = 23
    BiDiMode = bdLeftToRight
    EditMask = '99:99:99;1;_'
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 7
    Text = '00:00:00'
    OnKeyPress = txtTimeKeyPress
  end
  object cmdHelp: TBitBtn
    Left = 99
    Top = 184
    Width = 85
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 11
    Kind = bkHelp
  end
  object txtMessage: TEdit
    Left = 416
    Top = 155
    Width = 44
    Height = 23
    MaxLength = 64
    TabOrder = 5
  end
  object lst: TListBox
    Left = 247
    Top = 42
    Width = 93
    Height = 22
    Columns = 2
    ItemHeight = 15
    MultiSelect = True
    TabOrder = 2
    Visible = False
  end
  object pnlTitle: TPanel
    Left = 7
    Top = 7
    Width = 290
    Height = 22
    TabOrder = 1
  end
  object cmdInvert: TBitBtn
    Left = 318
    Top = 184
    Width = 85
    Height = 22
    Caption = '&'#1605#1593#1603#1608#1587
    TabOrder = 9
    OnClick = cmdInvertClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
      33333333333F8888883F33330000324334222222443333388F3833333388F333
      000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
      F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
      223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
      3338888300003AAAAAAA33333333333888888833333333330000333333333333
      333333333333333333FFFFFF000033333333333344444433FFFF333333888888
      00003A444333333A22222438888F333338F3333800003A2243333333A2222438
      F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
      22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
      33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object dtaReaders: TDataSource
    DataSet = qryReaders
    Left = 248
    Top = 64
  end
  object qryReaders: TAdoQuery
    OnCalcFields = qryReadersCalcFields
    SQL.Strings = (
      'SELECT * FROM Readers'
      'WHERE R_Active = True')
    Left = 192
    Top = 64
    object qryReadersR_Name: TStringField
      DisplayLabel = '          '#1606#1575#1605' '#1603#1606#1578#1585#1604#1711#1585
      FieldName = 'R_Name'
      Origin = '"Readers.DB".R_Name'
    end
    object qryReadersTic: TStringField
      Alignment = taCenter
      DisplayLabel = #8207
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'Tic'
      Size = 1
      Calculated = True
    end
    object qryReadersR_Code: TSmallintField
      FieldName = 'R_Code'
      Origin = '"Readers.DB".R_Code'
      Visible = False
    end
    object qryReadersR_Port: TSmallintField
      FieldName = 'R_Port'
      Origin = '"Readers.DB".R_Port'
      Visible = False
    end
    object qryReadersR_BaudNo: TSmallintField
      FieldName = 'R_BaudNo'
      Origin = '"Readers.DB".R_BaudNo'
      Visible = False
    end
    object qryReadersR_Active: TStringField
      FieldName = 'R_Active'
      Size = 1
    end
    object qryReadersR_IP: TStringField
      FieldName = 'R_IP'
      Size = 15
    end
    object qryReadersR_TCP: TBooleanField
      FieldName = 'R_TCP'
    end
    object qryReadersR_IsCOM: TBooleanField
      FieldName = 'R_IsCOM'
    end
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 32
    Top = 168
  end
end
