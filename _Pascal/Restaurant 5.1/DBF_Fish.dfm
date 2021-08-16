object frmPrsCost: TfrmPrsCost
  Left = 240
  Top = 100
  HelpContext = 313
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1610#1580#1575#1583' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610' '#1575#1586' '#1601#1610#1588#1607#1575
  ClientHeight = 400
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
  object lbl4: TLabel
    Left = 256
    Top = 280
    Width = 30
    Height = 15
    Caption = '&'#1606#1575#1605' '#1601#1575#1610#1604
    FocusControl = txtFileName
  end
  object lbl5: TLabel
    Left = 237
    Top = 312
    Width = 49
    Height = 15
    Caption = '&'#1587#1610#1587#1578#1605' '#1601#1608#1606#1578
    FocusControl = cmbFonts
  end
  object lbl3: TLabel
    Left = 191
    Top = 48
    Width = 95
    Height = 15
    Caption = '&'#1601#1610#1604#1583#1607#1575#1610' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
  end
  object txtFromDate: TEdit
    Left = 152
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
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
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtFileName: TEdit
    Left = 8
    Top = 280
    Width = 233
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    Text = 'PrsCost.DBF'
  end
  object cmbFonts: TComboBox
    Left = 8
    Top = 312
    Width = 217
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 3
    Items.Strings = (
      #1603#1583#1662#1610#1580' '#1587#1610#1606#1575' ('#1608#1610#1606#1583#1608#1586')'
      #1603#1583#1662#1610#1580' '#1605#1575#1610#1603#1585#1608#1587#1575#1601#1578' ('#1608#1610#1606#1583#1608#1586')'
      #1601#1608#1606#1578' '#1575#1610#1585#1575#1606' '#1587#1610#1587#1578#1605
      #1601#1608#1606#1578' '#1587#1575#1610#1607' '#1588#1585#1603#1578' '#1587#1610#1606#1575
      #1601#1608#1606#1578' '#1662#1585#1608#1585#1588' '#1583#1575#1583#1607' '#1607#1575)
  end
  object cmdRun: TBitBtn
    Left = 200
    Top = 368
    Width = 91
    Height = 25
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 4
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
    Top = 368
    Width = 91
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 368
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object prgBar: TProgressBar
    Left = 8
    Top = 344
    Width = 281
    Height = 16
    Smooth = True
    Step = 1
    TabOrder = 7
  end
  object grdFields: TXStringGrid
    Left = 8
    Top = 72
    Width = 281
    Height = 201
    FixedCols = 0
    TabOrder = 8
    OnDblClick = grdFieldsDblClick
    FixedLineColor = clBlack
    Columns = <
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taCenter
      end
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taRightJustify
      end
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end>
    MultiLine = False
    ImmediateEditMode = False
    ColWidths = (
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
end
