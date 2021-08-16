object frmReaders: TfrmReaders
  Left = 193
  Top = 87
  HelpContext = 60
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1587#1575#1593#1578#1607#1575#1610' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576
  ClientHeight = 453
  ClientWidth = 634
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
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpList: TGroupBox
    Left = 0
    Top = 0
    Width = 634
    Height = 289
    Align = alTop
    TabOrder = 0
    object dbgReaders: TDBGrid
      Left = 8
      Top = 11
      Width = 616
      Height = 236
      Hint = 'Doublle Click = '#1578#1594#1610#1610#1585' '#1608#1590#1593#1610#1578
      DataSource = dtaReaders
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
      OnDblClick = dbgReadersDblClick
      OnKeyDown = dbgReadersKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'R_Code'
          Title.Alignment = taCenter
          Title.Caption = #1603#1583' '#1583#1587#1578#1711#1575#1607
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'R_Name'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Station'
          Title.Caption = #1575#1610#1587#1578#1711#1575#1607' '#1705#1606#1578#1585#1604
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Type'
          Title.Alignment = taCenter
          Title.Caption = #1606#1608#1593' '#1583#1587#1578#1711#1575#1607
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Active'
          Title.Caption = #1608#1590#1593#1610#1578
          Width = 49
          Visible = True
        end>
    end
    object cmdNew: TBitBtn
      Left = 530
      Top = 256
      Width = 97
      Height = 25
      Caption = #1583#1587#1578#1711#1575#1607' &'#1580#1583#1610#1583
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
    object cmdEdit: TBitBtn
      Left = 426
      Top = 256
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1583#1587#1578#1711#1575#1607
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
    object cmdDelete: TBitBtn
      Left = 322
      Top = 256
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601' '#1583#1587#1578#1711#1575#1607
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
      Left = 112
      Top = 256
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 256
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
    object BitBtn1: TBitBtn
      Left = 218
      Top = 256
      Width = 97
      Height = 25
      Caption = '&'#1578#1606#1592#1610#1605#1575#1578' '#1583#1608#1585#1576#1610#1606
      TabOrder = 6
      Visible = False
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        033333FFFF77777773F330000077777770333777773FFFFFF733077777000000
        03337F3F3F777777733F0797A770003333007F737337773F3377077777778803
        30807F333333337FF73707888887880007707F3FFFF333777F37070000878807
        07807F777733337F7F3707888887880808807F333333337F7F37077777778800
        08807F333FFF337773F7088800088803308073FF777FFF733737300008000033
        33003777737777333377333080333333333333F7373333333333300803333333
        33333773733333333333088033333333333373F7F33333333333308033333333
        3333373733333333333333033333333333333373333333333333}
      NumGlyphs = 2
    end
  end
  object grpInf: TGroupBox
    Left = 0
    Top = 289
    Width = 634
    Height = 163
    Align = alTop
    TabOrder = 1
    DesignSize = (
      634
      163)
    object lbl5: TLabel
      Left = 200
      Top = 134
      Width = 58
      Height = 15
      Caption = #1575#1610#1587#1578#1711#1575#1607' '#1705#1606#1578#1585#1604
      FocusControl = cmbStation
      Visible = False
    end
    object lbl1: TLabel
      Left = 575
      Top = 19
      Width = 49
      Height = 15
      Caption = #1603#1583' '#1583#1587#1578#1711#1575#1607' :'
      FocusControl = txtCode
    end
    object lbl2: TLabel
      Left = 267
      Top = 19
      Width = 50
      Height = 15
      Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' :'
      FocusControl = txtName
    end
    object lbl4: TLabel
      Left = 570
      Top = 48
      Width = 54
      Height = 15
      Caption = #1606#1608#1593' '#1587#1575#1593#1578' :'
      FocusControl = cmbType
    end
    object Label3: TLabel
      Left = 255
      Top = 48
      Width = 62
      Height = 15
      Caption = #1605#1581#1604' '#1575#1587#1578#1602#1585#1575#1585' :'
      FocusControl = txtName
    end
    object cmbStation: TComboBox
      Left = -13
      Top = 130
      Width = 205
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 9
      Visible = False
      OnKeyPress = cmbStationKeyPress
    end
    object grpLan: TGroupBox
      Left = 217
      Top = 81
      Width = 299
      Height = 73
      TabOrder = 10
      object lbl6: TLabel
        Left = 39
        Top = 29
        Width = 11
        Height = 15
        Caption = 'IP'
      end
      object Label2: TLabel
        Left = 232
        Top = 28
        Width = 30
        Height = 15
        Caption = #1662#1585#1608#1578#1603#1604
      end
      object cmbProtocol: TComboBox
        Left = 170
        Top = 25
        Width = 57
        Height = 23
        BiDiMode = bdLeftToRight
        ItemHeight = 15
        ItemIndex = 0
        ParentBiDiMode = False
        TabOrder = 0
        Text = 'TCP'
        Items.Strings = (
          'TCP'
          'UDP')
      end
      object txtIP: TEdit
        Left = 54
        Top = 25
        Width = 111
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
      end
    end
    object grpPort: TGroupBox
      Left = 217
      Top = 81
      Width = 299
      Height = 73
      TabOrder = 5
      object lbl3: TLabel
        Left = 170
        Top = 16
        Width = 92
        Height = 15
        Caption = #1587#1585#1610#1575#1604' '#1662#1608#1585#1578' '#1575#1585#1578#1576#1575#1591#1610
      end
      object Label1: TLabel
        Left = 165
        Top = 48
        Width = 97
        Height = 15
        Caption = #1587#1585#1593#1578' '#1575#1606#1578#1602#1575#1604' '#1575#1591#1604#1575#1593#1575#1578
      end
      object cmbPort: TComboBox
        Left = 40
        Top = 16
        Width = 120
        Height = 23
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemHeight = 15
        ParentBiDiMode = False
        TabOrder = 0
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8')
      end
      object cmbBaud: TComboBox
        Left = 40
        Top = 40
        Width = 120
        Height = 23
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemHeight = 15
        ItemIndex = 4
        ParentBiDiMode = False
        TabOrder = 1
        Text = '38400'
        Items.Strings = (
          '2400'
          '4800'
          '9600'
          '129200'
          '38400')
      end
    end
    object cmdSave: TBitBtn
      Left = 8
      Top = 99
      Width = 97
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 7
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
    object cmdCancel: TBitBtn
      Left = 8
      Top = 128
      Width = 97
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 8
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
    object txtCode: TEdit
      Left = 323
      Top = 16
      Width = 241
      Height = 23
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object txtName: TEdit
      Left = 8
      Top = 16
      Width = 241
      Height = 23
      MaxLength = 30
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object grpStat: TGroupBox
      Left = 120
      Top = 73
      Width = 81
      Height = 81
      Caption = #1608#1590#1593#1610#1578
      TabOrder = 6
      object rdoActive: TRadioButton
        Left = 24
        Top = 24
        Width = 48
        Height = 17
        Caption = '&'#1601#1593#1575#1604
        Checked = True
        TabOrder = 0
        TabStop = True
        OnKeyPress = rdoActiveKeyPress
      end
      object rdoNotActive: TRadioButton
        Left = 8
        Top = 56
        Width = 65
        Height = 17
        Caption = '&'#1594#1610#1585' '#1601#1593#1575#1604
        TabOrder = 1
        OnKeyPress = rdoActiveKeyPress
      end
    end
    object chkModem: TCheckBox
      Left = 55
      Top = 77
      Width = 49
      Height = 17
      Caption = 'RTS'
      TabOrder = 11
      Visible = False
      OnKeyPress = chkModemKeyPress
    end
    object cmbType: TComboBox
      Left = 323
      Top = 45
      Width = 241
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 2
      Text = #1705#1606#1578#1585#1604' '#1662#1575#1585#1705#1610#1606#1711' PCT2000'
      OnKeyPress = cmbTypeKeyPress
      Items.Strings = (
        #1705#1606#1578#1585#1604' '#1662#1575#1585#1705#1610#1606#1711' PCT2000'
        #1587#1575#1593#1578' CLK6000')
    end
    object rdoRelation: TRadioGroup
      Left = 523
      Top = 73
      Width = 97
      Height = 81
      Caption = #1606#1608#1593' '#1575#1585#1578#1576#1575#1591
      ItemIndex = 0
      Items.Strings = (
        #1587#1585#1610#1575#1604' '#1662#1608#1585#1578
        #1588#1576#1603#1607)
      TabOrder = 4
      OnClick = rdoRelationClick
    end
    object cmbDepartment: TComboBox
      Left = 8
      Top = 45
      Width = 241
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 3
      OnChange = cmbDepartmentChange
    end
    object cmbDepartmentCode: TComboBox
      Left = 40
      Top = 48
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
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
  object tblReaders: TADOTable
    CursorType = ctStatic
    OnCalcFields = tblReadersCalcFields
    TableName = 'READERS'
    Left = 240
    Top = 72
    object tblReadersR_Code: TSmallintField
      Alignment = taCenter
      DisplayLabel = '  '#1603#1583' '#1583#1587#1578#1711#1575#1607
      FieldName = 'R_Code'
    end
    object tblReadersR_Name: TStringField
      DisplayLabel = '                    '#1606#1575#1605' '#1583#1587#1578#1711#1575#1607
      DisplayWidth = 30
      FieldName = 'R_Name'
    end
    object tblReadersType: TStringField
      DisplayLabel = '      '#1606#1608#1593' '#1583#1587#1578#1711#1575#1607
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'Type'
      Size = 25
      Calculated = True
    end
    object tblReadersActive: TStringField
      DisplayLabel = '     '#1608#1590#1593#1610#1578
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'Active'
      Size = 10
      Calculated = True
    end
    object tblReadersR_Port: TSmallintField
      FieldName = 'R_Port'
      Visible = False
    end
    object tblReadersR_BaudNo: TSmallintField
      FieldName = 'R_BaudNo'
      Visible = False
    end
    object tblReadersR_Active: TStringField
      FieldName = 'R_Active'
      Size = 1
    end
    object tblReadersR_IP: TStringField
      FieldName = 'R_IP'
      Size = 15
    end
    object tblReadersR_TCP: TBooleanField
      FieldName = 'R_TCP'
    end
    object tblReadersR_IsCOM: TBooleanField
      FieldName = 'R_IsCOM'
    end
    object tblReadersR_Type: TSmallintField
      FieldName = 'R_Type'
    end
    object tblReadersR_Modem: TBooleanField
      FieldName = 'R_Modem'
    end
    object tblReadersR_Depart: TIntegerField
      FieldName = 'R_Depart'
    end
  end
  object dtaReaders: TDataSource
    DataSet = tblReaders
    Left = 304
    Top = 72
  end
end
