object frmViewClockRecs: TfrmViewClockRecs
  Left = 265
  Top = 368
  HelpContext = 413
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1606#1605#1575#1610#1588' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576
  ClientHeight = 386
  ClientWidth = 353
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 251
    Top = 8
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
  end
  object lblRecNo: TLabel
    Left = 292
    Top = 368
    Width = 50
    Height = 15
    Caption = 'lblRecNo'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtBarCode: TEdit
    Left = 112
    Top = 8
    Width = 121
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 0
    OnKeyPress = txtBarCodeKeyPress
  end
  object dbgRecs: TDBGrid
    Left = 8
    Top = 40
    Width = 337
    Height = 313
    Hint = 'F5 = '#1576#1575#1586#1582#1608#1575#1606#1610' '#1575#1586' '#1576#1575#1606#1603
    DataSource = dtaRecs
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
  end
  object cmdRetry: TBitBtn
    Left = 104
    Top = 360
    Width = 113
    Height = 25
    Caption = '&'#1576#1575#1586#1610#1575#1576#1610' '#1575#1586' '#1587#1575#1593#1578
    TabOrder = 2
    OnClick = cmdRetryClick
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
  object cmdClose: TBitBtn
    Left = 8
    Top = 360
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkClose
  end
  object dtaRecs: TDataSource
    DataSet = tblRecs
    Left = 120
    Top = 104
  end
  object tblRecs: TADOTable
    OnCalcFields = tblRecsCalcFields
    TableName = 'ClckRecs'
    Left = 168
    Top = 104
    object tblRecsPCode: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'PCode'
      Size = 8
      Calculated = True
    end
    object tblRecsClock_BarCode: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 12
      FieldName = 'Clock_BarCode'
      Visible = False
      Size = 8
    end
    object tblRecsClock_Date: TStringField
      Alignment = taCenter
      DisplayLabel = '     '#1578#1575#1585#1610#1582
      FieldName = 'Clock_Date'
      Size = 10
    end
    object tblRecsClock_Time: TStringField
      Alignment = taCenter
      DisplayLabel = '    '#1586#1605#1575#1606
      DisplayWidth = 8
      FieldName = 'Clock_Time'
      Size = 5
    end
    object tblRecsClock_RdrCode: TSmallintField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1578#1585#1605#1610#1606#1575#1604
      FieldName = 'Clock_RdrCode'
    end
  end
  object adoQryRecs: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Initial Catalog=clock;Data Source=NOTEBOOK'
    CursorType = ctStatic
    OnCalcFields = adoQryRecsCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from c138408')
    Left = 168
    Top = 176
    object adoQryRecsPCode: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'PCode'
      Size = 8
      Calculated = True
    end
    object adoQryRecsClock_BarCode: TStringField
      Alignment = taCenter
      DisplayLabel = '   '#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      DisplayWidth = 12
      FieldName = 'Clock_BarCode'
      Visible = False
      Size = 8
    end
    object adoQryRecsClock_Date: TStringField
      Alignment = taCenter
      DisplayLabel = '     '#1578#1575#1585#1610#1582
      FieldName = 'Clock_Date'
      Size = 10
    end
    object adoQryRecsClock_RdrCode: TSmallintField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1578#1585#1605#1610#1606#1575#1604
      FieldName = 'Clock_RdrCode'
    end
    object adoQryRecsClock_Time: TSmallintField
      DisplayLabel = '    '#1586#1605#1575#1606
      DisplayWidth = 1
      FieldName = 'Clock_Time'
      Visible = False
    end
    object adoQryRecsclocktime: TStringField
      DisplayLabel = #1586#1605#1575#1606
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'clocktime'
      Size = 6
      Calculated = True
    end
  end
end
