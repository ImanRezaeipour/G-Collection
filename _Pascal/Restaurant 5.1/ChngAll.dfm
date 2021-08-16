object frmAllChange: TfrmAllChange
  Left = 437
  Top = 206
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1589#1604#1575#1581#1575#1578' '#1603#1604#1610' '#1662#1585#1587#1606#1604
  ClientHeight = 336
  ClientWidth = 391
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
    Left = 325
    Top = 49
    Width = 54
    Height = 15
    Caption = #1662'&'#1584#1610#1585#1588' '#1603#1575#1585#1578
    FocusControl = cmbValid
  end
  object lbl2: TLabel
    Left = 311
    Top = 81
    Width = 68
    Height = 15
    Caption = #1578'&'#1587#1578' '#1603#1606#1578#1585#1604' '#1578#1585#1583#1583
    FocusControl = cmbClock
  end
  object lbl3: TLabel
    Left = 343
    Top = 113
    Width = 36
    Height = 15
    Caption = #1575#1582#1584' '#1608'&'#1580#1607
    FocusControl = cmbPrice
  end
  object lbl4: TLabel
    Left = 325
    Top = 145
    Width = 54
    Height = 15
    Caption = '&'#1594#1584#1575#1610' '#1575#1590#1575#1601#1610
    FocusControl = cmbFood
  end
  object lbl5: TLabel
    Left = 321
    Top = 177
    Width = 58
    Height = 15
    Caption = #1662#1585#1587#1606#1604' '#1585'&'#1688#1610#1605#1610
    FocusControl = cmbRejim
  end
  object lbl6: TLabel
    Left = 324
    Top = 209
    Width = 55
    Height = 15
    Caption = #1587#1585#1608' &'#1589#1576#1581#1575#1606#1607
    FocusControl = cmbSobh
  end
  object lbl7: TLabel
    Left = 335
    Top = 241
    Width = 44
    Height = 15
    Caption = #1587#1585#1608' &'#1606#1575#1607#1575#1585
    FocusControl = cmbNahar
  end
  object lbl8: TLabel
    Left = 342
    Top = 273
    Width = 37
    Height = 15
    Caption = #1587#1585#1608' &'#1588#1575#1605
    FocusControl = cmbSham
  end
  object Label1: TLabel
    Left = 331
    Top = 307
    Width = 47
    Height = 15
    Caption = '&'#1711#1585#1608#1607' '#1603#1575#1585#1610
    FocusControl = cmbGroups
  end
  object Label2: TLabel
    Left = 46
    Top = 3
    Width = 318
    Height = 30
    Caption = 
      #1578#1608#1580#1607' :  '#1576#1575' '#1586#1583#1606' '#1583#1705#1605#1607' '#1579#1576#1578' '#1578#1594#1610#1610#1585#1575#1578' '#1605#1588#1582#1589#1575#1578' '#1705#1604#1610#1607' '#1662#1585#1587#1606#1604' '#1591#1576#1602' '#1578#1606#1592#1610#1605#1575#1578' '#1586#1610 +
      #1585' '#1578#1594#1610#1610#1585' '#1605#1610' '#1610#1575#1576#1583
    FocusControl = cmbValid
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 35
    Width = 378
    Height = 7
    Shape = bsTopLine
  end
  object cmbValid: TComboBox
    Left = 124
    Top = 45
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnKeyPress = cmbValidKeyPress
  end
  object cmbClock: TComboBox
    Left = 124
    Top = 77
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 1
    OnKeyPress = cmbValidKeyPress
  end
  object cmbPrice: TComboBox
    Left = 124
    Top = 109
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 2
    OnKeyPress = cmbValidKeyPress
  end
  object cmbFood: TComboBox
    Left = 124
    Top = 141
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 3
    OnKeyPress = cmbValidKeyPress
  end
  object cmbRejim: TComboBox
    Left = 124
    Top = 173
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 4
    OnKeyPress = cmbValidKeyPress
  end
  object cmbSobh: TComboBox
    Left = 124
    Top = 205
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 5
    OnKeyPress = cmbValidKeyPress
  end
  object cmbNahar: TComboBox
    Left = 124
    Top = 237
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 6
    OnKeyPress = cmbValidKeyPress
  end
  object cmbSham: TComboBox
    Left = 124
    Top = 269
    Width = 173
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 7
    OnKeyPress = cmbValidKeyPress
  end
  object cmdChange: TBitBtn
    Left = 8
    Top = 45
    Width = 97
    Height = 25
    Caption = '&'#1579#1576#1578' '#1578#1594#1610#1610#1585#1575#1578
    TabOrder = 9
    OnClick = cmdChangeClick
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
  object cmdHelp: TBitBtn
    Left = 8
    Top = 257
    Width = 97
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 10
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 297
    Width = 97
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 11
    Kind = bkClose
  end
  object cmbGroups: TComboBox
    Left = 125
    Top = 300
    Width = 172
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 8
  end
end
