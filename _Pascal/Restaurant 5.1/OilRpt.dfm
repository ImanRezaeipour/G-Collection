object frmOilRpt: TfrmOilRpt
  Left = 315
  Top = 95
  HelpContext = 313
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1608#1610#1688#1607' '#1588#1585#1603#1578' '#1606#1601#1578
  ClientHeight = 395
  ClientWidth = 296
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
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 251
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 110
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object lbl3: TLabel
    Left = 256
    Top = 85
    Width = 30
    Height = 15
    Caption = '&'#1606#1575#1605' '#1601#1575#1610#1604
    FocusControl = txtFileName
  end
  object lbl6: TLabel
    Left = 110
    Top = 223
    Width = 40
    Height = 15
    Caption = #1585#1605#1586' &'#1593#1605#1604
  end
  object lbl5: TLabel
    Left = 252
    Top = 223
    Width = 34
    Height = 15
    Caption = #1606#1608#1593' &'#1587#1606#1583
  end
  object lbl8: TLabel
    Left = 108
    Top = 255
    Width = 42
    Height = 15
    Caption = #1585#1605#1586' '#1606#1575'&'#1581#1610#1607
  end
  object lbl9: TLabel
    Left = 243
    Top = 287
    Width = 43
    Height = 15
    Caption = #1585'&'#1605#1586' '#1662'/'#1576
  end
  object lbl10: TLabel
    Left = 96
    Top = 287
    Width = 54
    Height = 15
    Caption = '&'#1579#1575#1576#1578' '#1608' '#1605#1578#1594#1610#1585
  end
  object lbl7: TLabel
    Left = 245
    Top = 255
    Width = 41
    Height = 15
    Caption = #1585#1605#1586' &'#1608#1575#1581#1583
  end
  object lbl4: TLabel
    Left = 235
    Top = 190
    Width = 51
    Height = 15
    Caption = #1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
  end
  object txtFromDate: TEdit
    Left = 152
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 8
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtFileName: TEdit
    Left = 8
    Top = 85
    Width = 233
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    Text = 'Oil.DBF'
    OnKeyPress = txtFileNameKeyPress
  end
  object cmdRun: TBitBtn
    Left = 199
    Top = 365
    Width = 91
    Height = 24
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 14
    OnClick = cmdRunClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
      555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
      05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
      FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
      FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
      FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
      05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
      555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
      9055575757575757775505050505055505557575757575557555}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 103
    Top = 365
    Width = 91
    Height = 24
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 15
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 7
    Top = 365
    Width = 89
    Height = 24
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 16
    Kind = bkClose
  end
  object prgBar: TProgressBar
    Left = 8
    Top = 340
    Width = 281
    Height = 16
    Smooth = True
    Step = 1
    TabOrder = 17
  end
  object txtFld1: TEdit
    Left = 168
    Top = 220
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 6
    OnKeyPress = txtFileNameKeyPress
  end
  object txtFld2: TEdit
    Left = 8
    Top = 220
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 1
    ParentBiDiMode = False
    TabOrder = 7
    OnKeyPress = txtFileNameKeyPress
  end
  object txtFld3: TEdit
    Left = 168
    Top = 252
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 3
    ParentBiDiMode = False
    TabOrder = 8
    OnKeyPress = txtFileNameKeyPress
  end
  object txtFld4: TEdit
    Left = 8
    Top = 252
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 9
    OnKeyPress = txtFileNameKeyPress
  end
  object txtFld7: TEdit
    Left = 168
    Top = 284
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 10
    OnKeyPress = txtFileNameKeyPress
  end
  object txtFld9: TEdit
    Left = 8
    Top = 284
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 1
    ParentBiDiMode = False
    TabOrder = 11
    OnKeyPress = txtFileNameKeyPress
  end
  object cmbJobType: TComboBox
    Left = 8
    Top = 187
    Width = 221
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 5
    OnKeyDown = cmbJobTypeKeyDown
    OnKeyPress = txtFileNameKeyPress
  end
  object chkFreeDBS: TCheckBox
    Left = 144
    Top = 317
    Width = 145
    Height = 17
    Caption = #1581#1584#1601' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1576#1575#1606#1603' '#1602#1576#1604#1610
    TabOrder = 12
    OnKeyPress = txtFileNameKeyPress
  end
  object rdoOutPut: TRadioGroup
    Left = 8
    Top = 38
    Width = 280
    Height = 39
    Caption = #1606#1608#1593' '#1582#1585#1608#1580#1610
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
      #1711#1586#1575#1585#1588)
    TabOrder = 2
    OnClick = rdoOutPutClick
  end
  object chkSign: TCheckBox
    Left = 9
    Top = 317
    Width = 113
    Height = 17
    Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
    TabOrder = 13
    OnKeyPress = txtFileNameKeyPress
  end
  object rdobase: TRadioGroup
    Left = 8
    Top = 114
    Width = 280
    Height = 67
    Caption = #1575#1587#1575#1587' '#1711#1586#1575#1585#1588
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1594#1584#1575' '#1582#1608#1585#1583#1607
      #1585#1586#1585#1608' '#1705#1585#1583#1607' '#1608' '#1594#1584#1575' '#1582#1608#1585#1583#1607
      #1585#1586#1585#1608' '#1705#1585#1583#1607)
    TabOrder = 4
    OnClick = rdoOutPutClick
  end
end
