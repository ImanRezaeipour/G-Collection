object frmDelete: TfrmDelete
  Left = 11
  Top = 21
  HelpContext = 303
  BiDiMode = bdRightToLeft
  Caption = #1581#1584#1601' '#1585#1603#1608#1585#1583#1607#1575
  ClientHeight = 311
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object grpView: TGroupBox
    Left = 0
    Top = 0
    Width = 631
    Height = 187
    Align = alClient
    TabOrder = 0
    DesignSize = (
      631
      187)
    object GroupBox1: TGroupBox
      Left = 7
      Top = 7
      Width = 111
      Height = 57
      TabOrder = 0
      object rdoArival: TRadioButton
        Left = 3
        Top = 13
        Width = 103
        Height = 15
        Hint = #1606#1605#1575#1610#1588' '#1585#1705#1608#1585#1583#1607#1575#1610' '#1605#1585#1576#1608#1591' '#1576#1607' '#1608#1585#1608#1583' '#1582#1608#1583#1585#1608#1607#1575
        Caption = #1582#1608#1583#1585#1608#1607#1575#1610' &'#1608#1585#1608#1583#1610
        Checked = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
        OnClick = rdoArivalClick
      end
      object rdoExit: TRadioButton
        Left = 3
        Top = 34
        Width = 103
        Height = 15
        Hint = #1606#1605#1575#1610#1588' '#1585#1705#1608#1585#1583#1607#1575#1610' '#1605#1585#1576#1608#1591' '#1576#1607' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575
        Caption = #1582#1608#1583#1585#1608#1607#1575#1610' '#1582'&'#1585#1608#1580#1610
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = rdoArivalClick
      end
    end
    object cmdDelete: TBitBtn
      Left = 7
      Top = 71
      Width = 111
      Height = 22
      Hint = #1581#1584#1601' '#1585#1705#1608#1585#1583' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1607
      Caption = '&'#1581#1584#1601' '#1585#1603#1608#1585#1583
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
      Left = 7
      Top = 99
      Width = 111
      Height = 22
      Hint = #1585#1575#1607#1606#1605#1575
      HelpContext = 2
      Caption = #1585#1575'&'#1607#1606#1605#1575
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Kind = bkHelp
    end
    object cmdExit: TBitBtn
      Left = 7
      Top = 127
      Width = 111
      Height = 22
      Hint = #1582#1585#1608#1580
      Caption = '&'#1582#1585#1608#1580
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Kind = bkClose
    end
    object Panel1: TPanel
      Left = 124
      Top = 13
      Width = 501
      Height = 167
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
      object dbgDelete: TDBGrid
        Left = 0
        Top = 0
        Width = 501
        Height = 167
        Hint = #1575#1591#1604#1575#1593#1575#1578' '#1605#1585#1576#1608#1591' '#1576#1607' '#1608#1585#1608#1583' '#1582#1608#1583#1585#1608#1607#1575
        Align = alClient
        DataSource = dtaDelete
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = ARABIC_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arabic Transparent'
        TitleFont.Style = []
        OnDrawColumnCell = dbgDeleteDrawColumnCell
        OnMouseMove = dbgDeleteMouseMove
        OnTitleClick = dbgDeleteTitleClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'M_BarCode'
            Title.Alignment = taCenter
            Title.Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'M_Number'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'M_Serial'
            Title.Alignment = taCenter
            Title.Caption = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_IDate'
            Title.Alignment = taCenter
            Title.Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_ITime'
            Title.Alignment = taCenter
            Title.Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_ODate'
            Title.Alignment = taCenter
            Title.Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_OTime'
            Title.Alignment = taCenter
            Title.Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580
            Visible = True
          end>
      end
    end
  end
  object grpSearch: TGroupBox
    Left = 0
    Top = 187
    Width = 631
    Height = 105
    Align = alBottom
    Caption = #1601#1610#1604#1578#1585
    TabOrder = 1
    DesignSize = (
      631
      105)
    object Label15: TLabel
      Left = 13
      Top = 72
      Width = 61
      Height = 15
      Caption = #1605#1578#1589#1583#1610' '#1582#1585#1608#1580
      Enabled = False
      Visible = False
    end
    object Label2: TLabel
      Left = 568
      Top = 20
      Width = 58
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1576#1575#1585#1603#1583' :'
      ExplicitLeft = 474
    end
    object Label3: TLabel
      Left = 202
      Top = 58
      Width = 43
      Height = 15
      Caption = #1606#1575#1605' '#1582#1608#1583#1585#1608
      Enabled = False
      Visible = False
    end
    object Label4: TLabel
      Left = 136
      Top = 75
      Width = 54
      Height = 15
      Caption = #1585#1606#1711' '#1582#1608#1583#1585#1608
      Enabled = False
      Visible = False
    end
    object Label5: TLabel
      Left = 374
      Top = 20
      Width = 66
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
      ExplicitLeft = 280
    end
    object Label6: TLabel
      Left = 194
      Top = 32
      Width = 51
      Height = 15
      Caption = #1588#1607#1585' '#1582#1608#1583#1585#1608
      Enabled = False
      Visible = False
    end
    object Label7: TLabel
      Left = 185
      Top = 20
      Width = 63
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1587#1585#1610#1575#1604' :'
      ExplicitLeft = 91
    end
    object Label8: TLabel
      Left = 570
      Top = 49
      Width = 56
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583' :'
      ExplicitLeft = 476
    end
    object Label9: TLabel
      Left = 385
      Top = 49
      Width = 55
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583' :'
      ExplicitLeft = 291
    end
    object Label10: TLabel
      Left = 24
      Top = 51
      Width = 45
      Height = 15
      Caption = #1583#1585#1576' '#1608#1585#1608#1583
      Enabled = False
      Visible = False
    end
    object Label11: TLabel
      Left = 13
      Top = 37
      Width = 57
      Height = 15
      Caption = #1605#1578#1589#1583#1610' '#1608#1585#1608#1583
      Enabled = False
      Visible = False
    end
    object Label12: TLabel
      Left = 566
      Top = 78
      Width = 60
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580' :'
      ExplicitLeft = 472
    end
    object Label13: TLabel
      Left = 381
      Top = 78
      Width = 59
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580' :'
      ExplicitLeft = 287
    end
    object Label14: TLabel
      Left = 2
      Top = 58
      Width = 49
      Height = 15
      Caption = #1583#1585#1576' '#1582#1585#1608#1580
      Enabled = False
      Visible = False
    end
    object Label1: TLabel
      Left = 368
      Top = 0
      Width = 18
      Height = 15
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Caption = #1601#1610#1604#1578#1585
      Enabled = False
      FocusControl = cmbBarCode
      Visible = False
      ExplicitLeft = 274
    end
    object cmbOPerson: TComboBox
      Left = -91
      Top = 72
      Width = 107
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 13
      Visible = False
      OnExit = rdoArivalClick
      OnKeyPress = cmbOPersonKeyPress
    end
    object cmbBarCode: TComboBox
      Left = 446
      Top = 17
      Width = 114
      Height = 23
      Hint = #1588#1605#1575#1585#1607' '#1576#1575#1585#1705#1583' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      ItemHeight = 15
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cmbBarCodeChange
      OnKeyPress = cmbBarCodeKeyPress
    end
    object cmbName: TComboBox
      Left = 75
      Top = 58
      Width = 113
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 7
      Visible = False
      OnEnter = cmbNameEnter
      OnExit = rdoArivalClick
      OnKeyPress = cmbNameKeyPress
    end
    object cmbColor: TComboBox
      Left = 24
      Top = 75
      Width = 114
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 8
      Visible = False
      OnEnter = cmbNameEnter
      OnExit = rdoArivalClick
      OnKeyPress = cmbColorKeyPress
    end
    object cmbCity: TComboBox
      Left = 75
      Top = 32
      Width = 113
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 9
      Visible = False
      OnEnter = cmbNameEnter
      OnExit = rdoArivalClick
      OnKeyPress = cmbCityKeyPress
    end
    object cmbIDoor: TComboBox
      Left = -68
      Top = 46
      Width = 86
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 10
      Visible = False
      OnExit = rdoArivalClick
      OnKeyPress = cmbIDoorKeyPress
    end
    object cmbIPerson: TComboBox
      Left = -97
      Top = 37
      Width = 107
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 11
      Visible = False
      OnExit = rdoArivalClick
      OnKeyPress = cmbIPersonKeyPress
    end
    object cmbODoor: TComboBox
      Left = -79
      Top = 58
      Width = 86
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 12
      Visible = False
      OnExit = rdoArivalClick
      OnKeyPress = cmbODoorKeyPress
    end
    object txtNumber: TEdit
      Left = 254
      Top = 17
      Width = 114
      Height = 23
      Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      MaxLength = 6
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnExit = txtNumberExit
      OnKeyPress = txtNumberKeyPress
    end
    object txtSerial: TEdit
      Left = 99
      Top = 17
      Width = 80
      Height = 23
      Hint = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      MaxLength = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = txtNumberExit
      OnKeyPress = txtSerialKeyPress
    end
    object txtIDate: TEdit
      Left = 446
      Top = 46
      Width = 114
      Height = 23
      Hint = 'Ctrl + Enter : '#1575#1605#1585#1608#1586
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnExit = txtIDateExit
      OnKeyDown = txtIDateKeyDown
      OnKeyPress = txtIDateKeyPress
    end
    object txtITime: TEdit
      Left = 254
      Top = 46
      Width = 114
      Height = 23
      Hint = 'Ctrl + Enter : '#1575#1705#1606#1608#1606
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 6
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnExit = txtITimeExit
      OnKeyDown = txtITimeKeyDown
      OnKeyPress = txtITimeKeyPress
    end
    object txtODate: TEdit
      Left = 446
      Top = 75
      Width = 114
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
    end
    object txtOTime: TEdit
      Left = 254
      Top = 76
      Width = 114
      Height = 23
      Hint = 'Ctrl + Enter : '#1575#1705#1606#1608#1606
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 6
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnExit = txtOTimeExit
      OnKeyDown = txtOTimeKeyDown
      OnKeyPress = txtOTimeKeyPress
    end
    object cmdCancelFilter: TBitBtn
      Left = 68
      Top = 17
      Width = 25
      Height = 23
      Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
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
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 292
    Width = 631
    Height = 19
    Constraints.MinHeight = 19
    Constraints.MinWidth = 552
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 
          #1575#1586' '#1591#1585#1610#1602' '#1575#1610#1606' '#1601#1585#1605' '#1605#1610#1578#1608#1575#1606#1610#1583' '#1585#1705#1608#1585#1583#1607#1575#1610' '#1608#1585#1608#1583' '#1608' '#1610#1575' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575' '#1585#1575' '#1581#1584#1601' ' +
          #1606#1605#1575#1610#1610#1583
        Width = 50
      end>
  end
  object dtaDelete: TDataSource
    DataSet = tblDelete
    Left = 200
    Top = 24
  end
  object tblDelete: TADOTable
    CursorType = ctStatic
    OnCalcFields = tblDeleteCalcFields
    TableName = 'Machines'
    Left = 168
    Top = 24
    object tblDeleteM_BarCode: TStringField
      Alignment = taRightJustify
      DisplayLabel = '  '#1588#1605#1575#1585#1607' '#1576#1575#1585#1603#1583
      DisplayWidth = 10
      FieldName = 'M_BarCode'
      Size = 8
    end
    object tblDeleteM_CarName: TStringField
      DisplayLabel = '    '#1606#1575#1605' '#1582#1608#1583#1585#1608
      DisplayWidth = 10
      FieldName = 'M_CarName'
      Visible = False
      Size = 15
    end
    object tblDeleteM_Color: TStringField
      DisplayLabel = '   '#1585#1606#1711' '#1582#1608#1583#1585#1608
      DisplayWidth = 12
      FieldName = 'M_Color'
      Visible = False
      Size = 15
    end
    object tblDeleteM_Number: TStringField
      DisplayLabel = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      FieldName = 'M_Number'
      Size = 6
    end
    object tblDeleteNumber: TStringField
      Alignment = taCenter
      DisplayLabel = '  '#1588#1605#1575#1585#1607
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'Number'
      Visible = False
      Size = 7
      Calculated = True
    end
    object tblDeleteM_Serial: TStringField
      DisplayLabel = #1587#1585#1610#1575#1604
      FieldName = 'M_Serial'
      Size = 2
    end
    object tblDeleteCitySerial: TStringField
      DisplayLabel = '  '#1588#1607#1585' - '#1587#1585#1610#1575#1604
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'CitySerial'
      Visible = False
      Calculated = True
    end
    object tblDeleteM_IDate: TStringField
      Alignment = taCenter
      DisplayLabel = ' '#1578#1575#1585#1610#1582' '#1608#1585#1608#1583
      DisplayWidth = 9
      FieldName = 'M_IDate'
      Size = 10
    end
    object tblDeleteM_ITime: TStringField
      Alignment = taCenter
      DisplayLabel = ' '#1608#1585#1608#1583
      DisplayWidth = 5
      FieldName = 'M_ITime'
      Size = 5
    end
    object tblDeleteM_ODate: TStringField
      Alignment = taCenter
      DisplayLabel = ' '#1578#1575#1585#1610#1582' '#1582#1585#1608#1580
      DisplayWidth = 9
      FieldName = 'M_ODate'
      Size = 10
    end
    object tblDeleteM_OTime: TStringField
      Alignment = taCenter
      DisplayLabel = ' '#1582#1585#1608#1580
      DisplayWidth = 5
      FieldName = 'M_OTime'
      Size = 5
    end
    object tblDeleteM_CityName: TStringField
      Alignment = taRightJustify
      FieldName = 'M_CityName'
      Visible = False
      Size = 15
    end
    object tblDeleteM_Kind: TSmallintField
      FieldName = 'M_Kind'
      Visible = False
    end
    object tblDeleteM_IDoor: TSmallintField
      FieldName = 'M_IDoor'
      Visible = False
    end
    object tblDeleteM_ODoor: TSmallintField
      FieldName = 'M_ODoor'
      Visible = False
    end
    object tblDeleteM_IPerson: TStringField
      FieldName = 'M_IPerson'
      Visible = False
      Size = 8
    end
    object tblDeleteM_OPerson: TStringField
      FieldName = 'M_OPerson'
      Visible = False
      Size = 8
    end
    object tblDeleteM_Price: TCurrencyField
      FieldName = 'M_Price'
      Visible = False
    end
    object tblDeleteM_PayAble: TCurrencyField
      FieldName = 'M_PayAble'
      Visible = False
    end
    object tblDeleteM_IsPark: TBooleanField
      FieldName = 'M_IsPark'
      Visible = False
    end
    object tblDeleteM_Karshenasi: TBooleanField
      FieldName = 'M_Karshenasi'
      Visible = False
    end
    object tblDeleteM_Gholnameh: TBooleanField
      FieldName = 'M_Gholnameh'
      Visible = False
    end
    object tblDeleteM_ExitValid: TBooleanField
      FieldName = 'M_ExitValid'
      Visible = False
    end
    object tblDeleteM_IsDeleted: TBooleanField
      FieldName = 'M_IsDeleted'
      Visible = False
    end
    object tblDeleteM_DUserName: TWideStringField
      FieldName = 'M_DUserName'
      Size = 15
    end
    object tblDeleteM_DDate: TWideStringField
      FieldName = 'M_DDate'
      Size = 10
    end
    object tblDeleteM_DTime: TWideStringField
      FieldName = 'M_DTime'
      Size = 5
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 136
    Top = 24
  end
end
