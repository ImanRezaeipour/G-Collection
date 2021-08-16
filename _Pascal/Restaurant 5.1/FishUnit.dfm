object frmFishUnit: TfrmFishUnit
  Left = 74
  Top = 70
  HelpContext = 207
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1607#1610#1607' '#1601#1610#1588' '#1594#1584#1575#1610' '#1608#1575#1581#1583#1607#1575#1610' '#1578#1575#1576#1593#1607
  ClientHeight = 329
  ClientWidth = 536
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
  OnActivate = FormActivate
  OnKeyPress = cmbKhadamatKeyPress
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 486
    Top = 40
    Width = 43
    Height = 15
    Caption = '&'#1608#1575#1581#1583' '#1578#1575#1576#1593#1607
  end
  object Label2: TLabel
    Left = 484
    Top = 8
    Width = 22
    Height = 15
    Caption = #1578#1575#1585#1610#1582
  end
  object Label3: TLabel
    Left = 250
    Top = 8
    Width = 21
    Height = 15
    Caption = #1586#1605#1575#1606
  end
  object Label4: TLabel
    Left = 68
    Top = 72
    Width = 28
    Height = 15
    Caption = '&'#1582#1583#1605#1575#1578
    FocusControl = cmbKhadamat
  end
  object Label5: TLabel
    Left = 63
    Top = 128
    Width = 50
    Height = 15
    Caption = '&'#1602#1610#1605#1578' '#1711#1584#1575#1585#1610
    FocusControl = cmbPrcType
  end
  object grdFood: TStringGrid
    Left = 168
    Top = 78
    Width = 304
    Height = 219
    ColCount = 2
    DefaultRowHeight = 23
    FixedCols = 0
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 13
    OnKeyPress = grdFoodKeyPress
  end
  object cmd1: TButton
    Left = 473
    Top = 104
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &1'
    TabOrder = 3
    OnClick = cmd1Click
  end
  object cmd2: TButton
    Left = 473
    Top = 128
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &2'
    TabOrder = 4
    OnClick = cmd2Click
  end
  object cmd3: TButton
    Left = 473
    Top = 152
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &3'
    TabOrder = 5
    OnClick = cmd3Click
  end
  object cmd4: TButton
    Left = 473
    Top = 176
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &4'
    TabOrder = 6
    OnClick = cmd4Click
  end
  object cmd5: TButton
    Left = 473
    Top = 200
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &5'
    TabOrder = 7
    OnClick = cmd5Click
  end
  object cmd6: TButton
    Left = 473
    Top = 224
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &6'
    TabOrder = 8
    OnClick = cmd6Click
  end
  object cmd7: TButton
    Left = 473
    Top = 248
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &7'
    TabOrder = 9
    OnClick = cmd7Click
  end
  object cmd8: TButton
    Left = 473
    Top = 272
    Width = 56
    Height = 25
    Caption = #1603#1604#1610#1583' &8'
    TabOrder = 10
    OnClick = cmd8Click
  end
  object cmd9: TButton
    Left = 344
    Top = 296
    Width = 185
    Height = 25
    Caption = #1603#1604#1610#1583' &9'
    TabOrder = 11
    OnClick = cmd9Click
  end
  object cmd0: TButton
    Left = 168
    Top = 296
    Width = 177
    Height = 25
    Caption = #1603#1604#1610#1583' &0'
    TabOrder = 12
    OnClick = cmd0Click
  end
  object cmdSave: TBitBtn
    Left = 8
    Top = 232
    Width = 145
    Height = 25
    Caption = '&'#1579#1576#1578
    TabOrder = 17
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
  object cmdHelp: TBitBtn
    Left = 8
    Top = 264
    Width = 145
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 18
    Kind = bkHelp
  end
  object cmdCancel: TBitBtn
    Left = 8
    Top = 296
    Width = 145
    Height = 25
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 19
    Kind = bkCancel
  end
  object txtDate: TEdit
    Left = 376
    Top = 8
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtDateExit
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TEdit
    Left = 168
    Top = 8
    Width = 73
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtTimeExit
    OnKeyPress = txtTimeKeyPress
  end
  object cmbUnits: TComboBox
    Left = 168
    Top = 40
    Width = 305
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnKeyPress = cmbUnitsKeyPress
  end
  object cmbKhadamat: TComboBox
    Left = 8
    Top = 88
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 14
    OnKeyPress = cmbKhadamatKeyPress
  end
  object cmbPrcType: TComboBox
    Left = 8
    Top = 144
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 15
    Items.Strings = (
      #1662#1600#1600#1600#1585#1587#1606#1604#1610
      #1662#1610#1605#1575#1606#1603#1575#1585#1610)
  end
  object chkIsPrice: TCheckBox
    Left = 80
    Top = 184
    Width = 73
    Height = 17
    Caption = #1576#1575' '#1575#1582'&'#1584' '#1608#1580#1607
    TabOrder = 16
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 16
  end
end
