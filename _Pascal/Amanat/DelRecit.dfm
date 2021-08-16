object frmDelRecit: TfrmDelRecit
  Left = 194
  Top = 61
  HelpContext = 15
  BiDiMode = bdRightToLeft
  BorderStyle = bsSingle
  Caption = #1581#1584#1601' '#1582#1583#1605#1575#1578' '#1575#1585#1575#1574#1607' '#1588#1583#1607
  ClientHeight = 435
  ClientWidth = 492
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpReceipt: TGroupBox
    Left = 0
    Top = 0
    Width = 492
    Height = 60
    Align = alTop
    Caption = #1580#1587#1578#1580#1608
    TabOrder = 0
    object lbl2: TLabel
      Left = 194
      Top = 27
      Width = 29
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '
    end
    object lbl3: TLabel
      Left = 98
      Top = 27
      Width = 22
      Height = 15
      Caption = #1578#1575#1585#1610#1582
    end
    object lbl1: TLabel
      Left = 466
      Top = 24
      Width = 13
      Height = 15
      Caption = #1601#1585#1583
    end
    object txtFishNo: TEdit
      Left = 130
      Top = 23
      Width = 59
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtFishNoExit
    end
    object txtDate: TEdit
      Left = 8
      Top = 23
      Width = 81
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = txtDateExit
    end
    object cmbCardCode: TComboBox
      Left = 352
      Top = 24
      Width = 104
      Height = 23
      BiDiMode = bdLeftToRight
      ItemHeight = 0
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = cmbCardCodeClick
      OnExit = cmbCardCodeExit
    end
    object cmbCardName: TComboBox
      Left = 240
      Top = 24
      Width = 113
      Height = 23
      ItemHeight = 0
      TabOrder = 1
      OnClick = cmbCardNameClick
      OnExit = cmbCardNameExit
      OnKeyPress = cmbCardNameKeyPress
    end
  end
  object grd1: TDBGrid
    Left = 0
    Top = 60
    Width = 492
    Height = 197
    Align = alTop
    DataSource = dta1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Recit1_No'
        Title.Caption = #1588#1605#1575#1585#1607
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Recit1_Date'
        Title.Alignment = taCenter
        Title.Caption = #1578#1575#1585#1610#1582
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Recit1_EmplNo'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FamilyName'
        Title.Alignment = taCenter
        Title.Caption = #1601#1585#1583
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Recit1_TotalPrice'
        Title.Alignment = taCenter
        Title.Caption = #1603#1604' '#1605#1576#1604#1594
        Width = 105
        Visible = True
      end>
  end
  object grd2: TDBGrid
    Left = 0
    Top = 257
    Width = 492
    Height = 145
    Align = alTop
    DataSource = dta2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Recit2_Srvc'
        Title.Alignment = taCenter
        Title.Caption = #1603#1583' '#1582#1583#1605#1575#1578
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Service'
        Title.Alignment = taCenter
        Title.Caption = #1593#1606#1608#1575#1606' '#1582#1583#1605#1575#1578
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Recit2_SrvcNo'
        Title.Alignment = taCenter
        Title.Caption = #1578#1593#1583#1575#1583
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Recit2_Price'
        Title.Alignment = taCenter
        Title.Caption = #1601#1610
        Width = 120
        Visible = True
      end>
  end
  object cmdCancel: TBitBtn
    Left = 8
    Top = 408
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkCancel
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 408
    Width = 89
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdDelAll: TBitBtn
    Left = 304
    Top = 408
    Width = 89
    Height = 25
    Caption = #1581#1584#1601' '#1603#1604#1610
    TabOrder = 5
    Visible = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
      3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
      33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
      33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
      333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
      03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
      33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
      0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
      3333333337FFF7F3333333333000003333333333377777333333}
    NumGlyphs = 2
  end
  object cmdDel: TBitBtn
    Left = 400
    Top = 408
    Width = 89
    Height = 25
    Caption = #1581#1584#1601
    TabOrder = 6
    OnClick = cmdDelClick
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
  object dta1: TDataSource
    DataSet = atbl1
    Left = 136
    Top = 104
  end
  object dta2: TDataSource
    DataSet = atbl2
    Left = 136
    Top = 280
  end
  object atbl1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\PrgOut\Credit1\C' +
      'redit.mdb;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = atbl1CalcFields
    TableName = 'Receipt1'
    Left = 176
    Top = 104
    object atbl1Recit1_Date: TWideStringField
      FieldName = 'Recit1_Date'
      Size = 10
    end
    object atbl1Recit1_No: TIntegerField
      FieldName = 'Recit1_No'
    end
    object atbl1Recit1_EmplNo: TWideStringField
      FieldName = 'Recit1_EmplNo'
      Size = 8
    end
    object atbl1Recit1_Time: TWideStringField
      FieldName = 'Recit1_Time'
      Size = 5
    end
    object atbl1Recit1_Rdr: TIntegerField
      FieldName = 'Recit1_Rdr'
    end
    object atbl1Recit1_TotalPrice: TBCDField
      FieldName = 'Recit1_TotalPrice'
      Precision = 19
    end
    object atbl1Recit1_Credit: TBCDField
      FieldName = 'Recit1_Credit'
      Precision = 19
    end
    object atbl1Recit1_Cash: TBCDField
      FieldName = 'Recit1_Cash'
      Precision = 19
    end
    object atbl1Recit1_PayType: TIntegerField
      FieldName = 'Recit1_PayType'
    end
    object atbl1FamilyName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamilyName'
      Size = 50
      Calculated = True
    end
  end
  object atbl2: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\PrgOut\Credit1\C' +
      'redit.mdb;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = atbl2CalcFields
    IndexFieldNames = 'Recit2_Date;Recit2_No;Recit2_EmplNo'
    MasterFields = 'Recit1_Date;Recit1_No;Recit1_EmplNo'
    MasterSource = dta1
    TableName = 'Receipt2'
    Left = 176
    Top = 280
    object atbl2Recit2_Date: TWideStringField
      FieldName = 'Recit2_Date'
      Size = 10
    end
    object atbl2Recit2_No: TIntegerField
      FieldName = 'Recit2_No'
    end
    object atbl2Recit2_EmplNo: TWideStringField
      FieldName = 'Recit2_EmplNo'
      Size = 8
    end
    object atbl2Recit2_Srvc: TIntegerField
      FieldName = 'Recit2_Srvc'
    end
    object atbl2Recit2_SrvcNo: TIntegerField
      FieldName = 'Recit2_SrvcNo'
    end
    object atbl2Recit2_Price: TBCDField
      FieldName = 'Recit2_Price'
      Precision = 19
    end
    object atbl2Recit2_PrcType: TIntegerField
      FieldName = 'Recit2_PrcType'
    end
    object atbl2Recit2_Time: TWideStringField
      FieldName = 'Recit2_Time'
      Size = 5
    end
    object atbl2Service: TStringField
      FieldKind = fkCalculated
      FieldName = 'Service'
      Size = 40
      Calculated = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
  end
end
