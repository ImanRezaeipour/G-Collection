object frmDBFMonth: TfrmDBFMonth
  Left = 236
  Top = 185
  HelpContext = 313
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1610#1580#1575#1583' '#1576#1575#1606#1603' '#1605#1575#1607#1575#1606#1607' '#1605#1589#1585#1601' '#1594#1584#1575#1610' '#1662#1585#1587#1606#1604
  ClientHeight = 143
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
    Left = 269
    Top = 8
    Width = 17
    Height = 15
    Caption = '&'#1587#1575#1604
  end
  object lbl2: TLabel
    Left = 154
    Top = 8
    Width = 12
    Height = 15
    Caption = '&'#1605#1575#1607
  end
  object lbl3: TLabel
    Left = 256
    Top = 48
    Width = 30
    Height = 15
    Caption = '&'#1606#1575#1605' '#1601#1575#1610#1604
    FocusControl = txtFileName
  end
  object txtFileName: TEdit
    Left = 8
    Top = 48
    Width = 233
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    Text = 'Month.DBF'
  end
  object cmdRun: TBitBtn
    Left = 200
    Top = 112
    Width = 91
    Height = 25
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 1
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
    Left = 104
    Top = 112
    Width = 91
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 2
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 112
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkClose
  end
  object prgBar: TProgressBar
    Left = 8
    Top = 88
    Width = 281
    Height = 16
    Smooth = True
    Step = 1
    TabOrder = 4
  end
  object spnYear: TSpinEdit
    Left = 184
    Top = 8
    Width = 81
    Height = 24
    MaxValue = 1400
    MinValue = 1379
    TabOrder = 5
    Value = 1379
  end
  object cmbMonth: TComboBox
    Left = 8
    Top = 8
    Width = 137
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 6
  end
end
