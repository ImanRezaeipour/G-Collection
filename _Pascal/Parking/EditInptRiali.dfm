object frmEditInputRiali: TfrmEditInputRiali
  Left = 11
  Top = 21
  HelpContext = 303
  BiDiMode = bdRightToLeft
  Caption = #1575#1589#1604#1575#1581' '#1585#1610#1575#1604#1610' '#1585#1603#1608#1585#1583' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1582#1585#1608#1580#1610
  ClientHeight = 311
  ClientWidth = 706
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
    Width = 706
    Height = 187
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 758
    DesignSize = (
      706
      187)
    object GroupBox1: TGroupBox
      Left = 7
      Top = 8
      Width = 111
      Height = 57
      TabOrder = 0
      Visible = False
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
    object cmdEdit: TBitBtn
      Left = 7
      Top = 71
      Width = 111
      Height = 22
      Hint = #1575#1589#1604#1575#1581' '#1585#1705#1608#1585#1583' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1607
      Caption = #1575'&'#1589#1604#1575#1581' '#1585#1603#1608#1585#1583
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
      Width = 576
      Height = 167
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
      ExplicitWidth = 628
      object dbgMachines: TDBGrid
        Left = 0
        Top = 0
        Width = 576
        Height = 167
        Hint = #1575#1591#1604#1575#1593#1575#1578' '#1605#1585#1576#1608#1591' '#1576#1607' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575' '#1608' '#1605#1576#1575#1604#1594' '#1605#1585#1576#1608#1591' '#1576#1607' '#1570#1606#1607#1575
        Align = alClient
        DataSource = dtaMachines
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
            Width = 79
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'M_Number'
            Title.Alignment = taCenter
            Title.Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
            Width = 74
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'M_Serial'
            Title.Alignment = taCenter
            Title.Caption = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_ODate'
            Title.Alignment = taCenter
            Title.Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_OTime'
            Title.Alignment = taCenter
            Title.Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_BPayAble'
            Title.Alignment = taCenter
            Title.Caption = #1605#1576#1604#1594' '#1575#1608#1604#1610#1607
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'M_PayAble'
            Title.Alignment = taCenter
            Title.Caption = #1605#1576#1604#1594' '#1602#1575#1576#1604' '#1662#1585#1583#1575#1582#1578
            Width = 82
            Visible = True
          end>
      end
    end
  end
  object grpSearch: TGroupBox
    Left = 0
    Top = 187
    Width = 706
    Height = 105
    Align = alBottom
    Caption = #1601#1610#1604#1578#1585
    TabOrder = 1
    ExplicitWidth = 758
    DesignSize = (
      706
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
      Left = 643
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
      Left = 449
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
      Left = 260
      Top = 20
      Width = 63
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1588#1605#1575#1585#1607' '#1587#1585#1610#1575#1604' :'
      ExplicitLeft = 91
    end
    object Label8: TLabel
      Left = 645
      Top = 49
      Width = 56
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583' :'
      ExplicitLeft = 476
    end
    object Label9: TLabel
      Left = 460
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
      Left = 641
      Top = 78
      Width = 60
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580' :'
      ExplicitLeft = 472
    end
    object Label13: TLabel
      Left = 456
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
      Left = 443
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
      Left = 521
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
      ExplicitLeft = 573
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
      Left = 329
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
      Left = 174
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
      ExplicitLeft = 226
    end
    object txtIDate: TEdit
      Left = 521
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
      ExplicitLeft = 573
    end
    object txtITime: TEdit
      Left = 329
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
      ExplicitLeft = 381
    end
    object txtODate: TEdit
      Left = 521
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
      ExplicitLeft = 573
    end
    object txtOTime: TEdit
      Left = 329
      Top = 75
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
      Left = 143
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
      ExplicitLeft = 195
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 292
    Width = 706
    Height = 19
    Constraints.MinHeight = 19
    Constraints.MinWidth = 552
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 
          #1575#1586' '#1591#1585#1610#1602' '#1575#1610#1606' '#1601#1585#1605' '#1605#1610#1578#1608#1575#1606#1610#1583' '#1605#1602#1583#1575#1585' '#1585#1610#1575#1604#1610' '#1605#1576#1604#1594' '#1602#1575#1576#1604' '#1662#1585#1583#1575#1582#1578' '#1585#1705#1608#1585#1583' '#1605#1608#1585#1583 +
          ' '#1606#1592#1585' '#1585#1575' '#1578#1589#1581#1610#1581' '#1606#1605#1575#1610#1610#1583
        Width = 50
      end>
    ExplicitWidth = 758
  end
  object grpEdit: TGroupBox
    Left = 42
    Top = 93
    Width = 623
    Height = 105
    Caption = #1575#1589#1604#1575#1581' '#1585#1705#1608#1585#1583' ('#1605#1576#1604#1594' '#1602#1575#1576#1604' '#1662#1585#1583#1575#1582#1578')'
    TabOrder = 3
    Visible = False
    DesignSize = (
      623
      105)
    object Label16: TLabel
      Left = 566
      Top = 34
      Width = 49
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1605#1576#1604#1594' '#1575#1608#1604#1610#1607' :'
    end
    object Label17: TLabel
      Left = 566
      Top = 63
      Width = 49
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1605#1576#1604#1594' '#1580#1583#1610#1583' :'
    end
    object Label18: TLabel
      Left = 332
      Top = 34
      Width = 104
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1605#1576#1604#1594' '#1602#1575#1576#1604' '#1662#1585#1583#1575#1582#1578' '#1601#1593#1604#1610' :'
    end
    object cmdCancel: TBitBtn
      Left = 212
      Top = 60
      Width = 106
      Height = 22
      Hint = #1575#1606#1589#1585#1575#1601
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1575#1606'&'#1589#1585#1575#1601
      ParentShowHint = False
      ShowHint = True
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
      Left = 330
      Top = 60
      Width = 106
      Height = 22
      Hint = #1579#1576#1578' '#1578#1594#1610#1610#1585#1575#1578
      Anchors = [akTop, akRight]
      Caption = '&'#1579#1576#1578
      ParentShowHint = False
      ShowHint = True
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
    object firstPayAble: TEdit
      Left = 446
      Top = 31
      Width = 114
      Height = 21
      Hint = #1605#1576#1604#1594' '#1575#1608#1604#1610#1607' '#1585#1705#1608#1585#1583' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1607
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object newPayAble: TEdit
      Left = 446
      Top = 60
      Width = 114
      Height = 23
      Hint = #1605#1576#1604#1594' '#1580#1583#1610#1583' '#1585#1575' '#1576#1585#1575#1610' '#1585#1705#1608#1585#1583' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1607' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = newPayAbleKeyPress
    end
    object currentPayAble: TEdit
      Left = 212
      Top = 31
      Width = 114
      Height = 21
      Hint = #1605#1576#1604#1594' '#1575#1608#1604#1610#1607' '#1585#1705#1608#1585#1583' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1607
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 4
    end
  end
  object dtaMachines: TDataSource
    DataSet = tblMachines
    Left = 192
    Top = 64
  end
  object tblMachines: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Parking;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = tblMachinesCalcFields
    TableName = 'Machines'
    Left = 160
    Top = 64
    object tblMachinesM_rdrCode: TSmallintField
      FieldName = 'M_rdrCode'
    end
    object tblMachinesM_BarCode: TWideStringField
      FieldName = 'M_BarCode'
      Size = 8
    end
    object tblMachinesM_CarName: TWideStringField
      FieldName = 'M_CarName'
      Size = 15
    end
    object tblMachinesM_Number: TWideStringField
      FieldName = 'M_Number'
      Size = 6
    end
    object tblMachinesM_CityName: TWideStringField
      FieldName = 'M_CityName'
      Size = 15
    end
    object tblMachinesM_Serial: TWideStringField
      FieldName = 'M_Serial'
      Size = 2
    end
    object tblMachinesM_PlaqueType: TSmallintField
      FieldName = 'M_PlaqueType'
    end
    object tblMachinesM_PlaqueAppliance: TSmallintField
      FieldName = 'M_PlaqueAppliance'
    end
    object tblMachinesM_CitySerial: TIntegerField
      FieldName = 'M_CitySerial'
    end
    object tblMachinesM_Color: TWideStringField
      FieldName = 'M_Color'
      Size = 15
    end
    object tblMachinesM_IDate: TWideStringField
      FieldName = 'M_IDate'
      Size = 10
    end
    object tblMachinesM_ITime: TWideStringField
      FieldName = 'M_ITime'
      Size = 5
    end
    object tblMachinesM_ODate: TWideStringField
      FieldName = 'M_ODate'
      Size = 10
    end
    object tblMachinesM_OTime: TWideStringField
      FieldName = 'M_OTime'
      Size = 5
    end
    object tblMachinesM_Kind: TSmallintField
      FieldName = 'M_Kind'
    end
    object tblMachinesM_IDoor: TSmallintField
      FieldName = 'M_IDoor'
    end
    object tblMachinesM_ODoor: TSmallintField
      FieldName = 'M_ODoor'
    end
    object tblMachinesM_IPerson: TWideStringField
      FieldName = 'M_IPerson'
      Size = 8
    end
    object tblMachinesM_OPerson: TWideStringField
      FieldName = 'M_OPerson'
      Size = 8
    end
    object tblMachinesM_OperatorCode: TWideStringField
      FieldName = 'M_OperatorCode'
      Size = 8
    end
    object tblMachinesM_Price: TBCDField
      FieldName = 'M_Price'
      Precision = 19
    end
    object tblMachinesM_PayAble: TBCDField
      FieldName = 'M_PayAble'
      DisplayFormat = ',###'
      Precision = 19
    end
    object tblMachinesM_IsPark: TBooleanField
      FieldName = 'M_IsPark'
    end
    object tblMachinesM_Karshenasi: TBooleanField
      FieldName = 'M_Karshenasi'
    end
    object tblMachinesM_Gholnameh: TBooleanField
      FieldName = 'M_Gholnameh'
    end
    object tblMachinesM_ExitValid: TBooleanField
      FieldName = 'M_ExitValid'
    end
    object tblMachinesM_IsDeleted: TBooleanField
      FieldName = 'M_IsDeleted'
    end
    object tblMachinesM_BPayAble: TBCDField
      FieldName = 'M_BPayAble'
      DisplayFormat = ',###'
      Precision = 19
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 128
    Top = 64
  end
end
