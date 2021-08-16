object frmPrsnScp: TfrmPrsnScp
  Left = 201
  Top = 236
  AlphaBlend = True
  AlphaBlendValue = 0
  BiDiMode = bdRightToLeft
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'frmPrsnScp'
  ClientHeight = 298
  ClientWidth = 552
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
  Visible = True
  OnCreate = FormCreate
  DesignSize = (
    552
    298)
  PixelsPerInch = 96
  TextHeight = 15
  object grpPrintType: TGroupBox
    Left = 6
    Top = 253
    Width = 542
    Height = 42
    Anchors = [akBottom]
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 5
    object rdoScreen: TRadioButton
      Left = 347
      Top = 16
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 112
      Top = 16
      Width = 40
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1670#1575#1662#1711#1585
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object grpDateTime: TGroupBox
    Left = 6
    Top = 129
    Width = 542
    Height = 112
    Caption = #1578#1593#1610#1610#1606' '#1605#1581#1583#1608#1583#1607' '#1586#1605#1575#1606#1610
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
    object lbl7: TLabel
      Left = 199
      Top = 44
      Width = 40
      Height = 15
      Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582' :'
      FocusControl = txtToDate
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 456
      Top = 44
      Width = 43
      Height = 15
      Caption = #1575#1586' '#1578#1575'&'#1585#1610#1582' :'
      FocusControl = txtFromDate
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 455
      Top = 68
      Width = 47
      Height = 15
      Caption = #1575#1586' '#1587#1575#1593#1578' :'
      FocusControl = txtFromDate
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 199
      Top = 68
      Width = 44
      Height = 15
      Caption = #1578#1575' '#1587#1575#1593#1578' :'
      FocusControl = txtToDate
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object txtToDate: TEdit
      Left = 50
      Top = 41
      Width = 142
      Height = 23
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      MaxLength = 10
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 1
      OnExit = txtToDateExit
      OnKeyPress = txtToDateKeyPress
    end
    object txtFromDate: TEdit
      Left = 307
      Top = 41
      Width = 142
      Height = 23
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      MaxLength = 10
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      OnExit = txtFromDateExit
      OnKeyPress = txtFromDateKeyPress
    end
    object txtSTime: TEdit
      Left = 363
      Top = 65
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      MaxLength = 6
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
      OnExit = txtSTimeExit
      OnKeyPress = txtSTimeKeyPress
    end
    object txtETime: TEdit
      Left = 107
      Top = 65
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      MaxLength = 6
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 3
      OnExit = txtETimeExit
      OnKeyPress = txtETimeKeyPress
    end
    object rdoStartdate: TRadioButton
      Left = 347
      Top = 18
      Width = 104
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1602#1585#1575#1585#1583#1575#1583
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object rdoEndDate: TRadioButton
      Left = 222
      Top = 16
      Width = 108
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606'  '#1602#1585#1575#1585#1583#1575#1583
      Checked = True
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 5
      TabStop = True
      Visible = False
    end
  end
  object rdoOneSelect: TRadioButton
    Left = 407
    Top = 8
    Width = 143
    Height = 17
    Caption = #1575#1606#1578#1582#1575#1576' '#1610#1705' '#1606#1601#1585
    Checked = True
    Font.Charset = ARABIC_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = True
    OnClick = rdoOneSelectClick
  end
  object grpOne: TGroupBox
    Left = 205
    Top = 24
    Width = 342
    Height = 104
    TabOrder = 1
    OnClick = cmbBarCodeChange
    object lbl3: TLabel
      Left = 261
      Top = 70
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606'&'#1608#1575#1583#1711#1610
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 261
      Top = 43
      Width = 10
      Height = 15
      Caption = '&'#1606#1575#1605
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 261
      Top = 17
      Width = 29
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object cmbName: TComboBox
      Left = 17
      Top = 40
      Width = 235
      Height = 23
      AutoComplete = False
      BiDiMode = bdRightToLeft
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ItemHeight = 15
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      OnClick = cmbNameClick
      OnExit = cmbNameClick
      OnKeyPress = cmbNameKeyPress
    end
    object cmbFamily: TComboBox
      Left = 17
      Top = 67
      Width = 235
      Height = 23
      AutoComplete = False
      BiDiMode = bdRightToLeft
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ItemHeight = 15
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 1
      OnClick = cmbFamilyClick
      OnExit = cmbFamilyClick
      OnKeyPress = cmbFamilyKeyPress
    end
    object cmbBarCode: TComboBox
      Left = 17
      Top = 14
      Width = 235
      Height = 23
      BiDiMode = bdRightToLeft
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ItemHeight = 15
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
      OnChange = cmbBarCodeChange
      OnClick = cmbBarCodeClick
      OnExit = cmbBarCodeClick
      OnKeyPress = cmbBarCodeKeyPress
    end
  end
  object cmdSelect: TBitBtn
    Left = 49
    Top = 31
    Width = 112
    Height = 25
    Caption = '&'#1575#1606#1578#1582#1575#1576' '
    TabOrder = 3
    OnClick = cmdSelectClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
  end
  object rdoVariousSelect: TRadioButton
    Left = 38
    Top = 8
    Width = 143
    Height = 17
    Caption = #1575#1606#1578#1582#1575#1576' '#1575#1601#1585#1575#1583' '#1605#1582#1578#1604#1601
    Font.Charset = ARABIC_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = rdoVariousSelectClick
  end
  object DosMove1: TDosMove
    Active = True
    Left = 344
  end
end
