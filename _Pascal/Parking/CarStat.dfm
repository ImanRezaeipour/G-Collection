object frmCarsStatus: TfrmCarsStatus
  Left = 228
  Top = 103
  BiDiMode = bdRightToLeft
  Caption = #1608#1590#1593#1610#1578' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 406
  ClientWidth = 706
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
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object grpSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 706
    Height = 71
    Align = alTop
    Caption = #1601#1610#1604#1578#1585
    TabOrder = 1
    ExplicitWidth = 523
    DesignSize = (
      706
      71)
    object lbl1: TLabel
      Left = 307
      Top = 45
      Width = 42
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1608#1590#1593#1610#1578' :'
    end
    object lbl2: TLabel
      Left = 89
      Top = 40
      Width = 59
      Height = 15
      Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' :'
      Enabled = False
      Visible = False
    end
    object Label2: TLabel
      Left = 643
      Top = 16
      Width = 58
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1576#1575#1585#1603#1583' :'
    end
    object Label8: TLabel
      Left = 658
      Top = 45
      Width = 43
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1575#1586' '#1578#1575#1585#1610#1582' :'
    end
    object Label5: TLabel
      Left = 459
      Top = 16
      Width = 66
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    end
    object Label12: TLabel
      Left = 485
      Top = 45
      Width = 40
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1578#1575' '#1578#1575#1585#1610#1582' :'
    end
    object Label7: TLabel
      Left = 269
      Top = 16
      Width = 80
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1575#1605' ('#1585#1575#1606#1606#1583#1607'/'#1605#1575#1604#1705') :'
    end
    object cmbSort: TComboBox
      Left = -24
      Top = 37
      Width = 107
      Height = 23
      Style = csDropDownList
      Enabled = False
      ItemHeight = 15
      ItemIndex = 3
      TabOrder = 9
      Text = #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580
      Visible = False
      OnClick = edlblCardCodeExit
      Items.Strings = (
        #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
        #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
        #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1583
        #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580)
    end
    object edlblNumber: TLabeledEdit
      Left = -48
      Top = 8
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      EditLabel.Width = 66
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdRightToLeft
      EditLabel.Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
      EditLabel.ParentBiDiMode = False
      Enabled = False
      LabelPosition = lpRight
      ParentBiDiMode = False
      TabOrder = 1
      Visible = False
      OnExit = edlblCardCodeExit
    end
    object edlblCardCode: TLabeledEdit
      Left = 382
      Top = 3
      Width = 64
      Height = 23
      EditLabel.Width = 60
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdRightToLeft
      EditLabel.Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578' :'
      EditLabel.ParentBiDiMode = False
      Enabled = False
      LabelPosition = lpRight
      TabOrder = 0
      Visible = False
      OnExit = edlblCardCodeExit
    end
    object cmbStatus: TComboBox
      Left = 189
      Top = 42
      Width = 112
      Height = 23
      Hint = #1608#1590#1593#1610#1578' '#1605#1608#1585#1583' '#1606#1592#1585' '#1582#1608#1583' '#1585#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = edlblCardCodeExit
      Items.Strings = (
        #1608#1575#1585#1583' '#1588#1583#1607'+'#1582#1575#1585#1580' '#1588#1583#1607
        #1608#1575#1585#1583' '#1588#1583#1607
        #1582#1575#1585#1580' '#1588#1583#1607
        #1662#1575#1585#1705' '#1588#1583#1607)
    end
    object edlblToDate: TLabeledEdit
      Left = 156
      Top = 61
      Width = 79
      Height = 23
      BiDiMode = bdLeftToRight
      EditLabel.Width = 40
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdRightToLeft
      EditLabel.Caption = #1578#1575' '#1578#1575#1585#1610#1582' :'
      EditLabel.ParentBiDiMode = False
      Enabled = False
      LabelPosition = lpRight
      ParentBiDiMode = False
      TabOrder = 8
      Visible = False
      OnExit = edlblToDateExit
      OnKeyPress = edlblFromDateKeyPress
    end
    object edlblFromDate: TLabeledEdit
      Left = 347
      Top = 58
      Width = 78
      Height = 23
      BiDiMode = bdLeftToRight
      EditLabel.Width = 43
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdRightToLeft
      EditLabel.Caption = #1575#1586' '#1578#1575#1585#1610#1582' :'
      EditLabel.ParentBiDiMode = False
      Enabled = False
      LabelPosition = lpRight
      ParentBiDiMode = False
      TabOrder = 7
      Visible = False
      OnExit = edlblFromDateExit
      OnKeyPress = edlblFromDateKeyPress
    end
    object cmbBarCode: TComboBox
      Left = 531
      Top = 13
      Width = 98
      Height = 23
      Hint = #1588#1605#1575#1585#1607' '#1576#1575#1585#1705#1583' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      ItemHeight = 15
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = cmbBarCodeChange
      OnKeyPress = cmbBarCodeKeyPress
    end
    object txtIDate: TEdit
      Left = 531
      Top = 42
      Width = 98
      Height = 23
      Hint = 'Ctrl + Enter : '#1575#1605#1585#1608#1586
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnExit = txtIDateExit
      OnKeyDown = txtIDateKeyDown
      OnKeyPress = txtIDateKeyPress
      ExplicitLeft = 348
    end
    object txtNumber: TEdit
      Left = 355
      Top = 13
      Width = 98
      Height = 23
      Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      MaxLength = 6
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnExit = txtNumberExit
      OnKeyPress = txtNumberKeyPress
      ExplicitLeft = 172
    end
    object txtODate: TEdit
      Left = 355
      Top = 42
      Width = 98
      Height = 23
      Hint = 'Ctrl + Enter : '#1575#1605#1585#1608#1586
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnExit = txtODateExit
      OnKeyDown = txtODateKeyDown
      OnKeyPress = txtODateKeyPress
      ExplicitLeft = 172
    end
    object cmdCancelFilter: TBitBtn
      Left = 158
      Top = 41
      Width = 25
      Height = 23
      Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      TabStop = False
      OnClick = cmdCancelFilterClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
    end
    object cmbDriver: TComboBox
      Left = 94
      Top = 13
      Width = 169
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnChange = cmbDriverChange
      OnKeyDown = cmbDriverKeyDown
    end
    object cmbDriverCode: TComboBox
      Left = 161
      Top = 16
      Width = 38
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Visible = False
    end
  end
  object dbgMachines: TDBGrid
    Left = 0
    Top = 71
    Width = 706
    Height = 289
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnDrawColumnCell = dbgMachinesDrawColumnCell
    OnMouseMove = dbgMachinesMouseMove
    OnTitleClick = dbgMachinesTitleClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_BarCode'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_Number'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608'('#1587#1585#1610#1575#1604')'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'P_Family_Name'
        Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610'-'#1606#1575#1605
        Width = 163
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_IDate'
        Title.Alignment = taCenter
        Title.Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_ITime'
        Title.Alignment = taCenter
        Title.Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_ODate'
        Title.Alignment = taCenter
        Title.Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'M_OTime'
        Title.Alignment = taCenter
        Title.Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580
        Width = 75
        Visible = True
      end>
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 360
    Width = 706
    Height = 27
    Align = alBottom
    Caption = #1570#1582#1585#1610#1606' '#1608#1590#1593#1610#1578
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 523
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 387
    Width = 706
    Height = 19
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 
          #1575#1586' '#1591#1585#1610#1602' '#1575#1610#1606' '#1601#1585#1605' '#1605#1610#1578#1608#1575#1606#1610#1583' '#1570#1582#1585#1610#1606' '#1608#1590#1593#1610#1578' '#1582#1608#1583#1585#1608#1607#1575' ('#1608#1575#1585#1583' '#1588#1583#1607#1548' '#1582#1575#1585#1580' '#1588#1583#1607 +
          ' '#1608' '#1662#1575#1585#1705' '#1588#1583#1607') '#1585#1575' '#1605#1588#1575#1607#1583#1607' '#1606#1605#1575#1610#1610#1583
        Width = 50
      end>
    ExplicitWidth = 523
  end
  object DataSource1: TDataSource
    DataSet = qryMachines
    Left = 72
    Top = 136
  end
  object qryMachines: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * From Machines')
    Left = 32
    Top = 136
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 32
    Top = 192
  end
end
