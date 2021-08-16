object frmRelations: TfrmRelations
  Left = 27
  Top = 99
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 238
  ClientWidth = 567
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
  object lblDate: TLabel
    Left = 460
    Top = 176
    Width = 22
    Height = 15
    Caption = '&'#1578#1575#1585#1610#1582
    FocusControl = txtDate
  end
  object lblTime: TLabel
    Left = 234
    Top = 176
    Width = 21
    Height = 15
    Caption = '&'#1586#1605#1575#1606
  end
  object pnlTitle: TPanel
    Left = 8
    Top = 8
    Width = 329
    Height = 25
    TabOrder = 7
  end
  object dbgReaders: TDBGrid
    Left = 345
    Top = 8
    Width = 216
    Height = 161
    DataSource = dtaReaders
    TabOrder = 0
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnDblClick = dbgReadersDblClick
    OnKeyDown = dbgReadersKeyDown
  end
  object cmdTic: TBitBtn
    Left = 456
    Top = 209
    Width = 105
    Height = 24
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
    Left = 8
    Top = 209
    Width = 105
    Height = 24
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 12
    Kind = bkClose
  end
  object mmoResult: TMemo
    Left = 8
    Top = 32
    Width = 329
    Height = 137
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 2
  end
  object cmdRun: TBitBtn
    Left = 232
    Top = 209
    Width = 113
    Height = 24
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
  object Panel1: TPanel
    Left = 112
    Top = 112
    Width = 337
    Height = 57
    Color = clGreen
    TabOrder = 3
    Visible = False
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 305
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Label1'
      Color = clGreen
      Font.Charset = ARABIC_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 305
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Label2'
      Color = clGreen
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object txtDate: TEdit
    Left = 345
    Top = 176
    Width = 104
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 4
    OnKeyPress = txtDateKeyPress
  end
  object cmdHelp: TBitBtn
    Left = 120
    Top = 209
    Width = 106
    Height = 24
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 11
    Kind = bkHelp
  end
  object lst: TListBox
    Left = 32
    Top = 8
    Width = 105
    Height = 25
    Columns = 2
    ItemHeight = 15
    MultiSelect = True
    TabOrder = 1
    Visible = False
  end
  object chkOnLine: TCheckBox
    Left = 272
    Top = 176
    Width = 65
    Height = 17
    Alignment = taLeftJustify
    BiDiMode = bdRightToLeftNoAlign
    Caption = 'OnLine'
    Checked = True
    ParentBiDiMode = False
    State = cbChecked
    TabOrder = 6
    Visible = False
  end
  object cmdInvert: TBitBtn
    Left = 352
    Top = 209
    Width = 97
    Height = 24
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
  object txtTime: TEdit
    Left = 144
    Top = 176
    Width = 82
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 5
    OnKeyPress = txtTimeKeyPress
  end
  object dtaReaders: TDataSource
    DataSet = qryReaders
    Left = 400
    Top = 48
  end
  object qryReaders: TADOQuery
    OnCalcFields = qryReadersCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Readers'
      'WHERE R_Active = True')
    Left = 344
    Top = 48
    object qryReadersTic: TStringField
      Alignment = taCenter
      DisplayLabel = #8207
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'Tic'
      Size = 1
      Calculated = True
    end
    object qryReadersR_Name: TStringField
      DisplayLabel = '          '#1606#1575#1605' '#1603#1606#1578#1585#1604#1711#1585
      FieldName = 'R_Name'
      Origin = '"Readers.DB".R_Name'
    end
    object qryReadersR_Code: TSmallintField
      FieldName = 'R_Code'
      Origin = '"Readers.DB".R_Code'
      Visible = False
    end
    object qryReadersR_Active: TBooleanField
      FieldName = 'R_Active'
      Origin = '"Readers.DB".R_Active'
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
    object qryReadersR_OnLine: TBooleanField
      FieldName = 'R_OnLine'
      Origin = '"Readers.DB".R_Code'
      Visible = False
    end
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 32
    Top = 168
  end
end
