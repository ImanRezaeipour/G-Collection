object frmReaderInf: TfrmReaderInf
  Left = 160
  Top = 105
  HelpContext = 402
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1588#1582#1589#1575#1578' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 283
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
  object lbl1: TLabel
    Left = 497
    Top = 19
    Width = 41
    Height = 15
    Caption = '&'#1603#1583' '#1583#1587#1578#1711#1575#1607
    FocusControl = txtCode
  end
  object lbl2: TLabel
    Left = 253
    Top = 19
    Width = 42
    Height = 15
    Caption = '&'#1606#1575#1605' '#1583#1587#1578#1711#1575#1607
    FocusControl = txtName
  end
  object lbl4: TLabel
    Left = 497
    Top = 48
    Width = 48
    Height = 15
    Caption = '&'#1606#1608#1593' '#1583#1587#1578#1711#1575#1607
    FocusControl = cmbType
  end
  object Label12: TLabel
    Left = 253
    Top = 48
    Width = 49
    Height = 15
    Caption = #1606#1575#1605' '#1587#1575#1582#1578#1605#1575#1606
  end
  object grpPort: TGroupBox
    Left = 207
    Top = 85
    Width = 241
    Height = 74
    TabOrder = 8
    object lbl3: TLabel
      Left = 138
      Top = 13
      Width = 92
      Height = 15
      Caption = #1587#1585#1610#1575#1604' '#1662#1608#1585#1578' '#1575#1585#1578#1576#1575#1591#1610
    end
    object Label1: TLabel
      Left = 133
      Top = 45
      Width = 97
      Height = 15
      Caption = #1587#1585#1593#1578' '#1575#1606#1578#1602#1575#1604' '#1575#1591#1604#1575#1593#1575#1578
    end
    object cmbPort: TComboBox
      Left = 8
      Top = 13
      Width = 120
      Height = 23
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 0
    end
    object cmbBaud: TComboBox
      Left = 8
      Top = 37
      Width = 120
      Height = 23
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object grpLan: TGroupBox
    Left = 207
    Top = 85
    Width = 241
    Height = 74
    TabOrder = 3
    object lbl6: TLabel
      Left = 7
      Top = 29
      Width = 11
      Height = 15
      Caption = 'IP'
    end
    object Label3: TLabel
      Left = 202
      Top = 29
      Width = 30
      Height = 15
      Caption = #1662#1585#1608#1578#1603#1604
    end
    object cmbProtocol: TComboBox
      Left = 138
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
      Left = 21
      Top = 25
      Width = 111
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object cmdSave: TBitBtn
    Left = 455
    Top = 249
    Width = 93
    Height = 25
    Caption = '&'#1579#1576#1578
    TabOrder = 1
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
    Top = 249
    Width = 93
    Height = 25
    Cancel = True
    Caption = '&'#1575#1606#1589#1585#1575#1601
    ModalResult = 2
    TabOrder = 2
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
  object grpActive: TGroupBox
    Left = 8
    Top = 78
    Width = 194
    Height = 81
    Caption = #1608#1590#1593#1610#1578
    TabOrder = 0
    object rdoActive: TRadioButton
      Left = 134
      Top = 25
      Width = 49
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1601#1593#1575#1604
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoActiveKeyPress
    end
    object rdoNotActive: TRadioButton
      Left = 117
      Top = 48
      Width = 66
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1594#1610#1585' '#1601#1593#1575#1604
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = rdoActiveKeyPress
    end
    object chkModem: TCheckBox
      Left = 23
      Top = 25
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1575#1585#1578#1576#1575#1591' &'#1605#1608#1583#1605#1610
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = chkModemKeyPress
    end
    object chkOnLine: TCheckBox
      Left = 7
      Top = 50
      Width = 97
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftReadingOnly
      Caption = #1575#1585'&'#1578#1576#1575#1591' OnLine '
      ParentBiDiMode = False
      TabOrder = 3
      OnKeyPress = chkOnLineKeyPress
    end
  end
  object rdoRelation: TRadioGroup
    Left = 451
    Top = 78
    Width = 97
    Height = 81
    Caption = #1606#1608#1593' '#1575#1585#1578#1576#1575#1591
    Items.Strings = (
      #1587#1585#1610#1575#1604' '#1662#1608#1585#1578
      #1588#1576#1603#1607)
    TabOrder = 4
    OnClick = rdoRelationClick
  end
  object txtCode: TEdit
    Left = 427
    Top = 16
    Width = 64
    Height = 23
    MaxLength = 3
    TabOrder = 5
    OnKeyPress = txtCodeKeyPress
  end
  object txtName: TEdit
    Left = 8
    Top = 16
    Width = 240
    Height = 23
    MaxLength = 30
    TabOrder = 6
    OnKeyPress = txtNameKeyPress
  end
  object cmbType: TComboBox
    Left = 328
    Top = 45
    Width = 160
    Height = 23
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 7
    OnChange = cmbTypeChange
    OnKeyPress = cmbTypeKeyPress
  end
  object cmbBuilding: TComboBox
    Left = 8
    Top = 45
    Width = 240
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 9
    Items.Strings = (
      #1603#1575#1585#1578' '#1575#1608#1604
      #1578#1593#1583#1575#1583' '#1603#1575#1585#1578' '#1601#1585#1583)
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 165
    Width = 540
    Height = 78
    Caption = #1670#1575#1662#1711#1585
    TabOrder = 10
    object Label2: TLabel
      Left = 14
      Top = 29
      Width = 4
      Height = 15
    end
    object Label4: TLabel
      Left = 403
      Top = 23
      Width = 46
      Height = 15
      Caption = #1606#1608#1593' '#1670#1575#1662#1711#1585
    end
    object Label5: TLabel
      Left = 372
      Top = 56
      Width = 77
      Height = 15
      Caption = #1578#1593#1583#1575#1583' &'#1582#1591#1608#1591' '#1582#1575#1604#1610
      FocusControl = txtLineFeed
    end
    object chkPrintFish: TCheckBox
      Left = 465
      Top = 22
      Width = 65
      Height = 17
      Caption = #1670#1575#1662' &'#1601#1610#1588
      TabOrder = 0
      OnKeyPress = cmbPrintersKeyPress
    end
    object cmbPrinters: TComboBox
      Left = 220
      Top = 19
      Width = 177
      Height = 23
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = cmbPrintersKeyPress
    end
    object txtLineFeed: TEdit
      Left = 317
      Top = 48
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = cmbPrintersKeyPress
    end
    object chkAllFihPrc: TCheckBox
      Left = 44
      Top = 24
      Width = 129
      Height = 17
      Caption = #1670#1575#1662' '#1602#1610#1605#1578' '#1603#1604#1610#1607' '#1601#1610#1588#1607#1575
      TabOrder = 3
      OnKeyPress = cmbPrintersKeyPress
    end
    object chkignorename: TCheckBox
      Left = 3
      Top = 50
      Width = 170
      Height = 17
      Caption = #1581#1584#1601' '#1606#1575#1605' '#1608' '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' '#1575#1586' '#1601#1610#1588
      TabOrder = 4
      OnKeyPress = cmbPrintersKeyPress
    end
  end
  object tblReaders: TADOTable
    TableName = 'Readers'
    Left = 337
  end
end
