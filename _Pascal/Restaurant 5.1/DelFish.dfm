object frmDelFish: TfrmDelFish
  Left = 155
  Top = 49
  HelpContext = 208
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1581#1584#1601' '#1601#1610#1588#1607#1575#1610' '#1589#1575#1583#1585' '#1588#1583#1607
  ClientHeight = 363
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 326
    Top = 8
    Width = 50
    Height = 15
    Caption = #1608'&'#1593#1583#1607' '#1594#1584#1575#1610#1610
    FocusControl = cmbType
  end
  object Label2: TLabel
    Left = 128
    Top = 8
    Width = 22
    Height = 15
    Caption = '&'#1578#1575#1585#1610#1582
    FocusControl = txtDate
  end
  object Label3: TLabel
    Left = 328
    Top = 48
    Width = 46
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1601#1610#1588
    FocusControl = txtFishNo
  end
  object Label4: TLabel
    Left = 139
    Top = 48
    Width = 59
    Height = 15
    Caption = #1588#1605#1575#1585#1607' &'#1662#1585#1587#1606#1604#1610
    FocusControl = txtPCode
  end
  object lblRecCount: TLabel
    Left = 306
    Top = 312
    Width = 68
    Height = 15
    Caption = 'lblRecCount'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmbType: TComboBox
    Left = 208
    Top = 8
    Width = 105
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnClick = cmbTypeClick
    OnKeyPress = cmbTypeKeyPress
  end
  object txtDate: TEdit
    Left = 8
    Top = 8
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnClick = cmbTypeClick
    OnExit = txtDateExit
    OnKeyPress = txtDateKeyPress
  end
  object txtFishNo: TEdit
    Left = 208
    Top = 48
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnChange = cmbTypeClick
    OnKeyPress = cmbTypeKeyPress
  end
  object dbgFish: TDBGrid
    Left = 7
    Top = 81
    Width = 369
    Height = 225
    DataSource = dtaFish
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnKeyPress = cmbTypeKeyPress
  end
  object cmdDel: TBitBtn
    Left = 288
    Top = 336
    Width = 91
    Height = 25
    Caption = '&'#1581#1584#1601
    TabOrder = 5
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
  object cmdHelp: TBitBtn
    Left = 152
    Top = 336
    Width = 91
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 6
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 336
    Width = 91
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 7
    Kind = bkClose
  end
  object txtPCode: TEdit
    Left = 8
    Top = 48
    Width = 121
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    OnChange = cmbTypeClick
    OnKeyPress = cmbTypeKeyPress
  end
  object dtaFish: TDataSource
    DataSet = tblFish
    Left = 64
    Top = 120
  end
  object tblFish: TADOTable
    OnCalcFields = tblFishCalcFields
    TableName = 'Fish'
    Left = 16
    Top = 120
    object tblFishFish_Date: TStringField
      FieldName = 'Fish_Date'
      Visible = False
      Size = 10
    end
    object tblFishFish_Type: TSmallintField
      FieldName = 'Fish_Type'
      Visible = False
    end
    object tblFishFish_No: TSmallintField
      Alignment = taCenter
      DisplayLabel = ' '#1588#1605#1575#1585#1607' '#1601#1610#1588
      DisplayWidth = 10
      FieldName = 'Fish_No'
    end
    object tblFishFish_PCode: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FieldName = 'Fish_PCode'
      Visible = False
      Size = 8
    end
    object tblFishPCode: TStringField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FieldKind = fkCalculated
      FieldName = 'PCode'
      Size = 8
      Calculated = True
    end
    object tblFishName: TStringField
      DisplayLabel = '           '#1606#1575#1605' '#1608' '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
      DisplayWidth = 26
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 50
      Calculated = True
    end
    object tblFishFish_UCode: TSmallintField
      FieldName = 'Fish_UCode'
      Visible = False
    end
  end
end
